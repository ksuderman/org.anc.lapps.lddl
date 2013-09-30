package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class SqlDelegate extends AbstractTableDelegate {

    String statement

    public SqlDelegate(String statement) {
        this.statement = statement
    }

    @Override
    Set fieldNames() { return null }

    @Override
    String table() { return null }

    @Override
    String columns() { return null }

    @Override
    String values() { return null }

    @Override
    String asSql() { return statement }

    @Override
    void execute(Sql sql) {
//        println "Executing SQL : ${statement}"
        sql.execute(statement)
    }
}
