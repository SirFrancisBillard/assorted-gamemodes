include("shared.lua")

function GM:ContextMenuOpen()
	return LocalPlayer():IsAdmin()
end

function GM:HUDDrawTargetID()
	local tr = util.GetPlayerTrace(LocalPlayer())
	local trace = util.TraceLine(tr)
	if not trace.Hit then return end
	if not trace.HitNonWorld then return end
	if not IsValid(trace.Entity) then return end
	if trace.Entity:GetPos():Distance(LocalPlayer():GetPos()) > 160 then return end

	local text = "ERROR"
	local font = "TargetID"

	if trace.Entity:IsPlayer() then
		text = trace.Entity:Nick()
	elseif trace.Entity:GetNWBool("player_corpse", false) then
		text = trace.Entity:GetNWString("player_nick", "Unknown")
	else
		return
		--text = trace.Entity:GetClass()
	end

	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)

	local MouseX, MouseY = gui.MousePos()

	if MouseX == 0 && MouseY == 0 then
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	end

	local x = MouseX
	local y = MouseY

	x = x - w / 2
	y = y + 30

	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 120))
	draw.SimpleText(text, font, x + 2, y + 2, Color(0, 0, 0, 50))
	draw.SimpleText(text, font, x, y, self:GetTeamColor( trace.Entity ))

	y = y + h + 5

	local text = trace.Entity:Health() .. "%"
	if trace.Entity:Health() < 1 then
		text = "Corpse"
	end
	local font = "TargetIDSmall"

	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)
	local x = MouseX - w / 2

	draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 120))
	draw.SimpleText(text, font, x + 2, y + 2, Color(0, 0, 0, 50))
	draw.SimpleText(text, font, x, y, self:GetTeamColor(trace.Entity))
end

local padding = 10

local function GetPadding()
	return padding, padding, padding, padding
end

net.Receive("br_openperkmenu", function(len)
	local PerkFrame = vgui.Create("DFrame")
	PerkFrame:SetSize(600, 300)
	PerkFrame:Center()
	PerkFrame:SetDraggable(true)
	PerkFrame:ShowCloseButton(true)
	PerkFrame:MakePopup()
	PerkFrame:SetTitle("Choose a perk")
	function PerkFrame:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 200))
	end

	local PerkScroll = vgui.Create("DScrollPanel", PerkFrame)
	PerkScroll:SetSize(280, 0)
	PerkScroll:Dock(FILL)
	PerkScroll:DockPadding(GetPadding())
	PerkScroll:DockMargin(GetPadding())

	local PerkPanels = {}
	local PerkButtons = {}
	-- local PerkModels = {}

	for k, v in SortedPairs(GAMEMODE.PerkInfo) do
		if k == PERK_NONE then continue end

		PerkPanels[#PerkPanels + 1] = vgui.Create("DPanel", PerkScroll)
		PerkPanels[#PerkPanels]:SetSize(0, 40)
		PerkPanels[#PerkPanels]:Dock(TOP)
		PerkPanels[#PerkPanels].Paint = function(self, w, h)
			draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 200))
		end

		PerkButtons[#PerkButtons + 1] = vgui.Create("DButton", PerkPanels[#PerkPanels])
		PerkButtons[#PerkButtons]:SetSize(260, 40)
		PerkButtons[#PerkButtons]:Dock(FILL)
		PerkButtons[#PerkButtons]:SetText(v.name)
		PerkButtons[#PerkButtons]:SetTooltip(v.desc)
		PerkButtons[#PerkButtons].DoClick = function()
			net.Start("br_selectperk")
			net.WriteInt(k, 6)
			net.SendToServer()
			PerkFrame:Remove()
		end

		-- PerkModels[#PerkModels + 1] = vgui.Create("ModelImage", PerkButtons[#PerkButtons])
		-- PerkModels[#PerkModels]:SetSize(40, 40)
		-- PerkModels[#PerkModels]:Dock(LEFT)
		-- PerkModels[#PerkModels]:DockMargin(5, 0, 0, 0)
		-- PerkModels[#PerkModels]:SetModel(v.model)
	end
end)

net.Receive("br_headshotsound", function(len)
	sound.Play(Sound("Bullet_Impact.Headshot"), LocalPlayer():GetPos())
end)
