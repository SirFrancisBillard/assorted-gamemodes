function GM:CreateTeams()
	TEAM_ARENA = 1
	team.SetUp(TEAM_ARENA, "Players", Color(255, 150, 0))
	team.SetClass(TEAM_ARENA, "player_arena")

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
