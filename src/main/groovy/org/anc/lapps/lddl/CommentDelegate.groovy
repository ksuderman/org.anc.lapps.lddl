package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class CommentDelegate extends AbstractDelegate {
    String comment

    public CommentDelegate(String comment) {
        this.comment = comment
    }

    @Override
    String[] asSql() {
        return [ "# ${comment}" ] as String[]
    }

    void execute(Sql sql) {
        println comment
    }
}
