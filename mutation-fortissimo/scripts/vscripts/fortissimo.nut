DirectorOptions <- {
	ShouldAllowMobsWithTank     = true
	ShouldAllowSpecialsWithTank = true
	RelaxMaxInterval            = 1
	RelaxMinInterval            = 0
	WitchLimit                  = 0
}

if ( !Ent("trigger_finale") ) {
	GetNextStage <- function() {
		SessionOptions.ScriptedStageType = Director.HasAnySurvivorLeftSafeArea() ? STAGE_PANIC : STAGE_DELAY;
		SessionOptions.ScriptedStageValue = 1;
	}
}