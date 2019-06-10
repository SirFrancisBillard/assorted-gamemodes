
local AlliedTeams = {
	[TEAM_CIVILIANS] = {[TEAM_POLICE] = true},
	[TEAM_POLICE] = {[TEAM_CIVILIANS] = true},
}

local DamagePerBuck = 20

function GM:EntityTakeDamage(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() then
		local atk = dmg:GetAttacker()
		local gameactive = IsRoundState(ROUND_INPROGRESS) or IsRoundState(ROUND_PREPARING)
		if IsValid(atk) and atk:IsPlayer() and gameactive then
			if ent:Team() == atk:Team() then
				dmg:ScaleDamage(0)
				return
			elseif AlliedTeams[atk:Team()] ~= nil and AlliedTeams[atk:Team()][ent:Team()] then
				dmg:ScaleDamage(0.3)
				return
			end
			if atk.DamageDealt == nil then atk.DamageDealt = 0 end
			atk.DamageDealt = atk.DamageDealt + dmg:GetDamage()
			if atk.DamageDealt >= DamagePerBuck then
				atk:AddBux(math.floor(atk.DamageDealt / DamagePerBuck))
				atk.DamageDealt = atk.DamageDealt % DamagePerBuck
			end
		end
		if ent:GetSpecialClass() == CLASS_EMO then
			local amt = dmg:GetDamage()
			local prot = ent:GetNWInt("emo_charge", 0)
			if prot > 0 then
				ent:EmitSound("garrysmod/save_load3.wav", 75, 60)
			end
			if amt > prot then
				dmg:SetDamage(amt - prot)
				ent:SetNWInt("emo_charge", 0)
			else
				dmg:SetDamage(0)
				ent:SetNWInt("emo_charge", prot - amt)
			end
		end
		if dmg:IsBulletDamage() then
			local spat = EffectData()
			spat:SetOrigin(dmg:GetDamagePosition())
			util.Effect("blood_spatter", spat, true)
		end
	end
end

function GM:PlayerDeathSound() return true end
