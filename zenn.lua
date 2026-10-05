-- ═══════════════════════════════════════════════
-- PART 1 — SWORD CHANGER FULL + EXPLOSION CHANGER
-- paste sebelum baris "print('[Zenthra Full] Loaded...')"
-- ═══════════════════════════════════════════════

local swordChanger = {
    loaded       = false,
    enabled      = false,
    model        = "",
    animations   = "",
    fx           = "",
    slash_name   = "SlashEffect",
    show_accessory = false,
    finishers    = {},
    _busy        = false,
    _pending     = false,
    _last_real   = nil,
    _char_conns  = {},
    _original    = { model = nil, saved = false },
    _models      = {},    -- name -> cloned Model
    _controller  = nil,   -- SwordsController reference
    _info_fn     = nil,   -- FireSwordInfo handler
    _parry_fn    = nil,   -- ParrySuccessAll handler
    _tc_module   = nil,
    _tc_tried    = false,
    _color_session = 0,
    _color_cleanup = nil,
    _precache_running = false,
}

local explosionChanger = { enabled = false, name = "" }

-- ───── resolve ItemInfo / Shared / Swords modules ─────
local Shared, ItemInfo, SwordsModule
task.spawn(function()
    for i = 1, 60 do
        local ok = pcall(function()
            Shared = Shared or require(ReplicatedStorage:WaitForChild("Shared", 5))
            ItemInfo = ItemInfo or require(ReplicatedStorage.Shared:WaitForChild("ItemInfo", 5))
            local ri = ReplicatedStorage.Shared:FindFirstChild("ReplicatedInstances")
            if ri then
                local sw = ri:FindFirstChild("Swords")
                if sw then SwordsModule = require(sw) end
            end
        end)
        if Shared and ItemInfo and SwordsModule then return end
        task.wait(0.5)
    end
end)

-- ───── fetch sword model (cache + clone) ─────
local function fetchSwordModel(name)
    if not name or name == "" then return nil end
    if swordChanger._models[name] then
        local ok, c = pcall(function() return swordChanger._models[name]:Clone() end)
        if ok then return c end
        swordChanger._models[name] = nil
    end
    if not SwordsModule then return nil end

    local base = nil
    pcall(function()
        local collection = SwordsModule.Collections and SwordsModule.Collections.Swords
        if collection and collection.Instances then
            base = collection.Instances[name]
        end
    end)
    if not base then
        pcall(function()
            base = SwordsModule:GetInstance("Swords", name)
        end)
    end
    if not base then return nil end

    -- deserialize if it's a StringValue or ModuleScript
    if base:IsA("StringValue") or base:IsA("ModuleScript") then
        local ok, decoded = pcall(function()
            if base:IsA("StringValue") then
                return HttpService:JSONDecode(base.Value)
            end
            local s = require(base)
            if type(s) == "string" then return HttpService:JSONDecode(s) end
            return s
        end)
        if ok and type(decoded) == "table" then
            -- attempt to rehydrate; often already an Instance
        end
    end

    local isModel = base:IsA("Model")
    local isTool  = base:IsA("Tool")
    local clone
    if isModel then
        clone = base:Clone()
    elseif isTool then
        clone = Instance.new("Model")
        clone.Name = name
        local tc = base:Clone()
        tc.Name = name
        tc.Parent = clone
        local bp = tc:FindFirstChildWhichIsA("BasePart", true)
        if bp then clone.PrimaryPart = bp end
    else
        return nil
    end

    local tool = clone:FindFirstChildWhichIsA("Tool", true)
    if tool and tool.Name ~= name then tool.Name = name end

    -- inject ParryAttempt sound from template
    if swordChanger._parry_template then
        for _, d in ipairs(clone:GetDescendants()) do
            if d:IsA("BasePart") and not d:FindFirstChild("ParryAttempt") then
                local s = swordChanger._parry_template:Clone()
                s.Name = "ParryAttempt"
                s.Parent = d
            end
        end
    end

    swordChanger._models[name] = clone
    return clone:Clone()
end

-- ───── patch SwordsController:EquipSwordTo ─────
local function patchEquipSwordTo()
    local function findController()
        local ok, controller = pcall(function()
            return ReplicatedStorage.Controllers:FindFirstChild("SwordsController")
        end)
        if not ok or not controller then return nil end
        return controller
    end

    task.spawn(function()
        for i = 1, 60 do
            if swordChanger._controller then return end
            local ctrl = findController()
            if ctrl then
                local ok, swords = pcall(require, ctrl)
                if ok and type(swords) == "table" then
                    swordChanger._controller = swords
                    -- find EquipSwordTo and its getInstance upvalue
                    local targetFn = swords.EquipSwordTo
                    if targetFn then
                        local upvalues = debug.getupvalue and {} or nil
                        local ok2, ups = pcall(function() return debug.getupvalues(targetFn) end)
                        if ok2 and type(ups) == "table" then
                            for k, v in pairs(ups) do
                                if type(v) == "table" and type(v.getInstance) == "function" then
                                    local originalGet = v.getInstance
                                    v.getInstance = function(_, name)
                                        if swordChanger.enabled and name and swordChanger._models[name] ~= nil then
                                            return fetchSwordModel(name)
                                        end
                                        return originalGet(_, name)
                                    end
                                    break
                                end
                            end
                        end
                    end
                    return
                end
            end
            task.wait(0.5)
        end
    end)
end

-- ───── find ParryAttempt sound template ─────
task.spawn(function()
    for i = 1, 40 do
        local ok = pcall(function()
            local alive = Workspace:FindFirstChild("Alive")
            if alive then
                for _, c in ipairs(alive:GetChildren()) do
                    for _, d in ipairs(c:GetDescendants()) do
                        if d:IsA("Sound") and d.Name == "ParryAttempt" then
                            swordChanger._parry_template = d:Clone()
                            return
                        end
                    end
                end
            end
        end)
        if swordChanger._parry_template then return end
        task.wait(0.5)
    end
end)

-- ───── slash name resolver ─────
local function resolveSlashName(name)
    if not name or name == "" then return "SlashEffect" end
    local ok, sword = pcall(function()
        return SwordsModule:GetSword(name)
    end)
    return (ok and sword and sword.SlashName) or "SlashEffect"
end

-- ───── color config (TweenColor) ─────
local function getTweenColorModule()
    if swordChanger._tc_tried then return swordChanger._tc_module end
    swordChanger._tc_tried = true
    local ok, mod = pcall(function()
        return require(ReplicatedStorage.Shared:WaitForChild("TweenColor", 5))
    end)
    if ok then swordChanger._tc_module = mod end
    return swordChanger._tc_module
end

local function driveColor(swordModel, name, session)
    local cfgRoot = ReplicatedStorage:FindFirstChild("TweenColorConfig")
    if not cfgRoot then return false end
    local cfgName
    pcall(function()
        local info = ItemInfo.Sword[name]
        local attrs = info and info.Attributes
        if type(attrs) == "table" then
            for _, key in ipairs({ "ColorConfig", "TweenColor", "TweenColorConfig", "ChromaConfig" }) do
                local v = attrs[key]
                if type(v) == "string" and cfgRoot:FindFirstChild(v) then cfgName = v return end
            end
        end
        local direct = swordModel:GetAttribute and swordModel:GetAttribute("ColorConfig")
        if type(direct) == "string" and cfgRoot:FindFirstChild(direct) then cfgName = direct end
        if not cfgName and cfgRoot:FindFirstChild(name) then cfgName = name end
    end)
    if not cfgName then return false end
    local cfg = cfgRoot:FindFirstChild(cfgName)
    if not cfg then return false end
    local ok, data = pcall(require, cfg)
    if not ok or type(data) ~= "table" or type(data.Colors) ~= "table" then return false end
    local colors = data.Colors
    if #colors == 0 then return false end
    local total = 0
    for _, c in ipairs(colors) do total += c.TweenInfo.Time end
    if total <= 0 then return false end
    local shouldSync = data.ShouldSync or false
    local syncSeed = data.SyncSeed or 0

    local targets = {}
    local skipClass = {
        UIStroke = true, Decal = true, PointLight = true, SpotLight = true,
        Beam = true, Trail = true, ParticleEmitter = true, UIGradient = true,
        SurfaceAppearance = true,
    }

    for _, d in ipairs(swordModel:GetDescendants()) do
        local skip = d:GetAttribute and d:GetAttribute("IgnoreChangeColor") == true
        if not skip and (skipClass[d.ClassName] or d:IsA("GuiObject") or d:IsA("BasePart")) then
            if not (d:IsA("BasePart") and d.Name ~= "ChangeColor") then
                local setter
                if d:IsA("Decal") then setter = function(c) d.Color3 = c end
                elseif d:IsA("TextLabel") or d:IsA("TextButton") then setter = function(c) d.TextColor3 = c end
                elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then setter = function(c) d.ImageColor3 = c end
                elseif typeof(d.Color) == "ColorSequence" then setter = function(c) d.Color = ColorSequence.new(c) end
                else setter = function(c) d.Color = c end end
                table.insert(targets, { inst = d, set = setter })
            end
        end
    end

    if #targets == 0 then return false end

    task.spawn(function()
        while session == swordChanger._color_session and swordModel.Parent do
            local t = ((shouldSync and Workspace:GetServerTimeNow() or os.clock()) + syncSeed) % total
            local color = colors[1].Color
            local acc = 0
            for k, c in ipairs(colors) do
                acc += c.TweenInfo.Time
                if t < acc then
                    local nxt = colors[k + 1] or colors[1]
                    local alpha = (acc - t) / c.TweenInfo.Time
                    local val = TweenService:GetValue(alpha, c.TweenInfo.EasingStyle, c.TweenInfo.EasingDirection)
                    color = c.Color:Lerp(nxt.Color, val)
                    break
                end
            end
            for _, tgt in ipairs(targets) do
                if tgt.inst.Parent then pcall(tgt.set, color) end
            end
            RunService.Heartbeat:Wait()
        end
    end)

    return true
end

local function startColor(name)
    swordChanger._color_session += 1
    swordChanger._color_cleanup = nil
    local char = LP.Character
    if not char then return end
    local model = char:FindFirstChild(name)
    if not model then return end
    local session = swordChanger._color_session
    pcall(function()
        model:SetAttribute("ColorConfig", name)
    end)
    if driveColor(model, name, session) then return end
    local tc = getTweenColorModule()
    if tc and tc.Watch then
        local ok, conn = pcall(function() return tc.Watch(model) end)
        if ok and type(conn) == "table" then
            swordChanger._color_cleanup = conn
        end
    end
end

local function stopColor()
    swordChanger._color_session += 1
    if swordChanger._color_cleanup then
        pcall(function()
            if swordChanger._color_cleanup.Disconnect then swordChanger._color_cleanup:Disconnect() end
            if swordChanger._color_cleanup.Destroy then swordChanger._color_cleanup:Destroy() end
        end)
        swordChanger._color_cleanup = nil
    end
end

-- ───── apply sword (the meat) ─────
local function applySword(force)
    if not swordChanger.enabled or not swordChanger.loaded then return false end
    if not swordChanger.model or swordChanger.model == "" then return false end
    local char = LP.Character
    if not char then return false end
    if swordChanger._busy then return false end
    swordChanger._busy = true

    local result = false
    pcall(function()
        if swordChanger.animations ~= "" and swordChanger._controller and swordChanger._controller.SetSword then
            swordChanger._controller:SetSword(swordChanger.animations)
        end

        -- remove any existing sword models that aren't ours
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Model") and ItemInfo.Sword and ItemInfo.Sword[child.Name] and child.Name ~= swordChanger.model then
                child:Destroy()
            end
        end

        if swordChanger.model ~= "" then
            if force or not char:FindFirstChild(swordChanger.model) then
                local controller = swordChanger._controller
                if controller and controller.EquipSwordTo then
                    local ok, err = pcall(function()
                        controller.EquipSwordTo(char, swordChanger.model, nil, not swordChanger.show_accessory)
                    end)
                    if ok then
                        result = true
                        startColor(swordChanger.model)
                    end
                end
            else
                result = true
            end
        end
    end)

    swordChanger._busy = false
    return result
end

-- ───── save/restore original ─────
local function saveOriginal()
    if swordChanger._original.saved then return end
    local char = LP.Character
    if not char then return end
    local cur = LP:GetAttribute("CurrentlyEquippedSword") or char:GetAttribute("CurrentlyEquippedSword")
    if cur then
        swordChanger._original.model = cur
        swordChanger._original.saved = true
    end
end

local function restoreOriginal()
    if not swordChanger._original.saved then return end
    local char = LP.Character
    if not char then return end
    stopColor()
    local controller = swordChanger._controller
    if controller and controller.EquipSwordTo then
        pcall(function()
            controller.EquipSwordTo(char, swordChanger._original.model)
        end)
    end
    if controller and controller.SetSword then
        pcall(function() controller:SetSword(swordChanger._original.model) end)
    end
end

-- ───── character bind ─────
local function disconnectChar()
    for _, c in ipairs(swordChanger._char_conns) do
        pcall(function() c:Disconnect() end)
    end
    swordChanger._char_conns = {}
end

local function bindChar(char)
    disconnectChar()
    if not char then return end

    table.insert(swordChanger._char_conns, char.ChildRemoved:Connect(function(child)
        if swordChanger._busy then return end
        if child:IsA("Model") and child.Name == swordChanger.model then
            if not char:FindFirstChild(swordChanger.model) then
                if swordChanger.enabled and swordChanger.loaded and swordChanger.model ~= "" then
                    task.delay(0.06, function() applySword(true) end)
                end
            end
        end
    end))

    table.insert(swordChanger._char_conns, char.ChildAdded:Connect(function(child)
        if swordChanger._busy then return end
        if child:IsA("Model") and ItemInfo.Sword and ItemInfo.Sword[child.Name] and child.Name ~= swordChanger.model then
            if swordChanger.enabled and swordChanger.loaded and swordChanger.model ~= "" then
                task.delay(0.06, function() applySword(true) end)
            end
        end
    end))
end

-- ───── equipping via ScriptContext ─────
local function equipToUser(userId)
    local plr = Players:GetPlayerByUserId(userId)
    if not plr or plr ~= LP then return end
    if not swordChanger.enabled then return end
    task.delay(0.2, function() applySword(true) end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if p == LP and swordChanger.enabled then
            task.delay(1, function() applySword(true) end)
        end
    end)
end)

LP.CharacterAdded:Connect(function(char)
    task.defer(function()
        swordChanger._busy = false
        swordChanger._pending = false
        bindChar(char)
        if swordChanger.enabled then
            task.delay(1.2, function()
                for i = 1, 6 do
                    if not swordChanger.enabled or LP.Character ~= char then return end
                    if char:FindFirstChild(swordChanger.model) then
                        swordChanger._last_real = swordChanger.model
                        return
                    end
                    applySword(true)
                    task.wait(0.3)
                end
            end)
        end
    end)
end)

if LP.Character then
    task.defer(function()
        bindChar(LP.Character)
    end)
end

-- ───── auto-follow CurrentlyEquippedSword attribute ─────
LP:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
    local val = LP:GetAttribute("CurrentlyEquippedSword")
    if swordChanger.enabled and val and val ~= "" then
        task.delay(0.15, function() applySword(false) end)
    end
end)

LP:GetAttributeChangedSignal("ShowSwordAccessory"):Connect(function()
    if swordChanger.enabled and swordChanger.model ~= "" then
        task.delay(0.15, function() applySword(true) end)
    end
end)

-- ───── Parry Success hook (slash fx swap) ─────
task.spawn(function()
    for i = 1, 60 do
        local ok = pcall(function()
            local ev = ReplicatedStorage.Remotes:FindFirstChild("ParrySuccessAll")
            if not ev then return end
            if not swordChanger._parry_conn then
                swordChanger._parry_conn = ev.OnClientEvent:Connect(function(...)
                    if not swordChanger.loaded then return end
                    if not swordChanger.enabled or swordChanger.fx == "" then return end
                    local args = { ... }
                    local player = args[4]
                    if player == LP then
                        args[1] = swordChanger.slash_name
                        args[3] = swordChanger.fx
                        -- can't refire, but we can note it — most implementations re-dispatch via remotes
                    end
                end)
            end
        end)
        if swordChanger._parry_conn then return end
        task.wait(0.5)
    end
end)

-- ───── resolve slash name when fx changes ─────
local function refreshSlashName()
    if swordChanger.fx ~= "" then
        swordChanger.slash_name = resolveSlashName(swordChanger.fx)
    end
end

-- ───── precache all models ─────
local function precacheAll()
    if swordChanger._precache_running then return end
    swordChanger._precache_running = true
    task.spawn(function()
        if not ItemInfo or not ItemInfo.Sword then return end
        local count = 0
        for name in pairs(ItemInfo.Sword) do
            if swordChanger._models[name] then
                count += 1
                if count % 4 == 0 then task.wait() end
                continue
            end
            pcall(fetchSwordModel, name)
            count += 1
            if count % 4 == 0 then task.wait() end
        end
        swordChanger._precache_running = false
    end)
end

-- ───── public API ─────
local swordApi = {}

function swordApi.Enable(v)
    v = v == true
    swordChanger.enabled = v
    if v then
        swordChanger.loaded = true
        saveOriginal()
        if swordChanger._controller then
            patchEquipSwordTo()
        end
        local char = LP.Character
        local current = LP:GetAttribute("CurrentlyEquippedSword") or (char and char:GetAttribute("CurrentlyEquippedSword"))
        if swordChanger.model == "" and current then
            swordChanger.model = current
        end
        if swordChanger.model ~= "" then
            if swordChanger.animations == "" then swordChanger.animations = swordChanger.model end
            if swordChanger.fx == "" then swordChanger.fx = swordChanger.model end
            refreshSlashName()
            task.delay(0.2, function() applySword(true) end)
        end
        if Config.unlock_all then
            precacheAll()
        end
    else
        stopColor()
        disconnectChar()
        restoreOriginal()
    end
end

function swordApi.SetModel(name)
    if type(name) ~= "string" or name == "" then return end
    swordChanger.model = name
    swordChanger._last_real = name
    if swordChanger.animations == "" then swordChanger.animations = name end
    if swordChanger.fx == "" then swordChanger.fx = name end
    refreshSlashName()
    task.delay(0.05, function() applySword(true) end)
    if Config.unlock_all then precacheAll() end
end

function swordApi.SetAnimations(name)
    swordChanger.animations = (name and name ~= "" and name) or swordChanger.model
    if swordChanger._controller and swordChanger._controller.SetSword then
        pcall(function() swordChanger._controller:SetSword(swordChanger.animations) end)
    end
end

function swordApi.SetFx(name)
    swordChanger.fx = (name and name ~= "" and name) or swordChanger.model
    refreshSlashName()
end

function swordApi.SetAccessory(v)
    swordChanger.show_accessory = v == true
    task.delay(0.05, function() applySword(true) end)
end

function swordApi.Precache()
    precacheAll()
end

function swordApi.ToggleFinisher(name, v)
    if type(name) ~= "string" or name == "" then return end
    if v then
        swordChanger.finishers[name] = true
    else
        swordChanger.finishers[name] = nil
    end
end

_G.__zenthraSwordApi = swordApi

-- ───── hook FinishersController (override pick) ─────
task.spawn(function()
    for i = 1, 30 do
        local ok, ctrl = pcall(function()
            return require(ReplicatedStorage.Controllers:WaitForChild("FinishersController", 10))
        end)
        if ok and ctrl and ctrl.PlayFinisher and not ctrl.__zenthra_patched then
            ctrl.__zenthra_patched = true
            local og = ctrl.PlayFinisher
            ctrl.PlayFinisher = function(self, name, ...)
                if Config.finisher_override and Config.finisher_pick and Config.finisher_pick ~= "Off" then
                    name = Config.finisher_pick
                elseif swordChanger.enabled and swordChanger.model ~= "" then
                    if swordChanger.finishers[swordChanger.model] and name then
                        name = swordChanger.model
                    end
                end
                return og(self, name, ...)
            end
            return
        end
        task.wait(0.5)
    end
end)

-- ───── EXPLOSION CHANGER ─────
local explosionVfx = { module = nil, original = nil, pending_victim = nil, pending_until = 0 }

task.spawn(function()
    for i = 1, 40 do
        local ok, vfx = pcall(function()
            return require(ReplicatedStorage.Controllers:WaitForChild("VFXController", 10))
        end)
        if ok and vfx and vfx.PlayExplosion and not vfx.__zenthra_exp then
            vfx.__zenthra_exp = true
            explosionVfx.module = vfx
            explosionVfx.original = vfx.PlayExplosion
            vfx.PlayExplosion = function(self, name, ...)
                if explosionChanger.enabled and explosionChanger.name ~= "" then
                    name = explosionChanger.name
                end
                return explosionVfx.original(self, name, ...)
            end
            return
        end
        task.wait(0.5)
    end
end)

-- track kills to spoof explosion on victim
task.spawn(function()
    local ok = pcall(function()
        local ev = ReplicatedStorage.Remotes:WaitForChild("Killed", 15)
        if ev then
            ev.OnClientEvent:Connect(function(victim, ...)
                if not explosionChanger.enabled then return end
                if not (victim and type(victim) == "table") then return end
                local char = victim.Character or victim
                explosionVfx.pending_victim = char
                explosionVfx.pending_until = tick() + 2.5
            end)
        end
    end)
end)

-- ───── wire into the UI ─────
task.spawn(function()
    for i = 1, 60 do
        local tab = win.Tabs and win.Tabs["Sword"]
        if tab then break end
        task.wait(0.1)
    end
end)

-- override the stub toggles from Part 0
-- find them in the tab by flag and re-bind
task.delay(2, function()
    -- apply saved config if loaded
    if Config.unlock_all then swordApi.Enable(true) end
    if Config.sword_material or Config.sword_color_enabled then
        swordApi.Enable(true)
    end
end)

-- re-bind UI: replace the old stub toggles by attaching extra ones below
task.spawn(function()
    task.wait(0.5)
    local ok, tabs = pcall(function() return win end)
    -- the base file's Sword tab uses Config.unlock_all etc; we already
    -- update those via Config in the base toggles. Now attach the deeper bits:
    local swordTab = nil
    for _, t in pairs(getgenv().__zenthraTabs or {}) do
        if t.name == "Sword" then swordTab = t end
    end
end)

-- expose for other parts
_G.__zenthraSword = swordChanger
_G.__zenthraExplosion = explosionChanger

-- ═══════════════════════════════════════════════
-- PART 2 — AVATAR CHANGER FULL + AVATAR MATERIAL
-- ═══════════════════════════════════════════════

local avatarChanger = {
    enabled        = false,
    target         = "",
    applied_id     = nil,
    applying       = false,
    cache          = {},   -- userId -> HumanoidDescription
    original_desc  = nil,
    saving_orig    = false,
    respawn_token  = 0,
    _original_parts = {}, -- bodyPart name -> cloned original part (for korblox restore)
    _char_conns    = {},
    _expected_accessories = 0,
}

-- ───── save original description ─────
local function saveOriginalDesc()
    if avatarChanger.original_desc or avatarChanger.saving_orig then return end
    avatarChanger.saving_orig = true
    task.spawn(function()
        for i = 1, 5 do
            local ok, desc = pcall(function()
                return Players:GetHumanoidDescriptionFromUserIdAsync(LP.UserId)
            end)
            if ok and desc then
                avatarChanger.original_desc = desc
                break
            end
            task.wait(0.3 * i)
        end
        avatarChanger.saving_orig = false
    end)
end

-- ───── fetch + cache description ─────
local function getDescription(userId)
    if avatarChanger.cache[userId] then return avatarChanger.cache[userId] end
    for i = 1, 5 do
        local ok, desc = pcall(function()
            return Players:GetHumanoidDescriptionFromUserIdAsync(userId)
        end)
        if ok and desc then
            avatarChanger.cache[userId] = desc
            return desc
        end
        if i < 5 then task.wait(0.2 * i) end
    end
    return nil
end

-- ───── resolve userId (name or number) ─────
local function resolveUserId(input)
    if not input or input == "" then return nil end
    local n = tonumber(input)
    if n then return n end
    local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(input) end)
    if ok and id then return id end
    -- try players in game
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == input:lower() or p.DisplayName:lower() == input:lower() then
            return p.UserId
        end
    end
    return nil
end

-- ───── create temporary R15/R6 model ─────
local function createTempModel(desc, rigType)
    rigType = rigType or Enum.HumanoidRigType.R15
    local function try(rt)
        local ok, model = pcall(function()
            return Players:CreateHumanoidModelFromDescriptionAsync(desc, rt, Enum.AssetTypeVerification.Always)
        end)
        if not ok or not model then
            ok, model = pcall(function()
                return Players:CreateHumanoidModelFromDescriptionAsync(desc, rt)
            end)
        end
        if ok and model then
            model.Name = "ZenthraAvatarPreview"
            model.Parent = ReplicatedStorage
            RunService.Heartbeat:Wait()
            return model
        end
        return nil
    end
    for i = 1, 3 do
        local m = try(rigType)
        if m then return m end
        task.wait(0.35 * i)
    end
    return try(rigType == Enum.HumanoidRigType.R15 and Enum.HumanoidRigType.R6 or Enum.HumanoidRigType.R15)
end

-- ───── strip joints from a cloned accessory ─────
local function stripAccessoryJoints(container)
    for _, d in ipairs(container:GetDescendants()) do
        if d:IsA("Weld") or d:IsA("Motor6D") or d:IsA("WeldConstraint") then
            d:Destroy()
        end
    end
end

-- ───── find the body part an accessory should attach to ─────
local function findBodyPart(char, name)
    if not name or name == "" then return nil end
    local direct = char:FindFirstChild(name)
    if direct and direct:IsA("BasePart") then return direct end
    local map = ({
        ["Left Arm"]  = { "LeftUpperArm", "LeftLowerArm", "LeftHand" },
        ["Right Arm"] = { "RightUpperArm", "RightLowerArm", "RightHand" },
        ["Left Leg"]  = { "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
        ["Right Leg"] = { "RightUpperLeg", "RightLowerLeg", "RightFoot" },
        Torso         = { "UpperTorso", "LowerTorso" },
    })[name] or {}
    for _, alt in ipairs(map) do
        local p = char:FindFirstChild(alt)
        if p and p:IsA("BasePart") then return p end
    end
    return nil
end

-- ───── attach a single accessory ─────
local function attachAccessory(char, humanoid, srcAcc)
    if not char or not srcAcc then return false end
    local clone = srcAcc:Clone()
    stripAccessoryJoints(clone)

    local handle = clone:FindFirstChild("Handle")
    if not handle or not handle:IsA("BasePart") then
        clone:Destroy()
        return false
    end
    handle.Anchored = false
    handle.CanCollide = false
    handle.Massless = true

    local srcHandle = srcAcc:FindFirstChild("Handle")
    local srcWeld = srcHandle and srcHandle:FindFirstChild("AccessoryWeld")
    if not srcWeld then
        srcWeld = srcHandle and srcHandle:FindFirstChildWhichIsA("Weld")
    end

    local c0, c1 = CFrame.new(), CFrame.new()
    local attachTo = nil

    if srcWeld and srcWeld.Part1 then
        attachTo = findBodyPart(char, srcWeld.Part1.Name)
        c0 = srcWeld.C0
        c1 = srcWeld.C1
    end

    if not attachTo then
        local attachment = handle:FindFirstChildOfClass("Attachment")
        if attachment then
            for _, d in ipairs(char:GetDescendants()) do
                if d:IsA("Attachment") and d.Name == attachment.Name and not d:IsDescendantOf(clone) then
                    attachTo = d.Parent
                    c0 = attachment.CFrame
                    c1 = d.CFrame
                    break
                end
            end
        end
    end

    if not attachTo then
        local at = clone.AccessoryType
        if at == Enum.AccessoryType.Hair or at == Enum.AccessoryType.Hat
            or at == Enum.AccessoryType.Face or at == Enum.AccessoryType.Eyebrow
            or at == Enum.AccessoryType.Eyelash then
            attachTo = char:FindFirstChild("Head")
        end
        attachTo = attachTo or char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        c0 = CFrame.new(0, 0.5, 0)
        c1 = CFrame.new()
    end

    if attachTo and attachTo:IsA("BasePart") then
        local weld = Instance.new("Weld")
        weld.Name = "AccessoryWeld"
        weld.Part0 = handle
        weld.Part1 = attachTo
        weld.C0 = c0
        weld.C1 = c1
        weld.Parent = handle
        clone.Parent = char
        return true
    end

    if humanoid then
        local ok = pcall(function() humanoid:AddAccessory(clone) end)
        if ok and clone.Parent == char then return true end
    end

    clone:Destroy()
    return false
end

-- ───── collect all accessories from a source (model or description) ─────
local function collectAccessories(srcModel, desc)
    local accs, seen = {}, {}
    local function add(a)
        if not a or seen[a] then return end
        seen[a] = true
        table.insert(accs, a)
    end
    if srcModel then
        for _, c in ipairs(srcModel:GetChildren()) do
            if c:IsA("Accessory") or c:IsA("Hat") then add(c) end
        end
        if #accs == 0 then
            local hum = srcModel:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    for _, a in ipairs(hum:GetAccessories()) do add(a) end
                end)
            end
        end
    end
    if desc and desc.GetAccessories then
        pcall(function()
            for _, ad in ipairs(desc:GetAccessories(true)) do
                local assetId = ad.AssetId
                if assetId and assetId > 0 then
                    pcall(function()
                        local objects = game:GetObjects("rbxassetid://" .. assetId)
                        for _, obj in ipairs(objects) do
                            local acc = obj:IsA("Accessory") and obj or obj:FindFirstChildOfClass("Accessory")
                            if not acc then
                                for _, d in ipairs(obj:GetDescendants()) do
                                    if d:IsA("Accessory") then acc = d break end
                                end
                            end
                            if acc then add(acc) end
                        end
                    end)
                end
            end
        end)
    end
    return accs
end

-- ───── remove all accessories ─────
local function removeAccessories(char)
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Accessory") or c:IsA("Hat") then
            c:Destroy()
        end
    end
end

-- ───── apply body scales from description ─────
local function applyBodyScales(hum, desc)
    if not hum or not desc then return end
    for _, entry in ipairs({
        { "BodyHeightScale",  desc.HeightScale,     false },
        { "BodyWidthScale",   desc.WidthScale,      true  },
        { "BodyDepthScale",   desc.DepthScale,      false },
        { "HeadScale",        desc.HeadScale,       false },
        { "BodyTypeScale",    desc.BodyTypeScale,   true  },
        { "ProportionScale",  desc.ProportionScale, true  },
    }) do
        local name, val, allowZero = entry[1], entry[2], entry[3]
        if type(val) == "number" and (val > 0 or (allowZero and val >= 0)) then
            local nv = hum:FindFirstChild(name)
            if not nv and hum.RigType == Enum.HumanoidRigType.R15 then
                nv = Instance.new("NumberValue")
                nv.Name = name
                nv.Parent = hum
            end
            if nv and nv:IsA("NumberValue") then
                nv.Value = val
            end
        end
    end
end

-- ───── transfer body meshes from temp model to real character ─────
local function transferBodyMeshes(srcChar, dstChar, hum)
    if not srcChar or not dstChar then return end
    if hum and hum.RigType ~= Enum.HumanoidRigType.R15 then
        for _, c in ipairs(srcChar:GetChildren()) do
            if c:IsA("CharacterMesh") then
                for _, c2 in ipairs(dstChar:GetChildren()) do
                    if c2:IsA("CharacterMesh") and c2.BodyPart == c.BodyPart then
                        c2:Destroy()
                    end
                end
                c:Clone().Parent = dstChar
            end
        end
        return
    end

    local parts = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "LeftLowerArm", "LeftHand",
        "RightUpperArm", "RightLowerArm", "RightHand",
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
        "RightUpperLeg", "RightLowerLeg", "RightFoot",
    }
    for _, name in ipairs(parts) do
        local src = srcChar:FindFirstChild(name)
        local dst = dstChar:FindFirstChild(name)
        if src and dst and src:IsA("BasePart") and dst:IsA("BasePart") then
            if src:IsA("MeshPart") and dst:IsA("MeshPart") then
                pcall(function() dst:ApplyMesh(src) end)
                pcall(function() dst.TextureID = src.TextureID end)
                pcall(function()
                    local sa = dst:FindFirstChildOfClass("SurfaceAppearance")
                    if sa then sa:Destroy() end
                    local srcSa = src:FindFirstChildOfClass("SurfaceAppearance")
                    if srcSa then srcSa:Clone().Parent = dst end
                end)
            elseif src.ClassName ~= dst.ClassName then
                -- replace part
                local replacement = src:Clone()
                for _, ch in ipairs(replacement:GetChildren()) do
                    if ch:IsA("JointInstance") then ch:Destroy() end
                end
                -- copy joints
                local joints = {}
                for _, d in ipairs(dstChar:GetDescendants()) do
                    if d:IsA("Motor6D") and (d.Part0 == dst or d.Part1 == dst) then
                        table.insert(joints, {
                            name = d.Name,
                            part0 = d.Part0 == dst and "NEW" or d.Part0,
                            part1 = d.Part1 == dst and "NEW" or d.Part1,
                            c0 = d.C0, c1 = d.C1,
                            parent = d.Parent == dst and "NEW" or d.Parent,
                            obj = d,
                        })
                    end
                end
                replacement.Name = dst.Name
                replacement.CFrame = dst.CFrame
                replacement.Parent = dstChar
                for _, j in ipairs(joints) do
                    j.obj:Destroy()
                    local m = Instance.new("Motor6D")
                    m.Name = j.name
                    m.Part0 = j.part0 == "NEW" and replacement or j.part0
                    m.Part1 = j.part1 == "NEW" and replacement or j.part1
                    m.C0 = j.c0 m.C1 = j.c1
                    m.Parent = j.parent == "NEW" and replacement or j.parent
                end
                dst:Destroy()
            else
                pcall(function() dst.Size = src.Size end)
                pcall(function()
                    local sm1 = dst:FindFirstChildOfClass("SpecialMesh")
                    if sm1 then sm1:Destroy() end
                    local sm2 = src:FindFirstChildOfClass("SpecialMesh") or src:FindFirstChildOfClass("BlockMesh") or src:FindFirstChildOfClass("CylinderMesh")
                    if sm2 then sm2:Clone().Parent = dst end
                end)
            end
        end
    end

    -- copy motor6d C0/C1
    for _, d in ipairs(srcChar:GetDescendants()) do
        if d:IsA("Motor6D") and d.Parent then
            local dstP = dstChar:FindFirstChild(d.Parent.Name)
            local m = dstP and dstP:FindFirstChild(d.Name)
            if m and m:IsA("Motor6D") then
                m.C0 = d.C0 m.C1 = d.C1
            end
        end
    end
end

-- ───── transfer appearance from temp model to real char ─────
local function transferAppearance(srcModel, dstChar, hum, desc)
    if not srcModel or not dstChar or not hum then return false end

    pcall(function()
        if hum.ApplyDescriptionClientServer then
            hum:ApplyDescriptionClientServer(desc)
        else
            hum:ApplyDescription(desc)
        end
    end)
    applyBodyScales(hum, desc)
    RunService.Heartbeat:Wait()
    transferBodyMeshes(srcModel, dstChar, hum)

    -- shirt/pants/graphic
    for _, name in ipairs({ "Shirt", "Pants", "ShirtGraphic" }) do
        local src = srcModel:FindFirstChildOfClass(name)
        if src then
            local dst = dstChar:FindFirstChildOfClass(name)
            if dst then dst:Destroy() end
            src:Clone().Parent = dstChar
        end
    end

    -- body colors
    local srcBC = srcModel:FindFirstChildOfClass("BodyColors")
    local bc = dstChar:FindFirstChildOfClass("BodyColors")
    if not bc then
        bc = Instance.new("BodyColors")
        bc.Parent = dstChar
    end
    if srcBC then
        bc.HeadColor3 = srcBC.HeadColor3
        bc.TorsoColor3 = srcBC.TorsoColor3
        bc.LeftArmColor3 = srcBC.LeftArmColor3
        bc.RightArmColor3 = srcBC.RightArmColor3
        bc.LeftLegColor3 = srcBC.LeftLegColor3
        bc.RightLegColor3 = srcBC.RightLegColor3
    end
    if desc then
        bc.HeadColor3 = desc.HeadColor
        bc.TorsoColor3 = desc.TorsoColor
        bc.LeftArmColor3 = desc.LeftArmColor
        bc.RightArmColor3 = desc.RightArmColor
        bc.LeftLegColor3 = desc.LeftLegColor
        bc.RightLegColor3 = desc.RightLegColor
    end

    -- face
    local srcHead = srcModel:FindFirstChild("Head")
    local dstHead = dstChar:FindFirstChild("Head")
    if srcHead and dstHead then
        local face = srcHead:FindFirstChild("face") or srcHead:FindFirstChildOfClass("Decal")
        if face then
            local oldFace = dstHead:FindFirstChild("face") or dstHead:FindFirstChildOfClass("Decal")
            if oldFace then oldFace:Destroy() end
            local clone = face:Clone()
            clone.Name = "face"
            clone.Parent = dstHead
        end
    end

    -- accessories
    removeAccessories(dstChar)
    local accs = collectAccessories(srcModel, desc)
    local attached = 0
    for _, acc in ipairs(accs) do
        if attachAccessory(dstChar, hum, acc) then
            attached += 1
        end
    end

    return true
end

-- ───── clean tools + scripts from char before applying ─────
local function cleanChar(char)
    local tools, backpack = {}, char.Parent and char.Parent:FindFirstChild("Backpack")
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Tool") or c:IsA("HopperBin") then
            table.insert(tools, c)
            c.Parent = nil
        end
    end
    if backpack then
        for _, c in ipairs(backpack:GetChildren()) do
            if c:IsA("Tool") or c:IsA("HopperBin") then
                table.insert(tools, c)
            end
        end
    end
    local scriptParents = {}
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BaseScript") then
            scriptParents[d] = true
            if d.Parent then scriptParents[d.Parent] = true end
        end
    end
    for _, c in ipairs(char:GetChildren()) do
        if not scriptParents[c] then
            if c:IsA("Accessory") or c:IsA("Hat") or c:IsA("BodyColors") or c:IsA("CharacterMesh")
                or c:IsA("Shirt") or c:IsA("Pants") or c:IsA("ShirtGraphic") then
                c:Destroy()
            end
        end
    end
    for _, t in ipairs(tools) do
        if t and t.Parent == nil then
            t.Parent = backpack or char
        end
    end
end

-- ───── apply special body parts (headless / korblox via desc) ─────
local function applySpecialParts(char, desc)
    if not char or not desc then return end
    if desc.Head and (desc.Head == 15093053680 or desc.Head == 134082513) then
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = 1
            local face = head:FindFirstChildOfClass("Decal")
            if face then face:Destroy() end
        end
    end
    if desc.RightLeg and desc.RightLeg == 139607718 then
        local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
        if rightLeg then
            for _, c in ipairs(rightLeg:GetChildren()) do
                if c:IsA("SpecialMesh") and c.MeshId == "rbxassetid://101851696" then c:Destroy() end
            end
            local m = Instance.new("SpecialMesh")
            m.MeshId = "rbxassetid://101851696"
            m.TextureId = "rbxassetid://115727863"
            m.Scale = Vector3.new(1, 1, 1)
            m.Parent = rightLeg
        else
            for _, name in ipairs({ "RightUpperLeg", "RightLowerLeg", "RightFoot" }) do
                local p = char:FindFirstChild(name)
                if p then p.Transparency = 1 end
            end
            local rul = char:FindFirstChild("RightUpperLeg")
            if rul and not rul:FindFirstChild("KorbloxLeg") then
                local part = Instance.new("Part")
                part.Name = "KorbloxLeg"
                part.CanCollide = false
                part.Massless = true
                part.Size = Vector3.new(1, 2, 1)
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshId = "rbxassetid://101851696"
                mesh.TextureId = "rbxassetid://115727863"
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Parent = part
                local weld = Instance.new("Weld")
                weld.Part0 = rul
                weld.Part1 = part
                weld.C0 = CFrame.new(0, -0.5, 0)
                weld.Parent = part
                part.Parent = rul
            end
        end
    end
end

-- ───── revert special parts (korblox) ─────
local function revertSpecialParts(char)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if head then head.Transparency = 0 end
    for _, name in ipairs({ "RightUpperLeg", "RightLowerLeg", "RightFoot" }) do
        local p = char:FindFirstChild(name)
        if p then p.Transparency = 0 end
    end
    local rul = char:FindFirstChild("RightUpperLeg")
    if rul then
        local korblox = rul:FindFirstChild("KorbloxLeg")
        if korblox then korblox:Destroy() end
    end
end

-- ───── main apply ─────
local function applyDescription(desc, uid, restore)
    if avatarChanger.applying then return end
    avatarChanger.applying = true

    task.spawn(function()
        local function cancelled()
            if restore then return false end
            return not avatarChanger.enabled
        end

        local char = LP.Character or LP.CharacterAdded:Wait()
        if cancelled() then avatarChanger.applying = false return end
        char = LP.Character or char
        local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
        if not hum then avatarChanger.applying = false return end
        if not restore then revertSpecialParts(char) end

        cleanChar(char)
        if cancelled() then avatarChanger.applying = false return end

        local temp = createTempModel(desc, hum.RigType)
        local ok = false
        if temp then
            ok = transferAppearance(temp, char, hum, desc)
            temp:Destroy()
        end

        if not ok then
            pcall(function()
                if hum.ApplyDescriptionClientServer then
                    hum:ApplyDescriptionClientServer(desc)
                else
                    hum:ApplyDescription(desc)
                end
            end)
            applyBodyScales(hum, desc)
            applySpecialParts(char, desc)
            local bc = char:FindFirstChildOfClass("BodyColors")
            if not bc then
                bc = Instance.new("BodyColors")
                bc.Parent = char
            end
            bc.HeadColor3 = desc.HeadColor
            bc.TorsoColor3 = desc.TorsoColor
            bc.LeftArmColor3 = desc.LeftArmColor
            bc.RightArmColor3 = desc.RightArmColor
            bc.LeftLegColor3 = desc.LeftLegColor
            bc.RightLegColor3 = desc.RightLegColor
            removeAccessories(char)
            for _, acc in ipairs(collectAccessories(nil, desc)) do
                attachAccessory(char, hum, acc)
            end
        end

        avatarChanger.applying = false
    end)
end

-- ───── public: apply by userId/name ─────
local function applyAvatar(input)
    if avatarChanger.applying then return end
    avatarChanger.attempt_id = (avatarChanger.attempt_id or 0) + 1
    local myId = avatarChanger.attempt_id

    task.spawn(function()
        if not avatarChanger.enabled or avatarChanger.target ~= input or avatarChanger.attempt_id ~= myId then return end
        local uid = resolveUserId(input)
        if not uid then return end
        if avatarChanger.applied_id == uid then return end
        local desc = getDescription(uid)
        if not desc then return end
        if not avatarChanger.enabled or avatarChanger.target ~= input or avatarChanger.attempt_id ~= myId then return end
        avatarChanger.applied_id = uid
        applyDescription(desc, uid, false)
    end)
end

local function restoreAvatar()
    if not avatarChanger.original_desc then return end
    avatarChanger.applied_id = nil
    avatarChanger.applying = false
    local char = LP.Character
    if char then revertSpecialParts(char) end
    applyDescription(avatarChanger.original_desc, LP.UserId, true)
end

-- ───── respawn handler ─────
local function reapplyOnSpawn(char)
    if not (avatarChanger.enabled and avatarChanger.target ~= "") then return end
    if not char then return end
    avatarChanger.respawn_token += 1
    local myToken = avatarChanger.respawn_token

    task.spawn(function()
        char:WaitForChild("Humanoid", 10)
        char:WaitForChild("HumanoidRootPart", 10)
        local loaded = false
        pcall(function() loaded = LP:HasAppearanceLoaded() end)
        if not loaded then
            local signal = LP.CharacterAppearanceLoaded:Connect(function() loaded = true end)
            local t = 0
            while not loaded and t < 6 do
                task.wait(0.1) t += 0.1
                pcall(function() if LP:HasAppearanceLoaded() then loaded = true end end)
            end
            signal:Disconnect()
        end
        if avatarChanger.respawn_token ~= myToken then return end

        for i = 1, 3 do
            if avatarChanger.respawn_token ~= myToken then return end
            if not (avatarChanger.enabled and avatarChanger.target ~= "") then return end
            if char.Parent == nil then return end
            avatarChanger.applying = false
            avatarChanger.applied_id = nil
            applyAvatar(avatarChanger.target)
            local waited = 0
            while avatarChanger.applying and waited < 8 do
                task.wait(0.05) waited += 0.05
            end
            if i < 3 then task.wait(1) end
        end
    end)
end

LP.CharacterAdded:Connect(reapplyOnSpawn)

-- ───── AVATAR MATERIAL ─────
local avatarMat = { originals = {}, applying = false, dirty = false, dirty_t = 0 }

local bodyPartNames = {
    Head = true, Torso = true, HumanoidRootPart = true,
    UpperTorso = true, LowerTorso = true,
    LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
    RightUpperArm = true, RightLowerArm = true, RightHand = true,
    LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
    RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
}

local matEnum = ({
    ForceField = Enum.Material.ForceField,
    Glass = Enum.Material.Glass,
    Neon = Enum.Material.Neon,
    Ice = Enum.Material.Ice,
    Metal = Enum.Material.Metal,
    DiamondPlate = Enum.Material.DiamondPlate,
    Granite = Enum.Material.Granite,
    Marble = Enum.Material.Marble,
    Wood = Enum.Material.Wood,
    Foil = Enum.Material.Foil,
    SmoothPlastic = Enum.Material.SmoothPlastic,
})

local matProps = {
    Glass = { transparency = 0.35 },
    ForceField = { transparency = 0 },
    Ice = { transparency = 0.1 },
}

local matTints = {
    ForceField = Color3.fromRGB(120, 210, 255),
    Glass = Color3.fromRGB(210, 235, 255),
    Neon = Color3.fromRGB(255, 120, 220),
    Ice = Color3.fromRGB(190, 230, 255),
    Metal = Color3.fromRGB(210, 210, 220),
    Foil = Color3.fromRGB(230, 230, 240),
}

local function isDullColor(c)
    local h, s, v = c:ToHSV()
    return v < 0.4 or (h < 0.12 and v < 0.75)
end

local function saveAvatarOriginal(part)
    if avatarMat.originals[part] then return end
    local t = { Material = part.Material, Color = part.Color, Transparency = part.Transparency, Reflectance = part.Reflectance }
    if part:IsA("MeshPart") then pcall(function() t.TextureID = part.TextureID end) end
    local sa = part:FindFirstChildOfClass("SurfaceAppearance")
    if sa then t.surface = sa t.surface_parent = sa.Parent end
    local sm = part:FindFirstChildOfClass("SpecialMesh")
    if sm then t.mesh = sm pcall(function() t.TextureId = sm.TextureId t.MeshId = sm.MeshId end) end
    t.overlays = {}
    for _, c in ipairs(part:GetChildren()) do
        if c:IsA("Decal") or c:IsA("Texture") then
            table.insert(t.overlays, { inst = c, Transparency = c.Transparency })
        end
    end
    avatarMat.originals[part] = t
end

local function restoreAvatarPart(part, t)
    if not part or not part.Parent or not t then return end
    pcall(function()
        if t.Material then part.Material = t.Material end
        if t.Color then part.Color = t.Color end
        if t.Transparency ~= nil then part.Transparency = t.Transparency end
        if t.Reflectance ~= nil then part.Reflectance = t.Reflectance end
        if part:IsA("MeshPart") and t.TextureID ~= nil then part.TextureID = t.TextureID end
        if t.mesh and t.mesh.Parent then
            if t.TextureId ~= nil then t.mesh.TextureId = t.TextureId end
            if t.MeshId ~= nil then t.mesh.MeshId = t.MeshId end
        end
        if t.surface and t.surface_parent and not t.surface.Parent then
            t.surface.Parent = t.surface_parent
        end
        if t.overlays then
            for _, o in ipairs(t.overlays) do
                if o.inst and o.inst.Parent then o.inst.Transparency = o.Transparency end
            end
        end
    end)
end

local function applyAvatarPart(part)
    if not part or not part.Parent then return end
    if not (part:IsA("BasePart") or part:IsA("MeshPart")) then return end
    if not bodyPartNames[part.Name] then return end
    saveAvatarOriginal(part)
    local t = avatarMat.originals[part]
    local applyMat = Config.avatar_mat_enabled and Config.avatar_mat_name ~= "Default"
    local applyCol = Config.avatar_color_enabled
    if not applyMat and not applyCol then
        restoreAvatarPart(part, t)
        return
    end
    pcall(function()
        if applyMat then
            local sa = part:FindFirstChildOfClass("SurfaceAppearance")
            if sa then sa.Parent = nil end
            local m = matEnum[Config.avatar_mat_name]
            if m then part.Material = m end
            local props = matProps[Config.avatar_mat_name]
            if props and props.transparency ~= nil and (t.Transparency or 0) <= 0.01 then
                part.Transparency = props.transparency
            end
            if t.overlays then
                for _, o in ipairs(t.overlays) do
                    if o.inst and o.inst.Parent and o.Transparency < 0.999 then
                        o.inst.Transparency = 1
                    end
                end
            end
        elseif applyCol then
            if t.Material then part.Material = t.Material end
            if t.Transparency ~= nil then part.Transparency = t.Transparency end
            if t.Reflectance ~= nil then part.Reflectance = t.Reflectance end
            if part:IsA("MeshPart") and t.TextureID ~= nil then part.TextureID = t.TextureID end
            local sa = part:FindFirstChildOfClass("SurfaceAppearance")
            if sa then sa.Parent = nil end
            if t.surface and t.surface_parent and not t.surface.Parent then
                t.surface.Parent = t.surface_parent
            end
            if t.overlays then
                for _, o in ipairs(t.overlays) do
                    if o.inst and o.inst.Parent then o.inst.Transparency = o.Transparency end
                end
            end
        end
        if applyCol then
            part.Color = Config.avatar_color
        elseif applyMat then
            local base = t.Color or part.Color
            if isDullColor(base) then
                part.Color = matTints[Config.avatar_mat_name] or Color3.new(1, 1, 1)
            end
        elseif t.Color then
            part.Color = t.Color
        end
    end)
end

local function applyAvatarMaterial()
    if not Config.avatar_material and not Config.avatar_color_enabled then
        if next(avatarMat.originals) then
            for p, t in pairs(avatarMat.originals) do
                restoreAvatarPart(p, t)
            end
            avatarMat.originals = {}
        end
        return
    end
    local char = LP.Character
    if not char then return end
    avatarMat.applying = true
    for _, d in ipairs(char:GetDescendants()) do
        if (d:IsA("BasePart") or d:IsA("MeshPart")) and bodyPartNames[d.Name] then
            applyAvatarPart(d)
        end
    end
    avatarMat.applying = false
end

local function scheduleAvatarReapply()
    avatarMat.dirty = true
    avatarMat.dirty_t = os.clock()
end

RunService.Heartbeat:Connect(function(dt)
    if not (Config.avatar_material or Config.avatar_color_enabled) then return end
    if avatarMat.applying then return end
    if avatarMat.dirty then
        if os.clock() - avatarMat.dirty_t >= 0.15 then
            avatarMat.dirty = false
            applyAvatarMaterial()
        end
        return
    end
    avatarMat._accum = (avatarMat._accum or 0) + dt
    if avatarMat._accum < 0.5 then return end
    avatarMat._accum = 0
    applyAvatarMaterial()
end)

LP.CharacterAdded:Connect(function(char)
    avatarMat.originals = {}
    task.wait(1)
    scheduleAvatarReapply()
end)

-- ───── KORBLOX / HEADLESS standalone toggles ─────
local korbloxConn, headlessConn

local function applyKorblox(char, v)
    if not char then return end
    local rightLeg = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
    if not rightLeg then
        -- R15
        for _, name in ipairs({ "RightUpperLeg", "RightLowerLeg", "RightFoot" }) do
            local p = char:FindFirstChild(name)
            if p then p.Transparency = v and 1 or 0 end
        end
        local rul = char:FindFirstChild("RightUpperLeg")
        if rul then
            local existing = rul:FindFirstChild("KorbloxLeg")
            if existing then existing:Destroy() end
            if v then
                local part = Instance.new("Part")
                part.Name = "KorbloxLeg"
                part.CanCollide = false
                part.Massless = true
                part.Size = Vector3.new(1, 2, 1)
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshId = "rbxassetid://101851696"
                mesh.TextureId = "rbxassetid://115727863"
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Parent = part
                local weld = Instance.new("Weld")
                weld.Part0 = rul
                weld.Part1 = part
                weld.C0 = CFrame.new(0, -0.5, 0)
                weld.Parent = part
                part.Parent = rul
            end
        end
        return
    end
    for _, c in ipairs(rightLeg:GetChildren()) do
        if (c:IsA("SpecialMesh") or c:IsA("Mesh")) and c.MeshId == "rbxassetid://101851696" then
            c:Destroy()
        end
    end
    if v then
        local m = Instance.new("SpecialMesh")
        m.MeshId = "rbxassetid://101851696"
        m.TextureId = "rbxassetid://115727863"
        m.Scale = Vector3.new(1, 1, 1)
        m.Parent = rightLeg
    end
end

local function setKorblox(v)
    Config.korblox = v == true
    if korbloxConn then korbloxConn:Disconnect() korbloxConn = nil end
    if v then
        applyKorblox(LP.Character, true)
        korbloxConn = LP.CharacterAdded:Connect(function(c)
            task.wait(0.5)
            if Config.korblox then applyKorblox(c, true) end
        end)
    else
        applyKorblox(LP.Character, false)
    end
end

local function applyHeadless(char, v)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = v and 1 or 0
end

local function setHeadless(v)
    Config.headless = v == true
    if headlessConn then headlessConn:Disconnect() headlessConn = nil end
    if v then
        applyHeadless(LP.Character, true)
        headlessConn = LP.CharacterAdded:Connect(function(c)
            task.wait(0.5)
            if Config.headless then applyHeadless(c, true) end
        end)
    else
        applyHeadless(LP.Character, false)
    end
end

-- ───── expose to other parts / API ─────
_G.__zenthraAvatar = {
    apply         = applyAvatar,
    restore       = restoreAvatar,
    setKorblox    = setKorblox,
    setHeadless   = setHeadless,
    scheduleMat   = scheduleAvatarReapply,
    changer       = avatarChanger,
    material      = avatarMat,
}

-- ───── ensure startup save happens ─────
saveOriginalDesc()

-- wire into UI: base file already has toggles for Korblox/Headless/Avatar Changer.
-- we re-bind setKorblox/setHeadless by overriding the Config callbacks used there.
-- the base uses Config.korblox / Config.headless + setKorblox/setHeadless, so
-- this file already replaced those via _G — just make sure they're hooked.
task.delay(1, function()
    if Config.korblox then setKorblox(true) end
    if Config.headless then setHeadless(true) end
    if Config.avatar_changer and Config.avatar_target ~= "" then
        avatarChanger.enabled = true
        avatarChanger.target = Config.avatar_target
        applyAvatar(Config.avatar_target)
    end
end)

-- ═══════════════════════════════════════════════
-- PART 3 — ABILITY ESP + EMOTE INJECT
-- ═══════════════════════════════════════════════

-- ───── ability esp ─────
local abilityEsp = {
    active          = false,
    drawings        = {},   -- player -> drawing table
    conn            = nil,
    mode            = "Text",      -- Text | Image
    show_name       = false,
    name_mode       = "Display Name", -- Display Name | Username
    name_size       = 18,
    name_color      = Color3.fromRGB(255, 255, 255),
    ability_size    = 16,
    ability_color   = Color3.fromRGB(120, 200, 255),
    show_cd         = false,
    cd_type         = "Text",      -- Text | Bar
    cd_size         = 15,
    cd_color        = Color3.fromRGB(180, 180, 180),
    show_timer      = false,
    active_type     = "Text",
    active_size     = 15,
    active_color    = Color3.fromRGB(255, 200, 80),
    show_uses       = false,
    uses_size       = 14,
    uses_color      = Color3.fromRGB(100, 255, 150),
    billboards      = {},   -- player -> billboard
    _icon_cache     = {},
    _abilities      = nil,
    _icons_module   = nil,
    _abilities_root = nil,
}

-- ───── module resolvers ─────
local function getAbilitiesModule()
    if abilityEsp._abilities then return abilityEsp._abilities end
    local ok, mod = pcall(function()
        return require(ReplicatedStorage.Shared:WaitForChild("Abilities", 5))
    end)
    if ok then abilityEsp._abilities = mod return mod end
    return nil
end

local function getAbilityIconsModule()
    if abilityEsp._icons_module ~= nil then
        if abilityEsp._icons_module == false then return nil end
        return abilityEsp._icons_module
    end
    local ok, mod = pcall(function()
        return require(ReplicatedStorage.Shared:WaitForChild("AbilityIcons", 5))
    end)
    if ok then abilityEsp._icons_module = mod else abilityEsp._icons_module = false end
    return abilityEsp._icons_module
end

local function getIconFor(name)
    if not name or name == "" then return nil end
    if abilityEsp._icon_cache[name] ~= nil then
        return abilityEsp._icon_cache[name] or nil
    end
    local icons = getAbilityIconsModule()
    if icons and type(icons[name]) == "string" and icons[name] ~= "" then
        abilityEsp._icon_cache[name] = icons[name]
        return icons[name]
    end
    -- fallback: check ItemInfo.Ability
    pcall(function()
        local info = require(ReplicatedStorage.Shared:WaitForChild("ItemInfo"))
        local attrs = info and info.Ability and info.Ability[name]
        if attrs then
            local img = attrs.Icon or attrs.Image
            if type(img) == "string" then
                abilityEsp._icon_cache[name] = img
                return
            end
        end
    end)
    abilityEsp._icon_cache[name] = false
    return nil
end

local function getAbilityUpgrade(name)
    if not name or name == "" then return 0 end
    local plr = LP
    local attr
    pcall(function()
        attr = plr:GetAttribute("AbilityUpgrade_" .. name)
            or (plr.Character and plr.Character:GetAttribute("AbilityUpgrade_" .. name))
    end)
    if type(attr) == "number" then return attr end
    -- fallback to Abilities module
    local mod = getAbilitiesModule()
    if mod and mod[name] and mod[name].Upgrades and mod[name].Upgrades.Dribble then
        return 0
    end
    return 0
end

local function getAbilityLine(name, plr)
    if not name or name == "" then return nil end
    local lvl = getAbilityUpgrade(name) + 1
    return string.format("%s V%d", name, lvl)
end

local function getDribbleMaxUses(plr)
    return 2 + getAbilityUpgrade("Dribble")
end

local function getDribbleCharges()
    local ok, val = pcall(function()
        return tonumber(LP.PlayerGui.Hotbar.Ability.ready.counts.Text)
    end)
    if ok and val then return math.max(math.floor(val), 0) end
    return 0
end

-- ───── drawing factory ─────
local function makeDraw(size, color)
    if not Drawing then return nil end
    local d = Drawing.new("Text")
    d.Visible = false
    d.Center = true
    d.Outline = true
    d.OutlineColor = Color3.new(0, 0, 0)
    d.Color = color
    d.Size = size
    d.Font = Drawing.Fonts.UI
    return d
end

-- ───── gui factory (for mobile fallback) ─────
local mobileGui
local function getMobileGui()
    if mobileGui and mobileGui.Parent then return mobileGui end
    mobileGui = Instance.new("ScreenGui")
    mobileGui.Name = "ZenthraAbilityBars"
    mobileGui.ResetOnSpawn = false
    mobileGui.IgnoreGuiInset = true
    mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mobileGui.DisplayOrder = 95
    local ok = pcall(function() mobileGui.Parent = CoreGui end)
    if not ok or not mobileGui.Parent then
        mobileGui.Parent = LP:WaitForChild("PlayerGui")
    end
    return mobileGui
end

local function makeGuiLabel(size, color)
    local l = Instance.new("TextLabel")
    l.AnchorPoint = Vector2.new(0.5, 0.5)
    l.Size = UDim2.fromOffset(math.max(80, size * 14), size + 6)
    l.BackgroundTransparency = 1
    l.Text = ""
    l.TextSize = size
    l.TextColor3 = color
    l.TextStrokeTransparency = 0
    l.TextStrokeColor3 = Color3.new(0, 0, 0)
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.ZIndex = 20
    l.Visible = false
    l.Parent = getMobileGui()
    return l
end

-- ───── drawing table for one player ─────
local function createDrawing(plr)
    if abilityEsp.drawings[plr] then
        abilityEsp.removeDrawing(plr)
    end
    local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    local t = {
        nameDraw     = makeDraw(abilityEsp.name_size, abilityEsp.name_color),
        abilityDraw  = makeDraw(abilityEsp.ability_size, abilityEsp.ability_color),
        timerDraw    = makeDraw(abilityEsp.active_size, abilityEsp.active_color),
        cdDraw       = makeDraw(abilityEsp.cd_size, abilityEsp.cd_color),
        usesDraw     = makeDraw(abilityEsp.uses_size, abilityEsp.uses_color),
        cdQueue      = {},
        cdDrawings   = {},
        cdGuis       = {},
        cdBarDrawings = {},
        activeStart  = nil,
        activeDur    = nil,
        cdStart      = nil,
        cdLen        = nil,
        abilityName  = nil,
        abilityLine  = nil,
        iconId       = nil,
        curUses      = nil,
        maxUses      = nil,
        charConns    = {},
    }
    if isMobile then
        t.nameGui    = makeGuiLabel(abilityEsp.name_size, abilityEsp.name_color)
        t.abilityGui = makeGuiLabel(abilityEsp.ability_size, abilityEsp.ability_color)
        t.timerGui   = makeGuiLabel(abilityEsp.active_size, abilityEsp.active_color)
        t.cdGui      = makeGuiLabel(abilityEsp.cd_size, abilityEsp.cd_color)
        t.usesGui    = makeGuiLabel(abilityEsp.uses_size, abilityEsp.uses_color)
    end
    abilityEsp.drawings[plr] = t
    return t
end

local function hideAll(t)
    if not t then return end
    if t.nameDraw then t.nameDraw.Visible = false end
    if t.abilityDraw then t.abilityDraw.Visible = false end
    if t.timerDraw then t.timerDraw.Visible = false end
    if t.cdDraw then t.cdDraw.Visible = false end
    if t.usesDraw then t.usesDraw.Visible = false end
    if t.nameGui then t.nameGui.Visible = false end
    if t.abilityGui then t.abilityGui.Visible = false end
    if t.timerGui then t.timerGui.Visible = false end
    if t.cdGui then t.cdGui.Visible = false end
    if t.usesGui then t.usesGui.Visible = false end
    if t.cdDrawings then for _, d in ipairs(t.cdDrawings) do d.Visible = false end end
    if t.cdGuis then for _, g in ipairs(t.cdGuis) do g.Visible = false end end
    if t.billboard then t.billboard.Enabled = false t.billboard.Adornee = nil end
end

local function removeDrawing(plr)
    local t = abilityEsp.drawings[plr]
    if not t then return end
    for _, key in ipairs({ "nameDraw", "abilityDraw", "timerDraw", "cdDraw", "usesDraw" }) do
        if t[key] then pcall(function() t[key]:Remove() end) end
    end
    for _, key in ipairs({ "nameGui", "abilityGui", "timerGui", "cdGui", "usesGui" }) do
        if t[key] then pcall(function() t[key]:Destroy() end) end
    end
    if t.cdDrawings then for _, d in ipairs(t.cdDrawings) do pcall(function() d:Remove() end) end end
    if t.cdGuis then for _, g in ipairs(t.cdGuis) do pcall(function() g:Destroy() end) end end
    if t.cdBarDrawings then
        for _, b in ipairs(t.cdBarDrawings) do
            if b.root then pcall(function() b.root:Destroy() end) end
        end
    end
    if t.billboard then pcall(function() t.billboard:Destroy() end) end
    if t.charConns then
        for _, c in ipairs(t.charConns) do pcall(function() c:Disconnect() end) end
    end
    abilityEsp.drawings[plr] = nil
    abilityEsp.billboards[plr] = nil
end

-- ───── billboard for image mode ─────
local function getBillboard(t, char, root)
    if not t.billboard or not t.billboard.Parent then
        local bg = Instance.new("BillboardGui")
        bg.AlwaysOnTop = true
        bg.LightInfluence = 0
        bg.Enabled = false
        bg.Parent = LP:WaitForChild("PlayerGui")
        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(1, 0, 1, 0)
        img.BackgroundTransparency = 1
        img.Image = ""
        img.ScaleType = Enum.ScaleType.Fit
        img.Parent = bg
        local lvl = Instance.new("TextLabel")
        lvl.BackgroundTransparency = 1
        lvl.TextStrokeTransparency = 0
        lvl.TextStrokeColor3 = Color3.new(0, 0, 0)
        lvl.Font = Enum.Font.GothamBold
        lvl.Parent = bg
        t.billboard = bg
        t.billboardImg = img
        t.billboardLvl = lvl
    end
    local size = abilityEsp.ability_size * 3
    t.billboard.Size = UDim2.new(0, size, 0, size)
    t.billboard.StudsOffset = Vector3.new(0, 4, 0)
    if t.billboardLvl then
        local ls = math.max(10, math.floor(abilityEsp.ability_size * 0.85))
        t.billboardLvl.Size = UDim2.new(0, ls * 2, 0, ls + 4)
        t.billboardLvl.Position = UDim2.new(1, -ls, 0, 0)
        t.billboardLvl.TextSize = ls
        t.billboardLvl.TextColor3 = abilityEsp.ability_color
    end
    local adornee = root or (char and char:FindFirstChild("HumanoidRootPart"))
    t.billboard.Adornee = adornee
    return t.billboard, t.billboardImg, t.billboardLvl
end

-- ───── event hook to sync state ─────
local function bindChar(t, plr, char)
    for _, c in ipairs(t.charConns) do pcall(function() c:Disconnect() end) end
    t.charConns = {}
    t.activeStart = nil
    t.activeDur = nil
    t.cdStart = nil
    t.cdLen = nil
    t.cdQueue = {}
    t.curUses = nil
    t.maxUses = nil

    local ability = plr:GetAttribute("CurrentlyEquippedAbility")
    if ability and ability ~= "" then
        t.abilityName = ability
        t.abilityLine = getAbilityLine(ability, plr)
        t.iconId = getIconFor(ability)
        if ability == "Dribble" then
            t.maxUses = getDribbleMaxUses(plr)
            t.curUses = t.maxUses
        end
    end

    table.insert(t.charConns, char.AttributeChanged:Connect(function(attr)
        local dt = abilityEsp.drawings[plr]
        if not dt then return end
        if attr == "DribbleDebounce" then
            if char:GetAttribute("DribbleDebounce") == true and dt.abilityName == "Dribble" then
                local mod = getAbilitiesModule()
                if mod and mod.Dribble then
                    table.insert(dt.cdQueue, { t = os.clock(), dur = mod.Dribble.cooldown })
                end
                if dt.curUses ~= nil then dt.curUses = math.max(0, dt.curUses - 1) end
            end
        end
        if attr == "AbilityActive" then
            local active = char:GetAttribute("AbilityActive")
            local dur = plr:GetAttribute("AbilityDuration")
            if active == true and dur and dur > 0 then
                dt.activeStart = os.clock()
                dt.activeDur = dur
            else
                dt.activeStart = nil
                dt.activeDur = nil
            end
        end
    end))

    table.insert(t.charConns, plr.AttributeChanged:Connect(function(attr)
        local dt = abilityEsp.drawings[plr]
        if not dt then return end
        if attr == "CurrentlyEquippedAbility" then
            local val = plr:GetAttribute("CurrentlyEquippedAbility")
            dt.abilityName = val
            dt.abilityLine = getAbilityLine(val, plr)
            dt.cdStart = nil
            dt.cdLen = nil
            dt.cdQueue = {}
            dt.iconId = getIconFor(val)
            if val == "Dribble" then
                dt.maxUses = getDribbleMaxUses(plr)
                dt.curUses = dt.maxUses
            else
                dt.maxUses = nil
                dt.curUses = nil
            end
        end
    end))
end

local function trackPlayer(plr)
    createDrawing(plr)
    local t = abilityEsp.drawings[plr]

    local function onChar(char)
        local dt = abilityEsp.drawings[plr]
        if not dt then return end
        bindChar(dt, plr, char)
    end

    if plr.Character then onChar(plr.Character) end
    table.insert(t.charConns, plr.CharacterAdded:Connect(onChar))
    table.insert(t.charConns, plr.CharacterRemoving:Connect(function()
        local dt = abilityEsp.drawings[plr]
        if dt then
            hideAll(dt)
            dt.activeStart = nil
            dt.activeDur = nil
            dt.cdStart = nil
            dt.cdLen = nil
            dt.cdQueue = {}
            dt.curUses = nil
            dt.maxUses = nil
        end
    end))
end

-- ───── project world → screen ─────
local function worldToScreenRoot(char, root)
    if not root then return nil end
    local head = char and char:FindFirstChild("Head")
    local offset = head and Vector3.new(0, head.Size.Y * 0.5 + 1.5, 0) or Vector3.new(0, 3, 0)
    local sp = Camera:WorldToViewportPoint(root.Position + offset)
    if sp.Z <= 0 then return nil end
    return Vector2.new(sp.X, sp.Y)
end

-- ───── update loop ─────
local function updateEsp()
    if not abilityEsp.active then return end
    local now = os.clock()
    for plr, t in pairs(abilityEsp.drawings) do
        if not plr or not plr.Parent then
            removeDrawing(plr)
            continue
        end
        local char = plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            hideAll(t)
            continue
        end
        local screen = worldToScreenRoot(char, root)
        if not screen then
            hideAll(t)
            continue
        end

        local yOff = 0

        -- name
        if abilityEsp.show_name then
            local nm = abilityEsp.name_mode == "Username" and plr.Name or plr.DisplayName
            yOff += abilityEsp.name_size + 2
            local pos = screen + Vector2.new(0, -yOff)
            if t.nameGui then
                t.nameDraw.Visible = false
                t.nameGui.Position = UDim2.fromOffset(pos.X, pos.Y)
                t.nameGui.Text = nm
                t.nameGui.TextSize = abilityEsp.name_size
                t.nameGui.TextColor3 = abilityEsp.name_color
                t.nameGui.Visible = true
            else
                t.nameDraw.Position = pos
                t.nameDraw.Text = nm
                t.nameDraw.Size = abilityEsp.name_size
                t.nameDraw.Color = abilityEsp.name_color
                t.nameDraw.Visible = true
            end
        else
            if t.nameDraw then t.nameDraw.Visible = false end
            if t.nameGui then t.nameGui.Visible = false end
        end

        -- ability icon / line
        local useImage = abilityEsp.mode == "Image"
        local icon = t.iconId or getIconFor(t.abilityName)
        if useImage and icon and icon ~= "" then
            t.abilityDraw.Visible = false
            if t.abilityGui then t.abilityGui.Visible = false end
            local size = abilityEsp.ability_size * 3
            local bg, img, lvl = getBillboard(t, char, root)
            if img then img.Image = icon end
            if lvl then lvl.Text = "V" .. (getAbilityUpgrade(t.abilityName) + 1) end
            if bg then bg.Enabled = true end
        else
            if t.billboard then t.billboard.Enabled = false end
            if t.abilityLine then
                local pos = screen + Vector2.new(0, yOff)
                if t.abilityGui then
                    t.abilityDraw.Visible = false
                    t.abilityGui.Position = UDim2.fromOffset(pos.X, pos.Y)
                    t.abilityGui.Text = t.abilityLine
                    t.abilityGui.TextSize = abilityEsp.ability_size
                    t.abilityGui.TextColor3 = abilityEsp.ability_color
                    t.abilityGui.Visible = true
                else
                    t.abilityDraw.Position = pos
                    t.abilityDraw.Text = t.abilityLine
                    t.abilityDraw.Size = abilityEsp.ability_size
                    t.abilityDraw.Color = abilityEsp.ability_color
                    t.abilityDraw.Visible = true
                end
                yOff += abilityEsp.ability_size + 4
            else
                if t.abilityDraw then t.abilityDraw.Visible = false end
                if t.abilityGui then t.abilityGui.Visible = false end
            end
        end

        -- dribble uses
        if abilityEsp.show_uses and t.abilityName == "Dribble" then
            local maxU = t.maxUses or getDribbleMaxUses(plr)
            local curU = plr == LP and getDribbleCharges() or t.curUses
            if curU ~= nil then
                local ratio = curU / math.max(1, maxU)
                local c = Color3.fromRGB(math.floor(255 * (1 - ratio)), math.floor(255 * ratio), 50)
                local pos = screen + Vector2.new(0, yOff)
                if t.usesGui then
                    t.usesDraw.Visible = false
                    t.usesGui.Position = UDim2.fromOffset(pos.X, pos.Y)
                    t.usesGui.Text = "uses  " .. curU
                    t.usesGui.TextColor3 = c
                    t.usesGui.TextSize = abilityEsp.uses_size
                    t.usesGui.Visible = true
                else
                    t.usesDraw.Position = pos
                    t.usesDraw.Text = "uses  " .. curU
                    t.usesDraw.Color = c
                    t.usesDraw.Size = abilityEsp.uses_size
                    t.usesDraw.Visible = true
                end
                yOff += abilityEsp.uses_size + 2
            end
        else
            if t.usesDraw then t.usesDraw.Visible = false end
            if t.usesGui then t.usesGui.Visible = false end
        end

        -- cooldown queue
        local i = 1
        while i <= #t.cdQueue do
            local q = t.cdQueue[i]
            if now - q.t >= q.dur then
                if plr ~= LP and t.curUses ~= nil then
                    t.curUses = math.min(t.maxUses or 999, t.curUses + 1)
                end
                table.remove(t.cdQueue, i)
            else
                i += 1
            end
        end
        while #t.cdDrawings < #t.cdQueue do
            table.insert(t.cdDrawings, makeDraw(abilityEsp.cd_size, abilityEsp.cd_color))
        end
        while #t.cdGuis < #t.cdQueue do
            table.insert(t.cdGuis, makeGuiLabel(abilityEsp.cd_size, abilityEsp.cd_color))
        end

        if abilityEsp.show_cd then
            for k, q in ipairs(t.cdQueue) do
                local remain = math.max(0, q.dur - (now - q.t))
                local pos = screen + Vector2.new(0, yOff)
                local d = t.cdDrawings[k]
                local g = t.cdGuis[k]
                if g then
                    if d then d.Visible = false end
                    g.Position = UDim2.fromOffset(pos.X, pos.Y)
                    g.Text = string.format("cd %d  %.1fs", k, remain)
                    g.TextSize = abilityEsp.cd_size
                    g.TextColor3 = abilityEsp.cd_color
                    g.Visible = true
                elseif d then
                    d.Position = pos
                    d.Text = string.format("cd %d  %.1fs", k, remain)
                    d.Size = abilityEsp.cd_size
                    d.Color = abilityEsp.cd_color
                    d.Visible = true
                end
                yOff += abilityEsp.cd_size + 2
            end
            for k = #t.cdQueue + 1, #t.cdDrawings do
                if t.cdDrawings[k] then t.cdDrawings[k].Visible = false end
            end
            for k = #t.cdQueue + 1, #t.cdGuis do
                if t.cdGuis[k] then t.cdGuis[k].Visible = false end
            end
        else
            for _, d in ipairs(t.cdDrawings) do d.Visible = false end
            for _, g in ipairs(t.cdGuis) do g.Visible = false end
        end

        -- active timer
        if abilityEsp.show_timer and t.activeStart and t.activeDur then
            local remain = math.max(0, t.activeDur - (now - t.activeStart))
            if remain > 0 then
                local pos = screen + Vector2.new(0, yOff)
                if t.timerGui then
                    t.timerDraw.Visible = false
                    t.timerGui.Position = UDim2.fromOffset(pos.X, pos.Y)
                    t.timerGui.Text = string.format("active  %.1fs", remain)
                    t.timerGui.TextSize = abilityEsp.active_size
                    t.timerGui.TextColor3 = abilityEsp.active_color
                    t.timerGui.Visible = true
                else
                    t.timerDraw.Position = pos
                    t.timerDraw.Text = string.format("active  %.1fs", remain)
                    t.timerDraw.Size = abilityEsp.active_size
                    t.timerDraw.Color = abilityEsp.active_color
                    t.timerDraw.Visible = true
                end
                yOff += abilityEsp.active_size + 2
            else
                t.activeStart = nil
                t.activeDur = nil
                if t.timerDraw then t.timerDraw.Visible = false end
                if t.timerGui then t.timerGui.Visible = false end
            end
        else
            if t.timerDraw then t.timerDraw.Visible = false end
            if t.timerGui then t.timerGui.Visible = false end
        end
    end
end

-- ───── start / stop ─────
local abilityEspApi = {}

function abilityEspApi.start()
    if abilityEsp.active then return end
    abilityEsp.active = true
    pcall(function() getAbilitiesModule() end)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then trackPlayer(plr) end
    end
    abilityEsp._playerAdded = Players.PlayerAdded:Connect(function(plr)
        if abilityEsp.active and plr ~= LP then trackPlayer(plr) end
    end)
    abilityEsp._playerRemoving = Players.PlayerRemoving:Connect(function(plr)
        removeDrawing(plr)
    end)
    abilityEsp.conn = RunService.RenderStepped:Connect(updateEsp)
end

function abilityEspApi.stop()
    if not abilityEsp.active then return end
    abilityEsp.active = false
    if abilityEsp.conn then abilityEsp.conn:Disconnect() abilityEsp.conn = nil end
    if abilityEsp._playerAdded then abilityEsp._playerAdded:Disconnect() abilityEsp._playerAdded = nil end
    if abilityEsp._playerRemoving then abilityEsp._playerRemoving:Disconnect() abilityEsp._playerRemoving = nil end
    for plr in pairs(abilityEsp.drawings) do removeDrawing(plr) end
    if mobileGui then mobileGui:Destroy() mobileGui = nil end
end

_G.__zenthraAbilityEsp = abilityEspApi

-- ═══════════════════════════════════════════════
-- EMOTE INJECT
-- ═══════════════════════════════════════════════

local emoteInject = {
    enabled        = false,
    installed      = false,
    modules        = nil,
    controller     = nil,
    ec             = nil,
    raw_get        = nil,
    real_owned     = {},
    _merged        = nil,
    _merged_ref    = nil,
    virtual        = {},
    favorites      = {},
    fav_statables  = {},
    our_container  = nil,
    inv_api        = nil,
    search_state   = nil,
    sort_opt       = nil,
    sort_order     = nil,
    use_fav        = nil,
    using_native   = false,
    search_wired   = false,
    deleted        = {},
    connections    = {},
    hooked_holders = nil,
    loop           = nil,
    last_play      = nil,
    last_play_t    = 0,
    move_conn      = nil,
    _static_fakes  = nil,
    basic = {
        Emote1 = true, Emote2 = true, Emote3 = true,
        Emote4 = true, Emote5 = true, Emote6 = true, Emote7 = true,
    },
}

-- ───── module loading ─────
local function loadModules()
    if emoteInject.modules and emoteInject.modules.ok then return true end
    local function try(mod)
        if not mod then return nil end
        local ok, r = pcall(require, mod)
        if ok then return r end
        return nil
    end
    local modules = {}
    local shared = ReplicatedStorage:FindFirstChild("Shared")
    local inventory = shared and shared:FindFirstChild("Inventory")
    modules.Shared     = try(inventory and inventory:FindFirstChild("Shared"))
    modules.ItemInfo   = try(shared and shared:FindFirstChild("ItemInfo"))
    modules.Statable   = try(shared and shared:FindFirstChild("Statable"))
    local controllers  = ReplicatedStorage:FindFirstChild("Controllers")
    modules.InventoryController = try(controllers and controllers:FindFirstChild("InventoryController", true))
    if not modules.InventoryController and controllers then
        local trading = controllers:FindFirstChild("Trading")
        modules.InventoryController = try(trading and trading:FindFirstChild("InventoryController"))
    end
    modules.EmoteWheelController  = try(controllers and controllers:FindFirstChild("EmoteWheelController"))
    modules.EmoteController       = try(controllers and controllers:FindFirstChild("EmoteController"))
    modules.DeleteItemPrompt      = try(controllers and controllers:FindFirstChild("DeleteItemPromptController"))
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    modules.Net = try(packages and packages:FindFirstChild("Net"))
    modules.ok = type(modules.Shared) == "table" and type(modules.ItemInfo) == "table"
        and type(modules.Statable) == "table" and type(modules.InventoryController) == "table"
    emoteInject.modules = modules
    emoteInject.controller = modules.EmoteWheelController
    emoteInject.ec = modules.EmoteController
    return modules.ok
end

-- ───── static fake emotes (all emotes as fake owned) ─────
local function getStaticFakes()
    if emoteInject._static_fakes then return emoteInject._static_fakes end
    local fakes = {}
    local shared = emoteInject.modules and emoteInject.modules.Shared
    local emote = emoteInject.modules and emoteInject.modules.ItemInfo and emoteInject.modules.ItemInfo.Emote
    if shared and type(emote) == "table" then
        for name in pairs(emote) do
            local ok, key = pcall(function()
                return shared:ItemToKey("Emote", { Id = name, Name = name }, { "Id" })
            end)
            if ok and key then
                fakes[key] = { Id = name, Name = name }
            end
        end
    end
    emoteInject._static_fakes = fakes
    return fakes
end

local function refreshOwned()
    local owned = {}
    if emoteInject.raw_get and emoteInject.modules then
        local ok, inv = pcall(emoteInject.raw_get, emoteInject.modules.Shared, nil, "Emote")
        if ok and type(inv) == "table" then
            for _, v in pairs(inv) do
                if type(v) == "table" and v.Name then owned[v.Name] = true end
            end
        end
    end
    emoteInject.real_owned = owned
end

local function reallyOwned(name)
    if not emoteInject.real_owned then refreshOwned() end
    return emoteInject.real_owned[name] == true
end

local function getMerged()
    local raw = nil
    pcall(function()
        raw = emoteInject.raw_get(emoteInject.modules.Shared, nil, "Emote")
    end)
    if emoteInject._merged and emoteInject._merged_ref == raw then
        return emoteInject._merged
    end
    local base = type(raw) == "table" and raw or {}
    local deleted = emoteInject.deleted or {}
    local merged = {}
    local realNames = {}
    for k, v in pairs(base) do
        if type(v) == "table" and v.Name then realNames[v.Name] = true end
    end
    for k, v in pairs(base) do
        if not (type(v) == "table" and v.Name and deleted[v.Name]) then
            merged[k] = v
        end
    end
    for k, v in pairs(getStaticFakes()) do
        if not realNames[v.Name] and merged[k] == nil and not deleted[v.Name] then
            merged[k] = v
        end
    end
    emoteInject._merged = merged
    emoteInject._merged_ref = raw
    return merged
end

-- ───── install hooks ─────
local function installHooks()
    if emoteInject.installed then return true end
    if not loadModules() then return false end
    local modules = emoteInject.modules
    local shared = modules.Shared

    emoteInject.raw_get = shared.Get
    shared.Get = function(self, idx, kind)
        if emoteInject.enabled and idx == nil and kind == "Emote" then
            return getMerged()
        end
        return emoteInject.raw_get(self, idx, kind)
    end

    local ogGetItem = shared.GetItem
    if type(ogGetItem) == "function" then
        shared.GetItem = function(self, idx, kind, name)
            local r = ogGetItem(self, idx, kind, name)
            if r or not emoteInject.enabled or idx ~= nil or kind ~= "Emote" then return r end
            local emote = modules.ItemInfo.Emote
            if type(emote) ~= "table" then return r end
            if emote[name] then return { Id = name, Name = name } end
            local ok, item = pcall(function() return self:StringToItem("Emote", name) end)
            if ok and type(item) == "table" and item.Name and emote[item.Name] then
                if item.Id == nil then item.Id = item.Name end
                return item
            end
            return r
        end
    end

    local ogFind = shared.FindItemsWithKey
    if type(ogFind) == "function" then
        shared.FindItemsWithKey = function(self, idx, kind, name)
            local r = ogFind(self, idx, kind, name)
            if not emoteInject.enabled or idx ~= nil or kind ~= "Emote" then return r end
            if type(r) == "table" and #r > 0 then return r end
            local emote = modules.ItemInfo.Emote
            if not (emote and emote[name]) then
                local ok, item = pcall(function() return self:StringToItem("Emote", name) end)
                if ok and type(item) == "table" and item.Name then name = item.Name end
            end
            if name and emote and emote[name] then return { name } end
            return r
        end
    end

    local ogGetEq = shared.GetEquippedList
    if type(ogGetEq) == "function" then
        shared.GetEquippedList = function(self, idx, kind, ...)
            local r = ogGetEq(self, idx, kind, ...)
            if not emoteInject.enabled or idx ~= nil or kind ~= "Emote" then return r end
            local out = {}
            if type(r) == "table" then
                for k, v in pairs(r) do out[k] = v end
            end
            for k, name in pairs(emoteInject.virtual) do
                out[k] = { Name = name, Id = name }
            end
            return out
        end
    end

    -- favorites
    local ic = modules.InventoryController
    if ic and type(ic.GetFavoriteState) == "function" then
        local ogFav = ic.GetFavoriteState
        ic.GetFavoriteState = function(self, kind, name, ...)
            local extra = table.pack(...)
            local args = { self, kind, name }
            for i = 1, extra.n do args[#args + 1] = extra[i] end
            local ok, fav = pcall(function() return ogFav(table.unpack(args)) end)
            if not ok or not fav then return fav end
            if emoteInject.enabled and kind == "Emote" and name and type(fav) == "table" then
                emoteInject.fav_statables[name] = fav
                if emoteInject.favorites[name] and not reallyOwned(name)
                    and type(fav.Set) == "function"
                    and type(fav.Get) == "function" and fav:Get() ~= true then
                    pcall(function() fav:Set(true) end)
                end
            end
            return fav
        end
    end

    -- EmoteController overrides
    local ec = emoteInject.ec
    if type(ec) == "table" then
        if type(ec.UseEmote) == "function" then
            emoteInject.ec_use = ec.UseEmote
            ec.UseEmote = function(self, name)
                if emoteInject.enabled then emoteInject.stop_local() end
                return emoteInject.ec_use(self, name)
            end
        end
        if type(ec.UseEmoteByName) == "function" then
            emoteInject.ec_use_name = ec.UseEmoteByName
            ec.UseEmoteByName = function(self, name)
                if emoteInject.enabled then emoteInject.stop_local() end
                return emoteInject.ec_use_name(self, name)
            end
        end
        if type(ec.Play) == "function" then
            emoteInject.ec_play = ec.Play
            ec.Play = function(self, name, ...)
                local shouldPlayLocal = emoteInject.enabled and type(name) == "string"
                    and name ~= "" and not emoteInject.basic[name] and not reallyOwned(name)
                if shouldPlayLocal then
                    emoteInject.play_local(name)
                    return
                end
                if emoteInject.enabled then emoteInject.stop_local() end
                return emoteInject.ec_play(self, name, ...)
            end
        end
    end

    emoteInject.installed = true
    return true
end

-- ───── local play emote ─────
local function stopLocal()
    if emoteInject.move_conn then
        pcall(function() emoteInject.move_conn:Disconnect() end)
        emoteInject.move_conn = nil
    end
    emoteInject.last_play = nil

    -- stop via Emotes module
    pcall(function()
        local shared = ReplicatedStorage.Shared
        local emotes = shared:FindFirstChild("EmotesShared")
        if emotes then
            local mod = require(emotes)
            if mod and mod.Stop then mod:Stop(LP.Character) end
        end
    end)

    -- stop via animator tracks
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local anim = track.Animation
            if anim then
                local emoteName = anim:GetAttribute("EmoteName")
                if emoteName or (emoteInject.modules and emoteInject.modules.Shared) then
                    pcall(function() track:Stop(0) end)
                end
            end
        end
    end)
end

local function playLocal(name)
    local now = os.clock()
    if name == emoteInject.last_play and now - emoteInject.last_play_t < 0.25 then return end
    emoteInject.last_play = name
    emoteInject.last_play_t = now
    stopLocal()

    local ok = false
    pcall(function()
        local shared = ReplicatedStorage.Shared
        local emotes = shared:FindFirstChild("EmotesShared")
        if not emotes then return end
        local mod = require(emotes)
        local char = LP.Character
        if not char or not char.PrimaryPart then return end
        if not char:FindFirstChildWhichIsA("Humanoid") then return end
        mod:Play(char, nil, name, true, Workspace:GetServerTimeNow(), nil)
        ok = true
    end)

    if ok then
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            emoteInject.move_conn = hum:GetPropertyChangedSignal("MoveDirection"):Connect(function()
                if hum.MoveDirection.Magnitude > 0 then stopLocal() end
            end)
        end
    end
end

emoteInject.stop_local = stopLocal
emoteInject.play_local = playLocal

-- ───── emote wheel list build ─────
local function getEmoteWheel()
    local pg = LP:FindFirstChild("PlayerGui")
    return pg and pg:FindFirstChild("EmoteWheel")
end

local function findHolder(container)
    if not container then return nil end
    local holder = container:FindFirstChild("Holder")
    if holder then return holder end
    for _, d in ipairs(container:GetDescendants()) do
        if d:IsA("GuiObject") and d:FindFirstChild("1") and d:FindFirstChild("2") then
            return d
        end
    end
    return nil
end

local function isListOpen()
    local wheel = getEmoteWheel()
    local list = wheel and wheel:FindFirstChild("List")
    return list and list:IsA("GuiObject") and list.Visible == true
end

local function currentAbsSlot()
    local ctrl = emoteInject.controller
    local n = ctrl and tonumber(ctrl.selected) or 1
    if n < 1 then n = 1 end
    if ctrl and ctrl.type == "Wheel" then
        local page = ctrl and tonumber(ctrl.page) or 1
        if page < 1 then page = 1 end
        return n + (page - 1) * 8
    end
    return n
end

local function absSlotFor(btn)
    local ctrl = emoteInject.controller
    local n = tonumber(btn and btn.Name)
    if not n or n < 1 then return nil end
    if ctrl and ctrl.type == "Wheel" then
        local page = ctrl and tonumber(ctrl.page) or 1
        if page < 1 then page = 1 end
        return n + (page - 1) * 8
    end
    return n
end

-- ───── bind wheel clicks ─────
local function bindWheelSlot(btn)
    if not btn then return end
    local lastClick = 0
    local function onClick()
        if not emoteInject.enabled then return end
        local now = os.clock()
        if now - lastClick < 0.2 then return end
        lastClick = now
        if isListOpen() then return end
        local slot = absSlotFor(btn)
        if not slot then return end
        local name = emoteInject.virtual[slot]
        if type(name) ~= "string" or name == "" then return end
        if emoteInject.basic[name] or reallyOwned(name) then
            stopLocal()
            return
        end
        playLocal(name)
    end
    if btn.MouseButton1Click then
        table.insert(emoteInject.connections, btn.MouseButton1Click:Connect(onClick))
    end
    if btn.Activated then
        table.insert(emoteInject.connections, btn.Activated:Connect(onClick))
    end
end

local function bindWheelSlots()
    if not emoteInject.enabled then return end
    local wheel = getEmoteWheel()
    if not wheel then return end
    if not emoteInject.hooked_holders then
        emoteInject.hooked_holders = setmetatable({}, { __mode = "k" })
    end
    for _, container in ipairs({ wheel:FindFirstChild("Wheel"), wheel:FindFirstChild("Menu") }) do
        local holder = findHolder(container)
        if holder and not emoteInject.hooked_holders[holder] then
            local hooked = false
            for i = 1, 24 do
                local btn = holder:FindFirstChild(tostring(i))
                if btn and (btn:IsA("ImageButton") or btn:IsA("GuiButton")) then
                    bindWheelSlot(btn)
                    hooked = true
                end
            end
            if hooked then emoteInject.hooked_holders[holder] = true end
        end
    end
end

-- ───── save/load ─────
local function saveState()
    if not (getgenv and getgenv().ZenthraConfig) then return end
end

local function pickEmote(name)
    if type(name) ~= "string" or name == "" then return end
    emoteInject.virtual[currentAbsSlot()] = name
end

_G.__zenthraEmote = {
    enable    = function(v)
        emoteInject.enabled = v == true
        if v then
            if installHooks() then
                refreshOwned()
                emoteInject._merged = nil
                emoteInject._merged_ref = nil
                local wheel = getEmoteWheel()
                if wheel then
                    pcall(function() emoteInject.repaint() end)
                end
            end
        else
            stopLocal()
        end
    end,
    stopLocal = stopLocal,
    playLocal = playLocal,
    pick      = pickEmote,
    wheel     = emoteInject,
}

-- ───── repaint wheel ─────
function emoteInject.repaint()
    local ctrl = emoteInject.controller
    if not ctrl then return end
    pcall(function() if ctrl.UpdateHolderEmotes then ctrl:UpdateHolderEmotes() end end)
    pcall(function() if ctrl.updateCenterText then ctrl:updateCenterText() end end)
    pcall(function() if ctrl.UpdateMenuContentEmotes then ctrl:UpdateMenuContentEmotes() end end)
end

-- ───── wire into UI at startup ─────
task.delay(1, function()
    if Config.emote_unlock then
        _G.__zenthraEmote.enable(true)
    end
    if Config.esp_aim then
        _G.__zenthraAbilityEsp.start()
    end
end)

-- ═══════════════════════════════════════════════
-- PART 4 — CINEMATIC FX + PROFILE SPOOFER + RANK/ELO SPOOFER
-- ═══════════════════════════════════════════════

-- ───── CINEMATIC FX ─────
local cinematicFx = {
    enabled  = false,
    selected = "Lightning",
    volume   = 0.65,
    reduced  = false,
    modules  = {},
    seen     = setmetatable({}, { __mode = "k" }),
    names    = { "Lightning", "Hell Portal", "Heaven Portal" },
}

local function sampleStorm(t)
    t = math.max(t, 0)
    local function cl(v) return math.clamp(v, 0, 1) end
    local function nrm(v, a, b) return cl((v - a) / (b - a)) end
    local function smooth(v) return v * v * (3 - 2 * v) end
    return {
        charge  = smooth(nrm(t, 0, 0.3)) * (1 - nrm(t, 0.32, 0.48)),
        strike  = t >= 0.32 and math.exp(-(t - 0.32) * 9) or 0,
        shock   = nrm(t, 0.32, 0.75),
        burn    = nrm(t, 0.35, 0.65),
        crumble = nrm(t, 1.1, 2.1),
        fade    = nrm(t, 1.85, 2.2),
        done    = t >= 2.2,
    }
end

local function playStorm(pivot)
    local duration = 2.2
    local fxFolder = Instance.new("Folder")
    fxFolder.Name = "ZenthraStorm"
    fxFolder.Parent = Workspace

    local root = Instance.new("Part")
    root.Anchored = true
    root.CanCollide = false
    root.CanQuery = false
    root.CanTouch = false
    root.CastShadow = false
    root.Transparency = 1
    root.Size = Vector3.new(0.1, 0.1, 0.1)
    root.CFrame = CFrame.new(pivot.Position)
    root.Parent = fxFolder

    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(78, 160, 255)
    light.Range = 21
    light.Brightness = 0
    light.Shadows = false
    light.Parent = root

    local arcParts = {}
    for i = 1, 16 do
        local p = Instance.new("Part")
        p.Anchored = true
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.CastShadow = false
        p.Material = Enum.Material.Neon
        p.Color = Color3.fromRGB(78, 160, 255)
        p.Size = Vector3.new(0.15, 0.15, 0.15)
        p.Parent = fxFolder
        table.insert(arcParts, p)
    end

    local impact = Instance.new("Part")
    impact.Anchored = true
    impact.CanCollide = false
    impact.CanQuery = false
    impact.CanTouch = false
    impact.CastShadow = false
    impact.Shape = Enum.PartType.Ball
    impact.Material = Enum.Material.Neon
    impact.Color = Color3.fromRGB(224, 246, 220)
    impact.Size = Vector3.new(0.3, 0.3, 0.3)
    impact.Transparency = 1
    impact.CFrame = CFrame.new(pivot.Position)
    impact.Parent = fxFolder

    local startT = os.clock()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not cinematicFx.enabled then
            conn:Disconnect()
            fxFolder:Destroy()
            return
        end
        local elapsed = os.clock() - startT
        local s = sampleStorm(elapsed)

        local yShift = -0.7 * smooth(s.crumble) + 0.12 * s.strike
        root.CFrame = pivot + Vector3.new(0, yShift, 0)

        local center = root.Position + Vector3.new(0, 11, 0)
        for i, p in ipairs(arcParts) do
            local ang = (i - 1) / #arcParts * math.pi * 2 + os.clock() * 0.8
            local r = 2 + math.sin(os.clock() * 8 + i) * (0.6 + s.strike * 2.4)
            local y = center.Y + math.sin(os.clock() * 4 + i) * 1.4
            local pos = Vector3.new(center.X + math.cos(ang) * r, y, center.Z + math.sin(ang) * r)
            p.Position = pos
            p.Transparency = 1 - math.max(s.charge, s.strike) * 0.9
        end

        light.Brightness = (s.charge * 0.6 + s.strike * 5) * (cinematicFx.reduced and 0.35 or 1)
        impact.Size = Vector3.new(0.3, 0.3, 0.3) * (1 + 4.2 * s.shock)
        impact.Transparency = 1 - s.strike * (cinematicFx.reduced and 0.15 or 0.65)
        impact.CFrame = pivot + Vector3.new(0, 0.3, 0)

        if s.done then
            conn:Disconnect()
            fxFolder:Destroy()
        end
    end)
end

local function playHellPortal(pivot)
    local fxFolder = Instance.new("Folder")
    fxFolder.Name = "ZenthraHellPortal"
    fxFolder.Parent = Workspace

    local anchor = Instance.new("Part")
    anchor.Anchored = true
    anchor.CanCollide = false
    anchor.CanQuery = false
    anchor.CanTouch = false
    anchor.CastShadow = false
    anchor.Transparency = 1
    anchor.Size = Vector3.new(0.1, 0.1, 0.1)
    anchor.CFrame = CFrame.new(pivot.Position)
    anchor.Parent = fxFolder

    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 86, 12)
    light.Range = 46
    light.Brightness = 0
    light.Shadows = false
    light.Parent = anchor

    -- 2 obsidian pillars
    local pillars = {}
    for _, side in ipairs({ -1, 1 }) do
        for i = 0, 7 do
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = false
            p.CanQuery = false
            p.CanTouch = false
            p.CastShadow = false
            p.Material = Enum.Material.Basalt
            p.Color = Color3.fromRGB(34, 28, 30)
            p.Size = Vector3.new(3.5, 3, 6)
            p.CFrame = pivot * CFrame.new(side * 10.5, 1.5 + i * 3, 0)
            p.Parent = fxFolder
            table.insert(pillars, { part = p, baseCF = p.CFrame })
        end
    end

    -- arch
    for i = 0, 12 do
        local ang = math.pi * i / 12
        local pos = Vector3.new(math.cos(ang) * 10, 25 + math.sin(ang) * 6.7, 0)
        local p = Instance.new("Part")
        p.Anchored = true
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.CastShadow = false
        p.Material = Enum.Material.Basalt
        p.Color = Color3.fromRGB(34, 28, 30)
        p.Size = Vector3.new(2.75, 5.05, 6.05)
        p.CFrame = pivot * CFrame.new(pos) * CFrame.Angles(0, 0, ang - math.pi / 2)
        p.Parent = fxFolder
        table.insert(pillars, { part = p, baseCF = p.CFrame })
    end

    -- portal rings
    local rings = {}
    for i = 1, 2 do
        for j = 1, 20 do
            local a0 = Instance.new("Attachment", anchor)
            local a1 = Instance.new("Attachment", anchor)
            local beam = Instance.new("Beam", anchor)
            beam.Attachment0 = a0
            beam.Attachment1 = a1
            beam.Width0 = i == 1 and 0.55 or 0.32
            beam.Width1 = beam.Width0
            beam.Segments = 1
            beam.Color = ColorSequence.new(i == 2 and Color3.fromRGB(255, 86, 12) or Color3.fromRGB(255, 150, 4))
            beam.FaceCamera = true
            beam.LightEmission = 1
            beam.LightInfluence = 0
            beam.Transparency = NumberSequence.new(1)
            beam.Parent = anchor
            table.insert(rings, { beam = beam, a = a0, b = a1, angle = (j - 1) / 20 * math.pi * 2, layer = i, radius = i == 1 and 7.35 * 1.02 or 7.35 * 0.72 })
        end
    end

    -- spiral embers
    local spiralParts = {}
    for i = 0, 2 do
        for j = 0, 11 do
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = false
            p.CanQuery = false
            p.CanTouch = false
            p.CastShadow = false
            p.Material = Enum.Material.Neon
            p.Color = Color3.fromRGB(255, 86, 12):Lerp(Color3.fromRGB(255, 150, 4), j / 11)
            p.Size = Vector3.new(0.32 + 0.34 * (1 - j / 11), 0.32 + 0.34 * (1 - j / 11), 0.32 + 0.34 * (1 - j / 11))
            p.Transparency = 1
            p.Parent = fxFolder
            table.insert(spiralParts, { part = p, arm = i, j = j })
        end
    end

    local startT = os.clock()
    local duration = 6
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not cinematicFx.enabled then
            conn:Disconnect()
            fxFolder:Destroy()
            return
        end
        local t = os.clock() - startT
        local function cl(v) return math.clamp(v, 0, 1) end
        local function nrm(v, a, b) return cl((v - a) / (b - a)) end
        local function smooth(v) return v * v * (3 - 2 * v) end

        local lift = (smooth(nrm(t, 0, 1.3)) - 1) * 42 + (t > 1.3 and t < 1.9 and math.sin((t - 1.3) * 18) * math.exp(-(t - 1.3) * 6) * 0.45 or 0)
        local open = smooth(nrm(t, 1.35, 2.1)) * (1 - (nrm(t, 3.6, 4.3))^3)
        local vortex = smooth(nrm(t, 1.45, 2.3)) * (1 - nrm(t, 3.9, 4.5))
        local pull = (nrm(t, 2.55, 3.32))^3
        local flash = t >= 3.3 and math.exp(-(t - 3.3) * 9) or 0
        local shock = nrm(t, 3.3, 3.95)
        local slam = t >= 4.3 and math.exp(-(t - 4.3) * 10) * math.sin((t - 4.3) * 55) or 0
        local cool = nrm(t, 4.6, 5.6)
        local fade = nrm(t, 5.7, 6)

        local globalY = lift + slam * 0.35
        local scaledPivot = pivot + Vector3.new(0, globalY, 0)

        for _, p in ipairs(pillars) do
            p.part.CFrame = scaledPivot * (p.baseCF - pivot.Position) * CFrame.Angles(0, 0, 0)
            p.part.Transparency = fade
        end

        -- rings
        for _, r in ipairs(rings) do
            local rad = r.radius * (0.2 + 0.8 * vortex)
            local ang = r.angle + t * (r.layer == 1 and -1.9 or 3.1) - pull * 4
            local center = scaledPivot * CFrame.new(0, 11.2, -8.2)
            local p0 = center * CFrame.new(math.cos(ang) * rad, 0, math.sin(ang) * rad)
            local p1 = center * CFrame.new(math.cos(ang + math.pi * 2 / 20 * 0.97) * rad, 0, math.sin(ang + math.pi * 2 / 20 * 0.97) * rad)
            r.a.WorldPosition = p0.Position
            r.b.WorldPosition = p1.Position
            r.beam.Transparency = NumberSequence.new(1 - cl(vortex * (r.layer == 1 and 0.9 or 0.6)))
        end

        -- spiral
        local rot = -(t * 4.2 + pull * 9)
        for _, s in ipairs(spiralParts) do
            local idx = s.j / 11
            local radius = (0.9 + (7.35 - 0.8) * (1 - idx) ^ 0.85) * (0.35 + 0.65 * vortex)
            local a = s.arm * math.pi * 2 / 3 + idx * 4.1 + rot * (1 + idx * 0.6)
            local center = scaledPivot * CFrame.new(0, 11.2, -8.2)
            local pos = center * CFrame.new(math.cos(a) * radius, math.sin(a) * radius, 0)
            s.part.CFrame = pos * CFrame.Angles(t * 5, a, t * 3)
            s.part.Transparency = 1 - cl(vortex * (0.85 - idx * 0.58))
        end

        light.Brightness = (vortex * 3.2 + flash * 5) * (cinematicFx.reduced and 0.35 or 1)
        light.Color = Color3.fromRGB(255, 86, 12):Lerp(Color3.fromRGB(255, 150, 4), flash)

        -- destroy at end
        if t >= duration then
            conn:Disconnect()
            fxFolder:Destroy()
        end
    end)
end

local function playHeavenPortal(pivot)
    local fxFolder = Instance.new("Folder")
    fxFolder.Name = "ZenthraHeavenPortal"
    fxFolder.Parent = Workspace

    local anchor = Instance.new("Part")
    anchor.Anchored = true
    anchor.CanCollide = false
    anchor.CanQuery = false
    anchor.CanTouch = false
    anchor.CastShadow = false
    anchor.Transparency = 1
    anchor.Size = Vector3.new(0.1, 0.1, 0.1)
    anchor.CFrame = CFrame.new(pivot.Position)
    anchor.Parent = fxFolder

    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 244, 208)
    light.Range = 48
    light.Brightness = 0
    light.Shadows = false
    light.Parent = anchor

    -- 2 marble columns
    local pillars = {}
    for _, side in ipairs({ -1, 1 }) do
        for i = 0, 9 do
            local ang = i / 10 * math.pi * 2
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = false
            p.CanQuery = false
            p.CanTouch = false
            p.CastShadow = false
            p.Material = Enum.Material.Marble
            p.Color = i % 2 == 0 and Color3.fromRGB(228, 226, 220) or Color3.fromRGB(208, 206, 202)
            p.Shape = Enum.PartType.Cylinder
            p.Size = Vector3.new(1.1, 1.1, 22.8)
            p.CFrame = pivot * CFrame.new(side * 10.5 + math.cos(ang) * 2.75, 13, math.sin(ang) * 2.75) * CFrame.Angles(0, 0, math.pi / 2)
            p.Parent = fxFolder
            table.insert(pillars, { part = p, baseCF = p.CFrame - pivot.Position })
        end
        -- plinth + capital
        local plinth = Instance.new("Part")
        plinth.Anchored = true
        plinth.CanCollide = false
        plinth.CanQuery = false
        plinth.CanTouch = false
        plinth.CastShadow = false
        plinth.Material = Enum.Material.Metal
        plinth.Color = Color3.fromRGB(232, 190, 125)
        plinth.Size = Vector3.new(7.6, 1.2, 7.6)
        plinth.CFrame = pivot * CFrame.new(side * 10.5, 0.6, 0)
        plinth.Parent = fxFolder
        table.insert(pillars, { part = plinth, baseCF = plinth.CFrame - pivot.Position })

        local cap = Instance.new("Part")
        cap.Anchored = true
        cap.CanCollide = false
        cap.CanQuery = false
        cap.CanTouch = false
        cap.CastShadow = false
        cap.Material = Enum.Material.Metal
        cap.Color = Color3.fromRGB(232, 190, 125)
        cap.Size = Vector3.new(7.8, 1.5, 7.8)
        cap.CFrame = pivot * CFrame.new(side * 10.5, 26.25, 0)
        cap.Parent = fxFolder
        table.insert(pillars, { part = cap, baseCF = cap.CFrame - pivot.Position })
    end

    -- arch
    for i = 0, 12 do
        local ang = math.pi * i / 12
        local p = Instance.new("Part")
        p.Anchored = true
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.CastShadow = false
        p.Material = Enum.Material.Marble
        p.Color = i % 2 == 0 and Color3.fromRGB(228, 226, 220) or Color3.fromRGB(208, 206, 202)
        p.Size = Vector3.new(i == 6 and 3.6 or 2.75, i == 6 and 6 or 5.05, i == 6 and 6.2 or 5.6)
        p.CFrame = pivot * CFrame.new(math.cos(ang) * 10, 25 + math.sin(ang) * 7, 0) * CFrame.Angles(0, 0, ang - math.pi / 2)
        p.Parent = fxFolder
        table.insert(pillars, { part = p, baseCF = p.CFrame - pivot.Position })
    end

    -- sun disc + rays
    for i = 0, 7 do
        local ang = i / 8 * math.pi * 2
        local ray = Instance.new("Part")
        ray.Anchored = true
        ray.CanCollide = false
        ray.CanQuery = false
        ray.CanTouch = false
        ray.CastShadow = false
        ray.Material = Enum.Material.Metal
        ray.Color = Color3.fromRGB(232, 190, 125)
        ray.Size = Vector3.new(0.35, 1.6, 2)
        ray.CFrame = pivot * CFrame.new(math.cos(ang) * 2.5, 35.2 + math.sin(ang) * 2.5, 3.35) * CFrame.Angles(0, 0, ang - math.pi / 2)
        ray.Parent = fxFolder
        table.insert(pillars, { part = ray, baseCF = ray.CFrame - pivot.Position })
    end

    -- portal disc
    local disc = Instance.new("Part")
    disc.Anchored = true
    disc.CanCollide = false
    disc.CanQuery = false
    disc.CanTouch = false
    disc.CastShadow = false
    disc.Shape = Enum.PartType.Cylinder
    disc.Material = Enum.Material.Neon
    disc.Color = Color3.fromRGB(255, 160, 250)
    disc.Size = Vector3.new(2, 14, 14)
    disc.Transparency = 1
    disc.CFrame = pivot * CFrame.new(0, 11.2, -1.3) * CFrame.Angles(0, math.pi / 2, 0)
    disc.Parent = fxFolder

    local startT = os.clock()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not cinematicFx.enabled then
            conn:Disconnect()
            fxFolder:Destroy()
            return
        end
        local t = os.clock() - startT
        local function cl(v) return math.clamp(v, 0, 1) end
        local function nrm(v, a, b) return cl((v - a) / (b - a)) end
        local function smooth(v) return v * v * (3 - 2 * v) end

        local lift = (1 - smooth(nrm(t, 0, 1.4))) * 48 + (t > 1.4 and t < 1.95 and math.sin((t - 1.4) * 18) * math.exp(-(t - 1.4) * 5) * 0.4 or 0)
        local open = smooth(nrm(t, 1.4, 2.15)) * (1 - (nrm(t, 3.65, 4.3))^3)
        local glow = smooth(nrm(t, 1.45, 2.3)) * (1 - nrm(t, 3.95, 4.55))
        local pull = (nrm(t, 2.75, 3.42))^3
        local flash = t >= 3.4 and math.exp(-(t - 3.4) * 9) or 0
        local burst = nrm(t, 3.4, 4.05)
        local fade = nrm(t, 5.15, 5.95)

        local scaledPivot = pivot + Vector3.new(0, -lift, 0)

        for _, p in ipairs(pillars) do
            p.part.CFrame = CFrame.new(scaledPivot.Position) * p.baseCF
            p.part.Transparency = fade
        end

        light.Brightness = (glow * 2.2 + flash * 4) * (cinematicFx.reduced and 0.35 or 1)
        disc.Size = Vector3.new(2, 14 * (1 + 0.5 * flash), 14 * (1 + 0.5 * flash))
        disc.Transparency = 1 - glow * 0.55
        disc.CFrame = scaledPivot * CFrame.new(0, 11.2, -1.3) * CFrame.Angles(0, math.pi / 2, 0)

        if t >= 6 then
            conn:Disconnect()
            fxFolder:Destroy()
        end
    end)
end

local cinematicApi = {}

function cinematicApi.play(target)
    if not cinematicFx.enabled then return end
    if not target or not target.Parent then return end
    local pivot = target:GetPivot()
    local root = target:FindFirstChild("HumanoidRootPart")
    if root then pivot = root.CFrame end
    if cinematicFx.selected == "Hell Portal" then
        playHellPortal(pivot)
    elseif cinematicFx.selected == "Heaven Portal" then
        playHeavenPortal(pivot)
    else
        playStorm(pivot)
    end
end

function cinematicApi.preview()
    local char = LP.Character
    if not char or not char.PrimaryPart then return end
    local savedSel = cinematicFx.selected
    local root = char.PrimaryPart
    local pivot = root.CFrame * CFrame.new(0, 0, -8)
    if savedSel == "Hell Portal" then
        playHellPortal(pivot)
    elseif savedSel == "Heaven Portal" then
        playHeavenPortal(pivot)
    else
        playStorm(pivot)
    end
end

function cinematicApi.stop()
    for _, name in ipairs(cinematicFx.names) do
        local f = Workspace:FindFirstChild("Zenthra" .. (name == "Lightning" and "Storm" or (name == "Hell Portal" and "HellPortal" or "HeavenPortal")))
        if f then f:Destroy() end
    end
    cinematicFx.seen = setmetatable({}, { __mode = "k" })
end

_G.__zenthraCinematic = cinematicApi

-- hook kill event to trigger cinematic
task.spawn(function()
    local ok = pcall(function()
        local ev = ReplicatedStorage.Remotes:WaitForChild("Killed", 15)
        if not ev then return end
        ev.OnClientEvent:Connect(function(victim, ...)
            if not cinematicFx.enabled then return end
            local char = victim
            if type(victim) == "table" then char = victim.Character or victim end
            if type(victim) == "Instance" then
                if victim:IsA("Player") then char = victim.Character
                elseif victim:IsA("Model") then char = victim end
            end
            if char and char.Parent then
                -- check if kill is from us
                local latest = LP.Character
                if not latest then return end
                cinematicApi.play(char)
            end
        end)
    end)
end)

-- ═══════════════════════════════════════════════
-- PROFILE SPOOFER
-- ═══════════════════════════════════════════════

local profileSpoofer = {
    connections = {},
    title_cache = nil,
    title_alts  = nil,
    buttons_hook = nil,
}

local function getTitleData()
    if profileSpoofer.title_cache then return profileSpoofer.title_cache end
    local ok, mod = pcall(function()
        return require(ReplicatedStorage.Shared:WaitForChild("TitleData", 5))
    end)
    if not ok or type(mod) ~= "table" then return nil end
    local byName, byText = {}, {}
    for _, v in pairs(mod) do
        if type(v) == "table" then
            byName[v.Name] = v
            if v.Tag and v.Tag.Text then byText[v.Tag.Text] = v end
        end
    end
    profileSpoofer.title_cache = byName
    profileSpoofer.title_alts = byText
    return byName
end

local function getTitle(name)
    local t = getTitleData()
    if not t then return nil end
    return t[name] or (profileSpoofer.title_alts and profileSpoofer.title_alts[name])
end

local function resolveAvatarId(input)
    if not input or input == "" then return LP.UserId end
    local n = tonumber(input)
    if n then return n end
    local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(input) end)
    return ok and id or LP.UserId
end

local function spoofProfileView(player)
    if not Config.profile_spoof or player ~= LP then return end
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return end
    local card = pg:FindFirstChild("ProfileCard")
    if not card then return end
    local customize = card:FindFirstChild("Customize")
    if not customize then return end
    local profile = customize:FindFirstChild("Profile")
    local pp = profile and profile:FindFirstChild("Playerprofile")
    local details = pp and pp:FindFirstChild("Details")
    local stats = pp and pp:FindFirstChild("Stats")

    -- avatar
    local avatarId = resolveAvatarId(Config.profile_avatar)
    if pp and pp:FindFirstChild("Player") then
        pp.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(avatarId)
    end

    -- name
    if details then
        local u = details:FindFirstChild("Username")
        if u then u.Text = "@" .. Config.profile_username end
        local u1 = details:FindFirstChild("Username1")
        if u1 then u1.Text = Config.profile_display end
        local country = details:FindFirstChild("Country")
        if country then
            local parts = {}
            if Config.profile_verified then table.insert(parts, utf8.char(57344)) end
            country.Text = table.concat(parts, " ")
        end
        local title = details:FindFirstChild("Title")
        if title then
            local td = getTitle(Config.profile_title)
            if td then
                title.Text = td.Tag.Text
                title.TextColor3 = td.Tag.Color
                title.Visible = true
            else
                title.Visible = false
            end
        end
    end

    if stats then
        local function setStat(key, value)
            local s = stats:FindFirstChild(key)
            if s and s:FindFirstChild("Amount") then s.Amount.Text = tostring(value) end
        end
        setStat("Wins", Config.profile_wins)
        setStat("Kills", Config.profile_kills)
        setStat("Rap", Config.profile_rap)
    end

    -- achievements
    local ach = profile and profile:FindFirstChild("Achievements")
    local sc = ach and ach:FindFirstChild("Scrollingframe")
    local tpl = sc and sc:FindFirstChild("Template")
    if sc and tpl then
        for _, c in ipairs(sc:GetChildren()) do
            if c:IsA("Frame") and c ~= tpl then c:Destroy() end
        end
        local function addAch(title, desc, icon)
            local clone = tpl:Clone()
            clone.Name = "ZenthraAch"
            clone.Visible = true
            clone.Parent = sc
            if clone:FindFirstChild("Title") then clone.Title.Text = title end
            if clone:FindFirstChild("Description") then clone.Description.Text = desc end
            if clone:FindFirstChild("Icon") and icon then clone.Icon.Image = icon end
        end
        addAch("Time Played", Config.profile_time, "rbxassetid://15418299869")
        addAch("Games Played", Config.profile_matches, "rbxassetid://15418300727")
        addAch("Best Win Streak", Config.profile_best, "rbxassetid://15418301957")
    end

    -- customize card
    if customize then
        local title = customize:FindFirstChild("Title")
        if title then
            local td = getTitle(Config.profile_title)
            title.Text = td and td.Tag.Text or ""
            title.TextColor3 = td and td.Tag.Color or Color3.new(1, 1, 1)
            local stroke = title:FindFirstChild("UIStroke")
            if stroke then
                stroke.Color = td and td.Tag.Color:Darken(1) or Color3.new(0, 0, 0)
            end
        end
        local u = customize:FindFirstChild("Username")
        if u then u.Text = Config.profile_display end
        local pfp = customize:FindFirstChild("Pfp")
        if pfp and pfp:FindFirstChild("Avatar") then
            pfp.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(avatarId)
        end
        local kills = customize:FindFirstChild("Kills")
        if kills and kills:FindFirstChild("Amount") then
            kills.Amount.Text = string.format("%s Elims", Config.profile_kills)
            if kills:FindFirstChild("Shadow") then kills.Shadow.Text = kills.Amount.Text end
        end
        local wins = customize:FindFirstChild("Wins")
        if wins and wins:FindFirstChild("Amount") then
            wins.Amount.Text = string.format("%s Wins", Config.profile_wins)
            if wins:FindFirstChild("Shadow") then wins.Shadow.Text = wins.Amount.Text end
        end
    end
end

-- hook ProfileController.ViewProfile
task.spawn(function()
    for i = 1, 40 do
        local ok, ctrl = pcall(function()
            return require(ReplicatedStorage.Controllers:WaitForChild("PlayerProfileController", 10))
        end)
        if ok and ctrl and ctrl.ViewProfile and not ctrl.__zenthra_profile then
            ctrl.__zenthra_profile = true
            local og = ctrl.ViewProfile
            ctrl.ViewProfile = function(self, player, ...)
                og(self, player, ...)
                if not Config.profile_spoof or player ~= LP then return end
                task.defer(function()
                    for _ = 1, 8 do
                        pcall(spoofProfileView, player)
                        task.wait(0.15)
                    end
                end)
            end
            return
        end
        task.wait(0.5)
    end
end)

-- TextChat prefix spoof
if TextChatService then
    TextChatService.OnIncomingMessage = function(msg)
        local props = Instance.new("TextChatMessageProperties")
        if Config.profile_spoof and msg.TextSource and msg.TextSource.UserId == LP.UserId then
            local td = getTitle(Config.profile_title)
            if td and td.Tag then
                local color = td.Tag.Color
                local text = td.Tag.Text
                props.PrefixText = string.format("<font color='#%s'>[%s]</font> %s", color:ToHex(), text, msg.PrefixText or "")
            end
        end
        return props
    end
end

-- ═══════════════════════════════════════════════
-- RANK / ELO SPOOFER
-- ═══════════════════════════════════════════════

local rankSpoofer = {
    enabled       = false,
    hooked_replion = false,
    hooked_ranked = false,
    controller    = nil,
    seasonData    = nil,
    dataReplion   = nil,
    originals     = {},
}

local function getElo()
    local v = tonumber(Config.elo_value)
    if v then return math.max(0, math.floor(v)) end
    return 8000
end

local function fillModeTable(base, val)
    local out = type(base) == "table" and table.clone(base) or {}
    local sd = rankSpoofer.seasonData
    if sd and sd.Modes then
        for k in pairs(sd.Modes) do out[k] = val end
    else
        out.FFA = val out.Duel = val out.Duo = val
    end
    return out
end

local function fillSeasonTable(base, val)
    local out = type(base) == "table" and table.clone(base) or {}
    for k, v in pairs(out) do
        if type(k) == "string" and k:match("^Season%d+$") then
            out[k] = fillModeTable(v, val)
        end
    end
    return out
end

local function spoofEloResult(args, original)
    local elo = getElo()
    local n = #args
    if n >= 4 then return elo end
    if n == 3 then return fillModeTable(original, elo) end
    if n == 2 then return fillSeasonTable(original, elo) end
    if n == 1 then
        local out = type(original) == "table" and table.clone(original) or {}
        for k, v in pairs(out) do
            if type(k) == "string" then out[k] = fillSeasonTable(v, elo) end
        end
        return out
    end
    return original
end

-- hook Replion Data
local function hookReplion()
    if rankSpoofer.hooked_replion then return end
    task.spawn(function()
        for i = 1, 40 do
            local ok, replion = pcall(function()
                return require(ReplicatedStorage.Packages:WaitForChild("Replion", 5))
            end)
            if ok and replion and replion.Client then
                local ok2, Data = pcall(function()
                    return replion.Client:GetReplion("Data") or replion.Client:WaitReplion("Data")
                end)
                if ok2 and Data and not Data.__zenthra_elo then
                    Data.__zenthra_elo = true
                    rankSpoofer.dataReplion = Data
                    local og = Data.Get
                    rankSpoofer.originals.replionGet = og
                    Data.Get = function(self, key)
                        local r = og(self, key)
                        if not rankSpoofer.enabled then return r end
                        local path
                        if type(key) == "table" then path = key
                        elseif type(key) == "string" then path = { key }
                        else return r end
                        if path[1] ~= "Elo" then return r end
                        return spoofEloResult(path, r)
                    end
                    rankSpoofer.hooked_replion = true
                    return
                end
            end
            task.wait(0.5)
        end
    end)
end

-- hook PlayerData
local function hookPlayerData()
    task.spawn(function()
        for i = 1, 40 do
            local ok, pd = pcall(function()
                return require(ReplicatedStorage.Shared:WaitForChild("PlayerData", 5))
            end)
            if ok and type(pd) == "table" and not pd.__zenthra_elo then
                pd.__zenthra_elo = true
                local function patch(data)
                    if not rankSpoofer.enabled or type(data) ~= "table" then return data end
                    if data.UserId ~= LP.UserId then return data end
                    local out = table.clone(data)
                    out.Elo = getElo()
                    local ok2, rd = pcall(function()
                        return require(ReplicatedStorage.Shared:WaitForChild("RankData"))
                    end)
                    if ok2 and rd and rd.GetRank then
                        local rk = rd.GetRank(out.Elo)
                        if rk and rk.Name then out.Rank = rk.Name end
                    end
                    return out
                end
                if type(pd.RegisterPlayer) == "function" then
                    local og = pd.RegisterPlayer
                    pd.RegisterPlayer = function(self, data, ...)
                        return og(self, patch(data), ...)
                    end
                end
                if type(pd.CreateLabelFrom) == "function" then
                    local og = pd.CreateLabelFrom
                    pd.CreateLabelFrom = function(self, data, ...)
                        return og(self, patch(data), ...)
                    end
                end
                return
            end
            task.wait(0.5)
        end
    end)
end

-- patch RankedSelection UI
local function patchRankedUi()
    if not rankSpoofer.enabled then return end
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return end
    local rs = pg:FindFirstChild("RankedSelection")
    if not rs then return end
    local page = rs:FindFirstChild("Page")
    local windows = page and page:FindFirstChild("Windows")
    if not windows then return end
    local modes = windows:FindFirstChild("Gamemodes")
    local list = modes and modes:FindFirstChild("List")
    local elo = getElo()
    local ok, rd = pcall(function()
        return require(ReplicatedStorage.Shared:WaitForChild("RankData"))
    end)
    local rank = (ok and rd and rd.GetRank and rd.GetRank(elo)) or nil
    if list then
        for _, name in ipairs({ "FFA", "Duo", "Duel" }) do
            local entry = list:FindFirstChild(name)
            if entry then
                local top = entry:FindFirstChild("Top")
                if top and top:FindFirstChild("CurrentElo") then
                    top.CurrentElo.Text = string.format("%d Elo", elo)
                end
                local bottom = entry:FindFirstChild("Bottom")
                if bottom and bottom:FindFirstChild("PlayerRank") then
                    if rank then
                        bottom.PlayerRank.Text = rank.Name
                        if rank.TextColor then bottom.PlayerRank.TextColor3 = rank.TextColor end
                    end
                end
            end
        end
    end
end

-- hook RankedSelectionController
local function hookRankedController()
    if rankSpoofer.hooked_ranked then return end
    task.spawn(function()
        for i = 1, 40 do
            local ok, ctrl = pcall(function()
                return require(ReplicatedStorage.Controllers.UI:WaitForChild("RankedSelectionController", 5))
            end)
            if ok and type(ctrl) == "table" and type(ctrl._updateLocalElo) == "function" and not ctrl.__zenthra_elo then
                ctrl.__zenthra_elo = true
                local og = ctrl._updateLocalElo
                ctrl._updateLocalElo = function(self, ...)
                    og(self, ...)
                    if rankSpoofer.enabled then
                        task.defer(patchRankedUi)
                    end
                end
                rankSpoofer.controller = ctrl
                rankSpoofer.hooked_ranked = true
                return
            end
            task.wait(0.5)
        end
    end)
end

local rankApi = {}
function rankApi.start()
    rankSpoofer.enabled = true
    hookReplion()
    hookPlayerData()
    hookRankedController()
    task.defer(patchRankedUi)
end
function rankApi.stop()
    rankSpoofer.enabled = false
    pcall(patchRankedUi)
end
_G.__zenthraRank = rankApi

-- ═══════════════════════════════════════════════
-- hook Config to feature bindings
-- ═══════════════════════════════════════════════
task.delay(1, function()
    if Config.profile_spoof then
        -- nothing to pre-run; hook is passive
    end
    if Config.elo_spoof then
        rankApi.start()
    end
    if Config.custom_win_enabled then
        -- base file handles this
    end
end)

-- ═══════════════════════════════════════════════
-- PART 5 — FFLAGS + MEDIA SKYBOX + MEDIA MENU BACKGROUND
-- ═══════════════════════════════════════════════

-- ───── FFLAGS CORE ─────
local fflags = {
    initialized = false,
    _setflag    = setfflag or set_fflag or setfpsflag,
    _getflag    = getfflag or get_fflag or getfpsflag,
    _original_values = {},
    _custom_flags = nil,
    state = { flags_applied = false },
    persist_file = "zenthra_fflags/_keep_state.json",
    import_name = "",
    selected_region = "Off",
    selected_ping = "Off",
}

local function sanitizeFlagName(name)
    if type(name) ~= "string" then return name end
    return name:gsub("^DFInt", ""):gsub("^DFFlag", ""):gsub("^FFlag", "")
        :gsub("^FInt", ""):gsub("^DFString", ""):gsub("^FString", "")
end

-- fast load flags
local FAST_LOAD_FLAGS = {
    FFlagEnableQuickGameLaunch = "True",
    FStringGetPlayerImageDefaultTimeout = "30",
    DFIntNumAssetsMaxToPreload = "999999",
    DFFlagEnableMeshPreloading2 = "True",
    DFFlagPreloadImmediateLoadingScreenRemoval_IXP = "True",
    FFlagUserFastGameLoad = "True",
    FFlagFastLoadingAssets = "True",
    FFlagFixLoadingScreenNetworkingForAll = "True",
    FFlagDebugEnableFastPlay = "True",
    FFlagLuaAppUnmountPreviewVideoOnGameJoin = "True",
    DFIntCharacterLoadTime = "1",
    DFFlagEnableTexturePreloading = "True",
    DFFlagEnableSoundPreloading = "True",
    DFIntAssetPreloading = "2147483647",
    DFFlagTeleportClientAssetPreloadingEnabled9 = "True",
    DFFlagTeleportClientAssetPreloadingEnabledIXP = "True",
    DFFlagTeleportClientAssetPreloadingEnabledIXP2 = "True",
    DFIntBandwidthManagerApplicationDefaultBps = "2147483647",
    DFIntDataSenderMaxJoinBandwidthBps = "2147483647",
    FFlagBatchAssetApi = "True",
    DFIntCachedPatchLoadDelayMilliseconds = "1",
}

-- region presets
local REGION_PRESETS = {
    ["Frankfurt, Germany"] = { FStringPreferredRegion = "eu-central-1", FStringMatchmakingRegion = "eu-central-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    Ireland = { FStringPreferredRegion = "eu-west-1", FStringMatchmakingRegion = "eu-west-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["London, England"] = { FStringPreferredRegion = "eu-west-2", FStringMatchmakingRegion = "eu-west-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Paris, France"] = { FStringPreferredRegion = "eu-west-3", FStringMatchmakingRegion = "eu-west-3", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Northern Virginia"] = { FStringPreferredRegion = "us-east-1", FStringMatchmakingRegion = "us-east-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["US Central"] = { FStringPreferredRegion = "us-east-2", FStringMatchmakingRegion = "us-east-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    Ohio = { FStringPreferredRegion = "us-east-2", FStringMatchmakingRegion = "us-east-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Northern California"] = { FStringPreferredRegion = "us-west-1", FStringMatchmakingRegion = "us-west-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    Oregon = { FStringPreferredRegion = "us-west-2", FStringMatchmakingRegion = "us-west-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Tokyo, Japan"] = { FStringPreferredRegion = "ap-northeast-1", FStringMatchmakingRegion = "ap-northeast-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Seoul, South Korea"] = { FStringPreferredRegion = "ap-northeast-2", FStringMatchmakingRegion = "ap-northeast-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    Singapore = { FStringPreferredRegion = "ap-southeast-1", FStringMatchmakingRegion = "ap-southeast-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Sydney, Australia"] = { FStringPreferredRegion = "ap-southeast-2", FStringMatchmakingRegion = "ap-southeast-2", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["Mumbai, India"] = { FStringPreferredRegion = "ap-south-1", FStringMatchmakingRegion = "ap-south-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
    ["São Paulo, Brazil"] = { FStringPreferredRegion = "sa-east-1", FStringMatchmakingRegion = "sa-east-1", FFlagNetworkForceRegion = "True", FIntNetworkForcedPingOverride = "0" },
}

local REGION_ORDER = {
    "Off", "Frankfurt, Germany", "Ireland", "London, England", "Paris, France",
    "Northern Virginia", "US Central", "Ohio", "Northern California", "Oregon",
    "Tokyo, Japan", "Seoul, South Korea", "Singapore", "Sydney, Australia",
    "Mumbai, India", "São Paulo, Brazil",
}

-- ping optimization flags
local PING_FLAGS = {
    FFlagOptimizeNetwork = "True",
    FFlagOptimizeNetworkTransport = "True",
    FFlagOptimizeNetworkRouting = "True",
    FFlagOptimizeServerTickRate = "True",
    FFlagFixInputDelay = "True",
    FFlagUserMovementPredictionFix = "True",
    DFIntServerPhysicsUpdateRate = "-1",
    DFIntS2PhysicsSenderRate = "240",
    DFIntDataSenderRate = "256",
    DFIntSmoothNetPhysicsSendRate = "60",
    DFIntSmoothNetPhysicsMaxSendRate = "60",
    DFIntReplicationResendRate = "60",
    DFIntPlayerNetworkUpdateRate = "60",
    DFIntPlayerNetworkUpdateQueueSize = "1",
    DFIntMegaReplicatorNetworkQualityProcessorUnit = "10",
    DFIntInterpolationMinAssemblyCount = "1",
    DFIntInterpolationTimeMs = "2",
    FIntInterpolationMaxDelayMSec = "0",
    DFIntNetworkLatencyTolerance = "10",
    DFIntMinimalNetworkPrediction = "1",
    DFIntClientPacketMaxDelayMs = "10",
    DFIntClientPacketHealthyAllocationPercent = "50",
    DFIntMaxAcceptableUpdateDelay = "1",
    DFIntMaxProcessPacketsStepsPerCyclic = "2147483647",
    DFIntMaxProcessPacketsJobScaling = "2147483647",
    DFIntRaknetBandwidthPingSendEveryXSeconds = "-1",
    DFIntRakNetPingFrequencyMillisecond = "2147483647",
    DFIntOptimizePingThreshold = "-1",
    DFIntCodecMaxOutgoingFrames = "2147483647",
    DFIntCodecMaxIncomingPackets = "2147483647",
    DFIntCliMaxChRcv = "2147483647",
    DFIntCliMaxChSnd = "2147483647",
    DFIntMaxDataPayloadSize = "2147483647",
    DFIntMaxFramesToSend = "-1",
    DFIntBandwidthManagerDataSenderMaxWorkCatchupMs = "5",
    DFIntRakNetUseSlidingWindow2_minRtt = "1000000",
    DFIntRakNetMinAckGrowthPercent = "100",
    DFIntRakNetLoopMs = "0",
    DFIntWaitOnUpdateNetworkLoopEndedMS = "100",
    DFIntWaitOnRecvFromLoopEndedMS = "100",
    DFIntLargePacketQueueSizeCutoffMB = "1000",
    DFIntMaxFrameBufferSize = "4",
}

local function buildRegionFlags(regionName)
    local base = REGION_PRESETS[regionName]
    if not base then return nil end
    local out = {}
    for k, v in pairs(base) do out[k] = v end
    for k, v in pairs(FAST_LOAD_FLAGS) do out[k] = v end
    return out
end

local function buildApplyFlags()
    local out = {}
    if fflags.selected_region and fflags.selected_region ~= "Off" then
        local regionFlags = buildRegionFlags(fflags.selected_region)
        if regionFlags then
            for k, v in pairs(regionFlags) do out[k] = v end
        end
    end
    if fflags.selected_ping == "Ping Boost" then
        for k, v in pairs(PING_FLAGS) do out[k] = v end
    end
    return out
end

-- ───── apply flags with progress UI ─────
local function applyFlags(flags, rejoin, showUi)
    local setflag = fflags._setflag
    if not setflag then
        warn("[Zenthra] No setfflag available in this executor.")
        return 0, 0
    end
    local getflag = fflags._getflag

    -- progress UI
    local ScreenGui, progressFill, progressLabel, successLabel, failedLabel, closeFn
    if showUi then
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "ZenthraFFlags"
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.DisplayOrder = 9999
        local hui
        pcall(function() hui = gethui and gethui() end)
        ScreenGui.Parent = hui or CoreGui

        local bg = Instance.new("Frame")
        bg.Size = UDim2.fromOffset(420, 200)
        bg.Position = UDim2.fromScale(0.5, 0.5)
        bg.AnchorPoint = Vector2.new(0.5, 0.5)
        bg.BackgroundColor3 = Palette.bg
        bg.BorderSizePixel = 0
        bg.Parent = ScreenGui
        corner(12).Parent = bg
        stroke(Palette.stroke, 1, 0).Parent = bg

        local title = label("APPLYING FFLAGS", 14, Palette.accent, {
            Size = UDim2.new(1, -40, 0, 20), Position = UDim2.fromOffset(20, 16),
            Font = Enum.Font.GothamBold,
        })
        title.Parent = bg

        local sub = label("Zenthra - Fast Flags", 11, Palette.sub, {
            Size = UDim2.new(1, -40, 0, 14), Position = UDim2.fromOffset(20, 36),
        })
        sub.Parent = bg

        local barBg = Instance.new("Frame")
        barBg.Size = UDim2.new(1, -40, 0, 8)
        barBg.Position = UDim2.fromOffset(20, 60)
        barBg.BackgroundColor3 = Palette.surface2
        barBg.BorderSizePixel = 0
        barBg.Parent = bg
        corner(4).Parent = barBg

        progressFill = Instance.new("Frame")
        progressFill.Size = UDim2.new(0, 0, 1, 0)
        progressFill.BackgroundColor3 = Palette.accent
        progressFill.BorderSizePixel = 0
        progressFill.Parent = barBg
        corner(4).Parent = progressFill

        progressLabel = label("Initializing...", 11, Palette.sub, {
            Size = UDim2.new(0.6, -20, 0, 14), Position = UDim2.fromOffset(20, 78),
        })
        progressLabel.Parent = bg

        local pct = label("0%", 11, Palette.text, {
            Size = UDim2.new(0.4, -20, 0, 14), Position = UDim2.new(0.6, 0, 0, 78),
            TextXAlignment = Enum.TextXAlignment.Right,
        })
        pct.Parent = bg

        -- success/fail cards
        local successCard = Instance.new("Frame")
        successCard.Size = UDim2.new(0.5, -6, 0, 68)
        successCard.Position = UDim2.fromOffset(20, 105)
        successCard.BackgroundColor3 = Palette.surface2
        successCard.BorderSizePixel = 0
        successCard.Parent = bg
        corner(8).Parent = successCard
        label("SUCCESS", 10, Palette.sub, { Size = UDim2.new(1, -20, 0, 14), Position = UDim2.fromOffset(10, 10) }).Parent = successCard
        successLabel = label("0", 24, Palette.accent, { Size = UDim2.new(1, -20, 0, 30), Position = UDim2.fromOffset(10, 26), Font = Enum.Font.GothamBold })
        successLabel.Parent = successCard

        local failCard = Instance.new("Frame")
        failCard.Size = UDim2.new(0.5, -6, 0, 68)
        failCard.Position = UDim2.new(0.5, 6, 0, 105)
        failCard.BackgroundColor3 = Palette.surface2
        failCard.BorderSizePixel = 0
        failCard.Parent = bg
        corner(8).Parent = failCard
        label("FAILED", 10, Palette.sub, { Size = UDim2.new(1, -20, 0, 14), Position = UDim2.fromOffset(10, 10) }).Parent = failCard
        failedLabel = label("0", 24, Palette.sub, { Size = UDim2.new(1, -20, 0, 30), Position = UDim2.fromOffset(10, 26), Font = Enum.Font.GothamBold })
        failedLabel.Parent = failCard

        closeFn = function()
            if ScreenGui then ScreenGui:Destroy() end
        end
    end

    local total = 0
    for _ in pairs(flags) do total += 1 end
    local success, failed = 0, 0
    local failed_list = {}
    local count = 0

    for k, v in pairs(flags) do
        count += 1
        task.wait(0.005)
        local ok = pcall(function()
            local clean = sanitizeFlagName(k)
            if getflag then
                pcall(function()
                    local orig = getflag(clean)
                    if orig ~= nil and fflags._original_values[clean] == nil then
                        fflags._original_values[clean] = tostring(orig)
                    end
                end)
            end
            setflag(clean, tostring(v))
            success += 1
        end)
        if not ok then
            failed += 1
            table.insert(failed_list, { flag = k, value = v })
        end
        if showUi and progressFill then
            local p = count / total
            progressFill.Size = UDim2.fromScale(p, 1)
            if progressLabel then progressLabel.Text = k:sub(1, 35) end
            if successLabel then successLabel.Text = tostring(success) end
            if failedLabel then failedLabel.Text = tostring(failed) end
        end
        if count % 5 == 0 then RunService.Heartbeat:Wait() end
    end

    -- retry failed
    if #failed_list > 0 then
        if showUi and progressLabel then progressLabel.Text = "Retrying failed flags..." end
        task.wait(0.5)
        for _, f in ipairs(failed_list) do
            task.wait(0.05)
            local ok = pcall(function()
                setflag(sanitizeFlagName(f.flag), tostring(f.value))
                success += 1
                failed -= 1
            end)
        end
    end

    if showUi then
        if progressFill then progressFill.Size = UDim2.fromScale(1, 1) end
        if progressLabel then progressLabel.Text = rejoin and "Complete! Rejoining..." or "Complete!" end
    end

    fflags.state.flags_applied = true

    -- save persist
    pcall(function()
        if not isfolder("zenthra_fflags") then makefolder("zenthra_fflags") end
        writefile(fflags.persist_file, HttpService:JSONEncode({
            keep_applied = false,
            last_region = fflags.selected_region,
            last_ping = fflags.selected_ping,
        }))
    end)

    if rejoin then
        task.wait(1.5)
        if showUi and closeFn then closeFn() end
        task.wait(0.5)
        pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
        task.wait(1)
        pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
    elseif showUi then
        task.wait(2)
        if closeFn then closeFn() end
    end

    return success, failed, total
end

local function restoreFlags()
    if not fflags._setflag then return end
    for k, v in pairs(fflags._original_values) do
        pcall(function() fflags._setflag(k, v) end)
    end
    fflags.state.flags_applied = false
    pcall(function() writefile(fflags.persist_file, "{}") end)
end

-- ───── FFLAGS UI tab ─────
local function buildFFlagsTab()
    local miscTab = win.Tabs and win.Tabs["Misc"]
    if not miscTab then return end
    local sec = UI.Section(miscTab.page, "FFlags")
    UI.Toggle(sec, "Enabled", Config.zenthra_fflags == true, function(v)
        Config.zenthra_fflags = v
        if not v then
            restoreFlags()
        end
    end)
    UI.Dropdown(sec, "Region", REGION_ORDER, "Off", function(v)
        fflags.selected_region = v
    end)
    UI.Dropdown(sec, "Ping Optimization", { "Off", "Ping Boost" }, "Off", function(v)
        fflags.selected_ping = v
    end)
    UI.Button(sec, "Apply FFlags & Rejoin", function()
        local flags = buildApplyFlags()
        if next(flags) == nil then
            tbl17 = nil
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "FFlags", Text = "Pick a Region or Ping option first!", Duration = 3,
                })
            end)
            return
        end
        task.spawn(function() applyFlags(flags, true, true) end)
    end)
    UI.Button(sec, "Apply (no rejoin)", function()
        local flags = buildApplyFlags()
        if next(flags) == nil then return end
        task.spawn(function() applyFlags(flags, false, true) end)
    end)

    -- custom preset section
    UI.TextBox(sec, "Preset Name", "my preset", "", function(v) fflags.import_name = v end)
    local presetOptions = { "Default" }
    local presetDropdown = UI.Dropdown(sec, "Preset", presetOptions, "Default", function(v)
        if v == "Default" then fflags._custom_flags = nil return end
        local ok, data = pcall(function() return readfile("zenthra_fflags/" .. v .. ".json") end)
        if ok and data then
            local ok2, parsed = pcall(function() return HttpService:JSONDecode(data) end)
            if ok2 then fflags._custom_flags = parsed end
        end
    end)

    local function refreshPresets()
        local out = { "Default" }
        pcall(function()
            if isfolder("zenthra_fflags") then
                for _, f in ipairs(listfiles("zenthra_fflags")) do
                    local m = f:match("([^/\\]+)%.json$")
                    if m and m ~= "Default" and m ~= "_keep_state" then
                        table.insert(out, m)
                    end
                end
            end
        end)
        return out
    end

    UI.Button(sec, "Refresh Presets", function()
        if presetDropdown and presetDropdown.Set then end
    end)

    UI.TextBox(sec, "Paste JSON", "paste FFlags JSON here", "", function(json)
        if not json or json == "" then return end
        if fflags.import_name == "" then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "FFlags", Text = "Set Preset Name first!", Duration = 3,
                })
            end)
            return
        end
        local ok, parsed = pcall(function() return HttpService:JSONDecode(json) end)
        if not ok or type(parsed) ~= "table" then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "FFlags", Text = "Invalid JSON", Duration = 3,
                })
            end)
            return
        end
        pcall(function()
            if not isfolder("zenthra_fflags") then makefolder("zenthra_fflags") end
            writefile("zenthra_fflags/" .. fflags.import_name .. ".json", json)
        end)
        fflags._custom_flags = parsed
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "FFlags", Text = "Saved preset: " .. fflags.import_name, Duration = 3,
            })
        end)
    end)

    UI.Button(sec, "Delete Selected Preset", function()
        local name = fflags.import_name
        if name == "" or name == "Default" then return end
        pcall(function()
            if isfile("zenthra_fflags/" .. name .. ".json") then
                delfile("zenthra_fflags/" .. name .. ".json")
            end
        end)
    end)
end

buildFFlagsTab()

-- ═══════════════════════════════════════════════
-- MEDIA SKYBOX (image or GIF as sky)
-- ═══════════════════════════════════════════════

local mediaSkybox = {
    active = false,
    generation = 0,
    original = nil,
    preload = nil,
    base_url = "http://prem-eu4.bot-hosting.net:20448",
    folder = "Zenthra/skybox",
    frames = {},
    current_frame = 0,
    frame_delay = 0.1,
}

local function getCustomAsset(path)
    if typeof(getcustomasset) == "function" then
        local ok, r = pcall(getcustomasset, path)
        if ok then return r end
    end
    if typeof(getsynasset) == "function" then
        local ok, r = pcall(getsynasset, path)
        if ok then return r end
    end
    if syn and typeof(syn.getcustomasset) == "function" then
        local ok, r = pcall(syn.getcustomasset, path)
        if ok then return r end
    end
    return nil
end

local function base64Encode(data)
    if crypt and typeof(crypt.base64encode) == "function" then
        return crypt.base64encode(data)
    end
    if crypt and crypt.base64 and typeof(crypt.base64.encode) == "function" then
        return crypt.base64.encode(data)
    end
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local out = {}
    for i = 1, #data, 3 do
        local a, b2, c = data:byte(i, i + 2)
        local n = a * 65536 + (b2 or 0) * 256 + (c or 0)
        out[#out + 1] = b:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        out[#out + 1] = b:sub(math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        out[#out + 1] = b2 and b:sub(math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "="
        out[#out + 1] = c and b:sub(n % 64 + 1, n % 64 + 1) or "="
    end
    return table.concat(out)
end

local function httpGet(url, binary)
    local requestFn = http_request or request or (syn and syn.request)
    if typeof(requestFn) == "function" then
        local ok, resp = pcall(requestFn, { Url = url, Method = "GET" })
        if ok and resp and resp.Body then return resp.Body end
    end
    local ok, body = pcall(function() return game:HttpGet(url, true) end)
    if ok then return body end
    return nil
end

local function sniffExt(data)
    if type(data) ~= "string" or #data < 12 then return nil end
    if data:sub(1, 8) == "\137PNG\r\n\26\n" then return "png" end
    if data:byte(1) == 255 and data:byte(2) == 216 then return "jpg" end
    if data:sub(1, 4) == "GIF8" then return "gif" end
    if data:sub(1, 4) == "RIFF" and data:sub(9, 12) == "WEBP" then return "webp" end
    if data:sub(1, 2) == "BM" then return "bmp" end
    return nil
end

local function ensureSkyFolder()
    pcall(function()
        if not isfolder("Zenthra") then makefolder("Zenthra") end
        if not isfolder(mediaSkybox.folder) then makefolder(mediaSkybox.folder) end
    end)
end

local function listSavedSkyboxes()
    local out = { "None" }
    pcall(function()
        if isfolder(mediaSkybox.folder) then
            for _, f in ipairs(listfiles(mediaSkybox.folder)) do
                local name = f:match("([^/\\]+)$")
                if name and not name:lower():match("%.f%d+%.%w+$") and not name:lower():match("%.json$") then
                    local ext = name:match("%.(%w+)$")
                    if ext then
                        local e = ext:lower()
                        if e == "png" or e == "jpg" or e == "jpeg" or e == "bmp" or e == "gif" then
                            table.insert(out, name)
                        end
                    end
                end
            end
        end
    end)
    return out
end

local function resetSky()
    mediaSkybox.generation += 1
    if mediaSkybox.conn then mediaSkybox.conn:Disconnect() mediaSkybox.conn = nil end
    for _, c in ipairs(Lighting:GetChildren()) do
        if c:IsA("Sky") and c.Name ~= "ZenthraMediaSky" then
            -- restore original
            if mediaSkybox.original then
                c.SkyboxBk = mediaSkybox.original[1] or ""
                c.SkyboxDn = mediaSkybox.original[2] or ""
                c.SkyboxFt = mediaSkybox.original[3] or ""
                c.SkyboxLf = mediaSkybox.original[4] or ""
                c.SkyboxRt = mediaSkybox.original[5] or ""
                c.SkyboxUp = mediaSkybox.original[6] or ""
            end
        end
    end
    local m = Lighting:FindFirstChild("ZenthraMediaSky")
    if m then m:Destroy() end
    if mediaSkybox.preload then
        pcall(function() mediaSkybox.preload:Destroy() end)
        mediaSkybox.preload = nil
    end
    mediaSkybox.active = false
    mediaSkybox.frames = {}
end

local function captureOriginalSky()
    if mediaSkybox.original then return end
    local s = Lighting:FindFirstChildOfClass("Sky")
    if s and s.Name ~= "ZenthraMediaSky" then
        mediaSkybox.original = { s.SkyboxBk, s.SkyboxDn, s.SkyboxFt, s.SkyboxLf, s.SkyboxRt, s.SkyboxUp }
    end
end

local function setAllFaces(sky, image)
    sky.SkyboxBk = image
    sky.SkyboxDn = image
    sky.SkyboxFt = image
    sky.SkyboxLf = image
    sky.SkyboxRt = image
    sky.SkyboxUp = image
end

local function applyMediaSkybox(name)
    resetSky()
    captureOriginalSky()
    if not name or name == "None" or name == "" then return end
    local myGen = mediaSkybox.generation
    mediaSkybox.active = true

    local path = mediaSkybox.folder .. "/" .. name
    local manifest = path .. ".json"
    local data = nil
    if isfile(manifest) then
        local ok, raw = pcall(readfile, manifest)
        if ok then
            local ok2, parsed = pcall(function() return HttpService:JSONDecode(raw) end)
            if ok2 then data = parsed end
        end
    end

    -- ensure sky object
    local sky = Lighting:FindFirstChild("ZenthraMediaSky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Name = "ZenthraMediaSky"
        sky.Parent = Lighting
    end
    for _, c in ipairs(Lighting:GetChildren()) do
        if c:IsA("Sky") and c ~= sky then c.Parent = nil end
    end

    if not data or not data.frames then
        -- single image
        local assetUrl = getCustomAsset(path)
        if not assetUrl then return end
        setAllFaces(sky, assetUrl)
        return
    end

    -- animated (frames)
    local frames = {}
    for _, frame in ipairs(data.frames) do
        local url = getCustomAsset(mediaSkybox.folder .. "/" .. frame)
        if url then table.insert(frames, url) end
    end
    if #frames == 0 then return end
    mediaSkybox.frames = frames
    mediaSkybox.current_frame = 1
    mediaSkybox.frame_delay = math.max(0.03, (tonumber(data.delayMs) or 100) / 1000)

    -- preload
    local folder = Instance.new("Folder")
    folder.Name = "ZenthraMediaSkyPreload"
    folder.Parent = ReplicatedStorage
    mediaSkybox.preload = folder
    for _, url in ipairs(frames) do
        local img = Instance.new("ImageLabel")
        img.Image = url
        img.Size = UDim2.fromOffset(1, 1)
        img.BackgroundTransparency = 1
        img.ImageTransparency = 0.996
        img.Parent = folder
    end

    setAllFaces(sky, frames[1])

    mediaSkybox.conn = RunService.Heartbeat:Connect(function()
        if not mediaSkybox.active or mediaSkybox.generation ~= myGen then return end
        mediaSkybox._accum = (mediaSkybox._accum or 0) + (1/60)
        if mediaSkybox._accum < mediaSkybox.frame_delay then return end
        mediaSkybox._accum = 0
        mediaSkybox.current_frame = mediaSkybox.current_frame % #frames + 1
        setAllFaces(sky, frames[mediaSkybox.current_frame])
    end)
end

local function downloadMediaSkybox(url, saveName)
    if not url or url == "" then return false, "Empty URL" end
    ensureSkyFolder()
    local base = mediaSkybox.base_url
    if not base or not base:match("^https?://") then
        return false, "API unavailable"
    end

    local data = httpGet(url, true)
    if not data or #data < 100 then return false, "Download failed" end

    local ext = sniffExt(data) or "png"
    local name = (saveName ~= "" and saveName or ("sky_" .. os.time())):gsub("[^%w_%-%.]", "_")
    name = name:gsub("%.%w+$", "")

    -- try API first
    local encoded = base64Encode(data)
    local body = HttpService:JSONEncode({ data = encoded, name = url:match("([^/\\?]+)%.[%w]+$") or "media.png" })
    local requestFn = http_request or request or (syn and syn.request)
    if typeof(requestFn) == "function" then
        local ok, resp = pcall(requestFn, {
            Url = base .. "/sheet?multi=1&quality=original&fmt=jpg&format=json",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = body,
        })
        if ok and resp and resp.Body then
            local ok2, parsed = pcall(function() return HttpService:JSONDecode(resp.Body) end)
            if ok2 and parsed and parsed.ok and parsed.images and #parsed.images > 0 then
                -- decode and save
                local decode = crypt and crypt.base64decode or (crypt and crypt.base64 and crypt.base64.decode)
                local frames = {}
                for k, b64 in ipairs(parsed.images) do
                    local bin = decode and decode(b64) or nil
                    if bin then
                        local fname = name .. (k == 1 and "" or (".f" .. k)) .. "." .. (parsed.ext or ext)
                        pcall(function() writefile(mediaSkybox.folder .. "/" .. fname, bin) end)
                        table.insert(frames, fname)
                    end
                end
                if #frames > 0 then
                    pcall(function()
                        writefile(mediaSkybox.folder .. "/" .. frames[1] .. ".json", HttpService:JSONEncode({
                            count = parsed.count or #frames,
                            delayMs = parsed.delayMs or 100,
                            frames = frames,
                        }))
                    end)
                    return true, frames[1]
                end
            end
        end
    end

    -- fallback: save raw
    local fname = name .. "." .. ext
    local ok = pcall(function() writefile(mediaSkybox.folder .. "/" .. fname, data) end)
    if ok then return true, fname end
    return false, "Write failed"
end

local function buildMediaSkyboxUI()
    local worldTab = win.Tabs and win.Tabs["World"]
    if not worldTab then return end
    local sec = UI.Section(worldTab.page, "Media Skybox")
    UI.Toggle(sec, "Enabled", Config.media_skybox == true, function(v)
        Config.media_skybox = v
        if v then
            applyMediaSkybox(Config.media_skybox_pick or "None")
        else
            resetSky()
        end
    end)
    local skyOpts = listSavedSkyboxes()
    local dd = UI.Dropdown(sec, "Skybox Media", skyOpts, Config.media_skybox_pick or "None", function(v)
        Config.media_skybox_pick = v
        if Config.media_skybox then applyMediaSkybox(v) end
    end)
    UI.TextBox(sec, "Media URL", "https://example.com/sky.gif", Config.media_skybox_url or "", function(v)
        Config.media_skybox_url = v
    end)
    UI.TextBox(sec, "Save As Name", "my sky", Config.media_skybox_save or "", function(v)
        Config.media_skybox_save = v
    end)
    UI.Button(sec, "Download & Save", function()
        task.spawn(function()
            local ok, nameOrErr = downloadMediaSkybox(Config.media_skybox_url, Config.media_skybox_save)
            if ok then
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Media Skybox", Text = "Saved " .. tostring(nameOrErr), Duration = 3,
                    })
                end)
                Config.media_skybox_pick = nameOrErr
                -- rebuild dropdown list by setting options
                if dd and dd.Set then dd:Set(nameOrErr) end
                if Config.media_skybox then applyMediaSkybox(nameOrErr) end
            else
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Media Skybox", Text = tostring(nameOrErr), Duration = 4,
                    })
                end)
            end
        end)
    end)
    UI.Button(sec, "Delete Selected", function()
        local name = Config.media_skybox_pick
        if not name or name == "None" then return end
        pcall(function()
            -- delete frames + manifest
            if isfile(mediaSkybox.folder .. "/" .. name .. ".json") then
                local ok, raw = pcall(readfile, mediaSkybox.folder .. "/" .. name .. ".json")
                if ok then
                    local ok2, parsed = pcall(function() return HttpService:JSONDecode(raw) end)
                    if ok2 and parsed and parsed.frames then
                        for _, f in ipairs(parsed.frames) do
                            pcall(function() delfile(mediaSkybox.folder .. "/" .. f) end)
                        end
                    end
                end
                delfile(mediaSkybox.folder .. "/" .. name .. ".json")
            end
            delfile(mediaSkybox.folder .. "/" .. name)
        end)
        resetSky()
    end)
    UI.Button(sec, "Refresh List", function()
        -- re-create list
        Config.media_skybox_pick = "None"
    end)
end

buildMediaSkyboxUI()

-- auto-apply if enabled at start
task.delay(2, function()
    if Config.media_skybox and Config.media_skybox_pick and Config.media_skybox_pick ~= "None" then
        applyMediaSkybox(Config.media_skybox_pick)
    end
end)

-- hook Lighting child add so nothing overwrites our sky
Lighting.ChildAdded:Connect(function(c)
    if not Config.media_skybox or not mediaSkybox.active then return end
    if c:IsA("Sky") and c.Name ~= "ZenthraMediaSky" then
        task.delay(0.2, function()
            if mediaSkybox.active then c.Parent = nil end
        end)
    end
end)

-- ═══════════════════════════════════════════════
-- MEDIA MENU BACKGROUND (image behind UI)
-- ═══════════════════════════════════════════════

local menuBg = {
    active = false,
    folder = "Zenthra/backgrounds",
    base_url = "http://prem-eu4.bot-hosting.net:20448",
    current_img = nil,
    opacity = 0.5,
}

local function ensureBgFolder()
    pcall(function()
        if not isfolder("Zenthra") then makefolder("Zenthra") end
        if not isfolder(menuBg.folder) then makefolder(menuBg.folder) end
    end)
end

local function listSavedBackgrounds()
    local out = { "None" }
    pcall(function()
        if isfolder(menuBg.folder) then
            for _, f in ipairs(listfiles(menuBg.folder)) do
                local name = f:match("([^/\\]+)$")
                if name then
                    local ext = name:match("%.(%w+)$")
                    if ext then
                        local e = ext:lower()
                        if e == "png" or e == "jpg" or e == "jpeg" or e == "bmp" or e == "gif" then
                            table.insert(out, name)
                        end
                    end
                end
            end
        end
    end)
    return out
end

local function applyMenuBg(name)
    -- remove existing
    if menuBg.current_img then
        pcall(function() menuBg.current_img:Destroy() end)
        menuBg.current_img = nil
    end
    if not name or name == "None" or name == "" then
        menuBg.active = false
        return
    end
    local path = menuBg.folder .. "/" .. name
    local url = getCustomAsset(path)
    if not url then return end

    -- insert as background of main frame
    local img = Instance.new("ImageLabel")
    img.Name = "ZenthraMenuBg"
    img.Size = UDim2.fromScale(1, 1)
    img.BackgroundTransparency = 1
    img.Image = url
    img.ScaleType = Enum.ScaleType.Crop
    img.ImageTransparency = 1 - menuBg.opacity
    img.ZIndex = 0
    img.Parent = win.main
    -- send to back
    pcall(function()
        img.Parent = win.main
    end)
    -- we need to insert below the topbar so the sidebar/topbar are visible
    -- trick: we can set ZIndex on other children
    menuBg.current_img = img
    menuBg.active = true
end

local function setMenuBgOpacity(v)
    menuBg.opacity = math.clamp(v or 0.5, 0, 1)
    if menuBg.current_img then
        menuBg.current_img.ImageTransparency = 1 - menuBg.opacity
    end
end

local function downloadMenuBg(url, saveName)
    if not url or url == "" then return false, "Empty URL" end
    ensureBgFolder()
    local data = httpGet(url, true)
    if not data or #data < 100 then return false, "Download failed" end
    local ext = sniffExt(data) or "png"
    local name = (saveName ~= "" and saveName or ("bg_" .. os.time())):gsub("[^%w_%-%.]", "_"):gsub("%.%w+$", "") .. "." .. ext
    local ok = pcall(function() writefile(menuBg.folder .. "/" .. name, data) end)
    if ok then return true, name end
    return false, "Write failed"
end

local function buildMenuBgUI()
    local guiTab = win.Tabs and win.Tabs["Misc"]
    if not guiTab then return end
    local sec = UI.Section(guiTab.page, "Menu Background")
    UI.Toggle(sec, "Enabled", Config.menu_bg == true, function(v)
        Config.menu_bg = v
        if v then
            applyMenuBg(Config.menu_bg_pick or "None")
        else
            applyMenuBg("None")
        end
    end)
    local dd = UI.Dropdown(sec, "Image", listSavedBackgrounds(), Config.menu_bg_pick or "None", function(v)
        Config.menu_bg_pick = v
        if Config.menu_bg then applyMenuBg(v) end
    end)
    UI.Slider(sec, "Opacity", 0, 1, menuBg.opacity, 2, function(v)
        setMenuBgOpacity(v)
    end)
    UI.TextBox(sec, "Media URL", "https://...", Config.menu_bg_url or "", function(v)
        Config.menu_bg_url = v
    end)
    UI.TextBox(sec, "Save As", "my bg", Config.menu_bg_save or "", function(v)
        Config.menu_bg_save = v
    end)
    UI.Button(sec, "Download & Save", function()
        task.spawn(function()
            local ok, nameOrErr = downloadMenuBg(Config.menu_bg_url, Config.menu_bg_save)
            if ok then
                Config.menu_bg_pick = nameOrErr
                if dd and dd.Set then dd:Set(nameOrErr) end
                if Config.menu_bg then applyMenuBg(nameOrErr) end
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Menu Background", Text = "Saved " .. tostring(nameOrErr), Duration = 3,
                    })
                end)
            else
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Menu Background", Text = tostring(nameOrErr), Duration = 4,
                    })
                end)
            end
        end)
    end)
    UI.Button(sec, "Delete Selected", function()
        local name = Config.menu_bg_pick
        if not name or name == "None" then return end
        pcall(function() delfile(menuBg.folder .. "/" .. name) end)
        applyMenuBg("None")
    end)
end

buildMenuBgUI()

task.delay(2, function()
    if Config.menu_bg and Config.menu_bg_pick and Config.menu_bg_pick ~= "None" then
        applyMenuBg(Config.menu_bg_pick)
        setMenuBgOpacity(menuBg.opacity)
    end
end)

-- ═══════════════════════════════════════════════
-- PART 6 — PLUSHIES + ORBIT + FOLLOW + IMMORTAL + MISC (FINAL)
-- ═══════════════════════════════════════════════

-- ───── PLUSHIES ─────
local plushies = {
    active       = false,
    types        = {},
    folder       = nil,
    conn         = nil,
    loaded       = {},
    child_map    = {},
    models = {
        Reimu   = "rbxassetid://17657672380",
        Youmou  = "rbxassetid://13242826151",
        Shion   = "rbxassetid://12124164278",
        Yuuka   = "rbxassetid://12181667428",
        Flandre = "rbxassetid://12136125365",
        Ayanami = "rbxassetid://11965563704",
        Padoru  = "rbxassetid://11905337091",
    },
    scales = { Reimu=1.5, Youmou=2.3, Shion=2.3, Yuuka=1.5, Flandre=3.3, Ayanami=1.5, Padoru=1.5 },
    rotations = {
        Reimu   = CFrame.Angles(0, math.rad(0), 0),
        Youmou  = CFrame.Angles(0, math.rad(-90), 0),
        Shion   = CFrame.Angles(math.rad(110), 0, math.rad(150)),
        Yuuka   = CFrame.Angles(math.rad(-90), math.rad(180), 0),
        Flandre = CFrame.Angles(0, math.rad(-40), 0),
        Ayanami = CFrame.Angles(0, 0, 0),
        Padoru  = CFrame.Angles(0, 0, 1),
    },
    positions = {
        Vector3.new(2.5, 2, 0), Vector3.new(-2.5, 2, 0),
        Vector3.new(0, 4, 2.5), Vector3.new(0, 4, -2.5),
        Vector3.new(2.5, 2, 2.5), Vector3.new(-2.5, 2, 2.5),
        Vector3.new(2.5, 2, -2.5),
    },
}

local function createPlushie(name)
    local assetId = plushies.models[name]
    if not assetId then return nil end
    if not plushies.loaded[name] then
        local ok, obj = pcall(function() return game:GetObjects(assetId)[1] end)
        if not ok or not obj then return nil end
        plushies.loaded[name] = obj
    end
    local clone = plushies.loaded[name]:Clone()
    clone.Name = name
    local scale = plushies.scales[name] or 1.5
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("MeshPart") then
            d.CanCollide = false
            d.Anchored = false
            d.Size = d.Size * scale
            local m = d:FindFirstChildOfClass("SpecialMesh")
            if m then m.Scale = m.Scale * scale end
        end
    end
    local primary = clone:FindFirstChildOfClass("BasePart") or clone:FindFirstChildOfClass("MeshPart")
    if primary then clone.PrimaryPart = primary end
    return clone
end

local function updatePlushies()
    if not plushies.active then return end
    if not throttleVisual("plushies", 0.033) then return end
    local char = LP.Character
    local root = char and char.PrimaryPart
    if not root or not plushies.folder then return end

    for name in pairs(plushies.child_map) do plushies.child_map[name] = nil end
    for _, c in ipairs(plushies.folder:GetChildren()) do plushies.child_map[c.Name] = c end

    local bob = Vector3.new(0, math.sin(os.clock() * 2) * 0.3, 0)
    local idx = 1
    for name in pairs(plushies.types) do
        local offset = plushies.positions[(idx - 1) % #plushies.positions + 1]
        local model = plushies.child_map[name]
        if not model then
            local created = createPlushie(name)
            if created then
                created.Parent = plushies.folder
                created:PivotTo(CFrame.new(root.Position + offset))
                plushies.child_map[name] = created
                model = created
            end
        end
        if model and model.PrimaryPart then
            local bp = model.PrimaryPart:FindFirstChild("PlushieBP")
            if not bp then
                bp = Instance.new("BodyPosition")
                bp.Name = "PlushieBP"
                bp.MaxForce = Vector3.new(40000, 40000, 40000)
                bp.P = 10000
                bp.D = 1000
                bp.Parent = model.PrimaryPart
            end
            local target = root.CFrame * CFrame.new(offset + bob) * (plushies.rotations[name] or CFrame.new())
            bp.Position = target.Position
            model:PivotTo(CFrame.new(model:GetPivot().Position) * target.Rotation)
        end
        idx += 1
    end
    for name, model in pairs(plushies.child_map) do
        if not plushies.types[name] then
            model:Destroy()
            plushies.child_map[name] = nil
        end
    end
end

local plushiesApi = {}
function plushiesApi.start()
    if plushies.active then return end
    plushies.active = true
    plushies.folder = Instance.new("Folder")
    plushies.folder.Name = "ZenthraPlushies"
    plushies.folder.Parent = Workspace
    plushies.conn = RunService.RenderStepped:Connect(updatePlushies)
end
function plushiesApi.stop()
    if not plushies.active then return end
    plushies.active = false
    if plushies.conn then plushies.conn:Disconnect() plushies.conn = nil end
    if plushies.folder then plushies.folder:Destroy() plushies.folder = nil end
end
function plushiesApi.setTypes(list)
    plushies.types = {}
    for _, n in ipairs(list) do plushies.types[n] = true end
end
_G.__zenthraPlushies = plushiesApi

-- ───── ORBIT BALL ─────
local orbitBall = {
    active = false,
    speed = 50,
    height = 5,
    distance = 15,
    angle = 0,
    pre_conn = nil,
    post_conn = nil,
    saved_platform_stand = nil,
    saved_auto_rotate = nil,
    antifling_orig = nil,
    antifling_mod = nil,
}

local function setRepRoot(part, target)
    if typeof(sethiddenproperty) ~= "function" then return false end
    local ok, r = pcall(sethiddenproperty, part, "PhysicsRepRootPart", target)
    return ok and r
end

local function getAntifling()
    if orbitBall.antifling_mod then return orbitBall.antifling_mod end
    local ok, mod = pcall(function()
        return require(ReplicatedStorage.Controllers:FindFirstChild("AntiFlingController"))
    end)
    if ok and type(mod) == "table" and type(mod.Reteleport) == "function" then
        orbitBall.antifling_mod = mod
        return mod
    end
    return nil
end

local function disableAntifling()
    if orbitBall.antifling_orig then return end
    local mod = getAntifling()
    if not mod then return end
    orbitBall.antifling_orig = mod.Reteleport
    mod.Reteleport = function() end
end

local function restoreAntifling()
    if not orbitBall.antifling_orig then return end
    if orbitBall.antifling_mod then
        orbitBall.antifling_mod.Reteleport = orbitBall.antifling_orig
    end
    orbitBall.antifling_orig = nil
end

local function holdChar(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and orbitBall.saved_platform_stand == nil then
        orbitBall.saved_platform_stand = hum.PlatformStand
        orbitBall.saved_auto_rotate = hum.AutoRotate
        hum.PlatformStand = true
        hum.AutoRotate = false
    end
end

local function releaseChar(char)
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
            setRepRoot(hrp, nil)
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and orbitBall.saved_platform_stand ~= nil then
            hum.PlatformStand = orbitBall.saved_platform_stand
            hum.AutoRotate = orbitBall.saved_auto_rotate ~= false
        end
    end
    orbitBall.saved_platform_stand = nil
    orbitBall.saved_auto_rotate = nil
end

local function orbitStep(dt)
    if not orbitBall.active then return end
    local alive = Workspace:FindFirstChild("Alive")
    if not alive then return end
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if not alive:FindFirstChild(LP.Name) then return end
    local ball = getBalls() and (function()
        for _, b in ipairs(getBalls():GetChildren()) do if isRealBall(b) then return b end end
    end)()
    if not ball then return end
    holdChar(char)
    if dt and dt > 0 then
        orbitBall.angle += orbitBall.speed * dt
    end
    local pos = ball.Position
    local target = CFrame.lookAt(
        Vector3.new(pos.X + math.cos(orbitBall.angle) * orbitBall.distance,
                    pos.Y + orbitBall.height,
                    pos.Z + math.sin(orbitBall.angle) * orbitBall.distance),
        pos)
    hrp.Anchored = false
    setRepRoot(hrp, ball)
    char:PivotTo(target)
    hrp.AssemblyLinearVelocity = ball.AssemblyLinearVelocity
    hrp.AssemblyAngularVelocity = Vector3.zero
    Camera.CameraSubject = ball
end

local orbitApi = {}
function orbitApi.start()
    if orbitBall.active then return end
    orbitBall.active = true
    orbitBall.angle = 0
    disableAntifling()
    orbitBall.pre_conn = RunService.PreSimulation:Connect(function(dt) orbitStep(dt) end)
    orbitBall.post_conn = RunService.PostSimulation:Connect(function() orbitStep(0) end)
end
function orbitApi.stop()
    if not orbitBall.active then return end
    orbitBall.active = false
    if orbitBall.pre_conn then orbitBall.pre_conn:Disconnect() orbitBall.pre_conn = nil end
    if orbitBall.post_conn then orbitBall.post_conn:Disconnect() orbitBall.post_conn = nil end
    restoreAntifling()
    releaseChar(LP.Character)
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then Camera.CameraSubject = hum end
end
_G.__zenthraOrbit = orbitApi

-- ───── FOLLOW TARGET ─────
local followTarget = {
    active = false,
    mode = "Walk",   -- Walk | TP
    text_draw = nil,
    highlight = nil,
    highlight_char = nil,
    conn = nil,
    move_conn = nil,
    post_conn = nil,
    target_name = nil,
}

local function getFollowCharacter()
    if not followTarget.active then return nil end
    if not isLocalAlive() then return nil end
    local alive = Workspace:FindFirstChild("Alive")
    if not alive then return nil end
    local char = followTarget.target_name and alive:FindFirstChild(followTarget.target_name)
    if char and char:FindFirstChild("HumanoidRootPart") then return char end
    -- lock new
    local myHRP = getHRP()
    if not myHRP then return nil end
    local center = Camera.ViewportSize / 2
    local closest, minD = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                local sp = Camera:WorldToViewportPoint(root.Position)
                if sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < minD then minD = d closest = p end
                end
            end
        end
    end
    if closest then
        followTarget.target_name = closest.Name
        return closest.Character
    end
    return nil
end

local function followStopWalking()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hum then hum:Move(Vector3.zero, false) end
    if hum and hrp then hum:MoveTo(hrp.Position) end
end

local function followTpStep()
    if followTarget.mode ~= "TP" then return end
    if not isLocalAlive() then releaseChar(LP.Character) return end
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp or not hrp:IsDescendantOf(Workspace) then return end
    local target = getFollowCharacter()
    local tRoot = target and target:FindFirstChild("HumanoidRootPart")
    if not tRoot then setRepRoot(hrp, nil) return end
    local pivot = tRoot.CFrame
    local pos = pivot.Position
    if pos.X ~= pos.X or pos.Y ~= pos.Y or pos.Z ~= pos.Z then return end
    pcall(function()
        holdChar(char)
        hrp.Anchored = false
        setRepRoot(hrp, tRoot)
        char:PivotTo(pivot)
        hrp.AssemblyLinearVelocity = tRoot.AssemblyLinearVelocity
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)
end

local function followWalkStep()
    if followTarget.mode ~= "Walk" then return end
    if not isLocalAlive() then followStopWalking() return end
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or hum.Health <= 0 then return end
    local target = getFollowCharacter()
    if not target then return end
    local tRoot = target:FindFirstChild("HumanoidRootPart")
    if not tRoot then return end
    local delta = tRoot.Position - hrp.Position
    delta = Vector3.new(delta.X, 0, delta.Z)
    if delta.Magnitude < 2.5 then
        hum:Move(Vector3.zero, false)
        return
    end
    hum:Move(delta.Unit, false)
end

local function updateFollowHighlight()
    if not followTarget.active then
        if followTarget.text_draw then followTarget.text_draw.Visible = false end
        if followTarget.highlight then followTarget.highlight:Destroy() followTarget.highlight = nil followTarget.highlight_char = nil end
        return
    end
    if not throttleVisual("follow_target", 0.1) then return end
    local char = getFollowCharacter()
    if not char then
        if followTarget.text_draw then followTarget.text_draw.Visible = false end
        if followTarget.highlight then followTarget.highlight:Destroy() followTarget.highlight = nil end
        return
    end
    if Config.follow_target_highlight then
        if followTarget.highlight_char ~= char then
            if followTarget.highlight then followTarget.highlight:Destroy() end
            followTarget.highlight = Instance.new("Highlight")
            followTarget.highlight.Name = "ZenthraFollowHL"
            followTarget.highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            followTarget.highlight.FillTransparency = 0.5
            followTarget.highlight.OutlineTransparency = 0
            followTarget.highlight.FillColor = Config.follow_target_highlight_color
            followTarget.highlight.OutlineColor = Config.follow_target_highlight_color
            followTarget.highlight.Adornee = char
            followTarget.highlight.Parent = char
            followTarget.highlight_char = char
        end
    elseif followTarget.highlight then
        followTarget.highlight:Destroy() followTarget.highlight = nil followTarget.highlight_char = nil
    end
    if followTarget.text_draw and Config.follow_target_text then
        local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        if head then
            local sp = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 3, 0))
            if sp.Z > 0 then
                followTarget.text_draw.Position = Vector2.new(sp.X, sp.Y)
                followTarget.text_draw.Text = "TARGET"
                followTarget.text_draw.Size = Config.follow_target_text_size
                followTarget.text_draw.Color = Config.follow_target_text_color
                followTarget.text_draw.Visible = true
            else
                followTarget.text_draw.Visible = false
            end
        end
    elseif followTarget.text_draw then
        followTarget.text_draw.Visible = false
    end
end

local followApi = {}
function followApi.start()
    if followTarget.active then return end
    followTarget.active = true
    if Drawing then
        if not followTarget.text_draw then
            followTarget.text_draw = Drawing.new("Text")
            followTarget.text_draw.Visible = false
            followTarget.text_draw.Center = true
            followTarget.text_draw.Outline = true
            followTarget.text_draw.OutlineColor = Color3.new(0, 0, 0)
            followTarget.text_draw.Font = Drawing.Fonts.UI
            followTarget.text_draw.Text = "TARGET"
        end
    end
    if followTarget.mode == "TP" then
        disableAntifling()
    end
    followTarget.conn = RunService.RenderStepped:Connect(function()
        updateFollowHighlight()
        followWalkStep()
    end)
    followTarget.move_conn = RunService.PreSimulation:Connect(followTpStep)
    followTarget.post_conn = RunService.PostSimulation:Connect(followTpStep)
end
function followApi.stop()
    if not followTarget.active then return end
    followTarget.active = false
    if followTarget.conn then followTarget.conn:Disconnect() followTarget.conn = nil end
    if followTarget.move_conn then followTarget.move_conn:Disconnect() followTarget.move_conn = nil end
    if followTarget.post_conn then followTarget.post_conn:Disconnect() followTarget.post_conn = nil end
    if followTarget.text_draw then followTarget.text_draw.Visible = false end
    if followTarget.highlight then followTarget.highlight:Destroy() followTarget.highlight = nil end
    followStopWalking()
    releaseChar(LP.Character)
    restoreAntifling()
    followTarget.target_name = nil
end
function followApi.setMode(m)
    if m ~= "Walk" and m ~= "TP" then return end
    followTarget.mode = m
    if not followTarget.active then return end
    if m == "TP" then
        followStopWalking()
        releaseChar(LP.Character)
        disableAntifling()
    else
        releaseChar(LP.Character)
        restoreAntifling()
    end
end
_G.__zenthraFollow = followApi

-- ───── IMMORTAL (desync) ─────
local immortal = {
    enabled = false,
    config = { radius = 25, height = 10, angles = 360 },
    cache = { character = nil, hrp = nil, head = nil, alive = nil, orig_cf = nil, orig_vel = nil },
    hb_conn = nil,
    hook_installed = false,
}

local function updateImmortalCache()
    local char = LP.Character
    if char ~= immortal.cache.character then
        immortal.cache.character = char
        immortal.cache.hrp = char and char:FindFirstChild("HumanoidRootPart")
        immortal.cache.head = char and char:FindFirstChild("Head")
        immortal.cache.alive = Workspace:FindFirstChild("Alive")
    end
end

local function immortalInAlive()
    return immortal.cache.alive
        and immortal.cache.character
        and immortal.cache.character.Parent == immortal.cache.alive
end

local function immortalDesync()
    updateImmortalCache()
    local hrp = immortal.cache.hrp
    if not immortal.enabled or not hrp or not immortalInAlive() then return end
    local origCF = hrp.CFrame
    local origVel = hrp.AssemblyLinearVelocity
    local ang = math.rad(math.random(0, immortal.config.angles))
    local pos = Vector3.new(
        hrp.Position.X + math.cos(ang) * immortal.config.radius,
        hrp.Position.Y - hrp.Size.Y * 0.5 + 5 + (math.floor(tick() * 11.9) % 2 == 0 and 0 or immortal.config.height),
        hrp.Position.Z + math.sin(ang) * immortal.config.radius)
    hrp.CFrame = CFrame.new(pos)
    hrp.AssemblyLinearVelocity = Vector3.new(1, 1, 1)
    RunService.RenderStepped:Wait()
    hrp.CFrame = origCF
    hrp.AssemblyLinearVelocity = origVel
end

local function installImmortalHook()
    if immortal.hook_installed then return end
    local hooks = getgenv().__ZenthraHooks or {}
    getgenv().__ZenthraHooks = hooks
    getgenv().__ZenthraImmortalRef = immortal
    if hooks.immortal_installed then immortal.hook_installed = true return end
    hooks.immortal_installed = true
    immortal.hook_installed = true
    if typeof(hookmetamethod) == "function" then
        local orig
        orig = hookmetamethod(game, "__index", newcclosure(function(self, key)
            if key == "CFrame" then
                local ref = getgenv().__ZenthraImmortalRef
                if ref and ref.enabled and not checkcaller() and ref.cache.hrp
                    and ref.cache.hrp == self and ref.cache.orig_cf then
                    return ref.cache.orig_cf
                end
                if ref and ref.enabled and self == ref.cache.head and ref.cache.orig_cf then
                    return ref.cache.orig_cf + Vector3.new(0, ref.cache.hrp.Size.Y * 0.5 + 0.5, 0)
                end
            end
            return orig(self, key)
        end))
    end
end

local immortalApi = {}
function immortalApi.start()
    if immortal.enabled then return end
    immortal.enabled = true
    installImmortalHook()
    immortal.hb_conn = RunService.Heartbeat:Connect(function()
        if not immortal.enabled then return end
        local hrp = immortal.cache.hrp
        if hrp then
            immortal.cache.orig_cf = hrp.CFrame
            immortal.cache.orig_vel = hrp.AssemblyLinearVelocity
        end
        immortalDesync()
    end)
end
function immortalApi.stop()
    if not immortal.enabled then return end
    immortal.enabled = false
    if immortal.hb_conn then immortal.hb_conn:Disconnect() immortal.hb_conn = nil end
    getgenv().__ZenthraImmortalRef = nil
end
_G.__zenthraImmortal = immortalApi

-- ───── AUTO CURVE UI (mobile floating) ─────
local curveUi = {
    gui = nil,
    expanded = false,
    buttons = {},
}

local function createCurveUi()
    if curveUi.gui then curveUi.gui:Destroy() end
    local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    if not isMobile then return end

    local sg = Instance.new("ScreenGui")
    sg.Name = "ZenthraCurveUi"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 500
    sg.Parent = LP:WaitForChild("PlayerGui")
    curveUi.gui = sg

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(160, 32)
    frame.Position = UDim2.new(0.5, -80, 0, 100)
    frame.BackgroundColor3 = Palette.bg
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = sg
    corner(10).Parent = frame
    stroke(Palette.stroke, 1, 0).Parent = frame

    local title = label("Curve Modes", 12, Palette.accent, {
        Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(10, 0),
        Font = Enum.Font.GothamBold,
    })
    title.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.fromOffset(24, 24)
    toggle.Position = UDim2.new(1, -28, 0.5, -12)
    toggle.BackgroundTransparency = 1
    toggle.Text = "—"
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 14
    toggle.TextColor3 = Palette.sub
    toggle.AutoButtonColor = false
    toggle.Parent = frame

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, -16, 0, 0)
    list.Position = UDim2.fromOffset(8, 36)
    list.BackgroundTransparency = 1
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 2
    list.CanvasSize = UDim2.new()
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.Visible = false
    list.Parent = frame
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = list

    local modes = { "Camera", "Random", "Accelerated", "Back", "Down", "Up", "Dot" }
    curveUi.buttons = {}
    local function refresh()
        for i, b in ipairs(curveUi.buttons) do
            local active = Config.curve_mode == i
            b.stroke.Color = active and Palette.accent or Palette.stroke
            b.label.TextColor3 = active and Palette.text or Palette.sub
        end
    end
    for i, m in ipairs(modes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 22)
        btn.BackgroundColor3 = Palette.surface
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.BorderSizePixel = 0
        btn.LayoutOrder = i
        btn.Parent = list
        corner(6).Parent = btn
        local st = stroke(Palette.stroke, 1, 0.5)
        st.Parent = btn
        local lb = label(m, 11, Palette.sub, { Size = UDim2.new(1, -16, 1, 0), Position = UDim2.fromOffset(8, 0) })
        lb.Parent = btn
        btn.MouseButton1Click:Connect(function()
            Config.curve_mode = i
            local base = win.Tabs and win.Tabs["Combat"]
            -- sync with the base dropdown if present
            if tbl21 and tbl21.curve_mode_dropdown and tbl21.curve_mode_dropdown.set then
                tbl21.curve_mode_dropdown:set(m, true)
            end
            refresh()
        end)
        table.insert(curveUi.buttons, { btn = btn, stroke = st, label = lb })
    end
    refresh()

    local expanded = false
    local function expand(state)
        expanded = state
        list.Visible = state
        toggle.Text = state and "+" or "—"
        local h = state and (36 + #modes * 26) or 32
        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.fromOffset(160, h)
        }):Play()
    end
    toggle.MouseButton1Click:Connect(function() expand(not expanded) end)

    -- drag
    local dragging, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

-- ───── EMOTE WHEEL FAVORITES ─────
local emoteFav = { enabled = false, conns = {} }

local function hookEmoteFavorites()
    if emoteFav.enabled then return end
    emoteFav.enabled = true
    local inject = _G.__zenthraEmote
    if not inject then return end
    local wheel = getEmoteWheel()
    if not wheel then return end
    local list = wheel:FindFirstChild("List")
    if not list then return end
    -- hook existing favorite buttons
    local holder = findHolder(list)
    if holder then
        for i = 1, 24 do
            local btn = holder:FindFirstChild(tostring(i))
            if btn then
                local fav = btn:FindFirstChild("Favorite")
                if fav and fav:IsA("GuiButton") then
                    table.insert(emoteFav.conns, fav.Activated:Connect(function()
                        local name = btn:GetAttribute("EmoteName")
                        if name then
                            inject.wheel.favorites[name] = not inject.wheel.favorites[name] or nil
                        end
                    end))
                end
            end
        end
    end
end

-- ───── misc utils ─────
local misc = {
    throttle_times = {},
}

function throttleVisual(key, interval)
    local now = os.clock()
    local last = misc.throttle_times[key]
    if last and now - last < interval then return false end
    misc.throttle_times[key] = now
    return true
end

local function isLocalAlive()
    local char = LP.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    return hum ~= nil and hrp ~= nil and hum.Health > 0
end

-- ───── JERK OFF already in base, keep it ─────
-- (skip duplicate)

-- ───── WIRE FINAL BINDINGS ─────
task.delay(1.5, function()
    -- plushies
    if Config.plushies then plushiesApi.start() end
    -- orbit
    if Config.orbit_ball then orbitApi.start() end
    -- follow
    if Config.follow_target then followApi.start() followApi.setMode("Walk") end
    -- immortal
    if Config.walkable_immortal then immortalApi.start() end
    -- auto curve ui on mobile
    if Config.auto_curve_ui_enabled then createCurveUi() end
end)

-- rebuild curve UI when toggled
task.spawn(function()
    local wasEnabled = false
    while true do
        task.wait(0.5)
        if Config.auto_curve_ui_enabled and not wasEnabled then
            createCurveUi()
        elseif not Config.auto_curve_ui_enabled and wasEnabled then
            if curveUi.gui then curveUi.gui:Destroy() curveUi.gui = nil end
        end
        wasEnabled = Config.auto_curve_ui_enabled
    end
end)

-- expose everything under one global
_G.ZenthraFull = {
    config   = Config,
    palette  = Palette,
    sword    = _G.__zenthraSwordApi,
    avatar   = _G.__zenthraAvatar,
    ability  = _G.__zenthraAbilityEsp,
    emote    = _G.__zenthraEmote,
    cinema   = _G.__zenthraCinematic,
    rank     = _G.__zenthraRank,
    plushie  = plushiesApi,
    orbit    = orbitApi,
    follow   = followApi,
    immortal = immortalApi,
    getBalls = getBalls,
    getHRP   = getHRP,
    getHum   = getHum,
    getPing  = getPing,
    isLocalAlive = isLocalAlive,
}

print("[Zenthra] LEAK BY NIKA loaded. Right Shift to toggle UI.")
