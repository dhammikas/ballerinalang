import ballerina.lang.system;

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
    //1. Check if each recipient is free during the toTime - fromTime
    int j;
    while (j < 5) {
        system:println(j);
        j = j + 1;
        if (j == 3) {
            break;
        }
    }

    return "Not Yet Implemented, but Here is booking info : FromTime:" + bookingInfo.fromTime;

}





