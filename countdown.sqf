//Pali's countdown timer. Count down with a timer, precisely calculated but imprecisely printed in minutes and seconds to hint or hintSilent. 
// DEPENDENT ON COMMUNITY BASE ADDONS
//Initialise by saving to scripts\countdown.sqf, then execute with a trigger that runs the following line:
//	nul=[]execvm "scripts\countdown.sqf";

//Enter time in minutes and seconds. Both fields will be added together in final output. Will work with decimals and oversized numbers, e.g. 900 seconds for 15 minutes, or 1.5 minutes for 90 seconds. 
//Minutes field
totalMinutes = 15; 
//Seconds field
totalSeconds = 0;
//Enter how often you want the hint to update in seconds. Does not affect timer speed, only the frequency of the printing. Setting this lower accounts for the imprecision in the sleep command.
timeStep = 0.2;
//Format the output however you want, substituting %1 for the minutes place and %2 for the seconds place.
timerText = "%1:%2 until main force arrives";

//NOTE: These four fields are formatted for conversion to a function later.

//Saves the sum of the minutes and seconds so we have the total to refer back to.
timeTotalSeconds = totalSeconds + (totalMinutes * 60); 

[timeTotalSeconds] call BIS_fnc_countdown;

While {[true] call BIS_fnc_countdown} do 
{

    //Sums up the minutes from the total seconds.
    timeTotalMinutes = ([0] call BIS_fnc_countdown) / 60.0; 
    
    //Gives us a printable integer by making sure the minutes field ticks down properly. Using the round command instead of floor will make the minutes field tick down at 30 seconds instead of 59.
    timeMinutes = floor timeTotalMinutes; 

    //Takes the time from the minutes decimal points and converts them to seconds
    timeSeconds = (timeTotalMinutes - timeMinutes) * 60.0; 
    
    //Uses CBA to format the seconds with two digits, e.g. shows 1 second as 01
    timeSecondsFmt = [timeSeconds, 2] call CBA_fnc_formatNumber; 
    
    //Prints the minutes and seconds fields to a hintSilent. 
    hintSilent format [timerText, timeMinutes, timeSecondsFmt];

    //Sleeps until the next loop.
    Sleep timeStep; 
};

hintSilent ""; 

//Any code you want to kick in at the end of the timer, put here.
//Example code
hint "Done";
sleep 1;
//remove hint
hintSilent "";
