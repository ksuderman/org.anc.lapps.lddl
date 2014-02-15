package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ResourceMetaAttributeDelegate extends AbstractTableDelegate {
//    String id
//    String name
//    String domain
//    String description
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id', 'name', 'type', 'domain', 'description'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        "resourcemetaattribute"
    }

    @Override
    String columns() {
        "attributeid,domainid,attributename,description"
    }

    @Override
    String values() {
        if (valueCache != null) {
            return valueCache
        }
        StringBuilder buffer = new StringBuilder()
        buffer << "'${fields.id}'"
        [fields.domain,fields.name,fields.description].each {
            buffer << ",'${it}'"
        }
        valueCache = buffer.toString()
        return valueCache
    }

    @Override
    String[] asSql() {
        String[] statements = super.asSql()
        def columns = "resourcetype_domainid,resourcetype_resourcetypeid,metaattributes_attributeid,metaattributes_domainid"
        StringBuilder buffer = new StringBuilder()
        buffer << "'${fields.domain}'"
        [fields.type, fields.id, fields.domain].each {
            buffer << ", '${it}'"
        }

        statements += "insert into resourcetype_resourcemetaattribute (${columns}) values (${buffer.toString()})"
        return statements
    }
}
