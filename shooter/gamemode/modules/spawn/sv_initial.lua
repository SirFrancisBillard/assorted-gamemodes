function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_citizen")
	ply:SetTeam(TEAM_CIVILIANS)
	ply:Spawn()

	if not IsRoundState(ROUND_PREPARING) then
		ply:ChatPrint("The round is already in progress.")
		ply:KillSilent()
	end

	ply:SetCanZoom(false) -- nice
end
