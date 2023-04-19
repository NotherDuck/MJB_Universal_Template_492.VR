if (!isNil "mjb_arsenal_fnc_serverInit") exitWith {systemChat "Using init from MJB ARMA V2, changes to init scripts in the mission folder will not be reflected. Comment the first line of init scripts you're making changes to."; [] call mjb_arsenal_fnc_serverInit;};
// Comment above line when making changes

SafestartisActive = true;
publicVariable "SafestartisActive";

// Sim disable non-interactable objects
private _id = ["acex_fortify_objectPlaced", {params ["_player", "_side", "_object"];
  private _interactable = (_object isKindOf "AllVehicles" || {_object isKindOf "ReammoBox" || {_object isKindOf "ThingX"}});
  if (!_interactable) then {_object enableSimulationGlobal false;};
}] call CBA_fnc_addEventHandler;