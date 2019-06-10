
local hintding = CreateClientConVar("shooter_ding", 1, true, false, "Whether to play the annoying *ding!* when you get a HUD hint.")

surface.CreateFont("ShooterHUD", {
	font = "Comic Sans MS",
	size = ScreenScale(30),
})

surface.CreateFont("ShooterHUD_Small", {
	font = "Comic Sans MS",
	size = ScreenScale(10),
})

local lastradialtaunt = 0
local radialopen = false
local radialjustclosed = false

hook.Add("Think", "RadialTauntMenu", function()
	local shouldopen = input.IsKeyDown(KEY_G) and LocalPlayer():Alive()
	if radialopen and not shouldopen then
		radialjustclosed = true
	else
		radialopen = shouldopen
		gui.EnableScreenClicker(shouldopen)
	end
end)

local classhint = nil
local ClassHintData = {
	["player_citizen"] = {
		title = "Civilian",
		desc = {"Avoid the shooters at all costs.", "If you die, you may be resurrected as police."},
		color = Color(100, 255, 100)
	},
	["player_cop"] = {
		title = "Police",
		desc = {"Stick with your team and eliminate the shooters.", "Watch your fire, keep civilians safe."},
		color = Color(0, 0, 255)
	},
	["player_guard"] = {
		title = "Security Guard",
		desc = {"Protect the civilians until help arrives.", "Watch your fire, keep civilians safe."},
		color = Color(100, 100, 255)
	},
	["player_shooter"] = {
		title = "Shooter",
		desc = {"Kill every last man.", "The more you kill, the quicker the police will arrive.", "You are not expected to survive."},
		color = Color(255, 100, 100)
	},
	["player_vigilante"] = {
		title = "Vigilante",
		desc = {"Respond fast, respond first.", "Hold off the shooter until further help arrives."},
		color = Color(255, 100, 255)
	},
	["gameover_shooter"] = {
		title = "Shooters Win",
		desc = {"All civilians have been eliminated."},
		color = Color(255, 100, 100)
	},
	["gameover_civilians"] = {
		title = "Civilians Win",
		desc = {"All shooters have been eliminated."},
		color = Color(100, 255, 100)
	},
}

local oldsubclass = 0
local oldclassid = 0
local oldbux = false
local dark_green = Color(60, 255, 60)
local magenta = Color(255, 60, 255)

net.Receive("GameOver", function(len)
	local shooterwon = net.ReadBool()
	if shooterwon then
		classhint = {class = "gameover_shooter", started = CurTime(), playding = true, seewhiledead = true}
	else
		classhint = {class = "gameover_civilians", started = CurTime(), playding = true, seewhiledead = true}
	end

	local newbux = LocalPlayer():GetBux()
	if oldbux and newbux > oldbux then
		chat.AddText(dark_green, "You gained ", magenta, string.Comma(newbux - oldbux), dark_green, " Bux this round, for a total of ", magenta, string.Comma(newbux), dark_green, " Bux.")
	end
	oldbux = newbux
end)

local barwidth = 0
local health = 0
local lastchange = 0

local function DrawHex(x, y, w, h)
	local hex = {
		{x = x, y = y + (h * 0.25)},
		{x = x + (w / 2), y = y},
		{x = x + w, y = y + (h * 0.25)},
		{x = x + w, y = y + (h * 0.75)},
		{x = x + (w / 2), y = y + h},
		{x = x, y = y + (h * 0.75)},
	}
	draw.NoTexture()
	surface.DrawPoly(hex)
end

local lastspawn = 0
local alive = false

local function CenteredSquare(x, y, size, highlighted, text)
	if highlighted then
		surface.SetDrawColor(0, 100, 255, 200)
	else
		surface.SetDrawColor(50, 50, 50, 200)
	end
	local halfsize = size / 2
	DrawHex(x - halfsize, y - halfsize, size, size)
	if text then
		draw.SimpleText(text, "ShooterHUD_Small", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

hook.Add("HUDPaint", "Shooter_HUD", function()
	local newalive = LocalPlayer():Alive()
	if newalive ~= alive then
		alive = newalive
		if alive then
			lastspawn = CurTime()
		end
	end

	local dist = ScrH() / 40
	draw.SimpleTextOutlined(GetRoundTimer(), "ShooterHUD", ScrW() / 2, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
	draw.SimpleTextOutlined(RoundStateData[GetRoundState()].name, "ShooterHUD_Small", dist, dist, RoundStateData[GetRoundState()].color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, color_black)

	if health ~= LocalPlayer():Health() then
		lastchange = CurTime()
		health = LocalPlayer():Health()
	end

	local barheight = ScrH() / 40
	barwidth = Lerp(FrameTime() * 4, barwidth, ScrW() * (health / LocalPlayer():GetMaxHealth()))
	surface.SetDrawColor(255 * (1 - (barwidth / ScrW())), 255 * (barwidth / ScrW()), 0, 255 * (1 - ((CurTime() - lastchange) / 2)))
	surface.DrawRect(0, ScrH() - barheight, barwidth, barheight)

	local newclassid = LocalPlayer():GetClassID()
	local newsubclass = LocalPlayer():GetSpecialClass()
	if oldclassid ~= newclassid or oldsubclass ~= newsubclass then
		oldclassid = newclassid
		oldsubclass = newsubclass
		classhint = {class = player_manager.GetPlayerClass(LocalPlayer()), started = CurTime(), playding = true, seewhiledead = false}
	end

	if classhint ~= nil and CurTime() - classhint.started < 8 and (alive or classhint.seewhiledead) then
		if hintding:GetBool() and classhint.playding then
			surface.PlaySound("ambient/levels/canals/windchime2.wav")
			classhint.playding = false
		end

		draw.SimpleTextOutlined(ClassHintData[classhint.class].title, "ShooterHUD", ScrW() / 2, ScrH() / 4.5, ClassHintData[classhint.class].color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
		local desc = ClassHintData[classhint.class].desc
		for i = 1, #desc do
			draw.SimpleTextOutlined(desc[i], "ShooterHUD_Small", ScrW() / 2, ScrH() / 4.5 + 50 + ((i - 1) * 25), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
		end

		if classhint.class == "player_citizen" then
			local subclasstab = gCitizenClasses[oldsubclass]

			if subclasstab ~= nil then
				local anchor = ScrH() - (ScrH() / 4.5)
				draw.SimpleTextOutlined("Civilian class", "ShooterHUD_Small", ScrW() / 2, anchor - 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
				for i = 1, #subclasstab.desc do
					draw.SimpleTextOutlined(subclasstab.desc[i], "ShooterHUD_Small", ScrW() / 2, anchor + 50 + ((i - 1) * 25), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
				end
				draw.SimpleTextOutlined(subclasstab.name, "ShooterHUD", ScrW() / 2, anchor, subclasstab.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black)
			end
		end
	end

	if radialopen then
		local centerx = ScrW() / 2
		local centery = ScrH() / 2 // 100 years xd
		local distfromcenter = ScrH() / 8
		local size = distfromcenter * 1.2
		local x, y = input.GetCursorPos()
		x = x - centerx
		y = y - centery
		local canselect = math.abs(x) + math.abs(y) > size / 4 -- distance from center
		local xneg = x < 0
		local yneg = y < 0
		local xbigger = math.abs(x) > math.abs(y)
		CenteredSquare(centerx - distfromcenter, centery, size, canselect and xneg and xbigger, "Joke")
		CenteredSquare(centerx + distfromcenter, centery, size, canselect and not xneg and xbigger, "Scream")
		CenteredSquare(centerx, centery + distfromcenter, size, canselect and not yneg and not xbigger, "Danger")
		CenteredSquare(centerx, centery - distfromcenter, size, canselect and yneg and not xbigger, "Laugh")
		if radialjustclosed and canselect and CurTime() - 0.5 > lastradialtaunt then
			lastradialtaunt = CurTime()
			if xbigger then
				if xneg then
					RunConsoleCommand("radialtaunt", "joke")
				else
					RunConsoleCommand("radialtaunt", "scream")
				end
			else
				if yneg then
					RunConsoleCommand("radialtaunt", "laugh")
				else
					RunConsoleCommand("radialtaunt", "danger")
				end
			end
		end
		if radialjustclosed then
			radialjustclosed = false
			radialopen = false
			gui.EnableScreenClicker(false)
		end
	end

	if CurTime() - lastspawn < 3 then
		local delta = (CurTime() - lastspawn) / 2
		surface.SetDrawColor(0, 0, 0, 255 - (255 * delta))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end

	local blind = LocalPlayer():GetNWFloat("blinded", 0)
	if CurTime() - blind < 4 then
		local delta = (CurTime() - blind) / 2
		surface.SetDrawColor(255, 255, 255, (255 * 2) - (255 * delta))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end
end)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if hide[name] then return false end
end)

function GM:HUDDrawTargetID() end
