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
