
RegisterLuaAnimation('lean_left', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine'] = {
					--RU = -16,
					RR = -48
				}
			},
			FrameRate = 1
		}
	},
	Type = TYPE_POSTURE
})

RegisterLuaAnimation('lean_right', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Spine'] = {
					--RU = 16,
					RR = 48
				}
			},
			FrameRate = 1
		}
	},
	Type = TYPE_POSTURE
})

RegisterLuaAnimation('sit_chell', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 144,
					RF = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -64,
					RR = -16
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -32
				},
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 144,
					RF = -96
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -64
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 64
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -32,
					RR = -80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 64
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32,
					RR = 80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -28
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -28
				},
			},
			FrameRate = 6
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 144,
					RF = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -64,
					RR = -16
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -32
				},
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 144,
					RF = -96
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -64
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 64
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -32,
					RR = -80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 64
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32,
					RR = 80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -28
				},
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_SEQUENCE
})

RegisterLuaAnimation('kick_right', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 102.3071
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -115.61723942681,
					RR = 2.8260262315056,
					RF = -4.6652460583237
				},
				['ValveBiped.Bip01_L_Thigh'] = {
				},
				['ValveBiped.Bip01_R_Foot'] = {
					RU = -29.918,
					RR = 2.116,
					RF = -9.5646
				}
			},
			FrameRate = 6
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = -21.8525
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -58.9163,
					RR = 31.819313763098,
					RF = 2.3538658102721
				},
				['ValveBiped.Bip01_L_Thigh'] = {
				},
				['ValveBiped.Bip01_R_Foot'] = {
					RU = -4.7768
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
				},
				['ValveBiped.Bip01_R_Thigh'] = {
				},
				['ValveBiped.Bip01_L_Thigh'] = {
				},
				['ValveBiped.Bip01_R_Foot'] = {
				}
			},
			FrameRate = 5
		}
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('kys_pistol', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 67.182433367961,
					RR = 10.301412030766
				},
				['ValveBiped.Bip01_R_Toe0'] = {
				},
				['ValveBiped.Bip01_Head1'] = {
					RU = -8.9601009423707,
					RR = 16.997394485779,
					RF = 11.579986739119
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 77.800032673968,
					RR = 131.27489772008,
					MF = -1.625353119467,
					RF = 34.796849403735
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -66.954945766385,
					RR = 175.94066895144,
					RF = 114.43187626885
				}
			},
			FrameRate = 1
		}
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('fallover', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
					RU = 1.4191229373292,
					MU = -34.716697686514,
					MF = -33.870008397232,
					MR = -0.071548396158521,
					RF = -93.895855413429
				}
			},
			FrameRate = 10
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
					RU = 1.4191229373292,
					MU = -34.716697686514,
					MF = -33.870008397232,
					MR = -0.071548396158521,
					RF = -93.895855413429
				}
			},
			FrameRate = 1
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
				}
			},
			FrameRate = 3
		}
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('baseball_slide', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 48,
					RF = 80
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = -32
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -48,
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -31
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -32
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 64,
					RR = -48
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 48,
					RF = 80
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = -32
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -48,
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 64,
					RR = -48
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -32
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -31
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_SEQUENCE
})

RegisterLuaAnimation('sit_alyx', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 128,
					RF = -32
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 32,
					RF = 64
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RR = 32
				},
				['ValveBiped.Bip01_L_Foot'] = {
					RU = 32
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RR = -32
				},
				['ValveBiped.Bip01_R_Foot'] = {
					RU = 48
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -64,
					RF = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -30,
					RF = -16
				},
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 80
				}
			},
			FrameRate = 4
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 128,
					RF = -32
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 32,
					RF = 64
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RR = 32
				},
				['ValveBiped.Bip01_L_Foot'] = {
					RU = 32
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
					RR = -32
				},
				['ValveBiped.Bip01_R_Foot'] = {
					RU = 48
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -64,
					RF = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -30,
					RF = -16
				},
				['ValveBiped.Bip01_L_Calf'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 80
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_SEQUENCE
})

RegisterLuaAnimation('kys_pistol', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 67.182433367961,
					RR = 10.301412030766
				},
				['ValveBiped.Bip01_R_Toe0'] = {
				},
				['ValveBiped.Bip01_Head1'] = {
					RU = -8.9601009423707,
					RR = 16.997394485779,
					RF = 11.579986739119
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 77.800032673968,
					RR = 131.27489772008,
					MF = -1.625353119467,
					RF = 34.796849403735
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -66.954945766385,
					RR = 175.94066895144,
					RF = 114.43187626885
				}
			},
			FrameRate = 0.5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = 67.182433367961,
					RR = 10.301412030766
				},
				['ValveBiped.Bip01_R_Toe0'] = {
				},
				['ValveBiped.Bip01_Head1'] = {
					RU = -8.9601009423707,
					RR = 16.997394485779,
					RF = 11.579986739119
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 77.800032673968,
					RR = 131.27489772008,
					MF = -1.625353119467,
					RF = 34.796849403735
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -66.954945766385,
					RR = 175.94066895144,
					RF = 114.43187626885
				}
			},
			FrameRate = 0.2
		}
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('pipebomb_light', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -32,
					RR = -16
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = 16,
					RF = -48
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32,
					RR = 32
				}
			},
			FrameRate = 1
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = 0,
					RR = 0
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = 0,
					RF = 0
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 0,
					RR = 0
				}
			},
			FrameRate = 1
		},
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('kys_mp5', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -144,
					RR = 32
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = 48,
					RF = -48
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RF = 112
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 16,
					RR = 16
				}
			},
			FrameRate = 1
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_UpperArm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_R_Hand'] = {
					RU = -144,
					RR = 32
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = 48,
					RF = -48
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 80
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RF = 112
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 16,
					RR = 16
				}
			},
			FrameRate = 0.2
		}
	},
	Type = TYPE_GESTURE
})
