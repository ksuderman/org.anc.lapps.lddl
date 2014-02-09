package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class ServiceDelegate extends AbstractTableDelegate {

    static final String SERVICE_COLUMNS = 'dtype,gridid,serviceid,createddatetime,updateddatetime,active,approved,containertype,copyrightinfo,federateduseallowed,instance,instancesize,instancetype,licenseinfo,membersonly,owneruserid,resourceid,servicedescription,servicename,servicetypedomainid,servicetypeid,streaming,timeoutmillis,usealternateservice,visible,wsdl'
    static final String ENDPOINT_COLUMNS = 'gridid,protocolid,serviceid,url,createddatetime,updateddatetime,averesponsemillis,enabled,experience'

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name','url', 'protocol','copyright','resource','license','description','allow','control','federate','domain','type'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() { 'service' }

    @Override
    String columns() {
        return null
    }

    @Override
    String values() {
        return null
    }

    // This is NOT (and shoult not be) called by the execute method. This is
    // only used during debugging to print the SQL.
    @Override
    String[] asSql() {
        def stmts = []
        long zipId = 1
        int size = Math.random() * 16 * 1024
        long oid = 5
        def now = timestamp()
        StringBuilder buffer = new StringBuilder()
        buffer << "'ExternalService'"
        [GRID_ID, fields.id,now,now,true,true,'ATOMIC',fields.copyright,fields.federate,zipId,size,0,fields.license,false,GRID_USER_ID,fields.resource,fields.description,fields.name,fields.domain,fields.type,false,0,false,true,oid].each {
            buffer << ",'${it}'"
        }
        stmts << "insert into service (${SERVICE_COLUMNS}) values (${buffer.toString()})".toString()

        def allowedControl = fields.control
        if (allowedControl == null) {
            throw new DelegateException("No values have been provided for the control of the service.")
        }
        if (allowedControl instanceof String) {
            //provision(sql, fields.id, allowedControl)
            stmts << "Provision ${fields.id} controlled by ${allowedControl}"
        }
        else {
            allowedControl.each { allowed ->
                // provision(sql, fields.id, allowed)
                stmts << "Provision ${fields.id} controlled by ${allowedControl}"
            }
        }

        def allowedUse = fields.allow
        if (allowedUse == null) {
            throw new DelegateException("No values have been provided for the allowed use of the service.")
        }
        if (allowedUse instanceof String) {
            //allowUse(sql, fields.id, allowedUse)
            stmts << "Allow use ${fields.id} ${allowedUse}"
        }
        else {
            allowedUse.each { allowed ->
//                allowUse(sql, fields.id, allowed)
                stmts << "Allow use ${fields.id} ${allowed}"
            }
        }

        buffer = new StringBuilder()
        buffer << "'${GRID_ID}'"
        [fields.protocol,fields.id,fields.url,now,now,0,true,0].each {
            buffer << ",'${it}'"
        }
        stmts << "insert into serviceendpoint (${ENDPOINT_COLUMNS}) values (${buffer.toString()})"
        return stmts as String[]
    }

    @Override
    void execute(Sql sql) {
        validateFields()

        // Fetch the WSDL file from the server.
        String wsdl = new URL("${fields.url}?wsdl").text

        // Save the wsdl as a LargeObject in the database.
        long zipId = writeZipObject(sql, fields.name, wsdl)
        int size = wsdl.bytes.size()
        long oid = writeLargeObject(sql, wsdl)

        // Now we have the info needed to update the database.
        def now = timestamp()
        StringBuilder buffer = new StringBuilder()
        buffer << "'ExternalService'"
        [GRID_ID, fields.id,now,now,true,true,'ATOMIC',fields.copyright,fields.federate,zipId,size,0,fields.license,false,GRID_USER_ID,fields.resource,fields.description,fields.name,fields.domain,fields.type,false,0,false,true,oid].each {
            buffer << ",'${it}'"
        }
        String stmt = "insert into service (${SERVICE_COLUMNS}) values (${buffer.toString()})".toString()
        sql.execute(stmt)

        def allowedControl = fields.control
        if (allowedControl == null) {
            throw new DelegateException("No values have been provided for the control of the service.")
        }
        if (allowedControl instanceof String) {
            provision(sql, fields.id, allowedControl)
        }
        else {
            allowedControl.each { allowed ->
                provision(sql, fields.id, allowed)
            }
        }

        def allowedUse = fields.allow
        if (allowedUse == null) {
            throw new DelegateException("No values have been provided for the allowed use of the service.")
        }
        if (allowedUse instanceof String) {
            allowUse(sql, fields.id, allowedUse)
        }
        else {
            allowedUse.each { allowed ->
                allowUse(sql, fields.id, allowed)
            }
        }

        buffer = new StringBuilder()
        buffer << "'${GRID_ID}'"
        [fields.protocol,fields.id,fields.url,now,now,0,true,0].each {
            buffer << ",'${it}'"
        }
        stmt = "insert into serviceendpoint (${ENDPOINT_COLUMNS}) values (${buffer.toString()})"
        sql.execute(stmt.toString())
    }

    void allowUse(Sql sql, String id, String type) {
        //println "Allowed use for ${id} : ${type}"
        def ucType = type.toUpperCase()
        switch (ucType) {
            case 'COMMERCIAL':  // Fall through all of the allowable values.
            case 'NONPROFIT':
            case 'RESEARCH':
                break
            default:
                throw new DelegateException("Invalid use type: ${type}")
                break

        }
        String stmt = "insert into service_alloweduse values ('${GRID_ID}', '${id}', '${ucType}_USE')".toString()
        sql.execute(stmt)
    }

    void provision(Sql sql, String id, String type) {
        String ucType = type.toUpperCase()
        String control
        if (ucType == 'SERVER') {
            control = 'SERVER_CONTROL'
        }
        else if (ucType == 'CLIENT') {
            control = 'CLIENT_CONTROL'
        }
        else {
            throw new DelegateException("Invalid control type: ${type}")
        }
        def stmt = "insert into service_allowedappprovision values ('${GRID_ID}', '${id}', '${control}')"
        sql.execute(stmt.toString())
    }
}
