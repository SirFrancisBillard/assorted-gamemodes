function GM:CreateTeams()
	TEAM_BATTLEROYALE = 1
	team.SetUp(TEAM_BATTLEROYALE, "Players", Color(255, 150, 0))
	team.SetClass(TEAM_BATTLEROYALE, "player_battleroyale")

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
