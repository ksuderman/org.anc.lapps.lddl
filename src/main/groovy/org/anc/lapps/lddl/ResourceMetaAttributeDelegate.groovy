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
            namesCache = ['id', 'name', 'domain', 'description'] as HashSet
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
}
