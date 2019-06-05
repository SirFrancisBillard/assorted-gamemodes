function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_citizen")
	ply:SetTeam(TEAM_CIVILIANS)
	ply:Spawn()
end
