function GM:CreateTeams()
	TEAM_PRISONER = 1
	team.SetUp(TEAM_PRISONER, "Prisoners", Color(255, 150, 0))
	team.SetSpawnPoint(TEAM_PRISONER, "info_terrorist")

	TEAM_GUARD = 2
	team.SetUp(TEAM_GUARD, "Guards", Color(0, 0, 255))
	team.SetSpawnPoint(TEAM_GUARD, "info_counterterrorist")

	TEAM_CRIMINAL = 3
	team.SetUp(TEAM_CRIMINAL, "Crininals", Color(255, 0, 0))
	team.SetSpawnPoint(TEAM_CRIMINAL, "info_player_start")

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
