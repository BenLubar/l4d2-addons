MutationOptions <- {
	CommonLimit = 60

	MaxSpecials  = 8
	WitchLimit   = 0
	TankLimit    = 0
	BoomerLimit  = 8
	ChargerLimit = 0
	HunterLimit  = 0
	JockeyLimit  = 0
	SpitterLimit = 0
	SmokerLimit  = 0

	weaponsToConvert = {
		weapon_first_aid_kit = "weapon_pain_pills_spawn"
	}
	AllowPillConversion = 0

	function ConvertWeaponSpawn( classname ) {
		if (classname in weaponsToConvert) {
			return weaponsToConvert[classname];
		}
		return 0;
	}

	weaponsToAllow = {
		weapon_first_aid_kit = 1
		weapon_defibrillator = 1
		weapon_pain_pills    = 1
		weapon_adrenaline    = 1
		weapon_molotov       = 1
		weapon_pipe_bomb     = 1
		weapon_vomitjar      = 1
		weapon_gascan        = 1
		weapon_propanetank   = 1
		weapon_oxygentank    = 1
	}
	function AllowWeaponSpawn( classname ) {
		// For some reason, this anti-pattern is required for this to work.
		if (classname in weaponsToAllow) {
			return true;
		}
		return false;
	}

	DefaultItems = [
		"weapon_pistol_magnum",
	]
	function GetDefaultItem( idx ) {
		if ( idx < DefaultItems.len() ) {
			return DefaultItems[idx];
		}
		return 0;
	}
}
