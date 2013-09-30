package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class DelegateException extends Exception {
    DelegateException() {
    }

    DelegateException(String s) {
        super(s)
    }

    DelegateException(String s, Throwable throwable) {
        super(s, throwable)
    }

    DelegateException(Throwable throwable) {
        super(throwable)
    }
}
