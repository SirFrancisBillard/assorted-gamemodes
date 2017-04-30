
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "ent_br_basegrenade_proj"
ENT.Model = Model("models/weapons/w_eq_smokegrenade_thrown.mdl")


AccessorFunc( ENT, "radius", "Radius", FORCE_NUMBER )

function ENT:Initialize()
	if not self:GetRadius() then self:SetRadius(20) end

	-- make sure the airdrop can travel as fast as it needs to
	local settings = physenv.GetPerformanceSettings()
	if settings.MaxVelocity < 3000 then
		settings.MaxVelocity = 3000
		physenv.SetPerformanceSettings(settings)
	end

	return self.BaseClass.Initialize(self)
end

if CLIENT then
	local smokeparticles = {
		Model("particle/particle_smokegrenade"),
		Model("particle/particle_noisesphere")
	};

	function ENT:CreateSmoke(center)
		local em = ParticleEmitter(center)

		local r = self:GetRadius()
		for i = 1, 20, 0.5 do
			timer.Simple(i, function()
				local prpos = VectorRand() * r
				prpos.z = prpos.z + 32
				local p = em:Add(table.Random(smokeparticles), center + prpos)
				if p then
					local gray = math.random(200, 250)
					p:SetColor(gray, 0, gray)
					p:SetStartAlpha(255)
					p:SetEndAlpha(200)
					p:SetVelocity(Vector(0, 0, 100))
					p:SetLifeTime(0)

					p:SetDieTime(math.Rand(15, 20))

					p:SetStartSize(math.random(140, 150))
					p:SetEndSize(math.random(1, 40))
					p:SetRoll(math.random(-180, 180))
					p:SetRollDelta(math.Rand(-0.1, 0.1))
					p:SetAirResistance(0)

					p:SetCollide(true)
					p:SetBounce(0.4)

					p:SetLighting(false)
				end
			end)
		end
		timer.Simple(21, function()
			if not IsValid(em) then return end
			em:Finish()
		end)
	end
end

function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local pos = self:GetPos()

		timer.Simple(16, function()
			local plane = pos + Vector(0, 0, 512)
			sound.Play("battleroyale/plane_close.wav", plane, 150, 100)
			sound.Play("battleroyale/plane_close.wav", plane, 150, 100)
			sound.Play("battleroyale/plane_close.wav", plane, 150, 100)
			for key,ply in pairs(player.GetAll())do
				ply:EmitSound("battleroyale/plane_far.wav", 70, 100)
			end
		end)

		timer.Simple(20, function()
			local drop = ents.Create("ent_airdrop")
			drop:SetPos(pos + Vector(0, 0, 128))
			drop:Spawn()
		end)

		self:Remove()
	else
		local spos = self:GetPos()
		local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
		util.Decal("SmallScorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      

		self:SetDetonateExact(0)

		if tr.Fraction != 1.0 then
			spos = tr.HitPos + tr.HitNormal * 0.6
		end

		self:CreateSmoke(spos)
	end
end
