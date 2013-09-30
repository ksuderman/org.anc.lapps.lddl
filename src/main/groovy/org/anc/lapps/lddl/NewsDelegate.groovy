package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class NewsDelegate extends AbstractTableDelegate {
    String content

    public NewsDelegate(String content) {
        //println "Creating news: \"${content}\""
        this.content = content
    }


    @Override
    Set fieldNames() {
        return null
    }

    @Override
    String table() {
        return 'news'
    }

    @Override
    String columns() {
        'id,createddatetime,updateddatetime,contents,gridid,nodeid,nodelocalid'
    }

    @Override
    String values() {
        return null
    }

    @Override
    void execute(Sql sql) {
        def now = timestamp()
        def id = getNext(sql, 'news', 'id')
        StringBuilder buffer = new StringBuilder()
        buffer << "'${id}'"
        [now,now,content,GRID_ID,NODE_ID,id].each {
            buffer << ",'${it}'"
        }
        String stmt = "insert into news (${columns()}) values (${buffer.toString()})".toString()
        sql.execute(stmt)
        println "NEWS: ${content}"
    }
}
