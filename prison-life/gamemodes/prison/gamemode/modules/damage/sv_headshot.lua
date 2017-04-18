local HeadshotSound = Sound("Player.Headshot")

function GM:EntityTakeDamage(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:IsBulletDamage() and ent:LastHitGroup() == HITGROUP_HEAD then
		ent:EmitSound(HeadshotSound)
	end
end
