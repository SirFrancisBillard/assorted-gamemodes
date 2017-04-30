
-- Misc

sound.Add({
	name = "Prison.Handcuff",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "prison/handcuff.wav"
})

sound.Add({
	name = "Prison.Knife",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "prison/knife.wav"
})

sound.Add({
	name = "Prison.Taser",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "prison/taser.wav"
})

-- Bullets

sound.Add({
	name = "Bullet.Snap",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"prison/bullets/snap_01.wav", "prison/bullets/snap_02.wav", "prison/bullets/snap_03.wav"}
})

-- Explosion

sound.Add({
	name = "Explosion.Near",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 120,
	pitch = {95, 110},
	sound = {"prison/explosion/near.wav"}
})

sound.Add({
	name = "Explosion.Far",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 180,
	pitch = {95, 110},
	sound = {"prison/explosion/far.wav"}
})

-- Player

sound.Add({
	name = "Player.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"prison/player/headshot.wav"}
})

-- Weapons

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
		channel = CHAN_WEAPON,
		volume = 1.0,
		level = 0,
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
