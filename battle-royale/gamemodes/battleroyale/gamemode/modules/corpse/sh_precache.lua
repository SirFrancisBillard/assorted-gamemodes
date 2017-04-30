
hook.Add("Initialize", "BattleRoyale.PrecacheCorpses", function()
	for k, v in pairs(GAMEMODE.PlayerModels) do
		for k2, v2 in pairs(v) do
			if k ~= "gender" then
				util.PrecacheModel(v)
			end
		end
	end
end)
