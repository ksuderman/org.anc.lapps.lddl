package org.anc.lapps.lddl

/**
 * This class is not longer used and is scheduled for removal.
 *
 * @author Keith Suderman
 * @deprecated
 */
class GridDelegate {

    void methodMissing(String name, args) {
        if (name == 'id') {
            AbstractDelegate.GRID_ID = args[0]
        }
        else if (name == 'user') {
            AbstractDelegate.GRID_USER_ID = args[0]
        }
        else if (name == 'node') {
            AbstractDelegate.NODE_ID = args[0]
        }
        else {
            throw new MissingPropertyException("Invalid property for grid: ${name}")
        }
    }
}
