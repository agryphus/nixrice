//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/    /*Command*/     /*Update Interval*/ /*Update Signal*/
    {" ",      "coinmon -f XMR | grep 'XMR' | awk '{print $6}'",
                                120,                0},
    {" ",      "nmcli -f IN-USE,SIGNAL,SSID device wifi | grep \"*\" | awk '{print $3 \": \" $2}'",
                                30,                 0},
    {" ",      "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",  
                                30,                 0},
    {" ",      "date '+%a %b %d  %H:%M'",                               
                                5,                  0},
    {"",        "block_battery",   
                                10,                 0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;

