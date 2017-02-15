AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

game.ConsoleCommand("sbox_weapons 0\n")
game.ConsoleCommand("sbox_godmode 0\n")
game.ConsoleCommand("sbox_noclip 0\n")

function GM:PlayerSpawnObject()
	return ply:IsAdmin()
end

function GM:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_sandbox")
	ply:StripWeapons()
	ply:Give("weapon_fists") -- bare hands
end
