params ["_player"];

 private _check = false;
waitUntil {sleep 8; !(isNil {_check = (isPlayer _player); _check}) && {_check}};

[{
    if (isClass (configfile >> "CfgPatches" >> "fatigue_core")) then {
        if(iEnemY_iFatigue_use_sway) then { player setCustomAimCoef iEnemY_iFatigue_aimcoeff; };
        if(iEnemY_iFatigue_stamina_enabled) then { player enableStamina false; };
        if(iEnemY_iFatigue_fatigue_enabled) then { player enableFatigue false; }; 
    };
    player allowSprint true;
    player call diw_armor_plates_main_fnc_fillVestWithPlates;
    player call diw_armor_plates_main_fnc_updatePlateUi;
    if !(isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
        player call diw_armor_plates_main_fnc_addPlayerHoldActions;
        player setVariable ["diw_armor_plates_main_hp", (diw_armor_plates_main_maxPlayerHp+0.01), true];
        player call diw_armor_plates_main_fnc_updateHPUi;
    };
    call babe_em_fnc_init;
}] remoteExec ["call", _player];