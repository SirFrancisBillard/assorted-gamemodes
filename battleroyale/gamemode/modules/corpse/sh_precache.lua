
local ExtraPrecache = {
	"models/Gibs/Fast_Zombie_Torso.mdl",
	"models/Gibs/Fast_Zombie_Legs.mdl",
	"models/Gibs/HGIBS.mdl",
	"models/Gibs/HGIBS_rib.mdl",
	"models/Gibs/HGIBS_scapula.mdl",
	"models/Gibs/HGIBS_spine.mdl"
}

hook.Add("Initialize", "BattleRoyale.PrecacheCorpses", function()
	for k, v in pairs(GAMEMODE.PlayerModels) do
		for k2, v2 in pairs(v) do
			if k ~= "gender" then
				util.PrecacheModel(v2)
			end
		end
	end

	for k, v in pairs(ExtraPrecache) do
		util.PrecacheModel(v)
	end
end)
