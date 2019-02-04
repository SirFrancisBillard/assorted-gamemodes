local HeadshotSound = Sound("Player.Headshot")

function GM:EntityTakeDamage(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() then
		local atk = dmg:GetAttacker()
		if IsValid(atk) and atk:IsPlayer() and ent:Team() == atk:Team() and not dmg:GetInflictor().YupWeAreFists then
			dmg:ScaleDamage(0)
			return
		end
		if dmg:IsBulletDamage() and ent:LastHitGroup() == HITGROUP_HEAD then
			ent:EmitSound(HeadshotSound)
		end
	end
end
