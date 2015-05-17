package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class TemporaryUserDelegate extends AbstractTableDelegate {

    @Override
    Set fieldNames() {
        ['name','password','duration','owner'] as HashSet
    }

    @Override
    String table() {
        return "temporaryuser"
    }

    @Override
    String columns() {
        return 'gridid,userid,createddatetime,updateddatetime,beginavailabledatetime,endavailabledatetime,parentuserid,password'
    }

    @Override
    String values() {
        def now = timestamp()
        def password = encodePassword(fields.password)
        long time = System.currentTimeMillis()
//        println "Time: $time"
//        println "Duration: ${fields.duration}"
        def end = timestamp(time + fields.duration)
//        println "Now: $now"
//        println "End timestamp: ${end}"
        def values = [GRID_ID, fields.name, now, now, now, end, fields.owner, password]
        return values.collect { "'$it'"}.join(',')
    }

}
