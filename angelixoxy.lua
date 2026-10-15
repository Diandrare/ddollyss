-- ═══════════════════════════════════════════════════════════════════
-- angeli × oxy — MERGED
-- UI: Angeli. Combat engine: Oxy (self-contained).
-- ═══════════════════════════════════════════════════════════════════

task.spawn(function()

-- ─── Fluent window ────────────────────────────────────────────────
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "angeli",
    SubTitle = "",
    TabWidth = 110,
    Size = UDim2.fromOffset(500, 330),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Rage      = Window:AddTab({ Title = "Autoparry", Icon = "sword" }),
    Detection = Window:AddTab({ Title = "Detection", Icon = "eye" }),
    Spam      = Window:AddTab({ Title = "Spam",      Icon = "skull" }),
    Player    = Window:AddTab({ Title = "Player",    Icon = "user" }),
    Visuals   = Window:AddTab({ Title = "Visuals",   Icon = "monitor" }),
    Misc      = Window:AddTab({ Title = "Misc",      Icon = "settings" }),
    Settings  = Window:AddTab({ Title = "Settings",  Icon = "sliders" })
}

local Options = Fluent.Options

repeat task.wait(0.5) until game:IsLoaded()

-- ─── Services ────────────────────────────────────────────────────
local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local RunService = cloneref(game:GetService('RunService'))
local TweenService = cloneref(game:GetService('TweenService'))
local Stats = cloneref(game:GetService('Stats'))
local Debris = cloneref(game:GetService('Debris'))
local CoreGui = cloneref(game:GetService('CoreGui'))

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

if not LocalPlayer.Character then LocalPlayer.CharacterAdded:Wait() end

local Alive = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
local Runtime = workspace.Runtime

-- ─── Angeli System (non-combat state) ────────────────────────────
local System = {
    __properties = {
        __play_animation = false,
        __accuracy = 100,
        __divisor_multiplier = 1.1,
        __parried = false,
        __training_parried = false,
        __parries = 0,
        __tornado_time = tick(),
        __connections = {},
        __infinity_active = false,
        __deathslash_active = false,
        __timehole_active = false,
        __slashesoffury_active = false,
        __slashesoffury_count = 0,
        __is_mobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled,
        __mobile_guis = {}
    },
    __config = {
        __curve_names = {'Camera', 'Random', 'Accelerated', 'Backwards', 'Slow', 'High'},
        __detections = {
            __infinity = false,
            __deathslash = false,
            __timehole = false,
            __slashesoffury = false,
            __phantom = false
        }
    }
}

local function update_divisor()
    System.__properties.__divisor_multiplier = 0.59 + (System.__properties.__accuracy - 1) * (3 / 99)
end
update_divisor()

-- ═══════════════════════════════════════════════════════════════════
-- OXY COMBAT ENGINE (self-contained)
-- ═══════════════════════════════════════════════════════════════════
_G.OxyCombat = {}
_G.OxyCombat.ready = false

local OxyConn = {}

task.spawn(function()
    local RS = ReplicatedStorage
    local UIS = UserInputService
    local RSvc = RunService
    local WS = workspace
    local S = Stats
    local D = Debris

    local LP = Players.LocalPlayer
    local name = LP.Name
    local currentCamera = WS.CurrentCamera
    WS:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        currentCamera = WS.CurrentCamera
    end)

    local remotes = RS:WaitForChild("Remotes", 10)
    local packages = RS.Packages
    local controllers = RS.Controllers
    local balls = WS.Balls
    local alive = WS.Alive
    local runtime = WS.Runtime
    local dataPing = S.Network.ServerStatsItem["Data Ping"]

    local config = {
        curve_method = "camera",
        spam_threshold = 3,
        random_target = false,
        accuracy = 100,
        auto_spam_distance_multiplier = 1.0,
    }

    local eventCapture = { captured = {}, hooked = {}, originals = {}, token_fn = nil }
    local ballState = {
        state = { AerodynamicTime = tick(), LastWarping = tick(), LerpRadians = 0, Curving = tick() },
        positions = {}, replicator = nil,
    }
    local parryController = { count = 0, first_signal = nil }
    local curveController = { syncing = false }
    local spamController = { distance = 0, last_auto = 0 }
    local triggerbotState = { on = false, busy = false }
    local parryState = { debounce = false, until_at = 0, accuracy = 1.5 }
    local swordAnimState = {
        active = nil, cache = {}, tracks = {},
        generation = 0, last_spam = 0,
        cancel_delay = 0.12, cancel_fraction = 0.35, api = nil,
    }
    local currentTarget = nil
    local visited = {}

    local function clamp(v, a, b) return math.clamp(v, a, b) end
    local function mn(v, a) return math.min(v, a) end
    local function mx(v, a) return math.max(v, a) end

    ballState.get = function()
        for _, b in ipairs(balls:GetChildren()) do
            if b:GetAttribute("realBall") then return b end
        end
    end
    ballState.get_all = function()
        local t = {}
        for _, b in ipairs(balls:GetChildren()) do
            if b:GetAttribute("realBall") then table.insert(t, b) end
        end
        return t
    end
    ballState.position = function(b)
        b = b or ballState.get()
        if b then return ballState.positions[b] or b.Position end
        return Vector3.zero
    end
    ballState.props = function()
        local b = ballState.get()
        local zero = Vector3.zero
        if not b then
            return { Velocity = zero, Direction = Vector3.new(0,1,0), Distance = 0, Dot = 0 }
        end
        local chr = LP.Character
        local hrp = chr and chr.PrimaryPart
        if not hrp then return { Velocity = zero, Direction = Vector3.new(0,1,0), Distance = 0, Dot = 0 } end
        local bp = ballState.position(b)
        local diff = hrp.Position - bp
        local unit = diff.Unit
        return { Velocity = zero, Direction = unit, Distance = diff.Magnitude, Dot = unit:Dot(zero.Unit) }
    end
    ballState.curved = function(b)
        b = b or ballState.get()
        if not b then return false end
        local z = b:FindFirstChild("zoomies")
        if not z then return false end
        local now = tick()
        local ping = dataPing:GetValue()
        local vel = z.VectorVelocity
        local unit = vel.Unit
        local chr = LP.Character
        if not chr or not chr.PrimaryPart then return false end
        local root = chr.PrimaryPart.Position
        local bp = ballState.position(b)
        local dirUnit = (root - bp).Unit
        local dot = dirUnit:Dot(unit)
        local speed = vel.Magnitude
        local speedMax = mn(speed / 100, 40)
        local bend = dot - dirUnit:Dot((unit - vel).Unit)
        local dist = (root - bp).Magnitude
        local t1 = 0.5 - ping / 1000
        local t2 = dist / speed - ping / 1000
        local t3 = 15 - mn(dist / 1000, 15) + speedMax
        ballState.state.LerpRadians = ballState.state.LerpRadians
            + (math.rad(math.asin(clamp(dot, -1, 1))) - ballState.state.LerpRadians) * 0.8
        if speed > 100 and t2 > ping / 10 then
            t3 = mx(t3 - 15, 15)
        end
        if dist < t3 then return false end
        if bend < t1 then return true end
        if ballState.state.LerpRadians < 0.018 then ballState.state.LastWarping = now end
        if now - ballState.state.LastWarping < t2 / 1.5 then return true end
        if now - ballState.state.Curving < t2 / 1.5 then return true end
        return dot < t1
    end

    do
        local net = RS:FindFirstChild("Packages")
        net = net and net:FindFirstChild("_Index")
        net = net and net:FindFirstChild("sleitnick_net@0.1.0")
        net = net and net:FindFirstChild("net")
        if net then
            for _, ch in ipairs(net:GetChildren()) do
                if ch:IsA("UnreliableRemoteEvent") and ch.Name ~= "URE/ReplicateBallPosition" then
                    ballState.replicator = ch
                    break
                end
            end
        end
    end
    if ballState.replicator then
        ballState.replicator.OnClientEvent:Connect(function(b, pos)
            if b and b.Parent == balls and b:GetAttribute("realBall") == true then
                ballState.positions[b] = pos
            end
        end)
    end

    -- reset debounce saat target ball berubah
    local function bindBall(b)
        task.spawn(function()
            if not b:GetAttribute("realBall") and not b:WaitForChild("zoomies", 3) then
                return
            end
            b:GetAttributeChangedSignal("target"):Connect(function()
                parryState.debounce = false
                parryState.until_at = 0
                if config.random_target then pickRandomTarget() end
            end)
        end)
    end

    balls.ChildAdded:Connect(function(b)
        if config.random_target then pickRandomTarget() end
    end)
    balls.ChildAdded:Connect(bindBall)
    for _, b in ipairs(balls:GetChildren()) do
        bindBall(b)
    end

    balls.ChildRemoved:Connect(function(child)
        ballState.positions[child] = nil
        parryController.count = 0
        parryState.debounce = false
        parryState.until_at = 0
        currentTarget = nil
        visited = {}
    end)

    local function pickRandomTarget()
        local list = {}
        for _, e in ipairs(alive:GetChildren()) do
            if e.Name ~= name and e.PrimaryPart then table.insert(list, e) end
        end
        if #list == 0 then currentTarget = nil; return end
        if #list == 1 then currentTarget = list[1]; return end
        local unv = {}
        for _, e in ipairs(list) do
            if not visited[e.Name] then table.insert(unv, e) end
        end
        if #unv == 0 then
            visited = {}
            for _, e in ipairs(list) do
                if not currentTarget or e.Name ~= currentTarget.Name then
                    table.insert(unv, e)
                end
            end
            if #unv == 0 then unv = list end
        end
        local pick = unv[math.random(1, #unv)]
        visited[pick.Name] = true
        currentTarget = pick
    end

    local function byMouse()
        local list = {}
        for _, e in ipairs(alive:GetChildren()) do
            if e.Name ~= name and e.PrimaryPart then table.insert(list, e) end
        end
        if #list == 0 then currentTarget = nil; return nil end
        local cam = currentCamera or WS.CurrentCamera
        local camCF = cam.CFrame
        local camPos = camCF.Position
        local look = camCF.LookVector
        local dir
        if UIS.MouseEnabled then
            local m = UIS:GetMouseLocation()
            dir = cam:ScreenPointToRay(m.X, m.Y).Direction
        else
            local vp = cam.ViewportSize
            dir = cam:ViewportPointToRay(vp.X * 0.5, vp.Y * 0.5).Direction
        end
        local bestDot = -math.huge
        local best = nil
        for _, e in ipairs(list) do
            local d = e.PrimaryPart.Position - camPos
            if d.Magnitude > 0 then
                local u = d.Unit
                if look:Dot(u) > 0 then
                    local dot = dir:Dot(u)
                    if dot > bestDot then bestDot = dot; best = e end
                end
            end
        end
        best = best or list[1]
        currentTarget = best
        return best
    end

    local function closestTarget()
        if config.random_target then
            if not currentTarget then pickRandomTarget() end
            return currentTarget
        end
        return byMouse()
    end

    curveController.get_cframe = function()
        local cam = currentCamera or WS.CurrentCamera
        local camCF = cam.CFrame
        local chr = LP.Character
        local hrp = chr and chr:FindFirstChild("HumanoidRootPart")
        if not hrp then return camCF end
        local tgt = currentTarget and currentTarget.PrimaryPart
            and currentTarget.PrimaryPart.Position
            or (hrp.Position + camCF.LookVector * 1000)
        local dir = (tgt - hrp.Position).Unit
        local method = config.curve_method
        if method == "dot" then
            return CFrame.lookAt(hrp.Position, tgt + Vector3.new(0, 1.75, 0))
        elseif method == "backwards" then
            return CFrame.new(hrp.Position, hrp.Position + -dir * 1000)
        elseif method == "slow" then
            return CFrame.new(hrp.Position, hrp.Position + Vector3.new(0, -350, 0))
        elseif method == "random" then
            return CFrame.new(hrp.Position,
                tgt + Vector3.new(math.random(-1000, 1000), math.random(-350, 1000), math.random(-1000, 1000)))
        end
        return camCF
    end

    pcall(function() swordAnimState.api = require(RS.Shared.SwordAPI) end)
    LP.CharacterAdded:Connect(function()
        table.clear(swordAnimState.tracks)
        swordAnimState.active = nil
        swordAnimState.generation = swordAnimState.generation + 1
        swordAnimState.last_spam = 0
    end)

    local function swordFind(parent)
        local g = parent:FindFirstChild("GrabParry") or parent:FindFirstChild("Parry") or parent:FindFirstChild("Grab")
        if g then return g end
        local base = parent:FindFirstChild("Base")
        if base then
            return base:FindFirstChild("GrabParry") or base:FindFirstChild("Parry") or base:FindFirstChild("Grab")
        end
    end

    local function swordResolve(chr, swordName)
        if not swordName then return nil end
        if swordAnimState.cache[swordName] and swordAnimState.cache[swordName].Parent then
            return swordAnimState.cache[swordName]
        end
        local shared = RS:FindFirstChild("Shared")
        if not shared then return nil end
        local inst = shared:FindFirstChild("ReplicatedInstances")
        inst = inst and inst:FindFirstChild("Swords")
        local getSword = inst and inst:FindFirstChild("GetSword")
        local data
        if getSword then pcall(function() data = getSword:Invoke(swordName) end) end
        local atype = data and data.AnimationType or "Single"
        local stype = data and data.SwordType or "Single"
        if swordAnimState.api and type(swordAnimState.api.GetAnimations) == "function" then
            local ok, anims = pcall(function()
                return swordAnimState.api:GetAnimations(chr, { "Parry", "GrabParry" }, atype, stype)
            end)
            if ok and type(anims) == "table" and anims[1] then
                swordAnimState.cache[swordName] = anims[1]
                return anims[1]
            end
        end
        local api = shared:FindFirstChild("SwordAPI")
        api = api and (api:FindFirstChild("Collection") or api)
        if api then
            local folder = api:FindFirstChild(atype)
            if folder then
                local a = swordFind(folder)
                if a then swordAnimState.cache[swordName] = a; return a end
            end
            local def = api:FindFirstChild("Default")
            if def then
                local a = swordFind(def)
                if a then swordAnimState.cache[swordName] = a; return a end
            end
        end
    end

    local function playGrabParry(animate)
        local chr = LP.Character
        if not chr then return false end
        local hum = chr:FindFirstChildOfClass("Humanoid")
        local anim = hum and hum:FindFirstChildOfClass("Animator")
        if not hum or not anim then return false end
        local swName = chr:GetAttribute("CurrentlyEquippedSword") or "Base Sword"
        local animation = swordResolve(chr, swName)
        if not animation then return false end
        local tracks = swordAnimState.tracks[anim]
        if not tracks then tracks = {}; swordAnimState.tracks[anim] = tracks end
        local track = tracks[animation]
        if not track or not track.Parent or track.Parent ~= anim then
            local ok, t = pcall(function() return anim:LoadAnimation(animation) end)
            if not ok or not t then return false end
            for k, v in pairs(animation:GetAttributes()) do t:SetAttribute(k, v) end
            t:SetAttribute("GrabParry", true)
            t.Priority = Enum.AnimationPriority.Action4
            tracks[animation] = t
            track = t
        end
        if animate then
            local now = tick()
            if now - swordAnimState.last_spam < swordAnimState.cancel_delay then
                local playing = false
                if swordAnimState.active then
                    pcall(function() playing = swordAnimState.active.IsPlaying end)
                end
                if playing then
                    chr:SetAttribute("ParryTime",
                        mx(chr:GetAttribute("ParryTime") or 0,
                            swordAnimState.active.Length ~= 0 and swordAnimState.active.Length or 1))
                    return true
                end
            end
            swordAnimState.last_spam = now
        else
            swordAnimState.last_spam = 0
        end
        swordAnimState.generation = swordAnimState.generation + 1
        local gen = swordAnimState.generation
        for _, t in ipairs(anim:GetPlayingAnimationTracks()) do
            if t:GetAttribute("GrabParry") or t:GetAttribute("Parry") or t:GetAttribute("SuccessParry") then
                pcall(t.Stop, t, t:GetAttribute("StopFadeTime") or 0.05)
            end
        end
        local fadeIn = animation:GetAttribute("PlayFadeTime") or 0.05
        local weight = animation:GetAttribute("PlayWeight") or 1
        local speed = animation:GetAttribute("PlaySpeed") or 1
        track.TimePosition = 0
        track:Play(fadeIn, weight, speed)
        swordAnimState.active = track
        chr:SetAttribute("ParryTime",
            mx(chr:GetAttribute("ParryTime") or 0,
                track.Length ~= 0 and (track.Length - track.TimePosition) * speed or 1))
        if animate then
            local len = track.Length or 0
            local cd = swordAnimState.cancel_delay
            local delay = not (len > 0) and cd or mn(cd, len * swordAnimState.cancel_fraction)
            if delay < 0.05 then delay = 0.05 end
            local t = track
            local fadeOut = animation:GetAttribute("StopFadeTime") or 0.05
            task.delay(delay, function()
                if gen ~= swordAnimState.generation or swordAnimState.active ~= t then return end
                pcall(t.Stop, t, fadeOut)
            end)
        end
        return true
    end

    for _, f in ipairs(getgc(true)) do
        if type(f) == "function" and debug.info(f, "s"):find("PRY", 1, true) then
            for _, upv in ipairs(debug.getupvalues(f)) do
                if type(upv) == "function" then
                    eventCapture.token_fn = upv
                    break
                end
            end
            if eventCapture.token_fn then break end
        end
    end

    eventCapture.tokenize = function(inputValue)
        local ts = tostring(math.floor(WS:GetServerTimeNow() * 100))
        local seed = eventCapture.token_fn(inputValue, "TIME")
        local out = table.create(#ts)
        for i = 1, #ts do
            out[i] = string.char(bit32.bxor((string.byte(ts, i) + i) % 256, string.byte(seed, (i - 1) % #seed + 1)))
        end
        return table.concat(out)
    end

    eventCapture.valid_args = function(args)
        return #args == 8
            and type(args[2]) == "string"
            and type(args[3]) == "string"
            and type(args[4]) == "number"
            and typeof(args[5]) == "CFrame"
            and type(args[6]) == "table"
            and type(args[7]) == "table"
            and type(args[8]) == "boolean"
    end
    eventCapture.unhook = function()
        for meta, orig in pairs(eventCapture.originals) do
            pcall(function()
                setreadonly(meta, false)
                meta.__index = orig
                setreadonly(meta, true)
            end)
        end
        table.clear(eventCapture.hooked)
        table.clear(eventCapture.originals)
    end
    eventCapture.hook = function(remote)
        if next(eventCapture.captured) ~= nil then return end
        local meta = getrawmetatable(remote)
        if eventCapture.hooked[meta] then return end
        eventCapture.hooked[meta] = true
        setreadonly(meta, false)
        local old = meta.__index
        eventCapture.originals[meta] = old
        meta.__index = function(self, key)
            if (key == "FireServer" and self:IsA("RemoteEvent"))
                or (key == "InvokeServer" and self:IsA("RemoteFunction")) then
                return function(obj, ...)
                    local args = { ... }
                    if eventCapture.valid_args(args) then
                        eventCapture.captured[obj] = args
                        eventCapture.unhook()
                    end
                    return old(self, key)(obj, unpack(args))
                end
            end
            return old(self, key)
        end
        setreadonly(meta, true)
    end
    for _, d in ipairs(RS:GetDescendants()) do
        if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
            eventCapture.hook(d)
        end
    end

    parryController.fire = function(animate)
        local cam = currentCamera or WS.CurrentCamera
        if not config.random_target then byMouse() end
        local cf = curveController.get_cframe()
        local tp = currentTarget and currentTarget.PrimaryPart
        local list
        if tp then
            local v = cam:WorldToViewportPoint(tp.Position)
            list = { v.X, v.Y }
        elseif UIS.MouseEnabled then
            local m = UIS:GetMouseLocation()
            list = { m.X, m.Y }
        else
            local vp = cam.ViewportSize
            list = { vp.X * 0.5, vp.Y * 0.5 }
        end
        local map = {}
        for _, e in ipairs(alive:GetChildren()) do
            local p = e.PrimaryPart
            if p then
                local v = cam:WorldToScreenPoint(p.Position)
                if v and v.Z > 0 then map[e.Name] = v end
            end
        end
        if next(eventCapture.captured) == nil then
            if not parryController.first_signal then
                parryController.first_signal = require(packages.Signal).new()
                parryController.first_signal:Connect(require(controllers["SwordsController \12"].PRY))
            end
            parryController.first_signal:Fire(0.5, cf, map, list, false)
            if animate then playGrabParry(true) end
        else
            playGrabParry(animate)
            for remote, args in pairs(eventCapture.captured) do
                local payload = {
                    args[1], args[2], eventCapture.tokenize(args[2]),
                    0.5, cf, map, list, false,
                }
                if remote:IsA("RemoteEvent") then remote:FireServer(unpack(payload))
                elseif remote:IsA("RemoteFunction") then remote:InvokeServer(unpack(payload)) end
            end
        end
        if parryController.count > 7 then return false end
        parryController.count = parryController.count + 1
        task.delay(0.5, function()
            if parryController.count > 0 then parryController.count = parryController.count - 1 end
        end)
        return true
    end

    local apConn = nil
    local function parryTick()
        if triggerbotState.busy then return end
        local chr = LP.Character
        local root = chr and chr.PrimaryPart
        if not root then return end
        local now = tick()
        if parryState.debounce or now < parryState.until_at then return end
        local pos = root.Position
        local pingThreshold = clamp(dataPing:GetValue() / 100, 5, 17)
        local primary = ballState.get()
        local primaryTarget = primary and primary:GetAttribute("target")
        local tornado = runtime:FindFirstChild("Tornado")
        local tornadoTime = tornado and (tornado:GetAttribute("TornadoTime") or 1)
        for _, b in ipairs(ballState.get_all()) do
            local z = b:FindFirstChild("zoomies")
            if z then
                local tgt = b:GetAttribute("target")
                local speed = z.VectorVelocity.Magnitude
                local dist = (pos - ballState.position(b)).Magnitude
                local divisor = (2.4 + mn(mx(speed - 9.5, 0), 650) * 0.002) * parryState.accuracy
                if b:FindFirstChild("AeroDynamicSlashVFX") then
                    D:AddItem(b.AeroDynamicSlashVFX, 0)
                    ballState.state.AerodynamicTime = now
                end
                if tornado and now - ballState.state.AerodynamicTime < tornadoTime + 0.314159 then return end
                if primaryTarget == name and ballState.curved(b) then return end
                if tgt == name and dist <= pingThreshold + mx(speed / divisor, 9.5) and parryState.accuracy * 0.8 then
                    parryController.fire()
                    parryState.debounce = true
                    parryState.until_at = now + 1
                end
            end
        end
    end

    triggerbotState.fire = function(b)
        if triggerbotState.busy then return end
        triggerbotState.busy = true
        parryController.fire()
        b:GetAttributeChangedSignal("target"):Once(function()
            triggerbotState.busy = false
        end)
        local start = tick()
        task.spawn(function()
            while true do
                RSvc.PreSimulation:Wait()
                if tick() - start >= 1 or not triggerbotState.busy then break end
            end
            triggerbotState.busy = false
        end)
    end

    local function spamPerform(ping)
        local b = ballState.get()
        local tgt = currentTarget or closestTarget()
        if not b or not tgt or not tgt.PrimaryPart then return false end
        local vel = b.AssemblyLinearVelocity
        local speed = vel.Magnitude
        local chr = LP.Character
        local hrp = chr and chr.PrimaryPart
        if not hrp then return false end
        local dot = (hrp.Position - ballState.position(b)).Unit:Dot(vel.Unit)
        local targetDist = LP:DistanceFromCharacter(tgt.PrimaryPart.Position)
        local reach = ping + mn(speed / 6, 95)
        if targetDist > reach then return spamController.distance end
        if reach < ballState.props().Distance then return spamController.distance end
        if reach < targetDist then return spamController.distance end
        spamController.distance = reach - clamp(dot, -1, 0) * (5 - mn(speed / 5, 5))
        return spamController.distance
    end

    local function spamTick()
        local b = ballState.get()
        if not b or not b:FindFirstChild("zoomies") then return end
        closestTarget()
        if not currentTarget or not currentTarget.PrimaryPart then return end
        local now = tick()
        local reach = spamPerform(clamp(dataPing:GetValue() / 10, 1, 16))
        local chr = LP.Character
        local hrp = chr and chr.PrimaryPart
        if not hrp then return end
        local distBall = (hrp.Position - ballState.position(b)).Magnitude
        local tgt = b:GetAttribute("target")
        if not tgt then return end
        local distTgt = LP:DistanceFromCharacter(currentTarget.PrimaryPart.Position)
        if distTgt > reach or distBall > reach then return end
        if chr:GetAttribute("Pulsed") then return end
        if tgt == name and distTgt > 30 and distBall > 30 then return end
        if distBall <= reach and parryController.count > config.spam_threshold and now - spamController.last_auto >= 0.001 then
            spamController.last_auto = now
            parryController.fire(true)
        end
    end

    local Oxy = _G.OxyCombat
    Oxy.config = config
    Oxy.ballState = ballState

    function Oxy.fire(animate) return parryController.fire(animate == true) end

    function Oxy.startAutoParry()
        if apConn then apConn:Disconnect() end
        parryState.debounce = false
        parryState.until_at = 0
        apConn = RSvc.PostSimulation:Connect(parryTick)
        OxyConn.auto_parry = apConn
    end
    function Oxy.stopAutoParry()
        if apConn then apConn:Disconnect() end
        apConn = nil
        OxyConn.auto_parry = nil
    end
    function Oxy.setAccuracy(acc)
        parryState.accuracy = (acc - 1) * 0.015151515151515152
        config.accuracy = acc
    end
    function Oxy.setCurve(m) config.curve_method = m end
    function Oxy.setRandomTarget(on)
        config.random_target = on == true
        currentTarget = nil
        visited = {}
        if on then pickRandomTarget() end
    end
    function Oxy.startTriggerbot()
        if OxyConn.triggerbot then OxyConn.triggerbot:Disconnect() end
        triggerbotState.on = true
        OxyConn.triggerbot = RSvc.PreSimulation:Connect(function()
            local b = ballState.get()
            if b and b:GetAttribute("target") == name then triggerbotState.fire(b) end
        end)
    end
    function Oxy.stopTriggerbot()
        triggerbotState.on = false
        if OxyConn.triggerbot then OxyConn.triggerbot:Disconnect(); OxyConn.triggerbot = nil end
        triggerbotState.busy = false
    end
    function Oxy.startAutoSpam()
        if OxyConn.auto_spam then OxyConn.auto_spam:Disconnect() end
        OxyConn.auto_spam = RSvc.PreSimulation:Connect(spamTick)
    end
    function Oxy.stopAutoSpam()
        if OxyConn.auto_spam then OxyConn.auto_spam:Disconnect(); OxyConn.auto_spam = nil end
    end
    function Oxy.setManualSpam(on)
        if OxyConn.manual_spam then OxyConn.manual_spam:Disconnect(); OxyConn.manual_spam = nil end
        if on then
            local last = 0
            OxyConn.manual_spam = RSvc.PreSimulation:Connect(function()
                local now = tick()
                if now - last < 0.001 then return end
                last = now
                parryController.fire(true)
            end)
        end
    end
    function Oxy.setSpamThreshold(n) config.spam_threshold = tonumber(n) or 3 end
    function Oxy.startKeypressOnce()
        parryController.fire(true)
    end

    Oxy.ready = true
    print("[OxyCombat] loaded.")
end)

-- ═══════════════════════════════════════════════════════════════════
-- ANGELI NON-COMBAT
-- Tidak ada hook remote, tidak ada parry engine. Itu semua di Oxy.
-- ═══════════════════════════════════════════════════════════════════

-- ─── System.ball (dipakai detector + ESP, bukan combat) ──────────
System.ball = {}
function System.ball.get()
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return nil end
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            return ball
        end
    end
    return nil
end
function System.ball.get_all()
    local t = {}
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return t end
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            table.insert(t, ball)
        end
    end
    return t
end

-- ─── Curve (dipakai detection saja, bukan fire parry) ───────────
System.player = {}
local Closest_Entity = nil
local last_closest_check = 0

function System.player.get_closest()
    local now = tick()
    if now - last_closest_check < 0.1 then return Closest_Entity end
    last_closest_check = now
    local maxD = math.huge
    local closest = nil
    if not Alive then return nil end
    for _, entity in pairs(Alive:GetChildren()) do
        if entity ~= LocalPlayer.Character and entity.PrimaryPart then
            local d = LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
            if d < maxD then maxD = d; closest = entity end
        end
    end
    Closest_Entity = closest
    return closest
end

function System.player.get_closest_to_cursor()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then return nil end
    local closest = nil
    local minDot = -math.huge
    local camera = workspace.CurrentCamera
    if not Alive then return nil end
    local ok, mouseLoc = pcall(function() return UserInputService:GetMouseLocation() end)
    if not ok then return nil end
    local ray = camera:ScreenPointToRay(mouseLoc.X, mouseLoc.Y)
    local pointer = CFrame.lookAt(ray.Origin, ray.Origin + ray.Direction)
    for _, player in pairs(Alive:GetChildren()) do
        if player ~= LocalPlayer.Character and player:FindFirstChild('HumanoidRootPart') then
            local dir = (player.HumanoidRootPart.Position - camera.CFrame.Position).Unit
            local dot = pointer.LookVector:Dot(dir)
            if dot > minDot then minDot = dot; closest = player end
        end
    end
    return closest
end

-- ─── Detection ───────────────────────────────────────────────────
local function linear_predict(a, b, t) return a + (b - a) * t end
System.detection = {
    __ball_properties = {
        __aerodynamic_time = tick(),
        __last_warping = tick(),
        __lerp_radians = 0,
        __curving = tick()
    }
}
function System.detection.is_curved()
    local props = System.detection.__ball_properties
    local ball = System.ball.get()
    if not ball then return false end
    local zoomies = ball:FindFirstChild("zoomies")
    if not zoomies then return false end
    local velocity = zoomies.VectorVelocity
    local speed = velocity.Magnitude
    if speed < 1 then return false end
    local ball_dir = velocity.Unit
    local char = LocalPlayer.Character
    if not char or not char.PrimaryPart then return false end
    local pos = char.PrimaryPart.Position
    local direction = (pos - ball.Position).Unit
    local dot = direction:Dot(ball_dir)
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
    local distance = (pos - ball.Position).Magnitude
    local reach_time = distance / speed - ping
    local dot_threshold = 0.55 - (ping * 0.75)
    dot_threshold = math.clamp(dot_threshold, -1, 0.45)
    local speed_threshold = math.min(speed / 100, 45)
    local ball_distance_threshold = 15 - math.min(distance / 1000, 15) + speed_threshold
    local clamped_dot = math.clamp(dot, -1, 1)
    local radians = math.asin(clamped_dot)
    props.__lerp_radians = linear_predict(props.__lerp_radians, radians, 0.85)
    if props.__lerp_radians < 0.016 then props.__last_warping = tick() end
    if distance < (ball_distance_threshold * 0.85) then return false end
    if (tick() - props.__last_warping) < (reach_time / 1.4) then return true end
    if (tick() - props.__curving) < (reach_time / 1.1) then return true end
    return dot < dot_threshold
end

ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c, d)
    System.__properties.__deathslash_active = d or false
end)
ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a, b)
    System.__properties.__infinity_active = b or false
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local p = args[1]
    if p == LocalPlayer or p == LocalPlayer.Name or (p and p.Name == LocalPlayer.Name) then
        System.__properties.__timehole_active = true
    end
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
    System.__properties.__timehole_active = false
end)

local maxParryCount = 36
local parryDelay = 0.05

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local p = args[1]
    if p == LocalPlayer or p == LocalPlayer.Name or (p and p.Name == LocalPlayer.Name) then
        System.__properties.__slashesoffury_active = true
        System.__properties.__slashesoffury_count = 0
    end
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_active = false
    System.__properties.__slashesoffury_count = 0
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_count = System.__properties.__slashesoffury_count + 1
end)
ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
    spawn(function()
        while System.__properties.__slashesoffury_active and System.__properties.__slashesoffury_count < maxParryCount do
            if System.__config.__detections.__slashesoffury then
                -- fire lewat Oxy, bukan fungsi Angeli
                if _G.OxyCombat and _G.OxyCombat.ready then _G.OxyCombat.fire(false) end
                task.wait(parryDelay)
            else
                break
            end
        end
    end)
end)

-- ─── Anti-Phantom ────────────────────────────────────────────────
Runtime.ChildAdded:Connect(function(Object)
    if not System.__config.__detections.__phantom then return end
    if Object.Name == "maxTransmission" or Object.Name == "transmissionpart" then
        local Weld = Object:FindFirstChildWhichIsA("WeldConstraint")
        if Weld then
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if Character and Weld.Part1 == Character.HumanoidRootPart then
                local CurrentBall = System.ball.get()
                Weld:Destroy()
                if CurrentBall then
                    local FocusConnection
                    FocusConnection = RunService.RenderStepped:Connect(function()
                        local Highlighted = CurrentBall:GetAttribute("highlighted")
                        if Highlighted == true then
                            ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                            System.__properties.__parried = true
                            task.delay(1, function() System.__properties.__parried = false end)
                        elseif Highlighted == false then
                            FocusConnection:Disconnect()
                        end
                    end)
                    task.delay(3, function()
                        if FocusConnection and FocusConnection.Connected then FocusConnection:Disconnect() end
                    end)
                end
            end
        end
    end
end)

-- ─── Skin changer (TANPA setupvalue, TANPA disable connection) ────
local swordInstancesInstance = ReplicatedStorage:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
local swordInstances = require(swordInstancesInstance)

local swordsController

task.spawn(function()
    while task.wait() and (not swordsController) do
        for i, v in getconnections(ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent) do
            if v.Function and islclosure(v.Function) then
                local upvalues = getupvalues(v.Function)
                if #upvalues == 1 and type(upvalues[1]) == "table" then
                    swordsController = upvalues[1]
                    break
                end
            end
        end
    end
end)

local function getSlashName(swordName)
    local data = swordInstances:GetSword(swordName)
    return (data and data.SlashName) or "SlashEffect"
end

local function setSword()
    if not getgenv().skinChangerEnabled then return end
    if getgenv().changeSwordModel and getgenv().swordModel and getgenv().swordModel ~= "" then
        pcall(function()
            swordInstances:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel)
        end)
    end
    if getgenv().changeSwordAnimation and swordsController and getgenv().swordAnimations and getgenv().swordAnimations ~= "" then
        pcall(function()
            swordsController:SetSword(getgenv().swordAnimations)
        end)
    end
end

getgenv().slashName = "SlashEffect"

getgenv().updateSword = function()
    if getgenv().changeSwordFX and getgenv().swordFX and getgenv().swordFX ~= "" then
        pcall(function()
            getgenv().slashName = getSlashName(getgenv().swordFX)
        end)
    end
    setSword()
end

task.spawn(function()
    while task.wait(1) do
        if getgenv().skinChangerEnabled and getgenv().changeSwordModel and getgenv().swordModel and getgenv().swordModel ~= "" then
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then setSword() end
            if char and (not char:FindFirstChild(getgenv().swordModel)) then setSword() end
            for _, v in (char and char:GetChildren()) or {} do
                if v:IsA("Model") and v.Name ~= getgenv().swordModel then
                    pcall(function() v:Destroy() end)
                end
                task.wait()
            end
        end
    end
end)

-- ─── Default config ───────────────────────────────────────────────
getgenv().AutoParryMode = "Remote"
getgenv().AutoParryNotify = false
getgenv().CooldownProtection = false
getgenv().AutoAbility = false
getgenv().TriggerbotNotify = false
getgenv().AutoCurveHotkeyNotify = false
getgenv().AutoCurveHotkeyEnabled = false
getgenv().InfinityNotify = false
getgenv().ManualSpamNotify = false
getgenv().ManualSpamMode = "Remote"
getgenv().ManualSpamAnimationFix = false
getgenv().AutoSpamNotify = false
getgenv().AutoSpamMode = "Remote"
getgenv().AutoSpamAnimationFix = false
getgenv().AutoStop = false
getgenv().CameraEnabled = false
getgenv().CameraFOV = 70
getgenv().CharacterModifierEnabled = false
getgenv().WalkspeedCheckboxEnabled = false
getgenv().CustomWalkSpeed = 36
getgenv().JumpPowerCheckboxEnabled = false
getgenv().CustomJumpPower = 50
getgenv().SpinbotCheckboxEnabled = false
getgenv().CustomSpinSpeed = 5
getgenv().GravityCheckboxEnabled = false
getgenv().CustomGravity = 196.2
getgenv().HipHeightCheckboxEnabled = false
getgenv().CustomHipHeight = 0
getgenv().InfiniteJumpCheckboxEnabled = false
getgenv().skinChangerEnabled = false
getgenv().changeSwordModel = true
getgenv().changeSwordAnimation = true
getgenv().changeSwordFX = true
getgenv().swordModel = ""
getgenv().swordAnimations = ""
getgenv().swordFX = ""

-- ═══════════════════════════════════════════════════════════════════
-- UI — combat sections wired to Oxy, non-combat ke Angeli
-- ═══════════════════════════════════════════════════════════════════

-- ─── Rage tab — Auto Parry ────────────────────────────────────────
local autoparry_section = Tabs.Rage:AddSection("Auto Parry", "shield")

autoparry_section:AddToggle("AutoParryToggle", {
    Title = "Auto Parry",
    Description = "Oxy engine",
    Default = false,
    Callback = function(v)
        if v then
            if not _G.OxyCombat or not _G.OxyCombat.ready then
                Fluent:Notify({ Title = "Auto Parry", Content = "Oxy engine not ready", Duration = 3 })
                return
            end
            _G.OxyCombat.startAutoParry()
        else
            if _G.OxyCombat then _G.OxyCombat.stopAutoParry() end
        end
    end
})

autoparry_section:AddDropdown("ParryMode", {
    Title = "Parry Mode",
    Values = { "Remote", "Keypress" },
    Default = "Remote",
    Callback = function(v) getgenv().AutoParryMode = v end
})

autoparry_section:AddDropdown("ModeCurve", {
    Title = "Mode curve",
    Values = { "Camera", "Dot", "Backwards", "Slow", "Random" },
    Default = "Camera",
    Callback = function(v)
        if _G.OxyCombat and _G.OxyCombat.ready then
            _G.OxyCombat.setCurve(v:lower())
        end
    end
})

autoparry_section:AddSlider("ParryAccuracy", {
    Title = "Parry Accuracy",
    Min = 1, Max = 100, Default = 100, Rounding = 1,
    Callback = function(v)
        System.__properties.__accuracy = v
        update_divisor()
        if _G.OxyCombat and _G.OxyCombat.ready then _G.OxyCombat.setAccuracy(v) end
    end
})

autoparry_section:AddToggle("PlayAnimation", {
    Title = "Play Animation",
    Default = false,
    Callback = function(v) System.__properties.__play_animation = v end
})

autoparry_section:AddToggle("CooldownProtection", {
    Title = "Cooldown Protection",
    Default = false,
    Callback = function(v) getgenv().CooldownProtection = v end
})

autoparry_section:AddToggle("AutoAbility", {
    Title = "Auto Ability",
    Default = false,
    Callback = function(v) getgenv().AutoAbility = v end
})

autoparry_section:AddToggle("AutoParryNotify", {
    Title = "Notify",
    Default = false,
    Callback = function(v) getgenv().AutoParryNotify = v end
})

-- ─── Rage tab — Triggerbot ────────────────────────────────────────
local triggerbot_section = Tabs.Rage:AddSection("Triggerbot", "target")

triggerbot_section:AddToggle("TriggerbotToggle", {
    Title = "Triggerbot",
    Description = "Oxy engine",
    Default = false,
    Callback = function(v)
        if v then
            if not _G.OxyCombat or not _G.OxyCombat.ready then
                Fluent:Notify({ Title = "Triggerbot", Content = "Oxy engine not ready", Duration = 3 })
                return
            end
            _G.OxyCombat.startTriggerbot()
        else
            if _G.OxyCombat then _G.OxyCombat.stopTriggerbot() end
        end
    end
})

triggerbot_section:AddToggle("TriggerbotNotify", {
    Title = "Notify",
    Default = false,
    Callback = function(v) getgenv().TriggerbotNotify = v end
})

-- ─── Detection tab ────────────────────────────────────────────────
local infinity_section = Tabs.Detection:AddSection("Infinity Detection", "infinity")
infinity_section:AddToggle("InfinityDetection", {
    Title = "Infinity Detection",
    Default = false,
    Callback = function(v) System.__config.__detections.__infinity = v end
})
infinity_section:AddToggle("InfinityNotify", {
    Title = "Notify",
    Default = false,
    Callback = function(v) getgenv().InfinityNotify = v end
})

local deathslash_section = Tabs.Detection:AddSection("Death Slash Detection", "skull")
deathslash_section:AddToggle("DeathSlashDetection", {
    Title = "Death Slash Detection",
    Default = false,
    Callback = function(v) System.__config.__detections.__deathslash = v end
})

local timehole_section = Tabs.Detection:AddSection("Time Hole Detection", "clock")
timehole_section:AddToggle("TimeHoleDetection", {
    Title = "Time Hole Detection",
    Default = false,
    Callback = function(v) System.__config.__detections.__timehole = v end
})

local slashes_section = Tabs.Detection:AddSection("Slashes Of Fury Detection", "swords")
slashes_section:AddToggle("SlashesOfFuryDetection", {
    Title = "Slashes Of Fury Detection",
    Default = false,
    Callback = function(v) System.__config.__detections.__slashesoffury = v end
})
slashes_section:AddSlider("ParryDelay", {
    Title = "Parry Delay",
    Min = 0.05, Max = 0.25, Default = 0.05, Rounding = 2,
    Callback = function(v) parryDelay = v end
})
slashes_section:AddSlider("MaxParryCount", {
    Title = "Max Parry Count",
    Min = 1, Max = 100, Default = 36, Rounding = 0,
    Callback = function(v) maxParryCount = v end
})

local phantom_section = Tabs.Detection:AddSection("Anti-Phantom [BETA]", "ghost")
phantom_section:AddToggle("AntiPhantom", {
    Title = "Anti-Phantom [BETA]",
    Default = false,
    Callback = function(v) System.__config.__detections.__phantom = v end
})

-- ─── Spam tab ─────────────────────────────────────────────────────
local manual_spam_section = Tabs.Spam:AddSection("Manual Spam", "zap")
manual_spam_section:AddToggle("ManualSpamToggle", {
    Title = "Manual Spam",
    Description = "Oxy engine",
    Default = false,
    Callback = function(v)
        if not _G.OxyCombat or not _G.OxyCombat.ready then
            Fluent:Notify({ Title = "Manual Spam", Content = "Oxy engine not ready", Duration = 3 })
            return
        end
        _G.OxyCombat.setManualSpam(v)
    end
})
manual_spam_section:AddToggle("ManualSpamNotify", {
    Title = "Notify",
    Default = false,
    Callback = function(v) getgenv().ManualSpamNotify = v end
})

local auto_spam_section = Tabs.Spam:AddSection("Auto Spam", "zap")
auto_spam_section:AddToggle("AutoSpamToggle", {
    Title = "Auto Spam",
    Description = "Oxy engine",
    Default = false,
    Callback = function(v)
        if v then
            if not _G.OxyCombat or not _G.OxyCombat.ready then
                Fluent:Notify({ Title = "Auto Spam", Content = "Oxy engine not ready", Duration = 3 })
                return
            end
            _G.OxyCombat.startAutoSpam()
        else
            if _G.OxyCombat then _G.OxyCombat.stopAutoSpam() end
        end
    end
})
auto_spam_section:AddToggle("AutoSpamNotify", {
    Title = "Notify",
    Default = false,
    Callback = function(v) getgenv().AutoSpamNotify = v end
})
auto_spam_section:AddSlider("ParryThreshold", {
    Title = "Parry Threshold",
    Min = 0, Max = 10, Default = 2.5, Rounding = 1,
    Callback = function(v)
        System.__properties.__spam_threshold = v
        if _G.OxyCombat and _G.OxyCombat.ready then _G.OxyCombat.setSpamThreshold(v) end
    end
})
auto_spam_section:AddSlider("DistanceMultiplier", {
    Title = "Distance Multiplier",
    Min = 0.3, Max = 3.0, Default = 0.3, Rounding = 1,
    Callback = function(v) System.__properties.__auto_spam_distance_multiplier = v end
})

-- ─── Player tab ───────────────────────────────────────────────────
local avatar_section = Tabs.Player:AddSection("Avatar Changer", "user")
local __flags = {}
local __players = cloneref(game:GetService('Players'))
local __localplayer = __players.LocalPlayer

local function __apparence(__name)
    local s, e = pcall(function()
        local __id = __players:GetUserIdFromNameAsync(__name)
        return __players:GetHumanoidDescriptionFromUserId(__id)
    end)
    if not s then return nil end
    return e
end

local function __set(__name, __char)
    if not __name or __name == '' then return end
    local __hum = __char and __char:WaitForChild('Humanoid', 5)
    if not __hum then return end
    local __desc = __apparence(__name)
    if not __desc then return end
    __localplayer:ClearCharacterAppearance()
    pcall(function()
        __hum:ApplyDescription(__desc)
    end)
end

avatar_section:AddToggle("AvatarChanger", {
    Title = "Avatar Changer",
    Default = false,
    Callback = function(val)
        __flags['Skin Changer'] = val
        if val then
            local __char = __localplayer.Character
            if __char and __flags['name'] then __set(__flags['name'], __char) end
            __flags['loop'] = __localplayer.CharacterAdded:Connect(function(char)
                task.wait(0.75)
                if __flags['name'] then __set(__flags['name'], char) end
            end)
        else
            if __flags['loop'] then
                __flags['loop']:Disconnect()
                __flags['loop'] = nil
                local __char = __localplayer.Character
                if __char then __set(__localplayer.Name, __char) end
            end
        end
    end
})
avatar_section:AddInput("TargetUsername", {
    Title = "Target Username",
    Placeholder = "Enter Username...",
    Default = "",
    Callback = function(val)
        __flags['name'] = val
        if __flags['Skin Changer'] and val ~= '' then
            local __char = __localplayer.Character
            if __char then __set(val, __char) end
        end
    end
})

local fov_section = Tabs.Player:AddSection("FOV", "maximize")
fov_section:AddToggle("FOV", {
    Title = "FOV",
    Default = false,
    Callback = function(value)
        getgenv().CameraEnabled = value
        local Camera = workspace.CurrentCamera
        if value then
            getgenv().CameraFOV = getgenv().CameraFOV or 70
            Camera.FieldOfView = getgenv().CameraFOV
            if not getgenv().FOVLoop then
                getgenv().FOVLoop = RunService.RenderStepped:Connect(function()
                    if getgenv().CameraEnabled then Camera.FieldOfView = getgenv().CameraFOV end
                end)
            end
        else
            Camera.FieldOfView = 70
            if getgenv().FOVLoop then getgenv().FOVLoop:Disconnect(); getgenv().FOVLoop = nil end
        end
    end
})
fov_section:AddSlider("CameraFOV", {
    Title = "Camera FOV",
    Min = 50, Max = 120, Default = 70, Rounding = 1,
    Callback = function(Value)
        getgenv().CameraFOV = Value
        if getgenv().CameraEnabled then workspace.CurrentCamera.FieldOfView = Value end
    end
})

local character_section = Tabs.Player:AddSection("Character", "user")
character_section:AddToggle("CharacterModifier", {
    Title = "Character Modifier",
    Default = false,
    Callback = function(value)
        getgenv().CharacterModifierEnabled = value
        if value then
            if not getgenv().CharacterConnection then
                getgenv().OriginalValues = {}
                getgenv().spinAngle = 0
                getgenv().CharacterConnection = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    local humanoid = char:FindFirstChild("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if humanoid then
                        if not getgenv().OriginalValues.WalkSpeed then
                            getgenv().OriginalValues.WalkSpeed = humanoid.WalkSpeed
                            getgenv().OriginalValues.JumpPower = humanoid.JumpPower
                            getgenv().OriginalValues.JumpHeight = humanoid.JumpHeight
                            getgenv().OriginalValues.HipHeight = humanoid.HipHeight
                            getgenv().OriginalValues.AutoRotate = humanoid.AutoRotate
                        end
                        if getgenv().WalkspeedCheckboxEnabled then humanoid.WalkSpeed = getgenv().CustomWalkSpeed or 36 end
                        if getgenv().JumpPowerCheckboxEnabled then
                            if humanoid.UseJumpPower then humanoid.JumpPower = getgenv().CustomJumpPower or 50
                            else humanoid.JumpHeight = getgenv().CustomJumpHeight or 7.2 end
                        end
                        if getgenv().HipHeightCheckboxEnabled then humanoid.HipHeight = getgenv().CustomHipHeight or 0 end
                        if getgenv().SpinbotCheckboxEnabled and root then
                            humanoid.AutoRotate = false
                            getgenv().spinAngle = (getgenv().spinAngle + (getgenv().CustomSpinSpeed or 5)) % 360
                            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(getgenv().spinAngle), 0)
                        else
                            if getgenv().OriginalValues.AutoRotate ~= nil then humanoid.AutoRotate = getgenv().OriginalValues.AutoRotate end
                        end
                    end
                    if getgenv().GravityCheckboxEnabled and getgenv().CustomGravity then workspace.Gravity = getgenv().CustomGravity end
                end)
            end
        else
            if getgenv().CharacterConnection then
                getgenv().CharacterConnection:Disconnect()
                getgenv().CharacterConnection = nil
                local char = LocalPlayer.Character
                if char then
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid and getgenv().OriginalValues then
                        humanoid.WalkSpeed = getgenv().OriginalValues.WalkSpeed or 16
                        if humanoid.UseJumpPower then humanoid.JumpPower = getgenv().OriginalValues.JumpPower or 50
                        else humanoid.JumpHeight = getgenv().OriginalValues.JumpHeight or 7.2 end
                        humanoid.HipHeight = getgenv().OriginalValues.HipHeight or 0
                        humanoid.AutoRotate = getgenv().OriginalValues.AutoRotate or true
                    end
                end
                workspace.Gravity = 196.2
                if getgenv().InfiniteJumpConnection then
                    getgenv().InfiniteJumpConnection:Disconnect()
                    getgenv().InfiniteJumpConnection = nil
                end
                getgenv().OriginalValues = nil
                getgenv().spinAngle = nil
            end
        end
    end
})
character_section:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(value)
        getgenv().InfiniteJumpCheckboxEnabled = value
        if value and getgenv().CharacterModifierEnabled then
            if not getgenv().InfiniteJumpConnection then
                getgenv().InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
                    if getgenv().InfiniteJumpCheckboxEnabled and getgenv().CharacterModifierEnabled then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end)
            end
        else
            if getgenv().InfiniteJumpConnection then
                getgenv().InfiniteJumpConnection:Disconnect()
                getgenv().InfiniteJumpConnection = nil
            end
        end
    end
})
character_section:AddToggle("Spinbot", {
    Title = "Spin",
    Default = false,
    Callback = function(value)
        getgenv().SpinbotCheckboxEnabled = value
        if not value and getgenv().CharacterModifierEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
                char.Humanoid.AutoRotate = getgenv().OriginalValues.AutoRotate or true
            end
        end
    end
})
character_section:AddSlider("SpinSpeed", {
    Title = "Spin Speed",
    Min = 1, Max = 50, Default = 5, Rounding = 1,
    Callback = function(Value) getgenv().CustomSpinSpeed = Value end
})
character_section:AddToggle("WalkSpeed", {
    Title = "Walk Speed",
    Default = false,
    Callback = function(value)
        getgenv().WalkspeedCheckboxEnabled = value
        if not value and getgenv().CharacterModifierEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
                char.Humanoid.WalkSpeed = getgenv().OriginalValues.WalkSpeed or 16
            end
        end
    end
})
character_section:AddSlider("WalkSpeedValue", {
    Title = "Walk Speed Value",
    Min = 16, Max = 500, Default = 36, Rounding = 1,
    Callback = function(Value)
        getgenv().CustomWalkSpeed = Value
        if getgenv().CharacterModifierEnabled and getgenv().WalkspeedCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = Value end
        end
    end
})
character_section:AddToggle("JumpPower", {
    Title = "Jump Power",
    Default = false,
    Callback = function(value)
        getgenv().JumpPowerCheckboxEnabled = value
        if not value and getgenv().CharacterModifierEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
                local humanoid = char.Humanoid
                if humanoid.UseJumpPower then humanoid.JumpPower = getgenv().OriginalValues.JumpPower or 50
                else humanoid.JumpHeight = getgenv().OriginalValues.JumpHeight or 7.2 end
            end
        end
    end
})
character_section:AddSlider("JumpPowerValue", {
    Title = "Jump Power Value",
    Min = 50, Max = 200, Default = 50, Rounding = 1,
    Callback = function(Value)
        getgenv().CustomJumpPower = Value
        getgenv().CustomJumpHeight = Value * 0.144
        if getgenv().CharacterModifierEnabled and getgenv().JumpPowerCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                local humanoid = char.Humanoid
                if humanoid.UseJumpPower then humanoid.JumpPower = Value
                else humanoid.JumpHeight = Value * 0.144 end
            end
        end
    end
})
character_section:AddToggle("Gravity", {
    Title = "Gravity",
    Default = false,
    Callback = function(value)
        getgenv().GravityCheckboxEnabled = value
        if not value and getgenv().CharacterModifierEnabled then workspace.Gravity = 196.2 end
    end
})
character_section:AddSlider("GravityValue", {
    Title = "Gravity Value",
    Min = 0, Max = 400, Default = 196.2, Rounding = 1,
    Callback = function(Value)
        getgenv().CustomGravity = Value
        if getgenv().CharacterModifierEnabled and getgenv().GravityCheckboxEnabled then workspace.Gravity = Value end
    end
})
character_section:AddToggle("HipHeight", {
    Title = "Hip Height",
    Default = false,
    Callback = function(value)
        getgenv().HipHeightCheckboxEnabled = value
        if not value and getgenv().CharacterModifierEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
                char.Humanoid.HipHeight = getgenv().OriginalValues.HipHeight or 0
            end
        end
    end
})
character_section:AddSlider("HipHeightValue", {
    Title = "Hip Height Value",
    Min = -5, Max = 20, Default = 0, Rounding = 1,
    Callback = function(Value)
        getgenv().CustomHipHeight = Value
        if getgenv().CharacterModifierEnabled and getgenv().HipHeightCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.HipHeight = Value end
        end
    end
})

-- ─── Visuals tab — Ability ESP ────────────────────────────────────
local ability_esp = {
    __config = {
        gui_name = "AbilityESPGui",
        gui_size = UDim2.new(0, 200, 0, 40),
        studs_offset = Vector3.new(0, 3.2, 0),
        text_color = Color3.fromRGB(255, 255, 255),
        stroke_color = Color3.fromRGB(0, 0, 0),
        font = Enum.Font.GothamBold,
        text_size = 14,
        update_rate = 1/30
    },
    __state = { active = false, players = {}, update_task = nil }
}
function ability_esp.create_billboard(player)
    local character = player.Character
    if not character then return nil end
    local humanoid = character:FindFirstChild("Humanoid")
    local head = character:FindFirstChild("Head")
    if not humanoid or not head then return nil end
    local existing = head:FindFirstChild(ability_esp.__config.gui_name)
    if existing then existing:Destroy() end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = ability_esp.__config.gui_name
    billboard.Adornee = head
    billboard.Size = ability_esp.__config.gui_size
    billboard.StudsOffset = ability_esp.__config.studs_offset
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = ability_esp.__config.text_color
    label.TextStrokeColor3 = ability_esp.__config.stroke_color
    label.TextStrokeTransparency = 0.5
    label.Font = ability_esp.__config.font
    label.TextSize = ability_esp.__config.text_size
    label.Parent = billboard
    return label, billboard
end
function ability_esp.update_label(player, label)
    if not player or not label then return false end
    if ability_esp.__state.active then
        label.Visible = true
        local ab = player:GetAttribute("EquippedAbility")
        label.Text = ab and (player.DisplayName .. "  [" .. ab .. "]") or player.DisplayName
    else
        label.Visible = false
    end
    return true
end
function ability_esp.setup_character(player)
    task.wait(0.1)
    local character = player.Character
    if not character then return end
    local label, billboard = ability_esp.create_billboard(player)
    if not label then return end
    if not ability_esp.__state.players[player] then ability_esp.__state.players[player] = {} end
    ability_esp.__state.players[player].label = label
    ability_esp.__state.players[player].billboard = billboard
    ability_esp.__state.players[player].character = character
end
function ability_esp.add_player(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function() ability_esp.setup_character(player) end)
    if player.Character then task.spawn(function() ability_esp.setup_character(player) end) end
end
function ability_esp.update_loop()
    while ability_esp.__state.active do
        task.wait(ability_esp.__config.update_rate)
        for player, data in pairs(ability_esp.__state.players) do
            if player.Character and data.label then ability_esp.update_label(player, data.label) end
        end
    end
end
function ability_esp.start()
    if ability_esp.__state.active then return end
    ability_esp.__state.active = true
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then ability_esp.add_player(player) end
    end
    ability_esp.__state.update_task = task.spawn(function() ability_esp.update_loop() end)
end
function ability_esp.stop()
    if not ability_esp.__state.active then return end
    ability_esp.__state.active = false
    for _, v in pairs(ability_esp.__state.players) do
        if v.billboard then v.billboard:Destroy() end
    end
    ability_esp.__state.players = {}
end

local ability_esp_section = Tabs.Visuals:AddSection("Ability ESP", "eye")
ability_esp_section:AddToggle("AbilityESP", {
    Title = "Ability ESP",
    Default = false,
    Callback = function(v)
        if v then ability_esp.start() else ability_esp.stop() end
    end
})

-- ─── Visuals tab — Ball Velocity HUD ──────────────────────────────
System.__properties.__ball_velocity_gui = nil
System.__properties.__ball_velocity_enabled = false
System.__properties.__peak_velocity = 0
System.__properties.__last_ball_id = nil

function System.create_ball_velocity_gui()
    if System.__properties.__ball_velocity_gui then System.__properties.__ball_velocity_gui.gui:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "BallVelocityGUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 80)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 8); c1.Parent = frame
    local c2 = Instance.new("UIStroke"); c2.Color = Color3.new(1,1,1); c2.Thickness = 2; c2.Parent = frame
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 20); title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1; title.Text = "⚡ Ball Velocity"
    title.TextColor3 = Color3.new(1,1,1); title.Font = Enum.Font.GothamBold; title.TextSize = 14
    title.Parent = frame
    local cur = Instance.new("TextLabel")
    cur.Size = UDim2.new(1, -10, 0, 25); cur.Position = UDim2.new(0, 5, 0, 25)
    cur.BackgroundTransparency = 1; cur.Text = "Current: 0"
    cur.TextColor3 = Color3.new(1,1,1); cur.Font = Enum.Font.GothamBold; cur.TextSize = 16
    cur.TextXAlignment = Enum.TextXAlignment.Left; cur.Parent = frame
    local pk = Instance.new("TextLabel")
    pk.Size = UDim2.new(1, -10, 0, 25); pk.Position = UDim2.new(0, 5, 0, 50)
    pk.BackgroundTransparency = 1; pk.Text = "Peak: 0"
    pk.TextColor3 = Color3.new(1,1,1); pk.Font = Enum.Font.GothamBold; pk.TextSize = 16
    pk.TextXAlignment = Enum.TextXAlignment.Left; pk.Parent = frame
    frame.Parent = gui
    gui.Parent = CoreGui
    System.__properties.__ball_velocity_gui = { gui = gui, frame = frame, currentSpeedLabel = cur, peakSpeedLabel = pk }
end
function System.update_ball_velocity()
    if not System.__properties.__ball_velocity_enabled or not System.__properties.__ball_velocity_gui then return end
    local ball = System.ball.get()
    if not ball then
        System.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
        return
    end
    local ballId = ball:GetFullName()
    if ballId ~= System.__properties.__last_ball_id then
        System.__properties.__peak_velocity = 0
        System.__properties.__last_ball_id = ballId
    end
    local zoomies = ball:FindFirstChild('zoomies')
    if not zoomies then
        System.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
        return
    end
    local speed = zoomies.VectorVelocity.Magnitude
    if speed > System.__properties.__peak_velocity then System.__properties.__peak_velocity = speed end
    System.__properties.__ball_velocity_gui.currentSpeedLabel.Text = string.format("Current: %.1f", speed)
    System.__properties.__ball_velocity_gui.peakSpeedLabel.Text = string.format("Peak: %.1f", System.__properties.__peak_velocity)
end

local ball_velocity_section = Tabs.Visuals:AddSection("Ball Velocity", "gauge")
ball_velocity_section:AddToggle("BallVelocity", {
    Title = "Show Ball Velocity",
    Default = false,
    Callback = function(value)
        System.__properties.__ball_velocity_enabled = value
        if value then
            System.create_ball_velocity_gui()
            if not System.__properties.__connections.__ball_velocity then
                System.__properties.__connections.__ball_velocity = RunService.RenderStepped:Connect(function()
                    System.update_ball_velocity()
                end)
            end
        else
            if System.__properties.__ball_velocity_gui then
                System.__properties.__ball_velocity_gui.gui:Destroy()
                System.__properties.__ball_velocity_gui = nil
            end
            if System.__properties.__connections.__ball_velocity then
                System.__properties.__connections.__ball_velocity:Disconnect()
                System.__properties.__connections.__ball_velocity = nil
            end
            System.__properties.__peak_velocity = 0
            System.__properties.__last_ball_id = nil
        end
    end
})

-- ─── Misc tab — Skin changer ──────────────────────────────────────
local skin_changer_section = Tabs.Misc:AddSection("Skin Changer", "sword")
skin_changer_section:AddToggle("SkinChanger", {
    Title = "Skin Changer",
    Default = false,
    Callback = function(v)
        getgenv().skinChangerEnabled = v
        if v then getgenv().updateSword() end
    end
})
skin_changer_section:AddToggle("ChangeSwordModel", {
    Title = "Change Sword Model",
    Default = true,
    Callback = function(v)
        getgenv().changeSwordModel = v
        if getgenv().skinChangerEnabled then getgenv().updateSword() end
    end
})
skin_changer_section:AddInput("SwordModelName", {
    Title = "Sword Model Name",
    Placeholder = "Name...",
    Default = "",
    Callback = function(text)
        getgenv().swordModel = text
        if getgenv().skinChangerEnabled and getgenv().changeSwordModel then getgenv().updateSword() end
    end
})
skin_changer_section:AddToggle("ChangeSwordAnimation", {
    Title = "Change Sword Animation",
    Default = true,
    Callback = function(v)
        getgenv().changeSwordAnimation = v
        if getgenv().skinChangerEnabled then getgenv().updateSword() end
    end
})
skin_changer_section:AddInput("SwordAnimationName", {
    Title = "Sword Animation Name",
    Placeholder = "Name...",
    Default = "",
    Callback = function(text)
        getgenv().swordAnimations = text
        if getgenv().skinChangerEnabled and getgenv().changeSwordAnimation then getgenv().updateSword() end
    end
})

-- ─── Misc tab — No Render ─────────────────────────────────────────
local no_render_section = Tabs.Misc:AddSection("No Render", "eye-off")
local Connections_Manager = {}
no_render_section:AddToggle("NoRender", {
    Title = "No Render",
    Default = false,
    Callback = function(state)
        local effectScripts = LocalPlayer.PlayerScripts:FindFirstChild("EffectScripts")
        if effectScripts then
            local clientFX = effectScripts:FindFirstChild("ClientFX")
            if clientFX then clientFX.Disabled = state end
        end
        if state then
            Connections_Manager['No Render'] = workspace.Runtime.ChildAdded:Connect(function(Value)
                Debris:AddItem(Value, 0)
            end)
        else
            if Connections_Manager['No Render'] then
                Connections_Manager['No Render']:Disconnect()
                Connections_Manager['No Render'] = nil
            end
        end
    end
})

-- ─── Settings ─────────────────────────────────────────────────────
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("nikaoxyangeli")
SaveManager:SetFolder("nikaoxyangeli/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()

Fluent:Notify({
    Title = "Nika Hub",
    Content = "Loaded. engine attached.",
    Duration = 5
})

print("[nikahub] ready. attached.")

end)
