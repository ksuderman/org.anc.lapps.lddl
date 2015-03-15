package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ServiceTypeDelegate extends AbstractTableDelegate {
//    String domain
//    String id
//    String name
//    String description
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id', 'name', 'domain', 'description', 'attributes'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        'servicetype'
    }

    @Override
    String columns() {
        'domainid,servicetypeid,createddatetime,updateddatetime,description,servicetypename'
    }

    @Override
    String values() {
        if (valueCache == null) {
            def now = timestamp()
            StringBuilder buffer = new StringBuilder()
            buffer << "'${fields.domain}'"
            [fields.id, now, now, fields.description,fields.name].each {
                buffer << ",'${it}'"
            }
            valueCache = buffer.toString()
        }
        return valueCache
    }

    @Override
    String[] asSql() {
        String[] statements = super.asSql()
        def columns = "servicetype_domainid, servicetype_servicetypeid, metaattributes_attributeid, metaattributes_domainid"
        StringBuilder buffer = new StringBuilder()
        fields.attributes.each { att ->
            buffer.setLength(0)
            buffer << "'${fields.domain}'"
            [fields.id, att, fields.domain].each {
                buffer << ", '${it}'"
            }

            statements += "insert into servicetype_servicemetaattribute (${columns}) values (${buffer.toString()})"
        }
//        statements.each { println it }
        return statements
    }
}
