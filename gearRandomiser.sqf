//GEAR RANDOMISER SCRIPT
//Randomises player clothing within parameters you set. To run, save this as scripts\gearup.sqf, then place the following line in initplayerlocal.sqf:
//  [] execVM "scripts\gearRandomiser.sqf";
//You can also run it in onPlayerRespawn.sqf to shuffle equipment when they respawn, though this version won't save ACRE settings or track spent ammo across lives

//Fetches the variable name of the player's unit.
_plrName = vehicleVarName player; 

//Enter the classnames of the gear you want here. Make sure that whatever you load into it will fit the lowest-capacity item!
_headgear = [
	"lxWS_H_ssh40_black","lxWS_H_ssh40_green","lxWS_H_ssh40_sand"
] call BIS_fnc_selectRandom;

_uniform = [
	"U_lxWS_Djella_02_Brown","U_lxWS_Djella_02_Grey","U_lxWS_Djella_03_Green","U_lxWS_Djella_02_Sand"
] call BIS_fnc_selectRandom;

_vest = [
	"V_TacChestrig_cbr_F","V_TacChestrig_grn_F","V_TacChestrig_oli_F","V_lxWS_HarnessO_oli","V_HarnessO_brn"
] call BIS_fnc_selectRandom;

//Removes all equipment
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;

//Adds randomised clothes
player addHeadgear _headgear;
player forceAddUniform _uniform;
player addVest _vest;

//Baseline player equipment goes here as per your unit's standards
for "_i" from 1 to 8 do {player addItemToUniform "ACE_fieldDressing";};
player addItemToUniform "ACE_splint";
player addItemToUniform "ACE_morphine";
for "_i" from 1 to 2 do {player addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 2 do {player addItemToUniform "SmokeShell";};
player addItemToUniform "ACRE_PRC343";
player linkItem "itemMap";
player linkItem "itemCompass";
player linkItem "itemWatch";

for "_i" from 1 to 2 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

///Gives player appropriate weapon and ammo. These examples are customised to this one mission of mine using ANZIF equipment rules, so change to suit yours as appropriate.
//Change the _plrname in the unit's init when you place it, so your LSW gunner gets the variablename lswgun, your seccos and TLs get ldr, etc. It's flexible, so ldr_1, cls_ldr, or i_am_the_best_ldr will all work.
//Also, some roles combine. So rfl for rifleman combines to make rfl_cls, rfl_matgun, rfl_lswasst, etc since they just add extra equipment.

//LSW gunner
if (["lswgun", (_plrName)]
	call BIS_fnc_inString) then 
{
    player addWeapon "LMG_S77_Desert_lxWS";
    player addPrimaryWeaponItem "100Rnd_762x51_S77_Green_Tracer_lxWS";
    player addBackpack "EF_B_Kitbag_coy";
    for "_i" from 1 to 3 do {player addItemToVest "100Rnd_762x51_S77_Green_Tracer_lxWS";};
    for "_i" from 1 to 8 do {player addItemToBackpack "100Rnd_762x51_S77_Green_Tracer_lxWS";};
    player addWeapon "hgun_Pistol_01_F";
    player addHandgunItem "10Rnd_9x21_Mag";
    for "_i" from 1 to 3 do {player addItemToVest "10Rnd_9x21_Mag";};
};

//Seccos and TLs
if (["ldr", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addWeapon "arifle_SLR_D_lxWS";
    player addPrimaryWeaponItem "20Rnd_762x51_slr_desert_tracer_green_lxWS";
    player removeItemFromVest "SmokeShell";
    player addItemToUniform "SmokeShell";
    for "_i" from 1 to 9 do {player addItemToVest "20Rnd_762x51_slr_desert_tracer_green_lxWS";};
    player addItemtoVest "ACRE_PRC152";
    player addWeapon "Binocular"; 
};

//Rifleman
    if (["rfl", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addWeapon "arifle_SLR_D_lxWS";
    player addPrimaryWeaponItem "20Rnd_762x51_slr_desert_lxWS";
    for "_i" from 1 to 9 do {player addItemToVest "20Rnd_762x51_slr_desert_lxWS";};

};

//Platoon medic
    if (["med", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addBackpack "AAF_Carryall_Medic_cbr";
    for "_i" from 1 to 50 do {player addItemToBackpack "ACE_fieldDressing";};
    for "_i" from 1 to 12 do {player addItemToBackpack "ACE_epinephrine";};
    for "_i" from 1 to 12 do {player addItemToBackpack "ACE_morphine";};
    for "_i" from 1 to 8 do {player addItemToBackpack "ACE_splint";};
    for "_i" from 1 to 12 do {player addItemToBackpack "ACE_tourniquet";};
    for "_i" from 1 to 16 do {player addItemToBackpack "ACE_personalAidKit";};
    for "_i" from 1 to 10 do {player addItemToBackpack "ACE_salineIV_250";};
    for "_i" from 1 to 10 do {player addItemToBackpack "ACE_salineIV_500";};
    for "_i" from 1 to 4 do {player addItemToVest "SmokeShell";};
    
};

//CLS
    if (["cls", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addBackpack "AAF_AssaultPack_Medic_cbr";
    for "_i" from 1 to 24 do {player addItemToBackpack "ACE_fieldDressing";};
    for "_i" from 1 to 8 do {player addItemToBackpack "ACE_epinephrine";};
    for "_i" from 1 to 8 do {player addItemToBackpack "ACE_morphine";};
    for "_i" from 1 to 8 do {player addItemToBackpack "ACE_tourniquet";};
    for "_i" from 1 to 4 do {player addItemToBackpack "ACE_personalAidKit";};
    for "_i" from 1 to 2 do {player addItemToBackpack "ACE_salineIV_250";};
    for "_i" from 1 to 3 do {player addItemToBackpack "ACE_salineIV_500";};
    for "_i" from 1 to 4 do {player addItemToBackpack "SmokeShell";};
    
};
//LSW Asst
    if (["lswasst", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addBackpack "EF_B_Carryall_coy";
for "_i" from 1 to 9 do {player addItemToBackpack "100Rnd_762x51_S77_Green_Tracer_lxWS";};
};
//Marksman
    if (["mrk", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addPrimaryWeaponItem "optic_KHS_old";
};
//MAT gunner
    if (["matgun", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addWeapon "launch_RPG32_tan_lxWS";
    player addSecondaryWeaponItem "RPG32_F";
    player addBackpack "EF_B_Carryall_coy";
    for "_i" from 1 to 4 do {player addItemToBackpack "RPG32_F";};
    for "_i" from 1 to 2 do {player addItemToBackpack "RPG32_HE_F";};
};
//MAT asst
    if (["matasst", (_plrName)] 
	call BIS_fnc_inString) then 
{
    player addBackpack "EF_B_Carryall_coy";
    player addWeapon "Binocular";
    for "_i" from 1 to 4 do {player addItemToBackpack "RPG32_F";};
    for "_i" from 1 to 2 do {player addItemToBackpack "RPG32_HE_F";};
};
//If you want all players to have identical insignias, rather than individual or group-based ones, uncomment this. Leave blank for no insignia or put the insignia classname between the inverted commas.
//[player, ""] call BIS_fnc_setUnitInsignia;
