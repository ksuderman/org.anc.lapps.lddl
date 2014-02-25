package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class AttributesDelegate {
    Map map = [:]

    void methodMissing(String name, args) {
        map[name] = args
    }
}
