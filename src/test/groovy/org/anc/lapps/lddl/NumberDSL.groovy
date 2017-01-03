package org.anc.lapps.lddl

import java.util.concurrent.TimeUnit

/**
 * @author Keith Suderman
 */
class NumberDSL {

    void run() {

        String source = """
        outer {
            println 4.hours
            println 2.days
            println 2.days + 4.hours
            println 2.days + 4.hours + 1.minute
            println 1.minute
            println 2.minutes
        }
        """
//        Integer.metaClass.getHour = {
//            return TimeUnit.HOURS.toMillis(delegate)
//        }
//        Integer.metaClass.getHours = {
//            return TimeUnit.HOURS.toMillis(delegate)
//        }
//        Integer.metaClass.getDay = {
//            return TimeUnit.DAYS.toMillis(delegate)
//        }
//        Integer.metaClass.getDays = {
//            return TimeUnit.DAYS.toMillis(delegate)
//        }
//        Integer.metaClass.getMinute = {
//            return TimeUnit.HOURS.toMillis(delegate)
//        }
//        Integer.metaClass.getMinutes = {
//            return TimeUnit.HOURS.toMillis(delegate)
//        }
        GroovyShell shell = new GroovyShell()
        Script script = shell.parse(source)
        script.metaClass.outer = { Closure cl ->
            use(TimeUnitCategory) {
                cl()
            }
        }
        script.run()
    }
    static void main(String[] args) {
        new NumberDSL().run()
    }
}

@Category(Integer)
class IntegerCategory {
    int getHour() {
        return TimeUnit.HOURS.toMillis(this)
    }
    int getHours() {
        return TimeUnit.HOURS.toMillis(this)
    }
    int getDay() {
        return TimeUnit.DAYS.toMillis(this)
    }
    int getDays() {
        return TimeUnit.DAYS.toMillis(this)
    }
    int getMinute() {
        return TimeUnit.HOURS.toMillis(this)
    }
    int getMinutes() {
        return TimeUnit.HOURS.toMillis(this)
    }

}
class OuterDelegate {
    void inner(Closure cl) {
        use(TimeUnitCategory) {
            cl()
        }
    }

}
