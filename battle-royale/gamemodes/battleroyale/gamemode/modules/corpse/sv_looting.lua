
function GM:KeyRelease(ply, key)
	if IsValid(ply) and ply:IsPlayer() and key == IN_USE then
		local tr = util.TraceLine({
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 84,
			filter = ply,
			mask = MASK_SHOT
		})

		if tr.Hit and IsValid(tr.Entity) and tr.Entity.player_corpse then
			if tr.Entity.is_looted then
				ply:ChatPrint("There is nothing on this corpse.")
				return
			end
			tr.Entity.is_looted = true
			ply:SetArmor(math.min(ply:Armor() + tr.Entity.loot_armor))
			for k, v in pairs(tr.Entity.loot_weapons) do
				ply:Give(v)
			end
			for k, v in pairs(tr.Entity.loot_ammo) do
				ply:GiveAmmo(v, k)
			end
			if tr.Entity.loot_resources > 0 then
				ply:GiveResources(tr.Entity.loot_resources)
			end
		end
	end
end
