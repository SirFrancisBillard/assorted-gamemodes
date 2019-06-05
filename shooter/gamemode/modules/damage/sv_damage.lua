local HeadshotSound = Sound("Player.Headshot")

function GM:EntityTakeDamage(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() then
		local atk = dmg:GetAttacker()
		if IsValid(atk) and atk:IsPlayer() and (ent:Team() == atk:Team() and IsRoundState(ROUND_INPROGRESS)) then
			dmg:ScaleDamage(0)
			return
		end
		if dmg:IsBulletDamage() and ent:LastHitGroup() == HITGROUP_HEAD then
			ent:EmitSound(HeadshotSound)
		end
		if ent:GetSpecialClass() == CLASS_EMO then
			local amt = dmg:GetDamage()
			local prot = ent:GetNWInt("emo_charge")
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
	end
end

function GM:PlayerDeathSound() return true end
