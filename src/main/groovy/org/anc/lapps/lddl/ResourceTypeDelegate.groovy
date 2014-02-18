package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ResourceTypeDelegate extends AbstractTableDelegate {
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name','domain','description','attributes'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        'resourcetype'
    }

    @Override
    String columns() {
        'domainid,resourcetypeid,createddatetime,updateddatetime,description,resourcetypename'
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
        def columns = "resourcetype_domainid,resourcetype_resourcetypeid,metaattributes_attributeid,metaattributes_domainid"
        StringBuilder buffer = new StringBuilder()
        fields.attributes.each { att ->
            buffer.setLength()
            buffer << "'${fields.domain}'"
            [fields.id, att, fields.domain].each {
                buffer << ", '${it}'"
            }

            statements += "insert into resourcetype_resourcemetaattribute (${columns}) values (${buffer.toString()})"
        }
        return statements
    }
}
