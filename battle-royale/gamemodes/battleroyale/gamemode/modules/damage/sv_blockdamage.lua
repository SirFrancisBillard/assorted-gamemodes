local BreakSound = Sound("Block.Break")

hook.Add("EntityTakeDamage", "BattleRoyale.BlockDamage", function(ent, dmg)
	local atk = dmg:GetAttacker()
	-- block damage
	if IsValid(ply) and ply:GetNWBool("is_block", false) then
		local raw = dmg:GetDamage()
		if dmg:IsDamageType(DMG_BLAST) then
			raw = raw
		else
			raw = raw * 0.4
		end
		ply:SetNWInt("block_health", ply:GetNWInt("block_health", 500) - math.Round(raw))
		if ply:GetNWInt("block_health", 500) < 1 then
			ply:EmitSound(BreakSound)
			ply:Remove()
		end

		return
	end

	if IsValid(ply) and IsValid(atk) and atk:IsPlayer() and ply.IsHarvestableNode then
		local wep = atk:GetActiveWeapon()
		if IsValid(wep) and self.WeaponTypes.Melee[wep:GetClass()] then
			atk:GiveResources(25)
		end
	end
end)
