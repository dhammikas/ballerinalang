import ballerina.net.http;
import ballerina.lang.messages;

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
        message response = {};
        messages:setStringPayload(response, "allUsers..");
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
