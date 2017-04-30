
hook.Add("EntityTakeDamage", "BattleRoyale.HurtSounds", function(ent, dmg)
	-- hurt sounds
	if IsValid(ply) and ply:IsPlayer() and ply.hurtsound_cooldown < CurTime() then
		ply.hurtsound_cooldown = CurTime() + 1

		local hg = ply:LastHitGroup()
		local gen = GetGender(ply)

		-- this is the order of priority for where something is in the table
		local snd_table = self.HurtSounds[hg] or self.HurtSounds[gen][hg] or self.HurtSounds[gen]["generic"]
		ply:EmitSound(snd_table[math.random(1, #snd_table)])
	end
end)
