
local last_change = 0
local round_state = 1
PoliceWaves = 0

ROUND_WAITING = 1
ROUND_PREPARING = 2
ROUND_INPROGRESS = 3
ROUND_OVER = 4

RoundStateData = {
	[ROUND_WAITING] = {
		name = "Waiting for players...",
		color = Color(150, 150, 150),
	},
	[ROUND_PREPARING] = {
		name = "Preparing to start...",
		color = Color(150, 150, 150),
		start = function()
			PrintMessage(HUD_PRINTTALK, "Shooter will be selected in 15 seconds...")
			for k, v in pairs(player.GetAll()) do
				v:SetTeam(TEAM_CIVILIANS)
				player_manager.SetPlayerClass(v, "player_citizen")
				v:Spawn()
			end
		end,
	},
	[ROUND_INPROGRESS] = {
		name = "Shooting in progress",
		color = Color(150, 0, 0),
		start = function()
			PoliceWaves = 0
			PrintMessage(HUD_PRINTTALK, "Shooter has been selected!")
			for k, v in RandomPairs(player.GetHumans()) do
				v:SetTeam(TEAM_SHOOTERS)
				player_manager.SetPlayerClass(v, "player_shooter")
				v:Spawn()
				break
			end
		end,
	},
	[ROUND_OVER] = {
		name = "Round over",
		color = Color(150, 150, 0),
		start = function()
			PrintMessage(HUD_PRINTTALK, "Next round starting in 10 seconds...")
		end,
	},
}

function GetRoundState()
	return round_state
end

function LastRoundStateChange()
	return last_change
end

function IsRoundState(state)
	return round_state == state
end

function GetRoundTimer()
	return string.ToMinutesSeconds(CurTime() - last_change)
end

if SERVER then
	util.AddNetworkString("UpdateRoundstate")

	function UpdateRoundState()
		net.Start("UpdateRoundstate")
		net.WriteInt(round_state, 5)
		net.Broadcast()
	end

	function SetRoundState(state, forceupdate)
		if round_state == state and not forceupdate then return end
		last_change = CurTime()
		round_state = state
		UpdateRoundState()
		if RoundStateData[state].start then
			RoundStateData[state].start()
		end
	end

	hook.Add("Think", "RoundStateThink", function()
		if CurTime() - last_change > 10 then
			if IsRoundState(ROUND_OVER) then
				SetRoundState(ROUND_WAITING)
			elseif IsRoundState(ROUND_PREPARING) then
				SetRoundState(ROUND_INPROGRESS)
			end
		end

		if player.GetCount() < 3 then
			SetRoundState(ROUND_WAITING)
			return
		elseif IsRoundState(ROUND_WAITING) then -- just got enough players
			SetRoundState(ROUND_PREPARING)
		end
	end)

	local function CheckShooter(ply)
		local shooter_alive = false
		local living_innocents = 0
		for k, v in pairs(player.GetAll()) do
			if v:Alive() then
				if v:Team() == TEAM_SHOOTERS then
					shooter_alive = true
				else
					living_innocents = living_innocents + 1
				end
			end
		end

		if IsRoundState(ROUND_INPROGRESS) then
			if living_innocents < 1 then
				PrintMessage(HUD_PRINTTALK, "Shooter has killed all innocents.")
				SetRoundState(ROUND_OVER)
				local shooter = team.GetPlayers(TEAM_SHOOTERS)[1]
				shooter:SelectWeapon("shooter_deagle")
				shooter:Freeze(true) -- freeze for sewer slide
				timer.Simple(6, function()
					if IsValid(shooter) and shooter:IsPlayer() then
						shooter:Freeze(false)
					end
				end)
			elseif not shooter_alive then
				PrintMessage(HUD_PRINTTALK, "Shooter has died!")
				SetRoundState(ROUND_OVER)
			end

			if living_innocents <= player.GetCount() / 2 and PoliceWaves < 2 then
				PoliceWaves = PoliceWaves + 1
				if PoliceWaves == 1 then
					PrintMessage(HUD_PRINTTALK, "The first wave of police have arrived!")
				else
					PrintMessage(HUD_PRINTTALK, "The second wave of police have arrived!")
				end
				for k, v in pairs(player.GetAll()) do
					if not v:Alive() then
						v:SetTeam(TEAM_POLICE)
						player_manager.SetPlayerClass(v, "player_cop")
						v:Spawn()
					end
				end
			end
		end

		
	end

	hook.Add("PostPlayerDeath", "Shooter_CheckDeath", CheckShooter)
	hook.Add("PlayerDisconnected", "Shooter_CheckDisc", CheckShooter)
else
	net.Receive("UpdateRoundstate", function(len)
		local state = net.ReadInt(5)
		last_change = CurTime() -- could get desynced, but who cares
		round_state = state
	end)
end
