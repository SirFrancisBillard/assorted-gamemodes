
function GM:DoPlayerDeath(ply, attacker, dmg)
	if not IsValid(ply) then return end

	local rag_type = RAGTYPE_DEFAULT
	if ply:LastHitGroup() == HITGROUP_HEAD then
		rag_type = RAGTYPE_DECAP
	end
	if ply:LastHitGroup() == HITGROUP_LEFTARM or ply:LastHitGroup() == HITGROUP_RIGHTARM then
		rag_type = RAGTYPE_ARMS
	end
	if ply:LastHitGroup() == HITGROUP_LEFTLEG or ply:LastHitGroup() == HITGROUP_RIGHTLEG then
		rag_type = RAGTYPE_LEGS
	end
	if dmg:IsExplosionDamage() then
		rag_type = math.random(1, 2) == 1 and RAGTYPE_GIB or RAGTYPE_AMPUTEE
	end
	if dmg:GetDamageType() == DMG_SLASH then
		rag_type = math.random(RAGTYPE_DECAP, RAGTYPE_AMPUTEE)
	end
	ply:RagdollOnClient(rag_type)

	local loot = ents.Create("ent_droppedloot")
	if not IsValid(loot) then return nil end

	loot:SetPos(ply:GetPos())
	loot:Spawn()

	loot:SetPlayerName(ply:Nick())

	loot.loot_armor = 0
	if ply:Armor() > 0 then
		loot.loot_armor = ply:Armor()
	end

	loot.loot_weapons = {}
	for k, v in pairs(ply:GetWeapons()) do
		if self.DefaultWeapons[v:GetClass()] then continue end
		table.insert(loot.loot_weapons, v:GetClass())
	end

	loot.loot_resources = ply:GetResources()

	if loot.loot_armor < 1 and #loot.loot_weapons < 1 and loot.loot_resources < 1 then
		-- we don't have anything, might as well not exist
		loot:Remove()
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
