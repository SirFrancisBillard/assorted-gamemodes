
GM.RagdollTypes = {
	[RAGTYPE_DEFAULT] = {
		bone_mods = {
			[1] = {}
		},
		on_create = function(ply, rag) end
	},
	[RAGTYPE_GIB] = {
		bone_mods = {
			[1] = {}
		},
		on_create = function(ply, rag)
			rag:Remove()

			local top = ClientsideRagdoll("models/Gibs/Fast_Zombie_Torso.mdl")
			top:SetNoDraw(false)
			top:DrawShadow(true)
			top:SetPos(ply:GetShootPos())
			top:SetAngles(ply:GetAngles())

			-- nonsolid to players, but can be picked up and shot
			top:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			timer.Simple(1, function()
				if IsValid(top) then
					top:CollisionRulesChanged()
				end
			end)

			-- position the bones
			local num = top:GetPhysicsObjectCount() - 1
			for i = 0, num do
				local bone = top:GetPhysicsObjectNum(i)
				if IsValid(bone) then
					local bp, ba = ply:GetBonePosition(top:TranslatePhysBoneToBone(i))
					if bp and ba then
						bone:SetPos(bp)
						bone:SetAngles(ba)
					end

					bone:SetVelocity(vector_origin)
				end
			end

			SafeRemoveEntityDelayed(top, 60)

			local bottom = ClientsideRagdoll("models/Gibs/Fast_Zombie_Legs.mdl")
			bottom:SetNoDraw(false)
			bottom:DrawShadow(true)
			bottom:SetPos(ply:GetPos())
			bottom:SetAngles(ply:GetAngles())

			-- nonsolid to players, but can be picked up and shot
			bottom:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			timer.Simple(1, function()
				if IsValid(bottom) then
					bottom:CollisionRulesChanged()
				end
			end)

			-- position the bones
			local num = bottom:GetPhysicsObjectCount() - 1
			for i = 0, num do
				local bone = bottom:GetPhysicsObjectNum(i)
				if IsValid(bone) then
					local bp, ba = ply:GetBonePosition(bottom:TranslatePhysBoneToBone(i))
					if bp and ba then
						bone:SetPos(bp)
						bone:SetAngles(ba)
					end

					bone:SetVelocity(vector_origin)
				end
			end

			SafeRemoveEntityDelayed(bottom, 60)
		end
	},
	[RAGTYPE_DECAP] = {
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function(ply, rag) end
	},
	[RAGTYPE_ARMS] = {
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function(ply, rag) end
	},
	[RAGTYPE_LEGS] = {
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function(ply, rag) end
	},
	[RAGTYPE_AMPUTEE] = {
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function(ply, rag) end
	}
}
