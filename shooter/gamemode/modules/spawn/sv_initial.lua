
function GM:PlayerInitialSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_citizen")
	ply:SetTeam(TEAM_CIVILIANS)
	ply:Spawn()

	if not IsRoundState(ROUND_PREPARING) and not IsRoundState(ROUND_WAITING) then
		ply:ChatPrint("The round is already in progress.")
		timer.Simple(0.1, function()
			if not IsValid(ply) or not ply:IsPlayer() then return end
			ply:KillSilent()
		end)
	end

	ply:Flashlight(false)
	ply:AllowFlashlight(false)
	ply:SetCanZoom(false)

	local fil = "shooterdata/inv_" .. ply:SteamID64() .. ".txt"
	if file.Exists(fil, "DATA") then
		ply:SetNWInt("inv", tonumber(file.Read(fil)))
	end

	local buxfil = "shooterdata/bux_" .. ply:SteamID64() .. ".txt"
	if file.Exists(buxfil, "DATA") then
		ply:SetNWInt("bux", tonumber(file.Read(buxfil)))
	end
end
