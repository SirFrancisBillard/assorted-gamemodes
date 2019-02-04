local PLAYER = FindMetaTable("Player")

function PLAYER:CanTase(target)
	return self:Team() ~= target:Team()
end

function PLAYER:Tase() -- DO ME
	self:Freeze(false)
	self:Kill()
end
