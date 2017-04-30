
function GM:DoPlayerDeath(ply, attacker, dmg)
	if not IsValid(ply) then return end

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
		-- we don't have anything, might as well be looted
		loot.is_looted = true
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
