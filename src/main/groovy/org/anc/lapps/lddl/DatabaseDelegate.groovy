package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class DatabaseDelegate extends AbstractDelegate {

    @Override
    String[] asSql() {
        return [] as String[]
    }

    @Override
    Set fieldNames() {
        ['url','username','password'] as HashSet
    }
}
