import ballerina.net.http;
import ballerina.lang.messages;
import connectors.googlecalendar;
import ballerina.lang.system;

@http:configuration {basePath:"/helloda"}
service<http> HelloService {

    @http:GET {}
    @http:Path {value:"/test"}
    resource sayHello (message m) {
        message response = {};
        messages:setStringPayload(response, "Hello World !!!");

        string userId = "freedatest1@gmail.com";
        string accessToken = "ya29.GluQBH4nuqjU3JAr-Kgx9qnZQJok3_VpUsyJnPaE83aC7j0EE8COBBl0HMwJTRn1KxtRKFJhi6-UFsC7YmOL8uGOr8a4r054TKsSgpi9kFKj6HiXU8cgCFhgpvcT";
        string refreshToken = "1/2EZoWKbfQB-YVMH2-KMAmDwIqIR5rl0W51yJOLCSERE";
        string clientId = "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com";
        string clientSecret = "tP4jPU5WkTqKqnNNCYAC1F9j";


        string recipient1  = "freedatest1@gmail.com";
        GoogleCalToken token1 = {
                                     userId : "freedatest1@gmail.com",
         accessToken : "ya29.GluQBH4nuqjU3JAr-Kgx9qnZQJok3_VpUsyJnPaE83aC7j0EE8COBBl0HMwJTRn1KxtRKFJhi6-UFsC7YmOL8uGOr8a4r054TKsSgpi9kFKj6HiXU8cgCFhgpvcT",
         refreshToken : "1/2EZoWKbfQB-YVMH2-KMAmDwIqIR5rl0W51yJOLCSERE",
         clientId : "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com",
         clientSecret : "tP4jPU5WkTqKqnNNCYAC1F9j"

    };
        any[][] recipientsInfo = [[recipient1, token1]];

        Booking bookingInfo = {fromTime:"2017-06-26T09:46:22.444-0500", toTime:"tT", recipientsInfo:recipientsInfo};


        if (bookingInfo != null && bookingInfo.recipientsInfo != null){
        //1. Check if each recipient is free during the toTime - fromTime
            int recipientIndex = 0; any[] recipientInfo;
            while (recipientIndex < bookingInfo.recipientsInfo.length) {
                //system:println(bookingInfo.recipientsInfo[recipientIndex]);
                recipientInfo = bookingInfo.recipientsInfo[0];
                // Call Google Calendar and check availability of 'recipient'
                //system:println(recipientInfo[1]);
                var token, err = (GoogleCalToken)recipientInfo[1];
                GoogleCalToken googleCalToken = (GoogleCalToken)token;
                //creating the Google Cal
                //googlecalendar:ClientConnector calendar = create googlecalendar:ClientConnector(googleCalToken.userId, googleCalToken.accessToken, googleCalToken.refreshToken, googleCalToken.clientId, googleCalToken.clientSecret);
                googlecalendar:ClientConnector calendar = create googlecalendar:ClientConnector(googleCalToken.userId, googleCalToken.accessToken, googleCalToken.refreshToken, googleCalToken.clientId, googleCalToken.clientSecret);

                //create an Calander
                //message calendarResponse = googlecalendar:ClientConnector.createQuickEvent(calendar, googleCalToken.userId, "event text");


                //message x = googlecalendar:ClientConnector.getAllEvents(calendar, "freedatest1@gmail.com");

                //message response = googlecalendar:ClientConnector.checkFreebusy(calendar, "2017-07-22T12:50:40+00:00", "2017-07-22T20:50:40+00:00", "freedatest1@gmail.com");

                message calendarResponse = googlecalendar:ClientConnector.checkFreebusy(calendar, "2017-07-22T12:50:40+00:00", "2017-07-22T20:50:40+00:00", "freedatest1@gmail.com");


                system:println(calendarResponse);

                //message calendarResponse = googlecalendar:ClientConnector.checkFreebusy(calendar);


                recipientIndex = recipientIndex + 1;
            }
        }
        else{
        //Return an error
        }


        reply response;
    }






}
struct Booking{
    string fromTime;
    string toTime;
    any[][] recipientsInfo;
    string bookingTitle;
    string bookingBody;
}

struct GoogleCalToken{
    string userId;
    string accessToken;
    string refreshToken;
    string clientId;
    string clientSecret;
}