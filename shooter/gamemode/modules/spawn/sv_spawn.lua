
function GM:PlayerSpawn(ply)
	ply:UnSpectate()
	ply:SetupHands()

	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply, "Spawn")
end

function GM:PlayerDeathThink(ply)
	return IsRoundState(ROUND_PREPARING)
end
