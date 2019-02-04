
surface.CreateFont("BattleRoyale_HUD", {
	font = "Trebuchet",
	size = 24,
})

function GM:HUDPaint()
	self.BaseClass.HUDPaint(self)

	local ply = LocalPlayer()
	local health = "Health: " .. (ply:Health() > 0 and ply:Health() or "Dead")
	local armor = "Armor: " .. (ply:Armor() > 0 and ply:Armor() or "None")
	local res = "Resources: " .. (ply:GetResources() > 0 and ply:GetResources() or "None")
	
	local font = "BattleRoyale_HUD"

	-- move the health up by the height of the armor
	surface.SetFont(font)
	local health_offset = select(2, surface.GetTextSize(armor))

	draw.SimpleText(health, font, ScrW() / 400, ScrH() - health_offset, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.SimpleText(armor, font, ScrW() / 400, ScrH(), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

	draw.SimpleText(res, font, ScrW() - (ScrW() / 400), ScrH(), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end
