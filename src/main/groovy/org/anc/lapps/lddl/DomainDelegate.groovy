package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class DomainDelegate extends AbstractTableDelegate {
//    String id
//    String name
//    String description
    String valueCache

    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','name','description'] as HashSet
        }
        return namesCache
    }

    String table() { 'domain'}
    String columns() {
        'domainid,createddatetime,updateddatetime,description,domainname,ownerusergridid,owneruserid'
    }

    String values() {
        if (valueCache != null) {
            return valueCache
        }
        def now = timestamp()
        def buffer = new StringBuilder()
        buffer << "'${fields.id}'"
        [now, now, fields.description, fields.name, GRID_ID, GRID_USER_ID].each {
            buffer << ",'${it}'"
        }
        valueCache = buffer.toString()
        return valueCache
    }

//    String asSql() {
//        "insert into domain () values ('${id}),'${now}'"
//    }
}
