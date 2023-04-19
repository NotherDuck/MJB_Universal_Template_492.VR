if (!isNil "mjb_arsenal_fnc_playerLocalInit") exitWith {[] call mjb_arsenal_fnc_playerLocalInit;};
// Comment above line when making changes

//0 = execVM 'loadouts\arsenal.sqf'; // uncomment this
[] call mjb_arsenal_fnc_arsenal; // and comment this if changing arsenal

/* if (SafestartisActive == false) then
{
	[true] call TMF_safestart_fnc_end;
}; */

mjb_startLoc = getPosASL player; // Fix for players falling through platforms on Utes
player setPosASL mjb_startLoc; // Can also be used to teleport players back to start with remoteExec

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

mjb_jipFast = false; if (didJIP) then {mjb_jipTime = time; mjb_jipFast = true;};
bef_ttap = diw_armor_plates_main_timeToAddPlate; // Credit: MajorDanvers for this block, reduces plating time during safestart
private _plateMachine = [[player], true] call CBA_statemachine_fnc_create;
[_plateMachine, {}, {
    diw_armor_plates_main_timeToAddPlate = 0.5;}, {}, "fast"] call CBA_statemachine_fnc_addState;
[_plateMachine, {}, {
    diw_armor_plates_main_timeToAddPlate = bef_ttap;
	if (time < 1290 || {mjb_jipFast}) then {
      player call diw_armor_plates_main_fnc_fillVestWithPlates; // Fill plates in-case anyone forgot
	};
	mjb_jipFast = false;
}, {}, "slow"] call CBA_statemachine_fnc_addState;
[_plateMachine, "fast", "slow", { mjb_jipFast && {mjb_jipTime + 90 < time} || {!mjb_jipFast && {!([] call TMF_safestart_fnc_isActive)}}}, {}, "Safestart deactivated"] call CBA_statemachine_fnc_addTransition;
[_plateMachine, "slow", "fast", {[] call TMF_safestart_fnc_isActive || {mjb_jipFast && {mjb_jipTime + 90 > time}}}, {}, "Safestart active"] call CBA_statemachine_fnc_addTransition;