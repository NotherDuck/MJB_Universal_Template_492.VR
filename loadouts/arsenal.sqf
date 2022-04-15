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
	* v2.1 - 2022-01-22:
		- AKA the RHS one
			- All AR-pattern rifles switched out for RHS variants
			- RHS AKs added to augment our CUP AKs(yay for folding stocks!)
			- RHS optics and accessories added 
			- Some RHS cosmetics added
			- Added some vanilla fatigues to match our MWS fatigues
			- More backpack colors
			- M110 SASS and M14 EBR for sharpshooters
			- TAR-21 for vanilla troopers
	* v2.1a - 2022-01-30:
            - Left most CUP AR-pattern rifles for GL roles, some might prefer the holo dot gl sight
			- Prioritized model quality and variety when removing/replacing guns, CUP has nicer wood furniture usually.
			- Added RHS disposables and RPG-7 with similar AT strength rockets
			- ACE Vector and RHS Binocs
			- Couple RHSGREF camos
			- Winter variable to enable winter camo gear, these are currently weaker than our normal gear
			- Added RHS rifles to Sharpshooter and Sniper
			- Replaced CUP MP7 and added PP2000 and M590 in CQB weapons
			- Added M145 optic and a couple RHS AR options to ARs
			- Gave SF some vests from the pre-nuke arsenal, RHS AS Val, and a special pistol
			- Gave helo and tank crews pre-nuke vests (sorry air ;-;)
			- Blyat
			- Beltstaff yeeted (un-yeeted non-bugged shirts)
			- Added 20 round 9x39 mag and corrected 9x39 ammo box class name to ball
		- 2022-02-02:
			- Gave up trying to limit size and added a ton more weapons
			- Removed a few redundancies
		-2022-02-04:
			- Scav uniforms
		-2022-02-11:
			- MMG team (mjbLOVE to Banzerschreck), not shaking down AR yet
			- Moved non-base/med backpacks into _itemPackMedium and _itemPackHeavy
*/

//Variables
private _unitRole = player getVariable ["tmf_assignGear_role",nil];
private _leaderRole = ["tl","sl"];
private _aceMedLoaded = isClass(configFile >> "CfgPatches" >> "ace_medical_engine"); //Store whether ace med is present

private _winter = false; // true to enable winter camo

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
	"WU_B_T_Soldier_F",
	"WU_B_T_Soldier_AR_F",
	"WU_B_GEN_Soldier_F",
	"WU_B_GEN_Commander_F",

	//Drip
	"CUP_U_I_GUE_Anorak_01",
	"CUP_U_I_GUE_Flecktarn3",
	"rhsgref_uniform_alpenflage",
	"rhsgref_uniform_3color_desert",
	
	//Vanilla stuff
	"U_B_CombatUniform_mcam",
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_T_Soldier_F",
	"U_B_T_Soldier_AR_F",
	
	// Blyat
	"CUP_U_O_CHDKZ_Lopotev",
	"CUP_U_C_Tracksuit_01",
	"CUP_U_C_Tracksuit_02",
	"CUP_U_C_Tracksuit_03",
	"CUP_U_C_Tracksuit_04",
	
	//============================================================
	//Vests
	//============================================================
	"V_PlateCarrier2_blk",
	"V_PlateCarrier2_rgr_noflag_F",
	"V_PlateCarrier1_blk",
	"V_PlateCarrier1_rgr_noflag_F",
	"CUP_V_CZ_NPP2006_nk_black",
	"CUP_V_CZ_NPP2006_nk_vz95",
	"CUP_V_CZ_NPP2006_nk_des",
	"Module3mAssault_vest",
	"Module3mTV109_vest",
	"Module3mD3CRX_vest",
	"Module3mThunderbolt_vest",
	"Module3mTriton_vest",
	
	//============================================================
	//Backpacks
	//============================================================
	"B_AssaultPack_rgr",
	"B_AssaultPack_cbr",
	"B_AssaultPack_khk",
	"B_AssaultPack_mcamo",
	"B_AssaultPack_tna_F",
	"B_Kitbag_rgr",
	"B_Kitbag_cbr",
	"B_Kitbag_sgg",
	"B_Kitbag_tan",
	"B_Kitbag_mcamo",
	"CUP_B_GER_Pack_Flecktarn",
	"CUP_B_GER_Pack_Tropentarn",
	
	//============================================================
	//Helmets
	//============================================================
	"H_Bandanna_gry",
	"H_Bandanna_camo",
	"H_Bandanna_sgg",
	"H_Bandanna_cbr",
	"H_Bandanna_khk",
	"H_Bandanna_sand",
	"CUP_H_RUS_Bandana_GSSh_Headphones",
	"CUP_H_RUS_Bandana_HS",
	"CUP_H_FR_BandanaWdl",
	
	"H_Booniehat_tna_F",
	"H_Booniehat_tan",
	"H_Booniehat_taiga",
	"H_Booniehat_oli",
	"H_Booniehat_wdl",
	"CUP_H_FR_BoonieWDL",
	"rhsgref_Booniehat_alpen",
	
	"H_Cap_blk",
	"CUP_H_PMC_Cap_Back_Grey",
	"CUP_H_PMC_Cap_Back_EP_Grey",
	"CUP_H_PMC_Cap_EP_Grey",
	"H_Cap_oli",
	"H_Cap_tan",
	"CUP_H_PMC_Cap_Back_Tan",
	"CUP_H_PMC_Cap_Back_EP_Tan",
	"CUP_H_PMC_Cap_EP_Tan",
	"rhsusf_bowman_cap",
	
	// blyat
	"rhs_ushanka",
	"CUP_H_C_Ushanka_01",
	"CUP_H_C_Ushanka_02",
	"CUP_H_C_Ushanka_04",
	"CUP_H_C_Ushanka_03",
	
	
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
	
	"H_Watchcap_blk",
	"H_Watchcap_khk",
	"H_Watchcap_cbr",
	"H_Watchcap_camo",
	"CUP_H_C_Beanie_02",
	"CUP_H_PMC_Beanie_Black",
	"CUP_H_PMC_Beanie_Headphones_Black",
	"CUP_H_PMC_Beanie_Khaki",
	"CUP_H_PMC_Beanie_Headphones_Khaki",
	"rhs_beanie_green",
	"rhs_beanie",
	
	"H_Hat_camo",
	"NVGoggles_OPFOR",
	
	//RHS headset cosmetics
	"rhs_6m2_nvg",
	"rhs_6m2_1_nvg",	
	"rhs_facewear_6m2",
	"rhs_facewear_6m2_1",

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
	"ACE_microDAGR",
	
	//Diwako
	"diw_armor_plates_main_plate",

	//Greenmag speedloader
	"greenmag_item_speedloader"
];

private _itemPackMedium = 
[
	"B_Carryall_cbr",
	"B_Carryall_taiga_F",
	"B_Carryall_eaf_F",
	"B_Carryall_oli",
	"rhs_tortila_grey",
	"rhs_tortila_khaki",
	"rhs_tortila_olive"
];

private _itemPackHeavy = 
[	
	"B_Bergen_mcamo_F",
	"B_Bergen_tna_F",
	"B_Bergen_dgtl_F",
	"B_Bergen_hex_F",
	"Blackjack50",
	"B6SH118"
];
_itemPackHeavy append _itemPackMedium;

if (_winter) then {
  private _winterCamo = 
  [
	"CUP_I_B_PMC_Unit_29",
	"CUP_I_B_PMC_Unit_30",
	"CUP_I_B_PMC_Unit_33",
	"CUP_I_B_PMC_Unit_34",
	
	"CUP_H_PMC_Beanie_Winter",	
	"CUP_H_PMC_Beanie_Headphones_Winter",
	
	"CUP_V_PMC_CIRAS_Winter_Patrol"
  ];
  _itemEquipment append _winterCamo;
};

private _itemFacewear =
[
	//Vanilla
	"G_Balaclava_blk",
	"G_Bandanna_tan",
	"G_Bandanna_oli",
	"G_Bandanna_shades",
	"G_Shades_Black",
	"G_Balaclava_lowprofile",
	"G_Lowprofile",
	"G_Squares",
	"G_Tactical_Clear",

	//CUP
	"CUP_G_ESS_BLK",
	"CUP_G_ESS_BLK_Scarf_Face_Blk",
	"CUP_G_ESS_BLK_Facewrap_Black",
	"CUP_G_ESS_BLK_Scarf_Grn",
	"CUP_G_ESS_BLK_Dark",
	"CUP_G_ESS_BLK_Scarf_Face_Grn",
	"CUP_G_ESS_KHK_Scarf_Tan",
	"CUP_G_ESS_KHK_Scarf_Face_Tan",
	"CUP_G_ESS_BLK_Scarf_White",
	"CUP_G_ESS_BLK_Scarf_Face_White",
	
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
	"CUP_FR_NeckScarf5",
	
	"CUP_RUS_Balaclava_blk",
	"CUP_RUS_Balaclava_grn",
	"CUP_RUS_Balaclava_rgr",
	
	//RHS
	"rhs_balaclava"
];

private _itemSpecial =
[
	//============================================================
	//Binoculars and rangefinders
	//============================================================
	//BIS
	"Binocular",
	"Rangefinder",
	"Laserdesignator",
	"Laserdesignator_01_khk_F",
	"Laserdesignator_03",	
	"ACE_Vector",
	
	//RHS
	"rhsusf_bino_lerca_1200_black",
	"rhsusf_bino_lerca_1200_tan",
	"rhsusf_bino_m24",
	"rhsusf_bino_m24_ard",
	
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
if (_winter) then { _itemSpecial pushback "CUP_V_PMC_CIRAS_Winter_TL"; };

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
	"CUP_optic_pechenegscope", // 2.8x
	
	"rhs_acc_1p78", // 2x
	"rhs_acc_pgo7v3",

	//Others
	//============================================================
	//Muzzle Devices
	//============================================================
	"CUP_muzzle_snds_socom762rc",
	"CUP_muzzle_snds_G36_black",
	"CUP_muzzle_snds_FAMAS",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_groza",
	
	"rhsusf_acc_nt4_black", // New nicer 5.56/mk20 suppressors
	"rhsusf_acc_nt4_tan",
	"rhsusf_acc_rotex5_grey",
	"rhs_acc_pbs1",
	"rhsusf_acc_rotex_mp7",
	"rhsgref_acc_zendl",
	"rhs_acc_dtk",
	"rhs_acc_dtk1983",
	"rhs_acc_dtk4short",
	"rhs_acc_pgs64",
	"rhs_acc_tgpv2",
	"rhsgref_sdn6_suppressor",
	"rhsusf_acc_ardec_m240",
	
	//============================================================
	//Bipod & Foregrips
	//============================================================
	"CUP_bipod_Harris_1A2_L_BLK",
	"cup_bipod_sa58",
	
	"rhsusf_acc_grip2",
	"rhsusf_acc_kac_grip",
	"rhsusf_acc_rvg_blk",
	"rhs_acc_grip_rk2",
	"rhs_acc_grip_rk6",
	"rhsusf_acc_grip_m203_blk",	
	"rhs_acc_harris_swivel",	
	"rhsusf_acc_kac_grip_saw_bipod",
	"rhsusf_acc_grip4_bipod",	
	"rhsusf_acc_grip4",
	"rhsusf_acc_saw_lw_bipod",

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
	"CUP_acc_llm_black",
	
	"rhsusf_acc_anpeq15side_bk",
	"rhsusf_acc_anpeq15_bk_top",
	"rhsusf_acc_wmx_bk",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_m952v",
	"rhsusf_acc_anpeq15_bk",
	"rhsusf_acc_anpeq16a",
	"rhsusf_acc_anpeq16a_top",
	"rhs_acc_2dpzenit",
	"rhs_acc_2dpzenit_ris",
	"rhs_acc_perst1ik",
	"rhs_acc_perst1ik_ris",
	"rhs_acc_perst3",
	"rhs_acc_perst3_top",
	"rhs_acc_perst3_2dp_h"
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
	
	//RHS Reflex
	"rhsusf_acc_compm4",
	"rhsusf_acc_mrds",
	"rhsusf_acc_mrds_fwd",
	"rhsusf_acc_RX01_NoFilter",
	"rhsusf_acc_eotech_xps3",
	"rhs_acc_ekp8_18",
	"rhsusf_acc_t1_low",
	"rhsusf_acc_t1_low_fwd",

	//Dovetail (Ak Sights)
	"CUP_optic_ekp_8_02",
	"CUP_optic_Kobra",
	"CUP_optic_1p63",
	"CUP_optic_okp_7",
	
	"rhs_acc_pkas",
	"rhs_acc_ekp1",
	"rhs_acc_ekp8_02",
	"rhs_acc_npz" // B-13 adapter, doesn't get saved in loadouts regardless ;-;
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
	"greenmag_ammo_762x25_ball_30Rnd",

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
	
	"greenmag_ammo_50AE_ball_30Rnd", // deagle rounds

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
	"arifle_TRG21_F",
	
	"CUP_arifle_G36A3_grip",
	
	"CUP_arifle_XM8_Railed",
	
	"CUP_arifle_ACR_blk_556",
	
	"rhs_weap_hk416d145",
	
	"rhs_weap_m4a1_blockII_KAC_bk",
	
	"CUP_Famas_F1_Rail",
	
	"rhs_weap_m16a4_carryhandle",
	
	"CUP_arifle_AK101",
	"CUP_arifle_AK101_railed",
	
	"rhs_weap_vhsd2",
	"rhs_weap_vhsd2_ct15x",
	
	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_Fort222",
	"CUP_arifle_AK74",
	
	"rhs_weap_ak74m",
	"rhs_weap_ak74m_zenitco01",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"rhs_weap_savz58v",
	"rhs_weap_savz58v_rail_black",
	
	"CUP_arifle_AKM",
	
	"rhs_weap_ak103",
	"rhs_weap_ak103_zenitco01",

	//============================================================
	//7.62x51mm
	//============================================================
	"CUP_arifle_DSA_SA58_OSW_VFG",
	
	"rhs_weap_l1a1_wood"
];

private _itemWeaponCarbine =
[
	//============================================================
	//5.56x45mm
	//============================================================
	"arifle_Mk20C_plain_F",
	"arifle_TRG20_F",
	
	"CUP_arifle_G36CA3_grip",
	
	"rhs_weap_hk416d10",
	
	"CUP_arifle_XM8_Compact_Rail",
	
	"CUP_arifle_ACRC_blk_556",
	
	"CUP_arifle_AK102",
	"CUP_arifle_AK102_railed",
	
	"rhs_weap_mk18_KAC",
	
	"rhs_weap_vhsk2",
	
	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_Fort224_Grippod",
	
	"rhs_weap_aks74un",
	
	"rhs_weap_ak105",
	"rhs_weap_ak105_zenitco01",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_arifle_OTS14_GROZA_762",
	"CUP_arifle_Sa58_Carbine_RIS_AFG",
	
	"rhs_weap_ak104",
	"rhs_weap_ak104_zenitco01"
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
	"CUP_30Rnd_545x39_AK_M",
	"CUP_30Rnd_545x39_AK74M_M",

	//Loose ammo
	"greenmag_ammo_545x39_basic_60Rnd",
	
	//============================================================
	//7.62x39mm
	//============================================================
	//Magazines
	"CUP_30Rnd_762x39_AK47_bakelite_M",
	"CUP_30Rnd_762x39_AK47_M",
	"CUP_30Rnd_Sa58_M",
	
	"rhs_30Rnd_762x39mm_Savz58",

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
	"CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",
	
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
	
	"rhs_30Rnd_762x39mm_Savz58_tracer",

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
	"CUP_50Rnd_556x45_Green_Tracer_Galil_Mag",

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
	"CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",

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
	"CUP_arifle_SR3M_Vikhr_VFG_top_rail",
	"CUP_smg_Mac10_rail",
	"CUP_smg_MP5A5_Rail_AFG",
	"CUP_smg_SA61",
	"CUP_smg_vityaz_vfg_top_rail",
	"CUP_smg_bizon",
		
	"rhs_weap_pp2000",
	"rhsusf_weap_MP7A2",
	
	//Shotguns
	"CUP_sgun_M1014_vfg",
	"CUP_sgun_Saiga12K",
	"CUP_sgun_SPAS12",
	
	"rhs_weap_M590_8RD",
	"rhs_weap_M590_5RD",

	//============================================================
	//Accessories
	//============================================================
	"CUP_muzzle_snds_mp5",
	"CUP_muzzle_snds_sa61",
	"CUP_muzzle_mfsup_suppressor_mac10",
	"CUP_muzzle_Bizon",
	"cup_muzzle_snds_sr3m",
	
	"rhsusf_acc_rotex_mp7",

	//============================================================
	//Magazines
	//============================================================
	//SMGs
	"CUP_40Rnd_46x30_MP7",
	"CUP_20Rnd_B_765x17_Ball_M",
	"CUP_30Rnd_9x39_SP5_VIKHR_M",
	"CUP_20Rnd_9x39_SP5_VSS_M",
	"CUP_30Rnd_45ACP_MAC10_M",
	"CUP_30Rnd_9x19_MP5",
	"CUP_30Rnd_9x19_Vityaz",
	"CUP_64Rnd_9x19_Bizon_M",
	"CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M",
	
	"rhs_mag_9x19mm_7n21_20",

	//Shotguns
	"CUP_5Rnd_B_Saiga12_Buck_00",
	"CUP_5Rnd_B_Saiga12_Slug",
	"CUP_12Rnd_B_Saiga12_Buck_00",
	"CUP_12Rnd_B_Saiga12_Slug",
	"CUP_8Rnd_12Gauge_Pellets_No00_Buck",
	"CUP_8Rnd_12Gauge_Slug",
	
	"rhsusf_5Rnd_00Buck",
	"rhsusf_5Rnd_Slug",

	//============================================================
	//Loose ammo
	//============================================================
	"greenmag_ammo_46x30_basic_60Rnd",
	"greenmag_ammo_765x17_basic_60Rnd",
	"greenmag_ammo_9x39_ball_60Rnd",
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
	"CUP_arifle_Galil_556_black",
	
	"rhs_weap_m249_pip_ris",
	"rhs_weap_m249_pip_L_para",
	"rhs_weap_m249_light_S",
	"rhs_weap_m249_pip_S_para",
	"rhs_weap_m27iar",
	"rhs_weap_m27iar_grip",

	//============================================================
	//5.45x39mm
	//============================================================
	"CUP_arifle_RPK74_45",
	
	"rhs_weap_rpk74m",
	
	//============================================================
	//7.62x39mm
	//============================================================
	"CUP_arifle_RPK74",
	"CUP_arifle_RPK74_top_rail",
	"CUP_arifle_Sa58_Klec_frontris",
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
	
	"rhs_weap_pkm",
	"rhs_weap_pkp",

	//============================================================
	//LMG Accessories
	//============================================================	
	"cup_muzzle_snds_l85",
	
    "rhsusf_acc_elcan",
    "rhsusf_acc_elcan_ard"
];

private _itemWeaponSFAR = 
[
	//============================================================
	//LMGs
	//============================================================
	
	//============================================================
	//LMG Accessories
	//============================================================	
	"muzzle_snds_h_mg_blk_f",
	"muzzle_snds_93mmg",
	"muzzle_snds_93mmg_tan",
	"muzzle_snds_338_black",
	"muzzle_snds_338_sand",
	"CUP_100Rnd_556x45_BetaCMag_ar15",
	"CUP_100Rnd_TE1__Yellow_Tracer_556x45_BetaCMag_ar15"
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
	//Loose belts
	"greenmag_beltlinked_762x51_basic_200",
	"greenmag_beltlinked_762x51_basic_100",
	"greenmag_beltlinked_762x51_basic_50",
	
	//============================================================
	//7.62x54mmR
	//============================================================
	//Boxes
	"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M",
	
	//Loose belts
	"greenmag_beltlinked_762x54_basic_200",
	"greenmag_beltlinked_762x54_basic_100",
	"greenmag_beltlinked_762x54_basic_50",
	
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
	"CUP_arifle_HK417_20",
	
	"rhs_weap_m14ebrri",
	"rhs_weap_sr25",
	"rhs_weap_sr25_ec",

	//7.62x54mmR
	"CUP_srifle_SVD",
	"CUP_srifle_SVD_top_rail",
	
	"rhs_weap_svds",
	"rhs_weap_svdp",
	
	"ace_csw_m220CarryTripod", // can deploy bipod on these
	"ace_csw_spg9CarryTripod",

	//============================================================
	//Magazines
	//============================================================
	//7.62x51mm
	"ace_20rnd_762x51_m118lr_mag",
	"ace_20rnd_762x51_mag_tracer",
	
	"rhsusf_20Rnd_762x51_SR25_m993_Mag",

	//7.62x54mmR
	"ace_10rnd_762x54_tracer_mag",
	
	"rhs_10Rnd_762x54mmR_7N14",

	//============================================================
	//Accessories
	//============================================================
	//~1-4x 'combat sights'
	"optic_DMS",
	"optic_DMS_weathered_F",
	
	"cup_optic_acog",
	"cup_optic_acog_ta01nsn_rmr_black",
	"rhsusf_acc_acog_rmr",
	
	"CUP_optic_Elcan_SpecterDR_RMR_black",
	"cup_optic_elcan_specterdr_kf_black",
	
	"rhsusf_acc_su230",
	"rhsusf_acc_su230_mrds",
	"rhsusf_acc_su230a", //zeroed for 7.62
	"rhsusf_acc_su230a_mrds", //same but with a red dot
	
	//dovetail mounted
	"CUP_optic_PSO_1",
	"cup_optic_pso_1_1_open",
	
	"rhs_acc_pso1m21",

	// muzzle devices
	"rhsusf_acc_sr25s",
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
	"CUP_srifle_M24_blk",

	"rhs_weap_m24sws",
	"rhs_weap_m40a5",
	"rhs_weap_t5000",
	"RHS_weap_m107"
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
	
	"rhsusf_acc_premier_mrds",
	"rhsusf_acc_leupoldmk4_2",
	"rhsusf_acc_nxs_3515x50f1_md_sun",	
	
	"ace_5rnd_127x99_api_mag",
	
	"CUP_10Rnd_127x99_M107",
	"CUP_5Rnd_127x99_as50_M",
	"CUP_10Rnd_762x51_CZ750",
	"CUP_5Rnd_86x70_L115A1",
	"CUP_5Rnd_127x108_KSVK_M",
	"CUP_5Rnd_762x51_M24",
	
	"rhsusf_5Rnd_762x51_m118_special_Mag",
	"rhsusf_5Rnd_762x51_m993_Mag",
	"rhsusf_10Rnd_762x51_m118_special_Mag",
	"rhsusf_10Rnd_762x51_m993_Mag",
	"rhs_5Rnd_338lapua_t5000",
	
	"CUP_muzzle_snds_AWM",
	"CUP_optic_PSO_3_open",
	"CUP_muzzle_mfsup_Suppressor_M107_Black",
	"CUP_Mxx_camo_half",
	"muzzle_snds_B",
	
	"rhsusf_acc_m24_silencer_black",

	"rhsusf_weap_MP7A2_folded",
	"rhsusf_acc_rotex_mp7",
	
	"CUP_40Rnd_46x30_MP7",
	
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
	"arifle_TRG21_GL_F",
	
	"CUP_arifle_ACR_EGLM_blk_556",
	
	"CUP_arifle_M16A4_GL",
	
	"CUP_arifle_mk18_m203_black",
	
	"CUP_arifle_G36A3_AG36",
	"CUP_arifle_G36K_RIS_AG36",
	
	"CUP_arifle_XM8_Carbine_GL",
	
	"CUP_arifle_HK416_AGL_Black",
	
	"CUP_arifle_AK101_GL",
	"CUP_arifle_AK101_GL_railed",	
	"CUP_arifle_AK19_GP34_bicolor",
	
	"rhs_weap_hk416d145_m320",
	
	"rhs_weap_m16a4_carryhandle_M203",
	
	"rhs_weap_mk18_m320",
	
	"rhs_weap_vhsd2_bg",
	"rhs_weap_vhsd2_bg_ct15x",

	//5.45x39mm
	"CUP_arifle_AK74M_GL",
	"CUP_arifle_AK74M_GL_railed",
	"CUP_arifle_AK12_GP34_bicolor",
	
	"rhs_weap_ak74m_gp25",

	//7.62x39mm
	"CUP_arifle_AKM_GL",
	"CUP_arifle_AKM_GL_top_rail",
	"CUP_arifle_AK15_GP34_bicolor",
	"CUP_arifle_OTS14_GROZA_762_GL",
	"CUP_arifle_Sa58RIS2_gl",
	
	"rhs_weap_ak103_gp25",

	//7.62x51mm
	"CUP_arifle_DSA_SA58_OSW_M203",
	
	// Fancy mags
	"CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_Tan_M",
	"CUP_30Rnd_TE1_Green_Tracer_762x39_AK15_Tan_M",
	"CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",

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
	"CUP_arifle_AK109_GL_railed",
	
	"rhs_weap_ak74mr_gp25",
	"rhs_weap_M320",
	"rhs_mag_m4009",
	"rhs_VG40SZ",
	"rhs_VG40MD"
];

private _itemMedic =
[
	//BIS
	"B_Carryall_oucamo",
	"rhs_tortila_black"
];

private _itemWeaponLAT = 
[
	"CUP_launch_M136", // Better than RHS HEAT
	"CUP_launch_M72A6",
	"CUP_launch_RPG26",
	
	"rhs_weap_rpg75", // Not much better than m72s in the configs
	"rhs_weap_M136", // HEAT
	"rhs_weap_M136_hedp", // Not great for AT
	"rhs_weap_M136_hp", // High Penetration
	
	"rhs_acc_at4_handler",

	"rhs_weap_rpg7", // reloadable

	//Launchers in Backpack
	"CUP_launch_M136_Loaded",
	"CUP_launch_M72A6_Loaded",
	"CUP_M72A6_M",
	"CUP_launch_RPG26_Loaded"
];

private _itemAmmoLAT = 
[
	//RPG Rockets (Uncomment desired rockets)
	
	// "rhs_rpg7_OG7V_mag",
	// "rhs_rpg7_PG7V_mag",
	 "rhs_rpg7_PG7VL_mag", // High pen
	 "rhs_rpg7_PG7VM_mag"//, // 
	// "rhs_rpg7_PG7VR_mag", // Very High Pen Tandem
	// "rhs_rpg7_PG7VS_mag", // Between VM and VL, ~AT4 HEAT
	// "rhs_rpg7_TBG7V_mag",
	// "rhs_rpg7_type69_airburst_mag"
];

private _itemWeaponMAT =
[
	"launch_MRAWS_green_F"
];

private _itemAmmoMAT =
[
	"MRAWS_HEAT_F",
	"MRAWS_HEAT55_F",
	"MRAWS_HE_F"
];

private _itemWeaponHAT =
[
	"launch_I_Titan_short_F"
];

private _itemAmmoHAT =
[
	"Titan_AT",
	"Rangefinder",
	"ACE_Vector"
];

private _itemWeaponMMG =
[  
    "CUP_lmg_Mk48",
    "CUP_lmg_M60",
  
    "rhs_weap_m240G",
    "rhs_weap_m240B",  
  
    "cup_optic_hensoldtzo",
    "cup_optic_acog2",
	
	"rhsusf_acc_su230",
	"rhsusf_acc_su230_mrds",
    "rhsusf_acc_su230a",
	"rhsusf_acc_su230a_mrds"
];

private _itemWeaponMMGAmmo = 
[
	"150Rnd_762x51_Box_Tracer",
	"130Rnd_338_Mag",
	"mjb_130Rnd_338_Mag_trc_ylw",
	"150Rnd_93x64_Mag",
	"mjb_150Rnd_93x64_Mag_trc_ylw",
	"greenmag_beltlinked_338_basic_200",
	"greenmag_beltlinked_338_basic_100",
	"greenmag_beltlinked_338_basic_50",
	"greenmag_beltlinked_93x64_basic_200",
	"greenmag_beltlinked_93x64_basic_100",
	"greenmag_beltlinked_93x64_basic_50",
	"Rangefinder",
	"ACE_Vector",
	"ace_csw_m220CarryTripod", // can deploy bipod on these
	"ace_csw_spg9CarryTripod"
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
	"rhsusf_plateframe_rifleman",
	"rhsusf_plateframe_machinegunner",
	"rhsusf_plateframe_medic",
	"rhsusf_plateframe_teamleader",
	"rhsusf_mbav_mg",

	//Weapons
	"CUP_arifle_AK107_railed",
	"CUP_arifle_AK108_railed",
	"CUP_arifle_AK109_railed",
	"CUP_arifle_AK12_AFG_bicolor",
	"CUP_arifle_AK15_VG_bicolor",
	"CUP_arifle_AK19_bicolor",
	"CUP_smg_MP5SD6",
	"CUP_sgun_AA12",
		
	"rhs_weap_ak74mr",
	"rhs_weap_asval_grip",
	"rhs_20rnd_9x39mm_SP6",	
	
	"CUP_20Rnd_B_AA12_Buck_00",
	"CUP_20Rnd_B_AA12_Slug",
	"CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
	
	"rhs_weap_6p53",
	"rhs_18rnd_9x21mm_7BT3",
	"rhs_18rnd_9x21mm_7N29",

	//Attachments
	"cup_acc_flashlight_mp5sd",
		
	// SF Drip
	"G_Bandanna_aviator",
	"G_Bandanna_blk",
	"G_aviator",
	"rhsusf_shemagh_gogg_tan",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_oakley_goggles_blk",
	"rhsusf_shemagh_tan",
	"rhsusf_shemagh2_tan"
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
	"Rangefinder",
	"ACE_Vector",
	
	"rhs_charge_sb3kg_mag",
	"rhs_charge_tnt_x2_mag",
	"rhs_tr8_periscope",
	"rhsusf_bino_leopold_mk4",

	//Equipment
	"CUP_V_MBSS_PACA_Tan",
	"CUP_V_MBSS_PACA_CB",
	"CUP_V_MBSS_PACA_RGR",
	"CUP_V_MBSS_PACA_Black",
	"CUP_V_MBSS_PACA_Green",
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
	"ACE_Vector",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"ACE_MapTools",
	"NVGoggles",
	"NVGoggles_OPFOR",
	"rhsgref_6b23_khaki",
    "rhsusf_mbav_mg",
    "rhsusf_oakley_goggles_blk"
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
	"ACE_Vector",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"ACE_MapTools",
	"NVGoggles",
	"NVGoggles_OPFOR",
	"G_Bandanna_aviator",
	"G_aviator",
    "rhsusf_mbav_light",
	"rhsusf_mbav_mg"
];

private _itemAirCrew =
[
	"muzzle_snds_l",
	"U_I_pilotCoveralls",
	"WU_O_PilotCoveralls",
	"ACE_IR_Strobe_Item",
	"greenmag_item_speedloader",
	"ACRE_PRC148",
	"ACE_Chemlight_UltraHiOrange",
	"SmokeShellOrange",
	"H_PilotHelmetFighter_B",
	"Rangefinder",
	"ACE_Vector",
	"ItemMap",
	"ItemGPS",
	"ItemCompass",
	"ItemWatch",
	"ACE_MapTools",
	"G_Bandanna_aviator",
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
private _hasMarksmen = 332350 in _ownedDLCs;

if (_hasApex) then {
	_itemEquipment append [
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
	_itemEquipment append [		
		"U_O_R_Gorka_01_black_F",		
		"G_Blindfold_01_black_F",		
		"G_Blindfold_01_white_F"		
	];
	
	_itemLeaderEquipment append [
		"H_Beret_EAF_01_F"
	];
	
	_itemAirCrew append [
		"U_I_E_Uniform_01_coveralls_F"
	];
};

if (_hasMarksmen) then {
        _itemWeaponMMG append [
                "MMG_01_tan_F",
                "MMG_02_black_F",
                "MMG_02_sand_F"
        ];
};

//Add Existing Player Items
waitUntil { !isNull player }; // should prevent FAKs/Medikits from adding when ACE enabled.
private _exWeap = weaponsItems player; // Weapons, attachments, loaded mags/ub
for "_y" from 0 to (count _exWeap - 1) do {
  {
    if (count _x == 2) then { _itemEquipment pushBackUnique (_x # 0);}
	else { _itemEquipment pushBackUnique _x;};
  } forEach (_exWeap # _y);
};
  
{
    _itemEquipment pushBackUnique _x;
} forEach (assignedItems player + itemsWithMagazines player + [uniform player, vest player, backpack player, headgear player]); // All other equipment

private _tarkovuniforms = ["Tarkov_Uniforms_49"]; // most cursed is not cursed
private _whiteTexBugged = [55,56,58,59,61,62,63,64,65,68,71,72]; // bugged shirts
for [{_i = 2}, {_i < 623}, {_i = _i + 24}] do // skips Beltstaff pants
{ for "_j" from (_i) to (_i + 22) do 
  { if ((_whiteTexBugged findIf {_j == _x}) == -1) then {
    _tarkovuniforms pushback ("Tarkov_Uniforms_" + str _j); }; };
};
for "_i" from (1) to (49) do {  _tarkovuniforms pushback ("Tarkov_Uniforms_Scavs_" + str _i); };

//Match unitrole name with the classnames in loadout.
switch (true) do 
{
	case (_unitRole == "ar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponAR + _itemWeaponMG + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "aar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole in _leaderRole) :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemSpecial + _itemMod + _itemReflexSight +  _itemWeaponGL + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "r") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "cls") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemMedic)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "mat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponMAT + _itemMod + _itemReflexSight +  _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "amat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "lat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
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
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponGL + _itemWeaponSFSL + _itemWeaponCQB + _itemSpecial + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemPackMedium + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfmed") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfmat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemWeaponMAT + _itemAmmoMAT + _itemPackMedium + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "sfar") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponAR + _itemWeaponARAmmo + _itemWeaponSFAR + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackMedium + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
	case (_unitRole == "ceng") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemEngineer + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
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
		[arsenal, (_itemEquipment + _itemFacewear + _itemWeaponHAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "ahat") :
	{
		[arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "mmg") :
	{
		[arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponAR + _itemWeaponMG + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
	};
		case (_unitRole == "ammg") :
	{
		[arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine+ _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMGAmmo  + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
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
