
-- Misc

sound.Add({
	name = "Player.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 100,
	pitch = {95, 110},
	sound = "battleroyale/headshot.wav"
})

sound.Add({
	name = "Kevlar.Equip",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 50,
	pitch = {95, 110},
	sound = "battleroyale/armor.wav"
})

sound.Add({
	name = "Loot.Open",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 65,
	pitch = {95, 110},
	sound = "battleroyale/loot.wav"
})

-- Doors

sound.Add({
	name = "Door.Locked",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 50,
	pitch = {95, 110},
	sound = "buttons/weapon_cant_buy.wav"
})

sound.Add({
	name = "Door.Open",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 50,
	pitch = {95, 110},
	sound = "buttons/blip2.wav"
})

sound.Add({
	name = "Door.Auth",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 50,
	pitch = {95, 110},
	sound = "buttons/bell1.wav"
})

-- Blocks

sound.Add({
	name = "Block.Place",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 60,
	pitch = {95, 110},
	sound = {"physics/concrete/concrete_impact_hard1.wav", "physics/concrete/concrete_impact_hard2.wav", "physics/concrete/concrete_impact_hard3.wav"}
})

sound.Add({
	name = "Block.Break",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 60,
	pitch = {95, 110},
	sound = {"physics/concrete/concrete_break2.wav", "physics/concrete/concrete_break3.wav"}
})

-- Bullets

sound.Add({
	name = "Bullet.Snap",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"battleroyale/bullets/snap_01.wav", "battleroyale/bullets/snap_02.wav", "battleroyale/bullets/snap_03.wav"}
})

-- Explosion

sound.Add({
	name = "Explosion.Near",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 120,
	pitch = {95, 110},
	sound = {"battleroyale/explosion/near.wav"}
})

sound.Add({
	name = "Explosion.Far",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 180,
	pitch = {95, 110},
	sound = {"battleroyale/explosion/far.wav"}
})

-- Player

sound.Add({
	name = "Player.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"battleroyale/player/headshot.wav"}
})

-- Weapons

sound.Add({
	name = "Weapon_Knife.Hit",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "battleroyale/knife.wav"
})

local function RegisterWeaponScript(id, name)
	sound.Add({
		name = name .. ".Near",
		channel = CHAN_WEAPON,
		volume = 1.0,
		level = 100,
		pitch = {95, 110},
		sound = {"battleroyale/weapons/" .. id .. ".wav"}
	})

	sound.Add({
		name = name .. ".Far",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 140,
		pitch = {95, 110},
		sound = {"battleroyale/weapons/" .. id .. "_dist.wav"}
	})
end

RegisterWeaponScript("ak47", "Weapon_AK47")
RegisterWeaponScript("deagle", "Weapon_Deagle")
RegisterWeaponScript("flaregun", "Weapon_Flaregun")
RegisterWeaponScript("glock", "Weapon_Glock")
RegisterWeaponScript("m4a1", "Weapon_M4A1")
RegisterWeaponScript("m249", "Weapon_M249")
RegisterWeaponScript("mp5", "Weapon_MP5")
RegisterWeaponScript("pistol", "Weapon_Pistol")
RegisterWeaponScript("shotgun", "Weapon_Shotgun")
RegisterWeaponScript("sniper", "Weapon_Sniper")
