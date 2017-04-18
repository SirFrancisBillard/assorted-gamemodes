function GM:PlayerSpawn(ply)
	ply:UnSpectate()
	pl:SetupHands()

	player_manager.OnPlayerSpawn(ply)
	player_manager.RunClass(ply, "Spawn")

	hook.Call("PlayerLoadout", GAMEMODE, ply)
	hook.Call("PlayerSetModel", GAMEMODE, ply)
end
