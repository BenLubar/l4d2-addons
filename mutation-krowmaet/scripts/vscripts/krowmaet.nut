MutationOptions <- {
	AllowPillConversion = 0
	cm_TempHealthOnly = true

	weaponsToRemove = {
		weapon_first_aid_kit = 1
		weapon_defibrillator = 1
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

	TempHealthDecayRate = 0.001
	lastTick = Time()
	function RecalculateHealthDecay() {
		if ( Director.HasAnySurvivorLeftSafeArea() ) {
			TempHealthDecayRate = 0.27;

			if ( lastTick < Time() - 1 ) {
				lastTick = Time();
				EntCall("player", function(player) {
					if ( !player.IsSurvivor() ) {
						return;
					}

					EntCall("player", function(other) {
						if ( other == player || !other.IsSurvivor() ) {
							player.SetHealthBuffer(player.GetHealthBuffer() + ((player.GetOrigin() - other.GetOrigin()).Length() / 1000));
						}
					});

					if ( player.GetHealthBuffer() > 100 ) {
						player.SetHealthBuffer( 100 );
					}
				});
			}
		}
	}
}

function Update() {
	DirectorOptions.RecalculateHealthDecay();
}