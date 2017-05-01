
GM.RagdollTypes = {
	[RAGTYPE_DEFAULT] = {
		bone_mods = {
			[1] = {}
		},
		on_create = function(ply, rag) end
	},
	[RAGTYPE_GIB] = { -- FIXME?
		bone_mods = {
			[1] = {}
		},
		on_create = function(ply, rag) end
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
	[RAGTYPE_BISECT] = { -- FIXME
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

			SafeRemoveEntityDelayed(top, 60)

			local bottom = ClientsideRagdoll("models/Gibs/Fast_Zombie_Legs.mdl")
			bottom:SetNoDraw(false)
			bottom:DrawShadow(true)
			bottom:SetPos(ply:GetPos())
			bottom:SetAngles(ply:GetAngles())

			SafeRemoveEntityDelayed(bottom, 60)
		end
	},
	[RAGTYPE_AMPUTATE] = {
		bone_mods = {
			[1] = { -- head
				--["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_Spine4"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Clavicle"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}--[[, -- FIXME
			[2] = { -- left arm
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine4"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[3] = { -- right arm
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine4"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[4] = { -- left leg
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine4"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[5] = { -- right leg
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine4"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}]]
		},
		on_create = function(ply, rag) end
	}
}
