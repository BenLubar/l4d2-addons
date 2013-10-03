// 5 consecutive headshots with 90+ health before the bonus gives 10 seconds of adrenaline. During the effect, no further
// headshots are counted. Each time the effect occurs, the duration decreases by 2 seconds, to a minimum of 1 second.
adrenaline_bonus <- []

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
	function RecalculateHealthDecay() {
		if ( Director.HasAnySurvivorLeftSafeArea() )
		{
			TempHealthDecayRate = 0.6;
		}
	}
}

function Update() {
	DirectorOptions.RecalculateHealthDecay();
}

function OnGameEvent_player_death( params ) {
	if ( params.victimname == "Witch" ) {
		death(params, 30);
	} else if ( params.victimname == "Tank" ) {
		death(params, 50);
	} else {
		death(params, 10);
	}
}

function OnGameEvent_infected_death( params ) {
	death(params, 5);
}

function death( params, health ) {
	if ( !params.headshot )
		return;

	local player = GetPlayerFromUserID(params.attacker);
	if (player && player.IsSurvivor()) {
		local player_adrenaline = null;
		foreach ( _, pa in adrenaline_bonus ) {
			if ( pa.id == params.attacker ) {
				player_adrenaline = pa;
				break;
			}
		}
		if ( player_adrenaline == null ) {
			player_adrenaline = {
				headshots = 0
				cooldown  = 0
				id        = params.attacker
				duration  = 10
			};
			adrenaline_bonus.push(player_adrenaline);
		}
		if ( player.GetHealthBuffer() >= 90 && player_adrenaline.cooldown < Time() ) {
			player_adrenaline.headshots++;
			if ( player_adrenaline.headshots >= 5 ) {
				player_adrenaline.headshots = 0;
				player_adrenaline.cooldown = Time() + player_adrenaline.duration;
				player.UseAdrenaline( player_adrenaline.duration );
				player_adrenaline.duration -= 2;
				if ( player_adrenaline.duration < 1 ) {
					player_adrenaline.duration = 1;
				}
			}
		} else {
			player_adrenaline.headshots = 0;
		}

		if ( player.GetHealthBuffer() < 50 ) {
			player.SetHealthBuffer(player.GetHealthBuffer() + health + (50 - player.GetHealthBuffer()) / 5);
		} else {
			player.SetHealthBuffer(player.GetHealthBuffer() + health);
		}
		if ( player.GetHealthBuffer() > 100 ) {
			player.SetHealthBuffer(100);
		}
	}
}