MutationOptions <- {
	CommonLimit  = 0
	MaxSpecials  = 2
	WitchLimit   = 0
	TankLimit    = 0
	BoomerLimit  = 0
	ChargerLimit = 1
	HunterLimit  = 1
	JockeyLimit  = 1
	SmokerLimit  = 1
	SpitterLimit = 1

	SpecialRespawnInterval = 1

	AllowPillConversion = 0

	weaponsToConvert = {
		// Convert non-useful things into slightly more useful things
		weapon_pipe_bomb      = "weapon_molotov_spawn"
		weapon_vomitjar       = "weapon_molotov_spawn"
                weapon_smg            = "weapon_rifle_spawn"
                weapon_pumpshotgun    = "weapon_autoshotgun_spawn"
                weapon_smg_silenced   = "weapon_rifle_desert_spawn"
                weapon_shotgun_chrome = "weapon_shotgun_spas_spawn"
	}
	function ConvertWeaponSpawn( classname ) {
		if (classname in weaponsToConvert) {
			return weaponsToConvert[classname];
		}
		return 0;
	}

	weaponsToRemove = {
		weapon_first_aid_kit = 0
		weapon_pain_pills    = 0
		weapon_adrenaline    = 0
	}
	function AllowWeaponSpawn( classname ) {
		if (classname in weaponsToRemove) {
			return false;
		}
		return true;
	}

	DefaultItems = [
		"weapon_pistol",
		"weapon_defibrillator",
	]
	function GetDefaultItem( idx ) {
		if ( idx < DefaultItems.len() ) {
			return DefaultItems[idx];
		}
		return 0;
	}
}

function Update() {
	EntCall("player", check_health);
}

function check_health(p) {
	if (p.IsIncapacitated()) {
		return;
	}
	if (p.GetHealth() > 5) {
		p.SetHealthBuffer(p.GetHealth() + p.GetHealthBuffer() - 5);
		p.SetHealth(5);
	}
	if (p.GetHealthBuffer() > 20) {
		p.SetHealthBuffer(20);
	}
}
