function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_battleroyale")
	ply:SetTeam(TEAM_BATTLEROYALE)
	ply:Spawn()
end
