package com.freeda.manager.impl;
import ballerina.lang.system;
import ballerina.lang.messages;
import connectors.googlecalendar;
import ballerina.lang.jsons;

function main (string[] args) {
    //string[] recipients  = ["ballerinahack.john.doe@gmail.com ","ballerinahack.mark.hughes@gmail.com ",
    //                        "ballerinahack.adam.sandler@gmail.com "];
    string recipient1  = "freedatest1@gmail.com";
    GoogleCalToken token1 = {
                                userId : "freedatest1@gmail.com",
                                accessToken : "ya29.GluQBO8u4j9Mpz8PS96BNBZId595lVUhx26QiDq0joRGjl_eqdKS9jQ_ybqJaTS4LxB3vvEPN5J4OAxstd3PDCzJyGljvIw6WQz_91A98vQ7ouwW_QoijHlmsrCU",
                                refreshToken : "1/2EZoWKbfQB-YVMH2-KMAmDwIqIR5rl0W51yJOLCSERE",
                                clientId : "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com",
                                clientSecret : "tP4jPU5WkTqKqnNNCYAC1F9j"

                            };
    any[][] recipientsInfo = [[recipient1, token1]];


    Booking mockBooking = {fromTime:"2017-07-22T12:50:40+00:00", toTime:"2017-07-22T20:50:40+00:00", recipientsInfo:recipientsInfo};
    system:println(checkAvailability(mockBooking));
    ////json statusmsg = {status:"false", flag:"NOT_AVAILABLE", meta:{options:[
    //                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"],
    //                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"],
    //                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"]
    //                                                                      ]}};
    //system:println( jsons:toString(statusmsg));
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

function checkAvailability(Booking bookingInfo)(string){
    if (bookingInfo != null && bookingInfo.recipientsInfo != null){
        //1. Check if each recipient is free during the toTime - fromTime
        int recipientIndex = 0; any[] recipientInfo;
        while (recipientIndex < bookingInfo.recipientsInfo.length) {
            //system:println(bookingInfo.recipientsInfo[recipientIndex]);
            recipientInfo = bookingInfo.recipientsInfo[0];
            // Call Google Calendar and check availability of 'recipient'
            //system:println(recipientInfo[1]);
            var email, err = (string)recipientInfo[0];
            var token, err = (GoogleCalToken)recipientInfo[1];
            GoogleCalToken googleCalToken = (GoogleCalToken)token;
            //creating the Google Cal
            //googlecalendar:ClientConnector calendar = create googlecalendar:ClientConnector(googleCalToken.userId, googleCalToken.accessToken, googleCalToken.refreshToken, googleCalToken.clientId, googleCalToken.clientSecret);
            googlecalendar:ClientConnector calendar = create googlecalendar:ClientConnector(googleCalToken.userId, googleCalToken.accessToken, googleCalToken.refreshToken, googleCalToken.clientId, googleCalToken.clientSecret);

            //create an Calander
            //message calendarResponse = googlecalendar:ClientConnector.createQuickEvent(calendar, googleCalToken.userId, "event text");


            //message x = googlecalendar:ClientConnector.getAllEvents(calendar, "freedatest1@gmail.com");

            //message response = googlecalendar:ClientConnector.checkFreebusy(calendar, "2017-07-22T12:50:40+00:00", "2017-07-22T20:50:40+00:00", "freedatest1@gmail.com");

            message calendarResponse = googlecalendar:ClientConnector.checkFreebusy(calendar, bookingInfo.fromTime, bookingInfo.toTime, email);
            //var x, err = (json)calendarResponse;

            //system:println(x);
            json msgJson = messages:getJsonPayload(calendarResponse);
            json emailJson = msgJson.calendars[email];
            var busyStatusJson = emailJson["busy"];
            if(busyStatusJson != null){
                system:println("The one with this email is busy during this time, at least " + email);
                json statusmsg = {status:"false", flag:"NOT_AVAILABLE", meta:{options:[
                                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"],
                                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"],
                                                                                      ["2017-07-22T12:50:40+00:00", "2017-07-22T12:50:40+00:00"]
                                                                                      ]}};
                return jsons:toString(statusmsg);
            }

            recipientIndex = recipientIndex + 1;
        }
        json statusmsg = {status:"true", flag:"ALL_AVAILABLE"};
        return jsons:toString(statusmsg);

    }
    else{
        //Return an error
    }


    return "Not Yet Implemented, but Here is booking info : FromTime:" + bookingInfo.fromTime;

}


function print(string info){
    system:println(info);
}




