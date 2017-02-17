AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_config.lua")

include("shared.lua")

-- disable all the game-breaking stuff
game.ConsoleCommand("sbox_weapons 0\n")
game.ConsoleCommand("sbox_godmode 0\n")
game.ConsoleCommand("sbox_noclip 0\n")

-- pool network strings
util.AddNetworkString("br_openperkmenu")
util.AddNetworkString("br_selectperk")

-- we need this so we don't just assume
local function GetGender(ply)
	-- if they don't have a gender we'll assume they're male
	-- (sexism smh)
	return ply.model_table and ply.model_table.gender or GENDER_MALE
end

-- called on the attacker of every kill
function GM:PlayerKillstreak(ply)
	-- if this ever runs, we have a serious problem
	if not type(ply.killstreak) == "number" then
		ply.killstreak = 0
		return
	end
	-- temp
	-- add something better here
	if ply.killstreak % 5 == 0 then
		-- i will give 400 bucks to whomever can get
		-- this string.Comma to make a difference
		ply:ChatPrint("Killstreak: " .. string.Comma(ply.killstreak))
		ply:ChatPrint("Airdrop inbound")

		local drop = ents.Create("ent_dropnade_proj")
		drop:SetPos(ply:GetPos())
		drop:Spawn()

		-- disable collisions with owner
		drop:SetOwner(ply)
	end
end

function GM:PlayerSpawnObject(ply)
	return ply:IsAdmin()
end

function GM:EntityTakeDamage(ply, dmg)
	local atk = dmg:GetAttacker()
	local hg = ply:LastHitGroup()
	-- hurt sounds
	if IsValid(ply) and ply:IsPlayer() end
		local gen = GetGender(ply)
		-- this is the order of priority for where something is in the table
		local snd = GM.HurtSounds[hg] or GM.HurtSounds[gen][hg] or GM.HurtSounds[gen]["generic"]
		ply:EmitSound(snd)
	end
	-- perks
	if IsValid(ply) and IsValid(atk) and ply:IsPlayer() and atk:IsPlayer() then
		local wep = atk:GetActiveWeapon()
		local ply_perk = atk:GetNWInt("br_perk", PERK_NONE)
		local atk_perk = atk:GetNWInt("br_perk", PERK_NONE)
		if not IsValid(wep) then return end
		-- grinder: get armor for hurting people
		if atk_perk == PERK_GRINDER and atk:Armor() < 40 then
			atk:SetArmor(math.Clamp(atk:Armor() + math.Round(dmg:GetDamage() / 4), 0, 40))
			return
		end
		-- psycho: deal double damage with blades
		if atk_perk == PERK_PSYCHO and self.WeaponTypes.Blades[wep:GetClass()] then
			dmg:ScaleDamage(2)
			return
		end
		-- rage: deal more damage the lower your health
		if atk_perk == PERK_RAGE then
			dmg:ScaleDamage(1 + ((100 - atk:Health()) / 100))
			return
		end
		-- marksman: deal more damage with rifles
		if atk_perk == PERK_MARKSMAN and self.WeaponTypes.Marksman[wep:GetClass()] then
			dmg:ScaleDamage(1.4)
			return
		end
		-- boxer: deal more damage with fists
		if atk_perk == PERK_BOXER and wep:GetClass() == "weapon_fists" then
			dmg:ScaleDamage(6)
			return
		elseif wep:GetClass() == "weapon_fists" then
			-- fists really shit so buff them by default
			dmg:ScaleDamage(2)
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

	rag:SetNWString("player_nick", ply:Nick())

	rag.loot_armor = 0
	if ply:Armor() > 0 then
		rag.loot_armor = ply:Armor()
	end

	rag.loot_weapons = {}
	for k, v in pairs(ply:GetWeapons()) do
		if v:GetClass() == "weapon_fists" then continue end
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

	-- nonsolid to players, but can be picked up and shot
	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	timer.Simple(1, function() if IsValid(rag) then rag:CollisionRulesChanged() end end)

	-- clean corpse in a minute
	SafeRemoveEntityDelayed(rag, 60)

	-- position the bones
	local num = rag:GetPhysicsObjectCount() - 1
	local v = ply:GetVelocity()

	-- bullets have a lot of force, which feels better when shooting props,
	-- but makes bodies fly, so dampen that here
	if dmg:IsDamageType(DMG_BULLET) or dmg:IsDamageType(DMG_SLASH) then
		v = v / 5
	end

	for i = 0, num do
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
		if not attacker == ply then
			attacker:AddFrags(1)
			attacker.killstreak = attacker.killstreak + 1
			self:PlayerKillstreak(attacker)
		end
	end
end

function GM:PlayerSpawn(ply)
	self.BaseClass.PlayerSpawn(self, ply)

	player_manager.SetPlayerClass(ply, "player_sandbox")
	ply:StripWeapons()

	-- bare hands
	ply:Give("weapon_fists")

	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(250)

	ply:SetNWInt("br_perk", PERK_NONE)
	ply.chose_perk = false

	net.Start("br_openperkmenu")
	net.Send(ply)

	local mdl_choice = self.PlayerModels[math.random(1, #self.PlayerModels)]
	ply:SetModel(mdl_choice[math.random(1, #mdl_choice)])
	ply.model_table = mdl_choice

	ply.killstreak = 0

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
	-- acrobat: take less fall damage
	if ply:GetNWInt("br_perk") == PERK_ACROBAT then
		return 5
	else
		return speed / 8
	end
end

net.Receive("br_selectperk", function(len, ply)
	local perk = net.ReadInt(5)
	if perk <= PERK_MAX and not ply.chose_perk then
		ply:SetNWInt("br_perk", perk)
		ply.chose_perk = true
	end
end)
