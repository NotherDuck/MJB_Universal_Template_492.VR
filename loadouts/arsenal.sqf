/**
	* Adds curated arsenal to player that disables itself under specified conditions.
	*
	* Faction: MJB ARMA default PMCs
	*
	* Usage - under initPlayerLocal.sqf
	* 0 = execVM 'loadouts\arsenal.sqf';
	* 
	* New framework update by NotherDuck
	* Equipment and quality hat choices by MajorDanvers
	* Formatting by veerserif
	*
	* v0.5 - 2021-08-20:
		- Removed ACRE Radios
		- Removed EFT Uniforms with Beltstaff Pants (White LOD Issue)
		- Added weapons and attachments requested in framework doc.
		- Gave all roles access to tracers where possible.
		- Moved DMRs (M14, SR-25, SVDS) and Shortdot to seperate role (_itemWeaponSharpshooter).
		- Added LAT Equipment (_itemWeaponLAT).
	* v1.0 - 2021-08-21:
		- Fixed several typos with magazines and added some missing ones (150 rnd 7.62x54r Box)
		- Moved shotguns and smgs to seperate section (_itemWeaponCQB, still given to all classes with normal rifles)
		- Added section for high capacity rifle mags (_itemWeaponHighCapAmmo, given to SF)
	* v1.1 - 2021-08-26:
		- Added ACRE radios back to arsenal.
		- Removed CUP lasers.
		- Fixed some roles not having access to pistols.
		- Added NAPA drip hoodie.
	* v1.1a - 2021-08-31:
		- Removed heli coveralls from normal infantry roles.
		- Gave tank and air crews access to CQB weapons.
	* v1.2 - 2021-09-01:
		- Added carbine variants requested by VierLeger (VHS-K2, ACR-C, F2000 Tactical, Mk17 CQC, Mk18).
	* v1.2a - 2021-09-14:
		- Added the AK-104 and AK-74M.
		- Changed AK-105 variant to B-13 version (rail can be removed using CTRL+C by default to access dovetail sights)
		- Fixed LAT and HAT roles having access to binoculars.
	* v2.0 - 2021-10-08:
		- Replaced all RHS and T1 content with CUP versions
		- Added trivial cosmetics for specific roles (ex. AR, Leaders)
*/

//Variables
private _unitRole = player getVariable ["tmf_assignGear_role",nil];
private _leaderRole = ["tl","sl"];
private _aceMedLoaded = isClass(configFile >> "CfgPatches" >> "ace_medical_engine"); //Store whether ace med is present

arsenal = "building" createVehicleLocal [0,0,0];
player setVariable ["startpos", getPosASL player];


//Define Arsenal Items
private _itemEquipment = 
[
	//============================================================
	//Non-Tarkov uniforms
	//============================================================
	//Female outfit models
	"U_B_CombatUniform_mcam_W",
	"U_B_CombatUniform_mcam_WO",
	"U_B_CombatUniform_mcam_tshirt_W",
	"WU_B_GEN_Soldier_F",
	"WU_B_GEN_Commander_F",

	//Drip
	"CUP_U_I_GUE_Anorak_01",
	"CUP_U_I_GUE_Flecktarn3",
	
	//============================================================
	//Vests
	//============================================================
	"V_PlateCarrier2_blk",
	
	//============================================================
	//Backpacks
	//============================================================
	"B_AssaultPack_rgr",
	"B_AssaultPack_cbr",
	"B_AssaultPack_khk",
	"B_Kitbag_rgr",
	"B_Kitbag_cbr",
	"B_Kitbag_sgg",
	"B_Kitbag_tan",
	
	//============================================================
	//Helmets
	//============================================================
	"H_Bandanna_gry",
	"H_Bandanna_camo",
	"H_Bandanna_sgg",
	"H_Bandanna_cbr",
	"H_Bandanna_khk",
	"H_Booniehat_wdl",
	"H_Bandanna_sand",
	
	"H_Booniehat_tna_F",
	"H_Booniehat_tan",
	"H_Booniehat_taiga",
	"H_Booniehat_oli",
	
	"H_Cap_blk",
	"CUP_H_PMC_Cap_Back_Grey",
	"CUP_H_PMC_Cap_EP_Grey",
	"H_Cap_oli",
	"H_Cap_tan",
	"CUP_H_PMC_Cap_Back_Tan",
	"CUP_H_PMC_Cap_EP_Tan",
	
	"H_HelmetB_Enh_tna_F",
	"H_HelmetSpecB",
	"H_HelmetSpecB_blk",
	"H_HelmetSpecB_paint2",
	"H_HelmetSpecB_paint1",
	"H_HelmetSpecB_sand",
	"H_HelmetSpecB_snakeskin",
	"H_HelmetSpecB_wdl",
	
	"CUP_H_RUS_K6_3_black",
	"CUP_H_RUS_K6_3_Goggles_black",
	"CUP_H_RUS_Bandana_GSSh_Headphones",
	"CUP_H_RUS_Bandana_HS",
	
	"H_Watchcap_blk",
	"H_Watchcap_khk",
	"H_Watchcap_cbr",
	"H_Watchcap_camo",
	
	"H_Hat_camo",
	"NVGoggles_OPFOR",

	//============================================================
	//ACRE radio
	//============================================================
	"ACRE_PRC343",
	
	//============================================================
	//Tools and misc
	//============================================================
	//ACE
	"ACE_Flashlight_XL50",
	"ACE_MapTools",
	"ACE_RangeCard",

	//BIS
	"ItemCompass",
	"ItemMap",
	"ItemWatch",
	"Laserbatteries",
	"ItemGPS",
	
	//Diwako
	"diw_armor_plates_main_plate",

	//Greenmag speedloader
	"greenmag_item_speedloader"
];

private _itemFacewear =
[
	//Vanilla
	"G_Balaclava_blk",
	"G_Bandanna_aviator",
	"G_Bandanna_tan",
	"G_Bandanna_oli",
	"G_Bandanna_shades",
	"G_Lowprofile",
	"G_Balaclava_TI_blk_F",
	"G_Balaclava_TI_G_blk_F",
	"G_Tactical_Clear",

	//CUP
	"CUP_G_ESS_BLK",
	"CUP_G_ESS_BLK_Scarf_Face_Blk",
	"CUP_G_ESS_BLK_Facewrap_Black",
	"CUP_G_ESS_BLK_Scarf_Grn",
	"CUP_G_ESS_BLK_Dark",
	"CUP_G_ESS_BLK_Scarf_Face_Grn",
	"CUP_PMC_Facewrap_Black",
	"CUP_G_PMC_Facewrap_Black_Glasses_Dark",
	"CUP_PMC_Facewrap_Tan",
	"CUP_G_PMC_Facewrap_Tan_Glasses_Dark",
	"CUP_PMC_Facewrap_Tropical",
	"CUP_G_PMC_Facewrap_Tropical_Glasses_Dark",
	"CUP_PMC_Facewrap_Winter",
	"CUP_G_PMC_Facewrap_Winter_Glasses_Dark",
	"CUP_G_Oakleys_Clr",
	"CUP_G_Oakleys_Drk",
	"CUP_G_Oakleys_Embr",
	"CUP_G_Scarf_Face_Blk",
	"CUP_G_Scarf_Face_Grn",
	"CUP_G_Scarf_Face_Tan",
	"CUP_G_Scarf_Face_White",
	"CUP_FR_NeckScarf",
	"CUP_FR_NeckScarf2",
	"CUP_FR_NeckScarf3",
	"CUP_FR_NeckScarf4",
	"CUP_FR_NeckScarf5"
];

private _itemSpecial =
[
	//============================================================
	//Binoculars and rangefinders
	//============================================================
	//BIS
	"Binocular",
	"Laserdesignator",
	"Laserdesignator_01_khk_F",
	"Laserdesignator_03",
	
	//============================================================
	//Explosives
	//============================================================

	//============================================================
	//Radios
	//============================================================
	"ACRE_PRC148",
	"ACRE_PRC152",
	"ACRE_PRC117F"
];

private _itemMod =
[	
	//============================================================
	// Magnified Optics (2-3x)
	//============================================================
	//Vanilla
	"optic_arco_blk_F",
	"optic_hamr",
	"optic_mrco",

	//CUP Magnified Sights
	"cup_optic_aimm_microt1_blk",
	"cup_optic_aimm_compm2_blk",
	"cup_optic_aimm_compm4_blk",
	"cup_optic_aimm_zddot_blk",
	"cup_optic_g33_hws_blk",

	//Dovetail (Ak Sights)
	"CUP_optic_pechenegscope",

	//Others
	//============================================================
	//Muzzle Devices
	//============================================================
	"CUP_muzzle_snds_socom762rc",
	"CUP_muzzle_snds_G36_black",
	"CUP_muzzle_snds_FAMAS",
	"CUP_muzzle_snds_M16",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_groza",
	
	//============================================================
	//Bipod & Foregrips
	//============================================================
	"CUP_bipod_Harris_1A2_L_BLK",

	//============================================================
	//Other rail attachments
	//============================================================
	"cup_acc_flashlight",
	"CUP_acc_anpeq_15",
	"CUP_acc_anpeq_15_tan_Top",
	"CUP_acc_anpeq_15_Flashlight_tan_L",
	"CUP_acc_anpeq_15_Top_Flashlight_tan_L",
	"CUP_acc_anpeq_15_Black",
	"CUP_acc_anpeq_15_Black_Top",
	"CUP_acc_anpeq_15_Flashlight_Black_L",
	"CUP_acc_anpeq_15_Top_Flashlight_Black_L",
	"CUP_acc_llm_black"
];

private _itemReflexSight = 
[
	//Vanilla
	"optic_yorris",
	"optic_aco",
	"optic_holosight_blk_f",

	//CUP Reflex Sights
	"cup_optic_ac11704_black",
	"cup_optic_mrad",
	"cup_optic_vortexrazor_uh1_black",
	"cup_optic_eotech553_black",
	"cup_optic_compm4",
	"cup_optic_okp_7_rail",
	"CUP_optic_MEPRO_openx_orange",
	"CUP_optic_TrijiconRx01_black",
	"CUP_optic_ZeissZPoint",

	//Dovetail (Ak Sights)
	"CUP_optic_ekp_8_02",
	"CUP_optic_Kobra",
	"CUP_optic_1p63",
	"CUP_optic_okp_7"
];

private _itemWeaponPistol = 
[
	//Pistols
	"CUP_hgun_Browning_HP",
	"CUP_hgun_CZ75",
	"CUP_hgun_M17_Black",
	"CUP_hgun_Makarov",
	"CUP_hgun_Mk23",
	"CUP_hgun_M9A1",
	"CUP_hgun_Colt1911",
	"CUP_hgun_Glock17_blk",
	"CUP_hgun_TT",

	//Magazines
	"CUP_13Rnd_9x19_Browning_HP",
	"CUP_16Rnd_9x19_cz75",
	"CUP_17Rnd_9x19_M17_Black",
	"CUP_8Rnd_9x18_Makarov_M",
	"CUP_12Rnd_45ACP_mk23",
	"CUP_15Rnd_9x19_M9",
	"CUP_7Rnd_45ACP_1911",
	"CUP_17Rnd_9x19_glock17",
	"CUP_8Rnd_762x25_TT",
	
	//Loose ammo
	"greenmag_ammo_9x19_basic_30Rnd",
	"greenmag_ammo_9x21_basic_30Rnd",
	"greenmag_ammo_45ACP_basic_30Rnd",
	"greenmag_ammo_9x18_basic_30Rnd",

	//Attachments
	"cup_acc_mk23_lam_f",
	"CUP_acc_CZ_M3X",
	"cup_acc_glock17_flashlight"

];

private _itemLeaderEquipment = 
[
	//Pistols
	"CUP_hgun_TaurusTracker455_gold",
	"CUP_hgun_TaurusTracker455",
	"CUP_hgun_Deagle",
	"hgun_Pistol_heavy_02_F",

	"CUP_6Rnd_45ACP_M",
	"CUP_7Rnd_50AE_Deagle",
	"6Rnd_45ACP_Cylinder",

	//Cute attachments for leaders
	"optic_mrd_black",
	"muzzle_snds_l",
	"cup_muzzle_snds_mk23",

	//Hats
	"H_Beret_blk",
	"CUP_H_Beret_HIL",
	"CUP_H_SLA_BeretRed",
	"CUP_H_ChDKZ_Beret"
];

private _itemWeaponRifle =
[
	//============================================================
	//5.56x45mm
	//============================================================
	"arifle_Mk20_plain_F",
	"CUP_arifle_G36A3_grip",
	"CUP_arifle_XM8_Railed",
	"CUP_arifle_ACR_blk_556",
	"CUP_arifle_HK416_Black",
	"CUP_arifle_M4A1_SOMMOD_black",
	"CUP_Famas_F1_Rail",
	"CUP_arifle_M16A4_Grip",
	"CUP_arifle_AK101_railed",
	
	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_Fort222",
	"CUP_arifle_AK74M",
	"CUP_arifle_AK74M_railed",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_arifle_AKM",
	"CUP_arifle_AK103_railed",
	"CUP_arifle_Sa58V",


	//============================================================
	//7.62x51mm
	//============================================================
	"CUP_arifle_DSA_SA58_OSW_VFG"
];

private _itemWeaponCarbine =
[
	//============================================================
	//5.56x45mm
	//============================================================
	"arifle_Mk20C_plain_F",
	"CUP_arifle_G36CA3_grip",
	"CUP_arifle_HK416_CQC_Black",
	"CUP_arifle_XM8_Compact_Rail",
	"CUP_arifle_ACRC_blk_556",
	"CUP_arifle_mk18_black",
	
	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_Fort224_Grippod",
	"CUP_arifle_AKS74U",
	"CUP_arifle_AK105_railed",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_arifle_OTS14_GROZA_762",
	"CUP_arifle_Sa58_Carbine_RIS_AFG"
];

private _itemWeaponAmmo =
[
	//============================================================
	//5.56x45mm
	//============================================================
	//Magazines
	"CUP_30Rnd_556x45_Emag",
	"CUP_30Rnd_556x45_PMAG_QP",
	"CUP_30Rnd_556x45_XM8",
	"CUP_25Rnd_556x45_Famas",
	"CUP_30Rnd_556x45_AK",

	//Loose ammo
	"greenmag_ammo_556x45_basic_60Rnd",
	
	//============================================================
	//5.45x39mm
	//============================================================
	//Magazines
	"CUP_30Rnd_545x39_Fort224_M",
	"CUP_30Rnd_545x39_AK74M_railed",

	//Loose ammo
	"greenmag_ammo_545x39_basic_60Rnd",
	
	//============================================================
	//7.62x39mm
	//============================================================
	//Magazines
	"CUP_30Rnd_762x39_AK47_bakelite_M",
	"CUP_30Rnd_762x39_AK47_M",
	"CUP_30Rnd_Sa58_M",

	//Loose ammo
	"greenmag_ammo_762x39_basic_60Rnd",
	
	//============================================================
	//7.62x51mm
	//============================================================
	//Magazines
	"CUP_20Rnd_762x51_FNFAL_M",

	//Loose ammo
	"greenmag_ammo_762x51_basic_60Rnd",
	
	//============================================================
	//7.62x54mm
	//============================================================
	//Magazines
	//Loose ammo
	"greenmag_ammo_762x54_basic_60Rnd",
	
	//============================================================
	//Grenades
	//============================================================
	//HE and frags
	"HandGrenade",
	
	//Smokes
	"SmokeShell",
	"SmokeShellGreen",
	"SmokeShellRed",
	"SmokeShellPurple",
	"SmokeShellBlue",

	//Make eyeballs hurt
	"ACE_M84"
];

private _itemWeaponTracerAmmo =
[
	//============================================================
	//5.56x45mm
	//============================================================
	"CUP_30Rnd_556x45_Emag_Tracer_Yellow",
	"CUP_30Rnd_556x45_PMAG_QP_Tracer_Yellow",
	"CUP_30Rnd_TE1_Yellow_Tracer_556x45_XM8",
	"CUP_25Rnd_556x45_Famas_Tracer_Yellow",
	"CUP_30Rnd_TE1_Yellow_Tracer_556x45_AK",
	
	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_30Rnd_TE1_Yellow_Tracer_545x39_Fort224_M",
	"CUP_30Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_bakelite_M",
	"CUP_30Rnd_Sa58_M_TracerY",
	"CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_M",

	//============================================================
	//7.62x51mm
	//============================================================
	"CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M"
	
	//============================================================
	//7.62x54mm
	//============================================================

	//============================================================
	//Misc Calibers (SMGs, Shotguns, Etc.)
	//============================================================


];

private _itemWeaponHighCapAmmo =
[
	//============================================================
	//5.56x45mm
	//============================================================
	"CUP_60Rnd_556x45_SureFire",
	"CUP_60Rnd_556x45_SureFire_Tracer_Yellow",

	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M",
	"CUP_60Rnd_545x39_AK74M_M",
	"CUP_60Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",

	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",
	"CUP_45Rnd_Sa58_M",
	"CUP_45Rnd_Sa58_M_TracerY",

	//============================================================
	//7.62x51mm
	//============================================================
	"CUP_30Rnd_762x51_FNFAL_M",
	"CUP_30Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M"
	
	//============================================================
	//7.62x54mm
	//============================================================
];

private _itemWeaponCQB =
[
	//============================================================
	//Weapons
	//============================================================	
	//SMGs
	"CUP_smg_MP7",
	"CUP_arifle_SR3M_Vikhr_VFG_top_rail",
	"CUP_smg_Mac10_rail",
	"CUP_smg_MP5A5_Rail_AFG",
	"CUP_smg_vityaz_vfg_top_rail",
	"CUP_smg_bizon",
	"CUP_smg_SA61",
	
	//Shotguns
	"CUP_sgun_M1014_vfg",
	"CUP_sgun_Saiga12k_top_rail",
	"CUP_sgun_SPAS12",

	//============================================================
	//Accessories
	//============================================================
	"CUP_muzzle_snds_mp7",
	"CUP_muzzle_snds_mp5",
	"CUP_muzzle_snds_sa61",
	"CUP_muzzle_mfsup_suppressor_mac10",
	"CUP_muzzle_Bizon",
	"cup_muzzle_snds_sr3m",	

	//============================================================
	//Magazines
	//============================================================
	//SMGs
	"CUP_40Rnd_46x30_MP7",
	"CUP_20Rnd_B_765x17_Ball_M",
	"CUP_30Rnd_9x39_SP5_VIKHR_M",
	"CUP_30Rnd_45ACP_MAC10_M",
	"CUP_30Rnd_9x19_MP5",
	"CUP_30Rnd_9x19_Vityaz",
	"CUP_64Rnd_9x19_Bizon_M",
	"CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M",

	//Shotguns
	"6Rnd_12Gauge_Pellets",
	"CUP_5Rnd_B_Saiga12_Buck_00",
	"CUP_12Rnd_B_Saiga12_Buck_00",
	"CUP_8Rnd_12Gauge_Pellets_No00_Buck",

	//============================================================
	//Loose ammo
	//============================================================
	"greenmag_ammo_46x30_basic_60Rnd",
	"greenmag_ammo_765x17_basic_60Rnd",
	"greenmag_ammo_9x39_basic_60Rnd",
	"greenmag_ammo_45ACP_basic_60Rnd",
	"greenmag_ammo_9x19_basic_60Rnd"
];

private _itemWeaponAR = 
[
	//============================================================
	//5.56x45mm
	//============================================================
	"CUP_lmg_L110A1",
	"CUP_arifle_L86A2",

	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_RPK74_45",
	"CUP_arifle_RPK74M_railed",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_arifle_RPK74",
	"CUP_arifle_RPK74_top_rail",
	"CUP_arifle_Sa58_Klec",
	"CUP_arifle_Sa58_Klec_ris",

	//============================================================
	//7.62x51mm
	//============================================================
	"CUP_lmg_M60E4",
	"CUP_lmg_MG3_rail",
	
	//============================================================
	//7.62x54mm
	//============================================================
	"CUP_lmg_Pecheneg_B50_vfg",
	"CUP_lmg_Pecheneg_top_rail_B50_vfg",



	//============================================================
	//LMG Accessories
	//============================================================	
	"cup_muzzle_snds_l85",
	"cup_muzzle_snds_kzrzp_pk"
];

private _itemWeaponSFAR = 
[
	//============================================================
	//LMGs
	//============================================================	
	"CUP_lmg_Mk48",

	//============================================================
	//LMG Accessories
	//============================================================	
	"muzzle_snds_h_mg_blk_f",
	"CUP_100Rnd_556x45_BetaCMag_ar15",
	"CUP_100Rnd_TE1__Yellow_Tracer_556x45_BetaCMag_ar15",
	"CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"
];

private _itemWeaponARAmmo =
[
	//============================================================
	//5.56x45mm
	//============================================================
	//Boxes
	"CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249",
	"CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249",
	//Loose belts
	"greenmag_beltlinked_556x45_basic_200",
	"greenmag_beltlinked_556x45_basic_100",
	"greenmag_beltlinked_556x45_basic_50",
	
	//============================================================
	//7.62x51mm
	//============================================================
	//Boxes
	"CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
	"CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
	"CUP_120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",
	"CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
	//Loose belts
	"greenmag_beltlinked_762x51_basic_200",
	"greenmag_beltlinked_762x51_basic_100",
	"greenmag_beltlinked_762x51_basic_50",
	
	//============================================================
	//7.62x54mmR
	//============================================================
	//Boxes
	"150Rnd_762x54_Box",
	"150Rnd_762x54_Box_Tracer",

	"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M",
	
	//Loose belts
	"greenmag_beltlinked_762x54_basic_200",
	"greenmag_beltlinked_762x54_basic_100",
	"greenmag_beltlinked_762x54_basic_50",

	//Backpack
	"B_Carryall_cbr",
	"B_Carryall_taiga_F",
	"B_Carryall_eaf_F",
	"B_Carryall_oli",
	
	//Bling
	"CUP_H_RUS_Altyn_Goggles",
	"CUP_H_RUS_Altyn_Shield_Up",
	"CUP_H_RUS_Altyn_Shield_Down",
	"CUP_H_RUS_Altyn_Goggles_khaki",
	"CUP_H_RUS_Altyn_Shield_Up_khaki",
	"CUP_H_RUS_Altyn_Shield_Down_khaki",
	"CUP_H_RUS_Altyn_Goggles_black",
	"CUP_H_RUS_Altyn_Shield_Down_black"
];

private _itemWeaponMG = 
[
	//mgs
	
	//bipods
];

private _itemWeaponSharpshooter = 
[
	//============================================================
	//Weapons
	//============================================================	
	//7.62x51mm
	"CUP_srifle_M14_DMR",
	"CUP_arifle_HK417_20",

	//7.62x54mmR
	"CUP_srifle_SVD",
	"CUP_srifle_SVD_top_rail",

	//============================================================
	//Magazines
	//============================================================
	//7.62x51mm
	"CUP_20Rnd_762x51_HK417",
	"CUP_20Rnd_762x51_DMR",
	"ace_20rnd_762x51_mag_tracer",

	//7.62x54mmR
	"CUP_10Rnd_762x54_SVD_M",
	"ace_10rnd_762x54_tracer_mag",

	//============================================================
	//Accessories
	//============================================================
	"optic_DMS",
	"optic_DMS_weathered_F",
	"CUP_optic_PSO_1",
	"CUP_optic_Elcan_SpecterDR_RMR_black",
	"cup_optic_acog",
	"cup_optic_acog_ta01nsn_rmr_black",
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_SVD_camo_g",
	"CUP_muzzle_snds_KZRZP_SVD"
];

private _itemWeaponSniper =
[
	"srifle_GM6_camo_F",
	"CUP_srifle_AS50",
	"CUP_srifle_CZ750",
	"CUP_srifle_AWM_wdl",
	"CUP_srifle_ksvk",
	"CUP_srifle_M107_Pristine",
	"CUP_srifle_M24_blk"
];

private _itemSniper =
[
	"U_I_GhillieSuit",
	"U_O_GhillieSuit",
	"U_B_GhillieSuit",
	"CUP_U_O_RUS_Ghillie",
	"CUP_U_B_BAF_DDPM_GHILLIE",
	// "optic_AMS", // marksman dlc
	"optic_LRPS",
	"CUP_optic_LeupoldMk4_25x50_LRT_pip",
	"CUP_optic_SB_3_12x50_PMII",
	
	"CUP_10Rnd_127x99_M107",
	"CUP_5Rnd_127x99_as50_M",
	"CUP_10Rnd_762x51_CZ750",
	"CUP_5Rnd_86x70_L115A1",
	"CUP_5Rnd_127x108_KSVK_M",
	"CUP_5Rnd_762x51_M24",
	
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_muzzle_snds_AWM",
	"CUP_optic_PSO_3_open",
	"CUP_muzzle_mfsup_Suppressor_M107_Black",
	"CUP_Mxx_camo_half",
	"muzzle_snds_B",

	"CUP_hgun_MP7",
	"CUP_40Rnd_46x30_MP7",
	"CUP_muzzle_snds_mp7",
	
	"greenmag_ammo_127x99_basic_30Rnd",
	"greenmag_ammo_127x99_basic_60Rnd",
	"greenmag_ammo_127x108_basic_30Rnd",
	"greenmag_ammo_127x108_basic_60Rnd",
	"greenmag_ammo_338_basic_30Rnd",
	"greenmag_ammo_338_basic_60Rnd",
	"greenmag_ammo_46x30_basic_60Rnd",
	"ACE_ATragMX"
];

private _itemWeaponGL =
[	
	//============================================================
	//Rifles
	//============================================================	
	//5.56x45mm
	"arifle_Mk20_GL_plain_F",
	"CUP_arifle_ACR_EGLM_blk_556",
	"CUP_arifle_M16A4_GL",
	"CUP_arifle_mk18_m203_black",
	"CUP_arifle_G36A3_AG36",
	"CUP_arifle_XM8_Carbine_GL",
	"CUP_arifle_HK416_AGL_Black",
	"CUP_arifle_AK101_GL",
	"CUP_arifle_AK101_GL_railed",

	//5.45x39mm
	"CUP_arifle_AK74M_GL",
	"CUP_arifle_AK74M_GL_railed",

	//7.62x39mm
	"CUP_arifle_AKM_GL",
	"CUP_arifle_AK103_GL_railed",
	"CUP_arifle_OTS14_GROZA_762_GL",
	"CUP_arifle_Sa58RIS2_gl",

	//7.62x51mm
	"CUP_arifle_DSA_SA58_OSW_M203",

	//============================================================
	//Grenade Rounds
	//============================================================
	//NATO
	"1Rnd_HE_Grenade_shell",
	"ACE_40mm_Flare_white",
	"ACE_40mm_Flare_ir",
	"1Rnd_Smoke_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell",
	"1Rnd_SmokeBlue_Grenade_shell",
	"1Rnd_SmokeGreen_Grenade_shell",

	//Rusfor
	"CUP_1Rnd_HE_GP25_M",
	"CUP_IlumFlareWhite_GP25_M",
	"CUP_1Rnd_SMOKE_GP25_M",
	"CUP_1Rnd_SmokeRed_GP25_M",
	"CUP_1Rnd_SmokeGreen_GP25_M"
];

private _itemWeaponSFSL =
[	
	"CUP_lmg_m249_para_gl",
	"CUP_arifle_AK107_GL_railed",
	"CUP_arifle_AK108_GL_railed",
	"CUP_arifle_AK109_GL_railed"
];

private _itemMedic =
[
	//BIS
	"B_Carryall_oucamo"
];

private _itemWeaponLAT = 
[
	"CUP_launch_M136",
	"CUP_launch_M72A6",
	"CUP_launch_RPG26",

	//Launchers in Backpack
	"CUP_launch_M136_Loaded",
	"CUP_launch_M72A6_Loaded",
	"CUP_M72A6_M",
	"CUP_launch_RPG26_Loaded"
];

private _itemAmmoLAT = 
[
	//RPG Rockets (Uncomment desired rockets)
];

private _itemWeaponMAT =
[
	"launch_MRAWS_green_F"
];

private _itemAmmoMAT =
[
	"MRAWS_HEAT_F",
	"MRAWS_HEAT55_F",
	"MRAWS_HE_F",
	"B_Carryall_cbr"
];

private _itemWeaponHAT =
[
	"launch_I_Titan_short_F"
];

private _itemAmmoHAT =
[
	"Titan_AT",
	"Rangefinder",
	"B_Bergen_mcamo_F"
];

private _itemSF =
[
	//BIS and Mods
	"O_NVGoggles_grn_F",
	"DemoCharge_Remote_Mag",
	"ACE_CTS9",
	"ACE_CableTie",
	"ACE_IR_Strobe_Item",
	"ACE_Clacker",
	"ACE_wirecutter",
	
	//Vests + Backpack
	"CUP_U_O_RUS_Gorka_Green_gloves_kneepads",
	"CUP_V_B_Ciras_Black",
	"CUP_V_B_Ciras_Black2",
	"CUP_V_B_Ciras_Khaki",
	"CUP_V_B_Ciras_Khaki2",
	"CUP_V_B_Ciras_Olive",
	"CUP_V_B_Ciras_Olive2",
	"Mechanism",
	"G2_Gunslinger",
	"Paratus",

	//Weapons
	"CUP_arifle_AK107_railed",
	"CUP_arifle_AK108_railed",
	"CUP_arifle_AK109_railed",
	"CUP_arifle_AS_VAL_VFG_top_rail",
	"CUP_smg_MP5SD6",
	"CUP_sgun_AA12",
	"CUP_20Rnd_B_AA12_Buck_00",
	"CUP_20Rnd_B_AA12_Slug",
	"CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",

	//Attachments
	"cup_acc_flashlight_mp5sd"
];

private _itemEngineer =
[
	//Tools
	"ACRE_148",
	"DemoCharge_Remote_Mag",
	"ACE_Clacker",
	"Toolkit",
	"ACE_M14",
	"ACE_wirecutter",
	"ACE_EntrenchingTool",
	"ACE_DeadManSwitch",
	"ACE_DefusalKit",
	"ATMine_Range_Mag",
	"ACE_FlareTripMine_Mag",
	"APERSTripMine_Wire_Mag",
	"SLAMDirectionalMine_Wire_Mag",
	"ClaymoreDirectionalMine_Remote_Mag",
	"TrainingMine_Mag",
	"ACE_UAVBattery",
	"ACE_SpraypaintBlack",
	"ACE_Rope36",
	"ACE_Rope15",
	"MineDetector",
	"ACE_Chemlight_HiBlue",
	"ACE_Chemlight_HiYellow",
	"ACE_Chemlight_UltraHiOrange",
	"ACE_TacticalLadder_Pack",

	//Equipment
	"CUP_V_MBSS_PACA_Tan",
	"CUP_V_MBSS_PACA_CB",
	"CUP_V_MBSS_PACA_RGR",
	"CUP_V_MBSS_PACA_Black",
	"CUP_V_MBSS_PACA_Green",
	"B_Bergen_mcamo_F",
	"B_UAV_01_backpack_F",
	"B_UGV_02_Demining_backpack_F"


];

private _itemTankCrew =
[
	"diw_armor_plates_main_plate",
	"greenmag_item_speedloader",
	"CUP_V_PMC_CIRAS_Black_Veh",
	"CUP_V_PMC_CIRAS_Khaki_Veh",
	"CUP_V_PMC_CIRAS_Coyote_Veh",
	"CUP_V_PMC_CIRAS_OD_Veh",
	"ACRE_PRC148",
	"SmokeShellBlue",
	"H_HelmetCrew_I",
	"U_B_CombatUniform_mcam_W",
	"U_B_CombatUniform_mcam_WO",
	"U_B_CombatUniform_mcam_tshirt_W",
	"WU_B_GEN_Soldier_F",
	"WU_B_GEN_Commander_F",
	"Rangefinder",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles"
];

private _itemHeloCrew =
[
	"diw_armor_plates_main_plate",
	"greenmag_item_speedloader",
	"CUP_V_PMC_CIRAS_Black_Veh",
	"CUP_V_PMC_CIRAS_Khaki_Veh",
	"CUP_V_PMC_CIRAS_Coyote_Veh",
	"CUP_V_PMC_CIRAS_OD_Veh",
	"ACRE_PRC148",
	"SmokeShellBlue",
	"H_PilotHelmetHeli_B",
	"WU_B_HeliPilotCoveralls",
	"WU_I_HeliPilotCoveralls",
	"U_B_HeliPilotCoveralls",
	"Rangefinder",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"G_aviator"
];

private _itemAirCrew =
[
	"muzzle_snds_l",
	"U_I_pilotCoveralls",
	"WU_O_PilotCoveralls",
	"ACE_IR_Strobe_Item",
	"greenmag_item_speedloader",
	"ACRE_PRC148",
	"greenmag_ammo_9x19_basic_30Rnd",
	"ACE_Chemlight_UltraHiOrange",
	"SmokeShellOrange",
	"H_PilotHelmetFighter_B",
	"Rangefinder",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"G_aviator"
];

if (_aceMedLoaded) then { //Check for ace med
  private _itemMedical = 
  [
	//Bandages
	"ACE_fieldDressing",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_quikclot",
	//Specialized Equipments
	"ACE_splint",
	"ACE_tourniquet",
	//Rifleman Medications
	"ACE_epinephrine",
	"ACE_morphine"
  ];
  {_x append _itemMedical} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
  // Append ACE Med Items
  private _itemMedicalAdv = 
  [
	//Fluids
	"ACE_bloodIV",
	"ACE_bloodIV_250",
	"ACE_bloodIV_500",
	"ACE_plasmaIV",
	"ACE_plasmaIV_250",
	"ACE_plasmaIV_500",
	"ACE_salineIV",
	"ACE_salineIV_250",
	"ACE_salineIV_500",
	//Medications
	"ACE_adenosine",
	//Specialized Equipments
	"ACE_personalAidKit",
	"ACE_surgicalKit"
  ]; 
  _itemMedic append _itemMedicalAdv;
} else { // Add base med items
	{_x pushBack "FirstAidKit";} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
	_itemMedic pushBack "Medikit";
};

private _ownedDLCs = getDLCs 1; // DLC check, Credit to MajorDanvers
private _hasApex = 395180 in _ownedDLCs;
private _hasContact = 1021790 in _ownedDLCs;

if (_hasApex) then {
	_itemsEquipment append [
		"U_I_C_Soldier_Bandit_3_F",
		"U_I_C_Soldier_Para_2_F",
		"U_I_C_Soldier_Para_3_F",
		"U_I_C_Soldier_Para_4_F",
		"U_I_C_Soldier_Para_1_F",
		
		"H_HelmetB_TI_tna_F",
		"U_I_C_Soldier_Camo_F"
	];
	
	_itemFacewear append [		
		"G_Balaclava_TI_blk_F",
		"G_Balaclava_TI_G_blk_F"
	];
	
	_itemMod append [
		"optic_ERCO_blk_F"
	];
};

if (_hasContact) then {
	_itemsEquipment append [		
		"U_O_R_Gorka_01_black_F",		
		"G_Blindfold_01_black_F"
	];
	
	_itemLeaderEquipment append [
		"H_Beret_EAF_01_F"
	];
	
	_itemAirCrew append [
		"U_I_E_Uniform_01_coveralls_F"
	];
};

//Add Existing Player Items
private _exWeap = weaponsItems player; // Weapons, attachments, loaded mags/ub
for "_y" from 0 to (count _exWeap - 1) do {
  {
    if (count _x == 2) then { _itemsEquipment pushBackUnique (_x # 0);}
	else { _itemsEquipment pushBackUnique _x;};
  } forEach (_exWeap # _y);
};
  
{
    _itemsEquipment pushBackUnique _x;
} forEach (assignedItems player + itemsWithMagazines player + [uniform player, vest player, backpack player, headgear player]); // All other equipment

private _tarkovuniforms = [];
for [{_i = 2}, {_i < 623}, {_i = _i + 24}] do
{
	for "_j" from (_i) to (_i + 21) do 
	{
    _tarkovuniforms pushback ("Tarkov_Uniforms_" + str _j);
	};
};

//Match unitrole name with the classnames in loadout.
switch (true) do 
{
	case (_unitRole == "ar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponAR + _itemWeaponMG + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "aar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole in _leaderRole) :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemSpecial + _itemMod + _itemReflexSight +  _itemWeaponGL + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "rm_fa") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "cls") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemMedic)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "mat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponMAT + _itemMod + _itemReflexSight +  _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "amat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "lat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sniper") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemWeaponSniper + _itemSniper + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "spotter") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponRifle + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSniper + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfsl") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponGL + _itemWeaponSFSL + _itemWeaponCQB + _itemSpecial + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfmed") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfmat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemWeaponMAT + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponAR + _itemWeaponARAmmo + _itemWeaponSFAR + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "ceng") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemEngineer + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "crew") :
	{
		[arsenal, (_ItemTankCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "helocrew") :
	{
		[arsenal, (_ItemHeloCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "aircrew") :
	{
		[arsenal, (_ItemAirCrew + _itemFacewear + _itemWeaponPistol + _itemLeaderEquipment)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "hat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponHAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "ahat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	default 
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
};

_action = 
[
	"personal_arsenal","Personal Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",
	{
		lockIdentity player;
		[arsenal, _player] call ace_arsenal_fnc_openBox
	},
	{ 
		(player distance2d (player getVariable ["startpos",[0,0,0]])) < 200
	},
	{},
	[],
	[0,0,0],
	3
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
