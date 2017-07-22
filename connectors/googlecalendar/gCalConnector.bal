package connectors.googlecalendar;

import ballerina.lang.messages;
import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.net.uri;

@doc:Description {value:"Calendar client connector"}
@doc:Param {value:"userId: The userId of the Google account which means the email id"}
@doc:Param {value:"accessToken: The accessToken of the Gmail account to access the calendar REST API"}
@doc:Param {value:"refreshToken: The refreshToken of the Calendar App to access the calendar REST API"}
@doc:Param {value:"clientId: The clientId of the App to access the calendar REST API"}
@doc:Param {value:"clientSecret: The clientSecret of the App to access the calendar REST API"}
connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://www.googleapis.com/calendar";

    oauth2:ClientConnector calendarEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
                                                                      refreshToken, refreshTokenEP);

    action getAllEvents (ClientConnector c, string calendarId) (message response) {
        message request = {};

        string getPath = "/v3/calendars/" + calendarId + "/events/";
        response = oauth2:ClientConnector.get(calendarEP, getPath, request);

        return;
    }

    action checkFreebusy (ClientConnector c, string from, string to, string email) (message response) {
        message request = {};

        json createFreebusyPayload = {
                                         "timeMin": from,
                                         "timeMax": to,
                                         "items": [
                                                  {
                                                      "id": email
                                                  }
                                                  ]
                                     };

        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, createFreebusyPayload);

        string getPath = "/v3/freeBusy";
        response = oauth2:ClientConnector.post(calendarEP, getPath, request);

        return;
    }

    action createQuickEvent(ClientConnector c, string calendarId, string eventText) (message response) {
        message request = {};

        messages:setHeader(request, "Content-Length", "0");
        string getPath = "/v3/calendars/" + uri:encode(calendarId) +  "/events/quickAdd?text=" + uri:encode(eventText);
        response = oauth2:ClientConnector.post(calendarEP, getPath, request);

        return;
    }

}