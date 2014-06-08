sicount <- 0

function OnGameEvent_player_spawn(event) {
	local player = GetPlayerFromUserID(event.userid);
	if (player.IsSurvivor()) return;
	sicount += 1;
	if (sicount % 2 == 1) {
		DirectorScript.DirectorOptions.MaxSpecials += 1;
		ZSpawn({
			type = player.GetZombieType()
			pos  = player.GetOrigin()
			ang  = player.GetAngles()
		});
		DirectorScript.DirectorOptions.MaxSpecials -= 1;
	}
}