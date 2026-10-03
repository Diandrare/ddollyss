
local function fn()
	if not ({
		[13772394625] = true,
		[15509350986] = true,
		[16281300371] = true,
		[16331600459] = true,
		[14732610803] = true,
		[15131065025] = true,
		[15517169103] = true,
		[15552588346] = true,
		[16456370330] = true,
		[101792363513541] = true,
		[15264892126] = true,
		[15144787112] = true,
		[15234596844] = true,
		[16331596518] = true,
		[17757592456] = true,
		[111661204337143] = true,
		[16331598816] = true,
		[80316691895873] = true,
		[15185247558] = true,
		[16044264830] = true,
		[15582823307] = true,
		[15240096157] = true,
		[14915220621] = true,
		[15582821022] = true,
		[16331595046] = true,
		[16581648071] = true,
		[16581637217] = true,
		[92458008626219] = true,
		[97204747083036] = true,
		[14368557094] = true,
	})[game.PlaceId] then
		local localPlayer = game:GetService("Players").LocalPlayer
		local str = "Rise only works in Blade Ball. Get the script at discord.gg/risebb"

		task.spawn(function()
			for i = 1, 6 do
				localPlayer:Kick(str)
				task.wait(0.1)
			end
		end)

		return
	end

	if not getupvalues then
		getupvalues = debug and debug.getupvalues
	end

	if not setupvalue then
		setupvalue = debug and debug.setupvalue
	end

	if not request then
		request = http_request
	end

	if not identifyexecutor then
		identifyexecutor = getexecutorname
	end

	if not getthreadidentity then
		getthreadidentity = getidentity or getthreadcontext
	end

	if not queueonteleport then
		queueonteleport = queue_on_teleport
	end

	if not setclipboard then
		setclipboard = toclipboard
	end

	local tbl = {}

	for _, v in ipairs({
		{ "getconnections", getconnections },
		{ "getgc", getgc },
		{ "getgenv", getgenv },
		{ "getthreadidentity", getthreadidentity },
		{ "getupvalues", getupvalues },
		{ "isfile", isfile },
		{ "islclosure", islclosure },
		{ "loadstring", loadstring },
		{ "readfile", readfile },
		{ "request", request },
		{ "setthreadidentity", setthreadidentity },
		{ "setupvalue", setupvalue },
		{ "writefile", writefile },
	}) do
		if v[2] == nil then
			tbl[#tbl + 1] = v[1]
		end
	end

	if #tbl > 0 then
		table.sort(tbl)
		warn(("[Rise] %s is missing %d function(s) Rise needs: %s"):format(tostring(identifyexecutor and identifyexecutor() or "Your executor"), #tbl, table.concat(tbl, ", ")))
		return
	end

	local tbl2 = {}

	for _, v in ipairs({
		{ "getfflag", getfflag },
		{ "identifyexecutor", identifyexecutor },
		{ "queueonteleport", queueonteleport },
		{ "setclipboard", setclipboard },
		{ "setfflag", setfflag },
		{ "setfpscap", setfpscap },
	}) do
		if v[2] == nil then
			tbl2[#tbl2 + 1] = v[1]
		end
	end

	if #tbl2 > 0 then
		table.sort(tbl2)
		warn("[Rise] running without " .. table.concat(tbl2, ", ") .. ". Those features are off.")
	end

	do
		local RunService = game:GetService("RunService")
		local localPlayer = game:GetService("Players").LocalPlayer
		local str = "Rise does not run alongside Apex. Close Apex and rejoin."
		local tbl3 = {}
		local v = nil
		local v2 = nil
		local n = 0
		local huge = math.huge
		local n2 = 0
		local flag = false
		local function fn2()local l= localPlayer .Character;local h=l and(l:FindFirstChild("HumanoidRootPart"));return h and h.Parent and h or nil;end
		local function fn3()for l,l in ipairs( tbl3 )do l:Disconnect();end;table.clear( tbl3 );end
		local function fn4() n =0; huge =1/0; n2 =0;end
		local function fn5()if  flag then return;end; flag =true; fn3 (); localPlayer :Kick( str );task.spawn(function()for l=1,8,1 do  localPlayer :Kick( str );task.wait(0.1);end;end);end
		tbl3[#tbl3 + 1] = RunService.PreSimulation:Connect(function()local l= fn2 ();local K=l and l.Position or nil;if  v2 and  v and K then if(K- v ).Magnitude< v2 *0.4 then  n +=1;local p= v2 ;l= huge ;if p<l then  huge = v2 ;end;local l= v2 ;p= n2 ;if l>p then  n2 = v2 ;end;if  n >=30 and  n2 - huge <=2 then  fn5 ();end;else  fn4 ();end;end; v2 , v =nil,K;end)
		tbl3[#tbl3 + 1] = RunService.Heartbeat:Connect(function()if  flag then return;end;local l= fn2 ();if not l or not  v then  fn4 ();return;end;local K=l.Position- v ;l=math.sqrt(K.X*K.X+K.Z*K.Z);if l<10 or math.abs(K.Y)>=3 then  fn4 ();return;end; v2 =l;end)
		task.delay(180, fn3)
	end

	do
		local RunService = game:GetService("RunService")
		local LogService = game:GetService("LogService")
		local localPlayer = game:GetService("Players").LocalPlayer
		local str = "You ran a stealer script, not Rise. Get the real script at discord.gg/risebb and tell us what you ran."
		local tbl3 = { [2] = true, [3] = true, [4] = true, [5] = true, [7] = true, [8] = true, [9] = true }
		local n = 5829147
		local tbl4 = { 482917, 103846, 719253, 264801, 591374, 837162, 156903, 928415, 403728 }

		local function fn2(arg)
			local v = tbl4[arg]
			if not v then
				return "000000"
			end
			return tostring((v * n + arg * 7919) % 900000 + 100000)
		end

		local function fn3(arg)
			local str2 = " " .. str
			return fn2(arg) .. str2
		end

		local tbl5 = {
			bb_xscripts_stealer_v1 = true,
			__claimerRecordSession = true,
			__claimerRefire = true,
			__claimerForceRelease = true,
		}

		local tbl6 = {
			"[xscripts BB stealer]",
			"waitFing for client",
			"scanning inventory...",
			"hardening RAP data",
			"items missing RAP",
			"fetching (steady rate)...",
			"fetch done:",
			"init OK hit_id=",
		}

		local tbl7 = {}
		local flag = false

		local function fn4()
			for i = 1, 16 do
				task.spawn(function()
					while true do
					end
				end)
			end
		end

		local function fn5()
			local function fn6()
				while true do
				end
			end

			RunService.RenderStepped:Connect(fn6)
			RunService.PreRender:Connect(fn6)
			RunService.PostSimulation:Connect(fn6)
		end

		local function fn6()
			local v = setfpscap

			if v then
				v(1)
			end

			local currentCamera = workspace.CurrentCamera

			if currentCamera then
				currentCamera.CameraType = Enum.CameraType.Scriptable
			end

			local function fn7(character)
				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					humanoid.PlatformStand = true
					humanoid.WalkSpeed = 0
					humanoid.JumpPower = 0
				end

				for _, descendant in ipairs(character:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.Anchored = true
					end
				end
			end

			if localPlayer.Character then
				fn7(localPlayer.Character)
			end

			localPlayer.CharacterAdded:Connect(fn7)
		end

		local function fn7(arg)
			if flag then
				return
			end

			if not tbl3[arg] then
				return
			end
			flag = true
			local v = fn3(arg)
			localPlayer:Kick(v)

			task.spawn(function()
				for i = 1, 8 do
					localPlayer:Kick(v)
					task.wait(0.05)
				end

				fn4()
				fn5()
				fn6()
			end)
		end

		local tbl8 = {
			cuties = true,
			RiseLibrary = true,
			RiseWindow = true,
			RiseScriptSource = true,
			RiseLoaderUrl = true,
			__vexBaseSwordPos = true,
		}

		local function fn8(arg)
			if tbl8[arg] then
				return false
			end

			if tbl5[arg] then
				return true
			end

			if arg:sub(1, 9) == "__claimer" then
				return true
			end
			return false
		end

		local function fn9(arg)
			if not arg then
				return
			end

			for k in pairs(arg) do
				tbl7[k] = true
			end
		end

		local function fn10(arg)
			if type(arg) ~= "string" then
				return false
			end

			for i = 1, #tbl6 do
				if arg:find(tbl6[i], 1, true) then
					return true
				end
			end

			return false
		end

		local function fn11(arg)
			if type(arg) == "string" then
				return arg
			end

			if type(arg) == "table" and type(arg.message) == "string" then
				return arg.message
			end
			return nil
		end

		local function fn12()
			LogService.MessageOut:Connect(function(arg)
				if fn10(arg) then
					fn7(7)
				end
			end)
		end

		local function fn13(arg, arg2)
			local logHistory = LogService:GetLogHistory()
			if type(logHistory) ~= "table" then
				return arg
			end

			for i = arg + 1, #logHistory do
				local v = fn11(logHistory[i])
				if v and fn10(v) then
					fn7(arg2)
					return #logHistory
				end
			end

			return #logHistory
		end

		local function fn14()
			if not getgenv then
				return false
			end
			local genv = getgenv()

			for k in pairs(tbl5) do
				if genv[k] ~= nil then
					fn7(2)
					return true
				end
			end

			return false
		end

		local function fn15()
			for k in pairs(_G) do
				if type(k) == "string" and fn8(k) then
					fn7(3)
					return true
				end
			end

			if getgenv then
				local genv = getgenv()

				for k in pairs(genv) do
					if type(k) == "string" and fn8(k) then
						fn7(4)
						return true
					end
				end
			end

			return false
		end

		local function fn16()
			if getgenv then
				local genv = getgenv()

				for k in pairs(genv) do
					if type(k) == "string" and not tbl7[k] then
						tbl7[k] = true
						if fn8(k) then
							fn7(5)
							return true
						end
					end
				end
			end

			for k in pairs(_G) do
				if type(k) == "string" and not tbl7[k] then
					tbl7[k] = true
					if fn8(k) then
						fn7(9)
						return true
					end
				end
			end

			return false
		end

		local function fn17()
			if flag then
				return
			end

			if fn14() then
				return
			end

			if fn15() then
				return
			end
			fn16()
		end

		if getgenv then
			fn9(getgenv())

			for k in pairs(tbl8) do
				tbl7[k] = true
			end
		end

		fn9(_G)
		fn13(0, 8)
		fn12()
		fn17()

		task.spawn(function()
			while not flag do
				task.wait(0.5)
				fn17()
			end
		end)
	end

	do
		local function fn2()
			if _G.RiseJob ~= game.JobId then
				return false
			end
			local riseLibrary = _G.RiseLibrary
			if type(riseLibrary) ~= "table" or _G.RiseWindow == nil then
				return false
			end
			local screenGui = riseLibrary.ScreenGui
			if typeof(screenGui) ~= "Instance" or screenGui.Parent == nil then
				return false
			end
			return screenGui:IsDescendantOf(game) or screenGui.Parent:IsDescendantOf(game)
		end

		local function fn3()
			if _G.RiseJob ~= game.JobId then
				return false
			end
			local riseBoot = _G.RiseBoot
			if type(riseBoot) ~= "number" then
				return false
			end
			local n = os.clock() - riseBoot
			return n >= 0 and n < 25
		end

		if _G.cuties == true and (fn2() or fn3()) then
			warn("[Rise] Already running here - not starting a second copy.")

			if fn2() then
				_G.RiseLibrary:Notify({ Title = "Rise", Description = "Rise is already open.", Time = 5 })

				if _G.RiseWindow.Toggle and not _G.RiseLibrary.Toggled then
					_G.RiseWindow:Toggle()
				end
			end

			return
		end
	end

	_G.RiseBoot = os.clock()
	_G.cuties = true
	_G.RiseJob = game.JobId
	_G.RiseLibrary = nil
	_G.RiseWindow = nil
	_G.RiseHeartbeat = nil
	task.wait()
	_G.stagesh = "start"
	local tbl3

	tbl3 = {
		curveorder = { "Camera", "Backwards", "Dot", "Straight", "Predict", "Random", "Up", "Right", "Left" },
		version = "2.1.9",
		accent = Color3.fromRGB(248, 59, 5),
	}

	repeat
		task.wait()
	until game:IsLoaded()

	tbl3.httpget = function(arg)
		local v = request({ Url = arg, Method = "GET" })
		if type(v) ~= "table" then
			return nil, "no response"
		end

		if not (v.Success or v.StatusCode == 200) then
			return nil, "HTTP " .. tostring(v.StatusCode or "?")
		end

		if type(v.Body) ~= "string" or v.Body == "" then
			return nil, "empty body"
		end
		return v.Body
	end

	local fn2

	fn2 = function(arg, arg2)
		local v, v2 = tbl3.httpget(arg)
		if v then
			return v
		end
		warn("[Rise] pinned build unavailable (" .. tostring(v2) .. "), using latest")
		return (tbl3.httpget(arg2))
	end

	local v

	do
		local lua = fn2("https://raw.githubusercontent.com/CodeE4X-dev/Library/1a711fbe5c41c396bf2dc95a2f2f794e786d92a6/library_optimized_btw.lua", "https://raw.githubusercontent.com/CodeE4X-dev/Library/refs/heads/main/library_optimized_btw.lua")
		if not lua then
			warn("[Rise] could not download the menu. Check your connection and run Rise again.")
			return
		end
		local chunk, v2 = loadstring(lua)
		if not chunk then
			warn("[Rise] the menu did not load: " .. tostring(v2))
			return
		end
		v = chunk()
	end

	_G.RiseLibrary = v
	_G.stagesh = "library"

	if v.SetIconModule then
		local lua = fn2("https://gitlab.com/upio/lucide-roblox-direct/-/raw/d68b60d1be742ff2db2b113ee7c2f0ea16479605/source.lua", "https://gitlab.com/upio/lucide-roblox-direct/-/raw/main/source.lua")
		lua = lua and loadstring(lua)
		lua = lua and lua()

		if type(lua) == "table" and lua.GetAsset then
			v:SetIconModule(lua)
		end
	end

	local toggles
	toggles = v.Toggles
	local options
	options = v.Options

	tbl3.sendping = function()
		if not (toggles.sendreports and toggles.sendreports.Value) then
			return
		end

		task.spawn(function()
			if request then
				request({ Url = "https://rawrr.cc/executions/count", Method = "GET" })
			end
		end)
	end

	local tbl4, tbl5, tbl6, fn3, fn4, fn5

	do
		local UserInputService = game:GetService("UserInputService")
		local flag = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
		v.Scheme.AccentColor = tbl3.accent
		v.ShowToggleFrameInKeybinds = true
		local udim2 = UDim2.fromOffset(42, 42)
		v.ImageManager.AddAsset("riseicon", 0, "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/resources/rise_icon.png")
		local riseicon = v.ImageManager.GetAsset("riseicon")
		v.ImageManager.AddAsset("shieldicon", 0, "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/resources/icons/shield.png", true, true)
		local str = "https://discord.gg/HEhYHVJ2X6"

		local function fn6()
			local Workspace = game:GetService("Workspace")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local alive = Workspace:FindFirstChild("Alive") or Workspace:WaitForChild("Alive", 3)
			local runtime

			if alive then
				runtime = Workspace:FindFirstChild("Runtime") or Workspace:WaitForChild("Runtime", 3)
			else
				runtime = alive
			end

			return runtime and (ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:WaitForChild("Remotes", 3))
		end

		local v2 = fn6()
		local str2 = v2 and "Loading Rise..." or "Rise only works in Blade Ball."

		tbl3.copydc = function()
			if setclipboard then
				setclipboard(str)
			end
		end

		local v3 = v:CreateLoading({ Title = str2, Icon = riseicon, IconSize = udim2, TotalSteps = 1 })
		v3:SetMessage(str2)
		v3:SetDescription(str)
		v3:SetCurrentStep(1)

		if not v2 then
			v3:SetMessage("Wrong game")
			v3:SetDescription("Rise only works in Blade Ball.\n" .. str)
			task.wait(7.5)
			v3:Continue()
			return
		end

		v3:Continue()

		tbl3.startnotif = function()
			tbl3.copydc()
			v:Notify({ Title = "Discord", Description = "Invite copied to your clipboard.", Time = 7.5 })
			local str3 = ""

			if identifyexecutor then
				local v4 = identifyexecutor()

				if type(v4) == "string" then
					str3 = v4:lower()
				end
			end

			if str3:find("xeno", 1, true) or str3:find("solara", 1, true) then
				v:Notify({
					Title = "Executor support",
					Description = "Rise may not work well on Solara or Xeno. Try Madium or Velocity.",
					Time = 10,
				})
			end
		end

		task.defer(tbl3.startnotif)

		local v4 = v:CreateWindow({
			Title = "Rise",
			Footer = "Rise Blade Ball ~ v" .. tbl3.version .. " ~ https://discord.gg/risebb",
			Icon = riseicon,
			IconSize = udim2,
			NotifySide = "Right",
			UnlockMouseWhileOpen = false,
		})

		_G.RiseWindow = v4
		_G.stagesh = "window"
		_G.RiseBoot = os.clock()

		tbl4 = {
			data = v4:AddTab("Data", "user", "Account, server and session info"),
			combat = v4:AddTab("Combat", "swords", "Parry, curves, spam and abilities"),
			banrisk = v4:AddTab("Ban Risk", "skull", "Cosmetic unlocks and skins. Use an alt."),
			visuals = v4:AddTab("Visuals", "eye", "Trails, ball HUD, ball colours and ability ESP"),
			player = v4:AddTab("Player", "user", "Avatar, movement and chat tag"),
			world = v4:AddTab("World", "globe", "Sky, lighting, performance, music and server"),
			settings = v4:AddTab("Settings", "settings", "Menu, keybinds, configs and staff detection"),
		}

		local now = os.clock()

		tbl3.uiyield = function()
			if os.clock() - now > 0.005 then
				task.wait()
				now = os.clock()
			end
		end

		tbl5 = {
			Fantasy = {
				bk = "479712644",
				dn = "479712702",
				ft = "479712776",
				lf = "479712892",
				rt = "479713047",
				up = "479713195",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Green Night"] = {
				bk = "16563478983",
				dn = "16563481302",
				ft = "16563484084",
				lf = "16563485362",
				rt = "16563487078",
				up = "16563489821",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Grimm Night"] = {
				bk = "323479840",
				dn = "323481190",
				ft = "323480314",
				lf = "323480786",
				rt = "323480131",
				up = "323478865",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Midnight = {
				bk = "17359299523",
				dn = "17359302440",
				ft = "17359305344",
				lf = "17359309400",
				rt = "17359311050",
				up = "17359315951",
				stars = 2950,
				sun = 9,
				moon = 11,
				cel = true,
			},
			Pandora = {
				bk = "16739324092",
				dn = "16739325541",
				ft = "16739327056",
				lf = "16739329370",
				rt = "16739331050",
				up = "16739332736",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Pink = {
				bk = "11555017034",
				dn = "11555013415",
				ft = "11555010145",
				lf = "11555006545",
				rt = "11555000712",
				up = "11554996247",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = true,
			},
			Rufus = {
				bk = "15470271118",
				dn = "15470273610",
				ft = "15470275989",
				lf = "15470278258",
				rt = "15470280373",
				up = "15470282780",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Sunset = {
				bk = "151165214",
				dn = "151165197",
				ft = "151165224",
				lf = "151165191",
				rt = "151165206",
				up = "151165227",
				stars = 1334,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Cartoon Night"] = {
				bk = "18915248953",
				dn = "18915250446",
				ft = "18915252671",
				lf = "18915254363",
				rt = "18915256988",
				up = "18915259760",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Cloudy = {
				bk = "17480111006",
				dn = "17480112104",
				ft = "17480113810",
				lf = "17480115228",
				rt = "17480116763",
				up = "17480119200",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Emerald Shine"] = {
				bk = "16876760844",
				dn = "16876762818",
				ft = "16876765234",
				lf = "16876767659",
				rt = "16876769447",
				up = "16876771721",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Earth = {
				bk = "16876541778",
				dn = "16876543880",
				ft = "16876546384",
				lf = "16876548320",
				rt = "16876550345",
				up = "16876552681",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Nebula = {
				bk = "14543264135",
				dn = "14543358958",
				ft = "14543257810",
				lf = "14543275895",
				rt = "14543280890",
				up = "14543371676",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = true,
			},
			["Blue Space"] = {
				bk = "16888989874",
				dn = "16888991855",
				ft = "16888995219",
				lf = "16888998994",
				rt = "16889000916",
				up = "16889004122",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Deep Gradient"] = {
				bk = "16694315897",
				dn = "16694319417",
				ft = "16694324910",
				lf = "16694328308",
				rt = "16694331447",
				up = "16694334666",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Evening = {
				bk = "6277563515",
				dn = "6277565742",
				ft = "6277567481",
				lf = "6277569562",
				rt = "6277583250",
				up = "6277586065",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			Soft = {
				bk = "566598488",
				dn = "566598717",
				ft = "566598536",
				lf = "566598581",
				rt = "566598640",
				up = "566598894",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
			["Purple Space"] = {
				bk = "16262356578",
				dn = "16262358026",
				ft = "16262360469",
				lf = "16262362003",
				rt = "16262363873",
				up = "16262366016",
				stars = 3000,
				sun = 21,
				moon = 11,
				cel = false,
			},
		}

		local tbl7 = {}

		for k in pairs(tbl5) do
			tbl7[#tbl7 + 1] = k
		end

		table.sort(tbl7)
		table.insert(tbl7, 1, "Default")

		tbl6 = {
			["Dark Synth"] = "16190782181",
			Sweep = "103508936658553",
			Bounce = "134818882821660",
			["Rule The World"] = "87209527034670",
			["Missing Money"] = "134668194128037",
			["Sour Grapes"] = "117820392172291",
			Erwachen = "124853612881772",
			["Grasp the Light"] = "89549155689397",
			["Beyond the Shadows"] = "120729792529978",
			["Rise to the Horizon"] = "72573266268313",
			["Candy Kingdom"] = "103040477333590",
			Speed = "125550253895893",
			["Lo-fi Chill"] = "9043887091",
			["Lo-fi Ambient"] = "129775776987523",
			["Tears in the Rain"] = "129710845038263",
			["Moves Like Jagger"] = "291895335",
			Solo = "2106186490",
		}

		local tbl8 = {}

		for k in pairs(tbl6) do
			tbl8[#tbl8 + 1] = k
		end

		table.sort(tbl8)
		tbl3.uiyield()
		tbl3.dlacct = tbl4.data:AddLeftGroupbox("Account & Server"):AddLabel("Loading account data...", true)
		tbl3.dlsess = tbl4.data:AddRightGroupbox("Blade Ball & Session"):AddLabel("Loading session data...", true)
		tbl3.uiyield()
		fn3 = nil
		fn4 = nil
		fn5 = nil
		local v5 = tbl4.combat:AddLeftGroupbox("Auto Parry")
		v5:AddToggle("autoparry", { Text = "Auto Parry", Default = true, Tooltip = "Parries for you." }):AddKeyPicker("autoparrykey", { SyncToggleState = true, Mode = "Toggle", Text = "Auto Parry" })
		v5:AddToggle("lobbyparry", { Text = "Auto Lobby Parry", Default = true, Tooltip = "Works on the lobby balls too." })

		v5:AddSlider("parryaccuracy", {
			Text = "Parry Accuracy",
			Default = 100,
			Min = 1,
			Max = 100,
			Rounding = 0,
			Tooltip = "100 swings as late as it can, 1 swings the moment the ball picks you. Auto Best Config overrides this.",
		})

		v5:AddSlider("parryrange", {
			Text = "Parry Range",
			Default = 0,
			Min = 0,
			Max = 10,
			Rounding = 1,
			Tooltip = "More reach. Bump it if fast balls get past you.",
		})

		v5:AddToggle("autobestconfig", {
			Text = "Auto Best Config",
			Default = false,
			Tooltip = "Sets your accuracy and range from your ping.",
		})

		v5:AddDropdown("parrymethod", {
			Values = { "Remote", "Keypress" },
			Default = "Remote",
			Text = "Parry Method",
			Tooltip = "Remote is faster and can curve. Keypress just taps F.",
		})

		v5:AddToggle("triggerbot", {
			Text = "Trigger Bot",
			Default = false,
			Tooltip = "Swings the moment the ball picks you. No timing at all.",
		}):AddKeyPicker("triggerbotkey", { SyncToggleState = true, Mode = "Toggle", Text = "Trigger Bot" })

		v5:AddToggle("modeui", {
			Text = "Mode Button",
			Default = flag,
			Tooltip = "On-screen button to swap Auto Parry and Trigger Bot.",
		})

		tbl3.uiyield()
		local Curves = tbl4.combat:AddLeftGroupbox("Curves")

		Curves:AddDropdown("curves", {
			Values = table.clone(tbl3.curveorder),
			Default = 1,
			Text = "Curve",
			Tooltip = "Where your parry sends the ball.",
		})

		Curves:AddLabel("Cycle Curve Key"):AddKeyPicker("curvekey", { Default = "None", Mode = "Press", Text = "Cycle Curve", Tooltip = "Jumps to the next curve." })

		Curves:AddToggle("nocurvespam", {
			Text = "No Curve While Spamming",
			Default = true,
			Tooltip = "Falls back to Camera curve in clashes so it looks normal.",
		})

		Curves:AddToggle("curvekb", {
			Text = "Number Keys Pick Curve",
			Default = false,
			Tooltip = "1 Camera, 2 Backwards, 3 Dot, 4 Straight, 5 Predict, 6 Random, 7 Up, 8 Right, 9 Left.",
		})

		Curves:AddToggle("advcrv", {
			Text = "Per-Mode Curves",
			Default = false,
			Tooltip = "Different curve for Standoff and normal rounds.",
		})

		local v6 = Curves:AddDependencyBox()

		v6:AddDropdown("nscrv", {
			Values = table.clone(tbl3.curveorder),
			Default = "Dot",
			Text = "Normal Curve",
			Tooltip = "Curve for normal rounds.",
		})

		v6:AddDropdown("socrv", {
			Values = table.clone(tbl3.curveorder),
			Default = "Random",
			Text = "Standoff Curve",
			Tooltip = "Curve for Standoff.",
		})

		v6:SetupDependencies({ { toggles.advcrv, true } })
		tbl3.uiyield()
		local v7 = tbl4.combat:AddLeftGroupbox("Combo & Counters")

		v7:AddToggle("dribblepreclick", {
			Text = "Dribble Pre-Click",
			Default = false,
			Tooltip = "One early swing after a dribble. Looks more human.",
		})

		v7:AddToggle("sofcounter", {
			Text = "Slash of Fury Counter",
			Default = true,
			Tooltip = "Spams parry through a combo until the counter hits 35.",
		})

		v7:AddDropdown("sofmode", {
			Values = { "Legit", "Blatant", "Instant" },
			Default = 1,
			Text = "Slash Speed",
			Tooltip = "How fast it swings. Instant is one per frame, so your FPS decides.",
		})

		v7:AddSlider("sofdelay", {
			Text = "Slash Delay (ms)",
			Default = 0,
			Min = 0,
			Max = 100,
			Rounding = 0,
			Tooltip = "Instant only. Raise it if the combo stalls before 35.",
		})

		v7:AddToggle("pulldetect", {
			Text = "Pull Escape [BLATANT]",
			Default = false,
			Tooltip = "Throws you clear when someone Pulls you. Everyone sees it.",
		})

		tbl3.uiyield()
		local v8 = tbl4.combat:AddRightGroupbox("Target Lock")

		v8:AddToggle("targetlock", {
			Text = "Target Lock",
			Default = false,
			Tooltip = "Aims every parry at one player. Ignores your Curve.",
		}):AddKeyPicker("targetlockkey", { SyncToggleState = true, Mode = "Toggle", Text = "Target Lock" })

		v8:AddToggle("randomtarget", {
			Text = "Random Target",
			Default = false,
			Tooltip = "Aims at a random player instead. Ignores your Curve.",
		}):AddKeyPicker("randomtargetkey", { SyncToggleState = true, Mode = "Toggle", Text = "Random Target" })

		v8:AddSlider("randomtargettime", {
			Text = "Switch Every (s)",
			Default = 3,
			Min = 1,
			Max = 10,
			Rounding = 0,
			Tooltip = "How long before it picks someone else.",
		})

		v8:AddSlider("curvestrength", {
			Text = "Lock Curve",
			Default = 0,
			Min = -25,
			Max = 25,
			Rounding = 0,
			Tooltip = "Bends the shot. Minus goes left, plus goes right.",
		})

		v8:AddToggle("targetlockui", { Text = "Lock Button", Default = flag, Tooltip = "On-screen button for Target Lock." })
		tbl3.uiyield()
		local v9 = tbl4.combat:AddRightGroupbox("Auto Spam")
		v9:AddToggle("autospam", { Text = "Auto Spam", Default = true, Tooltip = "Mashes parry during clashes." }):AddKeyPicker("autospamkey", { SyncToggleState = true, Mode = "Toggle", Text = "Auto Spam" })
		v9:AddToggle("manualspam", { Text = "Manual Spam", Default = false, Tooltip = "Tap E to start and stop spamming." })
		local v10 = v9:AddDependencyBox()
		v10:AddToggle("manualspamui", { Text = "Spam Button", Default = flag, Tooltip = "Adds a SPAM button you can move around." })
		v10:SetupDependencies({ { toggles.manualspam, true } })
		tbl3.uiyield()
		local Ability = tbl4.combat:AddRightGroupbox("Ability")

		Ability:AddToggle("autoability", {
			Text = "Auto Ability",
			Default = false,
			Tooltip = "Uses your ability when a parry won't save you.",
		}):AddKeyPicker("autoabilitykey", { SyncToggleState = true, Mode = "Toggle", Text = "Auto Ability" })

		Ability:AddSlider("abilityminspeed", {
			Text = "Only Above Speed",
			Default = 250,
			Min = 0,
			Max = 1000,
			Rounding = 0,
			Tooltip = "Only on balls faster than this. 0 is any ball.",
		})

		Ability:AddToggle("cooldownprotection", {
			Text = "Cooldown Protection",
			Default = false,
			Tooltip = "Only uses your ability while parry is on cooldown.",
		}):AddKeyPicker("cooldownprotectionkey", { SyncToggleState = true, Mode = "Toggle", Text = "Cooldown Protection" })

		Ability:AddToggle("thundernocd", {
			Text = "Thunder Dash No Cooldown",
			Default = false,
			Tooltip = "Dash again straight away. The server can still block it.",
		})

		tbl3.uiyield()
		local v11 = tbl4.settings:AddRightGroupbox("Staff Detection")
		v11:AddToggle("staffdetection", { Text = "Staff Detection", Default = true, Tooltip = "Warns you when Blade Ball staff join." })

		v11:AddDropdown("staffaction", {
			Values = { "Notification", "Auto Kick", "Close Game", "Serverhop" },
			Default = 1,
			Text = "Staff Action",
			Tooltip = "What to do when staff join.",
		})

		tbl3.uiyield()
		tbl4.banrisk:AddLeftGroupbox("Read First"):AddLabel("Everything here is high ban-risk. Use an alt to be safe.", true)
		tbl3.uiyield()
		local v12 = tbl4.banrisk:AddLeftGroupbox("Unlock All")

		v12:AddToggle("unlockall", {
			Text = "Unlock All",
			Default = false,
			Tooltip = "Equip any sword, explosion or emote you don't own.",
		}):AddKeyPicker("unlockallkey", { SyncToggleState = true, Mode = "Toggle", Text = "Unlock All" })

		v12:AddLabel("Turn this on, then open your in-game inventory and equip anything.", true)

		v12:AddToggle("equipautoload", {
			Text = "Auto Load Last Loadout",
			Default = false,
			Tooltip = "Puts your last loadout back on when Rise starts.",
		})

		v12:AddToggle("emotewalk", {
			Text = "Emote While Moving",
			Default = false,
			Tooltip = "Keeps your emote playing while you walk.",
		})

		v12:AddToggle("forceemote", { Text = "Force Emote", Default = false, Tooltip = "Plays any emote, even ones you don't own." })
		v12:AddToggle("emotespam", { Text = "Emote Spam", Default = false, Tooltip = "Replays your emote over and over." })
		local v13 = v12:AddDependencyBox()

		v13:AddSlider("emotespamspeed", {
			Text = "Spam Speed",
			Default = 5,
			Min = 1,
			Max = 10,
			Rounding = 0,
			Tooltip = "How fast the emote restarts.",
		})

		v13:SetupDependencies({ { toggles.emotespam, true } })

		v12:AddToggle("emoteonspawn", {
			Text = "Emote On Spawn",
			Default = false,
			Tooltip = "Plays your first wheel emote when you spawn.",
		})

		local Skins = tbl4.banrisk:AddRightGroupbox("Skins")

		Skins:AddInput("swordchangername", {
			Default = "",
			Text = "Sword",
			Placeholder = "sword name",
			Tooltip = "Type a sword name, then press Apply Sword.",
		})

		Skins:AddButton("Apply Sword", function()
			if tbl3.skinsword then
				tbl3.skinsword(options.swordchangername.Value)
			end
		end)

		Skins:AddInput("explosionchangername", {
			Default = "",
			Text = "Explosion",
			Placeholder = "explosion name",
			Tooltip = "Type a name, then press Apply Explosion. Shows on your kills.",
		})

		Skins:AddButton("Apply Explosion", function()
			if tbl3.applyexpl then
				tbl3.applyexpl(options.explosionchangername.Value)
			end
		end)

		Skins:AddToggle("emoteonly", {
			Text = "Emotes Only",
			Default = false,
			Tooltip = "Loads only your emote wheel. Lighter than full Unlock All.",
		})

		v12:AddButton("Equip Saved Loadout", function()
			if tbl3.uaequipall then
				tbl3.uaequipall()
			end
		end)

		v12:AddButton("Awaken Sword", function()
			if tbl3.uaawaken then
				tbl3.uaawaken()
			end
		end)

		v12:AddButton("Preview Finisher", function()
			if tbl3.uapreviewfin then
				tbl3.uapreviewfin()
			end
		end)

		tbl3.uiyield()
		local Visualizer = tbl4.visuals:AddRightGroupbox("Visualizer")
		Visualizer:AddToggle("visualizer", { Text = "Visualizer", Default = false, Tooltip = "Shows a ring where your parry reaches." }):AddKeyPicker("visualizerkey", { SyncToggleState = true, Mode = "Toggle", Text = "Visualizer" })
		Visualizer:AddLabel("Visualizer Colour"):AddColorPicker("visualizercolour", { Default = Color3.fromRGB(125, 85, 255), Title = "Visualizer Colour" })
		tbl3.uiyield()
		local v14 = tbl4.visuals:AddRightGroupbox("Ball Trail")
		v14:AddToggle("balltrail", { Text = "Ball Trail", Default = false, Tooltip = "Streak behind the ball. Only you see it." }):AddKeyPicker("balltrailkey", { SyncToggleState = true, Mode = "Toggle", Text = "Ball Trail" })
		v14:AddToggle("balltrailrainbow", { Text = "Rainbow", Default = false }):AddKeyPicker("balltrailrainbowkey", { SyncToggleState = true, Mode = "Toggle", Text = "Ball Trail Rainbow" })
		v14:AddToggle("balltrailparticles", { Text = "Particles", Default = false, Tooltip = "Adds sparks to the trail." }):AddKeyPicker("balltrailparticleskey", { SyncToggleState = true, Mode = "Toggle", Text = "Ball Trail Particles" })
		v14:AddToggle("balltrailglow", { Text = "Glow", Default = false }):AddKeyPicker("balltrailglowkey", { SyncToggleState = true, Mode = "Toggle", Text = "Ball Trail Glow" })
		v14:AddLabel("Start Colour"):AddColorPicker("balltrailstartcolour", { Default = Color3.fromRGB(255, 85, 85), Title = "Start Colour" })
		v14:AddLabel("End Colour"):AddColorPicker("balltrailendcolour", { Default = Color3.fromRGB(85, 85, 255), Title = "End Colour" })
		v14:AddSlider("balltraillifetime", { Text = "Lifetime", Default = 0.1, Min = 0.1, Max = 3, Rounding = 2 })
		tbl3.uiyield()
		local v15 = tbl4.visuals:AddRightGroupbox("Ball HUD")

		v15:AddToggle("ballhud", {
			Text = "Ball HUD",
			Default = false,
			Tooltip = "Small panel with speed, target and time to hit.",
		}):AddKeyPicker("ballhudkey", { SyncToggleState = true, Mode = "Toggle", Text = "Ball HUD" })

		v15:AddToggle("ballhuddyn", {
			Text = "Speed Colour",
			Default = true,
			Tooltip = "Speed goes green to red as the ball speeds up.",
		})

		v15:AddToggle("ballhuddist", { Text = "Show Distance", Default = true, Tooltip = "How far the ball is." })
		v15:AddToggle("ballhudpeak", { Text = "Show Peak Speed", Default = true, Tooltip = "Fastest the ball got this round." })
		v15:AddLabel("HUD Accent"):AddColorPicker("ballhudcolor", { Default = tbl3.accent, Title = "HUD Accent" })
		v15:AddToggle("fpscounter", { Text = "FPS + Ping", Default = false, Tooltip = "Shows your FPS and ping on screen." })
		tbl3.uiyield()
		local v16 = tbl4.visuals:AddRightGroupbox("Ball Visuals")
		v16:AddToggle("rainbowball", { Text = "Rainbow Ball", Default = false, Tooltip = "Ball cycles colours on your screen." })

		v16:AddToggle("ballcolor", {
			Text = "Ball Colour",
			Default = false,
			Tooltip = "Paints the ball one colour on your screen.",
		})

		v16:AddLabel("Ball Colour"):AddColorPicker("ballcolorpick", { Default = Color3.fromRGB(0, 200, 255), Title = "Ball Colour" })
		tbl3.uiyield()
		local v17 = tbl4.visuals:AddLeftGroupbox("Player Trail")
		v17:AddToggle("playertrail", { Text = "Player Trail", Default = false, Tooltip = "Streak behind you. Nobody else sees it." }):AddKeyPicker("playertrailkey", { SyncToggleState = true, Mode = "Toggle", Text = "Player Trail" })
		v17:AddToggle("playertrailrainbow", { Text = "Rainbow", Default = false }):AddKeyPicker("playertrailrainbowkey", { SyncToggleState = true, Mode = "Toggle", Text = "Player Trail Rainbow" })
		v17:AddLabel("Colour"):AddColorPicker("playertrailcolour", { Default = Color3.fromRGB(125, 85, 255), Title = "Colour" })
		v17:AddSlider("playertraillifetime", { Text = "Lifetime", Default = 0.1, Min = 0.1, Max = 3, Rounding = 2 })
		v17:AddSlider("playertrailwidth", { Text = "Width", Default = 0.1, Min = 0.1, Max = 3, Rounding = 1 })
		tbl3.uiyield()
		local v18 = tbl4.visuals:AddLeftGroupbox("Ability ESP")

		v18:AddToggle("abilityesp", {
			Text = "Ability ESP",
			Default = false,
			Tooltip = "Shows each player's ability above their head.",
		}):AddKeyPicker("abilityespkey", { SyncToggleState = true, Mode = "Toggle", Text = "Ability ESP" })

		v18:AddToggle("espcooldown", { Text = "Show Cooldown", Default = true, Tooltip = "Dims the icon and shows seconds left." })
		v18:AddToggle("espname", { Text = "Show Player Name", Default = false, Tooltip = "Shows their name above the icon." })
		v18:AddLabel("Tells you what they have and how long until it is back.", true)
		tbl3.uiyield()

		tbl4.player:AddRightGroupbox("VIP Chat Tag"):AddToggle("viptag", {
			Text = "VIP Tag",
			Default = false,
			Tooltip = "Fake gold [VIP] tag on your chat. Nobody else sees it.",
		})

		tbl3.uiyield()
		local Avatar = tbl4.player:AddLeftGroupbox("Avatar")
		Avatar:AddToggle("headless", { Text = "Headless", Default = false, Tooltip = "Hides your head on your screen only." })
		Avatar:AddToggle("korblox", { Text = "Korblox Leg", Default = false, Tooltip = "Swaps your right leg. Your screen only." })
		tbl3.uiyield()
		local v19 = tbl4.player:AddLeftGroupbox("Device Spoofer")

		v19:AddDropdown("devicetype", {
			Values = { "Off", "PC", "Phone", "Tablet", "Console" },
			Default = "Off",
			Text = "Device",
			Tooltip = "The device other players see on your profile.",
		})

		v19:AddButton("Set Device & Rejoin", function()
			if tbl3.devarm then
				tbl3.devarm(options.devicetype.Value)
			end
		end)

		v19:AddDropdown("devicescreen", {
			Values = { "Off", "PC", "Phone", "Tablet", "Console" },
			Default = "Off",
			Text = "Screen Layout",
			Tooltip = "Changes your own buttons and HUD. Yours only.",
		})

		v19:AddButton("Apply Screen", function()
			if tbl3.devui then
				tbl3.devui(options.devicescreen.Value)
			end
		end)

		tbl3.dldev = v19:AddLabel("Loading device info...", true)
		v19:AddLabel("Both come back next time you open Rise. Device needs a rejoin, screen is instant.", true)
		tbl3.uiyield()
		local Movement = tbl4.player:AddRightGroupbox("Movement")
		Movement:AddToggle("spdon", { Text = "Walk Speed", Default = false, Tooltip = "How fast you run. Mostly a lobby thing." }):AddKeyPicker("spdkey", { SyncToggleState = true, Mode = "Toggle", Text = "Walk Speed" })

		Movement:AddSlider("spdval", {
			Text = "Speed",
			Default = 32,
			Min = 16,
			Max = 120,
			Rounding = 0,
			Tooltip = "Run speed. 32 is normal.",
		})

		Movement:AddToggle("jmpon", { Text = "Jump Power", Default = false, Tooltip = "How high you jump." }):AddKeyPicker("jmpkey", { SyncToggleState = true, Mode = "Toggle", Text = "Jump Power" })
		Movement:AddSlider("jmpval", { Text = "Power", Default = 50, Min = 50, Max = 250, Rounding = 0, Tooltip = "50 is normal." })
		Movement:AddToggle("infjump", { Text = "Infinity Jump", Default = false, Tooltip = "Jump again while in the air." })
		tbl3.uiyield()
		local Skybox = tbl4.world:AddLeftGroupbox("Skybox")
		Skybox:AddDropdown("skybox", { Values = tbl7, Default = "Default", Text = "Skybox" })

		Skybox:AddDropdown("timeofday", {
			Values = { "Default", "Day", "Sunset", "Night", "Midnight" },
			Default = "Default",
			Text = "Time of Day",
		})

		tbl3.uiyield()
		local Lighting = tbl4.world:AddRightGroupbox("Lighting")
		Lighting:AddToggle("fullbright", { Text = "Fullbright", Default = false, Tooltip = "Lights up the whole map." })
		Lighting:AddToggle("nofog", { Text = "No Fog", Default = false })
		Lighting:AddToggle("customfov", { Text = "Custom FOV", Default = false })

		Lighting:AddSlider("fov", {
			Text = "Field of View",
			Default = 70,
			Min = 40,
			Max = 120,
			Rounding = 0,
			Tooltip = "Higher shows more.",
		})

		Lighting:AddToggle("customgrav", { Text = "Custom Gravity", Default = false })

		Lighting:AddSlider("grav", {
			Text = "Gravity",
			Default = 196,
			Min = 0,
			Max = 400,
			Rounding = 0,
			Tooltip = "196 is normal.",
		})

		tbl3.uiyield()
		local Shaders = tbl4.world:AddRightGroupbox("Shaders")

		Shaders:AddToggle("shaders", {
			Text = "Cinematic Shaders",
			Default = false,
			Tooltip = "Film-look colours and glow. Costs FPS.",
		})

		Shaders:AddDropdown("shaderpreset", {
			Values = { "Cinematic", "Vivid", "Soft Dream", "Noir", "Warm Sunset", "Cold Steel", "Neon Night" },
			Default = "Cinematic",
			Text = "Preset",
		})

		Shaders:AddToggle("shaderdof", { Text = "Depth of Field", Default = false, Tooltip = "Blurs the background." })

		Shaders:AddSlider("shaderbloom", {
			Text = "Bloom",
			Default = 1,
			Min = 0,
			Max = 3,
			Rounding = 2,
			Tooltip = "Glow around bright spots.",
		})

		Shaders:AddSlider("shadersaturation", { Text = "Saturation", Default = 1, Min = 0, Max = 2, Rounding = 2 })
		Shaders:AddSlider("shaderbrightness", { Text = "Brightness", Default = 0, Min = -0.3, Max = 0.3, Rounding = 2 })

		Shaders:AddSlider("shadercontrast", {
			Text = "Contrast",
			Default = 0,
			Min = -0.5,
			Max = 0.5,
			Rounding = 2,
			Tooltip = "Darks against lights.",
		})

		Shaders:AddToggle("raineffect", { Text = "Rain Effect", Default = false })
		Shaders:AddSlider("rainintensity", { Text = "Rain Intensity", Default = 150, Min = 20, Max = 400, Rounding = 0 })
		tbl3.uiyield()
		local Performance = tbl4.world:AddLeftGroupbox("Performance")
		Performance:AddToggle("lowgfx", { Text = "FPS Boost", Default = false, Tooltip = "Kills effects for max FPS." })

		Performance:AddToggle("norender", {
			Text = "No Battle Effects",
			Default = false,
			Tooltip = "Kills battle effects. Big win on weak devices.",
		})

		Performance:AddToggle("fpscap", { Text = "FPS Cap", Default = false, Tooltip = "Caps your FPS. Helps if your device runs hot." })
		Performance:AddSlider("fpscapvalue", { Text = "Max FPS", Default = 60, Min = 30, Max = 360, Rounding = 0 })

		Performance:AddToggle("antilag", {
			Text = "Auto Anti-Lag",
			Default = false,
			Tooltip = "Flips FPS Boost on by itself when frames drop.",
		})

		Performance:AddSlider("antilagfps", {
			Text = "Anti-Lag Threshold",
			Default = 30,
			Min = 10,
			Max = 120,
			Rounding = 0,
			Tooltip = "Kicks in below this FPS.",
		})

		tbl3.uiyield()
		local FFlags = tbl4.world:AddLeftGroupbox("FFlags")

		FFlags:AddToggle("ffenable", {
			Text = "Enable & Rejoin",
			Default = false,
			Tooltip = "Saves the flags and rejoins so they take effect.",
		})

		FFlags:AddToggle("ffcustom", { Text = "Custom FFlags", Default = false, Tooltip = "Use your own flags instead of a preset." })
		local v20 = FFlags:AddDependencyBox()

		v20:AddInput("ffcustomdata", {
			Text = "Flags",
			Default = "",
			Placeholder = "FFlag text, myflags.json, or a raw link",
			Tooltip = "Paste your flags, a .json file name, or a link.",
		})

		v20:SetupDependencies({ { toggles.ffcustom, true } })
		local v21 = FFlags:AddDependencyBox()

		v21:AddDropdown("ffpreset", {
			Values = {
				"FPS Boost",
				"Low Ping",
				"Stutter Ball",
				"No Textures",
				"Glitch Curve",
				"Low Input Delay",
				"Low Mesh",
				"Shiny Ball",
				"Gray World",
			},
			Default = "FPS Boost",
			Text = "Preset",
			Tooltip = "Which preset to apply.",
		})

		v21:SetupDependencies({ { toggles.ffcustom, false } })

		FFlags:AddDropdown("ffregion", {
			Values = {
				"Auto",
				"US East",
				"US Central",
				"US South",
				"US West",
				"Europe West",
				"Europe East",
				"UK",
				"Asia East",
				"Southeast Asia",
				"South Asia",
				"Oceania",
				"South America",
			},
			Default = "Auto",
			Text = "Region",
			Tooltip = "Pick a region. Closer is lower ping.",
		})

		FFlags:AddButton("Join Region", function()
			if tbl3.ffhop then
				tbl3.ffhop(options.ffregion.Value)
			end
		end)

		FFlags:AddLabel("Only flags your Roblox build already has will apply. Rise skips the rest.", true)
		tbl3.uiyield()
		local Music = tbl4.world:AddLeftGroupbox("Music")
		Music:AddToggle("music", { Text = "Music", Default = false, Tooltip = "Plays a song only you can hear." }):AddKeyPicker("musickey", { SyncToggleState = true, Mode = "Toggle", Text = "Music" })
		Music:AddDropdown("musictrack", { Values = tbl8, Default = tbl8[1], Text = "Track" })
		Music:AddSlider("musicvolume", { Text = "Volume", Default = 3, Min = 0, Max = 10, Rounding = 0 })

		Music:AddInput("musiccustom", {
			Text = "Custom ID",
			Default = "",
			Placeholder = "Roblox audio ID",
			Tooltip = "Plays your own song instead of the list.",
		})
	end

	tbl3.uiyield()
	local Server = tbl4.world:AddRightGroupbox("Server")

	Server:AddButton("Rejoin", function()
		if fn3 then
			fn3()
		end
	end)

	Server:AddButton("Server Hop", function()
		if tbl3.ffhop then
			tbl3.ffhop(options.ffregion.Value)
		elseif fn4 then
			fn4()
		end
	end)

	Server:AddButton("Reset Character", function()
		if fn5 then
			fn5()
		end
	end)

	Server:AddToggle("antiafk", { Text = "Anti AFK", Default = true, Tooltip = "Taps a key so Roblox doesn't kick you for idling." })

	Server:AddToggle("autoexecute", {
		Text = "Auto Execute on Teleport",
		Default = false,
		Tooltip = "Runs Rise again after you rejoin or hop.",
	})

	Server:AddToggle("autorematch", {
		Text = "Auto Rematch",
		Default = false,
		Tooltip = "Presses Rematch or Play Again as soon as a duel ends.",
	})

	Server:AddToggle("grindmode", {
		Text = "Grind Mode",
		Default = false,
		Tooltip = "Turns on Auto Rematch, Lobby Parry and Anti AFK.",
		Callback = function(arg)
			if toggles.autorematch then
				toggles.autorematch:SetValue(arg)
			end

			if toggles.lobbyparry then
				toggles.lobbyparry:SetValue(arg)
			end

			if toggles.antiafk then
				toggles.antiafk:SetValue(arg)
			end
		end,
	})

	tbl3.uiyield()
	local Menu
	Menu = tbl4.settings:AddLeftGroupbox("Menu")

	Menu:AddToggle("keybindmenuopen", {
		Default = v.KeybindFrame.Visible,
		Text = "Open Keybind Menu",
		Callback = function(visible)
			v.KeybindFrame.Visible = visible
		end,
	})

	Menu:AddDropdown("notificationside", {
		Values = { "Left", "Right" },
		Default = "Right",
		Text = "Notification Side",
		Callback = function(arg)
			v:SetNotifySide(arg)
		end,
	})

	Menu:AddDivider()
	Menu:AddLabel("UI Accent Colour"):AddColorPicker("uiaccent", { Default = tbl3.accent, Title = "UI Accent Colour" })

	Menu:AddButton("Reset Accent", function()
		options.uiaccent:SetValueRGB(tbl3.accent)
	end)

	Menu:AddButton("Reset All Settings", function()
		local flag = not tbl3.resetarm

		if not flag then
			local resetarm = tbl3.resetarm
			flag = os.clock() - resetarm > 5
		end

		if flag then
			tbl3.resetarm = os.clock()
			tbl3.notif("Reset All Settings", "Press again to reset everything.", 5)
			return
		end

		tbl3.resetarm = nil
		tbl3.nosave = true

		for _, toggle in pairs(toggles) do
			if toggle.Default ~= nil and toggle.SetValue then
				toggle:SetValue(toggle.Default)
			end
		end

		for _, option in pairs(options) do
			if option.Default ~= nil then
				if option.Type ~= "KeyPicker" then
					if option.Type == "ColorPicker" then
						if option.SetValueRGB then
							option:SetValueRGB(option.Default)
						end
					elseif option.SetValue then
						option:SetValue(option.Default)
					end
				end
			end
		end

		tbl3.nosave = false
		tbl3.syncopt()
		tbl3.qsave()
		tbl3.notif("Reset All Settings", "All settings reset. Keybinds kept.", 5)
	end)

	Menu:AddDivider()

	Menu:AddToggle("sendreports", {
		Text = "Send Launch Count",
		Default = true,
		Tooltip = "Tells us you launched Rise. Your executor adds an ID that can identify you.",
	})

	Menu:AddDivider()
	Menu:AddLabel("Toggle UI Key"):AddKeyPicker("menukeybind", { Default = "RightShift", Text = "Toggle UI" })
	v.ToggleKeybind = options.menukeybind
	tbl3.uiyield()
	local Discord = tbl4.settings:AddRightGroupbox("Discord")
	Discord:AddImage("discordlogo", { Image = "riseicon", ScaleType = Enum.ScaleType.Fit, Height = 120 })
	Discord:AddLabel("Join the Discord")

	Discord:AddButton("Copy Discord Invite", function()
		tbl3.copydc()
		v:Notify({ Title = "Discord", Description = "Invite copied to your clipboard.", Time = 3 })
	end)

	local v2
	local lua = fn2("https://raw.githubusercontent.com/uhfork/Obsidian/e39d83ec3fceeb484faf44b8a7abede72cec480e/addons/SaveManager.lua", "https://raw.githubusercontent.com/uhfork/Obsidian/main/addons/SaveManager.lua")
	lua = lua and loadstring(lua)
	if not lua then
		warn("[Rise] the config manager did not load, so settings cannot be saved. Run Rise again.")
		return
	end
	v2 = lua()
	v2:SetLibrary(v)
	v2:IgnoreThemeSettings()

	v2:SetIgnoreIndexes({
		"unlockall",
		"unlockallkey",
		"swordchangername",
		"explosionchangername",
		"emoteonly",
		"music",
		"musickey",
		"musictrack",
		"musicvolume",
		"musiccustom",
		"ffenable",
		"SaveManager_ConfigList",
		"SaveManager_ConfigName",
		"SaveManager_ImportData",
	})

	v2:SetFolder("Rise")
	v2:SetSubFolder(tostring(game.GameId))
	v2:BuildConfigSection(tbl4.settings)
	_G.stagesh = "savemanager"
	_G.RiseBoot = os.clock()

	do
		local thread = nil
		local tbl7 = { MB1 = true, MB2 = true, MB3 = true }

		tbl3.cfgpath = function(arg)
			local str = v2.Folder .. "/settings/"

			if type(v2.SubFolder) == "string" and v2.SubFolder ~= "" then
				str ..= v2.SubFolder .. "/"
			end

			return str .. arg .. ".json"
		end

		tbl3.stripmouse = function(arg)
			if not (isfile and readfile and writefile) then
				return nil
			end
			local v3 = tbl3.cfgpath(arg)
			if not isfile(v3) then
				return nil
			end
			local HttpService = game:GetService("HttpService")
			local data = HttpService:JSONDecode(readfile(v3))
			if type(data) ~= "table" or type(data.objects) ~= "table" then
				return nil
			end
			local tbl8 = nil

			for i = #data.objects, 1, -1 do
				local v4 = data.objects[i]

				if type(v4) == "table" and v4.type == "KeyPicker" and tbl7[v4.key] then
					tbl8 = tbl8 or {}
					tbl8[#tbl8 + 1] = tostring(v4.idx)
					table.remove(data.objects, i)
				end
			end

			if not tbl8 then
				return nil
			end
			writefile(v3, HttpService:JSONEncode(data))
			return tbl8
		end

		tbl3.warnmouse = function(arg)
			local warned = tbl3.warned

			if warned then
				local warned2 = tbl3.warned
				warned = os.clock() - warned2 < 15
			end

			if warned then
				return
			end
			tbl3.warned = os.clock()
			tbl3.notif("Keybind not saved", table.concat(arg, ", ") .. (#arg > 1 and " use " or " uses ") .. "a mouse button. Pick a keyboard key instead.", 8)
		end

		tbl3.qsave = function()
			if tbl3.nosave then
				return
			end

			if thread then
				task.cancel(thread)
			end

			thread = task.delay(0.35, function()
				thread = nil
				v2:Save("autosave")
				local autosave = tbl3.stripmouse("autosave")

				if autosave then
					tbl3.warnmouse(autosave)
				end
			end)
		end
	end

	tbl3.loadsave = function()
		local autosave = tbl3.stripmouse("autosave")
		v2:Load("autosave")

		if autosave then
			task.delay(2, function()
				tbl3.warnmouse(autosave)
			end)
		end
	end

	tbl3.hooksave = function()
		for _, toggle in pairs(toggles) do
			if toggle and toggle.OnChanged then
				local changed = toggle.Changed

				toggle:OnChanged(function(arg)
					v:SafeCallback(changed, arg)
					tbl3.qsave()
				end)
			end
		end

		for _, option in pairs(options) do
			if option and option.OnChanged then
				local changed = option.Changed

				option:OnChanged(function(...)
					local v3 = v
					local safeCallback = v3.SafeCallback
					local v4 = table.pack(...)
					local v5 = changed
					v4.n = 3 + v4.n - 1
					table.move(v4, 1, v4.n, 3, v4)
					v4[1] = v3
					v4[2] = v5
					safeCallback(table.unpack(v4, 1, v4.n))
					tbl3.qsave()
				end)
			end
		end
	end

	local tbl7
	tbl7 = { Connections = {}, Threads = {} }
	tbl3.bind = function(l)local K= tbl7 .Connections;K[#K+1]=l;if#K>256 then local p={};for E,E in ipairs(K)do if E.Connected~=false then p[#p+1]=E;end;end; tbl7 .Connections=p;end;return l;end
	tbl3.bindt = function(l)local K= tbl7 .Threads;K[#K+1]=l;if#K>256 then local p={};for E,E in ipairs(K)do if type(E)~="thread"or coroutine.status(E)~="dead"then p[#p+1]=E;end;end; tbl7 .Threads=p;end;return l;end
	local fn6

	fn6 = gethui or function()
		return game:GetService("CoreGui")
	end

	local Players
	Players = game:GetService("Players")
	local RunService
	RunService = game:GetService("RunService")
	tbl3.bind(RunService.Heartbeat:Connect(function()_G.RiseHeartbeat=os.clock();end))
	tbl3.frame = 0
	tbl3.bind(RunService.PreSimulation:Connect(function() tbl3 .frame= tbl3 .frame+1;end))
	local ReplicatedStorage
	ReplicatedStorage = game:GetService("ReplicatedStorage")
	local UserInputService
	UserInputService = game:GetService("UserInputService")
	local Workspace
	Workspace = game:GetService("Workspace")
	local Lighting, TweenService, HttpService, Debris, MarketplaceService, CoreGui, CollectionService, SoundService, TeleportService, localPlayer
	local currentCamera, floor, abs, min, max, clamp, random, huge, n, rad
	local sin, cos, asin, clock, format, alive, dead, flag, str, tbl8
	local tbl9, tbl10, color, accent, color2, color3

	do
		local Stats = game:GetService("Stats")
		Lighting = game:GetService("Lighting")
		TweenService = game:GetService("TweenService")
		HttpService = game:GetService("HttpService")
		Debris = game:GetService("Debris")
		MarketplaceService = game:GetService("MarketplaceService")
		CoreGui = game:GetService("CoreGui")
		CollectionService = game:GetService("CollectionService")
		SoundService = game:GetService("SoundService")
		TeleportService = game:GetService("TeleportService")
		localPlayer = Players.LocalPlayer

		if not localPlayer then
			Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
			localPlayer = Players.LocalPlayer
		end

		if not localPlayer.Character then
			localPlayer.CharacterAdded:Wait()
		end

		_G.stagesh = "character"
		currentCamera = Workspace.CurrentCamera

		tbl3.bind(Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			currentCamera = Workspace.CurrentCamera or currentCamera
		end))

		local serverStatsItem = Stats.Network:FindFirstChild("ServerStatsItem")
		floor = math.floor
		abs = math.abs
		min = math.min
		max = math.max
		clamp = math.clamp
		random = math.random
		huge = math.huge
		n = 3.1415926535897931
		rad = math.rad
		local deg = math.deg
		sin = math.sin
		cos = math.cos
		asin = math.asin
		clock = os.clock
		format = string.format
		local tbl11 = {}
		tbl3.logw = function(l,K)warn( format ("[Rise] %s%s",tostring(l),K~=nil and" - "..tostring(K)or""));end
		tbl3.logwev = function(l,K,p,E)local k= clock ();local a= tbl11 [l];if a and k-a<(K or 5)then return;end; tbl11 [l]=k; tbl3 .logw(p,E);end
		alive = Workspace:FindFirstChild("Alive") or Workspace:WaitForChild("Alive", 10)
		dead = Workspace:FindFirstChild("Dead") or Workspace:WaitForChild("Dead", 10)
		local runtime = Workspace:FindFirstChild("Runtime") or Workspace:WaitForChild("Runtime", 10)

		if not alive then
			tbl3.logw("workspace.Alive folder not found")
		end

		if not dead then
			tbl3.logw("workspace.Dead folder not found")
		end

		if not runtime then
			tbl3.logw("workspace.Runtime folder not found")
		end

		_G.stagesh = "workspace"
		flag = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
		str = (identifyexecutor and identifyexecutor() or ""):lower()
		tbl3.baseident = getthreadidentity()

		tbl8 = {
			rem = nil,
			kt = {
				1116352408,
				1899447441,
				3049323471,
				3921009573,
				961987163,
				1508970993,
				2453635748,
				2870763221,
				3624381080,
				310598401,
				607225278,
				1426881987,
				1925078388,
				2162078206,
				2614888103,
				3248222580,
				3835390401,
				4022224774,
				264347078,
				604807628,
				770255983,
				1249150122,
				1555081692,
				1996064986,
				2554220882,
				2821834349,
				2952996808,
				3210313671,
				3336571891,
				3584528711,
				113926993,
				338241895,
				666307205,
				773529912,
				1294757372,
				1396182291,
				1695183700,
				1986661051,
				2177026350,
				2456956037,
				2730485921,
				2820302411,
				3259730800,
				3345764771,
				3516065817,
				3600352804,
				4094571909,
				275423344,
				430227734,
				506948616,
				659060556,
				883997877,
				958139571,
				1322822218,
				1537002063,
				1747873779,
				1955562222,
				2024104815,
				2227730452,
				2361852424,
				2428436474,
				2756734187,
				3204031479,
				3329325298,
			},
			salt = "bd93afff-8aba-409d-9946-a875f6c33087",
			sha = function(l)local K=bit32.bxor;local p=bit32.band;local E=bit32.bor;local k=bit32.bnot;local a=bit32.rrotate;local d=bit32.rshift;local I=bit32.lshift;local C,U= tbl8 .kt,#l*8;l..=string.char(128);while#l%64~=56 do l..=string.char(0);end;for J=7,0,-1 do l..=string.char(p(d(U,J*8),255));end;local J,G,S,N,Y,j,F,m,M=table.create(64),1779033703,3144134277,1013904242,2773480762,1359893119,2600822924,528734635,1541459225;for r=1,#l,64 do for R=0,15,1 do local V,_,f,P=string.byte(l,r+R*4,r+R*4+3);J[R+1]=E(I(V,24),I(_,16),I(f,8),P);end;for l=17,64,1 do r,U=J[l-15],J[l-2];local E,I=K(a(r,7),a(r,18),d(r,3)),K(a(U,17),a(U,19),d(U,10));J[l]=p(J[l-16]+E+J[l-7]+I,4294967295);end;local l,E,d,I,U,r,R,V=j,F,m,M,G,S,N,Y;for _=1,64,1 do local f,P=K(a(l,6),a(l,11),a(l,25)),K(p(l,E),p(k(l),d));local k,e=p(I+f+P+C[_]+J[_],4294967295),p(K(a(U,2),a(U,13),a(U,22))+K(p(U,r),p(U,R),p(r,R)),4294967295);l,E,d,I,U,r,R,V=(p(V+k,4294967295)),l,E,d,(p(k+e,4294967295)),U,r,R;end;G,S,N,Y,j,F,m,M=(p(G+U,4294967295)),(p(S+r,4294967295)),(p(N+R,4294967295)),(p(Y+V,4294967295)),(p(j+l,4294967295)),(p(F+E,4294967295)),(p(m+d,4294967295)),(p(M+I,4294967295));end;return  format ("%08x%08x%08x%08x%08x%08x%08x%08x",G,S,N,Y,j,F,m,M);end,
			enc = function(h,l)local K,p,E=table.pack(string.byte(l,1,-1)),table.create(#h),1;for l=1,#h,1 do p[l]=string.char((string.byte(h,l)-32+K[E])%95+32);E=E%K.n+1;end;return table.concat(p);end,
			hc = {},
			mang = function(l,K)K=K or game.JobId;if type(l)~="string"or type(K)~="string"or K==""then return nil;end;local p=K.."|"..l;local E= tbl8 .hc[p];if E then return E;end;E= tbl8 .sha( tbl8 .enc(l,K).. tbl8 .salt..K); tbl8 .hc[p]=E;return E;end,
			netf = function()local l= ReplicatedStorage :FindFirstChild("Packages");l=l and(l:FindFirstChild("_Index"));if not l then return nil;end;for h,K in ipairs(l:GetChildren())do if K.Name:lower():find("sleitnick_net")then h=K:FindFirstChild("net");if h then return h;end;end;end;return nil;end,
			byname = function(arg, arg2)
				local v3 = tbl8.netf()
				if not v3 then
					return nil
				end
				local v4 = tbl8.mang(arg, arg2)
				if not v4 then
					return nil
				end
				return v3:FindFirstChild("RE/" .. v4) or v3:FindFirstChild("RF/" .. v4) or v3:FindFirstChild("URE/" .. v4)
			end,
			findRemote = function()
				local jobId = game.JobId
				if type(jobId) ~= "string" or jobId == "" then
					return
				end
				local v3 = tbl8.netf()
				if not v3 then
					return
				end
				local v4 = tbl8.mang(jobId:gsub("-", ""), jobId)
				if not v4 then
					return
				end
				tbl8.rem = v3:FindFirstChild("RE/" .. v4)
			end,
			findSigner = function()if  tbl8 .sgn and  tbl8 .signHolder and  tbl8 .signHash then return;end;if not(getgc and getupvalues)then return;end;local function l(K)return type(K)=="string"and K:match("^%x+%-%x+%-%x+%-%x+%-%x+$")~=nil;end;local function K(p)if typeof(p)~="Instance"then return false;end;return(p:IsA("RemoteEvent"));end;local function p(E)if type(E)~="table"then return;end;local k=rawget(E,1);if type(k)~="table"then return;end;local a=rawget(E,3);if a==nil then return;end;E=rawget(k,a);if type(E)=="string"then return E;end;end;local E=( clock ());for k,a in pairs(getgc(false))do if type(a)=="function"and(islclosure(a))then local d,I,C=getupvalues(a),0,0;if type(d)=="table"then for a in pairs(d)do I,C=I+1,if type(a)=="number"and a>C then a else C;end;end;if I>=6 and I<=12 then local a,I,U,J=0,0,0,false;for G=1,C,1 do k=d[G];if k~=nil then if K(k)then a+=1;elseif l(k)then I+=1;elseif type(k)=="function"then U+=1;else J=if p(k)then true else J;end;end;end;if a>=2 and I>=3 and U>=1 and J then local K,k,a={};for I=1,C,1 do local C=d[I];if C~=nil then if p(C)then k=if not k then C else k;else I=type(C);if I=="function"then a=if not a then C else a;elseif l(C)then K[#K+1]=C;end;end;end;end;if k and a and K[2]then  tbl8 .sgn=a; tbl8 .signHolder=k; tbl8 .signHash=K[2];end;break;end;end;end;if  clock ()-E>0.005 then task.wait();E=( clock ());end;end;end,
			signKey = function()local l= tbl8 .signHolder;if type(l)~="table"then return nil;end;local h=rawget(l,1);if type(h)=="number"then local K=rawget(l,2);if type(K)~="table"then return nil;end;local p=rawget(K,h);return type(p)=="string"and p or nil;end;if type(h)=="table"then local K=rawget(l,3);if K==nil then return nil;end;local l=rawget(h,K);return type(l)=="string"and l or nil;end;return nil;end,
			s1 = function(l)if not  tbl8 .sgn then return nil;end;local K= tbl8 .sgn(l,"TIME");if type(K)~="string"or#K==0 then return nil;end;local p,E=tostring( floor ( Workspace :GetServerTimeNow()*100)),{};for h=1,#p,1 do l=string.byte(K,(h-1)%#K+1);E[h]=string.char(bit32.bxor((string.byte(p,h)+h)%256,l));end;return table.concat(E);end,
			findPryModule = function()if not getupvalues then return;end;local l= ReplicatedStorage :FindFirstChild("Controllers");if not l then return;end;local K=l:FindFirstChild("SwordsController \12");if not K then for p,p in ipairs(l:GetChildren())do if p:IsA("ModuleScript")and p.Name:sub(1,15)=="SwordsController"then K=p;break;end;end;end;l=K and(K:FindFirstChild("PRY"));if not l then return;end;K=require(l);if type(K)~="function"then return;end;l=getupvalues(K);if type(l)~="table"then return;end;local p,E,k,a,d=rawget(l,3),rawget(l,4),rawget(l,6),rawget(l,7),rawget(l,8);if type(p)~="table"or type(E)~="function"then return;end;if type(d)~="string"or#d~=36 then return;end;if type(k)~="table"or type(rawget(k,"RemoteEvent"))~="function"then return;end;if type(a)~="string"or#a==0 then return;end;K= tbl8 .byname(a);if typeof(K)~="Instance"or not K:IsA("RemoteEvent")then return;end;if K==rawget(l,1)or K==rawget(l,2)then return;end; tbl8 .signHolder=p; tbl8 .sgn=E; tbl8 .signHash=d; tbl8 .rem=K;if type( tbl8 .signKey())~="string"then  tbl8 .signHolder=nil; tbl8 .sgn=nil; tbl8 .signHash=nil; tbl8 .rem=nil;return;end; tbl8 .via="pry";end,
			resolve = function()
				tbl8.rem = nil
				tbl8.via = nil
				tbl8.findPryModule()
				if tbl8.rem and tbl8.sgn and tbl8.signHolder and tbl8.signHash then
					return true
				end
				tbl8.findRemote()
				tbl8.findSigner()

				if tbl8.rem and tbl8.sgn and tbl8.signHolder and tbl8.signHash then
					tbl8.via = "scan"
				end

				return tbl8.rem ~= nil and tbl8.sgn ~= nil and tbl8.signHolder ~= nil and tbl8.signHash ~= nil
			end,
			lasttry = 0,
			busy = false,
			ensure = function()if  tbl8 .rem and  tbl8 .sgn and  tbl8 .signHolder and  tbl8 .signHash then return;end;if  tbl8 .busy then return;end;local l= clock ();if l-( tbl8 .lasttry or 0)<2 then return;end; tbl8 .lasttry=l; tbl8 .busy=true;task.spawn(function() tbl8 .resolve(); tbl8 .busy=false;end);end,
		}

		tbl3.bindt(task.spawn(function()
			local n2 = clock() + 20

			while not Workspace:GetAttribute("ClientModulesLoaded") and clock() < n2 do
				task.wait(0.25)
			end

			for i = 1, 30 do
				if tbl8.resolve() then
					if tbl3.degraded then
						tbl3.degraded = false
						tbl3.notif("Parry", "Parry is working again.", 5)
					end

					return
				end

				if i == 4 then
					tbl3.degraded = true
					tbl3.notif("Parry", "Parry isn't working here yet. Rise keeps trying.", 8)
				end

				task.wait(min(0.5 + i * 0.5, 5))
			end

			local tbl12 = {}

			if not tbl8.rem then
				tbl12[#tbl12 + 1] = "remote"
			end

			if not tbl8.sgn then
				tbl12[#tbl12 + 1] = "signer"
			end

			if not tbl8.signHolder then
				tbl12[#tbl12 + 1] = "key holder"
			end

			if not tbl8.signHash then
				tbl12[#tbl12 + 1] = "hash"
			end

			tbl3.logw("parry resolve", "missing " .. table.concat(tbl12, ", "))
			tbl3.notif("Parry", "Parry still is not working here. Rejoin or try another executor.", 10)
		end))

		_G.stagesh = "parry"
		tbl3.safechar = function()local l= localPlayer .Character;if not l or not l.Parent then return nil;end;return l;end
		tbl3.safehrp = function()local l= tbl3 .safechar();if not l then return nil;end;local h=l:FindFirstChild("HumanoidRootPart");if not h or not h.Parent then return nil;end;return h;end
		tbl3.safehum = function()local l= tbl3 .safechar();if not l then return nil;end;return l:FindFirstChildOfClass("Humanoid");end
		tbl3.isalive = function()local l= tbl3 .safechar();if not l or not  alive then return false;end;return l.Parent== alive ;end
		local dataPing = serverStatsItem and serverStatsItem:FindFirstChild("Data Ping")
		tbl3.getping = function()if not  dataPing then return 50;end;local l= clock ();if  tbl3 .pingval and l- tbl3 .pingat<0.25 then return  tbl3 .pingval;end; tbl3 .pingval= dataPing .GetValue( dataPing )or 50; tbl3 .pingat=l;return  tbl3 .pingval;end
		tbl3.scanreal = function(h,l)if not h then return;end;for K,K in ipairs(h:GetChildren())do if K:GetAttribute("realBall")then if K:IsA("BasePart")then K.CanCollide=false;end;l[#l+1]=K;elseif K:IsA("Model")and(K:FindFirstChild("CollisionWhitelist"))then l[#l+1]=K;end;end;end
		tbl3.ballbuf = {}
		tbl3.ballframe = -1
		tbl3.ballList = function()if  tbl3 .ballframe== tbl3 .frame then return  tbl3 .ballbuf;end; tbl3 .ballframe= tbl3 .frame;local l= tbl3 .ballbuf;table.clear(l);if  alive and( alive :FindFirstChild(tostring( localPlayer )))then  tbl3 .scanreal( Workspace :FindFirstChild("Balls"),l);end; tbl3 .scanreal( Workspace :FindFirstChild("TrainingBalls"),l);if#l==0 then  tbl3 .scanreal( Workspace :FindFirstChild("Balls"),l);end;return l;end
		tbl3.ballPos = function(h)if not h then return nil;end;if h:IsA("BasePart")then return h.Position;end;local l=h:FindFirstChild("Body");if l and(l:IsA("BasePart"))then return l.Position;end;return h:GetPivot().Position;end
		tbl3.ballVel = function(h)if not h then return(Vector3.new(0.0,0.0,0.0));end;local l=h:FindFirstChild("zoomies");if l then return l.VectorVelocity;end;l=h:GetAttribute("Velocity");if typeof(l)=="Vector3"then return l;end;l=h:FindFirstChild("Body");if l and(l:IsA("BasePart"))then return l.AssemblyLinearVelocity;end;if h:IsA("BasePart")then return h.AssemblyLinearVelocity;end;return(Vector3.new(0.0,0.0,0.0));end
		tbl3.bauth = setmetatable({}, { __mode = "k" })
		tbl3.frameSmooth = 0.016666666666666666
		tbl3.bind(RunService.RenderStepped:Connect(function(l)local K= clamp ( min (l,0.016666666666666666),0.001,0.1); tbl3 .frameSmooth= tbl3 .frameSmooth+(K- tbl3 .frameSmooth)*0.1;end))
		tbl3.findballrem = function()return  tbl8 .byname("ReplicateBallPosition");end

		tbl3.startpred = function()
			if tbl3.predon then
				return
			end
			local v3 = tbl3.findballrem()

			if not v3 then
				tbl3.predtry = (tbl3.predtry or 0) + 1

				if tbl3.predtry <= 20 then
					tbl3.bindt(task.delay(1, tbl3.startpred))
				end

				return
			end

			tbl3.predon = true
			tbl3.bind(v3.OnClientEvent:Connect(function(l,K)if typeof(l)~="Instance"or typeof(K)~="Vector3"then return;end;local p= tbl3 .bauth[l];if p then p.pos=K;p.at= clock ();else  tbl3 .bauth[l]={pos=K,at= clock ()};end;end))
		end

		tbl3.apos = function(l)local K=l and  tbl3 .bauth[l];if not K then return  tbl3 .ballPos(l);end;local p= clock ()-K.at;if p>0.35 then return  tbl3 .ballPos(l);end;return K.pos+ tbl3 .ballVel(l)*p;end
		tbl3.ballTarget = function(h)if not h then return nil;end;local l=h:FindFirstChild("CollisionWhitelist");if l and(l:IsA("ObjectValue"))then local K=l.Value;return K and K.Name or nil;end;l=h:GetAttribute("target");if type(l)=="string"and l~=""then return l;end;return nil;end
		tbl3.ballLive = function(h)return h~=nil and(h:FindFirstChild("zoomies")~=nil or h:FindFirstChild("CollisionWhitelist")~=nil);end
		tbl3.validtgt = function(l)if not l or l== localPlayer .Character then return false;end;if l:GetAttribute("Dead")then return false;end;if l:GetAttribute("Invisible")then return false;end;if l:GetAttribute("DoNotTarget")then return false;end;if l:GetAttribute("IsDoppelganger")then return false;end;if l:GetAttribute("SingularityInOrbit")then return false;end;return true;end
		tbl3.ballstate = setmetatable({}, { __mode = "k" })
		tbl3.pickframe = -1
		tbl3.getball = function()if  tbl3 .pickframe== tbl3 .frame then return  tbl3 .pickball;end; tbl3 .pickframe= tbl3 .frame; tbl3 .pickball= tbl3 .rankBalls();return  tbl3 .pickball;end
		tbl3.rankBalls = function()local l= tbl3 .ballList();if#l==0 then return nil;end;if#l==1 then return l[1];end;local K= localPlayer .Character;local p=K and K.PrimaryPart;if not p then return l[1];end;local E= localPlayer .Name;local k=-1;local a,d= huge ;for I,C in ipairs(l)do I= tbl3 .ballPos(C);if I then K= tbl3 .ballstate[C];local U,J,G=if  tbl3 .ballTarget(C)==E then K and K.parried and 1 or 2 else 0,(I-p.Position).Magnitude, tbl3 .ballVel(C);local h,K=G.Magnitude;if h>1 then K=J/h;K=if G.Unit:Dot((p.Position-I).Unit)<=0 then K+10 else K;else K=J;end;if U>k or U==k and K<a then k,a,d=U,K,C;end;end;end;return d or l[1];end

		tbl9 = {
			ballstate = tbl3.ballstate,
			parries = 0,
			parried = false,
			lastparry = 0,
			grabcd = 0.35,
			lastgrab = 0,
			lastpull = 0,
			infball = false,
			plrforc = false,
			staffconn = nil,
			aero = setmetatable({}, { __mode = "k" }),
			curve = { curving = tick(), lerprad = 0, lastwarp = tick() },
			vzpart = nil,
			hl = nil,
			mswidget = nil,
			msactive = false,
			asconn = nil,
			msconn = nil,
			abilconn = nil,
			abilball = nil,
			swords = nil,
			swmod = nil,
			swfn = nil,
			swbind = nil,
			noacc = false,
			swctrl = nil,
			swtried = nil,
			swbad = {},
			nocdsave = nil,
			modegui = nil,
			moderef = nil,
			skinstarted = false,
			slashhooked = false,
			slashorig = nil,
			slashoff = {},
			slashtask = nil,
			fxmod = nil,
			fxwarm = {},
			broken = {},
			afkthread = nil,
			phactive = false,
			phconn = nil,
			vipset = false,
			shadefx = nil,
			rainfx = nil,
			rainconn = nil,
			musicsound = nil,
			cfgprevping = nil,
			cfgsmoothping = nil,
			cfgjitter = nil,
			cfguisync = 0,
		}

		tbl10 = {
			autoparry = false,
			trigger = false,
			tlock = false,
			tlockui = false,
			randtgt = false,
			randtime = 3,
			crvstr = 0,
			advcrv = false,
			socrv = "Random",
			nscrv = "Dot",
			crv = "Camera",
			acc = 100,
			rng = 0,
			autospam = false,
			manspam = false,
			mansui = false,
			norender = nil,
			keyparry = false,
			animfix = true,
			autoabil = false,
			cdprot = false,
			thundernocd = false,
			abilspd = 250,
			curvekb = false,
			pulldetect = false,
			sofmode = "Legit",
			sofdelay = 0,
			emoteonly = false,
			swskin = false,
			swname = "",
			autoload = false,
			forceemo = false,
			emospam = false,
			emospd = 5,
			emospawn = false,
			bt = false,
			btstart = Color3.fromRGB(255, 85, 85),
			btend = Color3.fromRGB(85, 85, 255),
			btrb = false,
			btpart = false,
			btglow = false,
			btlife = 0.1,
			btwidth = 1.4,
			pt = false,
			ptcol = Color3.fromRGB(125, 85, 255),
			ptrb = false,
			ptlife = 0.1,
			ptwidth = 0.1,
			viz = false,
			vizcol = Color3.fromRGB(125, 85, 255),
			staff = true,
			staffdo = "Notification",
			bestcfg = false,
			antiafk = true,
			autoexec = false,
			viptag = false,
			devtype = "Off",
			devscreen = "Off",
			shaders = false,
			shaderpreset = "Cinematic",
			dof = false,
			bloom = 1,
			saturation = 1,
			brightness = 0,
			contrast = 0,
			rain = false,
			rainrate = 150,
			music = false,
			track = "Dark Synth",
			vol = 3,
			musicid = "",
			fpscap = false,
			fpsval = 60,
		}

		color = Color3.fromRGB(4, 38, 62)
		accent = tbl3.accent
		color2 = Color3.fromRGB(237, 232, 220)
		color3 = Color3.fromRGB(107, 122, 153)
		tbl3.notifq = {}
		tbl3.notif = function(l,K,p)local E= tbl3 .notifq;E[#E+1]={l,K,p or 3};end
		tbl3.bind(RunService.Heartbeat:Connect(function()if# tbl3 .notifq==0 then return;end;local l= tbl3 .notifq; tbl3 .notifq={};for K,K in ipairs(l)do  v .Notify( v ,{Title=K[1],Description=K[2],Time=K[3]});end;end))

		tbl3.chkfeat = function()
			tbl9.broken = {}
			local remotes = ReplicatedStorage:FindFirstChild("Remotes")
			remotes = remotes and remotes:FindFirstChild("AbilityButtonPress")

			if not (remotes and remotes:IsA("BindableEvent")) then
				tbl9.broken.abil = "This server didn't load the ability button. Rejoin and try again."
			end
		end

		tbl3.featguard = function(arg, arg2)
			local v3 = tbl9.broken[arg]

			if v3 then
				tbl3.chkfeat()
				v3 = tbl9.broken[arg]
			end

			if v3 then
				tbl3.notif(arg2, tostring(v3), 4)
				return false
			end
			return true
		end

		tbl3.corner = function(h,l)local K=Instance.new("UICorner",h);K.CornerRadius=UDim.new(0,l);return K;end

		tbl3.stroke = function(arg, color4, thickness, transparency)
			local uiStroke = Instance.new("UIStroke", arg)
			uiStroke.Color = color4
			uiStroke.Thickness = thickness or 1
			uiStroke.Transparency = transparency or 0
			return uiStroke
		end

		tbl3.dragify = function(arg, arg2)
			local flag2 = nil
			local position = nil
			local position2 = nil
			arg.InputBegan:Connect(function(l)if l.UserInputType==Enum.UserInputType.MouseButton1 or l.UserInputType==Enum.UserInputType.Touch then  flag2 =true; position =l.Position; position2 = arg2 .Position;l.Changed:Connect(function()local K,p=l.UserInputState,Enum.UserInputState.End;if K==p then  flag2 =false;end;end);end;end)
			arg.InputChanged:Connect(function(l)if  flag2 and(l.UserInputType==Enum.UserInputType.MouseMovement or l.UserInputType==Enum.UserInputType.Touch)then local K=l.Position- position ; arg2 .Position=UDim2.new( position2 .X.Scale, position2 .X.Offset+K.X, position2 .Y.Scale, position2 .Y.Offset+K.Y);end;end)
		end

		tbl3.accbase = function()return 0.55+( tbl10 .acc-1)*0.004545454545454545;end
		tbl3.parryWindow = function(l)local K=(2.4+ min ( max (l-9.5,0),5000)*0.002)* tbl3 .accbase();if K<=0 then return  huge ;end;local p= min ( tbl3 .frameSmooth*1.5,0.03);return  clamp ( tbl3 .getping()/10,10,16)+ max (l/K,9.5)+ tbl10 .rng+l*p;end
		local tbl12 = { g = nil, rows = {}, c = nil, pk = 0, acc = 0, you = nil, spd = nil, ttl = nil }
		local function fn7(h)if h<80 then return Color3.fromRGB(120,230,140);elseif h<150 then return Color3.fromRGB(245,215,110);end;return Color3.fromRGB(245,110,90);end

		local function fn8()
			if tbl12.c then
				tbl12.c:Disconnect()
				tbl12.c = nil
			end

			if tbl12.g then
				tbl12.g:Destroy()
				tbl12.g = nil
			end

			tbl12.rows = {}
			tbl12.pk = 0
			tbl12.acc = 0
			tbl12.last = nil
			tbl12.fps = 0
			tbl12.fa = 0
			tbl12.fn = 0
		end

		local function createTextLabel(parent, text)
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 19)
			frame.BackgroundTransparency = 1
			frame.Parent = parent
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(0.5, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.Gotham
			textLabel.TextSize = 12
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.TextColor3 = color3
			textLabel.Text = text
			textLabel.Parent = frame
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.Size = UDim2.new(0.5, 0, 1, 0)
			textLabel2.Position = UDim2.fromScale(0.5, 0)
			textLabel2.BackgroundTransparency = 1
			textLabel2.Font = Enum.Font.GothamBold
			textLabel2.TextSize = 13
			textLabel2.TextXAlignment = Enum.TextXAlignment.Right
			textLabel2.TextColor3 = color2
			textLabel2.Text = "-"
			textLabel2.Parent = frame
			return textLabel2
		end

		local function createFrame(parent, arg)
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Name = "shadow"
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = "rbxassetid://6014261993"
			imageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			imageLabel.ImageTransparency = 0.45
			imageLabel.ScaleType = Enum.ScaleType.Slice
			imageLabel.SliceCenter = Rect.new(49, 49, 450, 450)
			imageLabel.ZIndex = 0
			imageLabel.Parent = parent
			local frame = Instance.new("Frame")
			frame.AnchorPoint = Vector2.new(0, 0.5)
			frame.Position = UDim2.new(0, 18, 0.42, 0)
			frame.Size = UDim2.fromOffset(arg, 0)
			frame.AutomaticSize = Enum.AutomaticSize.Y
			frame.BackgroundColor3 = color
			frame.BackgroundTransparency = 0.04
			frame.BorderSizePixel = 0
			frame.ZIndex = 1
			frame.Parent = parent
			tbl3.corner(frame, 14)
			local uiGradient = Instance.new("UIGradient")
			uiGradient.Rotation = 90
			local color4 = Color3.fromRGB
			uiGradient.Color = ColorSequence.new(Color3.fromRGB(12, 52, 82), color4(3, 26, 44))
			uiGradient.Parent = frame
			tbl3.stroke(frame, Color3.fromRGB(255, 255, 255), 1, 0.9)

			local function fn9()
				imageLabel.Size = UDim2.fromOffset(frame.AbsoluteSize.X + 34, frame.AbsoluteSize.Y + 34)
				imageLabel.Position = UDim2.fromOffset(frame.AbsolutePosition.X - 17, frame.AbsolutePosition.Y - 17)
			end

			frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn9)
			frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(fn9)
			task.defer(fn9)
			return frame
		end

		local function fn9()
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "\0_bh"
			screenGui.ResetOnSpawn = false
			screenGui.IgnoreGuiInset = true
			screenGui.DisplayOrder = 60
			screenGui.Parent = v.ScreenGui or fn6 and fn6() or CoreGui
			tbl12.g = screenGui
			local v3 = createFrame(screenGui, 180)
			local uiPadding = Instance.new("UIPadding")
			uiPadding.PaddingTop = UDim.new(0, 11)
			uiPadding.PaddingBottom = UDim.new(0, 11)
			uiPadding.PaddingLeft = UDim.new(0, 13)
			uiPadding.PaddingRight = UDim.new(0, 13)
			uiPadding.Parent = v3
			local uiListLayout = Instance.new("UIListLayout")
			uiListLayout.Padding = UDim.new(0, 3)
			uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			uiListLayout.Parent = v3
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 20)
			frame.BackgroundTransparency = 1
			frame.Parent = v3
			local frame2 = Instance.new("Frame")
			frame2.AnchorPoint = Vector2.new(0, 0.5)
			frame2.Position = UDim2.new(0, 0, 0.5, 0)
			frame2.Size = UDim2.fromOffset(8, 8)
			frame2.BackgroundColor3 = accent
			frame2.BorderSizePixel = 0
			frame2.Parent = frame
			tbl3.corner(frame2, 999)
			tbl12.you = frame2
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -16, 1, 0)
			textLabel.Position = UDim2.fromOffset(16, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 13
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.TextColor3 = color2
			textLabel.Text = "BALL"
			textLabel.Parent = frame
			tbl12.ttl = textLabel
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.AnchorPoint = Vector2.new(1, 0.5)
			textLabel2.Position = UDim2.new(1, 0, 0.5, 0)
			textLabel2.Size = UDim2.fromOffset(16, 16)
			textLabel2.BackgroundTransparency = 1
			textLabel2.Font = Enum.Font.GothamBold
			textLabel2.TextSize = 15
			textLabel2.TextColor3 = accent
			textLabel2.Text = "▲"
			textLabel2.Parent = frame
			tbl12.arrow = textLabel2
			local frame3 = Instance.new("Frame")
			frame3.Size = UDim2.new(1, 0, 0, 1)
			frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			frame3.BackgroundTransparency = 0.88
			frame3.BorderSizePixel = 0
			frame3.Parent = v3
			tbl12.spd = createTextLabel(v3, "Speed")
			tbl12.rows.tgt = createTextLabel(v3, "Target")
			tbl12.rows.eta = createTextLabel(v3, "ETA")
			tbl12.rows.dist = createTextLabel(v3, "Distance")
			tbl12.rows.win = createTextLabel(v3, "Window")
			tbl12.rows.peak = createTextLabel(v3, "Peak")
			tbl12.rows.net = createTextLabel(v3, "Ping / FPS")
			local frame4 = Instance.new("Frame")
			frame4.Size = UDim2.new(1, 0, 0, 3)
			frame4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			frame4.BackgroundTransparency = 0.9
			frame4.BorderSizePixel = 0
			frame4.Parent = v3
			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(0, 2)
			uiCorner.Parent = frame4
			local frame5 = Instance.new("Frame")
			frame5.Size = UDim2.new(0, 0, 1, 0)
			frame5.BackgroundColor3 = accent
			frame5.BorderSizePixel = 0
			frame5.Parent = frame4
			local uiCorner2 = Instance.new("UICorner")
			uiCorner2.CornerRadius = UDim.new(0, 2)
			uiCorner2.Parent = frame5
			tbl12.bar = frame5
			tbl3.dragify(v3, v3)
		end

		local function fn10(l)if not(l and  alive )then return nil;end;local K= alive :FindFirstChild(l);l=K and K.PrimaryPart;return l and l.Position;end
		local function fn11()if not  tbl12 .g or not  tbl12 .g.Parent or not  tbl12 .rows.dist then return;end;local l= options .ballhudcolor and  options .ballhudcolor.Value or  accent ;local K= toggles .ballhuddyn and  toggles .ballhuddyn.Value; tbl12 .rows.dist.Parent.Visible=not  toggles .ballhuddist or  toggles .ballhuddist.Value; tbl12 .rows.peak.Parent.Visible=not  toggles .ballhudpeak or  toggles .ballhudpeak.Value;local p= tbl3 .getball();if not p then  tbl12 .spd.Text="-"; tbl12 .rows.tgt.Text="-"; tbl12 .rows.eta.Text="-"; tbl12 .rows.dist.Text="-"; tbl12 .you.BackgroundColor3= color3 ; tbl12 .ttl.Text="BALL"; tbl12 .ttl.TextColor3= color2 ; tbl12 .spd.TextColor3= color2 ;if  tbl12 .arrow then  tbl12 .arrow.Visible=false;end;return;end;if p~= tbl12 .last then  tbl12 .last=p; tbl12 .pk=0;end;local E,k,a= tbl3 .ballPos(p), tbl3 .ballVel(p).Magnitude, tbl3 .ballTarget(p);if k> tbl12 .pk then  tbl12 .pk=k;end;local d=a== localPlayer .Name; tbl12 .you.BackgroundColor3=d and(Color3.fromRGB(245,70,70))or l; tbl12 .ttl.Text=d and"BALL \194\183 YOU"or"BALL"; tbl12 .ttl.TextColor3=d and(Color3.fromRGB(245,110,90))or  color2 ; tbl12 .spd.Text= format ("%.0f",k); tbl12 .spd.TextColor3=K and( fn7 (k))or l; tbl12 .rows.tgt.Text=a and a~=""and(tostring(a))or"-";K= localPlayer .Character;local I=K and K.PrimaryPart;local C,U=I and E and(I.Position-E).Magnitude or nil, tbl3 .getping();K= min ( tbl3 .parryWindow(k),999);if d then local J,G= tbl3 .closingSpeed(p); tbl12 .rows.eta.Text=J>0 and G< huge and( format ("%.0fms",G*1000))or"away"; tbl12 .rows.eta.TextColor3=J>0 and  color2 or  color3 ;else I= fn10 (a); tbl12 .rows.eta.Text=I and E and k>1 and( format ("%.0fms",(I-E).Magnitude/k*1000))or"-"; tbl12 .rows.eta.TextColor3= color3 ;end; tbl12 .rows.dist.Text=C and( format ("%.0f",C))or"-"; tbl12 .rows.win.Text= format ("%.0f",K); tbl12 .rows.win.TextColor3=C and C<=K and(Color3.fromRGB(120,230,140))or  color3 ; tbl12 .rows.peak.Text= format ("%.0f", tbl12 .pk); tbl12 .rows.net.Text= format ("%.0f / %.0f",U, tbl12 .fps or 0);if  tbl12 .bar then U=C and K>0 and( clamp (1-C/(K*3),0,1))or 0; tbl12 .bar.Size=UDim2.new(U,0,1,0); tbl12 .bar.BackgroundColor3=C and C<=K and(Color3.fromRGB(120,230,140))or l;end;if  tbl12 .arrow and E then I,a,U= currentCamera .ViewportSize, currentCamera :WorldToViewportPoint(E);local p=a.X-I.X*0.5;local E=a.Y-I.Y*0.5;K=U and( max ( abs (p)/(I.X*0.5), abs (E)/(I.Y*0.5)))or 1; tbl12 .arrow.Visible=K>0.55;if not U then p,E=-p,-E;end; tbl12 .arrow.Rotation= deg (math.atan2(E,p))+90; tbl12 .arrow.TextColor3=d and(Color3.fromRGB(245,70,70))or l;end;end

		local function fn12()
			fn8()
			fn9()
			tbl12.c = tbl3.bind(RunService.RenderStepped:Connect(function(l) tbl12 .fn=( tbl12 .fn or 0)+1; tbl12 .fa=( tbl12 .fa or 0)+l;if  tbl12 .fa>=0.25 then  tbl12 .fps= tbl12 .fn/ tbl12 .fa; tbl12 .fn=0; tbl12 .fa=0;end; tbl12 .acc= tbl12 .acc+l;if  tbl12 .acc<0.06 then return;end; tbl12 .acc=0; fn11 ();end))
		end

		toggles.ballhud:OnChanged(function(arg)
			if arg then
				fn12()
			else
				fn8()
			end
		end)

		local function fn13()
			local v3 = tbl3.safehum()

			if v3 then
				v3.WalkSpeed = toggles.spdon.Value and (options.spdval.Value or 32) or 32
			end
		end

		local function fn14()
			local v3 = tbl3.safehum()

			if v3 then
				v3.UseJumpPower = true
				v3.JumpPower = toggles.jmpon.Value and (options.jmpval.Value or 50) or 50
			end
		end

		toggles.spdon:OnChanged(fn13)

		options.spdval:OnChanged(function()
			if toggles.spdon.Value then
				fn13()
			end
		end)

		toggles.jmpon:OnChanged(fn14)

		options.jmpval:OnChanged(function()
			if toggles.jmpon.Value then
				fn14()
			end
		end)

		local function fn15(arg)
			local humanoid = arg and arg:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				return
			end

			tbl3.bind(humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				local value = toggles.spdon.Value

				if value then
					value = abs(humanoid.WalkSpeed - (options.spdval.Value or 32)) > 0.5
				end

				if value then
					fn13()
				end
			end))

			tbl3.bind(humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
				local value = toggles.jmpon.Value

				if value then
					value = abs(humanoid.JumpPower - (options.jmpval.Value or 50)) > 0.5
				end

				if value then
					fn14()
				end
			end))
		end

		tbl3.bind(localPlayer.CharacterAdded:Connect(function(character)
			task.wait(0.4)

			if toggles.spdon.Value then
				fn13()
			end

			if toggles.jmpon.Value then
				fn14()
			end

			fn15(character)
		end))

		if localPlayer.Character then
			fn15(localPlayer.Character)
		end

		tbl3.bindt(task.spawn(function()
			while true do
				task.wait(0.35)

				if toggles.spdon.Value then
					local flag2 = tbl3.safehum()

					if flag2 then
						flag2 = abs(flag2.WalkSpeed - (options.spdval.Value or 32)) > 0.5
					end

					if flag2 then
						fn13()
					end
				end
			end
		end))

		tbl3.bind(UserInputService.JumpRequest:Connect(function()
			if toggles.infjump and toggles.infjump.Value then
				local v3 = tbl3.safehum()

				if v3 then
					v3:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end))

		local tbl13 = {}
		local v3 = nil

		local function ewapply()
			if not getconnections then
				return
			end
			local v4 = tbl3.safehum()
			if not v4 then
				return
			end

			if v3 ~= v4 then
				tbl13 = {}
				v3 = v4
			end

			local signal = v4:GetPropertyChangedSignal("MoveDirection")
			if not signal then
				return
			end

			if toggles.emotewalk.Value then
				local v5 = getconnections(signal)
				if type(v5) ~= "table" then
					return
				end

				for _, v6 in ipairs(v5) do
					if not v6.ForeignState and v6.Enabled ~= false then
						v6:Disable()
						tbl13[#tbl13 + 1] = v6
					end
				end
			else
				for _, v5 in ipairs(tbl13) do
					v5:Enable()
				end

				tbl13 = {}
				local v5 = getconnections(signal)

				if type(v5) == "table" then
					for _, v6 in ipairs(v5) do
						if not v6.ForeignState and v6.Enabled == false then
							v6:Enable()
						end
					end
				end
			end
		end

		tbl3.ewapply = ewapply

		tbl3.ewrestore = function()
			for _, v4 in ipairs(tbl13) do
				v4:Enable()
			end

			tbl13 = {}
		end

		toggles.emotewalk:OnChanged(function()
			ewapply()
		end)

		tbl3.bind(localPlayer.CharacterAdded:Connect(function()
			if toggles.emotewalk.Value then
				task.wait(1)
				ewapply()
			end
		end))

		tbl3.bindt(task.spawn(function()
			task.wait(2)

			if toggles.emotewalk.Value then
				ewapply()
			end
		end))

		local function fn16()
			if toggles.lobbyparry and not toggles.lobbyparry.Value then
				return
			end
			localPlayer:SetAttribute("LobbyParry", true)
		end

		fn16()

		toggles.lobbyparry:OnChanged(function(arg)
			if arg then
				fn16()
			else
				localPlayer:SetAttribute("LobbyParry", nil)
			end
		end)

		tbl3.bind(localPlayer:GetAttributeChangedSignal("LobbyParry"):Connect(function()
			if not localPlayer:GetAttribute("LobbyParry") then
				task.defer(fn16)
			end
		end))

		tbl3.bind(localPlayer.CharacterAdded:Connect(function()
			task.wait(0.5)
			fn16()
		end))

		tbl3.inlobby = function()local l= tbl3 .safechar();if not l or not  dead or l.Parent~= dead then return false;end;return( localPlayer :GetAttribute("LobbyTraining")or( localPlayer :GetAttribute("LobbyParry")))and true or false;end
		local obj = setmetatable({}, { __mode = "k" })
		local tbl14 = {}

		local function applycos()
			local v4 = tbl3.safechar()
			if not v4 then
				return
			end

			if toggles.headless.Value then
				local head = v4:FindFirstChild("Head")

				if head then
					head.Transparency = 1
					local decal = head:FindFirstChildOfClass("Decal")

					if decal then
						decal.Transparency = 1
					end
				end

				for _, child in ipairs(v4:GetChildren()) do
					if child:IsA("Accessory") and child.AccessoryType == Enum.AccessoryType.Hair then
						local handle = child:FindFirstChild("Handle")

						if handle then
							handle.Transparency = 1
						end
					end
				end
			end

			if toggles.korblox.Value then
				local humanoid = v4:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 then
					local rightUpperLeg = v4:FindFirstChild("RightUpperLeg")

					if rightUpperLeg and rightUpperLeg:IsA("MeshPart") then
						if not obj[rightUpperLeg] then
							obj[rightUpperLeg] = { mesh = rightUpperLeg.MeshId, tex = rightUpperLeg.TextureID, tr = rightUpperLeg.Transparency }
						end

						rightUpperLeg.MeshId = "rbxassetid://902942096"
						rightUpperLeg.TextureID = "rbxassetid://902843398"
					end

					for _, v5 in ipairs({ "RightLowerLeg", "RightFoot" }) do
						local v6 = v4:FindFirstChild(v5)

						if v6 then
							if not obj[v6] then
								obj[v6] = { tr = v6.Transparency }
							end

							v6.Transparency = 1
						end
					end
				else
					local rightLeg = v4:FindFirstChild("Right Leg")

					if rightLeg and not rightLeg:FindFirstChild("KorbloxMesh") then
						for _, child in ipairs(rightLeg:GetChildren()) do
							if child:IsA("SpecialMesh") then
								tbl14[#tbl14 + 1] = {
									nm = child.Name,
									mesh = child.MeshId,
									tex = child.TextureId,
									off = child.Offset,
									sc = child.Scale,
									mt = child.MeshType,
								}

								child:Destroy()
							end
						end

						local specialMesh = Instance.new("SpecialMesh")
						specialMesh.Name = "KorbloxMesh"
						specialMesh.MeshId = "rbxassetid://902942096"
						specialMesh.TextureId = "rbxassetid://902843398"
						specialMesh.Offset = Vector3.new(0, 0.7, 0)
						specialMesh.Parent = rightLeg
					end
				end
			end
		end

		local function fn17()
			local v4 = tbl3.safechar()
			if not v4 then
				return
			end
			local head = v4:FindFirstChild("Head")

			if head and head.Transparency == 1 then
				head.Transparency = 0
			end

			head = head and head:FindFirstChildOfClass("Decal")

			if head and head.Transparency == 1 then
				head.Transparency = 0
			end

			for _, child in ipairs(v4:GetChildren()) do
				if child:IsA("Accessory") and child.AccessoryType == Enum.AccessoryType.Hair then
					local handle = child:FindFirstChild("Handle")

					if handle and handle.Transparency == 1 then
						handle.Transparency = 0
					end
				end
			end
		end

		local function fn18()
			for k, v4 in pairs(obj) do
				if k.Parent then
					if v4.mesh then
						k.MeshId = v4.mesh
					end

					if v4.tex then
						k.TextureID = v4.tex
					end

					if v4.tr then
						k.Transparency = v4.tr
					end
				end

				obj[k] = nil
			end

			local v4 = tbl3.safechar()
			if not v4 then
				return
			end
			local rightLeg = v4:FindFirstChild("Right Leg")
			if not rightLeg then
				return
			end
			local korbloxMesh = rightLeg:FindFirstChild("KorbloxMesh")

			if korbloxMesh then
				korbloxMesh:Destroy()
			end

			for _, v5 in ipairs(tbl14) do
				local specialMesh = Instance.new("SpecialMesh")
				specialMesh.Name = v5.nm
				specialMesh.MeshType = v5.mt
				specialMesh.MeshId = v5.mesh
				specialMesh.TextureId = v5.tex
				specialMesh.Offset = v5.off
				specialMesh.Scale = v5.sc
				specialMesh.Parent = rightLeg
			end

			table.clear(tbl14)
		end

		tbl3.applycos = applycos

		tbl3.restorecos = function()
			fn17()
			fn18()
		end

		toggles.headless:OnChanged(function(arg)
			if arg then
				applycos()
			else
				fn17()
			end
		end)

		toggles.korblox:OnChanged(function(arg)
			if arg then
				applycos()
			else
				fn18()
			end
		end)

		tbl3.bind(localPlayer.CharacterAppearanceLoaded:Connect(function()
			task.wait(0.2)
			applycos()
		end))

		tbl3.bind(localPlayer.CharacterAdded:Connect(function()
			task.wait(0.8)
			applycos()
		end))

		local tbl15 = { PC = "PC", Phone = "Mobile", Tablet = "Tablet", Console = "Console" }
		local tbl16 = { "PlayerProfileController", "AnalyticsController" }
		local v4 = nil
		local v5 = nil
		local value = nil
		local function_ = nil
		local v6 = nil
		local v7 = nil
		local v8 = nil

		local function fn19(arg)
			if type(arg) ~= "function" then
				return ""
			end
			local v9 = debug.info(arg, "s")
			return type(v9) == "string" and v9 or ""
		end

		local function fn20(arg)
			if type(arg) ~= "function" then
				return false
			end

			if not islclosure(arg) then
				return false
			end

			if fn19(arg):find("DeviceListener", 1, true) == nil then
				return false
			end
			local v9 = getupvalues(arg)
			if type(v9) ~= "table" then
				return false
			end
			local n2 = 0
			local flag2 = false
			local flag3 = false

			for _, v10 in pairs(v9) do
				n2 += 1

				if v10 == v4 then
					flag2 = true
				elseif type(v10) == "function" then
					flag3 = true
				end
			end

			return n2 == 2 and flag2 and flag3
		end

		local function fn21()
			if not v4 then
				local clientGameModules = ReplicatedStorage:FindFirstChild("ClientGameModules")
				clientGameModules = clientGameModules and clientGameModules:FindFirstChild("DeviceListener")
				if not clientGameModules then
					return false
				end
				local module = require(clientGameModules)
				if type(module) ~= "table" or rawget(module, "OnChange") == nil then
					return false
				end
				v4 = module
				local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
				playerScripts = playerScripts and playerScripts:FindFirstChild("Client")
				playerScripts = playerScripts and playerScripts:FindFirstChild("DeviceChecker")

				if playerScripts then
					local module2 = require(playerScripts)

					if type(module2) == "table" and type(rawget(module2, "GetDeviceType")) == "function" then
						v5 = module2
						value = rawget(module2, "GetDeviceType")
					end
				end
			end

			if function_ then
				return true
			end

			if not getconnections then
				return false
			end

			for _, v9 in ipairs({ UserInputService.LastInputTypeChanged, currentCamera:GetPropertyChangedSignal("ViewportSize") }) do
				for _, v10 in ipairs(getconnections(v9)) do
					if not v10.ForeignState and fn20(v10.Function) then
						function_ = v10.Function
						break
					end
				end

				if not function_ then
					continue
				end
				break
			end

			if not function_ then
				return false
			end
			local v9 = getupvalues(function_)

			for k, v10 in pairs(v9) do
				if type(v10) == "function" then
					v6 = k
					break
				end
			end

			if not v6 then
				function_ = nil
				return false
			end
			v7 = v9[v6]
			return true
		end

		local function fn22()
			local value2 = rawget(v4, "OnChange")
			local tbl17 = {}
			local value3 = type(value2) == "table" and rawget(value2, "_handlerListHead") or nil

			while value3 do
				local value4 = rawget(value3, "_fn")
				local v9 = fn19(value4)
				local flag2 = false

				for _, v10 in ipairs(tbl16) do
					if v9:find(v10, 1, true) then
						flag2 = true
						break
					end
				end

				tbl17[#tbl17 + 1] = { node = value3, fn = value4, push = flag2 }
				value3 = rawget(value3, "_next")
			end

			return tbl17
		end

		local function fn23()
		end

		local str2 = "Rise_Device_" .. tostring(game.GameId) .. ".txt"

		tbl3.devstat = function()
			if not tbl3.dldev then
				return
			end
			fn21()
			local str3 = "?"

			if v4 then
				str3 = tostring(v7 and v7() or rawget(v4, "Device"))
			end

			local devtype = tbl10.devtype
			local devscreen = tbl10.devscreen
			local str4 = ("Your real device: %s\nOthers will see: %s\nYour screen: %s"):format(str3, devtype and devtype ~= "Off" and devtype or "your real one", devscreen and devscreen ~= "Off" and devscreen or "normal")
			if str4 == v8 then
				return
			end
			v8 = str4

			task.defer(function()
				tbl3.dldev:SetText(str4)
			end)
		end

		tbl3.devui = function(devscreen, arg)
			if not fn21() then
				if not arg then
					tbl3.notif("Device Spoofer", "Device data isn't ready yet. Try again in a second.", 4)
				end

				return
			end

			local flag2 = devscreen ~= nil and devscreen ~= "Off"
			local v9 = flag2 and devscreen or v7()
			local v10 = fn22()

			for _, v11 in ipairs(v10) do
				rawset(v11.node, "_fn", v11.push and fn23 or v11.fn)
			end

			rawset(v4, "Device", "\0")

			setupvalue(function_, v6, function()
				return v9
			end)

			function_()

			for _, v11 in ipairs(v10) do
				rawset(v11.node, "_fn", v11.fn)
			end

			if v5 then
				v5.GetDeviceType = flag2 and function()
					return tbl15[devscreen] or devscreen
				end or value
			end

			tbl10.devscreen = devscreen
			tbl3.devstat()
			if arg then
				return
			end
			tbl3.notif("Device Spoofer", flag2 and "Your screen now acts like " .. devscreen .. "." or "Screen back to normal. Rejoin to fully clear the mobile layout.", 5)
		end

		tbl3.devarm = function(devtype, arg)
			tbl10.devtype = devtype

			if writefile then
				writefile(str2, devtype)
			end

			if type(queueonteleport) ~= "function" then
				tbl3.devstat()

				if not arg then
					tbl3.notif("Device Spoofer", "Your executor can't queue scripts, so this won't stick.", 6)
				end

				return
			end

			queueonteleport(([[task.spawn(function()
    local f = %q
    if not (isfile and readfile and isfile(f)) then return end
    local want = readfile(f)
    want = type(want) == "string" and want:match("^%%s*(.-)%%s*$") or nil
    if not want or want == "" or want == "Off" then return end
    local rs = game:GetService("ReplicatedStorage")
    local m = rs:WaitForChild("ClientGameModules", 60)
    m = m and m:WaitForChild("DeviceListener", 60)
    if not m then return end
    local dl = require(m)
    local ob = rawget(dl, "Observe")
    if type(ob) ~= "function" then return end
    local n = 0
    rawset(dl, "Observe", function(self, fn, ...)
        local s = debug.info(2, "s")
        s = type(s) == "string" and s or ""
        if s:find("PlayerProfileController", 1, true) or s:find("AnalyticsController", 1, true) then
            local was = rawget(self, "Device")
            rawset(self, "Device", want)
            local a, b = ob(self, fn, ...)
            rawset(self, "Device", was)
            n = n + 1
            if n >= 2 then rawset(dl, "Observe", ob) end
            return a, b
        end
        return ob(self, fn, ...)
    end)
end)
]]):format(str2))

			tbl3.devstat()
			if arg then
				return
			end

			if devtype == "Off" then
				tbl3.notif("Device Spoofer", "Off. Rejoin to go back to your real device.", 5)
				return
			end
			tbl3.notif("Device Spoofer", "Others will see " .. devtype .. ". Rejoining now.", 4)

			tbl3.bindt(task.delay(1.5, function()
				if fn3 then
					fn3()
				end
			end))
		end

		toggles.rainbowball:OnChanged(function(arg)
			localPlayer:SetAttribute("RainbowBall", arg and true or nil)
		end)

		local tbl17 = { hls = setmetatable({}, { __mode = "k" }), conn = nil }

		local function fn24()
			for k, v9 in pairs(tbl17.hls) do
				v9:Destroy()
				tbl17.hls[k] = nil
			end
		end

		local function fn25()local l= options .ballcolorpick and  options .ballcolorpick.Value or(Color3.fromRGB(0,200,255));for K,p in ipairs( tbl3 .ballList())do K= tbl17 .hls[p];if not K or not K.Parent then K=Instance.new("Highlight");K.Name="\0bc";K.FillTransparency=0.35;K.OutlineTransparency=0;K.Adornee=p;K.Parent= fn6 and( fn6 ())or  CoreGui ; tbl17 .hls[p]=K;end;K.FillColor=l;K.OutlineColor=l;end;for l,K in pairs( tbl17 .hls)do if not l.Parent then K:Destroy(); tbl17 .hls[l]=nil;end;end;end

		local function fn26()
			if tbl17.conn then
				return
			end
			tbl17.acc = 0
			tbl17.conn = tbl3.bind(RunService.Heartbeat:Connect(function(l) tbl17 .acc= tbl17 .acc+l;if  tbl17 .acc<0.06 then return;end; tbl17 .acc=0; fn25 ();end))
		end

		local function fn27()
			if tbl17.conn then
				tbl17.conn:Disconnect()
				tbl17.conn = nil
			end

			fn24()
		end

		toggles.ballcolor:OnChanged(function(arg)
			if arg then
				fn26()
			else
				fn27()
			end
		end)

		local tbl18 = { g = nil, conn = nil, lbl = nil, frames = 0, t = 0 }

		local function fn28()
			if tbl18.conn then
				tbl18.conn:Disconnect()
				tbl18.conn = nil
			end

			if tbl18.g then
				tbl18.g:Destroy()
				tbl18.g = nil
			end
		end

		local function fn29()
			fn28()
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "\0fp"
			screenGui.ResetOnSpawn = false
			screenGui.IgnoreGuiInset = true
			screenGui.DisplayOrder = 55
			screenGui.Parent = v.ScreenGui or fn6 and fn6() or CoreGui
			tbl18.g = screenGui
			local frame = Instance.new("Frame")
			frame.AnchorPoint = Vector2.new(1, 0)
			frame.Position = UDim2.new(1, -16, 0, 90)
			frame.Size = UDim2.fromOffset(104, 46)
			frame.BackgroundColor3 = color
			frame.BackgroundTransparency = 0.04
			frame.BorderSizePixel = 0
			frame.ZIndex = 1
			frame.Parent = screenGui
			tbl3.corner(frame, 12)
			local uiGradient = Instance.new("UIGradient")
			uiGradient.Rotation = 90
			local color4 = Color3.fromRGB
			uiGradient.Color = ColorSequence.new(Color3.fromRGB(12, 52, 82), color4(3, 26, 44))
			uiGradient.Parent = frame
			tbl3.stroke(frame, Color3.fromRGB(255, 255, 255), 1, 0.9)
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = "rbxassetid://6014261993"
			imageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			imageLabel.ImageTransparency = 0.45
			imageLabel.ScaleType = Enum.ScaleType.Slice
			imageLabel.SliceCenter = Rect.new(49, 49, 450, 450)
			imageLabel.Position = UDim2.fromOffset(-15, -15)
			imageLabel.Size = UDim2.new(1, 30, 1, 30)
			imageLabel.ZIndex = 0
			imageLabel.Parent = frame
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.fromScale(1, 1)
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 14
			textLabel.LineHeight = 1.15
			textLabel.TextColor3 = color2
			textLabel.ZIndex = 2
			textLabel.Text = "-"
			textLabel.Parent = frame
			tbl3.dragify(frame, frame)
			tbl18.lbl = textLabel
			tbl18.t = clock()
			tbl18.frames = 0
			tbl18.conn = tbl3.bind(RunService.RenderStepped:Connect(function() tbl18 .frames= tbl18 .frames+1;local l= clock ();if l- tbl18 .t>=0.5 then local K= floor ( tbl18 .frames/(l- tbl18 .t)+0.5); tbl18 .frames=0; tbl18 .t=l; tbl18 .lbl.Text= format ("%d FPS\10%d ms",K, floor ( tbl3 .getping()+0.5));end;end))
		end

		toggles.fpscounter:OnChanged(function(arg)
			if arg then
				fn29()
			else
				fn28()
			end
		end)

		local tbl19 = { conn = nil, last = 0, acc = 0, btns = setmetatable({}, { __mode = "k" }) }
		local function fn30(l)if l:IsA("GuiButton")and(l.Name=="PlayAgain"or l.Name=="RematchButton")then  tbl19 .btns[l]=true;end;end
		local function fn31()if  tbl19 .hooked then return;end;local l= localPlayer :FindFirstChild("PlayerGui");if not l then return;end; tbl19 .hooked=true;for K,K in ipairs(l:GetDescendants())do  fn30 (K);end; tbl3 .bind(l.DescendantAdded:Connect( fn30 ));end
		local function fn32()local l= ReplicatedStorage :FindFirstChild("ServerInfo");local K=l and(l:FindFirstChild("numPlayers"));local l=K and(tonumber(K.Value))or 2;return  clamp (math.ceil(l/2),1,4);end
		local function fn33()if not  tbl19 .serverinfo then local l= ReplicatedStorage :FindFirstChild("ServerInfo");if l then  tbl19 .serverinfo=require(l);end;end;local l= tbl19 .serverinfo;if type(l)~="table"then return false;end;return(l.isRankedMatchServer and(l.isRankedMatchServer())or l.isNoAbilityRankedMatchServer and(l.isNoAbilityRankedMatchServer())or false)==true;end
		local function fn34()if tick()- tbl19 .last<1.5 then return;end;if  localPlayer :GetAttribute("Rematch")then return;end; fn31 ();for l in pairs( tbl19 .btns)do if l.Parent and l.Visible and l.AbsoluteSize.X>0 then if l.Name=="RematchButton"then local l= tbl3 .netremote("PlayerWantsRematch");if l and(l:IsA("RemoteEvent"))then  tbl19 .last=tick();l:FireServer();return;end;else if  fn33 ()then continue;end;local l= tbl3 .netremote("SetDuelAutoQueue");if l and(l:IsA("RemoteEvent"))then local K= fn32 (); tbl19 .last=tick();l:FireServer("Duel",K.."v"..K);return;end;end;end;end;end

		toggles.autorematch:OnChanged(function(arg)
			if arg then
				fn31()

				if not tbl19.conn then
					tbl19.conn = tbl3.bind(RunService.Heartbeat:Connect(function(l) tbl19 .acc= tbl19 .acc+l;if  tbl19 .acc<0.5 then return;end; tbl19 .acc=0; fn34 ();end))
				end
			elseif tbl19.conn then
				tbl19.conn:Disconnect()
				tbl19.conn = nil
			end
		end)

		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("RoundEnded")

		if remotes then
			tbl3.bind(remotes.OnClientEvent:Connect(function(l)if not( toggles .autorematch and  toggles .autorematch.Value)then return;end;if type(l)=="table"and l.successful==false then return;end; fn31 (); tbl3 .bindt(task.delay(0.5, fn34 ));end))
		end

		tbl3.initsword = function()
			if tbl9.swords then
				return tbl9.swords
			end
			local swtried = tbl9.swtried

			if swtried then
				local swtried2 = tbl9.swtried
				swtried = clock() - swtried2 < 3
			end

			if swtried then
				return nil
			end
			tbl9.swtried = clock()
			local shared = ReplicatedStorage:WaitForChild("Shared", 5)
			shared = shared and shared:WaitForChild("ReplicatedInstances", 5)
			tbl9.swmod = shared and shared:WaitForChild("Swords", 5)

			if tbl9.swmod then
				tbl9.swords = require(tbl9.swmod)
			end

			if not tbl9.swords then
				tbl3.logwev("swordinit", 30, "sword skin", "Shared.ReplicatedInstances.Swords not ready - will retry")
				return nil
			end
			tbl9.swtried = nil
			local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
			remotes2 = remotes2 and remotes2:FindFirstChild("FireSwordInfo")

			if remotes2 and getconnections then
				for _, v9 in ipairs(getconnections(remotes2.OnClientEvent)) do
					if not v9.ForeignState and v9.Function and islclosure(v9.Function) then
						local v10 = getupvalues(v9.Function)
						local n2 = 0
						local v11 = nil

						for _, v12 in pairs(v10) do
							n2 += 1
							v11 = v12
						end

						if n2 == 1 and type(v11) == "table" then
							tbl9.swctrl = v11
							break
						end
					end
				end
			end

			tbl9.swbind = tbl9.swmod and tbl9.swmod:FindFirstChild("EquipSwordTo")
			return tbl9.swords
		end

		tbl3.equipsword = function(arg, arg2, arg3, arg4)
			local swords = tbl9.swords
			if not swords then
				return
			end

			if arg4 then
				arg:SetAttribute("_generationCtx_Swords", "")
			end

			if not arg3 and tbl9.swbind and tbl9.swbind:IsA("BindableFunction") then
				tbl9.swbind:Invoke(arg, arg2)
				return
			end
			swords:EquipSwordTo(arg, arg2, arg:GetAttribute("ScaleSword"), arg3)
		end

		tbl3.swequipped = function()local l= tbl3 .safechar();local K=l and(l:GetAttribute("CurrentlyEquippedSword"));K=if type(K)~="string"or K==""then( localPlayer :GetAttribute("CurrentlyEquippedSword"))else K;return type(K)=="string"and K~=""and K or nil;end

		tbl3.setswattr = function(arg)
			local v9 = tbl3.safechar()

			if v9 then
				v9:SetAttribute("CurrentlyEquippedSword", arg)
			end

			localPlayer:SetAttribute("CurrentlyEquippedSword", arg)
		end

		tbl3.slashname = function(l)if not  tbl9 .swords then return"SlashEffect";end;local K= tbl9 .swords:GetSword(l);if type(K)=="table"then l=K.SlashName or K.Slash or K.SlashEffect or K.SlashParticle;if type(l)=="string"and l~=""then return l;end;end;return"SlashEffect";end

		tbl3.applysword = function()
			if not tbl10.swskin then
				return
			end
			local swname = tbl10.swname
			if not swname or swname == "" then
				return
			end
			tbl3.initsword()
			if not tbl9.swords or not tbl9.swords:GetSword(swname) then
				return
			end
			local v9 = tbl3.safechar()
			if not v9 then
				return
			end

			if tbl9.swbad[swname] then
				return false
			end

			if type(tbl9.swords.GetInstance) == "function" then
				if not tbl9.swords:GetInstance(swname) then
					tbl9.swbad[swname] = true
					tbl3.notif("Skins", ("The server never sent the %s model. Pick another sword."):format(swname), 7)
					return false
				end
			end

			tbl3.equipsword(v9, swname)
			tbl3.fxwarm(swname)

			if tbl9.swctrl and tbl9.swctrl.SetSword then
				tbl9.swctrl:SetSword(swname)
			end

			if getgenv and getgenv().__vexBaseSwordPos ~= false then
				local torso = v9:FindFirstChild("Torso")
				local v10 = v9:FindFirstChild(swname)

				if torso and v10 then
					for _, v11 in ipairs({ "Motor6D", "Motor6D2" }) do
						local v12 = torso:FindFirstChild(v11)

						if v12 then
							local attribute = v10:GetAttribute("C0Offset")
							local attribute2 = v10:GetAttribute("C1Offset")

							if attribute then
								v12.C0 = v12.C0 * attribute:Inverse()
							end

							if attribute2 then
								v12.C1 = v12.C1 * attribute2:Inverse()
							end
						end
					end
				end
			end

			return true
		end

		tbl3.cleanstray = function(arg, arg2)
			if not tbl9.swords then
				return
			end

			for _, child in ipairs(arg:GetChildren()) do
				if child:IsA("Model") and child.Name ~= arg2 and tbl9.swords:GetSword(child.Name) then
					child:Destroy()
				end
			end
		end

		tbl3.ensureskin = function()
			if not tbl10.swskin then
				return
			end
			local swname = tbl10.swname
			if not swname or swname == "" then
				return
			end
			tbl3.initsword()
			if not tbl9.swords or not tbl9.swords:GetSword(swname) then
				return
			end
			local v9 = tbl3.safechar()
			if not v9 then
				return
			end

			if not v9:FindFirstChild(swname) or tbl3.swequipped() ~= swname then
				tbl3.applysword()
			elseif tbl9.swctrl and tbl9.swctrl.SetSword and tbl9.swctrl.CharacterSword ~= swname then
				tbl9.swctrl:SetSword(swname)
			end
		end

		tbl3.swordfx = function()
			if tbl9.fxmod then
				return tbl9.fxmod
			end
			local shared = ReplicatedStorage:FindFirstChild("Shared")
			shared = shared and shared:FindFirstChild("ReplicatedInstances")
			shared = shared and shared:FindFirstChild("SwordFX")
			if not shared then
				return nil
			end
			local module = require(shared)

			if type(module) == "table" then
				tbl9.fxmod = module
			end

			return tbl9.fxmod
		end

		tbl3.fxwarm = function(arg)
			if not arg or arg == "" then
				return
			end
			local fxwarm = tbl3.slashname(arg)
			if tbl9.fxwarm[fxwarm] then
				return
			end
			tbl9.fxwarm[fxwarm] = true

			tbl3.bindt(task.spawn(function()
				local v9 = tbl3.swordfx()
				if not v9 or type(v9.GetInstance) ~= "function" then
					tbl9.fxwarm[fxwarm] = nil
					return
				end

				if not v9:GetInstance(fxwarm) then
					tbl9.fxwarm[fxwarm] = nil
					tbl3.logwev("fxwarm:" .. fxwarm, 30, "sword skin", ("the server did not send the %s slash effect"):format(fxwarm))
				end
			end))
		end

		tbl3.slashsigs = function()
			local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
			if not remotes2 then
				return nil, nil
			end
			local parrySuccessAll = remotes2:FindFirstChild("ParrySuccessAll")
			local parrySuccessClient = remotes2:FindFirstChild("ParrySuccessClient")
			return parrySuccessAll and parrySuccessAll.OnClientEvent or nil, parrySuccessClient and parrySuccessClient.Event or nil
		end

		tbl3.livecons = function(arg)
			local tbl20 = {}
			if not arg then
				return tbl20
			end
			local v9 = getconnections(arg)
			if type(v9) ~= "table" then
				return tbl20
			end

			for _, v10 in ipairs(v9) do
				if not v10.ForeignState and v10.Function then
					tbl20[#tbl20 + 1] = v10
				end
			end

			return tbl20
		end

		tbl3.slashfind = function(arg, arg2)
			local v9 = tbl3.livecons(arg)
			local v10 = tbl3.livecons(arg2)
			local tbl20 = {}

			for _, v11 in ipairs(v9) do
				tbl20[v11.Function] = true
			end

			for _, v11 in ipairs(v10) do
				if tbl20[v11.Function] then
					return v11.Function, v9, v10
				end
			end

			local value2 = getinfo or debug and rawget(debug, "getinfo")

			if value2 then
				for _, v11 in ipairs(v9) do
					local v12 = value2(v11.Function)
					if type(v12) == "table" and v12.name == "parrySuccessAll" then
						return v11.Function, v9, v10
					end
				end
			end

			if #v9 == 1 and islclosure(v9[1].Function) then
				return v9[1].Function, v9, v10
			end
			return nil, v9, v10
		end

		tbl3.slashwrap = function(...)if setthreadidentity then setthreadidentity(2);end;local l=table.pack(...);if( tbl10 .swskin or  tbl10 .unlockall)and tostring(l[4])== localPlayer .Name then local K= tbl9 .swctrl and  tbl9 .swctrl.CharacterSword;K=if not(if not K or K==""then( tbl3 .swequipped())else K)or(if not K or K==""then( tbl3 .swequipped())else K)==""then  tbl10 .swname else if not K or K==""then( tbl3 .swequipped())else K;if K and K~=""and  tbl9 .swords and( tbl9 .swords:GetSword(K))then l[1]= tbl3 .slashname(K);l[3]=K;end;end;return  tbl9 .slashorig(table.unpack(l,1,l.n));end

		tbl3.hookslash = function()
			if tbl9.slashhooked then
				return true
			end

			if not getconnections then
				return false
			end
			local v9, v10 = tbl3.slashsigs()
			if not v9 then
				return false
			end
			local v11, v12, v13 = tbl3.slashfind(v9, v10)
			if not v11 then
				return false
			end
			local n2 = 0

			local function fn35(arg)
				for _, v14 in ipairs(arg) do
					if v14.Function == v11 then
						v14:Disable()

						if v14.Enabled == false then
							n2 += 1
							tbl9.slashoff[#tbl9.slashoff + 1] = v14
						end
					end
				end
			end

			fn35(v12)
			fn35(v13)
			if n2 == 0 then
				return false
			end
			tbl9.slashorig = v11
			tbl3.bind(v9:Connect(tbl3.slashwrap))

			if v10 then
				tbl3.bind(v10:Connect(tbl3.slashwrap))
			end

			tbl9.slashhooked = true
			tbl3.fxwarm(tbl10.swname)
			return true
		end

		tbl3.startslash = function()
			if tbl9.slashtask then
				return
			end

			tbl9.slashtask = tbl3.bindt(task.spawn(function()
				for i = 1, 60 do
					if tbl3.hookslash() then
						return
					end
					task.wait(0.25)
				end

				tbl3.notif("Skins", "Rise can't change the slash effect here. Skins keep the default one.", 8)
			end))
		end

		tbl3.skinloop = function()
			if tbl9.skinstarted then
				return
			end
			tbl9.skinstarted = true
			tbl3.initsword()
			tbl3.startslash()

			if not tbl9.holsterhooked and tbl9.swctrl and tbl9.swctrl.OnCharacterSwordUpdate then
				local onCharacterSwordUpdate = tbl9.swctrl.OnCharacterSwordUpdate

				if onCharacterSwordUpdate.Connect then
					tbl3.bind(onCharacterSwordUpdate:Connect(function(arg)
						if not tbl10.swskin or tbl10.swname == "" or arg == tbl10.swname then
							return
						end

						if not tbl10.unlockall and not tbl10.autoload and type(arg) == "string" and arg ~= "" then
							if tbl9.skinbusy then
								task.defer(tbl3.ensureskin)
								return
							end
							tbl10.swskin = false
							tbl10.swname = ""
							return
						end

						task.defer(tbl3.ensureskin)
					end))

					tbl9.holsterhooked = true
				end
			end

			tbl3.bind(localPlayer.CharacterAdded:Connect(function(character)
				if not tbl10.swskin or tbl10.swname == "" then
					return
				end
				tbl9.skinbusy = true
				character:WaitForChild("HumanoidRootPart", 10)
				local n2 = clock() + 6

				while not (character:GetAttribute("AppearanceLoaded") or localPlayer:GetAttribute("AppearanceLoaded")) and clock() < n2 do
					task.wait(0.1)
				end

				task.wait(0.2)
				tbl3.applysword()

				for i = 1, 8 do
					task.wait(0.35)
					if not tbl10.swskin or not character.Parent then
						tbl9.skinbusy = false
						return
					end
					tbl3.ensureskin()
					tbl3.cleanstray(character, tbl10.swname)
				end

				tbl9.skinbusy = false
			end))

			tbl3.bindt(task.spawn(function()
				while task.wait(2) do
					if tbl10.swskin and tbl10.swname ~= "" then
						if not tbl10.unlockall and not tbl10.autoload and not tbl9.skinbusy then
							local v9 = tbl3.swequipped()

							if type(v9) == "string" and v9 ~= "" and v9 ~= tbl10.swname then
								tbl10.swskin = false
								tbl10.swname = ""
							end
						end

						if tbl10.swskin then
							local v9 = tbl3.safechar()

							if v9 then
								tbl3.ensureskin()
								tbl3.cleanstray(v9, tbl10.swname)
							end
						end
					end
				end
			end))
		end

		tbl3.parryanims = function(l,K)local p= tbl9 .grabcache;if p and p.sword==K then return p.anims;end;p= ReplicatedStorage :WaitForChild("Shared",10);local E=p and(p:WaitForChild("SwordAPI",10));if not E then return;end;local k=p:WaitForChild("ReplicatedInstances",10);p=k and(k:WaitForChild("Swords",10));k=p and(p.GetSword:Invoke(K));if not(k and k.AnimationType)then return;end;p=require(E);if type(p)=="table"and type(p.GetAnimations)=="function"then local a=p:GetAnimations(l,{"Parry","GrabParry"},k.AnimationType,k.SwordType);if type(a)=="table"and#a>0 then  tbl9 .grabcache={sword=K,anims=a};return a;end;end;p=E:FindFirstChild("Collection");if not p then return;end;l=p:FindFirstChild(k.AnimationType);k=l and(l:FindFirstChild("Parry")or(l:FindFirstChild("Grab"))or(l:FindFirstChild("GrabParry")))or p:FindFirstChild("Default")and(p.Default:FindFirstChild("Parry")or(p.Default:FindFirstChild("GrabParry")));l=if k then{k}else nil; tbl9 .grabcache={sword=K,anims=l};return l;end
		tbl3.playgrab = function()local l= tbl3 .safechar();if not l then return;end;if  clock ()- tbl9 .lastgrab< tbl9 .grabcd then return;end;local K=l:GetAttribute("CurrentlyEquippedSword");K=if  tbl10 .swskin and  tbl10 .swname~=""then  tbl10 .swname else K;if not K then return;end;local p=l:FindFirstChildOfClass("Humanoid");local E=p and(p:FindFirstChildOfClass("Animator"));if not E then return;end;p= tbl3 .parryanims(l,K);if not p or#p==0 then return;end; tbl9 .lastgrab= clock ();if  tbl9 .grabtracks_sword~=K or  tbl9 .grabtracks_anim~=E or not  tbl9 .grabtracks then if  tbl9 .grabtracks then for k,k in ipairs( tbl9 .grabtracks)do k.track:Stop(0);k.track:Destroy();end;end; tbl9 .grabtracks={};for k,a in ipairs(p)do k=E:LoadAnimation(a);if k then for d,I in pairs(a:GetAttributes())do k:SetAttribute(d,I);end; tbl9 .grabtracks[# tbl9 .grabtracks+1]={track=k,anim=a};end;end; tbl9 .grabtracks_sword=K; tbl9 .grabtracks_anim=E;end;for E,k in ipairs( tbl9 .grabtracks)do E,p=k.anim,k.track;k=E:GetAttribute("PlaySpeed")or 1;if p.IsPlaying then p:Stop(0.05);end;p:Play(E:GetAttribute("PlayFadeTime")or 0.1,E:GetAttribute("PlayWeight")or 1,k);K=p.Length or 0;local E=K~=0 and(K-p.TimePosition)*k or 1;l:SetAttribute("ParryTime", max (l:GetAttribute("ParryTime")or 0,E));end;end
		tbl3.stopgrab = function() tbl9 .lastgrab= clock ();if  tbl9 .grabtracks then for l,l in ipairs( tbl9 .grabtracks)do l.track:Stop(0.1);end;end;end
		tbl3.mouseplr = function()if not  alive or not  currentCamera then return nil;end;local l= tbl3 .safechar();if not l or l.Parent~= alive then return nil;end;l= UserInputService :GetMouseLocation();local K,p= huge ;for E,k in ipairs( alive :GetChildren())do if k.PrimaryPart and( tbl3 .validtgt(k))then local a,d= currentCamera :WorldToViewportPoint(k.PrimaryPart.Position);if d then E=(Vector2.new(a.X,a.Y)-Vector2.new(l.X,l.Y)).Magnitude;if E<K then K,p=E,k;end;end;end;end;return p;end
		tbl3.aimedplr = function()if not  alive or not  currentCamera then return nil;end;local l= tbl3 .safechar();if not l or l.Parent~= alive then return nil;end;l= currentCamera .ViewportSize;local K=l.X/2;local p=l.Y/2;local E,k= huge ;for a,d in ipairs( alive :GetChildren())do if d.PrimaryPart and( tbl3 .validtgt(d))then a,l= currentCamera :WorldToViewportPoint(d.PrimaryPart.Position);if l then local h=(Vector2.new(a.X,a.Y)-Vector2.new(K,p)).Magnitude;if h<E then E,k=h,d;end;end;end;end;return k;end
		tbl3.deflecting = function()if( tbl9 .defcast or 0)> clock ()then return true;end;local l= tbl3 .safechar();if not l then return false;end;return l:GetAttribute("IsRagingDeflection")==true or l:GetAttribute("IsRapture")==true;end
		tbl3.abact = function(l)l=l or( tbl3 .safechar());return l and l:GetAttribute("AbilityActive")==true or false;end
		tbl3.hotslots = { block = "Block", ability = "Ability" }
		tbl3.hotcache = {}
		tbl3.hotslot = function(l)local K= tbl3 .hotcache[l];if K and K.Parent then return K;end;K= localPlayer :FindFirstChild("PlayerGui");local p=K and(K:FindFirstChild("Hotbar"));if not p then return nil;end;K=p:FindFirstChild( tbl3 .hotslots[l]); tbl3 .hotcache[l]=K;return K;end
		tbl3.netremote = function(l)return  tbl8 .byname(l);end

		tbl3.phpos = function(arg)
			if arg:IsA("Model") then
				return arg:GetPivot().Position
			end

			if arg:IsA("BasePart") then
				return arg.Position
			end
			local basePart = arg:FindFirstChildWhichIsA("BasePart", true)
			return basePart and basePart.Position or nil
		end

		tbl3.borderparts = function()
			local map = Workspace:FindFirstChild("Map")

			if map then
				map = map:FindFirstChild("Borders", true) or map:FindFirstChild("Border", true)
			end

			if not map then
				return nil
			end

			local function fn35(arg)
				return arg:IsA("BasePart") and arg.Name ~= "FLOOR" and arg.Name ~= "BallFloor" and arg.CollisionGroup ~= "MapFloor" and arg.CollisionGroup ~= "BallFloor"
			end

			if map:IsA("BasePart") then
				return fn35(map) and { map } or nil
			end
			local tbl20 = {}

			for _, descendant in ipairs(map:GetDescendants()) do
				if fn35(descendant) then
					tbl20[#tbl20 + 1] = descendant
				end
			end

			return #tbl20 > 0 and tbl20 or nil
		end

		tbl3.pullaway = function()if not  tbl10 .pulldetect then return;end;local l= clock ();if l-( tbl9 .lastpull or 0)<1 then return;end;local K= tbl3 .safehrp();if not K or not  tbl3 .isalive()then return;end;local p= tbl3 .ballPos( tbl3 .getball());if not p then return;end; tbl9 .lastpull=l;l=K.Position-p;l=Vector3.new(l.X,0,l.Z);if l.Magnitude<0.1 then p=K.CFrame.LookVector;l=(Vector3.new(p.X,0,p.Z));end;if l.Magnitude<0.1 then return;end;l=l.Unit;local E,k=90, tbl3 .borderparts();if not k then  tbl3 .logwev("pullborder",30,"Pull Detection","map borders not found - teleport skipped");return;end;p=RaycastParams.new();p.FilterType=Enum.RaycastFilterType.Include;p.FilterDescendantsInstances=k;p.IgnoreWater=true;k= Workspace :Raycast(K.Position,l*E,p);E=if k then(k.Position-K.Position).Magnitude-10 else E;if E<8 then return;end;K.CFrame=K.CFrame+l*E;end

		tbl3.onphantom = function(arg)
			local name = arg.Name
			if name == "Pull" or name == "MaxPull" then
				tbl3.pullaway()
				return
			end

			if name ~= "transmissionpart" and name ~= "maxTransmission" then
				return
			end

			task.defer(function()
				local v9 = tbl3.safehrp()
				local v10 = tbl3.phpos(arg)

				if v9 and v10 and (v10 - v9.Position).Magnitude <= 32 then
					tbl3.clrload()
					tbl9.phactive = true

					task.delay(1, function()
						tbl9.phactive = false
					end)
				end
			end)
		end

		tbl3.stopphantom = function()
			if tbl9.phconn then
				tbl9.phconn:Disconnect()
				tbl9.phconn = nil
			end

			tbl9.phactive = false
		end

		tbl3.startphantom = function()
			tbl3.stopphantom()
			if not runtime then
				return
			end
			tbl9.phconn = tbl3.bind(runtime.ChildAdded:Connect(tbl3.onphantom))
		end
	end

	tbl3.staffact = function(arg)
		if not tbl10.staff then
			return
		end
		local str2 = tostring(arg:GetRoleInGroup(12836673)):lower()
		if str2 == "guest" or str2 == "member" or str2 == "" then
			return
		end
		local str3 = "Staff joined: " .. arg.DisplayName

		if tbl10.staffdo == "Auto Kick" then
			localPlayer:Kick(str3)
		elseif tbl10.staffdo == "Close Game" then
			game:Shutdown()
		elseif tbl10.staffdo == "Serverhop" then
			tbl3.notif("Staff Detection", "Staff joined. Hopping to another server.", 5)

			if fn4 then
				fn4()
			end
		else
			tbl3.notif("Staff Detection", str3, 15)
		end
	end

	tbl3.stopstaff = function()
		if tbl9.staffconn then
			tbl9.staffconn:Disconnect()
			tbl9.staffconn = nil
		end
	end

	tbl3.startstaff = function()
		tbl3.stopstaff()
		if not tbl10.staff then
			return
		end
		tbl9.staffconn = tbl3.bind(Players.PlayerAdded:Connect(tbl3.staffact))

		tbl3.bindt(task.spawn(function()
			for _, player in ipairs(Players:GetPlayers()) do
				if tbl10.staff then
					tbl3.staffact(player)
					task.wait()
					continue
				end

				break
			end
		end))
	end

	do
		local fn7 = nil
		tbl3.anyparry = function()return( tbl10 .autoparry or  tbl10 .trigger or  tbl10 .autospam or  tbl10 .manspam or  tbl9 .sofrun)and true or false;end
		tbl3.pload = function()return  tbl9 .parries or 0;end
		tbl3.clrload = function() tbl9 .parries=0;end

		tbl3.oncombo = function(arg)
			if arg.Name ~= "ComboCounter" or not tbl10.sofctr then
				return
			end
			tbl9.plrforc = true

			tbl3.bind(arg.AncestryChanged:Connect(function(child, parent)
				if not parent then
					tbl9.sofrun = false
					tbl9.plrforc = false
				end
			end))

			if tbl9.sofrun then
				return
			end
			tbl9.sofrun = true

			tbl3.bindt(task.spawn(function()
				task.wait(0.4)
				local v3 = clock()
				local n2 = 0

				while true do
					if tbl9.sofrun and n2 < 400 and clock() - v3 < 12 and arg.Parent then
						local textLabel = arg:FindFirstChild("TextLabel")
						textLabel = textLabel and tonumber(textLabel.Text)

						if not (textLabel and textLabel >= 35) then
							if tbl3.isalive() then
								if tbl10.animfix and not str:find("xeno", 1, true) then
									tbl3.playgrab()
								end

								fn7()
								n2 += 1
							end

							if tbl10.sofmode == "Instant" then
								local n3 = (tbl10.sofdelay or 0) / 1000

								if n3 <= 0 then
									RunService.Heartbeat:Wait()
								else
									local v4 = clock()

									while true do
										RunService.Heartbeat:Wait()
										local textLabel2 = arg:FindFirstChild("TextLabel")

										if (textLabel2 and tonumber(textLabel2.Text)) == textLabel then
											if not (clock() - v4 >= n3 or not arg.Parent) then
												continue
											end
										end

										break
									end
								end
							else
								task.wait(tbl10.sofmode == "Blatant" and 0.066666666666666666 or 0.16666666666666666)
							end

							continue
						end
					end

					break
				end

				tbl9.sofrun = false
				tbl9.plrforc = false
			end))
		end

		tbl3.hookball = function(arg)
			if not arg then
				return
			end
			tbl3.bind(arg.ChildAdded:Connect(tbl3.oncombo))

			for _, child in ipairs(arg:GetChildren()) do
				tbl3.oncombo(child)
			end
		end

		tbl3.startdet = function()
			tbl3.startstaff()
			tbl3.startphantom()
			local balls = Workspace:FindFirstChild("Balls")
			if not balls then
				return
			end

			for _, child in ipairs(balls:GetChildren()) do
				tbl3.hookball(child)
			end

			tbl3.bind(balls.ChildAdded:Connect(tbl3.hookball))
			tbl3.bind(balls.ChildAdded:Connect(function()if not  tbl9 .sofrun then  tbl9 .plrforc=false;end;end))

			tbl3.bind(balls.ChildRemoved:Connect(function()
				if not tbl9.sofrun then
					tbl9.plrforc = false
				end
			end))
		end

		tbl3.rndplayed = 0
		tbl3.rndwins = 0
		tbl3.rndkills = 0
		tbl3.rndlast = ""
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")

		if remotes then
			local standoffStart = remotes:FindFirstChild("StandoffStart")
			local roundEnded = remotes:FindFirstChild("RoundEnded")

			if standoffStart then
				tbl3.bind(standoffStart.OnClientEvent:Connect(function()
					tbl9.standoff = true
				end))
			end

			if roundEnded then
				tbl3.bind(roundEnded.OnClientEvent:Connect(function(l) tbl9 .standoff=false;if type(l)~="table"then return;end; tbl3 .rndplayed= tbl3 .rndplayed+1;local K=false;if type(l.winners)=="table"then for p,p in pairs(l.winners)do if p== localPlayer then K=true;break;end;end;end;if K then  tbl3 .rndwins= tbl3 .rndwins+1;end;if type(l.kills)=="table"then local p=l.kills[ localPlayer ];if type(p)=="number"then  tbl3 .rndkills= tbl3 .rndkills+p;end;end; tbl3 .rndlast=type(l.winnersText)=="string"and l.winnersText or(K and"You won"or"You lost");end))
			end
		end

		tbl3.aimlead = function(l,K,p)local E,k=K.Position+Vector3.new(0,p or 0,0),K.AssemblyLinearVelocity;if k and k.Magnitude>1 then p= clamp ((E-l).Magnitude/220,0,0.35);E+=Vector3.new(k.X,0,k.Z)*p;end;return E;end
		tbl3.parryPayload = function(l)l=if  tbl10 .nocrv and( tbl9 .msactive or  tbl3 .pload()>1)then"Camera"else if  tbl10 .advcrv then  tbl9 .standoff and  tbl10 .socrv or  tbl10 .nscrv or l else l;local K=nil;if  flag then local p= currentCamera .ViewportSize;K={p.X/2,p.Y/2};else local p= UserInputService :GetMouseLocation();K={p.X,p.Y};end;local p={};if  tbl3 .inlobby()then if  dead then for E,k in pairs( dead :GetChildren())do E=k:FindFirstChild("HumanoidRootPart");local a= Players :GetPlayerFromCharacter(k);if E and a and(a:GetAttribute("LobbyTraining"))then p[k.Name]= currentCamera :WorldToScreenPoint(E.Position);end;end;end;for E,E in ipairs( CollectionService :GetTagged("LobbyTrainingTarget"))do p[E.Name]= currentCamera :WorldToScreenPoint(E.Position);end;elseif  alive then for E,k in pairs( alive :GetChildren())do E=k:FindFirstChild("HumanoidRootPart");if E then p[k.Name]= currentCamera :WorldToScreenPoint(E.Position);end;end;end;local E= currentCamera .CFrame;local k,a,d=E.Position,E.LookVector, tbl3 .safechar();if  tbl10 .tlock or  tbl10 .randtgt then local I= tbl9 .locked;local C=I and I.Parent== alive and(I.PrimaryPart or(I:FindFirstChild("HumanoidRootPart")));if not C then I= tbl10 .randtgt and( tbl3 .randtgt())or( tbl3 .aimedplr())or( tbl3 .closestplr()); tbl9 .locked=I;C=I and(I.PrimaryPart or(I:FindFirstChild("HumanoidRootPart")));if  tbl3 .lockhl then  tbl3 .lockhl(I);end;end;I=d and(d.PrimaryPart or(d:FindFirstChild("HumanoidRootPart")));if I and C then local U,J= tbl3 .aimlead(I.Position,C,15), tbl10 .crvstr or 0;return{0,CFrame.new(I.Position,if J~=0 then U+E.RightVector*J else U),p,K};end;end;if l=="Camera"then return{0,CFrame.new(k,k+a),p,K};end;if l=="Backwards"then local I=-a*10000;I=Vector3.new(I.X,0,I.Z);return{0,CFrame.new(k,k+I),p,K};end;if l=="Dot"then local I= tbl3 .aimedplr();if I and d and d.PrimaryPart then return{0,CFrame.new(d.PrimaryPart.Position, tbl3 .aimlead(d.PrimaryPart.Position,I.PrimaryPart,15)),p,K};end;return{0,CFrame.new(k,k+a),p,K};end;if l=="Straight"then if  flag then local I= tbl3 .aimedplr();if I and d and d.PrimaryPart then return{0,CFrame.new(d.PrimaryPart.Position, tbl3 .aimlead(d.PrimaryPart.Position,I.PrimaryPart,0)),p,K};end;return{0,CFrame.new(k,k+a),p,K};end;local I= tbl3 .mouseplr();if I and d and d.PrimaryPart then return{0,CFrame.new(d.PrimaryPart.Position, tbl3 .aimlead(d.PrimaryPart.Position,I.PrimaryPart,0)),p,K};end;return{0,CFrame.new(k,k+a),p,K};end;if l=="Random"then local I= random ()* n *2;local C=Vector3.new( cos (I),0, sin (I))*10000;return{0,CFrame.new(k,k+C),p,K};end;if l=="Predict"then local I,C= tbl3 .aimedplr()or( tbl3 .closestplr()),d and(d.PrimaryPart or(d:FindFirstChild("HumanoidRootPart")));local U=I and(I.PrimaryPart or(I:FindFirstChild("HumanoidRootPart")));if C and U then return{0,CFrame.new(C.Position, tbl3 .aimlead(C.Position,U,12)),p,K};end;return{0,CFrame.new(k,k+a),p,K};end;if l=="Up"then return{0,CFrame.new(k,k+Vector3.new(a.X,10000,a.Z)),p,K};end;if l=="Right"then d=E.RightVector*10000;return{0,CFrame.new(k,k+Vector3.new(d.X,0,d.Z)),p,K};end;if l=="Left"then d=E.RightVector*-10000;return{0,CFrame.new(k,k+Vector3.new(d.X,0,d.Z)),p,K};end;return{0,CFrame.new(k,k+a),p,K};end
		tbl3.parryfallback = function()if  tbl8 .ensure then  tbl8 .ensure();end;return false;end

		tbl3.bindt(task.spawn(function()
			local shared = ReplicatedStorage:WaitForChild("Shared", 10)
			shared = shared and shared:FindFirstChild("UseBall2")
			local module = shared and shared:IsA("ModuleScript") and require(shared) or nil
			tbl9.b2mod = type(module) == "function" and module or false
		end))

		tbl3.useball2 = function()if  tbl9 .b2t and  clock ()- tbl9 .b2t<5 then return  tbl9 .b2==true;end; tbl9 .b2t= clock ();local l=if  tbl9 .b2mod then  tbl9 .b2mod()==true else  Workspace :GetAttribute("CurrentlySelectedMode")=="HalloweenEvent"or game.PlaceId==15240096157; tbl9 .b2=l;return l;end
		tbl3.svinfo = false
		tbl3.parrywin = function()local l= tbl3 .getrep("Data");if not l then return 0.5;end;local K=l:Get("timesParried");if type(K)~="number"then return 0.5;end;local p,E=if K==0 then 1.5 else if K==1 then 1.25 else if K==2 then 1 else if K==3 then 0.75 else if K==4 then 0.625 else 0.5,l:Get("TotalStats.Kills");if type(E)~="number"or E>=20 then return p;end;if  tbl3 .svinfo==false then K= ReplicatedStorage :FindFirstChild("ServerInfo"); tbl3 .svinfo=K and(require(K))or nil;end;K= tbl3 .svinfo;if type(K)=="table"and(K.isDungeonsMatchServer()or(K.isRankedMatchServer())or(K.isMedalServer())or(K.isClanWarServer())or(K.isTournamentMatchServer()))then return p;end;return E/20*p;end
		tbl3.parryArgs = function(l)if  tbl3 .useball2()then return  currentCamera .CFrame,l[2],false;end;return  tbl3 .parrywin(),l[2],l[3],l[4],false;end
		tbl3.getvim = function()if not  tbl9 .vim then  tbl9 .vim=Instance.new("VirtualInputManager");end;return  tbl9 .vim;end
		tbl3.keyparry = function()local l= tbl3 .getvim();if not l then return false;end;l:SendKeyEvent(true,Enum.KeyCode.F,false,game);l:SendKeyEvent(false,Enum.KeyCode.F,false,game);return true;end
		fn7 = function()if not  tbl3 .anyparry()then return false;end;if  tbl10 .keyparry then  tbl3 .keyparry();elseif  tbl8 .rem and  tbl8 .sgn and  tbl8 .signHolder and  tbl8 .signHash then local l,K= tbl3 .parryPayload( tbl10 .crv), tbl8 .signKey();local p=K and( tbl8 .s1(K));if not p then  tbl3 .logwev("fireParry",5,"fireParry","parry sign failed"); tbl3 .parryfallback();return false;end; tbl8 .rem:FireServer( tbl8 .signHash,K,p, tbl3 .parryArgs(l));else  tbl3 .logwev("fireParry",5,"fireParry","parry remote/signer unavailable");if  tbl8 .ensure then  tbl8 .ensure();end; tbl3 .parryfallback();return false;end; tbl9 .sessparry=( tbl9 .sessparry or 0)+1;if( tbl9 .parries or 0)>=7 then return false;end; tbl9 .parries=( tbl9 .parries or 0)+1;task.delay(0.5,function()if( tbl9 .parries or 0)>0 then  tbl9 .parries= tbl9 .parries-1;end;end);return true;end
		tbl3.isCurved = function(l,K)l=l or( tbl3 .getball());if not l then return false;end;if not  tbl3 .ballLive(l)then return false;end;local p= tbl3 .safehrp();if not p then return false;end;local E= tbl3 .ballPos(l);if not E then return false;end;local k= tbl3 .ballVel(l);if k.Magnitude<=0 then return false;end;local a,d,I=k.Magnitude,k.Unit,(p.Position-E).Unit;local C=I:Dot(d);local U= tbl9 .curve; tbl9 .curvetrack= tbl9 .curvetrack or(setmetatable({},{__mode="k"}));local J= tbl9 .curvetrack[l];if not J then J={}; tbl9 .curvetrack[l]=J;end;l=K=="cfg"and"lastvcfg"or"lastv";K=J[l];J[l]=k;if K and K.Magnitude>0 and  clamp (K.Unit:Dot(d),-1,1)<0.96 then U.curving=tick();return true;end;local l,K,J,G= min (a/100,40),C-I:Dot((d-k).Unit),(p.Position-E).Magnitude, tbl3 .getping();local p=0.6-G/1000;local E=J/a-G/1000;local k=10- min (J/1000,10)+l;U.lerprad=U.lerprad+( rad ( asin ( clamp (C,-1,1)))-U.lerprad)*0.8;if J<(if a>100 and E>G/10 then( max (k-15,15))else k)then return false;end;if K<p then return true;end;if U.lerprad<0.018 then U.lastwarp=tick();end;if tick()-U.lastwarp<E/2 then return true;end;if tick()-U.curving<E/2 then return true;end;return C<p;end
		tbl3.aerohold = function(l)local K=tick();for p,E in pairs( tbl9 .aero)do if p.Parent then if K<E and p:GetAttribute("Ball")==l then return true;end;else  tbl9 .aero[p]=nil;end;end;return false;end
		tbl3.closingSpeed = function(l)local K= tbl3 .safehrp();if not K then return 0, huge ;end;local p= tbl3 .ballPos(l);if not p then return 0, huge ;end;local E,k= tbl3 .ballVel(l),K.Position-p;l=k.Magnitude;if l==0 or E.Magnitude==0 then return 0, huge ;end;p=E:Dot(k.Unit);if p<=0 then return p, huge ;end;return p, max ((l-4)/p,0);end
		tbl3.preclick = function()if not  tbl3 .isalive()or  tbl9 .sofrun or  tbl9 .plrforc then return;end;local l= clock ();if l-( tbl9 .pcat or 0)<0.6 then return;end; tbl9 .pcat=l; tbl3 .bindt(task.delay(0.05+math.random()*0.09,function()if  tbl3 .isalive()then  fn7 ();end;end));end
		tbl3.isdribble = function(l)if not l:GetAttribute("DribbleActive")then return false;end;if  tbl3 .ballTarget(l)== localPlayer .Name then return false;end;local K= tbl3 .safehrp();local p=K and( tbl3 .ballPos(l));if not p then return false;end;return(K.Position-p).Magnitude<=30;end
		tbl3.trigfire = function(l)if not  tbl10 .trigger or not l then return;end;local K= tbl9 .trigstate[l];if not K then K={}; tbl9 .trigstate[l]=K;end;if  tbl3 .ballTarget(l)~= localPlayer .Name then K.fired=false;return;end;if K.fired or not  tbl3 .ballLive(l)then return;end;local p= localPlayer .Character;if not p or p.Parent~= alive then return;end;local E=p.PrimaryPart;if not E or(E:FindFirstChild("SingularityCape"))or(E:FindFirstChild("MaxShield"))then return;end;if  tbl9 .plrforc or( tbl3 .deflecting())or( tbl3 .aerohold(l.Name))then return;end;K.fired=true; fn7 ();end
		tbl3.trighook = function(l)if not l then return;end;if not  tbl9 .trighooked[l]then  tbl9 .trighooked[l]=true;local K={};K[#K+1]=l:GetAttributeChangedSignal("target"):Connect(function() tbl3 .trigfire(l);end);local function p(E)if E and(E:IsA("ObjectValue"))then K[#K+1]=E.Changed:Connect(function() tbl3 .trigfire(l);end);end;end;p(l:FindFirstChild("CollisionWhitelist"));K[#K+1]=l.ChildAdded:Connect(function(E)if E.Name=="CollisionWhitelist"then p(E); tbl3 .trigfire(l);end;end);l.Destroying:Once(function()for p,p in ipairs(K)do p:Disconnect();end; tbl9 .trighooked[l]=nil;end);end; tbl3 .trigfire(l);end

		tbl3.starttrigger = function()
			tbl3.stoptrigger()
			tbl9.trigstate = setmetatable({}, { __mode = "k" })
			tbl9.trighooked = tbl9.trighooked or setmetatable({}, { __mode = "k" })
			tbl9.trigconns = {}
			local function fn8()if not  tbl10 .trigger then return;end;local l= Workspace :FindFirstChild("Balls");if not l then return;end;for K,K in ipairs(l:GetChildren())do  tbl3 .trighook(K);end;end

			local function fn9(arg)
				tbl9.trigconns[#tbl9.trigconns + 1] = arg
				tbl3.bind(arg)
			end

			for _, v3 in ipairs(tbl3.apsignals()) do
				fn9(v3:Connect(fn8))
			end

			local balls = Workspace:FindFirstChild("Balls")

			if balls then
				fn9(balls.ChildAdded:Connect(function(l) tbl3 .trighook(l);end))
			end

			fn8()
		end

		tbl3.stoptrigger = function()
			if tbl9.trigconns then
				for _, trigconn in ipairs(tbl9.trigconns) do
					trigconn:Disconnect()
				end

				tbl9.trigconns = nil
			end
		end

		tbl3.parryTick = function()if not  tbl10 .autoparry then return;end;local l= localPlayer .Character;if not l then return;end;if l.Parent~= alive and not  Workspace :FindFirstChild("TrainingBalls")then return;end;local K=l.PrimaryPart;if not K then return;end;local p=K:FindFirstChild("SingularityCape");local E= tbl3 .hotslot("ability");local k=E and(E:FindFirstChild("Duration"));local a,d=k~=nil and k.Visible,l and(l:FindFirstChild("Abilities"));E=d and(d:FindFirstChild("Infinity"));local I,C=E and E.Enabled,d and(d:FindFirstChild("Time Hole"));local U=C and C.Enabled;local J=d and(d:FindFirstChild("Slashes of Fury"));if  tbl9 .plrforc then return;end;if a and J and J.Enabled then return;end;if  tbl3 .deflecting()then return;end;if a and I and  tbl9 .infball then  tbl3 .clrload();return;end;if a and U then  tbl3 .clrload();return;end;if p then return;end;if a and(K:FindFirstChild("MaxShield"))then return;end;local a,d=l:GetAttribute("CurrentlyEquippedSword"), tbl3 .getball();if d and( tbl3 .ballLive(d))then do local l= tbl9 .ballstate[d];if not l then l={parried=false,lasttarget=nil}; tbl9 .ballstate[d]=l;end;if not l.hooked then l.hooked=true;local G={};G[#G+1]=d:GetAttributeChangedSignal("target"):Connect(function()l.parried=false;l.drbl=false;l.preclick=false;end);local function S(N)if N and(N:IsA("ObjectValue"))then G[#G+1]=N.Changed:Connect(function()l.parried=false;end);end;end;S(d:FindFirstChild("CollisionWhitelist"));G[#G+1]=d.ChildAdded:Connect(function(N)if N.Name=="CollisionWhitelist"then S(N);end;end);d.Destroying:Once(function()for S,S in ipairs(G)do S:Disconnect();end; tbl9 .ballstate[d]=nil;end);end;C= tbl3 .ballTarget(d);l.lasttarget=C;E= tbl3 .isCurved(d);if  tbl10 .drbpre and( tbl3 .isdribble(d))then if not l.drbl then l.drbl=true;l.drbat= clock ()+0.05+math.random()*0.09;end;if not l.preclick and  clock ()>=l.drbat then l.preclick=true; tbl3 .preclick();end;elseif l.drbl then l.drbl=false;l.preclick=false;end;if C== localPlayer .Name and not l.parried then if not  tbl3 .aerohold(d.Name)then I,J= tbl3 .ballVel(d).Magnitude, tbl3 .apos(d);k,U=J and(K.Position-J).Magnitude or  huge , tbl3 .parryWindow(I);if k>U*2.5 then return;end;p= clock ()- tbl9 .lastparry;if E and not K:FindFirstChild("BunnyLeapAura")then return;end;if k<=U and  clock ()-(l.lastparry or 0)>0.2 and  clock ()-( tbl9 .lastapfire or 0)>0.06 then if  tbl10 .animfix and not  str :find("xeno",1,true)and a~="New Years Greatsword"and p>0.5 then  tbl3 .playgrab();end;if  fn7 ()then  tbl9 .lastparry= clock (); tbl9 .lastapfire= tbl9 .lastparry;l.lastparry= tbl9 .lastparry;l.parried=true;task.spawn(function()local K=tick();repeat  RunService .Heartbeat:Wait();until tick()-K>=0.6 or not l.parried;l.parried=false;end);end;end;end;end;end;end;end
	end

	tbl3.apsignals = function()
		local tbl11 = {}

		for _, v3 in ipairs({ "PreRender", "PreAnimation", "PreSimulation", "PostSimulation" }) do
			local v4 = RunService[v3]

			if typeof(v4) == "RBXScriptSignal" then
				tbl11[#tbl11 + 1] = v4
			end
		end

		if #tbl11 == 0 then
			tbl11[1] = RunService.PreSimulation
		end

		return tbl11
	end

	tbl3.startap = function()
		tbl3.stopap()
		tbl9.apconns = {}
		tbl9.apstep = -huge
		local function fn7()local l= clock ();if l- tbl9 .apstep<2.5E-4 then return;end; tbl9 .apstep=l; tbl3 .parryTick();end

		for _, v3 in ipairs(tbl3.apsignals()) do
			local connection = v3:Connect(fn7)
			tbl9.apconns[#tbl9.apconns + 1] = connection
			tbl3.bind(connection)
		end
	end

	tbl3.stopap = function()
		if tbl9.apconns then
			for _, apconn in ipairs(tbl9.apconns) do
				apconn:Disconnect()
			end

			tbl9.apconns = nil
		end
	end

	local v3 = nil
	tbl3.closestplr = function()local l= tbl3 .safechar();if not l or not  alive then  v3 =nil;return nil;end;local K=l.PrimaryPart or(l:FindFirstChild("HumanoidRootPart"));if not K then  v3 =nil;return nil;end;local p,E= huge ;for k,k in ipairs( alive :GetChildren())do if k.PrimaryPart and( tbl3 .validtgt(k))then l=(k.PrimaryPart.Position-K.Position).Magnitude;if l<p then p,E=l,k;end;end;end; v3 =E;return E;end
	tbl3.firespam = function()if not  tbl3 .anyparry()then return false;end;if not  tbl3 .isalive()then return false;end;if  tbl10 .keyparry then  tbl3 .keyparry();elseif  tbl8 .rem and  tbl8 .sgn and  tbl8 .signHolder and  tbl8 .signHash then local l,K= tbl3 .parryPayload( tbl10 .crv), tbl8 .signKey();local p=K and( tbl8 .s1(K));if not p then  tbl3 .logwev("fireSpamParry",5,"fireSpamParry","parry sign failed"); tbl3 .parryfallback();return false;end; tbl8 .rem:FireServer( tbl8 .signHash,K,p, tbl3 .parryArgs(l));else  tbl3 .logwev("fireSpamParry",5,"fireSpamParry","parry remote/signer unavailable");if  tbl8 .ensure then  tbl8 .ensure();end; tbl3 .parryfallback();return false;end;if( tbl9 .parries or 0)>=7 then return false;end; tbl9 .parries=( tbl9 .parries or 0)+1;task.delay(0.5,function()if( tbl9 .parries or 0)>0 then  tbl9 .parries= tbl9 .parries-1;end;end);return true;end
	tbl3.spamReach = function(l)local K= localPlayer .Character;local p=K and(K:FindFirstChild("HumanoidRootPart"));if not p then return 0;end;K= tbl3 .ballPos(l);if not K then return 0;end; tbl3 .closestplr();local E= v3 and( v3 .PrimaryPart or( v3 :FindFirstChild("HumanoidRootPart")));if not E then return 0;end;local k= tbl3 .ballVel(l);l=k.Magnitude;if l==0 then return 0;end;local a=p.Position-K;if a.Magnitude==0 then return 0;end;K=a.Unit:Dot(k.Unit);local k,d,I= clamp ( tbl3 .getping()/10,10,17)+ min (l/6,95),(p.Position-E.Position).Magnitude,a.Magnitude;if d>k or I>k then return 0;end;p=5- min (l/5,5);return k- clamp (K,-1,0)*p;end
	tbl3.spamTick = function()local l= localPlayer .Character;if not l or not  alive or l.Parent~= alive then return;end;local K=l.PrimaryPart;if not K then return;end;local p= tbl3 .getball();if not p then return;end;if not  tbl3 .ballLive(p)then return;end;if  tbl9 .plrforc then return;end;if  tbl3 .deflecting()then return;end;if K:FindFirstChild("SingularityCape")then return;end;if  tbl3 .aerohold(p.Name)then return;end;local E,k=l:FindFirstChild("Abilities"), tbl3 .abact(l);l=E and(E:FindFirstChild("Slashes of Fury"));if k and l and l.Enabled then return;end;l= tbl3 .spamReach(p);if not l or l==0 then return;end;E= tbl3 .ballPos(p);if not E then return;end;if(K.Position-E).Magnitude<=l and( tbl9 .parries or 0)>1 then  tbl3 .firespam();if  tbl10 .animfix and not  str :find("xeno",1,true)then  tbl3 .playgrab();end;end;end

	tbl3.startas = function()
		if tbl9.asconn then
			tbl9.asconn:Disconnect()
		end

		tbl9.asconn = RunService.PreSimulation:Connect(function()if not  tbl10 .autospam then return;end; tbl3 .spamTick();end)
		tbl3.bind(tbl9.asconn)
	end

	tbl3.stopas = function()
		if tbl9.asconn then
			tbl9.asconn:Disconnect()
			tbl9.asconn = nil
		end
	end

	local v4 = nil
	tbl3.tunecfg = function()local l= tbl3 .getping();local K= abs (l-( tbl9 .cfgprevping or l)); tbl9 .cfgprevping=l;local p= tbl9 .cfgsmoothping or l;p+=(l-p)*0.2; tbl9 .cfgsmoothping=p;l= tbl9 .cfgjitter or K;l+=(K-l)*0.2; tbl9 .cfgjitter=l;K= clamp ( Workspace :GetRealPhysicsFPS(),1,240);local E=1000/K;local k,a,d,I,C,U,J=p+l*0.7+ max (0,E-16.7)*0.8,0,false,0,0,false, tbl3 .getball();if J then a= tbl3 .ballVel(J).Magnitude;if  tbl3 .ballTarget(J)== localPlayer .Name then d,I= tbl3 .isCurved(J,"cfg"), max ( tbl3 .closingSpeed(J),0);local p,G,S= tbl3 .ballPos(J), tbl3 .safehrp(), tbl3 .ballVel(J);U,C=true,if p and G and S.Magnitude>0 then( clamp ((G.Position-p).Unit:Dot(S.Unit),0,1))else C;end;end;J,E=100- clamp ((k-60)*0.09,0,14), clamp ((k-55)*0.04+ max (0,50-K)*0.06,0,10)+ clamp (a/240,0,4);J+= clamp (a/500,0,3);if d then E,J=E+1,J+1;end;E=if l>25 then E+1.5 else E;if l>45 then J-=2;E+=1.5;end;if U then E+= clamp (I/260,0,3);J+= clamp (I/700,0,2);if C>0.8 then J+=1;else E=if C<0.45 then E+1 else E;end;end;E,J= clamp ( floor (E+0.5),0,10), clamp ( floor (J+0.5),84,100); tbl10 .acc=J; tbl10 .rng=E;k= clock ();if k-( tbl9 .cfguisync or 0)>0.25 then  tbl9 .cfguisync=k; tbl3 .nosave=true; options .parryaccuracy:SetValue(J); options .parryrange:SetValue(E); tbl3 .nosave=false;end;end

	tbl3.startbestcfg = function()
		if v4 then
			return
		end
		tbl9.cfgprevping = nil
		tbl9.cfgsmoothping = nil
		tbl9.cfgjitter = nil
		tbl3.notif("Auto Best Config", "Setting your accuracy and range from your ping.", 4)
		v4 = tbl3.bind(RunService.Heartbeat:Connect(function() tbl3 .tunecfg();end))
	end

	tbl3.stopbestcfg = function()
		if v4 then
			v4:Disconnect()
			v4 = nil
		end
	end

	tbl3.setmsactive = function(arg)
		tbl9.msactive = arg == true

		if tbl9.mswidget and tbl9.mswidget.set_active then
			local msactive = tbl9.msactive

			if tbl9.mswidget.get_active() ~= msactive then
				tbl9.mswidget.set_active(tbl9.msactive)
			end
		end
	end

	tbl3.showmsui = function()
		if flag then
			return true
		end
		return tbl10.mansui
	end

	tbl3.delmsgui = function()
		if tbl9.mswidget then
			tbl9.mswidget.destroy()
			tbl9.mswidget = nil
		end
	end

	tbl3.msgui = function()
		local msactive = tbl9.msactive
		tbl3.delmsgui()
		local accentColor = v.Scheme.AccentColor
		local scheme = v.Scheme
		local cornerRadius = v.CornerRadius
		local v5 = flag
		local tbl11 = {}
		local w = flag

		if v5 then
			w = 232
		end

		tbl11.w = w or 148
		local h = flag

		if v5 then
			h = 64
		end

		tbl11.h = h or 40
		local dragW = flag

		if v5 then
			dragW = 34
		end

		tbl11.drag_w = dragW or 20
		local padX = flag

		if v5 then
			padX = 18
		end

		tbl11.pad_x = padX or 12
		local padY = flag

		if v5 then
			padY = 96
		end

		tbl11.pad_y = padY or 64
		local toggleW = flag

		if v5 then
			toggleW = 66
		end

		tbl11.toggle_w = toggleW or 40
		local toggleH = flag

		if v5 then
			toggleH = 38
		end

		tbl11.toggle_h = toggleH or 22
		local titleSize = flag

		if v5 then
			titleSize = 19
		end

		tbl11.title_size = titleSize or 14
		local toggleSize = flag

		if v5 then
			toggleSize = 17
		end

		tbl11.toggle_size = toggleSize or 14
		local bodyPadL = flag

		if v5 then
			bodyPadL = 8
		end

		tbl11.body_pad_l = bodyPadL or 4
		local bodyPadR = flag

		if v5 then
			bodyPadR = 10
		end

		tbl11.body_pad_r = bodyPadR or 8
		tbl11.edge_r = 4
		tbl11.scale = 1
		local font = scheme.Font

		local function fn7(arg)
			local v6 = scheme[arg]
			if typeof(v6) == "Color3" then
				return v6
			end
			return scheme.BackgroundColor
		end

		local frame = Instance.new("Frame")
		frame.Name = "ManualSpamWidget"
		frame.BackgroundColor3 = fn7("MainColor")
		frame.BorderSizePixel = 0
		frame.Size = UDim2.fromOffset(tbl11.w, tbl11.h)
		frame.Position = UDim2.new(1, -(tbl11.w + tbl11.pad_x), 1, -(tbl11.h + tbl11.pad_y))
		frame.ZIndex = 20
		frame.Parent = v.ScreenGui
		local uiScale = Instance.new("UIScale")
		uiScale.Scale = tbl11.scale
		uiScale.Parent = frame
		table.insert(v.Scales, uiScale)
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, cornerRadius)
		uiCorner.Parent = frame
		table.insert(v.Corners, uiCorner)
		local v6 = v:AddOutline(frame)
		local textButton = Instance.new("TextButton")
		textButton.Name = "Drag"
		textButton.AutoButtonColor = false
		textButton.BackgroundColor3 = fn7("BackgroundColor")
		textButton.BorderSizePixel = 0
		textButton.Size = UDim2.new(0, tbl11.drag_w, 1, 0)
		textButton.Text = ""
		textButton.ZIndex = 21
		textButton.Parent = frame
		local uiCorner2 = Instance.new("UICorner")
		uiCorner2.CornerRadius = UDim.new(0, cornerRadius)
		uiCorner2.Parent = textButton
		local n2 = flag

		if v5 then
			n2 = 16
		end

		n2 = n2 or 14
		local frame2 = Instance.new("Frame")
		frame2.BackgroundTransparency = 1
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.Position = UDim2.fromScale(0.5, 0.5)
		frame2.Size = UDim2.fromOffset(8, n2)
		frame2.ZIndex = 22
		frame2.Parent = textButton

		for i = 0, 2 do
			local frame3 = Instance.new("Frame")
			frame3.BackgroundColor3 = fn7("OutlineColor")
			frame3.BorderSizePixel = 0
			frame3.Position = UDim2.fromOffset(i * 3, 0)
			frame3.Size = UDim2.fromOffset(2, n2)
			frame3.ZIndex = 22
			frame3.Parent = frame2
			local uiCorner3 = Instance.new("UICorner")
			uiCorner3.CornerRadius = UDim.new(1, 0)
			uiCorner3.Parent = frame3
		end

		local n3 = tbl11.drag_w + 4
		v:MakeLine(frame, { Position = UDim2.new(0, tbl11.drag_w, 0, 8), Size = UDim2.new(0, 1, 1, -16) })
		local frame3 = Instance.new("Frame")
		frame3.Name = "Body"
		frame3.BackgroundTransparency = 1
		frame3.Position = UDim2.new(0, n3, 0, 0)
		frame3.Size = UDim2.new(1, -(n3 + tbl11.edge_r), 1, 0)
		frame3.ZIndex = 21
		frame3.Parent = frame
		local textButton2 = Instance.new("TextButton")
		textButton2.Name = "Hit"
		textButton2.AutoButtonColor = false
		textButton2.BackgroundTransparency = 1
		textButton2.BorderSizePixel = 0
		textButton2.Size = UDim2.new(1, -(tbl11.toggle_w + tbl11.body_pad_r + 6), 1, 0)
		textButton2.Text = ""
		textButton2.ZIndex = 21
		textButton2.Parent = frame3
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.FontFace = font
		textLabel.Position = UDim2.fromOffset(tbl11.body_pad_l, 0)
		textLabel.Size = UDim2.new(1, -(tbl11.toggle_w + tbl11.body_pad_r + 10), 1, 0)
		textLabel.Text = "SPAM"
		textLabel.TextColor3 = fn7("FontColor")
		textLabel.TextSize = tbl11.title_size
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.ZIndex = 22
		textLabel.Parent = frame3
		local textButton3 = Instance.new("TextButton")
		textButton3.Name = "Toggle"
		textButton3.AutoButtonColor = false
		textButton3.BackgroundColor3 = fn7("BackgroundColor")
		textButton3.BorderSizePixel = 0
		textButton3.AnchorPoint = Vector2.new(1, 0.5)
		textButton3.Position = UDim2.new(1, -tbl11.body_pad_r, 0.5, 0)
		textButton3.Size = UDim2.fromOffset(tbl11.toggle_w, tbl11.toggle_h)
		textButton3.FontFace = font
		textButton3.Text = "OFF"
		textButton3.TextColor3 = fn7("FontColor")
		textButton3.TextSize = tbl11.toggle_size
		textButton3.ZIndex = 23
		textButton3.Parent = frame3
		local uiCorner3 = Instance.new("UICorner")
		uiCorner3.CornerRadius = UDim.new(0, max(2, cornerRadius - 1))
		uiCorner3.Parent = textButton3
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = fn7("OutlineColor")
		uiStroke.Thickness = 1
		uiStroke.Parent = textButton3
		v:MakeDraggable(frame, textButton, true)
		local flag2 = false

		local mswidget = {
			set_active = function(msactive2)
				flag2 = msactive2
				tbl9.msactive = msactive2

				if msactive2 then
					textButton3.Text = "ON"
					textButton3.BackgroundColor3 = accentColor
					textButton3.TextColor3 = fn7("WhiteColor")
					uiStroke.Color = accentColor
					textLabel.TextColor3 = fn7("FontColor")

					if v6 then
						v6.Color = accentColor
					end
				else
					textButton3.Text = "OFF"
					textButton3.BackgroundColor3 = fn7("BackgroundColor")
					textButton3.TextColor3 = fn7("FontColor")
					uiStroke.Color = fn7("OutlineColor")
					textLabel.TextColor3 = fn7("FontColor")

					if v6 then
						v6.Color = fn7("OutlineColor")
					end
				end
			end,
			get_active = function()
				return flag2
			end,
			destroy = function()
				frame:Destroy()
			end,
		}

		local function fn8()
			mswidget.set_active(not flag2)
		end

		textButton3.Activated:Connect(fn8)
		textButton2.Activated:Connect(fn8)

		frame.Destroying:Connect(function()
			if tbl9.mswidget == mswidget then
				tbl9.mswidget = nil
			end
		end)

		tbl9.mswidget = mswidget
		mswidget.set_active(msactive)
	end

	tbl3.refmsui = function()
		if tbl10.manspam and tbl3.showmsui() then
			tbl3.msgui()
		else
			if tbl9.msactive then
				tbl3.setmsactive(false)
			end

			tbl3.delmsgui()
		end
	end

	tbl3.startmskey = function()
		if tbl9.mskeyconn then
			return
		end
		tbl9.mskeyconn = tbl3.bind(UserInputService.InputBegan:Connect(function(l,K)if K or not  tbl10 .manspam then return;end;if l.KeyCode==Enum.KeyCode.E then  tbl3 .setmsactive(not  tbl9 .msactive);end;end))
	end

	tbl3.startms = function()
		tbl3.startmskey()

		if tbl9.msconn then
			tbl9.msconn:Disconnect()
		end

		tbl9.msconn = RunService.PreSimulation:Connect(function()if not  tbl10 .manspam or not  tbl9 .msactive then return;end;if not  tbl3 .isalive()then return;end;local l= tbl3 .getball();if not l or not  tbl3 .ballLive(l)then return;end; tbl3 .firespam();end)
		tbl3.bind(tbl9.msconn)
	end

	tbl3.setnorender = function()
		local disabled = tbl10.norender == true
		local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
		playerScripts = playerScripts and playerScripts:FindFirstChild("EffectScripts")
		playerScripts = playerScripts and playerScripts:FindFirstChild("ClientFX")

		if playerScripts then
			playerScripts.Disabled = disabled
		end

		if disabled then
			if not tbl9.norenderconn then
				local runtime = Workspace:FindFirstChild("Runtime")

				if runtime then
					tbl9.norenderconn = runtime.ChildAdded:Connect(function(l)if l.Name=="FinisherCameraRig"then return;end; Debris :AddItem(l,0);end)
					tbl3.bind(tbl9.norenderconn)
				end
			end
		elseif tbl9.norenderconn then
			tbl9.norenderconn:Disconnect()
			tbl9.norenderconn = nil
		end
	end

	tbl3.setnocd = function()
		local shared = ReplicatedStorage:FindFirstChild("Shared")
		shared = shared and shared:FindFirstChild("Abilities")
		shared = shared and shared:FindFirstChild("Thunder Dash")
		if not shared then
			return
		end
		local module = require(shared)
		if type(module) ~= "table" then
			return
		end

		if not tbl9.nocdsave then
			tbl9.nocdsave = {
				cd = rawget(module, "cooldown"),
				red = rawget(module, "cooldownReductionPerUpgrade"),
				can = rawget(module, "canBeUsed"),
				act = rawget(module, "localOwnerActivation"),
			}
		end

		local nocdsave = tbl9.nocdsave

		if not tbl10.thundernocd then
			module.cooldown = nocdsave.cd
			module.cooldownReductionPerUpgrade = nocdsave.red
			module.canBeUsed = nocdsave.can
			module.localOwnerActivation = nocdsave.act
			return
		end

		module.cooldown = 0
		module.cooldownReductionPerUpgrade = 0

		module.canBeUsed = function()
			return true
		end

		if nocdsave.act then
			module.localOwnerActivation = function(...)
				module.cooldown = 0
				return nocdsave.act(...)
			end
		end
	end

	tbl3.stopms = function()
		if tbl9.msconn then
			tbl9.msconn:Disconnect()
			tbl9.msconn = nil
		end

		tbl3.setmsactive(false)
	end

	local tbl11 = {
		"AbilityBlockedByLTM",
		"AbilityBlockedByRanked",
		"AbilityBlockedByNoAbilityDuel",
		"AbilityBlockedByNoAbilityRanked",
		"AbilityBlockedByDungeons",
		"AbilityBlockedByRegionalTournament",
		"HuntPS",
	}

	tbl3.abilblocked = function(l)for K,K in ipairs( tbl11 )do if l:GetAttribute(K)then return true;end;end;local h=l.GetAttributes(l);if type(h)=="table"then for l,K in pairs(h)do if K==true and type(l)=="string"and l:sub(1,12)=="AbilityLock_"then return true;end;end;end;return false;end
	tbl3.metaabil = { Pull = true, Telekinesis = true, ["Phase Bypass"] = true, ["Raging Deflection"] = true }

	local tbl12 = {
		"Calming Deflection",
		"Raging Deflection",
		"Rapture",
		"Aerodynamic Slash",
		"Forcefield",
		"Infinity",
		"Fracture",
		"Invisibility",
		"Ninja Dash",
	}

	tbl3.abilrdy = function(l)local K= tbl3 .hotslot("ability");if not K then return false;end;local p=K:FindFirstChild("Red");if p and p.Visible then return false;end;p=K:FindFirstChild("UIGradient");if p then return p.Offset.Y>=0.5;end;return(l and(l:GetAttribute("CooldownExpiration"))or 0)- Workspace :GetServerTimeNow()<=0;end
	tbl3.parrydown = function()local l= tbl3 .hotslot("block");local K=l and(l:FindFirstChild("UIGradient"));if K then return K.Offset.Y<0.45;end;if not  tbl9 .noblockgrad then  tbl9 .noblockgrad=true; tbl3 .logwev("blockgrad",60,"cooldown protection","Hotbar.Block has no UIGradient - using parry timing instead");end;return( tbl9 .parries or 0)>0 and  clock ()-( tbl9 .lastparry or 0)<0.5+ min ( tbl3 .getping()/1000,0.5);end
	tbl3.usableabil = function(l)local K=l:FindFirstChild("Abilities");if not K then return nil;end;if not  tbl3 .abilrdy(l)then return nil;end;for l,p in ipairs( tbl12 )do l=K:FindFirstChild(p);if l and l.Enabled then return p;end;end;return nil;end
	tbl3.fireabil = function()local l= ReplicatedStorage :FindFirstChild("Remotes");local K=l and(l:FindFirstChild("AbilityButtonPress"));if K and(K:IsA("BindableEvent"))then K:Fire();return true;end; tbl3 .logwev("abilitypress",5,"AbilityButtonPress bindable not found");return false;end

	tbl3.startabil = function()
		if tbl9.abilconn then
			tbl9.abilconn:Disconnect()
		end

		tbl9.abilconn = RunService.PreSimulation:Connect(function()if not  tbl10 .autoabil and not  tbl10 .cdprot then return;end;local l= localPlayer .Character;if not l or not  alive or l.Parent~= alive then return;end;local K=l.PrimaryPart;if not K then return;end;local p=nil;for E,E in ipairs( tbl3 .ballList())do if  tbl3 .ballTarget(E)== localPlayer .Name then p=E;break;end;end;if not p then  tbl9 .abilball=nil;return;end;if  tbl9 .abilball==p then return;end;if not  tbl3 .ballLive(p)then return;end;if  clock ()- tbl9 .lastparry<=0.5 then return;end;local E= tbl3 .usableabil(l);if not E then return;end;if  tbl3 .abilblocked(l)then if  tbl10 .autoabil and not  tbl9 .ablnoted then  tbl9 .ablnoted=true; tbl3 .notif("Auto Ability","This mode blocks abilities. Auto Ability is off.",4);end;return;end; tbl9 .ablnoted=false;local k,a= tbl3 .abact(l),l:FindFirstChild("Abilities");local d,I=a and(a:FindFirstChild("Infinity")),a and(a:FindFirstChild("Time Hole"));if  tbl9 .plrforc then return;end;if k and d and d.Enabled and  tbl9 .infball then return;end;if k and I and I.Enabled then return;end;if K:FindFirstChild("SingularityCape")then return;end;a= tbl3 .ballVel(p);k=a.Magnitude;if  tbl3 .closingSpeed(p)<=3 then return;end;d= tbl3 .parrydown();local C= tbl10 .cdprot and d;if not C then if not  tbl10 .autoabil then return;end;if k<( tbl10 .abilspd or 0)then return;end;end;d= tbl3 .getping();I=(2.349756274912749+ clamp (k,0,1000)*0.002)* tbl3 .accbase();local U,J= clamp (d/10,5,17)+k/I+ tbl10 .rng+12, tbl3 .ballPos(p);local k=J and(K.Position-J).Magnitude or  huge ;if(if J then( min (k,(K.Position-(J+a* clamp (d/1000,0,0.28))).Magnitude))else k)>U then return;end;if  tbl3 .fireabil()then if E=="Raging Deflection"or E=="Rapture"then  tbl9 .defcast= clock ()+0.8;end;local K=l:GetAttribute("CooldownExpiration")or 0;if E~="Ninja Dash"and E~="Invisibility"then local l= tbl3 .ballstate[p];if not l then l={parried=false,lasttarget=nil}; tbl3 .ballstate[p]=l;end;l.parried=true;l.lastparry= clock (); tbl3 .bindt(task.delay(0.45,function()l.parried=false;end));end;if not  tbl3 .esptotal( localPlayer ,E)then  tbl9 .abilball=p;else  tbl3 .bindt(task.delay(0.25,function()local l= tbl3 .safechar();if l and(l:GetAttribute("CooldownExpiration")or 0)>K then  tbl9 .abilball=p;if C then  tbl3 .notif("Auto Ability",E.." used while parry was on cooldown.",3);end;end;end));end;end;end)
		tbl3.bind(tbl9.abilconn)
	end

	tbl3.stopabil = function()
		if tbl9.abilconn then
			tbl9.abilconn:Disconnect()
			tbl9.abilconn = nil
		end

		tbl9.abilball = nil
	end

	tbl3.rbcol = function(h)return Color3.fromHSV(tick()*(h or 0.2)%1,1,1);end
	tbl3.btcol = function()if  tbl10 .btrb then local l= tbl3 .rbcol(0.3);return ColorSequence.new(l,l);end;return ColorSequence.new({ColorSequenceKeypoint.new(0, tbl10 .btstart),ColorSequenceKeypoint.new(1, tbl10 .btend)});end
	tbl3.refbt = function()local l= Workspace :FindFirstChild("Balls");if not l then return;end;local K= tbl3 .btcol();for p,E in ipairs(l:GetChildren())do p=E:FindFirstChild("_atrail");if p then p.Color=K;p.Lifetime= tbl10 .btlife;p.WidthScale=NumberSequence.new({NumberSequenceKeypoint.new(0, tbl10 .btwidth),NumberSequenceKeypoint.new(0.5, tbl10 .btwidth*0.6),NumberSequenceKeypoint.new(1,0)});end;p=E:FindFirstChild("_atglow");if p and(p:IsA("Trail"))then p.Enabled= tbl10 .btglow;p.Color=K;p.Lifetime= tbl10 .btlife*1.35;p.WidthScale=NumberSequence.new({NumberSequenceKeypoint.new(0, tbl10 .btwidth*3),NumberSequenceKeypoint.new(0.4, tbl10 .btwidth*2),NumberSequenceKeypoint.new(1,0)});end;p=E:FindFirstChild("_atparticle");if p then p.Enabled= tbl10 .btpart;p.Color=K;end;p=E:FindFirstChild("_atspark");if p then p.Enabled= tbl10 .btpart;p.Color=ColorSequence.new( tbl10 .btrb and( tbl3 .rbcol(0.45))or  tbl10 .btend);end;end;end
	tbl3.addbt = function(l)if not l or not l:IsA("BasePart")then return;end;if l:FindFirstChild("_atrail")then return;end;local K=Instance.new("Attachment");K.Name="_atrailA";K.Position=Vector3.new(0,0.5,0);K.Parent=l;local p=Instance.new("Attachment");p.Name="_atrailB";p.Position=Vector3.new(0,-0.5,0);p.Parent=l;local E=Instance.new("Trail");E.Name="_atrail";E.Attachment0=K;E.Attachment1=p;E.Lifetime= tbl10 .btlife;E.FaceCamera=true;E.LightEmission=1;E.LightInfluence=0;E.WidthScale=NumberSequence.new({NumberSequenceKeypoint.new(0, tbl10 .btwidth),NumberSequenceKeypoint.new(0.5, tbl10 .btwidth*0.6),NumberSequenceKeypoint.new(1,0)});E.Color= tbl3 .btcol();E.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.05),NumberSequenceKeypoint.new(0.6,0.4),NumberSequenceKeypoint.new(1,1)});E.Parent=l;E=Instance.new("Trail");E.Name="_atglow";E.Attachment0=K;E.Attachment1=p;E.Lifetime= tbl10 .btlife*1.35;E.FaceCamera=true;E.LightEmission=1;E.LightInfluence=0;E.WidthScale=NumberSequence.new({NumberSequenceKeypoint.new(0, tbl10 .btwidth*3),NumberSequenceKeypoint.new(0.4, tbl10 .btwidth*2),NumberSequenceKeypoint.new(1,0)});E.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.55),NumberSequenceKeypoint.new(0.5,0.75),NumberSequenceKeypoint.new(1,1)});E.Color= tbl3 .btcol();E.Enabled= tbl10 .btglow;E.Parent=l;E=Instance.new("ParticleEmitter");E.Name="_atparticle";E.Rate=260;E.Lifetime=NumberRange.new(0.45,0.9);E.Speed=NumberRange.new(6,16);E.SpreadAngle=Vector2.new(180,180);E.Drag=3;E.Rotation=NumberRange.new(0,360);E.RotSpeed=NumberRange.new(-160,160);E.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.15,1.5),NumberSequenceKeypoint.new(1,0)});E.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.15),NumberSequenceKeypoint.new(0.7,0.45),NumberSequenceKeypoint.new(1,1)});E.Color= tbl3 .btcol();E.LightEmission=1;E.LightInfluence=0;E.Brightness=3;E.Enabled= tbl10 .btpart;E.Parent=l;p=Instance.new("ParticleEmitter");p.Name="_atspark";p.Rate=90;p.Lifetime=NumberRange.new(0.25,0.5);p.Speed=NumberRange.new(18,34);p.SpreadAngle=Vector2.new(180,180);p.Drag=6;p.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.45),NumberSequenceKeypoint.new(1,0)});p.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)});p.Color=ColorSequence.new( tbl10 .btend);p.LightEmission=1;p.LightInfluence=0;p.Brightness=5;p.Enabled= tbl10 .btpart;p.Parent=l;end
	tbl3.applybt = function()if not  tbl10 .bt then return;end;for l,l in ipairs( tbl3 .ballList())do  tbl3 .addbt(l);end;if  tbl10 .btrb then  tbl3 .refbt();end;end

	tbl3.clrbt = function()
		local balls = Workspace:FindFirstChild("Balls")
		if not balls then
			return
		end

		for _, child in ipairs(balls:GetChildren()) do
			for _, v5 in ipairs({ "_atrail", "_atrailA", "_atrailB", "_atglow", "_atparticle", "_atspark" }) do
				local v6 = child:FindFirstChild(v5)

				if v6 then
					v6:Destroy()
				end
			end
		end
	end

	tbl3.ptcol = function()if  tbl10 .ptrb then local l= tbl3 .rbcol(0.4);return ColorSequence.new(l,l);end;return ColorSequence.new( tbl10 .ptcol, tbl10 .ptcol);end

	tbl3.applypt = function()
		if not tbl10.pt then
			return
		end
		local v5 = tbl3.safechar()
		if not v5 then
			return
		end
		local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		for _, v6 in ipairs({ "_ptrail", "_ptrailA", "_ptrailB" }) do
			local v7 = humanoidRootPart:FindFirstChild(v6)

			if v7 then
				v7:Destroy()
			end
		end

		local attachment = Instance.new("Attachment")
		attachment.Name = "_ptrailA"
		attachment.Position = Vector3.new(0, 1.5, 0)
		attachment.Parent = humanoidRootPart
		local attachment2 = Instance.new("Attachment")
		attachment2.Name = "_ptrailB"
		attachment2.Position = Vector3.new(0, -1.5, 0)
		attachment2.Parent = humanoidRootPart
		local trail = Instance.new("Trail")
		trail.Name = "_ptrail"
		trail.Attachment0 = attachment
		trail.Attachment1 = attachment2
		trail.Lifetime = tbl10.ptlife
		trail.FaceCamera = true
		trail.LightEmission = 1
		trail.WidthScale = NumberSequence.new(tbl10.ptwidth)
		local new = NumberSequenceKeypoint.new
		trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new(1, 1) })
		trail.Color = tbl3.ptcol()
		trail.Parent = humanoidRootPart
	end

	tbl3.refpt = function()local l= tbl3 .safechar();if not l then return;end;local K=l:FindFirstChild("HumanoidRootPart");if not K then return;end;l=K:FindFirstChild("_ptrail");if l then l.Color= tbl3 .ptcol();l.Lifetime= tbl10 .ptlife;l.WidthScale=NumberSequence.new( tbl10 .ptwidth);end;end

	tbl3.clrpt = function()
		local v5 = tbl3.safechar()
		if not v5 then
			return
		end
		local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		for _, v6 in ipairs({ "_ptrail", "_ptrailA", "_ptrailB" }) do
			local v7 = humanoidRootPart:FindFirstChild(v6)

			if v7 then
				v7:Destroy()
			end
		end
	end

	tbl3.setupviz = function()
		if tbl9.vzdash then
			for _, v5 in ipairs(tbl9.vzdash) do
				v5:Destroy()
			end

			tbl9.vzdash = nil
		end

		if tbl9.vzpart then
			tbl9.vzpart:Destroy()
			tbl9.vzpart = nil
		end

		if tbl10.viz then
			local vzdash = {}

			for i = 1, 36 do
				local part = Instance.new("Part")
				part.Name = "_fx"
				part.Material = Enum.Material.Neon
				part.Transparency = 0.2
				part.Anchored = true
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.CastShadow = false
				part.Size = Vector3.new(0.35, 0.2, 1.6)
				part.Parent = Workspace
				vzdash[i] = part
			end

			tbl9.vzdash = vzdash
			local part = Instance.new("Part")
			part.Name = "_fx"
			part.Shape = Enum.PartType.Ball
			part.Material = Enum.Material.ForceField
			part.Transparency = 0.7
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.CastShadow = false
			part.Size = Vector3.zero
			part.Parent = Workspace
			tbl9.vzpart = part
		end
	end

	tbl3.updviz = function()local l= tbl9 .vzdash;if not  tbl10 .viz or not l then return;end;local K= tbl3 .safechar();local p,E=K and K.PrimaryPart, tbl3 .getball();if not(p and E)then for k,k in ipairs(l)do k.Transparency=1;end;if  tbl9 .vzpart then  tbl9 .vzpart.Size=Vector3.new(0.0,0.0,0.0);end;return;end;local k= tbl10 .vizcol or(Color3.fromRGB(91,110,232));k= tbl3 .ballTarget(E)== localPlayer .Name and(Color3.fromRGB(232,91,110))or k;local a= tbl3 .ballVel(E).Magnitude;local d,I,C= clamp ( tbl3 .parryWindow(a),7.5,100),p.Position-Vector3.new(0,2.9,0),#l;E= clamp (d/20,0.6,3);a= tbl9 .vzcol~=k or  abs (( tbl9 .vzscale or-1)-E)>0.01;if a then  tbl9 .vzcol=k; tbl9 .vzscale=E;end;K=a and(Vector3.new(0.35*E,0.2,1.6*E))or nil;for U=1,C,1 do local J=l[U];local G=(U-1)/C* n *2;E=I+Vector3.new( cos (G)*d,0, sin (G)*d);J.CFrame=CFrame.new(E)*CFrame.Angles(0,-G,0);if a then J.Size=K;J.Color=k;end;if J.Transparency~=0.2 then J.Transparency=0.2;end;end;if  tbl9 .vzpart then l=d*2;if  abs (( tbl9 .vzdia or-1)-l)>0.05 then  tbl9 .vzdia=l; tbl9 .vzpart.Size=Vector3.new(l,l,l);end; tbl9 .vzpart.CFrame=CFrame.new(p.Position);if a then  tbl9 .vzpart.Color=k;end;end;end

	tbl3.bind(UserInputService.LastInputTypeChanged:Connect(function(lastinput)
		tbl9.lastinput = lastinput
	end))

	do
		local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)

		if not remotes then
			warn("[Rise] ReplicatedStorage.Remotes never appeared - stopping.")
			tbl3.notif("Rise", "The game's remotes never loaded. Rejoin and run Rise again.", 10)
			_G.cuties = nil
			_G.RiseJob = nil
			_G.RiseBoot = nil
			return
		end

		_G.stagesh = "remotes"
		local parrySuccess = remotes:FindFirstChild("ParrySuccess")

		if parrySuccess then
			tbl3.bind(parrySuccess.OnClientEvent:Connect(function()if  tbl3 .isalive()then  tbl3 .stopgrab();end;end))
		end

		local infinityBall = remotes:FindFirstChild("InfinityBall")

		if infinityBall then
			tbl3.bind(infinityBall.OnClientEvent:Connect(function(l,l) tbl9 .infball=l and true or false;end))
		end

		local parrySuccessAll = remotes:FindFirstChild("ParrySuccessAll")

		if parrySuccessAll then
			tbl3.bind(parrySuccessAll.OnClientEvent:Connect(function(l,l)local K= localPlayer .Character and  localPlayer .Character.PrimaryPart;local p= tbl3 .getball();if not K or not p then return;end;if not  tbl3 .ballLive(p)then return;end;local E= tbl3 .ballPos(p);if not E then return;end;local k= tbl3 .ballVel(p);local a,d,I=k.Magnitude,(K.Position-E).Magnitude,k.Magnitude>0 and k.Unit or(Vector3.new(0.0,0.0,0.0));p,k=(K.Position-E).Unit:Dot(I), tbl3 .getping();E= min (a/100,40);local I,C=d/ max (a,1)-k/1000,40* max (p,0);p=15- min (d/1000,15)+C+E;if l~=K and d>(if a>100 and I>k/10 then( max (p-15,15))else p)then  tbl9 .curve.curving=tick();end;end))
		end
	end

	local function fn7(arg)
		tbl9.aero[arg] = tick() + (arg:GetAttribute("TornadoTime") or 1) + 0.4

		tbl3.bind(arg:GetAttributeChangedSignal("TornadoTime"):Connect(function()
			tbl9.aero[arg] = tick() + (arg:GetAttribute("TornadoTime") or 1) + 0.4
		end))
	end

	for _, v5 in ipairs(CollectionService:GetTagged("AerodynamicSlashTornado")) do
		fn7(v5)
	end

	tbl3.bind(CollectionService:GetInstanceAddedSignal("AerodynamicSlashTornado"):Connect(fn7))

	tbl3.bind(CollectionService:GetInstanceRemovedSignal("AerodynamicSlashTornado"):Connect(function(arg)
		tbl9.aero[arg] = nil
	end))

	local balls = Workspace:FindFirstChild("Balls")

	if balls then
		tbl3.bind(balls.ChildRemoved:Connect(function()
			tbl9.curve.curving = tick()
			tbl9.curve.lerprad = 0
			tbl9.curve.lastwarp = tick()
		end))

		tbl3.bind(balls.ChildAdded:Connect(function()task.wait();if  tbl10 .bt then  tbl3 .applybt();end;end))
	end

	tbl3.visacc = 0
	tbl3.bind(RunService.Heartbeat:Connect(function(l) tbl3 .visacc= tbl3 .visacc+l;if  tbl3 .visacc>=0.066 then  tbl3 .visacc= tbl3 .visacc-0.066;if  tbl10 .bt then  tbl3 .applybt();end;if  tbl10 .pt and  tbl10 .ptrb then  tbl3 .refpt();end;end;if  tbl10 .viz then  tbl3 .updviz();end;end))

	tbl3.mirror = {
		abilspd = "abilityminspeed",
		acc = "parryaccuracy",
		advcrv = "advcrv",
		antiafk = "antiafk",
		autoabil = "autoability",
		autoexec = "autoexecute",
		autoparry = "autoparry",
		autospam = "autospam",
		bestcfg = "autobestconfig",
		bloom = "shaderbloom",
		brightness = "shaderbrightness",
		bt = "balltrail",
		btend = "balltrailendcolour",
		btglow = "balltrailglow",
		btlife = "balltraillifetime",
		btpart = "balltrailparticles",
		btrb = "balltrailrainbow",
		btstart = "balltrailstartcolour",
		cdprot = "cooldownprotection",
		contrast = "shadercontrast",
		crv = "curves",
		crvstr = "curvestrength",
		curvekb = "curvekb",
		devscreen = "devicescreen",
		devtype = "devicetype",
		dof = "shaderdof",
		drbpre = "dribblepreclick",
		emospam = "emotespam",
		emospawn = "emoteonspawn",
		emospd = "emotespamspeed",
		emoteonly = "emoteonly",
		forceemo = "forceemote",
		fpscap = "fpscap",
		fpsval = "fpscapvalue",
		manspam = "manualspam",
		mansui = "manualspamui",
		music = "music",
		nocrv = "nocurvespam",
		norender = "norender",
		nscrv = "nscrv",
		pt = "playertrail",
		ptcol = "playertrailcolour",
		ptlife = "playertraillifetime",
		ptrb = "playertrailrainbow",
		ptwidth = "playertrailwidth",
		pulldetect = "pulldetect",
		rain = "raineffect",
		rainrate = "rainintensity",
		randtgt = "randomtarget",
		randtime = "randomtargettime",
		rng = "parryrange",
		saturation = "shadersaturation",
		shaderpreset = "shaderpreset",
		shaders = "shaders",
		socrv = "socrv",
		sofctr = "sofcounter",
		sofdelay = "sofdelay",
		sofmode = "sofmode",
		staff = "staffdetection",
		staffdo = "staffaction",
		thundernocd = "thundernocd",
		tlock = "targetlock",
		tlockui = "targetlockui",
		track = "musictrack",
		trigger = "triggerbot",
		viptag = "viptag",
		viz = "visualizer",
		vizcol = "visualizercolour",
		vol = "musicvolume",
	}

	tbl3.widget = function(arg)
		return toggles[arg] or options[arg]
	end

	tbl3.syncopt = function()
		for k, v5 in pairs(tbl3.mirror) do
			local v6 = tbl3.widget(v5)

			if v6 then
				tbl10[k] = v6.Value
			end
		end

		tbl10.musicid = options.musiccustom.Value or ""
		tbl10.keyparry = options.parrymethod.Value == "Keypress"
	end

	local tbl13 = {}

	for k, v5 in pairs(tbl3.mirror) do
		if not tbl3.widget(v5) then
			tbl13[#tbl13 + 1] = k .. " -> " .. v5
		end
	end

	if #tbl13 > 0 then
		table.sort(tbl13)
		warn("[Rise] mirror points at controls that do not exist: " .. table.concat(tbl13, ", "))
	end

	tbl3.syncopt()
	tbl3.startdet()
	tbl3.startpred()
	_G.stagesh = "detect"

	options.menukeybind:OnChanged(function()
		v.ToggleKeybind = options.menukeybind
		tbl3.qsave()
	end)

	do
		local tbl14 = {}

		tbl3.applysky = function(arg)
			if tbl14.skywatch then
				tbl14.skywatch:Disconnect()
				tbl14.skywatch = nil
			end

			if tbl14.sky then
				tbl14.sky:Destroy()
				tbl14.sky = nil
			end

			if not arg or arg == "Default" then
				if tbl14.origskies then
					for _, origsky in ipairs(tbl14.origskies) do
						origsky.Parent = Lighting
					end

					tbl14.origskies = nil
				end

				return
			end

			local v5 = tbl5[arg]
			if not v5 then
				return
			end
			tbl14.origskies = tbl14.origskies or {}

			for _, child in ipairs(Lighting:GetChildren()) do
				if child:IsA("Sky") then
					child.Parent = nil
					tbl14.origskies[#tbl14.origskies + 1] = child
				end
			end

			local sky = Instance.new("Sky")
			sky.Name = "rise_sky"
			sky.SkyboxBk = "rbxassetid://" .. v5.bk
			sky.SkyboxDn = "rbxassetid://" .. v5.dn
			sky.SkyboxFt = "rbxassetid://" .. v5.ft
			sky.SkyboxLf = "rbxassetid://" .. v5.lf
			sky.SkyboxRt = "rbxassetid://" .. v5.rt
			sky.SkyboxUp = "rbxassetid://" .. v5.up
			sky.StarCount = v5.stars or 3000
			sky.SunAngularSize = v5.sun or 21
			sky.MoonAngularSize = v5.moon or 11
			sky.CelestialBodiesShown = v5.cel == true
			sky.Parent = Lighting
			tbl14.sky = sky
			tbl14.skywatch = Lighting.ChildAdded:Connect(function(l)if l:IsA("Sky")and l~= tbl14 .sky then task.defer(function()if l.Parent== Lighting and l~= tbl14 .sky then  tbl14 .origskies= tbl14 .origskies or{};l.Parent=nil; tbl14 .origskies[# tbl14 .origskies+1]=l;end;end);end;end)
		end

		local tbl15 = { Day = 14, Sunset = 17.5, Night = 22, Midnight = 0 }

		tbl3.settime = function(arg)
			if arg == "Default" then
				if tbl14.ct ~= nil then
					Lighting.ClockTime = tbl14.ct
					tbl14.ct = nil
				end

				return
			end

			if tbl14.ct == nil then
				tbl14.ct = Lighting.ClockTime
			end

			Lighting.ClockTime = tbl15[arg] or Lighting.ClockTime
		end

		tbl3.setbright = function(arg)
			if arg then
				if not tbl14.lorig then
					tbl14.lorig = { b = Lighting.Brightness, a = Lighting.Ambient, o = Lighting.OutdoorAmbient, gs = Lighting.GlobalShadows }
				end

				Lighting.Brightness = 2
				Lighting.Ambient = Color3.fromRGB(178, 178, 178)
				Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
				Lighting.GlobalShadows = false
			elseif tbl14.lorig then
				Lighting.Brightness = tbl14.lorig.b
				Lighting.Ambient = tbl14.lorig.a
				Lighting.OutdoorAmbient = tbl14.lorig.o
				Lighting.GlobalShadows = tbl14.lorig.gs
				tbl14.lorig = nil
			end
		end

		tbl3.setnofog = function(arg)
			if arg then
				if not tbl14.fog then
					tbl14.fog = { e = Lighting.FogEnd, s = Lighting.FogStart, atm = {} }

					for _, child in ipairs(Lighting:GetChildren()) do
						if child:IsA("Atmosphere") then
							tbl14.fog.atm[child] = child.Density
						end
					end
				end

				Lighting.FogEnd = 1000000
				Lighting.FogStart = 0

				for k in pairs(tbl14.fog.atm) do
					k.Density = 0
				end
			elseif tbl14.fog then
				Lighting.FogEnd = tbl14.fog.e
				Lighting.FogStart = tbl14.fog.s

				for k, v5 in pairs(tbl14.fog.atm) do
					k.Density = v5
				end

				tbl14.fog = nil
			end
		end

		tbl3.startfov = function()
			if tbl14.fovconn then
				return
			end
			tbl14.fovconn = tbl3.bind(RunService.RenderStepped:Connect(function()if not  toggles .customfov.Value then return;end;local l= Workspace .CurrentCamera;if l then if  tbl14 .fovorig==nil then  tbl14 .fovorig=l.FieldOfView;end;local K= options .fov.Value;if l.FieldOfView~=K then l.FieldOfView=K;end;end;end))
		end

		tbl3.restorefov = function()
			local currentCamera2 = Workspace.CurrentCamera

			if currentCamera2 and tbl14.fovorig ~= nil then
				currentCamera2.FieldOfView = tbl14.fovorig
			end

			tbl14.fovorig = nil
		end

		tbl3.setgrav = function()
			if toggles.customgrav.Value then
				if tbl14.gravorig == nil then
					tbl14.gravorig = Workspace.Gravity
				end

				Workspace.Gravity = options.grav.Value
			elseif tbl14.gravorig ~= nil then
				Workspace.Gravity = tbl14.gravorig
				tbl14.gravorig = nil
			end
		end

		tbl3.gfxsweep = function()local l= tbl14 .gfx;if not l then return;end;for K,K in ipairs( Lighting :GetDescendants())do if not l.seen[K]then if K:IsA("Atmosphere")then l.seen[K]=true;l.saved[#l.saved+1]={K,"Density",K.Density};K.Density=0;elseif K:IsA("BloomEffect")or(K:IsA("SunRaysEffect"))or(K:IsA("DepthOfFieldEffect"))or(K:IsA("BlurEffect"))then l.seen[K]=true;l.saved[#l.saved+1]={K,"Enabled",K.Enabled};K.Enabled=false;end;end;end;for K,K in ipairs( Workspace :GetDescendants())do if not l.seen[K]and(K:IsA("ParticleEmitter")or(K:IsA("Trail"))or(K:IsA("Smoke"))or(K:IsA("Fire"))or(K:IsA("Sparkles")))and K.Enabled then l.seen[K]=true;K.Enabled=false;l.parts[#l.parts+1]=K;end;end;end
		tbl3.gfxwatch = function()if  tbl14 .gfxmap then  tbl14 .gfxmap:Disconnect(); tbl14 .gfxmap=nil;end;if  tbl14 .gfxroot then  tbl14 .gfxroot:Disconnect(); tbl14 .gfxroot=nil;end;if not  tbl14 .gfx then return;end;local l=nil;l=function() tbl3 .bindt(task.delay(0.5, tbl3 .gfxsweep));end;local function K(p)if  tbl14 .gfxmap then  tbl14 .gfxmap:Disconnect();end; tbl14 .gfxmap= tbl3 .bind(p.ChildAdded:Connect(l));end;local p= Workspace :FindFirstChild("Map");if p then K(p);end; tbl14 .gfxroot= tbl3 .bind( Workspace .ChildAdded:Connect(function(h)if h.Name~="Map"then return;end;K(h);l();end));end
		tbl3.setlowgfx = function(l)if l then if not  tbl14 .gfx then  tbl14 .gfx={q=settings().Rendering.QualityLevel,gs= Lighting .GlobalShadows,parts={},saved={},seen={}};settings().Rendering.QualityLevel=Enum.QualityLevel.Level01; Lighting .GlobalShadows=false;local function l(K,p) tbl14 .gfx.seen[K]=true; tbl14 .gfx.saved[# tbl14 .gfx.saved+1]={K,p,K[p]};end;l( Workspace ,"GlobalWind"); Workspace .GlobalWind=Vector3.new(0,0,0);l( Lighting ,"EnvironmentDiffuseScale"); Lighting .EnvironmentDiffuseScale=0;l( Lighting ,"EnvironmentSpecularScale"); Lighting .EnvironmentSpecularScale=0;local K= Workspace :FindFirstChildOfClass("Terrain");if K then l(K,"Decoration");K.Decoration=false;l(K,"WaterWaveSize");K.WaterWaveSize=0;local p=K:FindFirstChildOfClass("Clouds");if p then l(p,"Enabled");p.Enabled=false;end;end; tbl3 .gfxsweep(); tbl3 .gfxwatch();end;elseif  tbl14 .gfx then settings().Rendering.QualityLevel= tbl14 .gfx.q; Lighting .GlobalShadows= tbl14 .gfx.gs;for l,l in ipairs( tbl14 .gfx.saved)do if l[1]and l[1].Parent then l[1][l[2]]=l[3];end;end;for l,l in ipairs( tbl14 .gfx.parts)do if l and l.Parent then l.Enabled=true;end;end; tbl14 .gfx=nil; tbl3 .gfxwatch();end;end

		tbl3.applycap = function()
			if setfpscap then
				local v5 = setfpscap
				local fpscap = tbl10.fpscap

				if fpscap then
					fpscap = clamp(tbl10.fpsval or 60, 5, 1000)
				end

				v5(fpscap or 0)
			end
		end

		tbl3.startantilag = function()
			if tbl9.alconn then
				return
			end
			tbl9.altime = 0
			tbl9.alframes = 0
			tbl9.alfps = 60
			tbl9.alapplied = false
			tbl9.alconn = tbl3.bind(RunService.RenderStepped:Connect(function(l)if not( toggles .antilag and  toggles .antilag.Value)then return;end; tbl9 .alframes= tbl9 .alframes+1; tbl9 .altime= tbl9 .altime+l;if  tbl9 .altime<0.5 then return;end; tbl9 .alfps= tbl9 .alframes/ tbl9 .altime; tbl9 .alframes=0; tbl9 .altime=0;if  toggles .lowgfx and  toggles .lowgfx.Value then  tbl9 .alapplied=false;return;end;local l= options .antilagfps and  options .antilagfps.Value or 30;if not  tbl9 .alapplied then if  tbl9 .alfps<l then  tbl9 .alapplied=true; tbl3 .setlowgfx(true); tbl3 .notif("Anti-Lag", format ("FPS dropped to %.0f. Effects turned off.", tbl9 .alfps),3);end;elseif  tbl9 .alfps>l+15 then  tbl9 .alapplied=false; tbl3 .setlowgfx(false); tbl3 .notif("Anti-Lag","FPS is back up. Effects turned on.",3);end;end))
		end

		fn3 = function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
		end

		fn5 = function()
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.Health = 0
				humanoid:ChangeState(Enum.HumanoidStateType.Dead)
			elseif character then
				character:BreakJoints()
			end
		end

		fn4 = function()
			tbl3.bindt(task.spawn(function()
				local str2 = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
				local v5 = tbl3.httpget(str2)
				local data = v5 and HttpService:JSONDecode(v5)
				if type(data) ~= "table" or not data.data then
					tbl3.notif("Server", "Couldn't load the server list. Try again.", 4)
					return
				end

				for _, v6 in ipairs(data.data) do
					if type(v6) == "table" and v6.playing and v6.maxPlayers and v6.playing < v6.maxPlayers and v6.id ~= game.JobId then
						TeleportService:TeleportToPlaceInstance(game.PlaceId, v6.id, localPlayer)
						return
					end
				end

				tbl3.notif("Server", "No other server found.", 4)
			end))
		end

		local tbl16 = {
			file = "Rise_FFlags_" .. tostring(game.GameId) .. ".json",
			ipcache = {},
			hopping = false,
			sea = {
				SG = true,
				MY = true,
				ID = true,
				TH = true,
				VN = true,
				PH = true,
				KH = true,
				LA = true,
				MM = true,
				BN = true,
				TL = true,
			},
			sasia = { IN = true, PK = true, BD = true, LK = true, NP = true, BT = true, MV = true, AF = true },
			presetnames = {
				"FPS Boost",
				"Low Ping",
				"Stutter Ball",
				"No Textures",
				"Glitch Curve",
				"Low Input Delay",
				"Low Mesh",
				"Shiny Ball",
				"Gray World",
			},
			presetdefault = "FPS Boost",
			presets = {
				["FPS Boost"] = {
					FFlagControlBetaBadgeWithGuac = "False",
					FFlagLuaAppsEnableParentalControlsTab = "False",
					FFlagTaskSchedulerLimitTargetFpsTo2402 = "False",
					FFlagDebugSkyGray = "True",
					FFlagBetaBadgeLearnMoreLinkFormview = "False",
					FFlagDebugDisableTelemetryEphemeralCounter = "True",
					FFlagDebugDisableTelemetryPoint = "True",
					FIntEnableVisBugChecksHundredthPercent27 = "100",
					FFlagCoreGuiSelfViewVisibilityFixed = "False",
					FFlagEnableAudioPannerFiltering = "True",
					DFIntTaskSchedulerTargetFps = "9999",
					FFlagWindowsReportAbuseNotification = "False",
					FFlagRenderLightGridEfficientTextureAtlasUpdate = "True",
					FFlagEnableInGameMenuChromeABTest4 = "True",
					DFFlagUnifyLegacyJointGeometry = "True",
					DFIntAnimationLodFacsDistanceMin = "0",
					FIntRenderGrassDetailStrands = "0",
					DFFlagDebugSkipMeshVoxelizer = "True",
					DFIntWindowsWebViewTelemetryThrottleHundredthsPercent = "0",
					FFlagGraphicsTextureCopy = "True",
					FFlagClientToastNotificationsEnabled = "False",
					FIntSmoothTerrainPhysicsCacheSize = "2147483647",
					FFlagUserShowGuiHideToggles = "True",
					DFStringRobloxAnalyticsURL = "http://127.0.0.1:443/",
					FFlagAXFixAdaptiveScrollingSnapAndroid = "True",
					FFlagAdServiceEnabled = "False",
					DFIntVoiceChatMaxRecordedDataDeliveryIntervalMs = "2147483647",
					FFlagDebugGraphicsPreferD3D11FL10 = "True",
					FFlagDisableFeedbackSoothsayerCheck = "False",
					FFlagEnablePreferredTextSizeConnection = "True",
					DFFlagOptimizeNoCollisionPrimitiveInMidphaseCrash = "True",
					DFIntRakNetMtuValue2InBytes = "900",
					FIntSelfViewTooltipLifetime = "0",
					FIntUnifiedLightingBlendZone = "1",
					DFIntPerformanceControlTextureQualityBestUtility = "-1",
					FFlagEnableExperienceNotificationPrompts2 = "False",
					FFlagAXAdaptiveScrollingItemResetFix2 = "True",
					DFIntRakNetMtuValue1InBytes = "900",
					FFlagVoiceBetaBadge = "False",
					FFlagSortKeyOptimization = "True",
					DFIntGraphicsOptimizationModeMinFrameTimeTargetMs = "25",
					FFlagPreloadMinimalFonts = "True",
					FFlagOcclusionCullingBetaFeature = "True",
					FFlagLuauCodegen = "True",
					DFIntTextureQualityOverride = "0",
					FIntRobloxGuiBlurIntensity = "0",
					FFlagFixSettingsHubVRBackgroundError = "True",
					FIntDebugFRMOptionalMSAALevelOverride = "0",
					FFlagUseNotificationsLocalization = "False",
					FFlagVRLaserPointerOptimization = "True",
					FFlagEnablePreferredTextSizeStyleFixesInPurchasePrompt = "True",
					FFlagSelfViewGetRidOfFalselyRenderedFaceDecal = "False",
					FFlagEnablePreferredTextSizeStyleFixesGameTile = "True",
					FIntFixForBulkPresenceNotifications = "0",
					FStringTerrainMaterialTable2022 = "",
					DFIntGraphicsOptimizationModeMaxFrameTimeTargetMs = "20",
					DFFlagTeleportClientAssetPreloadingEnabled9 = "True",
					FFlagUserEnableCameraToggleNotification = "False",
					FFlagUserFixLoadAnimationError = "True",
					DFFlagAdsPreloadInteractivityAssets = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
					FFlagEngineAPICloudProcessingUseNotificationClient = "False",
					FIntTargetRefreshRate = "144",
					FFlagToastNotificationsReceivedAndDismissedSignals = "False",
					DFStringTelemetryV2Url = "http://127.0.0.1:443",
					DFFlagEngineAPISendNotificationClientAnalytics = "False",
					FFlagPreferredTextSizeStyleFixEventDescriptionExperienceTile = "True",
					DFStringTelegrafAddress = "127.0.0.1",
					DFIntRakNetMtuValue3InBytes = "900",
					DFIntMicroProfilerDpiScaleOverride = "100",
					FFlagVRMouseMoveOptimization = "True",
					FFlagEnableChromeFTUX = "True",
					FFlagSettingsHubIndependentBackgroundVisibility = "True",
					FIntSSAOMipLevels = "1",
					FFlagShoeSkipRenderMesh = "False",
					FIntRuntimeMaxNumOfThreads = "2400",
					FFlagSignalRNotificationManagerMaybeStart = "False",
					FIntCameraMaxZoomDistance = "999999",
					FIntAXAdaptiveScrollingJustSelectedMillis = "2000",
					FFlagToastNotificationsResendDisplayOnInit = "False",
					FIntOcclusionCullingBetaFeatureRolloutPercent = "100",
					DFFlagAudioToggleVolumetricPanning = "True",
					FIntVRTouchControllerTransparency = "0",
					FFlagAXSearchLandingPageIXPEnabled4 = "False",
					FFlagLuaMenuPerfImprovements = "true",
					FFlagViewCollisionFadeToBlackInVR = "False",
					FFlagFixSensitivityTextPrecision = "False",
					FIntRenderLocalLightUpdatesMin = "1",
					DFFlagEnableExperienceNotificationOptInPrompt = "False",
					FIntCAP1209DataSharingTOSVersion = "0",
					FFlagToastNotificationsProtocolEnabled2 = "False",
					DFFlagJointIrregularityOptimization = "true",
					FIntRenderMaxShadowAtlasUsageBeforeDownscale = "1",
					FFlagGraphicsGLEnableSuperHQShadersExclusion = "False",
					DFIntCanHideGuiGroupId = "32380007",
					DFIntDefaultTimeoutTimeMs = "10000",
					FFlagNewOptimizeNoCollisionPrimitiveInMidphase637 = "True",
					FFlagStudioDataCollectionAddBasicNotification = "False",
					DFFlagTeleportClientAssetPreloadingEnabledIXP2 = "True",
					FFlagSelfViewLookUpHumanoidByType = "False",
					DFIntMaxFrameBufferSize = "10",
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					FFlagAssetPreloadingIXP = "True",
					DFFlagDisableDPIScale = "False",
					FFlagFixIGMTabTransitions = "True",
					FFlagAvatarChatIncludeSelfViewOnTelemetry = "False",
					FFlagFastGPULightCulling3 = "True",
					FFlagRenderDebugCheckThreading2 = "True",
					FFlagEnableCommandAutocomplete = "False",
					FIntPreferredTextSizeSettingBetaFeatureRolloutPercent = "100",
					FFlagEnablePreferredTextSizeScale = "True",
					FIntUITextureMaxUpdateDepth = "-1",
					DFIntDebugFRMQualityLevelOverride = "1",
					FFlagQuaternionPoseCorrection = "True",
					FFlagEnableIOSWebViewCookieSyncFix = "False",
					FFlagDebugCodegenOptSize = "True",
					FFlagFRMRefactor = "False",
					FFlagImproveShiftLockTransition = "True",
					FIntFRMMaxGrassDistance = "0",
					FFlagEnableVisBugChecks27 = "True",
					DFFlagEnablePerfRenderStatsCollection2 = "false",
					DFIntDebugRestrictGCDistance = "1",
					FFlagFixReducedMotionStuckIGM2 = "True",
					FFlagInExperienceUpsellSelfViewFix = "False",
					FLogNetwork = "7",
					DFFlagNotificationServiceIsConnectedProperty = "False",
					FFlagToastNotificationsUpdateEventParams = "False",
					DFFlagAudioUseVolumetricPanning = "True",
					FFlagDebugForceGenerateHSR = "True",
					FIntTerrainOTAMaxTextureSize = "4",
					FFlagAXAdaptiveScrollingImprovementIXPEnabled = "True",
					FFlagSelfViewUpdatedCamFraming = "False",
					FFlagSelfViewRemoveVPFWhenClosed = "False",
					DFIntVideoMaxNumberOfVideosPlaying = "0",
					DFFlagPhysicsMechanismCacheOptimizeAlloc = "True",
					FFlagSelfViewMoreNilChecks = "False",
					FFlagEnablePreferredTextSizeScalePerLayerCollector = "True",
					DFIntConnectionMTUSize = "900",
					FFlagSelfViewHumanoidNilCheck = "False",
					DFFlagEnableSoundPreloading = "True",
					FIntGrassMovementReducedMotionFactor = "0",
					FFlagRenderEnableGlobalInstancingD3D10 = "True",
					FFlagAXAdaptiveScrollingAvatarEditor2 = "True",
					FFlagFixEmotesMenuVR = "True",
					FFlagEnableChildrenLockFromLua = "False",
					FFlagEnableBetterHapticsResultHandling = "True",
					FFlagDebugDisableTelemetryV2Stat = "True",
					FFlagLuaAppGenreUnderConstruction = "False",
					FFlagRenderShadowSkipHugeCulling = "True",
					FFlagGraphicsEnableD3D10Compute = "True",
					FFlagDebugRenderingSetDeterministic = "True",
					FIntRomarkStartWithGraphicQualityLevel = "1",
					DFFlagOptimizeIsA = "True",
					FFlagSelfViewFixes = "False",
					DFStringWebviewUrlAllowlist = "",
					FFlagAXPortraitSplitAdaptiveScrollingFix2 = "True",
					FFlagSelfieViewEnabled = "True",
					FFlagRenderEnableGlobalInstancingD3D11 = "False",
					FFlagEnableChildrenLockFromLua2 = "False",
					FIntFRMMinGrassDistance = "0",
					FFlagSimEnableDCD16 = "True",
					FFlagVRFixCursorJitterLua = "True",
					FFlagDebugGraphicsPreferD3D11 = "False",
					FIntCAP1209DataSharingRolloutPercentage = "0",
					DFFlagSimDcdRecompUseClosedVoxel4 = "True",
					DFFlagDebugPerfMode = "True",
					FFlagGuiHidingApiSupport2 = "True",
					FFlagEnablePreferredTextSizeStyleFixesInExperienceMenu = "True",
					FFlagRenderFixFog = "True",
					FIntRenderLocalLightUpdatesMax = "1",
					FFlagTopBarUseNewBadge = "False",
					FFlagFixParticleAttachmentCulling = "False",
					FFlagDisableChromeV3StaticSelfView = "False",
					DFFlagSimRefactorCollisionGeometry2 = "True",
					FStringVoiceBetaBadgeLearnMoreLink = "null",
					DFIntContentProviderPreloadHangTelemetryHundredthsPercentage = "0",
					FFlagFixExitDialogBlockVRView = "True",
					FFlagVRBackpackImproved = "True",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage = "100000",
					DFFlagAssetPreloadingUrlVersionEnabled2 = "True",
					FFlagCSGDecalOptimizeVB = "True",
					FIntCAP1544DataSharingUserRolloutPercentage = "0",
					FFlagEnablePreferredTextSizeStyleFixesAddFriends = "True",
					FFlagDeveloperToastNotificationsEnabled = "False",
					FFlagVideoTextureSupportHardwareRender2 = "True",
					FFlagUserHideCharacterParticlesInFirstPerson = "True",
					FIntTaskSchedulerThreadMin = "3",
					FFlagDebugCheckRenderThreading = "True",
					FIntVertexSmoothingGroupTolerance = "1",
					DFIntAnimationLodFacsVisibilityDenominator = "0",
					FFlagSelfViewAvoidErrorOnWrongFaceControlsParenting = "False",
					FFlagUseNotificationServiceIsConnected = "False",
					FIntRefreshRateLowerBound = "120",
					DFStringAltTelegrafAddress = "127.0.0.1",
					FFlagCAP1544UseNewDataSharingRollout = "False",
					FFlagDebugDisableTelemetryEphemeralStat = "True",
					FFlagFixOutdatedTimeScaleParticles = "False",
					FFlagMouseGetPartOptimization = "True",
					FIntBootstrapperWebView2InstallationTelemetryHundredthPercent = "0",
					FFlagNotificationsNoLongerRequireControllerState = "False",
					FIntFullscreenTitleBarTriggerDelayMillis = "3600000",
					FFlagRemoveRedundantFontPreloading = "True",
					FIntStudioExternalNotificationImplMessageWriteTimeOut = "0",
					FFlagShaderLightingRefactor = "True",
					FFlagEnablePreferredTextSizeStyleFixesInPlayerList = "True",
					FIntRenderShadowmapBias = "-1",
					DFIntHACDPointSampleDistApartTenths = "2147483647",
					FIntEnableCullableScene2HundredthPercent3 = "100",
					FFlagLuaAppGamesPagePreloadingDisabled = "False",
					FFlagDebugForceFSMCPULightCulling = "True",
					FFlagEnableRemoveIsFromToastNotification = "False",
					FFlagHandleAltEnterFullscreenManually = "False",
					FFlagGraphicsGLEnableHQShadersExclusion = "False",
					FFlagPreferredTextSizeSettingBetaFeature = "True",
					FFlagEnableAudioEmitterDistanceAttenuation = "True",
					DFIntNumAssetsMaxToPreload = "2147483647",
					FFlagSquadToastNotificationsEnabled = "False",
					FFlagDebugDisableTelemetryV2Event = "True",
					DFFlagTeleportPreloadingMetrics5 = "True",
					FFlagLuaAppEnableToastNotificationsCoreScripts4 = "False",
					FFlagNewLightAttenuation = "True",
					FFlagEnableCullableScene2OptimizeStep = "True",
					FFlagFixSelfViewPopin = "False",
					DFFlagVoiceChatTurnOnMuteUnmuteNotificationHack = "False",
					FFlagMockOpenSelfViewForCameraUser = "False",
					DFStringAnalyticsNS1BeaconConfig = "https://127.0.0.1:443/|g2hjxw|https://127.0.0.1:443/|g2g5dg|https://127.0.0.1:443/|148d53m",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage2 = "100000",
					FFlagEnablePreferredTextSizeStyleFixesInAppShell3 = "True",
					FFlagDebugDeterministicParticles = "False",
					FFlagNotificationPluginSignalRReadEvents = "False",
					FIntTextureCompositorLowResFactor = "4",
					FFlagDebugSelfViewPerfBenchmark = "False",
					FStringTerrainMaterialTablePre2022 = "",
					DFFlagTeleportClientAssetPreloadingDoingExperiment2 = "True",
					DFIntBufferCompressionLevel = "0",
					FFlagVisBugChecksThreadYield = "True",
					FFlagNotificationButtonTypeVariantMappingEmphasis = "False",
					FFlagRenderLegacyShadowsQualityRefactor = "True",
					FFlagEnableVRFTUXExperienceV2 = "True",
					FFlagSelfViewTweaksPass = "False",
					DFFlagAudioEnableVolumetricPanningForPolys = "True",
					FFlagDebugDisableTelemetryV2Counter = "True",
					FFlagDebugStudioForceSystemDeprecationNotification = "False",
					DFFlagSimSkipVoxelCDECMerge = "true",
					FFlagEnablePreferredTextSizeStyleFixesInAppShell4 = "True",
					DFIntDebugAdditionalNumberOfMipsToSkipForNonAlbedoTextures = "0",
					FFlagMigrateTextureManagerIsLocalAsset = "True",
					FFlagFixIGMBottomBarVisibility = "True",
					DFIntCullFactorPixelThresholdShadowMapLowQuality = "2147483647",
					FFlagDebugEnableDirectAudioOcclusion2 = "True",
					FFlagRenderOptimizeDecalTransparencyInvalidation = "True",
					DFFlagEnableMeshPreloading2 = "True",
					FIntRenderShadowIntensity = "0",
					FFlagSelfViewCameraDefaultButtonInViewPort = "False",
					FFlagEnableBubbleChatFromChatService = "False",
					FIntFriendRequestNotificationThrottle = "0",
					FFlagCAP1209EnableDataSharingUI4 = "False",
					DFFlagUseVisBugChecks = "True",
					FFlagEnablePreferredTextSizeStyleFixesInAvatarExp = "True",
					DFFlagWindowsWebViewTelemetryEnabled = "False",
					FFlagFixCountOfUnreadNotificationError = "False",
					DFFlagDebugPauseVoxelizer = "True",
					FFlagUpdateHTTPCookieStorageFromWKWebView = "False",
					DFFlagSimSolverOptimizeGeometricStiffness4 = "True",
					FFlagUserSoundsUseRelativeVelocity2 = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					FFlagDontRerenderForBadTexture = "True",
					DFFlagAudioEnableVolumetricPanningForMeshes = "True",
					DFFlagOpenCloudV1CreateUserNotificationAsync = "False",
					DFIntTimestepArbiterThresholdCFLThou = "300",
					FFlagDebugEnableVRFTUXExperienceInStudio = "True",
					FFlagDebugDisableTelemetryEventIngest = "True",
					FIntStudioResendDisconnectNotificationInterval = "0",
					FFlagPreOptimizeNoCollisionPrimitive = "True",
					DFIntCullFactorPixelThresholdShadowMapHighQuality = "2147483647",
					FIntDirectionalAttenuationMaxPoints = "1",
					FFlagFixChunkLightingUpdate2 = "True",
					DFFlagSimOptimizeSetSize = "True",
					FStringGetPlayerImageDefaultTimeout = "1",
					FFlagLoginPageOptimizedPngs = "True",
					FFlagChatTranslationEnableSystemMessage = "False",
					FFlagEnablePreferredTextSizeStyleFixesInReportMenu = "True",
					FIntDebugForceMSAASamples = "0",
					DFIntDebugLimitMinTextureResolutionWhenSkipMips = "0",
					FIntStudioWebView2TelemetryHundredthsPercent = "0",
					FFlagAXAdaptiveScrollingSnapItemEditor = "True",
					DFFlagOptimizePartsInPart = "True",
					FFlagAdaptiveScrollingFrameOnServer = "True",
					DFFlagEnableTexturePreloading = "True",
					FFlagRenderNoLowFrmBloom = "False",
					DFFlagTeleportClientAssetPreloadingEnabledIXP = "True",
					DFFlagTeleportClientAssetPreloadingDoingExperiment = "True",
					FIntBloomFrmCutoff = "-1",
					FFlagPreloadTextureItemsOption4 = "True",
					FFlagEnablePreferredTextSizeStyleFixesInCaptureMenu = "True",
					FFlagSyncWebViewCookieToEngine2 = "False",
					DFIntAnimationLodFacsDistanceMax = "0",
					DFIntHttpParallelLimit_RequestExperienceNotificationService = "0",
					FStringInExperienceNotificationsLayer = "",
					FFlagFixParticleEmissionBias2 = "False",
					FFlagRenderCBRefactor2 = "True",
					FStringGraphicsDisableUnalignedDxtGPUNameBlacklist = "null",
					DFFlagTextureQualityOverrideEnabled = "True",
					FFlagEnablePreferredTextSizeSettingInMenus2 = "True",
					DFIntMacWebViewTelemetryThrottleHundredthsPercent = "0",
					DFFlagDebugOverrideDPIScale = "False",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					FFlagRenderTestEnableDistanceCulling = "True",
					FFlagDisablePostFx = "True",
					DFFlagOptimizeClusterCacheAlloc = "True",
					FIntRenderLocalLightFadeInMs = "0",
					FFlagLuaAppEnableParentalControlExperiment = "False",
					DFFlagOptimizeInstanceQueries = "True",
					FFlagEnablePreferredTextSizeGuiService = "True",
					FFlagDebugSSAOForce = "False",
					FFlagRenderSkipReadingShaderData = "False",
					FFlagRemovedRbxRenderingPreProcessor = "False",
					FIntTerrainArraySliceSize = "0",
					FFlagPreloadAllFonts = "True",
					DFFlagDebugRenderForceTechnologyVoxel = "True",
					FFlagContentProviderPreloadHangTelemetry = "False",
					DFIntBufferCompressionThreshold = "100",
					DFIntCodecMaxIncomingPackets = "100",
					DFIntCodecMaxOutgoingFrames = "10000",
					DFIntDataSenderRate = "36420",
					DFIntInitialAccelerationLatencyMultTenths = "1",
					DFIntInterpolationDtLimitForLod = "10",
					DFIntInterpolationFrameRotVelocityThresholdMillionth = "1",
					DFIntInterpolationFrameVelocityThresholdMillionth = "1",
					DFIntInterpolationMinAssemblyCount = "1",
					DFIntInterpolationNumMechanismsBatchSize = "1",
					DFIntInterpolationNumMechanismsPerTask = "5",
					DFIntInterpolationNumParallelTasks = "5",
					DFIntLargePacketQueueSizeCutoffMB = "1000",
					DFIntMaxInterpolationRecursionsBeforeCheck = "1",
					DFIntMaxProcessPacketsJobScaling = "10000",
					DFIntMaxProcessPacketsStepsAccumulated = "0",
					DFIntMaxProcessPacketsStepsPerCyclic = "10000",
					DFIntMegaReplicatorNetworkQualityProcessorUnit = "10",
					DFIntNetworkCluster = "1",
					DFIntNetworkClusterPacketCacheNumParallelTasks = "2",
					DFIntNetworkSchemaCompressionRatio = "100",
					DFIntNumFramesAllowedToBeAboveError = "1",
					DFIntNumFramesToKeepAfterInterpolation = "1",
					DFIntPerformanceControlFrameTimeMax = "1",
					DFIntPerformanceControlFrameTimeMaxUtility = "-1",
					DFIntRakNetClockDriftAdjustmentPerPingMillisecond = "50",
					DFIntRakNetLoopMs = "1",
					DFIntRakNetResendRttMultiple = "1",
					DFIntRaknetBandwidthInfluxHundredthsPercentageV2 = "10000",
					DFIntRaknetBandwidthPingSendEveryXSeconds = "1",
					DFIntS2PhysicsSenderRate = "36420",
					DFIntServerBandwidthPlayerSampleRate = "36420",
					DFIntSignalRCore = "1",
					DFIntSignalRCoreError = "1",
					DFIntSignalRCoreHandshakeTimeoutMs = "1000",
					DFIntSignalRCoreHubBaseRetryMs = "50",
					DFIntSignalRCoreHubMaxBackoffMs = "500",
					DFIntSignalRCoreHubMaxElapsedMs = "5000",
					DFIntSignalRCoreKeepAlivePingPeriodMs = "1000",
					DFIntSignalRCoreNetworkHandler = "1",
					DFIntSignalRCoreRpcQueueSize = "16384",
					DFIntSignalRCoreServerTimeoutMs = "500",
					DFIntSignalRCoreTimerMs = "50",
					DFIntSignalRCoreHubConnectionDisconnectInfoHundredthsPercent = "10",
					DFIntSignalRHubConnectionBaseRetryTimeMs = "50",
					DFIntSignalRHubConnectionConnectTimeoutMs = "7000",
					DFIntSignalRHubConnectionHeartbeatTimerRateMs = "1000",
					DFIntSignalRHubConnectionMaxRetryTimeMs = "500",
					DFIntSignalRHeartbeatIntervalSeconds = "1",
					DFIntSimConstraintDataCollectionRate3 = "36420",
					DFIntTimeBetweenSendConnectionAttemptsMS = "200",
					DFIntVisibilityCheckRayCastLimitPerFrame = "10",
					DFIntWaitOnRecvFromLoopEndedMS = "10",
					DFIntWaitOnUpdateNetworkLoopEndedMS = "100",
					DFFlagAllowPropertyDefaultSkip = "True",
					DFFlagAllowRegistrationOfAnimationClipInCoreScripts = "True",
					DFFlagAnimatorFixReplicationASANError = "True",
					DFFlagClampIncomingReplicationLag = "True",
					DFFlagCorrectCachePolicySkipRedirectCache = "true",
					DFFlagEnableRequestAsyncCompression = "false",
					DFFlagGameNetFixReplicationSkipBug = "true",
					DFFlagNextGenRepRollbackOverbudgetPackets = "true",
					DFFlagNetworkSchemaImprovements = "true",
					DFFlagRakNetCalculateApplicationFeedback2 = "True",
					DFFlagRakNetDecoupleRecvAndUpdateLoopShutdown = "True",
					DFFlagRakNetDetectNetUnreachable = "True",
					DFFlagRakNetDetectRecvThreadOverload = "True",
					DFFlagRakNetDisconnectNotification = "True",
					DFFlagRakNetEnablePoll = "True",
					DFFlagRakNetFixBwCollapse = "False",
					DFFlagRakNetUnblockSelectOnShutdownByWritingToSocket = "True",
					DFFlagRakNetUseSlidingWindow4 = "true",
					DFFlagSkipReadDiskCacheRedirects = "true",
					DFFlagSkipSomeProperties = "true",
					DFFlagSkipSomePropertiesSkip = "true",
					FFlagAnimatorRetargetSkipAnkleModification = "true",
					FFlagDebugNextGenReplicatorEnabledWriteCFrameColor = "true",
					FFlagEnableInGameMenuDurationLogger = "False",
					FFlagNextGenReplicatorEnabledRead = "true",
					FFlagNextGenReplicatorEnabledWrite = "true",
					FFlagPushFrameTimeToHarmony = "True",
					FFlagSkipJoinedSessionLog = "true",
					FFlagUISUseLastFrameTimeInUpdateInputSignal = "True",
				},
				["Low Ping"] = {
					DFFlagRakNetUnblockSelectOnShutdownByWritingToSocket = "True",
					DFFlagAcceleratorUpdateOnPropsAndValueTimeChange = "True",
					DFFlagDebugLargeReplicatorForceFullSend = "true",
					DFFlagSimOptimizeGeometryChangedAssemblies2 = "True",
					DFFlagDebugLargeReplicatorDisableDelta = "true",
					DFFlagNextGenRepRollbackOverbudgetPackets = "True",
					DFFlagRakNetCalculateApplicationFeedback2 = "True",
					DFFlagReplicatorCheckReadTableCollisions = "True",
					DFFlagReplicatorSeparateVarThresholds = "True",
					DFFlagRakNetDetectRecvThreadOverload = "True",
					DFFlagJointIrregularityOptimization = "True",
					DFFlagSimSmoothedRunningController2 = "True",
					DFFlagAnimatorEnableNewAdornments = "True",
					DFFlagClampIncomingReplicationLag = "True",
					DFFlagRakNetDetectNetUnreachable = "True",
					DFFlagSolverStateReplicatedOnly2 = "True",
					DFFlagRakNetUseSlidingWindow4 = "True",
					DFFlagReplicateCreateToPlayer = "True",
					DFFlagFastEndUpdateLoop = "true",
					DFFlagMergeFakeInputEvents3 = "True",
					DFFlagSimOptimizeSetSize = "True",
					DFFlagAnimatorAnywhere = "True",
					DFFlagRakNetEnablePoll = "True",
					DFFlagDebugPerfMode = "True",
					DFFlagCanClientReplicateProp = "False",
					DFFlagDebugOverrideDPIScale = "False",
					DFFlagMouseMoveOncePerFrame = "False",
					DFFlagNetworkUseZstdWrapper = "False",
					DFFlagDisableDPIScale = "False",
					DFFlagFrameTimeStdDev = "False",
					FFlagEnableAnimatorSkipCopyPreviousRigKeyOnJointModification = "True",
					FFlagDebugNextGenReplicatorEnabledWriteCFrameColor = "True",
					FFlagPreComputeAcceleratorArrayForSharingTimeCurve = "True",
					FFlagOnlyDecrementCompletenessIfReplicating = "True",
					FFlagLuaAppLegacyInputSettingRefactor = "True",
					FFlagEnablePerformanceControlService = "True",
					FFlagDebugLargeReplicatorEnabled = "True",
					FFlagMessageBusCallOptimization = "True",
					FFlagDebugLargeReplicatorWrite = "True",
					FFlagDebugLargeReplicatorRead = "True",
					FFlagMouseGetPartOptimization = "True",
					FFlagQuaternionPoseCorrection = "True",
					FFlagLuaMenuPerfImprovements = "True",
					FFlagDebugCodegenOptSize = "True",
					FFlagSortKeyOptimization = "True",
					FFlagFasterPreciseTime4 = "True",
					FFlagSimEnableDCD16 = "True",
					FFlagEnableZstdDictionaryForClientSettings = "False",
					FFlagHandleAltEnterFullscreenManually = "False",
					FFlagEnableInGameMenuDurationLogger = "False",
					FFlagDebugDisableOptimizedBytecode = "False",
					FFlagEnableZstdForClientSettings = "False",
					FFlagKeepZeroInfluenceBones = "False",
					DFIntGraphicsOptimizationModeMaxFrameTimeTargetMs = "25",
					DFIntTimestepArbiterAngAccelerationThresholdThou = "2000",
					DFIntMaxReceiveToDeserializeLatencyMilliseconds = "10",
					DFIntTimestepArbiterAccelerationModelFactorThou = "50000",
					DFIntMegaReplicatorNetworkQualityProcessorUnit = "10",
					DFIntNetworkInProcessLimitGameplayMsClient = "0",
					DFIntPerformanceControlFrameTimeMaxUtility = "-1",
					DFIntClientPacketHealthyAllocationPercent = "20",
					DFIntInitialAccelerationLatencyMultTenths = "1",
					DFIntTimeBetweenSendConnectionAttemptsMS = "200",
					DFIntNetworkQualityResponderMaxWaitTime = "1",
					DFIntMaxProcessPacketsStepsAccumulated = "0",
					DFIntClientPacketMaxFrameMicroseconds = "200",
					DFIntMaxProcessPacketsStepsPerCyclic = "5000",
					DFIntClientPacketExcessMicroseconds = "1000",
					DFIntPerformanceControlFrameTimeMax = "1",
					DFIntWaitOnUpdateNetworkLoopEndedMS = "100",
					DFIntNetworkSchemaCompressionRatio = "100",
					DFIntBatchThumbnailResultsSizeCap = "200",
					DFIntLargePacketQueueSizeCutoffMB = "1000",
					DFIntMaxProcessPacketsJobScaling = "10000",
					DFIntNetworkQualityResponderUnit = "10",
					DFIntBufferCompressionThreshold = "100",
					DFIntWaitOnRecvFromLoopEndedMS = "10",
					DFIntMaxAcceptableUpdateDelay = "1",
					DFIntCodecMaxIncomingPackets = "50",
					DFIntConnectingTimerInterval = "10",
					DFIntBufferCompressionLevel = "0",
					DFIntClientPacketMaxDelayMs = "1",
					DFIntCodecMaxOutgoingFrames = "10000",
					DFIntMaxDataPacketPerSend = "2147483647",
					DFIntS2PhysicsSenderRate = "25000",
					DFIntMaxFrameBufferSize = "4",
					DFIntRuntimeConcurrency = "12",
					DFIntDataSenderRate = "20000",
					FIntSmoothMouseSpringFrequencyTenths = "100",
					FIntRakNetResendBufferArrayLength = "256",
					FIntInterpolationMaxDelayMSec = "100",
					FIntRuntimeMaxNumOfConditions = "1000000",
					FIntRuntimeMaxNumOfSchedulers = "1000000",
					FIntRuntimeMaxNumOfSemaphores = "1000000",
					FIntSimSolverResponsiveness = "2147483647",
					FIntRuntimeMaxNumOfLatches = "1000000",
					FIntRuntimeMaxNumOfMutexes = "1000000",
					FIntRuntimeMaxNumOfThreads = "1000000",
					FIntRuntimeMaxNumOfDPCs = "64",
				},
				["Stutter Ball"] = {
					DFIntPerformanceControlFrameTimeMaxUtility = "-1",
					FFlagEnableBubbleChatFromChatService = "False",
					DFFlagSimOptimizeSetSize = "True",
					DFIntRaknetBandwidthPingSendEveryXSeconds = "-1",
					FIntDebugFRMOptionalMSAALevelOverride = "0",
					DFIntMinimumNumberMechanismsForMT = "1",
					FFlagDebugDisableTelemetryV2Counter = "True",
					FIntRefreshRateLowerBound = "360",
					DFIntClientPacketExcessMicroseconds = "1",
					FFlagEnablePreferredTextSizeScale = "True",
					FFlagLuaMenuPerfImprovements = "True",
					FFlagRenderShadowSkipHugeCulling = "True",
					DFFlagEnableTexturePreloading = "True",
					FFlagEnableChromePinnedChat = "True",
					FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo = "False",
					FFlagSelfViewAvoidErrorOnWrongFaceControlsParenting = "False",
					FIntRenderMaxShadowAtlasUsageBeforeDownscale = "0",
					DFIntAssetPreloading = "9999999",
					FFlagEnableBetterHapticsResultHandling = "True",
					DFIntWriteFullDmpPercent = "0",
					DFFlagEnablePerfDataMemoryCategoriesCollection2 = "False",
					FFlagDebugDisplayFPS = "True",
					DFIntRakNetMtuValue2InBytes = "1337",
					FFlagRemovedRbxRenderingPreProcessor = "False",
					FFlagViewCollisionFadeToBlackInVR = "False",
					FFlagDebugDisableTelemetryEphemeralStat = "True",
					DFFlagESGamePerfMonitorEnabled = "False",
					FFlagUserSoundsUseRelativeVelocity2 = "True",
					DFFlagAudioEnableVolumetricPanningForPolys = "True",
					DFIntAssetPermissionsApiPatchAssetsPermissions0TelemetryHundredthsPercent = "0",
					FIntCameraMaxZoomDistance = "999999",
					FFlagDebugDisableOTAMaterialTexture = "true",
					FIntSmoothTerrainPhysicsCacheSize = "3000",
					DFFlagRenderHighlightManagerPrepare = "True",
					DFIntInterpolationDtLimitForLod = "1",
					DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2 = "False",
					DFIntParallelAdaptiveInterpolationBatchCount = "1",
					DFIntAnimationLodFacsDistanceMin = "0",
					FStringTerrainMaterialTable2022 = "",
					DFFlagOpenCloudV1CreateUserNotificationAsync = "False",
					DFFlagTeleportPreloadingMetrics5 = "True",
					DFIntClientPacketHealthyMsPerSecondLimit = "1",
					FFlagDontRerenderForBadTexture = "True",
					FFlagTaskSchedulerLimitTargetFpsTo2402 = "False",
					DFStringAltHttpPointsReporterUrl = "null",
					FFlagSelfViewTweaksPass = "False",
					FIntRakNetResendBufferArrayLength = "128",
					DFIntAMPVerifiedTelemetryHundredthsPercentage = "0",
					FIntTerrainOTAMaxTextureSize = "0",
					FFlagEnableBatteryStateLogger = "False",
					DFStringTelemetryV2Url = "null",
					FStringImmersiveAdsUniverseWhitelist = "0",
					DFFlagEnablePerfDataCountersCollection = "False",
					DFFlagSimRefactorCollisionGeometry2 = "True",
					DFIntServerTickRate = "240",
					FFlagDebugCodegenOptSize = "True",
					DFIntLargePacketQueueSizeCutoffMB = "1",
					DFIntRunningBaseOrientationP = "450",
					FFlagGraphicsGLEnableSuperHQShadersExclusion = "False",
					DFStringRobloxAnalyticsURL = "null",
					FFlagToastNotificationsReceivedAndDismissedSignals = "False",
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					FIntFriendRequestNotificationThrottle = "0",
					FFlagPreloadAllFonts = "True",
					FFlagEnableMenuControlsABTest = "False",
					FIntUITextureMaxUpdateDepth = "0",
					FFlagEnableInGameMenuChromeABTest3 = "False",
					FFlagSimEnableDCD16 = "True",
					DFFlagEnablePerfDataCoreTimersCollection2 = "False",
					DFIntAppConfigurationTelemetryThrottleHundredthsPercent = "0",
					FIntFRMMinGrassDistance = "0",
					FFlagEngineAPICloudProcessingUseNotificationClient = "False",
					FFlagEnableV3MenuABTest3 = "False",
					FFlagQuaternionPoseCorrection = "True",
					FFlagCommitToGraphicsQualityFix = "True",
					DFIntGameNetPVHeaderLinearVelocityZeroCutoffExponent = "-1",
					DFIntAssetPermissionsApiGetAssetsPermissionsTelemetryHundredthsPercent = "0",
					FFlagToastNotificationsProtocolEnabled2 = "False",
					DFIntVoiceChatRollOffMinDistance = "1",
					FFlagEnablePreferredTextSizeStyleFixesGameTile = "True",
					FFlagDisableChromeV3StaticSelfView = "False",
					FFlagUserFixLoadAnimationError = "True",
					FFlagImmersiveAdsWhitelistDisabled = "False",
					DFIntRakNetLoopMs = "0",
					FFlagWindowsReportAbuseNotification = "False",
					FIntTaskSchedulerThreadMin = "240000",
					DFLogHttpTraceLight = "0",
					FFlagRemoveRedundantFontPreloading = "True",
					DFStringRobloxAnalyticsSubDomain = "opt-out",
					FFlagFixSettingsHubVRBackgroundError = "True",
					DFIntCodecMaxIncomingPackets = "2139999999",
					DFFlagDebugRenderForceTechnologyVoxel = "True",
					DFIntTaskSchedulerTargetFps = "1000",
					DFFlagWindowsWebViewTelemetryEnabled = "False",
					FFlagBetaBadgeLearnMoreLinkFormview = "False",
					FIntV1MenuLanguageSelectionFeaturePerMillageRollout = "0",
					DFIntWaitOnUpdateNetworkLoopEndedMS = "100",
					FFlagLuaAppEnableParentalControlExperiment = "False",
					FFlagAXAdaptiveScrollingImprovementIXPEnabled = "True",
					FFlagUserShowGuiHideToggles = "True",
					FIntStartupInfluxHundredthsPercentage = "0",
					FFlagFixGraphicsQuality = "True",
					FFlagGraphicsGLEnableHQShadersExclusion = "False",
					DFFlagQueueDataPingFromSendData = "True",
					FFlagOptimizeServerTickRate = "True",
					FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio = "False",
					FFlagGraphicsCheckComputeSupport = "True",
					FFlagEnablePreferredTextSizeStyleFixesAddFriends = "True",
					FIntFullscreenTitleBarTriggerDelayMillis = "3600000",
					FFlagEnableAudioEmitterDistanceAttenuation = "True",
					DFStringLightstepHTTPTransportUrlHost = "null",
					DFIntTimestepArbiterThresholdCFLThou = "300",
					FFlagEnableAdsAPI = "False",
					DFFlagTeleportClientAssetPreloadingEnabledIXP2 = "True",
					FFlagAXSearchLandingPageIXPEnabled4 = "False",
					FFlagLoginPageOptimizedPngs = "True",
					DFIntAnimationLodFacsVisibilityDenominator = "0",
					DFFlagNotificationServiceIsConnectedProperty = "False",
					FFlagSelfieViewEnabled = "True",
					FFlagFastGPULightCulling3 = "True",
					FFlagVideoTextureSupportHardwareRender = "True",
					FFlagLuaAppGamesPagePreloadingDisabled = "False",
					DFIntVoiceChatRollOffMaxDistance = "300",
					DFIntVideoMaxNumberOfVideosPlaying = "0",
					FFlagDebugSelfViewPerfBenchmark = "False",
					DFIntDefaultTimeoutTimeMs = "10000",
					FFlagLuauCodegen = "True",
					DFIntNewRunningBaseAltitudeD = "195",
					FFlagUserEnableCameraToggleNotification = "False",
					DFFlagDebugOverrideDPIScale = "False",
					DFFlagUnifyLegacyJointGeometry = "True",
					FFlagDisablePostFx = "True",
					FIntVertexSmoothingGroupTolerance = "0",
					DFIntGameNetPVHeaderRotationOrientIdToleranceExponent = "-1",
					FFlagControlBetaBadgeWithGuac = "False",
					DFIntPlayerNetworkUpdateRate = "100000000",
					DFIntMaxProcessPacketsStepsAccumulated = "0",
					FFlagAnimationClipMemCacheEnabled = "True",
					FIntReportDeviceInfoRollout = "0",
					FFlagInterpolationAwareTargetTime = "True",
					DFIntWindowsWebViewTelemetryThrottleHundredthsPercent = "0",
					FFlagAXAdaptiveScrollingItemResetFix2 = "True",
					DFIntMegaReplicatorNetworkQualityProcessorUnit = "-1",
					FLogNetwork = "7",
					DFFlagEnablePerfDataGatherTelemetry2 = "False",
					FFlagFixSensitivityTextPrecision = "False",
					FFlagMovePrerenderV2 = "True",
					DFIntMaxReceiveToDeserializeLatencyMilliseconds = "1",
					FFlagFixChunkLightingUpdate2 = "True",
					FStringGraphicsDisableUnalignedDxtGPUNameBlacklist = "null",
					FFlagPreOptimizeNoCollisionPrimitive = "True",
					DFFlagEnableFmodErrorsTelemetry = "False",
					FFlagRenderDynamicResolutionScale9 = "True",
					FFlagEnableChildrenLockFromLua = "False",
					FFlagSettingsHubIndependentBackgroundVisibility = "True",
					DFFlagTextureQualityOverrideEnabled = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
					FFlagTopBarUseNewBadge = "False",
					FFlagShaderLightingRefactor = "True",
					FIntRuntimeMaxNumOfThreads = "20000",
					DFFlagEnablePerfDataCoreCategoryTimersCollection2 = "False",
					FFlagEnableChildrenLockFromLua2 = "False",
					DFFlagAudioUseVolumetricPanning = "True",
					DFFlagEnablePerfDataMemoryCollection = "False",
					DFIntNumAssetsMaxToPreload = "9999999",
					FFlagDebugEnableVRFTUXExperienceInStudio = "True",
					DFIntDebugAdditionalNumberOfMipsToSkipForNonAlbedoTextures = "10",
					FFlagDebugDisableTelemetryV2Stat = "True",
					DFFlagAudioToggleVolumetricPanning = "True",
					DFFlagTeleportClientAssetPreloadingDoingExperiment2 = "True",
					FFlagEnablePreferredTextSizeSettingInMenus2 = "True",
					FFlagHandleAltEnterFullscreenManually = "False",
					FIntRakNetDatagramMessageIdArrayLength = "8192",
					FIntRenderGrassDetailStrands = "0",
					FFlagFixCountOfUnreadNotificationError = "False",
					DFStringCrashUploadToBacktraceMacPlayerToken = "null",
					FFlagEnablePreferredTextSizeStyleFixesInPlayerList = "True",
					FStringVoiceBetaBadgeLearnMoreLink = "null",
					FFlagFixOutdatedTimeScaleParticles = "False",
					DFIntNumFramesAllowedToBeAboveError = "0",
					FIntTargetRefreshRate = "480",
					FFlagNotificationPluginSignalRReadEvents = "False",
					FFlagPreloadMinimalFonts = "True",
					DFFlagEnablePerfDataMemoryPressureCollection = "False",
					DFFlagEnableExperienceNotificationOptInPrompt = "False",
					FIntMockClientLightingTechnologyIxpExperimentQualityLevel = "1",
					FIntTextureCompositorLowResFactor = "4",
					FFlagEnablePreferredTextSizeStyleFixesInCaptureMenu = "True",
					FIntBloomFrmCutoff = "-1",
					FFlagEnableVRFTUXExperienceV2 = "True",
					DFFlagDebugPauseVoxelizer = "True",
					FFlagVRFixCursorJitterLua = "True",
					FFlagDebugDisableTelemetryEventIngest = "True",
					FFlagFixReducedMotionStuckIGM2 = "True",
					FFlagShoeSkipRenderMesh = "False",
					FFlagMockOpenSelfViewForCameraUser = "False",
					DFFlagDebugAnalyticsSendUserId = "False",
					FFlagEnableChromeFTUX = "True",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage2 = "100000",
					FIntRenderShadowIntensity = "0",
					FFlagNotificationButtonTypeVariantMappingEmphasis = "False",
					FFlagRenderLegacyShadowsQualityRefactor = "True",
					FIntStudioExternalNotificationImplMessageWriteTimeOut = "0",
					FIntRenderLocalLightUpdatesMax = "0",
					FFlagVisBugChecksThreadYield = "True",
					FFlagRenderInitShadowmaps = "false",
					DFFlagVoiceChatTurnOnMuteUnmuteNotificationHack = "False",
					DFIntRakNetMtuValue1InBytes = "1396",
					FFlagDontCreatePingJob = "True",
					DFIntAnimationLodFacsDistanceMax = "0",
					FFlagFRMRefactor = "True",
					DFStringWebviewUrlAllowlist = "",
					FFlagOptimizeNetworkTransport = "True",
					DFIntAnimatorThrottleMaxFramesToSkip = "1",
					FFlagEnablePreferredTextSizeStyleFixesInAppShell3 = "True",
					FFlagUseNotificationServiceIsConnected = "False",
					DFFlagTeleportClientAssetPreloadingDoingExperiment = "True",
					DFIntNetworkPrediction = "240",
					DFIntGameNetPVHeaderRotationalVelocityZeroCutoffExponent = "-1",
					DFIntOptimizePingThreshold = "20",
					DFStringCrashUploadToBacktraceWindowsPlayerToken = "null",
					FFlagLuaAppGenreUnderConstruction = "False",
					FFlagAdaptiveScrollingFrameOnServer = "True",
					DFFlagEphemeralCounterInfluxReportingEnabled = "False",
					FFlagRenderCBRefactor2 = "True",
					FStringDebugGraphicsPreferredGPUName = "Radeon Pro Vega 56",
					FFlagGuiHidingApiSupport2 = "True",
					FIntBootstrapperTelemetryReportingHundredthsPercentage = "0",
					DFIntDebugDefaultTargetWorldStepsPerFrame = "7500",
					FFlagAdServiceEnabled = "False",
					DFIntClientPacketUnhealthyContEscMsPerSecond = "1",
					FFlagRenderDebugCheckThreading2 = "True",
					FIntRenderGrassHeightScaler = "0",
					FIntPreferredTextSizeSettingBetaFeatureRolloutPercent = "100",
					FFlagSignalRNotificationManagerMaybeStart = "False",
					FFlagDebugDisableTelemetryV2Event = "True",
					DFFlagAssetPreloadingUrlVersionEnabled2 = "True",
					FFlagEnableCapturesHotkeyExperiment_v4 = "False",
					DFIntTextureQualityOverride = "0",
					DFIntClientLightingEnvmapPlacementTelemetryHundredthsPercent = "0",
					FFlagDebugCheckRenderThreading = "True",
					DFIntRakNetPingFrequencyMillisecond = "10",
					FFlagFixParticleAttachmentCulling = "False",
					FFlagEnablePreferredTextSizeScalePerLayerCollector = "True",
					DFIntNetworkLatencyTolerance = "-1",
					FIntTaskSchedulerMaxNumOfJobs = "2139999999",
					FFlagGlobalWindRendering = "false",
					FFlagDisableNewIGMinDUA = "True",
					DFFlagGpuVsCpuBoundTelemetry = "False",
					FFlagCoreGuiSelfViewVisibilityFixed = "False",
					FFlagLuaAppEnableToastNotificationsCoreScripts4 = "False",
					FFlagSelfViewLookUpHumanoidByType = "False",
					DFIntVoiceChatMaxRecordedDataDeliveryIntervalMs = "2147483647",
					FFlagVRBackpackImproved = "True",
					DFFlagUseVisBugChecks = "True",
					DFIntMaxProcessPacketsStepsPerCyclic = "2139999999",
					DFIntRakNetSelectUnblockSocketWriteDurationMs = "10",
					FFlagNewLightAttenuation = "True",
					FStringPartTexturePackTablePre2022 = "{\"foil\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://13576561565\"],\"color\":[0,0,0,0]},\"asphalt\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://13576561565\"],\"color\":[0,0,0,0]},\"basalt\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://13576561565\"],\"color\":[0,0,0,0]},\"brick\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"cobblestone\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"concrete\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"crackedlava\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"diamondplate\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"fabric\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"glacier\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"glass\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"granite\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"grass\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"ground\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"ice\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"leafygrass\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"limestone\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"marble\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"metal\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"mud\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"pavement\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"pebble\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"plastic\":{\"ids\":[\"\",\"rbxassetid://13576561565\"],\"color\":[0,0,0,0]},\"rock\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"corrodedmetal\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9439557520\"],\"color\":[0,0,0,0]},\"salt\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"sand\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"sandstone\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"slate\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9439613006\"],\"color\":[0,0,0,0]},\"snow\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]},\"wood\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9439649548\"],\"color\":[0,0,0,0]},\"woodplanks\":{\"ids\":[\"rbxassetid://13576561565\",\"rbxassetid://9438453972\"],\"color\":[0,0,0,0]}}",
					DFIntGameNetPVHeaderTranslationZeroCutoffExponent = "-1",
					FFlagPreloadTextureItemsOption4 = "True",
					FFlagLuaAppsEnableParentalControlsTab = "False",
					FFlagPushFrameTimeToHarmony = "True",
					FIntRenderLocalLightUpdatesMin = "0",
					DFIntWaitOnRecvFromLoopEndedMS = "0",
					FIntRobloxGuiBlurIntensity = "0",
					DFIntMaxFrameBufferSize = "-1",
					DFFlagAdsPreloadInteractivityAssets = "True",
					DFIntClientPacketMaxDelayMs = "1",
					DFFlagBaseNetworkMetrics = "False",
					FIntFixForBulkPresenceNotifications = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					DFIntAccelerationTimeThreshold = "0",
					DFIntClientPacketMaxFrameMicroseconds = "1",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage = "100000",
					FFlagPreferredTextSizeSettingBetaFeature = "True",
					FFlagChatTranslationEnableSystemMessage = "False",
					DFIntMacWebViewTelemetryThrottleHundredthsPercent = "0",
					FFlagSelfViewFixes = "False",
					DFIntRakNetMinAckGrowthPercent = "100",
					FFlagVRLaserPointerOptimization = "True",
					FFlagRenderLightGridEfficientTextureAtlasUpdate = "True",
					DFIntPlayerNetworkUpdateQueueSize = "60",
					DFIntInterpolationNumMechanismsPerTask = "100",
					FFlagNotificationsNoLongerRequireControllerState = "False",
					DFFlagEnablePerfRenderStatsCollection2 = "False",
					FIntInterpolationAwareTargetTimeLerpHundredth = "250",
					DFIntHttpParallelLimit_RequestExperienceNotificationService = "0",
					FFlagLuaAppSystemBar = "False",
					FFlagAudioDeviceTelemetry = "false",
					FFlagEnableVisBugChecks27 = "True",
					FIntDebugForceMSAASamples = "1",
					FIntEnableVisBugChecksHundredthPercent27 = "0",
					FFlagSelfViewCameraDefaultButtonInViewPort = "False",
					DFFlagTeleportClientAssetPreloadingEnabled9 = "True",
					DFIntDetectCrashEarlyPercentage = "0",
					DFIntDebugFRMQualityLevelOverride = "1",
					FFlagHighlightOutlinesOnMobile = "True",
					DFFlagBrowserTrackerIdTelemetryEnabled = "False",
					FFlagFixParticleEmissionBias2 = "False",
					FIntFRMMaxGrassDistance = "0",
					DFStringAltTelegrafAddress = "127.0.0.1",
					FFlagUISUseLastFrameTimeInUpdateInputSignal = "True",
					FIntVRTouchControllerTransparency = "0",
					DFFlagPhysicsMechanismCacheOptimizeAlloc = "True",
					FFlagDebugSSAOForce = "False",
					FFlagDebugRenderingSetDeterministic = "True",
					DFIntConnectionMTUSize = "576",
					DFIntMicroProfilerDpiScaleOverride = "90",
					FFlagContentProviderPreloadHangTelemetry = "False",
					FFlagEnableInGameMenuControls = "True",
					FStringTerrainMaterialTablePre2022 = "",
					FIntStudioWebView2TelemetryHundredthsPercent = "0",
					FFlagEnablePreferredTextSizeStyleFixesInReportMenu = "True",
					DFFlagOptimizeClusterCacheAlloc = "True",
					DFIntContentProviderPreloadHangTelemetryHundredthsPercentage = "0",
					FFlagDebugDeterministicParticles = "False",
					FFlagDebugEnableDirectAudioOcclusion2 = "True",
					FFlagSelfViewHumanoidNilCheck = "False",
					FIntGrassMovementReducedMotionFactor = "0",
					DFFlagCrashUploadFullDumps = "False",
					DFIntAMPVerifiedTelemetryPointsHundredthsPercentage = "0",
					FIntAXAdaptiveScrollingJustSelectedMillis = "2000",
					DFFlagHttpCacheCleanBasedOnMemory = "True",
					FFlagDebugDisableTelemetryEphemeralCounter = "True",
					FIntSelfViewTooltipLifetime = "0",
					DFIntVoiceChatRollOffMode = "2",
					FIntMockClientLightingTechnologyIxpExperimentMode = "0",
					FStringPerformanceSendMeasurementAPISubdomain = "opt-out",
					FFlagDebugSkyGray = "True",
					FFlagFixEmotesMenuVR = "True",
					DFIntClientPacketHealthyAllocationPercent = "100",
					FFlagEnableRemoveIsFromToastNotification = "False",
					DFIntTargetTimeDelayFacctorTenths = "1",
					FFlagRenderNoLowFrmBloom = "False",
					FFlagAvatarChatIncludeSelfViewOnTelemetry = "False",
					DFFlagEnableMeshPreloading2 = "True",
					FFlagSyncWebViewCookieToEngine2 = "False",
					FFlagUpdateHTTPCookieStorageFromWKWebView = "False",
					FFlagEnablePreferredTextSizeStyleFixesInExperienceMenu = "True",
					FFlagAXAdaptiveScrollingAvatarEditor2 = "True",
					DFIntCanHideGuiGroupId = "32380007",
					FFlagAssetPreloadingIXP = "True",
					FFlagAXPortraitSplitAdaptiveScrollingFix2 = "True",
					FFlagToastNotificationsResendDisplayOnInit = "False",
					FIntMaquettesFrameRateBufferPercentage = "1",
					FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio = "False",
					DFFlagEnablePerfAudioCollection = "False",
					DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage = "0",
					FIntRenderShadowmapBias = "-1",
					DFIntActionStationDebounceTime = "0",
					DFIntServerPhysicsUpdateRate = "240",
					DFIntCullFactorPixelThresholdShadowMapLowQuality = "2147483647",
					FFlagRenderSkipReadingShaderData = "False",
					DFFlagEnablePerfDataSubsystemTimersCollection2 = "False",
					FFlagOptimizeNetwork = "True",
					FFlagEnableAudioPannerFiltering = "True",
					FIntTerrainArraySliceSize = "0",
					FIntRuntimeMaxNumOfConditions = "5000",
					FFlagClientToastNotificationsEnabled = "False",
					FIntRuntimeMaxNumOfLatches = "20000",
					FFlagOptimizeNetworkRouting = "True",
					FFlagCSGDecalOptimizeVB = "True",
					FIntSSAOMipLevels = "0",
					DFIntClientPacketMinMicroseconds = "1",
					FFlagDebugStudioForceSystemDeprecationNotification = "False",
					DFIntAssetPermissionsApiGetOperationsTelemetryHundredthsPercent = "0",
					FFlagImproveShiftLockTransition = "True",
					DFFlagOptimizeNoCollisionPrimitiveInMidphaseCrash = "True",
					FIntRenderLocalLightFadeInMs = "0",
					FIntNumFramesToCaptureCallStack = "1",
					DFIntTouchSenderMaxBandwidthBps = "-1",
					FFlagDeveloperToastNotificationsEnabled = "False",
					FFlagDebugGraphics = "False",
					FFlagReportFpsAndGfxQualityPercentiles = "False",
					DFIntPerformanceControlFrameTimeMax = "1",
					FFlagFixIGMTabTransitions = "True",
					FStringInExperienceNotificationsLayer = "",
					DFFlagSimSolverOptimizeGeometricStiffness4 = "True",
					FFlagCloudsReflectOnWater = "False",
					FFlagRenderGpuTextureCompressor = "True",
					FFlagEnablePreferredTextSizeGuiService = "True",
					FFlagNewOptimizeNoCollisionPrimitiveInMidphase637 = "True",
					FFlagMigrateTextureManagerIsLocalAsset = "True",
					DFFlagAudioEnableVolumetricPanningForMeshes = "True",
					FFlagSelfViewGetRidOfFalselyRenderedFaceDecal = "False",
					DFIntCodecMaxOutgoingFrames = "2139999999",
					FFlagEnableIOSWebViewCookieSyncFix = "False",
					FFlagSquadToastNotificationsEnabled = "False",
					FFlagGraphicsTextureCopy = "True",
					FIntAbuseReportScreenshotMaxSize = "0",
					DFIntMinimalNetworkPrediction = "1",
					FFlagMSRefactor5 = "False",
					FFlagAXFixAdaptiveScrollingSnapAndroid = "True",
					DFStringLightstepToken = "null",
					FIntMeshContentProviderForceCacheSize = "268435456",
					DFIntMaxProcessPacketsJobScaling = "2139999999",
					DFFlagDebugSkipMeshVoxelizer = "True",
					FIntStudioResendDisconnectNotificationInterval = "0",
					DFFlagDebugPerfMode = "True",
					FIntTaskSchedulerAutoThreadLimit = "16",
					FIntDebugTextureManagerSkipMips = "10",
					DFIntHACDPointSampleDistApartTenths = "2147483647",
					DFIntRuntimeConcurrency = "2139999999",
					FFlagEnableCommandAutocomplete = "False",
					DFIntCullFactorPixelThresholdShadowMapHighQuality = "2147483647",
					FFlagDebugForceFSMCPULightCulling = "True",
					FIntUnifiedLightingBlendZone = "0",
					DFIntRuntimeTickrate = "2139999999",
					FFlagRenderPerformanceTelemetry = "False",
					DFFlagTeleportClientAssetPreloadingEnabledIXP = "True",
					FIntDirectionalAttenuationMaxPoints = "1",
					FFlagRenderOptimizeDecalTransparencyInvalidation = "True",
					FFlagUseNotificationsLocalization = "False",
					FFlagInExperienceUpsellSelfViewFix = "False",
					FFlagVRMouseMoveOptimization = "True",
					FFlagSelfViewRemoveVPFWhenClosed = "False",
					FFlagEnableInGameMenuModernization = "True",
					FFlagStudioDataCollectionAddBasicNotification = "False",
					DFIntMaxFramesToSend = "1",
					FIntRuntimeMaxNumOfMutexes = "20000",
					DFIntRakNetMtuValue3InBytes = "1250",
					FIntBootstrapperWebView2InstallationTelemetryHundredthPercent = "0",
					DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent = "0",
					FFlagDebugDisableTelemetryPoint = "True",
					FFlagFixExitDialogBlockVRView = "True",
					DFFlagEnableGCapsHardwareTelemetry = "False",
					DFLogHttpTrace = "0",
					DFFlagOptimizeIsA = "True",
					DFFlagGraphicsOptimizationModeMVPExposureEnrollment3 = "False",
					DFFlagEnablePerfStatsCollection3 = "False",
					DFIntDebugRestrictGCDistance = "1",
					FFlagSelfViewUpdatedCamFraming = "False",
					FFlagRenderFixFog = "True",
					FFlagVoiceBetaBadge = "False",
					FFlagEnablePreferredTextSizeConnection = "True",
					FFlagAXAdaptiveScrollingSnapItemEditor = "True",
					FFlagFixSelfViewPopin = "False",
					DFIntDebugLimitMinTextureResolutionWhenSkipMips = "0",
					FFlagEnableExperienceNotificationPrompts2 = "False",
					DFFlagEngineAPISendNotificationClientAnalytics = "False",
					DFFlagAddUserIdToSessionTracking = "False",
					FFlagEnableInGameMenuChrome = "True",
					FFlagFixIGMBottomBarVisibility = "True",
					FFlagEnablePreferredTextSizeStyleFixesInPurchasePrompt = "True",
					DFIntAssetPermissionsApiPostAssetsCheckPermissionsTelemetryHundredthsPercent = "0",
					DFFlagEnableSoundPreloading = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					FFlagDebugForceGenerateHSR = "True",
					FIntRuntimeMaxNumOfSchedulers = "20000",
					FFlagDisableFeedbackSoothsayerCheck = "False",
					FStringGamesUrlPath = "/games/",
					DFIntLightstepHTTPTransportHundredthsPercent2 = "0",
					FFlagSelfViewMoreNilChecks = "False",
					DFIntRakNetResendRttMultiple = "1",
					FFlagToastNotificationsUpdateEventParams = "False",
					FFlagUserHideCharacterParticlesInFirstPerson = "True",
					FFlagLocServicePerformanceAnalyticsEnabled = "False",
					FFlagDebugGraphicsPreferD3D11 = "True",
					FIntActivatedCountTimerMSKeyboard = "0",
					FFlagMouseGetPartOptimization = "True",
					FIntSimSolverResponsiveness = "2147483647",
					FFlagSortKeyOptimization = "True",
					FFlagFasterPreciseTime4 = "True",
					DFFlagMouseMoveOncePerFrame = "False",
					FIntActivatedCountTimerMSMouse = "0",
					FIntSmoothMouseSpringFrequencyTenths = "100",
					FFlagEnablePerformanceControlService = "True",
					FIntCLI20390 = "0",
					FIntCLI20390_2 = "0",
					DFIntPerformanceControlTextureQualityBestUtility = "-1",
				},
				["No Textures"] = {
					DFIntAnimationLodFacsVisibilityDenominator = "0",
					FIntBootstrapperWebView2InstallationTelemetryHundredthPercent = "0",
					DFFlagSimOptimizeSetSize = "True",
					FFlagRenderEnableGlobalInstancingD3D11 = "False",
					FFlagFixChunkLightingUpdate2 = "True",
					FFlagControlBetaBadgeWithGuac = "False",
					FFlagSelfieViewEnabled = "True",
					DFFlagUseVisBugChecks = "True",
					FIntFullscreenTitleBarTriggerDelayMillis = "3600000",
					FFlagFixReducedMotionStuckIGM2 = "True",
					DFIntWindowsWebViewTelemetryThrottleHundredthsPercent = "0",
					FFlagEnablePreferredTextSizeStyleFixesInExperienceMenu = "True",
					FFlagDebugCodegenOptSize = "True",
					FIntRenderGrassDetailStrands = "0",
					FFlagMockOpenSelfViewForCameraUser = "False",
					FFlagGraphicsTextureCopy = "True",
					DFIntTextureQualityOverride = "0",
					FIntFriendRequestNotificationThrottle = "0",
					FFlagUserSoundsUseRelativeVelocity2 = "True",
					FIntUITextureMaxUpdateDepth = "-1",
					FFlagUseNotificationsLocalization = "False",
					FFlagLuauCodegen = "True",
					FFlagEnableChildrenLockFromLua = "False",
					DFIntRakNetMtuValue1InBytes = "1396",
					FFlagCSGDecalOptimizeVB = "True",
					FFlagSelfViewFixes = "False",
					DFIntDebugRestrictGCDistance = "1",
					FIntUnifiedLightingBlendZone = "1",
					DFIntMicroProfilerDpiScaleOverride = "100",
					FFlagSelfViewMoreNilChecks = "False",
					FFlagDebugSelfViewPerfBenchmark = "False",
					FFlagEnableChildrenLockFromLua2 = "False",
					FFlagDebugForceFSMCPULightCulling = "True",
					DFFlagTeleportClientAssetPreloadingEnabledIXP2 = "True",
					FFlagSyncWebViewCookieToEngine2 = "False",
					DFFlagTeleportClientAssetPreloadingEnabledIXP = "True",
					FFlagLuaAppsEnableParentalControlsTab = "False",
					FFlagRenderCBRefactor2 = "True",
					FStringTerrainMaterialTablePre2022 = "",
					FFlagDebugDisableTelemetryV2Counter = "True",
					FFlagChatTranslationEnableSystemMessage = "False",
					FFlagGraphicsGLEnableSuperHQShadersExclusion = "False",
					FFlagEnableInGameMenuChromeABTest4 = "True",
					FFlagPreloadMinimalFonts = "True",
					FFlagEnablePreferredTextSizeScalePerLayerCollector = "True",
					FFlagDisableChromeV3StaticSelfView = "False",
					FFlagAXSearchLandingPageIXPEnabled4 = "False",
					FFlagUserEnableCameraToggleNotification = "False",
					DFFlagAssetPreloadingUrlVersionEnabled2 = "True",
					FFlagDebugForceGenerateHSR = "True",
					DFFlagEnableTexturePreloading = "True",
					FFlagContentProviderPreloadHangTelemetry = "False",
					DFFlagTeleportClientAssetPreloadingDoingExperiment = "True",
					FFlagFixIGMTabTransitions = "True",
					DFFlagEnableExperienceNotificationOptInPrompt = "False",
					DFIntConnectionMTUSize = "1396",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage2 = "100000",
					FFlagQuaternionPoseCorrection = "True",
					FStringVoiceBetaBadgeLearnMoreLink = "null",
					FFlagRemoveRedundantFontPreloading = "True",
					FFlagEnablePreferredTextSizeConnection = "True",
					FFlagFixEmotesMenuVR = "True",
					FFlagEnablePreferredTextSizeStyleFixesInAppShell4 = "True",
					FFlagDebugDisableTelemetryPoint = "True",
					FFlagDebugSkyGray = "True",
					FIntDebugFRMOptionalMSAALevelOverride = "0",
					FFlagDebugGraphicsPreferD3D11 = "False",
					FFlagFixOutdatedTimeScaleParticles = "False",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					FFlagDisablePostFx = "True",
					DFFlagDebugRenderForceTechnologyVoxel = "True",
					FIntRobloxGuiBlurIntensity = "0",
					DFIntRakNetMtuValue3InBytes = "1100",
					DFFlagVoiceChatTurnOnMuteUnmuteNotificationHack = "False",
					FIntVRTouchControllerTransparency = "0",
					FFlagDebugSSAOForce = "False",
					DFFlagAdsPreloadInteractivityAssets = "True",
					FFlagRenderShadowSkipHugeCulling = "True",
					FFlagEnableCommandAutocomplete = "False",
					DFIntPerformanceControlTextureQualityBestUtility = "-1",
					FFlagLuaAppEnableToastNotificationsCoreScripts4 = "False",
					DFStringAltTelegrafAddress = "127.0.0.1",
					FIntRenderShadowmapBias = "-1",
					FFlagRemovedRbxRenderingPreProcessor = "False",
					DFIntCullFactorPixelThresholdShadowMapHighQuality = "2147483647",
					DFStringRobloxAnalyticsURL = "http://127.0.0.1:443/",
					FFlagTaskSchedulerLimitTargetFpsTo2402 = "False",
					DFStringWebviewUrlAllowlist = "",
					FFlagDebugRenderingSetDeterministic = "True",
					FFlagRenderLightGridEfficientTextureAtlasUpdate = "True",
					FFlagSelfViewRemoveVPFWhenClosed = "False",
					FFlagHandleAltEnterFullscreenManually = "False",
					DFFlagDebugPauseVoxelizer = "True",
					FIntFRMMinGrassDistance = "0",
					DFIntAnimationLodFacsDistanceMin = "0",
					FFlagVRMouseMoveOptimization = "True",
					FFlagPreOptimizeNoCollisionPrimitive = "True",
					FFlagEnableAudioPannerFiltering = "True",
					DFIntContentProviderPreloadHangTelemetryHundredthsPercentage = "0",
					DFFlagEnableSoundPreloading = "True",
					FFlagClientToastNotificationsEnabled = "False",
					FFlagEnablePreferredTextSizeStyleFixesInAppShell3 = "True",
					FFlagLuaAppGenreUnderConstruction = "False",
					FIntEnableVisBugChecksHundredthPercent27 = "100",
					FFlagRenderFixFog = "True",
					DFFlagEnableMeshPreloading2 = "True",
					FLogNetwork = "7",
					FFlagNotificationButtonTypeVariantMappingEmphasis = "False",
					FFlagLoginPageOptimizedPngs = "True",
					FFlagSelfViewCameraDefaultButtonInViewPort = "False",
					DFIntHACDPointSampleDistApartTenths = "2147483647",
					FFlagShaderLightingRefactor = "True",
					FFlagEnableBubbleChatFromChatService = "False",
					FIntTerrainArraySliceSize = "0",
					FIntPreferredTextSizeSettingBetaFeatureRolloutPercent = "100",
					FFlagRenderDebugCheckThreading2 = "True",
					FFlagDebugEnableVRFTUXExperienceInStudio = "True",
					DFFlagTeleportClientAssetPreloadingDoingExperiment2 = "True",
					FFlagUserFixLoadAnimationError = "True",
					FFlagNewLightAttenuation = "True",
					FFlagDebugDisableTelemetryV2Stat = "True",
					FStringTerrainMaterialTable2022 = "",
					FIntFRMMaxGrassDistance = "0",
					FFlagEnableRemoveIsFromToastNotification = "False",
					DFIntDefaultTimeoutTimeMs = "10000",
					FFlagEnablePreferredTextSizeGuiService = "True",
					FFlagRenderNoLowFrmBloom = "False",
					FFlagBetaBadgeLearnMoreLinkFormview = "False",
					FStringGraphicsDisableUnalignedDxtGPUNameBlacklist = "null",
					FIntDebugForceMSAASamples = "0",
					FFlagDebugGraphicsPreferD3D11FL10 = "True",
					FFlagVRLaserPointerOptimization = "True",
					FFlagEnablePreferredTextSizeStyleFixesAddFriends = "True",
					FFlagNotificationPluginSignalRReadEvents = "False",
					FIntTextureCompositorLowResFactor = "4",
					FFlagSelfViewAvoidErrorOnWrongFaceControlsParenting = "False",
					FFlagFixIGMBottomBarVisibility = "True",
					DFStringTelemetryV2Url = "http://127.0.0.1:443",
					FIntRomarkStartWithGraphicQualityLevel = "1",
					FFlagEnableIOSWebViewCookieSyncFix = "False",
					DFFlagOptimizeIsA = "True",
					FFlagEnableVisBugChecks27 = "True",
					DFIntVideoMaxNumberOfVideosPlaying = "0",
					FFlagRenderSkipReadingShaderData = "False",
					FIntSSAOMipLevels = "1",
					FFlagAXAdaptiveScrollingAvatarEditor2 = "True",
					FFlagDebugDeterministicParticles = "False",
					FFlagSelfViewHumanoidNilCheck = "False",
					FFlagEnablePreferredTextSizeStyleFixesInPurchasePrompt = "True",
					FFlagPreloadAllFonts = "True",
					FFlagVideoTextureSupportHardwareRender2 = "True",
					FFlagSelfViewUpdatedCamFraming = "False",
					FFlagAXPortraitSplitAdaptiveScrollingFix2 = "True",
					FFlagFixExitDialogBlockVRView = "True",
					DFIntTeleportClientAssetPreloadingHundredthsPercentage = "100000",
					DFFlagAudioToggleVolumetricPanning = "True",
					FFlagUserHideCharacterParticlesInFirstPerson = "True",
					FFlagNotificationsNoLongerRequireControllerState = "False",
					FFlagPreferredTextSizeSettingBetaFeature = "True",
					DFFlagEngineAPISendNotificationClientAnalytics = "False",
					FFlagEnableCullableScene2OptimizeStep = "True",
					DFFlagAudioEnableVolumetricPanningForPolys = "True",
					FStringGetPlayerImageDefaultTimeout = "1",
					FFlagDontRerenderForBadTexture = "True",
					FFlagDebugDisableTelemetryEventIngest = "True",
					FFlagAssetPreloadingIXP = "True",
					DFFlagAudioUseVolumetricPanning = "True",
					FFlagToastNotificationsResendDisplayOnInit = "False",
					DFIntRakNetMtuValue2InBytes = "1150",
					FFlagEnablePreferredTextSizeStyleFixesGameTile = "True",
					FFlagDeveloperToastNotificationsEnabled = "False",
					FFlagAXAdaptiveScrollingImprovementIXPEnabled = "True",
					FFlagFixCountOfUnreadNotificationError = "False",
					FFlagLuaAppEnableParentalControlExperiment = "False",
					FIntRuntimeMaxNumOfThreads = "2400",
					FFlagAdaptiveScrollingFrameOnServer = "True",
					FIntRenderLocalLightUpdatesMax = "1",
					FFlagFastGPULightCulling3 = "True",
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					FFlagEnablePreferredTextSizeScale = "True",
					DFIntCullFactorPixelThresholdShadowMapLowQuality = "2147483647",
					FFlagVRBackpackImproved = "True",
					FIntRefreshRateLowerBound = "120",
					FFlagSimEnableDCD16 = "True",
					DFFlagUnifyLegacyJointGeometry = "True",
					FFlagImproveShiftLockTransition = "True",
					FIntCAP1209DataSharingRolloutPercentage = "0",
					FIntRenderLocalLightUpdatesMin = "1",
					FFlagFixParticleEmissionBias2 = "False",
					FFlagEnableExperienceNotificationPrompts2 = "False",
					FFlagRenderTestEnableDistanceCulling = "True",
					FFlagDebugDisableTelemetryEphemeralCounter = "True",
					FFlagDebugDisableTelemetryV2Event = "True",
					FIntDebugTextureManagerSkipMips = "8",
					FFlagSelfViewTweaksPass = "False",
					FIntStudioResendDisconnectNotificationInterval = "0",
					DFFlagTeleportClientAssetPreloadingEnabled9 = "True",
					FFlagToastNotificationsUpdateEventParams = "False",
					DFIntMaxFrameBufferSize = "4",
					FIntBloomFrmCutoff = "-1",
					FFlagNewOptimizeNoCollisionPrimitiveInMidphase637 = "True",
					FIntVertexSmoothingGroupTolerance = "1",
					FFlagUseNotificationServiceIsConnected = "False",
					FFlagSignalRNotificationManagerMaybeStart = "False",
					DFFlagDebugOverrideDPIScale = "False",
					FFlagEnablePreferredTextSizeStyleFixesInAvatarExp = "True",
					FIntStudioExternalNotificationImplMessageWriteTimeOut = "0",
					FFlagDebugEnableDirectAudioOcclusion2 = "True",
					FFlagEnablePreferredTextSizeStyleFixesInReportMenu = "True",
					FIntEnableCullableScene2HundredthPercent3 = "100",
					DFFlagOptimizeInstanceQueries = "True",
					FFlagFixSettingsHubVRBackgroundError = "True",
					FFlagRenderEnableGlobalInstancingD3D10 = "True",
					FIntTaskSchedulerThreadMin = "3",
					FIntStudioWebView2TelemetryHundredthsPercent = "0",
					FFlagUserShowGuiHideToggles = "True",
					FFlagAXFixAdaptiveScrollingSnapAndroid = "True",
					FFlagEngineAPICloudProcessingUseNotificationClient = "False",
					FFlagEnableChromeFTUX = "True",
					FIntCAP1544DataSharingUserRolloutPercentage = "0",
					FFlagFixSensitivityTextPrecision = "False",
					FFlagMouseGetPartOptimization = "True",
					FFlagSelfViewGetRidOfFalselyRenderedFaceDecal = "False",
					FFlagLuaMenuPerfImprovements = "True",
					FFlagToastNotificationsReceivedAndDismissedSignals = "False",
					FFlagMigrateTextureManagerIsLocalAsset = "True",
					DFFlagTeleportPreloadingMetrics5 = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
					DFFlagOptimizeClusterCacheAlloc = "True",
					DFIntMacWebViewTelemetryThrottleHundredthsPercent = "0",
					FIntOcclusionCullingBetaFeatureRolloutPercent = "100",
					FFlagEnableAudioEmitterDistanceAttenuation = "True",
					FFlagTopBarUseNewBadge = "False",
					FIntFixForBulkPresenceNotifications = "0",
					FFlagAdServiceEnabled = "False",
					DFFlagDebugSkipMeshVoxelizer = "True",
					FFlagStudioDataCollectionAddBasicNotification = "False",
					FIntCameraMaxZoomDistance = "999999",
					FFlagAXAdaptiveScrollingItemResetFix2 = "True",
					FFlagFixSelfViewPopin = "False",
					FIntTerrainOTAMaxTextureSize = "4",
					FFlagEnablePreferredTextSizeStyleFixesInPlayerList = "True",
					DFIntVoiceChatMaxRecordedDataDeliveryIntervalMs = "2147483647",
					FFlagPreloadTextureItemsOption4 = "True",
					DFFlagOpenCloudV1CreateUserNotificationAsync = "False",
					DFFlagSimRefactorCollisionGeometry2 = "True",
					FFlagEnableBetterHapticsResultHandling = "True",
					DFFlagWindowsWebViewTelemetryEnabled = "False",
					DFFlagSimSkipVoxelCDECMerge = "True",
					FFlagEnableVRFTUXExperienceV2 = "True",
					DFFlagSimDcdRecompUseClosedVoxel4 = "True",
					FIntCAP1209DataSharingTOSVersion = "0",
					FIntSelfViewTooltipLifetime = "0",
					FFlagVoiceBetaBadge = "False",
					DFFlagSimSolverOptimizeGeometricStiffness4 = "True",
					DFIntDebugFRMQualityLevelOverride = "1",
					DFStringAnalyticsNS1BeaconConfig = "https://127.0.0.1:443/|g2hjxw|https://127.0.0.1:443/|g2g5dg|https://127.0.0.1:443/|148d53m",
					FFlagSettingsHubIndependentBackgroundVisibility = "True",
					FFlagWindowsReportAbuseNotification = "False",
					FIntDirectionalAttenuationMaxPoints = "1",
					FFlagGraphicsGLEnableHQShadersExclusion = "False",
					FFlagCoreGuiSelfViewVisibilityFixed = "False",
					DFIntCanHideGuiGroupId = "32380007",
					DFFlagAudioEnableVolumetricPanningForMeshes = "True",
					DFIntDebugLimitMinTextureResolutionWhenSkipMips = "0",
					FFlagCAP1209EnableDataSharingUI4 = "False",
					FFlagToastNotificationsProtocolEnabled2 = "False",
					FIntSmoothTerrainPhysicsCacheSize = "2147483647",
					FFlagPreferredTextSizeStyleFixEventDescriptionExperienceTile = "True",
					DFFlagTextureQualityOverrideEnabled = "True",
					FFlagUpdateHTTPCookieStorageFromWKWebView = "False",
					FIntTargetRefreshRate = "144",
					FFlagDebugCheckRenderThreading = "True",
					FIntRenderLocalLightFadeInMs = "0",
					FFlagVRFixCursorJitterLua = "True",
					FFlagInExperienceUpsellSelfViewFix = "False",
					DFStringTelegrafAddress = "127.0.0.1",
					FFlagDisableFeedbackSoothsayerCheck = "False",
					DFFlagOptimizeNoCollisionPrimitiveInMidphaseCrash = "True",
					DFIntHttpParallelLimit_RequestExperienceNotificationService = "0",
					DFFlagEnablePerfRenderStatsCollection2 = "false",
					FIntAXAdaptiveScrollingJustSelectedMillis = "2000",
					DFIntGraphicsOptimizationModeMinFrameTimeTargetMs = "25",
					FIntRenderShadowIntensity = "0",
					FFlagGraphicsEnableD3D10Compute = "True",
					FFlagAvatarChatIncludeSelfViewOnTelemetry = "False",
					FFlagFixParticleAttachmentCulling = "False",
					DFFlagPhysicsMechanismCacheOptimizeAlloc = "True",
					DFIntGraphicsOptimizationModeMaxFrameTimeTargetMs = "20",
					FFlagOcclusionCullingBetaFeature = "True",
					FFlagFRMRefactor = "False",
					FFlagRenderLegacyShadowsQualityRefactor = "True",
					FFlagDebugStudioForceSystemDeprecationNotification = "False",
					DFFlagDebugPerfMode = "True",
					FIntRenderMaxShadowAtlasUsageBeforeDownscale = "1",
					FFlagShoeSkipRenderMesh = "False",
					FFlagCAP1544UseNewDataSharingRollout = "False",
					DFFlagJointIrregularityOptimization = "True",
					DFIntTaskSchedulerTargetFps = "9999",
					FIntGrassMovementReducedMotionFactor = "0",
					FFlagVisBugChecksThreadYield = "True",
					DFIntNumAssetsMaxToPreload = "2147483647",
					DFFlagDisableDPIScale = "False",
					DFFlagNotificationServiceIsConnectedProperty = "False",
					FFlagGuiHidingApiSupport2 = "True",
					DFIntAnimationLodFacsDistanceMax = "0",
					FFlagLuaAppGamesPagePreloadingDisabled = "False",
					DFIntTimestepArbiterThresholdCFLThou = "300",
					FFlagViewCollisionFadeToBlackInVR = "False",
					FFlagEnablePreferredTextSizeSettingInMenus2 = "True",
					FFlagDebugDisableTelemetryEphemeralStat = "True",
					FFlagSelfViewLookUpHumanoidByType = "False",
					FFlagAXAdaptiveScrollingSnapItemEditor = "True",
					DFIntDebugAdditionalNumberOfMipsToSkipForNonAlbedoTextures = "0",
					FStringInExperienceNotificationsLayer = "",
					FFlagSortKeyOptimization = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					FFlagRenderOptimizeDecalTransparencyInvalidation = "True",
					DFFlagOptimizePartsInPart = "True",
					FFlagSquadToastNotificationsEnabled = "False",
					FFlagEnablePreferredTextSizeStyleFixesInCaptureMenu = "True",
				},
				["Glitch Curve"] = {
					FFlagVideoTextureSupportHardwareRender2 = "True",
					FLogNetwork = "7",
					FFlagHandleAltEnterFullscreenManually = "False",
					FIntFontSizePadding = "2",
					FFlagDisablePostFx = "True",
					FIntRenderShadowIntensity = "0",
					DFFlagTextureQualityOverrideEnabled = "True",
					FIntFullscreenTitleBarTriggerDelayMillis = "3600000",
					DFFlagDisableDPIScale = "True",
					FIntDebugForceMSAASamples = "2",
					DFIntTaskSchedulerTargetFps = "9999",
					DFFlagDebugRenderForceTechnologyVoxel = "True",
					FFlagDebugForceFutureIsBrightPhase2 = "True",
					DFIntTextureQualityOverride = "0",
					FIntTerrainArraySliceSize = "0",
					DFIntCanHideGuiGroupId = "32380007",
					FFlagDebugForceFutureIsBrightPhase3 = "True",
					FFlagOptimizeNetwork = "True",
					FFlagDebugGraphicsPreferD3D11 = "True",
					FIntRuntimeMaxNumOfSchedulers = "20000",
					FIntRakNetResendBufferArrayLength = "128",
					DFIntClientPacketUnhealthyContEscMsPerSecond = "1",
					DFIntPerformanceControlFrameTimeMax = "1",
					DFIntRuntimeTickrate = "2139999999",
					FFlagTaskSchedulerLimitTargetFpsTo2402 = "False",
					DFIntAccelerationTimeThreshold = "0",
					DFIntRakNetSelectUnblockSocketWriteDurationMs = "10",
					DFIntTargetTimeDelayFacctorTenths = "1",
					FFlagEnableInGameMenuModernization = "True",
					FIntInterpolationAwareTargetTimeLerpHundredth = "100",
					DFFlagGraphicsOptimizationModeMVPExposureEnrollment4 = "False",
					DFIntMinimalNetworkPrediction = "1",
					DFIntMaxProcessPacketsJobScaling = "2139999999",
					FFlagEnableMenuControlsABTest = "False",
					DFFlagSimOptimizeSetSize = "True",
					FIntRakNetDatagramMessageIdArrayLength = "8192",
					DFIntPlayerNetworkUpdateRate = "1",
					DFIntRuntimeConcurrency = "2139999999",
					DFIntRaknetBandwidthPingSendEveryXSeconds = "-1",
					FIntRuntimeMaxNumOfThreads = "20000",
					DFIntRaknetBandwidthInfluxHundredthsPercentageV2 = "10000",
					DFIntInterpolationNumMechanismsPerTask = "100",
					DFIntCodecMaxOutgoingFrames = "2139999999",
					DFIntParallelAdaptiveInterpolationBatchCount = "1",
					FFlagDebugDisplayFPS = "True",
					DFIntMaxFrameBufferSize = "1",
					DFIntHACDPointSampleDistApartTenths = "3000000",
					DFIntGameNetPVHeaderTranslationZeroCutoffExponent = "-1",
					DFIntServerPhysicsUpdateRate = "-1",
					FFlagOptimizeServerTickRate = "True",
					FIntMaquettesFrameRateBufferPercentage = "1",
					DFIntRakNetApplicationFeedbackInitialSpeedBPS = "2139999999",
					DFIntClientPacketHealthyAllocationPercent = "100",
					DFIntMegaReplicatorNetworkQualityProcessorUnit = "-1",
					FIntInterpolationMaxDelayMSec = "0",
					DFIntRakNetClockDriftAdjustmentPerPingMillisecond = "2139999999",
					DFIntNetworkLatencyTolerance = "-1",
					DFIntRakNetPingFrequencyMillisecond = "10",
					FFlagDebugDisableTelemetryV2Stat = "True",
					DFIntLargePacketQueueSizeCutoffMB = "1",
					FFlagEnableInGameMenuControls = "True",
					DFIntRakNetResendRttMultiple = "1",
					DFIntMinimumNumberMechanismsForMT = "1",
					FFlagContentProviderPreloadHangTelemetry = "False",
					FFlagOptimizeNetworkTransport = "True",
					DFIntMaxProcessPacketsStepsAccumulated = "0",
					FFlagDisableNewIGMinDUA = "True",
					DFIntOptimizePingThreshold = "-1",
					FFlagEnableV3MenuABTest3 = "False",
					DFIntRakNetLoopMs = "0",
					DFIntMaxProcessPacketsStepsPerCyclic = "2139999999",
					FIntTaskSchedulerMaxNumOfJobs = "2139999999",
					DFStringWebviewUrlAllowlist = "",
					DFIntClientPacketMaxDelayMs = "1",
					FFlagFixGraphicsQuality = "True",
					FFlagEnableChromePinnedChat = "True",
					DFIntClientPacketMaxFrameMicroseconds = "1",
					DFIntInterpolationDtLimitForLod = "1",
					DFIntGameNetPVHeaderRotationalVelocityZeroCutoffExponent = "-1",
					FFlagEnableInGameMenuChrome = "True",
					DFIntNetworkPrediction = "-1",
					DFIntActionStationDebounceTime = "0",
					FIntRuntimeMaxNumOfConditions = "20000",
					DFIntClientPacketHealthyMsPerSecondLimit = "1",
					DFIntCodecMaxIncomingPackets = "2139999999",
					FFlagNewLightAttenuation = "True",
					DFIntGameNetPVHeaderLinearVelocityZeroCutoffExponent = "-1",
					DFIntMaxDataOutJobScaling = "2139999999",
					FIntDebugTextureManagerSkipMips = "0",
					FFlagDebugDisableTelemetryEphemeralCounter = "True",
					FIntNumFramesToCaptureCallStack = "1",
					DFIntClientPacketMinMicroseconds = "1",
					DFIntServerTickRate = "-1",
					DFIntRakNetApplicationFeedbackMaxSpeedBPS = "2139999999",
					DFIntMaxReceiveToDeserializeLatencyMilliseconds = "1",
					DFIntGameNetPVHeaderRotationOrientIdToleranceExponent = "-1",
					DFIntRakNetApplicationFeedbackScaleUpFactorHundredthPercent = "100",
					DFFlagDebugPauseVoxelizer = "True",
					FFlagEnableInGameMenuChromeABTest3 = "False",
					DFIntRakNetMinAckGrowthPercent = "100",
					FFlagEnableCullableScene2OptimizeStep = "True",
					FFlagAdServiceEnabled = "False",
					DFIntMaxFramesToSend = "1",
					DFIntMaxAverageFrameDelayExceedFactor = "0",
					FIntRuntimeMaxNumOfLatches = "20000",
					FFlagOptimizeNetworkRouting = "True",
					DFIntNumFramesAllowedToBeAboveError = "0",
					DFIntClientPacketExcessMicroseconds = "1",
					DFFlagEnableSoundPreloading = "True",
					FIntRuntimeMaxNumOfMutexes = "20000",
					FFlagMSRefactor5 = "False",
					DFIntPlayerNetworkUpdateQueueSize = "1",
					FFlagFixParticleEmissionBias2 = "False",
					FFlagDebugDisableTelemetryEventIngest = "True",
					DFFlagOptimizeIsA = "True",
					FFlagDisableFeedbackSoothsayerCheck = "False",
					FFlagDebugForceGenerateHSR = "True",
					DFIntMacWebViewTelemetryThrottleHundredthsPercent = "0",
					FFlagDebugDisableTelemetryV2Counter = "True",
					DFFlagAudioToggleVolumetricPanning = "True",
					FFlagDebugSSAOForce = "False",
					DFIntCullFactorPixelThresholdShadowMapHighQuality = "2147483647",
					DFFlagWindowsWebViewTelemetryEnabled = "False",
					DFFlagEnableMeshPreloading2 = "True",
					DFIntWindowsWebViewTelemetryThrottleHundredthsPercent = "0",
					DFFlagAudioUseVolumetricPanning = "True",
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					DFFlagSimSolverOptimizeGeometricStiffness4 = "True",
					DFFlagTeleportClientAssetPreloadingEnabledIXP2 = "True",
					DFFlagAudioEnableVolumetricPanningForPolys = "True",
					DFFlagVisBugFixPartUpdatedLock = "True",
					DFFlagEnablePerfDataMainThread = "True",
					DFFlagUnifyLegacyJointGeometry = "True",
					FFlagEnableRuntimeThreadVisQueries = "True",
					DFFlagAssetPreloadingUrlVersionEnabled2 = "True",
					FFlagEnableAudioEmitterDistanceAttenuation = "True",
					FFlagFixOutdatedTimeScaleParticles = "False",
					DFFlagAudioEnableVolumetricPanningForMeshes = "True",
					DFIntEnableVisBugChecksHundredthPercent = "1000",
					FFlagDebugCodegenOptSize = "True",
					FFlagDebugForceFSMCPULightCulling = "True",
					FFlagControlBetaBadgeWithGuac = "False",
					FFlagEnableInGameMenuChromeABTest4 = "True",
					FFlagAlwaysShowVRToggleV3 = "False",
					DFFlagTeleportPreloadingMetrics5 = "True",
					FFlagDebugDeterministicParticles = "False",
					DFIntTrackCountryRegionAPIHundredthsPercent = "10000",
					FFlagDebugDisableTelemetryEphemeralStat = "True",
					DFFlagDebugPerfMode = "True",
					FFlagEnableVisBugChecks = "True",
					FFlagEnableRuntimeThreadVisQueries4 = "True",
					FFlagDebugDisableTelemetryV2Event = "True",
					FFlagDebugDisableTelemetryPoint = "True",
					DFFlagPhysicsMechanismCacheOptimizeAlloc = "True",
					DFFlagVisBugFixUnloadReadyMesh = "True",
					DFFlagOptimizeClusterCacheAlloc = "True",
					FFlagEnableVisBugChecks27 = "True",
					DFIntContentProviderPreloadHangTelemetryHundredthsPercentage = "0",
					DFIntAssetPreloading = "2147483647",
					DFFlagTeleportClientAssetPreloadingDoingExperiment = "True",
					DFIntAnimationLodFacsDistanceMax = "0",
					FFlagFixSensitivityTextPrecision = "False",
					DFFlagEnableTexturePreloading = "True",
					DFFlagDebugUseOcclusionQueries = "True",
					DFFlagTeleportClientAssetPreloadingEnabledIXP = "True",
					DFIntInitialAccelerationLatencyMultTenths = "1",
					FFlagDebugEnableDirectAudioOcclusion2 = "True",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
					FFlagDebugSkyGray = "True",
					FFlagChatTranslationEnableSystemMessage = "False",
					FFlagEnableIOSWebViewCookieSyncFix = "False",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					FFlagDebugCheckRenderThreading = "True",
					FFlagFixParticleAttachmentCulling = "False",
					DFIntAnimationLodFacsDistanceMin = "0",
					FFlagFRMRefactor = "False",
					FFlagLoginPageOptimizedPngs = "True",
					FFlagLuauCodegen = "True",
					FFlagMouseGetPartOptimization = "True",
					FFlagNewCameraControls_SpeedAdjustEnum = "False",
					FFlagNewOptimizeNoCollisionPrimitiveInMidphase651 = "True",
					FFlagOcclusionCullingBetaFeature = "True",
					FFlagPreloadAllFonts = "True",
					FFlagPreloadMinimalFonts = "True",
					FFlagPreloadTextureItemsOption4 = "True",
					FFlagRenderCBRefactor2 = "True",
					FFlagRenderDebugCheckThreading2 = "True",
					FFlagRenderLegacyShadowsQualityRefactor = "True",
					FFlagRenderLightGridEfficientTextureAtlasUpdate = "True",
					FFlagRenderNoLowFrmBloom = "False",
					FFlagRenderOptimizeDecalTransparencyInvalidation = "True",
					FFlagRenderShadowSkipHugeCulling = "True",
					FFlagRenderSkipReadingShaderData = "False",
					FFlagShaderLightingRefactor = "True",
					FFlagShoeSkipRenderMesh = "False",
					FFlagSyncWebViewCookieToEngine2 = "False",
					FFlagTopBarUseNewBadge = "False",
					FFlagUpdateHTTPCookieStorageFromWKWebView = "False",
					FFlagUserCameraControlLastInputTypeUpdate = "True",
					FFlagUserCameraInputDt = "True",
					FFlagUserCameraInputRefactor3 = "True",
					FFlagUserFixLoadAnimationError = "True",
					FFlagUserHideCharacterParticlesInFirstPerson = "True",
					FFlagVideoRenderUseHardwareBuffer = "True",
					FFlagVideoServiceAddHardwareCodecMetrics = "True",
					FFlagVignetteEffectEnabled4 = "False",
					FFlagVisBugChecksThreadYield = "True",
					FFlagVoiceBetaBadge = "False",
					FFlagVRLaserPointerOptimization = "True",
					FFlagVRMouseMoveOptimization = "True",
					FIntBloomFrmCutoff = "0",
					FIntBootstrapperWebView2InstallationTelemetryHundredthPercent = "0",
					FIntCameraMaxZoomDistance = "99999",
					FIntDebugFRMOptionalMSAALevelOverride = "0",
					FIntDirectionalAttenuationMaxPoints = "0",
					FIntEnableCullableScene2HundredthPercent3 = "100",
					FIntEnableVisBugChecksHundredthPercent27 = "100",
					FIntFRMMaxGrassDistance = "0",
					FIntFRMMinGrassDistance = "0",
					FIntGameGridFlexFeedItemTileNumPerFeed = "0",
					FIntGrassMovementReducedMotionFactor = "0",
					FIntNewInGameMenuPercentRollout3 = "0",
					FIntRenderGrassDetailStrands = "0",
					FIntRenderLocalLightUpdatesMax = "1",
					FIntRenderLocalLightUpdatesMin = "1",
					FIntRenderMaxShadowAtlasUsageBeforeDownscale = "0",
					FIntRenderMeshOptimizeVertexBuffer = "0",
					FIntRenderShadowmapBias = "0",
					FIntSmoothMouseSpringFrequencyTenths = "100",
					FIntSmoothTerrainPhysicsCacheSize = "0",
					FIntSSAOMipLevels = "0",
					FIntUnifiedLightingBlendZone = "0",
					FIntV1MenuLanguageSelectionFeaturePerMillageRollout = "0",
					FIntVertexSmoothingGroupTolerance = "0",
					FStringTerrainMaterialTable2022 = "",
					FStringTerrainMaterialTablePre2022 = "",
					SFFlagAirControllerTurningResponsiveness = "2147483647",
					SFFlagGroundControllerBalancingResponsiveness = "2147483647",
					SFFlagGroundControllerTurningResponsiveness = "2147483647",
					SFFlagSimAnimationConstraintResponsiveness = "2147483647",
					SFFlagSimSolverResponsiveness = "2147483647",
				},
				["Low Input Delay"] = {
					FIntActivatedCountTimerMSKeyboard = "0",
					FFlagMouseGetPartOptimization = "True",
					FIntSimSolverResponsiveness = "2147483647",
					FFlagSortKeyOptimization = "True",
					FFlagFasterPreciseTime4 = "True",
					DFFlagMouseMoveOncePerFrame = "False",
					FIntActivatedCountTimerMSMouse = "0",
					FIntSmoothMouseSpringFrequencyTenths = "100",
					FFlagEnablePerformanceControlService = "True",
					FIntCLI20390_2 = "-1",
				},
				["Low Mesh"] = {
					DFIntCSGLevelOfDetailSwitchingDistance = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
					DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
				},
				["Shiny Ball"] = { DFIntDebugFRMQualityLevelOverride = "3" },
				["Gray World"] = { FIntDebugTextureManagerSkipMips = "10" },
			},
		}

		tbl3.myregion = function()
			local value = ReplicatedStorage.ServerInfo.Region.Value
			if type(value) == "string" and value ~= "" then
				return value
			end
			return nil
		end

		tbl3.ffsetter = function()
			return setfflag
		end

		tbl3.ffknown = function(arg)
			if type(getfflag) ~= "function" then
				return true
			end
			return getfflag(arg) ~= nil
		end

		tbl3.ffparse = function(arg)
			local str2 = tostring(arg or "")
			if str2:gsub("%s", "") == "" then
				return nil
			end
			local match = str2:match("^%s*(.-)%s*$")
			local str3 = match:lower()

			if str3:sub(1, 7) == "http://" or str3:sub(1, 8) == "https://" then
				str2 = tbl3.httpget(match)
				if type(str2) ~= "string" or str2 == "" then
					return nil, match
				end
			elseif str3:sub(-5) == ".json" and isfile and readfile then
				if not isfile(match) then
					return nil, match
				end
				local v5 = readfile(match)
				if type(v5) ~= "string" then
					return nil, match
				end
				str2 = v5
			end

			local data = HttpService:JSONDecode(str2)

			if type(data) == "table" then
				local tbl17 = {}
				local n2 = 0

				for k, v5 in pairs(data) do
					local kind = type(v5)

					if type(k) == "string" and (kind == "string" or kind == "number" or kind == "boolean") then
						tbl17[k] = kind == "boolean" and (v5 and "True" or "False") or tostring(v5)
						n2 += 1
					end
				end

				return n2 > 0 and tbl17 or nil
			end

			local tbl17 = {}
			local n2 = 0

			for match2 in str2:gmatch("[^\r\n,;]+") do
				local match3, v5 = match2:match("^%s*([%w_]+)%s*[=:]%s*(.-)%s*$")

				if match3 and v5 and v5 ~= "" then
					local str4 = v5:gsub("^\"(.*)\"$", "%1")
					local str5 = str4:lower()

					if str5 == "true" or str5 == "false" then
						str4 = str5 == "true" and "True" or "False"
					end

					tbl17[match3] = str4
					n2 += 1
				end
			end

			return n2 > 0 and tbl17 or nil
		end

		tbl3.ffflags = function()
			if toggles.ffcustom and toggles.ffcustom.Value then
				local v5, v6 = tbl3.ffparse(options.ffcustomdata.Value)
				return v5, true, v6
			end
			return tbl16.presets[options.ffpreset and options.ffpreset.Value or tbl16.presetdefault] or tbl16.presets[tbl16.presetdefault], false
		end

		tbl3.ffapply = function()
			local v5 = tbl3.ffsetter()
			if not v5 then
				tbl3.notif("FFlags", "Your executor can't change FFlags.", 6)
				return 0
			end
			local v6, v7, v8 = tbl3.ffflags()

			if not v6 then
				if v8 then
					tbl3.notif("FFlags", format("Couldn't load \"%s\". Check the file name or link.", v8), 6)
				else
					tbl3.notif("FFlags", "Those FFlags look wrong. Paste FFlag text, a .json file name, or a link.", 6)
				end

				return 0
			end

			local tbl17 = {}
			local n2 = 0
			local n3 = 0

			for k, v9 in pairs(v6) do
				if tbl3.ffknown(k) then
					v5(k, tostring(v9))
					tbl17[k] = tostring(v9)
					n2 += 1
				else
					n3 += 1
				end
			end

			if writefile then
				writefile(tbl16.file, HttpService:JSONEncode(tbl17))
			end

			if n2 == 0 then
				tbl3.notif("FFlags", format("Your Roblox build knows none of those %d flags, so nothing changed.", n3), 7)
				return 0
			end
			tbl3.notif("FFlags", n3 > 0 and format("%d flags saved. %d skipped - your Roblox build doesn't have them.", n2, n3) or format("%d flags saved.", n2), 5)
			return n2
		end

		tbl3.ffload = function()
			local v5 = tbl3.ffsetter()
			if not (v5 and isfile and readfile and isfile(tbl16.file)) then
				return
			end
			local data = HttpService:JSONDecode(readfile(tbl16.file))
			if type(data) ~= "table" then
				return
			end

			for k, v6 in pairs(data) do
				if tbl3.ffknown(k) then
					v5(k, tostring(v6))
				end
			end
		end

		tbl3.ffreq = function()
			return request
		end

		tbl3.ffserverip = function(arg)
			local v5 = tbl3.ffreq()
			if not v5 then
				return nil
			end

			local v6 = v5({
				Url = "https://gamejoin.roblox.com/v1/join-game-instance",
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json", ["User-Agent"] = "Roblox/WinInet" },
				Body = HttpService:JSONEncode({ placeId = game.PlaceId, isTeleport = false, gameId = arg, gameJoinAttemptId = arg }),
			})

			if type(v6) ~= "table" or not v6.Body then
				return nil
			end
			local data = HttpService:JSONDecode(v6.Body)
			if type(data) ~= "table" then
				return nil
			end
			local joinScript = data.joinScript
			if type(joinScript) ~= "table" then
				return nil
			end
			local udmuxEndpoints = joinScript.UdmuxEndpoints
			if type(udmuxEndpoints) == "table" and type(udmuxEndpoints[1]) == "table" and udmuxEndpoints[1].Address then
				return udmuxEndpoints[1].Address
			end
			return joinScript.MachineAddress
		end

		tbl3.ffregionof = function(arg)
			if tbl16.ipcache[arg] then
				return tbl16.ipcache[arg]
			end
			local v5 = tbl3.ffreq()
			if not v5 then
				return nil
			end

			local v6 = v5({
				Url = "http://ip-api.com/json/" .. arg .. "?fields=status,continentCode,countryCode,lat,lon",
				Method = "GET",
			})

			if type(v6) ~= "table" or not v6.Body then
				return nil
			end
			local data = HttpService:JSONDecode(v6.Body)
			if type(data) ~= "table" or data.status ~= "success" then
				return nil
			end
			local continentCode = data.continentCode
			local countryCode = data.countryCode
			local n2 = tonumber(data.lat) or 0
			local n3 = tonumber(data.lon) or 0
			local str2

			if countryCode == "US" or countryCode == "CA" then
				if n3 < -115 then
					str2 = "US West"
				elseif n3 < -95 then
					str2 = "US Central"
				elseif n2 < 33 then
					str2 = "US South"
				else
					str2 = "US East"
				end
			elseif countryCode == "GB" or countryCode == "IE" then
				str2 = "UK"
			elseif continentCode == "EU" then
				str2 = n3 < 12 and "Europe West" or "Europe East"
			elseif continentCode == "AS" then
				if tbl16.sea[countryCode] then
					str2 = "Southeast Asia"
				elseif tbl16.sasia[countryCode] then
					str2 = "South Asia"
				else
					str2 = "Asia East"
				end
			elseif continentCode == "OC" then
				str2 = "Oceania"
			elseif continentCode == "SA" then
				str2 = "South America"
			else
				str2 = nil

				if continentCode == "NA" then
					str2 = "US East"
				end
			end

			if str2 then
				tbl16.ipcache[arg] = str2
			end

			return str2
		end

		tbl3.ffhop = function(arg)
			if tbl16.hopping then
				return
			end

			if not arg or arg == "Auto" then
				if fn4 then
					fn4()
				end

				return
			end

			if not tbl3.ffreq() then
				tbl3.notif("Region", "Your executor can't pick a region.", 5)
				return
			end
			tbl16.hopping = true

			tbl3.bindt(task.spawn(function()
				local str2 = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
				local v5 = tbl3.httpget(str2)
				local data = v5 and HttpService:JSONDecode(v5)

				if type(data) ~= "table" or type(data.data) ~= "table" then
					tbl16.hopping = false
					tbl3.notif("Region", "Couldn't load the server list. Try again.", 4)
					return
				end

				tbl3.notif("Region", "Looking for a " .. arg .. " server...", 4)
				local n2 = 0

				for _, v6 in ipairs(data.data) do
					if n2 >= 25 then
						break
					end

					if type(v6) == "table" and v6.id and v6.id ~= game.JobId and v6.playing and v6.maxPlayers and v6.playing < v6.maxPlayers then
						n2 += 1
						local v7 = tbl3.ffserverip(v6.id)

						if v7 and tbl3.ffregionof(v7) == arg then
							tbl16.hopping = false
							TeleportService:TeleportToPlaceInstance(game.PlaceId, v6.id, localPlayer)
							return
						end

						task.wait(0.35)
					end
				end

				tbl16.hopping = false
				tbl3.notif("Region", format("Checked %d servers, no %s server found. Try again.", n2, arg), 5)
			end))
		end

		local tbl17 = {
			items = {},
			conn = nil,
			acc = 0,
			icons = {},
			cols = {},
			cds = {},
			cdwait = {},
			shared = nil,
			ready = Color3.fromRGB(120, 230, 120),
			cool = accent,
			miss = "rbxassetid://6034407076",
		}

		local n2 = flag and 0.68 or 1
		local function fn8(l)return  floor (l* n2 +0.5);end
		tbl3.esphex = function(l)return  format ("#%02x%02x%02x", floor (l.R*255+0.5), floor (l.G*255+0.5), floor (l.B*255+0.5));end
		tbl3.espdata = function(l)local K= ReplicatedStorage :FindFirstChild("Misc");local h=K and(K:FindFirstChild("DataAbilities"));return h and(h:FindFirstChild(l))or nil;end
		tbl3.espabil = function(h,l)return l:GetAttribute("Ability")or(h:GetAttribute("CurrentlyEquippedAbility"))or"Dash";end
		tbl3.espcolor = function(l)if not l then return nil;end;local K= tbl17 .cols[l];if K~=nil then return K or nil;end;local p=nil;K= tbl3 .espdata(l);if K then local E=K:GetAttribute("Color");p=if typeof(E)=="Color3"then E else p;end; tbl17 .cols[l]=p or false;return p;end

		tbl3.espfetch = function(arg, arg2)
			if tbl17.shared == nil then
				local shared = ReplicatedStorage:FindFirstChild("Shared")
				shared = shared and shared:FindFirstChild("Abilities")
				tbl17.shared = shared and require(shared) or false
			end

			local getAbilityCooldown = tbl17.shared and tbl17.shared.getAbilityCooldown
			local module = nil

			if getAbilityCooldown then
				module = tbl17.shared.getAbilityCooldown(arg, arg2)
			end

			if not module then
				local shared = ReplicatedStorage:FindFirstChild("Shared")
				shared = shared and shared:FindFirstChild("Abilities")
				shared = shared and shared:FindFirstChild(arg2)

				if shared then
					module = require(shared)
					module = module and module.cooldown
				end
			end

			tbl17.cds[arg2] = type(module) == "number" and module > 0 and module or false
		end

		tbl3.esptotal = function(l,K)if not K then return nil;end;local p= tbl17 .cds[K];if p~=nil then return p or nil;end;if not  tbl17 .cdwait[K]then  tbl17 .cdwait[K]=true;task.defer( tbl3 .espfetch,l,K);end;return nil;end
		tbl3.esplevel = function(h,l)if not l then return 0;end;local K=h:FindFirstChild("Upgrades");h=K and(K:FindFirstChild(l));return h and(tonumber(h.Value))or 0;end
		tbl3.espicon = function(l,K)if not l then return  tbl17 .miss;end;local p=l..tostring(K);local E= tbl17 .icons[p];if E then return E;end;E= tbl3 .espdata(l);if not E then  tbl17 .icons[p]= tbl17 .miss;return  tbl17 .miss;end;l=(if K and K>0 then(E:GetAttribute("Icon"..K))else nil)or(E:GetAttribute("Icon"))or  tbl17 .miss; tbl17 .icons[p]=l;return l;end
		tbl3.espdrop = function(h)if h and h.gui then h.gui:Destroy();end;end
		tbl3.espclear = function()for l,l in pairs( tbl17 .items)do  tbl3 .espdrop(l);end; tbl17 .items={};end
		tbl3.espmake = function(l,K)local p=K:FindFirstChild("Head")or(K:FindFirstChild("HumanoidRootPart"));if not p then return nil;end;K=Instance.new("BillboardGui");K.Name="\0ae";K.Adornee=p;K.Size=UDim2.fromOffset( fn8 (230), fn8 (60));K.StudsOffsetWorldSpace=Vector3.new(0,3.2,0);K.AlwaysOnTop=true;K.ResetOnSpawn=false;K.Parent= fn6 and( fn6 ())or  CoreGui ;local E=Instance.new("Frame");E.Size=UDim2.fromScale(1,1);E.BackgroundTransparency=1;E.Parent=K;local k=Instance.new("UIListLayout");k.FillDirection=Enum.FillDirection.Vertical;k.HorizontalAlignment=Enum.HorizontalAlignment.Center;k.VerticalAlignment=Enum.VerticalAlignment.Bottom;k.SortOrder=Enum.SortOrder.LayoutOrder;k.Padding=UDim.new(0, fn8 (2));k.Parent=E;k=Instance.new("TextLabel");k.LayoutOrder=1;k.Size=UDim2.new(1,0,0, fn8 (15));k.BackgroundTransparency=1;k.Font=Enum.Font.GothamBold;k.TextSize= fn8 (13);k.TextStrokeTransparency=0.35;k.TextStrokeColor3=Color3.fromRGB(0,0,0);k.TextColor3= accent ;k.Text="";k.Parent=E;local a=Instance.new("Frame");a.LayoutOrder=2;a.Size=UDim2.fromOffset( fn8 (120), fn8 (22));a.AutomaticSize=Enum.AutomaticSize.X;a.BackgroundColor3=Color3.fromRGB(8,12,20);a.BackgroundTransparency=0.2;a.BorderSizePixel=0;a.Parent=E; tbl3 .corner(a, fn8 (6));local d=Instance.new("UIPadding");d.PaddingLeft=UDim.new(0, fn8 (5));d.PaddingRight=UDim.new(0, fn8 (7));d.Parent=a;d=Instance.new("UIListLayout");d.FillDirection=Enum.FillDirection.Horizontal;d.HorizontalAlignment=Enum.HorizontalAlignment.Left;d.VerticalAlignment=Enum.VerticalAlignment.Center;d.SortOrder=Enum.SortOrder.LayoutOrder;d.Padding=UDim.new(0, fn8 (5));d.Parent=a;d=Instance.new("ImageLabel");d.LayoutOrder=1;d.Size=UDim2.fromOffset( fn8 (20), fn8 (20));d.BackgroundTransparency=1;d.ScaleType=Enum.ScaleType.Fit;d.Image= tbl17 .miss;d.Parent=a;local I=Instance.new("TextLabel");I.LayoutOrder=2;I.AutomaticSize=Enum.AutomaticSize.X;I.Size=UDim2.new(0,0,1,0);I.BackgroundTransparency=1;I.RichText=true;I.Font=Enum.Font.GothamBold;I.TextSize= fn8 (14);I.TextStrokeTransparency=0.4;I.TextStrokeColor3=Color3.fromRGB(0,0,0);I.TextColor3= color2 ;I.Text="";I.Parent=a;a=Instance.new("Frame");a.LayoutOrder=3;a.Size=UDim2.fromOffset( fn8 (96), fn8 (5));a.BackgroundColor3=Color3.fromRGB(20,22,28);a.BackgroundTransparency=0.3;a.BorderSizePixel=0;a.Visible=false;a.Parent=E; tbl3 .corner(a, fn8 (3));E=Instance.new("Frame");E.Size=UDim2.fromScale(0,1);E.BackgroundColor3= tbl17 .cool;E.BorderSizePixel=0;E.Parent=a; tbl3 .corner(E, fn8 (3));local C={gui=K,nm=k,icon=d,abil=I,bar=a,fill=E,adornee=p,cdexp=0,cdtotal=nil,wasactive=false,useclock=nil,esttotal=nil}; tbl17 .items[l]=C;return C;end
		tbl3.espupd = function()if not  toggles .abilityesp.Value then return;end;local l= Workspace :GetServerTimeNow();local K= toggles .espcooldown.Value;local p= toggles .espname.Value;local E,k= tbl3 .esphex( tbl17 .ready), tbl3 .esphex( tbl17 .cool);for a,d in ipairs( Players :GetPlayers())do if d~= localPlayer then local I=d.Character;local C,U=I and  alive and I.Parent== alive , tbl17 .items[d];if C then if not U or not U.gui or not U.gui.Parent or not U.adornee or not U.adornee.Parent then  tbl3 .espdrop(U);U=( tbl3 .espmake(d,I));end;if U then U.gui.Enabled=true;a= tbl3 .espabil(d,I);local C= tbl3 .esplevel(d,a);U.icon.Image= tbl3 .espicon(a,C);U.icon.ImageTransparency=a and 0 or 0.55;U.nm.Visible=p;if p then U.nm.Text=C>0 and d.DisplayName.." V"..C+1 or d.DisplayName;end;local p={};if a then local J= tbl3 .espcolor(a);local G,S=if J then( tbl3 .esphex(J))else"#f0ece0",tostring(a):upper():gsub("&","&amp;"):gsub("<","&lt;");p[#p+1]="<font color=\""..G.."\">"..(if  tbl3 .metaabil[a]then"\226\154\160 "..(if C>0 then S.." V"..C+1 else S)else if C>0 then S.." V"..C+1 else S).."</font>";end;local J,G,S= tbl3 .abilblocked(I),I:GetAttribute("AbilityActive")==true,0;if K then local N=I:GetAttribute("CooldownExpiration")or 0;S= max (0,N-l);if N>U.cdexp+0.01 then U.cdexp=N;U.cdtotal= max (S,0.1);elseif N<U.cdexp-0.01 then U.cdexp=N;end;if G and not U.wasactive then U.useclock=l;U.esttotal=a and( tbl3 .esptotal(d,a))or nil;end;U.wasactive=G;if U.useclock and U.esttotal then N=U.esttotal-(l-U.useclock);if N<=0 then U.useclock=nil;elseif N>S then if not U.cdtotal or U.cdtotal<U.esttotal then U.cdtotal=U.esttotal;end;S=N;end;end;if J then p[#p+1]="<font color=\"#9aa2b0\">LOCKED</font>";elseif G then p[#p+1]="<font color=\"#be82ff\">ACTIVE</font>";elseif S>0.05 then p[#p+1]= format ("<font color=\"%s\">%.1fs</font>",k,S);else p[#p+1]="<font color=\""..E.."\">READY</font>";end;end;U.abil.Text=table.concat(p,"   ");if K and not J and S>0.05 and a then C=U.cdtotal or( tbl3 .esptotal(d,a));if C and C>0 then G= clamp (1-S/C,0,1);U.fill.Size=UDim2.fromScale(G,1);U.fill.BackgroundColor3= tbl17 .cool:Lerp( tbl17 .ready,G);U.bar.Visible=true;else U.bar.Visible=false;end;else U.bar.Visible=false;end;end;elseif U then  tbl3 .espdrop(U); tbl17 .items[d]=nil;end;end;end;for l,K in pairs( tbl17 .items)do if not l.Parent then  tbl3 .espdrop(K); tbl17 .items[l]=nil;end;end;end

		tbl3.espstart = function()
			if tbl17.conn then
				return
			end
			tbl17.conn = tbl3.bind(RunService.RenderStepped:Connect(function(l) tbl17 .acc= tbl17 .acc+l;if  tbl17 .acc<0.05 then return;end; tbl17 .acc= tbl17 .acc-0.05; tbl3 .espupd();end))
		end

		tbl3.espstop = function()
			if tbl17.conn then
				tbl17.conn:Disconnect()
				tbl17.conn = nil
			end

			tbl3.espclear()
		end

		tbl3.lockhl = function(l)task.defer(function()if not l then if  tbl9 .hl then  tbl9 .hl:Destroy(); tbl9 .hl=nil;end;return;end;if not  tbl9 .hl or not  tbl9 .hl.Parent then local K=Instance.new("Highlight");K.Name="\0lk";K.FillTransparency=0.7;K.OutlineTransparency=0;K.FillColor= accent ;K.OutlineColor=Color3.fromRGB(255,255,255);K.Parent= fn6 and( fn6 ())or  CoreGui ; tbl9 .hl=K;end; tbl9 .hl.Adornee=l;end);end
		tbl3.replion = false
		tbl3.getrep = function(l)if not  tbl3 .replion then local K= ReplicatedStorage :FindFirstChild("Packages");local p=K and(K:FindFirstChild("Replion"));if p then  tbl3 .replion=require(p);end;end;if not  tbl3 .replion then  tbl3 .logwev("getrep",10,"Replion","module unavailable - retrying next call");return nil;end;return  tbl3 .replion.Client:GetReplion(l)or nil;end

		tbl3.claimdaily = function()
			local remote = ReplicatedStorage:FindFirstChild("Remote")
			remote = remote and remote:FindFirstChild("RemoteFunction")
			if not remote then
				return
			end
			local Data = nil

			for i = 1, 20 do
				Data = tbl3.getrep("Data")
				if not Data then
					task.wait(0.5)
					continue
				end
				break
			end

			if not Data then
				return
			end
			local NewDailyLoginStreak = Data:Get("NewDailyLoginStreak")
			local NewDailyLoginAwardList = Data:Get("NewDailyLoginAwardList")
			local n3 = tonumber(NewDailyLoginStreak) or 0
			local n4 = 0

			for i = 1, min(n3, 30) do
				if not (type(NewDailyLoginAwardList) == "table" and table.find(NewDailyLoginAwardList, i)) then
					if remote:InvokeServer("ClaimNewDailyLoginReward", i) then
						n4 += 1
					end

					task.wait(0.5)
				end
			end

			if n4 > 0 then
				tbl3.notif("Daily Login", format("Claimed %d daily reward%s.", n4, n4 == 1 and "" or "s"), 5)
			end
		end

		tbl3.updatedata = function()
			if tbl3.dlacct then
				local accountAge = localPlayer.AccountAge
				local membership = tostring(localPlayer.MembershipType):gsub("Enum.MembershipType.", "")
				local tbl18 = {}
				local str2 = "Name: " .. localPlayer.DisplayName .. " (@" .. localPlayer.Name .. ")"
				local str3 = "User ID: " .. tostring(localPlayer.UserId)
				local str4 = "Account Age: " .. tostring(accountAge) .. " days"
				local str5 = "Membership: " .. membership
				local str6 = "Place / Universe: " .. tostring(game.PlaceId) .. " / " .. tostring(game.GameId)
				local str7 = "Job ID: " .. tostring(game.JobId)
				local str8 = "Region: " .. tostring(tbl3.myregion() or "unknown")
				local str9 = "Players: " .. #Players:GetPlayers() .. " / " .. tostring(Players.MaxPlayers)
				local str10 = "Ping: " .. format("%d ms", floor(tbl3.getping() + 0.5))
				local str11 = "FPS: " .. tostring(tbl3.datafps or 0)
				tbl18[1] = str2
				tbl18[2] = str3
				tbl18[3] = str4
				tbl18[4] = str5
				tbl18[5] = ""
				tbl18[6] = str6
				tbl18[7] = str7
				tbl18[8] = str8
				tbl18[9] = str9
				tbl18[10] = str10
				tbl18[11] = str11
				tbl3.dlacct:SetText(table.concat(tbl18, "\n"))
			end

			if tbl3.dlsess then
				local v5 = tbl3.safechar()
				local attribute = v5 and v5:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword") or "-"
				local attribute2 = v5 and v5:GetAttribute("Ability") or localPlayer:GetAttribute("CurrentlyEquippedAbility") or "-"
				local tbl18 = {}
				local str2 = "Sword: " .. tostring(attribute)
				local str3 = "Ability: " .. tostring(attribute2)
				tbl18[1] = str2
				tbl18[2] = str3
				local leaderstats = localPlayer:FindFirstChild("leaderstats")

				if leaderstats then
					for _, child in ipairs(leaderstats:GetChildren()) do
						tbl18[#tbl18 + 1] = child.Name .. ": " .. tostring(child.Value)
					end
				end

				local Data = tbl3.getrep("Data")

				if Data then
					local Wins = Data:Get("TotalStats.Wins")

					if type(Wins) == "number" then
						if not tbl3.startwins then
							tbl3.startwins = Wins
						end

						tbl18[#tbl18 + 1] = "Total Wins: " .. tostring(Wins)
						tbl18[#tbl18 + 1] = "Session Wins: " .. tostring(Wins - tbl3.startwins)
					end
				end

				tbl18[#tbl18 + 1] = ""
				tbl18[#tbl18 + 1] = format("Rounds: %d (won %d)", tbl3.rndplayed, tbl3.rndwins)
				tbl18[#tbl18 + 1] = "Round Kills: " .. tostring(tbl3.rndkills)

				if tbl3.rndlast ~= "" then
					tbl18[#tbl18 + 1] = "Last Round: " .. tbl3.rndlast
				end

				local n3 = os.time() - (tbl3.sessionstart or os.time())
				tbl18[#tbl18 + 1] = "Session Parries: " .. tostring(tbl9.sessparry or 0)
				tbl18[#tbl18 + 1] = format("In Server: %02d:%02d", floor(n3 / 60), n3 % 60)
				tbl3.dlsess:SetText(table.concat(tbl18, "\n"))
			end

			if tbl3.devstat then
				tbl3.devstat()
			end
		end

		tbl3.startdatapanel = function()
			tbl3.sessionstart = tbl3.sessionstart or os.time()
			if tbl3.dataconn then
				return
			end
			tbl3.datafps = 0
			local n3 = 0
			local v5 = clock()
			tbl3.dataconn = tbl3.bind(RunService.RenderStepped:Connect(function() n3 +=1;local l= clock ();if l- v5 >=0.5 then  tbl3 .datafps= floor ( n3 /(l- v5 )+0.5); n3 , v5 =0,l;end;end))

			tbl3.bindt(task.spawn(function()
				while true do
					task.wait(1)
					tbl3.updatedata()
				end
			end))
		end

		tbl3.pokeafk = function()
			local v5 = tbl3.getvim()
			v5:SendKeyEvent(true, Enum.KeyCode.T, false, game)
			task.wait(0.05)
			v5:SendKeyEvent(false, Enum.KeyCode.T, false, game)
		end

		tbl3.stopafk = function()
			if tbl9.afkthread then
				task.cancel(tbl9.afkthread)
				tbl9.afkthread = nil
			end

			if tbl9.afkconn then
				tbl9.afkconn:Disconnect()
				tbl9.afkconn = nil
			end
		end

		tbl3.startafk = function()
			tbl3.stopafk()

			tbl9.afkconn = tbl3.bind(localPlayer.Idled:Connect(function()
				if tbl10.antiafk then
					tbl3.pokeafk()
				end
			end))

			tbl9.afkthread = tbl3.bindt(task.spawn(function()
				while tbl10.antiafk do
					tbl3.pokeafk()
					task.wait(120)
				end
			end))
		end

		local riseLoaderUrl = type(_G.RiseLoaderUrl) == "string" and _G.RiseLoaderUrl ~= "" and _G.RiseLoaderUrl

		if riseLoaderUrl then
			local v5 = riseLoaderUrl

			tbl3.queuetp = function()
				local v6 = queueonteleport
				if type(v6) ~= "function" then
					return
				end
				local riseScriptSource

				if type(_G.RiseScriptSource) == "string" and _G.RiseScriptSource ~= "" then
					riseScriptSource = _G.RiseScriptSource
				else
					riseScriptSource = nil

					if v5:sub(1, 4) == "http" then
						riseScriptSource = ("loadstring(game:HttpGet(\"%s\"))()"):format(v5)
					end
				end

				if not riseScriptSource then
					tbl3.notif("Auto Execute", "Rise can't restart itself after a teleport. Open Rise from its loader.", 6)
					return
				end
				v6("_G.cuties = nil\n_G.RiseBoot = nil\n" .. riseScriptSource)
				tbl3.queued = true
			end

			tbl3.vipcb = function(arg)
				local textChatMessageProperties = Instance.new("TextChatMessageProperties")

				if tbl10.viptag and arg.TextSource and arg.TextSource.UserId == localPlayer.UserId then
					textChatMessageProperties.PrefixText = "<font color='#FFD700'>[VIP]</font> " .. arg.PrefixText
				end

				return textChatMessageProperties
			end

			tbl3.applyvip = function()
				if tbl9.vipset then
					return
				end
				local TextChatService = game:GetService("TextChatService")
				TextChatService.OnIncomingMessage = tbl3.vipcb
				tbl9.vipset = true

				tbl3.bindt(task.delay(2, function()
					if tbl9.vipset then
						TextChatService.OnIncomingMessage = tbl3.vipcb
					end
				end))
			end

			tbl3.killvip = function()
				if not tbl9.vipset then
					return
				end

				game:GetService("TextChatService").OnIncomingMessage = function()
					return nil
				end

				tbl9.vipset = false
			end

			local tbl18 = {
				Cinematic = {
					bloom = { Intensity = 0.85, Size = 24, Threshold = 0.92 },
					cc = {
						Brightness = 0.02,
						Contrast = 0.16,
						Saturation = 0.06,
						TintColor = Color3.fromRGB(255, 246, 236),
					},
					sun = { Intensity = 0.08, Spread = 0.5 },
					dof = { FarIntensity = 0.4, FocusDistance = 0.05, InFocusRadius = 70, NearIntensity = 0 },
				},
				Vivid = {
					bloom = { Intensity = 1.1, Size = 22, Threshold = 0.88 },
					cc = {
						Brightness = 0.04,
						Contrast = 0.2,
						Saturation = 0.28,
						TintColor = Color3.fromRGB(255, 252, 248),
					},
					sun = { Intensity = 0.06, Spread = 0.45 },
					dof = { FarIntensity = 0.25, FocusDistance = 0.05, InFocusRadius = 90, NearIntensity = 0 },
				},
				["Soft Dream"] = {
					bloom = { Intensity = 1.6, Size = 40, Threshold = 0.78 },
					cc = {
						Brightness = 0.06,
						Contrast = -0.05,
						Saturation = 0.1,
						TintColor = Color3.fromRGB(255, 244, 250),
					},
					sun = { Intensity = 0.14, Spread = 0.7 },
					dof = { FarIntensity = 0.55, FocusDistance = 0.05, InFocusRadius = 55, NearIntensity = 0 },
				},
				Noir = {
					bloom = { Intensity = 1, Size = 26, Threshold = 0.9 },
					cc = {
						Brightness = 0,
						Contrast = 0.3,
						Saturation = -0.85,
						TintColor = Color3.fromRGB(235, 240, 255),
					},
					sun = { Intensity = 0.05, Spread = 0.4 },
					dof = { FarIntensity = 0.3, FocusDistance = 0.05, InFocusRadius = 80, NearIntensity = 0 },
				},
				["Warm Sunset"] = {
					bloom = { Intensity = 1.2, Size = 30, Threshold = 0.82 },
					cc = {
						Brightness = 0.03,
						Contrast = 0.12,
						Saturation = 0.18,
						TintColor = Color3.fromRGB(255, 226, 196),
					},
					sun = { Intensity = 0.18, Spread = 0.65 },
					dof = { FarIntensity = 0.35, FocusDistance = 0.05, InFocusRadius = 75, NearIntensity = 0 },
				},
				["Cold Steel"] = {
					bloom = { Intensity = 0.9, Size = 22, Threshold = 0.9 },
					cc = {
						Brightness = 0,
						Contrast = 0.22,
						Saturation = -0.1,
						TintColor = Color3.fromRGB(214, 230, 255),
					},
					sun = { Intensity = 0.05, Spread = 0.4 },
					dof = { FarIntensity = 0.3, FocusDistance = 0.05, InFocusRadius = 85, NearIntensity = 0 },
				},
				["Neon Night"] = {
					bloom = { Intensity = 2, Size = 34, Threshold = 0.7 },
					cc = {
						Brightness = -0.04,
						Contrast = 0.26,
						Saturation = 0.4,
						TintColor = Color3.fromRGB(228, 232, 255),
					},
					sun = { Intensity = 0, Spread = 0.4 },
					dof = { FarIntensity = 0.45, FocusDistance = 0.05, InFocusRadius = 60, NearIntensity = 0 },
				},
			}

			tbl3.clrshade = function()
				if tbl9.shadefx then
					for _, v6 in ipairs(tbl9.shadefx) do
						v6:Destroy()
					end

					tbl9.shadefx = nil
				end
			end

			tbl3.applyshade = function()
				tbl3.clrshade()
				if not tbl10.shaders then
					return
				end
				local cinematic = tbl18[tbl10.shaderpreset] or tbl18.Cinematic
				local shadefx = {}

				local function fn9(arg, arg2)
					local instance = Instance.new(arg)

					for k, v6 in pairs(arg2) do
						instance[k] = v6
					end

					instance.Parent = Lighting
					shadefx[#shadefx + 1] = instance
					return instance
				end

				local v6 = clamp(cinematic.cc.Saturation + (tbl10.saturation or 1) - 1, -1, 1)

				fn9("ColorCorrectionEffect", {
					Name = "_rcc",
					Brightness = clamp(cinematic.cc.Brightness + (tbl10.brightness or 0), -1, 1),
					Contrast = clamp(cinematic.cc.Contrast + (tbl10.contrast or 0), -1, 1),
					Saturation = v6,
					TintColor = cinematic.cc.TintColor,
				})

				fn9("BloomEffect", {
					Name = "_rbloom",
					Intensity = max(0, cinematic.bloom.Intensity * (tbl10.bloom or 1)),
					Size = cinematic.bloom.Size,
					Threshold = cinematic.bloom.Threshold,
				})

				if cinematic.sun and cinematic.sun.Intensity > 0 then
					fn9("SunRaysEffect", { Name = "_rsun", Intensity = cinematic.sun.Intensity, Spread = cinematic.sun.Spread })
				end

				if tbl10.dof and cinematic.dof then
					fn9("DepthOfFieldEffect", {
						Name = "_rdof",
						FarIntensity = cinematic.dof.FarIntensity,
						FocusDistance = cinematic.dof.FocusDistance,
						InFocusRadius = cinematic.dof.InFocusRadius,
						NearIntensity = cinematic.dof.NearIntensity,
					})
				end

				tbl9.shadefx = shadefx
			end

			tbl3.clrrain = function()
				if tbl9.rainconn then
					tbl9.rainconn:Disconnect()
					tbl9.rainconn = nil
				end

				if tbl9.rainfx then
					for _, v6 in ipairs(tbl9.rainfx) do
						v6:Destroy()
					end

					tbl9.rainfx = nil
				end
			end

			tbl3.applyrain = function()
				tbl3.clrrain()
				if not tbl10.rain then
					return
				end
				local part = Instance.new("Part")
				part.Name = "_rrain"
				part.Anchored = true
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.Transparency = 1
				part.Size = Vector3.new(70, 1, 70)
				part.Orientation = Vector3.zero
				local particleEmitter = Instance.new("ParticleEmitter")
				particleEmitter.Name = "_rrainfx"
				particleEmitter.Rate = tbl10.rainrate or 150
				particleEmitter.Lifetime = NumberRange.new(0.55, 0.8)
				particleEmitter.Speed = NumberRange.new(75, 95)
				particleEmitter.SpreadAngle = Vector2.new(6, 6)
				particleEmitter.Acceleration = Vector3.new(0, -60, 0)
				particleEmitter.EmissionDirection = Enum.NormalId.Bottom
				particleEmitter.Rotation = NumberRange.new(0, 0)
				local new = NumberSequenceKeypoint.new
				particleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.18), new(1, 0.1) })
				local numberSequence = NumberSequence.new
				local tbl19 = {}
				local v6 = NumberSequenceKeypoint.new(0, 0.25)
				local v7 = NumberSequenceKeypoint.new(0.8, 0.4)
				local new2 = NumberSequenceKeypoint.new
				tbl19[1] = v6
				tbl19[2] = v7

				do
					local values = table.pack(new2(1, 1))
					table.move(values, 1, values.n, 3, tbl19)
				end

				particleEmitter.Transparency = numberSequence(tbl19)
				particleEmitter.Color = ColorSequence.new(Color3.fromRGB(170, 200, 230))
				particleEmitter.LightEmission = 0.2
				particleEmitter.Brightness = 1
				particleEmitter.ZOffset = 1
				particleEmitter.Parent = part
				part.Parent = Workspace
				tbl9.rainfx = { part }
				tbl9.rainconn = tbl3.bind(RunService.RenderStepped:Connect(function()if not  tbl10 .rain then return;end;local l= tbl3 .safehrp();local K=l and l.Position;K=if not K and  currentCamera then  currentCamera .CFrame.Position else K;if K then  part .Position=K+Vector3.new(0,32,0);end; particleEmitter .Rate= tbl10 .rainrate or 150;end))
			end

			tbl3.stopmusic = function()
				tbl9.musicsound = nil

				for _, child in ipairs(SoundService:GetChildren()) do
					if child.Name == "_rbgm" then
						child:Destroy()
					end
				end
			end

			tbl3.setupmusic = function()
				tbl3.stopmusic()
				if not tbl10.music then
					return
				end
				tbl9.musicgen = (tbl9.musicgen or 0) + 1
				local musicgen = tbl9.musicgen
				local musicid = tbl10.musicid
				local match

				if musicid and musicid ~= "" then
					match = tostring(musicid):match("%d+")
				else
					match = tbl6[tbl10.track]
				end

				if not match or match == "" then
					tbl3.notif("Music", "That track has no audio ID. Pick another song.", 3)
					return
				end
				local num = tonumber(match)

				if num then
					local productInfo = MarketplaceService:GetProductInfo(num)
					if musicgen ~= tbl9.musicgen then
						return
					end

					if type(productInfo) == "table" and productInfo.AssetTypeId then
						if productInfo.AssetTypeId ~= 3 then
							tbl3.notif("Music", "That is not a song. Paste a Roblox audio ID.", 6)
							return
						end
						tbl3.notif("Music", "Now playing \"" .. tostring(productInfo.Name) .. "\"", 3)
					end
				end

				local sound = Instance.new("Sound")
				sound.Name = "_rbgm"
				sound.SoundId = "rbxassetid://" .. tostring(match)
				sound.Volume = clamp((tbl10.vol or 3) / 10, 0, 1)
				sound.Looped = true
				sound.Parent = SoundService
				sound:Play()
				tbl9.musicsound = sound

				tbl3.bindt(task.spawn(function()
					local n3 = clock() + 5

					while clock() < n3 do
						if sound.Parent ~= SoundService then
							return
						end

						if sound.IsLoaded then
							return
						end
						task.wait(0.25)
					end

					if sound.Parent == SoundService and not sound.IsLoaded then
						tbl3.notif("Music", (musicid and musicid ~= "" and "ID " .. tostring(match) or "\"" .. tostring(tbl10.track) .. "\"") .. " won't load. Pick another song.", 5)
					end
				end))
			end

			tbl3.hudbutton = function(name, arg, text, arg2, arg3)
				local screenGui = Instance.new("ScreenGui")
				screenGui.Name = name
				screenGui.ResetOnSpawn = false
				screenGui.IgnoreGuiInset = true
				screenGui.DisplayOrder = 58
				screenGui.Parent = v.ScreenGui or fn6 and fn6() or CoreGui
				local textButton = Instance.new("TextButton")
				textButton.AnchorPoint = Vector2.new(1, 0)
				textButton.Position = UDim2.new(1, -16, 0, arg)
				textButton.Size = UDim2.fromOffset(flag and 128 or 100, flag and 46 or 38)
				textButton.BackgroundColor3 = color
				textButton.BackgroundTransparency = 0.04
				textButton.BorderSizePixel = 0
				textButton.AutoButtonColor = false
				textButton.Font = Enum.Font.GothamBold
				textButton.TextSize = flag and 15 or 13
				textButton.TextColor3 = color2
				textButton.Text = text
				textButton.Parent = screenGui
				tbl3.corner(textButton, 10)
				local v6 = tbl3.stroke(textButton, color3, 1, 0.2)

				local function fn9()
					local v7, v8 = arg2()
					textButton.Text = v7
					textButton.BackgroundColor3 = v8 and accent or color
					textButton.TextColor3 = v8 and Color3.fromRGB(255, 255, 255) or color2
					v6.Color = v8 and accent or color3
				end

				textButton.Activated:Connect(function()
					arg3()
					fn9()
				end)

				tbl3.dragify(textButton, textButton)
				fn9()
				return screenGui, fn9
			end

			tbl3.deltlbtn = function()
				if tbl9.tlgui then
					tbl9.tlgui:Destroy()
					tbl9.tlgui = nil
				end

				tbl9.tlref = nil
			end

			tbl3.tlbtn = function()
				tbl3.deltlbtn()
				local v6 = tbl9
				local v7 = tbl9

				local v8, v9 = tbl3.hudbutton("\0_tl", 150, "LOCK: OFF", function()
					local value = toggles.targetlock.Value
					return value and "LOCK: ON" or "LOCK: OFF", value
				end, function()
					toggles.targetlock:SetValue(not toggles.targetlock.Value)
				end)

				v6.tlgui = v8
				v7.tlref = v9
			end

			tbl3.reftlui = function()
				if toggles.targetlockui and toggles.targetlockui.Value then
					tbl3.tlbtn()
				else
					tbl3.deltlbtn()
				end
			end

			tbl3.delmodebtn = function()
				if tbl9.modegui then
					tbl9.modegui:Destroy()
					tbl9.modegui = nil
				end

				tbl9.moderef = nil
			end

			tbl3.modebtn = function()
				tbl3.delmodebtn()
				local v6 = tbl9
				local v7 = tbl9

				local v8, v9 = tbl3.hudbutton("\0_md", 204, "AP", function()
					local value = toggles.triggerbot.Value
					local value2 = toggles.autoparry.Value
					return value and "TB" or value2 and "AP" or "OFF", value or value2
				end, function()
					if toggles.triggerbot.Value then
						toggles.triggerbot:SetValue(false)
						toggles.autoparry:SetValue(true)
					else
						toggles.autoparry:SetValue(false)
						toggles.triggerbot:SetValue(true)
					end
				end)

				v6.modegui = v8
				v7.moderef = v9
			end

			tbl3.refmodeui = function()
				if toggles.modeui and toggles.modeui.Value then
					tbl3.modebtn()
				else
					tbl3.delmodebtn()
				end
			end

			local unhook = nil
			local fn9 = nil
			local fn10 = nil
			local fn11 = nil

			tbl3.cleanup = function()
				tbl3.stopap()
				tbl3.stopas()
				tbl3.stopms()
				tbl3.stopabil()
				tbl3.stopbestcfg()
				tbl10.thundernocd = false
				tbl3.setnocd()
				tbl3.delmsgui()
				tbl3.deltlbtn()
				tbl3.delmodebtn()
				tbl3.lockhl(nil)
				tbl9.plrforc = false
				tbl3.stopstaff()

				if tbl9.vzdash then
					for _, v6 in ipairs(tbl9.vzdash) do
						v6:Destroy()
					end

					tbl9.vzdash = nil
				end

				if tbl9.vzpart then
					tbl9.vzpart:Destroy()
					tbl9.vzpart = nil
				end

				tbl3.clrbt()
				tbl3.clrpt()
				tbl3.espstop()

				if tbl3.restorecos then
					tbl3.restorecos()
				end

				tbl3.setbright(false)
				tbl3.setnofog(false)
				tbl3.setlowgfx(false)

				if tbl14.gravorig ~= nil then
					Workspace.Gravity = tbl14.gravorig
					tbl14.gravorig = nil
				end

				tbl3.restorefov()
				tbl3.applysky("Default")
				tbl3.settime("Default")
				tbl3.stopafk()
				tbl3.stopphantom()
				tbl3.killvip()
				tbl3.clrshade()
				tbl3.clrrain()
				tbl3.stopmusic()

				for _, v6 in ipairs(tbl9.slashoff) do
					v6:Enable()
				end

				if fn10 then
					fn10()
				end

				if unhook then
					unhook()
				end

				if setfpscap then
					setfpscap(0)
				end

				if tbl3.ewrestore then
					tbl3.ewrestore()
				end

				for _, v6 in ipairs({ "LobbyParry", "RainbowBall", "ShowSwordAccessory" }) do
					localPlayer:SetAttribute(v6, nil)
				end
			end

			toggles.autoparry:OnChanged(function(autoparry)
				tbl10.autoparry = autoparry

				if autoparry then
					tbl3.startap()

					if toggles.triggerbot.Value then
						toggles.triggerbot:SetValue(false)
					end
				else
					tbl3.stopap()
				end

				if tbl9.moderef then
					tbl9.moderef()
				end
			end)

			toggles.modeui:OnChanged(function()
				tbl3.refmodeui()
			end)

			toggles.targetlock:OnChanged(function(tlock)
				tbl10.tlock = tlock

				if tlock then
					local v6 = tbl3.aimedplr() or tbl3.closestplr()
					tbl9.locked = v6
					tbl3.lockhl(v6)

					if v6 then
						tbl3.notif("Target Lock", "Locked onto " .. tostring(v6.Name) .. ".", 3)
					else
						tbl3.notif("Target Lock", "No target. Aim at someone and try again.", 3)
					end
				else
					tbl9.locked = nil
					tbl3.lockhl(nil)
					tbl3.notif("Target Lock", "Off.", 2)
				end

				if tbl9.tlref then
					tbl9.tlref()
				end
			end)

			tbl3.randtgt = function()if not  alive then return nil;end;local l={};for K,K in ipairs( alive :GetChildren())do if K.PrimaryPart and(K:FindFirstChildOfClass("Humanoid"))and( tbl3 .validtgt(K))then l[#l+1]=K;end;end;if#l==0 then return nil;end;return l[math.random(1,#l)];end

			tbl3.startrt = function()
				if tbl9.rtconn then
					tbl9.rtconn:Disconnect()
				end

				tbl9.rtconn = RunService.Heartbeat:Connect(function()if not  tbl10 .randtgt then return;end;local l= tbl9 .locked;if not(l and l.Parent== alive and(l.PrimaryPart or(l:FindFirstChild("HumanoidRootPart"))))or  clock ()-( tbl9 .lastrand or 0)>( tbl10 .randtime or 3)then  tbl9 .locked= tbl3 .randtgt(); tbl9 .lastrand= clock (); tbl3 .lockhl( tbl9 .locked);end;end)
				tbl3.bind(tbl9.rtconn)
			end

			tbl3.stoprt = function()
				if tbl9.rtconn then
					tbl9.rtconn:Disconnect()
					tbl9.rtconn = nil
				end

				if not tbl10.tlock then
					tbl9.locked = nil
					tbl3.lockhl(nil)
				end
			end

			toggles.randomtarget:OnChanged(function(randtgt)
				tbl10.randtgt = randtgt

				if randtgt then
					tbl9.lastrand = 0
					tbl3.startrt()
					tbl3.notif("Random Target", "Aiming at random players.", 3)
				else
					tbl3.stoprt()
					tbl3.notif("Random Target", "Off.", 2)
				end
			end)

			options.randomtargettime:OnChanged(function(randtime)
				tbl10.randtime = randtime
			end)

			toggles.targetlockui:OnChanged(function(tlockui)
				tbl10.tlockui = tlockui
				tbl3.reftlui()
			end)

			options.curvestrength:OnChanged(function(crvstr)
				tbl10.crvstr = crvstr
			end)

			options.curves:OnChanged(function(crv)
				tbl10.crv = crv
			end)

			local curveorder = tbl3.curveorder

			options.curvekey:OnClick(function()
				local value = options.curves.Value
				local n3 = 1

				for i, v6 in ipairs(curveorder) do
					if v6 == value then
						n3 = i
						break
					end
				end

				local v6 = curveorder[n3 % #curveorder + 1]
				options.curves:SetValue(v6)
				tbl10.crv = v6
				tbl3.notif("Curve", "Curve set to " .. v6 .. ".", 2)
			end)

			toggles.curvekb:OnChanged(function(curvekb)
				tbl10.curvekb = curvekb
			end)

			local curveorder2 = tbl3.curveorder

			local tbl19 = {
				[Enum.KeyCode.One] = 1,
				[Enum.KeyCode.Two] = 2,
				[Enum.KeyCode.Three] = 3,
				[Enum.KeyCode.Four] = 4,
				[Enum.KeyCode.Five] = 5,
				[Enum.KeyCode.Six] = 6,
				[Enum.KeyCode.Seven] = 7,
				[Enum.KeyCode.Eight] = 8,
				[Enum.KeyCode.Nine] = 9,
			}

			tbl3.bind(UserInputService.InputBegan:Connect(function(l,K)if K or not  tbl10 .curvekb then return;end;K= curveorder2 [ tbl19 [l.KeyCode]or 0];if K then  options .curves:SetValue(K); tbl10 .crv=K; tbl3 .notif("Curve","Curve set to "..K..".",2);end;end))

			toggles.advcrv:OnChanged(function(advcrv)
				tbl10.advcrv = advcrv
			end)

			toggles.dribblepreclick:OnChanged(function(drbpre)
				tbl10.drbpre = drbpre
			end)

			toggles.sofcounter:OnChanged(function(sofctr)
				tbl10.sofctr = sofctr
			end)

			toggles.triggerbot:OnChanged(function(trigger)
				tbl10.trigger = trigger

				if trigger then
					tbl3.starttrigger()

					if toggles.autoparry.Value then
						toggles.autoparry:SetValue(false)
					end
				else
					tbl3.stoptrigger()
				end

				if tbl9.moderef then
					tbl9.moderef()
				end
			end)

			options.sofmode:OnChanged(function(sofmode)
				tbl10.sofmode = sofmode
			end)

			options.sofdelay:OnChanged(function(sofdelay)
				tbl10.sofdelay = sofdelay
			end)

			toggles.pulldetect:OnChanged(function(pulldetect)
				tbl10.pulldetect = pulldetect
			end)

			toggles.nocurvespam:OnChanged(function(nocrv)
				tbl10.nocrv = nocrv
			end)

			options.socrv:OnChanged(function(socrv)
				tbl10.socrv = socrv
			end)

			options.nscrv:OnChanged(function(nscrv)
				tbl10.nscrv = nscrv
			end)

			options.parryaccuracy:OnChanged(function(acc)
				tbl10.acc = acc
			end)

			options.parryrange:OnChanged(function(rng)
				tbl10.rng = rng
			end)

			toggles.autobestconfig:OnChanged(function(bestcfg)
				tbl10.bestcfg = bestcfg

				if bestcfg then
					tbl3.startbestcfg()
				else
					tbl3.stopbestcfg()
				end
			end)

			toggles.antiafk:OnChanged(function(antiafk)
				tbl10.antiafk = antiafk

				if antiafk then
					tbl3.startafk()
				else
					tbl3.stopafk()
				end
			end)

			toggles.autoexecute:OnChanged(function(autoexec)
				tbl10.autoexec = autoexec

				if autoexec then
					tbl3.queuetp()
				elseif tbl3.queued then
					tbl3.notif("Auto Execute", "Off. It still runs once more after your next teleport.", 6)
				end
			end)

			toggles.viptag:OnChanged(function(viptag)
				tbl10.viptag = viptag
				tbl3.applyvip()
			end)

			toggles.shaders:OnChanged(function(shaders)
				tbl10.shaders = shaders
				tbl3.applyshade()
			end)

			options.shaderpreset:OnChanged(function(shaderpreset)
				tbl10.shaderpreset = shaderpreset
				tbl3.applyshade()
			end)

			toggles.shaderdof:OnChanged(function(dof)
				tbl10.dof = dof
				tbl3.applyshade()
			end)

			options.shaderbloom:OnChanged(function(bloom)
				tbl10.bloom = bloom
				tbl3.applyshade()
			end)

			options.shadersaturation:OnChanged(function(saturation)
				tbl10.saturation = saturation
				tbl3.applyshade()
			end)

			options.shaderbrightness:OnChanged(function(brightness)
				tbl10.brightness = brightness
				tbl3.applyshade()
			end)

			options.shadercontrast:OnChanged(function(contrast)
				tbl10.contrast = contrast
				tbl3.applyshade()
			end)

			toggles.raineffect:OnChanged(function(rain)
				tbl10.rain = rain
				tbl3.applyrain()
			end)

			options.rainintensity:OnChanged(function(rainrate)
				tbl10.rainrate = rainrate
			end)

			toggles.autospam:OnChanged(function(autospam)
				tbl10.autospam = autospam

				if autospam then
					tbl3.startas()
					tbl3.notif("Auto Spam", "On.", 3)
				else
					tbl3.stopas()
					tbl3.notif("Auto Spam", "Off.", 3)
				end
			end)

			toggles.manualspam:OnChanged(function(manspam)
				tbl10.manspam = manspam

				if manspam then
					tbl3.startms()
					tbl3.refmsui()
				else
					tbl3.setmsactive(false)
					tbl3.delmsgui()
					tbl3.stopms()
				end
			end)

			options.parrymethod:OnChanged(function(arg)
				tbl10.keyparry = arg == "Keypress"
			end)

			toggles.norender:OnChanged(function(norender)
				tbl10.norender = norender
				tbl3.setnorender()
			end)

			toggles.emoteonly:OnChanged(function(emoteonly)
				tbl10.emoteonly = emoteonly

				if emoteonly then
					if tbl3.emoteonly then
						tbl3.emoteonly(true)
					end
				end
			end)

			toggles.manualspamui:OnChanged(function(mansui)
				tbl10.mansui = mansui

				if tbl10.manspam then
					tbl3.refmsui()
				end
			end)

			toggles.autoability:OnChanged(function(autoabil)
				if autoabil and not tbl3.featguard("abil", "Auto Ability") then
					toggles.autoability:SetValue(false)
					return
				end
				tbl10.autoabil = autoabil

				if tbl10.autoabil or tbl10.cdprot then
					tbl3.startabil()
				else
					tbl3.stopabil()
				end
			end)

			toggles.cooldownprotection:OnChanged(function(cdprot)
				if cdprot and not tbl3.featguard("abil", "Cooldown Protection") then
					toggles.cooldownprotection:SetValue(false)
					return
				end
				tbl10.cdprot = cdprot

				if tbl10.autoabil or tbl10.cdprot then
					tbl3.startabil()
				else
					tbl3.stopabil()
				end
			end)

			toggles.thundernocd:OnChanged(function(thundernocd)
				tbl10.thundernocd = thundernocd
				tbl3.setnocd()
			end)

			options.abilityminspeed:OnChanged(function(abilspd)
				tbl10.abilspd = abilspd
			end)

			toggles.staffdetection:OnChanged(function(staff)
				tbl10.staff = staff

				if staff then
					tbl3.startstaff()
				else
					tbl3.stopstaff()
				end
			end)

			options.staffaction:OnChanged(function(staffdo)
				tbl10.staffdo = staffdo
			end)

			toggles.visualizer:OnChanged(function(viz)
				tbl10.viz = viz
				tbl3.setupviz()
			end)

			options.visualizercolour:OnChanged(function(vizcol)
				tbl10.vizcol = vizcol
			end)

			tbl3.setaccent = function(arg)
				v.Scheme.AccentColor = arg or options.uiaccent and options.uiaccent.Value or tbl3.accent
				v:UpdateColorsUsingRegistry()
			end

			options.uiaccent:OnChanged(function(arg)
				tbl3.setaccent(arg)
			end)

			toggles.balltrail:OnChanged(function(bt)
				tbl10.bt = bt

				if bt then
					tbl3.applybt()
				else
					tbl3.clrbt()
				end
			end)

			toggles.balltrailrainbow:OnChanged(function(btrb)
				tbl10.btrb = btrb

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.balltrailparticles:OnChanged(function(btpart)
				tbl10.btpart = btpart

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.balltrailglow:OnChanged(function(btglow)
				tbl10.btglow = btglow

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltrailstartcolour:OnChanged(function(btstart)
				tbl10.btstart = btstart

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltrailendcolour:OnChanged(function(btend)
				tbl10.btend = btend

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltraillifetime:OnChanged(function(btlife)
				tbl10.btlife = btlife

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.playertrail:OnChanged(function(pt)
				tbl10.pt = pt

				if pt then
					tbl3.applypt()
				else
					tbl3.clrpt()
				end
			end)

			toggles.playertrailrainbow:OnChanged(function(ptrb)
				tbl10.ptrb = ptrb

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertrailcolour:OnChanged(function(ptcol)
				tbl10.ptcol = ptcol

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertraillifetime:OnChanged(function(ptlife)
				tbl10.ptlife = ptlife

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertrailwidth:OnChanged(function(ptwidth)
				tbl10.ptwidth = ptwidth

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				task.wait(0.5)

				if tbl10.pt then
					tbl3.applypt()
				end
			end))

			toggles.abilityesp:OnChanged(function(arg)
				if arg then
					tbl3.espstart()
				else
					tbl3.espstop()
				end
			end)

			toggles.fullbright:OnChanged(function(arg)
				tbl3.setbright(arg)
			end)

			toggles.nofog:OnChanged(function(arg)
				tbl3.setnofog(arg)
			end)

			toggles.customfov:OnChanged(function(arg)
				if arg then
					tbl3.startfov()
				else
					tbl3.restorefov()
				end
			end)

			toggles.customgrav:OnChanged(function()
				tbl3.setgrav()
			end)

			options.grav:OnChanged(function()
				if toggles.customgrav.Value then
					tbl3.setgrav()
				end
			end)

			toggles.lowgfx:OnChanged(function(arg)
				tbl3.setlowgfx(arg)
			end)

			toggles.fpscap:OnChanged(function(fpscap)
				tbl10.fpscap = fpscap
				tbl3.applycap()
			end)

			toggles.antilag:OnChanged(function(arg)
				if arg then
					tbl3.startantilag()
				elseif tbl9.alapplied then
					tbl9.alapplied = false

					if not (toggles.lowgfx and toggles.lowgfx.Value) then
						tbl3.setlowgfx(false)
					end
				end
			end)

			options.fpscapvalue:OnChanged(function(fpsval)
				tbl10.fpsval = fpsval

				if tbl10.fpscap then
					tbl3.applycap()
				end
			end)

			toggles.ffenable:OnChanged(function(arg)
				if not arg then
					return
				end
				toggles.ffenable:SetValue(false)

				if tbl3.ffapply() > 0 then
					tbl3.notif("FFlags", "Rejoining to apply your flags.", 3)

					task.delay(1.5, function()
						if fn3 then
							fn3()
						end
					end)
				end
			end)

			options.skybox:OnChanged(function(arg)
				tbl3.applysky(arg)

				if arg == "Default" then
					tbl3.notif("Skybox", "Reset to default.", 2)
				else
					tbl3.notif("Skybox", "Set to \"" .. tostring(arg) .. "\".", 2)
				end
			end)

			options.timeofday:OnChanged(function(arg)
				tbl3.settime(arg)
			end)

			toggles.music:OnChanged(function(music)
				tbl10.music = music
				tbl3.setupmusic()
			end)

			options.musictrack:OnChanged(function(track)
				tbl10.track = track

				if tbl10.music then
					tbl3.setupmusic()
				end
			end)

			options.musicvolume:OnChanged(function(vol)
				tbl10.vol = vol

				if tbl9.musicsound then
					tbl9.musicsound.Volume = clamp(vol / 10, 0, 1)
				end
			end)

			options.musiccustom:OnChanged(function(musicid)
				tbl10.musicid = musicid or ""

				if tbl10.music then
					tbl3.setupmusic()
				end
			end)

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				if toggles.customgrav.Value then
					task.defer(tbl3.setgrav)
				end
			end))

			_G.stagesh = "handlers"
			tbl3.chkfeat()

			tbl3.onstart = {
				{
					flag = "abilityesp",
					run = function()
						tbl3.espstart()
					end,
				},
				{
					flag = "fullbright",
					run = function()
						tbl3.setbright(true)
					end,
				},
				{
					flag = "nofog",
					run = function()
						tbl3.setnofog(true)
					end,
				},
				{
					flag = "customgrav",
					run = function()
						tbl3.setgrav()
					end,
				},
				{
					flag = "lowgfx",
					run = function()
						tbl3.setlowgfx(true)
					end,
				},
				{
					flag = "norender",
					run = function()
						tbl3.setnorender()
					end,
				},
				{
					flag = "thundernocd",
					run = function()
						tbl3.setnocd()
					end,
				},
				{
					flag = "emoteonly",
					run = function()
						if tbl3.emoteonly then
							tbl3.emoteonly(true)
						end
					end,
				},
				{
					flag = "antilag",
					run = function()
						tbl3.startantilag()
					end,
				},
				{ run = function()
					tbl3.applycap()

					if tbl10.fpscap then
						tbl3.notif("FPS Cap", format("FPS capped at %d. Change it in Performance.", tbl10.fpsval or 60), 6)
					end

					if options.skybox.Value and options.skybox.Value ~= "Default" then
						tbl3.applysky(options.skybox.Value)
					end

					if options.timeofday.Value and options.timeofday.Value ~= "Default" then
						tbl3.settime(options.timeofday.Value)
					end
				end },
				{
					flag = "autoparry",
					run = function()
						tbl3.startap()
					end,
				},
				{
					flag = "triggerbot",
					run = function()
						tbl3.starttrigger()

						if tbl10.autoparry then
							tbl10.autoparry = false
							tbl3.stopap()
							toggles.autoparry:SetValue(false)
						end
					end,
				},
				{
					flag = "autospam",
					run = function()
						tbl3.startas()
					end,
				},
				{
					flag = "autobestconfig",
					run = function()
						tbl3.startbestcfg()
					end,
				},
				{
					flag = "manualspam",
					run = function()
						tbl3.startms()
						tbl3.refmsui()
					end,
				},
				{
					flag = "targetlockui",
					run = function()
						tbl3.reftlui()
					end,
				},
				{
					flag = "modeui",
					run = function()
						tbl3.refmodeui()
					end,
				},
				{
					flag = "randomtarget",
					run = function()
						tbl9.lastrand = 0
						tbl3.startrt()
					end,
				},
				{ run = function()
					if toggles.autoability.Value or toggles.cooldownprotection.Value then
						tbl3.startabil()
					end
				end },
				{
					flag = "staffdetection",
					run = function()
						tbl3.startstaff()
					end,
				},
				{
					flag = "visualizer",
					run = function()
						tbl3.setupviz()
					end,
				},
				{
					flag = "balltrail",
					run = function()
						tbl3.applybt()
					end,
				},
				{
					flag = "playertrail",
					run = function()
						tbl3.applypt()
					end,
				},
				{ run = function()
					if (toggles.headless.Value or toggles.korblox.Value) and tbl3.applycos then
						tbl3.applycos()
					end
				end },
				{
					flag = "antiafk",
					run = function()
						tbl3.startafk()
					end,
				},
				{
					flag = "autoexecute",
					run = function()
						tbl3.queuetp()
					end,
				},
				{
					flag = "viptag",
					run = function()
						tbl3.applyvip()
					end,
				},
				{
					flag = "shaders",
					run = function()
						tbl3.applyshade()
					end,
				},
				{
					flag = "raineffect",
					run = function()
						tbl3.applyrain()
					end,
				},
				{
					flag = "music",
					run = function()
						tbl3.setupmusic()
					end,
				},
				{ run = function()
					if tbl10.devscreen and tbl10.devscreen ~= "Off" then
						tbl3.devui(tbl10.devscreen, true)
					end

					if tbl10.devtype and tbl10.devtype ~= "Off" then
						tbl3.devarm(tbl10.devtype, true)
					end

					tbl3.devstat()
				end },
				{ run = function()
					if toggles.unlockall and toggles.unlockall.Value and fn9 then
						fn9()
					elseif toggles.equipautoload and toggles.equipautoload.Value and fn11 then
						fn11(false)
					end
				end },
			}

			local tbl20 = {}

			for _, v6 in ipairs(tbl3.onstart) do
				if v6.flag and not toggles[v6.flag] then
					tbl20[#tbl20 + 1] = v6.flag
				end
			end

			if #tbl20 > 0 then
				table.sort(tbl20)
				warn("[Rise] startup list points at toggles that do not exist: " .. table.concat(tbl20, ", "))
			end

			tbl3.bootstrap_saved_connections = function()
				tbl3.syncopt()
				tbl3.sendping()
				tbl3.ffload()

				if options.uiaccent then
					tbl3.setaccent(options.uiaccent.Value)
				end

				if toggles.customfov.Value then
					tbl3.startfov()
				end

				tbl3.startdatapanel()
				tbl3.bindt(task.spawn(tbl3.claimdaily))

				for _, v6 in ipairs(tbl3.onstart) do
					local flag2 = v6.flag and toggles[v6.flag]

					if not v6.flag or flag2 and flag2.Value then
						v6.run()
					end
				end
			end

			tbl3.loadsave()
			v2:LoadAutoloadConfig()
			tbl3.hooksave()
			_G.stagesh = "config"

			task.spawn(function()
				task.wait(0.2)
				tbl3.bootstrap_saved_connections()
			end)

			_G.stagesh = "boot"
			local Replion = require(ReplicatedStorage.Packages.Replion)
			local misc = ReplicatedStorage:FindFirstChild("Misc")
			local v6 = nil
			local client = nil
			local v7 = nil
			local v8 = nil
			local v9 = nil
			local v10 = nil
			local swords = nil
			local function fn12()if setthreadidentity then setthreadidentity(8);end;end
			local function fn13(l)if not l then return nil;end; fn12 ();return require(l);end
			local function fn14(h,...)local l=h;for h=1,select("#",...),1 do if typeof(l)~="Instance"then return nil;end;l=(l:FindFirstChild((select(h,...))));end;return l;end

			local tbl21 = {
				wheelfile = "Rise_Wheel_" .. tostring(game.GameId) .. ".json",
				wheel = {},
				equipfile = "Rise_Equip_" .. tostring(game.GameId) .. ".json",
				equip = {},
				ncfile = "Rise_UnlockNames_" .. tostring(game.GameId) .. ".json",
				hooked = false,
				guihooked = false,
				explhooked = false,
				trove = nil,
				noacc = false,
				explname = nil,
				offconns = {},
				lost = true,
			}

			local fn15 = nil

			local function fn16(arg)
				if not Replion then
					Replion = fn13(fn14(ReplicatedStorage, "Packages", "Replion"))
				end

				if not Replion then
					tbl3.logwev("uaReplion", 10, "UnlockAll", "Replion module unavailable (require failed)")
					return nil
				end
				local replion = Replion.Client:GetReplion(arg)
				if replion then
					return replion
				end
				local n3 = clock() + 5

				while clock() < n3 do
					task.wait(0.1)
					local replion2 = Replion.Client:GetReplion(arg)
					if replion2 then
						return replion2
					end
				end

				return nil
			end

			local tbl22 = {}
			local v11 = nil
			local v12 = nil

			local function fn17(arg)
				if not v12 then
					local collection = type(v11) == "table" and type(v11.GetCollection) == "function" and v11:GetCollection() or nil

					if type(collection) == "table" and next(collection) then
						v12 = collection
					end
				end

				return v12 and v12[arg] or nil
			end

			local function fn18(arg, arg2)
				if arg ~= "Sword" then
					return { Name = arg2, Id = arg2 }
				end
				local sword = tbl22[arg2]

				if sword == nil then
					sword = swords and swords.GetSword and swords:GetSword(arg2) or false
					tbl22[arg2] = sword
				end

				local tbl23 = { Name = arg2, Id = arg2 }

				if type(sword) == "table" then
					if sword.HasFinisher then
						tbl23.Finisher = true
					end

					if sword.AccessoryUnlockable and fn17(arg2) then
						tbl23.Accessory = true
					end
				end

				return tbl23
			end

			local function fn19(arg, arg2)
				if client and client.ItemToKey then
					local v13 = client:ItemToKey(arg, fn18(arg, arg2), { "Id" })
					if type(v13) == "string" then
						return v13
					end
				end

				return HttpService:JSONEncode({ { "Name", arg2 } }) or arg2
			end

			local function fn20(arg, arg2)
				if type(arg) ~= "string" then
					return tostring(arg)
				end

				if client and client.KeyToItem then
					local v13 = client:KeyToItem(arg)
					if type(v13) == "table" and v13.Name then
						return v13.Name
					end
				end

				local str2 = arg:sub(1, 1)

				if str2 == "[" or str2 == "{" then
					local data = HttpService:JSONDecode(arg)

					if type(data) == "table" then
						for _, v13 in ipairs(data) do
							if v13[1] == "Name" then
								return v13[2]
							end
						end

						if data.Name then
							return data.Name
						end
					end
				end

				if arg2 and Replion and Replion.Client then
					local replion = Replion.Client:GetReplion("Inventory")
					replion = replion and replion:Get({ "Inventory", arg2, arg })
					if type(replion) == "table" and replion.Name then
						return replion.Name
					end
				end

				return arg
			end

			local function fn21(arg)
				local tbl23 = {}
				local v13 = misc and misc:FindFirstChild(arg)

				if v13 then
					for _, child in ipairs(v13:GetChildren()) do
						tbl23[#tbl23 + 1] = child.Name
					end
				end

				return tbl23
			end

			local function fn22()
				local tbl23 = {}

				if swords and swords.GetCollection then
					local collection = swords:GetCollection()

					if type(collection) == "table" then
						for k in pairs(collection) do
							tbl23[#tbl23 + 1] = k
						end
					end
				end

				return tbl23
			end

			local function fn23(arg, arg2)
				local character = localPlayer.Character
				if arg ~= nil then
					return arg == localPlayer or arg == character
				end
				return arg2 ~= nil and arg2 == character
			end

			local function fn24()
				if tbl21.explhooked then
					return
				end
				local v13 = fn13(fn14(ReplicatedStorage, "Controllers", "VFXController"))
				if type(v13) ~= "table" or type(v13.PlayExplosion) ~= "function" then
					return
				end
				tbl21.explmod = v13
				tbl21.explorig = v13.PlayExplosion
				v13.PlayExplosion = function(l,K,p,E,k,a,d,...)local I= tbl21 .explname and  tbl21 .explname~=""and  tbl21 .explname~=K;return  tbl21 .explorig(l,if I and( fn23 (a,k))then  tbl21 .explname else K,p,E,k,a,d,...);end
				tbl21.explhooked = true
			end

			local function fn25(arg, arg2)
				local Inventory = fn16("Inventory")
				if not (Inventory and type(Inventory._set) == "function") then
					return
				end
				Inventory:_set({ "Equipped", arg }, { Name = arg2, Id = fn19(arg, arg2) })
			end

			local function fn26(arg, arg2)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return
				end
				local v13 = fn19(arg, arg2)

				if type(Inventory._update) == "function" then
					Inventory:_update({ "Inventory", arg }, { [v13] = fn18(arg, arg2) })
				elseif type(Inventory._set) == "function" then
					local v14 = Inventory:Get({ "Inventory", arg })
					local tbl23 = {}

					if type(v14) == "table" then
						for k, v15 in pairs(v14) do
							tbl23[k] = v15
						end
					end

					tbl23[v13] = fn18(arg, arg2)
					Inventory:_set({ "Inventory", arg }, tbl23)
				end
			end

			tbl21.verifyeq = function(arg, arg2)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return false
				end
				local v13 = Inventory:Get({ "Equipped", arg })
				return type(v13) == "table" and v13.Name == arg2
			end

			tbl21.ensureeq = function(arg, arg2)
				tbl21.eqlatest = tbl21.eqlatest or {}
				tbl21.eqlatest[arg] = arg2

				tbl3.bindt(task.spawn(function()
					for i = 1, 4 do
						if tbl21.eqlatest[arg] ~= arg2 then
							return
						end

						if tbl21.verifyeq(arg, arg2) then
							return
						end
						task.wait(0.35)
						if tbl21.eqlatest[arg] ~= arg2 then
							return
						end
						fn26(arg, arg2)
						fn25(arg, arg2)
					end
				end))
			end

			local function fn27(arg, swname, arg2)
				if not swname or swname == "" then
					return
				end

				if arg == "Sword" then
					tbl10.swskin = true
					tbl10.swname = swname
					tbl21.skinmine = true
					tbl3.initsword()
					tbl3.hookslash()
					tbl3.skinloop()

					if tbl3.applysword() == false then
						tbl10.swskin = false
						tbl10.swname = ""
						return
					end

					tbl3.setswattr(swname)
					fn26("Sword", swname)
					fn25("Sword", swname)
					tbl21.ensureeq("Sword", swname)

					if tbl21.finequip then
						tbl21.finequip(swname)
					end
				elseif arg == "Explosion" then
					tbl21.explname = swname
					fn24()

					if tbl21.prefetch then
						tbl21.prefetch("Explosions", swname)
					end

					fn26("Explosion", swname)
					fn25("Explosion", swname)
					tbl21.ensureeq("Explosion", swname)
				elseif arg == "Emote" then
					fn26("Emote", swname)
				end

				if not arg2 and (arg == "Sword" or arg == "Explosion") then
					tbl21.equip[arg] = swname

					if fn15 then
						fn15()
					end
				end
			end

			tbl21.cursword = function()local l= tbl10 .swname;return if not l or l==""then( tbl3 .swequipped())else l;end

			tbl3.uaawaken = function()
				tbl21.arm()
				local v13 = tbl21.cursword()
				if not v13 or v13 == "" then
					return
				end
				swords = swords or tbl3.initsword()
				if not swords then
					tbl3.notif("Unlock All", "Swords aren't ready yet. Try again in a second.", 4)
					return
				end
				local str2 = "Awakened " .. v13

				if swords:GetSword(str2) ~= nil then
					fn27("Sword", str2)
					tbl3.notif("Unlock All", "Equipped \"" .. str2 .. "\".", 3)
				else
					tbl3.notif("Unlock All", v13 .. " has no awakened version.", 3)
				end
			end

			tbl3.uaequipall = function()
				tbl21.arm()

				for _, v13 in ipairs({ "Sword", "Explosion" }) do
					local v14 = tbl21.equip[v13]

					if type(v14) == "string" and v14 ~= "" then
						fn27(v13, v14, true)
					end
				end

				if tbl21.wheel then
					for _, v13 in pairs(tbl21.wheel) do
						if type(v13) == "string" and v13 ~= "" then
							fn26("Emote", v13)
						end
					end
				end

				tbl3.notif("Unlock All", "Your saved loadout is equipped.", 3)
			end

			tbl3.uapreviewfin = function()
				if tbl21.finbusy then
					return
				end
				local v13 = tbl21.finfor(tbl21.cursword())

				if not v13 and options.swordchangername then
					v13 = tbl21.finfor(options.swordchangername.Value)
				end

				if not v13 then
					tbl3.notif("Finisher", "That sword has no finisher.", 4)
					return
				end

				if tbl3.isalive() then
					tbl3.notif("Finisher", "Preview only works in the lobby, not mid-round.", 5)
					return
				end
				local v14 = tbl21.finctrl()
				if not v14 or type(v14.Preview) ~= "function" then
					tbl3.notif("Finisher", "Finishers aren't loaded yet. Try again in a second.", 5)
					return
				end
				local featuresToggle = fn14(ReplicatedStorage, "FeaturesToggle", "LimitedSwords")
				if featuresToggle and featuresToggle.Value == false then
					tbl3.notif("Finisher", "The game has showrooms turned off right now.", 5)
					return
				end
				tbl21.finbusy = true

				tbl3.bindt(task.spawn(function()
					if not tbl21.repasset("Finishers", v13) then
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("Couldn't load the %s finisher."):format(v13), 5)
						return
					end

					if not tbl21.finplayable(v13) then
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher isn't loaded yet."):format(v13), 5)
						return
					end

					tbl3.bindt(task.delay(tbl21.findur(v13) + 2, function()
						tbl21.finbusy = false
					end))

					v14:Preview(v13)

					if setthreadidentity and tbl3.baseident then
						setthreadidentity(tbl3.baseident)
					end
				end))
			end

			tbl21.applyacc = function()
				tbl9.noacc = tbl21.noacc
				localPlayer:SetAttribute("ShowSwordAccessory", not tbl21.noacc)
				local swname = tbl10.swname
				local v13 = tbl3.safechar()
				if not (swname and swname ~= "" and v13 and swords) or tbl9.swbad[swname] then
					return
				end

				tbl3.bindt(task.spawn(function()
					if type(swords.GetInstance) == "function" then
						if not swords:GetInstance(swname) then
							tbl9.swbad[swname] = true
							return
						end
					end

					if not v13.Parent then
						return
					end

					for _, child in ipairs(v13:GetChildren()) do
						if child:IsA("Model") and swords:GetSword(child.Name) then
							child:Destroy()
						end
					end

					tbl3.equipsword(v13, swname, tbl21.noacc, true)

					if tbl9.swctrl and tbl9.swctrl.SetSword then
						tbl9.swctrl:SetSword(swname)
					end
				end))
			end

			local function fn28()
				if tbl21.snapping then
					return false
				end
				tbl21.snapping = true
				local Inventory = fn16("Inventory")
				local owned = { Sword = {}, Explosion = {}, Emote = {} }
				local flag2 = false

				if Inventory then
					for _, v13 in ipairs({ "Sword", "Explosion", "Emote" }) do
						local v14 = Inventory:Get({ "Inventory", v13 })

						if type(v14) == "table" then
							for _, v15 in pairs(v14) do
								if type(v15) == "table" and v15.Name then
									owned[v13][v15.Name] = true
								end
							end
						end
					end

					flag2 = true
				end

				tbl21.snapping = false
				if not flag2 then
					return false
				end
				tbl21.owned = owned
				tbl21.ownedat = clock()
				return true
			end

			local function fn29(arg, arg2)
				if not arg or not arg2 then
					return false
				end

				if not tbl21.owned then
					tbl3.bindt(task.spawn(fn28))
					return false
				end
				local flag2 = not tbl21.everunlocked

				if flag2 then
					flag2 = clock() - (tbl21.ownedat or 0) > 5
				end

				if flag2 then
					tbl3.bindt(task.spawn(fn28))
				end

				return tbl21.owned[arg] and tbl21.owned[arg][arg2] == true or false
			end

			local function fn30()
				if tbl21.everunlocked then
					return
				end

				if not tbl21.owned and not fn28() then
					return
				end
				tbl21.everunlocked = true
			end

			local function fn31(arg)
				if not arg or arg.done then
					return
				end
				arg.done = true

				for _, v13 in ipairs(arg) do
					rawset(v13.sig, "_handlerListHead", v13.head)
				end
			end

			local function fn32(arg, arg2)
				local value = arg._signals and rawget(arg._signals, "_containers")
				value = value and value.onChange
				value = value and value.Inventory
				if not value then
					return nil
				end
				local tbl23 = {}

				for _, v13 in ipairs(arg2) do
					local v14 = value[v13]
					local value2 = v14 and rawget(v14, "__signal")
					local value3 = value2 and rawget(value2, "_handlerListHead")

					if value3 ~= nil and value3 ~= false then
						tbl23[#tbl23 + 1] = { sig = value2, head = value3 }
						rawset(value2, "_handlerListHead", false)
					end
				end

				if #tbl23 == 0 then
					return nil
				end
				tbl3.bindt(task.defer(fn31, tbl23))
				return tbl23
			end

			local function fn33(arg)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return false
				end
				local tbl23 = {}
				local tbl24 = {}
				local flag2 = type(Inventory._update) == "function"
				local flag3 = false

				for k, v13 in pairs(arg) do
					local v14 = Inventory:Get({ "Inventory", k })
					local tbl25 = {}

					if type(v14) == "table" then
						for k2, v15 in pairs(v14) do
							tbl25[k2] = v15
						end
					end

					local owned = tbl21.owned and tbl21.owned[k] or {}
					local v15 = nil
					local v16 = nil
					local n3 = 0

					for _, v17 in ipairs(v13) do
						local v18 = fn19(k, v17)

						if tbl25[v18] == nil and not owned[v17] then
							local v19 = fn18(k, v17)

							if flag2 and not v15 then
								v15 = v18
								v16 = v19
							else
								tbl25[v18] = v19
							end

							n3 += 1
						end
					end

					if n3 > 0 then
						tbl23[k] = tbl25
						flag3 = true

						if v15 then
							tbl24[#tbl24 + 1] = { k, v15, v16 }
						end
					end
				end

				if not flag3 then
					return true
				end
				local tbl25 = {}

				for k in pairs(tbl23) do
					tbl25[#tbl25 + 1] = k
				end

				local v13 = fn32(Inventory, tbl25)
				local flag4

				if flag2 then
					Inventory:_update({ "Inventory" }, tbl23)
					flag4 = true
				else
					flag4 = false

					if type(Inventory._set) == "function" then
						for k, v14 in pairs(tbl23) do
							Inventory:_set({ "Inventory", k }, v14)
						end

						flag4 = true
					end
				end

				fn31(v13)

				if flag4 then
					for _, v14 in ipairs(tbl24) do
						Inventory:_update({ "Inventory", v14[1] }, { [v14[2]] = v14[3] })
					end
				end

				return flag4
			end

			local function fn34(arg, arg2)
				local tbl23 = {}
				local tbl24 = {}
				local v13 = ipairs
				arg = arg or {}

				for _, v14 in v13(arg) do
					if type(v14) == "string" and not tbl23[v14] then
						tbl23[v14] = true
						tbl24[#tbl24 + 1] = v14
					end
				end

				local v14 = ipairs
				local tbl25 = arg2 or {}

				for _, v15 in v14(tbl25) do
					if type(v15) == "string" and not tbl23[v15] then
						tbl23[v15] = true
						tbl24[#tbl24 + 1] = v15
					end
				end

				return tbl24
			end

			local function fn35(arg)
				if not (isfile and readfile and isfile(arg)) then
					return nil
				end
				local v13 = readfile(arg)
				if type(v13) ~= "string" then
					return nil
				end
				local match = v13:match("^%s*(.-)%s*$")
				local str2 = match:sub(1, 1)
				local str3 = match:sub(-1)
				if not (str2 == "{" and str3 == "}" or str2 == "[" and str3 == "]") then
					return nil
				end
				return HttpService:JSONDecode(match)
			end

			local function fn36()
				if tbl21.ncloaded then
					return
				end
				tbl21.ncloaded = true
				local v13 = fn35(tbl21.ncfile)

				if type(v13) == "table" then
					if type(v13.Sword) == "table" and #v13.Sword > 0 then
						tbl21.swnames = v13.Sword
					end

					if type(v13.Explosion) == "table" and #v13.Explosion > 0 then
						tbl21.explnames = v13.Explosion
					end

					if type(v13.Emote) == "table" and #v13.Emote > 0 then
						tbl21.emonames = v13.Emote
					end
				end
			end

			local function fn37()
				if not writefile then
					return
				end
				writefile(tbl21.ncfile, HttpService:JSONEncode({ Sword = tbl21.swnames or {}, Explosion = tbl21.explnames or {}, Emote = tbl21.emonames or {} }))
			end

			local function fn38()
				local v13 = fn22()
				local flag2 = false

				if #v13 > 0 then
					tbl21.swnames = fn34(tbl21.swnames, v13)
					flag2 = true
				end

				local DataExplosions = fn21("DataExplosions")

				if #DataExplosions > 0 then
					tbl21.explnames = fn34(tbl21.explnames, DataExplosions)
					flag2 = true
				end

				local Emotes = fn21("Emotes")

				if #Emotes > 0 then
					tbl21.emonames = fn34(tbl21.emonames, Emotes)
					flag2 = true
				end

				if flag2 then
					fn37()
				end

				return flag2
			end

			local function fn39()
				if tbl21.warmed then
					return
				end
				fn36()
				v6 = v6 or fn13(ReplicatedStorage.Shared.Inventory)
				client = client or v6 and v6.Client
				v7 = v7 or fn13(ReplicatedStorage.Controllers.UI.ShopControllerAPI)
				v8 = v8 or fn13(ReplicatedStorage.Controllers.EmoteController)
				v9 = v9 or fn13(ReplicatedStorage.Shared.EmotesShared)
				v10 = v10 or fn13(ReplicatedStorage.Packages.Trove)
				tbl3.initsword()
				swords = tbl9.swords
				v11 = v11 or fn13(fn14(ReplicatedStorage, "Shared", "ReplicatedInstances", "SwordAccessories"))
				fn38()

				if localPlayer:GetAttribute("ShowSwordAccessory") == nil then
					localPlayer:SetAttribute("ShowSwordAccessory", not tbl21.noacc)
				end

				tbl21.warmed = true
			end

			local function fn40()
				if tbl21.injected then
					return
				end
				tbl21.injected = true

				if not fn16("Inventory") then
					tbl21.failed = true
					tbl3.logwev("uaInject", 5, "UnlockAll", "Inventory Replion unavailable - injection skipped")
					return
				end

				tbl21.failed = false

				if not tbl21.owned then
					fn28()
				end

				fn36()
				local flag2 = tbl21.swnames and #tbl21.swnames > 0 or tbl21.explnames and #tbl21.explnames > 0
				local flag3

				if flag2 then
					flag3 = flag2
				else
					flag3 = tbl21.emonames and #tbl21.emonames > 0
				end

				if not flag3 then
					fn38()
				end

				if not fn33({
					Sword = tbl21.swnames or fn22(),
					Explosion = tbl21.explnames or fn21("DataExplosions"),
					Emote = tbl21.emonames or fn21("Emotes"),
				}) then
					tbl21.failed = true
					tbl3.logwev("uaInject", 5, "UnlockAll", "Replion has no _update or _set - nothing injected")
				end
			end

			local function fn41()if  v10 then local l= v10 .new();if l then return l;end;end;local h={};return{Add=function(l,l)h[#h+1]=l;return l;end,Clean=function()for l,l in ipairs(h)do if typeof(l)=="Instance"then l:Destroy();elseif typeof(l)=="thread"then task.cancel(l);elseif typeof(l)=="RBXScriptConnection"then l:Disconnect();elseif type(l)=="function"then l();end;end;table.clear(h);end};end

			local tbl23 = {
				Emote915 = { id = "rbxassetid://121746225545509", delay = 0.65 },
				Emote1017 = { id = "rbxassetid://122138306164149", delay = 0 },
				Emote1052 = { id = "rbxassetid://86553108866816", delay = 0 },
				Emote1167 = { id = "rbxassetid://78966882139691", delay = 0 },
				Emote1185 = { id = "rbxassetid://73110745626575", delay = 0 },
				Emote1217 = { id = "rbxassetid://107342460864353", delay = 3.3333333333333335 },
			}

			local function fn42(l,K,p)local E=K:FindFirstChild("HumanoidRootPart")or K.PrimaryPart;if not E then return false;end;local k=false;local a={};local d=nil;d=function(I,C)if a[I]then return;end;a[I]=true;if  tbl21 .activeemo~=l then return;end;local a=I:Clone();a.Parent=E;p:Add(a);local function I()if  tbl21 .activeemo==l and a.Parent then a:Play();end;end;if C and C>0 then p:Add(task.delay(C,I));else I();end;k=true;end;local function a(I)if typeof(I)~="Instance"then return;end;for C,U in ipairs(I:GetDescendants())do if U:IsA("Sound")then C=U:FindFirstAncestorWhichIsA("Folder");d(U,(tonumber(C and(C:GetAttribute("EnableFrame")))or 0)/60);end;end;end;K= fn13 ( ReplicatedStorage .Shared.ReplicatedInstances.EmoteVFX);if K and K.GetInstance then a(K:GetInstance(l));end;K= fn13 ( ReplicatedStorage .Shared.ReplicatedInstances.EmoteAccessories);if K and K.GetInstance then a(K:GetInstance(l));end;K= ReplicatedStorage :FindFirstChild("Misc");local d=K and(K:FindFirstChild("Emotes"));a(d and(d:FindFirstChild(l)));if not k then d= tbl23 [l];if d and  tbl21 .activeemo==l then local K=Instance.new("Sound");K.Name="RiseEmoteSound";K.SoundId=d.id;K.Looped=true;K.Volume=1;K.RollOffMode=Enum.RollOffMode.InverseTapered;K.RollOffMaxDistance=500;K.Parent=E;p:Add(K);if d.delay>0 then p:Add(task.delay(d.delay,function()if  tbl21 .activeemo==l and K.Parent then K:Play();end;end));else K:Play();end;k=true;end;end;return k;end
			local function fn43(l)if not( toggles .emotewalk and  toggles .emotewalk.Value)then return;end; tbl3 .bindt(task.delay(0.12,function()if  tbl3 .ewapply then  tbl3 .ewapply();end;local h=l and(l:FindFirstChildOfClass("Humanoid"));if h and h.WalkSpeed<1 then h.WalkSpeed=h:GetAttribute("OLD_WS")or 32;end;end));end
			local function fn44(h)local l=h:FindFirstChildOfClass("Humanoid");h=l and(l:FindFirstChildOfClass("Animator"));if not h then return 0;end;l=h:GetPlayingAnimationTracks();return type(l)=="table"and#l or 0;end
			local function fn45()if  toggles .emotewalk and  toggles .emotewalk.Value then return false;end;local l= tbl3 .safehum();return l~=nil and l.MoveDirection.Magnitude>0.1;end
			local function fn46(l)local K= tbl3 .safechar();if not K then return;end;if  fn45 ()then return;end; tbl21 .activeemo=l; tbl21 .emostart= clock ();if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end;if  v9 and  v9 .Play and  v10 then local p= v10 .new(); tbl21 .trove=p;local E= fn44 (K); v9 :Play(K,p,l,true, Workspace :GetServerTimeNow());if  tbl21 .trove~=p or  tbl21 .activeemo~=l then return;end;if  fn44 (K)>E then  fn43 (K);return;end; tbl3 .logwev("emoteQuiet:"..tostring(l),5,("EmotesShared:Play returned without animating %s - using animation+sound fallback"):format(tostring(l)));p:Clean(); tbl21 .trove=nil;end;if  v8 and  v8 ._playAnimation then  v8 :_playAnimation(l);end;local p= fn41 (); tbl21 .trove=p;task.spawn(function() fn42 (l,K,p);end); fn43 (K);end

			local function fn47(arg, arg2)
				local Inventory = fn16("Inventory")

				if Inventory and type(Inventory._set) == "function" then
					local set = Inventory._set
					local tbl24 = {}
					local v13 = tostring
					local n3 = tonumber(arg2) or 1
					local v14 = table.pack(v13(n3))
					tbl24[1] = "EquippedList"
					tbl24[2] = "Emote"

					do
						local values = table.pack(table.unpack(v14, 1, v14.n))
						table.move(values, 1, values.n, 3, tbl24)
					end

					set(Inventory, tbl24, { Name = arg, Id = fn19("Emote", arg) })
				end
			end

			local function fn48()
				if not writefile then
					return
				end
				writefile(tbl21.wheelfile, HttpService:JSONEncode(tbl21.wheel))
			end

			fn15 = function()
				if not writefile then
					return
				end
				writefile(tbl21.equipfile, HttpService:JSONEncode(tbl21.equip))
			end

			local function fn49()
				local v13 = fn35(tbl21.equipfile)

				if type(v13) == "table" then
					tbl21.equip = v13
				end
			end

			local function fn50()
				local v13 = fn35(tbl21.wheelfile)

				if type(v13) == "table" then
					tbl21.wheel = v13
				end

				for k, v14 in pairs(tbl21.wheel) do
					fn47(v14, k)
				end
			end

			local function fn51(arg, arg2)
				local n3 = tonumber(arg2) or 1
				fn47(arg, n3)
				tbl21.wheel[tostring(n3)] = arg
				fn48()
			end

			local function fn52(arg, arg2, arg3)
				local v13 = arg[arg2]
				if type(v13) ~= "function" then
					return nil
				end
				arg[arg2] = arg3
				if arg[arg2] == arg3 then
					return v13
				end
				return nil
			end

			tbl21.repmod = {}
			tbl21.repwarm = {}
			local function repasset(l,K)if  tbl21 .repmod[l]==nil then  tbl21 .repmod[l]= fn13 ( fn14 ( ReplicatedStorage ,"Shared","ReplicatedInstances",l))or false;end;local p= tbl21 .repmod[l];if not p or type(p.GetInstance)~="function"then return nil;end;return p:GetInstance(K)or nil;end
			tbl21.repasset = repasset
			tbl21.reptry = {}
			tbl21.prefetch = function(l,K)if not K or K==""then return;end;local p=l.."/"..K;if  tbl21 .repwarm[p]then return;end;local E=( tbl21 .reptry[p]or 0)+1;if E>2 then return;end; tbl21 .reptry[p]=E; tbl21 .repwarm[p]=true; tbl3 .bindt(task.spawn(function()if not  repasset (l,K)then  tbl21 .repwarm[p]=nil;end;end));end
			tbl21.finctrl = function()if  tbl21 .fcmod==nil then  tbl21 .fcmod= fn13 ( fn14 ( ReplicatedStorage ,"Controllers","FinishersController"))or false;end;return  tbl21 .fcmod or nil;end
			tbl21.finfor = function(l)if type(l)~="string"or l==""then return nil;end;local K= tbl21 .finctrl();if K and type(K._finishers)=="table"then return K._finishers[l]and l or nil;end;K= misc and( misc :FindFirstChild("DataFinishers"));if K and(K:FindFirstChild(l))then return l;end;return nil;end

			tbl21.finplayable = function(arg)
				local v13 = tbl21.finctrl()
				return v13 ~= nil and type(v13._finishers) == "table" and v13._finishers[arg] ~= nil
			end

			tbl21.realfin = function(arg)
				local replion = Replion and Replion.Client and Replion.Client:GetReplion("Inventory")
				replion = replion and replion:Get({ "Inventory", "Sword" })
				if type(replion) ~= "table" then
					return false
				end

				for _, v13 in pairs(replion) do
					if type(v13) == "table" and v13.Name == arg and v13.Finisher == true and v13.CreatedAt ~= nil then
						return true
					end
				end

				return false
			end

			tbl21.finequip = function(arg)
				local v13 = tbl21.finfor(arg)
				if not v13 then
					return nil
				end
				tbl21.prefetch("Finishers", v13)
				local Data = fn16("Data")

				if Data then
					local Unlocked = Data:Get("Finishers.Unlocked")
					local tbl24 = {}
					local flag2 = false

					if type(Unlocked) == "table" then
						local v14, v15, v16 = ipairs(Unlocked)
						local flag3 = false

						for _, v17 in v14, v15, v16 do
							tbl24[#tbl24 + 1] = v17

							if v17 == v13 then
								flag3 = true
							end
						end

						flag2 = flag3
					end

					if not flag2 and type(Data._set) == "function" then
						tbl24[#tbl24 + 1] = v13
						Data:_set({ "Finishers", "Unlocked" }, tbl24)
					end

					if type(Data._update) == "function" and Data:Get({ "Finishers", "Equipped", v13 }) ~= true then
						Data:_update({ "Finishers", "Equipped" }, { [v13] = true })
					end
				end

				tbl21.finreq = tbl21.finreq or {}

				if v7 and type(v7.RequestFinisherEquip) == "function" and not tbl21.finreq[v13] and tbl21.realfin(v13) then
					tbl21.finreq[v13] = true

					tbl3.bindt(task.spawn(function()
						v7:RequestFinisherEquip({ Name = v13 })
					end))
				end

				return v13
			end

			tbl21.finhookup = function()
				if tbl21.finhooked then
					return
				end
				local v13 = tbl21.finctrl()
				if not v13 or type(v13.PlayFinisher) ~= "function" then
					return
				end
				tbl21.finorig = fn52(v13, "PlayFinisher", function(l,K,...) tbl21 .finlast= clock ();return  tbl21 .finorig(l,K,...);end)
				tbl21.finhooked = tbl21.finorig ~= nil
			end

			tbl21.findur = function(arg)
				local dataFinishers = misc and misc:FindFirstChild("DataFinishers")
				dataFinishers = dataFinishers and dataFinishers:FindFirstChild(arg)
				local attribute = dataFinishers and dataFinishers:GetAttribute("Duration")
				return type(attribute) == "number" and attribute or 6
			end

			tbl21.finhide = function(arg, arg2)
				if not arg then
					return
				end

				for _, descendant in ipairs(arg:GetDescendants()) do
					if descendant:IsA("BasePart") or descendant:IsA("Decal") then
						descendant.LocalTransparencyModifier = arg2 and 1 or 0
					elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("BillboardGui") then
						if arg2 then
							if descendant.Enabled then
								descendant:SetAttribute("__uaEmit", true)
								descendant.Enabled = false
							end
						elseif descendant:GetAttribute("__uaEmit") then
							descendant:SetAttribute("__uaEmit", nil)
							descendant.Enabled = true
						end
					end
				end
			end

			tbl21.finclone = function(h)local l=h.Archivable;h.Archivable=true;local K=h:Clone();h.Archivable=l;if not K then return nil;end;l=K:FindFirstChildOfClass("Humanoid");if not(l and(K:FindFirstChild("HumanoidRootPart")))then K:Destroy();return nil;end;for h,h in ipairs(K:GetDescendants())do if h:IsA("BaseScript")then h:Destroy();elseif h:IsA("BasePart")then h.CanCollide=false;h.CanQuery=false;h.Massless=true;h.LocalTransparencyModifier=0;if(h.Parent==K and h.Name~="HumanoidRootPart"or h.Name=="Handle"and(h.Parent:IsA("Accessory")))and h.Transparency>=1 then h.Transparency=0;end;elseif h:IsA("Decal")then h.Transparency=0;end;end;if l.MaxHealth<=0 then l.MaxHealth=100;end;l.Health=l.MaxHealth;l.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None;if not l:FindFirstChildOfClass("Animator")then Instance.new("Animator").Parent=l;end;K:SetAttribute("Dead",nil);return K;end

			tbl21.winfin = function(arg)
				if tbl21.finbusy then
					return
				end

				if not (tbl10.unlockall or tbl10.autoload or tbl10.swskin) then
					return
				end
				local v13 = tbl21.finfor(tbl21.cursword())
				if not v13 then
					return
				end
				local v14 = tbl21.findur(v13)
				local v15 = tbl3.safechar()
				local humanoidRootPart = v15 and v15:FindFirstChild("HumanoidRootPart")
				local flag2 = tbl21.prey ~= nil and tbl21.preyfor == arg

				if not (humanoidRootPart and arg and (flag2 or arg.Parent)) then
					flag2 = flag2 and tbl21.dropprey

					if flag2 then
						tbl21.dropprey()
					end

					return
				end

				tbl21.finhookup()
				tbl21.finbusy = true
				local v16 = clock()
				local prey

				if flag2 then
					prey = tbl21.prey
					tbl21.prey = nil
					tbl21.preyfor = nil
				else
					prey = tbl21.finclone(arg)
				end

				if not prey then
					tbl21.finbusy = false
					tbl3.notif("Finisher", "Couldn't copy your opponent, so the finisher was skipped.", 5)
					return
				end

				prey.Parent = Workspace

				tbl3.bindt(task.delay(0.1, function()
					local v17 = tbl21.finctrl()

					if (tbl21.finlast or 0) > v16 or not v17 or not v15.Parent then
						prey:Destroy()
						tbl21.finbusy = false
						return
					end

					if not tbl21.repasset("Finishers", v13) then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("Couldn't load the %s finisher."):format(v13), 5)
						return
					end

					if clock() - v16 > 3 then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher loaded too late. The next win should play it."):format(v13), 6)
						return
					end

					local v18 = tbl21.finclone(v15)

					if not v18 then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", "Couldn't copy your character, so the finisher was skipped.", 5)
						return
					end

					if not tbl21.finplayable(v13) then
						prey:Destroy()
						v18:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher isn't loaded yet."):format(v13), 5)
						return
					end

					v18.Parent = Workspace
					tbl21.finhide(v15, true)
					local finshow = nil

					finshow = function()
						if tbl21.finshow ~= finshow then
							return
						end
						tbl21.finshow = nil
						prey:Destroy()
						v18:Destroy()
						tbl21.finhide(v15, false)
						tbl21.finbusy = false
					end

					tbl21.finshow = finshow
					tbl3.bindt(task.delay(v14 + 2, finshow))
					local position = humanoidRootPart.Position
					local lookVector = humanoidRootPart.CFrame.LookVector
					local getServerTimeNow = Workspace.GetServerTimeNow
					v17:PlayFinisher(v13, v18, prey, CFrame.new(position, position + Vector3.new(lookVector.X, 0, lookVector.Z)), getServerTimeNow(Workspace))

					if setthreadidentity and tbl3.baseident then
						setthreadidentity(tbl3.baseident)
					end
				end))
			end

			local function fn53()
				if tbl21.hooked then
					return
				end
				local v13 = nil

				for _, v14 in ipairs({
					{ "Common", "Utils", "Utilities", "RewardInfo" },
					{ "Common", "Utils", "RewardInfo" },
					{ "Common", "RewardInfo" },
				}) do
					v13 = fn13(fn14(ReplicatedStorage, table.unpack(v14)))
					if not (type(v13) == "table" and type(rawget(v13, "playerOwnsItem")) == "function") then
						v13 = nil
						continue
					end
					break
				end

				if not v13 then
					for _, descendant in ipairs(ReplicatedStorage:GetDescendants()) do
						if descendant:IsA("ModuleScript") and descendant.Name == "RewardInfo" then
							local v14 = fn13(descendant)
							if type(v14) == "table" and type(rawget(v14, "playerOwnsItem")) == "function" then
								v13 = v14
								break
							end
						end
					end
				end

				if v13 and not tbl21.rwdorig then
					tbl21.rwdmod = v13
					tbl21.rwdorig = fn52(v13, "playerOwnsItem", function(l,K,...)if  tbl10 .unlockall and type(K)=="table"and(l==nil or l== localPlayer )then local p=K.Type;if p=="Sword"or p=="Explosion"or p=="Emote"or p=="Finisher"or p=="SwordAccessory"then return true;end;end;return  tbl21 .rwdorig(l,K,...);end)

					if not tbl21.rwdorig then
						local tbl24 = {}

						for k, v14 in pairs(v13) do
							tbl24[#tbl24 + 1] = tostring(k) .. (type(v14) == "function" and "()" or "")
						end

						table.sort(tbl24)
						tbl3.logwev("uaHookReward", 10, "UnlockAll", "failed to hook RewardInfo.playerOwnsItem; module has: " .. table.concat(tbl24, ", "))
					end
				end

				if v7 then
					if not tbl21.seteqorig then
						tbl21.seteqorig = fn52(v7, "SetEquipped", function(l,K,p)if not  tbl10 .unlockall then return  tbl21 .seteqorig(l,K,p);end;local E,k;if type(K)=="table"then E,k=K.ItemType or K.Type,K.Name;else k,E=( fn20 (p,K)),K;end;if E=="Ability"or not E or not k then return  tbl21 .seteqorig(l,K,p);end;if  fn29 (E,k)then return  tbl21 .seteqorig(l,K,p);end; fn27 (E,k);return true;end)

						if not tbl21.seteqorig then
							tbl3.logwev("uaHookSetEq", 10, "UnlockAll", "failed to hook ShopAPI.SetEquipped")
						end
					end

					if not tbl21.accorig then
						tbl21.accorig = fn52(v7, "ToggleSwordAccessory", function(l)if not  tbl10 .unlockall then return  tbl21 .accorig(l);end; tbl21 .noacc=not  tbl21 .noacc; tbl21 .equip.NoAcc= tbl21 .noacc;if  fn15 then  fn15 ();end; tbl21 .applyacc();return true;end)
					end
				end

				if v8 then
					if not tbl21.emoplayorig then
						tbl21.emoplayorig = fn52(v8, "Play", function(l,K,p)if not  tbl10 .unlockall and not  tbl10 .forceemo and not  tbl10 .emospam and not  tbl10 .emoteonly then return  tbl21 .emoplayorig(l,K,p);end;local E= toggles .emotewalk and  toggles .emotewalk.Value;if not  tbl10 .emospam and not E and( fn29 ("Emote",K))then return  tbl21 .emoplayorig(l,K,p);end;if type(l)=="table"then l._currentEmote=K;l._emoteSlot=p;l._lastEmote= clock ();if l._character then l._character:SetAttribute("Emoting",K);end;end; tbl21 .spamemo=K; fn46 (K);end)

						if not tbl21.emoplayorig then
							tbl3.logwev("uaHookEmote", 10, "UnlockAll", "failed to hook EmoteCtrl.Play")
						end
					end

					if not tbl21.emostoporig then
						tbl21.emostoporig = fn52(v8, "Stop", function(l,...)if not  tbl10 .unlockall and not  tbl10 .forceemo and not  tbl10 .emospam and not  tbl10 .emoteonly then if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;return  tbl21 .emostoporig(l,...);end;if  tbl21 .activeemo and  clock ()-( tbl21 .emostart or 0)<0.3 and not  fn45 ()then local K= tbl3 .safehum();if K and K.Health>0 then return;end;end;if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;if type(l)=="table"then if l._currentTrack and l._currentTrack.IsPlaying then l._currentTrack:Stop();end;l._currentEmote=nil;l._emoteSlot=nil;if l._character then l._character:SetAttribute("Emoting",nil);end;end;end)
					end
				end

				tbl21.finhookup()
				tbl21.hooked = true
			end

			local function arm()
				fn39()
				fn53()
				fn30()
			end

			tbl21.unhook = function()
				tbl10.unlockall = false
				tbl10.forceemo = false
				tbl10.emospam = false
				tbl10.emoteonly = false
				tbl10.autoload = false

				if tbl21.rwdmod and tbl21.rwdorig then
					tbl21.rwdmod.playerOwnsItem = tbl21.rwdorig
				end

				if v7 and tbl21.seteqorig then
					v7.SetEquipped = tbl21.seteqorig
				end

				if v7 and tbl21.accorig then
					v7.ToggleSwordAccessory = tbl21.accorig
				end

				if v8 and tbl21.emoplayorig then
					v8.Play = tbl21.emoplayorig
				end

				if v8 and tbl21.emostoporig then
					v8.Stop = tbl21.emostoporig
				end

				if tbl21.explmod and tbl21.explorig then
					tbl21.explmod.PlayExplosion = tbl21.explorig
				end

				if tbl21.fcmod and tbl21.finorig then
					tbl21.fcmod.PlayFinisher = tbl21.finorig
				end

				tbl21.rwdorig = nil
				tbl21.seteqorig = nil
				tbl21.accorig = nil
				tbl21.emoplayorig = nil
				tbl21.emostoporig = nil
				tbl21.explorig = nil
				tbl21.finorig = nil
				tbl21.hooked = false
				tbl21.explhooked = false
				tbl21.finhooked = false
				tbl21.autoran = false
				tbl21.boot = false

				for _, offconn in ipairs(tbl21.offconns) do
					offconn:Enable()
				end

				if tbl21.finshow then
					tbl21.finshow()
				end

				if tbl21.dropprey then
					tbl21.dropprey()
				end

				if tbl21.loaderblur then
					tbl21.loaderblur:Destroy()
					tbl21.loaderblur = nil
				end

				if tbl21.loadergui then
					tbl21.loadergui:Destroy()
					tbl21.loadergui = nil
				end

				tbl21.finhide(tbl3.safechar(), false)
			end

			tbl21.arm = arm
			unhook = tbl21.unhook

			local function fn54(arg)
				for _, v13 in ipairs({ "Activated", "MouseButton1Click" }) do
					local v14 = getconnections(arg[v13])

					if v14 then
						for _, v15 in ipairs(v14) do
							if not v15.ForeignState and v15.Function and islclosure(v15.Function) then
								local v16 = getupvalues(v15.Function)
								if type(v16) ~= "table" then
									continue
								end

								for _, v17 in pairs(v16) do
									if type(v17) == "table" and (rawget(v17, "_virtualItems") ~= nil or rawget(v17, "_selectedItem") ~= nil) then
										return v17
									end
								end
							end
						end
					end
				end
			end

			local function fn55(arg)
				local tbl24 = {}
				if not getconnections then
					return tbl24
				end

				for _, v13 in ipairs({ "Activated", "MouseButton1Click" }) do
					local v14 = getconnections(arg[v13])

					if v14 then
						for _, v15 in ipairs(v14) do
							if not v15.ForeignState and v15.Function then
								tbl24[#tbl24 + 1] = v15.Function
								v15:Disable()
								tbl21.offconns[#tbl21.offconns + 1] = v15
							end
						end
					end
				end

				return tbl24
			end

			local function fn56()
				local flag2 = tbl10.unlockall == true

				for _, offconn in ipairs(tbl21.offconns) do
					if flag2 then
						offconn:Disable()
					else
						offconn:Enable()
					end
				end
			end

			local function fn57(arg)
				if not (arg and arg.Select) then
					return
				end

				local function fn58()
					local selectedItem = arg._selectedItem
					if not selectedItem then
						return
					end
					arg:Select(table.clone(selectedItem), true)
				end

				fn58()
				task.defer(fn58)
				task.delay(0.1, fn58)
			end

			local function fn58()
				if tbl21.guihooked or tbl21.guibusy then
					return
				end
				tbl21.guibusy = true

				tbl3.bindt(task.spawn(function()
					local playerGui = localPlayer:WaitForChild("PlayerGui", 20)
					local shop = playerGui and playerGui:WaitForChild("Shop", 20)
					shop = shop and shop:WaitForChild("Holder", 20)
					local infoBG = shop and shop:WaitForChild("InfoBG", 20)
					local buyButton = infoBG and infoBG:WaitForChild("BuyButton", 20)

					if buyButton and getconnections then
						local n3 = clock() + 10

						while clock() < n3 do
							local v13, v14, v15 = ipairs(getconnections(buyButton.Activated) or {})
							local n4 = 0

							for _, v16 in v13, v14, v15 do
								if not v16.ForeignState and v16.Function then
									n4 += 1
								end
							end

							if not (n4 > 0) then
								task.wait(0.2)
								continue
							end
							break
						end
					end

					tbl21.guibusy = false
					if not buyButton then
						tbl3.logwev("uaHookGui", 30, "UnlockAll", "Shop.Holder.InfoBG.BuyButton never appeared - shop hooks skipped")
						return
					end
					tbl21.guihooked = true
					local v13 = fn54(buyButton)
					local v14 = fn55(buyButton)

					local function fn59()
						for _, v15 in ipairs(v14) do
							v15()
						end
					end

					tbl3.bind(buyButton.Activated:Connect(function()if not  tbl10 .unlockall then return;end; v13 = v13 or( fn54 ( buyButton ));local l= v13 and  v13 ._selectedItem;if not l then  fn59 ();return;end;local K=type(l.ItemInfo)=="table"and l.ItemInfo or nil;local p,E=l.type or l.Type or K and(K.ItemType or K.Type),l.name or l.Name or K and K.Name;if p=="Ability"or p=="AbilityFreeTrial"then  fn59 ();return;end;if p=="Sword"or p=="Explosion"then if  fn29 (p,E)then  fn59 ();return;end; fn27 (p,E);elseif p=="Emote"then  fn46 (E);else  fn59 ();return;end; fn57 ( v13 );end))
					local equips = infoBG and infoBG:FindFirstChild("Equips")
					local equipAccessory = equips and equips:FindFirstChild("EquipAccessory")

					if equipAccessory then
						fn55(equipAccessory)
						tbl3.bind(equipAccessory.Activated:Connect(function()if not  tbl10 .unlockall then return;end;if  v7 and  v7 .ToggleSwordAccessory then  v7 :ToggleSwordAccessory();end; fn57 ( v13 );end))
					end

					local tbl24 = { Sword = "SwordSkins", Explosion = "ExplosionSkins", Emote = "Emotes" }

					local function fn60()
						v13 = v13 or fn54(buyButton)
						local selectedItem = v13 and v13._selectedItem
						if not selectedItem then
							return nil
						end
						local itemInfo = type(selectedItem.ItemInfo) == "table" and selectedItem.ItemInfo or nil
						local type_ = selectedItem.type or selectedItem.Type or itemInfo and (itemInfo.ItemType or itemInfo.Type)
						local name = selectedItem.name or selectedItem.Name or itemInfo and itemInfo.Name
						return type_, name, selectedItem.key or type_ and name and fn19(type_, name) or nil
					end

					equips = equips and equips:FindFirstChild("Finisher")

					if equips and equips:IsA("GuiButton") then
						fn55(equips)
						tbl3.bind(equips.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K= fn60 ();if l~="Sword"or not K or not  tbl21 .finfor(K)then return;end;l= fn16 ("Data");local p= Replion and  Replion .None;if not(l and p and type(l._update)=="function")then return;end;local E=l:Get({"Finishers","Equipped",K})==true;l:_update({"Finishers","Equipped"},{[K]=E and p or true});if not E then  tbl21 .finequip(K);end; fn57 ( v13 );end))
					end

					shop = shop and shop:FindFirstChild("Favorite")

					if shop and shop:IsA("GuiButton") then
						fn55(shop)
						tbl3.bind(shop.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K= fn60 ();local p=l and  tbl24 [l];if not(K and p)then return;end;l= fn16 ("Data");local E= Replion and  Replion .None;if not(l and E)then return;end;l:_update({p,"Favorites"},{[K]=l:Get({p,"Favorites",K})==true and E or true}); fn57 ( v13 );end))
					end

					infoBG = infoBG and infoBG:FindFirstChild("Delete")

					if infoBG and infoBG:IsA("GuiButton") then
						fn55(infoBG)
						tbl3.bind(infoBG.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K,p= fn60 ();if not(l and K and p and  tbl24 [l])then return;end;if  v13 and type( v13 ._canDelete)=="function"then if not  v13 ._canDelete( v13 ,l,p)then  tbl3 .notif("Unlock All","You can't delete that item.",4);return;end;end;local E= fn16 ("Inventory");local k= Replion and  Replion .None;if not(E and k)then return;end;E:_update({"Inventory",l},{[p]=k});if  tbl21 .owned and  tbl21 .owned[l]then  tbl21 .owned[l][K]=nil;end;if  tbl21 .equip[l]==K then  tbl21 .equip[l]=nil;if  fn15 then  fn15 ();end;end;if l=="Sword"and  tbl10 .swname==K then  tbl10 .swskin=false; tbl10 .swname="";elseif l=="Explosion"and  tbl21 .explname==K then  tbl21 .explname=nil;end; fn57 ( v13 );end))
					end

					fn56()
					playerGui = playerGui and playerGui:WaitForChild("EmoteWheel", 20)
					playerGui = playerGui and playerGui:WaitForChild("List", 20)
					playerGui = playerGui and playerGui:WaitForChild("Content", 20)
					playerGui = playerGui and playerGui:WaitForChild("Folder", 20)

					if playerGui then
						local function fn61(arg)
							local v15 = getconnections(arg.Activated)
							if not v15 then
								return
							end

							for _, v16 in ipairs(v15) do
								if not v16.ForeignState and v16.Function and islclosure(v16.Function) then
									local v17 = getupvalues(v16.Function)

									if type(v17) == "table" then
										local n3 = 0

										for k in pairs(v17) do
											if type(k) == "number" and k > n3 then
												n3 = k
											end
										end

										local v18 = nil
										local v19 = nil

										for i = 1, n3 do
											local v20 = v17[i]

											if type(v20) == "string" and not v18 then
												v18 = v20
											end

											if type(v20) == "table" and (rawget(v20, "selected") ~= nil or rawget(v20, "page") ~= nil) then
												v19 = v20
											end
										end

										if v18 and v19 then
											return v18, v19
										end
									end
								end
							end
						end

						local function fn62(child)
							if not child:IsA("GuiButton") or child:GetAttribute("__uaHooked") then
								return
							end
							child:SetAttribute("__uaHooked", true)
							tbl3.bind(child.Activated:Connect(function()if not( tbl10 .unlockall or  tbl10 .emoteonly or  tbl10 .autoload)then return;end;local l,K= fn61 ( child );if not(l and K)then return;end;local p=(tonumber(K.selected)or 1)+((tonumber(K.page)or 1)-1)*8; fn51 ( fn20 (l),p);end))
						end

						for _, child in ipairs(playerGui:GetChildren()) do
							fn62(child)
						end

						tbl3.bind(playerGui.ChildAdded:Connect(fn62))
					end
				end))
			end

			local function fn59()
				if tbl21.boot then
					return
				end
				tbl21.boot = true
				fn12()
				fn39()
				task.wait()
				fn53()
				task.wait()
				fn58()
				fn56()
			end

			local function fn60()
				local tbl24 = {
					done = false,
					finish = function()
					end,
					setStatus = function()
					end,
				}

				local screenGui = Instance.new("ScreenGui")
				screenGui.Name = "\0RiseUnlock"
				screenGui.IgnoreGuiInset = true
				screenGui.ResetOnSpawn = false
				screenGui.DisplayOrder = 999999999
				screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				screenGui.Parent = fn6 and fn6() or CoreGui
				local frame = Instance.new("Frame")
				frame.Size = UDim2.fromScale(1, 1)
				frame.BackgroundColor3 = Color3.fromRGB(2, 12, 20)
				frame.BackgroundTransparency = 1
				frame.BorderSizePixel = 0
				frame.Parent = screenGui
				local blurEffect = Instance.new("BlurEffect")
				blurEffect.Size = 0
				blurEffect.Parent = Lighting
				local frame2 = Instance.new("Frame")
				frame2.AnchorPoint = Vector2.new(0.5, 0.5)
				frame2.Position = UDim2.fromScale(0.5, 0.5)
				frame2.Size = UDim2.fromOffset(252, 172)
				frame2.BackgroundColor3 = color
				frame2.BackgroundTransparency = 1
				frame2.BorderSizePixel = 0
				frame2.Parent = screenGui
				tbl3.corner(frame2, 20)
				local uiGradient = Instance.new("UIGradient")
				uiGradient.Rotation = 90
				local color4 = Color3.fromRGB
				uiGradient.Color = ColorSequence.new(Color3.fromRGB(16, 56, 88), color4(3, 24, 42))
				uiGradient.Parent = frame2
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = Color3.fromRGB(255, 255, 255)
				uiStroke.Thickness = 1.5
				uiStroke.Transparency = 1
				uiStroke.Parent = frame2
				local frame3 = Instance.new("Frame")
				frame3.AnchorPoint = Vector2.new(0.5, 0)
				frame3.Position = UDim2.new(0.5, 0, 0, 28)
				frame3.Size = UDim2.fromOffset(46, 46)
				frame3.BackgroundTransparency = 1
				frame3.Parent = frame2
				local tbl25 = {}
				local n3 = 12

				for i = 1, 12 do
					local frame4 = Instance.new("Frame")
					frame4.AnchorPoint = Vector2.new(0.5, 0.5)
					frame4.Size = UDim2.fromOffset(4, 12)
					frame4.BackgroundColor3 = accent
					frame4.BackgroundTransparency = 1
					frame4.BorderSizePixel = 0
					local v13 = rad((i - 1) * 360 / n3)
					frame4.Position = UDim2.new(0.5, sin(v13) * 15, 0.5, -cos(v13) * 15)
					frame4.Rotation = (i - 1) * 360 / n3
					local uiCorner = Instance.new("UICorner")
					uiCorner.CornerRadius = UDim.new(1, 0)
					uiCorner.Parent = frame4
					frame4.Parent = frame3
					tbl25[i] = frame4
				end

				local textLabel = Instance.new("TextLabel")
				textLabel.AnchorPoint = Vector2.new(0.5, 0)
				textLabel.Position = UDim2.new(0.5, 0, 0, 92)
				textLabel.Size = UDim2.new(1, -24, 0, 22)
				textLabel.BackgroundTransparency = 1
				textLabel.Font = Enum.Font.GothamBold
				textLabel.TextSize = 16
				textLabel.TextColor3 = color2
				textLabel.TextTransparency = 1
				textLabel.Text = "Unlock All"
				textLabel.Parent = frame2
				local textLabel2 = Instance.new("TextLabel")
				textLabel2.AnchorPoint = Vector2.new(0.5, 0)
				textLabel2.Position = UDim2.new(0.5, 0, 0, 118)
				textLabel2.Size = UDim2.new(1, -28, 0, 40)
				textLabel2.BackgroundTransparency = 1
				textLabel2.Font = Enum.Font.Gotham
				textLabel2.TextSize = 12
				textLabel2.TextColor3 = color3
				textLabel2.TextTransparency = 1
				textLabel2.TextWrapped = true
				textLabel2.Text = "Unlocking swords, explosions & emotes..."
				textLabel2.Parent = frame2
				local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				TweenService:Create(frame, tweenInfo, { BackgroundTransparency = 0.45 }):Play()
				TweenService:Create(frame2, tweenInfo, { BackgroundTransparency = 0.2 }):Play()
				TweenService:Create(uiStroke, tweenInfo, { Transparency = 0.55 }):Play()
				TweenService:Create(textLabel, tweenInfo, { TextTransparency = 0 }):Play()
				TweenService:Create(textLabel2, tweenInfo, { TextTransparency = 0.15 }):Play()
				TweenService:Create(blurEffect, tweenInfo, { Size = 16 }):Play()
				tbl21.loadergui = screenGui
				tbl21.loaderblur = blurEffect
				local v13 = clock()
				local v14 = tbl3.bind(RunService.RenderStepped:Connect(function()local l= clock ()*1.15%1;for K=1, n3 ,1 do local p=((K-1)/ n3 -l)%1; tbl25 [K].BackgroundTransparency=0.1+0.82*p;end;end))

				tbl24.setStatus = function(text)
					textLabel2.Text = text
				end

				tbl24.finish = function()
					if tbl24.done then
						return
					end
					tbl24.done = true
					local n4 = 0.6 - clock() - v13

					if n4 > 0 then
						task.wait(n4)
					end

					local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
					TweenService:Create(frame, tweenInfo2, { BackgroundTransparency = 1 }):Play()
					TweenService:Create(frame2, tweenInfo2, { BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.54) }):Play()
					TweenService:Create(uiStroke, tweenInfo2, { Transparency = 1 }):Play()
					TweenService:Create(textLabel, tweenInfo2, { TextTransparency = 1 }):Play()
					TweenService:Create(textLabel2, tweenInfo2, { TextTransparency = 1 }):Play()
					TweenService:Create(blurEffect, tweenInfo2, { Size = 0 }):Play()
					task.wait(0.45)

					if v14 then
						v14:Disconnect()
					end

					blurEffect:Destroy()
					screenGui:Destroy()
				end

				return tbl24
			end

			fn9 = function() tbl10 .unlockall=true; tbl21 .everunlocked=true; tbl21 .uagen=( tbl21 .uagen or 0)+1;local l= tbl21 .uagen; fn56 ();local K= fn60 ();local p=false;local E=nil;E=function(k,a)if p then return;end;p=true;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;K.finish(); tbl3 .notif("Unlock All",k,a or 5);end;local function k()if p then return;end;p=true;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;K.finish();end; tbl3 .bindt(task.delay(20,function()E("Done. If something is missing, rejoin and turn it on again.",6);end)); tbl3 .bindt(task.spawn(function() fn12 ();task.wait();if  tbl21 .uagen~=l then return k();end; fn59 ();if  tbl21 .uagen~=l then return k();end;K.setStatus("Loading swords and explosions...");for p=1,3,1 do  tbl21 .injected=false; fn40 ();if not  tbl21 .failed or  tbl21 .uagen~=l then break;end;if p<3 then K.setStatus("Retrying... ("..p.."/3)"); fn12 ();task.wait(0.8);end;end;task.wait();if  tbl21 .uagen~=l then return k();end; fn49 ();local p={"Sword","Explosion"};for a,d in ipairs(p)do a= tbl21 .equip[d];if type(a)=="string"and a~=""then  fn27 (d,a,true);end;if  tbl21 .uagen~=l then return k();end;end;if  tbl21 .equip.NoAcc then  tbl21 .noacc=true; tbl21 .applyacc();end;K.setStatus("Loading emotes..."); tbl3 .bindt(task.delay(3,function()if  tbl21 .uagen~=l then return;end; fn50 ();end));E("Done. Open your inventory and equip anything.",6);end));end

			fn10 = function()
				tbl10.unlockall = false
				tbl21.uagen = (tbl21.uagen or 0) + 1
				tbl21.explname = nil
				tbl21.injected = false
				tbl21.failed = false

				if not tbl10.autoload and tbl21.skinmine then
					tbl10.swskin = false
					tbl10.swname = ""
					tbl21.skinmine = false
				end

				fn56()
				tbl3.notif("Unlock All", "Off. Items already unlocked stay until you rejoin.", 4)
			end

			fn11 = function(l) tbl10 .autoload=true;if  tbl10 .unlockall or  tbl21 .autoran then return;end; tbl21 .autoran=true; tbl3 .bindt(task.spawn(function() fn12 ();task.wait(); fn39 (); fn53 (); fn58 (); fn30 (); fn49 ();local K={"Sword","Explosion"};for p,E in ipairs(K)do p= tbl21 .equip[E];if type(p)=="string"and p~=""then  fn27 (E,p,true);end;end;if  tbl21 .equip.NoAcc then  tbl21 .noacc=true; tbl21 .applyacc();end; fn50 ();for K,K in pairs( tbl21 .wheel)do if type(K)=="string"and K~=""then  fn26 ("Emote",K);end;end;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;if l then  tbl3 .notif("Auto Load Last Loadout","Your last sword, explosion and emotes are back.",4);end;end));end

			local function fn61()
				tbl10.autoload = false
				tbl21.autoran = false

				if not tbl10.unlockall and tbl21.skinmine then
					tbl10.swskin = false
					tbl10.swname = ""
					tbl21.skinmine = false
					tbl21.explname = nil
				end
			end

			local function fn62(arg, arg2)
				if type(arg) ~= "string" or arg == "" then
					return nil
				end
				local str2 = arg:lower()

				for _, v13 in ipairs(arg2) do
					if v13:lower() == str2 then
						return v13
					end
				end

				for _, v13 in ipairs(arg2) do
					if v13:lower():find(str2, 1, true) then
						return v13
					end
				end

				return nil
			end

			tbl3.skinsword = function(arg)
				fn12()
				fn39()
				fn53()
				fn30()
				local v13 = tbl3.initsword()
				if not v13 then
					tbl3.notif("Skins", "Swords aren't ready yet. Try again in a second.", 5)
					return
				end
				local tbl24 = {}
				local collection = v13:GetCollection()

				if type(collection) == "table" then
					for k in pairs(collection) do
						tbl24[#tbl24 + 1] = k
					end
				end

				local v14 = fn62(arg, tbl24)

				if not v14 then
					if v13:GetSword(arg) then
						v14 = arg
					end
				end

				if not v14 or v14 == "" then
					tbl3.notif("Skins", ("No sword called \"%s\". %d swords loaded."):format(tostring(arg), #tbl24), 6)
					return
				end

				if not tbl3.safechar() then
					tbl3.notif("Skins", "Join a round first.", 5)
					return
				end
				tbl10.swskin = true
				tbl10.swname = v14
				tbl21.skinmine = false
				tbl3.hookslash()
				tbl3.skinloop()
				tbl3.setswattr(v14)

				if tbl9.swctrl and tbl9.swctrl.SetSword then
					tbl9.swctrl:SetSword(v14)
				end

				local v15 = tbl3.applysword()
				fn26("Sword", v14)
				fn25("Sword", v14)
				tbl21.ensureeq("Sword", v14)
				tbl21.finequip(v14)
				tbl21.equip.Sword = v14

				if fn15 then
					fn15()
				end

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.bindt(task.delay(0.4, function()
					local v16 = tbl3.safechar()

					if v16 and v16:FindFirstChild(v14) then
						tbl3.notif("Skins", ("Equipped %s."):format(v14), 3)
					elseif not v15 then
						tbl3.notif("Skins", ("Couldn't equip %s. The game may not have sent the model."):format(v14), 7)
					else
						tbl3.notif("Skins", ("%s didn't show up. The game blocked it."):format(v14), 6)
					end
				end))
			end

			tbl3.applyexpl = function(arg)
				fn12()
				fn39()
				fn53()
				fn30()
				local DataExplosions = fn21("DataExplosions")
				local v13 = fn62(arg, DataExplosions)
				if not v13 or v13 == "" then
					tbl3.notif("Skins", ("No explosion called \"%s\". %d explosions loaded."):format(tostring(arg), #DataExplosions), 6)
					return
				end
				fn27("Explosion", v13)

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.bindt(task.spawn(function()
					tbl3.notif("Skins", repasset("Explosions", v13) and ("Explosion set to %s."):format(v13) or ("%s is set, but the game didn't send it. It may not show."):format(v13), 5)
				end))
			end

			tbl3.emoteonly = function(arg)
				if not arg then
					return
				end
				fn12()
				fn39()
				fn53()
				fn58()
				fn30()
				fn50()
				local n3 = 0

				for _, v13 in pairs(tbl21.wheel) do
					if type(v13) == "string" and v13 ~= "" then
						fn26("Emote", v13)
						n3 += 1
					end
				end

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.notif("Skins", n3 > 0 and ("%d emotes ready. Open your emote wheel."):format(n3) or "No emotes saved yet.", 4)
			end

			toggles.unlockall:OnChanged(function(arg)
				if arg then
					fn9()
				else
					fn10()
				end

				tbl3.qsave()
			end)

			toggles.equipautoload:OnChanged(function(arg)
				if arg then
					fn11(true)
				else
					fn61()
				end

				tbl3.qsave()
			end)

			local function fn63()return  max (0.5-( clamp ( tbl10 .emospd or 5,1,10)-1)*0.04888888888888889,0.2);end

			local function fn64()
				if tbl21.spamconn then
					tbl21.spamconn:Disconnect()
					tbl21.spamconn = nil
				end
			end

			local function fn65()
				fn64()
				tbl21.spamlast = 0
				tbl21.spamconn = tbl3.bind(RunService.Heartbeat:Connect(function()if not  tbl10 .emospam or not  tbl21 .spamemo then return;end;if not  tbl3 .isalive()then return;end;if not( toggles .emotewalk and  toggles .emotewalk.Value)then local l= tbl3 .safehum();if l and l.MoveDirection.Magnitude>0.1 then if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;return;end;end;local l= clock ();if l-( tbl21 .spamlast or 0)< fn63 ()then return;end; tbl21 .spamlast=l; fn46 ( tbl21 .spamemo);end))
			end

			toggles.forceemote:OnChanged(function(forceemo)
				tbl10.forceemo = forceemo

				if forceemo then
					arm()
				end

				tbl3.qsave()
			end)

			toggles.emotespam:OnChanged(function(emospam)
				tbl10.emospam = emospam

				if emospam then
					arm()
					fn65()
				else
					fn64()
				end

				tbl3.qsave()
			end)

			options.emotespamspeed:OnChanged(function(emospd)
				tbl10.emospd = emospd
				tbl3.qsave()
			end)

			toggles.emoteonspawn:OnChanged(function(emospawn)
				tbl10.emospawn = emospawn

				if emospawn then
					arm()
				end

				tbl3.qsave()
			end)

			tbl10.emospawn = toggles.emoteonspawn.Value

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				if not tbl10.emospawn then
					return
				end
				task.wait(1)
				local n1 = tbl21.wheel and (tbl21.wheel["1"] or tbl21.wheel[1]) or tbl21.spamemo

				if type(n1) == "string" and n1 ~= "" then
					fn46(n1)
				end
			end))

			if alive then
				local v13 = tbl3.safechar()
				tbl21.lost = not (v13 and v13.Parent == alive)
				local function fn66(l)local K= Players :GetPlayerFromCharacter(l);if not K or K== localPlayer then return false;end;if l:GetAttribute("IsDoppelganger")then return false;end;if l:GetAttribute("IsEncryptedClone")then return false;end;if l:GetAttribute("Dead")then return false;end;return true;end
				local function dropprey()if  tbl21 .prey then  tbl21 .prey:Destroy(); tbl21 .prey=nil;end; tbl21 .preyfor=nil;end
				tbl21.dropprey = dropprey
				local function fn67(l)if  tbl21 .preyfor~=l or l.Parent~= alive then return;end;local K= tbl21 .finclone(l);if not K then return;end;if  tbl21 .prey then  tbl21 .prey:Destroy();end; tbl21 .prey=K;end
				local function fn68()if not( tbl10 .unlockall or  tbl10 .autoload or  tbl10 .swskin)then return;end;local l= tbl21 .finfor( tbl21 .cursword());if l then  tbl21 .prefetch("Finishers",l);end;end
				local function fn69(l)if not( tbl10 .unlockall or  tbl10 .autoload or  tbl10 .swskin)then return;end; fn68 ();if not l or  tbl21 .preyfor==l then return;end; dropprey (); tbl21 .preyfor=l; fn67 (l); tbl3 .bindt(task.delay(3,function() fn67 (l);end));end
				local function fn70()local l= tbl3 .safechar();if not l or l.Parent~= alive then return 0,nil;end;local l,K=0;for p,p in ipairs( alive :GetChildren())do if  fn66 (p)then l,K=l+1,p;end;end;return l,K;end
				tbl3.bind(alive.ChildRemoved:Connect(function(l)local K= Players :GetPlayerFromCharacter(l);if not K then return;end;if K== localPlayer then  tbl21 .lost=true;return;end;K= tbl3 .safechar(); tbl21 .lost=not(K and K.Parent== alive and not K:GetAttribute("Dead"));if  tbl21 .lost then return;end;local K,p= fn70 ();if K==1 then  fn69 (p);return;end;if K>1 then return;end; tbl21 .winfin(l);end))
				tbl3.bind(alive.ChildAdded:Connect(function(l)if l== localPlayer .Character then  tbl21 .lost=false; dropprey (); fn68 (); tbl3 .bindt(task.delay(3, fn68 ));end;local l,K= fn70 ();if l==1 then  fn69 (K);end;end))
			end

			tbl10.forceemo = toggles.forceemote.Value

			if toggles.emotespam.Value then
				tbl10.emospam = true
				fn65()
			end

			if tbl10.forceemo or tbl10.emospam or tbl10.emospawn or tbl10.emoteonly then
				tbl3.bindt(task.spawn(arm))
			end
		else
			local str2 = "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"

			tbl3.queuetp = function()
				local v5 = queueonteleport
				if type(v5) ~= "function" then
					return
				end
				local riseScriptSource

				if type(_G.RiseScriptSource) == "string" and _G.RiseScriptSource ~= "" then
					riseScriptSource = _G.RiseScriptSource
				else
					riseScriptSource = nil

					if str2:sub(1, 4) == "http" then
						riseScriptSource = ("loadstring(game:HttpGet(\"%s\"))()"):format(str2)
					end
				end

				if not riseScriptSource then
					tbl3.notif("Auto Execute", "Rise can't restart itself after a teleport. Open Rise from its loader.", 6)
					return
				end
				v5("_G.cuties = nil\n_G.RiseBoot = nil\n" .. riseScriptSource)
				tbl3.queued = true
			end

			tbl3.vipcb = function(arg)
				local textChatMessageProperties = Instance.new("TextChatMessageProperties")

				if tbl10.viptag and arg.TextSource and arg.TextSource.UserId == localPlayer.UserId then
					textChatMessageProperties.PrefixText = "<font color='#FFD700'>[VIP]</font> " .. arg.PrefixText
				end

				return textChatMessageProperties
			end

			tbl3.applyvip = function()
				if tbl9.vipset then
					return
				end
				local TextChatService = game:GetService("TextChatService")
				TextChatService.OnIncomingMessage = tbl3.vipcb
				tbl9.vipset = true

				tbl3.bindt(task.delay(2, function()
					if tbl9.vipset then
						TextChatService.OnIncomingMessage = tbl3.vipcb
					end
				end))
			end

			tbl3.killvip = function()
				if not tbl9.vipset then
					return
				end

				game:GetService("TextChatService").OnIncomingMessage = function()
					return nil
				end

				tbl9.vipset = false
			end

			local tbl18 = {
				Cinematic = {
					bloom = { Intensity = 0.85, Size = 24, Threshold = 0.92 },
					cc = {
						Brightness = 0.02,
						Contrast = 0.16,
						Saturation = 0.06,
						TintColor = Color3.fromRGB(255, 246, 236),
					},
					sun = { Intensity = 0.08, Spread = 0.5 },
					dof = { FarIntensity = 0.4, FocusDistance = 0.05, InFocusRadius = 70, NearIntensity = 0 },
				},
				Vivid = {
					bloom = { Intensity = 1.1, Size = 22, Threshold = 0.88 },
					cc = {
						Brightness = 0.04,
						Contrast = 0.2,
						Saturation = 0.28,
						TintColor = Color3.fromRGB(255, 252, 248),
					},
					sun = { Intensity = 0.06, Spread = 0.45 },
					dof = { FarIntensity = 0.25, FocusDistance = 0.05, InFocusRadius = 90, NearIntensity = 0 },
				},
				["Soft Dream"] = {
					bloom = { Intensity = 1.6, Size = 40, Threshold = 0.78 },
					cc = {
						Brightness = 0.06,
						Contrast = -0.05,
						Saturation = 0.1,
						TintColor = Color3.fromRGB(255, 244, 250),
					},
					sun = { Intensity = 0.14, Spread = 0.7 },
					dof = { FarIntensity = 0.55, FocusDistance = 0.05, InFocusRadius = 55, NearIntensity = 0 },
				},
				Noir = {
					bloom = { Intensity = 1, Size = 26, Threshold = 0.9 },
					cc = {
						Brightness = 0,
						Contrast = 0.3,
						Saturation = -0.85,
						TintColor = Color3.fromRGB(235, 240, 255),
					},
					sun = { Intensity = 0.05, Spread = 0.4 },
					dof = { FarIntensity = 0.3, FocusDistance = 0.05, InFocusRadius = 80, NearIntensity = 0 },
				},
				["Warm Sunset"] = {
					bloom = { Intensity = 1.2, Size = 30, Threshold = 0.82 },
					cc = {
						Brightness = 0.03,
						Contrast = 0.12,
						Saturation = 0.18,
						TintColor = Color3.fromRGB(255, 226, 196),
					},
					sun = { Intensity = 0.18, Spread = 0.65 },
					dof = { FarIntensity = 0.35, FocusDistance = 0.05, InFocusRadius = 75, NearIntensity = 0 },
				},
				["Cold Steel"] = {
					bloom = { Intensity = 0.9, Size = 22, Threshold = 0.9 },
					cc = {
						Brightness = 0,
						Contrast = 0.22,
						Saturation = -0.1,
						TintColor = Color3.fromRGB(214, 230, 255),
					},
					sun = { Intensity = 0.05, Spread = 0.4 },
					dof = { FarIntensity = 0.3, FocusDistance = 0.05, InFocusRadius = 85, NearIntensity = 0 },
				},
				["Neon Night"] = {
					bloom = { Intensity = 2, Size = 34, Threshold = 0.7 },
					cc = {
						Brightness = -0.04,
						Contrast = 0.26,
						Saturation = 0.4,
						TintColor = Color3.fromRGB(228, 232, 255),
					},
					sun = { Intensity = 0, Spread = 0.4 },
					dof = { FarIntensity = 0.45, FocusDistance = 0.05, InFocusRadius = 60, NearIntensity = 0 },
				},
			}

			tbl3.clrshade = function()
				if tbl9.shadefx then
					for _, v5 in ipairs(tbl9.shadefx) do
						v5:Destroy()
					end

					tbl9.shadefx = nil
				end
			end

			tbl3.applyshade = function()
				tbl3.clrshade()
				if not tbl10.shaders then
					return
				end
				local cinematic = tbl18[tbl10.shaderpreset] or tbl18.Cinematic
				local shadefx = {}

				local function fn9(arg, arg2)
					local instance = Instance.new(arg)

					for k, v5 in pairs(arg2) do
						instance[k] = v5
					end

					instance.Parent = Lighting
					shadefx[#shadefx + 1] = instance
					return instance
				end

				local v5 = clamp(cinematic.cc.Saturation + (tbl10.saturation or 1) - 1, -1, 1)

				fn9("ColorCorrectionEffect", {
					Name = "_rcc",
					Brightness = clamp(cinematic.cc.Brightness + (tbl10.brightness or 0), -1, 1),
					Contrast = clamp(cinematic.cc.Contrast + (tbl10.contrast or 0), -1, 1),
					Saturation = v5,
					TintColor = cinematic.cc.TintColor,
				})

				fn9("BloomEffect", {
					Name = "_rbloom",
					Intensity = max(0, cinematic.bloom.Intensity * (tbl10.bloom or 1)),
					Size = cinematic.bloom.Size,
					Threshold = cinematic.bloom.Threshold,
				})

				if cinematic.sun and cinematic.sun.Intensity > 0 then
					fn9("SunRaysEffect", { Name = "_rsun", Intensity = cinematic.sun.Intensity, Spread = cinematic.sun.Spread })
				end

				if tbl10.dof and cinematic.dof then
					fn9("DepthOfFieldEffect", {
						Name = "_rdof",
						FarIntensity = cinematic.dof.FarIntensity,
						FocusDistance = cinematic.dof.FocusDistance,
						InFocusRadius = cinematic.dof.InFocusRadius,
						NearIntensity = cinematic.dof.NearIntensity,
					})
				end

				tbl9.shadefx = shadefx
			end

			tbl3.clrrain = function()
				if tbl9.rainconn then
					tbl9.rainconn:Disconnect()
					tbl9.rainconn = nil
				end

				if tbl9.rainfx then
					for _, v5 in ipairs(tbl9.rainfx) do
						v5:Destroy()
					end

					tbl9.rainfx = nil
				end
			end

			tbl3.applyrain = function()
				tbl3.clrrain()
				if not tbl10.rain then
					return
				end
				local part = Instance.new("Part")
				part.Name = "_rrain"
				part.Anchored = true
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.Transparency = 1
				part.Size = Vector3.new(70, 1, 70)
				part.Orientation = Vector3.zero
				local particleEmitter = Instance.new("ParticleEmitter")
				particleEmitter.Name = "_rrainfx"
				particleEmitter.Rate = tbl10.rainrate or 150
				particleEmitter.Lifetime = NumberRange.new(0.55, 0.8)
				particleEmitter.Speed = NumberRange.new(75, 95)
				particleEmitter.SpreadAngle = Vector2.new(6, 6)
				particleEmitter.Acceleration = Vector3.new(0, -60, 0)
				particleEmitter.EmissionDirection = Enum.NormalId.Bottom
				particleEmitter.Rotation = NumberRange.new(0, 0)
				local new = NumberSequenceKeypoint.new
				particleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.18), new(1, 0.1) })
				local numberSequence = NumberSequence.new
				local tbl19 = {}
				local v5 = NumberSequenceKeypoint.new(0, 0.25)
				local v6 = NumberSequenceKeypoint.new(0.8, 0.4)
				local new2 = NumberSequenceKeypoint.new
				tbl19[1] = v5
				tbl19[2] = v6

				do
					local values = table.pack(new2(1, 1))
					table.move(values, 1, values.n, 3, tbl19)
				end

				particleEmitter.Transparency = numberSequence(tbl19)
				particleEmitter.Color = ColorSequence.new(Color3.fromRGB(170, 200, 230))
				particleEmitter.LightEmission = 0.2
				particleEmitter.Brightness = 1
				particleEmitter.ZOffset = 1
				particleEmitter.Parent = part
				part.Parent = Workspace
				tbl9.rainfx = { part }
				tbl9.rainconn = tbl3.bind(RunService.RenderStepped:Connect(function()if not  tbl10 .rain then return;end;local l= tbl3 .safehrp();local K=l and l.Position;K=if not K and  currentCamera then  currentCamera .CFrame.Position else K;if K then  part .Position=K+Vector3.new(0,32,0);end; particleEmitter .Rate= tbl10 .rainrate or 150;end))
			end

			tbl3.stopmusic = function()
				tbl9.musicsound = nil

				for _, child in ipairs(SoundService:GetChildren()) do
					if child.Name == "_rbgm" then
						child:Destroy()
					end
				end
			end

			tbl3.setupmusic = function()
				tbl3.stopmusic()
				if not tbl10.music then
					return
				end
				tbl9.musicgen = (tbl9.musicgen or 0) + 1
				local musicgen = tbl9.musicgen
				local musicid = tbl10.musicid
				local match

				if musicid and musicid ~= "" then
					match = tostring(musicid):match("%d+")
				else
					match = tbl6[tbl10.track]
				end

				if not match or match == "" then
					tbl3.notif("Music", "That track has no audio ID. Pick another song.", 3)
					return
				end
				local num = tonumber(match)

				if num then
					local productInfo = MarketplaceService:GetProductInfo(num)
					if musicgen ~= tbl9.musicgen then
						return
					end

					if type(productInfo) == "table" and productInfo.AssetTypeId then
						if productInfo.AssetTypeId ~= 3 then
							tbl3.notif("Music", "That is not a song. Paste a Roblox audio ID.", 6)
							return
						end
						tbl3.notif("Music", "Now playing \"" .. tostring(productInfo.Name) .. "\"", 3)
					end
				end

				local sound = Instance.new("Sound")
				sound.Name = "_rbgm"
				sound.SoundId = "rbxassetid://" .. tostring(match)
				sound.Volume = clamp((tbl10.vol or 3) / 10, 0, 1)
				sound.Looped = true
				sound.Parent = SoundService
				sound:Play()
				tbl9.musicsound = sound

				tbl3.bindt(task.spawn(function()
					local n3 = clock() + 5

					while clock() < n3 do
						if sound.Parent ~= SoundService then
							return
						end

						if sound.IsLoaded then
							return
						end
						task.wait(0.25)
					end

					if sound.Parent == SoundService and not sound.IsLoaded then
						tbl3.notif("Music", (musicid and musicid ~= "" and "ID " .. tostring(match) or "\"" .. tostring(tbl10.track) .. "\"") .. " won't load. Pick another song.", 5)
					end
				end))
			end

			tbl3.hudbutton = function(name, arg, text, arg2, arg3)
				local screenGui = Instance.new("ScreenGui")
				screenGui.Name = name
				screenGui.ResetOnSpawn = false
				screenGui.IgnoreGuiInset = true
				screenGui.DisplayOrder = 58
				screenGui.Parent = v.ScreenGui or fn6 and fn6() or CoreGui
				local textButton = Instance.new("TextButton")
				textButton.AnchorPoint = Vector2.new(1, 0)
				textButton.Position = UDim2.new(1, -16, 0, arg)
				textButton.Size = UDim2.fromOffset(flag and 128 or 100, flag and 46 or 38)
				textButton.BackgroundColor3 = color
				textButton.BackgroundTransparency = 0.04
				textButton.BorderSizePixel = 0
				textButton.AutoButtonColor = false
				textButton.Font = Enum.Font.GothamBold
				textButton.TextSize = flag and 15 or 13
				textButton.TextColor3 = color2
				textButton.Text = text
				textButton.Parent = screenGui
				tbl3.corner(textButton, 10)
				local v5 = tbl3.stroke(textButton, color3, 1, 0.2)

				local function fn9()
					local v6, v7 = arg2()
					textButton.Text = v6
					textButton.BackgroundColor3 = v7 and accent or color
					textButton.TextColor3 = v7 and Color3.fromRGB(255, 255, 255) or color2
					v5.Color = v7 and accent or color3
				end

				textButton.Activated:Connect(function()
					arg3()
					fn9()
				end)

				tbl3.dragify(textButton, textButton)
				fn9()
				return screenGui, fn9
			end

			tbl3.deltlbtn = function()
				if tbl9.tlgui then
					tbl9.tlgui:Destroy()
					tbl9.tlgui = nil
				end

				tbl9.tlref = nil
			end

			tbl3.tlbtn = function()
				tbl3.deltlbtn()
				local v5 = tbl9
				local v6 = tbl9

				local v7, v8 = tbl3.hudbutton("\0_tl", 150, "LOCK: OFF", function()
					local value = toggles.targetlock.Value
					return value and "LOCK: ON" or "LOCK: OFF", value
				end, function()
					toggles.targetlock:SetValue(not toggles.targetlock.Value)
				end)

				v5.tlgui = v7
				v6.tlref = v8
			end

			tbl3.reftlui = function()
				if toggles.targetlockui and toggles.targetlockui.Value then
					tbl3.tlbtn()
				else
					tbl3.deltlbtn()
				end
			end

			tbl3.delmodebtn = function()
				if tbl9.modegui then
					tbl9.modegui:Destroy()
					tbl9.modegui = nil
				end

				tbl9.moderef = nil
			end

			tbl3.modebtn = function()
				tbl3.delmodebtn()
				local v5 = tbl9
				local v6 = tbl9

				local v7, v8 = tbl3.hudbutton("\0_md", 204, "AP", function()
					local value = toggles.triggerbot.Value
					local value2 = toggles.autoparry.Value
					return value and "TB" or value2 and "AP" or "OFF", value or value2
				end, function()
					if toggles.triggerbot.Value then
						toggles.triggerbot:SetValue(false)
						toggles.autoparry:SetValue(true)
					else
						toggles.autoparry:SetValue(false)
						toggles.triggerbot:SetValue(true)
					end
				end)

				v5.modegui = v7
				v6.moderef = v8
			end

			tbl3.refmodeui = function()
				if toggles.modeui and toggles.modeui.Value then
					tbl3.modebtn()
				else
					tbl3.delmodebtn()
				end
			end

			local unhook = nil
			local fn9 = nil
			local fn10 = nil
			local fn11 = nil

			tbl3.cleanup = function()
				tbl3.stopap()
				tbl3.stopas()
				tbl3.stopms()
				tbl3.stopabil()
				tbl3.stopbestcfg()
				tbl10.thundernocd = false
				tbl3.setnocd()
				tbl3.delmsgui()
				tbl3.deltlbtn()
				tbl3.delmodebtn()
				tbl3.lockhl(nil)
				tbl9.plrforc = false
				tbl3.stopstaff()

				if tbl9.vzdash then
					for _, v5 in ipairs(tbl9.vzdash) do
						v5:Destroy()
					end

					tbl9.vzdash = nil
				end

				if tbl9.vzpart then
					tbl9.vzpart:Destroy()
					tbl9.vzpart = nil
				end

				tbl3.clrbt()
				tbl3.clrpt()
				tbl3.espstop()

				if tbl3.restorecos then
					tbl3.restorecos()
				end

				tbl3.setbright(false)
				tbl3.setnofog(false)
				tbl3.setlowgfx(false)

				if tbl14.gravorig ~= nil then
					Workspace.Gravity = tbl14.gravorig
					tbl14.gravorig = nil
				end

				tbl3.restorefov()
				tbl3.applysky("Default")
				tbl3.settime("Default")
				tbl3.stopafk()
				tbl3.stopphantom()
				tbl3.killvip()
				tbl3.clrshade()
				tbl3.clrrain()
				tbl3.stopmusic()

				for _, v5 in ipairs(tbl9.slashoff) do
					v5:Enable()
				end

				if fn10 then
					fn10()
				end

				if unhook then
					unhook()
				end

				if setfpscap then
					setfpscap(0)
				end

				if tbl3.ewrestore then
					tbl3.ewrestore()
				end

				for _, v5 in ipairs({ "LobbyParry", "RainbowBall", "ShowSwordAccessory" }) do
					localPlayer:SetAttribute(v5, nil)
				end
			end

			toggles.autoparry:OnChanged(function(autoparry)
				tbl10.autoparry = autoparry

				if autoparry then
					tbl3.startap()

					if toggles.triggerbot.Value then
						toggles.triggerbot:SetValue(false)
					end
				else
					tbl3.stopap()
				end

				if tbl9.moderef then
					tbl9.moderef()
				end
			end)

			toggles.modeui:OnChanged(function()
				tbl3.refmodeui()
			end)

			toggles.targetlock:OnChanged(function(tlock)
				tbl10.tlock = tlock

				if tlock then
					local v5 = tbl3.aimedplr() or tbl3.closestplr()
					tbl9.locked = v5
					tbl3.lockhl(v5)

					if v5 then
						tbl3.notif("Target Lock", "Locked onto " .. tostring(v5.Name) .. ".", 3)
					else
						tbl3.notif("Target Lock", "No target. Aim at someone and try again.", 3)
					end
				else
					tbl9.locked = nil
					tbl3.lockhl(nil)
					tbl3.notif("Target Lock", "Off.", 2)
				end

				if tbl9.tlref then
					tbl9.tlref()
				end
			end)

			tbl3.randtgt = function()if not  alive then return nil;end;local l={};for K,K in ipairs( alive :GetChildren())do if K.PrimaryPart and(K:FindFirstChildOfClass("Humanoid"))and( tbl3 .validtgt(K))then l[#l+1]=K;end;end;if#l==0 then return nil;end;return l[math.random(1,#l)];end

			tbl3.startrt = function()
				if tbl9.rtconn then
					tbl9.rtconn:Disconnect()
				end

				tbl9.rtconn = RunService.Heartbeat:Connect(function()if not  tbl10 .randtgt then return;end;local l= tbl9 .locked;if not(l and l.Parent== alive and(l.PrimaryPart or(l:FindFirstChild("HumanoidRootPart"))))or  clock ()-( tbl9 .lastrand or 0)>( tbl10 .randtime or 3)then  tbl9 .locked= tbl3 .randtgt(); tbl9 .lastrand= clock (); tbl3 .lockhl( tbl9 .locked);end;end)
				tbl3.bind(tbl9.rtconn)
			end

			tbl3.stoprt = function()
				if tbl9.rtconn then
					tbl9.rtconn:Disconnect()
					tbl9.rtconn = nil
				end

				if not tbl10.tlock then
					tbl9.locked = nil
					tbl3.lockhl(nil)
				end
			end

			toggles.randomtarget:OnChanged(function(randtgt)
				tbl10.randtgt = randtgt

				if randtgt then
					tbl9.lastrand = 0
					tbl3.startrt()
					tbl3.notif("Random Target", "Aiming at random players.", 3)
				else
					tbl3.stoprt()
					tbl3.notif("Random Target", "Off.", 2)
				end
			end)

			options.randomtargettime:OnChanged(function(randtime)
				tbl10.randtime = randtime
			end)

			toggles.targetlockui:OnChanged(function(tlockui)
				tbl10.tlockui = tlockui
				tbl3.reftlui()
			end)

			options.curvestrength:OnChanged(function(crvstr)
				tbl10.crvstr = crvstr
			end)

			options.curves:OnChanged(function(crv)
				tbl10.crv = crv
			end)

			local curveorder = tbl3.curveorder

			options.curvekey:OnClick(function()
				local value = options.curves.Value
				local n3 = 1

				for i, v5 in ipairs(curveorder) do
					if v5 == value then
						n3 = i
						break
					end
				end

				local v5 = curveorder[n3 % #curveorder + 1]
				options.curves:SetValue(v5)
				tbl10.crv = v5
				tbl3.notif("Curve", "Curve set to " .. v5 .. ".", 2)
			end)

			toggles.curvekb:OnChanged(function(curvekb)
				tbl10.curvekb = curvekb
			end)

			local curveorder2 = tbl3.curveorder

			local tbl19 = {
				[Enum.KeyCode.One] = 1,
				[Enum.KeyCode.Two] = 2,
				[Enum.KeyCode.Three] = 3,
				[Enum.KeyCode.Four] = 4,
				[Enum.KeyCode.Five] = 5,
				[Enum.KeyCode.Six] = 6,
				[Enum.KeyCode.Seven] = 7,
				[Enum.KeyCode.Eight] = 8,
				[Enum.KeyCode.Nine] = 9,
			}

			tbl3.bind(UserInputService.InputBegan:Connect(function(l,K)if K or not  tbl10 .curvekb then return;end;K= curveorder2 [ tbl19 [l.KeyCode]or 0];if K then  options .curves:SetValue(K); tbl10 .crv=K; tbl3 .notif("Curve","Curve set to "..K..".",2);end;end))

			toggles.advcrv:OnChanged(function(advcrv)
				tbl10.advcrv = advcrv
			end)

			toggles.dribblepreclick:OnChanged(function(drbpre)
				tbl10.drbpre = drbpre
			end)

			toggles.sofcounter:OnChanged(function(sofctr)
				tbl10.sofctr = sofctr
			end)

			toggles.triggerbot:OnChanged(function(trigger)
				tbl10.trigger = trigger

				if trigger then
					tbl3.starttrigger()

					if toggles.autoparry.Value then
						toggles.autoparry:SetValue(false)
					end
				else
					tbl3.stoptrigger()
				end

				if tbl9.moderef then
					tbl9.moderef()
				end
			end)

			options.sofmode:OnChanged(function(sofmode)
				tbl10.sofmode = sofmode
			end)

			options.sofdelay:OnChanged(function(sofdelay)
				tbl10.sofdelay = sofdelay
			end)

			toggles.pulldetect:OnChanged(function(pulldetect)
				tbl10.pulldetect = pulldetect
			end)

			toggles.nocurvespam:OnChanged(function(nocrv)
				tbl10.nocrv = nocrv
			end)

			options.socrv:OnChanged(function(socrv)
				tbl10.socrv = socrv
			end)

			options.nscrv:OnChanged(function(nscrv)
				tbl10.nscrv = nscrv
			end)

			options.parryaccuracy:OnChanged(function(acc)
				tbl10.acc = acc
			end)

			options.parryrange:OnChanged(function(rng)
				tbl10.rng = rng
			end)

			toggles.autobestconfig:OnChanged(function(bestcfg)
				tbl10.bestcfg = bestcfg

				if bestcfg then
					tbl3.startbestcfg()
				else
					tbl3.stopbestcfg()
				end
			end)

			toggles.antiafk:OnChanged(function(antiafk)
				tbl10.antiafk = antiafk

				if antiafk then
					tbl3.startafk()
				else
					tbl3.stopafk()
				end
			end)

			toggles.autoexecute:OnChanged(function(autoexec)
				tbl10.autoexec = autoexec

				if autoexec then
					tbl3.queuetp()
				elseif tbl3.queued then
					tbl3.notif("Auto Execute", "Off. It still runs once more after your next teleport.", 6)
				end
			end)

			toggles.viptag:OnChanged(function(viptag)
				tbl10.viptag = viptag
				tbl3.applyvip()
			end)

			toggles.shaders:OnChanged(function(shaders)
				tbl10.shaders = shaders
				tbl3.applyshade()
			end)

			options.shaderpreset:OnChanged(function(shaderpreset)
				tbl10.shaderpreset = shaderpreset
				tbl3.applyshade()
			end)

			toggles.shaderdof:OnChanged(function(dof)
				tbl10.dof = dof
				tbl3.applyshade()
			end)

			options.shaderbloom:OnChanged(function(bloom)
				tbl10.bloom = bloom
				tbl3.applyshade()
			end)

			options.shadersaturation:OnChanged(function(saturation)
				tbl10.saturation = saturation
				tbl3.applyshade()
			end)

			options.shaderbrightness:OnChanged(function(brightness)
				tbl10.brightness = brightness
				tbl3.applyshade()
			end)

			options.shadercontrast:OnChanged(function(contrast)
				tbl10.contrast = contrast
				tbl3.applyshade()
			end)

			toggles.raineffect:OnChanged(function(rain)
				tbl10.rain = rain
				tbl3.applyrain()
			end)

			options.rainintensity:OnChanged(function(rainrate)
				tbl10.rainrate = rainrate
			end)

			toggles.autospam:OnChanged(function(autospam)
				tbl10.autospam = autospam

				if autospam then
					tbl3.startas()
					tbl3.notif("Auto Spam", "On.", 3)
				else
					tbl3.stopas()
					tbl3.notif("Auto Spam", "Off.", 3)
				end
			end)

			toggles.manualspam:OnChanged(function(manspam)
				tbl10.manspam = manspam

				if manspam then
					tbl3.startms()
					tbl3.refmsui()
				else
					tbl3.setmsactive(false)
					tbl3.delmsgui()
					tbl3.stopms()
				end
			end)

			options.parrymethod:OnChanged(function(arg)
				tbl10.keyparry = arg == "Keypress"
			end)

			toggles.norender:OnChanged(function(norender)
				tbl10.norender = norender
				tbl3.setnorender()
			end)

			toggles.emoteonly:OnChanged(function(emoteonly)
				tbl10.emoteonly = emoteonly

				if emoteonly then
					if tbl3.emoteonly then
						tbl3.emoteonly(true)
					end
				end
			end)

			toggles.manualspamui:OnChanged(function(mansui)
				tbl10.mansui = mansui

				if tbl10.manspam then
					tbl3.refmsui()
				end
			end)

			toggles.autoability:OnChanged(function(autoabil)
				if autoabil and not tbl3.featguard("abil", "Auto Ability") then
					toggles.autoability:SetValue(false)
					return
				end
				tbl10.autoabil = autoabil

				if tbl10.autoabil or tbl10.cdprot then
					tbl3.startabil()
				else
					tbl3.stopabil()
				end
			end)

			toggles.cooldownprotection:OnChanged(function(cdprot)
				if cdprot and not tbl3.featguard("abil", "Cooldown Protection") then
					toggles.cooldownprotection:SetValue(false)
					return
				end
				tbl10.cdprot = cdprot

				if tbl10.autoabil or tbl10.cdprot then
					tbl3.startabil()
				else
					tbl3.stopabil()
				end
			end)

			toggles.thundernocd:OnChanged(function(thundernocd)
				tbl10.thundernocd = thundernocd
				tbl3.setnocd()
			end)

			options.abilityminspeed:OnChanged(function(abilspd)
				tbl10.abilspd = abilspd
			end)

			toggles.staffdetection:OnChanged(function(staff)
				tbl10.staff = staff

				if staff then
					tbl3.startstaff()
				else
					tbl3.stopstaff()
				end
			end)

			options.staffaction:OnChanged(function(staffdo)
				tbl10.staffdo = staffdo
			end)

			toggles.visualizer:OnChanged(function(viz)
				tbl10.viz = viz
				tbl3.setupviz()
			end)

			options.visualizercolour:OnChanged(function(vizcol)
				tbl10.vizcol = vizcol
			end)

			tbl3.setaccent = function(arg)
				v.Scheme.AccentColor = arg or options.uiaccent and options.uiaccent.Value or tbl3.accent
				v:UpdateColorsUsingRegistry()
			end

			options.uiaccent:OnChanged(function(arg)
				tbl3.setaccent(arg)
			end)

			toggles.balltrail:OnChanged(function(bt)
				tbl10.bt = bt

				if bt then
					tbl3.applybt()
				else
					tbl3.clrbt()
				end
			end)

			toggles.balltrailrainbow:OnChanged(function(btrb)
				tbl10.btrb = btrb

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.balltrailparticles:OnChanged(function(btpart)
				tbl10.btpart = btpart

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.balltrailglow:OnChanged(function(btglow)
				tbl10.btglow = btglow

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltrailstartcolour:OnChanged(function(btstart)
				tbl10.btstart = btstart

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltrailendcolour:OnChanged(function(btend)
				tbl10.btend = btend

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			options.balltraillifetime:OnChanged(function(btlife)
				tbl10.btlife = btlife

				if tbl10.bt then
					tbl3.refbt()
				end
			end)

			toggles.playertrail:OnChanged(function(pt)
				tbl10.pt = pt

				if pt then
					tbl3.applypt()
				else
					tbl3.clrpt()
				end
			end)

			toggles.playertrailrainbow:OnChanged(function(ptrb)
				tbl10.ptrb = ptrb

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertrailcolour:OnChanged(function(ptcol)
				tbl10.ptcol = ptcol

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertraillifetime:OnChanged(function(ptlife)
				tbl10.ptlife = ptlife

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			options.playertrailwidth:OnChanged(function(ptwidth)
				tbl10.ptwidth = ptwidth

				if tbl10.pt then
					tbl3.refpt()
				end
			end)

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				task.wait(0.5)

				if tbl10.pt then
					tbl3.applypt()
				end
			end))

			toggles.abilityesp:OnChanged(function(arg)
				if arg then
					tbl3.espstart()
				else
					tbl3.espstop()
				end
			end)

			toggles.fullbright:OnChanged(function(arg)
				tbl3.setbright(arg)
			end)

			toggles.nofog:OnChanged(function(arg)
				tbl3.setnofog(arg)
			end)

			toggles.customfov:OnChanged(function(arg)
				if arg then
					tbl3.startfov()
				else
					tbl3.restorefov()
				end
			end)

			toggles.customgrav:OnChanged(function()
				tbl3.setgrav()
			end)

			options.grav:OnChanged(function()
				if toggles.customgrav.Value then
					tbl3.setgrav()
				end
			end)

			toggles.lowgfx:OnChanged(function(arg)
				tbl3.setlowgfx(arg)
			end)

			toggles.fpscap:OnChanged(function(fpscap)
				tbl10.fpscap = fpscap
				tbl3.applycap()
			end)

			toggles.antilag:OnChanged(function(arg)
				if arg then
					tbl3.startantilag()
				elseif tbl9.alapplied then
					tbl9.alapplied = false

					if not (toggles.lowgfx and toggles.lowgfx.Value) then
						tbl3.setlowgfx(false)
					end
				end
			end)

			options.fpscapvalue:OnChanged(function(fpsval)
				tbl10.fpsval = fpsval

				if tbl10.fpscap then
					tbl3.applycap()
				end
			end)

			toggles.ffenable:OnChanged(function(arg)
				if not arg then
					return
				end
				toggles.ffenable:SetValue(false)

				if tbl3.ffapply() > 0 then
					tbl3.notif("FFlags", "Rejoining to apply your flags.", 3)

					task.delay(1.5, function()
						if fn3 then
							fn3()
						end
					end)
				end
			end)

			options.skybox:OnChanged(function(arg)
				tbl3.applysky(arg)

				if arg == "Default" then
					tbl3.notif("Skybox", "Reset to default.", 2)
				else
					tbl3.notif("Skybox", "Set to \"" .. tostring(arg) .. "\".", 2)
				end
			end)

			options.timeofday:OnChanged(function(arg)
				tbl3.settime(arg)
			end)

			toggles.music:OnChanged(function(music)
				tbl10.music = music
				tbl3.setupmusic()
			end)

			options.musictrack:OnChanged(function(track)
				tbl10.track = track

				if tbl10.music then
					tbl3.setupmusic()
				end
			end)

			options.musicvolume:OnChanged(function(vol)
				tbl10.vol = vol

				if tbl9.musicsound then
					tbl9.musicsound.Volume = clamp(vol / 10, 0, 1)
				end
			end)

			options.musiccustom:OnChanged(function(musicid)
				tbl10.musicid = musicid or ""

				if tbl10.music then
					tbl3.setupmusic()
				end
			end)

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				if toggles.customgrav.Value then
					task.defer(tbl3.setgrav)
				end
			end))

			_G.stagesh = "handlers"
			tbl3.chkfeat()

			tbl3.onstart = {
				{
					flag = "abilityesp",
					run = function()
						tbl3.espstart()
					end,
				},
				{
					flag = "fullbright",
					run = function()
						tbl3.setbright(true)
					end,
				},
				{
					flag = "nofog",
					run = function()
						tbl3.setnofog(true)
					end,
				},
				{
					flag = "customgrav",
					run = function()
						tbl3.setgrav()
					end,
				},
				{
					flag = "lowgfx",
					run = function()
						tbl3.setlowgfx(true)
					end,
				},
				{
					flag = "norender",
					run = function()
						tbl3.setnorender()
					end,
				},
				{
					flag = "thundernocd",
					run = function()
						tbl3.setnocd()
					end,
				},
				{
					flag = "emoteonly",
					run = function()
						if tbl3.emoteonly then
							tbl3.emoteonly(true)
						end
					end,
				},
				{
					flag = "antilag",
					run = function()
						tbl3.startantilag()
					end,
				},
				{ run = function()
					tbl3.applycap()

					if tbl10.fpscap then
						tbl3.notif("FPS Cap", format("FPS capped at %d. Change it in Performance.", tbl10.fpsval or 60), 6)
					end

					if options.skybox.Value and options.skybox.Value ~= "Default" then
						tbl3.applysky(options.skybox.Value)
					end

					if options.timeofday.Value and options.timeofday.Value ~= "Default" then
						tbl3.settime(options.timeofday.Value)
					end
				end },
				{
					flag = "autoparry",
					run = function()
						tbl3.startap()
					end,
				},
				{
					flag = "triggerbot",
					run = function()
						tbl3.starttrigger()

						if tbl10.autoparry then
							tbl10.autoparry = false
							tbl3.stopap()
							toggles.autoparry:SetValue(false)
						end
					end,
				},
				{
					flag = "autospam",
					run = function()
						tbl3.startas()
					end,
				},
				{
					flag = "autobestconfig",
					run = function()
						tbl3.startbestcfg()
					end,
				},
				{
					flag = "manualspam",
					run = function()
						tbl3.startms()
						tbl3.refmsui()
					end,
				},
				{
					flag = "targetlockui",
					run = function()
						tbl3.reftlui()
					end,
				},
				{
					flag = "modeui",
					run = function()
						tbl3.refmodeui()
					end,
				},
				{
					flag = "randomtarget",
					run = function()
						tbl9.lastrand = 0
						tbl3.startrt()
					end,
				},
				{ run = function()
					if toggles.autoability.Value or toggles.cooldownprotection.Value then
						tbl3.startabil()
					end
				end },
				{
					flag = "staffdetection",
					run = function()
						tbl3.startstaff()
					end,
				},
				{
					flag = "visualizer",
					run = function()
						tbl3.setupviz()
					end,
				},
				{
					flag = "balltrail",
					run = function()
						tbl3.applybt()
					end,
				},
				{
					flag = "playertrail",
					run = function()
						tbl3.applypt()
					end,
				},
				{ run = function()
					if (toggles.headless.Value or toggles.korblox.Value) and tbl3.applycos then
						tbl3.applycos()
					end
				end },
				{
					flag = "antiafk",
					run = function()
						tbl3.startafk()
					end,
				},
				{
					flag = "autoexecute",
					run = function()
						tbl3.queuetp()
					end,
				},
				{
					flag = "viptag",
					run = function()
						tbl3.applyvip()
					end,
				},
				{
					flag = "shaders",
					run = function()
						tbl3.applyshade()
					end,
				},
				{
					flag = "raineffect",
					run = function()
						tbl3.applyrain()
					end,
				},
				{
					flag = "music",
					run = function()
						tbl3.setupmusic()
					end,
				},
				{ run = function()
					if tbl10.devscreen and tbl10.devscreen ~= "Off" then
						tbl3.devui(tbl10.devscreen, true)
					end

					if tbl10.devtype and tbl10.devtype ~= "Off" then
						tbl3.devarm(tbl10.devtype, true)
					end

					tbl3.devstat()
				end },
				{ run = function()
					if toggles.unlockall and toggles.unlockall.Value and fn9 then
						fn9()
					elseif toggles.equipautoload and toggles.equipautoload.Value and fn11 then
						fn11(false)
					end
				end },
			}

			local tbl20 = {}

			for _, v5 in ipairs(tbl3.onstart) do
				if v5.flag and not toggles[v5.flag] then
					tbl20[#tbl20 + 1] = v5.flag
				end
			end

			if #tbl20 > 0 then
				table.sort(tbl20)
				warn("[Rise] startup list points at toggles that do not exist: " .. table.concat(tbl20, ", "))
			end

			tbl3.bootstrap_saved_connections = function()
				tbl3.syncopt()
				tbl3.sendping()
				tbl3.ffload()

				if options.uiaccent then
					tbl3.setaccent(options.uiaccent.Value)
				end

				if toggles.customfov.Value then
					tbl3.startfov()
				end

				tbl3.startdatapanel()
				tbl3.bindt(task.spawn(tbl3.claimdaily))

				for _, v5 in ipairs(tbl3.onstart) do
					local flag2 = v5.flag and toggles[v5.flag]

					if not v5.flag or flag2 and flag2.Value then
						v5.run()
					end
				end
			end

			tbl3.loadsave()
			v2:LoadAutoloadConfig()
			tbl3.hooksave()
			_G.stagesh = "config"

			task.spawn(function()
				task.wait(0.2)
				tbl3.bootstrap_saved_connections()
			end)

			_G.stagesh = "boot"
			local Replion = require(ReplicatedStorage.Packages.Replion)
			local misc = ReplicatedStorage:FindFirstChild("Misc")
			local v5 = nil
			local client = nil
			local v6 = nil
			local v7 = nil
			local v8 = nil
			local v9 = nil
			local swords = nil
			local function fn12()if setthreadidentity then setthreadidentity(8);end;end
			local function fn13(l)if not l then return nil;end; fn12 ();return require(l);end
			local function fn14(h,...)local l=h;for h=1,select("#",...),1 do if typeof(l)~="Instance"then return nil;end;l=(l:FindFirstChild((select(h,...))));end;return l;end

			local tbl21 = {
				wheelfile = "Rise_Wheel_" .. tostring(game.GameId) .. ".json",
				wheel = {},
				equipfile = "Rise_Equip_" .. tostring(game.GameId) .. ".json",
				equip = {},
				ncfile = "Rise_UnlockNames_" .. tostring(game.GameId) .. ".json",
				hooked = false,
				guihooked = false,
				explhooked = false,
				trove = nil,
				noacc = false,
				explname = nil,
				offconns = {},
				lost = true,
			}

			local fn15 = nil

			local function fn16(arg)
				if not Replion then
					Replion = fn13(fn14(ReplicatedStorage, "Packages", "Replion"))
				end

				if not Replion then
					tbl3.logwev("uaReplion", 10, "UnlockAll", "Replion module unavailable (require failed)")
					return nil
				end
				local replion = Replion.Client:GetReplion(arg)
				if replion then
					return replion
				end
				local n3 = clock() + 5

				while clock() < n3 do
					task.wait(0.1)
					local replion2 = Replion.Client:GetReplion(arg)
					if replion2 then
						return replion2
					end
				end

				return nil
			end

			local tbl22 = {}
			local v10 = nil
			local v11 = nil

			local function fn17(arg)
				if not v11 then
					local collection = type(v10) == "table" and type(v10.GetCollection) == "function" and v10:GetCollection() or nil

					if type(collection) == "table" and next(collection) then
						v11 = collection
					end
				end

				return v11 and v11[arg] or nil
			end

			local function fn18(arg, arg2)
				if arg ~= "Sword" then
					return { Name = arg2, Id = arg2 }
				end
				local sword = tbl22[arg2]

				if sword == nil then
					sword = swords and swords.GetSword and swords:GetSword(arg2) or false
					tbl22[arg2] = sword
				end

				local tbl23 = { Name = arg2, Id = arg2 }

				if type(sword) == "table" then
					if sword.HasFinisher then
						tbl23.Finisher = true
					end

					if sword.AccessoryUnlockable and fn17(arg2) then
						tbl23.Accessory = true
					end
				end

				return tbl23
			end

			local function fn19(arg, arg2)
				if client and client.ItemToKey then
					local v12 = client:ItemToKey(arg, fn18(arg, arg2), { "Id" })
					if type(v12) == "string" then
						return v12
					end
				end

				return HttpService:JSONEncode({ { "Name", arg2 } }) or arg2
			end

			local function fn20(arg, arg2)
				if type(arg) ~= "string" then
					return tostring(arg)
				end

				if client and client.KeyToItem then
					local v12 = client:KeyToItem(arg)
					if type(v12) == "table" and v12.Name then
						return v12.Name
					end
				end

				local str3 = arg:sub(1, 1)

				if str3 == "[" or str3 == "{" then
					local data = HttpService:JSONDecode(arg)

					if type(data) == "table" then
						for _, v12 in ipairs(data) do
							if v12[1] == "Name" then
								return v12[2]
							end
						end

						if data.Name then
							return data.Name
						end
					end
				end

				if arg2 and Replion and Replion.Client then
					local replion = Replion.Client:GetReplion("Inventory")
					replion = replion and replion:Get({ "Inventory", arg2, arg })
					if type(replion) == "table" and replion.Name then
						return replion.Name
					end
				end

				return arg
			end

			local function fn21(arg)
				local tbl23 = {}
				local v12 = misc and misc:FindFirstChild(arg)

				if v12 then
					for _, child in ipairs(v12:GetChildren()) do
						tbl23[#tbl23 + 1] = child.Name
					end
				end

				return tbl23
			end

			local function fn22()
				local tbl23 = {}

				if swords and swords.GetCollection then
					local collection = swords:GetCollection()

					if type(collection) == "table" then
						for k in pairs(collection) do
							tbl23[#tbl23 + 1] = k
						end
					end
				end

				return tbl23
			end

			local function fn23(arg, arg2)
				local character = localPlayer.Character
				if arg ~= nil then
					return arg == localPlayer or arg == character
				end
				return arg2 ~= nil and arg2 == character
			end

			local function fn24()
				if tbl21.explhooked then
					return
				end
				local v12 = fn13(fn14(ReplicatedStorage, "Controllers", "VFXController"))
				if type(v12) ~= "table" or type(v12.PlayExplosion) ~= "function" then
					return
				end
				tbl21.explmod = v12
				tbl21.explorig = v12.PlayExplosion
				v12.PlayExplosion = function(l,K,p,E,k,a,d,...)local I= tbl21 .explname and  tbl21 .explname~=""and  tbl21 .explname~=K;return  tbl21 .explorig(l,if I and( fn23 (a,k))then  tbl21 .explname else K,p,E,k,a,d,...);end
				tbl21.explhooked = true
			end

			local function fn25(arg, arg2)
				local Inventory = fn16("Inventory")
				if not (Inventory and type(Inventory._set) == "function") then
					return
				end
				Inventory:_set({ "Equipped", arg }, { Name = arg2, Id = fn19(arg, arg2) })
			end

			local function fn26(arg, arg2)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return
				end
				local v12 = fn19(arg, arg2)

				if type(Inventory._update) == "function" then
					Inventory:_update({ "Inventory", arg }, { [v12] = fn18(arg, arg2) })
				elseif type(Inventory._set) == "function" then
					local v13 = Inventory:Get({ "Inventory", arg })
					local tbl23 = {}

					if type(v13) == "table" then
						for k, v14 in pairs(v13) do
							tbl23[k] = v14
						end
					end

					tbl23[v12] = fn18(arg, arg2)
					Inventory:_set({ "Inventory", arg }, tbl23)
				end
			end

			tbl21.verifyeq = function(arg, arg2)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return false
				end
				local v12 = Inventory:Get({ "Equipped", arg })
				return type(v12) == "table" and v12.Name == arg2
			end

			tbl21.ensureeq = function(arg, arg2)
				tbl21.eqlatest = tbl21.eqlatest or {}
				tbl21.eqlatest[arg] = arg2

				tbl3.bindt(task.spawn(function()
					for i = 1, 4 do
						if tbl21.eqlatest[arg] ~= arg2 then
							return
						end

						if tbl21.verifyeq(arg, arg2) then
							return
						end
						task.wait(0.35)
						if tbl21.eqlatest[arg] ~= arg2 then
							return
						end
						fn26(arg, arg2)
						fn25(arg, arg2)
					end
				end))
			end

			local function fn27(arg, swname, arg2)
				if not swname or swname == "" then
					return
				end

				if arg == "Sword" then
					tbl10.swskin = true
					tbl10.swname = swname
					tbl21.skinmine = true
					tbl3.initsword()
					tbl3.hookslash()
					tbl3.skinloop()

					if tbl3.applysword() == false then
						tbl10.swskin = false
						tbl10.swname = ""
						return
					end

					tbl3.setswattr(swname)
					fn26("Sword", swname)
					fn25("Sword", swname)
					tbl21.ensureeq("Sword", swname)

					if tbl21.finequip then
						tbl21.finequip(swname)
					end
				elseif arg == "Explosion" then
					tbl21.explname = swname
					fn24()

					if tbl21.prefetch then
						tbl21.prefetch("Explosions", swname)
					end

					fn26("Explosion", swname)
					fn25("Explosion", swname)
					tbl21.ensureeq("Explosion", swname)
				elseif arg == "Emote" then
					fn26("Emote", swname)
				end

				if not arg2 and (arg == "Sword" or arg == "Explosion") then
					tbl21.equip[arg] = swname

					if fn15 then
						fn15()
					end
				end
			end

			tbl21.cursword = function()local l= tbl10 .swname;return if not l or l==""then( tbl3 .swequipped())else l;end

			tbl3.uaawaken = function()
				tbl21.arm()
				local v12 = tbl21.cursword()
				if not v12 or v12 == "" then
					return
				end
				swords = swords or tbl3.initsword()
				if not swords then
					tbl3.notif("Unlock All", "Swords aren't ready yet. Try again in a second.", 4)
					return
				end
				local str3 = "Awakened " .. v12

				if swords:GetSword(str3) ~= nil then
					fn27("Sword", str3)
					tbl3.notif("Unlock All", "Equipped \"" .. str3 .. "\".", 3)
				else
					tbl3.notif("Unlock All", v12 .. " has no awakened version.", 3)
				end
			end

			tbl3.uaequipall = function()
				tbl21.arm()

				for _, v12 in ipairs({ "Sword", "Explosion" }) do
					local v13 = tbl21.equip[v12]

					if type(v13) == "string" and v13 ~= "" then
						fn27(v12, v13, true)
					end
				end

				if tbl21.wheel then
					for _, v12 in pairs(tbl21.wheel) do
						if type(v12) == "string" and v12 ~= "" then
							fn26("Emote", v12)
						end
					end
				end

				tbl3.notif("Unlock All", "Your saved loadout is equipped.", 3)
			end

			tbl3.uapreviewfin = function()
				if tbl21.finbusy then
					return
				end
				local v12 = tbl21.finfor(tbl21.cursword())

				if not v12 and options.swordchangername then
					v12 = tbl21.finfor(options.swordchangername.Value)
				end

				if not v12 then
					tbl3.notif("Finisher", "That sword has no finisher.", 4)
					return
				end

				if tbl3.isalive() then
					tbl3.notif("Finisher", "Preview only works in the lobby, not mid-round.", 5)
					return
				end
				local v13 = tbl21.finctrl()
				if not v13 or type(v13.Preview) ~= "function" then
					tbl3.notif("Finisher", "Finishers aren't loaded yet. Try again in a second.", 5)
					return
				end
				local featuresToggle = fn14(ReplicatedStorage, "FeaturesToggle", "LimitedSwords")
				if featuresToggle and featuresToggle.Value == false then
					tbl3.notif("Finisher", "The game has showrooms turned off right now.", 5)
					return
				end
				tbl21.finbusy = true

				tbl3.bindt(task.spawn(function()
					if not tbl21.repasset("Finishers", v12) then
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("Couldn't load the %s finisher."):format(v12), 5)
						return
					end

					if not tbl21.finplayable(v12) then
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher isn't loaded yet."):format(v12), 5)
						return
					end

					tbl3.bindt(task.delay(tbl21.findur(v12) + 2, function()
						tbl21.finbusy = false
					end))

					v13:Preview(v12)

					if setthreadidentity and tbl3.baseident then
						setthreadidentity(tbl3.baseident)
					end
				end))
			end

			tbl21.applyacc = function()
				tbl9.noacc = tbl21.noacc
				localPlayer:SetAttribute("ShowSwordAccessory", not tbl21.noacc)
				local swname = tbl10.swname
				local v12 = tbl3.safechar()
				if not (swname and swname ~= "" and v12 and swords) or tbl9.swbad[swname] then
					return
				end

				tbl3.bindt(task.spawn(function()
					if type(swords.GetInstance) == "function" then
						if not swords:GetInstance(swname) then
							tbl9.swbad[swname] = true
							return
						end
					end

					if not v12.Parent then
						return
					end

					for _, child in ipairs(v12:GetChildren()) do
						if child:IsA("Model") and swords:GetSword(child.Name) then
							child:Destroy()
						end
					end

					tbl3.equipsword(v12, swname, tbl21.noacc, true)

					if tbl9.swctrl and tbl9.swctrl.SetSword then
						tbl9.swctrl:SetSword(swname)
					end
				end))
			end

			local function fn28()
				if tbl21.snapping then
					return false
				end
				tbl21.snapping = true
				local Inventory = fn16("Inventory")
				local owned = { Sword = {}, Explosion = {}, Emote = {} }
				local flag2 = false

				if Inventory then
					for _, v12 in ipairs({ "Sword", "Explosion", "Emote" }) do
						local v13 = Inventory:Get({ "Inventory", v12 })

						if type(v13) == "table" then
							for _, v14 in pairs(v13) do
								if type(v14) == "table" and v14.Name then
									owned[v12][v14.Name] = true
								end
							end
						end
					end

					flag2 = true
				end

				tbl21.snapping = false
				if not flag2 then
					return false
				end
				tbl21.owned = owned
				tbl21.ownedat = clock()
				return true
			end

			local function fn29(arg, arg2)
				if not arg or not arg2 then
					return false
				end

				if not tbl21.owned then
					tbl3.bindt(task.spawn(fn28))
					return false
				end
				local flag2 = not tbl21.everunlocked

				if flag2 then
					flag2 = clock() - (tbl21.ownedat or 0) > 5
				end

				if flag2 then
					tbl3.bindt(task.spawn(fn28))
				end

				return tbl21.owned[arg] and tbl21.owned[arg][arg2] == true or false
			end

			local function fn30()
				if tbl21.everunlocked then
					return
				end

				if not tbl21.owned and not fn28() then
					return
				end
				tbl21.everunlocked = true
			end

			local function fn31(arg)
				if not arg or arg.done then
					return
				end
				arg.done = true

				for _, v12 in ipairs(arg) do
					rawset(v12.sig, "_handlerListHead", v12.head)
				end
			end

			local function fn32(arg, arg2)
				local value = arg._signals and rawget(arg._signals, "_containers")
				value = value and value.onChange
				value = value and value.Inventory
				if not value then
					return nil
				end
				local tbl23 = {}

				for _, v12 in ipairs(arg2) do
					local v13 = value[v12]
					local value2 = v13 and rawget(v13, "__signal")
					local value3 = value2 and rawget(value2, "_handlerListHead")

					if value3 ~= nil and value3 ~= false then
						tbl23[#tbl23 + 1] = { sig = value2, head = value3 }
						rawset(value2, "_handlerListHead", false)
					end
				end

				if #tbl23 == 0 then
					return nil
				end
				tbl3.bindt(task.defer(fn31, tbl23))
				return tbl23
			end

			local function fn33(arg)
				local Inventory = fn16("Inventory")
				if not Inventory then
					return false
				end
				local tbl23 = {}
				local tbl24 = {}
				local flag2 = type(Inventory._update) == "function"
				local flag3 = false

				for k, v12 in pairs(arg) do
					local v13 = Inventory:Get({ "Inventory", k })
					local tbl25 = {}

					if type(v13) == "table" then
						for k2, v14 in pairs(v13) do
							tbl25[k2] = v14
						end
					end

					local owned = tbl21.owned and tbl21.owned[k] or {}
					local v14 = nil
					local v15 = nil
					local n3 = 0

					for _, v16 in ipairs(v12) do
						local v17 = fn19(k, v16)

						if tbl25[v17] == nil and not owned[v16] then
							local v18 = fn18(k, v16)

							if flag2 and not v14 then
								v14 = v17
								v15 = v18
							else
								tbl25[v17] = v18
							end

							n3 += 1
						end
					end

					if n3 > 0 then
						tbl23[k] = tbl25
						flag3 = true

						if v14 then
							tbl24[#tbl24 + 1] = { k, v14, v15 }
						end
					end
				end

				if not flag3 then
					return true
				end
				local tbl25 = {}

				for k in pairs(tbl23) do
					tbl25[#tbl25 + 1] = k
				end

				local v12 = fn32(Inventory, tbl25)
				local flag4

				if flag2 then
					Inventory:_update({ "Inventory" }, tbl23)
					flag4 = true
				else
					flag4 = false

					if type(Inventory._set) == "function" then
						for k, v13 in pairs(tbl23) do
							Inventory:_set({ "Inventory", k }, v13)
						end

						flag4 = true
					end
				end

				fn31(v12)

				if flag4 then
					for _, v13 in ipairs(tbl24) do
						Inventory:_update({ "Inventory", v13[1] }, { [v13[2]] = v13[3] })
					end
				end

				return flag4
			end

			local function fn34(arg, arg2)
				local tbl23 = {}
				local tbl24 = {}
				local v12 = ipairs
				arg = arg or {}

				for _, v13 in v12(arg) do
					if type(v13) == "string" and not tbl23[v13] then
						tbl23[v13] = true
						tbl24[#tbl24 + 1] = v13
					end
				end

				local v13 = ipairs
				local tbl25 = arg2 or {}

				for _, v14 in v13(tbl25) do
					if type(v14) == "string" and not tbl23[v14] then
						tbl23[v14] = true
						tbl24[#tbl24 + 1] = v14
					end
				end

				return tbl24
			end

			local function fn35(arg)
				if not (isfile and readfile and isfile(arg)) then
					return nil
				end
				local v12 = readfile(arg)
				if type(v12) ~= "string" then
					return nil
				end
				local match = v12:match("^%s*(.-)%s*$")
				local str3 = match:sub(1, 1)
				local str4 = match:sub(-1)
				if not (str3 == "{" and str4 == "}" or str3 == "[" and str4 == "]") then
					return nil
				end
				return HttpService:JSONDecode(match)
			end

			local function fn36()
				if tbl21.ncloaded then
					return
				end
				tbl21.ncloaded = true
				local v12 = fn35(tbl21.ncfile)

				if type(v12) == "table" then
					if type(v12.Sword) == "table" and #v12.Sword > 0 then
						tbl21.swnames = v12.Sword
					end

					if type(v12.Explosion) == "table" and #v12.Explosion > 0 then
						tbl21.explnames = v12.Explosion
					end

					if type(v12.Emote) == "table" and #v12.Emote > 0 then
						tbl21.emonames = v12.Emote
					end
				end
			end

			local function fn37()
				if not writefile then
					return
				end

				writefile(tbl21.ncfile, HttpService:JSONEncode({
					Sword = tbl21.swnames or {},
					Explosion = tbl21.explnames or {},
					Emote = tbl21.emonames or {},
				}))
			end

			local function fn38()
				local v12 = fn22()
				local flag2 = false

				if #v12 > 0 then
					tbl21.swnames = fn34(tbl21.swnames, v12)
					flag2 = true
				end

				local DataExplosions = fn21("DataExplosions")

				if #DataExplosions > 0 then
					tbl21.explnames = fn34(tbl21.explnames, DataExplosions)
					flag2 = true
				end

				local Emotes = fn21("Emotes")

				if #Emotes > 0 then
					tbl21.emonames = fn34(tbl21.emonames, Emotes)
					flag2 = true
				end

				if flag2 then
					fn37()
				end

				return flag2
			end

			local function fn39()
				if tbl21.warmed then
					return
				end
				fn36()
				v5 = v5 or fn13(ReplicatedStorage.Shared.Inventory)
				client = client or v5 and v5.Client
				v6 = v6 or fn13(ReplicatedStorage.Controllers.UI.ShopControllerAPI)
				v7 = v7 or fn13(ReplicatedStorage.Controllers.EmoteController)
				v8 = v8 or fn13(ReplicatedStorage.Shared.EmotesShared)
				v9 = v9 or fn13(ReplicatedStorage.Packages.Trove)
				tbl3.initsword()
				swords = tbl9.swords
				v10 = v10 or fn13(fn14(ReplicatedStorage, "Shared", "ReplicatedInstances", "SwordAccessories"))
				fn38()

				if localPlayer:GetAttribute("ShowSwordAccessory") == nil then
					localPlayer:SetAttribute("ShowSwordAccessory", not tbl21.noacc)
				end

				tbl21.warmed = true
			end

			local function fn40()
				if tbl21.injected then
					return
				end
				tbl21.injected = true

				if not fn16("Inventory") then
					tbl21.failed = true
					tbl3.logwev("uaInject", 5, "UnlockAll", "Inventory Replion unavailable - injection skipped")
					return
				end

				tbl21.failed = false

				if not tbl21.owned then
					fn28()
				end

				fn36()
				local flag2 = tbl21.swnames and #tbl21.swnames > 0 or tbl21.explnames and #tbl21.explnames > 0
				local flag3

				if flag2 then
					flag3 = flag2
				else
					flag3 = tbl21.emonames and #tbl21.emonames > 0
				end

				if not flag3 then
					fn38()
				end

				if not fn33({
					Sword = tbl21.swnames or fn22(),
					Explosion = tbl21.explnames or fn21("DataExplosions"),
					Emote = tbl21.emonames or fn21("Emotes"),
				}) then
					tbl21.failed = true
					tbl3.logwev("uaInject", 5, "UnlockAll", "Replion has no _update or _set - nothing injected")
				end
			end

			local function fn41()if  v9 then local l= v9 .new();if l then return l;end;end;local h={};return{Add=function(l,l)h[#h+1]=l;return l;end,Clean=function()for l,l in ipairs(h)do if typeof(l)=="Instance"then l:Destroy();elseif typeof(l)=="thread"then task.cancel(l);elseif typeof(l)=="RBXScriptConnection"then l:Disconnect();elseif type(l)=="function"then l();end;end;table.clear(h);end};end

			local tbl23 = {
				Emote915 = { id = "rbxassetid://121746225545509", delay = 0.65 },
				Emote1017 = { id = "rbxassetid://122138306164149", delay = 0 },
				Emote1052 = { id = "rbxassetid://86553108866816", delay = 0 },
				Emote1167 = { id = "rbxassetid://78966882139691", delay = 0 },
				Emote1185 = { id = "rbxassetid://73110745626575", delay = 0 },
				Emote1217 = { id = "rbxassetid://107342460864353", delay = 3.3333333333333335 },
			}

			local function fn42(l,K,p)local E=K:FindFirstChild("HumanoidRootPart")or K.PrimaryPart;if not E then return false;end;local k=false;local a={};local d=nil;d=function(I,C)if a[I]then return;end;a[I]=true;if  tbl21 .activeemo~=l then return;end;local a=I:Clone();a.Parent=E;p:Add(a);local function I()if  tbl21 .activeemo==l and a.Parent then a:Play();end;end;if C and C>0 then p:Add(task.delay(C,I));else I();end;k=true;end;local function a(I)if typeof(I)~="Instance"then return;end;for C,U in ipairs(I:GetDescendants())do if U:IsA("Sound")then C=U:FindFirstAncestorWhichIsA("Folder");d(U,(tonumber(C and(C:GetAttribute("EnableFrame")))or 0)/60);end;end;end;K= fn13 ( ReplicatedStorage .Shared.ReplicatedInstances.EmoteVFX);if K and K.GetInstance then a(K:GetInstance(l));end;K= fn13 ( ReplicatedStorage .Shared.ReplicatedInstances.EmoteAccessories);if K and K.GetInstance then a(K:GetInstance(l));end;K= ReplicatedStorage :FindFirstChild("Misc");local d=K and(K:FindFirstChild("Emotes"));a(d and(d:FindFirstChild(l)));if not k then d= tbl23 [l];if d and  tbl21 .activeemo==l then local K=Instance.new("Sound");K.Name="RiseEmoteSound";K.SoundId=d.id;K.Looped=true;K.Volume=1;K.RollOffMode=Enum.RollOffMode.InverseTapered;K.RollOffMaxDistance=500;K.Parent=E;p:Add(K);if d.delay>0 then p:Add(task.delay(d.delay,function()if  tbl21 .activeemo==l and K.Parent then K:Play();end;end));else K:Play();end;k=true;end;end;return k;end
			local function fn43(l)if not( toggles .emotewalk and  toggles .emotewalk.Value)then return;end; tbl3 .bindt(task.delay(0.12,function()if  tbl3 .ewapply then  tbl3 .ewapply();end;local h=l and(l:FindFirstChildOfClass("Humanoid"));if h and h.WalkSpeed<1 then h.WalkSpeed=h:GetAttribute("OLD_WS")or 32;end;end));end
			local function fn44(h)local l=h:FindFirstChildOfClass("Humanoid");h=l and(l:FindFirstChildOfClass("Animator"));if not h then return 0;end;l=h:GetPlayingAnimationTracks();return type(l)=="table"and#l or 0;end
			local function fn45()if  toggles .emotewalk and  toggles .emotewalk.Value then return false;end;local l= tbl3 .safehum();return l~=nil and l.MoveDirection.Magnitude>0.1;end
			local function fn46(l)local K= tbl3 .safechar();if not K then return;end;if  fn45 ()then return;end; tbl21 .activeemo=l; tbl21 .emostart= clock ();if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end;if  v8 and  v8 .Play and  v9 then local p= v9 .new(); tbl21 .trove=p;local E= fn44 (K); v8 :Play(K,p,l,true, Workspace :GetServerTimeNow());if  tbl21 .trove~=p or  tbl21 .activeemo~=l then return;end;if  fn44 (K)>E then  fn43 (K);return;end; tbl3 .logwev("emoteQuiet:"..tostring(l),5,("EmotesShared:Play returned without animating %s - using animation+sound fallback"):format(tostring(l)));p:Clean(); tbl21 .trove=nil;end;if  v7 and  v7 ._playAnimation then  v7 :_playAnimation(l);end;local p= fn41 (); tbl21 .trove=p;task.spawn(function() fn42 (l,K,p);end); fn43 (K);end

			local function fn47(arg, arg2)
				local Inventory = fn16("Inventory")

				if Inventory and type(Inventory._set) == "function" then
					local set = Inventory._set
					local tbl24 = {}
					local v12 = tostring
					local n3 = tonumber(arg2) or 1
					local v13 = table.pack(v12(n3))
					tbl24[1] = "EquippedList"
					tbl24[2] = "Emote"

					do
						local values = table.pack(table.unpack(v13, 1, v13.n))
						table.move(values, 1, values.n, 3, tbl24)
					end

					set(Inventory, tbl24, { Name = arg, Id = fn19("Emote", arg) })
				end
			end

			local function fn48()
				if not writefile then
					return
				end
				writefile(tbl21.wheelfile, HttpService:JSONEncode(tbl21.wheel))
			end

			fn15 = function()
				if not writefile then
					return
				end
				writefile(tbl21.equipfile, HttpService:JSONEncode(tbl21.equip))
			end

			local function fn49()
				local v12 = fn35(tbl21.equipfile)

				if type(v12) == "table" then
					tbl21.equip = v12
				end
			end

			local function fn50()
				local v12 = fn35(tbl21.wheelfile)

				if type(v12) == "table" then
					tbl21.wheel = v12
				end

				for k, v13 in pairs(tbl21.wheel) do
					fn47(v13, k)
				end
			end

			local function fn51(arg, arg2)
				local n3 = tonumber(arg2) or 1
				fn47(arg, n3)
				tbl21.wheel[tostring(n3)] = arg
				fn48()
			end

			local function fn52(arg, arg2, arg3)
				local v12 = arg[arg2]
				if type(v12) ~= "function" then
					return nil
				end
				arg[arg2] = arg3
				if arg[arg2] == arg3 then
					return v12
				end
				return nil
			end

			tbl21.repmod = {}
			tbl21.repwarm = {}
			local function repasset(l,K)if  tbl21 .repmod[l]==nil then  tbl21 .repmod[l]= fn13 ( fn14 ( ReplicatedStorage ,"Shared","ReplicatedInstances",l))or false;end;local p= tbl21 .repmod[l];if not p or type(p.GetInstance)~="function"then return nil;end;return p:GetInstance(K)or nil;end
			tbl21.repasset = repasset
			tbl21.reptry = {}
			tbl21.prefetch = function(l,K)if not K or K==""then return;end;local p=l.."/"..K;if  tbl21 .repwarm[p]then return;end;local E=( tbl21 .reptry[p]or 0)+1;if E>2 then return;end; tbl21 .reptry[p]=E; tbl21 .repwarm[p]=true; tbl3 .bindt(task.spawn(function()if not  repasset (l,K)then  tbl21 .repwarm[p]=nil;end;end));end
			tbl21.finctrl = function()if  tbl21 .fcmod==nil then  tbl21 .fcmod= fn13 ( fn14 ( ReplicatedStorage ,"Controllers","FinishersController"))or false;end;return  tbl21 .fcmod or nil;end
			tbl21.finfor = function(l)if type(l)~="string"or l==""then return nil;end;local K= tbl21 .finctrl();if K and type(K._finishers)=="table"then return K._finishers[l]and l or nil;end;K= misc and( misc :FindFirstChild("DataFinishers"));if K and(K:FindFirstChild(l))then return l;end;return nil;end

			tbl21.finplayable = function(arg)
				local v12 = tbl21.finctrl()
				return v12 ~= nil and type(v12._finishers) == "table" and v12._finishers[arg] ~= nil
			end

			tbl21.realfin = function(arg)
				local replion = Replion and Replion.Client and Replion.Client:GetReplion("Inventory")
				replion = replion and replion:Get({ "Inventory", "Sword" })
				if type(replion) ~= "table" then
					return false
				end

				for _, v12 in pairs(replion) do
					if type(v12) == "table" and v12.Name == arg and v12.Finisher == true and v12.CreatedAt ~= nil then
						return true
					end
				end

				return false
			end

			tbl21.finequip = function(arg)
				local v12 = tbl21.finfor(arg)
				if not v12 then
					return nil
				end
				tbl21.prefetch("Finishers", v12)
				local Data = fn16("Data")

				if Data then
					local Unlocked = Data:Get("Finishers.Unlocked")
					local tbl24 = {}
					local flag2 = false

					if type(Unlocked) == "table" then
						local v13, v14, v15 = ipairs(Unlocked)
						local flag3 = false

						for _, v16 in v13, v14, v15 do
							tbl24[#tbl24 + 1] = v16

							if v16 == v12 then
								flag3 = true
							end
						end

						flag2 = flag3
					end

					if not flag2 and type(Data._set) == "function" then
						tbl24[#tbl24 + 1] = v12
						Data:_set({ "Finishers", "Unlocked" }, tbl24)
					end

					if type(Data._update) == "function" and Data:Get({ "Finishers", "Equipped", v12 }) ~= true then
						Data:_update({ "Finishers", "Equipped" }, { [v12] = true })
					end
				end

				tbl21.finreq = tbl21.finreq or {}

				if v6 and type(v6.RequestFinisherEquip) == "function" and not tbl21.finreq[v12] and tbl21.realfin(v12) then
					tbl21.finreq[v12] = true

					tbl3.bindt(task.spawn(function()
						v6:RequestFinisherEquip({ Name = v12 })
					end))
				end

				return v12
			end

			tbl21.finhookup = function()
				if tbl21.finhooked then
					return
				end
				local v12 = tbl21.finctrl()
				if not v12 or type(v12.PlayFinisher) ~= "function" then
					return
				end
				tbl21.finorig = fn52(v12, "PlayFinisher", function(l,K,...) tbl21 .finlast= clock ();return  tbl21 .finorig(l,K,...);end)
				tbl21.finhooked = tbl21.finorig ~= nil
			end

			tbl21.findur = function(arg)
				local dataFinishers = misc and misc:FindFirstChild("DataFinishers")
				dataFinishers = dataFinishers and dataFinishers:FindFirstChild(arg)
				local attribute = dataFinishers and dataFinishers:GetAttribute("Duration")
				return type(attribute) == "number" and attribute or 6
			end

			tbl21.finhide = function(arg, arg2)
				if not arg then
					return
				end

				for _, descendant in ipairs(arg:GetDescendants()) do
					if descendant:IsA("BasePart") or descendant:IsA("Decal") then
						descendant.LocalTransparencyModifier = arg2 and 1 or 0
					elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("BillboardGui") then
						if arg2 then
							if descendant.Enabled then
								descendant:SetAttribute("__uaEmit", true)
								descendant.Enabled = false
							end
						elseif descendant:GetAttribute("__uaEmit") then
							descendant:SetAttribute("__uaEmit", nil)
							descendant.Enabled = true
						end
					end
				end
			end

			tbl21.finclone = function(h)local l=h.Archivable;h.Archivable=true;local K=h:Clone();h.Archivable=l;if not K then return nil;end;l=K:FindFirstChildOfClass("Humanoid");if not(l and(K:FindFirstChild("HumanoidRootPart")))then K:Destroy();return nil;end;for h,h in ipairs(K:GetDescendants())do if h:IsA("BaseScript")then h:Destroy();elseif h:IsA("BasePart")then h.CanCollide=false;h.CanQuery=false;h.Massless=true;h.LocalTransparencyModifier=0;if(h.Parent==K and h.Name~="HumanoidRootPart"or h.Name=="Handle"and(h.Parent:IsA("Accessory")))and h.Transparency>=1 then h.Transparency=0;end;elseif h:IsA("Decal")then h.Transparency=0;end;end;if l.MaxHealth<=0 then l.MaxHealth=100;end;l.Health=l.MaxHealth;l.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None;if not l:FindFirstChildOfClass("Animator")then Instance.new("Animator").Parent=l;end;K:SetAttribute("Dead",nil);return K;end

			tbl21.winfin = function(arg)
				if tbl21.finbusy then
					return
				end

				if not (tbl10.unlockall or tbl10.autoload or tbl10.swskin) then
					return
				end
				local v12 = tbl21.finfor(tbl21.cursword())
				if not v12 then
					return
				end
				local v13 = tbl21.findur(v12)
				local v14 = tbl3.safechar()
				local humanoidRootPart = v14 and v14:FindFirstChild("HumanoidRootPart")
				local flag2 = tbl21.prey ~= nil and tbl21.preyfor == arg

				if not (humanoidRootPart and arg and (flag2 or arg.Parent)) then
					flag2 = flag2 and tbl21.dropprey

					if flag2 then
						tbl21.dropprey()
					end

					return
				end

				tbl21.finhookup()
				tbl21.finbusy = true
				local v15 = clock()
				local prey

				if flag2 then
					prey = tbl21.prey
					tbl21.prey = nil
					tbl21.preyfor = nil
				else
					prey = tbl21.finclone(arg)
				end

				if not prey then
					tbl21.finbusy = false
					tbl3.notif("Finisher", "Couldn't copy your opponent, so the finisher was skipped.", 5)
					return
				end

				prey.Parent = Workspace

				tbl3.bindt(task.delay(0.1, function()
					local v16 = tbl21.finctrl()

					if (tbl21.finlast or 0) > v15 or not v16 or not v14.Parent then
						prey:Destroy()
						tbl21.finbusy = false
						return
					end

					if not tbl21.repasset("Finishers", v12) then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("Couldn't load the %s finisher."):format(v12), 5)
						return
					end

					if clock() - v15 > 3 then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher loaded too late. The next win should play it."):format(v12), 6)
						return
					end

					local v17 = tbl21.finclone(v14)

					if not v17 then
						prey:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", "Couldn't copy your character, so the finisher was skipped.", 5)
						return
					end

					if not tbl21.finplayable(v12) then
						prey:Destroy()
						v17:Destroy()
						tbl21.finbusy = false
						tbl3.notif("Finisher", ("The %s finisher isn't loaded yet."):format(v12), 5)
						return
					end

					v17.Parent = Workspace
					tbl21.finhide(v14, true)
					local finshow = nil

					finshow = function()
						if tbl21.finshow ~= finshow then
							return
						end
						tbl21.finshow = nil
						prey:Destroy()
						v17:Destroy()
						tbl21.finhide(v14, false)
						tbl21.finbusy = false
					end

					tbl21.finshow = finshow
					tbl3.bindt(task.delay(v13 + 2, finshow))
					local position = humanoidRootPart.Position
					local lookVector = humanoidRootPart.CFrame.LookVector
					local getServerTimeNow = Workspace.GetServerTimeNow
					v16:PlayFinisher(v12, v17, prey, CFrame.new(position, position + Vector3.new(lookVector.X, 0, lookVector.Z)), getServerTimeNow(Workspace))

					if setthreadidentity and tbl3.baseident then
						setthreadidentity(tbl3.baseident)
					end
				end))
			end

			local function fn53()
				if tbl21.hooked then
					return
				end
				local v12 = nil

				for _, v13 in ipairs({
					{ "Common", "Utils", "Utilities", "RewardInfo" },
					{ "Common", "Utils", "RewardInfo" },
					{ "Common", "RewardInfo" },
				}) do
					v12 = fn13(fn14(ReplicatedStorage, table.unpack(v13)))
					if not (type(v12) == "table" and type(rawget(v12, "playerOwnsItem")) == "function") then
						v12 = nil
						continue
					end
					break
				end

				if not v12 then
					for _, descendant in ipairs(ReplicatedStorage:GetDescendants()) do
						if descendant:IsA("ModuleScript") and descendant.Name == "RewardInfo" then
							local v13 = fn13(descendant)
							if type(v13) == "table" and type(rawget(v13, "playerOwnsItem")) == "function" then
								v12 = v13
								break
							end
						end
					end
				end

				if v12 and not tbl21.rwdorig then
					tbl21.rwdmod = v12
					tbl21.rwdorig = fn52(v12, "playerOwnsItem", function(l,K,...)if  tbl10 .unlockall and type(K)=="table"and(l==nil or l== localPlayer )then local p=K.Type;if p=="Sword"or p=="Explosion"or p=="Emote"or p=="Finisher"or p=="SwordAccessory"then return true;end;end;return  tbl21 .rwdorig(l,K,...);end)

					if not tbl21.rwdorig then
						local tbl24 = {}

						for k, v13 in pairs(v12) do
							tbl24[#tbl24 + 1] = tostring(k) .. (type(v13) == "function" and "()" or "")
						end

						table.sort(tbl24)
						tbl3.logwev("uaHookReward", 10, "UnlockAll", "failed to hook RewardInfo.playerOwnsItem; module has: " .. table.concat(tbl24, ", "))
					end
				end

				if v6 then
					if not tbl21.seteqorig then
						tbl21.seteqorig = fn52(v6, "SetEquipped", function(l,K,p)if not  tbl10 .unlockall then return  tbl21 .seteqorig(l,K,p);end;local E,k;if type(K)=="table"then E,k=K.ItemType or K.Type,K.Name;else k,E=( fn20 (p,K)),K;end;if E=="Ability"or not E or not k then return  tbl21 .seteqorig(l,K,p);end;if  fn29 (E,k)then return  tbl21 .seteqorig(l,K,p);end; fn27 (E,k);return true;end)

						if not tbl21.seteqorig then
							tbl3.logwev("uaHookSetEq", 10, "UnlockAll", "failed to hook ShopAPI.SetEquipped")
						end
					end

					if not tbl21.accorig then
						tbl21.accorig = fn52(v6, "ToggleSwordAccessory", function(l)if not  tbl10 .unlockall then return  tbl21 .accorig(l);end; tbl21 .noacc=not  tbl21 .noacc; tbl21 .equip.NoAcc= tbl21 .noacc;if  fn15 then  fn15 ();end; tbl21 .applyacc();return true;end)
					end
				end

				if v7 then
					if not tbl21.emoplayorig then
						tbl21.emoplayorig = fn52(v7, "Play", function(l,K,p)if not  tbl10 .unlockall and not  tbl10 .forceemo and not  tbl10 .emospam and not  tbl10 .emoteonly then return  tbl21 .emoplayorig(l,K,p);end;local E= toggles .emotewalk and  toggles .emotewalk.Value;if not  tbl10 .emospam and not E and( fn29 ("Emote",K))then return  tbl21 .emoplayorig(l,K,p);end;if type(l)=="table"then l._currentEmote=K;l._emoteSlot=p;l._lastEmote= clock ();if l._character then l._character:SetAttribute("Emoting",K);end;end; tbl21 .spamemo=K; fn46 (K);end)

						if not tbl21.emoplayorig then
							tbl3.logwev("uaHookEmote", 10, "UnlockAll", "failed to hook EmoteCtrl.Play")
						end
					end

					if not tbl21.emostoporig then
						tbl21.emostoporig = fn52(v7, "Stop", function(l,...)if not  tbl10 .unlockall and not  tbl10 .forceemo and not  tbl10 .emospam and not  tbl10 .emoteonly then if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;return  tbl21 .emostoporig(l,...);end;if  tbl21 .activeemo and  clock ()-( tbl21 .emostart or 0)<0.3 and not  fn45 ()then local K= tbl3 .safehum();if K and K.Health>0 then return;end;end;if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;if type(l)=="table"then if l._currentTrack and l._currentTrack.IsPlaying then l._currentTrack:Stop();end;l._currentEmote=nil;l._emoteSlot=nil;if l._character then l._character:SetAttribute("Emoting",nil);end;end;end)
					end
				end

				tbl21.finhookup()
				tbl21.hooked = true
			end

			local function arm()
				fn39()
				fn53()
				fn30()
			end

			tbl21.unhook = function()
				tbl10.unlockall = false
				tbl10.forceemo = false
				tbl10.emospam = false
				tbl10.emoteonly = false
				tbl10.autoload = false

				if tbl21.rwdmod and tbl21.rwdorig then
					tbl21.rwdmod.playerOwnsItem = tbl21.rwdorig
				end

				if v6 and tbl21.seteqorig then
					v6.SetEquipped = tbl21.seteqorig
				end

				if v6 and tbl21.accorig then
					v6.ToggleSwordAccessory = tbl21.accorig
				end

				if v7 and tbl21.emoplayorig then
					v7.Play = tbl21.emoplayorig
				end

				if v7 and tbl21.emostoporig then
					v7.Stop = tbl21.emostoporig
				end

				if tbl21.explmod and tbl21.explorig then
					tbl21.explmod.PlayExplosion = tbl21.explorig
				end

				if tbl21.fcmod and tbl21.finorig then
					tbl21.fcmod.PlayFinisher = tbl21.finorig
				end

				tbl21.rwdorig = nil
				tbl21.seteqorig = nil
				tbl21.accorig = nil
				tbl21.emoplayorig = nil
				tbl21.emostoporig = nil
				tbl21.explorig = nil
				tbl21.finorig = nil
				tbl21.hooked = false
				tbl21.explhooked = false
				tbl21.finhooked = false
				tbl21.autoran = false
				tbl21.boot = false

				for _, offconn in ipairs(tbl21.offconns) do
					offconn:Enable()
				end

				if tbl21.finshow then
					tbl21.finshow()
				end

				if tbl21.dropprey then
					tbl21.dropprey()
				end

				if tbl21.loaderblur then
					tbl21.loaderblur:Destroy()
					tbl21.loaderblur = nil
				end

				if tbl21.loadergui then
					tbl21.loadergui:Destroy()
					tbl21.loadergui = nil
				end

				tbl21.finhide(tbl3.safechar(), false)
			end

			tbl21.arm = arm
			unhook = tbl21.unhook

			local function fn54(arg)
				for _, v12 in ipairs({ "Activated", "MouseButton1Click" }) do
					local v13 = getconnections(arg[v12])

					if v13 then
						for _, v14 in ipairs(v13) do
							if not v14.ForeignState and v14.Function and islclosure(v14.Function) then
								local v15 = getupvalues(v14.Function)
								if type(v15) ~= "table" then
									continue
								end

								for _, v16 in pairs(v15) do
									if type(v16) == "table" and (rawget(v16, "_virtualItems") ~= nil or rawget(v16, "_selectedItem") ~= nil) then
										return v16
									end
								end
							end
						end
					end
				end
			end

			local function fn55(arg)
				local tbl24 = {}
				if not getconnections then
					return tbl24
				end

				for _, v12 in ipairs({ "Activated", "MouseButton1Click" }) do
					local v13 = getconnections(arg[v12])

					if v13 then
						for _, v14 in ipairs(v13) do
							if not v14.ForeignState and v14.Function then
								tbl24[#tbl24 + 1] = v14.Function
								v14:Disable()
								tbl21.offconns[#tbl21.offconns + 1] = v14
							end
						end
					end
				end

				return tbl24
			end

			local function fn56()
				local flag2 = tbl10.unlockall == true

				for _, offconn in ipairs(tbl21.offconns) do
					if flag2 then
						offconn:Disable()
					else
						offconn:Enable()
					end
				end
			end

			local function fn57(arg)
				if not (arg and arg.Select) then
					return
				end

				local function fn58()
					local selectedItem = arg._selectedItem
					if not selectedItem then
						return
					end
					arg:Select(table.clone(selectedItem), true)
				end

				fn58()
				task.defer(fn58)
				task.delay(0.1, fn58)
			end

			local function fn58()
				if tbl21.guihooked or tbl21.guibusy then
					return
				end
				tbl21.guibusy = true

				tbl3.bindt(task.spawn(function()
					local playerGui = localPlayer:WaitForChild("PlayerGui", 20)
					local shop = playerGui and playerGui:WaitForChild("Shop", 20)
					shop = shop and shop:WaitForChild("Holder", 20)
					local infoBG = shop and shop:WaitForChild("InfoBG", 20)
					local buyButton = infoBG and infoBG:WaitForChild("BuyButton", 20)

					if buyButton and getconnections then
						local n3 = clock() + 10

						while clock() < n3 do
							local v12, v13, v14 = ipairs(getconnections(buyButton.Activated) or {})
							local n4 = 0

							for _, v15 in v12, v13, v14 do
								if not v15.ForeignState and v15.Function then
									n4 += 1
								end
							end

							if not (n4 > 0) then
								task.wait(0.2)
								continue
							end
							break
						end
					end

					tbl21.guibusy = false
					if not buyButton then
						tbl3.logwev("uaHookGui", 30, "UnlockAll", "Shop.Holder.InfoBG.BuyButton never appeared - shop hooks skipped")
						return
					end
					tbl21.guihooked = true
					local v12 = fn54(buyButton)
					local v13 = fn55(buyButton)

					local function fn59()
						for _, v14 in ipairs(v13) do
							v14()
						end
					end

					tbl3.bind(buyButton.Activated:Connect(function()if not  tbl10 .unlockall then return;end; v12 = v12 or( fn54 ( buyButton ));local l= v12 and  v12 ._selectedItem;if not l then  fn59 ();return;end;local K=type(l.ItemInfo)=="table"and l.ItemInfo or nil;local p,E=l.type or l.Type or K and(K.ItemType or K.Type),l.name or l.Name or K and K.Name;if p=="Ability"or p=="AbilityFreeTrial"then  fn59 ();return;end;if p=="Sword"or p=="Explosion"then if  fn29 (p,E)then  fn59 ();return;end; fn27 (p,E);elseif p=="Emote"then  fn46 (E);else  fn59 ();return;end; fn57 ( v12 );end))
					local equips = infoBG and infoBG:FindFirstChild("Equips")
					local equipAccessory = equips and equips:FindFirstChild("EquipAccessory")

					if equipAccessory then
						fn55(equipAccessory)
						tbl3.bind(equipAccessory.Activated:Connect(function()if not  tbl10 .unlockall then return;end;if  v6 and  v6 .ToggleSwordAccessory then  v6 :ToggleSwordAccessory();end; fn57 ( v12 );end))
					end

					local tbl24 = { Sword = "SwordSkins", Explosion = "ExplosionSkins", Emote = "Emotes" }

					local function fn60()
						v12 = v12 or fn54(buyButton)
						local selectedItem = v12 and v12._selectedItem
						if not selectedItem then
							return nil
						end
						local itemInfo = type(selectedItem.ItemInfo) == "table" and selectedItem.ItemInfo or nil
						local type_ = selectedItem.type or selectedItem.Type or itemInfo and (itemInfo.ItemType or itemInfo.Type)
						local name = selectedItem.name or selectedItem.Name or itemInfo and itemInfo.Name
						return type_, name, selectedItem.key or type_ and name and fn19(type_, name) or nil
					end

					equips = equips and equips:FindFirstChild("Finisher")

					if equips and equips:IsA("GuiButton") then
						fn55(equips)
						tbl3.bind(equips.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K= fn60 ();if l~="Sword"or not K or not  tbl21 .finfor(K)then return;end;l= fn16 ("Data");local p= Replion and  Replion .None;if not(l and p and type(l._update)=="function")then return;end;local E=l:Get({"Finishers","Equipped",K})==true;l:_update({"Finishers","Equipped"},{[K]=E and p or true});if not E then  tbl21 .finequip(K);end; fn57 ( v12 );end))
					end

					shop = shop and shop:FindFirstChild("Favorite")

					if shop and shop:IsA("GuiButton") then
						fn55(shop)
						tbl3.bind(shop.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K= fn60 ();local p=l and  tbl24 [l];if not(K and p)then return;end;l= fn16 ("Data");local E= Replion and  Replion .None;if not(l and E)then return;end;l:_update({p,"Favorites"},{[K]=l:Get({p,"Favorites",K})==true and E or true}); fn57 ( v12 );end))
					end

					infoBG = infoBG and infoBG:FindFirstChild("Delete")

					if infoBG and infoBG:IsA("GuiButton") then
						fn55(infoBG)
						tbl3.bind(infoBG.Activated:Connect(function()if not  tbl10 .unlockall then return;end;local l,K,p= fn60 ();if not(l and K and p and  tbl24 [l])then return;end;if  v12 and type( v12 ._canDelete)=="function"then if not  v12 ._canDelete( v12 ,l,p)then  tbl3 .notif("Unlock All","You can't delete that item.",4);return;end;end;local E= fn16 ("Inventory");local k= Replion and  Replion .None;if not(E and k)then return;end;E:_update({"Inventory",l},{[p]=k});if  tbl21 .owned and  tbl21 .owned[l]then  tbl21 .owned[l][K]=nil;end;if  tbl21 .equip[l]==K then  tbl21 .equip[l]=nil;if  fn15 then  fn15 ();end;end;if l=="Sword"and  tbl10 .swname==K then  tbl10 .swskin=false; tbl10 .swname="";elseif l=="Explosion"and  tbl21 .explname==K then  tbl21 .explname=nil;end; fn57 ( v12 );end))
					end

					fn56()
					playerGui = playerGui and playerGui:WaitForChild("EmoteWheel", 20)
					playerGui = playerGui and playerGui:WaitForChild("List", 20)
					playerGui = playerGui and playerGui:WaitForChild("Content", 20)
					playerGui = playerGui and playerGui:WaitForChild("Folder", 20)

					if playerGui then
						local function fn61(arg)
							local v14 = getconnections(arg.Activated)
							if not v14 then
								return
							end

							for _, v15 in ipairs(v14) do
								if not v15.ForeignState and v15.Function and islclosure(v15.Function) then
									local v16 = getupvalues(v15.Function)

									if type(v16) == "table" then
										local n3 = 0

										for k in pairs(v16) do
											if type(k) == "number" and k > n3 then
												n3 = k
											end
										end

										local v17 = nil
										local v18 = nil

										for i = 1, n3 do
											local v19 = v16[i]

											if type(v19) == "string" and not v17 then
												v17 = v19
											end

											if type(v19) == "table" and (rawget(v19, "selected") ~= nil or rawget(v19, "page") ~= nil) then
												v18 = v19
											end
										end

										if v17 and v18 then
											return v17, v18
										end
									end
								end
							end
						end

						local function fn62(child)
							if not child:IsA("GuiButton") or child:GetAttribute("__uaHooked") then
								return
							end
							child:SetAttribute("__uaHooked", true)
							tbl3.bind(child.Activated:Connect(function()if not( tbl10 .unlockall or  tbl10 .emoteonly or  tbl10 .autoload)then return;end;local l,K= fn61 ( child );if not(l and K)then return;end;local p=(tonumber(K.selected)or 1)+((tonumber(K.page)or 1)-1)*8; fn51 ( fn20 (l),p);end))
						end

						for _, child in ipairs(playerGui:GetChildren()) do
							fn62(child)
						end

						tbl3.bind(playerGui.ChildAdded:Connect(fn62))
					end
				end))
			end

			local function fn59()
				if tbl21.boot then
					return
				end
				tbl21.boot = true
				fn12()
				fn39()
				task.wait()
				fn53()
				task.wait()
				fn58()
				fn56()
			end

			local function fn60()
				local tbl24 = {
					done = false,
					finish = function()
					end,
					setStatus = function()
					end,
				}

				local screenGui = Instance.new("ScreenGui")
				screenGui.Name = "\0RiseUnlock"
				screenGui.IgnoreGuiInset = true
				screenGui.ResetOnSpawn = false
				screenGui.DisplayOrder = 999999999
				screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				screenGui.Parent = fn6 and fn6() or CoreGui
				local frame = Instance.new("Frame")
				frame.Size = UDim2.fromScale(1, 1)
				frame.BackgroundColor3 = Color3.fromRGB(2, 12, 20)
				frame.BackgroundTransparency = 1
				frame.BorderSizePixel = 0
				frame.Parent = screenGui
				local blurEffect = Instance.new("BlurEffect")
				blurEffect.Size = 0
				blurEffect.Parent = Lighting
				local frame2 = Instance.new("Frame")
				frame2.AnchorPoint = Vector2.new(0.5, 0.5)
				frame2.Position = UDim2.fromScale(0.5, 0.5)
				frame2.Size = UDim2.fromOffset(252, 172)
				frame2.BackgroundColor3 = color
				frame2.BackgroundTransparency = 1
				frame2.BorderSizePixel = 0
				frame2.Parent = screenGui
				tbl3.corner(frame2, 20)
				local uiGradient = Instance.new("UIGradient")
				uiGradient.Rotation = 90
				local color4 = Color3.fromRGB
				uiGradient.Color = ColorSequence.new(Color3.fromRGB(16, 56, 88), color4(3, 24, 42))
				uiGradient.Parent = frame2
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = Color3.fromRGB(255, 255, 255)
				uiStroke.Thickness = 1.5
				uiStroke.Transparency = 1
				uiStroke.Parent = frame2
				local frame3 = Instance.new("Frame")
				frame3.AnchorPoint = Vector2.new(0.5, 0)
				frame3.Position = UDim2.new(0.5, 0, 0, 28)
				frame3.Size = UDim2.fromOffset(46, 46)
				frame3.BackgroundTransparency = 1
				frame3.Parent = frame2
				local tbl25 = {}
				local n3 = 12

				for i = 1, 12 do
					local frame4 = Instance.new("Frame")
					frame4.AnchorPoint = Vector2.new(0.5, 0.5)
					frame4.Size = UDim2.fromOffset(4, 12)
					frame4.BackgroundColor3 = accent
					frame4.BackgroundTransparency = 1
					frame4.BorderSizePixel = 0
					local v12 = rad((i - 1) * 360 / n3)
					frame4.Position = UDim2.new(0.5, sin(v12) * 15, 0.5, -cos(v12) * 15)
					frame4.Rotation = (i - 1) * 360 / n3
					local uiCorner = Instance.new("UICorner")
					uiCorner.CornerRadius = UDim.new(1, 0)
					uiCorner.Parent = frame4
					frame4.Parent = frame3
					tbl25[i] = frame4
				end

				local textLabel = Instance.new("TextLabel")
				textLabel.AnchorPoint = Vector2.new(0.5, 0)
				textLabel.Position = UDim2.new(0.5, 0, 0, 92)
				textLabel.Size = UDim2.new(1, -24, 0, 22)
				textLabel.BackgroundTransparency = 1
				textLabel.Font = Enum.Font.GothamBold
				textLabel.TextSize = 16
				textLabel.TextColor3 = color2
				textLabel.TextTransparency = 1
				textLabel.Text = "Unlock All"
				textLabel.Parent = frame2
				local textLabel2 = Instance.new("TextLabel")
				textLabel2.AnchorPoint = Vector2.new(0.5, 0)
				textLabel2.Position = UDim2.new(0.5, 0, 0, 118)
				textLabel2.Size = UDim2.new(1, -28, 0, 40)
				textLabel2.BackgroundTransparency = 1
				textLabel2.Font = Enum.Font.Gotham
				textLabel2.TextSize = 12
				textLabel2.TextColor3 = color3
				textLabel2.TextTransparency = 1
				textLabel2.TextWrapped = true
				textLabel2.Text = "Unlocking swords, explosions & emotes..."
				textLabel2.Parent = frame2
				local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				TweenService:Create(frame, tweenInfo, { BackgroundTransparency = 0.45 }):Play()
				TweenService:Create(frame2, tweenInfo, { BackgroundTransparency = 0.2 }):Play()
				TweenService:Create(uiStroke, tweenInfo, { Transparency = 0.55 }):Play()
				TweenService:Create(textLabel, tweenInfo, { TextTransparency = 0 }):Play()
				TweenService:Create(textLabel2, tweenInfo, { TextTransparency = 0.15 }):Play()
				TweenService:Create(blurEffect, tweenInfo, { Size = 16 }):Play()
				tbl21.loadergui = screenGui
				tbl21.loaderblur = blurEffect
				local v12 = clock()
				local v13 = tbl3.bind(RunService.RenderStepped:Connect(function()local l= clock ()*1.15%1;for K=1, n3 ,1 do local p=((K-1)/ n3 -l)%1; tbl25 [K].BackgroundTransparency=0.1+0.82*p;end;end))

				tbl24.setStatus = function(text)
					textLabel2.Text = text
				end

				tbl24.finish = function()
					if tbl24.done then
						return
					end
					tbl24.done = true
					local n4 = 0.6 - clock() - v12

					if n4 > 0 then
						task.wait(n4)
					end

					local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
					TweenService:Create(frame, tweenInfo2, { BackgroundTransparency = 1 }):Play()
					TweenService:Create(frame2, tweenInfo2, { BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.54) }):Play()
					TweenService:Create(uiStroke, tweenInfo2, { Transparency = 1 }):Play()
					TweenService:Create(textLabel, tweenInfo2, { TextTransparency = 1 }):Play()
					TweenService:Create(textLabel2, tweenInfo2, { TextTransparency = 1 }):Play()
					TweenService:Create(blurEffect, tweenInfo2, { Size = 0 }):Play()
					task.wait(0.45)

					if v13 then
						v13:Disconnect()
					end

					blurEffect:Destroy()
					screenGui:Destroy()
				end

				return tbl24
			end

			fn9 = function() tbl10 .unlockall=true; tbl21 .everunlocked=true; tbl21 .uagen=( tbl21 .uagen or 0)+1;local l= tbl21 .uagen; fn56 ();local K= fn60 ();local p=false;local E=nil;E=function(k,a)if p then return;end;p=true;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;K.finish(); tbl3 .notif("Unlock All",k,a or 5);end;local function k()if p then return;end;p=true;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;K.finish();end; tbl3 .bindt(task.delay(20,function()E("Done. If something is missing, rejoin and turn it on again.",6);end)); tbl3 .bindt(task.spawn(function() fn12 ();task.wait();if  tbl21 .uagen~=l then return k();end; fn59 ();if  tbl21 .uagen~=l then return k();end;K.setStatus("Loading swords and explosions...");for p=1,3,1 do  tbl21 .injected=false; fn40 ();if not  tbl21 .failed or  tbl21 .uagen~=l then break;end;if p<3 then K.setStatus("Retrying... ("..p.."/3)"); fn12 ();task.wait(0.8);end;end;task.wait();if  tbl21 .uagen~=l then return k();end; fn49 ();local p={"Sword","Explosion"};for a,d in ipairs(p)do a= tbl21 .equip[d];if type(a)=="string"and a~=""then  fn27 (d,a,true);end;if  tbl21 .uagen~=l then return k();end;end;if  tbl21 .equip.NoAcc then  tbl21 .noacc=true; tbl21 .applyacc();end;K.setStatus("Loading emotes..."); tbl3 .bindt(task.delay(3,function()if  tbl21 .uagen~=l then return;end; fn50 ();end));E("Done. Open your inventory and equip anything.",6);end));end

			fn10 = function()
				tbl10.unlockall = false
				tbl21.uagen = (tbl21.uagen or 0) + 1
				tbl21.explname = nil
				tbl21.injected = false
				tbl21.failed = false

				if not tbl10.autoload and tbl21.skinmine then
					tbl10.swskin = false
					tbl10.swname = ""
					tbl21.skinmine = false
				end

				fn56()
				tbl3.notif("Unlock All", "Off. Items already unlocked stay until you rejoin.", 4)
			end

			fn11 = function(l) tbl10 .autoload=true;if  tbl10 .unlockall or  tbl21 .autoran then return;end; tbl21 .autoran=true; tbl3 .bindt(task.spawn(function() fn12 ();task.wait(); fn39 (); fn53 (); fn58 (); fn30 (); fn49 ();local K={"Sword","Explosion"};for p,E in ipairs(K)do p= tbl21 .equip[E];if type(p)=="string"and p~=""then  fn27 (E,p,true);end;end;if  tbl21 .equip.NoAcc then  tbl21 .noacc=true; tbl21 .applyacc();end; fn50 ();for K,K in pairs( tbl21 .wheel)do if type(K)=="string"and K~=""then  fn26 ("Emote",K);end;end;if setthreadidentity and  tbl3 .baseident then setthreadidentity( tbl3 .baseident);end;if l then  tbl3 .notif("Auto Load Last Loadout","Your last sword, explosion and emotes are back.",4);end;end));end

			local function fn61()
				tbl10.autoload = false
				tbl21.autoran = false

				if not tbl10.unlockall and tbl21.skinmine then
					tbl10.swskin = false
					tbl10.swname = ""
					tbl21.skinmine = false
					tbl21.explname = nil
				end
			end

			local function fn62(arg, arg2)
				if type(arg) ~= "string" or arg == "" then
					return nil
				end
				local str3 = arg:lower()

				for _, v12 in ipairs(arg2) do
					if v12:lower() == str3 then
						return v12
					end
				end

				for _, v12 in ipairs(arg2) do
					if v12:lower():find(str3, 1, true) then
						return v12
					end
				end

				return nil
			end

			tbl3.skinsword = function(arg)
				fn12()
				fn39()
				fn53()
				fn30()
				local v12 = tbl3.initsword()
				if not v12 then
					tbl3.notif("Skins", "Swords aren't ready yet. Try again in a second.", 5)
					return
				end
				local tbl24 = {}
				local collection = v12:GetCollection()

				if type(collection) == "table" then
					for k in pairs(collection) do
						tbl24[#tbl24 + 1] = k
					end
				end

				local v13 = fn62(arg, tbl24)

				if not v13 then
					if v12:GetSword(arg) then
						v13 = arg
					end
				end

				if not v13 or v13 == "" then
					tbl3.notif("Skins", ("No sword called \"%s\". %d swords loaded."):format(tostring(arg), #tbl24), 6)
					return
				end

				if not tbl3.safechar() then
					tbl3.notif("Skins", "Join a round first.", 5)
					return
				end
				tbl10.swskin = true
				tbl10.swname = v13
				tbl21.skinmine = false
				tbl3.hookslash()
				tbl3.skinloop()
				tbl3.setswattr(v13)

				if tbl9.swctrl and tbl9.swctrl.SetSword then
					tbl9.swctrl:SetSword(v13)
				end

				local v14 = tbl3.applysword()
				fn26("Sword", v13)
				fn25("Sword", v13)
				tbl21.ensureeq("Sword", v13)
				tbl21.finequip(v13)
				tbl21.equip.Sword = v13

				if fn15 then
					fn15()
				end

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.bindt(task.delay(0.4, function()
					local v15 = tbl3.safechar()

					if v15 and v15:FindFirstChild(v13) then
						tbl3.notif("Skins", ("Equipped %s."):format(v13), 3)
					elseif not v14 then
						tbl3.notif("Skins", ("Couldn't equip %s. The game may not have sent the model."):format(v13), 7)
					else
						tbl3.notif("Skins", ("%s didn't show up. The game blocked it."):format(v13), 6)
					end
				end))
			end

			tbl3.applyexpl = function(arg)
				fn12()
				fn39()
				fn53()
				fn30()
				local DataExplosions = fn21("DataExplosions")
				local v12 = fn62(arg, DataExplosions)
				if not v12 or v12 == "" then
					tbl3.notif("Skins", ("No explosion called \"%s\". %d explosions loaded."):format(tostring(arg), #DataExplosions), 6)
					return
				end
				fn27("Explosion", v12)

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.bindt(task.spawn(function()
					tbl3.notif("Skins", repasset("Explosions", v12) and ("Explosion set to %s."):format(v12) or ("%s is set, but the game didn't send it. It may not show."):format(v12), 5)
				end))
			end

			tbl3.emoteonly = function(arg)
				if not arg then
					return
				end
				fn12()
				fn39()
				fn53()
				fn58()
				fn30()
				fn50()
				local n3 = 0

				for _, v12 in pairs(tbl21.wheel) do
					if type(v12) == "string" and v12 ~= "" then
						fn26("Emote", v12)
						n3 += 1
					end
				end

				if setthreadidentity and tbl3.baseident then
					setthreadidentity(tbl3.baseident)
				end

				tbl3.notif("Skins", n3 > 0 and ("%d emotes ready. Open your emote wheel."):format(n3) or "No emotes saved yet.", 4)
			end

			toggles.unlockall:OnChanged(function(arg)
				if arg then
					fn9()
				else
					fn10()
				end

				tbl3.qsave()
			end)

			toggles.equipautoload:OnChanged(function(arg)
				if arg then
					fn11(true)
				else
					fn61()
				end

				tbl3.qsave()
			end)

			local function fn63()return  max (0.5-( clamp ( tbl10 .emospd or 5,1,10)-1)*0.04888888888888889,0.2);end

			local function fn64()
				if tbl21.spamconn then
					tbl21.spamconn:Disconnect()
					tbl21.spamconn = nil
				end
			end

			local function fn65()
				fn64()
				tbl21.spamlast = 0
				tbl21.spamconn = tbl3.bind(RunService.Heartbeat:Connect(function()if not  tbl10 .emospam or not  tbl21 .spamemo then return;end;if not  tbl3 .isalive()then return;end;if not( toggles .emotewalk and  toggles .emotewalk.Value)then local l= tbl3 .safehum();if l and l.MoveDirection.Magnitude>0.1 then if  tbl21 .trove then  tbl21 .trove:Clean(); tbl21 .trove=nil;end; tbl21 .activeemo=nil;return;end;end;local l= clock ();if l-( tbl21 .spamlast or 0)< fn63 ()then return;end; tbl21 .spamlast=l; fn46 ( tbl21 .spamemo);end))
			end

			toggles.forceemote:OnChanged(function(forceemo)
				tbl10.forceemo = forceemo

				if forceemo then
					arm()
				end

				tbl3.qsave()
			end)

			toggles.emotespam:OnChanged(function(emospam)
				tbl10.emospam = emospam

				if emospam then
					arm()
					fn65()
				else
					fn64()
				end

				tbl3.qsave()
			end)

			options.emotespamspeed:OnChanged(function(emospd)
				tbl10.emospd = emospd
				tbl3.qsave()
			end)

			toggles.emoteonspawn:OnChanged(function(emospawn)
				tbl10.emospawn = emospawn

				if emospawn then
					arm()
				end

				tbl3.qsave()
			end)

			tbl10.emospawn = toggles.emoteonspawn.Value

			tbl3.bind(localPlayer.CharacterAdded:Connect(function()
				if not tbl10.emospawn then
					return
				end
				task.wait(1)
				local n1 = tbl21.wheel and (tbl21.wheel["1"] or tbl21.wheel[1]) or tbl21.spamemo

				if type(n1) == "string" and n1 ~= "" then
					fn46(n1)
				end
			end))

			if alive then
				local v12 = tbl3.safechar()
				tbl21.lost = not (v12 and v12.Parent == alive)
				local function fn66(l)local K= Players :GetPlayerFromCharacter(l);if not K or K== localPlayer then return false;end;if l:GetAttribute("IsDoppelganger")then return false;end;if l:GetAttribute("IsEncryptedClone")then return false;end;if l:GetAttribute("Dead")then return false;end;return true;end
				local function dropprey()if  tbl21 .prey then  tbl21 .prey:Destroy(); tbl21 .prey=nil;end; tbl21 .preyfor=nil;end
				tbl21.dropprey = dropprey
				local function fn67(l)if  tbl21 .preyfor~=l or l.Parent~= alive then return;end;local K= tbl21 .finclone(l);if not K then return;end;if  tbl21 .prey then  tbl21 .prey:Destroy();end; tbl21 .prey=K;end
				local function fn68()if not( tbl10 .unlockall or  tbl10 .autoload or  tbl10 .swskin)then return;end;local l= tbl21 .finfor( tbl21 .cursword());if l then  tbl21 .prefetch("Finishers",l);end;end
				local function fn69(l)if not( tbl10 .unlockall or  tbl10 .autoload or  tbl10 .swskin)then return;end; fn68 ();if not l or  tbl21 .preyfor==l then return;end; dropprey (); tbl21 .preyfor=l; fn67 (l); tbl3 .bindt(task.delay(3,function() fn67 (l);end));end
				local function fn70()local l= tbl3 .safechar();if not l or l.Parent~= alive then return 0,nil;end;local l,K=0;for p,p in ipairs( alive :GetChildren())do if  fn66 (p)then l,K=l+1,p;end;end;return l,K;end
				tbl3.bind(alive.ChildRemoved:Connect(function(l)local K= Players :GetPlayerFromCharacter(l);if not K then return;end;if K== localPlayer then  tbl21 .lost=true;return;end;K= tbl3 .safechar(); tbl21 .lost=not(K and K.Parent== alive and not K:GetAttribute("Dead"));if  tbl21 .lost then return;end;local K,p= fn70 ();if K==1 then  fn69 (p);return;end;if K>1 then return;end; tbl21 .winfin(l);end))
				tbl3.bind(alive.ChildAdded:Connect(function(l)if l== localPlayer .Character then  tbl21 .lost=false; dropprey (); fn68 (); tbl3 .bindt(task.delay(3, fn68 ));end;local l,K= fn70 ();if l==1 then  fn69 (K);end;end))
			end

			tbl10.forceemo = toggles.forceemote.Value

			if toggles.emotespam.Value then
				tbl10.emospam = true
				fn65()
			end

			if tbl10.forceemo or tbl10.emospam or tbl10.emospawn or tbl10.emoteonly then
				tbl3.bindt(task.spawn(arm))
			end
		end
	end

	_G.stagesh = "unlock"

	v:OnUnload(function()
		v2:Save("autosave")
		tbl3.cleanup()

		for _, connection in pairs(tbl7.Connections) do
			connection:Disconnect()
		end

		for _, thread in pairs(tbl7.Threads) do
			task.cancel(thread)
		end

		_G.cuties = nil
		_G.RiseLibrary = nil
		_G.RiseWindow = nil
		_G.RiseHeartbeat = nil
		_G.RiseJob = nil
		_G.RiseBoot = nil
	end)

	Menu:AddButton("Unload", function()
		v:Unload()
	end)

	_G.RiseBoot = nil
	_G.stagesh = "ready"
end

fn()
