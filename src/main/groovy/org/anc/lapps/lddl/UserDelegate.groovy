package org.anc.lapps.lddl

import groovy.sql.Sql

/**
 * @author Keith Suderman
 */
class UserDelegate extends AbstractTableDelegate {

    @Override
    Set fieldNames() {
        ['id','name','password','email','organization','address','homepage'] as HashSet
    }

    @Override
    String table() {
        return null //"Users"
    }

    @Override
    String columns() {
        return null //""
    }

    @Override
    String values() {
        return null
    }

    @Override
    void execute(Sql sql) {
        validateFields()
        String columns = 'gridid,userid,createddatetime,updateddatetime,abletocallservices,address,defaultappprovisiontype,defaultusetype,emailaddress,homepageurlclazz,homepageurlstringvalue,organization,password,passwordchangeddate,representative,visible'
        def now = timestamp()
        def password = encodePassword(fields.password)
        StringBuilder values = new StringBuilder()
        values << "'${GRID_ID}'"
        [fields.id,now,now,true,fields.address,'CLIENT_CONTROL','NONPROFIT_USER',fields.email,'java.net.URL',fields.homepage,fields.organization,password,now,fields.name,true].each {
            values << ','
            values << "'${it}'"
        }
        String stmt = "insert into users (${columns}) values (${values.toString()})"
        sql.execute(stmt)

        stmt = "insert into userroles (gridid,userid,rolename) values ('${GRID_ID}','${fields.id}','langriduser')"
        sql.execute(stmt)
    }
}
