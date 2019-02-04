
local round_state = 0

ROUND_WAITING = 0
ROUND_PREPARING = 1
ROUND_INPROGESS = 2
ROUND_OVER = 3

function GetRoundState()
	if player.GetCount() < 3 then
		return ROUND_WAITING
	end
	return round_state
end

function IsRoundState(state)
	return GetRoundstate() == state
end

function GetRoundTimer()

end

if SERVER then
	util.AddNetworkString("UpdateRoundstate")

	function UpdateRoundState()
		net.Start("UpdateRoundstate")
		net.WriteInt(round_state, 5)
		net.Broadcast()
	end

	function SetRoundState(state)
		round_state = state
		UpdateRoundState()
	end
else
	net.Receive("UpdateRoundstate", function(len)
		local state = net.ReadInt(5)
		round_state = state
	end)
end
