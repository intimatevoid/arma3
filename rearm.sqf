//PALI AND ALIAS' REARM SCRIPT
//DEPENDENCIES: ACRE
//The following script automatically re-kits players depending on their unit variable name using a scroll wheel interaction. The variable only needs to CONTAIN the _plrname variable, so "rifle" will work on units with the variablename "rifle1", "crifle", and "i_like_to_shoot_my_rifle_at_targets"
//Place the following in the init of the crate or whatever you want them to be able to kit up from:
//	call{this addAction ["Rearm!","scripts\rearm.sqf",nil,1.5,true,true,"","true",2]; };

//////////
//Rewrite to improve efficiency and make it more universal. Assumes players won't be doing unusual things like changing uniforms or switching roles
//////////

//Creating empty custom variables to ensure they return as strings
plr343 = "";
plr152 = "";
plr117f = "";
plr148 = "";
plr77 = "";
plrBF888S = "";
plrSEM70 = "";
plrSEM52SL = "";

//Gathering information about the player and their kit
_plrName = vehicleVarName player;
_muzzleslot = primaryweaponItems player select 0;
_railslot = primaryweaponItems player select 1;
_opticslot = primaryweaponitems player select 2;
_bipodslot = primaryweaponItems player select 3;
_pistolmuzzle = handgunItems player select 0;
_pistolunder = handgunItems player select 1;
_pistoloptic = handgunItems player select 2;
_uniformslot = uniform player;
_vestslot = vest player;
_backpackslot = backpack player;
_headgearslot = headgear player;
_nvgslot = player getSlotItemName 616;
_mapslot = player getSlotItemName 608;
_gpsslot = player getSlotItemName 612;
_compassslot = player getSlotItemName 609;
_facewearslot = player getSlotItemName 603;
_binocslot = player getSlotItemName 617;
_watchslot = player getSlotItemName 610;

if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then {
	plr343 = (["ACRE_PRC343"] call acre_api_fnc_getRadioByType);
	Ear343 = [plr343] call acre_api_fnc_getRadioSpatial;
	Chn343 = [plr343] call acre_api_fnc_getRadioChannel;
	Vol343 = [plr343] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then {
	plr152 = (["ACRE_PRC152"] call acre_api_fnc_getRadioByType);
	Ear152 = [plr152] call acre_api_fnc_getRadioSpatial;
	Chn152 = [plr152] call acre_api_fnc_getRadioChannel;
	Vol152 = [plr152] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then {
	plr148 = (["ACRE_PRC148"] call acre_api_fnc_getRadioByType);
	Ear148 = [plr148] call acre_api_fnc_getRadioSpatial;
	Chn148 = [plr148] call acre_api_fnc_getRadioChannel;
	Vol148 = [plr148] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then {
	plr117F = (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType);
	Ear117F = [plr117F] call acre_api_fnc_getRadioSpatial;
	Chn117F = [plr117F] call acre_api_fnc_getRadioChannel;
	Vol117F = [plr117F] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_PRC77"] call acre_api_fnc_hasKindOfRadio) then {
	plr77 = (["ACRE_PRC77"] call acre_api_fnc_getRadioByType);
	Ear77 = [plr77] call acre_api_fnc_getRadioSpatial;
	Chn77 = [plr77] call acre_api_fnc_getRadioChannel;
	Vol77 = [plr77] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_BF888S"] call acre_api_fnc_hasKindOfRadio) then {
	plrBF888S = (["ACRE_BF888S"] call acre_api_fnc_getRadioByType);
	EarBF888S = [plrBF888S] call acre_api_fnc_getRadioSpatial;
	ChnBF888S = [plrBF888S] call acre_api_fnc_getRadioChannel;
	VolBF888S = [plrBF888S] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_SEM70"] call acre_api_fnc_hasKindOfRadio) then {
	plrSEM70 = (["ACRE_SEM70"] call acre_api_fnc_getRadioByType);
	EarSEM70 = [plrSEM70] call acre_api_fnc_getRadioSpatial;
	ChnSEM70 = [plrSEM70] call acre_api_fnc_getRadioChannel;
	VolSEM70 = [plrSEM70] call acre_api_fnc_getRadioVolume;
}; 
if ([player, "ACRE_SEM52SL"] call acre_api_fnc_hasKindOfRadio) then {
	plrSEM52SL = (["ACRE_SEM52SL"] call acre_api_fnc_getRadioByType);
	EarSEM52SL = [plrSEM52SL] call acre_api_fnc_getRadioSpatial;
	ChnSEM52SL = [plrSEM52SL] call acre_api_fnc_getRadioChannel;
	VolSEM52SL = [plrSEM52SL] call acre_api_fnc_getRadioVolume;
}; 
PLRPTT = [] call acre_api_fnc_getMultiPushToTalkAssignment;



//Removing all player gear
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

//Universal gear that every player has

//Add uniform/vest/pack/hat - If the mission has different gear per role, comment these out and add them in the role specific sections
player forceAddUniform _uniformslot;
player addVest _vestslot;
player addBackpack _backpackslot;
player addHeadgear _headgearslot;

//Adding default medical and radios
for "_i" from 1 to 8 do {player addItemToUniform "ACE_fieldDressing";};
player addItemToUniform "ACE_splint";
player addItemToUniform "ACE_morphine";
for "_i" from 1 to 2 do {player addItemToUniform "ACE_tourniquet";};
player addItem plr343;
player addItem plrSEM52SL; // these 3 are the only ones we'd be likely to use as rifleman radios and if the script didn't find one, it'll add nothing
player addItem plrBF888S;
player linkItem _mapslot;
player linkItem _gpsslot;
player linkItem _compassslot;
player linkItem _nvgslot;
player linkItem _watchslot;
player linkItem _facewearslot;
player addWeapon _binocslot; 
player linkItem _binocslot;


//PLAYER ROLE SPECIFIC CODE

//RIFLEMAN - All units with RFL in their classname will get this loadout 
if (["rfl", (_plrName)] 
	call BIS_fnc_inString) then 
{
/* 
These are in case units don't all have the same gear (eg: insurgent missions). If you need to use this, comment out the block above and uncomment these. I've only put them in the rifleman role, you can copy paste into others if you need it

player forceAddUniform "U_B_CombatUniform_mcam";
player addVest "V_PlateCarrier1_rgr";
player addBackpack "B_AssaultPack_rgr";
player addHeadgear "H_HelmetB";

*/

player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Rifleman</t>","PLAIN", 1,true,true];
};

//LEADER
if (["ldr", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

player addItemToBackpack plr152;
player addItemToBackpack plrSEM70;
player addItemToBackpack plr117F;
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellBlue"};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellOrange"};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellPurple"};
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Leader</t>","PLAIN", 1,true,true];
};

//JTAC - Assumed to have 2 different types of long range radios rather than 2 of the same
if (["jtac", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

player addItemToBackpack plr117F;
player addItemToBackpack plr152;
player addItemToBackpack plrSEM70;
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: JTAC</t>","PLAIN", 1,true,true];
};

//CLS
if (["cls", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShell";};
for "_i" from 1 to 24 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 8 do {player addItemToBackpack "ACE_epinephrene";};
for "_i" from 1 to 8 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 8 do {player addItemToBackpack "ACE_tourniquet";};
for "_i" from 1 to 4 do {player addItemToBackpack "ACE_personalAidKit";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_salineIV_500";};
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_salineIV_250";};
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: CLS</t>","PLAIN", 1,true,true];
};

//PLATMED
if (["platmed", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShell";};
for "_i" from 1 to 32 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 12 do {player addItemToBackpack "ACE_epinephrene";};
for "_i" from 1 to 12 do {player addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 12 do {player addItemToBackpack "ACE_tourniquet";};
for "_i" from 1 to 16 do {player addItemToBackpack "ACE_personalAidKit";};
for "_i" from 1 to 6 do {player addItemToBackpack "ACE_salineIV_500";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_salineIV_250";};
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Platoon Medic</t>","PLAIN", 1,true,true];
};



//AUTORIFLEMAN
if (["auto", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "LMG_03_F";
player addPrimaryWeaponItem "200Rnd_556x45_Box_Tracer_Red_F";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

player addItemToVest "200Rnd_556x45_Box_Tracer_Red_F";
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

for "_i" from 1 to 4 do {player addItemToBackpack "200Rnd_556x45_Box_Tracer_Red_F";};
player addItemToVest "HandGrenade";
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Autofifleman</t>","PLAIN", 1,true,true];
};

//LAT
if (["lat", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

player addWeapon "CUP_launch_M72A6";

titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Rifleman (LAT)</t>","PLAIN", 1,true,true];
};

//DEMO
if (["demo", (_plrName)] 
	call BIS_fnc_inString) then 
{
player addWeapon "hlc_rifle_SG551LB_RIS";
player addPrimaryWeaponItem "hlc_30Rnd_556x45_EPR_sg550";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

player addWeapon "CUP_hgun_Mk23";
player addHandgunItem "CUP_12Rnd_45ACP_mk23";
player addHandgunItem _pistolmuzzle;
player addHandgunItem _pistolunder;
player addHandgunItem _pistoloptic;

for "_i" from 1 to 2 do {player addItemToUniform "CUP_12Rnd_45ACP_mk23";};

for "_i" from 1 to 5 do {player addItemToVest "hlc_30Rnd_556x45_EPR_sg550";};
for "_i" from 1 to 2 do {player addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "HandGrenade";};

titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Demolitions Specialist</t>","PLAIN", 1,true,true];
player addItemToBackpack "ACE_DefusalKit";
player addItemToBackpack "ACE_Clacker";
player addItemToBackpack "MineDetector";
for "_i" from 1 to 14 do {player addItemToBackpack "DemoCharge_Remote_Mag";};
};

//PILOT
if (["pilot", (_plrName)] 
	call BIS_fnc_inString) then 
{
for "_i" from 1 to 2 do {player removeItem "CUP_12Rnd_45ACP_mk23";};
player addWeapon "SMG_01_F";
player addPrimaryWeaponItem "30Rnd_45ACP_Mag_SMG_01";
player addPrimaryWeaponItem _muzzleslot; //these lines and the pistol versions below preserve weapon attachments when rearming
player addPrimaryWeaponItem _railslot;
player addPrimaryWeaponItem _opticslot;
player addPrimaryWeaponItem _bipodslot;

for "_i" from 1 to 2 do {player addItemToVest "30Rnd_45ACP_Mag_SMG_01";};
for "_i" from 1 to 2 do {player addItemToVest "ACE_SalineIV_500";};
player addItemToVest "ACE_personalAidKit";
for "_i" from 1 to 2 do {player addItemToVest "SmokeShellOrange";};
player addItemToVest "ToolKit";

player addBackpack "B_AssaultPack_blk";
player addItemToBackpack plr117F;
player addItemToBackpack plr152;
player addItemToBackpack plrSEM70;
titleText ["<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t color='#e0cd23' size='1.5'>Rearmed loadout: Pilot</t>","PLAIN", 1,true,true];
};

sleep 1;

//Resets the radios to the correct volume, ear and channel
if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then {
	[plr343, Chn343] call acre_api_fnc_setRadioChannel;
	[plr343, Ear343] call acre_api_fnc_setRadioSpatial;
	[plr343, Vol343] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then {
	[plr152, Chn152] call acre_api_fnc_setRadioChannel;
	[plr152, Ear152] call acre_api_fnc_setRadioSpatial;
	[plr152, Vol152] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then {
	[plr148, Chn148] call acre_api_fnc_setRadioChannel;
	[plr148, Ear148] call acre_api_fnc_setRadioSpatial;
	[plr148, Vol148] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then {
	[plr117F, Chn117F] call acre_api_fnc_setRadioChannel;
	[plr117F, Ear117F] call acre_api_fnc_setRadioSpatial;
	[plr117F, Vol117F] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_PRC77"] call acre_api_fnc_hasKindOfRadio) then {
	[plr77, Chn77] call acre_api_fnc_setRadioChannel;
	[plr77, Ear77] call acre_api_fnc_setRadioSpatial;
	[plr77, Vol77] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_BF888S"] call acre_api_fnc_hasKindOfRadio) then {
	[plrBF888S, ChnBF888S] call acre_api_fnc_setRadioChannel;
	[plrBF888S, EarBF888S] call acre_api_fnc_setRadioSpatial;
	[plrBF888S, VolBF888S] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_SEM70"] call acre_api_fnc_hasKindOfRadio) then {
	[plrSEM70, ChnSEM70] call acre_api_fnc_setRadioChannel;
	[plrSEM70, EarSEM70] call acre_api_fnc_setRadioSpatial;
	[plrSEM70, VolSEM70] call acre_api_fnc_setRadioVolume;
}; 
if ([player, "ACRE_SEM52SL"] call acre_api_fnc_hasKindOfRadio) then {
	[plrSEM52SL, ChnSEM52SL] call acre_api_fnc_setRadioChannel;
	[plrSEM52SL, EarSEM52SL] call acre_api_fnc_setRadioSpatial;
	[plrSEM52SL, VolSEM52SL] call acre_api_fnc_setRadioVolume;
}; 
[[PLRPTT]] call acre_api_fnc_setMultiPushToTalkAssignment;
