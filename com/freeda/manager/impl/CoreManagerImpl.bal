import ballerina.lang.system;
import connectors.googlecalendar;

string userId = "freedatest1@gmail.com";
string accessToken = "ya29.GluQBJddhsiYLwtUQuXoz7U5gKGKcHP-6m0xkncfyE9_RbWMs5Zk5FI3KjCONZhoWD_jTld6vk4eO0JSeeK8sI4W3AUHESTnWT6w4TEs5QgTiXjJJoxj2GrVMVh2";
string refreshToken = "1/sNJAaC3Dt90Qxz9vq7btrE3UtAVYba55E2lk6vpEEFY";
string clientId = "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com";
string clientSecret = "tP4jPU5WkTqKqnNNCYAC1F9j";

function main (string[] args) {
    //string[] recipients  = ["ballerinahack.john.doe@gmail.com ","ballerinahack.mark.hughes@gmail.com ",
    //                        "ballerinahack.adam.sandler@gmail.com "];
    string recipient1  = "freedatest1@gmail.com";
    GoogleCalToken token1 = {userId : "freedatest1@gmail.com",
                                accessToken : "ya29.GluQBJddhsiYLwtUQuXoz7U5gKGKcHP-6m0xkncfyE9_RbWMs5Zk5FI3KjCONZhoWD_jTld6vk4eO0JSeeK8sI4W3AUHESTnWT6w4TEs5QgTiXjJJoxj2GrVMVh2",
                                refreshToken : "1/sNJAaC3Dt90Qxz9vq7btrE3UtAVYba55E2lk6vpEEFY",
                                clientId : "294920908486-2v42sias9f74m63chmvaolve8mn043rs.apps.googleusercontent.com",
                                clientSecret : "tP4jPU5WkTqKqnNNCYAC1F9j"};
    any[][] recipientsInfo = [[recipient1, token1]];


    Booking mockBooking = {fromTime:"2017-06-26T09:46:22.444-0500", toTime:"tT", recipientsInfo:recipientsInfo};
    system:println(checkAvailability(mockBooking));
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
            var token, err = (GoogleCalToken)recipientInfo[1];
            GoogleCalToken googleCalToken = (GoogleCalToken)token;
            system:println(googleCalToken);
            googlecalendar:ClientConnector calendar = create googlecalendar:ClientConnector(googleCalToken.userId, googleCalToken.accessToken, googleCalToken.refreshToken, googleCalToken.clientId, googleCalToken.clientSecret);
            //system:println(recipientInfo);

            //message calendarResponse = googlecalendar:ClientConnector.checkFreebusy(calendar);


            recipientIndex = recipientIndex + 1;
        }
    }
    else{
        //Return an error
    }


    return "Not Yet Implemented, but Here is booking info : FromTime:" + bookingInfo.fromTime;

}


function print(string info){
    system:println(info);
}




