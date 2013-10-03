package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class ServiceInterfaceDefinitionDelegate extends AbstractTableDelegate {
//    String id
//    String url
//    String protocol
//    String domain
//    String servicetype
    //String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['name','url','protocol','domain','type'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        'serviceinterfacedefinition'
    }

    @Override
    String columns() {
        "id,definition,protocolid,servicetype_domainid,servicetype_servicetypeid"
    }

    @Override
    String values() {
//        if (valueCache == null) {
//            StringBuilder buffer = new StringBuilder()
//            buffer << "'${fields.id}'"
//
//            [getDefinition(),fields.protocol,fields.domain,fields.type].each {
//                buffer << ",'${it}'"
//            }
//            valueCache = buffer.toString()
//        }
//        return valueCache
        return null
    }

    @Override
    void execute(Sql sql) {
        validateFields()
        // Get the wsdl for the service interface
        String wsdl = new URL(fields.url).text

        // Get the next available servicetypeid
        int nextId = getNextId(sql);

//        sql.connection.autoCommit = false
        long loid = writeZipObject(sql, fields.name, wsdl)
//        sql.connection.autoCommit = true
        StringBuilder buffer = new StringBuilder()
        buffer << "'${nextId}'"
        [loid,fields.protocol,fields.domain,fields.type].each {
            buffer << ",'${it}'"
        }

        def stmt = "insert into ${table()} (${columns()}) values (${buffer.toString()})".toString()
        sql.execute(stmt)
//        sql.commit()
//        sql.connection.autoCommit = true
    }
}
