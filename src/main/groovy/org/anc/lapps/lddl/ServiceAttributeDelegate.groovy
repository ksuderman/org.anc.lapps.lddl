package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ServiceTypeDelegate extends AbstractTableDelegate {

    static final String SERVICE_ATTRIBUTE_COLUMNS = "gridid, name, serviceid, createddatetime, updateddatetime, value"
    // here SERVICE_ATTRIBUTE_COLUMNS (value) is Language

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

}
