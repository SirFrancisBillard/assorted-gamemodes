
local HeadshotSound = Sound("Player.Headshot")

hook.Add("EntityTakeDamage", "Arena.HeadshotSound", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() then
		if dmg:IsBulletDamage() and ent:LastHitGroup() == HITGROUP_HEAD then
			ent:EmitSound(HeadshotSound)
		end
	end
end)
