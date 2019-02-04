
function GM:ScalePlayerDamage(ply, hit, dmg)
	if hit == HITGROUP_HEAD then
		dmg:ScaleDamage(2)
	end

	if hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
		dmg:ScaleDamage(0.5)
	end
end
