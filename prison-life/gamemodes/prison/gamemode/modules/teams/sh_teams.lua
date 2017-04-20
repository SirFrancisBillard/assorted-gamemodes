function GM:CreateTeams()
	TEAM_PRISONER = 1
	team.SetUp(TEAM_PRISONER, "Prisoners", Color(255, 150, 0))
	team.SetSpawnPoint(TEAM_PRISONER, "info_player_terrorist")
	team.SetClass(TEAM_PRISONER, "player_prisoner")

	TEAM_GUARD = 2
	team.SetUp(TEAM_GUARD, "Guards", Color(0, 0, 255))
	team.SetSpawnPoint(TEAM_GUARD, "info_player_counterterrorist")
	team.SetClass(TEAM_GUARD, "player_guard")

	TEAM_CRIMINAL = 3
	team.SetUp(TEAM_CRIMINAL, "Criminals", Color(255, 0, 0), false)
	team.SetSpawnPoint(TEAM_CRIMINAL, "info_player_start")
	team.SetClass(TEAM_CRIMINAL, "player_criminal")

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
