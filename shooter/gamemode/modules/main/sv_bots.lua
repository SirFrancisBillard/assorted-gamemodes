
do return end -- there is a bug where bots created using CreateNextBot cannot change their angles

local BotNames = {
	"Eric",
	"Dylan",
	"Rock",
	"Biff",
	"Lilac",
	"Numbnut",
	"Sam",
	"Albini",
	"Delta",
	"Foxtrot",
	"Wayne",
	"Tyler",
}

function KickAllBots()
	for k, v in pairs(player.GetBots()) do
		v:Kick("Later nerd")
		break
	end
end

function UpdateBots()
	if game.SinglePlayer() then return end

	if player.GetCount() >= game.MaxPlayers() - 1 then
		for k, v in RandomPairs(player.GetBots()) do
			v:Kick("Later nerd")
			break
		end
		return
	else
		local add = game.MaxPlayers() - (player.GetCount() + 1)
		for i = 1, add do
			player.CreateNextBot(BotNames[#player.GetBots() + 1])
		end
	end
end

hook.Add("PlayerInitialSpawn", "UpdateNextBots", UpdateBots)
hook.Add("PlayerDisconnect", "UpdateNextBots", UpdateBots)
