import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.data.sql;

@http:configuration {basePath:"/freedacore"}
service<http> HelloService {

    @http:GET {}
    @http:Path {value:"/login"}
    resource login (message m) {
        message response = {};
        messages:setStringPayload(response, "Login..");
        reply response;
    }

    @http:GET {}
    @http:Path {value:"/user"}
    resource userList (message m) {
        map props = {"jdbcUrl":"jdbc:mysql://localhost:3306/freeda", "username":"root", "password":"user@123"};
        sql:ClientConnector freedaDB = create sql:ClientConnector(props);
        sql:Parameter[] params = [];
        datatable dt = sql:ClientConnector.select(freedaDB, "SELECT * from User", params);
        var jsonRes, err = <json>dt;
        message response = {};
        messages:setJsonPayload(response, jsonRes);
        reply response;
    }


    @http:GET {}
    @http:Path {value:"/checkAvailability"}
    resource checkAvailability (message m) {
        message response = {};
        messages:setStringPayload(response, "checkAvailability..");
        reply response;
    }


    @http:GET {}
    @http:Path {value:"/createMeeting"}
    resource createMeeting (message m) {
        message response = {};
        messages:setStringPayload(response, "createMeeting..");
        reply response;
    }
}
