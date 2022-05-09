["CAManBase", "Reloaded", {
    params ["_unit", "", "", "", "_oldMagazine"];
    if (isPlayer _unit) exitWith {};
    _oldMagazine params ["_type", "_roundsLeft"];
    if (isNil "_type" || {_roundsLeft > 0}) exitWith {};
    (_type call BIS_fnc_ItemType) params ["_magType", "_magLoadedWith"];
    if (_magType != "Magazine" || {!(_magLoadedWith in ["Bullet", "ShotgunShell"])}) exitWith {};
    [_unit, _type, 0] call CBA_fnc_removeMagazine;
    _unit addMagazine _type;
}, true, [], true] call CBA_fnc_addClassEventHandler;

addMissionEventHandler ["OnUserAdminStateChanged", {    // Admin JIP handler
  params ["_networkId", "_loggedIn", "_votedIn"];  
    
  if (time > 0 && {_loggedIn || _votedIn}) then {  
    [_networkId] spawn { params ["_newAdmin"];  
      waitUntil {(allPlayers findIf {_newAdmin == getPlayerID _x}) > -1};  
      private _JIPAdmin = (allPlayers select (allPlayers findIf {_newAdmin == getPlayerID _x}));  
      if (fileExists "briefing\admin.sqf") then {  
        [(compile preprocessfilelinenumbers "briefing\admin.sqf")] remoteExec ["call", _JIPAdmin];  
        ["Admin briefing granted."] remoteExec ["systemChat", _JIPAdmin];
      } else {  
        ["Warning, admin briefing not found. Expected: MISSION_ROOT\briefing\admin.sqf"] remoteExec ["systemChat", _JIPAdmin]; };  
  }; };    
}];

// Fortify rules: disallow placement of non-interactable objects with cost greater than 25 if not near terrain level
[{
    params ["_unit", "_object", "_cost"];
	private _interactable = (_object isKindOf "AllVehicles" || {_object isKindOf "ReammoBox" || {_object isKindOf "ThingX"}});
    private _return = (_cost < 26 || { _interactable || {(getPosATL _object) select 2 < 0.5}});
    _return
}] call ace_fortify_fnc_addDeployHandler;