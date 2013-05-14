MutationOptions <- {
	MaxSpecials  = 8
	CommonLimit  = 0
	WitchLimit   = 0
	TankLimit    = 0
	BoomerLimit  = 4
	ChargerLimit = 0
	HunterLimit  = 0
	JockeyLimit  = 0
	SmokerLimit  = 0
	SpitterLimit = 0

	SpecialRespawnInterval = 15
}

who_is_it <- {}

want_panic <- false

function OnGameEvent_player_now_it( params ) {
	if ( params.by_boomer ) {
		who_is_it[params.userid] <- true;
		want_panic = true;
	}
}

function OnGameEvent_player_no_longer_it( params ) {
	who_is_it[params.userid] <- false;
}

function Update() {
	is_someone_it <- false;
	foreach ( it in who_is_it ) {
		if ( it ) {
			is_someone_it = true;
		}
	}

	if ( is_someone_it ) {
		DirectorOptions.CommonLimit  <- 45;
		DirectorOptions.WitchLimit   <- 1;
		DirectorOptions.TankLimit    <- 1;
		DirectorOptions.ChargerLimit <- 1;
		DirectorOptions.HunterLimit  <- 1;
		DirectorOptions.JockeyLimit  <- 1;
		DirectorOptions.SmokerLimit  <- 1;
		DirectorOptions.SpitterLimit <- 1;
	} else {
		DirectorOptions.CommonLimit  <- 0;
		DirectorOptions.WitchLimit   <- 0;
		DirectorOptions.TankLimit    <- 0;
		DirectorOptions.ChargerLimit <- 0;
		DirectorOptions.HunterLimit  <- 0;
		DirectorOptions.JockeyLimit  <- 0;
		DirectorOptions.SmokerLimit  <- 0;
		DirectorOptions.SpitterLimit <- 0;
	}

	if ( want_panic ) {
		EntFire("info_director", "PanicEvent", null);
		want_panic = false;
	}
}
