
function GM:PlayerSetHandsModel(ply, ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local info = player_manager.TranslatePlayerHands(simplemodel)
	if info then
		ent:SetModel(info.model)
		ent:SetSkin(info.skin)
		ent:SetBodyGroups(info.body)
	end
end
