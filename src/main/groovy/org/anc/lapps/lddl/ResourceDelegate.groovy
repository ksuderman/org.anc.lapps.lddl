package org.anc.lapps.lddl

/**
 * @author Keith Suderman
 */
class ResourceDelegate extends AbstractTableDelegate{
    String valuesCache
    Map attributes = [:]

    void attributes(Map map) {
        map.each { name, value ->
            attributes[name] = value
        }
    }

    void attributes(Closure cl) {
        AttributesDelegate delegate = new AttributesDelegate()
        cl.delegate = delegate
        cl.resolveStrategy = Closure.DELEGATE_FIRST
        cl()
        delegate.map.each { name,value ->
            attributes['resource.meta.' + name] = value
        }
    }

    @Override
    Set fieldNames() {
        if (namesCache == null) {
            namesCache = ['id','copyright','license','description','name','domain','type'] as HashSet
        }
        return namesCache
    }

    @Override
    String table() {
        'resource'
    }

    @Override
    String columns() {
        'gridid,resourceid,createddatetime,updateddatetime,active,approved,copyrightinfo,licenseinfo,memoryinfo,osinfo,owneruserid,resourcedescription,resourcename,resourcetypedomainid,resourcetypeid,specialnoteinfo,visible'
    }

    @Override
    String values() {
        if (valuesCache == null) {
            def now = timestamp()
            StringBuilder buffer = new StringBuilder()
            buffer << "'${GRID_ID}'"
            [fields.id,now,now,true,true,fields.copyright,fields.license,null,null,GRID_USER_ID,fields.description,fields.name,fields.domain,fields.type,null,true].each {
                buffer << ",'${it}'"
            }
            valuesCache = buffer.toString()
        }
        return valuesCache
    }

    @Override
    String[] asSql() {
        String[] statements = super.asSql()
        String columns = "gridid,name,resourceid,createddatetime,updateddatetime,value"
        def now = timestamp()
        StringBuilder buffer = new StringBuilder()
        attributes.each { name,value ->
            buffer.setLength(0)
            // http://en.wikipedia.org/wiki/IETF_language_tag
            buffer << "'${GRID_ID}'"
            [name,fields.id,now,now,value].each {
                buffer << ",'${it}'"
            }
            statements += "insert into resourceattribute (${columns}) values (${buffer.toString()})"
        }
        return statements
    }
}
