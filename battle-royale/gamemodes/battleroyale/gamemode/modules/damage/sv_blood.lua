
hook.Add("EntityTakeDamage", "BattleRoyale.PlayerBlood", function(ply, dmg)
	-- hurt sounds
	if IsValid(ply) and ply:IsPlayer() then
		if dmg:IsBulletDamage() then
			ply:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
		end

		ply:ViewPunch(Angle(math.random(-40, 40), math.random(-40, 40), 0))
	end
end)
