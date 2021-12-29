0 = execVM 'loadouts\arsenal.sqf';

/* if (SafestartisActive == false) then
{
	[true] call TMF_safestart_fnc_end;
}; */

//workaround for magazines being slurped into weapons
sleep 5;
_primMags = primaryWeaponMagazine player;
if(count _primMags > 0) then {
  player addItem (_primMags select 0);
  if(count _primMags > 1) then {
    player addItem (_primMags select 1);
  };
};
if(secondaryWeapon player != "") then {
  player addItem (secondaryWeaponMagazine player select 0);
};
if(handgunWeapon player != "") then {
  player addItem (handgunMagazine player select 0);
};

bef_ttap = diw_armor_plates_main_timeToAddPlate; // Credit: MajorDanvers for this block, reduces plating time during safestart
waitUntil { time > 0 };
if ([] call TMF_safestart_fnc_isActive) then {
  diw_armor_plates_main_timeToAddPlate = 0.5;
  [ {!([] call TMF_safestart_fnc_isActive)},{
    diw_armor_plates_main_timeToAddPlate = bef_ttap;
    bef_ttap = nil;
    player call diw_armor_plates_main_fnc_fillVestWithPlates; // Fill plates in-case anyone forgot
  } ] call CBA_fnc_waitUntilAndExecute;
};