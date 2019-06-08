
function GM:StartCommand(ply, cmd)
	if not ply:IsBot() or not ply:Alive() then return end

	cmd:ClearMovement()
	cmd:ClearButtons()

	if ply:Team() == TEAM_SHOOTERS then
		local nearest = nil
		for k, v in pairs(player.GetAll()) do
			if not IsValid(v) or not v:IsPlayer() or not v:Alive() or ply == v or v:Team() == TEAM_SHOOTERS then continue end
			if not nearest or ply:GetPos():DistToSqr(nearest:GetPos()) > ply:GetPos():DistToSqr(v:GetPos()) then
				nearest = v
			end
		end

		if not IsValid(nearest) then return end

		local wep1 = ply:GetWeapon("shooter_ak47")
		local wep2 = ply:GetWeapon("shooter_m3")
		if IsValid(wep1) then
			cmd:SelectWeapon(wep1)
		elseif IsValid(wep2) then
			cmd:SelectWeapon(wep2)
		end

		local livingcops = #team.GetPlayers(TEAM_POLICE)
		if not ply.SkillMod then ply.SkillMod = math.random(20, 30) end
		cmd:SetViewAngles(LerpAngle(FrameTime() * (ply.SkillMod + (2 * livingcops)), cmd:GetViewAngles(), (nearest:GetShootPos() - ply:GetShootPos()):GetNormalized():Angle()))

		local tr = ply:GetEyeTrace()
		if IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.Entity:Team() ~= TEAM_SHOOTERS then
			cmd:SetButtons(IN_ATTACK)
		else
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
		end

		cmd:SetForwardMove(ply:GetRunSpeed())
	elseif ply:Team() == TEAM_CIVILIANS then
		local scared = nil
		for k, v in pairs(ents.FindByClass("ent_pipebomb")) do
			if not IsValid(v) then return end
			if ply:GetPos():DistToSqr(v:GetPos()) < 202500 then
				scared = v
				break
			end
		end
		if not IsValid(scared) then
			for k, v in pairs(team.GetPlayers(TEAM_SHOOTERS)) do
				if not v:Alive() or v == ply then continue end
				if ply:GetPos():DistToSqr(v:GetPos()) < 360000 then
					scared = v
					break
				end
			end
		end

		if IsValid(scared) then -- run AI
			if ply.ShouldScream then
				ply.ShouldScream = nil
				RadialTaunt(ply, "danger")
			end
			cmd:SetButtons(IN_SPEED)
			ply.ShouldMove = true
			local desiredang = (scared:GetPos() - ply:GetShootPos()):GetNormalized():Angle()
			ply.DesiredYaw = ((desiredang.y + 360) % 360) - 180 -- away from the danger

			cmd:SetForwardMove(ply:GetRunSpeed()) -- run
		else -- wander AI
			ply.ShouldScream = true -- peace
			if not ply.NextBotWander then ply.NextBotWander = 0 end
			if CurTime() > ply.NextBotWander then
				ply.NextBotWander = CurTime() + math.Rand(1, 4) -- float rand

				local rand = math.random(5)
				if rand == 1 then -- go
					ply.ShouldMove = true
				elseif rand == 2 then -- stop
					ply.ShouldMove = false
				elseif rand == 3 then -- change direction
					ply.DesiredYaw = math.random(360) - 180
				elseif rand == 4 and math.random(3) == 1 then -- sometimes tell a joke
					RadialTaunt(ply, "joke")
				end
				-- 5 does nothing
			end

			if ply.ShouldMove then
				cmd:SetForwardMove(ply:GetWalkSpeed()) -- walk
			end
		end

		local curang = cmd:GetViewAngles()
		cmd:SetViewAngles(LerpAngle(FrameTime() * 12, curang, Angle(curang.p, ply.DesiredYaw, curang.r)))
	elseif ply:Team() == TEAM_POLICE then
		if not ply:HasWeapon("shooter_mp5") then
			ply:Give("shooter_mp5")
		end
		local wep = ply:GetWeapon("shooter_mp5")
		if IsValid(wep) then
			cmd:SelectWeapon(wep)
		end

		if not IsValid(ply.BotEnemy) then
			for k, v in pairs(team.GetPlayers(TEAM_SHOOTERS)) do
				if not v:Alive() or v == ply then continue end
				ply.BotEnemy = v
			end
		end

		if not IsValid(ply.BotEnemy) then return end

		local targetpos
		if ply.BotEnemy:IsPlayer() then
			targetpos = ply.BotEnemy:GetShootPos() - Vector(0, 0, 24)
		else
			targetpos = ply.BotEnemy:GetPos()
		end

		local desiredang = (targetpos - ply:GetShootPos()):GetNormalized():Angle()
		local copsrecentlykilled = 0 -- TODO
		if not ply.SkillMod then ply.SkillMod = math.random(10, 14) end
		cmd:SetViewAngles(LerpAngle(FrameTime() * (ply.SkillMod + (2 * copsrecentlykilled)), cmd:GetViewAngles(), desiredang))

		local tr = ply:GetEyeTrace()
		if IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.Entity:Team() == TEAM_SHOOTERS then
			ply.BotEnemy = tr.Entity
			cmd:SetButtons(IN_ATTACK)
		else
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
		end

		if not IsValid(ply.BotEnemy) or not ply.BotEnemy:Alive() or ply.BotEnemy:Team() ~= TEAM_SHOOTERS then
			ply.BotEnemy = nil
		end

		cmd:SetForwardMove(ply:GetWalkSpeed())
	end
end
