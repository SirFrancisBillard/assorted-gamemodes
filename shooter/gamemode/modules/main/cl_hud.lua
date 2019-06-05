
surface.CreateFont("ShooterHUD", {
	font = "Comic Sans MS",
	size = ScreenScale(30),
})

surface.CreateFont("ShooterHUD_Small", {
	font = "Comic Sans MS",
	size = ScreenScale(10),
})

hook.Add("HUDPaint", "Shooter_HUD", function()
	draw.SimpleTextOutlined(GetRoundTimer(), "ShooterHUD", ScrW() / 2, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
	draw.SimpleTextOutlined(RoundStateData[GetRoundState()].name, "ShooterHUD_Small", 0, 0, RoundStateData[GetRoundState()].color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, color_black)
end)
