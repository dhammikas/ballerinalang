import ballerina.lang.system;

// A test method, just to Test this, remove it when integrating
function main (string[] args) {
    string[] recipients  = ["ballerinahack.john.doe@gmail.com ","ballerinahack.mark.hughes@gmail.com ",
                            "ballerinahack.adam.sandler@gmail.com "];
    Booking mockBooking = {fromTime:"2017-06-26T09:46:22.444-0500", toTime:"tT", recipients:recipients};
    system:println(checkAvailability(mockBooking));
}

struct Booking{
    string fromTime;
    string toTime;
    string[] recipients;
    string bookingTitle;
    string bookingBody;
}

function checkAvailability(Booking bookingInfo)(string){
    return "Not Yet Implemented, but Here is booking info : FromTime:" + bookingInfo.fromTime;
}





