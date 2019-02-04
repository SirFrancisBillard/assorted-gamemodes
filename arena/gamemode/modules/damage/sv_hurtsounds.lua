
local function GetGender(ply)
	return ply.model_table and ply.model_table.gender or GENDER_MALE
end

hook.Add("EntityTakeDamage", "Arena.HurtSounds", function(ply, dmg)
	-- hurt sounds
	ply.hurtsound_cooldown = ply.hurtsound_cooldown or 0
	if IsValid(ply) and ply:IsPlayer() and ply.hurtsound_cooldown < CurTime() then
		ply.hurtsound_cooldown = CurTime() + 1

		local hg = ply:LastHitGroup()
		local gen = GetGender(ply)

		-- this is the order of priority for where something is in the table
		local snd_table = GAMEMODE.HurtSounds[hg] or GAMEMODE.HurtSounds[gen][hg] or GAMEMODE.HurtSounds[gen]["generic"]
		ply:EmitSound(snd_table[math.random(1, #snd_table)])
	end
end)
