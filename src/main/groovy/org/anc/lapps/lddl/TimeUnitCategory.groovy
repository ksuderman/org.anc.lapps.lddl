package org.anc.lapps.lddl

import java.util.concurrent.TimeUnit

/**
 * The TimeUnitCategory is used in the TemporaryUserDelegate so the duration
 * of temporary accounts can be expressed in a human readable format.
 *
 * E.g.
 * <code>
 *     duration 4.days
 * </code>
 *
 * Available units are second(s), minute(s), hour(s), and day(s).
 *
 * @author Keith Suderman
 */
@Category(Integer)
class TimeUnitCategory {
    long getHour() {
        return TimeUnit.HOURS.toMillis(this)
    }
    long getHours() {
        return TimeUnit.HOURS.toMillis(this)
    }
    long getDay() {
        return TimeUnit.DAYS.toMillis(this)
    }
    long getDays() {
        return TimeUnit.DAYS.toMillis(this)
    }
    long getMinute() {
        return TimeUnit.MINUTES.toMillis(this)
    }
    long getMinutes() {
        return TimeUnit.MINUTES.toMillis(this)
    }

    long getSecond() {
        return TimeUnit.SECONDS.toMillis(this)
    }

    long getSeconds() {
        return TimeUnit.SECONDS.toMillis(this)
    }
\
}
