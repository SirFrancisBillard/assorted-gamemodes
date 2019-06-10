
-- handled in cl_hud.lua

util.AddNetworkString("SendClassHint")

local PLAYER = FindMetaTable("Player")

function PLAYER:SendClassHint()
	net.Start("SendClassHint")
	net.Send(self)
end

function BroadcastClassHints()
	net.Start("SendClassHint")
	net.Broadcast()
end
