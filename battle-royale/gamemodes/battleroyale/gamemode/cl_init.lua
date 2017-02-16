include("shared.lua")

function GM:SpawnMenuOpen()
	return LocalPlayer():IsAdmin()
end

function GM:ContextMenuOpen()
	return LocalPlayer():IsAdmin()
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
	PerkFrame:SetTitle("Inventory")
	function PerkFrame:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 200))
	end
	local PerkName = vgui.Create("DLabel", PerkFrame)
	PerkName:SetTextColor(color_white)
	PerkName:SetText(LocalPlayer():Nick())
	PerkName:Dock(TOP)

	local PerkScroll = vgui.Create("DScrollPanel", PerkFrame)
	PerkScroll:SetSize(280, 0)
	PerkScroll:Dock(FILL)
	PerkScroll:DockPadding(GetPadding())
	PerkScroll:DockMargin(GetPadding())

	local PerkPanels = {}
	local PerkButtons = {}
	-- local PerkModels = {}

	for k, v in SortedPairs(GM.PerkInfo) do
		if v <= 0 then continue end
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
		end
		-- PerkModels[#PerkModels + 1] = vgui.Create("ModelImage", PerkButtons[#PerkButtons])
		-- PerkModels[#PerkModels]:SetSize(40, 40)
		-- PerkModels[#PerkModels]:Dock(LEFT)
		-- PerkModels[#PerkModels]:DockMargin(5, 0, 0, 0)
		-- PerkModels[#PerkModels]:SetModel(v.model)
	en
end)
