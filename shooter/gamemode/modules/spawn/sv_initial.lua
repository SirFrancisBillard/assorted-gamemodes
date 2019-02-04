function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_prisoner")
	ply:SetTeam(TEAM_PRISONER)
	ply:Spawn()

	ply:ConCommand("gm_showteam")
end
