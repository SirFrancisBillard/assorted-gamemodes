GM.Name = "Prion Life RP"
GM.Author = "Sir Francis Billard"
GM.Email = "bgambla@muslim.kz"
GM.Website = "xdmemes.co.uk"

DeriveGamemode("base")

include("player_class/player_prisonbase.lua")

include("player_class/player_prisoner.lua")
include("player_class/player_guard.lua")
include("player_class/player_criminal.lua")

function GM:Initialize()
	self.BaseClass.Initialize(self)

	timer.Create("PrisonLife.RegainStamina", 5, 0, function()
		for k, v in pairs(player.GetAll()) do
			v:SetStamina(math.min(v:GetStamina() + 10, 100))
		end
	end)
end

function GM:SetupMove(ply, mv, cmd)
	self.BaseClass.SetupMove(self)

	local jumping = bit.band(move:GetButtons(), IN_JUMP) ~= 0
	if jumping and ply:GetStamina() < 10 then
		ply:ChatPrint("Not enough stamina to jump!")
		mv:SetUpSpeed(0)
	elseif jumping then
		ply:SetStamina(math.max(ply:GetStamina() - 10, 0))
	end
end
