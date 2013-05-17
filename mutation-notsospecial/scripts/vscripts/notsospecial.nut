DirectorOptions <- {
	ActiveChallenge = 1

	BoomerLimit  = 0
	ChargerLimit = 0
	HunterLimit  = 0
	JockeyLimit  = 0
	SpitterLimit = 0
	SmokerLimit  = 0

	requestedClass = 0

	function ConvertZombieClass( original ) {
		if ( original == 8 ) { // gotta love them tanks
			return 8;
		}
		return requestedClass;
	}
}

switch ( RandomInt( 0, 5 ) ) {
case 0:
	DirectorOptions.BoomerLimit = 16;
	DirectorOptions.requestedClass = 2;
	break;
case 1:
	DirectorOptions.ChargerLimit = 16;
	DirectorOptions.requestedClass = 6;
	break;
case 2:
	DirectorOptions.HunterLimit = 16;
	DirectorOptions.requestedClass = 3;
	break;
case 3:
	DirectorOptions.JockeyLimit = 16;
	DirectorOptions.requestedClass = 5;
	break;
case 4:
	DirectorOptions.SpitterLimit = 16;
	DirectorOptions.requestedClass = 4;
	break;
case 5:
	DirectorOptions.SmokerLimit = 16;
	DirectorOptions.requestedClass = 1;
	break;
}
