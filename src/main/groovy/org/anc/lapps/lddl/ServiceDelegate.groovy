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
            namesCache = ['id','name','url','protocol','copyright','resource','license','description','allow','control','federate','domain','type'] as HashSet
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

    @Override
    void execute(Sql sql) {
        validateFields()
        println "Fetching WSDL from ${fields.url}"
        String wsdl = new URL("${fields.url}?wsdl").text
        def allowedUse = fields.allowed
        if (allowedUse instanceof String) {
            allowUse(sql, fields.id, allowedUse)
        }
        else {
            allowedUse.each { allowed ->
                allowUse(sql, fields.id, allowed)
            }
        }

        // Save the wsdl as a LargeObject in the database.
//        sql.connection.autoCommit = false
        long zipId = writeZipObject(sql, fields.name, wsdl)
        int size = wsdl.bytes.size()
        long oid = writeLargeObject(sql, wsdl)
//        sql.connection.autoCommit = true
        def now = timestamp()
        StringBuilder buffer = new StringBuilder()
        buffer << "'ExternalService'"
        [GRID_ID, fields.id,now,now,true,true,'ATOMIC',fields.copyright,fields.federate,zipId,size,0,fields.license,false,GRID_USER_ID,fields.resource,fields.description,fields.name,fields.domain,fields.type,false,0,false,true,oid].each {
            buffer << ",'${it}'"
        }
        String stmt = "insert into service (${SERVICE_COLUMNS}) values (${buffer.toString()})".toString()
        sql.execute(stmt)

        def allowedControl = fields.control
        if (allowedControl instanceof String) {
            provision(sql, fields.id, allowedControl)
        }
        else {
            allowedControl.each { allowed ->
                provision(sql, fields.id, allowed)
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
