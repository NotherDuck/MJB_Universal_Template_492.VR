["CAManBase", "Reloaded", {
    params ["_unit", "", "", "", "_oldMagazine"];
    if (isPlayer _unit) exitWith {};
    _oldMagazine params ["_type", "_roundsLeft"];
    if (isNil "_type" || {_roundsLeft > 0}) exitWith {};
    (_type call BIS_fnc_ItemType) params ["_magType", "_magLoadedWith"];
    if (_magType != "Magazine" || {!(_magLoadedWith in ["Bullet", "ShotgunShell"])}) exitWith {};
    _unit addMagazine _type;
}, true, [], true] call CBA_fnc_addClassEventHandler;