/*
	*Example Loadout for players
	*This is an example loadout made to use as a template for creating loadouts.
	*Faction: Example Russian Forces (EMR Flora)
*/

// Weaponless Baseclass
class baseMan 
{
	displayName = "Unarmed";
	// All Randomized. Use LIST_X("className") for multiple items in an array. 
	uniform[] = 
	{
		LIST_9("rhs_uniform_emr_patchless"),
		//No Commas at the end of Array
		"rhs_uniform_gorka_r_g"
	};
	vest[] = 
	{
		"rhs_6b23_6sh116",
		"rhs_6b23_6sh116_vog",
		"rhs_6b23_digi_6sh92",
		"rhs_6b23_digi_6sh92_headset",
		"rhs_6b23_digi_6sh92_radio",
		"rhs_6b23_digi_6sh92_spetsnaz",
		"rhs_6b23_digi_6sh92_spetsnaz2",
		"rhs_6b23_digi_6sh92_vog",
		"rhs_6b23_digi_6sh92_vog_headset",
		"rhs_6b23_digi_6sh92_Vog_radio_spetsnaz",
		"rhs_6b23_digi_6sh92_vog_spetsnaz"
	};
	backpack[] = 
	{
		LIST_9(""),
		"rhs_assault_umbts"
	};
	headgear[] = 
	{
		LIST_2("rhs_6b27m_digi"),
		LIST_2("rhs_6b47"),
		LIST_2("rhs_6b7_1m"),
		LIST_2("rhs_6b7_1m_emr"),
		"rhs_6b27m_digi_ess",
		"rhs_6b47_ess",
		"rhs_6b7_1m_ess",
		"rhs_6b7_1m_emr_ess"
	};
	goggles[] = {"default"};
	hmd[] = {};
	// Leave empty to not change faces and Insignias -> example: faces[] = {};
	faces[] = {"faceset:african", "faceset:caucasian"};
	insignias[] = {"111thID"};
	
	//All Randomized. Add Primary Weapon and attachments.
	//Leave Empty to remove all. {"Default"} for using original items the character start with.
	primaryWeapon[] = {};
	scope[] = {};
	bipod[] = {};
	attachment[] = {};
	silencer[] = {};
	
	// *WARNING* secondaryAttachments[] arrays are NOT randomized.
	secondaryWeapon[] = {};
	secondaryAttachments[] = {};
	sidearmWeapon[] = {};
	sidearmAttachments[] = {};
	
	// These are added to the uniform or vest first - overflow goes to backpack if there's any.
	magazines[] = {};
	items[] = 
	{
		LIST_2("ACE_fieldDressing"),
		LIST_2("ACE_packingBandage"),
		LIST_2("ACE_quikclot"),
		"ACE_tourniquet",
		"ACE_morphine",
		"ACE_splint"
	};
	
	// These are added directly into their respective slots
	linkedItems[] = 
	{
		"ItemWatch",
		"ItemMap",
		"ItemCompass"
	};
	
	// These are put directly into the backpack.
	backpackItems[] = {};
	
	// This is executed after the unit init is complete. Argument: _this = _unit.
	code = "";
};

//Since this a loadout used by enemies only - we don't need to define a bunch of different classes, roles such as AAR, Team Leader, and etc are redundant.
class r : baseMan
{
	displayName = "Rifleman";
	primaryWeapon[] = 
	{
		"rhs_weap_ak74m"
	};
	scope[] = 
	{
		"rhs_acc_1p63",
		"rhs_acc_ekp1",
		"rhs_acc_ekp8_02",
		"rhs_acc_pkas"
	};
	silencer[] = 
	{
		"rhs_acc_dtk"
	};
	magazines[] = 
	{
		"rhs_mag_rgd5",
		LIST_9("rhs_30Rnd_545x39_7N10_AK")
	};
};

class g : r 
{
	displayName = "Grenadier";
	primaryWeapon[] = 
	{
		"rhs_weap_ak74m_gp25"
	};
	magazines[] += 
	{
		LIST_5("rhs_VOG25"),
		LIST_2("rhs_GRD40_White")
	};
};

class mg : r
{
	displayName = "Machine Gunner";
	primaryWeapon[] = 
	{
		"rhs_weap_pkp"
	};
	silencer[] = {};
	magazines[] = 
	{
		LIST_3("rhs_100Rnd_762x54mmR")
	};
};

class rat : r 
{
	displayName = "Rifleman (LAT)";
	secondaryWeapon[] = 
	{
		"rhs_weap_rpg26"
	};
};

class rrpg : r
{
	displayName = "Rifleman (RPG)";
	backpack[] = 
	{
		"rhs_rpg_empty"
	};
	secondaryWeapon[] = 
	{
		"rhs_weap_rpg7"
	};
	secondaryAttachments[] = 
	{
		"rhs_acc_pgo7v3"
	};
	backpackItems[] = 
	{
		LIST_2("rhs_rpg7_PG7V_mag"),
		LIST_2("rhs_rpg7_PG7VL_mag")
	};
};