if not game:IsLoaded() then
	game.Loaded:Wait()
end

local tbl

tbl = {
	Players = game:GetService("Players"),
	UserInputService = game:GetService("UserInputService"),
	Lighting = game:GetService("Lighting"),
	RunService = game:GetService("RunService"),
	CoreGui = game:GetService("CoreGui"),
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	VirtualInputManager = game:GetService("VirtualInputManager"),
	VirtualUser = game:GetService("VirtualUser"),
	HttpService = game:GetService("HttpService"),
	Stats = game:GetService("Stats"),
	Workspace = game:GetService("Workspace"),
	TeleportService = game:GetService("TeleportService"),
	GuiService = game:GetService("GuiService"),
	RbxAnalytics = game:GetService("RbxAnalyticsService"),
	LocalPlayer = game:GetService("Players").LocalPlayer,
	Terrain = game:GetService("Workspace").Terrain,
	Camera = workspace.CurrentCamera,
}

local Debris
Debris = game:GetService("Debris")
local remotes
remotes = tbl.ReplicatedStorage:WaitForChild("Remotes", 10)
local repairEvent, skillCheckResultEvent
local generator = remotes and remotes:FindFirstChild("Generator")
repairEvent = generator and generator:FindFirstChild("RepairEvent")
skillCheckResultEvent = generator and generator:FindFirstChild("SkillCheckResultEvent")
local parry, flag, expired, userThumbnailAsync, tbl2, tbl3, tbl4, tbl5, tbl6, tbl7
local tbl8, tbl9, str, v, humanoidRootPart, humanoid, tbl10, str2, fn
local fn2, tbl11, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fn10
local fn11, fn12, fn13, fn14, fn15, fn16

do
	local palletDropEvent = remotes and remotes:FindFirstChild("Pallet") and remotes.Pallet:FindFirstChild("PalletDropEvent")
	parry = remotes and remotes:FindFirstChild("Items") and remotes.Items:FindFirstChild("Parrying Dagger") and remotes.Items["Parrying Dagger"]:FindFirstChild("parry")
	flag = false
	expired = "Unknown"
	userThumbnailAsync = tbl.Players:GetUserThumbnailAsync(tbl.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

	tbl2 = {
		icon = "121088593459735",
		name = "JEJE LOL",
		version = "Finall",
		dc = "https://discord.gg/9EwGEhAvkV",
		tt = "None",
	}

	tbl3 = {
		AUTO_AutoSurvivor = false,
		AUTO_Generator = false,
		AUTO_LeaveDist = 45,
		TP_Offset = 5,
		Pistol_CustomSound = false,
		Pistol_SelectedSound = "Sound 1",
		ESP_Master = false,
		ESP_Player = false,
		ESP_Killer = false,
		ESP_SCP = false,
		ESP_Name = false,
		ESP_NameG = false,
		ESP_Outline = false,
		ESP_ItemIcon = false,
		ESP_MaxDistance = 200,
		ESP_Generator = false,
		ESP_Pallet = false,
		ESP_Hook = false,
		ESP_Gate = false,
		ESP_Window = false,
		ESP_KillerWarn = false,
		Killer_SpamHit = false,
		Killer_SpamHitRadius = 15,
		Killer_SpamHitDelay = 100,
		Killer_HitEspCircle = true,
		Killer_BreakSpeed = 1,
		Killer_BypassCarry = false,
		Killer_WalkSpeedToggle = false,
		Killer_WalkSpeed = 16,
		Killer_AttackMode = "BasicAttack",
		Killer_3rdPerson = false,
		Killer_CameraMode = "Classic",
		Killer_InfAbyssal = false,
		Killer_InfLunge = false,
		Killer_InfLungeV2 = false,
		Anti_Blind = false,
		Show_Stun = false,
		Surv_Parry = false,
		Surv_ParryV2 = false,
		Surv_ParryCircle = true,
		Surv_ParryAggressive = false,
		Surv_ParrySafety = false,
		Surv_ParryRadius = 15,
		Surv_ParryFace = 0.7,
		Ignored_Skills_List = {},
		Surv_GodMode = false,
		Surv_SelfHeal = false,
		Surv_AuraHeal = false,
		Surv_AutoCancelGene = false,
		Surv_DoubleGen = false,
		Surv_AutoSprint = false,
		Surv_Bandage = false,
		Surv_SoundDbd = false,
		Surv_AutoSkillCheck = false,
		Surv_SkillCheckMode = "Legit",
		Surv_SkillFrequency = 10,
		Surv_SkillSpeed = 1,
		Surv_PerfectSkill = true,
		Surv_NoSkill = false,
		Surv_Perks = false,
		Surv_SpeedBoost = 1.1,
		Surv_VaultSpeed = 1.3,
		Surv_SpeedAfterVault = false,
		Surv_FastVault = false,
		Surv_PerfectVault = false,
		Surv_AutoCrouch = false,
		Surv_NoFall = false,
		Surv_AutoFlee = false,
		Surv_FleeDistance = 30,
		Surv_AutoPallet = false,
		Surv_AutoPalletRadius = 10,
		Surv_AutoPalletSM = true,
		Surv_AutoPalletSF = false,
		Surv_CrouchV = false,
		Surv_Spdb = false,
		Surv_QuickRecoveryCD = 15,
		Surv_FlowstateCD = 20,
		Surv_Fov = false,
		Surv_FOV_Value = 70,
		Aimbot_Enabled = false,
		Aimbot_ShowFOV = true,
		Aimbot_Radius = 150,
		Aimbot_MaxDist = 300,
		Aimbot_Smoothness = 0.5,
		Aimbot_Predict = 0.01,
		Aim_Silent = false,
		Aim_Lock = false,
		Predict = false,
		SmartPredict = false,
		AIM_TargetPart = "Torso",
		Pistol_Target = "Killer",
		Pistol_PredictLead = 3.5,
		Pistol_AimOffset = -1,
		Pistol_BlockKnocked = true,
		Pistol_FOVMode = false,
		Pistol_ShowFOV = false,
		Pistol_FOV = 150,
		Pistol_ShowLaser = true,
		Flash_Silent = false,
		Flash_YOffset = 8,
		Aim_SilentVeil = false,
		Veil_ShowFOV = true,
		Veil_LeadMultiplier = 1.7,
		Veil_FOV = 150,
		Veil_ShowLaser = true,
		SPEAR_Auto = false,
		SPEAR_Speed = 165,
		SPEAR_Gravity = workspace.Gravity * 0.5,
		SPEAR_MaxDist = 200,
		Crosshair_Enabled = false,
		Crosshair_Type = "Cross",
		Crosshair_Color = Color3.new(0, 1, 0),
		Crosshair_Size = 4,
		Crosshair_OffsetX = 0,
		Crosshair_OffsetY = 0,
		Misc_Invisible = false,
		Misc_FakeName = false,
		Misc_FakeAttributes = false,
		Misc_CopyAvatar = false,
		Misc_Noclip = false,
		Misc_FlyToggle = false,
		Misc_FlySpeed = 10,
		Misc_HighJump = false,
		Misc_JumpPower = 50,
		Misc_InfJump = false,
		Misc_InfiniteZoom = false,
		Misc_Fullbright = false,
		Misc_Potato = false,
		Misc_SkipCutscene = false,
		Misc_SmoothCam = false,
		Misc_CamHeight = -1,
		Misc_CamStiffness = 9.5,
		Misc_SmoothHDR = false,
		Next_Map = true,
	}

	tbl4 = {}
	tbl4.Level = tbl.LocalPlayer:GetAttribute("Level") or 0
	tbl4.Gears = tbl.LocalPlayer:GetAttribute("Gears") or 0
	tbl4.Screws = tbl.LocalPlayer:GetAttribute("Screws") or 0

	tbl5 = {
		["122812055447896"] = "Veil lunge",
		["133963973694098"] = "Mayers Basic",
		["117042998468241"] = "Mayers lunge",
		["135002183282873"] = "cure lunge",
		["121216847022485"] = "cure Basic",
		["132817836308238"] = "Jeff Basic",
		["129784271201071"] = "Jeff lunge",
		["82666958311998"] = "Jeff Frenzy",
		["78432063483146"] = "Abyssal Basic",
		["118907603246885"] = "Abyssal lunge",
		["139369275981139"] = "Jason Basic",
		["110355011987939"] = "Jason lunge",
		["111920872708571"] = "Masked Basic",
		["105374834496520"] = "Masked lunge",
		["138720291317243"] = "Masked Tony",
		["106871536134254"] = "Masked Alex",
		["130593238885843"] = "Masked Cobra",
		["115244153053858"] = "Masked Cobra lunge",
		["74968262036854"] = "Hidden Basic",
		["113255068724446"] = "Hidden lunge",
		["98163597193511"] = "Hidden S1",
		["80411309607666"] = "Abyssal S1",
	}

	tbl6 = {
		Unloaded = false,
		OriginalSpeed = 16,
		isPredicting = false,
		CutsceneConn = nil,
		CharCutscene = nil,
		FleeThread = nil,
		RandomMode_IsNormal = false,
		AutoSprintThread = nil,
		OriginalLighting = nil,
		CurrentPing = 0,
		QuickRecoveryOnCD = false,
		FlowstateOnCD = false,
		HookF = false,
		Bandage = false,
		isAimLocking = false,
		currentTarget = nil,
		lockTimerThread = nil,
		lastNoclipChar = nil,
		lastUpdate = 0,
		lastSpam = 0,
		spearSwitchCooldown = false,
		SpearModeConn = nil,
		StunConn = nil,
		CurrentTeleportGen = nil,
		CurrentTeleportPlayer = nil,
		CurrentTeleportHook = nil,
		CurrentTeleportGate = nil,
		KillerTarget = nil,
		SpamHit = nil,
		autoParry = nil,
		CrosshairUI = nil,
		WatermarkUI = nil,
		ItemESPs = {},
		FlyConnection = nil,
		FollowConnection = nil,
		InfiniteZoomConn = nil,
		ThirdPersonCamConn = nil,
		blockThread = nil,
		AutoPalletThread = nil,
		VaultBoostThread = nil,
		Pv2Con = nil,
		lungeV2Connection = nil,
		ParryCooldown = false,
		ParryCooldownTime = 50,
		RepairEngineRunning = false,
		VaultBoostActive = false,
		AutoFollow = false,
		isHoldingLunge = false,
		isAttackCd = false,
		isHolding = false,
		cachedNoclipParts = {},
		ActiveAnimations = {},
		SpooferConns = {},
		TeamConnections = {},
		DroppedPallets = {},
		TrackV2 = {},
		touchLunge = nil,
		currentTouch = nil,
		locked = nil,
	}

	tbl7 = {
		Colors = {
			SCP = Color3.fromRGB(150, 0, 255),
			Player = Color3.fromRGB(0, 255, 255),
			Killer = Color3.fromRGB(255, 0, 0),
			Generator = Color3.fromRGB(255, 255, 0),
			GeneratorDone = Color3.fromRGB(0, 255, 0),
			Pallet = Color3.fromRGB(255, 128, 0),
			Hook = Color3.fromRGB(255, 105, 180),
			Gate = Color3.fromRGB(255, 255, 255),
			Window = Color3.fromRGB(0, 150, 255),
		},
		Bones_R6 = {
			{ "Head", "Torso" },
			{ "Torso", "Left Arm" },
			{ "Torso", "Right Arm" },
			{ "Torso", "Left Leg" },
			{ "Torso", "Right Leg" },
		},
	}

	tbl8 = {
		isChargingSpear = false,
		isChargingPistol = false,
		isAimingFlash = false,
		currentTouchInput = nil,
		isAimbotHolding = false,
		lockedAimbotTarget = nil,
	}

	tbl9 = {
		Visibility = {},
		Generators = {},
		Pallets = {},
		Hooks = {},
		Gates = {},
		Windows = {},
		SCPs = {},
	}

	str = "Spectator"
	v = nil
	humanoidRootPart = nil
	humanoid = nil

	tbl10 = {
		WEB = "https://panel.vdtixo.store",
		SCRIPT = "https://script.vdtixo.store",
		keyFile = "VD_KeySave.txt",
		cache = "JEJE/Log/KeyCache.json",
		srvID = "22403",
		plaS = "0b813828-bf1b-48b1-b973-c29340d10d2e",
	}

	-- Developer-unlocked build: online key verification removed.
	flag = true
	expired = "Unlimited"
	str2 = "DEV-UNLOCKED"

	fn2 = function(arg, arg2, arg3)
		getgenv().Library:Notify({ Title = "Tixo Hub", Description = arg, Time = arg2 or 3, Icon = "bell", SoundId = arg3 })
	end

	tbl11 = {}

	fn3 = function()
		table.clear(tbl11)

		for _, player in ipairs(tbl.Players:GetPlayers()) do
			if player ~= tbl.LocalPlayer then
				table.insert(tbl11, player)
			end
		end
	end

	tbl.Players.PlayerAdded:Connect(fn3)
	tbl.Players.PlayerRemoving:Connect(fn3)
	fn3()

	fn4 = function(arg)
		v = arg
		humanoidRootPart = arg:WaitForChild("HumanoidRootPart", 3)
		humanoid = arg:WaitForChild("Humanoid", 3)

		if humanoid then
			tbl6.OriginalSpeed = humanoid.WalkSpeed
		end
	end

	fn5 = function()
		return str
	end

	fn6 = function(arg)
		return arg and arg.Team and arg.Team.Name == "Killer"
	end

	fn7 = function(arg)
		return arg and arg.Team and arg.Team.Name == "Survivors"
	end

	fn8 = function()
		return humanoidRootPart
	end

	fn9 = function(arg)
		local v3 = fn8()
		if not v3 then
			return math.huge
		end
		return (arg - v3.Position).Magnitude
	end

	fn10 = function()
		local v3 = fn8()
		if not v3 then
			return math.huge
		end
		local huge = math.huge

		for _, player in pairs(tbl.Players:GetPlayers()) do
			if player ~= tbl.LocalPlayer and fn6(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local magnitude = (player.Character.HumanoidRootPart.Position - v3.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
				end
			end
		end

		return huge
	end

	fn11 = function(arg)
		if not arg then
			return false
		end
		return arg:GetAttribute("Knocked") == true or arg:GetAttribute("IsHooked") == true
	end

	fn12 = function(arg)
		if not arg then
			return true
		end
		local playerFromCharacter = tbl.Players:GetPlayerFromCharacter(arg)
		if playerFromCharacter and playerFromCharacter:GetAttribute("IsDead") then
			return true
		end

		if arg:GetAttribute("IsCarried") or arg:GetAttribute("IsHooked") or arg:GetAttribute("Knocked") then
			return true
		end
		local checkInterractable = arg:FindFirstChild("CheckInterractable")

		if checkInterractable then
			for _, v3 in ipairs({
				"isVaulting",
				"isSliding",
				"isDroppingPallet",
				"isRepairing",
				"isHealing",
				"isUnhooking",
				"isExiting",
			}) do
				if checkInterractable:GetAttribute(v3) == true then
					return true
				end
			end
		end

		return false
	end

	fn13 = function(arg)
		if not tbl3.Surv_ParrySafety then
			return true
		end

		if not arg then
			return false
		end
		local checkInterractable = arg:FindFirstChild("CheckInterractable")

		if checkInterractable then
			if checkInterractable:GetAttribute("isVaulting") == true then
				return false
			end

			if checkInterractable:GetAttribute("isRepairing") == true then
				return false
			end

			if checkInterractable:GetAttribute("isUnhooking") == true then
				return false
			end

			if checkInterractable:GetAttribute("isHealing") == true then
				return false
			end

			if checkInterractable:GetAttribute("isSliding") == true then
				return false
			end
		end

		return true
	end

	fn14 = function()
		local v3 = fn8()
		local map = tbl.Workspace:FindFirstChild("Map")
		if not v3 or not map then
			return false
		end
		local position = nil

		pcall(function()
			for _, descendant in ipairs(map:GetDescendants()) do
				local v4 = string.lower(descendant.Name)

				if v4 == "fininshline" or v4 == "finishline" or string.find(v4, "finish") then
					if descendant:IsA("BasePart") then
						position = descendant.Position
						break
					elseif descendant:IsA("Model") then
						local basePart = descendant:FindFirstChildWhichIsA("BasePart")
						if basePart then
							position = basePart.Position
							break
						end
					end
				end
			end

			if not position then
				if map:FindFirstChild("RooftopHitbox") or map:FindFirstChild("Rooftop") then
					position = Vector3.new(3098.16, 454.04, -4918.74)
				elseif map:FindFirstChild("HooksMeat") then
					position = Vector3.new(1546.12, 152.21, -796.72)
				elseif map:FindFirstChild("churchbell") then
					position = Vector3.new(760.98, -20.14, -78.48)
				else
					for _, descendant in ipairs(map:GetDescendants()) do
						if descendant:IsA("MeshPart") and descendant.Material == Enum.Material.Limestone then
							position = Vector3.new(-947.9, 152.12, -7579.52)
							break
						elseif descendant:IsA("MeshPart") and descendant.Material == Enum.Material.Leather then
							position = Vector3.new(1546.12, 152.21, -796.72)
							break
						end
					end
				end
			end
		end)

		if position then
			v3.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
			return true
		end
		return false
	end

	local function fn22(character)
		if not character then
			return
		end

		task.spawn(function()
			local cutscene = character:WaitForChild("cutscene", 5)

			if cutscene and cutscene:IsA("LocalScript") then
				if tbl3.Misc_SkipCutscene then
					cutscene.Disabled = true
				end

				if tbl6.CutsceneConn then
					tbl6.CutsceneConn:Disconnect()
				end

				tbl6.CutsceneConn = cutscene:GetPropertyChangedSignal("Disabled"):Connect(function()
					if tbl3.Misc_SkipCutscene and not cutscene.Disabled then
						cutscene.Disabled = true
					end
				end)
			end
		end)
	end

	fn15 = function(miscSkipCutscene)
		tbl3.Misc_SkipCutscene = miscSkipCutscene
		local character = tbl.LocalPlayer.Character

		if miscSkipCutscene then
			if character then
				fn22(character)
			end

			if tbl6.CharCutscene then
				tbl6.CharCutscene:Disconnect()
			end

			tbl6.CharCutscene = tbl.LocalPlayer.CharacterAdded:Connect(fn22)
		else
			if tbl6.CutsceneConn then
				tbl6.CutsceneConn:Disconnect()
				tbl6.CutsceneConn = nil
			end

			if tbl6.CharCutscene then
				tbl6.CharCutscene:Disconnect()
				tbl6.CharCutscene = nil
			end

			if character then
				local cutscene = character:FindFirstChild("cutscene")

				if cutscene and cutscene:IsA("LocalScript") then
					cutscene.Disabled = false
				end
			end
		end
	end

	fn16 = function(survAutoPallet)
		tbl3.Surv_AutoPallet = survAutoPallet

		if survAutoPallet then
			if tbl6.AutoPalletThread then
				task.cancel(tbl6.AutoPalletThread)
			end

			tbl6.AutoPalletThread = task.spawn(function()
				while tbl3.Surv_AutoPallet and not tbl6.Unloaded do
					task.wait(0.1)

					if palletDropEvent then
						local character = tbl.LocalPlayer.Character
						local v3 = fn8()

						if v3 and character then
							local flag2 = character:GetAttribute("IsHooked") == true or character:GetAttribute("isHooked") == true
							local flag3 = character:GetAttribute("isCarried") == true or character:GetAttribute("IsCarried") == true or character:GetAttribute("Carried") == true
							local flag4 = (character:GetAttribute("Knocked") == true or character:GetAttribute("isKnocked") == true) and not flag3
							local flag5

							if flag2 or flag4 then
								flag5 = false
							else
								local survAutoPalletSM = flag3 and tbl3.Surv_AutoPalletSM
								flag5 = true

								if survAutoPalletSM then
									flag5 = false
								end
							end

							if flag5 then
								local tbl12 = {}

								for _, v4 in ipairs(tbl11) do
									if fn6(v4) and v4.Character then
										local humanoidRootPart2 = v4.Character:FindFirstChild("HumanoidRootPart")

										if humanoidRootPart2 then
											table.insert(tbl12, { root = humanoidRootPart2, char = v4.Character })
										end
									end
								end

								if #tbl12 > 0 then
									for _, pallet in ipairs(tbl9.Pallets) do
										local model = pallet.model
										local trigger = pallet.trigger
										local palletPointSlide

										if trigger then
											palletPointSlide = trigger
										elseif model then
											palletPointSlide = model:FindFirstChild("PalletPointSlide", true) or model:FindFirstChild("PalletPoint", true)
										else
											palletPointSlide = model
										end

										if model and model.Parent and palletPointSlide and not tbl6.DroppedPallets[model] then
											local magnitude = (v3.Position - palletPointSlide.Position).Magnitude
											local flag6 = false

											for _, v4 in ipairs(tbl12) do
												local magnitude2 = (v4.root.Position - palletPointSlide.Position).Magnitude
												local flag7 = v4.char:GetAttribute("IsCarrying") == true or v4.char:GetAttribute("isCarrying") == true

												if flag3 then
													if magnitude <= tbl3.Surv_AutoPalletRadius or magnitude2 <= tbl3.Surv_AutoPalletRadius then
														flag6 = true
														break
													else
														flag6 = false
													end
												elseif flag7 and tbl3.Surv_AutoPalletSF then
													if not (magnitude2 <= 6.5) then
														flag6 = false
													else
														flag6 = true
														break
													end
												elseif magnitude <= tbl3.Surv_AutoPalletRadius and magnitude2 <= tbl3.Surv_AutoPalletRadius then
													flag6 = true
													break
												else
													flag6 = false
												end
											end

											if flag6 then
												pcall(function()
													palletDropEvent:FireServer(palletPointSlide)
												end)

												tbl6.DroppedPallets[model] = true
											end
										end
									end
								end
							end
						end
					end
				end
			end)
		else
			if tbl6.AutoPalletThread then
				task.cancel(tbl6.AutoPalletThread)
				tbl6.AutoPalletThread = nil
			end

			table.clear(tbl6.DroppedPallets)
		end
	end
end

local fn17

do
	local flag2 = false
	local n = 0

	fn17 = function(arg)
		if flag2 then
			return
		end

		if not arg and os.clock() - n < 3 then
			return
		end
		flag2 = true
		n = os.clock()
		table.clear(tbl9.Generators)
		table.clear(tbl9.Windows)
		table.clear(tbl9.Pallets)
		table.clear(tbl9.Hooks)
		table.clear(tbl9.Gates)
		table.clear(tbl9.SCPs)
		table.clear(tbl6.DroppedPallets)
		local descendants = tbl.Workspace:GetDescendants()

		for i, descendant in ipairs(descendants) do
			if i % 300 == 0 then
				task.wait()
			end

			if descendant:IsA("Model") then
				local v2 = string.lower(descendant.Name)

				if v2 == "generator" then
					local basePart = descendant:FindFirstChildWhichIsA("BasePart")

					if basePart then
						table.insert(tbl9.Generators, { model = descendant, part = basePart })
					end
				elseif v2 == "hook" and descendant:FindFirstChild("HookPoint") then
					table.insert(tbl9.Hooks, descendant)
				elseif v2 == "gate" and descendant:FindFirstChild("ExitLever") then
					table.insert(tbl9.Gates, descendant)
				elseif v2 == "window" then
					table.insert(tbl9.Windows, descendant)
				elseif string.match(v2, "^scp") then
					table.insert(tbl9.SCPs, descendant)
				end
			elseif descendant:IsA("BasePart") and descendant.Name == "PrimaryPartPallet" then
				local parent = descendant.Parent

				if parent then
					local flag3 = false

					for _, pallet in ipairs(tbl9.Pallets) do
						if pallet.model == parent then
							flag3 = true
							break
						end
					end

					if not flag3 then
						table.insert(tbl9.Pallets, {
							model = parent,
							trigger = parent:FindFirstChild("PalletPointSlide", true) or parent:FindFirstChild("PalletPoint", true),
						})
					end
				end
			end
		end

		flag2 = false
	end
end

if tbl.CoreGui:FindFirstChild("WM") then
	tbl.CoreGui:FindFirstChild("WM"):Destroy()
end

tbl6.WatermarkUI = Instance.new("ScreenGui")
tbl6.WatermarkUI.Name = "WM"
tbl6.WatermarkUI.Parent = tbl.CoreGui
tbl6.WatermarkUI.IgnoreGuiInset = true
tbl6.WatermarkUI.Enabled = true
tbl6.WatermarkUI.ResetOnSpawn = false
local frame
frame = Instance.new("Frame")
frame.Name = "Bubble"
frame.Size = UDim2.new(0, 110, 0, 20)
frame.Position = UDim2.new(0.5, 0, 0.95, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BackgroundTransparency = 0.5
frame.Active = true
frame.Parent = tbl6.WatermarkUI
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local textLabel

do
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = Color3.fromRGB(255, 255, 255)
	uiStroke.Thickness = 1
	uiStroke.Parent = frame
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.Transparency = 0.25
	local uiGradient = Instance.new("UIGradient")
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)), new(1, color(50, 50, 50)) })
	uiGradient.Rotation = 90
	uiGradient.Parent = frame
	textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamSemibold
	textLabel.TextSize = 11
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Text = "JEJE_LOL | FPS: ... | Ping: ..."
	textLabel.Parent = frame
	local uiGradient2 = Instance.new("UIGradient")
	local colorSequence = ColorSequence.new
	local tbl12 = {}
	local v2 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255))
	local v3 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 180))
	local new2 = ColorSequenceKeypoint.new
	local color2 = Color3.fromRGB
	tbl12[1] = v2
	tbl12[2] = v3

	do
		local values = table.pack(new2(1, color2(255, 255, 255)))
		table.move(values, 1, values.n, 3, tbl12)
	end

	uiGradient2.Color = colorSequence(tbl12)
	local numberSequence = NumberSequence.new
	local tbl13 = {}
	local v4 = NumberSequenceKeypoint.new(0, 0.9)
	local v5 = NumberSequenceKeypoint.new(0.15, 0.2)
	local v6 = NumberSequenceKeypoint.new(0.5, 0)
	local v7 = NumberSequenceKeypoint.new(0.85, 0.2)
	local new3 = NumberSequenceKeypoint.new
	tbl13[1] = v4
	tbl13[2] = v5
	tbl13[3] = v6
	tbl13[4] = v7

	do
		local values = table.pack(new3(1, 0.9))
		table.move(values, 1, values.n, 5, tbl13)
	end

	uiGradient2.Transparency = numberSequence(tbl13)
	uiGradient2.Rotation = 0
	uiGradient2.Parent = uiStroke
end

if getgenv().Tixo_SpectatorUI then
	getgenv().Tixo_SpectatorUI:Destroy()
end

local textLabel2, frame2

do
	local coreGui = pcall(function()
		return tbl.CoreGui.Name
	end) and tbl.CoreGui or tbl.Players.LocalPlayer:WaitForChild("PlayerGui")

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SpcGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = true
	getgenv().Tixo_SpectatorUI = screenGui
	local frame3 = Instance.new("Frame")
	frame3.Name = "MainBox"
	frame3.AnchorPoint = Vector2.new(0.5, 1)
	frame3.Position = UDim2.new(0.5, 0, 0, -10)
	frame3.Size = UDim2.new(0, 50, 0, 18)
	frame3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame3.BackgroundTransparency = 0
	frame3.BorderSizePixel = 0
	frame3.Parent = screenGui
	local uiGradient = Instance.new("UIGradient")
	local numberSequence = NumberSequence.new
	local tbl12 = {}
	local v2 = NumberSequenceKeypoint.new(0, 1)
	local v3 = NumberSequenceKeypoint.new(0.2, 0.3)
	local v4 = NumberSequenceKeypoint.new(0.8, 0.3)
	local new = NumberSequenceKeypoint.new
	tbl12[1] = v2
	tbl12[2] = v3
	tbl12[3] = v4

	do
		local values = table.pack(new(1, 1))
		table.move(values, 1, values.n, 4, tbl12)
	end

	uiGradient.Transparency = numberSequence(tbl12)
	uiGradient.Parent = frame3
	local uiCorner2 = Instance.new("UICorner")
	uiCorner2.CornerRadius = UDim.new(0, 6)
	uiCorner2.Parent = frame3
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Padding = UDim.new(0, 6)
	uiListLayout.Parent = frame3
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "Icon"
	imageLabel.LayoutOrder = 1
	imageLabel.Size = UDim2.new(0, 14, 0, 14)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://13321848320"
	imageLabel.ImageColor3 = Color3.fromRGB(200, 200, 200)
	imageLabel.Parent = frame3
	textLabel2 = Instance.new("TextLabel")
	textLabel2.Name = "Count"
	textLabel2.LayoutOrder = 2
	textLabel2.Size = UDim2.new(0, 0, 1, 0)
	textLabel2.AutomaticSize = Enum.AutomaticSize.X
	textLabel2.BackgroundTransparency = 1
	textLabel2.Font = Enum.Font.GothamMedium
	textLabel2.Text = "0"
	textLabel2.TextColor3 = Color3.fromRGB(230, 230, 230)
	textLabel2.TextSize = 12
	textLabel2.Parent = frame3
	screenGui.Parent = coreGui
	frame2 = Instance.new("Frame")
	frame2.Name = "NextKillerBox"
	frame2.AnchorPoint = Vector2.new(0.5, 0)
	frame2.Position = UDim2.new(0.5, 0, frame3.Position.Y.Scale, frame3.Position.Y.Offset + 20)
	frame2.Size = UDim2.new(0, 150, 0, 18)
	frame2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame2.BackgroundTransparency = 0.2
	frame2.BorderSizePixel = 0
	frame2.Parent = screenGui
end

do
	local uiGradient = Instance.new("UIGradient")
	local numberSequence = NumberSequence.new
	local tbl12 = {}
	local v2 = NumberSequenceKeypoint.new(0, 1)
	local v3 = NumberSequenceKeypoint.new(0.2, 0.3)
	local v4 = NumberSequenceKeypoint.new(0.8, 0.3)
	local new = NumberSequenceKeypoint.new
	tbl12[1] = v2
	tbl12[2] = v3
	tbl12[3] = v4

	do
		local values = table.pack(new(1, 1))
		table.move(values, 1, values.n, 4, tbl12)
	end

	uiGradient.Transparency = numberSequence(tbl12)
	uiGradient.Parent = frame2
end

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 6)
uiCorner2.Parent = frame2
local textLabel3
textLabel3 = Instance.new("TextLabel")
textLabel3.Name = "KillerText"
textLabel3.Size = UDim2.new(1, 0, 1, 0)
textLabel3.BackgroundTransparency = 1
textLabel3.Font = Enum.Font.GothamMedium
textLabel3.Text = "Next Killer: ..."
textLabel3.TextColor3 = Color3.fromRGB(255, 85, 85)
textLabel3.TextSize = 12
textLabel3.Parent = frame2

if tbl.CoreGui:FindFirstChild("FovC") then
	tbl.CoreGui:FindFirstChild("FovC"):Destroy()
end

local frame3
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FovC"
screenGui.Parent = tbl.CoreGui
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
frame3 = Instance.new("Frame")
frame3.BackgroundTransparency = 1
frame3.AnchorPoint = Vector2.new(0.5, 0.5)
frame3.Position = UDim2.new(0.5, 0, 0.5, 0)
frame3.Visible = false
frame3.Parent = screenGui
local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(1, 0)
uiCorner3.Parent = frame3
local uiStroke
uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 255, 100)
uiStroke.Thickness = 0.4
uiStroke.Parent = frame3
local screenGui2
screenGui2 = Instance.new("ScreenGui")
screenGui2.Name = "TargetUI"
screenGui2.Parent = tbl.CoreGui
screenGui2.IgnoreGuiInset = true
screenGui2.Enabled = false
local frame4
frame4 = Instance.new("Frame")
frame4.Name = "TargetMainBox"
frame4.Size = UDim2.new(0, 100, 0, 25)
frame4.Position = UDim2.new(0.5, 0, 0.8, 0)
frame4.AnchorPoint = Vector2.new(0.5, 0.5)
frame4.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame4.BackgroundTransparency = 0.2
frame4.ZIndex = 100
frame4.Parent = screenGui2
local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 8)
uiCorner4.Parent = frame4
local uiStroke2 = Instance.new("UIStroke")
uiStroke2.Color = Color3.fromRGB(255, 255, 255)
uiStroke2.Transparency = 0.5
uiStroke2.Thickness = 1
uiStroke2.Parent = frame4
local textLabel4
textLabel4 = Instance.new("TextLabel")
textLabel4.Size = UDim2.new(1, -40, 1, -15)
textLabel4.Position = UDim2.new(0, 10, 0, 5)
textLabel4.BackgroundTransparency = 1
textLabel4.Font = Enum.Font.GothamSemibold
textLabel4.TextSize = 12
textLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel4.Text = "Target: Killer"
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.ZIndex = 101
textLabel4.Parent = frame4
local textButton
textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 20, 0, 20)
textButton.AnchorPoint = Vector2.new(0.5, 0.5)
textButton.Position = UDim2.new(0.85, 0, 0.5, 0)
textButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textButton.Text = ">"
textButton.Font = Enum.Font.GothamBold
textButton.TextSize = 16
textButton.TextColor3 = Color3.fromRGB(0, 255, 100)
textButton.ZIndex = 102
textButton.Parent = frame4
local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 6)
uiCorner5.Parent = textButton
local frame5
frame5 = Instance.new("Frame")
frame5.Size = UDim2.new(1, 0, 0, 15)
frame5.Position = UDim2.new(0, 0, 1, 5)
frame5.AnchorPoint = Vector2.new(0, 0.5)
frame5.BackgroundTransparency = 1
frame5.Active = true
frame5.ZIndex = 103
frame5.Parent = frame4

do
	local frame6 = Instance.new("Frame")
	frame6.Size = UDim2.new(0, 60, 0, 4)
	frame6.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame6.AnchorPoint = Vector2.new(0.5, 0.5)
	frame6.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	frame6.ZIndex = 104
	frame6.Parent = frame5
	local uiCorner6 = Instance.new("UICorner")
	uiCorner6.CornerRadius = UDim.new(1, 0)
	uiCorner6.Parent = frame6
end

local flag2
flag2 = false
local v2
v2 = nil
local position
position = nil
local position2
position2 = nil
local fn18

fn18 = function(arg)
	local n = arg.Position - position
	frame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n.X, position2.Y.Scale, position2.Y.Offset + n.Y)
end

local fn19

fn19 = function()
	local n = 0

	for _, player in ipairs(tbl.Players:GetPlayers()) do
		if player.Team and player.Team.Name == "Spectator" then
			n += 1
		end
	end

	textLabel2.Text = tostring(n)
end

local fn20, fn21, connection, connection2, fn22, fn23, fn24, fn25, fn26, fn27
local fn28, fn29, fn30, fn31, fn32, fn33, fn34, fn35, fn36, fn37
local fn38, fn39, fn40, fn41

do
	local function fn42()
		if tbl.LocalPlayer.Team and tbl.LocalPlayer.Team.Name == "Spectator" then
			if not tbl6.isPredicting then
				tbl6.isPredicting = true
				frame2.Visible = true

				task.spawn(function()
					while tbl6.isPredicting and not tbl6.Unloaded do
						local n = -1
						local v3 = nil

						for _, player in ipairs(tbl.Players:GetPlayers()) do
							local attribute = player:GetAttribute("AllowKiller")
							local attribute2 = player:GetAttribute("KillerChance")

							if attribute == true and type(attribute2) == "number" then
								if attribute2 > n then
									n = attribute2
									v3 = player
								end
							end
						end

						if not v3 then
							local n2 = -1

							for _, player in ipairs(tbl.Players:GetPlayers()) do
								local attribute = player:GetAttribute("KillerChance")

								if type(attribute) == "number" then
									if n2 < attribute then
										n2 = attribute
										v3 = player
									end
								end
							end
						end

						if v3 then
							local selectedKiller = v3:FindFirstChild("SelectedKiller")
							textLabel3.Text = string.format("Killer: %s (%s)", v3.Name, selectedKiller and selectedKiller.Value or v3:GetAttribute("SelectedKiller") or "Unknown")
						else
							textLabel3.Text = "Killer: Tidak ada data"
						end

						task.wait(1)
					end
				end)
			end
		else
			tbl6.isPredicting = false
			frame2.Visible = false
		end
	end

	fn20 = function(arg)
		local Lighting = game:GetService("Lighting")
		local Workspace = game:GetService("Workspace")

		if arg then
			Lighting.GlobalShadows = true
			Lighting.ClockTime = 12
			Lighting.Brightness = 3.2
			Lighting.ExposureCompensation = 0.1
			Lighting.OutdoorAmbient = Color3.fromRGB(230, 230, 230)
			Lighting.Ambient = Color3.fromRGB(210, 210, 210)
			Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
			Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
			Lighting.EnvironmentDiffuseScale = 1
			Lighting.EnvironmentSpecularScale = 1
			Lighting.FogStart = 50
			Lighting.FogEnd = 500
			Lighting.FogColor = Color3.fromRGB(210, 210, 210)

			for _, child in ipairs(Lighting:GetChildren()) do
				if child:IsA("Atmosphere") or child:IsA("BloomEffect") or child:IsA("SunRaysEffect") then
					child:Destroy()
				end
			end

			local bloomEffect = Instance.new("BloomEffect")
			bloomEffect.Name = "Estetik_Bloom"
			bloomEffect.Intensity = 0.05
			bloomEffect.Size = 24
			bloomEffect.Threshold = 2
			bloomEffect.Parent = Lighting
			local sunRaysEffect = Instance.new("SunRaysEffect")
			sunRaysEffect.Name = "Estetik_SunRays"
			sunRaysEffect.Intensity = 0.04
			sunRaysEffect.Spread = 0.1
			sunRaysEffect.Parent = Lighting
			local atmosphere = Instance.new("Atmosphere")
			atmosphere.Name = "Estetik_Atmosphere"
			atmosphere.Density = 0.45
			atmosphere.Offset = 0.25
			atmosphere.Color = Color3.fromRGB(210, 210, 210)
			atmosphere.Decay = Color3.fromRGB(150, 150, 150)
			atmosphere.Glare = 0.2
			atmosphere.Haze = 2.5
			atmosphere.Parent = Lighting

			for _, descendant in ipairs(Workspace:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.Material = Enum.Material.SmoothPlastic
					descendant.Reflectance = 0
				end
			end

			local hdrColor = Lighting:FindFirstChild("HDR_Color") or Instance.new("ColorCorrectionEffect")
			hdrColor.Name = "HDR_Color"
			hdrColor.Saturation = 0.45
			hdrColor.Contrast = 0.15
			hdrColor.Brightness = 0.03
			hdrColor.TintColor = Color3.fromRGB(255, 255, 255)
			hdrColor.Parent = Lighting
		else
			if Lighting:FindFirstChild("HDR_Color") then
				Lighting.HDR_Color:Destroy()
			end

			if Lighting:FindFirstChild("Estetik_Bloom") then
				Lighting.Estetik_Bloom:Destroy()
			end

			if Lighting:FindFirstChild("Estetik_SunRays") then
				Lighting.Estetik_SunRays:Destroy()
			end

			if Lighting:FindFirstChild("Estetik_Atmosphere") then
				Lighting.Estetik_Atmosphere:Destroy()
			end

			Lighting.FogEnd = 100000
		end
	end

	fn21 = function(arg)
		if not remotes then
			return
		end
		local window = remotes:FindFirstChild("Window")
		local pallet = remotes:FindFirstChild("Pallet")

		if window then
			for _, window2 in ipairs(tbl9.Windows) do
				if window2 and window2.Parent then
					if arg then
						local vaultTrigger = window2:FindFirstChild("VaultTrigger", true)

						if vaultTrigger then
							pcall(function()
								window:FindFirstChild("VaultEvent"):FireServer(vaultTrigger, true)
							end)
						end
					else
						local vaultPointInUse = window2:FindFirstChild("VaultPointInUse", true)

						if vaultPointInUse then
							pcall(function()
								window:FindFirstChild("VaultCompleteEvent"):FireServer(vaultPointInUse, false)
							end)
						end
					end
				end
			end
		end

		if pallet then
			for _, pallet2 in ipairs(tbl9.Pallets) do
				if pallet2 and pallet2.Parent then
					if arg then
						local palletPointSlide = pallet2:FindFirstChild("PalletPointSlide", true)

						if palletPointSlide then
							pcall(function()
								pallet:FindFirstChild("PalletSlideEvent"):FireServer(palletPointSlide, true)
							end)
						end
					else
						local palletPointSlideInUse = pallet2:FindFirstChild("PalletPointSlideInUse", true)

						if palletPointSlideInUse then
							pcall(function()
								pallet:FindFirstChild("PalletSlideCompleteEvent"):FireServer(palletPointSlideInUse)
							end)
						end
					end
				end
			end
		end
	end

	connection = nil
	connection2 = nil

	local function fn43()
		pcall(function()
			local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")

			for match in string.gmatch("Survivor-mob.Controls.action.check", "[^%.]+") do
				playerGui = playerGui and playerGui:FindFirstChild(match)
			end

			if playerGui and playerGui:IsA("GuiObject") and playerGui.Visible and playerGui.Parent and playerGui.Parent:IsA("GuiButton") then
				local parent = playerGui.Parent

				if type(firesignal) == "function" then
					pcall(function()
						firesignal(parent.MouseButton1Down)
						task.wait(0.01)
						firesignal(parent.MouseButton1Up)
					end)
				else
					local n = parent.AbsolutePosition + parent.AbsoluteSize / 2
					local guiInset = tbl.GuiService:GetGuiInset()
					local n2 = n.X + guiInset.X
					local n3 = n.Y + guiInset.Y
					tbl.VirtualInputManager:SendMouseButtonEvent(n2, n3, 0, true, game, 1)
					task.wait(0.02)
					tbl.VirtualInputManager:SendMouseButtonEvent(n2, n3, 0, false, game, 1)
				end
			else
				tbl.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
				task.wait(0.012)
				tbl.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
			end
		end)
	end

	fn22 = function()
		task.spawn(function()
			local skillCheckPromptGui = tbl.LocalPlayer:FindFirstChild("PlayerGui"):WaitForChild("SkillCheckPromptGui", 10)
			if not skillCheckPromptGui then
				return
			end
			local check = skillCheckPromptGui:WaitForChild("Check", 8)
			if not check then
				return
			end
			local line = check:WaitForChild("Line", 5)
			local goal = check:WaitForChild("Goal", 5)
			if not (line and goal) then
				return
			end

			if connection2 then
				connection2:Disconnect()
			end

			connection2 = check:GetPropertyChangedSignal("Visible"):Connect(function()
				local flag3 = not tbl3.Surv_AutoSkillCheck

				if not flag3 then
					flag3 = not (tbl.LocalPlayer.Team and tbl.LocalPlayer.Team.Name == "Survivors")
				end

				if flag3 then
					return
				end

				if not tbl3.Surv_PerfectSkill then
					if connection then
						connection:Disconnect()
						connection = nil
					end

					return
				end

				if check.Visible then
					if tbl3.Surv_InstanSkill or tbl3.Surv_SkillCheckMode == "Random" and not tbl6.RandomMode_IsNormal then
						line.Rotation = goal.Rotation % 360 + 85
					end

					local n = 0

					if connection then
						connection:Disconnect()
					end

					connection = line:GetPropertyChangedSignal("Rotation"):Connect(function()
						if not tbl3.Surv_PerfectSkill then
							connection:Disconnect()
							connection = nil
							return
						end

						local randomModeIsNormal = tbl3.Surv_SkillCheckMode == "Normal" or tbl3.Surv_SkillCheckMode == "Random" and tbl6.RandomMode_IsNormal
						local n2 = line.Rotation % 360
						local n3 = goal.Rotation % 360
						local n4 = (n3 + 105) % 360
						local n5 = (n3 + 115) % 360

						if randomModeIsNormal then
							n4 = (n3 + 116) % 360
							n5 = (n3 + 140) % 360
						end

						if n4 > n5 and (n2 >= n4 or n2 <= n5) or n2 >= n4 and n2 <= n5 then
							if tick() - n > 0.2 then
								fn43()
								n = tick()
							end
						end
					end)
				else
					tbl6.RandomMode_IsNormal = false

					if connection then
						connection:Disconnect()
						connection = nil
					end
				end
			end)
		end)
	end

	local thread = nil

	getgenv().CleanupNoCD = function()
		getgenv().NoCD_Active = false

		if thread then
			task.cancel(thread)
			thread = nil
		end
	end

	fn23 = function()
		if fn5() ~= "Survivor" then
			return
		end
		local character = tbl.LocalPlayer.Character
		if not character then
			return
		end
		local smoothCamera = character:WaitForChild("SmoothCamera", 3) or character:FindFirstChild("SmoothCamera")

		if smoothCamera and smoothCamera:IsA("LocalScript") then
			if tbl3.Misc_SmoothCam then
				smoothCamera:SetAttribute("CameraHeight", tbl3.Misc_CamHeight)
				smoothCamera:SetAttribute("CameraStiffness", tbl3.Misc_CamStiffness)
			else
				smoothCamera:SetAttribute("CameraHeight", -1)
				smoothCamera:SetAttribute("CameraStiffness", 9.5)
			end
		end
	end

	fn24 = function(arg)
		if not arg then
			if getgenv().CleanupNoCD then
				getgenv().CleanupNoCD()
			end

			return
		end

		if fn5() ~= "Killer" then
			if getgenv().Library then
				fn2("Akses Ditolak: Kamu bukan Killer!", 3)
			end

			task.defer(function()
				if Toggles.Killer_NoCDToggle then
					Toggles.Killer_NoCDToggle:SetValue(false)
				end
			end)

			return
		end

		local selectedKiller = tbl.LocalPlayer:FindFirstChild("SelectedKiller")
		local attribute = selectedKiller and selectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller")

		if attribute ~= "Hidden" and attribute ~= "Stalker" then
			if getgenv().Library then
				fn2("Fitur ini hanya untuk Stalker atau Hidden!", 3)
			end

			task.defer(function()
				if Toggles.Killer_NoCDToggle then
					Toggles.Killer_NoCDToggle:SetValue(false)
				end
			end)

			return
		end

		getgenv().NoCD_Active = true

		if thread then
			task.cancel(thread)
		end

		local tbl12 = {}

		pcall(function()
			for _, v3 in pairs(getgc(true)) do
				if type(v3) == "function" and islclosure(v3) and not isexecutorclosure(v3) then
					local v4 = getinfo(v3)

					if v4 and v4.source and string.find(v4.source, "Powers") then
						table.insert(tbl12, v3)
					end
				end
			end
		end)

		thread = task.spawn(function()
			while getgenv().NoCD_Active and not tbl6.Unloaded do
				task.wait(1)

				pcall(function()
					for _, v3 in ipairs(tbl12) do
						local v4 = getinfo(v3)
						local v5 = getupvalues(v3)

						if attribute == "Hidden" and (v4.name == "tryActivate" or v4.name == "playM2Animation") then
							for k, v6 in pairs(v5) do
								if type(v6) == "boolean" and v6 == true then
									setupvalue(v3, k, false)
								end
							end
						elseif attribute == "Stalker" then
							if v4.name == "updateUI" then
								for k, v6 in pairs(v5) do
									if type(v6) == "boolean" then
										setupvalue(v3, k, true)
									end
								end
							elseif v4.name == "" then
								local n = 0
								local n2 = 0
								local v6 = nil

								for k, v7 in pairs(v5) do
									n += 1

									if type(v7) == "boolean" then
										n2 += 1
										v6 = k
									end
								end

								if n == 1 and n2 == 1 then
									setupvalue(v3, v6, false)
								end
							end
						end
					end
				end)
			end
		end)
	end

	fn25 = function(arg)
		if not arg then
			if getgenv().SlasherInvisLoop then
				task.cancel(getgenv().SlasherInvisLoop)
				getgenv().SlasherInvisLoop = nil
			end

			return
		end

		if getgenv().SlasherInvisLoop then
			task.cancel(getgenv().SlasherInvisLoop)
		end

		local tbl12 = {}

		pcall(function()
			for _, v3 in pairs(getgc(true)) do
				if type(v3) == "function" and islclosure(v3) and not isexecutorclosure(v3) then
					local v4 = getinfo(v3)

					if v4 and v4.source and string.find(v4.source, "Powers") then
						table.insert(tbl12, v3)
					end
				end
			end
		end)

		getgenv().SlasherInvisLoop = task.spawn(function()
			while task.wait(0.5) do
				pcall(function()
					local selectedKiller = tbl.LocalPlayer:FindFirstChild("SelectedKiller")
					selectedKiller = selectedKiller and selectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller")

					if fn5() == "Killer" and selectedKiller == "Slasher" then
						for _, v3 in ipairs(tbl12) do
							local v4 = getupvalues(v3)

							for k, v5 in pairs(v4) do
								if type(v5) == "boolean" and v5 == true then
									setupvalue(v3, k, false)
								end
							end
						end

						local character = tbl.LocalPlayer.Character

						if character then
							if character:GetAttribute("LakeMist") then
								character:SetAttribute("LakeMist", false)
							end

							if character:GetAttribute("Invisibility") then
								character:SetAttribute("Invisibility", false)
							end

							local checkInterractable = character:FindFirstChild("CheckInterractable")

							if checkInterractable and checkInterractable:GetAttribute("action") then
								checkInterractable:SetAttribute("action", false)
							end
						end
					end
				end)
			end
		end)
	end

	local tbl12 = {
		["Sound 1"] = "rbxassetid://125027580248269",
		["Sound 2"] = "rbxassetid://79440711397443",
		["Sound 3"] = "rbxassetid://102793319115878",
		["Sound 4"] = "rbxassetid://134840941464861",
	}

	local tbl13 = {}

	local function fn44(arg)
		if not arg or not arg:IsA("Sound") then
			return
		end

		if not arg:GetAttribute("OriginalSoundId") then
			arg:SetAttribute("OriginalSoundId", arg.SoundId)
		end

		local function fn45()
			if tbl3.Pistol_CustomSound then
				local v3 = tbl12[tbl3.Pistol_SelectedSound]

				if v3 and arg.SoundId ~= v3 then
					arg.SoundId = v3
				end
			else
				local attribute = arg:GetAttribute("OriginalSoundId")

				if attribute and arg.SoundId ~= attribute then
					arg.SoundId = attribute
				end
			end
		end

		fn45()

		if not tbl13[arg] then
			tbl13[arg] = arg:GetPropertyChangedSignal("SoundId"):Connect(fn45)

			arg.Played:Connect(function()
				task.delay(1, function()
					if arg and arg.IsPlaying then
						arg:Stop()
					end
				end)
			end)
		end
	end

	fn26 = function(arg)
		if not arg then
			return
		end

		local function fn45()
			local twistOfFate = arg:FindFirstChild("Twist of Fate") or tbl.Workspace:FindFirstChild("Twist of Fate", true)

			if twistOfFate then
				for _, descendant in ipairs(twistOfFate:GetDescendants()) do
					if descendant:IsA("LocalScript") and descendant.Name:lower() == "gun" then
						local disabled = fn11(arg)
						disabled = not tbl3.Pistol_BlockKnocked and disabled

						if descendant.Disabled ~= disabled then
							descendant.Disabled = disabled
						end
					end

					if descendant:IsA("Sound") and descendant.Name:lower() == "shoot" then
						fn44(descendant)
					end
				end
			end
		end

		task.spawn(function()
			if arg:WaitForChild("Twist of Fate", 5) then
				fn45()
			end
		end)

		fn45()

		for _, v3 in ipairs({ "Knocked", "isKnocked", "IsHooked", "isHooked", "IsCarried", "isCarried" }) do
			arg:GetAttributeChangedSignal(v3):Connect(fn45)
		end
	end

	local n = 0

	local function fn45()
		local character = tbl.LocalPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character then
			return nil
		end
		local huge = math.huge
		local character2 = nil

		for _, player in ipairs(tbl.Players:GetPlayers()) do
			if player ~= tbl.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local humanoid2 = player.Character:FindFirstChild("Humanoid")

				if humanoid2 and humanoid2.Health > 0 and not fn11(player.Character) then
					local magnitude = (character.Position - player.Character.HumanoidRootPart.Position).Magnitude

					if magnitude < huge then
						character2 = player.Character
						huge = magnitude
					end
				end
			end
		end

		return character2
	end

	local function fn46()
		if tbl6.isAimLocking then
			return
		end

		if tick() - n < 0.2 then
			return
		end
		n = tick()

		if fn5() == "Killer" then
			tbl6.currentTarget = fn45()

			if tbl6.currentTarget and tbl6.currentTarget:FindFirstChild("HumanoidRootPart") then
				tbl6.isAimLocking = true

				if tbl6.lockTimerThread then
					task.cancel(tbl6.lockTimerThread)
				end

				tbl6.lockTimerThread = task.delay(2, function()
					tbl6.isAimLocking = false
					tbl6.currentTarget = nil
					tbl6.lockTimerThread = nil
				end)
			end
		end
	end

	fn27 = function(arg)
		if not arg then
			if getgenv().DashRenderConn then
				getgenv().DashRenderConn:Disconnect()
				getgenv().DashRenderConn = nil
			end

			if getgenv().DashInputConn then
				getgenv().DashInputConn:Disconnect()
				getgenv().DashInputConn = nil
			end

			if getgenv().DashMobileLoop then
				task.cancel(getgenv().DashMobileLoop)
				getgenv().DashMobileLoop = nil
			end

			if getgenv().DashMobileBtnConn then
				getgenv().DashMobileBtnConn:Disconnect()
				getgenv().DashMobileBtnConn = nil
			end

			tbl6.isAimLocking = false
			tbl6.currentTarget = nil
			return
		end

		local renderStepped = tbl.RunService.RenderStepped

		getgenv().DashRenderConn = renderStepped:Connect(function()
			if tbl6.isAimLocking and tbl6.currentTarget and tbl6.currentTarget:FindFirstChild("HumanoidRootPart") then
				tbl.Camera.CFrame = tbl.Camera.CFrame:Lerp(CFrame.lookAt(tbl.Camera.CFrame.Position, tbl6.currentTarget.HumanoidRootPart.Position), 0.6)
			else
				tbl6.isAimLocking = false
			end
		end)

		local inputBegan = tbl.UserInputService.InputBegan

		getgenv().DashInputConn = inputBegan:Connect(function(arg2, arg3)
			if arg3 then
				return
			end

			if arg2.UserInputType == Enum.UserInputType.MouseButton2 then
				fn46()
			end
		end)

		getgenv().DashMobileLoop = task.spawn(function()
			local v3 = nil
			local playerGui = tbl.LocalPlayer:WaitForChild("PlayerGui", 10)

			while task.wait(2) do
				pcall(function()
					if playerGui then
						local hiddenMob = playerGui:FindFirstChild("Hidden-mob")
						local move2 = hiddenMob and hiddenMob:FindFirstChild("Controls") and hiddenMob.Controls:FindFirstChild("move2")

						if move2 and move2 ~= v3 then
							if getgenv().DashMobileBtnConn then
								getgenv().DashMobileBtnConn:Disconnect()
							end

							v3 = move2
							local inputBegan2 = move2.InputBegan

							getgenv().DashMobileBtnConn = inputBegan2:Connect(function(arg2)
								if arg2.UserInputType == Enum.UserInputType.Touch or arg2.UserInputType == Enum.UserInputType.MouseButton1 then
									fn46()
								end
							end)
						end
					end
				end)
			end
		end)
	end

	local function fn47()
		if tbl6.Bandage then
			return
		end
		tbl6.Bandage = true

		task.spawn(function()
			pcall(function()
				local remotes2 = tbl.ReplicatedStorage:FindFirstChild("Remotes")
				remotes2 = remotes2 and remotes2:FindFirstChild("Items")
				remotes2 = remotes2 and remotes2:FindFirstChild("Bandage")
				remotes2 = remotes2 and remotes2:FindFirstChild("Fire")
				local character = tbl.LocalPlayer.Character

				if remotes2 and character then
					local bandage = character:FindFirstChild("Bandage") or tbl.LocalPlayer.Backpack:FindFirstChild("Bandage")

					if bandage then
						local rightArm = bandage:FindFirstChild("Right Arm")
						rightArm = rightArm and rightArm:FindFirstChild("Bandage") or bandage

						for i = 1, 400 do
							remotes2:FireServer(true, rightArm)
							remotes2:FireServer(false, rightArm)
						end
					end
				end
			end)

			task.wait(0.1)
			tbl6.Bandage = false
		end)
	end

	local function fn48()
		if tbl6.HookF then
			return
		end

		if not getrawmetatable or not setreadonly then
			warn("[Anti-Fail]: Executor tidak support getrawmetatable atau setreadonly.")
			return
		end
		local v3 = getrawmetatable(game)
		setreadonly(v3, false)
		local namecall = v3.__namecall

		v3.__namecall = newcclosure(function(arg, ...)
			local v4 = table.pack(...)
			local v5 = getnamecallmethod()
			local tbl14 = { ... }

			if tbl3.Killer_BypassCarry and v5 == "GetAttribute" and not checkcaller() then
				if tbl14[1] == "IsCarrying" then
					return false
				end
			end

			if v5 == "FireServer" and not checkcaller() then
				if typeof(arg) == "Instance" then
					local name = arg.Name

					if tbl3.Surv_AutoCancelGene and name == "SkillCheckResultEvent" then
						if args[1] == "fail" then
							return nil
						end
					end

					if tbl3.Aim_SilentVeil and name == "Spearthrow" then
						return
					end

					if tbl3.Aim_Silent and name == "Fire" and arg.Parent and arg.Parent.Name == "Twist of Fate" then
						return nil
					end

					if tbl3.Surv_NoFall and name == "Fall" then
						return nil
					end

					if tbl3.Surv_Bandage and name == "Fire" and arg.Parent and arg.Parent.Name == "Bandage" then
						if tbl14[1] == true then
							fn47()
							return nil
						end
					end

					if name == "VaultEvent" then
						local character = tbl.LocalPlayer.Character

						if tbl3.Surv_SpeedAfterVault and not tbl6.QuickRecoveryOnCD then
							tbl6.VaultBoostActive = true
							tbl6.QuickRecoveryOnCD = true

							if character then
								character:SetAttribute("speedboost", 1.4)
							end

							if tbl6.VaultBoostThread then
								task.cancel(tbl6.VaultBoostThread)
							end

							tbl6.VaultBoostThread = task.delay(3, function()
								tbl6.VaultBoostActive = false
								local character2 = tbl.LocalPlayer.Character

								if character2 then
									character2:SetAttribute("speedboost", tbl3.Surv_Perks and tbl3.Surv_Spdb and tbl3.Surv_SpeedBoost or 1)
								end

								task.wait(tbl3.Surv_QuickRecoveryCD)
								tbl6.QuickRecoveryOnCD = false
							end)
						end

						if tbl3.Surv_FastVault and not tbl6.FlowstateOnCD then
							task.delay(1, function()
								tbl6.FlowstateOnCD = true
							end)

							if tbl6.FlowstateCDThread then
								task.cancel(tbl6.FlowstateCDThread)
							end

							tbl6.FlowstateCDThread = task.spawn(function()
								task.wait(tbl3.Surv_FlowstateCD)
								tbl6.FlowstateOnCD = false
							end)
						end
					end

					if tbl3.Anti_Blind and fn5() == "Killer" and name == "GotBlinded" then
						return nil
					end
				end
			end

			return namecall(arg, table.unpack(v4, 1, v4.n))
		end)

		setreadonly(v3, true)
		tbl6.HookF = true
	end

	fn48()

	fn28 = function()
		if not tbl3.Misc_FakeName then
			return
		end
		local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
		if not playerGui then
			return
		end

		local function fn49(arg)
			pcall(function()
				if arg:IsA("TextLabel") or arg:IsA("TextButton") or arg:IsA("TextBox") then
					local function fn50()
						if not tbl3.Misc_FakeName then
							return
						end
						local text = arg.Text

						if not arg:GetAttribute("OriginalText") then
							arg:SetAttribute("OriginalText", text)
						end

						local flag3 = false

						for _, player in ipairs(tbl.Players:GetPlayers()) do
							local name = player.Name
							local displayName = player.DisplayName
							local v3

							if name and name ~= "" and string.find(text, name) then
								v3 = string.gsub(text, name, tbl2.name)
								flag3 = true
							else
								v3 = text
							end

							if displayName and displayName ~= "" and string.find(v3, displayName) then
								text = string.gsub(v3, displayName, tbl2.name)
								flag3 = true
							else
								text = v3
							end
						end

						if flag3 and arg.Text ~= text then
							arg.Text = text
						end
					end

					fn50()
					local connection3 = arg:GetPropertyChangedSignal("Text"):Connect(fn50)
					table.insert(tbl6.SpooferConns, connection3)
				elseif arg:IsA("ImageLabel") or arg:IsA("ImageButton") then
					local function fn50()
						if not tbl3.Misc_FakeName then
							return
						end
						local image = arg.Image
						local flag3 = false

						for _, player in ipairs(tbl.Players:GetPlayers()) do
							if string.find(image, tostring(player.UserId)) then
								if not arg:GetAttribute("OriginalImage") then
									arg:SetAttribute("OriginalImage", image)
								end

								flag3 = true
								break
							end
						end

						local image2 = "rbxassetid://" .. tbl2.icon

						if flag3 and arg.Image ~= image2 then
							arg.Image = image2
						end
					end

					fn50()
					local connection3 = arg:GetPropertyChangedSignal("Image"):Connect(fn50)
					table.insert(tbl6.SpooferConns, connection3)
				end
			end)
		end

		for _, descendant in ipairs(playerGui:GetDescendants()) do
			fn49(descendant)
		end

		local connection3 = playerGui.DescendantAdded:Connect(function(descendant)
			task.defer(function()
				fn49(descendant)
			end)
		end)

		table.insert(tbl6.SpooferConns, connection3)
	end

	fn29 = function()
		for _, spooferConn in ipairs(tbl6.SpooferConns) do
			if spooferConn.Connected then
				spooferConn:Disconnect()
			end
		end

		table.clear(tbl6.SpooferConns)
		local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")

		if playerGui then
			for _, descendant in ipairs(playerGui:GetDescendants()) do
				pcall(function()
					if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
						local attribute = descendant:GetAttribute("OriginalText")

						if attribute then
							descendant.Text = attribute
							descendant:SetAttribute("OriginalText", nil)
						end
					elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
						local attribute = descendant:GetAttribute("OriginalImage")

						if attribute then
							descendant.Image = attribute
							descendant:SetAttribute("OriginalImage", nil)
						end
					end
				end)
			end
		end
	end

	fn30 = function()
		if tbl6.RepairEngineRunning then
			return
		end
		tbl6.RepairEngineRunning = true

		task.spawn(function()
			local tbl14 = {}
			local tbl15 = {}
			local n2 = 0

			while tbl3.AUTO_Generator and not tbl6.Unloaded do
				if tick() - n2 > 2 then
					tbl14 = {}

					for _, generator2 in ipairs(tbl9.Generators) do
						local attribute = generator2.model:GetAttribute("RepairProgress")
						local value

						if attribute then
							value = attribute
						else
							value = generator2.model:FindFirstChild("RepairProgress") and generator2.model.RepairProgress.Value
						end

						value = value or 0

						if value < 100 then
							for _, child in ipairs(generator2.model:GetChildren()) do
								if child.Name:match("GeneratorPoint") then
									table.insert(tbl14, { gen = generator2.model, pt = child })
								end
							end
						else
							for _, child in ipairs(generator2.model:GetChildren()) do
								if child.Name:match("GeneratorPoint") then
									tbl15[child] = nil
								end
							end
						end
					end

					n2 = tick()
				end

				if repairEvent and skillCheckResultEvent then
					local v3 = fn8()

					for _, v4 in ipairs(tbl14) do
						if v3 and (v3.Position - v4.pt.Position).Magnitude <= 20 then
							if not tbl15[v4.pt] then
								pcall(repairEvent.FireServer, repairEvent, v4.pt, true)
								tbl15[v4.pt] = true
							end

							pcall(skillCheckResultEvent.FireServer, skillCheckResultEvent, tbl3.Surv_PerfectSkill and "success" or "neutral", 100, v4.gen, v4.pt)
						elseif tbl15[v4.pt] then
							pcall(repairEvent.FireServer, repairEvent, v4.pt, false)
							tbl15[v4.pt] = nil
						end
					end
				end

				task.wait(0.15)
			end

			if repairEvent then
				for k in pairs(tbl15) do
					pcall(repairEvent.FireServer, repairEvent, k, false)
				end
			end

			tbl6.RepairEngineRunning = false
		end)
	end

	fn31 = function()
		tbl3.AUTO_Generator = false

		pcall(function()
			local remotes2 = tbl.ReplicatedStorage:FindFirstChild("Remotes")
			local generator2 = remotes2 and remotes2:FindFirstChild("Generator")
			local repairEvent2 = generator2 and generator2:FindFirstChild("RepairEvent")

			if repairEvent2 then
				for _, generator3 in ipairs(tbl9.Generators) do
					for _, child in ipairs(generator3.model:GetChildren()) do
						if child.Name:match("GeneratorPoint") then
							pcall(function()
								repairEvent2:FireServer(child, false)
							end)
						end
					end
				end
			end

			local character = tbl.LocalPlayer.Character
			if not character then
				return
			end

			for _, descendant in pairs(character:GetDescendants()) do
				if descendant:IsA("Weld") or descendant:IsA("WeldConstraint") or descendant:IsA("ManualWeld") then
					if descendant.Part0 and not descendant.Part0:IsDescendantOf(character) or descendant.Part1 and not descendant.Part1:IsDescendantOf(character) then
						descendant:Destroy()
					end
				end
			end

			local humanoid2 = character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

			if humanoid2 then
				humanoid2:ChangeState(Enum.HumanoidStateType.GettingUp)
				humanoid2.PlatformStand = false
				humanoid2.Sit = false
				humanoid2.WalkSpeed = tbl6.OriginalSpeed or 16
				local animator = humanoid2:FindFirstChildOfClass("Animator")

				if animator then
					for _, v3 in pairs(animator:GetPlayingAnimationTracks()) do
						v3:Stop()
					end
				end
			end

			if humanoidRootPart2 then
				humanoidRootPart2.Anchored = false
				humanoidRootPart2.CFrame = humanoidRootPart2.CFrame * CFrame.new(0, 0, 1.5)
			end
		end)
	end

	fn32 = function()
		if not fn8() then
			return nil
		end
		local huge = math.huge
		local v3 = nil

		for _, generator2 in ipairs(tbl9.Generators) do
			local attribute = generator2.model:GetAttribute("RepairProgress") or generator2.model:FindFirstChild("RepairProgress") and generator2.model.RepairProgress.Value or 0
			local attribute2 = generator2.model:GetAttribute("PlayersRepairingCount") or generator2.model:FindFirstChild("PlayersRepairingCount") and generator2.model.PlayersRepairingCount.Value or 0

			if attribute < 100 and attribute2 < 4 then
				local huge2 = math.huge

				for _, player in pairs(tbl.Players:GetPlayers()) do
					if player ~= tbl.LocalPlayer and fn6(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local magnitude = (player.Character.HumanoidRootPart.Position - generator2.part.Position).Magnitude

						if magnitude < huge2 then
							huge2 = magnitude
						end
					end
				end

				if tbl3.AUTO_LeaveDist + 15 < huge2 then
					local v4 = fn9(generator2.part.Position)

					if v4 < huge then
						huge = v4
						v3 = generator2
					end
				end
			end
		end

		return v3
	end

	fn33 = function()
		local v3 = fn8()
		if not v3 then
			return false
		end
		task.spawn(fn31)
		local huge = math.huge
		local humanoidRootPart2 = nil

		for _, player in pairs(tbl.Players:GetPlayers()) do
			if player ~= tbl.LocalPlayer and fn6(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local magnitude = (player.Character.HumanoidRootPart.Position - v3.Position).Magnitude

				if magnitude < huge then
					humanoidRootPart2 = player.Character.HumanoidRootPart
					huge = magnitude
				end
			end
		end

		if humanoidRootPart2 and huge <= tbl3.AUTO_LeaveDist then
			local unit = (v3.Position - humanoidRootPart2.Position).Unit

			if unit.Magnitude ~= unit.Magnitude then
				unit = Vector3.new(1, 0, 0)
			end

			v3.CFrame = CFrame.new(v3.Position + unit * (tbl3.AUTO_LeaveDist + 20) + Vector3.new(0, 3, 0))
			return true
		end

		return false
	end

	fn34 = function(arg)
		local v3 = fn8()
		if not v3 or not arg then
			return false
		end
		local unit = (v3.Position - arg.part.Position).Unit

		if unit.Magnitude ~= unit.Magnitude then
			unit = Vector3.new(0, 0, 1)
		end

		v3.CFrame = CFrame.new(arg.part.Position + unit * tbl3.TP_Offset + Vector3.new(0, 3, 0), arg.part.Position)
		return true
	end

	local thread2 = nil

	fn35 = function(survDoubleGen)
		tbl3.Surv_DoubleGen = survDoubleGen

		if survDoubleGen then
			if thread2 then
				task.cancel(thread2)
			end

			thread2 = task.spawn(function()
				local remotes2 = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
				local repairEvent2 = remotes2 and remotes2:FindFirstChild("Generator") and remotes2.Generator:FindFirstChild("RepairEvent")
				local tbl14 = {}
				local flag3 = false

				while tbl3.Surv_DoubleGen and not tbl6.Unloaded do
					task.wait(0.2)
					local character = tbl.LocalPlayer.Character

					if fn5() == "Survivor" and character then
						local checkInterractable = character:FindFirstChild("CheckInterractable")
						local flag4 = checkInterractable and checkInterractable:GetAttribute("isRepairing") == true or character:GetAttribute("isRepairing") == true

						if flag4 and not flag3 then
							tbl14 = {}
							task.wait(0.2)
							local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
							local v3 = humanoidRootPart2 and repairEvent2
							flag3 = true

							if v3 then
								local exitTo = nil

								for _, generator2 in ipairs(tbl9.Generators) do
									if (humanoidRootPart2.Position - generator2.part.Position).Magnitude <= 15 then
										exitTo = 1
										break
									end
								end

								if exitTo == 1 then
									for _, child in ipairs(t8.model:GetChildren()) do
										if string.match(child.Name, "GeneratorPoint") then
											if not (child:GetAttribute("IsRepairing") == true or child:GetAttribute("isRepairing") == true) then
												table.insert(tbl14, child)

												pcall(function()
													repairEvent2:FireServer(child, true)
												end)
											end
										end
									end
								end
							end
						elseif not flag4 and flag3 then
							if repairEvent2 then
								for _, v3 in ipairs(tbl14) do
									pcall(function()
										repairEvent2:FireServer(v3, false)
									end)
								end
							end

							tbl14 = {}
							flag3 = false
						end
					end
				end
			end)
		elseif thread2 then
			task.cancel(thread2)
			thread2 = nil
		end
	end

	fn36 = function()
		local ok, result = pcall(function()
			return game:HttpGet("https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
		end)

		if ok and result then
			local data = tbl.HttpService:JSONDecode(result)
			local tbl14 = {}

			if data and data.data then
				for _, v3 in ipairs(data.data) do
					if type(v3) == "table" and v3.id and v3.id ~= game.JobId then
						table.insert(tbl14, v3.id)
					end
				end
			end

			if #tbl14 > 0 then
				local v3 = tbl14[math.random(#tbl14)]
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v3, tbl.LocalPlayer)
			elseif getgenv().Library then
				fn2("Gagal: Tidak ada server yang tersedia.", 3)
			end
		end
	end

	fn37 = function(arg)
		if arg == "Player" then
			for _, v3 in ipairs(tbl11) do
				if v3.Character then
					local peh = v3.Character:FindFirstChild("PEH")
					local peText = v3.Character:FindFirstChild("PE_Text")

					if peh then
						Debris:AddItem(peh, 0)
					end

					if peText then
						Debris:AddItem(peText, 0)
					end
				end
			end
		elseif arg == "Killer" then
			for _, v3 in ipairs(tbl11) do
				if v3.Character then
					local keh = v3.Character:FindFirstChild("KEH")
					local keText = v3.Character:FindFirstChild("KE_Text")

					if keh then
						Debris:AddItem(keh, 0)
					end

					if keText then
						Debris:AddItem(keText, 0)
					end
				end
			end
		elseif arg == "Generator" then
			for _, generator2 in pairs(tbl9.Generators) do
				if generator2.model and generator2.model.Parent then
					local geh = generator2.model:FindFirstChild("GEH")
					local geText = generator2.model:FindFirstChild("GE_Text")

					if geh then
						Debris:AddItem(geh, 0)
					end

					if geText then
						Debris:AddItem(geText, 0)
					end
				end
			end
		elseif arg == "Pallet" then
			for _, pallet in pairs(tbl9.Pallets) do
				if pallet and pallet.Parent then
					local palletEH = pallet:FindFirstChild("PalletEH")

					if palletEH then
						Debris:AddItem(palletEH, 0)
					end
				end
			end
		elseif arg == "Hook" then
			for _, hook in pairs(tbl9.Hooks) do
				if hook and hook.Parent then
					local hookEH = hook:FindFirstChild("HookEH")
					local hookEText = hook:FindFirstChild("HookE_Text")

					if hookEH then
						Debris:AddItem(hookEH, 0)
					end

					if hookEText then
						Debris:AddItem(hookEText, 0)
					end
				end
			end
		elseif arg == "Window" then
			for _, window in pairs(tbl9.Windows) do
				if window and window.Parent then
					local windowEH = window:FindFirstChild("WindowEH")

					if windowEH then
						Debris:AddItem(windowEH, 0)
					end
				end
			end
		elseif arg == "Item" then
			for _, itemESP in pairs(tbl6.ItemESPs) do
				if itemESP then
					Debris:AddItem(itemESP, 0)
				end
			end

			table.clear(tbl6.ItemESPs)
		elseif arg == "Gate" then
			for _, gate in pairs(tbl9.Gates) do
				if gate and gate.Parent then
					local gateEH = gate:FindFirstChild("GateEH")
					local gateEText = gate:FindFirstChild("GateE_Text")

					if gateEH then
						Debris:AddItem(gateEH, 0)
					end

					if gateEText then
						Debris:AddItem(gateEText, 0)
					end
				end
			end
		elseif arg == "SCP" then
			for _, scP in pairs(tbl9.SCPs) do
				if scP and scP.Parent then
					local scpeh = scP:FindFirstChild("SCPEH")

					if scpeh then
						Debris:AddItem(scpeh, 0)
					end
				end
			end
		end
	end

	fn38 = function()
		fn37("Player")
		fn37("Killer")
		fn37("Generator")
		fn37("Pallet")
		fn37("Hook")
		fn37("Item")
		fn37("Gate")
		fn37("SCP")
		fn37("Window")
	end

	fn39 = function(arg)
		if not arg then
			return
		end

		if tbl6.SpearModeConn then
			tbl6.SpearModeConn:Disconnect()
			tbl6.SpearModeConn = nil
		end

		if tbl6.StunConn then
			tbl6.StunConn:Disconnect()
			tbl6.StunConn = nil
		end

		tbl6.SpearModeConn = arg:GetAttributeChangedSignal("spearmode"):Connect(function()
			local attribute = tbl.LocalPlayer:FindFirstChild("SelectedKiller") and tbl.LocalPlayer.SelectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller")

			if fn5() == "Killer" and attribute == "Veil" and arg:GetAttribute("spearmode") == true then
				tbl8.isChargingSpear = false
				tbl8.currentTouchInput = nil
				tbl6.spearSwitchCooldown = true

				task.delay(2, function()
					tbl6.spearSwitchCooldown = false
				end)
			else
				tbl6.spearSwitchCooldown = false
			end
		end)

		tbl6.StunConn = arg:GetAttributeChangedSignal("IsStunned"):Connect(function()
			if arg:GetAttribute("IsStunned") == true then
				tbl8.isChargingSpear = false
				tbl8.currentTouchInput = nil
			end
		end)
	end

	fn40 = function(arg)
		if not arg then
			return
		end
		local tbl14 = { Great = "rbxassetid://111033165135961", Sound = "rbxassetid://138997442392324" }
		local tbl15 = { "Skillcheck-gen", "Skillcheck-player" }

		task.spawn(function()
			for _, v3 in ipairs(tbl15) do
				local v4 = arg:WaitForChild(v3, 5)

				if v4 then
					for k, v5 in pairs(tbl14) do
						local v6 = v4:WaitForChild(k, 5)

						if v6 and v6:IsA("Sound") then
							if not v6:GetAttribute("OriginalSoundId") then
								v6:SetAttribute("OriginalSoundId", v6.SoundId)
							end

							if tbl3.Surv_SoundDbd then
								v6.SoundId = v5
							else
								local attribute = v6:GetAttribute("OriginalSoundId")

								if attribute then
									v6.SoundId = attribute
								end
							end
						end
					end
				end
			end
		end)
	end

	fn41 = function()
		if not tbl.LocalPlayer.Team then
			str = "Unknown"
			return
		end
		local name = tbl.LocalPlayer.Team.Name

		if name == "Killer" then
			str = "Killer"
		elseif name == "Survivors" then
			str = "Survivor"
		else
			str = "Spectator"

			if getgenv().NoCD_Active then
				getgenv().NoCD_Active = false

				if getgenv().CleanupNoCD then
					pcall(getgenv().CleanupNoCD)
				end
			end
		end

		tbl6.VaultBoostActive = false
		tbl6.QuickRecoveryOnCD = false

		if tbl6.VaultBoostThread then
			task.cancel(tbl6.VaultBoostThread)
			tbl6.VaultBoostThread = nil
		end

		fn42()
		fn38()

		if name == "Killer" or name == "Survivors" then
			if fn3 then
				fn3()
			end

			task.delay(15, function()
				if tbl6.Unloaded then
					return
				end
				fn17()
				fn23()
				fn40(tbl.LocalPlayer.Character)
				fn39(tbl.LocalPlayer.Character)

				if tbl3.Misc_SmoothHDR then
					fn20(true)
				end
			end)
		end
	end
end

local fn42

fn42 = function()
	if not tbl3.ESP_Master then
		return
	end

	if tbl3.ESP_SCP then
		for _, scP in ipairs(tbl9.SCPs) do
			if scP and scP.Parent then
				local humanoid2 = scP:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart2 = scP:FindFirstChild("HumanoidRootPart") or scP:FindFirstChild("Torso") or scP:FindFirstChild("Head") or scP.PrimaryPart

				if humanoid2 and humanoidRootPart2 and math.floor(humanoid2.WalkSpeed) > 0 and math.floor(humanoid2.WalkSpeed) ~= 16 then
					local scp = tbl7.Colors.SCP
					local scpeh = scP:FindFirstChild("SCPEH")

					if not scpeh then
						scpeh = Instance.new("Highlight")
						scpeh.Name = "SCPEH"
						scpeh.Parent = scP
					end

					scpeh.FillColor = scp
					scpeh.OutlineColor = scp
					scpeh.FillTransparency = tbl3.ESP_Outline and 1 or tbl3.Trans or 0.7
					scpeh.Enabled = true
					scpeh.OutlineTransparency = 0.5
				else
					local scpeh = scP:FindFirstChild("SCPEH")

					if scpeh then
						scpeh.Enabled = false
					end
				end
			end
		end
	else
		fn37("SCP")
	end
end

local fn43, fn44

do
	local items = tbl.ReplicatedStorage:WaitForChild("Items", 5)

	local function fn45(arg)
		return tostring(arg):match("%d+")
	end

	local function fn46(arg)
		if not items then
			return nil
		end
		local v3 = items:FindFirstChild(arg)
		if not v3 then
			return nil
		end
		local texture = nil

		pcall(function()
			texture = v3.Texture or v3.Image
		end)

		if texture and texture ~= "" then
			local v4 = fn45(texture)
			if v4 then
				return ("rbxthumb://type=Asset&id=%s&w=420&h=420"):format(v4)
			end
		end

		return nil
	end

	fn43 = function(parent, name, arg)
		local billboardGui = parent:FindFirstChild(name)
		local lineScale = arg.lineScale or 1

		if not billboardGui then
			billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = name
			billboardGui.Parent = parent

			if parent:IsA("Model") then
				billboardGui.Adornee = parent:FindFirstChild("Head") or parent:FindFirstChild("HumanoidRootPart") or parent.PrimaryPart
			else
				billboardGui.Adornee = parent
			end

			billboardGui.AlwaysOnTop = true
			billboardGui.Size = UDim2.new(0, 250, 0, 100)
			billboardGui.StudsOffset = Vector3.new(0, arg.offsetY or 0, 0)
			local frame6 = Instance.new("Frame")
			frame6.Name = "Wrapper"
			frame6.AutomaticSize = Enum.AutomaticSize.XY
			frame6.Size = UDim2.new(0, 0, 0, 0)
			frame6.Position = UDim2.new(0.5, 25 * lineScale, 0.5, -25 * lineScale)
			frame6.AnchorPoint = Vector2.new(0, 1)
			frame6.BackgroundTransparency = 1
			frame6.ZIndex = 2
			frame6.Parent = billboardGui
			local uiListLayout = Instance.new("UIListLayout")
			uiListLayout.FillDirection = Enum.FillDirection.Vertical
			uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
			uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			uiListLayout.Padding = UDim.new(0, 0)
			uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			uiListLayout.Parent = frame6
			local textLabel5 = Instance.new("TextLabel")
			textLabel5.Name = "StatusText"
			textLabel5.AutomaticSize = Enum.AutomaticSize.X
			textLabel5.Size = UDim2.new(0, 0, 0, 10)
			textLabel5.BackgroundTransparency = 1
			textLabel5.Font = Enum.Font.GothamBold
			textLabel5.TextSize = 10
			textLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel5.TextXAlignment = Enum.TextXAlignment.Center
			textLabel5.TextYAlignment = Enum.TextYAlignment.Bottom
			textLabel5.ZIndex = 3
			textLabel5.LayoutOrder = 1
			textLabel5.Parent = frame6
			local frame7 = Instance.new("Frame")
			frame7.Name = "Box"
			frame7.AutomaticSize = Enum.AutomaticSize.X
			frame7.Size = UDim2.new(0, 0, 0, 16)
			frame7.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			frame7.BackgroundTransparency = 0
			frame7.BorderSizePixel = 0
			frame7.ZIndex = 2
			frame7.LayoutOrder = 2
			frame7.Parent = frame6
			Instance.new("UICorner", frame7).CornerRadius = UDim.new(0, 3)
			local uiGradient = Instance.new("UIGradient")
			local numberSequence = NumberSequence.new
			local tbl12 = {}
			local v3 = NumberSequenceKeypoint.new(0, 1)
			local v4 = NumberSequenceKeypoint.new(0.15, 0.3)
			local v5 = NumberSequenceKeypoint.new(0.5, 0.3)
			local v6 = NumberSequenceKeypoint.new(0.85, 0.3)
			local new = NumberSequenceKeypoint.new
			tbl12[1] = v3
			tbl12[2] = v4
			tbl12[3] = v5
			tbl12[4] = v6

			do
				local values = table.pack(new(1, 1))
				table.move(values, 1, values.n, 5, tbl12)
			end

			uiGradient.Transparency = numberSequence(tbl12)
			uiGradient.Parent = frame7
			local uiPadding = Instance.new("UIPadding", frame7)
			uiPadding.PaddingLeft = UDim.new(0, 8)
			uiPadding.PaddingRight = UDim.new(0, 8)
			local uiListLayout2 = Instance.new("UIListLayout", frame7)
			uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
			uiListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center
			uiListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			uiListLayout2.Padding = UDim.new(0, 4)
			uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
			local imageLabel = Instance.new("ImageLabel", frame7)
			imageLabel.Name = "Icon"
			imageLabel.Size = UDim2.new(0, 12, 0, 12)
			imageLabel.BackgroundTransparency = 1
			imageLabel.ZIndex = 3
			imageLabel.LayoutOrder = 1
			imageLabel.Visible = false
			local textLabel6 = Instance.new("TextLabel", frame7)
			textLabel6.Name = "Text"
			textLabel6.AutomaticSize = Enum.AutomaticSize.X
			textLabel6.Size = UDim2.new(0, 0, 1, 0)
			textLabel6.BackgroundTransparency = 1
			textLabel6.Font = Enum.Font.GothamMedium
			textLabel6.TextSize = 11
			textLabel6.ZIndex = 3
			textLabel6.LayoutOrder = 2
			textLabel6.RichText = true
			textLabel6.TextXAlignment = Enum.TextXAlignment.Center
			textLabel6.TextYAlignment = Enum.TextYAlignment.Center
			local frame8 = Instance.new("Frame")
			frame8.Name = "Line"
			frame8.Size = UDim2.new(0, 1, 0, 36 * lineScale)
			frame8.Position = UDim2.new(0.5, 12 * lineScale, 0.5, -12 * lineScale)
			frame8.AnchorPoint = Vector2.new(0.5, 0.5)
			frame8.Rotation = 45
			frame8.BorderSizePixel = 0
			frame8.ZIndex = 1
			frame8.Parent = billboardGui
			local uiGradient2 = Instance.new("UIGradient")
			uiGradient2.Rotation = 90
			local new2 = NumberSequenceKeypoint.new
			uiGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new2(1, 1) })
			uiGradient2.Parent = frame8
		end

		if billboardGui:FindFirstChild("Wrapper") then
			billboardGui.Wrapper.Position = UDim2.new(0.5, 25 * lineScale, 0.5, -25 * lineScale)
		end

		if billboardGui:FindFirstChild("Line") then
			billboardGui.Line.Size = UDim2.new(0, 1, 0, 36 * lineScale)
			billboardGui.Line.Position = UDim2.new(0.5, 12 * lineScale, 0.5, -12 * lineScale)
			billboardGui.Line.BackgroundColor3 = arg.color
		end

		local str3 = string.format("#%02X%02X%02X", arg.color.R * 255, arg.color.G * 255, arg.color.B * 255)
		local flag3 = arg.hookCount and arg.hookCount ~= ""
		local str4 = ""

		if flag3 then
			str4 = string.format(" <font color='#FF4444'>[%s]</font>", arg.hookCount)
		end

		local box = billboardGui:FindFirstChild("Wrapper") and billboardGui.Wrapper:FindFirstChild("Box")

		if box then
			if arg.distance then
				box.Text.Text = string.format("<font color='#FFFFFF'>%s</font>%s <font color='%s'>[%dm]</font>", arg.name, str4, str3, arg.distance)
			elseif arg.subtext then
				box.Text.Text = string.format("<font color='#FFFFFF'>%s</font>%s <font color='%s'>%s</font>", arg.name, str4, str3, arg.subtext)
			else
				box.Text.Text = string.format("<font color='#FFFFFF'>%s</font>%s", arg.name, str4)
			end

			if arg.icon and arg.icon ~= "" then
				box.Icon.Image = arg.icon
				box.Icon.Visible = true
			else
				box.Icon.Visible = false
			end
		end

		local statusText = billboardGui:FindFirstChild("Wrapper") and billboardGui.Wrapper:FindFirstChild("StatusText")

		if statusText then
			if arg.status and arg.status ~= "" then
				statusText.Text = arg.status
				statusText.Visible = true

				if arg.status == "Hook" then
					statusText.TextColor3 = Color3.fromRGB(255, 50, 50)
				elseif arg.status == "Knock" then
					statusText.TextColor3 = Color3.fromRGB(255, 150, 50)
				elseif arg.status == "Injured" then
					statusText.TextColor3 = Color3.fromRGB(255, 255, 50)
				end
			else
				statusText.Visible = false
			end
		end
	end

	fn44 = function()
		if not tbl3.ESP_Master then
			return
		end
		local v3 = fn8()

		if tbl3.ESP_KillerWarn and v3 and fn5() == "Survivor" then
			local killerWarn = v3:FindFirstChild("KillerWarn")
			local huge = math.huge

			for _, player in ipairs(tbl.Players:GetPlayers()) do
				if player ~= tbl.LocalPlayer and fn6(player) and player.Character then
					local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart2 then
						local magnitude = (humanoidRootPart2.Position - v3.Position).Magnitude

						if magnitude < huge then
							huge = magnitude
						end
					end
				end
			end

			if huge <= 80 then
				if not killerWarn then
					killerWarn = Instance.new("BillboardGui")
					killerWarn.Name = "KillerWarn"
					killerWarn.Size = UDim2.new(0, 28, 0, 28)
					killerWarn.AlwaysOnTop = true
					killerWarn.StudsOffset = Vector3.new(0, 4, 0)
					killerWarn.Parent = v3
					local frame6 = Instance.new("Frame")
					frame6.Name = "WarnBox"
					frame6.Size = UDim2.new(0.65, 0, 0.65, 0)
					frame6.Position = UDim2.new(0.5, 0, 0.5, 0)
					frame6.AnchorPoint = Vector2.new(0.5, 0.5)
					frame6.BackgroundTransparency = 1
					frame6.Rotation = 45
					frame6.Parent = killerWarn
					local uiStroke3 = Instance.new("UIStroke")
					uiStroke3.Name = "WarnStroke"
					uiStroke3.Thickness = 1
					uiStroke3.Parent = frame6
					local textLabel5 = Instance.new("TextLabel")
					textLabel5.Name = "WarnText"
					textLabel5.Size = UDim2.new(0.8, 0, 0.8, 0)
					textLabel5.Position = UDim2.new(0.5, 0, 0.5, 0)
					textLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
					textLabel5.BackgroundTransparency = 1
					textLabel5.TextScaled = true
					textLabel5.TextStrokeTransparency = 0.4
					textLabel5.Font = Enum.Font.GothamBlack
					textLabel5.Text = "!"
					textLabel5.ZIndex = 2
					textLabel5.Parent = killerWarn
				end

				local warnText = killerWarn:FindFirstChild("WarnText")
				local warnBox = killerWarn:FindFirstChild("WarnBox")
				warnBox = warnBox and warnBox:FindFirstChild("WarnStroke")

				if warnText and warnBox then
					if huge <= 40 then
						warnBox.Color = Color3.fromRGB(255, 20, 20)
						warnText.TextColor3 = Color3.fromRGB(255, 20, 20)
					else
						warnBox.Color = Color3.fromRGB(255, 220, 0)
						warnText.TextColor3 = Color3.fromRGB(255, 220, 0)
					end
				end
			elseif killerWarn then
				killerWarn:Destroy()
			end
		else
			local killerWarn = v3 and v3:FindFirstChild("KillerWarn")

			if killerWarn then
				killerWarn:Destroy()
			end
		end

		if tbl3.ESP_Player or tbl3.ESP_Killer then
			for _, player in pairs(tbl.Players:GetPlayers()) do
				if player ~= tbl.LocalPlayer and player.Character then
					local v4 = fn6(player)
					local head = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")

					if head and (not v4 and tbl3.ESP_Player or v4 and tbl3.ESP_Killer) then
						local n = v3 and math.floor((head.Position - v3.Position).Magnitude) or 0
						local name = v4 and "KEH" or "PEH"
						local str3 = v4 and "KE_Text" or "PE_Text"
						local str4 = v4 and "PEH" or "KEH"
						local str5 = v4 and "PE_Text" or "KE_Text"

						if player.Character:FindFirstChild(str4) then
							player.Character[str4]:Destroy()
						end

						if player.Character:FindFirstChild(str5) then
							player.Character[str5]:Destroy()
						end

						if n <= tbl3.ESP_MaxDistance then
							local killer = v4 and tbl7.Colors.Killer or tbl7.Colors.Player
							local highlight = player.Character:FindFirstChild(name)

							if not highlight then
								highlight = Instance.new("Highlight")
								highlight.Name = name
								highlight.Parent = player.Character
							end

							highlight.FillColor = killer
							highlight.OutlineColor = killer
							highlight.FillTransparency = tbl3.ESP_Outline and 1 or tbl3.Trans or 0.7
							highlight.OutlineTransparency = 0.5

							if tbl3.ESP_Name then
								local v5 = nil
								local str6 = ""
								local str7 = ""

								if not v4 then
									v5 = nil

									if tbl3.ESP_ItemIcon then
										local attribute = player:GetAttribute("EquippedItem")
										local flag3 = attribute and attribute ~= ""
										v5 = nil

										if flag3 then
											v5 = fn46(attribute)
										end
									end

									local character = player.Character
									local attribute = character:GetAttribute("IsHooked") or character:GetAttribute("isHooked") or character:GetAttribute("Hooked")
									local attribute2 = character:GetAttribute("Knocked") or character:GetAttribute("isKnocked")
									local humanoid2 = character:FindFirstChildOfClass("Humanoid")
									local flag3 = humanoid2 and humanoid2.Health <= 60 and humanoid2.Health > 0

									if attribute then
										str6 = "Hook"
									elseif attribute2 then
										str6 = "Knock"
									elseif flag3 then
										str6 = "Injured"
									end

									local attribute3 = character:GetAttribute("HookCount") or 0

									if attribute3 == 1 then
										str7 = "I"
									elseif attribute3 == 2 then
										str7 = "II"
									elseif attribute3 >= 3 then
										str7 = "III"
									end
								end

								fn43(player.Character, str3, {
									name = player.Name,
									distance = n,
									color = killer,
									icon = v5,
									status = str6,
									hookCount = str7,
									lineScale = v4 and 0.6 or 1,
								})
							else
								local v5 = player.Character:FindFirstChild(str3)

								if v5 then
									v5:Destroy()
								end
							end
						else
							local v5 = player.Character:FindFirstChild(name)
							local v6 = player.Character:FindFirstChild(str3)

							if v5 then
								v5:Destroy()
							end

							if v6 then
								v6:Destroy()
							end
						end
					end
				end
			end
		end
	end
end

local fn45

fn45 = function()
	if not tbl3.ESP_Master then
		return
	end
	local v3 = fn8()

	local function fn46(arg)
		if not v3 then
			return 0
		end
		return math.floor((arg - v3.Position).Magnitude)
	end

	if tbl3.ESP_Generator then
		for k, generator2 in pairs(tbl9.Generators) do
			local model = generator2.model

			if model and model.Parent and generator2.part then
				local espMaxDistance = tbl3.ESP_MaxDistance

				if fn46(generator2.part.Position) <= espMaxDistance then
					local n = math.floor(model:GetAttribute("RepairProgress") or 0)
					local attribute = model:GetAttribute("PlayersRepairingCount") or 0
					local generatorDone = n >= 100 and tbl7.Colors.GeneratorDone or tbl7.Colors.Generator
					local geh = model:FindFirstChild("GEH")

					if not geh then
						geh = Instance.new("Highlight")
						geh.Name = "GEH"
						geh.Parent = model
					end

					geh.FillColor = generatorDone
					geh.OutlineColor = generatorDone
					local n2 = tbl3.ESP_Outline and 1
					local trans

					if n2 then
						trans = n2
					else
						trans = tbl3.Trans or 0.7
					end

					geh.FillTransparency = trans
					geh.OutlineTransparency = 0.5

					if tbl3.ESP_NameG then
						fn43(model, "GE_Text", {
							name = "G " .. k,
							subtext = attribute > 0 and string.format("[%d%%] (%d plyr)", n, attribute) or string.format("[%d%%]", n),
							color = generatorDone,
							icon = nil,
							lineScale = 0.2,
						})
					else
						local geText = model:FindFirstChild("GE_Text")

						if geText then
							geText:Destroy()
						end
					end
				else
					if model:FindFirstChild("GEH") then
						model.GEH:Destroy()
					end

					if model:FindFirstChild("GE_Text") then
						model.GE_Text:Destroy()
					end
				end
			end
		end
	end

	if tbl3.ESP_Pallet then
		for _, pallet in pairs(tbl9.Pallets) do
			local model = pallet.model

			if model and model.Parent then
				local espMaxDistance = tbl3.ESP_MaxDistance

				if fn46(model:GetPivot().Position) <= espMaxDistance then
					local palletEH = model:FindFirstChild("PalletEH")

					if not palletEH then
						palletEH = Instance.new("Highlight")
						palletEH.Name = "PalletEH"
						palletEH.Parent = model
					end

					local pallet2 = tbl7.Colors.Pallet
					palletEH.Adornee = model
					palletEH.FillColor = pallet2
					palletEH.OutlineColor = pallet2
					palletEH.FillTransparency = tbl3.ESP_Outline and 1 or tbl3.Trans or 0.7
					palletEH.OutlineTransparency = 0.5
				elseif model:FindFirstChild("PalletEH") then
					model.PalletEH:Destroy()
				end
			end
		end
	end

	if tbl3.ESP_Window then
		for _, window in ipairs(tbl9.Windows) do
			if window and window.Parent then
				local bottom = window:FindFirstChild("Bottom") or window:FindFirstChildWhichIsA("BasePart")

				if bottom then
					local espMaxDistance = tbl3.ESP_MaxDistance

					if fn46(bottom.Position) <= espMaxDistance then
						local windowEH = window:FindFirstChild("WindowEH")

						if not windowEH then
							windowEH = Instance.new("BoxHandleAdornment")
							windowEH.Name = "WindowEH"
							windowEH.Parent = window
							windowEH.AlwaysOnTop = true
							windowEH.ZIndex = 5
						end

						windowEH.Adornee = bottom
						windowEH.Size = bottom.Size
						windowEH.Color3 = tbl7.Colors.Window
						windowEH.Transparency = tbl3.ESP_Outline and 0.8 or 0.4
					elseif window:FindFirstChild("WindowEH") then
						window.WindowEH:Destroy()
					end
				end
			end
		end
	end

	if tbl3.ESP_Hook then
		for _, hook in ipairs(tbl9.Hooks) do
			if hook and hook.Parent then
				local espMaxDistance = tbl3.ESP_MaxDistance

				if fn46(hook:GetPivot().Position) <= espMaxDistance then
					local hookEH = hook:FindFirstChild("HookEH")

					if not hookEH then
						hookEH = Instance.new("Highlight")
						hookEH.Name = "HookEH"
						hookEH.Parent = hook
					end

					local hook2 = tbl7.Colors.Hook
					hookEH.FillColor = hook2
					hookEH.OutlineColor = hook2
					local n = tbl3.ESP_Outline and 1
					local trans

					if n then
						trans = n
					else
						trans = tbl3.Trans or 0.7
					end

					hookEH.FillTransparency = trans
					hookEH.OutlineTransparency = 0.5
				elseif hook:FindFirstChild("HookEH") then
					hook.HookEH:Destroy()
				end
			end
		end
	end

	if tbl3.ESP_Gate then
		for i, gate in ipairs(tbl9.Gates) do
			if gate and gate.Parent then
				local espMaxDistance = tbl3.ESP_MaxDistance

				if fn46(gate:GetPivot().Position) <= espMaxDistance then
					if not gate:FindFirstChild("Main") then
						gate:FindFirstChildWhichIsA("BasePart")
					end

					local gateEH = gate:FindFirstChild("GateEH")

					if not gateEH then
						gateEH = Instance.new("Highlight")
						gateEH.Name = "GateEH"
						gateEH.Parent = gate
					end

					local gate2 = tbl7.Colors.Gate
					gateEH.Adornee = gate
					gateEH.FillColor = gate2
					gateEH.OutlineColor = gate2
					gateEH.FillTransparency = tbl3.ESP_Outline and 1 or 0.5
					gateEH.OutlineTransparency = 0
					local exitLever = gate:FindFirstChild("ExitLever")
					local n = 0

					if exitLever then
						local main = exitLever:FindFirstChild("Main")
						local n2 = 0

						if main then
							n = math.floor(main:GetAttribute("ActivationProgress") or 0)
						else
							n = n2
						end
					end

					fn43(gate, "GateE_Text", {
						name = "Gate " .. i,
						subtext = string.format("[%d%%]", n),
						color = gate2,
						icon = nil,
						lineScale = 0.2,
					})
				else
					if gate:FindFirstChild("GateEH") then
						gate.GateEH:Destroy()
					end

					if gate:FindFirstChild("GateE_Text") then
						gate.GateE_Text:Destroy()
					end
				end
			end
		end
	end
end

local part
part = Instance.new("Part")
part.Name = "PLaser"
part.Material = Enum.Material.Neon
part.Color = Color3.fromRGB(57, 255, 20)
part.CanCollide = false
part.Anchored = true
part.CastShadow = false
part.Size = Vector3.new(0.05, 0.05, 1.5)

pcall(function()
	local trajectory = tbl.Workspace.Terrain:FindFirstChild("Trajectory") or tbl.Workspace:FindFirstChild("Trajectory")

	if trajectory then
		trajectory:Destroy()
	end
end)

local highlight
highlight = Instance.new("Highlight")
highlight.Name = "VTarget"
highlight.FillColor = Color3.fromRGB(255, 0, 0)
highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
highlight.FillTransparency = 0.5
highlight.OutlineTransparency = 0
local fn46, fn47

do
	local circle = Drawing.new("Circle")
	circle.Filled = true
	circle.Radius = 6
	circle.Color = Color3.fromRGB(0, 220, 255)
	circle.Transparency = 0.9
	circle.Visible = false
	local n = 15
	local folder = Instance.new("Folder")
	folder.Name = "Trajectory"
	folder.Parent = tbl.Workspace.Terrain
	local tbl12 = {}
	local tbl13 = {}

	for i = 1, n + 1 do
		local attachment = Instance.new("Attachment")
		attachment.Name = "Att_" .. i
		attachment.Parent = folder
		table.insert(tbl12, attachment)
	end

	for i = 1, 15 do
		local beam = Instance.new("Beam")
		beam.Attachment0 = tbl12[i]
		beam.Attachment1 = tbl12[i + 1]
		beam.Width0 = 0.12
		beam.Width1 = 0.12
		beam.FaceCamera = true
		beam.Color = ColorSequence.new(Color3.fromRGB(0, 220, 255))
		beam.LightEmission = 1
		beam.LightInfluence = 0
		beam.Texture = "rbxassetid://4740112440"
		beam.TextureSpeed = 2
		beam.Enabled = false
		beam.Parent = folder
		table.insert(tbl13, beam)
	end

	fn46 = function()
		for _, v3 in ipairs(tbl13) do
			v3.Enabled = false
		end

		circle.Visible = false
	end

	fn47 = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
		local n2 = arg2 * arg3
		local n3 = math.max(tbl3.SPEAR_MaxDist or 500, 500)
		local position3 = arg6 and arg6.Position
		local magnitude = position3 and (position3 - arg).Magnitude or 100
		local n4 = magnitude / arg3 / n
		local vector = Vector3.new(0, -arg4, 0)
		local tbl14 = { arg }
		arg7 = arg7 or position3
		local huge = math.huge

		for i = 1, 15 do
			arg = arg + n2 * n4 + 0.5 * vector * n4 ^ 2
			table.insert(tbl14, arg)

			if arg7 then
				local magnitude2 = (arg - arg7).Magnitude

				if magnitude2 < huge then
					huge = magnitude2
				end
			end

			n2 += vector * n4
		end

		local flag3 = arg6 ~= nil and magnitude <= n3 and huge <= 6
		local colorSequence = ColorSequence.new(flag3 and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 60, 60))

		for i = 1, #tbl14 do
			if tbl12[i] then
				tbl12[i].WorldPosition = tbl14[i]
			end
		end

		for i = 1, 15 do
			if i < #tbl14 and tbl3.Veil_ShowLaser then
				tbl13[i].Color = colorSequence
				tbl13[i].Enabled = true
			else
				tbl13[i].Enabled = false
			end
		end

		if arg6 then
			local v3, v4 = tbl.Camera:WorldToViewportPoint(arg6.Position)

			if v4 and v3.Z > 0 then
				circle.Position = Vector2.new(v3.X, v3.Y)
				circle.Visible = true

				if flag3 then
					circle.Color = Color3.fromRGB(0, 255, 120)
				else
					circle.Color = Color3.fromRGB(255, 60, 60)
				end
			else
				circle.Visible = false
			end
		else
			circle.Visible = false
		end
	end

	local tbl14 = {}

	local function fn48()
		if not tbl3.Misc_Fullbright then
			return
		end

		if tbl.Lighting.Brightness ~= 1 then
			tbl.Lighting.Brightness = 1
		end

		if tbl.Lighting.FogEnd ~= 100000 then
			tbl.Lighting.FogEnd = 100000
		end

		if tbl.Lighting.GlobalShadows ~= false then
			tbl.Lighting.GlobalShadows = false
		end

		if tbl.Lighting.OutdoorAmbient ~= Color3.fromRGB(255, 255, 255) then
			tbl.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		end

		if tbl.Lighting.Ambient ~= Color3.fromRGB(255, 255, 255) then
			tbl.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		end

		local atmosphere = tbl.Lighting:FindFirstChildOfClass("Atmosphere")

		if atmosphere and atmosphere.Density ~= 0 then
			atmosphere.Density = 0
		end
	end

	local function fn49()
		for _, v3 in ipairs(tbl14) do
			if v3.Connected then
				v3:Disconnect()
			end
		end

		table.clear(tbl14)

		for _, v3 in ipairs({ "Brightness", "FogEnd", "GlobalShadows", "OutdoorAmbient", "Ambient" }) do
			local connection3 = tbl.Lighting:GetPropertyChangedSignal(v3):Connect(function()
				if tbl3.Misc_Fullbright then
					fn48()
				end
			end)

			table.insert(tbl14, connection3)
		end

		local connection3 = tbl.Lighting.ChildAdded:Connect(function(child)
			if tbl3.Misc_Fullbright and child:IsA("Atmosphere") then
				child.Density = 0
			end
		end)

		table.insert(tbl14, connection3)
	end

	local function fn50()
		for _, v3 in ipairs(tbl14) do
			if v3.Connected then
				v3:Disconnect()
			end
		end

		table.clear(tbl14)
	end

	local function fn51(arg)
		local vector2 = Vector2.new(tbl.Camera.ViewportSize.X / 2, tbl.Camera.ViewportSize.Y / 2)
		local character = tbl.LocalPlayer.Character
		local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart2 then
			return nil
		end

		if arg == "Pistol" and tbl3.Pistol_BlockKnocked and fn11(character) then
			return nil
		end
		local huge = math.huge
		local v3 = nil

		for _, v4 in ipairs(tbl11) do
			if v4.Character then
				local v5 = fn6(v4)
				local v6 = fn5()

				if arg == "Survivor" and not v5 then
					local character2 = v4.Character
					local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

					if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
						local flag3 = arg == "Aimbot" or arg == "Pistol"
						local str3 = "HumanoidRootPart"

						if flag3 then
							if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
								str3 = "Head"
							elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
								str3 = "Torso"
							end
						end

						local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

						if torso then
							local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude
							local spearMaxDist

							if arg == "Survivor" then
								spearMaxDist = tbl3.SPEAR_MaxDist
							else
								spearMaxDist = math.huge

								if arg == "Aimbot" then
									if fn5() == "Killer" then
										spearMaxDist = 10
									else
										spearMaxDist = tbl3.Aimbot_MaxDist
									end
								end
							end

							if magnitude <= spearMaxDist then
								if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
									local aimbotRadius = tbl3.Aimbot_Radius
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= aimbotRadius then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
									local pistolFov = tbl3.Pistol_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= pistolFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
									local veilFov = tbl3.Veil_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= veilFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif magnitude < huge then
									huge = magnitude
									v3 = torso
								end
							end
						end
					end
				elseif arg == "Killer" and v5 then
					local character2 = v4.Character
					local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

					if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
						local flag3 = arg == "Aimbot" or arg == "Pistol"
						local str3 = "HumanoidRootPart"

						if flag3 then
							if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
								str3 = "Head"
							elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
								str3 = "Torso"
							end
						end

						local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

						if torso then
							local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude
							local spearMaxDist

							if arg == "Survivor" then
								spearMaxDist = tbl3.SPEAR_MaxDist
							else
								spearMaxDist = math.huge

								if arg == "Aimbot" then
									if fn5() == "Killer" then
										spearMaxDist = 10
									else
										spearMaxDist = tbl3.Aimbot_MaxDist
									end
								end
							end

							if magnitude <= spearMaxDist then
								if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
									local aimbotRadius = tbl3.Aimbot_Radius
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= aimbotRadius then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
									local pistolFov = tbl3.Pistol_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= pistolFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
									local veilFov = tbl3.Veil_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= veilFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif magnitude < huge then
									huge = magnitude
									v3 = torso
								end
							end
						end
					end
				elseif arg == "Flash" and v5 then
					local character2 = v4.Character
					local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

					if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
						local flag3 = arg == "Aimbot" or arg == "Pistol"
						local str3 = "HumanoidRootPart"

						if flag3 then
							if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
								str3 = "Head"
							elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
								str3 = "Torso"
							end
						end

						local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

						if torso then
							local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude
							local spearMaxDist

							if arg == "Survivor" then
								spearMaxDist = tbl3.SPEAR_MaxDist
							else
								spearMaxDist = math.huge

								if arg == "Aimbot" then
									if fn5() == "Killer" then
										spearMaxDist = 10
									else
										spearMaxDist = tbl3.Aimbot_MaxDist
									end
								end
							end

							if magnitude <= spearMaxDist then
								if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
									local aimbotRadius = tbl3.Aimbot_Radius
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= aimbotRadius then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
									local pistolFov = tbl3.Pistol_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= pistolFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
									local veilFov = tbl3.Veil_FOV
									local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

									if v8 then
										local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

										if magnitude2 < huge and magnitude2 <= veilFov then
											huge = magnitude2
											v3 = torso
										end
									end
								elseif magnitude < huge then
									huge = magnitude
									v3 = torso
								end
							end
						end
					end
				elseif arg == "Pistol" then
					if tbl3.Pistol_Target == "Killer" and v5 then
						local character2 = v4.Character
						local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
							local flag3 = arg == "Aimbot" or arg == "Pistol"
							local str3 = "HumanoidRootPart"

							if flag3 then
								if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
									str3 = "Head"
								elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
									str3 = "Torso"
								end
							end

							local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

							if torso then
								local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude

								if magnitude <= math.huge then
									if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
										local aimbotRadius = tbl3.Aimbot_Radius
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= aimbotRadius then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
										local pistolFov = tbl3.Pistol_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= pistolFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
										local veilFov = tbl3.Veil_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= veilFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif magnitude < huge then
										huge = magnitude
										v3 = torso
									end
								end
							end
						end
					elseif tbl3.Pistol_Target == "Survivor" and not v5 then
						local character2 = v4.Character
						local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
							local flag3 = arg == "Aimbot" or arg == "Pistol"
							local str3 = "HumanoidRootPart"

							if flag3 then
								if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
									str3 = "Head"
								else
									local flag4 = tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2
									local str4 = "HumanoidRootPart"

									if flag4 then
										str3 = "Torso"
									else
										str3 = str4
									end
								end
							end

							local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

							if torso then
								local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude

								if magnitude <= math.huge then
									if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
										local aimbotRadius = tbl3.Aimbot_Radius
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= aimbotRadius then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
										local pistolFov = tbl3.Pistol_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= pistolFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
										local veilFov = tbl3.Veil_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= veilFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif magnitude < huge then
										huge = magnitude
										v3 = torso
									end
								end
							end
						end
					end
				elseif arg == "Aimbot" then
					if v6 == "Survivor" and v5 then
						local character2 = v4.Character
						local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
							local flag3 = arg == "Aimbot" or arg == "Pistol"
							local str3 = "HumanoidRootPart"

							if flag3 then
								if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
									str3 = "Head"
								elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
									str3 = "Torso"
								end
							end

							local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

							if torso then
								local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude
								local n2

								if fn5() == "Killer" then
									n2 = 10
								else
									n2 = tbl3.Aimbot_MaxDist
								end

								if magnitude <= n2 then
									if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
										local aimbotRadius = tbl3.Aimbot_Radius
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= aimbotRadius then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
										local pistolFov = tbl3.Pistol_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= pistolFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
										local veilFov = tbl3.Veil_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= veilFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif magnitude < huge then
										huge = magnitude
										v3 = torso
									end
								end
							end
						end
					elseif v6 == "Killer" and not v5 then
						local character2 = v4.Character
						local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

						if humanoid2 and humanoid2.Health > 0 and not fn11(character2) then
							local flag3 = arg == "Aimbot" or arg == "Pistol"
							local str3 = "HumanoidRootPart"

							if flag3 then
								if tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1 then
									str3 = "Head"
								elseif tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2 then
									str3 = "Torso"
								end
							end

							local torso = character2:FindFirstChild(str3) or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart")

							if torso then
								local magnitude = (torso.Position - humanoidRootPart2.Position).Magnitude
								local n2

								if fn5() == "Killer" then
									n2 = 10
								else
									n2 = tbl3.Aimbot_MaxDist
								end

								if magnitude <= n2 then
									if arg == "Aimbot" and tbl3.Aimbot_ShowFOV and fn5() ~= "Killer" then
										local aimbotRadius = tbl3.Aimbot_Radius
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= aimbotRadius then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Pistol" and tbl3.Pistol_FOVMode then
										local pistolFov = tbl3.Pistol_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= pistolFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif arg == "Survivor" and tbl3.Veil_ShowFOV then
										local veilFov = tbl3.Veil_FOV
										local v7, v8 = tbl.Camera:WorldToViewportPoint(torso.Position)

										if v8 then
											local magnitude2 = (Vector2.new(v7.X, v7.Y) - vector2).Magnitude

											if magnitude2 < huge and magnitude2 <= veilFov then
												huge = magnitude2
												v3 = torso
											end
										end
									elseif magnitude < huge then
										huge = magnitude
										v3 = torso
									end
								end
							end
						end
					end
				end
			end
		end

		if arg == "Pistol" and tbl3.Pistol_Target == "SCP" then
			for _, scP in ipairs(tbl9.SCPs) do
				if scP and scP.Parent then
					local humanoid2 = scP:FindFirstChildOfClass("Humanoid")
					local humanoidRootPart3 = scP:FindFirstChild("HumanoidRootPart") or scP.PrimaryPart

					if humanoid2 and humanoidRootPart3 and math.floor(humanoid2.WalkSpeed) > 0 and math.floor(humanoid2.WalkSpeed) ~= 16 then
						if (tbl3.AIM_TargetPart == "Head" or tbl3.AIM_TargetPart == 1) and scP:FindFirstChild("Head") then
							humanoidRootPart3 = scP.Head
						elseif (tbl3.AIM_TargetPart == "Torso" or tbl3.AIM_TargetPart == 2) and scP:FindFirstChild("Torso") then
							humanoidRootPart3 = scP.Torso
						end

						local v4, v5 = tbl.Camera:WorldToViewportPoint(humanoidRootPart3.Position)

						if tbl3.Pistol_FOVMode then
							if v5 then
								local magnitude = (Vector2.new(v4.X, v4.Y) - vector2).Magnitude

								if magnitude < huge and magnitude <= tbl3.Pistol_FOV then
									huge = magnitude
									v3 = humanoidRootPart3
								end
							end
						else
							local magnitude = (humanoidRootPart3.Position - humanoidRootPart2.Position).Magnitude

							if magnitude < huge then
								huge = magnitude
								v3 = humanoidRootPart3
							end
						end
					end
				end
			end
		end

		return v3
	end

	local function fn52()
		pcall(function()
			local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
			if not playerGui then
				return
			end
			local survivorMob = playerGui:FindFirstChild("Survivor-mob")
			local guiMob = survivorMob and survivorMob:FindFirstChild("Controls") and survivorMob.Controls:FindFirstChild("Gui-mob")

			if guiMob and guiMob:IsA("GuiObject") and guiMob.Visible then
				if type(firesignal) == "function" then
					pcall(function()
						firesignal(guiMob.MouseButton1Down)
						task.wait(0.01)
						firesignal(guiMob.MouseButton1Up)
					end)
				end
			else
				pcall(function()
					tbl.VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
					task.wait(0.01)
					tbl.VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
				end)
			end
		end)
	end

	local function fn53()
		if tbl6.ParryCooldown then
			return
		end

		pcall(function()
			if parry then
				parry:FireServer()
			end

			task.spawn(fn52)
		end)
	end

	local tbl15 = {}

	local function fn54()
		table.clear(tbl15)

		for _, player in ipairs(tbl.Players:GetPlayers()) do
			if player ~= tbl.LocalPlayer and fn6(player) and player.Character then
				table.insert(tbl15, player)
			end
		end
	end

	tbl.Players.PlayerAdded:Connect(fn54)
	tbl.Players.PlayerRemoving:Connect(fn54)

	for _, player in ipairs(tbl.Players:GetPlayers()) do
		player:GetPropertyChangedSignal("Team"):Connect(fn54)
	end

	local function fn55(arg)
		if arg then
			if tbl6.Pv2Con then
				return
			end

			tbl6.Pv2Con = tbl.RunService.Heartbeat:Connect(function()
				if tbl6.ParryCooldown then
					return
				end
				local character = tbl.LocalPlayer.Character
				if not character or fn11(character) or not fn13(character) then
					return
				end
				local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart2 then
					return
				end
				local n2 = (tbl3.Surv_ParryRadius or 15) + 5

				for _, v3 in ipairs(tbl15) do
					local character2 = v3.Character

					if character2 then
						local humanoidRootPart3 = character2:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart3 then
							local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

							if not (n2 < magnitude) then
								local humanoid2 = character2:FindFirstChildOfClass("Humanoid")

								if humanoid2 then
									local animator = humanoid2:FindFirstChildOfClass("Animator")

									if animator then
										local n3 = Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z) - Vector3.new(humanoidRootPart3.Position.X, 0, humanoidRootPart3.Position.Z)
										local flag3 = false

										if n3.Magnitude > 0 then
											local unit = n3.Unit
											flag3 = Vector3.new(humanoidRootPart3.CFrame.LookVector.X, 0, humanoidRootPart3.CFrame.LookVector.Z).Unit:Dot(unit) >= (tbl3.Surv_ParryFace or 0.85)
										end

										if flag3 then
											local playingAnimationTracks = animator:GetPlayingAnimationTracks()

											for _, playingAnimationTrack in ipairs(playingAnimationTracks) do
												if not tbl6.TrackV2[playingAnimationTrack] then
													tbl6.TrackV2[playingAnimationTrack] = true
													local v4 = tbl5[(playingAnimationTrack.Animation and playingAnimationTrack.Animation.AnimationId or ""):match("%d+")]

													if v4 then
														if not (tbl3.Ignored_Skills_List and tbl3.Ignored_Skills_List[v4]) then
															if magnitude <= tbl3.Surv_ParryRadius then
																fn53()
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end

				for k in pairs(tbl6.TrackV2) do
					if not k.IsPlaying then
						tbl6.TrackV2[k] = nil
					end
				end
			end)
		else
			if tbl6.Pv2Con then
				tbl6.Pv2Con:Disconnect()
				tbl6.Pv2Con = nil
			end

			table.clear(tbl6.TrackV2)
		end
	end

	local function fn56()
		local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
		if not playerGui then
			return nil
		end

		for _, child in pairs(playerGui:GetChildren()) do
			if string.sub(child.Name, -4) == "-mob" and child.Name ~= "Survivor-mob" then
				return child
			end
		end

		return nil
	end

	local function fn57(arg, arg2)
		if not arg then
			return
		end
		arg2 = arg2 or 0.2
		tbl.Camera.CFrame = tbl.Camera.CFrame:Lerp(CFrame.lookAt(tbl.Camera.CFrame.Position, arg.Position), arg2)
	end

	local function fn58(arg, arg2, arg3)
		local position3 = arg2.Position
		if not tbl3.Predict then
			return position3
		end
		local parent = arg2.Parent
		parent = parent and parent:FindFirstChildOfClass("Humanoid")
		local n2 = 0
		local vector = Vector3.zero

		if parent then
			vector = parent.MoveDirection * parent.WalkSpeed
			n2 = vector.Magnitude
		end

		if n2 < 0.1 then
			return position3
		end
		return position3 + vector * ((position3 - arg).Magnitude / arg3 * tbl3.Pistol_PredictLead + math.clamp(tbl6.CurrentPing, 0, 0.25))
	end

	local function fn59()
		local Pistol = fn51("Pistol")
		local character = tbl.LocalPlayer.Character
		if tbl3.Pistol_BlockKnocked and fn12(character) then
			return
		end

		if Pistol and character then
			local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
			character:FindFirstChild("Right Arm")

			if humanoidRootPart2 then
				local twistOfFate = character:FindFirstChild("Twist of Fate")

				if twistOfFate then
					local rightArm = twistOfFate:FindFirstChild("Right Arm")

					if rightArm then
						if rightArm:FindFirstChild("EmperorGun") then
							twistOfFate = rightArm:FindFirstChild("EmperorGun")
						elseif rightArm:FindFirstChild("gun") then
							twistOfFate = rightArm:FindFirstChild("gun")
						else
							twistOfFate = rightArm
						end
					end

					local position3 = humanoidRootPart2.Position
					local v3 = fn58(position3, Pistol, 160)

					if (v3 - position3).Magnitude < 4 then
						v3 -= Pistol.CFrame.RightVector * -2
					end

					local unit = (v3 + Vector3.new(0, tbl3.Pistol_AimOffset, 0) - position3).Unit
					local remotes2 = tbl.ReplicatedStorage:FindFirstChild("Remotes")

					if remotes2 and remotes2:FindFirstChild("Items") and remotes2.Items:FindFirstChild("Twist of Fate") and remotes2.Items["Twist of Fate"]:FindFirstChild("Fire") then
						remotes2.Items["Twist of Fate"].Fire:FireServer(twistOfFate, unit)
					end
				end
			end
		end
	end

	local function fn60()
		if tbl6.isHoldingLunge then
			return
		end
		tbl6.isHoldingLunge = true

		task.spawn(function()
			while tbl6.isHoldingLunge and tbl3.Killer_InfLunge and fn5() == "Killer" do
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.Attacks.Lunge:FireServer()
				end)

				task.wait(0.05)
			end
		end)
	end

	local function fn61(arg)
		if not arg then
			return
		end
		arg:SetAttribute("lungeboost", 999)

		if tbl6.lungeV2Connection then
			tbl6.lungeV2Connection:Disconnect()
		end

		tbl6.lungeV2Connection = arg:GetAttributeChangedSignal("lungeboost"):Connect(function()
			if tbl3.Killer_InfLungeV2 and arg:GetAttribute("lungeboost") ~= 999 then
				arg:SetAttribute("lungeboost", 999)
			end
		end)
	end

	tbl.LocalPlayer.CharacterAdded:Connect(function(character)
		if tbl3.Killer_InfLungeV2 then
			task.wait(0.5)
			fn61(character)
		end
	end)

	local tbl16 = { "Killer", "Survivor", "SCP" }
	local n2 = 1

	local function fn62()
		n2 += 1

		if n2 > #tbl16 then
			n2 = 1
		end

		local target = tbl16[n2]
		tbl3.Pistol_Target = target
		textLabel4.Text = "Target: " .. target

		pcall(function()
			if Options and Options.Pistol_Target_Drop then
				Options.Pistol_Target_Drop:SetValue(target)
			end
		end)

		if getgenv().Library then
			fn2("Pistol Target: " .. target, 0.5)
		end
	end

	textButton.MouseButton1Click:Connect(fn62)

	local function fn63()
		if tbl6.CrosshairUI then
			tbl6.CrosshairUI:Destroy()
		end

		if not tbl3.Crosshair_Enabled then
			return
		end
		tbl6.CrosshairUI = Instance.new("ScreenGui", tbl.CoreGui)
		tbl6.CrosshairUI.Name = "Croshair"
		tbl6.CrosshairUI.IgnoreGuiInset = true
		local frame6 = Instance.new("Frame", tbl6.CrosshairUI)
		frame6.AnchorPoint = Vector2.new(0.5, 0.5)
		frame6.Position = UDim2.new(0.5, tbl3.Crosshair_OffsetX, 0.5, tbl3.Crosshair_OffsetY)
		frame6.Size = UDim2.new(0, 0, 0, 0)
		frame6.BackgroundTransparency = 1
		local crosshairSize = tbl3.Crosshair_Size
		local crosshairColor = tbl3.Crosshair_Color
		local thickness = math.max(1, math.floor(crosshairSize / 4))
		local n3 = crosshairSize * 2
		local n4 = math.max(2, math.floor(crosshairSize / 1.5))

		if tbl3.Crosshair_Type == "Dot" then
			local frame7 = Instance.new("Frame", frame6)
			frame7.AnchorPoint = Vector2.new(0.5, 0.5)
			frame7.Size = UDim2.new(0, crosshairSize, 0, crosshairSize)
			frame7.Position = UDim2.new(0.5, 0, 0.5, 0)
			frame7.BackgroundColor3 = crosshairColor
			Instance.new("UICorner", frame7).CornerRadius = UDim.new(1, 0)
		elseif tbl3.Crosshair_Type == "Cross" then
			local frame7 = Instance.new("Frame", frame6)
			frame7.AnchorPoint = Vector2.new(0.5, 1)
			frame7.Size = UDim2.new(0, thickness, 0, n3)
			frame7.Position = UDim2.new(0.5, 0, 0.5, -n4)
			frame7.BackgroundColor3 = crosshairColor
			local frame8 = Instance.new("Frame", frame6)
			frame8.AnchorPoint = Vector2.new(0.5, 0)
			frame8.Size = UDim2.new(0, thickness, 0, n3)
			frame8.Position = UDim2.new(0.5, 0, 0.5, n4)
			frame8.BackgroundColor3 = crosshairColor
			local frame9 = Instance.new("Frame", frame6)
			frame9.AnchorPoint = Vector2.new(1, 0.5)
			frame9.Size = UDim2.new(0, n3, 0, thickness)
			frame9.Position = UDim2.new(0.5, -n4, 0.5, 0)
			frame9.BackgroundColor3 = crosshairColor
			local frame10 = Instance.new("Frame", frame6)
			frame10.AnchorPoint = Vector2.new(0, 0.5)
			frame10.Size = UDim2.new(0, n3, 0, thickness)
			frame10.Position = UDim2.new(0.5, n4, 0.5, 0)
			frame10.BackgroundColor3 = crosshairColor
		elseif tbl3.Crosshair_Type == "Circle" then
			local frame7 = Instance.new("Frame", frame6)
			frame7.AnchorPoint = Vector2.new(0.5, 0.5)
			frame7.Size = UDim2.new(0, crosshairSize * 2.5, 0, crosshairSize * 2.5)
			frame7.Position = UDim2.new(0.5, 0, 0.5, 0)
			frame7.BackgroundTransparency = 1
			local uiStroke3 = Instance.new("UIStroke", frame7)
			uiStroke3.Color = crosshairColor
			uiStroke3.Thickness = thickness
			Instance.new("UICorner", frame7).CornerRadius = UDim.new(1, 0)
		end
	end

	local lib2 = (function()
		-- >>> Embedded: Library
		local cloneref = (cloneref or clonereference or function(instance: any)
		    return instance
		end)
		local CoreGui: CoreGui = cloneref(game:GetService("CoreGui"))
		local Players: Players = cloneref(game:GetService("Players"))
		local RunService: RunService = cloneref(game:GetService("RunService"))
		local SoundService: SoundService = cloneref(game:GetService("SoundService"))
		local UserInputService: UserInputService = cloneref(game:GetService("UserInputService"))
		local TextService: TextService = cloneref(game:GetService("TextService"))
		local Teams: Teams = cloneref(game:GetService("Teams"))
		local TweenService: TweenService = cloneref(game:GetService("TweenService"))
		
		local getgenv = getgenv or function()
		    return shared
		end
		local setclipboard = setclipboard or nil
		local protectgui = protectgui or (syn and syn.protect_gui) or function() end
		local gethui = gethui or function()
		    return CoreGui
		end
		
		local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
		local Mouse = cloneref(LocalPlayer:GetMouse())
		
		local Labels = {}
		local Buttons = {}
		local Toggles = {}
		local Options = {}
		local Tooltips = {}
		
		local BaseURL = "https://script.vdtixo.store/lib"
		local CustomImageManager = {}
		local CustomImageManagerAssets = {
		    TransparencyTexture = {
		        RobloxId = 139785960036434,
		        Path = "lib/assets/TransparencyTexture.png",
		        URL = BaseURL .. "assets/TransparencyTexture.png",
		
		        Id = nil,
		    },
		
		    SaturationMap = {
		        RobloxId = 4155801252,
		        Path = "lib/assets/SaturationMap.png",
		        URL = BaseURL .. "assets/SaturationMap.png",
		
		        Id = nil,
		    },
		
		    LoadingIcon = {
		        RobloxId = 97544096941083,
		        Path = "lib/assets/LoadingIcon.png",
		        URL = BaseURL .. "assets/LoadingIcon.png",
		
		        Id = nil,
		    },
		
		    CheckIcon = {
		        RobloxId = 97682394690683,
		        Path = "lib/assets/CheckIcon.png",
		        URL = BaseURL .. "assets/CheckIcon.png",
		
		        Id = nil,
		    },
		}
		do
		    local function RecursiveCreatePath(Path: string, IsFile: boolean?)
		        if not isfolder or not makefolder then
		            return
		        end
		
		        local Segments = Path:split("/")
		        local TraversedPath = ""
		
		        if IsFile then
		            table.remove(Segments, #Segments)
		        end
		
		        for _, Segment in ipairs(Segments) do
		            if not isfolder(TraversedPath .. Segment) then
		                makefolder(TraversedPath .. Segment)
		            end
		
		            TraversedPath = TraversedPath .. Segment .. "/"
		        end
		
		        return TraversedPath
		    end
		
		    function CustomImageManager.AddAsset(
		        AssetName: string,
		        RobloxAssetId: number,
		        URL: string,
		        ForceRedownload: boolean?
		    )
		        if CustomImageManagerAssets[AssetName] ~= nil then
		            error(string.format("Asset %q already exists", AssetName))
		        end
		
		        assert(typeof(RobloxAssetId) == "number", "RobloxAssetId must be a number")
		
		        CustomImageManagerAssets[AssetName] = {
		            RobloxId = RobloxAssetId,
		            Path = string.format("lib/custom_assets/%s", AssetName),
		            URL = URL,
		
		            Id = nil,
		        }
		
		        CustomImageManager.DownloadAsset(AssetName, ForceRedownload)
		    end
		
		    function CustomImageManager.GetAsset(AssetName: string)
		        if not CustomImageManagerAssets[AssetName] then
		            return nil
		        end
		
		        local AssetData = CustomImageManagerAssets[AssetName]
		        if AssetData.Id then
		            return AssetData.Id
		        end
		
		        local AssetID = string.format("rbxassetid://%s", AssetData.RobloxId)
		
		        if getcustomasset then
		            local Success, NewID = pcall(getcustomasset, AssetData.Path)
		
		            if Success and NewID then
		                AssetID = NewID
		            end
		        end
		
		        AssetData.Id = AssetID
		        return AssetID
		    end
		
		    function CustomImageManager.DownloadAsset(AssetName: string, ForceRedownload: boolean?)
		        if not getcustomasset or not writefile or not isfile then
		            return false, "missing functions"
		        end
		
		        local AssetData = CustomImageManagerAssets[AssetName]
		
		        RecursiveCreatePath(AssetData.Path, true)
		
		        if ForceRedownload ~= true and isfile(AssetData.Path) then
		            return true, nil
		        end
		
		        local success, errorMessage = pcall(function()
		            writefile(AssetData.Path, game:HttpGet(AssetData.URL))
		        end)
		
		        return success, errorMessage
		    end
		
		    for AssetName, _ in CustomImageManagerAssets do
		        CustomImageManager.DownloadAsset(AssetName)
		    end
		end
		
		local Library = {
		    LocalPlayer = LocalPlayer,
		    DevicePlatform = nil,
		    IsMobile = false,
		    IsRobloxFocused = true,
		
		    ScreenGui = nil,
		
		    SearchText = "",
		    Searching = false,
		    GlobalSearch = false,
		    LastSearchTab = nil,
		
		    ActiveTab = nil,
		    Tabs = {},
		    TabButtons = {},
		    DependencyBoxes = {},
		
		    KeybindFrame = nil,
		    KeybindContainer = nil,
		    KeybindToggles = {},
		
		    Notifications = {},
		    Dialogues = {},
		    ActiveLoading = nil,
		    ActiveDialog = nil,
		
		    Corners = {},
		
		    ToggleKeybind = Enum.KeyCode.RightControl,
		    TweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		    NotifyTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		
		    Toggled = false,
		    Unloaded = false,
		
		    Labels = Labels,
		    Buttons = Buttons,
		    Toggles = Toggles,
		    Options = Options,
		
		    NotifySide = "Right",
		    ShowCustomCursor = true,
		    ForceCheckbox = false,
		    ShowToggleFrameInKeybinds = true,
		    NotifyOnError = false,
		
		    CantDragForced = false,
		
		    Signals = {},
		    UnloadSignals = {},
		
		    OriginalMinSize = Vector2.new(480, 360),
		    MinSize = Vector2.new(480, 360),
		    DPIScale = 0.95,
		    CornerRadius = 4,
		    CornerRadiusDropdown = false,
		
		    IsLightTheme = false,
		    Scheme = {
		        BackgroundColor = Color3.fromRGB(15, 15, 15),
		        MainColor = Color3.fromRGB(25, 25, 25),
		        AccentColor = Color3.fromRGB(245, 0, 0),
		        OutlineColor = Color3.fromRGB(103, 0, 0),
		        FontColor = Color3.new(1, 1, 1),
		        Font = Font.fromEnum(Enum.Font.Code),
		
		        RedColor = Color3.fromRGB(255, 50, 50),
		        DestructiveColor = Color3.fromRGB(220, 38, 38),
		        DarkColor = Color3.new(0, 0, 0),
		        WhiteColor = Color3.new(1, 1, 1),
		    },
		
		    Registry = {},
		    Scales = {},
		
		    ImageManager = CustomImageManager,
		    ShowCursorBinding = string.sub(tostring({}), 10),
		}
		
		if RunService:IsStudio() then
		    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
		        Library.IsMobile = true
		        Library.OriginalMinSize = Vector2.new(480, 240)
		    else
		        Library.IsMobile = false
		        Library.OriginalMinSize = Vector2.new(480, 360)
		    end
		else
		    pcall(function()
		        Library.DevicePlatform = UserInputService:GetPlatform()
		    end)
		    Library.IsMobile = (Library.DevicePlatform == Enum.Platform.Android or Library.DevicePlatform == Enum.Platform.IOS)
		    Library.OriginalMinSize = Library.IsMobile and Vector2.new(480, 240) or Vector2.new(480, 360)
		end
		
		local Templates = {
		    --// UI \\-
		    Frame = {
		        BorderSizePixel = 0,
		    },
		    ImageLabel = {
		        BackgroundTransparency = 1,
		        BorderSizePixel = 0,
		    },
		    ImageButton = {
		        AutoButtonColor = false,
		        BorderSizePixel = 0,
		    },
		    ScrollingFrame = {
		        BorderSizePixel = 0,
		    },
		    TextLabel = {
		        BorderSizePixel = 0,
		        FontFace = "Font",
		        RichText = true,
		        TextColor3 = "FontColor",
		    },
		    TextButton = {
		        AutoButtonColor = false,
		        BorderSizePixel = 0,
		        FontFace = "Font",
		        RichText = true,
		        TextColor3 = "FontColor",
		    },
		    TextBox = {
		        BorderSizePixel = 0,
		        FontFace = "Font",
		        PlaceholderColor3 = function()
		            local H, S, V = Library.Scheme.FontColor:ToHSV()
		            return Color3.fromHSV(H, S, V / 2)
		        end,
		        Text = "",
		        TextColor3 = "FontColor",
		    },
		    UIListLayout = {
		        SortOrder = Enum.SortOrder.LayoutOrder,
		    },
		    UIStroke = {
		        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		    },
		
		    --// Library \\--
		    Window = {
		        Title = "No Title",
		        Footer = "No Footer",
		        Position = UDim2.fromOffset(6, 6),
		        Size = UDim2.fromOffset(720, 600),
		        IconSize = UDim2.fromOffset(30, 30),
		        AutoShow = true,
		        Center = true,
		        Resizable = true,
		        SearchbarSize = UDim2.fromScale(1, 1),
		        GlobalSearch = false,
		        CornerRadius = 4,
		        NotifySide = "Right",
		        ShowCustomCursor = true,
		        Font = Enum.Font.Code,
		        ToggleKeybind = Enum.KeyCode.RightControl,
		        
		        ShowMobileButtons = true,
		        MobileButtonsSide = "Left",
		
		        UnlockMouseWhileOpen = true,
		
		        EnableSidebarResize = false,
		        EnableCompacting = true,
		        DisableCompactingSnap = false,
		        SidebarCompacted = false,
		        MinContainerWidth = 256,
		
		        --// Snapping \\--
		        MinSidebarWidth = 128,
		        SidebarCompactWidth = 48,
		        SidebarCollapseThreshold = 0.5,
		
		        --// Dragging \\--
		        CompactWidthActivation = 128,
		    },
		    Dialog = {
		        Title = "Dialog",
		        Description = "Description",
		        AutoDismiss = true,
		        OutsideClickDismiss = true,
		        FooterButtons = {}
		    },
		    Loading = {
		        Title = "mspaint",
		        Icon = 95816097006870,
		        IconSize = UDim2.fromOffset(30, 30),
		
		        LoadingIcon = CustomImageManager.GetAsset("LoadingIcon"),
		        LoadingIconColor = nil,
		        LoadingIconTweenTime = 1,
		
		        CurrentStep = 0,
		        TotalSteps = 10,
		
		        ShowSidebar = false,
		        AutoResizeHeight = false,
		
		        WindowWidth = 450,
		        WindowHeight = 275,
		
		        ContentWidth = 450,
		        SidebarWidth = 250,
		    },
		    Toggle = {
		        Text = "Toggle",
		        Default = false,
		
		        Callback = function() end,
		        Changed = function() end,
		
		        Risky = false,
		        Disabled = false,
		        Visible = true,
		    },
		    Input = {
		        Text = "Input",
		        Default = "",
		        Finished = false,
		        Numeric = false,
		        ClearTextOnFocus = true,
		        ClearTextOnBlur = false,
		        Placeholder = "",
		        AllowEmpty = true,
		        EmptyReset = "---",
		
		        Callback = function() end,
		        Changed = function() end,
		        VerifyValue = nil,
		
		        Disabled = false,
		        Visible = true,
		    },
		    Slider = {
		        Text = "Slider",
		        Default = 0,
		        Min = 0,
		        Max = 100,
		        Rounding = 0,
		
		        Prefix = "",
		        Suffix = "",
		
		        Callback = function() end,
		        Changed = function() end,
		
		        Disabled = false,
		        Visible = true,
		    },
		    Dropdown = {
		        Values = {},
		        DisabledValues = {},
		        Multi = false,
		        MaxVisibleDropdownItems = 8,
		
		        Callback = function() end,
		        Changed = function() end,
		
		        Disabled = false,
		        Visible = true,
		    },
		    Viewport = {
		        Object = nil,
		        Camera = nil,
		        Clone = true,
		        AutoFocus = true,
		        Interactive = false,
		        Height = 200,
		        Visible = true,
		    },
		    Image = {
		        Image = "",
		        Transparency = 0,
		        BackgroundTransparency = 0,
		        Color = Color3.new(1, 1, 1),
		        RectOffset = Vector2.zero,
		        RectSize = Vector2.zero,
		        ScaleType = Enum.ScaleType.Fit,
		        Height = 200,
		        Visible = true,
		    },
		    Video = {
		        Video = "",
		        Looped = false,
		        Playing = false,
		        Volume = 1,
		        Height = 200,
		        Visible = true,
		    },
		    UIPassthrough = {
		        Instance = nil,
		        Height = 24,
		        Visible = true,
		    },
		
		    --// Addons \\-
		    KeyPicker = {
		        Text = "KeyPicker",
		
		        Default = "None",
		        DefaultModifiers = {},
		
		        Blacklisted = {},
		        BlacklistedModifiers = {},
		        Whitelisted = {},
		        WhitelistedModifiers = {},
		
		        Mode = "Toggle",
		        Modes = { "Always", "Toggle", "Hold" },
		        SyncToggleState = false,
		
		        Callback = function() end,
		        ChangedCallback = function() end,
		        Changed = function() end,
		        Clicked = function() end,
		    },
		    ColorPicker = {
		        Default = Color3.new(1, 1, 1),
		
		        Callback = function() end,
		        Changed = function() end,
		    },
		}
		
		local Places = {
		    Bottom = { 0, 1 },
		    Right = { 1, 0 },
		}
		local Sizes = {
		    Left = { 0.5, 1 },
		    Right = { 0.5, 1 },
		}
		
		--// Scheme Functions \\--
		local SchemeReplaceAlias = {
		    RedColor = "Red",
		    WhiteColor = "White",
		    DarkColor = "Dark"
		}
		
		local SchemeAlias = {
		    Red = "RedColor",
		    White = "WhiteColor",
		    Dark = "DarkColor"
		}
		
		local function GetSchemeValue(Index)
		    if not Index then
		        return nil
		    end
		
		    local ReplaceAliasIndex = SchemeReplaceAlias[Index]
		    if ReplaceAliasIndex and Library.Scheme[ReplaceAliasIndex] ~= nil then
		        Library.Scheme[Index] = Library.Scheme[ReplaceAliasIndex]
		        Library.Scheme[ReplaceAliasIndex] = nil
		
		        return Library.Scheme[Index]
		    end
		
		    local AliasIndex = SchemeAlias[Index]
		    if AliasIndex and Library.Scheme[AliasIndex] ~= nil then
		        warn(string.format("Scheme Value %q is deprecated, please use %q instead.", Index, AliasIndex))
		        return Library.Scheme[AliasIndex]
		    end
		
		    return Library.Scheme[Index]
		end
		
		--// Basic Functions \\--
		local function WaitForEvent(Event, Timeout, Condition)
		    local Bindable = Instance.new("BindableEvent")
		    local Connection = Event:Once(function(...)
		        if not Condition or typeof(Condition) == "function" and Condition(...) then
		            Bindable:Fire(true)
		        else
		            Bindable:Fire(false)
		        end
		    end)
		    task.delay(Timeout, function()
		        Connection:Disconnect()
		        Bindable:Fire(false)
		    end)
		
		    local Result = Bindable.Event:Wait()
		    Bindable:Destroy()
		
		    return Result
		end
		
		local function IsMouseInput(Input: InputObject, IncludeM2: boolean?)
		    return Input.UserInputType == Enum.UserInputType.MouseButton1
		        or (IncludeM2 == true and Input.UserInputType == Enum.UserInputType.MouseButton2)
		        or Input.UserInputType == Enum.UserInputType.Touch
		end
		local function IsClickInput(Input: InputObject, IncludeM2: boolean?)
		    return IsMouseInput(Input, IncludeM2)
		        and Input.UserInputState == Enum.UserInputState.Begin
		        and Library.IsRobloxFocused
		end
		local function IsHoverInput(Input: InputObject)
		    return (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
		        and Input.UserInputState == Enum.UserInputState.Change
		end
		local function IsDragInput(Input: InputObject, IncludeM2: boolean?)
		    return IsMouseInput(Input, IncludeM2)
		        and (Input.UserInputState == Enum.UserInputState.Begin or Input.UserInputState == Enum.UserInputState.Change)
		        and Library.IsRobloxFocused
		end
		
		local function GetTableSize(Table: { [any]: any })
		    local Size = 0
		
		    for _, _ in Table do
		        Size += 1
		    end
		
		    return Size
		end
		local function StopTween(Tween: TweenBase)
		    if not (Tween and Tween.PlaybackState == Enum.PlaybackState.Playing) then
		        return
		    end
		
		    Tween:Cancel()
		end
		local function Trim(Text: string)
		    return Text:match("^%s*(.-)%s*$")
		end
		local function Round(Value, Rounding)
		    assert(Rounding >= 0, "Invalid rounding number.")
		
		    if Rounding == 0 then
		        return math.floor(Value)
		    end
		
		    return tonumber(string.format("%." .. Rounding .. "f", Value))
		end
		
		local function GetPlayers(ExcludeLocalPlayer: boolean?)
		    local PlayerList = Players:GetPlayers()
		
		    if ExcludeLocalPlayer then
		        local Idx = table.find(PlayerList, LocalPlayer)
		        if Idx then
		            table.remove(PlayerList, Idx)
		        end
		    end
		
		    table.sort(PlayerList, function(Player1, Player2)
		        return Player1.Name:lower() < Player2.Name:lower()
		    end)
		
		    return PlayerList
		end
		local function GetTeams()
		    local TeamList = Teams:GetTeams()
		
		    table.sort(TeamList, function(Team1, Team2)
		        return Team1.Name:lower() < Team2.Name:lower()
		    end)
		
		    return TeamList
		end
		
		function Library:UpdateDependencyBoxes()
		    for _, Depbox in Library.DependencyBoxes do
		        Depbox:Update(true)
		    end
		
		    if Library.Searching then
		        Library:UpdateSearch(Library.SearchText)
		    end
		end
		
		local function CheckDepbox(Box, Search)
		    local VisibleElements = 0
		
		    for _, ElementInfo in Box.Elements do
		        if ElementInfo.Type == "Divider" then
		            ElementInfo.Holder.Visible = false
		            continue
		        elseif ElementInfo.SubButton then
		            --// Check if any of the Buttons Name matches with Search
		            local Visible = false
		
		            --// Check if Search matches Element's Name and if Element is Visible
		            if ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		                Visible = true
		            else
		                ElementInfo.Base.Visible = false
		            end
		            if ElementInfo.SubButton.Text:lower():match(Search) and ElementInfo.SubButton.Visible then
		                Visible = true
		            else
		                ElementInfo.SubButton.Base.Visible = false
		            end
		            ElementInfo.Holder.Visible = Visible
		            if Visible then
		                VisibleElements += 1
		            end
		
		            continue
		        end
		
		        --// Check if Search matches Element's Name and if Element is Visible
		        if ElementInfo.Text and ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		            ElementInfo.Holder.Visible = true
		            VisibleElements += 1
		        else
		            ElementInfo.Holder.Visible = false
		        end
		    end
		
		    for _, Depbox in Box.DependencyBoxes do
		        if not Depbox.Visible then
		            continue
		        end
		
		        VisibleElements += CheckDepbox(Depbox, Search)
		    end
		
		    Box.Holder.Visible = VisibleElements > 0
		    return VisibleElements
		end
		local function RestoreDepbox(Box)
		    for _, ElementInfo in Box.Elements do
		        ElementInfo.Holder.Visible = typeof(ElementInfo.Visible) == "boolean" and ElementInfo.Visible or true
		
		        if ElementInfo.SubButton then
		            ElementInfo.Base.Visible = ElementInfo.Visible
		            ElementInfo.SubButton.Base.Visible = ElementInfo.SubButton.Visible
		        end
		    end
		
		    Box:Resize()
		    Box.Holder.Visible = true
		
		    for _, Depbox in Box.DependencyBoxes do
		        if not Depbox.Visible then
		            continue
		        end
		
		        RestoreDepbox(Depbox)
		    end
		end
		
		local function ApplySearchToTab(Tab, Search)
		    if not Tab then
		        return
		    end
		
		    local HasVisible = false
		
		    --// Loop through Groupboxes to get Elements Info
		    for _, Groupbox in Tab.Groupboxes do
		        local VisibleElements = 0
		
		        for _, ElementInfo in Groupbox.Elements do
		            if ElementInfo.Type == "Divider" then
		                ElementInfo.Holder.Visible = false
		                continue
		            elseif ElementInfo.SubButton then
		                --// Check if any of the Buttons Name matches with Search
		                local Visible = false
		
		                --// Check if Search matches Element's Name and if Element is Visible
		                if ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		                    Visible = true
		                else
		                    ElementInfo.Base.Visible = false
		                end
		                if ElementInfo.SubButton.Text:lower():match(Search) and ElementInfo.SubButton.Visible then
		                    Visible = true
		                else
		                    ElementInfo.SubButton.Base.Visible = false
		                end
		                ElementInfo.Holder.Visible = Visible
		                if Visible then
		                    VisibleElements += 1
		                end
		
		                continue
		            end
		
		            --// Check if Search matches Element's Name and if Element is Visible
		            if ElementInfo.Text and ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		                ElementInfo.Holder.Visible = true
		                VisibleElements += 1
		            else
		                ElementInfo.Holder.Visible = false
		            end
		        end
		
		        for _, Depbox in Groupbox.DependencyBoxes do
		            if not Depbox.Visible then
		                continue
		            end
		
		            VisibleElements += CheckDepbox(Depbox, Search)
		        end
		
		        --// Update Groupbox Size and Visibility if found any element
		        if VisibleElements > 0 then
		            Groupbox:Resize()
		            HasVisible = true
		        end
		        Groupbox.BoxHolder.Visible = VisibleElements > 0
		    end
		
		    for _, Tabbox in Tab.Tabboxes do
		        local VisibleTabs = 0
		        local VisibleElements = {}
		
		        for _, SubTab in Tabbox.Tabs do
		            VisibleElements[SubTab] = 0
		
		            for _, ElementInfo in SubTab.Elements do
		                if ElementInfo.Type == "Divider" then
		                    ElementInfo.Holder.Visible = false
		                    continue
		                elseif ElementInfo.SubButton then
		                    --// Check if any of the Buttons Name matches with Search
		                    local Visible = false
		
		                    --// Check if Search matches Element's Name and if Element is Visible
		                    if ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		                        Visible = true
		                    else
		                        ElementInfo.Base.Visible = false
		                    end
		                    if ElementInfo.SubButton.Text:lower():match(Search) and ElementInfo.SubButton.Visible then
		                        Visible = true
		                    else
		                        ElementInfo.SubButton.Base.Visible = false
		                    end
		                    ElementInfo.Holder.Visible = Visible
		                    if Visible then
		                        VisibleElements[SubTab] += 1
		                    end
		
		                    continue
		                end
		
		                --// Check if Search matches Element's Name and if Element is Visible
		                if ElementInfo.Text and ElementInfo.Text:lower():match(Search) and ElementInfo.Visible then
		                    ElementInfo.Holder.Visible = true
		                    VisibleElements[SubTab] += 1
		                else
		                    ElementInfo.Holder.Visible = false
		                end
		            end
		
		            for _, Depbox in SubTab.DependencyBoxes do
		                if not Depbox.Visible then
		                    continue
		                end
		
		                VisibleElements[SubTab] += CheckDepbox(Depbox, Search)
		            end
		        end
		
		        for SubTab, Visible in VisibleElements do
		            SubTab.ButtonHolder.Visible = Visible > 0
		            if Visible > 0 then
		                VisibleTabs += 1
		                HasVisible = true
		
		                if Tabbox.ActiveTab == SubTab then
		                    SubTab:Resize()
		                elseif Tabbox.ActiveTab and VisibleElements[Tabbox.ActiveTab] == 0 then
		                    SubTab:Show()
		                end
		            end
		        end
		
		        --// Update Tabbox Visibility if any visible
		        Tabbox.BoxHolder.Visible = VisibleTabs > 0
		    end
		
		    return HasVisible
		end
		local function ResetTab(Tab)
		    if not Tab then
		        return
		    end
		
		    for _, Groupbox in Tab.Groupboxes do
		        for _, ElementInfo in Groupbox.Elements do
		            ElementInfo.Holder.Visible = typeof(ElementInfo.Visible) == "boolean" and ElementInfo.Visible or true
		
		            if ElementInfo.SubButton then
		                ElementInfo.Base.Visible = ElementInfo.Visible
		                ElementInfo.SubButton.Base.Visible = ElementInfo.SubButton.Visible
		            end
		        end
		
		        for _, Depbox in Groupbox.DependencyBoxes do
		            if not Depbox.Visible then
		                continue
		            end
		
		            RestoreDepbox(Depbox)
		        end
		
		        Groupbox:Resize()
		        Groupbox.BoxHolder.Visible = true
		    end
		
		    for _, Tabbox in Tab.Tabboxes do
		        for _, SubTab in Tabbox.Tabs do
		            for _, ElementInfo in SubTab.Elements do
		                ElementInfo.Holder.Visible = typeof(ElementInfo.Visible) == "boolean" and ElementInfo.Visible or true
		
		                if ElementInfo.SubButton then
		                    ElementInfo.Base.Visible = ElementInfo.Visible
		                    ElementInfo.SubButton.Base.Visible = ElementInfo.SubButton.Visible
		                end
		            end
		
		            for _, Depbox in SubTab.DependencyBoxes do
		                if not Depbox.Visible then
		                    continue
		                end
		
		                RestoreDepbox(Depbox)
		            end
		
		            SubTab.ButtonHolder.Visible = true
		        end
		
		        if Tabbox.ActiveTab then
		            Tabbox.ActiveTab:Resize()
		        end
		        Tabbox.BoxHolder.Visible = true
		    end
		end
		
		function Library:UpdateSearch(SearchText)
		    Library.SearchText = SearchText
		
		    local TabsToReset = {}
		
		    if Library.GlobalSearch then
		        for _, Tab in Library.Tabs do
		            if typeof(Tab) == "table" and not Tab.IsKeyTab then
		                table.insert(TabsToReset, Tab)
		            end
		        end
		    elseif Library.LastSearchTab and typeof(Library.LastSearchTab) == "table" then
		        table.insert(TabsToReset, Library.LastSearchTab)
		    end
		
		    for _, Tab in ipairs(TabsToReset) do
		        ResetTab(Tab)
		    end
		
		    local Search = SearchText:lower()
		    if Trim(Search) == "" then
		        Library.Searching = false
		        Library.LastSearchTab = nil
		        return
		    end
		    if not Library.GlobalSearch and Library.ActiveTab and Library.ActiveTab.IsKeyTab then
		        Library.Searching = false
		        Library.LastSearchTab = nil
		        return
		    end
		
		    Library.Searching = true
		
		    local TabsToSearch = {}
		
		    if Library.GlobalSearch then
		        TabsToSearch = TabsToReset
		        if #TabsToSearch == 0 then
		            for _, Tab in Library.Tabs do
		                if typeof(Tab) == "table" and not Tab.IsKeyTab then
		                    table.insert(TabsToSearch, Tab)
		                end
		            end
		        end
		    elseif Library.ActiveTab then
		        table.insert(TabsToSearch, Library.ActiveTab)
		    end
		
		    local FirstVisibleTab = nil
		    local ActiveHasVisible = false
		
		    for _, Tab in ipairs(TabsToSearch) do
		        local HasVisible = ApplySearchToTab(Tab, Search)
		        if HasVisible then
		            if not FirstVisibleTab then
		                FirstVisibleTab = Tab
		            end
		            if Tab == Library.ActiveTab then
		                ActiveHasVisible = true
		            end
		        end
		    end
		
		    if Library.GlobalSearch then
		        if ActiveHasVisible and Library.ActiveTab then
		            Library.ActiveTab:RefreshSides()
		        elseif FirstVisibleTab then
		            local SearchMarker = SearchText
		            task.defer(function()
		                if Library.SearchText ~= SearchMarker then
		                    return
		                end
		
		                if Library.ActiveTab ~= FirstVisibleTab then
		                    FirstVisibleTab:Show()
		                end
		            end)
		        end
		        Library.LastSearchTab = nil
		    else
		        Library.LastSearchTab = Library.ActiveTab
		    end
		end
		
		function Library:AddToRegistry(Instance, Properties)
		    Library.Registry[Instance] = Properties
		end
		
		function Library:RemoveFromRegistry(Instance)
		    Library.Registry[Instance] = nil
		end
		
		function Library:UpdateColorsUsingRegistry()
		    for Instance, Properties in Library.Registry do
		        for Property, Index in Properties do
		            local SchemeValue = GetSchemeValue(Index)
		
		            if SchemeValue or typeof(Index) == "function" then
		                Instance[Property] = SchemeValue or Index()
		            end
		        end
		    end
		end
		
		function Library:SetDPIScale(DPIScale: number)
		    Library.DPIScale = DPIScale / 100
		    Library.MinSize = Library.OriginalMinSize * Library.DPIScale
		
		    for _, UIScale in Library.Scales do
		        UIScale.Scale = Library.DPIScale
		    end
		
		    for _, Option in Options do
		        if Option.Type == "Dropdown" then
		            Option:RecalculateListSize()
		        end
		    end
		
		    for _, Notification in Library.Notifications do
		        Notification:Resize()
		    end
		end
		
		function Library:GiveSignal(Connection: RBXScriptConnection | RBXScriptSignal)
		    local ConnectionType = typeof(Connection)
		    if Connection and (ConnectionType == "RBXScriptConnection" or ConnectionType == "RBXScriptSignal") then
		        table.insert(Library.Signals, Connection)
		    end
		
		    return Connection
		end
		
		function IsValidCustomIcon(Icon: string)
		    return typeof(Icon) == "string" and (Icon:match("rbxasset") or Icon:match("roblox%.com/asset/%?id=") or Icon:match("rbxthumb://type="))
		end
		
		type Icon = {
		    Url: string,
		    Id: number,
		    IconName: string,
		    ImageRectOffset: Vector2,
		    ImageRectSize: Vector2,
		}
		
		type IconModule = {
		    Icons: { string },
		    GetAsset: (Name: string) -> Icon?,
		}
		
		local FetchIcons, Icons = pcall(function()
		    return (loadstring(
		        game:HttpGet("https://script.vdtixo.store/lib/source.lua")
		    ) :: () -> IconModule)()
		end)
		
		function Library:GetIcon(IconName: string)
		    if not FetchIcons then
		        return
		    end
		
		    local Success, Icon = pcall(Icons.GetAsset, IconName)
		    if not Success then
		        return
		    end
		    return Icon
		end
		
		function Library:GetCustomIcon(IconName: string): any
		    if not IconName then
		        return nil
		    end
		
		    if tonumber(IconName) then
		        IconName = string.format("rbxassetid://%s", tostring(IconName))
		    end
		
		    local CustomIcon = IsValidCustomIcon(IconName)
		    if CustomIcon then
		        return {
		            Url = IconName,
		            ImageRectOffset = Vector2.zero,
		            ImageRectSize = Vector2.zero,
		            Custom = true,
		        }
		    end
		
		    local LucideIcon = Library:GetIcon(IconName)
		    if LucideIcon then
		        return LucideIcon
		    end
		
		    return nil
		end
		
		function Library:Validate(Table: { [string]: any }, Template: { [string]: any }): { [string]: any }
		    if typeof(Table) ~= "table" then
		        return Template
		    end
		
		    for k, v in Template do
		        if typeof(k) == "number" then
		            continue
		        end
		
		        if typeof(v) == "table" then
		            Table[k] = Library:Validate(Table[k], v)
		        elseif Table[k] == nil then
		            Table[k] = v
		        end
		    end
		
		    return Table
		end
		
		--// Creator Functions \\--
		local function FillInstance(Table: { [string]: any }, Instance: GuiObject)
		    local ThemeProperties = Library.Registry[Instance] or {}
		
		    for key, value in Table do
		        if key ~= "Text" then
		            local SchemeValue = GetSchemeValue(value)
		
		            if SchemeValue or typeof(value) == "function" then
		                ThemeProperties[key] = value
		                value = SchemeValue or value()
		            else
		                ThemeProperties[key] = nil
		            end
		        end
		
		        Instance[key] = value
		    end
		
		    if GetTableSize(ThemeProperties) > 0 then
		        Library.Registry[Instance] = ThemeProperties
		    end
		end
		
		local function New(ClassName: string, Properties: { [string]: any }): any
		    local Instance = Instance.new(ClassName)
		
		    if Templates[ClassName] then
		        FillInstance(Templates[ClassName], Instance)
		    end
		    FillInstance(Properties, Instance)
		
		    if Properties["Parent"] and not Properties["ZIndex"] then
		        pcall(function()
		            Instance.ZIndex = Properties.Parent.ZIndex
		        end)
		    end
		
		    return Instance
		end
		
		--// Main Instances \\-
		local function SafeParentUI(Instance: Instance, Parent: Instance | () -> Instance)
		    local success, _error = pcall(function()
		        if not Parent then
		            Parent = CoreGui
		        end
		
		        local DestinationParent
		        if typeof(Parent) == "function" then
		            DestinationParent = Parent()
		        else
		            DestinationParent = Parent
		        end
		
		        Instance.Parent = DestinationParent
		    end)
		
		    if not (success and Instance.Parent) then
		        Instance.Parent = Library.LocalPlayer:WaitForChild("PlayerGui", math.huge)
		    end
		end
		
		local function ParentUI(UI: Instance, SkipHiddenUI: boolean?)
		    if SkipHiddenUI then
		        SafeParentUI(UI, CoreGui)
		        return
		    end
		
		    pcall(protectgui, UI)
		    SafeParentUI(UI, gethui)
		end
		
		local ScreenGui = New("ScreenGui", {
		    Name = "Obsidian",
		    DisplayOrder = 998,
		    ResetOnSpawn = false,
		})
		ParentUI(ScreenGui)
		Library.ScreenGui = ScreenGui
		
		ScreenGui.DescendantRemoving:Connect(function(Instance)
		    Library:RemoveFromRegistry(Instance)
		end)
		
		local ModalElement = New("TextButton", {
		    BackgroundTransparency = 1,
		    Modal = false,
		    Size = UDim2.fromScale(0, 0),
		    AnchorPoint = Vector2.zero,
		    Text = "",
		    ZIndex = -999,
		    Parent = ScreenGui,
		})
		
		--// Cursor
		local Cursor, CursorCustomImage
		do
		    Cursor = New("Frame", {
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundColor3 = "WhiteColor",
		        Size = UDim2.fromOffset(9, 1),
		        Visible = false,
		        ZIndex = 11000,
		        Parent = ScreenGui,
		    })
		    New("Frame", {
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundColor3 = "DarkColor",
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.new(1, 2, 1, 2),
		        ZIndex = 10999,
		        Parent = Cursor,
		    })
		
		    local CursorV = New("Frame", {
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundColor3 = "WhiteColor",
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.fromOffset(1, 9),
		        ZIndex = 11000,
		        Parent = Cursor,
		    })
		    New("Frame", {
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundColor3 = "DarkColor",
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.new(1, 2, 1, 2),
		        ZIndex = 10999,
		        Parent = CursorV,
		    })
		
		    CursorCustomImage = New("ImageLabel", {
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundTransparency = 1,
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.fromOffset(20, 20),
		        ZIndex = 11000,
		        Visible = false,
		        Parent = Cursor
		    })
		end
		
		--// Notification
		local NotificationArea
		local NotificationList
		do
		    NotificationArea = New("Frame", {
		        AnchorPoint = Vector2.new(1, 0),
		        BackgroundTransparency = 1,
		        Position = UDim2.new(1, -6, 0, 6),
		        Size = UDim2.new(0, 300, 1, -6),
		        Parent = ScreenGui,
		    })
		    table.insert(
		        Library.Scales,
		        New("UIScale", {
		            Parent = NotificationArea,
		        })
		    )
		
		    NotificationList = New("UIListLayout", {
		        HorizontalAlignment = Enum.HorizontalAlignment.Right,
		        Padding = UDim.new(0, 8),
		        Parent = NotificationArea,
		    })
		end
		
		--// Lib Functions \\--
		function Library:ResetCursorIcon()
		    CursorCustomImage.Visible = false
		    CursorCustomImage.Size = UDim2.fromOffset(20, 20)
		end
		function Library:ChangeCursorIcon(ImageId: string)
		    if not ImageId or ImageId == "" then
		        Library:ResetCursorIcon()
		        return
		    end
		
		    local Icon = Library:GetCustomIcon(ImageId)
		    assert(Icon, "Image must be a valid Roblox asset or a valid URL or a valid lucide icon.")
		
		    CursorCustomImage.Visible = true
		    CursorCustomImage.Image = Icon.Url
		    CursorCustomImage.ImageRectOffset = Icon.ImageRectOffset
		    CursorCustomImage.ImageRectSize = Icon.ImageRectSize
		end
		
		function Library:ChangeCursorIconSize(Size: UDim2)
		    assert(typeof(Size) == "UDim2", "UDim2 expected.")
		    CursorCustomImage.Size = Size
		end
		
		function Library:GetBetterColor(Color: Color3, Add: number): Color3
		    Add = Add * (Library.IsLightTheme and -4 or 2)
		    return Color3.fromRGB(
		        math.clamp(Color.R * 255 + Add, 0, 255),
		        math.clamp(Color.G * 255 + Add, 0, 255),
		        math.clamp(Color.B * 255 + Add, 0, 255)
		    )
		end
		
		function Library:GetLighterColor(Color: Color3): Color3
		    local H, S, V = Color:ToHSV()
		    return Color3.fromHSV(H, math.max(0, S - 0.1), math.min(1, V + 0.1))
		end
		
		function Library:GetDarkerColor(Color: Color3): Color3
		    local H, S, V = Color:ToHSV()
		    return Color3.fromHSV(H, S, V / 2)
		end
		
		function Library:GetKeyString(KeyCode: Enum.KeyCode)
		    if KeyCode.EnumType == Enum.KeyCode and KeyCode.Value > 33 and KeyCode.Value < 127 then
		        return string.char(KeyCode.Value)
		    end
		
		    return KeyCode.Name
		end
		
		function Library:GetTextBounds(Text: string, Font: Font, Size: number, Width: number?): (number, number)
		    local Params = Instance.new("GetTextBoundsParams")
		    Params.Text = Text
		    Params.RichText = true
		    Params.Font = Font
		    Params.Size = Size
		    Params.Width = Width or workspace.CurrentCamera.ViewportSize.X - 32
		
		    local Bounds = TextService:GetTextBoundsAsync(Params)
		    return Bounds.X, Bounds.Y
		end
		
		function Library:MouseIsOverFrame(Frame: GuiObject, Mouse: Vector2): boolean
		    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize
		    return Mouse.X >= AbsPos.X
		        and Mouse.X <= AbsPos.X + AbsSize.X
		        and Mouse.Y >= AbsPos.Y
		        and Mouse.Y <= AbsPos.Y + AbsSize.Y
		end
		
		function Library:SafeCallback(Func: (...any) -> ...any, ...: any)
		    if not (Func and typeof(Func) == "function") then
		        return
		    end
		
		    local Result = table.pack(xpcall(Func, function(Error)
		        task.defer(error, debug.traceback(Error, 2))
		        if Library.NotifyOnError then
		            Library:Notify(Error)
		        end
		
		        return Error
		    end, ...))
		
		    if not Result[1] then
		        return nil
		    end
		
		    return table.unpack(Result, 2, Result.n)
		end
		
		function Library:MakeDraggable(UI: GuiObject, DragFrame: GuiObject, IgnoreToggled: boolean?, IsMainWindow: boolean?)
		    local StartPos
		    local FramePos
		    local Dragging = false
		    local Changed
		    DragFrame.InputBegan:Connect(function(Input: InputObject)
		        if not IsClickInput(Input) and Library.CantDragForced then
		            return
		        end
		
		        StartPos = Input.Position
		        FramePos = UI.Position
		        Dragging = true
		
		        Changed = Input.Changed:Connect(function()
		            if Input.UserInputState ~= Enum.UserInputState.End then
		                return
		            end
		
		            Dragging = false
		            if Changed and Changed.Connected then
		                Changed:Disconnect()
		                Changed = nil
		            end
		        end)
		    end)
		    Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input: InputObject)
		        if
		            (not IgnoreToggled and not Library.Toggled)
		            or (Library.CantDragForced)
		            or not (ScreenGui and ScreenGui.Parent)
		        then
		            Dragging = false
		            if Changed and Changed.Connected then
		                Changed:Disconnect()
		                Changed = nil
		            end
		
		            return
		        end
		
		        if Dragging and IsHoverInput(Input) then
		            local Delta = Input.Position - StartPos
		            UI.Position =
		                UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
		        end
		    end))
		end
		
		function Library:MakeResizable(UI: GuiObject, DragFrame: GuiObject, Callback: () -> ()?)
		    local StartPos
		    local FrameSize
		    local Dragging = false
		    local Changed
		
		    DragFrame.InputBegan:Connect(function(Input: InputObject)
		        if not IsClickInput(Input) then
		            return
		        end
		
		        StartPos = Input.Position
		        FrameSize = UI.Size
		        Dragging = true
		
		        Changed = Input.Changed:Connect(function()
		            if Input.UserInputState ~= Enum.UserInputState.End then
		                return
		            end
		
		            Dragging = false
		            if Changed and Changed.Connected then
		                Changed:Disconnect()
		                Changed = nil
		            end
		        end)
		    end)
		
		    Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input: InputObject)
		        if not UI.Visible or not (ScreenGui and ScreenGui.Parent) then
		            Dragging = false
		            if Changed and Changed.Connected then
		                Changed:Disconnect()
		                Changed = nil
		            end
		
		            return
		        end
		
		        if Dragging and IsHoverInput(Input) then
		            local Delta = Input.Position - StartPos
		            UI.Size = UDim2.new(
		                FrameSize.X.Scale,
		                math.clamp(FrameSize.X.Offset + Delta.X, Library.MinSize.X, math.huge),
		                FrameSize.Y.Scale,
		                math.clamp(FrameSize.Y.Offset + Delta.Y, Library.MinSize.Y, math.huge)
		            )
		            if Callback then
		                Library:SafeCallback(Callback)
		            end
		        end
		    end))
		end
		
		function Library:MakeCover(Holder: GuiObject, Place: string)
		    local Pos = Places[Place] or { 0, 0 }
		    local Size = Sizes[Place] or { 1, 0.5 }
		
		    local Cover = New("Frame", {
		        AnchorPoint = Vector2.new(Pos[1], Pos[2]),
		        BackgroundColor3 = Holder.BackgroundColor3,
		        Position = UDim2.fromScale(Pos[1], Pos[2]),
		        Size = UDim2.fromScale(Size[1], Size[2]),
		        Parent = Holder,
		    })
		
		    return Cover
		end
		
		function Library:MakeLine(Frame: GuiObject, Info)
		    local Line = New("Frame", {
		        AnchorPoint = Info.AnchorPoint or Vector2.zero,
		        BackgroundColor3 = "OutlineColor",
		        Position = Info.Position,
		        Size = Info.Size,
		        ZIndex = Info.ZIndex or Frame.ZIndex,
		        Parent = Frame,
		    })
		
		    return Line
		end
		
		function Library:AddOutline(Frame, Animated)
		    if Animated then
		        local Stroke = Instance.new("UIStroke")
		        Stroke.Thickness = 1.5 
		        Stroke.Color = Color3.fromRGB(255, 255, 255)
		        Stroke.Parent = Frame
		
		        local Gradient = Instance.new("UIGradient")
		        
		        -- Kiri dan kanan abu-abu, tengah putih cahaya
		        Gradient.Color = ColorSequence.new({
		            ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 150)),
		            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
		        })
		
		        -- Transparansi: Kiri & kanan transparan (0.6), tengah terang (0)
		        Gradient.Transparency = NumberSequence.new({
		            NumberSequenceKeypoint.new(0, 0.6), 
		            NumberSequenceKeypoint.new(0.5, 0), 
		            NumberSequenceKeypoint.new(1, 0.6)
		        })
		        
		        Gradient.Rotation = 45
		        Gradient.Parent = Stroke
		
		        Gradient.Offset = Vector2.new(-1, -1)
		
		        -- Animasi geser cahaya yang kalem (Durasi 4 detik)
		        game:GetService("TweenService"):Create(
		            Gradient,
		            TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		            { Offset = Vector2.new(1, 1) }
		        ):Play()
		
		        return Stroke
		    end
		
		    local OutlineStroke = New("UIStroke", {
		        Color = "OutlineColor",
		        Thickness = 1,
		        ZIndex = 2,
		        Parent = Frame,
		    })
		
		    local ShadowStroke = New("UIStroke", {
		        Color = "DarkColor",
		        Thickness = 1.5,
		        ZIndex = 1,
		        Parent = Frame,
		    })
		
		    return OutlineStroke, ShadowStroke
		end
		
		function Library:AddBlank(Frame: GuiObject, Size: UDim2)
		    return New("Frame", {
		        BackgroundTransparency = 1,
		        Size = Size or UDim2.fromScale(0, 0),
		        Parent = Frame,
		    })
		end
		
		--// Deprecated \\--
		function Library:MakeOutline(Frame: GuiObject, Corner: number?, ZIndex: number?)
		    warn("Obsidian:MakeOutline is deprecated, please use Obsidian:AddOutline instead.")
		    local Holder = New("Frame", {
		        BackgroundColor3 = "DarkColor",
		        Position = UDim2.fromOffset(-2, -2),
		        Size = UDim2.new(1, 4, 1, 4),
		        ZIndex = ZIndex,
		        Parent = Frame,
		    })
		
		    local Outline = New("Frame", {
		        BackgroundColor3 = "OutlineColor",
		        Position = UDim2.fromOffset(1, 1),
		        Size = UDim2.new(1, -2, 1, -2),
		        ZIndex = ZIndex,
		        Parent = Holder,
		    })
		
		    if Corner and Corner > 0 then
		        New("UICorner", {
		            CornerRadius = UDim.new(0, Corner + 1),
		            Parent = Holder,
		        })
		        New("UICorner", {
		            CornerRadius = UDim.new(0, Corner),
		            Parent = Outline,
		        })
		    end
		
		    return Holder, Outline
		end
		
		function Library:AddDraggableLabel(Text: string)
		    local Table = {}
		
		    local Label = New("TextLabel", {
		        AutomaticSize = Enum.AutomaticSize.XY,
		        BackgroundColor3 = "BackgroundColor",
		        Size = UDim2.fromOffset(0, 0),
		        Position = UDim2.fromOffset(6, 6),
		        Text = Text,
		        TextSize = 15,
		        ZIndex = 10,
		        Parent = ScreenGui,
		    })
		    table.insert(
		        Library.Corners, 
		        New("UICorner", {
		            CornerRadius = UDim.new(0, Library.CornerRadius),
		            Parent = Label,
		        })
		    )
		    New("UIPadding", {
		        PaddingBottom = UDim.new(0, 6),
		        PaddingLeft = UDim.new(0, 12),
		        PaddingRight = UDim.new(0, 12),
		        PaddingTop = UDim.new(0, 6),
		        Parent = Label,
		    })
		    table.insert(
		        Library.Scales,
		        New("UIScale", {
		            Parent = Label,
		        })
		    )
		 Library:AddOutline(Label, true)
		    
		    Library:MakeDraggable(Label, Label, true)
		
		    Table.Label = Label
		
		    function Table:SetText(Text: string)
		        Label.Text = Text
		    end
		
		    function Table:SetVisible(Visible: boolean)
		        Label.Visible = Visible
		    end
		
		    return Table
		end
		
		function Library:AddDraggableButton(Text: string, Func, ExcludeScaling: boolean?)
		    local Table = {}
		    
		    local IsIcon = string.find(Text, "rbxassetid://") or string.find(Text, "http")
		    
		    local ElementType = IsIcon and "ImageButton" or "TextButton"
		
		    local Button = New(ElementType, {
		        BackgroundColor3 = "BackgroundColor",
		        Position = UDim2.fromOffset(6, 6),
		        ZIndex = 10,
		        Parent = ScreenGui,
		    })
		    
		    table.insert(
		        Library.Corners, 
		        New("UICorner", {
		            CornerRadius = IsIcon and UDim.new(1, 0) or UDim.new(0, Library.CornerRadius),
		            Parent = Button,
		        })
		    )
		    
		    if not ExcludeScaling then
		        table.insert(
		            Library.Scales,
		            New("UIScale", {
		                Parent = Button,
		            })
		        )
		    end
		    
		    Library:AddOutline(Button, true)
		    
		    Button.MouseButton1Click:Connect(function()
		        Library:SafeCallback(Func, Table)
		    end)
		    Library:MakeDraggable(Button, Button, true)
		
		    Table.Button = Button
		
		    function Table:SetText(NewText: string)
		        if IsIcon then
		            Button.Image = NewText
		            Button.Size = UDim2.fromOffset(35, 35)
		        else
		            local X, Y = Library:GetTextBounds(NewText, Library.Scheme.Font, 16)
		            Button.TextSize = 16
		            Button.Text = NewText
		            Button.Size = UDim2.fromOffset(X * 2, Y * 2)
		        end
		    end
		    
		    Table:SetText(Text)
		
		    return Table
		end
		
		function Library:AddDraggableMenu(Name: string)
		    local Holder = New("Frame", {
		        AutomaticSize = Enum.AutomaticSize.XY,
		        BackgroundColor3 = "BackgroundColor",
		        Position = UDim2.fromOffset(6, 6),
		        Size = UDim2.fromOffset(0, 0),
		        ZIndex = 10,
		        Parent = ScreenGui,
		    })
		    table.insert(
		        Library.Corners,
		        New("UICorner", {
		            CornerRadius = UDim.new(0, Library.CornerRadius),
		            Parent = Holder,
		        })
		    )
		    table.insert(
		        Library.Scales,
		        New("UIScale", {
		            Parent = Holder,
		        })
		    )
		    Library:AddOutline(Holder)
		
		    Library:MakeLine(Holder, {
		        Position = UDim2.fromOffset(0, 34),
		        Size = UDim2.new(1, 0, 0, 1),
		    })
		
		    local Label = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Size = UDim2.new(1, 0, 0, 34),
		        Text = Name,
		        TextSize = 15,
		        TextXAlignment = Enum.TextXAlignment.Left,
		        Parent = Holder,
		    })
		    New("UIPadding", {
		        PaddingLeft = UDim.new(0, 12),
		        PaddingRight = UDim.new(0, 12),
		        Parent = Label,
		    })
		
		    local Container = New("Frame", {
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(0, 35),
		        Size = UDim2.new(1, 0, 1, -35),
		        Parent = Holder,
		    })
		    New("UIListLayout", {
		        Padding = UDim.new(0, 7),
		        Parent = Container,
		    })
		    New("UIPadding", {
		        PaddingBottom = UDim.new(0, 7),
		        PaddingLeft = UDim.new(0, 7),
		        PaddingRight = UDim.new(0, 7),
		        PaddingTop = UDim.new(0, 7),
		        Parent = Container,
		    })
		
		    Library:MakeDraggable(Holder, Label, true)
		    return Holder, Container
		end
		
		--// Watermark - Deprecated \\--
		do
		    local WatermarkLabel = Library:AddDraggableLabel("")
		    WatermarkLabel:SetVisible(false)
		
		    function Library:SetWatermark(Text: string)
		        warn("Watermark is deprecated, please use Library:AddDraggableLabel instead.")
		        WatermarkLabel:SetText(Text)
		    end
		
		    function Library:SetWatermarkVisibility(Visible: boolean)
		        warn("Watermark is deprecated, please use Library:AddDraggableLabel instead.")
		        WatermarkLabel:SetVisible(Visible)
		    end
		end
		
		--// Context Menu \\--
		local CurrentMenu
		function Library:AddContextMenu(
		    Holder: GuiObject,
		    Size: UDim2 | () -> (),
		    Offset: { [number]: number } | () -> {},
		    List: number?,
		    ActiveCallback: (Active: boolean) -> ()?,
		    IgnoreCornerRadius: boolean?
		)
		    local Menu
		    local ParentGui = Holder:FindFirstAncestorOfClass("ScreenGui")
		    if ParentGui ~= ScreenGui and (Library.ActiveLoading and ParentGui ~= Library.ActiveLoading.ScreenGui) then
		        ParentGui = ScreenGui
		    end
		
		    if List then
		        Menu = New("ScrollingFrame", {
		            AutomaticCanvasSize = List == 2 and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
		            AutomaticSize = List == 1 and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
		            BackgroundColor3 = "BackgroundColor",
		            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		            CanvasSize = UDim2.fromOffset(0, 0),
		            ScrollBarImageColor3 = "OutlineColor",
		            ScrollBarThickness = List == 2 and 2 or 0,
		            Size = typeof(Size) == "function" and Size() or Size,
		            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		            Visible = false,
		            ZIndex = 10,
		            Parent = ParentGui,
		        })
		    else
		        Menu = New("Frame", {
		            BackgroundColor3 = "BackgroundColor",
		            Size = typeof(Size) == "function" and Size() or Size,
		            Visible = false,
		            ZIndex = 10,
		            Parent = ParentGui,
		        })
		    end
		    table.insert(
		        Library.Scales,
		        New("UIScale", {
		            Parent = Menu,
		        })
		    )
		
		    New("UIStroke", {
		        Color = "OutlineColor",
		        Parent = Menu,
		    })
		
		    if IgnoreCornerRadius ~= true then
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                Parent = Menu,
		            })
		        )
		    end
		
		    local Table = {
		        Active = false,
		        Holder = Holder,
		        Menu = Menu,
		        List = nil,
		        Signal = nil,
		
		        Size = Size,
		    }
		
		    if List then
		        Table.List = New("UIListLayout", {
		            Parent = Menu,
		        })
		    end
		
		        function Table:Open()
		        if CurrentMenu == Table then
		            return
		        elseif CurrentMenu then
		            CurrentMenu:Close()
		        end
		
		        CurrentMenu = Table
		        Table.Active = true
		
		        if typeof(Offset) == "function" then
		            Menu.Position = UDim2.fromOffset(math.floor(Holder.AbsolutePosition.X + Offset()[1]), math.floor(Holder.AbsolutePosition.Y + Offset()[2]))
		        else
		            Menu.Position = UDim2.fromOffset(math.floor(Holder.AbsolutePosition.X + Offset[1]), math.floor(Holder.AbsolutePosition.Y + Offset[2]))
		        end
		        
		        local TargetSize = typeof(Table.Size) == "function" and Table.Size() or Table.Size
		        
		        Menu.Size = UDim2.new(TargetSize.X.Scale, TargetSize.X.Offset, TargetSize.Y.Scale, 0)
		        Menu.Visible = true
		
		        TweenService:Create(Menu, Library.TweenInfo, {
		            Size = TargetSize
		        }):Play()
		
		        if typeof(ActiveCallback) == "function" then
		            Library:SafeCallback(ActiveCallback, true)
		        end
		
		        Table.Signal = Holder:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		            if typeof(Offset) == "function" then
		                Menu.Position = UDim2.fromOffset(math.floor(Holder.AbsolutePosition.X + Offset()[1]), math.floor(Holder.AbsolutePosition.Y + Offset()[2]))
		            else
		                Menu.Position = UDim2.fromOffset(math.floor(Holder.AbsolutePosition.X + Offset[1]), math.floor(Holder.AbsolutePosition.Y + Offset[2]))
		            end
		        end)
		    end
		
		    function Table:Close()
		        if CurrentMenu ~= Table then
		            return
		        end
		
		        local TargetSize = typeof(Table.Size) == "function" and Table.Size() or Table.Size
		        local CloseTween = TweenService:Create(Menu, Library.TweenInfo, {
		            Size = UDim2.new(TargetSize.X.Scale, TargetSize.X.Offset, TargetSize.Y.Scale, 0)
		        })
		        CloseTween:Play()
		
		        task.delay(Library.TweenInfo.Time, function()
		            if not Table.Active then
		                Menu.Visible = false
		            end
		        end)
		
		        if Table.Signal then
		            Table.Signal:Disconnect()
		            Table.Signal = nil
		        end
		        Table.Active = false
		        CurrentMenu = nil
		        if typeof(ActiveCallback) == "function" then
		            Library:SafeCallback(ActiveCallback, false)
		        end
		    end
		
		    function Table:Close()
		        if CurrentMenu ~= Table then
		            return
		        end
		        Menu.Visible = false
		
		        if Table.Signal then
		            Table.Signal:Disconnect()
		            Table.Signal = nil
		        end
		        Table.Active = false
		        CurrentMenu = nil
		        if typeof(ActiveCallback) == "function" then
		            Library:SafeCallback(ActiveCallback, false)
		        end
		    end
		
		    function Table:Toggle()
		        if Table.Active then
		            Table:Close()
		        else
		            Table:Open()
		        end
		    end
		
		    function Table:SetSize(Size)
		        Table.Size = Size
		        Menu.Size = typeof(Size) == "function" and Size() or Size
		    end
		
		    return Table
		end
		
		Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input: InputObject)
		    if Library.Unloaded then
		        return
		    end
		
		    if IsClickInput(Input, true) then
		        local Location = Input.Position
		
		        if
		            CurrentMenu
		            and not (
		                Library:MouseIsOverFrame(CurrentMenu.Menu, Location)
		                or Library:MouseIsOverFrame(CurrentMenu.Holder, Location)
		            )
		        then
		            CurrentMenu:Close()
		        end
		    end
		end))
		
		--// Tooltip \\--
		local TooltipLabel = New("TextLabel", {
		    AutomaticSize = Enum.AutomaticSize.Y,
		    BackgroundColor3 = "BackgroundColor",
		    TextSize = 14,
		    TextWrapped = true,
		    Visible = false,
		    ZIndex = 20,
		    Parent = ScreenGui,
		})
		New("UIPadding", {
		    PaddingBottom = UDim.new(0, 2),
		    PaddingLeft = UDim.new(0, 4),
		    PaddingRight = UDim.new(0, 4),
		    PaddingTop = UDim.new(0, 2),
		    Parent = TooltipLabel,
		})
		table.insert(
		    Library.Scales,
		    New("UIScale", {
		        Parent = TooltipLabel,
		    })
		)
		New("UIStroke", {
		    Color = "OutlineColor",
		    Parent = TooltipLabel,
		})
		table.insert(
		    Library.Corners,
		    New("UICorner", {
		        CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		        Parent = TooltipLabel,
		    })
		)
		TooltipLabel:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		    if Library.Unloaded then
		        return
		    end
		
		    local X, _ = Library:GetTextBounds(
		        TooltipLabel.Text,
		        TooltipLabel.FontFace,
		        TooltipLabel.TextSize,
		        (workspace.CurrentCamera.ViewportSize.X - TooltipLabel.AbsolutePosition.X - 8) / Library.DPIScale
		    )
		
		    TooltipLabel.Size = UDim2.fromOffset(X + 8)
		end)
		
		local CurrentHoverInstance
		function Library:AddTooltip(InfoStr: string, DisabledInfoStr: string, HoverInstance: GuiObject)
		    local TooltipTable = {
		        Disabled = false,
		        Hovering = false,
		        Signals = {},
		    }
		
		    local function DoHover()
		        if
		            CurrentHoverInstance == HoverInstance
		            or Library.ActiveDialog
		            or (CurrentMenu and Library:MouseIsOverFrame(CurrentMenu.Menu, Mouse))
		            or (TooltipTable.Disabled and typeof(DisabledInfoStr) ~= "string")
		            or (not TooltipTable.Disabled and typeof(InfoStr) ~= "string")
		        then
		            return
		        end
		        CurrentHoverInstance = HoverInstance
		
		        local ParentGui = HoverInstance:FindFirstAncestorOfClass("ScreenGui")
		        if ParentGui ~= ScreenGui and (Library.ActiveLoading and ParentGui ~= Library.ActiveLoading.ScreenGui) then
		            ParentGui = ScreenGui
		        end
		        TooltipLabel.Parent = ParentGui
		
		        TooltipLabel.Text = TooltipTable.Disabled and DisabledInfoStr or InfoStr
		        TooltipLabel.Visible = true
		
		        while
		            (Library.Toggled or Library.ActiveLoading)
		            and not Library.ActiveDialog
		            and Library:MouseIsOverFrame(HoverInstance, Mouse)
		            and not (CurrentMenu and Library:MouseIsOverFrame(CurrentMenu.Menu, Mouse))
		        do
		            TooltipLabel.Position = UDim2.fromOffset(
		                Mouse.X + (Library.ShowCustomCursor and 8 or 14),
		                Mouse.Y + (Library.ShowCustomCursor and 8 or 12)
		            )
		
		            RunService.RenderStepped:Wait()
		        end
		
		        TooltipLabel.Visible = false
		        CurrentHoverInstance = nil
		    end
		
		    local function GiveSignal(Connection: RBXScriptConnection | RBXScriptSignal)
		        local ConnectionType = typeof(Connection)
		        if Connection and (ConnectionType == "RBXScriptConnection" or ConnectionType == "RBXScriptSignal") then
		            table.insert(TooltipTable.Signals, Connection)
		        end
		
		        return Connection
		    end
		
		    GiveSignal(HoverInstance.MouseEnter:Connect(DoHover))
		    GiveSignal(HoverInstance.MouseMoved:Connect(DoHover))
		    GiveSignal(HoverInstance.MouseLeave:Connect(function()
		        if CurrentHoverInstance ~= HoverInstance then
		            return
		        end
		
		        TooltipLabel.Visible = false
		        CurrentHoverInstance = nil
		    end))
		
		    function TooltipTable:Destroy()
		        for Index = #TooltipTable.Signals, 1, -1 do
		            local Connection = table.remove(TooltipTable.Signals, Index)
		            if Connection and Connection.Connected then
		                Connection:Disconnect()
		            end
		        end
		
		        if CurrentHoverInstance == HoverInstance then
		            if TooltipLabel then
		                TooltipLabel.Visible = false
		            end
		
		            CurrentHoverInstance = nil
		        end
		    end
		
		    table.insert(Tooltips, TooltipLabel)
		    return TooltipTable
		end
		
		function Library:OnUnload(Callback)
		    table.insert(Library.UnloadSignals, Callback)
		end
		
		function Library:Unload()
		    for Index = #Library.Signals, 1, -1 do
		        local Connection = table.remove(Library.Signals, Index)
		        if Connection and Connection.Connected then
		            Connection:Disconnect()
		        end
		    end
		
		    for _, Callback in Library.UnloadSignals do
		        Library:SafeCallback(Callback)
		    end
		
		    for _, Tooltip in Tooltips do
		        Library:SafeCallback(Tooltip.Destroy, Tooltip)
		    end
		
		    Library.Unloaded = true
		
		    if Library.ActiveLoading then
		        Library.ActiveLoading:Destroy()
		    end
		
		    if ScreenGui then
		        ScreenGui:Destroy()
		    end
		
		    getgenv().Library = nil
		end
		
		local CheckIcon = Library:GetIcon("check")
		local ArrowIcon = Library:GetIcon("chevron-up")
		local ResizeIcon = Library:GetIcon("move-diagonal-2")
		local KeyIcon = Library:GetIcon("key")
		local MoveIcon = Library:GetIcon("gamepad-directional")
		
		function Library:SetIconModule(module: IconModule)
		    FetchIcons = true
		    Icons = module
		
		    -- Top ten fixes 🚀
		    CheckIcon = Library:GetIcon("check")
		    ArrowIcon = Library:GetIcon("chevron-up")
		    ResizeIcon = Library:GetIcon("move-diagonal-2")
		    KeyIcon = Library:GetIcon("key")
		    MoveIcon = Library:GetIcon("gamepad-directional")
		end
		
		local BaseAddons = {}
		do
		    local Funcs = {}
		
		    function Funcs:AddKeyPicker(Idx, Info)
		        Info = Library:Validate(Info, Templates.KeyPicker)
		
		        local ParentObj = self
		        local ToggleLabel = ParentObj.TextLabel
		
		        local KeyPicker = {
		            Text = Info.Text,
		            Value = Info.Default, -- Key
		            Modifiers = Info.DefaultModifiers, -- Modifiers
		            DisplayValue = Info.Default, -- Picker Text
		
		            Blacklisted = Info.Blacklisted,
		            BlacklistedModifiers = Info.BlacklistedModifiers,
		            Whitelisted = Info.Whitelisted,
		            WhitelistedModifiers = Info.WhitelistedModifiers,
		
		            Toggled = false,
		            Mode = Info.Mode,
		            SyncToggleState = Info.SyncToggleState,
		
		            Callback = Info.Callback,
		            ChangedCallback = Info.ChangedCallback,
		            Changed = Info.Changed,
		            Clicked = Info.Clicked,
		
		            Type = "KeyPicker",
		        }
		
		        if KeyPicker.Mode == "Press" then
		            assert(ParentObj.Type == "Label", "KeyPicker with the mode 'Press' can be only applied on Labels.")
		
		            KeyPicker.SyncToggleState = false
		            Info.Modes = { "Press" }
		            Info.Mode = "Press"
		        end
		
		        if KeyPicker.SyncToggleState then
		            Info.Modes = { "Toggle", "Hold" }
		
		            if not table.find(Info.Modes, Info.Mode) then
		                Info.Mode = "Toggle"
		            end
		        end
		
		        local Picking = false
		
		        -- Special Keys
		        local SpecialKeys = {
		            ["MB1"] = Enum.UserInputType.MouseButton1,
		            ["MB2"] = Enum.UserInputType.MouseButton2,
		            ["MB3"] = Enum.UserInputType.MouseButton3,
		        }
		
		        local SpecialKeysInput = {
		            [Enum.UserInputType.MouseButton1] = "MB1",
		            [Enum.UserInputType.MouseButton2] = "MB2",
		            [Enum.UserInputType.MouseButton3] = "MB3",
		        }
		
		        -- Modifiers
		        local Modifiers = {
		            ["LAlt"] = Enum.KeyCode.LeftAlt,
		            ["RAlt"] = Enum.KeyCode.RightAlt,
		
		            ["LCtrl"] = Enum.KeyCode.LeftControl,
		            ["RCtrl"] = Enum.KeyCode.RightControl,
		
		            ["LShift"] = Enum.KeyCode.LeftShift,
		            ["RShift"] = Enum.KeyCode.RightShift,
		
		            ["Tab"] = Enum.KeyCode.Tab,
		            ["CapsLock"] = Enum.KeyCode.CapsLock,
		        }
		
		        local ModifiersInput = {
		            [Enum.KeyCode.LeftAlt] = "LAlt",
		            [Enum.KeyCode.RightAlt] = "RAlt",
		
		            [Enum.KeyCode.LeftControl] = "LCtrl",
		            [Enum.KeyCode.RightControl] = "RCtrl",
		
		            [Enum.KeyCode.LeftShift] = "LShift",
		            [Enum.KeyCode.RightShift] = "RShift",
		
		            [Enum.KeyCode.Tab] = "Tab",
		            [Enum.KeyCode.CapsLock] = "CapsLock",
		        }
		
		        local IsModifierInput = function(Input)
		            return Input.UserInputType == Enum.UserInputType.Keyboard and ModifiersInput[Input.KeyCode] ~= nil
		        end
		
		        local GetActiveModifiers = function()
		            local ActiveModifiers = {}
		
		            for Name, Input in Modifiers do
		                if table.find(ActiveModifiers, Name) then
		                    continue
		                end
		                if not UserInputService:IsKeyDown(Input) then
		                    continue
		                end
		
		                table.insert(ActiveModifiers, Name)
		            end
		
		            return ActiveModifiers
		        end
		
		        local AreModifiersHeld = function(Required)
		            if not (typeof(Required) == "table" and GetTableSize(Required) > 0) then
		                return true
		            end
		
		            local ActiveModifiers = GetActiveModifiers()
		            local Holding = true
		
		            for _, Name in Required do
		                if table.find(ActiveModifiers, Name) then
		                    continue
		                end
		
		                Holding = false
		                break
		            end
		
		            return Holding
		        end
		
		        local IsInputDown = function(Input)
		            if not Input then
		                return false
		            end
		
		            if SpecialKeysInput[Input.UserInputType] ~= nil then
		                return UserInputService:IsMouseButtonPressed(Input.UserInputType)
		                    and not UserInputService:GetFocusedTextBox()
		            elseif Input.UserInputType == Enum.UserInputType.Keyboard then
		                return UserInputService:IsKeyDown(Input.KeyCode) and not UserInputService:GetFocusedTextBox()
		            else
		                return false
		            end
		        end
		
		        local ConvertToInputModifiers = function(CurrentModifiers)
		            local InputModifiers = {}
		
		            for _, name in CurrentModifiers do
		                table.insert(InputModifiers, Modifiers[name])
		            end
		
		            return InputModifiers
		        end
		
		        local VerifyModifiers = function(CurrentModifiers)
		            if typeof(CurrentModifiers) ~= "table" then
		                return {}
		            end
		
		            local ValidModifiers = {}
		
		            for _, name in CurrentModifiers do
		                if not Modifiers[name] then
		                    continue
		                end
		
		                table.insert(ValidModifiers, name)
		            end
		
		            return ValidModifiers
		        end
		
		        KeyPicker.Modifiers = VerifyModifiers(KeyPicker.Modifiers)
		
		        local Picker = New("TextButton", {
		            BackgroundColor3 = "MainColor",
		            Size = UDim2.fromOffset(18, 18),
		            Text = KeyPicker.Value,
		            TextSize = 14,
		            Parent = ToggleLabel,
		        })
		
		        New("UIStroke", {
		            Color = "OutlineColor",
		            Parent = Picker,
		        })
		
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                Parent = Picker,
		            })
		        )
		
		        local KeybindsToggle = { Normal = KeyPicker.Mode ~= "Toggle" }
		        do
		            local Holder = New("TextButton", {
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, 0, 0, 16),
		                Text = "",
		                Visible = not Info.NoUI,
		                Parent = Library.KeybindContainer,
		            })
		
		            local Label = New("TextLabel", {
		                AutomaticSize = Enum.AutomaticSize.X,
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(0, 1),
		                Text = "",
		                TextSize = 14,
		                TextTransparency = 0.5,
		                Parent = Holder,
		            })
		
		            local Checkbox = New("Frame", {
		                AnchorPoint = Vector2.new(0, 0.5),
		                BackgroundColor3 = "MainColor",
		                Position = UDim2.fromScale(0, 0.5),
		                Size = UDim2.fromOffset(14, 14),
		                SizeConstraint = Enum.SizeConstraint.RelativeYY,
		                Parent = Holder,
		            })
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                    Parent = Checkbox,
		                })
		            )
		            New("UIStroke", {
		                Color = "OutlineColor",
		                Parent = Checkbox,
		            })
		
		            local CheckImage = New("ImageLabel", {
		                Image = CheckIcon and CheckIcon.Url or "",
		                ImageColor3 = "FontColor",
		                ImageRectOffset = CheckIcon and CheckIcon.ImageRectOffset or Vector2.zero,
		                ImageRectSize = CheckIcon and CheckIcon.ImageRectSize or Vector2.zero,
		                ImageTransparency = 1,
		                Position = UDim2.fromOffset(2, 2),
		                Size = UDim2.new(1, -4, 1, -4),
		                Parent = Checkbox,
		            })
		
		            function KeybindsToggle:Display(State)
		                Label.TextTransparency = State and 0 or 0.5
		                CheckImage.ImageTransparency = State and 0 or 1
		            end
		
		            function KeybindsToggle:SetText(Text)
		                Label.Text = Text
		            end
		
		            function KeybindsToggle:SetVisibility(Visibility)
		                Holder.Visible = Visibility
		            end
		
		            function KeybindsToggle:SetNormal(Normal)
		                KeybindsToggle.Normal = Normal
		
		                Holder.Active = not Normal
		                Label.Position = Normal and UDim2.fromOffset(0, 0) or UDim2.fromOffset(22, 0)
		                Checkbox.Visible = not Normal
		            end
		
		            KeyPicker.DoClick = function(...) end --// make luau lsp shut up
		            Holder.MouseButton1Click:Connect(function()
		                if KeybindsToggle.Normal then
		                    return
		                end
		
		                KeyPicker.Toggled = not KeyPicker.Toggled
		                KeyPicker:DoClick()
		            end)
		
		            KeybindsToggle.Holder = Holder
		            KeybindsToggle.Label = Label
		            KeybindsToggle.Checkbox = Checkbox
		            KeybindsToggle.Loaded = true
		            table.insert(Library.KeybindToggles, KeybindsToggle)
		        end
		
		        local MenuTable = Library:AddContextMenu(Picker, UDim2.fromOffset(62, 0), function()
		            return { Picker.AbsoluteSize.X + 1.5, 0.5 }
		        end, 1, nil, true)
		        KeyPicker.Menu = MenuTable
		
		        local ModeButtons = {}
		        for _, Mode in Info.Modes do
		            local ModeButton = {}
		
		            local Button = New("TextButton", {
		                BackgroundColor3 = "MainColor",
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, 0, 0, 21),
		                Text = Mode,
		                TextSize = 14,
		                TextTransparency = 0.5,
		                Parent = MenuTable.Menu,
		            })
		
		            function ModeButton:Select()
		                for _, Button in ModeButtons do
		                    Button:Deselect()
		                end
		
		                KeyPicker.Mode = Mode
		
		                Button.BackgroundTransparency = 0
		                Button.TextTransparency = 0
		
		                MenuTable:Close()
		            end
		
		            function ModeButton:Deselect()
		                KeyPicker.Mode = nil
		
		                Button.BackgroundTransparency = 1
		                Button.TextTransparency = 0.5
		            end
		
		            Button.MouseButton1Click:Connect(function()
		                ModeButton:Select()
		            end)
		
		            if KeyPicker.Mode == Mode then
		                ModeButton:Select()
		            end
		
		            ModeButtons[Mode] = ModeButton
		        end
		
		        function KeyPicker:Display(PickerText)
		            if Library.Unloaded then
		                return
		            end
		
		            local X, Y = Library:GetTextBounds(
		                PickerText or KeyPicker.DisplayValue,
		                Picker.FontFace,
		                Picker.TextSize,
		                ToggleLabel.AbsoluteSize.X
		            )
		            Picker.Text = PickerText or KeyPicker.DisplayValue
		            Picker.Size = UDim2.fromOffset((X + 9), (Y + 4))
		        end
		
		        function KeyPicker:Update()
		            KeyPicker:Display()
		
		            if Info.NoUI then
		                return
		            end
		
		            if KeyPicker.Mode == "Toggle" and ParentObj.Type == "Toggle" and ParentObj.Disabled then
		                KeybindsToggle:SetVisibility(false)
		                return
		            end
		
		            local State = KeyPicker:GetState()
		            local ShowToggle = Library.ShowToggleFrameInKeybinds and KeyPicker.Mode == "Toggle"
		
		            if KeyPicker.SyncToggleState and ParentObj.Value ~= State then
		                ParentObj:SetValue(State)
		            end
		
		            if KeybindsToggle.Loaded then
		                if ShowToggle then
		                    KeybindsToggle:SetNormal(false)
		                else
		                    KeybindsToggle:SetNormal(true)
		                end
		
		                KeybindsToggle:SetText(("[%s] %s (%s)"):format(KeyPicker.DisplayValue, KeyPicker.Text, KeyPicker.Mode))
		                KeybindsToggle:SetVisibility(true)
		                KeybindsToggle:Display(State)
		            end
		        end
		
		        function KeyPicker:GetState()
		            if KeyPicker.Mode == "Always" then
		                return true
		            elseif KeyPicker.Mode == "Hold" then
		                local Key = KeyPicker.Value
		                if Key == "None" then
		                    return false
		                end
		
		                if not AreModifiersHeld(KeyPicker.Modifiers) then
		                    return false
		                end
		
		                if SpecialKeys[Key] ~= nil then
		                    return UserInputService:IsMouseButtonPressed(SpecialKeys[Key])
		                        and not UserInputService:GetFocusedTextBox()
		                else
		                    return UserInputService:IsKeyDown(Enum.KeyCode[Key]) and not UserInputService:GetFocusedTextBox()
		                end
		            else
		                return KeyPicker.Toggled
		            end
		        end
		
		        function KeyPicker:OnChanged(Func)
		            KeyPicker.Changed = Func
		        end
		
		        function KeyPicker:OnClick(Func)
		            KeyPicker.Clicked = Func
		        end
		
		        function KeyPicker:DoClick()
		            if KeyPicker.Mode == "Press" then
		                if KeyPicker.Toggled and Info.WaitForCallback == true then
		                    return
		                end
		
		                KeyPicker.Toggled = true
		            end
		
		            Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
		            Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
		
		            if KeyPicker.Mode == "Press" then
		                KeyPicker.Toggled = false
		            end
		        end
		
		        function KeyPicker:SetValue(Data)
		            local Key, Mode, Modifiers = Data[1], Data[2], Data[3]
		
		            local IsKeyValid, KeyCode = pcall(function()
		                if Key == "None" then
		                    Key = nil
		                    return nil
		                end
		
		                if SpecialKeys[Key] == nil then
		                    return Enum.KeyCode[Key]
		                end
		
		                return SpecialKeys[Key]
		            end)
		
		            if Key == nil then
		                KeyPicker.Value = "None"
		            elseif IsKeyValid then
		                KeyPicker.Value = Key
		            else
		                KeyPicker.Value = "Unknown"
		            end
		
		            KeyPicker.Modifiers =
		                VerifyModifiers(if typeof(Modifiers) == "table" then Modifiers else KeyPicker.Modifiers)
		            KeyPicker.DisplayValue = if GetTableSize(KeyPicker.Modifiers) > 0
		                then (table.concat(KeyPicker.Modifiers, " + ") .. " + " .. KeyPicker.Value)
		                else KeyPicker.Value
		
		            if ModeButtons[Mode] then
		                ModeButtons[Mode]:Select()
		            end
		
		            local NewModifiers = ConvertToInputModifiers(KeyPicker.Modifiers)
		            Library:SafeCallback(KeyPicker.ChangedCallback, KeyCode, NewModifiers)
		            Library:SafeCallback(KeyPicker.Changed, KeyCode, NewModifiers)
		
		            KeyPicker:Update()
		        end
		
		        function KeyPicker:SetText(Text)
		            KeybindsToggle:SetText(Text)
		            KeyPicker:Update()
		        end
		
		        Picker.MouseButton1Click:Connect(function()
		            if Picking then
		                return
		            end
		
		            Picking = true
		
		            Picker.Text = "..."
		            Picker.Size = UDim2.fromOffset(29, 18)
		
		            -- Wait for an non modifier key --
		            local Input
		            local ActiveModifiers = {}
		
		            local GetInput = nil; GetInput = function()
		                Input = UserInputService.InputBegan:Wait()
		                if UserInputService:GetFocusedTextBox() ~= nil then
		                    return true
		                end
		
		                if Input.KeyCode == Enum.KeyCode.Escape then
		                    return false
		                end
		
		                local IsMod = IsModifierInput(Input)
		                local KeyName
		                if SpecialKeysInput[Input.UserInputType] ~= nil then
		                    KeyName = SpecialKeysInput[Input.UserInputType]
		                elseif Input.UserInputType == Enum.UserInputType.Keyboard then
		                    if IsMod then
		                        KeyName = ModifiersInput[Input.KeyCode]
		                    else
		                        KeyName = Input.KeyCode.Name
		                    end
		                end
		
		                if KeyName then
		                    if IsMod then
		                        if KeyPicker.WhitelistedModifiers and #KeyPicker.WhitelistedModifiers > 0 and not table.find(KeyPicker.WhitelistedModifiers, KeyName) then
		                            return GetInput()
		                        end
		
		                        if KeyPicker.BlacklistedModifiers and table.find(KeyPicker.BlacklistedModifiers, KeyName) then
		                            return GetInput()
		                        end
		                    else
		                        if KeyPicker.Whitelisted and #KeyPicker.Whitelisted > 0 and not table.find(KeyPicker.Whitelisted, KeyName) then
		                            return GetInput()
		                        end
		
		                        if KeyPicker.Blacklisted and table.find(KeyPicker.Blacklisted, KeyName) then
		                            return GetInput()
		                        end
		                    end
		                end
		
		                return false
		            end
		
		            repeat
		                task.wait()
		
		                -- Wait for any input --
		                Picker.Text = "..."
		                Picker.Size = UDim2.fromOffset(29, 18)
		
		                if GetInput() then
		                    Picking = false
		                    KeyPicker:Update()
		                    return
		                end
		
		                -- Escape --
		                if Input.KeyCode == Enum.KeyCode.Escape then
		                    break
		                end
		
		                -- Handle modifier keys --
		                if IsModifierInput(Input) then
		                    local StopLoop = false
		
		                    repeat
		                        task.wait()
		                        if UserInputService:IsKeyDown(Input.KeyCode) then
		                            task.wait(0.075)
		
		                            if UserInputService:IsKeyDown(Input.KeyCode) then
		                                -- Add modifier to the key list --
		                                if not table.find(ActiveModifiers, ModifiersInput[Input.KeyCode]) then
		                                    ActiveModifiers[#ActiveModifiers + 1] = ModifiersInput[Input.KeyCode]
		                                    KeyPicker:Display(table.concat(ActiveModifiers, " + ") .. " + ...")
		                                end
		
		                                -- Wait for another input --
		                                if GetInput() then
		                                    StopLoop = true
		                                    break -- Invalid Input
		                                end
		
		                                -- Escape --
		                                if Input.KeyCode == Enum.KeyCode.Escape then
		                                    break
		                                end
		
		                                -- Stop loop if its a normal key --
		                                if not IsModifierInput(Input) then
		                                    break
		                                end
		                            else
		                                if not table.find(ActiveModifiers, ModifiersInput[Input.KeyCode]) then
		                                    break -- Modifier is meant to be used as a normal key --
		                                end
		                            end
		                        end
		                    until false
		
		                    if StopLoop then
		                        Picking = false
		                        KeyPicker:Update()
		                        return
		                    end
		                end
		
		                break -- Input found, end loop
		            until false
		
		            local Key = "Unknown"
		            if SpecialKeysInput[Input.UserInputType] ~= nil then
		                Key = SpecialKeysInput[Input.UserInputType]
		            elseif Input.UserInputType == Enum.UserInputType.Keyboard then
		                Key = Input.KeyCode == Enum.KeyCode.Escape and "None" or Input.KeyCode.Name
		            end
		
		            ActiveModifiers = if Input.KeyCode == Enum.KeyCode.Escape or Key == "Unknown" then {} else ActiveModifiers
		
		            KeyPicker.Toggled = false
		            KeyPicker:SetValue({ Key, KeyPicker.Mode, ActiveModifiers })
		
		            repeat
		                task.wait()
		            until not IsInputDown(Input) or UserInputService:GetFocusedTextBox()
		            Picking = false
		        end)
		        Picker.MouseButton2Click:Connect(MenuTable.Toggle)
		
		        Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input: InputObject)
		            if Library.Unloaded then
		                return
		            end
		
		            if
		                KeyPicker.Mode == "Always"
		                or KeyPicker.Value == "Unknown"
		                or KeyPicker.Value == "None"
		                or Picking
		                or UserInputService:GetFocusedTextBox()
		            then
		                return
		            end
		
		            local Key = KeyPicker.Value
		            local HoldingModifiers = AreModifiersHeld(KeyPicker.Modifiers)
		            local HoldingKey = false
		
		            if
		                Key
		                and HoldingModifiers == true
		                and (
		                    SpecialKeysInput[Input.UserInputType] == Key
		                    or (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Key)
		                )
		            then
		                HoldingKey = true
		            end
		
		            if KeyPicker.Mode == "Toggle" then
		                if HoldingKey then
		                    KeyPicker.Toggled = not KeyPicker.Toggled
		                    KeyPicker:DoClick()
		                end
		            elseif KeyPicker.Mode == "Press" then
		                if HoldingKey then
		                    KeyPicker:DoClick()
		                end
		            end
		
		            KeyPicker:Update()
		        end))
		
		        Library:GiveSignal(UserInputService.InputEnded:Connect(function()
		            if Library.Unloaded then
		                return
		            end
		
		            if
		                KeyPicker.Value == "Unknown"
		                or KeyPicker.Value == "None"
		                or Picking
		                or UserInputService:GetFocusedTextBox()
		            then
		                return
		            end
		
		            KeyPicker:Update()
		        end))
		
		        KeyPicker:Update()
		
		        if ParentObj.Addons then
		            table.insert(ParentObj.Addons, KeyPicker)
		        end
		
		        KeyPicker.Default = KeyPicker.Value
		        KeyPicker.DefaultModifiers = table.clone(KeyPicker.Modifiers or {})
		
		        Options[Idx] = KeyPicker
		
		        return self
		    end
		
		            local HueSequenceTable = {}
		    for Hue = 0, 1, 0.1 do
		        table.insert(HueSequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)))
		    end
		    
		    function Funcs:AddColorPicker(Idx, Info)
		        local UserTransparency = Info.Transparency
		        local HasTransparency = (UserTransparency ~= nil)
		
		        Info = Library:Validate(Info, Templates.ColorPicker)
		
		        local ParentObj = self
		        local ToggleLabel = ParentObj.TextLabel
		
		        local ColorPicker = {
		            Value = Info.Default,
		            Transparency = UserTransparency or 0,
		            Title = Info.Title,
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		            Type = "ColorPicker",
		            HasTransparency = HasTransparency
		        }
		        ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = ColorPicker.Value:ToHSV()
		
		        local Holder = New("TextButton", {
		            BackgroundColor3 = ColorPicker.Value,
		            Size = UDim2.fromOffset(18, 18),
		            Text = "",
		            Parent = ToggleLabel,
		        })
		        local HolderStroke = New("UIStroke", {
		            Color = Library:GetDarkerColor(ColorPicker.Value),
		            Parent = Holder,
		        })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = Holder }))
		
		        local HolderTransparency = New("ImageLabel", {
		            Image = CustomImageManager.GetAsset("TransparencyTexture"),
		            ImageTransparency = (1 - ColorPicker.Transparency),
		            ScaleType = Enum.ScaleType.Tile,
		            Position = UDim2.new(0, -1, 0, -1),
		            Size = UDim2.new(1, 2, 1, 2),
		            TileSize = UDim2.fromOffset(9, 9),
		            Parent = Holder,
		        })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = HolderTransparency }))
		
		        local WindowWidth = ColorPicker.HasTransparency and 182 or 164
		        local WindowHeight = Info.Title and 226 or 204 
		        
		        local ColorWindow = New("Frame", {
		            BackgroundColor3 = "BackgroundColor",
		            AnchorPoint = Vector2.new(0.5, 0.5), 
		            Position = UDim2.fromScale(0.5, 0.5), 
		            Size = UDim2.fromOffset(WindowWidth, WindowHeight),
		            Visible = false,
		            ZIndex = 100,
		            Parent = ScreenGui,
		        })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = ColorWindow }))
		        Library:AddOutline(ColorWindow)
		        
		        local ContentLayout = New("UIListLayout", {
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            HorizontalAlignment = Enum.HorizontalAlignment.Center, 
		            Padding = UDim.new(0, 8),
		            Parent = ColorWindow,
		        })
		        New("UIPadding", {
		            PaddingTop = UDim.new(0, 8), 
		            PaddingBottom = UDim.new(0, 8),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            Parent = ColorWindow,
		        })
		
		        local DragHitbox = New("TextButton", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 20),
		            Text = "",
		            LayoutOrder = 0,
		            Parent = ColorWindow,
		        })
		        
		        local DragPill = New("Frame", {
		            BackgroundColor3 = "OutlineColor",
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            Position = UDim2.fromScale(0.5, 0.5),
		            Size = UDim2.fromOffset(40, 5),
		            Parent = DragHitbox,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = DragPill })
		        
		        local UserInputService = game:GetService("UserInputService")
		        local dragging = false
		        local dragInput, dragStart, startPos
		
		        DragHitbox.InputBegan:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		                dragging = true
		                dragStart = input.Position
		                startPos = ColorWindow.Position
		                
		                input.Changed:Connect(function()
		                    if input.UserInputState == Enum.UserInputState.End then
		                        dragging = false
		                    end
		                end)
		            end
		        end)
		
		        DragHitbox.InputChanged:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		                dragInput = input
		            end
		        end)
		
		        UserInputService.InputChanged:Connect(function(input)
		            if input == dragInput and dragging then
		                local delta = input.Position - dragStart
		                ColorWindow.Position = UDim2.new(
		                    startPos.X.Scale, startPos.X.Offset + delta.X,
		                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
		                )
		            end
		        end)
		
		        if typeof(ColorPicker.Title) == "string" then
		            New("TextLabel", {
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, 0, 0, 14),
		                Text = ColorPicker.Title,
		                TextSize = 13,
		                TextColor3 = "FontColor",
		                TextXAlignment = Enum.TextXAlignment.Left,
		                LayoutOrder = 1,
		                Parent = ColorWindow,
		            })
		        end
		
		        local ColorHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 130),
		            LayoutOrder = 2,
		            Parent = ColorWindow,
		        })
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Center,
		            Padding = UDim.new(0, 6),
		            Parent = ColorHolder,
		        })
		
		        local SatVipMap = New("ImageButton", {
		            BackgroundColor3 = ColorPicker.Value,
		            Image = CustomImageManager.GetAsset("SaturationMap"),
		            Size = UDim2.new(1, ColorPicker.HasTransparency and -36 or -18, 1, 0), 
		            AutoButtonColor = false,
		            Parent = ColorHolder,
		        })
		        local SatVibCursor = New("Frame", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundColor3 = "WhiteColor",
		            Size = UDim2.fromOffset(6, 6),
		            Parent = SatVipMap,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = SatVibCursor })
		        New("UIStroke", { Color = "DarkColor", Parent = SatVibCursor })
		
		        local HueSelector = New("TextButton", {
		            Size = UDim2.new(0, 12, 1, 0),
		            Text = "",
		            AutoButtonColor = false,
		            Parent = ColorHolder,
		        })
		        New("UIGradient", {
		            Color = ColorSequence.new(HueSequenceTable),
		            Rotation = 90,
		            Parent = HueSelector,
		        })
		        local HueCursor = New("Frame", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundColor3 = "WhiteColor",
		            BorderColor3 = "DarkColor",
		            BorderSizePixel = 1,
		            Position = UDim2.fromScale(0.5, ColorPicker.Hue),
		            Size = UDim2.new(1, 2, 0, 1),
		            Parent = HueSelector,
		        })
		
		        local TransparencySelector, TransparencyColor, TransparencyCursor
		        if ColorPicker.HasTransparency then
		            TransparencySelector = New("ImageButton", {
		                Image = CustomImageManager.GetAsset("TransparencyTexture"),
		                ScaleType = Enum.ScaleType.Tile,
		                Size = UDim2.new(0, 12, 1, 0),
		                TileSize = UDim2.fromOffset(8, 8),
		                AutoButtonColor = false,
		                Parent = ColorHolder,
		            })
		            TransparencyColor = New("Frame", {
		                BackgroundColor3 = ColorPicker.Value,
		                Size = UDim2.fromScale(1, 1),
		                Parent = TransparencySelector,
		            })
		            New("UIGradient", {
		                Rotation = 90,
		                Transparency = NumberSequence.new({
		                    NumberSequenceKeypoint.new(0, 0),
		                    NumberSequenceKeypoint.new(1, 1),
		                }),
		                Parent = TransparencyColor,
		            })
		            TransparencyCursor = New("Frame", {
		                AnchorPoint = Vector2.new(0.5, 0.5),
		                BackgroundColor3 = "WhiteColor",
		                BorderColor3 = "DarkColor",
		                BorderSizePixel = 1,
		                Position = UDim2.fromScale(0.5, ColorPicker.Transparency),
		                Size = UDim2.new(1, 2, 0, 1),
		                Parent = TransparencySelector,
		            })
		        end
		
		        local InfoHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 22),
		            LayoutOrder = 3,
		            Parent = ColorWindow,
		        })
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Center, 
		            Padding = UDim.new(0, 6),
		            Parent = InfoHolder,
		        })
		
		        local HueBox = New("TextBox", {
		            BackgroundColor3 = "MainColor",
		            ClearTextOnFocus = false,
		            Size = UDim2.new(0.38, 0, 1, 0), 
		            Text = "#??????",
		            TextSize = 12,
		            TextColor3 = "FontColor",
		            Parent = InfoHolder,
		        })
		        New("UIStroke", { Color = "OutlineColor", Parent = HueBox })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = HueBox }))
		
		        local RgbBox = New("TextBox", {
		            BackgroundColor3 = "MainColor",
		            ClearTextOnFocus = false,
		            Size = UDim2.new(0.62, -6, 1, 0),
		            Text = "?, ?, ?",
		            TextSize = 12,
		            TextColor3 = "FontColor",
		            Parent = InfoHolder,
		        })
		        New("UIStroke", { Color = "OutlineColor", Parent = RgbBox })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = RgbBox }))
		
		        local ContextMenu = Library:AddContextMenu(Holder, UDim2.fromOffset(93, 0), function()
		            return { Holder.AbsoluteSize.X + 1.5, 0.5 }
		        end, 1)
		        ColorPicker.ContextMenu = ContextMenu
		        ContextMenu.List.Padding = UDim.new(0, 6)
		        do
		            local function CreateButton(Text, Func)
		                local Button = New("TextButton", {
		                    BackgroundTransparency = 1,
		                    Size = UDim2.new(1, 0, 0, 21),
		                    Text = Text,
		                    TextSize = 13,
		                    TextColor3 = "FontColor",
		                    Parent = ContextMenu.Menu,
		                })
		                Button.MouseButton1Click:Connect(function()
		                    Library:SafeCallback(Func)
		                    ContextMenu:Close()
		                end)
		            end
		
		            CreateButton("Copy color", function()
		                Library.CopiedColor = { ColorPicker.Value, ColorPicker.Transparency }
		            end)
		
		            ColorPicker.SetValueRGB = function(...) end 
		            CreateButton("Paste color", function()
		                if Library.CopiedColor then
		                    ColorPicker:SetValueRGB(Library.CopiedColor[1], Library.CopiedColor[2])
		                end
		            end)
		
		            if setclipboard then
		                CreateButton("Copy Hex", function()
		                    setclipboard(tostring(ColorPicker.Value:ToHex()))
		                end)
		                CreateButton("Copy RGB", function()
		                    setclipboard(table.concat({
		                        math.floor(ColorPicker.Value.R * 255),
		                        math.floor(ColorPicker.Value.G * 255),
		                        math.floor(ColorPicker.Value.B * 255),
		                    }, ", "))
		                end)
		            end
		        end
		
		        function ColorPicker:SetHSVFromRGB(Color)
		            ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color:ToHSV()
		        end
		
		        function ColorPicker:Display()
		            if Library.Unloaded then return end
		
		            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib)
		
		            Holder.BackgroundColor3 = ColorPicker.Value
		            HolderStroke.Color = Library:GetDarkerColor(ColorPicker.Value)
		            HolderTransparency.ImageTransparency = (1 - ColorPicker.Transparency)
		
		            SatVipMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1)
		            if TransparencyColor then
		                TransparencyColor.BackgroundColor3 = ColorPicker.Value
		            end
		
		            SatVibCursor.Position = UDim2.fromScale(ColorPicker.Sat, 1 - ColorPicker.Vib)
		            HueCursor.Position = UDim2.fromScale(0.5, ColorPicker.Hue)
		            if TransparencyCursor then
		                TransparencyCursor.Position = UDim2.fromScale(0.5, ColorPicker.Transparency)
		            end
		
		            HueBox.Text = "#" .. ColorPicker.Value:ToHex()
		            RgbBox.Text = table.concat({
		                math.floor(ColorPicker.Value.R * 255),
		                math.floor(ColorPicker.Value.G * 255),
		                math.floor(ColorPicker.Value.B * 255),
		            }, ", ")
		        end
		
		        function ColorPicker:Update()
		            ColorPicker:Display()
		            Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value)
		            Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value)
		        end
		
		        function ColorPicker:OnChanged(Func)
		            ColorPicker.Changed = Func
		        end
		
		        function ColorPicker:SetValue(HSV, Transparency)
		            if typeof(HSV) == "Color3" then
		                ColorPicker:SetValueRGB(HSV, Transparency)
		                return
		            end
		            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])
		            ColorPicker.Transparency = ColorPicker.HasTransparency and Transparency or 0
		            ColorPicker:SetHSVFromRGB(Color)
		            ColorPicker:Update()
		        end
		
		        function ColorPicker:SetValueRGB(Color, Transparency)
		            ColorPicker.Transparency = ColorPicker.HasTransparency and Transparency or 0
		            ColorPicker:SetHSVFromRGB(Color)
		            ColorPicker:Update()
		        end
		
		        Holder.MouseButton1Click:Connect(function()
		            local targetState = not ColorWindow.Visible
		            
		            if targetState then
		                for _, option in pairs(Options) do
		                    if option.Type == "ColorPicker" and option.ColorMenu and option.ColorMenu.Close then
		                        option.ColorMenu.Close()
		                    end
		                end
		            end
		            
		            ColorWindow.Visible = targetState
		        end)
		        Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input: InputObject)
		            if Library.Unloaded or not ColorWindow.Visible then
		                return
		            end
		
		            if IsClickInput(Input, true) then
		                local Location = Input.Position
		                if not (Library:MouseIsOverFrame(ColorWindow, Location) or Library:MouseIsOverFrame(Holder, Location)) then
		                    ColorWindow.Visible = false
		                end
		            end
		        end))
		        
		        Holder.MouseButton2Click:Connect(ContextMenu.Toggle)
		
		        SatVipMap.InputBegan:Connect(function(Input)
		            while IsDragInput(Input) do
		                local MinX = SatVipMap.AbsolutePosition.X
		                local MaxX = MinX + SatVipMap.AbsoluteSize.X
		                local LocationX = math.clamp(Mouse.X, MinX, MaxX)
		
		                local MinY = SatVipMap.AbsolutePosition.Y
		                local MaxY = MinY + SatVipMap.AbsoluteSize.Y
		                local LocationY = math.clamp(Mouse.Y, MinY, MaxY)
		
		                local OldSat = ColorPicker.Sat
		                local OldVib = ColorPicker.Vib
		                ColorPicker.Sat = (LocationX - MinX) / (MaxX - MinX)
		                ColorPicker.Vib = 1 - ((LocationY - MinY) / (MaxY - MinY))
		
		                if ColorPicker.Sat ~= OldSat or ColorPicker.Vib ~= OldVib then
		                    ColorPicker:Update()
		                end
		                RunService.RenderStepped:Wait()
		            end
		        end)
		
		        HueSelector.InputBegan:Connect(function(Input)
		            while IsDragInput(Input) do
		                local Min = HueSelector.AbsolutePosition.Y
		                local Max = Min + HueSelector.AbsoluteSize.Y
		                local Location = math.clamp(Mouse.Y, Min, Max)
		
		                local OldHue = ColorPicker.Hue
		                ColorPicker.Hue = (Location - Min) / (Max - Min)
		
		                if ColorPicker.Hue ~= OldHue then
		                    ColorPicker:Update()
		                end
		                RunService.RenderStepped:Wait()
		            end
		        end)
		
		        if TransparencySelector then
		            TransparencySelector.InputBegan:Connect(function(Input)
		                while IsDragInput(Input) do
		                    local Min = TransparencySelector.AbsolutePosition.Y
		                    local Max = TransparencySelector.AbsolutePosition.Y + TransparencySelector.AbsoluteSize.Y
		                    local Location = math.clamp(Mouse.Y, Min, Max)
		
		                    local OldTransparency = ColorPicker.Transparency
		                    ColorPicker.Transparency = (Location - Min) / (Max - Min)
		
		                    if ColorPicker.Transparency ~= OldTransparency then
		                        ColorPicker:Update()
		                    end
		                    RunService.RenderStepped:Wait()
		                end
		            end)
		        end
		
		        HueBox.FocusLost:Connect(function(Enter)
		            if not Enter then return end
		            local Success, Color = pcall(Color3.fromHex, HueBox.Text)
		            if Success and typeof(Color) == "Color3" then
		                ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color:ToHSV()
		            end
		            ColorPicker:Update()
		        end)
		
		        RgbBox.FocusLost:Connect(function(Enter)
		            if not Enter then return end
		            local R, G, B = RgbBox.Text:match("(%d+),%s*(%d+),%s*(%d+)")
		            if R and G and B then
		                ColorPicker:SetHSVFromRGB(Color3.fromRGB(R, G, B))
		            end
		            ColorPicker:Update()
		        end)
		
		        ColorPicker:Display()
		
		        if ParentObj.Addons then
		            table.insert(ParentObj.Addons, ColorPicker)
		        end
		        ColorPicker.Default = ColorPicker.Value
		        Options[Idx] = ColorPicker
		        
		        ColorPicker.ColorMenu = { Close = function() ColorWindow.Visible = false end } 
		
		        return self
		    end
		
		    BaseAddons.__index = Funcs
		    BaseAddons.__namecall = function(_, Key, ...)
		        return Funcs[Key](...)
		    end
		end
		
		local BaseGroupbox = {}
		do
		    local Funcs = {}
		
		    function Funcs:AddDivider(...)
		        local Params = select(1, ...)
		        local Text
		        local MarginTop = 0
		        local MarginBottom = 0
		
		        if typeof(Params) == "table" then
		            Text = Params.Text
		            MarginTop = Params.MarginTop or Params.Margin or 0
		            MarginBottom = Params.MarginBottom or Params.Margin or 0
		        elseif typeof(Params) == "string" then
		            Text = Params
		        end
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 6 + MarginTop + MarginBottom),
		            Parent = Container,
		        })
		
		        local InnerHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 1, 0),
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingTop = UDim.new(0, MarginTop),
		            PaddingBottom = UDim.new(0, MarginBottom),
		            Parent = Holder,
		        })
		
		        if Text then
		            local TextLabel = New("TextLabel", {
		                AutomaticSize = Enum.AutomaticSize.X,
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 0),
		                Text = Text,
		                TextSize = 14,
		                TextTransparency = 0.5,
		                TextXAlignment = Enum.TextXAlignment.Center,
		                Parent = InnerHolder,
		            })
		
		            local X, _ = Library:GetTextBounds(Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
		            local SizeX = X // 2 + 10
		
		            New("Frame", {
		                AnchorPoint = Vector2.new(0, 0.5),
		                BackgroundColor3 = "MainColor",
		                BorderColor3 = "OutlineColor",
		                BorderSizePixel = 1,
		                Position = UDim2.fromScale(0, 0.5),
		                Size = UDim2.new(0.5, -SizeX, 0, 2),
		                Parent = InnerHolder,
		            })
		            New("Frame", {
		                AnchorPoint = Vector2.new(1, 0.5),
		                BackgroundColor3 = "MainColor",
		                BorderColor3 = "OutlineColor",
		                BorderSizePixel = 1,
		                Position = UDim2.fromScale(1, 0.5),
		                Size = UDim2.new(0.5, -SizeX, 0, 2),
		                Parent = InnerHolder,
		            })
		        else
		            New("Frame", {
		                AnchorPoint = Vector2.new(0, 0.5),
		                BackgroundColor3 = "MainColor",
		                BorderColor3 = "OutlineColor",
		                BorderSizePixel = 1,
		                Position = UDim2.fromScale(0, 0.5),
		                Size = UDim2.new(1, 0, 0, 2),
		                Parent = InnerHolder,
		            })
		        end
		
		        Groupbox:Resize()
		
		        local Divider = {
		            Holder = Holder,
		            Text = Text,
		            MarginTop = MarginTop,
		            MarginBottom = MarginBottom,
		            Type = "Divider",
		        }
		
		        table.insert(Groupbox.Elements, Divider)
		        return Divider
		    end
		
		    function Funcs:AddLabel(...)
		        local Data = {}
		        local Addons = {}
		
		        local First = select(1, ...)
		        local Second = select(2, ...)
		
		        if typeof(First) == "table" or typeof(Second) == "table" then
		            local Params = typeof(First) == "table" and First or Second
		
		            Data.Text = Params.Text or ""
		            Data.DoesWrap = Params.DoesWrap or false
		            Data.Size = Params.Size or 14
		            Data.Visible = Params.Visible or true
		            Data.Idx = typeof(Second) == "table" and First or nil
		        else
		            Data.Text = First or ""
		            Data.DoesWrap = Second or false
		            Data.Size = 14
		            Data.Visible = true
		            Data.Idx = select(3, ...) or nil
		        end
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Label = {
		            Text = Data.Text,
		            DoesWrap = Data.DoesWrap,
		
		            Addons = Addons,
		
		            Visible = Data.Visible,
		            Type = "Label",
		        }
		
		        local TextLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 18),
		            Text = Label.Text,
		            TextSize = Data.Size,
		            TextWrapped = Label.DoesWrap,
		            TextXAlignment = Groupbox.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
		            Parent = Container,
		        })
		
		        function Label:SetVisible(Visible: boolean)
		            Label.Visible = Visible
		
		            TextLabel.Visible = Label.Visible
		            Groupbox:Resize()
		        end
		
		        function Label:SetText(Text: string)
		            Label.Text = Text
		            TextLabel.Text = Text
		
		            if Label.DoesWrap then
		                local _, Y =
		                    Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
		                TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
		            end
		
		            Groupbox:Resize()
		        end
		
		        if Label.DoesWrap then
		            local _, Y =
		                Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
		            TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
		
		            local Last = TextLabel.AbsoluteSize
		            TextLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		                if TextLabel.AbsoluteSize == Last then
		                    return
		                end
		
		                local _, Y =
		                    Library:GetTextBounds(Label.Text, TextLabel.FontFace, TextLabel.TextSize, TextLabel.AbsoluteSize.X)
		                TextLabel.Size = UDim2.new(1, 0, 0, Y + 4)
		
		                Last = TextLabel.AbsoluteSize
		                Groupbox:Resize()
		            end)
		        else
		            New("UIListLayout", {
		                FillDirection = Enum.FillDirection.Horizontal,
		                HorizontalAlignment = Enum.HorizontalAlignment.Right,
		                Padding = UDim.new(0, 6),
		                Parent = TextLabel,
		            })
		        end
		
		        Groupbox:Resize()
		
		        Label.TextLabel = TextLabel
		        Label.Container = Container
		        if not Data.DoesWrap then
		            setmetatable(Label, BaseAddons)
		        end
		
		        Label.Holder = TextLabel
		        table.insert(Groupbox.Elements, Label)
		
		        if Data.Idx then
		            Labels[Data.Idx] = Label
		        else
		            table.insert(Labels, Label)
		        end
		
		        return Label
		    end
		
		    function Funcs:AddButton(...)
		        local function GetInfo(...)
		            local Info = {}
		
		            local First = select(1, ...)
		            local Second = select(2, ...)
		
		            if typeof(First) == "table" or typeof(Second) == "table" then
		                local Params = typeof(First) == "table" and First or Second
		
		                Info.Text = Params.Text or ""
		                Info.Func = Params.Func or Params.Callback or function() end
		                Info.DoubleClick = Params.DoubleClick
		
		                Info.Tooltip = Params.Tooltip
		                Info.DisabledTooltip = Params.DisabledTooltip
		
		                Info.Risky = Params.Risky or false
		                Info.Disabled = Params.Disabled or false
		                Info.Visible = Params.Visible or true
		                Info.Idx = typeof(Second) == "table" and First or nil
		            else
		                Info.Text = First or ""
		                Info.Func = Second or function() end
		                Info.DoubleClick = false
		
		                Info.Tooltip = nil
		                Info.DisabledTooltip = nil
		
		                Info.Risky = false
		                Info.Disabled = false
		                Info.Visible = true
		                Info.Idx = select(3, ...) or nil
		            end
		
		            return Info
		        end
		        local Info = GetInfo(...)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Button = {
		            Text = Info.Text,
		            Func = Info.Func,
		            DoubleClick = Info.DoubleClick,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Risky = Info.Risky,
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		
		            Tween = nil,
		            Type = "Button",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 21),
		            Parent = Container,
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalFlex = Enum.UIFlexAlignment.Fill,
		            Padding = UDim.new(0, 9),
		            Parent = Holder,
		        })
		
		        local function CreateButton(Button)
		            local Base = New("TextButton", {
		                Active = not Button.Disabled,
		                BackgroundColor3 = Button.Disabled and "BackgroundColor" or "MainColor",
		                Size = UDim2.fromScale(1, 1),
		                Text = Button.Text,
		                TextSize = 14,
		                TextTransparency = 0.4,
		                Visible = Button.Visible,
		                Parent = Holder,
		            })
		
		            local Stroke = New("UIStroke", {
		                Color = "OutlineColor",
		                Transparency = Button.Disabled and 0.5 or 0,
		                Parent = Base,
		            })
		
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                    Parent = Base,
		                })
		            )
		
		            return Base, Stroke
		        end
		
		        local function InitEvents(Button)
		            Button.Base.MouseEnter:Connect(function()
		                if Button.Disabled then
		                    return
		                end
		
		                Button.Tween = TweenService:Create(Button.Base, Library.TweenInfo, {
		                    TextTransparency = 0,
		                })
		                Button.Tween:Play()
		            end)
		            Button.Base.MouseLeave:Connect(function()
		                if Button.Disabled then
		                    return
		                end
		
		                Button.Tween = TweenService:Create(Button.Base, Library.TweenInfo, {
		                    TextTransparency = 0.4,
		                })
		                Button.Tween:Play()
		            end)
		
		            Button.Base.MouseButton1Click:Connect(function()
		                if Button.Disabled or Button.Locked then
		                    return
		                end
		
		                if Button.DoubleClick then
		                    Button.Locked = true
		
		                    Button.Base.Text = "Are you sure?"
		                    Button.Base.TextColor3 = Library.Scheme.AccentColor
		                    Library.Registry[Button.Base].TextColor3 = "AccentColor"
		
		                    local Clicked = WaitForEvent(Button.Base.MouseButton1Click, 0.5)
		
		                    Button.Base.Text = Button.Text
		                    Button.Base.TextColor3 = Button.Risky and Library.Scheme.RedColor or Library.Scheme.FontColor
		                    Library.Registry[Button.Base].TextColor3 = Button.Risky and "RedColor" or "FontColor"
		
		                    if Clicked then
		                        Library:SafeCallback(Button.Func)
		                    end
		
		                    RunService.RenderStepped:Wait()
		                    Button.Locked = false
		                    return
		                end
		
		                Library:SafeCallback(Button.Func)
		            end)
		        end
		
		        Button.Base, Button.Stroke = CreateButton(Button)
		        InitEvents(Button)
		
		        function Button:AddButton(...)
		            local Info = GetInfo(...)
		
		            local SubButton = {
		                Text = Info.Text,
		                Func = Info.Func,
		                DoubleClick = Info.DoubleClick,
		
		                Tooltip = Info.Tooltip,
		                DisabledTooltip = Info.DisabledTooltip,
		                TooltipTable = nil,
		
		                Risky = Info.Risky,
		                Disabled = Info.Disabled,
		                Visible = Info.Visible,
		
		                Tween = nil,
		                Type = "SubButton",
		            }
		
		            Button.SubButton = SubButton
		            SubButton.Base, SubButton.Stroke = CreateButton(SubButton)
		            InitEvents(SubButton)
		
		            function SubButton:UpdateColors()
		                if Library.Unloaded then
		                    return
		                end
		
		                StopTween(SubButton.Tween)
		
		                SubButton.Base.BackgroundColor3 = SubButton.Disabled and Library.Scheme.BackgroundColor
		                    or Library.Scheme.MainColor
		                SubButton.Base.TextTransparency = SubButton.Disabled and 0.8 or 0.4
		                SubButton.Stroke.Transparency = SubButton.Disabled and 0.5 or 0
		
		                Library.Registry[SubButton.Base].BackgroundColor3 = SubButton.Disabled and "BackgroundColor"
		                    or "MainColor"
		            end
		
		            function SubButton:SetDisabled(Disabled: boolean)
		                SubButton.Disabled = Disabled
		
		                if SubButton.TooltipTable then
		                    SubButton.TooltipTable.Disabled = SubButton.Disabled
		                end
		
		                SubButton.Base.Active = not SubButton.Disabled
		                SubButton:UpdateColors()
		            end
		
		            function SubButton:SetVisible(Visible: boolean)
		                SubButton.Visible = Visible
		
		                SubButton.Base.Visible = SubButton.Visible
		                Groupbox:Resize()
		            end
		
		            function SubButton:SetText(Text: string)
		                SubButton.Text = Text
		                SubButton.Base.Text = Text
		            end
		
		            if typeof(SubButton.Tooltip) == "string" or typeof(SubButton.DisabledTooltip) == "string" then
		                SubButton.TooltipTable =
		                    Library:AddTooltip(SubButton.Tooltip, SubButton.DisabledTooltip, SubButton.Base)
		                SubButton.TooltipTable.Disabled = SubButton.Disabled
		            end
		
		            if SubButton.Risky then
		                SubButton.Base.TextColor3 = Library.Scheme.RedColor
		                Library.Registry[SubButton.Base].TextColor3 = "RedColor"
		            end
		
		            SubButton:UpdateColors()
		
		            if Info.Idx then
		                Buttons[Info.Idx] = SubButton
		            else
		                table.insert(Buttons, SubButton)
		            end
		
		            return SubButton
		        end
		
		        function Button:UpdateColors()
		            if Library.Unloaded then
		                return
		            end
		
		            StopTween(Button.Tween)
		
		            Button.Base.BackgroundColor3 = Button.Disabled and Library.Scheme.BackgroundColor
		                or Library.Scheme.MainColor
		            Button.Base.TextTransparency = Button.Disabled and 0.8 or 0.4
		            Button.Stroke.Transparency = Button.Disabled and 0.5 or 0
		
		            Library.Registry[Button.Base].BackgroundColor3 = Button.Disabled and "BackgroundColor" or "MainColor"
		        end
		
		        function Button:SetDisabled(Disabled: boolean)
		            Button.Disabled = Disabled
		
		            if Button.TooltipTable then
		                Button.TooltipTable.Disabled = Button.Disabled
		            end
		
		            Button.Base.Active = not Button.Disabled
		            Button:UpdateColors()
		        end
		
		        function Button:SetVisible(Visible: boolean)
		            Button.Visible = Visible
		
		            Holder.Visible = Button.Visible
		            Groupbox:Resize()
		        end
		
		        function Button:SetText(Text: string)
		            Button.Text = Text
		            Button.Base.Text = Text
		        end
		
		        if typeof(Button.Tooltip) == "string" or typeof(Button.DisabledTooltip) == "string" then
		            Button.TooltipTable = Library:AddTooltip(Button.Tooltip, Button.DisabledTooltip, Button.Base)
		            Button.TooltipTable.Disabled = Button.Disabled
		        end
		
		        if Button.Risky then
		            Button.Base.TextColor3 = Library.Scheme.RedColor
		            Library.Registry[Button.Base].TextColor3 = "RedColor"
		        end
		
		        Button:UpdateColors()
		        Groupbox:Resize()
		
		        Button.Holder = Holder
		        table.insert(Groupbox.Elements, Button)
		
		        if Info.Idx then
		            Buttons[Info.Idx] = Button
		        else
		            table.insert(Buttons, Button)
		        end
		
		        return Button
		    end
		
		    function Funcs:AddCheckbox(Idx, Info)
		        Info = Library:Validate(Info, Templates.Toggle)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Toggle = {
		            Text = Info.Text,
		            Value = Info.Default,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		
		            Risky = Info.Risky,
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		            Addons = {},
		
		            Variant = "Checkbox",
		            Type = "Toggle",
		        }
		
		        local Button = New("TextButton", {
		            Active = not Toggle.Disabled,
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 18),
		            Text = "",
		            Visible = Toggle.Visible,
		            Parent = Container,
		        })
		
		        local Label = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Position = UDim2.fromOffset(26, 0),
		            Size = UDim2.new(1, -26, 1, 0),
		            Text = Toggle.Text,
		            TextSize = 14,
		            TextTransparency = 0.4,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = Button,
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Right,
		            Padding = UDim.new(0, 6),
		            Parent = Label,
		        })
		
		        local Checkbox = New("Frame", {
		            BackgroundColor3 = "MainColor",
		            Size = UDim2.fromScale(1, 1),
		            SizeConstraint = Enum.SizeConstraint.RelativeYY,
		            Parent = Button,
		        })
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                Parent = Checkbox,
		            })
		        )
		
		        local CheckboxStroke = New("UIStroke", {
		            Color = "OutlineColor",
		            Parent = Checkbox,
		        })
		
		        local CheckImage = New("ImageLabel", {
		            Image = CheckIcon and CheckIcon.Url or "",
		            ImageColor3 = "FontColor",
		            ImageRectOffset = CheckIcon and CheckIcon.ImageRectOffset or Vector2.zero,
		            ImageRectSize = CheckIcon and CheckIcon.ImageRectSize or Vector2.zero,
		            ImageTransparency = 1,
		            Position = UDim2.fromOffset(2, 2),
		            Size = UDim2.new(1, -4, 1, -4),
		            Parent = Checkbox,
		        })
		
		        function Toggle:UpdateColors()
		            Toggle:Display()
		        end
		
		        function Toggle:Display()
		            if Library.Unloaded then
		                return
		            end
		
		            CheckboxStroke.Transparency = Toggle.Disabled and 0.5 or 0
		
		            if Toggle.Disabled then
		                Label.TextTransparency = 0.8
		                CheckImage.ImageTransparency = Toggle.Value and 0.8 or 1
		
		                Checkbox.BackgroundColor3 = Library.Scheme.BackgroundColor
		                Library.Registry[Checkbox].BackgroundColor3 = "BackgroundColor"
		
		                return
		            end
		
		            TweenService:Create(Label, Library.TweenInfo, {
		                TextTransparency = Toggle.Value and 0 or 0.4,
		            }):Play()
		            TweenService:Create(CheckImage, Library.TweenInfo, {
		                ImageTransparency = Toggle.Value and 0 or 1,
		            }):Play()
		
		            Checkbox.BackgroundColor3 = Library.Scheme.MainColor
		            Library.Registry[Checkbox].BackgroundColor3 = "MainColor"
		        end
		
		        function Toggle:OnChanged(Func)
		            Toggle.Changed = Func
		        end
		
		        function Toggle:SetValue(Value)
		            if Toggle.Disabled then
		                return
		            end
		
		            Toggle.Value = Value
		            Toggle:Display()
		
		            for _, Addon in Toggle.Addons do
		                if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
		                    Addon.Toggled = Toggle.Value
		                    Addon:Update()
		                end
		            end
		
		            Library:UpdateDependencyBoxes()
		            Library:SafeCallback(Toggle.Callback, Toggle.Value)
		            Library:SafeCallback(Toggle.Changed, Toggle.Value)
		        end
		
		        function Toggle:SetDisabled(Disabled: boolean)
		            Toggle.Disabled = Disabled
		
		            if Toggle.TooltipTable then
		                Toggle.TooltipTable.Disabled = Toggle.Disabled
		            end
		
		            for _, Addon in Toggle.Addons do
		                if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
		                    Addon:Update()
		                end
		            end
		
		            Button.Active = not Toggle.Disabled
		            Toggle:Display()
		        end
		
		        function Toggle:SetVisible(Visible: boolean)
		            Toggle.Visible = Visible
		
		            Button.Visible = Toggle.Visible
		            Groupbox:Resize()
		        end
		
		        function Toggle:SetText(Text: string)
		            Toggle.Text = Text
		            Label.Text = Text
		        end
		
		        Button.MouseButton1Click:Connect(function()
		            if Toggle.Disabled then
		                return
		            end
		
		            Toggle:SetValue(not Toggle.Value)
		        end)
		
		        if typeof(Toggle.Tooltip) == "string" or typeof(Toggle.DisabledTooltip) == "string" then
		            Toggle.TooltipTable = Library:AddTooltip(Toggle.Tooltip, Toggle.DisabledTooltip, Button)
		            Toggle.TooltipTable.Disabled = Toggle.Disabled
		        end
		
		        if Toggle.Risky then
		            Label.TextColor3 = Library.Scheme.RedColor
		            Library.Registry[Label].TextColor3 = "RedColor"
		        end
		
		        Toggle:Display()
		        Groupbox:Resize()
		
		        Toggle.TextLabel = Label
		        Toggle.Container = Container
		        setmetatable(Toggle, BaseAddons)
		
		        Toggle.Holder = Button
		        table.insert(Groupbox.Elements, Toggle)
		
		        Toggle.Default = Toggle.Value
		
		        Toggles[Idx] = Toggle
		
		        return Toggle
		    end
		
		    function Funcs:AddToggle(Idx, Info)
		        if Library.ForceCheckbox then
		            return Funcs.AddCheckbox(self, Idx, Info)
		        end
		
		        Info = Library:Validate(Info, Templates.Toggle)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Toggle = {
		            Text = Info.Text,
		            Value = Info.Default,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		
		            Risky = Info.Risky,
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		            Addons = {},
		
		            Variant = "Switch",
		            Type = "Toggle",
		        }
		
		        local Button = New("TextButton", {
		            Active = not Toggle.Disabled,
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 18),
		            Text = "",
		            Visible = Toggle.Visible,
		            Parent = Container,
		        })
		
		        local Label = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, -40, 1, 0),
		            Text = Toggle.Text,
		            TextSize = 14,
		            TextTransparency = 0.4,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = Button,
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Right,
		            Padding = UDim.new(0, 6),
		            Parent = Label,
		        })
		
		        local Switch = New("Frame", {
		            AnchorPoint = Vector2.new(1, 0.5),
		            BackgroundColor3 = "MainColor",
		            Position = UDim2.new(1, 0, 0.5, 0),
		            Size = UDim2.fromOffset(33, 20),
		            Parent = Button,
		        })
		        New("UICorner", {
		            CornerRadius = UDim.new(1, 0),
		            Parent = Switch,
		        })
		        local SwitchStroke = New("UIStroke", {
		            Color = "OutlineColor",
		            Thickness = 1,
		            Parent = Switch,
		        })
		
		        local CheckIconAsset = Library:GetIcon("badge-check") or {Url = "", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		        local XIconAsset = Library:GetIcon("x") or Library:GetIcon("circle-x") or {Url = "rbxassetid://6031094678", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		
		        local Ball = New("Frame", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundColor3 = "FontColor",
		            Position = UDim2.new(0, 6, 0.5, 0), 
		            Size = UDim2.fromOffset(14, 14),
		            Parent = Switch,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Ball })
		        New("UIStroke", { Color = "OutlineColor", Thickness = 1, Parent = Ball })
		
		        local CheckImage = New("ImageLabel", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundTransparency = 1,
		            Image = CheckIconAsset.Url,
		            ImageColor3 = "BackgroundColor",
		            ImageRectOffset = CheckIconAsset.ImageRectOffset,
		            ImageRectSize = CheckIconAsset.ImageRectSize,
		            ImageTransparency = 1,
		            Position = UDim2.fromScale(0.5, 0.5),
		            Size = UDim2.fromOffset(10, 10),
		            Parent = Ball,
		        })
		
		        local XImage = New("ImageLabel", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundTransparency = 1,
		            Image = XIconAsset.Url,
		            ImageColor3 = "BackgroundColor",
		            ImageRectOffset = XIconAsset.ImageRectOffset,
		            ImageRectSize = XIconAsset.ImageRectSize,
		            ImageTransparency = 0,
		            Position = UDim2.fromScale(0.5, 0.5),
		            Size = UDim2.fromOffset(10, 10),
		            Parent = Ball,
		        })
		
		        function Toggle:UpdateColors()
		            Toggle:Display()
		        end
		
		                function Toggle:Display()
		            if Library.Unloaded then
		                return
		            end
		
		            local State = Toggle.Value
		            local TargetColor = State and Library.Scheme.AccentColor or Library.Scheme.MainColor
		            local StrokeColor = State and Library.Scheme.AccentColor or Library.Scheme.OutlineColor
		            
		            if Toggle.Disabled then
		                Label.TextTransparency = 0.8
		                Switch.BackgroundTransparency = 0.75
		                SwitchStroke.Transparency = 0.75
		                return
		            end
		
		            Switch.BackgroundTransparency = 0
		            SwitchStroke.Transparency = 0
		            
		            TweenService:Create(Switch, Library.TweenInfo, { BackgroundColor3 = TargetColor }):Play()
		            TweenService:Create(SwitchStroke, Library.TweenInfo, { Color = StrokeColor }):Play()
		            
		            TweenService:Create(Label, Library.TweenInfo, {
		                TextTransparency = State and 0 or 0.4,
		            }):Play()
		            
		            local BallPos = State and 1 or 0
		            TweenService:Create(Ball, Library.TweenInfo, {
		                AnchorPoint = Vector2.new(BallPos, 0.5),
		                Position = UDim2.new(BallPos, State and -6 or 6, 0.5, 0),
		            }):Play()
		
		            TweenService:Create(XImage, Library.TweenInfo, {
		                ImageTransparency = State and 1 or 0
		            }):Play()
		
		            TweenService:Create(CheckImage, Library.TweenInfo, {
		                ImageTransparency = State and 0 or 1
		            }):Play()
		
		            Library.Registry[Switch].BackgroundColor3 = State and "AccentColor" or "MainColor"
		            Library.Registry[SwitchStroke].Color = State and "AccentColor" or "OutlineColor"
		        end
		
		        function Toggle:OnChanged(Func)
		            Toggle.Changed = Func
		        end
		
		        function Toggle:SetValue(Value)
		            if Toggle.Disabled then
		                return
		            end
		
		            Toggle.Value = Value
		            Toggle:Display()
		
		            for _, Addon in Toggle.Addons do
		                if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
		                    Addon.Toggled = Toggle.Value
		                    Addon:Update()
		                end
		            end
		
		            Library:UpdateDependencyBoxes()
		            Library:SafeCallback(Toggle.Callback, Toggle.Value)
		            Library:SafeCallback(Toggle.Changed, Toggle.Value)
		        end
		
		        function Toggle:SetDisabled(Disabled: boolean)
		            Toggle.Disabled = Disabled
		
		            if Toggle.TooltipTable then
		                Toggle.TooltipTable.Disabled = Toggle.Disabled
		            end
		
		            for _, Addon in Toggle.Addons do
		                if Addon.Type == "KeyPicker" and Addon.SyncToggleState then
		                    Addon:Update()
		                end
		            end
		
		            Button.Active = not Toggle.Disabled
		            Toggle:Display()
		        end
		
		        function Toggle:SetVisible(Visible: boolean)
		            Toggle.Visible = Visible
		
		            Button.Visible = Toggle.Visible
		            Groupbox:Resize()
		        end
		
		        function Toggle:SetText(Text: string)
		            Toggle.Text = Text
		            Label.Text = Text
		        end
		
		        Button.MouseButton1Click:Connect(function()
		            if Toggle.Disabled then
		                return
		            end
		
		            Toggle:SetValue(not Toggle.Value)
		        end)
		
		        if typeof(Toggle.Tooltip) == "string" or typeof(Toggle.DisabledTooltip) == "string" then
		            Toggle.TooltipTable = Library:AddTooltip(Toggle.Tooltip, Toggle.DisabledTooltip, Button)
		            Toggle.TooltipTable.Disabled = Toggle.Disabled
		        end
		
		        if Toggle.Risky then
		            Label.TextColor3 = Library.Scheme.RedColor
		            Library.Registry[Label].TextColor3 = "RedColor"
		        end
		
		        Toggle:Display()
		        Groupbox:Resize()
		
		        Toggle.TextLabel = Label
		        Toggle.Container = Container
		        setmetatable(Toggle, BaseAddons)
		
		        Toggle.Holder = Button
		        table.insert(Groupbox.Elements, Toggle)
		        if Info.Content then
		            if Library.IsMobile then 
		                local PillType = Info.Switch and "Switch" or "Click"
		                
		                local FloatingButton = Library:AddDraggablePillButton({
		                    Text = Info.Content,
		                    Type = PillType,
		                    Default = Info.Default,
		                    Callback = Info.Callback
		                })
		                
		                local function UpdateMasterContainerVisibility()
		                    if not Library.QuickMenuContainer or not Library.QuickMenuButtons then return end
		                    
		                    local hasVisibleButton = false
		                    for _, child in ipairs(Library.QuickMenuButtons:GetChildren()) do
		                        if child:IsA("TextButton") and child.Visible then
		                            hasVisibleButton = true
		                            break
		                        end
		                    end
		                    
		                    Library.QuickMenuContainer.Visible = hasVisibleButton
		                end
		                
		                Library.ActivePillCount = Library.ActivePillCount or 0
		                local MAX_PILLS = 10
		                
		                if Toggle.Value then
		                    if Library.ActivePillCount < MAX_PILLS then
		                        Library.ActivePillCount = Library.ActivePillCount + 1
		                        FloatingButton:SetVisible(true)
		                    else
		                        Toggle.Value = false
		                        FloatingButton:SetVisible(false)
		                    end
		                else
		                    FloatingButton:SetVisible(false)
		                end
		                
		                UpdateMasterContainerVisibility()
		                
		                Toggle.Callback = function(State)
		                    if State then
		                        if Library.ActivePillCount >= MAX_PILLS then
		                            Library:Notify({
		                                Title = "Warn!",
		                                Description = "Hanya " .. MAX_PILLS .. " tombol melayang yang diizinkan tampil.",
		                                Time = 3
		                            })
		                            
		                            task.spawn(function()
		                                Toggle:SetValue(false)
		                            end)
		                            return
		                        end
		                        
		                        Library.ActivePillCount = Library.ActivePillCount + 1
		                        if FloatingButton then
		                            FloatingButton:SetVisible(true)
		                        end
		                    else
		                        if FloatingButton and FloatingButton.Holder.Visible then
		                            Library.ActivePillCount = math.max(0, Library.ActivePillCount - 1)
		                            FloatingButton:SetVisible(false)
		                        end
		                    end
		                    
		                    UpdateMasterContainerVisibility()
		                end
		            end
		        end
		
		        Toggle.Default = Toggle.Value
		
		        Toggles[Idx] = Toggle
		
		        return Toggle
		    end
		
		    function Funcs:AddInput(Idx, Info)
		        if typeof(Info) == "table" and (typeof(Info.VerifyValue) == "function" and Info.Finished ~= true) then
		            Info.Finished = true
		        end
		
		        Info = Library:Validate(Info, Templates.Input)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Input = {
		            Text = Info.Text,
		            Value = Info.Default,
		
		            Finished = Info.Finished,
		            Numeric = Info.Numeric,
		            ClearTextOnFocus = Info.ClearTextOnFocus,
		            ClearTextOnBlur = Info.ClearTextOnBlur,
		            Placeholder = Info.Placeholder,
		            AllowEmpty = Info.AllowEmpty,
		            EmptyReset = Info.EmptyReset,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		            VerifyValue = Info.VerifyValue,
		
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		
		            Type = "Input",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 39),
		            Visible = Input.Visible,
		            Parent = Container,
		        })
		
		        local Label = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 14),
		            Text = Input.Text,
		            TextSize = 14,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = Holder,
		        })
		
		        local Box = New("TextBox", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            ClearTextOnFocus = not Input.Disabled and Input.ClearTextOnFocus,
		            PlaceholderText = Input.Placeholder,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.new(1, 0, 0, 21),
		            Text = Input.Value,
		            TextEditable = not Input.Disabled,
		            TextScaled = true,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 3),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 4),
		            Parent = Box,
		        })
		
		        New("UIStroke", {
		            Color = "OutlineColor",
		            Parent = Box,
		        })
		
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                Parent = Box,
		            })
		        )
		
		        function Input:UpdateColors()
		            if Library.Unloaded then
		                return
		            end
		
		            Label.TextTransparency = Input.Disabled and 0.8 or 0
		            Box.TextTransparency = Input.Disabled and 0.8 or 0
		        end
		
		        function Input:OnChanged(Func)
		            Input.Changed = Func
		        end
		
		        function Input:SetValue(Text)
		            if not Input.AllowEmpty and Trim(Text) == "" then
		                Text = Input.EmptyReset
		            end
		
		            if Info.MaxLength and #Text > Info.MaxLength then
		                Text = Text:sub(1, Info.MaxLength)
		            end
		
		            if Input.Numeric then
		                if #tostring(Text) > 0 and not tonumber(Text) then
		                    Text = Input.Value
		                end
		            end
		
		            if typeof(Info.VerifyValue) == "function" and (Text ~= Input.EmptyReset and Info.VerifyValue(Text) ~= true) then
		                Text = Input.EmptyReset
		            end
		
		            Input.Value = Text
		            Box.Text = Text
		
		            if not Input.Disabled then
		                Library:SafeCallback(Input.Callback, Input.Value)
		                Library:SafeCallback(Input.Changed, Input.Value)
		            end
		        end
		
		        function Input:SetDisabled(Disabled: boolean)
		            Input.Disabled = Disabled
		
		            if Input.TooltipTable then
		                Input.TooltipTable.Disabled = Input.Disabled
		            end
		
		            Box.ClearTextOnFocus = not Input.Disabled and Input.ClearTextOnFocus
		            Box.TextEditable = not Input.Disabled
		            Input:UpdateColors()
		        end
		
		        function Input:SetVisible(Visible: boolean)
		            Input.Visible = Visible
		
		            Holder.Visible = Input.Visible
		            Groupbox:Resize()
		        end
		
		        function Input:SetText(Text: string)
		            Input.Text = Text
		            Label.Text = Text
		        end
		
		        if Input.Finished then
		            Box.FocusLost:Connect(function(Enter)
		                if not Enter then
		                    if Input.ClearTextOnBlur then
		                        Box.Text = Input.Value
		                    end
		
		                    return
		                end
		
		                Input:SetValue(Box.Text)
		            end)
		        else
		            Box:GetPropertyChangedSignal("Text"):Connect(function()
		                if Box.Text == Input.Value then return end
		                
		                Input:SetValue(Box.Text)
		            end)
		        end
		
		        if typeof(Input.Tooltip) == "string" or typeof(Input.DisabledTooltip) == "string" then
		            Input.TooltipTable = Library:AddTooltip(Input.Tooltip, Input.DisabledTooltip, Box)
		            Input.TooltipTable.Disabled = Input.Disabled
		        end
		
		        Groupbox:Resize()
		
		        Input.Holder = Holder
		        table.insert(Groupbox.Elements, Input)
		
		        Input.Default = Input.Value
		        if typeof(Info.VerifyValue) == "function" and (Input.Default ~= Input.EmptyReset and Info.VerifyValue(Input.Default) ~= true) then
		            Input:SetValue(Input.EmptyReset)
		            Input.Default = Input.EmptyReset
		        end
		        
		        Options[Idx] = Input
		
		        return Input
		    end
		
		        function Funcs:AddSlider(Idx, Info)
		        Info = Library:Validate(Info, Templates.Slider)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Slider = {
		            Text = Info.Text,
		            Value = Info.Default,
		
		            Min = Info.Min,
		            Max = Info.Max,
		
		            Prefix = Info.Prefix,
		            Suffix = Info.Suffix,
		            Compact = Info.Compact,
		            Rounding = Info.Rounding,
		            HideMax = Info.HideMax,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		
		            Type = "Slider",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 36),
		            Visible = Slider.Visible,
		            Parent = Container,
		        })
		
		        local TextRow = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 14),
		            Parent = Holder,
		        })
		
		        local SliderLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(0.5, 0, 1, 0),
		            Position = UDim2.fromScale(0, 0),
		            Text = Slider.Text,
		            TextSize = 13,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = TextRow,
		        })
		
		        local ValueLabel = New("TextBox", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(0.5, 0, 1, 0),
		            Position = UDim2.fromScale(0.5, 0),
		            Text = "",
		            TextSize = 13,
		            TextXAlignment = Enum.TextXAlignment.Right,
		            ClearTextOnFocus = false,
		            Parent = TextRow,
		        })
		
		        ValueLabel.Focused:Connect(function()
		            if Slider.Disabled then
		                ValueLabel:ReleaseFocus()
		                return
		            end
		            ValueLabel.Text = tostring(Slider.Value)
		        end)
		
		        ValueLabel.FocusLost:Connect(function()
		            if Slider.Disabled then return end
		            
		            local ParsedNum = tonumber(ValueLabel.Text)
		            if ParsedNum then
		                Slider:SetValue(ParsedNum)
		            else
		                Slider:Display() 
		            end
		        end)
		
		        local Bar = New("TextButton", {
		            Active = not Slider.Disabled,
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.new(1, 0, 0, 8),
		            Text = "",
		            Parent = Holder,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Bar })
		        New("UIStroke", { Color = "OutlineColor", Parent = Bar })
		
		        local Fill = New("Frame", {
		            BackgroundColor3 = "AccentColor",
		            Size = UDim2.fromScale(0.5, 1),
		            Parent = Bar,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Fill })
		        local FillGradient = New("UIGradient", {
		            Color = ColorSequence.new({
		                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.Scheme.AccentColor)),
		                ColorSequenceKeypoint.new(1, Library.Scheme.AccentColor)
		            }),
		            Parent = Fill
		        })
		        local KnobIcon = Library:GetCustomIcon("diamond") or {Url = "", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		
		        local Knob = New("ImageLabel", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundTransparency = 1, -- Transparan agar latar belakang ikon bersih
		            Image = KnobIcon.Url,
		            ImageColor3 = "FontColor",
		            ImageRectOffset = KnobIcon.ImageRectOffset,
		            ImageRectSize = KnobIcon.ImageRectSize,
		            Position = UDim2.new(1, 0, 0.5, 0),
		            Size = UDim2.fromOffset(20, 20), -- Sesuaikan ukuran ikon
		            Parent = Fill,
		        })
		
		        function Slider:UpdateColors()
		            if Library.Unloaded then
		                return
		            end
		
		            SliderLabel.TextTransparency = Slider.Disabled and 0.8 or 0.4
		            ValueLabel.TextTransparency = Slider.Disabled and 0.8 or 0.4
		
		            Fill.BackgroundColor3 = Slider.Disabled and Library.Scheme.OutlineColor or Library.Scheme.AccentColor
		            Library.Registry[Fill].BackgroundColor3 = Slider.Disabled and "OutlineColor" or "AccentColor"
		
		            Knob.BackgroundColor3 = Slider.Disabled and Library:GetDarkerColor(Library.Scheme.FontColor) or Library.Scheme.FontColor
		            Library.Registry[Knob].BackgroundColor3 = Slider.Disabled and function() return Library:GetDarkerColor(Library.Scheme.FontColor) end or "FontColor"
		        end
		
		        function Slider:Display()
		            if Library.Unloaded then
		                return
		            end
		
		            local CustomDisplayText = nil
		            if Info.FormatDisplayValue then
		                CustomDisplayText = Info.FormatDisplayValue(Slider, Slider.Value)
		            end
		
		            if CustomDisplayText then
		                ValueLabel.Text = tostring(CustomDisplayText)
		            else
		                if Info.HideMax then
		                    ValueLabel.Text = string.format("%s%s%s", Slider.Prefix, Slider.Value, Slider.Suffix)
		                else
		                    ValueLabel.Text = string.format(
		                        "%s%s%s/%s%s%s",
		                        Slider.Prefix,
		                        Slider.Value,
		                        Slider.Suffix,
		                        Slider.Prefix,
		                        Slider.Max,
		                        Slider.Suffix
		                    )
		                end
		            end
		
		            local X = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
		            Fill.Size = UDim2.fromScale(X, 1)
		        end
		
		        function Slider:OnChanged(Func)
		            Slider.Changed = Func
		        end
		
		        function Slider:SetMax(Value)
		            assert(Value > Slider.Min, "Max value cannot be less than the current min value.")
		
		            Slider:SetValue(math.clamp(Slider.Value, Slider.Min, Value))
		            Slider.Max = Value
		            Slider:Display()
		        end
		
		        function Slider:SetMin(Value)
		            assert(Value < Slider.Max, "Min value cannot be greater than the current max value.")
		
		            Slider:SetValue(math.clamp(Slider.Value, Value, Slider.Max))
		            Slider.Min = Value
		            Slider:Display()
		        end
		
		        function Slider:SetValue(Str)
		            if Slider.Disabled then
		                return
		            end
		
		            local Num = tonumber(Str)
		            if not Num or Num == Slider.Value then
		                return
		            end
		
		            Num = math.clamp(Num, Slider.Min, Slider.Max)
		
		            Slider.Value = Num
		            Slider:Display()
		
		            Library:SafeCallback(Slider.Callback, Slider.Value)
		            Library:SafeCallback(Slider.Changed, Slider.Value)
		        end
		
		        function Slider:SetDisabled(Disabled: boolean)
		            Slider.Disabled = Disabled
		
		            if Slider.TooltipTable then
		                Slider.TooltipTable.Disabled = Slider.Disabled
		            end
		
		            Bar.Active = not Slider.Disabled
		            Slider:UpdateColors()
		        end
		
		        function Slider:SetVisible(Visible: boolean)
		            Slider.Visible = Visible
		
		            Holder.Visible = Slider.Visible
		            Groupbox:Resize()
		        end
		
		        function Slider:SetText(Text: string)
		            Slider.Text = Text
		            SliderLabel.Text = Text
		        end
		
		        function Slider:SetPrefix(Prefix: string)
		            Slider.Prefix = Prefix
		            Slider:Display()
		        end
		
		        function Slider:SetSuffix(Suffix: string)
		            Slider.Suffix = Suffix
		            Slider:Display()
		        end
		
		                Bar.InputBegan:Connect(function(Input: InputObject)
		            if not IsClickInput(Input) or Slider.Disabled then
		                return
		            end
		
		            if Library.ActiveTab then
		                for _, Side in Library.ActiveTab.Sides do
		                    Side.ScrollingEnabled = false
		                end
		            end
		
		            if Library.ActiveLoading and Library.ActiveLoading.Sidebar then
		                Library.ActiveLoading.Sidebar.Container.ScrollingEnabled = false
		            end
		
		            TweenService:Create(Knob, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		                Rotation = 45
		            }):Play()
		
		            while IsDragInput(Input) do
		                local Location = Mouse.X
		                local Scale = math.clamp((Location - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
		
		                local OldValue = Slider.Value
		                Slider.Value = Round(Slider.Min + ((Slider.Max - Slider.Min) * Scale), Slider.Rounding)
		
		                Slider:Display()
		                
		                Knob.Rotation = Scale * 900
		
		                if Slider.Value ~= OldValue then
		                    Library:SafeCallback(Slider.Callback, Slider.Value)
		                    Library:SafeCallback(Slider.Changed, Slider.Value)
		                end
		
		                RunService.RenderStepped:Wait()
		            end
		
		            TweenService:Create(Knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		                Rotation = 0
		            }):Play()
		
		            if Library.ActiveTab then
		                for _, Side in Library.ActiveTab.Sides do
		                    Side.ScrollingEnabled = true
		                end
		            end
		
		            if Library.ActiveLoading and Library.ActiveLoading.Sidebar then
		                Library.ActiveLoading.Sidebar.Container.ScrollingEnabled = true
		            end
		        end)
		
		        if typeof(Slider.Tooltip) == "string" or typeof(Slider.DisabledTooltip) == "string" then
		            Slider.TooltipTable = Library:AddTooltip(Slider.Tooltip, Slider.DisabledTooltip, Bar)
		            Slider.TooltipTable.Disabled = Slider.Disabled
		        end
		
		        Slider:UpdateColors()
		        Slider:Display()
		        Groupbox:Resize()
		
		        Slider.Holder = Holder
		        table.insert(Groupbox.Elements, Slider)
		
		        Slider.Default = Slider.Value
		
		        Options[Idx] = Slider
		
		        return Slider
		    end
		
		    function Funcs:AddDropdown(Idx, Info)
		        Info = Library:Validate(Info, Templates.Dropdown)
		
		        -- Tambahkan integrasi ke Mobile Button jika mode = "button"
		        if Info.mode == "button" and Library.IsMobile then
		            local FloatingDropdown = Library:AddDraggablePillButton({
		                Text = Info.Text or "Dropdown",
		                Type = "Dropdown",
		                Values = Info.Values,
		                Default = Info.Default,
		                Callback = Info.Callback
		            })
		            FloatingDropdown:SetVisible(true)
		        end
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        if Info.SpecialType == "Player" then
		            Info.Values = GetPlayers(Info.ExcludeLocalPlayer)
		            Info.AllowNull = true
		        elseif Info.SpecialType == "Team" then
		            Info.Values = GetTeams()
		            Info.AllowNull = true
		        end
		
		        local Dropdown = {
		            Text = typeof(Info.Text) == "string" and Info.Text or nil,
		            Value = Info.Multi and {} or nil,
		            Values = Info.Values,
		            DisabledValues = Info.DisabledValues,
		            Multi = Info.Multi,
		
		            SpecialType = Info.SpecialType,
		            ExcludeLocalPlayer = Info.ExcludeLocalPlayer,
		
		            Tooltip = Info.Tooltip,
		            DisabledTooltip = Info.DisabledTooltip,
		            TooltipTable = nil,
		
		            Callback = Info.Callback,
		            Changed = Info.Changed,
		
		            Disabled = Info.Disabled,
		            Visible = Info.Visible,
		
		            Type = "Dropdown",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, Dropdown.Text and 39 or 21),
		            Visible = Dropdown.Visible,
		            Parent = Container,
		        })
		
		        local Label = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 14),
		            Text = Dropdown.Text,
		            TextSize = 14,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Visible = not not Info.Text,
		            ZIndex = 3,
		            Parent = Holder,
		        })
		
		        local Display = New("TextButton", {
		            Active = not Dropdown.Disabled,
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.new(1, 0, 0, 21),
		            Text = "---",
		            TextSize = 14,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            ZIndex = 2,
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 4),
		            Parent = Display,
		        })
		
		        New("UIStroke", {
		            Color = "OutlineColor",
		            Parent = Display,
		        })
		
		        if Library.CornerRadiusDropdown == true then
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, Library.CornerRadius / 2),
		                    Parent = Display,
		                })
		            )
		        end
		
		        local ArrowImage = New("ImageLabel", {
		            AnchorPoint = Vector2.new(1, 0.5),
		            Image = ArrowIcon and ArrowIcon.Url or "",
		            ImageColor3 = "FontColor",
		            ImageRectOffset = ArrowIcon and ArrowIcon.ImageRectOffset or Vector2.zero,
		            ImageRectSize = ArrowIcon and ArrowIcon.ImageRectSize or Vector2.zero,
		            ImageTransparency = 0.5,
		            Position = UDim2.fromScale(1, 0.5),
		            Size = UDim2.fromOffset(16, 16),
		            Parent = Display,
		        })
		
		        local SearchBox
		        if Info.Searchable then
		            SearchBox = New("TextBox", {
		                BackgroundTransparency = 1,
		                PlaceholderText = "Search...",
		                Position = UDim2.fromOffset(-8, 0),
		                Size = UDim2.new(1, -12, 1, 0),
		                TextSize = 14,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                Visible = false,
		                Parent = Display,
		            })
		            New("UIPadding", {
		                PaddingLeft = UDim.new(0, 8),
		                Parent = SearchBox,
		            })
		        end
		
		        local MenuTable = Library:AddContextMenu(
		            Display,
		            function()
		                return UDim2.fromOffset(Display.AbsoluteSize.X / Library.DPIScale, 0)
		            end,
		            function()
		                return { 0.5, Display.AbsoluteSize.Y + 1.5 }
		            end,
		            2,
		            function(Active: boolean)
		                Display.TextTransparency = (Active and SearchBox) and 1 or 0
		                ArrowImage.ImageTransparency = Active and 0 or 0.5
		                ArrowImage.Rotation = Active and 180 or 0
		                if SearchBox then
		                    SearchBox.Text = ""
		                    SearchBox.Visible = Active
		                end
		            end,
		            true
		        )
		        Dropdown.Menu = MenuTable
		
		        function Dropdown:RecalculateListSize(Count)
		            local Y = math.clamp((Count or GetTableSize(Dropdown.Values)) * 21, 0, Info.MaxVisibleDropdownItems * 21)
		
		            MenuTable:SetSize(function()
		                return UDim2.fromOffset(Display.AbsoluteSize.X / Library.DPIScale, Y)
		            end)
		        end
		
		        function Dropdown:UpdateColors()
		            if Library.Unloaded then
		                return
		            end
		
		            Label.TextTransparency = Dropdown.Disabled and 0.8 or 0
		            Display.TextTransparency = Dropdown.Disabled and 0.8 or 0
		            ArrowImage.ImageTransparency = Dropdown.Disabled and 0.8 or MenuTable.Active and 0 or 0.5
		        end
		
		        function Dropdown:Display()
		            if Library.Unloaded then
		                return
		            end
		
		            local Str = ""
		
		            if Info.Multi then
		                for _, Value in Dropdown.Values do
		                    if Dropdown.Value[Value] then
		                        Str = Str
		                            .. (Info.FormatDisplayValue and tostring(Info.FormatDisplayValue(Value)) or tostring(Value))
		                            .. ", "
		                    end
		                end
		
		                Str = Str:sub(1, #Str - 2)
		            else
		                Str = Dropdown.Value and tostring(Dropdown.Value) or ""
		                if Str ~= "" and Info.FormatDisplayValue then
		                    Str = tostring(Info.FormatDisplayValue(Str))
		                end
		            end
		
		            if #Str > 25 then
		                Str = Str:sub(1, 22) .. "..."
		            end
		
		            Display.Text = (Str == "" and "---" or Str)
		        end
		
		        function Dropdown:OnChanged(Func)
		            Dropdown.Changed = Func
		        end
		
		        function Dropdown:GetActiveValues()
		            if Info.Multi then
		                local Table = {}
		
		                for Value, _ in Dropdown.Value do
		                    table.insert(Table, Value)
		                end
		
		                return Table
		            end
		
		            return Dropdown.Value and 1 or 0
		        end
		
		        local Buttons = {}
		        function Dropdown:BuildDropdownList()
		            local Values = Dropdown.Values
		            local DisabledValues = Dropdown.DisabledValues
		
		            for Button, _ in Buttons do
		                Button:Destroy()
		            end
		            table.clear(Buttons)
		
		            local Count = 0
		            for _, Value in Values do
		                local FormattedValue = tostring(Info.FormatListValue and Info.FormatListValue(Value) or Value)
		                if SearchBox and not FormattedValue:lower():match(SearchBox.Text:lower()) then
		                    continue
		                end
		
		                Count += 1
		
		                local IsDisabled = table.find(DisabledValues, Value)
		                local Table = {}
		
		                local Button = New("TextButton", {
		                    BackgroundColor3 = "MainColor",
		                    BackgroundTransparency = 1,
		                    LayoutOrder = IsDisabled and 1 or 0,
		                    Size = UDim2.new(1, 0, 0, 21),
		                    Text = FormattedValue,
		                    TextSize = 14,
		                    TextTransparency = 0.5,
		                    TextXAlignment = Enum.TextXAlignment.Left,
		                    Parent = MenuTable.Menu,
		                })
		                New("UIPadding", {
		                    PaddingLeft = UDim.new(0, 7),
		                    PaddingRight = UDim.new(0, 7),
		                    Parent = Button,
		                })
		
		                local Selected
		                if Info.Multi then
		                    Selected = Dropdown.Value[Value]
		                else
		                    Selected = Dropdown.Value == Value
		                end
		
		                function Table:UpdateButton()
		                    if Info.Multi then
		                        Selected = Dropdown.Value[Value]
		                    else
		                        Selected = Dropdown.Value == Value
		                    end
		
		                    Button.BackgroundTransparency = Selected and 0 or 1
		                    Button.TextTransparency = IsDisabled and 0.8 or Selected and 0 or 0.5
		                end
		
		                if not IsDisabled then
		                    Button.MouseButton1Click:Connect(function()
		                        local Try = not Selected
		
		                        if not (Dropdown:GetActiveValues() == 1 and not Try and not Info.AllowNull) then
		                            Selected = Try
		                            if Info.Multi then
		                                Dropdown.Value[Value] = Selected and true or nil
		                            else
		                                Dropdown.Value = Selected and Value or nil
		                            end
		
		                            for _, OtherButton in Buttons do
		                                OtherButton:UpdateButton()
		                            end
		                        end
		
		                        Table:UpdateButton()
		                        Dropdown:Display()
		
		                        Library:UpdateDependencyBoxes()
		                        Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
		                        Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		                    end)
		                end
		
		                Table:UpdateButton()
		                Dropdown:Display()
		
		                Buttons[Button] = Table
		            end
		
		            Dropdown:RecalculateListSize(Count)
		        end
		
		        function Dropdown:SetValue(Value)
		            if Info.Multi then
		                local Table = {}
		
		                for Val, Active in Value or {} do
		                    if typeof(Active) ~= "boolean" then
		                        Table[Active] = true
		                    elseif Active and table.find(Dropdown.Values, Val) then
		                        Table[Val] = true
		                    end
		                end
		
		                Dropdown.Value = Table
		            else
		                if table.find(Dropdown.Values, Value) then
		                    Dropdown.Value = Value
		                elseif not Value then
		                    Dropdown.Value = nil
		                end
		            end
		
		            Dropdown:Display()
		            for _, Button in Buttons do
		                Button:UpdateButton()
		            end
		
		            if not Dropdown.Disabled then
		                Library:UpdateDependencyBoxes()
		                Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
		                Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		            end
		        end
		
		        function Dropdown:SetValues(Values)
		            Dropdown.Values = Values
		            Dropdown:BuildDropdownList()
		        end
		
		        function Dropdown:AddValues(Values)
		            if typeof(Values) == "table" then
		                for _, val in Values do
		                    table.insert(Dropdown.Values, val)
		                end
		            elseif typeof(Values) == "string" then
		                table.insert(Dropdown.Values, Values)
		            else
		                return
		            end
		
		            Dropdown:BuildDropdownList()
		        end
		
		        function Dropdown:SetDisabledValues(DisabledValues)
		            Dropdown.DisabledValues = DisabledValues
		            Dropdown:BuildDropdownList()
		        end
		
		        function Dropdown:AddDisabledValues(DisabledValues)
		            if typeof(DisabledValues) == "table" then
		                for _, val in DisabledValues do
		                    table.insert(Dropdown.DisabledValues, val)
		                end
		            elseif typeof(DisabledValues) == "string" then
		                table.insert(Dropdown.DisabledValues, DisabledValues)
		            else
		                return
		            end
		
		            Dropdown:BuildDropdownList()
		        end
		
		        function Dropdown:SetDisabled(Disabled: boolean)
		            Dropdown.Disabled = Disabled
		
		            if Dropdown.TooltipTable then
		                Dropdown.TooltipTable.Disabled = Dropdown.Disabled
		            end
		
		            MenuTable:Close()
		            Display.Active = not Dropdown.Disabled
		            Dropdown:UpdateColors()
		        end
		
		        function Dropdown:SetVisible(Visible: boolean)
		            Dropdown.Visible = Visible
		
		            Holder.Visible = Dropdown.Visible
		            Groupbox:Resize()
		        end
		
		        function Dropdown:SetText(Text: string)
		            Dropdown.Text = Text
		            Holder.Size = UDim2.new(1, 0, 0, Text and 39 or 21)
		
		            Label.Text = Text and Text or ""
		            Label.Visible = not not Text
		        end
		
		        Display.MouseButton1Click:Connect(function()
		            if Dropdown.Disabled then
		                return
		            end
		
		            MenuTable:Toggle()
		        end)
		
		        if SearchBox then
		            SearchBox:GetPropertyChangedSignal("Text"):Connect(Dropdown.BuildDropdownList)
		        end
		
		        local Defaults = {}
		        if typeof(Info.Default) == "string" then
		            local Index = table.find(Dropdown.Values, Info.Default)
		            if Index then
		                table.insert(Defaults, Index)
		            end
		        elseif typeof(Info.Default) == "table" then
		            for _, Value in next, Info.Default do
		                local Index = table.find(Dropdown.Values, Value)
		                if Index then
		                    table.insert(Defaults, Index)
		                end
		            end
		        elseif Dropdown.Values[Info.Default] ~= nil then
		            table.insert(Defaults, Info.Default)
		        end
		
		        if next(Defaults) then
		            for i = 1, #Defaults do
		                local Index = Defaults[i]
		                if Info.Multi then
		                    Dropdown.Value[Dropdown.Values[Index]] = true
		                else
		                    Dropdown.Value = Dropdown.Values[Index]
		                end
		
		                if not Info.Multi then
		                    break
		                end
		            end
		        end
		
		        if typeof(Dropdown.Tooltip) == "string" or typeof(Dropdown.DisabledTooltip) == "string" then
		            Dropdown.TooltipTable = Library:AddTooltip(Dropdown.Tooltip, Dropdown.DisabledTooltip, Display)
		            Dropdown.TooltipTable.Disabled = Dropdown.Disabled
		        end
		
		        Dropdown:UpdateColors()
		        Dropdown:Display()
		        Dropdown:BuildDropdownList()
		        Groupbox:Resize()
		
		        Dropdown.Holder = Holder
		        table.insert(Groupbox.Elements, Dropdown)
		
		        Dropdown.Default = Defaults
		        Dropdown.DefaultValues = Dropdown.Values
		
		        Options[Idx] = Dropdown
		
		        return Dropdown
		    end
		
		    function Funcs:AddViewport(Idx, Info)
		        Info = Library:Validate(Info, Templates.Viewport)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Dragging, Pinching = false, false
		        local LastMousePos, LastPinchDist = nil, 0
		
		        local ViewportObject = Info.Object
		        if Info.Clone and typeof(Info.Object) == "Instance" then
		            if Info.Object.Archivable then
		                ViewportObject = ViewportObject:Clone()
		            else
		                Info.Object.Archivable = true
		                ViewportObject = ViewportObject:Clone()
		                Info.Object.Archivable = false
		            end
		        end
		
		        local Viewport = {
		            Object = ViewportObject,
		            Camera = if not Info.Camera then Instance.new("Camera") else Info.Camera,
		            Interactive = Info.Interactive,
		            AutoFocus = Info.AutoFocus,
		            Visible = Info.Visible,
		            Type = "Viewport",
		        }
		
		        assert(
		            typeof(Viewport.Object) == "Instance" and (Viewport.Object:IsA("BasePart") or Viewport.Object:IsA("Model")),
		            "Instance must be a BasePart or Model."
		        )
		
		        assert(
		            typeof(Viewport.Camera) == "Instance" and Viewport.Camera:IsA("Camera"),
		            "Camera must be a valid Camera instance."
		        )
		
		        local function GetModelSize(model)
		            if model:IsA("BasePart") then
		                return model.Size
		            end
		
		            return select(2, model:GetBoundingBox())
		        end
		
		        local function FocusCamera()
		            local ModelSize = GetModelSize(Viewport.Object)
		            local MaxExtent = math.max(ModelSize.X, ModelSize.Y, ModelSize.Z)
		            local CameraDistance = MaxExtent * 2
		            local ModelPosition = Viewport.Object:GetPivot().Position
		
		            Viewport.Camera.CFrame =
		                CFrame.new(ModelPosition + Vector3.new(0, MaxExtent / 2, CameraDistance), ModelPosition)
		        end
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, Info.Height),
		            Visible = Viewport.Visible,
		            Parent = Container,
		        })
		
		        local Box = New("Frame", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            BorderColor3 = "OutlineColor",
		            BorderSizePixel = 1,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.fromScale(1, 1),
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 3),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 4),
		            Parent = Box,
		        })
		
		        local ViewportFrame = New("ViewportFrame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 1),
		            Parent = Box,
		            CurrentCamera = Viewport.Camera,
		            Active = Viewport.Interactive,
		        })
		
		        ViewportFrame.MouseEnter:Connect(function()
		            if not Viewport.Interactive then
		                return
		            end
		
		            for _, Side in Groupbox.Tab.Sides do
		                Side.ScrollingEnabled = false
		            end
		        end)
		
		        ViewportFrame.MouseLeave:Connect(function()
		            if not Viewport.Interactive then
		                return
		            end
		
		            for _, Side in Groupbox.Tab.Sides do
		                Side.ScrollingEnabled = true
		            end
		        end)
		
		        ViewportFrame.InputBegan:Connect(function(input)
		            if not Viewport.Interactive then
		                return
		            end
		
		            if input.UserInputType == Enum.UserInputType.MouseButton2 then
		                Dragging = true
		                LastMousePos = input.Position
		            elseif input.UserInputType == Enum.UserInputType.Touch and not Pinching then
		                Dragging = true
		                LastMousePos = input.Position
		            end
		        end)
		
		        Library:GiveSignal(UserInputService.InputEnded:Connect(function(input)
		            if Library.Unloaded then
		                return
		            end
		
		            if not Viewport.Interactive then
		                return
		            end
		
		            if input.UserInputType == Enum.UserInputType.MouseButton2 then
		                Dragging = false
		            elseif input.UserInputType == Enum.UserInputType.Touch then
		                Dragging = false
		            end
		        end))
		
		        Library:GiveSignal(UserInputService.InputChanged:Connect(function(input)
		            if Library.Unloaded then
		                return
		            end
		
		            if not Viewport.Interactive or not Dragging or Pinching then
		                return
		            end
		
		            if
		                input.UserInputType == Enum.UserInputType.MouseMovement
		                or input.UserInputType == Enum.UserInputType.Touch
		            then
		                local MouseDelta = input.Position - LastMousePos
		                LastMousePos = input.Position
		
		                local Position = Viewport.Object:GetPivot().Position
		                local Camera = Viewport.Camera
		
		                local RotationY = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -MouseDelta.X * 0.01)
		                Camera.CFrame = CFrame.new(Position) * RotationY * CFrame.new(-Position) * Camera.CFrame
		
		                local RotationX = CFrame.fromAxisAngle(Camera.CFrame.RightVector, -MouseDelta.Y * 0.01)
		                local PitchedCFrame = CFrame.new(Position) * RotationX * CFrame.new(-Position) * Camera.CFrame
		
		                if PitchedCFrame.UpVector.Y > 0.1 then
		                    Camera.CFrame = PitchedCFrame
		                end
		            end
		        end))
		
		        ViewportFrame.InputChanged:Connect(function(input)
		            if not Viewport.Interactive then
		                return
		            end
		
		            if input.UserInputType == Enum.UserInputType.MouseWheel then
		                local ZoomAmount = input.Position.Z * 2
		                Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * ZoomAmount
		            end
		        end)
		
		        Library:GiveSignal(UserInputService.TouchPinch:Connect(function(touchPositions, scale, velocity, state)
		            if Library.Unloaded then
		                return
		            end
		
		            if not Viewport.Interactive or not Library:MouseIsOverFrame(ViewportFrame, touchPositions[1]) then
		                return
		            end
		
		            if state == Enum.UserInputState.Begin then
		                Pinching = true
		                Dragging = false
		                LastPinchDist = (touchPositions[1] - touchPositions[2]).Magnitude
		            elseif state == Enum.UserInputState.Change then
		                local currentDist = (touchPositions[1] - touchPositions[2]).Magnitude
		                local delta = (currentDist - LastPinchDist) * 0.1
		                LastPinchDist = currentDist
		                Viewport.Camera.CFrame += Viewport.Camera.CFrame.LookVector * delta
		            elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then
		                Pinching = false
		            end
		        end))
		
		        Viewport.Object.Parent = ViewportFrame
		        if Viewport.AutoFocus then
		            FocusCamera()
		        end
		
		        function Viewport:SetObject(Object: Instance, Clone: boolean?)
		            assert(Object, "Object cannot be nil.")
		
		            if Clone then
		                Object = Object:Clone()
		            end
		
		            if Viewport.Object then
		                Viewport.Object:Destroy()
		            end
		
		            Viewport.Object = Object
		            Viewport.Object.Parent = ViewportFrame
		
		            Groupbox:Resize()
		        end
		
		        function Viewport:SetHeight(Height: number)
		            assert(Height > 0, "Height must be greater than 0.")
		
		            Holder.Size = UDim2.new(1, 0, 0, Height)
		            Groupbox:Resize()
		        end
		
		        function Viewport:Focus()
		            if not Viewport.Object then
		                return
		            end
		
		            FocusCamera()
		        end
		
		        function Viewport:SetCamera(Camera: Instance)
		            assert(
		                Camera and typeof(Camera) == "Instance" and Camera:IsA("Camera"),
		                "Camera must be a valid Camera instance."
		            )
		
		            Viewport.Camera = Camera
		            ViewportFrame.CurrentCamera = Camera
		        end
		
		        function Viewport:SetInteractive(Interactive: boolean)
		            Viewport.Interactive = Interactive
		            ViewportFrame.Active = Interactive
		        end
		
		        function Viewport:SetVisible(Visible: boolean)
		            Viewport.Visible = Visible
		
		            Holder.Visible = Viewport.Visible
		            Groupbox:Resize()
		        end
		
		        Groupbox:Resize()
		
		        Viewport.Holder = Holder
		        table.insert(Groupbox.Elements, Viewport)
		
		        Options[Idx] = Viewport
		
		        return Viewport
		    end
		
		    function Funcs:AddImage(Idx, Info)
		        Info = Library:Validate(Info, Templates.Image)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Image = {
		            Image = Info.Image,
		            Color = Info.Color,
		            RectOffset = Info.RectOffset,
		            RectSize = Info.RectSize,
		            Height = Info.Height,
		            ScaleType = Info.ScaleType,
		            Transparency = Info.Transparency,
		            BackgroundTransparency = Info.BackgroundTransparency,
		
		            Visible = Info.Visible,
		            Type = "Image",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, Info.Height),
		            Visible = Image.Visible,
		            Parent = Container,
		        })
		
		        local Box = New("Frame", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            BorderColor3 = "OutlineColor",
		            BorderSizePixel = 1,
		            BackgroundTransparency = Image.BackgroundTransparency,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.fromScale(1, 1),
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 3),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 4),
		            Parent = Box,
		        })
		
		        local ImageProperties = {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 1),
		            Image = Image.Image,
		            ImageTransparency = Image.Transparency,
		            ImageColor3 = Image.Color,
		            ImageRectOffset = Image.RectOffset,
		            ImageRectSize = Image.RectSize,
		            ScaleType = Image.ScaleType,
		            Parent = Box,
		        }
		
		        local Icon = Library:GetCustomIcon(ImageProperties.Image)
		        assert(Icon, "Image must be a valid Roblox asset or a valid URL or a valid lucide icon.")
		
		        ImageProperties.Image = Icon.Url
		        ImageProperties.ImageRectOffset = Icon.ImageRectOffset
		        ImageProperties.ImageRectSize = Icon.ImageRectSize
		
		        local ImageLabel = New("ImageLabel", ImageProperties)
		
		        function Image:SetHeight(Height: number)
		            assert(Height > 0, "Height must be greater than 0.")
		
		            Image.Height = Height
		            Holder.Size = UDim2.new(1, 0, 0, Height)
		            Groupbox:Resize()
		        end
		
		        function Image:SetImage(NewImage: string)
		            assert(typeof(NewImage) == "string", "Image must be a string.")
		
		            local Icon = Library:GetCustomIcon(NewImage)
		            assert(Icon, "Image must be a valid Roblox asset or a valid URL or a valid lucide icon.")
		
		            NewImage = Icon.Url
		            Image.RectOffset = Icon.ImageRectOffset
		            Image.RectSize = Icon.ImageRectSize
		
		            ImageLabel.Image = NewImage
		            Image.Image = NewImage
		        end
		
		        function Image:SetColor(Color: Color3)
		            assert(typeof(Color) == "Color3", "Color must be a Color3 value.")
		
		            ImageLabel.ImageColor3 = Color
		            Image.Color = Color
		        end
		
		        function Image:SetRectOffset(RectOffset: Vector2)
		            assert(typeof(RectOffset) == "Vector2", "RectOffset must be a Vector2 value.")
		
		            ImageLabel.ImageRectOffset = RectOffset
		            Image.RectOffset = RectOffset
		        end
		
		        function Image:SetRectSize(RectSize: Vector2)
		            assert(typeof(RectSize) == "Vector2", "RectSize must be a Vector2 value.")
		
		            ImageLabel.ImageRectSize = RectSize
		            Image.RectSize = RectSize
		        end
		
		        function Image:SetScaleType(ScaleType: Enum.ScaleType)
		            assert(
		                typeof(ScaleType) == "EnumItem" and ScaleType:IsA("ScaleType"),
		                "ScaleType must be a valid Enum.ScaleType."
		            )
		
		            ImageLabel.ScaleType = ScaleType
		            Image.ScaleType = ScaleType
		        end
		
		        function Image:SetTransparency(Transparency: number)
		            assert(typeof(Transparency) == "number", "Transparency must be a number between 0 and 1.")
		            assert(Transparency >= 0 and Transparency <= 1, "Transparency must be between 0 and 1.")
		
		            ImageLabel.ImageTransparency = Transparency
		            Image.Transparency = Transparency
		        end
		
		        function Image:SetVisible(Visible: boolean)
		            Image.Visible = Visible
		
		            Holder.Visible = Image.Visible
		            Groupbox:Resize()
		        end
		
		        Groupbox:Resize()
		
		        Image.Holder = Holder
		        table.insert(Groupbox.Elements, Image)
		
		        Options[Idx] = Image
		
		        return Image
		    end
		
		    function Funcs:AddVideo(Idx, Info)
		        Info = Library:Validate(Info, Templates.Video)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local Video = {
		            Video = Info.Video,
		            Looped = Info.Looped,
		            Playing = Info.Playing,
		            Volume = Info.Volume,
		            Height = Info.Height,
		            Visible = Info.Visible,
		
		            Type = "Video",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, Info.Height),
		            Visible = Video.Visible,
		            Parent = Container,
		        })
		
		        local Box = New("Frame", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = "MainColor",
		            BorderColor3 = "OutlineColor",
		            BorderSizePixel = 1,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.fromScale(1, 1),
		            Parent = Holder,
		        })
		
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 3),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 4),
		            Parent = Box,
		        })
		
		        local VideoFrameInstance = New("VideoFrame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 1),
		            Video = Video.Video,
		            Looped = Video.Looped,
		            Volume = Video.Volume,
		            Parent = Box,
		        })
		
		        VideoFrameInstance.Playing = Video.Playing
		
		        function Video:SetHeight(Height: number)
		            assert(Height > 0, "Height must be greater than 0.")
		
		            Video.Height = Height
		            Holder.Size = UDim2.new(1, 0, 0, Height)
		            Groupbox:Resize()
		        end
		
		        function Video:SetVideo(NewVideo: string)
		            assert(typeof(NewVideo) == "string", "Video must be a string.")
		
		            VideoFrameInstance.Video = NewVideo
		            Video.Video = NewVideo
		        end
		
		        function Video:SetLooped(Looped: boolean)
		            assert(typeof(Looped) == "boolean", "Looped must be a boolean.")
		
		            VideoFrameInstance.Looped = Looped
		            Video.Looped = Looped
		        end
		
		        function Video:SetVolume(Volume: number)
		            assert(typeof(Volume) == "number", "Volume must be a number between 0 and 10.")
		
		            VideoFrameInstance.Volume = Volume
		            Video.Volume = Volume
		        end
		
		        function Video:SetPlaying(Playing: boolean)
		            assert(typeof(Playing) == "boolean", "Playing must be a boolean.")
		
		            VideoFrameInstance.Playing = Playing
		            Video.Playing = Playing
		        end
		
		        function Video:Play()
		            VideoFrameInstance.Playing = true
		            Video.Playing = true
		        end
		
		        function Video:Pause()
		            VideoFrameInstance.Playing = false
		            Video.Playing = false
		        end
		
		        function Video:SetVisible(Visible: boolean)
		            Video.Visible = Visible
		
		            Holder.Visible = Video.Visible
		            Groupbox:Resize()
		        end
		
		        Groupbox:Resize()
		
		        Video.Holder = Holder
		        Video.VideoFrame = VideoFrameInstance
		        table.insert(Groupbox.Elements, Video)
		
		        Options[Idx] = Video
		
		        return Video
		    end
		
		    function Funcs:AddUIPassthrough(Idx, Info)
		        Info = Library:Validate(Info, Templates.UIPassthrough)
		
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        assert(Info.Instance, "Instance must be provided.")
		        assert(
		            typeof(Info.Instance) == "Instance" and Info.Instance:IsA("GuiBase2d"),
		            "Instance must inherit from GuiBase2d."
		        )
		        assert(typeof(Info.Height) == "number" and Info.Height > 0, "Height must be a number greater than 0.")
		
		        local Passthrough = {
		            Instance = Info.Instance,
		            Height = Info.Height,
		            Visible = Info.Visible,
		
		            Type = "UIPassthrough",
		        }
		
		        local Holder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, Info.Height),
		            Visible = Passthrough.Visible,
		            Parent = Container,
		        })
		
		        Passthrough.Instance.Parent = Holder
		
		        Groupbox:Resize()
		
		        function Passthrough:SetHeight(Height: number)
		            assert(typeof(Height) == "number" and Height > 0, "Height must be a number greater than 0.")
		
		            Passthrough.Height = Height
		            Holder.Size = UDim2.new(1, 0, 0, Height)
		            Groupbox:Resize()
		        end
		
		        function Passthrough:SetInstance(Instance: Instance)
		            assert(Instance, "Instance must be provided.")
		            assert(
		                typeof(Instance) == "Instance" and Instance:IsA("GuiBase2d"),
		                "Instance must inherit from GuiBase2d."
		            )
		
		            if Passthrough.Instance then
		                Passthrough.Instance.Parent = nil
		            end
		
		            Passthrough.Instance = Instance
		            Passthrough.Instance.Parent = Holder
		        end
		
		        function Passthrough:SetVisible(Visible: boolean)
		            Passthrough.Visible = Visible
		
		            Holder.Visible = Passthrough.Visible
		            Groupbox:Resize()
		        end
		
		        Passthrough.Holder = Holder
		        table.insert(Groupbox.Elements, Passthrough)
		
		        Options[Idx] = Passthrough
		
		        return Passthrough
		    end
		
		    function Funcs:AddDependencyBox()
		        local Groupbox = self
		        local Container = Groupbox.Container
		
		        local DepboxContainer
		        local DepboxList
		
		        do
		            DepboxContainer = New("Frame", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 1),
		                Visible = false,
		                Parent = Container,
		            })
		
		            DepboxList = New("UIListLayout", {
		                Padding = UDim.new(0, 8),
		                Parent = DepboxContainer,
		            })
		        end
		
		        local Depbox = {
		            Visible = false,
		            Dependencies = {},
		
		            Holder = DepboxContainer,
		            Container = DepboxContainer,
		
		            Elements = {},
		            DependencyBoxes = {},
		        }
		
		        function Depbox:Resize()
		            DepboxContainer.Size = UDim2.new(1, 0, 0, DepboxList.AbsoluteContentSize.Y / Library.DPIScale)
		            Groupbox:Resize()
		        end
		
		        function Depbox:Update(CancelSearch)
		            for _, Dependency in Depbox.Dependencies do
		                local Element = Dependency[1]
		                local Value = Dependency[2]
		
		                if Element.Type == "Toggle" and Element.Value ~= Value then
		                    DepboxContainer.Visible = false
		                    Depbox.Visible = false
		                    return
		                elseif Element.Type == "Dropdown" then
		                    if typeof(Element.Value) == "table" then
		                        if not Element.Value[Value] then
		                            DepboxContainer.Visible = false
		                            Depbox.Visible = false
		                            return
		                        end
		                    else
		                        if Element.Value ~= Value then
		                            DepboxContainer.Visible = false
		                            Depbox.Visible = false
		                            return
		                        end
		                    end
		                end
		            end
		
		            Depbox.Visible = true
		            DepboxContainer.Visible = true
		            if not Library.Searching then
		                task.defer(function()
		                    Depbox:Resize()
		                end)
		            elseif not CancelSearch then
		                Library:UpdateSearch(Library.SearchText)
		            end
		        end
		
		        DepboxList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		            if not Depbox.Visible then
		                return
		            end
		
		            Depbox:Resize()
		        end)
		
		        function Depbox:SetupDependencies(Dependencies)
		            for _, Dependency in Dependencies do
		                assert(typeof(Dependency) == "table", "Dependency should be a table.")
		                assert(Dependency[1] ~= nil, "Dependency is missing element.")
		                assert(Dependency[2] ~= nil, "Dependency is missing expected value.")
		            end
		
		            Depbox.Dependencies = Dependencies
		            Depbox:Update()
		        end
		
		        DepboxContainer:GetPropertyChangedSignal("Visible"):Connect(function()
		            Depbox:Resize()
		        end)
		
		        setmetatable(Depbox, BaseGroupbox)
		
		        table.insert(Groupbox.DependencyBoxes, Depbox)
		        table.insert(Library.DependencyBoxes, Depbox)
		
		        return Depbox
		    end
		
		    function Funcs:AddDependencyGroupbox()
		        local Groupbox = self
		        local Tab = Groupbox.Tab
		        local BoxHolder = Groupbox.BoxHolder
		
		        local DepGroupboxContainer
		        local DepGroupboxList
		
		        do
		            DepGroupboxContainer = New("Frame", {
		                BackgroundColor3 = "BackgroundColor",
		                Size = UDim2.fromScale(1, 0),
		                Visible = false,
		                Parent = BoxHolder,
		            })
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, Library.CornerRadius),
		                    Parent = DepGroupboxContainer,
		                })
		            )
		            Library:AddOutline(DepGroupboxContainer)
		
		            DepGroupboxList = New("UIListLayout", {
		                Padding = UDim.new(0, 8),
		                Parent = DepGroupboxContainer,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 7),
		                PaddingLeft = UDim.new(0, 7),
		                PaddingRight = UDim.new(0, 7),
		                PaddingTop = UDim.new(0, 7),
		                Parent = DepGroupboxContainer,
		            })
		        end
		
		        local DepGroupbox = {
		            Visible = false,
		            Dependencies = {},
		
		            BoxHolder = BoxHolder,
		            Holder = DepGroupboxContainer,
		            Container = DepGroupboxContainer,
		
		            Tab = Tab,
		            Elements = {},
		            DependencyBoxes = {},
		        }
		
		        function DepGroupbox:Resize()
		            DepGroupboxContainer.Size = UDim2.new(1, 0, 0, (DepGroupboxList.AbsoluteContentSize.Y / Library.DPIScale) + 18)
		        end
		
		        function DepGroupbox:Update(CancelSearch)
		            for _, Dependency in DepGroupbox.Dependencies do
		                local Element = Dependency[1]
		                local Value = Dependency[2]
		
		                if Element.Type == "Toggle" and Element.Value ~= Value then
		                    DepGroupboxContainer.Visible = false
		                    DepGroupbox.Visible = false
		                    return
		                elseif Element.Type == "Dropdown" then
		                    if typeof(Element.Value) == "table" then
		                        if not Element.Value[Value] then
		                            DepGroupboxContainer.Visible = false
		                            DepGroupbox.Visible = false
		                            return
		                        end
		                    else
		                        if Element.Value ~= Value then
		                            DepGroupboxContainer.Visible = false
		                            DepGroupbox.Visible = false
		                            return
		                        end
		                    end
		                end
		            end
		
		            DepGroupbox.Visible = true
		            if not Library.Searching then
		                DepGroupboxContainer.Visible = true
		                DepGroupbox:Resize()
		            elseif not CancelSearch then
		                Library:UpdateSearch(Library.SearchText)
		            end
		        end
		
		        function DepGroupbox:SetupDependencies(Dependencies)
		            for _, Dependency in Dependencies do
		                assert(typeof(Dependency) == "table", "Dependency should be a table.")
		                assert(Dependency[1] ~= nil, "Dependency is missing element.")
		                assert(Dependency[2] ~= nil, "Dependency is missing expected value.")
		            end
		
		            DepGroupbox.Dependencies = Dependencies
		            DepGroupbox:Update()
		        end
		
		        setmetatable(DepGroupbox, BaseGroupbox)
		
		        table.insert(Tab.DependencyGroupboxes, DepGroupbox)
		        table.insert(Library.DependencyBoxes, DepGroupbox)
		
		        return DepGroupbox
		    end
		
		    BaseGroupbox.__index = Funcs
		    BaseGroupbox.__namecall = function(_, Key, ...)
		        return Funcs[Key](...)
		    end
		end
		
		function Library:SetFont(FontFace)
		    if typeof(FontFace) == "EnumItem" then
		        FontFace = Font.fromEnum(FontFace)
		    end
		
		    Library.Scheme.Font = FontFace
		    Library:UpdateColorsUsingRegistry()
		end
		
		function Library:SetNotifySide(Side: string)
		    Library.NotifySide = Side
		
		    if Side:lower() == "left" then
		        NotificationArea.AnchorPoint = Vector2.new(0, 0)
		        NotificationArea.Position = UDim2.fromOffset(6, 6)
		        NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Left
		    else
		        NotificationArea.AnchorPoint = Vector2.new(1, 0)
		        NotificationArea.Position = UDim2.new(1, -6, 0, 6)
		        NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
		    end
		end
		
		    function Library:Notify(...)
		        local Data = {}
		        local Info = select(1, ...)
		
		        if typeof(Info) == "table" then
		            Data.Title = Info.Title and tostring(Info.Title) or nil
		            Data.Description = Info.Description and tostring(Info.Description) or nil
		            Data.Time = Info.Time or 5
		            Data.SoundId = Info.SoundId
		            Data.Steps = Info.Steps
		            Data.Persist = Info.Persist
		            Data.Icon = Info.Icon
		            Data.BigIcon = Info.BigIcon
		            Data.IconColor = Info.IconColor
		        else
		            Data.Description = tostring(Info)
		            Data.Time = select(2, ...) or 5
		            Data.SoundId = select(3, ...)
		        end
		        Data.Destroyed = false
		
		        local DeletedInstance = false
		        local DeleteConnection = nil
		        if typeof(Data.Time) == "Instance" then
		            DeleteConnection = Data.Time.Destroying:Connect(function()
		                DeletedInstance = true
		                DeleteConnection:Disconnect()
		                DeleteConnection = nil
		            end)
		        end
		
		        local FakeBackground = New("Frame", {
		            AutomaticSize = Enum.AutomaticSize.Y,
		            BackgroundTransparency = 1,
		            Size = UDim2.fromOffset(220, 0),
		            Visible = false,
		            Parent = NotificationArea,
		        })
		
		        local Holder = New("Frame", {
		            AutomaticSize = Enum.AutomaticSize.Y,
		            BackgroundColor3 = "MainColor",
		            Position = Library.NotifySide:lower() == "left" and UDim2.new(-1, -8, 0, 0) or UDim2.new(1, 8, 0, 0),
		            Size = UDim2.fromScale(1, 0),
		            ZIndex = 5,
		            Parent = FakeBackground,
		        })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = Holder }))
		        
		        New("UIListLayout", {
		            Padding = UDim.new(0, 6),
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = Holder,
		        })
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 10),
		            PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8),
		            Parent = Holder,
		        })
		        Library:AddOutline(Holder)
		
		        local ContentContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Size = UDim2.fromScale(1, 0),
		            LayoutOrder = 1,
		            Parent = Holder,
		        })
		        
		        New("UIListLayout", {
		            Padding = UDim.new(0, 8),
		            FillDirection = Enum.FillDirection.Horizontal,
		            VerticalAlignment = Enum.VerticalAlignment.Center,
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = ContentContainer,
		        })
		
		        if Data.BigIcon then
		            local ParsedIcon = Library:GetCustomIcon(Data.BigIcon)
		            if ParsedIcon then
		                New("ImageLabel", {
		                    BackgroundTransparency = 1,
		                    Size = UDim2.fromOffset(28, 28),
		                    Image = ParsedIcon.Url,
		                    ImageColor3 = Data.IconColor or "AccentColor",
		                    ImageRectOffset = ParsedIcon.ImageRectOffset,
		                    ImageRectSize = ParsedIcon.ImageRectSize,
		                    LayoutOrder = 1,
		                    Parent = ContentContainer,
		                })
		            end
		        end
		
		        local TextContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Size = UDim2.new(1, Data.BigIcon and -36 or 0, 0, 0),
		            LayoutOrder = 2,
		            Parent = ContentContainer,
		        })
		        New("UIListLayout", {
		            Padding = UDim.new(0, 2),
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = TextContainer,
		        })
		
		        local TitleContainer
		        local Title
		        if Data.Title or Data.Icon then
		            TitleContainer = New("Frame", {
		                BackgroundTransparency = 1,
		                AutomaticSize = Enum.AutomaticSize.Y,
		                Size = UDim2.fromScale(1, 0),
		                LayoutOrder = 1,
		                Parent = TextContainer,
		            })
		            New("UIListLayout", {
		                Padding = UDim.new(0, 5),
		                FillDirection = Enum.FillDirection.Horizontal,
		                VerticalAlignment = Enum.VerticalAlignment.Center,
		                SortOrder = Enum.SortOrder.LayoutOrder,
		                Parent = TitleContainer,
		            })
		
		            if Data.Icon then
		                local ParsedIcon = Library:GetCustomIcon(Data.Icon)
		                if ParsedIcon then
		                    New("ImageLabel", {
		                        BackgroundTransparency = 1,
		                        Size = UDim2.fromOffset(14, 14),
		                        Image = ParsedIcon.Url,
		                        ImageColor3 = Data.IconColor or "FontColor",
		                        ImageRectOffset = ParsedIcon.ImageRectOffset,
		                        ImageRectSize = ParsedIcon.ImageRectSize,
		                        LayoutOrder = 1,
		                        Parent = TitleContainer,
		                    })
		                end
		            end
		
		            if Data.Title then
		                Title = New("TextLabel", {
		                    AutomaticSize = Enum.AutomaticSize.Y,
		                    BackgroundTransparency = 1,
		                    Size = UDim2.new(1, Data.Icon and -19 or 0, 0, 0),
		                    Text = Data.Title,
		                    TextSize = 13,
		                    TextColor3 = "FontColor",
		                    FontFace = Font.new(Library.Scheme.Font.Family, Enum.FontWeight.Bold, Enum.FontStyle.Normal), 
		                    TextXAlignment = Enum.TextXAlignment.Left,
		                    TextWrapped = true,
		                    LayoutOrder = 2,
		                    Parent = TitleContainer,
		                })
		            end
		        end
		
		        local Desc
		        if Data.Description then
		            Desc = New("TextLabel", {
		                AutomaticSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 0),
		                Text = Data.Description,
		                TextSize = 12,
		                TextColor3 = "FontColor",
		                TextTransparency = 0.3,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                TextWrapped = true,
		                LayoutOrder = 2,
		                Parent = TextContainer,
		            })
		        end
		
		        function Data:ChangeTitle(Text)
		            if Title then
		                Data.Title = tostring(Text)
		                Title.Text = Data.Title
		            end
		        end
		
		        function Data:ChangeDescription(Text)
		            if Desc then
		                Data.Description = tostring(Text)
		                Desc.Text = Data.Description
		            end
		        end
		
		        local TimerFill
		        function Data:ChangeStep(NewStep)
		            if TimerFill and Data.Steps then
		                NewStep = math.clamp(NewStep or 0, 0, Data.Steps)
		                TimerFill.Size = UDim2.fromScale(NewStep / Data.Steps, 1)
		            end
		        end
		
		        function Data:Destroy()
		            Data.Destroyed = true
		
		            if typeof(Data.Time) == "Instance" then
		                pcall(Data.Time.Destroy, Data.Time)
		            end
		
		            if DeleteConnection then
		                DeleteConnection:Disconnect()
		            end
		
		            TweenService
		                :Create(Holder, Library.NotifyTweenInfo, {
		                    Position = Library.NotifySide:lower() == "left" and UDim2.new(-1, -8, 0, 0) or UDim2.new(1, 8, 0, 0),
		                })
		                :Play()
		
		            task.delay(Library.NotifyTweenInfo.Time, function()
		                Library.Notifications[FakeBackground] = nil
		                FakeBackground:Destroy()
		            end)
		        end
		
		        function Data:Resize() end 
		
		        local TimerHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 2),
		            LayoutOrder = 2,
		            Visible = (Data.Persist ~= true and typeof(Data.Time) ~= "Instance") or typeof(Data.Steps) == "number",
		            Parent = Holder,
		        })
		        local TimerBar = New("Frame", {
		            BackgroundColor3 = "OutlineColor",
		            BorderSizePixel = 0,
		            Size = UDim2.new(1, 0, 0, 2),
		            Parent = TimerHolder,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = TimerBar })
		        
		        TimerFill = New("Frame", {
		            BackgroundColor3 = "AccentColor",
		            Size = UDim2.fromScale(1, 1),
		            Parent = TimerBar,
		        })
		        New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = TimerFill })
		
		        if typeof(Data.Time) == "Instance" then
		            TimerFill.Size = UDim2.fromScale(0, 1)
		        end
		        if Data.SoundId then
		            local SoundId = Data.SoundId
		            if typeof(SoundId) == "number" then
		                SoundId = string.format("rbxassetid://%d", SoundId)
		            end
		
		            New("Sound", {
		                SoundId = SoundId,
		                Volume = 3,
		                PlayOnRemove = true,
		                Parent = SoundService,
		            }):Destroy()
		        end
		
		        Library.Notifications[FakeBackground] = Data
		
		        FakeBackground.Visible = true
		        TweenService:Create(Holder, Library.NotifyTweenInfo, {
		            Position = UDim2.fromOffset(0, 0),
		        }):Play()
		
		        task.delay(Library.NotifyTweenInfo.Time, function()
		            if Data.Persist then
		                return
		            elseif typeof(Data.Time) == "Instance" then
		                repeat
		                    task.wait()
		                until DeletedInstance or Data.Destroyed
		            else
		                TweenService
		                    :Create(TimerFill, TweenInfo.new(Data.Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		                        Size = UDim2.fromScale(0, 1),
		                    })
		                    :Play()
		                task.wait(Data.Time)
		            end
		
		            if not Data.Destroyed then
		                Data:Destroy()
		            end
		        end)
		
		        return Data
		    end
		
		function Library:CreateWindow(WindowInfo)
		    WindowInfo = Library:Validate(WindowInfo, Templates.Window)
		    local ViewportSize: Vector2 = workspace.CurrentCamera.ViewportSize
		    if RunService:IsStudio() and ViewportSize.X <= 5 and ViewportSize.Y <= 5 then
		        repeat
		            ViewportSize = workspace.CurrentCamera.ViewportSize
		            task.wait()
		        until ViewportSize.X > 5 and ViewportSize.Y > 5
		    end
		
		    local MaxX = ViewportSize.X - 64
		    local MaxY = ViewportSize.Y - 64
		
		    Library.OriginalMinSize =
		        Vector2.new(math.min(Library.OriginalMinSize.X, MaxX), math.min(Library.OriginalMinSize.Y, MaxY))
		    Library.MinSize = Library.OriginalMinSize
		
		    WindowInfo.Size = UDim2.fromOffset(
		        math.clamp(WindowInfo.Size.X.Offset, Library.MinSize.X, MaxX),
		        math.clamp(WindowInfo.Size.Y.Offset, Library.MinSize.Y, MaxY)
		    )
		    if typeof(WindowInfo.Font) == "EnumItem" then
		        WindowInfo.Font = Font.fromEnum(WindowInfo.Font)
		    end
		    WindowInfo.CornerRadius = math.min(WindowInfo.CornerRadius, 20)
		    
		    --// Old Naming \\--
		    if WindowInfo.Compact ~= nil then
		        WindowInfo.SidebarCompacted = WindowInfo.Compact
		    end
		    if WindowInfo.SidebarMinWidth ~= nil then
		        WindowInfo.MinSidebarWidth = WindowInfo.SidebarMinWidth
		    end
		    WindowInfo.MinSidebarWidth = math.max(64, WindowInfo.MinSidebarWidth)
		    WindowInfo.SidebarCompactWidth = math.max(48, WindowInfo.SidebarCompactWidth)
		    WindowInfo.SidebarCollapseThreshold = math.clamp(WindowInfo.SidebarCollapseThreshold, 0.1, 0.9)
		    WindowInfo.CompactWidthActivation = math.max(48, WindowInfo.CompactWidthActivation)
		
		    Library.CornerRadius = WindowInfo.CornerRadius
		    Library:SetNotifySide(WindowInfo.NotifySide)
		    Library.ShowCustomCursor = WindowInfo.ShowCustomCursor
		    Library.Scheme.Font = WindowInfo.Font
		    Library.ToggleKeybind = WindowInfo.ToggleKeybind
		    Library.GlobalSearch = WindowInfo.GlobalSearch
		
		    local IsDefaultSearchbarSize = WindowInfo.SearchbarSize == UDim2.fromScale(1, 1)
		    local MainFrame
		    local DividerLine
		    local TitleHolder
		    local WindowTitle
		    local WindowIcon
		    local RightWrapper
		    local SearchBox
		    local CurrentTabInfo
		    local CurrentTabLabel
		    local CurrentTabDescription
		    local ResizeButton
		    local Tabs
		    local Container
		    local BackgroundImage
		    local BottomBackground
		    local FooterLabel
		
		    local InitialLeftWidth = math.ceil(WindowInfo.Size.X.Offset * 0.3)
		    local IsCompact = WindowInfo.SidebarCompacted
		    local LastExpandedWidth = InitialLeftWidth
		
		    do
		        Library.KeybindFrame, Library.KeybindContainer = Library:AddDraggableMenu("Keybinds")
		        Library.KeybindFrame.AnchorPoint = Vector2.new(0, 0.5)
		        Library.KeybindFrame.Position = UDim2.new(0, 6, 0.5, 0)
		        Library.KeybindFrame.Visible = false
		
		        MainFrame = New("TextButton", {
		            BackgroundColor3 = function()
		                return Library:GetBetterColor(Library.Scheme.BackgroundColor, -1)
		            end,
		            Name = "Main",
		            Text = "",
		            Position = WindowInfo.Position,
		            Size = WindowInfo.Size,
		            Visible = false,
		            Parent = ScreenGui,
		        })
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                Parent = MainFrame,
		            })
		        )
		        table.insert(
		            Library.Scales,
		            New("UIScale", {
		                Parent = MainFrame,
		            })
		        )
		        Library:AddOutline(MainFrame)
		        Library:MakeLine(MainFrame, {
		            Position = UDim2.fromOffset(0, 48),
		            Size = UDim2.new(1, 0, 0, 1),
		        })
		
		        DividerLine = New("Frame", {
		            BackgroundColor3 = "OutlineColor",
		            Position = UDim2.fromOffset(InitialLeftWidth, 0),
		            Size = UDim2.new(0, 1, 1, -21),
		            Parent = MainFrame,
		        })
		
		        if WindowInfo.BackgroundImage then
		            BackgroundImage = New("ImageLabel", {
		                Image = WindowInfo.BackgroundImage,
		                Position = UDim2.fromScale(0, 0),
		                Size = UDim2.fromScale(1, 1),
		                ScaleType = Enum.ScaleType.Stretch,
		                ZIndex = 999,
		                BackgroundTransparency = 1,
		                ImageTransparency = 0.75,
		                Parent = MainFrame,
		            })
		
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                    Parent = BackgroundImage,
		                })
		            )
		        end
		
		        if WindowInfo.Center then
		            MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
		        end
		
		        --// Top Bar \\-
		        local TopBar = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 48),
		            Parent = MainFrame,
		        })
		        Library:MakeDraggable(MainFrame, TopBar, false, true)
		
		        --// Title
		        TitleHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(0, InitialLeftWidth, 1, 0),
		            Parent = TopBar,
		        })
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Center,
		            VerticalAlignment = Enum.VerticalAlignment.Center,
		            Padding = UDim.new(0, 6),
		            Parent = TitleHolder,
		        })
		
		        if WindowInfo.Icon then
		            local Icon = Library:GetCustomIcon(WindowInfo.Icon)
		            WindowIcon = New("ImageLabel", {
		                Image = Icon.Url,
		                ImageRectOffset = Icon.ImageRectOffset,
		                ImageRectSize = Icon.ImageRectSize,
		                Size = WindowInfo.IconSize,
		                Parent = TitleHolder,
		            })
		        else
		            WindowIcon = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Size = WindowInfo.IconSize,
		                Text = WindowInfo.Title:sub(1, 1),
		                TextScaled = true,
		                Visible = false,
		                Parent = TitleHolder,
		            })
		        end
		
		        local X = Library:GetTextBounds(
		            WindowInfo.Title,
		            Library.Scheme.Font,
		            20,
		            TitleHolder.AbsoluteSize.X - (WindowInfo.Icon and WindowInfo.IconSize.X.Offset + 6 or 0) - 12
		        )
		        WindowTitle = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(0, X, 1, 0),
		            Text = WindowInfo.Title,
		            TextSize = 20,
		            Parent = TitleHolder,
		        })
		
		        --// Top Right Bar
		        RightWrapper = New("Frame", {
		            AnchorPoint = Vector2.new(1, 0.5),
		            BackgroundTransparency = 1,
		            Position = UDim2.new(1, -49, 0.5, 0),
		            Size = UDim2.new(1, -InitialLeftWidth - 57 - 1, 1, -16),
		            Parent = TopBar,
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Left,
		            VerticalAlignment = Enum.VerticalAlignment.Center,
		            Padding = UDim.new(0, 8),
		            Parent = RightWrapper,
		        })
		
		        CurrentTabInfo = New("Frame", {
		            Size = UDim2.fromScale(WindowInfo.DisableSearch and 1 or 0.5, 1),
		            Visible = false,
		            BackgroundTransparency = 1,
		            Parent = RightWrapper,
		        })
		
		        New("UIFlexItem", {
		            FlexMode = Enum.UIFlexMode.Grow,
		            Parent = CurrentTabInfo,
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Vertical,
		            HorizontalAlignment = Enum.HorizontalAlignment.Left,
		            VerticalAlignment = Enum.VerticalAlignment.Center,
		            Parent = CurrentTabInfo,
		        })
		
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 8),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 8),
		            Parent = CurrentTabInfo,
		        })
		
		        CurrentTabLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Text = "",
		            TextSize = 20,
		            FontFace = Font.new(Library.Scheme.Font.Family, Enum.FontWeight.Bold, Enum.FontStyle.Normal), 
		            TextXAlignment = Enum.TextXAlignment.Left,
		            Parent = CurrentTabInfo,
		        })
		        local ShineGradient = New("UIGradient", {
		            Color = ColorSequence.new({
		                ColorSequenceKeypoint.new(0, Color3.new(0.7, 0.7, 0.7)),
		                ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
		                ColorSequenceKeypoint.new(1, Color3.new(0.7, 0.7, 0.7))
		            }),
		            Rotation = 45,
		            Offset = Vector2.new(-1, 0),
		            Parent = CurrentTabLabel,
		        })
		
		        TweenService:Create(ShineGradient, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false), {
		            Offset = Vector2.new(1, 0)
		        }):Play()
		
		        CurrentTabDescription = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Text = "",
		            TextWrapped = true,
		            TextSize = 14,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            TextTransparency = 0.5,
		            Parent = CurrentTabInfo,
		        })
		
		        SearchBox = New("TextBox", {
		            BackgroundColor3 = "MainColor",
		            PlaceholderText = "Search",
		            Size = WindowInfo.SearchbarSize,
		            TextScaled = true,
		            Visible = not (WindowInfo.DisableSearch or false),
		            Parent = RightWrapper,
		        })
		        New("UIFlexItem", {
		            FlexMode = Enum.UIFlexMode.Shrink,
		            Parent = SearchBox,
		        })
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                Parent = SearchBox,
		            })
		        )
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 8),
		            PaddingLeft = UDim.new(0, 8),
		            PaddingRight = UDim.new(0, 8),
		            PaddingTop = UDim.new(0, 8),
		            Parent = SearchBox,
		        })
		        New("UIStroke", {
		            Color = "OutlineColor",
		            Parent = SearchBox,
		        })
		
		        local SearchIcon = Library:GetIcon("text-search")
		        if SearchIcon then
		            New("ImageLabel", {
		                Image = SearchIcon.Url,
		                ImageColor3 = "FontColor",
		                ImageRectOffset = SearchIcon.ImageRectOffset,
		                ImageRectSize = SearchIcon.ImageRectSize,
		                ImageTransparency = 0.5,
		                Size = UDim2.fromScale(1, 1),
		                SizeConstraint = Enum.SizeConstraint.RelativeYY,
		                Parent = SearchBox,
		            })
		        end
		
		        if MoveIcon then
		            New("ImageLabel", {
		                AnchorPoint = Vector2.new(1, 0.5),
		                Image = MoveIcon.Url,
		                ImageColor3 = "OutlineColor",
		                ImageRectOffset = MoveIcon.ImageRectOffset,
		                ImageRectSize = MoveIcon.ImageRectSize,
		                Position = UDim2.new(1, -10, 0.5, 0),
		                Size = UDim2.fromOffset(28, 28),
		                SizeConstraint = Enum.SizeConstraint.RelativeYY,
		                Parent = TopBar,
		            })
		        end
		
		        --// Bottom Bar \\--
		        BottomBackground = New("Frame", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundColor3 = function()
		                return Library:GetBetterColor(Library.Scheme.BackgroundColor, 4)
		            end,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.new(1, 0, 0, 20 + WindowInfo.CornerRadius),
		            Parent = MainFrame
		        })
		        Library:MakeLine(MainFrame, {
		            AnchorPoint = Vector2.new(0, 1),
		            Position = UDim2.new(0, 0, 1, -20),
		            Size = UDim2.new(1, 0, 0, 1),
		        })
		
		        local BottomBar = New("Frame", {
		            AnchorPoint = Vector2.new(0, 1),
		            BackgroundTransparency = 1,
		            Position = UDim2.fromScale(0, 1),
		            Size = UDim2.new(1, 0, 0, 20),
		            Parent = MainFrame,
		        })
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                Parent = BottomBackground,
		            })
		        )
		
		        --// Footer
		        FooterLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 1),
		            Text = WindowInfo.Footer,
		            TextSize = 14,
		            TextTransparency = 0.5,
		            Parent = BottomBar,
		        })
		
		        --// Resize Button
		        if WindowInfo.Resizable then
		            ResizeButton = New("TextButton", {
		                AnchorPoint = Vector2.new(1, 0),
		                BackgroundTransparency = 1,
		                Position = UDim2.new(1, -WindowInfo.CornerRadius / 4, 0, 0),
		                Size = UDim2.fromScale(1, 1),
		                SizeConstraint = Enum.SizeConstraint.RelativeYY,
		                Text = "",
		                Parent = BottomBar,
		            })
		
		            Library:MakeResizable(MainFrame, ResizeButton, function()
		                for _, Tab in Library.Tabs do
		                    Tab:Resize(true)
		                end
		            end)
		        end
		
		        New("ImageLabel", {
		            Image = ResizeIcon and ResizeIcon.Url or "",
		            ImageColor3 = "FontColor",
		            ImageRectOffset = ResizeIcon and ResizeIcon.ImageRectOffset or Vector2.zero,
		            ImageRectSize = ResizeIcon and ResizeIcon.ImageRectSize or Vector2.zero,
		            ImageTransparency = 0.5,
		            Position = UDim2.fromOffset(2, 2),
		            Size = UDim2.new(1, -4, 1, -4),
		            Parent = ResizeButton,
		        })
		
		        --// Tabs \\--
		        Tabs = New("ScrollingFrame", {
		            AutomaticCanvasSize = Enum.AutomaticSize.Y,
		            BackgroundColor3 = "BackgroundColor",
		            CanvasSize = UDim2.fromScale(0, 0),
		            Position = UDim2.fromOffset(0, 49),
		            ScrollBarThickness = 0,
		            Size = UDim2.new(0, InitialLeftWidth, 1, -70),
		            Parent = MainFrame,
		        })
		        New("UIListLayout", {
		            HorizontalAlignment = Enum.HorizontalAlignment.Center,
		            Padding = UDim.new(0, 6),
		            Parent = Tabs,
		        })
		        New("UIPadding", {
		            PaddingTop = UDim.new(0, 8),
		            Parent = Tabs,
		        })
		
		        --// Container \\--
		        Container = New("Frame", {
		            AnchorPoint = Vector2.new(1, 0),
		            BackgroundColor3 = function()
		                return Library:GetBetterColor(Library.Scheme.BackgroundColor, 1)
		            end,
		            Name = "Container",
		            Position = UDim2.new(1, 0, 0, 49),
		            Size = UDim2.new(1, -InitialLeftWidth - 1, 1, -70),
		            Parent = MainFrame,
		        })
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 0),
		            PaddingLeft = UDim.new(0, 6),
		            PaddingRight = UDim.new(0, 6),
		            PaddingTop = UDim.new(0, 0),
		            Parent = Container,
		        })
		    end
		
		    --// Window Table \\--
		    local Window = {}
		
		    function Window:ChangeTitle(title)
		        assert(typeof(title) == "string", "Expected string for title got: " .. typeof(title))
		
		        WindowTitle.Text = title
		        WindowInfo.Title = title
		    end
		
		    if WindowInfo.BackgroundImage then
		        function Window:SetBackgroundImage(Image: string)
		            assert(typeof(Image) == "string", "Expected string for Image got: " .. typeof(Image))
		    
		            BackgroundImage.Image = Image
		            WindowInfo.BackgroundImage = Image
		        end
		    end
		
		    function Window:SetFooter(footer: string)
		        assert(typeof(footer) == "string", "Expected string for footer got: " .. typeof(footer))
		
		        FooterLabel.Text = footer
		        WindowInfo.Footer = footer
		    end
		
		    function Window:SetCornerRadius(Radius: number)
		        assert(typeof(Radius) == "number", "Expected number for Radius got: " .. typeof(Radius))
		        Radius = math.min(Radius, 20)
		
		        for _, UICorner in Library.Corners do
		            if UICorner.CornerRadius.Offset == Library.CornerRadius / 2 then
		                UICorner.CornerRadius = UDim.new(0, Radius / 2)
		            else
		                UICorner.CornerRadius = UDim.new(0, Radius)
		            end
		        end
		
		        Library.CornerRadius = Radius
		        WindowInfo.CornerRadius = Radius
		
		        ResizeButton.Position = UDim2.new(1, -Radius / 4, 0, 0)
		        BottomBackground.Size = UDim2.new(1, 0, 0, 20 + Radius)
		
		        for _, Tab in Library.Tabs do
		            if Tab.IsKeyTab then
		                continue
		            end
		
		            for _, Tabbox in Tab.Tabboxes do
		                Tabbox:UpdateCorners()
		            end
		        end
		    end
		
		    local function ApplyCompact()
		        IsCompact = Window:GetSidebarWidth() == WindowInfo.SidebarCompactWidth
		        if WindowInfo.DisableCompactingSnap then
		            IsCompact = Window:GetSidebarWidth() <= WindowInfo.CompactWidthActivation
		        end
		
		        WindowTitle.Visible = not IsCompact
		        if not WindowInfo.Icon then
		            WindowIcon.Visible = IsCompact
		        end
		
		                for _, Button in Library.TabButtons do
		            if not Button.Icon then
		                continue
		            end
		
		            Button.Label.Visible = not IsCompact
		            
		            Button.Padding.PaddingBottom = UDim.new(0, 6)
		            Button.Padding.PaddingLeft = UDim.new(0, 8)
		            Button.Padding.PaddingRight = UDim.new(0, 8)
		            Button.Padding.PaddingTop = UDim.new(0, 6)
		            Button.Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
		        end
		     end
		
		    function Window:IsSidebarCompacted()
		        return IsCompact
		    end
		
		    function Window:SetCompact(State)
		        Window:SetSidebarWidth(State and WindowInfo.SidebarCompactWidth or LastExpandedWidth)
		    end
		
		    function Window:GetSidebarWidth()
		        return Tabs.Size.X.Offset
		    end
		
		    function Window:SetSidebarWidth(Width)
		        Width = math.clamp(Width, 48, MainFrame.Size.X.Offset - WindowInfo.MinContainerWidth - 1)
		
		        DividerLine.Position = UDim2.fromOffset(Width, 0)
		
		        TitleHolder.Size = UDim2.new(0, Width, 1, 0)
		        RightWrapper.Size = UDim2.new(1, -Width - 57 - 1, 1, -16)
		        Tabs.Size = UDim2.new(0, Width, 1, -70)
		        Container.Size = UDim2.new(1, -Width - 1, 1, -70)
		
		        if WindowInfo.EnableCompacting then
		            ApplyCompact()
		        end
		        if not IsCompact then
		            LastExpandedWidth = Width
		        end
		    end
		
		    function Window:ShowTabInfo(Name, Description)
		        CurrentTabLabel.Text = Name
		        CurrentTabDescription.Text = Description
		
		        if IsDefaultSearchbarSize then
		            SearchBox.Size = UDim2.fromScale(0.5, 1)
		        end
		        CurrentTabInfo.Visible = true
		    end
		    function Window:HideTabInfo()
		        CurrentTabInfo.Visible = false
		        if IsDefaultSearchbarSize then
		            SearchBox.Size = UDim2.fromScale(1, 1)
		        end
		    end
		
		    function Window:AddTab(...)
		        local Name = nil
		        local Icon = nil
		        local Description = nil
		
		        if select("#", ...) == 1 and typeof(...) == "table" then
		            local Info = select(1, ...)
		            Name = Info.Name or "Tab"
		            Icon = Info.Icon
		            Description = Info.Description
		        else
		            Name = select(1, ...)
		            Icon = select(2, ...)
		            Description = select(3, ...)
		        end
		
		        local TabButton: TextButton
		        local TabLabel
		        local TabIcon
		        local IconScale
		        local ButtonPadding
		
		        local TabContainer
		        local TabLeft
		        local TabRight
		
		        Icon = Library:GetCustomIcon(Icon)
		        do
		            TabButton = New("TextButton", {
		                BackgroundColor3 = "AccentColor", 
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, -12, 0, 36),
		                Text = "",
		                Parent = Tabs,
		            })
		            
		            table.insert(Library.Corners, New("UICorner", {
		                CornerRadius = UDim.new(0, 8),
		                Parent = TabButton,
		            }))
		            
		            ButtonPadding = New("UIPadding", {
		                PaddingBottom = UDim.new(0, 6),
		                PaddingLeft = UDim.new(0, 8),
		                PaddingRight = UDim.new(0, 8),
		                PaddingTop = UDim.new(0, 6),
		                Parent = TabButton,
		            })
		
		            TabLabel = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Position = UDim2.fromOffset(30, 0),
		                Size = UDim2.new(1, -30, 1, 0),
		                Text = Name,
		                TextSize = 16,
		                TextTransparency = 0.5,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                Visible = not IsCompact,
		                Parent = TabButton,
		            })
		
		            if Icon then
		                TabIcon = New("ImageLabel", {
		                    Image = Icon.Url,
		                    ImageColor3 = Icon.Custom and "WhiteColor" or "AccentColor",
		                    ImageRectOffset = Icon.ImageRectOffset,
		                    ImageRectSize = Icon.ImageRectSize,
		                    ImageTransparency = 0.5,
		                    ScaleType = Enum.ScaleType.Fit,
		                    Size = UDim2.fromScale(1, 1),
		                    SizeConstraint = IsCompact and Enum.SizeConstraint.RelativeXY or Enum.SizeConstraint.RelativeYY,
		                    Parent = TabButton,
		                })
		                
		                IconScale = New("UIScale", {
		                    Scale = 1,
		                    Parent = TabIcon,
		                })
		            end
		
		            table.insert(Library.TabButtons, {
		                Label = TabLabel,
		                Padding = ButtonPadding,
		                Icon = TabIcon,
		            })
		
		            --// Tab Container \\--
		            TabContainer = New("Frame", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 1),
		                Visible = false,
		                Parent = Container,
		            })
		
		            TabLeft = New("ScrollingFrame", {
		                AutomaticCanvasSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                CanvasSize = UDim2.fromScale(0, 0),
		                ScrollBarImageTransparency = 1,
		                ScrollBarThickness = 0,
		                Size = UDim2.new(0.5, -3, 1, 0),
		                Parent = TabContainer,
		            })
		            New("UIListLayout", {
		                Padding = UDim.new(0, 2),
		                Parent = TabLeft,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 2),
		                PaddingLeft = UDim.new(0, 2),
		                PaddingRight = UDim.new(0, 2),
		                PaddingTop = UDim.new(0, 2),
		                Parent = TabLeft,
		            })
		            do
		                New("Frame", {
		                    BackgroundTransparency = 1,
		                    LayoutOrder = -1,
		                    Parent = TabLeft,
		                })
		                New("Frame", {
		                    BackgroundTransparency = 1,
		                    LayoutOrder = 1,
		                    Parent = TabLeft,
		                })
		            end
		
		            TabRight = New("ScrollingFrame", {
		                AnchorPoint = Vector2.new(1, 0),
		                AutomaticCanvasSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                CanvasSize = UDim2.fromScale(0, 0),
		                Position = UDim2.fromScale(1, 0),
		                ScrollBarImageTransparency = 1,
		                ScrollBarThickness = 0,
		                Size = UDim2.new(0.5, -3, 1, 0),
		                Parent = TabContainer,
		            })
		            New("UIListLayout", {
		                Padding = UDim.new(0, 2),
		                Parent = TabRight,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 2),
		                PaddingLeft = UDim.new(0, 2),
		                PaddingRight = UDim.new(0, 2),
		                PaddingTop = UDim.new(0, 2),
		                Parent = TabRight,
		            })
		            do
		                New("Frame", {
		                    BackgroundTransparency = 1,
		                    LayoutOrder = -1,
		                    Parent = TabRight,
		                })
		                New("Frame", {
		                    BackgroundTransparency = 1,
		                    LayoutOrder = 1,
		                    Parent = TabRight,
		                })
		            end
		        end
		
		        --// Warning Box \\--
		        local WarningBoxHolder = New("Frame", {
		            AutomaticSize = Enum.AutomaticSize.Y,
		            BackgroundTransparency = 1,
		            Position = UDim2.fromOffset(0, 7),
		            Size = UDim2.fromScale(1, 0),
		            Visible = false,
		            Parent = TabContainer,
		        })
		
		        local WarningBox
		        local WarningBoxOutline
		        local WarningBoxShadowOutline
		        local WarningBoxScrollingFrame
		        local WarningTitle
		        local WarningStroke
		        local WarningText
		        do
		            WarningBox = New("Frame", {
		                BackgroundColor3 = "BackgroundColor",
		                Position = UDim2.fromOffset(2, 0),
		                Size = UDim2.new(1, -5, 0, 0),
		                Parent = WarningBoxHolder,
		            })
		            table.insert(
		                Library.Corners,
		                New("UICorner", {
		                    CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                    Parent = WarningBox,
		                })
		            )
		            WarningBoxOutline, WarningBoxShadowOutline = Library:AddOutline(WarningBox)
		
		            WarningBoxScrollingFrame = New("ScrollingFrame", {
		                BackgroundTransparency = 1,
		                BorderSizePixel = 0,
		                Size = UDim2.fromScale(1, 1),
		                CanvasSize = UDim2.new(0, 0, 0, 0),
		                ScrollBarThickness = 3,
		                ScrollingDirection = Enum.ScrollingDirection.Y,
		                Parent = WarningBox,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 4),
		                PaddingLeft = UDim.new(0, 6),
		                PaddingRight = UDim.new(0, 6),
		                PaddingTop = UDim.new(0, 4),
		                Parent = WarningBoxScrollingFrame,
		            })
		
		            WarningTitle = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, -4, 0, 14),
		                Text = "",
		                TextColor3 = Color3.fromRGB(255, 50, 50),
		                TextSize = 14,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                Parent = WarningBoxScrollingFrame,
		            })
		
		            WarningStroke = New("UIStroke", {
		                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
		                Color = Color3.fromRGB(169, 0, 0),
		                LineJoinMode = Enum.LineJoinMode.Miter,
		                Parent = WarningTitle,
		            })
		
		            WarningText = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Position = UDim2.fromOffset(0, 16),
		                Size = UDim2.new(1, -4, 0, 0),
		                Text = "",
		                TextSize = 14,
		                TextWrapped = true,
		                Parent = WarningBoxScrollingFrame,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                TextYAlignment = Enum.TextYAlignment.Top,
		            })
		
		            New("UIStroke", {
		                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
		                Color = "DarkColor",
		                LineJoinMode = Enum.LineJoinMode.Miter,
		                Parent = WarningText,
		            })
		        end
		
		        --// Tab Table \\--
		        local Tab = {
		            Groupboxes = {},
		            Tabboxes = {},
		            DependencyGroupboxes = {},
		            Description = Description,
		            Sides = {
		                TabLeft,
		                TabRight,
		            },
		            WarningBox = {
		                IsNormal = false,
		                LockSize = false,
		                Visible = false,
		                Title = "WARNING",
		                Text = "",
		            },
		        }
		
		        function Tab:UpdateWarningBox(Info)
		            if typeof(Info.IsNormal) == "boolean" then
		                Tab.WarningBox.IsNormal = Info.IsNormal
		            end
		            if typeof(Info.LockSize) == "boolean" then
		                Tab.WarningBox.LockSize = Info.LockSize
		            end
		            if typeof(Info.Visible) == "boolean" then
		                Tab.WarningBox.Visible = Info.Visible
		            end
		            if typeof(Info.Title) == "string" then
		                Tab.WarningBox.Title = Info.Title
		            end
		            if typeof(Info.Text) == "string" then
		                Tab.WarningBox.Text = Info.Text
		            end
		
		            WarningBoxHolder.Visible = Tab.WarningBox.Visible
		            WarningTitle.Text = Tab.WarningBox.Title
		            WarningText.Text = Tab.WarningBox.Text
		            Tab:Resize(true)
		
		            WarningBox.BackgroundColor3 = Tab.WarningBox.IsNormal == true and Library.Scheme.BackgroundColor
		                or Color3.fromRGB(127, 0, 0)
		
		            WarningBoxShadowOutline.Color = Tab.WarningBox.IsNormal == true and Library.Scheme.DarkColor
		                or Color3.fromRGB(85, 0, 0)
		            WarningBoxOutline.Color = Tab.WarningBox.IsNormal == true and Library.Scheme.OutlineColor
		                or Color3.fromRGB(255, 50, 50)
		
		            WarningTitle.TextColor3 = Tab.WarningBox.IsNormal == true and Library.Scheme.FontColor
		                or Color3.fromRGB(255, 50, 50)
		            WarningStroke.Color = Tab.WarningBox.IsNormal == true and Library.Scheme.OutlineColor
		                or Color3.fromRGB(169, 0, 0)
		
		            if not Library.Registry[WarningBox] then
		                Library:AddToRegistry(WarningBox, {})
		            end
		            if not Library.Registry[WarningBoxShadowOutline] then
		                Library:AddToRegistry(WarningBoxShadowOutline, {})
		            end
		            if not Library.Registry[WarningBoxOutline] then
		                Library:AddToRegistry(WarningBoxOutline, {})
		            end
		            if not Library.Registry[WarningTitle] then
		                Library:AddToRegistry(WarningTitle, {})
		            end
		            if not Library.Registry[WarningStroke] then
		                Library:AddToRegistry(WarningStroke, {})
		            end
		
		            Library.Registry[WarningBox].BackgroundColor3 = function()
		                return Tab.WarningBox.IsNormal == true and Library.Scheme.BackgroundColor or Color3.fromRGB(127, 0, 0)
		            end
		
		            Library.Registry[WarningBoxShadowOutline].Color = function()
		                return Tab.WarningBox.IsNormal == true and Library.Scheme.DarkColor or Color3.fromRGB(85, 0, 0)
		            end
		
		            Library.Registry[WarningBoxOutline].Color = function()
		                return Tab.WarningBox.IsNormal == true and Library.Scheme.OutlineColor or Color3.fromRGB(255, 50, 50)
		            end
		
		            Library.Registry[WarningTitle].TextColor3 = function()
		                return Tab.WarningBox.IsNormal == true and Library.Scheme.FontColor or Color3.fromRGB(255, 50, 50)
		            end
		
		            Library.Registry[WarningStroke].Color = function()
		                return Tab.WarningBox.IsNormal == true and Library.Scheme.OutlineColor or Color3.fromRGB(169, 0, 0)
		            end
		        end
		
		        function Tab:RefreshSides()
		            local Offset = WarningBoxHolder.Visible and WarningBox.Size.Y.Offset + 8 or 0
		            for _, Side in Tab.Sides do
		                Side.Position = UDim2.new(Side.Position.X.Scale, 0, 0, Offset)
		                Side.Size = UDim2.new(0.5, -3, 1, -Offset)
		            end
		        end
		
		        function Tab:Resize(ResizeWarningBox: boolean?)
		            if ResizeWarningBox then
		                local MaximumSize = math.floor(TabContainer.AbsoluteSize.Y / 3.25)
		                local _, YText = Library:GetTextBounds(
		                    WarningText.Text,
		                    Library.Scheme.Font,
		                    WarningText.TextSize,
		                    WarningText.AbsoluteSize.X
		                )
		
		                local YBox = 24 + YText
		                if Tab.WarningBox.LockSize == true and YBox >= MaximumSize then
		                    WarningBoxScrollingFrame.CanvasSize = UDim2.fromOffset(0, YBox)
		                    YBox = MaximumSize
		                else
		                    WarningBoxScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)
		                end
		
		                WarningText.Size = UDim2.new(1, -4, 0, YText)
		                WarningBox.Size = UDim2.new(1, -5, 0, YBox + 4)
		            end
		
		            Tab:RefreshSides()
		        end
		
		        function Tab:AddGroupbox(Info)
		            local BoxHolder = New("Frame", {
		                AutomaticSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 0),
		                Parent = Info.Side == 1 and TabLeft or TabRight,
		            })
		            New("UIListLayout", {
		                Padding = UDim.new(0, 6),
		                Parent = BoxHolder,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 4),
		                PaddingTop = UDim.new(0, 4),
		                Parent = BoxHolder,
		            })
		
		            local GroupboxHolder
		            local GroupboxLabel
		            local GroupboxContainer
		            local GroupboxList
		            local CollapseButton
		
		            do
		                GroupboxHolder = New("Frame", {
		                    BackgroundColor3 = "BackgroundColor",
		                    Size = UDim2.fromScale(1, 0),
		                    ClipsDescendants = true,
		                    Parent = BoxHolder,
		                })
		                table.insert(
		                    Library.Corners,
		                    New("UICorner", {
		                        CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                        Parent = GroupboxHolder,
		                    })
		                )
		                Library:AddOutline(GroupboxHolder)
		
		                Library:MakeLine(GroupboxHolder, {
		                    Position = UDim2.fromOffset(0, 34),
		                    Size = UDim2.new(1, 0, 0, 1),
		                })
		
		                local BoxIcon = Library:GetCustomIcon(Info.IconName)
		                if BoxIcon then
		                    New("ImageLabel", {
		                        Image = BoxIcon.Url,
		                        ImageColor3 = BoxIcon.Custom and "WhiteColor" or "AccentColor",
		                        ImageRectOffset = BoxIcon.ImageRectOffset,
		                        ImageRectSize = BoxIcon.ImageRectSize,
		                        Position = UDim2.fromOffset(6, 6),
		                        Size = UDim2.fromOffset(22, 22),
		                        Parent = GroupboxHolder,
		                    })
		                end
		
		                GroupboxLabel = New("TextLabel", {
		                    BackgroundTransparency = 1,
		                    Position = UDim2.fromOffset(BoxIcon and 24 or 0, 0),
		                    Size = UDim2.new(1, -30, 0, 34),
		                    Text = Info.Name,
		                    TextSize = 15,
		                    TextXAlignment = Enum.TextXAlignment.Left,
		                    Parent = GroupboxHolder,
		                })
		                New("UIPadding", {
		                    PaddingLeft = UDim.new(0, 12),
		                    PaddingRight = UDim.new(0, 12),
		                    Parent = GroupboxLabel,
		                })
		
		                local ArrowIcon = Library:GetIcon("chevron-up")
		                CollapseButton = New("ImageButton", {
		                    BackgroundTransparency = 1,
		                    AnchorPoint = Vector2.new(1, 0.5),
		                    Position = UDim2.new(1, -15, 0, 17),
		                    Size = UDim2.fromOffset(16, 16),
		                    Image = ArrowIcon and ArrowIcon.Url or "",
		                    ImageColor3 = "FontColor",
		                    ImageRectOffset = ArrowIcon and ArrowIcon.ImageRectOffset or Vector2.zero,
		                    ImageRectSize = ArrowIcon and ArrowIcon.ImageRectSize or Vector2.zero,
		                    ImageTransparency = 0.5,
		                    Rotation = 180,
		                    Parent = GroupboxHolder,
		                })
		
		                GroupboxContainer = New("Frame", {
		                    BackgroundTransparency = 1,
		                    Position = UDim2.fromOffset(0, 35),
		                    Size = UDim2.new(1, 0, 1, -35),
		                    Parent = GroupboxHolder,
		                })
		
		                GroupboxList = New("UIListLayout", {
		                    Padding = UDim.new(0, 8),
		                    Parent = GroupboxContainer,
		                })
		                New("UIPadding", {
		                    PaddingBottom = UDim.new(0, 7),
		                    PaddingLeft = UDim.new(0, 7),
		                    PaddingRight = UDim.new(0, 7),
		                    PaddingTop = UDim.new(0, 7),
		                    Parent = GroupboxContainer,
		                })
		            end
		
		            local Groupbox = {
		                BoxHolder = BoxHolder,
		                Holder = GroupboxHolder,
		                Container = GroupboxContainer,
		                Tab = Tab,
		                DependencyBoxes = {},
		                Elements = {},
		                Collapsed = false,
		            }
		
		            function Groupbox:Resize()
		                local TargetSize
		                if Groupbox.Collapsed then
		                    TargetSize = UDim2.new(1, 0, 0, 34)
		                else
		                    TargetSize = UDim2.new(1, 0, 0, (GroupboxList.AbsoluteContentSize.Y / Library.DPIScale) + 49)
		                end
		                
		                TweenService:Create(GroupboxHolder, Library.TweenInfo, {
		                    Size = TargetSize
		                }):Play()
		            end
		
		            GroupboxList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		                if not Groupbox.Collapsed then
		                    Groupbox:Resize()
		                end
		            end)
		
		            local function ToggleCollapse()
		                Groupbox.Collapsed = not Groupbox.Collapsed
		                
		                if not Groupbox.Collapsed then
		                    GroupboxContainer.Visible = true
		                end
		
		                TweenService:Create(CollapseButton, Library.TweenInfo, {Rotation = Groupbox.Collapsed and 0 or 180}):Play()
		                Groupbox:Resize()
		
		                if Groupbox.Collapsed then
		                    task.delay(Library.TweenInfo.Time, function()
		                        if Groupbox.Collapsed then
		                            GroupboxContainer.Visible = false
		                        end
		                    end)
		                end
		            end
		
		            CollapseButton.MouseButton1Click:Connect(ToggleCollapse)
		            
		            local HeaderClick = New("TextButton", {
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, -30, 0, 34),
		                Text = "",
		                Parent = GroupboxHolder,
		            })
		            HeaderClick.MouseButton1Click:Connect(ToggleCollapse)
		
		            setmetatable(Groupbox, BaseGroupbox)
		            Groupbox:Resize()
		            Tab.Groupboxes[Info.Name] = Groupbox
		
		            return Groupbox
		        end
		
		        function Tab:AddLeftGroupbox(Name, IconName)
		            return Tab:AddGroupbox({ Side = 1, Name = Name, IconName = IconName })
		        end
		
		        function Tab:AddRightGroupbox(Name, IconName)
		            return Tab:AddGroupbox({ Side = 2, Name = Name, IconName = IconName })
		        end
		
		        function Tab:AddTabbox(Info)
		            local BoxHolder = New("Frame", {
		                AutomaticSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 0),
		                Parent = Info.Side == 1 and TabLeft or TabRight,
		            })
		            New("UIListLayout", {
		                Padding = UDim.new(0, 6),
		                Parent = BoxHolder,
		            })
		            New("UIPadding", {
		                PaddingBottom = UDim.new(0, 4),
		                PaddingTop = UDim.new(0, 4),
		                Parent = BoxHolder,
		            })
		
		            local TabboxHolder
		            local TabboxButtons
		
		            do
		                TabboxHolder = New("Frame", {
		                    BackgroundColor3 = "BackgroundColor",
		                    Size = UDim2.fromScale(1, 0),
		                    Parent = BoxHolder,
		                })
		                table.insert(
		                    Library.Corners,
		                    New("UICorner", {
		                        CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                        Parent = TabboxHolder,
		                    })
		                )
		                Library:AddOutline(TabboxHolder)
		
		                TabboxButtons = New("Frame", {
		                    BackgroundTransparency = 1,
		                    Size = UDim2.new(1, 0, 0, 34),
		                    Parent = TabboxHolder,
		                })
		                New("UIListLayout", {
		                    FillDirection = Enum.FillDirection.Horizontal,
		                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
		                    Parent = TabboxButtons,
		                })
		            end
		
		            local TotalButtons, TotalTabs = 0, 1
		            local Tabbox = {
		                ActiveTab = nil,
		
		                BoxHolder = BoxHolder,
		                Holder = TabboxHolder,
		                Tabs = {}
		            }
		
		            function Tabbox:UpdateCorners()
		                for _, Tab in Tabbox.Tabs do
		                    Tab:UpdateCorners()
		                end
		            end
		
		            function Tabbox:AddTab(Name, IconName)
		                local TabIndex = TotalTabs
		
		                TotalButtons = TotalButtons + 1
		                TotalTabs = TotalTabs + 1
		
		                local BoxIcon = Library:GetCustomIcon(IconName)
		
		                local Button = New("TextButton", {
		                    BackgroundColor3 = "MainColor",
		                    BackgroundTransparency = 0,
		                    Size = UDim2.fromOffset(0, 34),
		                    Text = "",
		                    Parent = TabboxButtons,
		                })
		
		                table.insert(
		                    Library.Corners,
		                    New("UICorner", {
		                        CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                        Parent = Button,
		                    })
		                )
		
		                local BottomCover = New("Frame", {
		                    Name = "BottomCover",
		                    BackgroundColor3 = "MainColor",
		                    BorderSizePixel = 0,
		                    Position = UDim2.new(0, 0, 1, -WindowInfo.CornerRadius),
		                    Size = UDim2.new(1, 0, 0, WindowInfo.CornerRadius),
		                    Parent = Button,
		                })
		
		                local LeftCover = New("Frame", {
		                    Name = "LeftCover",
		                    BackgroundColor3 = "MainColor",
		                    BorderSizePixel = 0,
		                    Position = UDim2.new(0, 0, 0, 0),
		                    Size = UDim2.new(0, WindowInfo.CornerRadius, 1, 0),
		                    Visible = false,
		                    Parent = Button,
		                })
		
		                local RightCover = New("Frame", {
		                    Name = "RightCover",
		                    AnchorPoint = Vector2.new(1, 0),
		                    BackgroundColor3 = "MainColor",
		                    BorderSizePixel = 0,
		                    Position = UDim2.new(1, 0, 0, 0),
		                    Size = UDim2.new(0, WindowInfo.CornerRadius, 1, 0),
		                    Visible = false,
		                    Parent = Button,
		                })
		
		                local ButtonContent = New("Frame", {
		                    AnchorPoint = Vector2.new(0.5, 0.5),
		                    AutomaticSize = Enum.AutomaticSize.X,
		                    BackgroundTransparency = 1,
		                    Position = UDim2.fromScale(0.5, 0.5),
		                    Size = UDim2.fromOffset(0, 16),
		                    Parent = Button,
		                })
		                New("UIListLayout", {
		                    FillDirection = Enum.FillDirection.Horizontal,
		                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
		                    VerticalAlignment = Enum.VerticalAlignment.Center,
		                    Padding = UDim.new(0, 8),
		                    Parent = ButtonContent,
		                })
		
		                local ButtonIcon
		                if BoxIcon then
		                    ButtonIcon = New("ImageLabel", {
		                        Image = BoxIcon.Url,
		                        ImageColor3 = BoxIcon.Custom and "WhiteColor" or "AccentColor",
		                        ImageRectOffset = BoxIcon.ImageRectOffset,
		                        ImageRectSize = BoxIcon.ImageRectSize,
		                        ImageTransparency = 0.5,
		                        Size = UDim2.fromOffset(16, 16),
		                        Parent = ButtonContent,
		                    })
		                end
		
		                local ButtonLabel = New("TextLabel", {
		                    AutomaticSize = Enum.AutomaticSize.X,
		                    BackgroundTransparency = 1,
		                    Size = UDim2.fromOffset(0, 16),
		                    Text = Name,
		                    TextSize = 15,
		                    TextTransparency = 0.5,
		                    Parent = ButtonContent,
		                })
		
		                local Line = Library:MakeLine(Button, {
		                    AnchorPoint = Vector2.new(0, 1),
		                    Position = UDim2.new(0, 0, 1, 1),
		                    Size = UDim2.new(1, 0, 0, 1),
		                })
		
		                local Container = New("Frame", {
		                    BackgroundTransparency = 1,
		                    Position = UDim2.fromOffset(0, 35),
		                    Size = UDim2.new(1, 0, 1, -35),
		                    Visible = false,
		                    Parent = TabboxHolder,
		                })
		                local List = New("UIListLayout", {
		                    Padding = UDim.new(0, 8),
		                    Parent = Container,
		                })
		                New("UIPadding", {
		                    PaddingBottom = UDim.new(0, 7),
		                    PaddingLeft = UDim.new(0, 7),
		                    PaddingRight = UDim.new(0, 7),
		                    PaddingTop = UDim.new(0, 7),
		                    Parent = Container,
		                })
		
		                local Tab = {
		                    ButtonHolder = Button,
		                    Container = Container,
		
		                    ButtonCovers = {
		                        BottomCover = BottomCover,
		                        LeftCover = LeftCover,
		                        RightCover = RightCover
		                    },
		
		                    Tab = Tab,
		                    Elements = {},
		                    DependencyBoxes = {},
		                }
		
		                function Tab:Show()
		                    if Tabbox.ActiveTab then
		                        Tabbox.ActiveTab:Hide()
		                    end
		                    
		       local ClickSound = Instance.new("Sound")
		            ClickSound.SoundId = "rbxassetid://139804904213958"
		            ClickSound.Volume = 1
		            ClickSound.Parent = SoundService
		            ClickSound:Play()
		            ClickSound.Ended:Connect(function()
		                ClickSound:Destroy()
		            end)
		
		                    Button.BackgroundTransparency = 1
		                    BottomCover.BackgroundTransparency = 1
		                    LeftCover.BackgroundTransparency = 1
		                    RightCover.BackgroundTransparency = 1
		
		                    ButtonLabel.TextTransparency = 0
		                    if ButtonIcon then
		                        ButtonIcon.ImageTransparency = 0
		                    end
		                    Line.Visible = false
		
		                    Container.Visible = true
		
		                    Tabbox.ActiveTab = Tab
		                    Tab:Resize()
		                end
		
		                function Tab:Hide()
		                    Button.BackgroundTransparency = 0
		                    BottomCover.BackgroundTransparency = 0
		                    LeftCover.BackgroundTransparency = 0
		                    RightCover.BackgroundTransparency = 0
		
		                    ButtonLabel.TextTransparency = 0.5
		                    if ButtonIcon then
		                        ButtonIcon.ImageTransparency = 0.5
		                    end
		                    Line.Visible = true
		                    Container.Visible = false
		
		                    Tabbox.ActiveTab = nil
		                end
		
		                function Tab:Resize()
		                    if Tabbox.ActiveTab ~= Tab then
		                        return
		                    end
		
		                    TabboxHolder.Size = UDim2.new(1, 0, 0, (List.AbsoluteContentSize.Y / Library.DPIScale) + 49)
		                end
		
		                function Tab:UpdateCorners()
		                    LeftCover.Visible = TabIndex ~= 1
		                    RightCover.Visible = TabIndex ~= TotalButtons
		        
		                    BottomCover.Position = UDim2.new(0, 0, 1, -WindowInfo.CornerRadius)
		                    BottomCover.Size = UDim2.new(1, 0, 0, WindowInfo.CornerRadius)
		        
		                    LeftCover.Size = UDim2.new(0, WindowInfo.CornerRadius, 1, 0)
		                    RightCover.Size = UDim2.new(0, WindowInfo.CornerRadius, 1, 0)
		                end
		
		                --// Execution \\--
		                if not Tabbox.ActiveTab then
		                    Tab:Show()
		                end
		
		                Button.MouseButton1Click:Connect(Tab.Show)
		
		                setmetatable(Tab, BaseGroupbox)
		
		                Tabbox.Tabs[Name] = Tab
		                Tabbox:UpdateCorners()
		
		                return Tab
		            end
		
		            if Info.Name then
		                Tab.Tabboxes[Info.Name] = Tabbox
		            else
		                table.insert(Tab.Tabboxes, Tabbox)
		            end
		
		            return Tabbox
		        end
		
		        function Tab:AddLeftTabbox(Name)
		            return Tab:AddTabbox({ Side = 1, Name = Name })
		        end
		
		        function Tab:AddRightTabbox(Name)
		            return Tab:AddTabbox({ Side = 2, Name = Name })
		        end
		
		        function Tab:Hover(Hovering)
		            if Library.ActiveTab == Tab then
		                return
		            end
		
		            TweenService:Create(TabLabel, Library.TweenInfo, {
		                TextTransparency = Hovering and 0.25 or 0.5,
		            }):Play()
		            if TabIcon then
		                TweenService:Create(TabIcon, Library.TweenInfo, {
		                    ImageTransparency = Hovering and 0.25 or 0.5,
		                }):Play()
		            end
		        end
		
		        function Tab:Show()
		            if Library.ActiveTab then
		                Library.ActiveTab:Hide()
		            end
		
		            TweenService:Create(TabButton, Library.TweenInfo, {
		                BackgroundTransparency = 0.8,
		            }):Play()
		            TweenService:Create(TabLabel, Library.TweenInfo, { TextTransparency = 0, TextSize = 18 }):Play()
		            
		            if TabIcon then
		                TweenService:Create(TabIcon, Library.TweenInfo, { ImageTransparency = 0 }):Play()
		                
		                if IconScale then
		                    TweenService:Create(IconScale, Library.TweenInfo, { Scale = 1.15 }):Play() 
		                end
		            end
		            Window:ShowTabInfo(Name, Description or "")
		
		            TabContainer.Visible = true
		            Tab:RefreshSides()
		
		            Library.ActiveTab = Tab
		
		            if Library.Searching then
		                Library:UpdateSearch(Library.SearchText)
		            end
		        end
		
		        function Tab:Hide()
		            TweenService:Create(TabButton, Library.TweenInfo, {
		                BackgroundTransparency = 1,
		            }):Play()
		            TweenService:Create(TabLabel, Library.TweenInfo, { TextTransparency = 0.5, TextSize = 16 }):Play()
		            
		            if TabIcon then
		                TweenService:Create(TabIcon, Library.TweenInfo, { ImageTransparency = 0.5 }):Play()
		                
		                if IconScale then
		                    TweenService:Create(IconScale, Library.TweenInfo, { Scale = 1 }):Play()
		                end
		            end
		            TabContainer.Visible = false
		
		            Window:HideTabInfo()
		
		            Library.ActiveTab = nil
		        end
		
		        function Tab:SetVisible(Visible: boolean)
		            TabButton.Visible = Visible
		
		            if not Visible and Library.ActiveTab == Tab then
		                Tab:Hide()
		            end
		        end
		
		        --// Execution \\--
		        if not Library.ActiveTab then
		            Tab:Show()
		        end
		
		                TabButton.MouseEnter:Connect(function()
		            Tab:Hover(true)
		        end)
		        TabButton.MouseLeave:Connect(function()
		            Tab:Hover(false)
		        end)
		        
		        TabButton.MouseButton1Click:Connect(function()
		            local ClickSound = Instance.new("Sound")
		            ClickSound.SoundId = "rbxassetid://102702078778790"
		            ClickSound.Volume = 0.5
		            ClickSound.Parent = SoundService
		            ClickSound:Play()
		            ClickSound.Ended:Connect(function()
		                ClickSound:Destroy()
		            end)
		
		            Tab:Show()
		        end)
		
		        Library.Tabs[Name] = Tab
		
		        return Tab
		    end
		
		        function Window:AddKeyTab(...)
		        local Name = nil
		        local Icon = nil
		        local Description = nil
		
		        if select("#", ...) == 1 and typeof(...) == "table" then
		            local Info = select(1, ...)
		            Name = Info.Name or "Key"
		            Icon = Info.Icon
		            Description = Info.Description
		        else
		            Name = select(1, ...) or "Key"
		            Icon = select(2, ...)
		            Description = select(3, ...)
		        end
		
		        Icon = Icon or "key"
		
		        local TabButton
		        local TabLabel
		        local TabIcon
		        local TabContainer
		        local IconScale
		        local ButtonPadding
		
		        Icon = if Icon == "key" then KeyIcon else Library:GetCustomIcon(Icon)
		        
		        do
		            TabButton = New("TextButton", {
		                BackgroundColor3 = "AccentColor", 
		                BackgroundTransparency = 1,
		                Size = UDim2.new(1, -12, 0, 36), 
		                Text = "",
		                Parent = Tabs,
		            })
		            
		            table.insert(Library.Corners, New("UICorner", {
		                CornerRadius = UDim.new(0, 8),
		                Parent = TabButton,
		            }))
		            
		            ButtonPadding = New("UIPadding", {
		                PaddingBottom = UDim.new(0, 6),
		                PaddingLeft = UDim.new(0, 8),
		                PaddingRight = UDim.new(0, 8),
		                PaddingTop = UDim.new(0, 6),
		                Parent = TabButton,
		            })
		
		            TabLabel = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Position = UDim2.fromOffset(30, 0),
		                Size = UDim2.new(1, -30, 1, 0),
		                Text = Name,
		                TextSize = 16,
		                TextTransparency = 0.5,
		                TextXAlignment = Enum.TextXAlignment.Left,
		                Visible = not IsCompact,
		                Parent = TabButton,
		            })
		
		            if Icon then
		                TabIcon = New("ImageLabel", {
		                    Image = Icon.Url,
		                    ImageColor3 = Icon.Custom and "WhiteColor" or "AccentColor",
		                    ImageRectOffset = Icon.ImageRectOffset,
		                    ImageRectSize = Icon.ImageRectSize,
		                    ImageTransparency = 0.5,
		                    ScaleType = Enum.ScaleType.Fit,
		                    Size = UDim2.fromScale(1, 1),
		                    SizeConstraint = Enum.SizeConstraint.RelativeYY, 
		                    Parent = TabButton,
		                })
		                
		                IconScale = New("UIScale", {
		                    Scale = 1,
		                    Parent = TabIcon,
		                })
		            end
		
		            table.insert(Library.TabButtons, { Label = TabLabel, Padding = ButtonPadding, Icon = TabIcon })
		
		            TabContainer = New("ScrollingFrame", {
		                AutomaticCanvasSize = Enum.AutomaticSize.Y,
		                BackgroundTransparency = 1,
		                CanvasSize = UDim2.fromScale(0, 0),
		                ScrollBarThickness = 0,
		                Size = UDim2.fromScale(1, 1),
		                Visible = false,
		                Parent = Container,
		            })
		            
		            New("UIListLayout", {
		                HorizontalAlignment = Enum.HorizontalAlignment.Center,
		                VerticalAlignment = Enum.VerticalAlignment.Top,
		                Padding = UDim.new(0, 0),
		                Parent = TabContainer,
		            })
		
		            New("UIPadding", {
		                PaddingTop = UDim.new(0, 20),
		                PaddingBottom = UDim.new(0, 20),
		                Parent = TabContainer,
		            })
		
		        end
		
		        local Tab = {
		            Elements = {},
		            Description = Description,
		            IsKeyTab = true,
		            Container = TabContainer,
		        }
		
		function Tab:SetupKeySystem(Info)
		    local VerifyCallback = Info.Callback or function() end
		    local GetKeyCallback = Info.GetKeyCallback
		    
		    local KeyCard = New("Frame", {
		        BackgroundColor3 = "BackgroundColor",
		        Size = UDim2.new(0, 320, 0, 0),
		        AutomaticSize = Enum.AutomaticSize.Y,
		        Parent = TabContainer,
		    })
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = KeyCard }))
		    Library:AddOutline(KeyCard)
		
		    New("UIPadding", {
		        PaddingBottom = UDim.new(0, 14), PaddingLeft = UDim.new(0, 14),
		        PaddingRight = UDim.new(0, 14), PaddingTop = UDim.new(0, 14),
		        Parent = KeyCard,
		    })
		    New("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = KeyCard })
		
		    local HeaderFrame = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = 1, Parent = KeyCard })
		    local HeaderIcon = Library:GetCustomIcon("lock") or {Url = "rbxassetid://102639104920386", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.new(100, 100)}
		    
		    New("ImageLabel", { 
		        BackgroundTransparency = 1, Image = HeaderIcon.Url, ImageRectOffset = HeaderIcon.ImageRectOffset or Vector2.zero, 
		        ImageRectSize = HeaderIcon.ImageRectSize or Vector2.new(100, 100), ImageColor3 = Library.Scheme.AccentColor, 
		        Size = UDim2.fromOffset(20, 20), Parent = HeaderFrame 
		    })
		    New("TextLabel", { 
		        BackgroundTransparency = 1, Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -28, 1, 0), 
		        Text = Info.Title or "Authentication", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, Parent = HeaderFrame 
		    })
		
		    local DescLabel = New("TextLabel", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 14), Text = Info.Description or "", TextSize = 13, TextTransparency = 0.4, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 2, Parent = KeyCard })
		
		    local InputHolder = New("Frame", { BackgroundColor3 = "MainColor", Size = UDim2.new(1, 0, 0, 34), LayoutOrder = 3, Parent = KeyCard })
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = InputHolder }))
		    New("UIStroke", { Color = "OutlineColor", Parent = InputHolder })
		    local KeyInput = New("TextBox", { BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(1, -20, 1, 0), PlaceholderText = "Enter key...", Text = "", TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = InputHolder })
		
		    local function AddPremiumButton(Text, ParentObj, Color, LayoutOrderNum, Callback)
		        local Btn = New("TextButton", {
		            BackgroundColor3 = Color,
		            Size = UDim2.new(0, 0, 0, 28),
		            AutomaticSize = Enum.AutomaticSize.X,
		            Text = "  " .. Text .. "  ",
		            TextSize = 12,
		            TextColor3 = Color3.fromRGB(255, 255, 255),
		            AutoButtonColor = false,
		            LayoutOrder = LayoutOrderNum,
		            Parent = ParentObj
		        })
		        New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = Btn })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = Btn }))
		        New("UIStroke", { Color = "OutlineColor", Transparency = 0.5, Parent = Btn })
		        
		        Btn.MouseEnter:Connect(function() TweenService:Create(Btn, Library.TweenInfo, {BackgroundColor3 = Library:GetBetterColor(Color, 15)}):Play() end)
		        Btn.MouseLeave:Connect(function() TweenService:Create(Btn, Library.TweenInfo, {BackgroundColor3 = Color}):Play() end)
		        Btn.MouseButton1Click:Connect(Callback)
		    end
		
		    local ActionRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 4, Parent = KeyCard })
		    New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = ActionRow })
		    
		    if GetKeyCallback then AddPremiumButton("Get Key", ActionRow, Library.Scheme.MainColor, 1, GetKeyCallback) end
		    AddPremiumButton("Verify Key", ActionRow, Library.Scheme.AccentColor, 2, function() Library:SafeCallback(VerifyCallback, KeyInput.Text, DescLabel) end)
		
		    if Info.HWIDReset and Info.HWIDReset.Enabled then
		        New("Frame", { BackgroundColor3 = "OutlineColor", BackgroundTransparency = 0.5, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 5, Parent = KeyCard })
		        
		        local HWIDHolder = New("Frame", { BackgroundColor3 = "MainColor", Size = UDim2.new(1, 0, 0, 32), LayoutOrder = 6, Parent = KeyCard })
		        table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = HWIDHolder }))
		        New("UIStroke", { Color = "OutlineColor", Parent = HWIDHolder })
		        local HWIDInput = New("TextBox", { BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(1, -20, 1, 0), PlaceholderText = "Paste HWID Key...", Text = "", TextSize = 13, Parent = HWIDHolder })
		        
		        local ResetBtnWrapper = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 7, Parent = KeyCard })
		        New("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = ResetBtnWrapper })
		        
		        AddPremiumButton(Info.HWIDReset.ButtonText or "Reset HWID", ResetBtnWrapper, Library.Scheme.MainColor, 1, function() 
		    if Info.HWIDReset.Callback then 
		                Library:SafeCallback(Info.HWIDReset.Callback, HWIDInput.Text, DescLabel)
		            end
		        end)
		    end
		
		    return KeyInput
		end
		
		        function Tab:RefreshSides() end
		        function Tab:Resize() end
		        function Tab:UpdateCorners() end
		
		        function Tab:Hover(Hovering)
		            if Library.ActiveTab == Tab then return end
		            TweenService:Create(TabLabel, Library.TweenInfo, { TextTransparency = Hovering and 0.25 or 0.5 }):Play()
		            if TabIcon then TweenService:Create(TabIcon, Library.TweenInfo, { ImageTransparency = Hovering and 0.25 or 0.5 }):Play() end
		        end
		
		        function Tab:Show()
		            if Library.ActiveTab then Library.ActiveTab:Hide() end
		
		            TweenService:Create(TabButton, Library.TweenInfo, { BackgroundTransparency = 0.8 }):Play()
		            
		            TweenService:Create(TabLabel, Library.TweenInfo, { TextTransparency = 0, TextSize = 18 }):Play()
		            
		            if TabIcon then 
		                TweenService:Create(TabIcon, Library.TweenInfo, { ImageTransparency = 0 }):Play() 
		                if IconScale then
		                    TweenService:Create(IconScale, Library.TweenInfo, { Scale = 1.15 }):Play() 
		                end
		            end
		            
		            TabContainer.Position = UDim2.new(0, 0, 0, 15)
		            TabContainer.Visible = true
		            TweenService:Create(TabContainer, Library.TweenInfo, { Position = UDim2.new(0, 0, 0, 0) }):Play()
		
		            if Description then Window:ShowTabInfo(Name, Description) end
		            Library.ActiveTab = Tab
		            if Library.Searching then Library:UpdateSearch(Library.SearchText) end
		        end
		
		        function Tab:Hide()
		            TweenService:Create(TabButton, Library.TweenInfo, { BackgroundTransparency = 1 }):Play()
		            
		            TweenService:Create(TabLabel, Library.TweenInfo, { TextTransparency = 0.5, TextSize = 16 }):Play()
		            
		            if TabIcon then 
		                TweenService:Create(TabIcon, Library.TweenInfo, { ImageTransparency = 0.5 }):Play() 
		                if IconScale then
		                    TweenService:Create(IconScale, Library.TweenInfo, { Scale = 1 }):Play()
		                end
		            end
		            
		            TabContainer.Visible = false
		            Window:HideTabInfo()
		            Library.ActiveTab = nil
		        end
		
		        function Tab:SetVisible(Visible: boolean)
		            TabButton.Visible = Visible
		            if not Visible and Library.ActiveTab == Tab then Tab:Hide() end
		        end
		
		        if not Library.ActiveTab then Tab:Show() end
		
		        TabButton.MouseEnter:Connect(function() Tab:Hover(true) end)
		        TabButton.MouseLeave:Connect(function() Tab:Hover(false) end)
		        TabButton.MouseButton1Click:Connect(function()
		            local ClickSound = Instance.new("Sound")
		            ClickSound.SoundId = "rbxassetid://139804904213958"
		            ClickSound.Volume = 0.5
		            ClickSound.Parent = SoundService
		            ClickSound:Play()
		            ClickSound.Ended:Connect(function()
		                ClickSound:Destroy()
		            end)
		
		            Tab:Show()
		        end)
		
		        setmetatable(Tab, BaseGroupbox)
		        Library.Tabs[Name] = Tab
		
		        return Tab
		    end
		
		    function Window:AddDialog(Idx, Info)
		        Info = Library:Validate(Info, Templates.Dialog)
		
		        local DialogFrame
		        local DialogOverlay
		        local DialogContainer
		        local ButtonsHolder
		        local FooterButtonsList = {}
		
		        DialogOverlay = New("TextButton", {
		            AutoButtonColor = false,
		            BackgroundColor3 = "DarkColor",
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 1),
		            Text = "",
		            Active = false,
		            ZIndex = 9000,
		            Visible = true,
		            Parent = MainFrame,
		        })
		        TweenService:Create(DialogOverlay, Library.TweenInfo, {
		            BackgroundTransparency = 0.5,
		        }):Play()
		
		        DialogFrame = New("TextButton", {
		            AnchorPoint = Vector2.new(0.5, 0.5),
		            BackgroundColor3 = "BackgroundColor",
		            Position = UDim2.fromScale(0.5, 0.5),
		            Size = UDim2.fromOffset(300, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Text = "",
		            AutoButtonColor = false,
		            ZIndex = 9001,
		            Parent = DialogOverlay,
		        })
		        table.insert(
		            Library.Corners,
		            New("UICorner", {
		                CornerRadius = UDim.new(0, WindowInfo.CornerRadius),
		                Parent = DialogFrame,
		            })
		        )
		        Library:AddOutline(DialogFrame)
		
		        local InnerContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            ZIndex = 9002,
		            Parent = DialogFrame,
		        })
		        local DialogScale = New("UIScale", {
		            Scale = 0.95,
		            Parent = DialogFrame,
		        })
		        TweenService:Create(DialogScale, Library.TweenInfo, {
		            Scale = 1
		        }):Play()
		        local _InnerPadding = New("UIPadding", {
		            PaddingBottom = UDim.new(0, 15),
		            PaddingLeft = UDim.new(0, 15),
		            PaddingRight = UDim.new(0, 15),
		            PaddingTop = UDim.new(0, 15),
		            Parent = InnerContainer,
		        })
		        local _InnerLayout = New("UIListLayout", {
		            Padding = UDim.new(0, 10),
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = InnerContainer,
		        })
		
		        local HeaderContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            LayoutOrder = 1,
		            ZIndex = 9002,
		            Parent = InnerContainer,
		        })
		        New("UIListLayout", {
		            Padding = UDim.new(0, 6),
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = HeaderContainer,
		        })
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 5),
		            Parent = HeaderContainer,
		        })
		
		        local TitleRow = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 20),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            LayoutOrder = 1,
		            ZIndex = 9002,
		            Parent = HeaderContainer,
		        })
		        New("UIListLayout", {
		            Padding = UDim.new(0, 6),
		            FillDirection = Enum.FillDirection.Horizontal,
		            VerticalAlignment = Enum.VerticalAlignment.Center,
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = TitleRow,
		        })
		
		        if Info.Icon then
		            local ParsedIcon = Library:GetCustomIcon(Info.Icon)
		            if ParsedIcon then
		                local IconImg = New("ImageLabel", {
		                    BackgroundTransparency = 1,
		                    Size = UDim2.fromOffset(16, 16),
		                    Image = ParsedIcon.Url,
		                    ImageColor3 = "FontColor",
		                    ImageRectOffset = ParsedIcon.ImageRectOffset,
		                    ImageRectSize = ParsedIcon.ImageRectSize,
		                    LayoutOrder = 1,
		                    ZIndex = 9002,
		                    Parent = TitleRow,
		                })
		                if Info.TitleColor then
		                    IconImg.ImageColor3 = Info.TitleColor
		                end
		            end
		        end
		
		        local TitleLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 18),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Text = Info.Title,
		            TextSize = 18,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            LayoutOrder = 2,
		            ZIndex = 9002,
		            Parent = TitleRow,
		        })
		        if Info.TitleColor then
		            TitleLabel.TextColor3 = Info.TitleColor
		        end
		
		        local DescriptionLabel = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 14),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            Text = Info.Description,
		            TextSize = 14,
		            TextTransparency = Info.DescriptionColor and 0 or 0.2,
		            TextXAlignment = Enum.TextXAlignment.Left,
		            TextWrapped = true,
		            LayoutOrder = 2,
		            ZIndex = 9002,
		            Parent = HeaderContainer,
		        })
		        if Info.DescriptionColor then
		            DescriptionLabel.TextColor3 = Info.DescriptionColor
		        end
		
		        DialogContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromScale(1, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            LayoutOrder = 4,
		            ZIndex = 9002,
		            Parent = InnerContainer,
		        })
		        local _DialogContainerLayout = New("UIListLayout", {
		            Padding = UDim.new(0, 8),
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = DialogContainer,
		        })
		        New("UIPadding", {
		            PaddingBottom = UDim.new(0, 5),
		            Parent = DialogContainer,
		        })
		        
		        local _Sep2 = New("Frame", {
		            BackgroundColor3 = "OutlineColor",
		            BackgroundTransparency = 0,
		            BorderSizePixel = 0,
		            Size = UDim2.new(1, 0, 0, 1),
		            LayoutOrder = 5,
		            ZIndex = 9002,
		            Parent = InnerContainer,
		        })
		
		        ButtonsHolder = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.new(1, 0, 0, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            LayoutOrder = 6,
		            ZIndex = 9002,
		            Parent = InnerContainer,
		        })
		        New("UIListLayout", {
		            Padding = UDim.new(0, 8),
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Right,
		            Wraps = true,
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = ButtonsHolder,
		        })
		        New("UIPadding", {
		            PaddingTop = UDim.new(0, 5),
		            Parent = ButtonsHolder,
		        })
		
		        local Dialog = {
		            Elements = {},
		            Container = DialogContainer,
		        }
		
		        function Dialog:Resize()
		            local MaxWidth = MainFrame.AbsoluteSize.X * 0.75
		            local MinWidth = 400
		
		            local TotalButtonWidth = 0
		            local ButtonCount = 0
		            local HasButtons = false
		
		            for _, BtnWrap in FooterButtonsList do
		                HasButtons = true
		                ButtonCount = ButtonCount + 1
		                TotalButtonWidth = TotalButtonWidth + BtnWrap.Container.Size.X.Offset
		            end
		
		            local TargetWidth = MinWidth
		            if HasButtons then
		                local RequiredWidth = TotalButtonWidth + ((ButtonCount - 1) * 8) + 30
		                TargetWidth = math.max(MinWidth, math.min(RequiredWidth, MaxWidth))
		            end
		
		            DialogFrame.Size = UDim2.fromOffset(TargetWidth, 0)
		
		            local _DescX, DescY = Library:GetTextBounds(DescriptionLabel.Text, Library.Scheme.Font, 14, TargetWidth - 30)
		            DescriptionLabel.Size = UDim2.new(1, 0, 0, DescY)
		
		            local HasElements = false
		            for _, v in DialogContainer:GetChildren() do
		                if not v:IsA("UIListLayout") and not v:IsA("UIPadding") then
		                    HasElements = true
		                    break
		                end
		            end
		            DialogContainer.Visible = HasElements
		
		            ButtonsHolder.Visible = HasButtons
		            _Sep2.Visible = HasButtons
		        end
		
		        function Dialog:SetTitle(Title)
		            TitleLabel.Text = Title
		            Dialog:Resize()
		        end
		
		        function Dialog:SetDescription(Description)
		            DescriptionLabel.Text = Description
		            Dialog:Resize()
		        end
		
		        function Dialog:Dismiss()
		            Library.ActiveDialog = nil
		            local CloseTween = TweenService:Create(DialogScale, Library.TweenInfo, { Scale = 0.95 })
		            TweenService:Create(DialogOverlay, Library.TweenInfo, { BackgroundTransparency = 1 }):Play()
		            CloseTween:Play()
		            
		            task.delay(Library.TweenInfo.Time, function()
		                DialogOverlay:Destroy()
		            end)
		            Library.Dialogues[Idx] = nil
		        end
		
		        DialogOverlay.MouseButton1Click:Connect(function()
		            if Info.OutsideClickDismiss then
		                Dialog:Dismiss()
		            end
		        end)
		
		        function Dialog:RemoveFooterButton(ButtonIdx)
		            if FooterButtonsList[ButtonIdx] then
		                FooterButtonsList[ButtonIdx].Container:Destroy()
		                FooterButtonsList[ButtonIdx] = nil
		            end
		        end
		
		        function Dialog:SetButtonDisabled(ButtonIdx, Disabled)
		            if FooterButtonsList[ButtonIdx] and type(FooterButtonsList[ButtonIdx].SetDisabled) == "function" then
		                FooterButtonsList[ButtonIdx]:SetDisabled(Disabled)
		            end
		        end
		
		        function Dialog:SetButtonOrder(ButtonIdx, Order)
		            if FooterButtonsList[ButtonIdx] and FooterButtonsList[ButtonIdx].Container then
		                FooterButtonsList[ButtonIdx].Container.LayoutOrder = Order
		            end
		        end
		
		        function Dialog:AddFooterButton(ButtonIdx, ButtonInfo)
		            Dialog:RemoveFooterButton(ButtonIdx)
		
		            local WaitTime = ButtonInfo.WaitTime or 0
		
		            local ButtonContainer = New("Frame", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromOffset(0, 26),
		                LayoutOrder = ButtonInfo.Order or 0,
		                ZIndex = 9002,
		                Parent = ButtonsHolder,
		            })
		            
		            local BtnColor = "MainColor"
		            local BtnOutline = "OutlineColor"
		            local Variant = ButtonInfo.Variant or "Primary"
		            
		            if Variant == "Primary" then
		                BtnColor = "FontColor"
		                BtnOutline = "FontColor"
		            elseif Variant == "Secondary" then
		                BtnColor = "MainColor"
		                BtnOutline = "OutlineColor"
		            elseif Variant == "Destructive" then
		                BtnColor = "DestructiveColor"
		                BtnOutline = "DestructiveColor"
		            elseif Variant == "Ghost" then
		                BtnColor = "BackgroundColor"
		                BtnOutline = "BackgroundColor"
		            end
		
		            local TextBtn = New("TextButton", {
		                BackgroundColor3 = BtnColor,
		                BorderColor3 = BtnOutline,
		                BackgroundTransparency = WaitTime > 0 and 0.5 or 0,
		                Size = UDim2.fromOffset(0, 26),
		                Text = "",
		                AutoButtonColor = false,
		                ZIndex = 9002,
		                Parent = ButtonContainer,
		            })
		            Library:AddOutline(TextBtn)
		            table.insert(
		                Library.Corners,
		                New("UICorner", { 
		                    CornerRadius = UDim.new(0, Library.CornerRadius), 
		                    Parent = TextBtn 
		                })
		            )
		
		            local _BtnPadding = New("UIPadding", {
		                PaddingLeft = UDim.new(0, 15),
		                PaddingRight = UDim.new(0, 15),
		                Parent = TextBtn,
		            })
		
		            local TextColor = Library.Scheme.FontColor
		            if Variant == "Primary" then
		                TextColor = Library.Scheme.BackgroundColor
		            elseif Variant == "Destructive" then
		                TextColor = Color3.new(1, 1, 1)
		            end
		            
		            local BtnLabel = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 1),
		                Text = ButtonInfo.Title or ButtonIdx,
		                TextColor3 = TextColor,
		                TextTransparency = WaitTime > 0 and 0.5 or 0,
		                TextSize = 14,
		                ZIndex = 9002,
		                Parent = TextBtn,
		            })
		            
		            local LabelX, _ = Library:GetTextBounds(BtnLabel.Text, Library.Scheme.Font, 14, 250)
		            ButtonContainer.Size = UDim2.fromOffset(LabelX + 30, 26)
		            TextBtn.Size = UDim2.fromOffset(LabelX + 30, 26)
		
		            local ProgressBar
		            if WaitTime > 0 then
		                ProgressBar = New("Frame", {
		                    BackgroundColor3 = "AccentColor",
		                    BorderSizePixel = 0,
		                    Position = UDim2.new(0, 0, 1, -2),
		                    Size = UDim2.new(0, 0, 0, 2),
		                    ZIndex = 2,
		                    Parent = TextBtn,
		                })
		                table.insert(
		                    Library.Corners,
		                    New("UICorner", { 
		                        CornerRadius = UDim.new(0, Library.CornerRadius), 
		                        Parent = ProgressBar 
		                    })
		                )
		            end
		
		            local IsActive = WaitTime <= 0
		
		            local ButtonWrap = {
		                Container = ButtonContainer,
		                SetDisabled = function(self, Disabled)
		                    IsActive = not Disabled
		                    if Disabled then
		                        TweenService:Create(TextBtn, Library.TweenInfo, { BackgroundTransparency = 0.5 }):Play()
		                        TweenService:Create(BtnLabel, Library.TweenInfo, { TextTransparency = 0.5 }):Play()
		                    else
		                        TweenService:Create(TextBtn, Library.TweenInfo, { BackgroundTransparency = 0 }):Play()
		                        TweenService:Create(BtnLabel, Library.TweenInfo, { TextTransparency = 0 }):Play()
		                    end
		                end
		            }
		
		            local ActiveColor = typeof(BtnColor) == "Color3" and BtnColor or Library.Scheme[BtnColor]
		            local HoverColor = Variant == "Ghost" and Library.Scheme.MainColor or Library:GetBetterColor(ActiveColor, 10)
		
		            TextBtn.MouseEnter:Connect(function()
		                if not IsActive then return end
		                TweenService:Create(TextBtn, Library.TweenInfo, {
		                    BackgroundColor3 = HoverColor
		                }):Play()
		            end)
		            TextBtn.MouseLeave:Connect(function()
		                if not IsActive then return end
		                TweenService:Create(TextBtn, Library.TweenInfo, {
		                    BackgroundColor3 = ActiveColor
		                }):Play()
		            end)
		
		            TextBtn.MouseButton1Click:Connect(function()
		                if not IsActive then return end
		                if ButtonInfo.Callback then
		                    ButtonInfo.Callback(Dialog)
		                end
		                if Info.AutoDismiss then
		                    Dialog:Dismiss()
		                end
		            end)
		
		            if WaitTime > 0 then
		                TweenService:Create(ProgressBar, TweenInfo.new(WaitTime, Enum.EasingStyle.Linear), {
		                    Size = UDim2.new(1, 0, 0, 2)
		                }):Play()
		                
		                task.delay(WaitTime, function()
		                    ButtonWrap:SetDisabled(false)
		                    if ProgressBar then
		                        TweenService:Create(ProgressBar, Library.TweenInfo, {
		                            BackgroundTransparency = 1
		                        }):Play()
		                    end
		                end)
		            end
		
		            FooterButtonsList[ButtonIdx] = ButtonWrap
		        end
		
		        for BIdx, BInfo in Info.FooterButtons do
		            if type(BIdx) == "number" and BInfo.Id then BIdx = BInfo.Id end
		            Dialog:AddFooterButton(BIdx, BInfo)
		        end
		
		        setmetatable(Dialog, BaseGroupbox)
		        Library.Dialogues[Idx] = Dialog
		
		        Dialog:Resize()
		        
		        Library.ActiveDialog = Dialog
		        return Dialog
		    end
		
		    function Window:Toggle(Value: boolean?)
		        if Library.ActiveLoading then
		            if Value == true then
		                return
		            end
		
		            if not Library.Toggled then
		                return
		            end
		        end
		
		        if typeof(Value) == "boolean" then
		            Library.Toggled = Value
		        else
		            Library.Toggled = not Library.Toggled
		        end
		
		        MainFrame.Visible = Library.Toggled
		
		        if WindowInfo.UnlockMouseWhileOpen then
		            ModalElement.Modal = Library.Toggled
		        end
		
		        if Library.Toggled and not Library.IsMobile then
		            local OldMouseIconEnabled = UserInputService.MouseIconEnabled
		            local ShowCursorBinding = Library.ShowCursorBinding
		            pcall(function()
		                RunService:UnbindFromRenderStep(ShowCursorBinding)
		            end)
		            RunService:BindToRenderStep(ShowCursorBinding, Enum.RenderPriority.Last.Value, function()
		                UserInputService.MouseIconEnabled = not Library.ShowCustomCursor
		
		                Cursor.Position = UDim2.fromOffset(Mouse.X, Mouse.Y)
		                Cursor.Visible = Library.ShowCustomCursor
		
		                if not (Library.Toggled and ScreenGui and ScreenGui.Parent) then
		                    UserInputService.MouseIconEnabled = OldMouseIconEnabled
		                    Cursor.Visible = false
		                    RunService:UnbindFromRenderStep(ShowCursorBinding)
		                end
		            end)
		        elseif not Library.Toggled then
		            TooltipLabel.Visible = false
		
		            for _, Option in Library.Options do
		                if Option.Type == "ColorPicker" then
		                    Option.ColorMenu:Close()
		                    Option.ContextMenu:Close()
		                elseif Option.Type == "Dropdown" or Option.Type == "KeyPicker" then
		                    Option.Menu:Close()
		                end
		            end
		        end
		    end
		
		    function Library:Toggle(Value: boolean?)
		        return Window:Toggle(Value)
		    end
		
		    if WindowInfo.EnableSidebarResize then
		        local Threshold = (WindowInfo.MinSidebarWidth + WindowInfo.SidebarCompactWidth) * WindowInfo.SidebarCollapseThreshold
		        local StartPos, StartWidth
		        local Dragging = false
		        local Changed
		
		        local SidebarGrabber = New("TextButton", {
		            AnchorPoint = Vector2.new(0.5, 0),
		            BackgroundTransparency = 1,
		            Position = UDim2.fromScale(0.5, 0),
		            Size = UDim2.new(0, 8, 1, 0),
		            Text = "",
		            Parent = DividerLine,
		        })
		        SidebarGrabber.MouseEnter:Connect(function()
		            TweenService:Create(DividerLine, Library.TweenInfo, {
		                BackgroundColor3 = Library:GetLighterColor(Library.Scheme.OutlineColor),
		            }):Play()
		        end)
		        SidebarGrabber.MouseLeave:Connect(function()
		            if Dragging then
		                return
		            end
		            TweenService:Create(DividerLine, Library.TweenInfo, {
		                BackgroundColor3 = Library.Scheme.OutlineColor,
		            }):Play()
		        end)
		
		        SidebarGrabber.InputBegan:Connect(function(Input: InputObject)
		            if not IsClickInput(Input) then
		                return
		            end
		
		            Library.CantDragForced = true
		
		            StartPos = Input.Position
		            StartWidth = Window:GetSidebarWidth()
		            Dragging = true
		
		            Changed = Input.Changed:Connect(function()
		                if Input.UserInputState ~= Enum.UserInputState.End then
		                    return
		                end
		
		                Library.CantDragForced = false
		                TweenService:Create(DividerLine, Library.TweenInfo, {
		                    BackgroundColor3 = Library.Scheme.OutlineColor,
		                }):Play()
		
		                Dragging = false
		                if Changed and Changed.Connected then
		                    Changed:Disconnect()
		                    Changed = nil
		                end
		            end)
		        end)
		
		        Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input: InputObject)
		            if not Library.Toggled or not (ScreenGui and ScreenGui.Parent) then
		                Dragging = false
		                if Changed and Changed.Connected then
		                    Changed:Disconnect()
		                    Changed = nil
		                end
		
		                return
		            end
		
		            if Dragging and IsHoverInput(Input) then
		                local Delta = Input.Position - StartPos
		                local Width = StartWidth + Delta.X
		
		                if WindowInfo.DisableCompactingSnap then
		                    Window:SetSidebarWidth(Width)
		                    return
		                end
		
		                if Width > Threshold then
		                    Window:SetSidebarWidth(math.max(Width, WindowInfo.MinSidebarWidth))
		                else
		                    Window:SetSidebarWidth(WindowInfo.SidebarCompactWidth)
		                end
		            end
		        end))
		    end
		    if WindowInfo.EnableCompacting and WindowInfo.SidebarCompacted then
		        Window:SetSidebarWidth(WindowInfo.SidebarCompactWidth)
		    end
		    if WindowInfo.AutoShow and not Library.ActiveLoading then
		        task.spawn(Library.Toggle)
		    end
		
		        if Library.IsMobile then
		        local iconUrl = "rbxassetid://121088593459735" 
		        
		        if WindowInfo.Icon then
		            local iconStr = tostring(WindowInfo.Icon)
		            
		            if string.find(iconStr, "rbxassetid://") or string.find(iconStr, "http") then
		                iconUrl = iconStr
		            else
		                iconUrl = "rbxassetid://" .. iconStr
		            end
		        end
		
		        local holdStart = 0
		        local isHolding = false
		        local isHidden = false
		        local TS = game:GetService("TweenService")
		
		        local ToggleButton = Library:AddDraggableButton(iconUrl, function()
		            if tick() - holdStart < 2 then
		                Library:Toggle()
		            end
		        end, true)
		
		        ToggleButton.Button.InputBegan:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		                isHolding = true
		                holdStart = tick()
		                
		                task.spawn(function()
		                    task.wait(2)
		                    
		                    if isHolding and (tick() - holdStart) >= 1.9 then
		                        isHidden = not isHidden
		                        
		                        local targetTrans = isHidden and 1 or 0
		                        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		                        
		                        TS:Create(ToggleButton.Button, tweenInfo, {
		                            BackgroundTransparency = targetTrans,
		                            ImageTransparency = targetTrans
		                        }):Play()
		                        
		                        for _, child in pairs(ToggleButton.Button:GetChildren()) do
		                            if child:IsA("UIStroke") then
		                                TS:Create(child, tweenInfo, {Transparency = targetTrans}):Play()
		                            end
		                        end
		                    end
		                end)
		            end
		        end)
		
		        ToggleButton.Button.InputEnded:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		                isHolding = false
		            end
		        end)
		
		        if WindowInfo.MobileButtonsSide == "Right" then
		            ToggleButton.Button.Position = UDim2.new(1, -6, 0, 6)
		            ToggleButton.Button.AnchorPoint = Vector2.new(1, 0)
		        end
		
		        if WindowInfo.ShowMobileButtons == false then
		            ToggleButton.Button.Visible = false
		        end
		    end
		
		    --// Execution \\--
		    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		        Library:UpdateSearch(SearchBox.Text)
		    end)
		
		    Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input: InputObject)
		        if Library.Unloaded then
		            return
		        end
		
		        if UserInputService:GetFocusedTextBox() then
		            return
		        end
		
		        if
		            (
		                typeof(Library.ToggleKeybind) == "table"
		                and Library.ToggleKeybind.Type == "KeyPicker"
		                and Input.KeyCode.Name == Library.ToggleKeybind.Value
		            ) or Input.KeyCode == Library.ToggleKeybind
		        then
		            Library.Toggle()
		        end
		    end))
		
		    Library:GiveSignal(UserInputService.WindowFocused:Connect(function()
		        Library.IsRobloxFocused = true
		    end))
		    Library:GiveSignal(UserInputService.WindowFocusReleased:Connect(function()
		        Library.IsRobloxFocused = false
		    end))
		    Library:SetDPIScale(95)
		    return Window
		end
		
		function Library:CreateLoading(LoadingInfo)
		    if Library.ActiveLoading then
		        warn("Loading GUI already exists, you cannot create multiple Loading GUIs.")
		        return Library.ActiveLoading
		    end
		
		    LoadingInfo = Library:Validate(LoadingInfo, Templates.Loading)
		
		    local Loading = {
		        CurrentStep = LoadingInfo.CurrentStep,
		        TotalSteps = LoadingInfo.TotalSteps,
		
		        ShowSidebar = LoadingInfo.ShowSidebar,
		        AutoResizeHeight = LoadingInfo.AutoResizeHeight,
		        IsError = false,
		        Destroyed = false,
		
		        WindowWidth = LoadingInfo.WindowWidth,
		        WindowHeight = LoadingInfo.WindowHeight,
		        BaseWindowHeight = LoadingInfo.WindowHeight,
		        WindowErrorHeight = LoadingInfo.WindowHeight,
		
		        ContentWidth = LoadingInfo.ContentWidth,
		        SidebarWidth = LoadingInfo.SidebarWidth,
		    }
		
		    --// ScreenGui \\--
		    local ScreenGui = New("ScreenGui", {
		        Name = "ObsidianLoading",
		        DisplayOrder = 999,
		        ResetOnSpawn = false
		    })
		    ParentUI(ScreenGui)
		    Loading.ScreenGui = ScreenGui
		
		    ScreenGui.DescendantRemoving:Connect(function(Instance)
		        Library:RemoveFromRegistry(Instance)
		    end)
		
		    --// Main Frame \\--
		    local MainFrame = New("TextButton", {
		        Name = "Main",
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundColor3 = function()
		            return Library:GetBetterColor(Library.Scheme.BackgroundColor, -1)
		        end,
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.fromOffset(Loading.ShowSidebar and (Loading.ContentWidth + Loading.SidebarWidth) or Loading.WindowWidth, Loading.WindowHeight),
		        ClipsDescendants = true,
		        Text = "",
		        AutoButtonColor = false,
		        Parent = ScreenGui,
		    })
		    Library:AddOutline(MainFrame)
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = MainFrame }))
		    
		    local MainScale = New("UIScale", { Parent = MainFrame })
		    table.insert(Library.Scales, MainScale)
		
		    --// Layout Containers \\--
		    local Container = New("Frame", {
		        Name = "Content",
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(0, 0),
		        Size = UDim2.new(0, Loading.ContentWidth, 1, 0),
		        Parent = MainFrame,
		    })
		
		    local SideBar = New("Frame", {
		        Name = "SideBar",
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(Loading.ContentWidth, 0),
		        Size = UDim2.new(0, Loading.ShowSidebar and Loading.SidebarWidth or 0, 1, 0),
		        ClipsDescendants = true,
		        Visible = Loading.ShowSidebar,
		        Parent = MainFrame,
		    })
		    local SidebarCorner = New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius), Parent = SideBar })
		    table.insert(Library.Corners, SidebarCorner)
		    
		    Library:AddOutline(SideBar)
		    
		    local SidebarDivider = New("Frame", {
		        BackgroundColor3 = "OutlineColor",
		        BorderSizePixel = 0,
		        Position = UDim2.fromOffset(0, 0),
		        Size = UDim2.new(0, 1, 1, 0),
		        Visible = Loading.ShowSidebar,
		        Parent = SideBar,
		    })
		
		    --// Top Bar \\--
		    local TopBar = New("Frame", {
		        Name = "TopBar",
		        BackgroundTransparency = 1,
		        Size = UDim2.new(1, 0, 0, 48),
		        ZIndex = 2,
		        Parent = Container,
		    })
		    Library:MakeDraggable(MainFrame, TopBar, true, true)
		
		    local TitleHolder = New("Frame", {
		        BackgroundTransparency = 1,
		        Size = UDim2.new(1, 0, 1, 0),
		        Parent = TopBar,
		    })
		    New("UIListLayout", {
		        FillDirection = Enum.FillDirection.Horizontal,
		        HorizontalAlignment = Enum.HorizontalAlignment.Left,
		        VerticalAlignment = Enum.VerticalAlignment.Center,
		        Padding = UDim.new(0, 6),
		        Parent = TitleHolder,
		    })
		    New("UIPadding", {
		        PaddingLeft = UDim.new(0, 12),
		        Parent = TitleHolder,
		    })
		
		    if LoadingInfo.Icon then
		        local Icon = Library:GetCustomIcon(LoadingInfo.Icon)
		        local _WindowIcon = New("ImageLabel", {
		            Image = Icon.Url,
		            ImageRectOffset = Icon.ImageRectOffset,
		            ImageRectSize = Icon.ImageRectSize,
		            Size = LoadingInfo.IconSize,
		            Parent = TitleHolder,
		        })
		    else
		        local _WindowIcon = New("TextLabel", {
		            BackgroundTransparency = 1,
		            Size = LoadingInfo.IconSize,
		            Text = LoadingInfo.Title:sub(1, 1),
		            TextScaled = true,
		            Visible = false,
		            Parent = TitleHolder,
		        })
		    end
		
		    local TitleX = Library:GetTextBounds(
		        LoadingInfo.Title,
		        Library.Scheme.Font,
		        20,
		        TitleHolder.AbsoluteSize.X - (LoadingInfo.Icon and (LoadingInfo.IconSize.X.Offset + 6) or 0) - 12
		    )
		    local _WindowTitle = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Size = UDim2.new(0, TitleX, 1, 0),
		        Text = LoadingInfo.Title,
		        TextSize = 20,
		        Parent = TitleHolder,
		    })
		
		    Library:MakeLine(Container, {
		        Position = UDim2.fromOffset(0, 48),
		        Size = UDim2.new(1, 0, 0, 1),
		    })
		
		    --// Loading Content Elements \\--
		    local InnerContent = New("Frame", {
		        Name = "InnerContent",
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(0, 49),
		        Size = UDim2.new(1, 0, 1, -49),
		        Parent = Container,
		    })
		
		    New("UIListLayout", {
		        FillDirection = Enum.FillDirection.Vertical,
		        HorizontalAlignment = Enum.HorizontalAlignment.Center,
		        VerticalAlignment = Enum.VerticalAlignment.Center,
		        Padding = UDim.new(0, 12),
		        Parent = InnerContent,
		    })
		
		    local IconHolder = New("Frame", {
		        Name = "IconHolder",
		        BackgroundTransparency = 1,
		        Size = UDim2.fromOffset(64, 64),
		        Parent = InnerContent,
		    })
		
		    local LoaderIcon = Library:GetCustomIcon(LoadingInfo.LoadingIcon)
		    local LoadingIcon = New("ImageLabel", {
		        Name = "LoaderIcon",
		        AnchorPoint = Vector2.new(0.5, 0.5),
		        BackgroundTransparency = 1,
		        Position = UDim2.fromScale(0.5, 0.5),
		        Size = UDim2.fromScale(1, 1),
		        Image = LoaderIcon.Url,
		        ImageRectOffset = LoaderIcon.ImageRectOffset,
		        ImageRectSize = LoaderIcon.ImageRectSize,
		        ImageColor3 = LoadingInfo.LoadingIconColor or ((LoadingInfo.LoadingIcon == Templates.Loading.LoadingIcon) and "AccentColor" or "WhiteColor"),
		        Parent = IconHolder,
		    })
		
		    local RotationTween
		    if LoadingInfo.LoadingIconTweenTime > 0 then
		        RotationTween = TweenService:Create(
		            LoadingIcon,
		            TweenInfo.new(LoadingInfo.LoadingIconTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
		            { Rotation = 360 }
		        )
		        RotationTween:Play()
		    end
		
		    local MessageLabel = New("TextLabel", {
		        BackgroundTransparency = 1,
		        AutomaticSize = Loading.AutoResizeHeight and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY,
		        Size = Loading.AutoResizeHeight and UDim2.new(1, -60, 0, 0) or UDim2.fromOffset(0, 0),
		        Text = "",
		        TextSize = 18,
		        TextWrapped = Loading.AutoResizeHeight,
		        Parent = InnerContent,
		    })
		
		    local DescriptionLabel = New("TextLabel", {
		        BackgroundTransparency = 1,
		        AutomaticSize = Loading.AutoResizeHeight and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY,
		        Size = Loading.AutoResizeHeight and UDim2.new(1, -60, 0, 0) or UDim2.fromOffset(0, 0),
		        Text = "",
		        TextSize = 14,
		        TextTransparency = 0.5,
		        TextWrapped = Loading.AutoResizeHeight,
		        Parent = InnerContent,
		    })
		
		    --// Progress Bar \\--
		    local SliderBar = New("Frame", {
		        BackgroundColor3 = "MainColor",
		        Size = UDim2.new(0.7, 0, 0, 15),
		        Parent = InnerContent,
		    })
		    Library:AddOutline(SliderBar)
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = SliderBar }))
		
		    local SliderFill = New("Frame", {
		        BackgroundColor3 = "AccentColor",
		        BorderSizePixel = 0,
		        Size = UDim2.fromScale(0, 1),
		        Parent = SliderBar,
		    })
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius / 2), Parent = SliderFill }))
		
		    local ProgressLabel = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Size = UDim2.fromScale(1, 1),
		        Text = "",
		        TextSize = 14,
		        ZIndex = 2,
		        Parent = SliderBar,
		    })
		    New("UIStroke", {
		        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
		        Color = "DarkColor",
		        LineJoinMode = Enum.LineJoinMode.Miter,
		        Parent = ProgressLabel,
		    })
		
		    --// Sidebar Object \\--
		    local SidebarScrolling = New("ScrollingFrame", {
		        BackgroundTransparency = 1,
		        BorderSizePixel = 0,
		        CanvasSize = UDim2.new(0, 0, 0, 0),
		        Size = UDim2.fromScale(1, 1),
		        ScrollBarThickness = 2,
		        ScrollBarImageColor3 = "OutlineColor",
		        Parent = SideBar,
		    })
		    local SidebarList = New("UIListLayout", {
		        Padding = UDim.new(0, 8),
		        SortOrder = Enum.SortOrder.LayoutOrder,
		        Parent = SidebarScrolling,
		    })
		    New("UIPadding", {
		        PaddingBottom = UDim.new(0, 12),
		        PaddingLeft = UDim.new(0, 12),
		        PaddingRight = UDim.new(0, 12),
		        PaddingTop = UDim.new(0, 12),
		        Parent = SidebarScrolling,
		    })
		
		    local SidebarObject = {
		        Elements = {},
		        DependencyBoxes = {},
		        Tabboxes = {},
		        
		        BoxHolder = SidebarScrolling,
		        Container = SidebarScrolling,
		        
		        Resize = function(self)
		            SidebarScrolling.CanvasSize = UDim2.fromOffset(0, SidebarList.AbsoluteContentSize.Y + 24)
		        end,
		        Tab = {
		            Elements = {},
		            DependencyBoxes = {},
		            DependencyGroupboxes = {},
		            Tabboxes = {},
		        },
		    }
		
		    SidebarList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		        SidebarObject:Resize()
		    end)
		
		    setmetatable(SidebarObject, BaseGroupbox)
		    Loading.Sidebar = SidebarObject
		
		    --// Error Frame \\--
		    local ErrorFrame = New("Frame", {
		        Name = "Error",
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(0, 49),
		        Size = UDim2.new(1, 0, 1, -49),
		        ClipsDescendants = true,
		        Visible = false,
		        Parent = Container,
		    })
		
		    local _ErrorTitle = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(15, 15),
		        Size = UDim2.new(1, -30, 0, 18),
		        Text = "Error",
		        TextColor3 = "RedColor",
		        TextSize = 18,
		        TextXAlignment = Enum.TextXAlignment.Left,
		        Parent = ErrorFrame,
		    })
		
		    local ErrorLabel = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Position = UDim2.fromOffset(15, 39),
		        Size = UDim2.new(1, -30, 1, -90),
		        Text = "Error Message",
		        TextSize = 14,
		        TextTransparency = 0.2,
		        TextWrapped = true,
		        TextXAlignment = Enum.TextXAlignment.Left,
		        TextYAlignment = Enum.TextYAlignment.Top,
		        Parent = ErrorFrame,
		    })
		
		    local ErrorButtonsDivider = New("Frame", {
		        BackgroundColor3 = "OutlineColor",
		        BackgroundTransparency = 0,
		        BorderSizePixel = 0,
		        AnchorPoint = Vector2.new(0.5, 0),
		        Position = UDim2.new(0.5, 0, 1, -48),
		        Size = UDim2.new(1, -30, 0, 1),
		        Visible = false,
		        Parent = ErrorFrame,
		    })
		
		    local ErrorButtonsHolder = New("Frame", {
		        AnchorPoint = Vector2.new(0.5, 1),
		        BackgroundTransparency = 1,
		        Position = UDim2.new(0.5, 0, 1, 0),
		        Size = UDim2.new(1, 0, 0, 42),
		        Visible = false,
		        Parent = ErrorFrame,
		    })
		    New("UIListLayout", {
		        Padding = UDim.new(0, 8),
		        FillDirection = Enum.FillDirection.Horizontal,
		        HorizontalAlignment = Enum.HorizontalAlignment.Right,
		        VerticalAlignment = Enum.VerticalAlignment.Center,
		        SortOrder = Enum.SortOrder.LayoutOrder,
		        Parent = ErrorButtonsHolder,
		    })
		    New("UIPadding", {
		        PaddingTop = UDim.new(0, 5),
		        PaddingBottom = UDim.new(0, 15),
		        PaddingRight = UDim.new(0, 15),
		        Parent = ErrorButtonsHolder,
		    })
		
		    function Loading:UpdateLayout()
		        if Loading.IsError then
		            Loading:RecalculateErrorHeight()
		        end
		
		        local ShowSidebar = Loading.ShowSidebar
		        local FinalWidth = ShowSidebar and (Loading.ContentWidth + Loading.SidebarWidth) or Loading.WindowWidth
		        local FinalHeight = Loading.IsError and Loading.WindowErrorHeight or Loading.WindowHeight
		        
		        if ShowSidebar then
		            SideBar.Visible = true
		            SidebarDivider.Visible = true
		        end
		
		        TweenService:Create(MainFrame, Library.TweenInfo, { Size = UDim2.fromOffset(FinalWidth, FinalHeight) }):Play()
		        TweenService:Create(SideBar, Library.TweenInfo, { Position = UDim2.fromOffset(Loading.ContentWidth, 0), Size = UDim2.new(0, ShowSidebar and Loading.SidebarWidth or 0, 1, 0) }):Play()
		        TweenService:Create(Container, Library.TweenInfo, { Size = UDim2.new(0, ShowSidebar and Loading.ContentWidth or Loading.WindowWidth, 1, 0) }):Play()
		
		        if not ShowSidebar then
		            task.delay(Library.TweenInfo.Time, function()
		                if not Loading.ShowSidebar then
		                    SideBar.Visible = false
		                    SidebarDivider.Visible = false
		                end
		            end)
		        end
		    end
		
		    --// Content Page \\--
		    function Loading:RecalculateLoadingHeight()
		        if not Loading.AutoResizeHeight then
		            return
		        end
		
		        local RequiredHeight = 
		              49 -- TopBar
		            + 48 -- Padding
		            + InnerContent.UIListLayout.AbsoluteContentSize.Y
		
		        Loading.WindowHeight = math.max(Loading.BaseWindowHeight, RequiredHeight)
		    end
		
		    function Loading:SetMessage(Text)
		        MessageLabel.Text = Text
		
		        if Loading.AutoResizeHeight then
		            Loading:RecalculateLoadingHeight()
		            Loading:UpdateLayout()
		        end
		    end
		
		    function Loading:SetDescription(Text)
		        DescriptionLabel.Text = Text
		
		        if Loading.AutoResizeHeight then
		            Loading:RecalculateLoadingHeight()
		            Loading:UpdateLayout()
		        end
		    end
		
		    function Loading:SetLoadingIcon(Icon)
		        local IconData = Library:GetCustomIcon(Icon)
		        LoadingIcon.Image = IconData.Url
		        LoadingIcon.ImageRectOffset = IconData.ImageRectOffset
		        LoadingIcon.ImageRectSize = IconData.ImageRectSize
		    end
		
		    function Loading:SetLoadingIconTweenTime(TweenTime)
		        if RotationTween then
		            RotationTween:Cancel()
		            RotationTween:Destroy()
		        end
		
		        if TweenTime > 0 then
		            RotationTween = TweenService:Create(
		                LoadingIcon,
		                TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
		                { Rotation = 360 }
		            )
		            RotationTween:Play()
		        else
		            LoadingIcon.Rotation = 0
		        end
		    end
		
		    function Loading:SetLoadingIconColor(Color)
		        LoadingIcon.ImageColor3 = Color
		    end
		
		    function Loading:SetCurrentStep(Step)
		        Loading.CurrentStep = math.clamp(Step, 0, Loading.TotalSteps)
		
		        local Progress = Loading.CurrentStep / Loading.TotalSteps
		        TweenService:Create(SliderFill, Library.TweenInfo, { Size = UDim2.fromScale(Progress, 1) }):Play()
		
		        ProgressLabel.Text = string.format("%d/%d", Loading.CurrentStep, Loading.TotalSteps)
		    end
		
		    function Loading:SetTotalSteps(Steps)
		        Loading.TotalSteps = Steps
		        Loading:SetCurrentStep(Loading.CurrentStep)
		    end
		
		    --// Size \\--
		    function Loading:SetWindowHeight(Height)
		        Loading.WindowHeight = Height
		        Loading:UpdateLayout()
		    end
		
		    function Loading:SetWindowWidth(Width)
		        Loading.WindowWidth = Width
		        Loading:UpdateLayout()
		    end
		
		    function Loading:SetContentWidth(Width)
		        Loading.ContentWidth = Width
		        Loading:UpdateLayout()
		    end
		
		    function Loading:SetSidebarWidth(Width)
		        Loading.SidebarWidth = Width
		        Loading:UpdateLayout()
		    end
		
		    --// Sidebar \\--
		    function Loading:ShowSidebarPage(Bool)
		        Loading.ShowSidebar = Bool
		        Loading:UpdateLayout()
		    end
		
		    --// Error Page \\--
		    function Loading:ShowErrorPage(Enabled)
		        Loading.IsError = Enabled
		        InnerContent.Visible = not Enabled
		        ErrorFrame.Visible = Enabled
		
		        if Loading.ShowSidebar then
		            Loading:ShowSidebarPage(not Enabled)
		        else
		            Loading:UpdateLayout()
		        end
		    end
		
		    function Loading:RecalculateErrorHeight()
		        local TargetWidth = (Loading.ShowSidebar and Loading.ContentWidth or Loading.WindowWidth) - 30
		        local _, ErrorY = Library:GetTextBounds(ErrorLabel.Text, Library.Scheme.Font, 14, TargetWidth)
		
		        ErrorLabel.Size = UDim2.new(1, -30, 0, ErrorY)
		
		        local HasButtons = ErrorButtonsHolder.Visible
		        local RequiredHeight =
		              49                        -- TopBar
		            + 15                        -- Padding Top
		            + 18                        -- Title Height
		            + 6                         -- Padding between Title and Label
		            + ErrorY                    -- Label Height
		            + 15                        -- Padding between Label and Buttons
		            + (HasButtons and 48 or 0)  -- Buttons Area
		
		        Loading.WindowErrorHeight = RequiredHeight
		    end
		
		    function Loading:SetErrorMessage(Text)
		        ErrorLabel.Text = Text
		        Loading:UpdateLayout()
		    end
		
		    function Loading:SetErrorButtons(Buttons)
		        assert(typeof(Buttons) == "table", "Buttons must be a table")
		
		        for _, button in ErrorButtonsHolder:GetChildren() do
		            if button:IsA("Frame") then 
		                button:Destroy() 
		            end
		        end
		
		        local HasButtons = GetTableSize(Buttons) > 0
		        ErrorButtonsHolder.Visible = HasButtons
		        ErrorButtonsDivider.Visible = HasButtons
		
		        for Idx, ButtonInfo in Buttons do
		            local ButtonContainer = New("Frame", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromOffset(0, 26),
		                Parent = ErrorButtonsHolder,
		            })
		            
		            local BtnColor = "MainColor"
		            local BtnOutline = "OutlineColor"
		            local Variant = ButtonInfo.Variant or "Primary"
		            
		            if Variant == "Primary" then
		                BtnColor = "FontColor"
		                BtnOutline = "FontColor"
		            elseif Variant == "Secondary" then
		                BtnColor = "MainColor"
		                BtnOutline = "OutlineColor"
		            elseif Variant == "Destructive" then
		                BtnColor = "DestructiveColor"
		                BtnOutline = "DestructiveColor"
		            elseif Variant == "Ghost" then
		                BtnColor = "BackgroundColor"
		                BtnOutline = "BackgroundColor"
		            end
		
		            local TextBtn = New("TextButton", {
		                BackgroundColor3 = BtnColor,
		                BorderColor3 = BtnOutline,
		                Size = UDim2.fromOffset(0, 26),
		                Text = "",
		                AutoButtonColor = false,
		                Parent = ButtonContainer,
		            })
		            Library:AddOutline(TextBtn)
		            table.insert(
		                Library.Corners,
		                New("UICorner", { 
		                    CornerRadius = UDim.new(0, Library.CornerRadius), 
		                    Parent = TextBtn 
		                })
		            )
		
		            New("UIPadding", {
		                PaddingLeft = UDim.new(0, 15),
		                PaddingRight = UDim.new(0, 15),
		                Parent = TextBtn,
		            })
		
		            local TextColor = Library.Scheme.FontColor
		            if Variant == "Primary" then
		                TextColor = Library.Scheme.BackgroundColor
		            elseif Variant == "Destructive" then
		                TextColor = Color3.new(1, 1, 1)
		            end
		
		            local BtnLabel = New("TextLabel", {
		                BackgroundTransparency = 1,
		                Size = UDim2.fromScale(1, 1),
		                Text = ButtonInfo.Title or Idx,
		                TextColor3 = TextColor,
		                TextSize = 14,
		                Parent = TextBtn,
		            })
		            
		            local LabelX, _ = Library:GetTextBounds(BtnLabel.Text, Library.Scheme.Font, 14, 250)
		            ButtonContainer.Size = UDim2.fromOffset(LabelX + 30, 26)
		            TextBtn.Size = UDim2.fromOffset(LabelX + 30, 26)
		
		            local ActiveColor = typeof(BtnColor) == "Color3" and BtnColor or Library.Scheme[BtnColor]
		            local HoverColor = Variant == "Ghost" and Library.Scheme.MainColor or Library:GetBetterColor(ActiveColor, 10)
		
		            TextBtn.MouseEnter:Connect(function()
		                TweenService:Create(TextBtn, Library.TweenInfo, {
		                    BackgroundColor3 = HoverColor
		                }):Play()
		            end)
		            TextBtn.MouseLeave:Connect(function()
		                TweenService:Create(TextBtn, Library.TweenInfo, {
		                    BackgroundColor3 = ActiveColor
		                }):Play()
		            end)
		
		            TextBtn.MouseButton1Click:Connect(function()
		                if ButtonInfo.Callback then
		                    ButtonInfo.Callback(Loading)
		                end
		            end)
		        end
		
		        Loading:UpdateLayout()
		    end
		
		    function Loading:Destroy()
		        if RotationTween then
		            RotationTween:Cancel()
		        end
		
		        ScreenGui:Destroy()
		        Loading.Destroyed = true
		        Library.ActiveLoading = nil
		
		        if Library.Toggle and Library.Toggled == false and Library.Unloaded ~= true then
		            Library:Toggle(true)
		        end
		    end
		
		    Loading.Continue = Loading.Destroy;
		
		    if Library.Toggle and Library.Toggled and Library.Unloaded ~= true then
		        Library:Toggle(false)
		    end
		
		    Loading:SetCurrentStep(Loading.CurrentStep)
		
		    Library.ActiveLoading = Loading
		    return Loading
		end
		
		local function OnPlayerChange()
		    if Library.Unloaded then
		        return
		    end
		
		    local PlayerList, ExcludedPlayerList = GetPlayers(), GetPlayers(true)
		    for _, Dropdown in Options do
		        if Dropdown.Type == "Dropdown" and Dropdown.SpecialType == "Player" then
		            Dropdown:SetValues(Dropdown.ExcludeLocalPlayer and ExcludedPlayerList or PlayerList)
		        end
		    end
		end
		
		local function OnTeamChange()
		    if Library.Unloaded then
		        return
		    end
		
		    local TeamList = GetTeams()
		    for _, Dropdown in Options do
		        if Dropdown.Type == "Dropdown" and Dropdown.SpecialType == "Team" then
		            Dropdown:SetValues(TeamList)
		        end
		    end
		end
		
		function Library:AddDraggablePillButton(Info)
		    if not Library.IsMobile then
		        return { SetVisible = function() end, Value = Info.Default or false, Holder = nil }
		    end
		
		    local Text = Info.Text and string.upper(tostring(Info.Text)) or "BUTTON"
		    local Type = Info.Type or "Click" 
		    local Callback = Info.Callback or function() end
		    local Default = Info.Default or false
		    local UserInputService = game:GetService("UserInputService")
		
		    if not Library.QuickMenuContainer then
		        Library.QuickMenuContainer = New("Frame", {
		            BackgroundTransparency = 1,
		            AnchorPoint = Vector2.new(1, 0),
		            Position = UDim2.new(1, -20, 0.15, 0), 
		            Size = UDim2.fromOffset(130, 36),
		            AutomaticSize = Enum.AutomaticSize.XY, 
		            ZIndex = 100, 
		            Visible = false, 
		            Parent = Library.ScreenGui, 
		        })
		
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Horizontal,
		            HorizontalAlignment = Enum.HorizontalAlignment.Right,
		            VerticalAlignment = Enum.VerticalAlignment.Top,
		            Padding = UDim.new(0, 6),
		            Parent = Library.QuickMenuContainer,
		        })
		
		        Library.RightControlPanel = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromOffset(24, 0),
		            AutomaticSize = Enum.AutomaticSize.Y,
		            LayoutOrder = 2,
		            Parent = Library.QuickMenuContainer,
		        })
		        New("UIListLayout", {
		            FillDirection = Enum.FillDirection.Vertical,
		            HorizontalAlignment = Enum.HorizontalAlignment.Center,
		            Padding = UDim.new(0, 6),
		            Parent = Library.RightControlPanel,
		        })
		
		        local DragIcon = Library:GetCustomIcon("grip-vertical") or {Url = "", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		        Library.QuickMenuHandle = New("ImageButton", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromOffset(24, 24),
		            Image = DragIcon.Url,
		            ImageRectOffset = DragIcon.ImageRectOffset,
		            ImageRectSize = DragIcon.ImageRectSize,
		            ImageColor3 = "FontColor",
		            AutoButtonColor = false,
		            Parent = Library.RightControlPanel,
		        })
		
		        local LockOpenIcon = Library:GetCustomIcon("lock-keyhole-open") or {Url = "", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		        local LockClosedIcon = Library:GetCustomIcon("shield-check") or {Url = "", ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero}
		        
		        Library.QuickMenuLock = New("ImageButton", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromOffset(20, 20),
		            Image = LockOpenIcon.Url,
		            ImageRectOffset = LockOpenIcon.ImageRectOffset,
		            ImageRectSize = LockOpenIcon.ImageRectSize,
		            ImageColor3 = Color3.fromRGB(150, 150, 150),
		            AutoButtonColor = false,
		            Parent = Library.RightControlPanel,
		        })
		
		        Library.QuickMenuButtons = New("Frame", {
		            BackgroundTransparency = 1,
		            Size = UDim2.fromOffset(120, 164),
		            AutomaticSize = Enum.AutomaticSize.X, 
		            LayoutOrder = 1, 
		            Visible = true,
		            Parent = Library.QuickMenuContainer,
		        })
		
		        New("UIGridLayout", {
		            CellSize = UDim2.fromOffset(120, 28),
		            CellPadding = UDim2.fromOffset(6, 6),
		            FillDirection = Enum.FillDirection.Vertical, 
		            FillDirectionMaxCells = 5,                    
		            HorizontalAlignment = Enum.HorizontalAlignment.Right,
		            StartCorner = Enum.StartCorner.TopRight,
		            SortOrder = Enum.SortOrder.LayoutOrder,
		            Parent = Library.QuickMenuButtons,
		        })
		
		
		        local isLocked = false
		        local Dragging = false
		        local DragInput, StartPos, FramePos
		
		        Library.QuickMenuHandle.InputBegan:Connect(function(input)
		            if isLocked then return end
		            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		                Dragging = true
		                StartPos = input.Position
		                FramePos = Library.QuickMenuContainer.Position
		                
		                input.Changed:Connect(function()
		                    if input.UserInputState == Enum.UserInputState.End then
		                        Dragging = false
		                    end
		                end)
		            end
		        end)
		
		        Library.QuickMenuHandle.InputChanged:Connect(function(input)
		            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		                DragInput = input
		            end
		        end)
		
		        UserInputService.InputChanged:Connect(function(input)
		            if input == DragInput and Dragging then
		                local Delta = input.Position - StartPos
		                
		                local ScreenSize = workspace.CurrentCamera.ViewportSize
		                local ContainerSize = Library.QuickMenuContainer.AbsoluteSize
		                
		                local startX = (FramePos.X.Scale * ScreenSize.X) + FramePos.X.Offset
		                local startY = (FramePos.Y.Scale * ScreenSize.Y) + FramePos.Y.Offset
		                
		                local targetX = startX + Delta.X
		                local targetY = startY + Delta.Y
		                
		                local clampedX = math.clamp(targetX, ContainerSize.X, ScreenSize.X)
		                local clampedY = math.clamp(targetY, 0, ScreenSize.Y - ContainerSize.Y)
		                
		                Library.QuickMenuContainer.Position = UDim2.new(0, clampedX, 0, clampedY)
		            end
		        end)
		
		        Library.QuickMenuLock.MouseButton1Click:Connect(function()
		            isLocked = not isLocked
		            
		            local targetIcon = isLocked and LockClosedIcon or LockOpenIcon
		            Library.QuickMenuLock.Image = targetIcon.Url
		            Library.QuickMenuLock.ImageRectOffset = targetIcon.ImageRectOffset
		            Library.QuickMenuLock.ImageRectSize = targetIcon.ImageRectSize
		            
		            Library.QuickMenuLock.ImageColor3 = isLocked and Color3.fromRGB(235, 65, 65) or Color3.fromRGB(150, 150, 150)
		        end)
		
		        Library.QuickMenuHandle.MouseButton1Click:Connect(function()
		            Library.QuickMenuButtons.Visible = not Library.QuickMenuButtons.Visible
		        end)
		    end
		
		    local Table = {}
		    
		    local currentButtonCount = #Library.QuickMenuButtons:GetChildren()
		    
		    local MainBtn = New("TextButton", {
		        BackgroundColor3 = "MainColor",
		        Size = UDim2.fromOffset(120, 28),
		        Text = "",
		        AutoButtonColor = false,
		        Visible = false, 
		        LayoutOrder = currentButtonCount + 1,
		        Parent = Library.QuickMenuButtons,
		    })
		    table.insert(Library.Corners, New("UICorner", { CornerRadius = UDim.new(0, Library.CornerRadius * 2), Parent = MainBtn }))
		    
		    local BtnStroke = New("UIStroke", {
		        Color = "OutlineColor",
		        Thickness = 1,
		        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		        Parent = MainBtn,
		    })
		
		    local BtnGradient = New("UIGradient", {
		        Rotation = 0,
		        Transparency = NumberSequence.new({
		            NumberSequenceKeypoint.new(0, 0.85),
		            NumberSequenceKeypoint.new(0.2, 0),
		            NumberSequenceKeypoint.new(0.8, 0),
		            NumberSequenceKeypoint.new(1, 0.85)
		        }),
		        Parent = MainBtn,
		    })
		
		    local MainLabel = New("TextLabel", {
		        BackgroundTransparency = 1,
		        Size = UDim2.fromScale(1, 1),
		        Text = Text,
		        TextSize = 12,
		        FontFace = Font.fromEnum(Enum.Font.FredokaOne),
		        TextColor3 = "FontColor", 
		        Parent = MainBtn,
		    })
		
		    if Type == "Switch" then
		        Table.Value = Default
		        local function UpdateVisuals()
		            local targetBg = Table.Value and Color3.fromRGB(180, 25, 25) or Library.Scheme.MainColor
		            local targetStroke = Table.Value and Color3.fromRGB(255, 60, 60) or Library.Scheme.OutlineColor
		            local targetText = Library.Scheme.FontColor 
		            
		            TweenService:Create(MainBtn, Library.TweenInfo, {BackgroundColor3 = targetBg}):Play()
		            TweenService:Create(BtnStroke, Library.TweenInfo, {Color = targetStroke}):Play()
		            TweenService:Create(MainLabel, Library.TweenInfo, {TextColor3 = targetText}):Play()
		        end
		        
		        MainBtn.MouseButton1Click:Connect(function()
		            Table.Value = not Table.Value
		            UpdateVisuals()
		            if Library.Toggled then Library:Toggle(false) end
		            Library:SafeCallback(Callback, Table.Value)
		        end)
		        UpdateVisuals()
		    else
		        MainBtn.MouseButton1Click:Connect(function()
		            local clickTween = TweenService:Create(MainBtn, Library.TweenInfo, {BackgroundColor3 = Library.Scheme.AccentColor})
		            clickTween:Play()
		            if Library.Toggled then Library:Toggle(false) end
		            Library:SafeCallback(Callback)
		            task.wait(0.15)
		            local resetTween = TweenService:Create(MainBtn, Library.TweenInfo, {BackgroundColor3 = Library.Scheme.MainColor})
		            resetTween:Play()
		        end)
		    end
		
		    Table.Holder = MainBtn
		    Table.SetVisible = function(self, Visible)
		        if MainBtn then MainBtn.Visible = Visible end
		    end
		
		    return Table
		end
		
		Library:GiveSignal(Players.PlayerAdded:Connect(OnPlayerChange))
		Library:GiveSignal(Players.PlayerRemoving:Connect(OnPlayerChange))
		
		Library:GiveSignal(Teams.ChildAdded:Connect(OnTeamChange))
		Library:GiveSignal(Teams.ChildRemoved:Connect(OnTeamChange))
		
		getgenv().Library = Library
		return Library
		-- <<< End embedded: Library
	end)()
	local lib3 = (function()
		-- >>> Embedded: ThemeManager
		local cloneref = (cloneref or clonereference or function(instance: any)
		    return instance
		end)
		local clonefunction = (clonefunction or copyfunction or function(func) 
		    return func 
		end)
		
		local HttpService: HttpService = cloneref(game:GetService("HttpService"))
		local isfolder, isfile, listfiles = isfolder, isfile, listfiles
		
		if typeof(clonefunction) == "function" then
		    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.
		
		    local
		        isfolder_copy,
		        isfile_copy,
		        listfiles_copy = clonefunction(isfolder), clonefunction(isfile), clonefunction(listfiles)
		
		    local isfolder_success, isfolder_error = pcall(function()
		        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
		    end)
		
		    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
		        isfolder = function(folder)
		            local success, data = pcall(isfolder_copy, folder)
		            return (if success then data else false)
		        end
		
		        isfile = function(file)
		            local success, data = pcall(isfile_copy, file)
		            return (if success then data else false)
		        end
		
		        listfiles = function(folder)
		            local success, data = pcall(listfiles_copy, folder)
		            return (if success then data else {})
		        end
		    end
		end
		
		local ThemeManager = {}
		do
		    local ThemeFields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
		    ThemeManager.Folder = "ObsidianLibSettings"
		    -- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end
		
		    ThemeManager.Library = nil
		    ThemeManager.AppliedToTab = false
		    ThemeManager.BuiltInThemes = {
		        ["Default"] = {
		            1,
		            { FontColor = "ffffff", MainColor = "470000", AccentColor = "f50000", BackgroundColor = "2e0000", OutlineColor = "868686" },
		        },
		        ["BBot"] = {
		            2,
		            { FontColor = "ffffff", MainColor = "1e1e1e", AccentColor = "7e48a3", BackgroundColor = "232323", OutlineColor = "141414" },
		        },
		        ["Fatality"] = {
		            3,
		            { FontColor = "ffffff", MainColor = "1e1842", AccentColor = "c50754", BackgroundColor = "191335", OutlineColor = "3c355d" },
		        },
		        ["Jester"] = {
		            4,
		            { FontColor = "ffffff", MainColor = "242424", AccentColor = "db4467", BackgroundColor = "1c1c1c", OutlineColor = "373737" },
		        },
		        ["Mint"] = {
		            5,
		            { FontColor = "ffffff", MainColor = "242424", AccentColor = "3db488", BackgroundColor = "1c1c1c", OutlineColor = "373737" },
		        },
		        ["Tokyo Night"] = {
		            6,
		            { FontColor = "ffffff", MainColor = "191925", AccentColor = "6759b3", BackgroundColor = "16161f", OutlineColor = "323232" },
		        },
		        ["Ubuntu"] = {
		            7,
		            { FontColor = "ffffff", MainColor = "3e3e3e", AccentColor = "e2581e", BackgroundColor = "323232", OutlineColor = "191919" },
		        },
		        ["Quartz"] = {
		            8,
		            { FontColor = "ffffff", MainColor = "232330", AccentColor = "426e87", BackgroundColor = "1d1b26", OutlineColor = "27232f" },
		        },
		        ["Nord"] = {
		            9,
		            { FontColor = "eceff4", MainColor = "3b4252", AccentColor = "88c0d0", BackgroundColor = "2e3440", OutlineColor = "4c566a" },
		        },
		        ["Dracula"] = {
		            10,
		            { FontColor = "f8f8f2", MainColor = "44475a", AccentColor = "ff79c6", BackgroundColor = "282a36", OutlineColor = "6272a4" },
		        },
		        ["Monokai"] = {
		            11,
		            { FontColor = "f8f8f2", MainColor = "272822", AccentColor = "f92672", BackgroundColor = "1e1f1c", OutlineColor = "49483e" },
		        },
		        ["Gruvbox"] = {
		            12,
		            { FontColor = "ebdbb2", MainColor = "3c3836", AccentColor = "fb4934", BackgroundColor = "282828", OutlineColor = "504945" },
		        },
		        ["Solarized"] = {
		            13,
		            { FontColor = "839496", MainColor = "073642", AccentColor = "cb4b16", BackgroundColor = "002b36", OutlineColor = "586e75" },
		        },
		        ["Catppuccin"] = {
		            14,
		            { FontColor = "d9e0ee", MainColor = "302d41", AccentColor = "f5c2e7", BackgroundColor = "1e1e2e", OutlineColor = "575268" },
		        },
		        ["One Dark"] = {
		            15,
		            { FontColor = "abb2bf", MainColor = "282c34", AccentColor = "c678dd", BackgroundColor = "21252b", OutlineColor = "5c6370" },
		        },
		        ["Cyberpunk"] = {
		            16,
		            { FontColor = "f9f9f9", MainColor = "262335", AccentColor = "00ff9f", BackgroundColor = "1a1a2e", OutlineColor = "413c5e" },
		        },
		        ["Oceanic Next"] = {
		            17,
		            { FontColor = "d8dee9", MainColor = "1b2b34", AccentColor = "6699cc", BackgroundColor = "16232a", OutlineColor = "343d46" },
		        },
		        ["Material"] = {
		            18,
		            { FontColor = "eeffff", MainColor = "212121", AccentColor = "82aaff", BackgroundColor = "151515", OutlineColor = "424242" },
		        }
		    }
		
		    function ThemeManager:SetLibrary(library)
		        self.Library = library
		    end
		
		    --// Folders \\--
		    function ThemeManager:GetPaths()
		        local paths = {}
		
		        local parts = self.Folder:split("/")
		        for idx = 1, #parts do
		            paths[#paths + 1] = table.concat(parts, "/", 1, idx)
		        end
		
		        paths[#paths + 1] = self.Folder .. "/themes"
		
		        return paths
		    end
		
		    function ThemeManager:BuildFolderTree()
		        local paths = self:GetPaths()
		
		        for i = 1, #paths do
		            local str = paths[i]
		            if isfolder(str) then
		                continue
		            end
		            makefolder(str)
		        end
		    end
		
		    function ThemeManager:CheckFolderTree()
		        if isfolder(self.Folder) then
		            return
		        end
		        self:BuildFolderTree()
		
		        task.wait(0.1)
		    end
		
		    function ThemeManager:SetFolder(folder)
		        self.Folder = folder
		        self:BuildFolderTree()
		    end
		
		    --// Apply, Update theme \\--
		    function ThemeManager:ApplyTheme(theme)
		        local customThemeData = self:GetCustomTheme(theme)
		        local data = customThemeData or self.BuiltInThemes[theme]
		
		        if not data then
		            return
		        end
		
		        local scheme = data[2]
		        for idx, val in pairs(customThemeData or scheme) do
		            if idx == "VideoLink" then
		                continue
		            elseif idx == "FontFace" then
		                self.Library:SetFont(Enum.Font[val])
		
		                if self.Library.Options[idx] then
		                    self.Library.Options[idx]:SetValue(val)
		                end
		            else
		                self.Library.Scheme[idx] = Color3.fromHex(val)
		
		                if self.Library.Options[idx] then
		                    self.Library.Options[idx]:SetValueRGB(Color3.fromHex(val))
		                end
		            end
		        end
		
		        self:ThemeUpdate()
		    end
		
		    function ThemeManager:ThemeUpdate()
		        for i, field in ThemeFields do
		            if self.Library.Options and self.Library.Options[field] then
		                self.Library.Scheme[field] = self.Library.Options[field].Value
		            end
		        end
		
		        self.Library:UpdateColorsUsingRegistry()
		    end
		
		    --// Get, Load, Save, Delete, Refresh \\--
		    function ThemeManager:GetCustomTheme(file)
		        local path = self.Folder .. "/themes/" .. file .. ".json"
		        if not isfile(path) then
		            return nil
		        end
		
		        local data = readfile(path)
		        local success, decoded = pcall(HttpService.JSONDecode, HttpService, data)
		
		        if not success then
		            return nil
		        end
		
		        return decoded
		    end
		
		    function ThemeManager:LoadDefault()
		        local theme = "Default"
		        local content = isfile(self.Folder .. "/themes/default.txt") and readfile(self.Folder .. "/themes/default.txt")
		
		        local isDefault = true
		        if content then
		            if self.BuiltInThemes[content] then
		                theme = content
		            elseif self:GetCustomTheme(content) then
		                theme = content
		                isDefault = false
		            end
		        elseif self.BuiltInThemes[self.DefaultTheme] then
		            theme = self.DefaultTheme
		        end
		
		        if isDefault then
		            self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
		        else
		            self:ApplyTheme(theme)
		        end
		    end
		
		    function ThemeManager:SaveDefault(theme)
		        writefile(self.Folder .. "/themes/default.txt", theme)
		    end
		
		    function ThemeManager:SetDefaultTheme(theme)
		        assert(self.Library, "Must set ThemeManager.Library first!")
		        assert(not self.AppliedToTab, "Cannot set default theme after applying ThemeManager to a tab!")
		
		        local FinalTheme = {}
		        local LibraryScheme = {}
		        for _, field in ThemeFields do
		            if typeof(theme[field]) == "Color3" then
		                FinalTheme[field] = "#" .. theme[field]:ToHex()
		                LibraryScheme[field] = theme[field]
		
		            elseif typeof(theme[field]) == "string" then
		                FinalTheme[field] = if theme[field]:sub(1, 1) == "#" then theme[field] else ("#" .. theme[field])
		                LibraryScheme[field] = Color3.fromHex(theme[field])
		
		            else
		                FinalTheme[field] = ThemeManager.BuiltInThemes["Default"][2][field]
		                LibraryScheme[field] = Color3.fromHex(ThemeManager.BuiltInThemes["Default"][2][field])
		            end
		        end
		
		        if typeof(theme["FontFace"]) == "EnumItem" then
		            FinalTheme["FontFace"] = theme["FontFace"].Name
		            LibraryScheme["Font"] = Font.fromEnum(theme["FontFace"])
		
		        elseif typeof(theme["FontFace"]) == "string" then
		            FinalTheme["FontFace"] = theme["FontFace"]
		            LibraryScheme["Font"] = Font.fromEnum(Enum.Font[theme["FontFace"]])
		
		        else
		            FinalTheme["FontFace"] = "Code"
		            LibraryScheme["Font"] = Font.fromEnum(Enum.Font.Code)
		        end
		
		        for _, field in { "RedColor", "DarkColor", "WhiteColor" } do
		            LibraryScheme[field] = self.Library.Scheme[field]
		        end
		
		        self.Library.Scheme = LibraryScheme
		        self.BuiltInThemes["Default"] = { 1, FinalTheme }
		
		        self.Library:UpdateColorsUsingRegistry()
		    end
		
		    function ThemeManager:SaveCustomTheme(file)
		        if file:gsub(" ", "") == "" then
		            self.Library:Notify("Invalid file name for theme (empty)", 3)
		            return
		        end
		
		        local theme = {}
		        for _, field in ThemeFields do
		            theme[field] = self.Library.Options[field].Value:ToHex()
		        end
		        theme["FontFace"] = self.Library.Options["FontFace"].Value
		
		        writefile(self.Folder .. "/themes/" .. file .. ".json", HttpService:JSONEncode(theme))
		    end
		
		    function ThemeManager:Delete(name)
		        if not name then
		            return false, "no config file is selected"
		        end
		
		        local file = self.Folder .. "/themes/" .. name .. ".json"
		        if not isfile(file) then
		            return false, "invalid file"
		        end
		
		        local success = pcall(delfile, file)
		        if not success then
		            return false, "delete file error"
		        end
		
		        return true
		    end
		
		    function ThemeManager:ReloadCustomThemes()
		        local list = listfiles(self.Folder .. "/themes")
		
		        local out = {}
		        for i = 1, #list do
		            local file = list[i]
		            if file:sub(-5) == ".json" then
		                -- i hate this but it has to be done ...
		
		                local pos = file:find(".json", 1, true)
		                local start = pos
		
		                local char = file:sub(pos, pos)
		                while char ~= "/" and char ~= "\\" and char ~= "" do
		                    pos = pos - 1
		                    char = file:sub(pos, pos)
		                end
		
		                if char == "/" or char == "\\" then
		                    table.insert(out, file:sub(pos + 1, start - 1))
		                end
		            end
		        end
		
		        return out
		    end
		
		    --// GUI \\--
		    function ThemeManager:CreateThemeManager(groupbox)
		        groupbox
		            :AddLabel("Background color")
		            :AddColorPicker("BackgroundColor", { Default = self.Library.Scheme.BackgroundColor })
		        groupbox:AddLabel("Main color"):AddColorPicker("MainColor", { Default = self.Library.Scheme.MainColor })
		        groupbox:AddLabel("Accent color"):AddColorPicker("AccentColor", { Default = self.Library.Scheme.AccentColor })
		        groupbox
		            :AddLabel("Outline color")
		            :AddColorPicker("OutlineColor", { Default = self.Library.Scheme.OutlineColor })
		        groupbox:AddLabel("Font color"):AddColorPicker("FontColor", { Default = self.Library.Scheme.FontColor })
		        groupbox:AddDropdown("FontFace", {
		            Text = "Font Face",
		            Default = "Code",
		            Values = { "BuilderSans", "Code", "Fantasy", "Gotham", "Jura", "Roboto", "RobotoMono", "SourceSans" },
		        })
		
		        local ThemesArray = {}
		        for Name, Theme in pairs(self.BuiltInThemes) do
		            table.insert(ThemesArray, Name)
		        end
		
		        table.sort(ThemesArray, function(a, b)
		            return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1]
		        end)
		
		        groupbox:AddDivider()
		
		        groupbox:AddDropdown("ThemeManager_ThemeList", { Text = "Theme list", Values = ThemesArray, Default = 1 })
		        groupbox:AddButton("Set as default", function()
		            self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
		            self.Library:Notify(
		                string.format("Set default theme to %q", self.Library.Options.ThemeManager_ThemeList.Value)
		            )
		        end)
		
		        self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
		            self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
		        end)
		
		        groupbox:AddDivider()
		
		        groupbox:AddInput("ThemeManager_CustomThemeName", { Text = "Custom theme name" })
		        groupbox:AddButton("Create theme", function()
		            local name = self.Library.Options.ThemeManager_CustomThemeName.Value
		
		            if name:gsub(" ", "") == "" then
		                self.Library:Notify("Invalid theme name (empty)", 2)
		                return
		            end
		
		            self:SaveCustomTheme(name)
		
		            self.Library:Notify(string.format("Created theme %q", name))
		            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
		            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		        end)
		
		        groupbox:AddDivider()
		
		        groupbox:AddDropdown(
		            "ThemeManager_CustomThemeList",
		            { Text = "Custom themes", Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 }
		        )
		        groupbox:AddButton("Load theme", function()
		            local name = self.Library.Options.ThemeManager_CustomThemeList.Value
		
		            self:ApplyTheme(name)
		            self.Library:Notify(string.format("Loaded theme %q", name))
		        end)
		        groupbox:AddButton("Overwrite theme", function()
		            local name = self.Library.Options.ThemeManager_CustomThemeList.Value
		
		            self:SaveCustomTheme(name)
		            self.Library:Notify(string.format("Overwrote config %q", name))
		        end)
		        groupbox:AddButton("Delete theme", function()
		            local name = self.Library.Options.ThemeManager_CustomThemeList.Value
		
		            local success, err = self:Delete(name)
		            if not success then
		                self.Library:Notify("Failed to delete theme: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Deleted theme %q", name))
		            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
		            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		        end)
		        groupbox:AddButton("Refresh list", function()
		            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
		            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		        end)
		        groupbox:AddButton("Set as default", function()
		            if
		                self.Library.Options.ThemeManager_CustomThemeList.Value ~= nil
		                and self.Library.Options.ThemeManager_CustomThemeList.Value ~= ""
		            then
		                self:SaveDefault(self.Library.Options.ThemeManager_CustomThemeList.Value)
		                self.Library:Notify(
		                    string.format("Set default theme to %q", self.Library.Options.ThemeManager_CustomThemeList.Value)
		                )
		            end
		        end)
		        groupbox:AddButton("Reset default", function()
		            local success = pcall(delfile, self.Folder .. "/themes/default.txt")
		            if not success then
		                self.Library:Notify("Failed to reset default: delete file error")
		                return
		            end
		
		            self.Library:Notify("Set default theme to nothing")
		            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
		            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		        end)
		
		        self:LoadDefault()
		        self.AppliedToTab = true
		
		        local function UpdateTheme()
		            self:ThemeUpdate()
		        end
		
		        self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
		        self.Library.Options.MainColor:OnChanged(UpdateTheme)
		        self.Library.Options.AccentColor:OnChanged(UpdateTheme)
		        self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
		        self.Library.Options.FontColor:OnChanged(UpdateTheme)
		        self.Library.Options.FontFace:OnChanged(function(Value)
		            self.Library:SetFont(Enum.Font[Value])
		            self.Library:UpdateColorsUsingRegistry()
		        end)
		    end
		
		    function ThemeManager:CreateGroupBox(tab, icon)
		        assert(self.Library, "Must set ThemeManager.Library first!")
		        return tab:AddLeftGroupbox("Themes", icon or "paintbrush")
		    end
		
		    function ThemeManager:ApplyToTab(tab, icon)
		        assert(self.Library, "Must set ThemeManager.Library first!")
		        local groupbox = self:CreateGroupBox(tab, icon)
		        self:CreateThemeManager(groupbox)
		    end
		
		    function ThemeManager:ApplyToGroupbox(groupbox)
		        assert(self.Library, "Must set ThemeManager.Library first!")
		        self:CreateThemeManager(groupbox)
		    end
		
		    ThemeManager:BuildFolderTree()
		end
		
		getgenv().ObsidianThemeManager = ThemeManager
		return ThemeManager
		-- <<< End embedded: ThemeManager
	end)()
	local lib4 = (function()
		-- >>> Embedded: SaveManager
		local cloneref = (cloneref or clonereference or function(instance: any)
		    return instance
		end)
		local clonefunction = (clonefunction or copyfunction or function(func) 
		    return func 
		end)
		
		local HttpService: HttpService = cloneref(game:GetService("HttpService"))
		local isfolder, isfile, listfiles = isfolder, isfile, listfiles
		
		if typeof(clonefunction) == "function" then
		    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.
		
		    local
		        isfolder_copy,
		        isfile_copy,
		        listfiles_copy = clonefunction(isfolder), clonefunction(isfile), clonefunction(listfiles)
		
		    local isfolder_success, isfolder_error = pcall(function()
		        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
		    end)
		
		    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
		        isfolder = function(folder)
		            local success, data = pcall(isfolder_copy, folder)
		            return (if success then data else false)
		        end
		
		        isfile = function(file)
		            local success, data = pcall(isfile_copy, file)
		            return (if success then data else false)
		        end
		
		        listfiles = function(folder)
		            local success, data = pcall(listfiles_copy, folder)
		            return (if success then data else {})
		        end
		    end
		end
		
		local SaveManager = {} do
		    SaveManager.Folder = "ObsidianLibSettings"
		    SaveManager.SubFolder = ""
		    SaveManager.Ignore = {}
		    SaveManager.Library = nil
		    SaveManager.UseLoadingOrder = false
		    SaveManager.LoadingOrder = {}
		    SaveManager.Parser = {
		        Toggle = {
		            Save = function(idx, object)
		                return { type = "Toggle", idx = idx, value = object.Value }
		            end,
		            Load = function(idx, data)
		                local object = SaveManager.Library.Toggles[idx]
		                if object and object.Value ~= data.value then
		                    object:SetValue(data.value)
		                end
		            end,
		        },
		        Slider = {
		            Save = function(idx, object)
		                return { type = "Slider", idx = idx, value = tostring(object.Value) }
		            end,
		            Load = function(idx, data)
		                local object = SaveManager.Library.Options[idx]
		                if object and object.Value ~= data.value then
		                    object:SetValue(data.value)
		                end
		            end,
		        },
		        Dropdown = {
		            Save = function(idx, object)
		                return { type = "Dropdown", idx = idx, value = object.Value, multi = object.Multi }
		            end,
		            Load = function(idx, data)
		                local object = SaveManager.Library.Options[idx]
		                if object and object.Value ~= data.value then
		                    object:SetValue(data.value)
		                end
		            end,
		        },
		        ColorPicker = {
		            Save = function(idx, object)
		                return { type = "ColorPicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
		            end,
		            Load = function(idx, data)
		                if SaveManager.Library.Options[idx] then
		                    SaveManager.Library.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
		                end
		            end,
		        },
		        KeyPicker = {
		            Save = function(idx, object)
		                return { type = "KeyPicker", idx = idx, mode = object.Mode, key = object.Value, modifiers = object.Modifiers }
		            end,
		            Load = function(idx, data)
		                if SaveManager.Library.Options[idx] then
		                    SaveManager.Library.Options[idx]:SetValue({ data.key, data.mode, data.modifiers })
		                end
		            end,
		        },
		        Input = {
		            Save = function(idx, object)
		                return { type = "Input", idx = idx, text = object.Value }
		            end,
		            Load = function(idx, data)
		                local object = SaveManager.Library.Options[idx]
		                if object and object.Value ~= data.text and type(data.text) == "string" then
		                    SaveManager.Library.Options[idx]:SetValue(data.text)
		                end
		            end,
		        },
		    }
		
		    function SaveManager:SetLibrary(library)
		        self.Library = library
		    end
		
		    function SaveManager:SetLoadingOrder(enabled, order)
		        self.UseLoadingOrder = enabled
		
		        if typeof(order) == "table" then
		            self.LoadingOrder = order
		        end
		    end
		
		    function SaveManager:IgnoreThemeSettings()
		        self:SetIgnoreIndexes({
		            "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", "FontFace", -- themes
		            "ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName", -- themes
		        })
		    end
		
		    --// Folders \\--
		    function SaveManager:CheckSubFolder(createFolder)
		        if typeof(self.SubFolder) ~= "string" or self.SubFolder == "" then return false end
		
		        if createFolder == true then
		            if not isfolder(self.Folder .. "/settings/" .. self.SubFolder) then
		                makefolder(self.Folder .. "/settings/" .. self.SubFolder)
		            end
		        end
		
		        return true
		    end
		
		    function SaveManager:GetPaths()
		        local paths = {}
		
		        local parts = self.Folder:split("/")
		        for idx = 1, #parts do
		            local path = table.concat(parts, "/", 1, idx)
		            if not table.find(paths, path) then paths[#paths + 1] = path end
		        end
		
		        paths[#paths + 1] = self.Folder .. "/themes"
		        paths[#paths + 1] = self.Folder .. "/settings"
		
		        if self:CheckSubFolder(false) then
		            local subFolder = self.Folder .. "/settings/" .. self.SubFolder
		            parts = subFolder:split("/")
		
		            for idx = 1, #parts do
		                local path = table.concat(parts, "/", 1, idx)
		                if not table.find(paths, path) then paths[#paths + 1] = path end
		            end
		        end
		
		        return paths
		    end
		
		    function SaveManager:BuildFolderTree()
		        local paths = self:GetPaths()
		
		        for i = 1, #paths do
		            local str = paths[i]
		            if isfolder(str) then continue end
		
		            makefolder(str)
		        end
		    end
		
		    function SaveManager:CheckFolderTree()
		        if isfolder(self.Folder) then return end
		        SaveManager:BuildFolderTree()
		
		        task.wait(0.1)
		    end
		
		    function SaveManager:SetIgnoreIndexes(list)
		        for _, key in pairs(list) do
		            self.Ignore[key] = true
		        end
		    end
		
		    function SaveManager:SetFolder(folder)
		        self.Folder = folder
		        self:BuildFolderTree()
		    end
		
		    function SaveManager:SetSubFolder(folder)
		        self.SubFolder = folder
		        self:BuildFolderTree()
		    end
		
		    --// Save, Load, Delete, Refresh \\--
		    function SaveManager:Save(name)
		        if (not name) then
		            return false, "no config file is selected"
		        end
		        SaveManager:CheckFolderTree()
		
		        local fullPath = self.Folder .. "/settings/" .. name .. ".json"
		        if SaveManager:CheckSubFolder(true) then
		            fullPath = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
		        end
		
		        local data = {
		            objects = {}
		        }
		
		        for idx, toggle in pairs(self.Library.Toggles) do
		            if not toggle.Type then continue end
		            if not self.Parser[toggle.Type] then continue end
		            if self.Ignore[idx] then continue end
		
		            table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
		        end
		
		        for idx, option in pairs(self.Library.Options) do
		            if not option.Type then continue end
		            if not self.Parser[option.Type] then continue end
		            if self.Ignore[idx] then continue end
		
		            table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		        end
		
		        local success, encoded = pcall(HttpService.JSONEncode, HttpService, data)
		        if not success then
		            return false, "failed to encode data"
		        end
		
		        writefile(fullPath, encoded)
		        return true
		    end
		
		    function SaveManager:Load(name)
		        if (not name) then
		            return false, "no config file is selected"
		        end
		        SaveManager:CheckFolderTree()
		
		        local file = self.Folder .. "/settings/" .. name .. ".json"
		        if SaveManager:CheckSubFolder(true) then
		            file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
		        end
		
		        if not isfile(file) then return false, "invalid file" end
		
		        local success, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(file))
		        if not success then return false, "decode error" end
		
		        if self.UseLoadingOrder == true and typeof(self.LoadingOrder) == "table" then
		            table.sort(decoded.objects, function(a, b)
		                local aIndex = table.find(self.LoadingOrder, a.type) or math.huge
		                local bIndex = table.find(self.LoadingOrder, b.type) or math.huge
		                return aIndex < bIndex
		            end)
		        end
		
		        for _, option in decoded.objects do
		            if not option.type then continue end
		            if not self.Parser[option.type] then continue end
		            if self.Ignore[option.idx] then continue end
		
		            task.spawn(self.Parser[option.type].Load, option.idx, option) -- task.spawn() so the config loading wont get stuck.
		        end
		
		        return true
		    end
		
		    function SaveManager:Delete(name)
		        if (not name) then
		            return false, "no config file is selected"
		        end
		
		        local file = self.Folder .. "/settings/" .. name .. ".json"
		        if SaveManager:CheckSubFolder(true) then
		            file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
		        end
		
		        if not isfile(file) then return false, "invalid file" end
		
		        local success = pcall(delfile, file)
		        if not success then return false, "delete file error" end
		
		        return true
		    end
		
		    function SaveManager:RefreshConfigList()
		        local success, data = pcall(function()
		            SaveManager:CheckFolderTree()
		
		            local list = {}
		            local out = {}
		
		            if SaveManager:CheckSubFolder(true) then
		                list = listfiles(self.Folder .. "/settings/" .. self.SubFolder)
		            else
		                list = listfiles(self.Folder .. "/settings")
		            end
		            if typeof(list) ~= "table" then list = {} end
		
		            for i = 1, #list do
		                local file = list[i]
		                if file:sub(-5) == ".json" then
		                    -- i hate this but it has to be done ...
		
		                    local pos = file:find(".json", 1, true)
		                    local start = pos
		
		                    local char = file:sub(pos, pos)
		                    while char ~= "/" and char ~= "\\" and char ~= "" do
		                        pos = pos - 1
		                        char = file:sub(pos, pos)
		                    end
		
		                    if char == "/" or char == "\\" then
		                        table.insert(out, file:sub(pos + 1, start - 1))
		                    end
		                end
		            end
		
		            return out
		        end)
		
		        if (not success) then
		            if self.Library then
		                self.Library:Notify("Failed to load config list: " .. tostring(data))
		            else
		                warn("Failed to load config list: " .. tostring(data))
		            end
		
		            return {}
		        end
		
		        return data
		    end
		
		    --// Auto Load \\--
		    function SaveManager:GetAutoloadConfig()
		        SaveManager:CheckFolderTree()
		
		        local autoLoadPath = self.Folder .. "/settings/autoload.txt"
		        if SaveManager:CheckSubFolder(true) then
		            autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
		        end
		
		        if isfile(autoLoadPath) then
		            local successRead, name = pcall(readfile, autoLoadPath)
		            if not successRead then
		                return "none"
		            end
		
		            name = tostring(name)
		            return if name == "" then "none" else name
		        end
		
		        return "none"
		    end
		
		    function SaveManager:LoadAutoloadConfig()
		        SaveManager:CheckFolderTree()
		
		        local autoLoadPath = self.Folder .. "/settings/autoload.txt"
		        if SaveManager:CheckSubFolder(true) then
		            autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
		        end
		
		        if isfile(autoLoadPath) then
		            local successRead, name = pcall(readfile, autoLoadPath)
		            if not successRead then
		                self.Library:Notify("Failed to load autoload config: write file error")
		                return
		            end
		
		            local success, err = self:Load(name)
		            if not success then
		                self.Library:Notify("Failed to load autoload config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Auto loaded config %q", name))
		        end
		    end
		
		    function SaveManager:SaveAutoloadConfig(name)
		        SaveManager:CheckFolderTree()
		
		        local autoLoadPath = self.Folder .. "/settings/autoload.txt"
		        if SaveManager:CheckSubFolder(true) then
		            autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
		        end
		
		        local success = pcall(writefile, autoLoadPath, name)
		        if not success then return false, "write file error" end
		
		        return true, ""
		    end
		
		    function SaveManager:DeleteAutoLoadConfig()
		        SaveManager:CheckFolderTree()
		
		        local autoLoadPath = self.Folder .. "/settings/autoload.txt"
		        if SaveManager:CheckSubFolder(true) then
		            autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
		        end
		
		        local success = pcall(delfile, autoLoadPath)
		        if not success then return false, "delete file error" end
		
		        return true, ""
		    end
		
		    --// GUI \\--
		    function SaveManager:BuildConfigSection(tab, icon)
		        assert(self.Library, "Must set SaveManager.Library")
		
		        local section = tab:AddRightGroupbox("Configuration", icon or "folder-cog")
		
		        section:AddInput("SaveManager_ConfigName",    { Text = "Config name" })
		        section:AddButton("Create config", function()
		            local name = self.Library.Options.SaveManager_ConfigName.Value
		
		            if name:gsub(" ", "") == "" then
		                self.Library:Notify("Invalid config name (empty)", 2)
		                return
		            end
		
		            local success, err = self:Save(name)
		            if not success then
		                self.Library:Notify("Failed to create config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Created config %q", name))
		            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
		            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
		        end)
		
		        section:AddDivider()
		
		        section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })
		        section:AddButton("Load config", function()
		            local name = self.Library.Options.SaveManager_ConfigList.Value
		
		            local success, err = self:Load(name)
		            if not success then
		                self.Library:Notify("Failed to load config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Loaded config %q", name))
		        end)
		        section:AddButton("Overwrite config", function()
		            local name = self.Library.Options.SaveManager_ConfigList.Value
		
		            local success, err = self:Save(name)
		            if not success then
		                self.Library:Notify("Failed to overwrite config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Overwrote config %q", name))
		        end)
		
		        section:AddButton("Delete config", function()
		            local name = self.Library.Options.SaveManager_ConfigList.Value
		
		            local success, err = self:Delete(name)
		            if not success then
		                self.Library:Notify("Failed to delete config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Deleted config %q", name))
		            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
		            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
		        end)
		
		        section:AddButton("Refresh list", function()
		            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
		            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
		        end)
		
		        section:AddButton("Set as autoload", function()
		            local name = self.Library.Options.SaveManager_ConfigList.Value
		
		            local success, err = self:SaveAutoloadConfig(name)
		            if not success then
		                self.Library:Notify("Failed to set autoload config: " .. err)
		                return
		            end
		
		            self.Library:Notify(string.format("Set %q to auto load", name))
		            self.AutoloadConfigLabel:SetText("Current autoload config: " .. name)
		        end)
		        section:AddButton("Reset autoload", function()
		            local success, err = self:DeleteAutoLoadConfig()
		            if not success then
		                self.Library:Notify("Failed to set autoload config: " .. err)
		                return
		            end
		
		            self.Library:Notify("Set autoload to none")
		            self.AutoloadConfigLabel:SetText("Current autoload config: none")
		        end)
		
		        self.AutoloadConfigLabel = section:AddLabel("Current autoload config: " .. self:GetAutoloadConfig(), true)
		
		        -- self:LoadAutoloadConfig()
		        self:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
		    end
		
		    SaveManager:BuildFolderTree()
		end
		
		return SaveManager
		-- <<< End embedded: SaveManager
	end)()
	local options = lib2.Options
	local toggles = lib2.Toggles
	lib2.ForceCheckbox = false
	lib2.ShowToggleFrameInKeybinds = true

	local v3 = lib2:CreateWindow({
		Title = "JEJE LOL",
		AutoShow = true,
		MenuFadeTime = 0.2,
		Footer = "JEJE LOL " .. tbl2.version .. " | Checking Authentication...",
		Font = Font.fromEnum(Enum.Font.SourceSans),
		Size = UDim2.fromOffset(450, 280),
		IconSize = UDim2.fromOffset(40, 40),
		Center = true,
		CornerRadius = 10,
		Icon = tbl2.icon,
		ShowCustomCursor = false,
		EnableSidebarResize = false,
		EnableCompacting = true,
		SidebarCompacted = true,
	})

	local tbl17 = {}

	local function fn64()
		v3:SetFooter("JEJE LOL " .. tbl2.version .. " | " .. (flag and "VIP Script" or "Free Script"))
		tbl17.Surv = v3:AddTab("Survivor", "shield-plus", "Fitur tambahan untuk team survivor")
		tbl17.Killer = v3:AddTab("Killer", "skull", "Fitur tambahan untuk team killer")
		tbl17.Tele = v3:AddTab("Teleport", "map-pinned", "Teleport instan")
		tbl17.Esp = v3:AddTab("ESP", "eye", "Esp semua objek dalam map")
		tbl17.Aim = v3:AddTab("Aim", "crosshair", "Op aim")
		tbl17.Misc = v3:AddTab("Misc", "sliders-horizontal")
		tbl17.Config = v3:AddTab("Config", "settings")
		tbl17.Info = v3:AddTab("Info", "badge-info")
		local v4 = tbl17.Surv:AddLeftGroupbox("Auto Bot", "step-forward")
		local v5 = tbl17.Surv:AddRightGroupbox("Auto feature", "zap")
		local v6 = tbl17.Surv:AddLeftGroupbox("Survivor Skill", "shield")
		local v7 = tbl17.Killer:AddLeftGroupbox("Killer Settings", "skull")
		local v8 = tbl17.Killer:AddRightGroupbox("Skill Killer", "target")

		v4:AddToggle("Surv_DoubleGenToggle", {
			Text = "Multi Generator",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Default = false,
			Content = "Multi Generator",
			Switch = true,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Tooltip = "Repair generator multi poin",
			Callback = function(arg)
				fn35(arg)
			end,
		}):AddKeyPicker("Surv_DoubleGenToggle", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Multi gen", NoUI = false })

		v4:AddToggle("Auto_MasterSurvivor", {
			Text = "Gen + Escape",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(autoAutoSurvivor)
				if autoAutoSurvivor and fn5() == "Killer" then
					fn2("Akses Ditolak: Auto Gen hanya untuk Survivor!", 4)
					tbl3.AUTO_AutoSurvivor = false

					task.defer(function()
						toggles.Auto_MasterSurvivor:SetValue(false)
					end)

					return
				end

				tbl3.AUTO_AutoSurvivor = autoAutoSurvivor

				if not autoAutoSurvivor then
					task.spawn(fn31)
				else
					task.spawn(function()
						while true do
							if tbl3.AUTO_AutoSurvivor and not tbl6.Unloaded then
								task.wait(2)

								if tbl3.AUTO_AutoSurvivor then
									if fn5() == "Survivor" then
										local n3 = #tbl9.Generators
										local n4 = 0

										for _, generator2 in ipairs(tbl9.Generators) do
											if (generator2.model:GetAttribute("RepairProgress") or generator2.model:FindFirstChild("RepairProgress") and generator2.model.RepairProgress.Value or 0) >= 100 then
												n4 += 1
											end
										end

										if n3 >= 5 and n4 >= 5 then
											if tbl3.AUTO_Generator then
												task.spawn(fn31)
											end

											tbl3.AUTO_AutoSurvivor = false

											task.defer(function()
												toggles.Auto_MasterSurvivor:SetValue(false)
											end)

											if fn14() then
												fn2("Berhasil teleportasi ke jalan keluar!", 3)
											end

											continue
										else
											local v9 = fn10()
											local v10 = fn32()

											if v9 <= tbl3.AUTO_LeaveDist then
												if tbl3.AUTO_Generator then
													task.spawn(fn31)
													task.wait(0.5)
												end

												if tbl3.AUTO_AutoSurvivor then
													if v10 then
														fn34(v10)
														tbl3.AUTO_Generator = true
														fn30()
													else
														fn33()
													end

													continue
												end
											elseif v10 then
												if fn9(v10.part.Position) > 20 then
													if tbl3.AUTO_Generator then
														task.spawn(fn31)
														task.wait(0.5)
													end

													if tbl3.AUTO_AutoSurvivor then
														fn34(v10)
														tbl3.AUTO_Generator = true
														fn30()
														continue
													end
												else
													tbl3.AUTO_Generator = true
													fn30()
													continue
												end
											else
												continue
											end
										end
									else
										continue
									end
								end
							end

							break
						end
					end)
				end
			end,
		})

		v4:AddSlider("Auto_LeaveDist", {
			Text = "Distance from Killer",
			Min = 20,
			Max = 100,
			Default = 45,
			Rounding = 0,
			Callback = function(autoLeaveDist)
				tbl3.AUTO_LeaveDist = autoLeaveDist
			end,
		})

		v4:AddButton({
			Text = "Cancel Gen",
			Func = function()
				if toggles.Auto_MasterSurvivor then
					toggles.Auto_MasterSurvivor:SetValue(false)
				end

				tbl3.AUTO_AutoSurvivor = false
				tbl3.AUTO_Generator = false
				task.spawn(fn31)
			end,
		})

		v5:AddButton({
			Text = "Auto Escape",
			Func = function()
				if fn14() then
					fn2("Berhasil teleportasi ke jalan keluar!", 3)
				else
					fn2("Gagal menemukan jalan keluar!", 3)
				end
			end,
		})

		v5:AddDivider()

		v5:AddButton({
			Text = "Drop All Pallets",
			DoubleClick = true,
			Tooltip = "Drop all pallet?",
			DisabledTooltip = "Pallet has been dropped",
			Func = function()
				task.spawn(function()
					local palletDropEvent = nil

					for i = 1, 5 do
						local remotes2 = tbl.ReplicatedStorage:FindFirstChild("Remotes")

						if remotes2 and remotes2:FindFirstChild("Pallet") then
							palletDropEvent = remotes2.Pallet:FindFirstChild("PalletDropEvent")
							if not palletDropEvent then
								task.wait(0.5)
								continue
							end
						else
							task.wait(0.5)
							continue
						end

						break
					end

					if not palletDropEvent then
						fn2("Error: PalletDropEvent belum ditemukan!", 3)
						return
					end
					local n3 = 0

					for _, pallet in ipairs(tbl9.Pallets) do
						local model = pallet.model
						local trigger = pallet.trigger

						if not trigger then
							if model then
								trigger = model:FindFirstChild("PalletPointSlide", true) or model:FindFirstChild("PalletPoint", true)
							else
								trigger = model
							end
						end

						if trigger then
							pcall(function()
								palletDropEvent:FireServer(trigger)
							end)

							n3 += 1
						end
					end

					fn2("Berhasil Drop " .. n3 .. " Pallet.", 3)
				end)
			end,
		})

		v5:AddToggle("AntiBlockWindowToggle", {
			Text = "Anti Block Window",
			Content = "Infinite vault",
			Switch = true,
			Default = false,
			Risky = true,
			Tooltip = "Otomatis menghapus duri/blokir pada jendela di sekitarmu",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				if not arg then
					if tbl6.blockThread then
						task.cancel(tbl6.blockThread)
						tbl6.blockThread = nil
					end

					return
				end

				tbl6.blockThread = task.spawn(function()
					local CollectionService = game:GetService("CollectionService")

					while task.wait(1) do
						pcall(function()
							local character = tbl.LocalPlayer.Character
							if not character or not character:FindFirstChild("HumanoidRootPart") then
								return
							end
							local humanoidRootPart2 = character.HumanoidRootPart

							for _, v9 in ipairs({ "BlockedVault", "BlockedWindow", "Blocked", "EntityBlocker" }) do
								for _, v10 in ipairs(CollectionService:GetTagged(v9)) do
									CollectionService:RemoveTag(v10, v9)
								end
							end

							local partBoundsInRadius = tbl.Workspace:GetPartBoundsInRadius(humanoidRootPart2.Position, 40)

							for _, partBoundsInRadiu in ipairs(partBoundsInRadius) do
								if partBoundsInRadiu:GetAttribute("Blocked") ~= nil then
									partBoundsInRadiu:SetAttribute("Blocked", false)
								end

								if partBoundsInRadiu:GetAttribute("IsBlocked") ~= nil then
									partBoundsInRadiu:SetAttribute("IsBlocked", false)
								end

								if partBoundsInRadiu:GetAttribute("Spiked") ~= nil then
									partBoundsInRadiu:SetAttribute("Spiked", false)
								end

								local str3 = partBoundsInRadiu.Name:lower()

								if str3:match("spike") or str3:match("blocker") or str3:match("entity") then
									if partBoundsInRadiu.CanCollide == true then
										partBoundsInRadiu.CanCollide = false
									end

									if partBoundsInRadiu.Transparency ~= 1 then
										partBoundsInRadiu.Transparency = 1
									end
								end
							end
						end)
					end
				end)
			end,
		})

		v5:AddToggle("Surv_AutoPalletToggle", {
			Text = "Auto Drop Pallet",
			Tooltip = "Otomatis menjatuhkan pallet.",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				fn16(arg)
			end,
		}):AddKeyPicker("Surv_AutoPalletKey", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Auto Pallet",
			NoUI = false,
		})

		v5:AddCheckbox("Surv_AutoPalletSF", {
			Text = "Pallet Save Team",
			Default = false,
			Tooltip = "Selamat kan teman ketika carry",
			Callback = function(survAutoPalletSF)
				tbl3.Surv_AutoPalletSF = survAutoPalletSF
			end,
		})

		v5:AddCheckbox("Surv_AutoPalletSM", {
			Text = "Safe Mode",
			Default = true,
			Tooltip = "Blocked drop pallet ketika knock.",
			Callback = function(survAutoPalletSM)
				tbl3.Surv_AutoPalletSM = survAutoPalletSM
			end,
		})

		v5:AddSlider("Surv_AutoPalletRadius", {
			Text = "Radius Pallet",
			Min = 5,
			Max = 20,
			Default = 10,
			Rounding = 0,
			Callback = function(survAutoPalletRadius)
				tbl3.Surv_AutoPalletRadius = survAutoPalletRadius
			end,
		})

		v5:AddDivider("Auto menu")

		v5:AddToggle("Surv_SelfHeal", {
			Text = "self progres Heal",
			Content = "Heal",
			Switch = true,
			Default = false,
			Callback = function(survSelfHeal)
				tbl3.Surv_SelfHeal = survSelfHeal
			end,
		}):AddKeyPicker("Surv_KeyHeal", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle self heal",
			NoUI = false,
		})

		v5:AddCheckbox("Surv_AutoHeal", {
			Text = "Auto Heal Team",
			Default = false,
			Callback = function(survAuraHeal)
				tbl3.Surv_AuraHeal = survAuraHeal
			end,
		})

		v5:AddDivider("parry menu")

		v5:AddToggle("Surv_Parry", {
			Text = "Auto Parry V1",
			Content = "Auto Parry",
			Switch = true,
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(survParry)
				tbl3.Surv_Parry = survParry

				if survParry then
					toggles.Surv_ParryV2:SetValue(false)
				end
			end,
		}):AddKeyPicker("Surv_ParryKey", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Auto Parry",
			NoUI = false,
		})

		v5:AddToggle("Surv_ParryV2", {
			Text = "Auto Parry V2",
			Content = "Auto Parry v2",
			Switch = true,
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(survParryV2)
				tbl3.Surv_ParryV2 = survParryV2
				fn55(survParryV2)

				if survParryV2 then
					toggles.Surv_Parry:SetValue(false)
				end
			end,
		}):AddKeyPicker("Surv_ParryV2Key", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Auto Parry V2",
			NoUI = false,
		})

		v5:AddToggle("Fake_Parry", {
			Text = "Fake Parry (keybind R)",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				if arg then
					pcall(function()
						do
-- >>> Embedded: FAKE PARRY source
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

if getgenv().VD_FakeParry_Cleanup then
    pcall(getgenv().VD_FakeParry_Cleanup)
end

local FakeParryGui = nil
local KeybindConn = nil

local currentParryTrack = nil 

local ParryAnimations = {
    ["StopWatch"] = "rbxassetid://81793464499285",
    ["Enten"] = "rbxassetid://127096285501517",
    ["Default"] = "rbxassetid://109133187196613",
    ["BloodShield"] = "rbxassetid://75939529748815",
    ["Fih"] = "rbxassetid://123307242865945",
    ["Feedbacker"] = "rbxassetid://126894569253341"
}

local function stopFakeParryInternal()
    if currentParryTrack then
        currentParryTrack:Stop()
        currentParryTrack:Destroy()
        currentParryTrack = nil
    end
end

local function playFakeParryInternal()
    stopFakeParryInternal()
    
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not hum or hum.Health <= 0 then return end
    
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then 
        animator = Instance.new("Animator")
        animator.Parent = hum
    end

    local equippedSkin = LP:GetAttribute("EquippedSkin_Parrying_Dagger")
    
    local animId = ParryAnimations[equippedSkin]
    if not animId then
        animId = ParryAnimations["Default"]
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    
    currentParryTrack = animator:LoadAnimation(anim)
    currentParryTrack.Looped = false
    currentParryTrack:Play()
end

-- Menyimpan fungsi play ke global agar bisa dipanggil keybind meskipun GUI tidak ada
getgenv().VD_PlayFakeParry = playFakeParryInternal

local function destroyFakeParryGui()
    if FakeParryGui then
        FakeParryGui:Destroy()
        FakeParryGui = nil
    end
end

local function createFakeParryGui()
    destroyFakeParryGui()
    
    local targetParent = pcall(function() return CoreGui.Name end) and CoreGui or LP:WaitForChild("PlayerGui")
    
    FakeParryGui = Instance.new("ScreenGui")
    FakeParryGui.Name = "VD_FakeParry"
    FakeParryGui.ResetOnSpawn = false
    FakeParryGui.Parent = targetParent
    
    local frame = Instance.new("Frame")
    frame.Name = "Frame"
    frame.Parent = FakeParryGui
    frame.Size = UDim2.fromOffset(160, 90)
    frame.Position = UDim2.fromScale(0.75, 0.25)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.1
    frame.Active = true
    frame.Draggable = false
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Name = "UIStroke"
    stroke.Parent = frame
    stroke.Color = Color3.fromRGB(255, 150, 100)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3

    local dragPill = Instance.new("Frame")
    dragPill.Name = "DragPill"
    dragPill.Parent = frame
    dragPill.Size = UDim2.fromOffset(50, 6)
    dragPill.AnchorPoint = Vector2.new(0.5, 1)
    dragPill.Position = UDim2.new(0.5, 0, 0, -8)
    dragPill.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    dragPill.BackgroundTransparency = 0.4
    dragPill.BorderSizePixel = 0
    dragPill.Active = true
    Instance.new("UICorner", dragPill).CornerRadius = UDim.new(1, 0) 

    local dragging = false
    local dragInput, dragStart, startPos

    dragPill.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragPill.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, -48, 0, 22)
    title.Position = UDim2.fromOffset(0, 3)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Text = "FAKE PARRY"
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Parent = frame
    minimizeBtn.Size = UDim2.fromOffset(18, 18)
    minimizeBtn.Position = UDim2.new(1, -44, 0, 4)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 60)
    minimizeBtn.Text = "—"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 12
    minimizeBtn.TextColor3 = Color3.new(1,1,1)
    minimizeBtn.BorderSizePixel = 0
    Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 5)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = frame
    closeBtn.Size = UDim2.fromOffset(18, 18)
    closeBtn.Position = UDim2.new(1, -22, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 10
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BorderSizePixel = 0
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
    
    local keybindLbl = Instance.new("TextLabel")
    keybindLbl.Parent = frame
    keybindLbl.Size = UDim2.new(1,0,0,14)
    keybindLbl.Position = UDim2.fromOffset(0,35)
    keybindLbl.BackgroundTransparency = 1
    keybindLbl.Font = Enum.Font.Gotham
    keybindLbl.TextSize = 10
    keybindLbl.TextColor3 = Color3.fromRGB(180,180,180)
    keybindLbl.Text = "Press R to Play"
    
    local playBtn = Instance.new("TextButton")
    playBtn.Name = "PlayBtn"
    playBtn.Parent = frame
    playBtn.Size = UDim2.fromOffset(140,26)
    playBtn.Position = UDim2.fromOffset(10,55)
    playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    playBtn.Text = "PLAY"
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextSize = 11
    playBtn.TextColor3 = Color3.new(1,1,1)
    playBtn.BorderSizePixel = 0
    Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0,6)
    
    playBtn.MouseButton1Down:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    end)
    playBtn.MouseButton1Up:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    end)
    playBtn.MouseLeave:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    end)
    
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            frame.Size = UDim2.fromOffset(160, 28)
            keybindLbl.Visible = false
            playBtn.Visible = false
            minimizeBtn.Text = "+"
        else
            frame.Size = UDim2.fromOffset(160, 90)
            keybindLbl.Visible = true
            playBtn.Visible = true
            minimizeBtn.Text = "—"
        end
    end)
    
    playBtn.MouseButton1Click:Connect(playFakeParryInternal)
    
    closeBtn.MouseButton1Click:Connect(function()
        if getgenv().VD_FakeParry_Cleanup then
            pcall(getgenv().VD_FakeParry_Cleanup)
        end
    end)
end

-- ==========================================
-- DETEKSI PLATFORM DAN EKSEKUSI
-- ==========================================

local platformAttr = LP:GetAttribute("platform")
local isMobile = false

if platformAttr then
    isMobile = (platformAttr == "Mobile")
else
    isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

if isMobile then
    createFakeParryGui()
end

KeybindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        if getgenv().VD_PlayFakeParry then
            getgenv().VD_PlayFakeParry()
        end
    end
end)

getgenv().VD_FakeParry_Cleanup = function()
    stopFakeParryInternal()
    destroyFakeParryGui()
    if KeybindConn then KeybindConn:Disconnect() KeybindConn = nil end
    getgenv().VD_PlayFakeParry = nil
    getgenv().VD_FakeParry_Cleanup = nil
end
-- <<< End embedded: FAKE PARRY source
end
					end)
				elseif getgenv().VD_FakeParry_Cleanup then
					pcall(getgenv().VD_FakeParry_Cleanup)
				end
			end,
		})

		v5:AddCheckbox("Surv_ParrySafety", {
			Text = "Safety Parry",
			Default = false,
			Callback = function(survParrySafety)
				tbl3.Surv_ParrySafety = survParrySafety
			end,
		})

		v5:AddCheckbox("Surv_ParryAggressive", {
			Text = "Aggressive parry V1",
			Default = false,
			Callback = function(survParryAggressive)
				tbl3.Surv_ParryAggressive = survParryAggressive
			end,
		})

		v5:AddCheckbox("Surv_ParryCircle", {
			Text = "Esp Range",
			Default = true,
			Callback = function(survParryCircle)
				tbl3.Surv_ParryCircle = survParryCircle
			end,
		})

		v5:AddSlider("Surv_ParryRadius", {
			Text = "Parry Radius",
			Min = 5,
			Max = 25,
			Default = tbl3.Surv_ParryRadius,
			Rounding = 0,
			Callback = function(survParryRadius)
				tbl3.Surv_ParryRadius = survParryRadius
			end,
		})

		v5:AddSlider("Surv_ParryFace", {
			Text = "Face Sensitivity",
			Min = -10,
			Max = 10,
			Default = tbl3.Surv_ParryFace * 10,
			Rounding = 0,
			Callback = function(arg)
				tbl3.Surv_ParryFace = arg / 10
			end,
		})

		v5:AddDropdown("Surv_IgnoreSkillsList", {
			Text = "Ignore Skills",
			Values = { "Hidden S1", "Abyssal S1" },
			Default = {},
			Multi = true,
			Callback = function(ignoredSkillsList)
				tbl3.Ignored_Skills_List = ignoredSkillsList
			end,
		})

		v5:AddDivider("flee menu")

		v5:AddToggle("Surv_AutoFleeToggle", {
			Text = "Flee killer",
			Tooltip = "Menjauh dari killer saat knok",
			Default = false,
			Callback = function(survAutoFlee)
				tbl3.Surv_AutoFlee = survAutoFlee

				if survAutoFlee then
					if tbl6.FleeThread then
						task.cancel(tbl6.FleeThread)
					end

					tbl6.FleeThread = task.spawn(function()
						while tbl3.Surv_AutoFlee and not tbl6.Unloaded do
							task.wait(0.1)

							if fn5() == "Survivor" then
								local character = tbl.LocalPlayer.Character
								local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
								local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
								local flag3 = character and character:GetAttribute("Knocked") == true
								character = character and character:GetAttribute("IsHooked") == true

								if humanoidRootPart2 and humanoid2 and humanoid2.Health > 0 and flag3 and not character then
									local survFleeDistance = tbl3.Surv_FleeDistance
									local v9 = nil

									for _, player in ipairs(tbl.Players:GetPlayers()) do
										if player ~= tbl.LocalPlayer and fn6(player) and player.Character then
											local humanoidRootPart3 = player.Character:FindFirstChild("HumanoidRootPart")

											if humanoidRootPart3 then
												local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

												if magnitude < survFleeDistance then
													survFleeDistance = magnitude
													v9 = humanoidRootPart3
												end
											end
										end
									end

									if v9 then
										local n3 = humanoidRootPart2.Position - v9.Position
										local unit = Vector3.new(n3.X, 0, n3.Z).Unit

										if unit.Magnitude == unit.Magnitude then
											local n4 = v9.Position + unit * (tbl3.Surv_FleeDistance + 5)
											humanoidRootPart2.CFrame = CFrame.new(n4.X, humanoidRootPart2.Position.Y + 2, n4.Z)
										end
									end
								end
							end
						end
					end)
				elseif tbl6.FleeThread then
					task.cancel(tbl6.FleeThread)
					tbl6.FleeThread = nil
				end
			end,
		})

		v5:AddSlider("Surv_FleeDistSlider", {
			Text = "Jarak Auto Flee",
			Min = 10,
			Max = 100,
			Default = 30,
			Rounding = 0,
			Callback = function(survFleeDistance)
				tbl3.Surv_FleeDistance = survFleeDistance
			end,
		})

		v6:AddToggle("Surv_GodMode", {
			Text = "God Mode",
			Default = false,
			Callback = function(survGodMode)
				tbl3.Surv_GodMode = survGodMode
			end,
		})

		v6:AddToggle("Surv_SoundDbd", {
			Text = "Sound DBD",
			Default = false,
			Tooltip = "Mengubah suara skill check ke DBD",
			Callback = function(survSoundDbd)
				tbl3.Surv_SoundDbd = survSoundDbd
				local character = tbl.LocalPlayer.Character

				if character then
					fn40(character)
				end
			end,
		})

		v6:AddToggle("Surv_AutoSprintToggle", {
			Text = "Auto Sprint (Mobile)",
			Default = false,
			Tooltip = "Otomatis lari saat bergerak",
			Callback = function(survAutoSprint)
				tbl3.Surv_AutoSprint = survAutoSprint

				if survAutoSprint then
					if tbl6.AutoSprintThread then
						task.cancel(tbl6.AutoSprintThread)
					end

					tbl6.AutoSprintThread = task.spawn(function()
						while tbl3.Surv_AutoSprint and not tbl6.Unloaded do
							task.wait(0.1)
							local character = tbl.LocalPlayer.Character
							local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")

							if character and humanoid2 and humanoid2.Health > 0 and not fn11(character) and not fn12(character) then
								if not (character:GetAttribute("Crouching") == true) then
									if humanoid2.MoveDirection.Magnitude > 0 then
										local attribute = character:GetAttribute("Sprinting")

										if type(attribute) ~= "boolean" then
											local sprinting = character:FindFirstChild("Sprinting")
											local isBoolValue = sprinting and sprinting:IsA("BoolValue")
											attribute = false

											if isBoolValue then
												attribute = sprinting.Value
											end
										end

										if not attribute then
											local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
											local sprint = playerGui and playerGui:FindFirstChild("Survivor-mob") and playerGui["Survivor-mob"]:FindFirstChild("Controls") and playerGui["Survivor-mob"].Controls:FindFirstChild("sprint")

											if sprint and sprint.Visible then
												if type(firesignal) == "function" then
													pcall(function()
														firesignal(sprint.MouseButton1Click)
													end)
												elseif type(firesignal) == "table" then
													pcall(function()
														sprint.MouseButton1Click:Fire()
													end)
												end
											end
										end
									end
								end
							end
						end
					end)
				elseif tbl6.AutoSprintThread then
					task.cancel(tbl6.AutoSprintThread)
					tbl6.AutoSprintThread = nil
				end
			end,
		})

		local function fn65()
			local survAutoSkillCheck = tbl3.Surv_AutoSkillCheck
			local survSkillCheckMode = tbl3.Surv_SkillCheckMode
			local v9 = tbl3
			local survPerfectSkill

			if survAutoSkillCheck then
				survPerfectSkill = survSkillCheckMode == "Legit" or survSkillCheckMode == "Instan" or survSkillCheckMode == "Normal" or survSkillCheckMode == "Random"
			else
				survPerfectSkill = survAutoSkillCheck
			end

			v9.Surv_PerfectSkill = survPerfectSkill
			tbl3.Surv_InstanSkill = survAutoSkillCheck and survSkillCheckMode == "Instan"
			tbl3.Surv_NoSkill = survAutoSkillCheck and survSkillCheckMode == "Skip"

			task.spawn(function()
				local character = tbl.LocalPlayer.Character

				if character then
					local skillcheckGen = character:FindFirstChild("Skillcheck-gen")
					local skillcheckPlayer = character:FindFirstChild("Skillcheck-player")

					if skillcheckGen then
						skillcheckGen.Disabled = tbl3.Surv_NoSkill
					end

					if skillcheckPlayer then
						skillcheckPlayer.Disabled = tbl3.Surv_NoSkill
					end
				end
			end)
		end

		v6:AddToggle("Surv_AutoSkillCheck", {
			Text = "Auto Skill Check",
			Default = false,
			Callback = function(survAutoSkillCheck)
				tbl3.Surv_AutoSkillCheck = survAutoSkillCheck
				fn65()
			end,
		})

		v6:AddDropdown("Surv_SkillCheckMode", {
			Text = "Mode",
			Values = { "Legit", "Instan", "Skip", "Normal", "Random" },
			Default = 1,
			Multi = false,
			Tooltip = [[Instan: Auto nge-hit
Legit: Nunggu jarum pas
Normal: Safe zone lebar
Random: Perfect pertama, lalu Normal jika kena King Scourge]],
			Callback = function(survSkillCheckMode)
				tbl3.Surv_SkillCheckMode = survSkillCheckMode
				fn65()
			end,
		})

		v6:AddToggle("Surv_AntiFailGen", {
			Text = "Anti fail Gene",
			Default = false,
			Tooltip = "Memblokir gen meledak saat gagal",
			Callback = function(survAutoCancelGene)
				tbl3.Surv_AutoCancelGene = survAutoCancelGene
			end,
		})

		local tbl18 = {}

		v6:AddToggle("Surv_InstantGate", {
			Text = "Instant Teleport",
			Content = "Teleport",
			Switch = true,
			Default = false,
			Tooltip = "Durasi gate 0 detik",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(survInstantGate)
				tbl3.Surv_InstantGate = survInstantGate

				task.spawn(function()
					local ok, result = pcall(function()
						return require(tbl.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Items"):WaitForChild("GateClient"))
					end)

					if not ok or not result then
						if survInstantGate and getgenv().Library then
							fn2("Gagal!", 3)
						end

						return
					end

					if survInstantGate then
						if not tbl18._isLowHealth then
							tbl18._isLowHealth = result._isLowHealth
						end

						if not tbl18.StartGate then
							tbl18.StartGate = result.StartGate
						end

						result._isLowHealth = function()
							return false
						end

						result.StartGate = function(arg)
							arg.gateDuration = 0
							return tbl18.StartGate(arg)
						end
					else
						if tbl18._isLowHealth then
							result._isLowHealth = tbl18._isLowHealth
						end

						if tbl18.StartGate then
							result.StartGate = tbl18.StartGate
						end
					end
				end)
			end,
		})

		v6:AddToggle("Surv_AutoCrouch", {
			Text = "Auto Crouch dodge",
			Default = false,
			Callback = function(survAutoCrouch)
				tbl3.Surv_AutoCrouch = survAutoCrouch
			end,
		})

		v6:AddToggle("Surv_Bandage", {
			Text = "Instan Bandage",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(survBandage)
				tbl3.Surv_Bandage = survBandage
			end,
		})

		v6:AddToggle("Surv_CrouchV", {
			Text = "Auto Crouch Veil",
			Default = false,
			Callback = function(survCrouchV)
				tbl3.Surv_CrouchV = survCrouchV
			end,
		})

		v6:AddToggle("Surv_NoFall", {
			Text = "Anti slow",
			Default = false,
			Callback = function(survNoFall)
				tbl3.Surv_NoFall = survNoFall
			end,
		})

		v6:AddToggle("Surv_Perks", {
			Text = "Perks Mod",
			Default = false,
			Callback = function(survPerks)
				tbl3.Surv_Perks = survPerks
			end,
		}):AddKeyPicker("Surv_PerksKey", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Perks Mod",
			NoUI = false,
		})

		v6:AddCheckbox("Surv_Spdb", {
			Text = "speedboost",
			Default = false,
			Callback = function(survSpdb)
				tbl3.Surv_Spdb = survSpdb
				local character = tbl.LocalPlayer.Character

				if character and fn5() == "Survivor" then
					if survSpdb and tbl3.Surv_Perks then
						character:SetAttribute("speedboost", tbl3.Surv_SpeedBoost)
					else
						character:SetAttribute("speedboost", 1)
					end
				end
			end,
		})

		v6:AddSlider("Surv_SpeedSlider", {
			Text = "Speed Boost Value",
			Min = 10,
			Max = 20,
			Default = 11,
			Rounding = 1,
			Callback = function(arg)
				tbl3.Surv_SpeedBoost = arg / 10
				local character = tbl.LocalPlayer.Character

				if character and tbl3.Surv_Spdb and tbl3.Surv_Perks and not tbl6.VaultBoostActive then
					character:SetAttribute("speedboost", tbl3.Surv_SpeedBoost)
				end
			end,
		})

		v6:AddSlider("Surv_VaultSlider", {
			Text = "Vault Speed",
			Min = 10,
			Max = 20,
			Default = 13,
			Rounding = 1,
			Callback = function(arg)
				tbl3.Surv_VaultSpeed = arg / 10
			end,
		})

		v6:AddDivider("vault mod")

		v6:AddCheckbox("Surv_PerfectVault", {
			Text = "Perfect vault",
			Default = false,
			Callback = function(survPerfectVault)
				tbl3.Surv_PerfectVault = survPerfectVault
			end,
		})

		v6:AddCheckbox("Surv_FastVault", {
			Text = "Flowstate",
			Default = false,
			Callback = function(survFastVault)
				tbl3.Surv_FastVault = survFastVault

				if not survFastVault then
					if tbl6.FlowstateCDThread then
						task.cancel(tbl6.FlowstateCDThread)
						tbl6.FlowstateCDThread = nil
					end

					tbl6.FlowstateOnCD = false
					local character = tbl.LocalPlayer.Character

					if character then
						character:SetAttribute("Flowstate", false)
					end
				end
			end,
		})

		v6:AddSlider("Surv_FlowstateCD_Slider", {
			Text = "Flowstate Cooldown",
			Min = 5,
			Max = 60,
			Default = 20,
			Rounding = 0,
			Callback = function(survFlowstateCD)
				tbl3.Surv_FlowstateCD = survFlowstateCD
			end,
		})

		v6:AddCheckbox("Surv_SpeedAfterVault", {
			Text = "Quick Recovery",
			Default = false,
			Callback = function(survSpeedAfterVault)
				tbl3.Surv_SpeedAfterVault = survSpeedAfterVault
			end,
		})

		v6:AddSlider("Surv_QuickRecovCD_Slider", {
			Text = "Quick Recovery Cooldown",
			Min = 5,
			Max = 60,
			Default = 15,
			Rounding = 0,
			Callback = function(survQuickRecoveryCD)
				tbl3.Surv_QuickRecoveryCD = survQuickRecoveryCD
			end,
		})

		v6:AddDivider("Skill Generator")

		v6:AddSlider("Surv_SkillSpeedSlider", {
			Text = "Skill Check Speed",
			Min = 1,
			Max = 30,
			Default = 10,
			Rounding = 1,
			Callback = function(arg)
				tbl3.Surv_SkillSpeed = arg / 10
			end,
		})

		v6:AddDivider("camera menu")

		v6:AddToggle("Surv_Fov", {
			Text = "Custom FOV",
			Default = false,
			Callback = function(survFov)
				tbl3.Surv_Fov = survFov

				if not survFov then
					tbl.Camera.FieldOfView = 70
				end
			end,
		})

		v6:AddSlider("Surv_FOV_Value", {
			Text = "Field of View",
			Min = 70,
			Max = 120,
			Default = 70,
			Rounding = 0,
			Callback = function(survFovValue)
				tbl3.Surv_FOV_Value = survFovValue
			end,
		})

		v7:AddToggle("Killer_WalkSpeedToggle", {
			Text = "Walk Speed",
			Content = "Walkspeed",
			Switch = true,
			Default = false,
			Callback = function(killerWalkSpeedToggle)
				tbl3.Killer_WalkSpeedToggle = killerWalkSpeedToggle

				if not killerWalkSpeedToggle and tbl.LocalPlayer.Character and tbl.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
					tbl.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tbl6.OriginalSpeed or 16
				end
			end,
		}):AddKeyPicker("Killer_WalkSpeedKey", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Walk Speed",
			NoUI = false,
		})

		v7:AddSlider("Killer_WalkSpeedSlider", {
			Text = "Walk Speed Value",
			Min = 16,
			Max = 300,
			Default = 16,
			Rounding = 0,
			Callback = function(killerWalkSpeed)
				tbl3.Killer_WalkSpeed = killerWalkSpeed
			end,
		})

		v7:AddDivider("attack menu")

		v7:AddDropdown("Killer_AttackModeDrop", {
			Text = "Attack Mode",
			Values = { "BasicAttack", "Lunge" },
			Default = 1,
			Multi = false,
			Callback = function(killerAttackMode)
				tbl3.Killer_AttackMode = killerAttackMode
			end,
		})

		v7:AddToggle("Killer_SpamHit", {
			Text = "One hit",
			Default = false,
			Risky = true,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(killerSpamHit)
				tbl3.Killer_SpamHit = killerSpamHit
			end,
		})

		v7:AddCheckbox("Killer_HitEspCircle", {
			Text = "Show Range",
			Default = true,
			Callback = function(killerHitEspCircle)
				tbl3.Killer_HitEspCircle = killerHitEspCircle
			end,
		})

		v7:AddSlider("Killer_SpamHitRadius", {
			Text = "Hit Radius",
			Min = 5,
			Max = 15,
			Default = 8,
			Rounding = 0,
			Callback = function(killerSpamHitRadius)
				tbl3.Killer_SpamHitRadius = killerSpamHitRadius
			end,
		})

		v7:AddSlider("Killer_SpamHitDelay", {
			Text = "Hit Delay",
			Min = 15,
			Max = 500,
			Default = 50,
			Rounding = 0,
			Callback = function(killerSpamHitDelay)
				tbl3.Killer_SpamHitDelay = killerSpamHitDelay
			end,
		})

		v8:AddToggle("Surv_CounterParryGUI", {
			Text = "Counter Parry",
			Content = "Counter Parry",
			Switch = true,
			Tooltip = "Keybind PC V",
			Default = false,
			Callback = function(arg)
				if arg then
					pcall(function()
						do
-- >>> Embedded: CParry source
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

if getgenv().VD_FakeParry_Cleanup then
    pcall(getgenv().VD_FakeParry_Cleanup)
end

local FakeParryGui = nil
local KeybindConn = nil

local currentParryTrack = nil 

local ParryAnimations = {
    ["StopWatch"] = "rbxassetid://81793464499285",
    ["Enten"] = "rbxassetid://127096285501517",
    ["Default"] = "rbxassetid://109133187196613",
    ["BloodShield"] = "rbxassetid://75939529748815",
    ["Fih"] = "rbxassetid://123307242865945",
    ["Feedbacker"] = "rbxassetid://126894569253341"
}

local function stopFakeParryInternal()
    if currentParryTrack then
        currentParryTrack:Stop()
        currentParryTrack:Destroy()
        currentParryTrack = nil
    end
end

local function playFakeParryInternal()
    stopFakeParryInternal()
    
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not hum or hum.Health <= 0 then return end
    
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then 
        animator = Instance.new("Animator")
        animator.Parent = hum
    end

    local equippedSkin = LP:GetAttribute("EquippedSkin_Parrying_Dagger")
    
    local animId = ParryAnimations[equippedSkin]
    if not animId then
        animId = ParryAnimations["Default"]
    end

    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    
    currentParryTrack = animator:LoadAnimation(anim)
    currentParryTrack.Looped = false
    currentParryTrack:Play()
end

-- Menyimpan fungsi play ke global agar bisa dipanggil keybind meskipun GUI tidak ada
getgenv().VD_PlayFakeParry = playFakeParryInternal

local function destroyFakeParryGui()
    if FakeParryGui then
        FakeParryGui:Destroy()
        FakeParryGui = nil
    end
end

local function createFakeParryGui()
    destroyFakeParryGui()
    
    local targetParent = pcall(function() return CoreGui.Name end) and CoreGui or LP:WaitForChild("PlayerGui")
    
    FakeParryGui = Instance.new("ScreenGui")
    FakeParryGui.Name = "VD_FakeParry"
    FakeParryGui.ResetOnSpawn = false
    FakeParryGui.Parent = targetParent
    
    local frame = Instance.new("Frame")
    frame.Name = "Frame"
    frame.Parent = FakeParryGui
    frame.Size = UDim2.fromOffset(160, 90)
    frame.Position = UDim2.fromScale(0.75, 0.25)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    frame.BackgroundTransparency = 0.1
    frame.Active = true
    frame.Draggable = false
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Name = "UIStroke"
    stroke.Parent = frame
    stroke.Color = Color3.fromRGB(255, 150, 100)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3

    local dragPill = Instance.new("Frame")
    dragPill.Name = "DragPill"
    dragPill.Parent = frame
    dragPill.Size = UDim2.fromOffset(50, 6)
    dragPill.AnchorPoint = Vector2.new(0.5, 1)
    dragPill.Position = UDim2.new(0.5, 0, 0, -8)
    dragPill.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    dragPill.BackgroundTransparency = 0.4
    dragPill.BorderSizePixel = 0
    dragPill.Active = true
    Instance.new("UICorner", dragPill).CornerRadius = UDim.new(1, 0) 

    local dragging = false
    local dragInput, dragStart, startPos

    dragPill.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragPill.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, -48, 0, 22)
    title.Position = UDim2.fromOffset(0, 3)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Text = "FAKE PARRY"
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Parent = frame
    minimizeBtn.Size = UDim2.fromOffset(18, 18)
    minimizeBtn.Position = UDim2.new(1, -44, 0, 4)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 60)
    minimizeBtn.Text = "—"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 12
    minimizeBtn.TextColor3 = Color3.new(1,1,1)
    minimizeBtn.BorderSizePixel = 0
    Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 5)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = frame
    closeBtn.Size = UDim2.fromOffset(18, 18)
    closeBtn.Position = UDim2.new(1, -22, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 10
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BorderSizePixel = 0
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
    
    local keybindLbl = Instance.new("TextLabel")
    keybindLbl.Parent = frame
    keybindLbl.Size = UDim2.new(1,0,0,14)
    keybindLbl.Position = UDim2.fromOffset(0,35)
    keybindLbl.BackgroundTransparency = 1
    keybindLbl.Font = Enum.Font.Gotham
    keybindLbl.TextSize = 10
    keybindLbl.TextColor3 = Color3.fromRGB(180,180,180)
    keybindLbl.Text = "Press R to Play"
    
    local playBtn = Instance.new("TextButton")
    playBtn.Name = "PlayBtn"
    playBtn.Parent = frame
    playBtn.Size = UDim2.fromOffset(140,26)
    playBtn.Position = UDim2.fromOffset(10,55)
    playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    playBtn.Text = "PLAY"
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextSize = 11
    playBtn.TextColor3 = Color3.new(1,1,1)
    playBtn.BorderSizePixel = 0
    Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0,6)
    
    playBtn.MouseButton1Down:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    end)
    playBtn.MouseButton1Up:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    end)
    playBtn.MouseLeave:Connect(function()
        playBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
    end)
    
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            frame.Size = UDim2.fromOffset(160, 28)
            keybindLbl.Visible = false
            playBtn.Visible = false
            minimizeBtn.Text = "+"
        else
            frame.Size = UDim2.fromOffset(160, 90)
            keybindLbl.Visible = true
            playBtn.Visible = true
            minimizeBtn.Text = "—"
        end
    end)
    
    playBtn.MouseButton1Click:Connect(playFakeParryInternal)
    
    closeBtn.MouseButton1Click:Connect(function()
        if getgenv().VD_FakeParry_Cleanup then
            pcall(getgenv().VD_FakeParry_Cleanup)
        end
    end)
end

-- ==========================================
-- DETEKSI PLATFORM DAN EKSEKUSI
-- ==========================================

local platformAttr = LP:GetAttribute("platform")
local isMobile = false

if platformAttr then
    isMobile = (platformAttr == "Mobile")
else
    isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

if isMobile then
    createFakeParryGui()
end

KeybindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        if getgenv().VD_PlayFakeParry then
            getgenv().VD_PlayFakeParry()
        end
    end
end)

getgenv().VD_FakeParry_Cleanup = function()
    stopFakeParryInternal()
    destroyFakeParryGui()
    if KeybindConn then KeybindConn:Disconnect() KeybindConn = nil end
    getgenv().VD_PlayFakeParry = nil
    getgenv().VD_FakeParry_Cleanup = nil
end
-- <<< End embedded: CParry source
end
					end)
				elseif getgenv().CParry then
					pcall(getgenv().CParry)
				end
			end,
		})

		v8:AddToggle("Killer_InfLunge", {
			Text = "Infinite Lunge",
			Default = false,
			Callback = function(killerInfLunge)
				tbl3.Killer_InfLunge = killerInfLunge

				if not killerInfLunge then
					tbl6.isHoldingLunge = false
				end
			end,
		}):AddKeyPicker("Key_InfLunge", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Toggle Lunge", NoUI = false })

		v8:AddToggle("Killer_InfLungeV2", {
			Text = "Infinite Lunge V2",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(killerInfLungeV2)
				tbl3.Killer_InfLungeV2 = killerInfLungeV2
				local character = tbl.LocalPlayer.Character

				if killerInfLungeV2 then
					if character then
						fn61(character)
					end
				else
					if tbl6.lungeV2Connection then
						tbl6.lungeV2Connection:Disconnect()
						tbl6.lungeV2Connection = nil
					end

					if character then
						character:SetAttribute("lungeboost", 1)
					end
				end
			end,
		}):AddKeyPicker("Key_InfLungeV2", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Lunge V2",
			NoUI = false,
		})

		v8:AddToggle("Anti_Blind", {
			Text = "Anti blind",
			Default = false,
			Callback = function(antiBlind)
				tbl3.Anti_Blind = antiBlind
			end,
		})

		v8:AddToggle("Killer_InfAbyssal", {
			Text = "Infinite corrupt Abyssal",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(killerInfAbyssal)
				tbl3.Killer_InfAbyssal = killerInfAbyssal
			end,
		})

		v8:AddToggle("Auto_BlockVault", {
			Text = "Block (windows/pallet)",
			Content = "Block windows",
			Switch = true,
			Default = false,
			Tooltip = "Block all pallet & windows",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				fn21(arg)
			end,
		})

		v8:AddToggle("Killer_BypassCarryToggle", {
			Text = "Bypass Skill Gendong",
			Content = "Bypass Carry",
			Switch = true,
			Tooltip = "Bisa menggunakan Dash/Skill saat menggendong target",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Default = false,
			Callback = function(killerBypassCarry)
				tbl3.Killer_BypassCarry = killerBypassCarry

				if killerBypassCarry and fn5() ~= "Killer" then
					if getgenv().Library then
						fn2("Fitur aktif, berlaku saat jadi Killer!", 3)
					end
				end
			end,
		})

		v8:AddToggle("Killer_NoCDToggle", {
			Text = "NO CD STALKER/HIDDEN",
			Default = false,
			Content = "Bypass CD",
			Switch = true,
			Tooltip = "Bypass untuk spam skill tanpa batas",
			Callback = function(arg)
				fn24(arg)
			end,
		}):AddKeyPicker("Key_NoCDPower", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle NO CD Power",
			NoUI = false,
		})

		v8:AddToggle("Slasher_InvisibleToggle", {
			Text = "INVISIBLE SLASHER",
			Default = false,
			Tooltip = "Spam skill 1 agar invisible",
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				fn25(arg)
			end,
		}):AddKeyPicker("Key_SlasherInvis", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle Invisible Slasher",
			NoUI = false,
		})

		v7:AddToggle("AutoDashLockToggle", {
			Text = "Auto Aim (Hidden)",
			Content = "Auto aim",
			Switch = true,
			Default = false,
			Tooltip = "Auto lock aim hidden",
			Callback = function(arg)
				fn27(arg)
			end,
		})

		v8:AddDivider("skil menu")

		v8:AddSlider("Killer_BreakSpeed", {
			Text = "Break speed",
			Min = 1,
			Max = 10,
			Default = 1,
			Rounding = 0,
			Callback = function(killerBreakSpeed)
				tbl3.Killer_BreakSpeed = killerBreakSpeed
			end,
		})

		local tbl19 = {}

		v8:AddToggle("Killer_3rdPerson", {
			Text = "3rd Person Camera",
			Default = false,
			Callback = function(killer3rdPerson)
				tbl3.Killer_3rdPerson = killer3rdPerson

				if tbl6.ThirdPersonCamConn then
					tbl6.ThirdPersonCamConn:Disconnect()
					tbl6.ThirdPersonCamConn = nil
				end

				if killer3rdPerson then
					tbl19.CameraMode = tbl.LocalPlayer.CameraMode
					tbl19.MinZoom = tbl.LocalPlayer.CameraMinZoomDistance
					tbl19.MaxZoom = tbl.LocalPlayer.CameraMaxZoomDistance
					tbl19.DevComputer = tbl.LocalPlayer.DevComputerCameraMode
					tbl19.DevTouch = tbl.LocalPlayer.DevTouchCameraMode

					local function fn66()
						if fn5() ~= "Killer" then
							return
						end
						local killerCameraMode = tbl3.Killer_CameraMode or "Classic"

						if tbl.LocalPlayer.CameraMode ~= Enum.CameraMode.Classic then
							tbl.LocalPlayer.CameraMode = Enum.CameraMode.Classic
						end

						local huge = tbl3.Misc_InfiniteZoom and math.huge or 40

						if tbl.LocalPlayer.CameraMaxZoomDistance ~= huge then
							tbl.LocalPlayer.CameraMaxZoomDistance = huge
						end

						if tbl.LocalPlayer.CameraMinZoomDistance ~= 7 then
							tbl.LocalPlayer.CameraMinZoomDistance = 7
						end

						tbl.LocalPlayer.DevComputerCameraMode = Enum.DevComputerCameraMovementMode[killerCameraMode] or Enum.DevComputerCameraMovementMode.Classic
						tbl.LocalPlayer.DevTouchCameraMode = Enum.DevTouchCameraMovementMode[killerCameraMode] or Enum.DevTouchCameraMovementMode.Classic
					end

					if fn5() == "Killer" then
						fn66()
					elseif getgenv().Library then
						fn2("3rd Person hanya berlaku saat menjadi Killer!", 3)
					end

					tbl6.ThirdPersonCamConn = tbl.RunService.RenderStepped:Connect(function()
						if fn5() == "Killer" then
							fn66()
						end
					end)
				elseif tbl19.CameraMode then
					tbl.LocalPlayer.CameraMode = tbl19.CameraMode
					tbl.LocalPlayer.CameraMinZoomDistance = tbl19.MinZoom
					tbl.LocalPlayer.CameraMaxZoomDistance = tbl3.Misc_InfiniteZoom and math.huge or tbl19.MaxZoom
					tbl.LocalPlayer.DevComputerCameraMode = tbl19.DevComputer
					tbl.LocalPlayer.DevTouchCameraMode = tbl19.DevTouch
				else
					tbl.LocalPlayer.CameraMode = Enum.CameraMode.Classic
					tbl.LocalPlayer.CameraMinZoomDistance = 7
					tbl.LocalPlayer.CameraMaxZoomDistance = tbl3.Misc_InfiniteZoom and math.huge or 128
					tbl.LocalPlayer.DevComputerCameraMode = Enum.DevComputerCameraMovementMode.UserChoice
					tbl.LocalPlayer.DevTouchCameraMode = Enum.DevTouchCameraMovementMode.UserChoice
				end
			end,
		}):AddKeyPicker("Killer_3rdPersonKey", {
			Default = "None",
			SyncToggleState = true,
			Mode = "Toggle",
			Text = "Toggle 3rd Person",
			NoUI = false,
		})

		v8:AddDropdown("Killer_CameraModeDrop", {
			Text = "3rd Person Mode",
			Values = { "Classic", "Follow" },
			Default = 1,
			Multi = false,
			Callback = function(killerCameraMode)
				tbl3.Killer_CameraMode = killerCameraMode

				if tbl3.Killer_3rdPerson then
					tbl.LocalPlayer.DevComputerCameraMode = Enum.DevComputerCameraMovementMode[killerCameraMode] or Enum.DevComputerCameraMovementMode.Classic
					tbl.LocalPlayer.DevTouchCameraMode = Enum.DevTouchCameraMovementMode[killerCameraMode] or Enum.DevTouchCameraMovementMode.Classic
				end
			end,
		})

		v8:AddDropdown("Killer_MaskDropdown", {
			Text = "Ganti Topeng Masked",
			Values = { "Tony", "Rabbit", "Alex", "Brandon", "Cobra", "Richard", "Richter" },
			Default = 1,
			Multi = false,
			Callback = function(arg)
				if fn5() ~= "Killer" then
					fn2("Akses Ditolak: Kamu bukan Killer!", 3)
					return
				end
				local selectedKiller = tbl.LocalPlayer:FindFirstChild("SelectedKiller")
				if (selectedKiller and selectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller")) ~= "Masked" then
					fn2("Akses Ditolak: Killer bukan Masked!", 3)
					return
				end

				pcall(function()
					local tbl20 = { arg }
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Killers"):WaitForChild("Masked"):WaitForChild("Activatepower"):FireServer(unpack(tbl20))
					fn2("Topeng diganti ke " .. arg, 2)

					task.spawn(function()
						task.wait(60)

						pcall(function()
							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Killers"):WaitForChild("Masked"):WaitForChild("Deactivatepower"):FireServer()
						end)
					end)
				end)
			end,
		})

		local v9 = tbl17.Tele:AddLeftGroupbox("Refresh Data Peta", "clock-fading")
		local Generators = tbl17.Tele:AddRightGroupbox("Generators", "cog")
		local Players = tbl17.Tele:AddLeftGroupbox("Players", "circle-user-round")
		local v10 = tbl17.Tele:AddRightGroupbox("Hooks & Gates", "webhook")

		v9:AddButton({
			Text = "Refresh",
			Func = function()
				fn17()
				local tbl20 = {}

				for i, generator2 in ipairs(tbl9.Generators) do
					local model = generator2.model
					local attribute = model:GetAttribute("RepairProgress") or model:FindFirstChild("RepairProgress") and model.RepairProgress.Value or 0
					local attribute2 = model:GetAttribute("PlayersRepairingCount")
					local value

					if attribute2 then
						value = attribute2
					else
						value = model:FindFirstChild("PlayersRepairingCount") and model.PlayersRepairingCount.Value
					end

					value = value or 0
					table.insert(tbl20, { index = i, progress = math.floor(attribute), players = value })
				end

				table.sort(tbl20, function(arg, arg2)
					return arg.progress > arg2.progress
				end)

				local tbl21 = {}

				for _, v11 in ipairs(tbl20) do
					table.insert(tbl21, string.format("Generator %d | %d%% | %dP", v11.index, v11.progress, v11.players))
				end

				if #tbl21 == 0 then
					table.insert(tbl21, "No Gen Found")
				end

				options.Tele_GenDropdown:SetValues(tbl21)
				local tbl22 = {}

				for _, player in pairs(tbl.Players:GetPlayers()) do
					if player ~= tbl.LocalPlayer then
						local str3 = "[Spct]"

						if player.Team then
							if player.Team.Name == "Survivors" then
								str3 = "[Surv]"
							elseif player.Team.Name == "Killer" then
								str3 = "[Killer]"
							end
						end

						table.insert(tbl22, str3 .. " " .. player.Name)
					end
				end

				if #tbl22 == 0 then
					table.insert(tbl22, "No Players Found")
				end

				options.Tele_PlayerDropdown:SetValues(tbl22)
				local tbl23 = {}

				for i in ipairs(tbl9.Hooks) do
					table.insert(tbl23, "Gantungan " .. i)
				end

				if #tbl23 == 0 then
					table.insert(tbl23, "No Hook Found")
				end

				options.Tele_HookDropdown:SetValues(tbl23)
				local tbl24 = {}

				for i in ipairs(tbl9.Gates) do
					table.insert(tbl24, "Gate " .. i)
				end

				if #tbl24 == 0 then
					table.insert(tbl24, "No Gate Found")
				end

				options.Tele_GateDropdown:SetValues(tbl24)
			end,
		})

		Generators:AddSlider("Tele_GenOffset", {
			Text = "Jarak Offset Teleport",
			Min = 1,
			Max = 15,
			Default = 5,
			Rounding = 0,
			Callback = function(tpOffset)
				tbl3.TP_Offset = tpOffset
			end,
		})

		Generators:AddDropdown("Tele_GenDropdown", {
			Text = "Pilih Generator",
			Values = { "Refresh First" },
			Default = 1,
			Multi = false,
			Callback = function(currentTeleportGen)
				tbl6.CurrentTeleportGen = currentTeleportGen
			end,
		})

		Generators:AddButton({
			Text = "Teleport",
			Func = function()
				if tbl6.CurrentTeleportGen and string.match(tbl6.CurrentTeleportGen, "Generator %d+") then
					local v11 = tbl9.Generators[tonumber(string.match(tbl6.CurrentTeleportGen, "Generator (%d+)"))]

					if v11 then
						fn34(v11)
					end
				end
			end,
		})

		Players:AddDropdown("Tele_PlayerDropdown", {
			Text = "Pilih Player",
			Values = { "Refresh First" },
			Default = 1,
			Multi = false,
			Callback = function(currentTeleportPlayer)
				tbl6.CurrentTeleportPlayer = currentTeleportPlayer
			end,
		})

		Players:AddButton({
			Text = "Teleport",
			Func = function()
				if tbl6.CurrentTeleportPlayer and tbl6.CurrentTeleportPlayer ~= "No Players Found" then
					local v11 = tbl.Players:FindFirstChild(string.match(tbl6.CurrentTeleportPlayer, "%[%w+%]%s+(.+)") or tbl6.CurrentTeleportPlayer)

					if v11 and v11.Character and tbl.LocalPlayer.Character then
						tbl.LocalPlayer.Character:PivotTo(v11.Character:GetPivot())
					end
				end
			end,
		})

		Players:AddToggle("AutoFollow", {
			Text = "Auto Follow",
			Default = false,
			Callback = function(autoFollow)
				tbl6.AutoFollow = autoFollow

				if tbl6.FollowConnection then
					tbl6.FollowConnection:Disconnect()
					tbl6.FollowConnection = nil
				end

				if autoFollow then
					if not tbl6.CurrentTeleportPlayer or tbl6.CurrentTeleportPlayer == "No Players Found" then
						return
					end
					local v11 = tbl.Players:FindFirstChild(string.match(tbl6.CurrentTeleportPlayer, "%[%w+%]%s+(.+)") or tbl6.CurrentTeleportPlayer)

					if v11 then
						tbl6.FollowConnection = tbl.RunService.Heartbeat:Connect(function()
							pcall(function()
								if not v11.Character or not v11.Character:FindFirstChild("HumanoidRootPart") then
									return
								end

								if not tbl.LocalPlayer.Character or not tbl.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
									return
								end
								tbl.LocalPlayer.Character:PivotTo(v11.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0))
							end)
						end)
					end
				end
			end,
		})

		v10:AddDropdown("Tele_HookDropdown", {
			Text = "Pilih Hook",
			Values = { "Refresh First" },
			Default = 1,
			Multi = false,
			Callback = function(currentTeleportHook)
				tbl6.CurrentTeleportHook = currentTeleportHook
			end,
		})

		v10:AddButton({
			Text = "Teleport",
			Func = function()
				if tbl6.CurrentTeleportHook and string.match(tbl6.CurrentTeleportHook, "Gantungan %d+") then
					local v11 = tbl9.Hooks[tonumber(string.match(tbl6.CurrentTeleportHook, "%d+"))]

					if v11 and tbl.LocalPlayer.Character then
						local hookPoint = v11:FindFirstChild("HookPoint")

						if hookPoint then
							tbl.LocalPlayer.Character:PivotTo(hookPoint:GetPivot())
						else
							tbl.LocalPlayer.Character:PivotTo(v11:GetPivot())
						end
					end
				end
			end,
		})

		v10:AddDropdown("Tele_GateDropdown", {
			Text = "Pilih Gate",
			Values = { "Refresh First" },
			Default = 1,
			Multi = false,
			Callback = function(currentTeleportGate)
				tbl6.CurrentTeleportGate = currentTeleportGate
			end,
		})

		v10:AddButton({
			Text = "Teleport",
			Func = function()
				if tbl6.CurrentTeleportGate and string.match(tbl6.CurrentTeleportGate, "Gate %d+") then
					local v11 = tbl9.Gates[tonumber(string.match(tbl6.CurrentTeleportGate, "%d+"))]

					if v11 and tbl.LocalPlayer.Character then
						tbl.LocalPlayer.Character:PivotTo(v11:GetPivot() * CFrame.new(0, 0, 8))
					end
				end
			end,
		})

		local v11 = tbl17.Esp:AddLeftTabbox()
		local v12 = v11:AddTab("", "scan-eye")
		local v13 = v11:AddTab("", "badge-info")

		v13:AddToggle("Next_Map", {
			Text = "Show Next Map",
			Default = true,
			Callback = function(nextMap)
				tbl3.Next_Map = nextMap
			end,
		})

		v13:AddToggle("Show_Stun", {
			Text = "Indikator stun killer",
			Default = false,
			Callback = function(showStun)
				tbl3.Show_Stun = showStun
			end,
		})

		v13:AddToggle("Misc_OverlayInfo", {
			Text = "Show (FPS & Spectator)",
			Default = true,
			Callback = function(enabled)
				if tbl6.WatermarkUI then
					tbl6.WatermarkUI.Enabled = enabled
				end

				if getgenv().Tixo_SpectatorUI then
					getgenv().Tixo_SpectatorUI.Enabled = enabled
				end
			end,
		})

		v13:AddToggle("Info Perk", {
			Text = "Info Perk",
			Default = false,
			Callback = function(arg)
				if arg then
					if not getgenv().InfoPerkLoaded then
						pcall(function()
							do
-- >>> Embedded: perk-info source
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local killersFolder = ReplicatedStorage:WaitForChild("Killers", 10)
local generalPerks = killersFolder and killersFolder:WaitForChild("!General"):WaitForChild("Perks")

if not killersFolder or not generalPerks then
    warn("Folder Killers atau !General tidak ditemukan di ReplicatedStorage.")
    return
end

local existing = CoreGui:FindFirstChild("InfoPerk") or (player.PlayerGui and player.PlayerGui:FindFirstChild("InfoPerk"))
if existing then existing:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "InfoPerk"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = (pcall(function() return CoreGui.Name end) and CoreGui) or player.PlayerGui
sg.Enabled = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 140)
frame.Position = UDim2.new(0.65, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 60, 70)
stroke.Thickness = 1
stroke.Parent = frame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
topBar.BorderSizePixel = 0
topBar.Parent = frame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 6)
topCorner.Parent = topBar

local fixCorner = Instance.new("Frame")
fixCorner.Size = UDim2.new(1, 0, 0, 5)
fixCorner.Position = UDim2.new(0, 0, 1, -5)
fixCorner.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
fixCorner.BorderSizePixel = 0
fixCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Info Perk"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Image Icons
local minBtn = Instance.new("ImageButton")
minBtn.Size = UDim2.new(0, 18, 0, 18)
minBtn.Position = UDim2.new(1, -26, 0, 5)
minBtn.BackgroundTransparency = 1
minBtn.Image = "rbxassetid://11255032783"
minBtn.ScaleType = Enum.ScaleType.Fit
minBtn.Parent = topBar

local refreshBtn = Instance.new("ImageButton")
refreshBtn.Size = UDim2.new(0, 18, 0, 18)
refreshBtn.Position = UDim2.new(1, -52, 0, 5)
refreshBtn.BackgroundTransparency = 1
refreshBtn.Image = "rbxassetid://122032243989747"
refreshBtn.ScaleType = Enum.ScaleType.Fit
refreshBtn.Parent = topBar

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -8, 1, -34)
scrollFrame.Position = UDim2.new(0, 4, 0, 30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
scrollFrame.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 3)
listLayout.Parent = scrollFrame

local function addText(text, color, isHeader)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, isHeader and 16 or 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = " " .. text
    lbl.TextColor3 = color or Color3.new(1, 1, 1)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = isHeader and Enum.Font.GothamBold or Enum.Font.Gotham
    lbl.TextSize = isHeader and 11 or 10
    lbl.Parent = scrollFrame
end

local function isVerifiedPerk(perkName)
    if generalPerks:FindFirstChild(perkName) then return true end
    for _, killerDir in ipairs(killersFolder:GetChildren()) do
        if killerDir:IsA("Folder") or killerDir:IsA("Model") then
            local pFolder = killerDir:FindFirstChild("Perks")
            if pFolder and pFolder:FindFirstChild(perkName) then
                return true
            end
        end
    end
    return false
end

local function scanArena()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end

    local entityFound = false

    for _, p in ipairs(Players:GetPlayers()) do
        local isKiller = false
        if p.Team then
            if p.Team.Name == "Killer" then
                isKiller = true
            end
        end

        local char = p.Character
        if char and char:FindFirstChild("Humanoid") then
            local detectedPerks = {}
            
            for _, obj in ipairs(char:GetChildren()) do
                local baseName, level = string.match(obj.Name, "^(.-)%s+(%d+)$")
                if baseName and level and isVerifiedPerk(baseName) then
                    table.insert(detectedPerks, string.format("• %s (Lvl %s)", baseName, level))
                end
            end
            
            if #detectedPerks > 0 then
                entityFound = true
                
                if p == player then
                    addText("👤 Kamu (" .. p.Name .. ")", Color3.fromRGB(100, 255, 100), true)
                elseif isKiller then
                    addText("KILLER: " .. p.Name, Color3.fromRGB(255, 50, 50), true)
                else
                    addText("🛡️ Survivor: " .. p.Name, Color3.fromRGB(80, 170, 255), true)
                end
                
                for _, perk in ipairs(detectedPerks) do
                    addText(perk, Color3.fromRGB(220, 220, 220), false)
                end
                addText("------------------------", Color3.fromRGB(80, 80, 90), false)
            end
        end
    end

    if not entityFound then
        addText("Memindai...", Color3.fromRGB(150, 150, 150), false)
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 5)
end

local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 220, 0, 28) or UDim2.new(0, 220, 0, 140)
    
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(frame, tweenInfo, {Size = targetSize}):Play()
end)

refreshBtn.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(refreshBtn, TweenInfo.new(0.3), {Rotation = refreshBtn.Rotation + 360})
    tw:Play()
    scanArena()
end)

task.spawn(function()
    while sg and sg.Parent do
        task.wait(5)
        if sg.Enabled then
            scanArena()
        end
    end
end)

scanArena()

getgenv().InfoPerkEnabled = true

getgenv().ToggleInfoPerk = function(state)
    if state == nil then
        state = not sg.Enabled
    end
    sg.Enabled = state
    getgenv().InfoPerkEnabled = state
    if state then
        scanArena()
    end
end

getgenv().InfoPerkCleanup = function()
    if sg and sg.Parent then
        sg:Destroy()
    end
    getgenv().InfoPerkEnabled = false
    getgenv().ToggleInfoPerk = nil
    getgenv().InfoPerkCleanup = nil
    getgenv().InfoPerkLoaded = false
end

getgenv().InfoPerkLoaded = true
-- <<< End embedded: perk-info source
end
						end)
					elseif getgenv().ToggleInfoPerk then
						getgenv().ToggleInfoPerk(true)
					end
				else
					if getgenv().InfoPerkCleanup then
						getgenv().InfoPerkCleanup()
					end

					getgenv().InfoPerkLoaded = false
				end
			end,
		})

		v12:AddToggle("ESP_Master", {
			Text = "Aktifkan ESP",
			Default = false,
			Callback = function(espMaster)
				tbl3.ESP_Master = espMaster

				if espMaster then
					fn17()
				else
					fn38()
				end
			end,
		})

		v12:AddSlider("ESP_MaxDistSlider", {
			Text = "ESP Distance",
			Min = 50,
			Max = 500,
			Default = 200,
			Rounding = 0,
			Callback = function(espMaxDistance)
				tbl3.ESP_MaxDistance = espMaxDistance
			end,
		})

		v12:AddSlider("ESP_Transr", {
			Text = "ESP Transparency",
			Min = 0,
			Max = 10,
			Default = 7,
			Rounding = 1,
			Callback = function(arg)
				tbl3.Trans = arg / 10

				if tbl3.ESP_Master then
					fn38()
					fn17()
				end
			end,
		})

		v12:AddCheckbox("ESP_Name", {
			Text = "Name player",
			Default = false,
			Callback = function(espName)
				tbl3.ESP_Name = espName

				if espName then
					fn17()
				else
					fn38()
				end
			end,
		})

		v12:AddCheckbox("ESP_NameG", {
			Text = "Name Generator",
			Default = false,
			Callback = function(espNameG)
				tbl3.ESP_NameG = espNameG

				if espNameG then
					fn17()
				else
					fn38()
				end
			end,
		})

		v12:AddCheckbox("ESP_ItemIcon", {
			Text = "Esp item",
			Default = false,
			Callback = function(espItemIcon)
				tbl3.ESP_ItemIcon = espItemIcon

				if tbl3.ESP_Master then
					if not espItemIcon then
						fn37("Item")
					end
				end
			end,
		})

		v12:AddCheckbox("ESP_Outline", {
			Text = "Mode outline",
			Default = false,
			Callback = function(espOutline)
				tbl3.ESP_Outline = espOutline
			end,
		})

		v12:AddCheckbox("ESP_KillerWarn", {
			Text = "Killer Warn",
			Default = false,
			Callback = function(espKillerWarn)
				tbl3.ESP_KillerWarn = espKillerWarn
			end,
		})

		local Target = tbl17.Esp:AddRightGroupbox("Target", "palette")

		Target:AddCheckbox("ESP_SCP", {
			Text = "SCP / Zombie",
			Default = false,
			Callback = function(espScp)
				tbl3.ESP_SCP = espScp

				if tbl3.ESP_Master then
					if not espScp then
						fn37("SCP")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_SCP", {
			Default = tbl7.Colors.SCP,
			Title = "SCP Color",
			Callback = function(scp)
				tbl7.Colors.SCP = scp
			end,
		})

		Target:AddCheckbox("ESP_Player", {
			Text = "Player",
			Default = false,
			Callback = function(espPlayer)
				tbl3.ESP_Player = espPlayer

				if tbl3.ESP_Master then
					if not espPlayer then
						fn37("Player")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Player", {
			Default = tbl7.Colors.Player,
			Title = "Player Color",
			Callback = function(player)
				tbl7.Colors.Player = player
			end,
		})

		Target:AddCheckbox("ESP_Killer", {
			Text = "Killer",
			Default = false,
			Callback = function(espKiller)
				tbl3.ESP_Killer = espKiller

				if tbl3.ESP_Master then
					if not espKiller then
						fn37("Killer")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Killer", {
			Default = tbl7.Colors.Killer,
			Title = "Killer Color",
			Callback = function(killer)
				tbl7.Colors.Killer = killer
			end,
		})

		Target:AddCheckbox("ESP_Generator", {
			Text = "Generator",
			Default = false,
			Callback = function(espGenerator)
				tbl3.ESP_Generator = espGenerator

				if tbl3.ESP_Master then
					if not espGenerator then
						fn37("Generator")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Generator", {
			Default = tbl7.Colors.Generator,
			Title = "Generator Color",
			Callback = function(generator2)
				tbl7.Colors.Generator = generator2
			end,
		})

		Target:AddCheckbox("ESP_Pallet", {
			Text = "Pallet",
			Default = false,
			Callback = function(espPallet)
				tbl3.ESP_Pallet = espPallet

				if tbl3.ESP_Master then
					if not espPallet then
						fn37("Pallet")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Pallet", {
			Default = tbl7.Colors.Pallet,
			Title = "Pallet Color",
			Callback = function(pallet)
				tbl7.Colors.Pallet = pallet
			end,
		})

		Target:AddCheckbox("ESP_Window", {
			Text = "Window / Vault",
			Default = false,
			Callback = function(espWindow)
				tbl3.ESP_Window = espWindow

				if tbl3.ESP_Master then
					if not espWindow then
						fn37("Window")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Window", {
			Default = tbl7.Colors.Window,
			Title = "Window Color",
			Callback = function(window)
				tbl7.Colors.Window = window
			end,
		})

		Target:AddCheckbox("ESP_Hook", {
			Text = "Hook",
			Default = false,
			Callback = function(espHook)
				tbl3.ESP_Hook = espHook

				if tbl3.ESP_Master then
					if not espHook then
						fn37("Hook")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Hook", {
			Default = tbl7.Colors.Hook,
			Title = "Hook Color",
			Callback = function(hook)
				tbl7.Colors.Hook = hook
			end,
		})

		Target:AddCheckbox("ESP_Gate", {
			Text = "Exit Gate",
			Default = false,
			Callback = function(espGate)
				tbl3.ESP_Gate = espGate

				if tbl3.ESP_Master then
					if not espGate then
						fn37("Gate")
					else
						fn17()
					end
				end
			end,
		}):AddColorPicker("Color_Gate", {
			Default = tbl7.Colors.Gate,
			Title = "Gate Color",
			Callback = function(gate)
				tbl7.Colors.Gate = gate
			end,
		})

		local v14 = tbl17.Aim:AddRightTabbox()
		local Aimbot = v14:AddTab("Aimbot")
		local Pistol = v14:AddTab("Pistol")
		local Veil = v14:AddTab("Veil")

		Pistol:AddToggle("Pistol_CustomSoundToggle", {
			Text = "Sound TOF",
			Default = false,
			Tooltip = "Mengubah suara tembakan Pistol",
			Callback = function(pistolCustomSound)
				tbl3.Pistol_CustomSound = pistolCustomSound

				if tbl.LocalPlayer.Character then
					fn26(tbl.LocalPlayer.Character)
				end
			end,
		})

		Pistol:AddDropdown("Pistol_SoundDropdown", {
			Text = "Pilih Sound",
			Values = { "Sound 1", "Sound 2", "Sound 3", "Sound 4" },
			Default = 1,
			Multi = false,
			Callback = function(pistolSelectedSound)
				tbl3.Pistol_SelectedSound = pistolSelectedSound

				if tbl3.Pistol_CustomSound and tbl.LocalPlayer.Character then
					fn26(tbl.LocalPlayer.Character)
				end
			end,
		})

		Pistol:AddDivider("Aim")

		Pistol:AddDropdown("AIM_TargetPart_Drop", {
			Text = "Target Aim",
			Values = { "Head", "Torso", "Root" },
			Default = 2,
			Multi = false,
			Callback = function(aimTargetPart)
				tbl3.AIM_TargetPart = aimTargetPart
			end,
		})

		Pistol:AddToggle("Aim_Silent", {
			Text = "Pistol",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(aimSilent)
				tbl3.Aim_Silent = aimSilent
			end,
		}):AddColorPicker("Pistol_LaserColor", {
			Default = Color3.fromRGB(57, 255, 20),
			Title = "Pistol Laser Color",
			Callback = function(color)
				if part then
					part.Color = color
				end
			end,
		}):AddKeyPicker("KeyPicker_SilentPistol", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Pistol" })

		Pistol:AddCheckbox("Pistol_BlockKnocked", {
			Text = "Block aim Knocked",
			Default = true,
			Callback = function(pistolBlockKnocked)
				tbl3.Pistol_BlockKnocked = pistolBlockKnocked
			end,
		})

		Pistol:AddCheckbox("Pistol_ShowLaser", {
			Text = "Show Laser",
			Default = true,
			Callback = function(pistolShowLaser)
				tbl3.Pistol_ShowLaser = pistolShowLaser

				if not pistolShowLaser and part and part.Parent ~= nil then
					part.Parent = nil
				end
			end,
		})

		Pistol:AddCheckbox("Aim_Lock", {
			Text = "Aim Lock",
			Default = false,
			Callback = function(aimLock)
				tbl3.Aim_Lock = aimLock
			end,
		})

		Pistol:AddToggle("Aim_Pre", {
			Text = "Auto prediksi",
			Default = false,
			Content = "Predict",
			Switch = true,
			Callback = function(predict)
				tbl3.Predict = predict
			end,
		}):AddKeyPicker("KeyPicker_AimPre", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Auto prediksi" })

		Pistol:AddSlider("Pistol_PredictLead", {
			Text = "Prediction",
			Tooltip = "Jarak prediksi",
			Min = 5,
			Max = 50,
			Default = 35,
			Rounding = 0,
			Callback = function(arg)
				tbl3.Pistol_PredictLead = arg / 10
			end,
		})

		Pistol:AddSlider("Pistol_AimOffsetSlider", {
			Text = "Aim Offset",
			Min = -2,
			Max = 0,
			Default = tbl3.Pistol_AimOffset,
			Rounding = 1,
			Callback = function(pistolAimOffset)
				tbl3.Pistol_AimOffset = pistolAimOffset
			end,
		})

		Pistol:AddDropdown("Pistol_Target_Drop", {
			Text = "Pistol Target",
			Values = { "Killer", "Survivor", "SCP" },
			Default = 1,
			Multi = false,
			Callback = function(pistolTarget)
				tbl3.Pistol_Target = pistolTarget
			end,
		})

		Pistol:AddDivider("target menu")

		Pistol:AddToggle("Pistol_TargetShortcutUI", {
			Text = "Show Mobile Target Shortcut",
			Default = false,
			Callback = function(enabled)
				if screenGui2 then
					screenGui2.Enabled = enabled
				end
			end,
		}):AddKeyPicker("Pistol_CycleTargetTypeKey", {
			Default = "T",
			SyncToggleState = false,
			Mode = "Toggle",
			Text = "Cycle Target Type",
			NoUI = false,
			Callback = function()
				fn62()
			end,
		})

		Pistol:AddCheckbox("Pistol_FOVMode", {
			Text = "Pistol FOV Mode",
			Default = false,
			Callback = function(pistolFOVMode)
				tbl3.Pistol_FOVMode = pistolFOVMode
			end,
		})

		Pistol:AddCheckbox("Pistol_ShowFOV", {
			Text = "Pistol Show FOV",
			Default = false,
			Callback = function(pistolShowFOV)
				tbl3.Pistol_ShowFOV = pistolShowFOV
			end,
		})

		Pistol:AddSlider("Pistol_FOVSlider", {
			Text = "Pistol FOV Radius",
			Min = 50,
			Max = 300,
			Default = 120,
			Rounding = 0,
			Callback = function(pistolFov)
				tbl3.Pistol_FOV = pistolFov
			end,
		})

		Veil:AddToggle("Aim_SilentVeil", {
			Text = "Veil",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(aimSilentVeil)
				if aimSilentVeil then
					if fn5() ~= "Killer" then
						fn2("Akses Ditolak: Kamu bukan Killer!", 3)

						task.defer(function()
							toggles.Aim_SilentVeil:SetValue(false)
						end)

						return
					end

					local selectedKiller = tbl.LocalPlayer:FindFirstChild("SelectedKiller")

					if (selectedKiller and selectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller")) ~= "Veil" then
						fn2("Akses Ditolak: Killer bukan Veil!", 3)

						task.defer(function()
							toggles.Aim_SilentVeil:SetValue(false)
						end)

						return
					end
				end

				tbl3.Aim_SilentVeil = aimSilentVeil
			end,
		}):AddKeyPicker("KeyPicker_SilentVeil", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Veil" })

		Veil:AddCheckbox("SmartPredict_Toggle", {
			Text = "Smart Predict Mode",
			Default = false,
			Callback = function(smartPredict)
				tbl3.SmartPredict = smartPredict
			end,
		})

		Veil:AddSlider("Veil_LeadMultiplierSlider", {
			Text = "Smart Predict Lead",
			Tooltip = "Mengatur jarak ekstra prediksi",
			Min = 10,
			Max = 50,
			Default = 17,
			Rounding = 0,
			Callback = function(arg)
				tbl3.Veil_LeadMultiplier = arg / 10
			end,
		})

		Veil:AddCheckbox("Veil_ShowFOV", {
			Text = "Show FOV",
			Default = true,
			Callback = function(veilShowFOV)
				tbl3.Veil_ShowFOV = veilShowFOV
			end,
		})

		Veil:AddCheckbox("Veil_ShowLaser", {
			Text = "Snapline",
			Default = true,
			Callback = function(veilShowLaser)
				tbl3.Veil_ShowLaser = veilShowLaser
			end,
		})

		Veil:AddSlider("Veil_FOVSlider", {
			Text = "FOV Radius",
			Min = 50,
			Max = 300,
			Default = 120,
			Rounding = 0,
			Callback = function(veilFov)
				tbl3.Veil_FOV = veilFov
			end,
		})

		Veil:AddSlider("Vei_Distance", {
			Text = "Distance",
			Min = 50,
			Max = 500,
			Default = 150,
			Rounding = 0,
			Callback = function(spearMaxDist)
				tbl3.SPEAR_MaxDist = spearMaxDist
			end,
		})

		Veil:AddSlider("Veil_SpearSpeed", {
			Text = "Spear Speed",
			Min = 50,
			Max = 200,
			Default = 165,
			Rounding = 0,
			Callback = function(spearSpeed)
				tbl3.SPEAR_Speed = spearSpeed
			end,
		})

		Veil:AddSlider("Veil_SpearGravity", {
			Text = "Spear Gravity",
			Min = 0,
			Max = 200,
			Default = 103,
			Rounding = 0,
			Callback = function(spearGravity)
				tbl3.SPEAR_Gravity = spearGravity
			end,
		})

		Aimbot:AddToggle("Aimbot_Enabled", {
			Text = "Aimbot",
			Default = false,
			Callback = function(aimbotEnabled)
				tbl3.Aimbot_Enabled = aimbotEnabled
			end,
		})

		Aimbot:AddCheckbox("Aimbot_ShowFOV", {
			Text = "Show FOV Circle",
			Default = true,
			Callback = function(aimbotShowFOV)
				tbl3.Aimbot_ShowFOV = aimbotShowFOV
			end,
		})

		Aimbot:AddSlider("Aimbot_Radius", {
			Text = "FOV Circle Radius",
			Min = 50,
			Max = 500,
			Default = 150,
			Rounding = 0,
			Callback = function(aimbotRadius)
				tbl3.Aimbot_Radius = aimbotRadius
			end,
		})

		Aimbot:AddSlider("Aimbot_MaxDist", {
			Text = "Max Distance",
			Min = 50,
			Max = 1000,
			Default = 300,
			Rounding = 0,
			Callback = function(aimbotMaxDist)
				tbl3.Aimbot_MaxDist = aimbotMaxDist
			end,
		})

		Aimbot:AddSlider("Aimbot_Smoothness", {
			Text = "Aimbot Smoothness",
			Min = 1,
			Max = 10,
			Default = 5,
			Rounding = 1,
			Callback = function(arg)
				tbl3.Aimbot_Smoothness = arg / 10
			end,
		})

		Aimbot:AddInput("Aimbot_Predict", {
			Text = "Predict Aim Offset",
			Default = "",
			Numeric = true,
			Placeholder = "misal: 0.05",
			Callback = function(arg)
				local aimbotPredict = tonumber(arg)

				if aimbotPredict then
					tbl3.Aimbot_Predict = aimbotPredict
				end
			end,
		})

		Aimbot:AddDivider("aim flash")

		Aimbot:AddToggle("FlashAim", {
			Text = "Aim (flash)",
			Default = false,
			Callback = function(flashSilent)
				tbl3.Flash_Silent = flashSilent
			end,
		}):AddKeyPicker("SilentFlashKey", {
			Default = "None",
			Text = "Silent Aim Key",
			Mode = "Toggle",
			Callback = function(flashSilent)
				tbl3.Flash_Silent = flashSilent
			end,
		})

		Aimbot:AddSlider("FlashAimOffset", {
			Text = "Aim Offset (Y)",
			Tooltip = "Atur posisi bidikan (0 = Badan, 1.5 = Kepala, 8 = Atas Kepala)",
			Default = 15,
			Min = 1,
			Max = 15,
			Rounding = 1,
			Callback = function(flashYOffset)
				tbl3.Flash_YOffset = flashYOffset
			end,
		})

		local v15 = tbl17.Aim:AddLeftGroupbox("Custom Crosshair", "crosshair")

		v15:AddToggle("Crosshair_Enabled", {
			Text = "Crosshair",
			Default = false,
			Callback = function(crosshairEnabled)
				tbl3.Crosshair_Enabled = crosshairEnabled
				fn63()
			end,
		}):AddColorPicker("Crosshair_Color", {
			Default = Color3.fromRGB(57, 255, 20),
			Title = "Crosshair Color",
			Callback = function(crosshairColor)
				tbl3.Crosshair_Color = crosshairColor
				fn63()
			end,
		})

		v15:AddDropdown("Crosshair_Type", {
			Text = "Crosshair Style",
			Values = { "Dot", "Cross", "Circle" },
			Default = 2,
			Multi = false,
			Callback = function(crosshairType)
				tbl3.Crosshair_Type = crosshairType
				fn63()
			end,
		})

		v15:AddSlider("Crosshair_Size", {
			Text = "Crosshair Size",
			Min = 2,
			Max = 30,
			Default = 4,
			Rounding = 0,
			Callback = function(crosshairSize)
				tbl3.Crosshair_Size = crosshairSize
				fn63()
			end,
		})

		local v16 = tbl17.Aim:AddLeftGroupbox("Crosshair Position", "move")

		v16:AddInput("CrossX", {
			Text = "Posisi X",
			Default = "",
			Placeholder = "misal: 50",
			Callback = function(arg)
				local crosshairOffsetX = tonumber(arg)

				if crosshairOffsetX then
					tbl3.Crosshair_OffsetX = crosshairOffsetX
					fn63()
				end
			end,
		})

		v16:AddInput("CrossY", {
			Text = "Posisi Y",
			Default = "",
			Placeholder = "misal: 50",
			Callback = function(arg)
				local crosshairOffsetY = tonumber(arg)

				if crosshairOffsetY then
					tbl3.Crosshair_OffsetY = crosshairOffsetY
					fn63()
				end
			end,
		})

		v16:AddButton({
			Text = "Reset Posisi",
			Func = function()
				tbl3.Crosshair_OffsetX = 0
				tbl3.Crosshair_OffsetY = 0

				pcall(function()
					options.CrossX:SetValue("0")
				end)

				pcall(function()
					options.CrossY:SetValue("0")
				end)

				fn63()
			end,
		})

		local Screen = tbl17.Misc:AddLeftGroupbox("Screen", "camera")
		getgenv().Resolution = { reso = 0.65 }
		Screen:AddDivider("Camera")

		Screen:AddToggle("Misc_SmoothCamToggle", {
			Text = "Camera DBD",
			Default = false,
			Tooltip = "Smoothies camera",
			Callback = function(miscSmoothCam)
				tbl3.Misc_SmoothCam = miscSmoothCam
				fn23()
			end,
		})

		Screen:AddSlider("Misc_CamHeightSlider", {
			Text = "Camera Height",
			Min = -10,
			Max = 10,
			Default = -1,
			Rounding = 1,
			Callback = function(miscCamHeight)
				tbl3.Misc_CamHeight = miscCamHeight

				if tbl3.Misc_SmoothCam then
					fn23()
				end
			end,
		})

		Screen:AddSlider("Misc_CamStiffnessSlider", {
			Text = "Camera Stiffness",
			Min = 1,
			Max = 30,
			Default = 9.5,
			Rounding = 1,
			Callback = function(miscCamStiffness)
				tbl3.Misc_CamStiffness = miscCamStiffness

				if tbl3.Misc_SmoothCam then
					fn23()
				end
			end,
		})

		Screen:AddDivider("Screen")

		Screen:AddToggle("Res_Toggle", {
			Text = "Custom Resolution",
			Default = false,
			Callback = function(arg)
				if arg then
					if not getgenv().resolusi then
						getgenv().resolusi = game:GetService("RunService").RenderStepped:Connect(function()
							tbl.Camera.CFrame = tbl.Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution.reso, 0, 0, 0, 1)
						end)
					end
				elseif getgenv().resolusi then
					getgenv().resolusi:Disconnect()
					getgenv().resolusi = nil
				end
			end,
		})

		Screen:AddSlider("Res_Slider", {
			Text = "Resolution Scale",
			Default = 0.65,
			Min = 0.1,
			Max = 2,
			Rounding = 2,
			Callback = function(reso)
				getgenv().Resolution.reso = reso
			end,
		})

		local v17 = tbl17.Misc:AddRightGroupbox("Spoofer Profile", "circle-user-round")

		v17:AddToggle("Misc_FakeName", {
			Text = "Fake Name",
			Default = false,
			Callback = function(miscFakeName)
				tbl3.Misc_FakeName = miscFakeName

				if miscFakeName then
					fn28()
				else
					fn29()
				end
			end,
		})

		v17:AddDivider("profile menu")

		v17:AddToggle("Misc_FakeAttributesToggle", {
			Text = "Fake Profile",
			Default = false,
			Callback = function(miscFakeAttributes)
				tbl3.Misc_FakeAttributes = miscFakeAttributes

				if miscFakeAttributes then
					if options.Misc_LevelInput then
						tbl.LocalPlayer:SetAttribute("Level", tonumber(options.Misc_LevelInput.Value) or tbl4.Level)
					end

					if options.Misc_GearsInput then
						tbl.LocalPlayer:SetAttribute("Gears", tonumber(options.Misc_GearsInput.Value) or tbl4.Gears)
					end

					if options.Misc_ScrewsInput then
						tbl.LocalPlayer:SetAttribute("Screws", tonumber(options.Misc_ScrewsInput.Value) or tbl4.Screws)
					end
				else
					tbl.LocalPlayer:SetAttribute("Level", tbl4.Level)
					tbl.LocalPlayer:SetAttribute("Gears", tbl4.Gears)
					tbl.LocalPlayer:SetAttribute("Screws", tbl4.Screws)
				end
			end,
		})

		v17:AddInput("Misc_LevelInput", {
			Default = tostring(tbl4.Level),
			Numeric = true,
			Finished = true,
			Text = "Set Level",
			Tooltip = "Ubah jumlah Level",
			Placeholder = "Masukkan angka Level...",
			Callback = function(arg)
				local num = tonumber(arg)

				if num and tbl3.Misc_FakeAttributes then
					tbl.LocalPlayer:SetAttribute("Level", num)
				end
			end,
		})

		v17:AddInput("Misc_GearsInput", {
			Default = tostring(tbl4.Gears),
			Numeric = true,
			Finished = true,
			Text = "Set Gears",
			Tooltip = "Ubah jumlah Gears",
			Placeholder = "Masukkan angka Gears...",
			Callback = function(arg)
				local num = tonumber(arg)

				if num and tbl3.Misc_FakeAttributes then
					tbl.LocalPlayer:SetAttribute("Gears", num)
				end
			end,
		})

		v17:AddInput("Misc_ScrewsInput", {
			Default = tostring(tbl4.Screws),
			Numeric = true,
			Finished = true,
			Text = "Set Screws",
			Tooltip = "Ubah jumlah Screws",
			Placeholder = "Masukkan angka Screws...",
			Callback = function(arg)
				local num = tonumber(arg)

				if num and tbl3.Misc_FakeAttributes then
					tbl.LocalPlayer:SetAttribute("Screws", num)
				end
			end,
		})

		local v18 = tbl17.Misc:AddRightGroupbox("GUI Mob", "layout-grid")

		v18:AddToggle("Misc_InfiniteZoom", {
			Text = "Infinite Zoom",
			Default = false,
			Tooltip = "Bebas zoom-out kamera sejauh mungkin",
			Callback = function(miscInfiniteZoom)
				tbl3.Misc_InfiniteZoom = miscInfiniteZoom

				if tbl6.InfiniteZoomConn then
					tbl6.InfiniteZoomConn:Disconnect()
					tbl6.InfiniteZoomConn = nil
				end

				if miscInfiniteZoom then
					tbl.LocalPlayer.CameraMaxZoomDistance = math.huge

					tbl6.InfiniteZoomConn = tbl.LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
						if tbl.LocalPlayer.CameraMaxZoomDistance ~= math.huge then
							tbl.LocalPlayer.CameraMaxZoomDistance = math.huge
						end
					end)
				else
					tbl.LocalPlayer.CameraMaxZoomDistance = tbl19.MaxZoom or 128
				end
			end,
		})

		v18:AddToggle("Misc_Invisible", {
			Text = "Invisible GUI",
			Default = false,
			Content = "Invisible",
			Tooltip = "Invisible FE, keybind Q",
			Switch = true,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(miscInvisible)
				tbl3.Misc_Invisible = miscInvisible

				if miscInvisible then
					pcall(function()
						do
-- >>> Embedded: invis source
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

local FillColor = Color3.fromRGB(255, 0, 0) 
local OutlineColor = Color3.fromRGB(255, 255, 255) 
local TargetFillTrans = 0.7
local TargetOutTrans = 0.5

local TInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

-- Setup Sound Effect ketika diaktifkan
local ActivateSound = Instance.new("Sound")
ActivateSound.Name = "InvisActivateSound"
ActivateSound.SoundId = "rbxassetid://120228379729797"
ActivateSound.Volume = 1
ActivateSound.Parent = SoundService

-- Pengecekan agar Event/Hook tidak ter-duplicate ketika toggle dimatikan & dinyalakan lagi
if not getgenv().InvisSetupDone then
    getgenv().InvisSetupDone = true
    getgenv().InvisState = false

    local InvisHookSetup = false
    local function SetupInvisHook()
        if InvisHookSetup then return end
        InvisHookSetup = true
        
        task.spawn(function()
            pcall(function()
                if type(hookmetamethod) == "function" and type(getnamecallmethod) == "function" and type(checkcaller) == "function" then
                    local oldNamecall
                    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                        local method = getnamecallmethod()
                        local args = {...}

                        if not checkcaller() and method == "FireServer" and typeof(self) == "Instance" then
                            local selfName = string.lower(self.Name)
                            if getgenv().InvisState and selfName == "updatecharacterlook" then
                                local newArgs = {}
                                for i, v in ipairs(args) do
                                    if typeof(v) == "CFrame" then
                                        newArgs[i] = v * CFrame.new(0, 5000, 0)
                                    else
                                        newArgs[i] = v
                                    end
                                end
                                return oldNamecall(self, unpack(newArgs))
                            end
                        end
                        return oldNamecall(self, ...)
                    end)
                end
            end)
        end)
    end

    getgenv().ToggleInvisible = function(state)
        -- Jangan eksekusi jika statenya sama (Mencegah spam)
        if getgenv().InvisState == state then return end
        
        getgenv().InvisState = state
        local char = LocalPlayer.Character
        if not char then return end
        
        if state then
            SetupInvisHook()
            
            -- Memutar Suara Aktivasi
            if ActivateSound then
                ActivateSound:Play()
            end

            -- Setup Highlight
            local highlight = char:FindFirstChild("InvisibilityFX")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "InvisibilityFX"
                highlight.Adornee = char
                highlight.FillColor = FillColor
                highlight.OutlineColor = OutlineColor
                highlight.FillTransparency = 1 
                highlight.OutlineTransparency = 1
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = char
            end
            
            -- Setup ESP Icon GUI
            local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
            local invisUI = char:FindFirstChild("InvisStatusGUI")
            
            if not invisUI and head then
                invisUI = Instance.new("BillboardGui")
                invisUI.Name = "InvisStatusGUI"
                invisUI.Adornee = head
                invisUI.Size = UDim2.new(0, 100, 0, 50)
                invisUI.StudsOffset = Vector3.new(0, 1.6, 0)
                invisUI.AlwaysOnTop = true
                invisUI.Parent = char

                local container = Instance.new("Frame")
                container.Name = "Container"
                container.Size = UDim2.new(1, 0, 1, 0)
                container.BackgroundTransparency = 1
                container.Parent = invisUI

                local box = Instance.new("Frame")
                box.Name = "Box"
                box.Size = UDim2.new(0, 18, 0, 18)
                box.Position = UDim2.new(0.5, 14, 0.5, -9)
                box.AnchorPoint = Vector2.new(0, 0.5)
                box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                box.BackgroundTransparency = 0.2 
                box.BorderSizePixel = 0
                box.ZIndex = 2
                box.Parent = container
                
                Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
                
                local icon = Instance.new("ImageLabel")
                icon.Name = "Icon"
                icon.Size = UDim2.new(1, 0, 1, 0)
                icon.BackgroundTransparency = 1
                icon.Image = "rbxassetid://78134819718605"
                icon.ImageTransparency = 1
                icon.ZIndex = 3
                icon.Parent = box

                local line = Instance.new("Frame")
                line.Name = "Line"
                line.Size = UDim2.new(0, 2, 0, 16) 
                line.Position = UDim2.new(0.5, 6, 0.5, 0) 
                line.AnchorPoint = Vector2.new(0.5, 0.5) 
                line.Rotation = 45 
                line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                line.BorderSizePixel = 0
                line.ZIndex = 1
                line.Parent = container

                local lineGradient = Instance.new("UIGradient")
                lineGradient.Rotation = 90
                lineGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1) 
                })
                lineGradient.Parent = line
            end
            
            -- Transisi Animasi Masuk
            TweenService:Create(highlight, TInfo, {FillTransparency = TargetFillTrans, OutlineTransparency = TargetOutTrans}):Play()
            local iconImg = invisUI and invisUI:FindFirstChild("Icon", true)
            if iconImg then TweenService:Create(iconImg, TInfo, {ImageTransparency = 0}):Play() end
            
        else
            -- Transisi Animasi Keluar
            local highlight = char:FindFirstChild("InvisibilityFX")
            local invisUI = char:FindFirstChild("InvisStatusGUI")
            local iconImg = invisUI and invisUI:FindFirstChild("Icon", true)
            
            if highlight then TweenService:Create(highlight, TInfo, {FillTransparency = 1, OutlineTransparency = 1}):Play() end
            if iconImg then TweenService:Create(iconImg, TInfo, {ImageTransparency = 1}):Play() end
            
            task.spawn(function()
                task.wait(0.4)
                if not getgenv().InvisState then
                    if highlight then highlight:Destroy() end
                    if invisUI then invisUI:Destroy() end
                end
            end)
        end
    end

    -- Fungsi yang dipanggil oleh toggle library kamu saat "OFF"
    getgenv().RemoveInvisibleGui = function()
        getgenv().ToggleInvisible(false)
    end

    -- Auto-apply invis kalau pemain reset character / mati
    LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(1)
        if getgenv().InvisState then
            local tempState = getgenv().InvisState
            getgenv().InvisState = false -- Paksa refresh
            getgenv().ToggleInvisible(tempState)
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input, isTyping)
        if not isTyping and input.KeyCode == Enum.KeyCode.T then
            local newState = not getgenv().InvisState
            getgenv().ToggleInvisible(newState)
        end
    end)
end

-- Mengeksekusi script ini (dari loadstring UI library-mu) berarti menyalakan Invis.
getgenv().ToggleInvisible(true)
-- <<< End embedded: invis source
end
					end)
				elseif getgenv().RemoveInvisibleGui then
					pcall(getgenv().RemoveInvisibleGui)
				end
			end,
		})

		v18:AddToggle("Misc_SkyC", {
			Text = "Sky Changer",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(miscCopyAvatar)
				tbl3.Misc_CopyAvatar = miscCopyAvatar

				if miscCopyAvatar then
					pcall(function()
						do
-- >>> Embedded: SkyC source
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GlobalConnections = {}

local C_BG = Color3.fromRGB(35, 35, 40)
local C_BG_LIGHT = Color3.fromRGB(45, 45, 55)
local C_BG_ITEM = Color3.fromRGB(50, 50, 60)
local C_NEON_CYAN = Color3.fromRGB(60, 180, 255)
local C_TEXT = Color3.fromRGB(240, 240, 240)
local C_STROKE = Color3.fromRGB(80, 80, 95)

local guiName = "SkyChangerUI"
if getgenv().RemoveSkyChanger then 
    pcall(getgenv().RemoveSkyChanger) 
end

-- Menggunakan CoreGui jika tersedia (lebih aman dari respawn/reset), jika tidak fallback ke PlayerGui
local targetGuiParent = pcall(function() return CoreGui.Name end) and CoreGui or playerGui

local studioGui = Instance.new("ScreenGui")
studioGui.Name = guiName
studioGui.ResetOnSpawn = false -- Memastikan GUI tidak hilang saat karakter mati/respawn
studioGui.Parent = targetGuiParent

local preMinSize = UDim2.new(0, 260, 0, 280) 
local minSize = UDim2.new(0, 150, 0, 32) 

local mainFrame = Instance.new("Frame", studioGui)
mainFrame.Size = preMinSize
mainFrame.AnchorPoint = Vector2.new(0.5, 0) 
mainFrame.Position = UDim2.new(0.5, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.new(1, 1, 1) 
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

local mainGradient = Instance.new("UIGradient", mainFrame)
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C_BG),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30))
}
mainGradient.Rotation = 90

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 8)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = C_STROKE
mainStroke.Thickness = 1.2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 32)
header.BackgroundTransparency = 1 
header.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Sky Changer"
title.TextColor3 = C_TEXT
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Center

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(1, -32, 0, 0)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "▬"
minimizeBtn.TextColor3 = C_TEXT
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14

local searchFrame = Instance.new("Frame", mainFrame)
local gridArea = Instance.new("ScrollingFrame", mainFrame)
local loadingLabel = Instance.new("TextLabel", mainFrame)
local ResizeHandle = Instance.new("TextButton", mainFrame)

local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = minSize
        mainCorner.CornerRadius = UDim.new(1, 0) 
        searchFrame.Visible = false
        gridArea.Visible = false
        ResizeHandle.Visible = false
    else
        mainFrame.Size = preMinSize
        mainCorner.CornerRadius = UDim.new(0, 8)
        searchFrame.Visible = true
        gridArea.Visible = true
        ResizeHandle.Visible = true
    end
end)

local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end))

table.insert(GlobalConnections, RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end))

table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end))

ResizeHandle.Size = UDim2.new(0, 16, 0, 16)
ResizeHandle.Position = UDim2.new(1, -16, 1, -16)
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Text = "↘"
ResizeHandle.TextColor3 = Color3.fromRGB(120, 120, 120)
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.TextSize = 12
ResizeHandle.ZIndex = 20

local resizing = false
local resizeStartPos, startSize
ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStartPos = input.Position
        startSize = mainFrame.AbsoluteSize
    end
end)

table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if not isMinimized then
            local delta = input.Position - resizeStartPos
            local newWidth = math.clamp(startSize.X + (delta.X * 2), 220, 450)
            local newHeight = math.clamp(startSize.Y + delta.Y, 250, 550)
            
            mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            preMinSize = mainFrame.Size 
        end
    end
end))

table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end))

searchFrame.Size = UDim2.new(1, -20, 0, 30)
searchFrame.Position = UDim2.new(0, 10, 0, 40)
searchFrame.BackgroundColor3 = C_BG_LIGHT
Instance.new("UICorner", searchFrame).CornerRadius = UDim.new(0, 6)

local searchStroke = Instance.new("UIStroke", searchFrame)
searchStroke.Color = Color3.fromRGB(70, 70, 80)
searchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local searchBox = Instance.new("TextBox", searchFrame)
searchBox.Size = UDim2.new(1, -40, 1, 0)
searchBox.Position = UDim2.new(0, 10, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.TextColor3 = C_TEXT
searchBox.PlaceholderText = "Search sky..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
searchBox.Text = "sky"
searchBox.TextSize = 11
searchBox.Font = Enum.Font.GothamMedium
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false

local searchBtn = Instance.new("TextButton", searchFrame)
searchBtn.Size = UDim2.new(0, 30, 1, 0)
searchBtn.Position = UDim2.new(1, -30, 0, 0)
searchBtn.BackgroundTransparency = 1
searchBtn.Text = "🔍"
searchBtn.TextColor3 = C_NEON_CYAN

loadingLabel.Size = UDim2.new(1, 0, 0, 20)
loadingLabel.Position = UDim2.new(0, 0, 0, 75)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Searching..."
loadingLabel.TextColor3 = C_NEON_CYAN
loadingLabel.Font = Enum.Font.Gotham
loadingLabel.TextSize = 10
loadingLabel.Visible = false

task.spawn(function()
    while true do
        if loadingLabel.Visible then
            loadingLabel.TextTransparency = 0.3; task.wait(0.4)
            loadingLabel.TextTransparency = 0.8; task.wait(0.4)
        else
            task.wait(0.2)
        end
    end
end)

gridArea.Size = UDim2.new(1, -16, 1, -85)
gridArea.Position = UDim2.new(0, 8, 0, 80)
gridArea.BackgroundTransparency = 1
gridArea.ScrollBarThickness = 2
gridArea.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 130)
gridArea.CanvasSize = UDim2.new(0, 0, 0, 0)

local gridLayout = Instance.new("UIGridLayout", gridArea)
gridLayout.CellSize = UDim2.new(0, 56, 0, 70)
gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)

local function getAssetInfo(assetId)
    local success, response = pcall(function()
        if type(request) == "function" then
            return request({Url = "https://economy.roblox.com/v2/assets/" .. assetId .. "/details", Method = "GET"}).Body
        else
            return game:HttpGet("https://economy.roblox.com/v2/assets/" .. assetId .. "/details")
        end
    end)
    if success and response then
        local data = HttpService:JSONDecode(response)
        if data and data.Name then
            return {id = assetId, name = data.Name, icon = assetId}
        end
    end
    return nil
end

local function shuffleTable(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function fetchModels(keyword)
    local url = "https://apis.roblox.com/toolbox-service/v1/marketplace/10?limit=30&keyword=" .. HttpService:UrlEncode(keyword)
    local success, response = pcall(function()
        if type(request) == "function" then
            return request({Url = url, Method = "GET"}).Body
        else
            return game:HttpGet(url)
        end
    end)
    
    if success and response then
        local decoded = HttpService:JSONDecode(response)
        if decoded and decoded.data then
            local allItems = {}
            for _, item in ipairs(decoded.data) do
                if item.id then table.insert(allItems, item) end
            end
            
            shuffleTable(allItems)
            
            local res = {}
            local validCount = 0
            for i = 1, #allItems do
                if validCount >= 10 then break end
                local info = getAssetInfo(allItems[i].id)
                if info then 
                    table.insert(res, info)
                    validCount = validCount + 1
                end
            end
            return res
        end
    end
    return nil
end

local function displayGrid(items)
    for _, v in ipairs(gridArea:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    if not items then return end
    
    for _, item in ipairs(items) do
        local btn = Instance.new("TextButton", gridArea)
        btn.BackgroundColor3 = C_BG_ITEM; btn.Text = ""
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        
        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = Color3.fromRGB(80, 80, 90)
        btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        
        local thumb = Instance.new("ImageLabel", btn)
        thumb.Size = UDim2.new(1, -6, 0, 45); thumb.Position = UDim2.new(0, 3, 0, 3)
        thumb.Image = "rbxthumb://type=Asset&id=" .. item.id .. "&w=150&h=150"
        thumb.BackgroundTransparency = 1
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(0, 4)

        local txt = Instance.new("TextLabel", btn)
        txt.Size = UDim2.new(1, -4, 0, 18); txt.Position = UDim2.new(0, 2, 1, -20)
        txt.Text = item.name; txt.TextColor3 = C_TEXT; txt.TextSize = 8
        txt.Font = Enum.Font.GothamMedium
        txt.BackgroundTransparency = 1; txt.TextWrapped = true

        btn.MouseButton1Click:Connect(function()
            pcall(function()
                local btnTextCache = txt.Text
                txt.Text = "..."
                txt.TextColor3 = C_NEON_CYAN
                
                task.spawn(function()
                    local success, result = pcall(function()
                        return game:GetObjects("rbxassetid://" .. item.id)
                    end)
                    
                    if success and result and #result > 0 then
                        local downloadedAsset = result[1]
                        
                        -- FUNGSI BARU: Menghapus Sky dari Lighting & workspace.Map
                        local function clearOldSkies()
                            -- 1. Hapus Sky bawaan yang ada di Lighting
                            for _, child in pairs(Lighting:GetChildren()) do
                                if child:IsA("Sky") then child:Destroy() end
                            end
                            
                            -- 2. Hapus semua Sky yang ada di dalam Map (seperti di gambar 14124.jpg)
                            local mapFolder = workspace:FindFirstChild("Map")
                            if mapFolder then
                                for _, desc in pairs(mapFolder:GetDescendants()) do
                                    if desc:IsA("Sky") then
                                        desc:Destroy()
                                    end
                                end
                            end
                        end
                        
                        if downloadedAsset:IsA("Sky") then
                            clearOldSkies()
                            downloadedAsset.Parent = Lighting
                        else
                            local skyObject = downloadedAsset:FindFirstChildOfClass("Sky", true)
                            if skyObject then
                                clearOldSkies()
                                skyObject.Parent = Lighting
                            end
                        end
                    end
                    
                    txt.Text = btnTextCache
                    txt.TextColor3 = C_TEXT
                end)
            end)
        end)
    end
    gridArea.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 10)
end

local function doSearch()
    local query = searchBox.Text
    if query == "" then return end
    
    loadingLabel.Visible = true
    gridArea.Visible = false
    
    task.spawn(function()
        local res = fetchModels(query)
        displayGrid(res)
        
        loadingLabel.Visible = false
        gridArea.Visible = true
    end)
end

searchBtn.MouseButton1Click:Connect(doSearch)
searchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then doSearch() end
end)

task.spawn(doSearch)

getgenv().RemoveSkyChanger = function()
    for _, connection in pairs(GlobalConnections) do
        if connection.Disconnect then
            connection:Disconnect()
        end
    end
    GlobalConnections = {}
    
    if studioGui then
        studioGui:Destroy()
    end
    
    getgenv().RemoveSkyChanger = nil
end
-- <<< End embedded: SkyC source
end
					end)
				elseif getgenv().RemoveSkyChanger then
					pcall(getgenv().RemoveSkyChanger)
				end
			end,
		})

		v18:AddToggle("Misc_CopyAvatar", {
			Text = "Copy Avatar",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(miscCopyAvatar)
				tbl3.Misc_CopyAvatar = miscCopyAvatar

				if miscCopyAvatar then
					pcall(function()
						do
-- >>> Embedded: copyava source
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local GlobalConnections = {}

local saveFileName = "Avatars.json"
local savedAvatars = {} 
local activeMorphId = nil 

local function loadSaves()
    if readfile then
        pcall(function()
            local decoded = HttpService:JSONDecode(readfile(saveFileName))
            if type(decoded) == "table" then savedAvatars = decoded end
        end)
    end
end

local function saveToFile()
    if writefile then
        pcall(function()
            writefile(saveFileName, HttpService:JSONEncode(savedAvatars))
        end)
    end
end

loadSaves()

local uiName = "MorphAva"
if getgenv().RemoveCopyAvatar then 
    pcall(getgenv().RemoveCopyAvatar) 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = uiName
ScreenGui.ResetOnSpawn = false
local uiParent = (gethui and gethui()) or game:GetService("CoreGui"):FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Parent = uiParent

local BgColor = Color3.fromRGB(35, 35, 40)
local TopBarColor = Color3.fromRGB(25, 25, 30)
local InputBgColor = Color3.fromRGB(20, 20, 25)
local TextColor = Color3.fromRGB(255, 255, 255)
local AccentColor = Color3.fromRGB(70, 130, 240)
local DangerColor = Color3.fromRGB(200, 60, 60)
local SuccessColor = Color3.fromRGB(50, 170, 80)
local ElementBg = Color3.fromRGB(50, 50, 55)
local globalRadius = UDim.new(0, 6)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 210, 0, 250) 
MainFrame.Position = UDim2.new(0, 380, 0.5, -125)
MainFrame.BackgroundColor3 = BgColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = false 
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = globalRadius
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(70, 70, 80)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 28)
TopBar.BackgroundColor3 = TopBarColor
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = globalRadius
TopBarCorner.Parent = TopBar

local TopBarBottomFiller = Instance.new("Frame")
TopBarBottomFiller.Size = UDim2.new(1, 0, 0, 10)
TopBarBottomFiller.Position = UDim2.new(0, 0, 1, -10)
TopBarBottomFiller.BackgroundColor3 = TopBarColor
TopBarBottomFiller.BorderSizePixel = 0
TopBarBottomFiller.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Copy Avatar by VDT"
Title.TextColor3 = TextColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -28, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "–"
MinimizeBtn.TextColor3 = TextColor
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = TopBar

local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then updateDrag(input) end
end))

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, 0, 1, -28)
Content.Position = UDim2.new(0, 0, 0, 28)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 2 
Content.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y 
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.ClipsDescendants = true 
Content.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Content

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 6)
UIPadding.Parent = Content

local function createCustomInput(placeholder, order, parentTarget)
    local target = parentTarget or Content
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 26)
    container.BackgroundColor3 = InputBgColor
    container.LayoutOrder = order
    Instance.new("UICorner", container).CornerRadius = globalRadius
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 90)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = container

    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1, -16, 1, 0)
    tb.Position = UDim2.new(0, 8, 0, 0)
    tb.BackgroundTransparency = 1
    tb.TextColor3 = TextColor
    tb.Text = "" 
    tb.PlaceholderText = placeholder
    tb.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
    tb.Font = Enum.Font.GothamMedium
    tb.TextSize = 11
    tb.TextXAlignment = Enum.TextXAlignment.Left
    tb.ClearTextOnFocus = false
    tb.Parent = container

    container.Parent = target
    return tb
end

local function createButton(text, bgColor, order, parentTarget)
    local target = parentTarget or Content
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 26)
    btn.BackgroundColor3 = bgColor
    btn.Text = text
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.LayoutOrder = order
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    Instance.new("UICorner", btn).CornerRadius = globalRadius
    
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.8, 0.8))
    }
    grad.Rotation = 90
    grad.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Transparency = 0.7
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = btn

    btn.Parent = target
    return btn
end

local EditToggleBtn = Instance.new("TextButton")
EditToggleBtn.Size = UDim2.new(0, 30, 0, 30)
EditToggleBtn.Position = UDim2.new(0, -35, 0.5, -15) 
EditToggleBtn.BackgroundTransparency = 1
EditToggleBtn.Text = "<"
EditToggleBtn.TextColor3 = TextColor
EditToggleBtn.Font = Enum.Font.GothamBold
EditToggleBtn.TextSize = 22
EditToggleBtn.ZIndex = 15
EditToggleBtn.Parent = MainFrame

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 0, 0)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = EditToggleBtn

local EditPanel = Instance.new("Frame")
EditPanel.Size = UDim2.new(0, 310, 0, 250)
EditPanel.Position = UDim2.new(0, -320, 0, 0)
EditPanel.BackgroundColor3 = BgColor
EditPanel.BorderSizePixel = 0
EditPanel.Visible = false
Instance.new("UICorner", EditPanel).CornerRadius = globalRadius
Instance.new("UIStroke", EditPanel).Color = Color3.fromRGB(70, 70, 80)
EditPanel.Parent = MainFrame

local ViewportContainer = Instance.new("Frame")
ViewportContainer.Size = UDim2.new(0, 145, 1, -20)
ViewportContainer.Position = UDim2.new(0, 10, 0, 10)
ViewportContainer.BackgroundColor3 = InputBgColor
Instance.new("UICorner", ViewportContainer).CornerRadius = globalRadius
Instance.new("UIStroke", ViewportContainer).Color = Color3.fromRGB(70, 70, 80)
ViewportContainer.Parent = EditPanel

local ViewportLabel = Instance.new("TextLabel")
ViewportLabel.Size = UDim2.new(1, 0, 1, 0)
ViewportLabel.BackgroundTransparency = 1
ViewportLabel.Text = "preview Avatar"
ViewportLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
ViewportLabel.Font = Enum.Font.GothamBold
ViewportLabel.TextSize = 12
ViewportLabel.ZIndex = 0
ViewportLabel.Parent = ViewportContainer

local Viewport = Instance.new("ViewportFrame")
Viewport.Size = UDim2.new(1, 0, 1, 0)
Viewport.BackgroundTransparency = 1
Viewport.LightColor = Color3.new(1, 1, 1)
Viewport.Ambient = Color3.new(0.8, 0.8, 0.8)
Viewport.Parent = ViewportContainer

local EditControls = Instance.new("Frame")
EditControls.Size = UDim2.new(0, 135, 1, -20)
EditControls.Position = UDim2.new(0, 165, 0, 10)
EditControls.BackgroundTransparency = 1
EditControls.Parent = EditPanel

local EditLayout = Instance.new("UIListLayout")
EditLayout.Padding = UDim.new(0, 8)
EditLayout.SortOrder = Enum.SortOrder.LayoutOrder
EditLayout.Parent = EditControls

local BtnKorles = createButton("Korles", ElementBg, 1, EditControls)
local BtnTypeAcc = createButton("Type Aksesoris", ElementBg, 2, EditControls)
local BtnRemoveAcc = createButton("Remove", ElementBg, 3, EditControls)

local EditDivider = Instance.new("Frame")
EditDivider.Size = UDim2.new(1, 0, 0, 2)
EditDivider.BackgroundColor3 = DangerColor
EditDivider.BorderSizePixel = 0
EditDivider.LayoutOrder = 4
EditDivider.Parent = EditControls

local InputAccId = createCustomInput("Input URL / ID Aksesoris", 5, EditControls)
local BtnApplyAcc = createButton("Apply", ElementBg, 6, EditControls)

local activeAccTarget = nil
local AccDropdownList = Instance.new("ScrollingFrame")
AccDropdownList.Size = UDim2.new(0, 135, 0, 100)
AccDropdownList.Position = UDim2.new(0, 165, 0, 72)
AccDropdownList.BackgroundColor3 = TopBarColor
AccDropdownList.BorderSizePixel = 0
AccDropdownList.Visible = false
AccDropdownList.ZIndex = 10
AccDropdownList.ScrollBarThickness = 2
AccDropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", AccDropdownList).CornerRadius = globalRadius
Instance.new("UIStroke", AccDropdownList).Color = Color3.fromRGB(70, 70, 80)
AccDropdownList.Parent = EditPanel

local AccListLayout = Instance.new("UIListLayout")
AccListLayout.SortOrder = Enum.SortOrder.LayoutOrder
AccListLayout.Parent = AccDropdownList

local function updatePreview()
    if not EditPanel.Visible then return end
    
    for _, child in pairs(Viewport:GetChildren()) do
        if child:IsA("Model") or child:IsA("Camera") then child:Destroy() end
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    char.Archivable = true
    local clone = char:Clone()
    char.Archivable = false
    
    if clone then
        for _, v in pairs(clone:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
        end
        clone.Parent = Viewport
        
        local hrp = clone:FindFirstChild("HumanoidRootPart") or clone:FindFirstChild("Torso") or clone:FindFirstChild("Head")
        if hrp then
            local cam = Instance.new("Camera")
            local camPos = hrp.CFrame.Position + (hrp.CFrame.LookVector * 5.5) + Vector3.new(0, 0.5, 0)
            cam.CFrame = CFrame.new(camPos, hrp.CFrame.Position)
            Viewport.CurrentCamera = cam
            cam.Parent = Viewport
        end
    end
end

local function refreshAccDropdown()
    for _, child in pairs(AccDropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local accessories = char:GetChildren()
    local count = 0
    for _, item in pairs(accessories) do
        if item:IsA("Accessory") then
            count = count + 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 22)
            btn.BackgroundColor3 = (count % 2 == 0) and Color3.fromRGB(35, 35, 40) or Color3.fromRGB(30, 30, 35)
            btn.BorderSizePixel = 0
            btn.Text = " " .. item.Name
            btn.TextTruncate = Enum.TextTruncate.AtEnd
            btn.TextColor3 = TextColor
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 10
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.ZIndex = 11
            btn.Parent = AccDropdownList
            
            btn.MouseButton1Click:Connect(function()
                activeAccTarget = item
                BtnTypeAcc.Text = item.Name
                AccDropdownList.Visible = false
            end)
        end
    end
end

EditToggleBtn.MouseButton1Click:Connect(function()
    EditPanel.Visible = not EditPanel.Visible
    if EditPanel.Visible then
        EditToggleBtn.Text = ">"
        EditToggleBtn.Position = UDim2.new(0, -355, 0.5, -15) 
        updatePreview()
    else
        EditToggleBtn.Text = "<"
        EditToggleBtn.Position = UDim2.new(0, -35, 0.5, -15) 
        AccDropdownList.Visible = false
    end
end)

BtnKorles.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = 0 
        local face = head:FindFirstChildOfClass("Decal")
        if face then face.Transparency = 1 end
        
        for _, v in pairs(head:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("BlockMesh") or v:IsA("CylinderMesh") then 
                v:Destroy() 
            end
        end
        
        local headlessMesh = Instance.new("SpecialMesh")
        headlessMesh.MeshType = Enum.MeshType.FileMesh
        headlessMesh.MeshId = "rbxassetid://134079402"
        headlessMesh.Scale = Vector3.new(1, 1, 1)
        headlessMesh.Parent = head
    end
    
    local rightLeg = char:FindFirstChild("Right Leg")
    if rightLeg then
        for _, v in pairs(rightLeg:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("BlockMesh") or v:IsA("CylinderMesh") then
                v:Destroy()
            end
        end
        
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.RightLeg then
                v:Destroy()
            end
        end
        
        rightLeg.Transparency = 0
        
        local korbloxMesh = Instance.new("SpecialMesh")
        korbloxMesh.MeshType = Enum.MeshType.FileMesh
        korbloxMesh.MeshId = "rbxassetid://101851696"
        korbloxMesh.TextureId = "rbxassetid://101851254"
        korbloxMesh.Scale = Vector3.new(1, 1, 1)
        korbloxMesh.Parent = rightLeg
    end
    
    updatePreview()
end)

BtnTypeAcc.MouseButton1Click:Connect(function()
    AccDropdownList.Visible = not AccDropdownList.Visible
    if AccDropdownList.Visible then refreshAccDropdown() end
end)

BtnRemoveAcc.MouseButton1Click:Connect(function()
    if activeAccTarget and activeAccTarget.Parent then
        activeAccTarget:Destroy()
        activeAccTarget = nil
        BtnTypeAcc.Text = "Type Aksesoris"
        updatePreview()
    end
end)

BtnApplyAcc.MouseButton1Click:Connect(function()
    local rawInput = InputAccId.Text
    if rawInput == "" then return end
    
    local extractedId = string.match(rawInput, "catalog/(%d+)") 
        or string.match(rawInput, "bundles/(%d+)") 
        or string.match(rawInput, "library/(%d+)") 
        or string.match(rawInput, "%d+")
        
    if not extractedId then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(extractedId))[1]
    end)
    
    if success and result then
        local targets = result:IsA("Model") and result:GetDescendants() or {result}
        table.insert(targets, result)
        
        for _, item in ipairs(targets) do
            if item:IsA("Accessory") then
                local clone = item:Clone()
                clone.Parent = char
                
                for _, part in pairs(clone:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                
                local handle = clone:FindFirstChild("Handle")
                if handle then
                    local accAtt = handle:FindFirstChildOfClass("Attachment")
                    local charAtt = accAtt and char:FindFirstChild(accAtt.Name, true)
                    
                    local weld = Instance.new("Weld")
                    weld.Name = "AccessoryWeld"
                    if charAtt then
                        weld.Part0 = charAtt.Parent
                        weld.Part1 = handle
                        weld.C0 = charAtt.CFrame
                        weld.C1 = accAtt.CFrame
                    else
                        local h = char:FindFirstChild("Head")
                        if h then
                            weld.Part0 = h
                            weld.Part1 = handle
                            weld.C0 = CFrame.new(0, 0.5, 0)
                            weld.C1 = clone.AttachmentPoint or CFrame.new()
                        end
                    end
                    weld.Parent = handle
                end
            elseif item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("Decal") then
                if item:IsA("Decal") and item.Name:lower() == "face" then
                    local h = char:FindFirstChild("Head")
                    if h then
                        for _, old in pairs(h:GetChildren()) do
                            if old:IsA("Decal") then old:Destroy() end
                        end
                        item:Clone().Parent = h
                    end
                else
                    local clone = item:Clone()
                    for _, old in pairs(char:GetChildren()) do
                        if old.ClassName == clone.ClassName then old:Destroy() end
                    end
                    clone.Parent = char
                end
            end
        end
        InputAccId.Text = ""
        updatePreview()
    end
end)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 14)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.LayoutOrder = 1
StatusLabel.Parent = Content

local InputUsername = createCustomInput("Input Username / ID", 2)
local BtnMorph = createButton("Morph Avatar", ElementBg, 3)
local BtnRestore = createButton("Restore Avatar", DangerColor, 4)

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, 0, 0, 2)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BorderSizePixel = 0
Divider.LayoutOrder = 5
local DivGrad = Instance.new("UIGradient")
DivGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, BgColor),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 120, 130)),
    ColorSequenceKeypoint.new(1, BgColor)
}
DivGrad.Parent = Divider
Divider.Parent = Content

local InputSaveName = createCustomInput("Config Save Name", 6)
local BtnSave = createButton("Save Avatar", SuccessColor, 7)

local DropdownBtn = createButton("Select Saved Avatar", ElementBg, 8)
local selectedSave = nil

local DropdownList = Instance.new("Frame") 
DropdownList.Size = UDim2.new(1, 0, 0, 0)
DropdownList.BackgroundColor3 = TopBarColor
DropdownList.BorderSizePixel = 0
DropdownList.Visible = false
DropdownList.LayoutOrder = 9
Instance.new("UICorner", DropdownList).CornerRadius = globalRadius
Instance.new("UIStroke", DropdownList).Color = Color3.fromRGB(70, 70, 80)
DropdownList.Parent = Content

local DropdownLayout = Instance.new("UIListLayout")
DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
DropdownLayout.Parent = DropdownList

local BtnMorphSave = createButton("Morph from Save", AccentColor, 10)
local BtnDeleteSave = createButton("Delete Save", DangerColor, 11)

local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 16, 0, 16)
ResizeHandle.Position = UDim2.new(1, -16, 1, -16)
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Text = "↘"
ResizeHandle.TextColor3 = Color3.fromRGB(120, 120, 120)
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.TextSize = 12
ResizeHandle.ZIndex = 20
ResizeHandle.Parent = MainFrame

local isMinimized = false
local preMinSize = MainFrame.Size

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        preMinSize = MainFrame.Size
        MainFrame.Size = UDim2.new(0, 150, 0, 28)
        Content.Visible = false
        ResizeHandle.Visible = false
        TopBarBottomFiller.Visible = false 
        EditPanel.Visible = false
        EditToggleBtn.Visible = false
    else
        MainFrame.Size = preMinSize
        Content.Visible = true
        ResizeHandle.Visible = true
        TopBarBottomFiller.Visible = true
        EditToggleBtn.Visible = true
        EditToggleBtn.Text = "<"
        EditToggleBtn.Position = UDim2.new(0, -35, 0.5, -15)
    end
end)

local resizing = false
local resizeStartPos, startSize
ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStartPos = input.Position
        startSize = MainFrame.AbsoluteSize
    end
end)

table.insert(GlobalConnections, UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if not isMinimized then
            local delta = input.Position - resizeStartPos
            local newWidth = math.clamp(startSize.X + delta.X, 180, 400)
            local newHeight = math.clamp(startSize.Y + delta.Y, 150, 500)
            MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end
end))

table.insert(GlobalConnections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end))

local function refreshDropdown()
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local count = 0
    for saveName, userId in pairs(savedAvatars) do
        count = count + 1
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 22)
        item.BackgroundColor3 = (count % 2 == 0) and Color3.fromRGB(35, 35, 40) or Color3.fromRGB(30, 30, 35)
        item.BorderSizePixel = 0
        item.Text = "  " .. saveName
        item.TextColor3 = TextColor
        item.Font = Enum.Font.GothamMedium
        item.TextSize = 10
        item.TextXAlignment = Enum.TextXAlignment.Left
        item.ZIndex = 11
        item.Parent = DropdownList
        
        item.MouseButton1Click:Connect(function()
            selectedSave = saveName
            DropdownBtn.Text = "Selected: " .. saveName
            DropdownList.Visible = false
        end)
    end
    DropdownList.Size = UDim2.new(1, 0, 0, count * 22)
end

DropdownBtn.MouseButton1Click:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
end)
refreshDropdown()

local function getUserId(input)
    if tonumber(input) then return tonumber(input) end
    local success, id = pcall(function() return Players:GetUserIdFromNameAsync(input) end)
    return success and id or nil
end

local function applyR6Morph(targetId)
    local character = LocalPlayer.Character
    local head = character and character:FindFirstChild("Head")
    if not character then return false, "Karakter tidak ditemukan!" end

    local success, appearance = pcall(function() return Players:GetCharacterAppearanceAsync(targetId) end)
    if not success or not appearance then return false, "Gagal memuat aset dari server!" end
    
    local successDesc, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(targetId) end)

    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then 
            v:Destroy() 
        end
    end
    
    if successDesc and desc then
        local bc = character:FindFirstChildOfClass("BodyColors")
        if not bc then
            bc = Instance.new("BodyColors", character)
        end
        bc.HeadColor3 = desc.HeadColor
        bc.LeftArmColor3 = desc.LeftArmColor
        bc.RightArmColor3 = desc.RightArmColor
        bc.LeftLegColor3 = desc.LeftLegColor
        bc.RightLegColor3 = desc.RightLegColor
        bc.TorsoColor3 = desc.TorsoColor
    else
        local targetBc = appearance:FindFirstChildOfClass("BodyColors")
        if targetBc then
            local currentBc = character:FindFirstChildOfClass("BodyColors")
            if currentBc then currentBc:Destroy() end
            targetBc:Clone().Parent = character
        end
    end
    
    local rightLeg = character:FindFirstChild("Right Leg")
    if rightLeg then
        rightLeg.Transparency = 0
        for _, v in pairs(rightLeg:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("BlockMesh") or v:IsA("CylinderMesh") then v:Destroy() end
        end
    end

    local targetShirt, targetPants, targetGraphic
    for _, v in pairs(appearance:GetDescendants()) do
        if v:IsA("Shirt") then targetShirt = v end
        if v:IsA("Pants") then targetPants = v end
        if v:IsA("ShirtGraphic") then targetGraphic = v end
    end
    
    local myShirt = character:FindFirstChildOfClass("Shirt")
    if targetShirt then
        if not myShirt then myShirt = Instance.new("Shirt", character) end
        myShirt.ShirtTemplate = targetShirt.ShirtTemplate
    elseif myShirt then myShirt:Destroy() end

    local myPants = character:FindFirstChildOfClass("Pants")
    if targetPants then
        if not myPants then myPants = Instance.new("Pants", character) end
        myPants.PantsTemplate = targetPants.PantsTemplate
    elseif myPants then myPants:Destroy() end
    
    local myGraphic = character:FindFirstChildOfClass("ShirtGraphic")
    if targetGraphic then
        if not myGraphic then myGraphic = Instance.new("ShirtGraphic", character) end
        myGraphic.Graphic = targetGraphic.Graphic
    elseif myGraphic then myGraphic:Destroy() end

    if head then
        head.Transparency = 0
        for _, v in pairs(head:GetChildren()) do
            if v:IsA("SpecialMesh") or v:IsA("BlockMesh") or v:IsA("CylinderMesh") or v:IsA("Decal") then v:Destroy() end
        end
        local targetFace, targetHeadMesh
        for _, v in pairs(appearance:GetDescendants()) do
            if v:IsA("Decal") and v.Name:lower() == "face" then targetFace = v 
            elseif (v:IsA("SpecialMesh") or v:IsA("BlockMesh") or v:IsA("CylinderMesh")) and not v:FindFirstAncestorOfClass("Accessory") then targetHeadMesh = v end
        end
        
        if targetFace then targetFace:Clone().Parent = head
        else Instance.new("Decal", head).Texture = "rbxasset://textures/face.png" end
        
        if targetHeadMesh then targetHeadMesh:Clone().Parent = head
        else 
            local dm = Instance.new("SpecialMesh", head)
            dm.MeshType = Enum.MeshType.Head; dm.Scale = Vector3.new(1.25, 1.25, 1.25)
        end
    end

    for _, item in pairs(appearance:GetDescendants()) do
        if item:IsA("CharacterMesh") then 
            item:Clone().Parent = character
        elseif item:IsA("Accessory") then
            
            local isLayeredClothing = false
            for _, v in pairs(item:GetDescendants()) do
                if v:IsA("WrapLayer") or v:IsA("WrapTarget") then
                    isLayeredClothing = true
                    break
                end
            end
            
            if not isLayeredClothing then
                local clone = item:Clone()
                local handle = clone:FindFirstChild("Handle")
                if handle then
                    clone.Parent = character
                    
                    for _, part in pairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    
                    local accAtt = handle:FindFirstChildOfClass("Attachment")
                    local charAtt = accAtt and character:FindFirstChild(accAtt.Name, true)
                    
                    local weld = Instance.new("Weld")
                    weld.Name = "AccessoryWeld"
                    if charAtt then
                        weld.Part0 = charAtt.Parent; weld.Part1 = handle; weld.C0 = charAtt.CFrame; weld.C1 = accAtt.CFrame
                    elseif head then
                        weld.Part0 = head; weld.Part1 = handle; weld.C0 = CFrame.new(0, 0.5, 0); weld.C1 = clone.AttachmentPoint or CFrame.new()
                    end
                    weld.Parent = handle
                end
            end
        end
    end
    
    updatePreview()
    return true, "Morph berhasil diterapkan!"
end


table.insert(GlobalConnections, LocalPlayer.CharacterAdded:Connect(function(newChar)
    if activeMorphId then
        task.spawn(function()
            newChar:WaitForChild("HumanoidRootPart", 5)
            newChar:WaitForChild("Humanoid", 5)
            task.wait(0.5)
            if activeMorphId then
                applyR6Morph(activeMorphId)
            end
        end)
    end
end))

local function setStatus(msg, color)
    StatusLabel.Text = "Status: " .. msg
    StatusLabel.TextColor3 = color
end

BtnMorph.MouseButton1Click:Connect(function()
    local text = InputUsername.Text
    if text == "" then setStatus("Input kosong!", DangerColor) return end
    setStatus("Memproses avatar...", TextColor)
    
    local extractedUserId = string.match(text, "^%d+$")
    local targetId = getUserId(extractedUserId or text)

    if not targetId then setStatus("User tidak ditemukan!", DangerColor) return end
    
    activeMorphId = targetId
    local success, msg = applyR6Morph(targetId)
    setStatus(msg, success and AccentColor or DangerColor)
end)

BtnRestore.MouseButton1Click:Connect(function()
    setStatus("Mengembalikan karakter...", TextColor)
    activeMorphId = nil
    local success, msg = applyR6Morph(LocalPlayer.UserId)
    setStatus(success and "Karakter dikembalikan." or "Gagal mengembalikan!", success and AccentColor or DangerColor)
end)

BtnSave.MouseButton1Click:Connect(function()
    local saveName = InputSaveName.Text
    local targetInput = InputUsername.Text
    if saveName == "" or targetInput == "" then setStatus("Nama & Username harus diisi!", DangerColor) return end
    
    local extractedUserId = string.match(targetInput, "^%d+$")
    local targetId = getUserId(extractedUserId or targetInput)
    
    if not targetId then setStatus("User target tidak valid!", DangerColor) return end
    
    savedAvatars[saveName] = targetId
    saveToFile()
    refreshDropdown()
    setStatus("Config '"..saveName.."' tersimpan!", SuccessColor)
    InputSaveName.Text = ""
end)

BtnMorphSave.MouseButton1Click:Connect(function()
    if not selectedSave or not savedAvatars[selectedSave] then setStatus("Pilih config dari dropdown!", DangerColor) return end
    setStatus("Memproses avatar dari save...", TextColor)
    
    activeMorphId = savedAvatars[selectedSave]
    local success, msg = applyR6Morph(activeMorphId)
    setStatus(msg, success and AccentColor or DangerColor)
end)

BtnDeleteSave.MouseButton1Click:Connect(function()
    if not selectedSave or not savedAvatars[selectedSave] then setStatus("Pilih config dari dropdown!", DangerColor) return end
    savedAvatars[selectedSave] = nil
    saveToFile()
    refreshDropdown()
    DropdownBtn.Text = "Select Saved Avatar"
    selectedSave = nil
    setStatus("Config dihapus!", SuccessColor)
end)

getgenv().RemoveCopyAvatar = function()
    for _, connection in pairs(GlobalConnections) do
        if connection.Disconnect then
            connection:Disconnect()
        end
    end
    GlobalConnections = {}
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    getgenv().RemoveCopyAvatar = nil
end
-- <<< End embedded: copyava source
end
					end)
				elseif getgenv().RemoveCopyAvatar then
					pcall(getgenv().RemoveCopyAvatar)
				end
			end,
		})

		v18:AddToggle("Misc_Moonwalk", {
			Text = "Moonwalk GUI",
			Content = "Moonwalk",
			Switch = true,
			Tooltip = "Keybind PC G",
			Default = false,
			Callback = function(arg)
				if arg then
					pcall(function()
						do
-- >>> Embedded: MoonWalk source
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

--[ CLEANUP LAMA (JIKA ADA) ]--
if getgenv().Moonwalk then
    pcall(getgenv().Moonwalk)
end

-- HARUS TRUE: Agar langsung menyala begitu dipanggil oleh GUI Toggle (loadstring)
local MoonwalkEnabled = true 
local MoonwalkMoveConn = nil
local KeybindConn = nil
local CharAddedConn = nil

local MOONWALK_SIDE_SPEED = 1.3
local MOONWALK_BACK_SPEED = 1.5
local MOONWALK_INTERVAL = 0.07
local ROTATION_INTENSITY = 0.9

local function stopMoonwalkInternal()
    if MoonwalkMoveConn then
        MoonwalkMoveConn:Disconnect()
        MoonwalkMoveConn = nil
    end
    if LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
        
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local gyro = hrp:FindFirstChild("VD_MoonwalkGyro")
            if gyro then gyro:Destroy() end
        end
    end
end

local function startMoonwalkInternal()
    stopMoonwalkInternal()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    local lastSwitch = 0
    local direction = 1
    
    MoonwalkMoveConn = RunService.RenderStepped:Connect(function()
        if not MoonwalkEnabled or not LP.Character then return end
        
        local currentHrp = LP.Character:FindFirstChild("HumanoidRootPart")
        local currentHum = LP.Character:FindFirstChildOfClass("Humanoid")
        
        if not currentHrp or not currentHum or currentHum.Health <= 0 then return end
        
        local moveDir = currentHum.MoveDirection
        
        if moveDir.Magnitude > 0 then
            currentHum.AutoRotate = false
            
            local gyro = currentHrp:FindFirstChild("VD_MoonwalkGyro")
            if not gyro then
                gyro = Instance.new("BodyGyro")
                gyro.Name = "VD_MoonwalkGyro"
                gyro.MaxTorque = Vector3.new(0, 100000, 0)
                gyro.P = 50000 
                gyro.Parent = currentHrp
            end
            
            local now = tick()
            if now - lastSwitch >= MOONWALK_INTERVAL then
                direction = direction * -1
                lastSwitch = now
            end
            
            local baseLook = CFrame.lookAt(currentHrp.Position, currentHrp.Position - moveDir)
            local glitchAngle = math.atan2(MOONWALK_SIDE_SPEED, MOONWALK_BACK_SPEED) * ROTATION_INTENSITY
            gyro.CFrame = baseLook * CFrame.Angles(0, direction * glitchAngle, 0)
            
            local forwardGlitch = moveDir * MOONWALK_BACK_SPEED
            local sideGlitch = baseLook.RightVector * (direction * MOONWALK_SIDE_SPEED)
            
            currentHum:Move(forwardGlitch + sideGlitch, false)
        else
            currentHum.AutoRotate = true
            local gyro = currentHrp:FindFirstChild("VD_MoonwalkGyro")
            if gyro then gyro:Destroy() end
        end
    end)
end

-- Keybind tambahan untuk on/off manual (PC)
KeybindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.G then
        MoonwalkEnabled = not MoonwalkEnabled
        if MoonwalkEnabled then 
            startMoonwalkInternal() 
        else 
            stopMoonwalkInternal() 
        end
    end
end)

CharAddedConn = LP.CharacterAdded:Connect(function()
    if MoonwalkEnabled then 
        task.wait(0.5) 
        startMoonwalkInternal() 
    end
end)

--[ CLEANUP FUNCTION GLOBAL ]--
getgenv().Moonwalk = function()
    MoonwalkEnabled = false
    stopMoonwalkInternal()
    if KeybindConn then KeybindConn:Disconnect() KeybindConn = nil end
    if CharAddedConn then CharAddedConn:Disconnect() CharAddedConn = nil end
    getgenv().Moonwalk = nil
end

-- EKSEKUSI UTAMA (Ini yang kurang di kodemu sebelumnya)
startMoonwalkInternal()
-- <<< End embedded: MoonWalk source
end
					end)
				elseif getgenv().Moonwalk then
					pcall(getgenv().Moonwalk)
				end
			end,
		})

		v18:AddToggle("Misc_Emote", {
			Text = "Emote GUI",
			Tooltip = "Buka Emote Menu",
			Default = false,
			Callback = function(arg)
				if arg then
					pcall(function()
						pcall(function()
							do
-- >>> Embedded: emote source
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local guiName = "CustomEmoteWheelGUI"
if CoreGui:FindFirstChild(guiName) then CoreGui[guiName]:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = guiName
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local WheelFrame = Instance.new("Frame", ScreenGui)
WheelFrame.Name = "WheelFrame"
WheelFrame.Size = UDim2.new(0, 300, 0, 300) 
WheelFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
WheelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
WheelFrame.BackgroundTransparency = 1
WheelFrame.Visible = false

local wheelAspect = Instance.new("UIAspectRatioConstraint", WheelFrame)
wheelAspect.AspectRatio = 1

local OuterRing = Instance.new("Frame", WheelFrame)
OuterRing.Name = "OuterRing"
OuterRing.Size = UDim2.new(1, 0, 1, 0)
OuterRing.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
OuterRing.BackgroundTransparency = 0.25
OuterRing.BorderSizePixel = 0
OuterRing.ZIndex = 1
Instance.new("UICorner", OuterRing).CornerRadius = UDim.new(1, 0)

local OuterStroke = Instance.new("UIStroke", OuterRing)
OuterStroke.Color = Color3.fromRGB(100, 100, 120)
OuterStroke.Thickness = 1.5
OuterStroke.Transparency = 0.4

for i = 1, 8 do
    local lineContainer = Instance.new("Frame", WheelFrame)
    lineContainer.Size = UDim2.new(1, 0, 1, 0)
    lineContainer.BackgroundTransparency = 1
    lineContainer.Rotation = (i - 1) * 45 + 22.5
    lineContainer.ZIndex = 2
    
    local line = Instance.new("Frame", lineContainer)
    line.Size = UDim2.new(0, 1.5, 0.29, 0)
    line.Position = UDim2.new(0.5, 0, 0, 0)
    line.AnchorPoint = Vector2.new(0.5, 0)
    line.BackgroundColor3 = Color3.fromRGB(120, 120, 140)
    line.BackgroundTransparency = 0.6
    line.BorderSizePixel = 0
end

local CenterHole = Instance.new("Frame", WheelFrame)
CenterHole.Name = "CenterHole"
CenterHole.Size = UDim2.new(0.42, 0, 0.42, 0)
CenterHole.Position = UDim2.new(0.5, 0, 0.5, 0)
CenterHole.AnchorPoint = Vector2.new(0.5, 0.5)
CenterHole.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
CenterHole.BackgroundTransparency = 0.85 
CenterHole.BorderSizePixel = 0
CenterHole.ZIndex = 3
Instance.new("UICorner", CenterHole).CornerRadius = UDim.new(1, 0)

local CenterStroke = Instance.new("UIStroke", CenterHole)
CenterStroke.Color = Color3.fromRGB(100, 100, 120)
CenterStroke.Thickness = 1.5
CenterStroke.Transparency = 0.4

local PageText = Instance.new("TextLabel", CenterHole)
PageText.Size = UDim2.new(1, 0, 0.3, 0)
PageText.Position = UDim2.new(0, 0, 0.2, 0)
PageText.BackgroundTransparency = 1
PageText.Text = "1 / 1"
PageText.TextColor3 = Color3.fromRGB(230, 230, 240)
PageText.Font = Enum.Font.GothamBold
PageText.TextSize = 12
PageText.ZIndex = 4

local PrevBtn = Instance.new("TextButton", CenterHole)
PrevBtn.Size = UDim2.new(0, 26, 0, 22)
PrevBtn.Position = UDim2.new(0.25, 0, 0.65, 0)
PrevBtn.AnchorPoint = Vector2.new(0.5, 0.5)
PrevBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
PrevBtn.Text = "<"
PrevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrevBtn.Font = Enum.Font.GothamBold
PrevBtn.TextSize = 12
PrevBtn.ZIndex = 4
Instance.new("UICorner", PrevBtn).CornerRadius = UDim.new(0, 6)

local NextBtn = Instance.new("TextButton", CenterHole)
NextBtn.Size = UDim2.new(0, 26, 0, 22)
NextBtn.Position = UDim2.new(0.75, 0, 0.65, 0)
NextBtn.AnchorPoint = Vector2.new(0.5, 0.5)
NextBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
NextBtn.Text = ">"
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.Font = Enum.Font.GothamBold
NextBtn.TextSize = 12
NextBtn.ZIndex = 4
Instance.new("UICorner", NextBtn).CornerRadius = UDim.new(0, 6)

local WheelContainer = Instance.new("Frame", WheelFrame)
WheelContainer.Name = "WheelContainer"
WheelContainer.Size = UDim2.new(1, 0, 1, 0)
WheelContainer.BackgroundTransparency = 1
WheelContainer.ZIndex = 4

local currentTrack, currentSound, activeEmoteName
local emoteList = {}
local currentPage = 1
local itemsPerPage = 8 
local currentDisplayedEmotes = {}

local function StopEmote()
    if currentTrack then 
        currentTrack:Stop()
        currentTrack:Destroy()
        currentTrack = nil 
    end
    if currentSound then 
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil 
    end
    activeEmoteName = nil
end

local function PlayEmote(animId, soundId)
    StopEmote()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    local animator = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 2)
    if not animator then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. string.match(animId, "%d+")
    
    currentTrack = animator:LoadAnimation(anim)
    currentTrack.Looped = true
    currentTrack:Play()

    if soundId and soundId ~= "" and char:FindFirstChild("HumanoidRootPart") then
        currentSound = Instance.new("Sound", char.HumanoidRootPart)
        currentSound.SoundId = "rbxassetid://" .. string.match(soundId, "%d+")
        currentSound.Looped = true
        currentSound:Play()
    end
end

local function ToggleGui()
    WheelFrame.Visible = not WheelFrame.Visible
    if WheelFrame.Visible then StopEmote() end
end

local function RenderPage(page)
    for _, child in pairs(WheelContainer:GetChildren()) do
        if child.Name == "EmoteSlice" then
            child:Destroy()
        end
    end

    currentDisplayedEmotes = {}
    local totalItems = #emoteList
    if totalItems == 0 then return end

    local totalPages = math.max(1, math.ceil(totalItems / itemsPerPage))
    currentPage = math.clamp(page, 1, totalPages)
    PageText.Text = currentPage .. " / " .. totalPages

    local startIndex = (currentPage - 1) * itemsPerPage + 1
    local endIndex = math.min(currentPage * itemsPerPage, totalItems)
    local countOnPage = endIndex - startIndex + 1

    local radius = 0.35 

    for i = 1, countOnPage do
        local emoteData = emoteList[startIndex + i - 1]
        
        currentDisplayedEmotes[i] = emoteData 
        
        local angle_deg = (i * 45) - 135 
        local rad = math.rad(angle_deg)
        
        local posX = 0.5 + math.cos(rad) * radius
        local posY = 0.5 + math.sin(rad) * radius

        local btn = Instance.new("TextButton", WheelContainer)
        btn.Name = "EmoteSlice"
        btn.Size = UDim2.new(0.28, 0, 0.28, 0)
        btn.Position = UDim2.new(posX, 0, posY, 0)
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        btn.BackgroundTransparency = 1 
        btn.ZIndex = 5
        
        btn.Text = emoteData.name .. "\n" .. tostring(i)
        btn.TextColor3 = Color3.fromRGB(240, 240, 250)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 10
        btn.TextWrapped = true
        btn.AutoButtonColor = false

        btn.Activated:Connect(function()
            activeEmoteName = emoteData.name
            PlayEmote(emoteData.id, emoteData.song)
            WheelFrame.Visible = false
        end)
    end
end

PrevBtn.Activated:Connect(function() RenderPage(currentPage - 1) end)
NextBtn.Activated:Connect(function() RenderPage(currentPage + 1) end)

local numberKeys = {
    [Enum.KeyCode.One] = 1, [Enum.KeyCode.KeypadOne] = 1,
    [Enum.KeyCode.Two] = 2, [Enum.KeyCode.KeypadTwo] = 2,
    [Enum.KeyCode.Three] = 3, [Enum.KeyCode.KeypadThree] = 3,
    [Enum.KeyCode.Four] = 4, [Enum.KeyCode.KeypadFour] = 4,
    [Enum.KeyCode.Five] = 5, [Enum.KeyCode.KeypadFive] = 5,
    [Enum.KeyCode.Six] = 6, [Enum.KeyCode.KeypadSix] = 6,
    [Enum.KeyCode.Seven] = 7, [Enum.KeyCode.KeypadSeven] = 7,
    [Enum.KeyCode.Eight] = 8, [Enum.KeyCode.KeypadEight] = 8
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.G then
        ToggleGui()
        return
    end

    if WheelFrame.Visible then
        if input.KeyCode == Enum.KeyCode.M then
            RenderPage(currentPage + 1)
            return
        elseif input.KeyCode == Enum.KeyCode.N then
            RenderPage(currentPage - 1)
            return
        end

        local slotIndex = numberKeys[input.KeyCode]
        if slotIndex and currentDisplayedEmotes[slotIndex] then
            local selectedEmote = currentDisplayedEmotes[slotIndex]
            activeEmoteName = selectedEmote.name
            PlayEmote(selectedEmote.id, selectedEmote.song)
            WheelFrame.Visible = false
        end
    end
end)

task.spawn(function()
    local customEmotebut = Instance.new("Frame")
    customEmotebut.Name = "custom_emotebut_wheel"
    customEmotebut.Parent = ScreenGui
    customEmotebut.BackgroundTransparency = 1 
    customEmotebut.BorderSizePixel = 0
    
    customEmotebut.AnchorPoint = Vector2.new(1, 0)
    customEmotebut.Position = UDim2.new(0.939999998, 0, 0.00899999961, 0)
    customEmotebut.Size = UDim2.new(0.259532124, 0, 0.391950965, 0)

    local customEmoteBtn = Instance.new("ImageButton", customEmotebut)
    customEmoteBtn.Name = "emote"
    
    customEmoteBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    customEmoteBtn.Position = UDim2.new(0.400000006, 0, 0.172399998, 0)
    customEmoteBtn.Size = UDim2.new(0.1548675, 0, 0.203999996, 0)
    
    customEmoteBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    customEmoteBtn.BackgroundTransparency = 0.8
    customEmoteBtn.Image = "rbxassetid://128855373783913"
    customEmoteBtn.ScaleType = Enum.ScaleType.Fit

    local btnAspect = Instance.new("UIAspectRatioConstraint", customEmoteBtn)
    btnAspect.AspectRatio = 1

    local btnCorner = Instance.new("UICorner", customEmoteBtn)
    btnCorner.CornerRadius = UDim.new(1, 0) 

    local btnStroke = Instance.new("UIStroke", customEmoteBtn)
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 1.2
    btnStroke.Transparency = 0.3

    customEmoteBtn.Activated:Connect(ToggleGui)
end)

task.spawn(function()
    local success, result = pcall(function() return game:HttpGet("https://pastebin.com/raw/DVUbsm3x") end)
    if success then
        local data = HttpService:JSONDecode(result)
        for _, v in pairs(data) do
            local hasValidId = v.id and tostring(v.id) ~= "" and tostring(v.id) ~= "0"
            local nameLower = string.lower(v.name or "")
            local isExcluded = string.find(nameLower, "emotold") or string.find(nameLower, "modelold")

            if hasValidId and not isExcluded then
                table.insert(emoteList, v)
            end
        end
        RenderPage(1)
    end
end)
-- <<< End embedded: emote source
end
						end)
					end)
				elseif getgenv().StopEmoteGUI then
					pcall(getgenv().StopEmoteGUI)
				end
			end,
		})

		local Movement = tbl17.Misc:AddLeftGroupbox("Movement", "sport-shoe")

		Movement:AddToggle("Misc_Noclip", {
			Text = "Noclip",
			Default = false,
			Callback = function(miscNoclip)
				tbl3.Misc_Noclip = miscNoclip
			end,
		})

		Movement:AddSlider("Misc_FlySpeed", {
			Text = "Fly Speed",
			Min = 10,
			Max = 500,
			Default = 10,
			Rounding = 0,
			Callback = function(miscFlySpeed)
				tbl3.Misc_FlySpeed = miscFlySpeed
			end,
		})

		Movement:AddToggle("Misc_FlyToggle", {
			Text = "Fly Mode",
			Default = false,
			Callback = function(miscFlyToggle)
				tbl3.Misc_FlyToggle = miscFlyToggle
				local character = tbl.LocalPlayer.Character
				local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
				if not character or not humanoid2 or not humanoidRootPart2 then
					return
				end

				if tbl3.Misc_FlyToggle then
					if character:FindFirstChild("Animate") then
						character.Animate.Disabled = true
					end

					for _, v19 in pairs(humanoid2:GetPlayingAnimationTracks()) do
						v19:Stop()
					end

					humanoid2:ChangeState(Enum.HumanoidStateType.Swimming)
					humanoid2.AutoRotate = false
					local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart2)
					bodyVelocity.Name = "FlyStable"
					bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
					bodyVelocity.Velocity = Vector3.zero
					local bodyGyro = Instance.new("BodyGyro", humanoidRootPart2)
					bodyGyro.Name = "FlyGyro"
					bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
					bodyGyro.P = 90000
					bodyGyro.CFrame = tbl.Camera.CFrame

					if tbl6.FlyConnection then
						tbl6.FlyConnection:Disconnect()
					end

					tbl6.FlyConnection = tbl.RunService.Heartbeat:Connect(function()
						if not character or not humanoidRootPart2 or not humanoid2 then
							return
						end
						tbl.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
						bodyGyro.CFrame = tbl.Camera.CFrame

						if humanoid2.MoveDirection.Magnitude > 0 then
							local moveDirection = humanoid2.MoveDirection
							local lookVector = tbl.Camera.CFrame.LookVector
							local y

							if tbl.UserInputService:IsKeyDown(Enum.KeyCode.W) or moveDirection:Dot(tbl.Camera.CFrame.LookVector) > 0.5 then
								y = lookVector.Y
							else
								local flag3 = tbl.UserInputService:IsKeyDown(Enum.KeyCode.S) or moveDirection:Dot(tbl.Camera.CFrame.LookVector) < -0.5
								y = 0

								if flag3 then
									y = -lookVector.Y
								end
							end

							local n3 = tbl3.Misc_FlySpeed / 10
							character:TranslateBy(Vector3.new(moveDirection.X, y, moveDirection.Z) * n3)
						end
					end)
				else
					if tbl6.FlyConnection then
						tbl6.FlyConnection:Disconnect()
					end

					if humanoidRootPart2:FindFirstChild("FlyStable") then
						humanoidRootPart2.FlyStable:Destroy()
					end

					if humanoidRootPart2:FindFirstChild("FlyGyro") then
						humanoidRootPart2.FlyGyro:Destroy()
					end

					if character:FindFirstChild("Animate") then
						character.Animate.Disabled = false
					end

					humanoid2.AutoRotate = true
					humanoid2:ChangeState(Enum.HumanoidStateType.Running)
					tbl.UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end
			end,
		})

		local v19 = tbl17.Misc:AddRightGroupbox("Jump Mod", "arrow-big-up-dash")

		v19:AddToggle("Misc_HighJump", {
			Text = "High Jump",
			Default = false,
			Callback = function(miscHighJump)
				tbl3.Misc_HighJump = miscHighJump

				if not miscHighJump and tbl.LocalPlayer.Character then
					local humanoid2 = tbl.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

					if humanoid2 then
						humanoid2.UseJumpPower = false
					end
				end
			end,
		})

		v19:AddSlider("Misc_JumpPower", {
			Text = "Jump Power",
			Min = 50,
			Max = 300,
			Default = 50,
			Rounding = 0,
			Callback = function(miscJumpPower)
				tbl3.Misc_JumpPower = miscJumpPower
			end,
		})

		v19:AddCheckbox("Misc_InfJump", {
			Text = "Infinite Jump",
			Default = false,
			Callback = function(miscInfJump)
				tbl3.Misc_InfJump = miscInfJump
			end,
		})

		local v20 = tbl17.Misc:AddLeftGroupbox("Visual Enhancements", "scan-eye")

		v20:AddToggle("Misc_SkipCutsceneToggle", {
			Text = "Skip Cutscene",
			Default = false,
			Tooltip = "Skip endscreen.",
			Callback = function(arg)
				fn15(arg)
			end,
		})

		v20:AddCheckbox("Misc_Fullbright", {
			Text = "Fullbright",
			Default = false,
			Callback = function(miscFullbright)
				tbl3.Misc_Fullbright = miscFullbright

				if miscFullbright then
					if not tbl6.OriginalLighting then
						local atmosphere = tbl.Lighting:FindFirstChildOfClass("Atmosphere")

						tbl6.OriginalLighting = {
							Brightness = tbl.Lighting.Brightness,
							FogEnd = tbl.Lighting.FogEnd,
							GlobalShadows = tbl.Lighting.GlobalShadows,
							OutdoorAmbient = tbl.Lighting.OutdoorAmbient,
							Ambient = tbl.Lighting.Ambient,
							AtmosphereDensity = atmosphere and atmosphere.Density or 0.3,
						}
					end

					fn48()
					fn49()
				else
					fn50()

					if tbl6.OriginalLighting then
						tbl.Lighting.Brightness = tbl6.OriginalLighting.Brightness
						tbl.Lighting.FogEnd = tbl6.OriginalLighting.FogEnd
						tbl.Lighting.GlobalShadows = tbl6.OriginalLighting.GlobalShadows
						tbl.Lighting.OutdoorAmbient = tbl6.OriginalLighting.OutdoorAmbient
						tbl.Lighting.Ambient = tbl6.OriginalLighting.Ambient
						local atmosphere = tbl.Lighting:FindFirstChildOfClass("Atmosphere")

						if atmosphere and tbl6.OriginalLighting.AtmosphereDensity then
							atmosphere.Density = tbl6.OriginalLighting.AtmosphereDensity
						end
					end
				end
			end,
		})

		v20:AddSlider("Fullbright_Time", {
			Text = "Fullbright Time",
			Min = 0,
			Max = 24,
			Default = 14,
			Rounding = 1,
			Callback = function(clockTime)
				if tbl3.Misc_Fullbright then
					tbl.Lighting.ClockTime = clockTime
				end
			end,
		})

		local Graphics = tbl17.Misc:AddRightGroupbox("Graphics", "contrast")

		Graphics:AddToggle("Misc_SmoothHDR", {
			Text = "Smooth HDR Graphics",
			Default = false,
			Callback = function(miscSmoothHDR)
				tbl3.Misc_SmoothHDR = miscSmoothHDR
				fn20(miscSmoothHDR)
			end,
		})

		local function fn66()
			if setfpscap then
				if toggles.Misc_FPSUnlockToggle.Value then
					local value = options.Misc_FPSDropdown.Value

					if value == "Max" then
						setfpscap(9999)
					else
						setfpscap(tonumber(value))
					end
				else
					setfpscap(60)
				end
			else
				fn2("Executor kamu tidak mensupport fitur setfpscap!", 3)
			end
		end

		Graphics:AddToggle("Misc_FPSUnlockToggle", {
			Text = "Unlock FPS",
			Default = false,
			Callback = function()
				fn66()
			end,
		})

		Graphics:AddDropdown("Misc_FPSDropdown", {
			Text = "Target FPS",
			Values = { "60", "90", "120", "Max" },
			Default = 3,
			Multi = false,
			Callback = function()
				if toggles.Misc_FPSUnlockToggle.Value then
					fn66()
				end
			end,
		})

		local Tools = tbl17.Misc:AddLeftGroupbox("Tools", "swords")
		local connection3 = nil

		Tools:AddButton({
			Text = "Tools Jerk",
			Func = function()
				pcall(function()
					do
-- >>> Embedded: Jerk tool source
local Players = game:GetService("Players")

game:GetService("UserInputService")
game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local function u3()
	-- upvalues: LocalPlayer (ref)
	local Tool = Instance.new("Tool")

	Tool.Name = "Jerk Off"
	Tool.RequiresHandle = false
	Tool.Parent = LocalPlayer.Backpack

	return Tool
end

local u4 = false
local t1 = {}

local function u6(p1, p2, p3, p4)
	-- upvalues: LocalPlayer (ref), t1 (ref), u4 (ref)
	local v18 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	if v18 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://" .. p1

		local track = v18:LoadAnimation(Animation)

		t1[p4] = game:GetService("RunService").RenderStepped:Connect(function()
			-- upvalues: u4 (ref), track (ref), p3 (ref), p2 (ref)
			if not u4 then
				track:Stop()
			elseif track.TimePosition >= p3 or track.IsPlaying == false then
				track:Play()
				track.TimePosition = p2
			end
		end)
		track:Play()
		track.TimePosition = p2

		return
	end

	warn("Humanoid not found!")
end
local function u7()
	-- upvalues: u6 (ref), u4 (ref)
	u6("72042024", 0.5, 0.9, 1)
	u6("168268306", 1, 1.001, 2)
	u4 = true
end
local function u8()
	-- upvalues: u4 (ref), t1 (ref)
	u4 = false

	for _, v in pairs(t1) do
		v:Disconnect()
	end

	t1 = {}
end
local function u9()
	-- upvalues: u7 (ref)
	u7()
end
local function u10()
	-- upvalues: u8 (ref)
	u8()
end

LocalPlayer.CharacterAdded:Connect(function(_)
	-- upvalues: LocalPlayer (ref), u3 (ref), u9 (ref), u10 (ref)
	if LocalPlayer.Backpack:FindFirstChild("Jerk Off") then
		LocalPlayer.Backpack["Jerk Off"]:Destroy()
	end

	local v25 = u3()

	v25.Equipped:Connect(u9)
	v25.Unequipped:Connect(u10)
end)

local v11 = u3()

v11.Equipped:Connect(u9)
v11.Unequipped:Connect(u10)
-- <<< End embedded: Jerk tool source
end
					fn2("Fitur Jerk berhasil dimuat!", 3)
				end)
			end,
		})

		v18:AddToggle("Misc_Ring", {
			Text = "Super Fling",
			Tooltip = "Fling semua player server (1x pakai di 1 server)",
			Default = false,
			Disabled = not flag,
			DisabledTooltip = "Fitur VIP (Locked)",
			Callback = function(arg)
				if arg then
					pcall(function()
						pcall(function()
							do
-- >>> Embedded: fling source
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local guiName = "fling"

-- ==========================================
-- 1. SISTEM ANTI DUPLIKAT & CLEANUP
-- ==========================================
if getgenv().StopSuperRing then
    getgenv().StopSuperRing()
end

getgenv().StopSuperRing = function()
    if CoreGui:FindFirstChild(guiName) then
        CoreGui[guiName]:Destroy()
    end
    if getgenv().RingHeartbeat then
        getgenv().RingHeartbeat:Disconnect()
        getgenv().RingHeartbeat = nil
    end
    if getgenv().ClaimHeartbeat then
        getgenv().ClaimHeartbeat:Disconnect()
        getgenv().ClaimHeartbeat = nil
    end
end

-- ==========================================
-- 2. TEMA UI (MINIMALIS & GELAP)
-- ==========================================
local Theme = {
    Background = Color3.fromRGB(25, 25, 30),
    Stroke = Color3.fromRGB(55, 55, 65),
    Text = Color3.fromRGB(230, 230, 235),
    Button = Color3.fromRGB(35, 35, 42),
    ButtonHover = Color3.fromRGB(45, 45, 55),
    OnColor = Color3.fromRGB(60, 140, 80), 
    OffColor = Color3.fromRGB(160, 60, 60)
}

local function playSound(soundId)
    pcall(function()
        local sound = Instance.new("Sound", SoundService)
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = 0.5; sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end)
end

playSound("2865227271")

-- ==========================================
-- 3. PEMBUATAN GUI (COMPACT)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.ResetOnSpawn = false
local success = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 120)
local vp = workspace.CurrentCamera.ViewportSize
MainFrame.Position = UDim2.new(0, (vp.X/2) - 100, 0, (vp.Y/2) - 60)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Theme.Stroke; MainStroke.Thickness = 1.2

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Super Fling"
Title.TextColor3 = Theme.Text
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Dragging Logic
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Tombol Header
local function createHeaderBtn(text, posX, callback, color)
    local Btn = Instance.new("TextButton", Header)
    Btn.Size = UDim2.new(0, 22, 0, 22)
    Btn.Position = UDim2.new(1, posX, 0.5, -11)
    Btn.Text = text; Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 11
    Btn.BackgroundColor3 = Theme.Background; Btn.TextColor3 = color or Theme.Text
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", Btn).Color = Theme.Stroke
    Btn.AutoButtonColor = false
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonHover}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Background}):Play() end)
    Btn.MouseButton1Click:Connect(callback)
end

local isMinimized = false
local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1

createHeaderBtn("-", -54, function()
    isMinimized = not isMinimized
    MainFrame:TweenSize(isMinimized and UDim2.new(0, 200, 0, 30) or UDim2.new(0, 200, 0, 120), "Out", "Quad", 0.25, true)
    Content.Visible = not isMinimized
    playSound("12221967")
end)
createHeaderBtn("X", -28, function() playSound("12221967"); getgenv().StopSuperRing() end, Color3.fromRGB(220, 90, 90))

-- Komponen Isi (Lebih Ramping)
local function createButton(parent, text, size, pos)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = size; Btn.Position = pos
    Btn.Text = text; Btn.Font = Enum.Font.GothamSemibold; Btn.TextSize = 12
    Btn.BackgroundColor3 = Theme.Button; Btn.TextColor3 = Theme.Text
    Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", Btn).Color = Theme.Stroke
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonHover}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Button}):Play() end)
    return Btn
end

local ToggleButton = createButton(Content, "Super Fling: OFF", UDim2.new(1, -20, 0, 26), UDim2.new(0, 10, 0, 8))
local DecreaseRadius = createButton(Content, "<", UDim2.new(0, 26, 0, 26), UDim2.new(0, 10, 0, 42))
local IncreaseRadius = createButton(Content, ">", UDim2.new(0, 26, 0, 26), UDim2.new(1, -36, 0, 42))

local RadiusInput = Instance.new("TextBox", Content)
RadiusInput.Size = UDim2.new(1, -84, 0, 26)
RadiusInput.Position = UDim2.new(0, 42, 0, 42)
RadiusInput.Text = "5"
RadiusInput.Font = Enum.Font.GothamSemibold; RadiusInput.TextSize = 12
RadiusInput.BackgroundColor3 = Theme.Button; RadiusInput.TextColor3 = Theme.Text
RadiusInput.ClearTextOnFocus = false
Instance.new("UICorner", RadiusInput).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", RadiusInput).Color = Theme.Stroke

local Watermark = Instance.new("TextLabel", Content)
Watermark.Size = UDim2.new(1, 0, 0, 15)
Watermark.Position = UDim2.new(0, 0, 1, -15)
Watermark.Text = "Super Fling server"
Watermark.TextColor3 = Color3.fromRGB(130, 130, 130)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Gotham; Watermark.TextSize = 10

-- ==========================================
-- 4. LOGIKA FLING & PART BERAT
-- ==========================================
local radius = 5
local height = 100
local rotationSpeed = 0.5
local attractionStrength = 1000
local ringPartsEnabled = false
local parts = {}

-- Filter Angka Radius
RadiusInput:GetPropertyChangedSignal("Text"):Connect(function()
    local filtered = RadiusInput.Text:gsub("%D", "")
    if RadiusInput.Text ~= filtered then RadiusInput.Text = filtered end
end)
RadiusInput.FocusLost:Connect(function()
    local num = tonumber(RadiusInput.Text)
    if num then radius = math.clamp(num, 0, 10000) end
    RadiusInput.Text = tostring(radius)
end)

ToggleButton.MouseButton1Click:Connect(function()
    ringPartsEnabled = not ringPartsEnabled
    ToggleButton.Text = ringPartsEnabled and "Super Fling: ON" or "Super Fling: OFF"
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = ringPartsEnabled and Theme.OnColor or Theme.Button}):Play()
    playSound("12221967")
end)
DecreaseRadius.MouseButton1Click:Connect(function() radius = math.max(0, radius - 5); RadiusInput.Text = tostring(radius); playSound("12221967") end)
IncreaseRadius.MouseButton1Click:Connect(function() radius = math.min(10000, radius + 5); RadiusInput.Text = tostring(radius); playSound("12221967") end)

if not getgenv().Network then
    getgenv().Network = { BaseParts = {}, Velocity = Vector3.new(14.5, 14.5, 14.5) }
end

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then return false end
        -- PART BERAT UNTUK FLING (Density 100)
        Part.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
        Part.CanCollide = false
        return true
    end
    return false
end

local function addPart(part)
    if RetainPart(part) and not table.find(parts, part) then 
        table.insert(Network.BaseParts, part)
        table.insert(parts, part) 
    end
end
for _, part in pairs(workspace:GetDescendants()) do addPart(part) end
workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(function(part)
    local idx = table.find(parts, part); if idx then table.remove(parts, idx) end
    local netIdx = table.find(Network.BaseParts, part); if netIdx then table.remove(Network.BaseParts, netIdx) end
end)

getgenv().ClaimHeartbeat = RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character then
        pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
        if not ringPartsEnabled then
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(workspace) then 
                    Part.Velocity = Network.Velocity 
                    Part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)

getgenv().RingHeartbeat = RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        local center = hrp.Position
        for _, part in pairs(parts) do
            if part.Parent and not part.Anchored then
                local pos = part.Position
                local distance = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
                local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
                local targetPos = Vector3.new(
                    center.X + math.cos(angle + math.rad(rotationSpeed)) * math.min(radius, distance),
                    center.Y + (height * (math.abs(math.sin((pos.Y - center.Y) / height)))),
                    center.Z + math.sin(angle + math.rad(rotationSpeed)) * math.min(radius, distance)
                )
                
                -- KECEPATAN TARIK + PUTARAN GILA UNTUK FLING
                part.Velocity = (targetPos - part.Position).unit * attractionStrength
                part.RotVelocity = Vector3.new(50000, 50000, 50000) 
            end
        end
    end
end)
-- <<< End embedded: fling source
end
						end)
					end)
				elseif getgenv().StopSuperRing then
					pcall(getgenv().StopSuperRing)
				end
			end,
		})

		Tools:AddToggle("Misc_AuraFling", {
			Text = "Fling ",
			Default = false,
			Callback = function(arg)
				if arg then
					if connection3 then
						connection3:Disconnect()
					end

					connection3 = tbl.RunService.PostSimulation:Connect(function()
						local character = tbl.LocalPlayer.Character
						local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
						if not humanoidRootPart2 then
							return
						end

						for _, player in ipairs(tbl.Players:GetPlayers()) do
							if player ~= tbl.LocalPlayer and player.Character then
								for _, child in ipairs(player.Character:GetChildren()) do
									if child:IsA("BasePart") then
										child.CanCollide = false
									end
								end
							end
						end

						local value = options.Misc_FlingPower.Value
						local velocity = humanoidRootPart2.Velocity
						humanoidRootPart2.Velocity = Vector3.new(value, value, value)

						for _, descendant in ipairs(character:GetDescendants()) do
							if descendant:IsA("BasePart") then
								descendant.CanCollide = false
							end
						end

						tbl.RunService.RenderStepped:Wait()

						if humanoidRootPart2 then
							humanoidRootPart2.Velocity = velocity
						end
					end)
				elseif connection3 then
					connection3:Disconnect()
					connection3 = nil
				end
			end,
		})

		Tools:AddSlider("Misc_FlingPower", {
			Text = "Fling Power",
			Min = 5000,
			Max = 100000,
			Default = 50000,
			Rounding = 0,
			Callback = function()
			end,
		})

		local v21 = tbl17.Config:AddLeftGroupbox("Menu Settings", "cog")

		v21:AddSlider("UICornerSlider", {
			Text = "Corner Radius",
			Default = lib2.CornerRadius,
			Min = 0,
			Max = 20,
			Rounding = 0,
			Callback = function(arg)
				v3:SetCornerRadius(arg)
			end,
		})

		v21:AddToggle("KeybindMenuOpen", {
			Default = lib2.KeybindFrame.Visible,
			Text = "Open Keybind",
			Callback = function(visible)
				lib2.KeybindFrame.Visible = visible
			end,
		})

		v21:AddToggle("ToggleCustomCursor", {
			Default = false,
			Text = "Custom Cursor",
			Callback = function(showCustomCursor)
				lib2.ShowCustomCursor = showCustomCursor
			end,
		})

		v21:AddToggle("LockMenu", {
			Default = true,
			Text = "Lock Gui",
			Callback = function(cantDragForced)
				lib2.CantDragForced = cantDragForced
			end,
		})

		v21:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
		lib2.ToggleKeybind = options.MenuKeybind
		lib2.ShowToggleFrameInKeybinds = true
		lib2.CantDragForced = true
		lib3:SetLibrary(lib2)
		lib3:SetFolder("JEJE/Theme")
		lib3:ApplyToTab(tbl17.Config)
		lib4:SetLibrary(lib2)
		lib4:IgnoreThemeSettings()
		lib4:SetIgnoreIndexes({ "MenuKeybind", "Surv_PerksKey", "Killer_WalkSpeedKey", "Surv_AutoParry" })
		lib4:SetFolder("JEJE/configs")
		lib4:BuildConfigSection(tbl17.Config)
		local v22 = tbl17.Info:AddLeftGroupbox("Profile User")

		v22:AddImage("UserAvatar", {
			Image = userThumbnailAsync,
			Transparency = 0,
			BackgroundTransparency = 0,
			Color = Color3.new(1, 1, 1),
			RectOffset = Vector2.zero,
			RectSize = Vector2.zero,
			ScaleType = Enum.ScaleType.Fit,
			Height = 50,
			Visible = true,
		})

		v22:AddLabel("Username: " .. tbl.LocalPlayer.Name)
		v22:AddLabel("Status: " .. (flag and "VIP" or "FREE"))
		v22:AddLabel("Expired: " .. expired)

		v22:AddLabel("Authentication: NONE")

		local v23 = tbl17.Info:AddRightGroupbox("Script Info")
		v23:AddLabel("Developer: LOLLERS JEJE")
		v23:AddLabel("Version: " .. tbl2.version)
		v23:AddLabel("Status: Skiddd")
		local v24 = tbl17.Info:AddLeftGroupbox("Sosial media")
		local v25 = v24:AddLabel("Discord: Mengambil data...")

		v24:AddButton({
			Text = "Join Discord",
			Func = function()
				setclipboard(tbl2.dc)
				fn2("Disalin!", 2)
			end,
		})

		v24:AddButton({
			Text = "Tiktok",
			Func = function()
				setclipboard(tbl2.tt)
				fn2("Disalin!", 2)
			end,
		})

		tbl17.Info:AddRightGroupbox("GUI"):AddButton({
			Text = "Destroy UI",
			DoubleClick = true,
			Func = function()
				tbl6.Unloaded = true
				lib2:Unload()

				if folder then
					folder:Destroy()
				end

				if circle then
					circle.Visible = false
					circle:Remove()
				end

				if tbl6.CutsceneConn then
					tbl6.CutsceneConn:Disconnect()
				end

				if tbl6.CharCutscene then
					tbl6.CharCutscene:Disconnect()
				end

				if tbl6.FlyConnection then
					tbl6.FlyConnection:Disconnect()
				end

				if tbl6.FollowConnection then
					tbl6.FollowConnection:Disconnect()
				end

				if tbl6.Pv2Con then
					tbl6.Pv2Con:Disconnect()
				end

				if connection3 then
					connection3:Disconnect()
				end

				if connection then
					connection:Disconnect()
				end

				if connection2 then
					connection2:Disconnect()
				end

				if tbl6.FleeThread then
					task.cancel(tbl6.FleeThread)
				end

				if tbl6.VaultBoostThread then
					task.cancel(tbl6.VaultBoostThread)
				end

				if HealAnimConnection then
					HealAnimConnection:Disconnect()
					HealAnimConnection = nil
				end

				fn27(false)

				if getgenv().SlasherInvisLoop then
					task.cancel(getgenv().SlasherInvisLoop)
					getgenv().SlasherInvisLoop = nil
				end

				if getgenv().resolusi then
					getgenv().resolusi:Disconnect()
					getgenv().resolusi = nil
				end

				if getgenv().VD_FakeParry_Cleanup then
					pcall(getgenv().VD_FakeParry_Cleanup)
				end

				if getgenv().InfoPerkCleanup then
					pcall(getgenv().InfoPerkCleanup)
				end

				fn38()

				if part then
					part:Destroy()
				end

				if highlight then
					highlight:Destroy()
				end

				if circle then
					circle.Visible = false
					circle:Remove()
				end

				for _, v26 in ipairs({ "WM", "FovC", "SpcGui", "TargetUI", "Croshair" }) do
					local v27 = tbl.CoreGui:FindFirstChild(v26)
					local playerGui

					if v27 then
						playerGui = v27
					else
						playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui") and tbl.LocalPlayer.PlayerGui:FindFirstChild(v26)
					end

					if playerGui then
						playerGui:Destroy()
					end
				end

				if getgenv().Tixo_SpectatorUI then
					getgenv().Tixo_SpectatorUI:Destroy()
				end

				local character = tbl.LocalPlayer.Character

				if character then
					local humanoid2 = character:FindFirstChildOfClass("Humanoid")
					local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

					if humanoid2 then
						humanoid2.WalkSpeed = tbl6.OriginalSpeed or 16
						humanoid2.UseJumpPower = false
						humanoid2.JumpPower = 50

						if character:FindFirstChild("Animate") then
							character.Animate.Disabled = false
						end

						humanoid2:ChangeState(Enum.HumanoidStateType.Running)
					end

					if humanoidRootPart2 then
						if humanoidRootPart2:FindFirstChild("FlyStable") then
							humanoidRootPart2.FlyStable:Destroy()
						end

						if humanoidRootPart2:FindFirstChild("FlyGyro") then
							humanoidRootPart2.FlyGyro:Destroy()
						end

						if humanoidRootPart2:FindFirstChild("SpamHitCircleESP") then
							humanoidRootPart2.SpamHitCircleESP:Destroy()
						end

						if humanoidRootPart2:FindFirstChild("AutoParryCircleESP") then
							humanoidRootPart2.AutoParryCircleESP:Destroy()
						end

						if humanoidRootPart2:FindFirstChild("KillerWarn") then
							humanoidRootPart2.KillerWarn:Destroy()
						end
					end

					character:SetAttribute("vaultspeed", 1)
					character:SetAttribute("speedboost", 1)
				end

				tbl.Camera.FieldOfView = 70
				tbl.LocalPlayer.CameraMode = Enum.CameraMode.Classic
				tbl.LocalPlayer.CameraMinZoomDistance = 0.5
				tbl.LocalPlayer.CameraMaxZoomDistance = 128
				fn50()

				if tbl6.OriginalLighting then
					tbl.Lighting.Brightness = tbl6.OriginalLighting.Brightness
					tbl.Lighting.FogEnd = tbl6.OriginalLighting.FogEnd
					tbl.Lighting.GlobalShadows = tbl6.OriginalLighting.GlobalShadows
					tbl.Lighting.OutdoorAmbient = tbl6.OriginalLighting.OutdoorAmbient
					tbl.Lighting.Ambient = tbl6.OriginalLighting.Ambient
					local atmosphere = tbl.Lighting:FindFirstChildOfClass("Atmosphere")

					if atmosphere and tbl6.OriginalLighting.AtmosphereDensity then
						atmosphere.Density = tbl6.OriginalLighting.AtmosphereDensity
					end
				end

				fn29()

				if getgenv().CleanupNoCD then
					pcall(getgenv().CleanupNoCD)
				end

				if getgenv().RemoveCopyAvatar then
					pcall(getgenv().RemoveCopyAvatar)
				end

				if getgenv().RemoveSkyChanger then
					pcall(getgenv().RemoveSkyChanger)
				end

				if getgenv().RemoveGlobalChat then
					pcall(getgenv().RemoveGlobalChat)
				end

				if getgenv().Moonwalk then
					pcall(getgenv().Moonwalk)
				end

				if getgenv().RemoveInvisibleGui then
					pcall(getgenv().RemoveInvisibleGui)
				end

				local invischair = tbl.Workspace:FindFirstChild("invischair")

				if invischair then
					pcall(function()
						invischair:Destroy()
					end)
				end

				tbl.LocalPlayer:SetAttribute("Level", tbl4.Level)
				tbl.LocalPlayer:SetAttribute("Gears", tbl4.Gears)
				tbl.LocalPlayer:SetAttribute("Screws", tbl4.Screws)

				for k, v26 in pairs(tbl3) do
					if type(v26) == "boolean" then
						tbl3[k] = false
					end
				end
			end,
		})

		local v26 = tbl17.Info:AddLeftGroupbox("Server Info")
		local jobId = game.JobId == "" and "Singleplayer/Studio" or game.JobId

		v26:AddButton({
			Text = "Copy Server ID",
			Func = function()
				if setclipboard then
					setclipboard(jobId)
					fn2("Tersalin!", 3)
				end
			end,
		})

		v26:AddButton({
			Text = "Rejoin Server",
			Func = function()
				local localPlayer = tbl.Players.LocalPlayer

				if game.JobId ~= "" then
					tbl.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
				else
					tbl.TeleportService:Teleport(game.PlaceId, localPlayer)
				end
			end,
		})

		v26:AddButton({
			Text = "Server Hop",
			Func = function()
				fn2("Mencari server baru...", 2)
				fn36()
			end,
		})

		task.spawn(function()
			local ok, result = pcall(function()
				return tbl.HttpService:JSONDecode(game:HttpGet("https://discord.com/api/v9/invites/AHEBP9gWgw?with_counts=true"))
			end)

			if ok and result then
				v25:SetText("Discord: " .. (result.approximate_member_count or "?") .. " Members")
			else
				v25:SetText("Discord: Error")
			end
		end)

		lib4:LoadAutoloadConfig()
	end

	-- Developer-unlocked startup: skip authentication and initialize all tabs/features.
	local flag3 = true
	fn64()

	local function fn65()
		task.spawn(function()
			local remotes2 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
			remotes2 = remotes2 and remotes2:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
			remotes2 = remotes2 and remotes2:WaitForChild("parryResult", 5)

			if remotes2 then
				remotes2.OnClientEvent:Connect(function(arg, arg2)
					local n4 = tonumber(arg2) or arg == true and 90 or 60
					tbl6.ParryCooldown = true

					if tbl6.ParryCooldownThread then
						task.cancel(tbl6.ParryCooldownThread)
					end

					tbl6.ParryCooldownThread = task.delay(n4, function()
						tbl6.ParryCooldown = false
					end)
				end)
			end
		end)
	end

	fn65()

	local function fn66()
		task.spawn(function()
			local remotes2 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10)
			remotes2 = remotes2 and remotes2:WaitForChild("KillerPerks", 5)
			remotes2 = remotes2 and remotes2:WaitForChild("kingscourge", 5)
			remotes2 = remotes2 and remotes2:WaitForChild("KingScourgeStart", 5)

			if remotes2 then
				remotes2.OnClientEvent:Connect(function()
					if tbl3.Surv_SkillCheckMode == "Random" then
						tbl6.RandomMode_IsNormal = true
					end
				end)
			end
		end)
	end

	fn66()
	local connection3 = nil

	local function fn67(arg)
		if not arg then
			return
		end

		if connection3 then
			connection3:Disconnect()
			connection3 = nil
		end

		task.spawn(function()
			fn26(arg)
			local humanoid2 = arg:WaitForChild("Humanoid", 5)
			if not humanoid2 then
				return
			end
			local animator = humanoid2:WaitForChild("Animator", 5) or humanoid2:FindFirstChildOfClass("Animator")
			if not animator then
				return
			end

			connection3 = animator.AnimationPlayed:Connect(function(arg2)
				local animationId = arg2.Animation and arg2.Animation.AnimationId
				if not animationId then
					return
				end

				if tbl3.Surv_SelfHeal and string.find(animationId, "95836365038528") then
					arg2:Stop(0)
				end
			end)
		end)
	end

	local function fn68()
		if fn5() ~= "Killer" then
			return
		end
		local selectedKiller = tbl.LocalPlayer:FindFirstChild("SelectedKiller")

		if string.find(string.lower(tostring(selectedKiller and selectedKiller.Value or tbl.LocalPlayer:GetAttribute("SelectedKiller"))), "abyss") then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.Killers.Abysswalker.corrupt:FireServer()
			end)
		end
	end

	local function fn69(arg)
		pcall(function()
			local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")

			for match in string.gmatch("Survivor-mob.Controls.crouch.icon", "[^%.]+") do
				playerGui = playerGui and playerGui:FindFirstChild(match)
			end

			if playerGui and playerGui:IsA("GuiObject") and playerGui.Visible and playerGui.Parent and playerGui.Parent:IsA("GuiButton") then
				local parent = playerGui.Parent

				if tbl.UserInputService.TouchEnabled and type(firesignal) == "function" then
					firesignal(parent.MouseButton1Click)
					task.wait(arg)
					firesignal(parent.MouseButton1Click)
				else
					tbl.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
					task.wait(arg)
					tbl.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
				end
			else
				tbl.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
				task.wait(arg)
				tbl.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
			end
		end)
	end

	local function fn70()
		if tbl6.isHolding then
			return
		end
		tbl6.isHolding = true

		task.spawn(function()
			while tbl6.isHolding and tbl3.Killer_InfAbyssal and fn5() == "Killer" do
				fn68()
				task.wait(0.5)
			end
		end)
	end

	tbl.UserInputService.InputBegan:Connect(function(input, gameProcessed)
		local flag4 = input.UserInputType == Enum.UserInputType.Touch
		if gameProcessed and not flag4 then
			return
		end
		local character = tbl.LocalPlayer.Character
		character = character and character:GetAttribute("spearmode") == true

		if tbl3.Killer_InfAbyssal and input.KeyCode == Enum.KeyCode.Q then
			fn70()
		end

		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			if tbl3.Aim_Silent then
				tbl8.isChargingPistol = true
				tbl6.locked = fn51("Pistol")
			end

			if tbl3.Flash_Silent then
				tbl8.isAimingFlash = true
			end
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			if tbl3.Aim_Silent and tbl8.isChargingPistol then
				fn59()
			end

			character = tbl3.Aim_SilentVeil and character

			if character then
				tbl8.isChargingSpear = true
				tbl8.spearAimStartTime = tick()

				task.delay(7, function()
					local isChargingSpear = tbl8.isChargingSpear

					if isChargingSpear then
						local spearAimStartTime = tbl8.spearAimStartTime
						isChargingSpear = tick() - spearAimStartTime >= 6.9
					end

					if isChargingSpear then
						tbl8.isChargingSpear = false
						tbl8.currentTouchInput = nil
					end
				end)
			end

			if fn5() == "Killer" then
				if tbl3.Aimbot_Enabled then
					tbl8.lockedAimbotTarget = fn51("Aimbot")

					if tbl8.lockedAimbotTarget then
						tbl8.isAimbotHolding = true
					end
				end

				if tbl3.Killer_InfLunge then
					fn60()
				end
			end
		elseif flag4 then
			if tbl3.Killer_InfAbyssal then
				local v4 = fn56()
				local move2 = v4 and v4:FindFirstChild("Controls") and v4.Controls:FindFirstChild("move2")

				if move2 and move2.Visible then
					local position3 = input.Position
					local absolutePosition = move2.AbsolutePosition
					local absoluteSize = move2.AbsoluteSize

					if position3.X >= absolutePosition.X and position3.X <= absolutePosition.X + absoluteSize.X and position3.Y >= absolutePosition.Y and position3.Y <= absolutePosition.Y + absoluteSize.Y then
						fn70()
						tbl6.currentTouch = input
					end
				end
			end

			if fn5() == "Killer" then
				local v4 = fn56()
				local attack = v4 and v4:FindFirstChild("Controls") and v4.Controls:FindFirstChild("attack")

				if attack and attack.Visible then
					local position3 = input.Position
					local absolutePosition = attack.AbsolutePosition
					local absoluteSize = attack.AbsoluteSize

					if position3.X >= absolutePosition.X and position3.X <= absolutePosition.X + absoluteSize.X and position3.Y >= absolutePosition.Y and position3.Y <= absolutePosition.Y + absoluteSize.Y then
						if tbl3.Aimbot_Enabled then
							tbl8.lockedAimbotTarget = fn51("Aimbot")

							if tbl8.lockedAimbotTarget then
								tbl8.isAimbotHolding = true
							end
						end

						if tbl3.Killer_InfLunge then
							fn60()
							tbl6.touchLunge = input
						end
					end
				end
			end

			if tbl3.Aim_Silent or tbl3.Flash_Silent then
				local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
				local guiMob = playerGui and playerGui:FindFirstChild("Survivor-mob") and playerGui["Survivor-mob"]:FindFirstChild("Controls") and playerGui["Survivor-mob"].Controls:FindFirstChild("Gui-mob")

				if guiMob and guiMob.Visible then
					local position3 = input.Position
					local absolutePosition = guiMob.AbsolutePosition
					local absoluteSize = guiMob.AbsoluteSize

					if position3.X >= absolutePosition.X and position3.X <= absolutePosition.X + absoluteSize.X and position3.Y >= absolutePosition.Y and position3.Y <= absolutePosition.Y + absoluteSize.Y then
						if tbl3.Aim_Silent then
							tbl8.isChargingPistol = true
							tbl8.currentTouchInput = input
							tbl6.locked = fn51("Pistol")
						end

						if tbl3.Flash_Silent then
							tbl8.isAimingFlash = true
							tbl8.currentTouchInput = input
						end
					end
				end
			end

			if tbl3.Aim_SilentVeil and character and not tbl6.spearSwitchCooldown then
				local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
				local attack = playerGui and playerGui:FindFirstChild("Slasher-mob") and playerGui["Slasher-mob"]:FindFirstChild("Controls") and playerGui["Slasher-mob"].Controls:FindFirstChild("attack")

				if attack and attack.Visible then
					local position3 = input.Position
					local absolutePosition = attack.AbsolutePosition
					local absoluteSize = attack.AbsoluteSize

					if position3.X >= absolutePosition.X and position3.X <= absolutePosition.X + absoluteSize.X and position3.Y >= absolutePosition.Y and position3.Y <= absolutePosition.Y + absoluteSize.Y then
						tbl8.isChargingSpear = true
						tbl8.currentTouchInput = input
						tbl8.spearAimStartTime = tick()

						task.delay(7, function()
							local isChargingSpear = tbl8.isChargingSpear

							if isChargingSpear then
								local spearAimStartTime = tbl8.spearAimStartTime
								isChargingSpear = tick() - spearAimStartTime >= 6.9
							end

							if isChargingSpear then
								tbl8.isChargingSpear = false
								tbl8.currentTouchInput = nil
							end
						end)
					end
				end
			end
		end
	end)

	tbl.UserInputService.InputEnded:Connect(function(input)
		local flag4 = input.UserInputType == Enum.UserInputType.Touch

		if input.KeyCode == Enum.KeyCode.Q then
			tbl6.isHolding = false
		end

		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			if tbl8.isChargingPistol then
				tbl8.isChargingPistol = false
				tbl6.locked = nil
			end

			if tbl8.isAimingFlash then
				tbl8.isAimingFlash = false
			end
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 or flag4 then
			tbl8.isAimbotHolding = false
			tbl8.lockedAimbotTarget = nil

			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				tbl6.isHoldingLunge = false
			end
		end

		if flag4 and input == tbl6.touchLunge then
			tbl6.isHoldingLunge = false
			tbl6.touchLunge = nil
		end

		if flag4 and input == tbl6.currentTouch then
			tbl6.isHolding = false
			tbl6.currentTouch = nil
		end

		if tbl8.isChargingSpear and (input == tbl8.currentTouchInput or input.UserInputType == Enum.UserInputType.MouseButton1) then
			tbl8.isChargingSpear = false

			if tbl8.currentTouchInput == input then
				tbl8.currentTouchInput = nil
			end

			if tbl6.spearSwitchCooldown then
				return
			end

			if tick() - (tbl8.spearAimStartTime or tick()) >= 7 then
				return
			end

			if tbl6.isAttackCd then
				return
			end
			tbl6.isAttackCd = true

			task.delay(3, function()
				tbl6.isAttackCd = false
			end)

			local character = tbl.LocalPlayer.Character
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")

			if character and (character:FindFirstChild("Head") or humanoidRootPart2) and humanoidRootPart2 then
				local flag5 = character:GetAttribute("special") == true
				local position3 = humanoidRootPart2.Position
				local spearSpeed = tbl3.SmartPredict and (flag5 and 165 or 142.5) or tbl3.SPEAR_Speed
				local Survivor = fn51("Survivor")
				local unit

				if Survivor then
					local humanoidRootPart3 = Survivor:IsA("Model") and Survivor:FindFirstChild("HumanoidRootPart") or Survivor
					local position4 = humanoidRootPart3.Position
					local humanoid2 = Survivor.Parent and Survivor.Parent:FindFirstChildOfClass("Humanoid")
					local n4

					if humanoid2 and humanoid2.MoveDirection.Magnitude > 0 then
						n4 = humanoid2.MoveDirection * humanoid2.WalkSpeed
					else
						n4 = Vector3.zero

						if humanoidRootPart3:IsA("BasePart") then
							n4 = humanoidRootPart3.AssemblyLinearVelocity
						end
					end

					local vector = Vector3.new(n4.X, 0, n4.Z)
					local magnitude = (position4 - position3).Magnitude
					local n5 = magnitude / spearSpeed

					if tbl3.SmartPredict then
						unit = (position4 + vector * n5 * tbl3.Veil_LeadMultiplier + Vector3.new(0, 0.5 * tbl.Workspace.Gravity * 0.5 * n5 ^ 2 - 1.5, 0) - position3).Unit
					else
						unit = (position4 + vector * n5 * math.clamp(magnitude / 50, 0.1, 4) + Vector3.new(0, 0.5 * tbl3.SPEAR_Gravity * n5 ^ 2 * math.clamp(magnitude / 100, 1, 2.5), 0) - position3).Unit
					end
				else
					unit = tbl.Camera.CFrame.LookVector
				end

				pcall(function()
					tbl.ReplicatedStorage.Remotes.Killers.Veil.Spearthrow:FireServer(unit, spearSpeed, position3)
				end)
			end
		end

		if flag4 and input == tbl8.currentTouchInput then
			if tbl8.isChargingPistol then
				tbl8.isChargingPistol = false
				tbl8.currentTouchInput = nil
				local flag5 = false

				pcall(function()
					local playerGui = tbl.LocalPlayer:FindFirstChild("PlayerGui")
					local cancelaim = playerGui and playerGui:FindFirstChild("Survivor-mob") and playerGui["Survivor-mob"]:FindFirstChild("Controls") and playerGui["Survivor-mob"].Controls:FindFirstChild("Gui-mob") and playerGui["Survivor-mob"].Controls["Gui-mob"]:FindFirstChild("cancelaim")

					if cancelaim and cancelaim.Visible then
						local position3 = input.Position
						local absolutePosition = cancelaim.AbsolutePosition
						local absoluteSize = cancelaim.AbsoluteSize

						if position3.X >= absolutePosition.X and position3.X <= absolutePosition.X + absoluteSize.X and position3.Y >= absolutePosition.Y and position3.Y <= absolutePosition.Y + absoluteSize.Y then
							flag5 = true
						end
					end
				end)

				if not flag5 then
					fn59()
				end

				tbl6.locked = nil
			end

			if tbl8.isAimingFlash then
				tbl8.isAimingFlash = false
				tbl8.currentTouchInput = nil
			end
		end
	end)

	local flag4 = false
	local position3 = nil
	local position4 = nil

	frame5.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag4 = true
			position3 = input.Position
			position4 = frame4.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag4 = false
				end
			end)
		end
	end)

	tbl.UserInputService.InputChanged:Connect(function(input)
		local flag5 = flag4

		if flag4 then
			flag5 = input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
		end

		if flag5 then
			local n4 = input.Position - position3
			frame4.Position = UDim2.new(position4.X.Scale, position4.X.Offset + n4.X, position4.Y.Scale, position4.Y.Offset + n4.Y)
		end
	end)

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = true
			position = input.Position
			position2 = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag2 = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v2 = input
		end
	end)

	tbl.UserInputService.InputChanged:Connect(function(input)
		if flag2 and input == v2 then
			fn18(input)
		end
	end)

	local tbl18 = {}
	local fn71 = nil

	fn71 = function(arg)
		if not arg or tbl18[arg] then
			return
		end
		tbl18[arg] = true
		local humanoid2 = arg:WaitForChild("Humanoid", 5)
		if not humanoid2 then
			return
		end
		local animator = humanoid2:FindFirstChildOfClass("Animator") or humanoid2:WaitForChild("Animator", 5)
		if not animator then
			return
		end
		local connection4 = nil

		connection4 = humanoid2.ChildAdded:Connect(function(child)
			if child:IsA("Animator") then
				tbl18[arg] = nil

				if connection4 then
					connection4:Disconnect()
				end

				fn71(arg)
			end
		end)

		arg.AncestryChanged:Connect(function(child, parent)
			if not parent then
				tbl18[arg] = nil

				if connection4 then
					connection4:Disconnect()
				end
			end
		end)

		animator.AnimationPlayed:Connect(function(arg2)
			local match = (arg2.Animation and arg2.Animation.AnimationId or ""):match("%d+")

			if (match == "86266790353635" or match == "93136435416899") and tbl3.Surv_CrouchV then
				local character = tbl.LocalPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")

				if character and humanoidRootPart2 and character.Parent and humanoidRootPart2.Parent then
					if (character.Position - humanoidRootPart2.Position).Magnitude <= 35 then
						local n4 = Vector3.new(character.Position.X, 0, character.Position.Z) - Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z)

						if n4.Magnitude > 0 then
							local unit = n4.Unit
							local vector = Vector3.new(humanoidRootPart2.CFrame.LookVector.X, 0, humanoidRootPart2.CFrame.LookVector.Z)

							if vector.Magnitude > 0.001 then
								if vector.Unit:Dot(unit) >= 0.7 then
									fn69(0.3)
								end
							end
						end
					end
				end
			end

			local v4 = tbl5[match]
			if not v4 then
				return
			end

			if match == "80411309607666" and tbl3.Surv_AutoCrouch then
				local character = tbl.LocalPlayer.Character
				if fn11(character) or not fn13(character) then
					return
				end
				character = character and character:FindFirstChild("HumanoidRootPart")
				local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")

				if character and humanoidRootPart2 and character.Parent and humanoidRootPart2.Parent then
					if (character.Position - humanoidRootPart2.Position).Magnitude <= 35 then
						fn69(1.5)
					end
				end

				return
			end

			if not tbl3.Surv_Parry then
				return
			end

			if tbl3.Ignored_Skills_List and tbl3.Ignored_Skills_List[v4] then
				return
			end
			local character = tbl.LocalPlayer.Character
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
			local humanoidRootPart3 = arg:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart2 or not humanoidRootPart3 then
				return
			end

			if match == "98163597193511" then
				if tbl6.ParryCooldown or fn11(character) or not fn13(character) then
					return
				end

				if humanoidRootPart2.Parent and humanoidRootPart3.Parent then
					if (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude <= 20 then
						local n4 = Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z) - Vector3.new(humanoidRootPart3.Position.X, 0, humanoidRootPart3.Position.Z)

						if n4.Magnitude > 0 then
							local unit = n4.Unit
							local vector = Vector3.new(humanoidRootPart3.CFrame.LookVector.X, 0, humanoidRootPart3.CFrame.LookVector.Z)

							if vector.Magnitude > 0.001 then
								if (tbl3.Surv_ParryFace or 0.7) <= vector.Unit:Dot(unit) then
									fn53()
								end
							end
						end
					end
				end

				return
			end

			local magnitude = (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude

			if tbl3.Surv_ParryAggressive then
				local n4 = 10
				if tbl3.Surv_ParryRadius + 5 < magnitude then
					return
				end
				local connection5 = nil
				local now = os.clock()

				connection5 = tbl.RunService.Heartbeat:Connect(function()
					if os.clock() - now >= 1.5 or not humanoidRootPart2 or not humanoidRootPart2.Parent or not humanoidRootPart3 or not humanoidRootPart3.Parent then
						connection5:Disconnect()
						return
					end

					if fn11(character) then
						connection5:Disconnect()
						return
					end

					if (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude <= n4 then
						if not tbl6.ParryCooldown and fn13(character) then
							local n5 = Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z) - Vector3.new(humanoidRootPart3.Position.X, 0, humanoidRootPart3.Position.Z)

							if n5.Magnitude > 0 then
								local unit = n5.Unit
								local vector = Vector3.new(humanoidRootPart3.CFrame.LookVector.X, 0, humanoidRootPart3.CFrame.LookVector.Z)

								if vector.Magnitude > 0.001 then
									if (tbl3.Surv_ParryFace or 0.7) <= vector.Unit:Dot(unit) then
										fn53()
										connection5:Disconnect()
									end
								else
									fn53()
									connection5:Disconnect()
								end
							else
								fn53()
								connection5:Disconnect()
							end
						end
					end
				end)
			else
				if magnitude > tbl3.Surv_ParryRadius then
					return
				end

				if tbl6.ParryCooldown or fn11(character) or not fn13(character) then
					return
				end

				if humanoidRootPart2.Parent and humanoidRootPart3.Parent then
					local n4 = Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z) - Vector3.new(humanoidRootPart3.Position.X, 0, humanoidRootPart3.Position.Z)
					if not (n4.Magnitude > 0) then
						return
					end
					local unit = n4.Unit
					local vector = Vector3.new(humanoidRootPart3.CFrame.LookVector.X, 0, humanoidRootPart3.CFrame.LookVector.Z)

					if vector.Magnitude > 0.001 then
						if vector.Unit:Dot(unit) < (tbl3.Surv_ParryFace or 0.7) then
							return
						end
					end

					fn53()
				end
			end
		end)
	end

	local function fn72(arg)
		if arg ~= tbl.LocalPlayer and fn6(arg) and arg.Character then
			fn71(arg.Character)
		end
	end

	local function fn73(arg)
		if arg == tbl.LocalPlayer then
			return
		end

		arg.CharacterAdded:Connect(function()
			fn72(arg)
		end)

		arg:GetPropertyChangedSignal("Team"):Connect(function()
			fn72(arg)
		end)

		if arg.Character then
			fn72(arg)
		end
	end

	for _, player in ipairs(tbl.Players:GetPlayers()) do
		fn73(player)
		player:GetPropertyChangedSignal("Team"):Connect(fn19)
	end

	tbl.Players.PlayerAdded:Connect(function(player)
		fn19()
		player:GetPropertyChangedSignal("Team"):Connect(fn19)
		fn73(player)
	end)

	tbl.Players.PlayerRemoving:Connect(function()
		fn19()
	end)

	tbl.RunService.RenderStepped:Connect(function()
		if tbl3.Surv_Fov and tbl.Camera.FieldOfView ~= tbl3.Surv_FOV_Value then
			tbl.Camera.FieldOfView = tbl3.Surv_FOV_Value
		end

		if tbl8.isAimingFlash and tbl3.Flash_Silent then
			local Flash = fn51("Flash")

			if Flash then
				local character = tbl.LocalPlayer.Character
				local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
				local n4 = Flash.Position + Vector3.new(0, tbl3.Flash_YOffset, 0)
				local currentCamera = tbl.Workspace.CurrentCamera
				currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.lookAt(currentCamera.CFrame.Position, n4), 0.5)

				if humanoidRootPart2 then
					humanoidRootPart2.CFrame = humanoidRootPart2.CFrame:Lerp(CFrame.lookAt(humanoidRootPart2.Position, Vector3.new(n4.X, humanoidRootPart2.Position.Y, n4.Z)), 0.5)
				end
			end
		end

		if tbl8.isChargingPistol and tbl3.Aim_Lock then
			if tbl6.locked and tbl6.locked.Parent and tbl6.locked.Parent:FindFirstChild("Humanoid") and tbl6.locked.Parent.Humanoid.Health > 0 then
				fn57(tbl6.locked)
			else
				tbl6.locked = fn51("Pistol")
			end
		end

		local character = v or tbl.LocalPlayer.Character
		local humanoidRootPart2 = humanoidRootPart or character and character:FindFirstChild("HumanoidRootPart")

		if not humanoid then
			if character then
				character:FindFirstChildOfClass("Humanoid")
			end
		end

		if tbl3.Killer_HitEspCircle and tbl3.Killer_SpamHit and humanoidRootPart2 then
			if not tbl6.SpamHit or tbl6.SpamHit.Parent ~= humanoidRootPart2 then
				if tbl6.SpamHit then
					tbl6.SpamHit:Destroy()
				end

				tbl6.SpamHit = Instance.new("CylinderHandleAdornment")
				tbl6.SpamHit.Name = "SpamHitCircleESP"
				tbl6.SpamHit.Height = 0.05
				tbl6.SpamHit.Color3 = Color3.fromRGB(255, 0, 0)
				tbl6.SpamHit.Transparency = 0.3
				tbl6.SpamHit.Adornee = humanoidRootPart2
				tbl6.SpamHit.Parent = humanoidRootPart2
				tbl6.SpamHit.ZIndex = 0
				tbl6.SpamHit.AlwaysOnTop = false
			end

			tbl6.SpamHit.Radius = tbl3.Killer_SpamHitRadius
			tbl6.SpamHit.InnerRadius = math.max(0.1, tbl3.Killer_SpamHitRadius - 0.15)
			tbl6.SpamHit.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
		elseif tbl6.SpamHit then
			tbl6.SpamHit:Destroy()
			tbl6.SpamHit = nil
		end

		local survParryCircle = tbl3.Surv_ParryCircle
		local survParry

		if survParryCircle then
			survParry = tbl3.Surv_Parry or tbl3.Surv_ParryV2
		else
			survParry = survParryCircle
		end

		if survParry and humanoidRootPart2 then
			if not tbl6.autoParry or tbl6.autoParry.Parent ~= humanoidRootPart2 then
				if tbl6.autoParry then
					tbl6.autoParry:Destroy()
				end

				tbl6.autoParry = Instance.new("CylinderHandleAdornment")
				tbl6.autoParry.Name = "AutoParryCircleESP"
				tbl6.autoParry.Height = 0.05
				tbl6.autoParry.Transparency = 0.3
				tbl6.autoParry.Adornee = humanoidRootPart2
				tbl6.autoParry.Parent = humanoidRootPart2
				tbl6.autoParry.ZIndex = 0
				tbl6.autoParry.AlwaysOnTop = false
			end

			local survParryRadius = tbl3.Surv_ParryRadius

			if tbl3.Surv_ParryAggressive then
				survParryRadius += 5
			end

			tbl6.autoParry.Radius = survParryRadius
			tbl6.autoParry.InnerRadius = math.max(0.1, survParryRadius - 0.15)
			tbl6.autoParry.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(1.5707963267948966, 0, 0)

			if tbl6.ParryCooldown then
				tbl6.autoParry.Color3 = Color3.fromRGB(255, 128, 0)
			elseif tbl3.Surv_ParryAggressive then
				tbl6.autoParry.Color3 = Color3.fromRGB(255, 0, 0)
			else
				tbl6.autoParry.Color3 = Color3.fromRGB(0, 255, 255)
			end
		elseif tbl6.autoParry then
			tbl6.autoParry:Destroy()
			tbl6.autoParry = nil
		end

		if tbl3.Aimbot_Enabled and tbl.LocalPlayer.Character then
			if fn5() == "Survivor" then
				local Aimbot = fn51("Aimbot")

				if Aimbot and humanoidRootPart2 then
					local position5 = Aimbot.Position
					local v4 = fn9(position5)

					if v4 < 100 then
						position5 += tbl.Camera.CFrame.RightVector * (100 - v4) * tbl3.Aimbot_Predict
					end

					local aimbotSmoothness = tbl3.Aimbot_Smoothness
					tbl.Camera.CFrame = tbl.Camera.CFrame:Lerp(CFrame.new(tbl.Camera.CFrame.Position, position5), aimbotSmoothness)
					local aimbotSmoothness2 = tbl3.Aimbot_Smoothness
					humanoidRootPart2.CFrame = humanoidRootPart2.CFrame:Lerp(CFrame.new(humanoidRootPart2.Position, Vector3.new(position5.X, humanoidRootPart2.Position.Y, position5.Z)), aimbotSmoothness2)
				end
			elseif fn5() == "Killer" then
				if tbl8.isAimbotHolding and tbl8.lockedAimbotTarget then
					local parent = tbl8.lockedAimbotTarget.Parent
					local humanoid2 = parent and parent:FindFirstChild("Humanoid")

					if not humanoid2 or humanoid2.Health <= 0 or fn11(parent) then
						tbl8.lockedAimbotTarget = fn51("Aimbot")
					end

					if tbl8.lockedAimbotTarget and humanoidRootPart2 then
						local position5 = tbl8.lockedAimbotTarget.Position
						local aimbotMaxDist = tbl3.Aimbot_MaxDist

						if fn9(position5) > aimbotMaxDist then
							tbl8.lockedAimbotTarget = fn51("Aimbot")
						else
							local aimbotSmoothness = tbl3.Aimbot_Smoothness
							tbl.Camera.CFrame = tbl.Camera.CFrame:Lerp(CFrame.new(tbl.Camera.CFrame.Position, position5), aimbotSmoothness)
							local aimbotSmoothness2 = tbl3.Aimbot_Smoothness
							humanoidRootPart2.CFrame = humanoidRootPart2.CFrame:Lerp(CFrame.new(humanoidRootPart2.Position, Vector3.new(position5.X, humanoidRootPart2.Position.Y, position5.Z)), aimbotSmoothness2)
						end
					end
				else
					tbl8.lockedAimbotTarget = nil
				end
			end
		end

		local vector2 = Vector2.new(tbl.Camera.ViewportSize.X / 2, tbl.Camera.ViewportSize.Y / 2)
		local color = Color3.fromRGB(255, 255, 255)
		local flag5 = character and character:GetAttribute("spearmode") == true
		local flag6 = character and character:GetAttribute("special") == true
		local flag7 = character and character:GetAttribute("IsStunned") == true
		local aimbotRadius, visible

		if tbl3.Aimbot_Enabled and tbl3.Aimbot_ShowFOV then
			aimbotRadius = tbl3.Aimbot_Radius
			color = fn51("Aimbot") ~= nil and Color3.fromRGB(255, 0, 0)
			visible = true
			color = color or Color3.fromRGB(0, 255, 100)
		elseif tbl3.Aim_SilentVeil and tbl3.Veil_ShowFOV and flag5 then
			aimbotRadius = tbl3.Veil_FOV

			if flag6 then
				color = Color3.fromRGB(0, 255, 100)
				visible = true
			else
				color = Color3.fromRGB(150, 150, 150)
				visible = true
			end
		else
			local pistolFOVMode = tbl3.Aim_Silent and tbl3.Pistol_ShowFOV and tbl3.Pistol_FOVMode
			visible = false
			aimbotRadius = 0

			if pistolFOVMode then
				aimbotRadius = tbl3.Pistol_FOV
				color = Color3.fromRGB(255, 255, 255)
				visible = true
			end
		end

		frame3.Visible = visible

		if visible then
			frame3.Size = UDim2.new(0, aimbotRadius * 2, 0, aimbotRadius * 2)
			frame3.Position = UDim2.new(0, vector2.X, 0, vector2.Y)
			uiStroke.Color = color
		end

		if tbl8.isChargingPistol and tbl3.Aim_Silent then
			local Pistol = fn51("Pistol")

			if Pistol then
				local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftHand")
				leftArm = leftArm and leftArm.Position or character:GetPivot().Position
				local position5 = Pistol.Position
				local assemblyLinearVelocity = Pistol.AssemblyLinearVelocity
				local n4 = position5 + Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z) * (position5 - leftArm).Magnitude / 400 + Vector3.new(0, tbl3.Pistol_AimOffset, 0)

				if tbl3.Pistol_ShowLaser then
					part.Parent = workspace
					local magnitude = (n4 - leftArm).Magnitude
					part.Size = Vector3.new(0.05, 0.05, magnitude)
					part.CFrame = CFrame.new(leftArm, n4) * CFrame.new(0, 0, -magnitude / 2)
				elseif part.Parent ~= nil then
					part.Parent = nil
				end
			elseif part.Parent ~= nil then
				part.Parent = nil
			end
		elseif part.Parent ~= nil then
			part.Parent = nil
		end

		if tbl8.isChargingSpear and tbl3.Aim_SilentVeil and flag5 and not tbl6.spearSwitchCooldown and not flag7 then
			local character2 = tbl.LocalPlayer.Character
			local rightArm = character2 and (character2:FindFirstChild("Right Arm") or character2:FindFirstChild("RightHand"))
			local humanoidRootPart3 = character2 and character2:FindFirstChild("HumanoidRootPart")
			rightArm = rightArm and rightArm.Position or humanoidRootPart3 and humanoidRootPart3.Position + Vector3.new(1.5, 0.5, 0)

			if rightArm and character2 then
				local flag8 = character2:GetAttribute("special") == true
				local smartPredict = tbl3.SmartPredict
				local n4

				if smartPredict then
					n4 = flag8 and 165 or 142.5
				else
					n4 = smartPredict
				end

				n4 = n4 or tbl3.SPEAR_Speed
				local spearGravity = tbl3.SmartPredict and tbl.Workspace.Gravity * 0.5 or tbl3.SPEAR_Gravity
				local Survivor = fn51("Survivor")
				local n5, unit

				if Survivor then
					highlight.Parent = Survivor.Parent
					local humanoidRootPart4 = Survivor:IsA("Model") and Survivor:FindFirstChild("HumanoidRootPart") or Survivor
					local position5 = humanoidRootPart4.Position
					local humanoid2 = Survivor.Parent and Survivor.Parent:FindFirstChildOfClass("Humanoid")
					local n6

					if humanoid2 and humanoid2.MoveDirection.Magnitude > 0 then
						n6 = humanoid2.MoveDirection * humanoid2.WalkSpeed
					else
						n6 = Vector3.zero

						if humanoidRootPart4:IsA("BasePart") then
							n6 = humanoidRootPart4.AssemblyLinearVelocity
						end
					end

					local vector = Vector3.new(n6.X, 0, n6.Z)
					local magnitude = (position5 - rightArm).Magnitude
					local n7 = magnitude / n4

					if tbl3.SmartPredict then
						n5 = position5 + vector * n7 * tbl3.Veil_LeadMultiplier
						unit = (n5 + Vector3.new(0, 0.5 * spearGravity * n7 ^ 2 - 1.5, 0) - rightArm).Unit
					else
						n5 = position5 + vector * n7 * math.clamp(magnitude / 50, 0.1, 4)
						unit = (n5 + Vector3.new(0, 0.5 * spearGravity * n7 ^ 2 * math.clamp(magnitude / 100, 1, 2.5), 0) - rightArm).Unit
					end
				else
					highlight.Parent = nil
					unit = tbl.Camera.CFrame.LookVector
					n5 = nil
				end

				fn47(rightArm, unit, n4, spearGravity, character2, Survivor, n5)
			else
				fn46()
				highlight.Parent = nil
			end
		else
			fn46()
			highlight.Parent = nil
		end
	end)

	tbl.RunService.Stepped:Connect(function()
		if not tbl3.Misc_Noclip then
			return
		end
		local character = tbl.LocalPlayer.Character
		if not character then
			return
		end

		if character ~= tbl6.lastNoclipChar then
			table.clear(tbl6.cachedNoclipParts)

			for _, descendant in ipairs(character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					table.insert(tbl6.cachedNoclipParts, descendant)
				end
			end

			tbl6.lastNoclipChar = character
		end

		for _, cachedNoclipPart in ipairs(tbl6.cachedNoclipParts) do
			cachedNoclipPart.CanCollide = false
		end
	end)

	local atmosphere = tbl.Lighting:FindFirstChildOfClass("Atmosphere")
	local remotes2 = tbl.ReplicatedStorage:FindFirstChild("Remotes")
	local attacks = remotes2 and remotes2:FindFirstChild("Attacks")

	tbl.Lighting.ChildAdded:Connect(function(child)
		if child:IsA("Atmosphere") then
			atmosphere = child
		end
	end)

	tbl.RunService.Heartbeat:Connect(function(deltaTime)
		if tbl6.Unloaded then
			return
		end
		local character = tbl.LocalPlayer.Character
		local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")
		local now = tick()
		local v4 = fn8()
		local n4 = math.max(0.15, (tbl3.Killer_SpamHitDelay or 100) / 1000)

		if tbl3.Killer_SpamHit and now - tbl6.lastSpam >= n4 then
			tbl6.lastSpam = now

			if v4 and fn5() == "Killer" then
				local v5 = attacks:FindFirstChild(tbl3.Killer_AttackMode)
				local flag5 = false

				for _, player in pairs(tbl.Players:GetPlayers()) do
					if player ~= tbl.LocalPlayer and not fn6(player) and player.Character then
						local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
						local humanoid3 = player.Character:FindFirstChildOfClass("Humanoid")

						if not (player.Character:GetAttribute("isHooked") or player.Character:GetAttribute("IsHooked") or player.Character:GetAttribute("Hooked")) and humanoidRootPart2 and humanoid3 and humanoid3.Health > 0 then
							if (v4.Position - humanoidRootPart2.Position).Magnitude <= tbl3.Killer_SpamHitRadius then
								flag5 = true
								break
							end
						end
					end
				end

				if flag5 and v5 then
					pcall(function()
						v5:FireServer()
					end)
				end
			end
		end

		if humanoid2 then
			if tbl3.Killer_WalkSpeedToggle and tbl3.Killer_WalkSpeed > humanoid2.WalkSpeed and humanoid2.MoveDirection.Magnitude > 0 then
				character:TranslateBy(humanoid2.MoveDirection * (tbl3.Killer_WalkSpeed - humanoid2.WalkSpeed) * deltaTime)
			end

			if tbl3.Misc_HighJump then
				humanoid2.UseJumpPower = true
				humanoid2.JumpPower = tbl3.Misc_JumpPower
			end

			if tbl3.Surv_GodMode and humanoid2 then
				local flag5 = character:GetAttribute("Knocked") == true

				if flag5 or fn11(humanoid2) then
					humanoid2.Health = humanoid2.MaxHealth

					if flag5 then
						character:SetAttribute("Knocked", false)
					end
				end
			end

			if tbl3.Killer_BreakSpeed and fn5() ~= "Survivor" then
				character:SetAttribute("breakspeed", tbl3.Killer_BreakSpeed)
			end

			if character and fn5() ~= "Killer" then
				if tbl3.Surv_Perks then
					local survVaultSpeed = tbl3.Surv_VaultSpeed

					if character:GetAttribute("vaultspeed") ~= survVaultSpeed then
						character:SetAttribute("vaultspeed", tbl3.Surv_VaultSpeed)
					end

					local survSkillSpeed = tbl3.Surv_SkillSpeed

					if character:GetAttribute("skillcheckspeed") ~= survSkillSpeed then
						character:SetAttribute("skillcheckspeed", tbl3.Surv_SkillSpeed)
					end
				end

				if tbl3.Surv_FastVault then
					local flag5 = not tbl6.FlowstateOnCD

					if character:GetAttribute("Flowstate") ~= flag5 then
						character:SetAttribute("Flowstate", flag5)
					end
				elseif character:GetAttribute("Flowstate") == true then
					character:SetAttribute("Flowstate", false)
				end
			end
		end

		if tbl3.ESP_Master then
			local now2 = tick()

			if now2 - tbl6.lastUpdate > 1 then
				fn44()
				fn42()
				tbl6.lastUpdate = now2
			end
		end
	end)

	local function fn74(arg)
		if not arg then
			return
		end
		tbl6.VaultBoostActive = false
		tbl6.QuickRecoveryOnCD = false

		if tbl6.VaultBoostThread then
			task.cancel(tbl6.VaultBoostThread)
			tbl6.VaultBoostThread = nil
		end

		if tbl6.SpeedConn then
			tbl6.SpeedConn:Disconnect()
			tbl6.SpeedConn = nil
		end

		if fn5() == "Survivor" and tbl3.Surv_Perks and tbl3.Surv_Spdb then
			arg:SetAttribute("speedboost", tbl3.Surv_SpeedBoost)
		end

		tbl6.SpeedConn = arg:GetAttributeChangedSignal("speedboost"):Connect(function()
			if tbl6.Unloaded or fn5() == "Killer" then
				return
			end
			local attribute = arg:GetAttribute("speedboost") or 1
			local survSpeedBoost = tbl3.Surv_SpeedBoost or 1.1

			if tbl3.Surv_SpeedAfterVault and tbl6.VaultBoostActive then
				if attribute ~= 1.4 then
					arg:SetAttribute("speedboost", 1.4)
				end

				return
			end

			if tbl3.Surv_Perks and tbl3.Surv_Spdb then
				if attribute == 1 then
					arg:SetAttribute("speedboost", survSpeedBoost)
				elseif attribute < 1 and tbl3.Surv_NoFall then
					arg:SetAttribute("speedboost", survSpeedBoost)
				end
			end
		end)
	end

	tbl.UserInputService.JumpRequest:Connect(function()
		if tbl3.Misc_InfJump and tbl.LocalPlayer.Character then
			local humanoid2 = tbl.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid2 then
				humanoid2:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end)

	tbl.LocalPlayer.CharacterRemoving:Connect(function()
		v = nil
		humanoidRootPart = nil
		humanoid = nil
	end)

	tbl.LocalPlayer.CharacterAdded:Connect(function(character)
		fn4(character)
		fn74(character)
		fn67(character)
		fn23()
		fn39(tbl.LocalPlayer.Character)

		if connection then
			connection:Disconnect()
		end

		if connection2 then
			connection2:Disconnect()
		end

		if not tbl3.Killer_3rdPerson then
			if fn6(tbl.LocalPlayer) then
				tbl.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
				tbl.LocalPlayer.CameraMinZoomDistance = 0.5
				tbl.LocalPlayer.CameraMaxZoomDistance = 0.5
			else
				tbl.LocalPlayer.CameraMode = Enum.CameraMode.Classic
				tbl.LocalPlayer.CameraMinZoomDistance = 7
				tbl.LocalPlayer.CameraMaxZoomDistance = 128
			end
		end

		fn22()
	end)

	tbl.LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
		fn41()
		local character = tbl.LocalPlayer.Character

		if character then
			fn74(character)
			fn67(character)
		end
	end)

	if tbl.LocalPlayer.Character then
		fn4(tbl.LocalPlayer.Character)
		fn74(tbl.LocalPlayer.Character)
		fn67(tbl.LocalPlayer.Character)
		fn22()
		fn39(tbl.LocalPlayer.Character)
		fn40(tbl.LocalPlayer.Character)
	end

	fn17()
	fn19()
	fn41()

	task.spawn(function()
		local n4 = 0

		local connection4 = tbl.RunService.RenderStepped:Connect(function()
			n4 += 1
		end)

		local remotes3 = tbl.ReplicatedStorage:WaitForChild("Remotes", 5)
		remotes3 = remotes3 and remotes3:FindFirstChild("Healing")
		local healEvent = remotes3 and remotes3:FindFirstChild("HealEvent")
		local tbl19 = {}
		local n5 = 0

		while not tbl6.Unloaded do
			task.wait(1)
			local v4 = n4
			n4 = 0
			local n6 = 0

			pcall(function()
				n6 = math.round(tbl.Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
			end)

			tbl6.CurrentPing = n6 / 1000

			if textLabel then
				textLabel.Text = string.format("JEJE | %d FPS | %dms", v4, n6)

				if n6 < 80 then
					textLabel.TextColor3 = Color3.fromRGB(85, 255, 127)
				elseif n6 < 150 then
					textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
				else
					textLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
				end
			end

			fn45()
			local tbl20 = {}
			local character = tbl.LocalPlayer.Character
			local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
			local humanoid2 = character and character:FindFirstChildOfClass("Humanoid")

			if character and humanoidRootPart2 and humanoid2 then
				local flag5 = tbl3.Surv_SelfHeal and humanoid2.Health > 0 and humanoid2.Health < 99
				local flag6 = false

				if flag5 then
					pcall(function()
						if healEvent then
							healEvent:FireServer(humanoidRootPart2, true)
						end
					end)

					flag6 = true
				end

				if tbl3.Surv_AuraHeal then
					for _, player in pairs(tbl.Players:GetPlayers()) do
						if player ~= tbl.LocalPlayer and fn7(player) and player.Character then
							local humanoidRootPart3 = player.Character:FindFirstChild("HumanoidRootPart")
							local humanoid3 = player.Character:FindFirstChildOfClass("Humanoid")

							if humanoidRootPart3 and humanoid3 and humanoid3.Health > 0 and humanoid3.Health < 99 then
								if (humanoidRootPart2.Position - humanoidRootPart3.Position).Magnitude <= (tbl3.Surv_AuraHealRadius or 15) then
									tbl20[player] = humanoidRootPart3
									flag6 = true
								end
							end
						end
					end
				end

				for k, v5 in pairs(tbl19) do
					if not tbl20[k] then
						pcall(function()
							if healEvent then
								healEvent:FireServer(v5, false)
							end
						end)

						tbl19[k] = nil
					end
				end

				local n7 = 0

				for k, v5 in pairs(tbl20) do
					tbl19[k] = v5
					n7 += 1

					pcall(function()
						if healEvent then
							healEvent:FireServer(v5, true)
						end
					end)
				end

				if n7 == 0 and n5 > 0 and not flag6 then
					if humanoid2 then
						local animator = humanoid2:FindFirstChildOfClass("Animator")

						if animator then
							for _, v5 in pairs(animator:GetPlayingAnimationTracks()) do
								v5:Stop()
							end

							n5 = n7
						else
							n5 = n7
						end
					else
						n5 = n7
					end
				else
					n5 = n7
				end
			end
		end

		connection4:Disconnect()
	end)

	task.spawn(function()
		local remotes3 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10)
		remotes3 = remotes3 and remotes3:FindFirstChild("Mapinfo", true)

		if remotes3 and remotes3:IsA("RemoteEvent") then
			remotes3.OnClientEvent:Connect(function(arg)
				if arg and tbl3.Next_Map then
					pcall(function()
						if lib2 then
							fn2("Next Map: " .. tostring(arg), 10, 18595195017)
						end
					end)
				end
			end)
		end
	end)
end

task.spawn(function()
	while not tbl6.Unloaded do
		task.wait(1)

		for _, player in ipairs(tbl.Players:GetPlayers()) do
			local character = player.Character

			if player ~= tbl.LocalPlayer and fn6(player) and character then
				if not character:GetAttribute("StunEventAdded") then
					character:SetAttribute("StunEventAdded", true)

					character:GetAttributeChangedSignal("IsStunned"):Connect(function()
						if not tbl3.Show_Stun or tbl6.Unloaded then
							return
						end
						local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

						if character:GetAttribute("IsStunned") then
							if humanoidRootPart2 and not character:FindFirstChild("StunIn") then
								local sound = Instance.new("Sound", humanoidRootPart2)
								sound.Name = "StunHitSound"
								sound.Volume = 5
								sound.SoundId = "rbxassetid://140209514807090"
								sound:Play()

								sound.Ended:Connect(function()
									sound:Destroy()
								end)

								fn43(character, "StunIn", { name = "stunned", color = Color3.fromRGB(255, 255, 0), offsetY = 5.5 })
							end
						else
							if character:FindFirstChild("StunIn") then
								character.StunIn:Destroy()
							end

							if humanoidRootPart2 and humanoidRootPart2:FindFirstChild("StunHitSound") then
								humanoidRootPart2.StunHitSound:Destroy()
							end
						end
					end)
				end
			end
		end
	end
end)

task.spawn(function()
	local ok, result = pcall(function()
		return require(tbl.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Survivors"):WaitForChild("SurvivorAnimationsController"))
	end)

	if not ok or not result then
		return
	end
	local isFacingStraightEnough = result._isFacingStraightEnough

	result._isFacingStraightEnough = function(arg, arg2, arg3, arg4)
		if tbl3.Surv_PerfectVault then
			arg.characterspeed = 20
			return true, 0
		end
		return isFacingStraightEnough(arg, arg2, arg3, arg4)
	end

	local onVaultAnimation = result._onVaultAnimation

	result._onVaultAnimation = function(arg, arg2, arg3)
		if tbl3.Surv_PerfectVault then
			return onVaultAnimation(arg, arg2, true)
		end
		return onVaultAnimation(arg, arg2, arg3)
	end

	local onSkillCheckFail = result._onSkillCheckFail

	result._onSkillCheckFail = function(arg, arg2, arg3)
		local v3 = onSkillCheckFail(arg, arg2, arg3)

		if tbl3.Surv_NoFall then
			arg.cantupdatespeed = false

			if arg.humanoidRootPart then
				arg.humanoidRootPart.Anchored = false
			end
		end

		return v3
	end
end)
