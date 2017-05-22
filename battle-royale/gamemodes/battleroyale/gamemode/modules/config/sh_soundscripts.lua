
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

sound.Add({
	name = "Bullet.Snap",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"battleroyale/bullets/snap_01.wav", "battleroyale/bullets/snap_02.wav", "battleroyale/bullets/snap_03.wav"}
})

sound.Add({
	name = "Explosion.Boom",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = {"ambient/explosions/explode_1.wav", "ambient/explosions/explode_3.wav", "ambient/explosions/explode_4.wav"}
})

sound.Add({
	name = "Player.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = {"battleroyale/player/headshot.wav"}
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
