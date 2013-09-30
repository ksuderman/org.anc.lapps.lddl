package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ProtocolDelegate extends AbstractTableDelegate {
    String valueCache

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name','description'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        'protocol'
    }

    @Override
    String columns() {
        'protocolid,createddatetime,updateddatetime,description,ownerusergridid,owneruserid,protocolname'
    }

    @Override
    String values() {
        if (valueCache == null) {
            def now = timestamp()
            StringBuilder buffer = new StringBuilder()
            buffer << "'${fields.id}'"
            [now,now,fields.description,GRID_ID,GRID_USER_ID,fields.name].each {
                buffer << ",'${it}'"
            }
            valueCache = buffer.toString()
        }
        return valueCache
    }
}
