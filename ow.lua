
-- Luraph runtime function (from the VM object, not part of the script: not lifted).
-- LPH_ENCFUNC decrypts a function this way: (key, encrypted buffer, ...) -> function.
local function luraph_runtime1(...)
	error("Luraph runtime function, not devirtualized")
end

local v = table.pack(...)

if not ce_like_loadstring_fn then
	if not l_fastload_enabled or not is_from_loader then
		game:GetService("Players").LocalPlayer:Kick("[Luarmor]: Use the loadstring, do not run this directly")
		wait(5)

		while true do
		end
	end
end

local str = "?"
loadstring = ce_like_loadstring_fn or loadstring
local flag = false

pcall(function()
	flag = true
	local UserGameSettings = UserSettings():GetService("UserGameSettings")

	if not UserGameSettings:GetTutorialState("nil  nil  ") then
		str = ""
		local n = ({ wait() })[1] * 1000000

		local function fn(arg)
			local n2 = 1103515245
			local n3 = 12345
			local n4 = 99999999
			local n5 = arg % 2147483648
			local n6 = 1

			return function(arg2, arg3)
				local v2 = n4
				local n7 = n2 * n5 + n3
				local n8 = n7 % v2 + n6
				n6 += 1
				n5 = n8
				n3 = n7 % 4858 * v2 % 5782
				return arg2 + n8 % arg3 - arg2 + 1
			end
		end

		local v2 = fn(n - n % 1)
		UserGameSettings:SetTutorialState("nil  nil  ", true)
		local n2 = 0

		for i = 1, 16 do
			local n3 = 0
			local n4 = 1

			for i2 = 1, 5 do
				local flag2 = v2(10, 20) > 15
				UserGameSettings:SetTutorialState("nil  nil  " .. n2, flag2)
				n3 += (flag2 and 1 or 0) * n4
				n4 *= 2
				n2 += 1
			end

			str ..= ("qwertyuiopasdfghjklzxcvbnm098765"):sub(n3 + 1, n3 + 1)
		end
	else
		str = ""
		local n = 0

		for i = 1, 16 do
			local n2 = 0
			local n3 = 1

			for i2 = 1, 5 do
				n2 += (UserGameSettings:GetTutorialState("nil  nil  " .. n) and 1 or 0) * n3
				n3 *= 2
				n += 1
			end

			str ..= ("qwertyuiopasdfghjklzxcvbnm098765"):sub(n2 + 1, n2 + 1)
		end
	end
end)

while not flag do
end

local now = os.clock()

if devsignature_sig then
	print([[        Luarmor - Lua whitelist service
        This is a signature - If you are seeing this, you know what not to do :3
        Have a good day!
        https://luarmor.net/
    ]])
end

local flag2 = nil
local flag3 = nil
local v2 = ({ table.unpack(v, 1, v.n) })[3]

if v2 and v2[1] then
end

local floor = math.floor
local random = math.random
local remove = table.remove
local char = string.char
local n = 0
local n2 = 2
local tbl = {}
local tbl2 = {}

for i = 1, 256 do
	tbl2[i] = i
end

repeat
	local v3 = random(1, #tbl2)
	local v4 = remove(tbl2, v3)
	tbl[v4] = char(v4 - 1)
until #tbl2 == 0

local tbl3 = {}

local function fn()
	if #tbl3 == 0 then
		n = (n * 149 + 4033097371307) % 35184372088832

		repeat
			n2 = n2 * 37 % 257
		until n2 ~= 1

		local n3 = n2 % 32
		local n4 = floor(n / 2 ^ (13 - (n2 - n3) / 32)) % 4294967296 / 2 ^ n3
		local n5 = floor(n4 % 1 * 4294967296) + floor(n4)
		local n6 = n5 % 65536
		local n7 = (n5 - n6) / 65536
		local n8 = n6 % 256
		local n9 = n7 % 256
		tbl3 = { n8, (n6 - n8) / 256, n9, (n7 - n9) / 256 }
	end

	return table.remove(tbl3)
end

local tbl4 = {}
local v3 = tbl4

local function fn2(arg, arg2)
	local v4 = tbl4

	if not v4[arg2] then
		tbl3 = {}
		local v5 = tbl
		n = arg2 % 35184372088832
		n2 = arg2 % 255 + 2
		v4[arg2] = ""
		local n3 = 77

		for i = 1, #arg do
			n3 = (string.byte(arg, i) + fn() + n3) % 256
			v4[arg2] = v4[arg2] .. v5[n3 + 1]
		end
	end

	return arg2
end

local v4 = LUARMOR_SkipAntidebugDevMode
local v5 = LUARMOR_AllowKeyCheckSkip
local flag4 = ff97f23b97f93792992999 and ff97f23b97f93792992999() == "j" or false
local v6 = "eu1-roblox-auth.luarmor.net"
local v7 = USE_NON_SSL_NODE
local v8 = l_fastload_enabled
local n3 = os["time"](os["date"]("*t")) - os["time"](os["date"]("!*t"))
local n4

if n3 < 0 then
	n4 = (86400 + -(-n3 % 86400)) % 86400
else
	n4 = n3 % 86400
end

local n5 = n4 / 3600

if n5 >= 21 or n5 < 5 then
	local tbl5 = {}
	local v9 = "eu1-roblox-auth.luarmor.net"
	local v10 = "eu2-roblox-auth.luarmor.net"
	tbl5[1] = v9
	tbl5[2] = v10
	v6 = tbl5[math["random"](1, 2)]
elseif n5 >= 5 and n5 < 15 then
	local tbl5 = {}
	local v9 = "as1-roblox-auth.luarmor.net"
	local v10 = "as2-roblox-auth.luarmor.net"
	local v11 = "as3-roblox-auth.luarmor.net"
	local v12 = "as5-roblox-auth.luarmor.net"
	local v13 = "as6-roblox-auth.luarmor.net"
	local v14 = "as7-roblox-auth.luarmor.net"
	local v15 = "au1-roblox-auth.luarmor.net"
	local v16 = "au2-roblox-auth.luarmor.net"
	local v17 = "au3-roblox-auth.luarmor.net"
	local v18 = "au4-roblox-auth.luarmor.net"
	local v19 = "au5-roblox-auth.luarmor.net"
	tbl5[1] = v9
	tbl5[2] = v10
	tbl5[3] = v11
	tbl5[4] = v12
	tbl5[5] = v13
	tbl5[6] = v14
	tbl5[7] = v15
	tbl5[8] = v16
	tbl5[9] = v17
	tbl5[10] = v18
	tbl5[11] = v19
	v6 = tbl5[math["random"](1, 11)]
elseif n5 >= 15 and n5 < 21 then
	local tbl5 = {}
	local v9 = "us1-roblox-auth.luarmor.net"
	local v10 = "us2-roblox-auth.luarmor.net"
	local v11 = "ca1-roblox-auth.luarmor.net"
	tbl5[1] = v9
	tbl5[2] = v10
	tbl5[3] = v11
	v6 = tbl5[math["random"](1, 2)]
else
	game:GetService("Players")["LocalPlayer"]:Kick("invalid timezone - send this screenshot to developer and Federal")
end

pcall(function()
	if game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game:GetService("Players")["LocalPlayer"]) == "AU" then
		local tbl5 = {}
		local v9 = "au1-roblox-auth.luarmor.net"
		local v10 = "au2-roblox-auth.luarmor.net"
		local v11 = "au3-roblox-auth.luarmor.net"
		local v12 = "au4-roblox-auth.luarmor.net"
		local v13 = "au5-roblox-auth.luarmor.net"
		tbl5[1] = v9
		tbl5[2] = v10
		tbl5[3] = v11
		tbl5[4] = v12
		tbl5[5] = v13
		v6 = tbl5[math["random"](1, 5)]
	end
end)

local tbl5 = { ["Version"] = "3.4" }
tbl5["Host"] = flag4 and LT_R_RRT_H or ("https://") .. v6
tbl5["ScriptID"] = "e30ade937c4c9b8ddbb03e976696e380"
tbl5["ScriptVersion"] = "0033"
tbl5["Name"] = "FlyteBBPrem"

if v7 then
	tbl5["Host"] = "http://mc.felinemastery.xyz"
	v6 = "mc.felinemastery.xyz"
end

local flag5 = type(({ table.unpack(v, 1, v.n) })[1]) ~= "table"
local flag6 = false
local fn3 = nil
local n6 = nil
local tbl6 = nil
local tbl7 = nil
local flag7 = nil
local v9 = nil
local tbl8 = nil
local v10 = print
local v11 = next
local v12 = string["char"]
local v13 = identifyexecutor
local v14 = game
local v15 = pcall
local v16 = string["gmatch"]
local v17 = debug["traceback"]
local v18 = tonumber
local v19 = setmetatable
local v20 = rawget
local v21 = wait
local v22 = debug["getinfo"]
local v23 = loadstring
local v24 = os["time"]
local v25 = string["byte"]
local v26 = string["sub"]
local v27 = spawn
local v28 = game:GetService("RunService")["Heartbeat"]
local v29 = os["clock"]
local v30 = rconsoleprint
local v31 = math["huge"]
local v32 = tostring
local v33 = pairs
local v34 = string["find"]
local v35 = getgenv
local flag8 = false

local function fn4(arg, arg2)
	v23("local t,r = ...")(arg, arg2)

	while v21() do
	end
end

local tbl9 = {}
local flag9 = false
local v36 = string["format"]
local v37 = string["sub"]
local v38 = table["concat"]
local v39 = type
local v40 = v33
local v41 = v21
local v42 = coroutine["wrap"]

local fn5 = syn and syn["websocket"] and syn["websocket"]["connect"] or WebSocket and WebSocket["connect"] or WebsocketClient and function(arg)
	local v43 = WebsocketClient["new"](arg)
	v43:Connect()
	return v43
end

local fn6 = nil

fn6 = function(arg)
	local tbl10 = {}

	for k, v43 in v40(arg) do
		local n7 = #tbl10 + 1
		local v44 = "\"%s\":%s,"
		local v45 = v3
		local flag10 = v39(v43) == "table" and fn6(v43)
		local str2

		if flag10 then
			str2 = flag10
		else
			local v46 = v3
			str2 = ("\"") .. v43 .. "\""
		end

		tbl10[n7] = v36(v44, k, str2)
	end

	return ("{") .. v37(v38(tbl10), 0, -2) .. "}"
end

local function fn7(arg)
	local function fn8(arg2)
		if arg2 == "PONG" then
			if flag8 then
				local v43 = v3
				v30(("[") .. os["clock"]() .. "] [PONG] Server ---> Client ")
			end

			arg["LastPong"] = tick()
			return
		end

		local v43 = v3
		local v44 = string["match"](arg2, "|__(%d+)__|")

		if flag8 then
			local v45 = v3
			v30(("[") .. os["clock"]() .. ("] [RESPONSE] Server ---> Client: ") .. arg2 .. "")
		end

		if v44 then
			local v45 = arg["Requests"][v44 + 0]
			local v46 = v3
			v45:Fire(arg2:gsub("|__(%d+)__|", ""))
			return v45:Destroy()
		end

		return arg["OnMessageSignal"]:Fire(arg2)
	end

	local fn9 = nil

	fn9 = function()
		if flag8 then
			local v43 = v3
			v30(("[") .. os["clock"]() .. "] [CLOSED] ")
		end

		arg["__OBJECT_ACTIVE"] = false

		if arg["SocketClosed"] or flag9 then
			if flag8 then
				v30(" (ALREADY CLOSED)")
			end

			return
		end

		local n7 = 0
		local v43

		while true do
			if flag8 then
				local v44 = v3
				v30(("[") .. os["clock"]() .. "] Attempting to reconnect to wshttpemu")
			end

			local v44 = v24()
			local flag10 = false
			local v45 = nil
			v43 = nil

			v27(function()
				local v46, v47 = v15(fn5, arg["Url"])
				v45 = v46
				v43 = v47
				flag10 = true
			end)

			while not flag10 and v24() < v44 + 8 do
				v41()
			end

			if flag8 then
				local v46 = v3
				v30(("[") .. os["clock"]() .. ("] ######## L_PASS: d: ") .. v32(flag10) .. (", ok: ") .. v32(v45) .. "")
			end

			if not flag10 then
				flag6 = false
				n7 = 10

				if flag8 then
					warn("[2] Unable to connect (timeout)")
				end
			end

			if not v45 then
				n7 += 1

				if n7 > 5 then
					flag6 = false
				end

				v41(n7 < 4 and 10 or 120)
				continue
			end

			break
		end

		if flag8 then
			local v44 = v3
			v30(("[") .. os["clock"]() .. "] [CONNECT] Reconnected")
		end

		arg["__OBJECT_ACTIVE"] = true
		arg["Websocket"] = v43
		flag6 = arg
		local v44 = v3

		v43:Send(fn6({
			["Opcode"] = "PING",
			["Data"] = {},
		}))

		v15(function()
			v43["OnClose"]:Connect(fn9)
			v43["OnMessage"]:Connect(fn8)
		end)

		v15(function()
			v43["ConnectionClosed"]:Connect(fn9)
			v43["DataReceived"]:Connect(fn8)
		end)
	end

	v15(function()
		local v43 = v3
		arg["Websocket"]["OnClose"]:Connect(fn9)
		local v44 = v3
		arg["Websocket"]["OnMessage"]:Connect(fn8)
	end)

	v15(function()
		local v43 = v3
		arg["Websocket"]["DataReceived"]:Connect(fn8)
		local v44 = v3
		arg["Websocket"]["ConnectionClosed"]:Connect(fn9)
	end)

	arg["LastPong"] = tick()

	while v41(10) do
		if flag8 then
			local v43 = v3
			v30(("[") .. os["clock"]() .. "] [PING] Client ---> Server")
		end

		if arg["__OBJECT_ACTIVE"] then
			local v43 = v3

			arg["Websocket"]:Send(fn6({
				["Opcode"] = "PING",
				["Data"] = {},
			}))

			if tick() - arg["LastPong"] > 20 then
				if flag8 then
					local v44 = v3
					v30(("[") .. os["clock"]() .. "] [WARN] Server timeout")
					warn("Server timeout")
				end

				arg["Websocket"]:Close()
			end
		end
	end
end

tbl9.new = function(arg, arg2)
	local tbl10 = {}
	v19(tbl10, arg)
	arg["__index"] = arg
	local v43 = v24()
	local flag10 = false
	local v44 = nil
	local v45 = nil

	v27(function()
		local v46, v47 = v15(fn5, arg2)
		v44 = v46
		v45 = v47
		flag10 = true
	end)

	while not flag10 and v24() < v43 + 8 do
		v41()
	end

	if not flag10 then
		flag6 = false
		error("Unable to connect to WS")
	end

	assert(v44, v45)
	arg["Websocket"] = v45
	arg["Url"] = arg2
	local v46 = v3
	arg["OnMessageSignal"] = Instance["new"]("BindableEvent")
	local v47 = v3
	arg["OnMessage"] = arg["OnMessageSignal"]["Event"]
	arg["Requests"] = {}
	arg["__OBJECT_ACTIVE"] = true
	v42(fn7)(arg)

	repeat
		v28:Wait()
	until arg["LastPong"]

	return tbl10
end

tbl9.request = function(arg, arg2)
	if flag8 then
		local v43 = v3
		v30(("[") .. os["clock"]() .. ("] [REQUEST] Client ---> Server, ObjectActive: ") .. v32(arg["__OBJECT_ACTIVE"]) .. "")
	end

	local n7 = 0

	while not arg["__OBJECT_ACTIVE"] do
		n7 += 1
		v41(0.1)

		if n7 > 40 then
			if flag8 then
				warn("[3] r_timeout")
			end

			flag6 = false
			return ""
		end
	end

	if flag8 then
		local v43 = v3
		v30(("[") .. os["clock"]() .. "] [REQUEST] [!!!] OBJECT ACTIVE PASSED")
	end

	local v43 = math["random"](1, 99999999)
	local v44 = v3
	local v45 = Instance["new"]("BindableEvent")

	if flag8 then
		local v46 = v3
		v30(("[") .. os["clock"]() .. "] Event assigned")
	end

	arg["Requests"][v43] = v45
	local v46 = v3

	arg["Websocket"]:Send(fn6({
		["Opcode"] = "REQUEST",
		["Data"] = arg2,
		["Id"] = v43,
	}))

	if flag8 then
		local v47 = v3
		v30(("[") .. os["clock"]() .. "] Packet sent!")
	end

	local flag10 = false

	v27(function()
		v41(30)

		if not flag10 then
			if flag8 then
				local v47 = v3
				v30(("[") .. os["clock"]() .. "] !!!!!! ALERT !!!!!!!!! REQ TIMEOUT !!!!!!!!")
			end

			local v47 = arg["Requests"][v43]
			v47:Fire("")

			if flag8 then
				local v48 = v3
				v30(("[") .. os["clock"]() .. "] Responded with something empty")
			end

			return v47:Destroy()
		end
	end)

	local v47 = v45["Event"]
	flag10 = true
	return (v47:Wait())
end

tbl9.close = function(arg)
	arg["SocketClosed"] = true
	arg["Websocket"]:Close()
end

local v43 = script_key or "none"
local n7 = 0
local flag10 = false

v27(function()
	flag10 = true

	while not flag7 do
		n7 += 1
		v28:Wait()
	end
end)

while not flag10 do
	v28:Wait()
end

local function fn8()
	local v44 = n7

	while n7 == v44 do
		v28:Wait()
	end
end

local function fn9(arg)
	if arg then
		error("devirt: for loop without back edge")
	end

	while v21() do
	end
end

local function fn10(arg)
	for i = 1, 2 do
		local n8 = arg % 9915 + 4
		local n9 = nil
		local n10 = nil

		for i2 = 1, 3 do
			n9 = arg % 4155 + 3

			if i2 % 2 == 1 then
				n9 += 522
			end

			n10 = arg % 9996 + 1

			if n10 % 2 ~= 1 then
				n10 *= 3
			end
		end

		local n11 = arg % 9999995 + 1 + 19855
		local n12 = arg % 1000
		local n13 = fn3((arg - n12) / 1000) % 1000
		local n14 = arg % (n8 * n9 + 9999) + 19855
		arg = (n12 * n13 + n11 + arg % (419824125 - n11 + n12) + (n14 + n12 * n9 + n13) % 999999 * (n11 + n14 % n10)) % 99999999999
	end

	return arg
end

local n8 = 1
local v44 = syn and syn["request"] or request or http_request

if v13 and ({ v13() })[1] == "Krampus" then
	n8 = 9
elseif v13 and ({ v13() })[1] == "ScriptWare" then
	if ({ v13() })[2] == "Mac" then
		n8 = 5
	else
		n8 = 2
	end
elseif FLUXUS_LOADED or EVON_LOADED or WRD_LOADED or COMET_LOADED or OZONE_LOADED or TRIGON_LOADED then
	n8 = 4
elseif KRNL_LOADED then
	n8 = 3
elseif Electron_Loaded then
	n8 = 6
elseif v13 and ({ v13() })[1] == "Sirhurt" then
	n8 = 7
elseif v13 and ({ v13() })[1] == "Solara" then
	n8 = 11
elseif v13 and ({ v13() })[1] == "incognito" then
	n8 = 11
elseif v13 and ({ v13() })[1] == "NX" then
	n8 = 11
elseif v13 and ({ v13() })[1] == "Xeno" then
	n8 = 11
elseif v13 and ({ v13() })[1] == "Nezur" then
	n8 = 11
elseif v13 and ({ v13() })[1] == "Rebel" then
	n8 = 15
end

if v13() == "Wind" then
	n8 = 11
end

local function fn11(arg, arg2)
	tbl7 = {}
	tbl6 = {}

	for i = 0, arg do
		local v45 = v12(i)
		tbl6[i] = v45
		tbl6[v45] = i
	end

	for i = 1, #arg2 do
		local v45 = arg2[i]
		tbl7[i - 1] = v45
		tbl7[v45] = i - 1
	end
end

local tbl10 = {}
local v45 = "a"
local v46 = "b"
local v47 = "Q"
local v48 = "k"
local v49 = "O"
local v50 = "I"
local v51 = "1"
local v52 = "l"
local v53 = "0"
local v54 = "9"
local v55 = "E"
local v56 = "3"
local v57 = "J"
local v58 = "7"
local v59 = "G"
local v60 = "T"
tbl10[1] = v45
tbl10[2] = v46
tbl10[3] = v47
tbl10[4] = v48
tbl10[5] = v49
tbl10[6] = v50
tbl10[7] = v51
tbl10[8] = v52
tbl10[9] = v53
tbl10[10] = v54
tbl10[11] = v55
tbl10[12] = v56
tbl10[13] = v57
tbl10[14] = v58
tbl10[15] = v59
tbl10[16] = v60
fn11(255, tbl10)

fn3 = function(arg)
	return arg - arg % 1
end

local function fn12(arg)
	local n9 = 1103515245
	local n10 = 12345
	local n11 = 99999999
	local n12 = arg % 2147483648
	local n13 = 1

	return function(arg2, arg3)
		local v61 = n11
		local n14 = n9 * n12 + n10
		local n15 = n14 % v61 + n13
		n13 += 1
		n12 = n15
		n10 = n14 % 4859 * v61 % 5781
		return arg2 + n15 % arg3 - arg2 + 1
	end
end

local function fn13(arg)
	for i = 1, 2 do
		local n9 = arg % 9915 + 4
		local n10 = nil
		local n11 = nil

		for i2 = 1, 3 do
			n10 = arg % 4155 + 3

			if i2 % 2 == 1 then
				n10 += 522
			end

			n11 = arg % 9996 + 1

			if n11 % 2 ~= 1 then
				n11 *= 3
			end
		end

		local n12 = arg % 9999995 + 1 + 19855
		local n13 = arg % 1000
		local n14 = fn3((arg - n13) / 1000) % 1000
		local n15 = arg % (n9 * n10 + 9999) + 19855
		arg = (n13 * n14 + n12 + arg % (419824125 - n12 + n13) + (n15 + n13 * n10 + n14) % 999999 * (n12 + n15 % n11)) % 99999999999
	end

	return arg
end

local function fn14()
end

local function fn15(arg)
	local tbl11 = {}
	local tbl12 = {}
	local tbl13 = {}

	for i = 1, 13 do
		local tbl14 = {}
		local tbl15 = {}
		tbl11[tbl14] = tbl15
		tbl12[tbl15] = i
		tbl13[tbl14] = tbl15
	end

	if arg then
		tbl11 = arg[1]
		tbl12 = arg[2]
		tbl13 = arg[3]
	end

	local n9 = 0
	local n10 = 0
	local n11 = 0

	for k, v61 in v11, tbl11, nil do
		local v62 = tbl12[v61]

		if tbl13[k] == v61 then
			n9 += 1
		end

		n10 += 1
		n11 = n10 % 2 == 0 and n11 * v62 or n11 + v62 + n10
	end

	if n9 ~= 13 then
		n6 = -1
	end

	tbl8 = { tbl11, tbl12, tbl13 }
	n6 = n11
	return false
end

local function fn16(arg)
	for i = 1, 2 do
		local n9 = arg % 9915 + 4
		local n10 = nil
		local n11 = nil

		for i2 = 1, 3 do
			n10 = arg % 4155 + 3

			if i2 % 2 == 1 then
				n10 += 522
			end

			n11 = arg % 9996 + 1

			if n11 % 2 ~= 1 then
				n11 *= 3
			end
		end

		local n12 = arg % 9999995 + 1 + 19855
		local n13 = arg % 1000
		local n14 = fn3((arg - n13) / 1000) % 1000
		local n15 = arg % (n9 * n10 + 9999) + 19855
		arg = (n13 * n14 + n12 + arg % (419824125 - n12 + n13) + (n15 + n13 * n10 + n14) % 999999 * (n12 + n15 % n11)) % 99999999999
	end

	return arg
end

local function fn17(arg)
	for i = 1, 2 do
		local n9 = arg % 9915 + 4
		local n10 = nil
		local n11 = nil

		for i2 = 1, 3 do
			n10 = arg % 4155 + 3

			if i2 % 2 == 1 then
				n10 += 522
			end

			n11 = arg % 9996 + 1

			if n11 % 2 ~= 1 then
				n11 *= 3
			end
		end

		local n12 = arg % 9999995 + 1 + 19855
		local n13 = arg % 1000
		local n14 = fn3((arg - n13) / 1000) % 1000
		local n15 = arg % (n9 * n10 + 9999) + 19855
		arg = (n13 * n14 + n12 + arg % (419824125 - n12 + n13) + (n15 + n13 * n10 + n14) % 999999 * (n12 + n15 % n11)) % 99999999999
	end

	return arg
end

local function fn18(arg)
	local n9 = 1103515245
	local n10 = 12345
	local n11 = 99999999
	local n12 = arg % 2147483648
	local n13 = 1

	return function(arg2, arg3)
		local v61 = n11
		local n14 = n9 * n12 + n10
		local n15 = n14 % v61 + n13
		n13 += 1
		n12 = n15
		n10 = n14 % 4859 * v61 % 5781
		return arg2 + n15 % arg3 - arg2 + 1
	end
end

local n9 = 68
fn14(67, "%", " - Loading Luarmor client...")
n6 = -1
fn15()

while n6 == -1 do
end

local v61 = fn18(n7 + n6)

if n8 == 9 or n8 == 15 then
	local n10 = 0

	v15(function()
		local function fn19(arg)
			v32(arg[1])
		end

		fn19(v19({}, { ["__index"] = function()
			local fn20 = nil

			fn20 = function()
				n10 += 1
				return fn20()
			end

			fn20()
		end }))
	end)

	local n11 = 0

	v15(function()
		v44(v19({}, { ["__index"] = function()
			local fn19 = nil

			fn19 = function()
				n11 += 1
				return fn19()
			end

			fn19()
		end }))
	end)

	if n11 + n10 < 20000 then
		n9 = 19
	elseif n11 - n10 ~= 0 then
		n9 = 189
	end
end

local function fn19(arg, arg2, arg3)
	local v62 = v3
	local tbl11 = { ["Method"] = "GET" }

	if arg2 then
		tbl11 = v19(tbl11, { ["__index"] = function(arg4, arg5)
			if arg5 == "Url" then
				local v63 = v3
				local v64 = v16(v17(), "[^:]*:(%d+)")
				local v65 = v64()
				local v66 = v64()
				local n10 = 1

				v15(function()
					n10 = v18(v66) - v18(v65)
				end)

				if (n8 == 9 or n8 == 15) and (n10 ~= 0 or v65 ~= v66) then
					n9 = 121

					while arg3 do
					end
				end

				return arg
			end

			return v20(tbl11, arg5)
		end })
	else
		tbl11["Url"] = arg
	end

	local v63 = v44(tbl11)

	if v63["StatusCode"] == 0 then
		if flag8 then
			warn("[CRITICAL] received StatusCode = 0; most likely an executor problem. Re-execute the script")
		end

		local v64 = v3
		writefile("luarmor-err-code0.txt", "[CRITICAL] received StatusCode = 0; most likely an executor problem. Re-execute the script")
	end

	return v63["Body"], v63["Headers"]
end

fn8()

local function fn20(arg)
	if v35()[8753563] == 22044 and n8 ~= 11 then
		if flag8 then
			warn("Cannot load Luarmor client (0x561c) task collision detected.. ")
		end

		v27(function()
			v21(5)
			v35()[8753563] = nil
		end)

		fn9()
	end

	v35()[8753563] = 22044
	local flag11 = false
	local tbl11 = { v22, v19, v32 }

	tbl11[-1] = n8 == 3 and function()
	end or v44

	local v62 = v26
	local v63 = v25
	local v64 = v24
	local v65 = v23
	local v66 = v15
	tbl11[4] = v12
	tbl11[5] = v62
	tbl11[6] = v63
	tbl11[7] = v64
	tbl11[8] = v65
	tbl11[9] = v66

	local function fn21()
		flag11 = true
		return (" "):rep(16777215)
	end

	local v67 = v19({}, { ["__tostring"] = function()
		flag11 = true
		return (" "):rep(16777215)
	end })

	for k, v68 in v11, tbl11, nil do
		if k ~= -1 then
			local flag12 = n8 ~= 11
			local flag13

			if flag12 then
				local v69 = v3
				flag13 = v22(v68)["what"] == "Lua"
			else
				flag13 = flag12
			end

			if flag13 then
				flag11 = true
			end
		end

		if v68 ~= v10 and v68 ~= v32 then
			local v69 = v10
			local v70 = v32
			local v71 = error
			local env = getfenv()
			env["tostring"] = fn21
			env["error"] = fn21
			env["print"] = fn21

			if k == -1 then
				if n8 ~= 5 then
					v15(v68, "")
				end
			else
				v15(v68, v67)
			end

			env["tostring"] = v70
			env["print"] = v69
			env["error"] = v71
		end
	end

	if flag11 and n8 ~= 11 then
		n9 = 85

		if arg then
			fn9(true)
		end
	end

	v35()[8753563] = nil
end

local v62 = n7
local v63 = nil
local flag11 = nil
local tbl11, tbl12

while true do
	local v64 = v15(function()
		local v64 = fn19
		local v65 = v3
		v63 = v64(tbl5["Host"] .. "/status", n8 == 9 or n8 == 15)
		local data = v14:GetService("HttpService"):JSONDecode(v63)

		if not data["active"] then
			warn(data["message"])
			fn9()
		end

		if not data["versions"][tbl5["Version"]] then
			warn("This script is outdated! Try using the latest version.")
			fn9()
		end

		tbl5["Host"] = flag4 and LT_R_RRT_H or v7 and "http://mc.felinemastery.xyz" or ("https://") .. v6
		local v66 = tbl5
		local v67 = v3
		v9 = data["versions"][v66["Version"]]
	end)

	fn8()

	if not v64 then
		if flag11 then
			break
		end
		fn14(69, "%", " - Trying failover EU host..")
		v6 = "eu1-roblox-auth.luarmor.net"
		tbl5["Host"] = flag4 and LT_R_RRT_H or "https://eu1-roblox-auth.luarmor.net"
		flag11 = true
	end

	if not v64 then
		continue
	end

	local function fn21(arg)
		local n10 = 1103515245
		local n11 = 12345
		local n12 = 99999999
		local n13 = arg % 2147483648
		local n14 = 1

		return function(arg2, arg3)
			local v65 = n12
			local n15 = n10 * n13 + n11
			local n16 = n15 % v65 + n14
			n14 += 1
			n13 = n16
			n11 = n15 % 4859 * v65 % 5781
			return arg2 + n16 % arg3 - arg2 + 1
		end
	end

	local flag12 = false

	v27(function()
		if not v15(function()
			local v65 = tbl9
			local new = v65.new
			local v66 = flag4 and LT_R_RRT_W
			local str2

			if v66 then
				str2 = v66
			else
				local v67 = v7

				if v7 then
					local v68 = v6
					local v69 = v3
					str2 = ("ws://") .. v68 .. ":80/wshttpemu"
				else
					str2 = v67
				end
			end

			if not str2 then
				local v67 = v6
				local v68 = v3
				str2 = ("wss://") .. v67 .. ":443/wshttpemu"
			end

			flag6 = new(v65, str2)
		end) then
			local v65 = v3
			fn14(75, "%", " - Failed to connect to WS, falling back to HTTP.")
			flag6 = false
		end

		flag12 = true
	end)

	local n10 = n7 % 8585 * v62 % 9910
	fn20()

	if flag5 then
		n9 = 146
	end

	fn14(85, "%", " - Connecting to server..")
	local v65 = fn21(n10 + v61(2, 4096))
	local v66 = v61(1111, 32768)
	local n11 = 12000 + ((1398563873 * ((1398563873 * (1361 + n10 + n6 % 1000 + n6) % 1610612736 + 22491) % 95716599 + 1) + 22491) % 95716599 + 1) % 120000 - 12000 + 1
	local tbl13 = { n11 + v65(100000, 1000000), v66, n11 + v61(3333, 15625) + n7, (v65(10000, 1000000)) }
	n6 = -1
	fn15()
	local flag13 = false

	if n6 == -1 then
		n6 = 100
		flag13 = true
	end

	local n12 = 0
	local n13 = 0
	local n14 = 0
	local n15 = 1
	local tbl14 = { [0] = 0 }

	local function fn22(arg, arg2, arg3)
		local n16 = arg2 and arg or tbl6[arg]

		if not arg3 then
			n16 = (n16 + 4096 - tbl14[n12]) % 256
			n14 += n16
			n12 = (n12 + 1) % n15
		end

		local n17 = n16 % 16
		return tbl7[(n16 - n17) / 16] .. tbl7[n17]
	end

	local function fn23(arg)
		local n16 = 0

		for i = 1, #arg do
			n16 += v25(arg, i)
		end

		return n16
	end

	local function fn24(arg, arg2)
		local v67 = tbl7
		local n16 = (tbl7[v26(arg, 1, 1)] * 16 + v67[v26(arg, 2, 2)] + tbl14[n13]) % 256
		n13 = (n13 + 1) % n15
		if arg2 then
			return n16
		end
		return tbl6[n16]
	end

	local function fn25(arg)
		local tbl15 = {}
		n13 = 0
		local n16 = 1

		while true do
			local v67 = fn24(v26(arg, n16, n16 + 1), true)
			n16 += 2
			local v68 = ""

			for i = 1, v67 do
				v68 ..= fn24(v26(arg, n16, n16 + 1))
				n16 += 2
			end

			tbl15[#tbl15 + 1] = v68
			if not (n16 > #arg) then
				continue
			end
			break
		end

		return tbl15
	end

	local function fn26(arg, arg2)
		local v67 = fn22(#arg, true, arg2)

		for i = 1, #arg do
			v67 ..= fn22(v26(arg, i, i), false, arg2)
		end

		return v67
	end

	local function fn27(arg, arg2, arg3)
		if arg == 1 then
			tbl14 = arg2
			n15 = arg3
		elseif arg == 2 then
			n12 = 0
			n14 = 0
		elseif arg == 3 then
			return n14
		end
	end

	local v67 = fn18(v61(2, 32768 + v24() % 2000) + n6 % 4096)
	local v68 = fn12(v65(1, 32768) + n7 + v24() % 1000)
	local v69 = v67(111111, 999999)
	local tbl15 = {}

	for i = 1, v69 % 30 + 1 do
		local fn28

		if i == 2 then
			fn28 = v32
		elseif i == 8 then
			fn28 = v10
		elseif i == 17 then
			fn28 = v26
		else
			fn28 = function()
			end
		end

		tbl15[i] = fn28
	end

	local n16 = v68(111111, 999999) + 12663
	local n17 = v67(1, 1234) * v68(2, 1235) + n6 % 80000
	local n18 = 10000 + ((1445613873 * ((1445613873 * (n11 + n6) % 1627389952 + 23515) % 94716599 + 1) + 23515) % 94716599 + 1) % 100000 - 10000 + 1
	local tbl16 = { n18 + v67(100000, 1000000), n18 + v68(100000, 1000000), (v67(100000, 1000000)) }
	v5 = v4 or v5

	if v5 then
		n9 = 218
	end

	if flag13 then
		n9 = 250
	end

	local v70 = tbl16[1]
	local n19 = 14039 + tbl13[4]
	local n20 = tbl13[2] + 12663
	local n21 = 17722 + tbl13[1]
	local str2 = ((((((fn26(("") .. n16) .. fn26(("") .. fn16(17722 + v69) .. fn13(n9 + n17) .. fn10(n16 - 12663))) .. fn26(n17 .. "") .. fn26(("") .. v69)) .. fn26(tbl13[3] + 14451 .. "")) .. fn26(("") .. v70) .. fn26(("") .. n19)) .. fn26(tbl16[3] .. "") .. fn26(("") .. n20)) .. fn26(tbl16[2] .. "") .. fn26(("") .. n21)) .. fn26(str or "?")
	local str3 = fn26(fn17(fn27(3) + 14894) .. "", true) .. str2
	local tbl17 = {}
	local v71 = v68(111111, 999999)
	local v72 = n6
	getfenv()[tbl17] = v71
	local v73, v74 = fn19(tbl5["Host"] .. ("/") .. v9 .. ("/auth/") .. tbl5["ScriptID"] .. ("/init?t=") .. str3 .. ("&v=") .. tbl5["ScriptVersion"] .. ("&k=") .. v43, n8 == 9 or n8 == 15)
	n6 = -1
	fn15(tbl8)

	while n6 == -1 do
	end

	while tbl13[2] ~= v66 do
	end

	local v75, v76, v77 = v33(tbl15)
	local n22 = 0

	for k, v78 in v75, v76, v77 do
		if k == 2 and v78 ~= v32 then
			n9 = 147
		end

		if k == 8 and v78 ~= v10 then
			n9 = 147
		end

		if k == 17 and v78 ~= v26 then
			n9 = 147
		end

		n22 = k
	end

	if n22 ~= v69 % 30 + 1 then
		n9 = 147
	end

	local flag14 = false

	if n9 == 147 then
		flag14 = true
	end

	if n6 ~= v72 then
		n9 = 100
		flag14 = true
	end

	if v73 == "err" then
		while true do
		end
	else
		local fn28, n23, v78, n24, n25, v79, tbl18, n26, n27, n28

		do
			if v34(v73, "Old script, please use the latest version") then
				if v8 then
					v8("flush")
					return
				end
			end

			if v26(v73, 1, 1) == "!" then
				local v80 = "Whitelist Error"
				local v81

				if string["find"](v73, ";;lrm_is_diff_msg") then
					v80 = "You are blacklisted"
					v81 = v26(v73, 2, #v73 - 17)
				else
					v81 = v26(v73, 2, #v73)
				end

				fn14(100, "[ AUTH ERROR ]", " - Unable to authenticate.", Color3["new"](1, 0, 0), "error")
				fn4(v80, v81)
				fn9()
			end

			if v74 then
				if not v74["Argwhudata"] then
					local v80 = v74["argwhudata"]
				end
			end

			local n29 = tbl13[4] % 256
			local tbl19 = { [0] = tbl13[1] % 256, tbl13[2] % 256, tbl13[3] % 256, n29 }
			fn8()

			fn28 = function(arg)
				local n30 = 1103515245
				local n31 = 12345
				local n32 = 99999999
				local n33 = arg % 2147483648
				local n34 = 1

				return function(arg2, arg3)
					local v80 = n32
					local n35 = n30 * n33 + n31
					local n36 = n35 % v80 + n34
					n34 += 1
					n33 = n36
					n31 = n35 % 4859 * v80 % 5781
					return arg2 + n36 % arg3 - arg2 + 1
				end
			end

			if getfenv()[tbl17] ~= v71 then
				n9 = 100
				flag14 = true
			end

			n23 = 1

			for i = 1, 30 do
				local n30

				if v32({}) > v32({}) then
					n30 = n23 + 1
				else
					n30 = n23 * 2
				end

				n23 = n30 % 10000
			end

			fn27(1, tbl19, 4)
			v78 = fn25(v73)
			n24 = v78[1] - n16
			n25 = v78[4] - v69

			while n29 ~= tbl19[3] do
			end

			fn20()
			v79 = tbl19[3]

			tbl18 = {
				[0] = tbl19[0],
				[2] = tbl19[1],
				[4] = tbl19[2],
				[6] = v79,
				v78[9],
				[3] = v78[7],
				[5] = v78[2],
				[7] = v78[6],
			}

			fn27(1, tbl18, 8)
			n26 = v78[8] - tbl16[1]
			n27 = v78[3] - tbl16[2]
			n28 = v78[5] - tbl16[3]
			local str4 = ("") .. fn17(tbl16[3] + 19852) .. fn16(tbl16[1] + 31) .. fn13(tbl16[2] + 10691)

			if v78[11] == str4 and ({ [str4] = true })[v78[11]] then
				flag2 = true
			else
				local str5 = ("") .. fn10(tbl16[3] + 19852) .. fn13(tbl16[1] + 69) .. fn16(tbl16[2] + 10691)

				if v78[11] == str5 and ({ [str5] = true })[v78[11]] then
					flag2 = true
				end
			end
		end

		local n29, v80, str4

		do
			if flag2 then
				local flag15 = v18(v78[14] and v78[14] or "-1") == -1
				v18(v78[15] and v78[15] or "0")
			end

			n6 = -1
			fn15()

			if n6 == -1 then
				n9 = 250
				n6 = 100
			end

			n29 = n7 + v67(111111, 999999) + v68(1234, 5678) + n6 % 99915 + n23
			tbl16[4] = n7 + n6 % 9951
			v67(100000, 1000000 + n6 % 1000)
			tbl16[5] = n6 % 8005 + n23 + v68(100000, 1000000 + n6 % 5000)
			tbl16[6] = v67(100000, 1000000)
			fn27(2)
			v80 = v78[10]
			local v81 = tbl16[6]
			local str5 = fn26(("") .. fn13(v78[13] + 6468) .. fn17(n29 + n9) .. fn16(v78[10] + v69)) .. fn26(tbl16[5] .. "") .. fn26(("") .. n29) .. fn26(("") .. v81) .. fn26(tbl16[4] .. "")
			str4 = fn26(fn13(fn27(3) + 14894) .. "", true) .. str5
		end

		local v81 = v78[12]
		local response = v14:HttpGet(tbl5["Host"] .. ("/") .. v9 .. ("/auth/start/") .. v81 .. ("?t=") .. str4)

		while v79 ~= tbl18[6] do
		end

		if response == "err" then
			while true do
			end
		else
			if v26(response, 1, 1) == "!" then
				v14:GetService("Players")["LocalPlayer"]:Kick(response)
				fn9()
			end

			do
				local v82 = fn25(response)
				local n30 = 1
				local v83 = fn28(1 + v67(100, 1000 + n23) + v68(500, 5000 + n23) + n7 % 10000)
				local flag15 = false
				local n31 = 0
				local flag16 = false
				local flag17 = false
				local v84 = nil

				for i = 1, 3 do
					local v85 = v82[3]
					local str5 = fn13(tbl16[5] + 12663) .. fn13(tbl16[4] + fn23(flag16 and "?" or v14["JobId"])) .. fn13(tbl16[6] + tbl16[2])

					if v85 == str5 and ({ [str5] = true })[v85] then
						flag3 = true

						if not (v82[8] and v82[8] ~= "?" and v82[8]) then
							local v86 = "Unknown"
						end

						if not (v82[9] and v82[9]) then
							local v86 = "Unknown"
						end

						v84 = v82[6]

						do
							local n32 = v82[1] - tbl16[4]
							local n33 = v82[7] - tbl16[5]
							local n34 = v82[5] - tbl16[6]
							local v86 = n26
							local v87 = n27
							local v88 = n28

							n26 = function(arg)
								if not (flag15 or n31 < v29() - 8) then
									n30 = (n30 + arg % 66) % 6644
									return v86 * arg % n32 + arg * 3
								end

								while true do
								end
							end

							n27 = function(arg)
								if not (flag15 or n31 < v29() - 8) then
									n30 = (n30 + arg % 50) % 5891
									return v87 * arg % 10000 + arg * n33 % 4
								end

								while true do
								end
							end

							n28 = function(arg)
								if not (flag15 or n31 < v29() - 8) then
									n30 = (n30 + arg % 35) % 6711
									return (arg + n34) % 100 * arg % (v88 % 100 + 1)
								end

								while true do
								end
							end
						end

						flag17 = true
						break
					elseif i == 3 then
						flag17 = false
						v84 = nil
					else
						flag16 = true
						flag17 = false
						v84 = nil
					end
				end

				if not flag17 then
					while true do
					end
				else
					if not flag14 then
						local v85, fn29, fn30, genv, scriptKey, v86, v87, v88, v89, v90
						local v91, v92, v93, v94, v95, v96, flyteBBState, v97, tbl19, tbl20
						local tbl21, fn31, fn32, fn33, fn34, fn35, tbl22, colors, localPlayer, touchEnabled
						local v98, fn36, fn37, v99, v100, v101, v102, tbl23, v103, fn38
						local fn39, fn40, tbl24, tbl25, Data, fn41

						do
							local fn42, fn43, v104, tbl26, obj, fn44, fn45, fn46, fn47, fn48
							local index, fn49, addDoubleSlider, addSlider, addToggle

							do
								local v105

								do
									do
										do
											while not flag12 do
												v28:Wait()
											end

											flag7 = true

											do
												local flag18 = false
												local flag19 = false
												local n32 = 0
												local n33 = 0
												local n34 = 0
												local flag20 = false
												local n35 = 0
												local n36 = 0
												local v106 = v78[12]

												v27(function()
													flag19 = true

													while not flag9 do
														local n37 = v83(1000, n30 + 10000) + n30
														local n38 = v83(1000, n30 + 10000) + n30
														n35 = n37
														n36 = n38
														fn27(2)
														local v107 = fn26
														local str5 = fn26(n36 .. "") .. v107(fn17(n36 + v80) .. ("") .. fn16(n35 + n16)) .. fn26(n35 .. "")
														local v108 = ""
														local v109 = v9
														local v110 = v3
														local str6 = tbl5["Host"] .. ("/") .. v109 .. ("/auth/heartbeat?t=") .. str5 .. ("&s=") .. v106

														v15(function()
															if flag8 then
																local v111 = v3
																v30(("[") .. v29() .. ("] Sending ticket...(") .. v32(flag6) .. ")")
															end

															if flag6 == false then
																v108 = fn19(str6)
															else
																v108 = flag6:request({ ["Url"] = str6 })
															end

															if flag8 then
																local v111 = v3
																v30(("[") .. v29() .. "] Ticket responded")
															end

															if v108 and #v108 > 3 then
																if v108 == "NOT_FOUND" then
																	flag15 = true
																	flag2 = false
																	flag3 = false
																	n25 = 1
																	n24 = 2
																	local v111 = v3
																	v14:GetService("Players")["LocalPlayer"]:Kick("A fatal Luarmor error occurred, please restart your script.")
																	fn9()
																end

																if v108 == "FAIL" then
																	flag15 = true
																	flag2 = false
																	flag3 = false
																	n25 = 1
																	n24 = 2
																	local v111 = v3
																	writefile("luarmor-dbgfail.txt", "resp:fail")

																	while true do
																	end
																else
																	v108 = fn25(v108)[1]

																	if v108 == fn13(n35 * n36 % 100000 + n29 + 17722) .. "" then
																		n33 += 1
																		flag20 = true
																		flag18 = true
																	elseif v108 == fn10(n35 * n36 % 100000 + n29 + 17722 + 4919) .. "" then
																		flag20 = true
																		flag18 = true
																		flag9 = true

																		v15(function()
																			flag6:close()
																		end)
																	else
																		flag15 = true
																		flag2 = false
																		flag3 = false
																		n25 = 1
																		n24 = 2
																		local v111 = v3
																		v14:GetService("Players")["LocalPlayer"]:Kick(("Heartbeat failure [0x01]. ttl: ") .. n33)
																	end
																end
															end
														end)

														v21(20)
													end
												end)

												while not flag19 do
													v28:Wait()
												end

												flag19 = false

												v27(function()
													flag19 = true
													local n37 = 200

													while true do
														n37 += 1

														if not flag9 and n37 >= 250 then
															if flag20 then
																n32 += 1

																if n32 > 4 then
																	n32 = 0

																	if n34 < 10 then
																		n34 += 1
																	end
																end
															else
																n34 -= 1

																if n34 <= 0 then
																	flag15 = true
																	flag2 = false
																	flag3 = false
																	n25 = 1
																	n24 = 2
																	local v107 = n33
																	writefile("luarmor-error-log.txt", ("[0x2001] ") .. v107 .. (" v: ") .. v32(flag6))
																end
															end

															flag20 = false
															n37 = 0
														end

														n31 = v29()
														v21(0.18)
														if n31 ~= v29() then
															continue
														end
														flag15 = true
														flag2 = false
														flag3 = false
														n25 = 1
														n24 = 2
														local v107 = n33
														writefile("luarmor-error-log.txt", ("[0x2022] ") .. v107 .. (" v: ") .. v32(flag6))
													end
												end)

												fn14(95, "%", " - Finalizing..")

												while not flag19 or not flag18 do
													v21()
												end
											end
										end

										do
											do
												fn14(100, "[   SUCCESS   ]", (" - Authenticated in ") .. v29() - now .. "s", Color3["new"](0, 1, 0), "done")
												v85 = nil

												do
													local tbl27 = {
														[4] = 170,
														[20] = 117,
														[18] = 229,
														[14] = 137,
														[11] = 67,
														[16] = 245,
														[21] = 18,
														[15] = 125,
														[7] = 102,
														99,
														[5] = 194,
														[6] = 113,
														[9] = 218,
														[17] = 70,
														[12] = 240,
														[10] = 40,
														[8] = 172,
														[3] = 200,
														[19] = 104,
														248,
														[13] = 10,
													}

													luraph_runtime1(v84, buffer.fromstring("V\145\135\178q\0305\2054#\245\16>\226e\0308\127\131f\189\223x\3\193\254\200\203-l\26\214S\188\151\239\30r¥\244jG\172q\7-\t\182K˗h\169\174\241l\239\1419\213Yv\200\4\22\21\26\175gTO@\224;-햷\0262\u{9A}C\0\169=\22?\198k\224p1[>\133\139|*\224]K\188\181\1522p-'_\255\175Ɛ\166\142d\212\237\229\236\3\155,\144W\227QKx\128Ζ\130C\141\139\137\188E\0alѶ\160\1677BA%\226C\6\1900\252\195\11\176\167\253t\25ȣ\18.El\144\169\188\222\12i\236\218l\154$ّ]Ʈ\166r\138\28L\153\144A\tcR\129\173\16C\188,\149\250\2\t\165\254\177\142\204>\16\184\131o\229zڰ\252\207&{\186?\212\17k<\241}\239ø\185\7j\159\139\168y\200\2557\252ݗ\23[\2124j\216\192<\147q6\18\166\11\128\211iJ\220(\17\214\22\161&\248\184\t\179:\131\163\rV\168ܢ\192\134\221\23\228g\252\247\245!;\4r\144\179\213С\194\235U\246\225\194\243\2243\143\2472\249\164+\196\21\227\6\154\159\28\2\191\226{\168?o\139\162\2439zP\226\\\24\16\197\251\143\21\168V\225<\193\241\224_\31m\202\2161V\197\215;\127\169\146\2\1845Uv\22\192\251\234\131\228!R\7\167\183\30Y\229@\1447M\163\198K\214\248=7$샳\239t\28J\189\255Xz\162ۏ\233\206\220z\\fݚ\129\179(34\221\1960\242\244\149\226=\154\174/\217J^h\229\239\30\254j\157\29\17g\21\242,U\2 \224[5\216e-\26\31\233Z\185ٜ\142\20PBt\226\230\193\0155\247\232k\230\234%\"`\\rr\211\2\239\142\248%\7\248\1654^7\214M\252B\191\201r)\182\29\253\232\149\5\247I/\181\128%E \175\185\160\2\157\138eE}\251\176\139\197\217R\161\179\184=s7\4W\2388g[\246\169\2M}\182J\206$\211\227\246\230r\174\250\27J\0h\184٪\204\251Anڐ\"E\228f\146\231{.\12\255\171\180\250\151#\205\217l\240Ǐ-|\251\139\166\143\134\175\\\183'\141J\184~\178{\0188\153n\162\201䋵2\184a\131\20c\19\142\236\232\8\30\20\150\25\28\16\182\234<\169K\183\8Y\184(\213\25u\199C}{ I\14\0p\4-\\/\152\133\231\171M/\165:r\1743\187j&\131_\129\r>\139\7\n\255\t\166\162\137&6\18\218{\140:\140\172\20\233K\209\4\162\193G\169S\237X3#C\31@\r\128\181l\252s]\2\140\133\230{O\222]a |\20903\146\231\142M_c\180\231)\199\21}\16\150Ĺxگ\148t\211\6\213\209)\2271\204\18<@-\203Od`\165\1769%\147\241WіL{̈́N\160\7\14\155'\202O8\154\19_;pk\198\236\171ziQ.\1754\t\24\229\"|a\189\0113Qp|\8@?\\&\2؍\173\161$5\129\127\"z\0\218D\186\172b\8\242\250Nq\n%\199\229z۲\235~\131\168\211ӯ\7\6W\158G\186\183\6X\148솢gEy\143⦰\15\1睧\1340\23\227\184\251\139K!d\253g\242\190\6\254\30\171\25\29\196\30\134\239@\228>\22\198x\18IQ$\179\196\245$@K]d\215P\162\u{89}\199u\248AZ\210\127-'\184kK.\127\134jI/ed\229-l\26\t\162\190)\212U\191X\159\191\189\2296\164\161{d\142\244\201V\250\231\t_\229qZ\241\6\151(\211Q܇\174\30\19a\158\147\28+\245.I)\129\226\184%2bMjG\20֨\255\236_\145\192\1996\188V\247\161\209N~\8\161\167\158'\17\200\255\203%\239G\217wU\0129\136\1296Lj\255\26\176\180\208y_\174\252\172\226mG4O\183\25\234?T\241\138:\162\198{)\31TFKۆn\134.\169\242c\226_\150G\176\254\245\139\248\0\20/X\227\24=\"\231\145S\226\239~Ѥ\164\205c\145\14\182\167\171\213\235\233\242\155\3U\195(\219y\151\140);\26\227Y\245N\176\165\178GU\tlȒ0\155}<e\148\172j_Qf\238:\4O\135\11\18\127\163(l:@Ws;M\157\"\213\241Ȅ\224\244\193t(\134Z=\159\142\184\30\15fO\5X\2\147C\174\16645\209C\2394f\130c\31B\127\167\226\t\"\226\16\214ۋ\rr\173\231\216\rw\154\158\174D}\210\246Y`EƬO\127\u{5CE})Y\132\254#\24݀&\237U\215\26S\181\243a\213l7\30b\195\199R\22\1804\21\146\199q\166X\172\11VVg\188U\31\195\16\168\163\166\206\254\1311ܴ\6\246\189\221>\160\155\129ͻ\209k\164\145\242/@\8Tp\214\238\u{5CE}+\243݃\6\134_\140\214\8En\n\174EY\226>pр\2456\206-\220\7\130\29I\232U\179\3y\20v\r:\213\228\20\225\201\197G\248\191\213м\31\148~tc\2117ZY\0\149%\227\2\t\6/cO|\214\28\255\235F\30VB\235BS\172Ď\t\4\191D\249yo\130Z\147\218*i;t\218D\199@a\217\251_5\153\180\211\1\n\154RX\217\234T\23\184\254;H<\141\215\24)\157\11pd$\148\222Qz\221\231v3 q{\216\8\"s\218,\12\195_t\229s\220\15\7'C\156|$<Si\31z\193p\12\12\209\193\215\204=\17\236/]=/\15\192\235{&\158\231\167\231`y\207\247-\173\165]n\203\0+\175;M\143\162\17\140\160\199_\229(EXFT\179\136\24\225\240%\236F\149\28V\239\128G+=fYŋ\4ɑ\215\19z\173\228\2`5Ԛւd\184\2094\247teӢ-\164&\180\207ձ\166\184;B\198\1\136<\12\221|~\232{\228û\149xV\216\225\153\18\187\1939TB>m\11\255\155\241h\140\u{39E18}9\214\246|˿Q*\191\144M\247G\224Xy\161ew\15\11\158T\179\175ӹ\255ᄞ͛U\244dj\152E\215\245q\30 \236\202(\24\137\18\243G6K\144\t\184ud\200\229+\176\204>\136\214\127\18X\23\220\2080N#8\6X\140\14m\188\195\2\239<\236\251\128\251\190q\204\tleN\17\30\133\20\166\183\251ƽ \199\250Q\196\245nBF\203\252_\196\208˥G\159y\176\157\189Ykx\1353T\225ӳ\253N%q'o\137i\n\157\237/\129\216\213\196d\178\153\148\26\235\11A\245ي\180t\20\165\176\178\215e\152F\143{U0\6X\242e.\5Kd\144\192lj絞\143\2454!,XU\187\159\234\183/\234\143K_S:\177\227\232\236\180\226i'\165S]\205\243\201\247d+\18\228m\174\209q\217xX\170E\187\16vU\226\1T\15\19\156\29\230ND\202N\142\\\\\152\190\239\31_)\210{\192\132\t\194k\161\164\239\167$ \249f+\29\216\16\248)\142<xYg\129W\n\252dG=&Z\225\129\210\5\148\128\11Z\5\176\219s\188\1486Y\t\186g\138C<\229\177\3\200g+\136\143\206\19p\5\195\236[Jt]\127\246e\23\152\182\228\14:\198\208\230\221=\221uH66ɺ\174\146\230\157$\194\\%\245;ΓlY\134S\150\245!̈́pz\242\225M\227\5\178J\179\r}_\163<\30p\177kӫ\\p\133u3mA\172\204.*6\171\218\6\244\229'C\156\149\25\1989\176\231>h\168\18\2S\7\2245\2073\24yH\207\3\212ގ\145\187Y\r\177\194\31\156\200\11O\212\193\128\150\170l\148/M\246df\199і?\185\133&\236.\21\157xu\242H\170\242~\220\223'\250\206_zO\242_\186_\0\153@\254\168\164\198Ż\149\152\11\142\208J\15\17\187}Xy \182\27\18\29'\240\136xR\128\161TŎ\1571\159`8\t\1661\242\0G\236k%\135ڤ\140͗YV\224]\25045\180\176\255\233\0226\30\11E9?N\245:N9\214\222\5\188\136\249ah57˅iAYufB\31\247\0001߷e<\161\237y\144Fu\136\132\195G6r{\215GH\134\14\192\231\248\222\225\168O,\20\166\229\n!.#WE\u{84}\163xl\156\245\191\251\0059\180Lq'\7\175\198\11.\215\25\202\219\230\209\t\127b\231)$&*\240\254&6\127ѥ\186\140\190\255\180\251\1596\184a\156J\186\145RE\21\183!\151\252\255\133\23\127[\164\250\23u\154\178\150D\147Qzy\1\14\140\160\180A\224X>\141\190\189\240r\20P\154\173\147\229\240\145B\220\235+\207\255\177\u{EC0E}\212c\138\27\195߆\31mR\145l\130tq\229\187\"_\244o\16\184\30\163\217\204\26\173\187\159p{\215\1972\242\219k\26\214=Z\222\221\20\253\236\229\193݁_\28\215&\243>@ʦ\246\8\133\30\191\tv\135ƥ\211\21\5!\136\27[>\248W\245º\193\188\135\135^@`X\158$\182M\197\225\246\209]'\199\\`p\144\8x{\245\200F\188\169\14\147nn\128\25\224\203;f\252\241\228\238\n\229\223\0\189\205ڡ\180J\178\155W\132\27\234\156pk\202\16U\168\175\151\15\223\253G\130V+\169.3,\255\30\182B\196\0116\176\24\n<\204V\255/dОÏtF:\144\171:\156\2365>\231\\(\184\222[\172V\3'\22\172\235\252G\252\1876a\2277\239h\152\168\145\19\163\226\177\u{5EE}>\219$\189\253\147\27K\30eYH*\157^\244\231¡^\184!\232\t\232L蚮\216\202\203H\232\140&\1296\251\245\211\218z\188l1}\152\145/\238\3\160\"\24\223hX$Tq\148\228\174\226\131e\8t\246r\241\188\151$\245\191\249\23\168\174\28\251\148\168\250g\215\2514\146\21\194ְ\16z\214\208G\31\171\206SeIM\142\222b\01750Z\152\218݉z\\@Y\208U\188\144\27\11K@\2 \255\29\157\27\247f\1477\196*\241ݻ\136,C[X\18\196x7l\31*\132\196\212sfw*\191nF\254\217\23\150Č\n;GEe\223\238\183\208+\180\148W\\Hбj\197f\244\219X\2117Y\14D\228'g9\211ј\26\150\166\129\240#C\168\252'{\172\2095\234DFN%\171&|5i({:\140\217\27\215]\145\2389\187\220\243˗Z\u{E26F}.\190_\6D1\203\23bݺ\186\29\149$\159\3\181Z\27\227\r\213@\229\211g\209\253&\219\254\165Ӥrٓ۸\175\220Aч\236~\252.\2\253VH\2011\156\184\152\153\239\142\19\154|\204IH\193\209ۮ\198C\132C\215o\209͌\140\211cl\215\0u\1574\151}\228G\137>*p\173\250i$\181\136\17i\197i&f\129\194=\135J\130u\175O\195fh\22-Z[\161\179\231\216Xn\233:\245s\153\15\2541\1î\19Ξ\136c\197\239\15Vq\229\132ec(\158~ܫ\195\208Ż\213i\2361q\210\231D\169:\30\127\168/\11\253u\3Φ9O\20\183\214\232\243\174@Q\132\175Զ㟑\212G\154\222ۍ\221\4\238\175\6R\139\3\23\236\189,!@1\182\244\151\228Ex\231\210jM\2506T\199U\240+\211-\16\203\20\11>\252\143E\193\163\234`k\142U9\253\210}A׃\244\255S좎(M\227V\245V\249D|[L\1577\201p~\249\157g\166\184\197ԥ%\174ðm@\143\25\27ʨ\193\208`ٙ.ҋ\232Q@\8ڭ\247\242Ё\244 \1\253\142\196\223e\178^\224\182(4,P.\170\245\14q\156Ԥ\199\14\0012\226\"\1774\176v\152\173'^o\127k\207\233\18\183\174\140\212\229)\146\136l\168i9}\185{\213<A\141\188^\"\158\175 \219\243F\255\200Fx\u{E25C}}Tp4\8\211=ԃ\161\21hLuǨ\165\14\170\19\179\161\201Q\209\194Ίc\192.(\240\26\20r\204\246n\247\18\138+\231\165\213\245\166\243\131\253l(\167{\246\187Ζ\221'\225+\157Cػ\251}\216^\201\0\29A\127S\254\208\243\230\161]\215\238|3\247\231\11\141\\\191\135U\17#\179D\235\146\235$Y\181\t)n\1885\244\156-ga/\1431\235\1790\213-{\236\29\160Fa+\143)ګ\5\242\145\18\175\2427\217V\145\225\228#Z\218o`\29\137\163\207\246\249\213!2I\140\130\249\226Jm&\131\r\174L9\2368\217\219`\226ӻ\215\2347M\147\156\151>ׯ:\255/\136\\\145\20}\205M974\184\245\208\235\26\11Ǹ\3I\187\166\176#cܜ\173a\29\152\155\161\154\168\254\"\239\rC\2$\154\252M\204\232\202w\213[e\144\137$\29 \144\\\246W\248\179\245\139L\208\231N}??vrS\154\160G[\228\249\234ġ\129\190\182\200\8\0\232\175\224\242\174\220d\244\212\243\6c\179\156\196*\25\154\180\nO\236\n\152$\19\201b\192\225D\204$k@@\24\16\204\249\155\234\213\241T\160\235\219'_\27>\8\224\tlH\143\208U\207\245\245L\152ri(\2517N\186\180)\227\230\\\166\178\27o\142\168^\191ă\\\0\150\"N\29\208]\181\24\180\15x4vZ#-,\225*W]O\134\249\142\234Дȷ{\181\2\30\135\177r_?\20\144\129\rбM\152א\248\152\176\0246\211I\247L\134J\127\196K\146P\189\202\252\155\154\132\253\144\173\210\23:|\208\251\235\134 \208\235\213.\155\127\227\160U\133L\141\153ν\19\163\239\136\246\234\206\27\139u\161\241g\150K\176\169J6n\183\u{8A}\240\204\195e[\163dWk\196\243\213\241o\221Bf\168"), tbl27, 349)()
												end
											end

											fn29 = nil

											fn29 = function(arg, arg2)
												if typeof(arg) == "RBXScriptConnection" then
													arg:Disconnect()
												elseif type(arg) == "thread" and coroutine.status(arg) ~= "dead" then
													task.cancel(arg)
												else
													local v106 = v85[145]

													if type(arg) == v106 then
														arg2 = arg2 or {}
														if arg2[arg] then
															return
														end
														arg2[arg] = true

														for _, v107 in arg, nil, nil do
															fn29(v107, arg2)
														end
													end
												end
											end

											fn30 = function(arg, ...)
												if type(arg) == "function" then
													local v106 = getthreadidentity()
													local v107 = pcall
													local v108 = table.pack(...)
													v107(arg, table.unpack(v108, 1, v108.n))
													setthreadidentity(v106)
												end
											end

											do
												local function fn50(arg)
													local tbl27 = arg or {}

													for k, v106 in tbl27, nil, nil do
														pcall(function()
															for k2, v107 in v106, nil, nil do
																k[k2] = v107
															end
														end)
													end
												end

												genv = getgenv()
												scriptKey = script_key or genv.script_key
												local flyteBBState2 = genv.FlyteBB_State
												local flyteBB = genv.FlyteBB

												if type(flyteBBState2) == "table" then
													fn30(flyteBBState2.Unload)
												end

												if type(flyteBB) == "table" then
													fn30(flyteBB.Destroy, flyteBB)
												end

												if type(flyteBBState2) == "table" and not flyteBBState2.Unloaded then
													do
														flyteBBState2.Unloading = true
														flyteBBState2.Loaded = v85[101]
														fn30(flyteBBState2.StreakRestore or flyteBBState2.Streak_Restore)
														fn30(flyteBBState2.AntiLagRestore)
														fn30(flyteBBState2.NoRenderRestore)
														fn50(flyteBBState2.AntiLagCache)
														fn50(flyteBBState2.RenderCache)
														flyteBBState2.AntiLagCache = nil
														flyteBBState2.RenderCache = nil
														fn30(fn29, flyteBBState2)

														do
															local espLabels = flyteBBState2.ESPLabels or flyteBBState2.ESP_Labels or flyteBBState2.Esp_Labels or {}

															for _, v106 in espLabels, nil, nil do
																if v106.Billboard then
																	pcall(function()
																		v106.Billboard:Destroy()
																	end)
																end
															end
														end
													end

													for _, v106 in {
														"KeybindPanel",
														"StatsPanel",
														v85[107],
														"TriggerPanel",
														v85[199],
														"Spam_Panel",
														"Trigger_Panel",
													}, nil, nil do
														do
															local v107 = flyteBBState2[v106]
															local v108 = v85[145]

															if type(v107) == v108 and typeof(v107.Gui) == "Instance" then
																pcall(function()
																	v107.Gui:Destroy()
																end)
															end
														end
													end

													do
														local extraStats = flyteBBState2.ExtraStats or {}

														for _, v106 in extraStats, nil, nil do
															local flag18 = type(v106) == "table"
															local flag19

															if flag18 then
																local v107 = v85[165]
																flag19 = typeof(v106.Gui) == v107
															else
																flag19 = flag18
															end

															if flag19 then
																pcall(function()
																	v106.Gui:Destroy()
																end)
															end
														end
													end

													flyteBBState2.Unloaded = true
												end

												if type(flyteBB) == "table" and typeof(flyteBB.screenGuiYay) == "Instance" then
													pcall(function()
														flyteBB.screenGuiYay:Destroy()
													end)
												end

												if genv.FlyteBB == flyteBB then
													genv.FlyteBB = nil
												end

												if genv.FlyteBB_State == flyteBBState2 then
													genv.FlyteBB_State = nil
												end
											end
										end

										do
											local v106

											do
												local fn50 = cloneref or function(arg)
													return arg
												end

												v86 = fn50(game:GetService("TweenService"))
												v87 = fn50(game:GetService("UserInputService"))
												v88 = fn50(game:GetService("RunService"))
												v89 = fn50(game:GetService(v85[173]))
												v105 = fn50(game:GetService("TextService"))
												v90 = fn50(game:GetService("GuiService"))
												v91 = fn50(game:GetService("HttpService"))
												v92 = fn50(game:GetService("ContentProvider"))
												v93 = fn50(game:GetService("ReplicatedStorage"))
												v94 = fn50(game:GetService(v85[93]))
												v106 = fn50(game:GetService(v85[129]))
												v95 = fn50(game:GetService("TeleportService"))
											end

											do
												local function fn50(arg)
													for _, v107 in arg:GetChildren() do
														if v107.Name == "v0rtexdBestUIEver" and v107:IsA("ScreenGui") then
															v107:Destroy()
														end
													end
												end

												if gethui then
													local ok, result = pcall(gethui)

													if ok then
														fn30(fn50, result)
													end
												end

												fn30(fn50, v94)
											end

											local dataPing = nil
											v96 = nil
											fn42 = function()if not  dataPing or not  dataPing .Parent then local F= v106 :FindFirstChild("Network");local P=F and(F:FindFirstChild("ServerStatsItem")); dataPing =P and(P:FindFirstChild("Data Ping"));end;if  dataPing then local F,P=pcall( dataPing .GetValue, dataPing );local x=F and type(P)=="number"and P>0 and P==P and P<math.huge;if x then  v96 =P;end;end;end
										end
									end

									do
										do
											do
												local v106 = assert
												local flag18 = type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function" and type(makefolder) == "function" and type(isfolder) == "function"

												if flag18 then
													local v107 = v85[154]
													flag18 = type(listfiles) == v107
												end

												if flag18 then
													local v107 = v85[154]
													flag18 = type(delfile) == v107
												end

												v106(flag18, "filesystem is not supported")
											end

											flyteBBState = nil
											v97 = nil
											fn43 = nil
											tbl19 = {}
											tbl20 = nil

											tbl21 = {
												v85[111],
												"Sliders",
												v85[126],
												"Dropdowns",
												"Textboxes",
												"Keybinds",
												"UnlockAll",
											}

											do
												local tbl27 = {
													v85[141],
													v85[142],
													"Cooldown_Protection",
													"Parry_On_Dribble",
													v85[84],
													"Anti_Blindness",
													"Anti_Phantom",
													"Anti_Curve",
													"Dynamic_Spam",
													"Manual_Spam",
													"Auto_Preclick",
													v85[12],
													"Auto_Parry",
													"Auto_Spam",
													v85[140],
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
													v85[37],
													"Ball_Stats",
													"Unlock_All",
													"Custom_Streak",
													"Hit_Freeze",
													v85[88],
													"Anti_AFK",
													"Anim_Fix",
													"Config_List",
													v85[103],
												}

												fn31 = function(arg)
													local v106 = v85[127]
													if type(arg) ~= v106 then
														return arg
													end

													for _, v107 in tbl27, nil, nil do
														arg = arg:gsub(v107, v107 == "Anti_Curve" and "Anticurve" or v107:gsub("_", ""))
													end

													return arg
												end
											end
										end

										do
											fn32 = function(arg)
												for _, v106 in tbl21, nil, nil do
													local v107 = arg[v106]

													if type(v107) == "table" then
														local tbl27 = {}

														for k in v107, nil, nil do
															local v108 = fn31(k)

															if v108 ~= k then
																tbl27[k] = v108
															end
														end

														for k, v108 in tbl27, nil, nil do
															if v107[v108] == nil then
																v107[v108] = v107[k]
															end

															v107[k] = nil
														end
													end
												end

												local toggles = arg.Toggles

												if type(toggles) == "table" then
													for k, v106 in {
														Claim_Daily_Gifts = "Claim_Daily_Rewards",
														Claim_Welcome_Rewards = "Claim_Daily_Rewards",
														Claim_Playtime_Gifts = "Claim_Playtime_Rewards",
													}, nil, nil do
														for _, v107 in { "", ":notify" }, nil, nil do
															if toggles[k .. v107] ~= nil then
																toggles[v106 .. v107] = toggles[v106 .. v107] == true or toggles[k .. v107] == true
																toggles[k .. v107] = nil
															end
														end
													end
												end

												return arg
											end

											do
												local tbl27 = {
													AutoParry_Type = true,
													AutoSpam_Type = v85[200],
													ManualSpam_Type = true,
													Triggerbot_Type = true,
													Fury_Parry_Method = v85[200],
												}

												tbl11 = {
													Writing = {},
													Pending = {},
													Read = function(arg)
														if not isfile(arg) then
															return
														end
														local v106 = readfile(arg)
														local ok, result = pcall(v91.JSONDecode, v91, v106)
														if ok and type(result) == "table" then
															return result
														end
													end,
													Write = function(arg, arg2)
														tbl11.Pending[arg] = v91:JSONEncode(arg2)
														if tbl11.Writing[arg] then
															return
														end
														tbl11.Writing[arg] = v85[200]

														while true do
															local v106 = tbl11.Pending[arg]
															tbl11.Pending[arg] = nil
															local ok, result = pcall(writefile, arg, v106)

															if not ok then
																tbl11.Writing[arg] = nil
																error(result)
															end

															if tbl11.Pending[arg] ~= nil then
																continue
															end
															break
														end

														tbl11.Writing[arg] = nil
													end,
												}

												fn33 = nil

												fn33 = function(arg)
													if type(arg) ~= "table" then
														return arg
													end
													local tbl28 = {}

													for k, v106 in arg, nil, nil do
														tbl28[k] = fn33(v106)
													end

													return tbl28
												end

												fn34 = function()
													if not flyteBBState or not flyteBBState.Loaded or flyteBBState.Unloading or v97 and v97.Applying then
														return
													end

													if not isfolder("Flyte") then
														makefolder("Flyte")
													end

													tbl11.Write("Flyte/Flyte.json", tbl19)

													if v97 and v97.Active and v97.Save then
														v97:Save(v97.Active, false)
													end
												end

												if isfile("Flyte/Flyte.json.backup") then
													pcall(delfile, "Flyte/Flyte.json.backup")
												end

												tbl19 = tbl11.Read("Flyte/Flyte.json") or tbl19

												for _, v106 in tbl21, nil, nil do
													local v107 = v85[145]
													tbl19[v106] = type(tbl19[v106]) == v107 and tbl19[v106] or {}
												end

												fn32(tbl19)

												for _, v106 in { "ManualSpam", "manual_spam_enabled" }, nil, nil do
													tbl19.Toggles[v106] = nil
												end

												fn35 = function(arg)
													for k, v106 in arg, nil, nil do
														local flag18 = v106 == "Keypress"

														if not flag18 then
															flag18 = tbl27[k] and v106 ~= v85[90] and v106 ~= v85[7] and v106 ~= v85[191]
														end

														if flag18 then
															arg[k] = "VIM"
														end
													end
												end
											end
										end

										fn35(tbl19.Dropdowns)

										if next(tbl19.Keybinds) == nil and isfile("FlyteBB_Keybinds.json") then
											local json = tbl11.Read("FlyteBB_Keybinds.json")
											local v106 = v85[145]

											if type(json) == v106 then
												tbl19.Keybinds = json
											end
										end

										do
											local font = Font.new
											local tbl27 = {}

											tbl22 = { new = function(arg, arg2, arg3)
												local v106 = v85[188]
												local str5 = tostring(arg) .. v106 .. tostring(arg2) .. "_" .. tostring(arg3)
												local v107 = tbl27[str5]

												if not v107 then
													v107 = font(arg, arg2, arg3)
													tbl27[str5] = v107
												end

												return v107
											end }
										end
									end

									do
										local keybinds, tbl27, tbl28, handlers, v106, v107, v108, fn50

										do
											keybinds = tbl19.Keybinds
											tbl27 = {}
											tbl28 = {}
											handlers = {}

											do
												local order = 0
												v106 = nil
												v107 = nil
												v108 = nil

												local function fn51(arg)
													if arg == "MouseButton3" then
														return Enum.UserInputType.MouseButton3
													end
													local v109 = v85[127]
													return type(arg) == v109 and Enum.KeyCode[arg] or Enum.KeyCode.Unknown
												end

												fn50 = function(arg)
													if arg.UserInputType == Enum.UserInputType.Keyboard then
														return arg.KeyCode
													end

													if arg.UserInputType == Enum.UserInputType.MouseButton3 then
														return arg.UserInputType
													end
												end

												tbl12 = {
													Resolve = function(arg)
														return fn51(arg)
													end,
													Display = function(arg)
														return arg == Enum.UserInputType.MouseButton3 and "M3" or arg.Name
													end,
													Get = function(arg)
														local v109 = keybinds[arg]
														return fn51(type(v109) == "table" and v109.Key or v109)
													end,
													Set = function(arg, arg2)
														if not arg2 or arg2 == Enum.KeyCode.Unknown then
															if v85[63] <= n24 then
																while true do
																end
															else
																keybinds[arg] = nil
															end
														else
															keybinds[arg] = { Key = arg2.Name, Mode = tbl12.GetMode(arg) }
														end

														fn34()

														if handlers[arg] then
															handlers[arg](tbl12.Get(arg))
														end

														if flyteBBState and flyteBBState.RefreshKeybinds then
															task.defer(flyteBBState.RefreshKeybinds)
														end
													end,
													GetMode = function(arg)
														local v109 = keybinds[arg]
														local v110 = v85[145]
														if type(v109) == v110 and (v109.Mode == v85[4] or v109.Mode == "Hold") then
															return v109.Mode
														end
														return v85[4]
													end,
													SetMode = function(arg, arg2)
														local v109 = tbl12.Get(arg)

														if v109 == Enum.KeyCode.Unknown then
															keybinds[arg] = { Mode = arg2 }
														else
															keybinds[arg] = { Key = v109.Name, Mode = arg2 }
														end

														fn34()

														if flyteBBState and flyteBBState.RefreshKeybinds then
															task.defer(flyteBBState.RefreshKeybinds)
														end
													end,
													SetMeta = function(arg, arg2)
														local v109 = tbl28[arg]

														if v109 and v109.Order then
															arg2.Order = v109.Order
														else
															order += 1
															arg2.Order = order
														end

														tbl28[arg] = arg2

														if flyteBBState and flyteBBState.RefreshKeybinds then
															task.defer(flyteBBState.RefreshKeybinds)
														end
													end,
													RegisterDisplay = function(arg, arg2)
														handlers[arg] = arg2
													end,
													GetAll = function()
														local tbl29 = {}
														local tbl30 = {}

														for _, v109 in pairs(tbl28) do
															if not v109.Parent then
																tbl30[string.lower(v109.Name or "")] = v109.Order or 9999
															end
														end

														for k, v109 in pairs(tbl28) do
															local v110 = tbl12.Get(k)

															if v110 ~= Enum.KeyCode.Unknown then
																local v111 = nil

																if v109.GetState then
																	v111 = v109.GetState()
																end

																table.insert(tbl29, {
																	Id = k,
																	Name = v109.Name or k,
																	Key = tbl12.Display(v110),
																	Mode = v109.DisplayMode or tbl12.GetMode(k),
																	Group = v109.Group,
																	Parent = v109.Parent,
																	Order = v109.Order or 9999,
																	ParentOrder = v109.Parent and tbl30[string.lower(v109.Parent)] or v109.Order or 9999,
																	Active = v111,
																})
															end
														end

														table.sort(tbl29, function(arg, arg2)
															if arg.ParentOrder ~= arg2.ParentOrder then
																return arg.ParentOrder < arg2.ParentOrder
															end

															if arg.Parent ~= nil ~= arg2.Parent ~= nil then
																return arg.Parent == nil
															end

															if arg.Parent and arg2.Parent and arg.Active ~= arg2.Active then
																return arg.Active == true
															end
															return arg.Order < arg2.Order
														end)

														return tbl29
													end,
													FindDuplicate = function(arg, arg2, arg3)
														if not arg or not arg3 or arg3 == Enum.KeyCode.Unknown then
															return nil
														end
														local name = arg3.Name

														for k, v109 in pairs(tbl28) do
															if k ~= arg2 and v109.Group == arg then
																local v110 = keybinds[k]
																if (type(v110) == "table" and v110.Key or v110) == name then
																	return v109.Name
																end
															end
														end

														return nil
													end,
													Register = function(arg, arg2)
														tbl27[arg] = arg2
													end,
													BeginListen = function(arg, arg2, arg3)
														v106 = arg
														v107 = arg2
														v108 = arg3
													end,
													IsListening = function()
														return v106 ~= nil
													end,
												}
											end
										end

										local connection = v87.InputBegan:Connect(function(input, gameProcessed)
											local unknown = fn50(input)
											if not unknown then
												return
											end

											if v106 then
												local v109 = v106
												local v110 = v107
												local v111 = v108
												v106 = nil
												v107 = nil
												v108 = nil
												if unknown == Enum.KeyCode.Unknown then
													return
												end

												if unknown == Enum.KeyCode.Escape then
													if v110 then
														v110(tbl12.Get(v109))
													end

													return
												end

												if unknown == Enum.KeyCode.Backspace then
													unknown = Enum.KeyCode.Unknown
												end

												if v111 and unknown ~= Enum.KeyCode.Unknown and v111(unknown) == false then
													if v110 then
														v110(tbl12.Get(v109))
													end

													return
												end

												tbl12.Set(v109, unknown)

												if v110 then
													v110(unknown)
												end

												return
											end

											if gameProcessed then
												return
											end
											local name = unknown.Name

											for k, v109 in pairs(tbl27) do
												local v110 = keybinds[k]

												if (type(v110) == "table" and v110.Key or v110) == name then
													task.spawn(v109, true, tbl12.GetMode(k), unknown)
												end
											end
										end)

										local connection2 = v87.InputEnded:Connect(function(input, gameProcessed)
											if gameProcessed then
												return
											end
											local v109 = fn50(input)
											if not v109 then
												return
											end
											local name = v109.Name

											for k, v110 in pairs(tbl27) do
												local v111 = keybinds[k]

												if (type(v111) == "table" and v111.Key or v111) == name and tbl12.GetMode(k) == "Hold" then
													task.spawn(v110, false, v85[99], v109)
												end
											end
										end)

										tbl12.Destroy = function()
											if connection then
												connection:Disconnect()
												connection = nil
											end

											if connection2 then
												connection2:Disconnect()
												connection2 = nil
											end

											tbl27 = {}
											tbl28 = {}
											handlers = {}
											v106 = nil
											v107 = nil
											v108 = nil
										end
									end
								end

								do
									do
										do
											setfpscap(9999)
											index = {}
											index.__index = index

											colors = {
												Primary = Color3.fromRGB(12, v85[49], 16),
												Secondary = Color3.fromRGB(18, 18, v85[19]),
												Tertiary = Color3.fromRGB(26, v85[190], 34),
												Surface = Color3.fromRGB(32, 32, v85[79]),
												Element = Color3.fromRGB(42, 42, v85[89]),
												ElementHover = Color3.fromRGB(55, 55, 70),
												Border = Color3.fromRGB(68, 68, 88),
												BorderSoft = Color3.fromRGB(v85[195], 45, 58),
												Accent = Color3.fromRGB(v85[67], 90, v85[71]),
												AccentDark = Color3.fromRGB(v85[189], v85[6], 210),
												AccentLight = Color3.fromRGB(v85[75], 165, 255),
												Text = Color3.fromRGB(240, 240, 245),
												SubText = Color3.fromRGB(155, 155, v85[168]),
												TextHover = Color3.fromRGB(225, 225, 240),
												Muted = Color3.fromRGB(105, 105, v85[120]),
												White = Color3.new(1, 1, 1),
												Black = Color3.new(),
												Success = Color3.fromRGB(126, 238, 174),
												Warning = Color3.fromRGB(255, 197, 117),
												Error = Color3.fromRGB(255, 116, 145),
											}

											index.Colors = colors

											if not game:IsLoaded() then
												game.Loaded:Wait()
											end

											while not v89.LocalPlayer do
												task.wait()
											end

											localPlayer = v89.LocalPlayer
											touchEnabled = v87.TouchEnabled

											fn45 = function(arg, arg2)
												local instance = Instance.new(arg)

												for k, v106 in pairs(arg2) do
													if k ~= "Parent" then
														instance[k] = v106
													end
												end

												if arg2.Parent then
													instance.Parent = arg2.Parent
												end

												return instance
											end

											v98 = fn45

											fn36 = function(arg)
												if gethui then
													local ok, parent = pcall(gethui)

													if ok and typeof(parent) == "Instance" then
														if pcall(function()
															arg.Parent = parent
														end) then
															return arg
														end
													end
												end

												local protectGui = syn and syn.protect_gui

												if protectGui then
													pcall(protectGui, arg)
												end

												if protectgui and protectgui ~= protectGui then
													pcall(protectgui, arg)
												end

												arg.Parent = v94
												return arg
											end

											fn46 = function(arg, arg2, arg3)
												if arg3 then
													return nil
												end
												return arg[arg2]
											end

											do
												local tbl27 = {}

												fn37 = function(arg, arg2, arg3, arg4, arg5)
													arg3 = arg3 or 0.5
													arg4 = arg4 or Enum.EasingStyle.Exponential
													local out = arg5 or Enum.EasingDirection.Out
													local str5 = string.format("%f_%d_%d", arg3, arg4.Value, out.Value)
													local tweenInfo = tbl27[str5]

													if not tweenInfo then
														tweenInfo = TweenInfo.new(arg3, arg4, out)
														tbl27[str5] = tweenInfo
													end

													local tween = v86:Create(arg, tweenInfo, arg2)
													tween:Play()
													return tween
												end
											end
										end

										do
											local fn50

											do
												local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
												tbl26 = {}

												fn44 = function(arg)
													tbl26[arg] = true
													return arg
												end

												fn48 = function(arg)
													if arg then
														arg:Disconnect()
														tbl26[arg] = nil
													end
												end

												v104 = nil

												fn44(v87.InputChanged:Connect(function(input)
													if v104 then
														v104(input)
													end
												end))

												fn50 = function(arg, arg2)
													local flag18 = false
													local v106 = nil
													local position = nil
													local position2 = nil
													local tween = nil
													local v107 = arg2 or arg

													local function fn51(arg3)
														local n32 = arg3.Position - position
														local udim2 = UDim2.new(position2.X.Scale, position2.X.Offset + n32.X, position2.Y.Scale, position2.Y.Offset + n32.Y)

														if tween then
															tween:Cancel()
														end

														tween = v86:Create(arg, tweenInfo, { Position = udim2 })
														tween:Play()
													end

													local function fn52(arg3)
														if arg3 == v106 and flag18 then
															fn51(arg3)
														end
													end

													v107.InputBegan:Connect(function(input)
														if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
															flag18 = true
															position = input.Position
															position2 = arg.Position

															input.Changed:Connect(function()
																if input.UserInputState == Enum.UserInputState.End then
																	flag18 = false

																	if v104 == fn52 then
																		v104 = nil
																	end
																end
															end)

															v104 = fn52
														end
													end)

													v107.InputChanged:Connect(function(input)
														if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
															v106 = input
														end
													end)
												end
											end

											v99 = fn50

											do
												local function fn51(arg)
													local ok, result = pcall(v89.GetUserThumbnailAsync, v89, arg, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
													if ok then
														return result
													end
													return "rbxassetid://135756197673563"
												end

												fn47 = function(arg, arg2, arg3)
													return v105:GetTextSize(arg, arg2, arg3 or Enum.Font.GothamSemibold, Vector2.new(math.huge, math.huge)).X
												end

												fn49 = function(arg, arg2, arg3, arg4)
													if fn47(arg, arg3, arg4) <= arg2 then
														return arg
													end
													local n32 = v85[18]
													local n33 = #arg
													local str5 = ""

													while n32 <= n33 do
														local n34 = math.floor((n32 + n33) / 2)
														local str6 = arg:sub(v85[18], n34) .. "..."

														if fn47(str6, arg3, arg4) <= arg2 then
															n32 = n34 + 1
															str5 = str6
														else
															n33 = n34 - 1
														end
													end

													return str5 ~= "" and str5 or "..."
												end

												index.new = function(config)
													local obj2 = setmetatable({}, index)
													obj2.config = config or {}
													obj2.config.Name = obj2.config.Name or "o11 vision"
													obj2.config.Colors = obj2.config.Colors or colors
													obj2.config.AccentColor = obj2.config.AccentColor or obj2.config.Colors.Accent
													obj2.config.BackgroundColor = obj2.config.BackgroundColor or obj2.config.Colors.Primary
													obj2.config.SecondaryColor = obj2.config.SecondaryColor or obj2.config.Colors.Secondary
													obj2.config.TextColor = obj2.config.TextColor or obj2.config.Colors.Text
													obj2.config.SubTextColor = obj2.config.SubTextColor or obj2.config.Colors.SubText
													obj2.sectionsAreAwesome = {}
													obj2.tabsGoWoosh = {}
													obj2.currentTabYay = nil
													obj2.notificationsAreCool = {}
													obj2.isToggledOn = true
													obj2.dropdownHolderRef = nil
													obj2.dropdownHolderScale = nil
													obj2.sectionRefreshers = {}
													obj2.openDropdowns = {}
													obj2.dropdownFrames = {}
													obj2.detachedDropdowns = {}
													obj2:CreateUIBecauseWeNeedIt()
													return obj2
												end

												index.CreateUIBecauseWeNeedIt = function(arg)
													arg.screenGuiYay = fn45("ScreenGui", { Name = "v0rtexdBestUIEver", ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false })
													fn36(arg.screenGuiYay)

													arg.dropdownHolderRef = fn45(v85[170], {
														Name = "DropdownHolderBecauseDropdownsNeedHomes",
														BackgroundTransparency = 1,
														Size = UDim2.new(v85[18], v85[33], 1, 0),
														ZIndex = v85[184],
														Parent = arg.screenGuiYay,
													})

													arg.dropdownHolderScale = fn45("UIScale", { Name = v85[180], Scale = 1, Parent = arg.dropdownHolderRef })
													arg:CreateWatermarkBecauseWeCool()
													arg:CreateMainFrameYay()
													arg:UpdateLayoutScale()

													arg.screenGuiYay:GetPropertyChangedSignal(v85[32]):Connect(function()
														arg:UpdateLayoutScale()
													end)

													arg:CreateNotificationHolderForCoolNotifs()

													task.delay(0.1, function()
														arg:SetVisible(true)
													end)

													local settingsMenuSettingsToggleKeybin = tbl19.Keybinds and tbl19.Keybinds["settings:menu settings:toggle keybind"]
													arg.toggleVisibilityKey = settingsMenuSettingsToggleKeybin and Enum.KeyCode[settingsMenuSettingsToggleKeybin] or Enum.KeyCode.RightAlt
													arg.toggleVisibilityKeyName = arg.toggleVisibilityKey == Enum.KeyCode.Unknown and "None" or arg.toggleVisibilityKey.Name

													fn44(v87.InputBegan:Connect(function(input, gameProcessed)
														local v106 = v85[25]

														if n28(897) < v106 then
															if gameProcessed then
																return
															end
															local lastKeybindChanged = arg.lastKeybindChanged

															if lastKeybindChanged then
																local lastKeybindChanged2 = arg.lastKeybindChanged
																lastKeybindChanged = tick() - lastKeybindChanged2 < 0.1
															end

															if lastKeybindChanged then
																return
															end

															if tbl12.IsListening and tbl12.IsListening() then
																return
															end

															if input.KeyCode == arg.toggleVisibilityKey then
																arg:SetVisible(not arg.isToggledOn)
															end

															return
														end

														while true do
														end
													end))

													if touchEnabled then
														local v106 = fn45(v85[39], {
															Name = "MobileToggle",
															Size = UDim2.new(0, 46, 0, 46),
															Position = UDim2.new(0, 38, 1, -v85[80]),
															AnchorPoint = Vector2.new(0.5, 0.5),
															BackgroundColor3 = Color3.fromRGB(24, 24, 28),
															BackgroundTransparency = 0.2,
															Text = "",
															AutoButtonColor = false,
															ClipsDescendants = false,
															Visible = true,
															ZIndex = 99999,
															Parent = arg.screenGuiYay,
														})

														arg.mobileToggleScale = fn45(v85[16], { Scale = (tbl20.MobileButtonScale or 100) / v85[158], Parent = v106 })
														fn45(v85[137], { CornerRadius = UDim.new(1, 0), Parent = v106 })

														local UIStroke = fn45("UIStroke", {
															Thickness = 1.5,
															Color = colors.Accent,
															ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
															Transparency = 0.3,
															Parent = v106,
														})

														local ImageLabel = fn45("ImageLabel", {
															Name = "OpenIcon",
															Size = UDim2.new(0, v85[108], 0, 20),
															Position = UDim2.new(v85[81], 0, 0.5, 0),
															AnchorPoint = Vector2.new(0.5, 0.5),
															BackgroundTransparency = 1,
															Image = "rbxassetid://136585806825349",
															ImageColor3 = colors.Accent,
															ZIndex = 100000,
															Parent = v106,
														})

														local UIScale = fn45("UIScale", { Scale = v85[18], Parent = ImageLabel })

														local ImageLabel2 = fn45("ImageLabel", {
															Name = "ClosedIcon",
															Size = UDim2.new(v85[33], 20, v85[33], 20),
															Position = UDim2.new(v85[81], v85[33], v85[81], v85[33]),
															AnchorPoint = Vector2.new(0.5, 0.5),
															BackgroundTransparency = 1,
															Image = "rbxassetid://127131703650472",
															ImageColor3 = colors.Accent,
															ImageTransparency = 1,
															Rotation = 180,
															Visible = false,
															ZIndex = v85[15],
															Parent = v106,
														})

														local UIScale2 = fn45("UIScale", { Scale = v85[33], Parent = ImageLabel2 })

														local function fn52(arg2)
															if arg.isToggledOn then
																ImageLabel.Visible = true

																if arg2 then
																	fn37(UIStroke, { Color = colors.Accent }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(ImageLabel, { ImageTransparency = 0, Rotation = 0 }, v85[26], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(UIScale, { Scale = v85[18] }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(ImageLabel2, { ImageTransparency = 1, Rotation = 180 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(UIScale2, { Scale = 0 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																else
																	UIStroke.Color = colors.Accent
																	ImageLabel.ImageTransparency = 0
																	ImageLabel.Rotation = v85[33]
																	UIScale.Scale = v85[18]
																	ImageLabel2.ImageTransparency = 1
																	ImageLabel2.Rotation = 180
																	UIScale2.Scale = v85[33]
																	ImageLabel2.Visible = v85[101]
																end
															else
																ImageLabel2.Visible = v85[200]

																if arg2 then
																	fn37(UIStroke, { Color = Color3.fromRGB(45, 47, 55) }, v85[26], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(ImageLabel, { ImageTransparency = 1, Rotation = 180 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

																	fn37(UIScale, { Scale = v85[33] }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out).Completed:Connect(function()
																		if not arg.isToggledOn then
																			ImageLabel.Visible = v85[101]
																		end
																	end)

																	fn37(ImageLabel2, { ImageTransparency = 0, Rotation = v85[33] }, v85[100], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	fn37(UIScale2, { Scale = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																else
																	UIStroke.Color = Color3.fromRGB(45, 47, 55)
																	ImageLabel.ImageTransparency = 1
																	ImageLabel.Rotation = v85[85]
																	UIScale.Scale = 0
																	ImageLabel.Visible = false
																	ImageLabel2.ImageTransparency = 0
																	ImageLabel2.Rotation = 0
																	UIScale2.Scale = v85[18]
																end
															end
														end

														v106.MouseEnter:Connect(function()
															fn37(v106, { BackgroundColor3 = Color3.fromRGB(30, 30, v85[59]) }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
															fn37(UIStroke, { Transparency = v85[22] }, v85[110], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
														end)

														v106.MouseLeave:Connect(function()
															fn37(v106, { BackgroundColor3 = Color3.fromRGB(24, v85[19], 28) }, v85[110], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
															fn37(UIStroke, { Transparency = 0.3 }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
														end)

														local flag18 = v85[101]
														local position = nil
														local position2 = nil
														local flag19 = false
														local v107 = nil

														v106.InputBegan:Connect(function(input)
															if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																flag18 = v85[200]
																flag19 = false
																position = input.Position
																position2 = v106.Position

																input.Changed:Connect(function()
																	if input.UserInputState == Enum.UserInputState.End then
																		flag18 = false
																	end
																end)
															end
														end)

														v106.InputChanged:Connect(function(input)
															if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
																v107 = input
															end
														end)

														fn44(v87.InputChanged:Connect(function(input)
															if input == v107 and flag18 then
																local n32 = input.Position - position

																if n32.Magnitude > 12 then
																	flag19 = true
																end

																local absoluteSize = arg.screenGuiYay.AbsoluteSize

																if absoluteSize.X > 0 and absoluteSize.Y > 0 then
																	local absoluteSize2 = v106.AbsoluteSize
																	local n33 = absoluteSize2.X > v85[33] and absoluteSize2.X / 2 or 23
																	local n34 = absoluteSize2.Y > 0 and absoluteSize2.Y / 2 or 23
																	local n35 = math.clamp(position2.X.Scale * absoluteSize.X + position2.X.Offset + n32.X, n33, absoluteSize.X - n33)
																	local n36 = math.clamp(position2.Y.Scale * absoluteSize.Y + position2.Y.Offset + n32.Y, n34, absoluteSize.Y - n34)
																	v106.Position = UDim2.new(0, n35, v85[33], n36)
																end
															end
														end))

														v106.InputEnded:Connect(function(input)
															if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																if flag18 then
																	flag18 = false
																end

																if not flag19 then
																	fn37(v106, { Size = UDim2.new(v85[33], 42, 0, 42) }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

																	task.delay(0.1, function()
																		fn37(v106, { Size = UDim2.new(0, 46, v85[33], v85[43]) }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
																	end)

																	arg:SetVisible(not arg.isToggledOn)
																	fn52(v85[200])
																end
															end
														end)

														local setVisible = arg.SetVisible

														arg.SetVisible = function(arg2, arg3)
															setVisible(arg2, arg3)
															fn52(v85[200])
														end

														fn52(false)
													end
												end

												index.GetScreenScale = function(arg)
													if not arg.screenGuiYay then
														return 1
													end
													local absoluteSize = arg.screenGuiYay.AbsoluteSize
													if absoluteSize.X == 0 or absoluteSize.Y == 0 then
														return v85[18]
													end
													return math.clamp(math.min((absoluteSize.X - 40) / 753, (absoluteSize.Y - 40) / 493), 0.1, v85[18]) * (tbl20.MenuScale or 100) / 100
												end

												index.UpdateLayoutScale = function(arg)
													if not arg.mainFrameYay then
														return
													end
													local mainFrameUIScale = arg.mainFrameYay:FindFirstChild("MainFrameUIScale") or arg.mainFrameYay:FindFirstChildOfClass("UIScale")
													if not mainFrameUIScale then
														return
													end
													local screenScale = arg:GetScreenScale()

													if arg.mobileToggleScale then
														fn37(arg.mobileToggleScale, { Scale = (tbl20.MobileButtonScale or v85[158]) / 100 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													end

													if arg.dropdownHolderScale then
														local scale = arg.dropdownHolderScale.Scale

														if arg.detachedDropdowns and scale > 0 and scale ~= screenScale then
															local tbl27 = {}

															for k in pairs(arg.detachedDropdowns) do
																if k.detached and k.buttonFrame then
																	tbl27[k] = k.buttonFrame.AbsolutePosition
																end
															end

															arg.dropdownHolderScale.Scale = screenScale

															for k, v106 in pairs(tbl27) do
																if k.buttonFrame then
																	k.buttonFrame.Position = UDim2.fromOffset(v106.X / screenScale, v106.Y / screenScale)
																end
															end
														else
															arg.dropdownHolderScale.Scale = screenScale
														end
													end

													if arg.isToggledOn then
														fn37(mainFrameUIScale, { Scale = screenScale }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													else
														mainFrameUIScale.Scale = v85[198] * screenScale
													end
												end

												index.SetVisible = function(arg, isToggledOn)
													arg.isToggledOn = isToggledOn
													local screenScale = arg:GetScreenScale()

													if isToggledOn then
														arg.mainFrameYay.GroupTransparency = 1

														if arg.dropdownHolderRef then
															arg.dropdownHolderRef.Visible = true
														end

														arg.watermarkFrame.GroupTransparency = 1
														arg.mainFrameYay.Visible = true
														arg.watermarkFrame.Visible = true
														local v106 = arg.mainFrameYay:FindFirstChildOfClass(v85[16])

														if v106 then
															v106.Scale = 0.92 * screenScale
														end

														fn37(arg.mainFrameYay, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

														if v106 then
															fn37(v106, { Scale = screenScale }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
														end

														fn37(arg.watermarkFrame, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

														task.delay(0.5, function()
															if arg.isToggledOn and arg.sectionRefreshers then
																for _, sectionRefresher in ipairs(arg.sectionRefreshers) do
																	sectionRefresher()
																end
															end
														end)
													else
														for k in pairs(arg.openDropdowns) do
															if k.Close then
																k:Close()
															end
														end

														fn37(arg.mainFrameYay, { GroupTransparency = v85[18] }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
														local uiScale = arg.mainFrameYay:FindFirstChildOfClass("UIScale")

														if uiScale then
															fn37(uiScale, { Scale = v85[198] * screenScale }, v85[64], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
														end

														fn37(arg.watermarkFrame, { GroupTransparency = 1 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

														if not tbl19.First_Execution_Done then
															tbl19.First_Execution_Done = v85[200]
															fn34()
															local str5

															if touchEnabled then
																str5 = "Tap the button in the bottom left to Hide/Unhide the UI."
															else
																str5 = (arg.toggleVisibilityKeyName or "RightAlt") .. " to Hide/Unhide the UI."
															end

															arg:Notify({ Title = str5, Duration = 4 })
														end

														task.delay(0.35, function()
															if not arg.isToggledOn then
																arg.mainFrameYay.Visible = v85[101]
																arg.watermarkFrame.Visible = false
															end
														end)
													end
												end

												index.CreateWatermarkBecauseWeCool = function(arg)
													local str5 = arg.config.Name .. " | 00:00:00 | 60 FPS | 0 MS"
													local n32 = fn47(str5, 14, Enum.Font.GothamSemibold) + 45
													local n33 = 0

													arg.watermarkFrame = fn45("CanvasGroup", {
														Name = "WatermarkCuzWeNeedFlexing",
														BackgroundColor3 = arg.config.Colors.Secondary,
														Position = UDim2.new(0.01, 0, 0.02, 0),
														BorderColor3 = arg.config.Colors.Black,
														BorderSizePixel = v85[33],
														GroupTransparency = 1,
														Size = UDim2.new(v85[33], n32, v85[33], 36),
														Parent = arg.screenGuiYay,
													})

													fn45(v85[137], {
														Name = "RoundedCornersAreSexy",
														CornerRadius = UDim.new(0, v85[72]),
														Parent = arg.watermarkFrame,
													})

													fn45(v85[44], {
														Name = "KeepItSquare",
														Parent = fn45("ImageLabel", {
															Name = "IconGoesHere",
															BorderColor3 = Color3.new(),
															BackgroundColor3 = Color3.new(v85[18], 1, 1),
															Image = "rbxassetid://10723375250",
															BackgroundTransparency = v85[18],
															Position = UDim2.new(0, v85[192], 0.5, -v85[148]),
															BorderSizePixel = 0,
															Size = UDim2.new(0, 15, 0, 15),
															Parent = arg.watermarkFrame,
														}),
													})

													arg.watermarkTextLabel = fn45("TextLabel", {
														Name = v85[23],
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = Color3.new(1, 1, 1),
														Text = str5,
														BackgroundColor3 = Color3.new(1, v85[18], 1),
														BackgroundTransparency = 1,
														Position = UDim2.new(0, v85[14], 0, 0),
														BorderSizePixel = 0,
														BorderColor3 = Color3.new(),
														TextSize = 14,
														Size = UDim2.new(1, -40, 1, 0),
														TextXAlignment = Enum.TextXAlignment.Left,
														Parent = arg.watermarkFrame,
													})

													fn45("UIPadding", { Name = "PaddingForDays", PaddingTop = UDim.new(0, 2), Parent = arg.watermarkTextLabel })
													fn50(arg.watermarkFrame)
													local n34 = 60
													local n35 = 0
													local now2 = os.clock()
													local v106 = nil

													v106 = fn44(v88.RenderStepped:Connect(function()
														if not arg.watermarkFrame or not arg.watermarkFrame.Parent then
															fn48(v106)
															return
														end
														n35 += 1
														local now3 = os.clock()

														if now3 - now2 >= 1 then
															n34 = math.floor(n35 / (now3 - now2) + 0.5)
															n35 = 0
															now2 = now3
														end
													end))

													task.spawn(function()
														while task.wait(1) do
															local watermarkFrame = arg.watermarkFrame
															local watermarkTextLabel = arg.watermarkTextLabel

															if not (not watermarkFrame or not watermarkFrame.Parent or not watermarkTextLabel or not watermarkTextLabel.Parent) then
																local v107 = os.date("%H:%M:%S")
																n33 = math.floor((v96 or n33) + 0.5)
																local text = arg.config.Name .. " | " .. v107 .. " | " .. n34 .. " FPS | " .. n33 .. v85[10]
																watermarkTextLabel.Text = text
																local n36 = fn47(text, 14, Enum.Font.GothamSemibold) + 45

																if v85[70] < math.abs(watermarkFrame.Size.X.Offset - n36) then
																	fn37(watermarkFrame, { Size = UDim2.new(0, n36, 0, 36) }, 0.2)
																end

																continue
															end

															break
														end
													end)
												end

												index.CreateMainFrameYay = function(arg)
													arg.mainFrameYay = fn45("CanvasGroup", {
														Name = v85[162],
														Active = v85[200],
														AnchorPoint = Vector2.new(0.5, 0.5),
														BackgroundColor3 = arg.config.Colors.Primary,
														Position = UDim2.new(0.5, 0, 0.5, v85[33]),
														BorderColor3 = arg.config.Colors.Black,
														BorderSizePixel = v85[33],
														GroupTransparency = 1,
														Size = UDim2.new(0, v85[62], v85[33], 493),
														Parent = arg.screenGuiYay,
													})

													fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, v85[115]), Parent = arg.mainFrameYay })
													fn45(v85[16], { Name = "MainFrameUIScale", Scale = 1, Parent = arg.mainFrameYay })

													arg.dragBarThing = fn45("Frame", {
														Name = "DragBarForDragging",
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 0, 0, 0),
														Size = UDim2.new(1, 0, 0, 65),
														Parent = arg.mainFrameYay,
													})

													fn50(arg.mainFrameYay, arg.dragBarThing)

													local function fn52(arg2, arg3, arg4)
														local ImageButton = fn45("ImageButton", {
															Name = arg2,
															BackgroundTransparency = 1,
															Image = "rbxassetid://" .. arg3,
															ImageColor3 = arg.config.Colors.SubText,
															Position = UDim2.new(v85[18], -arg4, 0, 17),
															Size = UDim2.new(0, v85[30], v85[33], 16),
															BorderSizePixel = 0,
															AutoButtonColor = false,
															Parent = arg.mainFrameYay,
														})

														ImageButton.MouseEnter:Connect(function()
															fn37(ImageButton, { ImageColor3 = arg.config.Colors.Text }, 0.2, Enum.EasingStyle.Quint)
														end)

														ImageButton.MouseLeave:Connect(function()
															fn37(ImageButton, { ImageColor3 = arg.config.Colors.SubText }, 0.2, Enum.EasingStyle.Quint)
														end)

														return ImageButton
													end

													arg.minimizeButton = fn52("MinimizeButton", "120931250449806", 50)
													arg.closeButton = fn52("CloseButton", "73070135088117", 24)

													arg.minimizeButton.MouseButton1Click:Connect(function()
														arg:SetVisible(false)
													end)

													arg.closeButton.MouseButton1Click:Connect(function()
														arg:Destroy()
													end)

													local v106 = fn47(arg.config.Name, v85[17], Enum.Font.GothamSemibold)

													arg.hubNameLabel = fn45(v85[65], {
														Name = "HubNameGoesHere",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = Color3.new(1, v85[18], 1),
														Text = arg.config.Name,
														BackgroundColor3 = Color3.new(v85[18], 1, 1),
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 10, 0, v85[46]),
														BorderSizePixel = 0,
														BorderColor3 = Color3.new(),
														TextSize = 17,
														Size = UDim2.new(0, v106 + 10, 0, 20),
														TextXAlignment = Enum.TextXAlignment.Left,
														Parent = arg.mainFrameYay,
													})

													local n32 = 156 - v106 + 20 - 50
													local v107 = fn49("@" .. localPlayer.Name, n32, 14, Enum.Font.GothamSemibold)

													arg.userNameLabel = fn45(v85[65], {
														Name = "UserNameOfTheCoolPlayer",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = arg.config.Colors.Muted,
														Text = v107,
														BackgroundColor3 = arg.config.Colors.White,
														BackgroundTransparency = v85[18],
														Position = UDim2.new(v85[33], 10, 0, 34),
														BorderSizePixel = 0,
														BorderColor3 = arg.config.Colors.Black,
														TextSize = 14,
														Size = UDim2.new(0, n32 + v85[115], 0, 18),
														TextXAlignment = Enum.TextXAlignment.Left,
														TextTruncate = Enum.TextTruncate.AtEnd,
														Parent = arg.mainFrameYay,
													})

													arg.playerAvatarImg = fn45("ImageLabel", {
														Name = "PlayerAvatarIs4K",
														BorderColor3 = arg.config.Colors.Black,
														BackgroundColor3 = arg.config.Colors.White,
														Image = "rbxassetid://135756197673563",
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 145, 0, 17),
														BorderSizePixel = v85[33],
														Size = UDim2.new(0, v85[36], v85[33], 30),
														Parent = arg.mainFrameYay,
													})

													task.spawn(function()
														local v108 = fn51(localPlayer.UserId)

														if arg.playerAvatarImg and arg.playerAvatarImg.Parent then
															arg.playerAvatarImg.Image = v108
														end
													end)

													fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(v85[18], 0), Parent = arg.playerAvatarImg })

													arg.lineSeperator = fn45("Frame", {
														Name = "LineThatSeperates",
														BackgroundColor3 = arg.config.Colors.BorderSoft,
														Position = UDim2.new(0, 19, 0, 64),
														BorderColor3 = arg.config.Colors.Black,
														BorderSizePixel = 0,
														Size = UDim2.new(0, 156, v85[33], 1),
														Parent = arg.mainFrameYay,
													})

													local v108 = fn45
													local v109 = v85[21]
													local tbl27 = { Name = "UIGradient" }
													local colorSequence = ColorSequence.new
													local tbl28 = {}
													local v110 = ColorSequenceKeypoint.new(0, arg.config.Colors.BorderSoft)
													local v111 = ColorSequenceKeypoint.new(v85[69], arg.config.Colors.AccentLight)
													local new = ColorSequenceKeypoint.new
													local v112 = v85[18]
													local borderSoft = arg.config.Colors.BorderSoft
													tbl28[1] = v110
													tbl28[2] = v111

													do
														local values = table.pack(new(v112, borderSoft))
														table.move(values, 1, values.n, 3, tbl28)
													end

													tbl27.Color = colorSequence(tbl28)
													tbl27.Parent = arg.lineSeperator
													v108(v109, tbl27)

													arg.tabNameLabel = fn45("TextLabel", {
														Name = "TabNameGoesHere",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = arg.config.Colors.Text,
														Text = "tab name",
														BackgroundColor3 = arg.config.Colors.White,
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 201, 0, 14),
														BorderSizePixel = 0,
														BorderColor3 = Color3.new(),
														TextSize = v85[17],
														Size = UDim2.new(v85[33], 78, 0, 20),
														TextXAlignment = Enum.TextXAlignment.Left,
														Parent = arg.mainFrameYay,
													})

													arg.tabDescriptionLabel = fn45(v85[65], {
														Name = "TabDescriptionGoesHere",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = arg.config.Colors.Muted,
														Text = "tab description",
														BackgroundColor3 = arg.config.Colors.White,
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 201, 0, 34),
														BorderSizePixel = v85[33],
														BorderColor3 = Color3.new(),
														TextSize = 14,
														Size = UDim2.new(v85[33], 200, 0, 18),
														TextXAlignment = Enum.TextXAlignment.Left,
														Parent = arg.mainFrameYay,
													})

													arg.sectionHolderScroll = fn45("ScrollingFrame", {
														Name = "SectionHolderForSections",
														Active = true,
														BackgroundTransparency = 1,
														Position = UDim2.new(v85[33], v85[17], v85[33], 75),
														Size = UDim2.new(0, 162, 0, v85[52]),
														ScrollBarThickness = 0,
														ScrollBarImageTransparency = 1,
														CanvasSize = UDim2.new(0, v85[33], v85[33], v85[33]),
														AutomaticCanvasSize = Enum.AutomaticSize.Y,
														ClipsDescendants = false,
														Parent = arg.mainFrameYay,
													})

													fn45(v85[50], {
														Name = v85[50],
														PaddingLeft = UDim.new(0, 2),
														PaddingRight = UDim.new(0, 2),
														PaddingTop = UDim.new(0, 2),
														PaddingBottom = UDim.new(0, v85[70]),
														Parent = arg.sectionHolderScroll,
													})

													arg.sectionLayoutThing = fn45("UIListLayout", {
														Name = "UIListLayout",
														Padding = UDim.new(0, 10),
														SortOrder = Enum.SortOrder.LayoutOrder,
														Parent = arg.sectionHolderScroll,
													})

													arg.contentHolderFrame = fn45("Frame", {
														Name = v85[135],
														Active = v85[200],
														BackgroundTransparency = v85[18],
														Position = UDim2.new(0, 198, 0, 62),
														Size = UDim2.new(0, 548, 0, 424),
														ClipsDescendants = true,
														Parent = arg.mainFrameYay,
													})
												end
											end
										end
									end

									do
										local v106, v107, fn50

										do
											index.CreateNotificationHolderForCoolNotifs = function(arg)
												arg.notificationHolderFrame = fn45("Frame", {
													Name = "NotificationHolderForNotifs",
													BackgroundTransparency = 1,
													Position = UDim2.new(1, -v85[108], 0, 20),
													AnchorPoint = Vector2.new(v85[18], 0),
													Size = UDim2.new(0, v85[98], v85[33], 400),
													Parent = arg.screenGuiYay,
												})

												fn45("UIListLayout", {
													Name = "UIListLayout",
													Padding = UDim.new(v85[33], 10),
													SortOrder = Enum.SortOrder.LayoutOrder,
													HorizontalAlignment = Enum.HorizontalAlignment.Right,
													VerticalAlignment = Enum.VerticalAlignment.Top,
													Parent = arg.notificationHolderFrame,
												})
											end

											index.Notify = function(arg, arg2)
												local tbl27 = arg2 or {}
												tbl27.Title = tbl27.Title or v85[74]
												tbl27.Duration = tbl27.Duration or 3
												tbl27.Icon = tbl27.Icon or "rbxassetid://10747361219"
												local textSize = v105:GetTextSize(tbl27.Title, 15, Enum.Font.GothamSemibold, Vector2.new(math.huge, 50))
												local n32 = math.max(127, textSize.X + 80)

												local Frame = fn45("Frame", {
													Name = "NotificationYay",
													BackgroundColor3 = arg.config.Colors.Secondary,
													Position = UDim2.new(1.5, 0, v85[33], 0),
													BorderColor3 = arg.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(0, n32, 0, 50),
													BackgroundTransparency = 1,
													Parent = arg.notificationHolderFrame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 10), Parent = Frame })
												fn45("UIScale", { Name = "UIScale", Scale = 0.8, Parent = Frame })

												local v108 = fn45(v85[170], {
													Name = "PillIndicator",
													BackgroundColor3 = arg.config.AccentColor,
													Position = UDim2.new(v85[33], 0, 0.22, 0),
													BorderColor3 = arg.config.Colors.Black,
													BorderSizePixel = v85[33],
													Size = UDim2.new(0, 6, 0, v85[185]),
													Parent = Frame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, v85[33]), Parent = v108 })

												fn45("Frame", {
													Name = "PillExtension",
													BackgroundColor3 = arg.config.AccentColor,
													BorderColor3 = arg.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(0, 4, v85[33], 28),
													Parent = v108,
												})

												local ImageLabel = fn45("ImageLabel", {
													Name = v85[128],
													BorderColor3 = arg.config.Colors.Black,
													BackgroundColor3 = arg.config.Colors.White,
													Image = tbl27.Icon,
													BackgroundTransparency = v85[18],
													Position = UDim2.new(0, 15, 0.5, -10),
													BorderSizePixel = v85[33],
													Size = UDim2.new(v85[33], 20, 0, 20),
													ImageTransparency = v85[18],
													Parent = Frame,
												})

												fn45("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = ImageLabel })

												local v109 = fn45(v85[65], {
													Name = "NotificationText",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.config.Colors.Text,
													Text = tbl27.Title,
													BackgroundColor3 = arg.config.Colors.White,
													BackgroundTransparency = 1,
													Position = UDim2.new(0, 45, 0.5, -8.5),
													BorderSizePixel = 0,
													BorderColor3 = arg.config.Colors.Black,
													TextSize = 15,
													Size = UDim2.new(0, textSize.X + 20, 0, 17),
													TextXAlignment = Enum.TextXAlignment.Left,
													TextTransparency = 1,
													Parent = Frame,
												})

												local uiScale = Frame:FindFirstChild("UIScale")

												task.defer(function()
													fn37(Frame, { Position = UDim2.new(v85[33], 0, 0, 0), BackgroundTransparency = 0 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
													fn37(uiScale, { Scale = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
													fn37(ImageLabel, { ImageTransparency = 0 }, v85[100], Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													fn37(v109, { TextTransparency = 0 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
												end)

												task.delay(tbl27.Duration, function()
													if Frame and Frame.Parent then
														fn37(Frame, { Position = UDim2.new(v85[122], 0, 0, 0), BackgroundTransparency = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
														fn37(uiScale, { Scale = 0.8 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
														fn37(ImageLabel, { ImageTransparency = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
														fn37(v109, { TextTransparency = 1 }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
														task.wait(0.5)

														if Frame and Frame.Parent then
															Frame:Destroy()
														end
													end
												end)

												return Frame
											end

											obj = setmetatable({}, { __mode = "k" })
											v106 = nil
											v107 = nil

											do
												local flag18 = false

												local function fn51()
													if flag18 then
														if not flag3 then
															return
														end
														return
													end

													flag18 = true

													flyteBBState.Connections[v85[125]] = v87.InputChanged:Connect(function(input)
														if v106 then
															v106(input)
														end
													end)

													flyteBBState.Connections["UI Slider Input Ended"] = v87.InputEnded:Connect(function(input)
														if v107 then
															v107(input)
														end
													end)
												end

												fn50 = function(arg, arg2)
													fn51()
													v106 = arg
													v107 = arg2
												end
											end
										end

										do
											local function fn51(arg)
												if v106 == arg then
													v106 = nil
													v107 = nil
												end
											end

											local function fn52(arg)
												if v85[18] <= arg then
													return 0
												end
												local str5 = string.format("%.10f", arg):gsub("0+$", ""):gsub("%.$", "")
												local pos = str5:find("%.")
												return pos and math.min(v85[157], #str5 - pos) or 0
											end

											addToggle = function(arg, arg2)
												local v108 = obj[arg]
												local tabConfig = v108.TabConfig
												local groupConfig = v108.GroupConfig
												local updateSize = v108.UpdateSize
												local createKeybindPill = v108.CreateKeybindPill
												arg2 = arg2 or {}
												arg2.Name = arg2.Name or v85[4]
												arg2.Default = arg2.Default or false

												arg2.Callback = arg2.Callback or function()
												end

												arg2.Notify = arg2.Notify == true
												arg2.SaveName = arg2.SaveName or arg2.Name
												arg2.Keybind = arg2.Keybind ~= false
												local tbl27 = {}
												local elementYPos = arg.elementYPos
												local toggle = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.SaveName)
												local str5 = "toggle:" .. toggle
												local str6 = toggle .. ":notify"
												local v109 = fn46(tbl19.Toggles, toggle, arg2.NoSave)
												local notify = arg2.Notify and fn46(tbl19.Toggles, str6)
												tbl27.value = type(v109) == "boolean" and v109 or arg2.Default
												tbl27.notify = type(notify) == "boolean" and notify or false
												tbl27.NotifySaveId = arg2.Notify and str6 or nil
												tbl27.DefaultNotify = v85[101]

												tbl27.labelText = fn45(v85[65], {
													Name = "ToggleLabel",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = tbl27.value and arg.Library.config.Colors.Text or arg.Library.config.Colors.SubText,
													Text = arg2.Name,
													BackgroundColor3 = arg.Library.config.Colors.White,
													BackgroundTransparency = 1,
													Position = UDim2.new(v85[33], 10, 0, elementYPos),
													BorderSizePixel = 0,
													BorderColor3 = Color3.new(),
													TextSize = 14,
													Size = UDim2.new(0, 150, 0, 20),
													TextXAlignment = Enum.TextXAlignment.Left,
													Parent = arg.mainFrame,
												})

												tbl27.switchFrame = fn45(v85[170], {
													Name = "ToggleSwitch",
													BackgroundColor3 = tbl27.value and arg.Library.config.AccentColor or arg.Library.config.Colors.Element,
													Position = UDim2.new(1, -44, 0, elementYPos),
													BorderColor3 = arg.Library.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(0, 34, 0, 21),
													Parent = arg.mainFrame,
												})

												local function fn53(arg3)
													return UDim2.new(1, arg2.Keybind and -77 - arg3 or -v85[6], v85[33], elementYPos)
												end

												if arg2.Keybind then
													tbl27.keybindPill = createKeybindPill(arg.mainFrame, str5, function(arg3)
														if tbl27.notifyButton then
															tbl27.notifyButton.Position = fn53(arg3)
														end

														return UDim2.new(1, -44 - arg3 - v85[72], 0, elementYPos + 2)
													end, 17, 8, function(arg3, arg4)
														if arg4 == "Hold" then
															tbl27:Set(arg3)
															return
														end

														if arg3 then
															tbl27:Set(not tbl27.value)
														end
													end, {
														Group = "toggles",
														Name = arg2.Name,
														GetState = function()
															return tbl27.value
														end,
													})
												end

												tbl27.SaveId = toggle
												tbl27.DefaultValue = arg2.Default
												fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(v85[18], 0), Parent = tbl27.switchFrame })
												local udim2 = UDim2.new(v85[33], 3, 0, v85[61])
												local udim22 = UDim2.new(0, v85[30], 0, v85[61])

												tbl27.circleFrame = fn45("Frame", {
													Name = v85[54],
													BackgroundColor3 = tbl27.value and arg.Library.config.Colors.White or arg.Library.config.Colors.Muted,
													Position = tbl27.value and udim22 or udim2,
													BorderColor3 = arg.Library.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(0, v85[147], 0, v85[147]),
													Parent = tbl27.switchFrame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = tbl27.circleFrame })

												local TextButton = fn45("TextButton", {
													Name = "ToggleClickButton",
													Text = "",
													BackgroundTransparency = 1,
													Position = UDim2.new(0, v85[33], 0, elementYPos),
													Size = UDim2.new(1, v85[33], 0, v85[197]),
													Parent = arg.mainFrame,
												})

												if arg2.Notify then
													tbl27.notifyButton = fn45("ImageButton", {
														Name = "NotifyBell",
														AutoButtonColor = false,
														BackgroundTransparency = 1,
														BorderSizePixel = v85[33],
														Image = "",
														Position = fn53(tbl27.keybindPill and tbl27.keybindPill.frame.Size.X.Offset or v85[33]),
														Size = UDim2.new(0, 20, 0, 21),
														ZIndex = 3,
														Parent = arg.mainFrame,
													})

													tbl27.notifyIcon = fn45("ImageLabel", {
														Name = "BellIcon",
														BackgroundTransparency = 1,
														BorderSizePixel = v85[33],
														Image = "rbxassetid://128533908255115",
														ImageColor3 = tbl27.notify and arg.Library.config.Colors.Text or arg.Library.config.Colors.Muted,
														ImageTransparency = tbl27.notify and 0 or 0.5,
														Position = UDim2.new(0.5, -9, 0.5, -v85[41]),
														Size = UDim2.new(0, 18, 0, v85[186]),
														ZIndex = 4,
														Parent = tbl27.notifyButton,
													})

													tbl27.notifyScale = fn45("UIScale", { Scale = v85[18], Parent = tbl27.notifyIcon })

													tbl27.SetNotify = function(arg3, arg4)
														local notify2 = arg4 == true
														tbl27.notify = notify2
														tbl27.notifyIcon.Rotation = notify2 and -14 or 14
														tbl27.notifyScale.Scale = 0.82

														fn37(tbl27.notifyIcon, {
															ImageColor3 = notify2 and arg.Library.config.Colors.Text or arg.Library.config.Colors.Muted,
															ImageTransparency = notify2 and 0 or 0.5,
															Rotation = 0,
														}, v85[26], Enum.EasingStyle.Back, Enum.EasingDirection.Out)

														fn37(tbl27.notifyScale, { Scale = v85[18] }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
														tbl19.Toggles[str6] = notify2
														fn34()
													end

													tbl27.notifyButton.MouseButton1Click:Connect(function()
														tbl27:SetNotify(not tbl27.notify)
													end)

													tbl27.notifyButton.MouseEnter:Connect(function()
														if not tbl27.notify then
															fn37(tbl27.notifyIcon, { ImageColor3 = arg.Library.config.Colors.TextHover, ImageTransparency = 0.5 }, 0.15)
														end
													end)

													tbl27.notifyButton.MouseLeave:Connect(function()
														if not tbl27.notify then
															fn37(tbl27.notifyIcon, { ImageColor3 = arg.Library.config.Colors.Muted, ImageTransparency = 0.5 }, 0.15)
														end
													end)
												end

												tbl27.Set = function(arg3, arg4)
													local value = tbl27.value
													tbl27.value = arg4 == true

													if tbl27.value then
														fn37(tbl27.switchFrame, { BackgroundColor3 = arg.Library.config.AccentColor }, 0.4)
														fn37(tbl27.circleFrame, { Position = udim22, BackgroundColor3 = arg.Library.config.Colors.White }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
														fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.Text }, 0.3, Enum.EasingStyle.Quint)
													else
														fn37(tbl27.switchFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.4)
														fn37(tbl27.circleFrame, { Position = udim2, BackgroundColor3 = arg.Library.config.Colors.Muted }, v85[81], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
														fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.3, Enum.EasingStyle.Quint)
													end

													if not arg2.NoSave then
														tbl19.Toggles[toggle] = tbl27.value
													end

													if arg2.Callback then
														arg2.Callback(tbl27.value)
													end

													if not arg2.NoSave then
														task.defer(fn34)
													end

													if flyteBBState and flyteBBState.RefreshKeybinds then
														task.defer(flyteBBState.RefreshKeybinds)
													end

													if arg2.Notify and tbl27.notify and value ~= tbl27.value then
														arg.Library:Notify({ Title = (tbl27.value and "Enabled " or v85[77]) .. (arg2.NotifyName or arg2.Name) })
													end
												end

												TextButton.MouseButton1Click:Connect(function()
													tbl27:Set(not tbl27.value)
												end)

												TextButton.InputBegan:Connect(function(input)
													if input.UserInputType == Enum.UserInputType.MouseButton2 and tbl27.keybindPill then
														tbl27.keybindPill:OpenMode(input.Position)
													end
												end)

												TextButton.MouseEnter:Connect(function()
													if not tbl27.value then
														fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.TextHover }, 0.2, Enum.EasingStyle.Quint)
													end
												end)

												TextButton.MouseLeave:Connect(function()
													if not tbl27.value then
														fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.SubText }, v85[113], Enum.EasingStyle.Quint)
													end
												end)

												arg.elementYPos = arg.elementYPos + 28
												updateSize()
												table.insert(arg.elementsInGroup, tbl27)
												tbl27:Set(tbl27.value)
												return tbl27
											end

											addSlider = function(arg, arg2)
												local v108 = obj[arg]
												local tabConfig = v108.TabConfig
												local groupConfig = v108.GroupConfig
												local updateSize = v108.UpdateSize
												arg2 = arg2 or {}
												arg2.Name = arg2.Name or "Slider"
												arg2.Min = arg2.Min or 0
												arg2.Max = arg2.Max or 100
												arg2.Default = arg2.Default or arg2.Min
												arg2.Increment = arg2.Increment or 1

												arg2.Callback = arg2.Callback or function()
												end

												local tbl27 = {}
												local elementYPos = arg.elementYPos
												local v109 = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.Name)
												local v110 = fn46(tbl19.Sliders, v109, arg2.NoSave)
												local v111 = v85[109]
												tbl27.value = type(v110) == v111 and v110 or arg2.Default
												tbl27.SaveId = v109
												tbl27.DefaultValue = arg2.Default
												local str5 = "%." .. fn52(arg2.Increment) .. "f"

												local function fn53(arg3)
													return string.format(str5, arg3)
												end

												tbl27.labelText = fn45("TextLabel", {
													Name = "SliderLabel",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.Library.config.Colors.SubText,
													Text = arg2.Name,
													BackgroundTransparency = 1,
													Position = UDim2.new(v85[33], v85[115], 0, elementYPos),
													BorderSizePixel = 0,
													TextSize = 14,
													Size = UDim2.new(0, 140, v85[33], v85[108]),
													TextXAlignment = Enum.TextXAlignment.Left,
													Parent = arg.mainFrame,
												})

												tbl27.backgroundFrame = fn45("Frame", {
													Name = "SliderBackground",
													BackgroundColor3 = arg.Library.config.Colors.Surface,
													AnchorPoint = Vector2.new(0, 0.5),
													Position = UDim2.new(v85[33], 10, 0, elementYPos + 28),
													BorderColor3 = arg.Library.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(v85[33], 238, 0, 5),
													Parent = arg.mainFrame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(v85[18], 0), Parent = tbl27.backgroundFrame })
												local n32 = (tbl27.value - arg2.Min) / (arg2.Max - arg2.Min)

												tbl27.fillFrame = fn45("Frame", {
													Name = "SliderFill",
													BackgroundColor3 = Color3.new(1, 1, 1),
													Position = UDim2.new(v85[33], 0, 0, v85[33]),
													BorderColor3 = arg.Library.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(v85[33], 238 * n32, 1, 0),
													Parent = tbl27.backgroundFrame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = tbl27.fillFrame })
												local v112 = fn45
												local tbl28 = { Name = "SliderFillGradient" }
												local colorSequence = ColorSequence.new
												local tbl29 = {}
												local v113 = ColorSequenceKeypoint.new(v85[33], arg.Library.config.Colors.AccentDark)
												local v114 = ColorSequenceKeypoint.new(0.5, arg.Library.config.AccentColor)
												local new = ColorSequenceKeypoint.new
												local accentLight = arg.Library.config.Colors.AccentLight
												tbl29[1] = v113
												tbl29[2] = v114

												do
													local values = table.pack(new(1, accentLight))
													table.move(values, 1, values.n, 3, tbl29)
												end

												tbl28.Color = colorSequence(tbl29)
												tbl28.Parent = tbl27.fillFrame
												tbl27.fillGradient = v112("UIGradient", tbl28)

												tbl27.valueBox = fn45("TextBox", {
													Name = "SliderValueBox",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.Library.config.Colors.SubText,
													Text = fn53(tbl27.value) .. " / " .. fn53(arg2.Max),
													PlaceholderText = "",
													ClearTextOnFocus = true,
													TextEditable = true,
													BackgroundTransparency = 1,
													Position = UDim2.new(1, -95, 0, elementYPos),
													BorderSizePixel = 0,
													TextSize = v85[46],
													Size = UDim2.new(0, 85, v85[33], v85[108]),
													TextXAlignment = Enum.TextXAlignment.Right,
													Parent = arg.mainFrame,
												})

												local TextButton = fn45("TextButton", {
													Name = "SliderClickButton",
													Text = "",
													BackgroundTransparency = 1,
													AnchorPoint = Vector2.new(v85[33], 0.5),
													Position = UDim2.new(0, v85[33], 0.5, v85[33]),
													Size = UDim2.new(1, 0, 0, 24),
													Parent = tbl27.backgroundFrame,
												})

												local v115 = n32
												local n33 = n32
												local flag18 = false
												local flag19 = false
												local flag20 = v85[101]
												local connection = nil

												local function fn54()
													if connection then
														return
													end

													if math.abs(v115 - n33) <= 0.0001 then
														v115 = n33
														tbl27.fillFrame.Size = UDim2.new(0, 238 * v115, 1, 0)
														return
													end

													connection = v88.RenderStepped:Connect(function()
														if not tbl27.backgroundFrame.Parent then
															connection:Disconnect()
															connection = nil
															return
														end

														v115 += (n33 - v115) * v85[110]

														if math.abs(v115 - n33) < 0.0001 then
															v115 = n33
														end

														tbl27.fillFrame.Size = UDim2.new(0, 238 * v115, v85[18], 0)

														if v115 == n33 then
															connection:Disconnect()
															connection = nil
														end
													end)
												end

												tbl27.Set = function(arg3, arg4, arg5)
													local v116 = v85[109]
													arg4 = type(arg4) == v116 and arg4 or arg2.Default
													local increment = arg2.Increment
													local n34 = math.clamp(arg2.Min + math.floor((arg4 - arg2.Min) / arg2.Increment + v85[81]) * increment, arg2.Min, arg2.Max)
													local value = tonumber(fn53(n34)) or n34
													tbl27.value = value

													if not arg5 then
														n33 = (value - arg2.Min) / (arg2.Max - arg2.Min)
													end

													fn54()

													if not flag18 then
														tbl27.valueBox.Text = fn53(value) .. " / " .. fn53(arg2.Max)
													end

													if not arg2.NoSave then
														tbl19.Sliders[v109] = value

														if not flag19 then
															fn34()
														end
													end

													arg2.Callback(value)
												end

												tbl27.valueBox.Focused:Connect(function()
													flag18 = v85[200]
												end)

												tbl27.valueBox:GetPropertyChangedSignal(v85[133]):Connect(function()
													if not flag18 then
														return
													end
													local num = tonumber(tbl27.valueBox.Text:match("^[%d%.]+"))

													if num then
														n33 = (math.clamp(num, arg2.Min, arg2.Max) - arg2.Min) / (arg2.Max - arg2.Min)
														fn54()
													end
												end)

												tbl27.valueBox.FocusLost:Connect(function()
													flag18 = false
													tbl27:Set(tonumber(tbl27.valueBox.Text:match("^[%d%.]+")) or tbl27.value)

													if arg2.OnCommit then
														arg2.OnCommit(tbl27.value)
													end
												end)

												local function fn55(arg3)
													local flag21 = arg3 == "drag" or arg3 == "hover"
													fn37(tbl27.backgroundFrame, { Size = UDim2.new(v85[33], 238, 0, arg3 == v85[159] and v85[72] or arg3 == v85[117] and 6 or 5) }, v85[26], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
													flag21 = flag21 and arg.Library.config.Colors.Text or arg.Library.config.Colors.SubText
													fn37(tbl27.valueBox, { TextColor3 = flag21 }, 0.25, Enum.EasingStyle.Quint)
													fn37(tbl27.labelText, { TextColor3 = flag21 }, 0.25, Enum.EasingStyle.Quint)
												end

												TextButton.MouseEnter:Connect(function()
													flag20 = v85[200]

													if not flag19 then
														fn55(v85[117])
													end
												end)

												TextButton.MouseLeave:Connect(function()
													flag20 = false

													if not flag19 then
														fn55("idle")
													end
												end)

												local tbl30 = {}
												local thread = nil

												local function fn56()
													if thread then
														task.cancel(thread)
													end

													thread = nil

													for _, v116 in ipairs(tbl30) do
														if v116 and v116.Parent then
															v116.ScrollingEnabled = true
														end
													end

													table.clear(tbl30)
												end

												local function fn57()
													local parent = TextButton.Parent

													while parent and parent ~= game do
														if parent:IsA("ScrollingFrame") and parent.ScrollingEnabled then
															parent.ScrollingEnabled = false
															table.insert(tbl30, parent)
														end

														parent = parent.Parent
													end

													if thread then
														task.cancel(thread)
													end

													thread = task.delay(v85[70], function()
														thread = nil
														fn56()
													end)
												end

												local function fn58(arg3)
													if flag19 and (arg3.UserInputType == Enum.UserInputType.MouseMovement or arg3.UserInputType == Enum.UserInputType.Touch) then
														local n34 = math.clamp((arg3.Position.X - tbl27.backgroundFrame.AbsolutePosition.X) / tbl27.backgroundFrame.AbsoluteSize.X, 0, 1)
														n33 = n34
														tbl27:Set(arg2.Min + (arg2.Max - arg2.Min) * n34, v85[200])
													end
												end

												local function fn59(arg3)
													if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
														if flag19 then
															flag19 = false
															fn56()
															fn55(flag20 and v85[117] or v85[82])
															n33 = (tbl27.value - arg2.Min) / (arg2.Max - arg2.Min)
															fn54()

															if not arg2.NoSave then
																fn34()
															end

															fn51(fn58)

															if arg2.OnCommit then
																arg2.OnCommit(tbl27.value)
															end
														end
													end
												end

												TextButton.MouseButton1Down:Connect(function(x)
													flag19 = true
													fn55("drag")
													fn57()
													local n34 = math.clamp(((x or v87:GetMouseLocation().X) - tbl27.backgroundFrame.AbsolutePosition.X) / tbl27.backgroundFrame.AbsoluteSize.X, v85[33], 1)
													n33 = n34
													tbl27:Set(arg2.Min + (arg2.Max - arg2.Min) * n34, v85[200])
													fn50(fn58, fn59)
												end)

												tbl27:Set(tbl27.value)
												arg.elementYPos = arg.elementYPos + 40
												updateSize()
												table.insert(arg.elementsInGroup, tbl27)
												return tbl27
											end

											addDoubleSlider = function(arg, arg2)
												local v108 = obj[arg]
												local tabConfig = v108.TabConfig
												local groupConfig = v108.GroupConfig
												local updateSize = v108.UpdateSize
												arg2 = arg2 or {}
												arg2.Name = arg2.Name or "Double Slider"
												arg2.Min = arg2.Min or 1
												arg2.Max = arg2.Max or 100
												arg2.DefaultMin = arg2.DefaultMin or arg2.Min
												arg2.DefaultMax = arg2.DefaultMax or arg2.Max
												arg2.Increment = arg2.Increment or 1

												arg2.Callback = arg2.Callback or function()
												end

												local tbl27 = {}
												local elementYPos = arg.elementYPos
												local v109 = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.Name)
												local v110 = fn46(tbl19.DoubleSliders, v109, arg2.NoSave)
												tbl27.minValue = type(v110) == "table" and type(v110.Min) == "number" and v110.Min or arg2.DefaultMin
												local v111 = v85[145]
												tbl27.maxValue = type(v110) == v111 and type(v110.Max) == "number" and v110.Max or arg2.DefaultMax
												tbl27.SaveId = v109
												tbl27.DefaultValue = { Min = arg2.DefaultMin, Max = arg2.DefaultMax }

												tbl27.labelText = fn45("TextLabel", {
													Name = "DoubleSliderLabel",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.Library.config.Colors.SubText,
													Text = arg2.Name,
													BackgroundTransparency = 1,
													Position = UDim2.new(v85[33], v85[115], 0, elementYPos),
													BorderSizePixel = 0,
													TextSize = 14,
													Size = UDim2.new(v85[33], 140, 0, 20),
													TextXAlignment = Enum.TextXAlignment.Left,
													Parent = arg.mainFrame,
												})

												tbl27.valueLabelText = fn45("TextLabel", {
													Name = "DoubleSliderValueLabel",
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.Library.config.Colors.SubText,
													Text = "",
													BackgroundTransparency = 1,
													Position = UDim2.new(1, -v85[31], v85[33], elementYPos),
													BorderSizePixel = 0,
													TextSize = v85[46],
													Size = UDim2.new(0, 85, v85[33], v85[108]),
													TextXAlignment = Enum.TextXAlignment.Right,
													Parent = arg.mainFrame,
												})

												tbl27.backgroundFrame = fn45("Frame", {
													Name = "DoubleSliderBackground",
													BackgroundColor3 = arg.Library.config.Colors.Surface,
													AnchorPoint = Vector2.new(0, 0.5),
													Position = UDim2.new(0, 10, 0, elementYPos + 28),
													BorderSizePixel = 0,
													Size = UDim2.new(0, 238, 0, 5),
													Parent = arg.mainFrame,
												})

												fn45("UICorner", { CornerRadius = UDim.new(1, 0), Parent = tbl27.backgroundFrame })

												tbl27.fillFrame = fn45(v85[170], {
													Name = v85[56],
													BackgroundColor3 = Color3.new(1, 1, 1),
													BorderSizePixel = v85[33],
													Parent = tbl27.backgroundFrame,
												})

												fn45(v85[137], { CornerRadius = UDim.new(1, 0), Parent = tbl27.fillFrame })
												local v112 = fn45
												local v113 = v85[21]
												local tbl28 = { Name = "DoubleSliderFillGradient" }
												local colorSequence = ColorSequence.new
												local tbl29 = {}
												local v114 = ColorSequenceKeypoint.new(v85[33], arg.Library.config.Colors.AccentDark)
												local v115 = ColorSequenceKeypoint.new(0.5, arg.Library.config.AccentColor)
												local new = ColorSequenceKeypoint.new
												local v116 = v85[18]
												local accentLight = arg.Library.config.Colors.AccentLight
												tbl29[1] = v114
												tbl29[2] = v115

												do
													local values = table.pack(new(v116, accentLight))
													table.move(values, 1, values.n, 3, tbl29)
												end

												tbl28.Color = colorSequence(tbl29)
												tbl28.Parent = tbl27.fillFrame
												tbl27.fillGradient = v112(v113, tbl28)

												tbl27.minEdgeFrame = fn45("Frame", {
													Name = "DoubleSliderMinEdge",
													BackgroundTransparency = 1,
													AnchorPoint = Vector2.new(0.5, v85[81]),
													Position = UDim2.new(0, 0, v85[81], v85[33]),
													Size = UDim2.new(0, 30, v85[18], 12),
													Parent = tbl27.backgroundFrame,
												})

												tbl27.maxEdgeFrame = fn45(v85[170], {
													Name = "DoubleSliderMaxEdge",
													BackgroundTransparency = 1,
													AnchorPoint = Vector2.new(0.5, v85[81]),
													Position = UDim2.new(0, 0, 0.5, 0),
													Size = UDim2.new(0, v85[36], 1, 12),
													Parent = tbl27.backgroundFrame,
												})

												local str5 = "%." .. fn52(arg2.Increment) .. "f"

												local function fn53(arg3)
													return string.format(str5, arg3)
												end

												local function fn54(arg3)
													local increment = arg2.Increment
													local min = arg2.Min
													local max = arg2.Max
													local n32 = math.clamp(arg2.Min + math.floor((arg3 - arg2.Min) / arg2.Increment + 0.5) * increment, min, max)
													return tonumber(fn53(n32)) or n32
												end

												local function fn55(arg3)
													return (arg3 - arg2.Min) / (arg2.Max - arg2.Min)
												end

												local n32 = 0
												local v117 = v85[33]
												local n33 = 0
												local n34 = 0
												local flag18 = false
												local str6 = nil
												local connection = nil

												local function fn56()
													if connection then
														return
													end
													local flag19 = math.abs(n32 - n33) > 0.0001
													local flag20 = math.abs(v117 - n34) > 0.0001
													if not flag19 and not flag20 then
														return
													end

													connection = v88.RenderStepped:Connect(function()
														if not tbl27.backgroundFrame.Parent then
															connection:Disconnect()
															connection = nil
															return
														end

														local v118 = v85[102]
														flag19 = math.abs(n32 - n33) > v118
														flag20 = math.abs(v117 - n34) > 0.0001

														if flag19 then
															n32 += (n33 - n32) * v85[110]
															local v119 = v85[102]

															if math.abs(n32 - n33) < v119 then
																n32 = n33
															end
														end

														if flag20 then
															v117 += (n34 - v117) * 0.15
															local v119 = v85[102]

															if math.abs(v117 - n34) < v119 then
																v117 = n34
															end
														end

														tbl27.minEdgeFrame.Position = UDim2.new(n32, 0, 0.5, v85[33])
														tbl27.maxEdgeFrame.Position = UDim2.new(v117, 0, v85[81], v85[33])
														tbl27.fillFrame.Position = UDim2.new(n32, 0, v85[33], 0)
														tbl27.fillFrame.Size = UDim2.new(v117 - n32, v85[33], 1, v85[33])

														if n32 == n33 and v117 == n34 then
															connection:Disconnect()
															connection = nil
														end
													end)
												end

												tbl27.Set = function(arg3, arg4, arg5, arg6)
													arg4 = type(arg4) == "number" and arg4 or arg2.DefaultMin
													local v118 = v85[109]
													arg5 = type(arg5) == v118 and arg5 or arg2.DefaultMax
													local v119 = fn54(arg4)
													local v120 = fn54(arg5)

													if not (v120 < v119) then
														local v121 = v120
														v120 = v119
														v119 = v121
													end

													tbl27.minValue = v120
													tbl27.maxValue = v119

													if not arg6 then
														n33 = fn55(v120)
														n34 = fn55(v119)
													end

													fn56()
													tbl27.valueLabelText.Text = fn53(v120) .. " - " .. fn53(v119)

													if not arg2.NoSave then
														if n24 >= 4769 then
															while true do
															end
														else
															tbl19.DoubleSliders[v109] = { Min = v120, Max = v119 }

															if not str6 then
																fn34()
															end
														end
													end

													arg2.Callback(v120, v119)
												end

												local function fn57()
													local text = (str6 or flag18) and arg.Library.config.Colors.Text or arg.Library.config.Colors.SubText
													fn37(tbl27.labelText, { TextColor3 = text }, 0.25, Enum.EasingStyle.Quint)
													fn37(tbl27.valueLabelText, { TextColor3 = text }, v85[26], Enum.EasingStyle.Quint)
												end

												local function fn58(arg3)
													local n35 = math.clamp((arg3.Position.X - tbl27.backgroundFrame.AbsolutePosition.X) / tbl27.backgroundFrame.AbsoluteSize.X, 0, 1)

													if str6 == "min" then
														n33 = n35
														tbl27:Set(arg2.Min + (arg2.Max - arg2.Min) * n35, tbl27.maxValue, v85[200])
														return
													end

													if str6 == "max" then
														n34 = n35
														tbl27:Set(tbl27.minValue, arg2.Min + (arg2.Max - arg2.Min) * n35, v85[200])
													end
												end

												local fn59 = nil

												local v118 = fn45(v85[39], {
													Name = "DoubleSliderClickButton",
													Text = "",
													BackgroundTransparency = 1,
													AnchorPoint = Vector2.new(v85[33], 0.5),
													Position = UDim2.new(v85[33], 0, v85[81], 0),
													Size = UDim2.new(v85[18], 0, 0, 24),
													Parent = tbl27.backgroundFrame,
												})

												v118.MouseEnter:Connect(function()
													flag18 = true
													fn57()
												end)

												v118.MouseLeave:Connect(function()
													flag18 = false
													fn57()
												end)

												v118.MouseButton1Down:Connect(function(x)
													local x2 = x or v87:GetMouseLocation().X
													str6 = math.abs(x2 - tbl27.minEdgeFrame.AbsolutePosition.X + tbl27.minEdgeFrame.AbsoluteSize.X * v85[81]) <= math.abs(x2 - tbl27.maxEdgeFrame.AbsolutePosition.X + tbl27.maxEdgeFrame.AbsoluteSize.X * 0.5) and "min" or "max"
													local n35 = math.clamp((x2 - tbl27.backgroundFrame.AbsolutePosition.X) / tbl27.backgroundFrame.AbsoluteSize.X, 0, 1)

													if str6 == "min" then
														n33 = n35
														tbl27:Set(arg2.Min + (arg2.Max - arg2.Min) * n35, tbl27.maxValue, true)
													else
														n34 = n35
														tbl27:Set(tbl27.minValue, arg2.Min + (arg2.Max - arg2.Min) * n35, v85[200])
													end

													fn57()
													fn50(fn58, fn59)
												end)

												fn59 = function(arg3)
													if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
														if str6 then
															str6 = nil
															fn57()
															n33 = fn55(tbl27.minValue)
															n34 = fn55(tbl27.maxValue)
															fn56()

															if not arg2.NoSave then
																fn34()
															end

															fn51(fn58)

															if arg2.OnCommit then
																arg2.OnCommit(tbl27.minValue, tbl27.maxValue)
															end
														end
													end
												end

												tbl27:Set(tbl27.minValue, tbl27.maxValue)
												arg.elementYPos = arg.elementYPos + 40
												updateSize()
												table.insert(arg.elementsInGroup, tbl27)
												return tbl27
											end
										end
									end
								end
							end

							do
								local addGroup

								do
									do
										local function addButton(arg, arg2)
											local updateSize = obj[arg].UpdateSize
											arg2 = arg2 or {}
											arg2.Name = arg2.Name or "Button"
											arg2.Icon = arg2.Icon
											arg2.Locked = arg2.Locked or false

											arg2.Callback = arg2.Callback or function()
											end

											local tbl27 = { isLocked = arg2.Locked }
											local elementYPos = arg.elementYPos
											local udim2 = UDim2.new(v85[33], 238, 0, 26)

											tbl27.mainFrame = fn45("Frame", {
												Name = "ButtonFrame",
												BackgroundColor3 = tbl27.isLocked and arg.Library.config.Colors.Tertiary or arg.Library.config.Colors.Element,
												Position = UDim2.new(0, 10, 0, elementYPos),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = udim2,
												ClipsDescendants = true,
												Parent = arg.mainFrame,
											})

											local UICorner = fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(0, 6), Parent = tbl27.mainFrame })

											local UIStroke = fn45("UIStroke", {
												Name = v85[131],
												Color = tbl27.isLocked and arg.Library.config.Colors.Element or arg.Library.config.Colors.Border,
												Parent = tbl27.mainFrame,
											})

											local v105 = fn45
											local tbl28 = { Name = v85[21] }
											local colorSequence = ColorSequence.new
											local tbl29 = {}
											local v106 = ColorSequenceKeypoint.new(0, arg.Library.config.Colors.Text)
											local v107 = ColorSequenceKeypoint.new(0.493, arg.Library.config.Colors.AccentLight)
											local new = ColorSequenceKeypoint.new
											local v108 = v85[18]
											local text = arg.Library.config.Colors.Text
											local v109 = ColorSequenceKeypoint.new(0.509, arg.Library.config.Colors.AccentLight)
											tbl29[1] = v106
											tbl29[2] = v107
											tbl29[3] = v109

											do
												local values = table.pack(new(v108, text))
												table.move(values, 1, values.n, 4, tbl29)
											end

											tbl28.Color = colorSequence(tbl29)
											tbl28.Rotation = 260
											tbl28.Parent = UIStroke
											v105("UIGradient", tbl28)

											local Frame = fn45("Frame", {
												Name = "Shine",
												BackgroundColor3 = arg.Library.config.Colors.AccentLight,
												BackgroundTransparency = v85[18],
												Size = UDim2.new(0, 8, 1, 0),
												Position = UDim2.new(-v85[22], 0, 0, 0),
												ZIndex = 3,
												Rotation = -15,
												Parent = tbl27.mainFrame,
											})

											local v110 = fn45
											local tbl30 = { Name = v85[51], Rotation = v85[91] }
											local numberSequence = NumberSequence.new
											local tbl31 = {}
											local v111 = NumberSequenceKeypoint.new(v85[33], v85[18])
											local v112 = NumberSequenceKeypoint.new(0.5, 0.4)
											tbl31[1] = v111
											tbl31[2] = v112

											do
												local values = table.pack(NumberSequenceKeypoint.new(1, 1))
												table.move(values, 1, values.n, 3, tbl31)
											end

											tbl30.Transparency = numberSequence(tbl31)
											tbl30.Parent = Frame
											v110("UIGradient", tbl30)
											local n32 = 8

											if arg2.Icon then
												fn45("ImageLabel", {
													Name = v85[40],
													ImageColor3 = tbl27.isLocked and arg.Library.config.Colors.Muted or arg.Library.config.Colors.SubText,
													BackgroundColor3 = arg.Library.config.Colors.White,
													Image = arg2.Icon,
													BackgroundTransparency = v85[18],
													Position = UDim2.new(0, 8, 0.5, -8),
													BorderColor3 = arg.Library.config.Colors.Black,
													BorderSizePixel = 0,
													Size = UDim2.new(v85[33], v85[30], 0, 16),
													Parent = tbl27.mainFrame,
												})

												n32 = v85[36]
											end

											tbl27.labelText = fn45("TextLabel", {
												Name = "ButtonLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = tbl27.isLocked and arg.Library.config.Colors.Muted or arg.Library.config.Colors.SubText,
												Text = arg2.Name .. (tbl27.isLocked and " (locked)" or ""),
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, n32, 0, 0),
												BorderSizePixel = 0,
												BorderColor3 = arg.Library.config.Colors.Black,
												TextSize = 14,
												Size = UDim2.new(1, -n32 - 10, 1, 0),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = tbl27.mainFrame,
											})

											local TextButton = fn45("TextButton", {
												Name = v85[177],
												Text = "",
												BackgroundTransparency = 1,
												Size = UDim2.new(v85[18], 0, 1, 0),
												Parent = tbl27.mainFrame,
											})

											local flag18 = v85[101]

											local function fn50()
												if flag18 then
													return
												end
												flag18 = true
												Frame.Position = UDim2.new(-0.1, 0, 0, 0)
												Frame.BackgroundTransparency = v85[139]
												fn37(Frame, { Position = UDim2.new(v85[104], 0, v85[33], v85[33]), BackgroundTransparency = 1 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

												task.delay(0.35, function()
													flag18 = false
												end)
											end

											TextButton.MouseButton1Down:Connect(function()
												if not tbl27.isLocked then
													fn37(tbl27.mainFrame, { Size = UDim2.new(0, 228.48, v85[33], 23.92) }, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													fn37(UICorner, { CornerRadius = UDim.new(0, 8) }, v85[22])
													fn50()
												end
											end)

											TextButton.MouseButton1Up:Connect(function()
												if not tbl27.isLocked then
													fn37(tbl27.mainFrame, { Size = udim2 }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
													fn37(UICorner, { CornerRadius = UDim.new(0, 6) }, 0.3)
													arg2.Callback()
												end
											end)

											TextButton.MouseLeave:Connect(function()
												if not tbl27.isLocked then
													fn37(tbl27.mainFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.4, Enum.EasingStyle.Exponential)
													fn37(tbl27.mainFrame, { Size = udim2 }, 0.3, Enum.EasingStyle.Exponential)
													fn37(UICorner, { CornerRadius = UDim.new(0, 6) }, 0.3)
												end
											end)

											TextButton.MouseEnter:Connect(function()
												if not tbl27.isLocked then
													fn37(tbl27.mainFrame, { BackgroundColor3 = arg.Library.config.Colors.ElementHover }, v85[139], Enum.EasingStyle.Exponential)
												end
											end)

											arg.elementYPos = arg.elementYPos + 32
											updateSize()
											table.insert(arg.elementsInGroup, tbl27)
											return tbl27
										end

										local function addKeybind(arg, arg2)
											local v105 = obj[arg]
											local tabConfig = v105.TabConfig
											local groupConfig = v105.GroupConfig
											local updateSize = v105.UpdateSize
											arg2 = arg2 or {}
											arg2.Name = arg2.Name or v85[29]
											arg2.Default = arg2.Default or Enum.KeyCode.Unknown

											arg2.Callback = arg2.Callback or function()
											end

											arg2.ChangedCallback = arg2.ChangedCallback or function()
											end

											local tbl27 = {}
											local v106 = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.Name)
											local v107 = fn46(tbl19.Keybinds, v106, arg2.NoSave)

											if v107 then
												local resolve = tbl12.Resolve
												local v108 = v85[145]
												v107 = resolve(type(v107) == v108 and v107.Key or v107)
											end

											tbl27.value = v107 or arg2.Default
											tbl27.isListening = v85[101]
											tbl27.SaveId = v106
											tbl27.DefaultValue = arg2.Default
											tbl12.SetMeta(v106, { Group = "keybinds", Name = arg2.Name })
											local elementYPos = arg.elementYPos

											tbl27.labelText = fn45(v85[65], {
												Name = "KeybindLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = arg2.Name,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, 10, 0, elementYPos),
												BorderSizePixel = v85[33],
												BorderColor3 = Color3.new(),
												TextSize = 14,
												Size = UDim2.new(0, 120, 0, v85[108]),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = arg.mainFrame,
											})

											local str5 = tbl27.value == Enum.KeyCode.Unknown and "None" or tbl12.Display(tbl27.value)
											local n32 = fn47(str5, v85[49]) + 26

											tbl27.buttonFrame = fn45("Frame", {
												Name = "KeybindButton",
												BackgroundColor3 = arg.Library.config.Colors.Element,
												Position = UDim2.new(1, -n32 - 10, v85[33], elementYPos),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = v85[33],
												Size = UDim2.new(0, n32, v85[33], 21),
												Parent = arg.mainFrame,
											})

											fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(1, v85[33]), Parent = tbl27.buttonFrame })
											local UIStroke = fn45("UIStroke", { Name = v85[131], Color = arg.Library.config.Colors.BorderSoft, Parent = tbl27.buttonFrame })
											local v108 = fn45
											local tbl28 = { Name = v85[21] }
											local colorSequence = ColorSequence.new
											local tbl29 = {}
											local v109 = ColorSequenceKeypoint.new(0, arg.Library.config.Colors.Text)
											local v110 = ColorSequenceKeypoint.new(v85[27], arg.Library.config.Colors.AccentLight)
											local v111 = ColorSequenceKeypoint.new(0.509, arg.Library.config.Colors.AccentLight)
											tbl29[1] = v109
											tbl29[2] = v110
											tbl29[3] = v111

											do
												local values = table.pack(ColorSequenceKeypoint.new(1, arg.Library.config.Colors.Text))
												table.move(values, 1, values.n, 4, tbl29)
											end

											tbl28.Color = colorSequence(tbl29)
											tbl28.Rotation = 260
											tbl28.Parent = UIStroke
											v108("UIGradient", tbl28)

											tbl27.keyLabelText = fn45("TextLabel", {
												Name = "KeyLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = str5,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(v85[33], v85[33], 0, v85[33]),
												BorderSizePixel = 0,
												BorderColor3 = Color3.new(),
												TextSize = 12,
												Size = UDim2.new(v85[18], -20, v85[18], v85[33]),
												TextXAlignment = Enum.TextXAlignment.Center,
												Parent = tbl27.buttonFrame,
											})

											tbl27.keyboardIconImg = fn45("ImageLabel", {
												Name = "KeyboardIcon",
												ImageColor3 = arg.Library.config.Colors.Muted,
												BackgroundColor3 = arg.Library.config.Colors.White,
												Image = "rbxassetid://10723416765",
												BackgroundTransparency = 1,
												Position = UDim2.new(1, -18, 0.5, -7),
												BorderColor3 = Color3.new(),
												BorderSizePixel = 0,
												Size = UDim2.new(0, 14, 0, 14),
												Parent = tbl27.buttonFrame,
											})

											fn45("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = tbl27.keyboardIconImg })

											local TextButton = fn45("TextButton", {
												Name = "KeybindClickButton",
												Text = "",
												BackgroundTransparency = 1,
												Size = UDim2.new(v85[18], 0, 1, 0),
												Parent = tbl27.buttonFrame,
											})

											local function fn50(arg3)
												local n33 = fn47(arg3, v85[49]) + 26
												fn37(tbl27.buttonFrame, { Size = UDim2.new(v85[33], n33, v85[33], 21), Position = UDim2.new(1, -n33 - v85[115], 0, elementYPos) }, 0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
											end

											tbl27.Set = function(arg3, value)
												tbl27.value = value
												local text = value == Enum.KeyCode.Unknown and v85[172] or tbl12.Display(value)
												tbl27.keyLabelText.Text = text
												fn50(text)

												if not arg2.NoSave then
													tbl19.Keybinds[v106] = value == Enum.KeyCode.Unknown and nil or value.Name
													fn34()
												end

												if flyteBBState and flyteBBState.RefreshKeybinds then
													task.defer(flyteBBState.RefreshKeybinds)
												end

												arg2.ChangedCallback(value)
											end

											TextButton.InputBegan:Connect(function(input)
												if input.UserInputType == Enum.UserInputType.MouseButton1 then
													tbl27.isListening = v85[200]
													tbl27.keyLabelText.Text = v85[112]
													fn50(v85[112])
													fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.ElementHover }, 0.4)
													fn37(UIStroke, { Color = arg.Library.config.Colors.Border }, 0.4)
													fn37(tbl27.keyLabelText, { TextColor3 = arg.Library.config.Colors.TextHover }, v85[139])
													fn37(tbl27.keyboardIconImg, { ImageColor3 = arg.Library.config.Colors.TextHover }, 0.4)
												end
											end)

											fn44(v87.InputBegan:Connect(function(input, gameProcessed)
												local flag18 = input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseButton3

												if tbl27.isListening then
													if not flag18 then
														return
													end
													tbl27.isListening = false
													tbl27:Set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
													fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.4)
													fn37(UIStroke, { Color = arg.Library.config.Colors.BorderSoft }, v85[139])
													fn37(tbl27.keyLabelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.4)
													fn37(tbl27.keyboardIconImg, { ImageColor3 = arg.Library.config.Colors.Muted }, v85[139])
													return
												end

												if gameProcessed or not flag18 then
													return
												end

												if (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType) == tbl27.value then
													arg2.Callback()
												end
											end))

											TextButton.MouseEnter:Connect(function()
												if not tbl27.isListening then
													fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.ElementHover }, 0.4)
													fn37(UIStroke, { Color = arg.Library.config.Colors.Border }, 0.4)
													fn37(tbl27.keyLabelText, { TextColor3 = arg.Library.config.Colors.TextHover }, 0.4)
													fn37(tbl27.keyboardIconImg, { ImageColor3 = arg.Library.config.Colors.TextHover }, 0.4)
												end
											end)

											TextButton.MouseLeave:Connect(function()
												if not tbl27.isListening then
													fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.4)
													fn37(UIStroke, { Color = arg.Library.config.Colors.BorderSoft }, 0.4)
													fn37(tbl27.keyLabelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.4)
													fn37(tbl27.keyboardIconImg, { ImageColor3 = arg.Library.config.Colors.Muted }, 0.4)
												end
											end)

											arg.elementYPos = arg.elementYPos + 28
											updateSize()
											arg2.ChangedCallback(tbl27.value)
											table.insert(arg.elementsInGroup, tbl27)
											return tbl27
										end

										local function addDropdown(arg, arg2)
											local v105 = obj[arg]
											local tabConfig = v105.TabConfig
											local groupConfig = v105.GroupConfig
											local updateSize = v105.UpdateSize
											local createKeybindPill = v105.CreateKeybindPill
											arg2 = arg2 or {}
											arg2.Name = arg2.Name or v85[92]
											arg2.Options = arg2.Options or { v85[178], "Option 2", v85[163] }
											arg2.Default = arg2.Default or arg2.Options[1]

											arg2.Callback = arg2.Callback or function()
											end

											arg2.OnOpen = arg2.OnOpen or function()
											end

											local tbl27 = {}
											local dropdown = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.Name)
											local v106 = fn46(tbl19.Dropdowns, dropdown, arg2.NoSave)
											tbl27.value = arg2.Default

											for _, v107 in arg2.Options, nil, nil do
												if v106 == v107 then
													tbl27.value = v106
													break
												end
											end

											tbl27.SaveId = dropdown
											tbl27.DefaultValue = arg2.Default
											tbl27.isOpen = v85[101]
											local str5 = "dropdown:" .. dropdown

											local function fn50(arg3)
												return str5 .. ":" .. arg3
											end

											local elementYPos = arg.elementYPos

											local function fn51()
												local n32 = fn47(arg2.Name, v85[46], Enum.Font.GothamSemibold) + 8
												local n33 = math.min(140, v85[151] - n32)

												if n33 < v85[78] then
													n33 = 40
													n32 = 172
												end

												local v107 = fn49(tbl27.value or "None", n33 - 32, 14, Enum.Font.GothamSemibold)
												local v108 = v85[14]
												return v107, n32, (math.clamp(fn47(v107, 14, Enum.Font.GothamSemibold) + v108, 40, n33))
											end

											local v107, v108, v109 = fn51()

											tbl27.labelText = fn45("TextLabel", {
												Name = "DropdownLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = arg2.Name,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, 10, v85[33], elementYPos),
												BorderSizePixel = v85[33],
												BorderColor3 = Color3.new(),
												TextSize = 14,
												Size = UDim2.new(0, v108, 0, 20),
												TextXAlignment = Enum.TextXAlignment.Left,
												TextTruncate = Enum.TextTruncate.AtEnd,
												Parent = arg.mainFrame,
											})

											local function fn52()
												local n32 = 0

												for _, option in ipairs(arg2.Options) do
													local v110 = fn47(option, v85[46], Enum.Font.GothamSemibold)
													local v111 = fn50(option)
													local v112 = tbl12.Get(v111)
													local n33

													if v112 == Enum.KeyCode.Unknown then
														local v113 = v85[19]
														n33 = fn47("...", 11, Enum.Font.GothamSemibold) + v113
													else
														local v113 = v85[19]
														n33 = fn47(v112.Name, v85[192], Enum.Font.GothamSemibold) + v113
													end

													local n34 = v110 + n33 + v85[76]

													if n32 < n34 then
														n32 = n34
													end
												end

												return math.max(n32, 130)
											end

											local function fn53(arg3, arg4)
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
												local udim2 = UDim2.new(v85[33], arg4, 0, v85[161])
												local tbl28 = { Size = udim2 }

												if not tbl27.detached then
													tbl28.Position = UDim2.new(v85[18], -arg4 - 10, 0, elementYPos)
												end

												if tbl27.dockFrame then
													tbl27.dockFrame.Size = udim2
													tbl27.dockFrame.Position = UDim2.new(1, -arg4 - 10, 0, elementYPos)
												end

												fn37(tbl27.labelText, { Size = UDim2.new(0, arg3, 0, 20) }, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
												fn37(tbl27.buttonFrame, tbl28, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

												if tbl27.isOpen then
													local absolutePosition = tbl27.buttonFrame.AbsolutePosition
													fn37(tbl27.optionHolderFrame, { Position = UDim2.new(0, absolutePosition.X / scale, 0, (absolutePosition.Y + tbl27.buttonFrame.AbsoluteSize.Y + 10) / scale) }, v85[100], Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
												end
											end

											local function fn54(value)
												local value2 = tbl27.value
												tbl27.value = value
												local v110, v111, v112 = fn51()
												tbl27.selectedLabelText.Text = v110
												fn53(v111, v112)

												for _, child in pairs(tbl27.optionContainerFrame:GetChildren()) do
													if child:IsA("TextButton") then
														local attribute = child:GetAttribute(v85[8])

														if attribute == value or attribute == value2 then
															local v113 = child:FindFirstChild(v85[121])
															local v114 = child:FindFirstChild(v85[96])
															local flag18 = attribute == value

															if v113 then
																fn37(v113, {
																	TextColor3 = flag18 and arg.Library.config.Colors.AccentLight or arg.Library.config.Colors.SubText,
																}, 0.2)
															end

															if v114 then
																fn37(v114, {
																	Position = flag18 and UDim2.new(1, -v85[153], 0.5, v85[33]) or UDim2.new(1, 30, 0.5, 0),
																}, v85[113], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
															end
														end
													end
												end

												if not arg2.NoSave then
													tbl19.Dropdowns[dropdown] = value
													fn34()
												end

												arg2.Callback(value)

												if flyteBBState and flyteBBState.RefreshKeybinds then
													task.defer(flyteBBState.RefreshKeybinds)
												end
											end

											local v110 = fn52()
											tbl27.holderWidth = v110

											tbl27.buttonFrame = fn45(v85[170], {
												Name = "DropdownButton",
												Active = v85[200],
												BackgroundColor3 = arg.Library.config.Colors.Element,
												Position = UDim2.new(1, -v109 - v85[115], 0, elementYPos),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = UDim2.new(v85[33], v109, 0, 21),
												Parent = arg.mainFrame,
											})

											if arg2.Detachable then
												tbl27.dockFrame = fn45("Frame", {
													Name = "DropdownDock",
													BackgroundTransparency = v85[18],
													Position = tbl27.buttonFrame.Position,
													Size = tbl27.buttonFrame.Size,
													Parent = arg.mainFrame,
												})

												fn45("UICorner", { CornerRadius = UDim.new(v85[33], 8), Parent = tbl27.dockFrame })

												tbl27.dockStroke = fn45("UIStroke", {
													Color = arg.Library.config.Colors.AccentLight,
													Thickness = 1.5,
													Transparency = 1,
													ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
													Parent = tbl27.dockFrame,
												})
											end

											fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(0, 8), Parent = tbl27.buttonFrame })
											local UIStroke = fn45("UIStroke", { Name = "UIStroke", Color = arg.Library.config.Colors.BorderSoft, Parent = tbl27.buttonFrame })

											tbl27.selectedLabelText = fn45("TextLabel", {
												Name = "SelectedLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = v107,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(v85[33], 8, 0, 0),
												BorderSizePixel = 0,
												BorderColor3 = Color3.new(),
												TextSize = 14,
												Size = UDim2.new(1, -28, 1, v85[33]),
												TextXAlignment = Enum.TextXAlignment.Left,
												TextTruncate = Enum.TextTruncate.AtEnd,
												Parent = tbl27.buttonFrame,
											})

											tbl27.arrowImg = fn45("ImageLabel", {
												Name = "DropdownArrow",
												ImageColor3 = arg.Library.config.Colors.Muted,
												BackgroundColor3 = arg.Library.config.Colors.White,
												Image = "rbxassetid://127296511745226",
												BackgroundTransparency = 1,
												Position = UDim2.new(1, -v85[30], 0.5, -7),
												BorderColor3 = Color3.new(),
												BorderSizePixel = 0,
												Size = UDim2.new(0, 14, 0, v85[46]),
												Parent = tbl27.buttonFrame,
											})

											fn45("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = tbl27.arrowImg })
											local flag18 = not arg2.NoSearch and #arg2.Options >= v85[35]
											local n32 = flag18 and 30 or 0

											tbl27.optionHolderFrame = fn45("Frame", {
												Name = "DropdownOptionHolder",
												Active = true,
												BackgroundColor3 = arg.Library.config.Colors.Element,
												Position = UDim2.new(0, 0, 0, v85[33]),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = UDim2.new(0, v110, 0, v85[33]),
												ClipsDescendants = true,
												Visible = false,
												ZIndex = 9999,
												Parent = arg.Library.dropdownHolderRef,
											})

											table.insert(arg.Library.dropdownFrames, tbl27.optionHolderFrame)
											tbl27.holderScale = fn45("UIScale", { Name = "DropdownHolderScale", Scale = v85[198], Parent = tbl27.optionHolderFrame })
											fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, v85[35]), Parent = tbl27.optionHolderFrame })
											fn45("UIStroke", { Name = "UIStroke", Color = arg.Library.config.Colors.BorderSoft, Parent = tbl27.optionHolderFrame })
											local str6 = ""

											if flag18 then
												local Frame = fn45("Frame", {
													Name = "SearchFrame",
													BackgroundColor3 = arg.Library.config.Colors.Element,
													BackgroundTransparency = v85[33],
													Position = UDim2.new(0, 8, 0, v85[157]),
													Size = UDim2.new(v85[18], -16, 0, 24),
													BorderSizePixel = v85[33],
													ZIndex = 10005,
													Parent = tbl27.optionHolderFrame,
												})

												fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = Frame })

												fn45(v85[131], {
													Name = "SearchStroke",
													Color = arg.Library.config.Colors.BorderSoft,
													Thickness = 1,
													Parent = Frame,
												})

												fn45("ImageLabel", {
													Name = v85[38],
													Image = "rbxassetid://117707949657765",
													ImageColor3 = arg.Library.config.Colors.Muted,
													BackgroundTransparency = 1,
													Position = UDim2.new(0, 6, 0.5, -6),
													Size = UDim2.new(0, 12, v85[33], v85[49]),
													ZIndex = v85[34],
													Parent = Frame,
												})

												tbl27.searchBox = fn45("TextBox", {
													Name = v85[194],
													FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
													TextColor3 = arg.Library.config.Colors.Text,
													PlaceholderText = "search...",
													PlaceholderColor3 = arg.Library.config.Colors.Muted,
													Text = "",
													TextSize = 14,
													BackgroundTransparency = v85[18],
													Position = UDim2.new(0, v85[19], 0, v85[33]),
													Size = UDim2.new(1, -30, 1, 0),
													TextXAlignment = Enum.TextXAlignment.Left,
													ClearTextOnFocus = false,
													ZIndex = 10006,
													Parent = Frame,
												})
											end

											tbl27.optionContainerFrame = fn45("ScrollingFrame", {
												Name = v85[28],
												BackgroundTransparency = 1,
												Position = UDim2.new(0, 0, v85[33], flag18 and n32 + 4 or 0),
												Size = UDim2.new(1, 0, 1, flag18 and -(n32 + 4) or 0),
												ZIndex = 10000,
												ScrollBarThickness = 3,
												ScrollBarImageColor3 = arg.Library.config.Colors.Muted,
												ScrollBarImageTransparency = 0.5,
												AutomaticCanvasSize = Enum.AutomaticSize.Y,
												CanvasSize = UDim2.new(0, 0, 0, 0),
												Parent = tbl27.optionHolderFrame,
											})

											fn45("UIPadding", {
												Name = "DropdownPadding",
												PaddingTop = UDim.new(0, flag18 and 4 or 8),
												PaddingBottom = UDim.new(0, 8),
												PaddingLeft = UDim.new(0, 12),
												PaddingRight = UDim.new(0, v85[49]),
												Parent = tbl27.optionContainerFrame,
											})

											fn45("UIListLayout", {
												Name = "DropdownListLayout",
												Padding = UDim.new(0, 7),
												SortOrder = Enum.SortOrder.LayoutOrder,
												Parent = tbl27.optionContainerFrame,
											})

											local function fn55(arg3)
												for _, child in pairs(tbl27.optionContainerFrame:GetChildren()) do
													if child:IsA("TextLabel") or child:IsA(v85[39]) then
														child:Destroy()
													end
												end

												local tbl28 = {}

												if arg3 and arg3 ~= "" then
													local v111 = string.lower(arg3)

													for _, option in ipairs(arg2.Options) do
														if #tbl28 < v85[169] and string.find(string.lower(option), v111, 1, true) then
															table.insert(tbl28, option)
														end
													end
												else
													for i = 1, math.min(#arg2.Options, v85[169]) do
														table.insert(tbl28, arg2.Options[i])
													end
												end

												local n33 = #arg2.Options
												local flag19 = n33 > 50

												if flag19 then
													flag19 = not (arg3 and arg3 ~= "")
												end

												if flag19 then
													local n34 = n33 - v85[169]

													fn45(v85[65], {
														Name = "TruncationHint",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = arg.Library.config.Colors.Muted,
														Text = "... and " .. n34 .. " more (use search)",
														BackgroundTransparency = 1,
														BorderSizePixel = 0,
														TextSize = 11,
														Size = UDim2.new(1, 0, 0, 16),
														TextXAlignment = Enum.TextXAlignment.Left,
														ZIndex = v85[86],
														LayoutOrder = 51,
														Parent = tbl27.optionContainerFrame,
													})
												end

												for i, v111 in ipairs(tbl28) do
													local flag20 = tbl27.value == v111

													local TextButton = fn45("TextButton", {
														Name = "OptionClickButton",
														Text = "",
														AutoButtonColor = false,
														BackgroundTransparency = 1,
														BorderSizePixel = v85[33],
														Size = UDim2.new(v85[18], 0, v85[33], v85[108]),
														LayoutOrder = i,
														ZIndex = 10002,
														Parent = tbl27.optionContainerFrame,
													})

													TextButton:SetAttribute("OptionValue", v111)
													local v112 = fn50(v111)

													local TextLabel = fn45("TextLabel", {
														Name = v85[121],
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = flag20 and arg.Library.config.Colors.AccentLight or arg.Library.config.Colors.SubText,
														Text = v111,
														BackgroundColor3 = arg.Library.config.Colors.White,
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 0, 0, 0),
														BorderSizePixel = 0,
														BorderColor3 = Color3.new(),
														TextSize = 14,
														Size = UDim2.new(1, -v85[19], 1, v85[33]),
														TextXAlignment = Enum.TextXAlignment.Left,
														ZIndex = v85[86],
														Parent = TextButton,
													})

													local v113 = createKeybindPill(TextButton, v112, function(arg4)
														TextLabel.Size = UDim2.new(1, -(arg4 + 44), v85[18], 0)
														return UDim2.new(v85[18], -arg4 - 28, 0.5, -7)
													end, 15, 10004, nil, {
														Group = str5,
														Name = v111,
														Parent = groupConfig.Name,
														DisplayMode = "select",
														GetState = function()
															return tbl27.value == v111
														end,
													})

													fn45("ImageLabel", {
														Name = "OptionCheck",
														Image = "rbxassetid://114461119629011",
														ImageColor3 = arg.Library.config.Colors.AccentLight,
														BackgroundTransparency = 1,
														AnchorPoint = Vector2.new(1, 0.5),
														Position = flag20 and UDim2.new(1, -4, v85[81], 0) or UDim2.new(1, v85[36], 0.5, v85[33]),
														Size = UDim2.new(v85[33], 14, v85[33], 14),
														BorderSizePixel = 0,
														ZIndex = 10003,
														Parent = TextButton,
													})

													TextButton.MouseButton1Click:Connect(function()
														fn54(v111)
													end)

													TextButton.InputBegan:Connect(function(input)
														if input.UserInputType == Enum.UserInputType.MouseButton2 and v113 then
															v113:OpenMode(input.Position)
														end
													end)

													TextButton.MouseEnter:Connect(function()
														if not tbl27.isOpen then
															return
														end

														if tbl27.value ~= v111 then
															fn37(TextLabel, { TextColor3 = arg.Library.config.Colors.TextHover }, 0.2)
														end
													end)

													TextButton.MouseLeave:Connect(function()
														if not tbl27.isOpen then
															return
														end

														if tbl27.value ~= v111 then
															fn37(TextLabel, { TextColor3 = arg.Library.config.Colors.SubText }, 0.2)
														end
													end)
												end
											end

											tbl27.optionsBuilt = v85[101]

											if flag18 and tbl27.searchBox then
												tbl27.searchBox:GetPropertyChangedSignal(v85[133]):Connect(function()
													str6 = string.lower(tbl27.searchBox.Text)
													fn55(str6 ~= "" and str6 or nil)
												end)
											end

											local v111 = fn45(v85[39], {
												Name = "DropdownClickButton",
												Text = "",
												AutoButtonColor = false,
												BackgroundTransparency = 1,
												BorderSizePixel = 0,
												Size = UDim2.new(1, 0, v85[18], 0),
												ZIndex = 100,
												Parent = tbl27.buttonFrame,
											})

											tbl27.detached = false
											local position = nil
											local absolutePosition = nil
											local v112 = nil
											local n33 = nil
											local flag19 = false
											local flag20 = false
											local flag21 = nil
											local v113 = nil

											local function fn56(arg3, arg4)
												local absolutePosition2 = arg3.AbsolutePosition
												local absoluteSize = arg3.AbsoluteSize
												local absolutePosition3 = arg4.AbsolutePosition
												local absoluteSize2 = arg4.AbsoluteSize
												return absolutePosition2.X <= absolutePosition3.X + absoluteSize2.X and absolutePosition2.X + absoluteSize.X >= absolutePosition3.X and absolutePosition2.Y <= absolutePosition3.Y + absoluteSize2.Y and absolutePosition2.Y + absoluteSize.Y >= absolutePosition3.Y
											end

											local function fn57(arg3)
												if not tbl27.dockStroke then
													return
												end
												arg3 = arg3 and arg.Library.isToggledOn == true
												if v113 == arg3 then
													return
												end
												v113 = arg3
												fn37(tbl27.dockStroke, { Transparency = arg3 and 0.1 or 1 }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
											end

											local function fn58()
												if tbl27.detached then
													return
												end
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
												local absolutePosition2 = tbl27.buttonFrame.AbsolutePosition
												tbl27.buttonFrame.Parent = arg.Library.dropdownHolderRef
												tbl27.buttonFrame.Position = UDim2.fromOffset(absolutePosition2.X / scale, absolutePosition2.Y / scale)
												tbl27.detached = v85[200]

												if arg.Library.detachedDropdowns then
													arg.Library.detachedDropdowns[tbl27] = true
												end
											end

											local function fn59(arg3)
												if not tbl27.detached or flag21 then
													return
												end
												flag21 = true
												fn57(false)
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
												local absolutePosition2 = tbl27.dockFrame.AbsolutePosition

												fn37(tbl27.buttonFrame, { Position = UDim2.fromOffset(absolutePosition2.X / scale, absolutePosition2.Y / scale) }, v85[136], Enum.EasingStyle.Quint, Enum.EasingDirection.Out).Completed:Once(function()
													if not tbl27.buttonFrame or not tbl27.buttonFrame.Parent then
														return
													end
													tbl27.buttonFrame.Parent = arg.mainFrame
													tbl27.buttonFrame.Position = tbl27.dockFrame.Position
													tbl27.buttonFrame.Visible = v85[200]
													tbl27.detached = false

													if arg.Library.detachedDropdowns then
														arg.Library.detachedDropdowns[tbl27] = nil
													end

													flag21 = false

													if arg3 then
														tbl27:Close()
													end
												end)
											end

											if arg2.Detachable then
												v111.InputBegan:Connect(function(input)
													if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
														return
													end
													position = input.Position
													absolutePosition = tbl27.buttonFrame.AbsolutePosition
													v112 = input
													n33 = input.UserInputType == Enum.UserInputType.Touch and 14 or v85[174]
													flag19 = v85[101]
													flag20 = v85[101]
												end)

												fn44(v87.InputChanged:Connect(function(input)
													if not v112 or input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
														return
													end

													if input.UserInputType == Enum.UserInputType.Touch and input ~= v112 then
														return
													end
													local n34 = input.Position - position
													if not flag19 and n34.Magnitude < n33 then
														return
													end

													if not flag19 then
														flag19 = v85[200]
														flag20 = true
														fn58()
													end

													local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
													tbl27.buttonFrame.Position = UDim2.fromOffset((absolutePosition.X + n34.X) / scale, (absolutePosition.Y + n34.Y) / scale)
													fn57(fn56(tbl27.buttonFrame, tbl27.dockFrame))
												end))

												fn44(v87.InputEnded:Connect(function(input)
													if input ~= v112 then
														return
													end
													v112 = nil
													if not flag19 then
														return
													end

													if arg.Library.isToggledOn and fn56(tbl27.buttonFrame, tbl27.dockFrame) then
														fn59(v85[101])
													else
														fn57(false)
													end
												end))
											end

											local function fn60()
												local absolutePosition2 = tbl27.buttonFrame.AbsolutePosition
												local absoluteSize = tbl27.buttonFrame.AbsoluteSize
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
												fn37(tbl27.optionHolderFrame, { Position = UDim2.new(v85[33], absolutePosition2.X / scale, 0, (absolutePosition2.Y + absoluteSize.Y + 10) / scale) }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
											end

											tbl27.followConn = nil
											tbl27.outsideConn = nil

											local function fn61(arg3, arg4)
												local absolutePosition2 = arg3.AbsolutePosition
												local absoluteSize = arg3.AbsoluteSize
												return arg4.X >= absolutePosition2.X and arg4.X <= absolutePosition2.X + absoluteSize.X and arg4.Y >= absolutePosition2.Y and arg4.Y <= absolutePosition2.Y + absoluteSize.Y
											end

											tbl27.Open = function()
												if tbl27.isOpen then
													return
												end
												arg2.OnOpen()

												if not tbl27.optionsBuilt then
													if not flag18 then
														fn55()
													end

													tbl27.optionsBuilt = true
												end

												for k in pairs(arg.Library.openDropdowns) do
													if k ~= tbl27 and k.Close then
														k:Close()
													end
												end

												tbl27.isOpen = true
												tbl27.optionHolderFrame.Parent = arg.Library.dropdownHolderRef
												local absolutePosition2 = tbl27.buttonFrame.AbsolutePosition
												local absoluteSize = tbl27.buttonFrame.AbsoluteSize
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1
												tbl27.optionHolderFrame.Position = UDim2.new(v85[33], absolutePosition2.X / scale, v85[33], (absolutePosition2.Y + absoluteSize.Y) / scale)
												tbl27.optionHolderFrame.Size = UDim2.new(v85[33], tbl27.holderWidth, v85[33], v85[33])
												tbl27.optionHolderFrame.Visible = v85[200]
												tbl27.holderScale.Scale = 0.9
												local n34 = math.min(#arg2.Options, 50)
												local n35 = math.min(16 + n34 * 20 + math.max(n34 - 1, 0) * 7 + (flag18 and n32 + 4 or 0), 300)

												if flag18 and tbl27.searchBox then
													tbl27.searchBox.Text = ""
													str6 = ""
													fn55()
												end

												fn37(tbl27.optionHolderFrame, {
													Position = UDim2.new(v85[33], absolutePosition2.X / scale, 0, (absolutePosition2.Y + absoluteSize.Y + 10) / scale),
													Size = UDim2.new(0, tbl27.holderWidth, 0, n35),
												}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

												fn37(tbl27.holderScale, { Scale = v85[18] }, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
												fn37(tbl27.arrowImg, { Rotation = -v85[91] }, 0.25)

												if tbl27.followConn then
													tbl27.followConn:Disconnect()
												end

												tbl27.followConn = tbl27.buttonFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(fn60)
												fn48(tbl27.outsideConn)

												tbl27.outsideConn = fn44(v87.InputBegan:Connect(function(input)
													if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
														return
													end

													if not tbl27.isOpen then
														return
													end

													if tbl27.detached then
														return
													end

													if fn61(tbl27.buttonFrame, input.Position) or fn61(tbl27.optionHolderFrame, input.Position) then
														return
													end
													tbl27:Close()
												end))

												arg.Library.openDropdowns[tbl27] = tbl27
											end

											tbl27.Close = function()
												if not tbl27.isOpen then
													return
												end
												tbl27.isOpen = false
												local absolutePosition2 = tbl27.buttonFrame.AbsolutePosition
												local absoluteSize = tbl27.buttonFrame.AbsoluteSize
												local scale = arg.Library.dropdownHolderScale and arg.Library.dropdownHolderScale.Scale or 1

												fn37(tbl27.optionHolderFrame, {
													Position = UDim2.new(0, absolutePosition2.X / scale, 0, (absolutePosition2.Y + absoluteSize.Y - 10) / scale),
													Size = UDim2.new(0, tbl27.holderWidth, 0, 0),
												}, v85[100], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

												fn37(tbl27.holderScale, { Scale = v85[198] }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
												fn37(tbl27.arrowImg, { Rotation = 0 }, 0.3)

												if tbl27.followConn then
													tbl27.followConn:Disconnect()
													tbl27.followConn = nil
												end

												if tbl27.outsideConn then
													fn48(tbl27.outsideConn)
													tbl27.outsideConn = nil
												end

												arg.Library.openDropdowns[tbl27] = nil

												task.delay(0.3, function()
													if not tbl27.isOpen and tbl27.optionHolderFrame then
														tbl27.optionHolderFrame.Visible = false
														tbl27.optionHolderFrame.Parent = nil
													end
												end)

												fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, v85[113])
												fn37(UIStroke, { Color = arg.Library.config.Colors.BorderSoft }, 0.2)
												fn37(tbl27.selectedLabelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.2)
												fn37(tbl27.arrowImg, { ImageColor3 = arg.Library.config.Colors.Muted }, 0.2)
											end

											v111.MouseButton1Click:Connect(function()
												if flag20 then
													return
												end

												if tbl27.isOpen then
													tbl27:Close()
												else
													tbl27:Open()
												end
											end)

											v111.MouseEnter:Connect(function()
												fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.ElementHover }, 0.2)
												fn37(UIStroke, { Color = arg.Library.config.Colors.Border }, 0.2)
												fn37(tbl27.selectedLabelText, { TextColor3 = arg.Library.config.Colors.TextHover }, v85[113])
												fn37(tbl27.arrowImg, { ImageColor3 = arg.Library.config.Colors.TextHover }, 0.2)
											end)

											v111.MouseLeave:Connect(function()
												if tbl27.isOpen then
													return
												end
												fn37(tbl27.buttonFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.2)
												fn37(UIStroke, { Color = arg.Library.config.Colors.BorderSoft }, 0.2)
												fn37(tbl27.selectedLabelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.2)
												fn37(tbl27.arrowImg, { ImageColor3 = arg.Library.config.Colors.Muted }, v85[113])
											end)

											tbl27.Set = function(arg3, value)
												local flag22 = nil

												for _, v114 in arg2.Options, nil, nil do
													if value == v114 then
														flag22 = true
														break
													else
														flag22 = nil
													end
												end

												value = flag22 and value or arg2.Default
												local value2 = tbl27.value
												tbl27.value = value
												local v114, v115, v116 = fn51()
												tbl27.selectedLabelText.Text = v114
												fn53(v115, v116)

												for _, child in pairs(tbl27.optionContainerFrame:GetChildren()) do
													if child:IsA("TextButton") then
														local attribute = child:GetAttribute("OptionValue")

														if attribute == value or attribute == value2 then
															local v117 = child:FindFirstChild(v85[121])
															local optionCheck = child:FindFirstChild("OptionCheck")
															local flag23 = attribute == tbl27.value

															if v117 then
																v117.TextColor3 = flag23 and arg.Library.config.Colors.AccentLight or arg.Library.config.Colors.SubText
															end

															if optionCheck then
																optionCheck.Position = flag23 and UDim2.new(v85[18], -4, v85[81], 0) or UDim2.new(1, 30, 0.5, v85[33])
															end
														end
													end
												end

												if not arg2.NoSave then
													tbl19.Dropdowns[dropdown] = value
													fn34()
												end

												arg2.Callback(value)

												if flyteBBState and flyteBBState.RefreshKeybinds then
													task.defer(flyteBBState.RefreshKeybinds)
												end
											end

											tbl27.Refresh = function(arg3, options)
												arg2.Options = options
												tbl27.optionsBuilt = v85[200]
												tbl27.holderWidth = fn52()
												local v114, v115, v116 = fn51()
												tbl27.selectedLabelText.Text = v114
												fn53(v115, v116)
												tbl27.optionHolderFrame.Size = UDim2.new(0, tbl27.holderWidth, v85[33], tbl27.optionHolderFrame.Size.Y.Offset)
												fn55()
											end

											tbl27:Set(tbl27.value)
											tbl27.optionHolderFrame.Parent = nil
											local value = nil

											for _, option in ipairs(arg2.Options) do
												local v114 = fn50(option)

												tbl12.SetMeta(v114, {
													Group = str5,
													Name = option,
													Parent = groupConfig.Name,
													DisplayMode = "select",
													GetState = function()
														return tbl27.value == option
													end,
												})

												tbl12.Register(v114, function(arg3, arg4)
													if arg4 == v85[99] then
														if arg3 then
															value = tbl27.value
															fn54(option)
															return
														end

														if value and value ~= option then
															fn54(value)
														end

														value = nil
														return
													end

													if arg3 then
														fn54(option)
													end
												end)
											end

											arg.elementYPos = arg.elementYPos + 28
											updateSize()
											table.insert(arg.elementsInGroup, tbl27)
											return tbl27
										end

										local function addTextbox(arg, arg2)
											local v105 = obj[arg]
											local tabConfig = v105.TabConfig
											local groupConfig = v105.GroupConfig
											local updateSize = v105.UpdateSize
											arg2 = arg2 or {}
											arg2.Name = arg2.Name or "Textbox"
											arg2.Placeholder = arg2.Placeholder or ""
											arg2.Default = arg2.Default or ""

											arg2.Callback = arg2.Callback or function()
											end

											local tbl27 = {}
											local v106 = fn31(arg2.SaveId or tabConfig.Name .. ":" .. groupConfig.Name .. ":" .. arg2.Name)
											local v107 = fn46(tbl19.Textboxes, v106, arg2.NoSave)
											local v108 = v85[127]
											tbl27.value = type(v107) == v108 and v107 or arg2.Default
											tbl27.SaveId = v106
											tbl27.DefaultValue = arg2.Default
											local elementYPos = arg.elementYPos

											tbl27.labelText = fn45("TextLabel", {
												Name = "TextboxLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = arg2.Name,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, v85[115], v85[33], elementYPos),
												BorderSizePixel = 0,
												BorderColor3 = Color3.new(),
												TextSize = 14,
												Size = UDim2.new(0, 130, 0, 20),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = arg.mainFrame,
											})

											tbl27.inputFrame = fn45("Frame", {
												Name = v85[87],
												BackgroundColor3 = arg.Library.config.Colors.Element,
												Position = UDim2.new(v85[33], 10, 0, elementYPos + 22),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = UDim2.new(0, 238, 0, 26),
												Parent = arg.mainFrame,
											})

											fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = tbl27.inputFrame })
											local v109 = fn45(v85[131], { Name = "UIStroke", Color = arg.Library.config.Colors.BorderSoft, Parent = tbl27.inputFrame })
											local v110 = fn45
											local tbl28 = { Name = "UIGradient" }
											local colorSequence = ColorSequence.new
											local tbl29 = {}
											local v111 = ColorSequenceKeypoint.new(v85[33], arg.Library.config.Colors.Text)
											local v112 = ColorSequenceKeypoint.new(0.493, arg.Library.config.Colors.AccentLight)
											local v113 = ColorSequenceKeypoint.new(0.509, arg.Library.config.Colors.AccentLight)
											tbl29[1] = v111
											tbl29[2] = v112
											tbl29[3] = v113

											do
												local values = table.pack(ColorSequenceKeypoint.new(1, arg.Library.config.Colors.Text))
												table.move(values, 1, values.n, 4, tbl29)
											end

											tbl28.Color = colorSequence(tbl29)
											tbl28.Rotation = 260
											tbl28.Parent = v109
											v110("UIGradient", tbl28)

											tbl27.textbox = fn45(v85[9], {
												Name = "TextboxInput",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.Text,
												PlaceholderColor3 = arg.Library.config.Colors.SubText,
												Text = tbl27.value,
												PlaceholderText = arg2.Placeholder,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, 8, 0, v85[33]),
												BorderSizePixel = v85[33],
												BorderColor3 = Color3.new(),
												TextSize = v85[11],
												Size = UDim2.new(1, -v85[30], 1, 0),
												TextXAlignment = Enum.TextXAlignment.Left,
												ClearTextOnFocus = v85[101],
												TextEditable = true,
												Parent = tbl27.inputFrame,
											})

											tbl27.Set = function(arg3, arg4)
												tbl27.value = tostring(arg4 or "")
												tbl27.textbox.Text = tbl27.value

												if not arg2.NoSave then
													tbl19.Textboxes[v106] = tbl27.value
													fn34()
												end

												arg2.Callback(tbl27.value)
											end

											local tbl30 = {}

											local function fn50()
												local parent = tbl27.textbox.Parent

												while parent and parent ~= game do
													if parent:IsA("ScrollingFrame") and parent.ScrollingEnabled then
														parent.ScrollingEnabled = false
														table.insert(tbl30, parent)
													end

													parent = parent.Parent
												end
											end

											local function fn51()
												for _, v114 in ipairs(tbl30) do
													if v114 and v114.Parent then
														v114.ScrollingEnabled = v85[200]
													end
												end

												table.clear(tbl30)
											end

											local flag18 = false
											local v114 = nil
											local v115 = nil
											local connection = nil

											local function fn52(arg3)
												local textbox = tbl27.textbox
												local text = textbox.Text
												local cursorPosition = textbox.CursorPosition
												local selectionStart = textbox.SelectionStart

												if selectionStart and selectionStart > 0 and cursorPosition and cursorPosition > 0 and selectionStart ~= cursorPosition then
													local cursorPosition2 = math.min(selectionStart, cursorPosition)
													local v116 = v85[18]
													local n32 = math.max(selectionStart, cursorPosition) - v116
													textbox.Text = text:sub(1, cursorPosition2 - 1) .. text:sub(n32 + 1)
													textbox.CursorPosition = cursorPosition2
													textbox.SelectionStart = cursorPosition2
													return
												end

												if not cursorPosition or cursorPosition <= 1 then
													return
												end
												local cursorPosition2 = math.max(1, cursorPosition - arg3)
												textbox.Text = text:sub(1, cursorPosition2 - 1) .. text:sub(cursorPosition - 1 + 1)
												textbox.CursorPosition = cursorPosition2
												textbox.SelectionStart = cursorPosition2
											end

											local function fn53()
												local flag19 = flag18

												if not flag18 then
													local textbox = tbl27.textbox
													flag19 = v87:GetFocusedTextBox() ~= textbox
												end

												if flag19 then
													return
												end
												flag18 = true

												task.spawn(function()
													task.wait(0.35)
													local now2 = os.clock()

													while true do
														local flag20 = flag18

														if flag18 then
															local textbox = tbl27.textbox
															flag20 = v87:GetFocusedTextBox() == textbox
														end

														if flag20 then
															local n32 = os.clock() - now2
															local n33 = math.clamp(math.floor(n32 * n32 * 10) + 1, 1, 90)
															fn52(n33)
															task.wait(math.max(0.03, 0.08 - n32 * 0.01))
															continue
														end

														break
													end
												end)
											end

											local function fn54()
												flag18 = v85[101]
											end

											local function fn55()
												fn48(v114)
												fn48(v115)

												if connection then
													connection:Disconnect()
												end

												v114 = fn44(v87.InputBegan:Connect(function(input)
													local flag19 = input.KeyCode == Enum.KeyCode.Backspace

													if flag19 then
														local textbox = tbl27.textbox
														flag19 = v87:GetFocusedTextBox() == textbox
													end

													if flag19 then
														fn53()
													end
												end))

												v115 = fn44(v87.InputEnded:Connect(function(input)
													if input.KeyCode == Enum.KeyCode.Backspace then
														fn54()
													end
												end))

												connection = tbl27.textbox:GetPropertyChangedSignal("Text"):Connect(function()
													local textbox = tbl27.textbox

													if v87:GetFocusedTextBox() == textbox and v87:IsKeyDown(Enum.KeyCode.Backspace) then
														fn53()
													end
												end)
											end

											local function fn56()
												fn54()
												fn48(v114)
												v114 = nil
												fn48(v115)
												v115 = nil

												if connection then
													connection:Disconnect()
													connection = nil
												end
											end

											tbl27.textbox.Focused:Connect(function()
												fn50()
												fn55()

												if touchEnabled then
													task.defer(function()
														local textbox = tbl27.textbox

														if v87:GetFocusedTextBox() == textbox then
															tbl27.textbox.CursorPosition = #tbl27.textbox.Text + 1
															tbl27.textbox.SelectionStart = v85[18]
														end
													end)
												end

												fn37(tbl27.inputFrame, { BackgroundColor3 = arg.Library.config.Colors.ElementHover }, 0.2)
												fn37(v109, { Color = arg.Library.config.Colors.Border }, 0.2)
												fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.Text }, v85[113])
												fn37(tbl27.textbox, { TextColor3 = arg.Library.config.Colors.Text }, v85[113])
											end)

											tbl27.textbox.FocusLost:Connect(function()
												fn56()
												fn51()
												tbl27.value = tbl27.textbox.Text
												fn37(tbl27.inputFrame, { BackgroundColor3 = arg.Library.config.Colors.Element }, 0.2)
												fn37(v109, { Color = arg.Library.config.Colors.BorderSoft }, 0.2)
												fn37(tbl27.labelText, { TextColor3 = arg.Library.config.Colors.SubText }, 0.2)
												fn37(tbl27.textbox, { TextColor3 = arg.Library.config.Colors.Text }, 0.2)

												if not arg2.NoSave then
													tbl19.Textboxes[v106] = tbl27.value
													fn34()
												end

												arg2.Callback(tbl27.value)
											end)

											arg2.Callback(tbl27.value)
											arg.elementYPos = arg.elementYPos + 56
											updateSize()
											table.insert(arg.elementsInGroup, tbl27)
											return tbl27
										end

										local function addDivider(arg)
											local updateSize = obj[arg].UpdateSize

											local Frame = fn45("Frame", {
												Name = v85[166],
												BackgroundColor3 = arg.Library.config.Colors.BorderSoft,
												BackgroundTransparency = 0.4,
												Position = UDim2.new(0, 14, 0, arg.elementYPos + 6),
												BorderSizePixel = v85[33],
												Size = UDim2.new(v85[18], -28, 0, 1),
												Parent = arg.mainFrame,
											})

											arg.elementYPos = arg.elementYPos + 14
											updateSize()
											return Frame
										end

										local function addSection(arg, arg2)
											local updateSize = obj[arg].UpdateSize
											arg2 = arg2 or "Section"
											local n32 = arg.elementYPos + v85[115]

											local v105 = fn45(v85[170], {
												Name = "SectionAccentBar",
												BackgroundColor3 = arg.Library.config.AccentColor,
												BorderSizePixel = v85[33],
												Position = UDim2.new(v85[33], 10, 0, n32 + 4),
												Size = UDim2.new(v85[33], v85[70], v85[33], v85[49]),
												Parent = arg.mainFrame,
											})

											fn45("UICorner", { CornerRadius = UDim.new(1, 0), Parent = v105 })

											fn45("UIGradient", {
												Name = "SectionAccentGradient",
												Color = ColorSequence.new({
													ColorSequenceKeypoint.new(0, arg.Library.config.AccentColor),
													ColorSequenceKeypoint.new(1, arg.Library.config.Colors.AccentLight),
												}),
												Rotation = 90,
												Parent = v105,
											})

											fn45("TextLabel", {
												Name = "SectionLabel",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.Text,
												Text = arg2,
												BackgroundTransparency = v85[18],
												Position = UDim2.new(v85[33], 18, 0, n32),
												BorderSizePixel = 0,
												TextSize = v85[49],
												Size = UDim2.new(v85[18], -v85[185], 0, v85[108]),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = arg.mainFrame,
											})

											fn45("Frame", {
												Name = v85[94],
												BackgroundColor3 = arg.Library.config.Colors.BorderSoft,
												BackgroundTransparency = 0.5,
												BorderSizePixel = 0,
												Position = UDim2.new(0, 18, 0, n32 + v85[197]),
												Size = UDim2.new(v85[18], -36, 0, 1),
												Parent = arg.mainFrame,
											})

											arg.elementYPos = n32 + 30
											updateSize()
										end

										local function addLabel(arg, arg2)
											local updateSize = obj[arg].UpdateSize
											arg2 = arg2 or {}
											arg2.Text = arg2.Text or "Label"
											local elementYPos = arg.elementYPos

											local v105 = fn45(v85[65], {
												Name = v85[60],
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.SubText,
												Text = arg2.Text,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(v85[33], 10, 0, elementYPos),
												BorderSizePixel = 0,
												BorderColor3 = Color3.new(),
												TextSize = v85[46],
												Size = UDim2.new(0.92, v85[33], 0, 20),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = arg.mainFrame,
											})

											arg.elementYPos = arg.elementYPos + 24
											updateSize()
											return v105
										end

										addGroup = function(arg, arg2)
											local config = arg.Config
											arg2 = arg2 or {}
											arg2.Name = arg2.Name or v85[1]
											arg2.Side = arg2.Side or "Left"
											arg2.Icon = arg2.Icon or "rbxassetid://10723427199"
											local tbl27 = { elementsInGroup = {}, Library = arg.Library, elementYPos = 35 }
											local leftColumnFrame = arg2.Side == v85[150] and arg.leftColumnFrame or arg.rightColumnFrame

											tbl27.mainFrame = fn45("Frame", {
												Name = v85[176],
												Active = true,
												BackgroundColor3 = arg.Library.config.Colors.Secondary,
												Position = UDim2.new(0, v85[18], 0, 0),
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = UDim2.new(0, 260, 0, 50),
												Parent = leftColumnFrame,
											})

											local UIStroke = fn45("UIStroke", { Name = v85[131], Color = arg.Library.config.Colors.BorderSoft, Parent = tbl27.mainFrame })
											local v105 = fn45
											local tbl28 = { Name = "UIGradient" }
											local colorSequence = ColorSequence.new
											local tbl29 = {}
											local v106 = ColorSequenceKeypoint.new(0, arg.Library.config.Colors.Text)
											local v107 = ColorSequenceKeypoint.new(0.493, arg.Library.config.Colors.AccentLight)
											local v108 = ColorSequenceKeypoint.new(0.509, arg.Library.config.Colors.AccentLight)
											tbl29[1] = v106
											tbl29[2] = v107
											tbl29[3] = v108

											do
												local values = table.pack(ColorSequenceKeypoint.new(v85[18], arg.Library.config.Colors.Text))
												table.move(values, 1, values.n, 4, tbl29)
											end

											tbl28.Color = colorSequence(tbl29)
											tbl28.Rotation = v85[68]
											tbl28.Parent = UIStroke
											v105("UIGradient", tbl28)
											fn45(v85[137], { Name = v85[137], CornerRadius = UDim.new(0, 11), Parent = tbl27.mainFrame })

											fn45("UIAspectRatioConstraint", {
												Name = "UIAspectRatioConstraint",
												Parent = fn45("ImageLabel", {
													Name = "GroupIcon",
													BorderColor3 = arg.Library.config.Colors.Black,
													BackgroundColor3 = arg.Library.config.Colors.White,
													Image = arg2.Icon,
													BackgroundTransparency = 1,
													Position = UDim2.new(0, 10, 0, 10),
													BorderSizePixel = v85[33],
													Size = UDim2.new(v85[33], 16, 0, 16),
													Parent = tbl27.mainFrame,
												}),
											})

											fn45("TextLabel", {
												Name = "GroupName",
												FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
												TextColor3 = arg.Library.config.Colors.Text,
												Text = arg2.Name,
												BackgroundColor3 = arg.Library.config.Colors.White,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, 32, v85[33], v85[35]),
												BorderSizePixel = 0,
												BorderColor3 = Color3.new(),
												TextSize = 15,
												Size = UDim2.new(0, 100, 0, 16),
												TextXAlignment = Enum.TextXAlignment.Left,
												Parent = tbl27.mainFrame,
											})

											local function updateSize(arg3)
												local n32 = tbl27.elementYPos + 10

												if arg3 and arg3 > v85[33] then
													fn37(tbl27.mainFrame, { Size = UDim2.new(0, 260, 0, n32) }, arg3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
												else
													tbl27.mainFrame.Size = UDim2.new(0, 260, 0, n32)
												end
											end

											tbl27.UpdateSize = updateSize

											obj[tbl27] = {
												TabConfig = config,
												GroupConfig = arg2,
												UpdateSize = updateSize,
												CreateKeybindPill = function(arg3, arg4, arg5, arg6, arg7, arg8, arg9)
													local tbl30 = arg9 or {}
													local tbl31 = {}
													local v109 = tbl12.Get(arg4)
													local str5 = v109 == Enum.KeyCode.Unknown and "" or tbl12.Display(v109)
													local v110 = arg6 or v85[186]

													if tbl30.Group then
														tbl12.SetMeta(arg4, {
															Group = tbl30.Group,
															Name = tbl30.Name or arg4,
															Parent = tbl30.Parent,
															DisplayMode = tbl30.DisplayMode,
															GetState = tbl30.GetState,
														})
													end

													local function fn50(arg10)
														return math.max(fn47(arg10, 11, Enum.Font.GothamSemibold) + 24, tbl30.MinWidth or 0)
													end

													local function fn51(arg10)
														if typeof(arg5) == "function" then
															return arg5(arg10)
														end
														return arg5
													end

													local v111 = fn50(str5)

													tbl31.frame = fn45("Frame", {
														Name = "KeybindPill",
														BackgroundColor3 = v109 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Surface or tbl27.Library.config.Colors.Element,
														BackgroundTransparency = v109 == Enum.KeyCode.Unknown and 0.25 or 0,
														Position = fn51(v111),
														BorderColor3 = tbl27.Library.config.Colors.Black,
														BorderSizePixel = 0,
														Size = UDim2.new(0, v111, 0, v110),
														ZIndex = arg7 or 5,
														ClipsDescendants = v85[200],
														Parent = arg3,
													})

													fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(1, 0), Parent = tbl31.frame })

													local UIStroke2 = fn45("UIStroke", {
														Name = v85[131],
														Color = tbl27.Library.config.Colors.BorderSoft,
														Transparency = v109 == Enum.KeyCode.Unknown and 0.35 or v85[33],
														Parent = tbl31.frame,
													})

													tbl31.label = fn45("TextLabel", {
														Name = "KeybindLabel",
														FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
														TextColor3 = v109 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														Text = str5,
														BackgroundTransparency = 1,
														Position = UDim2.new(0, 0, 0, v85[33]),
														BorderSizePixel = 0,
														TextSize = 11,
														Size = UDim2.new(v85[18], -18, 1, 0),
														TextXAlignment = Enum.TextXAlignment.Center,
														ZIndex = (arg7 or 5) + 1,
														Parent = tbl31.frame,
													})

													tbl31.keyboardIconImg = fn45("ImageLabel", {
														Name = "KeyboardIcon",
														ImageColor3 = v109 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														BackgroundColor3 = tbl27.Library.config.Colors.White,
														Image = "rbxassetid://10723416765",
														BackgroundTransparency = v85[18],
														Position = v109 == Enum.KeyCode.Unknown and UDim2.new(v85[81], -5.5, v85[81], -5) or UDim2.new(1, -16, 0.5, -5),
														BorderColor3 = Color3.new(),
														BorderSizePixel = 0,
														Size = UDim2.new(0, v85[192], v85[33], v85[192]),
														ZIndex = (arg7 or 5) + 1,
														Parent = tbl31.frame,
													})

													fn45("UIAspectRatioConstraint", { Name = "UIAspectRatioConstraint", Parent = tbl31.keyboardIconImg })

													local v112 = fn45(v85[39], {
														Name = "KeybindHitbox",
														Text = "",
														AutoButtonColor = v85[101],
														BackgroundTransparency = v85[18],
														Size = UDim2.new(1, 0, 1, 0),
														ZIndex = (arg7 or 5) + v85[70],
														Parent = tbl31.frame,
													})

													local Frame = nil
													local UIScale = nil
													local TextButton = nil
													local TextButton2 = nil
													local v113 = nil

													local function fn52()
														if not TextButton or not TextButton2 then
															return
														end
														local v114 = tbl12.GetMode(arg4)

														fn37(TextButton, {
															BackgroundColor3 = v114 == "Hold" and tbl27.Library.config.AccentColor or tbl27.Library.config.Colors.Element,
														}, 0.22, Enum.EasingStyle.Quint)

														fn37(TextButton2, {
															BackgroundColor3 = v114 == "Toggle" and tbl27.Library.config.AccentColor or tbl27.Library.config.Colors.Element,
														}, 0.22, Enum.EasingStyle.Quint)
													end

													local function fn53()
														if not Frame then
															return
														end
														local v114 = Frame
														local v115 = UIScale

														if v113 then
															fn48(v113)
															v113 = nil
														end

														Frame = nil
														UIScale = nil
														TextButton = nil
														TextButton2 = nil

														if v115 then
															fn37(v115, { Scale = 0.9 }, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
														end

														task.delay(0.2, function()
															if v114 and v114.Parent then
																v114:Destroy()
															end
														end)
													end

													local function fn54(arg10)
														if Frame then
															fn53()
															return
														end
														fn53()
														local n32 = tbl31.frame.AbsolutePosition + Vector2.new(tbl31.frame.AbsoluteSize.X + 8, -v85[72])
														arg10 = arg10 or n32

														Frame = fn45("Frame", {
															Name = "KeybindModeWindow",
															BackgroundColor3 = tbl27.Library.config.Colors.Secondary,
															Position = UDim2.new(v85[33], arg10.X, 0, arg10.Y),
															BorderColor3 = tbl27.Library.config.Colors.Black,
															BorderSizePixel = 0,
															Size = UDim2.new(v85[33], 112, v85[33], v85[97]),
															ZIndex = 20000,
															Parent = tbl27.Library.dropdownHolderRef,
														})

														UIScale = fn45("UIScale", { Name = "KeybindModeScale", Scale = 0.9, Parent = Frame })
														fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(v85[33], 8), Parent = Frame })
														fn45("UIStroke", { Name = "UIStroke", Color = tbl27.Library.config.Colors.BorderSoft, Parent = Frame })

														local Frame2 = fn45("Frame", {
															Name = "ModeHolder",
															BackgroundTransparency = v85[18],
															Position = UDim2.new(0, v85[174], 0, 5),
															Size = UDim2.new(1, -10, 1, -10),
															ZIndex = 20001,
															Parent = Frame,
														})

														fn45("UIListLayout", {
															Name = "ModeList",
															FillDirection = Enum.FillDirection.Horizontal,
															Padding = UDim.new(0, 6),
															SortOrder = Enum.SortOrder.LayoutOrder,
															Parent = Frame2,
														})

														TextButton = fn45("TextButton", {
															Name = "HoldMode",
															Text = "Hold",
															AutoButtonColor = false,
															FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
															TextSize = v85[49],
															TextColor3 = tbl27.Library.config.Colors.Text,
															BackgroundColor3 = tbl27.Library.config.Colors.Element,
															BorderSizePixel = v85[33],
															Size = UDim2.new(0.5, -v85[61], v85[18], 0),
															ZIndex = 20002,
															Parent = Frame2,
														})

														TextButton2 = fn45("TextButton", {
															Name = "ToggleMode",
															Text = v85[4],
															AutoButtonColor = false,
															FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
															TextSize = 12,
															TextColor3 = tbl27.Library.config.Colors.Text,
															BackgroundColor3 = tbl27.Library.config.Colors.Element,
															BorderSizePixel = 0,
															Size = UDim2.new(0.5, -3, 1, 0),
															ZIndex = 20002,
															Parent = Frame2,
														})

														fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(v85[33], 6), Parent = TextButton })
														fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 6), Parent = TextButton2 })

														TextButton.MouseButton1Click:Connect(function()
															tbl12.SetMode(arg4, "Hold")
															fn52()
														end)

														TextButton2.MouseButton1Click:Connect(function()
															tbl12.SetMode(arg4, v85[4])
															fn52()
														end)

														TextButton.MouseEnter:Connect(function()
															if tbl12.GetMode(arg4) ~= "Hold" then
																fn37(TextButton, { BackgroundColor3 = tbl27.Library.config.Colors.ElementHover }, 0.18)
															end
														end)

														TextButton.MouseLeave:Connect(fn52)

														TextButton2.MouseEnter:Connect(function()
															if tbl12.GetMode(arg4) ~= "Toggle" then
																fn37(TextButton2, { BackgroundColor3 = tbl27.Library.config.Colors.ElementHover }, v85[136])
															end
														end)

														TextButton2.MouseLeave:Connect(fn52)
														fn52()

														v113 = fn44(v87.InputBegan:Connect(function(input)
															if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
																return
															end

															if not Frame then
																return
															end
															local position = input.Position
															local absolutePosition = Frame.AbsolutePosition
															local absoluteSize = Frame.AbsoluteSize
															local absolutePosition2 = tbl31.frame.AbsolutePosition
															local absoluteSize2 = tbl31.frame.AbsoluteSize

															if not (position.X >= absolutePosition.X and position.X <= absolutePosition.X + absoluteSize.X and position.Y >= absolutePosition.Y and position.Y <= absolutePosition.Y + absoluteSize.Y) and not (position.X >= absolutePosition2.X and position.X <= absolutePosition2.X + absoluteSize2.X and position.Y >= absolutePosition2.Y and position.Y <= absolutePosition2.Y + absoluteSize2.Y) then
																fn53()
															end
														end))

														fn37(Frame, { Position = UDim2.new(0, n32.X, 0, n32.Y) }, 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
														fn37(UIScale, { Scale = 1 }, v85[143], Enum.EasingStyle.Back, Enum.EasingDirection.Out)
													end

													tbl31.Set = function(arg10, arg11)
														local text = arg11 == Enum.KeyCode.Unknown and "" or tbl12.Display(arg11)
														local v114 = fn50(text)
														tbl31.label.Text = text

														fn37(tbl31.frame, {
															Size = UDim2.new(0, v114, 0, v110),
															Position = fn51(v114),
															BackgroundColor3 = arg11 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Surface or tbl27.Library.config.Colors.Element,
															BackgroundTransparency = arg11 == Enum.KeyCode.Unknown and v85[26] or v85[33],
														}, 0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

														fn37(tbl31.label, {
															TextColor3 = arg11 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														}, 0.2)

														fn37(UIStroke2, {
															Color = tbl27.Library.config.Colors.BorderSoft,
															Transparency = arg11 == Enum.KeyCode.Unknown and 0.35 or 0,
														}, 0.2)

														fn37(tbl31.keyboardIconImg, {
															Position = arg11 == Enum.KeyCode.Unknown and UDim2.new(0.5, -v85[123], v85[81], -5) or UDim2.new(1, -v85[30], 0.5, -v85[174]),
															ImageColor3 = arg11 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														}, 0.2)
													end

													tbl12.RegisterDisplay(arg4, function(arg10)
														tbl31:Set(arg10)
													end)

													tbl31.Listen = function()
														fn53()
														tbl31.label.Text = "..."
														local v114 = fn50("...")

														fn37(tbl31.frame, {
															Size = UDim2.new(v85[33], v114, 0, v110),
															Position = fn51(v114),
															BackgroundColor3 = tbl27.Library.config.Colors.ElementHover,
															BackgroundTransparency = 0,
														}, v85[26], Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

														fn37(tbl31.label, { TextColor3 = tbl27.Library.config.Colors.TextHover }, 0.2)
														fn37(UIStroke2, { Color = tbl27.Library.config.Colors.Border, Transparency = v85[33] }, 0.2)
														fn37(tbl31.keyboardIconImg, { Position = UDim2.new(1, -v85[30], 0.5, -5), ImageColor3 = tbl27.Library.config.Colors.TextHover }, 0.2)

														tbl12.BeginListen(arg4, function(arg10)
															tbl31:Set(arg10)
														end, function(arg10)
															if not tbl30.Group then
																return true
															end
															local v115 = tbl12.FindDuplicate(tbl30.Group, arg4, arg10)
															if v115 then
																tbl27.Library:Notify({ Title = "You already have " .. v115 .. " set as " .. tbl12.Display(arg10) .. "!" })
																return false
															end
															return true
														end)
													end

													v112.InputBegan:Connect(function(input)
														if input.UserInputType == Enum.UserInputType.MouseButton1 then
															tbl31:Listen()
															return
														end

														if input.UserInputType == Enum.UserInputType.MouseButton2 then
															fn54(input.Position)
														end
													end)

													tbl31.OpenMode = function(arg10, arg11)
														fn54(arg11)
													end

													v112.MouseEnter:Connect(function()
														fn37(tbl31.frame, { BackgroundColor3 = tbl27.Library.config.Colors.ElementHover, BackgroundTransparency = 0 }, 0.2)
														fn37(tbl31.label, { TextColor3 = tbl27.Library.config.Colors.TextHover }, 0.2)
														fn37(UIStroke2, { Color = tbl27.Library.config.Colors.Border, Transparency = 0 }, 0.2)
														fn37(tbl31.keyboardIconImg, { ImageColor3 = tbl27.Library.config.Colors.TextHover }, v85[113])
													end)

													v112.MouseLeave:Connect(function()
														local v114 = tbl12.Get(arg4)

														fn37(tbl31.frame, {
															BackgroundColor3 = v114 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Surface or tbl27.Library.config.Colors.Element,
															BackgroundTransparency = v114 == Enum.KeyCode.Unknown and 0.25 or 0,
														}, 0.2)

														fn37(tbl31.label, {
															TextColor3 = v114 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														}, v85[113])

														fn37(UIStroke2, {
															Color = tbl27.Library.config.Colors.BorderSoft,
															Transparency = v114 == Enum.KeyCode.Unknown and 0.35 or 0,
														}, 0.2)

														fn37(tbl31.keyboardIconImg, {
															ImageColor3 = v114 == Enum.KeyCode.Unknown and tbl27.Library.config.Colors.Muted or tbl27.Library.config.Colors.SubText,
														}, 0.2)
													end)

													if arg8 then
														tbl12.Register(arg4, arg8)
													end

													return tbl31
												end,
											}

											tbl27.AddToggle = addToggle
											tbl27.AddSlider = addSlider
											tbl27.AddDoubleSlider = addDoubleSlider
											tbl27.AddButton = addButton
											tbl27.AddKeybind = addKeybind
											tbl27.AddDropdown = addDropdown
											tbl27.AddTextbox = addTextbox
											tbl27.AddDivider = addDivider
											tbl27.AddSection = addSection
											tbl27.AddLabel = addLabel
											updateSize()
											table.insert(arg.groupsInTab, tbl27)
											return tbl27
										end
									end
								end

								do
									local obj2 = setmetatable({}, { __mode = "k" })

									local function addTab(arg, arg2)
										local v105 = obj2[arg]
										arg2 = arg2 or {}
										arg2.Name = arg2.Name or "Tab"
										arg2.Description = arg2.Description or v85[181]
										arg2.Icon = arg2.Icon or "rbxassetid://94219370057308"

										local currentTabYay = {
											Config = arg2,
											groupsInTab = {},
											isActive = false,
											Library = arg.Library,
											buttonFrame = fn45("Frame", {
												Name = "TabButton",
												Active = true,
												BackgroundColor3 = arg.Library.config.AccentColor,
												BackgroundTransparency = 1,
												BorderColor3 = arg.Library.config.Colors.Black,
												BorderSizePixel = 0,
												Size = UDim2.new(0, 136, 0, 28),
												Parent = arg.tabHolderFrame,
											}),
										}

										fn45("UICorner", { Name = "UICorner", CornerRadius = UDim.new(0, 7), Parent = currentTabYay.buttonFrame })

										currentTabYay.iconImg = fn45("ImageLabel", {
											Name = "TabIcon",
											ImageColor3 = arg.Library.config.Colors.Muted,
											BackgroundColor3 = arg.Library.config.Colors.White,
											Image = arg2.Icon,
											BackgroundTransparency = 1,
											Position = UDim2.new(0, 9, 0.5, -7),
											BorderColor3 = Color3.new(),
											BorderSizePixel = 0,
											Size = UDim2.new(0, 14, 0, 14),
											Parent = currentTabYay.buttonFrame,
										})

										currentTabYay.nameLabel = fn45("TextLabel", {
											Name = "TabName",
											FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
											TextColor3 = arg.Library.config.Colors.Muted,
											Text = arg2.Name,
											BackgroundColor3 = arg.Library.config.Colors.White,
											BackgroundTransparency = 1,
											Position = UDim2.new(v85[33], 30, 0.5, -8),
											BorderSizePixel = 4,
											BorderColor3 = Color3.new(),
											TextSize = 15,
											Size = UDim2.new(0, v85[158], 0, 16),
											TextXAlignment = Enum.TextXAlignment.Left,
											Parent = currentTabYay.buttonFrame,
										})

										local TextButton = fn45("TextButton", {
											Name = "TabClickButton",
											Text = "",
											BackgroundTransparency = 1,
											Size = UDim2.new(v85[18], v85[33], 1, 0),
											Parent = currentTabYay.buttonFrame,
										})

										currentTabYay.contentFadeFrame = fn45("CanvasGroup", {
											Name = v85[24],
											Active = true,
											BackgroundTransparency = 1,
											Position = UDim2.new(0, 4, 0, 4),
											Size = UDim2.new(1, -8, v85[18], -8),
											GroupTransparency = v85[18],
											Visible = false,
											Parent = arg.Library.contentHolderFrame,
										})

										local function fn50(arg3, arg4)
											if n26(3578) < 16212 then
												local ScrollingFrame = fn45("ScrollingFrame", {
													Name = arg3,
													Active = true,
													BackgroundTransparency = v85[18],
													Position = arg4,
													Size = UDim2.new(0, v85[83], 1, 0),
													ScrollingDirection = Enum.ScrollingDirection.Y,
													ScrollBarThickness = v85[33],
													ScrollBarImageTransparency = v85[18],
													ScrollingEnabled = true,
													CanvasSize = UDim2.new(0, 0, v85[33], 0),
													AutomaticCanvasSize = Enum.AutomaticSize.Y,
													Parent = currentTabYay.contentFadeFrame,
												})

												fn45("UIPadding", {
													Name = "UIPadding",
													PaddingTop = UDim.new(0, 2),
													PaddingBottom = UDim.new(0, 8),
													PaddingLeft = UDim.new(v85[33], 3),
													PaddingRight = UDim.new(0, 3),
													Parent = ScrollingFrame,
												})

												fn45("UIListLayout", {
													Name = "UIListLayout",
													Padding = UDim.new(0, 10),
													SortOrder = Enum.SortOrder.LayoutOrder,
													Parent = ScrollingFrame,
												})

												return ScrollingFrame
											end

											while true do
											end
										end

										currentTabYay.leftColumnFrame = fn50(v85[95], UDim2.new(v85[33], 0, 0, 0))
										currentTabYay.rightColumnFrame = fn50(v85[144], UDim2.new(v85[33], 274, 0, 0))

										currentTabYay.Activate = function()
											if arg.Library.openDropdowns then
												for _, openDropdown in pairs(arg.Library.openDropdowns) do
													if openDropdown.Close then
														openDropdown:Close()
													end
												end
											end

											if arg.Library.currentTabYay then
												arg.Library.currentTabYay:Deactivate()
											end

											arg.Library.currentTabYay = currentTabYay
											currentTabYay.isActive = true
											currentTabYay.contentFadeFrame.Visible = true
											currentTabYay.contentFadeFrame.GroupTransparency = 1
											fn37(currentTabYay.contentFadeFrame, { GroupTransparency = 0 }, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
											local n32 = table.find(arg.tabsInSection, currentTabYay) or 1
											local position = arg.tabIndicatorFrame.Position
											local udim2 = UDim2.new(0, v85[192], v85[33], 39 + (n32 - 1) * v85[48])
											fn37(arg.tabIndicatorFrame, { Position = udim2 }, v85[64], Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

											for _, tabIndicatorTrail in ipairs(arg.tabIndicatorTrails) do
												local udim22 = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset - tabIndicatorTrail.offset)
												local udim23 = UDim2.new(udim2.X.Scale, udim2.X.Offset, udim2.Y.Scale, udim2.Y.Offset - tabIndicatorTrail.offset)
												tabIndicatorTrail.frame.Position = udim22
												tabIndicatorTrail.frame.BackgroundTransparency = tabIndicatorTrail.alpha
												fn37(tabIndicatorTrail.frame, { Position = udim23, BackgroundTransparency = 1 }, v85[64] + tabIndicatorTrail.delay, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
											end

											fn37(currentTabYay.iconImg, { ImageColor3 = arg.Library.config.Colors.Text }, v85[64])
											fn37(currentTabYay.nameLabel, { TextColor3 = arg.Library.config.Colors.Text }, v85[64])
											arg.Library.tabNameLabel.Text = arg2.Name
											arg.Library.tabDescriptionLabel.Text = arg2.Description
										end

										currentTabYay.Deactivate = function()
											currentTabYay.isActive = false
											currentTabYay.contentFadeFrame.Visible = false
											currentTabYay.contentFadeFrame.GroupTransparency = 1
											fn37(currentTabYay.iconImg, { ImageColor3 = arg.Library.config.Colors.Muted }, 0.35)
											fn37(currentTabYay.nameLabel, { TextColor3 = arg.Library.config.Colors.Muted }, v85[64])
										end

										TextButton.MouseButton1Click:Connect(function()
											if not currentTabYay.isActive then
												currentTabYay:Activate()
											end
										end)

										TextButton.MouseEnter:Connect(function()
											if not currentTabYay.isActive then
												fn37(currentTabYay.nameLabel, { TextColor3 = arg.Library.config.Colors.TextHover }, v85[100])
												fn37(currentTabYay.iconImg, { ImageColor3 = arg.Library.config.Colors.TextHover }, v85[100])
											end
										end)

										TextButton.MouseLeave:Connect(function()
											if not currentTabYay.isActive then
												fn37(currentTabYay.nameLabel, { TextColor3 = arg.Library.config.Colors.Muted }, 0.3)
												fn37(currentTabYay.iconImg, { ImageColor3 = arg.Library.config.Colors.Muted }, 0.3)
											end
										end)

										currentTabYay.AddGroup = addGroup
										table.insert(arg.tabsInSection, currentTabYay)
										table.insert(arg.Library.tabsGoWoosh, currentTabYay)

										if #arg.Library.tabsGoWoosh == 1 then
											currentTabYay:Activate()
										end

										task.defer(v105)
										return currentTabYay
									end

									index.CreateSection = function(arg, arg2)
										local tbl27 = arg2 or {}
										tbl27.Name = tbl27.Name or v85[183]
										tbl27.Icon = tbl27.Icon or "rbxassetid://98092584632154"

										local tbl28 = {
											tabsInSection = {},
											isExpanded = v85[200],
											Library = arg,
											containerFrame = fn45("Frame", {
												Name = "SectionContainerYay",
												Active = v85[200],
												BackgroundTransparency = 1,
												Size = UDim2.new(0, v85[45], 0, 32),
												ClipsDescendants = true,
												Parent = arg.sectionHolderScroll,
											}),
										}

										tbl28.mainFrame = fn45("Frame", {
											Name = "SectionMainFrame",
											Active = true,
											BackgroundColor3 = arg.config.Colors.Secondary,
											Position = UDim2.new(0, 1, 0, 2),
											BorderColor3 = arg.config.Colors.Black,
											BorderSizePixel = v85[33],
											Size = UDim2.new(0, 156, 0, 28),
											Parent = tbl28.containerFrame,
										})

										local UIStroke = fn45("UIStroke", { Name = "UIStroke", Color = arg.config.Colors.BorderSoft, Parent = tbl28.mainFrame })
										local v105 = fn45
										local tbl29 = { Name = "UIGradient" }
										local colorSequence = ColorSequence.new
										local tbl30 = {}
										local v106 = ColorSequenceKeypoint.new(0, arg.config.Colors.Text)
										local v107 = ColorSequenceKeypoint.new(0.493, arg.config.Colors.AccentLight)
										local v108 = ColorSequenceKeypoint.new(0.509, arg.config.Colors.AccentLight)
										tbl30[1] = v106
										tbl30[2] = v107
										tbl30[3] = v108

										do
											local values = table.pack(ColorSequenceKeypoint.new(1, arg.config.Colors.Text))
											table.move(values, 1, values.n, 4, tbl30)
										end

										tbl29.Color = colorSequence(tbl30)
										tbl29.Rotation = v85[68]
										tbl29.Parent = UIStroke
										v105("UIGradient", tbl29)
										fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(0, 7), Parent = tbl28.mainFrame })

										fn45("UIAspectRatioConstraint", {
											Name = "UIAspectRatioConstraint",
											Parent = fn45("ImageLabel", {
												Name = "SectionIcon",
												BorderColor3 = arg.config.Colors.Black,
												BackgroundColor3 = arg.config.Colors.White,
												Image = tbl27.Icon,
												BackgroundTransparency = 1,
												Position = UDim2.new(0, v85[115], 0.5, -7),
												BorderSizePixel = 0,
												Size = UDim2.new(v85[33], 14, v85[33], 14),
												Parent = tbl28.mainFrame,
											}),
										})

										fn45("TextLabel", {
											Name = "SectionName",
											FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
											TextColor3 = arg.config.Colors.Text,
											Text = tbl27.Name,
											BackgroundColor3 = arg.config.Colors.White,
											BackgroundTransparency = 1,
											Position = UDim2.new(0, 32, 0.5, -8.5),
											BorderSizePixel = 0,
											BorderColor3 = Color3.new(),
											TextSize = v85[147],
											Size = UDim2.new(v85[33], v85[158], 0, 16),
											TextXAlignment = Enum.TextXAlignment.Left,
											Parent = tbl28.mainFrame,
										})

										local ImageButton = fn45("ImageButton", {
											Name = "ExpandCollapseButton",
											BackgroundColor3 = arg.config.Colors.White,
											Image = "rbxassetid://111626678408582",
											BackgroundTransparency = 1,
											Position = UDim2.new(1, -24, 0.5, -8),
											BorderColor3 = Color3.new(),
											BorderSizePixel = 0,
											Size = UDim2.new(0, 16, 0, 16),
											Parent = tbl28.mainFrame,
										})

										tbl28.tabIndicatorFrame = fn45("Frame", {
											Name = v85[47],
											BackgroundColor3 = arg.config.AccentColor,
											BackgroundTransparency = 0,
											BorderSizePixel = 0,
											Position = UDim2.new(0, 11, 0, v85[42]),
											Size = UDim2.new(0, 136, 0, v85[185]),
											Parent = tbl28.containerFrame,
										})

										fn45("UICorner", { Name = v85[137], CornerRadius = UDim.new(v85[33], v85[72]), Parent = tbl28.tabIndicatorFrame })
										tbl28.tabIndicatorTrails = {}

										for i = 1, 4 do
											local n32 = 28 + i * 3
											local n33 = (n32 - 28) / 2

											local Frame = fn45("Frame", {
												Name = v85[20] .. i,
												BackgroundColor3 = arg.config.AccentColor,
												BackgroundTransparency = 1,
												BorderSizePixel = v85[33],
												Position = UDim2.new(v85[33], v85[192], 0, v85[42] - n33),
												Size = UDim2.new(v85[33], 136, 0, n32),
												Parent = tbl28.containerFrame,
											})

											fn45("UICorner", { Name = v85[164] .. i, CornerRadius = UDim.new(0, 7), Parent = Frame })
											table.insert(tbl28.tabIndicatorTrails, { frame = Frame, alpha = 0.6 - i * 0.1, delay = i * 0.06, offset = n33 })
										end

										tbl28.tabHolderFrame = fn45("Frame", {
											Name = "TabHolderFrame",
											BackgroundTransparency = 1,
											Position = UDim2.new(v85[33], 11, 0, 39),
											Size = UDim2.new(v85[33], 146, 0, 0),
											ClipsDescendants = v85[200],
											Parent = tbl28.containerFrame,
										})

										tbl28.tabHolderScale = fn45("UIScale", { Name = v85[175], Scale = v85[18], Parent = tbl28.tabHolderFrame })

										tbl28.tabLayoutThing = fn45(v85[106], {
											Name = "UIListLayout",
											Padding = UDim.new(v85[33], 5),
											SortOrder = Enum.SortOrder.LayoutOrder,
											Parent = tbl28.tabHolderFrame,
										})

										local function fn50()
											local n32 = #tbl28.tabsInSection > 0 and #tbl28.tabsInSection * 28 + (#tbl28.tabsInSection - v85[18]) * v85[174] or 0
											tbl28.tabHolderFrame.Size = UDim2.new(v85[33], v85[3], 0, n32)

											if tbl28.isExpanded then
												fn37(tbl28.containerFrame, { Size = UDim2.new(0, v85[45], 0, 32 + n32 + 14) }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
											end
										end

										tbl28.tabLayoutThing:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(fn50)

										local function toggleIsExpanded()
											tbl28.isExpanded = not tbl28.isExpanded
											fn37(ImageButton, { Rotation = tbl28.isExpanded and v85[33] or -v85[91] }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

											if tbl28.isExpanded then
												local y = tbl28.tabLayoutThing.AbsoluteContentSize.Y
												tbl28.tabHolderScale.Scale = 0.92
												fn37(tbl28.containerFrame, { Size = UDim2.new(0, 158, 0, 32 + y + 14) }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
												fn37(tbl28.tabHolderScale, { Scale = 1 }, 0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
												fn37(tbl28.tabIndicatorFrame, { BackgroundTransparency = 0 }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

												for _, tabIndicatorTrail in ipairs(tbl28.tabIndicatorTrails) do
													tabIndicatorTrail.frame.BackgroundTransparency = 1
												end
											else
												fn37(tbl28.tabHolderScale, { Scale = 0.94 }, v85[139], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
												fn37(tbl28.containerFrame, { Size = UDim2.new(0, 158, 0, v85[14]) }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
												fn37(tbl28.tabIndicatorFrame, { BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

												for _, tabIndicatorTrail in ipairs(tbl28.tabIndicatorTrails) do
													tabIndicatorTrail.frame.BackgroundTransparency = v85[18]
												end
											end
										end

										ImageButton.MouseButton1Click:Connect(toggleIsExpanded)

										fn45(v85[39], {
											Name = v85[179],
											Text = "",
											BackgroundTransparency = v85[18],
											Size = UDim2.new(1, 0, v85[18], 0),
											Parent = tbl28.mainFrame,
										}).MouseButton1Click:Connect(toggleIsExpanded)

										table.insert(arg.sectionRefreshers, fn50)
										obj2[tbl28] = fn50
										tbl28.AddTab = addTab
										table.insert(arg.sectionsAreAwesome, tbl28)
										return tbl28
									end
								end
							end

							index.SetAccentColor = function(arg, accentColor)
								arg.config.AccentColor = accentColor
							end

							index.Destroy = function(arg)
								if arg.Destroyed then
									return
								end
								arg.Destroyed = true
								fn30(fn43)

								for k in tbl26, nil, nil do
									k:Disconnect()
								end

								table.clear(tbl26)
								v104 = nil

								if arg.dropdownFrames then
									for _, dropdownFrame in ipairs(arg.dropdownFrames) do
										dropdownFrame:Destroy()
									end

									arg.dropdownFrames = nil
								end

								if tbl12 and tbl12.Destroy then
									tbl12.Destroy()
								end

								if arg.screenGuiYay and arg.screenGuiYay.Parent then
									arg.screenGuiYay:Destroy()
								end

								arg.screenGuiYay = nil

								if getgenv().FlyteBB == arg then
									getgenv().FlyteBB = nil
								end
							end

							v100 = index
							v101 = fn37
							v102 = tbl12
							tbl23 = nil
							v103 = nil
							fn38 = nil
							fn39 = nil
							fn40 = nil
							tbl24 = nil
							tbl25 = nil

							fn43 = function()
								if not flyteBBState or flyteBBState.Unloading then
									return
								end
								flyteBBState.Unloading = true
								flyteBBState.Loaded = v85[101]
								local tbl27 = tbl20 or {}

								for k, v105 in tbl27, nil, nil do
									if type(v105) == "boolean" then
										tbl20[k] = v85[101]
									end
								end

								if tbl25 then
									if tbl25.UnlockAll then
										fn30(tbl25.UnlockAll.Stop, true)
									end

									if tbl25.UIExtra then
										fn30(tbl25.UIExtra.HideOverlays)
									end

									if tbl25.AFK then
										fn30(tbl25.AFK.Toggle, v85[101])
									end

									if tbl25.Script then
										fn30(tbl25.Script.Toggle, false)
									end

									if tbl25.Render then
										fn30(tbl25.Render.DisableFX, false)
										fn30(tbl25.Render.SetAntiLag, false)
									end

									if tbl25.Visuals then
										fn30(tbl25.Visuals.ClearESP)
									end

									if tbl25.Streak then
										fn30(tbl25.Streak.Stop)
									end

									if tbl25.Stats then
										fn30(tbl25.Stats.Stop)
									end

									if tbl25.AutoPlay then
										fn30(tbl25.AutoPlay.Stop)
									end

									if tbl25.Staff then
										fn30(tbl25.Staff.Set, false)
									end

									if tbl25.Quasar then
										fn30(tbl25.Quasar.SetBlindness, false)
										fn30(tbl25.Quasar.SetDisorientate, false)
										fn30(tbl25.Quasar.Reset)
									end

									if tbl25.Phantom then
										fn30(tbl25.Phantom.Reset)
									end

									if tbl25.Animation then
										fn30(tbl25.Animation.Reset)
									end
								end

								if tbl23 then
									fn30(tbl23.Destroy)
								end

								fn29(flyteBBState)
								flyteBBState.Connections = {}

								if flyteBBState.PreclickQueue then
									table.clear(flyteBBState.PreclickQueue)
								end

								local parry = tbl25 and tbl25.Parry

								if parry then
									local fire = tbl25.Parry.Fire
									parry = getgenv().FlyteParry == fire
								end

								if parry then
									getgenv().FlyteParry = nil
								end

								flyteBBState.Unloaded = true

								if getgenv().FlyteBB_State == flyteBBState then
									getgenv().FlyteBB_State = nil
								end
							end

							do
								local virtualInputManager = Instance.new("VirtualInputManager")
								Data = require(v93.Packages.Replion).Client:WaitReplion("Data")
								local tbl27 = { MouseButton1 = 0, MouseButton2 = 1, MouseButton3 = v85[70] }
								local str5 = nil

								flyteBBState = {
									Unload = fn43,
									Loaded = v85[101],
									ParryMethod = v85[7],
									ESPLabels = {},
									ESPConnections = {},
									AbilityActive = {},
									AbilityCooldowns = {},
									AbilityUses = {},
									Connections = {},
									SpamParries = {},
									AutoSpamData = { {}, { 0, v85[33] } },
									StatsPeak = {},
									ExtraStats = {},
									StaffDetected = {},
								}

								getgenv().FlyteBB_State = flyteBBState
								fn42()
								flyteBBState.Connections["Data Ping"] = task.spawn(function()while true do task.wait(0.1); fn42 ();end;end)

								local function fn50()
									local bind3 = Data:Get({ "Settings", "Keybinds", "Block", "PC" })
									local bind1 = bind3 and bind3.Bind1
									local bind2 = bind3 and bind3.Bind2
									bind3 = bind3 and bind3.Bind3
									str5 = bind1 and not tbl27[bind1] and bind1 or bind2 and not tbl27[bind2] and bind2 or bind3 and not tbl27[bind3] and bind3 or bind1 or bind2 or bind3 or "F"
								end

								fn50()
								flyteBBState.Connections["Block Bind"] = Data:OnDescendantChange({ v85[58], "Keybinds", "Block" }, fn50)

								fn41 = function()
									if v87.TouchEnabled then
										local viewportSize = workspace.CurrentCamera.ViewportSize
										local n32 = viewportSize.X / 2
										local n33 = viewportSize.Y / 2
										virtualInputManager:SendTouchEvent(10, 0, n32, n33)
										virtualInputManager:SendTouchEvent(10, 2, n32, n33)
										return true
									end

									local v105 = tbl27[str5]

									if v105 then
										virtualInputManager:SendMouseButtonEvent(0, 0, v105, true, game, v85[33])
										virtualInputManager:SendMouseButtonEvent(0, 0, v105, false, game, 0)
										return true
									end

									local v106 = Enum.KeyCode[str5]
									if not v106 then
										return false
									end
									virtualInputManager:SendKeyEvent(true, v106, false, game)
									virtualInputManager:SendKeyEvent(false, v106, v85[101], game)
									return true
								end
							end
						end

						local fn42, fn43, fn44, currentCamera, Lighting, alive, runtime, balls, trainingBalls, v104
						local v105, v106, duration, fn45, fn46, fn47, fn48, fn49, abilityButtonPress, fn50
						local fn51, obj, fn52, fn53, fn54, fn55, fn56, fn57, obj2, fn58
						local fn59, fn60, fn61, fn62, fn63, fn64, fn65, fn66, fn67, flag18
						local n32, v107, v108, fn68

						do
							do
								local v109, tbl26

								do
									do
										fn42 = function(arg)
											local v110 = flyteBBState.Connections[arg]

											if v110 then
												fn29(v110)
												flyteBBState.Connections[arg] = nil
											end
										end

										tbl20 = {}

										do
											local tbl27 = {
												anticurve = "Anticurve",
												esp = v85[196],
												fflags = "FFlags",
												kh = "KH",
												timehole = "TimeHole",
												ui = "UI",
											}

											local tbl28 = {
												tbl19.Toggles,
												tbl19.Sliders,
												tbl19.DoubleSliders,
												tbl19.Dropdowns,
												tbl19.Textboxes,
											}

											local function fn69(arg, arg2)
												if arg2 and arg == "custom_streak" then
													return v85[105]
												end
												local str5 = (arg2 and arg:match("^(.-)(:notify)$") or arg):gsub("FFlags", "Fflags")

												for _, v110 in { v85[196], v85[155], v85[130], v85[13], "VIM", v85[55], "ID", v85[167], "VFX", "R15", "R6" }, nil, nil do
													str5 = str5:gsub(v110, v85[188] .. v110 .. "_")
												end

												local str6 = str5:gsub("(%l)(%u)", "%1_%2"):gsub("(%u)(%u%l)", "%1_%2"):gsub("_+", "_"):gsub("^_", ""):gsub("_$", ""):gsub("[^_]+", function(arg3)
													local v110 = tbl27[string.lower(arg3)]
													local str6

													if v110 then
														str6 = v110
													else
														str6 = arg3:sub(1, 1):upper() .. arg3:sub(v85[70])
													end

													return str6
												end)

												if arg2 then
													return fn31(str6:gsub("_Enabled$", "") .. "")
												end
												return str6:gsub("_", "")
											end

											fn43 = function(arg)
												for k, v110 in arg, nil, nil do
													local v111 = fn69(k, v85[200])

													for _, v112 in tbl28, nil, nil do
														if v112[v111] ~= nil then
															v110 = v112[v111]
															break
														end
													end

													tbl20[fn69(k)] = fn33(v110)
												end
											end

											fn44 = function(arg, arg2)
												return function(arg3)
													tbl20[fn69(arg)] = arg3

													if arg2 then
														arg2(arg3)
													end
												end
											end
										end
									end

									do
										local trainingArea, lobby

										do
											fn43({ MenuScale = v85[158] })

											Configs = {
												Folder = "Flyte/settings",
												AutoloadPath = "Flyte/settings/autoload.txt",
											}

											v97 = Configs

											Configs.SyncUnlock = function()
												if type(tbl19.UnlockAll) ~= "table" then
													return
												end
												tbl20.UnlockAllSword = type(tbl19.UnlockAll.Sword) == "string" and tbl19.UnlockAll.Sword or ""
												tbl20.UnlockAllExplosion = type(tbl19.UnlockAll.Explosion) == "string" and tbl19.UnlockAll.Explosion or ""
												tbl20.UnlockAllEmotes = type(tbl19.UnlockAll.Emotes) == "table" and tbl19.UnlockAll.Emotes or {}
												tbl20.UnlockAllAccessory = tbl19.UnlockAll.Accessory == true
												tbl20.UnlockAllFinishers = type(tbl19.UnlockAll.Finishers) == "table" and tbl19.UnlockAll.Finishers or {}
												tbl20.UnlockAllFavorites = type(tbl19.UnlockAll.Favorites) == "table" and tbl19.UnlockAll.Favorites or { Sword = {}, Explosion = {}, Emote = {} }
											end

											Configs.SyncUnlock()

											Configs.Name = function(arg)
												if type(arg) ~= "string" or arg:gsub("%s+", "") == "" then
													return
												end
												local str5 = arg:gsub("^%s+", ""):gsub("%s+$", "")
												if string.lower(str5) == "autoload" or str5:find("[\\/:*?\"<>|]") then
													return
												end
												return str5
											end

											Configs.MakeFolder = function()
												if not isfolder("Flyte") then
													makefolder("Flyte")
												end

												if not isfolder(Configs.Folder) then
													makefolder(Configs.Folder)
												end
											end

											Configs.GetPath = function(arg)
												local v110 = Configs.Name(arg)
												if not v110 then
													return
												end
												return Configs.Folder .. "/" .. v110 .. ".json"
											end

											Configs.Copy = function(arg, arg2)
												table.clear(arg)

												for k, v110 in arg2, nil, nil do
													arg[k] = fn33(v110)
												end
											end

											Configs.New = function()
												local tbl27 = {
													UnlockAll = {
														Sword = "",
														Explosion = "",
														Emotes = {},
														Accessory = false,
														Finishers = {},
														Favorites = { Sword = {}, Explosion = {}, Emote = {} },
													},
												}

												for _, v110 in tbl21, nil, nil do
													tbl27[v110] = tbl27[v110] or {}
												end

												return tbl27
											end

											Configs.Defaults = function()
												local v110 = Configs.New()

												if tbl24 then
													for _, v111 in tbl24.toggles, nil, nil do
														if v111.SaveId and v111.DefaultValue ~= nil then
															local v112 = v85[57]
															local keybinds = typeof(v111.DefaultValue) == v112 and v110.Keybinds or v110.Toggles
															local saveId = v111.SaveId
															local v113 = v85[57]
															keybinds[saveId] = typeof(v111.DefaultValue) == v113 and v111.DefaultValue.Name or fn33(v111.DefaultValue)
														end

														if v111.NotifySaveId then
															v110.Toggles[v111.NotifySaveId] = v111.DefaultNotify
														end
													end

													for _, v111 in tbl24.sliders, nil, nil do
														if v111.SaveId and v111.DefaultValue ~= nil then
															local v112 = v85[145]
															;(type(v111.DefaultValue) == v112 and v110.DoubleSliders or v110.Sliders)[v111.SaveId] = fn33(v111.DefaultValue)
														end
													end

													for _, v111 in tbl24.dropdowns, nil, nil do
														if v111.SaveId and v111.DefaultValue ~= nil then
															v110.Dropdowns[v111.SaveId] = fn33(v111.DefaultValue)
														end
													end

													for _, v111 in tbl24.textboxes, nil, nil do
														if v111.SaveId and v111.DefaultValue ~= nil then
															v110.Textboxes[v111.SaveId] = fn33(v111.DefaultValue)
														end
													end
												end

												return v110
											end

											Configs.Current = function()
												local v110 = Configs.New()

												for _, v111 in tbl21, nil, nil do
													Configs.Copy(v110[v111], tbl19[v111])
												end

												return v110
											end

											Configs.Validate = function(arg)
												arg = type(arg) == "table" and arg or {}
												fn32(arg)
												local v110 = Configs.Defaults()

												for _, v111 in tbl21, nil, nil do
													if type(arg[v111]) == "table" then
														Configs.Copy(v110[v111], arg[v111])
													end
												end

												for _, v111 in { v85[187], "manual_spam_enabled" }, nil, nil do
													v110.Toggles[v111] = nil
												end

												fn35(v110.Dropdowns)
												return v110
											end

											Configs.Apply = function(arg)
												local v110 = Configs.Validate(arg)
												local v111 = fn33(tbl19.Keybinds)
												Configs.Applying = true

												for _, v112 in tbl21, nil, nil do
													Configs.Copy(tbl19[v112], v110[v112])
												end

												Configs.SyncUnlock()

												local function fn69(arg2, arg3)
													for _, v112 in arg2, nil, nil do
														local saveId = v112.SaveId

														if saveId and v112.Set and arg3[saveId] ~= nil then
															v112:Set(fn33(arg3[saveId]))
														end

														if v112.SetNotify and v112.NotifySaveId and arg3[v112.NotifySaveId] ~= nil then
															v112:SetNotify(arg3[v112.NotifySaveId])
														end
													end
												end

												if tbl24 then
													fn69(tbl24.toggles, tbl19.Toggles)
													fn69(tbl24.sliders, tbl19.Sliders)

													for _, v112 in tbl24.sliders, nil, nil do
														local saveId = v112.SaveId and tbl19.DoubleSliders[v112.SaveId]

														if v112.Set and type(saveId) == "table" then
															v112:Set(saveId.Min, saveId.Max)
														end
													end

													fn69(tbl24.dropdowns, tbl19.Dropdowns)
													fn69(tbl24.textboxes, tbl19.Textboxes)

													for _, v112 in tbl24.toggles, nil, nil do
														local saveId = v112.SaveId
														saveId = saveId and tbl19.Keybinds[saveId]

														if v112.Set and saveId ~= nil then
															local v113 = v102.Resolve(type(saveId) == "table" and saveId.Key or saveId)
															local v114 = v85[57]

															if typeof(v113) == v114 then
																v112:Set(v113)
															end
														end
													end
												end

												for k, v112 in tbl19.Keybinds, nil, nil do
													if type(v112) == "table" then
														v102.SetMode(k, v112.Mode or "Toggle")
														v102.Set(k, v102.Resolve(v112.Key))
													end
												end

												for k in v111, nil, nil do
													if tbl19.Keybinds[k] == nil then
														v102.Set(k, Enum.KeyCode.Unknown)
													end
												end

												Configs.Applying = nil
												fn34()

												if flyteBBState and flyteBBState.RefreshKeybinds then
													task.defer(flyteBBState.RefreshKeybinds)
												end

												task.defer(function()
													if tbl25.UnlockAll and tbl25.UnlockAll.Status == "active" then
														tbl25.UnlockAll.LoadFavorites()
														tbl25.UnlockAll.ApplyFavorites()
														tbl25.UnlockAll.ApplySaved()
													elseif flyteBBState and flyteBBState.Loaded and tbl20.UnlockAllEnabled and tbl25.UnlockAll then
														tbl25.UnlockAll.Toggle(v85[200])
													end
												end)
											end

											Configs.Refresh = function(arg)
												Configs.MakeFolder()
												local tbl27 = {}

												for _, v110 in listfiles(arg.Folder) do
													local match = tostring(v110):gsub("\\", "/"):match("/([^/]+)%.json$")

													if match and match ~= "autoload" then
														table.insert(tbl27, match)
													end
												end

												table.sort(tbl27)
												return tbl27
											end

											Configs.Save = function(arg, arg2, arg3)
												local v110 = Configs.Name(arg2)
												if not v110 then
													return false, "invalid config name"
												end
												Configs.MakeFolder()
												local current = Configs.Current
												tbl11.Write(Configs.GetPath(v110), current())

												if arg3 ~= v85[101] then
													arg.Selected = v110
												end

												arg.Active = v110
												return true
											end

											Configs.Load = function(arg, arg2)
												local selected = Configs.Name(arg2)
												local v110 = selected and Configs.GetPath(selected)
												if not v110 or not isfile(v110) then
													selected = selected and "config does not exist"
													return false, selected or v85[118]
												end
												local v111 = tbl11.Read(v110)
												if type(v111) ~= "table" then
													return false, "failed to decode config"
												end
												arg.Selected = selected
												arg.Active = selected
												Configs.Apply(v111)
												return true
											end

											Configs.Delete = function(arg, arg2)
												local str5 = Configs.Name(arg2)
												local v110 = str5 and Configs.GetPath(str5)
												if not v110 or not isfile(v110) then
													str5 = str5 and v85[146] or "no config is selected"
													return false, str5
												end
												delfile(v110)

												if arg.Autoload == str5 then
													arg:ClearAutoload()
												end

												if arg.Selected == str5 then
													arg.Selected = nil
												end

												if arg.Active == str5 then
													arg.Active = nil
												end

												return v85[200]
											end

											Configs.Reset = function(arg, arg2)
												local v110 = Configs.Name(arg2)
												if not v110 then
													return false, "no config is selected"
												end
												Configs.MakeFolder()
												local v111 = Configs.GetPath(v110)
												local v112 = Configs.Defaults()
												tbl11.Write(v111, v112)

												if arg.Selected == v110 then
													Configs.Apply(v112)
												end

												return true
											end

											Configs.SetAutoload = function(arg, arg2)
												local v110 = Configs.Name(arg2)
												local v111 = v110 and Configs.GetPath(v110)
												if not v111 or not isfile(v111) then
													v110 = v110 and v85[146]
													return false, v110 or "no config is selected"
												end
												Configs.MakeFolder()
												writefile(Configs.AutoloadPath, v110)
												arg.Autoload = v110
												return true
											end

											Configs.GetAutoload = function(arg)
												Configs.MakeFolder()
												if not isfile(Configs.AutoloadPath) then
													arg.Autoload = nil
													return "none"
												end
												local v110 = Configs.Name(readfile(Configs.AutoloadPath))
												arg.Autoload = v110
												return v110 or "none"
											end

											Configs.ClearAutoload = function(arg)
												if isfile(Configs.AutoloadPath) then
													delfile(Configs.AutoloadPath)
												end

												arg.Autoload = nil
												return true
											end

											Configs.LoadAutoload = function(arg)
												local autoload = arg:GetAutoload()

												if autoload ~= "none" then
													arg:Load(autoload)
												end
											end

											tbl25 = {}
											currentCamera = workspace.CurrentCamera
											Lighting = game:GetService("Lighting")
											alive = workspace:WaitForChild("Alive")
											runtime = workspace:WaitForChild("Runtime")
											balls = workspace:WaitForChild("Balls")
											trainingBalls = workspace:FindFirstChild("TrainingBalls")
											v104 = localPlayer:WaitForChild(v85[193])

											do
												local lobbyTraining = workspace:FindFirstChild("LobbyTraining", true)
												trainingArea = lobbyTraining and lobbyTraining:FindFirstChild("TrainingArea")
												lobby = lobbyTraining and lobbyTraining:FindFirstChild("Lobby")
											end
										end

										local tbl27 = nil
										local hotbar = v104:WaitForChild("Hotbar")
										v109 = hotbar:WaitForChild(v85[2])
										v105 = hotbar:WaitForChild("Block"):FindFirstChild(v85[21])
										v106 = v109:FindFirstChild(v85[21])
										duration = v109:WaitForChild("Duration")

										tbl26 = {
											"Calming Deflection",
											"Raging Deflection",
											v85[73],
											"Aerodynamic Slash",
											"Forcefield",
											"Infinity",
											"Fracture",
											v85[5],
											"Ninja Dash",
											"Dribble",
											"Dragon Spirit",
										}

										fn45 = function(arg)
											arg = arg and arg:FindFirstChild("HumanoidRootPart")
											if not arg or not trainingArea then
												return false
											end
											local v110 = trainingArea.CFrame:PointToObjectSpace(arg.Position)
											local n33 = trainingArea.Size * 0.5
											local x = n33.X
											local flag19 = math.abs(v110.X) <= x

											if flag19 then
												local y = n33.Y
												flag19 = math.abs(v110.Y) <= y
											end

											local flag20

											if flag19 then
												local z = n33.Z
												flag20 = math.abs(v110.Z) <= z
											else
												flag20 = flag19
											end

											return flag20
										end

										fn46 = function(arg)
											return arg and arg.PrimaryPart and (arg.Parent == alive or fn45(arg))
										end

										fn47 = function()
											if tbl27 then
												return tbl27
											end
											tbl27 = {}
											local descendants = lobby and lobby:GetDescendants() or {}

											for _, v110 in descendants, nil, nil do
												local isBasePart = v110:IsA("BasePart")
												local flag19

												if isBasePart then
													local v111 = v85[200]
													flag19 = v110:GetAttribute(v85[114]) == v111
												else
													flag19 = isBasePart
												end

												if flag19 then
													tbl27[#tbl27 + 1] = v110
												end
											end

											return tbl27
										end
									end
								end

								do
									do
										do
											local function fn69(arg)
												if not arg then
													return v85[101]
												end

												for _, v110 in tbl26, nil, nil do
													local v111 = arg:FindFirstChild(v110)

													if v111 and v111.Enabled then
														if v110 == v85[156] or v110 == v85[160] then
															local ready = v109:FindFirstChild("ready")
															ready = ready and ready:FindFirstChild(v85[171])
															local flag19 = not v109.Red.Visible

															if flag19 then
																flag19 = not ready

																if not flag19 then
																	flag19 = (tonumber(ready.Text) or v85[33]) > 0
																end
															end

															v110 = flag19 and v110 or nil
															return v110
														end

														v110 = v106 and v106.Offset.Y >= 0.49 and v110 or nil
														return v110
													end
												end
											end

											fn48 = function(arg)
												local flag19 = arg:GetAttribute(v85[119]) == true

												if not flag19 then
													flag19 = flyteBBState.InvisibilityCharacter == arg

													if flag19 then
														flag19 = os.clock() < (flyteBBState.InvisibilityUntil or v85[33])
													end
												end

												return flag19
											end

											flyteBBState.Connections["Invisibility Request"] = v93.Remotes.VisualBindableCD.Event:Connect(function()
												local character = localPlayer.Character
												local flag19

												if character then
													local v110 = v85[5]
													flag19 = localPlayer:GetAttribute("CurrentlyEquippedAbility") == v110
												else
													flag19 = character
												end

												if flag19 then
													flyteBBState.InvisibilityCharacter = character
													flyteBBState.InvisibilityUntil = os.clock() + 3
												end
											end)

											fn49 = function(arg)
												local character = localPlayer.Character
												character = character and character:FindFirstChild("Abilities")
												character = character and character:FindFirstChild(arg)
												return localPlayer:GetAttribute("CurrentlyEquippedAbility") == arg and character and character.Enabled and duration.Visible
											end

											abilityButtonPress = v93.Remotes.AbilityButtonPress

											fn50 = function(arg)
												if not fn69(arg) then
													return false
												end
												abilityButtonPress:Fire()
												return true
											end
										end
									end

									fn43({
										ParryAccuracy = 1,
										ParryRange = 0,
										AntiCurveEnabled = true,
										BackwardsAntiCurveEnabled = true,
										AutoParryType = v85[90],
										SelectedParryType = v85[132],
										ParryLoopType = "PreSimulation",
										CooldownProtectionEnabled = v85[101],
										AutoAbilityEnabled = false,
										RandomizedParryAccuracy = v85[101],
										RandomAccuracyMin = 1,
										RandomAccuracyMax = v85[158],
									})

									fn51 = function(arg)
										local attribute = arg and arg:GetAttribute("target")
										if attribute and attribute ~= "" then
											return attribute
										end
										local targetAttachment = arg and arg:FindFirstChild("TargetAttachment")
										local model = targetAttachment and targetAttachment.Value and targetAttachment.Value:FindFirstAncestorWhichIsA("Model")

										while model and model:FindFirstChild("ActualCharacter") do
											model = model.ActualCharacter.Value
										end

										return model and model.Name
									end

									obj = setmetatable({}, { __mode = v85[124] })

									do
										local tbl27 = {}
										local v110 = nil

										for _, v111 in v93.Packages._Index["sleitnick_net@0.1.0"].net:GetChildren() do
											if v111:IsA("UnreliableRemoteEvent") and v111.Name ~= "URE/ReplicateBallPosition" then
												local connection = v111.OnClientEvent:Connect(function(F,P)if typeof(F)=="Instance"and typeof(P)=="Vector3"and(F.Parent== balls or F.Parent== trainingBalls )then local x= obj [F];if not x then x={}; obj [F]=x;end;x.Position=P;x.UpdatedAt=os.clock();if not  v110 then for F,P in  tbl27 ,nil,nil do if F~= v111 then P:Disconnect(); flyteBBState .Connections[F]=nil;end;end; v110 = v111 ;end;end;end)
												tbl27[v111] = connection
												flyteBBState.Connections[v111] = connection
											end
										end
									end
								end
							end

							do
								fn52 = function(arg)
									if arg then
										arg = arg:IsA("BasePart") and arg or arg:IsA("Model") and arg.PrimaryPart or arg:FindFirstChild("Body")
									end

									return arg
								end

								fn53 = function(arg, arg2, arg3)
									local v109 = obj[arg]

									if not v109 then
										v109 = arg2 or fn52(arg)
										v109 = v109 and obj[v109]
									end

									local flag19

									if v109 then
										flag19 = (arg3 or os.clock()) - (v109.UpdatedAt or v85[33]) <= v85[152]
									else
										flag19 = v109
									end

									if flag19 then
										return v109.Position
									end
								end

								fn54 = function(arg)
									local v109 = fn53(arg)
									if v109 then
										return v109
									end
									local v110 = fn52(arg)
									return v110 and v110.Position or Vector3.zero
								end

								fn55 = function(arg)
									local zoomies = arg and arg:FindFirstChild("zoomies")
									if zoomies then
										return zoomies.VectorVelocity
									end
									local attribute = arg and arg:GetAttribute("Velocity")
									return typeof(attribute) == "Vector3" and attribute or Vector3.zero
								end

								fn56 = function(arg)
									local body

									if arg then
										local attribute = arg:IsA("BasePart") and arg:GetAttribute("realBall")

										if attribute then
											body = attribute
										else
											body = arg:IsA("Model") and arg:FindFirstChild("Body") and arg:FindFirstChild(v85[149])
										end
									else
										body = arg
									end

									return body
								end

								fn57 = function(arg)
									return arg and arg:IsA("Model") and arg:FindFirstChild("Body") and arg:FindFirstChild(v85[149]) and not arg:FindFirstChild("zoomies")
								end

								obj2 = setmetatable({}, { __mode = "k" })

								fn58 = function(arg)
									local v109 = obj2[arg]

									if not v109 then
										local v110 = fn51(arg)
										local tbl26 = { Parried = false, ParryResetAt = 0, Target = v110, LoopTarget = v110 }
										obj2[arg] = tbl26
										v109 = tbl26
									end

									return v109
								end

								do
									local function fn69()
										return (v96 or localPlayer:GetNetworkPing() * 1000) / 1000
									end

									fn59 = function()
										local n33 = v96

										if not v96 then
											local v109 = v85[66]
											n33 = localPlayer:GetNetworkPing() * v109
										end

										return n33
									end

									fn60 = function(arg, arg2, arg3)
										local huge = math.huge
										local children = arg3 and fn47() or alive:GetChildren()
										local v109 = nil

										for _, v110 in children, nil, nil do
											if v110 ~= arg then
												local isBasePart = v110:IsA("BasePart") and v110 or v110.PrimaryPart or v110:FindFirstChild("HumanoidRootPart")
												local flag19

												if isBasePart then
													flag19 = not arg3

													if not flag19 then
														flag19 = isBasePart.Parent

														if flag19 then
															flag19 = (isBasePart:GetAttribute(v85[138]) or 1) > v85[33]
														end
													end
												else
													flag19 = isBasePart
												end

												if flag19 then
													local magnitude = (arg2 - isBasePart.Position).Magnitude

													if magnitude < huge then
														huge = magnitude
														v109 = isBasePart
													end
												end
											end
										end

										return huge, v109, #children
									end

									fn61 = function(F)local P= localPlayer .Character;local x=P and(P.PrimaryPart or(P:FindFirstChild("HumanoidRootPart")));P= alive and  alive .Parent and  alive or(workspace:FindFirstChild("Alive"));local T=type(F)=="string"and P and(P:FindFirstChild(F));F=T and(T.PrimaryPart or(T:FindFirstChild("HumanoidRootPart")));P=x and F and x.Position-F.Position;return P and P.Magnitude>0.001 and P or nil;end
									fn62 = function(F,P)local x=P.Zoomies;local f= fn51 (F);if not  tbl20 .BackwardsAntiCurveEnabled or not x or F.Parent== trainingBalls or f== localPlayer .Name then return;end;if F:GetAttribute("DribbleActive")==true then P.CurveReference=nil;return;end;F=x.VectorVelocity;f=F.Magnitude;if f~=f or f==math.huge or f<0.001 then return;end;P.CurveReference=F;end
									fn63 = function(F,P,x,f)if not  tbl20 .BackwardsAntiCurveEnabled or not F or F.Parent== trainingBalls or( fn57 (F))then return false;end;if(x or( fn51 (F)))~= localPlayer .Name then return false;end;local h,M= fn58 (F),P.Magnitude;if M~=M or M==math.huge or M<0.001 then return false;end;local C,Y,R=h.CurveSource,h.CurveTargetDirection,F:GetAttribute("from");if f and(not C or not Y)then if type(R)=="string"and R~=""and R~= localPlayer .Name then C,Y=R,( fn61 (R));end;end;if not C or R~=C or not Y then return false;end;F=Y.Magnitude;if F<0.001 then return false;end;x=h.CurveReference;local J,l=x and x.Magnitude or 0,Y:Dot(P)/(F*M);if J<0.001 then return f and M>=35 and l<-0.45;end;f,R=x:Dot(P)/(J*M),false;if f>0.2 and l>=-0.45 and l<0 then local t= fn61 (C);local U=t and t.Magnitude or 0;if U>0.001 then local H=t:Dot(P)/(U*M);R=f>0.95 and l<-0.2 and H<-0.2;if H<l then l,F,Y=H,U,t;end;end;end;local t=R or f>0.2 and l<-0.45;if not t and(math.abs(Y.Y)>F*0.1 or f>0.2 and l<-0.2)then local F,U,H=Vector3.new(x.X,0,x.Z),Vector3.new(P.X,0,P.Z),Vector3.new(Y.X,0,Y.Z);local P,x,Y=F.Magnitude,U.Magnitude,H.Magnitude;if P>J*0.35 and x>M*0.35 and Y>0.001 then t=F:Dot(U)/(P*x)>0.2 and H:Dot(U)/(Y*x)<-0.45;if t and Y<=1 then R= fn61 (C);local T=R and(Vector3.new(R.X,0,R.Z));local F=T and T.Magnitude or 0;t=F>0.001 and T:Dot(U)<-0.45*F*x;end;end;end;if not t and l>0.2 and f<0 then h.CurveReference=nil;end;return t;end

									fn64 = function(arg)
										local connections = arg.Connections
										local curveVelocity = connections and connections.CurveVelocity

										if curveVelocity then
											curveVelocity:Disconnect()
											connections.CurveVelocity = nil
										end

										arg.CurveReference = nil
										arg.CurveSource = nil
										arg.CurveTargetDirection = nil
										arg.CurveReady = nil
										arg.CurveVersion = (arg.CurveVersion or 0) + 1
									end

									fn65 = function(arg)
										arg.CurveTime = os.clock()
										arg.CurveWarping = nil
									end

									fn66 = function(arg)
										arg.CurveTime = nil
										arg.CurveWarping = nil
									end

									fn67 = function(arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
										if not tbl20.AntiCurveEnabled or not arg or arg.Parent == trainingBalls or fn57(arg) then
											return false
										end

										if (arg8 or fn51(arg)) ~= localPlayer.Name then
											return false
										end
										arg4 = arg4 or fn55(arg)
										arg6 = arg6 or arg4.Magnitude
										if arg6 ~= arg6 or arg6 == math.huge or arg6 < 0.001 then
											return false
										end

										if not arg2 then
											arg2 = localPlayer.Character

											if arg2 then
												arg2 = arg2:FindFirstChild("HumanoidRootPart") or arg2.PrimaryPart
											end
										end

										if not arg2 then
											return false
										end

										if not arg7 then
											arg7 = arg2.Position - (arg3 or fn54(arg))
										end

										arg5 = arg5 or arg7.Magnitude
										if arg5 ~= arg5 or arg5 == math.huge or arg5 < 0.001 then
											return false
										end
										local v109 = fn58(arg)
										local n33 = arg7:Dot(arg4) / arg5 * arg6
										local n34 = math.min(arg6 / v85[158], 40)
										local n35 = 7 * math.max(n33, 0)
										local n36 = 15 - math.min(arg5 / 1000, v85[147]) + n35 + n34

										if arg5 < n36 then
											v109.CurveTime = nil
											v109.CurveWarping = nil
											return false
										end

										local now2 = os.clock()
										arg9 = arg9 or fn69()
										local n37 = math.max(arg5 / arg6 - arg9, 0)

										if n33 < 0.85797987377317875 then
											v109.CurveWarping = now2
										end

										local curveWarping = v109.CurveWarping

										if curveWarping then
											if now2 - curveWarping < n37 * (1 - math.clamp(n33, 0, 1)) then
												return true
											end
											v109.CurveWarping = nil
										end

										local curveTime = v109.CurveTime

										if curveTime then
											if now2 - curveTime < n37 / 1.5 and n37 > n36 / arg6 then
												return true
											end
											v109.CurveTime = nil
										end

										return n33 < 0.5 - arg9
									end
								end
							end

							flag18 = false
							n32 = 0
							v107 = nil
							v108 = nil

							fn68 = function(arg)
								flag18 = false
								n32 = 0
								v107 = nil
								v108 = nil
								flyteBBState.SelfDribbleBall = nil
								flyteBBState.SelfDribbleAway = nil
								flyteBBState.AutoBall = nil
								flyteBBState.AutoParryAt = nil
								flyteBBState.ManualBall = nil
								flyteBBState.ExtraParryCooldownUntil = nil
								local v109 = balls or workspace:FindFirstChild(v85[182])
								if not v109 then
									return
								end

								for _, v110 in v109:GetChildren() do
									if fn56(v110) then
										local v111 = fn58(v110)
										v111.Parried = false
										v111.ParryResetAt = 0
										v111.AutoParryAt = nil
										v111.TriggerbotParried = false
										v111.InvisibleReturnAway = nil
										fn66(v111)
										local flag19

										if arg then
											local name = localPlayer.Name
											flag19 = fn51(v110) == name
										else
											flag19 = arg
										end

										if flag19 then
											v111.TargetChanges = math.max(v111.TargetChanges or 0, v85[70])
										end
									end
								end
							end

							do
								local function fn69(arg, arg2)
									if not tbl25.Ball or not tbl25.Ball.GetAllBalls then
										return
									end
									local str5 = tostring(arg)
									local v109 = v85[165]
									local position = typeof(arg2) == v109 and arg2:IsA("BasePart") and arg2.Position
									local v110 = nil
									local v111 = nil
									local v112 = nil
									local v113 = nil

									for _, v114 in tbl25.Ball.GetAllBalls() do
										local magnitude = nil

										if position then
											magnitude = (fn54(v114) - position).Magnitude

											if not v110 or magnitude < v110 then
												v110 = magnitude
												v111 = v114
											end
										end

										if v114.Name == str5 and (not v112 or magnitude and magnitude < v113) then
											v112 = v114
											v113 = magnitude
										end
									end

									return v112 or v111 or tbl25.Ball.GetMainBall()
								end

								if v93.Remotes:FindFirstChild("ParrySuccessAll") then
									flyteBBState.Connections["Parry All"] = v93.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(arg, arg2, arg3, arg4, arg5)
										local abilityESPEnabled = tbl20.AbilityESPEnabled

										if abilityESPEnabled then
											local v109 = v85[165]
											abilityESPEnabled = typeof(arg4) == v109
										end

										if abilityESPEnabled and arg4:IsA(v85[134]) and arg4 ~= localPlayer then
											local character = arg4.Character

											if (character and tbl25.Visuals and tbl25.Visuals.GetInfo(arg4, character)) == "Slashes of Fury" and character:GetAttribute("FuryCatch") then
												local huge = math.huge
												local position = typeof(arg2) == "Instance" and arg2:IsA(v85[53]) and arg2.Position
												local v109 = nil

												for _, v110 in workspace.Balls:GetChildren() do
													if v110:IsA(v85[53]) and not v110:GetAttribute("realBall") then
														if v110.Name == tostring(arg5 or arg) then
															v109 = v110
															break
														elseif position then
															local magnitude = (v110.Position - position).Magnitude

															if magnitude < huge then
																v109 = v110
																huge = magnitude
															end
														end
													end
												end

												if v109 then
													local tbl26 = flyteBBState.AbilityUses[arg4]

													if not tbl26 or tbl26.Character ~= character or tbl26.Ability ~= "Slashes of Fury" then
														tbl25.Visuals.ClearFury(tbl26)

														tbl26 = {
															Ability = "Slashes of Fury",
															Character = character,
															Uses = 0,
															Started = workspace:GetServerTimeNow(),
														}

														flyteBBState.AbilityUses[arg4] = tbl26
													end

													tbl26.Uses = math.min(tbl26.Uses + 1, 35)
													tbl25.Visuals.UpdateFuryCount(v109, tbl26)
												end
											end
										end

										local character = localPlayer.Character
										local primaryPart = character and character.PrimaryPart
										if not primaryPart then
											return
										end
										local v109 = fn69(arg, arg2)
										if not v109 then
											return
										end

										if arg4 == localPlayer then
											local now2 = os.clock()
											local v110 = v85[66]
											local n33 = math.clamp(fn59() / v110 + v85[22], 0.15, 1)
											local autoBall = flyteBBState.AutoBall
											local v111 = autoBall and obj2[autoBall]
											local flag19 = autoBall and autoBall.Parent and v111 and v111.AutoParryAt and now2 - v111.AutoParryAt <= n33

											if not flag19 then
												autoBall = v109
											end

											local v112 = fn58(autoBall)
											local flag20

											if flag19 then
												flag20 = flag19
											else
												flag20 = v112.AutoParryAt and now2 - v112.AutoParryAt <= n33
											end

											local flag21 = not flag20

											if flag21 then
												v112.Parried = true
												v112.ParryResetAt = now2 + 0.6
												flag18 = true
												v107 = autoBall
												n32 = v112.ParryResetAt
											end

											v112.AutoParryAt = nil

											if flyteBBState.AutoBall == autoBall then
												flyteBBState.AutoBall = nil
											end

											if flag21 then
												local name = localPlayer.Name
												flag21 = fn51(autoBall) == name
											end

											if flag21 then
												flyteBBState.ManualBall = autoBall

												if tbl20.TriggerbotEnabled then
													v112.TriggerbotTarget = localPlayer.Name
													v112.TriggerbotParried = v85[200]
												end
											end

											local ball = flag20 and tbl20.AutoParryEnabled and tbl25.Loop and tbl25.Loop.MainParryLoop and tbl25.Ball

											if ball then
												local v113 = v85[18]
												ball = #tbl25.Ball.GetAllBalls() > v113
											end

											if ball then
												tbl25.Loop.MainParryLoop()
											end

											return
										end

										local v110 = fn55(v109)
										local magnitude = v110.Magnitude
										if magnitude < 0.001 then
											return
										end
										local unit = v110.Unit
										local n33 = primaryPart.Position - fn54(v109)
										local magnitude2 = n33.Magnitude
										if magnitude2 < v85[116] then
											return
										end
										local v111 = n33.Unit:Dot(unit)

										if tbl20.AutoParryEnabled and magnitude > 100 and arg2 and arg2.Parent and arg2.Parent ~= character and arg2.Parent.Parent == alive and not flag18 then
											local getClosest = tbl25.Player and tbl25.Player.GetClosest and tbl25.Player.GetClosest()

											if getClosest and getClosest.PrimaryPart and (primaryPart.Position - getClosest.PrimaryPart.Position).Magnitude < 15 and magnitude2 < 15 and v111 > -0.25 and fn67(v109) then
												flag18 = v85[200]
												v107 = v109
												n32 = os.clock() + 0.6

												if not fn40(nil, nil, nil, nil, nil, tbl20.ParryAccuracy or 50) then
													flag18 = v85[101]
													v107 = nil
												end
											end
										end
									end)
								end
							end
						end

						local fn69, fn70, fn71

						do
							do
								fn43({
									FuryDetection = true,
									FurySpamHit = false,
									FuryParryAmount = v85[59],
									FuryParryDelay = 0.05,
									FuryParryMethod = "Remote",
								})

								do
									local function fn72()
										local function fn73()
											local character = localPlayer.Character
											local abilities = character and character:FindFirstChild("Abilities")
											abilities = abilities and abilities:FindFirstChild("Slashes of Fury")
											local hotbar = localPlayer.PlayerGui:FindFirstChild("Hotbar")
											local red = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Red")

											if tbl20.FuryDetection and character and character.Parent == alive and abilities and abilities.Enabled and red and not red.Visible and #balls:GetChildren() > 0 then
												flyteBBState.FuryCatch = true
												flyteBBState.FuryActive = false
											end
										end

										local function fn74(arg)
											if not tbl20.FuryDetection or not flyteBBState.FuryCatch then
												return
											end
											local v109 = arg:FindFirstChildOfClass(v85[65])
											if not v109 then
												return
											end
											flyteBBState.FuryActive = v85[200]
											local n33 = tonumber(v109.Text) or 0
											local tbl26 = {}
											local furyParryMethod = tbl20.FuryParryMethod
											local v110 = n33

											while true do
												local now2 = os.clock()
												local furyParryMethod2 = tbl20.FuryParryMethod
												local num = tonumber(v109.Text)

												if num then
													local v111

													if furyParryMethod2 == furyParryMethod then
														v111 = n33
													else
														table.clear(tbl26)
														furyParryMethod = furyParryMethod2
														v111 = num
														v110 = num
													end

													if furyParryMethod2 == "Remote" then
														n33 = math.max(v111, num)
													else
														for i = 1, math.min(math.max(num - v110, 0), #tbl26) do
															table.remove(tbl26, 1)
														end

														while tbl26[1] and now2 >= tbl26[1] do
															table.remove(tbl26, 1)
														end

														local n34 = math.max(v110, num)
														n33 = n34 + #tbl26
														v110 = n34
													end
												end

												num = tbl20.FurySpamHit and num

												if num then
													num = n33 < (tbl20.FuryParryAmount or v85[59])
												end

												if num then
													local v111

													if furyParryMethod2 == "Remote" and tbl25.Parry and tbl25.Parry.Fire then
														flyteBBState.ParryMethod = "Remote"
														v111 = tbl25.Parry.Fire()
													else
														v111 = tbl25.Animation.Input(furyParryMethod2)
													end

													if v111 then
														n33 += 1

														if furyParryMethod2 ~= v85[90] then
															local n34 = #tbl26 + 1
															local max = math.max
															local v112 = v85[110]
															local v113 = v85[22]
															tbl26[n34] = os.clock() + max(v112, fn59() / 1000 + v113)
														end
													end
												end

												local furyParryDelay = tbl20.FuryParryDelay or 0.12
												local wait_ = task.wait
												local flag19 = furyParryMethod2 == "Remote" and furyParryDelay

												if not flag19 then
													local v111 = v85[33]
													flag19 = math.max(furyParryDelay - os.clock() - now2, v111)
												end

												wait_(flag19)
												if not (not tbl20.FuryDetection or not flyteBBState.FuryCatch or not v109:IsDescendantOf(workspace)) then
													continue
												end
												break
											end

											flyteBBState.FuryCatch = false
											flyteBBState.FuryActive = false
										end

										local function fn75(child)
											local str5 = "Fury Ball " .. child:GetDebugId()
											local comboCounter = child:FindFirstChild("ComboCounter")

											if comboCounter then
												task.spawn(fn74, comboCounter)
											end

											fn42(str5)

											flyteBBState.Connections[str5] = child.ChildAdded:Connect(function(child2)
												if child2.Name == "ComboCounter" then
													fn74(child2)
												end
											end)
										end

										for _, v109 in balls:GetChildren() do
											fn75(v109)
										end

										flyteBBState.Connections["Fury Ball Added"] = balls.ChildAdded:Connect(fn75)

										flyteBBState.Connections["Fury Ball Removed"] = balls.ChildRemoved:Connect(function(child)
											fn42("Fury Ball " .. child:GetDebugId())
										end)

										local UserInputService = require(v93.UserInputService)
										local SettingsController = require(v93.Controllers.SettingsController)
										local net = v93.Packages._Index["sleitnick_net@0.1.0"].net

										flyteBBState.Connections["Fury Input"] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
											if not gameProcessed and SettingsController:UseBind(input, "Ability") then
												fn73()
											end
										end)

										flyteBBState.Connections["Fury Button"] = abilityButtonPress.Event:Connect(fn73)

										flyteBBState.Connections["Fury Catch"] = net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
											flyteBBState.FuryCatch = v85[200]
											flyteBBState.FuryActive = false
										end)

										flyteBBState.Connections["Fury End"] = net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
											flyteBBState.FuryCatch = false
											flyteBBState.FuryActive = false
										end)
									end

									fn40 = function(spamBall, arg, arg2, arg3, arg4, arg5)
										local character = localPlayer.Character
										if not fn46(character) then
											return false
										end

										if fn48(character) then
											return false
										end

										if not spamBall then
											spamBall = tbl25.Ball and tbl25.Ball.GetMainBall and tbl25.Ball.GetMainBall()
										end

										if not spamBall then
											return false
										end
										arg = arg or tbl20.AutoParryType

										if arg == "Remote" then
											if tbl25.Parry and tbl25.Parry.Fire then
												flyteBBState.ParryMethod = "Remote"
												local flag19 = not arg3

												if flag19 then
													local name = localPlayer.Name
													flag19 = fn51(spamBall) ~= name
												end

												if flag19 then
													return false
												end

												if fn57(spamBall) then
													flyteBBState.ParryMethod = "VIM"
													if not tbl25.Animation.VIM() then
														return false
													end
												else
													local now2 = os.clock()

													if flyteBBState.ParryCooldownUntil and now2 >= flyteBBState.ParryCooldownUntil then
														flyteBBState.AutoParryAnimationPlayed = nil
													end

													local flag20 = not flyteBBState.AutoParryAnimationPlayed and (not flyteBBState.ParryCooldownUntil or now2 >= flyteBBState.ParryCooldownUntil)
													local v109, v110 = tbl25.Parry.Fire(arg2 and tbl25.Curve.GetCFrame() or nil)
													if not v109 then
														return false
													end

													if flag20 and flyteBBState.ParryMethod == "Remote" then
														if v110 or tbl25.Animation.PlayAnimation(v85[200]) then
															flyteBBState.AutoParryAnimationPlayed = true
														end
													end
												end
											end
										else
											local flag19 = not arg3

											if flag19 then
												local name = localPlayer.Name
												flag19 = fn51(spamBall) ~= name
											end

											if flag19 then
												return false
											end
											local n33 = v85[33]

											if arg == "Mouse Click" and arg5 then
												local primaryPart = character.PrimaryPart
												local magnitude = fn55(spamBall).Magnitude

												if primaryPart and magnitude > 0 then
													local n34 = (primaryPart.Position - fn54(spamBall)).Magnitude / magnitude
													local n35 = math.clamp((arg5 - 1) / 99, 0, 1)
													n33 = math.clamp(n34 * (0.16 - n35 * 0.07), 0.02 - n35 * 0.008, 0.055 - n35 * 0.01)
												end
											end

											if not tbl25.Animation.Input(arg, nil, n33) then
												return false
											end
										end

										if tbl20.AutoSpamEnabled then
											local now2 = os.clock()

											while flyteBBState.SpamParries[1] and flyteBBState.SpamParries[1] < now2 - 0.75 do
												table.remove(flyteBBState.SpamParries, 1)
											end

											flyteBBState.SpamParries[#flyteBBState.SpamParries + v85[18]] = now2
											local flag19 = not arg3

											if flag19 then
												local name = localPlayer.Name
												flag19 = fn51(spamBall) == name
											end

											if flag19 then
												flyteBBState.SpamBall = spamBall
												flyteBBState.SpamTargetAt = now2
											end
										end

										flyteBBState.PreclickFired = nil
										flyteBBState.PreclickCooldown = nil
										flyteBBState.ParryActiveUntil = os.clock() + math.max(0, 0.5 - (arg4 or fn59()) / 2000)
										flyteBBState.CooldownProtected = nil
										return true
									end

									local function fn73()
										if flyteBBState.InfinityParried or not tbl20.InfinityDetection then
											return false
										end
										local getMainBall = tbl25.Ball and tbl25.Ball.GetMainBall and tbl25.Ball.GetMainBall()
										local character = localPlayer.Character
										character = character and character:FindFirstChild("HumanoidRootPart")
										local flag19 = not getMainBall or not character

										if not flag19 then
											local name = localPlayer.Name
											flag19 = fn51(getMainBall) ~= name
										end

										if not flag19 then
											local position = character.Position
											flag19 = (fn54(getMainBall) - position).Magnitude > 10
										end

										if flag19 then
											return v85[101]
										end
										flyteBBState.InfinityParried = true
										local v109 = fn58(getMainBall)

										if v109 then
											v109.Parried = true
											v109.ParryResetAt = os.clock() + 0.6
										end

										flag18 = true
										v107 = getMainBall
										n32 = os.clock() + 0.6
										if fn40(getMainBall, tbl20.AutoParryType, v85[200]) then
											return true
										end

										if v109 then
											v109.Parried = v85[101]
										end

										flag18 = false
										v107 = nil
										flyteBBState.InfinityParried = false
										return false
									end

									fn43({
										InfinityDetection = true,
										FreezeDetection = false,
										DeathSlashDetection = true,
										DeathSlashMinigame = v85[101],
										SingularityDetection = true,
										TimeHoleDetection = true,
										ForcefieldDetection = false,
										ParryOnDribble = v85[101],
										DribbleDetection = v85[101],
									})

									tbl25.Detection = {}

									tbl25.Detection.GetDribbleBall = function(arg)
										local flag19 = not tbl20.ParryOnDribble or not arg or not fn56(arg) or arg:GetAttribute("DribbleActive") ~= true

										if not flag19 then
											local name = localPlayer.Name
											flag19 = fn51(arg) == name
										end

										if flag19 then
											return
										end
										local v109 = balls
										local v110

										if balls then
											v110 = v109
										else
											v110 = workspace:FindFirstChild(v85[182])
										end

										if not v110 then
											return
										end

										for _, v111 in v110:GetChildren() do
											if v111 ~= arg and v111.Name == arg.Name and not fn56(v111) and v111:GetAttribute("highlighted") == true then
												return arg
											end
										end
									end

									tbl25.Detection.GetSelfDribbleBall = function(selfDribbleBall, arg)
										if not tbl20.DribbleDetection then
											flyteBBState.SelfDribbleBall = nil
											flyteBBState.SelfDribbleAway = nil
											return nil, false
										end

										local flag19 = not selfDribbleBall.Parent or not fn56(selfDribbleBall) or selfDribbleBall:GetAttribute("DribbleActive") ~= true
										local flag20

										if flag19 then
											flag20 = flag19
										else
											local name = localPlayer.Name
											flag20 = fn51(selfDribbleBall) ~= name
										end

										if flag20 then
											if flyteBBState.SelfDribbleBall == selfDribbleBall then
												flyteBBState.SelfDribbleBall = nil
												flyteBBState.SelfDribbleAway = nil
											end

											return nil, false
										end

										if flyteBBState.SelfDribbleBall ~= selfDribbleBall then
											flyteBBState.SelfDribbleBall = selfDribbleBall
											flyteBBState.SelfDribbleAway = false
										end

										local flag21 = (arg.Position - fn54(selfDribbleBall)):Dot(fn55(selfDribbleBall)) > 0

										if not flag21 then
											flyteBBState.SelfDribbleAway = true
										end

										return selfDribbleBall, flyteBBState.SelfDribbleAway and flag21
									end

									tbl25.Detection.TrackAbilityUse = function(arg, arg2, arg3, maximum, arg4)
										local serverTimeNow = workspace:GetServerTimeNow()
										local tbl26 = flyteBBState.AbilityUses[arg]

										if not tbl26 or tbl26.Ability ~= arg3 or tbl26.Character ~= arg2 then
											tbl26 = { Ability = arg3, Character = arg2, Recoveries = {} }
											flyteBBState.AbilityUses[arg] = tbl26
										end

										for i = #tbl26.Recoveries, 1, -1 do
											if tbl26.Recoveries[i] <= serverTimeNow then
												table.remove(tbl26.Recoveries, i)
											end
										end

										tbl26.Maximum = maximum

										if #tbl26.Recoveries < maximum then
											tbl26.Recoveries[#tbl26.Recoveries + 1] = serverTimeNow + arg4
										end
									end

									fn69 = function(arg, arg2)
										local flag19 = tbl20.FreezeDetection and arg:GetAttribute("Frozen") == true

										if flag19 then
											flag19 = (arg2 or fn51(arg)) == localPlayer.Name
										end

										local flag20

										if flag19 then
											flag20 = not (tbl20.AutoPlayEnabled and tbl20.HitFreeze)
										else
											flag20 = flag19
										end

										return flag20
									end

									tbl25.Detection.BlocksParry = function(arg, arg2, arg3)
										local humanoidRootPart = arg3 or arg2 and arg2:FindFirstChild("HumanoidRootPart")
										if not humanoidRootPart then
											return true
										end

										if arg and fn69(arg) then
											return true
										end
										local tornado = runtime:FindFirstChild("Tornado")

										if tornado then
											local attribute = tornado:GetAttribute("TornadoTime")

											if flyteBBState.Tornado ~= tornado or flyteBBState.TornadoDuration ~= attribute or not flyteBBState.TornadoAt then
												flyteBBState.Tornado = tornado
												flyteBBState.TornadoDuration = attribute
												flyteBBState.TornadoAt = tick()
											end

											local tornadoAt = flyteBBState.TornadoAt
											if tick() - tornadoAt < (attribute or 1) + 0.314159 then
												return true
											end
										elseif flyteBBState.Tornado then
											flyteBBState.Tornado = nil
											flyteBBState.TornadoDuration = nil
											flyteBBState.TornadoAt = nil
										end

										if tbl20.SingularityDetection and humanoidRootPart:FindFirstChild("SingularityCape") then
											return true
										end

										if tbl20.FuryDetection and (flyteBBState.FuryCatch or flyteBBState.FuryActive) then
											return true
										end

										if tbl20.DeathSlashDetection and flyteBBState.DeathSlash then
											return true
										end
										local abilities = arg2:FindFirstChild("Abilities")
										local visible = duration and duration.Visible
										local timeHole = abilities and abilities:FindFirstChild("Time Hole")
										if tbl20.TimeHoleDetection and (flyteBBState.TimeHole or visible and timeHole and timeHole.Enabled) then
											return true
										end

										if tbl20.InfinityDetection and (flyteBBState.InfinityActive or fn49("Infinity")) then
											return true
										end

										if tbl20.ForcefieldDetection and fn49("Forcefield") and (humanoidRootPart:FindFirstChild("MaxShield") or humanoidRootPart:FindFirstChild("Shield")) then
											return v85[200]
										end
										return v85[101], abilities
									end

									flyteBBState.Connections["Parry Cooldown"] = v93.Remotes.VisualCD.OnClientEvent:Connect(function(arg, arg2, arg3)
										if not arg then
											return
										end
										local now2 = os.clock()

										if arg2 then
											flyteBBState.ParryCooldownUntil = now2 + (tonumber(arg3) or 1.3)
											local v109 = v85[66]
											local n33 = math.clamp(fn59() / v109 + 0.1, 0.15, 1)

											if not (flyteBBState.AutoBall or flyteBBState.AutoParryAt and now2 - flyteBBState.AutoParryAt <= n33) and not (flyteBBState.AutoSpamParryAt and now2 - flyteBBState.AutoSpamParryAt <= n33) then
												flyteBBState.ExtraParryCooldownUntil = flyteBBState.ParryCooldownUntil
											end

											flyteBBState.PreclickCooldown = flyteBBState.PreclickFired or nil
											flyteBBState.PreclickFired = nil
											flyteBBState.ParryActiveUntil = now2 + math.max(0, v85[81] - fn59() / 2000)
											flyteBBState.CooldownProtected = nil
										else
											flyteBBState.ParryCooldownUntil = nil
											flyteBBState.ExtraParryCooldownUntil = nil
											flyteBBState.AutoParryAt = nil
											flyteBBState.AutoParryAnimationPlayed = nil
											flyteBBState.PreclickCooldown = nil
											flyteBBState.CooldownProtected = nil
											flyteBBState.ManualBall = nil

											if tbl20.TriggerbotEnabled then
												tbl25.Triggerbot.Update()
											elseif tbl20.AutoParryEnabled then
												task.spawn(tbl25.Loop.MainParryLoop)
											end
										end
									end)

									tbl25.Detection.UseProtection = function(arg, arg2)
										local now2 = os.clock()

										if not (flyteBBState.ParryCooldownUntil and now2 < flyteBBState.ParryCooldownUntil or v105 and v105.Offset.Y < 0.49) then
											flyteBBState.ParryCooldownUntil = nil
											flyteBBState.PreclickFired = nil
											flyteBBState.PreclickCooldown = nil
											flyteBBState.CooldownProtected = nil
										elseif tbl20.CooldownProtectionEnabled then
											if flyteBBState.CooldownProtected then
												return true
											end

											if now2 < (flyteBBState.ParryActiveUntil or 0) then
												return true
											end
											local getMainBall = tbl25.Ball and tbl25.Ball.GetMainBall and tbl25.Ball.GetMainBall()
											local magnitude = (getMainBall and fn55(getMainBall) or Vector3.zero).Magnitude
											local flag19 = not getMainBall or magnitude < v85[59]
											local flag20

											if flag19 then
												flag20 = flag19
											else
												local name = localPlayer.Name
												flag20 = fn51(getMainBall) ~= name
											end

											if flag20 then
												return true
											end

											if flyteBBState.PreclickCooldown then
												local n33 = fn59() / 1000
												if math.max(0, (arg.PrimaryPart.Position - fn54(getMainBall)).Magnitude - v85[174]) / magnitude - n33 > math.max(0, 0.5 - n33) then
													return v85[200]
												end
											end

											if v106 and v106.Offset.Y >= 0.49 then
												flyteBBState.CooldownProtected = true
												abilityButtonPress:Fire()
												return v85[200], true
											end

											return true
										end

										if arg2 then
											return false
										end

										if tbl20.AutoAbilityEnabled then
											arg = arg and arg:FindFirstChild("Abilities")

											if tbl25.Ball and tbl25.Ball.GetMainBall then
												tbl25.Ball.GetMainBall()
											end

											if fn50(arg) then
												return true, true
											end
										end

										return false
									end

									local function fn74()
										local deathSlashTimer

										while true do
											deathSlashTimer = localPlayer.PlayerGui:FindFirstChild("DeathSlashTimer")
											deathSlashTimer = deathSlashTimer and deathSlashTimer:FindFirstChild("Frame")

											if not deathSlashTimer then
												v88.PreRender:Wait()
											end

											if not (deathSlashTimer or not flyteBBState.DeathSlash or not tbl20.DeathSlashDetection or not tbl20.DeathSlashMinigame) then
												continue
											end
											break
										end

										if not deathSlashTimer or not flyteBBState.DeathSlash or not tbl20.DeathSlashDetection or not tbl20.DeathSlashMinigame then
											return
										end

										while true do
											v88.PreRender:Wait()
											if not (not flyteBBState.DeathSlash or not tbl20.DeathSlashDetection or not tbl20.DeathSlashMinigame or deathSlashTimer.Visible) then
												continue
											end
											break
										end

										local imageLabel = deathSlashTimer:FindFirstChild("ImageLabel")
										local circle = deathSlashTimer:FindFirstChild("Circle")
										local inner = deathSlashTimer:FindFirstChild("Inner")
										local n33 = circle and inner and (circle.Size.X.Scale + inner.Size.X.Scale) / 2

										while flyteBBState.DeathSlash and tbl20.DeathSlashDetection and tbl20.DeathSlashMinigame and deathSlashTimer.Visible and imageLabel and n33 do
											if imageLabel.Size.X.Scale <= n33 then
												abilityButtonPress:Fire()
												return
											end
											v88.PreRender:Wait()
										end
									end

									tbl25.Detection.Start = function()
										flyteBBState.Connections.Infinity = v93.Remotes.InfinityBall.OnClientEvent:Connect(function(arg, arg2)
											local infinityActive = flyteBBState.InfinityActive

											if arg2 then
												if fn49("Infinity") then
													flyteBBState.InfinityActive = v85[200]
													flyteBBState.InfinityParried = v85[101]
												end
											elseif infinityActive then
												flyteBBState.InfinityActive = false

												if tbl20.InfinityDetection then
													task.defer(fn73)
												end
											end
										end)

										flyteBBState.Connections["Death Slash"] = v93.Remotes.DeathBall.OnClientEvent:Connect(function(arg, arg2)
											if arg ~= localPlayer and arg ~= localPlayer.Name then
												return
											end
											local deathSlash = flyteBBState.DeathSlash
											flyteBBState.DeathSlash = arg2 == true

											if flyteBBState.DeathSlash and not deathSlash and tbl20.DeathSlashDetection and tbl20.DeathSlashMinigame then
												task.spawn(fn74)
											end
										end)

										task.spawn(function()
											local net = v93.Packages._Index["sleitnick_net@0.1.0"].net

											flyteBBState.Connections["Time Hole"] = net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(arg)
												if arg == localPlayer or arg == localPlayer.Name then
													flyteBBState.TimeHole = true
												end
											end)

											flyteBBState.Connections["Time Hole End"] = net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
												flyteBBState.TimeHole = false
											end)
										end)
									end

									tbl25.Detection.Start()
									fn72()
								end
							end

							do
								local fn72, fn73

								do
									tbl25.Staff = {
										Group = 12836673,
										Roles = {
											Mod = true,
											Support = true,
											Admin = true,
											Developer = v85[200],
											["Lead Developer"] = true,
											Management = v85[200],
											Executive = true,
											["Co-Owner"] = v85[200],
											Contributor = true,
											["Trial QA"] = true,
											Holder = true,
										},
									}

									fn43({ StaffDetection = false, StaffDetectionMode = "warn" })

									tbl25.Staff.Check = function(arg)
										if arg == localPlayer then
											return
										end

										if flyteBBState.StaffDetected[arg] or arg.Parent ~= v89 then
											return
										end
										local ok, result = pcall(arg.GetRoleInGroup, arg, tbl25.Staff.Group)

										if ok and tbl25.Staff.Roles[result] then
											flyteBBState.StaffDetected[arg] = true
											local str5 = "Staff Detected: " .. arg.Name .. " | " .. result

											if tbl20.StaffDetectionMode == "kick" then
												localPlayer:Kick(str5)
											else
												v103:Notify({ Title = str5, Duration = v85[147], Icon = "rbxassetid://128616761621643" })
											end
										end
									end

									tbl25.Staff.Set = function(arg)
										if not arg then
											fn42("Staff")
											table.clear(flyteBBState.StaffDetected)
											return
										end

										for _, v109 in v89:GetPlayers() do
											tbl25.Staff.Check(v109)
										end

										flyteBBState.Connections.Staff = v89.PlayerAdded:Connect(function(player)
											task.wait(1)

											if tbl20.StaffDetection then
												tbl25.Staff.Check(player)
											end
										end)
									end

									fn43({ DeviceSpoofType = "PC" })
									tbl25.DeviceSpoof = {}

									tbl25.DeviceSpoof.Apply = function()
										local str5 = [[local Source = %q
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
local Device = ]] .. v91:JSONEncode(tbl20.DeviceSpoofType == "Mobile" and "Phone" or tbl20.DeviceSpoofType) .. "if game.GameId ~= " .. tostring(game.GameId) .. [[ then return end
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

										local str6 = str5:format(str5)

										if genv.FlyteDeviceSpoofQueue then
											genv.FlyteDeviceSpoofQueue:Disconnect()
											genv.FlyteDeviceSpoofQueue = nil
										end
										;(queue_on_teleport or queueonteleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport)(str6)
										v103:Notify({ Title = "Rejoining...", Duration = v85[18] })
										task.wait(0.2)

										if not pcall(v95.TeleportToPlaceInstance, v95, game.PlaceId, game.JobId, localPlayer) then
											game.ExperienceService:LaunchExperience({ placeId = game.PlaceId, gameInstanceId = game.JobId })
										end
									end

									tbl25.LoadCurves = function()
										tbl25.Curve = {}
										tbl25.Curve.Random = Random.new()

										tbl25.Curve.GetCFrame = function(arg, arg2)
											local selectedParryType = tbl20.SelectedParryType or "Camera"
											local cFrame = currentCamera.CFrame
											if selectedParryType == "Camera" or selectedParryType == "BB Camera" then
												return cFrame
											end
											local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
											if not humanoidRootPart then
												return cFrame
											end

											if selectedParryType == "Randomized Backwards" then
												local cFrame2 = humanoidRootPart.CFrame
												local v109 = tbl25.Curve.Random:NextNumber(0, 6.2831853071795862)
												local v110 = tbl25.Curve.Random:NextNumber(0.2, 0.7)
												local upVector = cFrame2.UpVector
												return CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + (-cFrame2.LookVector + (cFrame2.RightVector * math.cos(v109) + upVector * math.sin(v109)) * v110).Unit * 10000)
											end

											if selectedParryType == "Backwards" then
												local n33 = -cFrame.LookVector * 10000
												return CFrame.new(cFrame.Position, cFrame.Position + Vector3.new(n33.X, v85[33], n33.Z)), nil
											end
											arg = arg or tbl25.Player.GetClosest()

											if arg then
												arg = arg:IsA("BasePart") and arg or arg.PrimaryPart or arg:FindFirstChild("HumanoidRootPart")
											end

											if arg and arg2 then
												local v109 = currentCamera:WorldToScreenPoint(arg.Position)
												local v110 = v85[70]
												local y = v109.Y
												arg2[1] = v109.X
												arg2[v110] = y
											end

											if selectedParryType == "Stop" then
												return CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(0, -3500, v85[33]))
											end

											if selectedParryType == "Random" then
												arg = arg and arg.Position - humanoidRootPart.Position
												local lookVector = arg or cFrame.LookVector
												if lookVector.Magnitude < 0.001 then
													return cFrame
												end
												local unit = lookVector.Unit
												local unit2 = unit:Cross(math.abs(unit.Y) < 0.9 and Vector3.new(0, 1, v85[33]) or Vector3.new(1, 0, 0)).Unit
												local v109 = unit2:Cross(unit)
												local v110 = tbl25.Curve.Random:NextNumber(0, 6.2831853071795862)
												local random2 = tbl25.Curve.Random
												return CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + (unit2 * math.cos(v110) + v109 * math.sin(v110) - unit * random2:NextNumber(v85[100], 0.8)).Unit * 1500)
											end

											if selectedParryType == "High" then
												return CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(0, 9e18, v85[33]))
											end

											if not arg then
												return humanoidRootPart.CFrame
											end
											local position = arg.Position
											if selectedParryType == "Straight" then
												return CFrame.new(humanoidRootPart.Position, position + Vector3.new(0, 10, 0))
											end

											if selectedParryType == "Dot" then
												return (position - humanoidRootPart.Position).Magnitude > 0.001 and CFrame.lookAt(humanoidRootPart.Position, position) or humanoidRootPart.CFrame
											end
											return humanoidRootPart.CFrame
										end
									end

									tbl25.LoadCurves()

									tbl25.LoadParry = function()
										local CollectionService = game:GetService("CollectionService")
										local tbl26 = {}
										local tbl27 = { 0, 0 }
										local tbl28 = { 1.5, 1.25, 1, 0.75, 0.625 }
										local ServerInfo = require(v93.ServerInfo)
										local UniverseIds = require(v93.Shared.UniverseIds)
										local flag19 = not ServerInfo.isDungeonsMatchServer() and game.PlaceId ~= UniverseIds.RankedMatches.PlaceId and game.PlaceId ~= UniverseIds.RankedMatchesNoAbility.PlaceId and not ServerInfo.isMedalServer() and not ServerInfo.isClanWarServer() and not ServerInfo.isTournamentMatchServer()
										local NoobParryEnabled

										if flag19 then
											local v109 = v85[200]
											NoobParryEnabled = require(v93.Common.Utils).FFlag.GetInstantFFlag("NoobParryEnabled", v109)
										else
											NoobParryEnabled = flag19
										end

										local swordsController = v93.Controllers["SwordsController \12"]
										local PRY = require(swordsController.PRY)

										local function fn74()
											error("devirt: storing a non-empty VM table into a register (at 54:73)")
										end

										local v109, v110 = fn74()
										local v111 = nil
										local v112 = nil
										local time = nil
										local tbl29 = {}
										local v113 = require(v93.Packages.Signal).new()
										v113:Connect(PRY)
										local flag20 = identifyexecutor() == "Volt"
										local v114 = nil
										local v115 = nil
										local v116 = newcclosure
										local v117 = hookfunction(Instance.new("RemoteEvent").FireServer, v116(function(F,...)if not  v111 and not checkcaller()then local P,x,f,h,M,C,Y,R=...;if P== v110 and type(x)=="string"and type(f)=="string"and type(h)=="number"and typeof(M)=="CFrame"and type(C)=="table"and type(Y)=="table"and type(R)=="boolean"then  v111 =F; v112 =x;end;end;return  v115 (F,...);end))

										local function fn75()
											local n33 = tbl28[(Data:Get("timesParried") or 0) + v85[18]] or 0.5
											if not NoobParryEnabled then
												return n33
											end
											local Kills = Data:Get("TotalStats.Kills") or 0
											return Kills < 20 and n33 * Kills / 20 or n33
										end

										local function fn76(arg, arg2, arg3, arg4, arg5)
											time = time or v109(v112, "TIME")
											local str5 = tostring(math.floor(workspace:GetServerTimeNow() * v85[158]))
											table.clear(tbl29)

											for i = 1, #str5 do
												local byte = string.byte
												local n33 = (i - v85[18]) % #time + v85[18]
												tbl29[i] = string.char(bit32.bxor((string.byte(str5, i) + i) % 256, byte(time, n33)))
											end

											local str6 = table.concat(tbl29)

											for i = 1, arg do
												v117(v111, v110, v112, str6, arg2, arg3, arg4, arg5, false)
											end
										end

										tbl25.Parry = {}

										tbl25.Parry.NativeClick = function()
											if flag20 then
												if not v114 or not v114.Enabled then
													v114 = nil
													local hotbar = localPlayer.PlayerGui:FindFirstChild("Hotbar")
													hotbar = hotbar and hotbar:FindFirstChild("Block")

													if hotbar then
														for _, v118 in getconnections(hotbar.Activated) do
															local function_ = v118.Function
															if v118.Enabled and function_ and getfenv(function_).script == swordsController then
																v114 = v118
																break
															end
														end
													end
												end

												if v114 then
													v114:Fire()
													return true
												end
											end

											return fn41()
										end

										local function fn77(arg)
											if arg then
												return false
											end
											local selectedParryType = tbl20.SelectedParryType or "Camera"
											return selectedParryType ~= v85[132] and selectedParryType ~= "BB Camera" and selectedParryType ~= "Backwards" and selectedParryType ~= "Randomized Backwards"
										end

										local function fn78(arg, arg2, arg3)
											arg = arg or tbl26
											arg2 = arg2 or tbl27
											table.clear(arg)
											local character = localPlayer.Character
											local flag21 = tbl20.SelectedParryType == "BB Camera"
											local flag22 = character and character.Parent ~= alive and fn45(character)

											if flag21 then
												flag22 = character and character.Parent == workspace.Dead and localPlayer:GetAttribute("LobbyTraining")
											end

											local vector2

											if v87.TouchEnabled then
												local viewportSize = currentCamera.ViewportSize
												vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
											else
												vector2 = v87:GetMouseLocation()
											end

											local y = vector2.Y
											arg2[v85[18]] = vector2.X
											arg2[2] = y

											if flag21 and flag22 then
												for _, v118 in workspace.Dead:GetChildren() do
													local playerFromCharacter = v89:GetPlayerFromCharacter(v118)
													local humanoidRootPart = v118:FindFirstChild("HumanoidRootPart")

													if playerFromCharacter and playerFromCharacter:GetAttribute("LobbyTraining") and humanoidRootPart then
														arg[v118.Name] = currentCamera:WorldToScreenPoint(humanoidRootPart.Position)
													end
												end

												for _, v118 in CollectionService:GetTagged("LobbyTrainingTarget") do
													arg[v118.Name] = currentCamera:WorldToScreenPoint(v118.Position)
												end

												return arg, arg2
											end

											local huge = math.huge
											local children

											if flag22 then
												children = fn47()
											else
												local parent = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
												children = nil

												if parent then
													alive = parent
													children = parent:GetChildren()
												end
											end

											if not children then
												return arg, arg2
											end
											local v118

											for _, v119 in children, nil, nil do
												local primaryPart = flag22 and v119 or v119.PrimaryPart

												if not flag22 and flag21 then
													primaryPart = v119:FindFirstChild("HumanoidRootPart")
												end

												local flag23

												if primaryPart then
													flag23 = not flag22

													if not flag23 then
														flag23 = v119.Parent

														if flag23 then
															flag23 = (v119:GetAttribute(v85[138]) or v85[18]) > 0
														end
													end
												else
													flag23 = primaryPart
												end

												if flag23 then
													local v120, v121 = currentCamera:WorldToScreenPoint(primaryPart.Position)
													arg[v119.Name] = v120

													if arg3 and v119 ~= character and v121 then
														local n33 = v120.X - vector2.X
														local n34 = v120.Y - vector2.Y
														local n35 = n33 * n33 + n34 * n34

														if n35 < huge then
															huge = n35
															v118 = v119
														end
													end
												elseif arg3 and not flag22 and v119 ~= character then
													local humanoidRootPart = v119:FindFirstChild("HumanoidRootPart")

													if humanoidRootPart then
														local v120, v121 = currentCamera:WorldToScreenPoint(humanoidRootPart.Position)
														local n33 = v120.X - vector2.X
														local n34 = v120.Y - vector2.Y
														local n35 = n33 * n33 + n34 * n34

														if v121 and n35 < huge then
															huge = n35
															v118 = v119
														end
													end
												end
											end

											return arg, arg2, v118
										end

										tbl25.Parry.GetData = function(arg, arg2)
											local tbl30 = arg2 or { {}, { v85[33], 0 } }
											local v118, v119, v120 = fn78(tbl30[1], tbl30[v85[70]], fn77(arg))
											arg = arg or tbl25.Curve.GetCFrame(v120, v119)
											tbl30[1] = v118
											tbl30[2] = v119
											tbl30[3] = arg
											return tbl30
										end

										tbl25.Parry.Fire = function(arg, arg2, arg3, arg4)
											local character = localPlayer.Character
											if character and fn48(character) then
												return false
											end
											local v118, v119

											if arg3 then
												v118 = arg3[1]
												v119 = arg3[v85[70]]
												arg = arg3[3]
											else
												local v120
												v118, v119, v120 = fn78(nil, nil, fn77(arg))
												arg = arg or tbl25.Curve.GetCFrame(v120, v119)
											end

											local v120 = fn75()
											arg4 = arg4 or v85[18]
											if v112 then
												fn76(arg4, v120, arg, v118, v119)
												return true
											end

											for i = 1, arg4 do
												v113:Fire(v120, arg, v118, v119, v85[101])

												if v112 then
													local n33 = arg4 - i

													if n33 > 0 then
														fn76(n33, v120, arg, v118, v119)
													end

													break
												end
											end

											return true
										end

										local fire = tbl25.Parry.Fire
										getgenv().FlyteParry = fire
									end

									tbl25.LoadParry()

									fn43({
										AutoPreclickEnabled = false,
										PreclickForAll = false,
										PreclickAfterVelocity = 0,
										PreclickDelay = 135,
									})

									flyteBBState.PreclickQueue = {}

									fn70 = function()
										fn42("Preclick")
									end

									fn72 = function()
										local character = localPlayer.Character
										return character and character.Parent == alive and not fn48(character) and not character:GetAttribute("DEATH_SLASH_STANCE") and not character:GetAttribute("IsRagingDeflection") and not character:GetAttribute("IsRapture") and not fn49("Infinity") and not fn49("Forcefield")
									end

									do
										local function fn74()
											if not fn72() then
												return false
											end
											local v109

											if (v87.TouchEnabled or tbl20.AutoParryType == "Remote") and tbl25.Parry and tbl25.Parry.Fire then
												flyteBBState.ParryMethod = "Remote"
												local v110
												v109, v110 = tbl25.Parry.Fire(nil, v85[200])

												if v109 and not v110 then
													tbl25.Animation.PlayAnimation(true)
												end
											else
												if v87.TouchEnabled or tbl20.AutoParryType == "Remote" then
													return v85[101]
												end
												flyteBBState.ParryMethod = "VIM"
												v109 = tbl25.Animation.VIM(true)
											end

											if v109 then
												flyteBBState.PreclickFired = true
											end

											return v109
										end

										fn73 = function()
											if flyteBBState.Connections.Preclick then
												return
											end

											flyteBBState.Connections.Preclick = v88.Heartbeat:Connect(function()
												local preclickQueue = flyteBBState.PreclickQueue
												if not preclickQueue or #preclickQueue <= 0 then
													fn70()
													return
												end
												local character = localPlayer.Character
												if not character or not character.Parent or character.Parent ~= alive then
													return
												end

												for i = #preclickQueue, v85[18], -1 do
													local v109 = preclickQueue[i]
													local fireAt = v109.FireAt

													if os.clock() >= fireAt then
														if (tbl20.PreclickAfterVelocity or 0) <= v109.Speed then
															fn74()
														end

														table.remove(preclickQueue, i)
													end
												end

												if #preclickQueue <= 0 then
													fn70()
												end
											end)
										end
									end
								end

								do
									local function fn74(arg)
										if not fn72() then
											return
										end
										table.insert(flyteBBState.PreclickQueue, { FireAt = os.clock() + (tbl20.PreclickDelay or 135) / v85[66], Speed = fn55(arg).Magnitude })
										fn73()
									end

									fn71 = function()
										if flyteBBState.Connections["Auto Preclick"] then
											return
										end
										local VFXController = require(v93.Controllers.VFXController)
										if not getupvalues then
											return
										end
										local v109 = nil

										for _, v110 in getupvalues(VFXController.Start) do
											if typeof(v110) == "Instance" and v110:IsA("RemoteEvent") then
												v109 = v110
												break
											else
												v109 = nil
											end
										end

										if not v109 then
											return
										end

										flyteBBState.Connections["Auto Preclick"] = v109.OnClientEvent:Connect(function(arg, arg2, arg3, arg4, arg5, arg6)
											if not tbl20.AutoPreclickEnabled or not arg6 or arg4 == localPlayer.Character then
												return
											end

											if tbl20.PreclickForAll or arg5 == localPlayer.Character then
												fn74(arg3)
											end
										end)
									end
								end
							end
						end

						local fn72

						do
							do
								fn72 = function()
									fn42("Auto Preclick")
									fn70()

									if flyteBBState.PreclickQueue then
										table.clear(flyteBBState.PreclickQueue)
									end
								end

								tbl25.LoadAnimations = function()
									tbl25.Animation = {}
									tbl25.Animation.Controller = require(v93.Controllers.AnimationController)
									tbl25.Animation.SwordAPI = require(v93.Shared.SwordAPI)
									local n33 = 0
									local flag19 = v85[101]
									local v109 = v85[33]
									local flag20 = false
									local tbl26 = {}

									local function fn73(arg)
										local v110 = tbl26[arg]

										if not v110 then
											local swordData = tbl25.UnlockAll and tbl25.UnlockAll.SwordData
											swordData = swordData and swordData[arg] or v93.Shared.ReplicatedInstances.Swords.GetSword:Invoke(arg)
											tbl26[arg] = swordData
											v110 = swordData
										end

										return v110
									end

									tbl25.Animation.Reset = function()
										v109 += v85[18]

										if flag20 then
											flag20 = false
											mouse1release()
										end

										if type(flyteBBState.GrabAnimation) == "table" then
											for _, v110 in flyteBBState.GrabAnimation, nil, nil do
												pcall(v110.Stop, v110, 0)
											end

											table.clear(flyteBBState.GrabAnimation)
										end

										n33 = 0
										flag19 = v85[200]
										flyteBBState.AutoParryAnimationPlayed = nil
									end

									tbl25.Animation.GetSword = function(arg)
										local attribute = arg and arg:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword")

										if tbl25.UnlockAll and tbl25.UnlockAll.Status == "active" and tbl25.UnlockAll.Sword then
											attribute = tbl25.UnlockAll.Sword

											if arg then
												arg:SetAttribute("CurrentlyEquippedSword", attribute)
											end

											localPlayer:SetAttribute("CurrentlyEquippedSword", attribute)
										end

										return attribute
									end

									local function fn74(arg, arg2)
										return tbl25.Animation.SwordAPI:GetAnimations(arg, { "Parry", "GrabParry" }, arg2.AnimationType, arg2.SwordType)
									end

									local function fn75(arg, arg2)
										local character = arg or localPlayer.Character
										local humanoid = character and (character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5))

										if humanoid then
											humanoid = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 5)
										end

										if not humanoid or character ~= localPlayer.Character then
											return
										end
										arg2 = arg2 or tbl25.Animation.GetSword(character)
										arg2 = arg2 and fn73(arg2)
										if not arg2 or character ~= localPlayer.Character then
											return
										end
										local v110 = fn74(character, arg2)
										pcall(v92.PreloadAsync, v92, v110)
										if character ~= localPlayer.Character then
											return
										end

										for _, v111 in v110, nil, nil do
											tbl25.Animation.Controller:LoadAnimation(humanoid, v111, true)
										end
									end

									tbl25.Animation.PreloadSword = function(arg)
										task.spawn(fn75, localPlayer.Character, arg)
									end

									tbl25.Animation.ParryAnimation = function()
										local character = localPlayer.Character
										local humanoid = character and character:FindFirstChildOfClass("Humanoid")
										if not humanoid then
											return v85[101]
										end
										local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 1)
										if not animator then
											return false
										end
										local v110 = tbl25.Animation.GetSword(character)
										if not v110 then
											return false
										end
										local v111 = fn73(v110)
										if not v111 or character ~= localPlayer.Character then
											return false
										end

										for _, v112 in tbl25.Animation.Controller:GetPlayingAnimationTracks(animator) do
											if v112:GetAttribute("GrabParry") or v112:GetAttribute("Parry") or v112.Name == "GrabParry" or v112.Name == "Grab" then
												v112:Stop(v112:GetAttribute("StopFadeTime") or 0.1)
											elseif v112.Name == "SuccessParry" or v112.Name == "Success" then
												v112:Stop(v112:GetAttribute("StopFadeTime") or 0.1)
											end
										end

										local v112 = flyteBBState
										local v113 = v85[145]
										v112.GrabAnimation = type(flyteBBState.GrabAnimation) == v113 and flyteBBState.GrabAnimation or {}
										table.clear(flyteBBState.GrabAnimation)
										local flag21 = false

										for _, v114 in fn74(character, v111) do
											local v115 = tbl25.Animation.Controller:LoadAnimation(animator, v114, true)
											local attribute = v115:GetAttribute("PlaySpeed") or v85[18]
											v115:Play(v115:GetAttribute("PlayFadeTime") or v85[22], v115:GetAttribute("PlayWeight") or 1, attribute)
											character:SetAttribute("ParryTime", math.max(character:GetAttribute("ParryTime") or 0, v115.Length == 0 and 1 or (v115.Length - v115.TimePosition) * attribute))
											flyteBBState.GrabAnimation[#flyteBBState.GrabAnimation + v85[18]] = v115
											flag21 = true
										end

										return flag21
									end

									tbl25.Animation.PlayAnimation = function(arg, arg2)
										alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
										local character = localPlayer.Character
										if not fn46(character) or fn48(character) then
											return v85[101]
										end

										if arg2 == "Animation + Click" then
											tbl25.Parry.NativeClick()
										elseif arg2 == "Click" then
											return tbl25.Parry.NativeClick()
										end

										local now2 = os.clock()

										if arg or now2 - n33 >= 0.2 or flag19 then
											n33 = now2
											flag19 = false
											return tbl25.Animation.ParryAnimation()
										end

										return false
									end

									tbl25.Animation.BypassCooldown = function()
										flag19 = true
									end

									tbl25.Animation.VIM = function(arg)
										local character = localPlayer.Character
										if character and fn48(character) then
											return false
										end

										if not arg and v87:GetFocusedTextBox() then
											return false
										end
										return fn41()
									end

									tbl25.Animation.Input = function(arg, arg2, arg3)
										flyteBBState.ParryMethod = "VIM"
										if arg ~= "Mouse Click" then
											return tbl25.Animation.VIM(arg2)
										end
										local character = localPlayer.Character
										character = character and fn48(character)
										local focusedTextBox

										if character then
											focusedTextBox = character
										else
											focusedTextBox = not arg2 and v87:GetFocusedTextBox()
										end

										if focusedTextBox then
											return v85[101]
										end
										v109 += 1
										local v110 = v109

										if flag20 then
											flag20 = v85[101]
											mouse1release()
										end

										mouse1press()
										if not arg3 or arg3 <= 0 then
											mouse1release()
											return v85[200]
										end
										flag20 = true

										task.delay(arg3, function()
											if flag20 and v109 == v110 then
												flag20 = false
												mouse1release()
											end
										end)

										return v85[200]
									end

									flyteBBState.Connections["Animation Sword"] = localPlayer:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(tbl25.Animation.PreloadSword)
									tbl25.Animation.PreloadSword()
								end

								tbl25.LoadAnimations()
								tbl25.Player = {}

								tbl25.Player.GetClosest = function()
									local character = localPlayer.Character
									if not character or not character.PrimaryPart or not alive then
										return nil
									end
									local huge = math.huge
									local v109 = nil

									for _, v110 in alive:GetChildren() do
										if v110 ~= character then
											local primaryPart = v110.PrimaryPart or v110:FindFirstChild("HumanoidRootPart")

											if primaryPart then
												local magnitude = (character.PrimaryPart.Position - primaryPart.Position).Magnitude

												if magnitude < huge then
													huge = magnitude
													v109 = v110
												end
											end
										end
									end

									return v109
								end

								tbl25.Ball = { List = {}, TrainingList = {} }

								do
									local function fn73(arg, arg2, arg3, arg4)
										local n33 = arg2 - (arg3 or fn54(arg))
										local magnitude = n33.Magnitude
										if magnitude < 0.001 then
											return 0, 0
										end
										local v109 = n33:Dot(arg4 or fn55(arg))
										if v109 <= 0 then
											return math.huge, magnitude
										end
										return magnitude * magnitude / v109, magnitude
									end

									tbl25.Ball.GetAllBalls = function()
										local character = localPlayer.Character
										return character and character.Parent ~= alive and fn45(character) and tbl25.Ball.TrainingList or tbl25.Ball.List
									end

									tbl25.Ball.GetMainBall = function()
										local v109 = tbl25.Ball.GetAllBalls()
										local character = localPlayer.Character
										character = character and character.PrimaryPart
										character = character and character.Position
										local v110 = nil
										local v111 = nil
										local v112, v113

										for _, v114 in v109, nil, v110 do
											local name = localPlayer.Name

											if fn51(v114) == name then
												if not character then
													tbl25.Ball.Target = v114
													return v114
												end
												local v115, v116 = fn73(v114, character)

												if not v111 or v115 < v111 or v115 == v111 and v116 < v112 then
													v111 = v115
													v112 = v116
													v113 = v114
												end
											end
										end

										tbl25.Ball.Target = v113
										return v113
									end

									fn43({ BallStatsEnabled = false })
									tbl25.BallStats = {}

									tbl25.BallStats.CreatePanel = function(arg, text, arg2)
										local json = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
										local json2 = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
										local screenGui = Instance.new("ScreenGui")
										screenGui.Name = "tungtungtungsahur" .. arg2
										screenGui.ResetOnSpawn = v85[101]
										screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
										screenGui.IgnoreGuiInset = true
										fn36(screenGui)
										local canvasGroup = Instance.new("CanvasGroup")
										canvasGroup.Name = "StatsGroup"
										canvasGroup.BackgroundTransparency = 1
										canvasGroup.Position = UDim2.new(v85[33], arg, 0, 150)
										canvasGroup.Size = UDim2.new(0, 210, v85[33], 96)
										canvasGroup.GroupTransparency = v85[18]
										canvasGroup.Parent = screenGui
										local uiScale = Instance.new("UIScale")
										uiScale.Name = "StatsScale"
										uiScale.Scale = v85[198]
										uiScale.Parent = canvasGroup
										local frame = Instance.new("Frame")
										frame.Name = "brobinipizanini"
										frame.BackgroundColor3 = colors.Primary
										frame.BorderSizePixel = v85[33]
										frame.Position = UDim2.new(0, 0, 0, 0)
										frame.Size = UDim2.new(1, 0, 1, v85[33])
										frame.Parent = canvasGroup
										local textButton = Instance.new("TextButton")
										textButton.Name = "clickblocker"
										textButton.Text = ""
										textButton.AutoButtonColor = false
										textButton.BackgroundTransparency = 1
										textButton.BorderSizePixel = 0
										textButton.Size = UDim2.new(1, v85[33], 1, v85[33])
										textButton.ZIndex = v85[33]
										textButton.Parent = frame
										local uiCorner = Instance.new("UICorner")
										uiCorner.CornerRadius = UDim.new(0, 11)
										uiCorner.Parent = frame
										local uiStroke = Instance.new("UIStroke")
										uiStroke.Color = colors.BorderSoft
										uiStroke.Parent = frame
										local instance = Instance.new(v85[21])
										local colorSequence = ColorSequence.new
										local tbl26 = {}
										local v109 = ColorSequenceKeypoint.new(0, colors.Text)
										local v110 = ColorSequenceKeypoint.new(0.493, colors.AccentLight)
										local v111 = ColorSequenceKeypoint.new(0.509, colors.AccentLight)
										local new = ColorSequenceKeypoint.new
										local text2 = colors.Text
										tbl26[1] = v109
										tbl26[2] = v110
										tbl26[3] = v111

										do
											local values = table.pack(new(1, text2))
											table.move(values, 1, values.n, 4, tbl26)
										end

										instance.Color = colorSequence(tbl26)
										instance.Rotation = 260
										instance.Parent = uiStroke
										local imageLabel = Instance.new("ImageLabel")
										imageLabel.Name = "igivup"
										imageLabel.BackgroundTransparency = 1
										imageLabel.BorderSizePixel = 0
										imageLabel.Image = "rbxassetid://10723427199"
										imageLabel.Position = UDim2.new(0, 10, 0, 10)
										imageLabel.Size = UDim2.new(v85[33], v85[30], v85[33], 16)
										imageLabel.Parent = frame
										Instance.new("UIAspectRatioConstraint", imageLabel)
										local textLabel = Instance.new("TextLabel")
										textLabel.Name = "v0rtexdisgay"
										textLabel.FontFace = json
										textLabel.Text = text
										textLabel.TextColor3 = colors.Text
										textLabel.TextSize = 15
										textLabel.TextXAlignment = Enum.TextXAlignment.Left
										textLabel.BackgroundTransparency = v85[18]
										textLabel.BorderSizePixel = v85[33]
										textLabel.Position = UDim2.new(v85[33], 32, v85[33], 8)
										textLabel.Size = UDim2.new(1, -v85[79], 0, 16)
										textLabel.Parent = frame
										local frame2 = Instance.new("Frame")
										frame2.Name = "divider"
										frame2.BackgroundColor3 = colors.BorderSoft
										frame2.BorderSizePixel = v85[33]
										frame2.Position = UDim2.new(0, v85[115], 0, 32)
										frame2.Size = UDim2.new(1, -20, 0, 1)
										frame2.Parent = frame
										local textLabel2 = Instance.new("TextLabel")
										textLabel2.Name = "veloc1"
										textLabel2.FontFace = json
										textLabel2.Text = "velocity"
										textLabel2.TextColor3 = colors.SubText
										textLabel2.TextSize = 14
										textLabel2.TextXAlignment = Enum.TextXAlignment.Left
										textLabel2.BackgroundTransparency = 1
										textLabel2.BorderSizePixel = v85[33]
										textLabel2.Position = UDim2.new(0, 12, v85[33], 40)
										textLabel2.Size = UDim2.new(0, 100, v85[33], 18)
										textLabel2.Parent = frame
										local instance2 = Instance.new(v85[65])
										instance2.Name = "velocplace"
										instance2.FontFace = json2
										instance2.Text = "0.0"
										instance2.TextColor3 = colors.Text
										instance2.TextSize = 14
										instance2.TextXAlignment = Enum.TextXAlignment.Right
										instance2.BackgroundTransparency = 1
										instance2.BorderSizePixel = 0
										instance2.Position = UDim2.new(1, -112, v85[33], v85[78])
										instance2.Size = UDim2.new(0, 100, 0, 18)
										instance2.Parent = frame
										local textLabel3 = Instance.new("TextLabel")
										textLabel3.Name = "velocpeaktext"
										textLabel3.FontFace = json
										textLabel3.Text = "peak velocity"
										textLabel3.TextColor3 = colors.SubText
										textLabel3.TextSize = v85[46]
										textLabel3.TextXAlignment = Enum.TextXAlignment.Left
										textLabel3.BackgroundTransparency = 1
										textLabel3.BorderSizePixel = 0
										textLabel3.Position = UDim2.new(0, 12, 0, 64)
										textLabel3.Size = UDim2.new(0, 120, 0, 18)
										textLabel3.Parent = frame
										local textLabel4 = Instance.new("TextLabel")
										textLabel4.Name = "peakvaluetext"
										textLabel4.FontFace = json2
										textLabel4.Text = "0.0"
										textLabel4.TextColor3 = colors.AccentLight
										textLabel4.TextSize = v85[46]
										textLabel4.TextXAlignment = Enum.TextXAlignment.Right
										textLabel4.BackgroundTransparency = 1
										textLabel4.BorderSizePixel = v85[33]
										textLabel4.Position = UDim2.new(1, -112, 0, 64)
										textLabel4.Size = UDim2.new(v85[33], v85[158], 0, 18)
										textLabel4.Parent = frame
										textButton.ZIndex = 10
										v99(canvasGroup, textButton)

										return {
											Gui = screenGui,
											Group = canvasGroup,
											Title = textLabel,
											Velocity = instance2,
											Peak = textLabel4,
											DisplayVelocity = 0,
											DisplayPeak = 0,
										}
									end

									local function fn74(arg, arg2)
										local group = arg.Group
										local statsScale = group and group:FindFirstChild("StatsScale")
										local n33 = arg2 and 0 or 1

										if group then
											v101(group, { GroupTransparency = n33 }, arg2 and 0.45 or 0.35, arg2 and Enum.EasingStyle.Exponential or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
										end

										if statsScale then
											v101(statsScale, { Scale = arg2 and 1 or v85[198] }, arg2 and 0.5 or 0.35, arg2 and Enum.EasingStyle.Back or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
										end
									end

									tbl25.BallStats.Toggle = function(ballStatsEnabled)
										tbl20.BallStatsEnabled = ballStatsEnabled

										if not ballStatsEnabled then
											fn42("Ball Stats")
											local statsPanel = flyteBBState.StatsPanel
											flyteBBState.StatsPanel = nil
											flyteBBState.StatsBall = nil
											local extraStats = flyteBBState.ExtraStats
											flyteBBState.ExtraStats = {}
											flyteBBState.StatsPeak = {}

											if statsPanel then
												fn74(statsPanel, false)

												task.delay(0.35, function()
													if statsPanel and statsPanel.Gui then
														statsPanel.Gui:Destroy()
													end
												end)
											end

											for _, v109 in extraStats, nil, nil do
												fn74(v109, false)
											end

											task.delay(0.35, function()
												for _, v109 in extraStats, nil, nil do
													v109.Gui:Destroy()
												end
											end)

											return
										end

										if not flyteBBState.StatsPanel then
											flyteBBState.StatsPanel = tbl25.BallStats.CreatePanel(20, "ball stats", "")
											fn74(flyteBBState.StatsPanel, v85[200])
										end

										flyteBBState.StatsPeak = {}
										flyteBBState.ExtraStats = {}
										flyteBBState.StatsBall = nil
										fn42("Ball Stats")

										flyteBBState.Connections["Ball Stats"] = v88.Heartbeat:Connect(function()
											if not tbl20.BallStatsEnabled then
												return
											end
											local now2 = os.clock()
											if now2 - (flyteBBState.StatsUpdate or 0) < 0.05 then
												return
											end
											flyteBBState.StatsUpdate = now2
											local v109 = tbl25.Ball.GetAllBalls()

											if #v109 == v85[33] then
												flyteBBState.StatsBall = nil

												for k, v110 in flyteBBState.ExtraStats, nil, nil do
													v110.Gui:Destroy()
													flyteBBState.ExtraStats[k] = nil
												end

												return
											end

											if flyteBBState.StatsBall and not flyteBBState.StatsBall.Parent then
												flyteBBState.StatsBall = nil
											end

											for k, v110 in flyteBBState.ExtraStats, nil, nil do
												if not k.Parent then
													v110.Gui:Destroy()
													flyteBBState.ExtraStats[k] = nil
												end
											end

											for k in flyteBBState.StatsPeak, nil, nil do
												if not k.Parent then
													flyteBBState.StatsPeak[k] = nil
												end
											end

											local tbl26 = {}

											for _, v110 in v109, nil, nil do
												tbl26[v110] = true
											end

											if flyteBBState.StatsBall and not tbl26[flyteBBState.StatsBall] then
												flyteBBState.StatsBall = nil

												if n24 >= 4766 then
													while true do
													end
												end
											end

											for k, v110 in flyteBBState.ExtraStats, nil, nil do
												if not tbl26[k] then
													v110.Gui:Destroy()
													flyteBBState.ExtraStats[k] = nil
												end
											end

											if not flyteBBState.StatsBall then
												local v110 = tbl25.Ball.GetMainBall(true)
												local tbl27 = {}

												for _, v111 in v109, nil, nil do
													if not flyteBBState.ExtraStats[v111] then
														table.insert(tbl27, v111)
													end
												end

												local statsBall = v110 and not flyteBBState.ExtraStats[v110] and v110 or tbl27[v85[18]]

												if statsBall then
													flyteBBState.StatsBall = statsBall
												end
											end

											for _, v110 in v109, nil, nil do
												if v110 ~= flyteBBState.StatsBall and not flyteBBState.ExtraStats[v110] then
													flyteBBState.ExtraStats[v110] = tbl25.BallStats.CreatePanel(20, "ball stats", tostring(v110:GetDebugId(0)))
													fn74(flyteBBState.ExtraStats[v110], true)
													flyteBBState.ExtraStats[v110].PeakValue = 0
												end
											end

											local statsPanel = flyteBBState.StatsPanel
											local statsBall = flyteBBState.StatsBall
											local n33 = 0
											local n34 = 0

											if statsBall then
												local v110 = fn58(statsBall)
												local zoomies = v110.Zoomies

												if not zoomies or zoomies.Parent ~= statsBall then
													zoomies = statsBall:FindFirstChild("zoomies")
													v110.Zoomies = zoomies
												end

												if zoomies then
													n34 = zoomies.VectorVelocity.Magnitude
													n33 = flyteBBState.StatsPeak[statsBall] or n33

													if n33 < n34 then
														flyteBBState.StatsPeak[statsBall] = n34
														n33 = n34
													end
												else
													n33 = flyteBBState.StatsPeak[statsBall] or 0
												end
											end

											statsPanel.DisplayVelocity = statsPanel.DisplayVelocity + (n34 - statsPanel.DisplayVelocity) * 0.15
											statsPanel.DisplayPeak = statsPanel.DisplayPeak + (n33 - statsPanel.DisplayPeak) * 0.15
											statsPanel.Velocity.Text = string.format("%.1f", statsPanel.DisplayVelocity)
											statsPanel.Peak.Text = string.format("%.1f", statsPanel.DisplayPeak)
											local n35 = 0

											for _, v110 in v109, nil, nil do
												if v110 ~= statsBall and flyteBBState.ExtraStats[v110] then
													n35 += 1
													local v111 = flyteBBState.ExtraStats[v110]
													v111.Title.Text = "ball stats #" .. n35
													local lastTargetX = v85[108] + n35 * 222

													if v111.LastTargetX ~= lastTargetX then
														v111.LastTargetX = lastTargetX
														v101(v111.Group, { Position = UDim2.new(v85[33], lastTargetX, 0, 150) }, 0.3)
													end

													local magnitude = v85[33]
													local displayPeak = v111.DisplayPeak or 0
													local v112 = fn58(v110)
													local zoomies = v112.Zoomies

													if not zoomies or zoomies.Parent ~= v110 then
														local zoomies2 = v110:FindFirstChild("zoomies")
														v112.Zoomies = zoomies2
														zoomies = zoomies2
													end

													if zoomies then
														magnitude = zoomies.VectorVelocity.Magnitude

														if (v111.PeakValue or 0) < magnitude then
															v111.PeakValue = magnitude
														end

														displayPeak = v111.PeakValue or 0
													end

													v111.DisplayVelocity = v111.DisplayVelocity + (magnitude - v111.DisplayVelocity) * v85[110]
													v111.DisplayPeak = v111.DisplayPeak + (displayPeak - v111.DisplayPeak) * v85[110]
													v111.Velocity.Text = string.format("%.1f", v111.DisplayVelocity)
													v111.Peak.Text = string.format("%.1f", v111.DisplayPeak)
												end
											end
										end)
									end

									flyteBBState.Connections.Character = localPlayer.CharacterAdded:Connect(function()
										tbl25.Animation.Reset()
										tbl25.Animation.PreloadSword()
										flyteBBState.InfinityActive = false
										flyteBBState.InfinityParried = v85[101]
										flyteBBState.TimeHole = v85[101]
										flyteBBState.FuryCatch = v85[101]
										flyteBBState.FuryActive = false
										flyteBBState.DeathSlash = false
										flyteBBState.StaffDetected = {}

										if tbl25.Phantom then
											tbl25.Phantom.Reset()
										end

										if tbl25.Quasar then
											tbl25.Quasar.Reset()
										end
									end)

									fn43({
										AntiPhantomEnabled = false,
										AntiPhantomBlatant = false,
										AntiPhantomType = "Spam",
										AntiFlashCounterEnabled = false,
										AntiFlashCounterBlatant = false,
										AntiFlashCounterType = "Spam",
									})

									tbl25.Phantom = {}

									tbl25.Phantom.Reset = function()
										flyteBBState.PhantomTarget = nil
										flyteBBState.PhantomAbility = nil
										flyteBBState.PhantomData = nil
									end

									tbl25.Phantom.Trigger = function(arg, phantomTarget, arg2)
										local antiPhantomEnabled, antiPhantomBlatant, antiPhantomType

										if arg == "Phantom" then
											antiPhantomEnabled = tbl20.AntiPhantomEnabled
											antiPhantomBlatant = tbl20.AntiPhantomBlatant
											antiPhantomType = tbl20.AntiPhantomType
										else
											antiPhantomEnabled = tbl20.AntiFlashCounterEnabled
											antiPhantomBlatant = tbl20.AntiFlashCounterBlatant
											antiPhantomType = tbl20.AntiFlashCounterType
										end

										if not antiPhantomEnabled then
											return
										end

										if arg2 ~= localPlayer.Character or typeof(phantomTarget) ~= "Instance" or not phantomTarget:IsA("Model") then
											return
										end
										flyteBBState.PhantomTarget = phantomTarget
										flyteBBState.PhantomAbility = nil

										flyteBBState.PhantomData = {
											Name = arg,
											Blatant = antiPhantomBlatant,
											Type = antiPhantomType,
											Ball = arg == "Phantom" and tbl25.Ball.GetMainBall() or nil,
											Expires = os.clock() + 1.25,
										}
									end

									tbl25.Phantom.Released = function(ball)
										local phantomData = flyteBBState.PhantomData
										local phantomTarget = flyteBBState.PhantomTarget
										if not phantomData or phantomData.Name ~= "Phantom" or not phantomTarget or phantomData.Ball and phantomData.Ball ~= ball then
											return false
										end
										local name = phantomTarget.Name

										if fn51(ball) ~= name then
											phantomData.Position = nil
											phantomData.Released = false
											return false
										end

										phantomData.Ball = ball
										local v109 = fn54(ball)

										if phantomData.Position and v109 ~= phantomData.Position then
											phantomData.Released = true
										end

										phantomData.Position = v109
										return phantomData.Released == true
									end

									tbl25.Phantom.Update = function()
										local phantomData = flyteBBState.PhantomData
										local phantomTarget = flyteBBState.PhantomTarget
										local character = localPlayer.Character
										character = character and character:FindFirstChild("HumanoidRootPart")
										local humanoidRootPart = phantomTarget and phantomTarget:FindFirstChild("HumanoidRootPart")
										local humanoid = phantomTarget and phantomTarget:FindFirstChildOfClass("Humanoid")
										local flag19 = not phantomData

										if not flag19 then
											local expires = phantomData.Expires
											flag19 = os.clock() >= expires
										end

										if flag19 or not character or not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
											tbl25.Phantom.Reset()
											return
										end
										local n33 = character.Position - humanoidRootPart.Position
										local magnitude = n33.Magnitude

										if phantomData.Blatant and magnitude < 32 then
											character.CFrame = character.CFrame + (magnitude > 0.1 and n33.Unit or -humanoidRootPart.CFrame.LookVector) * (32 - magnitude)
											tbl25.Phantom.Reset()
											return
										end

										return phantomTarget, magnitude, phantomData
									end

									flyteBBState.Connections.Phantom = v93.Remotes.ActivateAbility.OnClientEvent:Connect(function(arg, arg2)
										if arg:GetAttribute("Ability") == "Phantom" then
											tbl25.Phantom.Trigger("Phantom", arg, arg2 and arg2.target)
										end
									end)

									flyteBBState.Connections.FlashCounter = v93.Remotes.PlrFlashCountered.OnClientEvent:Connect(function(arg, arg2)
										tbl25.Phantom.Trigger("Flash Counter", arg, arg2)
									end)

									fn43({ AntiBlindness = false, AntiDisorientate = false })
									tbl25.Quasar = {}

									tbl25.Quasar.Reset = function()
										flyteBBState.QuasarUntil = nil
									end

									tbl25.Quasar.ClearBlindness = function(arg)
										Lighting.Blindness.Enabled = false

										if not arg then
											for _, v109 in Lighting:GetChildren() do
												if v109:IsA("Atmosphere") and v109.Name == "Blindness" then
													tbl25.Quasar.ClearBlindness(v109)
												end
											end

											return
										end

										local quasarAtmosphere = flyteBBState.QuasarAtmosphere
										arg.Density = quasarAtmosphere and quasarAtmosphere.Density or 0
										arg.Offset = quasarAtmosphere and quasarAtmosphere.Offset or 0
										arg.Haze = quasarAtmosphere and quasarAtmosphere.Haze or 0
										arg.Glare = quasarAtmosphere and quasarAtmosphere.Glare or v85[33]

										if quasarAtmosphere then
											arg.Color = quasarAtmosphere.Color
											arg.Decay = quasarAtmosphere.Decay
										end
									end

									tbl25.Quasar.SetBlindness = function(arg)
										flyteBBState.QuasarAtmosphere = arg and Lighting:FindFirstChildWhichIsA("Atmosphere") or nil
									end

									tbl25.Quasar.SetDisorientate = function(arg)
										fn42("Quasar Camera")
										flyteBBState.QuasarCamera = nil
										if not arg then
											return
										end

										flyteBBState.Connections["Quasar Camera"] = v88.PreRender:Connect(function()
											local currentCamera2 = workspace.CurrentCamera

											if currentCamera2 then
												flyteBBState.QuasarCamera = currentCamera2.CFrame
											end
										end)
									end

									flyteBBState.Connections.Quasar = v93.Remotes.PlrQuasared.OnClientEvent:Connect(function(arg, arg2)
										if arg2 ~= localPlayer.Character then
											return
										end
										arg = arg and arg:FindFirstChild("Upgrades")
										arg = arg and arg:FindFirstChild("Quasar")
										flyteBBState.QuasarUntil = os.clock() + 5 + (arg and arg.Value or 0)

										if tbl20.AntiBlindness then
											tbl25.Quasar.ClearBlindness()
										end

										local quasarCamera = tbl20.AntiDisorientate and flyteBBState.QuasarCamera

										if quasarCamera then
											task.defer(function()
												local currentCamera2 = workspace.CurrentCamera

												if currentCamera2 and tbl20.AntiDisorientate then
													local rotation = quasarCamera.Rotation
													currentCamera2.CFrame = CFrame.new(currentCamera2.CFrame.Position) * rotation
												end
											end)
										end
									end)

									flyteBBState.Connections["Quasar Blindness"] = Lighting.Blindness:GetPropertyChangedSignal("Enabled"):Connect(function()
										local antiBlindness = tbl20.AntiBlindness

										if antiBlindness then
											antiBlindness = os.clock() < (flyteBBState.QuasarUntil or 0)
										end

										if antiBlindness and Lighting.Blindness.Enabled then
											Lighting.Blindness.Enabled = false
										end
									end)

									flyteBBState.Connections["Quasar Atmosphere"] = Lighting.ChildAdded:Connect(function(child)
										if not tbl20.AntiBlindness or not child:IsA("Atmosphere") then
											return
										end
										local flag19 = child.Name == "Blindness"
										local flag20

										if flag19 then
											flag20 = os.clock() < (flyteBBState.QuasarUntil or 0)
										else
											flag20 = flag19
										end

										if flag20 then
											tbl25.Quasar.ClearBlindness(child)
										elseif child.Name ~= "Blindness" then
											flyteBBState.QuasarAtmosphere = child
										end
									end)

									fn43({
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

									tbl25.Loop = {}

									tbl25.Loop.InvisDetection = function(arg)
										alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
										local flag19 = v85[101]

										for _, v109 in alive:GetChildren() do
											if v109 ~= arg then
												if not fn48(v109) then
													return v85[101]
												end
												flag19 = true
											end
										end

										return flag19
									end

									tbl25.Loop.MainParryLoop = function(arg)
										local autoParryEnabled = tbl20.AutoParryEnabled
										if not autoParryEnabled and not tbl20.DribbleDetection then
											return
										end
										local now2 = os.clock()
										alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
										local character = localPlayer.Character
										if not fn46(character) then
											return
										end

										if fn48(character) then
											return
										end
										local primaryPart = character.PrimaryPart
										local v109 = tbl25.Ball.GetAllBalls()
										if #v109 == 0 then
											return
										end

										if tbl25.Detection.UseProtection(character, true) then
											return
										end
										local autoParryType = tbl20.AutoParryType
										local flag19 = autoParryType == v85[90]

										if flag19 then
											flag19 = now2 < (flyteBBState.ExtraParryCooldownUntil or 0)
										end

										if flag19 then
											return
										end
										flyteBBState.ExtraParryCooldownUntil = nil

										if flag18 and now2 >= n32 then
											flag18 = false
											v107 = nil
										end

										local v110 = fn59()
										local n33 = v110 / v85[66]
										local n34 = math.clamp(v110 / 10, 10, 16.7)
										local n35 = math.clamp(n33 * v85[81] - 0.05, 0, 0.04)
										local parryRange = tbl20.ParryRange or v85[33]
										local position = primaryPart.Position
										local name = localPlayer.Name
										local v111, v112 = tbl25.Detection.BlocksParry(nil, character, primaryPart)
										if v111 then
											return
										end
										local flag20 = #v109 > v85[18]
										local autoBall = flag20 and flyteBBState.AutoBall
										local v113 = nil

										if autoBall then
											local autoBall2 = flyteBBState.AutoBall
											local v114 = obj2[autoBall2]
											local flag21 = autoParryEnabled and autoBall2.Parent and autoBall2:GetAttribute("from") == name
											v113 = nil

											if flag21 then
												v113 = tbl25.Loop.InvisDetection(character)
											end

											local flag22 = not v113 and autoBall2.Parent and fn51(autoBall2) == name

											if flag22 then
												flag22 = now2 < (v114 and v114.ParryResetAt or 0)
											end

											if flag22 then
												return
											end
											flyteBBState.AutoBall = nil
										end

										local n36 = 0

										if flag20 then
											for _, v114 in v109, nil, nil do
												local v115 = obj2[v114]
												local v116 = v114 and fn51(v114)
												local parried = v115 and v115.Parried

												if parried then
													parried = now2 < (v115.ParryResetAt or 0)
												end

												if parried then
													n36 += 1
												elseif v116 == name and not fn69(v114, v116) then
													local huge = math.huge

													if fn73(v114, position) < huge then
														n36 += 1
													end
												end

												if not (v85[18] < n36) then
													continue
												end
												break
											end
										end

										local flag21 = n36 > 1
										local v114 = nil
										local v115 = nil
										local v116 = nil
										local v117 = nil
										local v118 = nil
										local v119 = nil
										local v120 = nil
										local flag22 = nil
										local v121 = nil
										local v122 = nil
										local v123 = nil

										for _, v124 in v109, nil, nil do
											if v124 then
												local v125 = fn58(v124)
												local v126 = fn51(v124)

												if not fn69(v124, v126) then
													local v127 = nil
													local flag23 = nil

													if tbl20.DribbleDetection then
														v127, flag23 = tbl25.Detection.GetSelfDribbleBall(v124, primaryPart)
													end

													local flag24 = not v127 and autoParryEnabled and v124:GetAttribute("from") == name
													local flag25 = false

													if flag24 then
														if v113 ~= nil then
															flag25 = v113
														else
															flag25 = tbl25.Loop.InvisDetection(character)
															v113 = flag25
														end
													end

													if flag25 then
														if v125.InvisibleReturnAway == nil then
															v125.InvisibleReturnAway = not v125.Parried
														end

														local v128 = (position - fn54(v124)):Dot(fn55(v124))
														flag23 = v128 > 0

														if v128 < 0 then
															v125.InvisibleReturnAway = true
														end

														local invisibleReturnAway = v125.InvisibleReturnAway

														if invisibleReturnAway then
															v127 = v124
														else
															v127 = v124
															flag23 = invisibleReturnAway
														end
													else
														v125.InvisibleReturnAway = nil
													end

													if not (not autoParryEnabled and not v127) then
														if v127 and (flag25 and v125.InvisibleReturnAway or not flag25 and flyteBBState.SelfDribbleAway) then
															v125.Parried = false
															v125.ParryResetAt = v85[33]

															if flyteBBState.ManualBall == v124 then
																flyteBBState.ManualBall = nil
															end

															if v107 == v124 then
																flag18 = false
																v107 = nil
																n32 = 0
															end
														end

														if flyteBBState.AutoBall == v124 and v126 ~= name then
															flyteBBState.AutoBall = nil
														end

														if flyteBBState.ManualBall == v124 then
															if v126 == name then
																continue
															end
															flyteBBState.ManualBall = nil
														end

														if v125.LoopTarget ~= v126 then
															v125.Parried = v85[101]
															v125.ParryResetAt = 0

															if v125.Target ~= v126 then
																if v126 == name then
																	fn65(v125)
																else
																	fn66(v125)
																end
															end

															v125.LoopTarget = v126

															if v126 == name and v107 == v124 then
																flag18 = false
																v107 = nil
																n32 = 0
															end
														end

														if v126 ~= name then
															v125.Parried = false
														elseif v125.Parried then
															if now2 < (v125.ParryResetAt or 0) then
																continue
															end
															v125.Parried = v85[101]
														end

														local flag26 = v108 == v124 and v124 or nil

														if v108 and tbl25.Detection.GetDribbleBall(v108) ~= v108 then
															if v107 == v108 then
																flag18 = false
																v107 = nil
																n32 = 0
															end

															v108 = nil
															flag26 = nil
														end

														if tbl20.ParryOnDribble and not v108 then
															flag26 = tbl25.Detection.GetDribbleBall(v124)

															if flag26 then
																v108 = flag26
															end
														end

														if not (v124:GetAttribute("DribbleActive") == true and not tbl20.ParryOnDribble and not v127 and v126 ~= name) then
															local v128 = flag26 or v127 or v124
															local v129 = fn52(v128)
															local vectorVelocity = v128 == v124 and v125.Zoomies and v125.Zoomies.VectorVelocity or fn55(v128)
															local magnitude = vectorVelocity.Magnitude
															local flag27 = v128 == v124 and v126 or fn51(v128)
															local position2 = fn53(v128, v129, now2) or v129 and v129.Position or Vector3.zero
															local n37 = position - position2
															local magnitude2 = n37.Magnitude
															local n38 = math.max(tbl20.ParryAccuracy or 50, v85[18])
															local phantomData = flyteBBState.PhantomData
															local phantomTarget = flyteBBState.PhantomTarget
															phantomTarget = phantomTarget and phantomTarget:FindFirstChild("HumanoidRootPart")
															local magnitude3 = phantomData and phantomData.Name == "Phantom" and not phantomData.Blatant and phantomData.Type == "Spam" and phantomTarget and (position - phantomTarget.Position).Magnitude

															if tbl20.RandomizedParryAccuracy then
																local n39 = math.clamp(tbl20.RandomAccuracyMin or 1, 1, 100)
																n38 = math.random(n39, math.clamp(tbl20.RandomAccuracyMax or 100, n39, 100))
															end

															if magnitude3 and magnitude3 > 30 then
																n38 = 100
															elseif magnitude3 and not phantomData.Released then
																continue
															end

															local flag28 = not v127

															if not (flag28 and (tbl20.BackwardsAntiCurveEnabled and fn63(v128, vectorVelocity, flag27, flag20) or fn67(v128, primaryPart, position2, vectorVelocity, magnitude2, magnitude, n37, flag27, n33))) then
																if not (v127 and not flag23) then
																	local n39 = math.clamp((n38 - 1) / 99, 0, 1)
																	local n40 = n39 * n39 * (v85[61] - 2 * n39)
																	local n41 = 2.4 + math.clamp(magnitude - 9.5, 0, 990.5) * 0.002
																	local n42 = magnitude / n41 * (0.75 + n39 * 0.43)
																	local flag29 = n42 <= 9.5
																	local n43 = flag29 and math.min(n34, magnitude * n33) or n34 + math.min(magnitude * n35, v85[36])
																	local n44 = n43 + math.max(n42, 9.5)
																	local n45

																	if not (n38 > 70) then
																		n45 = n44
																	else
																		local n46 = math.clamp((n38 - v85[6]) / v85[36], 0, 1)
																		local n47 = n46 * n46 * (3 - 2 * n46)
																		local attribute = v124:GetAttribute("from")
																		local flag30 = type(attribute) == "string" and alive and alive:FindFirstChild(attribute)

																		if flag30 then
																			flag30 = flag30.PrimaryPart or flag30:FindFirstChild("HumanoidRootPart")
																		end

																		flag30 = flag30 and (position - flag30.Position).Magnitude
																		local n48 = flag30 and math.clamp((8 - flag30) / v85[61], 0, 1) or 0

																		if flag30 and magnitude2 > flag30 + 3 then
																			n48 = v85[33]
																		end

																		local n49 = (flag29 and math.min(n34, magnitude * n33) or n34) + math.max(magnitude / n41 * (0.75 + n39 * 0.2), 9.5)
																		local n50 = n34 + magnitude / n41 * (1.4 + n39 * 0.2)
																		local n51 = math.clamp((magnitude - 1000) / 800, v85[33], 1)
																		local n52 = n50 + math.max(n49 - n50, 0) * n51
																		n45 = n44 + (n52 + (n49 - n52) * n48 - n44) * n47
																	end

																	local n46

																	if flag21 and n38 > v85[6] then
																		n46 = math.max(n45, n44)
																	else
																		n46 = n45
																	end

																	flag29 = flag29 and (n34 - n43) * (1 - n40) or v85[33]
																	local n47 = flag26 and n43 * (1 - n40 * 0.5) or 0
																	local flag30 = autoParryType == "Mouse Click"

																	if flag30 then
																		flag30 = magnitude * (arg or 0)
																	end

																	local n48 = n46 + parryRange + flag29 + n47 + (flag30 or v85[33])
																	local flag31 = tbl20.AutoAbilityEnabled and not v127 and v126 == name and magnitude2 <= n46
																	local v130 = nil
																	local v131 = nil

																	if flag31 then
																		v130, v131 = fn73(v124, position, position2, vectorVelocity)

																		if not v114 or v130 < v114 or v130 == v114 and v131 < v115 then
																			v114 = v130
																			v115 = v131
																			v116 = v124
																		end
																	end

																	flag28 = flag28 and v126 ~= name and n37:Dot(vectorVelocity) > 0

																	if flag28 then
																		if v113 ~= nil then
																			flag28 = v113
																		else
																			v113 = tbl25.Loop.InvisDetection(character)
																			flag28 = v113
																		end
																	end

																	if (flag28 or not v127 and v126 == name or flag26 or flag23) and magnitude2 <= n48 and not v125.Parried and (not flag18 or v107 ~= v124) then
																		local flag32 = flag28 or flag23 or not v127 and v126 == name

																		if not flag32 and flag26 then
																			flag32 = tbl25.Detection.GetDribbleBall(flag26) == flag26
																		end

																		if flag32 then
																			if flag20 and not v130 then
																				v130, v131 = fn73(v128, position, position2, vectorVelocity)
																			end

																			if not v117 or v130 < v118 or v130 == v118 and v131 < v119 then
																				flag22 = not not (flag28 or flag26 or v127)
																				v117 = v124
																				v118 = v130
																				v119 = v131
																				v120 = v125
																				v121 = n38
																				v122 = flag23
																				v123 = flag25
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

										if v116 and fn50(v112) then
											flag18 = true
											v107 = v116
											n32 = now2 + 0.6
											return
										end

										if not v117 then
											return
										end
										v120.Parried = true
										v120.ParryResetAt = now2 + 0.6
										v120.AutoParryAt = now2
										flag18 = true
										v107 = v117
										n32 = v120.ParryResetAt
										flyteBBState.AutoBall = v117

										if not fn40(v117, autoParryType, nil, flag22, v110, v121) then
											v120.Parried = false
											v120.ParryResetAt = 0
											v120.AutoParryAt = nil
											flyteBBState.AutoBall = nil
											flag18 = false
											v107 = nil
											n32 = 0
											return
										end

										if autoParryType == "Remote" then
											flyteBBState.AutoParryAt = now2
										end

										if v122 then
											if v123 then
												v120.InvisibleReturnAway = false
											else
												flyteBBState.SelfDribbleAway = v85[101]
											end
										end
									end
								end
							end

							tbl25.Loop.ResetSpam = function()
								table.clear(flyteBBState.SpamParries)
								flyteBBState.SpamBall = nil
								flyteBBState.SpamTargetAt = nil
								flyteBBState.AutoSpamAt = nil
								flyteBBState.AutoSpamCarry = 0
								flyteBBState.AutoSpamTime = nil
							end

							tbl25.Loop.AutoSpamLoop = function()
								local antiPhantomEnabled = tbl20.AntiPhantomEnabled or tbl20.AntiFlashCounterEnabled
								local v109 = nil
								local v110 = nil
								local flag19 = nil

								if antiPhantomEnabled then
									v109, flag19, v110 = tbl25.Phantom.Update()
								end

								if v109 and not v110.Blatant and v110.Type == "Ability" then
									tbl25.Loop.ResetSpam()

									if flyteBBState.PhantomAbility ~= v109 and v106 and v106.Offset.Y >= 0.49 then
										flyteBBState.PhantomAbility = v109
										abilityButtonPress:Fire()
									end

									return
								end

								local flag20 = v109 ~= nil
								if not tbl20.AutoSpamEnabled and not flag20 then
									tbl25.Loop.ResetSpam()
									return
								end
								local now2 = os.clock()
								local n33 = math.min(now2 - (flyteBBState.AutoSpamTime or now2), 0.066666666666666666)
								flyteBBState.AutoSpamTime = now2
								if tbl20.DeathSlashDetection and flyteBBState.DeathSlash then
									tbl25.Loop.ResetSpam()
									return
								end
								alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
								if tbl20.InfinityDetection and (flyteBBState.InfinityActive or fn49("Infinity")) then
									tbl25.Loop.ResetSpam()
									return
								end
								local character = localPlayer.Character
								local primaryPart = character and character.PrimaryPart
								if tbl20.ForcefieldDetection and primaryPart and fn49("Forcefield") and (primaryPart:FindFirstChild("MaxShield") or primaryPart:FindFirstChild("Shield")) then
									tbl25.Loop.ResetSpam()
									return
								end
								local flag21 = character and character.Parent ~= alive and fn45(character)
								if not primaryPart or character.Parent ~= alive and not flag21 then
									return
								end

								if fn48(character) then
									return
								end
								local v111 = tbl25.Ball.GetAllBalls()
								if #v111 == 0 then
									return
								end
								local position = primaryPart.Position
								local ball = flag20 and v110.Ball or flyteBBState.SpamBall
								local flag22 = not flag20

								if flag22 then
									ball = tbl25.Ball.GetMainBall() or ball
								end

								if ball and not table.find(v111, ball) then
									if flag20 then
										v110.Ball = nil
										v110.Position = nil
										v110.Released = false
									else
										flyteBBState.SpamBall = nil
										flyteBBState.SpamTargetAt = nil
									end

									ball = nil
								end

								if not ball and flag20 and v110.Name == "Phantom" then
									for _, v112 in v111, nil, nil do
										local name = v109.Name
										if fn51(v112) == name then
											ball = v112
											break
										end
									end
								end

								local magnitude = ball and (position - fn54(ball)).Magnitude or math.huge

								if not ball and flag20 then
									for _, v112 in v111, nil, nil do
										local magnitude2 = (position - fn54(v112)).Magnitude

										if magnitude2 < magnitude then
											magnitude = magnitude2
											ball = v112
										end
									end
								end

								if not ball then
									return
								end
								local v112 = fn51(ball)
								if not v112 then
									return
								end
								local magnitude2 = fn55(ball).Magnitude
								local v113 = fn59()
								local n34 = math.min(0.3 + v113 / 1000, v85[81])
								local flag23 = now2 - (flyteBBState.AutoSpamAt or 0) <= n34
								if character:GetAttribute("Pulsed") then
									return
								end

								if flag20 and v110.Name == "Phantom" and (flag19 > 30 or not tbl25.Phantom.Released(ball)) then
									tbl25.Loop.ResetSpam()
									return
								end

								if magnitude2 < v85[22] and (not flag20 or v110.Name ~= "Phantom") then
									return
								end

								if flag22 then
									local attribute = v112 == localPlayer.Name and ball:GetAttribute("from") or v112
									local v114 = v85[127]
									flag19 = type(attribute) == v114 and attribute ~= localPlayer.Name and alive:FindFirstChild(attribute)

									if flag19 then
										flag19 = flag19.PrimaryPart or flag19:FindFirstChild("HumanoidRootPart")
									end

									flag19 = flag19 and (position - flag19.Position).Magnitude or fn60(character, position, flag21)
								end

								flag19 = flag19 or fn60(character, position, flag21)
								if flag19 == math.huge then
									return
								end

								if magnitude < 0.1 then
									return
								end

								if flag22 then
									if v112 == localPlayer.Name then
										flyteBBState.SpamTargetAt = now2
									else
										local n35 = now2 - (flyteBBState.SpamTargetAt or 0)
										if (flag23 and n34 or math.min(0.15 + v113 / 2000, 0.25)) < n35 then
											return
										end
									end
								end

								local n35 = math.clamp(10 + v113 / 10, 10, v85[59])
								local n36 = #v111 >= 2 and 3 or v85[33]
								local n37 = tbl20.AutoSpamType ~= "Remote" and v85[147] or 0
								local n38 = math.min(0.5 + v113 / 1000, 0.75)
								local flag24 = flag20 and flag19 <= 30
								local n39 = 1

								if not flag24 then
									local n40 = n35 + math.min(magnitude2 / 6, 95) + n36 + n37
									local n41 = n35 + math.min(magnitude2 / 6, 30) + n36 + n37
									flag24 = flag19 <= n41 and magnitude <= n40

									if flag24 and not flag20 and not flag23 then
										if tbl20.DynamicSpamThreshold then
											n39 = math.clamp(math.ceil(math.min(math.max(flag19 / n41, magnitude / n40), v85[70] * math.max(flag19, magnitude) / magnitude2 * n38) * 3), 1, 3)
										else
											n39 = math.clamp(math.round(tbl20.AutoSpamThreshold or 2), 1, 4)
										end
									end
								end

								if not flag24 then
									return
								end

								if flag22 and v112 == localPlayer.Name and flag19 > 30 and magnitude > 30 then
									return
								end

								if flag22 then
									local n40 = now2 - n38

									while flyteBBState.SpamParries[v85[18]] and flyteBBState.SpamParries[1] < n40 do
										table.remove(flyteBBState.SpamParries, v85[18])
									end

									if not flag23 and #flyteBBState.SpamParries < n39 then
										return
									end
								end

								if flag22 then
									flyteBBState.AutoSpamAt = now2
								end

								if tbl20.AutoSpamType == "Remote" then
									flyteBBState.ParryMethod = "Remote"

									if tbl25.Parry and tbl25.Parry.Fire then
										flyteBBState.AutoSpamCarry = (flyteBBState.AutoSpamCarry or v85[33]) + math.max(n33 * 120 - v85[18], 0)
										local v114 = v85[72]
										local n40 = math.min(math.floor(flyteBBState.AutoSpamCarry), v114)
										flyteBBState.AutoSpamCarry = math.min(flyteBBState.AutoSpamCarry - n40, 7)
										local v115, v116 = tbl25.Parry.Fire(nil, v85[200], n40 > 0 and tbl25.Parry.GetData(nil, flyteBBState.AutoSpamData), n40 + 1)

										if v115 then
											flyteBBState.AutoSpamParryAt = now2
											flyteBBState.ExtraParryCooldownUntil = nil
										end

										if v115 and not v116 and tbl20.AutoSpamAnimFix then
											tbl25.Animation.PlayAnimation(nil, tbl20.AutoSpamAnimFixType)
										end
									end
								else
									flyteBBState.AutoSpamCarry = 0

									if tbl25.Animation.Input(tbl20.AutoSpamType, true) then
										flyteBBState.AutoSpamParryAt = now2
										flyteBBState.ExtraParryCooldownUntil = nil
									end
								end
							end

							tbl25.Loop.RefreshAutoSpam = function()
								if tbl20.AutoSpamEnabled or tbl20.AntiPhantomEnabled or tbl20.AntiFlashCounterEnabled then
									if not flyteBBState.Connections["Auto Spam"] then
										flyteBBState.Connections["Auto Spam"] = v88.PreSimulation:Connect(tbl25.Loop.AutoSpamLoop)
									end

									return
								end

								fn42("Auto Spam")
								tbl25.Loop.ResetSpam()
							end

							tbl25.MobileControls = { X = 240, Y = 150, Width = 180, Gap = v85[49] }

							tbl25.MobileControls.GetX = function(arg)
								return tbl25.MobileControls.X + (arg - v85[18]) * (tbl25.MobileControls.Width + tbl25.MobileControls.Gap)
							end

							tbl25.MobileControls.Layout = function()
								local tbl26 = {}

								if flyteBBState.SpamPanel then
									table.insert(tbl26, flyteBBState.SpamPanel)
								end

								if flyteBBState.TriggerPanel then
									table.insert(tbl26, flyteBBState.TriggerPanel)
								end

								for k, v109 in tbl26, nil, nil do
									local v110 = tbl25.MobileControls.GetX(k)

									if v109.Group and (v109.LastTargetX ~= v110 or not v109.Shown) then
										local n33 = not v109.Shown and 0.45 or 0.3
										v109.LastTargetX = v110
										v109.Shown = v85[200]

										v101(v109.Group, {
											Position = UDim2.new(0, v110, v85[33], tbl25.MobileControls.Y),
											GroupTransparency = v85[33],
										}, n33, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
									end
								end
							end

							tbl25.MobileControls.Remove = function(arg)
								if not arg or not arg.Gui then
									return
								end

								if arg.Group then
									v101(arg.Group, {
										Position = UDim2.new(0, (arg.LastTargetX or tbl25.MobileControls.X) + tbl25.MobileControls.Width + tbl25.MobileControls.Gap, 0, tbl25.MobileControls.Y),
										GroupTransparency = v85[18],
									}, v85[64], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
								end

								task.delay(0.35, function()
									if arg.Gui then
										arg.Gui:Destroy()
									end
								end)
							end

							tbl25.ManualSpam = { Data = { {}, { 0, 0 } }, Carry = 0 }

							tbl25.MobileControls.Create = function(arg, arg2, arg3, arg4)
								local json = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
								local v109 = tbl25.MobileControls.GetX(arg3)

								local ScreenGui = v98("ScreenGui", {
									Name = arg,
									ResetOnSpawn = false,
									ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
									IgnoreGuiInset = true,
								})

								fn36(ScreenGui)

								local CanvasGroup = v98("CanvasGroup", {
									Name = "Main",
									BackgroundTransparency = 1,
									Position = UDim2.new(0, v109 + tbl25.MobileControls.Width + tbl25.MobileControls.Gap, v85[33], tbl25.MobileControls.Y),
									Size = UDim2.new(0, tbl25.MobileControls.Width, 0, 56),
									GroupTransparency = 1,
									Parent = ScreenGui,
								})

								local TextButton = v98("TextButton", {
									Name = "Button",
									AutoButtonColor = false,
									BackgroundColor3 = colors.Primary,
									BorderSizePixel = v85[33],
									Size = UDim2.new(1, 0, v85[18], 0),
									Text = "",
									Parent = CanvasGroup,
								})

								v98("UICorner", { CornerRadius = UDim.new(0, 11), Parent = TextButton })
								local UIStroke = v98("UIStroke", { Color = colors.BorderSoft, Parent = TextButton })

								local TextLabel = v98("TextLabel", {
									Name = "Title",
									FontFace = json,
									Text = arg2,
									TextColor3 = colors.SubText,
									TextSize = 15,
									BackgroundTransparency = 1,
									Size = UDim2.new(1, 0, 1, 0),
									Parent = TextButton,
								})

								v99(CanvasGroup, TextButton)
								TextButton.MouseButton1Click:Connect(arg4)
								return { Gui = ScreenGui, Group = CanvasGroup, Title = TextLabel, Stroke = UIStroke, Shown = false }
							end

							tbl25.MobileControls.Update = function(arg, arg2, arg3)
								if not arg or not arg.Title then
									return
								end
								arg.Title.Text = arg3 and arg2 .. " (on)" or arg2
								arg.Title.TextColor3 = arg3 and colors.AccentLight or colors.SubText
								arg.Stroke.Color = arg3 and colors.AccentLight or colors.BorderSoft
								tbl25.MobileControls.Layout()
							end

							tbl25.ManualSpam.Refresh = function()
								if not tbl20.ManualSpamUIEnabled then
									local spamPanel = flyteBBState.SpamPanel
									flyteBBState.SpamPanel = nil
									tbl25.MobileControls.Remove(spamPanel)
									tbl25.MobileControls.Layout()
									return
								end

								if not flyteBBState.SpamPanel then
									flyteBBState.SpamPanel = tbl25.MobileControls.Create("ManualSpam", "manual spam", 1, function()
										local manualSpam = tbl24 and tbl24.toggles.Manual_Spam

										if manualSpam and manualSpam.Set then
											manualSpam:Set(not tbl20.ManualSpamEnabled)
										else
											tbl25.ManualSpam.SetEnabled(not tbl20.ManualSpamEnabled)
										end
									end)
								end

								tbl25.MobileControls.Update(flyteBBState.SpamPanel, "manual spam", tbl20.ManualSpamEnabled)
							end

							fn43({
								TriggerbotEnabled = v85[101],
								TriggerbotType = v85[90],
								TriggerbotDelay = 0,
								TriggerbotRandomize = false,
								TriggerbotDelayMin = 0,
								TriggerbotDelayMax = 200,
								TriggerbotIgnoreSpawn = false,
								TriggerbotUIEnabled = false,
							})

							tbl25.Triggerbot = tbl25.Triggerbot or {}

							tbl25.Triggerbot.Fire = function(arg, arg2, arg3)
								local now2 = os.clock()
								local flag19 = flyteBBState.ManualBall == arg

								if flag19 then
									local name = localPlayer.Name
									flag19 = fn51(arg) == name
								end

								if not flag19 then
									flag19 = now2 < (flyteBBState.ExtraParryCooldownUntil or v85[33])
								end

								if flag19 then
									return false
								end
								local triggerbotParried = {}
								arg2.TriggerbotParried = triggerbotParried
								arg2.AutoParryAt = now2
								flyteBBState.AutoParryAt = now2
								local triggerbotParried2 = fn40(arg, tbl20.TriggerbotType, true, arg3) == true

								if arg2.TriggerbotParried == triggerbotParried then
									arg2.TriggerbotParried = triggerbotParried2
								end

								if not triggerbotParried2 then
									if arg2.AutoParryAt == now2 then
										arg2.AutoParryAt = nil
									end

									if flyteBBState.AutoParryAt == now2 then
										flyteBBState.AutoParryAt = nil
									end
								end

								return triggerbotParried2
							end

							tbl25.Triggerbot.TryParry = function(arg, arg2, triggerbotTarget)
								if not tbl20.TriggerbotEnabled or not arg or not arg.Parent or not arg2 or not fn56(arg) then
									return
								end
								triggerbotTarget = triggerbotTarget or fn51(arg)

								if arg2.TriggerbotTarget ~= triggerbotTarget then
									if arg2.TriggerbotTarget and flyteBBState.ManualBall == arg then
										flyteBBState.ManualBall = nil
									end

									arg2.TriggerbotTarget = triggerbotTarget
									arg2.TriggerbotParried = v85[101]
								end

								local flag19 = not (triggerbotTarget == localPlayer.Name)

								if flag19 and flyteBBState.ManualBall == arg then
									flyteBBState.ManualBall = nil
								end

								local v109 = flag19 and tbl25.Detection.GetDribbleBall(arg)
								if flag19 and not v109 then
									arg2.TriggerbotParried = v85[101]
									return
								end

								if arg2.TriggerbotParried then
									return
								end
								local character = localPlayer.Character
								if not fn46(character) then
									return
								end

								if tbl20.TriggerbotIgnoreSpawn then
									local attribute = arg:GetAttribute("from")
									if not attribute or attribute == "" then
										return
									end
								end

								if tbl25.Detection.BlocksParry(arg, character) then
									return
								end
								local v110, v111 = tbl25.Detection.UseProtection(character)
								if v110 then
									arg2.TriggerbotParried = v111 == true
									return
								end
								local triggerbotDelay = tbl20.TriggerbotDelay or v85[33]

								if tbl20.TriggerbotRandomize then
									local triggerbotDelayMin = tbl20.TriggerbotDelayMin or 0
									local triggerbotDelayMax = tbl20.TriggerbotDelayMax or 200
									local max = math.max
									triggerbotDelay = math.random(math.min(triggerbotDelayMin, triggerbotDelayMax), max(triggerbotDelayMin, triggerbotDelayMax))
								end

								if triggerbotDelay <= v85[33] then
									tbl25.Triggerbot.Fire(arg, arg2, v109 ~= nil)
									return
								end
								local triggerbotParried = {}
								arg2.TriggerbotParried = triggerbotParried

								task.delay(triggerbotDelay / 1000, function()
									if arg2.TriggerbotParried ~= triggerbotParried then
										return
									end
									local flag20 = v109 and tbl25.Detection.GetDribbleBall(v109) == v109
									local flag21 = not tbl20.TriggerbotEnabled or not arg.Parent or not fn56(arg)

									if not flag21 then
										local name = localPlayer.Name
										flag21 = fn51(arg) ~= name and not flag20
									end

									if flag21 or tbl25.Detection.BlocksParry(arg, localPlayer.Character) then
										arg2.TriggerbotParried = false
										return
									end
									arg2.TriggerbotParried = false
									tbl25.Triggerbot.Fire(arg, arg2, flag20 and true or false)
								end)
							end

							tbl25.Triggerbot.Update = function()
								if not tbl20.TriggerbotEnabled then
									return
								end

								for _, v109 in tbl25.Ball.GetAllBalls() do
									tbl25.Triggerbot.TryParry(v109, fn58(v109))
								end
							end

							tbl25.Triggerbot.RefreshUI = function()
								if not tbl20.TriggerbotUIEnabled then
									local triggerPanel = flyteBBState.TriggerPanel
									flyteBBState.TriggerPanel = nil
									tbl25.MobileControls.Remove(triggerPanel)
									tbl25.MobileControls.Layout()
									return
								end

								if not flyteBBState.TriggerPanel then
									flyteBBState.TriggerPanel = tbl25.MobileControls.Create("Triggerbot", "triggerbot", flyteBBState.SpamPanel and 2 or 1, function()
										local flag19 = not tbl20.TriggerbotEnabled
										local triggerbot = tbl24 and tbl24.toggles.Triggerbot
										if triggerbot and triggerbot.Set then
											triggerbot:Set(flag19)
											return
										end
										tbl25.Triggerbot.SetEnabled(flag19)
									end)
								end

								tbl25.MobileControls.Update(flyteBBState.TriggerPanel, "triggerbot", tbl20.TriggerbotEnabled)
							end

							tbl25.Triggerbot.SetEnabled = function(triggerbotEnabled)
								if tbl20.TriggerbotEnabled == triggerbotEnabled then
									return
								end

								if triggerbotEnabled then
									flyteBBState.AutoParryTriggerbot = nil
									flyteBBState.TriggerbotAutoParry = tbl20.AutoParryEnabled or nil

									if tbl20.AutoParryEnabled then
										local autoParry = tbl24 and tbl24.toggles.Auto_Parry

										if autoParry and autoParry.Set then
											autoParry:Set(false)
										else
											tbl20.AutoParryEnabled = v85[101]
										end
									end
								end

								tbl20.TriggerbotEnabled = triggerbotEnabled
								if not flyteBBState.Loaded then
									return
								end

								if triggerbotEnabled then
									fn38()
								else
									fn39()
									local triggerbotAutoParry = flyteBBState.TriggerbotAutoParry
									flyteBBState.TriggerbotAutoParry = nil

									if triggerbotAutoParry then
										local autoParry = tbl24 and tbl24.toggles.Auto_Parry

										if autoParry and autoParry.Set then
											autoParry:Set(true)
										else
											tbl20.AutoParryEnabled = true
											fn68(true)
											task.defer(tbl25.Loop.MainParryLoop)
										end
									end
								end

								tbl25.Triggerbot.RefreshUI()
							end

							tbl25.Loop.ManualSpamLoop = function(arg, arg2, arg3)
								if not tbl20.ManualSpamEnabled then
									return
								end

								if not (tbl20.DeathSlashDetection and flyteBBState.DeathSlash) then
									if tbl20.ManualSpamType == "Remote" then
										flyteBBState.ParryMethod = v85[90]

										if tbl25.Parry and tbl25.Parry.Fire then
											local v109, v110 = tbl25.Parry.Fire(nil, true, arg, arg3)

											if v109 and not v110 and arg2 ~= v85[101] and tbl20.ManualSpamAnimFix and tbl20.ManualSpamAnimFixType == "Click" then
												tbl25.Animation.PlayAnimation(nil, "Click")
											end

											return v109, v110
										end

										return
									end

									return tbl25.Animation.Input(tbl20.ManualSpamType, true)
								end

								if n28(3586) < 2192 then
									return
								end

								while true do
								end
							end

							tbl25.ManualSpam.Start = function()
								fn42("Manual Spam")
								tbl20.ManualSpamEnabled = true
								tbl25.ManualSpam.Refresh()
								tbl25.ManualSpam.Time = os.clock()
								tbl25.ManualSpam.Carry = 0

								flyteBBState.Connections["Manual Spam"] = v88.PreSimulation:Connect(function()
									if not tbl20.ManualSpamEnabled then
										return
									end
									alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
									local character = localPlayer.Character
									if not character or character.Parent ~= alive then
										return
									end
									local now2 = os.clock()
									local n33 = math.min(now2 - tbl25.ManualSpam.Time, 0.066666666666666666)
									tbl25.ManualSpam.Time = now2
									local n34

									if tbl20.ManualSpamType == "Remote" then
										local manualSpam = tbl25.ManualSpam
										manualSpam.Carry = manualSpam.Carry + math.max(n33 * 120 - 1, 0)
										n34 = math.min(math.floor(tbl25.ManualSpam.Carry), 7)
										tbl25.ManualSpam.Carry = math.min(tbl25.ManualSpam.Carry - n34, 7)
									else
										tbl25.ManualSpam.Carry = 0
										n34 = 0
									end

									local v109, v110 = tbl25.Loop.ManualSpamLoop(n34 > 0 and tbl25.Parry.GetData(nil, tbl25.ManualSpam.Data), nil, n34 + 1)

									if v109 then
										flyteBBState.ManualSpamAt = now2
									end

									if v109 and not v110 and tbl20.ManualSpamEnabled and tbl20.ManualSpamType == v85[90] and tbl20.ManualSpamAnimFix and tbl20.ManualSpamAnimFixType ~= "Click" then
										tbl25.Animation.PlayAnimation(nil, tbl20.ManualSpamAnimFixType)
									end
								end)

								alive = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")
								local character = localPlayer.Character

								if character and character.Parent == alive then
									local v109, v110 = tbl25.Loop.ManualSpamLoop()

									if v109 and not v110 and tbl20.ManualSpamType == "Remote" and tbl20.ManualSpamAnimFix and tbl20.ManualSpamAnimFixType ~= "Click" then
										tbl25.Animation.PlayAnimation(nil, tbl20.ManualSpamAnimFixType)
									end
								end
							end

							tbl25.ManualSpam.Stop = function()
								local manualSpamEnabled = tbl20.ManualSpamEnabled
								tbl20.ManualSpamEnabled = false
								tbl25.ManualSpam.Refresh()
								fn42("Manual Spam")

								if manualSpamEnabled and tbl20.ManualSpamType == v85[90] and tbl20.ManualSpamAnimFix then
									task.spawn(tbl25.Animation.PlayAnimation)
								end
							end

							tbl25.ManualSpam.SetEnabled = function(arg)
								if arg then
									tbl25.ManualSpam.Start()
								else
									tbl25.ManualSpam.Stop()
								end
							end

							fn43({ KeybindListEnabled = false })
							tbl25.UIExtra = {}

							do
								local function fn73()
									local json = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
									local json2 = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

									local ScreenGui = v98("ScreenGui", {
										Name = "FlyteKeybindList",
										ResetOnSpawn = false,
										ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
										IgnoreGuiInset = true,
									})

									fn36(ScreenGui)

									local CanvasGroup = v98("CanvasGroup", {
										Name = "Main",
										BackgroundTransparency = v85[18],
										Position = UDim2.new(0, 32, v85[81], -120),
										Size = UDim2.new(0, 260, v85[33], 48),
										GroupTransparency = 1,
										Parent = ScreenGui,
									})

									local UIScale = v98("UIScale", { Name = "ListScale", Scale = v85[198], Parent = CanvasGroup })

									local Frame = v98("Frame", {
										Name = "MainFrame",
										BackgroundColor3 = colors.Primary,
										BorderSizePixel = v85[33],
										Size = UDim2.new(1, 0, 1, 0),
										ClipsDescendants = v85[200],
										Parent = CanvasGroup,
									})

									v98(v85[137], { CornerRadius = UDim.new(v85[33], v85[192]), Parent = Frame })
									v98("UIStroke", { Color = colors.BorderSoft, Parent = Frame })

									v98("ImageLabel", {
										Name = "Icon",
										BackgroundTransparency = 1,
										Image = "rbxassetid://10723416765",
										ImageColor3 = colors.SubText,
										Position = UDim2.new(v85[33], 10, 0, 10),
										Size = UDim2.new(v85[33], 16, v85[33], 16),
										Parent = Frame,
									})

									v98(v85[65], {
										Name = "Title",
										FontFace = json2,
										Text = "keybind list",
										TextColor3 = colors.Text,
										TextSize = 15,
										TextXAlignment = Enum.TextXAlignment.Left,
										BackgroundTransparency = 1,
										Position = UDim2.new(0, 32, 0, 8),
										Size = UDim2.new(1, -v85[79], 0, 18),
										Parent = Frame,
									})

									v98("Frame", {
										Name = "Divider",
										BackgroundColor3 = colors.BorderSoft,
										BorderSizePixel = v85[33],
										Position = UDim2.new(v85[33], 10, 0, v85[97]),
										Size = UDim2.new(1, -20, 0, 1),
										Parent = Frame,
									})

									local v109 = v98(v85[170], {
										Name = "Holder",
										BackgroundTransparency = v85[18],
										Position = UDim2.new(0, 10, v85[33], 43),
										Size = UDim2.new(1, -20, 0, 0),
										Parent = Frame,
									})

									local v110 = v98(v85[39], {
										Name = "Drag",
										Text = "",
										AutoButtonColor = false,
										BackgroundTransparency = 1,
										Size = UDim2.new(v85[18], 0, 0, 36),
										ZIndex = 10,
										Parent = Frame,
									})

									v99(CanvasGroup, v110)
									return { Gui = ScreenGui, Group = CanvasGroup, Scale = UIScale, Holder = v109, Rows = {}, Font = json }
								end

								tbl25.UIExtra.RefreshKeybindList = function()
									local keybindPanel = flyteBBState.KeybindPanel
									if not keybindPanel then
										return
									end
									local v109 = v102.GetAll()
									local tbl26 = {}

									for k, v110 in v109, nil, nil do
										local tbl27 = keybindPanel.Rows[v110.Id]
										local n33 = (k - v85[18]) * 22

										if not tbl27 then
											local instance = Instance.new(v85[170])
											instance.Name = v110.Id
											instance.BackgroundColor3 = colors.Secondary
											instance.BackgroundTransparency = 1
											instance.BorderSizePixel = 0
											instance.Position = UDim2.new(0, 0, v85[33], n33 + 8)
											instance.Size = UDim2.new(v85[18], 0, 0, 18)
											instance.Parent = keybindPanel.Holder
											local frame = Instance.new("Frame")
											frame.Name = "Check_Box"
											frame.BackgroundColor3 = colors.Element
											frame.BackgroundTransparency = 1
											frame.BorderSizePixel = 0
											frame.Position = UDim2.new(0, 0, v85[81], -v85[72])
											frame.Size = UDim2.new(0, v85[46], 0, v85[46])
											frame.Parent = instance
											local uiScale = Instance.new("UIScale")
											uiScale.Scale = 0.6
											uiScale.Parent = frame
											local imageLabel = Instance.new("ImageLabel")
											imageLabel.Name = "Check"
											imageLabel.BackgroundTransparency = 1
											imageLabel.Image = "rbxassetid://114461119629011"
											imageLabel.ImageColor3 = colors.AccentLight
											imageLabel.ImageTransparency = 1
											imageLabel.Position = UDim2.new(v85[81], -v85[72], 0.5, -7)
											imageLabel.Size = UDim2.new(0, 14, 0, 14)
											imageLabel.Parent = frame
											local instance2 = Instance.new(v85[65])
											instance2.Name = "Name"
											instance2.FontFace = keybindPanel.Font
											instance2.TextColor3 = colors.SubText
											instance2.TextSize = 13
											instance2.TextXAlignment = Enum.TextXAlignment.Left
											instance2.BackgroundTransparency = 1
											instance2.Position = UDim2.new(0, 22, v85[33], 0)
											instance2.Size = UDim2.new(1, -126, 1, 0)
											instance2.TextTransparency = 1
											instance2.Parent = instance
											local textLabel = Instance.new("TextLabel")
											textLabel.Name = "Key"
											textLabel.FontFace = keybindPanel.Font
											textLabel.TextColor3 = colors.AccentLight
											textLabel.TextSize = 13
											textLabel.TextXAlignment = Enum.TextXAlignment.Right
											textLabel.BackgroundTransparency = v85[18]
											textLabel.Position = UDim2.new(1, -102, 0, 0)
											textLabel.Size = UDim2.new(0, 102, v85[18], 0)
											textLabel.TextTransparency = 1
											textLabel.Parent = instance
											tbl27 = { Frame = instance, Name = instance2, Key = textLabel, Check = imageLabel, CheckScale = uiScale }
											keybindPanel.Rows[v110.Id] = tbl27
											v101(instance, { Position = UDim2.new(v85[33], 0, v85[33], n33), BackgroundTransparency = 0.45 }, v85[64], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
											v101(instance2, { TextTransparency = 0 }, v85[100])
											v101(textLabel, { TextTransparency = v85[33] }, 0.3)
										else
											v101(tbl27.Frame, { Position = UDim2.new(0, 0, 0, n33) }, v85[64], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
										end

										tbl27.Name.Text = string.lower(v110.Name)
										tbl27.Key.Text = v110.Key .. " [" .. string.lower(v110.Mode) .. "]"
										local flag19 = v110.Active == v85[200]
										v101(tbl27.CheckScale, { Scale = flag19 and v85[18] or 0.6 }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
										v101(tbl27.Check, { ImageTransparency = flag19 and 0 or v85[18], Rotation = flag19 and 0 or -45 }, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

										v101(tbl27.Name, {
											Position = UDim2.new(0, flag19 and v85[197] or 0, 0, 0),
											Size = UDim2.new(1, flag19 and -126 or -104, 1, 0),
										}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

										tbl26[v110.Id] = v85[200]
									end

									for k, v110 in keybindPanel.Rows, nil, nil do
										if not tbl26[k] then
											keybindPanel.Rows[k] = nil

											v101(v110.Frame, {
												BackgroundTransparency = v85[18],
												Position = v110.Frame.Position + UDim2.new(0, 0, 0, 8),
											}, 0.25)

											v101(v110.Name, { TextTransparency = 1 }, v85[113])
											v101(v110.Key, { TextTransparency = 1 }, 0.2)
											v101(v110.Check, { ImageTransparency = 1, Rotation = -45 }, 0.2)
											v101(v110.CheckScale, { Scale = 0.6 }, 0.2)

											task.delay(0.26, function()
												if v110.Frame then
													v110.Frame:Destroy()
												end
											end)
										end
									end

									local v110 = v85[197]
									v101(keybindPanel.Group, { Size = UDim2.new(v85[33], 260, 0, 48 + math.max(#v109, 1) * v110) }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
									keybindPanel.Holder.Size = UDim2.new(v85[18], -v85[108], 0, math.max(#v109, 1) * 22)
								end

								tbl25.UIExtra.ToggleKeybindList = function(keybindListEnabled)
									tbl20.KeybindListEnabled = keybindListEnabled
									if not keybindListEnabled then
										tbl25.UIExtra.HideKeybindList(true)
										return
									end

									if not flyteBBState.KeybindPanel then
										flyteBBState.KeybindPanel = fn73()
									end

									flyteBBState.RefreshKeybinds = tbl25.UIExtra.RefreshKeybindList
									tbl25.UIExtra.RefreshKeybindList()
									local keybindPanel = flyteBBState.KeybindPanel
									v101(keybindPanel.Group, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
									v101(keybindPanel.Scale, { Scale = 1 }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
								end
							end
						end

						do
							tbl25.UIExtra.HideKeybindList = function(arg)
								if arg ~= v85[101] then
									tbl20.KeybindListEnabled = false
								end

								if flyteBBState.KeybindPanel then
									local keybindPanel = flyteBBState.KeybindPanel
									flyteBBState.KeybindPanel = nil
									flyteBBState.RefreshKeybinds = nil
									v101(keybindPanel.Group, { GroupTransparency = 1 }, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
									v101(keybindPanel.Scale, { Scale = 0.92 }, v85[64], Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

									task.delay(v85[64], function()
										if keybindPanel.Gui then
											keybindPanel.Gui:Destroy()
										end
									end)
								end
							end

							tbl25.UIExtra.HideOverlays = function()
								flyteBBState.RefreshKeybinds = nil
								fn42("Ball Stats")

								for _, v109 in { "KeybindPanel", "StatsPanel", "SpamPanel", "TriggerPanel" }, nil, nil do
									local v110 = flyteBBState[v109]
									flyteBBState[v109] = nil

									if v110 and v110.Gui then
										v110.Gui:Destroy()
									end
								end

								local extraStats = flyteBBState.ExtraStats or {}

								for _, v109 in extraStats, nil, nil do
									if v109.Gui then
										v109.Gui:Destroy()
									end
								end

								flyteBBState.ExtraStats = {}
							end

							tbl25.LoadRender = function()
								local tbl26 = {
									BallEmit = v85[200],
									Upgrade = v85[200],
									Arch2 = true,
									MaxHook = v85[200],
									Wave = true,
									Totem = true,
									TotemRange = v85[200],
									InfinityFX = true,
									maxTransmission = true,
									transmissionpart = true,
									Tornado = true,
									Barrier = true,
									GUARDIAN_DRAGON = v85[200],
									DRAGON_POSITIONER = true,
									SpiritDeflect = true,
									Vanity = v85[200],
									dash = true,
									Summon = true,
									MaxBlink = true,
								}

								tbl25.Render = {}
								local tbl27 = { Spawn = v85[200], Rhythm = v85[200], Leaderboards = true, Map = true, UiClaimer = true }

								local tbl28 = {
									ParticleEmitter = true,
									Beam = v85[200],
									Trail = true,
									Smoke = true,
									Fire = v85[200],
									Sparkles = true,
									PointLight = true,
									SpotLight = true,
									SurfaceLight = true,
								}

								local numberSequence = NumberSequence.new(1)

								local tbl29 = {
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

								local tbl30 = {}

								local function fn73(arg)
									local className = arg.ClassName
									return className == "Sound" or className:find("Audio", 1, true) ~= nil
								end

								local function fn74(arg)
									local v109 = arg:IsDescendantOf(balls)
									local flag19

									if v109 then
										flag19 = v109
									else
										flag19 = trainingBalls ~= nil and arg:IsDescendantOf(trainingBalls)
									end

									return flag19
								end

								local function fn75(arg)
									while arg and arg.Parent and arg.Parent ~= workspace do
										arg = arg.Parent
									end

									return arg and tbl27[arg.Name] == v85[200]
								end

								local function fn76(arg)
									local fullName = arg:GetFullName()

									for _, v109 in tbl29, nil, nil do
										if fullName == v109 or fullName:sub(1, #v109 + v85[18]) == v109 .. "." then
											return v85[200]
										end
									end

									return false
								end

								local function fn77(arg)
									if arg:IsA("Model") and tbl25.UnlockAll.GetSwordData(arg.Name) then
										return true
									end
									local parent = arg.Parent

									while parent and parent ~= workspace and parent ~= runtime do
										if parent:IsA("Model") and tbl25.UnlockAll.GetSwordData(parent.Name) then
											return v85[200]
										end
										local v109 = string.lower(parent.Name)
										if v109 == "sord" or v109 == "blade" then
											return true
										end
										parent = parent.Parent
									end

									return v85[101]
								end

								local function fn78(arg, arg2)
									flyteBBState.RenderCache = flyteBBState.RenderCache or {}
									local tbl31 = flyteBBState.RenderCache[arg]

									if not tbl31 then
										tbl31 = {}
										flyteBBState.RenderCache[arg] = tbl31
									end

									for k, v109 in arg2, nil, nil do
										if tbl31[k] == nil then
											tbl31[k] = arg[k]
										end

										arg[k] = v109
									end
								end

								local function fn79()
									local renderCache = flyteBBState.RenderCache
									flyteBBState.RenderCache = nil
									if not renderCache then
										return
									end

									local function fn80(arg, arg2)
										for k, v109 in arg2, nil, nil do
											arg[k] = v109
										end
									end

									for k, v109 in renderCache, nil, nil do
										if k.Parent then
											fn80(k, v109)
										else
											pcall(fn80, k, v109)
										end
									end
								end

								local function fn80(arg, arg2, arg3)
									if fn73(arg) then
										return
									end

									if arg:IsA("Highlight") then
										return
									end

									if tbl28[arg.ClassName] then
										if arg:IsA("ParticleEmitter") or arg:IsA("Beam") or arg:IsA("Trail") then
											fn78(arg, { Enabled = false, Transparency = numberSequence })
										else
											fn78(arg, { Enabled = false })
										end

										if arg:IsA("ParticleEmitter") then
											arg:Clear()
										end
									elseif arg:IsA("Decal") or arg:IsA("Texture") then
										fn78(arg, { Transparency = 1 })
									elseif arg3 and (arg:IsA("SurfaceGui") or arg:IsA("BillboardGui")) then
										fn78(arg, { Enabled = false })
									elseif arg:IsA("BasePart") then
										if fn74(arg) then
											return
										end

										if arg2 or (fn76(arg) or tbl30[arg]) and not fn77(arg) then
											fn78(arg, { LocalTransparencyModifier = 1, CanCollide = false, CanTouch = false, CanQuery = false })
										end
									end
								end

								local function fn81(arg)
									while arg and arg.Parent and arg.Parent ~= runtime do
										arg = arg.Parent
									end

									return arg and arg.Parent == runtime and arg
								end

								local function fn82(arg)
									if not arg or not arg.Parent then
										return
									end

									if arg:IsDescendantOf(runtime) then
										local pos = fn81(arg)

										if pos then
											pos = pos.Name:find("PortalFor_") or pos.Name:find("WaypointFor_") or tbl26[pos.Name]
										end

										if pos then
											return
										end
										fn80(arg, true, false)
									elseif (arg:IsA("SurfaceGui") or arg:IsA("BillboardGui")) and fn75(arg) then
										fn80(arg, false, true)
									else
										fn80(arg, v85[101])
									end
								end

								tbl25.Render.DisableFX = function(noRender)
									flyteBBState.NoRender = noRender
									fn42("Render Workspace")

									if not noRender then
										fn79()
										table.clear(tbl30)
										return
									end

									local descendants = workspace:GetDescendants()
									table.clear(tbl30)

									for _, v109 in descendants, nil, nil do
										if fn73(v109) then
											local basePart = v109:FindFirstAncestorWhichIsA("BasePart")

											if basePart and not fn74(basePart) then
												tbl30[basePart] = v85[200]
											end
										end
									end

									for _, v109 in descendants, nil, nil do
										fn82(v109)
									end

									flyteBBState.Connections["Render Workspace"] = workspace.DescendantAdded:Connect(function(descendant)
										if not flyteBBState.NoRender then
											return
										end

										if fn73(descendant) then
											local basePart = descendant:FindFirstAncestorWhichIsA("BasePart")

											if basePart and not fn74(basePart) then
												tbl30[basePart] = true
												fn80(basePart, false)
											end

											return
										end

										fn82(descendant)
									end)
								end

								local tbl31 = { BloomEffect = true, BlurEffect = v85[200], DepthOfFieldEffect = true, SunRaysEffect = true }

								local function fn83(arg, arg2, arg3)
									flyteBBState.AntiLagCache = flyteBBState.AntiLagCache or {}
									local tbl32 = flyteBBState.AntiLagCache[arg]

									if not tbl32 then
										tbl32 = {}
										flyteBBState.AntiLagCache[arg] = tbl32
									end

									if tbl32[arg2] == nil then
										tbl32[arg2] = arg[arg2]
									end

									arg[arg2] = arg3
								end

								local function antiLagRestore()
									flyteBBState.AntiLag = false
									flyteBBState.AntiLagRestore = nil
									fn29(flyteBBState.AntiLagConnections or {})
									flyteBBState.AntiLagConnections = nil
									local antiLagCache = flyteBBState.AntiLagCache
									flyteBBState.AntiLagCache = nil
									antiLagCache = antiLagCache or {}

									for k, v109 in antiLagCache, nil, nil do
										pcall(function()
											for k2, v110 in v109, nil, nil do
												k[k2] = v110
											end
										end)
									end
								end

								local function fn84(descendant)
									if not flyteBBState.AntiLag then
										return
									end
									local className = descendant.ClassName

									if className == "Atmosphere" then
										fn83(descendant, "Density", 0)
										fn83(descendant, "Haze", 0)
										fn83(descendant, "Glare", v85[33])
										return
									end

									if className == "Clouds" then
										fn83(descendant, "Enabled", false)
										return
									end

									if not tbl31[className] then
										return
									end
									local antiLagCache = flyteBBState.AntiLagCache and flyteBBState.AntiLagCache[descendant]
									if antiLagCache and antiLagCache.Enabled ~= nil then
										return
									end
									fn83(descendant, "Enabled", false)

									flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + 1] = descendant:GetPropertyChangedSignal("Enabled"):Connect(function()
										if flyteBBState.AntiLag and descendant.Enabled then
											descendant.Enabled = v85[101]
										end
									end)
								end

								tbl25.Render.SetAntiLag = function(arg)
									antiLagRestore()
									if not arg then
										return
									end
									flyteBBState.AntiLag = true
									flyteBBState.AntiLagConnections = {}
									flyteBBState.AntiLagRestore = antiLagRestore
									local Lighting2 = game:GetService("Lighting")
									local terrain = workspace.Terrain
									local level01 = Enum.QualityLevel.Level01
									fn83(settings().Rendering, "QualityLevel", level01)
									fn83(Lighting2, "GlobalShadows", false)
									fn83(Lighting2, "EnvironmentDiffuseScale", 0)
									fn83(Lighting2, "EnvironmentSpecularScale", v85[33])
									fn83(terrain, "WaterWaveSize", v85[33])
									fn83(terrain, "WaterWaveSpeed", 0)
									fn83(terrain, "WaterReflectance", 0)

									local function fn85(arg2)
										if not arg2 then
											return
										end

										for _, v109 in arg2:GetDescendants() do
											fn84(v109)
										end

										flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + 1] = arg2.DescendantAdded:Connect(fn84)
									end

									fn85(Lighting2)
									fn85(terrain)
									fn85(workspace.CurrentCamera)

									flyteBBState.AntiLagConnections[#flyteBBState.AntiLagConnections + v85[18]] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
										fn85(workspace.CurrentCamera)
									end)
								end
							end

							tbl25.LoadRender()

							flyteBBState.Connections[v85[182]] = task.spawn(function()
								local function fn73(arg, arg2)
									local v109 = fn58(arg)
									v109.TargetChanges = 0
									v109.Target = fn51(arg)
									v109.LoopTarget = v109.Target
									v109.Parried = false
									v109.ParryResetAt = 0
									v109.AutoParryAt = nil
									fn66(v109)
									v109.Zoomies = nil
									v109.CurveReference = nil
									v109.CurveSource = nil
									v109.CurveTargetDirection = nil
									v109.CurveReady = nil
									v109.CurveVersion = 0
									v109.Connections = {}

									local function fn74()
										local curveVelocity = v109.Connections.CurveVelocity

										if curveVelocity then
											curveVelocity:Disconnect()
											v109.Connections.CurveVelocity = nil
										end
									end

									local function fn75(zoomies)
										local referenceVelocity = v109.Connections.ReferenceVelocity

										if referenceVelocity then
											referenceVelocity:Disconnect()
											v109.Connections.ReferenceVelocity = nil
										end

										v109.Zoomies = zoomies

										if zoomies then
											v109.Connections.ReferenceVelocity = zoomies:GetPropertyChangedSignal("VectorVelocity"):Connect(function()if  tbl20 .BackwardsAntiCurveEnabled then  fn62 ( arg , v109 );end;end)
											fn62(arg, v109)
										end
									end

									local function fn76(F,P)if  v109 .CurveVersion~=F or not  arg .Parent or  fn51 ( arg )~= localPlayer .Name then return;end; fn74 (); v109 .CurveReady=true;if  tbl20 .AutoParryEnabled and not P then task.spawn( tbl25 .Loop.MainParryLoop);end;end

									local function fn77()
										if fn56(arg) then
											if table.find(arg2, arg) then
												return
											end
											table.insert(arg2, arg)

											if flyteBBState.Loaded and tbl20.TriggerbotEnabled then
												tbl25.Triggerbot.TryParry(arg, v109)
											elseif flyteBBState.Loaded and tbl20.AutoParryEnabled then
												task.spawn(tbl25.Loop.MainParryLoop)
											end
										else
											local v110 = table.find(arg2, arg)

											if v110 then
												table.remove(arg2, v110)
											end
										end
									end

									fn75(arg:FindFirstChild("zoomies"))
									local targetAttachment = arg:FindFirstChild("TargetAttachment")
									v109.Connections.Target = (targetAttachment and targetAttachment.Changed or arg:GetAttributeChangedSignal("target")):Connect(function() v109 .TargetChanges=( v109 .TargetChanges or 0)+1;local F= fn51 ( arg );local P= v109 .Target~=F;if P or not  targetAttachment then  v109 .Parried=false; v109 .ParryResetAt=0;if  flyteBBState .ManualBall== arg then  flyteBBState .ManualBall=nil;end;if  v107 == arg then  flag18 =false; v107 =nil; n32 =0;end;end;if P then if F== localPlayer .Name then  fn65 ( v109 );else  fn66 ( v109 );end;end;if  tbl20 .TriggerbotEnabled then  tbl25 .Triggerbot.TryParry( arg , v109 ,F);end;if P then  v109 .CurveVersion= v109 .CurveVersion+1;if F== localPlayer .Name and  tbl20 .BackwardsAntiCurveEnabled then if  arg :GetAttribute("DribbleActive")==true then  v109 .CurveReference=nil;end; v109 .CurveSource=type( v109 .Target)=="string"and  v109 .Target~=""and  v109 .Target~= localPlayer .Name and  v109 .Target or nil; v109 .CurveTargetDirection= fn61 ( v109 .CurveSource); v109 .CurveReady=nil;local P= v109 .CurveVersion;local x= v109 .Zoomies;if  tbl20 .BackwardsAntiCurveEnabled and  arg .Parent~= trainingBalls and not  fn57 ( arg )and x then local f;f=x:GetPropertyChangedSignal("VectorVelocity"):Connect(function()if  v109 .Connections.CurveVelocity==f then  fn76 (P);end;end); v109 .Connections.CurveVelocity=f;local f=x.VectorVelocity;local x,h=f.Magnitude, v109 .CurveReference;local M,C=h and h.Magnitude or 0, localPlayer .Character;local Y=C and C.PrimaryPart;C= v109 .CurveTargetDirection or Y and Y.Position- fn54 ( arg );if M<0.001 or x>=0.001 and(h:Dot(f)<=0 or C and C:Dot(f)>=0)then  fn76 (P,true);end;else  fn76 (P,true);end;else  fn74 (); v109 .CurveReference=nil; v109 .CurveSource=nil; v109 .CurveTargetDirection=nil; v109 .CurveReady=nil; fn62 ( arg , v109 );end;end; v109 .Target=F;if  flyteBBState .AutoBall== arg and F~= localPlayer .Name then  flyteBBState .AutoBall=nil;if  tbl20 .AutoParryEnabled and# arg2 >1 and  tbl25 .Loop and  tbl25 .Loop.MainParryLoop then  tbl25 .Loop.MainParryLoop();end;elseif F== localPlayer .Name and  tbl20 .AutoParryEnabled and(# arg2 >1 or  v109 .CurveReady or not  tbl20 .BackwardsAntiCurveEnabled)and  tbl25 .Loop and  tbl25 .Loop.MainParryLoop then  tbl25 .Loop.MainParryLoop();end;if  tbl25 .Ball.Target== arg and F~= localPlayer .Name then  tbl25 .Ball.Target=nil;end;end)

									if targetAttachment then
										v109.Connections.TriggerbotTarget = arg:GetAttributeChangedSignal("target"):Connect(function()
											if tbl20.TriggerbotEnabled then
												tbl25.Triggerbot.TryParry(arg, v109)
											end
										end)
									end

									v109.Connections.TriggerbotSpawn = arg:GetAttributeChangedSignal("from"):Connect(function()
										if tbl20.TriggerbotEnabled and tbl20.TriggerbotIgnoreSpawn then
											tbl25.Triggerbot.TryParry(arg, v109)
										end
									end)

									v109.Connections.Real = arg:GetAttributeChangedSignal("realBall"):Connect(fn77)

									v109.Connections.ChildAdded = arg.ChildAdded:Connect(function(child)
										if child.Name == "zoomies" then
											fn75(child)
										end

										fn77()
									end)

									v109.Connections.ChildRemoved = arg.ChildRemoved:Connect(function(child)
										if child == v109.Zoomies then
											fn75(nil)
											fn74()

											if not v109.CurveReady then
												fn76(v109.CurveVersion)
											end
										end

										fn77()
									end)

									flyteBBState.Connections[arg] = v109.Connections
									fn77()
								end

								local function fn74(arg, arg2)
									if v107 == arg then
										v107 = nil
										flag18 = false
										n32 = 0
									end

									if flyteBBState.AutoBall == arg then
										flyteBBState.AutoBall = nil
									end

									local v109 = table.find(arg2, arg)

									if v109 then
										table.remove(arg2, v109)
									end

									if tbl25.Ball.Target == arg then
										tbl25.Ball.Target = nil
									end

									local v110 = fn52(arg)
									obj[arg] = nil

									if v110 and v110 ~= arg then
										obj[v110] = nil
									end

									local v111 = obj2[arg]

									if v111 and v111.Connections then
										fn29(v111.Connections)
									end

									flyteBBState.Connections[arg] = nil
									obj2[arg] = nil
								end

								local function fn75(arg, arg2, arg3)
									for _, v109 in arg:GetChildren() do
										fn73(v109, arg2)
									end

									flyteBBState.Connections[arg3 .. " Added"] = arg.ChildAdded:Connect(function(child)
										fn73(child, arg2)
									end)

									flyteBBState.Connections[arg3 .. " Removed"] = arg.ChildRemoved:Connect(function(child)
										fn74(child, arg2)
									end)
								end

								fn75(balls, tbl25.Ball.List, "Ball")

								local function fn76(child)
									if child.Name ~= "TrainingBalls" then
										return
									end
									trainingBalls = child
									fn42("Training Folder")
									fn75(child, tbl25.Ball.TrainingList, "Training Ball")
								end

								flyteBBState.Connections["Training Folder"] = workspace.ChildAdded:Connect(fn76)
								local trainingBalls2 = workspace:FindFirstChild("TrainingBalls")

								if trainingBalls2 then
									fn76(trainingBalls2)
								end
							end)

							fn43({ UnlockAllEnabled = v85[101] })

							do
								local unlockAll = {
									Run = v85[33],
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
										{ v85[183], "Section" },
										{ "ForceHide", "ForceHide" },
									},
									ShopActive = v85[101],
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
									EmoteCatalogLoaded = v85[101],
									ButtonConnections = {},
									CardConnections = {},
									EquippedEmotes = {},
									Finishers = {},
									DefaultFinishers = {},
									Overlays = {},
									MultiDelete = { Sword = {}, Explosion = {} },
									MultiDeleteCards = {},
								}

								tbl25.UnlockAll = unlockAll

								unlockAll.Add = function(arg)
									if arg then
										table.insert(unlockAll.Connections, arg)
									end

									return arg
								end

								local function fn73(arg, arg2, arg3)
									local v109 = unlockAll.Originals[arg]

									if v109 then
										arg2[arg3 or arg] = v109
										unlockAll.Originals[arg] = nil
									end
								end

								unlockAll.GetCharacter = function()
									local character = localPlayer.Character
									local humanoid = character and character:FindFirstChildOfClass("Humanoid")
									if character and character.Parent and (not humanoid or humanoid.Health > 0) then
										return character
									end
								end

								unlockAll.Load = function()
									if unlockAll.EmotesFolder then
										return true
									end
									local controllers = v93.Controllers
									local shared = v93.Shared
									local Replion = require(v93.Packages.Replion)
									unlockAll.InventoryClient = require(shared.Inventory).Client
									unlockAll.InventoryShared = require(shared.Inventory.Shared)
									unlockAll.InventoryController = require(controllers.Trading.InventoryController)
									unlockAll.InventoryReplion = Replion.Client:GetReplion("Inventory")
									unlockAll.DataReplion = Replion.Client:GetReplion("Data")
									unlockAll.Shop = require(controllers.UI.ShopController)
									unlockAll.ShopAPI = require(controllers.UI.ShopControllerAPI)
									unlockAll.TradeInfo = require(shared.Trading.TradeInfo)
									unlockAll.Swords = require(shared.ReplicatedInstances.Swords)
									unlockAll.SwordFX = require(shared.ReplicatedInstances.SwordFX)
									unlockAll.EmoteWheel = require(controllers.EmoteWheelController)
									unlockAll.EmoteController = require(controllers.EmoteController)
									unlockAll.DeletePrompt = require(controllers.DeleteItemPromptController)
									unlockAll.FinishersController = require(controllers.FinishersController)
									unlockAll.VFX = require(controllers.VFXController)
									unlockAll.EmotesShared = require(shared.EmotesShared)
									unlockAll.ItemInfo = require(shared.ItemInfo)
									unlockAll.AwakenData = require(shared.SecretAwakenData)
									unlockAll.AwakenBase = {}

									for k, v109 in unlockAll.AwakenData, nil, nil do
										if type(v109) == "table" and v109.Awakened then
											unlockAll.AwakenBase[v109.Awakened.Value] = k
										end
									end

									unlockAll.Trove = require(v93.Packages.Trove)
									unlockAll.EmotesFolder = v93.Misc.Emotes
									return true
								end

								unlockAll.ShopReady = function()
									local virtualItems = unlockAll.Shop._virtualItems
									if not virtualItems then
										return v85[101]
									end
									local loadInventoryPage = unlockAll.Shop._loadInventoryPage

									if loadInventoryPage then
										for _, v109 in unlockAll.Types, nil, nil do
											if virtualItems[v109] and not next(virtualItems[v109]) then
												loadInventoryPage(v109)
											end
										end
									end

									local inventoryPages = unlockAll.Shop._inventoryPages
									local sword = inventoryPages and inventoryPages.Sword
									inventoryPages = inventoryPages and inventoryPages.Explosion
									return virtualItems.Sword and next(virtualItems.Sword) ~= nil and virtualItems.Explosion and next(virtualItems.Explosion) ~= nil and sword and sword.BatchDepth == v85[33] and inventoryPages and inventoryPages.BatchDepth == 0
								end

								unlockAll.Save = function()
									tbl19.UnlockAll = tbl19.UnlockAll or {}
									tbl19.UnlockAll.Sword = unlockAll.AwakenBase[unlockAll.Sword] or unlockAll.Sword
									tbl19.UnlockAll.Explosion = unlockAll.Explosion
									local emotes = {}

									for k, v109 in unlockAll.EquippedEmotes, nil, nil do
										emotes[tostring(k)] = v109
									end

									tbl19.UnlockAll.Emotes = emotes
									tbl19.UnlockAll.Accessory = unlockAll.Accessory == v85[200]
									tbl19.UnlockAll.Finishers = table.clone(unlockAll.Finishers)

									tbl19.UnlockAll.Favorites = {
										Sword = table.clone(unlockAll.Favorites.Sword),
										Explosion = table.clone(unlockAll.Favorites.Explosion),
										Emote = table.clone(unlockAll.Favorites.Emote),
									}

									tbl20.UnlockAllSword = tbl19.UnlockAll.Sword or ""
									tbl20.UnlockAllExplosion = unlockAll.Explosion or ""
									tbl20.UnlockAllEmotes = tbl19.UnlockAll.Emotes
									tbl20.UnlockAllAccessory = tbl19.UnlockAll.Accessory
									tbl20.UnlockAllFinishers = tbl19.UnlockAll.Finishers
									tbl20.UnlockAllFavorites = tbl19.UnlockAll.Favorites
									fn34()
								end

								unlockAll.LoadFavorites = function()
									for _, v109 in { "Sword", "Explosion", "Emote" }, nil, nil do
										table.clear(unlockAll.Favorites[v109])
										local flag19 = type(tbl20.UnlockAllFavorites) == "table" and tbl20.UnlockAllFavorites[v109]

										if type(flag19) == "table" then
											for k, v110 in flag19, nil, nil do
												if v110 == true then
													unlockAll.Favorites[v109][k] = true
												end
											end
										end
									end
								end

								unlockAll.ApplyFavorites = function()
									for k, v109 in unlockAll.Favorites, nil, nil do
										for k2 in v109, nil, nil do
											unlockAll.SetFavorite(k, k2, v85[200], false)
										end
									end
								end

								unlockAll.GetFavoriteState = function(arg, arg2)
									local str5 = arg .. "\0" .. tostring(arg2)
									local v109 = unlockAll.FavoriteStates[str5]
									if v109 then
										return v109
									end
									local favoriteState = unlockAll.InventoryController:GetFavoriteState(arg, arg2)

									if favoriteState then
										unlockAll.FavoriteStates[str5] = favoriteState
										unlockAll.DefaultFavorites[str5] = favoriteState:Get() == true
									end

									return favoriteState
								end

								unlockAll.GetShopFavorites = function()
									if unlockAll.ShopFavorites then
										return unlockAll.ShopFavorites
									end
									local sword = unlockAll.Shop._inventoryPages and unlockAll.Shop._inventoryPages.Sword
									local v109 = sword and getupvalues and getupvalues(sword.MarkDirty)
									v109 = v109 and v109[2]
									local tbl26 = v109 and getupvalues(v109)
									tbl26 = tbl26 and tbl26[4]
									tbl26 = tbl26 and getupvalues(tbl26) or {}

									for _, v110 in tbl26, nil, nil do
										if type(v110) == "table" and type(v110.Sword) == "table" and type(v110.Explosion) == "table" then
											unlockAll.ShopFavorites = v110
											return v110
										end
									end
								end

								unlockAll.SetFavorite = function(arg, arg2, arg3, arg4)
									if not unlockAll.Favorites[arg] then
										return
									end
									unlockAll.Favorites[arg][arg2] = arg3 and true or nil
									local v109 = unlockAll.GetFavoriteState(arg, arg2)
									local flag19 = arg ~= "Emote" and unlockAll.GetShopFavorites()

									if flag19 and flag19[arg] then
										flag19[arg][arg2] = arg3 and true or nil
										local inventoryPages = unlockAll.Shop._inventoryPages and unlockAll.Shop._inventoryPages[arg]

										if inventoryPages and inventoryPages.MarkDirty then
											inventoryPages.MarkDirty(nil, v85[200], true)
										end
									end

									if v109 then
										v109:Set(arg3 == true)
									end

									local consoleItems = unlockAll.ConsoleItems and unlockAll.ConsoleItems[arg] and unlockAll.ConsoleItems[arg][arg2]

									if consoleItems then
										consoleItems.Data.IsFavorited:Set(arg3 == v85[200])
									end

									if arg4 ~= false then
										unlockAll.Save()
									end
								end

								unlockAll.ToggleFavorite = function(arg, arg2)
									unlockAll.SetFavorite(arg, arg2, not unlockAll.Favorites[arg][arg2])
								end

								unlockAll.RestoreFavorites = function()
									local v109 = unlockAll.GetShopFavorites()

									for k, v110 in unlockAll.FavoriteStates, nil, nil do
										local flag19 = unlockAll.DefaultFavorites[k] == true
										local str5 = string.find(k, "\0", 1, true)
										local str6 = str5 and string.sub(k, 1, str5 - 1)
										str5 = str5 and string.sub(k, str5 + 1)

										if v109 and v109[str6] and str5 then
											v109[str6][str5] = flag19 and true or nil
										end

										v110:Set(flag19)
									end

									for _, v110 in unlockAll.Types, nil, nil do
										local inventoryPages = unlockAll.Shop._inventoryPages and unlockAll.Shop._inventoryPages[v110]

										if inventoryPages then
											inventoryPages.MarkDirty(nil, v85[200], v85[200])
										end
									end

									table.clear(unlockAll.FavoriteStates)
									table.clear(unlockAll.DefaultFavorites)
								end

								unlockAll.GetShopState = function(T,F)local P=T and T[F];if type(P)=="table"and type(P.Get)=="function"then return P:Get();end;return P;end
								unlockAll.ApplyShopState = function(T,F,P)local x=T and T[F];if type(x)=="table"and type(x.Set)=="function"then x:Set(P);elseif T then T[F]=P;end;end

								unlockAll.SetShopState = function(arg, arg2)
									if not arg then
										return
									end
									local v109 = unlockAll.ShopState[arg]
									if not v109 then
										return
									end
									local tbl26 = unlockAll.ShopChanges[arg]
									local flag19 = false

									for _, v110 in unlockAll.ShopFields, nil, nil do
										local v111 = v110[1]
										local v112 = v110[2]
										local v113 = arg2[v111]

										if v113 ~= nil then
											local v114 = unlockAll.GetShopState(arg, v112)

											if v114 ~= v113 then
												unlockAll.ApplyShopState(arg, v112, v113)
												tbl26 = tbl26 or {}

												if tbl26[v111] == nil then
													tbl26[v111] = v114
												elseif tbl26[v111] == v113 then
													tbl26[v111] = nil
												end

												flag19 = true
											end

											v109[v111] = v113
										end
									end

									if tbl26 then
										unlockAll.ShopChanges[arg] = next(tbl26) and tbl26 or nil
									end

									local inventoryPages = unlockAll.Shop._inventoryPages and unlockAll.Shop._inventoryPages[arg.Type]

									if flag19 and inventoryPages and inventoryPages.MarkDirty and inventoryPages.BatchDepth == 0 then
										inventoryPages.MarkDirty(arg, false, true)
									end

									if flag19 and unlockAll.ConsoleItems then
										unlockAll.SyncConsoleItem(arg)
									end
								end

								unlockAll.IsUnlockItem = function(arg)
									local v109 = v85[145]
									local flag19 = type(arg) == v109

									if flag19 then
										flag19 = tostring(arg.Id or ""):match("^UnlockAll:") ~= nil
									end

									return flag19
								end

								unlockAll.GetOwnedItem = function(arg, arg2)
									local v109 = unlockAll.InventoryClient:FindItems(arg, arg2)
									local flag19 = type(v109) == "table" and v109[1]
									local item = flag19 and unlockAll.InventoryClient:GetItem(arg, flag19)

									if item and not unlockAll.IsUnlockItem(item) then
										local v110 = table.clone(item)
										v110.Id = v110.Id or flag19
										return v110
									end

									local tbl26 = unlockAll.InventoryClient:GetInventory()[arg] or {}

									for _, v110 in tbl26, nil, nil do
										if v110.Name == arg2 and not unlockAll.IsUnlockItem(v110) then
											return v110
										end
									end
								end

								unlockAll.GetRealEquipped = function(arg)
									local equipped = unlockAll.InventoryClient:GetEquipped(arg)
									if not unlockAll.IsUnlockItem(equipped) then
										return equipped
									end
									return unlockAll.GetOwnedItem(arg, equipped.Name)
								end

								unlockAll.ActivateShop = function()
									if unlockAll.ShopActive then
										return true
									end
									unlockAll.ShopActive = v85[200]
									table.clear(unlockAll.ShopState)
									table.clear(unlockAll.ShopChanges)
									local run = unlockAll.Run
									local n33 = os.clock() + 0.004
									local shop = unlockAll.Shop
									local inventoryPages = shop._inventoryPages
									local shopState = unlockAll.ShopState
									local shopItems = unlockAll.ShopItems
									local deleted = unlockAll.Deleted

									local function fn74(arg)
										if os.clock() < n33 then
											return true
										end
										v88.Heartbeat:Wait()

										if unlockAll.Run ~= run or unlockAll.Status ~= "active" then
											if arg and arg.EndBatch then
												arg.EndBatch()
											end

											return v85[101]
										end

										n33 = os.clock() + 0.004
										return v85[200]
									end

									for _, v109 in unlockAll.Types, nil, nil do
										local v110 = inventoryPages and inventoryPages[v109]

										if v110 and v110.BeginBatch then
											v110.BeginBatch()
										end

										local tbl26 = shop._virtualItems[v109] or {}
										local v111 = shopItems[v109]
										local tbl27 = {}
										table.clear(v111)

										for _, v112 in tbl26, nil, nil do
											local name = v112.Name

											if name and name ~= "Random" then
												local flag19 = unlockAll.GetShopState(v112, "OwnsItem")

												local tbl28 = {
													Owns = flag19,
													Section = unlockAll.GetShopState(v112, v85[183]),
													ForceHide = unlockAll.GetShopState(v112, "ForceHide"),
													ItemsMatching = unlockAll.GetShopState(v112, "ItemsMatching"),
													InDeleteMulti = unlockAll.GetShopState(v112, "InDeleteMulti"),
													Virtual = flag19 ~= true,
												}

												shopState[v112] = tbl28
												local v113 = v111[name]

												if not v113 then
													v111[name] = v112
													flag19 = flag19 and not tbl28.ForceHide or nil
													tbl27[name] = flag19
												elseif not tbl27[name] then
													local v114 = shopState[v113]

													if flag19 and not tbl28.ForceHide then
														v111[name] = v112
														tbl27[name] = v85[200]
													elseif flag19 and not v114.Owns then
														v111[name] = v112
													elseif v114.ForceHide and not tbl28.ForceHide then
														v111[name] = v112
													end
												end
											end

											if not fn74(v110) then
												return v85[101]
											end
										end

										for _, v112 in tbl26, nil, nil do
											local name = v112.Name

											if name and name ~= "Random" then
												local v113 = shopState[v112]
												local v114 = table.clone(v113)

												if v112 == v111[name] then
													local v115 = deleted[v109][name]
													local forceHide = v109 == "Sword" and unlockAll.AwakenBase[name] ~= nil
													local itemsMatching = v113.ItemsMatching or {}

													if v115 or forceHide then
														itemsMatching = {}
													elseif #itemsMatching == 0 then
														itemsMatching = { "UnlockAll:" .. name }
													end

													v113.ItemsMatching = itemsMatching
													v113.InDeleteMulti = 0
													v113.Owns = #itemsMatching > 0
													v113.Section = v113.Owns and "Owned" or "Unowned"
													v113.ForceHide = forceHide
												else
													v113.ForceHide = true
												end

												local tbl28 = {}

												for _, v115 in unlockAll.ShopFields, nil, nil do
													if v113[v115[1]] ~= v114[v115[1]] then
														tbl28[v115[1]] = v114[v115[1]]
													end
												end

												unlockAll.ShopChanges[v112] = next(tbl28) and tbl28 or nil
											end

											if not fn74(v110) then
												return v85[101]
											end
										end

										for _, v112 in tbl26, nil, nil do
											local v113 = unlockAll.ShopChanges[v112]

											if v113 then
												for _, v114 in unlockAll.ShopFields, nil, nil do
													if v113[v114[1]] ~= nil then
														unlockAll.ApplyShopState(v112, v114[v85[70]], shopState[v112][v114[1]])
													end
												end
											end
										end

										if v110 and v110.MarkDirty then
											v110.MarkDirty(nil, false, true)
										end

										if v110 and v110.EndBatch then
											v110.EndBatch()
										end
									end

									return true
								end

								unlockAll.RestoreShop = function()
									if not unlockAll.ShopActive then
										return
									end
									unlockAll.ShopActive = v85[101]
									local inventoryPages = unlockAll.Shop._inventoryPages

									for _, v109 in unlockAll.Types, nil, nil do
										local v110 = inventoryPages and inventoryPages[v109]

										if v110 and v110.BeginBatch then
											v110.BeginBatch()
										end
									end

									for k, v109 in unlockAll.ShopChanges, nil, nil do
										for _, v110 in unlockAll.ShopFields, nil, nil do
											if v109[v110[1]] ~= nil then
												unlockAll.ApplyShopState(k, v110[2], v109[v110[1]])
											end
										end
									end

									for _, v109 in unlockAll.Types, nil, nil do
										local v110 = inventoryPages and inventoryPages[v109]

										if v110 and v110.MarkDirty then
											v110.MarkDirty(nil, false, true)
										end

										if v110 and v110.EndBatch then
											v110.EndBatch()
										end
									end

									table.clear(unlockAll.ShopState)
									table.clear(unlockAll.ShopChanges)
									table.clear(unlockAll.ShopItems.Sword)
									table.clear(unlockAll.ShopItems.Explosion)
								end

								unlockAll.GetSelected = function()
									local console = unlockAll.Console

									if console then
										local currentPage = console:GetCurrentPage()
										local name = console.PageInfo[currentPage]
										name = name and name.ItemState:Get()
										name = name and name.ItemInfo.Name
										if unlockAll.ShopItems[currentPage] and name then
											return currentPage, name, unlockAll.ShopItems[currentPage][name]
										end
										return
									end

									local selectedItem = unlockAll.Shop and unlockAll.Shop._selectedItem
									local type_ = selectedItem and selectedItem.type
									selectedItem = selectedItem and selectedItem.name
									if (type_ == "Sword" or type_ == "Explosion") and selectedItem then
										return type_, selectedItem, unlockAll.ShopItems[type_][selectedItem]
									end
								end

								unlockAll.MakeOverlay = function(arg, parent, arg2)
									if not parent then
										return
									end
									local textButton = Instance.new("TextButton")
									textButton.Name = "UnlockAll" .. arg
									textButton.Text = ""
									textButton.AutoButtonColor = false
									textButton.BackgroundTransparency = 1
									textButton.BorderSizePixel = 0
									textButton.Size = UDim2.new(1, 0, 1, 0)
									textButton.ZIndex = 100
									textButton.Visible = false
									textButton.Parent = parent
									unlockAll.Add(textButton.Activated:Connect(arg2))
									unlockAll.Overlays[arg] = textButton
								end

								unlockAll.RefreshShop = function()
									if unlockAll.Console then
										return
									end
									local v109, v110, v111 = unlockAll.GetSelected()
									local visible = unlockAll.Status == "active" and v111 ~= nil and not unlockAll.Shop._multiDelete and unlockAll.Deleted[v109][v110] ~= true
									local favorite = unlockAll.Overlays.Favorite
									local delete = unlockAll.Overlays.Delete
									local accessory = unlockAll.Overlays.Accessory
									local finisher = unlockAll.Overlays.Finisher

									if favorite then
										favorite.Visible = visible
									end

									if accessory then
										accessory.Visible = false
									end

									if finisher then
										finisher.Visible = false
									end

									v111 = v111 and unlockAll.ShopState[v111]
									local owns = visible and v111 ~= nil and v111.Owns

									if delete then
										delete.Visible = owns and v111 ~= nil
									end

									local shop = v104:FindFirstChild("Shop")
									shop = shop and shop:FindFirstChild("Holder")

									if (v109 == "Sword" or v109 == "Explosion") and shop and shop:FindFirstChild("Favorite") then
										shop.Favorite.Visible = owns

										if owns then
											local flag19 = unlockAll.Favorites[v109][v110] == true
											shop.Favorite.Image = flag19 and "rbxassetid://15697987058" or "rbxassetid://15697981750"
											shop.Favorite.HoverImage = flag19 and "rbxassetid://15697983062" or "rbxassetid://15697987058"
										end
									end

									shop = shop and shop:FindFirstChild("InfoBG")

									if shop and shop:FindFirstChild("SecretUpgrade") then
										shop.SecretUpgrade.Visible = owns and v109 == "Sword" and unlockAll.AwakenData[v110] ~= nil
									end

									local flag19 = v109 and v110 and unlockAll.Deleted[v109][v110] == true

									if shop and shop:FindFirstChild("Delete") then
										shop.Delete.Visible = delete and delete.Visible or false
									end

									local buyButton = shop and shop:FindFirstChild("BuyButton")

									if shop and flag19 then
										for _, v112 in {
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
										}, nil, nil do
											local v113 = shop:FindFirstChild(v112)

											if v113 and v113:IsA("GuiObject") then
												v113.Visible = false
											end
										end
									end

									if buyButton and owns and v111 and v111.Virtual then
										local flag20 = v109 == "Sword" and unlockAll.Sword == v110 or v109 == "Explosion" and unlockAll.Explosion == v110
										buyButton.Visible = true
										buyButton.Active = true

										if buyButton:FindFirstChild("PriceTag") then
											local price = buyButton.PriceTag:FindFirstChild("Price")
											local textLabel = buyButton.PriceTag:FindFirstChild("TextLabel")

											if price then
												price.Visible = v85[101]
											end

											if textLabel then
												textLabel.Text = flag20 and "Equipped" or "Equip"
											end
										end
									end

									if v109 == "Sword" and owns and v111 and v111.Virtual and shop and shop:FindFirstChild("Equips") then
										local data = unlockAll.Shop._selectedItem and unlockAll.Shop._selectedItem.data
										local finisher2 = shop.Equips:FindFirstChild("Finisher")
										local equipAccessory = shop.Equips:FindFirstChild("EquipAccessory")

										if finisher2 and data and data.HasFinisher then
											finisher2.Visible = true

											if finisher then
												finisher.Visible = v85[200]
											end

											finisher2.ImageColor3 = Color3.new(v85[18], v85[18], v85[18])
											finisher2.Label.Text = unlockAll.Finishers[v110] and "UNEQUIP" or "EQUIP"
										end

										if equipAccessory and data and data.AccessoryToggleable and unlockAll.Sword == v110 then
											equipAccessory.Visible = true

											if accessory then
												accessory.Visible = true
											end

											equipAccessory.Label.Text = unlockAll.Accessory and "UNEQUIP ACCESSORY" or "EQUIP ACCESSORY"
										end
									end

									if unlockAll.Shop._multiDelete then
										unlockAll.Shop:_updateMultiDeleteVisbility()
									end
								end

								unlockAll.SetAccessory = function(arg)
									unlockAll.Accessory = arg == true
									localPlayer:SetAttribute("ShowSwordAccessory", unlockAll.Accessory)

									if unlockAll.Accessory and unlockAll.Sword then
										unlockAll.ApplySword(unlockAll.Sword)
									elseif not unlockAll.Accessory then
										local v109 = unlockAll.GetCharacter()
										local swordAccessories = v109 and v109:FindFirstChild("SwordAccessories")

										if swordAccessories then
											swordAccessories:Destroy()
										end
									end

									unlockAll.Save()
									unlockAll.RefreshShop()

									for k in unlockAll.Clones, nil, nil do
										unlockAll.UpdateClone(k)
									end
								end

								unlockAll.SetFinisher = function(arg, arg2)
									if not arg then
										return
									end
									local tbl26 = { "Finishers", "Equipped", arg }

									if unlockAll.DefaultFinishers[arg] == nil and unlockAll.DataReplion then
										unlockAll.DefaultFinishers[arg] = unlockAll.DataReplion:Get(tbl26) == true
									end

									unlockAll.Finishers[arg] = arg2 and v85[200] or nil

									if unlockAll.DataReplion then
										unlockAll.DataReplion:_set(tbl26, arg2 == true)
									end

									unlockAll.Save()
									unlockAll.RefreshShop()
								end

								unlockAll.GetCardType = function(arg)
									local shop = v104:FindFirstChild("Shop")
									local pages = shop and shop:FindFirstChild("Holder") and shop.Holder:FindFirstChild("Pages")
									if pages and pages:FindFirstChild("Sword") and arg:IsDescendantOf(pages.Sword) then
										return "Sword"
									end

									if pages and pages:FindFirstChild("Explosion") and arg:IsDescendantOf(pages.Explosion) then
										return "Explosion"
									end
								end

								unlockAll.UpdateMultiDelete = function()
									local v109 = v85[33]

									for _, v110 in unlockAll.Types, nil, nil do
										for _, v111 in unlockAll.MultiDelete[v110], nil, nil do
											v109 += v111
										end
									end

									local multiDelete = unlockAll.Overlays.MultiDelete

									if multiDelete then
										multiDelete.Visible = unlockAll.Status == "active"
									end

									local shop = v104:FindFirstChild("Shop")
									local deleteItems = shop and shop:FindFirstChild("Holder") and shop.Holder:FindFirstChild("DeleteItems")
									deleteItems = deleteItems and deleteItems:FindFirstChild("Title")

									if deleteItems then
										deleteItems.Text = v109 > 0 and "Delete Items (" .. v109 .. ")" or "Delete Items"
									end
								end

								unlockAll.GetDeleteList = function()
									local shop = v104:FindFirstChild("Shop")
									shop = shop and shop:FindFirstChild("Holder")
									shop = shop and shop:FindFirstChild("DeleteItems")
									local contentsCanvas = shop and shop:FindFirstChild("List") and shop.List:FindFirstChild("ContentsCanvas")
									return contentsCanvas and contentsCanvas:FindFirstChild("ScrollingFrame")
								end

								unlockAll.SetDeleteCount = function(arg, arg2, arg3)
									local v109 = unlockAll.ShopItems[arg][arg2]
									local v110 = v109 and unlockAll.ShopState[v109]
									if not v110 then
										return
									end
									local n33 = math.clamp(arg3, 0, #v110.ItemsMatching)
									unlockAll.MultiDelete[arg][arg2] = n33 > v85[33] and n33 or nil
									unlockAll.SetShopState(v109, { InDeleteMulti = n33, ForceHide = n33 > 0 and n33 == #v110.ItemsMatching })
									local str5 = arg .. "\0" .. arg2
									local clone = unlockAll.MultiDeleteCards[str5]

									if n33 == 0 then
										if clone then
											clone:Destroy()
										end

										unlockAll.MultiDeleteCards[str5] = nil
									else
										local v111 = unlockAll.GetDeleteList()

										if v111 then
											if not clone or clone.Parent ~= v111 then
												local uiListLayout = v111:FindFirstChildWhichIsA("UIListLayout")
												uiListLayout = uiListLayout and uiListLayout:FindFirstChild("Template")
												local v112 = unlockAll.ItemInfo[arg][arg2]
												if not uiListLayout or not v112 then
													return
												end
												clone = uiListLayout:Clone()
												clone.Name = arg .. v85[188] .. arg2
												clone.Visible = true
												clone.Button.Label.Text = v112.DisplayName or v112.Name or arg2
												clone.Button.Item.Vector.Image = v112.Icon or ""
												local smallerSlotColors = unlockAll.TradeInfo.SmallerSlotColors
												local default = smallerSlotColors[v112.Rarity] or smallerSlotColors.Default
												clone.Button.Item.Image = default.Image
												clone.Button.Item.HoverImage = default.HoverImage
												clone.Parent = v111
												unlockAll.MultiDeleteCards[str5] = clone

												local function fn74()
													unlockAll.SetDeleteCount(arg, arg2, (unlockAll.MultiDelete[arg][arg2] or v85[33]) - 1)
												end

												clone.Button.Activated:Connect(fn74)
												clone.Button.Item.Activated:Connect(fn74)
											end

											clone.Button.Item.Label.Text = "x" .. n33
										end
									end

									unlockAll.UpdateMultiDelete()
								end

								unlockAll.ClearMultiDelete = function()
									for _, v109 in unlockAll.Types, nil, nil do
										for k in unlockAll.MultiDelete[v109], nil, nil do
											local v110 = unlockAll.ShopItems[v109][k]

											if v110 and not unlockAll.Deleted[v109][k] then
												unlockAll.SetShopState(v110, { InDeleteMulti = 0, ForceHide = false })
											end
										end
									end

									table.clear(unlockAll.MultiDelete.Sword)
									table.clear(unlockAll.MultiDelete.Explosion)

									for k, v109 in unlockAll.MultiDeleteCards, nil, nil do
										if v109 then
											v109:Destroy()
										end

										unlockAll.MultiDeleteCards[k] = nil
									end

									unlockAll.UpdateMultiDelete()

									if unlockAll.Status == "active" then
										unlockAll.RefreshShop()
									end
								end

								unlockAll.ToggleMultiItem = function(arg)
									if not unlockAll.Shop._multiDelete then
										return
									end
									local v109 = unlockAll.GetCardType(arg)
									local attribute = arg:GetAttribute("Name")
									local v110 = v109 and attribute and unlockAll.ShopItems[v109][attribute]
									if not (v110 and unlockAll.ShopState[v110]) or unlockAll.Deleted[v109][attribute] then
										return
									end
									unlockAll.SetDeleteCount(v109, attribute, (unlockAll.MultiDelete[v109][attribute] or 0) + 1)
								end

								unlockAll.HookMultiCard = function(arg)
									if unlockAll.Status ~= "active" or not arg:IsA("GuiButton") or not unlockAll.GetCardType(arg) or unlockAll.CardConnections[arg] then
										return
									end

									unlockAll.CardConnections[arg] = arg.Activated:Connect(function()
										unlockAll.ToggleMultiItem(arg)
									end)
								end

								unlockAll.CloseMultiDelete = function()
									unlockAll.Shop._multiDelete = nil
									unlockAll.Shop:_updateMultiDeleteVisbility()
									unlockAll.Shop:_updateMultiDelete()
									unlockAll.ClearMultiDelete()
								end

								unlockAll.ConfirmMultiDelete = function()
									if not unlockAll.Shop._multiDelete then
										return
									end
									local tbl26 = {}
									local v109 = v85[33]

									for _, v110 in unlockAll.Types, nil, nil do
										for k, v111 in unlockAll.MultiDelete[v110], nil, nil do
											v109 += v111
											table.insert(tbl26, { Type = v110, Name = k, Quantity = v111 })
										end
									end

									unlockAll.ConfirmDelete(tbl26, "x" .. v109 .. " items", unlockAll.CloseMultiDelete)
								end

								unlockAll.HookMultiDelete = function(arg)
									local pages = arg:FindFirstChild("Pages")
									local deleteItems = arg:FindFirstChild("DeleteItems")
									local buttons = deleteItems and deleteItems:FindFirstChild("List") and deleteItems.List:FindFirstChild("Buttons")
									local shop = unlockAll.Shop
									unlockAll.Originals.CanDelete = shop._canDelete

									shop._canDelete = function()
										return false
									end

									unlockAll.CloseMultiDelete()
									local updateMultiDelete = shop._updateMultiDelete

									shop._updateMultiDelete = function(arg2)
										if unlockAll.Status ~= "active" then
											return updateMultiDelete(arg2)
										end

										if not arg2._multiDelete then
											unlockAll.ClearMultiDelete()
											return
										end
										unlockAll.UpdateMultiDelete()
									end

									unlockAll.Originals.UpdateMultiDelete = updateMultiDelete
									unlockAll.MakeOverlay("MultiDelete", buttons and buttons:FindFirstChild("Delete"), unlockAll.ConfirmMultiDelete)

									if pages then
										for _, v109 in pages:GetDescendants() do
											unlockAll.HookMultiCard(v109)
										end

										unlockAll.Add(pages.DescendantAdded:Connect(function(descendant)
											task.defer(unlockAll.HookMultiCard, descendant)
										end))
									end

									unlockAll.UpdateMultiDelete()
								end

								unlockAll.HookShop = function()
									local shop = v104:FindFirstChild("Shop")
									shop = shop and shop:FindFirstChild("Holder")
									local infoBG = shop and shop:FindFirstChild("InfoBG")
									if not shop or not infoBG then
										return
									end

									for _, v109 in unlockAll.Types, nil, nil do
										local v110 = unlockAll.Shop._inventoryPages[v109]
										local markDirty = v110.MarkDirty

										local function fn74(arg)
											local v111 = unlockAll.ShopState[arg]
											if not v111 or not unlockAll.ShopChanges[arg] then
												return
											end

											for _, v112 in unlockAll.ShopFields, nil, nil do
												local v113 = v111[v112[1]]

												if unlockAll.GetShopState(arg, v112[2]) ~= v113 then
													unlockAll.ApplyShopState(arg, v112[v85[70]], v113)
												end
											end

											if unlockAll.ConsoleItems then
												unlockAll.SyncConsoleItem(arg)
											end
										end

										v110.MarkDirty = function(arg, arg2, arg3)
											if unlockAll.Status == "active" then
												if arg then
													fn74(arg)
												else
													for _, v111 in unlockAll.Shop._virtualItems[v109], nil, nil do
														fn74(v111)
													end
												end
											end

											return markDirty(arg, arg2, arg3)
										end

										unlockAll.Originals["MarkDirty" .. v109] = markDirty
									end

									unlockAll.Add(infoBG.BuyButton.Activated:Connect(function()
										local v109, v110 = unlockAll.GetSelected()

										if v109 == "Sword" then
											unlockAll.SelectSword(v110)
										elseif v109 == "Explosion" then
											unlockAll.SelectExplosion(v110)
										end

										task.defer(unlockAll.RefreshShop)
									end))

									unlockAll.MakeOverlay("Favorite", shop:FindFirstChild("Favorite"), function()
										local v109, v110 = unlockAll.GetSelected()

										if v109 and v110 then
											unlockAll.ToggleFavorite(v109, v110)
											unlockAll.RefreshShop()
										end
									end)

									unlockAll.MakeOverlay("Delete", infoBG:FindFirstChild("Delete"), function()
										if n27(1143) < 5866 then
											local v109, v110, v111 = unlockAll.GetSelected()

											if v109 and v110 and v111 and unlockAll.ShopState[v111] then
												unlockAll.PromptDelete(v109, v110)
											end

											return
										end

										while true do
										end
									end)

									local secretUpgrade = v104:FindFirstChild("SecretUpgrade")

									if secretUpgrade then
										unlockAll.MakeOverlay("AwakenOpen", infoBG:FindFirstChild("SecretUpgrade"), function()
											local v109, v110 = unlockAll.GetSelected()

											if v109 == "Sword" then
												unlockAll.OpenAwaken(v110)
											end
										end)

										unlockAll.MakeOverlay("Awaken", secretUpgrade.Main.Upgrade, function()
											unlockAll.AwakenSword(unlockAll.AwakenName)
										end)

										unlockAll.Overlays.AwakenOpen.Visible = v85[200]
										unlockAll.Overlays.Awaken.Visible = true
									end

									local equips = infoBG:FindFirstChild("Equips")

									unlockAll.MakeOverlay("Accessory", equips and equips:FindFirstChild("EquipAccessory"), function()
										if n27(2212) < 7940 then
											local v109, v110 = unlockAll.GetSelected()

											if v109 == "Sword" and unlockAll.Sword == v110 then
												unlockAll.SetAccessory(not unlockAll.Accessory)
											end

											return
										end

										while true do
										end
									end)

									unlockAll.MakeOverlay("Finisher", equips and equips:FindFirstChild("Finisher"), function()
										local v109, v110 = unlockAll.GetSelected()

										if v109 == "Sword" then
											unlockAll.SetFinisher(v110, not unlockAll.Finishers[v110])
										end
									end)

									if unlockAll.Shop.itemSelected and unlockAll.Shop.itemSelected.Connect then
										unlockAll.Add(unlockAll.Shop.itemSelected:Connect(function()
											task.defer(unlockAll.RefreshShop)
										end))
									end

									unlockAll.HookMultiDelete(shop)
								end

								unlockAll.SyncConsoleItem = function(arg)
									local v109 = unlockAll.ConsoleItems[arg.Type][arg.Name]
									if not v109 or unlockAll.ShopItems[arg.Type][arg.Name] ~= arg then
										return
									end
									local v110 = unlockAll.ShopState[arg]
									local n33 = v110.ForceHide and 0 or #v110.ItemsMatching
									v109.Data.OwnedCopies:Set(n33)
									unlockAll.ShopAPI:GetItemBaseOwnedState(arg.Type, arg.Name):SetTag("UnlockAll", n33 > v85[33])
									unlockAll.Console:UpdateItem(v109.Data)
								end

								unlockAll.BindConsole = function(arg, arg2)
									for _, v109 in getconnections(arg.Activated) do
										if v109.Enabled then
											v109:Disable()
											table.insert(unlockAll.ConsoleConnections, v109)
										end
									end

									unlockAll.Add(arg.Activated:Connect(arg2))
								end

								unlockAll.HookConsole = function()
									local shopAPI = unlockAll.ShopAPI
									local activeVariant = shopAPI.ActiveVariant
									if not activeVariant then
										return
									end
									unlockAll.Console = activeVariant
									unlockAll.ConsoleItems = { Sword = {}, Explosion = {} }
									unlockAll.ConsoleConnections = {}
									local main = v104.ControllerShop.Main

									for k, v109 in {
										SetEquipped = function(arg, arg2, arg3)
											if not unlockAll.ShopItems[arg2] then
												return unlockAll.Originals.APISetEquipped(arg, arg2, arg3)
											end
											local item = unlockAll.InventoryClient:GetItem(arg2, arg3)
											item = item and item.Name or arg3
											if not unlockAll.ShopItems[arg2][item] or unlockAll.Deleted[arg2][item] then
												return v85[101]
											end

											if arg2 == "Sword" then
												unlockAll.SelectSword(item)
											else
												unlockAll.SelectExplosion(item)
											end

											return v85[200]
										end,
										ToggleFavorited = function(arg, arg2)
											local itemType = arg2.ItemInfo.ItemType
											local name = arg2.ItemInfo.Name
											if not unlockAll.ShopItems[itemType] then
												return unlockAll.Originals.APIToggleFavorited(arg, arg2)
											end
											unlockAll.ToggleFavorite(itemType, name)
											return true
										end,
										ToggleSwordAccessory = function()
											unlockAll.SetAccessory(not unlockAll.Accessory)
										end,
										RequestFinisherEquip = function(arg, arg2)
											unlockAll.SetFinisher(arg2.Name, not unlockAll.Finishers[arg2.Name])
											return v85[200]
										end,
										ToggleSwordStyle = function()
											local v109 = unlockAll.ItemInfo.Sword[unlockAll.Sword]

											if v109 then
												v109 = v109.AnimationStyles[unlockAll.Accessory and "Accessory" or "Base"]
											end

											if v109 and #v109 > v85[33] then
												localPlayer:SetAttribute("AnimationStyle", v109[(table.find(v109, localPlayer:GetAttribute("AnimationStyle")) or v85[33]) % #v109 + 1])
											end
										end,
									}, nil, nil do
										unlockAll.Originals["API" .. k] = shopAPI[k]
										shopAPI[k] = v109
									end

									local buttons = main.DeleteItems.List.Buttons
									local v109 = nil

									for _, v110 in getconnections(buttons.Cancel.Activated) do
										local function_ = v110.Enabled and v110.Function

										if function_ then
											local console = v93.Controllers.UI.ShopControllerAPI.Variants.Console
											function_ = getfenv(v110.Function).script == console
										end

										if function_ then
											v109 = v110
											break
										end
									end

									unlockAll.ConsoleCancel = v109

									unlockAll.BindConsole(buttons.Delete, function()
										local tbl26 = {}
										local v110 = v85[33]

										for k, v111 in debug.getupvalue(activeVariant.GetDeletingItemState, 1) do
											local v112 = v111:Get()
											local itemType = k.ItemInfo.ItemType
											local name = k.ItemInfo.Name

											if v112 > 0 and unlockAll.ShopItems[itemType] then
												v110 += v112
												table.insert(tbl26, { Type = itemType, Name = name, Quantity = v112 })
											end
										end

										unlockAll.ConfirmDelete(tbl26, "x" .. v110 .. " items", function()
											if v109 then
												v109:Fire()
											end
										end)
									end)

									unlockAll.BindConsole(main.Pages.Sword.Right.UpgradeButton, function()
										local v110, v111 = unlockAll.GetSelected()

										if v110 == "Sword" then
											unlockAll.OpenAwaken(v111)
										end
									end)

									unlockAll.BindConsole(v104.SecretUpgrade.Main.Upgrade, function()
										unlockAll.AwakenSword(unlockAll.AwakenName)
									end)

									local run = unlockAll.Run
									local n33 = os.clock() + 0.004

									for _, v110 in unlockAll.Types, nil, nil do
										for k, v111 in unlockAll.ShopItems[v110], nil, nil do
											local v112 = table.clone(v111.Item)

											if unlockAll.ShopState[v111].Virtual and v110 == "Sword" then
												local v113 = unlockAll.ItemInfo.Sword[k]
												v112.Finisher = v113.HasFinisher or nil
												v112.Accessory = v113.AccessoryUnlockable or nil
											end

											local itemData = shopAPI:GetItemData(v110, shopAPI:ParseItemKey(v110, v112))
											v112.Id = "UnlockAll:" .. v110 .. ":" .. k
											unlockAll.ConsoleItems[v110][k] = { Data = itemData, Item = v112, Favorite = itemData.IsFavorited:Get() }
											itemData.IsFavorited:Set(unlockAll.Favorites[v110][k] == true)
											unlockAll.SyncConsoleItem(v111)

											if os.clock() >= n33 then
												v88.Heartbeat:Wait()
												if unlockAll.Run ~= run or unlockAll.Status ~= "active" then
													return
												end
												n33 = os.clock() + 0.004
											end
										end

										unlockAll.Add(unlockAll.InventoryClient:OnInventoryChange(v110, function()
											task.defer(function()
												if unlockAll.Run ~= run or unlockAll.Status ~= "active" then
													return
												end

												for _, v111 in unlockAll.ShopItems[v110], nil, nil do
													unlockAll.SyncConsoleItem(v111)
												end
											end)
										end))

										local v111 = unlockAll[v110]

										if v111 then
											unlockAll.SetEquipped(v110, v111)
										end
									end
								end

								unlockAll.RestoreConsole = function()
									local console = unlockAll.Console
									if not console then
										return
									end

									if unlockAll.ConsoleCancel then
										unlockAll.ConsoleCancel:Fire()
									end

									for _, v109 in {
										"SetEquipped",
										"ToggleFavorited",
										"ToggleSwordAccessory",
										"RequestFinisherEquip",
										"ToggleSwordStyle",
									}, nil, nil do
										fn73("API" .. v109, unlockAll.ShopAPI, v109)
									end

									for _, v109 in unlockAll.ConsoleConnections, nil, nil do
										v109:Enable()
									end

									for k, v109 in unlockAll.ConsoleItems, nil, nil do
										for k2, v110 in v109, nil, nil do
											v110.Data.OwnedCopies:Set(#unlockAll.InventoryClient:FindItemsWithKey(k, v110.Data.ParsedItemKey))
											v110.Data.IsFavorited:Set(v110.Favorite)
											unlockAll.ShopAPI:GetItemBaseOwnedState(k, k2):SetTag("UnlockAll", nil)
											console:UpdateItem(v110.Data)
										end
									end

									unlockAll.Console = nil
									unlockAll.ConsoleItems = nil
									unlockAll.ConsoleConnections = nil
									unlockAll.ConsoleCancel = nil
								end

								unlockAll.OpenAwaken = function(awakenName)
									local v109 = unlockAll.AwakenData[awakenName]
									if not v109 then
										return
									end
									unlockAll.AwakenName = awakenName
									local secretUpgrade = v104.SecretUpgrade
									secretUpgrade:SetAttribute("ToAwaken", nil)
									local main = secretUpgrade.Main
									main.template1.vector.Image = v109.Regular.Icon
									main.template2.vector.Image = v109.Awakened.Icon
									main.template2.customs.c3.Visible = v109.CustomSlash == true
									main.Progress.Fill.Size = UDim2.fromScale(1, 1)
									local requirement = unlockAll.AwakenData.Requirement
									main.Progress.Progress.Text = requirement .. "/" .. requirement
									require(v93.ClientGameModules.GuiHandler):Open("SecretUpgrade")
								end

								unlockAll.DestroyOverlays = function()
									for _, v109 in unlockAll.Overlays, nil, nil do
										if v109 and v109.Parent then
											v109:Destroy()
										end
									end

									table.clear(unlockAll.Overlays)
								end

								unlockAll.ConfirmDelete = function(arg, arg2, arg3)
									local run = unlockAll.Run

									unlockAll.DeletePrompt:PromptConfirmation({
										PromptType = "Single",
										Description = "Are you sure you want to delete " .. arg2 .. "? This cannot be undone.",
									}, function(arg4)
										if not arg4 or unlockAll.Status ~= "active" or unlockAll.Run ~= run then
											return
										end

										for _, v109 in arg, nil, nil do
											unlockAll.DeleteItem(v109.Type, v109.Name, v109.Quantity)
										end

										if arg3 then
											arg3()
										end
									end)
								end

								unlockAll.PromptDelete = function(arg, arg2)
									if not unlockAll.DeletePrompt then
										return unlockAll.DeleteItem(arg, arg2)
									end
									local v109 = unlockAll.ItemInfo[arg] and unlockAll.ItemInfo[arg][arg2]
									unlockAll.ConfirmDelete({ { Type = arg, Name = arg2 } }, "x1 " .. tostring(v109 and (v109.DisplayName or v109.Name) or arg2))
								end

								unlockAll.AwakenSword = function(arg)
									local v109 = arg and unlockAll.AwakenData[arg]
									local v110 = arg and unlockAll.ShopItems.Sword[arg]
									local v111 = v109 and unlockAll.ShopItems.Sword[v109.Awakened.Value]
									local v112 = v110 and unlockAll.ShopState[v110]
									if unlockAll.Status ~= "active" or not v111 or not v112 or #v112.ItemsMatching == v85[33] then
										return
									end
									unlockAll.AwakenName = nil
									local v113 = table.clone(v112.ItemsMatching)
									table.remove(v113)

									unlockAll.SetShopState(v110, {
										ItemsMatching = v113,
										Owns = #v113 > 0,
										Section = #v113 > 0 and "Owned" or "Unowned",
										ForceHide = #v113 == 0,
									})

									local unlockAll2 = v109.Awakened.Value
									local v114 = table.clone(unlockAll.ShopState[v111].ItemsMatching)
									table.insert(v114, "UnlockAll:" .. unlockAll2)
									unlockAll.Deleted.Sword[unlockAll2] = nil
									unlockAll.SetShopState(v111, { ItemsMatching = v114, Owns = true, Section = "Owned", ForceHide = false })

									if unlockAll.Sword == arg then
										unlockAll.SelectSword(unlockAll2, false)
									end

									if unlockAll.Console then
										unlockAll.Console.PageInfo.Sword.ItemState:Set(unlockAll.ConsoleItems.Sword[unlockAll2].Data)
									else
										unlockAll.Shop:Select({ type = "Sword", name = unlockAll2, data = unlockAll.GetSwordData(unlockAll2) })
									end

									require(v93.ClientGameModules.GuiHandler):Open(unlockAll.Console and "ControllerShop" or "Shop")
									unlockAll.RefreshShop()
								end

								unlockAll.DeleteItem = function(arg, arg2, arg3)
									if unlockAll.Status ~= "active" then
										return
									end

									if arg == "Emote" then
										local v109 = unlockAll.EmoteItems[arg2]
										if not v109 then
											return
										end
										unlockAll.Deleted.Emote[arg2] = v85[200]
										unlockAll.SetFavorite("Emote", arg2, false, false)
										local emote = unlockAll.EmoteCaller and unlockAll.EmoteCaller.Replion.Data.Inventory.Emote

										if emote and emote[v109.Id] then
											emote[v109.Id] = nil

											if unlockAll.EmoteView then
												unlockAll.EmoteView.TriggerUpdate(v109, "Remove")
											end
										end

										for k, v110 in unlockAll.EquippedEmotes, nil, nil do
											if v110 == arg2 then
												unlockAll.EquippedEmotes[k] = nil
											end
										end

										unlockAll.UpdateEmoteWheel()
										unlockAll.Save()
										return
									end

									local v109 = unlockAll.ShopItems[arg] and unlockAll.ShopItems[arg][arg2]
									local v110 = v109 and unlockAll.ShopState[v109]
									if not v110 then
										return
									end
									local v111 = table.clone(v110.ItemsMatching)
									local v112 = v85[18]
									local min = math.min
									local n33 = arg3 or 1

									for i = v112, min(n33, #v111) do
										table.remove(v111)
									end

									unlockAll.SetShopState(v109, { ItemsMatching = v111, InDeleteMulti = 0 })

									if #v111 > 0 then
										unlockAll.SetShopState(v109, { ForceHide = false })
										unlockAll.RefreshShop()
										return
									end

									unlockAll.Deleted[arg][arg2] = true
									unlockAll.SetFavorite(arg, arg2, false, false)
									unlockAll.SetShopState(v109, { Owns = false, Section = "Unowned", ForceHide = false })

									if arg == "Sword" and unlockAll.Sword == arg2 then
										unlockAll.RestoreSword(v85[200])
									elseif arg == "Explosion" and unlockAll.Explosion == arg2 then
										unlockAll.RestoreExplosion(true)
									else
										unlockAll.Save()
									end

									unlockAll.RefreshShop()
								end

								unlockAll.PatchSwords = function()
									if unlockAll.SwordsPatched then
										return
									end
									local value = rawget(unlockAll.Swords, "EquipSwordTo")
									local v109 = value and getupvalues and getupvalues(value)
									if not v109 or not setupvalue then
										return
									end
									local v110 = nil

									for k, v111 in v109, nil, nil do
										if typeof(v111) == "Instance" and v111.ClassName == "Players" then
											v110 = k
										elseif type(v111) == "table" and type(rawget(v111, "cancel")) == "function" and type(rawget(v111, "begin")) == "function" then
											unlockAll.SwordState = v111
										end
									end

									if not v110 and v109[v85[61]] == false and v109[4] == true then
										setupvalue(value, 3, v89)
										v110 = v85[61]
									end

									if v110 and type(v109[v110 + 1]) == "boolean" then
										setupvalue(value, v110 + 1, false)
									end

									unlockAll.SwordsPatched = v110 ~= nil
								end

								unlockAll.GetSwordData = function(arg)
									local v109 = unlockAll.SwordData[arg]
									if v109 then
										return v109
									end
									local swords = unlockAll.Swords
									swords = swords and swords:GetSword(arg)

									if not swords then
										swords = v93.Shared.ReplicatedInstances:FindFirstChild("Swords")
										swords = swords and swords:FindFirstChild("GetSword")
										swords = swords and swords:Invoke(arg)
									end

									if swords then
										unlockAll.SwordData[arg] = swords
									end

									return swords
								end

								unlockAll.GetSlash = function(arg)
									local v109 = unlockAll.GetSwordData(arg)
									if not v109 then
										return
									end
									local slashName = v109.SlashName or "SlashEffect"
									unlockAll.SwordFX:GetInstance(slashName)
									return slashName
								end

								unlockAll.RemoveSwords = function(arg, arg2)
									if not arg then
										return
									end

									for _, v109 in arg:GetChildren() do
										if v109:IsA("Model") and v109.Name ~= arg2 and unlockAll.GetSwordData(v109.Name) then
											v109:Destroy()
										end
									end
								end

								unlockAll.GetBlade = function()
									if unlockAll.BladeController then
										return unlockAll.BladeController
									end

									if not getconnections or not getupvalues then
										return
									end
									local fireSwordInfo = v93:FindFirstChild("Remotes") and v93.Remotes:FindFirstChild("FireSwordInfo")
									if not fireSwordInfo then
										return
									end

									for _, v109 in getconnections(fireSwordInfo.OnClientEvent) do
										local function_ = v109.Function and getupvalues(v109.Function)

										if type(function_) == "table" then
											for _, v110 in function_, nil, nil do
												if type(v110) == "table" and type(v110.SetSword) == "function" then
													unlockAll.BladeController = v110
													return v110
												end
											end
										end
									end
								end

								unlockAll.PatchBlade = function(arg)
									if not arg or unlockAll.Originals.SetSword then
										return
									end
									unlockAll.Originals.SetSword = arg.SetSword

									arg.SetSword = function(arg2, arg3)
										if unlockAll.Status == "active" and unlockAll.Sword then
											arg3 = unlockAll.Sword
										end

										return unlockAll.Originals.SetSword(arg2, arg3)
									end
								end

								unlockAll.ApplySword = function(arg)
									local v109 = unlockAll.GetCharacter()
									if not v109 or not arg then
										return
									end
									local humanoid = v109:FindFirstChildOfClass("Humanoid") or v109:WaitForChild("Humanoid", 2)
									if not humanoid or humanoid.Health <= 0 or not v109:FindFirstChild("HumanoidRootPart") then
										return
									end

									if unlockAll.Sword and not unlockAll.SavedEquipped.Sword then
										unlockAll.Originals.EquippedSword = unlockAll.GetRealEquipped("Sword")
										unlockAll.SavedEquipped.Sword = true
									end

									unlockAll.PatchSwords()
									local swordState = unlockAll.SwordState

									if swordState then
										swordState.cancel(v109)
									end

									if unlockAll.Swords:EquipSwordTo(v109, arg) == false then
										return
									end
									unlockAll.Slash = unlockAll.GetSlash(arg) or unlockAll.Slash

									if not unlockAll.Accessory then
										local swordAccessories = v109:FindFirstChild("SwordAccessories")

										if swordAccessories then
											swordAccessories:Destroy()
										end
									end

									local v110 = unlockAll.GetBlade()

									if v110 then
										unlockAll.PatchBlade(v110)
										v110:SetSword(arg)
									end

									if not unlockAll.Accessory then
										task.defer(function()
											local swordAccessories = v109:FindFirstChild("SwordAccessories")

											if swordAccessories then
												swordAccessories:Destroy()
											end
										end)
									end

									task.defer(unlockAll.RemoveSwords, v109, arg)
								end

								unlockAll.SetEquipped = function(arg, arg2)
									if not unlockAll.SavedEquipped[arg] then
										unlockAll.Originals["Equipped" .. arg] = unlockAll.GetRealEquipped(arg)
										unlockAll.SavedEquipped[arg] = true
									end

									local consoleItems = unlockAll.ConsoleItems and unlockAll.ConsoleItems[arg][arg2]
									unlockAll.InventoryReplion:_set({ "Equipped", arg }, consoleItems and consoleItems.Item or unlockAll.GetOwnedItem(arg, arg2) or { Name = arg2, Id = "UnlockAll:" .. arg .. ":" .. arg2 })

									if unlockAll.Shop and unlockAll.Shop._selectedItem then
										unlockAll.Shop:Select(unlockAll.Shop._selectedItem, true)
									end
								end

								unlockAll.WatchSword = function(arg)
									if not arg then
										return
									end

									unlockAll.Add(arg.DescendantAdded:Connect(function(descendant)
										local sword = unlockAll.Sword
										if unlockAll.Status ~= "active" or not sword then
											return
										end
										local model = descendant:FindFirstAncestorOfClass("Model")

										while model and model.Parent ~= arg do
											model = model:FindFirstAncestorOfClass("Model")
										end

										if not model or not model:GetAttribute("_equippedSword") or model.Name == sword then
											return
										end

										if descendant:IsA("BasePart") or descendant:IsA("Decal") then
											descendant.Transparency = 1
										elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
											descendant.Enabled = false
											descendant:Clear()
										elseif descendant:IsA("Beam") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") or descendant:IsA("Light") then
											descendant.Enabled = false
										end
									end))

									unlockAll.Add(arg:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
										local sword = unlockAll.Sword

										if unlockAll.Status == "active" and sword and arg:GetAttribute("CurrentlyEquippedSword") ~= sword then
											task.defer(unlockAll.ApplySword, sword)
										end
									end))

									local humanoid = arg:FindFirstChildOfClass("Humanoid") or arg:WaitForChild("Humanoid", 2)

									if humanoid then
										unlockAll.Add(humanoid.HealthChanged:Connect(function(health)
											local sword = unlockAll.Sword

											if unlockAll.Status == "active" and health > 0 and sword then
												task.defer(unlockAll.ApplySword, sword)
											end
										end))
									end
								end

								unlockAll.ClearCloneTracks = function(arg)
									if not (n25 > 6642) then
										arg.Data = nil

										for k, v109 in arg.OriginalTracks, nil, nil do
											if arg.Animator and arg.Animator.Parent then
												k:Play(0, v109.Weight, v109.Speed)
											end
										end

										table.clear(arg.OriginalTracks)

										for _, v109 in arg.Tracks, nil, nil do
											v109:Stop(0)
											v109:Destroy()
										end

										table.clear(arg.Tracks)
										return
									end

									while true do
									end
								end

								unlockAll.PlayCloneTrack = function(arg, arg2)
									local v109 = unlockAll.Clones[arg]
									if not v109 or not v109.Data or not arg2.IsPlaying then
										return
									end

									for _, v110 in v109.Tracks, nil, nil do
										if arg2 == v110 then
											return
										end
									end

									local animation = arg2.Animation and unlockAll.CloneAnimationTypes[arg2.Animation.AnimationId]
									if not animation then
										return
									end
									local v110 = tbl25.Animation.SwordAPI:GetAnimations(arg, animation, v109.Data.AnimationType, v109.Data.SwordType)[1]
									if not v110 or v110.AnimationId == arg2.Animation.AnimationId then
										return
									end
									local v111 = v109.Tracks[v110]

									if not v111 then
										v111 = v109.Animator:LoadAnimation(v110)
										v109.Tracks[v110] = v111
									end

									local weightTarget = arg2.WeightTarget

									if arg2.Looped then
										v109.OriginalTracks[arg2] = { Weight = weightTarget, Speed = arg2.Speed }
									end

									v111.Priority = arg2.Priority
									v111.Looped = arg2.Looped
									v111:Play(0, weightTarget, arg2.Speed)

									if v111.Length > 0 then
										v111.TimePosition = math.min(arg2.TimePosition, v111.Length)
									end

									arg2:Stop(0)
								end

								unlockAll.UpdateClone = function(arg)
									local v109 = unlockAll.Clones[arg]
									if not v109 or v109.Thread or unlockAll.Status ~= "active" or not unlockAll.Sword then
										return
									end
									local humanoid = arg:FindFirstChildOfClass("Humanoid")
									local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
									if not animator or not arg:FindFirstChild("Torso") or not arg:FindFirstChild("Left Arm") or not arg:FindFirstChild("Right Arm") then
										return
									end

									if v109.Model and v109.Model.Parent == arg and v109.Name == unlockAll.Sword and v109.Accessory == unlockAll.Accessory then
										for _, v110 in arg:GetChildren() do
											if v110 ~= v109.Model and v110:GetAttribute("_equippedSword") then
												v110:Destroy()
											end
										end

										return
									end

									v109.Thread = task.defer(function()
										local sword = unlockAll.Sword
										local accessory = unlockAll.Accessory
										unlockAll.ClearCloneTracks(v109)
										local v110 = unlockAll.GetSwordData(sword)
										local ok, model = pcall(unlockAll.Swords.ForceEquipSwordTo, unlockAll.Swords, arg, sword, nil, accessory)
										if unlockAll.Clones[arg] ~= v109 then
											return
										end

										if not ok or not model or not v110 then
											v109.Thread = nil
											return
										end
										local v111 = v109
										local v112 = v109
										v109.Model = model
										v111.Name = sword
										v112.Accessory = accessory
										local v113 = v109
										local v114 = animator
										v109.Data = v110
										v113.Animator = v114

										if not v109.Connections.Animation then
											v109.Connections.Animation = animator.AnimationPlayed:Connect(function(arg2)
												unlockAll.PlayCloneTrack(arg, arg2)
											end)
										end

										for _, v115 in animator:GetPlayingAnimationTracks() do
											unlockAll.PlayCloneTrack(arg, v115)
										end

										v109.Thread = nil
										unlockAll.UpdateClone(arg)
									end)
								end

								unlockAll.ClearClone = function(arg, arg2)
									local v109 = unlockAll.Clones[arg]
									if not v109 then
										return
									end
									unlockAll.Clones[arg] = nil
									fn29(v109.Connections)
									fn29(v109.Thread)
									unlockAll.ClearCloneTracks(v109)

									if arg2 and v109.Model and arg.Parent then
										local attribute = arg:GetAttribute("EquippedSword") or v109.OriginalSword

										if attribute then
											task.defer(function()
												if arg.Parent and not unlockAll.Clones[arg] then
													unlockAll.Swords:ForceEquipSwordTo(arg, attribute, nil, v109.OriginalAccessory)
												end
											end)
										end
									end
								end

								unlockAll.WatchClone = function(arg)
									local flag19 = unlockAll.Status ~= "active"
									local flag20

									if flag19 then
										flag20 = flag19
									else
										local name = localPlayer.Name
										flag20 = arg:GetAttribute("EncryptedCloneOwner") ~= name
									end

									if flag20 or unlockAll.Clones[arg] then
										return
									end

									if not unlockAll.CloneAnimationTypes then
										local cloneAnimationTypes = {}

										for _, v109 in v93.Shared.SwordAPI.Collection:GetDescendants() do
											if v109:IsA("Animation") then
												for _, v110 in { "Idle", "Parry", "GrabParry", "SuccessParry" }, nil, nil do
													if v109:GetAttribute(v110) then
														local v111 = cloneAnimationTypes[v109.AnimationId]
														local animationId = v109.AnimationId
														local flag21 = v111 == nil and v110
														local flag22

														if flag21 then
															flag22 = flag21
														else
															flag22 = v111 == v110 and v110
														end

														flag22 = flag22 or false
														cloneAnimationTypes[animationId] = flag22
														break
													end
												end
											end
										end

										unlockAll.CloneAnimationTypes = cloneAnimationTypes
									end

									local tbl26 = {
										Connections = {},
										Tracks = {},
										OriginalTracks = {},
										OriginalSword = arg:GetAttribute("EquippedSword"),
										OriginalAccessory = arg:GetAttribute("HasAccessoryEquipped") == true,
									}

									unlockAll.Clones[arg] = tbl26

									tbl26.Connections.Loaded = arg.DescendantAdded:Connect(function(descendant)
										local isAnimator = descendant:IsA("Animator")
										local attribute

										if isAnimator then
											attribute = isAnimator
										else
											local flag21 = descendant.Parent == arg

											if flag21 then
												attribute = not tbl26.Model or descendant:GetAttribute("_equippedSword")
											else
												attribute = flag21
											end
										end

										if attribute then
											task.defer(unlockAll.UpdateClone, arg)
										end
									end)

									unlockAll.UpdateClone(arg)
								end

								unlockAll.WatchEmotes = function(arg)
									local humanoid

									if arg then
										humanoid = arg:FindFirstChildOfClass("Humanoid") or arg:WaitForChild("Humanoid", 2)
									else
										humanoid = arg
									end

									if not humanoid then
										return
									end

									unlockAll.Add(humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
										if humanoid.MoveDirection ~= Vector3.zero and unlockAll.EmoteTrove then
											unlockAll.StopEmote()
										end
									end))
								end

								unlockAll.SelectSword = function(sword, arg)
									if not sword or unlockAll.Deleted.Sword[sword] then
										return
									end
									unlockAll.Sword = sword
									unlockAll.Slash = unlockAll.GetSlash(sword)
									tbl25.Animation.PreloadSword(sword)
									unlockAll.SetEquipped("Sword", sword)
									unlockAll.PatchParrySuccess()

									for _, v109 in game:GetService("CollectionService"):GetTagged("EncryptedClone") do
										unlockAll.WatchClone(v109)
										unlockAll.UpdateClone(v109)
									end

									task.defer(function()
										if unlockAll.Status == "active" and unlockAll.Sword == sword then
											unlockAll.ApplySword(sword)
										end
									end)

									if arg ~= false then
										unlockAll.Save()
									end
								end

								unlockAll.RestoreSword = function(arg)
									local sword = unlockAll.Defaults.Sword or "Base Sword"
									unlockAll.Sword = nil
									unlockAll.Slash = nil

									if unlockAll.SavedEquipped.Sword then
										unlockAll.InventoryReplion:_set({ "Equipped", "Sword" }, unlockAll.Originals.EquippedSword)
										unlockAll.Originals.EquippedSword = nil
										unlockAll.SavedEquipped.Sword = nil
									end

									unlockAll.ApplySword(sword)

									if arg then
										unlockAll.Save()
									end

									for k in unlockAll.Clones, nil, nil do
										fn30(unlockAll.ClearClone, k, true)
									end
								end

								unlockAll.SelectExplosion = function(explosion, arg)
									if not explosion or unlockAll.Deleted.Explosion[explosion] then
										return
									end
									unlockAll.Explosion = explosion
									unlockAll.SetEquipped("Explosion", explosion)
									localPlayer:SetAttribute("CurrentlyEquippedExplosion", explosion)
									local v109 = unlockAll.GetCharacter()

									if v109 then
										v109:SetAttribute("CurrentlyEquippedExplosion", explosion)
									end

									if arg ~= v85[101] then
										unlockAll.Save()
									end
								end

								unlockAll.RestoreExplosion = function(arg)
									local explosion = unlockAll.Defaults.Explosion or "Explosion Normal"
									unlockAll.Explosion = nil

									if unlockAll.SavedEquipped.Explosion then
										unlockAll.InventoryReplion:_set({ "Equipped", "Explosion" }, unlockAll.Originals.EquippedExplosion)
										unlockAll.Originals.EquippedExplosion = nil
										unlockAll.SavedEquipped.Explosion = nil
									end

									localPlayer:SetAttribute("CurrentlyEquippedExplosion", explosion)
									local v109 = unlockAll.GetCharacter()

									if v109 then
										v109:SetAttribute("CurrentlyEquippedExplosion", explosion)
									end

									if arg then
										unlockAll.Save()
									end
								end

								unlockAll.PatchExplosion = function()
									if not unlockAll.VFX or unlockAll.Originals.PlayExplosion then
										return
									end
									unlockAll.Originals.PlayExplosion = unlockAll.VFX.PlayExplosion

									unlockAll.VFX.PlayExplosion = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
										if unlockAll.Status == "active" and unlockAll.Explosion and arg7 and arg6 == localPlayer.Character then
											arg2 = unlockAll.Explosion
										end

										if unlockAll.Status == "active" and arg7 and arg6 == localPlayer.Character and unlockAll.Sword and unlockAll.Finishers[unlockAll.Sword] and unlockAll.FinishersController then
											local humanoidRootPart = arg5 and arg5:FindFirstChild("HumanoidRootPart")
											local alive2 = workspace:FindFirstChild("Alive")
											local children = alive2 and alive2:GetChildren() or {}
											local n33 = 0

											for _, v109 in children, nil, nil do
												if v109 ~= arg5 then
													n33 += 1
												end
											end

											if humanoidRootPart and alive2 and n33 <= 1 then
												unlockAll.FinishersController:PlayFinisher(unlockAll.Sword, arg6, arg5, humanoidRootPart.CFrame, workspace:GetServerTimeNow())
											end
										end

										return unlockAll.Originals.PlayExplosion(arg, arg2, arg3, arg4, arg5, arg6, arg7)
									end
								end

								unlockAll.PatchParrySuccess = function()
									if not hookfunction or not getconnections or not getinfo then
										return
									end
									local remotes = v93:FindFirstChild("Remotes")
									local flyteSwordEffects = genv.FlyteSwordEffects or {}
									genv.FlyteSwordEffects = flyteSwordEffects

									local function fn74(arg, arg2)
										if unlockAll.Originals[arg] or not arg2 then
											return false
										end

										for _, v109 in getconnections(arg2) do
											if v109.Function and (getinfo(v109.Function).name == "parrySuccessAll" or flyteSwordEffects[arg] == v109.Function) then
												flyteSwordEffects[arg] = v109.Function
												unlockAll.Originals[arg .. "Target"] = v109.Function
												unlockAll.Originals[arg] = hookfunction(v109.Function, function(...)local F={...};if  unlockAll .Status=="active"and  unlockAll .Sword and(tostring(F[4])== localPlayer .Name or type(F[4])=="table"and  unlockAll .Clones[F[4].Character])then local P= unlockAll .Slash;if P then F[1]=P;F[3]= unlockAll .Sword;end;end;return  unlockAll .Originals[ arg ](unpack(F));end)
												return true
											end
										end

										return false
									end

									local parrySuccessAll = remotes and remotes:FindFirstChild("ParrySuccessAll")
									fn74("Parry_All_Func", parrySuccessAll and parrySuccessAll.OnClientEvent)
									remotes = remotes and remotes:FindFirstChild("ParrySuccessClient")

									if remotes then
										remotes = remotes:IsA("BindableEvent") and remotes.Event or remotes.OnClientEvent
									end

									fn74("Parry_Client_Func", remotes)
								end

								unlockAll.StopEmote = function()
									if unlockAll.EmoteTrove then
										unlockAll.EmoteTrove:Destroy()
										unlockAll.EmoteTrove = nil
									end

									local character = localPlayer.Character

									if character then
										character:SetAttribute("Emoting", nil)
									end
								end

								unlockAll.PlayEmote = function(arg)
									local v109 = unlockAll.EmotesFolder:FindFirstChild(arg)
									local v110 = unlockAll.GetCharacter()
									local humanoid = v110 and v110:FindFirstChildOfClass("Humanoid")
									if not v109 or not v110 or not humanoid or humanoid.MoveDirection.Magnitude > 0 then
										return
									end
									unlockAll.StopEmote()
									unlockAll.EmoteTrove = unlockAll.Trove.new()
									v110:SetAttribute("Emoting", v109:GetAttribute("EmoteName") or v109.Name)
									local v111 = v85[18]
									unlockAll.EmotesShared:Play(v110, unlockAll.EmoteTrove, v109.Name, true, workspace:GetServerTimeNow(), v111, nil, false)
								end

								unlockAll.PatchEmotes = function()
									if unlockAll.Originals.EmotePlay then
										return
									end
									unlockAll.Originals.EmotePlay = unlockAll.EmoteController.Play

									unlockAll.EmoteController.Play = function(arg, arg2, arg3)
										local flag19 = unlockAll.Status == "active" and arg2 and unlockAll.EmotesFolder:FindFirstChild(arg2)
										if flag19 and flag19.AnimationId ~= "" and flag19.AnimationId ~= "rbxassetid://0" then
											return unlockAll.PlayEmote(arg2)
										end
										return unlockAll.Originals.EmotePlay(arg, arg2, arg3)
									end

									for _, v109 in { "UpdateHolderEmotes", "UpdateMenuContentEmotes" }, nil, nil do
										local v110 = v109
										unlockAll.Originals[v110] = unlockAll.EmoteWheel[v110]

										unlockAll.EmoteWheel[v110] = function(arg, ...)
											local v111 = unlockAll.Originals[v110]
											local v112 = table.pack(...)
											v112.n = 2 + v112.n - 1
											table.move(v112, 1, v112.n, 2, v112)
											v112[1] = arg
											local v113 = v111(table.unpack(v112, 1, v112.n))

											if unlockAll.Status == "active" then
												unlockAll.RefreshEmotes()
											end

											return v113
										end
									end
								end

								unlockAll.GetEmoteSlot = function()
									if unlockAll.EmoteWheel.type == "Menu" then
										return math.clamp(tonumber(unlockAll.EmoteWheel.selected) or 1, v85[18], 24)
									end
									return math.clamp(tonumber(unlockAll.EmoteWheel.selected) or unlockAll.SelectedSlot or 1, 1, v85[35]) + ((tonumber(unlockAll.EmoteWheel.page) or 1) - 1) * 8
								end

								unlockAll.SetEmoteButton = function(arg, arg2)
									local v109 = unlockAll.EmotesFolder:FindFirstChild(arg2)
									if not v109 then
										return
									end
									local attribute = v109:GetAttribute("EmoteName") or v109.Name
									local attribute2 = v109:GetAttribute("Icon") or ""
									local emoteWheel = v104:FindFirstChild("EmoteWheel")
									local wheel = emoteWheel and emoteWheel:FindFirstChild("Wheel")
									emoteWheel = emoteWheel and emoteWheel:FindFirstChild("Menu")
									local v110 = v85[18]
									local n33 = math.floor((arg - 1) / 8) + v110
									wheel = wheel and wheel:FindFirstChild("Holder")
									emoteWheel = emoteWheel and emoteWheel:FindFirstChild("Content")
									local tbl26 = {}
									local flag19 = n33 == (tonumber(unlockAll.EmoteWheel.page) or 1) and wheel and wheel:FindFirstChild(tostring((arg - 1) % v85[35] + 1))
									emoteWheel = emoteWheel and emoteWheel:FindFirstChild(tostring(arg))
									tbl26[1] = flag19
									tbl26[2] = emoteWheel

									for _, v111 in tbl26, nil, nil do
										if v111 then
											v111:SetAttribute("EmoteId", arg2)
											v111:SetAttribute("EmoteName", attribute)
											local vector = v111:FindFirstChild("Vector")

											if vector then
												vector.Image = attribute2
											elseif v111:IsA("ImageButton") then
												v111.Image = attribute2
											end

											local title = v111:FindFirstChild("Title") or v111:FindFirstChild("ItemName") or v111:FindFirstChild("Text")

											if title and title:IsA("TextLabel") then
												title.Text = attribute
											end
										end
									end
								end

								unlockAll.RefreshEmotes = function()
									for k, v109 in unlockAll.EquippedEmotes, nil, nil do
										unlockAll.SetEmoteButton(tonumber(k) or k, v109)
									end
								end

								unlockAll.UpdateEmoteWheel = function()
									local updateHolderEmotes = unlockAll.Originals.UpdateHolderEmotes
									local updateMenuContentEmotes = unlockAll.Originals.UpdateMenuContentEmotes

									if updateHolderEmotes then
										updateHolderEmotes(unlockAll.EmoteWheel)
									else
										unlockAll.EmoteWheel:UpdateHolderEmotes()
									end

									if updateMenuContentEmotes then
										updateMenuContentEmotes(unlockAll.EmoteWheel)
									else
										unlockAll.EmoteWheel:UpdateMenuContentEmotes()
									end

									unlockAll.EmoteWheel:updateCenterText()
									unlockAll.RefreshEmotes()
								end

								unlockAll.ApplyEmote = function(arg, arg2)
									local selectedSlot = tonumber(arg) or unlockAll.GetEmoteSlot()
									if not arg2 or unlockAll.Deleted.Emote[arg2] or not unlockAll.EmotesFolder:FindFirstChild(arg2) then
										return
									end
									unlockAll.SelectedSlot = selectedSlot
									unlockAll.EquippedEmotes[selectedSlot] = arg2
									unlockAll.UpdateEmoteWheel()
									unlockAll.Save()
								end

								unlockAll.GetEmoteScroller = function()
									if unlockAll.EmoteContainer then
										return unlockAll.EmoteContainer
									end
									local emoteWheel = v104:FindFirstChild("EmoteWheel")
									emoteWheel = emoteWheel and emoteWheel:FindFirstChild("List")
									return emoteWheel and emoteWheel:FindFirstChild("Content")
								end

								unlockAll.LoadEmotes = function()
									local emote = unlockAll.InventoryClient:GetInventory().Emote or {}
									if unlockAll.EmoteCatalogLoaded then
										return emote
									end
									table.clear(unlockAll.EmoteItems)
									table.clear(unlockAll.EmoteItemsList)
									table.clear(unlockAll.EmoteDisplays)
									table.clear(unlockAll.EmoteItemKeys)
									local tbl26 = {}

									for _, v109 in emote, nil, nil do
										if not unlockAll.IsUnlockItem(v109) then
											tbl26[v109.Name] = v85[200]
										end
									end

									local v109 = v85[116]
									local n33 = os.clock() + v109

									for _, v110 in unlockAll.EmotesFolder:GetChildren() do
										local v111 = unlockAll.ItemInfo.Emote[v110.Name]

										if v110:IsA("Animation") and v111 then
											unlockAll.EmoteDisplays[v111.DisplayName or v111.Name] = v110.Name
										end

										if v110:IsA("Animation") and not tbl26[v110.Name] and v111 and type(v111.Icon) == "string" and v111.Icon ~= "" and v111.Icon ~= "rbxassetid://0" and v111.Icon ~= v110.AnimationId then
											local tbl27 = { Name = v110.Name, Id = "UnlockAll:Emote:" .. v110.Name, CreatedAt = 0 }
											unlockAll.EmoteItems[v110.Name] = tbl27
											table.insert(unlockAll.EmoteItemsList, tbl27)
											local tbl28 = { "Id" }
											local id = tbl27.Id
											unlockAll.EmoteItemKeys[unlockAll.InventoryShared:ItemToKey("Emote", tbl27, tbl28)] = id
										end

										if n33 <= os.clock() then
											v88.Heartbeat:Wait()
											n33 = os.clock() + 0.001
										end
									end

									unlockAll.EmoteCatalogLoaded = true
									return emote
								end

								unlockAll.FillEmoteInventory = function()
									if unlockAll.EmotesReady or unlockAll.EmoteBuilding or not unlockAll.EmoteView then
										return
									end
									unlockAll.EmoteBuilding = v85[200]
									unlockAll.EmoteBuildToken = unlockAll.EmoteBuildToken + 1
									local emoteBuildToken = unlockAll.EmoteBuildToken

									task.spawn(function()
										local emoteItemsList = unlockAll.EmoteItemsList
										local emoteInventory = unlockAll.EmoteInventory
										local emoteBuildIndex = unlockAll.EmoteBuildIndex

										while emoteBuildIndex <= #emoteItemsList and unlockAll.EmoteBuildToken == emoteBuildToken do
											local n33 = os.clock() + 0.001

											while true do
												local v109 = emoteItemsList[emoteBuildIndex]

												if not emoteInventory[v109.Id] and not unlockAll.Deleted.Emote[v109.Name] then
													emoteInventory[v109.Id] = v109
													unlockAll.EmoteView.TriggerUpdate(v109, "Insert")
												end

												emoteBuildIndex += 1
												if not (emoteBuildIndex > #emoteItemsList or os.clock() >= n33) then
													continue
												end
												break
											end

											unlockAll.EmoteBuildIndex = emoteBuildIndex

											if emoteBuildIndex <= #emoteItemsList then
												v88.Heartbeat:Wait()
											end
										end

										if unlockAll.EmoteBuildToken == emoteBuildToken then
											unlockAll.EmoteBuilding = false
											unlockAll.EmotesReady = emoteBuildIndex > #emoteItemsList
										end
									end)
								end

								unlockAll.PatchInventory = function(arg)
									if unlockAll.Originals.CreateInventory then
										return
									end
									local emoteSource = unlockAll.EmoteSource

									if not emoteSource or not emoteSource.Parent then
										emoteSource = v104:FindFirstChild("EmoteWheel")
										emoteSource = emoteSource and emoteSource:FindFirstChild("List")
										emoteSource = emoteSource and emoteSource:FindFirstChild("Content")
										unlockAll.EmoteSource = emoteSource
									end

									if not emoteSource then
										return
									end

									if not unlockAll.EmoteContainer then
										local tbl26 = {}

										for _, v109 in emoteSource:GetDescendants() do
											if v109:IsA("GuiButton") then
												tbl26[v109] = v109.Archivable
												v109.Archivable = false
											end
										end

										unlockAll.EmoteContainer = emoteSource:Clone()

										for k, v109 in tbl26, nil, nil do
											k.Archivable = v109
										end

										unlockAll.EmoteContainer.Name = "UnlockAllContent"
										unlockAll.EmoteContainer.Visible = false
										unlockAll.EmoteInventory = table.clone(arg)
										local v109 = unlockAll.InventoryShared.CreateFakeReplion()
										v109.Data = { Inventory = { Emote = unlockAll.EmoteInventory } }
										unlockAll.EmoteCaller = { Replion = v109 }
									end

									unlockAll.Originals.EmoteFindItemsWithKey = unlockAll.InventoryClient.FindItemsWithKey
									unlockAll.Originals.EmoteGetItem = unlockAll.InventoryClient.GetItem

									unlockAll.InventoryClient.FindItemsWithKey = function(arg2, arg3, arg4, ...)
										local flag19 = arg3 == "Emote" and unlockAll.EmoteItemKeys[arg4]
										if unlockAll.Status == "active" and flag19 then
											return { flag19 }
										end
										local emoteFindItemsWithKey = unlockAll.Originals.EmoteFindItemsWithKey
										local v109 = table.pack(...)
										v109.n = 4 + v109.n - 1
										table.move(v109, 1, v109.n, 4, v109)
										v109[1] = arg2
										v109[2] = arg3
										v109[3] = arg4
										return emoteFindItemsWithKey(table.unpack(v109, 1, v109.n))
									end

									unlockAll.InventoryClient.GetItem = function(arg2, arg3, arg4, ...)
										local match = arg3 == "Emote" and tostring(arg4):match("^UnlockAll:Emote:(.+)$")
										if unlockAll.Status == "active" and match and unlockAll.EmoteItems[match] then
											return unlockAll.EmoteItems[match]
										end
										local consoleItems = unlockAll.ConsoleItems and unlockAll.ConsoleItems[arg3]
										local match2 = consoleItems and tostring(arg4):match("^UnlockAll:" .. arg3 .. ":(.+)$")
										if unlockAll.Status == "active" and match2 and consoleItems[match2] then
											return consoleItems[match2].Item
										end
										local emoteGetItem = unlockAll.Originals.EmoteGetItem
										local v109 = table.pack(...)
										v109.n = 4 + v109.n - 1
										table.move(v109, 1, v109.n, 4, v109)
										v109[1] = arg2
										v109[2] = arg3
										v109[3] = arg4
										return emoteGetItem(table.unpack(v109, 1, v109.n))
									end

									local emoteContainer = unlockAll.EmoteContainer
									emoteContainer.Position = emoteSource.Position
									emoteContainer.Size = emoteSource.Size
									emoteContainer.Active = emoteSource.Active
									emoteContainer.Visible = false
									unlockAll.EmoteContainer.Parent = emoteSource.Parent
									unlockAll.EmoteOriginal = emoteSource
									unlockAll.OriginalPosition = emoteSource.Position
									unlockAll.OriginalSize = emoteSource.Size
									unlockAll.OriginalActive = emoteSource.Active
									unlockAll.OriginalVisible = emoteSource.Visible
									emoteSource.Visible = false
									emoteSource.Position = UDim2.fromOffset(-100000, -v85[15])
									emoteSource.Active = false
									unlockAll.Originals.CreateInventory = unlockAll.InventoryController.CreateInventory

									unlockAll.InventoryController.CreateInventory = function(arg2, arg3)
										if unlockAll.Status == "active" and arg3.InventoryType == "Emote" then
											local v109 = table.clone(arg3)
											v109.Caller = unlockAll.EmoteCaller
											v109.Container = unlockAll.EmoteContainer
											v109.WatchOnChange = false

											v109.FindItemsWithKey = function(arg4, arg5)
												local flag19 = arg4 == "Emote" and unlockAll.EmoteItemKeys[arg5]
												if flag19 then
													return unlockAll.EmoteInventory[flag19] and { flag19 } or {}
												end
												return unlockAll.InventoryShared:FindItemsWithKey(unlockAll.EmoteCaller, arg4, arg5)
											end

											local onSlotCreated = v109.OnSlotCreated

											v109.OnSlotCreated = function(arg4, arg5, arg6, arg7, arg8)
												if onSlotCreated then
													onSlotCreated(arg4, arg5, arg6, arg7, arg8)
												end

												if arg5 and arg5.Name and arg7 and arg8 then
													if unlockAll.EmoteItems[arg5.Name] and getconnections then
														for _, v110 in getconnections(arg7.Activated) do
															v110:Disconnect()
														end
													end

													arg8:Add(arg7.Activated:Connect(function()
														local name = arg5.Name
														task.defer(unlockAll.ApplyEmote, unlockAll.GetEmoteSlot(), name)
													end))
												end
											end

											unlockAll.EmoteView = unlockAll.Originals.CreateInventory(arg2, v109)
											return unlockAll.EmoteView
										end

										return unlockAll.Originals.CreateInventory(arg2, arg3)
									end

									if not unlockAll.EmoteView then
										local tbl26 = {}
										local searchFrame = emoteSource.Parent:FindFirstChild("SearchFrame")

										if searchFrame and getconnections then
											tbl26[searchFrame.Search.MouseButton1Click] = {}
											tbl26[searchFrame.SearchBG.SearchInput.FocusLost] = {}

											for k, v109 in tbl26, nil, nil do
												for _, v110 in getconnections(k) do
													if v110.Function then
														v109[v110.Function] = true
													end
												end
											end
										end

										local createSortOptions = unlockAll.InventoryController.CreateSortOptions

										unlockAll.InventoryController.CreateSortOptions = function()
										end

										unlockAll.EmoteWheel:populateEmoteList()
										unlockAll.InventoryController.CreateSortOptions = createSortOptions

										for k, v109 in tbl26, nil, nil do
											for _, v110 in getconnections(k) do
												if next(v109) and v110.Function and not v109[v110.Function] then
													v110:Disconnect()
												end
											end
										end
									end

									emoteContainer.Visible = true
									unlockAll.FillEmoteInventory()
								end

								unlockAll.RestoreInventory = function(arg)
									unlockAll.EmoteBuildToken = unlockAll.EmoteBuildToken + 1
									unlockAll.EmoteBuilding = v85[101]
									unlockAll.EmoteBuildIndex = 1
									unlockAll.EmotesReady = v85[101]
									fn73("CreateInventory", unlockAll.InventoryController)
									fn73("EmoteFindItemsWithKey", unlockAll.InventoryClient, "FindItemsWithKey")
									fn73("EmoteGetItem", unlockAll.InventoryClient, "GetItem")

									if unlockAll.EmoteContainer then
										unlockAll.EmoteContainer.Visible = false
										unlockAll.EmoteContainer.Parent = nil
									end

									if unlockAll.EmoteOriginal then
										unlockAll.EmoteOriginal.Position = unlockAll.OriginalPosition
										unlockAll.EmoteOriginal.Size = unlockAll.OriginalSize
										unlockAll.EmoteOriginal.Active = unlockAll.OriginalActive
										unlockAll.EmoteOriginal.Visible = unlockAll.OriginalVisible
										unlockAll.EmoteOriginal = nil
										unlockAll.OriginalPosition = nil
										unlockAll.OriginalSize = nil
										unlockAll.OriginalActive = nil
										unlockAll.OriginalVisible = nil
									end

									if not arg then
										return
									end
									fn29(unlockAll.ButtonConnections)
									table.clear(unlockAll.ButtonConnections)

									if unlockAll.EmoteView then
										unlockAll.EmoteView.Destroy()
										unlockAll.EmoteView = nil
									end

									if unlockAll.EmoteCaller then
										unlockAll.EmoteCaller.Replion:Destroy()
										unlockAll.EmoteCaller = nil
									end

									if unlockAll.EmoteContainer then
										unlockAll.EmoteContainer:Destroy()
										unlockAll.EmoteContainer = nil
									end

									unlockAll.EmoteSource = nil
									unlockAll.EmoteInventory = nil
									unlockAll.EmoteCatalogLoaded = v85[101]
								end

								unlockAll.BindEmoteCard = function(arg)
									local v109 = unlockAll.ButtonConnections[arg]

									if v109 then
										fn29(v109)
										unlockAll.ButtonConnections[arg] = nil
									end

									if unlockAll.Status ~= "active" or not arg.Parent then
										return
									end
									local itemName = arg:FindFirstChild("ItemName")
									local v110 = itemName and unlockAll.EmoteDisplays[itemName.Text]
									if not v110 then
										return
									end

									if not unlockAll.EmoteItems[v110] then
										return
									end
									local favorite = arg:FindFirstChild("Favorite")
									local delete = arg:FindFirstChild("Delete")

									if getconnections and favorite then
										for _, v111 in getconnections(favorite.Activated) do
											v111:Disconnect()
										end
									end

									if getconnections and delete then
										for _, v111 in getconnections(delete.Activated) do
											v111:Disconnect()
										end
									end

									local tbl26 = {}

									if favorite then
										table.insert(tbl26, favorite.Activated:Connect(function()
											unlockAll.ToggleFavorite("Emote", v110)
										end))
									end

									if delete then
										table.insert(tbl26, delete.Activated:Connect(function()
											unlockAll.PromptDelete("Emote", v110)
										end))
									end

									unlockAll.ButtonConnections[arg] = tbl26
								end

								unlockAll.HookEmoteCard = function(arg)
									if unlockAll.Status ~= "active" or not arg:IsA("GuiButton") or not arg:FindFirstChild("ItemName") or unlockAll.CardConnections[arg] then
										return
									end

									unlockAll.CardConnections[arg] = arg.ItemName:GetPropertyChangedSignal(v85[133]):Connect(function()
										task.defer(unlockAll.BindEmoteCard, arg)
									end)

									task.defer(unlockAll.BindEmoteCard, arg)
								end

								unlockAll.HookEmotes = function()
									local v109 = unlockAll.GetEmoteScroller()
									if not v109 then
										return
									end

									for _, v110 in v109:GetDescendants() do
										unlockAll.HookEmoteCard(v110)
									end

									unlockAll.Add(v109.DescendantAdded:Connect(function(descendant)
										task.defer(unlockAll.HookEmoteCard, descendant)
									end))
								end

								unlockAll.SaveDefaults = function()
									local character = localPlayer.Character
									unlockAll.Defaults.Sword = character and character:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword") or "Base Sword"
									unlockAll.Defaults.Explosion = localPlayer:GetAttribute("CurrentlyEquippedExplosion") or character and character:GetAttribute("CurrentlyEquippedExplosion") or "Explosion Normal"
									local v109 = v85[200]
									unlockAll.Defaults.Accessory = localPlayer:GetAttribute("ShowSwordAccessory") == v109
								end

								unlockAll.ApplySaved = function()
									local str5 = tostring(tbl20.UnlockAllSword or "")
									local v109 = unlockAll.AwakenBase[str5] or str5
									local str6 = tostring(tbl20.UnlockAllExplosion or "")
									local unlockAllEmotes = tbl20.UnlockAllEmotes or {}
									local accessory = tbl20.UnlockAllAccessory == true
									unlockAll.Accessory = accessory
									localPlayer:SetAttribute("ShowSwordAccessory", accessory)
									local flag19 = v109 ~= ""
									local flag20

									if flag19 then
										flag20 = not unlockAll.ShopActive or unlockAll.ShopItems.Sword[v109]
									else
										flag20 = flag19
									end

									if flag20 then
										unlockAll.SelectSword(v109, v85[101])
									end

									if str6 ~= "" and (not unlockAll.ShopActive or unlockAll.ShopItems.Explosion[str6]) then
										unlockAll.SelectExplosion(str6, false)
									end

									table.clear(unlockAll.EquippedEmotes)
									local tbl26 = {}

									for k in unlockAllEmotes, nil, nil do
										local num = tonumber(k)

										if num then
											table.insert(tbl26, num)
										end
									end

									table.sort(tbl26)
									local tbl27 = {}
									local emote = unlockAll.InventoryClient:GetInventory().Emote or {}

									for _, v110 in emote, nil, nil do
										tbl27[v110.Name] = true
									end

									for _, v110 in tbl26, nil, nil do
										local v111 = unlockAllEmotes[tostring(v110)] or unlockAllEmotes[v110]

										if v111 and (tbl27[v111] or unlockAll.EmoteItems[v111]) then
											unlockAll.EquippedEmotes[v110] = v111
										end
									end

									table.clear(unlockAll.Finishers)
									local unlockAllFinishers = tbl20.UnlockAllFinishers or {}

									for k, v110 in unlockAllFinishers, nil, nil do
										if v110 == true then
											unlockAll.Finishers[k] = v85[200]

											if unlockAll.DataReplion then
												local tbl28 = { "Finishers", "Equipped", k }
												unlockAll.DefaultFinishers[k] = unlockAll.DataReplion:Get(tbl28) == true
												unlockAll.DataReplion:_set(tbl28, true)
											end
										end
									end

									unlockAll.UpdateEmoteWheel()
								end

								unlockAll.RestoreEmotes = function()
									table.clear(unlockAll.EquippedEmotes)
									unlockAll.StopEmote()
									unlockAll.EmoteWheel:UpdateHolderEmotes()
									unlockAll.EmoteWheel:UpdateMenuContentEmotes()
								end

								unlockAll.Start = function()
									if unlockAll.Status then
										return
									end
									unlockAll.Status = "starting"
									local run = unlockAll.Run + v85[18]
									unlockAll.Run = run
									unlockAll.Load()

									while tbl20.UnlockAllEnabled and unlockAll.Run == run and not unlockAll.ShopReady() do
										v88.Heartbeat:Wait()
									end

									if not tbl20.UnlockAllEnabled or unlockAll.Run ~= run then
										if unlockAll.Run == run then
											unlockAll.Status = nil
										end

										return
									end

									unlockAll.Status = "active"

									for _, v109 in unlockAll.Deleted, nil, nil do
										table.clear(v109)
									end

									table.clear(unlockAll.EquippedEmotes)
									table.clear(unlockAll.SavedEquipped)
									table.clear(unlockAll.Finishers)
									table.clear(unlockAll.DefaultFinishers)
									unlockAll.Accessory = v85[101]
									unlockAll.Originals.EquippedSword = nil
									unlockAll.Originals.EquippedExplosion = nil
									unlockAll.LoadFavorites()
									unlockAll.SaveDefaults()
									local v109 = unlockAll.LoadEmotes()
									if unlockAll.Run ~= run or unlockAll.Status ~= "active" then
										return
									end
									unlockAll.PatchInventory(v109)
									unlockAll.HookEmotes()
									unlockAll.PatchExplosion()
									unlockAll.PatchEmotes()
									unlockAll.PatchParrySuccess()
									unlockAll.ApplySaved()
									unlockAll.WatchSword(localPlayer.Character)
									local CollectionService = game:GetService("CollectionService")
									unlockAll.Add(CollectionService:GetInstanceAddedSignal("EncryptedClone"):Connect(unlockAll.WatchClone))

									unlockAll.Add(CollectionService:GetInstanceRemovedSignal("EncryptedClone"):Connect(function(arg)
										unlockAll.ClearClone(arg, v85[200])
									end))

									for _, v110 in CollectionService:GetTagged("EncryptedClone") do
										unlockAll.WatchClone(v110)
									end

									unlockAll.WatchEmotes(localPlayer.Character)

									unlockAll.Add(localPlayer:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
										local sword = unlockAll.Sword

										if sword and localPlayer:GetAttribute("CurrentlyEquippedSword") ~= sword then
											task.defer(unlockAll.ApplySword, sword)
										end
									end))

									unlockAll.Add(localPlayer.CharacterAdded:Connect(function(character)
										local run2 = unlockAll.Run
										tbl25.Animation.Reset()
										unlockAll.WatchSword(character)
										unlockAll.WatchEmotes(character)

										task.delay(1, function()
											if unlockAll.Status == "active" and unlockAll.Run == run2 and localPlayer.Character == character and unlockAll.Sword then
												unlockAll.ApplySword(unlockAll.Sword)

												if unlockAll.Explosion then
													localPlayer:SetAttribute("CurrentlyEquippedExplosion", unlockAll.Explosion)
													character:SetAttribute("CurrentlyEquippedExplosion", unlockAll.Explosion)
												end
											end
										end)
									end))

									if not unlockAll.ActivateShop() then
										return
									end
									unlockAll.ApplyFavorites()
									unlockAll.HookShop()
									unlockAll.HookConsole()
								end

								unlockAll.Stop = function(arg)
									if arg then
										for _, v109 in { "Parry_All_Func", "Parry_Client_Func" }, nil, nil do
											local v110 = unlockAll.Originals[v109 .. "Target"]

											if v110 then
												hookfunction(v110, unlockAll.Originals[v109])
												unlockAll.Originals[v109 .. "Target"] = nil
												unlockAll.Originals[v109] = nil
											end
										end
									end

									local status = unlockAll.Status
									unlockAll.Status = nil
									unlockAll.Run = unlockAll.Run + 1

									if status ~= "active" then
										if arg then
											unlockAll.RestoreInventory(true)
										end

										return
									end

									fn73("UpdateMultiDelete", unlockAll.Shop, "_updateMultiDelete")
									fn73("CanDelete", unlockAll.Shop, "_canDelete")

									for _, v109 in unlockAll.Types, nil, nil do
										fn73("MarkDirty" .. v109, unlockAll.Shop._inventoryPages[v109], "MarkDirty")
									end

									unlockAll.CloseMultiDelete()
									fn29(unlockAll.Connections)
									table.clear(unlockAll.Connections)
									fn29(unlockAll.CardConnections)
									table.clear(unlockAll.CardConnections)
									unlockAll.RestoreConsole()
									unlockAll.DestroyOverlays()
									unlockAll.RestoreInventory(arg)
									unlockAll.RestoreShop()
									unlockAll.RestoreFavorites()
									localPlayer:SetAttribute("ShowSwordAccessory", unlockAll.Defaults.Accessory == true)

									for k, v109 in unlockAll.DefaultFinishers, nil, nil do
										if unlockAll.DataReplion then
											unlockAll.DataReplion:_set({ "Finishers", "Equipped", k }, v109 == v85[200])
										end
									end

									table.clear(unlockAll.Finishers)
									table.clear(unlockAll.DefaultFinishers)
									fn73("PlayExplosion", unlockAll.VFX)
									fn73("EmotePlay", unlockAll.EmoteController, "Play")
									fn73("UpdateHolderEmotes", unlockAll.EmoteWheel)
									fn73("UpdateMenuContentEmotes", unlockAll.EmoteWheel)
									unlockAll.RestoreSword()

									if unlockAll.Originals.SetSword and unlockAll.BladeController then
										fn73("SetSword", unlockAll.BladeController)
									end

									unlockAll.RestoreExplosion()
									unlockAll.RestoreEmotes()
									unlockAll.Sword = nil
									unlockAll.Explosion = nil
								end

								unlockAll.Toggle = function(unlockAllEnabled)
									tbl20.UnlockAllEnabled = unlockAllEnabled

									if unlockAllEnabled then
										task.defer(unlockAll.Start)
									else
										unlockAll.Stop()
									end
								end
							end
						end

						fn43({ CustomStreakEnabled = false, CustomStreak = "" })
						tbl25.Streak = { Originals = {} }

						tbl25.Streak.Get = function()
							local num = tonumber(tostring(tbl20.CustomStreak or ""):match("^%s*(.-)%s*$"))
							return num and math.max(0, math.floor(num))
						end

						tbl25.Streak.Format = function(arg)
							return (tostring(arg):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
						end

						tbl25.Streak.Set = function(arg, arg2, arg3)
							if not tbl25.Streak.Originals[arg] then
								tbl25.Streak.Originals[arg] = { arg2, arg[arg2] }
							end

							if arg[arg2] ~= arg3 then
								arg[arg2] = arg3
							end
						end

						tbl25.Streak.RestoreObject = function(arg)
							local v109 = tbl25.Streak.Originals[arg]
							if not v109 then
								return
							end

							if arg.Parent then
								arg[v109[v85[18]]] = v109[2]
							end

							tbl25.Streak.Originals[arg] = nil
						end

						tbl25.Streak.Restore = function()
							for k, v109 in tbl25.Streak.Originals, nil, nil do
								if k.Parent then
									k[v109[1]] = v109[v85[70]]
								end
							end

							table.clear(tbl25.Streak.Originals)
						end

						flyteBBState.StreakRestore = tbl25.Streak.Restore

						tbl25.Streak.Refresh = function(arg)
							local v109 = tbl25.Streak.Originals[arg]

							if v109 then
								v109[2] = arg[v109[1]]
							end

							fn42("Streak Display")
							fn42("Streak Value")
							fn42("Streak Flame")
							tbl25.Streak.Value = nil
							task.defer(tbl25.Streak.ApplyDisplay)
						end

						tbl25.Streak.Profile = function()
							local profileCard = v104:FindFirstChild("ProfileCard")
							local profile = profileCard and profileCard:FindFirstChild("Customize") and profileCard.Customize:FindFirstChild("Profile")
							local playerProfile = profile and profile:FindFirstChild("PlayerProfile")
							playerProfile = playerProfile and playerProfile:FindFirstChild("Details")
							profile = profile and profile:FindFirstChild("Achievements")
							return playerProfile and playerProfile:FindFirstChild("Username"), profile and profile:FindFirstChild("Scrollingframe")
						end

						tbl25.Streak.ApplyDisplay = function()
							if not tbl20.CustomStreakEnabled then
								return
							end
							local character = localPlayer.Character
							local winStreakDisplay = character and character:FindFirstChild("WinStreakDisplay", true)

							if not winStreakDisplay and character then
								local head = character:FindFirstChild("Head")
								local assets = v93:FindFirstChild("Assets")
								local ui = assets and assets:FindFirstChild("UI")
								ui = ui and ui:FindFirstChild("WinStreakDisplay")

								if head and ui then
									winStreakDisplay = ui:Clone()
									winStreakDisplay.Adornee = head
									tbl25.Streak.Display = winStreakDisplay
									winStreakDisplay.Parent = character
								end
							end

							local main = winStreakDisplay and winStreakDisplay:FindFirstChild("Main")
							local value = main and main:FindFirstChild("Value")
							local icon = main and main:FindFirstChild("Icon")
							if not value or not icon then
								return
							end
							local v109 = tbl25.Streak.Get()
							if not v109 then
								return
							end
							local str5 = "<b><stroke color='rgb(0, 0, 0)' thickness='2'>" .. tbl25.Streak.Format(v109) .. "</stroke></b>"
							local str6 = v109 >= 10 and "rbxassetid://75598166115655" or "rbxassetid://89658127170771"
							tbl25.Streak.Set(winStreakDisplay, "Enabled", true)
							tbl25.Streak.Set(value, "Text", str5)
							tbl25.Streak.Set(icon, "Image", str6)

							if tbl25.Streak.Value ~= value then
								fn42("Streak Display")
								fn42("Streak Value")
								fn42("Streak Flame")
								tbl25.Streak.Value = value

								flyteBBState.Connections["Streak Display"] = winStreakDisplay:GetPropertyChangedSignal("Enabled"):Connect(function()
									tbl25.Streak.Refresh(winStreakDisplay)
								end)

								flyteBBState.Connections["Streak Value"] = value:GetPropertyChangedSignal(v85[133]):Connect(function()
									tbl25.Streak.Refresh(value)
								end)

								flyteBBState.Connections["Streak Flame"] = icon:GetPropertyChangedSignal("Image"):Connect(function()
									tbl25.Streak.Refresh(icon)
								end)
							end
						end

						tbl25.Streak.ApplyProfile = function()
							if not tbl20.CustomStreakEnabled then
								return
							end
							local v109 = tbl25.Streak.Get()
							if not v109 then
								return
							end
							local flag19 = v109 > (tonumber(Data:Get("TotalStats.BestWinStreak")) or 0)
							local v110 = tbl25.Streak.Format(v109)
							local profile = v104:FindFirstChild("Profile")
							profile = profile and profile:FindFirstChild("BestWinStreak", true)
							profile = profile and profile:FindFirstChild("Value")

							if profile then
								if flag19 then
									tbl25.Streak.Set(profile, "Text", v110 .. " Wins")
								else
									tbl25.Streak.RestoreObject(profile)
								end
							end

							local v111, v112 = tbl25.Streak.Profile()
							if not v111 or v111.Text ~= "@" .. localPlayer.Name or not v112 then
								return
							end

							for _, v113 in v112:GetChildren() do
								local title = v113:FindFirstChild("Title")
								local description = v113:FindFirstChild("Description")

								if title and description and title.Text == "Best Win Streak" then
									if flag19 then
										tbl25.Streak.Set(description, "Text", v110)
									else
										tbl25.Streak.RestoreObject(description)
									end

									break
								end
							end
						end

						tbl25.Streak.BindCharacter = function(arg)
							fn42("Streak Character UI")

							flyteBBState.Connections["Streak Character UI"] = arg.DescendantAdded:Connect(function(descendant)
								if descendant.Name == "WinStreakDisplay" or descendant.Name == "Value" or descendant.Name == "Icon" then
									if descendant.Name == "WinStreakDisplay" and tbl25.Streak.Display and descendant ~= tbl25.Streak.Display then
										tbl25.Streak.Display:Destroy()
										tbl25.Streak.Display = nil
									end

									task.defer(tbl25.Streak.ApplyDisplay)
								end
							end)

							tbl25.Streak.ApplyDisplay()
						end

						tbl25.Streak.Stop = function()
							for _, v109 in {
								"Streak Character",
								"Streak Character UI",
								"Streak Display",
								"Streak Value",
								"Streak Flame",
								"Streak Profile",
								"Streak Profile Items",
								"Streak Best",
							}, nil, nil do
								fn42(v109)
							end

							tbl25.Streak.Restore()
							local character = localPlayer.Character
							local display = tbl25.Streak.Display and character

							if display then
								display = (tonumber(character:GetAttribute("Killstreak")) or 0) > 0
							end

							if tbl25.Streak.Display then
								tbl25.Streak.Display:Destroy()
								tbl25.Streak.Display = nil
							end

							if display then
								firesignal(character:GetAttributeChangedSignal("Killstreak"))
							end

							tbl25.Streak.Value = nil
						end

						tbl25.Streak.Toggle = function(customStreakEnabled)
							tbl20.CustomStreakEnabled = customStreakEnabled
							tbl25.Streak.Stop()
							if not customStreakEnabled or not tbl25.Streak.Get() then
								return
							end
							flyteBBState.Connections["Streak Character"] = localPlayer.CharacterAdded:Connect(tbl25.Streak.BindCharacter)

							flyteBBState.Connections["Streak Best"] = Data:OnChange("TotalStats.BestWinStreak", function()
								task.defer(tbl25.Streak.ApplyProfile)
							end)

							local v109, v110 = tbl25.Streak.Profile()

							if v109 then
								flyteBBState.Connections["Streak Profile"] = v109:GetPropertyChangedSignal("Text"):Connect(tbl25.Streak.ApplyProfile)
							end

							if v110 then
								flyteBBState.Connections["Streak Profile Items"] = v110.ChildAdded:Connect(function()
									task.defer(tbl25.Streak.ApplyProfile)
								end)
							end

							if localPlayer.Character then
								tbl25.Streak.BindCharacter(localPlayer.Character)
							end

							tbl25.Streak.ApplyProfile()
						end

						fn43({ ShowWins = false, ShowElims = false, ShowRAP = false })

						tbl25.Stats = {
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

						tbl25.Stats.Connect = function(arg, arg2)
							tbl25.Stats.Connections[#tbl25.Stats.Connections + 1] = arg:Connect(arg2)
						end

						tbl25.Stats.ConnectProfile = function(arg, arg2)
							tbl25.Stats.ProfileConnections = tbl25.Stats.ProfileConnections or {}
							tbl25.Stats.ProfileConnections[#tbl25.Stats.ProfileConnections + 1] = arg:Connect(arg2)
						end

						tbl25.Stats.RestoreProfile = function()
							local profileOriginal = tbl25.Stats.ProfileOriginal or {}

							for _, v109 in profileOriginal, nil, nil do
								if v109.Button.Parent then
									tbl25.Stats.Writing[v109.Button] = v85[200]
									tbl25.Stats.Writing[v109.Amount] = true
									v109.Button.Visible = v109.Visible
									v109.Amount.Text = v109.Text
									tbl25.Stats.Writing[v109.Button] = nil
									tbl25.Stats.Writing[v109.Amount] = nil
								end
							end
						end

						tbl25.Stats.ClearProfile = function(arg)
							local profileConnections = tbl25.Stats.ProfileConnections or {}

							for _, v109 in profileConnections, nil, nil do
								v109:Disconnect()
							end

							table.clear(tbl25.Stats.ProfileConnections or {})

							if arg then
								tbl25.Stats.RestoreProfile()
							end

							tbl25.Stats.ProfileOriginal = nil
						end

						tbl25.Stats.Stop = function()
							for _, v109 in tbl25.Stats.Connections, nil, nil do
								v109:Disconnect()
							end

							table.clear(tbl25.Stats.Connections)

							for k, v109 in tbl25.Stats.Originals, nil, nil do
								if k.Parent then
									tbl25.Stats.Writing[k] = v85[200]
									k.Value = v109
									tbl25.Stats.Writing[k] = nil
								end
							end

							tbl25.Stats.ClearProfile(true)
							table.clear(tbl25.Stats.Originals)
						end

						tbl25.Stats.SetValue = function(arg, arg2, arg3)
							if tbl25.Stats.Originals[arg3] ~= nil then
								return
							end
							tbl25.Stats.Originals[arg3] = arg3.Value

							local function fn73()
								local attribute = arg:GetAttribute(arg2.Attribute)

								if tbl20[arg2.Config] and tbl25.Stats.Originals[arg3] == 0 and type(attribute) == "number" and attribute > v85[33] and arg3.Value ~= attribute then
									tbl25.Stats.Writing[arg3] = v85[200]
									arg3.Value = attribute
									tbl25.Stats.Writing[arg3] = nil
								end
							end

							tbl25.Stats.Connect(arg3:GetPropertyChangedSignal("Value"), function()
								if tbl25.Stats.Writing[arg3] then
									return
								end
								tbl25.Stats.Originals[arg3] = arg3.Value
								fn73()
							end)

							tbl25.Stats.Connect(arg:GetAttributeChangedSignal(arg2.Attribute), fn73)
							fn73()
						end

						tbl25.Stats.BindPlayer = function(arg)
							local function fn73(arg2)
								for _, v109 in tbl25.Stats.Info, nil, nil do
									if v109.Leaderstat and tbl20[v109.Config] then
										local v110 = arg2:FindFirstChild(v109.Leaderstat)

										if v110 and v110:IsA("ValueBase") then
											tbl25.Stats.SetValue(arg, v109, v110)
										end
									end
								end

								tbl25.Stats.Connect(arg2.ChildAdded, function(arg3)
									for _, v109 in tbl25.Stats.Info, nil, nil do
										if v109.Leaderstat and tbl20[v109.Config] and arg3.Name == v109.Leaderstat and arg3:IsA("ValueBase") then
											tbl25.Stats.SetValue(arg, v109, arg3)
											break
										end
									end
								end)
							end

							local leaderstats = arg:FindFirstChild("leaderstats")

							if leaderstats then
								fn73(leaderstats)
							else
								tbl25.Stats.Connect(arg.ChildAdded, function(arg2)
									if arg2.Name == "leaderstats" then
										fn73(arg2)
									end
								end)
							end
						end

						tbl25.Stats.FormatRAP = function(arg)
							local n33 = v85[18]
							local str5

							if arg >= 1e12 then
								str5 = "T"
								n33 = 1e12
							elseif arg >= 1e9 then
								str5 = "B"
								n33 = 1e9
							elseif arg >= 1000000 then
								str5 = "M"
								n33 = 1000000
							else
								str5 = ""

								if arg >= 1000 then
									str5 = "K"
									n33 = 1000
								end
							end

							if n33 == 1 then
								return tostring(math.floor(arg))
							end
							local n34 = math.floor(arg / n33 * 10) / 10
							return (n34 % 1 == 0 and tostring(math.floor(n34)) or tostring(n34)) .. str5 .. (arg > 1000 and "+" or "")
						end

						tbl25.Stats.GetProfile = function()
							local profileCard = v104:FindFirstChild("ProfileCard")
							local customize = profileCard and profileCard:FindFirstChild("Customize")
							local profile = customize and customize:FindFirstChild("Profile")
							profile = profile and profile:FindFirstChild("PlayerProfile")
							local details = profile and profile:FindFirstChild("Details")
							return profileCard, details and details:FindFirstChild("Username"), profile and profile:FindFirstChild("Stats")
						end

						tbl25.Stats.ShowProfile = function(arg, arg2, arg3, arg4)
							local attribute = arg4:GetAttribute(arg2.Attribute)
							if not tbl20[arg2.Config] or not arg3 or arg3.Visible or type(attribute) ~= "number" then
								return
							end
							tbl25.Stats.Writing[arg3.Button] = true
							tbl25.Stats.Writing[arg3.Amount] = true
							arg3.Button.Visible = v85[200]
							arg3.Amount.Text = arg == "RAP" and tbl25.Stats.FormatRAP(attribute) or tbl25.Streak.Format(attribute)
							tbl25.Stats.Writing[arg3.Button] = nil
							tbl25.Stats.Writing[arg3.Amount] = nil
						end

						tbl25.Stats.ApplyProfile = function()
							local v109, match, v110 = tbl25.Stats.GetProfile()
							match = match and match.Text:match("^@(.+)$")
							local v111 = match and v89:FindFirstChild(match)
							if not v109 or not v109.Enabled or not v110 or not v111 then
								return
							end

							if not tbl25.Stats.ProfileOriginal then
								tbl25.Stats.ProfileOriginal = {}

								for k, v112 in tbl25.Stats.Info, nil, nil do
									local v113 = v110:FindFirstChild(v112.Profile)
									local amount = v113 and v113:FindFirstChild("Amount")

									if v113 and amount then
										tbl25.Stats.ProfileOriginal[k] = { Button = v113, Amount = amount, Visible = v113.Visible, Text = amount.Text }
										local v114 = tbl25.Stats.ProfileOriginal[k]

										tbl25.Stats.ConnectProfile(v113:GetPropertyChangedSignal("Visible"), function()
											if not tbl25.Stats.Writing[v113] then
												v114.Visible = v113.Visible
												tbl25.Stats.ShowProfile(k, v112, v114, v111)
											end
										end)

										tbl25.Stats.ConnectProfile(amount:GetPropertyChangedSignal("Text"), function()
											if not tbl25.Stats.Writing[amount] then
												v114.Text = amount.Text
												tbl25.Stats.ShowProfile(k, v112, v114, v111)
											end
										end)
									end
								end
							end

							tbl25.Stats.RestoreProfile()

							for k, v112 in tbl25.Stats.Info, nil, nil do
								tbl25.Stats.ShowProfile(k, v112, tbl25.Stats.ProfileOriginal[k], v111)
							end
						end

						tbl25.Stats.QueueProfile = function()
							if tbl25.Stats.ProfileQueued then
								return
							end
							tbl25.Stats.ProfileQueued = true
							tbl25.Stats.ClearProfile(false)

							task.defer(function()
								tbl25.Stats.ProfileQueued = nil
								tbl25.Stats.ApplyProfile()
							end)
						end

						tbl25.Stats.Toggle = function()
							tbl25.Stats.Stop()
							if not tbl20.ShowWins and not tbl20.ShowElims and not tbl20.ShowRAP then
								return
							end

							if tbl20.ShowWins or tbl20.ShowElims then
								tbl25.Stats.Connect(v89.PlayerAdded, tbl25.Stats.BindPlayer)

								for _, v109 in v89:GetPlayers() do
									tbl25.Stats.BindPlayer(v109)
								end
							end

							local v109, v110 = tbl25.Stats.GetProfile()

							if v109 then
								tbl25.Stats.Connect(v109:GetPropertyChangedSignal("Enabled"), function()
									if v109.Enabled then
										tbl25.Stats.QueueProfile()
									end
								end)
							end

							if v110 then
								local queueProfile = tbl25.Stats.QueueProfile
								tbl25.Stats.Connect(v110:GetPropertyChangedSignal("Text"), queueProfile)
							end

							tbl25.Stats.QueueProfile()
						end

						tbl25.Stats.Queue = function()
							if tbl25.Stats.Queued then
								return
							end
							tbl25.Stats.Queued = true

							task.defer(function()
								tbl25.Stats.Queued = nil
								tbl25.Stats.Toggle()
							end)
						end

						fn43({
							AutoPlayEnabled = false,
							AutoVoteMap = v85[101],
							HitFreeze = false,
							SpamJump = false,
							AutoPlaySmoothness = v85[169],
							AutoPlayAggressiveness = 45,
							AntiAFK = v85[101],
							AutoRejoinExecute = v85[101],
							ScriptKey = "",
							AutoPlayMode = "Play Edge",
						})

						tbl25.AFK = {}

						tbl25.AFK.Toggle = function(arg)
							flyteBBState.AFKConnections = flyteBBState.AFKConnections or {}

							for _, v109 in flyteBBState.AFKConnections, nil, nil do
								if not v109.Enabled then
									v109:Enable()
								end
							end

							table.clear(flyteBBState.AFKConnections)
							if not arg then
								return
							end

							for _, v109 in getconnections(localPlayer.Idled) do
								if v109.Enabled then
									v109:Disable()
									table.insert(flyteBBState.AFKConnections, v109)
								end
							end
						end

						tbl25.Script = {}

						tbl25.Script.Queue = function()
							local match = tostring(scriptKey or tbl20.ScriptKey or ""):match("^%s*(.-)%s*$")
							if match == "" then
								return v85[101]
							end
							queueonteleport(("script_key=%q;\nloadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/e30ade937c4c9b8ddbb03e976696e380.lua\"))()"):format(match))
							return v85[200]
						end

						tbl25.Script.Toggle = function(arg)
							fn42("Auto Rejoin")
							flyteBBState.ScriptRejoining = nil
							if not arg then
								return
							end

							flyteBBState.Connections["Auto Rejoin"] = v94:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay").ChildAdded:Connect(function(child)
								if child.Name ~= "ErrorPrompt" or flyteBBState.ScriptRejoining or v90.MenuIsOpen then
									return
								end
								local messageArea = child:WaitForChild("MessageArea", 1)
								if not messageArea or not messageArea:WaitForChild("ErrorFrame", 1) or not tbl25.Script.Queue() then
									return
								end
								flyteBBState.ScriptRejoining = true
								v95:Teleport(game.PlaceId, localPlayer)
							end)
						end

						tbl25.AutoPlay = { Direction = 1, Voting = {} }

						tbl25.AutoPlay.Jump = function(arg, arg2)
							if not arg then
								tbl25.AutoPlay.DoubleJumped = nil
								tbl25.AutoPlay.JumpAt = nil
								return
							end

							local character = localPlayer.Character
							character = character and character:FindFirstChildOfClass("Humanoid")
							if not character then
								return
							end

							if character.FloorMaterial ~= Enum.Material.Air then
								character:ChangeState(Enum.HumanoidStateType.Jumping)
								tbl25.AutoPlay.DoubleJumped = false
								tbl25.AutoPlay.JumpAt = os.clock()
							else
								local flag19 = arg2 and not tbl25.AutoPlay.DoubleJumped

								if flag19 then
									flag19 = os.clock() - (tbl25.AutoPlay.JumpAt or 0) >= 0.12
								end

								if flag19 then
									tbl25.AutoPlay.DoubleJumped = v85[200]
									firesignal(v87.JumpRequest)
								end
							end
						end

						tbl25.AutoPlay.VoteMode = function(arg)
							local voting = tbl25.AutoPlay.Voting
							local voter = localPlayer.PlayerGui:FindFirstChild("voter")

							if not voter or not voter.Enabled then
								voting.Mode = nil
								voting.ModeAt = nil
								return
							end

							if voting.Mode ~= voter then
								voting.Mode = voter
								voting.ModeAt = arg + 0.25 + math.random() * 0.5
							end

							if not voting.ModeAt or arg < voting.ModeAt then
								return
							end
							voting.ModeAt = nil
							local n1 = voter:FindFirstChild(v85[170])
							n1 = n1 and n1:FindFirstChild("1")
							local v109 = n1 and n1:FindFirstChildWhichIsA(v85[65], v85[200])

							if n1 and v109 and v109.Text == "Classic" then
								firesignal(n1.Activated)
							end
						end

						tbl25.AutoPlay.VoteMap = function(arg, arg2, arg3, arg4)
							local voting = tbl25.AutoPlay.Voting
							local gui = arg4:FindFirstChild("GUI")
							local surfaceGui = gui and gui:FindFirstChild("SurfaceGui")
							local top = surfaceGui and surfaceGui:FindFirstChild("Top")

							if not (top and top.Visible) then
								if voting.Map then
									voting.Done = v85[200]
								end

								voting.Map = nil
								voting.MapAt = nil
								voting.Pad = nil
								if voting.Done then
									arg2:MoveTo(arg3.Position)
									return
								end

								if not voting.Waiting then
									voting.Waiting = true
									voting.Moves = math.random(v85[18], 3)
									voting.Move = v85[33]
									voting.MoveAt = arg + 0.4 + math.random()
								end

								if not voting.Target and voting.Move < voting.Moves and arg >= voting.MoveAt then
									local part = arg4:FindFirstChild("Part")
									part = part and part.Position - arg3.Position or Vector3.zero
									local vector = Vector3.new(part.X, 0, part.Z)

									if vector.Magnitude > 0.1 then
										local unit = vector.Unit
										local vector2 = Vector3.new(-unit.Z, 0, unit.X)
										voting.Move = voting.Move + 1
										local position = arg3.Position
										local flag19 = voting.Move == 1

										if flag19 then
											local v109 = v85[153]
											flag19 = 3 + math.random() * v109
										end

										local n33 = position + unit * (flag19 or math.random() * 1.5)
										local v109 = v85[81]
										voting.Target = n33 + vector2 * (math.random() - v109) * (voting.Move == v85[18] and 5 or 3)
									end
								end

								if not voting.Target then
									arg2:MoveTo(arg3.Position)
									return
								end

								if (voting.Target - arg3.Position).Magnitude <= v85[122] then
									voting.Target = nil
									voting.MoveAt = arg + v85[81] + math.random() * 1.5
									arg2:MoveTo(arg3.Position)
								else
									arg2:MoveTo(voting.Target)
								end

								return
							end

							voting.Done = nil
							voting.Waiting = nil
							voting.Moves = nil
							voting.Move = nil
							voting.Target = nil

							if voting.Map ~= top or not voting.Pad or not voting.Pad.Parent then
								voting.Map = top
								voting.MapAt = arg + 0.8 + math.random() * 1.7
								local colliders = arg4:FindFirstChild("Colliders")
								local tbl26 = {}
								local children = colliders and colliders:GetChildren() or {}

								for _, v109 in children, nil, nil do
									if v109:IsA("BasePart") then
										tbl26[#tbl26 + v85[18]] = v109
									end
								end

								voting.Pad = #tbl26 > 0 and tbl26[math.random(#tbl26)]
							end

							local flag19 = not voting.Pad

							if not flag19 then
								flag19 = arg < (voting.MapAt or v85[33])
							end

							if flag19 then
								arg2:MoveTo(arg3.Position)
								return
							end
							local position = voting.Pad.Position
							arg2:MoveTo(Vector3.new(position.X, arg3.Position.Y, position.Z))
						end

						tbl25.AutoPlay.Stop = function()
							fn42("Auto Play")
							tbl25.AutoPlay.Jump(false)
							table.clear(tbl25.AutoPlay.Voting)
							tbl25.AutoPlay.Floor = nil
							tbl25.AutoPlay.Spawn = nil
							tbl25.AutoPlay.Map = nil
							tbl25.AutoPlay.Mode = nil
							tbl25.AutoPlay.Middle = nil
							tbl25.AutoPlay.MixAt = nil
							tbl25.AutoPlay.UpdateAt = nil
							tbl25.AutoPlay.PressureAt = nil
							tbl25.AutoPlay.PressureUntil = nil
							tbl25.AutoPlay.Home = nil
							tbl25.AutoPlay.Anchor = nil
							tbl25.AutoPlay.AnchorAt = nil
							tbl25.AutoPlay.EndAt = nil
							tbl25.AutoPlay.Raycast = nil
							tbl25.AutoPlay.LobbyTarget = nil
							tbl25.AutoPlay.LobbySettling = nil
							tbl25.AutoPlay.LobbyJumpAt = nil
							tbl25.AutoPlay.LobbyJumpUntil = nil
							tbl25.AutoPlay.LobbyDouble = nil
							tbl25.AutoPlay.LobbyDecided = nil
							tbl25.AutoPlay.LobbyIdle = nil
							tbl25.AutoPlay.InMatch = nil
							tbl25.AutoPlay.MatchHadOpponent = nil
							tbl25.AutoPlay.WonLast = nil
							tbl25.AutoPlay.ClashUntil = nil
							tbl25.AutoPlay.ChaseUntil = nil
							tbl25.AutoPlay.ClashDistance = nil
							tbl25.AutoPlay.ClashMoveAt = nil
							tbl25.AutoPlay.ClashTarget = nil
							tbl25.AutoPlay.Opponent = nil
							tbl25.AutoPlay.OpponentUntil = nil
							tbl25.AutoPlay.LastMove = nil
							tbl25.AutoPlay.Character = nil
						end

						tbl25.AutoPlay.Step = function()
							alive = alive.Parent and alive or workspace:FindFirstChild("Alive")
							local character = localPlayer.Character
							local humanoid = character and character:FindFirstChildOfClass("Humanoid")
							local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
							if not humanoid or not humanoidRootPart or humanoid.Health <= v85[33] then
								tbl25.AutoPlay.Jump(v85[101])
								return
							end
							local now2 = os.clock()
							if now2 < (tbl25.AutoPlay.UpdateAt or v85[33]) then
								return
							end
							tbl25.AutoPlay.UpdateAt = now2 + 0.066666666666666666

							if tbl20.AutoVoteMap then
								tbl25.AutoPlay.VoteMode(now2)
							end

							if character.Parent == workspace:FindFirstChild("Dead") then
								tbl25.AutoPlay.InMatch = false
								local spawn_ = workspace:FindFirstChild("Spawn")
								spawn_ = spawn_ and spawn_:FindFirstChild("NewPlayerCounter")
								if tbl20.AutoVoteMap and spawn_ then
									tbl25.AutoPlay.VoteMap(now2, humanoid, humanoidRootPart, spawn_)
									return
								end

								if not tbl25.AutoPlay.LobbyDecided then
									tbl25.AutoPlay.LobbyDecided = true
									tbl25.AutoPlay.LobbyIdle = tbl25.AutoPlay.WonLast and math.random(3) ~= 1 or not tbl25.AutoPlay.WonLast and math.random(5) == 1
								end

								if tbl25.AutoPlay.LobbyIdle then
									tbl25.AutoPlay.Jump(false)
									humanoid:MoveTo(humanoidRootPart.Position)
									return
								end

								spawn_ = spawn_ and spawn_:FindFirstChild("Part")
								if not spawn_ then
									tbl25.AutoPlay.Jump(false)
									return
								end

								if tbl25.AutoPlay.Character ~= character or not tbl25.AutoPlay.LobbyTarget then
									local lobbySpawnPlate = workspace:FindFirstChild("LobbySpawnPlate")
									lobbySpawnPlate = lobbySpawnPlate and lobbySpawnPlate:FindFirstChild("DO_NOT_DELETE")
									lobbySpawnPlate = lobbySpawnPlate and lobbySpawnPlate.Position - spawn_.Position or humanoidRootPart.Position - spawn_.Position
									local vector = Vector3.new(lobbySpawnPlate.X, 0, lobbySpawnPlate.Z)
									local unit = vector.Magnitude > v85[22] and vector.Unit or Vector3.zAxis
									local vector2 = Vector3.new(-unit.Z, 0, unit.X)
									tbl25.AutoPlay.Character = character
									tbl25.AutoPlay.LobbySettling = v85[101]
									tbl25.AutoPlay.LobbyJumpAt = now2 + math.random()
									tbl25.AutoPlay.LobbyJumpUntil = nil
									local x = spawn_.Size.X
									tbl25.AutoPlay.LobbyTarget = spawn_.Position + unit * (8 + math.random() * 10) + vector2 * (math.random() - 0.5) * x * 0.65
								end

								local lobbyTarget = tbl25.AutoPlay.LobbyTarget
								local vector = Vector3.new(lobbyTarget.X, humanoidRootPart.Position.Y, lobbyTarget.Z)

								if (Vector3.new(vector.X, 0, vector.Z) - Vector3.new(humanoidRootPart.Position.X, v85[33], humanoidRootPart.Position.Z)).Magnitude > 2.5 then
									if (tbl25.AutoPlay.LobbyJumpAt or 0) <= now2 then
										tbl25.AutoPlay.LobbyJumpAt = now2 + 1.2 + math.random() * 2
										tbl25.AutoPlay.LobbyJumpUntil = now2 + 0.45
										local v109 = v85[81]
										tbl25.AutoPlay.LobbyDouble = math.random() < v109
									end

									tbl25.AutoPlay.Jump(now2 < (tbl25.AutoPlay.LobbyJumpUntil or 0), tbl25.AutoPlay.LobbyDouble)
									humanoid:MoveTo(vector)
								elseif not tbl25.AutoPlay.LobbySettling then
									local vector2 = Vector3.new(humanoidRootPart.Position.X - spawn_.Position.X, v85[33], humanoidRootPart.Position.Z - spawn_.Position.Z)
									local unit = vector2.Magnitude > 0.1 and vector2.Unit or Vector3.zAxis
									local vector3 = Vector3.new(-unit.Z, 0, unit.X)
									tbl25.AutoPlay.LobbySettling = true
									local autoPlay = tbl25.AutoPlay
									local position = humanoidRootPart.Position
									local v109 = v85[33]
									autoPlay.LobbyTarget = position + vector3 * (math.random(0, 1) == v109 and -v85[18] or 1) * (v85[61] + math.random() * 4) + unit * (math.random() - 0.5) * 3
								else
									tbl25.AutoPlay.Jump(false)
									humanoid:MoveTo(humanoidRootPart.Position)
								end

								return
							end

							if not alive or character.Parent ~= alive then
								tbl25.AutoPlay.Jump(false)
								return
							end

							if not tbl25.AutoPlay.InMatch then
								tbl25.AutoPlay.InMatch = v85[200]
								table.clear(tbl25.AutoPlay.Voting)
								tbl25.AutoPlay.MatchHadOpponent = v85[101]
								tbl25.AutoPlay.WonLast = false
								tbl25.AutoPlay.LobbyDecided = false
								tbl25.AutoPlay.LobbyIdle = nil
								tbl25.AutoPlay.ClashUntil = nil
								tbl25.AutoPlay.ChaseUntil = nil
								tbl25.AutoPlay.ClashDistance = nil
								tbl25.AutoPlay.ClashMoveAt = nil
								tbl25.AutoPlay.ClashTarget = nil
								tbl25.AutoPlay.Opponent = nil
								tbl25.AutoPlay.OpponentUntil = nil
								tbl25.AutoPlay.LastMove = nil
								tbl25.AutoPlay.Home = nil
								tbl25.AutoPlay.Anchor = nil
								tbl25.AutoPlay.AnchorAt = nil
								tbl25.AutoPlay.EndAt = nil
							end

							local v109, v110, v111 = fn60(character, humanoidRootPart.Position)
							local opponent = tbl25.AutoPlay.Opponent
							local parent = opponent and opponent.Parent

							if parent then
								parent = now2 < (tbl25.AutoPlay.OpponentUntil or 0)
							end

							if parent then
								local magnitude = (humanoidRootPart.Position - opponent.Position).Magnitude

								if magnitude <= v109 + 2.5 then
									v110 = opponent
									v109 = magnitude
								end
							end

							if v110 ~= tbl25.AutoPlay.Opponent then
								tbl25.AutoPlay.Opponent = v110
								tbl25.AutoPlay.OpponentUntil = now2 + 0.65
							end

							if v111 > 1 then
								tbl25.AutoPlay.MatchHadOpponent = v85[200]
							elseif tbl25.AutoPlay.MatchHadOpponent then
								tbl25.AutoPlay.WonLast = true
							end

							if v111 <= 1 then
								tbl25.AutoPlay.EndAt = tbl25.AutoPlay.EndAt or now2 + 0.5 + math.random() * 0.7

								if tbl25.AutoPlay.EndAt <= now2 then
									tbl25.AutoPlay.Jump(false)
									humanoid:MoveTo(humanoidRootPart.Position)
									return
								end
							else
								tbl25.AutoPlay.EndAt = nil
							end

							tbl25.AutoPlay.Character = character
							tbl25.AutoPlay.LobbyTarget = nil
							tbl25.AutoPlay.LobbySettling = nil
							tbl25.AutoPlay.Jump(tbl20.SpamJump, v85[200])
							local map = workspace:FindFirstChild("Map")

							if tbl25.AutoPlay.Map ~= map or tbl25.AutoPlay.Mode ~= tbl20.AutoPlayMode or not tbl25.AutoPlay.Floor or not tbl25.AutoPlay.Floor.Parent then
								tbl25.AutoPlay.Map = map
								tbl25.AutoPlay.Mode = tbl20.AutoPlayMode
								tbl25.AutoPlay.Floor = map and map:FindFirstChild("FLOOR", true)
								tbl25.AutoPlay.Spawn = tbl20.AutoPlayMode ~= "Play Edge" and map and map:FindFirstChild("BALLSPAWN", v85[200])
								tbl25.AutoPlay.Raycast = nil
								tbl25.AutoPlay.Home = nil
								tbl25.AutoPlay.Anchor = nil

								if tbl25.AutoPlay.Floor then
									local raycastParams = RaycastParams.new()
									raycastParams.FilterType = Enum.RaycastFilterType.Include
									raycastParams.FilterDescendantsInstances = { tbl25.AutoPlay.Floor:FindFirstAncestorOfClass("Model") or map }
									raycastParams.RespectCanCollide = v85[200]
									raycastParams.IgnoreWater = true
									tbl25.AutoPlay.Raycast = raycastParams
								end
							end

							local floor2 = tbl25.AutoPlay.Floor
							if not floor2 or not floor2:IsA("BasePart") then
								return
							end
							local n33 = fn59() / 1000
							local middle = tbl25.AutoPlay.Middle
							local middle2 = tbl20.AutoPlayMode == "Play Middle"

							if tbl20.AutoPlayMode == "Mix" then
								local flag19 = tbl25.AutoPlay.Middle == nil

								if not flag19 then
									flag19 = now2 >= (tbl25.AutoPlay.MixAt or 0)
								end

								if flag19 then
									local n34 = v111 <= 2 and 0.8

									if not n34 then
										n34 = math.clamp(0.55 - n33 * 2 - math.max(v111 - v85[153], 0) * 0.04 + ((not v110 or v109 > 28) and 0.12 or 0), 0.35, 0.75)
									end

									tbl25.AutoPlay.Middle = math.random() < n34
									tbl25.AutoPlay.MixAt = now2 + 4 + math.random() * 4
								end

								middle2 = tbl25.AutoPlay.Middle
							end

							if middle ~= middle2 then
								tbl25.AutoPlay.Middle = middle2
								tbl25.AutoPlay.Home = nil
								tbl25.AutoPlay.Anchor = nil
							end

							local spawn_ = tbl25.AutoPlay.Spawn
							spawn_ = middle2 and spawn_ and spawn_:IsA("BasePart") and spawn_ or floor2
							local vector = Vector3.new(spawn_.Position.X, humanoidRootPart.Position.Y, spawn_.Position.Z)
							local vector2 = Vector3.new(humanoidRootPart.Position.X - vector.X, 0, humanoidRootPart.Position.Z - vector.Z)
							local unit = vector2.Magnitude > 1 and vector2.Unit or Vector3.xAxis
							local n34 = middle2 and math.max(spawn_.Size.X, spawn_.Size.Z) or v85[33]
							local n35 = math.min(floor2.Size.X, floor2.Size.Z) * (middle2 and 0.13 or 0.31)
							local n36 = middle2 and math.max(n34 * 0.75, humanoid.WalkSpeed * 0.45) or v85[33]
							local direction = tbl25.AutoPlay.Direction
							local n37 = Vector3.new(-unit.Z, 0, unit.X) * direction
							local n38 = vector + unit * n35
							local n39 = math.clamp((tbl20.AutoPlayAggressiveness or v85[195]) / 100, 0.01, 1)
							local n40 = (18 + humanoid.WalkSpeed * n33 * (8 + math.min(math.max(v111 - 2, 0), 4))) * (1 + (0.45 - n39) * (n39 > 0.45 and 1.18 or 0.5))
							local flag19 = v110 and v109 < n40

							if not tbl25.AutoPlay.Home then
								local autoPlay = tbl25.AutoPlay
								local n41 = humanoid.WalkSpeed * 0.5
								autoPlay.Home = math.abs(vector2.Magnitude - n35) > n41 and n38 or humanoidRootPart.Position
								tbl25.AutoPlay.Anchor = tbl25.AutoPlay.Home
								tbl25.AutoPlay.AnchorAt = now2
							end

							local vector3

							if flag19 then
								local n41 = humanoidRootPart.Position - v110.Position
								local vector4 = Vector3.new(n41.X, v85[33], n41.Z)
								vector3 = nil

								if vector4.Magnitude > 0.1 then
									local direction2 = tbl25.AutoPlay.Direction
									local unit2 = (vector4.Unit + Vector3.new(-vector4.Unit.Z, 0, vector4.Unit.X) * direction2 * 0.55).Unit
									local n42 = math.min(n40 - v109 + humanoid.WalkSpeed * 0.25, humanoid.WalkSpeed)
									local home = humanoidRootPart.Position + unit2 * n42
									local vector5 = Vector3.new(home.X - vector.X, 0, home.Z - vector.Z)
									local n43 = n35 + humanoid.WalkSpeed * 0.45

									if n43 < vector5.Magnitude then
										local n44 = vector5.Unit * n43
										home = Vector3.new(vector.X, humanoidRootPart.Position.Y, vector.Z) + n44
									elseif middle2 and vector5.Magnitude < n36 then
										home = vector + (vector5.Magnitude > v85[22] and vector5.Unit or unit) * n36
									end

									local n44 = home - humanoidRootPart.Position
									vector3 = Vector3.new(n44.X, v85[33], n44.Z)

									if vector3.Magnitude < v85[18] then
										vector3 = (n37 - unit * v85[64]).Unit * n42
										home = humanoidRootPart.Position + vector3
									end

									tbl25.AutoPlay.Home = home
									tbl25.AutoPlay.Anchor = tbl25.AutoPlay.Home
								end
							else
								local anchor = tbl25.AutoPlay.Anchor or humanoidRootPart.Position
								local flag20 = (Vector3.new(anchor.X, 0, anchor.Z) - Vector3.new(humanoidRootPart.Position.X, 0, humanoidRootPart.Position.Z)).Magnitude < 1.5

								if not flag20 then
									flag20 = now2 >= (tbl25.AutoPlay.AnchorAt or v85[33])
								end

								vector3 = nil

								if flag20 then
									local v112 = v85[64]

									if math.random() < v112 then
										tbl25.AutoPlay.Direction = -tbl25.AutoPlay.Direction
										n37 = -n37
									end

									tbl25.AutoPlay.AnchorAt = now2 + 0.6 + math.random() * 0.8
									local walkSpeed = humanoid.WalkSpeed
									tbl25.AutoPlay.Anchor = tbl25.AutoPlay.Home + n37 * humanoid.WalkSpeed * (0.2 + math.random() * 0.25) + unit * (math.random() - 0.5) * walkSpeed * 0.25
									vector3 = nil
								end
							end

							local n41 = (tbl25.AutoPlay.Anchor or tbl25.AutoPlay.Home) - humanoidRootPart.Position
							local vector4 = Vector3.new(n41.X, v85[33], n41.Z)
							local unit2 = vector4.Magnitude > 2 and vector4.Unit or Vector3.zero
							local flag20 = now2 >= (flyteBBState.ParryActiveUntil or v85[33])

							if flag20 then
								flag20 = now2 < (flyteBBState.ParryCooldownUntil or 0)
							end

							local unit3 = nil
							local unit4 = nil

							if not fn48(character) then
								unit3 = nil
								unit4 = nil

								for _, v112 in tbl25.Ball.GetAllBalls() do
									local v113 = fn58(v112)
									local magnitude = fn55(v112).Magnitude
									local name = localPlayer.Name
									local flag21 = fn51(v112) == name
									local hitFreeze = tbl20.HitFreeze and flag21

									if hitFreeze then
										local v114 = v85[200]
										hitFreeze = v112:GetAttribute("Frozen") == v114
									end

									if flag21 and flag20 then
										local n42 = humanoidRootPart.Position - fn54(v112)
										local vector5 = Vector3.new(n42.X, 0, n42.Z)

										if vector5.Magnitude > 0.1 then
											unit3 = vector5.Unit
											unit4 = nil
											break
										else
											unit3 = nil
											unit4 = nil
										end
									else
										if flag21 then
											flag21 = (v113.TargetChanges or 0) <= 1 and magnitude <= humanoid.WalkSpeed or hitFreeze
										end

										if flag21 then
											local position = humanoidRootPart.Position
											local n42 = fn54(v112) - position
											local vector5 = Vector3.new(n42.X, v85[33], n42.Z)

											if not (vector5.Magnitude > 0.1) then
												unit3 = nil
												unit4 = nil
											else
												unit4 = vector5.Unit
												unit3 = nil
												break
											end
										else
											unit3 = nil
											unit4 = nil
										end
									end
								end
							end

							if v110 and not unit3 then
								local n42 = math.clamp((n40 - v109) / n40, 0, v85[18])

								if n42 > v85[33] and vector3 and vector3.Magnitude > v85[22] then
									unit2 = unit2:Lerp(vector3.Unit, n42)
								end

								local n43 = math.clamp(math.clamp(1 - n33 / v85[22], 0, 1) * (0.6 + n39 * 0.4) + n39 * 0.25 + math.max(n39 - 0.45, 0) * 0.5, 0, 1)

								if (tbl25.AutoPlay.PressureAt or v85[33]) <= now2 then
									local n44 = math.clamp(n39 / 0.45, 0.65, 2)
									local min = math.min
									local n45 = v111 == 2 and 0.3 + n43 * 0.35 or n43 * 0.45
									local v112 = v85[18]
									local v113 = min(n45 * math.clamp(n44, 0.55, 1.8), v112)
									tbl25.AutoPlay.PressureAt = now2 + ((v111 == 2 and 2.5 or 3) + math.random() * 3) / n44
									tbl25.AutoPlay.PressureUntil = math.random() < v113 and now2 + (0.65 + math.random() * 0.55) * math.clamp(n44, 0.75, v85[122]) or 0
								end

								local flag21 = n42 == 0

								if flag21 then
									flag21 = now2 < (tbl25.AutoPlay.PressureUntil or 0)
								end

								if flag21 and v109 < n40 * (2 + n39) then
									local n44 = v110.Position - humanoidRootPart.Position
									unit2 = unit2:Lerp(Vector3.new(n44.X, v85[33], n44.Z).Unit, 0.35 + n43 * v85[139])
								end

								if v111 == 2 then
									local autoSpamEnabled = tbl20.AutoSpamEnabled

									if autoSpamEnabled then
										autoSpamEnabled = now2 - (flyteBBState.AutoSpamAt or v85[33]) < v85[113]
									end

									if not autoSpamEnabled then
										autoSpamEnabled = tbl20.ManualSpamEnabled

										if autoSpamEnabled then
											autoSpamEnabled = now2 - (flyteBBState.ManualSpamAt or 0) < 0.2
										end
									end

									if autoSpamEnabled then
										local flag22 = now2 >= (tbl25.AutoPlay.ClashUntil or 0)
										tbl25.AutoPlay.ClashUntil = now2 + 0.4

										if not flag22 and tbl25.AutoPlay.ClashDistance and v109 > tbl25.AutoPlay.ClashDistance + 0.3 then
											tbl25.AutoPlay.ChaseUntil = now2 + 0.9
										end

										if flag22 then
											tbl25.AutoPlay.ClashMoveAt = nil
											tbl25.AutoPlay.ClashTarget = nil
										end

										tbl25.AutoPlay.ClashDistance = v109
									end

									if now2 < (tbl25.AutoPlay.ClashUntil or 0) then
										local n44 = v110.Position - humanoidRootPart.Position
										local vector5 = Vector3.new(n44.X, 0, n44.Z)
										local flag22 = vector5.Magnitude > 0.1

										if flag22 then
											flag22 = v109 > 9

											if not flag22 then
												flag22 = now2 < (tbl25.AutoPlay.ChaseUntil or 0)
											end
										end

										if flag22 then
											local position = v110.Position
											middle2 = middle2 and vector2.Magnitude < n36 + 12 and vector5.Unit:Dot(unit) < 0

											if middle2 then
												position = humanoidRootPart.Position + (n37 + unit * 0.25).Unit * v85[49]
											end

											humanoid:MoveTo(position)
										else
											if (tbl25.AutoPlay.ClashMoveAt or 0) <= now2 then
												tbl25.AutoPlay.ClashMoveAt = now2 + 0.35 + math.random() * 0.5
												tbl25.AutoPlay.ClashTarget = humanoidRootPart.Position + (vector5.Magnitude > 0.1 and Vector3.new(-vector5.Z, 0, vector5.X).Unit or Vector3.zero) * (math.random(3) == 1 and math.random(-2, 2) or 0)
											end

											humanoid:MoveTo(tbl25.AutoPlay.ClashTarget or humanoidRootPart.Position)
										end

										return
									end
								end
							end

							if unit3 then
								unit2 = unit3
							elseif unit4 then
								unit2 = (unit4 * 0.9 + n37 * 0.1).Unit
							end

							if unit2.Magnitude > 0.1 then
								local unit5 = unit2.Unit

								if middle2 and vector2.Magnitude < n36 + 12 and unit5:Dot(unit) < 0 then
									unit5 = (n37 + unit * 0.25).Unit
								end

								local hit = tbl25.AutoPlay.Raycast and workspace:Raycast(humanoidRootPart.Position, unit5 * 12, tbl25.AutoPlay.Raycast)

								if hit then
									local vector5 = Vector3.new(hit.Normal.X, 0, hit.Normal.Z)

									if v85[22] < vector5.Magnitude then
										local unit6 = vector5.Unit
										local vector6 = Vector3.new(-unit6.Z, 0, unit6.X)

										if vector6:Dot(unit5) < 0 then
											vector6 = -vector6
										end

										unit5 = (vector6 + unit6 * 0.35).Unit
									end
								end

								if not unit4 and not unit3 and tbl25.AutoPlay.LastMove and tbl25.AutoPlay.LastMove:Dot(unit5) > -0.6 then
									local clamp = math.clamp
									local autoPlaySmoothness = tbl20.AutoPlaySmoothness or 50
									local v112 = v85[18]
									local n42 = 0.82 - (clamp(autoPlaySmoothness, 1, 100) - v112) / 99 * 0.48

									if flag19 then
										n42 = math.min(n42 + 0.18, 0.9)
									end

									local v113 = tbl25.AutoPlay.LastMove:Lerp(unit5, n42)

									if v85[22] < v113.Magnitude then
										unit5 = v113.Unit
									end
								end

								tbl25.AutoPlay.LastMove = unit5
								humanoid:MoveTo(humanoidRootPart.Position + unit5 * 12)
							else
								tbl25.AutoPlay.LastMove = nil
								humanoid:MoveTo(humanoidRootPart.Position)
							end
						end

						tbl25.AutoPlay.Toggle = function(autoPlayEnabled)
							tbl20.AutoPlayEnabled = autoPlayEnabled
							tbl25.AutoPlay.Stop()

							if autoPlayEnabled then
								flyteBBState.Connections["Auto Play"] = v88.PreSimulation:Connect(tbl25.AutoPlay.Step)
							end
						end

						fn43({ AvatarEnabled = false, AvatarUser = "", KHEnabled = false })

						tbl25.LoadRewards = function()
							local rewards = { Items = {} }
							tbl25.Rewards = rewards
							local controllers = v93.Controllers
							local InfiniteBattlepassData = require(v93.Shared.InfiniteBattlepass.InfiniteBattlepassData)
							local rewards2 = nil
							local BattlepassPlaytimeRewardsData = nil
							local Quests = nil
							local tbl26 = {}
							local tbl27 = {}

							local function fn73(...)
								local playerGui = localPlayer.PlayerGui

								for _, v109 in { ... }, nil, nil do
									playerGui = playerGui:FindFirstChild(v109)
									if not playerGui then
										return
									end
								end

								return playerGui
							end

							rewards.Notify = function(arg, arg2)
								local v109 = tbl24 and tbl24.toggles[arg]

								if flyteBBState.Loaded and tbl20[arg] and v109 and v109.notify and type(arg2) == "string" and arg2 ~= "" then
									v103:Notify({ Title = "Got " .. arg2 })
								end
							end

							local function fn74(arg, arg2, arg3, arg4, arg5)
								fn43({ [arg] = false })
								rewards.Items[#rewards.Items + 1] = { ID = arg, Name = arg2, Run = arg3, Interval = arg4 or 5, Next = 0, Notify = arg5 }
							end

							local function fn75(arg, arg2, arg3, arg4, arg5, arg6)
								if not arg2 or not arg2.Visible or tbl26[arg2] then
									return false
								end
								local v109 = getconnections
								local str5 = arg6 or "Activated"

								for _, v110 in v109(arg2[str5]) do
									if v110.Enabled and v110.Function and getfenv(v110.Function).script == arg3 then
										tbl26[arg2] = { ID = arg, Check = arg4, Names = arg5 }
										v110:Fire()
										return v85[200]
									end
								end

								return v85[101]
							end

							fn74("Claim_Daily_Rewards", "Auto Claim Daily", function()
								local CurrentDailyLoginType = Data:Get("CurrentDailyLoginType")
								local v109 = Data:Get({ "DailyLoginData", CurrentDailyLoginType })
								local flag19 = (CurrentDailyLoginType == "D30" or CurrentDailyLoginType == "Longterm") and v109 and type(v109.NextClaim) == "number"

								if flag19 then
									local nextClaim = v109.NextClaim
									flag19 = workspace:GetServerTimeNow() >= nextClaim
								end

								if flag19 then
									local claim = fn73("DailyLogin_" .. CurrentDailyLoginType .. "_Rewards")

									if claim then
										local flag20 = CurrentDailyLoginType == "D30" and claim.Page.Rewards:FindFirstChild("Day" .. v109.DaysClaimedStreak + 1, true)

										if flag20 then
											claim = flag20
										else
											claim = CurrentDailyLoginType == "Longterm" and claim.Frame.Claim
										end
									end

									local nextClaim = v109.NextClaim

									fn75("Claim_Daily_Rewards", claim, controllers.UI.DailyLoginController, function()
										return Data:Get({ "DailyLoginData", CurrentDailyLoginType, "NextClaim" }) ~= nextClaim
									end)
								end

								local BattlepassDailyLogin = InfiniteBattlepassData.isEnabled() and fn73("BattlepassDailyLogin", "Background", v85[170], "ScrollingFrame")

								if BattlepassDailyLogin then
									for _, v110 in BattlepassDailyLogin:GetChildren() do
										if v110:GetAttribute("State") == "Claimable" then
											local num = tonumber(v110.Day.Text:match("%d+"))

											if num then
												fn75("Claim_Daily_Rewards", v110.Claim, localPlayer.PlayerScripts.Client.UIBinders.BattlepassDailyLogin, function()
													return table.find(Data:Get("NewDailyLoginAwardList") or {}, num) ~= nil
												end)
											end

											break
										end
									end
								end

								local WelcomeBackEvent = Data:Get("WelcomeBackEvent")
								local flag20

								if WelcomeBackEvent then
									flag20 = workspace:GetServerTimeNow() < (WelcomeBackEvent.EventEndTime or v85[33])
								else
									flag20 = WelcomeBackEvent
								end

								flag20 = flag20 and fn73("NewWelcomeBack", "Frame", "Views", "Login", "Days")

								if flag20 then
									for _, v110 in flag20:GetChildren() do
										local claim = v110:FindFirstChild("Claim")
										local layoutOrder = claim and v110.LayoutOrder

										if claim and claim.Visible and layoutOrder <= WelcomeBackEvent.DailyLoginStreak and not WelcomeBackEvent.ClaimedDailyRewards[layoutOrder] then
											fn75("Claim_Daily_Rewards", claim, controllers.WelcomeBackController.EventControllers.Login, function()
												local WelcomeBackEvent2 = Data:Get("WelcomeBackEvent")
												return WelcomeBackEvent2 and WelcomeBackEvent2.ClaimedDailyRewards[layoutOrder] == true
											end, nil, "MouseButton1Click")

											break
										end
									end
								end
							end)

							fn74("Claim_Playtime_Rewards", "Auto Claim Playtime", function()
								rewards2 = rewards2 or require(v93.Common.PlaytimeRewardsInfo).Rewards
								BattlepassPlaytimeRewardsData = BattlepassPlaytimeRewardsData or require(v93.Shared.Battlepass.BattlepassPlaytimeRewardsData)
								Quests = Quests or require(v93.Shared.Quests)
								local PlaytimeRewardsData = Data:Get("PlaytimeRewardsData")

								if PlaytimeRewardsData then
									for k, v109 in rewards2, nil, nil do
										local flag19 = not PlaytimeRewardsData.ClaimedRewards[tostring(k)]

										if flag19 then
											local n33 = PlaytimeRewardsData.TimerStart + v109.Duration
											flag19 = workspace:GetServerTimeNow() >= n33
										end

										if flag19 then
											local playtimeRewardsController = controllers.UI.PlaytimeRewardsController

											fn75("Claim_Playtime_Rewards", fn73("PlaytimeRewards", "PlaytimeRewards", "Page", "List", "RewardsList", tostring(k), "ClaimButton"), playtimeRewardsController, function()
												return Data:Get({ "PlaytimeRewardsData", "ClaimedRewards", tostring(k) }) == true
											end)

											break
										end
									end
								end

								if InfiniteBattlepassData.isEnabled() then
									local ClaimedPlaytimeRewards = Data:Get("ClaimedPlaytimeRewards") or {}

									for k, v109 in BattlepassPlaytimeRewardsData, nil, nil do
										if v109.Seconds <= (Data:Get("SecondsPlayedToday") or 0) and not table.find(ClaimedPlaytimeRewards, k) then
											local BattlepassPlaytimeRewards = fn73("BattlepassPlaytimeRewards", "PlaytimeRewards", "MainFrame", "Grid", tostring(k))

											fn75("Claim_Playtime_Rewards", BattlepassPlaytimeRewards and BattlepassPlaytimeRewards.Claim.Claim, controllers.Battlepass.BattlepassPlaytimeRewardsController, function()
												return table.find(Data:Get("ClaimedPlaytimeRewards") or {}, k) ~= nil
											end)

											break
										end
									end
								end

								local CurrentQuests = Data:Get("CurrentQuests") or {}

								for _, v109 in CurrentQuests, nil, nil do
									local flag19 = Quests[v109]

									if flag19 then
										flag19 = (Data:Get({ "QuestStats", flag19.stat }) or 0) >= flag19.goal
									end

									if flag19 then
										flag19 = not table.find(Data:Get("QuestsAwarded") or {}, v109)
									end

									if flag19 then
										local questsController = controllers.UI.QuestsController

										fn75("Claim_Playtime_Rewards", fn73("NewDailyQuests", "Holder", "Quests", v109, "Intermediate"), questsController, function()
											return table.find(Data:Get("QuestsAwarded") or {}, v109) ~= nil
										end)
									end
								end
							end)

							if InfiniteBattlepassData.isEnabled() then
								fn74("Claim_Battlepass_Rewards", "Auto Claim Battlepass", function()
									if not InfiniteBattlepassData.isEnabled() then
										return
									end
									local Battlepass = fn73("Battlepass", "Main", "Background", "Left", "ClaimAll")
									if not Battlepass or not Battlepass.Visible or tbl26[Battlepass] then
										return
									end
									local InfiniteBattlepass = Data:Get("InfiniteBattlepass")
									local tbl28 = {}
									local getTierFromXP = InfiniteBattlepassData.SeasonData.Rewards.getTierFromXP
									local xp = InfiniteBattlepass.Quests.XP or v85[33]

									for i = 1, getTierFromXP(xp) do
										local v109 = InfiniteBattlepassData.SeasonData.Rewards.getReward(i, localPlayer)

										for _, v110 in { "Free", "Premium" }, nil, nil do
											if v109 and v109[v110:lower()] and (v110 == "Free" or InfiniteBattlepass.Premium == true) and not InfiniteBattlepass.Claimed[v110][tostring(i)] then
												tbl28[#tbl28 + 1] = { v110, tostring(i) }
											end
										end
									end

									if #tbl28 == 0 then
										return
									end

									fn75("Claim_Battlepass_Rewards", Battlepass, controllers.Battlepass.BattlepassTierController, function()
										local Claimed = Data:Get("InfiniteBattlepass.Claimed")

										for _, v109 in tbl28, nil, nil do
											if not Claimed[v109[1]][v109[2]] then
												return false
											end
										end

										return true
									end)
								end)
							end

							fn74("Auto_Wheel_Spins", "Auto Spin Wheel", function()
								local rolls = Data:Get("rolls") or v85[33]
								if rolls <= 0 then
									return
								end
								local Wheel = fn73("Wheel", "Default")
								if not Wheel or Wheel:GetAttribute("Spinning") then
									return
								end
								local wheelMenu = Wheel.WheelMenu

								fn75("Auto_Wheel_Spins", wheelMenu.Button.SpinButton, Wheel.SpinWheelClient, function()
									return (Data:Get("rolls") or v85[33]) < rolls and not Wheel:GetAttribute("Spinning")
								end, function()
									return wheelMenu.Win.Text:match("^You won (.-)!$")
								end)
							end, 12, v85[200])

							if InfiniteBattlepassData.isEnabled() then
								local flag19 = require(v93.Shared.BattlepassUIType) == "Window"

								local function fn76(spinID, arg)
									if not InfiniteBattlepassData.isEnabled() or Data:Get("InfiniteBattlepass.UseSteps") then
										return
									end

									if os.clock() < (rewards.SpinUntil or 0) then
										return
									end
									local n33 = Data:Get("InfGachaRounds" .. InfiniteBattlepassData.Season) or 0

									if arg then
										local flag20 = n33 > 0 or InfiniteBattlepassData.SeasonData.Currency.Name ~= "Gold"

										if not flag20 then
											local v109 = v85[200]
											flag20 = Data:Get("CanPurchaseInfGachaRounds" .. InfiniteBattlepassData.Season .. "DailyExtra") ~= v109
										end

										if not flag20 then
											flag20 = (Data:Get("InfiniteBattlepass.Currency") or v85[33]) < 400
										end

										if flag20 then
											return
										end
									elseif n33 <= 0 then
										return
									end

									local BattlepassSpinGacha = flag19 and fn73("BattlepassSpinGacha", "Main") or fn73("Battlepass", "Main", "Background", "Views", "SpinGacha")
									local v109 = rewards
									local v110 = rewards
									local v111 = v85[147]
									local spinUntil = os.clock() + v111
									v109.SpinID = spinID
									v110.SpinUntil = spinUntil

									if not fn75(spinID, BattlepassSpinGacha and BattlepassSpinGacha.Background.Spin.Spin, controllers.Battlepass.BattlepassSpinGachaController, function()
										local flag20 = arg and Data:Get("CanPurchaseInfGachaRounds" .. InfiniteBattlepassData.Season .. "DailyExtra") ~= true

										if not flag20 then
											flag20 = not arg

											if flag20 then
												flag20 = (Data:Get("InfGachaRounds" .. InfiniteBattlepassData.Season) or v85[33]) < n33
											end
										end

										return flag20
									end) then
										local v112 = rewards
										rewards.SpinID = nil
										v112.SpinUntil = nil
									end
								end

								fn74("Auto_Battlepass_Spins", "Auto Battlepass", function()
									fn76("Auto_Battlepass_Spins", false)
								end, 12, true)

								fn74("Auto_Gold_Spin", "Auto Kraken Spin", function()
									fn76("Auto_Gold_Spin", v85[200])
								end, v85[49], v85[200])
							end

							rewards.Step = function()
								for k, v109 in tbl26, nil, nil do
									if v109.Check() then
										tbl26[k] = nil
										rewards.Notify(v109.ID, type(v109.Names) == "function" and v109.Names() or v109.Names)
									elseif not k.Parent then
										tbl26[k] = nil
									end
								end

								for _, v109 in rewards.Items, nil, nil do
									local flag19 = tbl20[v109.ID]

									if flag19 then
										local next_ = v109.Next
										flag19 = os.clock() >= next_
									end

									if flag19 then
										local interval = v109.Interval
										v109.Next = os.clock() + interval

										if not pcall(v109.Run) then
											v109.Next = os.clock() + 30
										end
									end
								end
							end

							rewards.Toggle = function()
								if not flyteBBState.Loaded then
									return
								end
								local flag19 = v85[101]

								for _, v109 in rewards.Items, nil, nil do
									if tbl20[v109.ID] then
										flag19 = true
										break
									end
								end

								if not flag19 then
									fn42("Rewards")
									return
								end

								if flyteBBState.Connections.Rewards then
									return
								end
								local rewards3 = {}
								flyteBBState.Connections.Rewards = rewards3

								rewards3.Results = v93.Remote.RemoteEvent.OnClientEvent:Connect(function(arg, arg2, arg3)
									local spinID = rewards.SpinID

									if spinID then
										local spinUntil = rewards.SpinUntil
										spinID = os.clock() <= spinUntil
									end

									if spinID and type(arg3) == "table" then
										if arg == "GachaSpinStartBottom" then
											local v109 = tbl27
											local gachaSpinEndBottom = {}
											local spinID2 = rewards.SpinID
											local displayName = arg3.DisplayName or arg3.ItemName
											gachaSpinEndBottom[1] = spinID2
											gachaSpinEndBottom[2] = displayName
											v109.GachaSpinEndBottom = gachaSpinEndBottom
										elseif arg == "GachaSpinStartTop" then
											local v109 = tbl27
											local gachaSpinEndTop = {}
											local spinID2 = rewards.SpinID
											local displayName = arg3.DisplayName or arg3.ItemName
											gachaSpinEndTop[1] = spinID2
											gachaSpinEndTop[2] = displayName
											v109.GachaSpinEndTop = gachaSpinEndTop
										end
									end

									local v109 = tbl27[arg]

									if v109 then
										tbl27[arg] = nil
										rewards.Notify(v109[1], v109[2])
									end
								end)

								rewards3.Loop = task.spawn(function()
									while flyteBBState.Loaded and flyteBBState.Connections.Rewards == rewards3 do
										rewards.Step()
										task.wait(1)
									end
								end)
							end
						end

						tbl25.LoadRewards()

						tbl25.LoadAvatar = function()
							local flyteavatarcache1 = v93:FindFirstChild("flyteavatarcache1")

							if flyteavatarcache1 then
								flyteavatarcache1:Destroy()
							end

							local folder = Instance.new("Folder")
							folder.Name = "flyteavatarcache1"
							folder.Parent = v93
							local folder2 = Instance.new("Folder")
							folder2.Name = "Original"
							folder2.Parent = folder
							tbl23 = { Sources = {}, UserIDs = {}, SourceFolder = folder, Stash = folder2, Clones = {}, BindRun = 0 }
							local v109 = nil
							local v110 = nil
							local v111 = v85[33]
							local v112 = nil
							local v113 = nil

							tbl23.BindImage = function(arg, arg2)
								if not tbl23.Images or not arg or not arg2 or tbl23.Images[arg] then
									return
								end
								local tbl26 = { Original = arg.Image, Username = arg2 }
								tbl23.Images[arg] = tbl26

								tbl26.Update = function()
									local image = arg.Image

									if image ~= tbl26.Applied then
										tbl26.Original = image
									end

									if arg2.Text ~= "@" .. localPlayer.Name or tbl26.Original:match("^rbxthumb://type=AvatarHeadShot&id=(%d+)&") ~= tostring(localPlayer.UserId) then
										tbl26.Applied = nil
										return
									end
									tbl26.Applied = tbl26.Original:gsub("&id=%d+&", "&id=" .. v109 .. "&", 1)

									if image ~= tbl26.Applied then
										arg.Image = tbl26.Applied
									end
								end

								tbl26.ImageChanged = arg:GetPropertyChangedSignal("Image"):Connect(tbl26.Update)
								tbl26.UserChanged = arg2:GetPropertyChangedSignal("Text"):Connect(tbl26.Update)

								tbl26.Destroying = arg.Destroying:Connect(function()
									fn29(tbl26)

									if tbl23.Images then
										tbl23.Images[arg] = nil
									end
								end)

								tbl26.Update()
							end

							tbl23.UpdateImages = function()
								if tbl23.Images then
									for _, v114 in tbl23.Images, nil, nil do
										v114.Update()
									end

									return
								end

								tbl23.Images = {}

								local function fn73(arg)
									local parent = arg and arg.Parent
									if not parent then
										return
									end

									if arg.Name == "AvatarImage" and parent.Name == "PlayerHeader" then
										tbl23.BindImage(arg, parent:FindFirstChild("PlayerName", true))
									elseif arg.Name == "PlayerName" then
										local playerHeader = arg:FindFirstAncestor("PlayerHeader")

										if playerHeader then
											tbl23.BindImage(playerHeader:FindFirstChild("AvatarImage"), arg)
										end
									elseif arg.Name == "Player" and parent.Name == "PlayerProfile" then
										local details = parent:FindFirstChild("Details")
										tbl23.BindImage(arg, details and details:FindFirstChild("Username"))
									elseif arg.Name == "Username" and parent.Name == "Details" and parent.Parent.Name == "PlayerProfile" then
										tbl23.BindImage(parent.Parent:FindFirstChild("Player"), arg)
									end

									if not (n24 < 4731) then
										return
									end

									while true do
									end
								end

								local images = tbl23.Images

								local function fn74(descendant)
									if descendant.Name == "AvatarImage" or descendant.Name == "PlayerName" or descendant.Name == "Player" or descendant.Name == "Username" then
										task.defer(function()
											if tbl23.Images == images then
												pcall(fn73, descendant)
											end
										end)
									end
								end

								local tbl26 = { v104.DescendantAdded:Connect(fn74) }
								flyteBBState.Connections["Avatar Images"] = tbl26

								pcall(function()
									tbl26[#tbl26 + 1] = v94.DescendantAdded:Connect(fn74)
									local playerHeader = v94:FindFirstChild("PlayerHeader", true)

									if playerHeader then
										fn73(playerHeader:FindFirstChild("AvatarImage"))
									end
								end)

								local profileCard = v104:FindFirstChild("ProfileCard")
								profileCard = profileCard and profileCard:FindFirstChild("PlayerProfile", true)

								if profileCard then
									fn73(profileCard:FindFirstChild("Player"))
								end
							end

							tbl23.RestoreImages = function()
								fn42("Avatar Images")
								local images = tbl23.Images
								tbl23.Images = nil
								local tbl26 = images or {}

								for k, v114 in tbl26, nil, nil do
									fn29(v114)

									pcall(function()
										if v114.Applied and k.Image == v114.Applied and v114.Username.Text == "@" .. localPlayer.Name then
											k.Image = v114.Original
										end
									end)
								end
							end

							tbl23.IsBodyAppearance = function(arg)
								return arg:IsA("Shirt") or arg:IsA("Pants") or arg:IsA("ShirtGraphic") or arg:IsA("BodyColors") or arg:IsA("CharacterMesh") or arg:IsA("Accoutrement")
							end

							tbl23.IsHeadAppearance = function(arg)
								return arg:IsA("Decal") or arg:IsA("SpecialMesh")
							end

							tbl23.GetInput = function()
								return string.match(tostring(tbl20.AvatarUser or ""), "^%s*(.-)%s*$")
							end

							tbl23.SearchCurrent = function(arg, arg2)
								local flag19 = tbl20.AvatarEnabled and arg == v111

								if flag19 then
									flag19 = arg2 == tbl23.GetInput():lower()
								end

								return flag19
							end

							tbl23.IsAppearanceReady = function(arg)
								return arg and (arg:GetAttribute("AppearanceLoaded") == true or arg == localPlayer.Character and localPlayer:HasAppearanceLoaded())
							end

							tbl23.GetUserID = function(arg)
								local v114 = string.match(tostring(arg or ""), "^%s*(.-)%s*$")
								if v114 == "" then
									return
								end
								local str5 = v114:lower()
								local v115 = tbl23.UserIDs[str5]
								if v115 then
									return v115
								end
								local num = tonumber(v114)

								if num then
									if num ~= num or num <= 0 or num == math.huge or num % v85[18] ~= v85[33] then
										return
									end
								else
									for _, v116 in v89:GetPlayers() do
										if v116.Name:lower() == str5 or v116.DisplayName:lower() == str5 then
											num = v116.UserId
											break
										end
									end

									num = num or v89:GetUserIdFromNameAsync(v114)
								end

								if num then
									tbl23.UserIDs[str5] = num
								end

								return num
							end

							tbl23.GetSource = function(arg)
								local v114 = tbl23.Sources[arg]
								if v114 and v114.Parent == folder then
									return v114
								end
								local ok, result = pcall(v89.GetHumanoidDescriptionFromUserIdAsync, v89, arg)
								if not ok or not result then
									return
								end
								local ok2, result2 = pcall(v89.CreateHumanoidModelFromDescriptionAsync, v89, result, Enum.HumanoidRigType.R6)
								result:Destroy()
								if not ok2 or not result2 then
									return
								end

								if not folder.Parent then
									result2:Destroy()
									return
								end

								for _, v115 in result2:GetDescendants() do
									if v115:IsA("LuaSourceContainer") then
										v115:Destroy()
									end
								end

								result2.Name = tostring(arg)
								result2.Parent = folder
								tbl23.Sources[arg] = result2
								return result2
							end

							tbl23.AddAccessory = function(arg, arg2)
								local parent = arg.Parent
								local handle = arg2:FindFirstChild("Handle")

								if not (not handle or not handle:IsA("BasePart")) then
									local accessoryWeld = handle:FindFirstChild("AccessoryWeld")
									local part1 = accessoryWeld and accessoryWeld:IsA("Weld") and accessoryWeld.Part1
									local c1 = nil
									local head = nil
									local c0 = nil

									if part1 then
										head = parent:FindFirstChild(accessoryWeld.Part1.Name)
										c0 = accessoryWeld.C0
										c1 = accessoryWeld.C1
									end

									local attachment = handle:FindFirstChildOfClass("Attachment")

									if not head and attachment then
										for _, v114 in parent:GetChildren() do
											if v114:IsA("BasePart") then
												local v115 = v114:FindFirstChild(attachment.Name)

												if v115 and v115:IsA("Attachment") then
													c0 = attachment.CFrame
													c1 = v115.CFrame
													head = v114
													break
												end
											end
										end
									elseif not head then
										head = parent:FindFirstChild("Head")
										c0 = arg2.AttachmentPoint
										c1 = CFrame.new(0, 0.5, 0)
									end

									if not head then
										arg2:Destroy()
										return
									end

									for _, v114 in arg2:GetDescendants() do
										if v114:IsA("JointInstance") or v114:IsA("WeldConstraint") then
											local flag19 = v114.Name == "AccessoryWeld" or v114.Part0 and not v114.Part0:IsDescendantOf(arg2)
											local flag20

											if flag19 then
												flag20 = flag19
											else
												flag20 = v114.Part1 and not v114.Part1:IsDescendantOf(arg2)
											end

											if flag20 then
												v114:Destroy()
											end
										elseif v114:IsA("BasePart") then
											v114.Anchored = v85[101]
											v114.CanCollide = false
											v114.Massless = true
										end
									end

									local cFrame = handle.CFrame
									local n33 = head.CFrame * c1 * c0:Inverse() * cFrame:Inverse()

									for _, v114 in arg2:GetDescendants() do
										if v114:IsA("BasePart") then
											v114.CFrame = n33 * v114.CFrame
										end
									end

									local weld = Instance.new("Weld")
									weld.Name = "AccessoryWeld"
									weld.Part0 = handle
									weld.Part1 = head
									weld.C0 = c0
									weld.C1 = c1
									weld.Parent = handle
									arg2.Parent = parent
									return
								end

								if n28(3904) < 277 then
									arg2:Destroy()
									return
								end

								while true do
								end
							end

							tbl23.ClearAdded = function()
								if not v112 then
									return
								end

								for _, v114 in v112.Added, nil, nil do
									v114:Destroy()
								end

								table.clear(v112.Added)
							end

							tbl23.DiscardKH = function()
								if not v113 then
									return
								end

								if v113.Korblox then
									v113.Korblox:Destroy()
								end

								for _, v114 in v113.LegMeshes, nil, nil do
									v114:Destroy()
								end

								v113 = nil
							end

							tbl23.DiscardAppearance = function()
								if not v112 then
									return
								end
								tbl23.ClearAdded()
								local visibility = v112.Visibility or {}

								for _, v114 in visibility, nil, nil do
									v114:Disconnect()
								end

								for _, v114 in v112.Original, nil, nil do
									v114.Object:Destroy()
								end

								v112 = nil
							end

							tbl23.CaptureAppearance = function(arg)
								if v112 and v112.Character == arg then
									return v112
								end
								tbl23.DiscardKH()
								tbl23.DiscardAppearance()
								v112 = tbl23.StoreAppearance(arg)
								return v112
							end

							tbl23.StoreAppearance = function(arg, arg2)
								local tbl26 = arg2 or { Character = arg, Original = {}, Added = {} }
								local torso = arg:FindFirstChild("Torso")

								if torso and not tbl26.Visibility then
									local function fn73()
										tbl23.UpdateVisibility(tbl26)
									end

									local visibility = {}
									local connection = torso:GetPropertyChangedSignal("Transparency"):Connect(fn73)
									local signal = torso:GetPropertyChangedSignal("LocalTransparencyModifier")
									local connect = signal.Connect
									visibility[1] = connection

									do
										local values = table.pack(connect(signal, fn73))
										table.move(values, 1, values.n, 2, visibility)
									end

									tbl26.Visibility = visibility
								end

								local v114 = table.clone(tbl26.Original)

								local function fn73(arg3, arg4)
									for i = #tbl26.Original, 1, -1 do
										local v115 = tbl26.Original[i]

										if table.find(v114, v115) and v115.Parent == arg4 and v115.Object.ClassName == arg3.ClassName and (not arg3:IsA("Accoutrement") or v115.Object.Name == arg3.Name) and (not arg3:IsA("CharacterMesh") or v115.Object.BodyPart == arg3.BodyPart) then
											v115.Object:Destroy()
											table.remove(tbl26.Original, i)
										end
									end

									tbl26.Original[#tbl26.Original + 1] = { Object = arg3, Parent = arg4 }
									arg3.Parent = folder2
								end

								for _, v115 in arg:GetChildren() do
									if tbl23.IsBodyAppearance(v115) then
										fn73(v115, arg)
									end
								end

								local head = arg:FindFirstChild("Head")

								if head then
									for _, v115 in head:GetChildren() do
										if tbl23.IsHeadAppearance(v115) then
											fn73(v115, head)
										end
									end
								end

								return tbl26
							end

							tbl23.CopyAppearance = function(arg, parent, arg2, arg3)
								local v114 = arg3 or v112
								v114.Transparency = {}

								for _, v115 in arg:GetChildren() do
									if tbl23.IsBodyAppearance(v115) then
										local clone = v115:Clone()
										v114.Added[#v114.Added + 1] = clone

										if clone:IsA("Accoutrement") then
											for _, v116 in clone:GetDescendants() do
												if v116:IsA(v85[53]) or v116:IsA("Decal") then
													v114.Transparency[v116] = v116.Transparency
												end
											end

											tbl23.AddAccessory(arg2, clone)
										else
											clone.Parent = parent
										end
									end
								end

								local head = arg:FindFirstChild("Head")
								local head2 = parent:FindFirstChild("Head")

								if head and head2 then
									for _, v115 in head:GetChildren() do
										if tbl23.IsHeadAppearance(v115) then
											local clone = v115:Clone()
											v114.Added[#v114.Added + 1] = clone
											clone.Parent = head2
										end
									end
								end

								tbl23.UpdateVisibility(v114)
							end

							tbl23.UpdateVisibility = function(arg)
								if not arg or not arg.Transparency then
									return
								end
								local torso = arg.Character:FindFirstChild("Torso")
								if not torso then
									return
								end

								for k, v114 in arg.Transparency, nil, nil do
									if k.Parent then
										k.Transparency = v85[18] - (1 - v114) * (1 - torso.Transparency)

										if k:IsA("BasePart") then
											k.LocalTransparencyModifier = torso.LocalTransparencyModifier
										end
									end
								end
							end

							tbl23.RestoreKH = function(parent)
								local v114 = v113
								v113 = nil
								if not v114 then
									return
								end

								if v114.Korblox then
									v114.Korblox:Destroy()
								end

								if v114.Character == parent then
									for _, v115 in v114.LegMeshes, nil, nil do
										v115.Parent = parent
									end

									parent = parent and parent:FindFirstChild("Head")

									if parent then
										parent.Transparency = v114.HeadTransparency
									end

									if v114.Face and v114.Face.Parent then
										v114.Face.Transparency = v114.FaceTransparency
									end
								else
									for _, v115 in v114.LegMeshes, nil, nil do
										v115:Destroy()
									end
								end
							end

							tbl23.ApplyKH = function(parent)
								local humanoid = parent and parent:FindFirstChildOfClass("Humanoid")
								if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then
									return
								end
								tbl23.RestoreKH(parent)
								local head = parent:FindFirstChild("Head")
								local face = head and (head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal"))

								local tbl26 = {
									Character = parent,
									HeadTransparency = head and head.Transparency or 0,
									Face = face,
									FaceTransparency = face and face.Transparency or v85[33],
									LegMeshes = {},
								}

								for _, v114 in parent:GetChildren() do
									if v114:IsA("CharacterMesh") and v114.BodyPart == Enum.BodyPart.RightLeg then
										tbl26.LegMeshes[#tbl26.LegMeshes + 1] = v114
										v114.Parent = folder2
									end
								end

								local characterMesh = Instance.new("CharacterMesh")
								characterMesh.Name = "FlyteKorblox"
								characterMesh.BodyPart = Enum.BodyPart.RightLeg
								characterMesh.MeshId = 101851696
								characterMesh.OverlayTextureId = 101851254
								characterMesh.Parent = parent
								tbl26.Korblox = characterMesh
								v113 = tbl26

								if head then
									head.Transparency = 1
								end

								if face then
									face.Transparency = 1
								end
							end

							tbl23.RestoreAppearance = function(arg)
								tbl23.RestoreKH(arg)
								local v114 = v112

								if not v114 then
									if arg then
										arg:SetAttribute("flytemarker1", nil)
									end

									return
								end

								if v114.Character ~= arg then
									tbl23.DiscardAppearance()
									return
								end
								tbl23.ClearAdded()
								local visibility = v114.Visibility or {}

								for _, v115 in visibility, nil, nil do
									v115:Disconnect()
								end

								for _, v115 in v114.Original, nil, nil do
									if v115.Parent and v115.Parent.Parent then
										v115.Object.Parent = v115.Parent
									else
										v115.Object:Destroy()
									end
								end

								v112 = nil
								arg:SetAttribute("flytemarker1", nil)
							end

							tbl23.ApplySource = function(arg, arg2, arg3)
								if not tbl20.AvatarEnabled or localPlayer.Character ~= arg2 or v109 ~= arg3 then
									return
								end
								local humanoid = arg2:FindFirstChildOfClass("Humanoid")
								if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then
									return
								end
								tbl23.RestoreKH(arg2)
								tbl23.CaptureAppearance(arg2)
								tbl23.ClearAdded()
								arg2:SetAttribute("flytemarker1", nil)

								if not pcall(tbl23.CopyAppearance, arg, arg2, humanoid) then
									tbl23.RestoreAppearance(arg2)

									if tbl20.KHEnabled then
										tbl23.ApplyKH(arg2)
									end

									return
								end

								if tbl20.KHEnabled then
									tbl23.ApplyKH(arg2)
								end

								arg2:SetAttribute("flytemarker1", arg3)
								tbl23.UpdateImages()

								for k in tbl23.Clones, nil, nil do
									tbl23.ApplyClone(k)
								end

								if tbl23.DelayedSearch == v111 then
									tbl23.DelayedSearch = nil
									v103:Notify({ Title = "wow it loaded" })
								end

								return v85[200]
							end

							tbl23.Update = function(arg)
								if not tbl20.AvatarEnabled then
									return
								end
								local v114 = v109 and tbl23.Sources[v109]
								local flag19 = not v114 or v114.Parent ~= folder

								if not flag19 then
									flag19 = v110 ~= tbl23.GetInput():lower()
								end

								if flag19 then
									if not tbl23.PendingUser then
										task.spawn(tbl23.Apply)
									end

									return
								end

								local character = localPlayer.Character
								if not tbl23.IsAppearanceReady(character) then
									return
								end

								if not arg and v112 and v112.Character == character and character:GetAttribute("flytemarker1") == v109 then
									return
								end
								tbl23.ApplySource(v114, character, v109)
							end

							tbl23.Apply = function()
								if not tbl20.AvatarEnabled then
									return
								end
								local v114 = tbl23.GetInput()
								if v114 == "" then
									return
								end
								local pendingUser = v114:lower()
								if tbl23.PendingUser == pendingUser then
									return
								end
								local v115 = v109 and tbl23.Sources[v109]
								if not tbl23.PendingUser and v110 == pendingUser and v115 and v115.Parent == folder then
									tbl23.Update()
									return
								end
								v111 += 1
								local v116 = v111
								tbl23.PendingUser = pendingUser
								tbl23.DelayedSearch = nil

								task.delay(3, function()
									if tbl23.PendingUser == pendingUser and tbl23.SearchCurrent(v116, pendingUser) then
										tbl23.DelayedSearch = v116
										v103:Notify({ Title = "Roblox is delaying avatar changer np" })
									end
								end)

								local result = nil

								for i = 1, 3 do
									local ok
									ok, result = pcall(tbl23.GetUserID, v114)

									if not (ok and result) then
										result = nil
										if tbl23.SearchCurrent(v116, pendingUser) then
											result = nil
											continue
										end
									end

									break
								end

								if not result or not tbl23.SearchCurrent(v116, pendingUser) then
									if v116 == v111 then
										tbl23.PendingUser = nil
									end

									return
								end

								local v117 = nil

								while tbl23.SearchCurrent(v116, pendingUser) do
									local ok, result2 = pcall(tbl23.GetSource, result)
									v117 = ok and result2 or nil
									if not (v117 or not tbl23.SearchCurrent(v116, pendingUser)) then
										task.wait(2)
										continue
									end
									break
								end

								if v116 == v111 then
									tbl23.PendingUser = nil
								end

								if not v117 or not tbl23.SearchCurrent(v116, pendingUser) then
									return
								end
								v109 = result
								v110 = pendingUser
								local character = localPlayer.Character

								if tbl23.IsAppearanceReady(character) and tbl23.SearchCurrent(v116, pendingUser) then
									tbl23.ApplySource(v117, character, result)
								end
							end

							tbl23.Reconcile = function(arg)
								if localPlayer.Character ~= arg then
									return
								end
								arg:SetAttribute("flytemarker1", nil)

								if tbl20.AvatarEnabled then
									tbl23.Update(v85[200])
								elseif tbl20.KHEnabled then
									tbl23.ApplyKH(arg)
								end
							end

							tbl23.ClearClone = function(arg)
								local v114 = tbl23.Clones[arg]
								if not v114 then
									return
								end
								tbl23.Clones[arg] = nil

								for _, v115 in v114.Connections, nil, nil do
									v115:Disconnect()
								end

								if v114.Appearance then
									local visibility = v114.Appearance.Visibility or {}

									for _, v115 in visibility, nil, nil do
										v115:Disconnect()
									end

									for _, v115 in v114.Appearance.Added, nil, nil do
										v115:Destroy()
									end

									for _, v115 in v114.Appearance.Original, nil, nil do
										if arg.Parent and (v115.Parent == arg or v115.Parent:IsDescendantOf(arg)) then
											v115.Object.Parent = v115.Parent
										else
											v115.Object:Destroy()
										end
									end
								end
							end

							tbl23.ApplyClone = function(arg, arg2)
								local v114 = tbl23.Clones[arg]
								local v115 = v109 and tbl23.Sources[v109]
								local flag19 = not v114 or not tbl20.AvatarEnabled or not v115 or not arg2 and v114.ID == v109 or arg:GetAttribute("IsEncryptedClone") ~= true

								if not flag19 then
									local name = localPlayer.Name
									flag19 = arg:GetAttribute("EncryptedCloneOwner") ~= name
								end

								if flag19 then
									return
								end
								local humanoid = arg:FindFirstChildOfClass("Humanoid")
								if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 or not arg:FindFirstChild("Head") then
									return
								end

								if v114.Appearance then
									for _, v116 in v114.Appearance.Added, nil, nil do
										v116:Destroy()
									end

									table.clear(v114.Appearance.Added)
								end

								v114.Appearance = tbl23.StoreAppearance(arg, v114.Appearance)
								v114.ID = v109

								if not pcall(tbl23.CopyAppearance, v115, arg, humanoid, v114.Appearance) then
									tbl23.ClearClone(arg)
								end
							end

							tbl23.WatchClone = function(arg)
								if not tbl20.AvatarEnabled or not arg:IsA("Model") or arg == localPlayer.Character or tbl23.Clones[arg] then
									return
								end
								local tbl26 = { Connections = {} }
								tbl23.Clones[arg] = tbl26

								local function fn73()
									tbl23.ApplyClone(arg)
								end

								local function fn74()
									local pending = tbl26.Pending

									if not pending then
										local name = localPlayer.Name
										pending = arg:GetAttribute("EncryptedCloneOwner") ~= name
									end

									if pending then
										return
									end
									tbl26.Pending = true

									task.defer(function()
										tbl26.Pending = false

										if tbl23.Clones[arg] == tbl26 then
											tbl23.ApplyClone(arg, v85[200])
										end
									end)
								end

								tbl26.Connections.Owner = arg:GetAttributeChangedSignal("EncryptedCloneOwner"):Connect(fn73)
								tbl26.Connections.Clone = arg:GetAttributeChangedSignal("IsEncryptedClone"):Connect(fn73)

								tbl26.Connections.Loaded = arg.DescendantAdded:Connect(function(descendant)
									local flag19 = descendant.Parent == arg
									local isHumanoid

									if flag19 then
										isHumanoid = tbl23.IsBodyAppearance(descendant) or descendant:IsA("Humanoid")
									else
										isHumanoid = flag19
									end

									if isHumanoid or descendant.Parent == arg:FindFirstChild("Head") and tbl23.IsHeadAppearance(descendant) then
										if not tbl26.Appearance or not table.find(tbl26.Appearance.Added, descendant) then
											fn74()
										end
									end
								end)

								local humanoid = arg:FindFirstChildOfClass("Humanoid")

								if humanoid then
									tbl26.Connections.Description = humanoid.ApplyDescriptionFinished:Connect(fn74)
								end

								fn73()
							end

							tbl23.Bind = function()
								fn42("Avatar")
								tbl23.BindRun = tbl23.BindRun + 1
								local bindRun = tbl23.BindRun
								if not tbl20.AvatarEnabled and not tbl20.KHEnabled then
									return
								end
								local avatar = {}

								local function fn73(character)
									if bindRun ~= tbl23.BindRun or character ~= localPlayer.Character or not tbl23.IsAppearanceReady(character) then
										return
									end

									if tbl20.AvatarEnabled then
										if not v112 or v112.Character ~= character or character:GetAttribute("flytemarker1") ~= v109 then
											tbl23.Reconcile(character)
										end
									elseif tbl20.KHEnabled and (not v113 or v113.Character ~= character) then
										tbl23.ApplyKH(character)
									end
								end

								local function fn74(character)
									if avatar.Appearance then
										avatar.Appearance:Disconnect()
									end

									avatar.Appearance = character:GetAttributeChangedSignal("AppearanceLoaded"):Connect(function()
										if character:GetAttribute("AppearanceLoaded") == true then
											fn73(character)
										end
									end)

									fn73(character)
								end

								avatar.Character = localPlayer.CharacterAdded:Connect(fn74)
								avatar.Loaded = localPlayer.CharacterAppearanceLoaded:Connect(fn73)
								avatar.Alive = alive.ChildAdded:Connect(fn73)

								if tbl20.AvatarEnabled then
									avatar.CloneAdded = alive.ChildAdded:Connect(tbl23.WatchClone)
									avatar.CloneRemoved = alive.ChildRemoved:Connect(tbl23.ClearClone)

									for _, v114 in alive:GetChildren() do
										tbl23.WatchClone(v114)
									end
								else
									for k in tbl23.Clones, nil, nil do
										tbl23.ClearClone(k)
									end
								end

								flyteBBState.Connections.Avatar = avatar

								if localPlayer.Character then
									fn74(localPlayer.Character)
								end
							end

							tbl23.Toggle = function(avatarEnabled)
								tbl20.AvatarEnabled = avatarEnabled
								v111 += v85[18]
								tbl23.PendingUser = nil

								if avatarEnabled then
									local avatarChangerInput = tbl24 and tbl24.textboxes and tbl24.textboxes.Avatar_Changer_Input

									if avatarChangerInput and avatarChangerInput.textbox then
										tbl20.AvatarUser = avatarChangerInput.textbox.Text
									end

									tbl23.Bind()
									task.spawn(tbl23.Apply)
									return
								end

								tbl23.Bind()
								tbl23.RestoreImages()
								local character = localPlayer.Character

								if character then
									tbl23.RestoreAppearance(character)

									if tbl20.KHEnabled then
										tbl23.ApplyKH(character)
									end
								else
									tbl23.DiscardKH()
									tbl23.DiscardAppearance()
								end
							end

							tbl23.ToggleKH = function(khEnabled)
								tbl20.KHEnabled = khEnabled
								tbl23.Bind()
								local character = localPlayer.Character
								if not character then
									tbl23.DiscardKH()
									return
								end

								if khEnabled then
									if tbl23.IsAppearanceReady(character) and (not v113 or v113.Character ~= character) then
										tbl23.ApplyKH(character)
									end
								else
									tbl23.RestoreKH(character)
								end

								if not (n24 <= 4729) then
									return
								end

								while true do
								end
							end

							tbl23.Destroy = function()
								v111 += v85[18]
								tbl23.PendingUser = nil
								tbl23.BindRun = tbl23.BindRun + v85[18]
								fn42("Avatar")
								tbl23.RestoreImages()

								for k in tbl23.Clones, nil, nil do
									tbl23.ClearClone(k)
								end

								local character = localPlayer.Character

								if character then
									if n25 < 6615 then
										while true do
										end
									else
										tbl23.RestoreAppearance(character)
									end
								else
									tbl23.DiscardKH()
									tbl23.DiscardAppearance()
								end

								table.clear(tbl23.Sources)

								if folder.Parent then
									folder:Destroy()
								end
							end
						end

						tbl25.LoadAvatar()

						fn43({
							AbilityESPEnabled = false,
							AbilityESPShowNames = false,
							AbilityESPIconSize = 34,
							AbilityESPTextSize = v85[11],
						})

						tbl25.Visuals = {
							AbilityIcons = require(v93.Shared.AbilityIcons),
							Abilities = require(v93.Shared.Abilities),
							AbilityAnimations = {},
							UseBall2 = require(v93.Shared.UseBall2),
						}

						tbl25.Visuals.AbilityData = tbl25.Visuals.Abilities.All or {}
						tbl25.Visuals.FuryTimers = {}

						tbl25.Visuals.ClearFuryTimer = function(arg)
							local v109 = tbl25.Visuals.FuryTimers[arg]
							if not v109 then
								return
							end
							tbl25.Visuals.FuryTimers[arg] = nil
							if not flag2 then
								return
							end

							if v109.Tween then
								v109.Tween:Cancel()
							end

							v109.Gui:Destroy()
						end

						tbl25.Visuals.UpdateFuryTimer = function(arg, arg2, arg3)
							local str5 = tostring(arg)
							if not tbl20.AbilityESPEnabled or type(arg2) ~= "number" or arg2 <= 0 then
								tbl25.Visuals.ClearFuryTimer(str5)
								return
							end
							local v109 = nil

							for _, v110 in workspace.Balls:GetChildren() do
								if v110.Name == str5 and not v110:GetAttribute("realBall") then
									v109 = v110
									break
								else
									v109 = nil
								end
							end

							local furyTimer = localPlayer.PlayerGui:FindFirstChild("FuryTimer")
							if not v109 or not furyTimer then
								return
							end
							local tbl26 = tbl25.Visuals.FuryTimers[str5]

							if tbl26 and tbl26.Gui.Parent ~= v109 then
								tbl25.Visuals.ClearFuryTimer(str5)
								tbl26 = nil
							end

							if not tbl26 then
								local billboardGui = Instance.new("BillboardGui")
								billboardGui.Name = "FuryCharge"
								local n33 = math.max(v109.Size.X, v109.Size.Y, v109.Size.Z) * 2.5
								billboardGui.Size = UDim2.fromScale(n33, n33 * 32 / 280)
								billboardGui.StudsOffset = Vector3.new(0, -v109.Size.Y / 2 - v85[81], v85[33])
								billboardGui.ZIndexBehavior = furyTimer.ZIndexBehavior
								billboardGui.AlwaysOnTop = true
								billboardGui.ClipsDescendants = v85[101]
								billboardGui.Adornee = v109
								local instance = Instance.new(v85[170])
								instance.BackgroundTransparency = 1
								instance.AnchorPoint = Vector2.new(0.5, 0.5)
								instance.Position = UDim2.fromScale(0.5, 0.5)
								instance.Size = UDim2.fromScale(1, 1)
								local uiSizeConstraint = Instance.new("UISizeConstraint")
								uiSizeConstraint.MinSize = Vector2.new(220, 25.142857142857142)
								uiSizeConstraint.MaxSize = Vector2.new(240, 27.428571428571427)
								uiSizeConstraint.Parent = instance
								instance.Parent = billboardGui
								local clone = furyTimer.Selection.ProgressBar:Clone()
								clone.Size = UDim2.fromScale(0.88, 0.1890625)
								clone.Position = UDim2.fromScale(0.55, 0.5)
								clone.AnchorPoint = Vector2.new(0.5, 0.5)
								clone.UIStroke.Thickness = 1
								clone.Parent = instance
								billboardGui.Parent = v109
								tbl26 = { Gui = billboardGui, Fill = clone.Fill }
								tbl25.Visuals.FuryTimers[str5] = tbl26
							end

							local tween = tbl26.Tween
							tbl26.Tween = nil

							if tween then
								tween:Cancel()
							end

							tbl26.Fill.Size = UDim2.fromScale(math.clamp(arg2 / (arg3 or arg2), 0, 1), 1)
							local tween2 = v86:Create(tbl26.Fill, TweenInfo.new(arg2, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(v85[33], v85[18]) })
							tbl26.Tween = tween2

							tween2.Completed:Once(function()
								if tbl25.Visuals.FuryTimers[str5] == tbl26 and tbl26.Tween == tween2 then
									tbl25.Visuals.ClearFuryTimer(str5)
								end
							end)

							tween2:Play()
							return v85[200]
						end

						tbl25.Visuals.ClearFury = function(arg)
							if not arg then
								return
							end

							if arg.TimerId then
								tbl25.Visuals.ClearFuryTimer(arg.TimerId)
								arg.TimerId = nil
							end

							if arg.ScaleTween then
								arg.ScaleTween:Cancel()
								arg.ScaleTween = nil
							end

							if arg.PositionTween then
								arg.PositionTween:Cancel()
								arg.PositionTween = nil
							end

							if arg.Counter then
								arg.Counter:Destroy()
								arg.Counter = nil
							end
						end

						tbl25.Visuals.UpdateFuryCount = function(parent, arg)
							if arg.Counter and arg.Counter.Parent ~= parent then
								tbl25.Visuals.ClearFury(arg)
							end

							if arg.TimerId and arg.TimerId ~= parent.Name then
								tbl25.Visuals.ClearFuryTimer(arg.TimerId)
							end

							if tbl25.Visuals.UpdateFuryTimer(parent.Name, 0.5) then
								arg.TimerId = parent.Name
							end

							local comboCounter = parent:FindFirstChild("ComboCounter")
							if comboCounter and comboCounter ~= arg.Counter then
								return
							end
							local counter = arg.Counter

							if not counter then
								counter = v93.Assets.ComboCounter:Clone()
								counter.Parent = parent
								arg.Counter = counter
							end

							local textLabel = counter.TextLabel
							local uiScale = textLabel.UIScale
							uiScale.Scale = 1.2
							textLabel.Text = tostring(arg.Uses)
							local v109 = v85[18]
							textLabel.TextColor3 = Color3.new(v85[18], v85[18], 1):Lerp(Color3.fromHSV((v85[18] - math.min(arg.Uses / 35, 1)) * 0.166666, 1, v109), math.min(arg.Uses / 5, 1))
							counter.StudsOffset = Vector3.new(0, 4, 0)

							if arg.ScaleTween then
								arg.ScaleTween:Cancel()
								arg.PositionTween:Cancel()
							end

							arg.ScaleTween = v86:Create(uiScale, TweenInfo.new(0.33333333333333331, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Scale = 0.6 })
							arg.PositionTween = v86:Create(counter, TweenInfo.new(0.66666666666666663, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { StudsOffset = Vector3.new(0, v85[61], 0) })
							arg.ScaleTween:Play()
							arg.PositionTween:Play()
						end

						tbl25.Visuals.GetInfo = function(arg, arg2, arg3)
							local attribute = arg:GetAttribute("CurrentlyEquippedAbility") or arg:GetAttribute("EquippedAbility") or arg:GetAttribute(v85[2]) or arg:GetAttribute("CurrentAbility") or arg2:GetAttribute("CurrentlyEquippedAbility") or arg2:GetAttribute("EquippedAbility") or arg2:GetAttribute("Ability") or arg2:GetAttribute("CurrentAbility")

							if not attribute then
								local abilities = arg2:FindFirstChild("Abilities")

								if abilities then
									for _, v109 in abilities:GetChildren() do
										if v109:IsA("LocalScript") and v109.Enabled then
											attribute = v109.Name
											break
										end
									end
								end
							end

							if not attribute then
								return nil
							end
							local n33 = v85[33]
							local upgrades = arg:FindFirstChild("Upgrades")
							upgrades = upgrades and upgrades:FindFirstChild(attribute)

							if upgrades and upgrades:IsA("ValueBase") then
								n33 = tonumber(upgrades.Value) or 0
							end

							local num = tonumber(arg2:GetAttribute("AbilityUpgrade"))
							local n34

							if num then
								n34 = math.max(n33, num)
							else
								n34 = n33
							end

							local tbl26 = tbl25.Visuals.AbilityData[attribute] or {}
							local iconId = tbl25.Visuals.AbilityIcons[attribute] or tbl26.iconId

							if iconId == "rbxassetid://0" then
								iconId = nil
							end

							local v109 = flyteBBState.AbilityUses[arg]
							local n35 = math.max(tonumber(arg:GetAttribute("AbilityDurationStart")) or 0, tonumber(arg2:GetAttribute("AbilityDurationStart")) or v85[33])
							local n36 = math.max(tonumber(arg:GetAttribute("AbilityDuration")) or 0, tonumber(arg2:GetAttribute("AbilityDuration")) or v85[33])
							local n37 = n35 + n36
							local flag19 = n35 > 0 and n36 > v85[33]

							if flag19 then
								flag19 = n37 >= (v109 and v109.Started or 0)
							end

							if flag19 then
								flag19 = (arg3 or workspace:GetServerTimeNow()) >= n37
							end

							local flag20 = v109 and v109.Ability == "Slashes of Fury"

							if flag20 then
								flag20 = v109.Character ~= arg2 or attribute ~= "Slashes of Fury" or not arg2:GetAttribute("FuryCatch") or flag19
							end

							if flag20 then
								tbl25.Visuals.ClearFury(v109)
								flyteBBState.AbilityUses[arg] = nil
								v109 = nil
							elseif v109 and v109.Recoveries and (v109.Character ~= arg2 or v109.Ability ~= attribute) then
								flyteBBState.AbilityUses[arg] = nil
								v109 = nil
							end

							if tbl20.AbilityESPEnabled and attribute == "Slashes of Fury" and arg2:GetAttribute("FuryCatch") and not flag19 then
								local serverTimeNow = arg3 or workspace:GetServerTimeNow()

								if not v109 then
									local tbl27 = { Ability = attribute, Character = arg2, Uses = 0, Started = serverTimeNow }
									flyteBBState.AbilityUses[arg] = tbl27
									v109 = tbl27
								end

								if not v109.TimerId and v109.Uses == 0 then
									local n38 = 3.5 - serverTimeNow - v109.Started

									if v85[33] < n38 then
										for _, v110 in workspace.Balls:GetChildren() do
											if v110:GetAttribute("FuryCatch" .. arg.Name) then
												if tbl25.Visuals.UpdateFuryTimer(v110.Name, n38, 3.5) then
													v109.TimerId = v110.Name
												end

												break
											end
										end
									end
								end
							end

							local maximum, str5

							if attribute == "Guardian Angel" then
								maximum = tonumber(arg2:GetAttribute("GuardianAngelParriesLeft"))

								if maximum == nil then
									maximum = math.min(n34, 1) + 1
								end

								str5 = "lives"
							else
								maximum = tbl26.uses

								if attribute == v85[160] then
									maximum = workspace:GetAttribute("GoldenAbilities") and 999 or n34 + 2
								elseif attribute == "Dribble" then
									maximum = n34 + 2
								end

								local v110 = nil

								if maximum then
									if v109 and v109.Ability == attribute and v109.Recoveries then
										arg3 = arg3 or workspace:GetServerTimeNow()

										for i = #v109.Recoveries, 1, -1 do
											if v109.Recoveries[i] <= arg3 then
												table.remove(v109.Recoveries, i)
											end
										end

										v109.Maximum = maximum
										v109.Expiration = v109.Recoveries[v85[18]]
										maximum = math.max(maximum - #v109.Recoveries, v85[33])
										v109.Uses = maximum
									end
								else
									maximum = v110
								end

								str5 = "uses"
							end

							return attribute, n34 + 1, iconId, tbl26.isPassive or attribute == "Guardian Angel", maximum, str5, n35, n36
						end

						tbl25.Visuals.FindCharacter = function(arg, arg2)
							if not arg or not arg2 then
								return nil
							end
							local name = arg2.Name
							local displayName = arg2.DisplayName
							local v109 = arg:FindFirstChild(name, true) or arg:FindFirstChild(displayName, true)
							if v109 and v109:IsA("Model") then
								return v109
							end

							for _, v110 in arg:GetChildren() do
								if v110:IsA("Model") then
									local attribute = v110:GetAttribute("UserId") or v110:GetAttribute("UserID") or v110:GetAttribute("User")
									local humanoid = v110:FindFirstChildOfClass("Humanoid")
									if attribute == arg2.UserId or tostring(attribute) == tostring(arg2.UserId) or v110.Name == name or v110.Name == displayName or humanoid and (humanoid.DisplayName == displayName or humanoid.DisplayName == name) then
										return v110
									end
								end
							end

							return nil
						end

						tbl25.Visuals.GetESPCharacter = function(arg)
							if not arg then
								return nil
							end
							local character = arg.Character
							if character and character.Parent then
								return character
							end
							local v109 = tbl25.Visuals.FindCharacter(workspace:FindFirstChild("Alive"), arg)
							if v109 then
								return v109
							end
							local v110 = tbl25.Visuals.FindCharacter(workspace:FindFirstChild("Dead"), arg)
							if v110 then
								return v110
							end
							return nil
						end

						tbl25.Visuals.GetESPAdornee = function(arg)
							if not arg then
								return nil
							end
							local head = arg:FindFirstChild("Head") or arg:FindFirstChild("HumanoidRootPart")
							return head and head:IsA(v85[53]) and head or arg.PrimaryPart or arg:FindFirstChildWhichIsA("BasePart")
						end

						tbl25.Visuals.DestroyLabel = function(arg)
							if not arg then
								return
							end

							for _, v109 in arg.Connections, nil, nil do
								v109:Disconnect()
							end

							if arg.DurationTween then
								arg.DurationTween:Cancel()
							end

							if arg.DurationProgressTween then
								arg.DurationProgressTween:Cancel()
							end

							if arg.CooldownTextTween then
								arg.CooldownTextTween:Cancel()
							end

							if arg.Billboard then
								arg.Billboard:Destroy()
							end
						end

						tbl25.Visuals.UpdateSize = function(arg)
							if not arg or not arg.Billboard then
								return
							end
							local n33 = math.clamp(tonumber(tbl20.AbilityESPIconSize) or 34, 20, 60)
							local textSize = math.clamp(tonumber(tbl20.AbilityESPTextSize) or 13, v85[35], v85[108])
							local textSize2 = math.max(textSize - 1, 8)
							arg.Billboard.Size = UDim2.new(0, 230, v85[33], n33 + 64)
							arg.IconHolder.Size = UDim2.new(0, n33, 0, n33)
							arg.IconHolder.Position = UDim2.new(0.5, -(n33 / 2 + 3), 0, v85[46])
							arg.DurationHolder.Size = UDim2.new(0, 58, 0, n33)
							arg.DurationHolder.Position = UDim2.new(0.5, n33 / v85[70] - 1, 0, 14)
							arg.DurationText.Size = UDim2.new(v85[33], 48, v85[33], textSize + 2)
							arg.DurationText.Position = UDim2.new(v85[33], 9, v85[81], -(textSize + 2) / v85[70])
							arg.DurationText.TextSize = textSize
							arg.Uses.Size = UDim2.new(v85[33], 64, 0, textSize2 + 2)
							arg.Uses.Position = UDim2.new(v85[81], n33 / 2 - 3, 0, v85[49])
							arg.Uses.TextSize = textSize2
							arg.CooldownText.Size = UDim2.new(0, 64, 0, textSize + 2)
							arg.CooldownText.TextSize = textSize
							arg.Label.Size = UDim2.new(1, -18, 0, textSize + v85[174])
							arg.Label.Position = UDim2.new(v85[33], 9, 0, n33 + 19)
							arg.Label.TextSize = textSize + v85[70]
							arg.PlayerName.Size = UDim2.new(1, -18, 0, textSize2 + 4)
							arg.PlayerName.Position = UDim2.new(0, 9, 0, n33 + v85[80])
							arg.PlayerName.TextSize = textSize2
						end

						tbl25.Visuals.UpdateSizes = function()
							for _, v109 in flyteBBState.ESPLabels, nil, nil do
								tbl25.Visuals.UpdateSize(v109)
							end
						end

						tbl25.Visuals.AddLabel = function(arg, arg2)
							if not (tbl20.AbilityESPEnabled or tbl20.AbilityESPShowNames) or not arg or arg == localPlayer then
								return
							end

							local function fn73(arg3)
								if not (tbl20.AbilityESPEnabled or tbl20.AbilityESPShowNames) or not arg3 then
									return
								end
								local v109 = tbl25.Visuals.GetESPAdornee(arg3)
								if not v109 then
									return
								end
								local v110 = flyteBBState.ESPLabels[arg]

								if v110 then
									tbl25.Visuals.DestroyLabel(v110)
								end

								for _, v111 in arg3:GetDescendants() do
									if v111.Name == "Ability_ESP" and v111:IsA("BillboardGui") then
										v111:Destroy()
									end
								end

								local billboardGui = Instance.new("BillboardGui")
								billboardGui.Name = "Ability_ESP"
								billboardGui.Adornee = v109
								billboardGui.Size = UDim2.new(v85[33], 230, 0, 98)
								billboardGui.StudsOffset = Vector3.new(0, 4.15, 0)
								billboardGui.AlwaysOnTop = true
								billboardGui.MaxDistance = 500
								billboardGui.Parent = v109
								local instance = Instance.new(v85[170])
								instance.Size = UDim2.new(1, 0, 1, 0)
								instance.BackgroundTransparency = 1
								instance.Parent = billboardGui
								local frame = Instance.new("Frame")
								frame.Size = UDim2.new(0, v85[97], v85[33], v85[97])
								frame.Position = UDim2.new(0.5, -20, 0, 14)
								frame.BackgroundTransparency = 1
								frame.ClipsDescendants = v85[200]
								frame.Parent = instance
								local imageLabel = Instance.new("ImageLabel")
								imageLabel.Size = UDim2.new(1, 0, 1, 0)
								imageLabel.BackgroundTransparency = 1
								imageLabel.ScaleType = Enum.ScaleType.Fit
								imageLabel.ZIndex = 1
								imageLabel.Parent = frame
								local frame2 = Instance.new("Frame")
								frame2.AnchorPoint = Vector2.new(0, 1)
								frame2.Position = UDim2.fromScale(0, 1)
								frame2.Size = UDim2.new(1, 0, v85[18], 0)
								frame2.BackgroundColor3 = Color3.fromRGB(75, 75, 82)
								frame2.BackgroundTransparency = v85[136]
								frame2.BorderSizePixel = 0
								frame2.Visible = false
								frame2.ZIndex = 3
								frame2.Parent = frame
								local uiGradient = Instance.new("UIGradient")
								local color = Color3.fromRGB
								local v111 = v85[195]
								uiGradient.Color = ColorSequence.new(Color3.fromRGB(120, 120, 128), color(45, v111, 52))
								uiGradient.Rotation = 90
								uiGradient.Parent = frame2
								local canvasGroup = Instance.new("CanvasGroup")
								canvasGroup.Size = UDim2.new(v85[33], 58, 0, v85[97])
								canvasGroup.Position = UDim2.new(0.5, 16, 0, 14)
								canvasGroup.BackgroundTransparency = 1
								canvasGroup.Visible = false
								canvasGroup.ZIndex = 4
								canvasGroup.Parent = instance
								local instance2 = Instance.new(v85[170])
								instance2.Size = UDim2.new(0, 5, 1, 0)
								instance2.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
								instance2.BackgroundTransparency = v85[110]
								instance2.BorderSizePixel = 0
								instance2.ClipsDescendants = v85[200]
								instance2.ZIndex = 4
								instance2.Parent = canvasGroup
								local uiCorner = Instance.new("UICorner")
								uiCorner.CornerRadius = UDim.new(1, v85[33])
								uiCorner.Parent = instance2
								local frame3 = Instance.new("Frame")
								frame3.AnchorPoint = Vector2.new(0, 1)
								frame3.Size = UDim2.new(v85[18], 0, 1, v85[33])
								frame3.Position = UDim2.new(v85[33], 0, 1, 0)
								frame3.BackgroundColor3 = Color3.fromRGB(20, 228, 31)
								frame3.BorderSizePixel = v85[33]
								frame3.ZIndex = 5
								frame3.Parent = instance2
								local uiGradient2 = Instance.new("UIGradient")
								local color2 = Color3.fromRGB
								uiGradient2.Color = ColorSequence.new(Color3.fromRGB(120, 255, v85[67]), color2(0, 160, 20))
								uiGradient2.Rotation = 90
								uiGradient2.Parent = frame3
								local textLabel = Instance.new("TextLabel")
								textLabel.Size = UDim2.new(0, 48, v85[33], 14)
								textLabel.Position = UDim2.new(v85[33], 9, 0.5, -7)
								textLabel.BackgroundTransparency = 1
								textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								textLabel.TextStrokeColor3 = Color3.fromRGB(v85[33], 0, 0)
								textLabel.TextStrokeTransparency = 0.05
								textLabel.TextSize = 13
								textLabel.Font = Enum.Font.GothamBold
								textLabel.TextXAlignment = Enum.TextXAlignment.Left
								textLabel.ZIndex = 6
								textLabel.Parent = canvasGroup
								local textLabel2 = Instance.new("TextLabel")
								textLabel2.AnchorPoint = Vector2.new(v85[18], 0)
								textLabel2.Size = UDim2.new(0, 48, v85[33], 13)
								textLabel2.Position = UDim2.new(0.5, 14, 0, 12)
								textLabel2.BackgroundTransparency = 1
								textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
								textLabel2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
								textLabel2.TextStrokeTransparency = 0.05
								textLabel2.TextSize = 12
								textLabel2.Font = Enum.Font.GothamBold
								textLabel2.TextXAlignment = Enum.TextXAlignment.Right
								textLabel2.Visible = v85[101]
								textLabel2.ZIndex = 6
								textLabel2.Parent = instance
								local textLabel3 = Instance.new("TextLabel")
								textLabel3.AnchorPoint = Vector2.new(0.5, 0)
								textLabel3.Size = UDim2.new(v85[33], 48, 0, 14)
								textLabel3.Position = UDim2.new(0.5, -3, 0, 0)
								textLabel3.BackgroundTransparency = 1
								textLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
								textLabel3.TextTransparency = 1
								textLabel3.TextStrokeColor3 = Color3.fromRGB(v85[33], 0, 0)
								textLabel3.TextStrokeTransparency = 1
								textLabel3.TextSize = 13
								textLabel3.Font = Enum.Font.GothamBold
								textLabel3.TextXAlignment = Enum.TextXAlignment.Center
								textLabel3.Visible = false
								textLabel3.ZIndex = 6
								textLabel3.Parent = instance
								local textLabel4 = Instance.new("TextLabel")
								textLabel4.Size = UDim2.new(1, -v85[186], 0, v85[108])
								textLabel4.Position = UDim2.new(0, 9, v85[33], 53)
								textLabel4.BackgroundTransparency = v85[18]
								textLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
								textLabel4.TextStrokeColor3 = Color3.fromRGB(0, v85[33], v85[33])
								textLabel4.TextStrokeTransparency = 0.05
								textLabel4.TextScaled = false
								textLabel4.TextSize = 15
								textLabel4.Font = Enum.Font.GothamBold
								textLabel4.Text = ""
								textLabel4.TextXAlignment = Enum.TextXAlignment.Center
								textLabel4.TextYAlignment = Enum.TextYAlignment.Center
								textLabel4.Parent = instance
								local textLabel5 = Instance.new("TextLabel")
								textLabel5.Size = UDim2.new(v85[18], -18, 0, 16)
								textLabel5.Position = UDim2.new(0, v85[41], 0, 72)
								textLabel5.BackgroundTransparency = 1
								textLabel5.TextColor3 = Color3.fromRGB(225, 225, 230)
								textLabel5.TextStrokeColor3 = Color3.fromRGB(v85[33], 0, 0)
								textLabel5.TextStrokeTransparency = 0.1
								textLabel5.TextSize = v85[49]
								textLabel5.Font = Enum.Font.GothamMedium
								textLabel5.Text = arg.DisplayName
								textLabel5.TextXAlignment = Enum.TextXAlignment.Center
								textLabel5.TextYAlignment = Enum.TextYAlignment.Center
								textLabel5.Visible = tbl20.AbilityESPShowNames
								textLabel5.Parent = instance

								local tbl26 = {
									Character = arg3,
									Connections = {},
									Billboard = billboardGui,
									Label = textLabel4,
									IconHolder = frame,
									Icon = imageLabel,
									Cooldown = frame2,
									CooldownText = textLabel3,
									Duration = frame3,
									DurationHolder = canvasGroup,
									DurationText = textLabel,
									Uses = textLabel2,
									PlayerName = textLabel5,
								}

								tbl25.Visuals.UpdateSize(tbl26)
								flyteBBState.ESPLabels[arg] = tbl26

								tbl26.Connections[#tbl26.Connections + 1] = arg3:GetAttributeChangedSignal("FuryCatch"):Connect(function()
									if tbl20.AbilityESPEnabled and flyteBBState.ESPLabels[arg] == tbl26 then
										tbl25.Visuals.GetInfo(arg, arg3)
									end
								end)

								tbl26.Connections[#tbl26.Connections + 1] = arg3:GetAttributeChangedSignal("AbilityActive"):Connect(function()
									if tbl25.Visuals.UseBall2() or arg3:GetAttribute("AbilityActive") ~= true or arg3:GetAttribute("Ability") ~= "Dribble" then
										return
									end
									local v112, v113 = tbl25.Visuals.GetInfo(arg, arg3)

									if v112 == v85[156] then
										tbl25.Visuals.TrackCooldown(arg3, v112, v113)
									end
								end)

								task.spawn(function()
									local humanoid = arg3:FindFirstChildOfClass("Humanoid") or arg3:WaitForChild("Humanoid", 5)
									local animator

									if humanoid then
										animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator", 5)
									else
										animator = humanoid
									end

									if not animator or flyteBBState.ESPLabels[arg] ~= tbl26 then
										return
									end

									tbl26.Connections[#tbl26.Connections + 1] = animator.AnimationPlayed:Connect(function(arg4)
										if tbl25.Visuals.UseBall2() then
											return
										end
										local v112, v113 = tbl25.Visuals.GetInfo(arg, arg3)
										local v114 = v112 and flyteBBState.AbilityCooldowns[arg]
										if not v112 or v112 == "Dribble" or v114 and v114.Ability == v112 and v114.Ends > workspace:GetServerTimeNow() or not tbl25.Visuals.IsAbilityAnimation(v112, arg4) then
											return
										end
										tbl25.Visuals.TrackCooldown(arg3, v112, v113)
									end)
								end)
							end

							local v109 = flyteBBState.ESPConnections[arg]

							if v109 then
								v109:Disconnect()
							end

							local v110 = arg2 or tbl25.Visuals.GetESPCharacter(arg)

							if v110 then
								fn73(v110)
							end

							flyteBBState.ESPConnections[arg] = arg.CharacterAdded:Connect(function(character)
								if tbl20.AbilityESPEnabled or tbl20.AbilityESPShowNames then
									fn73(character)
								end
							end)
						end

						tbl25.Visuals.ClearESP = function()
							for k in tbl25.Visuals.FuryTimers, nil, nil do
								tbl25.Visuals.ClearFuryTimer(k)
							end

							for _, v109 in flyteBBState.ESPLabels, nil, nil do
								tbl25.Visuals.DestroyLabel(v109)
							end

							table.clear(flyteBBState.ESPLabels)

							for _, v109 in flyteBBState.ESPConnections, nil, nil do
								if v109 then
									v109:Disconnect()
								end
							end

							table.clear(flyteBBState.ESPConnections)

							for k, v109 in flyteBBState.AbilityUses, nil, nil do
								if v109.Ability == "Slashes of Fury" then
									tbl25.Visuals.ClearFury(v109)
									flyteBBState.AbilityUses[k] = nil
								end
							end

							local v109 = workspace
							local findFirstChild = v109.FindFirstChild

							for _, v110 in { workspace:FindFirstChild("Alive"), findFirstChild(v109, "Dead") }, nil, nil do
								if v110 then
									for _, v111 in v110:GetDescendants() do
										if v111.Name == "Ability_ESP" and v111:IsA("BillboardGui") then
											v111:Destroy()
										end
									end
								end
							end

							for _, v110 in v89:GetPlayers() do
								local character = v110.Character

								if character then
									for _, v111 in character:GetDescendants() do
										if v111.Name == "Ability_ESP" and v111:IsA("BillboardGui") then
											v111:Destroy()
										end
									end
								end
							end
						end

						tbl25.Visuals.Toggle = function()
							if not tbl20.AbilityESPEnabled and not tbl20.AbilityESPShowNames then
								tbl25.Visuals.ClearESP()
								return
							end

							if not tbl20.AbilityESPEnabled then
								for k in tbl25.Visuals.FuryTimers, nil, nil do
									tbl25.Visuals.ClearFuryTimer(k)
								end

								for k, v109 in flyteBBState.AbilityUses, nil, nil do
									if v109.Ability == "Slashes of Fury" then
										tbl25.Visuals.ClearFury(v109)
										flyteBBState.AbilityUses[k] = nil
									end
								end
							end

							tbl25.Visuals.RefreshESP()
						end

						tbl25.Visuals.HideDuration = function(arg)
							if not arg.DurationHolder.Visible or arg.DurationTween then
								return
							end
							local tween = v86:Create(arg.DurationHolder, TweenInfo.new(v85[110]), { GroupTransparency = 1 })
							arg.DurationTween = tween

							tween.Completed:Once(function(playbackState)
								if playbackState == Enum.PlaybackState.Completed and arg.DurationTween == tween then
									arg.DurationHolder.Visible = v85[101]
									arg.DurationHolder.GroupTransparency = v85[33]
									arg.Duration.Position = UDim2.new(0, v85[33], 1, 0)
									arg.Duration.Size = UDim2.new(1, 0, 1, 0)
									arg.DurationTween = nil
								end
							end)

							tween:Play()
						end

						tbl25.Visuals.SetCooldownText = function(arg, cooldownTextShown)
							if arg.CooldownTextShown == cooldownTextShown then
								return
							end
							arg.CooldownTextShown = cooldownTextShown

							if arg.CooldownTextTween then
								arg.CooldownTextTween:Cancel()
							end

							if cooldownTextShown then
								arg.CooldownText.Visible = true
							end

							local tween = v86:Create(arg.CooldownText, TweenInfo.new(0.15), { TextTransparency = cooldownTextShown and v85[33] or 1, TextStrokeTransparency = cooldownTextShown and 0.05 or 1 })
							arg.CooldownTextTween = tween

							tween.Completed:Once(function(playbackState)
								if playbackState ~= Enum.PlaybackState.Completed or arg.CooldownTextTween ~= tween then
									return
								end

								if not cooldownTextShown then
									arg.CooldownText.Visible = false
								end

								arg.CooldownTextTween = nil
							end)

							tween:Play()
						end

						tbl25.Visuals.FormatAbilityTime = function(arg)
							local v109 = v85[115]
							local n33 = math.ceil(arg * 10) / v109
							return "(" .. ((n33 == math.floor(n33) and tostring(math.floor(n33)) or string.format("%.1f", n33)) .. "s") .. ")"
						end

						tbl25.Visuals.GetCooldownDuration = function(arg, arg2, arg3)
							local tbl26 = tbl25.Visuals.AbilityData[arg2] or {}
							local n33 = math.max((tonumber(tbl26.cooldown) or v85[33]) - (tonumber(tbl26.cooldownReductionPerUpgrade) or 0) * (arg3 - 1), 0)
							local n34

							if workspace:GetAttribute("CurrentlySelectedMode") == "Fates" then
								if arg:GetAttribute("Fates_DecreasedAbilityCooldown") then
									n34 = n33 * 0.7
								elseif arg:GetAttribute("Fates_IncreasedAbilityCooldown") then
									n34 = n33 * 1.4285714285714286
								else
									n34 = n33
								end
							else
								n34 = n33
							end

							return n34
						end

						tbl25.Visuals.IsAbilityAnimation = function(arg, arg2)
							local animation = arg2.Animation
							animation = animation and animation.AnimationId:match("%d+")
							if not animation then
								return false
							end
							local tbl26 = tbl25.Visuals.AbilityAnimations[arg]

							if not tbl26 then
								local character = localPlayer.Character
								character = character and character:FindFirstChild("Abilities")
								local v109 = character and character:FindFirstChild(arg) or v93.Shared.Abilities:FindFirstChild(arg)
								if not v109 then
									return false
								end
								tbl26 = {}

								for _, v110 in v109:GetDescendants() do
									if v110:IsA("Animation") then
										local match = v110.AnimationId:match("%d+")

										if match then
											tbl26[match] = true
										end
									end
								end

								if not next(tbl26) then
									return false
								end
								tbl25.Visuals.AbilityAnimations[arg] = tbl26
							end

							return tbl26[animation] == true
						end

						tbl25.Visuals.SetCooldown = function(arg, arg2, arg3, arg4)
							local serverTimeNow = workspace:GetServerTimeNow()
							local n33 = math.max(tonumber(arg:GetAttribute("CooldownExpiration")) or 0, tonumber(arg2:GetAttribute("CooldownExpiration")) or 0)
							local n34

							if arg4 > 0 then
								local n35 = math.max(tonumber(arg:GetAttribute("AbilityDurationStart")) or v85[33], tonumber(arg2:GetAttribute("AbilityDurationStart")) or 0)

								if n35 <= 0 or n35 > serverTimeNow or serverTimeNow - n35 > arg4 then
									n35 = serverTimeNow
								end

								n34 = math.max(n33, n35 + arg4)
							else
								if n33 <= serverTimeNow then
									return serverTimeNow
								end
								n34 = n33
							end

							flyteBBState.AbilityCooldowns[arg] = { Ability = arg3, Duration = arg4 > 0 and arg4 or n34 - serverTimeNow, Ends = n34 }
							return serverTimeNow
						end

						tbl25.Visuals.TrackCooldown = function(arg, arg2, arg3)
							local playerFromCharacter = v89:GetPlayerFromCharacter(arg)
							if not playerFromCharacter or playerFromCharacter == localPlayer or arg.Parent ~= alive then
								return
							end

							if not arg2 then
								arg2, arg3 = tbl25.Visuals.GetInfo(playerFromCharacter, arg)
							end

							if not arg2 then
								return
							end
							local v109 = tbl25.Visuals.GetCooldownDuration(playerFromCharacter, arg2, arg3)

							if arg2 == v85[156] then
								tbl25.Detection.TrackAbilityUse(playerFromCharacter, arg, arg2, arg3 + v85[18], v109)
							end

							local v110 = tbl25.Visuals.SetCooldown(playerFromCharacter, arg, arg2, v109)

							if arg2 == "Dash" then
								flyteBBState.AbilityActive[playerFromCharacter] = { Ability = arg2, Start = v110, Duration = v85[139], Ends = v110 + v85[139] }
							end
						end

						tbl25.Visuals.NativeNameVisible = function(arg, arg2)
							arg = arg and arg:FindFirstChildOfClass("Humanoid")
							if not arg or not arg2 or arg.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
								return false
							end

							if arg.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.Viewer then
								arg = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") or arg
							end

							local nameDisplayDistance = arg.NameDisplayDistance
							return nameDisplayDistance > 0 and (currentCamera.CFrame.Position - arg2.Position).Magnitude <= nameDisplayDistance
						end

						tbl25.Visuals.RefreshPlayer = function(arg, arg2)
							local v109 = tbl25.Visuals.GetESPCharacter(arg)
							local v110 = flyteBBState.ESPLabels[arg]
							local v111 = tbl25.Visuals.GetESPAdornee(v109)

							if not arg.Parent or not v109 or not v111 then
								tbl25.Visuals.DestroyLabel(v110)
								flyteBBState.ESPLabels[arg] = nil
								return
							end

							if not v110 or v110.Character ~= v109 or not v110.Billboard.Parent or v110.Billboard.Adornee ~= v111 then
								tbl25.Visuals.AddLabel(arg, v109)
								v110 = flyteBBState.ESPLabels[arg]
							end

							v110.Character = v109
							local duration2 = nil
							local uses = nil
							local v112 = nil
							local v113 = nil
							local v114 = nil
							local start = nil
							local v115 = nil
							local v116 = nil

							if tbl20.AbilityESPEnabled then
								v112, v115, v113, v114, uses, v116, start, duration2 = tbl25.Visuals.GetInfo(arg, v109, arg2)
							end

							local flag19 = v109.Parent == alive

							if not flag19 then
								flyteBBState.AbilityActive[arg] = nil
								flyteBBState.AbilityCooldowns[arg] = nil
								local v117 = flyteBBState.AbilityUses[arg]

								if v117 then
									if v117.Ability == "Slashes of Fury" then
										tbl25.Visuals.ClearFury(v117)
										flyteBBState.AbilityUses[arg] = nil
										uses = nil
									else
										v117.Uses = v117.Maximum
										uses = v117.Uses
									end
								end
							end

							local abilityESPEnabled = tbl20.AbilityESPEnabled and v112 or nil
							v110.Billboard.Enabled = abilityESPEnabled ~= nil or tbl20.AbilityESPShowNames
							v110.PlayerName.Text = arg.DisplayName
							v110.PlayerName.Visible = tbl20.AbilityESPShowNames and not tbl25.Visuals.NativeNameVisible(v109, v110.Billboard.Adornee)
							v110.Label.Visible = abilityESPEnabled ~= nil

							if abilityESPEnabled then
								v110.Label.Text = v112 .. (v115 > 1 and " v" .. tostring(v115) or "")
								v110.Icon.Visible = v113 ~= nil

								if v113 then
									v110.Icon.Image = v113
								end

								v110.Uses.Visible = uses ~= nil

								if uses ~= nil then
									v110.Uses.Text = tostring(uses) .. " " .. (uses == 1 and (v116 == "lives" and "life" or "use") or v116)
								end

								local v117 = flyteBBState.AbilityActive[arg]

								if v117 and v117.Ability == v112 and v117.Ends > arg2 then
									start = v117.Start
									duration2 = v117.Duration
								elseif v117 then
									flyteBBState.AbilityActive[arg] = nil
								end

								local duration3 = tbl25.Visuals.GetCooldownDuration(arg, v112, v115)
								local tbl26 = flyteBBState.AbilityCooldowns[arg]
								local flag20 = v112 == "Dribble" or v112 == "Dragon Spirit"
								local v118 = flag20 and flyteBBState.AbilityUses[arg]
								local expiration = flag20 and (v118 and v118.Ability == v112 and v118.Expiration or v85[33])

								if not expiration then
									expiration = math.max(tonumber(arg:GetAttribute("CooldownExpiration")) or 0, tonumber(v109:GetAttribute("CooldownExpiration")) or 0)
								end

								if flag19 and expiration > arg2 then
									if not tbl26 or tbl26.Ability ~= v112 or tbl26.Ends < expiration then
										tbl26 = { Ability = v112, Duration = duration3 > 0 and duration3 or expiration - arg2, Ends = expiration }
										flyteBBState.AbilityCooldowns[arg] = tbl26
									end
								elseif flag20 then
									flyteBBState.AbilityCooldowns[arg] = nil
									tbl26 = nil
								elseif not flag20 and flag19 and duration3 > v85[33] and start > v85[33] and v110.CooldownStart ~= start then
									v110.CooldownStart = start
									tbl26 = { Ability = v112, Duration = duration3, Ends = start + duration3 }
									flyteBBState.AbilityCooldowns[arg] = tbl26
								end

								local n33 = flag19 and tbl26 and tbl26.Ability == v112 and math.max(tbl26.Ends - arg2, 0) or 0
								duration3 = tbl26 and tbl26.Duration or duration3

								if not v114 and n33 > 0 and duration3 > 0 then
									local n34 = math.max(v85[18], v110.Icon.AbsoluteSize.Y * math.clamp(n33 / duration3, v85[33], 1))
									v110.Cooldown.Visible = v85[200]
									v110.Cooldown.Size = UDim2.new(1, v85[33], 0, n34)
									v110.CooldownText.Text = tbl25.Visuals.FormatAbilityTime(n33)
									tbl25.Visuals.SetCooldownText(v110, v85[200])
								else
									v110.Cooldown.Visible = v85[101]
									tbl25.Visuals.SetCooldownText(v110, false)
								end

								local n34 = duration2 > 0 and math.clamp((arg2 - start) / duration2, 0, 1) or 1

								if flag19 and not v114 and start > 0 and n34 < 1 and v112 ~= "Rapture" and v112 ~= "Raging Deflection" and v112 ~= "Calming Deflection" then
									if v110.DurationTween then
										v110.DurationTween:Cancel()
										v110.DurationTween = nil
									end

									v110.DurationHolder.GroupTransparency = 0
									v110.DurationHolder.Visible = true
									v110.DurationText.Text = tbl25.Visuals.FormatAbilityTime(duration2 - arg2 - start)

									if v110.DurationStart ~= start or v110.DurationTime ~= duration2 then
										if v110.DurationProgressTween then
											v110.DurationProgressTween:Cancel()
										end

										v110.DurationStart = start
										v110.DurationTime = duration2
										v110.Duration.Size = UDim2.new(1, 0, 1 - n34, v85[33])
										v110.DurationProgressTween = v86:Create(v110.Duration, TweenInfo.new(duration2 * (1 - n34), Enum.EasingStyle.Linear), { Size = UDim2.new(v85[18], 0, 0, v85[33]) })
										v110.DurationProgressTween:Play()
									end
								else
									if v110.DurationProgressTween then
										v110.DurationProgressTween:Cancel()
										v110.DurationProgressTween = nil
									end

									v110.DurationStart = nil
									v110.DurationTime = nil

									if v110.DurationHolder.Visible then
										if not v110.DurationTween then
											tbl25.Visuals.HideDuration(v110)
										end
									else
										v110.Duration.Position = UDim2.new(v85[33], 0, v85[18], v85[33])
										v110.Duration.Size = UDim2.new(1, 0, 1, 0)
									end
								end
							else
								v110.Icon.Visible = v85[101]
								v110.Uses.Visible = false
								v110.Cooldown.Visible = false
								v110.CooldownText.Visible = false
								v110.CooldownTextShown = false

								if v110.CooldownTextTween then
									v110.CooldownTextTween:Cancel()
								end

								v110.CooldownTextTween = nil

								if v110.DurationTween then
									v110.DurationTween:Cancel()
								end

								if v110.DurationProgressTween then
									v110.DurationProgressTween:Cancel()
								end

								v110.DurationTween = nil
								v110.DurationProgressTween = nil
								v110.DurationHolder.Visible = false
								v110.DurationHolder.GroupTransparency = 0
								v110.DurationStart = nil
								v110.DurationTime = nil
							end
						end

						tbl25.Visuals.RefreshESP = function()
							if not tbl20.AbilityESPEnabled and not tbl20.AbilityESPShowNames then
								return
							end
							local serverTimeNow = workspace:GetServerTimeNow()

							for _, v109 in v89:GetPlayers() do
								if v109 ~= localPlayer then
									pcall(tbl25.Visuals.RefreshPlayer, v109, serverTimeNow)
								end
							end
						end

						tbl25.Visuals.RefreshLoop = function()
							fn42("Ability ESP")
							if not tbl20.AbilityESPEnabled and not tbl20.AbilityESPShowNames then
								return
							end

							flyteBBState.Connections["Ability ESP"] = task.spawn(function()
								while tbl20.AbilityESPEnabled or tbl20.AbilityESPShowNames do
									tbl25.Visuals.RefreshESP()
									task.wait(v85[113])
								end
							end)
						end

						tbl25.Visuals.ObserveCooldowns = function()
							local activateAbility = v93.Remotes:FindFirstChild("ActivateAbility")

							if activateAbility then
								flyteBBState.Connections["Ability Cooldown"] = activateAbility.OnClientEvent:Connect(function(arg)
									tbl25.Visuals.TrackCooldown(arg)
								end)
							end

							local plrDragonSummonedEvent = v93.Remotes:FindFirstChild("PlrDragonSummonedEvent")

							if plrDragonSummonedEvent then
								flyteBBState.Connections["Dragon Spirit Uses"] = plrDragonSummonedEvent.OnClientEvent:Connect(function(arg)
									local playerFromCharacter = v89:GetPlayerFromCharacter(arg)
									if not playerFromCharacter or playerFromCharacter == localPlayer or workspace:GetAttribute("GoldenAbilities") then
										return
									end
									local v109, v110 = tbl25.Visuals.GetInfo(playerFromCharacter, arg)

									if v109 == "Dragon Spirit" then
										tbl25.Detection.TrackAbilityUse(playerFromCharacter, arg, v109, v110 + 1, tbl25.Visuals.GetCooldownDuration(playerFromCharacter, v109, v110))
									end
								end)
							end
						end

						tbl25.Visuals.ObserveCooldowns()

						do
							local function fn73()
								if not flyteBBState.Loaded or not flyteBBState.AccuracyWarningReady or flyteBBState.AccuracyWarned then
									return
								end
								local parryAccuracy = tbl20.RandomizedParryAccuracy and (tbl20.RandomAccuracyMin + tbl20.RandomAccuracyMax) * 0.5 or tbl20.ParryAccuracy

								if v96 and parryAccuracy >= 80 and v96 >= 300 - parryAccuracy then
									flyteBBState.AccuracyWarned = true
									v103:Notify({ Title = "Your accuracy is likely too high for your current ping.", Duration = 5 })
								end
							end

							v103 = v100.new({ Name = "Flyte", AccentColor = colors.Accent })
							tbl24 = { toggles = {}, sliders = {}, dropdowns = {}, textboxes = {} }

							local function fn74()
								local v109 = v103:CreateSection({ Name = "Flyte", Icon = "rbxassetid://76499042599127" })

								local function fn75(arg)
									return v109:AddTab({ Name = arg, Description = "Main", Icon = "rbxassetid://76499042599127" })
								end

								local Main = fn75("Main")
								local Detections = fn75("Detections")
								local Misc = fn75("Misc")
								local Optimizations = fn75("Optimizations")
								local Settings = fn75("Settings")

								local function fn76(arg, arg2, arg3)
									local v110 = arg and tbl24.toggles[arg]
									local flag19 = not flyteBBState.Loaded

									if not flag19 then
										if arg then
											flag19 = not (v110 and v110.notify)
										else
											flag19 = arg
										end
									end

									if flag19 then
										return
									end
									v103:Notify({ Title = "Switched to " .. arg2 .. " " .. arg3, Duration = 2 })
								end

								local function fn77()
									local v110 = Main:AddGroup({ Name = "Parry", Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Auto_Parry = v110:AddToggle({
										Name = "Auto Parry",
										SaveId = "Auto_Parry",
										Default = false,
										Notify = true,
										Callback = function(autoParryEnabled)
											tbl20.AutoParryEnabled = autoParryEnabled
											if not flyteBBState.Loaded then
												return
											end

											if autoParryEnabled and tbl20.TriggerbotEnabled then
												flyteBBState.AutoParryTriggerbot = v85[200]
												flyteBBState.TriggerbotAutoParry = nil
												local triggerbot = tbl24 and tbl24.toggles.Triggerbot

												if triggerbot and triggerbot.Set then
													triggerbot:Set(false)
												else
													tbl25.Triggerbot.SetEnabled(v85[101])
												end
											elseif not autoParryEnabled and flyteBBState.AutoParryTriggerbot then
												flyteBBState.AutoParryTriggerbot = nil
												local triggerbot = tbl24 and tbl24.toggles.Triggerbot

												if triggerbot and triggerbot.Set then
													triggerbot:Set(true)
												else
													tbl25.Triggerbot.SetEnabled(true)
												end
											end

											if autoParryEnabled then
												fn68(true)
												task.defer(tbl25.Loop.MainParryLoop)
											end
										end,
									})

									tbl24.toggles.Anti_Curve = v110:AddToggle({
										Name = "Anticurve",
										SaveId = "Anticurve",
										Default = v85[200],
										Callback = fn44("AntiCurveEnabled", function()
											for _, v111 in obj2, nil, nil do
												fn66(v111)
											end
										end),
									})

									tbl24.toggles.Backwards_Anti_Curve = v110:AddToggle({
										Name = "Backwards Anticurve",
										SaveId = "Backwards_Anticurve",
										Default = true,
										Callback = fn44("BackwardsAntiCurveEnabled", function(arg)
											for k, v111 in obj2, nil, nil do
												fn64(v111)

												if arg then
													fn62(k, v111)
												end
											end
										end),
									})

									tbl24.dropdowns.Parry_Type = v110:AddDropdown({
										Name = "Parry Type",
										SaveId = "Auto_Parry_Type",
										Options = { v85[90], "VIM", "Mouse Click" },
										Default = "Remote",
										Callback = fn44("AutoParryType", function(arg)
											fn76("Auto_Parry", arg, "mode")
										end),
									})

									tbl24.dropdowns.Curve_Type = v110:AddDropdown({
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
										Callback = function(selectedParryType)
											tbl20.SelectedParryType = selectedParryType
											fn76("Auto_Parry", selectedParryType, "type")
										end,
									})

									tbl24.dropdowns.Parry_Loop = v110:AddDropdown({
										Name = "Parry Loop",
										SaveId = "Parry_Loop_Type",
										Options = { "PreSimulation", "PreRender" },
										Default = "PreSimulation",
										Callback = function(parryLoopType)
											tbl20.ParryLoopType = parryLoopType
											if not flyteBBState.Loaded then
												return
											end
											fn42("Auto Parry")
											flyteBBState.Connections["Auto Parry"] = (parryLoopType == "PreRender" and v88.PreRender or v88.PreSimulation):Connect(tbl25.Loop.MainParryLoop)
										end,
									})

									v110:AddDivider()

									tbl24.sliders.ParryAccuracy = v110:AddSlider({
										Name = "Accuracy",
										SaveId = "Parry_Accuracy",
										Min = 1,
										Max = v85[158],
										Default = 1,
										Increment = 1,
										Callback = fn44("ParryAccuracy"),
										OnCommit = fn73,
									})

									tbl24.sliders.ParryRange = v110:AddSlider({
										Name = "Parry Range",
										SaveId = "Parry_Range",
										Min = 0,
										Max = 10,
										Default = 0,
										Increment = 1,
										Callback = fn44("ParryRange"),
									})

									v110:AddDivider()

									tbl24.toggles.RandomizedParryAccuracy = v110:AddToggle({
										Name = "Randomize Accuracy",
										SaveId = "Randomized_Parry_Accuracy",
										Default = false,
										Callback = fn44("RandomizedParryAccuracy", fn73),
									})

									tbl24.sliders.Random_Accuracy_Range = v110:AddDoubleSlider({
										Name = "Accuracy Range",
										SaveId = "Randomized_Parry_Accuracy_Range",
										Min = 1,
										Max = 100,
										DefaultMin = 1,
										DefaultMax = 100,
										Increment = 1,
										Callback = function(randomAccuracyMin, randomAccuracyMax)
											tbl20.RandomAccuracyMin = randomAccuracyMin
											tbl20.RandomAccuracyMax = randomAccuracyMax
										end,
										OnCommit = fn73,
									})

									v110:AddDivider()

									tbl24.toggles.Auto_Preclick = v110:AddToggle({
										Name = "Auto Preclick",
										SaveId = "Auto_Preclick",
										Default = false,
										Callback = function(autoPreclickEnabled)
											tbl20.AutoPreclickEnabled = autoPreclickEnabled

											if autoPreclickEnabled then
												fn71()
											else
												fn72()
											end
										end,
									})

									tbl24.toggles.PreclickForAll = v110:AddToggle({
										Name = "Preclick For All",
										SaveId = "Preclick_For_All",
										Default = false,
										Callback = fn44("PreclickForAll"),
									})

									tbl24.sliders.PreclickDelay = v110:AddSlider({
										Name = "Preclick Delay (MS)",
										SaveId = "Preclick_Delay",
										Min = v85[33],
										Max = 150,
										Default = 135,
										Increment = 1,
										Suffix = "ms",
										Callback = fn44("PreclickDelay"),
									})

									tbl24.sliders.PreclickAfterVelocity = v110:AddSlider({
										Name = "Preclick After Velocity",
										SaveId = "Preclick_After_Velocity",
										Min = 0,
										Max = 1000,
										Default = v85[33],
										Increment = v85[18],
										Callback = fn44("PreclickAfterVelocity"),
									})

									v110:AddDivider()

									tbl24.toggles.Cooldown_Protection = v110:AddToggle({
										Name = "Cooldown Protection",
										SaveId = "Cooldown_Protection",
										Default = false,
										Callback = fn44("CooldownProtectionEnabled"),
									})

									tbl24.toggles.Auto_Ability = v110:AddToggle({
										Name = "Auto Ability",
										SaveId = "Auto_Ability",
										Default = false,
										Callback = fn44("AutoAbilityEnabled"),
									})

									local v111 = Main:AddGroup({ Name = "Auto Spam", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Auto_Spam = v111:AddToggle({
										Name = "Auto Spam",
										SaveId = "Auto_Spam",
										Default = false,
										Notify = true,
										Callback = function(autoSpamEnabled)
											tbl20.AutoSpamEnabled = autoSpamEnabled

											if flyteBBState.Loaded then
												tbl25.Loop.RefreshAutoSpam()
											end
										end,
									})

									tbl24.toggles.AutoSpamAnimFix = v111:AddToggle({
										Name = "Animation Fix",
										SaveId = "Auto_Spam_Anim_Fix",
										Default = true,
										Callback = fn44("AutoSpamAnimFix"),
									})

									tbl24.dropdowns.Spam_Type = v111:AddDropdown({
										Name = "Spam Type",
										SaveId = "Auto_Spam_Type",
										Options = { "Remote", "VIM", "Mouse Click" },
										Default = "Remote",
										Callback = fn44("AutoSpamType", function(arg)
											fn76(nil, arg, "spam mode")
										end),
									})

									tbl24.dropdowns.AutoSpamAnimFixType = v111:AddDropdown({
										Name = "Anim Fix Type",
										SaveId = "Auto_Spam_Anim_Fix_Type",
										Options = { "Animation + Click", "Animation", "Click" },
										Default = "Animation",
										Callback = fn44("AutoSpamAnimFixType"),
									})

									v111:AddDivider()
									local fn78 = nil

									tbl24.toggles.Dynamic_Threshold = v111:AddToggle({
										Name = "Dynamic Threshold",
										SaveId = "Dynamic_Spam_Threshold",
										Default = false,
										Callback = function(dynamicSpamThreshold)
											tbl20.DynamicSpamThreshold = dynamicSpamThreshold

											if fn78 then
												fn78(not dynamicSpamThreshold)
											end
										end,
									})

									tbl24.sliders.Spam_Threshold = v111:AddSlider({
										Name = "Threshold",
										SaveId = "Auto_Spam_Threshold",
										Min = v85[18],
										Max = 4,
										Default = v85[70],
										Increment = v85[18],
										Callback = function(arg)
											tbl20.AutoSpamThreshold = math.round(arg)
										end,
									})

									local spamThreshold = tbl24.sliders.Spam_Threshold
									local offset = spamThreshold.labelText.Position.Y.Offset
									spamThreshold.backgroundFrame.ClipsDescendants = v85[200]
									local n33 = 0

									local function fn79(arg, arg2, arg3)
										if arg3 > v85[33] then
											v101(arg, arg2, arg3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
										else
											for k, v112 in arg2, nil, nil do
												arg[k] = v112
											end
										end
									end

									fn78 = function(arg, arg2)
										n33 += v85[18]
										local v112 = n33
										arg2 = arg2 and v85[33] or 0.34
										local n34 = arg and 0 or 1
										local n35 = arg and offset or offset + 8

										if arg then
											spamThreshold.labelText.Visible = true
											spamThreshold.valueBox.Visible = v85[200]
											spamThreshold.backgroundFrame.Visible = true
										end

										v111.elementYPos = offset + (arg and 40 or v85[33])

										if v111.UpdateSize then
											v111.UpdateSize(arg2)
										end

										fn79(spamThreshold.labelText, { Position = UDim2.new(0, 10, 0, n35), TextTransparency = n34 }, arg2)
										fn79(spamThreshold.valueBox, { Position = UDim2.new(v85[18], -95, 0, n35), TextTransparency = n34 }, arg2)

										fn79(spamThreshold.backgroundFrame, {
											Position = UDim2.new(0, v85[115], 0, n35 + v85[185]),
											Size = UDim2.new(0, spamThreshold.backgroundFrame.Size.X.Offset, 0, arg and 5 or 0),
											BackgroundTransparency = n34,
										}, arg2)

										fn79(spamThreshold.fillFrame, { BackgroundTransparency = n34 }, arg2)

										task.delay(arg2, function()
											local v113 = arg
											local flag19

											if arg then
												flag19 = v113
											else
												flag19 = v112 ~= n33
											end

											if flag19 then
												return
											end
											spamThreshold.labelText.Visible = false
											spamThreshold.valueBox.Visible = false
											spamThreshold.backgroundFrame.Visible = false
										end)
									end

									fn78(not tbl20.DynamicSpamThreshold, v85[200])
									local v112 = Main:AddGroup({ Name = "Manual Spam", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Manual_Spam = v112:AddToggle({
										Name = "Manual Spam",
										SaveId = "Manual_Spam",
										NoSave = v85[200],
										Default = false,
										Notify = v85[200],
										Callback = tbl25.ManualSpam.SetEnabled,
									})

									tbl24.toggles.Manual_Spam_UI = v112:AddToggle({
										Name = "Manual UI (Mobile)",
										SaveId = "Manual_Spam_UI",
										Default = v85[101],
										Callback = fn44("ManualSpamUIEnabled", tbl25.ManualSpam.Refresh),
									})

									tbl24.toggles.ManualSpamAnimFix = v112:AddToggle({
										Name = "Manual Animation Fix",
										SaveId = "Manual_Spam_Anim_Fix",
										Default = true,
										Callback = fn44("ManualSpamAnimFix"),
									})

									tbl24.dropdowns.ManualSpamType = v112:AddDropdown({
										Name = "Manual Type",
										SaveId = "Manual_Spam_Type",
										Options = { v85[90], "VIM", v85[191] },
										Default = "Remote",
										Callback = fn44("ManualSpamType"),
									})

									tbl24.dropdowns.ManualSpamAnimFixType = v112:AddDropdown({
										Name = "Anim Fix Type",
										SaveId = "Manual_Spam_Anim_Fix_Type",
										Options = { "Animation + Click", "Animation", "Click" },
										Default = "Animation",
										Callback = fn44("ManualSpamAnimFixType"),
									})

									local v113 = Main:AddGroup({ Name = "Triggerbot", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Triggerbot = v113:AddToggle({
										Name = "Triggerbot",
										NotifyName = "Triggerbot",
										SaveId = "Triggerbot",
										Default = v85[101],
										Notify = true,
										Callback = function(arg)
											tbl25.Triggerbot.SetEnabled(arg)
										end,
									})

									tbl24.toggles.Triggerbot_UI = v113:AddToggle({
										Name = "Triggerbot UI (Mobile)",
										SaveId = "Triggerbot_UI",
										Default = false,
										Callback = fn44("TriggerbotUIEnabled", tbl25.Triggerbot.RefreshUI),
									})

									tbl24.dropdowns.TriggerbotType = v113:AddDropdown({
										Name = "Triggerbot Type",
										SaveId = "Triggerbot_Type",
										Options = { "Remote", "VIM", "Mouse Click" },
										Default = v85[90],
										Callback = fn44("TriggerbotType", function(arg)
											fn76("Triggerbot", arg, "triggerbot mode")
										end),
									})

									tbl24.sliders.Triggerbot_MS = v113:AddSlider({
										Name = "Delay (MS)",
										SaveId = "Triggerbot_Delay",
										Min = 0,
										Max = 200,
										Default = v85[33],
										Increment = v85[18],
										Callback = fn44("TriggerbotDelay"),
									})

									tbl24.toggles.Triggerbot_Randomize_MS = v113:AddToggle({
										Name = "Randomize Delay",
										SaveId = "Triggerbot_Randomize",
										Default = false,
										Callback = fn44("TriggerbotRandomize"),
									})

									tbl24.sliders.Triggerbot_MS_Range = v113:AddDoubleSlider({
										Name = "Delay Range",
										SaveId = "Triggerbot_Delay_Range",
										Min = 0,
										Max = 200,
										DefaultMin = v85[33],
										DefaultMax = 200,
										Increment = 1,
										Callback = function(triggerbotDelayMin, triggerbotDelayMax)
											tbl20.TriggerbotDelayMin = triggerbotDelayMin
											tbl20.TriggerbotDelayMax = triggerbotDelayMax
										end,
									})

									tbl24.toggles.Triggerbot_No_Spawn_Parry = v113:AddToggle({
										Name = "Don't Parry On Ball Spawn",
										SaveId = "Triggerbot_Ignore_Spawn",
										Default = false,
										Callback = fn44("TriggerbotIgnoreSpawn"),
									})
								end

								local function fn78()
									local v110 = Detections:AddGroup({ Name = "Fury", Side = v85[150], Icon = "rbxassetid://10723427199" })

									tbl24.toggles.FuryDetection = v110:AddToggle({
										Name = "SOF Detection",
										SaveId = "Fury_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("FuryDetection"),
									})

									tbl24.toggles.Auto_Hit_SOF = v110:AddToggle({ Name = "Auto Hit", SaveId = "Fury_Spam_Hit", Default = false, Callback = fn44("FurySpamHit") })

									tbl24.dropdowns.FuryParryMethod = v110:AddDropdown({
										Name = "Parry Method",
										SaveId = "Fury_Parry_Method",
										Options = { v85[90], "VIM", "Mouse Click" },
										Default = "Remote",
										Callback = fn44("FuryParryMethod"),
									})

									tbl24.sliders.FuryParryAmount = v110:AddSlider({
										Name = "Parry Amount",
										SaveId = "Fury_Parry_Amount",
										Default = 1,
										Min = 1,
										Max = v85[59],
										Increment = 1,
										Callback = fn44("FuryParryAmount"),
									})

									tbl24.sliders.FuryParryDelay = v110:AddSlider({
										Name = "Parry Delay",
										SaveId = "Fury_Parry_Delay",
										Default = 0.12,
										Min = 0.02,
										Max = 0.25,
										Increment = 0.01,
										Callback = fn44("FuryParryDelay"),
									})

									tbl24.toggles.SingularityDetection = Detections:AddGroup({ Name = "Singularity", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Singularity Detection",
										SaveId = "Singularity_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("SingularityDetection"),
									})

									tbl24.toggles.TimeHoleDetection = Detections:AddGroup({ Name = "Time Hole", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Time Hole Detection",
										SaveId = "Time_Hole_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("TimeholeDetection"),
									})

									tbl24.toggles.InfinityDetection = Detections:AddGroup({ Name = "Infinity", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Infinity Detection",
										SaveId = "Infinity_Detection",
										Default = false,
										Notify = v85[200],
										Callback = fn44("InfinityDetection"),
									})

									tbl24.toggles.FreezeDetection = Detections:AddGroup({ Name = "Freeze", Side = "Left", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Freeze Detection",
										SaveId = "Freeze_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("FreezeDetection"),
									})

									local v111 = Detections:AddGroup({ Name = "Dribble", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.ParryOnDribble = v111:AddToggle({
										Name = "Parry On Dribble",
										SaveId = "Parry_On_Dribble",
										Default = false,
										Notify = true,
										Callback = fn44("ParryOnDribble"),
									})

									tbl24.toggles.DribbleDetection = v111:AddToggle({
										Name = "Parry On Self Dribble",
										SaveId = "Dribble_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("DribbleDetection", function(arg)
											if not arg then
												flyteBBState.SelfDribbleBall = nil
												flyteBBState.SelfDribbleAway = nil
											end
										end),
									})

									local v112 = Detections:AddGroup({ Name = "Phantom", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Anti_Phantom = v112:AddToggle({
										Name = "Anti Phantom",
										SaveId = "Anti_Phantom",
										Default = false,
										Notify = true,
										Callback = function(antiPhantomEnabled)
											tbl20.AntiPhantomEnabled = antiPhantomEnabled

											if not antiPhantomEnabled and flyteBBState.PhantomData and flyteBBState.PhantomData.Name == "Phantom" then
												tbl25.Phantom.Reset()
											end

											if flyteBBState.Loaded then
												tbl25.Loop.RefreshAutoSpam()
											end
										end,
									})

									local antiPhantomMode = tbl19.Dropdowns.AntiPhantomMode

									if antiPhantomMode ~= "Blatant" and antiPhantomMode ~= "Legit" then
										antiPhantomMode = "Legit"
									end

									tbl24.dropdowns.AntiPhantomMode = v112:AddDropdown({
										Name = "Mode",
										SaveId = "Anti_Phantom_Mode",
										Options = { "Legit", "Blatant" },
										Default = antiPhantomMode,
										Callback = function(arg)
											tbl20.AntiPhantomBlatant = arg == "Blatant"
										end,
									})

									tbl24.dropdowns.AntiPhantomType = v112:AddDropdown({
										Name = "Legit Type",
										SaveId = "Anti_Phantom_Type",
										Options = { "Spam", "Ability" },
										Default = "Spam",
										Callback = fn44("AntiPhantomType"),
									})

									local v113 = Detections:AddGroup({ Name = "Flash Counter", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Anti_Flash_Counter = v113:AddToggle({
										Name = "Anti Flash Counter",
										SaveId = "Anti_Flash_Counter",
										Default = false,
										Notify = true,
										Callback = function(antiFlashCounterEnabled)
											tbl20.AntiFlashCounterEnabled = antiFlashCounterEnabled

											if not antiFlashCounterEnabled and flyteBBState.PhantomData and flyteBBState.PhantomData.Name == "Flash Counter" then
												tbl25.Phantom.Reset()
											end

											if flyteBBState.Loaded then
												tbl25.Loop.RefreshAutoSpam()

												if n25 > 6622 then
													while v85[200] do
													end
												end
											end
										end,
									})

									local antiFlashCounterMode = tbl19.Dropdowns.AntiFlashCounterMode

									if antiFlashCounterMode ~= "Blatant" and antiFlashCounterMode ~= "Legit" then
										antiFlashCounterMode = "Legit"
									end

									tbl24.dropdowns.AntiFlashCounterMode = v113:AddDropdown({
										Name = "Mode",
										SaveId = "Anti_Flash_Counter_Mode",
										Options = { "Legit", "Blatant" },
										Default = antiFlashCounterMode,
										Callback = function(arg)
											tbl20.AntiFlashCounterBlatant = arg == "Blatant"
										end,
									})

									tbl24.dropdowns.AntiFlashCounterType = v113:AddDropdown({
										Name = "Legit Type",
										SaveId = "Anti_Flash_Counter_Type",
										Options = { "Spam", "Ability" },
										Default = "Spam",
										Callback = fn44("AntiFlashCounterType"),
									})

									local v114 = Detections:AddGroup({ Name = "Quasar", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Anti_Blindness = v114:AddToggle({
										Name = "Anti Blindness",
										SaveId = "Anti_Blindness",
										Default = false,
										Notify = true,
										Callback = fn44("AntiBlindness", tbl25.Quasar.SetBlindness),
									})

									tbl24.toggles.Anti_Disorientate = v114:AddToggle({
										Name = "Anti Disorientate",
										SaveId = "Anti_Disorientate",
										Default = false,
										Notify = true,
										Callback = fn44("AntiDisorientate", tbl25.Quasar.SetDisorientate),
									})

									local v115 = Detections:AddGroup({ Name = "Death Slash", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.DeathSlashDetection = v115:AddToggle({
										Name = "Death Slash Detection",
										SaveId = "Death_Slash_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("DeathSlashDetection"),
									})

									tbl24.toggles.DeathSlashMinigame = v115:AddToggle({
										Name = "Do Minigame",
										SaveId = "Death_Slash_Minigame",
										Default = v85[101],
										Callback = fn44("DeathSlashMinigame"),
									})

									tbl24.toggles.ForcefieldDetection = Detections:AddGroup({ Name = "Forcefield", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Forcefield Detection",
										SaveId = "Forcefield_Detection",
										Default = false,
										Notify = true,
										Callback = fn44("ForcefieldDetection"),
									})
								end

								local function fn79()
									local v110 = Optimizations:AddGroup({ Name = "Rendering", Side = v85[150], Icon = "rbxassetid://10723427199" })
									tbl24.toggles.No_Render = v110:AddToggle({ Name = "No Render", SaveId = "No_Render", Default = false, Callback = tbl25.Render.DisableFX })
									tbl24.toggles.Anti_Lag = v110:AddToggle({ Name = "Anti-Lag", SaveId = "Anti_Lag", Default = v85[101], Callback = tbl25.Render.SetAntiLag })

									local function fn80(arg, arg2, arg3, arg4, arg5, arg6)
										if not setfflag or not getfflag then
											return false, 0
										end
										local flyteFFlagDefaults = rawget(getgenv(), "FlyteFFlagDefaults")
										local v111 = v85[145]

										if type(flyteFFlagDefaults) ~= v111 then
											flyteFFlagDefaults = {}
											getgenv().FlyteFFlagDefaults = flyteFFlagDefaults
										end

										local tbl26 = {}
										local tbl27 = {}

										for k in arg, nil, nil do
											if type(k) == "string" and k ~= "" then
												local str5 = k:gsub("^D?F[FISL][a-z]*", "")
												local ok, result = pcall(getfflag, str5)

												if ok and result ~= nil then
													tbl26[#tbl26 + v85[18]] = k
													tbl27[k] = str5

													if arg6 ~= v85[101] and flyteFFlagDefaults[str5] == nil then
														flyteFFlagDefaults[str5] = result
													end
												else
													arg[k] = nil
												end
											else
												arg[k] = nil
											end
										end

										table.sort(tbl26)
										arg2 = arg2 or v85[115]
										arg3 = arg3 or 0.07
										local n33 = 0

										for i = v85[18], #tbl26, arg2 do
											for i2 = i, math.min(i + arg2 - 1, #tbl26) do
												local v112 = tbl26[i2]
												local v113 = arg[v112]
												local kind = type(v113)
												local str5

												if kind == v85[109] then
													str5 = tostring(v113)
												elseif kind == "boolean" then
													str5 = v113 and "True" or "False"
												elseif kind == v85[145] then
													str5 = v91:JSONEncode(v113)
												elseif kind == "string" then
													str5 = v113
												else
													str5 = nil
												end

												if str5 and pcall(setfflag, tbl27[v112], str5) then
													n33 += 1
												end
											end

											task.wait(arg3)
										end

										if n33 <= 0 then
											return v85[101], n33
										end

										if arg6 == false then
											getgenv().FlyteFFlagsApplied = nil
										else
											getgenv().FlyteFFlagsApplied = true
										end

										queueonteleport(arg6 == false and "getgenv().FlyteFFlagsApplied=nil;getgenv().FlyteFFlagDefaults=nil" or ("getgenv().FlyteFFlagsApplied=true;getgenv().FlyteFFlagDefaults=game:GetService('HttpService'):JSONDecode(%s)"):format(v91:JSONEncode(v91:JSONEncode(flyteFFlagDefaults))))

										if arg5 then
											arg5(n33)
										end

										task.wait(arg4 or 0.5)
										game.ExperienceService:LaunchExperience({ placeId = game.PlaceId })
										return true, n33
									end

									local function fn81(arg)
										local function fn82(arg2)
											local ok, result = pcall(v91.JSONDecode, v91, arg2)
											local result2

											if ok and type(result) == "string" then
												ok, result2 = pcall(v91.JSONDecode, v91, result)
											else
												result2 = result
											end

											return ok and type(result2) == "table" and result2 or nil
										end

										local v111 = fn82(arg)
										if v111 then
											return v111
										end
										local tbl26 = {}
										local n33 = 1
										local n34 = 1

										while n33 <= #arg do
											local pos = arg:find("\"", n33, v85[200])

											if pos then
												local pos2 = arg:find("%S", pos + 1)
												local v112 = pos2 and arg:byte(pos2)

												if v112 ~= 91 and v112 ~= 123 then
													n33 = pos + v85[18]
												else
													local v113 = v85[33]
													local flag19 = false
													local flag20 = false
													local v114 = nil

													for i = pos2, #arg do
														local v115 = arg:byte(i)

														if flag19 then
															if flag20 then
																flag20 = v85[101]
																v114 = nil
															elseif v115 == 92 then
																flag20 = true
																v114 = nil
															elseif v115 ~= 34 then
																v114 = nil
															else
																flag19 = false
																v114 = nil
															end
														elseif v115 == v85[97] then
															flag19 = true
															v114 = nil
														elseif v115 == 91 or v115 == 123 then
															v113 += 1
															v114 = nil
														elseif v115 == 93 or v115 == 125 then
															v113 -= 1

															if v113 ~= v85[33] then
																v114 = nil
															else
																v114 = i
																break
															end
														else
															v114 = nil
														end
													end

													local pos3 = v114 and arg:find("%S", v114 + v85[18])
													local pos4 = pos3 and arg:find("%S", pos3 + v85[18])
													local v115 = pos4 and arg:byte(pos4)
													local str5 = v114 and arg:sub(pos2, v114)
													local flag21 = pos3 and arg:byte(pos3) == 34

													if flag21 then
														flag21 = not v115 or v115 == 44 or v115 == 93 or v115 == 125
													end

													if flag21 and fn82(str5) then
														tbl26[#tbl26 + 1] = arg:sub(n34, pos - v85[18])
														tbl26[#tbl26 + 1] = str5
														n33 = pos3 + v85[18]
														n34 = n33
													else
														n33 = pos + 1
													end
												end

												continue
											end

											break
										end

										if #tbl26 == 0 then
											return nil
										end
										tbl26[#tbl26 + 1] = arg:sub(n34)
										return (fn82(table.concat(tbl26)))
									end

									local function fn82(arg)
										local match = tostring(arg or ""):gsub("^\u{FEFF}", ""):match("^%s*(.-)%s*$")
										if match == "" then
											v103:Notify({ Title = "empty custom fflags" })
											return false
										end
										local v111 = fn81(match)
										if not v111 then
											v103:Notify({ Title = "invalid custom fflags json" })
											return false
										end

										local function fn83()
											local json = v91:JSONEncode(v111)
											local fFlagsCustomText = tbl24.textboxes.FFlags_Custom_Text

											if fFlagsCustomText then
												fFlagsCustomText:Set(json)
											else
												tbl20.CustomFFlagsText = json
											end
										end

										v103:Notify({ Title = "Enabled", Duration = v85[18] })

										if not fn80(v111, 60, 0.01, 0.04, function()
											fn83()
											v103:Notify({ Title = "Rejoining...", Duration = v85[18] })
										end) then
											fn83()
											v103:Notify({ Title = "no custom fflags applied" })
											return false
										end

										return true
									end

									local tbl26 = {
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

									local tbl27 = {
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

									local function fn83(arg)
										if not setfflag or not getfflag then
											if not flag2 then
												return
											end
											return
										end

										arg = tbl26[tbl27[arg] or arg] or arg

										fn80({
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
											FStringNetworkDefaultDNSResolveRegion = arg,
											FStringForceHttpProxyRegion = arg,
											FStringForceFastConnectRegion = arg,
											FStringPreferredClientRegion = arg,
											FStringMatchmakingRegion = arg,
											FStringDataStoreRegion = arg,
											FStringClientTelemetryRegionOverride = arg,
											FStringForceRegion = arg,
											FStringOverrideRegion = arg,
											FStringForceGameServerRegion = arg,
										}, 10, 0.07, v85[81])
									end

									local flag19 = false
									local v111 = Optimizations:AddGroup({ Name = "FFlags", Side = "Right", Icon = "rbxassetid://10723427199" })
									local fn84 = nil

									tbl24.toggles.FFlags_Enable = v111:AddToggle({
										Name = "Apply & Rejoin",
										SaveId = "FFlags",
										NoSave = v85[200],
										Default = rawget(getgenv(), "FlyteFFlagsApplied") == true,
										Callback = function(arg)
											if not flyteBBState.Loaded or flag19 then
												return
											end
											flag19 = true

											task.spawn(function()
												if arg then
													if tbl20.CustomFFlags then
														local fFlagsCustomText = tbl24.textboxes.FFlags_Custom_Text
														fn82(fFlagsCustomText and fFlagsCustomText.textbox and fFlagsCustomText.textbox.Text or tbl20.CustomFFlagsText)
													else
														fn83(tbl20.FFlagsRegion or "us-east")
													end
												else
													local value = rawget(getgenv(), "FlyteFFlagDefaults")

													if type(value) == "table" and next(value) then
														v103:Notify({ Title = "Disabled", Duration = 1 })
														fn80(value, v85[115], 0.07, v85[81], nil, v85[101])
													end
												end

												flag19 = v85[101]
											end)
										end,
									})

									tbl24.toggles.FFlags_Custom = v111:AddToggle({
										Name = "Custom FFlags",
										SaveId = "Custom_FFlags",
										Default = v85[101],
										Callback = function(customFFlags)
											tbl20.CustomFFlags = customFFlags

											if fn84 then
												fn84(customFFlags)
											end
										end,
									})

									tbl24.dropdowns.FFlagsRegion = v111:AddDropdown({
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
										Default = tbl27[tbl20.FFlagsRegion] or tbl20.FFlagsRegion or "US East (Virginia / New Jersey)",
										Callback = fn44("FFlagsRegion"),
									})

									tbl24.textboxes.FFlags_Custom_Text = v111:AddTextbox({
										Name = "Custom FFlags",
										SaveId = "Custom_FFlags_Text",
										Placeholder = "fflags here",
										Default = "",
										Callback = fn44("CustomFFlagsText"),
									})

									local offset = tbl24.dropdowns.FFlagsRegion.labelText.Position.Y.Offset
									tbl24.textboxes.FFlags_Custom_Text.inputFrame.ClipsDescendants = v85[200]
									tbl24.dropdowns.FFlagsRegion.buttonFrame.ClipsDescendants = true

									local function fn85(arg, arg2, arg3)
										if arg3 and arg3 > 0 then
											v101(arg, arg2, arg3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
										else
											for k, v112 in arg2, nil, nil do
												arg[k] = v112
											end
										end
									end

									local n33 = 0

									local function fn86(arg, arg2, arg3, arg4, arg5)
										local n34 = arg2 and 0 or v85[18]
										local n35 = arg2 and offset or offset + 8
										local n36

										if arg2 then
											n36 = arg4 and 26 or 21
										else
											n36 = arg2
										end

										n36 = n36 or 0
										local inputFrame = arg4 and arg.inputFrame or arg.buttonFrame

										if arg.Close then
											arg:Close()
										end

										if arg2 then
											if n28(2612) <= 505 then
												arg.labelText.Visible = true
												inputFrame.Visible = v85[200]
											else
												while v85[200] do
												end
											end
										end

										fn85(arg.labelText, { Position = UDim2.new(0, 10, v85[33], n35), TextTransparency = n34 }, arg3)

										fn85(inputFrame, {
											Position = arg4 and UDim2.new(v85[33], 10, 0, n35 + 22) or UDim2.new(1, inputFrame.Position.X.Offset, 0, n35),
											Size = UDim2.new(v85[33], inputFrame.Size.X.Offset, 0, n36),
											BackgroundTransparency = n34,
										}, arg3)

										if arg4 then
											fn85(arg.textbox, {
												TextTransparency = n34,
												PlaceholderColor3 = arg2 and v111.Library.config.Colors.SubText or v111.Library.config.Colors.Secondary,
											}, arg3)
										else
											fn85(arg.selectedLabelText, { TextTransparency = n34 }, arg3)
											fn85(arg.arrowImg, { ImageTransparency = n34 }, arg3)
										end

										local v112 = inputFrame:FindFirstChildOfClass(v85[131])

										if v112 then
											fn85(v112, { Transparency = n34 }, arg3)
										end

										task.delay(arg3 or 0, function()
											if arg2 or arg5 ~= n33 then
												return
											end
											arg.labelText.Visible = false
											inputFrame.Visible = v85[101]
										end)
									end

									fn84 = function(customFFlags, arg)
										n33 += 1
										arg = arg and 0 or 0.34
										tbl20.CustomFFlags = customFFlags
										v111.elementYPos = offset + (customFFlags and 56 or 28)

										if v111.UpdateSize then
											v111.UpdateSize(arg)
										end

										fn86(tbl24.dropdowns.FFlagsRegion, not customFFlags, arg, false, n33)
										fn86(tbl24.textboxes.FFlags_Custom_Text, customFFlags, arg, v85[200], n33)
									end

									fn84(tbl20.CustomFFlags == true, v85[200])
								end

								local function fn80()
									tbl24.toggles.Ball_Stats = Misc:AddGroup({ Name = "Ball Misc", Side = v85[150], Icon = "rbxassetid://10723427199" }):AddToggle({ Name = "Ball Stats", SaveId = "Ball_Stats", Default = false, Callback = tbl25.BallStats.Toggle })
									local v110 = Misc:AddGroup({ Name = "Avatar", Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Avatar_Changer = v110:AddToggle({
										Name = "Avatar Changer",
										SaveId = "Avatar",
										Default = false,
										Callback = function(avatarEnabled)
											tbl20.AvatarEnabled = avatarEnabled

											if flyteBBState.Loaded then
												tbl23.Toggle(avatarEnabled)
											end
										end,
									})

									tbl24.toggles.Avatar_Korblox_Headless = v110:AddToggle({
										Name = "Korblox/Headless",
										SaveId = "KH",
										Default = false,
										Callback = function(khEnabled)
											tbl20.KHEnabled = khEnabled

											if flyteBBState.Loaded then
												tbl23.ToggleKH(khEnabled)
											end
										end,
									})

									tbl24.textboxes.Avatar_Changer_Input = v110:AddTextbox({
										Name = "Avatar User/ID",
										SaveId = "Avatar_User",
										Placeholder = "user/userid",
										Callback = function(avatarUser)
											tbl20.AvatarUser = avatarUser

											if flyteBBState.Loaded and tbl20.AvatarEnabled then
												task.spawn(tbl23.Apply)
											end
										end,
									})

									tbl24.toggles.Unlock_All = Misc:AddGroup({ Name = "Inventory", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Unlock All (Client)",
										SaveId = "Unlock_All",
										Default = false,
										Callback = function(unlockAllEnabled)
											tbl20.UnlockAllEnabled = unlockAllEnabled
											if not flyteBBState.Loaded then
												return
											end
											tbl25.UnlockAll.Toggle(unlockAllEnabled)
										end,
									})

									local v111 = Misc:AddGroup({ Name = v85[105], Side = "Right", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.CustomStreak = v111:AddToggle({
										Name = "Custom Streak",
										SaveId = "Custom_Streak",
										Default = false,
										Callback = function(customStreakEnabled)
											tbl20.CustomStreakEnabled = customStreakEnabled

											if flyteBBState.Loaded then
												tbl25.Streak.Toggle(customStreakEnabled)
											end
										end,
									})

									tbl24.textboxes.CustomStreak = v111:AddTextbox({
										Name = "Streak",
										SaveId = "Streak",
										Placeholder = "Streak Here",
										Callback = function(customStreak)
											tbl20.CustomStreak = customStreak

											if flyteBBState.Loaded and tbl20.CustomStreakEnabled then
												tbl25.Streak.Toggle(true)
											end
										end,
									})

									local v112 = Misc:AddGroup({ Name = "Stats", Side = "Right", Icon = "rbxassetid://10723427199" })

									for _, v113 in { "Wins", "Elims", "RAP" }, nil, nil do
										local str5 = "Show_" .. v113
										local str6 = "Show" .. v113

										tbl24.toggles[str5] = v112:AddToggle({
											Name = "Show " .. v113,
											SaveId = str5,
											Default = false,
											Callback = function(arg)
												tbl20[str6] = arg

												if flyteBBState.Loaded then
													tbl25.Stats.Queue()
												end
											end,
										})
									end

									tbl24.toggles.AutoRejoinExecute = Misc:AddGroup({ Name = "Script", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Auto Rejoin & Execute",
										SaveId = "Auto_Rejoin_Execute",
										Default = false,
										Callback = function(autoRejoinExecute)
											tbl20.AutoRejoinExecute = autoRejoinExecute

											if flyteBBState.Loaded then
												tbl25.Script.Toggle(autoRejoinExecute)
											end
										end,
									})

									local v113 = Misc:AddGroup({ Name = "Staff", Side = v85[150], Icon = "rbxassetid://10723427199" })

									tbl24.toggles.StaffDetection = v113:AddToggle({
										Name = "Staff Detection",
										SaveId = "Staff_Detection",
										Default = false,
										Callback = function(staffDetection)
											tbl20.StaffDetection = staffDetection
											tbl25.Staff.Set(staffDetection)
										end,
									})

									tbl24.dropdowns.StaffDetectionMode = v113:AddDropdown({
										Name = "Mode",
										SaveId = "Staff_Detection_Mode",
										Options = { "warn", "kick" },
										Default = "warn",
										Callback = fn44("StaffDetectionMode"),
									})

									local value = rawget(getgenv(), "FlyteDeviceSpoofApplied")
									local device = type(value) == "table" and value.JobId == game.JobId and value.Device
									local str5 = (device == "Phone" or device == "Tablet") and "Mobile" or device or "PC"
									local v114 = Misc:AddGroup({ Name = "Device Spoof", Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.dropdowns.DeviceSpoofType = v114:AddDropdown({
										Name = "Device",
										SaveId = "Device_Spoof_Type",
										NoSave = true,
										Options = { "PC", "Mobile", "Console" },
										Default = str5,
										Callback = function(deviceSpoofType)
											tbl20.DeviceSpoofType = deviceSpoofType
										end,
									})

									v114:AddButton({ Name = "Apply", Callback = tbl25.DeviceSpoof.Apply })
									local v115 = Misc:AddGroup({ Name = v85[2], Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Ability_ESP = v115:AddToggle({
										Name = "Ability ESP",
										SaveId = "Ability_ESP",
										Default = false,
										Callback = function(abilityESPEnabled)
											tbl20.AbilityESPEnabled = abilityESPEnabled
											if not flyteBBState.Loaded then
												return
											end
											tbl25.Visuals.Toggle(abilityESPEnabled)
											tbl25.Visuals.RefreshLoop()
										end,
									})

									tbl24.toggles.AbilityESPShowNames = v115:AddToggle({
										Name = "Show Names",
										SaveId = "Ability_ESP_Show_Names",
										Default = false,
										Callback = function(abilityESPShowNames)
											tbl20.AbilityESPShowNames = abilityESPShowNames

											if flyteBBState.Loaded then
												tbl25.Visuals.Toggle()
												tbl25.Visuals.RefreshLoop()
											end
										end,
									})

									tbl24.sliders.AbilityESPIconSize = v115:AddSlider({
										Name = "Icon Size",
										SaveId = "Ability_ESP_Icon_Size",
										Min = 20,
										Max = 60,
										Default = 34,
										Increment = 1,
										Callback = function(abilityESPIconSize)
											tbl20.AbilityESPIconSize = abilityESPIconSize

											if flyteBBState.Loaded then
												tbl25.Visuals.UpdateSizes()
											end
										end,
									})

									tbl24.sliders.AbilityESPTextSize = v115:AddSlider({
										Name = "Text Size",
										SaveId = "Ability_ESP_Text_Size",
										Min = v85[35],
										Max = v85[108],
										Default = 13,
										Increment = v85[18],
										Callback = function(abilityESPTextSize)
											tbl20.AbilityESPTextSize = abilityESPTextSize

											if flyteBBState.Loaded then
												tbl25.Visuals.UpdateSizes()
											end
										end,
									})

									local v116 = Misc:AddGroup({ Name = "Rewards", Side = "Left", Icon = "rbxassetid://10723427199" })

									for _, v117 in tbl25.Rewards.Items, nil, nil do
										tbl24.toggles[v117.ID] = v116:AddToggle({
											Name = v117.Name,
											SaveId = v117.ID,
											Default = false,
											Notify = v117.Notify,
											Callback = function(arg)
												tbl20[v117.ID] = arg

												if flyteBBState.Loaded then
													tbl25.Rewards.Toggle()
												end
											end,
										})
									end

									local v117 = Misc:AddGroup({ Name = "Automation", Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.toggles.Auto_Play = v117:AddToggle({
										Name = "Auto Play",
										SaveId = "Auto_Play",
										Default = false,
										Callback = function(autoPlayEnabled)
											tbl20.AutoPlayEnabled = autoPlayEnabled

											if flyteBBState.Loaded then
												tbl25.AutoPlay.Toggle(autoPlayEnabled)
											end
										end,
									})

									tbl24.toggles.AutoVoteMap = v117:AddToggle({
										Name = "Auto Vote Map",
										SaveId = "Auto_Vote_Map",
										Default = false,
										Callback = function(autoVoteMap)
											tbl20.AutoVoteMap = autoVoteMap

											if not autoVoteMap then
												table.clear(tbl25.AutoPlay.Voting)
											end
										end,
									})

									tbl24.toggles.HitFreeze = v117:AddToggle({ Name = "Hit Freeze", SaveId = "Hit_Freeze", Default = false, Callback = fn44("HitFreeze") })

									tbl24.toggles.SpamJump = v117:AddToggle({
										Name = "Spam Jump",
										SaveId = "Spam_Jump",
										Default = false,
										Callback = function(spamJump)
											tbl20.SpamJump = spamJump

											if not spamJump then
												tbl25.AutoPlay.Jump(false)
											end
										end,
									})

									tbl24.sliders.AutoPlaySmoothness = v117:AddSlider({
										Name = "Smoothness",
										SaveId = "Auto_Play_Smoothness",
										Min = 1,
										Max = 100,
										Default = v85[169],
										Increment = v85[18],
										Callback = fn44("AutoPlaySmoothness"),
									})

									tbl24.sliders.AutoPlayAggressiveness = v117:AddSlider({
										Name = "Aggressiveness",
										SaveId = "Auto_Play_Aggressiveness",
										Min = 1,
										Max = 100,
										Default = v85[195],
										Increment = 1,
										Callback = fn44("AutoPlayAggressiveness"),
									})

									tbl24.toggles.AntiAFK = v117:AddToggle({
										Name = "Anti-AFK",
										SaveId = "Anti_AFK",
										Default = v85[101],
										Callback = function(antiAFK)
											tbl20.AntiAFK = antiAFK

											if flyteBBState.Loaded then
												tbl25.AFK.Toggle(antiAFK)
											end
										end,
									})

									tbl24.dropdowns.AutoPlayMode = v117:AddDropdown({
										Name = "Mode",
										SaveId = "Auto_Play_Mode",
										Options = { "Play Edge", "Play Middle", "Mix" },
										Default = "Play Edge",
										Callback = fn44("AutoPlayMode"),
									})
								end

								local function fn81()
									local v110 = Settings:AddGroup({ Name = "Menu", Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.sliders.MenuScale = v110:AddSlider({
										Name = "Menu Scale",
										SaveId = "Menu_Scale",
										Min = v85[169],
										Max = 150,
										Default = v85[158],
										Increment = 1,
										Callback = function(menuScale)
											tbl20.MenuScale = menuScale

											if v103 then
												v103:UpdateLayoutScale()
											end
										end,
									})

									if touchEnabled then
										tbl24.sliders.MobileButtonScale = v110:AddSlider({
											Name = "Mobile Button Scale",
											SaveId = "Mobile_Button_Scale",
											Min = 50,
											Max = 150,
											Default = v85[158],
											Increment = v85[18],
											Callback = function(mobileButtonScale)
												tbl20.MobileButtonScale = mobileButtonScale

												if v103 and v103.mobileToggleScale then
													fn37(v103.mobileToggleScale, { Scale = mobileButtonScale / 100 }, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
												end
											end,
										})
									end

									tbl24.toggles.Minimize_Keybind = v110:AddKeybind({
										Name = "UI Toggle Keybind",
										SaveId = "Menu_Toggle_Keybind",
										Default = Enum.KeyCode.RightAlt,
										ChangedCallback = function(toggleVisibilityKey)
											if v103 then
												v103.toggleVisibilityKey = toggleVisibilityKey
												v103.toggleVisibilityKeyName = toggleVisibilityKey == Enum.KeyCode.Unknown and "None" or toggleVisibilityKey.Name
												v103.lastKeybindChanged = tick()
											end
										end,
									})

									local v111 = Settings:AddGroup({ Name = "Configs", Side = "Left", Icon = "rbxassetid://10723427199" })

									tbl24.textboxes.ConfigName = v111:AddTextbox({
										Name = "Config Name",
										SaveId = "ConfigName",
										Default = "",
										NoSave = true,
										Callback = function()
										end,
									})

									local fn82 = nil

									tbl24.dropdowns.Config_List = v111:AddDropdown({
										Name = "Config List",
										SaveId = "Config_List",
										Options = Configs:Refresh(),
										Default = "none",
										NoSave = true,
										OnOpen = function()
											if fn82 then
												fn82()
											end
										end,
										Callback = function(arg)
											Configs.Selected = arg ~= "none" and arg or nil
										end,
									})

									fn82 = function()
										local tbl26 = Configs:Refresh()

										if #tbl26 == 0 then
											tbl26 = { "none" }
										end

										tbl24.dropdowns.Config_List:Refresh(tbl26)

										if Configs.Selected and table.find(tbl26, Configs.Selected) then
											tbl24.dropdowns.Config_List:Set(Configs.Selected)
										else
											tbl24.dropdowns.Config_List:Set(tbl26[v85[18]])
										end
									end

									fn82()
									local n33 = v111.elementYPos + 2

									local function fn83(arg, arg2, arg3)
										v103:Notify({ Title = arg and arg2 or "config failed: " .. tostring(arg3), Duration = 3 })
									end

									local function fn84(arg, arg2, arg3, arg4)
										local n34 = 113
										local n35 = 25
										local n36 = arg2 == 1 and 10 or 135
										local n37 = n33 + (arg3 - 1) * 31

										local TextButton = v98("TextButton", {
											Name = arg:gsub("%s+", "_"),
											AutoButtonColor = v85[101],
											BackgroundColor3 = v111.Library.config.Colors.Element,
											BorderSizePixel = 0,
											FontFace = tbl22.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
											Text = arg,
											TextColor3 = v111.Library.config.Colors.SubText,
											TextSize = 13,
											Position = UDim2.new(0, n36, v85[33], n37),
											Size = UDim2.new(v85[33], 113, 0, 25),
											Parent = v111.mainFrame,
										})

										v98("UICorner", { CornerRadius = UDim.new(v85[33], v85[72]), Parent = TextButton })
										local v112 = v98(v85[131], { Color = v111.Library.config.Colors.BorderSoft, Parent = TextButton })

										TextButton.MouseEnter:Connect(function()
											v101(TextButton, {
												BackgroundColor3 = v111.Library.config.Colors.ElementHover,
												TextColor3 = v111.Library.config.Colors.Text,
											}, v85[136])

											v101(v112, { Color = v111.Library.config.Colors.Border }, 0.18)
										end)

										TextButton.MouseLeave:Connect(function()
											v101(TextButton, {
												BackgroundColor3 = v111.Library.config.Colors.Element,
												TextColor3 = v111.Library.config.Colors.SubText,
											}, 0.22)

											v101(v112, { Color = v111.Library.config.Colors.BorderSoft }, 0.22)
										end)

										TextButton.MouseButton1Down:Connect(function()
											v101(TextButton, {
												Size = UDim2.new(v85[33], n34 - 5, 0, n35 - 2),
												Position = UDim2.new(0, n36 + 2, v85[33], n37 + 1),
											}, 0.08, Enum.EasingStyle.Quad)
										end)

										TextButton.MouseButton1Up:Connect(function()
											v101(TextButton, { Size = UDim2.new(v85[33], 113, 0, 25), Position = UDim2.new(0, n36, 0, n37) }, 0.22, Enum.EasingStyle.Back)
											arg4()
										end)
									end

									local function fn85(arg, arg2, arg3)
										return function()
											local selected = Configs.Selected
											local v112, v113 = Configs[arg](Configs, selected)
											fn83(v112, arg2 .. tostring(selected), v113)

											if arg3 then
												fn82()
											end
										end
									end

									fn84("Create", v85[18], v85[18], function()
										local str5 = tbl24.textboxes.ConfigName and tbl24.textboxes.ConfigName.value or ""
										local v112, v113 = Configs:Save(str5)
										fn83(v112, "created config " .. tostring(Configs.Name(str5) or str5), v113)
										fn82()
									end)

									local Load = fn85("Load", "loaded config ")
									fn84("Load", 2, 1, Load)
									local Save = fn85("Save", "overwrote config ", true)
									fn84("Overwrite", 1, 2, Save)
									local Reset = fn85("Reset", "reset config ", true)
									fn84("Reset Config", 2, 2, Reset)
									local Delete = fn85("Delete", "deleted config ", true)
									fn84("Delete", 1, 3, Delete)
									local SetAutoload = fn85("SetAutoload", "autoload set to ")
									fn84("Autoload", 2, 3, SetAutoload)

									fn84("Reset Autoload", 1, v85[153], function()
										Configs:ClearAutoload()
										v103:Notify({ Title = "autoload reset", Duration = 3 })
									end)

									fn84("Reset Settings", 2, v85[153], function()
										Configs.Apply(Configs.Defaults())
										v103:Notify({ Title = "settings reset to default", Duration = v85[61] })
									end)

									v111.elementYPos = n33 + 124

									if v111.UpdateSize then
										v111.UpdateSize()
									end

									tbl24.toggles.Keybind_List = Settings:AddGroup({ Name = "UI Extras", Side = "Right", Icon = "rbxassetid://10723427199" }):AddToggle({
										Name = "Keybind List",
										SaveId = v85[103],
										Default = false,
										Callback = tbl25.UIExtra.ToggleKeybindList,
									})
								end

								fn77()
								fn78()
								fn79()
								fn80()
								fn81()
							end

							fn74()
							Configs:LoadAutoload()
							flyteBBState.Loaded = true
							tbl25.Rewards.Toggle()
							tbl25.Visuals.Toggle(tbl20.AbilityESPEnabled)
							tbl25.Visuals.RefreshLoop()
							tbl25.AFK.Toggle(tbl20.AntiAFK)
							tbl25.Script.Toggle(tbl20.AutoRejoinExecute)

							if tbl20.AvatarEnabled then
								task.defer(tbl23.Toggle, true)
							end

							if tbl20.KHEnabled then
								task.defer(tbl23.ToggleKH, true)
							end

							if tbl20.UnlockAllEnabled then
								task.defer(tbl25.UnlockAll.Toggle, v85[200])
							end

							if tbl20.CustomStreakEnabled then
								task.defer(tbl25.Streak.Toggle, true)
							end

							if tbl20.ShowWins or tbl20.ShowElims or tbl20.ShowRAP then
								task.defer(tbl25.Stats.Toggle)
							end

							if tbl20.AutoPlayEnabled then
								tbl25.AutoPlay.Toggle(true)
							end

							if tbl20.AutoParryEnabled and tbl20.TriggerbotEnabled then
								tbl24.toggles.Triggerbot:Set(v85[101])
							end

							fn34()
							flyteBBState.Connections["Auto Parry"] = (tbl20.ParryLoopType == "PreRender" and v88.PreRender or v88.PreSimulation):Connect(tbl25.Loop.MainParryLoop)
							tbl25.Loop.RefreshAutoSpam()

							fn38 = function()
								fn42("Triggerbot")
								fn68(true)
								tbl25.Triggerbot.Update()
								flyteBBState.Connections.Triggerbot = v88.PreSimulation:Connect(tbl25.Triggerbot.Update)
							end

							fn39 = function()
								fn42("Triggerbot")
								local balls2 = balls or workspace:FindFirstChild("Balls")

								if balls2 then
									for _, v109 in balls2:GetChildren() do
										fn58(v109).TriggerbotParried = false
									end
								end
							end

							if tbl20.TriggerbotEnabled then
								fn38()
							end

							tbl25.Triggerbot.RefreshUI()

							if tbl20.ManualSpamEnabled then
								tbl25.ManualSpam.Start()
							end

							if v93.Remotes:FindFirstChild("ParrySuccess") then
								flyteBBState.Connections["Parry Success"] = v93.Remotes.ParrySuccess.OnClientEvent:Connect(function()
									tbl25.Animation.BypassCooldown()
									flyteBBState.InfinityParried = true
									if flyteBBState.ParryMethod == "VIM" then
										return
									end
									flyteBBState.ParryMethod = "VIM"
									local parent = alive and alive.Parent and alive or workspace:FindFirstChild("Alive")

									if parent then
										alive = parent
									end

									if not localPlayer.Character or localPlayer.Character.Parent ~= alive then
										return
									end
									local humanoid = localPlayer.Character:FindFirstChild("Humanoid")

									if humanoid then
										if n27(4025) >= 5564 then
											for _, v109 in humanoid.Animator:GetPlayingAnimationTracks() do
												if v109:GetAttribute("GrabParry") or v109:GetAttribute("Parry") or v109.Name == "GrabParry" or v109.Name == "Grab" then
													v109:Stop(v109:GetAttribute("StopFadeTime") or 0.1)
												end
											end
										else
											while true do
											end
										end
									end
								end)
							end

							if tbl20.AutoPreclickEnabled then
								fn71()
							end

							flyteBBState.Connections["ESP Player"] = v89.PlayerAdded:Connect(function(player)
								if tbl20.AbilityESPEnabled or tbl20.AbilityESPShowNames then
									tbl25.Visuals.AddLabel(player)
								end
							end)

							flyteBBState.Connections["ESP Player Removing"] = v89.PlayerRemoving:Connect(function(player)
								tbl25.Visuals.DestroyLabel(flyteBBState.ESPLabels[player])
								flyteBBState.ESPLabels[player] = nil
								local v109 = flyteBBState.ESPConnections[player]

								if v109 then
									v109:Disconnect()
									flyteBBState.ESPConnections[player] = nil
								end

								flyteBBState.AbilityActive[player] = nil
								flyteBBState.AbilityCooldowns[player] = nil
								tbl25.Visuals.ClearFury(flyteBBState.AbilityUses[player])
								flyteBBState.AbilityUses[player] = nil
							end)

							flyteBBState.Connections["Accuracy Warning"] = task.delay(5, function()
								flyteBBState.AccuracyWarningReady = true
								fn73()
							end)
						end

						getgenv().FlyteBB = v103
						return v100
					end

					while true do
					end
				end
			end
		end
	end
end

fn14(100, "[  ERROR  ]", (" - Failed to load Luarmor client --> ") .. v32(v63), Color3["new"](1, 0, 0), "error")
