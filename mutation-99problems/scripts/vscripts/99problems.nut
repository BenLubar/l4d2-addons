DirectorOptions <- {
	BoomerLimit  = 0
	SpitterLimit = 0
	HunterLimit  = 0
	ChargerLimit = 0
	SmokerLimit  = 0
	JockeyLimit  = 0
	TankLimit    = 0
	WitchLimit   = 100

	DefaultItems = [
		"weapon_pistol",
		"weapon_pistol",
		"weapon_shotgun_spas"
	]
	function GetDefaultItem( idx ) {
		if ( idx < DefaultItems.len() ) {
			return DefaultItems[idx];
		}
		return 0;
	}
}

function Update() {
	EntCall("infected", replace_with_witch);
}

function replace_with_witch(ent) {
	local witch = ZSpawn({
		type = ZOMBIE_WITCH
		pos  = ent.GetOrigin()
		ang  = ent.GetAngles()
	});
	ent.Kill();
}