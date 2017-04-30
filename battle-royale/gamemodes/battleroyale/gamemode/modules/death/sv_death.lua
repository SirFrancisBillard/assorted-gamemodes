
function GM:DoPlayerDeath(ply, attacker, dmg)
	if not IsValid(ply) then return end

	local rag = ents.Create("prop_ragdoll")
	if not IsValid(rag) then return nil end

	rag:SetPos(ply:GetPos())
	rag:SetModel(ply:GetModel())
	rag:SetAngles(ply:GetAngles())
	rag:SetColor(ply:GetColor())

	rag:Spawn()
	rag:Activate()

	rag.player_corpse = true
	rag.is_looted = false

	rag:SetNWBool("player_corpse", true)
	rag:SetNWString("player_nick", ply:Nick())

	rag.loot_armor = 0
	if ply:Armor() > 0 then
		rag.loot_armor = ply:Armor()
	end

	rag.loot_weapons = {}
	for k, v in pairs(ply:GetWeapons()) do
		if self.DefaultWeapons[v:GetClass()] then continue end
		table.insert(rag.loot_weapons, v:GetClass())
	end

	rag.loot_ammo = {}
	for k, v in pairs(self.AmmoTypes) do
		if ply:GetAmmoCount(v) > 0 then
			rag.loot_ammo[k] = ply:GetAmmoCount(v)
		end
	end

	if rag.loot_armor < 1 and #rag.loot_weapons < 1 and #rag.loot_ammo < 1 then
		-- we don't have anything, might as well be looted
		rag.is_looted = true
	end

	rag.loot_resources = ply:GetResources()

	-- nonsolid to players, but can be picked up and shot
	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	timer.Simple(1, function()
		if IsValid(rag) then
			rag:CollisionRulesChanged()
		end
	end)

	-- clean corpse in a minute
	SafeRemoveEntityDelayed(rag, 60)

	-- position the bones
	local num = rag:GetPhysicsObjectCount() - 1
	for i = 0, num do
		local bone = rag:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end

			bone:SetVelocity(vector_origin)
		end
	end

	ply:AddDeaths(1)

	if IsValid(attacker) and attacker:IsPlayer() then
		if ply ~= attacker then
			attacker:AddFrags(1)
			attacker:SetKillstreak(attacker:GetKillstreak() + 1)
			self:PlayerKillstreak(attacker)
		end
	end
end
