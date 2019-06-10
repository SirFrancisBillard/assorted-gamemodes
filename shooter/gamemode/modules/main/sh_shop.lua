
ITEM_TOPHAT = 1
ITEM_BACKPACK = 2
ITEM_NOSERING = 4
ITEM_BUMPSTOCK = 8
ITEM_BOOMBABY = 16
ITEM_SILENCER = 32
ITEM_BUCKSHOT = 64
-- "models/props/cs_office/Snowman_hat.mdl"
ShopItems = {
	[ITEM_TOPHAT] = {
		name = "Top Hat",
		desc = "Makes your head easy to shoot. Also very stylish.",
		price = 50,
		model = "models/player/items/humans/top_hat.mdl",
		worldmodel = {
			attach = "eyes",
			offsets = {forward = 2.5, up = 3, right = 0}
		}
	},
	[ITEM_BACKPACK] = {
		name = "Backpack",
		desc = "You can carry two primary weapons.",
		price = 80,
		model = "models/props_c17/BriefCase001a.mdl", -- "models/props_wasteland/controlroom_filecabinet001a.mdl"
		worldmodel = {
			attach = "eyes",
			offsets = {forward = 2.5, up = 3, right = 0}
		}
	},
	[ITEM_NOSERING] = {
		name = "Nose Ring",
		desc = "Doesn't do anything.",
		price = 20,
		model = "models/props_vehicles/carparts_tire01a.mdl",
		worldmodel = {
			attach = "eyes",
			offsets = {forward = 2.5, up = 3, right = 0}
		}
	},
	[ITEM_BUMPSTOCK] = {
		name = "Bump Stock",
		desc = "Your AR-15 will fire much faster.",
		price = 120,
		model = "models/weapons/w_rif_m4a1.mdl",
		worldmodel = {
			attach = "eyes",
			offsets = {forward = 2.5, up = 3, right = 0}
		}
	},
	[ITEM_BOOMBABY] = {
		name = "Boom Baby",
		desc = "Drops an explosive baby on death.",
		price = 300,
		model = "models/props_c17/doll01.mdl",
		worldmodel = {
			attach = "eyes",
			offsets = {forward = 2.5, up = 3, right = 0}
		}
	},
	[ITEM_SILENCER] = {
		name = "Silencer",
		desc = "Pistol shots are much quieter.",
		price = 450,
		model = "models/props_c17/doll01.mdl",
	},
	[ITEM_BUCKSHOT] = {
		name = "Advanced Buckshot",
		desc = "Your AK-47 will fire multiple shots at once.",
		price = 800,
		model = "models/props_c17/doll01.mdl",
	},
}

local PLAYER = FindMetaTable("Player")

function PLAYER:Inventory()
	return self:GetNWInt("inv", 0)
end

function PLAYER:HasItem(id)
	return bit.band(self:Inventory(), id) ~= 0
end

function PLAYER:GetBux()
	return self:GetNWInt("bux", 0)
end

function PLAYER:HasBux(amt)
	return self:GetNWInt("bux", 0) >= amt
end

if CLIENT then return end

file.CreateDir("shooterdata")

function PLAYER:SetBux(amt)
	self:SetNWInt("bux", amt)
	if not self:IsBot() then
		file.Write("shooterdata/bux_" .. self:SteamID64() .. ".txt", self:GetBux())
	end
end

function PLAYER:AddBux(amt)
	self:SetBux(self:GetBux() + amt)
end

function PLAYER:GiveItem(id)
	self:SetNWInt("inv", bit.bor(self:Inventory(), id))
	if not self:IsBot() then
		file.Write("shooterdata/inv_" .. self:SteamID64() .. ".txt", self:Inventory())
	end
end

function PLAYER:TakeItem(id)
	if not self:HasItem(id) then return end
	self:SetNWInt("inv", bit.band(self:Inventory(), bit.bnot(id)))
	if not self:IsBot() then
		file.Write("shooterdata/inv_" .. self:SteamID64() .. ".txt", self:Inventory())
	end
end

concommand.Add("shooter_buy", function(ply, cmd, args)
	local id = tonumber(args[1])
	if type(id) ~= "number" or not ShopItems[id] or ply:HasItem(id) or not ply:HasBux(ShopItems[id].price) then return end
	ply:AddBux(-ShopItems[id].price)
	ply:GiveItem(id)
end)

concommand.Add("shooter_sell", function(ply, cmd, args)
	local id = tonumber(args[1])
	if type(id) ~= "number" or not ShopItems[id] or not ply:HasItem(id) then return end
	ply:AddBux(ShopItems[id].price)
	ply:TakeItem(id)
end)

function GM:ShowHelp(ply)
	ply:ConCommand("shooter_shop")
end

function GM:ShowTeam(ply)
	ply:ConCommand("shooter_shop")
end

function GM:ShowSpare1(ply)
	ply:ConCommand("shooter_shop")
end

function GM:ShowSpare2(ply)
	ply:ConCommand("shooter_shop")
end
