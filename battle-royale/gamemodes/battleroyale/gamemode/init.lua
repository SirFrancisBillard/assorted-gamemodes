AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_init.lua")

include("shared.lua")

game.ConsoleCommand("sbox_weapons 0\n")
game.ConsoleCommand("sbox_godmode 0\n")
game.ConsoleCommand("sbox_noclip 0\n")

util.AddNetworkString("br_openperkmenu")
util.AddNetworkString("br_selectperk")

function GM:PlayerSpawnObject(ply)
	return ply:IsAdmin()
end

function GM:EntityTakeDamage(ply, dmg)
	local atk = dmg:GetAttacker()
	if IsValid(ply) and IsValid(atk) and ply:IsPlayer() and atk:IsPlayer() then
		local wep = atk:GetActiveWeapon()
		local ply_perk = atk:GetNWInt("br_perk", PERK_NONE)
		local atk_perk = atk:GetNWInt("br_perk", PERK_NONE)
		if not IsValid(wep) then return end
		-- Grinder: Get armor for hurting people
		if atk_perk == PERK_GRINDER and atk:Armor() < 40 then
			atk:SetArmor(math.Clamp(atk:Armor() + math.Round(dmg:GetDamage() / 4), 0, 40))
			return
		end
		-- Psycho: Deal double damage with blades
		if atk_perk == PERK_PSYCHO and self.WeaponTypes.Blades[wep:GetClass()] then
			dmg:ScaleDamage(2)
			return
		end
		-- Rage: Deal more damage the lower your health
		if atk_perk == PERK_RAGE then
			dmg:ScaleDamage(1 + ((100 - atk:Health()) / 100))
			return
		end
		-- Marksman: Deal more damage with rifles
		if atk_perk == PERK_MARKSMAN and self.WeaponTypes.Marksman[wep:GetClass()] then
			dmg:ScaleDamage(1.4)
			return
		end
		-- Acrobat: Take less damage from falling
		if atk_perk == PERK_ACROBAT and dmg:IsDamageType(DMG_FALL) then
			dmg:ScaleDamage(0.05)
			return
		end
		-- Boxer: Deal more damage with fists
		if atk_perk == PERK_BOXER and wep:GetClass() == "weapon_fists" then
			dmg:ScaleDamage(1.2)
			return
		elseif wep:GetClass() == "weapon_fists" then
			-- fist are op as shit so nerf them
			-- by default
			dmg:ScaleDamage(0.5)
		end
	end
end

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

	rag.loot_armor = 0
	if ply:Armor() > 0 then
		rag.loot_armor = ply:Armor()
	end

	rag.loot_weapons = {}
	for k, v in pairs(ply:GetWeapons()) do
		table.insert(rag.loot_weapons, v)
	end

	rag.loot_ammo = {}
	for k, v in pairs(self.AmmoTypes) do
		if ply:GetAmmoCount(v) > 0 then
			rag.loot_ammo[k] = ply:GetAmmoCount(v)
		end
	end

	-- nonsolid to players, but can be picked up and shot
	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	timer.Simple(1, function() if IsValid(rag) then rag:CollisionRulesChanged() end end)

	-- clean corpse in a minute
	SafeRemoveEntityDelayed(rag, 60)

	-- position the bones
	local num = rag:GetPhysicsObjectCount()-1
	local v = ply:GetVelocity()

	-- bullets have a lot of force, which feels better when shooting props,
	-- but makes bodies fly, so dampen that here
	if dmg:IsDamageType(DMG_BULLET) or dmg:IsDamageType(DMG_SLASH) then
		v = v / 5
	end

	for i=0, num do
		local bone = rag:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end

			-- not sure if this will work:
			bone:SetVelocity(v)
		end
	end

	ply:AddDeaths(1)

	if attacker:IsValid() && attacker:IsPlayer() then
		if attacker == ply then
			attacker:AddFrags(-1)
		else
			attacker:AddFrags(1)
		end
	end
end

function GM:PlayerSpawn(ply)
	self.BaseClass.PlayerSpawn(self, ply)

	player_manager.SetPlayerClass(ply, "player_sandbox")
	ply:StripWeapons()
	ply:Give("weapon_fists") -- bare hands

	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(250)

	ply:SetNWInt("br_perk", PERK_NONE)
	ply.chose_perk = false

	net.Start("br_openperkmenu")
	net.Send(ply)

	ply:SetModel(self.PlayerModels[math.random(1, #self.PlayerModels)])
	ply:SetupHands()
end

function GM:PlayerSetHandsModel(ply, ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
	local info = player_manager.TranslatePlayerHands(simplemodel)
	if info then
		ent:SetModel(info.model)
		ent:SetSkin(info.skin)
		ent:SetBodyGroups(info.body)
	end
end

function GM:GetFallDamage(ply, speed)
	return speed / 8
end

net.Receive("br_selectperk", function(len, ply)
	local perk = net.ReadInt(5)
	if perk <= PERK_MAX and not ply.chose_perk then
		ply:SetNWInt("br_perk", perk)
	end
end)
