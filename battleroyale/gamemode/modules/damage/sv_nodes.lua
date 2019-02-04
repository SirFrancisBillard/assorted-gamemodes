
hook.Add("EntityTakeDamage", "BattleRoyale.NodeHarvesting", function(ent, dmg)
	local atk = dmg:GetAttacker()
	if IsValid(ent) and IsValid(atk) and atk:IsPlayer() and ent.IsHarvestableNode then
		local wep = atk:GetActiveWeapon()
		if IsValid(wep) and GAMEMODE.WeaponTypes.Melee[wep:GetClass()] then
			atk:GiveResources(25)
		end
	end
end)
