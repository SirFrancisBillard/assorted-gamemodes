function GM:CreateTeams()
	TEAM_CIVILIANS = 1
	team.SetUp(TEAM_CIVILIANS, "Civilians", Color(0, 255, 150), false)
	team.SetSpawnPoint(TEAM_CIVILIANS, {"info_player_terrorist"})
	team.SetClass(TEAM_CIVILIANS, "player_citizen")

	TEAM_SHOOTERS = 2
	team.SetUp(TEAM_SHOOTERS, "Shooters", Color(255, 0, 0), false)
	team.SetSpawnPoint(TEAM_SHOOTERS, {"info_player_counterterrorist"})
	team.SetClass(TEAM_SHOOTERS, "player_shooter")

	TEAM_POLICE = 3
	team.SetUp(TEAM_POLICE, "Criminals", Color(0, 0, 255), false)
	team.SetSpawnPoint(TEAM_POLICE, {"info_player_counterterrorist"})
	team.SetClass(TEAM_POLICE, "player_cop")

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
