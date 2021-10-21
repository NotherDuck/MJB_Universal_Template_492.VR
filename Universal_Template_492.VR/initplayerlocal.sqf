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