package connectors.db;

import ballerina.lang.system;
import ballerina.data.sql;

connector ClientConnector(){

    map props = {"jdbcUrl":"jdbc:mysql://localhost:3306/db", "username":"root", "password":"user@123"};
    sql:ClientConnector testDB = create sql:ClientConnector(props);
    action getCalendarList(ClientConnector c) (message) {
        return testDB;
    }
}



