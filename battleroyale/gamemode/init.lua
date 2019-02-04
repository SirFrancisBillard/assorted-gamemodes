AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local function LoadModules()
	local fol = GM.FolderName .. "/gamemode/modules/"
	local files, folders = file.Find(fol .. "*", "LUA")

	for k, v in pairs(files) do
		if string.GetExtensionFromFilename(v) ~= "lua" then continue end
		include(fol .. v)
	end

	for _, folder in SortedPairs(folders, true) do
		if folder == "." or folder == ".." then continue end

		for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
			AddCSLuaFile(fol .. folder .. "/" .. File)
			include(fol .. folder .. "/" .. File)
		end

		for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
			include(fol .. folder .. "/" .. File)
		end

		for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
			AddCSLuaFile(fol .. folder .. "/" .. File)
		end
	end
end

LoadModules()
