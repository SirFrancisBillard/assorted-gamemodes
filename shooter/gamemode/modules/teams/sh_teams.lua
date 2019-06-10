
TEAM_CIVILIANS = 1
TEAM_SHOOTERS = 2
TEAM_POLICE = 3

function GM:CreateTeams()
	team.SetUp(TEAM_CIVILIANS, "Civilians", Color(0, 255, 150), false)
	team.SetSpawnPoint(TEAM_CIVILIANS, {"info_player_terrorist"})
	team.SetClass(TEAM_CIVILIANS, "player_citizen")

	team.SetUp(TEAM_SHOOTERS, "Shooters", Color(255, 0, 0), false)
	team.SetSpawnPoint(TEAM_SHOOTERS, {"info_player_counterterrorist"})
	team.SetClass(TEAM_SHOOTERS, "player_shooter")

	team.SetUp(TEAM_POLICE, "Criminals", Color(0, 0, 255), false)
	team.SetSpawnPoint(TEAM_POLICE, {"info_player_counterterrorist"})
	team.SetClass(TEAM_POLICE, {"player_guard", "player_vigilante", "player_cop"})

	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end
