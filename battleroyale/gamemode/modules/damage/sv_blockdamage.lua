
local BreakSound = Sound("Block.Break")

hook.Add("EntityTakeDamage", "BattleRoyale.BlockDamage", function(ent, dmg)
	local atk = dmg:GetAttacker()
	-- block damage
	if IsValid(ent) and ent:GetNWBool("is_block", false) then
		local raw = dmg:GetDamage()
		if dmg:IsDamageType(DMG_BLAST) then
			raw = raw
		else
			raw = raw * 0.1
		end
		ent:SetNWInt("block_health", ent:GetNWInt("block_health", 500) - math.Round(raw))
		if ent:GetNWInt("block_health", 500) < 1 then
			ent:EmitSound(BreakSound)
			ent:Remove()
		end

		return
	end
end)
