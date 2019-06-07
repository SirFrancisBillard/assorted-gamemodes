
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
}

concommand.Add("radialtaunt", function(ply, cmd, args)
	if not args[1] or not IsValid(ply) or not ply:IsPlayer() then return end
	local key = ply:GetModel()
	if not PlayerModelRadialTaunts[key] then key = "default" end
	local taunts = PlayerModelRadialTaunts[key][args[1]]
	if not taunts then return end
	if not ply.LastRadialTaunt then ply.LastRadialTaunt = 0 end
	if CurTime() - 1.8 > ply.LastRadialTaunt then
		ply.LastRadialTaunt = CurTime()
		ply:EmitSound(taunts[math.random(#taunts)])
	end
end)
