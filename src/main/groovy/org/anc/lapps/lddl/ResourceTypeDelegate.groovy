package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ResourceTypeDelegate extends AbstractTableDelegate {
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name','domain','description'] as HashSet
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

}
