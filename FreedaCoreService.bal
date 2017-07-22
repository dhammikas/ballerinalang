import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.data.sql;
import ballerina.lang.system;
import com.freeda.manager.impl;

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

        messages:addHeader(response, "Access-Control-Allow-Orogin", "*");

        reply response;
    }


    @http:POST {}
    @http:Path {value:"/checkAvailability"}
    resource checkAvailability (message m) {
        string clientId = "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com";
        string clientSecret = "tP4jPU5WkTqKqnNNCYAC1F9j";
        message response = {};
        messages:setStringPayload(response, "checkAvailability..");
        json jsonMsg = messages:getJsonPayload(m);
        //system:println(jsonMsg);
        var fromTime, castErr = (string )jsonMsg.fromTime;
        var toTime, castErr = (string )jsonMsg.toTime;
        json guestUsers = jsonMsg.guests;
        int l = lengthof guestUsers;
        int i = 0;
        any[][] recipientsInfo = [];
        while (i < l) {
            //system:println(guestUsers[i]);

        any [] data = [];
            var recipient1, castErr = (string )guestUsers[i].email;
            var accessToken , castErr = (string )guestUsers[i].accessToken;
            var refreshToken , castErr = (string )guestUsers[i].refreshToken;
            impl:GoogleCalToken token1 = {userId : recipient1,
                                        accessToken : accessToken,
                                        refreshToken :refreshToken,
                                        clientId : "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com",
                                        clientSecret : "tP4jPU5WkTqKqnNNCYAC1F9j"};
            data = [recipient1, token1];
            recipientsInfo[i] = data;
            i = i + 1;

        }
        impl:Booking bookinginfo = {fromTime:fromTime, toTime:toTime, recipientsInfo:recipientsInfo};
        //impl:checkAvailability(bookinginfo);
        system:println(bookinginfo);
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
