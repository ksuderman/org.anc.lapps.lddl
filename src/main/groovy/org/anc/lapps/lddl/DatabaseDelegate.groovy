package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class DatabaseDelegate extends AbstractDelegate {

    @Override
    Set fieldNames() {
        ['url','username','password'] as HashSet
    }
}
