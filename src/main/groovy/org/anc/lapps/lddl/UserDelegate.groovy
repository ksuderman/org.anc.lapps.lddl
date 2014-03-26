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
        return 'gridid,userid,createddatetime,updateddatetime,abletocallservices,address,defaultappprovisiontype,defaultusetype,emailaddress,homepageurlclazz,homepageurlstringvalue,organization,password,passwordchangeddate,representative,visible'
    }

    @Override
    String values() {
        return null
    }

    @Override
    String[] asSql() {
        def statements = []
        validateFields()
        def now = timestamp()
        def password = encodePassword(fields.password)
        StringBuilder values = new StringBuilder()
        values << "'${GRID_ID}'"
        [fields.id,now,now,true,fields.address,'CLIENT_CONTROL','NONPROFIT_USE',fields.email,'java.net.URL',fields.homepage,fields.organization,password,now,fields.name,true].each {
            values << ','
            values << "'${it}'"
        }
        statements << "insert into users (${columns()}) values (${values.toString()})"
        statements << "insert into userroles (gridid,userid,rolename) values ('${GRID_ID}','${fields.id}','langriduser')"
        return statements as String[]
    }

}
