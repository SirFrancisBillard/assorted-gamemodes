
SHOP = {}

surface.CreateFont("Shooter_ShopMenu", {
	size = ScreenScale(8),
	weight = 800,
	antialias = true,
	shadow = false,
	font = "Comic Sans MS"
})

function SHOP:BuyItem(id)
	local m = tonumber(id)
	if not isnumber(m) then return false end
	RunConsoleCommand("shooter_buy", id)
	return true
end

function SHOP:SellItem(id)
	local m = tonumber(id)
	if not isnumber(m) then return false end
	RunConsoleCommand("shooter_sell", id)
	return true
end

local bux_icon = Material("icon16/money.png", "noclamp smooth")
local dark_red = Color(255, 100, 100)
local dark_green = Color(60, 255, 60)

local function ScaleX(size)
	return ScrW() * size / 1920
end

local function ScaleY(size)
	return ScrH() * size / 1080
end

function SHOP:Build()
	self:Destroy()

	self.Panel = vgui.Create("DFrame")
	self.Panel:SetTitle("Shop")
	self.Panel:SetSkin("MaterialMeepen")
	self.Panel:SetSize(ScaleX(1040), ScaleY(600))
	self.Panel:Center()
	self.Panel:MakePopup()

	local BuxPanel = vgui.Create("DPanel", self.Panel)
	BuxPanel:Dock(BOTTOM)

	local BuxIcon = vgui.Create("DImage", BuxPanel)
	BuxIcon:SetMaterial(bux_icon)
	BuxIcon:Dock(LEFT)

	local Bux = vgui.Create("DLabel", BuxPanel)
	Bux:SetText("Bux: " .. LocalPlayer():GetBux())
	Bux:SetFont("Shooter_ShopMenu")
	Bux:Dock(FILL)

	local Scroll = vgui.Create("DScrollPanel", self.Panel)
	Scroll:Dock(FILL)

	local List	= vgui.Create("DIconLayout", Scroll)
	List:Dock(FILL)

	for k, v in SortedPairsByMemberValue(ShopItems, "price") do
		local ListPanel = List:Add("DPanel")
		ListPanel:SetSize(ScaleX(500), ScaleY(350))

		local ListImage = vgui.Create("DModelPanel", ListPanel)
		ListImage:SetSize(ScaleX(500), ScaleY(250))
		ListImage:SetModel(v.model)
		ListImage.DoClick = function()
			if LocalPlayer():HasItem(k) then
				if self:SellItem(k) then
					chat.AddText(dark_green, "You have sold ", color_white, v.name, dark_green, ".")
					return self:Rebuild()
				end
				return chat.AddText(dark_red, "Uh oh! Looks like our code monkeys made a lil fucky wucky.")
			elseif not LocalPlayer():HasBux(v.price) then
				return chat.AddText(dark_red, "You cannot afford this item.")
			end
			if self:BuyItem(k) then
				chat.AddText(dark_green, "You have purchased ", color_white, v.name, dark_green, ".")
				return self:Rebuild()
			end
			return chat.AddText(dark_red, "Uh oh! Looks like our code monkeys made a lil fucky wucky.")
		end
		local mn, mx = ListImage.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

		ListImage:SetFOV( 45 )
		ListImage:SetCamPos( Vector( size, size, size ) )
		ListImage:SetLookAt( ( mn + mx ) * 0.5 )

		local ListLabel = vgui.Create("DLabel", ListPanel)
		ListLabel:SetSize(ScaleX(500), ScaleY(100))
		local x, y = ListLabel:GetPos()
		ListLabel:SetPos(x, y + ScaleY(250))
		ListLabel:SetText(v.name .. (LocalPlayer():HasItem(k) and " (OWNED)" or "") .. "\nPrice: " .. string.Comma(v.price) .. " Bux\n" .. v.desc)
		ListLabel:SetTextColor(color_black)
		ListLabel:SetFont("Shooter_ShopMenu")
	end
end

function SHOP:Destroy()
	if IsValid(SHOP.Panel) and type(SHOP.Panel.Remove) == "function" then
		SHOP.Panel:Remove()
	end
end

function SHOP:Rebuild()
	timer.Simple(0.5, function()
		if not IsValid(SHOP.Panel) then return end
		self:Destroy()
		self:Build()
	end)
end

function SHOP:Toggle()
	if IsValid(SHOP.Panel) then
		SHOP:Destroy()
	else
		SHOP:Build()
	end
end

concommand.Add("shooter_shop", function(ply, cmd, args, argsStr)
	SHOP:Toggle()
end)
