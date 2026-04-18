// MISSION TITLES ///////////////////////////////////////////////////////////////////////////
//
// This is the regular mission title script that prints the name, date and location of the mission as a nice little intro. 
//Save to scripts\missiontitles.sqf, then activate with a trigger that runs the following code:
// [] execVM "scripts\missionTitles.sqf";

//
/////////////////////////////////////////////////////////////////////////////////////////////

setDate [2001, 07, 02, 05, 00]; //sets the time and date in year, month, day, hour, minute format. Ideal for those mission makers who are anal enough to notice the disconnect between clock time and printed time. I made it for my own use...
[
    ["<t font='PuristaBold' size='1'>2nd of July, 2001<br/></t>", 2, 2], 
    ["<t font='PuristaBold' size='1'>0500<br/></t>", 2, 2], 
    ["<t font='PuristaBold' size='1'>Vrana FOB WNW of Anizay Town<br/></t>", 2, 5, 2]
] 
spawn BIS_fnc_EXP_camp_SITREP;
sleep 20;
[parseText "<t font='PuristaBold' size='3'>'Oil Get You'</t><br />Fourth Corporate War, Mission 1</t>", [1, 0.8, 1, 1], nil, 5, 1, 0] spawn BIS_fnc_textTiles;
