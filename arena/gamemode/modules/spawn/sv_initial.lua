
function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_arena")
	ply:SetTeam(TEAM_ARENA)
	ply:Spawn()
end
