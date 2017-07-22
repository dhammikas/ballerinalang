import ballerina.net.http;
import ballerina.lang.messages;

@http:config {basePath:"/freedacore"}
service<http> HelloService {

    @http:GET {}
    @http:Path {value:"/login"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "Login..");
        reply response;
    }

    @http:GET {}
    @http:Path {value:"/allUsers"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "allUsers..");
        reply response;
    }

    // Checkout the REST naming convention of the URL here
    @http:GET {}
    @http:Path {value:"/checkAvailability"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "checkAvailability..");
        reply response;
    }

    // Checkout the REST naming convention of the URL here
    @http:GET {}
    @http:Path {value:"/createMeeting"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "createMeeting..");
        reply response;
    }
}
