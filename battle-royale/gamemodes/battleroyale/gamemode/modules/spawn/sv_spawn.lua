function GM:PlayerSpawn(ply)
	ply:UnSpectate()
	ply:SetupHands()

	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply, "Spawn")

	hook.Call("PlayerLoadout", GAMEMODE, ply)
	hook.Call("PlayerSetModel", GAMEMODE, ply)

	local spawns = ents.FindByClass("ent_spawnpoint")
	if #spawns > 0 then
		local spawn = spawns[math.random(1, #spawns)]
		if IsValid(spawn) then
			ply:SetPos(spawn:GetPos() + Vector(0, 0, 16))
		end
	end

	player_manager.SetPlayerClass(ply, "player_battleroyale")

	ply:SetKillstreak(0)
	ply:SetResources(0)

	ply:SetupHands()
end
