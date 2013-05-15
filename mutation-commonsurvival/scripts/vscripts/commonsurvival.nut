MutationOptions <- {
	CommonLimit = 30
	MobMaxSize  = 30

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

function Update() {
	EntCall( "player", kill_tanks );
}

function kill_tanks( p ) {
	if ( !p.IsSurvivor() && p.GetHealth() > 100 ) {
		p.Kill();
	}
}

NewHUD <- {
	Fields = {
		perwave = {
			slot         = HUD_TICKER
			flags        = HUD_FLAG_NOBG | HUD_FLAG_POSTSTR
			name         = "perwave"
			staticstring = " infected per wave"
			datafunc     = @() g_ModeScript.DirectorOptions.CommonLimit
		}
	}
}

function OnGameEvent_survival_round_start( params ) {
	DirectorOptions.CommonLimit <- 15;
	DirectorOptions.MobMaxSize <- 15;
}

function OnGameEvent_create_panic_event( params ) {
	DirectorOptions.CommonLimit += 15;
	DirectorOptions.MaxMobSize += 15;
}

HUDSetLayout( NewHUD )
