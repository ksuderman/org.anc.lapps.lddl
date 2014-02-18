package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ServiceMetaAttributeDelegate extends AbstractTableDelegate {
//    String id
//    String name
//    String domain
//    String description
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name', 'type', 'domain','description'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() { 'servicemetaattribute'}

    @Override
    String columns() {
        'attributeid,domainid,createddatetime,updateddatetime,attributename,description'
    }

    @Override
    String values() {
        if (valueCache != null) {
            return valueCache
        }
        def now = timestamp()
        StringBuilder buffer = new StringBuilder()
        buffer << "'${fields.id}'"
        [fields.domain,now, now, fields.name, fields.description].each {
            buffer << ",'${it}'"
        }
        valueCache = buffer.toString()
        return valueCache
    }

//    @Override
//    String[] asSql() {
//        String[] statements = super.asSql()
//        def columns = "servicetype_domainid, servicetype_servicetypeid, metaattributes_attributeid, metaattributes_domainid"
//        StringBuilder buffer = new StringBuilder()
//        buffer << "'${fields.domain}'"
//        [fields.type, fields.id, fields.domain].each {
//            buffer << ", '${it}'"
//        }
//
//        statements += "insert into servicetype_servicemetaattribute (${columns}) values (${buffer.toString()})"
//        return statements
//    }
}
