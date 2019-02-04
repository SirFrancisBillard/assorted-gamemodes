
local Mat = Material("vgui/crosshairs/crosshair6")
local HitTrans = 0

net.Receive("br_hitmarker",function(len,ply)
	HitTrans = 300
end)

hook.Add("HUDPaint", "BattleRoyale.HitMarker", function()
	HitTrans = math.Clamp(HitTrans - FrameTime() * 300 * 2, 0, 300)
	
	local x = ScrW() / 2
	local y = ScrH() / 2
	local FinalAlpha = math.Clamp(HitTrans, 0, 255)
	local Size = 10 * (FinalAlpha / 255)
	local Offset = (10 * (FinalAlpha / 255)) + Size
		
	surface.SetDrawColor(Color(255,255,255,FinalAlpha))
	surface.DrawLine(x - Size + Offset, y - Size + Offset, x + Size + Offset, y + Size + Offset)
	surface.DrawLine(x - Size - Offset, y - Size - Offset , x + Size - Offset, y + Size - Offset)	
	surface.DrawLine(x - Size + Offset, y + Size - Offset, x + Size + Offset, y - Size - Offset)
	surface.DrawLine(x - Size - Offset, y + Size + Offset , x + Size - Offset, y - Size + Offset)
end)
