MutationOptions <- {
	weaponsToRemove = {
		weapon_first_aid_kit = 1
		weapon_pain_pills    = 1
		weapon_adrenaline    = 1
	}
	function AllowWeaponSpawn( classname ) {
		// For some reason, this anti-pattern is required for this to work.
		if (classname in weaponsToRemove) {
			return false;
		}
		return true;
	}

	AllowPillConversion = 0
	SurvivorMaxIncapacitatedCount = 0

	MaxSpecials = 10
	SpecialRespawnInterval = 15
};

last_heal <- 0;
function Update() {
	if (last_heal < Time() - 1) {
		EntCall("player", @(ent) ent.SetHealth(maybe_increment(ent.GetHealth())));
		last_heal = Time();
	}
}

function maybe_increment(health) {
	health += 1;
	if (health > 100) {
		health = 100;
	}
	return health;
}
