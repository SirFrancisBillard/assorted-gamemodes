
PlayerModelRadialTaunts = {
	["default"] = {
		joke = {
			"vo/npc/barney/ba_ohyeah.wav",
			"vo/npc/barney/ba_yell.wav",
			"vo/npc/barney/ba_danger02.wav",
		},
		scream = {
			"vo/npc/barney/ba_ohshit03.wav",
		},
		danger = {
			"vo/npc/barney/ba_lookout.wav",
			"vo/npc/barney/ba_getdown.wav",
			"vo/npc/barney/ba_getaway.wav",
		},
		laugh = {
			"vo/npc/barney/ba_laugh01.wav",
			"vo/npc/barney/ba_laugh02.wav",
			"vo/npc/barney/ba_laugh03.wav",
			"vo/npc/barney/ba_laugh04.wav",
		},
	},
	["models/player/alyx.mdl"] = {
		joke = {
			"vo/novaprospekt/al_enoughbs01.wav",
			"vo/npc/alyx/brutal02.wav",
			"vo/eli_lab/al_ugh.wav",
		},
		scream = {
			"vo/npc/alyx/uggh02.wav",
		},
		danger = {
			"vo/npc/alyx/lookout01.wav",
			"vo/npc/alyx/lookout03.wav",
			"vo/npc/alyx/watchout01.wav",
			"vo/npc/alyx/watchout03.wav",
		},
		laugh = {
			"vo/eli_lab/al_laugh01.wav",
			"vo/eli_lab/al_laugh02.wav",
		},
	},
	["models/player/p2_chell.mdl"] = {
		joke = {
			"vo/npc/female01/hi01.wav",
			"vo/npc/female01/hi02.wav",
			"vo/npc/female01/question02.wav",
			"vo/npc/female01/question04.wav",
			"vo/npc/female01/question05.wav",
			"vo/npc/female01/question07.wav",
			"vo/npc/female01/question09.wav",
			"vo/npc/female01/question10.wav",
			"vo/npc/female01/question11.wav",
			"vo/npc/female01/question12.wav",
			"vo/npc/female01/question20.wav",
			"vo/npc/female01/question23.wav",
			"vo/npc/female01/question26.wav",
			"vo/npc/female01/question29.wav",
			"vo/npc/female01/question30.wav",
		},
		scream = {
			"vo/npc/female01/moan01.wav",
		},
		danger = {
			"vo/npc/female01/watchout.wav",
			"vo/npc/female01/ohno.wav",
		},
		laugh = {
			"vo/eli_lab/al_laugh01.wav",
			"vo/eli_lab/al_laugh02.wav",
		},
	},
	["models/player/monk.mdl"] = {
		joke = {
			"vo/ravenholm/aimforhead.wav",
			"vo/ravenholm/shotgun_hush.wav",
			"vo/ravenholm/monk_mourn01.wav",
			"vo/ravenholm/pyre_anotherlife.wav",
		},
		scream = {
			"vo/ravenholm/monk_death07.wav",
		},
		danger = {
			"vo/ravenholm/monk_danger01.wav",
			"vo/ravenholm/monk_danger02.wav",
			"vo/ravenholm/monk_danger03.wav",
		},
		laugh = {
			"vo/ravenholm/madlaugh01.wav",
			"vo/ravenholm/madlaugh02.wav",
			"vo/ravenholm/madlaugh03.wav",
			"vo/ravenholm/madlaugh04.wav",
		},
	},
	["models/player/kleiner.mdl"] = {
		joke = {
			"vo/k_lab/kl_ohdear.wav",
			"vo/k_lab/kl_fiddlesticks.wav",
			"vo/k_lab/kl_mygoodness01.wav",
			"vo/k_lab2/kl_greatscott.wav",
			"vo/k_lab/kl_nonsense.wav",
		},
		scream = {
			"vo/k_lab/kl_ahhhh.wav",
		},
		danger = {
			"vo/k_lab/kl_mygoodness01.wav",
			"vo/k_lab/kl_ohdear.wav",
			"vo/k_lab/kl_dearme.wav",
			"vo/k_lab/kl_getoutrun03.wav",
		},
		laugh = {
			"vo/npc/barney/ba_laugh01.wav",
			"vo/npc/barney/ba_laugh02.wav",
			"vo/npc/barney/ba_laugh03.wav",
			"vo/npc/barney/ba_laugh04.wav",
		},
	},
	["models/player/guerilla.mdl"] = {
		joke = {
			"bot/aw_hell.wav",
			"bot/come_out_and_fight_like_a_man.wav",
			"bot/come_out_wherever_you_are.wav",
			"bot/come_to_papa.wav",
			"bot/do_not_mess_with_me.wav",
			"bot/great.wav",
			"bot/i_am_dangerous.wav",
			"bot/i_am_on_fire.wav",
			"bot/i_got_more_where_that_came_from.wav",
			"bot/its_a_party.wav",
			"bot/owned.wav",
			"bot/tag_them_and_bag_them.wav",
			"bot/tag_them_and_bag_them.wav",
			"bot/yea_baby.wav",
			"bot/yesss.wav",
		},
		scream = {
			"bot/aah.wav",
			"bot/hey.wav",
			"bot/stop_it.wav",
		},
		danger = {
			"bot/help.wav",
			"bot/i_heard_them.wav",
			"bot/i_hear_something.wav",
			"bot/target_spotted.wav",
			"bot/uh_oh.wav",
			"bot/yikes.wav",
		},
		laugh = {
			"bot/whoo.wav",
			"bot/whoo2.wav",
		},
	},
}
PlayerModelRadialTaunts["models/player/leet.mdl"] = PlayerModelRadialTaunts["models/player/guerilla.mdl"]
PlayerModelRadialTaunts["models/player/phoenix.mdl"] = PlayerModelRadialTaunts["models/player/guerilla.mdl"]
PlayerModelRadialTaunts["models/player/mossman_arctic.mdl"] = PlayerModelRadialTaunts["models/player/p2_chell.mdl"]

function RadialTaunt(ply, taunt)
	if not taunt or not IsValid(ply) or not ply:IsPlayer() then return end
	local key = ply:GetModel()
	if not PlayerModelRadialTaunts[key] then key = "default" end
	local taunts = PlayerModelRadialTaunts[key][taunt]
	if not taunts then return end
	if not ply.NextRadialTaunt then ply.NextRadialTaunt = 0 end
	if CurTime() > ply.NextRadialTaunt then
		local wav = taunts[math.random(#taunts)]
		ply.NextRadialTaunt = CurTime() + SoundDuration(wav)
		if ply.CurEmitSound then
			ply:StopSound(ply.CurEmitSound)
		end
		ply.CurEmitSound = wav
		ply:EmitSound(wav)
	end
end

concommand.Add("radialtaunt", function(ply, cmd, args)
	RadialTaunt(ply, args[1])
end)
