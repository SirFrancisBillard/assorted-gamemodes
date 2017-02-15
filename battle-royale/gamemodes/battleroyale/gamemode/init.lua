AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

game.ConsoleCommand("sbox_weapons 0\n")
game.ConsoleCommand("sbox_godmode 0\n")
game.ConsoleCommand("sbox_noclip 0\n")

util.AddNetworkString("BR_OpenPerkMenu")
util.AddNetworkString("BR_SelectPerk")

function GM:PlayerSpawnObject()
	return ply:IsAdmin()
end

function GM:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_sandbox")
	ply:StripWeapons()
	ply:Give("weapon_fists") -- bare hands

	ply:SetNWInt("BR_Perk", PERK_NONE)
	ply.chose_perk = false

	net.Start("BR_OpenPerkMenu")
	net.Send(ply)
end

net.Receive("BR_SelectPerk", function(len, ply)
	local perk = net.ReadInt(5)
	if perk <= PERK_MAX and not ply.chose_perk then
		ply:SetNWInt("BR_Perk", perk)
	end
end)
