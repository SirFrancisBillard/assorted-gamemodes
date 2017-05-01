
hook.Add("EntityTakeDamage", "BattleRoyale.PlayerBlood", function(ply, dmg)
	-- hurt sounds
	if IsValid(ply) and ply:IsPlayer() then
		local splat = EffectData()
		splat:SetOrigin(ply:GetShootPos())
		splat:SetScale(10)
		util.Effect("BloodImpact", splat)

		ply:EmitSound("physics/flesh/flesh_squishy_impact_hard" .. math.random(2, 4) .. ".wav")
	end
end)
