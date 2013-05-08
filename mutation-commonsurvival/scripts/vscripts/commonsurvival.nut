MutationOptions <- {
	CommonLimit = 5
	MobMinSize  = 50
	MobMaxSize  = 300

	// Disable all specials
	ProhibitBosses = true
	TotalSpecials  = 0
	MaxSpecials    = 0
	WitchLimit     = 0
	TankLimit      = 0
	BoomerLimit    = 0
	ChargerLimit   = 0
	HunterLimit    = 0
	JockeyLimit    = 0
	SpitterLimit   = 0
	SmokerLimit    = 0
}

last_time <- -1
function Update() {
	if (last_time < Time() - 1) {
		DirectorScript.DirectorOptions.CommonLimit += 1;
		last_time = Time();
	}
}
