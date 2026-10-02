repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local unpack = table.unpack or unpack
local getgenv = getgenv or function() return _G end
local G = getgenv()

local STANDALONE_VERSION = 4
local reuseExistingBackend = G._lhxStandaloneUnlockAllLoaded
    and type(G.updateSword) == "function"
    and type(G.updateExplosion) == "function"

if G._lhxStandaloneUnlockAllLoaded and G._lhxStandaloneUnlockAllVersion == STANDALONE_VERSION then
    G.skinChanger = true
    G.explosionChanger = true
    warn("[Unlock All] The current standalone script is already running.")
    return
end

if G._lhxStandaloneUnlockAllLoaded then
    G._lhxStandaloneUnlockAllLoaded = false
    task.wait(0.3)
end
G._lhxStandaloneUnlockAllVersion = STANDALONE_VERSION
G._lhxStandaloneUnlockAllLoaded = true

local function getExecutorGlobal(name)
    if G[name] ~= nil then return G[name] end
    if _G and _G[name] ~= nil then return _G[name] end
    if shared and shared[name] ~= nil then return shared[name] end

    local value
    pcall(function()
        local env = getrenv and getrenv()
        if env then value = env[name] end
    end)
    if value ~= nil then return value end

    pcall(function()
        local env = getfenv and getfenv(0)
        if env then value = env[name] end
    end)
    return value
end

if not reuseExistingBackend then

    G.setSkinChangerToggleUI = function() end
    G.setExplosionChangerToggleUI = function() end
    G.setExplosionInputUI = function() end
    G.setExplosionApplyText = function() end

    local SKIN_LAST_EQUIPPED_CONFIG_KEY = "Skin.LastEquippedSword"
    local EXPLOSION_LAST_EQUIPPED_CONFIG_KEY = "Skin.LastEquippedExplosion"
    local FINISHER_LAST_EQUIPPED_CONFIG_KEY = "Skin.LastEquippedFinisher"
    local AUTO_CONFIG_FILE = "LeviHubX/auto_config.json"

    local function readLeviHubAutoConfig()
        local data = {}
        pcall(function()
            if isfile and isfile(AUTO_CONFIG_FILE) then
                local decoded = HttpService:JSONDecode(readfile(AUTO_CONFIG_FILE))
                if type(decoded) == "table" then
                    data = decoded
                end
            end
        end)
        return data
    end

    local function writeLeviHubAutoConfig(data)
        pcall(function()
            if isfolder and makefolder and not isfolder("LeviHubX") then
                makefolder("LeviHubX")
            end
            if writefile then
                writefile(AUTO_CONFIG_FILE, HttpService:JSONEncode(data or {}))
            end
        end)
    end

    local function loadLastEquippedSword()
        local data = readLeviHubAutoConfig()
        local saved = data[SKIN_LAST_EQUIPPED_CONFIG_KEY]
        return type(saved) == "string" and saved or ""
    end

    local function loadLastEquippedExplosion()
        local data = readLeviHubAutoConfig()
        local saved = data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY]
        return type(saved) == "string" and saved or ""
    end

    local function loadLastEquippedFinisher()
        local data = readLeviHubAutoConfig()
        local saved = data[FINISHER_LAST_EQUIPPED_CONFIG_KEY]
        return type(saved) == "string" and saved or ""
    end

    getgenv().saveLastEquippedSword = function(swordName)
        if type(swordName) ~= "string" or swordName == "" then return end

        local autoConfig = getgenv()._lhxAutoConfig
        local data = autoConfig and autoConfig.Data
        if type(data) ~= "table" then
            data = readLeviHubAutoConfig()
        end

        data[SKIN_LAST_EQUIPPED_CONFIG_KEY] = swordName
        if autoConfig and type(autoConfig.Data) == "table" then
            autoConfig.Data[SKIN_LAST_EQUIPPED_CONFIG_KEY] = swordName
        end
        writeLeviHubAutoConfig(data)
    end

    getgenv().saveLastEquippedExplosion = function(explosionName)
        if type(explosionName) ~= "string" or explosionName == "" then return end

        local autoConfig = getgenv()._lhxAutoConfig
        local data = autoConfig and autoConfig.Data
        if type(data) ~= "table" then
            data = readLeviHubAutoConfig()
        end

        data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY] = explosionName
        if autoConfig and type(autoConfig.Data) == "table" then
            autoConfig.Data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY] = explosionName
        end
        writeLeviHubAutoConfig(data)
    end

    getgenv().saveLastEquippedFinisher = function(finisherName)
        if type(finisherName) ~= "string" or finisherName == "" then return end

        local autoConfig = getgenv()._lhxAutoConfig
        local data = autoConfig and autoConfig.Data
        if type(data) ~= "table" then
            data = readLeviHubAutoConfig()
        end

        data[FINISHER_LAST_EQUIPPED_CONFIG_KEY] = finisherName
        if autoConfig and type(autoConfig.Data) == "table" then
            autoConfig.Data[FINISHER_LAST_EQUIPPED_CONFIG_KEY] = finisherName
        end
        writeLeviHubAutoConfig(data)
    end

    local savedLastSword = loadLastEquippedSword()
    local savedLastExplosion = loadLastEquippedExplosion()
    local savedLastFinisher = loadLastEquippedFinisher()
    getgenv().skinChanger = getgenv().skinChanger or savedLastSword ~= ""
    getgenv().swordModel = type(getgenv().swordModel) == "string" and getgenv().swordModel ~= "" and getgenv().swordModel or savedLastSword
    getgenv().swordAnimations = type(getgenv().swordAnimations) == "string" and getgenv().swordAnimations ~= "" and getgenv().swordAnimations or savedLastSword
    getgenv().swordFX = type(getgenv().swordFX) == "string" and getgenv().swordFX ~= "" and getgenv().swordFX or savedLastSword
    getgenv().explosionChanger = getgenv().explosionChanger or savedLastExplosion ~= ""
    getgenv().explosionFX = type(getgenv().explosionFX) == "string" and getgenv().explosionFX ~= "" and getgenv().explosionFX or savedLastExplosion
    getgenv().finisherChanger = getgenv().finisherChanger or savedLastFinisher ~= ""
    getgenv().finisherModel = type(getgenv().finisherModel) == "string" and getgenv().finisherModel ~= "" and getgenv().finisherModel or savedLastFinisher

    task.spawn(function()
        local rs = game:GetService("ReplicatedStorage")
        local swordInstancesInstance = rs:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
        local swordInstances = require(swordInstancesInstance)

        local swordsController
        task.spawn(function()
            while task.wait(0.25) and not swordsController do
                local ok, conns = pcall(getconnections, rs.Remotes.FireSwordInfo.OnClientEvent)
                if ok and conns then
                    for _, v in ipairs(conns) do
                        if v.Function and islclosure and islclosure(v.Function) then
                            local ok2, up = pcall(getupvalues, v.Function)
                            if ok2 and #up == 1 and type(up[1]) == "table" then
                                swordsController = up[1]
                                break
                            end
                        end
                    end
                end
            end
        end)

        local function getSlashName(swordName)
            local ok, sln = pcall(function() return swordInstances:GetSword(swordName) end)
            return (ok and sln and sln.SlashName) or "SlashEffect"
        end

        local function refreshSlashName()
            local fxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
            if fxName ~= "" then
                getgenv().slashName = getSlashName(fxName)
            else
                getgenv().slashName = "SlashEffect"
            end
        end
        refreshSlashName()

        local function setSword()
            if not getgenv().skinChanger then return end
            if not LocalPlayer.Character then return end
            pcall(function()
                local f = rawget(swordInstances, "EquipSwordTo")
                if type(f) == "function" then
                    local ups = getupvalues(f)
                    for i = 1, #ups do
                        if type(ups[i]) == "boolean" then
                            setupvalue(f, i, false)
                            break
                        end
                    end
                end
            end)
            pcall(function()
                swordInstances:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel)
            end)
            task.spawn(function()
                local attempts = 0
                while not swordsController and attempts < 20 do
                    task.wait(0.5); attempts += 1
                end
                if not swordsController then return end
                pcall(function()
                    if swordsController.SetSword then
                        swordsController:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel)
                    end
                end)
                pcall(function()
                    local targetSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                    if rs.Remotes:FindFirstChild("FireSwordInfo") then
                        rs.Remotes.FireSwordInfo:FireServer(targetSword)
                    end
                    if swordsController.currentSword ~= nil then
                        pcall(function() swordsController.currentSword = targetSword end)
                    end
                    if swordsController.SwordFX ~= nil then
                        pcall(function() swordsController.SwordFX = targetSword end)
                    end
                end)
            end)
        end

        local hookedFuncs = {}
        task.spawn(function()
            local remotesToHook = {"ParrySuccessAll", "ParryAttempt", "ParrySuccess", "PlaySound", "PlayVisuals"}
            while task.wait(1) do
                for _, remoteName in ipairs(remotesToHook) do
                    local remote = rs.Remotes:FindFirstChild(remoteName)
                    if remote and remote:IsA("RemoteEvent") then
                        local ok, conns = pcall(getconnections, remote.OnClientEvent)
                        if ok and type(conns) == "table" then
                            for _, v in ipairs(conns) do
                                local func = v.Function
                                if func and not hookedFuncs[func] then

                                    hookedFuncs[func] = true
                                    v:Disable()
                                    local targetFunc = func
                                    local ourFunc
                                    ourFunc = function(...)
                                        local args = { ... }

                                        local isLocal = false
                                        for _, arg in ipairs(args) do
                                            if tostring(arg) == LocalPlayer.Name or (typeof(arg) == "Instance" and (arg == LocalPlayer.Character or arg == LocalPlayer)) then
                                                isLocal = true
                                                break
                                            end
                                        end

                                        if isLocal and getgenv().skinChanger then
                                            local fxSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                                            refreshSlashName()

                                            local swordFound = false
                                            local slashFound = false

                                            for i, arg in ipairs(args) do
                                                if type(arg) == "string" then
                                                    if fxSword ~= "" and not slashFound and (arg:match("Slash") or arg == "Default" or arg:match("Effect")) then
                                                        args[i] = getgenv().slashName
                                                        slashFound = true
                                                    elseif fxSword ~= "" and not swordFound then
                                                        local isSword = false
                                                        pcall(function()
                                                            if rs.Shared.ReplicatedInstances.Swords:FindFirstChild(arg) then
                                                                isSword = true
                                                            end
                                                        end)
                                                        if isSword or arg == LocalPlayer:GetAttribute("CurrentlyEquippedSword") then
                                                            args[i] = fxSword
                                                            swordFound = true
                                                        end
                                                    end
                                                end
                                            end

                                            if fxSword ~= "" and not slashFound and type(args[1]) == "string" then
                                                args[1] = getgenv().slashName
                                            end
                                            if fxSword ~= "" and not swordFound and type(args[3]) == "string" then
                                                args[3] = fxSword
                                            end
                                        end
                                        if setthreadidentity then pcall(setthreadidentity, 2) end
                                        pcall(targetFunc, unpack(args))
                                    end
                                    hookedFuncs[ourFunc] = true
                                    remote.OnClientEvent:Connect(ourFunc)
                                end
                            end
                        end
                    end
                end
            end
        end)

        getgenv().updateSword = function()
            refreshSlashName()
            if getgenv().skinChanger and getgenv().swordModel ~= "" and getgenv().saveLastEquippedSword then
                getgenv().saveLastEquippedSword(getgenv().swordModel)
            end
            setSword()
        end

        task.spawn(function()
            while task.wait(1) do
                if getgenv().skinChanger and getgenv().swordModel ~= "" then
                    local char = LocalPlayer.Character
                    if char then
                        if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
                            setSword()
                        end
                        if not char:FindFirstChild(getgenv().swordModel) then
                            setSword()
                        end
                        for _, v in char:GetChildren() do
                            if v:IsA("Model") and v.Name ~= getgenv().swordModel then
                                v:Destroy()
                            end
                            task.wait()
                        end
                    end
                end
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function()
            if getgenv().skinChanger then
                getgenv().skinChanger = false
                if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(false) end
                task.wait(2)
                getgenv().skinChanger = true
                if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(true) end
                task.wait(0.5)
                pcall(function() getgenv().updateSword() end)
            end
        end)
    end)

    task.spawn(function()
        local rs = game:GetService("ReplicatedStorage")

        task.spawn(function()
            local hookFunction = getExecutorGlobal("hookfunction") or getExecutorGlobal("hookfunc")
            if type(hookFunction) ~= "function" then return end
            local controllers = rs:WaitForChild("Controllers", 10)
            if not controllers then return end
            local fcModule = controllers:WaitForChild("FinishersController", 10)
            if not fcModule then return end
            local ok, module = pcall(require, fcModule)
            if ok and type(module) == "table" then
                getgenv()._lhxFCModule = module
                for k, v in pairs(module) do
                    if type(v) == "function" then
                        local orig
                        orig = hookFunction(v, function(self, ...)
                            if getgenv().finisherModel and getgenv().finisherModel ~= "" then
                                local newArgs = { ... }
                                if type(newArgs[1]) == "string" then
                                    newArgs[1] = getgenv().finisherModel
                                elseif type(newArgs[2]) == "string" then
                                    newArgs[2] = getgenv().finisherModel
                                end
                                return orig(self, unpack(newArgs))
                            end
                            return orig(self, ...)
                        end)
                    end
                end
            end
        end)

        local explosionHookedFuncs = {}
        local explosionDirectHooked = {}
        local deadFolderHooked = false
        local explosionModule = nil
        local bindableInvokeHooked = false
        local nativeExplosionSuppressorHooked = {}
        local pendingKillExplosionPosition = nil
        local pendingKillExplosionAt = 0
        local lastLocalKillAt = 0
        local lastLocalKillStatTotal = nil
        local killStatWatcherStarted = false
        local lastLocalExplosionPlayedAt = 0
        local lastLocalExplosionPlayedPosition = nil

        local function normalizeExplosionName(value)
            return tostring(value or ""):lower():gsub("[^%w]", "")
        end

        local function getNetFolder()
            local packages = rs:FindFirstChild("Packages")
            local index = packages and packages:FindFirstChild("_Index")
            local sleitnick = index and index:FindFirstChild("sleitnick_net@0.1.0")
            return sleitnick and sleitnick:FindFirstChild("net")
        end

        local function getExplosionInstances()
            local shared = rs:FindFirstChild("Shared")
            local replicatedInstances = shared and shared:FindFirstChild("ReplicatedInstances")
            return replicatedInstances and replicatedInstances:FindFirstChild("Explosions")
        end

        local function getExplosionDataFolder()
            local misc = rs:FindFirstChild("Misc")
            return misc and misc:FindFirstChild("DataExplosions")
        end

        local function getExplosionEffectsFolder()
            return rs:FindFirstChild("ExplosionEffects")
        end

        local function getExplosionModule()
            if explosionModule ~= nil then return explosionModule end
            local instance = getExplosionInstances()
            if instance and instance:IsA("ModuleScript") then
                local ok, result = pcall(function()
                    return require(instance)
                end)
                explosionModule = ok and result or false
            end
            return explosionModule
        end

        local function findExplosionInstanceByName(value)
            if type(value) ~= "string" or value == "" then return nil end
            local wanted = normalizeExplosionName(value)
            for _, root in ipairs({getExplosionDataFolder(), getExplosionEffectsFolder(), getExplosionInstances()}) do
                if root then
                    local exact = root:FindFirstChild(value, true)
                    if exact then return exact end
                    for _, child in ipairs(root:GetDescendants()) do
                        if normalizeExplosionName(child.Name) == wanted then
                            return child
                        end
                    end
                end
            end
            return nil
        end

        local function findExplosionDataConfig(value)
            if type(value) ~= "string" or value == "" then return nil end
            local dataFolder = getExplosionDataFolder()
            if not dataFolder then return nil end

            local wanted = normalizeExplosionName(value)
            local exact = dataFolder:FindFirstChild(value, true)
            if exact then return exact end

            for _, child in ipairs(dataFolder:GetDescendants()) do
                if normalizeExplosionName(child.Name) == wanted then
                    return child
                end
                for _, attributeValue in pairs(child:GetAttributes()) do
                    if type(attributeValue) == "string"
                        and normalizeExplosionName(attributeValue) == wanted then
                        return child
                    end
                end
            end
            return nil
        end

        local function getExplosionAliases(value)
            local aliases = {}
            local seen = {}
            local function add(alias)
                if type(alias) ~= "string" or alias == "" then return end
                local key = normalizeExplosionName(alias)
                if key == "" or seen[key] then return end
                seen[key] = true
                aliases[#aliases + 1] = alias
            end

            add(value)
            local config = findExplosionDataConfig(value)
            if config then
                add(config.Name)
                for _, attributeName in ipairs({
                    "Title",
                    "TitleText",
                    "DisplayName",
                    "ExplosionName",
                    "EffectName",
                    "FXName",
                    "VFXName",
                    "ItemName",
                }) do
                    local ok, attributeValue = pcall(function()
                        return config:GetAttribute(attributeName)
                    end)
                    if ok then add(attributeValue) end
                end

                local scanned = 0
                for _, object in ipairs(config:GetDescendants()) do
                    if object:IsA("StringValue") then
                        add(object.Value)
                        scanned += 1
                        if scanned >= 20 then break end
                    end
                end
            end
            return aliases
        end

        local function isPlayableExplosionTemplate(instance)
            if typeof(instance) ~= "Instance" then return false end
            if instance:IsA("Configuration")
                or instance:IsA("ModuleScript")
                or instance:IsA("Script")
                or instance:IsA("LocalScript")
                or instance:IsA("BindableFunction")
                or instance:IsA("BindableEvent")
                or instance:IsA("ObjectValue") then
                return false
            end
            return instance:IsA("Folder")
                or instance:IsA("Model")
                or instance:IsA("BasePart")
                or instance:IsA("Attachment")
                or instance:IsA("Accessory")
                or instance:IsA("Tool")
                or instance:FindFirstChildWhichIsA("BasePart", true) ~= nil
                or instance:FindFirstChildWhichIsA("ParticleEmitter", true) ~= nil
                or instance:FindFirstChildWhichIsA("Beam", true) ~= nil
                or instance:FindFirstChildWhichIsA("Trail", true) ~= nil
        end

        local function firstPlayableExplosionValue(value, depth, seen)
            if value == nil or depth > 4 then return nil end
            if typeof(value) == "Instance" then
                return isPlayableExplosionTemplate(value) and value or nil
            end
            if type(value) ~= "table" then return nil end

            seen = seen or {}
            if seen[value] then return nil end
            seen[value] = true

            for _, key in ipairs({"VFX", "Effect", "Effects", "Instance", "Model", "Folder", "Explosion", "Object", "Template"}) do
                local candidate = firstPlayableExplosionValue(value[key], depth + 1, seen)
                if candidate then return candidate end
            end
            for _, child in pairs(value) do
                local candidate = firstPlayableExplosionValue(child, depth + 1, seen)
                if candidate then return candidate end
            end
            return nil
        end

        local function getReplicatedExplosionTemplate(value)
            local instances = getExplosionInstances()
            if not instances then return nil end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local direct = instances:FindFirstChild(alias, true)
                if isPlayableExplosionTemplate(direct) then
                    getgenv().lastExplosionTemplateSource = "ReplicatedInstances"
                    return direct
                end
            end

            local bindable = instances:FindFirstChild("GetInstance")
            if bindable and bindable:IsA("BindableFunction") then
                for _, alias in ipairs(getExplosionAliases(value)) do
                    local ok, result = pcall(function()
                        return bindable:Invoke(alias)
                    end)
                    local template = ok and firstPlayableExplosionValue(result, 0, {}) or nil
                    if template then
                        getgenv().lastExplosionTemplateSource = "ReplicatedInstances.GetInstance"
                        return template
                    end
                end
            end

            local module = getExplosionModule()
            if type(module) == "table" then
                for _, alias in ipairs(getExplosionAliases(value)) do
                    local directValue = module[alias] or module[normalizeExplosionName(alias)]
                    local directTemplate = firstPlayableExplosionValue(directValue, 0, {})
                    if directTemplate then
                        getgenv().lastExplosionTemplateSource = "ReplicatedInstances.Module"
                        return directTemplate
                    end

                    for _, methodName in ipairs({"GetInstance", "GetExplosion", "GetExplosionVFX", "GetEffect", "Get"}) do
                        local method = module[methodName]
                        if type(method) == "function" then
                            for _, callWithSelf in ipairs({true, false}) do
                                local ok, result = pcall(function()
                                    if callWithSelf then
                                        return method(module, alias)
                                    end
                                    return method(alias)
                                end)
                                local template = ok and firstPlayableExplosionValue(result, 0, {}) or nil
                                if template then
                                    getgenv().lastExplosionTemplateSource = "ReplicatedInstances." .. methodName
                                    return template
                                end
                            end
                        end
                    end
                end
            end

            return nil
        end

        local function findExplosionEffectTemplate(value)
            if type(value) ~= "string" or value == "" then return nil end
            local replicatedTemplate = getReplicatedExplosionTemplate(value)
            if replicatedTemplate then return replicatedTemplate end

            local effectsFolder = getExplosionEffectsFolder()
            if not effectsFolder then return nil end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local exact = effectsFolder:FindFirstChild(alias, true)
                if exact and isPlayableExplosionTemplate(exact) then
                    getgenv().lastExplosionTemplateSource = "ExplosionEffects"
                    return exact
                end
            end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local wanted = normalizeExplosionName(alias)
                for _, child in ipairs(effectsFolder:GetDescendants()) do
                    if isPlayableExplosionTemplate(child) and normalizeExplosionName(child.Name) == wanted then
                        getgenv().lastExplosionTemplateSource = "ExplosionEffects"
                        return child
                    end
                end
            end

            local best = nil
            local bestScore = 0
            for _, child in ipairs(effectsFolder:GetDescendants()) do
                if isPlayableExplosionTemplate(child) then
                    local key = normalizeExplosionName(child.Name)
                    local score = 0
                    for _, alias in ipairs(getExplosionAliases(value)) do
                        local wanted = normalizeExplosionName(alias)
                        if wanted:find(key, 1, true) or key:find(wanted, 1, true) then
                            score = math.max(score, math.min(#key, #wanted))
                        else
                            for word in tostring(alias):gmatch("[%w]+") do
                                local wordKey = normalizeExplosionName(word)
                                if #wordKey >= 4 and key:find(wordKey, 1, true) then
                                    score += #wordKey
                                end
                            end
                        end
                    end
                    if score > bestScore then
                        best = child
                        bestScore = score
                    end
                end
            end

            if best then
                getgenv().lastExplosionTemplateSource = "ExplosionEffects.Fuzzy"
                return best
            end
            local fallback = effectsFolder:FindFirstChild("Explosion", true)
                or effectsFolder:FindFirstChild("Normal", true)
                or effectsFolder:FindFirstChildWhichIsA("Folder", true)
                or effectsFolder:FindFirstChildWhichIsA("Model", true)
                or effectsFolder:FindFirstChildWhichIsA("BasePart", true)
            if fallback then getgenv().lastExplosionTemplateSource = "ExplosionEffects.Fallback" end
            return fallback
        end

        local function getSelectedExplosionName()
            local selected = getgenv().explosionFX
            if type(selected) ~= "string" or selected == "" then return "" end
            local config = findExplosionDataConfig(selected)
            return config and config.Name or selected
        end

        local function isPlayerString(value)
            if type(value) ~= "string" then return false end
            for _, player in ipairs(Players:GetPlayers()) do
                if value == player.Name or value == player.DisplayName then
                    return true
                end
            end
            return false
        end

        local function isKnownExplosionName(value)
            if type(value) ~= "string" or value == "" then return false end
            if findExplosionInstanceByName(value) then return true end
            local instances = getExplosionInstances()
            if instances then
                local bindable = instances:FindFirstChild("GetInstance")
                if bindable and bindable:IsA("BindableFunction") then
                    local ok, result = pcall(function()
                        return bindable:Invoke(value)
                    end)
                    if ok and result then return true end
                end
                if instances:FindFirstChild(value, true) then return true end
            end

            local module = getExplosionModule()
            if type(module) == "table" then
                if module[value] ~= nil then return true end
                for _, methodName in ipairs({"GetExplosion", "GetInstance", "Get"}) do
                    if type(module[methodName]) == "function" then
                        local ok, result = pcall(function()
                            return module[methodName](module, value)
                        end)
                        if ok and result then return true end
                    end
                end
            end
            return false
        end

        local function argsMentionLocal(args)
            for _, arg in ipairs(args) do
                if arg == LocalPlayer or arg == LocalPlayer.Character or arg == LocalPlayer.Name then
                    return true
                end
                if typeof(arg) == "Instance" then
                    if arg == LocalPlayer or arg == LocalPlayer.Character then return true end
                    if LocalPlayer.Character and arg:IsDescendantOf(LocalPlayer.Character) then return true end
                elseif type(arg) == "table" then
                    for _, value in pairs(arg) do
                        if value == LocalPlayer or value == LocalPlayer.Character or value == LocalPlayer.Name then
                            return true
                        end
                    end
                end
            end
            return false
        end

        local function valueMentionsLocal(value, depth)
            if depth > 4 or value == nil then return false end
            if value == LocalPlayer or value == LocalPlayer.Character or value == LocalPlayer.Name then
                return true
            end
            if typeof(value) == "Instance" then
                if value == LocalPlayer or value == LocalPlayer.Character then return true end
                if value:IsA("Player") then
                    return value == LocalPlayer
                        or value.Name == LocalPlayer.Name
                        or value.DisplayName == LocalPlayer.DisplayName
                end
                return LocalPlayer.Character and value:IsDescendantOf(LocalPlayer.Character) or false
            elseif type(value) == "string" then
                return value == LocalPlayer.Name or value == LocalPlayer.DisplayName
            elseif type(value) == "table" then
                for _, child in pairs(value) do
                    if valueMentionsLocal(child, depth + 1) then return true end
                end
            end
            return false
        end

        local function tableIndicatesLocalKill(tbl, depth)
            if type(tbl) ~= "table" or depth > 4 then return false end
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                local killerKey = keyText:find("killer", 1, true)
                    or keyText:find("attacker", 1, true)
                    or keyText:find("creator", 1, true)
                    or keyText:find("source", 1, true)
                    or keyText:find("from", 1, true)
                    or keyText:find("dealer", 1, true)
                    or keyText:find("owner", 1, true)
                local victimKey = keyText:find("victim", 1, true)
                    or keyText:find("dead", 1, true)
                    or keyText:find("killed", 1, true)
                    or keyText:find("target", 1, true)
                if killerKey and valueMentionsLocal(value, 0) then return true end
                if victimKey and valueMentionsLocal(value, 0) then return false end
            end
            for _, value in pairs(tbl) do
                if tableIndicatesLocalKill(value, depth + 1) then return true end
            end
            return false
        end

        local function tableIndicatesLocalDeath(tbl, depth)
            if type(tbl) ~= "table" or depth > 4 then return false end
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                local victimKey = keyText:find("victim", 1, true)
                    or keyText:find("dead", 1, true)
                    or keyText:find("killed", 1, true)
                    or keyText:find("target", 1, true)
                if victimKey and valueMentionsLocal(value, 0) then return true end
            end
            for _, value in pairs(tbl) do
                if tableIndicatesLocalDeath(value, depth + 1) then return true end
            end
            return false
        end

        local function argsIndicateLocalDeath(args)
            for _, arg in ipairs(args) do
                if tableIndicatesLocalDeath(arg, 0) then return true end
            end
            return false
        end

        local function argsIndicateLocalKill(args, remoteName)
            for _, arg in ipairs(args) do
                if tableIndicatesLocalKill(arg, 0) then return true end
            end
            local first = args[1]
            local second = args[2]
            local third = args[3]
            if valueMentionsLocal(second, 0) and not valueMentionsLocal(first, 0) then return true end
            if valueMentionsLocal(third, 0) and not valueMentionsLocal(first, 0) then return true end
            if valueMentionsLocal(first, 0) and not valueMentionsLocal(second, 0) then return true end

            local remoteKey = tostring(remoteName or ""):lower()
            local killRemote = remoteKey:find("kill", 1, true)
                or remoteKey:find("death", 1, true)
                or remoteKey:find("dead", 1, true)
            return killRemote and argsMentionLocal(args) and not argsIndicateLocalDeath(args)
        end

        local function getPositionFromExplosionValue(value, depth)
            if depth > 3 or value == nil then return nil end
            if typeof(value) == "Vector3" then return value end
            if typeof(value) == "CFrame" then return value.Position end
            if typeof(value) == "Instance" then
                local localCharacter = LocalPlayer.Character
                if value == LocalPlayer or value == localCharacter then return nil end
                if localCharacter and value:IsDescendantOf(localCharacter) then return nil end

                if value:IsA("BasePart") then return value.Position end
                if value:IsA("Player") then
                    local character = value.Character
                    local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
                    return root and root.Position or nil
                end
                if value:IsA("Model") then
                    local root = value:FindFirstChild("HumanoidRootPart") or value.PrimaryPart
                    if root then return root.Position end
                    local ok, pivot = pcall(function() return value:GetPivot() end)
                    if ok and pivot then return pivot.Position end
                end
            elseif type(value) == "table" then
                for _, child in pairs(value) do
                    local position = getPositionFromExplosionValue(child, depth + 1)
                    if position then return position end
                end
            end
            return nil
        end

        local function isLocalExplosionPosition(position)
            if typeof(position) ~= "Vector3" then return false end
            local character = LocalPlayer.Character
            local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
            return root and (position - root.Position).Magnitude <= 4 or false
        end

        local function getExplosionPositionFromArgs(args)
            for _, arg in ipairs(args) do
                local position = getPositionFromExplosionValue(arg, 0)
                if position and not isLocalExplosionPosition(position) then return position end
            end
            return nil
        end

        local function parseVector3Attribute(value)
            if typeof(value) == "Vector3" then return value end
            if type(value) ~= "string" then return nil end
            local numbers = {}
            for numberText in value:gmatch("[-+]?%d+%.?%d*") do
                numbers[#numbers + 1] = tonumber(numberText)
                if #numbers >= 3 then break end
            end
            if #numbers >= 3 then
                return Vector3.new(numbers[1], numbers[2], numbers[3])
            end
            return nil
        end

        local function getNumberAttribute(object, names)
            for _, name in ipairs(names) do
                local value = tonumber(object:GetAttribute(name))
                if value then return value end
            end
            return nil
        end

        local function delayedTween(object, delayTime, duration, properties)
            if not next(properties) then return end
            task.delay(delayTime or 0, function()
                if object and object.Parent then
                    pcall(function()
                        TweenService:Create(
                            object,
                            TweenInfo.new(math.max(duration or 0.05, 0.05), Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            properties
                        ):Play()
                    end)
                end
            end)
        end

        local function activateLocalExplosionObject(root)
            local objects = {root}
            for _, object in ipairs(root:GetDescendants()) do
                objects[#objects + 1] = object
            end

            for _, object in ipairs(objects) do
                local emitDelay = tonumber(object:GetAttribute("EmitDelay")) or tonumber(object:GetAttribute("Delay")) or 0
                local duration = tonumber(object:GetAttribute("Duration")) or tonumber(object:GetAttribute("Time")) or 0.35
                if object:IsA("BasePart") then
                    object.Anchored = true
                    object.CanCollide = false
                    object.CanTouch = false
                    object.CanQuery = false

                    local properties = {}
                    local sizeTarget = parseVector3Attribute(object:GetAttribute("Size_Target"))
                        or parseVector3Attribute(object:GetAttribute("Size"))
                    local transparencyTarget = tonumber(object:GetAttribute("Transparency_Target"))
                        or tonumber(object:GetAttribute("Transparency"))
                    if sizeTarget then properties.Size = sizeTarget end
                    if transparencyTarget then properties.Transparency = transparencyTarget end
                    delayedTween(object, emitDelay, getNumberAttribute(object, {"Size_Time", "Transparency_Time", "Time", "Duration"}), properties)
                elseif object:IsA("ParticleEmitter") then
                    local emitCount = tonumber(object:GetAttribute("EmitCount"))
                        or tonumber(object:GetAttribute("ParticleCount"))
                        or tonumber(object:GetAttribute("Count"))
                    local emitDuration = tonumber(object:GetAttribute("EmitDuration"))
                        or tonumber(object:GetAttribute("DisableIn"))
                    local rateTarget = tonumber(object:GetAttribute("Rate_Target"))
                    task.delay(emitDelay, function()
                        if object and object.Parent then
                            if emitCount and emitCount > 0 then
                                pcall(function() object:Emit(emitCount) end)
                            else
                                pcall(function() object.Enabled = true end)
                                if emitDuration and emitDuration > 0 then
                                    task.delay(emitDuration, function()
                                        if object and object.Parent then object.Enabled = false end
                                    end)
                                end
                            end
                            if rateTarget then
                                delayedTween(object, 0, duration, {Rate = rateTarget})
                            end
                        end
                    end)
                elseif object:IsA("Beam") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local properties = {}
                    local width0 = tonumber(object:GetAttribute("Width0"))
                    local width1 = tonumber(object:GetAttribute("Width1"))
                    if width0 then properties.Width0 = width0 end
                    if width1 then properties.Width1 = width1 end
                    delayedTween(object, emitDelay, duration, properties)
                elseif object:IsA("Trail") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local lifetime = tonumber(object:GetAttribute("Lifetime"))
                    if lifetime then object.Lifetime = lifetime end
                elseif object:IsA("Light") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local properties = {}
                    local rangeTarget = tonumber(object:GetAttribute("Range_Target"))
                    local brightnessTarget = tonumber(object:GetAttribute("Brightness_Target"))
                    if rangeTarget then properties.Range = rangeTarget end
                    if brightnessTarget then properties.Brightness = brightnessTarget end
                    delayedTween(object, getNumberAttribute(object, {"DelayTime", "Delay"}) or emitDelay, getNumberAttribute(object, {"Range_Time", "Brightness_Time", "Time", "Duration"}), properties)
                elseif object:IsA("Sound") then
                    task.delay(tonumber(object:GetAttribute("Delay")) or emitDelay, function()
                        if object and object.Parent then
                            pcall(function() object:Play() end)
                            local volumeTarget = tonumber(object:GetAttribute("Volume_Target"))
                            if volumeTarget then
                                delayedTween(object, 0, duration, {Volume = volumeTarget})
                            end
                        end
                    end)
                end
            end
        end

        local function playSyntheticExplosion(position)
            getgenv().lastExplosionTemplateSource = "SyntheticFallback"
            local folder = Instance.new("Folder")
            folder.Name = "LeviHubExplosion_LocalFallback"
            folder.Parent = workspace:FindFirstChild("Runtime") or workspace

            local part = Instance.new("Part")
            part.Name = "Burst"
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            part.Material = Enum.Material.Neon
            part.Shape = Enum.PartType.Ball
            part.Size = Vector3.new(1, 1, 1)
            part.Color = Color3.fromRGB(120, 180, 255)
            part.Transparency = 1
            pcall(function() part.LocalTransparencyModifier = 1 end)
            part.CFrame = CFrame.new(position or Vector3.zero)
            part.Parent = folder

            local attachment = Instance.new("Attachment")
            attachment.Parent = part

            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(90, 130, 255))
            emitter.LightEmission = 1
            emitter.Lifetime = NumberRange.new(0.35, 0.9)
            emitter.Speed = NumberRange.new(28, 58)
            emitter.SpreadAngle = Vector2.new(180, 180)
            emitter.Drag = 4
            emitter.Rate = 0
            emitter.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.8),
                NumberSequenceKeypoint.new(1, 0),
            })
            emitter.Parent = attachment
            emitter:Emit(90)

            local light = Instance.new("PointLight")
            light.Color = part.Color
            light.Brightness = 5
            light.Range = 18
            light.Parent = part

            TweenService:Create(part, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(9, 9, 9),
                Transparency = 1,
            }):Play()
            TweenService:Create(light, TweenInfo.new(0.45), {Brightness = 0, Range = 0}):Play()

            task.delay(2, function()
                if folder and folder.Parent then folder:Destroy() end
            end)
            return true
        end

        local function playLocalExplosion(position)
            if not getgenv().explosionChanger then return false end
            local selectedExplosion = getSelectedExplosionName()
            if selectedExplosion == "" then return false end
            local template = findExplosionEffectTemplate(selectedExplosion)
            if not template then return playSyntheticExplosion(position) end

            local clone = template:Clone()
            clone.Name = "LeviHubExplosion_" .. selectedExplosion

            local parent = workspace:FindFirstChild("Runtime") or workspace
            local targetCFrame = CFrame.new(position or Vector3.zero)

            if clone:IsA("Attachment") then
                local folder = Instance.new("Folder")
                folder.Name = "LeviHubExplosion_" .. selectedExplosion
                folder.Parent = parent

                local anchor = Instance.new("Part")
                anchor.Name = "LeviHubExplosionAnchor"
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.CanTouch = false
                anchor.CanQuery = false
                anchor.Transparency = 1
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.CFrame = targetCFrame
                anchor.Parent = folder

                clone.Parent = anchor
                clone = folder
            else
                clone.Parent = parent
            end

            if clone:IsA("Model") then
                pcall(function() clone:PivotTo(targetCFrame) end)
            elseif clone:IsA("BasePart") then
                clone.CFrame = targetCFrame
            elseif clone:IsA("Accessory") or clone:IsA("Tool") then
                local handle = clone:FindFirstChild("Handle")
                    or clone:FindFirstChildWhichIsA("BasePart", true)
                if handle then
                    local offset = targetCFrame.Position - handle.Position
                    for _, part in ipairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = part.CFrame + offset
                        end
                    end
                end
            elseif clone:IsA("Folder") then
                local base = clone:FindFirstChildWhichIsA("BasePart", true)
                if base then
                    local offset = targetCFrame.Position - base.Position
                    for _, part in ipairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = part.CFrame + offset
                        end
                    end
                else
                    local anchor = Instance.new("Part")
                    anchor.Name = "LeviHubExplosionAnchor"
                    anchor.Anchored = true
                    anchor.CanCollide = false
                    anchor.CanTouch = false
                    anchor.CanQuery = false
                    anchor.Transparency = 1
                    anchor.Size = Vector3.new(1, 1, 1)
                    anchor.CFrame = targetCFrame
                    anchor.Parent = clone
                    for _, child in ipairs(clone:GetDescendants()) do
                        if child:IsA("Attachment") and not child.Parent:IsA("BasePart") then
                            child.Parent = anchor
                        end
                    end
                end
            end

            activateLocalExplosionObject(clone)
            task.delay(8, function()
                if clone and clone.Parent then clone:Destroy() end
            end)
            return true
        end

        local function isLeviHubExplosionObject(object)
            local current = object
            while current and current ~= workspace do
                if type(current.Name) == "string"
                    and current.Name:find("LeviHubExplosion", 1, true) then
                    return true
                end
                current = current.Parent
            end
            return false
        end

        local function hideNativeExplosionVisual(object)
            if not object or isLeviHubExplosionObject(object) then return end
            local objects = { object }
            for _, descendant in ipairs(object:GetDescendants()) do
                objects[#objects + 1] = descendant
            end

            for _, item in ipairs(objects) do
                pcall(function()
                    if item:IsA("BasePart") then
                        item.Transparency = 1
                        item.LocalTransparencyModifier = 1
                        item.CanCollide = false
                        item.CanTouch = false
                        item.CanQuery = false
                    elseif item:IsA("ParticleEmitter") then
                        item.Enabled = false
                        item.Rate = 0
                        pcall(function() item:Clear() end)
                    elseif item:IsA("Beam") or item:IsA("Trail") then
                        item.Enabled = false
                    elseif item:IsA("Light") then
                        item.Enabled = false
                        item.Brightness = 0
                        item.Range = 0
                    elseif item:IsA("Sound") then
                        item.Volume = 0
                        pcall(function() item:Stop() end)
                    end
                end)
            end
        end

        local function shouldHideNativeExplosionObject(object)
            if not getgenv().explosionChanger then return false end
            if (getgenv()._lhxExplosionLocalKillUntil or 0) <= os.clock() then return false end
            if isLeviHubExplosionObject(object) then return false end

            local key = normalizeExplosionName(object and object.Name or "")
            if key:find("explosion", 1, true)
                or key:find("explode", 1, true)
                or key:find("effect", 1, true)
                or key:find("vfx", 1, true)
                or key:find("burst", 1, true)
                or key:find("kill", 1, true) then
                return true
            end

            local parent = object and object.Parent
            local parentKey = normalizeExplosionName(parent and parent.Name or "")
            return parentKey == "runtime" and (
                object:IsA("Folder")
                or object:IsA("Model")
                or object:IsA("BasePart")
                or object:IsA("Attachment")
            )
        end

        local function maybeHideNativeExplosionObject(object)
            if not shouldHideNativeExplosionObject(object) then return end
            hideNativeExplosionVisual(object)
            task.delay(0.03, function() hideNativeExplosionVisual(object) end)
            task.delay(0.12, function() hideNativeExplosionVisual(object) end)
            task.delay(0.3, function() hideNativeExplosionVisual(object) end)
        end

        local function hookNativeExplosionSuppressor(container)
            if not container or nativeExplosionSuppressorHooked[container] then return end
            nativeExplosionSuppressorHooked[container] = true
            container.ChildAdded:Connect(maybeHideNativeExplosionObject)
        end

        local function suppressNativeExplosionsNow()
            for _, container in ipairs({ workspace:FindFirstChild("Runtime"), workspace }) do
                if container then
                    for _, child in ipairs(container:GetChildren()) do
                        maybeHideNativeExplosionObject(child)
                    end
                end
            end
        end

        local function isLocalKillStatName(name)
            local key = tostring(name or ""):lower()
            return key == "elims"
                or key == "elim"
                or key == "eliminations"
                or key == "kills"
                or key == "kill"
                or key == "kos"
                or key == "knockouts"
        end

        local function numericStatValue(value)
            if type(value) == "number" then return value end
            if type(value) == "string" then return tonumber(value) end
            if typeof(value) == "Instance" then
                if value:IsA("IntValue")
                    or value:IsA("NumberValue")
                    or value:IsA("StringValue") then
                    return tonumber(value.Value)
                end
            end
            return nil
        end

        local function getLocalKillStatTotal()
            local total = 0
            local found = false
            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
            if leaderstats then
                for _, stat in ipairs(leaderstats:GetChildren()) do
                    if isLocalKillStatName(stat.Name) then
                        local value = numericStatValue(stat)
                        if value then
                            total += value
                            found = true
                        end
                    end
                end
            end
            for _, attributeName in ipairs({"PlayerElims", "Elims", "Eliminations", "Kills", "KillCount", "Knockouts"}) do
                local attributeValue = LocalPlayer:GetAttribute(attributeName)
                local value = numericStatValue(attributeValue)
                if value then
                    total += value
                    found = true
                end
            end
            return found and total or nil
        end

        local function playPendingKillExplosion()
            if not getgenv().explosionChanger and (not getgenv().finisherModel or getgenv().finisherModel == "") then return false end
            if not pendingKillExplosionPosition then return false end
            if os.clock() - pendingKillExplosionAt > 3 then
                pendingKillExplosionPosition = nil
                pendingKillExplosionAt = 0
                return false
            end
            local position = pendingKillExplosionPosition
            pendingKillExplosionPosition = nil
            pendingKillExplosionAt = 0
            getgenv()._lhxExplosionLocalKillUntil = os.clock() + 1.25
            if lastLocalExplosionPlayedPosition
                and os.clock() - lastLocalExplosionPlayedAt < 0.25
                and (lastLocalExplosionPlayedPosition - position).Magnitude < 8 then
                return false
            end
            lastLocalExplosionPlayedAt = os.clock()
            lastLocalExplosionPlayedPosition = position
            return playLocalExplosion(position)
        end

        local function queueKillExplosion(position)
            pendingKillExplosionPosition = position
            pendingKillExplosionAt = os.clock()
            if os.clock() - lastLocalKillAt <= 2.5 then
                playPendingKillExplosion()
            end
        end

        local function markLocalKill(position)
            lastLocalKillAt = os.clock()
            getgenv()._lhxExplosionLocalKillUntil = os.clock() + 1.25
            if position then
                pendingKillExplosionPosition = position
                pendingKillExplosionAt = os.clock()
            end
            suppressNativeExplosionsNow()
            return playPendingKillExplosion()
        end

        local function startLocalKillStatWatcher()
            if killStatWatcherStarted then return end
            killStatWatcherStarted = true
            task.spawn(function()
                while task.wait(0.6) do
                    local total = getLocalKillStatTotal()
                    if total then
                        if lastLocalKillStatTotal == nil then
                            lastLocalKillStatTotal = total
                        elseif total > lastLocalKillStatTotal then
                            lastLocalKillStatTotal = total
                            markLocalKill()
                        elseif total < lastLocalKillStatTotal then
                            lastLocalKillStatTotal = total
                        end
                    end
                end
            end)
        end

        local function patchExplosionTable(tbl, remoteKey, selectedExplosion, depth)
            if type(tbl) ~= "table" or depth > 2 then return false end
            local changed = false
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                if type(value) == "string" then
                    local keyLooksRight = keyText:find("explosion", 1, true)
                        or keyText:find("effect", 1, true)
                        or keyText:find("fx", 1, true)
                    if keyLooksRight or isKnownExplosionName(value) then
                        tbl[key] = selectedExplosion
                        changed = true
                    end
                elseif type(value) == "table" then
                    changed = patchExplosionTable(value, remoteKey, selectedExplosion, depth + 1) or changed
                end
            end
            return changed
        end

        local function patchExplosionArgs(remoteName, args, isOurKill)
            if not getgenv().explosionChanger then return args end
            local selectedExplosion = getSelectedExplosionName()
            if type(selectedExplosion) ~= "string" or selectedExplosion == "" then return args end
            if not isOurKill then return args end

            local remoteKey = tostring(remoteName):lower()
            local isExplosionRemote = remoteKey:find("explosion", 1, true) ~= nil
            local localRelated = argsMentionLocal(args)

            local changed = false

            for index, arg in ipairs(args) do
                if type(arg) == "string" and not isPlayerString(arg) then
                    local valueKey = arg:lower()
                    local shouldPatch = isKnownExplosionName(arg)
                        or isExplosionRemote
                        or (localRelated and (
                            valueKey:find("explosion", 1, true)
                            or valueKey:find("effect", 1, true)
                            or valueKey:find("fx", 1, true)
                        ))
                    if shouldPatch then
                        args[index] = selectedExplosion
                        changed = true
                    end
                elseif type(arg) == "table" then
                    changed = patchExplosionTable(arg, remoteKey, selectedExplosion, 0) or changed
                end
            end

            if isExplosionRemote and not changed then
                for index, arg in ipairs(args) do
                    if type(arg) == "string" and not isPlayerString(arg) then
                        args[index] = selectedExplosion
                        break
                    end
                end
            end

            return args
        end

        local function invokeExplosionRemote(remote, explosionName)
            if not remote or type(explosionName) ~= "string" or explosionName == "" then return false end
            local fired = false
            for _, args in ipairs({
                {explosionName},
                {"Explosion", explosionName},
                {"ExplosionFX", explosionName},
                {"KillEffect", explosionName},
                {explosionName, "Explosion"},
                {explosionName, "ExplosionFX"},
            }) do
                local ok = pcall(function()
                    if remote:IsA("RemoteFunction") then
                        remote:InvokeServer(unpack(args))
                    elseif remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    end
                end)
                fired = ok or fired
            end
            return fired
        end

        local function isExplosionBindable(instance)
            if typeof(instance) ~= "Instance" or not instance:IsA("BindableFunction") then return false end
            local nameKey = normalizeExplosionName(instance.Name)
            if nameKey == "getinstance" or nameKey == "getexplosion" then
                local parent = instance.Parent
                while parent and parent ~= rs do
                    if normalizeExplosionName(parent.Name):find("explosion", 1, true) then
                        return true
                    end
                    parent = parent.Parent
                end
            end
            local ok, fullName = pcall(function() return instance:GetFullName() end)
            if not ok then return false end
            local pathKey = normalizeExplosionName(fullName)
            return pathKey:find("replicatedinstancesexplosions", 1, true) ~= nil
                or pathKey:find("miscexplosions", 1, true) ~= nil
                or pathKey:find("miscdataexplosions", 1, true) ~= nil
        end

        local function installExplosionBindableHook()
            if bindableInvokeHooked then return end
            local hookFunction = getExecutorGlobal("hookfunction") or getExecutorGlobal("hookfunc")
            local makeClosure = getExecutorGlobal("newcclosure") or function(callback) return callback end
            if type(hookFunction) ~= "function" then return end

            local dummyBindable = Instance.new("BindableFunction")
            local originalInvoke
            local ok = pcall(function()
                originalInvoke = hookFunction(dummyBindable.Invoke, makeClosure(function(self, ...)
                    local args = { ... }
                    local localKillWindow = (getgenv()._lhxExplosionLocalKillUntil or 0) > os.clock()
                    if getgenv().explosionChanger and localKillWindow and isExplosionBindable(self) then
                        local selectedExplosion = getSelectedExplosionName()
                        if selectedExplosion ~= "" then
                            for index, value in ipairs(args) do
                                if type(value) == "string" and not isPlayerString(value) then
                                    args[index] = selectedExplosion
                                    break
                                end
                            end
                            if #args == 0 then
                                args[1] = selectedExplosion
                            end
                        end
                    end
                    return originalInvoke(self, unpack(args))
                end))
            end)
            dummyBindable:Destroy()
            bindableInvokeHooked = ok == true
        end

        local function findExplosionEquipRemotes()
            local remotes = {}
            local store = rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("Store")
            local net = getNetFolder()
            local function addRemote(remote)
                if not remote then return end
                for _, existing in ipairs(remotes) do
                    if existing == remote then return end
                end
                table.insert(remotes, remote)
            end

            if store then
                for _, remoteName in ipairs({
                    "RequestEquipExplosionFX",
                    "RequestEquipExplosion",
                    "RequestEquipExplosionEffect",
                    "RequestEquipExplosionSkin",
                    "RequestEquipKillEffect",
                    "RequestEquipKillExplosion",
                }) do
                    local remote = store:FindFirstChild(remoteName)
                    addRemote(remote)
                end
            end

            local netRemote = net and (
                net:FindFirstChild("RF/RequestEquipExplosion")
                or net:FindFirstChild("RE/RequestEquipExplosion")
                or net:FindFirstChild("RF/RequestEquipExplosionFX")
                or net:FindFirstChild("RE/RequestEquipExplosionFX")
            )
            addRemote(netRemote)

            if #remotes == 0 then
                for _, obj in ipairs(rs:GetDescendants()) do
                    if obj:IsA("RemoteFunction") or obj:IsA("RemoteEvent") then
                        local key = obj.Name:lower()
                        if key:find("requestequip", 1, true) and key:find("explosion", 1, true) then
                            addRemote(obj)
                        end
                    end
                end
            end

            return remotes
        end

        getgenv().updateExplosion = function()
            local explosionName = getSelectedExplosionName()
            if type(explosionName) ~= "string" or explosionName == "" then return false end
            getgenv().explosionFX = explosionName

            pcall(function() LocalPlayer:SetAttribute("CurrentlyEquippedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentlyEquippedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("SelectedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("SelectedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("KillEffect", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedKillEffect", explosionName) end)
            if LocalPlayer.Character then
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentlyEquippedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentlyEquippedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("SelectedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("SelectedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("KillEffect", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedKillEffect", explosionName) end)
            end

            if getgenv().saveLastEquippedExplosion then
                getgenv().saveLastEquippedExplosion(explosionName)
            end

            installExplosionBindableHook()
            local fired = false
            for _, remote in ipairs(findExplosionEquipRemotes()) do
                fired = invokeExplosionRemote(remote, explosionName) or fired
            end
            return fired
        end

        getgenv().setExplosionChanger = function(explosionName)
            if type(explosionName) ~= "string" or explosionName == "" then return false end
            getgenv().explosionFX = explosionName
            getgenv().explosionChanger = true
            if getgenv().setExplosionChangerToggleUI then getgenv().setExplosionChangerToggleUI(true) end
            if getgenv().setExplosionInputUI then getgenv().setExplosionInputUI(explosionName) end
            return getgenv().updateExplosion()
        end

        getgenv().testExplosion = function()
            local character = LocalPlayer.Character
            local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
            local camera = workspace.CurrentCamera
            local position = root and (root.Position + root.CFrame.LookVector * 7)
                or camera and (camera.CFrame.Position + camera.CFrame.LookVector * 12)
                or Vector3.zero
            return playLocalExplosion(position)
        end

        installExplosionBindableHook()
        startLocalKillStatWatcher()
        hookNativeExplosionSuppressor(workspace:FindFirstChild("Runtime"))
        hookNativeExplosionSuppressor(workspace)
        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Runtime" then
                hookNativeExplosionSuppressor(child)
            end
            maybeHideNativeExplosionObject(child)
        end)

        local function hookDeadFolder()
            if deadFolderHooked then return end
            local deadFolder = workspace:FindFirstChild("Dead")
            if not deadFolder then return end
            deadFolderHooked = true
            deadFolder.ChildAdded:Connect(function(character)
                if not getgenv().explosionChanger and (not getgenv().finisherModel or getgenv().finisherModel == "") then return end
                task.wait(0.05)
                if character == LocalPlayer.Character then return end

                local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
                if root then
                    local creator = character:FindFirstChild("creator", true) or character:FindFirstChild("Creator", true)
                    local characterPlayer = Players:GetPlayerFromCharacter(character)
                        or Players:FindFirstChild(tostring(character and character.Name or ""))

                    local isLocalKill = false
                    if creator and (creator.Value == LocalPlayer or creator.Value == LocalPlayer.Name) then
                        isLocalKill = true
                        markLocalKill(root.Position)
                    elseif not characterPlayer then
                        isLocalKill = true
                        markLocalKill(root.Position)
                    else
                        queueKillExplosion(root.Position)
                    end

                    if isLocalKill and getgenv().finisherModel and getgenv().finisherModel ~= "" and getgenv()._lhxFCModule then
                        if not characterPlayer then
                            task.spawn(function()
                                local s = pcall(function()
                                    getgenv()._lhxFCModule:Play(getgenv().finisherModel, character)
                                end)
                                if not s then
                                    pcall(function()
                                        getgenv()._lhxFCModule:Play(character, getgenv().finisherModel)
                                    end)
                                end
                            end)
                        end
                    end
                end
            end)
        end

        hookDeadFolder()
        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Dead" then
                deadFolderHooked = false
                task.defer(hookDeadFolder)
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function(character)
            task.wait(0.75)
            if getgenv().explosionChanger and getgenv().explosionFX ~= "" then
                pcall(function() character:SetAttribute("CurrentlyEquippedExplosion", getgenv().explosionFX) end)
                pcall(getgenv().updateExplosion)
            end
        end)

        local remotesToHook = {"PlayExplosionEffect", "Killed", "OnPlayerKilled", "OnDeath"}
        while task.wait(1) do
            local remotesFolder = rs:FindFirstChild("Remotes")
            if remotesFolder then
                for _, remoteName in ipairs(remotesToHook) do
                    local remote = remotesFolder:FindFirstChild(remoteName)
                    if remote and remote:IsA("RemoteEvent") then
                        if not explosionDirectHooked[remote] then
                            explosionDirectHooked[remote] = true
                            remote.OnClientEvent:Connect(function(...)
                                if not getgenv().explosionChanger then return end
                                local rawArgs = { ... }
                                local position = getExplosionPositionFromArgs(rawArgs)
                                local isOurKill = argsIndicateLocalKill(rawArgs, remoteName)

                                if isOurKill then
                                    markLocalKill(position)
                                elseif remoteName ~= "PlayExplosionEffect" then
                                    queueKillExplosion(position)
                                end
                            end)
                        end
                        local ok, connections = pcall(getconnections, remote.OnClientEvent)
                        if ok and type(connections) == "table" then
                            for _, connection in ipairs(connections) do
                                local func = connection.Function
                                if func and not explosionHookedFuncs[func] then
                                    if isourclosure and isourclosure(func) then
                                        explosionHookedFuncs[func] = true
                                        continue
                                    end
                                    explosionHookedFuncs[func] = true
                                    connection:Disable()
                                    local targetFunc = func
                                    local ourFunc
                                    ourFunc = function(...)
                                        local rawArgs = { ... }
                                        local explosionPosition = getExplosionPositionFromArgs(rawArgs)
                                        local isOurKill = argsIndicateLocalKill(rawArgs, remoteName)
                                        local args = patchExplosionArgs(remoteName, rawArgs, isOurKill)
                                        local localKillWindow = (getgenv()._lhxExplosionLocalKillUntil or 0) > os.clock()

                                        if getgenv().explosionChanger then
                                            if isOurKill then
                                                markLocalKill(explosionPosition)
                                            elseif remoteName ~= "PlayExplosionEffect" then
                                                queueKillExplosion(explosionPosition)
                                            end
                                            if remoteName == "PlayExplosionEffect" and (isOurKill or localKillWindow) then
                                                return
                                            end
                                        end
                                        if setthreadidentity then pcall(setthreadidentity, 2) end
                                        pcall(targetFunc, unpack(args))
                                    end
                                    explosionHookedFuncs[ourFunc] = true
                                    remote.OnClientEvent:Connect(ourFunc)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

do
    local FAVORITES_FILE = "LeviHubX/fav_swords.json"
    local favoriteSwords = {}

    local function loadFavs()
        table.clear(favoriteSwords)
        pcall(function()
            if isfile and readfile and isfile(FAVORITES_FILE) then
                local decoded = HttpService:JSONDecode(readfile(FAVORITES_FILE))
                if type(decoded) == "table" then
                    for _, swordName in ipairs(decoded) do
                        if type(swordName) == "string" and swordName ~= "" then
                            table.insert(favoriteSwords, swordName)
                        end
                    end
                end
            end
        end)
    end

    local function saveFavs()
        pcall(function()
            if isfolder and makefolder and not isfolder("LeviHubX") then
                makefolder("LeviHubX")
            end
            if writefile then
                writefile(FAVORITES_FILE, HttpService:JSONEncode(favoriteSwords))
            end
        end)
    end

    local function refreshFavList() end

    loadFavs()

    G.setLeviHubShopButtonText = function(button, text)
        if not button then return end
        for _, textObject in ipairs(button:GetDescendants()) do
            if textObject:IsA("TextLabel")
                or textObject:IsA("TextButton")
                or textObject:IsA("TextBox") then
                textObject.Text = text
            end
        end
        if button:IsA("TextButton") then
            button.Text = text
        end
    end

    G.forceLeviHubShopEquippedText = function(shop, button, kind, itemName)
        G._lhxShopForcedEquip = {
            Button = button,
            Kind = kind,
            Name = itemName,
            Until = os.clock() + 2.5,
        }

        local function applyOnce()
            local targetButton = button
            if (not targetButton or not targetButton.Parent) and shop and shop:FindFirstChild("Holder") then
                local infoBG = shop.Holder:FindFirstChild("InfoBG")
                targetButton = infoBG and (infoBG:FindFirstChild("BuyButton") or infoBG:FindFirstChild("EquipButton"))
                if not targetButton and infoBG then
                    for _, child in ipairs(infoBG:GetChildren()) do
                        if (child:IsA("TextButton") or child:IsA("ImageButton")) and not child.Name:lower():find("close") then
                            targetButton = child
                            break
                        end
                    end
                end
            end
            G.setLeviHubShopButtonText(targetButton, "Equipped")
        end

        applyOnce()
        task.spawn(function()
            while G._lhxShopForcedEquip and os.clock() < G._lhxShopForcedEquip.Until do
                applyOnce()
                task.wait(0.05)
            end
        end)
    end

    local function getSelectedShopItemName(infoBG, activePage)
        if not infoBG then return "" end

        local itemName = ""
        local bestY = math.huge
        local bestX = math.huge

        local function scoreTextLabel(label)
            if not label or not label:IsA("TextLabel") and not label:IsA("TextButton") and not label:IsA("TextBox") then
                return
            end
            if label.Visible == false then return end

            local text = tostring(label.Text or ""):gsub("<[^>]+>", "")
            text = text:gsub("^%s+", ""):gsub("%s+$", "")
            local cleanText = text:gsub(",", ""):gsub(" ", "")
            local lowered = text:lower()
            local isNumber = tonumber(cleanText) ~= nil

            if text == "" or text == "Title" or text == "Equip" or text == "Equipped" or text == "Buy" then return end
            if lowered == "sword" or lowered == "swords"
                or lowered == "explosion" or lowered == "explosions"
                or lowered == "skin" or lowered == "skins"
                or lowered == "shop" or lowered == "owned (unlocked)" then return end
            if isNumber or lowered:find("coins", 1, true) or lowered:find("owned", 1, true) then return end
            if #text < 4 or #text > 40 then return end

            local pos = label.AbsolutePosition
            local yPos = pos and pos.Y or math.huge
            local xPos = pos and pos.X or math.huge
            if yPos < bestY or (yPos == bestY and xPos < bestX) then
                bestY = yPos
                bestX = xPos
                itemName = text
            end
        end

        local function scan(parent)
            for _, child in ipairs(parent:GetChildren()) do
                scoreTextLabel(child)
                scan(child)
            end
        end

        local titleLabel = infoBG:FindFirstChild("Title", true)
            or infoBG:FindFirstChild("ItemName", true)
            or infoBG:FindFirstChild("Name", true)
            or infoBG:FindFirstChild("SwordName", true)
            or infoBG:FindFirstChild("ExplosionName", true)
            or infoBG:FindFirstChild("HeaderTitle", true)
        scoreTextLabel(titleLabel)
        scan(infoBG)
        if itemName == "" and activePage then
            scan(activePage)
        end

        return itemName
    end

    local function maintainShop(shop)
        local holder = shop and shop:FindFirstChild("Holder")
        if not holder then return end

        local pages = holder:FindFirstChild("Pages")
        for _, pageName in ipairs({"Sword", "Explosion"}) do
            local page = pages and pages:FindFirstChild(pageName)
            if page then
                local unownedHeader = page:FindFirstChild("HeaderTitle")
                if unownedHeader then
                    unownedHeader.Visible = false
                end

                for _, child in ipairs(page:GetDescendants()) do
                    if child.Name == "Lock" and child:IsA("GuiObject") then
                        child.Visible = false
                        local itemCard = child.Parent
                        if itemCard and itemCard:IsA("GuiObject") then
                            itemCard.LayoutOrder = 0
                            if itemCard.Parent and itemCard.Parent.Name == "Unowned" then
                                local ownedContainer = page:FindFirstChild("Owned", true)
                                if ownedContainer and ownedContainer:IsA("GuiObject") then
                                    itemCard.Parent = ownedContainer
                                end
                            end

                            local favBtn = itemCard:FindFirstChild("Favorite", true) or itemCard:FindFirstChild("Star", true)
                            local delBtn = itemCard:FindFirstChild("Delete", true) or itemCard:FindFirstChild("Trash", true)

                            if favBtn and favBtn:IsA("GuiObject") then favBtn.Visible = true end
                            if delBtn and delBtn:IsA("GuiObject") then delBtn.Visible = true end

                            if not itemCard:FindFirstChild("LeviHubHooked") then
                                local tag = Instance.new("BoolValue", itemCard)
                                tag.Name = "LeviHubHooked"

                                local itemName = itemCard.Name
                                local titleObj = itemCard:FindFirstChild("Title", true)
                                    or itemCard:FindFirstChild("ItemName", true)
                                    or itemCard:FindFirstChild("Name", true)
                                if titleObj and titleObj:IsA("TextLabel") then itemName = titleObj.Text end

                                if favBtn and (favBtn:IsA("GuiButton") or favBtn:IsA("ImageButton") or favBtn:IsA("TextButton")) then
                                    favBtn.MouseButton1Click:Connect(function()
                                        local found = false
                                        for _, swordName in ipairs(favoriteSwords) do
                                            if swordName == itemName then
                                                found = true
                                                break
                                            end
                                        end
                                        if not found then
                                            table.insert(favoriteSwords, itemName)
                                            pcall(function() saveFavs() end)
                                            pcall(function() refreshFavList() end)
                                        end
                                    end)
                                end

                                if delBtn and (delBtn:IsA("GuiButton") or delBtn:IsA("ImageButton") or delBtn:IsA("TextButton")) then
                                    delBtn.MouseButton1Click:Connect(function()
                                        for index, swordName in ipairs(favoriteSwords) do
                                            if swordName == itemName then
                                                table.remove(favoriteSwords, index)
                                                pcall(function() saveFavs() end)
                                                pcall(function() refreshFavList() end)
                                                break
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end

        local infoBG = holder:FindFirstChild("InfoBG")
        if not infoBG then return end

        local oldEquips = infoBG:FindFirstChild("Equips")
        local oldFinisherButton = (oldEquips and oldEquips:FindFirstChild("Finisher"))
            or infoBG:FindFirstChild("Finisher")
        if oldFinisherButton and oldFinisherButton:FindFirstChild("LeviUnlockAllFinisherHooked") then
            oldFinisherButton.Visible = false
        end

        local targetBtn = infoBG:FindFirstChild("BuyButton") or infoBG:FindFirstChild("EquipButton")

        if not targetBtn then
            for _, child in ipairs(infoBG:GetChildren()) do
                if (child:IsA("TextButton") or child:IsA("ImageButton")) and not child.Name:lower():find("close") then
                    targetBtn = child
                    break
                end
            end
        end

        if targetBtn then
            targetBtn.Visible = true

            if not targetBtn:FindFirstChild("LeviUnlockAllAlwaysVisible") then
                local visibleTag = Instance.new("BoolValue", targetBtn)
                visibleTag.Name = "LeviUnlockAllAlwaysVisible"
                targetBtn:GetPropertyChangedSignal("Visible"):Connect(function()
                    if G._lhxStandaloneUnlockAllLoaded and targetBtn.Parent and not targetBtn.Visible then
                        targetBtn.Visible = true
                    end
                end)
            end

            local currentPages = holder:FindFirstChild("Pages")
            local swordPage = currentPages and currentPages:FindFirstChild("Sword")
            local explosionPage = currentPages and currentPages:FindFirstChild("Explosion")
            local activeSkinPage = (swordPage and swordPage.Visible and swordPage)
                or (explosionPage and explosionPage.Visible and explosionPage)

            if not activeSkinPage then
                G._lhxShopForcedEquip = nil
                G.setLeviHubShopButtonText(targetBtn, "Equip")
                return
            end

            local activeKindForButton = activeSkinPage == explosionPage and "Explosion" or "Sword"
            local selectedItemName = getSelectedShopItemName(infoBG, activeSkinPage)
            local itemIsEquipped = false

            if activeKindForButton == "Sword" then
                itemIsEquipped = G._lhxSwordEquipSource == "Shop"
                    and selectedItemName ~= ""
                    and G._lhxEquippedShopSword == selectedItemName
            else
                itemIsEquipped = G._lhxExplosionEquipSource == "Shop"
                    and selectedItemName ~= ""
                    and G._lhxEquippedShopExplosion == selectedItemName
            end

            local forcedEquip = G._lhxShopForcedEquip
            local forcedMatches = forcedEquip
                and forcedEquip.Until
                and os.clock() < forcedEquip.Until
                and forcedEquip.Kind == activeKindForButton
                and forcedEquip.Name == selectedItemName
                and itemIsEquipped

            if forcedEquip and not forcedMatches then
                G._lhxShopForcedEquip = nil
            end

            G.setLeviHubShopButtonText(targetBtn, (itemIsEquipped or forcedMatches) and "Equipped" or "Equip")

            if not targetBtn:FindFirstChild("LeviUnlockAllEquipStateHooked") then
                local hookTag = Instance.new("BoolValue", targetBtn)
                hookTag.Name = "LeviUnlockAllEquipStateHooked"

                targetBtn.MouseButton1Click:Connect(function()
                    local livePages = shop.Holder and shop.Holder:FindFirstChild("Pages")
                    local liveSwordPage = livePages and livePages:FindFirstChild("Sword")
                    local liveExplosionPage = livePages and livePages:FindFirstChild("Explosion")
                    local activePage = (liveSwordPage and liveSwordPage.Visible and liveSwordPage)
                        or (liveExplosionPage and liveExplosionPage.Visible and liveExplosionPage)
                    local activeKind = activePage == liveExplosionPage and "Explosion" or "Sword"
                    if not activePage then
                        return
                    end

                    local liveInfoBG = shop.Holder:FindFirstChild("InfoBG")
                    if not liveInfoBG then
                        return
                    end

                    local itemName = ""
                    local bestY = math.huge
                    local bestX = math.huge

                    local function scoreTextLabel(label)
                        if not label or not label:IsA("TextLabel") and not label:IsA("TextButton") and not label:IsA("TextBox") then
                            return
                        end
                        if label.Visible == false then return end

                        local text = tostring(label.Text or ""):gsub("<[^>]+>", "")
                        text = text:gsub("^%s+", ""):gsub("%s+$", "")
                        local cleanText = text:gsub(",", ""):gsub(" ", "")
                        local lowered = text:lower()
                        local isNumber = tonumber(cleanText) ~= nil

                        if text == "" or text == "Title" or text == "Equip" or text == "Equipped" or text == "Buy" then return end
                        if lowered == "sword" or lowered == "swords"
                            or lowered == "explosion" or lowered == "explosions"
                            or lowered == "skin" or lowered == "skins"
                            or lowered == "shop" or lowered == "owned (unlocked)" then return end
                        if isNumber or lowered:find("coins", 1, true) or lowered:find("owned", 1, true) then return end
                        if #text < 4 or #text > 40 then return end

                        local pos = label.AbsolutePosition
                        local yPos = pos and pos.Y or math.huge
                        local xPos = pos and pos.X or math.huge
                        if yPos < bestY or (yPos == bestY and xPos < bestX) then
                            bestY = yPos
                            bestX = xPos
                            itemName = text
                        end
                    end

                    local function scan(parent)
                        for _, child in ipairs(parent:GetChildren()) do
                            scoreTextLabel(child)
                            scan(child)
                        end
                    end

                    local titleLabel = liveInfoBG:FindFirstChild("Title", true)
                        or liveInfoBG:FindFirstChild("ItemName", true)
                        or liveInfoBG:FindFirstChild("Name", true)
                        or liveInfoBG:FindFirstChild("SwordName", true)
                        or liveInfoBG:FindFirstChild("ExplosionName", true)
                        or liveInfoBG:FindFirstChild("HeaderTitle", true)
                    scoreTextLabel(titleLabel)
                    scan(liveInfoBG)
                    if itemName == "" then
                        scan(activePage)
                    end

                    if itemName ~= "" and itemName ~= "Title" then
                        if activeKind == "Explosion" then
                            G._lhxExplosionEquipSource = "Shop"
                            G._lhxEquippedShopExplosion = itemName
                        else
                            G._lhxSwordEquipSource = "Shop"
                            G._lhxEquippedShopSword = itemName
                        end

                        G.forceLeviHubShopEquippedText(shop, targetBtn, activeKind, itemName)

                        if activeKind == "Explosion" then
                            G.explosionFX = itemName
                            G.explosionChanger = true
                            if G.setExplosionChangerToggleUI then G.setExplosionChangerToggleUI(true) end
                            if G.setExplosionInputUI then G.setExplosionInputUI(itemName) end
                            G.setExplosionApplyText("Equipped")
                            if G.updateExplosion then
                                task.spawn(function()
                                    G.updateExplosion()
                                end)
                            end
                        else
                            G.swordModel = itemName
                            G.swordAnimations = itemName
                            G.swordFX = itemName
                            G.skinChanger = true

                            if G.setSkinChangerToggleUI then G.setSkinChangerToggleUI(true) end
                            if G.updateSword then G.updateSword() end
                        end

                        G.forceLeviHubShopEquippedText(shop, targetBtn, activeKind, itemName)
                    end
                end)
            end
        end

    end

    G.skinChanger = true
    G.explosionChanger = true
    G.unlockAllHooked = true

    task.spawn(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local announced = false
        while G._lhxStandaloneUnlockAllLoaded do
            local shop = playerGui:FindFirstChild("Shop")
            if shop then
                local ok, err = pcall(maintainShop, shop)
                if not ok then warn("[Unlock All] Shop update failed: " .. tostring(err)) end
                if not announced then
                    announced = true
                    print("[Unlock All] Ready. Open the normal Shop and use Equip on any sword or explosion.")
                end
            end
            task.wait(0.15)
        end
    end)
end

do
    local UserInputService = game:GetService("UserInputService")
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local previousGui = playerGui:FindFirstChild("LeviUnlockSwordMiniGui")
    if previousGui then previousGui:Destroy() end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LeviUnlockSwordMiniGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = false
    screenGui.DisplayOrder = 999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Name = "SwordInputPanel"
    panel.AnchorPoint = Vector2.new(0, 0.5)
    panel.Position = UDim2.new(0, 64, 0.62, 0)
    panel.Size = UDim2.fromOffset(240, 90)
    panel.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
    panel.BackgroundTransparency = 0.06
    panel.BorderSizePixel = 0
    panel.Active = true
    panel.Draggable = true
    panel.Parent = screenGui

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 10)
    panelCorner.Parent = panel

    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Color3.fromRGB(112, 95, 255)
    panelStroke.Transparency = 0.25
    panelStroke.Thickness = 1
    panelStroke.Parent = panel

    local panelScale = Instance.new("UIScale")
    panelScale.Name = "ResponsiveScale"
    panelScale.Parent = panel

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Position = UDim2.fromOffset(10, 7)
    title.Size = UDim2.new(1, -20, 0, 18)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamSemibold
    title.Text = "Sword model + animation + VFX"
    title.TextColor3 = Color3.fromRGB(242, 242, 248)
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local textBox = Instance.new("TextBox")
    textBox.Name = "SwordName"
    textBox.Position = UDim2.fromOffset(10, 30)
    textBox.Size = UDim2.new(1, -20, 0, 31)
    textBox.BackgroundColor3 = Color3.fromRGB(31, 34, 44)
    textBox.BorderSizePixel = 0
    textBox.ClearTextOnFocus = false
    textBox.Font = Enum.Font.GothamMedium
    textBox.PlaceholderText = "Type sword name, then press Enter"
    textBox.PlaceholderColor3 = Color3.fromRGB(142, 146, 160)
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 12
    textBox.TextTruncate = Enum.TextTruncate.AtEnd
    textBox.Parent = panel

    local textCorner = Instance.new("UICorner")
    textCorner.CornerRadius = UDim.new(0, 7)
    textCorner.Parent = textBox

    local textPadding = Instance.new("UIPadding")
    textPadding.PaddingLeft = UDim.new(0, 9)
    textPadding.PaddingRight = UDim.new(0, 9)
    textPadding.Parent = textBox

    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.Position = UDim2.fromOffset(10, 66)
    status.Size = UDim2.new(1, -20, 0, 15)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.Gotham
    status.Text = "Press Enter to apply — no button needed"
    status.TextColor3 = Color3.fromRGB(166, 169, 182)
    status.TextSize = 10
    status.TextTruncate = Enum.TextTruncate.AtEnd
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = panel

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "MobileToggle"
    toggleButton.AnchorPoint = Vector2.new(0, 0)
    toggleButton.Position = UDim2.new(0, 12, 0.62, -21)
    toggleButton.Size = UDim2.fromOffset(42, 42)
    toggleButton.AutoButtonColor = true
    toggleButton.BackgroundColor3 = Color3.fromRGB(104, 86, 255)
    toggleButton.BorderSizePixel = 0
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Text = "S"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 17
    toggleButton.ZIndex = 5
    toggleButton.Parent = screenGui

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton

    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = Color3.fromRGB(228, 224, 255)
    toggleStroke.Transparency = 0.35
    toggleStroke.Thickness = 1
    toggleStroke.Parent = toggleButton

    local toggleScale = Instance.new("UIScale")
    toggleScale.Name = "ResponsiveScale"
    toggleScale.Parent = toggleButton

    local function updateScale()
        local camera = workspace.CurrentCamera
        local viewportWidth = camera and camera.ViewportSize.X or 1280
        panelScale.Scale = math.clamp(viewportWidth / 1280, 0.72, 1)
        toggleScale.Scale = math.clamp(viewportWidth / 900, 0.82, 1)
    end

    updateScale()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
    end
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        updateScale()
        local camera = workspace.CurrentCamera
        if camera then
            camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
        end
    end)

    local toggleDragging = false
    local toggleDragInput
    local toggleDragStart
    local toggleStartPosition
    local toggleMoved = false

    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            toggleDragging = true
            toggleMoved = false
            toggleDragStart = input.Position
            toggleStartPosition = toggleButton.AbsolutePosition

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    toggleDragging = false
                end
            end)
        end
    end)

    toggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            toggleDragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not toggleDragging or input ~= toggleDragInput or not toggleDragStart or not toggleStartPosition then
            return
        end

        local delta = input.Position - toggleDragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            toggleMoved = true
        end

        local camera = workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
        local width = toggleButton.AbsoluteSize.X
        local height = toggleButton.AbsoluteSize.Y
        local x = math.clamp(toggleStartPosition.X + delta.X, 4, math.max(4, viewport.X - width - 4))
        local y = math.clamp(toggleStartPosition.Y + delta.Y, 4, math.max(4, viewport.Y - height - 4))
        toggleButton.Position = UDim2.fromOffset(x, y)
    end)

    toggleButton.Activated:Connect(function()
        if toggleMoved then
            toggleMoved = false
            return
        end
        panel.Visible = not panel.Visible
        toggleButton.Text = panel.Visible and "S" or "+"
    end)

    local submissionId = 0
    local function applySwordFromTextBox()
        local swordName = tostring(textBox.Text or "")
            :gsub("^%s+", "")
            :gsub("%s+$", "")
        if swordName == "" then
            status.Text = "Enter a sword name first"
            status.TextColor3 = Color3.fromRGB(255, 174, 174)
            return
        end

        submissionId += 1
        local thisSubmission = submissionId

        G._lhxSwordEquipSource = "SwordGui"
        G._lhxEquippedShopSword = nil
        G._lhxShopForcedEquip = nil
        G.swordModel = swordName
        G.swordAnimations = swordName
        G.swordFX = swordName
        G.skinChanger = true
        if G.setSkinChangerToggleUI then G.setSkinChangerToggleUI(true) end

        status.Text = "Applying: " .. swordName
        status.TextColor3 = Color3.fromRGB(205, 199, 255)

        task.spawn(function()
            for _ = 1, 100 do
                if thisSubmission ~= submissionId then return end
                if type(G.updateSword) == "function" then
                    local ok = pcall(G.updateSword)
                    if thisSubmission ~= submissionId then return end
                    if ok then
                        status.Text = "Applied: " .. swordName
                        status.TextColor3 = Color3.fromRGB(155, 235, 184)
                    else
                        status.Text = "Could not apply that sword"
                        status.TextColor3 = Color3.fromRGB(255, 174, 174)
                    end
                    return
                end
                task.wait(0.1)
            end

            if thisSubmission == submissionId then
                status.Text = "Sword backend is not ready"
                status.TextColor3 = Color3.fromRGB(255, 174, 174)
            end
        end)
    end

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            applySwordFromTextBox()
        end
    end)

    if UserInputService.TouchEnabled then
        toggleButton.TextSize = 18
    end
end
