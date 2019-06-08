
local function GetGender(ply)
	return gPlayerModelGenders[ply:GetModel()] or GENDER_MALE
end

hook.Add("EntityTakeDamage", "PlayerHurtSounds", function(ply, dmg)
	-- hurt sounds
	ply.hurtsound_cooldown = ply.hurtsound_cooldown or 0
	if IsValid(ply) and ply:IsPlayer() and (ply.hurtsound_cooldown < CurTime() or ply:LastHitGroup() == HITGROUP_HEAD) and dmg:GetDamage() >= 1 then
		ply.hurtsound_cooldown = CurTime() + 1

		local hg = ply:LastHitGroup()
		local gen = GetGender(ply)

		-- this is the order of priority for where something is in the table
		local snd_table = gPlayerHurtSounds[hg] or gPlayerHurtSounds[gen][hg] or gPlayerHurtSounds[gen]["generic"]
		local snd = snd_table[math.random(1, #snd_table)]
		if ply.CurEmitSound then
			ply:StopSound(ply.CurEmitSound)
		end
		ply.CurEmitSound = snd
		ply:EmitSound(snd)
	end
end)
