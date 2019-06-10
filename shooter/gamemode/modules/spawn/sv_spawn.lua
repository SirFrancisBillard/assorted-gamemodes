
function GM:PlayerSpawn(ply)
	ply:UnSpectate()
	ply:SetupHands()

	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply, "Spawn")

	ply:StopAllLuaAnimations()

	if IsRoundState(ROUND_WAITING) then
		ply:Give("shooter_revolver")
		ply:GiveAmmo(9999, "pistol")
	end
end

function GM:PlayerDeathThink(ply)
	if IsRoundState(ROUND_PREPARING) or IsRoundState(ROUND_WAITING) then
		ply:Spawn()
	end
end
