
hook.Add("EntityTakeDamage", "Arena.PlayerBlood", function(ply, dmg)
	-- hurt sounds
	if IsValid(ply) and ply:IsPlayer() then
		local splat = EffectData()
		splat:SetOrigin(dmg:GetReportedPosition() or ply:GetShootPos())
		splat:SetScale(10)
		util.Effect("BloodImpact", splat)

		if dmg:IsBulletDamage() then
			ply:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
		end

		-- ply:ViewPunch(Angle(math.random(-40, 40), math.random(-40, 40), 0))
	end
end)
