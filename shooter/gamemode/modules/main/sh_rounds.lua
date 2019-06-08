
local shooteramt = CreateConVar("shooter_amt", 1, FCVAR_NOTIFY, "How many shooters will spawn each round.")
local choosebots = CreateConVar("shooter_botshooters", 0, FCVAR_NONE, "Whether bots should be picked as shooters.")

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
			game.CleanUpMap()
		end,
	},
	[ROUND_INPROGRESS] = {
		name = "Shooting in progress",
		color = Color(150, 0, 0),
		start = function()
			PoliceWaves = 0
			PrintMessage(HUD_PRINTTALK, "Shooter has been selected!")
			local candidates = choosebots:GetBool() and player.GetAll() or player.GetHumans()
			for k, v in RandomPairs(candidates) do
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
	if IsRoundState(ROUND_WAITING) then
		return "--:--"
	end
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

		if player.GetCount() < 2 + shooteramt:GetInt() then
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
			if not shooter_alive then
				PrintMessage(HUD_PRINTTALK, "Shooter has died!")
				SetRoundState(ROUND_OVER)
				for k, v in pairs(team.GetPlayers(TEAM_POLICE)) do
					if not v:IsBot() or not v:Alive() then continue end
					v:SetLuaAnimation("kys_mp5")
				end
			end

			if living_innocents <= player.GetCount() / 2 and PoliceWaves < 2 then
				timer.Simple(1, function()
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
				end)
			end

			if living_innocents < 1 then
				PrintMessage(HUD_PRINTTALK, "Shooter has killed all innocents.")
				SetRoundState(ROUND_OVER)
				for k, v in pairs(team.GetPlayers(TEAM_SHOOTERS)) do
					--v:SelectWeapon("shooter_deagle")
					local wep = v:GetActiveWeapon()
					if IsValid(wep) and wep:GetClass() == "shooter_deagle" then
						v:SetLuaAnimation("kys_pistol")
					else
						v:SetLuaAnimation("kys_mp5")
					end
					v:Freeze(true) -- freeze for sewer slide
					timer.Simple(6, function()
						if IsValid(v) and v:IsPlayer() then
							v:Freeze(false)
						end
					end)
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
