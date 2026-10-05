
local function demo()
	return 0
end

cleanupResources = function(thread, result77)
	if typeof(thread) == "RBXScriptConnection" then
		thread:Disconnect()
	elseif type(thread) == "thread" and coroutine.status(thread) ~= "dead" then
		task.cancel(thread)
	else
		if type(thread) == "table" then
			result77 = result77 or {}
			if result77[thread] then
				return
			end
			result77[thread] = true

			for _, encodedString in pairs(thread) do
				cleanupResources(encodedString, result77)
			end
		end
	end
end

callWithRestoredThreadIdentity = function(line, ...)
	if type(line) == "function" then
		local knob = getthreadidentity()
		local packed = table.pack(...)
		pcall(line, table.unpack(packed, 1, packed.n))
		setthreadidentity(knob)
	end
end

do
	local function mergeTables(line)
		local sourceTable = line or {}

		for vertex, innerValue in pairs(sourceTable) do
			pcall(function()
					for neighbor, encodedString in pairs(innerValue) do
						vertex[neighbor] = encodedString
					end
				end)
		end
	end

	globalEnvironment = getgenv()
	scriptKey = script_key or globalEnvironment.script_key
	local result4 = globalEnvironment.FlyteBB_State
	local effect = globalEnvironment.FlyteBB

	if type(result4) == "table" then
		callWithRestoredThreadIdentity(result4.Unload)
	end

	if type(effect) == "table" then
		callWithRestoredThreadIdentity(effect.Destroy, effect)
	end

	if type(result4) == "table" and not result4.Unloaded then
		do
			result4.Unloading = true
			result4.Loaded = false
			callWithRestoredThreadIdentity(result4.StreakRestore or result4.Streak_Restore)
			callWithRestoredThreadIdentity(result4.AntiLagRestore)
			callWithRestoredThreadIdentity(result4.NoRenderRestore)
			mergeTables(result4.AntiLagCache)
			mergeTables(result4.RenderCache)
			result4.AntiLagCache = nil
			result4.RenderCache = nil
			callWithRestoredThreadIdentity(cleanupResources, result4)

			do
				local iteratorFunction = result4.ESPLabels or result4.ESP_Labels or result4.Esp_Labels or {}

				for _, innerValue in pairs(iteratorFunction) do
					if innerValue.Billboard then
						pcall(function()
								innerValue.Billboard:Destroy()
							end)
					end
				end
			end
		end

		for _, innerValue in pairs({
			"KeybindPanel",
			"StatsPanel",
			nil,
			"TriggerPanel",
			nil,
			"Spam_Panel",
			"Trigger_Panel",
		}) do
			do
				local currentDate = result4[innerValue]

				if type(currentDate) == "table" and typeof(currentDate.Gui) == "Instance" then
					pcall(function()
							currentDate.Gui:Destroy()
						end)
				end
			end
		end

		do
			local lineIterator = result4.ExtraStats or {}

			for _, innerValue in pairs(lineIterator) do
				local top = type(innerValue) == "table"
				local cell

				if top then
					cell = typeof(innerValue.Gui) == "Instance"
				else
					cell = top
				end

				if cell then
					pcall(function()
							innerValue.Gui:Destroy()
						end)
				end
			end
		end

		result4.Unloaded = true
	end

	if type(effect) == "table" and typeof(effect.screenGuiYay) == "Instance" then
		pcall(function()
				effect.screenGuiYay:Destroy()
			end)
	end

	if globalEnvironment.FlyteBB == effect then
		globalEnvironment.FlyteBB = nil
	end

	if globalEnvironment.FlyteBB_State == result4 then
		globalEnvironment.FlyteBB_State = nil
	end
end

do
	local result52

	do
		local wrapper = cloneref or function(line)
			return line
		end

		tweenService = wrapper(game:GetService("TweenService"))
		userInputService = wrapper(game:GetService("UserInputService"))
		runService = wrapper(game:GetService("RunService"))
		playersService = wrapper(game:GetService("Players"))
		textService = wrapper(game:GetService("TextService"))
		guiService = wrapper(game:GetService("GuiService"))
		httpService = wrapper(game:GetService("HttpService"))
		contentProvider = wrapper(game:GetService("ContentProvider"))
		replicatedStorage = wrapper(game:GetService("ReplicatedStorage"))
		coreGui = wrapper(game:GetService("CoreGui"))
		result52 = wrapper(game:GetService("Stats"))
		teleportService = wrapper(game:GetService("TeleportService"))
	end

	do
		local function mainLoop(line)
			for _, encodedString in line:GetChildren() do
				if encodedString.Name == "v0rtexdBestUIEver" and encodedString:IsA("ScreenGui") then
					encodedString:Destroy()
				end
			end
		end

		if gethui then
			local decoded, loadError = pcall(gethui)

			if decoded then
				callWithRestoredThreadIdentity(mainLoop, loadError)
			end
		end

		callWithRestoredThreadIdentity(mainLoop, coreGui)
	end

	local functionReference = nil
	latestPingMs = nil
	refreshDataPing = function()if not  functionReference or not  functionReference .Parent then local i= result52 :FindFirstChild("Network");local y=i and(i:FindFirstChild("ServerStatsItem")); functionReference =y and(y:FindFirstChild("Data Ping"));end;if  functionReference then local i,y=pcall( functionReference .GetValue, functionReference );local currentLength=i and type(y)=="number"and y>0 and y==y and y<math.huge;if currentLength then  latestPingMs =y;end;end;end
end

do
	do
		do
			local knob = assert
			local top = type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function" and type(makefolder) == "function" and type(isfolder) == "function"

			if top then
				top = type(listfiles) == "function"
			end

			if top then
				top = type(delfile) == "function"
			end

			knob(top, "filesystem is not supported")
		end

		flyteBBState = nil
		configManager = nil
		unloadScript = nil
		configData = {}
		flags = nil

		configSections = {
			"Toggles",
			"Sliders",
			"DoubleSliders",
			"Dropdowns",
			"Textboxes",
			"Keybinds",
			"UnlockAll",
		}

		do
			local sourceTable = {
				nil,
				nil,
				"Cooldown_Protection",
				"Parry_On_Dribble",
				nil,
				"Anti_Blindness",
				"Anti_Phantom",
				"Anti_Curve",
				"Dynamic_Spam",
				"Manual_Spam",
				"Auto_Preclick",
				nil,
				"Auto_Parry",
				"Auto_Spam",
				nil,
				"Auto_Rejoin",
				"Auto_Vote",
				"Death_Slash",
				"Time_Hole",
				"No_Render",
				"Anti_Lag",
				"Custom_FFlags",
				"Ability_ESP",
				"Device_Spoof",
				"Mobile_Button",
				nil,
				"Ball_Stats",
				"Unlock_All",
				"Custom_Streak",
				"Hit_Freeze",
				nil,
				"Anti_AFK",
				"Anim_Fix",
				"Config_List",
				nil,
			}

			normalizeConfigKey = function(line)
				if type(line) ~= "string" then
					return line
				end

				for _, encodedString in pairs(sourceTable) do
					line = line:gsub(encodedString, encodedString == "Anti_Curve" and "Anticurve" or encodedString:gsub("_", ""))
				end

				return line
			end
		end
	end

	do
		migrateConfigData = function(line)
			for _, innerValue in pairs(configSections) do
				local currentDate = line[innerValue]

				if type(currentDate) == "table" then
					local sourceTable = {}

					for vertex in pairs(currentDate) do
						local packed = normalizeConfigKey(vertex)

						if packed ~= vertex then
							sourceTable[vertex] = packed
						end
					end

					for vertex, id in pairs(sourceTable) do
						if currentDate[id] == nil then
							currentDate[id] = currentDate[vertex]
						end

						currentDate[vertex] = nil
					end
				end
			end

			local result60 = line.Toggles

			if type(result60) == "table" then
				for vertex, innerValue in pairs({
					Claim_Daily_Gifts = "Claim_Daily_Rewards",
					Claim_Welcome_Rewards = "Claim_Daily_Rewards",
					Claim_Playtime_Gifts = "Claim_Playtime_Rewards",
				}) do
					for _, encodedString in pairs({ "", ":notify" }) do
						if result60[vertex .. encodedString] ~= nil then
							result60[innerValue .. encodedString] = result60[innerValue .. encodedString] == true or result60[vertex .. encodedString] == true
							result60[vertex .. encodedString] = nil
						end
					end
				end
			end

			return line
		end

		do
			local sourceTable = {
				AutoParry_Type = true,
				AutoSpam_Type = true,
				ManualSpam_Type = true,
				Triggerbot_Type = true,
				Fury_Parry_Method = true,
			}

			configFileStore = {
				Writing = {},
				Pending = {},
				Read = function(line)
					if not isfile(line) then
						return
					end
					local knob = readfile(line)
					local decoded, loadError = pcall(httpService.JSONDecode, httpService, knob)
					if decoded and type(loadError) == "table" then
						return loadError
					end
				end,
				Write = function(line, object)
					configFileStore.Pending[line] = httpService:JSONEncode(object)
					if configFileStore.Writing[line] then
						return
					end
					configFileStore.Writing[line] = true

					while true do
						local knob = configFileStore.Pending[line]
						configFileStore.Pending[line] = nil
						local decoded, loadError = pcall(writefile, line, knob)

						if not decoded then
							configFileStore.Writing[line] = nil
							error(loadError)
						end

						if configFileStore.Pending[line] ~= nil then
							continue
						end
						break
					end

					configFileStore.Writing[line] = nil
				end,
			}

			deepCopy = nil

			deepCopy = function(line)
				if type(line) ~= "table" then
					return line
				end
				local players = {}

				for vertex, innerValue in pairs(line) do
					players[vertex] = deepCopy(innerValue)
				end

				return players
			end

			saveConfig = function()
				if not flyteBBState or not flyteBBState.Loaded or flyteBBState.Unloading or configManager and configManager.Applying then
					return
				end

				if not isfolder("Flyte") then
					makefolder("Flyte")
				end

				configFileStore.Write("Flyte/Flyte.json", configData)

				if configManager and configManager.Active and configManager.Save then
					configManager:Save(configManager.Active, false)
				end
			end

			if isfile("Flyte/Flyte.json.backup") then
				pcall(delfile, "Flyte/Flyte.json.backup")
			end

			configData = configFileStore.Read("Flyte/Flyte.json") or configData

			for _, innerValue in pairs(configSections) do
				configData[innerValue] = type(configData[innerValue]) == "table" and configData[innerValue] or {}
			end

			migrateConfigData(configData)

			for _, innerValue in pairs({ "ManualSpam", "manual_spam_enabled" }) do
				configData.Toggles[innerValue] = nil
			end

			normalizeKeyInputTypes = function(line)
				for vertex, innerValue in pairs(line) do
					local top = innerValue == "Keypress"

					if not top then
						top = sourceTable[vertex] and innerValue ~= "Remote" and innerValue ~= nil and innerValue ~= nil
					end

					if top then
						line[vertex] = "VIM"
					end
				end
			end
		end
	end

	normalizeKeyInputTypes(configData.Dropdowns)

	if next(configData.Keybinds) == nil and isfile("FlyteBB_Keybinds.json") then
		local jsonString = configFileStore.Read("FlyteBB_Keybinds.json")

		if type(jsonString) == "table" then
			configData.Keybinds = jsonString
		end
	end

	do
		local sourceTable = {}

		fontCache = { new = function(line, object, descendant)
				local knob = "_"
				local query = tostring(line) .. knob .. tostring(object) .. "_" .. tostring(descendant)
				local currentDate = sourceTable[query]

				if not currentDate then
					local decoded, loadError = pcall(function()
						return Font.new(line, object, descendant)
					end)

					if not decoded or not loadError then
						decoded, loadError = pcall(function()
							return Font.fromEnum(Enum.Font.GothamSemibold)
						end)
					end

					if not decoded or not loadError then
						error(loadError or "Font constructors are unavailable in this runtime", 2)
					end
					currentDate = loadError
					sourceTable[query] = currentDate
				end

				return currentDate
			end }
	end
end

do
	local result18, sourceTable, players, result9, knob, currentDate, packed, index25

	do
		result18 = configData.Keybinds
		sourceTable = {}
		players = {}
		result9 = {}

		do
			local index43 = 0
			knob = nil
			currentDate = nil
			packed = nil

			local function binarySearch(line)
				if line == "MouseButton3" then
					return Enum.UserInputType.MouseButton3
				end
				return type(line) == "string" and Enum.KeyCode[line] or Enum.KeyCode.Unknown
			end

			index25 = function(line)
				if line.UserInputType == Enum.UserInputType.Keyboard then
					return line.KeyCode
				end

				if line.UserInputType == Enum.UserInputType.MouseButton3 then
					return line.UserInputType
				end
			end

			keybindRegistry = {
				Resolve = function(line)
					return binarySearch(line)
				end,
				Display = function(line)
					return line == Enum.UserInputType.MouseButton3 and "M3" or line.Name
				end,
				Get = function(line)
					local radians = result18[line]
					return binarySearch(type(radians) == "table" and radians.Key or radians)
				end,
				Set = function(line, object)
					if not object or object == Enum.KeyCode.Unknown then
						if type(n24) == "number" and nil <= n24 then
							while true do
							end
						else
							result18[line] = nil
						end
					else
						result18[line] = { Key = object.Name, Mode = keybindRegistry.GetMode(line) }
					end

					saveConfig()

					if result9[line] then
						result9[line](keybindRegistry.Get(line))
					end

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end
				end,
				GetMode = function(line)
					local radians = result18[line]
					if type(radians) == "table" and (radians.Mode == "Toggle" or radians.Mode == "Hold") then
						return radians.Mode
					end
					return "Toggle"
				end,
				SetMode = function(line, object)
					local radians = keybindRegistry.Get(line)

					if radians == Enum.KeyCode.Unknown then
						result18[line] = { Mode = object }
					else
						result18[line] = { Key = radians.Name, Mode = object }
					end

					saveConfig()

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end
				end,
				SetMeta = function(line, object)
					local radians = players[line]

					if radians and radians.Order then
						object.Order = radians.Order
					else
						index43 += 1
						object.Order = index43
					end

					players[line] = object

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end
				end,
				RegisterDisplay = function(line, object)
					result9[line] = object
				end,
				GetAll = function()
					local sorted = {}
					local neighbors = {}

					for _, particle in pairs(players) do
						if not particle.Parent then
							neighbors[string.lower(particle.Name or "")] = particle.Order or 9999
						end
					end

					for vertex, particle in pairs(players) do
						local angleRadians = keybindRegistry.Get(vertex)

						if angleRadians ~= Enum.KeyCode.Unknown then
							local track = nil

							if particle.GetState then
								track = particle.GetState()
							end

							table.insert(sorted, {
							Id = vertex,
							Name = particle.Name or vertex,
							Key = keybindRegistry.Display(angleRadians),
							Mode = particle.DisplayMode or keybindRegistry.GetMode(vertex),
							Group = particle.Group,
							Parent = particle.Parent,
							Order = particle.Order or 9999,
							ParentOrder = particle.Parent and neighbors[string.lower(particle.Parent)] or particle.Order or 9999,
							Active = track,
						})
						end
					end

					table.sort(sorted, function(line, object)
						if line.ParentOrder ~= object.ParentOrder then
							return line.ParentOrder < object.ParentOrder
						end

						if line.Parent ~= nil ~= object.Parent ~= nil then
							return line.Parent == nil
						end

						if line.Parent and object.Parent and line.Active ~= object.Active then
							return line.Active == true
						end
						return line.Order < object.Order
					end)

					return sorted
				end,
				FindDuplicate = function(line, object, descendant)
					if not line or not descendant or descendant == Enum.KeyCode.Unknown then
						return nil
					end
					local targetPlayerName = descendant.Name

					for vertex, particle in pairs(players) do
						if vertex ~= object and particle.Group == line then
							local angleRadians = result18[vertex]
							if (type(angleRadians) == "table" and angleRadians.Key or angleRadians) == targetPlayerName then
								return particle.Name
							end
						end
					end

					return nil
				end,
				Register = function(line, object)
					sourceTable[line] = object
				end,
				BeginListen = function(line, object, descendant)
					knob = line
					currentDate = object
					packed = descendant
				end,
				IsListening = function()
					return knob ~= nil
				end,
			}
		end
	end

	local connection = userInputService.InputBegan:Connect(function(inputObject, vectorB)
			local adjustLightingBasedOnSpin = index25(inputObject)
			if not adjustLightingBasedOnSpin then
				return
			end

			if knob then
				local radians = knob
				local angleRadians = currentDate
				local track = packed
				knob = nil
				currentDate = nil
				packed = nil
				if adjustLightingBasedOnSpin == Enum.KeyCode.Unknown then
					return
				end

				if adjustLightingBasedOnSpin == Enum.KeyCode.Escape then
					if angleRadians then
						angleRadians(keybindRegistry.Get(radians))
					end

					return
				end

				if adjustLightingBasedOnSpin == Enum.KeyCode.Backspace then
					adjustLightingBasedOnSpin = Enum.KeyCode.Unknown
				end

				if track and adjustLightingBasedOnSpin ~= Enum.KeyCode.Unknown and track(adjustLightingBasedOnSpin) == false then
					if angleRadians then
						angleRadians(keybindRegistry.Get(radians))
					end

					return
				end

				keybindRegistry.Set(radians, adjustLightingBasedOnSpin)

				if angleRadians then
					angleRadians(adjustLightingBasedOnSpin)
				end

				return
			end

			if vectorB then
				return
			end
			local targetPlayerName = adjustLightingBasedOnSpin.Name

			for vertex, particle in pairs(sourceTable) do
				local angleRadians = result18[vertex]

				if (type(angleRadians) == "table" and angleRadians.Key or angleRadians) == targetPlayerName then
					task.spawn(particle, true, keybindRegistry.GetMode(vertex), adjustLightingBasedOnSpin)
				end
			end
		end)

	local heartbeatConnection = userInputService.InputEnded:Connect(function(inputObject, vectorB)
			if vectorB then
				return
			end
			local radians = index25(inputObject)
			if not radians then
				return
			end
			local targetPlayerName = radians.Name

			for vertex, existingPlayer in pairs(sourceTable) do
				local track = result18[vertex]

				if (type(track) == "table" and track.Key or track) == targetPlayerName and keybindRegistry.GetMode(vertex) == "Hold" then
					task.spawn(existingPlayer, false, "Hold", radians)
				end
			end
		end)

	keybindRegistry.Destroy = function()
		if connection then
			connection:Disconnect()
			connection = nil
		end

		if heartbeatConnection then
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
		end

		sourceTable = {}
		players = {}
		result9 = {}
		knob = nil
		currentDate = nil
		packed = nil
	end
end

do
	do
		setfpscap(9999)
		uiLibrary = {}
		uiLibrary.__index = uiLibrary

		colors = {
			Primary = Color3.fromRGB(12, 12, 15),
			Secondary = Color3.fromRGB(18, 18, 24),
			Tertiary = Color3.fromRGB(26, 28, 34),
			Surface = Color3.fromRGB(32, 32, 39),
			Element = Color3.fromRGB(42, 42, 50),
			ElementHover = Color3.fromRGB(55, 55, 70),
			Border = Color3.fromRGB(55, 55, 70),
			BorderSoft = Color3.fromRGB(45, 45, 58),
			Accent = Color3.fromRGB(132, 85, 247),
			AccentDark = Color3.fromRGB(108, 63, 205),
			AccentLight = Color3.fromRGB(188, 155, 255),
			Text = Color3.fromRGB(240, 240, 245),
			SubText = Color3.fromRGB(155, 155, 180),
			TextHover = Color3.fromRGB(225, 225, 240),
			Muted = Color3.fromRGB(105, 105, 123),
			White = Color3.new(1, 1, 1),
			Black = Color3.new(),
			Success = Color3.fromRGB(126, 238, 174),
			Warning = Color3.fromRGB(255, 197, 117),
			Error = Color3.fromRGB(255, 116, 145),
		}

		uiLibrary.Colors = colors

		if not game:IsLoaded() then
			game.Loaded:Wait()
		end

		while not playersService.LocalPlayer do
			task.wait()
		end

		localPlayer = playersService.LocalPlayer
		touchEnabled = userInputService.TouchEnabled

		createInstance = function(payload, originalTable)
			local container = Instance.new(payload)

			for vertex, innerValue in pairs(originalTable) do
				if vertex ~= "Parent" then
					container[vertex] = innerValue
				end
			end

			if originalTable.Parent then
				container.Parent = originalTable.Parent
			end

			return container
		end

		parentGui = function(action)
			if gethui then
				local decoded, checkpointFolder = pcall(gethui)

				if decoded and typeof(checkpointFolder) == "Instance" then
					if pcall(function()
							action.Parent = checkpointFolder
						end) then
						return action
					end
				end
			end

			local callable = syn and syn.protect_gui

			if callable then
				pcall(callable, action)
			end

			if protectgui and protectgui ~= callable then
				pcall(protectgui, action)
			end

			action.Parent = coreGui
			return action
		end

		safeIndex = function(line, object, descendant)
			if descendant then
				return nil
			end
			return line[object]
		end

		do
			local sourceTable = {}

			tweenInstance = function(delaySeconds, goal, deferrals, newValue, blue)
				deferrals = deferrals or 0.5
				newValue = newValue or Enum.EasingStyle.Exponential
				local currency = blue or Enum.EasingDirection.Out
				local query = string.format("%f_%d_%d", deferrals, newValue.Value, currency.Value)
				local propertyTable = sourceTable[query]

				if not propertyTable then
					propertyTable = TweenInfo.new(deferrals, newValue, currency)
					sourceTable[query] = propertyTable
				end

				local topTween = tweenService:Create(delaySeconds, propertyTable, goal)
				topTween:Play()
				return topTween
			end
		end
	end

	do
		local index32

		do
			local propertyTable = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			trackedConnections = {}

			trackConnection = function(target)
				trackedConnections[target] = true
				return target
			end

			disconnectTrackedConnection = function(line)
				if line then
					line:Disconnect()
					trackedConnections[line] = nil
				end
			end

			playerAddedHook = nil

			trackConnection(userInputService.InputChanged:Connect(function(inputObject)
					if playerAddedHook then
						playerAddedHook(inputObject)
					end
				end))

			index32 = function(intervalSeconds, entityIdentifier)
				local top = false
				local knob = nil
				local currentPosition = nil
				local rayOrigin = nil
				local topTween = nil
				local currentDate = entityIdentifier or intervalSeconds

				local function onInputBegan(descendant)
					if not descendant or not descendant.Position or not currentPosition or not rayOrigin then
						return
					end

					local elapsedTime = descendant.Position - currentPosition
					local targetSize = UDim2.new(rayOrigin.X.Scale, rayOrigin.X.Offset + elapsedTime.X, rayOrigin.Y.Scale, rayOrigin.Y.Offset + elapsedTime.Y)

					if topTween then
						topTween:Cancel()
					end

					topTween = tweenService:Create(intervalSeconds, propertyTable, { Position = targetSize })
					topTween:Play()
				end

				local function handlePlayerAdded(descendant)
					if descendant == knob and top then
						onInputBegan(descendant)
					end
				end

				currentDate.InputBegan:Connect(function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
							top = true
							currentPosition = inputObject.Position
							rayOrigin = intervalSeconds.Position

							inputObject.Changed:Connect(function()
								if inputObject.UserInputState == Enum.UserInputState.End then
									top = false

									if playerAddedHook == handlePlayerAdded then
										playerAddedHook = nil
									end
								end
							end)

							playerAddedHook = handlePlayerAdded
						end
					end)

				currentDate.InputChanged:Connect(function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch then
							knob = inputObject
						end
					end)
			end
		end

		makeDraggable = index32

		do
			local function generateRandomArray(line)
				local decoded, loadError = pcall(playersService.GetUserThumbnailAsync, playersService, line, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				if decoded then
					return loadError
				end
				return "rbxassetid://135756197673563"
			end

			measureTextWidth = function(line, object, descendant)
				local cacheKey = tostring(line or "")
				local ammunitionText = tonumber(object) or 14
				local TOOLTIP_FONT = descendant or Enum.Font.GothamSemibold
				return textService:GetTextSize(cacheKey, ammunitionText, TOOLTIP_FONT, Vector2.new(math.huge, math.huge)).X
			end

			truncateTextToWidth = function(line, object, descendant, radius)
				if measureTextWidth(line, descendant, radius) <= object then
					return line
				end
				local elapsedTime = 1
				local difference = #line
				local query = ""

				while elapsedTime <= difference do
					local openError = math.floor((elapsedTime + difference) / 2)
					local concatenated = line:sub(1, openError) .. "..."

					if measureTextWidth(concatenated, descendant, radius) <= object then
						elapsedTime = openError + 1
						query = concatenated
					else
						difference = openError - 1
					end
				end

				return query ~= "" and query or "..."
			end

			uiLibrary.new = function(comparator)
				local managerObject = setmetatable({}, uiLibrary)
				managerObject.config = comparator or {}
				managerObject.config.Name = managerObject.config.Name or "o11 vision"
				managerObject.config.Colors = managerObject.config.Colors or colors
				managerObject.config.AccentColor = managerObject.config.AccentColor or managerObject.config.Colors.Accent
				managerObject.config.BackgroundColor = managerObject.config.BackgroundColor or managerObject.config.Colors.Primary
				managerObject.config.SecondaryColor = managerObject.config.SecondaryColor or managerObject.config.Colors.Secondary
				managerObject.config.TextColor = managerObject.config.TextColor or managerObject.config.Colors.Text
				managerObject.config.SubTextColor = managerObject.config.SubTextColor or managerObject.config.Colors.SubText
				managerObject.sectionsAreAwesome = {}
				managerObject.tabsGoWoosh = {}
				managerObject.currentTabYay = nil
				managerObject.notificationsAreCool = {}
				managerObject.isToggledOn = true
				managerObject.dropdownHolderRef = nil
				managerObject.dropdownHolderScale = nil
				managerObject.sectionRefreshers = {}
				managerObject.openDropdowns = {}
				managerObject.dropdownFrames = {}
				managerObject.detachedDropdowns = {}
				managerObject:CreateUIBecauseWeNeedIt()
				return managerObject
			end

			uiLibrary.CreateUIBecauseWeNeedIt = function(line)
				line.screenGuiYay = createInstance("ScreenGui", { Name = "v0rtexdBestUIEver", ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false })
				parentGui(line.screenGuiYay)

				line.dropdownHolderRef = createInstance("Frame", {
					Name = "DropdownHolderBecauseDropdownsNeedHomes",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 100,
					Parent = line.screenGuiYay,
				})

				line.dropdownHolderScale = createInstance("UIScale", { Name = "DropdownHolderScale", Scale = 1, Parent = line.dropdownHolderRef })
				line:CreateWatermarkBecauseWeCool()
				line:CreateMainFrameYay()
				line:UpdateLayoutScale()

				line.screenGuiYay:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						line:UpdateLayoutScale()
					end)

				line:CreateNotificationHolderForCoolNotifs()

				task.delay(0.1, function()
						line:SetVisible(true)
					end)

				local result44 = configData.Keybinds and configData.Keybinds["settings:menu settings:toggle keybind"]
				local result59 = result44 and type(result44) == "string" and Enum.KeyCode[result44] or Enum.KeyCode.RightAlt
				if result59 == nil or result59 == Enum.KeyCode.Unknown then
					result59 = Enum.KeyCode.RightAlt
				end
				line.toggleVisibilityKey = result59
				line.toggleVisibilityKeyName = result59 and result59 ~= Enum.KeyCode.Unknown and result59.Name or "None"

				trackConnection(userInputService.InputBegan:Connect(function(inputObject, vectorB)
						local knob = nil
						local numberValue = tonumber(knob)

						if type(n28) ~= "function" or numberValue == nil or n28(897) < numberValue then
							if vectorB then
								return
							end
							local isUnderwater = line.lastKeybindChanged

							if isUnderwater then
								local index29 = line.lastKeybindChanged
								isUnderwater = tick() - index29 < 0.1
							end

							if isUnderwater then
								return
							end

							if keybindRegistry.IsListening and keybindRegistry.IsListening() then
								return
							end

							if inputObject.KeyCode == line.toggleVisibilityKey then
								line:SetVisible(not line.isToggledOn)
							end

							return
						end
					end))

				if touchEnabled then
					local knob = createInstance("TextButton", {
						Name = "MobileToggle",
						Size = UDim2.new(0, 46, 0, 46),
						Position = UDim2.new(0, 38, 1, -80),
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(24, 24, 28),
						BackgroundTransparency = 0.2,
						Text = "",
						AutoButtonColor = false,
						ClipsDescendants = false,
						Visible = true,
						ZIndex = 99999,
						Parent = line.screenGuiYay,
					})

					line.mobileToggleScale = createInstance("UIScale", { Scale = (flags.MobileButtonScale or 100) / 100, Parent = knob })
					createInstance("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })

					local j = createInstance("UIStroke", {
						Thickness = 1.5,
						Color = colors.Accent,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 1,
						Parent = knob,
					})

					local playerId = createInstance("ImageLabel", {
						Name = "OpenIcon",
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = "rbxassetid://136585806825349",
						ImageColor3 = colors.Accent,
						ZIndex = 100000,
						Parent = knob,
					})

					local name = createInstance("UIScale", { Scale = 1, Parent = playerId })

					local frame = createInstance("ImageLabel", {
						Name = "ClosedIcon",
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = "rbxassetid://127131703650472",
						ImageColor3 = colors.Accent,
						ImageTransparency = 1,
						Rotation = 180,
						Visible = false,
						ZIndex = 15,
						Parent = knob,
					})

					local input = createInstance("UIScale", { Scale = 0, Parent = frame })

					local function handlePlayerAdded(object)
						if line.isToggledOn then
							playerId.Visible = true

							if object then
								tweenInstance(j, { Color = colors.Accent }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(playerId, { ImageTransparency = 0, Rotation = 0 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(name, { Scale = 1 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(frame, { ImageTransparency = 1, Rotation = 180 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(input, { Scale = 0 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							else
								j.Color = colors.Accent
								playerId.ImageTransparency = 0
								playerId.Rotation = 0
								name.Scale = 1
								frame.ImageTransparency = 1
								frame.Rotation = 180
								input.Scale = 0
								frame.Visible = false
							end
						else
							frame.Visible = true

							if object then
								tweenInstance(j, { Color = Color3.fromRGB(45, 47, 55) }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(playerId, { ImageTransparency = 1, Rotation = 180 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

								tweenInstance(name, { Scale = 0 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out).Completed:Connect(function()
										if not line.isToggledOn then
											playerId.Visible = false
										end
									end)

								tweenInstance(frame, { ImageTransparency = 0, Rotation = 0 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
								tweenInstance(input, { Scale = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							else
								j.Color = Color3.fromRGB(45, 47, 55)
								playerId.ImageTransparency = 1
								playerId.Rotation = 180
								name.Scale = 0
								playerId.Visible = false
								frame.ImageTransparency = 0
								frame.Rotation = 0
								input.Scale = 1
							end
						end
					end

					knob.MouseEnter:Connect(function()
							tweenInstance(knob, { BackgroundColor3 = Color3.fromRGB(30, 30, 35) }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							tweenInstance(j, { Transparency = 0.001 }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						end)

					knob.MouseLeave:Connect(function()
							tweenInstance(knob, { BackgroundColor3 = Color3.fromRGB(24, 24, 28) }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							tweenInstance(j, { Transparency = 0.3 }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						end)

					local top = false
					local currentPosition = nil
					local rayOrigin = nil
					local cell = false
					local currentDate = nil

					knob.InputBegan:Connect(function(inputObject)
							if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
								top = true
								cell = false
								currentPosition = inputObject.Position
								rayOrigin = knob.Position

								inputObject.Changed:Connect(function()
									if inputObject.UserInputState == Enum.UserInputState.End then
										top = false
									end
								end)
							end
						end)

					knob.InputChanged:Connect(function(inputObject)
							if inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch then
								currentDate = inputObject
							end
						end)

					trackConnection(userInputService.InputChanged:Connect(function(inputObject)
							if inputObject == currentDate and top then
								local elapsedTime = inputObject.Position - currentPosition

								if elapsedTime.Magnitude > 12 then
									cell = true
								end

								local screenSize = line.screenGuiYay.AbsoluteSize

								if screenSize.X > 0 and screenSize.Y > 0 then
									local delta = knob.AbsoluteSize
									local difference = delta.X > 0 and delta.X / 2 or 23
									local openError = delta.Y > 0 and delta.Y / 2 or 23
									local step = math.clamp(rayOrigin.X.Scale * screenSize.X + rayOrigin.X.Offset + elapsedTime.X, difference, screenSize.X - difference)
									local mathMax = math.clamp(rayOrigin.Y.Scale * screenSize.Y + rayOrigin.Y.Offset + elapsedTime.Y, openError, screenSize.Y - openError)
									knob.Position = UDim2.new(0, step, 0, mathMax)
								end
							end
						end))

					knob.InputEnded:Connect(function(inputObject)
							if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
								if top then
									top = false
								end

								if not cell then
									tweenInstance(knob, { Size = UDim2.new(0, 42, 0, 42) }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

									task.delay(0.1, function()
										tweenInstance(knob, { Size = UDim2.new(0, 46, 0, 42) }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									end)

									line:SetVisible(not line.isToggledOn)
									handlePlayerAdded(true)
								end
							end
						end)

					local success8 = line.SetVisible

					line.SetVisible = function(object, descendant)
						success8(object, descendant)
						handlePlayerAdded(true)
					end

					handlePlayerAdded(false)
				end
			end

			uiLibrary.GetScreenScale = function(line)
				if not line.screenGuiYay then
					return 1
				end
				local Camera = workspace.CurrentCamera
				local mouseLocation = line.screenGuiYay.AbsoluteSize
				local viewportSize = Camera and Camera.ViewportSize or mouseLocation
				local maxLength = math.max(mouseLocation.X, viewportSize.X)
				local cellScore = math.max(mouseLocation.Y, viewportSize.Y)
				if maxLength <= 0 or cellScore <= 0 then
					return 1
				end
				local MAX_ITERATIONS = tonumber(flags.MenuScale) or 100

				if MAX_ITERATIONS < 50 or MAX_ITERATIONS > 150 then
					MAX_ITERATIONS = 100
					flags.MenuScale = MAX_ITERATIONS
				end

				local intensity = touchEnabled and 0.1 or 1
				local clamped = math.clamp(math.min((maxLength - 40) / 753, (cellScore - 40) / 493), intensity, 1)
				return math.clamp(clamped * MAX_ITERATIONS / 100, intensity, 1.5)
			end

			uiLibrary.UpdateLayoutScale = function(line)
				if not line.mainFrameYay then
					return
				end
				local mesh = line.mainFrameYay:FindFirstChild("MainFrameUIScale") or line.mainFrameYay:FindFirstChildOfClass("UIScale")
				if not mesh then
					return
				end
				local xString = line:GetScreenScale()

				if line.mobileToggleScale then
					tweenInstance(line.mobileToggleScale, { Scale = (flags.MobileButtonScale or 100) / 100 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				end

				if line.dropdownHolderScale then
					local currentScale = line.dropdownHolderScale.Scale

					if line.detachedDropdowns and currentScale > 0 and currentScale ~= xString then
						local sourceTable = {}

						for vertex in pairs(line.detachedDropdowns) do
							if vertex.detached and vertex.buttonFrame then
								sourceTable[vertex] = vertex.buttonFrame.AbsolutePosition
							end
						end

						line.dropdownHolderScale.Scale = xString

						for vertex, innerValue in pairs(sourceTable) do
							if vertex.buttonFrame then
								local index48 = tonumber(xString) or 1
								if index48 <= 0 then
									index48 = 1
								end
								vertex.buttonFrame.Position = UDim2.fromOffset(innerValue.X / index48, innerValue.Y / index48)
							end
						end
					else
						line.dropdownHolderScale.Scale = xString
					end
				end

				if line.isToggledOn then
					tweenInstance(mesh, { Scale = xString }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				else
					mesh.Scale = 0.8 * xString
				end
			end

			uiLibrary.SetVisible = function(line, pointA)
				line.isToggledOn = pointA
				local xString = line:GetScreenScale()

				if pointA then
					line.mainFrameYay.GroupTransparency = 1

					if line.dropdownHolderRef then
						line.dropdownHolderRef.Visible = true
					end

					line.watermarkFrame.GroupTransparency = 1
					line.mainFrameYay.Visible = true
					line.watermarkFrame.Visible = true
					local knob = line.mainFrameYay:FindFirstChildOfClass("UIScale")

					if knob then
						knob.Scale = 0.92 * xString
					end

					tweenInstance(line.mainFrameYay, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					if knob then
						tweenInstance(knob, { Scale = xString }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					end

					tweenInstance(line.watermarkFrame, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					task.delay(0.5, function()
							if line.isToggledOn and line.sectionRefreshers then
								for _, zone in ipairs(line.sectionRefreshers) do
									zone()
								end
							end
						end)
				else
					for vertex in pairs(line.openDropdowns) do
						if vertex.Close then
							vertex:Close()
						end
					end

					tweenInstance(line.mainFrameYay, { GroupTransparency = 1 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local panel = line.mainFrameYay:FindFirstChildOfClass("UIScale")

					if panel then
						tweenInstance(panel, { Scale = 0.8 * xString }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					end

					tweenInstance(line.watermarkFrame, { GroupTransparency = 1 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					if not configData.First_Execution_Done then
						configData.First_Execution_Done = true
						saveConfig()
						local query

						if touchEnabled then
							query = "Tap the button in the bottom left to Hide/Unhide the UI."
						else
							query = (line.toggleVisibilityKeyName or "RightAlt") .. " to Hide/Unhide the UI."
						end

						line:Notify({ Title = query, Duration = 4 })
					end

					task.delay(0.35, function()
							if not line.isToggledOn then
								line.mainFrameYay.Visible = false
								line.watermarkFrame.Visible = false
							end
						end)
				end
			end

			uiLibrary.CreateWatermarkBecauseWeCool = function(line)
				local query = line.config.Name .. " | 00:00:00 | 60 FPS | 0 MS"
				local elapsedTime = measureTextWidth(query, 14, Enum.Font.GothamSemibold) + 45
				local difference = 0

				line.watermarkFrame = createInstance("CanvasGroup", {
					Name = "WatermarkCuzWeNeedFlexing",
					BackgroundColor3 = line.config.Colors.Secondary,
					Position = UDim2.new(0.01, 0, 0.02, 0),
					BorderColor3 = line.config.Colors.Black,
					BorderSizePixel = 0,
					GroupTransparency = 1,
					Size = UDim2.new(0, elapsedTime, 0, 36),
					Parent = line.screenGuiYay,
				})

				createInstance("UICorner", {
					Name = "RoundedCornersAreSexy",
					CornerRadius = UDim.new(0, 7),
					Parent = line.watermarkFrame,
				})

				createInstance("UIAspectRatioConstraint", {
					Name = "KeepItSquare",
					Parent = createInstance("ImageLabel", {
					Name = "IconGoesHere",
					BorderColor3 = Color3.new(),
					BackgroundColor3 = Color3.new(1, 1, 1),
					Image = "rbxassetid://10723375250",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, -7.5),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 15, 0, 15),
					Parent = line.watermarkFrame,
				}),
				})

				line.watermarkTextLabel = createInstance("TextLabel", {
					Name = "WatermarkText",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = Color3.new(1, 1, 1),
					Text = query,
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 35, 0, 0),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(1, -40, 1, 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.watermarkFrame,
				})

				createInstance("UIPadding", { Name = "PaddingForDays", PaddingTop = UDim.new(0, 2), Parent = line.watermarkTextLabel })
				index32(line.watermarkFrame)
				local openError = 60
				local step = 0
				local osClock = os.clock()
				local knob = nil

				knob = trackConnection(runService.RenderStepped:Connect(function()
						if not line.watermarkFrame or not line.watermarkFrame.Parent then
							disconnectTrackedConnection(knob)
							return
						end
						step += 1
						local finish = os.clock()

						if finish - osClock >= 1 then
							openError = math.floor(step / (finish - osClock) + 0.5)
							step = 0
							osClock = finish
						end
					end))

				task.spawn(function()
						while task.wait(1) do
							local player31 = line.watermarkFrame
							local toggleButton = line.watermarkTextLabel

							if not (not player31 or not player31.Parent or not toggleButton or not toggleButton.Parent) then
								local currentDate = os.date("%H:%M:%S")
								local index46 = tonumber(latestPingMs) or tonumber(difference) or 0
								difference = math.floor(index46 + 0.5)
								local cacheKey = tostring(line.config.Name or "Flyte") .. " | " .. tostring(currentDate) .. " | " .. tostring(openError) .. " FPS | " .. tostring(difference) .. tostring(" MS")
								toggleButton.Text = cacheKey
								local mathMax = measureTextWidth(cacheKey, 14, Enum.Font.GothamSemibold) + 45

								if 2 < math.abs(player31.Size.X.Offset - mathMax) then
									tweenInstance(player31, { Size = UDim2.new(0, mathMax, 0, 36) }, 0.2)
								end

								continue
							end

							break
						end
					end)
			end

			uiLibrary.CreateMainFrameYay = function(line)
				line.mainFrameYay = createInstance("CanvasGroup", {
					Name = "MainFrame",
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = line.config.Colors.Primary,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderColor3 = line.config.Colors.Black,
					BorderSizePixel = 0,
					GroupTransparency = 1,
					Size = UDim2.new(0, 753, 0, 493),
					Parent = line.screenGuiYay,
				})

				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 10), Parent = line.mainFrameYay })
				createInstance("UIScale", { Name = "MainFrameUIScale", Scale = 1, Parent = line.mainFrameYay })

				line.dragBarThing = createInstance("Frame", {
					Name = "DragBarForDragging",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 65),
					Parent = line.mainFrameYay,
				})

				index32(line.mainFrameYay, line.dragBarThing)

				local function handlePlayerAdded(object, descendant, radius)
					local manager = createInstance("ImageButton", {
						Name = object,
						BackgroundTransparency = 1,
						Image = "rbxassetid://" .. descendant,
						ImageColor3 = line.config.Colors.SubText,
						Position = UDim2.new(1, -radius, 0, 17),
						Size = UDim2.new(0, 16, 0, 16),
						BorderSizePixel = 0,
						AutoButtonColor = false,
						Parent = line.mainFrameYay,
					})

					manager.MouseEnter:Connect(function()
							tweenInstance(manager, { ImageColor3 = line.config.Colors.Text }, 0.2, Enum.EasingStyle.Quint)
						end)

					manager.MouseLeave:Connect(function()
							tweenInstance(manager, { ImageColor3 = line.config.Colors.SubText }, 0.2, Enum.EasingStyle.Quint)
						end)

					return manager
				end

				line.minimizeButton = handlePlayerAdded("MinimizeButton", "120931250449806", 50)
				line.closeButton = handlePlayerAdded("CloseButton", "73070135088117", 24)

				line.minimizeButton.MouseButton1Click:Connect(function()
						line:SetVisible(false)
					end)

				line.closeButton.MouseButton1Click:Connect(function()
						line:Destroy()
					end)

				local knob = measureTextWidth(line.config.Name, 17, Enum.Font.GothamSemibold)

				line.hubNameLabel = createInstance("TextLabel", {
					Name = "HubNameGoesHere",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = Color3.new(1, 1, 1),
					Text = line.config.Name,
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 14),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 17,
					Size = UDim2.new(0, knob + 10, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrameYay,
				})

				local elapsedTime = 156 - knob + 20 - 50
				local currentDate = truncateTextToWidth("@" .. localPlayer.Name, elapsedTime, 14, Enum.Font.GothamSemibold)

				line.userNameLabel = createInstance("TextLabel", {
					Name = "UserNameOfTheCoolPlayer",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.config.Colors.Muted,
					Text = currentDate,
					BackgroundColor3 = line.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 34),
					BorderSizePixel = 0,
					BorderColor3 = line.config.Colors.Black,
					TextSize = 14,
					Size = UDim2.new(0, elapsedTime + 10, 0, 18),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Parent = line.mainFrameYay,
				})

				line.playerAvatarImg = createInstance("ImageLabel", {
					Name = "PlayerAvatarIs4K",
					BorderColor3 = line.config.Colors.Black,
					BackgroundColor3 = line.config.Colors.White,
					Image = "rbxassetid://135756197673563",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 145, 0, 17),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 30, 0, 30),
					Parent = line.mainFrameYay,
				})

				task.spawn(function()
						local packed = generateRandomArray(localPlayer.UserId)

						if line.playerAvatarImg and line.playerAvatarImg.Parent then
							line.playerAvatarImg.Image = packed
						end
					end)

				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = line.playerAvatarImg })

				line.lineSeperator = createInstance("Frame", {
					Name = "LineThatSeperates",
					BackgroundColor3 = line.config.Colors.BorderSoft,
					Position = UDim2.new(0, 19, 0, 64),
					BorderColor3 = line.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, 156, 0, 1),
					Parent = line.mainFrameYay,
				})

				local packed = createInstance
				local sourceTable = { Name = "UIGradient" }
				local controller = ColorSequence.new
				local players = {}
				local angleRadians = ColorSequenceKeypoint.new(0, line.config.Colors.BorderSoft)
				local track = ColorSequenceKeypoint.new(0.5, line.config.Colors.AccentLight)
				local instance4 = ColorSequenceKeypoint.new
				local vertexCount = 1
				local response = line.config.Colors.BorderSoft
				players[1] = angleRadians
				players[2] = track

				do
					local argumentPack = table.pack(instance4(vertexCount, response))
					table.move(argumentPack, 1, argumentPack.n, 3, players)
				end

				sourceTable.Color = controller(players)
				sourceTable.Parent = line.lineSeperator
				packed("UIGradient", sourceTable)

				line.tabNameLabel = createInstance("TextLabel", {
					Name = "TabNameGoesHere",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.config.Colors.Text,
					Text = "tab name",
					BackgroundColor3 = line.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 201, 0, 14),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 17,
					Size = UDim2.new(0, 78, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrameYay,
				})

				line.tabDescriptionLabel = createInstance("TextLabel", {
					Name = "TabDescriptionGoesHere",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.config.Colors.Muted,
					Text = "tab description",
					BackgroundColor3 = line.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 201, 0, 34),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(0, 200, 0, 18),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrameYay,
				})

				line.sectionHolderScroll = createInstance("ScrollingFrame", {
					Name = "SectionHolderForSections",
					Active = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 17, 0, 75),
					Size = UDim2.new(0, 162, 0, 400),
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ClipsDescendants = false,
					Parent = line.mainFrameYay,
				})

				createInstance("UIPadding", {
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 2),
					PaddingRight = UDim.new(0, 2),
					PaddingTop = UDim.new(0, 2),
					PaddingBottom = UDim.new(0, 2),
					Parent = line.sectionHolderScroll,
				})

				line.sectionLayoutThing = createInstance("UIListLayout", {
					Name = "UIListLayout",
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = line.sectionHolderScroll,
				})

				line.contentHolderFrame = createInstance("Frame", {
					Name = "ContentHolderFrame",
					Active = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 198, 0, 62),
					Size = UDim2.new(0, 548, 0, 424),
					ClipsDescendants = true,
					Parent = line.mainFrameYay,
				})
			end
		end
	end
end

do
	local knob, currentDate, wrapper

	do
		uiLibrary.CreateNotificationHolderForCoolNotifs = function(line)
			line.notificationHolderFrame = createInstance("Frame", {
				Name = "NotificationHolderForNotifs",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -20, 0, 20),
				AnchorPoint = Vector2.new(1, 0),
				Size = UDim2.new(0, 300, 0, 400),
				Parent = line.screenGuiYay,
			})

			createInstance("UIListLayout", {
				Name = "UIListLayout",
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				Parent = line.notificationHolderFrame,
			})
		end

		uiLibrary.Notify = function(line, object)
			local sourceTable = object or {}
			sourceTable.Title = tostring(sourceTable.Title or "Notification" or "Notification")
			sourceTable.Duration = sourceTable.Duration or 3
			sourceTable.Icon = sourceTable.Icon or "rbxassetid://10747361219"
			local cosine = textService:GetTextSize(sourceTable.Title, 15, Enum.Font.GothamSemibold, Vector2.new(math.huge, 50))
			local index54 = cosine and tonumber(cosine.X) or 0
			local elapsedTime = math.max(127, index54 + 80)

			local data = createInstance("Frame", {
				Name = "NotificationYay",
				BackgroundColor3 = line.config.Colors.Secondary,
				Position = UDim2.new(1.5, 0, 0, 0),
				BorderColor3 = line.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, elapsedTime, 0, 50),
				BackgroundTransparency = 1,
				Parent = line.notificationHolderFrame,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 10), Parent = data })
			createInstance("UIScale", { Name = "UIScale", Scale = 0.8, Parent = data })

			local packed = createInstance("Frame", {
				Name = "PillIndicator",
				BackgroundColor3 = line.config.AccentColor,
				Position = UDim2.new(0, 0, 0.22, 0),
				BorderColor3 = line.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 6, 0, 30),
				Parent = data,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = packed })

			createInstance("Frame", {
				Name = "PillExtension",
				BackgroundColor3 = line.config.AccentColor,
				BorderColor3 = line.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 4, 0, 28),
				Parent = packed,
			})

			local playerId = createInstance("ImageLabel", {
				Name = "NotificationIcon",
				BorderColor3 = line.config.Colors.Black,
				BackgroundColor3 = line.config.Colors.White,
				Image = sourceTable.Icon,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 15, 0.5, -10),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 20, 0, 20),
				ImageTransparency = 1,
				Parent = data,
			})

			createInstance("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = playerId })

			local radians = createInstance("TextLabel", {
				Name = "NotificationText",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.config.Colors.Text,
				Text = sourceTable.Title,
				BackgroundColor3 = line.config.Colors.White,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 45, 0.5, -8.5),
				BorderSizePixel = 0,
				BorderColor3 = line.config.Colors.Black,
				TextSize = 15,
				Size = UDim2.new(0, index54 + 20, 0, 17),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTransparency = 1,
				Parent = data,
			})

			local panel = data:FindFirstChild("UIScale")

			task.defer(function()
					tweenInstance(data, { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					tweenInstance(panel, { Scale = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					tweenInstance(playerId, { ImageTransparency = 0 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					tweenInstance(radians, { TextTransparency = 0 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				end)

			task.delay(sourceTable.Duration, function()
					if data and data.Parent then
						tweenInstance(data, { Position = UDim2.new(1.5, 0, 0, 0), BackgroundTransparency = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
						tweenInstance(panel, { Scale = 0.8 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
						tweenInstance(playerId, { ImageTransparency = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						tweenInstance(radians, { TextTransparency = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						task.wait(0.5)

						if data and data.Parent then
							data:Destroy()
						end
					end
				end)

			return data
		end

		obj = setmetatable({}, { __mode = "k" })
		knob = nil
		currentDate = nil

		do
			local top = false

			local function onInputBegan()
				if top then
					if not flag3 then
						return
					end
					return
				end

				top = true

				flyteBBState.Connections["UISliderInputChanged"] = userInputService.InputChanged:Connect(function(inputObject)
						if knob then
							knob(inputObject)
						end
					end)

				flyteBBState.Connections["UI Slider Input Ended"] = userInputService.InputEnded:Connect(function(inputObject)
						if currentDate then
							currentDate(inputObject)
						end
					end)
			end

			wrapper = function(line, object)
				onInputBegan()
				knob = line
				currentDate = object
			end
		end
	end

	do
		local function onInputBegan(line)
			if knob == line then
				knob = nil
				currentDate = nil
			end
		end

		local function handlePlayerAdded(line)
			if 1 <= line then
				return 0
			end
			local query = string.format("%.10f", line):gsub("0+$", ""):gsub("%.$", "")
			local rootFirst = query:find("%.")
			return rootFirst and math.min(10, #query - rootFirst) or 0
		end

		addToggle = function(line, object)
			local packed = obj[line]
			local player23 = packed.TabConfig
			local player4 = packed.GroupConfig
			local success10 = packed.UpdateSize
			local playerPosition = packed.CreateKeybindPill
			object = object or {}
			object.Name = object.Name or "Toggle"
			object.Default = object.Default or false

			object.Callback = object.Callback or function()
			end

			object.Notify = object.Notify == true
			object.SaveName = object.SaveName or object.Name
			object.Keybind = object.Keybind ~= false
			local sourceTable = {}
			local config = line.elementYPos
			local index55 = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.SaveName)
			local query = "toggle:" .. index55
			local concatenated = index55 .. ":notify"
			local radians = safeIndex(configData.Toggles, index55, object.NoSave)
			local result29 = object.Notify and safeIndex(configData.Toggles, concatenated)
			sourceTable.value = type(radians) == "boolean" and radians or object.Default
			sourceTable.notify = type(result29) == "boolean" and result29 or false
			sourceTable.NotifySaveId = object.Notify and concatenated or nil
			sourceTable.DefaultNotify = false

			sourceTable.labelText = createInstance("TextLabel", {
				Name = "ToggleLabel",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = sourceTable.value and line.Library.config.Colors.Text or line.Library.config.Colors.SubText,
				Text = object.Name,
				BackgroundColor3 = line.Library.config.Colors.White,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, config),
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(),
				TextSize = 14,
				Size = UDim2.new(0, 150, 0, 20),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = line.mainFrame,
			})

			sourceTable.switchFrame = createInstance("Frame", {
				Name = "ToggleSwitch",
				BackgroundColor3 = sourceTable.value and line.Library.config.AccentColor or line.Library.config.Colors.Element,
				Position = UDim2.new(1, -44, 0, config),
				BorderColor3 = line.Library.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 34, 0, 21),
				Parent = line.mainFrame,
			})

			local function initialize(descendant)
				return UDim2.new(1, object.Keybind and -77 - descendant or -44, 0, config)
			end

			if object.Keybind then
				sourceTable.keybindPill = playerPosition(line.mainFrame, query, function(descendant)
						if sourceTable.notifyButton then
							sourceTable.notifyButton.Position = initialize(descendant)
						end

						return UDim2.new(1, -44 - descendant - 7, 0, config + 2)
					end, 17, 8, function(descendant, radius)
						if radius == "Hold" then
							sourceTable:Set(descendant)
							return
						end

						if descendant then
							sourceTable:Set(not sourceTable.value)
						end
					end, {
					Group = "toggles",
					Name = object.Name,
					GetState = function()
						return sourceTable.value
					end,
				})
			end

			sourceTable.SaveId = index55
			sourceTable.DefaultValue = object.Default
			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sourceTable.switchFrame })
			local targetSize = UDim2.new(0, 3, 0, 3)
			local bottomGoal = UDim2.new(0, 16, 0, 3)

			sourceTable.circleFrame = createInstance("Frame", {
				Name = "ToggleCircle",
				BackgroundColor3 = sourceTable.value and line.Library.config.Colors.White or line.Library.config.Colors.Muted,
				Position = sourceTable.value and bottomGoal or targetSize,
				BorderColor3 = line.Library.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 15, 0, 15),
				Parent = sourceTable.switchFrame,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sourceTable.circleFrame })

			local button = createInstance("TextButton", {
				Name = "ToggleClickButton",
				Text = "",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, config),
				Size = UDim2.new(1, 0, 0, 26),
				Parent = line.mainFrame,
			})

			if object.Notify then
				sourceTable.notifyButton = createInstance("ImageButton", {
					Name = "NotifyBell",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "",
					Position = initialize(sourceTable.keybindPill and sourceTable.keybindPill.frame.Size.X.Offset or 0),
					Size = UDim2.new(0, 20, 0, 21),
					ZIndex = 3,
					Parent = line.mainFrame,
				})

				sourceTable.notifyIcon = createInstance("ImageLabel", {
					Name = "BellIcon",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "rbxassetid://128533908255115",
					ImageColor3 = sourceTable.notify and line.Library.config.Colors.Text or line.Library.config.Colors.Muted,
					ImageTransparency = sourceTable.notify and 0 or 0.5,
					Position = UDim2.new(0.5, -9, 0.5, -(tonumber(9) or 9)),
					Size = UDim2.new(0, 18, 0, 18),
					ZIndex = 4,
					Parent = sourceTable.notifyButton,
				})

				sourceTable.notifyScale = createInstance("UIScale", { Scale = 1, Parent = sourceTable.notifyIcon })

				sourceTable.SetNotify = function(descendant, radius)
					local isAbsolute = radius == true
					sourceTable.notify = isAbsolute
					sourceTable.notifyIcon.Rotation = isAbsolute and -14 or 14
					sourceTable.notifyScale.Scale = 0.82

					tweenInstance(sourceTable.notifyIcon, {
						ImageColor3 = isAbsolute and line.Library.config.Colors.Text or line.Library.config.Colors.Muted,
						ImageTransparency = isAbsolute and 0 or 0.5,
						Rotation = 0,
					}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

					tweenInstance(sourceTable.notifyScale, { Scale = 1 }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					configData.Toggles[concatenated] = isAbsolute
					saveConfig()
				end

				sourceTable.notifyButton.MouseButton1Click:Connect(function()
						sourceTable:SetNotify(not sourceTable.notify)
					end)

				sourceTable.notifyButton.MouseEnter:Connect(function()
						if not sourceTable.notify then
							tweenInstance(sourceTable.notifyIcon, { ImageColor3 = line.Library.config.Colors.TextHover, ImageTransparency = 0.5 }, 0.15)
						end
					end)

				sourceTable.notifyButton.MouseLeave:Connect(function()
						if not sourceTable.notify then
							tweenInstance(sourceTable.notifyIcon, { ImageColor3 = line.Library.config.Colors.Muted, ImageTransparency = 0.5 }, 0.15)
						end
					end)
			end

			sourceTable.Set = function(descendant, radius)
				local yString = sourceTable.value
				sourceTable.value = radius == true

				if sourceTable.value then
					tweenInstance(sourceTable.switchFrame, { BackgroundColor3 = line.Library.config.AccentColor }, 0.4)
					tweenInstance(sourceTable.circleFrame, { Position = bottomGoal, BackgroundColor3 = line.Library.config.Colors.White }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.Text }, 0.3, Enum.EasingStyle.Quint)
				else
					tweenInstance(sourceTable.switchFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.4)
					tweenInstance(sourceTable.circleFrame, { Position = targetSize, BackgroundColor3 = line.Library.config.Colors.Muted }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.3, Enum.EasingStyle.Quint)
				end

				if not object.NoSave then
					configData.Toggles[index55] = sourceTable.value
				end

				if object.Callback then
					object.Callback(sourceTable.value)
				end

				if not object.NoSave then
					task.defer(saveConfig)
				end

				local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
				if type(deferredFunction) == "function" then
					task.defer(deferredFunction)
				end

				if object.Notify and sourceTable.notify and yString ~= sourceTable.value then
					line.Library:Notify({ Title = (sourceTable.value and "Enabled " or "Disabled ") .. (object.NotifyName or object.Name) })
				end
			end

			button.MouseButton1Click:Connect(function()
					sourceTable:Set(not sourceTable.value)
				end)

			button.InputBegan:Connect(function(inputObject)
					if inputObject.UserInputType == Enum.UserInputType.MouseButton2 and sourceTable.keybindPill then
						sourceTable.keybindPill:OpenMode(inputObject.Position)
					end
				end)

			button.MouseEnter:Connect(function()
					if not sourceTable.value then
						tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.TextHover }, 0.2, Enum.EasingStyle.Quint)
					end
				end)

			button.MouseLeave:Connect(function()
					if not sourceTable.value then
						tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.2, Enum.EasingStyle.Quint)
					end
				end)

			line.elementYPos = line.elementYPos + 28
			success10()
			table.insert(line.elementsInGroup, sourceTable)
			sourceTable:Set(sourceTable.value)
			return sourceTable
		end

		addSlider = function(line, object)
			local packed = obj[line]
			local player23 = packed.TabConfig
			local player4 = packed.GroupConfig
			local success10 = packed.UpdateSize
			object = object or {}
			object.Name = object.Name or "Slider"
			object.Min = object.Min or 0
			object.Max = object.Max or 100
			object.Default = object.Default or object.Min
			object.Increment = object.Increment or 1

			object.Callback = object.Callback or function()
			end

			local sourceTable = {}
			local config = line.elementYPos
			local radians = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.Name)
			local angleRadians = safeIndex(configData.Sliders, radians, object.NoSave)
			sourceTable.value = type(angleRadians) == "number" and angleRadians or object.Default
			sourceTable.SaveId = radians
			sourceTable.DefaultValue = object.Default
			local query = "%." .. handlePlayerAdded(object.Increment) .. "f"

			local function initialize(descendant)
				return string.format(query, descendant)
			end

			sourceTable.labelText = createInstance("TextLabel", {
				Name = "SliderLabel",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.Library.config.Colors.SubText,
				Text = object.Name,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, config),
				BorderSizePixel = 0,
				TextSize = 14,
				Size = UDim2.new(0, 140, 0, 20),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = line.mainFrame,
			})

			sourceTable.backgroundFrame = createInstance("Frame", {
				Name = "SliderBackground",
				BackgroundColor3 = line.Library.config.Colors.Surface,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0, config + 28),
				BorderColor3 = line.Library.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 238, 0, 5),
				Parent = line.mainFrame,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sourceTable.backgroundFrame })
			local elapsedTime = (sourceTable.value - object.Min) / (object.Max - object.Min)

			sourceTable.fillFrame = createInstance("Frame", {
				Name = "SliderFill",
				BackgroundColor3 = Color3.new(1, 1, 1),
				Position = UDim2.new(0, 0, 0, 0),
				BorderColor3 = line.Library.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 238 * elapsedTime, 1, 0),
				Parent = sourceTable.backgroundFrame,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sourceTable.fillFrame })
			local vertexCount = createInstance
			local players = { Name = "SliderFillGradient" }
			local controller = ColorSequence.new
			local sorted = {}
			local steering = ColorSequenceKeypoint.new(0, line.Library.config.Colors.AccentDark)
			local major = ColorSequenceKeypoint.new(0.5, line.Library.config.AccentColor)
			local instance4 = ColorSequenceKeypoint.new
			local offsetX = line.Library.config.Colors.AccentLight
			sorted[1] = steering
			sorted[2] = major

			do
				local argumentPack = table.pack(instance4(1, offsetX))
				table.move(argumentPack, 1, argumentPack.n, 3, sorted)
			end

			players.Color = controller(sorted)
			players.Parent = sourceTable.fillFrame
			sourceTable.fillGradient = vertexCount("UIGradient", players)

			sourceTable.valueBox = createInstance("TextBox", {
				Name = "SliderValueBox",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.Library.config.Colors.SubText,
				Text = initialize(sourceTable.value) .. " / " .. initialize(object.Max),
				PlaceholderText = "",
				ClearTextOnFocus = true,
				TextEditable = true,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -95, 0, config),
				BorderSizePixel = 0,
				TextSize = 14,
				Size = UDim2.new(0, 85, 0, 20),
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = line.mainFrame,
			})

			local button = createInstance("TextButton", {
				Name = "SliderClickButton",
				Text = "",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(1, 0, 0, 24),
				Parent = sourceTable.backgroundFrame,
			})

			local byte = elapsedTime
			local difference = elapsedTime
			local top = false
			local cell = false
			local active = false
			local connection = nil

			local function serializeTable()
				if connection then
					return
				end

				if math.abs(byte - difference) <= 0.0001 then
					byte = difference
					sourceTable.fillFrame.Size = UDim2.new(0, 238 * byte, 1, 0)
					return
				end

				connection = runService.RenderStepped:Connect(function()
						if not sourceTable.backgroundFrame.Parent then
							connection:Disconnect()
							connection = nil
							return
						end

						byte += (difference - byte) * 0.15

						if math.abs(byte - difference) < 0.0001 then
							byte = difference
						end

						sourceTable.fillFrame.Size = UDim2.new(0, 238 * byte, 1, 0)

						if byte == difference then
							connection:Disconnect()
							connection = nil
						end
					end)
			end

			sourceTable.Set = function(descendant, radius, zCoordinate)
				radius = type(radius) == "number" and radius or object.Default
				local index26 = object.Increment
				local openError = math.clamp(object.Min + math.floor((radius - object.Min) / object.Increment + 0.5) * index26, object.Min, object.Max)
				local yString = tonumber(initialize(openError)) or openError
				sourceTable.value = yString

				if not zCoordinate then
					difference = (yString - object.Min) / (object.Max - object.Min)
				end

				serializeTable()

				if not top then
					sourceTable.valueBox.Text = initialize(yString) .. " / " .. initialize(object.Max)
				end

				if not object.NoSave then
					configData.Sliders[radians] = yString

					if not cell then
						saveConfig()
					end
				end

				object.Callback(yString)
			end

			sourceTable.valueBox.Focused:Connect(function()
					top = true
				end)

			sourceTable.valueBox:GetPropertyChangedSignal("Text"):Connect(function()
					if not top then
						return
					end
					local userId = tonumber(sourceTable.valueBox.Text:match("^[%d%.]+"))

					if userId then
						difference = (math.clamp(userId, object.Min, object.Max) - object.Min) / (object.Max - object.Min)
						serializeTable()
					end
				end)

			sourceTable.valueBox.FocusLost:Connect(function()
					top = false
					sourceTable:Set(tonumber(sourceTable.valueBox.Text:match("^[%d%.]+")) or sourceTable.value)

					if object.OnCommit then
						object.OnCommit(sourceTable.value)
					end
				end)

			local function generateRandomPoints(descendant)
				local isArray = descendant == "drag" or descendant == "hover"
				tweenInstance(sourceTable.backgroundFrame, { Size = UDim2.new(0, 238, 0, descendant == "drag" and 7 or descendant == "hover" and 6 or 5) }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				isArray = isArray and line.Library.config.Colors.Text or line.Library.config.Colors.SubText
				tweenInstance(sourceTable.valueBox, { TextColor3 = isArray }, 0.25, Enum.EasingStyle.Quint)
				tweenInstance(sourceTable.labelText, { TextColor3 = isArray }, 0.25, Enum.EasingStyle.Quint)
			end

			button.MouseEnter:Connect(function()
					active = true

					if not cell then
						generateRandomPoints("hover")
					end
				end)

			button.MouseLeave:Connect(function()
					active = false

					if not cell then
						generateRandomPoints("idle")
					end
				end)

			local neighbors = {}
			local delayTime = nil

			local function initializeSystem()
				if delayTime then
					task.cancel(delayTime)
				end

				delayTime = nil

				for _, playerObject in ipairs(neighbors) do
					if playerObject and playerObject.Parent then
						playerObject.ScrollingEnabled = true
					end
				end

				table.clear(neighbors)
			end

			local function addVectors()
				local checkpointFolder = button.Parent
				while checkpointFolder and checkpointFolder ~= game do
					if checkpointFolder:IsA("ScrollingFrame") and checkpointFolder.ScrollingEnabled then
						checkpointFolder.ScrollingEnabled = false
						table.insert(neighbors, checkpointFolder)
					end

					checkpointFolder = checkpointFolder.Parent
				end

				if delayTime then
					task.cancel(delayTime)
				end

				delayTime = task.delay(2, function()
						delayTime = nil
						initializeSystem()
					end)
			end

			local function calculateDistance(descendant)
				if cell and (descendant.UserInputType == Enum.UserInputType.MouseMovement or descendant.UserInputType == Enum.UserInputType.Touch) then
					local openError = math.clamp((descendant.Position.X - sourceTable.backgroundFrame.AbsolutePosition.X) / sourceTable.backgroundFrame.AbsoluteSize.X, 0, 1)
					difference = openError
					sourceTable:Set(object.Min + (object.Max - object.Min) * openError, true)
				end
			end

			local function traverse(descendant)
				if descendant.UserInputType == Enum.UserInputType.MouseButton1 or descendant.UserInputType == Enum.UserInputType.Touch then
					if cell then
						cell = false
						initializeSystem()
						generateRandomPoints(active and "hover" or "idle")
						difference = (sourceTable.value - object.Min) / (object.Max - object.Min)
						serializeTable()

						if not object.NoSave then
							saveConfig()
						end

						onInputBegan(calculateDistance)

						if object.OnCommit then
							object.OnCommit(sourceTable.value)
						end
					end
				end
			end

			button.MouseButton1Down:Connect(function(relativeVelocity)
					cell = true
					generateRandomPoints("drag")
					addVectors()
					local openError = math.clamp(((relativeVelocity or userInputService:GetMouseLocation().X) - sourceTable.backgroundFrame.AbsolutePosition.X) / sourceTable.backgroundFrame.AbsoluteSize.X, 0, 1)
					difference = openError
					sourceTable:Set(object.Min + (object.Max - object.Min) * openError, true)
					wrapper(calculateDistance, traverse)
				end)

			sourceTable:Set(sourceTable.value)
			line.elementYPos = line.elementYPos + 40
			success10()
			table.insert(line.elementsInGroup, sourceTable)
			return sourceTable
		end

		addDoubleSlider = function(line, object)
			local packed = obj[line]
			local player23 = packed.TabConfig
			local player4 = packed.GroupConfig
			local success10 = packed.UpdateSize
			object = object or {}
			object.Name = object.Name or "Double Slider"
			object.Min = object.Min or 1
			object.Max = object.Max or 100
			object.DefaultMin = object.DefaultMin or object.Min
			object.DefaultMax = object.DefaultMax or object.Max
			object.Increment = object.Increment or 1

			object.Callback = object.Callback or function()
			end

			local sourceTable = {}
			local config = line.elementYPos
			local radians = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.Name)
			local angleRadians = safeIndex(configData.DoubleSliders, radians, object.NoSave)
			sourceTable.minValue = type(angleRadians) == "table" and type(angleRadians.Min) == "number" and angleRadians.Min or object.DefaultMin
			sourceTable.maxValue = type(angleRadians) == "table" and type(angleRadians.Max) == "number" and angleRadians.Max or object.DefaultMax
			sourceTable.SaveId = radians
			sourceTable.DefaultValue = { Min = object.DefaultMin, Max = object.DefaultMax }

			sourceTable.labelText = createInstance("TextLabel", {
				Name = "DoubleSliderLabel",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.Library.config.Colors.SubText,
				Text = object.Name,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, config),
				BorderSizePixel = 0,
				TextSize = 14,
				Size = UDim2.new(0, 140, 0, 20),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = line.mainFrame,
			})

			sourceTable.valueLabelText = createInstance("TextLabel", {
				Name = "DoubleSliderValueLabel",
				AnchorPoint = Vector2.new(1, 0),
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.Library.config.Colors.SubText,
				Text = "",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -(tonumber(10) or 10), 0, config),
				BorderSizePixel = 0,
				TextSize = 14,
				Size = UDim2.new(0, 85, 0, 20),
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = line.mainFrame,
			})

			sourceTable.backgroundFrame = createInstance("Frame", {
				Name = "DoubleSliderBackground",
				BackgroundColor3 = line.Library.config.Colors.Surface,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0, config + 28),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -20, 0, 5),
				Parent = line.mainFrame,
			})

			createInstance("UICorner", { CornerRadius = UDim.new(1, 0), Parent = sourceTable.backgroundFrame })

			sourceTable.fillFrame = createInstance("Frame", {
				Name = "DoubleSliderFill",
				BackgroundColor3 = Color3.new(1, 1, 1),
				BorderSizePixel = 0,
				Parent = sourceTable.backgroundFrame,
			})

			createInstance("UICorner", { CornerRadius = UDim.new(1, 0), Parent = sourceTable.fillFrame })
			local vertexCount = createInstance
			local steering = "UIGradient"
			local players = { Name = "DoubleSliderFillGradient" }
			local controller = ColorSequence.new
			local sorted = {}
			local major = ColorSequenceKeypoint.new(0, line.Library.config.Colors.AccentDark)
			local byte = ColorSequenceKeypoint.new(0.5, line.Library.config.AccentColor)
			local instance4 = ColorSequenceKeypoint.new
			local result68 = 1
			local offsetX = line.Library.config.Colors.AccentLight
			sorted[1] = major
			sorted[2] = byte

			do
				local argumentPack = table.pack(instance4(result68, offsetX))
				table.move(argumentPack, 1, argumentPack.n, 3, sorted)
			end

			players.Color = controller(sorted)
			players.Parent = sourceTable.fillFrame
			sourceTable.fillGradient = vertexCount(steering, players)

			sourceTable.minEdgeFrame = createInstance("Frame", {
				Name = "DoubleSliderMinEdge",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(0, 30, 1, 12),
				Parent = sourceTable.backgroundFrame,
			})

			sourceTable.maxEdgeFrame = createInstance("Frame", {
				Name = "DoubleSliderMaxEdge",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(0, 30, 1, 12),
				Parent = sourceTable.backgroundFrame,
			})

			local query = "%." .. handlePlayerAdded(object.Increment) .. "f"

			local function initialize(descendant)
				return string.format(query, descendant)
			end

			local function serializeTable(descendant)
				local index26 = object.Increment
				local endIndex = object.Min
				local remaining = object.Max
				local elapsedTime = math.clamp(object.Min + math.floor((descendant - object.Min) / object.Increment + 0.5) * index26, endIndex, remaining)
				return tonumber(initialize(elapsedTime)) or elapsedTime
			end

			local function generateRandomPoints(descendant)
				return (descendant - object.Min) / (object.Max - object.Min)
			end

			local elapsedTime = 0
			local net = 0
			local difference = 0
			local openError = 0
			local top = false
			local concatenated = nil
			local connection = nil

			local function initializeSystem()
				if connection then
					return
				end
				local cell = math.abs(elapsedTime - difference) > 0.0001
				local active = math.abs(net - openError) > 0.0001
				if not cell and not active then
					return
				end

				connection = runService.RenderStepped:Connect(function()
						if not sourceTable.backgroundFrame.Parent then
							connection:Disconnect()
							connection = nil
							return
						end

						local slider = tonumber(0.0001) or 0.0001
						cell = math.abs(elapsedTime - difference) > slider
						active = math.abs(net - openError) > 0.0001

						if cell then
							elapsedTime += (difference - elapsedTime) * 0.15
							local newPrice = slider

							if math.abs(elapsedTime - difference) < newPrice then
								elapsedTime = difference
							end
						end

						if active then
							net += (openError - net) * 0.15
							local newPrice = slider

							if math.abs(net - openError) < newPrice then
								net = openError
							end
						end

						sourceTable.minEdgeFrame.Position = UDim2.new(elapsedTime, 0, 0.5, 0)
						sourceTable.maxEdgeFrame.Position = UDim2.new(net, 0, 0.5, 0)
						sourceTable.fillFrame.Position = UDim2.new(elapsedTime, 0, 0, 0)
						sourceTable.fillFrame.Size = UDim2.new(net - elapsedTime, 0, 1, 0)

						if elapsedTime == difference and net == openError then
							connection:Disconnect()
							connection = nil
						end
					end)
			end

			sourceTable.Set = function(descendant, radius, zCoordinate, alpha)
				radius = type(radius) == "number" and radius or object.DefaultMin
				zCoordinate = type(zCoordinate) == "number" and zCoordinate or object.DefaultMax
				local newPrice = serializeTable(radius)
				local screenPoint = serializeTable(zCoordinate)

				if not (screenPoint < newPrice) then
					local result69 = screenPoint
					screenPoint = newPrice
					newPrice = result69
				end

				sourceTable.minValue = screenPoint
				sourceTable.maxValue = newPrice

				if not alpha then
					difference = generateRandomPoints(screenPoint)
					openError = generateRandomPoints(newPrice)
				end

				initializeSystem()
				sourceTable.valueLabelText.Text = initialize(screenPoint) .. " - " .. initialize(newPrice)

				if not object.NoSave then
					if type(n24) == "number" and n24 >= 4769 then
						while true do
						end
					else
						configData.DoubleSliders[radians] = { Min = screenPoint, Max = newPrice }

						if not concatenated then
							saveConfig()
						end
					end
				end

				object.Callback(screenPoint, newPrice)
			end

			local function addVectors()
				local cacheKey = (concatenated or top) and line.Library.config.Colors.Text or line.Library.config.Colors.SubText
				tweenInstance(sourceTable.labelText, { TextColor3 = cacheKey }, 0.25, Enum.EasingStyle.Quint)
				tweenInstance(sourceTable.valueLabelText, { TextColor3 = cacheKey }, 0.25, Enum.EasingStyle.Quint)
			end

			local function calculateDistance(descendant)
				local step = math.clamp((descendant.Position.X - sourceTable.backgroundFrame.AbsolutePosition.X) / sourceTable.backgroundFrame.AbsoluteSize.X, 0, 1)

				if concatenated == "min" then
					difference = step
					sourceTable:Set(object.Min + (object.Max - object.Min) * step, sourceTable.maxValue, true)
					return
				end

				if concatenated == "max" then
					openError = step
					sourceTable:Set(sourceTable.minValue, object.Min + (object.Max - object.Min) * step, true)
				end
			end

			local previous = nil

			local slider = createInstance("TextButton", {
				Name = "DoubleSliderClickButton",
				Text = "",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(1, 0, 0, 24),
				Parent = sourceTable.backgroundFrame,
			})

			slider.MouseEnter:Connect(function()
					top = true
					addVectors()
				end)

			slider.MouseLeave:Connect(function()
					top = false
					addVectors()
				end)

			slider.MouseButton1Down:Connect(function(relativeVelocity)
					local index59 = relativeVelocity or userInputService:GetMouseLocation().X
					concatenated = math.abs(index59 - sourceTable.minEdgeFrame.AbsolutePosition.X + sourceTable.minEdgeFrame.AbsoluteSize.X * 0.5) <= math.abs(index59 - sourceTable.maxEdgeFrame.AbsolutePosition.X + sourceTable.maxEdgeFrame.AbsoluteSize.X * 0.5) and "min" or "max"
					local step = math.clamp((index59 - sourceTable.backgroundFrame.AbsolutePosition.X) / sourceTable.backgroundFrame.AbsoluteSize.X, 0, 1)

					if concatenated == "min" then
						difference = step
						sourceTable:Set(object.Min + (object.Max - object.Min) * step, sourceTable.maxValue, true)
					else
						openError = step
						sourceTable:Set(sourceTable.minValue, object.Min + (object.Max - object.Min) * step, true)
					end

					addVectors()
					wrapper(calculateDistance, previous)
				end)

			previous = function(descendant)
				if descendant.UserInputType == Enum.UserInputType.MouseButton1 or descendant.UserInputType == Enum.UserInputType.Touch then
					if concatenated then
						concatenated = nil
						addVectors()
						difference = generateRandomPoints(sourceTable.minValue)
						openError = generateRandomPoints(sourceTable.maxValue)
						initializeSystem()

						if not object.NoSave then
							saveConfig()
						end

						onInputBegan(calculateDistance)

						if object.OnCommit then
							object.OnCommit(sourceTable.minValue, sourceTable.maxValue)
						end
					end
				end
			end

			sourceTable:Set(sourceTable.minValue, sourceTable.maxValue)
			line.elementYPos = line.elementYPos + 40
			success10()
			table.insert(line.elementsInGroup, sourceTable)
			return sourceTable
		end
	end
end

do
	local hash

	do
		do
			local function main(line, object)
				local success10 = obj[line].UpdateSize
				object = object or {}
				object.Name = object.Name or "Button"
				object.Icon = object.Icon
				object.Locked = object.Locked or false

				object.Callback = object.Callback or function()
				end

				local sourceTable = { isLocked = object.Locked }
				local config = line.elementYPos
				local targetSize = UDim2.new(0, 238, 0, 26)

				sourceTable.mainFrame = createInstance("Frame", {
					Name = "ButtonFrame",
					BackgroundColor3 = sourceTable.isLocked and line.Library.config.Colors.Tertiary or line.Library.config.Colors.Element,
					Position = UDim2.new(0, 10, 0, config),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = targetSize,
					ClipsDescendants = true,
					Parent = line.mainFrame,
				})

				local coroutineHandle = createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = sourceTable.mainFrame })

				local j = createInstance("UIStroke", {
					Name = "UIStroke",
					Color = sourceTable.isLocked and line.Library.config.Colors.Element or line.Library.config.Colors.Border,
					Parent = sourceTable.mainFrame,
				})

				local bottomSnapZone = createInstance
				local players = { Name = "UIGradient" }
				local controller = ColorSequence.new
				local sorted = {}
				local knob = ColorSequenceKeypoint.new(0, line.Library.config.Colors.Text)
				local currentDate = ColorSequenceKeypoint.new(0.493, line.Library.config.Colors.AccentLight)
				local instance4 = ColorSequenceKeypoint.new
				local packed = 1
				local cacheKey = line.Library.config.Colors.Text
				local radians = ColorSequenceKeypoint.new(0.509, line.Library.config.Colors.AccentLight)
				sorted[1] = knob
				sorted[2] = currentDate
				sorted[3] = radians

				do
					local argumentPack = table.pack(instance4(packed, cacheKey))
					table.move(argumentPack, 1, argumentPack.n, 4, sorted)
				end

				players.Color = controller(sorted)
				players.Rotation = 260
				players.Parent = j
				bottomSnapZone("UIGradient", players)

				local data = createInstance("Frame", {
					Name = "Shine",
					BackgroundColor3 = line.Library.config.Colors.AccentLight,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 8, 1, 0),
					Position = UDim2.new(-0.001, 0, 0, 0),
					ZIndex = 3,
					Rotation = -15,
					Parent = sourceTable.mainFrame,
				})

				local angleRadians = createInstance
				local neighbors = { Name = "UIGradient", Rotation = 180 }
				local targetTransparency = NumberSequence.new
				local sample = {}
				local track = NumberSequenceKeypoint.new(0, 1)
				local vertexCount = NumberSequenceKeypoint.new(0.5, 0.4)
				sample[1] = track
				sample[2] = vertexCount

				do
					local argumentPack = table.pack(NumberSequenceKeypoint.new(1, 1))
					table.move(argumentPack, 1, argumentPack.n, 3, sample)
				end

				neighbors.Transparency = targetTransparency(sample)
				neighbors.Parent = data
				angleRadians("UIGradient", neighbors)
				local elapsedTime = 8

				if object.Icon then
					createInstance("ImageLabel", {
						Name = "ButtonIcon",
						ImageColor3 = sourceTable.isLocked and line.Library.config.Colors.Muted or line.Library.config.Colors.SubText,
						BackgroundColor3 = line.Library.config.Colors.White,
						Image = object.Icon,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 8, 0.5, -8),
						BorderColor3 = line.Library.config.Colors.Black,
						BorderSizePixel = 0,
						Size = UDim2.new(0, 30, 0, 16),
						Parent = sourceTable.mainFrame,
					})

					elapsedTime = 30
				end

				sourceTable.labelText = createInstance("TextLabel", {
					Name = "ButtonLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = sourceTable.isLocked and line.Library.config.Colors.Muted or line.Library.config.Colors.SubText,
					Text = object.Name .. (sourceTable.isLocked and " (locked)" or ""),
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, elapsedTime, 0, 0),
					BorderSizePixel = 0,
					BorderColor3 = line.Library.config.Colors.Black,
					TextSize = 14,
					Size = UDim2.new(1, -elapsedTime - 10, 1, 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sourceTable.mainFrame,
				})

				local button = createInstance("TextButton", {
					Name = "ButtonClickButton",
					Text = "",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = sourceTable.mainFrame,
				})

				local top = false

				local function mainLoop()
					if top then
						return
					end
					top = true
					data.Position = UDim2.new(-0.1, 0, 0, 0)
					data.BackgroundTransparency = 0.2
					tweenInstance(data, { Position = UDim2.new(1.2, 0, 0, 0), BackgroundTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

					task.delay(0.35, function()
							top = false
						end)
				end

				button.MouseButton1Down:Connect(function()
						if not sourceTable.isLocked then
							tweenInstance(sourceTable.mainFrame, { Size = UDim2.new(0, 228.48, 0, 23.92) }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							tweenInstance(coroutineHandle, { CornerRadius = UDim.new(0, 8) }, 0.001)
							mainLoop()
						end
					end)

				button.MouseButton1Up:Connect(function()
						if not sourceTable.isLocked then
							tweenInstance(sourceTable.mainFrame, { Size = targetSize }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
							tweenInstance(coroutineHandle, { CornerRadius = UDim.new(0, 6) }, 0.3)
							object.Callback()
						end
					end)

				button.MouseLeave:Connect(function()
						if not sourceTable.isLocked then
							tweenInstance(sourceTable.mainFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.4, Enum.EasingStyle.Exponential)
							tweenInstance(sourceTable.mainFrame, { Size = targetSize }, 0.3, Enum.EasingStyle.Exponential)
							tweenInstance(coroutineHandle, { CornerRadius = UDim.new(0, 6) }, 0.3)
						end
					end)

				button.MouseEnter:Connect(function()
						if not sourceTable.isLocked then
							tweenInstance(sourceTable.mainFrame, { BackgroundColor3 = line.Library.config.Colors.ElementHover }, 0.2, Enum.EasingStyle.Exponential)
						end
					end)

				line.elementYPos = line.elementYPos + 32
				success10()
				table.insert(line.elementsInGroup, sourceTable)
				return sourceTable
			end

			local function exampleUsage(line, object)
				local bottomSnapZone = obj[line]
				local player23 = bottomSnapZone.TabConfig
				local player4 = bottomSnapZone.GroupConfig
				local success10 = bottomSnapZone.UpdateSize
				object = object or {}
				object.Name = object.Name or "Keybind"
				object.Default = object.Default or Enum.KeyCode.Unknown

				object.Callback = object.Callback or function()
				end

				object.ChangedCallback = object.ChangedCallback or function()
				end

				local sourceTable = {}
				local knob = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.Name)
				local currentDate = safeIndex(configData.Keybinds, knob, object.NoSave)

				if currentDate then
					local success7 = keybindRegistry.Resolve
					currentDate = success7(type(currentDate) == "table" and currentDate.Key or currentDate)
				end

				sourceTable.value = currentDate or object.Default
				sourceTable.isListening = false
				sourceTable.SaveId = knob
				sourceTable.DefaultValue = object.Default
				keybindRegistry.SetMeta(knob, { Group = "keybinds", Name = object.Name })
				local config = line.elementYPos

				sourceTable.labelText = createInstance("TextLabel", {
					Name = "KeybindLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = object.Name,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, config),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(0, 120, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrame,
				})

				local query = sourceTable.value == Enum.KeyCode.Unknown and "None" or keybindRegistry.Display(sourceTable.value)
				local elapsedTime = measureTextWidth(query, 14) + 26

				sourceTable.buttonFrame = createInstance("Frame", {
					Name = "KeybindButton",
					BackgroundColor3 = line.Library.config.Colors.Element,
					Position = UDim2.new(1, -elapsedTime - 10, 0, config),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, elapsedTime, 0, 21),
					Parent = line.mainFrame,
				})

				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sourceTable.buttonFrame })
				local j = createInstance("UIStroke", { Name = "UIStroke", Color = line.Library.config.Colors.BorderSoft, Parent = sourceTable.buttonFrame })
				local packed = createInstance
				local players = { Name = "UIGradient" }
				local controller = ColorSequence.new
				local sorted = {}
				local radians = ColorSequenceKeypoint.new(0, line.Library.config.Colors.Text)
				local angleRadians = ColorSequenceKeypoint.new(0.493, line.Library.config.Colors.AccentLight)
				local track = ColorSequenceKeypoint.new(0.509, line.Library.config.Colors.AccentLight)
				sorted[1] = radians
				sorted[2] = angleRadians
				sorted[3] = track

				do
					local argumentPack = table.pack(ColorSequenceKeypoint.new(1, line.Library.config.Colors.Text))
					table.move(argumentPack, 1, argumentPack.n, 4, sorted)
				end

				players.Color = controller(sorted)
				players.Rotation = 260
				players.Parent = j
				packed("UIGradient", players)

				sourceTable.keyLabelText = createInstance("TextLabel", {
					Name = "KeyLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = query,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 12,
					Size = UDim2.new(1, -20, 1, 0),
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = sourceTable.buttonFrame,
				})

				sourceTable.keyboardIconImg = createInstance("ImageLabel", {
					Name = "KeyboardIcon",
					ImageColor3 = line.Library.config.Colors.Muted,
					BackgroundColor3 = line.Library.config.Colors.White,
					Image = "rbxassetid://10723416765",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -18, 0.5, -7),
					BorderColor3 = Color3.new(),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 14, 0, 14),
					Parent = sourceTable.buttonFrame,
				})

				createInstance("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = sourceTable.keyboardIconImg })

				local button = createInstance("TextButton", {
					Name = "KeybindClickButton",
					Text = "",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Parent = sourceTable.buttonFrame,
				})

				local function mainLoop(descendant)
					local difference = measureTextWidth(descendant, 14) + 26
					tweenInstance(sourceTable.buttonFrame, { Size = UDim2.new(0, difference, 0, 21), Position = UDim2.new(1, -difference - 10, 0, config) }, 0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				end

				sourceTable.Set = function(descendant, player29)
					sourceTable.value = player29
					local cacheKey = player29 == Enum.KeyCode.Unknown and "None" or keybindRegistry.Display(player29)
					sourceTable.keyLabelText.Text = cacheKey
					mainLoop(cacheKey)

					if not object.NoSave then
						configData.Keybinds[knob] = player29 == Enum.KeyCode.Unknown and nil or player29.Name
						saveConfig()
					end

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end

					object.ChangedCallback(player29)
				end

				button.InputBegan:Connect(function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							sourceTable.isListening = true
							sourceTable.keyLabelText.Text = "None"
							mainLoop("None")
							tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.ElementHover }, 0.4)
							tweenInstance(j, { Color = line.Library.config.Colors.Border }, 0.4)
							tweenInstance(sourceTable.keyLabelText, { TextColor3 = line.Library.config.Colors.TextHover }, 0.2)
							tweenInstance(sourceTable.keyboardIconImg, { ImageColor3 = line.Library.config.Colors.TextHover }, 0.4)
						end
					end)

				trackConnection(userInputService.InputBegan:Connect(function(inputObject, vectorB)
						local top = inputObject.UserInputType == Enum.UserInputType.Keyboard or inputObject.UserInputType == Enum.UserInputType.MouseButton3

						if sourceTable.isListening then
							if not top then
								return
							end
							sourceTable.isListening = false
							sourceTable:Set(inputObject.UserInputType == Enum.UserInputType.Keyboard and inputObject.KeyCode or inputObject.UserInputType)
							tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.4)
							tweenInstance(j, { Color = line.Library.config.Colors.BorderSoft }, 0.2)
							tweenInstance(sourceTable.keyLabelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.4)
							tweenInstance(sourceTable.keyboardIconImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.2)
							return
						end

						if vectorB or not top then
							return
						end

						if (inputObject.UserInputType == Enum.UserInputType.Keyboard and inputObject.KeyCode or inputObject.UserInputType) == sourceTable.value then
							object.Callback()
						end
					end))

				button.MouseEnter:Connect(function()
						if not sourceTable.isListening then
							tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.ElementHover }, 0.4)
							tweenInstance(j, { Color = line.Library.config.Colors.Border }, 0.4)
							tweenInstance(sourceTable.keyLabelText, { TextColor3 = line.Library.config.Colors.TextHover }, 0.4)
							tweenInstance(sourceTable.keyboardIconImg, { ImageColor3 = line.Library.config.Colors.TextHover }, 0.4)
						end
					end)

				button.MouseLeave:Connect(function()
						if not sourceTable.isListening then
							tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.4)
							tweenInstance(j, { Color = line.Library.config.Colors.BorderSoft }, 0.4)
							tweenInstance(sourceTable.keyLabelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.4)
							tweenInstance(sourceTable.keyboardIconImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.4)
						end
					end)

				line.elementYPos = line.elementYPos + 28
				success10()
				object.ChangedCallback(sourceTable.value)
				table.insert(line.elementsInGroup, sourceTable)
				return sourceTable
			end

			local function safeExecute(line, object)
				local bottomSnapZone = obj[line]
				local player23 = bottomSnapZone.TabConfig
				local player4 = bottomSnapZone.GroupConfig
				local success10 = bottomSnapZone.UpdateSize
				local playerPosition = bottomSnapZone.CreateKeybindPill
				object = object or {}
				object.Name = object.Name or "Dropdown"
				object.Options = object.Options or { "Option 1", "Option 2", "Option 3" }
				object.Default = object.Default or object.Options[1]

				object.Callback = object.Callback or function()
				end

				object.OnOpen = object.OnOpen or function()
				end

				local sourceTable = {}
				local prefix = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.Name)
				local knob = safeIndex(configData.Dropdowns, prefix, object.NoSave)
				sourceTable.value = object.Default

				for _, encodedString in pairs(object.Options) do
					if knob == encodedString then
						sourceTable.value = knob
						break
					end
				end

				sourceTable.SaveId = prefix
				sourceTable.DefaultValue = object.Default
				sourceTable.isOpen = false
				local query = "dropdown:" .. prefix

				local function mainLoop(descendant)
					return query .. ":" .. descendant
				end

				local config = line.elementYPos

				local function onInputBegan()
					local elapsedTime = measureTextWidth(object.Name, 14, Enum.Font.GothamSemibold) + 8
					local difference = math.max(40, math.min(116, line.mainFrame.Size.X.Offset - elapsedTime - 28))

					if difference < 40 then
						difference = 40
						elapsedTime = 172
					end

					local currentDate = truncateTextToWidth(sourceTable.value or "None", difference - 32, 14, Enum.Font.GothamSemibold)
					return currentDate, elapsedTime, (math.clamp(measureTextWidth(currentDate, 14, Enum.Font.GothamSemibold) + 35, 40, difference))
				end

				local currentDate, packed, radians = onInputBegan()

				sourceTable.labelText = createInstance("TextLabel", {
					Name = "DropdownLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = object.Name,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, config),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(0, packed, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Parent = line.mainFrame,
				})

				local function handlePlayerAdded()
					local startX = 130
					for _, token in ipairs(object.Options) do
						local WeaponBase = keybindRegistry.Get(mainLoop(token))
						local index28 = WeaponBase == Enum.KeyCode.Unknown and "" or keybindRegistry.Display(WeaponBase)
						local index45 = measureTextWidth(index28, 11, Enum.Font.GothamSemibold) + 24

						startX = math.max(startX, measureTextWidth(token, 14, Enum.Font.GothamSemibold) + index45 + 70)
					end
					return math.ceil(startX)
				end

				local function initialize(descendant, radius)
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
					local targetSize = UDim2.new(0, radius, 0, 21)
					local players = { Size = targetSize }

					if not sourceTable.detached then
						players.Position = UDim2.new(1, -radius - 10, 0, config)
					end

					if sourceTable.dockFrame then
						sourceTable.dockFrame.Size = targetSize
						sourceTable.dockFrame.Position = UDim2.new(1, -radius - 10, 0, config)
					end

					tweenInstance(sourceTable.labelText, { Size = UDim2.new(0, descendant, 0, 20) }, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
					tweenInstance(sourceTable.buttonFrame, players, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

					if sourceTable.isOpen then
						local point = sourceTable.buttonFrame.AbsolutePosition
						tweenInstance(sourceTable.optionHolderFrame, { Position = UDim2.new(0, point.X / currentScale, 0, (point.Y + sourceTable.buttonFrame.AbsoluteSize.Y + 10) / currentScale) }, 0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
					end
				end

				local function serializeTable(player29)
					local itemValue = sourceTable.value
					sourceTable.value = player29
					local angleRadians, track, vertexCount = onInputBegan()
					sourceTable.selectedLabelText.Text = angleRadians
					initialize(track, vertexCount)

					for _, child in pairs(sourceTable.optionContainerFrame:GetChildren()) do
						if child:IsA("TextButton") then
							local callbackFunction = child:GetAttribute("OptionValue")

							if callbackFunction == player29 or callbackFunction == itemValue then
								local steering = child:FindFirstChild("OptionLabel")
								local major = child:FindFirstChild("OptionCheck")
								local top = callbackFunction == player29

								if steering then
									tweenInstance(steering, {
										TextColor3 = top and line.Library.config.Colors.AccentLight or line.Library.config.Colors.SubText,
									}, 0.2)
								end

								if major then
									tweenInstance(major, {
										Position = top and UDim2.new(1, -4, 0.5, 0) or UDim2.new(1, 30, 0.5, 0),
									}, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
								end
							end
						end
					end

					if not object.NoSave then
						configData.Dropdowns[prefix] = player29
						saveConfig()
					end

					object.Callback(player29)

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end
				end

				local angleRadians = handlePlayerAdded()
				sourceTable.holderWidth = angleRadians

				sourceTable.buttonFrame = createInstance("Frame", {
					Name = "DropdownButton",
					Active = true,
					BackgroundColor3 = line.Library.config.Colors.Element,
					Position = UDim2.new(1, -radians - 10, 0, config),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, radians, 0, 21),
					Parent = line.mainFrame,
				})

				if object.Detachable then
					sourceTable.dockFrame = createInstance("Frame", {
						Name = "DropdownDock",
						BackgroundTransparency = 1,
						Position = sourceTable.buttonFrame.Position,
						Size = sourceTable.buttonFrame.Size,
						Parent = line.mainFrame,
					})

					createInstance("UICorner", { CornerRadius = UDim.new(0, 8), Parent = sourceTable.dockFrame })

					sourceTable.dockStroke = createInstance("UIStroke", {
						Color = line.Library.config.Colors.AccentLight,
						Thickness = 1.5,
						Transparency = 1,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Parent = sourceTable.dockFrame,
					})
				end

				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 8), Parent = sourceTable.buttonFrame })
				local j = createInstance("UIStroke", { Name = "UIStroke", Enabled = false, Color = line.Library.config.Colors.BorderSoft, Parent = sourceTable.buttonFrame })

				sourceTable.selectedLabelText = createInstance("TextLabel", {
					Name = "SelectedLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = currentDate,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 0),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(1, -28, 1, 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Parent = sourceTable.buttonFrame,
				})

				sourceTable.arrowImg = createInstance("ImageLabel", {
					Name = "DropdownArrow",
					ImageColor3 = line.Library.config.Colors.Muted,
					BackgroundColor3 = line.Library.config.Colors.White,
					Image = "rbxassetid://127296511745226",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -18, 0.5, -7),
					BorderColor3 = Color3.new(),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 14, 0, 14),
					Parent = sourceTable.buttonFrame,
				})

				createInstance("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = sourceTable.arrowImg })
				local top = not object.NoSearch and #object.Options >= 8
				local elapsedTime = top and 30 or 0

				sourceTable.optionHolderFrame = createInstance("Frame", {
					Name = "DropdownOptionHolder",
					Active = true,
					BackgroundColor3 = line.Library.config.Colors.Element,
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, angleRadians, 0, 0),
					ClipsDescendants = true,
					Visible = false,
					ZIndex = 9999,
					Parent = line.Library.dropdownHolderRef,
				})

				table.insert(line.Library.dropdownFrames, sourceTable.optionHolderFrame)
				sourceTable.holderScale = createInstance("UIScale", { Name = "DropdownHolderScale", Scale = 0.8, Parent = sourceTable.optionHolderFrame })
				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 8), Parent = sourceTable.optionHolderFrame })
				createInstance("UIStroke", { Name = "UIStroke", Color = line.Library.config.Colors.BorderSoft, Parent = sourceTable.optionHolderFrame })
				local concatenated = ""

				if top then
					local data = createInstance("Frame", {
						Name = "SearchFrame",
						BackgroundColor3 = line.Library.config.Colors.Element,
						BackgroundTransparency = 0,
						Position = UDim2.new(0, 8, 0, 10),
						Size = UDim2.new(1, -16, 0, 24),
						BorderSizePixel = 0,
						ZIndex = 10005,
						Parent = sourceTable.optionHolderFrame,
					})

					createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = data })

					createInstance("UIStroke", {
						Name = "SearchStroke",
						Color = line.Library.config.Colors.BorderSoft,
						Thickness = 1,
						Parent = data,
					})

					createInstance("ImageLabel", {
						Name = "DropdownSearchIcon",
						Image = "rbxassetid://117707949657765",
						ImageColor3 = line.Library.config.Colors.Muted,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 6, 0.5, -6),
						Size = UDim2.new(0, 12, 0, 14),
						ZIndex = 10006,
						Parent = data,
					})

					sourceTable.searchBox = createInstance("TextBox", {
						Name = "DropdownSearchBox",
						FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
						TextColor3 = line.Library.config.Colors.Text,
						PlaceholderText = "search...",
						PlaceholderColor3 = line.Library.config.Colors.Muted,
						Text = "",
						TextSize = 14,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 24, 0, 0),
						Size = UDim2.new(1, -30, 1, 0),
						TextXAlignment = Enum.TextXAlignment.Left,
						ClearTextOnFocus = false,
						ZIndex = 10006,
						Parent = data,
					})
				end

				sourceTable.optionContainerFrame = createInstance("ScrollingFrame", {
					Name = "DropdownOptions",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, top and elapsedTime + 4 or 0),
					Size = UDim2.new(1, 0, 1, top and -(elapsedTime + 4) or 0),
					ZIndex = 10000,
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = line.Library.config.Colors.Muted,
					ScrollBarImageTransparency = 0.5,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					Parent = sourceTable.optionHolderFrame,
				})

				createInstance("UIPadding", {
					Name = "DropdownPadding",
					PaddingTop = UDim.new(0, top and 4 or 8),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 14),
					Parent = sourceTable.optionContainerFrame,
				})

				createInstance("UIListLayout", {
					Name = "DropdownListLayout",
					Padding = UDim.new(0, 7),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = sourceTable.optionContainerFrame,
				})

				local function generateRandomPoints(descendant)
					for _, child in pairs(sourceTable.optionContainerFrame:GetChildren()) do
						if child:IsA("TextLabel") or child:IsA("TextButton") then
							child:Destroy()
						end
					end

					local players = {}

					if descendant and descendant ~= "" then
						local track = string.lower(descendant)

						for _, token in ipairs(object.Options) do
							if #players < 50 and string.find(string.lower(token), track, 1, true) then
								table.insert(players, token)
							end
						end
					else
						for k = 1, math.min(#object.Options, 50) do
							table.insert(players, object.Options[k])
						end
					end

					local difference = #object.Options
					local cell = difference > 50

					if cell then
						cell = not (descendant and descendant ~= "")
					end

					if cell then
						local openError = difference - 50

						createInstance("TextLabel", {
							Name = "TruncationHint",
							FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
							TextColor3 = line.Library.config.Colors.Muted,
							Text = "... and " .. openError .. " more (use search)",
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							TextSize = 11,
							Size = UDim2.new(1, 0, 0, 16),
							TextXAlignment = Enum.TextXAlignment.Left,
							ZIndex = 10000,
							LayoutOrder = 51,
							Parent = sourceTable.optionContainerFrame,
						})
					end

					for k, propertyName in ipairs(players) do
						local active = sourceTable.value == propertyName

						local button = createInstance("TextButton", {
							Name = "OptionClickButton",
							Text = "",
							AutoButtonColor = false,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0, 20),
							LayoutOrder = k,
							ZIndex = 10002,
							Parent = sourceTable.optionContainerFrame,
						})

						button:SetAttribute("OptionValue", propertyName)
						local vertexCount = mainLoop(propertyName)

						local textLabel = createInstance("TextLabel", {
							Name = "OptionLabel",
							FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
							TextColor3 = active and line.Library.config.Colors.AccentLight or line.Library.config.Colors.SubText,
							Text = propertyName,
							BackgroundColor3 = line.Library.config.Colors.White,
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 0, 0, 0),
							BorderSizePixel = 0,
							BorderColor3 = Color3.new(),
							TextSize = 14,
							Size = UDim2.new(1, -24, 1, 0),
							TextXAlignment = Enum.TextXAlignment.Left,
							TextTruncate = Enum.TextTruncate.None,
							ZIndex = 10000,
							Parent = button,
						})

						local index42 = 24
						local function lerp(radius)
							index42 = radius
							local maxY = math.max(textLabel.TextBounds.X, measureTextWidth(propertyName, 14, Enum.Font.GothamSemibold))
							local segmentCount = math.ceil(maxY + radius + 74)
							if segmentCount > sourceTable.holderWidth then
								sourceTable.holderWidth = segmentCount
								sourceTable.optionHolderFrame.Size = UDim2.new(0, segmentCount, 0, sourceTable.optionHolderFrame.Size.Y.Offset)
							end
							textLabel.Size = UDim2.new(1, -(radius + 44), 1, 0)
							return UDim2.new(1, -radius - 28, 0.5, -7)
						end
						textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
								lerp(index42)
							end)
						local steering = playerPosition(button, vertexCount, lerp, 15, 10004, nil, {
							Group = query,
							Name = propertyName,
							Parent = player4.Name,
							DisplayMode = "select",
							GetState = function()
								return sourceTable.value == propertyName
							end,
						})

						createInstance("ImageLabel", {
							Name = "OptionCheck",
							Image = "rbxassetid://114461119629011",
							ImageColor3 = line.Library.config.Colors.AccentLight,
							BackgroundTransparency = 1,
							AnchorPoint = Vector2.new(1, 0.5),
							Position = active and UDim2.new(1, -4, 0.5, 0) or UDim2.new(1, 30, 0.5, 0),
							Size = UDim2.new(0, 14, 0, 14),
							BorderSizePixel = 0,
							ZIndex = 10003,
							Parent = button,
						})

						button.MouseButton1Click:Connect(function()
								serializeTable(propertyName)
							end)

						button.InputBegan:Connect(function(inputObject)
								if inputObject.UserInputType == Enum.UserInputType.MouseButton2 and steering then
									steering:OpenMode(inputObject.Position)
								end
							end)

						button.MouseEnter:Connect(function()
								if not sourceTable.isOpen then
									return
								end

								if sourceTable.value ~= propertyName then
									tweenInstance(textLabel, { TextColor3 = line.Library.config.Colors.TextHover }, 0.2)
								end
							end)

						button.MouseLeave:Connect(function()
								if not sourceTable.isOpen then
									return
								end

								if sourceTable.value ~= propertyName then
									tweenInstance(textLabel, { TextColor3 = line.Library.config.Colors.SubText }, 0.2)
								end
							end)
					end
				end

				sourceTable.optionsBuilt = false

				if top and sourceTable.searchBox then
					sourceTable.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
							concatenated = string.lower(sourceTable.searchBox.Text)
							generateRandomPoints(concatenated ~= "" and concatenated or nil)
						end)
				end

				local track = createInstance("TextButton", {
					Name = "DropdownClickButton",
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 100,
					Parent = sourceTable.buttonFrame,
				})

				sourceTable.detached = false
				local currentPosition = nil
				local point = nil
				local vertexCount = nil
				local difference = nil
				local cell = false
				local active = false
				local isArray = nil
				local steering = nil

				local function initializeSystem(descendant, radius)
					local size = descendant.AbsolutePosition
					local screenSize = descendant.AbsoluteSize
					local startPosition = radius.AbsolutePosition
					local delta = radius.AbsoluteSize
					return size.X <= startPosition.X + delta.X and size.X + screenSize.X >= startPosition.X and size.Y <= startPosition.Y + delta.Y and size.Y + screenSize.Y >= startPosition.Y
				end

				local function addVectors(descendant)
					if not sourceTable.dockStroke then
						return
					end
					descendant = descendant and line.Library.isToggledOn == true
					if steering == descendant then
						return
					end
					steering = descendant
					tweenInstance(sourceTable.dockStroke, { Transparency = descendant and 0.1 or 1 }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				end

				local function calculateDistance()
					if sourceTable.detached then
						return
					end
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
					local size = sourceTable.buttonFrame.AbsolutePosition
					sourceTable.buttonFrame.Parent = line.Library.dropdownHolderRef
					sourceTable.buttonFrame.Position = UDim2.fromOffset(size.X / currentScale, size.Y / currentScale)
					sourceTable.detached = true

					if line.Library.detachedDropdowns then
						line.Library.detachedDropdowns[sourceTable] = true
					end
				end

				local function traverse(descendant)
					if not sourceTable.detached or isArray then
						return
					end
					isArray = true
					addVectors(false)
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
					local size = sourceTable.dockFrame.AbsolutePosition

					tweenInstance(sourceTable.buttonFrame, { Position = UDim2.fromOffset(size.X / currentScale, size.Y / currentScale) }, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out).Completed:Once(function()
							if not sourceTable.buttonFrame or not sourceTable.buttonFrame.Parent then
								return
							end
							sourceTable.buttonFrame.Parent = line.mainFrame
							sourceTable.buttonFrame.Position = sourceTable.dockFrame.Position
							sourceTable.buttonFrame.Visible = true
							sourceTable.detached = false

							if line.Library.detachedDropdowns then
								line.Library.detachedDropdowns[sourceTable] = nil
							end

							isArray = false

							if descendant then
								sourceTable:Close()
							end
						end)
				end

				if object.Detachable then
					track.InputBegan:Connect(function(inputObject)
							if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then
								return
							end
							currentPosition = inputObject.Position
							point = sourceTable.buttonFrame.AbsolutePosition
							vertexCount = inputObject
							difference = inputObject.UserInputType == Enum.UserInputType.Touch and 14 or 5
							cell = false
							active = false
						end)

					trackConnection(userInputService.InputChanged:Connect(function(inputObject)
							if not vertexCount or inputObject.UserInputType ~= Enum.UserInputType.MouseMovement and inputObject.UserInputType ~= Enum.UserInputType.Touch then
								return
							end

							if inputObject.UserInputType == Enum.UserInputType.Touch and inputObject ~= vertexCount then
								return
							end
							local openError = inputObject.Position - currentPosition
							if not cell and openError.Magnitude < difference then
								return
							end

							if not cell then
								cell = true
								active = true
								calculateDistance()
							end

							local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
							sourceTable.buttonFrame.Position = UDim2.fromOffset((point.X + openError.X) / currentScale, (point.Y + openError.Y) / currentScale)
							addVectors(initializeSystem(sourceTable.buttonFrame, sourceTable.dockFrame))
						end))

					trackConnection(userInputService.InputEnded:Connect(function(inputObject)
							if inputObject ~= vertexCount then
								return
							end
							vertexCount = nil
							if not cell then
								return
							end

							if line.Library.isToggledOn and initializeSystem(sourceTable.buttonFrame, sourceTable.dockFrame) then
								traverse(false)
							else
								addVectors(false)
							end
						end))
				end

				local function onHeartbeat()
					local size = sourceTable.buttonFrame.AbsolutePosition
					local screenSize = sourceTable.buttonFrame.AbsoluteSize
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
					tweenInstance(sourceTable.optionHolderFrame, { Position = UDim2.new(0, size.X / currentScale, 0, (size.Y + screenSize.Y + 10) / currentScale) }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				end

				sourceTable.followConn = nil
				sourceTable.outsideConn = nil

				local function clamp(descendant, radius)
					local size = descendant.AbsolutePosition
					local screenSize = descendant.AbsoluteSize
					return radius.X >= size.X and radius.X <= size.X + screenSize.X and radius.Y >= size.Y and radius.Y <= size.Y + screenSize.Y
				end

				sourceTable.Open = function()
					if sourceTable.isOpen then
						return
					end
					object.OnOpen()

					if not sourceTable.optionsBuilt then
						if not top then
							generateRandomPoints()
						end

						sourceTable.optionsBuilt = true
					end

					for vertex in pairs(line.Library.openDropdowns) do
						if vertex ~= sourceTable and vertex.Close then
							vertex:Close()
						end
					end

					sourceTable.isOpen = true
					sourceTable.optionHolderFrame.Parent = line.Library.dropdownHolderRef
					local size = sourceTable.buttonFrame.AbsolutePosition
					local screenSize = sourceTable.buttonFrame.AbsoluteSize
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1
					sourceTable.optionHolderFrame.Position = UDim2.new(0, size.X / currentScale, 0, (size.Y + screenSize.Y) / currentScale)
					sourceTable.optionHolderFrame.Size = UDim2.new(0, sourceTable.holderWidth, 0, 0)
					sourceTable.optionHolderFrame.Visible = true
					sourceTable.holderScale.Scale = 0.9
					local openError = math.min(#object.Options, 50)
					local step = math.min(16 + openError * 20 + math.max(openError - 1, 0) * 7 + (top and elapsedTime + 4 or 0), 300)

					if top and sourceTable.searchBox then
						sourceTable.searchBox.Text = ""
						concatenated = ""
						generateRandomPoints()
					end

					tweenInstance(sourceTable.optionHolderFrame, {
						Position = UDim2.new(0, size.X / currentScale, 0, (size.Y + screenSize.Y + 10) / currentScale),
						Size = UDim2.new(0, sourceTable.holderWidth, 0, step),
					}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					tweenInstance(sourceTable.holderScale, { Scale = 1 }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					tweenInstance(sourceTable.arrowImg, { Rotation = -180 }, 0.25)

					if sourceTable.followConn then
						sourceTable.followConn:Disconnect()
					end

					sourceTable.followConn = sourceTable.buttonFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(onHeartbeat)
					disconnectTrackedConnection(sourceTable.outsideConn)

					sourceTable.outsideConn = trackConnection(userInputService.InputBegan:Connect(function(inputObject)
							if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then
								return
							end

							if not sourceTable.isOpen then
								return
							end

							if sourceTable.detached then
								return
							end

							if clamp(sourceTable.buttonFrame, inputObject.Position) or clamp(sourceTable.optionHolderFrame, inputObject.Position) then
								return
							end
							sourceTable:Close()
						end))

					line.Library.openDropdowns[sourceTable] = sourceTable
				end

				sourceTable.Close = function()
					if not sourceTable.isOpen then
						return
					end
					sourceTable.isOpen = false
					local size = sourceTable.buttonFrame.AbsolutePosition
					local screenSize = sourceTable.buttonFrame.AbsoluteSize
					local currentScale = line.Library.dropdownHolderScale and line.Library.dropdownHolderScale.Scale or 1

					tweenInstance(sourceTable.optionHolderFrame, {
						Position = UDim2.new(0, size.X / currentScale, 0, (size.Y + screenSize.Y - 10) / currentScale),
						Size = UDim2.new(0, sourceTable.holderWidth, 0, 0),
					}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					tweenInstance(sourceTable.holderScale, { Scale = 0.8 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(sourceTable.arrowImg, { Rotation = 0 }, 0.3)

					if sourceTable.followConn then
						sourceTable.followConn:Disconnect()
						sourceTable.followConn = nil
					end

					if sourceTable.outsideConn then
						disconnectTrackedConnection(sourceTable.outsideConn)
						sourceTable.outsideConn = nil
					end

					line.Library.openDropdowns[sourceTable] = nil

					task.delay(0.3, function()
							if not sourceTable.isOpen and sourceTable.optionHolderFrame then
								sourceTable.optionHolderFrame.Visible = false
								sourceTable.optionHolderFrame.Parent = nil
							end
						end)

					tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.2)
					tweenInstance(j, { Color = line.Library.config.Colors.BorderSoft }, 0.2)
					tweenInstance(sourceTable.selectedLabelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.2)
					tweenInstance(sourceTable.arrowImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.2)
				end

				track.MouseButton1Click:Connect(function()
						if active then
							return
						end

						if sourceTable.isOpen then
							sourceTable:Close()
						else
							sourceTable:Open()
						end
					end)

				track.MouseEnter:Connect(function()
						tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.ElementHover }, 0.2)
						tweenInstance(j, { Color = line.Library.config.Colors.Border }, 0.2)
						tweenInstance(sourceTable.selectedLabelText, { TextColor3 = line.Library.config.Colors.TextHover }, 0.2)
						tweenInstance(sourceTable.arrowImg, { ImageColor3 = line.Library.config.Colors.TextHover }, 0.2)
					end)

				track.MouseLeave:Connect(function()
						if sourceTable.isOpen then
							return
						end
						tweenInstance(sourceTable.buttonFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.2)
						tweenInstance(j, { Color = line.Library.config.Colors.BorderSoft }, 0.2)
						tweenInstance(sourceTable.selectedLabelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.2)
						tweenInstance(sourceTable.arrowImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.2)
					end)

				sourceTable.Set = function(descendant, player29)
					local bestLabel = nil

					for _, weld in pairs(object.Options) do
						if player29 == weld then
							bestLabel = true
							break
						else
							bestLabel = nil
						end
					end

					player29 = bestLabel and player29 or object.Default
					local itemValue = sourceTable.value
					sourceTable.value = player29
					local major, byte, result68 = onInputBegan()
					sourceTable.selectedLabelText.Text = major
					initialize(byte, result68)

					for _, child in pairs(sourceTable.optionContainerFrame:GetChildren()) do
						if child:IsA("TextButton") then
							local callbackFunction = child:GetAttribute("OptionValue")

							if callbackFunction == player29 or callbackFunction == itemValue then
								local net = child:FindFirstChild("OptionLabel")
								local result31 = child:FindFirstChild("OptionCheck")
								local bestPair = callbackFunction == sourceTable.value

								if net then
									net.TextColor3 = bestPair and line.Library.config.Colors.AccentLight or line.Library.config.Colors.SubText
								end

								if result31 then
									result31.Position = bestPair and UDim2.new(1, -4, 0.5, 0) or UDim2.new(1, 30, 0.5, 0)
								end
							end
						end
					end

					if not object.NoSave then
						configData.Dropdowns[prefix] = player29
						saveConfig()
					end

					object.Callback(player29)

					local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
					if type(deferredFunction) == "function" then
						task.defer(deferredFunction)
					end
				end

				sourceTable.Refresh = function(descendant, origin)
					object.Options = origin
					sourceTable.optionsBuilt = true
					sourceTable.holderWidth = handlePlayerAdded()
					local major, byte, result68 = onInputBegan()
					sourceTable.selectedLabelText.Text = major
					initialize(byte, result68)
					sourceTable.optionHolderFrame.Size = UDim2.new(0, sourceTable.holderWidth, 0, sourceTable.optionHolderFrame.Size.Y.Offset)
					generateRandomPoints()
				end

				sourceTable:Set(sourceTable.value)
				sourceTable.optionHolderFrame.Parent = nil
				local yString = nil

				for _, token in ipairs(object.Options) do
					local major = mainLoop(token)

					keybindRegistry.SetMeta(major, {
						Group = query,
						Name = token,
						Parent = player4.Name,
						DisplayMode = "select",
						GetState = function()
							return sourceTable.value == token
						end,
					})

					keybindRegistry.Register(major, function(descendant, radius)
							if radius == "Hold" then
								if descendant then
									yString = sourceTable.value
									serializeTable(token)
									return
								end

								if yString and yString ~= token then
									serializeTable(yString)
								end

								yString = nil
								return
							end

							if descendant then
								serializeTable(token)
							end
						end)
				end

				line.elementYPos = line.elementYPos + 28
				success10()
				table.insert(line.elementsInGroup, sourceTable)
				return sourceTable
			end

			local function createVector3(line, object)
				local bottomSnapZone = obj[line]
				local player23 = bottomSnapZone.TabConfig
				local player4 = bottomSnapZone.GroupConfig
				local success10 = bottomSnapZone.UpdateSize
				object = object or {}
				object.Name = object.Name or "Textbox"
				object.Placeholder = object.Placeholder or ""
				object.Default = object.Default or ""

				object.Callback = object.Callback or function()
				end

				local sourceTable = {}
				local knob = normalizeConfigKey(object.SaveId or player23.Name .. ":" .. player4.Name .. ":" .. object.Name)
				local currentDate = safeIndex(configData.Textboxes, knob, object.NoSave)
				sourceTable.value = type(currentDate) == "string" and currentDate or object.Default
				sourceTable.SaveId = knob
				sourceTable.DefaultValue = object.Default
				local config = line.elementYPos

				sourceTable.labelText = createInstance("TextLabel", {
					Name = "TextboxLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = object.Name,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, config),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(0, 130, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrame,
				})

				sourceTable.inputFrame = createInstance("Frame", {
					Name = "TextboxInputFrame",
					BackgroundColor3 = line.Library.config.Colors.Element,
					Position = UDim2.new(0, 10, 0, config + 22),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, 238, 0, 26),
					Parent = line.mainFrame,
				})

				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = sourceTable.inputFrame })
				local radians = createInstance("UIStroke", { Name = "UIStroke", Color = line.Library.config.Colors.BorderSoft, Parent = sourceTable.inputFrame })
				local angleRadians = createInstance
				local players = { Name = "UIGradient" }
				local controller = ColorSequence.new
				local sorted = {}
				local track = ColorSequenceKeypoint.new(0, line.Library.config.Colors.Text)
				local vertexCount = ColorSequenceKeypoint.new(0.493, line.Library.config.Colors.AccentLight)
				local steering = ColorSequenceKeypoint.new(0.509, line.Library.config.Colors.AccentLight)
				sorted[1] = track
				sorted[2] = vertexCount
				sorted[3] = steering

				do
					local argumentPack = table.pack(ColorSequenceKeypoint.new(1, line.Library.config.Colors.Text))
					table.move(argumentPack, 1, argumentPack.n, 4, sorted)
				end

				players.Color = controller(sorted)
				players.Rotation = 260
				players.Parent = radians
				angleRadians("UIGradient", players)

				sourceTable.textbox = createInstance("TextBox", {
					Name = "TextboxInput",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.Text,
					PlaceholderColor3 = line.Library.config.Colors.SubText,
					Text = sourceTable.value,
					PlaceholderText = object.Placeholder,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 0),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(1, -30, 1, 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					ClearTextOnFocus = false,
					TextEditable = true,
					Parent = sourceTable.inputFrame,
				})

				sourceTable.Set = function(descendant, radius)
					sourceTable.value = tostring(radius or "")
					sourceTable.textbox.Text = sourceTable.value

					if not object.NoSave then
						configData.Textboxes[knob] = sourceTable.value
						saveConfig()
					end

					object.Callback(sourceTable.value)
				end

				local neighbors = {}

				local function mainLoop()
					local checkpointFolder = sourceTable.textbox.Parent

					while checkpointFolder and checkpointFolder ~= game do
						if checkpointFolder:IsA("ScrollingFrame") and checkpointFolder.ScrollingEnabled then
							checkpointFolder.ScrollingEnabled = false
							table.insert(neighbors, checkpointFolder)
						end

						checkpointFolder = checkpointFolder.Parent
					end
				end

				local function onInputBegan()
					for _, weld in ipairs(neighbors) do
						if weld and weld.Parent then
							weld.ScrollingEnabled = true
						end
					end

					table.clear(neighbors)
				end

				local top = false
				local major = nil
				local byte = nil
				local connection = nil

				local function handlePlayerAdded(descendant)
					local statusLabel = sourceTable.textbox
					local cacheKey = statusLabel.Text
					local speed = statusLabel.CursorPosition
					local deletion = statusLabel.SelectionStart

					if deletion and deletion > 0 and speed and speed > 0 and deletion ~= speed then
						local newHealth = math.min(deletion, speed)
						local result68 = 1
						local elapsedTime = math.max(deletion, speed) - result68
						statusLabel.Text = cacheKey:sub(1, newHealth - 1) .. cacheKey:sub(elapsedTime + 1)
						statusLabel.CursorPosition = newHealth
						statusLabel.SelectionStart = newHealth
						return
					end

					if not speed or speed <= 1 then
						return
					end
					local newHealth = math.max(1, speed - descendant)
					statusLabel.Text = cacheKey:sub(1, newHealth - 1) .. cacheKey:sub(speed - 1 + 1)
					statusLabel.CursorPosition = newHealth
					statusLabel.SelectionStart = newHealth
				end

				local function initialize()
					local cell = top

					if not top then
						local statusLabel = sourceTable.textbox
						cell = userInputService:GetFocusedTextBox() ~= statusLabel
					end

					if cell then
						return
					end
					top = true

					task.spawn(function()
							task.wait(0.35)
							local osClock = os.clock()

							while true do
								local active = top

								if top then
									local statusLabel = sourceTable.textbox
									active = userInputService:GetFocusedTextBox() == statusLabel
								end

								if active then
									local elapsedTime = os.clock() - osClock
									local difference = math.clamp(math.floor(elapsedTime * elapsedTime * 10) + 1, 1, 90)
									handlePlayerAdded(difference)
									task.wait(math.max(0.03, 0.08 - elapsedTime * 0.01))
									continue
								end

								break
							end
						end)
				end

				local function serializeTable()
					top = false
				end

				local function generateRandomPoints()
					disconnectTrackedConnection(major)
					disconnectTrackedConnection(byte)

					if connection then
						connection:Disconnect()
					end

					major = trackConnection(userInputService.InputBegan:Connect(function(inputObject)
							local cell = inputObject.KeyCode == Enum.KeyCode.Backspace

							if cell then
								local statusLabel = sourceTable.textbox
								cell = userInputService:GetFocusedTextBox() == statusLabel
							end

							if cell then
								initialize()
							end
						end))

					byte = trackConnection(userInputService.InputEnded:Connect(function(inputObject)
							if inputObject.KeyCode == Enum.KeyCode.Backspace then
								serializeTable()
							end
						end))

					connection = sourceTable.textbox:GetPropertyChangedSignal("Text"):Connect(function()
							local statusLabel = sourceTable.textbox

							if userInputService:GetFocusedTextBox() == statusLabel and userInputService:IsKeyDown(Enum.KeyCode.Backspace) then
								initialize()
							end
						end)
				end

				local function initializeSystem()
					serializeTable()
					disconnectTrackedConnection(major)
					major = nil
					disconnectTrackedConnection(byte)
					byte = nil

					if connection then
						connection:Disconnect()
						connection = nil
					end
				end

				sourceTable.textbox.Focused:Connect(function()
						mainLoop()
						generateRandomPoints()

						if touchEnabled then
							task.defer(function()
								local statusLabel = sourceTable.textbox

								if userInputService:GetFocusedTextBox() == statusLabel then
									sourceTable.textbox.CursorPosition = #sourceTable.textbox.Text + 1
									sourceTable.textbox.SelectionStart = 1
								end
							end)
						end

						tweenInstance(sourceTable.inputFrame, { BackgroundColor3 = line.Library.config.Colors.ElementHover }, 0.2)
						tweenInstance(radians, { Color = line.Library.config.Colors.Border }, 0.2)
						tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.Text }, 0.2)
						tweenInstance(sourceTable.textbox, { TextColor3 = line.Library.config.Colors.Text }, 0.2)
					end)

				sourceTable.textbox.FocusLost:Connect(function()
						initializeSystem()
						onInputBegan()
						sourceTable.value = sourceTable.textbox.Text
						tweenInstance(sourceTable.inputFrame, { BackgroundColor3 = line.Library.config.Colors.Element }, 0.2)
						tweenInstance(radians, { Color = line.Library.config.Colors.BorderSoft }, 0.2)
						tweenInstance(sourceTable.labelText, { TextColor3 = line.Library.config.Colors.SubText }, 0.2)
						tweenInstance(sourceTable.textbox, { TextColor3 = line.Library.config.Colors.Text }, 0.2)

						if not object.NoSave then
							configData.Textboxes[knob] = sourceTable.value
							saveConfig()
						end

						object.Callback(sourceTable.value)
					end)

				object.Callback(sourceTable.value)
				line.elementYPos = line.elementYPos + 56
				success10()
				table.insert(line.elementsInGroup, sourceTable)
				return sourceTable
			end

			local function onPlayerAdded(line)
				local success10 = obj[line].UpdateSize

				local data = createInstance("Frame", {
					Name = "Divider",
					BackgroundColor3 = line.Library.config.Colors.BorderSoft,
					BackgroundTransparency = 0.4,
					Position = UDim2.new(0, 14, 0, line.elementYPos + 6),
					BorderSizePixel = 0,
					Size = UDim2.new(1, -28, 0, 1),
					Parent = line.mainFrame,
				})

				line.elementYPos = line.elementYPos + 14
				success10()
				return data
			end

			local function onCharacterAdded(line, object)
				local success10 = obj[line].UpdateSize
				object = object or "Section"
				local elapsedTime = line.elementYPos + 10

				local bottomSnapZone = createInstance("Frame", {
					Name = "SectionAccentBar",
					BackgroundColor3 = line.Library.config.AccentColor,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, elapsedTime + 4),
					Size = UDim2.new(0, 2, 0, 14),
					Parent = line.mainFrame,
				})

				createInstance("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bottomSnapZone })

				createInstance("UIGradient", {
					Name = "SectionAccentGradient",
					Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, line.Library.config.AccentColor),
					ColorSequenceKeypoint.new(1, line.Library.config.Colors.AccentLight),
				}),
					Rotation = 90,
					Parent = bottomSnapZone,
				})

				createInstance("TextLabel", {
					Name = "SectionLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.Text,
					Text = object,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 18, 0, elapsedTime),
					BorderSizePixel = 0,
					TextSize = 14,
					Size = UDim2.new(1, -30, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrame,
				})

				createInstance("Frame", {
					Name = "SectionDivider",
					BackgroundColor3 = line.Library.config.Colors.BorderSoft,
					BackgroundTransparency = 0.5,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 18, 0, elapsedTime + 26),
					Size = UDim2.new(1, -36, 0, 1),
					Parent = line.mainFrame,
				})

				line.elementYPos = elapsedTime + 30
				success10()
			end

			local function safeCall(line, object)
				local success10 = obj[line].UpdateSize
				object = object or {}
				object.Text = object.Text or "Label"
				local config = line.elementYPos

				local bottomSnapZone = createInstance("TextLabel", {
					Name = "GroupLabel",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.SubText,
					Text = object.Text,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, config),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 14,
					Size = UDim2.new(0.92, 0, 0, 20),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = line.mainFrame,
				})

				line.elementYPos = line.elementYPos + 24
				success10()
				return bottomSnapZone
			end

			hash = function(line, object)
				local offset = line.Config
				object = object or {}
				object.Name = object.Name or "Group"
				object.Side = object.Side or "Left"
				object.Icon = object.Icon or "rbxassetid://10723427199"
				local sourceTable = { elementsInGroup = {}, Library = line.Library, elementYPos = 35 }
				local overlayFrame = object.Side == "Left" and line.leftColumnFrame or line.rightColumnFrame

				sourceTable.mainFrame = createInstance("Frame", {
					Name = "GroupMainFrame",
					Active = true,
					BackgroundColor3 = line.Library.config.Colors.Secondary,
					Position = UDim2.new(0, 1, 0, 0),
					BorderColor3 = line.Library.config.Colors.Black,
					BorderSizePixel = 0,
					Size = UDim2.new(0, 262, 0, 50),
					Parent = overlayFrame,
				})

				createInstance("UIStroke", {
					Name = "UIStroke",
					Color = Color3.fromRGB(45, 45, 58),
					Thickness = 1,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Parent = sourceTable.mainFrame,
				})
				createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 8), Parent = sourceTable.mainFrame })

				createInstance("UIAspectRatioConstraint", {
					Name = "UIAspectRatioConstraint",
					Parent = createInstance("ImageLabel", {
					Name = "GroupIcon",
					BorderColor3 = line.Library.config.Colors.Black,
					BackgroundColor3 = line.Library.config.Colors.White,
					Image = object.Icon,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 10),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 16, 0, 16),
					Parent = sourceTable.mainFrame,
				}),
				})

				createInstance("TextLabel", {
					Name = "GroupName",
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					TextColor3 = line.Library.config.Colors.Text,
					Text = object.Name,
					BackgroundColor3 = line.Library.config.Colors.White,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 32, 0, 8),
					BorderSizePixel = 0,
					BorderColor3 = Color3.new(),
					TextSize = 15,
					Size = UDim2.new(0, 100, 0, 16),
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sourceTable.mainFrame,
				})

				local function clampValue(descendant)
					local elapsedTime = sourceTable.elementYPos + 10

					if descendant and descendant > 0 then
						tweenInstance(sourceTable.mainFrame, { Size = UDim2.new(0, 262, 0, elapsedTime) }, descendant, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					else
						sourceTable.mainFrame.Size = UDim2.new(0, 262, 0, elapsedTime)
					end
				end

				sourceTable.UpdateSize = clampValue

				obj[sourceTable] = {
					TabConfig = offset,
					GroupConfig = object,
					UpdateSize = clampValue,
					CreateKeybindPill = function(descendant, radius, zCoordinate, alpha, color, initialCapacity, targetPosition)
						local neighbors = targetPosition or {}
						local sample = {}
						local radians = keybindRegistry.Get(radius)
						local query = radians == Enum.KeyCode.Unknown and "" or keybindRegistry.Display(radians)
						local angleRadians = alpha or 18

						if neighbors.Group then
							keybindRegistry.SetMeta(radius, {
							Group = neighbors.Group,
							Name = neighbors.Name or radius,
							Parent = neighbors.Parent,
							DisplayMode = neighbors.DisplayMode,
							GetState = neighbors.GetState,
						})
						end

						local function mainLoop(depth)
							return math.max(measureTextWidth(depth, 11, Enum.Font.GothamSemibold) + 26, neighbors.MinWidth or 0)
						end

						local function onInputBegan(depth)
							if typeof(zCoordinate) == "function" then
								return zCoordinate(depth)
							end
							return zCoordinate
						end

						local track = mainLoop(query)

						sample.frame = createInstance("Frame", {
						Name = "KeybindPill",
						BackgroundColor3 = radians == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Surface or sourceTable.Library.config.Colors.Element,
						BackgroundTransparency = radians == Enum.KeyCode.Unknown and 1 or 0,
						Position = onInputBegan(track),
						BorderColor3 = sourceTable.Library.config.Colors.Black,
						BorderSizePixel = 0,
						Size = UDim2.new(0, track, 0, angleRadians),
						ZIndex = color or 5,
						ClipsDescendants = true,
						Parent = descendant,
					})

						createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = sample.frame })

						local err = createInstance("UIStroke", {
						Enabled = false,
						Name = "UIStroke",
						Color = sourceTable.Library.config.Colors.BorderSoft,
						Transparency = radians == Enum.KeyCode.Unknown and 0.35 or 0,
						Parent = sample.frame,
					})

						sample.label = createInstance("TextLabel", {
						Name = "KeybindLabel",
						FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
						TextColor3 = radians == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						Text = query,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 4, 0, 0),
						BorderSizePixel = 0,
						TextSize = 11,
						Size = UDim2.new(1, -20, 1, 0),
						TextXAlignment = Enum.TextXAlignment.Center,
						ZIndex = (color or 5) + 1,
						Parent = sample.frame,
					})

						sample.keyboardIconImg = createInstance("ImageLabel", {
						Name = "KeyboardIcon",
						ImageColor3 = radians == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						BackgroundColor3 = sourceTable.Library.config.Colors.White,
						Image = "rbxassetid://10723416765",
						BackgroundTransparency = 1,
						Position = radians == Enum.KeyCode.Unknown and UDim2.new(0.5, -5, 0.5, -5) or UDim2.new(1, -15, 0.5, -5),
						BorderColor3 = Color3.new(),
						BorderSizePixel = 0,
						Size = UDim2.new(0, 10, 0, 10),
						ZIndex = (color or 5) + 1,
						Parent = sample.frame,
					})

						createInstance("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = sample.keyboardIconImg })

						local vertexCount = createInstance("TextButton", {
						Name = "KeybindHitbox",
						Text = "",
						AutoButtonColor = false,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = (color or 5) + 2,
						Parent = sample.frame,
					})

						local data = nil
						local name = nil
						local button = nil
						local file = nil
						local steering = nil

						local function handlePlayerAdded()
							if not button or not file then
								return
							end
							local major = keybindRegistry.GetMode(radius)

							tweenInstance(button, {
							BackgroundColor3 = major == "Hold" and sourceTable.Library.config.AccentColor or sourceTable.Library.config.Colors.Element,
						}, 0.22, Enum.EasingStyle.Quint)

							tweenInstance(file, {
							BackgroundColor3 = major == "Toggle" and sourceTable.Library.config.AccentColor or sourceTable.Library.config.Colors.Element,
						}, 0.22, Enum.EasingStyle.Quint)
						end

						local function initialize()
							if not data then
								return
							end
							local major = data
							local byte = name

							if steering then
								disconnectTrackedConnection(steering)
								steering = nil
							end

							data = nil
							name = nil
							button = nil
							file = nil

							if byte then
								tweenInstance(byte, { Scale = 0.9 }, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
							end

							task.delay(0.2, function()
								if major and major.Parent then
									major:Destroy()
								end
							end)
						end

						local function serializeTable(depth)
							if data then
								initialize()
								return
							end
							initialize()
							local elapsedTime = sample.frame.AbsolutePosition + Vector2.new(sample.frame.AbsoluteSize.X + 8, -7)
							depth = depth or elapsedTime

							data = createInstance("Frame", {
							Name = "KeybindModeWindow",
							BackgroundColor3 = sourceTable.Library.config.Colors.Secondary,
							Position = UDim2.new(0, depth.X, 0, depth.Y),
							BorderColor3 = sourceTable.Library.config.Colors.Black,
							BorderSizePixel = 0,
							Size = UDim2.new(0, 112, 0, 28),
							ZIndex = 20000,
							Parent = sourceTable.Library.dropdownHolderRef,
						})

							name = createInstance("UIScale", { Name = "KeybindModeScale", Scale = 0.9, Parent = data })
							createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 8), Parent = data })
							createInstance("UIStroke", { Name = "UIStroke", Color = sourceTable.Library.config.Colors.BorderSoft, Parent = data })

							local playerIdentifier = createInstance("Frame", {
							Name = "ModeHolder",
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 5, 0, 5),
							Size = UDim2.new(1, -10, 1, -10),
							ZIndex = 20001,
							Parent = data,
						})

							createInstance("UIListLayout", {
							Name = "ModeList",
							FillDirection = Enum.FillDirection.Horizontal,
							Padding = UDim.new(0, 6),
							SortOrder = Enum.SortOrder.LayoutOrder,
							Parent = playerIdentifier,
						})

							button = createInstance("TextButton", {
							Name = "HoldMode",
							Text = "Hold",
							AutoButtonColor = false,
							FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
							TextSize = 14,
							TextColor3 = sourceTable.Library.config.Colors.Text,
							BackgroundColor3 = sourceTable.Library.config.Colors.Element,
							BorderSizePixel = 0,
							Size = UDim2.new(0.5, -3, 1, 0),
							ZIndex = 20002,
							Parent = playerIdentifier,
						})

							file = createInstance("TextButton", {
							Name = "ToggleMode",
							Text = "Toggle",
							AutoButtonColor = false,
							FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
							TextSize = 12,
							TextColor3 = sourceTable.Library.config.Colors.Text,
							BackgroundColor3 = sourceTable.Library.config.Colors.Element,
							BorderSizePixel = 0,
							Size = UDim2.new(0.5, -3, 1, 0),
							ZIndex = 20002,
							Parent = playerIdentifier,
						})

							createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = button })
							createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = file })

							button.MouseButton1Click:Connect(function()
								keybindRegistry.SetMode(radius, "Hold")
								handlePlayerAdded()
							end)

							file.MouseButton1Click:Connect(function()
								keybindRegistry.SetMode(radius, "Toggle")
								handlePlayerAdded()
							end)

							button.MouseEnter:Connect(function()
								if keybindRegistry.GetMode(radius) ~= "Hold" then
									tweenInstance(button, { BackgroundColor3 = sourceTable.Library.config.Colors.ElementHover }, 0.18)
								end
							end)

							button.MouseLeave:Connect(handlePlayerAdded)

							file.MouseEnter:Connect(function()
								if keybindRegistry.GetMode(radius) ~= "Toggle" then
									tweenInstance(file, { BackgroundColor3 = sourceTable.Library.config.Colors.ElementHover }, 0.2)
								end
							end)

							file.MouseLeave:Connect(handlePlayerAdded)
							handlePlayerAdded()

							steering = trackConnection(userInputService.InputBegan:Connect(function(inputObject)
								if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then
									return
								end

								if not data then
									return
								end
								local currentPosition = inputObject.Position
								local point = data.AbsolutePosition
								local screenSize = data.AbsoluteSize
								local size = sample.frame.AbsolutePosition
								local delta = sample.frame.AbsoluteSize

								if not (currentPosition.X >= point.X and currentPosition.X <= point.X + screenSize.X and currentPosition.Y >= point.Y and currentPosition.Y <= point.Y + screenSize.Y) and not (currentPosition.X >= size.X and currentPosition.X <= size.X + delta.X and currentPosition.Y >= size.Y and currentPosition.Y <= size.Y + delta.Y) then
									initialize()
								end
							end))

							tweenInstance(data, { Position = UDim2.new(0, elapsedTime.X, 0, elapsedTime.Y) }, 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
							tweenInstance(name, { Scale = 1 }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
						end

						sample.Set = function(depth, command)
							local cacheKey = command == Enum.KeyCode.Unknown and "" or keybindRegistry.Display(command)
							local major = mainLoop(cacheKey)
							sample.label.Text = cacheKey

							tweenInstance(sample.frame, {
							Size = UDim2.new(0, major, 0, angleRadians),
							Position = onInputBegan(major),
							BackgroundColor3 = command == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Surface or sourceTable.Library.config.Colors.Element,
							BackgroundTransparency = command == Enum.KeyCode.Unknown and 1 or 0,
						}, 0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

							tweenInstance(sample.label, {
							TextColor3 = command == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						}, 0.2)

							tweenInstance(err, {
							Color = sourceTable.Library.config.Colors.BorderSoft,
							Transparency = command == Enum.KeyCode.Unknown and 0.35 or 0,
						}, 0.2)

							tweenInstance(sample.keyboardIconImg, {
							Position = command == Enum.KeyCode.Unknown and UDim2.new(0.5, -5, 0.5, -5) or UDim2.new(1, -15, 0.5, -5),
							ImageColor3 = command == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						}, 0.2)
						end

						keybindRegistry.RegisterDisplay(radius, function(depth)
							sample:Set(depth)
						end)

						sample.Listen = function()
							initialize()
							sample.label.Text = "..."
							local major = mainLoop("...")

							tweenInstance(sample.frame, {
							Size = UDim2.new(0, major, 0, angleRadians),
							Position = onInputBegan(major),
							BackgroundColor3 = sourceTable.Library.config.Colors.ElementHover,
							BackgroundTransparency = 0,
						}, 0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

							tweenInstance(sample.label, { TextColor3 = sourceTable.Library.config.Colors.TextHover }, 0.2)
							tweenInstance(err, { Color = sourceTable.Library.config.Colors.Border, Transparency = 0 }, 0.2)
							tweenInstance(sample.keyboardIconImg, { Position = UDim2.new(1, -15, 0.5, -5), ImageColor3 = sourceTable.Library.config.Colors.TextHover }, 0.2)

							keybindRegistry.BeginListen(radius, function(depth)
								sample:Set(depth)
							end, function(depth)
								if not neighbors.Group then
									return true
								end
								local byte = keybindRegistry.FindDuplicate(neighbors.Group, radius, depth)
								if byte then
									sourceTable.Library:Notify({ Title = "You already have " .. byte .. " set as " .. keybindRegistry.Display(depth) .. "!" })
									return false
								end
								return true
							end)
						end

						vertexCount.InputBegan:Connect(function(inputObject)
							if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
								sample:Listen()
								return
							end

							if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
								serializeTable(inputObject.Position)
							end
						end)

						sample.OpenMode = function(depth, command)
							serializeTable(command)
						end

						vertexCount.MouseEnter:Connect(function()
							tweenInstance(sample.frame, { BackgroundColor3 = sourceTable.Library.config.Colors.ElementHover, BackgroundTransparency = 0 }, 0.2)
							tweenInstance(sample.label, { TextColor3 = sourceTable.Library.config.Colors.TextHover }, 0.2)
							tweenInstance(err, { Color = sourceTable.Library.config.Colors.Border, Transparency = 0 }, 0.2)
							tweenInstance(sample.keyboardIconImg, { ImageColor3 = sourceTable.Library.config.Colors.TextHover }, 0.2)
						end)

						vertexCount.MouseLeave:Connect(function()
							local major = keybindRegistry.Get(radius)

							tweenInstance(sample.frame, {
							BackgroundColor3 = major == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Surface or sourceTable.Library.config.Colors.Element,
							BackgroundTransparency = major == Enum.KeyCode.Unknown and 1 or 0,
						}, 0.2)

							tweenInstance(sample.label, {
							TextColor3 = major == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						}, 0.2)

							tweenInstance(err, {
							Color = sourceTable.Library.config.Colors.BorderSoft,
							Transparency = major == Enum.KeyCode.Unknown and 0.35 or 0,
						}, 0.2)

							tweenInstance(sample.keyboardIconImg, {
							ImageColor3 = major == Enum.KeyCode.Unknown and sourceTable.Library.config.Colors.Muted or sourceTable.Library.config.Colors.SubText,
						}, 0.2)
						end)

						if initialCapacity then
							keybindRegistry.Register(radius, initialCapacity)
						end

						return sample
					end,
				}

				sourceTable.AddToggle = addToggle
				sourceTable.AddSlider = addSlider
				sourceTable.AddDoubleSlider = addDoubleSlider
				sourceTable.AddButton = main
				sourceTable.AddKeybind = exampleUsage
				sourceTable.AddDropdown = safeExecute
				sourceTable.AddTextbox = createVector3
				sourceTable.AddDivider = onPlayerAdded
				sourceTable.AddSection = onCharacterAdded
				sourceTable.AddLabel = safeCall
				clampValue()
				table.insert(line.groupsInTab, sourceTable)
				return sourceTable
			end
		end
	end

	do
		local managerObject = setmetatable({}, { __mode = "k" })

		local function onPlayerRemoving(line, object)
			local bottomSnapZone = managerObject[line]
			object = object or {}
			object.Name = object.Name or "Tab"
			object.Description = object.Description or "Main"
			object.Icon = object.Icon or "rbxassetid://94219370057308"

			local firstElement = {
				Config = object,
				groupsInTab = {},
				isActive = false,
				Library = line.Library,
				buttonFrame = createInstance("Frame", {
				Name = "TabButton",
				Active = true,
				BackgroundColor3 = line.Library.config.AccentColor,
				BackgroundTransparency = 1,
				BorderColor3 = line.Library.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 136, 0, 28),
				Parent = line.tabHolderFrame,
			}),
			}

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 7), Parent = firstElement.buttonFrame })

			firstElement.iconImg = createInstance("ImageLabel", {
				Name = "TabIcon",
				ImageColor3 = line.Library.config.Colors.Muted,
				BackgroundColor3 = line.Library.config.Colors.White,
				Image = object.Icon,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 9, 0.5, -7),
				BorderColor3 = Color3.new(),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 14, 0, 14),
				Parent = firstElement.buttonFrame,
			})

			firstElement.nameLabel = createInstance("TextLabel", {
				Name = "TabName",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.Library.config.Colors.Muted,
				Text = object.Name,
				BackgroundColor3 = line.Library.config.Colors.White,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 30, 0.5, -8),
				BorderSizePixel = 4,
				BorderColor3 = Color3.new(),
				TextSize = 15,
				Size = UDim2.new(0, 100, 0, 16),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = firstElement.buttonFrame,
			})

			local button = createInstance("TextButton", {
				Name = "TabClickButton",
				Text = "",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Parent = firstElement.buttonFrame,
			})

			firstElement.contentFadeFrame = createInstance("CanvasGroup", {
				Name = "TabContentFrame",
				Active = true,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 4, 0, 4),
				Size = UDim2.new(1, -8, 1, -8),
				GroupTransparency = 1,
				Visible = false,
				Parent = line.Library.contentHolderFrame,
			})

			local function mainLoop(descendant, radius)

				local copy = createInstance("ScrollingFrame", {
					Name = descendant,
					Active = true,
					BackgroundTransparency = 1,
					Position = radius,
					Size = UDim2.new(0, 268, 1, 0),
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					ScrollingEnabled = true,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					Parent = firstElement.contentFadeFrame,
				})

				createInstance("UIPadding", {
					Name = "UIPadding",
					PaddingTop = UDim.new(0, 2),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 3),
					PaddingRight = UDim.new(0, 3),
					Parent = copy,
				})

				createInstance("UIListLayout", {
					Name = "UIListLayout",
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = copy,
				})

				return copy
			end

			firstElement.leftColumnFrame = mainLoop("LeftColumnFrame", UDim2.new(0, 0, 0, 0))
			firstElement.rightColumnFrame = mainLoop("RightColumnFrame", UDim2.new(0, 272, 0, 0))

			firstElement.Activate = function()
				if line.Library.openDropdowns then
					for _, triangle in pairs(line.Library.openDropdowns) do
						if triangle.Close then
							triangle:Close()
						end
					end
				end

				if line.Library.currentTabYay then
					line.Library.currentTabYay:Deactivate()
				end

				line.Library.currentTabYay = firstElement
				firstElement.isActive = true
				firstElement.contentFadeFrame.Visible = true
				firstElement.contentFadeFrame.GroupTransparency = 1
				tweenInstance(firstElement.contentFadeFrame, { GroupTransparency = 0 }, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
				local elapsedTime = table.find(line.tabsInSection, firstElement) or 1
				local currentPosition = line.tabIndicatorFrame.Position
				local index53 = tonumber(33) or (28 + (tonumber(5) or 5))
				local targetSize = UDim2.new(0, 10, 0, 39 + (elapsedTime - 1) * index53)
				tweenInstance(line.tabIndicatorFrame, { Position = targetSize }, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

				for _, bubble in ipairs(line.tabIndicatorTrails) do
					local bottomGoal = UDim2.new(currentPosition.X.Scale, currentPosition.X.Offset, currentPosition.Y.Scale, currentPosition.Y.Offset - bubble.offset)
					local pos = UDim2.new(targetSize.X.Scale, targetSize.X.Offset, targetSize.Y.Scale, targetSize.Y.Offset - bubble.offset)
					bubble.frame.Position = bottomGoal
					bubble.frame.BackgroundTransparency = bubble.alpha
					tweenInstance(bubble.frame, { Position = pos, BackgroundTransparency = 1 }, (tonumber(0.4) or 0.4) + (tonumber(bubble.delay) or 0), Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				end

				tweenInstance(firstElement.iconImg, { ImageColor3 = line.Library.config.Colors.Text }, 0.4)
				tweenInstance(firstElement.nameLabel, { TextColor3 = line.Library.config.Colors.Text }, 0.4)
				line.Library.tabNameLabel.Text = object.Name
				line.Library.tabDescriptionLabel.Text = object.Description
			end

			firstElement.Deactivate = function()
				firstElement.isActive = false
				firstElement.contentFadeFrame.Visible = false
				firstElement.contentFadeFrame.GroupTransparency = 1
				tweenInstance(firstElement.iconImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.35)
				tweenInstance(firstElement.nameLabel, { TextColor3 = line.Library.config.Colors.Muted }, 0.4)
			end

			button.MouseButton1Click:Connect(function()
					if not firstElement.isActive then
						firstElement:Activate()
					end
				end)

			button.MouseEnter:Connect(function()
					if not firstElement.isActive then
						tweenInstance(firstElement.nameLabel, { TextColor3 = line.Library.config.Colors.TextHover }, 0.25)
						tweenInstance(firstElement.iconImg, { ImageColor3 = line.Library.config.Colors.TextHover }, 0.25)
					end
				end)

			button.MouseLeave:Connect(function()
					if not firstElement.isActive then
						tweenInstance(firstElement.nameLabel, { TextColor3 = line.Library.config.Colors.Muted }, 0.3)
						tweenInstance(firstElement.iconImg, { ImageColor3 = line.Library.config.Colors.Muted }, 0.3)
					end
				end)

			firstElement.AddGroup = hash
			table.insert(line.tabsInSection, firstElement)
			table.insert(line.Library.tabsGoWoosh, firstElement)

			if #line.Library.tabsGoWoosh == 1 then
				firstElement:Activate()
			end

			task.defer(bottomSnapZone)
			return firstElement
		end

		uiLibrary.CreateSection = function(line, object)
			local sourceTable = object or {}
			sourceTable.Name = sourceTable.Name or "Flyte"
			sourceTable.Icon = sourceTable.Icon or "rbxassetid://98092584632154"

			local players = {
				tabsInSection = {},
				isExpanded = true,
				Library = line,
				containerFrame = createInstance("Frame", {
				Name = "SectionContainerYay",
				Active = true,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 158 + 2, 0, 32),
				ClipsDescendants = true,
				Parent = line.sectionHolderScroll,
			}),
			}

			players.mainFrame = createInstance("Frame", {
				Name = "SectionMainFrame",
				Active = true,
				BackgroundColor3 = line.config.Colors.Secondary,
				Position = UDim2.new(0, 1, 0, 2),
				BorderColor3 = line.config.Colors.Black,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 156, 0, 28),
				Parent = players.containerFrame,
			})

			local j = createInstance("UIStroke", { Name = "UIStroke", Color = line.config.Colors.BorderSoft, Transparency = 0, Parent = players.mainFrame })
			local bottomSnapZone = createInstance
			local sorted = { Name = "UIGradient" }
			local controller = ColorSequence.new
			local neighbors = {}
			local knob = ColorSequenceKeypoint.new(0, line.config.Colors.Text)
			local currentDate = ColorSequenceKeypoint.new(0.493, line.config.Colors.AccentLight)
			local packed = ColorSequenceKeypoint.new(0.509, line.config.Colors.AccentLight)
			neighbors[1] = knob
			neighbors[2] = currentDate
			neighbors[3] = packed

			do
				local argumentPack = table.pack(ColorSequenceKeypoint.new(1, line.config.Colors.Text))
				table.move(argumentPack, 1, argumentPack.n, 4, neighbors)
			end

			sorted.Color = controller(neighbors)
			sorted.Rotation = 260
			sorted.Parent = j
			bottomSnapZone("UIGradient", sorted)
			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 7), Parent = players.mainFrame })

			createInstance("UIAspectRatioConstraint", {
				Name = "UIAspectRatioConstraint",
				Parent = createInstance("ImageLabel", {
				Name = "SectionIcon",
				BorderColor3 = line.config.Colors.Black,
				BackgroundColor3 = line.config.Colors.White,
				Image = sourceTable.Icon,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0.5, -7),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 14, 0, 14),
				Parent = players.mainFrame,
			}),
			})

			createInstance("TextLabel", {
				Name = "SectionName",
				FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextColor3 = line.config.Colors.Text,
				Text = sourceTable.Name,
				BackgroundColor3 = line.config.Colors.White,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 32, 0.5, -8.5),
				BorderSizePixel = 0,
				BorderColor3 = Color3.new(),
				TextSize = 15,
				Size = UDim2.new(0, 100, 0, 16),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = players.mainFrame,
			})

			local manager = createInstance("ImageButton", {
				Name = "ExpandCollapseButton",
				BackgroundColor3 = line.config.Colors.White,
				Image = "rbxassetid://111626678408582",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -24, 0.5, -8),
				BorderColor3 = Color3.new(),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 16, 0, 16),
				Parent = players.mainFrame,
			})

			players.tabIndicatorFrame = createInstance("Frame", {
				Name = "TabIndicator",
				BackgroundColor3 = line.config.AccentColor,
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 11, 0, 42),
				Size = UDim2.new(0, 136, 0, 30),
				Parent = players.containerFrame,
			})

			createInstance("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 7), Parent = players.tabIndicatorFrame })
			players.tabIndicatorTrails = {}

			for k = 1, 4 do
				local elapsedTime = 28 + k * 3
				local difference = (elapsedTime - 28) / 2

				local data = createInstance("Frame", {
					Name = "TabIndicatorTrail" .. k,
					BackgroundColor3 = line.config.AccentColor,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 42 - difference),
					Size = UDim2.new(0, 136, 0, elapsedTime),
					Parent = players.containerFrame,
				})

				createInstance("UICorner", { Name = "TabIndicatorTrailCorner" .. k, CornerRadius = UDim.new(0, 7), Parent = data })
				table.insert(players.tabIndicatorTrails, { frame = data, alpha = 0.6 - k * 0.1, delay = k * 0.06, offset = difference })
			end

			players.tabHolderFrame = createInstance("Frame", {
				Name = "TabHolderFrame",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 11, 0, 39),
				Size = UDim2.new(0, 146, 0, 0),
				ClipsDescendants = true,
				Parent = players.containerFrame,
			})

			players.tabHolderScale = createInstance("UIScale", { Name = "TabHolderScale", Scale = 1, Parent = players.tabHolderFrame })

			players.tabLayoutThing = createInstance("UIListLayout", {
				Name = "UIListLayout",
				Padding = UDim.new(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = players.tabHolderFrame,
			})

			local function mainLoop()
				local elapsedTime = players.tabLayoutThing.AbsoluteContentSize.Y
				players.tabHolderFrame.Size = UDim2.new(0, 146, 0, elapsedTime)

				if players.isExpanded then
					tweenInstance(players.containerFrame, { Size = UDim2.new(0, 158, 0, 32 + elapsedTime + 14) }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				end
			end

			players.tabLayoutThing:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(mainLoop)

			local function characterAdded()
				players.isExpanded = not players.isExpanded
				tweenInstance(manager, { Rotation = players.isExpanded and 0 or -180 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

				if players.isExpanded then
					local screenHeight = players.tabLayoutThing.AbsoluteContentSize.Y
					players.tabHolderScale.Scale = 0.92
					tweenInstance(players.containerFrame, { Size = UDim2.new(0, 158, 0, 32 + screenHeight + 14) }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(players.tabHolderScale, { Scale = 1 }, 0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					tweenInstance(players.tabIndicatorFrame, { BackgroundTransparency = 0 }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					for _, bubble in ipairs(players.tabIndicatorTrails) do
						bubble.frame.BackgroundTransparency = 1
					end
				else
					tweenInstance(players.tabHolderScale, { Scale = 0.94 }, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(players.containerFrame, { Size = UDim2.new(0, 158, 0, 35) }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(players.tabIndicatorFrame, { BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

					for _, bubble in ipairs(players.tabIndicatorTrails) do
						bubble.frame.BackgroundTransparency = 1
					end
				end
			end

			manager.MouseButton1Click:Connect(characterAdded)

			createInstance("TextButton", {
				Name = "SectionToggleButton",
				Text = "",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Parent = players.mainFrame,
			}).MouseButton1Click:Connect(characterAdded)

			table.insert(line.sectionRefreshers, mainLoop)
			managerObject[players] = mainLoop
			players.AddTab = onPlayerRemoving
			table.insert(line.sectionsAreAwesome, players)
			return players
		end
	end
end

uiLibrary.SetAccentColor = function(line, yCoordinate)
	line.config.AccentColor = yCoordinate
	if line.config.Colors then
		line.config.Colors.Accent = yCoordinate
		line.config.Colors.AccentDark = yCoordinate:Lerp(Color3.new(), 0.3)
		line.config.Colors.AccentLight = yCoordinate:Lerp(Color3.new(1, 1, 1), 0.35)
	end
end

uiLibrary.Destroy = function(line)
	if line.Destroyed then
		return
	end
	line.Destroyed = true
	callWithRestoredThreadIdentity(unloadScript)

	for vertex in pairs(trackedConnections) do
		vertex:Disconnect()
	end

	table.clear(trackedConnections)
	playerAddedHook = nil

	if line.dropdownFrames then
		for _, edge in ipairs(line.dropdownFrames) do
			edge:Destroy()
		end

		line.dropdownFrames = nil
	end

	if keybindRegistry and keybindRegistry.Destroy then
		keybindRegistry.Destroy()
	end

	if line.screenGuiYay and line.screenGuiYay.Parent then
		line.screenGuiYay:Destroy()
	end

	line.screenGuiYay = nil

	if getgenv().FlyteBB == line then
		getgenv().FlyteBB = nil
	end
end

accessoryManager = nil
window = nil
startTriggerbot = nil
resetTriggerbotState = nil
attemptAutoParry = nil
uiElements = nil
features = nil

unloadScript = function()
	if not flyteBBState or flyteBBState.Unloading then
		return
	end
	flyteBBState.Unloading = true
	flyteBBState.Loaded = false
	local sourceTable = flags or {}

	for vertex, elementIndex in pairs(sourceTable) do
		if type(elementIndex) == "boolean" then
			flags[vertex] = false
		end
	end

	if features then
		if features.UnlockAll then
			callWithRestoredThreadIdentity(features.UnlockAll.Stop, true)
		end

		if features.UIExtra then
			callWithRestoredThreadIdentity(features.UIExtra.HideOverlays)
		end

		if features.AFK then
			callWithRestoredThreadIdentity(features.AFK.Toggle, false)
		end

		if features.Script then
			callWithRestoredThreadIdentity(features.Script.Toggle, false)
		end

		if features.Render then
			callWithRestoredThreadIdentity(features.Render.DisableFX, false)
			callWithRestoredThreadIdentity(features.Render.SetAntiLag, false)
		end

		if features.Visuals then
			callWithRestoredThreadIdentity(features.Visuals.ClearESP)
		end

		if features.Streak then
			callWithRestoredThreadIdentity(features.Streak.Stop)
		end

		if features.Stats then
			callWithRestoredThreadIdentity(features.Stats.Stop)
		end

		if features.AutoPlay then
			callWithRestoredThreadIdentity(features.AutoPlay.Stop)
		end

		if features.Staff then
			callWithRestoredThreadIdentity(features.Staff.Set, false)
		end

		if features.Quasar then
			callWithRestoredThreadIdentity(features.Quasar.SetBlindness, false)
			callWithRestoredThreadIdentity(features.Quasar.SetDisorientate, false)
			callWithRestoredThreadIdentity(features.Quasar.Reset)
		end

		if features.Phantom then
			callWithRestoredThreadIdentity(features.Phantom.Reset)
		end

		if features.Animation then
			callWithRestoredThreadIdentity(features.Animation.Reset)
		end
	end

	if accessoryManager then
		callWithRestoredThreadIdentity(accessoryManager.Destroy)
	end

	cleanupResources(flyteBBState)
	flyteBBState.Connections = {}

	if flyteBBState.PreclickQueue then
		table.clear(flyteBBState.PreclickQueue)
	end

	local isActive = features and features.Parry

	if isActive then
		local index2 = features.Parry.Fire
		isActive = getgenv().FlyteParry == index2
	end

	if isActive then
		getgenv().FlyteParry = nil
	end

	flyteBBState.Unloaded = true

	if getgenv().FlyteBB_State == flyteBBState then
		getgenv().FlyteBB_State = nil
	end
end

do
	local instance8 = Instance.new("VirtualInputManager")
	Data = require(replicatedStorage.Packages.Replion).Client:WaitReplion("Data")
	local sourceTable = { MouseButton1 = 0, MouseButton2 = 1, MouseButton3 = 2 }
	local query = nil

	flyteBBState = {
		Unload = unloadScript,
		Loaded = false,
		ParryMethod = nil,
		ESPLabels = {},
		ESPConnections = {},
		AbilityActive = {},
		AbilityCooldowns = {},
		AbilityUses = {},
		Connections = {},
		SpamParries = {},
		AutoSpamData = { {}, { 0, 0 } },
		StatsPeak = {},
		ExtraStats = {},
		StaffDetected = {},
	}

	getgenv().FlyteBB_State = flyteBBState
	refreshDataPing()
	flyteBBState.Connections["Data Ping"] = task.spawn(function()while true do task.wait(0.1); refreshDataPing ();end;end)

	local function mainLoop()
		local selectedObjects = Data:Get({ "Settings", "Keybinds", "Block", "PC" })
		local seed = selectedObjects and selectedObjects.Bind1
		local workerCount = selectedObjects and selectedObjects.Bind2
		selectedObjects = selectedObjects and selectedObjects.Bind3
		query = seed and not sourceTable[seed] and seed or workerCount and not sourceTable[workerCount] and workerCount or selectedObjects and not sourceTable[selectedObjects] and selectedObjects or seed or workerCount or selectedObjects or "F"
	end

	mainLoop()
	flyteBBState.Connections["Block Bind"] = Data:OnDescendantChange({ nil, "Keybinds", "Block" }, mainLoop)

	simulateClick = function()
		if userInputService.TouchEnabled then
			local viewportSize = workspace.CurrentCamera.ViewportSize
			local elapsedTime = viewportSize.X / 2
			local difference = viewportSize.Y / 2
			instance8:SendTouchEvent(10, 0, elapsedTime, difference)
			instance8:SendTouchEvent(10, 2, elapsedTime, difference)
			return true
		end

		local bottomSnapZone = sourceTable[query]

		if bottomSnapZone then
			instance8:SendMouseButtonEvent(0, 0, bottomSnapZone, true, game, 0)
			instance8:SendMouseButtonEvent(0, 0, bottomSnapZone, false, game, 0)
			return true
		end

		local knob = Enum.KeyCode[query]
		if not knob then
			return false
		end
		instance8:SendKeyEvent(true, knob, false, game)
		instance8:SendKeyEvent(false, knob, false, game)
		return true
	end
end

local coroutineFunction, coroutineBody, operation, primaryPart, Workspace, smallest, newRoot, playerGui, CoreGui, newCharacter
local bottomSnapZone, knob, PlayerGui, success3, undoFunction, jsonEncode, continuation, updateFunction, left, wrapper
local compareFunction, managerInstance, executeFunction, redoFunction, unexecuteFunction, index4, index5, index6, managerObject, index7
local previous, index8, index9, index10, index11, index12, index13, index14, index15, top
local elapsedTime, currentDate, packed, index16

do
	do
		local radians, lines

		do
			do
				coroutineFunction = function(line)
					local angleRadians = flyteBBState.Connections[line]

					if angleRadians then
						cleanupResources(angleRadians)
						flyteBBState.Connections[line] = nil
					end
				end

				flags = {}

				do
					local sourceTable = {
						anticurve = "Anticurve",
						esp = nil,
						fflags = "FFlags",
						kh = "KH",
						timehole = "TimeHole",
						ui = "UI",
					}

					local players = {
						configData.Toggles,
						configData.Sliders,
						configData.DoubleSliders,
						configData.Dropdowns,
						configData.Textboxes,
					}

					local function normalizeVector(line, object)
						if object and line == "custom_streak" then
							return nil
						end
						local query = (object and line:match("^(.-)(:notify)$") or line):gsub("FFlags", "Fflags")

						for _, existingPlayer in pairs({ nil, nil, nil, nil, "VIM", nil, "ID", nil, "VFX", "R15", "R6" }) do
							query = query:gsub(existingPlayer, "_" .. existingPlayer .. "_")
						end

						local concatenated = query:gsub("(%l)(%u)", "%1_%2"):gsub("(%u)(%u%l)", "%1_%2"):gsub("_+", "_"):gsub("^_", ""):gsub("_$", ""):gsub("[^_]+", function(descendant)
								local angleRadians = sourceTable[string.lower(descendant)]
								local concatenated

								if angleRadians then
									concatenated = angleRadians
								else
									concatenated = descendant:sub(1, 1):upper() .. descendant:sub(2)
								end

								return concatenated
							end)

						if object then
							return normalizeConfigKey(concatenated:gsub("_Enabled$", "") .. "")
						end
						return concatenated:gsub("_", "")
					end

					coroutineBody = function(line)
						for vertex, existingPlayer in pairs(line) do
							local track = normalizeVector(vertex, true)

							for _, modelName in pairs(players) do
								if modelName[track] ~= nil then
									existingPlayer = modelName[track]
									break
								end
							end

							local WeaponBase = normalizeVector(vertex)
							local yString = deepCopy(existingPlayer)

							if WeaponBase == "ParryAccuracy" then
								yString = math.clamp(tonumber(yString) or 80, 1, 100)
							elseif WeaponBase == "ParryRange" then
								yString = math.clamp(tonumber(yString) or 0, 0, 10)
							elseif WeaponBase == "MenuScale" then
								yString = math.clamp(tonumber(yString) or 100, 50, 150)
							end

							flags[WeaponBase] = yString
						end
					end

					operation = function(line, object)
						return function(descendant)
							local WeaponBase = normalizeVector(line)
							local yString = descendant

							if WeaponBase == "ParryAccuracy" then
								yString = math.clamp(tonumber(yString) or 80, 1, 100)
							elseif WeaponBase == "ParryRange" then
								yString = math.clamp(tonumber(yString) or 0, 0, 10)
							elseif WeaponBase == "MenuScale" then
								yString = math.clamp(tonumber(yString) or 100, 50, 150)
							end

							flags[WeaponBase] = yString

							if object then
								object(yString)
							end
						end
					end
				end
			end

			do
				local bullet, rootInstance

				do
					coroutineBody({ MenuScale = 100 })

					Configs = {
						Folder = "Flyte/settings",
						AutoloadPath = "Flyte/settings/autoload.txt",
					}

					configManager = Configs

					Configs.SyncUnlock = function()
						if type(configData.UnlockAll) ~= "table" then
							return
						end
						flags.UnlockAllSword = type(configData.UnlockAll.Sword) == "string" and configData.UnlockAll.Sword or ""
						flags.UnlockAllExplosion = type(configData.UnlockAll.Explosion) == "string" and configData.UnlockAll.Explosion or ""
						flags.UnlockAllEmotes = type(configData.UnlockAll.Emotes) == "table" and configData.UnlockAll.Emotes or {}
						flags.UnlockAllAccessory = configData.UnlockAll.Accessory == true
						flags.UnlockAllFinishers = type(configData.UnlockAll.Finishers) == "table" and configData.UnlockAll.Finishers or {}
						flags.UnlockAllFavorites = type(configData.UnlockAll.Favorites) == "table" and configData.UnlockAll.Favorites or { Sword = {}, Explosion = {}, Emote = {} }
					end

					Configs.SyncUnlock()

					Configs.Name = function(line)
						if type(line) ~= "string" or line:gsub("%s+", "") == "" then
							return
						end
						local query = line:gsub("^%s+", ""):gsub("%s+$", "")
						if string.lower(query) == "autoload" or query:find("[\\/:*?\"<>|]") then
							return
						end
						return query
					end

					Configs.MakeFolder = function()
						if not isfolder("Flyte") then
							makefolder("Flyte")
						end

						if not isfolder(Configs.Folder) then
							makefolder(Configs.Folder)
						end
					end

					Configs.GetPath = function(line)
						local angleRadians = Configs.Name(line)
						if not angleRadians then
							return
						end
						return Configs.Folder .. "/" .. angleRadians .. ".json"
					end

					Configs.Copy = function(line, object)
						table.clear(line)

						for vertex, existingPlayer in pairs(object) do
							line[vertex] = deepCopy(existingPlayer)
						end
					end

					Configs.New = function()
						local sourceTable = {
							UnlockAll = {
							Sword = "",
							Explosion = "",
							Emotes = {},
							Accessory = false,
							Finishers = {},
							Favorites = { Sword = {}, Explosion = {}, Emote = {} },
						},
						}

						for _, existingPlayer in pairs(configSections) do
							sourceTable[existingPlayer] = sourceTable[existingPlayer] or {}
						end

						return sourceTable
					end

					Configs.Defaults = function()
						local angleRadians = Configs.New()

						if uiElements then
							for _, propertyName in pairs(uiElements.toggles) do
								if propertyName.SaveId and propertyName.DefaultValue ~= nil then
									local vertexCount = "EnumItem"
									local result18 = typeof(propertyName.DefaultValue) == vertexCount and angleRadians.Keybinds or angleRadians.Toggles
									local result42 = propertyName.SaveId
									result18[result42] = typeof(propertyName.DefaultValue) == "EnumItem" and propertyName.DefaultValue.Name or deepCopy(propertyName.DefaultValue)
								end

								if propertyName.NotifySaveId then
									angleRadians.Toggles[propertyName.NotifySaveId] = propertyName.DefaultNotify
								end
							end

							for _, propertyName in pairs(uiElements.sliders) do
								if propertyName.SaveId and propertyName.DefaultValue ~= nil then
									local vertexCount = "table"
									;(type(propertyName.DefaultValue) == vertexCount and angleRadians.DoubleSliders or angleRadians.Sliders)[propertyName.SaveId] = deepCopy(propertyName.DefaultValue)
								end
							end

							for _, propertyName in pairs(uiElements.dropdowns) do
								if propertyName.SaveId and propertyName.DefaultValue ~= nil then
									angleRadians.Dropdowns[propertyName.SaveId] = deepCopy(propertyName.DefaultValue)
								end
							end

							for _, propertyName in pairs(uiElements.textboxes) do
								if propertyName.SaveId and propertyName.DefaultValue ~= nil then
									angleRadians.Textboxes[propertyName.SaveId] = deepCopy(propertyName.DefaultValue)
								end
							end
						end

						return angleRadians
					end

					Configs.Current = function()
						local angleRadians = Configs.New()

						for _, propertyName in pairs(configSections) do
							Configs.Copy(angleRadians[propertyName], configData[propertyName])
						end

						return angleRadians
					end

					Configs.Validate = function(line)
						line = type(line) == "table" and line or {}
						migrateConfigData(line)
						local angleRadians = Configs.Defaults()

						for _, propertyName in pairs(configSections) do
							if type(line[propertyName]) == "table" then
								Configs.Copy(angleRadians[propertyName], line[propertyName])
							end
						end

						for _, propertyName in pairs({ nil, "manual_spam_enabled" }) do
							angleRadians.Toggles[propertyName] = nil
						end

						normalizeKeyInputTypes(angleRadians.Dropdowns)
						return angleRadians
					end

					Configs.Apply = function(line)
						local angleRadians = Configs.Validate(line)
						local track = deepCopy(configData.Keybinds)
						Configs.Applying = true

						for _, modelName in pairs(configSections) do
							Configs.Copy(configData[modelName], angleRadians[modelName])
						end

						Configs.SyncUnlock()

						local function normalizeVector(object, descendant)
							for _, modelName in pairs(object) do
								local result42 = modelName.SaveId

								if result42 and modelName.Set and descendant[result42] ~= nil then
									modelName:Set(deepCopy(descendant[result42]))
								end

								if modelName.SetNotify and modelName.NotifySaveId and descendant[modelName.NotifySaveId] ~= nil then
									modelName:SetNotify(descendant[modelName.NotifySaveId])
								end
							end
						end

						if uiElements then
							normalizeVector(uiElements.toggles, configData.Toggles)
							normalizeVector(uiElements.sliders, configData.Sliders)

							for _, modelName in pairs(uiElements.sliders) do
								local result42 = modelName.SaveId and configData.DoubleSliders[modelName.SaveId]

								if modelName.Set and type(result42) == "table" then
									modelName:Set(result42.Min, result42.Max)
								end
							end

							normalizeVector(uiElements.dropdowns, configData.Dropdowns)
							normalizeVector(uiElements.textboxes, configData.Textboxes)

							for _, modelName in pairs(uiElements.toggles) do
								local result42 = modelName.SaveId
								result42 = result42 and configData.Keybinds[result42]

								if modelName.Set and result42 ~= nil then
									local steering = keybindRegistry.Resolve(type(result42) == "table" and result42.Key or result42)

									if typeof(steering) == "EnumItem" then
										modelName:Set(steering)
									end
								end
							end
						end

						for vertex, modelName in pairs(configData.Keybinds) do
							if type(modelName) == "table" then
								keybindRegistry.SetMode(vertex, modelName.Mode or "Toggle")
								keybindRegistry.Set(vertex, keybindRegistry.Resolve(modelName.Key))
							end
						end

						for vertex in pairs(track) do
							if configData.Keybinds[vertex] == nil then
								keybindRegistry.Set(vertex, Enum.KeyCode.Unknown)
							end
						end

						Configs.Applying = nil
						saveConfig()

						local deferredFunction = flyteBBState and flyteBBState.RefreshKeybinds
						if type(deferredFunction) == "function" then
							task.defer(deferredFunction)
						end

						task.defer(function()
								if features.UnlockAll and features.UnlockAll.Status == "active" then
									features.UnlockAll.LoadFavorites()
									features.UnlockAll.ApplyFavorites()
									features.UnlockAll.ApplySaved()
								elseif flyteBBState and flyteBBState.Loaded and flags.UnlockAllEnabled and features.UnlockAll then
									features.UnlockAll.Toggle(true)
								end
							end)
					end

					Configs.Refresh = function(line)
						Configs.MakeFolder()
						local sourceTable = {}

						for _, existingPlayer in listfiles(line.Folder) do
							local targetName = tostring(existingPlayer):gsub("\\", "/"):match("/([^/]+)%.json$")

							if targetName and targetName ~= "autoload" then
								table.insert(sourceTable, targetName)
							end
						end

						table.sort(sourceTable)
						return sourceTable
					end

					Configs.Save = function(line, object, descendant)
						local angleRadians = Configs.Name(object)
						if not angleRadians then
							return false, "invalid config name"
						end
						Configs.MakeFolder()
						local row = Configs.Current
						configFileStore.Write(Configs.GetPath(angleRadians), row())

						if descendant ~= false then
							line.Selected = angleRadians
						end

						line.Active = angleRadians
						return true
					end

					Configs.Load = function(line, object)
						local playerUserId = Configs.Name(object)
						local angleRadians = playerUserId and Configs.GetPath(playerUserId)
						if not angleRadians or not isfile(angleRadians) then
							playerUserId = playerUserId and "config does not exist"
							return false, playerUserId or nil
						end
						local track = configFileStore.Read(angleRadians)
						if type(track) ~= "table" then
							return false, "failed to decode config"
						end
						line.Selected = playerUserId
						line.Active = playerUserId
						Configs.Apply(track)
						return true
					end

					Configs.Delete = function(line, object)
						local query = Configs.Name(object)
						local angleRadians = query and Configs.GetPath(query)
						if not angleRadians or not isfile(angleRadians) then
							query = query and nil or "no config is selected"
							return false, query
						end
						delfile(angleRadians)

						if line.Autoload == query then
							line:ClearAutoload()
						end

						if line.Selected == query then
							line.Selected = nil
						end

						if line.Active == query then
							line.Active = nil
						end

						return true
					end

					Configs.Reset = function(line, object)
						local angleRadians = Configs.Name(object)
						if not angleRadians then
							return false, "no config is selected"
						end
						Configs.MakeFolder()
						local track = Configs.GetPath(angleRadians)
						local vertexCount = Configs.Defaults()
						configFileStore.Write(track, vertexCount)

						if line.Selected == angleRadians then
							Configs.Apply(vertexCount)
						end

						return true
					end

					Configs.SetAutoload = function(line, object)
						local angleRadians = Configs.Name(object)
						local track = angleRadians and Configs.GetPath(angleRadians)
						if not track or not isfile(track) then
							angleRadians = angleRadians and nil
							return false, angleRadians or "no config is selected"
						end
						Configs.MakeFolder()
						writefile(Configs.AutoloadPath, angleRadians)
						line.Autoload = angleRadians
						return true
					end

					Configs.GetAutoload = function(line)
						Configs.MakeFolder()
						if not isfile(Configs.AutoloadPath) then
							line.Autoload = nil
							return "none"
						end
						local angleRadians = Configs.Name(readfile(Configs.AutoloadPath))
						line.Autoload = angleRadians
						return angleRadians or "none"
					end

					Configs.ClearAutoload = function(line)
						if isfile(Configs.AutoloadPath) then
							delfile(Configs.AutoloadPath)
						end

						line.Autoload = nil
						return true
					end

					Configs.LoadAutoload = function(line)
						local element = line:GetAutoload()

						if element ~= "none" then
							line:Load(element)
						end
					end

					features = {}
					primaryPart = workspace.CurrentCamera
					Workspace = game:GetService("Lighting")
					smallest = workspace:WaitForChild("Alive")
					newRoot = workspace:WaitForChild("Runtime")
					playerGui = workspace:WaitForChild("Balls")
					CoreGui = workspace:FindFirstChild("TrainingBalls")
					newCharacter = localPlayer:WaitForChild('PlayerGui')

					do
						local character4 = workspace:FindFirstChild("LobbyTraining", true)
						bullet = character4 and character4:FindFirstChild("TrainingArea")
						rootInstance = character4 and character4:FindFirstChild("Lobby")
					end
				end

				local sourceTable = nil
				local Player = newCharacter:WaitForChild("Hotbar")
				radians = Player:WaitForChild("Ability")
				bottomSnapZone = Player:WaitForChild("Block"):FindFirstChild("UIGradient")
				knob = radians:FindFirstChild("UIGradient")
				PlayerGui = radians:WaitForChild("Duration")

				lines = {
					"Calming Deflection",
					"Raging Deflection",
					"Rapture",
					"Aerodynamic Slash",
					"Forcefield",
					"Infinity",
					"Fracture",
					"Phantom",
					"Ninja Dash",
					"Dribble",
					"Dragon Spirit",
				}

				isInTrainingArea = function(line)
					line = line and line:FindFirstChild("HumanoidRootPart")
					if not line or not bullet then
						return false
					end
					local angleRadians = bullet.CFrame:PointToObjectSpace(line.Position)
					local difference = bullet.Size * 0.5
					local currentLength = difference.X
					local cell = math.abs(angleRadians.X) <= currentLength

					if cell then
						local screenHeight = difference.Y
						cell = math.abs(angleRadians.Y) <= screenHeight
					end

					local active

					if cell then
						local maxZ = difference.Z
						active = math.abs(angleRadians.Z) <= maxZ
					else
						active = cell
					end

					return active
				end

				undoFunction = function(line)
					return line and line.PrimaryPart and (line.Parent == smallest or isInTrainingArea(line))
				end

				jsonEncode = function()
					if sourceTable then
						return sourceTable
					end
					sourceTable = {}
					local lastTime = rootInstance and rootInstance:GetDescendants() or {}

					for _, existingPlayer in pairs(lastTime) do
						local player6 = existingPlayer:IsA("BasePart")
						local cell

						if player6 then
							cell = existingPlayer:GetAttribute(nil) == true
						else
							cell = player6
						end

						if cell then
							sourceTable[#sourceTable + 1] = existingPlayer
						end
					end

					return sourceTable
				end
			end
		end

		do
			do
				do
					local function normalizeVector(line)
						if not line then
							return false
						end

						for _, existingPlayer in pairs(lines) do
							local track = line:FindFirstChild(existingPlayer)

							if track and track.Enabled then
								if existingPlayer == nil or existingPlayer == nil then
									local resultLabel = radians:FindFirstChild("ready")
									resultLabel = resultLabel and resultLabel:FindFirstChild(nil)
									local cell = not radians.Red.Visible

									if cell then
										cell = not resultLabel

										if not cell then
											cell = (tonumber(resultLabel.Text) or 0) > 0
										end
									end

									existingPlayer = cell and existingPlayer or nil
									return existingPlayer
								end

								existingPlayer = knob and knob.Offset.Y >= 0.49 and existingPlayer or nil
								return existingPlayer
							end
						end
					end

					continuation = function(line)
						local attributeName = nil
						local cell = line and type(attributeName) == "string" and line:GetAttribute(attributeName) == true or false

						if not cell then
							cell = flyteBBState.InvisibilityCharacter == line

							if cell then
								cell = os.clock() < (flyteBBState.InvisibilityUntil or 0)
							end
						end

						return cell
					end

					flyteBBState.Connections["Invisibility Request"] = replicatedStorage.Remotes.VisualBindableCD.Event:Connect(function()
							local model = localPlayer.Character
							local cell

							if model then
								cell = localPlayer:GetAttribute("CurrentlyEquippedAbility") == "Phantom"
							else
								cell = model
							end

							if cell then
								flyteBBState.InvisibilityCharacter = model
								flyteBBState.InvisibilityUntil = os.clock() + 3
							end
						end)

					updateFunction = function(line)
						local model = localPlayer.Character
						model = model and model:FindFirstChild("Abilities")
						model = model and model:FindFirstChild(line)
						return localPlayer:GetAttribute("CurrentlyEquippedAbility") == line and model and model.Enabled and PlayerGui.Visible
					end

					left = replicatedStorage.Remotes.AbilityButtonPress

					wrapper = function(line)
						if not normalizeVector(line) then
							return false
						end
						left:Fire()
						return true
					end
				end
			end

			coroutineBody({
				ParryAccuracy = 80,
				ParryRange = 0,
				AntiCurveEnabled = true,
				BackwardsAntiCurveEnabled = true,
				AutoParryType = "Remote",
				SelectedParryType = nil,
				ParryLoopType = "PreSimulation",
				CooldownProtectionEnabled = false,
				AutoAbilityEnabled = false,
				RandomizedParryAccuracy = false,
				RandomAccuracyMin = 1,
				RandomAccuracyMax = 100,
			})

			compareFunction = function(line)
				local callbackFunction = line and line:GetAttribute("target")
				if callbackFunction and callbackFunction ~= "" then
					return callbackFunction
				end
				local valueObject = line and line:FindFirstChild("TargetAttachment")
				local otherPart = valueObject and valueObject.Value and valueObject.Value:FindFirstAncestorWhichIsA("Model")

				while otherPart and otherPart:FindFirstChild("ActualCharacter") do
					otherPart = otherPart.ActualCharacter.Value
				end

				return otherPart and otherPart.Name
			end

			managerInstance = setmetatable({}, { __mode = "k" })

			do
				local sourceTable = {}
				local angleRadians = nil

				for _, propertyName in replicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net:GetChildren() do
					if propertyName:IsA("UnreliableRemoteEvent") and propertyName.Name ~= "URE/ReplicateBallPosition" then
						local connection = propertyName.OnClientEvent:Connect(function(key,callback)if typeof(key)=="Instance"and typeof(callback)=="Vector3"and(key.Parent== playerGui or key.Parent== CoreGui )then local currentLength= managerInstance [key];if not currentLength then currentLength={}; managerInstance [key]=currentLength;end;currentLength.Position=callback;currentLength.UpdatedAt=os.clock();if not  angleRadians then angleRadians = propertyName ;end;end;end)
						sourceTable[propertyName] = connection
						flyteBBState.Connections[propertyName] = connection
					end
				end
			end
		end
	end

	do
		executeFunction = function(line)
			if line then
				line = line:IsA("BasePart") and line or line:IsA("Model") and line.PrimaryPart or line:FindFirstChild("Body")
			end

			return line
		end

		redoFunction = function(line, object, descendant)
			local radians = managerInstance[line]

			if not radians then
				radians = object or executeFunction(line)
				radians = radians and managerInstance[radians]
			end

			local cell

			if radians then
				cell = type(nil) == "number" and (descendant or os.clock()) - (radians.UpdatedAt or 0) <= nil
			else
				cell = radians
			end

			if cell then
				return radians.Position
			end
		end

		unexecuteFunction = function(line)
			local radians = redoFunction(line)
			if radians then
				return radians
			end
			local angleRadians = executeFunction(line)
			return angleRadians and angleRadians.Position or Vector3.zero
		end

		index4 = function(line)
			local linearVelocity = line and line:FindFirstChild("zoomies")
			if linearVelocity then
				return linearVelocity.VectorVelocity
			end
			local callbackFunction = line and line:GetAttribute("Velocity")
			return typeof(callbackFunction) == "Vector3" and callbackFunction or Vector3.zero
		end

		index5 = function(line)
			local bestDistance

			if line then
				local callbackFunction = line:IsA("BasePart") and line:GetAttribute("realBall")

				if callbackFunction then
					bestDistance = callbackFunction
				else
					bestDistance = line:IsA("Model") and line:FindFirstChild("Body") and line:FindFirstChild(nil)
				end
			else
				bestDistance = line
			end

			return bestDistance
		end

		index6 = function(line)
			return line and line:IsA("Model") and line:FindFirstChild("Body") and line:FindFirstChild(nil) and not line:FindFirstChild("zoomies")
		end

		managerObject = setmetatable({}, { __mode = "k" })

		index7 = function(line)
			local radians = managerObject[line]

			if not radians then
				local angleRadians = compareFunction(line)
				local lines = { Parried = false, ParryResetAt = 0, Target = angleRadians, LoopTarget = angleRadians }
				managerObject[line] = lines
				radians = lines
			end

			return radians
		end

		do
			local function normalizeVector()
				return (latestPingMs or localPlayer:GetNetworkPing() * 1000) / 1000
			end

			previous = function()
				local difference = latestPingMs

				if not latestPingMs then
					difference = localPlayer:GetNetworkPing() * 1000
				end

				return difference
			end

			index8 = function(line, object, descendant)
				local minX = math.huge
				local queue = descendant and jsonEncode() or smallest:GetChildren()
				local radians = nil

				for _, existingPlayer in pairs(queue) do
					if existingPlayer ~= line then
						local player6 = existingPlayer:IsA("BasePart") and existingPlayer or existingPlayer.PrimaryPart or existingPlayer:FindFirstChild("HumanoidRootPart")
						local cell

						if player6 then
							cell = not descendant

							if not cell then
								cell = player6.Parent

								if cell then
									cell = (player6:GetAttribute(nil) or 1) > 0
								end
							end
						else
							cell = player6
						end

						if cell then
							local exponent = (object - player6.Position).Magnitude

							if exponent < minX then
								minX = exponent
								radians = player6
							end
						end
					end
				end

				return minX, radians, #queue
			end

			index9 = function(key)local y= localPlayer .Character;local currentLength=y and(y.PrimaryPart or(y:FindFirstChild("HumanoidRootPart")));y= smallest and  smallest .Parent and  smallest or(workspace:FindFirstChild("Alive"));local deltaX=type(key)=="string"and y and(y:FindFirstChild(key));key=deltaX and(deltaX.PrimaryPart or(deltaX:FindFirstChild("HumanoidRootPart")));y=currentLength and key and currentLength.Position-key.Position;return y and y.Magnitude>0.001 and y or nil;end
			index10 = function(key,callback)local currentLength=callback.Zoomies;local velocity= compareFunction (key);if not  flags .BackwardsAntiCurveEnabled or not currentLength or key.Parent== CoreGui or velocity== localPlayer .Name then return;end;if key:GetAttribute("DribbleActive")==true then callback.CurveReference=nil;return;end;key=currentLength.VectorVelocity;velocity=key.Magnitude;if velocity~=velocity or velocity==math.huge or velocity<0.001 then return;end;callback.CurveReference=key;end
			index11 = function(key,callback,relativeVelocity,scale)if not  flags .BackwardsAntiCurveEnabled or not key or key.Parent== CoreGui or( index6 (key))then return false;end;if(relativeVelocity or( compareFunction (key)))~= localPlayer .Name then return false;end;local toTarget,length= index7 (key),callback.Magnitude;if length~=length or length==math.huge or length<0.001 then return false;end;local current,currentIndex,currentNode=toTarget.CurveSource,toTarget.CurveTargetDirection,key:GetAttribute("from");if scale and(not current or not currentIndex)then if type(currentNode)=="string"and currentNode~=""and currentNode~= localPlayer .Name then current,currentIndex=currentNode,( index9 (currentNode));end;end;if not current or currentNode~=current or not currentIndex then return false;end;key=currentIndex.Magnitude;if key<0.001 then return false;end;relativeVelocity=toTarget.CurveReference;local x,progress=relativeVelocity and relativeVelocity.Magnitude or 0,currentIndex:Dot(callback)/(key*length);if x<0.001 then return scale and length>=35 and progress<-0.45;end;scale,currentNode=relativeVelocity:Dot(callback)/(x*length),false;if scale>0.2 and progress>=-0.45 and progress<0 then local normal= index9 (current);local deltaY=normal and normal.Magnitude or 0;if deltaY>0.001 then local distance=normal:Dot(callback)/(deltaY*length);currentNode=scale>0.95 and progress<-0.2 and distance<-0.2;if distance<progress then progress,key,currentIndex=distance,deltaY,normal;end;end;end;local normal=currentNode or scale>0.2 and progress<-0.45;if not normal and(math.abs(currentIndex.Y)>key*0.1 or scale>0.2 and progress<-0.2)then local i,deltaY,distance=Vector3.new(relativeVelocity.X,0,relativeVelocity.Z),Vector3.new(callback.X,0,callback.Z),Vector3.new(currentIndex.X,0,currentIndex.Z);local y,currentLength,currentIndex=i.Magnitude,deltaY.Magnitude,distance.Magnitude;if y>x*0.35 and currentLength>length*0.35 and currentIndex>0.001 then normal=i:Dot(deltaY)/(y*currentLength)>0.2 and distance:Dot(deltaY)/(currentIndex*currentLength)<-0.45;if normal and currentIndex<=1 then currentNode= index9 (current);local deltaX=currentNode and(Vector3.new(currentNode.X,0,currentNode.Z));local i=deltaX and deltaX.Magnitude or 0;normal=i>0.001 and deltaX:Dot(deltaY)<-0.45*i*currentLength;end;end;end;if not normal and progress>0.2 and scale<0 then toTarget.CurveReference=nil;end; if normal then
				end return normal ;end

			index12 = function(line)
				local serialized = line.Connections
				local conn = serialized and serialized.CurveVelocity

				if conn then
					conn:Disconnect()
					serialized.CurveVelocity = nil
				end

				line.CurveReference = nil
				line.CurveSource = nil
				line.CurveTargetDirection = nil
				line.CurveReady = nil
				line.CurveVersion = (line.CurveVersion or 0) + 1
			end

			index13 = function(line)
				line.CurveTime = os.clock()
				line.CurveWarping = nil
			end

			index14 = function(line)
				line.CurveTime = nil
				line.CurveWarping = nil
			end

			index15 = function(line, object, descendant, radius, zCoordinate, alpha, color, initialCapacity, targetPosition)
				if not flags.AntiCurveEnabled or not line or line.Parent == CoreGui or index6(line) then
					return false
				end

				if (initialCapacity or compareFunction(line)) ~= localPlayer.Name then
					return false
				end
				radius = radius or index4(line)
				alpha = alpha or radius.Magnitude
				if alpha ~= alpha or alpha == math.huge or alpha < 0.001 then
					return false
				end

				if not object then
					object = localPlayer.Character

					if object then
						object = object:FindFirstChild("HumanoidRootPart") or object.PrimaryPart
					end
				end

				if not object then
					return false
				end

				if not color then
					color = object.Position - (descendant or unexecuteFunction(line))
				end

				zCoordinate = zCoordinate or color.Magnitude
				if zCoordinate ~= zCoordinate or zCoordinate == math.huge or zCoordinate < 0.001 then
					return false
				end
				local radians = index7(line)
				local difference = color:Dot(radius) / zCoordinate * alpha
				local openError = math.min(alpha / 100, 40)
				local step = 7 * math.max(difference, 0)
				local mathMax = 15 - math.min(zCoordinate / 1000, 15) + step + openError

				if zCoordinate < mathMax then
					radians.CurveTime = nil
					radians.CurveWarping = nil
					return false
				end

				local osClock = os.clock()
				targetPosition = targetPosition or normalizeVector()
				local leftChild = math.max(zCoordinate / alpha - targetPosition, 0)

				if difference < 0.85797987377317875 then
					radians.CurveWarping = osClock
				end

				local total = radians.CurveWarping

				if total then
					if osClock - total < leftChild * (1 - math.clamp(difference, 0, 1)) then
						return true
					end
					radians.CurveWarping = nil
				end

				local now = radians.CurveTime

				if now then
					if osClock - now < leftChild / 1.5 and leftChild > mathMax / alpha then
						return true
					end
					radians.CurveTime = nil
				end

				return difference < 0.5 - targetPosition
			end
		end
	end

	top = false
	elapsedTime = 0
	currentDate = nil
	packed = nil

	index16 = function(line)
		top = false
		elapsedTime = 0
		currentDate = nil
		packed = nil
		flyteBBState.SelfDribbleBall = nil
		flyteBBState.SelfDribbleAway = nil
		flyteBBState.AutoBall = nil
		flyteBBState.AutoParryAt = nil
		flyteBBState.ManualBall = nil
		flyteBBState.ExtraParryCooldownUntil = nil
		local radians = playerGui or workspace:FindFirstChild("Balls")
		if not radians then
			return
		end

		for _, existingPlayer in radians:GetChildren() do
			if index5(existingPlayer) then
				local track = index7(existingPlayer)
				track.Parried = false
				track.ParryResetAt = 0
				track.AutoParryAt = nil
				track.TriggerbotParried = false
				track.InvisibleReturnAway = nil
				index14(track)
				local cell

				if line then
					local targetPlayerName = localPlayer.Name
					cell = compareFunction(existingPlayer) == targetPlayerName
				else
					cell = line
				end

				if cell then
					track.TargetChanges = math.max(track.TargetChanges or 0, 2)
				end
			end
		end
	end

	do
		local function normalizeVector(line, object)
			if not features.Ball or not features.Ball.GetAllBalls then
				return
			end
			local query = tostring(line)
			local radians = "Instance"
			local currentPosition = typeof(object) == radians and object:IsA("BasePart") and object.Position
			local angleRadians = nil
			local track = nil
			local vertexCount = nil
			local steering = nil

			for _, weld in features.Ball.GetAllBalls() do
				local exponent = nil

				if currentPosition then
					exponent = (unexecuteFunction(weld) - currentPosition).Magnitude

					if not angleRadians or exponent < angleRadians then
						angleRadians = exponent
						track = weld
					end
				end

				if weld.Name == query and (not vertexCount or exponent and exponent < steering) then
					vertexCount = weld
					steering = exponent
				end
			end

			return vertexCount or track or features.Ball.GetMainBall()
		end

		if replicatedStorage.Remotes:FindFirstChild("ParrySuccessAll") then
			flyteBBState.Connections["Parry All"] = replicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(line, object, descendant, radius, zCoordinate)
					local resourceName = flags.AbilityESPEnabled

					if resourceName then
						resourceName = typeof(radius) == "Instance"
					end

					if resourceName and radius:IsA("Player") and radius ~= localPlayer then
						local model = radius.Character

						if (model and features.Visuals and features.Visuals.GetInfo(radius, model)) == "Slashes of Fury" and model:GetAttribute("FuryCatch") then
							local minX = math.huge
							local currentPosition = typeof(object) == "Instance" and object:IsA("BasePart") and object.Position
							local radians = nil

							for _, existingPlayer in workspace.Balls:GetChildren() do
								if existingPlayer:IsA("BasePart") and not existingPlayer:GetAttribute("realBall") then
									if existingPlayer.Name == tostring(zCoordinate or line) then
										radians = existingPlayer
										break
									elseif currentPosition then
										local exponent = (existingPlayer.Position - currentPosition).Magnitude

										if exponent < minX then
											radians = existingPlayer
											minX = exponent
										end
									end
								end
							end

							if radians then
								local lines = flyteBBState.AbilityUses[radius]

								if not lines or lines.Character ~= model or lines.Ability ~= "Slashes of Fury" then
									features.Visuals.ClearFury(lines)

									lines = {
									Ability = "Slashes of Fury",
									Character = model,
									Uses = 0,
									Started = workspace:GetServerTimeNow(),
								}

									flyteBBState.AbilityUses[radius] = lines
								end

								lines.Uses = math.min(lines.Uses + 1, 35)
								features.Visuals.UpdateFuryCount(radians, lines)
							end
						end
					end

					local model = localPlayer.Character
					local vehicleRoot = model and model.PrimaryPart
					if not vehicleRoot then
						return
					end
					local radians = normalizeVector(line, object)
					if not radians then
						return
					end

					if radius == localPlayer then
						local osClock = os.clock()
						local angleRadians = 1000
						local difference = math.clamp((tonumber(previous()) or 0) / angleRadians + (tonumber(0.001) or 0), 0.15, 1)
						local label = flyteBBState.AutoBall
						local track = label and managerObject[label]
						local cell = label and label.Parent and track and track.AutoParryAt and osClock - track.AutoParryAt <= difference

						if not cell then
							label = radians
						end

						local vertexCount = index7(label)
						local active

						if cell then
							active = cell
						else
							active = vertexCount.AutoParryAt and osClock - vertexCount.AutoParryAt <= difference
						end

						local isArray = not active

						if isArray then
							vertexCount.Parried = true
							vertexCount.ParryResetAt = osClock + 0.6
							top = true
							currentDate = label
							elapsedTime = vertexCount.ParryResetAt
						end

						vertexCount.AutoParryAt = nil

						if flyteBBState.AutoBall == label then
							flyteBBState.AutoBall = nil
						end

						if isArray then
							local targetPlayerName = localPlayer.Name
							isArray = compareFunction(label) == targetPlayerName
						end

						if isArray then
							flyteBBState.ManualBall = label

							if flags.TriggerbotEnabled then
								vertexCount.TriggerbotTarget = localPlayer.Name
								vertexCount.TriggerbotParried = true
							end
						end

						local nearestDistance = active and flags.AutoParryEnabled and features.Loop and features.Loop.MainParryLoop and features.Ball

						if nearestDistance then
							nearestDistance = #features.Ball.GetAllBalls() > 1
						end

						if nearestDistance then
							features.Loop.MainParryLoop()
						end

						return
					end

					local angleRadians = index4(radians)
					local exponent = angleRadians.Magnitude
					if exponent < 0.001 then
						return
					end
					local directionToTarget = angleRadians.Unit
					local difference = vehicleRoot.Position - unexecuteFunction(radians)
					local totalTime = difference.Magnitude
					local index34 = 0.001
					if type(index34) ~= "number" then
						index34 = 0.001
					end

					if totalTime < index34 then
						return
					end
					local track = difference.Unit:Dot(directionToTarget)

					if flags.AutoParryEnabled and exponent > 100 and object and object.Parent and object.Parent ~= model and object.Parent.Parent == smallest and not top then
						local vehicleModel = features.Player and features.Player.GetClosest and features.Player.GetClosest()

						if vehicleModel and vehicleModel.PrimaryPart and (vehicleRoot.Position - vehicleModel.PrimaryPart.Position).Magnitude < 15 and totalTime < 15 and track > -0.25 and index15(radians) then
							top = true
							currentDate = radians
							elapsedTime = os.clock() + 0.6

							if not attemptAutoParry(nil, nil, nil, nil, nil, flags.ParryAccuracy or 50) then
								top = false
								currentDate = nil
							end
						end
					end
				end)
		end
	end
end

local index17, index18, index19

do
	do
		coroutineBody({
			FuryDetection = true,
			FurySpamHit = false,
			FuryParryAmount = 35,
			FuryParryDelay = 0.05,
			FuryParryMethod = "Remote",
		})

		do
			local function runSimulation()
				local function onInputEnded()
					local model = localPlayer.Character
					local rootPart = model and model:FindFirstChild("Abilities")
					rootPart = rootPart and rootPart:FindFirstChild("Slashes of Fury")
					local Player = localPlayer.PlayerGui:FindFirstChild("Hotbar")
					local rectangle = Player and Player:FindFirstChild("Ability") and Player.Ability:FindFirstChild("Red")

					if flags.FuryDetection and model and model.Parent == smallest and rootPart and rootPart.Enabled and rectangle and not rectangle.Visible and #playerGui:GetChildren() > 0 then
						flyteBBState.FuryCatch = true
						flyteBBState.FuryActive = false
					end
				end

				local function handlePlayerRemoving(line)
					if not flags.FuryDetection or not flyteBBState.FuryCatch then
						return
					end
					local radians = line:FindFirstChildOfClass("TextLabel")
					if not radians then
						return
					end
					flyteBBState.FuryActive = true
					local difference = tonumber(radians.Text) or 0
					local lines = {}
					local index23 = flags.FuryParryMethod
					local angleRadians = difference

					while true do
						local osClock = os.clock()
						local index24 = flags.FuryParryMethod
						local userId = tonumber(radians.Text)

						if userId then
							local track

							if index24 == index23 then
								track = difference
							else
								table.clear(lines)
								index23 = index24
								track = userId
								angleRadians = userId
							end

							if index24 == "Remote" then
								difference = math.max(track, userId)
							else
								for k = 1, math.min(math.max(userId - angleRadians, 0), #lines) do
									table.remove(lines, 1)
								end

								while lines[1] and osClock >= lines[1] do
									table.remove(lines, 1)
								end

								local openError = math.max(angleRadians, userId)
								difference = openError + #lines
								angleRadians = openError
							end
						end

						userId = flags.FurySpamHit and userId

						if userId then
							userId = difference < (flags.FuryParryAmount or 35)
						end

						if userId then
							local track

							if index24 == "Remote" and features.Parry and features.Parry.Fire then
								flyteBBState.ParryMethod = "Remote"
								track = features.Parry.Fire()
							else
								track = features.Animation.Input(index24)
							end

							if track then
								difference += 1

								if index24 ~= "Remote" then
									local openError = #lines + 1
									local remaining = math.max
									local vertexCount = 0.15
									lines[openError] = os.clock() + remaining(vertexCount, previous() / 1000 + 0.001)
								end
							end
						end

						local index22 = flags.FuryParryDelay or 0.12
						local taskWait = task.wait
						local cell = index24 == "Remote" and index22

						if not cell then
							cell = math.max(index22 - os.clock() - osClock, 0)
						end

						taskWait(cell)
						if not (not flags.FuryDetection or not flyteBBState.FuryCatch or not radians:IsDescendantOf(workspace)) then
							continue
						end
						break
					end

					flyteBBState.FuryCatch = false
					flyteBBState.FuryActive = false
				end

				local function onTouched(guiObject)
					local query = "Fury Ball " .. guiObject:GetDebugId()
					local existing = guiObject:FindFirstChild("ComboCounter")

					if existing then
						task.spawn(handlePlayerRemoving, existing)
					end

					coroutineFunction(query)

					flyteBBState.Connections[query] = guiObject.ChildAdded:Connect(function(tool)
							if tool.Name == "ComboCounter" then
								handlePlayerRemoving(tool)
							end
						end)
				end

				for _, particle in playerGui:GetChildren() do
					onTouched(particle)
				end

				flyteBBState.Connections["Fury Ball Added"] = playerGui.ChildAdded:Connect(onTouched)

				flyteBBState.Connections["Fury Ball Removed"] = playerGui.ChildRemoved:Connect(function(guiObject)
						coroutineFunction("Fury Ball " .. guiObject:GetDebugId())
					end)

				local UserInputService = require(replicatedStorage.UserInputService)
				local state = require(replicatedStorage.Controllers.SettingsController)
				local result28 = replicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net

				flyteBBState.Connections["Fury Input"] = UserInputService.InputBegan:Connect(function(inputObject, vectorB)
						if not vectorB and state:UseBind(inputObject, "Ability") then
							onInputEnded()
						end
					end)

				flyteBBState.Connections["Fury Button"] = left.Event:Connect(onInputEnded)

				flyteBBState.Connections["Fury Catch"] = result28["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
						flyteBBState.FuryCatch = true
						flyteBBState.FuryActive = false
					end)

				flyteBBState.Connections["Fury End"] = result28["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
						flyteBBState.FuryCatch = false
						flyteBBState.FuryActive = false
					end)
			end

			attemptAutoParry = function(player15, line, object, descendant, radius, zCoordinate)
				local model = localPlayer.Character
				if not undoFunction(model) then
					return false
				end

				if continuation(model) then
					return false
				end

				if not player15 then
					player15 = features.Ball and features.Ball.GetMainBall and features.Ball.GetMainBall()
				end

				if not player15 then
					return false
				end
				line = line or flags.AutoParryType

				if line == "Remote" then
					if features.Parry and features.Parry.Fire then
						flyteBBState.ParryMethod = "Remote"
						local cell = not descendant

						if cell then
							local targetPlayerName = localPlayer.Name
							cell = compareFunction(player15) ~= targetPlayerName
						end

						if cell then
							return false
						end

						if index6(player15) then
							flyteBBState.ParryMethod = "VIM"
							if not features.Animation.VIM() then
								return false
							end
						else
							local osClock = os.clock()

							if flyteBBState.ParryCooldownUntil and osClock >= flyteBBState.ParryCooldownUntil then
								flyteBBState.AutoParryAnimationPlayed = nil
							end

							local active = not flyteBBState.AutoParryAnimationPlayed and (not flyteBBState.ParryCooldownUntil or osClock >= flyteBBState.ParryCooldownUntil)
							local radians, angleRadians = features.Parry.Fire(object and features.Curve.GetCFrame() or nil)
							if not radians then
								return false
							end

							if active and flyteBBState.ParryMethod == "Remote" then
								if angleRadians or features.Animation.PlayAnimation(true) then
									flyteBBState.AutoParryAnimationPlayed = true
								end
							end
						end
					end
				else
					local cell = not descendant

					if cell then
						local targetPlayerName = localPlayer.Name
						cell = compareFunction(player15) ~= targetPlayerName
					end

					if cell then
						return false
					end
					local difference = 0

					if line == "Mouse Click" and zCoordinate then
						local vehicleRoot = model.PrimaryPart
						local exponent = index4(player15).Magnitude

						if vehicleRoot and exponent > 0 then
							local openError = (vehicleRoot.Position - unexecuteFunction(player15)).Magnitude / exponent
							local step = math.clamp((zCoordinate - 1) / 99, 0, 1)
							difference = math.clamp(openError * (0.16 - step * 0.07), 0.02 - step * 0.008, 0.055 - step * 0.01)
						end
					end

					if not features.Animation.Input(line, nil, difference) then
						return false
					end
				end

				if flags.AutoSpamEnabled then
					local osClock = os.clock()

					while flyteBBState.SpamParries[1] and flyteBBState.SpamParries[1] < osClock - 0.75 do
						table.remove(flyteBBState.SpamParries, 1)
					end

					flyteBBState.SpamParries[#flyteBBState.SpamParries + 1] = osClock
					local cell = not descendant

					if cell then
						local targetPlayerName = localPlayer.Name
						cell = compareFunction(player15) == targetPlayerName
					end

					if cell then
						flyteBBState.SpamBall = player15
						flyteBBState.SpamTargetAt = osClock
					end
				end

				flyteBBState.PreclickFired = nil
				flyteBBState.PreclickCooldown = nil
				flyteBBState.ParryActiveUntil = os.clock() + math.max(0, 0.5 - (radius or previous()) / 2000)
				flyteBBState.CooldownProtected = nil
				return true
			end

			local function onInputEnded()
				if flyteBBState.InfinityParried or not flags.InfinityDetection then
					return false
				end
				local result8 = features.Ball and features.Ball.GetMainBall and features.Ball.GetMainBall()
				local model = localPlayer.Character
				model = model and model:FindFirstChild("HumanoidRootPart")
				local cell = not result8 or not model

				if not cell then
					local targetPlayerName = localPlayer.Name
					cell = compareFunction(result8) ~= targetPlayerName
				end

				if not cell then
					local currentPosition = model.Position
					cell = (unexecuteFunction(result8) - currentPosition).Magnitude > 10
				end

				if cell then
					return false
				end
				flyteBBState.InfinityParried = true
				local radians = index7(result8)

				if radians then
					radians.Parried = true
					radians.ParryResetAt = os.clock() + 0.6
				end

				top = true
				currentDate = result8
				elapsedTime = os.clock() + 0.6
				if attemptAutoParry(result8, flags.AutoParryType, true) then
					return true
				end

				if radians then
					radians.Parried = false
				end

				top = false
				currentDate = nil
				flyteBBState.InfinityParried = false
				return false
			end

			coroutineBody({
				InfinityDetection = true,
				FreezeDetection = false,
				DeathSlashDetection = true,
				DeathSlashMinigame = false,
				SingularityDetection = true,
				TimeHoleDetection = true,
				ForcefieldDetection = false,
				ParryOnDribble = false,
				DribbleDetection = false,
			})

			features.Detection = {}

			features.Detection.GetDribbleBall = function(line)
				local cell = not flags.ParryOnDribble or not line or not index5(line) or line:GetAttribute("DribbleActive") ~= true

				if not cell then
					local targetPlayerName = localPlayer.Name
					cell = compareFunction(line) == targetPlayerName
				end

				if cell then
					return
				end
				local radians = playerGui
				local angleRadians

				if playerGui then
					angleRadians = radians
				else
					angleRadians = workspace:FindFirstChild("Balls")
				end

				if not angleRadians then
					return
				end

				for _, propertyName in angleRadians:GetChildren() do
					if propertyName ~= line and propertyName.Name == line.Name and not index5(propertyName) and propertyName:GetAttribute("highlighted") == true then
						return line
					end
				end
			end

			features.Detection.GetSelfDribbleBall = function(player14, line)
				if not flags.DribbleDetection then
					flyteBBState.SelfDribbleBall = nil
					flyteBBState.SelfDribbleAway = nil
					return nil, false
				end

				local cell = not player14.Parent or not index5(player14) or player14:GetAttribute("DribbleActive") ~= true
				local active

				if cell then
					active = cell
				else
					local targetPlayerName = localPlayer.Name
					active = compareFunction(player14) ~= targetPlayerName
				end

				if active then
					if flyteBBState.SelfDribbleBall == player14 then
						flyteBBState.SelfDribbleBall = nil
						flyteBBState.SelfDribbleAway = nil
					end

					return nil, false
				end

				if flyteBBState.SelfDribbleBall ~= player14 then
					flyteBBState.SelfDribbleBall = player14
					flyteBBState.SelfDribbleAway = false
				end

				local isArray = (line.Position - unexecuteFunction(player14)):Dot(index4(player14)) > 0

				if not isArray then
					flyteBBState.SelfDribbleAway = true
				end

				return player14, flyteBBState.SelfDribbleAway and isArray
			end

			features.Detection.TrackAbilityUse = function(line, object, descendant, quantity, radius)
				local index51 = workspace:GetServerTimeNow()
				local lines = flyteBBState.AbilityUses[line]

				if not lines or lines.Ability ~= descendant or lines.Character ~= object then
					lines = { Ability = descendant, Character = object, Recoveries = {} }
					flyteBBState.AbilityUses[line] = lines
				end

				for k = #lines.Recoveries, 1, -1 do
					if lines.Recoveries[k] <= index51 then
						table.remove(lines.Recoveries, k)
					end
				end

				lines.Maximum = quantity

				if #lines.Recoveries < quantity then
					lines.Recoveries[#lines.Recoveries + 1] = index51 + radius
				end
			end

			index17 = function(line, object)
				local cell = flags.FreezeDetection and line:GetAttribute("Frozen") == true

				if cell then
					cell = (object or compareFunction(line)) == localPlayer.Name
				end

				local active

				if cell then
					active = not (flags.AutoPlayEnabled and flags.HitFreeze)
				else
					active = cell
				end

				return active
			end

			features.Detection.BlocksParry = function(line, object, descendant)
				local explosion = descendant or object and object:FindFirstChild("HumanoidRootPart")
				if not explosion then
					return true
				end

				if line and index17(line) then
					return true
				end
				local player25 = newRoot:FindFirstChild("Tornado")

				if player25 then
					local callbackFunction = player25:GetAttribute("TornadoTime")

					if flyteBBState.Tornado ~= player25 or flyteBBState.TornadoDuration ~= callbackFunction or not flyteBBState.TornadoAt then
						flyteBBState.Tornado = player25
						flyteBBState.TornadoDuration = callbackFunction
						flyteBBState.TornadoAt = tick()
					end

					local index56 = flyteBBState.TornadoAt
					if tick() - index56 < (callbackFunction or 1) + 0.314159 then
						return true
					end
				elseif flyteBBState.Tornado then
					flyteBBState.Tornado = nil
					flyteBBState.TornadoDuration = nil
					flyteBBState.TornadoAt = nil
				end

				if flags.SingularityDetection and explosion:FindFirstChild("SingularityCape") then
					return true
				end

				if flags.FuryDetection and (flyteBBState.FuryCatch or flyteBBState.FuryActive) then
					return true
				end

				if flags.DeathSlashDetection and flyteBBState.DeathSlash then
					return true
				end
				local rootPart = object:FindFirstChild("Abilities")
				local result76 = PlayerGui and PlayerGui.Visible
				local effectInstance = rootPart and rootPart:FindFirstChild("Time Hole")
				if flags.TimeHoleDetection and (flyteBBState.TimeHole or result76 and effectInstance and effectInstance.Enabled) then
					return true
				end

				if flags.InfinityDetection and (flyteBBState.InfinityActive or updateFunction("Infinity")) then
					return true
				end

				if flags.ForcefieldDetection and updateFunction("Forcefield") and (explosion:FindFirstChild("MaxShield") or explosion:FindFirstChild("Shield")) then
					return true
				end
				return false, rootPart
			end

			flyteBBState.Connections["Parry Cooldown"] = replicatedStorage.Remotes.VisualCD.OnClientEvent:Connect(function(line, object, descendant)
					if not line then
						return
					end
					local osClock = os.clock()

					if object then
						flyteBBState.ParryCooldownUntil = osClock + (tonumber(descendant) or 1.3)
						local radians = 1000
						local difference = math.clamp(previous() / radians + 0.1, 0.15, 1)

						if not (flyteBBState.AutoBall or flyteBBState.AutoParryAt and osClock - flyteBBState.AutoParryAt <= difference) and not (flyteBBState.AutoSpamParryAt and osClock - flyteBBState.AutoSpamParryAt <= difference) then
							flyteBBState.ExtraParryCooldownUntil = flyteBBState.ParryCooldownUntil
						end

						flyteBBState.PreclickCooldown = flyteBBState.PreclickFired or nil
						flyteBBState.PreclickFired = nil
						flyteBBState.ParryActiveUntil = osClock + math.max(0, 0.5 - previous() / 2000)
						flyteBBState.CooldownProtected = nil
					else
						flyteBBState.ParryCooldownUntil = nil
						flyteBBState.ExtraParryCooldownUntil = nil
						flyteBBState.AutoParryAt = nil
						flyteBBState.AutoParryAnimationPlayed = nil
						flyteBBState.PreclickCooldown = nil
						flyteBBState.CooldownProtected = nil
						flyteBBState.ManualBall = nil

						if flags.TriggerbotEnabled then
							features.Triggerbot.Update()
						elseif flags.AutoParryEnabled then
							task.spawn(features.Loop.MainParryLoop)
						end
					end
				end)

			features.Detection.UseProtection = function(line, object)
				local osClock = os.clock()

				if not (flyteBBState.ParryCooldownUntil and osClock < flyteBBState.ParryCooldownUntil or bottomSnapZone and bottomSnapZone.Offset.Y < 0.49) then
					flyteBBState.ParryCooldownUntil = nil
					flyteBBState.PreclickFired = nil
					flyteBBState.PreclickCooldown = nil
					flyteBBState.CooldownProtected = nil
				elseif flags.CooldownProtectionEnabled then
					if flyteBBState.CooldownProtected then
						return true
					end

					if osClock < (flyteBBState.ParryActiveUntil or 0) then
						return true
					end
					local result8 = features.Ball and features.Ball.GetMainBall and features.Ball.GetMainBall()
					local exponent = (result8 and index4(result8) or Vector3.zero).Magnitude
					local cell = not result8 or exponent < 35
					local active

					if cell then
						active = cell
					else
						local targetPlayerName = localPlayer.Name
						active = compareFunction(result8) ~= targetPlayerName
					end

					if active then
						return true
					end

					if flyteBBState.PreclickCooldown then
						local difference = previous() / 1000
						if math.max(0, (line.PrimaryPart.Position - unexecuteFunction(result8)).Magnitude - 5) / exponent - difference > math.max(0, 0.5 - difference) then
							return true
						end
					end

					if knob and knob.Offset.Y >= 0.49 then
						flyteBBState.CooldownProtected = true
						left:Fire()
						return true, true
					end

					return true
				end

				if object then
					return false
				end

				if flags.AutoAbilityEnabled then
					line = line and line:FindFirstChild("Abilities")

					if features.Ball and features.Ball.GetMainBall then
						features.Ball.GetMainBall()
					end

					if wrapper(line) then
						return true, true
					end
				end

				return false
			end

			local function handlePlayerRemoving()
				local initialValue

				while true do
					initialValue = localPlayer.PlayerGui:FindFirstChild("DeathSlashTimer")
					initialValue = initialValue and initialValue:FindFirstChild("Frame")

					if not initialValue then
						runService.PreRender:Wait()
					end

					if not (initialValue or not flyteBBState.DeathSlash or not flags.DeathSlashDetection or not flags.DeathSlashMinigame) then
						continue
					end
					break
				end

				if not initialValue or not flyteBBState.DeathSlash or not flags.DeathSlashDetection or not flags.DeathSlashMinigame then
					return
				end

				while true do
					runService.PreRender:Wait()
					if not (not flyteBBState.DeathSlash or not flags.DeathSlashDetection or not flags.DeathSlashMinigame or initialValue.Visible) then
						continue
					end
					break
				end

				local image = initialValue:FindFirstChild("ImageLabel")
				local handle = initialValue:FindFirstChild("Circle")
				local newPart = initialValue:FindFirstChild("Inner")
				local difference = handle and newPart and (handle.Size.X.Scale + newPart.Size.X.Scale) / 2

				while flyteBBState.DeathSlash and flags.DeathSlashDetection and flags.DeathSlashMinigame and initialValue.Visible and image and difference do
					if image.Size.X.Scale <= difference then
						left:Fire()
						return
					end
					runService.PreRender:Wait()
				end
			end

			features.Detection.Start = function()
				flyteBBState.Connections.Infinity = replicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(line, object)
						local success6 = flyteBBState.InfinityActive

						if object then
							if updateFunction("Infinity") then
								flyteBBState.InfinityActive = true
								flyteBBState.InfinityParried = false
							end
						elseif success6 then
							flyteBBState.InfinityActive = false

							if flags.InfinityDetection then
								task.defer(onInputEnded)
							end
						end
					end)

				flyteBBState.Connections["Death Slash"] = replicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(line, object)
						if line ~= localPlayer and line ~= localPlayer.Name then
							return
						end
						local output = flyteBBState.DeathSlash
						flyteBBState.DeathSlash = object == true

						if flyteBBState.DeathSlash and not output and flags.DeathSlashDetection and flags.DeathSlashMinigame then
							task.spawn(handlePlayerRemoving)
						end
					end)

				task.spawn(function()
						local result28 = replicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net

						flyteBBState.Connections["Time Hole"] = result28["RE/TimeHoleActivate"].OnClientEvent:Connect(function(line)
							if line == localPlayer or line == localPlayer.Name then
								flyteBBState.TimeHole = true
							end
						end)

						flyteBBState.Connections["Time Hole End"] = result28["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
							flyteBBState.TimeHole = false
						end)
					end)
			end

			features.Detection.Start()
			runSimulation()
		end
	end

	do
		local index20, index21

		do
			features.Staff = {
				Group = 12836673,
				Roles = {
				Mod = true,
				Support = true,
				Admin = true,
				Developer = true,
				["Lead Developer"] = true,
				Management = true,
				Executive = true,
				["Co-Owner"] = true,
				Contributor = true,
				["Trial QA"] = true,
				Holder = true,
			},
			}

			coroutineBody({ StaffDetection = false, StaffDetectionMode = "warn" })

			features.Staff.Check = function(line)
				if line == localPlayer then
					return
				end

				if flyteBBState.StaffDetected[line] or line.Parent ~= playersService then
					return
				end
				local decoded, loadError = pcall(line.GetRoleInGroup, line, features.Staff.Group)

				if decoded and features.Staff.Roles[loadError] then
					flyteBBState.StaffDetected[line] = true
					local query = "Staff Detected: " .. line.Name .. " | " .. loadError

					if flags.StaffDetectionMode == "kick" then
						localPlayer:Kick(query)
					else
						window:Notify({ Title = query, Duration = 15, Icon = "rbxassetid://128616761621643" })
					end
				end
			end

			features.Staff.Set = function(line)
				if not line then
					coroutineFunction("Staff")
					table.clear(flyteBBState.StaffDetected)
					return
				end

				for _, particle in playersService:GetPlayers() do
					features.Staff.Check(particle)
				end

				flyteBBState.Connections.Staff = playersService.PlayerAdded:Connect(function(player9)
						task.wait(1)

						if flags.StaffDetection then
							features.Staff.Check(player9)
						end
					end)
			end

			coroutineBody({ DeviceSpoofType = "PC" })
			features.DeviceSpoof = {}

			features.DeviceSpoof.Apply = function()
				local query = [[local Source = %q
					if not game:IsLoaded() then game.Loaded:Wait() end
					local Queue = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
					local Players = game:GetService('Players')
					local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
					local Environment = getgenv()
					if Environment.FlyteDeviceSpoofQueue then
						Environment.FlyteDeviceSpoofQueue:Disconnect()
					end
					local Queued = false
					Environment.FlyteDeviceSpoofQueue = Player.OnTeleport:Connect(function()
						if not Queued then
							Queue(Source:format(Source))
							Queued = true
						end
					end)
					local Device = ]] .. httpService:JSONEncode(flags.DeviceSpoofType == "Mobile" and "Phone" or flags.DeviceSpoofType) .. "if game.GameId ~= " .. tostring(game.GameId) .. [[ then return end
					local Previous = Environment.FlyteDeviceSpoofRun
					if Previous and Previous.JobId == game.JobId and Previous.Device == Device then return end
					if Previous and Previous.Restore then Previous.Restore() end
					local Run = {Device = Device, JobId = game.JobId}
					Environment.FlyteDeviceSpoofRun = Run
					while not workspace:GetAttribute('ClientModulesLoaded') do
						workspace:GetAttributeChangedSignal('ClientModulesLoaded'):Wait()
					end
					if Environment.FlyteDeviceSpoofRun ~= Run then return end
					local ReplicatedStorage = game:GetService('ReplicatedStorage')
					local Listener = require(ReplicatedStorage:WaitForChild('ClientGameModules'):WaitForChild('DeviceListener'))
					local Observe = Listener.Observe

					local function Apply(Callback)
						if Run.Restore then Run.Restore() end
						task.spawn(function()
							local Success, Result = pcall(function()
								Callback(Device)
								Callback(Listener.Device)
							end)
							if not Success then
								Environment.FlyteDeviceSpoofRun = nil
								error(Result, 0)
							end
							Environment.FlyteDeviceSpoofApplied = {Device = Device, JobId = game.JobId}
						end)
					end

					for _, Connection in Listener.OnChange:GetConnections() do
						if debug.info(Connection._fn, 's') == 'ReplicatedStorage.Controllers.PlayerProfileController' then
							Apply(Connection._fn)
							return
						end
					end

					local function ObserveDevice(Self, Callback)
						if debug.info(Callback, 's') == 'ReplicatedStorage.Controllers.PlayerProfileController' then
							Apply(Callback)
							return Self.OnChange:Connect(Callback)
						end

						return Observe(Self, Callback)
					end

					Run.Restore = function()
						if Listener.Observe == ObserveDevice then Listener.Observe = Observe end
						Run.Restore = nil
					end
					Listener.Observe = ObserveDevice
					]]

				local concatenated = query:format(query)

				if globalEnvironment.FlyteDeviceSpoofQueue then
					globalEnvironment.FlyteDeviceSpoofQueue:Disconnect()
					globalEnvironment.FlyteDeviceSpoofQueue = nil
				end
				;(queue_on_teleport or queueonteleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport)(concatenated)
				window:Notify({ Title = "Rejoining...", Duration = 1 })
				task.wait(0.2)

				if not pcall(teleportService.TeleportToPlaceInstance, teleportService, game.PlaceId, game.JobId, localPlayer) then
					game.ExperienceService:LaunchExperience({ placeId = game.PlaceId, gameInstanceId = game.JobId })
				end
			end

			features.LoadCurves = function()
				features.Curve = {}
				features.Curve.Random = Random.new()

				features.Curve.GetCFrame = function(line, object)
					local index49 = flags.SelectedParryType or "Camera"
					local currentCFrame = primaryPart.CFrame
					if index49 == "Camera" or index49 == "BB Camera" then
						return currentCFrame
					end
					local explosion = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
					if not explosion then
						return currentCFrame
					end

					if index49 == "Randomized Backwards" then
						local cframe = explosion.CFrame
						local radians = features.Curve.Random:NextNumber(0, 6.2831853071795862)
						local angleRadians = features.Curve.Random:NextNumber(0.2, 0.7)
						local upVector = cframe.UpVector
						return CFrame.lookAt(explosion.Position, explosion.Position + (-cframe.LookVector + (cframe.RightVector * math.cos(radians) + upVector * math.sin(radians)) * angleRadians).Unit * 10000)
					end

					if index49 == "Backwards" then
						local difference = -currentCFrame.LookVector * 10000
						return CFrame.new(currentCFrame.Position, currentCFrame.Position + Vector3.new(difference.X, 0, difference.Z)), nil
					end
					line = line or features.Player.GetClosest()

					if line then
						line = line:IsA("BasePart") and line or line.PrimaryPart or line:FindFirstChild("HumanoidRootPart")
					end

					if line and object then
						local radians = primaryPart:WorldToScreenPoint(line.Position)
						local angleRadians = 2
						local screenHeight = radians.Y
						object[1] = radians.X
						object[angleRadians] = screenHeight
					end

					if index49 == "Stop" then
						return CFrame.new(explosion.Position, explosion.Position + Vector3.new(0, -3500, 0))
					end

					if index49 == "Random" then
						line = line and line.Position - explosion.Position
						local steer = line or currentCFrame.LookVector
						if steer.Magnitude < 0.001 then
							return currentCFrame
						end
						local directionToTarget = steer.Unit
						local directionVector = directionToTarget:Cross(math.abs(directionToTarget.Y) < 0.9 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)).Unit
						local radians = directionVector:Cross(directionToTarget)
						local angleRadians = features.Curve.Random:NextNumber(0, 6.2831853071795862)
						local randomGenerator = features.Curve.Random
						return CFrame.new(explosion.Position, explosion.Position + (directionVector * math.cos(angleRadians) + radians * math.sin(angleRadians) - directionToTarget * randomGenerator:NextNumber(0.25, 0.8)).Unit * 1500)
					end

					if index49 == "High" then
						return CFrame.new(explosion.Position, explosion.Position + Vector3.new(0, 9e18, 0))
					end

					if not line then
						return explosion.CFrame
					end
					local currentPosition = line.Position
					if index49 == "Straight" then
						return CFrame.new(explosion.Position, currentPosition + Vector3.new(0, 10, 0))
					end

					if index49 == "Dot" then
						return (currentPosition - explosion.Position).Magnitude > 0.001 and CFrame.lookAt(explosion.Position, currentPosition) or explosion.CFrame
					end
					return explosion.CFrame
				end
			end

			features.LoadCurves()

			features.LoadParry = function()
				local Players = game:GetService("CollectionService")
				local lines = {}
				local sourceTable = { 0, 0 }
				local players = { 1.5, 1.25, 1, 0.75, 0.625 }
				local HttpService = require(replicatedStorage.ServerInfo)
				local bit = require(replicatedStorage.Shared.UniverseIds)
				local cell = not HttpService.isDungeonsMatchServer() and game.PlaceId ~= bit.RankedMatches.PlaceId and game.PlaceId ~= bit.RankedMatchesNoAbility.PlaceId and not HttpService.isMedalServer() and not HttpService.isClanWarServer() and not HttpService.isTournamentMatchServer()
				local fileHandle

				if cell then
					fileHandle = require(replicatedStorage.Common.Utils).FFlag.GetInstantFFlag("NoobParryEnabled", true)
				else
					fileHandle = cell
				end

				local parry_signal = require(replicatedStorage.Packages.Signal).new()
				parry_signal:Connect(require(replicatedStorage.Controllers["SwordsController \12"].PRY))
				local steering = parry_signal

				local function handlePlayerRemoving()
					return nil, {}
				end

				local radians, angleRadians = handlePlayerRemoving()
				local vertexCount = nil
				local result58 = nil
				local sorted = {}
				local active = identifyexecutor() == "Volt"
				local major = nil
				local byte = nil
				local result68 = newcclosure

				local function onTouched()
					local difference = players[(Data:Get("timesParried") or 0) + 1] or 0.5
					if not fileHandle then
						return difference
					end
					local elapsed = Data:Get("TotalStats.Kills") or 0
					return elapsed < 20 and difference * elapsed / 20 or difference
				end

				local function heartbeatUpdate(line, object, descendant, radius, zCoordinate)
					result58 = result58 or radians(vertexCount, "TIME")
					local query = tostring(math.floor(workspace:GetServerTimeNow() * 100))
					table.clear(sorted)

					for k = 1, #query do
						local Graph = string.byte
						local difference = (k - 1) % #result58 + 1
						sorted[k] = string.char(bit32.bxor((string.byte(query, k) + k) % 256, Graph(result58, difference)))
					end

					local concatenated = table.concat(sorted)

					for k = 1, line do
						v117(nil, angleRadians, vertexCount, concatenated, object, descendant, radius, zCoordinate, false)
					end
				end

				features.Parry = {}

				features.Parry.NativeClick = function()
					if active then
						if not major or not major.Enabled then
							major = nil
							local Player = localPlayer.PlayerGui:FindFirstChild("Hotbar")
							Player = Player and Player:FindFirstChild("Block")

							if Player then
								for _, pointIndex in getconnections(Player.Activated) do
									local edgeIterator = pointIndex.Function
									if pointIndex.Enabled and edgeIterator and getfenv(edgeIterator).script == result56 then
										major = pointIndex
										break
									end
								end
							end
						end

						if major then
							major:Fire()
							return true
						end
					end

					return simulateClick()
				end

				local function onInputChanged(line)
					if line then
						return false
					end
					local index49 = flags.SelectedParryType or "Camera"
					return index49 ~= nil and index49 ~= "BB Camera" and index49 ~= "Backwards" and index49 ~= "Randomized Backwards"
				end

				local function vectorLength(line, object, descendant)
					line = line or lines
					object = object or sourceTable
					table.clear(line)
					local model = localPlayer.Character
					local isArray = flags.SelectedParryType == "BB Camera"
					local bestLabel = model and model.Parent ~= smallest and isInTrainingArea(model)

					if isArray then
						bestLabel = model and model.Parent == workspace.Dead and localPlayer:GetAttribute("LobbyTraining")
					end

					local horizontalVelocity

					if userInputService.TouchEnabled then
						local viewportSize = primaryPart.ViewportSize
						horizontalVelocity = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
					else
						horizontalVelocity = userInputService:GetMouseLocation()
					end

					local screenHeight = horizontalVelocity.Y
					object[1] = horizontalVelocity.X
					object[2] = screenHeight

					if isArray and bestLabel then
						for _, pointIndex in workspace.Dead:GetChildren() do
							local hitPlayer = playersService:GetPlayerFromCharacter(pointIndex)
							local explosion = pointIndex:FindFirstChild("HumanoidRootPart")

							if hitPlayer and hitPlayer:GetAttribute("LobbyTraining") and explosion then
								line[pointIndex.Name] = primaryPart:WorldToScreenPoint(explosion.Position)
							end
						end

						for _, pointIndex in Players:GetTagged("LobbyTrainingTarget") do
							line[pointIndex.Name] = primaryPart:WorldToScreenPoint(pointIndex.Position)
						end

						return line, object
					end

					local minX = math.huge
					local queue

					if bestLabel then
						queue = jsonEncode()
					else
						local checkpointFolder = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
						queue = nil

						if checkpointFolder then
							smallest = checkpointFolder
							queue = checkpointFolder:GetChildren()
						end
					end

					if not queue then
						return line, object
					end
					local slider

					for _, npcModel in pairs(queue) do
						local vehicleRoot = bestLabel and npcModel or npcModel.PrimaryPart

						if not bestLabel and isArray then
							vehicleRoot = npcModel:FindFirstChild("HumanoidRootPart")
						end

						local bestPair

						if vehicleRoot then
							bestPair = not bestLabel

							if not bestPair then
								bestPair = npcModel.Parent

								if bestPair then
									bestPair = (npcModel:GetAttribute(nil) or 1) > 0
								end
							end
						else
							bestPair = vehicleRoot
						end

						if bestPair then
							local screenPoint, result69 = primaryPart:WorldToScreenPoint(vehicleRoot.Position)
							line[npcModel.Name] = screenPoint

							if descendant and npcModel ~= model and result69 then
								local difference = screenPoint.X - horizontalVelocity.X
								local openError = screenPoint.Y - horizontalVelocity.Y
								local step = difference * difference + openError * openError

								if step < minX then
									minX = step
									slider = npcModel
								end
							end
						elseif descendant and not bestLabel and npcModel ~= model then
							local explosion = npcModel:FindFirstChild("HumanoidRootPart")

							if explosion then
								local screenPoint, result69 = primaryPart:WorldToScreenPoint(explosion.Position)
								local difference = screenPoint.X - horizontalVelocity.X
								local openError = screenPoint.Y - horizontalVelocity.Y
								local step = difference * difference + openError * openError

								if result69 and step < minX then
									minX = step
									slider = npcModel
								end
							end
						end
					end

					return line, object, slider
				end

				features.Parry.GetData = function(line, object)
					local neighbors = object or { {}, { 0, 0 } }
					local slider, newPrice, screenPoint = vectorLength(neighbors[1], neighbors[2], onInputChanged(line))
					line = line or features.Curve.GetCFrame(screenPoint, newPrice)
					neighbors[1] = slider
					neighbors[2] = newPrice
					neighbors[3] = line
					return neighbors
				end

				features.Parry.Fire = function(line, object, descendant, radius)
					local model = localPlayer.Character
					if model and continuation(model) then
						return false
					end
					local slider, newPrice

					if descendant then
						slider = descendant[1]
						newPrice = descendant[2]
						line = descendant[3]
					else
						local screenPoint
						slider, newPrice, screenPoint = vectorLength(nil, nil, onInputChanged(line))
						line = line or features.Curve.GetCFrame(screenPoint, newPrice)
					end

					local parryTiming = onTouched()
					local parryFrame = line
					radius = radius or 1
					local parryTarget = slider
					local parryCoordinates = newPrice

					if userInputService.TouchEnabled then
						parryTiming = 0.5
						parryFrame = workspace.CurrentCamera and workspace.CurrentCamera.CFrame or line
						parryTarget = {}
						parryCoordinates = { 0, 0 }
					end

					if vertexCount then
						heartbeatUpdate(radius, parryTiming, parryFrame, parryTarget, parryCoordinates)
						return true
					end

					for k = 1, radius do
						parry_signal:Fire(parryTiming, parryFrame, parryTarget, parryCoordinates, false)

						if vertexCount then
							local difference = radius - k

							if difference > 0 then
								heartbeatUpdate(difference, parryTiming, parryFrame, parryTarget, parryCoordinates)
							end

							break
						end
					end

					return true
				end

				local index2 = features.Parry.Fire
				getgenv().FlyteParry = index2
			end

			features.LoadParry()

			coroutineBody({
				AutoPreclickEnabled = false,
				PreclickForAll = false,
				PreclickAfterVelocity = 0,
				PreclickDelay = 135,
			})

			flyteBBState.PreclickQueue = {}

			index18 = function()
				coroutineFunction("Preclick")
			end

			index20 = function()
				local model = localPlayer.Character
				return model and model.Parent == smallest and not continuation(model) and not model:GetAttribute("DEATH_SLASH_STANCE") and not model:GetAttribute("IsRagingDeflection") and not model:GetAttribute("IsRapture") and not updateFunction("Infinity") and not updateFunction("Forcefield")
			end

			do
				local function handlePlayerRemoving()
					if not index20() then
						return false
					end
					local radians

					if (userInputService.TouchEnabled or flags.AutoParryType == "Remote") and features.Parry and features.Parry.Fire then
						flyteBBState.ParryMethod = "Remote"
						local angleRadians
						radians, angleRadians = features.Parry.Fire(nil, true)

						if radians and not angleRadians then
							features.Animation.PlayAnimation(true)
						end
					else
						if userInputService.TouchEnabled or flags.AutoParryType == "Remote" then
							return false
						end
						flyteBBState.ParryMethod = "VIM"
						radians = features.Animation.VIM(true)
					end

					if radians then
						flyteBBState.PreclickFired = true
					end

					return radians
				end

				index21 = function()
					if flyteBBState.Connections.Preclick then
						return
					end

					flyteBBState.Connections.Preclick = runService.Heartbeat:Connect(function()
							local openSet = flyteBBState.PreclickQueue
							if not openSet or #openSet <= 0 then
								index18()
								return
							end
							local model = localPlayer.Character
							if not model or not model.Parent or model.Parent ~= smallest then
								return
							end

							for k = #openSet, 1, -1 do
								local radians = openSet[k]
								local neighborY = radians.FireAt

								if os.clock() >= neighborY then
									if (flags.PreclickAfterVelocity or 0) <= radians.Speed then
										handlePlayerRemoving()
									end

									table.remove(openSet, k)
								end
							end

							if #openSet <= 0 then
								index18()
							end
						end)
				end
			end
		end

		do
			local function handlePlayerRemoving(line)
				if not index20() then
					return
				end
				table.insert(flyteBBState.PreclickQueue, { FireAt = os.clock() + (flags.PreclickDelay or 135) / 1000, Speed = index4(line).Magnitude })
				index21()
			end

			index19 = function()
				if flyteBBState.Connections["Auto Preclick"] then
					return
				end
				local socket = require(replicatedStorage.Controllers.VFXController)
				if not getupvalues then
					return
				end
				local radians = nil

				for _, existingPlayer in getupvalues(socket.Start) do
					if typeof(existingPlayer) == "Instance" and existingPlayer:IsA("RemoteEvent") then
						radians = existingPlayer
						break
					else
						radians = nil
					end
				end

				if not radians then
					return
				end

				flyteBBState.Connections["Auto Preclick"] = radians.OnClientEvent:Connect(function(line, object, descendant, radius, zCoordinate, alpha)
						if not flags.AutoPreclickEnabled or not alpha or radius == localPlayer.Character then
							return
						end

						if flags.PreclickForAll or zCoordinate == localPlayer.Character then
							handlePlayerRemoving(descendant)
						end
					end)
			end
		end
	end
end

local index20

do
	do
		index20 = function()
			coroutineFunction("Auto Preclick")
			index18()

			if flyteBBState.PreclickQueue then
				table.clear(flyteBBState.PreclickQueue)
			end
		end

		features.LoadAnimations = function()
			features.Animation = {}
			features.Animation.Controller = require(replicatedStorage.Controllers.AnimationController)
			features.Animation.SwordAPI = require(replicatedStorage.Shared.SwordAPI)
			local difference = 0
			local cell = false
			local radians = 0
			local active = false
			local lines = {}

			local function onInputEnded(line)
				local angleRadians = lines[line]

				if not angleRadians then
					local result55 = features.UnlockAll and features.UnlockAll.SwordData
					result55 = result55 and result55[line] or replicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(line)
					lines[line] = result55
					angleRadians = result55
				end

				return angleRadians
			end

			features.Animation.Reset = function()
				radians += 1

				if active then
					active = false
					mouse1release()
				end

				if type(flyteBBState.GrabAnimation) == "table" then
					for _, existingPlayer in pairs(flyteBBState.GrabAnimation) do
						pcall(existingPlayer.Stop, existingPlayer, 0)
					end

					table.clear(flyteBBState.GrabAnimation)
				end

				difference = 0
				cell = true
				flyteBBState.AutoParryAnimationPlayed = nil
			end

			features.Animation.GetSword = function(line)
				local callbackFunction = line and line:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword")

				if features.UnlockAll and features.UnlockAll.Status == "active" and features.UnlockAll.Sword then
					callbackFunction = features.UnlockAll.Sword

					if line then
						line:SetAttribute("CurrentlyEquippedSword", callbackFunction)
					end

					localPlayer:SetAttribute("CurrentlyEquippedSword", callbackFunction)
				end

				return callbackFunction
			end

			local function handlePlayerRemoving(line, object)
				return features.Animation.SwordAPI:GetAnimations(line, { "Parry", "GrabParry" }, object.AnimationType, object.SwordType)
			end

			local function onTouched(line, object)
				local model = line or localPlayer.Character
				local targetHumanoid = model and (model:FindFirstChildOfClass("Humanoid") or model:WaitForChild("Humanoid", 5))

				if targetHumanoid then
					targetHumanoid = targetHumanoid:FindFirstChildOfClass("Animator") or targetHumanoid:WaitForChild("Animator", 5)
				end

				if not targetHumanoid or model ~= localPlayer.Character then
					return
				end
				object = object or features.Animation.GetSword(model)
				object = object and onInputEnded(object)
				if not object or model ~= localPlayer.Character then
					return
				end
				local angleRadians = handlePlayerRemoving(model, object)
				pcall(contentProvider.PreloadAsync, contentProvider, angleRadians)
				if model ~= localPlayer.Character then
					return
				end

				for _, propertyName in pairs(angleRadians) do
					features.Animation.Controller:LoadAnimation(targetHumanoid, propertyName, true)
				end
			end

			features.Animation.PreloadSword = function(line)
				task.spawn(onTouched, localPlayer.Character, line)
			end

			features.Animation.ParryAnimation = function()
				local model = localPlayer.Character
				local targetHumanoid = model and model:FindFirstChildOfClass("Humanoid")
				if not targetHumanoid then
					return false
				end
				local sourcePlayer = targetHumanoid:FindFirstChildOfClass("Animator") or targetHumanoid:WaitForChild("Animator", 1)
				if not sourcePlayer then
					return false
				end
				local angleRadians = features.Animation.GetSword(model)
				if not angleRadians then
					return false
				end
				local track = onInputEnded(angleRadians)
				if not track or model ~= localPlayer.Character then
					return false
				end

				for _, modelName in features.Animation.Controller:GetPlayingAnimationTracks(sourcePlayer) do
					if modelName:GetAttribute("GrabParry") or modelName:GetAttribute("Parry") or modelName.Name == "GrabParry" or modelName.Name == "Grab" then
						modelName:Stop(modelName:GetAttribute("StopFadeTime") or 0.1)
					elseif modelName.Name == "SuccessParry" or modelName.Name == "Success" then
						modelName:Stop(modelName:GetAttribute("StopFadeTime") or 0.1)
					end
				end

				local vertexCount = flyteBBState
				vertexCount.GrabAnimation = type(flyteBBState.GrabAnimation) == "table" and flyteBBState.GrabAnimation or {}
				table.clear(flyteBBState.GrabAnimation)
				local isArray = false

				for _, weld in handlePlayerRemoving(model, track) do
					local byte = features.Animation.Controller:LoadAnimation(sourcePlayer, weld, true)
					local callbackFunction = byte:GetAttribute("PlaySpeed") or 1
					byte:Play(byte:GetAttribute("PlayFadeTime") or 0.001, byte:GetAttribute("PlayWeight") or 1, callbackFunction)
					model:SetAttribute("ParryTime", math.max(model:GetAttribute("ParryTime") or 0, byte.Length == 0 and 1 or (byte.Length - byte.TimePosition) * callbackFunction))
					flyteBBState.GrabAnimation[#flyteBBState.GrabAnimation + 1] = byte
					isArray = true
				end

				return isArray
			end

			features.Animation.PlayAnimation = function(line, object)
				smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
				local model = localPlayer.Character
				if not undoFunction(model) or continuation(model) then
					return false
				end

				if object == "Animation + Click" then
					features.Parry.NativeClick()
				elseif object == "Click" then
					return features.Parry.NativeClick()
				end

				local osClock = os.clock()

				if line or osClock - difference >= 0.2 or cell then
					difference = osClock
					cell = false
					return features.Animation.ParryAnimation()
				end

				return false
			end

			features.Animation.BypassCooldown = function()
				cell = true
			end

			features.Animation.VIM = function(line)
				local model = localPlayer.Character
				if model and continuation(model) then
					return false
				end

				if not line and userInputService:GetFocusedTextBox() then
					return false
				end
				return simulateClick()
			end

			features.Animation.Input = function(line, object, descendant)
				flyteBBState.ParryMethod = "VIM"
				if line ~= "Mouse Click" then
					return features.Animation.VIM(object)
				end
				local model = localPlayer.Character
				model = model and continuation(model)
				local withinX

				if model then
					withinX = model
				else
					withinX = not object and userInputService:GetFocusedTextBox()
				end

				if withinX then
					return false
				end
				radians += 1
				local angleRadians = radians

				if active then
					active = false
					mouse1release()
				end

				mouse1press()
				if not descendant or descendant <= 0 then
					mouse1release()
					return true
				end
				active = true

				task.delay(descendant, function()
						if active and radians == angleRadians then
							active = false
							mouse1release()
						end
					end)

				return true
			end

			flyteBBState.Connections["Animation Sword"] = localPlayer:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(features.Animation.PreloadSword)
			features.Animation.PreloadSword()
		end

		features.LoadAnimations()
		features.Player = {}

		features.Player.GetClosest = function()
			local model = localPlayer.Character
			if not model or not model.PrimaryPart or not smallest then
				return nil
			end
			local minX = math.huge
			local radians = nil

			for _, existingPlayer in smallest:GetChildren() do
				if existingPlayer ~= model then
					local vehicleRoot = existingPlayer.PrimaryPart or existingPlayer:FindFirstChild("HumanoidRootPart")

					if vehicleRoot then
						local exponent = (model.PrimaryPart.Position - vehicleRoot.Position).Magnitude

						if exponent < minX then
							minX = exponent
							radians = existingPlayer
						end
					end
				end
			end

			return radians
		end

		features.Ball = { List = {}, TrainingList = {} }

		do
			local function onInputEnded(line, object, descendant, radius)
				local difference = object - (descendant or unexecuteFunction(line))
				local exponent = difference.Magnitude
				if exponent < 0.001 then
					return 0, 0
				end
				local radians = difference:Dot(radius or index4(line))
				if radians <= 0 then
					return math.huge, exponent
				end
				return exponent * exponent / radians, exponent
			end

			features.Ball.GetAllBalls = function()
				local model = localPlayer.Character
				return model and model.Parent ~= smallest and isInTrainingArea(model) and features.Ball.TrainingList or features.Ball.List
			end

			features.Ball.GetMainBall = function()
				local radians = features.Ball.GetAllBalls()
				local model = localPlayer.Character
				model = model and model.PrimaryPart
				model = model and model.Position
				local track = nil
				local vertexCount, steering

				for _, weld in pairs(radians) do
					local targetPlayerName = localPlayer.Name

					if compareFunction(weld) == targetPlayerName then
						if not model then
							features.Ball.Target = weld
							return weld
						end
						local byte, result68 = onInputEnded(weld, model)

						if not track or byte < track or byte == track and result68 < vertexCount then
							track = byte
							vertexCount = result68
							steering = weld
						end
					end
				end

				features.Ball.Target = steering
				return steering
			end

			coroutineBody({ BallStatsEnabled = false })
			features.BallStats = {}

			features.BallStats.CreatePanel = function(line, value4, object)
				local jsonString = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
				local result17 = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				local userInterface = Instance.new("ScreenGui")
				userInterface.Name = "tungtungtungsahur" .. object
				userInterface.ResetOnSpawn = false
				userInterface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				userInterface.IgnoreGuiInset = true
				parentGui(userInterface)
				local RemoteEvent = Instance.new("CanvasGroup")
				RemoteEvent.Name = "StatsGroup"
				RemoteEvent.BackgroundTransparency = 1
				RemoteEvent.Position = UDim2.new(0, line, 0, 150)
				RemoteEvent.Size = UDim2.new(0, 210, 0, 96)
				RemoteEvent.GroupTransparency = 1
				RemoteEvent.Parent = userInterface
				local panel = Instance.new("UIScale")
				panel.Name = "StatsScale"
				panel.Scale = 0.8
				panel.Parent = RemoteEvent
				local mainFrame = Instance.new("Frame")
				mainFrame.Name = "brobinipizanini"
				mainFrame.BackgroundColor3 = colors.Primary
				mainFrame.BorderSizePixel = 0
				mainFrame.Position = UDim2.new(0, 0, 0, 0)
				mainFrame.Size = UDim2.new(1, 0, 1, 0)
				mainFrame.Parent = RemoteEvent
				local containerFrame = Instance.new("TextButton")
				containerFrame.Name = "clickblocker"
				containerFrame.Text = ""
				containerFrame.AutoButtonColor = false
				containerFrame.BackgroundTransparency = 1
				containerFrame.BorderSizePixel = 0
				containerFrame.Size = UDim2.new(1, 0, 1, 0)
				containerFrame.ZIndex = 0
				containerFrame.Parent = mainFrame
				local corner = Instance.new("UICorner")
				corner.CornerRadius = UDim.new(0, 11)
				corner.Parent = mainFrame
				local stepPart = Instance.new("UIStroke")
				stepPart.Color = colors.BorderSoft
				stepPart.Parent = mainFrame
				local container = Instance.new("UIGradient")
				local controller = ColorSequence.new
				local lines = {}
				local radians = ColorSequenceKeypoint.new(0, colors.Text)
				local angleRadians = ColorSequenceKeypoint.new(0.493, colors.AccentLight)
				local track = ColorSequenceKeypoint.new(0.509, colors.AccentLight)
				local instance4 = ColorSequenceKeypoint.new
				local content = colors.Text
				lines[1] = radians
				lines[2] = angleRadians
				lines[3] = track

				do
					local argumentPack = table.pack(instance4(1, content))
					table.move(argumentPack, 1, argumentPack.n, 4, lines)
				end

				container.Color = controller(lines)
				container.Rotation = 260
				container.Parent = stepPart
				local image = Instance.new("ImageLabel")
				image.Name = "igivup"
				image.BackgroundTransparency = 1
				image.BorderSizePixel = 0
				image.Image = "rbxassetid://10723427199"
				image.Position = UDim2.new(0, 10, 0, 10)
				image.Size = UDim2.new(0, 30, 0, 16)
				image.Parent = mainFrame
				Instance.new("UIAspectRatioConstraint", image)
				local nameLabel = Instance.new("TextLabel")
				nameLabel.Name = "v0rtexdisgay"
				nameLabel.FontFace = jsonString
				nameLabel.Text = value4
				nameLabel.TextColor3 = colors.Text
				nameLabel.TextSize = 15
				nameLabel.TextXAlignment = Enum.TextXAlignment.Left
				nameLabel.BackgroundTransparency = 1
				nameLabel.BorderSizePixel = 0
				nameLabel.Position = UDim2.new(0, 32, 0, 8)
				nameLabel.Size = UDim2.new(1, -79, 0, 16)
				nameLabel.Parent = mainFrame
				local imageLabel = Instance.new("Frame")
				imageLabel.Name = "divider"
				imageLabel.BackgroundColor3 = colors.BorderSoft
				imageLabel.BorderSizePixel = 0
				imageLabel.Position = UDim2.new(0, 10, 0, 32)
				imageLabel.Size = UDim2.new(1, -20, 0, 1)
				imageLabel.Parent = mainFrame
				local textBox = Instance.new("TextLabel")
				textBox.Name = "veloc1"
				textBox.FontFace = jsonString
				textBox.Text = "velocity"
				textBox.TextColor3 = colors.SubText
				textBox.TextSize = 14
				textBox.TextXAlignment = Enum.TextXAlignment.Left
				textBox.BackgroundTransparency = 1
				textBox.BorderSizePixel = 0
				textBox.Position = UDim2.new(0, 12, 0, 40)
				textBox.Size = UDim2.new(0, 100, 0, 18)
				textBox.Parent = mainFrame
				local messageLabel = Instance.new("TextLabel")
				messageLabel.Name = "velocplace"
				messageLabel.FontFace = result17
				messageLabel.Text = "0.0"
				messageLabel.TextColor3 = colors.Text
				messageLabel.TextSize = 14
				messageLabel.TextXAlignment = Enum.TextXAlignment.Right
				messageLabel.BackgroundTransparency = 1
				messageLabel.BorderSizePixel = 0
				messageLabel.Position = UDim2.new(1, -112, 0, 40)
				messageLabel.Size = UDim2.new(0, 100, 0, 18)
				messageLabel.Parent = mainFrame
				local closeButton = Instance.new("TextLabel")
				closeButton.Name = "velocpeaktext"
				closeButton.FontFace = jsonString
				closeButton.Text = "peak velocity"
				closeButton.TextColor3 = colors.SubText
				closeButton.TextSize = 14
				closeButton.TextXAlignment = Enum.TextXAlignment.Left
				closeButton.BackgroundTransparency = 1
				closeButton.BorderSizePixel = 0
				closeButton.Position = UDim2.new(0, 12, 0, 64)
				closeButton.Size = UDim2.new(0, 120, 0, 18)
				closeButton.Parent = mainFrame
				local submitButton = Instance.new("TextLabel")
				submitButton.Name = "peakvaluetext"
				submitButton.FontFace = result17
				submitButton.Text = "0.0"
				submitButton.TextColor3 = colors.AccentLight
				submitButton.TextSize = 14
				submitButton.TextXAlignment = Enum.TextXAlignment.Right
				submitButton.BackgroundTransparency = 1
				submitButton.BorderSizePixel = 0
				submitButton.Position = UDim2.new(1, -112, 0, 64)
				submitButton.Size = UDim2.new(0, 100, 0, 18)
				submitButton.Parent = mainFrame
				containerFrame.ZIndex = 10
				makeDraggable(RemoteEvent, containerFrame)

				return {
					Gui = userInterface,
					Group = RemoteEvent,
					Title = nameLabel,
					Velocity = messageLabel,
					Peak = submitButton,
					DisplayVelocity = 0,
					DisplayPeak = 0,
				}
			end

			local function handlePlayerRemoving(line, object)
				local player3 = line.Group
				local result51 = player3 and player3:FindFirstChild("StatsScale")
				local difference = object and 0 or 1

				if player3 then
					tweenInstance(player3, { GroupTransparency = difference }, object and 0.45 or 0.35, object and Enum.EasingStyle.Exponential or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				end

				if result51 then
					tweenInstance(result51, { Scale = object and 1 or 0.8 }, object and 0.5 or 0.35, object and Enum.EasingStyle.Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				end
			end

			features.BallStats.Toggle = function(width)
				flags.BallStatsEnabled = width

				if not width then
					coroutineFunction("Ball Stats")
					local bodyVelocity = flyteBBState.StatsPanel
					flyteBBState.StatsPanel = nil
					flyteBBState.StatsBall = nil
					local lineIterator = flyteBBState.ExtraStats
					flyteBBState.ExtraStats = {}
					flyteBBState.StatsPeak = {}

					if bodyVelocity then
						handlePlayerRemoving(bodyVelocity, false)

						task.delay(0.35, function()
								if bodyVelocity and bodyVelocity.Gui then
									bodyVelocity.Gui:Destroy()
								end
							end)
					end

					for _, particle in pairs(lineIterator) do
						handlePlayerRemoving(particle, false)
					end

					task.delay(0.35, function()
							for _, particle in pairs(lineIterator) do
								particle.Gui:Destroy()
							end
						end)

					return
				end

				if not flyteBBState.StatsPanel then
					flyteBBState.StatsPanel = features.BallStats.CreatePanel(20, "ball stats", "")
					handlePlayerRemoving(flyteBBState.StatsPanel, true)
				end

				flyteBBState.StatsPeak = {}
				flyteBBState.ExtraStats = {}
				flyteBBState.StatsBall = nil
				coroutineFunction("Ball Stats")

				flyteBBState.Connections["Ball Stats"] = runService.Heartbeat:Connect(function()
						if not flags.BallStatsEnabled then
							return
						end
						local osClock = os.clock()
						if osClock - (flyteBBState.StatsUpdate or 0) < 0.05 then
							return
						end
						flyteBBState.StatsUpdate = osClock
						local radians = features.Ball.GetAllBalls()

						if #radians == 0 then
							flyteBBState.StatsBall = nil

							for vertex, existingPlayer in pairs(flyteBBState.ExtraStats) do
								existingPlayer.Gui:Destroy()
								flyteBBState.ExtraStats[vertex] = nil
							end

							return
						end

						if flyteBBState.StatsBall and not flyteBBState.StatsBall.Parent then
							flyteBBState.StatsBall = nil
						end

						for vertex, existingPlayer in pairs(flyteBBState.ExtraStats) do
							if not vertex.Parent then
								existingPlayer.Gui:Destroy()
								flyteBBState.ExtraStats[vertex] = nil
							end
						end

						for vertex in pairs(flyteBBState.StatsPeak) do
							if not vertex.Parent then
								flyteBBState.StatsPeak[vertex] = nil
							end
						end

						local lines = {}

						for _, existingPlayer in pairs(radians) do
							lines[existingPlayer] = true
						end

						if flyteBBState.StatsBall and not lines[flyteBBState.StatsBall] then
							flyteBBState.StatsBall = nil

							if type(n24) == "number" and n24 >= 4766 then
								while true do
								end
							end
						end

						for vertex, existingPlayer in pairs(flyteBBState.ExtraStats) do
							if not lines[vertex] then
								existingPlayer.Gui:Destroy()
								flyteBBState.ExtraStats[vertex] = nil
							end
						end

						if not flyteBBState.StatsBall then
							local angleRadians = features.Ball.GetMainBall(true)
							local sourceTable = {}

							for _, propertyName in pairs(radians) do
								if not flyteBBState.ExtraStats[propertyName] then
									table.insert(sourceTable, propertyName)
								end
							end

							local player19 = angleRadians and not flyteBBState.ExtraStats[angleRadians] and angleRadians or sourceTable[1]

							if player19 then
								flyteBBState.StatsBall = player19
							end
						end

						for _, existingPlayer in pairs(radians) do
							if existingPlayer ~= flyteBBState.StatsBall and not flyteBBState.ExtraStats[existingPlayer] then
								flyteBBState.ExtraStats[existingPlayer] = features.BallStats.CreatePanel(20, "ball stats", tostring(existingPlayer:GetDebugId(0)))
								handlePlayerRemoving(flyteBBState.ExtraStats[existingPlayer], true)
								flyteBBState.ExtraStats[existingPlayer].PeakValue = 0
							end
						end

						local bodyVelocity = flyteBBState.StatsPanel
						local player19 = flyteBBState.StatsBall
						local difference = 0
						local openError = 0

						if player19 then
							local angleRadians = index7(player19)
							local linearVelocity = angleRadians.Zoomies

							if not linearVelocity or linearVelocity.Parent ~= player19 then
								linearVelocity = player19:FindFirstChild("zoomies")
								angleRadians.Zoomies = linearVelocity
							end

							if linearVelocity then
								openError = linearVelocity.VectorVelocity.Magnitude
								difference = flyteBBState.StatsPeak[player19] or difference

								if difference < openError then
									flyteBBState.StatsPeak[player19] = openError
									difference = openError
								end
							else
								difference = flyteBBState.StatsPeak[player19] or 0
							end
						end

						bodyVelocity.DisplayVelocity = bodyVelocity.DisplayVelocity + (openError - bodyVelocity.DisplayVelocity) * 0.15
						bodyVelocity.DisplayPeak = bodyVelocity.DisplayPeak + (difference - bodyVelocity.DisplayPeak) * 0.15
						bodyVelocity.Velocity.Text = string.format("%.1f", bodyVelocity.DisplayVelocity)
						bodyVelocity.Peak.Text = string.format("%.1f", bodyVelocity.DisplayPeak)
						local step = 0

						for _, existingPlayer in pairs(radians) do
							if existingPlayer ~= player19 and flyteBBState.ExtraStats[existingPlayer] then
								step += 1
								local track = flyteBBState.ExtraStats[existingPlayer]
								track.Title.Text = "ball stats #" .. step
								local index30 = 20 + step * 222

								if track.LastTargetX ~= index30 then
									track.LastTargetX = index30
									tweenInstance(track.Group, { Position = UDim2.new(0, index30, 0, 150) }, 0.3)
								end

								local exponent = 0
								local v = track.DisplayPeak or 0
								local vertexCount = index7(existingPlayer)
								local linearVelocity = vertexCount.Zoomies

								if not linearVelocity or linearVelocity.Parent ~= existingPlayer then
									local result79 = existingPlayer:FindFirstChild("zoomies")
									vertexCount.Zoomies = result79
									linearVelocity = result79
								end

								if linearVelocity then
									exponent = linearVelocity.VectorVelocity.Magnitude

									if (track.PeakValue or 0) < exponent then
										track.PeakValue = exponent
									end

									v = track.PeakValue or 0
								end

								track.DisplayVelocity = track.DisplayVelocity + (exponent - track.DisplayVelocity) * 0.15
								track.DisplayPeak = track.DisplayPeak + (v - track.DisplayPeak) * 0.15
								track.Velocity.Text = string.format("%.1f", track.DisplayVelocity)
								track.Peak.Text = string.format("%.1f", track.DisplayPeak)
							end
						end
					end)
			end

			flyteBBState.Connections.Character = localPlayer.CharacterAdded:Connect(function()
					features.Animation.Reset()
					features.Animation.PreloadSword()
					flyteBBState.InfinityActive = false
					flyteBBState.InfinityParried = false
					flyteBBState.TimeHole = false
					flyteBBState.FuryCatch = false
					flyteBBState.FuryActive = false
					flyteBBState.DeathSlash = false
					flyteBBState.StaffDetected = {}

					if features.Phantom then
						features.Phantom.Reset()
					end

					if features.Quasar then
						features.Quasar.Reset()
					end
				end)

			coroutineBody({
				AntiPhantomEnabled = false,
				AntiPhantomBlatant = false,
				AntiPhantomType = "Spam",
				AntiFlashCounterEnabled = false,
				AntiFlashCounterBlatant = false,
				AntiFlashCounterType = "Spam",
			})

			features.Phantom = {}

			features.Phantom.Reset = function()
				flyteBBState.PhantomTarget = nil
				flyteBBState.PhantomAbility = nil
				flyteBBState.PhantomData = nil
			end

			features.Phantom.Trigger = function(line, options, object)
				local gameProcessed, low, priority

				if line == "Phantom" then
					gameProcessed = flags.AntiPhantomEnabled
					low = flags.AntiPhantomBlatant
					priority = flags.AntiPhantomType
				else
					gameProcessed = flags.AntiFlashCounterEnabled
					low = flags.AntiFlashCounterBlatant
					priority = flags.AntiFlashCounterType
				end

				if not gameProcessed then
					return
				end

				if object ~= localPlayer.Character or typeof(options) ~= "Instance" or not options:IsA("Model") then
					return
				end
				flyteBBState.PhantomTarget = options
				flyteBBState.PhantomAbility = nil

				flyteBBState.PhantomData = {
					Name = line,
					Blatant = low,
					Type = priority,
					Ball = line == "Phantom" and features.Ball.GetMainBall() or nil,
					Expires = os.clock() + 1.25,
				}
			end

			features.Phantom.Released = function(expectedType)
				local ENT = flyteBBState.PhantomData
				local innerPlayer = flyteBBState.PhantomTarget
				if not ENT or ENT.Name ~= "Phantom" or not innerPlayer or ENT.Ball and ENT.Ball ~= expectedType then
					return false
				end
				local targetPlayerName = innerPlayer.Name

				if compareFunction(expectedType) ~= targetPlayerName then
					ENT.Position = nil
					ENT.Released = false
					return false
				end

				ENT.Ball = expectedType
				local radians = unexecuteFunction(expectedType)

				if ENT.Position and radians ~= ENT.Position then
					ENT.Released = true
				end

				ENT.Position = radians
				return ENT.Released == true
			end

			features.Phantom.Update = function()
				local ENT = flyteBBState.PhantomData
				local innerPlayer = flyteBBState.PhantomTarget
				local model = localPlayer.Character
				model = model and model:FindFirstChild("HumanoidRootPart")
				local explosion = innerPlayer and innerPlayer:FindFirstChild("HumanoidRootPart")
				local targetHumanoid = innerPlayer and innerPlayer:FindFirstChildOfClass("Humanoid")
				local cell = not ENT

				if not cell then
					local neighborX = ENT.Expires
					cell = os.clock() >= neighborX
				end

				if cell or not model or not explosion or not targetHumanoid or targetHumanoid.Health <= 0 then
					features.Phantom.Reset()
					return
				end
				local difference = model.Position - explosion.Position
				local exponent = difference.Magnitude

				if ENT.Blatant and exponent < 32 then
					model.CFrame = model.CFrame + (exponent > 0.1 and difference.Unit or -explosion.CFrame.LookVector) * (32 - exponent)
					features.Phantom.Reset()
					return
				end

				return innerPlayer, exponent, ENT
			end

			flyteBBState.Connections.Phantom = replicatedStorage.Remotes.ActivateAbility.OnClientEvent:Connect(function(line, object)
					if line:GetAttribute("Ability") == "Phantom" then
						features.Phantom.Trigger("Phantom", line, object and object.target)
					end
				end)

			flyteBBState.Connections.FlashCounter = replicatedStorage.Remotes.PlrFlashCountered.OnClientEvent:Connect(function(line, object)
					features.Phantom.Trigger("Flash Counter", line, object)
				end)

			coroutineBody({ AntiBlindness = false, AntiDisorientate = false })
			features.Quasar = {}

			features.Quasar.Reset = function()
				flyteBBState.QuasarUntil = nil
			end

			features.Quasar.ClearBlindness = function(line)
				Workspace.Blindness.Enabled = false

				if not line then
					for _, particle in Workspace:GetChildren() do
						if particle:IsA("Atmosphere") and particle.Name == "Blindness" then
							features.Quasar.ClearBlindness(particle)
						end
					end

					return
				end

				local projectile = flyteBBState.QuasarAtmosphere
				line.Density = projectile and projectile.Density or 0
				line.Offset = projectile and projectile.Offset or 0
				line.Haze = projectile and projectile.Haze or 0
				line.Glare = projectile and projectile.Glare or 0

				if projectile then
					line.Color = projectile.Color
					line.Decay = projectile.Decay
				end
			end

			features.Quasar.SetBlindness = function(line)
				flyteBBState.QuasarAtmosphere = line and Workspace:FindFirstChildWhichIsA("Atmosphere") or nil
			end

			features.Quasar.SetDisorientate = function(line)
				coroutineFunction("Quasar Camera")
				flyteBBState.QuasarCamera = nil
				if not line then
					return
				end

				flyteBBState.Connections["Quasar Camera"] = runService.PreRender:Connect(function()
						local bodyGyro = workspace.CurrentCamera

						if bodyGyro then
							flyteBBState.QuasarCamera = bodyGyro.CFrame
						end
					end)
			end

			flyteBBState.Connections.Quasar = replicatedStorage.Remotes.PlrQuasared.OnClientEvent:Connect(function(line, object)
					if object ~= localPlayer.Character then
						return
					end
					line = line and line:FindFirstChild("Upgrades")
					line = line and line:FindFirstChild("Quasar")
					flyteBBState.QuasarUntil = os.clock() + 5 + (line and line.Value or 0)

					if flags.AntiBlindness then
						features.Quasar.ClearBlindness()
					end

					local windowInstance = flags.AntiDisorientate and flyteBBState.QuasarCamera

					if windowInstance then
						task.defer(function()
							local bodyGyro = workspace.CurrentCamera

							if bodyGyro and flags.AntiDisorientate then
								local rotation = windowInstance.Rotation
								bodyGyro.CFrame = CFrame.new(bodyGyro.CFrame.Position) * rotation
							end
						end)
					end
				end)

			flyteBBState.Connections["Quasar Blindness"] = Workspace.Blindness:GetPropertyChangedSignal("Enabled"):Connect(function()
					local angle = flags.AntiBlindness

					if angle then
						angle = os.clock() < (flyteBBState.QuasarUntil or 0)
					end

					if angle and Workspace.Blindness.Enabled then
						Workspace.Blindness.Enabled = false
					end
				end)

			flyteBBState.Connections["Quasar Atmosphere"] = Workspace.ChildAdded:Connect(function(guiObject)
					if not flags.AntiBlindness or not guiObject:IsA("Atmosphere") then
						return
					end
					local cell = guiObject.Name == "Blindness"
					local active

					if cell then
						active = os.clock() < (flyteBBState.QuasarUntil or 0)
					else
						active = cell
					end

					if active then
						features.Quasar.ClearBlindness(guiObject)
					elseif guiObject.Name ~= "Blindness" then
						flyteBBState.QuasarAtmosphere = guiObject
					end
				end)

			coroutineBody({
				AutoSpamType = "Remote",
				AutoSpamEnabled = false,
				AutoSpamAnimFix = true,
				AutoSpamAnimFixType = "Animation",
				AutoSpamThreshold = 2,
				DynamicSpamThreshold = false,
				ManualSpamEnabled = false,
				ManualSpamType = "Remote",
				ManualSpamAnimFix = true,
				ManualSpamAnimFixType = "Animation",
			})

			features.Loop = {}

			features.Loop.InvisDetection = function(line)
				smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
				local cell = false

				for _, particle in smallest:GetChildren() do
					if particle ~= line then
						if not continuation(particle) then
							return false
						end
						cell = true
					end
				end

				return cell
			end

			features.Loop.MainParryLoop = function(line)
				local graph = flags.AutoParryEnabled
				if not graph and not flags.DribbleDetection then
					return
				end
				local osClock = os.clock()
				smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
				local model = localPlayer.Character
				if not undoFunction(model) then
					return
				end

				if continuation(model) then
					return
				end
				local vehicleRoot = model.PrimaryPart
				local radians = features.Ball.GetAllBalls()
				if #radians == 0 then
					return
				end

				if features.Detection.UseProtection(model, true) then
					return
				end
				local valueType = flags.AutoParryType
				local cell = valueType == "Remote"

				if cell then
					cell = osClock < (flyteBBState.ExtraParryCooldownUntil or 0)
				end

				if cell then
					return
				end
				flyteBBState.ExtraParryCooldownUntil = nil

				if top and osClock >= elapsedTime then
					top = false
					currentDate = nil
				end

				local angleRadians = previous()
				local difference = angleRadians / 1000
				local openError = math.clamp(angleRadians / 10, 10, 16.7)
				local step = math.clamp(difference * 0.5 - 0.05, 0, 0.04)
				local clampedY = math.clamp(tonumber(flags.ParryRange) or 0, 0, 10)
				local currentPosition = vehicleRoot.Position
				local targetPlayerName = localPlayer.Name
				local track, vertexCount = features.Detection.BlocksParry(nil, model, vehicleRoot)
				if track then
					return
				end
				local active = #radians > 1
				local label = active and flyteBBState.AutoBall
				local steering = nil

				if label then
					local attachment = flyteBBState.AutoBall
					local major = managerObject[attachment]
					local isArray = graph and attachment.Parent and attachment:GetAttribute("from") == targetPlayerName
					steering = nil

					if isArray then
						steering = features.Loop.InvisDetection(model)
					end

					local bestLabel = not steering and attachment.Parent and compareFunction(attachment) == targetPlayerName

					if bestLabel then
						bestLabel = osClock < (major and major.ParryResetAt or 0)
					end

					if bestLabel then
						return
					end
					flyteBBState.AutoBall = nil
				end

				local mathMax = 0

				if active then
					for _, weld in pairs(radians) do
						local byte = managerObject[weld]
						local result68 = weld and compareFunction(weld)
						local splitHorizontal = byte and byte.Parried

						if splitHorizontal then
							splitHorizontal = osClock < (byte.ParryResetAt or 0)
						end

						if splitHorizontal then
							mathMax += 1
						elseif result68 == targetPlayerName and not index17(weld, result68) then
							local minX = math.huge

							if onInputEnded(weld, currentPosition) < minX then
								mathMax += 1
							end
						end

						if not (1 < mathMax) then
							continue
						end
						break
					end
				end

				local isArray = mathMax > 1
				local major = nil
				local byte = nil
				local result68 = nil
				local net = nil
				local slider = nil
				local newPrice = nil
				local screenPoint = nil
				local bestLabel = nil
				local result69 = nil
				local result70 = nil
				local result71 = nil

				for _, word in pairs(radians) do
					if word then
						local ikConstraint = index7(word)
						local result72 = compareFunction(word)

						if not index17(word, result72) then
							local result73 = nil
							local bestPair = nil

							if flags.DribbleDetection then
								result73, bestPair = features.Detection.GetSelfDribbleBall(word, vehicleRoot)
							end

							local isPinned = not result73 and graph and word:GetAttribute("from") == targetPlayerName
							local changed = false

							if isPinned then
								if steering ~= nil then
									changed = steering
								else
									changed = features.Loop.InvisDetection(model)
									steering = changed
								end
							end

							if changed then
								if ikConstraint.InvisibleReturnAway == nil then
									ikConstraint.InvisibleReturnAway = not ikConstraint.Parried
								end

								local dotProduct = (currentPosition - unexecuteFunction(word)):Dot(index4(word))
								bestPair = dotProduct > 0

								if dotProduct < 0 then
									ikConstraint.InvisibleReturnAway = true
								end

								local result14 = ikConstraint.InvisibleReturnAway

								if result14 then
									result73 = word
								else
									result73 = word
									bestPair = result14
								end
							else
								ikConstraint.InvisibleReturnAway = nil
							end

							if not (not graph and not result73) then
								if result73 and (changed and ikConstraint.InvisibleReturnAway or not changed and flyteBBState.SelfDribbleAway) then
									ikConstraint.Parried = false
									ikConstraint.ParryResetAt = 0

									if flyteBBState.ManualBall == word then
										flyteBBState.ManualBall = nil
									end

									if currentDate == word then
										top = false
										currentDate = nil
										elapsedTime = 0
									end
								end

								if flyteBBState.AutoBall == word and result72 ~= targetPlayerName then
									flyteBBState.AutoBall = nil
								end

								if flyteBBState.ManualBall == word then
									if result72 == targetPlayerName then
										continue
									end
									flyteBBState.ManualBall = nil
								end

								if ikConstraint.LoopTarget ~= result72 then
									ikConstraint.Parried = false
									ikConstraint.ParryResetAt = 0

									if ikConstraint.Target ~= result72 then
										if result72 == targetPlayerName then
											index13(ikConstraint)
										else
											index14(ikConstraint)
										end
									end

									ikConstraint.LoopTarget = result72

									if result72 == targetPlayerName and currentDate == word then
										top = false
										currentDate = nil
										elapsedTime = 0
									end
								end

								if result72 ~= targetPlayerName then
									ikConstraint.Parried = false
								elseif ikConstraint.Parried then
									if osClock < (ikConstraint.ParryResetAt or 0) then
										continue
									end
									ikConstraint.Parried = false
								end

								local bestChild = packed == word and word or nil

								if packed and features.Detection.GetDribbleBall(packed) ~= packed then
									if currentDate == packed then
										top = false
										currentDate = nil
										elapsedTime = 0
									end

									packed = nil
									bestChild = nil
								end

								if flags.ParryOnDribble and not packed then
									bestChild = features.Detection.GetDribbleBall(word)

									if bestChild then
										packed = bestChild
									end
								end

								if not (word:GetAttribute("DribbleActive") == true and not flags.ParryOnDribble and not result73 and result72 ~= targetPlayerName) then
									local dotProduct = bestChild or result73 or word
									local result74 = executeFunction(dotProduct)
									local moveDirection = dotProduct == word and ikConstraint.Zoomies and ikConstraint.Zoomies.VectorVelocity or index4(dotProduct)
									local exponent = moveDirection.Magnitude
									local index3 = dotProduct == word and result72 or compareFunction(dotProduct)
									local rayOrigin = redoFunction(dotProduct, result74, osClock) or result74 and result74.Position or Vector3.zero
									local leftChild = currentPosition - rayOrigin
									local totalTime = leftChild.Magnitude
									local endPosition = 101 - math.clamp(tonumber(flags.ParryAccuracy) or 80, 1, 100)
									local ENT = flyteBBState.PhantomData
									local innerPlayer = flyteBBState.PhantomTarget
									innerPlayer = innerPlayer and innerPlayer:FindFirstChild("HumanoidRootPart")
									local index31 = ENT and ENT.Name == "Phantom" and not ENT.Blatant and ENT.Type == "Spam" and innerPlayer and (currentPosition - innerPlayer.Position).Magnitude

									if flags.RandomizedParryAccuracy then
										local maximumValue = math.clamp(flags.RandomAccuracyMin or 1, 1, 100)
										endPosition = 101 - math.random(maximumValue, math.clamp(flags.RandomAccuracyMax or 100, maximumValue, 100))
									end

									if index31 and index31 > 30 then
										endPosition = 100
									elseif index31 and not ENT.Released then
										continue
									end

									local isRoblox = not result73

									if not (isRoblox and (flags.BackwardsAntiCurveEnabled and index11(dotProduct, moveDirection, index3, active) or index15(dotProduct, vehicleRoot, rayOrigin, moveDirection, totalTime, exponent, leftChild, index3, difference))) then
										if not (result73 and not bestPair) then
											local maximumValue = math.clamp((endPosition - 1) / 99, 0, 1)
											local offsetZ = maximumValue * maximumValue * (3 - 2 * maximumValue)
											local newDenominator = 2.4 + math.clamp(exponent - 9.5, 0, 990.5) * 0.002
											local center = exponent / newDenominator * (0.75 + maximumValue * 0.43)
											local isInside = center <= 9.5
											local clampedX = isInside and math.min(openError, exponent * difference) or openError + math.min(exponent * step, 30)
											local max = clampedX + math.max(center, 9.5)
											local tMinimum

											if not (endPosition > 70) then
												tMinimum = max
											else
												local maximumLength = math.clamp((endPosition - 44) / 30, 0, 1)
												local index35 = maximumLength * maximumLength * (3 - 2 * maximumLength)
												local callbackFunction = word:GetAttribute("from")
												local offsetY = type(callbackFunction) == "string" and smallest and smallest:FindFirstChild(callbackFunction)

												if offsetY then
													offsetY = offsetY.PrimaryPart or offsetY:FindFirstChild("HumanoidRootPart")
												end

												offsetY = offsetY and (currentPosition - offsetY.Position).Magnitude
												local index36 = offsetY and math.clamp((8 - offsetY) / 3, 0, 1) or 0

												if offsetY and totalTime > offsetY + 3 then
													index36 = 0
												end

												local index37 = (isInside and math.min(openError, exponent * difference) or openError) + math.max(exponent / newDenominator * (0.75 + maximumValue * 0.2), 9.5)
												local index38 = openError + exponent / newDenominator * (1.4 + maximumValue * 0.2)
												local clampedDistance = math.clamp((exponent - 1000) / 800, 0, 1)
												local index39 = index38 + math.max(index37 - index38, 0) * clampedDistance
												tMinimum = max + (index39 + (index37 - index39) * index36 - max) * index35
											end

											local maximumLength

											if isArray and endPosition > 44 then
												maximumLength = math.max(tMinimum, max)
											else
												maximumLength = tMinimum
											end

											isInside = isInside and (openError - clampedX) * (1 - offsetZ) or 0
											local index35 = bestChild and clampedX * (1 - offsetZ * 0.5) or 0
											local offsetY = valueType == "Mouse Click"

											if offsetY then
												offsetY = exponent * (line or 0)
											end

											local index36 = maximumLength + clampedY + isInside + index35 + (offsetY or 0)
											local seat = flags.AutoAbilityEnabled and not result73 and result72 == targetPlayerName and totalTime <= maximumLength
											local result75 = nil
											local index58 = nil

											if seat then
												result75, index58 = onInputEnded(word, currentPosition, rayOrigin, moveDirection)

												if not major or result75 < major or result75 == major and index58 < byte then
													major = result75
													byte = index58
													result68 = word
												end
											end

											isRoblox = isRoblox and result72 ~= targetPlayerName and leftChild:Dot(moveDirection) > 0

											if isRoblox then
												if steering ~= nil then
													isRoblox = steering
												else
													steering = features.Loop.InvisDetection(model)
													isRoblox = steering
												end
											end

											if (isRoblox or not result73 and result72 == targetPlayerName or bestChild or bestPair) and totalTime <= index36 and not ikConstraint.Parried and (not top or currentDate ~= word) then
												local empty = isRoblox or bestPair or not result73 and result72 == targetPlayerName

												if not empty and bestChild then
													empty = features.Detection.GetDribbleBall(bestChild) == bestChild
												end

												if empty then
													if active and not result75 then
														result75, index58 = onInputEnded(dotProduct, currentPosition, rayOrigin, moveDirection)
													end

													if not net or result75 < slider or result75 == slider and index58 < newPrice then
														bestLabel = not not (isRoblox or bestChild or result73)
														net = word
														slider = result75
														newPrice = index58
														screenPoint = ikConstraint
														result69 = endPosition
														result70 = bestPair
														result71 = changed
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

				if result68 and wrapper(vertexCount) then
					top = true
					currentDate = result68
					elapsedTime = osClock + 0.6
					return
				end

				if not net then
					return
				end
				screenPoint.Parried = true
				screenPoint.ParryResetAt = osClock + 0.6
				screenPoint.AutoParryAt = osClock
				top = true
				currentDate = net
				elapsedTime = screenPoint.ParryResetAt
				flyteBBState.AutoBall = net

				if not attemptAutoParry(net, valueType, nil, bestLabel, angleRadians, result69) then
					screenPoint.Parried = false
					screenPoint.ParryResetAt = 0
					screenPoint.AutoParryAt = nil
					flyteBBState.AutoBall = nil
					top = false
					currentDate = nil
					elapsedTime = 0
					return
				end

				if valueType == "Remote" then
					flyteBBState.AutoParryAt = osClock
				end

				if result70 then
					if result71 then
						screenPoint.InvisibleReturnAway = false
					else
						flyteBBState.SelfDribbleAway = false
					end
				end
			end
		end
	end

	features.Loop.ResetSpam = function()
		table.clear(flyteBBState.SpamParries)
		flyteBBState.SpamBall = nil
		flyteBBState.SpamTargetAt = nil
		flyteBBState.AutoSpamAt = nil
		flyteBBState.AutoSpamCarry = 0
		flyteBBState.AutoSpamTime = nil
	end

	features.Loop.AutoSpamLoop = function()
		local gameProcessed = flags.AntiPhantomEnabled or flags.AntiFlashCounterEnabled
		local radians = nil
		local angleRadians = nil
		local cell = nil

		if gameProcessed then
			radians, cell, angleRadians = features.Phantom.Update()
		end

		if radians and not angleRadians.Blatant and angleRadians.Type == "Ability" then
			features.Loop.ResetSpam()

			if flyteBBState.PhantomAbility ~= radians and knob and knob.Offset.Y >= 0.49 then
				flyteBBState.PhantomAbility = radians
				left:Fire()
			end

			return
		end

		local active = radians ~= nil
		if not flags.AutoSpamEnabled and not active then
			features.Loop.ResetSpam()
			return
		end
		local osClock = os.clock()
		local difference = math.min(osClock - (flyteBBState.AutoSpamTime or osClock), 0.066666666666666666)
		flyteBBState.AutoSpamTime = osClock
		if flags.DeathSlashDetection and flyteBBState.DeathSlash then
			features.Loop.ResetSpam()
			return
		end
		smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
		if flags.InfinityDetection and (flyteBBState.InfinityActive or updateFunction("Infinity")) then
			features.Loop.ResetSpam()
			return
		end
		local model = localPlayer.Character
		local vehicleRoot = model and model.PrimaryPart
		if flags.ForcefieldDetection and vehicleRoot and updateFunction("Forcefield") and (vehicleRoot:FindFirstChild("MaxShield") or vehicleRoot:FindFirstChild("Shield")) then
			features.Loop.ResetSpam()
			return
		end
		local isArray = model and model.Parent ~= smallest and isInTrainingArea(model)
		if not vehicleRoot or model.Parent ~= smallest and not isArray then
			return
		end

		if continuation(model) then
			return
		end
		local track = features.Ball.GetAllBalls()
		if #track == 0 then
			return
		end
		local currentPosition = vehicleRoot.Position
		local nearestDistance = active and angleRadians.Ball or flyteBBState.SpamBall
		local bestLabel = not active

		if bestLabel then
			nearestDistance = features.Ball.GetMainBall() or nearestDistance
		end

		if nearestDistance and not table.find(track, nearestDistance) then
			if active then
				angleRadians.Ball = nil
				angleRadians.Position = nil
				angleRadians.Released = false
			else
				flyteBBState.SpamBall = nil
				flyteBBState.SpamTargetAt = nil
			end

			nearestDistance = nil
		end

		if not nearestDistance and active and angleRadians.Name == "Phantom" then
			for _, modelName in pairs(track) do
				local targetPlayerName = radians.Name
				if compareFunction(modelName) == targetPlayerName then
					nearestDistance = modelName
					break
				end
			end
		end

		local exponent = nearestDistance and (currentPosition - unexecuteFunction(nearestDistance)).Magnitude or math.huge

		if not nearestDistance and active then
			for _, modelName in pairs(track) do
				local totalTime = (currentPosition - unexecuteFunction(modelName)).Magnitude

				if totalTime < exponent then
					exponent = totalTime
					nearestDistance = modelName
				end
			end
		end

		if not nearestDistance then
			return
		end
		local vertexCount = compareFunction(nearestDistance)
		if not vertexCount then
			return
		end
		local totalTime = index4(nearestDistance).Magnitude
		local steering = previous()
		local openError = math.min(0.3 + steering / 1000, 0.5)
		local bestPair = osClock - (flyteBBState.AutoSpamAt or 0) <= openError
		if model:GetAttribute("Pulsed") then
			return
		end

		if active and angleRadians.Name == "Phantom" and (cell > 30 or not features.Phantom.Released(nearestDistance)) then
			features.Loop.ResetSpam()
			return
		end

		if totalTime < 0.001 and (not active or angleRadians.Name ~= "Phantom") then
			return
		end

		if bestLabel then
			local callbackFunction = vertexCount == localPlayer.Name and nearestDistance:GetAttribute("from") or vertexCount
			cell = type(callbackFunction) == "string" and callbackFunction ~= localPlayer.Name and smallest:FindFirstChild(callbackFunction)

			if cell then
				cell = cell.PrimaryPart or cell:FindFirstChild("HumanoidRootPart")
			end

			cell = cell and (currentPosition - cell.Position).Magnitude or index8(model, currentPosition, isArray)
		end

		cell = cell or index8(model, currentPosition, isArray)
		if cell == math.huge then
			return
		end

		if exponent < 0.1 then
			return
		end

		if bestLabel then
			if vertexCount == localPlayer.Name then
				flyteBBState.SpamTargetAt = osClock
			else
				local step = osClock - (flyteBBState.SpamTargetAt or 0)
				if (bestPair and openError or math.min(0.15 + steering / 2000, 0.25)) < step then
					return
				end
			end
		end

		local step = math.clamp(10 + steering / 10, 10, 35)
		local mathMax = #track >= 2 and 3 or 0
		local leftChild = flags.AutoSpamType ~= "Remote" and 15 or 0
		local endPosition = math.min(0.5 + steering / 1000, 0.75)
		local isPinned = active and cell <= 30
		local maximumValue = 1

		if not isPinned then
			local offsetZ = step + math.min(totalTime / 6, 95) + mathMax + leftChild
			local newDenominator = step + math.min(totalTime / 6, 30) + mathMax + leftChild
			isPinned = cell <= newDenominator and exponent <= offsetZ

			if isPinned and not active and not bestPair then
				if flags.DynamicSpamThreshold then
					maximumValue = math.clamp(math.ceil(math.min(math.max(cell / newDenominator, exponent / offsetZ), 2 * math.max(cell, exponent) / totalTime * endPosition) * 3), 1, 3)
				else
					maximumValue = math.clamp(math.round(flags.AutoSpamThreshold or 2), 1, 4)
				end
			end
		end

		if not isPinned then
			return
		end

		if bestLabel and vertexCount == localPlayer.Name and cell > 30 and exponent > 30 then
			return
		end

		if bestLabel then
			local offsetZ = osClock - endPosition

			while flyteBBState.SpamParries[1] and flyteBBState.SpamParries[1] < offsetZ do
				table.remove(flyteBBState.SpamParries, 1)
			end

			if not bestPair and #flyteBBState.SpamParries < maximumValue then
				return
			end
		end

		if bestLabel then
			flyteBBState.AutoSpamAt = osClock
		end

		if flags.AutoSpamType == "Remote" then
			flyteBBState.ParryMethod = "Remote"

			if features.Parry and features.Parry.Fire then
				flyteBBState.AutoSpamCarry = (flyteBBState.AutoSpamCarry or 0) + math.max(difference * 120 - 1, 0)
				local major = 7
				local offsetZ = math.min(math.floor(flyteBBState.AutoSpamCarry), major)
				flyteBBState.AutoSpamCarry = math.min(flyteBBState.AutoSpamCarry - offsetZ, 7)
				local byte, result68 = features.Parry.Fire(nil, true, offsetZ > 0 and features.Parry.GetData(nil, flyteBBState.AutoSpamData), offsetZ + 1)

				if byte then
					flyteBBState.AutoSpamParryAt = osClock
					flyteBBState.ExtraParryCooldownUntil = nil
				end

				if byte and not result68 and flags.AutoSpamAnimFix then
					features.Animation.PlayAnimation(nil, flags.AutoSpamAnimFixType)
				end
			end
		else
			flyteBBState.AutoSpamCarry = 0

			if features.Animation.Input(flags.AutoSpamType, true) then
				flyteBBState.AutoSpamParryAt = osClock
				flyteBBState.ExtraParryCooldownUntil = nil
			end
		end
	end

	features.Loop.RefreshAutoSpam = function()
		if flags.AutoSpamEnabled or flags.AntiPhantomEnabled or flags.AntiFlashCounterEnabled then
			if not flyteBBState.Connections["Auto Spam"] then
				flyteBBState.Connections["Auto Spam"] = runService.PreSimulation:Connect(features.Loop.AutoSpamLoop)
			end

			return
		end

		coroutineFunction("Auto Spam")
		features.Loop.ResetSpam()
	end

	features.MobileControls = { X = 240, Y = 150, Width = 180, Gap = 14 }

	features.MobileControls.GetX = function(line)
		return features.MobileControls.X + (line - 1) * (features.MobileControls.Width + features.MobileControls.Gap)
	end

	features.MobileControls.Layout = function()
		local lines = {}

		if flyteBBState.SpamPanel then
			table.insert(lines, flyteBBState.SpamPanel)
		end

		if flyteBBState.TriggerPanel then
			table.insert(lines, flyteBBState.TriggerPanel)
		end

		for vertex, particle in pairs(lines) do
			local angleRadians = features.MobileControls.GetX(vertex)

			if particle.Group and (particle.LastTargetX ~= angleRadians or not particle.Shown) then
				local difference = not particle.Shown and 0.45 or 0.3
				particle.LastTargetX = angleRadians
				particle.Shown = true

				tweenInstance(particle.Group, {
					Position = UDim2.new(0, angleRadians, 0, features.MobileControls.Y),
					GroupTransparency = 0,
				}, difference, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			end
		end
	end

	features.MobileControls.Remove = function(line)
		if not line or not line.Gui then
			return
		end

		if line.Group then
			tweenInstance(line.Group, {
				Position = UDim2.new(0, (line.LastTargetX or features.MobileControls.X) + features.MobileControls.Width + features.MobileControls.Gap, 0, features.MobileControls.Y),
				GroupTransparency = 1,
			}, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		end

		task.delay(0.35, function()
				if line.Gui then
					line.Gui:Destroy()
				end
			end)
	end

	features.ManualSpam = { Data = { {}, { 0, 0 } }, Carry = 0 }

	features.MobileControls.Create = function(line, object, descendant, radius)
		local jsonString = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		local radians = features.MobileControls.GetX(descendant)

		local identifier = createInstance("ScreenGui", {
			Name = line,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			IgnoreGuiInset = true,
		})

		parentGui(identifier)

		local instance = createInstance("CanvasGroup", {
			Name = "Main",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, radians + features.MobileControls.Width + features.MobileControls.Gap, 0, features.MobileControls.Y),
			Size = UDim2.new(0, features.MobileControls.Width, 0, 56),
			GroupTransparency = 1,
			Parent = identifier,
		})

		local button = createInstance("TextButton", {
			Name = "Button",
			AutoButtonColor = false,
			BackgroundColor3 = colors.Primary,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Text = "",
			Parent = instance,
		})

		createInstance("UICorner", { CornerRadius = UDim.new(0, 11), Parent = button })
		local j = createInstance("UIStroke", { Color = colors.BorderSoft, Parent = button })

		local textLabel = createInstance("TextLabel", {
			Name = "Title",
			FontFace = jsonString,
			Text = object,
			TextColor3 = colors.SubText,
			TextSize = 15,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Parent = button,
		})

		makeDraggable(instance, button)
		button.MouseButton1Click:Connect(radius)
		return { Gui = identifier, Group = instance, Title = textLabel, Stroke = j, Shown = false }
	end

	features.MobileControls.Update = function(line, object, descendant)
		if not line or not line.Title then
			return
		end
		line.Title.Text = descendant and object .. " (on)" or object
		line.Title.TextColor3 = descendant and colors.AccentLight or colors.SubText
		line.Stroke.Color = descendant and colors.AccentLight or colors.BorderSoft
		features.MobileControls.Layout()
	end

	features.ManualSpam.Refresh = function()
		if not flags.ManualSpamUIEnabled then
			local hookName = flyteBBState.SpamPanel
			flyteBBState.SpamPanel = nil
			features.MobileControls.Remove(hookName)
			features.MobileControls.Layout()
			return
		end

		if not flyteBBState.SpamPanel then
			flyteBBState.SpamPanel = features.MobileControls.Create("ManualSpam", "manual spam", 1, function()
					local SecureDataStore = uiElements and uiElements.toggles.Manual_Spam

					if SecureDataStore and SecureDataStore.Set then
						SecureDataStore:Set(not flags.ManualSpamEnabled)
					else
						features.ManualSpam.SetEnabled(not flags.ManualSpamEnabled)
					end
				end)
		end

		features.MobileControls.Update(flyteBBState.SpamPanel, "manual spam", flags.ManualSpamEnabled)
	end

	coroutineBody({
		TriggerbotEnabled = false,
		TriggerbotType = "Remote",
		TriggerbotDelay = 0,
		TriggerbotRandomize = false,
		TriggerbotDelayMin = 0,
		TriggerbotDelayMax = 200,
		TriggerbotIgnoreSpawn = false,
		TriggerbotUIEnabled = false,
	})

	features.Triggerbot = features.Triggerbot or {}

	features.Triggerbot.Fire = function(line, object, descendant)
		local osClock = os.clock()
		local cell = flyteBBState.ManualBall == line

		if cell then
			local targetPlayerName = localPlayer.Name
			cell = compareFunction(line) == targetPlayerName
		end

		if not cell then
			cell = osClock < (flyteBBState.ExtraParryCooldownUntil or 0)
		end

		if cell then
			return false
		end
		local result63 = {}
		object.TriggerbotParried = result63
		object.AutoParryAt = osClock
		flyteBBState.AutoParryAt = osClock
		local underwater = attemptAutoParry(line, flags.TriggerbotType, true, descendant) == true

		if object.TriggerbotParried == result63 then
			object.TriggerbotParried = underwater
		end

		if not underwater then
			if object.AutoParryAt == osClock then
				object.AutoParryAt = nil
			end

			if flyteBBState.AutoParryAt == osClock then
				flyteBBState.AutoParryAt = nil
			end
		end

		return underwater
	end

	features.Triggerbot.TryParry = function(line, object, modulus)
		if not flags.TriggerbotEnabled or not line or not line.Parent or not object or not index5(line) then
			return
		end
		modulus = modulus or compareFunction(line)

		if object.TriggerbotTarget ~= modulus then
			if object.TriggerbotTarget and flyteBBState.ManualBall == line then
				flyteBBState.ManualBall = nil
			end

			object.TriggerbotTarget = modulus
			object.TriggerbotParried = false
		end

		local cell = not (modulus == localPlayer.Name)

		if cell and flyteBBState.ManualBall == line then
			flyteBBState.ManualBall = nil
		end

		local radians = cell and features.Detection.GetDribbleBall(line)
		if cell and not radians then
			object.TriggerbotParried = false
			return
		end

		if object.TriggerbotParried then
			return
		end
		local model = localPlayer.Character
		if not undoFunction(model) then
			return
		end

		if flags.TriggerbotIgnoreSpawn then
			local callbackFunction = line:GetAttribute("from")
			if not callbackFunction or callbackFunction == "" then
				return
			end
		end

		if features.Detection.BlocksParry(line, model) then
			return
		end
		local angleRadians, track = features.Detection.UseProtection(model)
		if angleRadians then
			object.TriggerbotParried = track == true
			return
		end
		local randomIndex = flags.TriggerbotDelay or 0

		if flags.TriggerbotRandomize then
			local substitution = flags.TriggerbotDelayMin or 0
			local insertion = flags.TriggerbotDelayMax or 200
			local remaining = math.max
			randomIndex = math.random(math.min(substitution, insertion), remaining(substitution, insertion))
		end

		if randomIndex <= 0 then
			features.Triggerbot.Fire(line, object, radians ~= nil)
			return
		end
		local result63 = {}
		object.TriggerbotParried = result63

		task.delay(randomIndex / 1000, function()
				if object.TriggerbotParried ~= result63 then
					return
				end
				local active = radians and features.Detection.GetDribbleBall(radians) == radians
				local isArray = not flags.TriggerbotEnabled or not line.Parent or not index5(line)

				if not isArray then
					local targetPlayerName = localPlayer.Name
					isArray = compareFunction(line) ~= targetPlayerName and not active
				end

				if isArray or features.Detection.BlocksParry(line, localPlayer.Character) then
					object.TriggerbotParried = false
					return
				end
				object.TriggerbotParried = false
				features.Triggerbot.Fire(line, object, active and true or false)
			end)
	end

	features.Triggerbot.Update = function()
		if not flags.TriggerbotEnabled then
			return
		end

		for _, particle in features.Ball.GetAllBalls() do
			features.Triggerbot.TryParry(particle, index7(particle))
		end
	end

	features.Triggerbot.RefreshUI = function()
		if not flags.TriggerbotUIEnabled then
			local timerName = flyteBBState.TriggerPanel
			flyteBBState.TriggerPanel = nil
			features.MobileControls.Remove(timerName)
			features.MobileControls.Layout()
			return
		end

		if not flyteBBState.TriggerPanel then
			flyteBBState.TriggerPanel = features.MobileControls.Create("Triggerbot", "triggerbot", flyteBBState.SpamPanel and 2 or 1, function()
					local cell = not flags.TriggerbotEnabled
					local result62 = uiElements and uiElements.toggles.Triggerbot
					if result62 and result62.Set then
						result62:Set(cell)
						return
					end
					features.Triggerbot.SetEnabled(cell)
				end)
		end

		features.MobileControls.Update(flyteBBState.TriggerPanel, "triggerbot", flags.TriggerbotEnabled)
	end

	features.Triggerbot.SetEnabled = function(player27)
		if flags.TriggerbotEnabled == player27 then
			return
		end

		if player27 then
			flyteBBState.AutoParryTriggerbot = nil
			flyteBBState.TriggerbotAutoParry = flags.AutoParryEnabled or nil

			if flags.AutoParryEnabled then
				local start = uiElements and uiElements.toggles.Auto_Parry

				if start and start.Set then
					start:Set(false)
				else
					flags.AutoParryEnabled = false
				end
			end
		end

		flags.TriggerbotEnabled = player27
		if not flyteBBState.Loaded then
			return
		end

		if player27 then
			startTriggerbot()
		else
			resetTriggerbotState()
			local success9 = flyteBBState.TriggerbotAutoParry
			flyteBBState.TriggerbotAutoParry = nil

			if success9 then
				local start = uiElements and uiElements.toggles.Auto_Parry

				if start and start.Set then
					start:Set(true)
				else
					flags.AutoParryEnabled = true
					index16(true)
					task.defer(features.Loop.MainParryLoop)
				end
			end
		end

		features.Triggerbot.RefreshUI()
	end

	features.Loop.ManualSpamLoop = function(line, object, descendant)
		if not flags.ManualSpamEnabled then
			return
		end

		if not (flags.DeathSlashDetection and flyteBBState.DeathSlash) then
			if flags.ManualSpamType == "Remote" then
				flyteBBState.ParryMethod = "Remote"

				if features.Parry and features.Parry.Fire then
					local radians, angleRadians = features.Parry.Fire(nil, true, line, descendant)

					if radians and not angleRadians and object ~= false and flags.ManualSpamAnimFix and flags.ManualSpamAnimFixType == "Click" then
						features.Animation.PlayAnimation(nil, "Click")
					end

					return radians, angleRadians
				end

				return
			end

			return features.Animation.Input(flags.ManualSpamType, true)
		end

		if type(n28) ~= "function" or n28(3586) < 2192 then
			return
		end

		while true do
		end
	end

	features.ManualSpam.Start = function()
		coroutineFunction("Manual Spam")
		flags.ManualSpamEnabled = true
		features.ManualSpam.Refresh()
		features.ManualSpam.Time = os.clock()
		features.ManualSpam.Carry = 0

		flyteBBState.Connections["Manual Spam"] = runService.PreSimulation:Connect(function()
				if not flags.ManualSpamEnabled then
					return
				end
				smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
				local model = localPlayer.Character
				if not model or model.Parent ~= smallest then
					return
				end
				local osClock = os.clock()
				local difference = math.min(osClock - features.ManualSpam.Time, 0.066666666666666666)
				features.ManualSpam.Time = osClock
				local openError

				if flags.ManualSpamType == "Remote" then
					local SecureDataStore = features.ManualSpam
					SecureDataStore.Carry = SecureDataStore.Carry + math.max(difference * 120 - 1, 0)
					openError = math.min(math.floor(features.ManualSpam.Carry), 7)
					features.ManualSpam.Carry = math.min(features.ManualSpam.Carry - openError, 7)
				else
					features.ManualSpam.Carry = 0
					openError = 0
				end

				local radians, angleRadians = features.Loop.ManualSpamLoop(openError > 0 and features.Parry.GetData(nil, features.ManualSpam.Data), nil, openError + 1)

				if radians then
					flyteBBState.ManualSpamAt = osClock
				end

				if radians and not angleRadians and flags.ManualSpamEnabled and flags.ManualSpamType == "Remote" and flags.ManualSpamAnimFix and flags.ManualSpamAnimFixType ~= "Click" then
					features.Animation.PlayAnimation(nil, flags.ManualSpamAnimFixType)
				end
			end)

		smallest = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")
		local model = localPlayer.Character

		if model and model.Parent == smallest then
			local radians, angleRadians = features.Loop.ManualSpamLoop()

			if radians and not angleRadians and flags.ManualSpamType == "Remote" and flags.ManualSpamAnimFix and flags.ManualSpamAnimFixType ~= "Click" then
				features.Animation.PlayAnimation(nil, flags.ManualSpamAnimFixType)
			end
		end
	end

	features.ManualSpam.Stop = function()
		local result23 = flags.ManualSpamEnabled
		flags.ManualSpamEnabled = false
		features.ManualSpam.Refresh()
		coroutineFunction("Manual Spam")

		if result23 and flags.ManualSpamType == "Remote" and flags.ManualSpamAnimFix then
			task.spawn(features.Animation.PlayAnimation)
		end
	end

	features.ManualSpam.SetEnabled = function(line)
		if line then
			features.ManualSpam.Start()
		else
			features.ManualSpam.Stop()
		end
	end

	coroutineBody({ KeybindListEnabled = false })
	features.UIExtra = {}

	do
		local function onInputEnded()
			local jsonString = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
			local result17 = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

			local identifier = createInstance("ScreenGui", {
				Name = "FlyteKeybindList",
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				IgnoreGuiInset = true,
			})

			parentGui(identifier)

			local instance = createInstance("CanvasGroup", {
				Name = "Main",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 32, 0.5, -120),
				Size = UDim2.new(0, 260, 0, 48),
				GroupTransparency = 1,
				Parent = identifier,
			})

			local name = createInstance("UIScale", { Name = "ListScale", Scale = 0.8, Parent = instance })

			local data = createInstance("Frame", {
				Name = "MainFrame",
				BackgroundColor3 = colors.Primary,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				ClipsDescendants = true,
				Parent = instance,
			})

			createInstance("UICorner", { CornerRadius = UDim.new(0, 10), Parent = data })
			createInstance("UIStroke", { Color = colors.BorderSoft, Parent = data })

			createInstance("ImageLabel", {
				Name = "Icon",
				BackgroundTransparency = 1,
				Image = "rbxassetid://10723416765",
				ImageColor3 = colors.SubText,
				Position = UDim2.new(0, 10, 0, 10),
				Size = UDim2.new(0, 16, 0, 16),
				Parent = data,
			})

			createInstance("TextLabel", {
				Name = "Title",
				FontFace = result17,
				Text = "keybind list",
				TextColor3 = colors.Text,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 32, 0, 8),
				Size = UDim2.new(1, -79, 0, 18),
				Parent = data,
			})

			createInstance("Frame", {
				Name = "Divider",
				BackgroundColor3 = colors.BorderSoft,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 10, 0, 28),
				Size = UDim2.new(1, -20, 0, 1),
				Parent = data,
			})

			local radians = createInstance("Frame", {
				Name = "Holder",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 43),
				Size = UDim2.new(1, -20, 0, 0),
				Parent = data,
			})

			local angleRadians = createInstance("TextButton", {
				Name = "Drag",
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 36),
				ZIndex = 10,
				Parent = data,
			})

			makeDraggable(instance, angleRadians)
			return { Gui = identifier, Group = instance, Scale = name, Holder = radians, Rows = {}, Font = jsonString }
		end

		features.UIExtra.RefreshKeybindList = function()
			local title = flyteBBState.KeybindPanel
			if not title then
				return
			end
			local radians = keybindRegistry.GetAll()
			local lines = {}

			for vertex, existingPlayer in pairs(radians) do
				local sourceTable = title.Rows[existingPlayer.Id]
				local difference = (vertex - 1) * 22

				if not sourceTable then
					local container = Instance.new("Frame")
					container.Name = existingPlayer.Id
					container.BackgroundColor3 = colors.Secondary
					container.BackgroundTransparency = 1
					container.BorderSizePixel = 0
					container.Position = UDim2.new(0, 0, 0, difference + 8)
					container.Size = UDim2.new(1, 0, 0, 18)
					container.Parent = title.Holder
					local mainFrame = Instance.new("Frame")
					mainFrame.Name = "Check_Box"
					mainFrame.BackgroundColor3 = colors.Element
					mainFrame.BackgroundTransparency = 1
					mainFrame.BorderSizePixel = 0
					mainFrame.Position = UDim2.new(0, 0, 0.5, -7)
					mainFrame.Size = UDim2.new(0, 14, 0, 14)
					mainFrame.Parent = container
					local panel = Instance.new("UIScale")
					panel.Scale = 0.6
					panel.Parent = mainFrame
					local image = Instance.new("ImageLabel")
					image.Name = "Check"
					image.BackgroundTransparency = 1
					image.Image = "rbxassetid://114461119629011"
					image.ImageColor3 = colors.AccentLight
					image.ImageTransparency = 1
					image.Position = UDim2.new(0.5, -7, 0.5, -7)
					image.Size = UDim2.new(0, 14, 0, 14)
					image.Parent = mainFrame
					local messageLabel = Instance.new("TextLabel")
					messageLabel.Name = "Name"
					messageLabel.FontFace = title.Font
					messageLabel.TextColor3 = colors.SubText
					messageLabel.TextSize = 13
					messageLabel.TextXAlignment = Enum.TextXAlignment.Left
					messageLabel.BackgroundTransparency = 1
					messageLabel.Position = UDim2.new(0, 22, 0, 0)
					messageLabel.Size = UDim2.new(1, -126, 1, 0)
					messageLabel.TextTransparency = 1
					messageLabel.Parent = container
					local nameLabel = Instance.new("TextLabel")
					nameLabel.Name = "Key"
					nameLabel.FontFace = title.Font
					nameLabel.TextColor3 = colors.AccentLight
					nameLabel.TextSize = 13
					nameLabel.TextXAlignment = Enum.TextXAlignment.Right
					nameLabel.BackgroundTransparency = 1
					nameLabel.Position = UDim2.new(1, -102, 0, 0)
					nameLabel.Size = UDim2.new(0, 102, 1, 0)
					nameLabel.TextTransparency = 1
					nameLabel.Parent = container
					sourceTable = { Frame = container, Name = messageLabel, Key = nameLabel, Check = image, CheckScale = panel }
					title.Rows[existingPlayer.Id] = sourceTable
					tweenInstance(container, { Position = UDim2.new(0, 0, 0, difference), BackgroundTransparency = 0.45 }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					tweenInstance(messageLabel, { TextTransparency = 0 }, 0.25)
					tweenInstance(nameLabel, { TextTransparency = 0 }, 0.3)
				else
					tweenInstance(sourceTable.Frame, { Position = UDim2.new(0, 0, 0, difference) }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				end

				sourceTable.Name.Text = string.lower(existingPlayer.Name)
				sourceTable.Key.Text = existingPlayer.Key .. " [" .. string.lower(existingPlayer.Mode) .. "]"
				local cell = existingPlayer.Active == true
				tweenInstance(sourceTable.CheckScale, { Scale = cell and 1 or 0.6 }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				tweenInstance(sourceTable.Check, { ImageTransparency = cell and 0 or 1, Rotation = cell and 0 or -45 }, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

				tweenInstance(sourceTable.Name, {
					Position = UDim2.new(0, cell and 26 or 0, 0, 0),
					Size = UDim2.new(1, cell and -126 or -104, 1, 0),
				}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

				lines[existingPlayer.Id] = true
			end

			for vertex, existingPlayer in pairs(title.Rows) do
				if not lines[vertex] then
					title.Rows[vertex] = nil

					tweenInstance(existingPlayer.Frame, {
						BackgroundTransparency = 1,
						Position = existingPlayer.Frame.Position + UDim2.new(0, 0, 0, 8),
					}, 0.25)

					tweenInstance(existingPlayer.Name, { TextTransparency = 1 }, 0.2)
					tweenInstance(existingPlayer.Key, { TextTransparency = 1 }, 0.2)
					tweenInstance(existingPlayer.Check, { ImageTransparency = 1, Rotation = -45 }, 0.2)
					tweenInstance(existingPlayer.CheckScale, { Scale = 0.6 }, 0.2)

					task.delay(0.26, function()
							if existingPlayer.Frame then
								existingPlayer.Frame:Destroy()
							end
						end)
				end
			end

			tweenInstance(title.Group, { Size = UDim2.new(0, 260, 0, 48 + math.max(#radians, 1) * 26) }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			title.Holder.Size = UDim2.new(1, -20, 0, math.max(#radians, 1) * 22)
		end

		features.UIExtra.ToggleKeybindList = function(pointB)
			flags.KeybindListEnabled = pointB
			if not pointB then
				features.UIExtra.HideKeybindList(true)
				return
			end

			if not flyteBBState.KeybindPanel then
				flyteBBState.KeybindPanel = onInputEnded()
			end

			flyteBBState.RefreshKeybinds = features.UIExtra.RefreshKeybindList
			features.UIExtra.RefreshKeybindList()
			local title = flyteBBState.KeybindPanel
			tweenInstance(title.Group, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			tweenInstance(title.Scale, { Scale = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end
	end
end

do
	features.UIExtra.HideKeybindList = function(line)
		if line ~= false then
			flags.KeybindListEnabled = false
		end

		if flyteBBState.KeybindPanel then
			local title = flyteBBState.KeybindPanel
			flyteBBState.KeybindPanel = nil
			flyteBBState.RefreshKeybinds = nil
			tweenInstance(title.Group, { GroupTransparency = 1 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			tweenInstance(title.Scale, { Scale = 0.92 }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

			task.delay(0.4, function()
					if title.Gui then
						title.Gui:Destroy()
					end
				end)
		end
	end

	features.UIExtra.HideOverlays = function()
		flyteBBState.RefreshKeybinds = nil
		coroutineFunction("Ball Stats")

		for _, particle in pairs({ "KeybindPanel", "StatsPanel", "SpamPanel", "TriggerPanel" }) do
			local angleRadians = flyteBBState[particle]
			flyteBBState[particle] = nil

			if angleRadians and angleRadians.Gui then
				angleRadians.Gui:Destroy()
			end
		end

		local lineIterator = flyteBBState.ExtraStats or {}

		for _, particle in pairs(lineIterator) do
			if particle.Gui then
				particle.Gui:Destroy()
			end
		end

		flyteBBState.ExtraStats = {}
	end

	features.LoadRender = function()
		local lines = {
			BallEmit = true,
			Upgrade = true,
			Arch2 = true,
			MaxHook = true,
			Wave = true,
			Totem = true,
			TotemRange = true,
			InfinityFX = true,
			maxTransmission = true,
			transmissionpart = true,
			Tornado = true,
			Barrier = true,
			GUARDIAN_DRAGON = true,
			DRAGON_POSITIONER = true,
			SpiritDeflect = true,
			Vanity = true,
			dash = true,
			Summon = true,
			MaxBlink = true,
		}

		features.Render = {}
		local sourceTable = { Spawn = true, Rhythm = true, Leaderboards = true, Map = true, UiClaimer = true }

		local players = {
			ParticleEmitter = true,
			Beam = true,
			Trail = true,
			Smoke = true,
			Fire = true,
			Sparkles = true,
			PointLight = true,
			SpotLight = true,
			SurfaceLight = true,
		}

		local targetTransparency = NumberSequence.new(1)

		local sorted = {
			"Workspace.Spawn.Limited",
			"Workspace.Spawn.ItemDuelsNPC",
			"Workspace.Spawn.AFK",
			"Workspace.Spawn.GroupCrate",
			"Workspace.Spawn.Portal",
			"Workspace.Spawn.ExplosionCratesSign",
			"Workspace.Spawn.SwordCratesSign",
			"Workspace.Spawn.MenuRings",
			"Workspace.Spawn.Spinnyy",
			"Workspace.Leaderboards",
			"Workspace.Rhythm.Runtime.Map.Decoration",
			"Workspace.Rhythm.Runtime.Map.Visuals",
			"Workspace.Rhythm.Track",
		}

		local neighbors = {}

		local function onInputEnded(line)
			local tree = line.ClassName
			return tree == "Sound" or tree:find("Audio", 1, true) ~= nil
		end

		local function handlePlayerRemoving(line)
			local radians = line:IsDescendantOf(playerGui)
			local cell

			if radians then
				cell = radians
			else
				cell = CoreGui ~= nil and line:IsDescendantOf(CoreGui)
			end

			return cell
		end

		local function onTouched(line)
			while line and line.Parent and line.Parent ~= workspace do
				line = line.Parent
			end

			return line and sourceTable[line.Name] == true
		end

		local function heartbeatUpdate(line)
			local sourceString = line:GetFullName()

			for _, particle in pairs(sorted) do
				if sourceString == particle or sourceString:sub(1, #particle + 1) == particle .. "." then
					return true
				end
			end

			return false
		end

		local function onInputChanged(line)
			if line:IsA("Model") and features.UnlockAll.GetSwordData(line.Name) then
				return true
			end
			local checkpointFolder = line.Parent

			while checkpointFolder and checkpointFolder ~= workspace and checkpointFolder ~= newRoot do
				if checkpointFolder:IsA("Model") and features.UnlockAll.GetSwordData(checkpointFolder.Name) then
					return true
				end
				local radians = string.lower(checkpointFolder.Name)
				if radians == "sord" or radians == "blade" then
					return true
				end
				checkpointFolder = checkpointFolder.Parent
			end

			return false
		end

		local function vectorLength(line, object)
			flyteBBState.RenderCache = flyteBBState.RenderCache or {}
			local sample = flyteBBState.RenderCache[line]

			if not sample then
				sample = {}
				flyteBBState.RenderCache[line] = sample
			end

			for vertex, particle in pairs(object) do
				if sample[vertex] == nil then
					sample[vertex] = line[vertex]
				end

				line[vertex] = particle
			end
		end

		local function vectorAdd()
			local generator = flyteBBState.RenderCache
			flyteBBState.RenderCache = nil
			if not generator then
				return
			end

			local function targetFunction(line, object)
				for vertex, particle in pairs(object) do
					line[vertex] = particle
				end
			end

			for vertex, particle in pairs(generator) do
				if vertex.Parent then
					targetFunction(vertex, particle)
				else
					pcall(targetFunction, vertex, particle)
				end
			end
		end

		local function targetFunction(line, object, descendant)
			if onInputEnded(line) then
				return
			end

			if line:IsA("Highlight") then
				return
			end

			if players[line.ClassName] then
				if line:IsA("ParticleEmitter") or line:IsA("Beam") or line:IsA("Trail") then
					vectorLength(line, { Enabled = false, Transparency = targetTransparency })
				else
					vectorLength(line, { Enabled = false })
				end

				if line:IsA("ParticleEmitter") then
					line:Clear()
				end
			elseif line:IsA("Decal") or line:IsA("Texture") then
				vectorLength(line, { Transparency = 1 })
			elseif descendant and (line:IsA("SurfaceGui") or line:IsA("BillboardGui")) then
				vectorLength(line, { Enabled = false })
			elseif line:IsA("BasePart") then
				if handlePlayerRemoving(line) then
					return
				end

				if object or (heartbeatUpdate(line) or neighbors[line]) and not onInputChanged(line) then
					vectorLength(line, { LocalTransparencyModifier = 1, CanCollide = false, CanTouch = false, CanQuery = false })
				end
			end
		end

		local function cleanup(line)
			while line and line.Parent and line.Parent ~= newRoot do
				line = line.Parent
			end

			return line and line.Parent == newRoot and line
		end

		local function createNode(line)
			if not line or not line.Parent then
				return
			end

			if line:IsDescendantOf(newRoot) then
				local rootFirst = cleanup(line)

				if rootFirst then
					rootFirst = rootFirst.Name:find("PortalFor_") or rootFirst.Name:find("WaypointFor_") or lines[rootFirst.Name]
				end

				if rootFirst then
					return
				end
				targetFunction(line, true, false)
			elseif (line:IsA("SurfaceGui") or line:IsA("BillboardGui")) and onTouched(line) then
				targetFunction(line, false, true)
			else
				targetFunction(line, false)
			end
		end

		features.Render.DisableFX = function(eventData)
			flyteBBState.NoRender = eventData
			coroutineFunction("Render Workspace")

			if not eventData then
				vectorAdd()
				table.clear(neighbors)
				return
			end

			local lastTime = workspace:GetDescendants()
			table.clear(neighbors)

			for _, particle in pairs(lastTime) do
				if onInputEnded(particle) then
					local points = particle:FindFirstAncestorWhichIsA("BasePart")

					if points and not handlePlayerRemoving(points) then
						neighbors[points] = true
					end
				end
			end

			for _, particle in pairs(lastTime) do
				createNode(particle)
			end

			flyteBBState.Connections["Render Workspace"] = workspace.DescendantAdded:Connect(function(hit)
					if not flyteBBState.NoRender then
						return
					end

					if onInputEnded(hit) then
						local points = hit:FindFirstAncestorWhichIsA("BasePart")

						if points and not handlePlayerRemoving(points) then
							neighbors[points] = true
							targetFunction(points, false)
						end

						return
					end

					createNode(hit)
				end)
		end

		local sample = { BloomEffect = true, BlurEffect = true, DepthOfFieldEffect = true, SunRaysEffect = true }

		local function generateRandomString(line, object, descendant)
			flyteBBState.AntiLagCache = flyteBBState.AntiLagCache or {}
			local result57 = flyteBBState.AntiLagCache[line]

			if not result57 then
				result57 = {}
				flyteBBState.AntiLagCache[line] = result57
			end

			if result57[object] == nil then
				result57[object] = line[object]
			end

			line[object] = descendant
		end

		local function createClass()
			flyteBBState.AntiLag = false
			flyteBBState.AntiLagRestore = nil
			cleanupResources(flyteBBState.AntiLagConnections or {})
			flyteBBState.AntiLagConnections = nil
			local duration = flyteBBState.AntiLagCache
			flyteBBState.AntiLagCache = nil
			duration = duration or {}

			for vertex, particle in pairs(duration) do
				pcall(function()
						for neighbor, existingPlayer in pairs(particle) do
							vertex[neighbor] = existingPlayer
						end
					end)
			end
		end

		local function onHumanoidDied(hit)
			if not flyteBBState.AntiLag then
				return
			end
			local tree = hit.ClassName

			if tree == "Atmosphere" then
				generateRandomString(hit, "Density", 0)
				generateRandomString(hit, "Haze", 0)
				generateRandomString(hit, "Glare", 0)
				return
			end

			if tree == "Clouds" then
				generateRandomString(hit, "Enabled", false)
				return
			end

			if not sample[tree] then
				return
			end
			local duration = flyteBBState.AntiLagCache and flyteBBState.AntiLagCache[hit]
			if duration and duration.Enabled ~= nil then
				return
			end
			generateRandomString(hit, "Enabled", false)

			flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + 1] = hit:GetPropertyChangedSignal("Enabled"):Connect(function()
					if flyteBBState.AntiLag and hit.Enabled then
						hit.Enabled = false
					end
				end)
		end

		features.Render.SetAntiLag = function(line)
			createClass()
			if not line then
				return
			end
			flyteBBState.AntiLag = true
			flyteBBState.AntiLagConnections = {}
			flyteBBState.AntiLagRestore = createClass
			local TweenService = game:GetService("Lighting")
			local Terrain = workspace.Terrain
			local result20 = Enum.QualityLevel.Level01
			generateRandomString(settings().Rendering, "QualityLevel", result20)
			generateRandomString(TweenService, "GlobalShadows", false)
			generateRandomString(TweenService, "EnvironmentDiffuseScale", 0)
			generateRandomString(TweenService, "EnvironmentSpecularScale", 0)
			generateRandomString(Terrain, "WaterWaveSize", 0)
			generateRandomString(Terrain, "WaterWaveSpeed", 0)
			generateRandomString(Terrain, "WaterReflectance", 0)

			local function subtractVectors(object)
				if not object then
					return
				end

				for _, particle in object:GetDescendants() do
					onHumanoidDied(particle)
				end

				flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + 1] = object.DescendantAdded:Connect(onHumanoidDied)
			end

			subtractVectors(TweenService)
			subtractVectors(Terrain)
			subtractVectors(workspace.CurrentCamera)

			flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + 1] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
					subtractVectors(workspace.CurrentCamera)
				end)
		end
	end

	features.LoadRender()

	flyteBBState.Connections["Balls"] = task.spawn(function()
			local function onInputEnded(line, object)
				local radians = index7(line)
				radians.TargetChanges = 0
				radians.Target = compareFunction(line)
				radians.LoopTarget = radians.Target
				radians.Parried = false
				radians.ParryResetAt = 0
				radians.AutoParryAt = nil
				index14(radians)
				radians.Zoomies = nil
				radians.CurveReference = nil
				radians.CurveSource = nil
				radians.CurveTargetDirection = nil
				radians.CurveReady = nil
				radians.CurveVersion = 0
				radians.Connections = {}

				local function handlePlayerRemoving()
					local conn = radians.Connections.CurveVelocity

					if conn then
						conn:Disconnect()
						radians.Connections.CurveVelocity = nil
					end
				end

				local function onTouched(scrollFrame)
					local connectionHandle = radians.Connections.ReferenceVelocity

					if connectionHandle then
						connectionHandle:Disconnect()
						radians.Connections.ReferenceVelocity = nil
					end

					radians.Zoomies = scrollFrame

					if scrollFrame then
						radians.Connections.ReferenceVelocity = scrollFrame:GetPropertyChangedSignal("VectorVelocity"):Connect(function()if  flags .BackwardsAntiCurveEnabled then  index10 ( line , radians );end;end)
						index10(line, radians)
					end
				end

				local function heartbeatUpdate(key,callback)if  radians .CurveVersion~=key or not  line .Parent or  compareFunction ( line )~= localPlayer .Name then return;end; handlePlayerRemoving (); radians .CurveReady=true;if  flags .AutoParryEnabled and not callback then task.spawn( features .Loop.MainParryLoop);end;end

				local function onInputChanged()
					if index5(line) then
						if table.find(object, line) then
							return
						end
						table.insert(object, line)

						if flyteBBState.Loaded and flags.TriggerbotEnabled then
							features.Triggerbot.TryParry(line, radians)
						elseif flyteBBState.Loaded and flags.AutoParryEnabled then
							task.spawn(features.Loop.MainParryLoop)
						end
					else
						local angleRadians = table.find(object, line)

						if angleRadians then
							table.remove(object, angleRadians)
						end
					end
				end

				onTouched(line:FindFirstChild("zoomies"))
				local valueObject = line:FindFirstChild("TargetAttachment")
				radians.Connections.Target = (valueObject and valueObject.Changed or line:GetAttributeChangedSignal("target")):Connect(function() radians .TargetChanges=( radians .TargetChanges or 0)+1;local i= compareFunction ( line );local y= radians .Target~=i;if y or not  valueObject then  radians .Parried=false; radians .ParryResetAt=0;if  flyteBBState .ManualBall== line then  flyteBBState .ManualBall=nil;end;if  currentDate == line then  top =false; currentDate =nil; elapsedTime =0;end;end;if y then if i== localPlayer .Name then  index13 ( radians );else  index14 ( radians );end;end;if  flags .TriggerbotEnabled then  features .Triggerbot.TryParry( line , radians ,i);end;if y then  radians .CurveVersion= radians .CurveVersion+1;if i== localPlayer .Name and  flags .BackwardsAntiCurveEnabled then if  line :GetAttribute("DribbleActive")==true then  radians .CurveReference=nil;end; radians .CurveSource=type( radians .Target)=="string"and  radians .Target~=""and  radians .Target~= localPlayer .Name and  radians .Target or nil; radians .CurveTargetDirection= index9 ( radians .CurveSource); radians .CurveReady=nil;local y= radians .CurveVersion;local currentLength= radians .Zoomies;if  flags .BackwardsAntiCurveEnabled and  line .Parent~= CoreGui and not  index6 ( line )and currentLength then local velocity;velocity=currentLength:GetPropertyChangedSignal("VectorVelocity"):Connect(function()if  radians .Connections.CurveVelocity==velocity then  heartbeatUpdate (y);end;end); radians .Connections.CurveVelocity=velocity;local velocity=currentLength.VectorVelocity;local currentLength,toTarget=velocity.Magnitude, radians .CurveReference;local length,current=toTarget and toTarget.Magnitude or 0, localPlayer .Character;local currentIndex=current and current.PrimaryPart;current= radians .CurveTargetDirection or currentIndex and currentIndex.Position- unexecuteFunction ( line );if length<0.001 or currentLength>=0.001 and(toTarget:Dot(velocity)<=0 or current and current:Dot(velocity)>=0)then  heartbeatUpdate (y,true);end;else  heartbeatUpdate (y,true);end;else  handlePlayerRemoving (); radians .CurveReference=nil; radians .CurveSource=nil; radians .CurveTargetDirection=nil; radians .CurveReady=nil; index10 ( line , radians );end;end; radians .Target=i;if  flyteBBState .AutoBall== line and i~= localPlayer .Name then  flyteBBState .AutoBall=nil;if  flags .AutoParryEnabled and# object >1 and  features .Loop and  features .Loop.MainParryLoop then  features .Loop.MainParryLoop();end;elseif i== localPlayer .Name and  flags .AutoParryEnabled and(# object >1 or  radians .CurveReady or not  flags .BackwardsAntiCurveEnabled)and  features .Loop and  features .Loop.MainParryLoop then  features .Loop.MainParryLoop();end;if  features .Ball.Target== line and i~= localPlayer .Name then  features .Ball.Target=nil;end;end)

				if valueObject then
					radians.Connections.TriggerbotTarget = line:GetAttributeChangedSignal("target"):Connect(function()
						if flags.TriggerbotEnabled then
							features.Triggerbot.TryParry(line, radians)
						end
					end)
				end

				radians.Connections.TriggerbotSpawn = line:GetAttributeChangedSignal("from"):Connect(function()
					if flags.TriggerbotEnabled and flags.TriggerbotIgnoreSpawn then
						features.Triggerbot.TryParry(line, radians)
					end
				end)

				radians.Connections.Real = line:GetAttributeChangedSignal("realBall"):Connect(onInputChanged)

				radians.Connections.ChildAdded = line.ChildAdded:Connect(function(guiObject)
					if guiObject.Name == "zoomies" then
						onTouched(guiObject)
					end

					onInputChanged()
				end)

				radians.Connections.ChildRemoved = line.ChildRemoved:Connect(function(guiObject)
					if guiObject == radians.Zoomies then
						onTouched(nil)
						handlePlayerRemoving()

						if not radians.CurveReady then
							heartbeatUpdate(radians.CurveVersion)
						end
					end

					onInputChanged()
				end)

				flyteBBState.Connections[line] = radians.Connections
				onInputChanged()
			end

			local function handlePlayerRemoving(line, object)
				if currentDate == line then
					currentDate = nil
					top = false
					elapsedTime = 0
				end

				if flyteBBState.AutoBall == line then
					flyteBBState.AutoBall = nil
				end

				local radians = table.find(object, line)

				if radians then
					table.remove(object, radians)
				end

				if features.Ball.Target == line then
					features.Ball.Target = nil
				end

				local angleRadians = executeFunction(line)
				managerInstance[line] = nil

				if angleRadians and angleRadians ~= line then
					managerInstance[angleRadians] = nil
				end

				local track = managerObject[line]

				if track and track.Connections then
					cleanupResources(track.Connections)
				end

				flyteBBState.Connections[line] = nil
				managerObject[line] = nil
			end

			local function onTouched(line, object, descendant)
				for _, particle in line:GetChildren() do
					onInputEnded(particle, object)
				end

				flyteBBState.Connections[descendant .. " Added"] = line.ChildAdded:Connect(function(guiObject)
					onInputEnded(guiObject, object)
				end)

				flyteBBState.Connections[descendant .. " Removed"] = line.ChildRemoved:Connect(function(guiObject)
					handlePlayerRemoving(guiObject, object)
				end)
			end

			onTouched(playerGui, features.Ball.List, "Ball")

			local function heartbeatUpdate(guiObject)
				if guiObject.Name ~= "TrainingBalls" then
					return
				end
				CoreGui = guiObject
				coroutineFunction("Training Folder")
				onTouched(guiObject, features.Ball.TrainingList, "Training Ball")
			end

			flyteBBState.Connections["Training Folder"] = workspace.ChildAdded:Connect(heartbeatUpdate)
			local result61 = workspace:FindFirstChild("TrainingBalls")

			if result61 then
				heartbeatUpdate(result61)
			end
		end)

	coroutineBody({ UnlockAllEnabled = false })

	do
		local hook = {
			Run = 0,
			Types = { "Sword", "Explosion" },
			Connections = {},
			Originals = {},
			SavedEquipped = {},
			Defaults = {},
			SwordData = {},
			Clones = {},
			Favorites = { Sword = {}, Explosion = {}, Emote = {} },
			Deleted = { Sword = {}, Explosion = {}, Emote = {} },
			ShopState = {},
			ShopChanges = {},
			ShopItems = { Sword = {}, Explosion = {} },
			ShopFields = {
			{ "ItemsMatching", "ItemsMatching" },
			{ "InDeleteMulti", "InDeleteMulti" },
			{ "Owns", "OwnsItem" },
			{ "Section", "Section" },
			{ "ForceHide", "ForceHide" },
		},
			ShopActive = false,
			FavoriteStates = {},
			DefaultFavorites = {},
			EmoteItems = {},
			EmoteItemsList = {},
			EmoteDisplays = {},
			EmoteItemKeys = {},
			EmoteBuildIndex = 1,
			EmoteBuildToken = 0,
			EmoteBuilding = false,
			EmotesReady = false,
			EmoteCatalogLoaded = false,
			ButtonConnections = {},
			CardConnections = {},
			EquippedEmotes = {},
			Finishers = {},
			DefaultFinishers = {},
			Overlays = {},
			MultiDelete = { Sword = {}, Explosion = {} },
			MultiDeleteCards = {},
		}

		features.UnlockAll = hook

		hook.Add = function(line)
			if line then
				table.insert(hook.Connections, line)
			end

			return line
		end

		local function onInputEnded(line, object, descendant)
			local radians = hook.Originals[line]

			if radians then
				object[descendant or line] = radians
				hook.Originals[line] = nil
			end
		end

		hook.GetCharacter = function()
			local model = localPlayer.Character
			local targetHumanoid = model and model:FindFirstChildOfClass("Humanoid")
			if model and model.Parent and (not targetHumanoid or targetHumanoid.Health > 0) then
				return model
			end
		end

		hook.Load = function()
			if hook.EmotesFolder then
				return true
			end
			local tween = replicatedStorage.Controllers
			local instance6 = replicatedStorage.Shared
			local screenGui = require(replicatedStorage.Packages.Replion)
			hook.InventoryClient = require(instance6.Inventory).Client
			hook.InventoryShared = require(instance6.Inventory.Shared)
			hook.InventoryController = require(tween.Trading.InventoryController)
			hook.InventoryReplion = screenGui.Client:GetReplion("Inventory")
			hook.DataReplion = screenGui.Client:GetReplion("Data")
			hook.Shop = require(tween.UI.ShopController)
			hook.ShopAPI = require(tween.UI.ShopControllerAPI)
			hook.TradeInfo = require(instance6.Trading.TradeInfo)
			hook.Swords = require(instance6.ReplicatedInstances.Swords)
			hook.SwordFX = require(instance6.ReplicatedInstances.SwordFX)
			hook.EmoteWheel = require(tween.EmoteWheelController)
			hook.EmoteController = require(tween.EmoteController)
			hook.DeletePrompt = require(tween.DeleteItemPromptController)
			hook.FinishersController = require(tween.FinishersController)
			hook.VFX = require(tween.VFXController)
			hook.EmotesShared = require(instance6.EmotesShared)
			hook.ItemInfo = require(instance6.ItemInfo)
			hook.AwakenData = require(instance6.SecretAwakenData)
			hook.AwakenBase = {}

			for vertex, particle in pairs(hook.AwakenData) do
				if type(particle) == "table" and particle.Awakened then
					hook.AwakenBase[particle.Awakened.Value] = vertex
				end
			end

			hook.Trove = require(replicatedStorage.Packages.Trove)
			hook.EmotesFolder = replicatedStorage.Misc.Emotes
			return true
		end

		hook.ShopReady = function()
			local player30 = hook.Shop._virtualItems
			if not player30 then
				return false
			end
			local result21 = hook.Shop._loadInventoryPage

			if result21 then
				for _, particle in pairs(hook.Types) do
					if player30[particle] and not next(player30[particle]) then
						result21(particle)
					end
				end
			end

			local result13 = hook.Shop._inventoryPages
			local player20 = result13 and result13.Sword
			result13 = result13 and result13.Explosion
			return player30.Sword and next(player30.Sword) ~= nil and player30.Explosion and next(player30.Explosion) ~= nil and player20 and player20.BatchDepth == 0 and result13 and result13.BatchDepth == 0
		end

		hook.Save = function()
			configData.UnlockAll = configData.UnlockAll or {}
			configData.UnlockAll.Sword = hook.AwakenBase[hook.Sword] or hook.Sword
			configData.UnlockAll.Explosion = hook.Explosion
			local result3 = {}

			for vertex, particle in pairs(hook.EquippedEmotes) do
				result3[tostring(vertex)] = particle
			end

			configData.UnlockAll.Emotes = result3
			configData.UnlockAll.Accessory = hook.Accessory == true
			configData.UnlockAll.Finishers = table.clone(hook.Finishers)

			configData.UnlockAll.Favorites = {
				Sword = table.clone(hook.Favorites.Sword),
				Explosion = table.clone(hook.Favorites.Explosion),
				Emote = table.clone(hook.Favorites.Emote),
			}

			flags.UnlockAllSword = configData.UnlockAll.Sword or ""
			flags.UnlockAllExplosion = hook.Explosion or ""
			flags.UnlockAllEmotes = configData.UnlockAll.Emotes
			flags.UnlockAllAccessory = configData.UnlockAll.Accessory
			flags.UnlockAllFinishers = configData.UnlockAll.Finishers
			flags.UnlockAllFavorites = configData.UnlockAll.Favorites
			saveConfig()
		end

		hook.LoadFavorites = function()
			for _, particle in pairs({ "Sword", "Explosion", "Emote" }) do
				table.clear(hook.Favorites[particle])
				local cell = type(flags.UnlockAllFavorites) == "table" and flags.UnlockAllFavorites[particle]

				if type(cell) == "table" then
					for vertex, existingPlayer in pairs(cell) do
						if existingPlayer == true then
							hook.Favorites[particle][vertex] = true
						end
					end
				end
			end
		end

		hook.ApplyFavorites = function()
			for vertex, particle in pairs(hook.Favorites) do
				for neighbor in pairs(particle) do
					hook.SetFavorite(vertex, neighbor, true, false)
				end
			end
		end

		hook.GetFavoriteState = function(line, object)
			local query = line .. "\0" .. tostring(object)
			local radians = hook.FavoriteStates[query]
			if radians then
				return radians
			end
			local SelectionService = hook.InventoryController:GetFavoriteState(line, object)

			if SelectionService then
				hook.FavoriteStates[query] = SelectionService
				hook.DefaultFavorites[query] = SelectionService:Get() == true
			end

			return SelectionService
		end

		hook.GetShopFavorites = function()
			if hook.ShopFavorites then
				return hook.ShopFavorites
			end
			local player20 = hook.Shop._inventoryPages and hook.Shop._inventoryPages.Sword
			local radians = player20 and getupvalues and getupvalues(player20.MarkDirty)
			radians = radians and radians[2]
			local lines = radians and getupvalues(radians)
			lines = lines and lines[4]
			lines = lines and getupvalues(lines) or {}

			for _, existingPlayer in pairs(lines) do
				if type(existingPlayer) == "table" and type(existingPlayer.Sword) == "table" and type(existingPlayer.Explosion) == "table" then
					hook.ShopFavorites = existingPlayer
					return existingPlayer
				end
			end
		end

		hook.SetFavorite = function(line, object, descendant, radius)
			if not hook.Favorites[line] then
				return
			end
			hook.Favorites[line][object] = descendant and true or nil
			local radians = hook.GetFavoriteState(line, object)
			local cell = line ~= "Emote" and hook.GetShopFavorites()

			if cell and cell[line] then
				cell[line][object] = descendant and true or nil
				local result13 = hook.Shop._inventoryPages and hook.Shop._inventoryPages[line]

				if result13 and result13.MarkDirty then
					result13.MarkDirty(nil, true, true)
				end
			end

			if radians then
				radians:Set(descendant == true)
			end

			local sortedArray = hook.ConsoleItems and hook.ConsoleItems[line] and hook.ConsoleItems[line][object]

			if sortedArray then
				sortedArray.Data.IsFavorited:Set(descendant == true)
			end

			if radius ~= false then
				hook.Save()
			end
		end

		hook.ToggleFavorite = function(line, object)
			hook.SetFavorite(line, object, not hook.Favorites[line][object])
		end

		hook.RestoreFavorites = function()
			local radians = hook.GetShopFavorites()

			for vertex, existingPlayer in pairs(hook.FavoriteStates) do
				local cell = hook.DefaultFavorites[vertex] == true
				local query = string.find(vertex, "\0", 1, true)
				local concatenated = query and string.sub(vertex, 1, query - 1)
				query = query and string.sub(vertex, query + 1)

				if radians and radians[concatenated] and query then
					radians[concatenated][query] = cell and true or nil
				end

				existingPlayer:Set(cell)
			end

			for _, existingPlayer in pairs(hook.Types) do
				local result13 = hook.Shop._inventoryPages and hook.Shop._inventoryPages[existingPlayer]

				if result13 then
					result13.MarkDirty(nil, true, true)
				end
			end

			table.clear(hook.FavoriteStates)
			table.clear(hook.DefaultFavorites)
		end

		hook.GetShopState = function(arguments,key)local y=arguments and arguments[key];if type(y)=="table"and type(y.Get)=="function"then return y:Get();end;return y;end
		hook.ApplyShopState = function(arguments,key,callback)local currentLength=arguments and arguments[key];if type(currentLength)=="table"and type(currentLength.Set)=="function"then currentLength:Set(callback);elseif arguments then arguments[key]=callback;end;end

		hook.SetShopState = function(line, object)
			if not line then
				return
			end
			local radians = hook.ShopState[line]
			if not radians then
				return
			end
			local lines = hook.ShopChanges[line]
			local cell = false

			for _, existingPlayer in pairs(hook.ShopFields) do
				local track = existingPlayer[1]
				local vertexCount = existingPlayer[2]
				local steering = object[track]

				if steering ~= nil then
					local major = hook.GetShopState(line, vertexCount)

					if major ~= steering then
						hook.ApplyShopState(line, vertexCount, steering)
						lines = lines or {}

						if lines[track] == nil then
							lines[track] = major
						elseif lines[track] == steering then
							lines[track] = nil
						end

						cell = true
					end

					radians[track] = steering
				end
			end

			if lines then
				hook.ShopChanges[line] = next(lines) and lines or nil
			end

			local result13 = hook.Shop._inventoryPages and hook.Shop._inventoryPages[line.Type]

			if cell and result13 and result13.MarkDirty and result13.BatchDepth == 0 then
				result13.MarkDirty(line, false, true)
			end

			if cell and hook.ConsoleItems then
				hook.SyncConsoleItem(line)
			end
		end

		hook.IsUnlockItem = function(line)
			local radians = "table"
			local cell = type(line) == radians

			if cell then
				cell = tostring(line.Id or ""):match("^UnlockAll:") ~= nil
			end

			return cell
		end

		hook.GetOwnedItem = function(line, object)
			local radians = hook.InventoryClient:FindItems(line, object)
			local cell = type(radians) == "table" and radians[1]
			local accessoryPrototype = cell and hook.InventoryClient:GetItem(line, cell)

			if accessoryPrototype and not hook.IsUnlockItem(accessoryPrototype) then
				local angleRadians = table.clone(accessoryPrototype)
				angleRadians.Id = angleRadians.Id or cell
				return angleRadians
			end

			local lines = hook.InventoryClient:GetInventory()[line] or {}

			for _, existingPlayer in pairs(lines) do
				if existingPlayer.Name == object and not hook.IsUnlockItem(existingPlayer) then
					return existingPlayer
				end
			end
		end

		hook.GetRealEquipped = function(line)
			local instance2 = hook.InventoryClient:GetEquipped(line)
			if not hook.IsUnlockItem(instance2) then
				return instance2
			end
			return hook.GetOwnedItem(line, instance2.Name)
		end

		hook.ActivateShop = function()
			if hook.ShopActive then
				return true
			end
			hook.ShopActive = true
			table.clear(hook.ShopState)
			table.clear(hook.ShopChanges)
			local HOOK_ORIGINAL_RUN = hook.Run
			local difference = os.clock() + 0.004
			local File = hook.Shop
			local result13 = File._inventoryPages
			local result47 = hook.ShopState
			local result46 = hook.ShopItems
			local heap = hook.Deleted

			local function handlePlayerRemoving(line)
				if os.clock() < difference then
					return true
				end
				runService.Heartbeat:Wait()

				if hook.Run ~= HOOK_ORIGINAL_RUN or hook.Status ~= "active" then
					if line and line.EndBatch then
						line.EndBatch()
					end

					return false
				end

				difference = os.clock() + 0.004
				return true
			end

			for _, particle in pairs(hook.Types) do
				local angleRadians = result13 and result13[particle]

				if angleRadians and angleRadians.BeginBatch then
					angleRadians.BeginBatch()
				end

				local lines = File._virtualItems[particle] or {}
				local track = result46[particle]
				local sourceTable = {}
				table.clear(track)

				for _, modelName in pairs(lines) do
					local targetPlayerName = modelName.Name

					if targetPlayerName and targetPlayerName ~= "Random" then
						local cell = hook.GetShopState(modelName, "OwnsItem")

						local players = {
							Owns = cell,
							Section = hook.GetShopState(modelName, "Section"),
							ForceHide = hook.GetShopState(modelName, "ForceHide"),
							ItemsMatching = hook.GetShopState(modelName, "ItemsMatching"),
							InDeleteMulti = hook.GetShopState(modelName, "InDeleteMulti"),
							Virtual = cell ~= true,
						}

						result47[modelName] = players
						local steering = track[targetPlayerName]

						if not steering then
							track[targetPlayerName] = modelName
							cell = cell and not players.ForceHide or nil
							sourceTable[targetPlayerName] = cell
						elseif not sourceTable[targetPlayerName] then
							local major = result47[steering]

							if cell and not players.ForceHide then
								track[targetPlayerName] = modelName
								sourceTable[targetPlayerName] = true
							elseif cell and not major.Owns then
								track[targetPlayerName] = modelName
							elseif major.ForceHide and not players.ForceHide then
								track[targetPlayerName] = modelName
							end
						end
					end

					if not handlePlayerRemoving(angleRadians) then
						return false
					end
				end

				for _, modelName in pairs(lines) do
					local targetPlayerName = modelName.Name

					if targetPlayerName and targetPlayerName ~= "Random" then
						local steering = result47[modelName]
						local major = table.clone(steering)

						if modelName == track[targetPlayerName] then
							local byte = heap[particle][targetPlayerName]
							local withinY = particle == "Sword" and hook.AwakenBase[targetPlayerName] ~= nil
							local characters = steering.ItemsMatching or {}

							if byte or withinY then
								characters = {}
							elseif #characters == 0 then
								characters = { "UnlockAll:" .. targetPlayerName }
							end

							steering.ItemsMatching = characters
							steering.InDeleteMulti = 0
							steering.Owns = #characters > 0
							steering.Section = steering.Owns and "Owned" or "Unowned"
							steering.ForceHide = withinY
						else
							steering.ForceHide = true
						end

						local players = {}

						for _, partTemplate in pairs(hook.ShopFields) do
							if steering[partTemplate[1]] ~= major[partTemplate[1]] then
								players[partTemplate[1]] = major[partTemplate[1]]
							end
						end

						hook.ShopChanges[modelName] = next(players) and players or nil
					end

					if not handlePlayerRemoving(angleRadians) then
						return false
					end
				end

				for _, modelName in pairs(lines) do
					local steering = hook.ShopChanges[modelName]

					if steering then
						for _, weld in pairs(hook.ShopFields) do
							if steering[weld[1]] ~= nil then
								hook.ApplyShopState(modelName, weld[2], result47[modelName][weld[1]])
							end
						end
					end
				end

				if angleRadians and angleRadians.MarkDirty then
					angleRadians.MarkDirty(nil, false, true)
				end

				if angleRadians and angleRadians.EndBatch then
					angleRadians.EndBatch()
				end
			end

			return true
		end

		hook.RestoreShop = function()
			if not hook.ShopActive then
				return
			end
			hook.ShopActive = false
			local result13 = hook.Shop._inventoryPages

			for _, particle in pairs(hook.Types) do
				local angleRadians = result13 and result13[particle]

				if angleRadians and angleRadians.BeginBatch then
					angleRadians.BeginBatch()
				end
			end

			for vertex, particle in pairs(hook.ShopChanges) do
				for _, existingPlayer in pairs(hook.ShopFields) do
					if particle[existingPlayer[1]] ~= nil then
						hook.ApplyShopState(vertex, existingPlayer[2], particle[existingPlayer[1]])
					end
				end
			end

			for _, particle in pairs(hook.Types) do
				local angleRadians = result13 and result13[particle]

				if angleRadians and angleRadians.MarkDirty then
					angleRadians.MarkDirty(nil, false, true)
				end

				if angleRadians and angleRadians.EndBatch then
					angleRadians.EndBatch()
				end
			end

			table.clear(hook.ShopState)
			table.clear(hook.ShopChanges)
			table.clear(hook.ShopItems.Sword)
			table.clear(hook.ShopItems.Explosion)
		end

		hook.GetSelected = function()
			local endTime = hook.Console

			if endTime then
				local timestamp = endTime:GetCurrentPage()
				local targetPlayerName = endTime.PageInfo[timestamp]
				targetPlayerName = targetPlayerName and targetPlayerName.ItemState:Get()
				targetPlayerName = targetPlayerName and targetPlayerName.ItemInfo.Name
				if hook.ShopItems[timestamp] and targetPlayerName then
					return timestamp, targetPlayerName, hook.ShopItems[timestamp][targetPlayerName]
				end
				return
			end

			local definition = hook.Shop and hook.Shop._selectedItem
			local index57 = definition and definition.type
			definition = definition and definition.name
			if (index57 == "Sword" or index57 == "Explosion") and definition then
				return index57, definition, hook.ShopItems[index57][definition]
			end
		end

		hook.MakeOverlay = function(line, hitboxPart, object)
			if not hitboxPart then
				return
			end
			local containerFrame = Instance.new("TextButton")
			containerFrame.Name = "UnlockAll" .. line
			containerFrame.Text = ""
			containerFrame.AutoButtonColor = false
			containerFrame.BackgroundTransparency = 1
			containerFrame.BorderSizePixel = 0
			containerFrame.Size = UDim2.new(1, 0, 1, 0)
			containerFrame.ZIndex = 100
			containerFrame.Visible = false
			containerFrame.Parent = hitboxPart
			hook.Add(containerFrame.Activated:Connect(object))
			hook.Overlays[line] = containerFrame
		end

		hook.RefreshShop = function()
			if hook.Console then
				return
			end
			local radians, angleRadians, track = hook.GetSelected()
			local result76 = hook.Status == "active" and track ~= nil and not hook.Shop._multiDelete and hook.Deleted[radians][angleRadians] ~= true
			local rope = hook.Overlays.Favorite
			local cash = hook.Overlays.Delete
			local right = hook.Overlays.Accessory
			local constraint = hook.Overlays.Finisher

			if rope then
				rope.Visible = result76
			end

			if right then
				right.Visible = false
			end

			if constraint then
				constraint.Visible = false
			end

			track = track and hook.ShopState[track]
			local result32 = result76 and track ~= nil and track.Owns

			if cash then
				cash.Visible = result32 and track ~= nil
			end

			local File = newCharacter:FindFirstChild("Shop")
			File = File and File:FindFirstChild("Holder")

			if (radians == "Sword" or radians == "Explosion") and File and File:FindFirstChild("Favorite") then
				File.Favorite.Visible = result32

				if result32 then
					local cell = hook.Favorites[radians][angleRadians] == true
					File.Favorite.Image = cell and "rbxassetid://15697987058" or "rbxassetid://15697981750"
					File.Favorite.HoverImage = cell and "rbxassetid://15697983062" or "rbxassetid://15697987058"
				end
			end

			File = File and File:FindFirstChild("InfoBG")

			if File and File:FindFirstChild("SecretUpgrade") then
				File.SecretUpgrade.Visible = result32 and radians == "Sword" and hook.AwakenData[angleRadians] ~= nil
			end

			local cell = radians and angleRadians and hook.Deleted[radians][angleRadians] == true

			if File and File:FindFirstChild("Delete") then
				File.Delete.Visible = cash and cash.Visible or false
			end

			local characterModel = File and File:FindFirstChild("BuyButton")

			if File and cell then
				for _, modelName in pairs({
					"BuyButton",
					"GiftButton",
					"UpgradeButton",
					"Finisher",
					"ChangeStyle",
					"EquipAccessory",
					"SecretUpgrade",
					"CharacterUpgradeButton",
					"UpgradesInfoButton",
					"Equips",
				}) do
					local steering = File:FindFirstChild(modelName)

					if steering and steering:IsA("GuiObject") then
						steering.Visible = false
					end
				end
			end

			if characterModel and result32 and track and track.Virtual then
				local active = radians == "Sword" and hook.Sword == angleRadians or radians == "Explosion" and hook.Explosion == angleRadians
				characterModel.Visible = true
				characterModel.Active = true

				if characterModel:FindFirstChild("PriceTag") then
					local optionContainer = characterModel.PriceTag:FindFirstChild("Price")
					local nameLabel = characterModel.PriceTag:FindFirstChild("TextLabel")

					if optionContainer then
						optionContainer.Visible = false
					end

					if nameLabel then
						nameLabel.Text = active and "Equipped" or "Equip"
					end
				end
			end

			if radians == "Sword" and result32 and track and track.Virtual and File and File:FindFirstChild("Equips") then
				local list = hook.Shop._selectedItem and hook.Shop._selectedItem.data
				local drawingObject = File.Equips:FindFirstChild("Finisher")
				local ropeConstraint = File.Equips:FindFirstChild("EquipAccessory")

				if drawingObject and list and list.HasFinisher then
					drawingObject.Visible = true

					if constraint then
						constraint.Visible = true
					end

					drawingObject.ImageColor3 = Color3.new(1, 1, 1)
					drawingObject.Label.Text = hook.Finishers[angleRadians] and "UNEQUIP" or "EQUIP"
				end

				if ropeConstraint and list and list.AccessoryToggleable and hook.Sword == angleRadians then
					ropeConstraint.Visible = true

					if right then
						right.Visible = true
					end

					ropeConstraint.Label.Text = hook.Accessory and "UNEQUIP ACCESSORY" or "EQUIP ACCESSORY"
				end
			end

			if hook.Shop._multiDelete then
				hook.Shop:_updateMultiDeleteVisbility()
			end
		end

		hook.SetAccessory = function(line)
			hook.Accessory = line == true
			localPlayer:SetAttribute("ShowSwordAccessory", hook.Accessory)

			if hook.Accessory and hook.Sword then
				hook.ApplySword(hook.Sword)
			elseif not hook.Accessory then
				local radians = hook.GetCharacter()
				local result54 = radians and radians:FindFirstChild("SwordAccessories")

				if result54 then
					result54:Destroy()
				end
			end

			hook.Save()
			hook.RefreshShop()

			for vertex in pairs(hook.Clones) do
				hook.UpdateClone(vertex)
			end
		end

		hook.SetFinisher = function(line, object)
			if not line then
				return
			end
			local lines = { "Finishers", "Equipped", line }

			if hook.DefaultFinishers[line] == nil and hook.DataReplion then
				hook.DefaultFinishers[line] = hook.DataReplion:Get(lines) == true
			end

			hook.Finishers[line] = object and true or nil

			if hook.DataReplion then
				hook.DataReplion:_set(lines, object == true)
			end

			hook.Save()
			hook.RefreshShop()
		end

		hook.GetCardType = function(line)
			local File = newCharacter:FindFirstChild("Shop")
			local root = File and File:FindFirstChild("Holder") and File.Holder:FindFirstChild("Pages")
			if root and root:FindFirstChild("Sword") and line:IsDescendantOf(root.Sword) then
				return "Sword"
			end

			if root and root:FindFirstChild("Explosion") and line:IsDescendantOf(root.Explosion) then
				return "Explosion"
			end
		end

		hook.UpdateMultiDelete = function()
			local radians = 0

			for _, existingPlayer in pairs(hook.Types) do
				for _, propertyName in pairs(hook.MultiDelete[existingPlayer]) do
					radians += propertyName
				end
			end

			local lineObject = hook.Overlays.MultiDelete

			if lineObject then
				lineObject.Visible = hook.Status == "active"
			end

			local File = newCharacter:FindFirstChild("Shop")
			local textButton = File and File:FindFirstChild("Holder") and File.Holder:FindFirstChild("DeleteItems")
			textButton = textButton and textButton:FindFirstChild("Title")

			if textButton then
				textButton.Text = radians > 0 and "Delete Items (" .. radians .. ")" or "Delete Items"
			end
		end

		hook.GetDeleteList = function()
			local File = newCharacter:FindFirstChild("Shop")
			File = File and File:FindFirstChild("Holder")
			File = File and File:FindFirstChild("DeleteItems")
			local targetCharacter = File and File:FindFirstChild("List") and File.List:FindFirstChild("ContentsCanvas")
			return targetCharacter and targetCharacter:FindFirstChild("ScrollingFrame")
		end

		hook.SetDeleteCount = function(line, object, descendant)
			local radians = hook.ShopItems[line][object]
			local angleRadians = radians and hook.ShopState[radians]
			if not angleRadians then
				return
			end
			local difference = math.clamp(descendant, 0, #angleRadians.ItemsMatching)
			hook.MultiDelete[line][object] = difference > 0 and difference or nil
			hook.SetShopState(radians, { InDeleteMulti = difference, ForceHide = difference > 0 and difference == #angleRadians.ItemsMatching })
			local query = line .. "\0" .. object
			local targetPart = hook.MultiDeleteCards[query]

			if difference == 0 then
				if targetPart then
					targetPart:Destroy()
				end

				hook.MultiDeleteCards[query] = nil
			else
				local track = hook.GetDeleteList()

				if track then
					if not targetPart or targetPart.Parent ~= track then
						local modelTemplate = track:FindFirstChildWhichIsA("UIListLayout")
						modelTemplate = modelTemplate and modelTemplate:FindFirstChild("Template")
						local vertexCount = hook.ItemInfo[line][object]
						if not modelTemplate or not vertexCount then
							return
						end
						targetPart = modelTemplate:Clone()
						targetPart.Name = line .. "_" .. object
						targetPart.Visible = true
						targetPart.Button.Label.Text = vertexCount.DisplayName or vertexCount.Name or object
						targetPart.Button.Item.Vector.Image = vertexCount.Icon or ""
						local MATERIAL_PENETRATION_COST = hook.TradeInfo.SmallerSlotColors
						local capacity = MATERIAL_PENETRATION_COST[vertexCount.Rarity] or MATERIAL_PENETRATION_COST.Default
						targetPart.Button.Item.Image = capacity.Image
						targetPart.Button.Item.HoverImage = capacity.HoverImage
						targetPart.Parent = track
						hook.MultiDeleteCards[query] = targetPart

						local function handlePlayerRemoving()
							hook.SetDeleteCount(line, object, (hook.MultiDelete[line][object] or 0) - 1)
						end

						targetPart.Button.Activated:Connect(handlePlayerRemoving)
						targetPart.Button.Item.Activated:Connect(handlePlayerRemoving)
					end

					targetPart.Button.Item.Label.Text = "x" .. difference
				end
			end

			hook.UpdateMultiDelete()
		end

		hook.ClearMultiDelete = function()
			for _, particle in pairs(hook.Types) do
				for vertex in pairs(hook.MultiDelete[particle]) do
					local angleRadians = hook.ShopItems[particle][vertex]

					if angleRadians and not hook.Deleted[particle][vertex] then
						hook.SetShopState(angleRadians, { InDeleteMulti = 0, ForceHide = false })
					end
				end
			end

			table.clear(hook.MultiDelete.Sword)
			table.clear(hook.MultiDelete.Explosion)

			for vertex, particle in pairs(hook.MultiDeleteCards) do
				if particle then
					particle:Destroy()
				end

				hook.MultiDeleteCards[vertex] = nil
			end

			hook.UpdateMultiDelete()

			if hook.Status == "active" then
				hook.RefreshShop()
			end
		end

		hook.ToggleMultiItem = function(line)
			if not hook.Shop._multiDelete then
				return
			end
			local radians = hook.GetCardType(line)
			local callbackFunction = line:GetAttribute("Name")
			local angleRadians = radians and callbackFunction and hook.ShopItems[radians][callbackFunction]
			if not (angleRadians and hook.ShopState[angleRadians]) or hook.Deleted[radians][callbackFunction] then
				return
			end
			hook.SetDeleteCount(radians, callbackFunction, (hook.MultiDelete[radians][callbackFunction] or 0) + 1)
		end

		hook.HookMultiCard = function(line)
			if hook.Status ~= "active" or not line:IsA("GuiButton") or not hook.GetCardType(line) or hook.CardConnections[line] then
				return
			end

			hook.CardConnections[line] = line.Activated:Connect(function()
					hook.ToggleMultiItem(line)
				end)
		end

		hook.CloseMultiDelete = function()
			hook.Shop._multiDelete = nil
			hook.Shop:_updateMultiDeleteVisbility()
			hook.Shop:_updateMultiDelete()
			hook.ClearMultiDelete()
		end

		hook.ConfirmMultiDelete = function()
			if not hook.Shop._multiDelete then
				return
			end
			local lines = {}
			local radians = 0

			for _, existingPlayer in pairs(hook.Types) do
				for vertex, propertyName in pairs(hook.MultiDelete[existingPlayer]) do
					radians += propertyName
					table.insert(lines, { Type = existingPlayer, Name = vertex, Quantity = propertyName })
				end
			end

			hook.ConfirmDelete(lines, "x" .. radians .. " items", hook.CloseMultiDelete)
		end

		hook.HookMultiDelete = function(line)
			local root = line:FindFirstChild("Pages")
			local textButton = line:FindFirstChild("DeleteItems")
			local ServerStorage = textButton and textButton:FindFirstChild("List") and textButton.List:FindFirstChild("Buttons")
			local File = hook.Shop
			hook.Originals.CanDelete = File._canDelete

			File._canDelete = function()
				return false
			end

			hook.CloseMultiDelete()
			local result66 = File._updateMultiDelete

			File._updateMultiDelete = function(object)
				if hook.Status ~= "active" then
					return result66(object)
				end

				if not object._multiDelete then
					hook.ClearMultiDelete()
					return
				end
				hook.UpdateMultiDelete()
			end

			hook.Originals.UpdateMultiDelete = result66
			hook.MakeOverlay("MultiDelete", ServerStorage and ServerStorage:FindFirstChild("Delete"), hook.ConfirmMultiDelete)

			if root then
				for _, particle in root:GetDescendants() do
					hook.HookMultiCard(particle)
				end

				hook.Add(root.DescendantAdded:Connect(function(hit)
						task.defer(hook.HookMultiCard, hit)
					end))
			end

			hook.UpdateMultiDelete()
		end

		hook.HookShop = function()
			local File = newCharacter:FindFirstChild("Shop")
			File = File and File:FindFirstChild("Holder")
			local player5 = File and File:FindFirstChild("InfoBG")
			if not File or not player5 then
				return
			end

			for _, particle in pairs(hook.Types) do
				local angleRadians = hook.Shop._inventoryPages[particle]
				local result25 = angleRadians.MarkDirty

				local function handlePlayerRemoving(line)
					local track = hook.ShopState[line]
					if not track or not hook.ShopChanges[line] then
						return
					end

					for _, modelName in pairs(hook.ShopFields) do
						local steering = track[modelName[1]]

						if hook.GetShopState(line, modelName[2]) ~= steering then
							hook.ApplyShopState(line, modelName[2], steering)
						end
					end

					if hook.ConsoleItems then
						hook.SyncConsoleItem(line)
					end
				end

				angleRadians.MarkDirty = function(line, object, descendant)
					if hook.Status == "active" then
						if line then
							handlePlayerRemoving(line)
						else
							for _, propertyName in pairs(hook.Shop._virtualItems[particle]) do
								handlePlayerRemoving(propertyName)
							end
						end
					end

					return result25(line, object, descendant)
				end

				hook.Originals["MarkDirty" .. particle] = result25
			end

			hook.Add(player5.BuyButton.Activated:Connect(function()
					local radians, angleRadians = hook.GetSelected()

					if radians == "Sword" then
						hook.SelectSword(angleRadians)
					elseif radians == "Explosion" then
						hook.SelectExplosion(angleRadians)
					end

					task.defer(hook.RefreshShop)
				end))

			hook.MakeOverlay("Favorite", File:FindFirstChild("Favorite"), function()
					local radians, angleRadians = hook.GetSelected()

					if radians and angleRadians then
						hook.ToggleFavorite(radians, angleRadians)
						hook.RefreshShop()
					end
				end)

			hook.MakeOverlay("Delete", player5:FindFirstChild("Delete"), function()
					if demo(1143) < 5866 then
						local radians, angleRadians, track = hook.GetSelected()

						if radians and angleRadians and track and hook.ShopState[track] then
							hook.PromptDelete(radians, angleRadians)
						end

						return
					end

					while true do
					end
				end)

			local partInstance = newCharacter:FindFirstChild("SecretUpgrade")

			if partInstance then
				hook.MakeOverlay("AwakenOpen", player5:FindFirstChild("SecretUpgrade"), function()
						local radians, angleRadians = hook.GetSelected()

						if radians == "Sword" then
							hook.OpenAwaken(angleRadians)
						end
					end)

				hook.MakeOverlay("Awaken", partInstance.Main.Upgrade, function()
						hook.AwakenSword(hook.AwakenName)
					end)

				hook.Overlays.AwakenOpen.Visible = true
				hook.Overlays.Awaken.Visible = true
			end

			local character2 = player5:FindFirstChild("Equips")

			hook.MakeOverlay("Accessory", character2 and character2:FindFirstChild("EquipAccessory"), function()
					if demo(2212) < 7940 then
						local radians, angleRadians = hook.GetSelected()

						if radians == "Sword" and hook.Sword == angleRadians then
							hook.SetAccessory(not hook.Accessory)
						end

						return
					end

					while true do
					end
				end)

			hook.MakeOverlay("Finisher", character2 and character2:FindFirstChild("Finisher"), function()
					local radians, angleRadians = hook.GetSelected()

					if radians == "Sword" then
						hook.SetFinisher(angleRadians, not hook.Finishers[angleRadians])
					end
				end)

			if hook.Shop.itemSelected and hook.Shop.itemSelected.Connect then
				hook.Add(hook.Shop.itemSelected:Connect(function()
						task.defer(hook.RefreshShop)
					end))
			end

			hook.HookMultiDelete(File)
		end

		hook.SyncConsoleItem = function(line)
			local radians = hook.ConsoleItems[line.Type][line.Name]
			if not radians or hook.ShopItems[line.Type][line.Name] ~= line then
				return
			end
			local angleRadians = hook.ShopState[line]
			local difference = angleRadians.ForceHide and 0 or #angleRadians.ItemsMatching
			radians.Data.OwnedCopies:Set(difference)
			hook.ShopAPI:GetItemBaseOwnedState(line.Type, line.Name):SetTag("UnlockAll", difference > 0)
			hook.Console:UpdateItem(radians.Data)
		end

		hook.BindConsole = function(line, object)
			for _, particle in getconnections(line.Activated) do
				if particle.Enabled then
					particle:Disable()
					table.insert(hook.ConsoleConnections, particle)
				end
			end

			hook.Add(line.Activated:Connect(object))
		end

		hook.HookConsole = function()
			local result45 = hook.ShopAPI
			local ok = result45.ActiveVariant
			if not ok then
				return
			end
			hook.Console = ok
			hook.ConsoleItems = { Sword = {}, Explosion = {} }
			hook.ConsoleConnections = {}
			local result22 = newCharacter.ControllerShop.Main

			for vertex, particle in pairs({
				SetEquipped = function(line, object, descendant)
					if not hook.ShopItems[object] then
						return hook.Originals.APISetEquipped(line, object, descendant)
					end
					local accessoryPrototype = hook.InventoryClient:GetItem(object, descendant)
					accessoryPrototype = accessoryPrototype and accessoryPrototype.Name or descendant
					if not hook.ShopItems[object][accessoryPrototype] or hook.Deleted[object][accessoryPrototype] then
						return false
					end

					if object == "Sword" then
						hook.SelectSword(accessoryPrototype)
					else
						hook.SelectExplosion(accessoryPrototype)
					end

					return true
				end,
				ToggleFavorited = function(line, object)
					local player7 = object.ItemInfo.ItemType
					local targetPlayerName = object.ItemInfo.Name
					if not hook.ShopItems[player7] then
						return hook.Originals.APIToggleFavorited(line, object)
					end
					hook.ToggleFavorite(player7, targetPlayerName)
					return true
				end,
				ToggleSwordAccessory = function()
					hook.SetAccessory(not hook.Accessory)
				end,
				RequestFinisherEquip = function(line, object)
					hook.SetFinisher(object.Name, not hook.Finishers[object.Name])
					return true
				end,
				ToggleSwordStyle = function()
					local radians = hook.ItemInfo.Sword[hook.Sword]

					if radians then
						radians = radians.AnimationStyles[hook.Accessory and "Accessory" or "Base"]
					end

					if radians and #radians > 0 then
						localPlayer:SetAttribute("AnimationStyle", radians[(table.find(radians, localPlayer:GetAttribute("AnimationStyle")) or 0) % #radians + 1])
					end
				end,
			}) do
				hook.Originals["API" .. vertex] = result45[vertex]
				result45[vertex] = particle
			end

			local ServerStorage = result22.DeleteItems.List.Buttons
			local radians = nil

			for _, existingPlayer in getconnections(ServerStorage.Cancel.Activated) do
				local edgeIterator = existingPlayer.Enabled and existingPlayer.Function

				if edgeIterator then
					local endTime = replicatedStorage.Controllers.UI.ShopControllerAPI.Variants.Console
					edgeIterator = getfenv(existingPlayer.Function).script == endTime
				end

				if edgeIterator then
					radians = existingPlayer
					break
				end
			end

			hook.ConsoleCancel = radians

			hook.BindConsole(ServerStorage.Delete, function()
					local lines = {}
					local angleRadians = 0

					for vertex, propertyName in debug.getupvalue(ok.GetDeletingItemState, 1) do
						local vertexCount = propertyName:Get()
						local player7 = vertex.ItemInfo.ItemType
						local targetPlayerName = vertex.ItemInfo.Name

						if vertexCount > 0 and hook.ShopItems[player7] then
							angleRadians += vertexCount
							table.insert(lines, { Type = player7, Name = targetPlayerName, Quantity = vertexCount })
						end
					end

					hook.ConfirmDelete(lines, "x" .. angleRadians .. " items", function()
						if radians then
							radians:Fire()
						end
					end)
				end)

			hook.BindConsole(result22.Pages.Sword.Right.UpgradeButton, function()
					local angleRadians, track = hook.GetSelected()

					if angleRadians == "Sword" then
						hook.OpenAwaken(track)
					end
				end)

			hook.BindConsole(newCharacter.SecretUpgrade.Main.Upgrade, function()
					hook.AwakenSword(hook.AwakenName)
				end)

			local HOOK_ORIGINAL_RUN = hook.Run
			local difference = os.clock() + 0.004

			for _, existingPlayer in pairs(hook.Types) do
				for vertex, propertyName in pairs(hook.ShopItems[existingPlayer]) do
					local vertexCount = table.clone(propertyName.Item)

					if hook.ShopState[propertyName].Virtual and existingPlayer == "Sword" then
						local steering = hook.ItemInfo.Sword[vertex]
						vertexCount.Finisher = steering.HasFinisher or nil
						vertexCount.Accessory = steering.AccessoryUnlockable or nil
					end

					local instance3 = result45:GetItemData(existingPlayer, result45:ParseItemKey(existingPlayer, vertexCount))
					vertexCount.Id = "UnlockAll:" .. existingPlayer .. ":" .. vertex
					hook.ConsoleItems[existingPlayer][vertex] = { Data = instance3, Item = vertexCount, Favorite = instance3.IsFavorited:Get() }
					instance3.IsFavorited:Set(hook.Favorites[existingPlayer][vertex] == true)
					hook.SyncConsoleItem(propertyName)

					if os.clock() >= difference then
						runService.Heartbeat:Wait()
						if hook.Run ~= HOOK_ORIGINAL_RUN or hook.Status ~= "active" then
							return
						end
						difference = os.clock() + 0.004
					end
				end

				hook.Add(hook.InventoryClient:OnInventoryChange(existingPlayer, function()
						task.defer(function()
							if hook.Run ~= HOOK_ORIGINAL_RUN or hook.Status ~= "active" then
								return
							end

							for _, propertyName in pairs(hook.ShopItems[existingPlayer]) do
								hook.SyncConsoleItem(propertyName)
							end
						end)
					end))

				local track = hook[existingPlayer]

				if track then
					hook.SetEquipped(existingPlayer, track)
				end
			end
		end

		hook.RestoreConsole = function()
			local endTime = hook.Console
			if not endTime then
				return
			end

			if hook.ConsoleCancel then
				hook.ConsoleCancel:Fire()
			end

			for _, particle in pairs({
				"SetEquipped",
				"ToggleFavorited",
				"ToggleSwordAccessory",
				"RequestFinisherEquip",
				"ToggleSwordStyle",
			}) do
				onInputEnded("API" .. particle, hook.ShopAPI, particle)
			end

			for _, particle in pairs(hook.ConsoleConnections) do
				particle:Enable()
			end

			for vertex, particle in pairs(hook.ConsoleItems) do
				for neighbor, existingPlayer in pairs(particle) do
					existingPlayer.Data.OwnedCopies:Set(#hook.InventoryClient:FindItemsWithKey(vertex, existingPlayer.Data.ParsedItemKey))
					existingPlayer.Data.IsFavorited:Set(existingPlayer.Favorite)
					hook.ShopAPI:GetItemBaseOwnedState(vertex, neighbor):SetTag("UnlockAll", nil)
					endTime:UpdateItem(existingPlayer.Data)
				end
			end

			hook.Console = nil
			hook.ConsoleItems = nil
			hook.ConsoleConnections = nil
			hook.ConsoleCancel = nil
		end

		hook.OpenAwaken = function(columnIndex)
			local radians = hook.AwakenData[columnIndex]
			if not radians then
				return
			end
			hook.AwakenName = columnIndex
			local partInstance = newCharacter.SecretUpgrade
			partInstance:SetAttribute("ToAwaken", nil)
			local result22 = partInstance.Main
			result22.template1.vector.Image = radians.Regular.Icon
			result22.template2.vector.Image = radians.Awakened.Icon
			result22.template2.customs.c3.Visible = radians.CustomSlash == true
			result22.Progress.Fill.Size = UDim2.fromScale(1, 1)
			local result40 = hook.AwakenData.Requirement
			result22.Progress.Progress.Text = result40 .. "/" .. result40
			require(replicatedStorage.ClientGameModules.GuiHandler):Open("SecretUpgrade")
		end

		hook.DestroyOverlays = function()
			for _, particle in pairs(hook.Overlays) do
				if particle and particle.Parent then
					particle:Destroy()
				end
			end

			table.clear(hook.Overlays)
		end

		hook.ConfirmDelete = function(line, object, descendant)
			local HOOK_ORIGINAL_RUN = hook.Run

			hook.DeletePrompt:PromptConfirmation({
				PromptType = "Single",
				Description = "Are you sure you want to delete " .. object .. "? This cannot be undone.",
			}, function(radius)
					if not radius or hook.Status ~= "active" or hook.Run ~= HOOK_ORIGINAL_RUN then
						return
					end

					for _, particle in pairs(line) do
						hook.DeleteItem(particle.Type, particle.Name, particle.Quantity)
					end

					if descendant then
						descendant()
					end
				end)
		end

		hook.PromptDelete = function(line, object)
			if not hook.DeletePrompt then
				return hook.DeleteItem(line, object)
			end
			local radians = hook.ItemInfo[line] and hook.ItemInfo[line][object]
			hook.ConfirmDelete({ { Type = line, Name = object } }, "x1 " .. tostring(radians and (radians.DisplayName or radians.Name) or object))
		end

		hook.AwakenSword = function(line)
			local radians = line and hook.AwakenData[line]
			local angleRadians = line and hook.ShopItems.Sword[line]
			local track = radians and hook.ShopItems.Sword[radians.Awakened.Value]
			local vertexCount = angleRadians and hook.ShopState[angleRadians]
			if hook.Status ~= "active" or not track or not vertexCount or #vertexCount.ItemsMatching == 0 then
				return
			end
			hook.AwakenName = nil
			local steering = table.clone(vertexCount.ItemsMatching)
			table.remove(steering)

			hook.SetShopState(angleRadians, {
				ItemsMatching = steering,
				Owns = #steering > 0,
				Section = #steering > 0 and "Owned" or "Unowned",
				ForceHide = #steering == 0,
			})

			local contactName = radians.Awakened.Value
			local major = table.clone(hook.ShopState[track].ItemsMatching)
			table.insert(major, "UnlockAll:" .. contactName)
			hook.Deleted.Sword[contactName] = nil
			hook.SetShopState(track, { ItemsMatching = major, Owns = true, Section = "Owned", ForceHide = false })

			if hook.Sword == line then
				hook.SelectSword(contactName, false)
			end

			if hook.Console then
				hook.Console.PageInfo.Sword.ItemState:Set(hook.ConsoleItems.Sword[contactName].Data)
			else
				hook.Shop:Select({ type = "Sword", name = contactName, data = hook.GetSwordData(contactName) })
			end

			require(replicatedStorage.ClientGameModules.GuiHandler):Open(hook.Console and "ControllerShop" or "Shop")
			hook.RefreshShop()
		end

		hook.DeleteItem = function(line, object, descendant)
			if hook.Status ~= "active" then
				return
			end

			if line == "Emote" then
				local radians = hook.EmoteItems[object]
				if not radians then
					return
				end
				hook.Deleted.Emote[object] = true
				hook.SetFavorite("Emote", object, false, false)
				local sourceIterator = hook.EmoteCaller and hook.EmoteCaller.Replion.Data.Inventory.Emote

				if sourceIterator and sourceIterator[radians.Id] then
					sourceIterator[radians.Id] = nil

					if hook.EmoteView then
						hook.EmoteView.TriggerUpdate(radians, "Remove")
					end
				end

				for vertex, existingPlayer in pairs(hook.EquippedEmotes) do
					if existingPlayer == object then
						hook.EquippedEmotes[vertex] = nil
					end
				end

				hook.UpdateEmoteWheel()
				hook.Save()
				return
			end

			local radians = hook.ShopItems[line] and hook.ShopItems[line][object]
			local angleRadians = radians and hook.ShopState[radians]
			if not angleRadians then
				return
			end
			local track = table.clone(angleRadians.ItemsMatching)
			local vertexCount = 1
			local endIndex = math.min
			local difference = descendant or 1

			for k = vertexCount, endIndex(difference, #track) do
				table.remove(track)
			end

			hook.SetShopState(radians, { ItemsMatching = track, InDeleteMulti = 0 })

			if #track > 0 then
				hook.SetShopState(radians, { ForceHide = false })
				hook.RefreshShop()
				return
			end

			hook.Deleted[line][object] = true
			hook.SetFavorite(line, object, false, false)
			hook.SetShopState(radians, { Owns = false, Section = "Unowned", ForceHide = false })

			if line == "Sword" and hook.Sword == object then
				hook.RestoreSword(true)
			elseif line == "Explosion" and hook.Explosion == object then
				hook.RestoreExplosion(true)
			else
				hook.Save()
			end

			hook.RefreshShop()
		end

		hook.PatchSwords = function()
			if hook.SwordsPatched then
				return
			end
			local yString = rawget(hook.Swords, "EquipSwordTo")
			local radians = yString and getupvalues and getupvalues(yString)
			if not radians or not setupvalue then
				return
			end
			local angleRadians = nil

			for vertex, propertyName in pairs(radians) do
				if typeof(propertyName) == "Instance" and propertyName.ClassName == "Players" then
					angleRadians = vertex
				elseif type(propertyName) == "table" and type(rawget(propertyName, "cancel")) == "function" and type(rawget(propertyName, "begin")) == "function" then
					hook.SwordState = propertyName
				end
			end

			if not angleRadians and radians[3] == false and radians[4] == true then
				setupvalue(yString, 3, playersService)
				angleRadians = 3
			end

			if angleRadians and type(radians[angleRadians + 1]) == "boolean" then
				setupvalue(yString, angleRadians + 1, false)
			end

			hook.SwordsPatched = angleRadians ~= nil
		end

		hook.GetSwordData = function(line)
			local radians = hook.SwordData[line]
			if radians then
				return radians
			end
			local bypassFunction = hook.Swords
			bypassFunction = bypassFunction and bypassFunction:GetSword(line)

			if not bypassFunction then
				bypassFunction = replicatedStorage.Shared.ReplicatedInstances:FindFirstChild("Swords")
				bypassFunction = bypassFunction and bypassFunction:FindFirstChild("GetSword")
				bypassFunction = bypassFunction and bypassFunction:Invoke(line)
			end

			if bypassFunction then
				hook.SwordData[line] = bypassFunction
			end

			return bypassFunction
		end

		hook.GetSlash = function(line)
			local radians = hook.GetSwordData(line)
			if not radians then
				return
			end
			local result48 = radians.SlashName or "SlashEffect"
			hook.SwordFX:GetInstance(result48)
			return result48
		end

		hook.RemoveSwords = function(line, object)
			if not line then
				return
			end

			for _, particle in line:GetChildren() do
				if particle:IsA("Model") and particle.Name ~= object and hook.GetSwordData(particle.Name) then
					particle:Destroy()
				end
			end
		end

		hook.GetBlade = function()
			if hook.BladeController then
				return hook.BladeController
			end

			if not getconnections or not getupvalues then
				return
			end
			local event = replicatedStorage:FindFirstChild("Remotes") and replicatedStorage.Remotes:FindFirstChild("FireSwordInfo")
			if not event then
				return
			end

			for _, particle in getconnections(event.OnClientEvent) do
				local edgeIterator = particle.Function and getupvalues(particle.Function)

				if type(edgeIterator) == "table" then
					for _, existingPlayer in pairs(edgeIterator) do
						if type(existingPlayer) == "table" and type(existingPlayer.SetSword) == "function" then
							hook.BladeController = existingPlayer
							return existingPlayer
						end
					end
				end
			end
		end

		hook.PatchBlade = function(line)
			if not line or hook.Originals.SetSword then
				return
			end
			hook.Originals.SetSword = line.SetSword

			line.SetSword = function(object, descendant)
				if hook.Status == "active" and hook.Sword then
					descendant = hook.Sword
				end

				return hook.Originals.SetSword(object, descendant)
			end
		end

		hook.ApplySword = function(line)
			local radians = hook.GetCharacter()
			if not radians or not line then
				return
			end
			local targetHumanoid = radians:FindFirstChildOfClass("Humanoid") or radians:WaitForChild("Humanoid", 2)
			if not targetHumanoid or targetHumanoid.Health <= 0 or not radians:FindFirstChild("HumanoidRootPart") then
				return
			end

			if hook.Sword and not hook.SavedEquipped.Sword then
				hook.Originals.EquippedSword = hook.GetRealEquipped("Sword")
				hook.SavedEquipped.Sword = true
			end

			hook.PatchSwords()
			local player22 = hook.SwordState

			if player22 then
				player22.cancel(radians)
			end

			if hook.Swords:EquipSwordTo(radians, line) == false then
				return
			end
			hook.Slash = hook.GetSlash(line) or hook.Slash

			if not hook.Accessory then
				local result54 = radians:FindFirstChild("SwordAccessories")

				if result54 then
					result54:Destroy()
				end
			end

			local angleRadians = hook.GetBlade()

			if angleRadians then
				hook.PatchBlade(angleRadians)
				angleRadians:SetSword(line)
			end

			if not hook.Accessory then
				task.defer(function()
						local result54 = radians:FindFirstChild("SwordAccessories")

						if result54 then
							result54:Destroy()
						end
					end)
			end

			task.defer(hook.RemoveSwords, radians, line)
		end

		hook.SetEquipped = function(line, object)
			if not hook.SavedEquipped[line] then
				hook.Originals["Equipped" .. line] = hook.GetRealEquipped(line)
				hook.SavedEquipped[line] = true
			end

			local sortedArray = hook.ConsoleItems and hook.ConsoleItems[line][object]
			hook.InventoryReplion:_set({ "Equipped", line }, sortedArray and sortedArray.Item or hook.GetOwnedItem(line, object) or { Name = object, Id = "UnlockAll:" .. line .. ":" .. object })

			if hook.Shop and hook.Shop._selectedItem then
				hook.Shop:Select(hook.Shop._selectedItem, true)
			end
		end

		hook.WatchSword = function(line)
			if not line then
				return
			end

			hook.Add(line.DescendantAdded:Connect(function(hit)
					local player20 = hook.Sword
					if hook.Status ~= "active" or not player20 then
						return
					end
					local otherPart = hit:FindFirstAncestorOfClass("Model")

					while otherPart and otherPart.Parent ~= line do
						otherPart = otherPart:FindFirstAncestorOfClass("Model")
					end

					if not otherPart or not otherPart:GetAttribute("_equippedSword") or otherPart.Name == player20 then
						return
					end

					if hit:IsA("BasePart") or hit:IsA("Decal") then
						hit.Transparency = 1
					elseif hit:IsA("ParticleEmitter") or hit:IsA("Trail") then
						hit.Enabled = false
						hit:Clear()
					elseif hit:IsA("Beam") or hit:IsA("Fire") or hit:IsA("Smoke") or hit:IsA("Sparkles") or hit:IsA("Light") then
						hit.Enabled = false
					end
				end))

			hook.Add(line:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
					local player20 = hook.Sword

					if hook.Status == "active" and player20 and line:GetAttribute("CurrentlyEquippedSword") ~= player20 then
						task.defer(hook.ApplySword, player20)
					end
				end))

			local targetHumanoid = line:FindFirstChildOfClass("Humanoid") or line:WaitForChild("Humanoid", 2)

			if targetHumanoid then
				hook.Add(targetHumanoid.HealthChanged:Connect(function(startIndex)
						local player20 = hook.Sword

						if hook.Status == "active" and startIndex > 0 and player20 then
							task.defer(hook.ApplySword, player20)
						end
					end))
			end
		end

		hook.ClearCloneTracks = function(line)
			if not (n25 > 6642) then
				line.Data = nil

				for vertex, particle in pairs(line.OriginalTracks) do
					if line.Animator and line.Animator.Parent then
						vertex:Play(0, particle.Weight, particle.Speed)
					end
				end

				table.clear(line.OriginalTracks)

				for _, particle in pairs(line.Tracks) do
					particle:Stop(0)
					particle:Destroy()
				end

				table.clear(line.Tracks)
				return
			end

			while true do
			end
		end

		hook.PlayCloneTrack = function(line, object)
			local radians = hook.Clones[line]
			if not radians or not radians.Data or not object.IsPlaying then
				return
			end

			for _, existingPlayer in pairs(radians.Tracks) do
				if object == existingPlayer then
					return
				end
			end

			local chunk = object.Animation and hook.CloneAnimationTypes[object.Animation.AnimationId]
			if not chunk then
				return
			end
			local angleRadians = features.Animation.SwordAPI:GetAnimations(line, chunk, radians.Data.AnimationType, radians.Data.SwordType)[1]
			if not angleRadians or angleRadians.AnimationId == object.Animation.AnimationId then
				return
			end
			local track = radians.Tracks[angleRadians]

			if not track then
				track = radians.Animator:LoadAnimation(angleRadians)
				radians.Tracks[angleRadians] = track
			end

			local originPosition = object.WeightTarget

			if object.Looped then
				radians.OriginalTracks[object] = { Weight = originPosition, Speed = object.Speed }
			end

			track.Priority = object.Priority
			track.Looped = object.Looped
			track:Play(0, originPosition, object.Speed)

			if track.Length > 0 then
				track.TimePosition = math.min(object.TimePosition, track.Length)
			end

			object:Stop(0)
		end

		hook.UpdateClone = function(line)
			local radians = hook.Clones[line]
			if not radians or radians.Thread or hook.Status ~= "active" or not hook.Sword then
				return
			end
			local targetHumanoid = line:FindFirstChildOfClass("Humanoid")
			local sourcePlayer = targetHumanoid and targetHumanoid:FindFirstChildOfClass("Animator")
			if not sourcePlayer or not line:FindFirstChild("Torso") or not line:FindFirstChild("Left Arm") or not line:FindFirstChild("Right Arm") then
				return
			end

			if radians.Model and radians.Model.Parent == line and radians.Name == hook.Sword and radians.Accessory == hook.Accessory then
				for _, existingPlayer in line:GetChildren() do
					if existingPlayer ~= radians.Model and existingPlayer:GetAttribute("_equippedSword") then
						existingPlayer:Destroy()
					end
				end

				return
			end

			radians.Thread = task.defer(function()
					local player20 = hook.Sword
					local right = hook.Accessory
					hook.ClearCloneTracks(radians)
					local angleRadians = hook.GetSwordData(player20)
					local decoded, otherPart = pcall(hook.Swords.ForceEquipSwordTo, hook.Swords, line, player20, nil, right)
					if hook.Clones[line] ~= radians then
						return
					end

					if not decoded or not otherPart or not angleRadians then
						radians.Thread = nil
						return
					end
					local track = radians
					local vertexCount = radians
					radians.Model = otherPart
					track.Name = player20
					vertexCount.Accessory = right
					local steering = radians
					local major = sourcePlayer
					radians.Data = angleRadians
					steering.Animator = major

					if not radians.Connections.Animation then
						radians.Connections.Animation = sourcePlayer.AnimationPlayed:Connect(function(object)
							hook.PlayCloneTrack(line, object)
						end)
					end

					for _, partTemplate in sourcePlayer:GetPlayingAnimationTracks() do
						hook.PlayCloneTrack(line, partTemplate)
					end

					radians.Thread = nil
					hook.UpdateClone(line)
				end)
		end

		hook.ClearClone = function(line, object)
			local radians = hook.Clones[line]
			if not radians then
				return
			end
			hook.Clones[line] = nil
			cleanupResources(radians.Connections)
			cleanupResources(radians.Thread)
			hook.ClearCloneTracks(radians)

			if object and radians.Model and line.Parent then
				local callbackFunction = line:GetAttribute("EquippedSword") or radians.OriginalSword

				if callbackFunction then
					task.defer(function()
							if line.Parent and not hook.Clones[line] then
								hook.Swords:ForceEquipSwordTo(line, callbackFunction, nil, radians.OriginalAccessory)
							end
						end)
				end
			end
		end

		hook.WatchClone = function(line)
			local cell = hook.Status ~= "active"
			local active

			if cell then
				active = cell
			else
				local targetPlayerName = localPlayer.Name
				active = line:GetAttribute("EncryptedCloneOwner") ~= targetPlayerName
			end

			if active or hook.Clones[line] then
				return
			end

			if not hook.CloneAnimationTypes then
				local keys = {}

				for _, particle in replicatedStorage.Shared.SwordAPI.Collection:GetDescendants() do
					if particle:IsA("Animation") then
						for _, existingPlayer in pairs({ "Idle", "Parry", "GrabParry", "SuccessParry" }) do
							if particle:GetAttribute(existingPlayer) then
								local track = keys[particle.AnimationId]
								local rowIndex = particle.AnimationId
								local isArray = track == nil and existingPlayer
								local bestLabel

								if isArray then
									bestLabel = isArray
								else
									bestLabel = track == existingPlayer and existingPlayer
								end

								bestLabel = bestLabel or false
								keys[rowIndex] = bestLabel
								break
							end
						end
					end
				end

				hook.CloneAnimationTypes = keys
			end

			local lines = {
				Connections = {},
				Tracks = {},
				OriginalTracks = {},
				OriginalSword = line:GetAttribute("EquippedSword"),
				OriginalAccessory = line:GetAttribute("HasAccessoryEquipped") == true,
			}

			hook.Clones[line] = lines

			lines.Connections.Loaded = line.DescendantAdded:Connect(function(hit)
					local result15 = hit:IsA("Animator")
					local callbackFunction

					if result15 then
						callbackFunction = result15
					else
						local isArray = hit.Parent == line

						if isArray then
							callbackFunction = not lines.Model or hit:GetAttribute("_equippedSword")
						else
							callbackFunction = isArray
						end
					end

					if callbackFunction then
						task.defer(hook.UpdateClone, line)
					end
				end)

			hook.UpdateClone(line)
		end

		hook.WatchEmotes = function(line)
			local targetHumanoid

			if line then
				targetHumanoid = line:FindFirstChildOfClass("Humanoid") or line:WaitForChild("Humanoid", 2)
			else
				targetHumanoid = line
			end

			if not targetHumanoid then
				return
			end

			hook.Add(targetHumanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
					if targetHumanoid.MoveDirection ~= Vector3.zero and hook.EmoteTrove then
						hook.StopEmote()
					end
				end))
		end

		hook.SelectSword = function(player21, line)
			if not player21 or hook.Deleted.Sword[player21] then
				return
			end
			hook.Sword = player21
			hook.Slash = hook.GetSlash(player21)
			features.Animation.PreloadSword(player21)
			hook.SetEquipped("Sword", player21)
			hook.PatchParrySuccess()

			for _, particle in game:GetService("CollectionService"):GetTagged("EncryptedClone") do
				hook.WatchClone(particle)
				hook.UpdateClone(particle)
			end

			task.defer(function()
					if hook.Status == "active" and hook.Sword == player21 then
						hook.ApplySword(player21)
					end
				end)

			if line ~= false then
				hook.Save()
			end
		end

		hook.RestoreSword = function(line)
			local player20 = hook.Defaults.Sword or "Base Sword"
			hook.Sword = nil
			hook.Slash = nil

			if hook.SavedEquipped.Sword then
				hook.InventoryReplion:_set({ "Equipped", "Sword" }, hook.Originals.EquippedSword)
				hook.Originals.EquippedSword = nil
				hook.SavedEquipped.Sword = nil
			end

			hook.ApplySword(player20)

			if line then
				hook.Save()
			end

			for vertex in pairs(hook.Clones) do
				callWithRestoredThreadIdentity(hook.ClearClone, vertex, true)
			end
		end

		hook.SelectExplosion = function(vehicleEntity, line)
			if not vehicleEntity or hook.Deleted.Explosion[vehicleEntity] then
				return
			end
			hook.Explosion = vehicleEntity
			hook.SetEquipped("Explosion", vehicleEntity)
			localPlayer:SetAttribute("CurrentlyEquippedExplosion", vehicleEntity)
			local radians = hook.GetCharacter()

			if radians then
				radians:SetAttribute("CurrentlyEquippedExplosion", vehicleEntity)
			end

			if line ~= false then
				hook.Save()
			end
		end

		hook.RestoreExplosion = function(line)
			local health = hook.Defaults.Explosion or "Explosion Normal"
			hook.Explosion = nil

			if hook.SavedEquipped.Explosion then
				hook.InventoryReplion:_set({ "Equipped", "Explosion" }, hook.Originals.EquippedExplosion)
				hook.Originals.EquippedExplosion = nil
				hook.SavedEquipped.Explosion = nil
			end

			localPlayer:SetAttribute("CurrentlyEquippedExplosion", health)
			local radians = hook.GetCharacter()

			if radians then
				radians:SetAttribute("CurrentlyEquippedExplosion", health)
			end

			if line then
				hook.Save()
			end
		end

		hook.PatchExplosion = function()
			if not hook.VFX or hook.Originals.PlayExplosion then
				return
			end
			hook.Originals.PlayExplosion = hook.VFX.PlayExplosion

			hook.VFX.PlayExplosion = function(line, object, descendant, radius, zCoordinate, alpha, color)
				if hook.Status == "active" and hook.Explosion and color and alpha == localPlayer.Character then
					object = hook.Explosion
				end

				if hook.Status == "active" and color and alpha == localPlayer.Character and hook.Sword and hook.Finishers[hook.Sword] and hook.FinishersController then
					local explosion = zCoordinate and zCoordinate:FindFirstChild("HumanoidRootPart")
					local folder = workspace:FindFirstChild("Alive")
					local queue = folder and folder:GetChildren() or {}
					local difference = 0

					for _, particle in pairs(queue) do
						if particle ~= zCoordinate then
							difference += 1
						end
					end

					if explosion and folder and difference <= 1 then
						hook.FinishersController:PlayFinisher(hook.Sword, alpha, zCoordinate, explosion.CFrame, workspace:GetServerTimeNow())
					end
				end

				return hook.Originals.PlayExplosion(line, object, descendant, radius, zCoordinate, alpha, color)
			end
		end

		hook.PatchParrySuccess = function()
			if not hookfunction or not getconnections or not getinfo then
				return
			end
			local bindable = replicatedStorage:FindFirstChild("Remotes")
			local result5 = globalEnvironment.FlyteSwordEffects or {}
			globalEnvironment.FlyteSwordEffects = result5

			local function handlePlayerRemoving(line, object)
				if hook.Originals[line] or not object then
					return false
				end

				for _, particle in getconnections(object) do
					if particle.Function and (getinfo(particle.Function).name == "parrySuccessAll" or result5[line] == particle.Function) then
						result5[line] = particle.Function
						hook.Originals[line .. "Target"] = particle.Function
						hook.Originals[line] = hookfunction(particle.Function, function(...)local i={...};if  hook .Status=="active"and  hook .Sword and(tostring(i[4])== localPlayer .Name or type(i[4])=="table"and  hook .Clones[i[4].Character])then local y= hook .Slash;if y then i[1]=y;i[3]= hook .Sword;end;end;return  hook .Originals[ line ](unpack(i));end)
						return true
					end
				end

				return false
			end

			local remote = bindable and bindable:FindFirstChild("ParrySuccessAll")
			handlePlayerRemoving("Parry_All_Func", remote and remote.OnClientEvent)
			bindable = bindable and bindable:FindFirstChild("ParrySuccessClient")

			if bindable then
				bindable = bindable:IsA("BindableEvent") and bindable.Event or bindable.OnClientEvent
			end

			handlePlayerRemoving("Parry_Client_Func", bindable)
		end

		hook.StopEmote = function()
			if hook.EmoteTrove then
				hook.EmoteTrove:Destroy()
				hook.EmoteTrove = nil
			end

			local model = localPlayer.Character

			if model then
				model:SetAttribute("Emoting", nil)
			end
		end

		hook.PlayEmote = function(line)
			local radians = hook.EmotesFolder:FindFirstChild(line)
			local angleRadians = hook.GetCharacter()
			local targetHumanoid = angleRadians and angleRadians:FindFirstChildOfClass("Humanoid")
			if not radians or not angleRadians or not targetHumanoid or targetHumanoid.MoveDirection.Magnitude > 0 then
				return
			end
			hook.StopEmote()
			hook.EmoteTrove = hook.Trove.new()
			angleRadians:SetAttribute("Emoting", radians:GetAttribute("EmoteName") or radians.Name)
			hook.EmotesShared:Play(angleRadians, hook.EmoteTrove, radians.Name, true, workspace:GetServerTimeNow(), 1, nil, false)
		end

		hook.PatchEmotes = function()
			if hook.Originals.EmotePlay then
				return
			end
			hook.Originals.EmotePlay = hook.EmoteController.Play

			hook.EmoteController.Play = function(line, object, descendant)
				local cell = hook.Status == "active" and object and hook.EmotesFolder:FindFirstChild(object)
				if cell and cell.AnimationId ~= "" and cell.AnimationId ~= "rbxassetid://0" then
					return hook.PlayEmote(object)
				end
				return hook.Originals.EmotePlay(line, object, descendant)
			end

			for _, particle in pairs({ "UpdateHolderEmotes", "UpdateMenuContentEmotes" }) do
				local angleRadians = particle
				hook.Originals[angleRadians] = hook.EmoteWheel[angleRadians]

				hook.EmoteWheel[angleRadians] = function(line, ...)
					local track = hook.Originals[angleRadians]
					local vertexCount = table.pack(...)
					vertexCount.n = 2 + vertexCount.n - 1
					table.move(vertexCount, 1, vertexCount.n, 2, vertexCount)
					vertexCount[1] = line
					local steering = track(table.unpack(vertexCount, 1, vertexCount.n))

					if hook.Status == "active" then
						hook.RefreshEmotes()
					end

					return steering
				end
			end
		end

		hook.GetEmoteSlot = function()
			if hook.EmoteWheel.type == "Menu" then
				return math.clamp(tonumber(hook.EmoteWheel.selected) or 1, 1, 24)
			end
			return math.clamp(tonumber(hook.EmoteWheel.selected) or hook.SelectedSlot or 1, 1, 8) + ((tonumber(hook.EmoteWheel.page) or 1) - 1) * 8
		end

		hook.SetEmoteButton = function(line, object)
			local radians = hook.EmotesFolder:FindFirstChild(object)
			if not radians then
				return
			end
			local callbackFunction = radians:GetAttribute("EmoteName") or radians.Name
			local cost = radians:GetAttribute("Icon") or ""
			local hitHumanoid = newCharacter:FindFirstChild("EmoteWheel")
			local result78 = hitHumanoid and hitHumanoid:FindFirstChild("Wheel")
			hitHumanoid = hitHumanoid and hitHumanoid:FindFirstChild("Menu")
			local angleRadians = 1
			local difference = math.floor((line - 1) / 8) + angleRadians
			result78 = result78 and result78:FindFirstChild("Holder")
			hitHumanoid = hitHumanoid and hitHumanoid:FindFirstChild("Content")
			local lines = {}
			local cell = difference == (tonumber(hook.EmoteWheel.page) or 1) and result78 and result78:FindFirstChild(tostring((line - 1) % 8 + 1))
			hitHumanoid = hitHumanoid and hitHumanoid:FindFirstChild(tostring(line))
			lines[1] = cell
			lines[2] = hitHumanoid

			for _, propertyName in pairs(lines) do
				if propertyName then
					propertyName:SetAttribute("EmoteId", object)
					propertyName:SetAttribute("EmoteName", callbackFunction)
					local relativePosition = propertyName:FindFirstChild("Vector")

					if relativePosition then
						relativePosition.Image = cost
					elseif propertyName:IsA("ImageButton") then
						propertyName.Image = cost
					end

					local inputBox = propertyName:FindFirstChild("Title") or propertyName:FindFirstChild("ItemName") or propertyName:FindFirstChild("Text")

					if inputBox and inputBox:IsA("TextLabel") then
						inputBox.Text = callbackFunction
					end
				end
			end
		end

		hook.RefreshEmotes = function()
			for vertex, particle in pairs(hook.EquippedEmotes) do
				hook.SetEmoteButton(tonumber(vertex) or vertex, particle)
			end
		end

		hook.UpdateEmoteWheel = function()
			local result64 = hook.Originals.UpdateHolderEmotes
			local result65 = hook.Originals.UpdateMenuContentEmotes

			if result64 then
				result64(hook.EmoteWheel)
			else
				hook.EmoteWheel:UpdateHolderEmotes()
			end

			if result65 then
				result65(hook.EmoteWheel)
			else
				hook.EmoteWheel:UpdateMenuContentEmotes()
			end

			hook.EmoteWheel:updateCenterText()
			hook.RefreshEmotes()
		end

		hook.ApplyEmote = function(line, object)
			local index50 = tonumber(line) or hook.GetEmoteSlot()
			if not object or hook.Deleted.Emote[object] or not hook.EmotesFolder:FindFirstChild(object) then
				return
			end
			hook.SelectedSlot = index50
			hook.EquippedEmotes[index50] = object
			hook.UpdateEmoteWheel()
			hook.Save()
		end

		hook.GetEmoteScroller = function()
			if hook.EmoteContainer then
				return hook.EmoteContainer
			end
			local hitHumanoid = newCharacter:FindFirstChild("EmoteWheel")
			hitHumanoid = hitHumanoid and hitHumanoid:FindFirstChild("List")
			return hitHumanoid and hitHumanoid:FindFirstChild("Content")
		end

		hook.LoadEmotes = function()
			local sourceIterator = hook.InventoryClient:GetInventory().Emote or {}
			if hook.EmoteCatalogLoaded then
				return sourceIterator
			end
			table.clear(hook.EmoteItems)
			table.clear(hook.EmoteItemsList)
			table.clear(hook.EmoteDisplays)
			table.clear(hook.EmoteItemKeys)
			local lines = {}

			for _, particle in pairs(sourceIterator) do
				if not hook.IsUnlockItem(particle) then
					lines[particle.Name] = true
				end
			end

			local radians = 0.001
			local difference = os.clock() + radians

			for _, existingPlayer in hook.EmotesFolder:GetChildren() do
				local track = hook.ItemInfo.Emote[existingPlayer.Name]

				if existingPlayer:IsA("Animation") and track then
					hook.EmoteDisplays[track.DisplayName or track.Name] = existingPlayer.Name
				end

				if existingPlayer:IsA("Animation") and not lines[existingPlayer.Name] and track and type(track.Icon) == "string" and track.Icon ~= "" and track.Icon ~= "rbxassetid://0" and track.Icon ~= existingPlayer.AnimationId then
					local sourceTable = { Name = existingPlayer.Name, Id = "UnlockAll:Emote:" .. existingPlayer.Name, CreatedAt = 0 }
					hook.EmoteItems[existingPlayer.Name] = sourceTable
					table.insert(hook.EmoteItemsList, sourceTable)
					local players = { "Id" }
					local result11 = sourceTable.Id
					hook.EmoteItemKeys[hook.InventoryShared:ItemToKey("Emote", sourceTable, players)] = result11
				end

				if difference <= os.clock() then
					runService.Heartbeat:Wait()
					difference = os.clock() + 0.001
				end
			end

			hook.EmoteCatalogLoaded = true
			return sourceIterator
		end

		hook.FillEmoteInventory = function()
			if hook.EmotesReady or hook.EmoteBuilding or not hook.EmoteView then
				return
			end
			hook.EmoteBuilding = true
			hook.EmoteBuildToken = hook.EmoteBuildToken + 1
			local isReady = hook.EmoteBuildToken

			task.spawn(function()
					local pattern = hook.EmoteItemsList
					local result2 = hook.EmoteInventory
					local rightIndex = hook.EmoteBuildIndex

					while rightIndex <= #pattern and hook.EmoteBuildToken == isReady do
						local difference = os.clock() + 0.001

						while true do
							local radians = pattern[rightIndex]

							if not result2[radians.Id] and not hook.Deleted.Emote[radians.Name] then
								result2[radians.Id] = radians
								hook.EmoteView.TriggerUpdate(radians, "Insert")
							end

							rightIndex += 1
							if not (rightIndex > #pattern or os.clock() >= difference) then
								continue
							end
							break
						end

						hook.EmoteBuildIndex = rightIndex

						if rightIndex <= #pattern then
							runService.Heartbeat:Wait()
						end
					end

					if hook.EmoteBuildToken == isReady then
						hook.EmoteBuilding = false
						hook.EmotesReady = rightIndex > #pattern
					end
				end)
		end

		hook.PatchInventory = function(line)
			if hook.Originals.CreateInventory then
				return
			end
			local sound = hook.EmoteSource

			if not sound or not sound.Parent then
				sound = newCharacter:FindFirstChild("EmoteWheel")
				sound = sound and sound:FindFirstChild("List")
				sound = sound and sound:FindFirstChild("Content")
				hook.EmoteSource = sound
			end

			if not sound then
				return
			end

			if not hook.EmoteContainer then
				local lines = {}

				for _, particle in sound:GetDescendants() do
					if particle:IsA("GuiButton") then
						lines[particle] = particle.Archivable
						particle.Archivable = false
					end
				end

				hook.EmoteContainer = sound:Clone()

				for vertex, particle in pairs(lines) do
					vertex.Archivable = particle
				end

				hook.EmoteContainer.Name = "UnlockAllContent"
				hook.EmoteContainer.Visible = false
				hook.EmoteInventory = table.clone(line)
				local radians = hook.InventoryShared.CreateFakeReplion()
				radians.Data = { Inventory = { Emote = hook.EmoteInventory } }
				hook.EmoteCaller = { Replion = radians }
			end

			hook.Originals.EmoteFindItemsWithKey = hook.InventoryClient.FindItemsWithKey
			hook.Originals.EmoteGetItem = hook.InventoryClient.GetItem

			hook.InventoryClient.FindItemsWithKey = function(object, descendant, radius, ...)
				local cell = descendant == "Emote" and hook.EmoteItemKeys[radius]
				if hook.Status == "active" and cell then
					return { cell }
				end
				local score = hook.Originals.EmoteFindItemsWithKey
				local radians = table.pack(...)
				radians.n = 4 + radians.n - 1
				table.move(radians, 1, radians.n, 4, radians)
				radians[1] = object
				radians[2] = descendant
				radians[3] = radius
				return score(table.unpack(radians, 1, radians.n))
			end

			hook.InventoryClient.GetItem = function(object, descendant, radius, ...)
				local targetName = descendant == "Emote" and tostring(radius):match("^UnlockAll:Emote:(.+)$")
				if hook.Status == "active" and targetName and hook.EmoteItems[targetName] then
					return hook.EmoteItems[targetName]
				end
				local sortedArray = hook.ConsoleItems and hook.ConsoleItems[descendant]
				local result26 = sortedArray and tostring(radius):match("^UnlockAll:" .. descendant .. ":(.+)$")
				if hook.Status == "active" and result26 and sortedArray[result26] then
					return sortedArray[result26].Item
				end
				local str = hook.Originals.EmoteGetItem
				local radians = table.pack(...)
				radians.n = 4 + radians.n - 1
				table.move(radians, 1, radians.n, 4, radians)
				radians[1] = object
				radians[2] = descendant
				radians[3] = radius
				return str(table.unpack(radians, 1, radians.n))
			end

			local bar = hook.EmoteContainer
			bar.Position = sound.Position
			bar.Size = sound.Size
			bar.Active = sound.Active
			bar.Visible = false
			hook.EmoteContainer.Parent = sound.Parent
			hook.EmoteOriginal = sound
			hook.OriginalPosition = sound.Position
			hook.OriginalSize = sound.Size
			hook.OriginalActive = sound.Active
			hook.OriginalVisible = sound.Visible
			sound.Visible = false
			sound.Position = UDim2.fromOffset(-100000, -15)
			sound.Active = false
			hook.Originals.CreateInventory = hook.InventoryController.CreateInventory

			hook.InventoryController.CreateInventory = function(object, descendant)
				if hook.Status == "active" and descendant.InventoryType == "Emote" then
					local radians = table.clone(descendant)
					radians.Caller = hook.EmoteCaller
					radians.Container = hook.EmoteContainer
					radians.WatchOnChange = false

					radians.FindItemsWithKey = function(radius, zCoordinate)
						local cell = radius == "Emote" and hook.EmoteItemKeys[zCoordinate]
						if cell then
							return hook.EmoteInventory[cell] and { cell } or {}
						end
						return hook.InventoryShared:FindItemsWithKey(hook.EmoteCaller, radius, zCoordinate)
					end

					local result30 = radians.OnSlotCreated

					radians.OnSlotCreated = function(radius, zCoordinate, alpha, color, initialCapacity)
						if result30 then
							result30(radius, zCoordinate, alpha, color, initialCapacity)
						end

						if zCoordinate and zCoordinate.Name and color and initialCapacity then
							if hook.EmoteItems[zCoordinate.Name] and getconnections then
								for _, existingPlayer in getconnections(color.Activated) do
									existingPlayer:Disconnect()
								end
							end

							initialCapacity:Add(color.Activated:Connect(function()
									local targetPlayerName = zCoordinate.Name
									task.defer(hook.ApplyEmote, hook.GetEmoteSlot(), targetPlayerName)
								end))
						end
					end

					hook.EmoteView = hook.Originals.CreateInventory(object, radians)
					return hook.EmoteView
				end

				return hook.Originals.CreateInventory(object, descendant)
			end

			if not hook.EmoteView then
				local lines = {}
				local result43 = sound.Parent:FindFirstChild("SearchFrame")

				if result43 and getconnections then
					lines[result43.Search.MouseButton1Click] = {}
					lines[result43.SearchBG.SearchInput.FocusLost] = {}

					for vertex, particle in pairs(lines) do
						for _, existingPlayer in getconnections(vertex) do
							if existingPlayer.Function then
								particle[existingPlayer.Function] = true
							end
						end
					end
				end

				local playerData = hook.InventoryController.CreateSortOptions

				hook.InventoryController.CreateSortOptions = function()
				end

				hook.EmoteWheel:populateEmoteList()
				hook.InventoryController.CreateSortOptions = playerData

				for vertex, particle in pairs(lines) do
					for _, existingPlayer in getconnections(vertex) do
						if next(particle) and existingPlayer.Function and not particle[existingPlayer.Function] then
							existingPlayer:Disconnect()
						end
					end
				end
			end

			bar.Visible = true
			hook.FillEmoteInventory()
		end

		hook.RestoreInventory = function(line)
			hook.EmoteBuildToken = hook.EmoteBuildToken + 1
			hook.EmoteBuilding = false
			hook.EmoteBuildIndex = 1
			hook.EmotesReady = false
			onInputEnded("CreateInventory", hook.InventoryController)
			onInputEnded("EmoteFindItemsWithKey", hook.InventoryClient, "FindItemsWithKey")
			onInputEnded("EmoteGetItem", hook.InventoryClient, "GetItem")

			if hook.EmoteContainer then
				hook.EmoteContainer.Visible = false
				hook.EmoteContainer.Parent = nil
			end

			if hook.EmoteOriginal then
				hook.EmoteOriginal.Position = hook.OriginalPosition
				hook.EmoteOriginal.Size = hook.OriginalSize
				hook.EmoteOriginal.Active = hook.OriginalActive
				hook.EmoteOriginal.Visible = hook.OriginalVisible
				hook.EmoteOriginal = nil
				hook.OriginalPosition = nil
				hook.OriginalSize = nil
				hook.OriginalActive = nil
				hook.OriginalVisible = nil
			end

			if not line then
				return
			end
			cleanupResources(hook.ButtonConnections)
			table.clear(hook.ButtonConnections)

			if hook.EmoteView then
				hook.EmoteView.Destroy()
				hook.EmoteView = nil
			end

			if hook.EmoteCaller then
				hook.EmoteCaller.Replion:Destroy()
				hook.EmoteCaller = nil
			end

			if hook.EmoteContainer then
				hook.EmoteContainer:Destroy()
				hook.EmoteContainer = nil
			end

			hook.EmoteSource = nil
			hook.EmoteInventory = nil
			hook.EmoteCatalogLoaded = false
		end

		hook.BindEmoteCard = function(line)
			local radians = hook.ButtonConnections[line]

			if radians then
				cleanupResources(radians)
				hook.ButtonConnections[line] = nil
			end

			if hook.Status ~= "active" or not line.Parent then
				return
			end
			local timerLabel = line:FindFirstChild("ItemName")
			local angleRadians = timerLabel and hook.EmoteDisplays[timerLabel.Text]
			if not angleRadians then
				return
			end

			if not hook.EmoteItems[angleRadians] then
				return
			end
			local rope = line:FindFirstChild("Favorite")
			local cash = line:FindFirstChild("Delete")

			if getconnections and rope then
				for _, propertyName in getconnections(rope.Activated) do
					propertyName:Disconnect()
				end
			end

			if getconnections and cash then
				for _, propertyName in getconnections(cash.Activated) do
					propertyName:Disconnect()
				end
			end

			local lines = {}

			if rope then
				table.insert(lines, rope.Activated:Connect(function()
						hook.ToggleFavorite("Emote", angleRadians)
					end))
			end

			if cash then
				table.insert(lines, cash.Activated:Connect(function()
						hook.PromptDelete("Emote", angleRadians)
					end))
			end

			hook.ButtonConnections[line] = lines
		end

		hook.HookEmoteCard = function(line)
			if hook.Status ~= "active" or not line:IsA("GuiButton") or not line:FindFirstChild("ItemName") or hook.CardConnections[line] then
				return
			end

			hook.CardConnections[line] = line.ItemName:GetPropertyChangedSignal("Text"):Connect(function()
					task.defer(hook.BindEmoteCard, line)
				end)

			task.defer(hook.BindEmoteCard, line)
		end

		hook.HookEmotes = function()
			local radians = hook.GetEmoteScroller()
			if not radians then
				return
			end

			for _, existingPlayer in radians:GetDescendants() do
				hook.HookEmoteCard(existingPlayer)
			end

			hook.Add(radians.DescendantAdded:Connect(function(hit)
					task.defer(hook.HookEmoteCard, hit)
				end))
		end

		hook.SaveDefaults = function()
			local model = localPlayer.Character
			hook.Defaults.Sword = model and model:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword") or "Base Sword"
			hook.Defaults.Explosion = localPlayer:GetAttribute("CurrentlyEquippedExplosion") or model and model:GetAttribute("CurrentlyEquippedExplosion") or "Explosion Normal"
			hook.Defaults.Accessory = localPlayer:GetAttribute("ShowSwordAccessory") == true
		end

		hook.ApplySaved = function()
			local query = tostring(flags.UnlockAllSword or "")
			local radians = hook.AwakenBase[query] or query
			local concatenated = tostring(flags.UnlockAllExplosion or "")
			local partsIterator = flags.UnlockAllEmotes or {}
			local right = flags.UnlockAllAccessory == true
			hook.Accessory = right
			localPlayer:SetAttribute("ShowSwordAccessory", right)
			local cell = radians ~= ""
			local active

			if cell then
				active = not hook.ShopActive or hook.ShopItems.Sword[radians]
			else
				active = cell
			end

			if active then
				hook.SelectSword(radians, false)
			end

			if concatenated ~= "" and (not hook.ShopActive or hook.ShopItems.Explosion[concatenated]) then
				hook.SelectExplosion(concatenated, false)
			end

			table.clear(hook.EquippedEmotes)
			local lines = {}

			for vertex in pairs(partsIterator) do
				local userId = tonumber(vertex)

				if userId then
					table.insert(lines, userId)
				end
			end

			table.sort(lines)
			local sourceTable = {}
			local sourceIterator = hook.InventoryClient:GetInventory().Emote or {}

			for _, existingPlayer in pairs(sourceIterator) do
				sourceTable[existingPlayer.Name] = true
			end

			for _, existingPlayer in pairs(lines) do
				local track = partsIterator[tostring(existingPlayer)] or partsIterator[existingPlayer]

				if track and (sourceTable[track] or hook.EmoteItems[track]) then
					hook.EquippedEmotes[existingPlayer] = track
				end
			end

			table.clear(hook.Finishers)
			local pointGenerator = flags.UnlockAllFinishers or {}

			for vertex, existingPlayer in pairs(pointGenerator) do
				if existingPlayer == true then
					hook.Finishers[vertex] = true

					if hook.DataReplion then
						local players = { "Finishers", "Equipped", vertex }
						hook.DefaultFinishers[vertex] = hook.DataReplion:Get(players) == true
						hook.DataReplion:_set(players, true)
					end
				end
			end

			hook.UpdateEmoteWheel()
		end

		hook.RestoreEmotes = function()
			table.clear(hook.EquippedEmotes)
			hook.StopEmote()
			hook.EmoteWheel:UpdateHolderEmotes()
			hook.EmoteWheel:UpdateMenuContentEmotes()
		end

		hook.Start = function()
			if hook.Status then
				return
			end
			hook.Status = "starting"
			local HOOK_ORIGINAL_RUN = hook.Run + 1
			hook.Run = HOOK_ORIGINAL_RUN
			hook.Load()

			while flags.UnlockAllEnabled and hook.Run == HOOK_ORIGINAL_RUN and not hook.ShopReady() do
				runService.Heartbeat:Wait()
			end

			if not flags.UnlockAllEnabled or hook.Run ~= HOOK_ORIGINAL_RUN then
				if hook.Run == HOOK_ORIGINAL_RUN then
					hook.Status = nil
				end

				return
			end

			hook.Status = "active"

			for _, particle in pairs(hook.Deleted) do
				table.clear(particle)
			end

			table.clear(hook.EquippedEmotes)
			table.clear(hook.SavedEquipped)
			table.clear(hook.Finishers)
			table.clear(hook.DefaultFinishers)
			hook.Accessory = false
			hook.Originals.EquippedSword = nil
			hook.Originals.EquippedExplosion = nil
			hook.LoadFavorites()
			hook.SaveDefaults()
			local radians = hook.LoadEmotes()
			if hook.Run ~= HOOK_ORIGINAL_RUN or hook.Status ~= "active" then
				return
			end
			hook.PatchInventory(radians)
			hook.HookEmotes()
			hook.PatchExplosion()
			hook.PatchEmotes()
			hook.PatchParrySuccess()
			hook.ApplySaved()
			hook.WatchSword(localPlayer.Character)
			local Players = game:GetService("CollectionService")
			hook.Add(Players:GetInstanceAddedSignal("EncryptedClone"):Connect(hook.WatchClone))

			hook.Add(Players:GetInstanceRemovedSignal("EncryptedClone"):Connect(function(line)
					hook.ClearClone(line, true)
				end))

			for _, existingPlayer in Players:GetTagged("EncryptedClone") do
				hook.WatchClone(existingPlayer)
			end

			hook.WatchEmotes(localPlayer.Character)

			hook.Add(localPlayer:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
					local player20 = hook.Sword

					if player20 and localPlayer:GetAttribute("CurrentlyEquippedSword") ~= player20 then
						task.defer(hook.ApplySword, player20)
					end
				end))

			hook.Add(localPlayer.CharacterAdded:Connect(function(playerInstance)
					local HookCall = hook.Run
					features.Animation.Reset()
					hook.WatchSword(playerInstance)
					hook.WatchEmotes(playerInstance)

					task.delay(1, function()
						if hook.Status == "active" and hook.Run == HookCall and localPlayer.Character == playerInstance and hook.Sword then
							hook.ApplySword(hook.Sword)

							if hook.Explosion then
								localPlayer:SetAttribute("CurrentlyEquippedExplosion", hook.Explosion)
								playerInstance:SetAttribute("CurrentlyEquippedExplosion", hook.Explosion)
							end
						end
					end)
				end))

			if not hook.ActivateShop() then
				return
			end
			hook.ApplyFavorites()
			hook.HookShop()
			hook.HookConsole()
		end

		hook.Stop = function(line)
			if line then
				for _, particle in pairs({ "Parry_All_Func", "Parry_Client_Func" }) do
					local angleRadians = hook.Originals[particle .. "Target"]

					if angleRadians then
						hookfunction(angleRadians, hook.Originals[particle])
						hook.Originals[particle .. "Target"] = nil
						hook.Originals[particle] = nil
					end
				end
			end

			local result53 = hook.Status
			hook.Status = nil
			hook.Run = hook.Run + 1

			if result53 ~= "active" then
				if line then
					hook.RestoreInventory(true)
				end

				return
			end

			onInputEnded("UpdateMultiDelete", hook.Shop, "_updateMultiDelete")
			onInputEnded("CanDelete", hook.Shop, "_canDelete")

			for _, particle in pairs(hook.Types) do
				onInputEnded("MarkDirty" .. particle, hook.Shop._inventoryPages[particle], "MarkDirty")
			end

			hook.CloseMultiDelete()
			cleanupResources(hook.Connections)
			table.clear(hook.Connections)
			cleanupResources(hook.CardConnections)
			table.clear(hook.CardConnections)
			hook.RestoreConsole()
			hook.DestroyOverlays()
			hook.RestoreInventory(line)
			hook.RestoreShop()
			hook.RestoreFavorites()
			localPlayer:SetAttribute("ShowSwordAccessory", hook.Defaults.Accessory == true)

			for vertex, particle in pairs(hook.DefaultFinishers) do
				if hook.DataReplion then
					hook.DataReplion:_set({ "Finishers", "Equipped", vertex }, particle == true)
				end
			end

			table.clear(hook.Finishers)
			table.clear(hook.DefaultFinishers)
			onInputEnded("PlayExplosion", hook.VFX)
			onInputEnded("EmotePlay", hook.EmoteController, "Play")
			onInputEnded("UpdateHolderEmotes", hook.EmoteWheel)
			onInputEnded("UpdateMenuContentEmotes", hook.EmoteWheel)
			hook.RestoreSword()

			if hook.Originals.SetSword and hook.BladeController then
				onInputEnded("SetSword", hook.BladeController)
			end

			hook.RestoreExplosion()
			hook.RestoreEmotes()
			hook.Sword = nil
			hook.Explosion = nil
		end

		hook.Toggle = function(player28)
			flags.UnlockAllEnabled = player28

			if player28 then
				task.defer(hook.Start)
			else
				hook.Stop()
			end
		end
	end
end

coroutineBody({ CustomStreakEnabled = false, CustomStreak = "" })
features.Streak = { Originals = {} }

features.Streak.Get = function()
	local userId = tonumber(tostring(flags.CustomStreak or ""):match("^%s*(.-)%s*$"))
	return userId and math.max(0, math.floor(userId))
end

features.Streak.Format = function(line)
	return (tostring(line):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
end

features.Streak.Set = function(line, object, descendant)
	if not features.Streak.Originals[line] then
		features.Streak.Originals[line] = { object, line[object] }
	end

	if line[object] ~= descendant then
		line[object] = descendant
	end
end

features.Streak.RestoreObject = function(line)
	local radians = features.Streak.Originals[line]
	if not radians then
		return
	end

	if line.Parent then
		line[radians[1]] = radians[2]
	end

	features.Streak.Originals[line] = nil
end

features.Streak.Restore = function()
	for vertex, particle in pairs(features.Streak.Originals) do
		if vertex.Parent then
			vertex[particle[1]] = particle[2]
		end
	end

	table.clear(features.Streak.Originals)
end

flyteBBState.StreakRestore = features.Streak.Restore

features.Streak.Refresh = function(line)
	local radians = features.Streak.Originals[line]

	if radians then
		radians[2] = line[radians[1]]
	end

	coroutineFunction("Streak Display")
	coroutineFunction("Streak Value")
	coroutineFunction("Streak Flame")
	features.Streak.Value = nil
	task.defer(features.Streak.ApplyDisplay)
end

features.Streak.Profile = function()
	local result38 = newCharacter:FindFirstChild("ProfileCard")
	local objects = result38 and result38:FindFirstChild("Customize") and result38.Customize:FindFirstChild("Profile")
	local result36 = objects and objects:FindFirstChild("PlayerProfile")
	result36 = result36 and result36:FindFirstChild("Details")
	objects = objects and objects:FindFirstChild("Achievements")
	return result36 and result36:FindFirstChild("Username"), objects and objects:FindFirstChild("Scrollingframe")
end

features.Streak.ApplyDisplay = function()
	if not flags.CustomStreakEnabled then
		return
	end
	local model = localPlayer.Character
	local guiClone = model and model:FindFirstChild("WinStreakDisplay", true)

	if not guiClone and model then
		local nearestPlayer = model:FindFirstChild("Head")
		local leaderstats = replicatedStorage:FindFirstChild("Assets")
		local template = leaderstats and leaderstats:FindFirstChild("UI")
		template = template and template:FindFirstChild("WinStreakDisplay")

		if nearestPlayer and template then
			guiClone = template:Clone()
			guiClone.Adornee = nearestPlayer
			features.Streak.Display = guiClone
			guiClone.Parent = model
		end
	end

	local result22 = guiClone and guiClone:FindFirstChild("Main")
	local yString = result22 and result22:FindFirstChild("Value")
	local Lighting = result22 and result22:FindFirstChild("Icon")
	if not yString or not Lighting then
		return
	end
	local radians = features.Streak.Get()
	if not radians then
		return
	end
	local query = "<b><stroke color='rgb(0, 0, 0)' thickness='2'>" .. features.Streak.Format(radians) .. "</stroke></b>"
	local concatenated = radians >= 10 and "rbxassetid://75598166115655" or "rbxassetid://89658127170771"
	features.Streak.Set(guiClone, "Enabled", true)
	features.Streak.Set(yString, "Text", query)
	features.Streak.Set(Lighting, "Image", concatenated)

	if features.Streak.Value ~= yString then
		coroutineFunction("Streak Display")
		coroutineFunction("Streak Value")
		coroutineFunction("Streak Flame")
		features.Streak.Value = yString

		flyteBBState.Connections["Streak Display"] = guiClone:GetPropertyChangedSignal("Enabled"):Connect(function()
				features.Streak.Refresh(guiClone)
			end)

		flyteBBState.Connections["Streak Value"] = yString:GetPropertyChangedSignal("Text"):Connect(function()
				features.Streak.Refresh(yString)
			end)

		flyteBBState.Connections["Streak Flame"] = Lighting:GetPropertyChangedSignal("Image"):Connect(function()
				features.Streak.Refresh(Lighting)
			end)
	end
end

features.Streak.ApplyProfile = function()
	if not flags.CustomStreakEnabled then
		return
	end
	local radians = features.Streak.Get()
	if not radians then
		return
	end
	local cell = radians > (tonumber(Data:Get("TotalStats.BestWinStreak")) or 0)
	local angleRadians = features.Streak.Format(radians)
	local objects = newCharacter:FindFirstChild("Profile")
	objects = objects and objects:FindFirstChild("BestWinStreak", true)
	objects = objects and objects:FindFirstChild("Value")

	if objects then
		if cell then
			features.Streak.Set(objects, "Text", angleRadians .. " Wins")
		else
			features.Streak.RestoreObject(objects)
		end
	end

	local track, vertexCount = features.Streak.Profile()
	if not track or track.Text ~= "@" .. localPlayer.Name or not vertexCount then
		return
	end

	for _, info in vertexCount:GetChildren() do
		local inputBox = info:FindFirstChild("Title")
		local item = info:FindFirstChild("Description")

		if inputBox and item and inputBox.Text == "Best Win Streak" then
			if cell then
				features.Streak.Set(item, "Text", angleRadians)
			else
				features.Streak.RestoreObject(item)
			end

			break
		end
	end
end

features.Streak.BindCharacter = function(line)
	coroutineFunction("Streak Character UI")

	flyteBBState.Connections["Streak Character UI"] = line.DescendantAdded:Connect(function(hit)
			if hit.Name == "WinStreakDisplay" or hit.Name == "Value" or hit.Name == "Icon" then
				if hit.Name == "WinStreakDisplay" and features.Streak.Display and hit ~= features.Streak.Display then
					features.Streak.Display:Destroy()
					features.Streak.Display = nil
				end

				task.defer(features.Streak.ApplyDisplay)
			end
		end)

	features.Streak.ApplyDisplay()
end

features.Streak.Stop = function()
	for _, particle in pairs({
		"Streak Character",
		"Streak Character UI",
		"Streak Display",
		"Streak Value",
		"Streak Flame",
		"Streak Profile",
		"Streak Profile Items",
		"Streak Best",
	}) do
		coroutineFunction(particle)
	end

	features.Streak.Restore()
	local model = localPlayer.Character
	local splitHorizontally = features.Streak.Display and model

	if splitHorizontally then
		splitHorizontally = (tonumber(model:GetAttribute("Killstreak")) or 0) > 0
	end

	if features.Streak.Display then
		features.Streak.Display:Destroy()
		features.Streak.Display = nil
	end

	if splitHorizontally then
		firesignal(model:GetAttributeChangedSignal("Killstreak"))
	end

	features.Streak.Value = nil
end

features.Streak.Toggle = function(other)
	flags.CustomStreakEnabled = other
	features.Streak.Stop()
	if not other or not features.Streak.Get() then
		return
	end
	flyteBBState.Connections["Streak Character"] = localPlayer.CharacterAdded:Connect(features.Streak.BindCharacter)

	flyteBBState.Connections["Streak Best"] = Data:OnChange("TotalStats.BestWinStreak", function()
			task.defer(features.Streak.ApplyProfile)
		end)

	local radians, angleRadians = features.Streak.Profile()

	if radians then
		flyteBBState.Connections["Streak Profile"] = radians:GetPropertyChangedSignal("Text"):Connect(features.Streak.ApplyProfile)
	end

	if angleRadians then
		flyteBBState.Connections["Streak Profile Items"] = angleRadians.ChildAdded:Connect(function()
				task.defer(features.Streak.ApplyProfile)
			end)
	end

	if localPlayer.Character then
		features.Streak.BindCharacter(localPlayer.Character)
	end

	features.Streak.ApplyProfile()
end

coroutineBody({ ShowWins = false, ShowElims = false, ShowRAP = false })

features.Stats = {
	Connections = {},
	Originals = setmetatable({}, { __mode = "k" }),
	Writing = setmetatable({}, { __mode = "k" }),
	Info = {
	Wins = {
	Attribute = "PlayerWins",
	Config = "ShowWins",
	Leaderstat = "Wins",
	Profile = "Wins",
},
	Elims = {
	Attribute = "PlayerElims",
	Config = "ShowElims",
	Leaderstat = "Elims",
	Profile = "Kills",
},
	RAP = { Attribute = "TotalRAP", Config = "ShowRAP", Profile = "Rap" },
},
}

features.Stats.Connect = function(line, object)
	features.Stats.Connections[#features.Stats.Connections + 1] = line:Connect(object)
end

features.Stats.ConnectProfile = function(line, object)
	features.Stats.ProfileConnections = features.Stats.ProfileConnections or {}
	features.Stats.ProfileConnections[#features.Stats.ProfileConnections + 1] = line:Connect(object)
end

features.Stats.RestoreProfile = function()
	local neighborIterator = features.Stats.ProfileOriginal or {}

	for _, particle in pairs(neighborIterator) do
		if particle.Button.Parent then
			features.Stats.Writing[particle.Button] = true
			features.Stats.Writing[particle.Amount] = true
			particle.Button.Visible = particle.Visible
			particle.Amount.Text = particle.Text
			features.Stats.Writing[particle.Button] = nil
			features.Stats.Writing[particle.Amount] = nil
		end
	end
end

features.Stats.ClearProfile = function(line)
	local matchIterator = features.Stats.ProfileConnections or {}

	for _, particle in pairs(matchIterator) do
		particle:Disconnect()
	end

	table.clear(features.Stats.ProfileConnections or {})

	if line then
		features.Stats.RestoreProfile()
	end

	features.Stats.ProfileOriginal = nil
end

features.Stats.Stop = function()
	for _, particle in pairs(features.Stats.Connections) do
		particle:Disconnect()
	end

	table.clear(features.Stats.Connections)

	for vertex, particle in pairs(features.Stats.Originals) do
		if vertex.Parent then
			features.Stats.Writing[vertex] = true
			vertex.Value = particle
			features.Stats.Writing[vertex] = nil
		end
	end

	features.Stats.ClearProfile(true)
	table.clear(features.Stats.Originals)
end

features.Stats.SetValue = function(line, object, descendant)
	if features.Stats.Originals[descendant] ~= nil then
		return
	end
	features.Stats.Originals[descendant] = descendant.Value

	local function onInputEnded()
		local callbackFunction = line:GetAttribute(object.Attribute)

		if flags[object.Config] and features.Stats.Originals[descendant] == 0 and type(callbackFunction) == "number" and callbackFunction > 0 and descendant.Value ~= callbackFunction then
			features.Stats.Writing[descendant] = true
			descendant.Value = callbackFunction
			features.Stats.Writing[descendant] = nil
		end
	end

	features.Stats.Connect(descendant:GetPropertyChangedSignal("Value"), function()
			if features.Stats.Writing[descendant] then
				return
			end
			features.Stats.Originals[descendant] = descendant.Value
			onInputEnded()
		end)

	features.Stats.Connect(line:GetAttributeChangedSignal(object.Attribute), onInputEnded)
	onInputEnded()
end

features.Stats.BindPlayer = function(line)
	local function onInputEnded(object)
		for _, particle in pairs(features.Stats.Info) do
			if particle.Leaderstat and flags[particle.Config] then
				local angleRadians = object:FindFirstChild(particle.Leaderstat)

				if angleRadians and angleRadians:IsA("ValueBase") then
					features.Stats.SetValue(line, particle, angleRadians)
				end
			end
		end

		features.Stats.Connect(object.ChildAdded, function(descendant)
				for _, particle in pairs(features.Stats.Info) do
					if particle.Leaderstat and flags[particle.Config] and descendant.Name == particle.Leaderstat and descendant:IsA("ValueBase") then
						features.Stats.SetValue(line, particle, descendant)
						break
					end
				end
			end)
	end

	local result19 = line:FindFirstChild("leaderstats")

	if result19 then
		onInputEnded(result19)
	else
		features.Stats.Connect(line.ChildAdded, function(object)
				if object.Name == "leaderstats" then
					onInputEnded(object)
				end
			end)
	end
end

features.Stats.FormatRAP = function(line)
	local difference = 1
	local query

	if line >= 1e12 then
		query = "T"
		difference = 1e12
	elseif line >= 1e9 then
		query = "B"
		difference = 1e9
	elseif line >= 1000000 then
		query = "M"
		difference = 1000000
	else
		query = ""

		if line >= 1000 then
			query = "K"
			difference = 1000
		end
	end

	if difference == 1 then
		return tostring(math.floor(line))
	end
	local openError = math.floor(line / difference * 10) / 10
	return (openError % 1 == 0 and tostring(math.floor(openError)) or tostring(openError)) .. query .. (line > 1000 and "+" or "")
end

features.Stats.GetProfile = function()
	local result38 = newCharacter:FindFirstChild("ProfileCard")
	local playerCharacter = result38 and result38:FindFirstChild("Customize")
	local objects = playerCharacter and playerCharacter:FindFirstChild("Profile")
	objects = objects and objects:FindFirstChild("PlayerProfile")
	local elevatorModel = objects and objects:FindFirstChild("Details")
	return result38, elevatorModel and elevatorModel:FindFirstChild("Username"), objects and objects:FindFirstChild("Stats")
end

features.Stats.ShowProfile = function(line, object, descendant, radius)
	local callbackFunction = radius:GetAttribute(object.Attribute)
	if not flags[object.Config] or not descendant or descendant.Visible or type(callbackFunction) ~= "number" then
		return
	end
	features.Stats.Writing[descendant.Button] = true
	features.Stats.Writing[descendant.Amount] = true
	descendant.Button.Visible = true
	descendant.Amount.Text = line == "RAP" and features.Stats.FormatRAP(callbackFunction) or features.Streak.Format(callbackFunction)
	features.Stats.Writing[descendant.Button] = nil
	features.Stats.Writing[descendant.Amount] = nil
end

features.Stats.ApplyProfile = function()
	local radians, targetName, angleRadians = features.Stats.GetProfile()
	targetName = targetName and targetName.Text:match("^@(.+)$")
	local track = targetName and playersService:FindFirstChild(targetName)
	if not radians or not radians.Enabled or not angleRadians or not track then
		return
	end

	if not features.Stats.ProfileOriginal then
		features.Stats.ProfileOriginal = {}

		for vertex, modelName in pairs(features.Stats.Info) do
			local steering = angleRadians:FindFirstChild(modelName.Profile)
			local xCoordinate = steering and steering:FindFirstChild("Amount")

			if steering and xCoordinate then
				features.Stats.ProfileOriginal[vertex] = { Button = steering, Amount = xCoordinate, Visible = steering.Visible, Text = xCoordinate.Text }
				local major = features.Stats.ProfileOriginal[vertex]

				features.Stats.ConnectProfile(steering:GetPropertyChangedSignal("Visible"), function()
						if not features.Stats.Writing[steering] then
							major.Visible = steering.Visible
							features.Stats.ShowProfile(vertex, modelName, major, track)
						end
					end)

				features.Stats.ConnectProfile(xCoordinate:GetPropertyChangedSignal("Text"), function()
						if not features.Stats.Writing[xCoordinate] then
							major.Text = xCoordinate.Text
							features.Stats.ShowProfile(vertex, modelName, major, track)
						end
					end)
			end
		end
	end

	features.Stats.RestoreProfile()

	for vertex, modelName in pairs(features.Stats.Info) do
		features.Stats.ShowProfile(vertex, modelName, features.Stats.ProfileOriginal[vertex], track)
	end
end

features.Stats.QueueProfile = function()
	if features.Stats.ProfileQueued then
		return
	end
	features.Stats.ProfileQueued = true
	features.Stats.ClearProfile(false)

	task.defer(function()
			features.Stats.ProfileQueued = nil
			features.Stats.ApplyProfile()
		end)
end

features.Stats.Toggle = function()
	features.Stats.Stop()
	if not flags.ShowWins and not flags.ShowElims and not flags.ShowRAP then
		return
	end

	if flags.ShowWins or flags.ShowElims then
		features.Stats.Connect(playersService.PlayerAdded, features.Stats.BindPlayer)

		for _, particle in playersService:GetPlayers() do
			features.Stats.BindPlayer(particle)
		end
	end

	local radians, angleRadians = features.Stats.GetProfile()

	if radians then
		features.Stats.Connect(radians:GetPropertyChangedSignal("Enabled"), function()
				if radians.Enabled then
					features.Stats.QueueProfile()
				end
			end)
	end

	if angleRadians then
		local onTouch = features.Stats.QueueProfile
		features.Stats.Connect(angleRadians:GetPropertyChangedSignal("Text"), onTouch)
	end

	features.Stats.QueueProfile()
end

features.Stats.Queue = function()
	if features.Stats.Queued then
		return
	end
	features.Stats.Queued = true

	task.defer(function()
			features.Stats.Queued = nil
			features.Stats.Toggle()
		end)
end

coroutineBody({
	AutoPlayEnabled = false,
	AutoVoteMap = false,
	HitFreeze = false,
	SpamJump = false,
	AutoPlaySmoothness = 50,
	AutoPlayAggressiveness = 45,
	AntiAFK = false,
	AutoRejoinExecute = false,
	ScriptKey = "",
	AutoPlayMode = "Play Edge",
})

features.AFK = {}

features.AFK.Toggle = function(line)
	flyteBBState.AFKConnections = flyteBBState.AFKConnections or {}

	for _, particle in pairs(flyteBBState.AFKConnections) do
		if not particle.Enabled then
			particle:Enable()
		end
	end

	table.clear(flyteBBState.AFKConnections)
	if not line then
		return
	end

	for _, particle in getconnections(localPlayer.Idled) do
		if particle.Enabled then
			particle:Disable()
			table.insert(flyteBBState.AFKConnections, particle)
		end
	end
end

features.Script = {}

features.Script.Queue = function()
	local targetName = tostring(scriptKey or flags.ScriptKey or ""):match("^%s*(.-)%s*$")
	if targetName == "" then
		return false
	end
	queueonteleport(("script_key=%q;\nloadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/e30ade937c4c9b8ddbb03e976696e380.lua\"))()"):format(targetName))
	return true
end

features.Script.Toggle = function(line)
	coroutineFunction("Auto Rejoin")
	flyteBBState.ScriptRejoining = nil
	if not line then
		return
	end

	flyteBBState.Connections["Auto Rejoin"] = coreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay").ChildAdded:Connect(function(guiObject)
			if guiObject.Name ~= "ErrorPrompt" or flyteBBState.ScriptRejoining or guiService.MenuIsOpen then
				return
			end
			local LocalPlayer = guiObject:WaitForChild("MessageArea", 1)
			if not LocalPlayer or not LocalPlayer:WaitForChild("ErrorFrame", 1) or not features.Script.Queue() then
				return
			end
			flyteBBState.ScriptRejoining = true
			teleportService:Teleport(game.PlaceId, localPlayer)
		end)
end

features.AutoPlay = { Direction = 1, Voting = {} }

features.AutoPlay.Jump = function(line, object)
	if not line then
		features.AutoPlay.DoubleJumped = nil
		features.AutoPlay.JumpAt = nil
		return
	end

	local model = localPlayer.Character
	model = model and model:FindFirstChildOfClass("Humanoid")
	if not model then
		return
	end

	if model.FloorMaterial ~= Enum.Material.Air then
		model:ChangeState(Enum.HumanoidStateType.Jumping)
		features.AutoPlay.DoubleJumped = false
		features.AutoPlay.JumpAt = os.clock()
	else
		local cell = object and not features.AutoPlay.DoubleJumped

		if cell then
			cell = os.clock() - (features.AutoPlay.JumpAt or 0) >= 0.12
		end

		if cell then
			features.AutoPlay.DoubleJumped = true
			firesignal(userInputService.JumpRequest)
		end
	end
end

features.AutoPlay.VoteMode = function(line)
	local RoundStateEnum = features.AutoPlay.Voting
	local bloomEffect = localPlayer.PlayerGui:FindFirstChild("voter")

	if not bloomEffect or not bloomEffect.Enabled then
		RoundStateEnum.Mode = nil
		RoundStateEnum.ModeAt = nil
		return
	end

	if RoundStateEnum.Mode ~= bloomEffect then
		RoundStateEnum.Mode = bloomEffect
		RoundStateEnum.ModeAt = line + 0.25 + math.random() * 0.5
	end

	if not RoundStateEnum.ModeAt or line < RoundStateEnum.ModeAt then
		return
	end
	RoundStateEnum.ModeAt = nil
	local toolInstance = bloomEffect:FindFirstChild("Frame")
	toolInstance = toolInstance and toolInstance:FindFirstChild("1")
	local radians = toolInstance and toolInstance:FindFirstChildWhichIsA("TextLabel", true)

	if toolInstance and radians and radians.Text == "Classic" then
		firesignal(toolInstance.Activated)
	end
end

features.AutoPlay.VoteMap = function(line, object, descendant, radius)
	local RoundStateEnum = features.AutoPlay.Voting
	local character3 = radius:FindFirstChild("GUI")
	local character5 = character3 and character3:FindFirstChild("SurfaceGui")
	local square = character5 and character5:FindFirstChild("Top")

	if not (square and square.Visible) then
		if RoundStateEnum.Map then
			RoundStateEnum.Done = true
		end

		RoundStateEnum.Map = nil
		RoundStateEnum.MapAt = nil
		RoundStateEnum.Pad = nil
		if RoundStateEnum.Done then
			object:MoveTo(descendant.Position)
			return
		end

		if not RoundStateEnum.Waiting then
			RoundStateEnum.Waiting = true
			RoundStateEnum.Moves = math.random(1, 3)
			RoundStateEnum.Move = 0
			RoundStateEnum.MoveAt = line + 0.4 + math.random()
		end

		if not RoundStateEnum.Target and RoundStateEnum.Move < RoundStateEnum.Moves and line >= RoundStateEnum.MoveAt then
			local result33 = radius:FindFirstChild("Part")
			result33 = result33 and result33.Position - descendant.Position or Vector3.zero
			local relativePosition = Vector3.new(result33.X, 0, result33.Z)

			if relativePosition.Magnitude > 0.1 then
				local directionToTarget = relativePosition.Unit
				local horizontalVelocity = Vector3.new(-directionToTarget.Z, 0, directionToTarget.X)
				RoundStateEnum.Move = RoundStateEnum.Move + 1
				local currentPosition = descendant.Position
				local cell = RoundStateEnum.Move == 1

				if cell then
					cell = 3 + math.random() * 24
				end

				local difference = currentPosition + directionToTarget * (cell or math.random() * 1.5)
				RoundStateEnum.Target = difference + horizontalVelocity * (math.random() - 0.5) * (RoundStateEnum.Move == 1 and 5 or 3)
			end
		end

		if not RoundStateEnum.Target then
			object:MoveTo(descendant.Position)
			return
		end

		if (RoundStateEnum.Target - descendant.Position).Magnitude <= 1.5 then
			RoundStateEnum.Target = nil
			RoundStateEnum.MoveAt = line + 0.5 + math.random() * 1.5
			object:MoveTo(descendant.Position)
		else
			object:MoveTo(RoundStateEnum.Target)
		end

		return
	end

	RoundStateEnum.Done = nil
	RoundStateEnum.Waiting = nil
	RoundStateEnum.Moves = nil
	RoundStateEnum.Move = nil
	RoundStateEnum.Target = nil

	if RoundStateEnum.Map ~= square or not RoundStateEnum.Pad or not RoundStateEnum.Pad.Parent then
		RoundStateEnum.Map = square
		RoundStateEnum.MapAt = line + 0.8 + math.random() * 1.7
		local gui = radius:FindFirstChild("Colliders")
		local lines = {}
		local queue = gui and gui:GetChildren() or {}

		for _, particle in pairs(queue) do
			if particle:IsA("BasePart") then
				lines[#lines + 1] = particle
			end
		end

		RoundStateEnum.Pad = #lines > 0 and lines[math.random(#lines)]
	end

	local cell = not RoundStateEnum.Pad

	if not cell then
		cell = line < (RoundStateEnum.MapAt or 0)
	end

	if cell then
		object:MoveTo(descendant.Position)
		return
	end
	local currentPosition = RoundStateEnum.Pad.Position
	object:MoveTo(Vector3.new(currentPosition.X, descendant.Position.Y, currentPosition.Z))
end

features.AutoPlay.Stop = function()
	coroutineFunction("Auto Play")
	features.AutoPlay.Jump(false)
	table.clear(features.AutoPlay.Voting)
	features.AutoPlay.Floor = nil
	features.AutoPlay.Spawn = nil
	features.AutoPlay.Map = nil
	features.AutoPlay.Mode = nil
	features.AutoPlay.Middle = nil
	features.AutoPlay.MixAt = nil
	features.AutoPlay.UpdateAt = nil
	features.AutoPlay.PressureAt = nil
	features.AutoPlay.PressureUntil = nil
	features.AutoPlay.Home = nil
	features.AutoPlay.Anchor = nil
	features.AutoPlay.AnchorAt = nil
	features.AutoPlay.EndAt = nil
	features.AutoPlay.Raycast = nil
	features.AutoPlay.LobbyTarget = nil
	features.AutoPlay.LobbySettling = nil
	features.AutoPlay.LobbyJumpAt = nil
	features.AutoPlay.LobbyJumpUntil = nil
	features.AutoPlay.LobbyDouble = nil
	features.AutoPlay.LobbyDecided = nil
	features.AutoPlay.LobbyIdle = nil
	features.AutoPlay.InMatch = nil
	features.AutoPlay.MatchHadOpponent = nil
	features.AutoPlay.WonLast = nil
	features.AutoPlay.ClashUntil = nil
	features.AutoPlay.ChaseUntil = nil
	features.AutoPlay.ClashDistance = nil
	features.AutoPlay.ClashMoveAt = nil
	features.AutoPlay.ClashTarget = nil
	features.AutoPlay.Opponent = nil
	features.AutoPlay.OpponentUntil = nil
	features.AutoPlay.LastMove = nil
	features.AutoPlay.Character = nil
end

features.AutoPlay.Step = function()
	smallest = smallest.Parent and smallest or workspace:FindFirstChild("Alive")
	local model = localPlayer.Character
	local targetHumanoid = model and model:FindFirstChildOfClass("Humanoid")
	local explosion = model and model:FindFirstChild("HumanoidRootPart")
	if not targetHumanoid or not explosion or targetHumanoid.Health <= 0 then
		features.AutoPlay.Jump(false)
		return
	end
	local osClock = os.clock()
	if osClock < (features.AutoPlay.UpdateAt or 0) then
		return
	end
	features.AutoPlay.UpdateAt = osClock + 0.066666666666666666

	if flags.AutoVoteMap then
		features.AutoPlay.VoteMode(osClock)
	end

	if model.Parent == workspace:FindFirstChild("Dead") then
		features.AutoPlay.InMatch = false
		local result49 = workspace:FindFirstChild("Spawn")
		result49 = result49 and result49:FindFirstChild("NewPlayerCounter")
		if flags.AutoVoteMap and result49 then
			features.AutoPlay.VoteMap(osClock, targetHumanoid, explosion, result49)
			return
		end

		if not features.AutoPlay.LobbyDecided then
			features.AutoPlay.LobbyDecided = true
			features.AutoPlay.LobbyIdle = features.AutoPlay.WonLast and math.random(3) ~= 1 or not features.AutoPlay.WonLast and math.random(5) == 1
		end

		if features.AutoPlay.LobbyIdle then
			features.AutoPlay.Jump(false)
			targetHumanoid:MoveTo(explosion.Position)
			return
		end

		result49 = result49 and result49:FindFirstChild("Part")
		if not result49 then
			features.AutoPlay.Jump(false)
			return
		end

		if features.AutoPlay.Character ~= model or not features.AutoPlay.LobbyTarget then
			local mouse = workspace:FindFirstChild("LobbySpawnPlate")
			mouse = mouse and mouse:FindFirstChild("DO_NOT_DELETE")
			mouse = mouse and mouse.Position - result49.Position or explosion.Position - result49.Position
			local relativePosition = Vector3.new(mouse.X, 0, mouse.Z)
			local directionToTarget = relativePosition.Magnitude > 0.001 and relativePosition.Unit or Vector3.zAxis
			local horizontalVelocity = Vector3.new(-directionToTarget.Z, 0, directionToTarget.X)
			features.AutoPlay.Character = model
			features.AutoPlay.LobbySettling = false
			features.AutoPlay.LobbyJumpAt = osClock + math.random()
			features.AutoPlay.LobbyJumpUntil = nil
			local currentLength = result49.Size.X
			features.AutoPlay.LobbyTarget = result49.Position + directionToTarget * (8 + math.random() * 10) + horizontalVelocity * (math.random() - 0.5) * currentLength * 0.65
		end

		local halfSize = features.AutoPlay.LobbyTarget
		local relativePosition = Vector3.new(halfSize.X, explosion.Position.Y, halfSize.Z)

		if (Vector3.new(relativePosition.X, 0, relativePosition.Z) - Vector3.new(explosion.Position.X, 0, explosion.Position.Z)).Magnitude > 2.5 then
			if (features.AutoPlay.LobbyJumpAt or 0) <= osClock then
				features.AutoPlay.LobbyJumpAt = osClock + 1.2 + math.random() * 2
				features.AutoPlay.LobbyJumpUntil = osClock + 0.45
				features.AutoPlay.LobbyDouble = math.random() < 0.5
			end

			features.AutoPlay.Jump(osClock < (features.AutoPlay.LobbyJumpUntil or 0), features.AutoPlay.LobbyDouble)
			targetHumanoid:MoveTo(relativePosition)
		elseif not features.AutoPlay.LobbySettling then
			local horizontalVelocity = Vector3.new(explosion.Position.X - result49.Position.X, 0, explosion.Position.Z - result49.Position.Z)
			local directionToTarget = horizontalVelocity.Magnitude > 0.1 and horizontalVelocity.Unit or Vector3.zAxis
			local moveVector = Vector3.new(-directionToTarget.Z, 0, directionToTarget.X)
			features.AutoPlay.LobbySettling = true
			local dummy = features.AutoPlay
			local currentPosition = explosion.Position
			dummy.LobbyTarget = currentPosition + moveVector * (math.random(0, 1) == 0 and -1 or 1) * (3 + math.random() * 4) + directionToTarget * (math.random() - 0.5) * 3
		else
			features.AutoPlay.Jump(false)
			targetHumanoid:MoveTo(explosion.Position)
		end

		return
	end

	if not smallest or model.Parent ~= smallest then
		features.AutoPlay.Jump(false)
		return
	end

	if not features.AutoPlay.InMatch then
		features.AutoPlay.InMatch = true
		table.clear(features.AutoPlay.Voting)
		features.AutoPlay.MatchHadOpponent = false
		features.AutoPlay.WonLast = false
		features.AutoPlay.LobbyDecided = false
		features.AutoPlay.LobbyIdle = nil
		features.AutoPlay.ClashUntil = nil
		features.AutoPlay.ChaseUntil = nil
		features.AutoPlay.ClashDistance = nil
		features.AutoPlay.ClashMoveAt = nil
		features.AutoPlay.ClashTarget = nil
		features.AutoPlay.Opponent = nil
		features.AutoPlay.OpponentUntil = nil
		features.AutoPlay.LastMove = nil
		features.AutoPlay.Home = nil
		features.AutoPlay.Anchor = nil
		features.AutoPlay.AnchorAt = nil
		features.AutoPlay.EndAt = nil
	end

	local radians, angleRadians, track = index8(model, explosion.Position)
	local player8 = features.AutoPlay.Opponent
	local checkpointFolder = player8 and player8.Parent

	if checkpointFolder then
		checkpointFolder = osClock < (features.AutoPlay.OpponentUntil or 0)
	end

	if checkpointFolder then
		local exponent = (explosion.Position - player8.Position).Magnitude

		if exponent <= radians + 2.5 then
			angleRadians = player8
			radians = exponent
		end
	end

	if angleRadians ~= features.AutoPlay.Opponent then
		features.AutoPlay.Opponent = angleRadians
		features.AutoPlay.OpponentUntil = osClock + 0.65
	end

	if track > 1 then
		features.AutoPlay.MatchHadOpponent = true
	elseif features.AutoPlay.MatchHadOpponent then
		features.AutoPlay.WonLast = true
	end

	if track <= 1 then
		features.AutoPlay.EndAt = features.AutoPlay.EndAt or osClock + 0.5 + math.random() * 0.7

		if features.AutoPlay.EndAt <= osClock then
			features.AutoPlay.Jump(false)
			targetHumanoid:MoveTo(explosion.Position)
			return
		end
	else
		features.AutoPlay.EndAt = nil
	end

	features.AutoPlay.Character = model
	features.AutoPlay.LobbyTarget = nil
	features.AutoPlay.LobbySettling = nil
	features.AutoPlay.Jump(flags.SpamJump, true)
	local result24 = workspace:FindFirstChild("Map")

	if features.AutoPlay.Map ~= result24 or features.AutoPlay.Mode ~= flags.AutoPlayMode or not features.AutoPlay.Floor or not features.AutoPlay.Floor.Parent then
		features.AutoPlay.Map = result24
		features.AutoPlay.Mode = flags.AutoPlayMode
		features.AutoPlay.Floor = result24 and result24:FindFirstChild("FLOOR", true)
		features.AutoPlay.Spawn = flags.AutoPlayMode ~= "Play Edge" and result24 and result24:FindFirstChild("BALLSPAWN", true)
		features.AutoPlay.Raycast = nil
		features.AutoPlay.Home = nil
		features.AutoPlay.Anchor = nil

		if features.AutoPlay.Floor then
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Include
			raycastParams.FilterDescendantsInstances = { features.AutoPlay.Floor:FindFirstAncestorOfClass("Model") or result24 }
			raycastParams.RespectCanCollide = true
			raycastParams.IgnoreWater = true
			features.AutoPlay.Raycast = raycastParams
		end
	end

	local titleLabel = features.AutoPlay.Floor
	if not titleLabel or not titleLabel:IsA("BasePart") then
		return
	end
	local difference = previous() / 1000
	local result27 = features.AutoPlay.Middle
	local IsFiveM = flags.AutoPlayMode == "Play Middle"

	if flags.AutoPlayMode == "Mix" then
		local cell = features.AutoPlay.Middle == nil

		if not cell then
			cell = osClock >= (features.AutoPlay.MixAt or 0)
		end

		if cell then
			local openError = track <= 2 and 0.8

			if not openError then
				openError = math.clamp(0.55 - difference * 2 - math.max(track - 24, 0) * 0.04 + ((not angleRadians or radians > 28) and 0.12 or 0), 0.35, 0.75)
			end

			features.AutoPlay.Middle = math.random() < openError
			features.AutoPlay.MixAt = osClock + 4 + math.random() * 4
		end

		IsFiveM = features.AutoPlay.Middle
	end

	if result27 ~= IsFiveM then
		features.AutoPlay.Middle = IsFiveM
		features.AutoPlay.Home = nil
		features.AutoPlay.Anchor = nil
	end

	local result49 = features.AutoPlay.Spawn
	result49 = IsFiveM and result49 and result49:IsA("BasePart") and result49 or titleLabel
	local relativePosition = Vector3.new(result49.Position.X, explosion.Position.Y, result49.Position.Z)
	local horizontalVelocity = Vector3.new(explosion.Position.X - relativePosition.X, 0, explosion.Position.Z - relativePosition.Z)
	local directionToTarget = horizontalVelocity.Magnitude > 1 and horizontalVelocity.Unit or Vector3.xAxis
	local openError = IsFiveM and math.max(result49.Size.X, result49.Size.Z) or 0
	local step = math.min(titleLabel.Size.X, titleLabel.Size.Z) * (IsFiveM and 0.13 or 0.31)
	local mathMax = IsFiveM and math.max(openError * 0.75, targetHumanoid.WalkSpeed * 0.45) or 0
	local t = features.AutoPlay.Direction
	local leftChild = Vector3.new(-directionToTarget.Z, 0, directionToTarget.X) * t
	local endPosition = relativePosition + directionToTarget * step
	local maximumValue = math.clamp((flags.AutoPlayAggressiveness or nil) / 100, 0.01, 1)
	local offsetZ = (18 + targetHumanoid.WalkSpeed * difference * (8 + math.min(math.max(track - 2, 0), 4))) * (1 + (0.45 - maximumValue) * (maximumValue > 0.45 and 1.18 or 0.5))
	local cell = angleRadians and radians < offsetZ

	if not features.AutoPlay.Home then
		local dummy = features.AutoPlay
		local newDenominator = targetHumanoid.WalkSpeed * 0.5
		dummy.Home = math.abs(horizontalVelocity.Magnitude - step) > newDenominator and endPosition or explosion.Position
		features.AutoPlay.Anchor = features.AutoPlay.Home
		features.AutoPlay.AnchorAt = osClock
	end

	local moveVector

	if cell then
		local newDenominator = explosion.Position - angleRadians.Position
		local newDirection = Vector3.new(newDenominator.X, 0, newDenominator.Z)
		moveVector = nil

		if newDirection.Magnitude > 0.1 then
			local deltaZ = features.AutoPlay.Direction
			local directionVector = (newDirection.Unit + Vector3.new(-newDirection.Unit.Z, 0, newDirection.Unit.X) * deltaZ * 0.55).Unit
			local center = math.min(offsetZ - radians + targetHumanoid.WalkSpeed * 0.25, targetHumanoid.WalkSpeed)
			local screenPosition = explosion.Position + directionVector * center
			local edgeVector = Vector3.new(screenPosition.X - relativePosition.X, 0, screenPosition.Z - relativePosition.Z)
			local clampedX = step + targetHumanoid.WalkSpeed * 0.45

			if clampedX < edgeVector.Magnitude then
				local max = edgeVector.Unit * clampedX
				screenPosition = Vector3.new(relativePosition.X, explosion.Position.Y, relativePosition.Z) + max
			elseif IsFiveM and edgeVector.Magnitude < mathMax then
				screenPosition = relativePosition + (edgeVector.Magnitude > 0.001 and edgeVector.Unit or directionToTarget) * mathMax
			end

			local max = screenPosition - explosion.Position
			moveVector = Vector3.new(max.X, 0, max.Z)

			if moveVector.Magnitude < 1 then
				moveVector = (leftChild - directionToTarget * 0.4).Unit * center
				screenPosition = explosion.Position + moveVector
			end

			features.AutoPlay.Home = screenPosition
			features.AutoPlay.Anchor = features.AutoPlay.Home
		end
	else
		local direction = features.AutoPlay.Anchor or explosion.Position
		local active = (Vector3.new(direction.X, 0, direction.Z) - Vector3.new(explosion.Position.X, 0, explosion.Position.Z)).Magnitude < 1.5

		if not active then
			active = osClock >= (features.AutoPlay.AnchorAt or 0)
		end

		moveVector = nil

		if active then
			if math.random() < 0.4 then
				features.AutoPlay.Direction = -features.AutoPlay.Direction
				leftChild = -leftChild
			end

			features.AutoPlay.AnchorAt = osClock + 0.6 + math.random() * 0.8
			local originalWalkSpeed = targetHumanoid.WalkSpeed
			features.AutoPlay.Anchor = features.AutoPlay.Home + leftChild * targetHumanoid.WalkSpeed * (0.2 + math.random() * 0.25) + directionToTarget * (math.random() - 0.5) * originalWalkSpeed * 0.25
			moveVector = nil
		end
	end

	local newDenominator = (features.AutoPlay.Anchor or features.AutoPlay.Home) - explosion.Position
	local newDirection = Vector3.new(newDenominator.X, 0, newDenominator.Z)
	local directionVector = newDirection.Magnitude > 2 and newDirection.Unit or Vector3.zero
	local active = osClock >= (flyteBBState.ParryActiveUntil or 0)

	if active then
		active = osClock < (flyteBBState.ParryCooldownUntil or 0)
	end

	local aimDirection = nil
	local axis = nil

	if not continuation(model) then
		aimDirection = nil
		axis = nil

		for _, modelName in features.Ball.GetAllBalls() do
			local steering = index7(modelName)
			local exponent = index4(modelName).Magnitude
			local targetPlayerName = localPlayer.Name
			local isArray = compareFunction(modelName) == targetPlayerName
			local isFiveM = flags.HitFreeze and isArray

			if isFiveM then
				isFiveM = modelName:GetAttribute("Frozen") == true
			end

			if isArray and active then
				local center = explosion.Position - unexecuteFunction(modelName)
				local edgeVector = Vector3.new(center.X, 0, center.Z)

				if edgeVector.Magnitude > 0.1 then
					aimDirection = edgeVector.Unit
					axis = nil
					break
				else
					aimDirection = nil
					axis = nil
				end
			else
				if isArray then
					isArray = (steering.TargetChanges or 0) <= 1 and exponent <= targetHumanoid.WalkSpeed or isFiveM
				end

				if isArray then
					local currentPosition = explosion.Position
					local center = unexecuteFunction(modelName) - currentPosition
					local edgeVector = Vector3.new(center.X, 0, center.Z)

					if not (edgeVector.Magnitude > 0.1) then
						aimDirection = nil
						axis = nil
					else
						axis = edgeVector.Unit
						aimDirection = nil
						break
					end
				else
					aimDirection = nil
					axis = nil
				end
			end
		end
	end

	if angleRadians and not aimDirection then
		local center = math.clamp((offsetZ - radians) / offsetZ, 0, 1)

		if center > 0 and moveVector and moveVector.Magnitude > 0.001 then
			directionVector = directionVector:Lerp(moveVector.Unit, center)
		end

		local clampedX = math.clamp(math.clamp(1 - difference / 0.001, 0, 1) * (0.6 + maximumValue * 0.4) + maximumValue * 0.25 + math.max(maximumValue - 0.45, 0) * 0.5, 0, 1)

		if (features.AutoPlay.PressureAt or 0) <= osClock then
			local max = math.clamp(maximumValue / 0.45, 0.65, 2)
			local endIndex = math.min
			local tMinimum = track == 2 and 0.3 + clampedX * 0.35 or clampedX * 0.45
			local vertexCount = 1
			local steering = endIndex(tMinimum * math.clamp(max, 0.55, 1.8), vertexCount)
			features.AutoPlay.PressureAt = osClock + ((track == 2 and 2.5 or 3) + math.random() * 3) / max
			features.AutoPlay.PressureUntil = math.random() < steering and osClock + (0.65 + math.random() * 0.55) * math.clamp(max, 0.75, 1.5) or 0
		end

		local isArray = center == 0

		if isArray then
			isArray = osClock < (features.AutoPlay.PressureUntil or 0)
		end

		if isArray and radians < offsetZ * (2 + maximumValue) then
			local max = angleRadians.Position - explosion.Position
			directionVector = directionVector:Lerp(Vector3.new(max.X, 0, max.Z).Unit, 0.35 + clampedX * 0.2)
		end

		if track == 2 then
			local parts = flags.AutoSpamEnabled

			if parts then
				parts = osClock - (flyteBBState.AutoSpamAt or 0) < 0.2
			end

			if not parts then
				parts = flags.ManualSpamEnabled

				if parts then
					parts = osClock - (flyteBBState.ManualSpamAt or 0) < 0.2
				end
			end

			if parts then
				local bestLabel = osClock >= (features.AutoPlay.ClashUntil or 0)
				features.AutoPlay.ClashUntil = osClock + 0.4

				if not bestLabel and features.AutoPlay.ClashDistance and radians > features.AutoPlay.ClashDistance + 0.3 then
					features.AutoPlay.ChaseUntil = osClock + 0.9
				end

				if bestLabel then
					features.AutoPlay.ClashMoveAt = nil
					features.AutoPlay.ClashTarget = nil
				end

				features.AutoPlay.ClashDistance = radians
			end

			if osClock < (features.AutoPlay.ClashUntil or 0) then
				local max = angleRadians.Position - explosion.Position
				local edgeVector = Vector3.new(max.X, 0, max.Z)
				local bestLabel = edgeVector.Magnitude > 0.1

				if bestLabel then
					bestLabel = radians > 9

					if not bestLabel then
						bestLabel = osClock < (features.AutoPlay.ChaseUntil or 0)
					end
				end

				if bestLabel then
					local currentPosition = angleRadians.Position
					IsFiveM = IsFiveM and horizontalVelocity.Magnitude < mathMax + 12 and edgeVector.Unit:Dot(directionToTarget) < 0

					if IsFiveM then
						currentPosition = explosion.Position + (leftChild + directionToTarget * 0.25).Unit * 14
					end

					targetHumanoid:MoveTo(currentPosition)
				else
					if (features.AutoPlay.ClashMoveAt or 0) <= osClock then
						features.AutoPlay.ClashMoveAt = osClock + 0.35 + math.random() * 0.5
						features.AutoPlay.ClashTarget = explosion.Position + (edgeVector.Magnitude > 0.1 and Vector3.new(-edgeVector.Z, 0, edgeVector.X).Unit or Vector3.zero) * (math.random(3) == 1 and math.random(-2, 2) or 0)
					end

					targetHumanoid:MoveTo(features.AutoPlay.ClashTarget or explosion.Position)
				end

				return
			end
		end
	end

	if aimDirection then
		directionVector = aimDirection
	elseif axis then
		directionVector = (axis * 0.9 + leftChild * 0.1).Unit
	end

	if directionVector.Magnitude > 0.1 then
		local surfaceNormal = directionVector.Unit

		if IsFiveM and horizontalVelocity.Magnitude < mathMax + 12 and surfaceNormal:Dot(directionToTarget) < 0 then
			surfaceNormal = (leftChild + directionToTarget * 0.25).Unit
		end

		local raycastResult = features.AutoPlay.Raycast and workspace:Raycast(explosion.Position, surfaceNormal * 12, features.AutoPlay.Raycast)

		if raycastResult then
			local edgeVector = Vector3.new(raycastResult.Normal.X, 0, raycastResult.Normal.Z)

			if 0.001 < edgeVector.Magnitude then
				local finalDirection = edgeVector.Unit
				local range = Vector3.new(-finalDirection.Z, 0, finalDirection.X)

				if range:Dot(surfaceNormal) < 0 then
					range = -range
				end

				surfaceNormal = (range + finalDirection * 0.35).Unit
			end
		end

		if not axis and not aimDirection and features.AutoPlay.LastMove and features.AutoPlay.LastMove:Dot(surfaceNormal) > -0.6 then
			local deepCopyTable = math.clamp
			local currentQuantity = flags.AutoPlaySmoothness or 50
			local vertexCount = 1
			local center = 0.82 - (deepCopyTable(currentQuantity, 1, 100) - vertexCount) / 99 * 0.48

			if cell then
				center = math.min(center + 0.18, 0.9)
			end

			local steering = features.AutoPlay.LastMove:Lerp(surfaceNormal, center)

			if 0.001 < steering.Magnitude then
				surfaceNormal = steering.Unit
			end
		end

		features.AutoPlay.LastMove = surfaceNormal
		targetHumanoid:MoveTo(explosion.Position + surfaceNormal * 12)
	else
		features.AutoPlay.LastMove = nil
		targetHumanoid:MoveTo(explosion.Position)
	end
end

features.AutoPlay.Toggle = function(inputString)
	flags.AutoPlayEnabled = inputString
	features.AutoPlay.Stop()

	if inputString then
		flyteBBState.Connections["Auto Play"] = runService.PreSimulation:Connect(features.AutoPlay.Step)
	end
end

coroutineBody({ AvatarEnabled = false, AvatarUser = "", KHEnabled = false })

features.LoadRewards = function()
	local instance5 = { Items = {} }
	features.Rewards = instance5
	local tween = replicatedStorage.Controllers
	local ffi = require(replicatedStorage.Shared.InfiniteBattlepass.InfiniteBattlepassData)
	local hullIterator = nil
	local position = nil
	local visited = nil
	local lines = {}
	local sourceTable = {}

	local function onInputEnded(...)
		local result35 = localPlayer.PlayerGui

		for _, particle in pairs({ ... }) do
			result35 = result35:FindFirstChild(particle)
			if not result35 then
				return
			end
		end

		return result35
	end

	instance5.Notify = function(line, object)
		local radians = uiElements and uiElements.toggles[line]

		if flyteBBState.Loaded and flags[line] and radians and radians.notify and type(object) == "string" and object ~= "" then
			window:Notify({ Title = "Got " .. object })
		end
	end

	local function handlePlayerRemoving(line, object, descendant, radius, zCoordinate)
		coroutineBody({ [line] = false })
		instance5.Items[#instance5.Items + 1] = { ID = line, Name = object, Run = descendant, Interval = radius or 5, Next = 0, Notify = zCoordinate }
	end

	local function onTouched(line, object, descendant, radius, zCoordinate, alpha)
		if not object or not object.Visible or lines[object] then
			return false
		end
		local radians = getconnections
		local query = alpha or "Activated"

		for _, existingPlayer in radians(object[query]) do
			if existingPlayer.Enabled and existingPlayer.Function and getfenv(existingPlayer.Function).script == descendant then
				lines[object] = { ID = line, Check = radius, Names = zCoordinate }
				existingPlayer:Fire()
				return true
			end
		end

		return false
	end

	handlePlayerRemoving("Claim_Daily_Rewards", "Auto Claim Daily", function()
			local value = Data:Get("CurrentDailyLoginType")
			local radians = Data:Get({ "DailyLoginData", value })
			local cell = (value == "D30" or value == "Longterm") and radians and type(radians.NextClaim) == "number"

			if cell then
				local accumulator = radians.NextClaim
				cell = workspace:GetServerTimeNow() >= accumulator
			end

			if cell then
				local head = onInputEnded("DailyLogin_" .. value .. "_Rewards")

				if head then
					local active = value == "D30" and head.Page.Rewards:FindFirstChild("Day" .. radians.DaysClaimedStreak + 1, true)

					if active then
						head = active
					else
						head = value == "Longterm" and head.Frame.Claim
					end
				end

				local accumulator = radians.NextClaim

				onTouched("Claim_Daily_Rewards", head, tween.UI.DailyLoginController, function()
					return Data:Get({ "DailyLoginData", value, "NextClaim" }) ~= accumulator
				end)
			end

			local character = ffi.isEnabled() and onInputEnded("BattlepassDailyLogin", "Background", "Frame", "ScrollingFrame")

			if character then
				for _, existingPlayer in character:GetChildren() do
					if existingPlayer:GetAttribute("State") == "Claimable" then
						local userId = tonumber(existingPlayer.Day.Text:match("%d+"))

						if userId then
							onTouched("Claim_Daily_Rewards", existingPlayer.Claim, localPlayer.PlayerScripts.Client.UIBinders.BattlepassDailyLogin, function()
								return table.find(Data:Get("NewDailyLoginAwardList") or {}, userId) ~= nil
							end)
						end

						break
					end
				end
			end

			local parent = Data:Get("WelcomeBackEvent")
			local active

			if parent then
				active = workspace:GetServerTimeNow() < (parent.EventEndTime or 0)
			else
				active = parent
			end

			active = active and onInputEnded("NewWelcomeBack", "Frame", "Views", "Login", "Days")

			if active then
				for _, existingPlayer in active:GetChildren() do
					local head = existingPlayer:FindFirstChild("Claim")
					local leftIndex = head and existingPlayer.LayoutOrder

					if head and head.Visible and leftIndex <= parent.DailyLoginStreak and not parent.ClaimedDailyRewards[leftIndex] then
						onTouched("Claim_Daily_Rewards", head, tween.WelcomeBackController.EventControllers.Login, function()
							local vehicle = Data:Get("WelcomeBackEvent")
							return vehicle and vehicle.ClaimedDailyRewards[leftIndex] == true
						end, nil, "MouseButton1Click")

						break
					end
				end
			end
		end)

	handlePlayerRemoving("Claim_Playtime_Rewards", "Auto Claim Playtime", function()
			hullIterator = hullIterator or require(replicatedStorage.Common.PlaytimeRewardsInfo).Rewards
			position = position or require(replicatedStorage.Shared.Battlepass.BattlepassPlaytimeRewardsData)
			visited = visited or require(replicatedStorage.Shared.Quests)
			local humanoid = Data:Get("PlaytimeRewardsData")

			if humanoid then
				for vertex, particle in pairs(hullIterator) do
					local cell = not humanoid.ClaimedRewards[tostring(vertex)]

					if cell then
						local difference = humanoid.TimerStart + particle.Duration
						cell = workspace:GetServerTimeNow() >= difference
					end

					if cell then
						local result37 = tween.UI.PlaytimeRewardsController

						onTouched("Claim_Playtime_Rewards", onInputEnded("PlaytimeRewards", "PlaytimeRewards", "Page", "List", "RewardsList", tostring(vertex), "ClaimButton"), result37, function()
							return Data:Get({ "PlaytimeRewardsData", "ClaimedRewards", tostring(vertex) }) == true
						end)

						break
					end
				end
			end

			if ffi.isEnabled() then
				local message = Data:Get("ClaimedPlaytimeRewards") or {}

				for vertex, particle in pairs(position) do
					if particle.Seconds <= (Data:Get("SecondsPlayedToday") or 0) and not table.find(message, vertex) then
						local success = onInputEnded("BattlepassPlaytimeRewards", "PlaytimeRewards", "MainFrame", "Grid", tostring(vertex))

						onTouched("Claim_Playtime_Rewards", success and success.Claim.Claim, tween.Battlepass.BattlepassPlaytimeRewardsController, function()
							return table.find(Data:Get("ClaimedPlaytimeRewards") or {}, vertex) ~= nil
						end)

						break
					end
				end
			end

			local count = Data:Get("CurrentQuests") or {}

			for _, particle in pairs(count) do
				local cell = visited[particle]

				if cell then
					cell = (Data:Get({ "QuestStats", cell.stat }) or 0) >= cell.goal
				end

				if cell then
					cell = not table.find(Data:Get("QuestsAwarded") or {}, particle)
				end

				if cell then
					local result39 = tween.UI.QuestsController

					onTouched("Claim_Playtime_Rewards", onInputEnded("NewDailyQuests", "Holder", "Quests", particle, "Intermediate"), result39, function()
						return table.find(Data:Get("QuestsAwarded") or {}, particle) ~= nil
					end)
				end
			end
		end)

	if ffi.isEnabled() then
		handlePlayerRemoving("Claim_Battlepass_Rewards", "Auto Claim Battlepass", function()
				if not ffi.isEnabled() then
					return
				end
				local player = onInputEnded("Battlepass", "Main", "Background", "Left", "ClaimAll")
				if not player or not player.Visible or lines[player] then
					return
				end
				local status = Data:Get("InfiniteBattlepass")
				local players = {}
				local success5 = ffi.SeasonData.Rewards.getTierFromXP
				local index60 = status.Quests.XP or 0

				for k = 1, success5(index60) do
					local radians = ffi.SeasonData.Rewards.getReward(k, localPlayer)

					for _, existingPlayer in pairs({ "Free", "Premium" }) do
						if radians and radians[existingPlayer:lower()] and (existingPlayer == "Free" or status.Premium == true) and not status.Claimed[existingPlayer][tostring(k)] then
							players[#players + 1] = { existingPlayer, tostring(k) }
						end
					end
				end

				if #players == 0 then
					return
				end

				onTouched("Claim_Battlepass_Rewards", player, tween.Battlepass.BattlepassTierController, function()
					local RunService = Data:Get("InfiniteBattlepass.Claimed")

					for _, particle in pairs(players) do
						if not RunService[particle[1]][particle[2]] then
							return false
						end
					end

					return true
				end)
			end)
	end

	handlePlayerRemoving("Auto_Wheel_Spins", "Auto Spin Wheel", function()
			local index47 = Data:Get("rolls") or 0
			if index47 <= 0 then
				return
			end
			local humanoidRootPart = onInputEnded("Wheel", "Default")
			if not humanoidRootPart or humanoidRootPart:GetAttribute("Spinning") then
				return
			end
			local instance9 = humanoidRootPart.WheelMenu

			onTouched("Auto_Wheel_Spins", instance9.Button.SpinButton, humanoidRootPart.SpinWheelClient, function()
				return (Data:Get("rolls") or 0) < index47 and not humanoidRootPart:GetAttribute("Spinning")
			end, function()
				return instance9.Win.Text:match("^You won (.-)!$")
			end)
		end, 12, true)

	if ffi.isEnabled() then
		local cell = require(replicatedStorage.Shared.BattlepassUIType) == "Window"

		local function heartbeatUpdate(player17, line)
			if not ffi.isEnabled() or Data:Get("InfiniteBattlepass.UseSteps") then
				return
			end

			if os.clock() < (instance5.SpinUntil or 0) then
				return
			end
			local difference = Data:Get("InfGachaRounds" .. ffi.Season) or 0

			if line then
				local active = difference > 0 or ffi.SeasonData.Currency.Name ~= "Gold"

				if not active then
					active = Data:Get("CanPurchaseInfGachaRounds" .. ffi.Season .. "DailyExtra") ~= true
				end

				if not active then
					active = (Data:Get("InfiniteBattlepass.Currency") or 0) < 400
				end

				if active then
					return
				end
			elseif difference <= 0 then
				return
			end

			local node = cell and onInputEnded("BattlepassSpinGacha", "Main") or onInputEnded("Battlepass", "Main", "Background", "Views", "SpinGacha")
			local radians = instance5
			local angleRadians = instance5
			local track = 15
			local index52 = os.clock() + track
			radians.SpinID = player17
			angleRadians.SpinUntil = index52

			if not onTouched(player17, node and node.Background.Spin.Spin, tween.Battlepass.BattlepassSpinGachaController, function()
					local active = line and Data:Get("CanPurchaseInfGachaRounds" .. ffi.Season .. "DailyExtra") ~= true

					if not active then
						active = not line

						if active then
							active = (Data:Get("InfGachaRounds" .. ffi.Season) or 0) < difference
						end
					end

					return active
				end) then
				local vertexCount = instance5
				instance5.SpinID = nil
				vertexCount.SpinUntil = nil
			end
		end

		handlePlayerRemoving("Auto_Battlepass_Spins", "Auto Battlepass", function()
				heartbeatUpdate("Auto_Battlepass_Spins", false)
			end, 12, true)

		handlePlayerRemoving("Auto_Gold_Spin", "Auto Kraken Spin", function()
				heartbeatUpdate("Auto_Gold_Spin", true)
			end, 14, true)
	end

	instance5.Step = function()
		for vertex, particle in pairs(lines) do
			if particle.Check() then
				lines[vertex] = nil
				instance5.Notify(particle.ID, type(particle.Names) == "function" and particle.Names() or particle.Names)
			elseif not vertex.Parent then
				lines[vertex] = nil
			end
		end

		for _, particle in pairs(instance5.Items) do
			local cell = flags[particle.ID]

			if cell then
				local index41 = particle.Next
				cell = os.clock() >= index41
			end

			if cell then
				local index27 = particle.Interval
				particle.Next = os.clock() + index27

				if not pcall(particle.Run) then
					particle.Next = os.clock() + 30
				end
			end
		end
	end

	instance5.Toggle = function()
		if not flyteBBState.Loaded then
			return
		end
		local cell = false

		for _, particle in pairs(instance5.Items) do
			if flags[particle.ID] then
				cell = true
				break
			end
		end

		if not cell then
			coroutineFunction("Rewards")
			return
		end

		if flyteBBState.Connections.Rewards then
			return
		end
		local result41 = {}
		flyteBBState.Connections.Rewards = result41

		result41.Results = replicatedStorage.Remote.RemoteEvent.OnClientEvent:Connect(function(line, object, descendant)
				local canUseCoyote = instance5.SpinID

				if canUseCoyote then
					local index52 = instance5.SpinUntil
					canUseCoyote = os.clock() <= index52
				end

				if canUseCoyote and type(descendant) == "table" then
					if line == "GachaSpinStartBottom" then
						local radians = sourceTable
						local result6 = {}
						local result50 = instance5.SpinID
						local moduleName = descendant.DisplayName or descendant.ItemName
						result6[1] = result50
						result6[2] = moduleName
						radians.GachaSpinEndBottom = result6
					elseif line == "GachaSpinStartTop" then
						local radians = sourceTable
						local result7 = {}
						local result50 = instance5.SpinID
						local moduleName = descendant.DisplayName or descendant.ItemName
						result7[1] = result50
						result7[2] = moduleName
						radians.GachaSpinEndTop = result7
					end
				end

				local radians = sourceTable[line]

				if radians then
					sourceTable[line] = nil
					instance5.Notify(radians[1], radians[2])
				end
			end)

		result41.Loop = task.spawn(function()
				while flyteBBState.Loaded and flyteBBState.Connections.Rewards == result41 do
					instance5.Step()
					task.wait(1)
				end
			end)
	end
end

features.LoadRewards()

features.LoadAvatar = function()
	local emitter = replicatedStorage:FindFirstChild("flyteavatarcache1")

	if emitter then
		emitter:Destroy()
	end

	local dummyPart = Instance.new("Folder")
	dummyPart.Name = "flyteavatarcache1"
	dummyPart.Parent = replicatedStorage
	local player2 = Instance.new("Folder")
	player2.Name = "Original"
	player2.Parent = dummyPart
	accessoryManager = { Sources = {}, UserIDs = {}, SourceFolder = dummyPart, Stash = player2, Clones = {}, BindRun = 0 }
	local radians = nil
	local angleRadians = nil
	local track = 0
	local vertexCount = nil
	local steering = nil

	accessoryManager.BindImage = function(line, object)
		if not accessoryManager.Images or not line or not object or accessoryManager.Images[line] then
			return
		end
		local lines = { Original = line.Image, Username = object }
		accessoryManager.Images[line] = lines

		lines.Update = function()
			local currentImage = line.Image

			if currentImage ~= lines.Applied then
				lines.Original = currentImage
			end

			if object.Text ~= "@" .. localPlayer.Name or lines.Original:match("^rbxthumb://type=AvatarHeadShot&id=(%d+)&") ~= tostring(localPlayer.UserId) then
				lines.Applied = nil
				return
			end
			lines.Applied = lines.Original:gsub("&id=%d+&", "&id=" .. radians .. "&", 1)

			if currentImage ~= lines.Applied then
				line.Image = lines.Applied
			end
		end

		lines.ImageChanged = line:GetPropertyChangedSignal("Image"):Connect(lines.Update)
		lines.UserChanged = object:GetPropertyChangedSignal("Text"):Connect(lines.Update)

		lines.Destroying = line.Destroying:Connect(function()
				cleanupResources(lines)

				if accessoryManager.Images then
					accessoryManager.Images[line] = nil
				end
			end)

		lines.Update()
	end

	accessoryManager.UpdateImages = function()
		if accessoryManager.Images then
			for _, weld in pairs(accessoryManager.Images) do
				weld.Update()
			end

			return
		end

		accessoryManager.Images = {}

		local function onInputEnded(line)
			local checkpointFolder = line and line.Parent
			if not checkpointFolder then
				return
			end

			if line.Name == "AvatarImage" and checkpointFolder.Name == "PlayerHeader" then
				accessoryManager.BindImage(line, checkpointFolder:FindFirstChild("PlayerName", true))
			elseif line.Name == "PlayerName" then
				local player10 = line:FindFirstAncestor("PlayerHeader")

				if player10 then
					accessoryManager.BindImage(player10:FindFirstChild("AvatarImage"), line)
				end
			elseif line.Name == "Player" and checkpointFolder.Name == "PlayerProfile" then
				local elevatorModel = checkpointFolder:FindFirstChild("Details")
				accessoryManager.BindImage(line, elevatorModel and elevatorModel:FindFirstChild("Username"))
			elseif line.Name == "Username" and checkpointFolder.Name == "Details" and checkpointFolder.Parent.Name == "PlayerProfile" then
				accessoryManager.BindImage(checkpointFolder.Parent:FindFirstChild("Player"), line)
			end

			if type(n24) ~= "number" or n24 >= 4731 then
				return
			end

			while true do
			end
		end

		local result12 = accessoryManager.Images

		local function handlePlayerRemoving(hit)
			if hit.Name == "AvatarImage" or hit.Name == "PlayerName" or hit.Name == "Player" or hit.Name == "Username" then
				task.defer(function()
						if accessoryManager.Images == result12 then
							pcall(onInputEnded, hit)
						end
					end)
			end
		end

		local lines = { newCharacter.DescendantAdded:Connect(handlePlayerRemoving) }
		flyteBBState.Connections["Avatar Images"] = lines

		pcall(function()
				lines[#lines + 1] = coreGui.DescendantAdded:Connect(handlePlayerRemoving)
				local player10 = coreGui:FindFirstChild("PlayerHeader", true)

				if player10 then
					onInputEnded(player10:FindFirstChild("AvatarImage"))
				end
			end)

		local result38 = newCharacter:FindFirstChild("ProfileCard")
		result38 = result38 and result38:FindFirstChild("PlayerProfile", true)

		if result38 then
			onInputEnded(result38:FindFirstChild("Player"))
		end
	end

	accessoryManager.RestoreImages = function()
		coroutineFunction("Avatar Images")
		local result12 = accessoryManager.Images
		accessoryManager.Images = nil
		local lines = result12 or {}

		for vertex, weld in pairs(lines) do
			cleanupResources(weld)

			pcall(function()
					if weld.Applied and vertex.Image == weld.Applied and weld.Username.Text == "@" .. localPlayer.Name then
						vertex.Image = weld.Original
					end
				end)
		end
	end

	accessoryManager.IsBodyAppearance = function(line)
		return line:IsA("Shirt") or line:IsA("Pants") or line:IsA("ShirtGraphic") or line:IsA("BodyColors") or line:IsA("CharacterMesh") or line:IsA("Accoutrement")
	end

	accessoryManager.IsHeadAppearance = function(line)
		return line:IsA("Decal") or line:IsA("SpecialMesh")
	end

	accessoryManager.GetInput = function()
		return string.match(tostring(flags.AvatarUser or ""), "^%s*(.-)%s*$")
	end

	accessoryManager.SearchCurrent = function(line, object)
		local cell = flags.AvatarEnabled and line == track

		if cell then
			cell = object == accessoryManager.GetInput():lower()
		end

		return cell
	end

	accessoryManager.IsAppearanceReady = function(line)
		return line and (line:GetAttribute("AppearanceLoaded") == true or line == localPlayer.Character and localPlayer:HasAppearanceLoaded())
	end

	accessoryManager.GetUserID = function(line)
		local major = string.match(tostring(line or ""), "^%s*(.-)%s*$")
		if major == "" then
			return
		end
		local query = major:lower()
		local byte = accessoryManager.UserIDs[query]
		if byte then
			return byte
		end
		local userId = tonumber(major)

		if userId then
			if userId ~= userId or userId <= 0 or userId == math.huge or userId % 1 ~= 0 then
				return
			end
		else
			for _, playerObject in playersService:GetPlayers() do
				if playerObject.Name:lower() == query or playerObject.DisplayName:lower() == query then
					userId = playerObject.UserId
					break
				end
			end

			userId = userId or playersService:GetUserIdFromNameAsync(major)
		end

		if userId then
			accessoryManager.UserIDs[query] = userId
		end

		return userId
	end

	accessoryManager.GetSource = function(line)
		local major = accessoryManager.Sources[line]
		if major and major.Parent == dummyPart then
			return major
		end
		local decoded, loadError = pcall(playersService.GetHumanoidDescriptionFromUserIdAsync, playersService, line)
		if not decoded or not loadError then
			return
		end
		local parsed, joint = pcall(playersService.CreateHumanoidModelFromDescriptionAsync, playersService, loadError, Enum.HumanoidRigType.R6)
		loadError:Destroy()
		if not parsed or not joint then
			return
		end

		if not dummyPart.Parent then
			joint:Destroy()
			return
		end

		for _, partTemplate in joint:GetDescendants() do
			if partTemplate:IsA("LuaSourceContainer") then
				partTemplate:Destroy()
			end
		end

		joint.Name = tostring(line)
		joint.Parent = dummyPart
		accessoryManager.Sources[line] = joint
		return joint
	end

	accessoryManager.AddAccessory = function(line, object)
		local checkpointFolder = line.Parent
		local accessory = object:FindFirstChild("Handle")

		if not (not accessory or not accessory:IsA("BasePart")) then
			local targetPlayer = accessory:FindFirstChild("AccessoryWeld")
			local result34 = targetPlayer and targetPlayer:IsA("Weld") and targetPlayer.Part1
			local tweenInfo = nil
			local nearestPlayer = nil
			local candidate = nil

			if result34 then
				nearestPlayer = checkpointFolder:FindFirstChild(targetPlayer.Part1.Name)
				candidate = targetPlayer.C0
				tweenInfo = targetPlayer.C1
			end

			local camera = accessory:FindFirstChildOfClass("Attachment")

			if not nearestPlayer and camera then
				for _, weld in checkpointFolder:GetChildren() do
					if weld:IsA("BasePart") then
						local byte = weld:FindFirstChild(camera.Name)

						if byte and byte:IsA("Attachment") then
							candidate = camera.CFrame
							tweenInfo = byte.CFrame
							nearestPlayer = weld
							break
						end
					end
				end
			elseif not nearestPlayer then
				nearestPlayer = checkpointFolder:FindFirstChild("Head")
				candidate = object.AttachmentPoint
				tweenInfo = CFrame.new(0, 0.5, 0)
			end

			if not nearestPlayer then
				object:Destroy()
				return
			end

			for _, weld in object:GetDescendants() do
				if weld:IsA("JointInstance") or weld:IsA("WeldConstraint") then
					local cell = weld.Name == "AccessoryWeld" or weld.Part0 and not weld.Part0:IsDescendantOf(object)
					local active

					if cell then
						active = cell
					else
						active = weld.Part1 and not weld.Part1:IsDescendantOf(object)
					end

					if active then
						weld:Destroy()
					end
				elseif weld:IsA("BasePart") then
					weld.Anchored = false
					weld.CanCollide = false
					weld.Massless = true
				end
			end

			local currentCFrame = accessory.CFrame
			local difference = nearestPlayer.CFrame * tweenInfo * candidate:Inverse() * currentCFrame:Inverse()

			for _, weld in object:GetDescendants() do
				if weld:IsA("BasePart") then
					weld.CFrame = difference * weld.CFrame
				end
			end

			local motor = Instance.new("Weld")
			motor.Name = "AccessoryWeld"
			motor.Part0 = accessory
			motor.Part1 = nearestPlayer
			motor.C0 = candidate
			motor.C1 = tweenInfo
			motor.Parent = accessory
			object.Parent = checkpointFolder
			return
		end

		if type(n28) ~= "function" or n28(3904) < 277 then
			object:Destroy()
			return
		end

		while true do
		end
	end

	accessoryManager.ClearAdded = function()
		if not vertexCount then
			return
		end

		for _, weld in pairs(vertexCount.Added) do
			weld:Destroy()
		end

		table.clear(vertexCount.Added)
	end

	accessoryManager.DiscardKH = function()
		if not steering then
			return
		end

		if steering.Korblox then
			steering.Korblox:Destroy()
		end

		for _, weld in pairs(steering.LegMeshes) do
			weld:Destroy()
		end

		steering = nil
	end

	accessoryManager.DiscardAppearance = function()
		if not vertexCount then
			return
		end
		accessoryManager.ClearAdded()
		local currentStates = vertexCount.Visibility or {}

		for _, weld in pairs(currentStates) do
			weld:Disconnect()
		end

		for _, weld in pairs(vertexCount.Original) do
			weld.Object:Destroy()
		end

		vertexCount = nil
	end

	accessoryManager.CaptureAppearance = function(line)
		if vertexCount and vertexCount.Character == line then
			return vertexCount
		end
		accessoryManager.DiscardKH()
		accessoryManager.DiscardAppearance()
		vertexCount = accessoryManager.StoreAppearance(line)
		return vertexCount
	end

	accessoryManager.StoreAppearance = function(line, object)
		local lines = object or { Character = line, Original = {}, Added = {} }
		local box = line:FindFirstChild("Torso")

		if box and not lines.Visibility then
			local function onInputEnded()
				accessoryManager.UpdateVisibility(lines)
			end

			local currentStates = {}
			local connection = box:GetPropertyChangedSignal("Transparency"):Connect(onInputEnded)
			local port = box:GetPropertyChangedSignal("LocalTransparencyModifier")
			local path = port.Connect
			currentStates[1] = connection

			do
				local argumentPack = table.pack(path(port, onInputEnded))
				table.move(argumentPack, 1, argumentPack.n, 2, currentStates)
			end

			lines.Visibility = currentStates
		end

		local major = table.clone(lines.Original)

		local function onInputEnded(descendant, radius)
			for k = #lines.Original, 1, -1 do
				local byte = lines.Original[k]

				if table.find(major, byte) and byte.Parent == radius and byte.Object.ClassName == descendant.ClassName and (not descendant:IsA("Accoutrement") or byte.Object.Name == descendant.Name) and (not descendant:IsA("CharacterMesh") or byte.Object.BodyPart == descendant.BodyPart) then
					byte.Object:Destroy()
					table.remove(lines.Original, k)
				end
			end

			lines.Original[#lines.Original + 1] = { Object = descendant, Parent = radius }
			descendant.Parent = player2
		end

		for _, partTemplate in line:GetChildren() do
			if accessoryManager.IsBodyAppearance(partTemplate) then
				onInputEnded(partTemplate, line)
			end
		end

		local nearestPlayer = line:FindFirstChild("Head")

		if nearestPlayer then
			for _, partTemplate in nearestPlayer:GetChildren() do
				if accessoryManager.IsHeadAppearance(partTemplate) then
					onInputEnded(partTemplate, nearestPlayer)
				end
			end
		end

		return lines
	end

	accessoryManager.CopyAppearance = function(line, hitboxPart, object, descendant)
		local major = descendant or vertexCount
		major.Transparency = {}

		for _, partTemplate in line:GetChildren() do
			if accessoryManager.IsBodyAppearance(partTemplate) then
				local targetPart = partTemplate:Clone()
				major.Added[#major.Added + 1] = targetPart

				if targetPart:IsA("Accoutrement") then
					for _, playerObject in targetPart:GetDescendants() do
						if playerObject:IsA("BasePart") or playerObject:IsA("Decal") then
							major.Transparency[playerObject] = playerObject.Transparency
						end
					end

					accessoryManager.AddAccessory(object, targetPart)
				else
					targetPart.Parent = hitboxPart
				end
			end
		end

		local nearestPlayer = line:FindFirstChild("Head")
		local result10 = hitboxPart:FindFirstChild("Head")

		if nearestPlayer and result10 then
			for _, partTemplate in nearestPlayer:GetChildren() do
				if accessoryManager.IsHeadAppearance(partTemplate) then
					local targetPart = partTemplate:Clone()
					major.Added[#major.Added + 1] = targetPart
					targetPart.Parent = result10
				end
			end
		end

		accessoryManager.UpdateVisibility(major)
	end

	accessoryManager.UpdateVisibility = function(line)
		if not line or not line.Transparency then
			return
		end
		local box = line.Character:FindFirstChild("Torso")
		if not box then
			return
		end

		for vertex, weld in pairs(line.Transparency) do
			if vertex.Parent then
				vertex.Transparency = 1 - (1 - weld) * (1 - box.Transparency)

				if vertex:IsA("BasePart") then
					vertex.LocalTransparencyModifier = box.LocalTransparencyModifier
				end
			end
		end
	end

	accessoryManager.RestoreKH = function(hitboxPart)
		local major = steering
		steering = nil
		if not major then
			return
		end

		if major.Korblox then
			major.Korblox:Destroy()
		end

		if major.Character == hitboxPart then
			for _, partTemplate in pairs(major.LegMeshes) do
				partTemplate.Parent = hitboxPart
			end

			hitboxPart = hitboxPart and hitboxPart:FindFirstChild("Head")

			if hitboxPart then
				hitboxPart.Transparency = major.HeadTransparency
			end

			if major.Face and major.Face.Parent then
				major.Face.Transparency = major.FaceTransparency
			end
		else
			for _, partTemplate in pairs(major.LegMeshes) do
				partTemplate:Destroy()
			end
		end
	end

	accessoryManager.ApplyKH = function(hitboxPart)
		local targetHumanoid = hitboxPart and hitboxPart:FindFirstChildOfClass("Humanoid")
		if not targetHumanoid or targetHumanoid.RigType ~= Enum.HumanoidRigType.R6 then
			return
		end
		accessoryManager.RestoreKH(hitboxPart)
		local nearestPlayer = hitboxPart:FindFirstChild("Head")
		local beam = nearestPlayer and (nearestPlayer:FindFirstChild("face") or nearestPlayer:FindFirstChildOfClass("Decal"))

		local lines = {
			Character = hitboxPart,
			HeadTransparency = nearestPlayer and nearestPlayer.Transparency or 0,
			Face = beam,
			FaceTransparency = beam and beam.Transparency or 0,
			LegMeshes = {},
		}

		for _, weld in hitboxPart:GetChildren() do
			if weld:IsA("CharacterMesh") and weld.BodyPart == Enum.BodyPart.RightLeg then
				lines.LegMeshes[#lines.LegMeshes + 1] = weld
				weld.Parent = player2
			end
		end

		local sorter = Instance.new("CharacterMesh")
		sorter.Name = "FlyteKorblox"
		sorter.BodyPart = Enum.BodyPart.RightLeg
		sorter.MeshId = 101851696
		sorter.OverlayTextureId = 101851254
		sorter.Parent = hitboxPart
		lines.Korblox = sorter
		steering = lines

		if nearestPlayer then
			nearestPlayer.Transparency = 1
		end

		if beam then
			beam.Transparency = 1
		end
	end

	accessoryManager.RestoreAppearance = function(line)
		accessoryManager.RestoreKH(line)
		local major = vertexCount

		if not major then
			if line then
				line:SetAttribute("flytemarker1", nil)
			end

			return
		end

		if major.Character ~= line then
			accessoryManager.DiscardAppearance()
			return
		end
		accessoryManager.ClearAdded()
		local currentStates = major.Visibility or {}

		for _, partTemplate in pairs(currentStates) do
			partTemplate:Disconnect()
		end

		for _, partTemplate in pairs(major.Original) do
			if partTemplate.Parent and partTemplate.Parent.Parent then
				partTemplate.Object.Parent = partTemplate.Parent
			else
				partTemplate.Object:Destroy()
			end
		end

		vertexCount = nil
		line:SetAttribute("flytemarker1", nil)
	end

	accessoryManager.ApplySource = function(line, object, descendant)
		if not flags.AvatarEnabled or localPlayer.Character ~= object or radians ~= descendant then
			return
		end
		local targetHumanoid = object:FindFirstChildOfClass("Humanoid")
		if not targetHumanoid or targetHumanoid.RigType ~= Enum.HumanoidRigType.R6 then
			return
		end
		accessoryManager.RestoreKH(object)
		accessoryManager.CaptureAppearance(object)
		accessoryManager.ClearAdded()
		object:SetAttribute("flytemarker1", nil)

		if not pcall(accessoryManager.CopyAppearance, line, object, targetHumanoid) then
			accessoryManager.RestoreAppearance(object)

			if flags.KHEnabled then
				accessoryManager.ApplyKH(object)
			end

			return
		end

		if flags.KHEnabled then
			accessoryManager.ApplyKH(object)
		end

		object:SetAttribute("flytemarker1", descendant)
		accessoryManager.UpdateImages()

		for vertex in pairs(accessoryManager.Clones) do
			accessoryManager.ApplyClone(vertex)
		end

		if accessoryManager.DelayedSearch == track then
			accessoryManager.DelayedSearch = nil
			window:Notify({ Title = "wow it loaded" })
		end

		return true
	end

	accessoryManager.Update = function(line)
		if not flags.AvatarEnabled then
			return
		end
		local major = radians and accessoryManager.Sources[radians]
		local cell = not major or major.Parent ~= dummyPart

		if not cell then
			cell = angleRadians ~= accessoryManager.GetInput():lower()
		end

		if cell then
			if not accessoryManager.PendingUser then
				task.spawn(accessoryManager.Apply)
			end

			return
		end

		local model = localPlayer.Character
		if not accessoryManager.IsAppearanceReady(model) then
			return
		end

		if not line and vertexCount and vertexCount.Character == model and model:GetAttribute("flytemarker1") == radians then
			return
		end
		accessoryManager.ApplySource(major, model, radians)
	end

	accessoryManager.Apply = function()
		if not flags.AvatarEnabled then
			return
		end
		local major = accessoryManager.GetInput()
		if major == "" then
			return
		end
		local lower = major:lower()
		if accessoryManager.PendingUser == lower then
			return
		end
		local byte = radians and accessoryManager.Sources[radians]
		if not accessoryManager.PendingUser and angleRadians == lower and byte and byte.Parent == dummyPart then
			accessoryManager.Update()
			return
		end
		track += 1
		local result68 = track
		accessoryManager.PendingUser = lower
		accessoryManager.DelayedSearch = nil

		task.delay(3, function()
				if accessoryManager.PendingUser == lower and accessoryManager.SearchCurrent(result68, lower) then
					accessoryManager.DelayedSearch = result68
					window:Notify({ Title = "Roblox is delaying avatar changer np" })
				end
			end)

		local loadError = nil

		for k = 1, 3 do
			local decoded
			decoded, loadError = pcall(accessoryManager.GetUserID, major)

			if not (decoded and loadError) then
				loadError = nil
				if accessoryManager.SearchCurrent(result68, lower) then
					loadError = nil
					continue
				end
			end

			break
		end

		if not loadError or not accessoryManager.SearchCurrent(result68, lower) then
			if result68 == track then
				accessoryManager.PendingUser = nil
			end

			return
		end

		local net = nil

		while accessoryManager.SearchCurrent(result68, lower) do
			local decoded, joint = pcall(accessoryManager.GetSource, loadError)
			net = decoded and joint or nil
			if not (net or not accessoryManager.SearchCurrent(result68, lower)) then
				task.wait(2)
				continue
			end
			break
		end

		if result68 == track then
			accessoryManager.PendingUser = nil
		end

		if not net or not accessoryManager.SearchCurrent(result68, lower) then
			return
		end
		radians = loadError
		angleRadians = lower
		local model = localPlayer.Character

		if accessoryManager.IsAppearanceReady(model) and accessoryManager.SearchCurrent(result68, lower) then
			accessoryManager.ApplySource(net, model, loadError)
		end
	end

	accessoryManager.Reconcile = function(line)
		if localPlayer.Character ~= line then
			return
		end
		line:SetAttribute("flytemarker1", nil)

		if flags.AvatarEnabled then
			accessoryManager.Update(true)
		elseif flags.KHEnabled then
			accessoryManager.ApplyKH(line)
		end
	end

	accessoryManager.ClearClone = function(line)
		local major = accessoryManager.Clones[line]
		if not major then
			return
		end
		accessoryManager.Clones[line] = nil

		for _, partTemplate in pairs(major.Connections) do
			partTemplate:Disconnect()
		end

		if major.Appearance then
			local currentStates = major.Appearance.Visibility or {}

			for _, partTemplate in pairs(currentStates) do
				partTemplate:Disconnect()
			end

			for _, partTemplate in pairs(major.Appearance.Added) do
				partTemplate:Destroy()
			end

			for _, partTemplate in pairs(major.Appearance.Original) do
				if line.Parent and (partTemplate.Parent == line or partTemplate.Parent:IsDescendantOf(line)) then
					partTemplate.Object.Parent = partTemplate.Parent
				else
					partTemplate.Object:Destroy()
				end
			end
		end
	end

	accessoryManager.ApplyClone = function(line, object)
		local major = accessoryManager.Clones[line]
		local byte = radians and accessoryManager.Sources[radians]
		local cell = not major or not flags.AvatarEnabled or not byte or not object and major.ID == radians or line:GetAttribute("IsEncryptedClone") ~= true

		if not cell then
			local targetPlayerName = localPlayer.Name
			cell = line:GetAttribute("EncryptedCloneOwner") ~= targetPlayerName
		end

		if cell then
			return
		end
		local targetHumanoid = line:FindFirstChildOfClass("Humanoid")
		if not targetHumanoid or targetHumanoid.RigType ~= Enum.HumanoidRigType.R6 or not line:FindFirstChild("Head") then
			return
		end

		if major.Appearance then
			for _, playerObject in pairs(major.Appearance.Added) do
				playerObject:Destroy()
			end

			table.clear(major.Appearance.Added)
		end

		major.Appearance = accessoryManager.StoreAppearance(line, major.Appearance)
		major.ID = radians

		if not pcall(accessoryManager.CopyAppearance, byte, line, targetHumanoid, major.Appearance) then
			accessoryManager.ClearClone(line)
		end
	end

	accessoryManager.WatchClone = function(line)
		if not flags.AvatarEnabled or not line:IsA("Model") or line == localPlayer.Character or accessoryManager.Clones[line] then
			return
		end
		local lines = { Connections = {} }
		accessoryManager.Clones[line] = lines

		local function onInputEnded()
			accessoryManager.ApplyClone(line)
		end

		local function handlePlayerRemoving()
			local fin = lines.Pending

			if not fin then
				local targetPlayerName = localPlayer.Name
				fin = line:GetAttribute("EncryptedCloneOwner") ~= targetPlayerName
			end

			if fin then
				return
			end
			lines.Pending = true

			task.defer(function()
					lines.Pending = false

					if accessoryManager.Clones[line] == lines then
						accessoryManager.ApplyClone(line, true)
					end
				end)
		end

		lines.Connections.Owner = line:GetAttributeChangedSignal("EncryptedCloneOwner"):Connect(onInputEnded)
		lines.Connections.Clone = line:GetAttributeChangedSignal("IsEncryptedClone"):Connect(onInputEnded)

		lines.Connections.Loaded = line.DescendantAdded:Connect(function(hit)
				local cell = hit.Parent == line
				local result16

				if cell then
					result16 = accessoryManager.IsBodyAppearance(hit) or hit:IsA("Humanoid")
				else
					result16 = cell
				end

				if result16 or hit.Parent == line:FindFirstChild("Head") and accessoryManager.IsHeadAppearance(hit) then
					if not lines.Appearance or not table.find(lines.Appearance.Added, hit) then
						handlePlayerRemoving()
					end
				end
			end)

		local targetHumanoid = line:FindFirstChildOfClass("Humanoid")

		if targetHumanoid then
			lines.Connections.Description = targetHumanoid.ApplyDescriptionFinished:Connect(handlePlayerRemoving)
		end

		onInputEnded()
	end

	accessoryManager.Bind = function()
		coroutineFunction("Avatar")
		accessoryManager.BindRun = accessoryManager.BindRun + 1
		local middle = accessoryManager.BindRun
		if not flags.AvatarEnabled and not flags.KHEnabled then
			return
		end
		local results = {}

		local function onInputEnded(playerInstance)
			if middle ~= accessoryManager.BindRun or playerInstance ~= localPlayer.Character or not accessoryManager.IsAppearanceReady(playerInstance) then
				return
			end

			if flags.AvatarEnabled then
				if not vertexCount or vertexCount.Character ~= playerInstance or playerInstance:GetAttribute("flytemarker1") ~= radians then
					accessoryManager.Reconcile(playerInstance)
				end
			elseif flags.KHEnabled and (not steering or steering.Character ~= playerInstance) then
				accessoryManager.ApplyKH(playerInstance)
			end
		end

		local function handlePlayerRemoving(playerInstance)
			if results.Appearance then
				results.Appearance:Disconnect()
			end

			results.Appearance = playerInstance:GetAttributeChangedSignal("AppearanceLoaded"):Connect(function()
					if playerInstance:GetAttribute("AppearanceLoaded") == true then
						onInputEnded(playerInstance)
					end
				end)

			onInputEnded(playerInstance)
		end

		results.Character = localPlayer.CharacterAdded:Connect(handlePlayerRemoving)
		results.Loaded = localPlayer.CharacterAppearanceLoaded:Connect(onInputEnded)
		results.Alive = smallest.ChildAdded:Connect(onInputEnded)

		if flags.AvatarEnabled then
			results.CloneAdded = smallest.ChildAdded:Connect(accessoryManager.WatchClone)
			results.CloneRemoved = smallest.ChildRemoved:Connect(accessoryManager.ClearClone)

			for _, weld in smallest:GetChildren() do
				accessoryManager.WatchClone(weld)
			end
		else
			for vertex in pairs(accessoryManager.Clones) do
				accessoryManager.ClearClone(vertex)
			end
		end

		flyteBBState.Connections.Avatar = results

		if localPlayer.Character then
			handlePlayerRemoving(localPlayer.Character)
		end
	end

	accessoryManager.Toggle = function(context)
		flags.AvatarEnabled = context
		track += 1
		accessoryManager.PendingUser = nil

		if context then
			local intersect = uiElements and uiElements.textboxes and uiElements.textboxes.Avatar_Changer_Input

			if intersect and intersect.textbox then
				flags.AvatarUser = intersect.textbox.Text
			end

			accessoryManager.Bind()
			task.spawn(accessoryManager.Apply)
			return
		end

		accessoryManager.Bind()
		accessoryManager.RestoreImages()
		local model = localPlayer.Character

		if model then
			accessoryManager.RestoreAppearance(model)

			if flags.KHEnabled then
				accessoryManager.ApplyKH(model)
			end
		else
			accessoryManager.DiscardKH()
			accessoryManager.DiscardAppearance()
		end
	end

	accessoryManager.ToggleKH = function(actionName)
		flags.KHEnabled = actionName
		accessoryManager.Bind()
		local model = localPlayer.Character
		if not model then
			accessoryManager.DiscardKH()
			return
		end

		if actionName then
			if accessoryManager.IsAppearanceReady(model) and (not steering or steering.Character ~= model) then
				accessoryManager.ApplyKH(model)
			end
		else
			accessoryManager.RestoreKH(model)
		end

		if type(n24) ~= "number" or n24 > 4729 then
			return
		end

		while true do
		end
	end

	accessoryManager.Destroy = function()
		track += 1
		accessoryManager.PendingUser = nil
		accessoryManager.BindRun = accessoryManager.BindRun + 1
		coroutineFunction("Avatar")
		accessoryManager.RestoreImages()

		for vertex in pairs(accessoryManager.Clones) do
			accessoryManager.ClearClone(vertex)
		end

		local model = localPlayer.Character

		if model then
			if n25 < 6615 then
				while true do
				end
			else
				accessoryManager.RestoreAppearance(model)
			end
		else
			accessoryManager.DiscardKH()
			accessoryManager.DiscardAppearance()
		end

		table.clear(accessoryManager.Sources)

		if dummyPart.Parent then
			dummyPart:Destroy()
		end
	end
end

features.LoadAvatar()

coroutineBody({
	AbilityESPEnabled = false,
	AbilityESPShowNames = false,
	AbilityESPIconSize = 34,
	AbilityESPTextSize = 14,
})

features.Visuals = {
	AbilityIcons = require(replicatedStorage.Shared.AbilityIcons),
	Abilities = require(replicatedStorage.Shared.Abilities),
	AbilityAnimations = {},
	UseBall2 = require(replicatedStorage.Shared.UseBall2),
}

features.Visuals.AbilityData = features.Visuals.Abilities.All or {}
features.Visuals.FuryTimers = {}

features.Visuals.ClearFuryTimer = function(line)
	local radians = features.Visuals.FuryTimers[line]
	if not radians then
		return
	end
	features.Visuals.FuryTimers[line] = nil
	if not flag2 then
		return
	end

	if radians.Tween then
		radians.Tween:Cancel()
	end

	radians.Gui:Destroy()
end

features.Visuals.UpdateFuryTimer = function(line, object, descendant)
	local query = tostring(line)
	if not flags.AbilityESPEnabled or type(object) ~= "number" or object <= 0 then
		features.Visuals.ClearFuryTimer(query)
		return
	end
	local radians = nil

	for _, existingPlayer in workspace.Balls:GetChildren() do
		if existingPlayer.Name == query and not existingPlayer:GetAttribute("realBall") then
			radians = existingPlayer
			break
		else
			radians = nil
		end
	end

	local success4 = localPlayer.PlayerGui:FindFirstChild("FuryTimer")
	if not radians or not success4 then
		return
	end
	local lines = features.Visuals.FuryTimers[query]

	if lines and lines.Gui.Parent ~= radians then
		features.Visuals.ClearFuryTimer(query)
		lines = nil
	end

	if not lines then
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "FuryCharge"
		local difference = math.max(radians.Size.X, radians.Size.Y, radians.Size.Z) * 2.5
		billboardGui.Size = UDim2.fromScale(difference, difference * 32 / 280)
		billboardGui.StudsOffset = Vector3.new(0, -radians.Size.Y / 2 - 0.5, 0)
		billboardGui.ZIndexBehavior = success4.ZIndexBehavior
		billboardGui.AlwaysOnTop = true
		billboardGui.ClipsDescendants = false
		billboardGui.Adornee = radians
		local container = Instance.new("Frame")
		container.BackgroundTransparency = 1
		container.AnchorPoint = Vector2.new(0.5, 0.5)
		container.Position = UDim2.fromScale(0.5, 0.5)
		container.Size = UDim2.fromScale(1, 1)
		local instance7 = Instance.new("UISizeConstraint")
		instance7.MinSize = Vector2.new(220, 25.142857142857142)
		instance7.MaxSize = Vector2.new(240, 27.428571428571427)
		instance7.Parent = container
		container.Parent = billboardGui
		local targetPart = success4.Selection.ProgressBar:Clone()
		targetPart.Size = UDim2.fromScale(0.88, 0.1890625)
		targetPart.Position = UDim2.fromScale(0.55, 0.5)
		targetPart.AnchorPoint = Vector2.new(0.5, 0.5)
		targetPart.UIStroke.Thickness = 1
		targetPart.Parent = container
		billboardGui.Parent = radians
		lines = { Gui = billboardGui, Fill = targetPart.Fill }
		features.Visuals.FuryTimers[query] = lines
	end

	local topTween = lines.Tween
	lines.Tween = nil

	if topTween then
		topTween:Cancel()
	end

	lines.Fill.Size = UDim2.fromScale(math.clamp(object / (descendant or object), 0, 1), 1)
	local fadeTween = tweenService:Create(lines.Fill, TweenInfo.new(object, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(0, 1) })
	lines.Tween = fadeTween

	fadeTween.Completed:Once(function()
			if features.Visuals.FuryTimers[query] == lines and lines.Tween == fadeTween then
				features.Visuals.ClearFuryTimer(query)
			end
		end)

	fadeTween:Play()
	return true
end

features.Visuals.ClearFury = function(line)
	if not line then
		return
	end

	if line.TimerId then
		features.Visuals.ClearFuryTimer(line.TimerId)
		line.TimerId = nil
	end

	if line.ScaleTween then
		line.ScaleTween:Cancel()
		line.ScaleTween = nil
	end

	if line.PositionTween then
		line.PositionTween:Cancel()
		line.PositionTween = nil
	end

	if line.Counter then
		line.Counter:Destroy()
		line.Counter = nil
	end
end

features.Visuals.UpdateFuryCount = function(hitboxPart, line)
	if line.Counter and line.Counter.Parent ~= hitboxPart then
		features.Visuals.ClearFury(line)
	end

	if line.TimerId and line.TimerId ~= hitboxPart.Name then
		features.Visuals.ClearFuryTimer(line.TimerId)
	end

	if features.Visuals.UpdateFuryTimer(hitboxPart.Name, 0.5) then
		line.TimerId = hitboxPart.Name
	end

	local existing = hitboxPart:FindFirstChild("ComboCounter")
	if existing and existing ~= line.Counter then
		return
	end
	local clone = line.Counter

	if not clone then
		clone = replicatedStorage.Assets.ComboCounter:Clone()
		clone.Parent = hitboxPart
		line.Counter = clone
	end

	local nameLabel = clone.TextLabel
	local panel = nameLabel.UIScale
	panel.Scale = 1.2
	nameLabel.Text = tostring(line.Uses)
	nameLabel.TextColor3 = Color3.new(1, 1, 1):Lerp(Color3.fromHSV((1 - math.min(line.Uses / 35, 1)) * 0.166666, 1, 1), math.min(line.Uses / 5, 1))
	clone.StudsOffset = Vector3.new(0, 4, 0)

	if line.ScaleTween then
		line.ScaleTween:Cancel()
		line.PositionTween:Cancel()
	end

	line.ScaleTween = tweenService:Create(panel, TweenInfo.new(0.33333333333333331, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Scale = 0.6 })
	line.PositionTween = tweenService:Create(clone, TweenInfo.new(0.66666666666666663, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { StudsOffset = Vector3.new(0, 3, 0) })
	line.ScaleTween:Play()
	line.PositionTween:Play()
end

features.Visuals.GetInfo = function(line, object, descendant)
	local callbackFunction = line:GetAttribute("CurrentlyEquippedAbility") or line:GetAttribute("EquippedAbility") or line:GetAttribute("Ability") or line:GetAttribute("CurrentAbility") or object:GetAttribute("CurrentlyEquippedAbility") or object:GetAttribute("EquippedAbility") or object:GetAttribute("Ability") or object:GetAttribute("CurrentAbility")

	if not callbackFunction then
		local rootPart = object:FindFirstChild("Abilities")

		if rootPart then
			for _, particle in rootPart:GetChildren() do
				if particle:IsA("LocalScript") and particle.Enabled then
					callbackFunction = particle.Name
					break
				end
			end
		end
	end

	if not callbackFunction then
		return nil
	end
	local difference = 0
	local coins = line:FindFirstChild("Upgrades")
	coins = coins and coins:FindFirstChild(callbackFunction)

	if coins and coins:IsA("ValueBase") then
		difference = tonumber(coins.Value) or 0
	end

	local userId = tonumber(object:GetAttribute("AbilityUpgrade"))
	local openError

	if userId then
		openError = math.max(difference, userId)
	else
		openError = difference
	end

	local lines = features.Visuals.AbilityData[callbackFunction] or {}
	local bestAction = features.Visuals.AbilityIcons[callbackFunction] or lines.iconId

	if bestAction == "rbxassetid://0" then
		bestAction = nil
	end

	local radians = flyteBBState.AbilityUses[line]
	local step = math.max(tonumber(line:GetAttribute("AbilityDurationStart")) or 0, tonumber(object:GetAttribute("AbilityDurationStart")) or 0)
	local mathMax = math.max(tonumber(line:GetAttribute("AbilityDuration")) or 0, tonumber(object:GetAttribute("AbilityDuration")) or 0)
	local leftChild = step + mathMax
	local cell = step > 0 and mathMax > 0

	if cell then
		cell = leftChild >= (radians and radians.Started or 0)
	end

	if cell then
		cell = (descendant or workspace:GetServerTimeNow()) >= leftChild
	end

	local active = radians and radians.Ability == "Slashes of Fury"

	if active then
		active = radians.Character ~= object or callbackFunction ~= "Slashes of Fury" or not object:GetAttribute("FuryCatch") or cell
	end

	if active then
		features.Visuals.ClearFury(radians)
		flyteBBState.AbilityUses[line] = nil
		radians = nil
	elseif radians and radians.Recoveries and (radians.Character ~= object or radians.Ability ~= callbackFunction) then
		flyteBBState.AbilityUses[line] = nil
		radians = nil
	end

	if flags.AbilityESPEnabled and callbackFunction == "Slashes of Fury" and object:GetAttribute("FuryCatch") and not cell then
		local index51 = descendant or workspace:GetServerTimeNow()

		if not radians then
			local sourceTable = { Ability = callbackFunction, Character = object, Uses = 0, Started = index51 }
			flyteBBState.AbilityUses[line] = sourceTable
			radians = sourceTable
		end

		if not radians.TimerId and radians.Uses == 0 then
			local endPosition = 3.5 - index51 - radians.Started

			if 0 < endPosition then
				for _, existingPlayer in workspace.Balls:GetChildren() do
					if existingPlayer:GetAttribute("FuryCatch" .. line.Name) then
						if features.Visuals.UpdateFuryTimer(existingPlayer.Name, endPosition, 3.5) then
							radians.TimerId = existingPlayer.Name
						end

						break
					end
				end
			end
		end
	end

	local number, query

	if callbackFunction == "Guardian Angel" then
		number = tonumber(object:GetAttribute("GuardianAngelParriesLeft"))

		if number == nil then
			number = math.min(openError, 1) + 1
		end

		query = "lives"
	else
		number = lines.uses

		if callbackFunction == nil then
			number = workspace:GetAttribute("GoldenAbilities") and 999 or openError + 2
		elseif callbackFunction == "Dribble" then
			number = openError + 2
		end

		if number then
			if radians and radians.Ability == callbackFunction and radians.Recoveries then
				descendant = descendant or workspace:GetServerTimeNow()

				for k = #radians.Recoveries, 1, -1 do
					if radians.Recoveries[k] <= descendant then
						table.remove(radians.Recoveries, k)
					end
				end

				radians.Maximum = number
				radians.Expiration = radians.Recoveries[1]
				number = math.max(number - #radians.Recoveries, 0)
				radians.Uses = number
			end
		else
			number = nil
		end

		query = "uses"
	end

	return callbackFunction, openError + 1, bestAction, lines.isPassive or callbackFunction == "Guardian Angel", number, query, step, mathMax
end

features.Visuals.FindCharacter = function(line, object)
	if not line or not object then
		return nil
	end
	local targetPlayerName = object.Name
	local moduleName = object.DisplayName
	local radians = line:FindFirstChild(targetPlayerName, true) or line:FindFirstChild(moduleName, true)
	if radians and radians:IsA("Model") then
		return radians
	end

	for _, existingPlayer in line:GetChildren() do
		if existingPlayer:IsA("Model") then
			local callbackFunction = existingPlayer:GetAttribute("UserId") or existingPlayer:GetAttribute("UserID") or existingPlayer:GetAttribute("User")
			local targetHumanoid = existingPlayer:FindFirstChildOfClass("Humanoid")
			if callbackFunction == object.UserId or tostring(callbackFunction) == tostring(object.UserId) or existingPlayer.Name == targetPlayerName or existingPlayer.Name == moduleName or targetHumanoid and (targetHumanoid.DisplayName == moduleName or targetHumanoid.DisplayName == targetPlayerName) then
				return existingPlayer
			end
		end
	end

	return nil
end

features.Visuals.GetESPCharacter = function(line)
	if not line then
		return nil
	end
	local model = line.Character
	if model and model.Parent then
		return model
	end
	local radians = features.Visuals.FindCharacter(workspace:FindFirstChild("Alive"), line)
	if radians then
		return radians
	end
	local angleRadians = features.Visuals.FindCharacter(workspace:FindFirstChild("Dead"), line)
	if angleRadians then
		return angleRadians
	end
	return nil
end

features.Visuals.GetESPAdornee = function(line)
	if not line then
		return nil
	end
	local nearestPlayer = line:FindFirstChild("Head") or line:FindFirstChild("HumanoidRootPart")
	return nearestPlayer and nearestPlayer:IsA("BasePart") and nearestPlayer or line.PrimaryPart or line:FindFirstChildWhichIsA("BasePart")
end

features.Visuals.DestroyLabel = function(line)
	if not line then
		return
	end

	for _, particle in pairs(line.Connections) do
		particle:Disconnect()
	end

	if line.DurationTween then
		line.DurationTween:Cancel()
	end

	if line.DurationProgressTween then
		line.DurationProgressTween:Cancel()
	end

	if line.CooldownTextTween then
		line.CooldownTextTween:Cancel()
	end

	if line.Billboard then
		line.Billboard:Destroy()
	end
end

features.Visuals.UpdateSize = function(line)
	if not line or not line.Billboard then
		return
	end
	local difference = math.clamp(tonumber(flags.AbilityESPIconSize) or 34, 20, 60)
	local cosine = math.clamp(tonumber(flags.AbilityESPTextSize) or 13, 8, 20)
	local maxX = math.max(cosine - 1, 8)
	line.Billboard.Size = UDim2.new(0, 230, 0, difference + 64)
	line.IconHolder.Size = UDim2.new(0, difference, 0, difference)
	line.IconHolder.Position = UDim2.new(0.5, -(difference / 2 + 3), 0, 14)
	line.DurationHolder.Size = UDim2.new(0, 58, 0, difference)
	line.DurationHolder.Position = UDim2.new(0.5, difference / 2 - 1, 0, 14)
	line.DurationText.Size = UDim2.new(0, 48, 0, cosine + 2)
	line.DurationText.Position = UDim2.new(0, 9, 0.5, -(cosine + 2) / 2)
	line.DurationText.TextSize = cosine
	line.Uses.Size = UDim2.new(0, 64, 0, maxX + 2)
	line.Uses.Position = UDim2.new(0.5, difference / 2 - 3, 0, 14)
	line.Uses.TextSize = maxX
	line.CooldownText.Size = UDim2.new(0, 64, 0, cosine + 2)
	line.CooldownText.TextSize = cosine
	line.Label.Size = UDim2.new(1, -18, 0, cosine + 5)
	line.Label.Position = UDim2.new(0, 9, 0, difference + 19)
	line.Label.TextSize = cosine + 2
	line.PlayerName.Size = UDim2.new(1, -18, 0, maxX + 4)
	line.PlayerName.Position = UDim2.new(0, 9, 0, difference + 80)
	line.PlayerName.TextSize = maxX
end

features.Visuals.UpdateSizes = function()
	for _, particle in pairs(flyteBBState.ESPLabels) do
		features.Visuals.UpdateSize(particle)
	end
end

features.Visuals.AddLabel = function(line, object)
	if not (flags.AbilityESPEnabled or flags.AbilityESPShowNames) or not line or line == localPlayer then
		return
	end

	local function onInputEnded(descendant)
		if not (flags.AbilityESPEnabled or flags.AbilityESPShowNames) or not descendant then
			return
		end
		local radians = features.Visuals.GetESPAdornee(descendant)
		if not radians then
			return
		end
		local angleRadians = flyteBBState.ESPLabels[line]

		if angleRadians then
			features.Visuals.DestroyLabel(angleRadians)
		end

		for _, propertyName in descendant:GetDescendants() do
			if propertyName.Name == "Ability_ESP" and propertyName:IsA("BillboardGui") then
				propertyName:Destroy()
			end
		end

		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "Ability_ESP"
		billboardGui.Adornee = radians
		billboardGui.Size = UDim2.new(0, 230, 0, 98)
		billboardGui.StudsOffset = Vector3.new(0, 4.15, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.MaxDistance = 500
		billboardGui.Parent = radians
		local container = Instance.new("Frame")
		container.Size = UDim2.new(1, 0, 1, 0)
		container.BackgroundTransparency = 1
		container.Parent = billboardGui
		local mainFrame = Instance.new("Frame")
		mainFrame.Size = UDim2.new(0, 28, 0, 28)
		mainFrame.Position = UDim2.new(0.5, -20, 0, 14)
		mainFrame.BackgroundTransparency = 1
		mainFrame.ClipsDescendants = true
		mainFrame.Parent = container
		local image = Instance.new("ImageLabel")
		image.Size = UDim2.new(1, 0, 1, 0)
		image.BackgroundTransparency = 1
		image.ScaleType = Enum.ScaleType.Fit
		image.ZIndex = 1
		image.Parent = mainFrame
		local imageLabel = Instance.new("Frame")
		imageLabel.AnchorPoint = Vector2.new(0, 1)
		imageLabel.Position = UDim2.fromScale(0, 1)
		imageLabel.Size = UDim2.new(1, 0, 1, 0)
		imageLabel.BackgroundColor3 = Color3.fromRGB(75, 75, 82)
		imageLabel.BackgroundTransparency = 0.2
		imageLabel.BorderSizePixel = 0
		imageLabel.Visible = false
		imageLabel.ZIndex = 3
		imageLabel.Parent = mainFrame
		local particleEmitter = Instance.new("UIGradient")
		local createVector = Color3.fromRGB
		local track = nil
		particleEmitter.Color = ColorSequence.new(Color3.fromRGB(120, 120, 128), createVector(45, track, 52))
		particleEmitter.Rotation = 90
		particleEmitter.Parent = imageLabel
		local RemoteEvent = Instance.new("CanvasGroup")
		RemoteEvent.Size = UDim2.new(0, 58, 0, 28)
		RemoteEvent.Position = UDim2.new(0.5, 16, 0, 14)
		RemoteEvent.BackgroundTransparency = 1
		RemoteEvent.Visible = false
		RemoteEvent.ZIndex = 4
		RemoteEvent.Parent = container
		local messageLabel = Instance.new("Frame")
		messageLabel.Size = UDim2.new(0, 5, 1, 0)
		messageLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
		messageLabel.BackgroundTransparency = 0.15
		messageLabel.BorderSizePixel = 0
		messageLabel.ClipsDescendants = true
		messageLabel.ZIndex = 4
		messageLabel.Parent = RemoteEvent
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = messageLabel
		local backgroundFrame = Instance.new("Frame")
		backgroundFrame.AnchorPoint = Vector2.new(0, 1)
		backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
		backgroundFrame.Position = UDim2.new(0, 0, 1, 0)
		backgroundFrame.BackgroundColor3 = Color3.fromRGB(20, 228, 31)
		backgroundFrame.BorderSizePixel = 0
		backgroundFrame.ZIndex = 5
		backgroundFrame.Parent = messageLabel
		local trail = Instance.new("UIGradient")
		local Scheduler = Color3.fromRGB
		trail.Color = ColorSequence.new(Color3.fromRGB(120, 255, nil), Scheduler(0, 160, 20))
		trail.Rotation = 90
		trail.Parent = backgroundFrame
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(0, 48, 0, 14)
		nameLabel.Position = UDim2.new(0, 9, 0.5, -7)
		nameLabel.BackgroundTransparency = 1
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		nameLabel.TextStrokeTransparency = 0.05
		nameLabel.TextSize = 13
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.ZIndex = 6
		nameLabel.Parent = RemoteEvent
		local textBox = Instance.new("TextLabel")
		textBox.AnchorPoint = Vector2.new(1, 0)
		textBox.Size = UDim2.new(0, 48, 0, 13)
		textBox.Position = UDim2.new(0.5, 14, 0, 12)
		textBox.BackgroundTransparency = 1
		textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		textBox.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textBox.TextStrokeTransparency = 0.05
		textBox.TextSize = 12
		textBox.Font = Enum.Font.GothamBold
		textBox.TextXAlignment = Enum.TextXAlignment.Right
		textBox.Visible = false
		textBox.ZIndex = 6
		textBox.Parent = container
		local closeButton = Instance.new("TextLabel")
		closeButton.AnchorPoint = Vector2.new(0.5, 0)
		closeButton.Size = UDim2.new(0, 48, 0, 14)
		closeButton.Position = UDim2.new(0.5, -3, 0, 0)
		closeButton.BackgroundTransparency = 1
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.TextTransparency = 1
		closeButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		closeButton.TextStrokeTransparency = 1
		closeButton.TextSize = 13
		closeButton.Font = Enum.Font.GothamBold
		closeButton.TextXAlignment = Enum.TextXAlignment.Center
		closeButton.Visible = false
		closeButton.ZIndex = 6
		closeButton.Parent = container
		local submitButton = Instance.new("TextLabel")
		submitButton.Size = UDim2.new(1, -18, 0, 20)
		submitButton.Position = UDim2.new(0, 9, 0, 53)
		submitButton.BackgroundTransparency = 1
		submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		submitButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		submitButton.TextStrokeTransparency = 0.05
		submitButton.TextScaled = false
		submitButton.TextSize = 15
		submitButton.Font = Enum.Font.GothamBold
		submitButton.Text = ""
		submitButton.TextXAlignment = Enum.TextXAlignment.Center
		submitButton.TextYAlignment = Enum.TextYAlignment.Center
		submitButton.Parent = container
		local entryLabel = Instance.new("TextLabel")
		entryLabel.Size = UDim2.new(1, -18, 0, 16)
		entryLabel.Position = UDim2.new(0, 9, 0, 72)
		entryLabel.BackgroundTransparency = 1
		entryLabel.TextColor3 = Color3.fromRGB(225, 225, 230)
		entryLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		entryLabel.TextStrokeTransparency = 0.1
		entryLabel.TextSize = 14
		entryLabel.Font = Enum.Font.GothamMedium
		entryLabel.Text = line.DisplayName
		entryLabel.TextXAlignment = Enum.TextXAlignment.Center
		entryLabel.TextYAlignment = Enum.TextYAlignment.Center
		entryLabel.Visible = flags.AbilityESPShowNames
		entryLabel.Parent = container

		local lines = {
			Character = descendant,
			Connections = {},
			Billboard = billboardGui,
			Label = submitButton,
			IconHolder = mainFrame,
			Icon = image,
			Cooldown = imageLabel,
			CooldownText = closeButton,
			Duration = backgroundFrame,
			DurationHolder = RemoteEvent,
			DurationText = nameLabel,
			Uses = textBox,
			PlayerName = entryLabel,
		}

		features.Visuals.UpdateSize(lines)
		flyteBBState.ESPLabels[line] = lines

		lines.Connections[#lines.Connections + 1] = descendant:GetAttributeChangedSignal("FuryCatch"):Connect(function()
				if flags.AbilityESPEnabled and flyteBBState.ESPLabels[line] == lines then
					features.Visuals.GetInfo(line, descendant)
				end
			end)

		lines.Connections[#lines.Connections + 1] = descendant:GetAttributeChangedSignal("AbilityActive"):Connect(function()
				if features.Visuals.UseBall2() or descendant:GetAttribute("AbilityActive") ~= true or descendant:GetAttribute("Ability") ~= "Dribble" then
					return
				end
				local vertexCount, steering = features.Visuals.GetInfo(line, descendant)

				if vertexCount == nil then
					features.Visuals.TrackCooldown(descendant, vertexCount, steering)
				end
			end)

		task.spawn(function()
				local targetHumanoid = descendant:FindFirstChildOfClass("Humanoid") or descendant:WaitForChild("Humanoid", 5)
				local sourcePlayer

				if targetHumanoid then
					sourcePlayer = targetHumanoid:FindFirstChildOfClass("Animator") or targetHumanoid:WaitForChild("Animator", 5)
				else
					sourcePlayer = targetHumanoid
				end

				if not sourcePlayer or flyteBBState.ESPLabels[line] ~= lines then
					return
				end

				lines.Connections[#lines.Connections + 1] = sourcePlayer.AnimationPlayed:Connect(function(radius)
					if features.Visuals.UseBall2() then
						return
					end
					local vertexCount, steering = features.Visuals.GetInfo(line, descendant)
					local major = vertexCount and flyteBBState.AbilityCooldowns[line]
					if not vertexCount or vertexCount == "Dribble" or major and major.Ability == vertexCount and major.Ends > workspace:GetServerTimeNow() or not features.Visuals.IsAbilityAnimation(vertexCount, radius) then
						return
					end
					features.Visuals.TrackCooldown(descendant, vertexCount, steering)
				end)
			end)
	end

	local radians = flyteBBState.ESPConnections[line]

	if radians then
		radians:Disconnect()
	end

	local angleRadians = object or features.Visuals.GetESPCharacter(line)

	if angleRadians then
		onInputEnded(angleRadians)
	end

	flyteBBState.ESPConnections[line] = line.CharacterAdded:Connect(function(playerInstance)
			if flags.AbilityESPEnabled or flags.AbilityESPShowNames then
				onInputEnded(playerInstance)
			end
		end)
end

features.Visuals.ClearESP = function()
	for vertex in pairs(features.Visuals.FuryTimers) do
		features.Visuals.ClearFuryTimer(vertex)
	end

	for _, particle in pairs(flyteBBState.ESPLabels) do
		features.Visuals.DestroyLabel(particle)
	end

	table.clear(flyteBBState.ESPLabels)

	for _, particle in pairs(flyteBBState.ESPConnections) do
		if particle then
			particle:Disconnect()
		end
	end

	table.clear(flyteBBState.ESPConnections)

	for vertex, particle in pairs(flyteBBState.AbilityUses) do
		if particle.Ability == "Slashes of Fury" then
			features.Visuals.ClearFury(particle)
			flyteBBState.AbilityUses[vertex] = nil
		end
	end

	local radians = workspace
	local success2 = radians.FindFirstChild

	for _, existingPlayer in pairs({ workspace:FindFirstChild("Alive"), success2(radians, "Dead") }) do
		if existingPlayer then
			for _, propertyName in existingPlayer:GetDescendants() do
				if propertyName.Name == "Ability_ESP" and propertyName:IsA("BillboardGui") then
					propertyName:Destroy()
				end
			end
		end
	end

	for _, existingPlayer in playersService:GetPlayers() do
		local model = existingPlayer.Character

		if model then
			for _, propertyName in model:GetDescendants() do
				if propertyName.Name == "Ability_ESP" and propertyName:IsA("BillboardGui") then
					propertyName:Destroy()
				end
			end
		end
	end
end

features.Visuals.Toggle = function()
	if not flags.AbilityESPEnabled and not flags.AbilityESPShowNames then
		features.Visuals.ClearESP()
		return
	end

	if not flags.AbilityESPEnabled then
		for vertex in pairs(features.Visuals.FuryTimers) do
			features.Visuals.ClearFuryTimer(vertex)
		end

		for vertex, particle in pairs(flyteBBState.AbilityUses) do
			if particle.Ability == "Slashes of Fury" then
				features.Visuals.ClearFury(particle)
				flyteBBState.AbilityUses[vertex] = nil
			end
		end
	end

	features.Visuals.RefreshESP()
end

features.Visuals.HideDuration = function(line)
	if not line.DurationHolder.Visible or line.DurationTween then
		return
	end
	local topTween = tweenService:Create(line.DurationHolder, TweenInfo.new(0.15), { GroupTransparency = 1 })
	line.DurationTween = topTween

	topTween.Completed:Once(function(value2)
			if value2 == Enum.PlaybackState.Completed and line.DurationTween == topTween then
				line.DurationHolder.Visible = false
				line.DurationHolder.GroupTransparency = 0
				line.Duration.Position = UDim2.new(0, 0, 1, 0)
				line.Duration.Size = UDim2.new(1, 0, 1, 0)
				line.DurationTween = nil
			end
		end)

	topTween:Play()
end

features.Visuals.SetCooldownText = function(line, secondVector)
	if line.CooldownTextShown == secondVector then
		return
	end
	line.CooldownTextShown = secondVector

	if line.CooldownTextTween then
		line.CooldownTextTween:Cancel()
	end

	if secondVector then
		line.CooldownText.Visible = true
	end

	local topTween = tweenService:Create(line.CooldownText, TweenInfo.new(0.15), { TextTransparency = secondVector and 0 or 1, TextStrokeTransparency = secondVector and 0.05 or 1 })
	line.CooldownTextTween = topTween

	topTween.Completed:Once(function(value2)
			if value2 ~= Enum.PlaybackState.Completed or line.CooldownTextTween ~= topTween then
				return
			end

			if not secondVector then
				line.CooldownText.Visible = false
			end

			line.CooldownTextTween = nil
		end)

	topTween:Play()
end

features.Visuals.FormatAbilityTime = function(line)
	local radians = 10
	local difference = math.ceil(line * 10) / radians
	return "(" .. ((difference == math.floor(difference) and tostring(math.floor(difference)) or string.format("%.1f", difference)) .. "s") .. ")"
end

features.Visuals.GetCooldownDuration = function(line, object, descendant)
	local lines = features.Visuals.AbilityData[object] or {}
	local difference = math.max((tonumber(lines.cooldown) or 0) - (tonumber(lines.cooldownReductionPerUpgrade) or 0) * (descendant - 1), 0)
	local openError

	if workspace:GetAttribute("CurrentlySelectedMode") == "Fates" then
		if line:GetAttribute("Fates_DecreasedAbilityCooldown") then
			openError = difference * 0.7
		elseif line:GetAttribute("Fates_IncreasedAbilityCooldown") then
			openError = difference * 1.4285714285714286
		else
			openError = difference
		end
	else
		openError = difference
	end

	return openError
end

features.Visuals.IsAbilityAnimation = function(line, object)
	local chunk = object.Animation
	chunk = chunk and chunk.AnimationId:match("%d+")
	if not chunk then
		return false
	end
	local lines = features.Visuals.AbilityAnimations[line]

	if not lines then
		local model = localPlayer.Character
		model = model and model:FindFirstChild("Abilities")
		local radians = model and model:FindFirstChild(line) or replicatedStorage.Shared.Abilities:FindFirstChild(line)
		if not radians then
			return false
		end
		lines = {}

		for _, existingPlayer in radians:GetDescendants() do
			if existingPlayer:IsA("Animation") then
				local targetName = existingPlayer.AnimationId:match("%d+")

				if targetName then
					lines[targetName] = true
				end
			end
		end

		if not next(lines) then
			return false
		end
		features.Visuals.AbilityAnimations[line] = lines
	end

	return lines[chunk] == true
end

features.Visuals.SetCooldown = function(line, object, descendant, radius)
	local index51 = workspace:GetServerTimeNow()
	local difference = math.max(tonumber(line:GetAttribute("CooldownExpiration")) or 0, tonumber(object:GetAttribute("CooldownExpiration")) or 0)
	local openError

	if radius > 0 then
		local step = math.max(tonumber(line:GetAttribute("AbilityDurationStart")) or 0, tonumber(object:GetAttribute("AbilityDurationStart")) or 0)

		if step <= 0 or step > index51 or index51 - step > radius then
			step = index51
		end

		openError = math.max(difference, step + radius)
	else
		if difference <= index51 then
			return index51
		end
		openError = difference
	end

	flyteBBState.AbilityCooldowns[line] = { Ability = descendant, Duration = radius > 0 and radius or openError - index51, Ends = openError }
	return index51
end

features.Visuals.TrackCooldown = function(line, object, descendant)
	local hitPlayer = playersService:GetPlayerFromCharacter(line)
	if not hitPlayer or hitPlayer == localPlayer or line.Parent ~= smallest then
		return
	end

	if not object then
		object, descendant = features.Visuals.GetInfo(hitPlayer, line)
	end

	if not object then
		return
	end
	local radians = features.Visuals.GetCooldownDuration(hitPlayer, object, descendant)

	if object == nil then
		features.Detection.TrackAbilityUse(hitPlayer, line, object, descendant + 1, radians)
	end

	local angleRadians = features.Visuals.SetCooldown(hitPlayer, line, object, radians)

	if object == "Dash" then
		flyteBBState.AbilityActive[hitPlayer] = { Ability = object, Start = angleRadians, Duration = 0.2, Ends = angleRadians + 0.2 }
	end
end

features.Visuals.NativeNameVisible = function(line, object)
	line = line and line:FindFirstChildOfClass("Humanoid")
	if not line or not object or line.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
		return false
	end

	if line.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.Viewer then
		line = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") or line
	end

	local index40 = line.NameDisplayDistance
	return index40 > 0 and (primaryPart.CFrame.Position - object.Position).Magnitude <= index40
end

features.Visuals.RefreshPlayer = function(line, object)
	local radians = features.Visuals.GetESPCharacter(line)
	local angleRadians = flyteBBState.ESPLabels[line]
	local track = features.Visuals.GetESPAdornee(radians)

	if not line.Parent or not radians or not track then
		features.Visuals.DestroyLabel(angleRadians)
		flyteBBState.ESPLabels[line] = nil
		return
	end

	if not angleRadians or angleRadians.Character ~= radians or not angleRadians.Billboard.Parent or angleRadians.Billboard.Adornee ~= track then
		features.Visuals.AddLabel(line, radians)
		angleRadians = flyteBBState.ESPLabels[line]
	end

	angleRadians.Character = radians
	local scalar = nil
	local result67 = nil
	local vertexCount = nil
	local steering = nil
	local major = nil
	local netStart = nil
	local byte = nil
	local result68 = nil

	if flags.AbilityESPEnabled then
		vertexCount, byte, steering, major, result67, result68, netStart, scalar = features.Visuals.GetInfo(line, radians, object)
	end

	local cell = radians.Parent == smallest

	if not cell then
		flyteBBState.AbilityActive[line] = nil
		flyteBBState.AbilityCooldowns[line] = nil
		local net = flyteBBState.AbilityUses[line]

		if net then
			if net.Ability == "Slashes of Fury" then
				features.Visuals.ClearFury(net)
				flyteBBState.AbilityUses[line] = nil
				result67 = nil
			else
				net.Uses = net.Maximum
				result67 = net.Uses
			end
		end
	end

	local resourceName = flags.AbilityESPEnabled and vertexCount or nil
	angleRadians.Billboard.Enabled = resourceName ~= nil or flags.AbilityESPShowNames
	angleRadians.PlayerName.Text = line.DisplayName
	angleRadians.PlayerName.Visible = flags.AbilityESPShowNames and not features.Visuals.NativeNameVisible(radians, angleRadians.Billboard.Adornee)
	angleRadians.Label.Visible = resourceName ~= nil

	if resourceName then
		angleRadians.Label.Text = vertexCount .. (byte > 1 and " v" .. tostring(byte) or "")
		angleRadians.Icon.Visible = steering ~= nil

		if steering then
			angleRadians.Icon.Image = steering
		end

		angleRadians.Uses.Visible = result67 ~= nil

		if result67 ~= nil then
			angleRadians.Uses.Text = tostring(result67) .. " " .. (result67 == 1 and (result68 == "lives" and "life" or "use") or result68)
		end

		local net = flyteBBState.AbilityActive[line]

		if net and net.Ability == vertexCount and net.Ends > object then
			netStart = net.Start
			scalar = net.Duration
		elseif net then
			flyteBBState.AbilityActive[line] = nil
		end

		local magnitude = features.Visuals.GetCooldownDuration(line, vertexCount, byte)
		local lines = flyteBBState.AbilityCooldowns[line]
		local active = vertexCount == "Dribble" or vertexCount == "Dragon Spirit"
		local slider = active and flyteBBState.AbilityUses[line]
		local iteration = active and (slider and slider.Ability == vertexCount and slider.Expiration or 0)

		if not iteration then
			iteration = math.max(tonumber(line:GetAttribute("CooldownExpiration")) or 0, tonumber(radians:GetAttribute("CooldownExpiration")) or 0)
		end

		if cell and iteration > object then
			if not lines or lines.Ability ~= vertexCount or lines.Ends < iteration then
				lines = { Ability = vertexCount, Duration = magnitude > 0 and magnitude or iteration - object, Ends = iteration }
				flyteBBState.AbilityCooldowns[line] = lines
			end
		elseif active then
			flyteBBState.AbilityCooldowns[line] = nil
			lines = nil
		elseif not active and cell and magnitude > 0 and netStart > 0 and angleRadians.CooldownStart ~= netStart then
			angleRadians.CooldownStart = netStart
			lines = { Ability = vertexCount, Duration = magnitude, Ends = netStart + magnitude }
			flyteBBState.AbilityCooldowns[line] = lines
		end

		local difference = cell and lines and lines.Ability == vertexCount and math.max(lines.Ends - object, 0) or 0
		magnitude = lines and lines.Duration or magnitude

		if not major and difference > 0 and magnitude > 0 then
			local openError = math.max(1, angleRadians.Icon.AbsoluteSize.Y * math.clamp(difference / magnitude, 0, 1))
			angleRadians.Cooldown.Visible = true
			angleRadians.Cooldown.Size = UDim2.new(1, 0, 0, openError)
			angleRadians.CooldownText.Text = features.Visuals.FormatAbilityTime(difference)
			features.Visuals.SetCooldownText(angleRadians, true)
		else
			angleRadians.Cooldown.Visible = false
			features.Visuals.SetCooldownText(angleRadians, false)
		end

		local openError = scalar > 0 and math.clamp((object - netStart) / scalar, 0, 1) or 1

		if cell and not major and netStart > 0 and openError < 1 and vertexCount ~= "Rapture" and vertexCount ~= "Raging Deflection" and vertexCount ~= "Calming Deflection" then
			if angleRadians.DurationTween then
				angleRadians.DurationTween:Cancel()
				angleRadians.DurationTween = nil
			end

			angleRadians.DurationHolder.GroupTransparency = 0
			angleRadians.DurationHolder.Visible = true
			angleRadians.DurationText.Text = features.Visuals.FormatAbilityTime(scalar - object - netStart)

			if angleRadians.DurationStart ~= netStart or angleRadians.DurationTime ~= scalar then
				if angleRadians.DurationProgressTween then
					angleRadians.DurationProgressTween:Cancel()
				end

				angleRadians.DurationStart = netStart
				angleRadians.DurationTime = scalar
				angleRadians.Duration.Size = UDim2.new(1, 0, 1 - openError, 0)
				angleRadians.DurationProgressTween = tweenService:Create(angleRadians.Duration, TweenInfo.new(scalar * (1 - openError), Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 0, 0) })
				angleRadians.DurationProgressTween:Play()
			end
		else
			if angleRadians.DurationProgressTween then
				angleRadians.DurationProgressTween:Cancel()
				angleRadians.DurationProgressTween = nil
			end

			angleRadians.DurationStart = nil
			angleRadians.DurationTime = nil

			if angleRadians.DurationHolder.Visible then
				if not angleRadians.DurationTween then
					features.Visuals.HideDuration(angleRadians)
				end
			else
				angleRadians.Duration.Position = UDim2.new(0, 0, 1, 0)
				angleRadians.Duration.Size = UDim2.new(1, 0, 1, 0)
			end
		end
	else
		angleRadians.Icon.Visible = false
		angleRadians.Uses.Visible = false
		angleRadians.Cooldown.Visible = false
		angleRadians.CooldownText.Visible = false
		angleRadians.CooldownTextShown = false

		if angleRadians.CooldownTextTween then
			angleRadians.CooldownTextTween:Cancel()
		end

		angleRadians.CooldownTextTween = nil

		if angleRadians.DurationTween then
			angleRadians.DurationTween:Cancel()
		end

		if angleRadians.DurationProgressTween then
			angleRadians.DurationProgressTween:Cancel()
		end

		angleRadians.DurationTween = nil
		angleRadians.DurationProgressTween = nil
		angleRadians.DurationHolder.Visible = false
		angleRadians.DurationHolder.GroupTransparency = 0
		angleRadians.DurationStart = nil
		angleRadians.DurationTime = nil
	end
end

features.Visuals.RefreshESP = function()
	if not flags.AbilityESPEnabled and not flags.AbilityESPShowNames then
		return
	end
	local index51 = workspace:GetServerTimeNow()

	for _, particle in playersService:GetPlayers() do
		if particle ~= localPlayer then
			pcall(features.Visuals.RefreshPlayer, particle, index51)
		end
	end
end

features.Visuals.RefreshLoop = function()
	coroutineFunction("Ability ESP")
	if not flags.AbilityESPEnabled and not flags.AbilityESPShowNames then
		return
	end

	flyteBBState.Connections["Ability ESP"] = task.spawn(function()
			while flags.AbilityESPEnabled or flags.AbilityESPShowNames do
				features.Visuals.RefreshESP()
				task.wait(0.2)
			end
		end)
end

features.Visuals.ObserveCooldowns = function()
	local remoteEvent = replicatedStorage.Remotes:FindFirstChild("ActivateAbility")

	if remoteEvent then
		flyteBBState.Connections["Ability Cooldown"] = remoteEvent.OnClientEvent:Connect(function(line)
				features.Visuals.TrackCooldown(line)
			end)
	end

	local VoteRemoteEvent = replicatedStorage.Remotes:FindFirstChild("PlrDragonSummonedEvent")

	if VoteRemoteEvent then
		flyteBBState.Connections["Dragon Spirit Uses"] = VoteRemoteEvent.OnClientEvent:Connect(function(line)
				local hitPlayer = playersService:GetPlayerFromCharacter(line)
				if not hitPlayer or hitPlayer == localPlayer or workspace:GetAttribute("GoldenAbilities") then
					return
				end
				local radians, angleRadians = features.Visuals.GetInfo(hitPlayer, line)

				if radians == "Dragon Spirit" then
					features.Detection.TrackAbilityUse(hitPlayer, line, radians, angleRadians + 1, features.Visuals.GetCooldownDuration(hitPlayer, radians, angleRadians))
				end
			end)
	end
end

features.Visuals.ObserveCooldowns()

do
	local function onInputEnded()
		if not flyteBBState.Loaded or not flyteBBState.AccuracyWarningReady or flyteBBState.AccuracyWarned then
			return
		end
		local index44 = 101 - math.clamp(flags.RandomizedParryAccuracy and (flags.RandomAccuracyMin + flags.RandomAccuracyMax) * 0.5 or flags.ParryAccuracy or 80, 1, 100)

		if latestPingMs and index44 >= 80 and latestPingMs >= 300 - index44 then
			flyteBBState.AccuracyWarned = true
			window:Notify({ Title = "Your early parry timing is likely too aggressive for your current ping.", Duration = 5 })
		end
	end

	window = uiLibrary.new({ Name = "Flyte", AccentColor = colors.Accent })
	uiElements = { toggles = {}, sliders = {}, dropdowns = {}, textboxes = {} }

	local function handlePlayerRemoving()
		local radians = window:CreateSection({ Name = "Flyte", Icon = "rbxassetid://76499042599127" })

		local function onTouched(line)
			return radians:AddTab({ Name = line, Description = "Main", Icon = "rbxassetid://76499042599127" })
		end

		local entry = onTouched("Main")
		local part = onTouched("Detections")
		local placeholder = onTouched("Misc")
		local iterator = onTouched("Optimizations")
		local entity = onTouched("Settings")

		local function heartbeatUpdate(line, object, descendant)
			local angleRadians = line and uiElements.toggles[line]
			local cell = not flyteBBState.Loaded

			if not cell then
				if line then
					cell = not (angleRadians and angleRadians.notify)
				else
					cell = line
				end
			end

			if cell then
				return
			end
			window:Notify({ Title = "Switched to " .. object .. " " .. descendant, Duration = 2 })
		end

		local function onInputChanged()
			local angleRadians = entry:AddGroup({ Name = "Parry", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Auto_Parry = angleRadians:AddToggle({
				Name = "Auto Parry",
				SaveId = "Auto_Parry",
				Default = false,
				Notify = true,
				Callback = function(found)
					flags.AutoParryEnabled = found
					if not flyteBBState.Loaded then
						return
					end

					if found and flags.TriggerbotEnabled then
						flyteBBState.AutoParryTriggerbot = true
						flyteBBState.TriggerbotAutoParry = nil
						local result62 = uiElements and uiElements.toggles.Triggerbot

						if result62 and result62.Set then
							result62:Set(false)
						else
							features.Triggerbot.SetEnabled(false)
						end
					elseif not found and flyteBBState.AutoParryTriggerbot then
						flyteBBState.AutoParryTriggerbot = nil
						local result62 = uiElements and uiElements.toggles.Triggerbot

						if result62 and result62.Set then
							result62:Set(true)
						else
							features.Triggerbot.SetEnabled(true)
						end
					end

					if found then
						index16(true)
						task.defer(features.Loop.MainParryLoop)
					end
				end,
			})

			uiElements.toggles.Anti_Curve = angleRadians:AddToggle({
				Name = "Anticurve",
				SaveId = "Anticurve",
				Default = true,
				Callback = operation("AntiCurveEnabled", function()
					for _, propertyName in pairs(managerObject) do
						index14(propertyName)
					end
				end),
			})

			uiElements.toggles.Backwards_Anti_Curve = angleRadians:AddToggle({
				Name = "Backwards Anticurve",
				SaveId = "Backwards_Anticurve",
				Default = true,
				Callback = operation("BackwardsAntiCurveEnabled", function(line)
					for vertex, propertyName in pairs(managerObject) do
						index12(propertyName)

						if line then
							index10(vertex, propertyName)
						end
					end
				end),
			})

			uiElements.dropdowns.Parry_Type = angleRadians:AddDropdown({
				Name = "Parry Type",
				SaveId = "Auto_Parry_Type",
				Options = { "Remote", "VIM", "Mouse Click" },
				Default = "Remote",
				Callback = operation("AutoParryType", function(line)
					heartbeatUpdate("Auto_Parry", line, "mode")
				end),
			})

			uiElements.dropdowns.Curve_Type = angleRadians:AddDropdown({
				Name = "Curve Type",
				SaveId = "Selected_Parry_Type",
				Detachable = true,
				NoSearch = true,
				Options = {
				"Randomized Backwards",
				"Backwards",
				"BB Camera",
				"Camera",
				"Straight",
				"Dot",
				"High",
				"Random",
				"Stop",
			},
				Default = "Camera",
				Callback = function(player12)
					flags.SelectedParryType = player12
					heartbeatUpdate("Auto_Parry", player12, "type")
				end,
			})

			uiElements.dropdowns.Parry_Loop = angleRadians:AddDropdown({
				Name = "Parry Loop",
				SaveId = "Parry_Loop_Type",
				Options = { "PreSimulation", "PreRender" },
				Default = "PreSimulation",
				Callback = function(handler)
					flags.ParryLoopType = handler
					if not flyteBBState.Loaded then
						return
					end
					coroutineFunction("Auto Parry")
					flyteBBState.Connections["Auto Parry"] = (handler == "PreRender" and runService.PreRender or runService.PreSimulation):Connect(features.Loop.MainParryLoop)
				end,
			})

			angleRadians:AddDivider()

			uiElements.sliders.ParryAccuracy = angleRadians:AddSlider({
				Name = "Accuracy",
				SaveId = "Parry_Accuracy",
				Min = 1,
				Max = 100,
				Default = 80,
				Increment = 1,
				Callback = operation("ParryAccuracy"),
				OnCommit = onInputEnded,
			})

			uiElements.sliders.ParryRange = angleRadians:AddSlider({
				Name = "Parry Range",
				SaveId = "Parry_Range",
				Min = 0,
				Max = 10,
				Default = 0,
				Increment = 1,
				Callback = operation("ParryRange"),
			})

			angleRadians:AddDivider()

			uiElements.toggles.RandomizedParryAccuracy = angleRadians:AddToggle({
				Name = "Randomize Accuracy",
				SaveId = "Randomized_Parry_Accuracy",
				Default = false,
				Callback = operation("RandomizedParryAccuracy", onInputEnded),
			})

			uiElements.sliders.Random_Accuracy_Range = angleRadians:AddDoubleSlider({
				Name = "Accuracy Range",
				SaveId = "Randomized_Parry_Accuracy_Range",
				Min = 1,
				Max = 100,
				DefaultMin = 1,
				DefaultMax = 100,
				Increment = 1,
				Callback = function(player11, value3)
					flags.RandomAccuracyMin = player11
					flags.RandomAccuracyMax = value3
				end,
				OnCommit = onInputEnded,
			})

			angleRadians:AddDivider()

			uiElements.toggles.Auto_Preclick = angleRadians:AddToggle({
				Name = "Auto Preclick",
				SaveId = "Auto_Preclick",
				Default = false,
				Callback = function(itemName)
					flags.AutoPreclickEnabled = itemName

					if itemName then
						index19()
					else
						index20()
					end
				end,
			})

			uiElements.toggles.PreclickForAll = angleRadians:AddToggle({
				Name = "Preclick For All",
				SaveId = "Preclick_For_All",
				Default = false,
				Callback = operation("PreclickForAll"),
			})

			uiElements.sliders.PreclickDelay = angleRadians:AddSlider({
				Name = "Preclick Delay (MS)",
				SaveId = "Preclick_Delay",
				Min = 0,
				Max = 150,
				Default = 135,
				Increment = 1,
				Suffix = "ms",
				Callback = operation("PreclickDelay"),
			})

			uiElements.sliders.PreclickAfterVelocity = angleRadians:AddSlider({
				Name = "Preclick After Velocity",
				SaveId = "Preclick_After_Velocity",
				Min = 0,
				Max = 1000,
				Default = 0,
				Increment = 1,
				Callback = operation("PreclickAfterVelocity"),
			})

			angleRadians:AddDivider()

			uiElements.toggles.Cooldown_Protection = angleRadians:AddToggle({
				Name = "Cooldown Protection",
				SaveId = "Cooldown_Protection",
				Default = false,
				Callback = operation("CooldownProtectionEnabled"),
			})

			uiElements.toggles.Auto_Ability = angleRadians:AddToggle({
				Name = "Auto Ability",
				SaveId = "Auto_Ability",
				Default = false,
				Callback = operation("AutoAbilityEnabled"),
			})

			local track = entry:AddGroup({ Name = "Auto Spam", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Auto_Spam = track:AddToggle({
				Name = "Auto Spam",
				SaveId = "Auto_Spam",
				Default = false,
				Notify = true,
				Callback = function(func)
					flags.AutoSpamEnabled = func

					if flyteBBState.Loaded then
						features.Loop.RefreshAutoSpam()
					end
				end,
			})

			uiElements.toggles.AutoSpamAnimFix = track:AddToggle({
				Name = "Animation Fix",
				SaveId = "Auto_Spam_Anim_Fix",
				Default = true,
				Callback = operation("AutoSpamAnimFix"),
			})

			uiElements.dropdowns.Spam_Type = track:AddDropdown({
				Name = "Spam Type",
				SaveId = "Auto_Spam_Type",
				Options = { "Remote", "VIM", "Mouse Click" },
				Default = "Remote",
				Callback = operation("AutoSpamType", function(line)
					heartbeatUpdate(nil, line, "spam mode")
				end),
			})

			uiElements.dropdowns.AutoSpamAnimFixType = track:AddDropdown({
				Name = "Anim Fix Type",
				SaveId = "Auto_Spam_Anim_Fix_Type",
				Options = { "Animation + Click", "Animation", "Click" },
				Default = "Animation",
				Callback = operation("AutoSpamAnimFixType"),
			})

			track:AddDivider()
			local ESX = nil

			uiElements.toggles.Dynamic_Threshold = track:AddToggle({
				Name = "Dynamic Threshold",
				SaveId = "Dynamic_Spam_Threshold",
				Default = false,
				Callback = function(minimum)
					flags.DynamicSpamThreshold = minimum

					if ESX then
						ESX(not minimum)
					end
				end,
			})

			uiElements.sliders.Spam_Threshold = track:AddSlider({
				Name = "Threshold",
				SaveId = "Auto_Spam_Threshold",
				Min = 1,
				Max = 4,
				Default = 2,
				Increment = 1,
				Callback = function(line)
					flags.AutoSpamThreshold = math.round(line)
				end,
			})

			local progressBar = uiElements.sliders.Spam_Threshold
			local targetX = progressBar.labelText.Position.Y.Offset
			progressBar.backgroundFrame.ClipsDescendants = true
			local difference = 0

			local function vectorAdd(line, object, descendant)
				if descendant > 0 then
					tweenInstance(line, object, descendant, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				else
					for vertex, modelName in pairs(object) do
						line[vertex] = modelName
					end
				end
			end

			ESX = function(line, object)
				difference += 1
				local vertexCount = difference
				object = object and 0 or 0.34
				local openError = line and 0 or 1
				local step = line and targetX or targetX + 8

				if line then
					progressBar.labelText.Visible = true
					progressBar.valueBox.Visible = true
					progressBar.backgroundFrame.Visible = true
				end

				track.elementYPos = targetX + (line and 40 or 0)

				if track.UpdateSize then
					track.UpdateSize(object)
				end

				vectorAdd(progressBar.labelText, { Position = UDim2.new(0, 10, 0, step), TextTransparency = openError }, object)
				vectorAdd(progressBar.valueBox, { Position = UDim2.new(1, -95, 0, step), TextTransparency = openError }, object)

				vectorAdd(progressBar.backgroundFrame, {
					Position = UDim2.new(0, 10, 0, step + 30),
					Size = UDim2.new(0, progressBar.backgroundFrame.Size.X.Offset, 0, line and 5 or 0),
					BackgroundTransparency = openError,
				}, object)

				vectorAdd(progressBar.fillFrame, { BackgroundTransparency = openError }, object)

				task.delay(object, function()
						local steering = line
						local cell

						if line then
							cell = steering
						else
							cell = vertexCount ~= difference
						end

						if cell then
							return
						end
						progressBar.labelText.Visible = false
						progressBar.valueBox.Visible = false
						progressBar.backgroundFrame.Visible = false
					end)
			end

			ESX(not flags.DynamicSpamThreshold, true)
			local vertexCount = entry:AddGroup({ Name = "Manual Spam", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Manual_Spam = vertexCount:AddToggle({
				Name = "Manual Spam",
				SaveId = "Manual_Spam",
				NoSave = true,
				Default = false,
				Notify = true,
				Callback = features.ManualSpam.SetEnabled,
			})

			uiElements.toggles.Manual_Spam_UI = vertexCount:AddToggle({
				Name = "Manual UI (Mobile)",
				SaveId = "Manual_Spam_UI",
				Default = false,
				Callback = operation("ManualSpamUIEnabled", features.ManualSpam.Refresh),
			})

			uiElements.toggles.ManualSpamAnimFix = vertexCount:AddToggle({
				Name = "Manual Animation Fix",
				SaveId = "Manual_Spam_Anim_Fix",
				Default = true,
				Callback = operation("ManualSpamAnimFix"),
			})

			uiElements.dropdowns.ManualSpamType = vertexCount:AddDropdown({
				Name = "Manual Type",
				SaveId = "Manual_Spam_Type",
				Options = { "Remote", "VIM", nil },
				Default = "Remote",
				Callback = operation("ManualSpamType"),
			})

			uiElements.dropdowns.ManualSpamAnimFixType = vertexCount:AddDropdown({
				Name = "Anim Fix Type",
				SaveId = "Manual_Spam_Anim_Fix_Type",
				Options = { "Animation + Click", "Animation", "Click" },
				Default = "Animation",
				Callback = operation("ManualSpamAnimFixType"),
			})

			local steering = entry:AddGroup({ Name = "Triggerbot", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Triggerbot = steering:AddToggle({
				Name = "Triggerbot",
				NotifyName = "Triggerbot",
				SaveId = "Triggerbot",
				Default = false,
				Notify = true,
				Callback = function(line)
					features.Triggerbot.SetEnabled(line)
				end,
			})

			uiElements.toggles.Triggerbot_UI = steering:AddToggle({
				Name = "Triggerbot UI (Mobile)",
				SaveId = "Triggerbot_UI",
				Default = false,
				Callback = operation("TriggerbotUIEnabled", features.Triggerbot.RefreshUI),
			})

			uiElements.dropdowns.TriggerbotType = steering:AddDropdown({
				Name = "Triggerbot Type",
				SaveId = "Triggerbot_Type",
				Options = { "Remote", "VIM", "Mouse Click" },
				Default = "Remote",
				Callback = operation("TriggerbotType", function(line)
					heartbeatUpdate("Triggerbot", line, "triggerbot mode")
				end),
			})

			uiElements.sliders.Triggerbot_MS = steering:AddSlider({
				Name = "Delay (MS)",
				SaveId = "Triggerbot_Delay",
				Min = 0,
				Max = 200,
				Default = 0,
				Increment = 1,
				Callback = operation("TriggerbotDelay"),
			})

			uiElements.toggles.Triggerbot_Randomize_MS = steering:AddToggle({
				Name = "Randomize Delay",
				SaveId = "Triggerbot_Randomize",
				Default = false,
				Callback = operation("TriggerbotRandomize"),
			})

			uiElements.sliders.Triggerbot_MS_Range = steering:AddDoubleSlider({
				Name = "Delay Range",
				SaveId = "Triggerbot_Delay_Range",
				Min = 0,
				Max = 200,
				DefaultMin = 0,
				DefaultMax = 200,
				Increment = 1,
				Callback = function(player26, value5)
					flags.TriggerbotDelayMin = player26
					flags.TriggerbotDelayMax = value5
				end,
			})

			uiElements.toggles.Triggerbot_No_Spawn_Parry = steering:AddToggle({
				Name = "Don't Parry On Ball Spawn",
				SaveId = "Triggerbot_Ignore_Spawn",
				Default = false,
				Callback = operation("TriggerbotIgnoreSpawn"),
			})
		end

		local function vectorLength()
			local angleRadians = part:AddGroup({ Name = "Fury", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.FuryDetection = angleRadians:AddToggle({
				Name = "SOF Detection",
				SaveId = "Fury_Detection",
				Default = false,
				Notify = true,
				Callback = operation("FuryDetection"),
			})

			uiElements.toggles.Auto_Hit_SOF = angleRadians:AddToggle({ Name = "Auto Hit", SaveId = "Fury_Spam_Hit", Default = false, Callback = operation("FurySpamHit") })

			uiElements.dropdowns.FuryParryMethod = angleRadians:AddDropdown({
				Name = "Parry Method",
				SaveId = "Fury_Parry_Method",
				Options = { "Remote", "VIM", "Mouse Click" },
				Default = "Remote",
				Callback = operation("FuryParryMethod"),
			})

			uiElements.sliders.FuryParryAmount = angleRadians:AddSlider({
				Name = "Parry Amount",
				SaveId = "Fury_Parry_Amount",
				Default = 1,
				Min = 1,
				Max = 35,
				Increment = 1,
				Callback = operation("FuryParryAmount"),
			})

			uiElements.sliders.FuryParryDelay = angleRadians:AddSlider({
				Name = "Parry Delay",
				SaveId = "Fury_Parry_Delay",
				Default = 0.12,
				Min = 0.02,
				Max = 0.25,
				Increment = 0.01,
				Callback = operation("FuryParryDelay"),
			})

			uiElements.toggles.SingularityDetection = part:AddGroup({ Name = "Singularity", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Singularity Detection",
				SaveId = "Singularity_Detection",
				Default = false,
				Notify = true,
				Callback = operation("SingularityDetection"),
			})

			uiElements.toggles.TimeHoleDetection = part:AddGroup({ Name = "Time Hole", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Time Hole Detection",
				SaveId = "Time_Hole_Detection",
				Default = false,
				Notify = true,
				Callback = operation("TimeholeDetection"),
			})

			uiElements.toggles.InfinityDetection = part:AddGroup({ Name = "Infinity", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Infinity Detection",
				SaveId = "Infinity_Detection",
				Default = false,
				Notify = true,
				Callback = operation("InfinityDetection"),
			})

			uiElements.toggles.FreezeDetection = part:AddGroup({ Name = "Freeze", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Freeze Detection",
				SaveId = "Freeze_Detection",
				Default = false,
				Notify = true,
				Callback = operation("FreezeDetection"),
			})

			local track = part:AddGroup({ Name = "Dribble", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.ParryOnDribble = track:AddToggle({
				Name = "Parry On Dribble",
				SaveId = "Parry_On_Dribble",
				Default = false,
				Notify = true,
				Callback = operation("ParryOnDribble"),
			})

			uiElements.toggles.DribbleDetection = track:AddToggle({
				Name = "Parry On Self Dribble",
				SaveId = "Dribble_Detection",
				Default = false,
				Notify = true,
				Callback = operation("DribbleDetection", function(line)
					if not line then
						flyteBBState.SelfDribbleBall = nil
						flyteBBState.SelfDribbleAway = nil
					end
				end),
			})

			local vertexCount = part:AddGroup({ Name = "Phantom", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Anti_Phantom = vertexCount:AddToggle({
				Name = "Anti Phantom",
				SaveId = "Anti_Phantom",
				Default = false,
				Notify = true,
				Callback = function(taskFunction)
					flags.AntiPhantomEnabled = taskFunction

					if not taskFunction and flyteBBState.PhantomData and flyteBBState.PhantomData.Name == "Phantom" then
						features.Phantom.Reset()
					end

					if flyteBBState.Loaded then
						features.Loop.RefreshAutoSpam()
					end
				end,
			})

			local weight = configData.Dropdowns.AntiPhantomMode

			if weight ~= "Blatant" and weight ~= "Legit" then
				weight = "Legit"
			end

			uiElements.dropdowns.AntiPhantomMode = vertexCount:AddDropdown({
				Name = "Mode",
				SaveId = "Anti_Phantom_Mode",
				Options = { "Legit", "Blatant" },
				Default = weight,
				Callback = function(line)
					flags.AntiPhantomBlatant = line == "Blatant"
				end,
			})

			uiElements.dropdowns.AntiPhantomType = vertexCount:AddDropdown({
				Name = "Legit Type",
				SaveId = "Anti_Phantom_Type",
				Options = { "Spam", "Ability" },
				Default = "Spam",
				Callback = operation("AntiPhantomType"),
			})

			local steering = part:AddGroup({ Name = "Flash Counter", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Anti_Flash_Counter = steering:AddToggle({
				Name = "Anti Flash Counter",
				SaveId = "Anti_Flash_Counter",
				Default = false,
				Notify = true,
				Callback = function(amount)
					flags.AntiFlashCounterEnabled = amount

					if not amount and flyteBBState.PhantomData and flyteBBState.PhantomData.Name == "Flash Counter" then
						features.Phantom.Reset()
					end

					if flyteBBState.Loaded then
						features.Loop.RefreshAutoSpam()

						if n25 > 6622 then
							while true do
							end
						end
					end
				end,
			})

			local high = configData.Dropdowns.AntiFlashCounterMode

			if high ~= "Blatant" and high ~= "Legit" then
				high = "Legit"
			end

			uiElements.dropdowns.AntiFlashCounterMode = steering:AddDropdown({
				Name = "Mode",
				SaveId = "Anti_Flash_Counter_Mode",
				Options = { "Legit", "Blatant" },
				Default = high,
				Callback = function(line)
					flags.AntiFlashCounterBlatant = line == "Blatant"
				end,
			})

			uiElements.dropdowns.AntiFlashCounterType = steering:AddDropdown({
				Name = "Legit Type",
				SaveId = "Anti_Flash_Counter_Type",
				Options = { "Spam", "Ability" },
				Default = "Spam",
				Callback = operation("AntiFlashCounterType"),
			})

			local major = part:AddGroup({ Name = "Quasar", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Anti_Blindness = major:AddToggle({
				Name = "Anti Blindness",
				SaveId = "Anti_Blindness",
				Default = false,
				Notify = true,
				Callback = operation("AntiBlindness", features.Quasar.SetBlindness),
			})

			uiElements.toggles.Anti_Disorientate = major:AddToggle({
				Name = "Anti Disorientate",
				SaveId = "Anti_Disorientate",
				Default = false,
				Notify = true,
				Callback = operation("AntiDisorientate", features.Quasar.SetDisorientate),
			})

			local byte = part:AddGroup({ Name = "Death Slash", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.DeathSlashDetection = byte:AddToggle({
				Name = "Death Slash Detection",
				SaveId = "Death_Slash_Detection",
				Default = false,
				Notify = true,
				Callback = operation("DeathSlashDetection"),
			})

			uiElements.toggles.DeathSlashMinigame = byte:AddToggle({
				Name = "Do Minigame",
				SaveId = "Death_Slash_Minigame",
				Default = false,
				Callback = operation("DeathSlashMinigame"),
			})

			uiElements.toggles.ForcefieldDetection = part:AddGroup({ Name = "Forcefield", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Forcefield Detection",
				SaveId = "Forcefield_Detection",
				Default = false,
				Notify = true,
				Callback = operation("ForcefieldDetection"),
			})
		end

		local function vectorAdd()
			local angleRadians = iterator:AddGroup({ Name = "Rendering", Side = "Left", Icon = "rbxassetid://10723427199" })
			uiElements.toggles.No_Render = angleRadians:AddToggle({ Name = "No Render", SaveId = "No_Render", Default = false, Callback = features.Render.DisableFX })
			uiElements.toggles.Anti_Lag = angleRadians:AddToggle({ Name = "Anti-Lag", SaveId = "Anti_Lag", Default = false, Callback = features.Render.SetAntiLag })

			local function targetFunction(line, object, descendant, radius, zCoordinate, alpha)
				if not setfflag or not getfflag then
					return false, 0
				end
				local dataTable = rawget(getgenv(), "FlyteFFlagDefaults")

				if type(dataTable) ~= "table" then
					dataTable = {}
					getgenv().FlyteFFlagDefaults = dataTable
				end

				local lines = {}
				local sourceTable = {}

				for vertex in pairs(line) do
					if type(vertex) == "string" and vertex ~= "" then
						local query = vertex:gsub("^D?F[FISL][a-z]*", "")
						local decoded, loadError = pcall(getfflag, query)

						if decoded and loadError ~= nil then
							lines[#lines + 1] = vertex
							sourceTable[vertex] = query

							if alpha ~= false and dataTable[query] == nil then
								dataTable[query] = loadError
							end
						else
							line[vertex] = nil
						end
					else
						line[vertex] = nil
					end
				end

				table.sort(lines)
				object = object or 10
				descendant = descendant or 0.07
				local difference = 0

				for k = 1, #lines, object do
					for column = k, math.min(k + object - 1, #lines) do
						local vertexCount = lines[column]
						local steering = line[vertexCount]
						local copyType = type(steering)
						local query

						if copyType == "number" then
							query = tostring(steering)
						elseif copyType == "boolean" then
							query = steering and "True" or "False"
						elseif copyType == "table" then
							query = httpService:JSONEncode(steering)
						elseif copyType == "string" then
							query = steering
						else
							query = nil
						end

						if query and pcall(setfflag, sourceTable[vertexCount], query) then
							difference += 1
						end
					end

					task.wait(descendant)
				end

				if difference <= 0 then
					return false, difference
				end

				if alpha == false then
					getgenv().FlyteFFlagsApplied = nil
				else
					getgenv().FlyteFFlagsApplied = true
				end

				queueonteleport(alpha == false and "getgenv().FlyteFFlagsApplied=nil;getgenv().FlyteFFlagDefaults=nil" or ("getgenv().FlyteFFlagsApplied=true;getgenv().FlyteFFlagDefaults=game:GetService('HttpService'):JSONDecode(%s)"):format(httpService:JSONEncode(httpService:JSONEncode(dataTable))))

				if zCoordinate then
					zCoordinate(difference)
				end

				task.wait(radius or 0.5)
				game.ExperienceService:LaunchExperience({ placeId = game.PlaceId })
				return true, difference
			end

			local function cleanup(line)
				local function createNode(object)
					local decoded, loadError = pcall(httpService.JSONDecode, httpService, object)
					local joint

					if decoded and type(loadError) == "string" then
						decoded, joint = pcall(httpService.JSONDecode, httpService, loadError)
					else
						joint = loadError
					end

					return decoded and type(joint) == "table" and joint or nil
				end

				local track = createNode(line)
				if track then
					return track
				end
				local lines = {}
				local difference = 1
				local openError = 1

				while difference <= #line do
					local rootFirst = line:find("\"", difference, true)

					if rootFirst then
						local characterIndex = line:find("%S", rootFirst + 1)
						local vertexCount = characterIndex and line:byte(characterIndex)

						if vertexCount ~= 91 and vertexCount ~= 123 then
							difference = rootFirst + 1
						else
							local steering = 0
							local cell = false
							local active = false
							local major = nil

							for k = characterIndex, #line do
								local byte = line:byte(k)

								if cell then
									if active then
										active = false
										major = nil
									elseif byte == 92 then
										active = true
										major = nil
									elseif byte ~= 34 then
										major = nil
									else
										cell = false
										major = nil
									end
								elseif byte == 28 then
									cell = true
									major = nil
								elseif byte == 91 or byte == 123 then
									steering += 1
									major = nil
								elseif byte == 93 or byte == 125 then
									steering -= 1

									if steering ~= 0 then
										major = nil
									else
										major = k
										break
									end
								else
									major = nil
								end
							end

							local dataString = major and line:find("%S", major + 1)
							local block = dataString and line:find("%S", dataString + 1)
							local byte = block and line:byte(block)
							local query = major and line:sub(characterIndex, major)
							local isArray = dataString and line:byte(dataString) == 34

							if isArray then
								isArray = not byte or byte == 44 or byte == 93 or byte == 125
							end

							if isArray and createNode(query) then
								lines[#lines + 1] = line:sub(openError, rootFirst - 1)
								lines[#lines + 1] = query
								difference = dataString + 1
								openError = difference
							else
								difference = rootFirst + 1
							end
						end

						continue
					end

					break
				end

				if #lines == 0 then
					return nil
				end
				lines[#lines + 1] = line:sub(openError)
				return (createNode(table.concat(lines)))
			end

			local function createNode(line)
				local targetName = tostring(line or ""):gsub("^\u{FEFF}", ""):match("^%s*(.-)%s*$")
				if targetName == "" then
					window:Notify({ Title = "empty custom fflags" })
					return false
				end
				local track = cleanup(targetName)
				if not track then
					window:Notify({ Title = "invalid custom fflags json" })
					return false
				end

				local function generateRandomString()
					local jsonString = httpService:JSONEncode(track)
					local Selection = uiElements.textboxes.FFlags_Custom_Text

					if Selection then
						Selection:Set(jsonString)
					else
						flags.CustomFFlagsText = jsonString
					end
				end

				window:Notify({ Title = "Enabled", Duration = 1 })

				if not targetFunction(track, 60, 0.01, 0.04, function()
						generateRandomString()
						window:Notify({ Title = "Rejoining...", Duration = 1 })
					end) then
					generateRandomString()
					window:Notify({ Title = "no custom fflags applied" })
					return false
				end

				return true
			end

			local lines = {
				["US East (Virginia / New Jersey)"] = "us-east",
				["US Central (Illinois / Texas)"] = "us-central",
				["US West (California / Washington)"] = "us-west",
				["US South (Florida / Georgia)"] = "us-south",
				["Europe West (France / Netherlands / UK)"] = "eu-west",
				["Europe Central (Germany)"] = "eu-central",
				["Asia East (Hong Kong / Japan)"] = "as-east",
				["Southeast Asia (Singapore)"] = "as-southeast",
				["South Asia (India)"] = "as-south",
				["Oceania (Australia)"] = "oceania",
				["South America (Brazil)"] = "sa-east",
			}

			local sourceTable = {
				["US East"] = "US East (Virginia / New Jersey)",
				["US Central"] = "US Central (Illinois / Texas)",
				["US West"] = "US West (California / Washington)",
				["US South"] = "US South (Florida / Georgia)",
				["Europe West"] = "Europe West (France / Netherlands / UK)",
				["Europe East"] = "Europe Central (Germany)",
				["Asia East"] = "Asia East (Hong Kong / Japan)",
				["Southeast Asia"] = "Southeast Asia (Singapore)",
				["South Asia"] = "South Asia (India)",
				Oceania = "Oceania (Australia)",
				["South America"] = "South America (Brazil)",
				["us-east"] = "US East (Virginia / New Jersey)",
				["us-central"] = "US Central (Illinois / Texas)",
				["us-west"] = "US West (California / Washington)",
				["us-south"] = "US South (Florida / Georgia)",
				uk = "Europe West (France / Netherlands / UK)",
				["eu-west"] = "Europe West (France / Netherlands / UK)",
				["eu-central"] = "Europe Central (Germany)",
				["eu-east"] = "Europe Central (Germany)",
				["as-hongkong"] = "Asia East (Hong Kong / Japan)",
				["as-tokyo"] = "Asia East (Hong Kong / Japan)",
				["as-singapore"] = "Southeast Asia (Singapore)",
				["as-mumbai"] = "South Asia (India)",
				oceania = "Oceania (Australia)",
				["sa-east"] = "South America (Brazil)",
			}

			local function generateRandomString(line)
				if not setfflag or not getfflag then
					if not flag2 then
						return
					end
					return
				end

				line = lines[sourceTable[line] or line] or line

				targetFunction({
					FFlagGraphicsDisableShadows = "True",
					FFlagDebugGraphicsDisableShadows = "True",
					FFlagGraphicsDisablePostEffects = "True",
					FFlagDisablePostFx = "True",
					FFlagDisablePostEffect = "True",
					FFlagGraphicsDisableParticles = "True",
					FFlagDisableScreenSpaceEffects = "True",
					FFlagDebugDisableLightingEffects = "True",
					FFlagDisableLightInfluence = "True",
					FIntRenderQualityLevel = "1",
					FIntQualityLevel = "1",
					FFlagGraphicsQualityAutoAdjust = "False",
					FIntMockClientLightingTechnologyIxpExperimentMode = "0",
					FIntMockClientLightingTechnologyIxpExperimentQualityLevel = "7",
					DFIntDebugFRMQualityLevelOverride = "3",
					DFFlagTextureQualityOverrideEnabled = "True",
					DFIntTextureQualityOverride = "0",
					FIntTextureLODOverride = "3",
					FIntAvatarTextureLOD = "3",
					FIntFRMMinGrassDistance = "0",
					FIntFRMMaxGrassDistance = "0",
					FIntRenderGrassDetailStrands = "0",
					FFlagDebugDisableTerrainDecoration = "True",
					FIntAvatarHeadMeshQuality = "0",
					FIntAvatarBodyMeshQuality = "0",
					FFlagDebugSkipAvatarMaterials = "True",
					FFlagEnableAvatarStreaming = "True",
					FFlagEnableAvatarLoadingSuppression = "True",
					FFlagHumanoidAutoLOD = "True",
					FFlagEnableHumanoidLOD = "True",
					FFlagDebugForceLowMeshAvatars = "True",
					FFlagLowQualityCharacterRendering = "True",
					FIntAvatarAccessoryRenderDistance = "0",
					FIntAvatarLoadTimeoutMS = "0",
					FFlagAvatarRenderingOptimization = "True",
					FFlagRenderLocalCharacter = "False",
					FFlagForceStreamOutCharacters = "True",
					FIntMeshPartDetailLevel = "0",
					FFlagDisableSunRays = "True",
					FFlagDisableWeather = "True",
					FFlagDisableAtmosphere = "True",
					FFlagDebugDisableWaterEffects = "True",
					FFlagDisableMaterialEffects = "True",
					FFlagForceSimpleMaterials = "True",
					FFlagSkipDecals = "True",
					FFlagDisableCameraShake = "True",
					FFlagNewLightAttenuation = "True",
					DFFlagDisableFrameRateSmoothing = "True",
					FFlagDisableRenderingThrottling = "True",
					DFIntPerformanceControlFrameTimeMax = "1",
					FFlagForceLowMemoryMode = "True",
					FFlagDebugLowMemoryMode = "True",
					FIntVideoMemoryLimitMB = "256",
					FFlagLowDetailMode = "True",
					FFlagUIQualityReductionEnabled = "True",
					FFlagSkipQualityReductionInLowMemory = "True",
					FIntUIQualityReductionLevel = "3",
					FIntRobloxGuiBlurIntensity = "0",
					FFlagEnableRegionSelectionOverride = "True",
					FFlagDebugUseOnlySpecifiedRegion = "True",
					DFIntLargePacketQueueSizeCutoffMB = "1000",
					DFIntClientPacketHealthyAllocationPercent = "50",
					FIntRakNetResendBufferArrayLength = "128",
					DFIntWaitOnUpdateNetworkLoopEndedMS = "100",
					DFIntWaitOnRecvFromLoopEndedMS = "100",
					DFIntCodecMaxOutgoingFrames = "10000",
					DFIntCodecMaxIncomingPackets = "100",
					DFIntMaxFrameBufferSize = "4",
					DFIntMaxProcessPacketsStepsPerCyclic = "5000",
					DFIntMaxProcessPacketsJobScaling = "2139999999",
					DFIntConnectionMTUSize = "1396",
					DFIntClientPacketMaxDelayMs = "1",
					DFIntRakNetLoopMs = "1",
					DFIntMaxFramesToSend = "1",
					DFIntMaxProcessPacketsStepsAccumulated = "0",
					DFIntRakNetResendRttMultiple = "1",
					DFIntRakNetClockDriftAdjustmentPerPingMillisecond = "2139999999",
					DFIntRaknetBandwidthPingSendEveryXSeconds = "1",
					DFIntRaknetBandwidthInfluxHundredthsPercentageV2 = "10000",
					FIntInterpolationMaxDelayMSec = "1",
					FIntInterpolationAwareTargetTimeLerpHundredth = "100",
					DFIntParallelAdaptiveInterpolationBatchCount = "1",
					DFIntInterpolationDtLimitForLod = "1",
					FFlagDebugDisableTelemetryV2Event = "True",
					FFlagDebugDisableTelemetryEphemeralStat = "True",
					FFlagDebugDisableTelemetryEventIngest = "True",
					FFlagDebugDisableTelemetryV2Stat = "True",
					FFlagDebugDisableTelemetryV2Counter = "True",
					FFlagDebugDisableTelemetryEphemeralCounter = "True",
					FFlagDebugDisableTelemetryPoint = "True",
					DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent = "0",
					DFIntTrackCountryRegionAPIHundredthsPercent = "10000",
					DFIntClientLightingEnvmapPlacementTelemetryHundredthsPercent = "100",
					FFlagEnableFastPathRendering = "True",
					FFlagEnableMeshLODStreaming = "True",
					FFlagMovePrerenderV2 = "True",
					FFlagMovePrerender = "true",
					FFlagFastGPULightCulling3 = "True",
					FFlagRenderForceLowQualityDOF = "True",
					FFlagPreferLowQualityParts = "True",
					FFlagDebugGraphicsPreferLowQuality = "True",
					FIntSimSolverResponsiveness = "2147483647",
					DFFlagSimRefactorCollisionGeometry2 = "true",
					DFFlagSimOptimizeSetSize = "true",
					DFFlagSimSolverOptimizeGeometricStiffness4 = "true",
					DFFlagSimHumanoidPhysics = "true",
					FIntDebugTextureManagerSkipMips = "0",
					FIntNumFramesToCaptureCallStack = "1",
					FFlagDebugDisplayFPS = "true",
					FFlagDebugSkyGray = "true",
					FIntFullscreenTitleBarTriggerDelayMillis = "18000000",
					FFlagHandleAltEnterFullscreenManually = "False",
					FIntActivatedCountTimerMSMouse = "0",
					FIntActivatedCountTimerMSKeyboard = "0",
					FIntCLI20390 = "-1",
					FLogNetwork = "7",
					DFFlagDebugPerfMode = "True",
					DFIntParryHitboxSize = "23",
					FIntHitboxPredictionBuffer = "40",
					DFFlagEnableCustomHitbox = "true",
					DFFlagCorrectServerReplicatorStatsIP = "True",
					DFIntMaxAverageFrameDelayExceedFactor = "0",
					DFIntNumFramesAllowedToBeAboveError = "0",
					DFFlagRakNetUnblockSelectOnShutdownByWritingToSocket = "True",
					DFFlagGameNetFixReplicationSkipBug = "True",
					DFFlagCorrectCachePolicySkipRedirectCache = "True",
					DFFlagAnimatorFixReplicationASANError = "True",
					DFFlagRakNetFixBwCollapse = "False",
					FFlagEnableInGameMenuDurationLogger = "False",
					DFFlagRakNetDecoupleRecvAndUpdateLoopShutdown = "True",
					FFlagPushFrameTimeToHarmony = "True",
					DFFlagRakNetUseSlidingWindow4 = "True",
					FFlagAnimatorRetargetSkipAnkleModification = "True",
					DFFlagSkipSomePropertiesSkip = "True",
					DFFlagSkipReadDiskCacheRedirects = "True",
					DFFlagSkipSomeProperties = "True",
					DFFlagReplicatorCheckReadTableCollisions = "True",
					DFFlagDisableDPIScale = "False",
					DFFlagJointIrregularityOptimization = "True",
					DFFlagReplicateCreateToPlayer = "True",
					DFFlagDebugLargeReplicatorForceFullSend = "True",
					FFlagEnableZstdDictionaryForClientSettings = "False",
					FFlagOnlyDecrementCompletenessIfReplicating = "True",
					FFlagDebugDisableOptimizedBytecode = "False",
					DFFlagReplicatorSeparateVarThresholds = "True",
					FFlagEnableZstdForClientSettings = "False",
					FFlagFasterPreciseTime4 = "True",
					FFlagDebugCodegenOptSize = "True",
					FFlagQuaternionPoseCorrection = "True",
					DFFlagAnimatorAnywhere = "True",
					InterpolationAwareTargetTimeLerpHundredth = "100",
					MaxAverageFrameDelayExceedFactor = "0",
					TargetTimeDelayFacctorTenths = "0",
					FIntFontSizePadding = "2",
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
					DebugDisplayFPS = "True",
					FStringNetworkDefaultDNSResolveRegion = line,
					FStringForceHttpProxyRegion = line,
					FStringForceFastConnectRegion = line,
					FStringPreferredClientRegion = line,
					FStringMatchmakingRegion = line,
					FStringDataStoreRegion = line,
					FStringClientTelemetryRegionOverride = line,
					FStringForceRegion = line,
					FStringOverrideRegion = line,
					FStringForceGameServerRegion = line,
				}, 10, 0.07, 0.5)
			end

			local cell = false
			local track = iterator:AddGroup({ Name = "FFlags", Side = "Right", Icon = "rbxassetid://10723427199" })
			local nearest = nil

			uiElements.toggles.FFlags_Enable = track:AddToggle({
				Name = "Apply & Rejoin",
				SaveId = "FFlags",
				NoSave = true,
				Default = rawget(getgenv(), "FlyteFFlagsApplied") == true,
				Callback = function(line)
					if not flyteBBState.Loaded or cell then
						return
					end
					cell = true

					task.spawn(function()
						if line then
							if flags.CustomFFlags then
								local Selection = uiElements.textboxes.FFlags_Custom_Text
								createNode(Selection and Selection.textbox and Selection.textbox.Text or flags.CustomFFlagsText)
							else
								generateRandomString(flags.FFlagsRegion or "us-east")
							end
						else
							local yString = rawget(getgenv(), "FlyteFFlagDefaults")

							if type(yString) == "table" and next(yString) then
								window:Notify({ Title = "Disabled", Duration = 1 })
								targetFunction(yString, 10, 0.07, 0.5, nil, false)
							end
						end

						cell = false
					end)
				end,
			})

			uiElements.toggles.FFlags_Custom = track:AddToggle({
				Name = "Custom FFlags",
				SaveId = "Custom_FFlags",
				Default = false,
				Callback = function(reason)
					flags.CustomFFlags = reason

					if nearest then
						nearest(reason)
					end
				end,
			})

			uiElements.dropdowns.FFlagsRegion = track:AddDropdown({
				Name = "Region",
				SaveId = "FFlags_Region",
				Options = {
				"US East (Virginia / New Jersey)",
				"US Central (Illinois / Texas)",
				"US West (California / Washington)",
				"US South (Florida / Georgia)",
				"Europe West (France / Netherlands / UK)",
				"Europe Central (Germany)",
				"Asia East (Hong Kong / Japan)",
				"Southeast Asia (Singapore)",
				"South Asia (India)",
				"Oceania (Australia)",
				"South America (Brazil)",
			},
				Default = sourceTable[flags.FFlagsRegion] or flags.FFlagsRegion or "US East (Virginia / New Jersey)",
				Callback = operation("FFlagsRegion"),
			})

			uiElements.textboxes.FFlags_Custom_Text = track:AddTextbox({
				Name = "Custom FFlags",
				SaveId = "Custom_FFlags_Text",
				Placeholder = "fflags here",
				Default = "",
				Callback = operation("CustomFFlagsText"),
			})

			local targetX = uiElements.dropdowns.FFlagsRegion.labelText.Position.Y.Offset
			uiElements.textboxes.FFlags_Custom_Text.inputFrame.ClipsDescendants = true
			uiElements.dropdowns.FFlagsRegion.buttonFrame.ClipsDescendants = true

			local function subtractVectors(line, object, descendant)
				if descendant and descendant > 0 then
					tweenInstance(line, object, descendant, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				else
					for vertex, modelName in pairs(object) do
						line[vertex] = modelName
					end
				end
			end

			local difference = 0

			local function crossProduct(line, object, descendant, radius, zCoordinate)
				local openError = object and 0 or 1
				local step = object and targetX or targetX + 8
				local mathMax

				if object then
					mathMax = radius and 26 or 21
				else
					mathMax = object
				end

				mathMax = mathMax or 0
				local forceField = radius and line.inputFrame or line.buttonFrame

				if line.Close then
					line:Close()
				end

				if object then
					if type(n28) ~= "function" or n28(2612) <= 505 then
						line.labelText.Visible = true
						forceField.Visible = true
					else
						while true do
						end
					end
				end

				subtractVectors(line.labelText, { Position = UDim2.new(0, 10, 0, step), TextTransparency = openError }, descendant)

				subtractVectors(forceField, {
					Position = radius and UDim2.new(0, 10, 0, step + 22) or UDim2.new(1, forceField.Position.X.Offset, 0, step),
					Size = UDim2.new(0, forceField.Size.X.Offset, 0, mathMax),
					BackgroundTransparency = openError,
				}, descendant)

				if radius then
					subtractVectors(line.textbox, {
						TextTransparency = openError,
						PlaceholderColor3 = object and track.Library.config.Colors.SubText or track.Library.config.Colors.Secondary,
					}, descendant)
				else
					subtractVectors(line.selectedLabelText, { TextTransparency = openError }, descendant)
					subtractVectors(line.arrowImg, { ImageTransparency = openError }, descendant)
				end

				local vertexCount = forceField:FindFirstChildOfClass("UIStroke")

				if vertexCount then
					subtractVectors(vertexCount, { Transparency = openError }, descendant)
				end

				task.delay(descendant or 0, function()
						if object or zCoordinate ~= difference then
							return
						end
						line.labelText.Visible = false
						forceField.Visible = false
					end)
			end

			nearest = function(reason, line)
				difference += 1
				line = line and 0 or 0.34
				flags.CustomFFlags = reason
				track.elementYPos = targetX + (reason and 56 or 28)

				if track.UpdateSize then
					track.UpdateSize(line)
				end

				crossProduct(uiElements.dropdowns.FFlagsRegion, not reason, line, false, difference)
				crossProduct(uiElements.textboxes.FFlags_Custom_Text, reason, line, true, difference)
			end

			nearest(flags.CustomFFlags == true, true)
		end

		local function targetFunction()
			uiElements.toggles.Ball_Stats = placeholder:AddGroup({ Name = "Ball Misc", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({ Name = "Ball Stats", SaveId = "Ball_Stats", Default = false, Callback = features.BallStats.Toggle })
			local angleRadians = placeholder:AddGroup({ Name = "Avatar", Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Avatar_Changer = angleRadians:AddToggle({
				Name = "Avatar Changer",
				SaveId = "Avatar",
				Default = false,
				Callback = function(context)
					flags.AvatarEnabled = context

					if flyteBBState.Loaded then
						accessoryManager.Toggle(context)
					end
				end,
			})

			uiElements.toggles.Avatar_Korblox_Headless = angleRadians:AddToggle({
				Name = "Korblox/Headless",
				SaveId = "KH",
				Default = false,
				Callback = function(actionName)
					flags.KHEnabled = actionName

					if flyteBBState.Loaded then
						accessoryManager.ToggleKH(actionName)
					end
				end,
			})

			uiElements.textboxes.Avatar_Changer_Input = angleRadians:AddTextbox({
				Name = "Avatar User/ID",
				SaveId = "Avatar_User",
				Placeholder = "user/userid",
				Callback = function(height)
					flags.AvatarUser = height

					if flyteBBState.Loaded and flags.AvatarEnabled then
						task.spawn(accessoryManager.Apply)
					end
				end,
			})

			uiElements.toggles.Unlock_All = placeholder:AddGroup({ Name = "Inventory", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Unlock All (Client)",
				SaveId = "Unlock_All",
				Default = false,
				Callback = function(player28)
					flags.UnlockAllEnabled = player28
					if not flyteBBState.Loaded then
						return
					end
					features.UnlockAll.Toggle(player28)
				end,
			})

			local track = placeholder:AddGroup({ Name = nil, Side = "Right", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.CustomStreak = track:AddToggle({
				Name = "Custom Streak",
				SaveId = "Custom_Streak",
				Default = false,
				Callback = function(other)
					flags.CustomStreakEnabled = other

					if flyteBBState.Loaded then
						features.Streak.Toggle(other)
					end
				end,
			})

			uiElements.textboxes.CustomStreak = track:AddTextbox({
				Name = "Streak",
				SaveId = "Streak",
				Placeholder = "Streak Here",
				Callback = function(maximum)
					flags.CustomStreak = maximum

					if flyteBBState.Loaded and flags.CustomStreakEnabled then
						features.Streak.Toggle(true)
					end
				end,
			})

			local vertexCount = placeholder:AddGroup({ Name = "Stats", Side = "Right", Icon = "rbxassetid://10723427199" })

			for _, info in pairs({ "Wins", "Elims", "RAP" }) do
				local query = "Show_" .. info
				local concatenated = "Show" .. info

				uiElements.toggles[query] = vertexCount:AddToggle({
					Name = "Show " .. info,
					SaveId = query,
					Default = false,
					Callback = function(line)
						flags[concatenated] = line

						if flyteBBState.Loaded then
							features.Stats.Queue()
						end
					end,
				})
			end

			uiElements.toggles.AutoRejoinExecute = placeholder:AddGroup({ Name = "Script", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Auto Rejoin & Execute",
				SaveId = "Auto_Rejoin_Execute",
				Default = false,
				Callback = function(args)
					flags.AutoRejoinExecute = args

					if flyteBBState.Loaded then
						features.Script.Toggle(args)
					end
				end,
			})

			local steering = placeholder:AddGroup({ Name = "Staff", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.StaffDetection = steering:AddToggle({
				Name = "Staff Detection",
				SaveId = "Staff_Detection",
				Default = false,
				Callback = function(player18)
					flags.StaffDetection = player18
					features.Staff.Set(player18)
				end,
			})

			uiElements.dropdowns.StaffDetectionMode = steering:AddDropdown({
				Name = "Mode",
				SaveId = "Staff_Detection_Mode",
				Options = { "warn", "kick" },
				Default = "warn",
				Callback = operation("StaffDetectionMode"),
			})

			local yString = rawget(getgenv(), "FlyteDeviceSpoofApplied")
			local currencyStat = type(yString) == "table" and yString.JobId == game.JobId and yString.Device
			local query = (currencyStat == "Phone" or currencyStat == "Tablet") and "Mobile" or currencyStat or "PC"
			local major = placeholder:AddGroup({ Name = "Device Spoof", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.dropdowns.DeviceSpoofType = major:AddDropdown({
				Name = "Device",
				SaveId = "Device_Spoof_Type",
				NoSave = true,
				Options = { "PC", "Mobile", "Console" },
				Default = query,
				Callback = function(firstVector)
					flags.DeviceSpoofType = firstVector
				end,
			})

			major:AddButton({ Name = "Apply", Callback = features.DeviceSpoof.Apply })
			local byte = placeholder:AddGroup({ Name = "Ability", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Ability_ESP = byte:AddToggle({
				Name = "Ability ESP",
				SaveId = "Ability_ESP",
				Default = false,
				Callback = function(rawCommand)
					flags.AbilityESPEnabled = rawCommand
					if not flyteBBState.Loaded then
						return
					end
					features.Visuals.Toggle(rawCommand)
					features.Visuals.RefreshLoop()
				end,
			})

			uiElements.toggles.AbilityESPShowNames = byte:AddToggle({
				Name = "Show Names",
				SaveId = "Ability_ESP_Show_Names",
				Default = false,
				Callback = function(text)
					flags.AbilityESPShowNames = text

					if flyteBBState.Loaded then
						features.Visuals.Toggle()
						features.Visuals.RefreshLoop()
					end
				end,
			})

			uiElements.sliders.AbilityESPIconSize = byte:AddSlider({
				Name = "Icon Size",
				SaveId = "Ability_ESP_Icon_Size",
				Min = 20,
				Max = 60,
				Default = 34,
				Increment = 1,
				Callback = function(playerEntity)
					flags.AbilityESPIconSize = playerEntity

					if flyteBBState.Loaded then
						features.Visuals.UpdateSizes()
					end
				end,
			})

			uiElements.sliders.AbilityESPTextSize = byte:AddSlider({
				Name = "Text Size",
				SaveId = "Ability_ESP_Text_Size",
				Min = 8,
				Max = 20,
				Default = 13,
				Increment = 1,
				Callback = function(eventName)
					flags.AbilityESPTextSize = eventName

					if flyteBBState.Loaded then
						features.Visuals.UpdateSizes()
					end
				end,
			})

			local result68 = placeholder:AddGroup({ Name = "Rewards", Side = "Left", Icon = "rbxassetid://10723427199" })

			for _, childNode in pairs(features.Rewards.Items) do
				uiElements.toggles[childNode.ID] = result68:AddToggle({
					Name = childNode.Name,
					SaveId = childNode.ID,
					Default = false,
					Notify = childNode.Notify,
					Callback = function(line)
						flags[childNode.ID] = line

						if flyteBBState.Loaded then
							features.Rewards.Toggle()
						end
					end,
				})
			end

			local net = placeholder:AddGroup({ Name = "Automation", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.toggles.Auto_Play = net:AddToggle({
				Name = "Auto Play",
				SaveId = "Auto_Play",
				Default = false,
				Callback = function(inputString)
					flags.AutoPlayEnabled = inputString

					if flyteBBState.Loaded then
						features.AutoPlay.Toggle(inputString)
					end
				end,
			})

			uiElements.toggles.AutoVoteMap = net:AddToggle({
				Name = "Auto Vote Map",
				SaveId = "Auto_Vote_Map",
				Default = false,
				Callback = function(original)
					flags.AutoVoteMap = original

					if not original then
						table.clear(features.AutoPlay.Voting)
					end
				end,
			})

			uiElements.toggles.HitFreeze = net:AddToggle({ Name = "Hit Freeze", SaveId = "Hit_Freeze", Default = false, Callback = operation("HitFreeze") })

			uiElements.toggles.SpamJump = net:AddToggle({
				Name = "Spam Jump",
				SaveId = "Spam_Jump",
				Default = false,
				Callback = function(player16)
					flags.SpamJump = player16

					if not player16 then
						features.AutoPlay.Jump(false)
					end
				end,
			})

			uiElements.sliders.AutoPlaySmoothness = net:AddSlider({
				Name = "Smoothness",
				SaveId = "Auto_Play_Smoothness",
				Min = 1,
				Max = 100,
				Default = 50,
				Increment = 1,
				Callback = operation("AutoPlaySmoothness"),
			})

			uiElements.sliders.AutoPlayAggressiveness = net:AddSlider({
				Name = "Aggressiveness",
				SaveId = "Auto_Play_Aggressiveness",
				Min = 1,
				Max = 100,
				Default = nil,
				Increment = 1,
				Callback = operation("AutoPlayAggressiveness"),
			})

			uiElements.toggles.AntiAFK = net:AddToggle({
				Name = "Anti-AFK",
				SaveId = "Anti_AFK",
				Default = false,
				Callback = function(filePath)
					flags.AntiAFK = filePath

					if flyteBBState.Loaded then
						features.AFK.Toggle(filePath)
					end
				end,
			})

			uiElements.dropdowns.AutoPlayMode = net:AddDropdown({
				Name = "Mode",
				SaveId = "Auto_Play_Mode",
				Options = { "Play Edge", "Play Middle", "Mix" },
				Default = "Play Edge",
				Callback = operation("AutoPlayMode"),
			})
		end

		local function cleanup()
			local angleRadians = entity:AddGroup({ Name = "Menu", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.sliders.MenuScale = angleRadians:AddSlider({
				Name = "Menu Scale",
				SaveId = "Menu_Scale",
				Min = 50,
				Max = 150,
				Default = 100,
				Increment = 1,
				Callback = function(numberString)
					flags.MenuScale = math.clamp(tonumber(numberString) or 100, 50, 150)

					if window then
						window:UpdateLayoutScale()
					end
				end,
			})

			if touchEnabled then
				uiElements.sliders.MobileButtonScale = angleRadians:AddSlider({
					Name = "Mobile Button Scale",
					SaveId = "Mobile_Button_Scale",
					Min = 50,
					Max = 150,
					Default = 100,
					Increment = 1,
					Callback = function(denominator)
						flags.MobileButtonScale = denominator

						if window and window.mobileToggleScale then
							tweenInstance(window.mobileToggleScale, { Scale = denominator / 100 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						end
					end,
				})
			end

			uiElements.toggles.Minimize_Keybind = angleRadians:AddKeybind({
				Name = "UI Toggle Keybind",
				SaveId = "Menu_Toggle_Keybind",
				Default = Enum.KeyCode.RightAlt,
				ChangedCallback = function(player24)
					if window then
						window.toggleVisibilityKey = player24
						window.toggleVisibilityKeyName = player24 == Enum.KeyCode.Unknown and "None" or player24.Name
						window.lastKeybindChanged = tick()
					end
				end,
			})

			local track = entity:AddGroup({ Name = "Configs", Side = "Left", Icon = "rbxassetid://10723427199" })

			uiElements.textboxes.ConfigName = track:AddTextbox({
				Name = "Config Name",
				SaveId = "ConfigName",
				Default = "",
				NoSave = true,
				Callback = function()
				end,
			})

			local nearestIndex = nil

			uiElements.dropdowns.Config_List = track:AddDropdown({
				Name = "Config List",
				SaveId = "Config_List",
				Options = Configs:Refresh(),
				Default = "none",
				NoSave = true,
				OnOpen = function()
					if nearestIndex then
						nearestIndex()
					end
				end,
				Callback = function(line)
					Configs.Selected = line ~= "none" and line or nil
				end,
			})

			nearestIndex = function()
				local lines = Configs:Refresh()

				if #lines == 0 then
					lines = { "none" }
				end

				uiElements.dropdowns.Config_List:Refresh(lines)

				if Configs.Selected and table.find(lines, Configs.Selected) then
					uiElements.dropdowns.Config_List:Set(Configs.Selected)
				else
					uiElements.dropdowns.Config_List:Set(lines[1])
				end
			end

			nearestIndex()
			local difference = (tonumber(track.elementYPos) or tonumber(track.mainFrame.AbsoluteSize.Y) or 0) + 2

			local function generateRandomString(line, object, descendant)
				window:Notify({ Title = line and object or "config failed: " .. tostring(descendant), Duration = 3 })
			end

			local function onHumanoidDied(line, object, descendant, radius)
				local mathMax = object == 1 and 10 or 135
				local leftChild = difference + ((tonumber(descendant) or 1) - 1) * 31

				local button = createInstance("TextButton", {
					Name = line:gsub("%s+", "_"),
					AutoButtonColor = false,
					BackgroundColor3 = track.Library.config.Colors.Element,
					BorderSizePixel = 0,
					FontFace = fontCache.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
					Text = line,
					TextColor3 = track.Library.config.Colors.SubText,
					TextSize = 13,
					Position = UDim2.new(0, mathMax, 0, leftChild),
					Size = UDim2.new(0, 113, 0, 25),
					Parent = track.mainFrame,
				})

				createInstance("UICorner", { CornerRadius = UDim.new(0, 7), Parent = button })
				local vertexCount = createInstance("UIStroke", { Color = track.Library.config.Colors.BorderSoft, Parent = button })

				button.MouseEnter:Connect(function()
						tweenInstance(button, {
						BackgroundColor3 = track.Library.config.Colors.ElementHover,
						TextColor3 = track.Library.config.Colors.Text,
					}, 0.2)

						tweenInstance(vertexCount, { Color = track.Library.config.Colors.Border }, 0.18)
					end)

				button.MouseLeave:Connect(function()
						tweenInstance(button, {
						BackgroundColor3 = track.Library.config.Colors.Element,
						TextColor3 = track.Library.config.Colors.SubText,
					}, 0.22)

						tweenInstance(vertexCount, { Color = track.Library.config.Colors.BorderSoft }, 0.22)
					end)

				button.MouseButton1Down:Connect(function()
						tweenInstance(button, {
						Size = UDim2.new(0, 113 - 5, 0, 25 - 2),
						Position = UDim2.new(0, mathMax + 2, 0, leftChild + 1),
					}, 0.08, Enum.EasingStyle.Quad)
					end)

				button.MouseButton1Up:Connect(function()
						tweenInstance(button, { Size = UDim2.new(0, 113, 0, 25), Position = UDim2.new(0, mathMax, 0, leftChild) }, 0.22, Enum.EasingStyle.Back)
						radius()
					end)
			end

			local function subtractVectors(line, object, descendant)
				return function()
					local playerUserId = Configs.Selected
					local vertexCount, steering = Configs[line](Configs, playerUserId)
					generateRandomString(vertexCount, object .. tostring(playerUserId), steering)

					if descendant then
						nearestIndex()
					end
				end
			end

			onHumanoidDied("Create", 1, 1, function()
					local query = uiElements.textboxes.ConfigName and uiElements.textboxes.ConfigName.value or ""
					local vertexCount, steering = Configs:Save(query)
					generateRandomString(vertexCount, "created config " .. tostring(Configs.Name(query) or query), steering)
					nearestIndex()
				end)

			local currentTime = subtractVectors("Load", "loaded config ")
			onHumanoidDied("Load", 2, 1, currentTime)
			local startTime = subtractVectors("Save", "overwrote config ", true)
			onHumanoidDied("Overwrite", 1, 2, startTime)
			local deltaTime = subtractVectors("Reset", "reset config ", true)
			onHumanoidDied("Reset Config", 2, 2, deltaTime)
			local errorMessage = subtractVectors("Delete", "deleted config ", true)
			onHumanoidDied("Delete", 1, 3, errorMessage)
			local playerPed = subtractVectors("SetAutoload", "autoload set to ")
			onHumanoidDied("Autoload", 2, 3, playerPed)

			onHumanoidDied("Reset Autoload", 1, 24, function()
					Configs:ClearAutoload()
					window:Notify({ Title = "autoload reset", Duration = 3 })
				end)

			onHumanoidDied("Reset Settings", 2, 24, function()
					Configs.Apply(Configs.Defaults())
					window:Notify({ Title = "settings reset to default", Duration = 3 })
				end)

			track.elementYPos = difference + 124

			if track.UpdateSize then
				track.UpdateSize()
			end

			uiElements.toggles.Keybind_List = entity:AddGroup({ Name = "UI Extras", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
				Name = "Keybind List",
				SaveId = nil,
				Default = false,
				Callback = features.UIExtra.ToggleKeybindList,
			})
		end

		onInputChanged()
		vectorLength()
		vectorAdd()
		targetFunction()
		cleanup()
	end

	handlePlayerRemoving()
	Configs:LoadAutoload()
	window:UpdateLayoutScale()
	flyteBBState.Loaded = true
	features.Rewards.Toggle()
	features.Visuals.Toggle(flags.AbilityESPEnabled)
	features.Visuals.RefreshLoop()
	features.AFK.Toggle(flags.AntiAFK)
	features.Script.Toggle(flags.AutoRejoinExecute)

	if flags.AvatarEnabled then
		task.defer(accessoryManager.Toggle, true)
	end

	if flags.KHEnabled then
		task.defer(accessoryManager.ToggleKH, true)
	end

	if flags.UnlockAllEnabled then
		task.defer(features.UnlockAll.Toggle, true)
	end

	if flags.CustomStreakEnabled then
		task.defer(features.Streak.Toggle, true)
	end

	if flags.ShowWins or flags.ShowElims or flags.ShowRAP then
		task.defer(features.Stats.Toggle)
	end

	if flags.AutoPlayEnabled then
		features.AutoPlay.Toggle(true)
	end

	if flags.AutoParryEnabled and flags.TriggerbotEnabled then
		uiElements.toggles.Triggerbot:Set(false)
	end

	saveConfig()
	flyteBBState.Connections["Auto Parry"] = (flags.ParryLoopType == "PreRender" and runService.PreRender or runService.PreSimulation):Connect(features.Loop.MainParryLoop)
	features.Loop.RefreshAutoSpam()

	startTriggerbot = function()
		coroutineFunction("Triggerbot")
		index16(true)
		features.Triggerbot.Update()
		flyteBBState.Connections.Triggerbot = runService.PreSimulation:Connect(features.Triggerbot.Update)
	end

	resetTriggerbotState = function()
		coroutineFunction("Triggerbot")
		local sign = playerGui or workspace:FindFirstChild("Balls")

		if sign then
			for _, particle in sign:GetChildren() do
				index7(particle).TriggerbotParried = false
			end
		end
	end

	if flags.TriggerbotEnabled then
		startTriggerbot()
	end

	features.Triggerbot.RefreshUI()

	if flags.ManualSpamEnabled then
		features.ManualSpam.Start()
	end

	if replicatedStorage.Remotes:FindFirstChild("ParrySuccess") then
		flyteBBState.Connections["Parry Success"] = replicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
				features.Animation.BypassCooldown()
				flyteBBState.InfinityParried = true
				if flyteBBState.ParryMethod == "VIM" then
					return
				end
				flyteBBState.ParryMethod = "VIM"
				local checkpointFolder = smallest and smallest.Parent and smallest or workspace:FindFirstChild("Alive")

				if checkpointFolder then
					smallest = checkpointFolder
				end

				if not localPlayer.Character or localPlayer.Character.Parent ~= smallest then
					return
				end
				local targetHumanoid = localPlayer.Character:FindFirstChild("Humanoid")

				if targetHumanoid then
					if demo(4025) >= 5564 then
						for _, particle in targetHumanoid.Animator:GetPlayingAnimationTracks() do
							if particle:GetAttribute("GrabParry") or particle:GetAttribute("Parry") or particle.Name == "GrabParry" or particle.Name == "Grab" then
								particle:Stop(particle:GetAttribute("StopFadeTime") or 0.1)
							end
						end
					else
						for _, particle in targetHumanoid:GetPlayingAnimationTracks() do
							if particle:GetAttribute("GrabParry") or particle:GetAttribute("Parry") or particle.Name == "GrabParry" or particle.Name == "Grab" then
								particle:Stop(particle:GetAttribute("StopFadeTime") or 0.1)
							end
						end
					end
				end
			end)
	end

	if flags.AutoPreclickEnabled then
		index19()
	end

	flyteBBState.Connections["ESP Player"] = playersService.PlayerAdded:Connect(function(player9)
			if flags.AbilityESPEnabled or flags.AbilityESPShowNames then
				features.Visuals.AddLabel(player9)
			end
		end)

	flyteBBState.Connections["ESP Player Removing"] = playersService.PlayerRemoving:Connect(function(player9)
			features.Visuals.DestroyLabel(flyteBBState.ESPLabels[player9])
			flyteBBState.ESPLabels[player9] = nil
			local radians = flyteBBState.ESPConnections[player9]

			if radians then
				radians:Disconnect()
				flyteBBState.ESPConnections[player9] = nil
			end

			flyteBBState.AbilityActive[player9] = nil
			flyteBBState.AbilityCooldowns[player9] = nil
			features.Visuals.ClearFury(flyteBBState.AbilityUses[player9])
			flyteBBState.AbilityUses[player9] = nil
		end)

	flyteBBState.Connections["Accuracy Warning"] = task.delay(5, function()
			flyteBBState.AccuracyWarningReady = true
			onInputEnded()
		end)
end

getgenv().FlyteBB = window
