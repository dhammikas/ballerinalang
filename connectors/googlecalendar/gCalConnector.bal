package connectors.googlecalendar;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;

@doc:Description{ value : "Calendar client connector"}
@doc:Param{ value : "userId: The userId of the Google account which means the email id"}
@doc:Param{ value : "accessToken: The accessToken of the Gmail account to access the calendar REST API"}
@doc:Param{ value : "refreshToken: The refreshToken of the Calendar App to access the calendar REST API"}
@doc:Param{ value : "clientId: The clientId of the App to access the calendar REST API"}
@doc:Param{ value : "clientSecret: The clientSecret of the App to access the calendar REST API"}
connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://www.googleapis.com/calendar";

    oauth2:ClientConnector calendarEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
                                                                      refreshToken, refreshTokenEP);

    @doc:Description{ value : "Retrieve the calendar list"}
    @doc:Param{ value : "c: The calendar Connector instance"}
    @doc:Return{ value : "response object"}
    action getCalendarList(ClientConnector c) (message) {

        message request = {};

        string getProfilePath = "/v3/users/me/calendarList";
        message response = oauth2:ClientConnector.get(calendarEP, getProfilePath, request);

        return response;
    }

}