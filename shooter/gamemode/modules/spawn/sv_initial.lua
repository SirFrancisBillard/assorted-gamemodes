
function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_citizen")
	ply:SetTeam(TEAM_CIVILIANS)
	ply:Spawn()

	if not IsRoundState(ROUND_PREPARING) and not IsRoundState(ROUND_WAITING) then
		ply:ChatPrint("The round is already in progress.")
		ply:KillSilent()
	end

	ply:SetCanZoom(false) -- nice
end
