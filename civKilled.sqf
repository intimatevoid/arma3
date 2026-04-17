///////////////////////////////////////////////////////
//PALI AND ALIAS' CIVILIAN KILL TRACKER 
// This script allows you to name and shame players who kill hand-placed or module-spawned civilians. 

//HOW TO USE:
//1. Place this file in your mission folders as scripts\civKilled.sqf.
//2. Paste this in initserver.sqf to make sure there's a counter: missionNamespace setVariable ["civsDead", 0];
//3. Paste this in Civilian Presence module's "Code On Unit Created" section, or if placing civs manually, just in their init: _this execVM "scripts\civKilled.sqf";

///////////////////////////////////////////////////////
//Was a unit killed?
_this addEventHandler ["Killed", {
    params ["_unit", "_killer"];
//Was the killer a player?
if(isPlayer _Killer) then{
//Is the killer alive?
    if(alive _Killer) then{
//Is the victim not west, east, or indep? I.E. is it a civilian or agent?
        if(((side _unit) !=west)&&((side _unit) !=east)&&((side _unit) !=independent)) then{
//Add one to the dead civ counter
                civsDead = civsDead + 1;
//This is where the magic happens. Print the killer's name and the total killed civs this mission. Can replace with anything, e.g. _killer setDamage 1; if you want to punish civ deaths with murder.
                [format ["%1 killed a civilian. %2 killed total.", name _Killer, civsDead]] remoteExec ["hint"];
            };
        };
    };
}];
