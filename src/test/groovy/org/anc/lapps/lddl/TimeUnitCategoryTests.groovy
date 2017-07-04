package org.anc.lapps.lddl

import org.junit.Ignore
import org.junit.Test

import java.util.concurrent.TimeUnit

import static org.junit.Assert.*

/**
 * @author Keith Suderman
 */
class TimeUnitCategoryTests {
    long SECOND = 1000
    long MINUTE = 60 * SECOND
    long HOUR   = 60 * MINUTE
    long DAY    = 24 * HOUR

    @Test
    void display() {
        use(TimeUnitCategory) {
            println MINUTE
            println 1.minute
            assertTrue(MINUTE == 1.minute)
            assertTrue(HOUR == 1.hour)
            assertTrue(DAY == 1.day)
        }
    }

    @Test
    void testPlurals() {
        use(TimeUnitCategory) {
            assertTrue 1.hour == 1.hours
            assertTrue 3.hour == 3.hours
            assertTrue(1.second == 1.seconds)
            assertTrue(2.second == 2.seconds)
        }
    }

    @Test
    void compareWithTimeUnit() {
        use(TimeUnitCategory) {
            assertTrue TimeUnit.SECONDS.toMillis(1) == SECOND
            assertTrue TimeUnit.MINUTES.toMillis(1) == MINUTE
            assertTrue TimeUnit.HOURS.toMillis(1) == HOUR
            assertTrue TimeUnit.DAYS.toMillis(1) == DAY
        }
    }

    @Ignore
    void checkDates() {
        long msec = System.currentTimeMillis()
        Date now = new Date(msec)
        println "Now $now"
        use(TimeUnitCategory) {
            Date later = new Date(msec + 1.day)
            println "One day later $later"
            later = new Date(msec + 365.days)
            println "One year later $later"
        }
    }
}

class CategoryTestDelegate extends AbstractTableDelegate {

    @Override
    String table() {
        return null
    }

    @Override
    String columns() {
        return null
    }

    @Override
    String values() {
        return null
    }

    void test() {
        Date now = new Date()
        use(TimeUnitCategory) {
            println now
            println now + 1.hour
        }
    }
}
