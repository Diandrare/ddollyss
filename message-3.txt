local controlValueA = 3238
local controlValueB = 1420
local controlFlagA = true
local controlFlagB = true
do
    do
        do
            do
                do
                    do
                        do
                            do
                                do
                                    local secondaryValue
                                    do
                                        if _G.oxyFluent then
                                            return 
                                        end
                                        _G.oxyFluent = true
                                        cloneref = cloneref or function(inputValue)
                                            return inputValue
                                        end
                                        do
                                            local cloneReference = cloneref
                                            createInstance = Instance.new
                                            createTweenInfo = TweenInfo.new
                                            createUDim = UDim.new
                                            createUDim2 = UDim2.new
                                            fromOffset = UDim2.fromOffset
                                            createVector2 = Vector2.new
                                            createVector3 = Vector3.new
                                            createCFrame = CFrame.new
                                            colorFromRGB = Color3.fromRGB
                                            formatString = string.format
                                            clampValue = math.clamp
                                            floorValue = math.floor
                                            maxValue = math.max
                                            minValue = math.min
                                            arcSin = math.asin
                                            toRadians = math.rad
                                            randomValue = math.random
                                            bitwiseXor = bit32.bxor
                                            clearTable = table.clear
                                            concatTable = table.concat
                                            createTable = table.create
                                            findInTable = table.find
                                            insertIntoTable = table.insert
                                            stringByte = string.byte
                                            stringChar = string.char
                                            spawnTask = task.spawn
                                            delayTask = task.delay
                                            deferTask = task.defer
                                            waitTask = task.wait
                                            globalEnvironment = getgenv()
                                            ReplicatedStorage = cloneReference(game:GetService("ReplicatedStorage"))
                                            UserInputService = cloneReference(game:GetService("UserInputService"))
                                            httpService = cloneReference(game:GetService("HttpService"))
                                            local runService = cloneReference(game:GetService("RunService"))
                                            TweenService = cloneReference(game:GetService("TweenService"))
                                            Players = cloneReference(game:GetService("Players"))
                                            Debris = cloneReference(game:GetService("Debris"))
                                            local statsService = cloneReference(game:GetService("Stats"))
                                            Workspace = cloneReference(game:GetService("Workspace"))
                                            createTween = TweenService.Create
                                            repeat
                                                waitTask()
                                            until game:IsLoaded()
                                            localPlayer = Players.LocalPlayer
                                            name = localPlayer.Name
                                            currentCamera = Workspace.CurrentCamera
                                            Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
                                                currentCamera = Workspace.CurrentCamera
                                            end)
                                            remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
                                            packages = ReplicatedStorage.Packages
                                            controllers = ReplicatedStorage.Controllers
                                            balls = Workspace.Balls
                                            alive = Workspace.Alive
                                            runtime = Workspace.Runtime
                                            dataPing = statsService.Network.ServerStatsItem["Data Ping"]
                                            heartbeat = runService.Heartbeat
                                            preSimulation = runService.PreSimulation
                                            postSimulation = runService.PostSimulation
                                        end
                                    end
                                    swordEventConnections = {
                                        parry_connections = {
                                        },
                                        fire_sword_connections = {
                                        },
                                        play_parry = nil,
                                        sword_fn = nil,
                                    }
                                    if remotes and type(getconnections) == "function" then
                                        do
                                            local parrySuccessAll = remotes:WaitForChild("ParrySuccessAll", 10)
                                            if parrySuccessAll then
                                                local tertiaryValue, quaternaryValue = pcall(getconnections, parrySuccessAll.OnClientEvent)
                                                if tertiaryValue and type(quaternaryValue) == "table" then
                                                    for _, auxiliaryValue in quaternaryValue, nil, nil do
                                                        do
                                                            local candidateValue, resultValue = pcall(function()
                                                                return auxiliaryValue.Function
                                                            end)
                                                            if candidateValue and type(resultValue) == "function" then
                                                                insertIntoTable(swordEventConnections.parry_connections, auxiliaryValue)
                                                                swordEventConnections.play_parry = resultValue
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        local tertiaryValue = remotes:WaitForChild("FireSwordInfo", 10)
                                        if tertiaryValue then
                                            local quaternaryValue, auxiliaryValue = pcall(getconnections, tertiaryValue.OnClientEvent)
                                            if quaternaryValue and type(auxiliaryValue) == "table" then
                                                for _, candidateValue in auxiliaryValue, nil, nil do
                                                    local resultValue, errorValue = pcall(function()
                                                        return candidateValue.Function
                                                    end)
                                                    if resultValue and type(errorValue) == "function" then
                                                        insertIntoTable(swordEventConnections.fire_sword_connections, candidateValue)
                                                        swordEventConnections.sword_fn = errorValue
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    configStorage = {
                                        folder = "oxy",
                                    }
                                    configStorage.storage_ok = type(readfile) == "function" and type(writefile) == "function"
                                    configStorage.last_saved = {
                                    }
                                    configStorage.has_saved = false
                                    configStorage.defaults = {
                                        accuracy = 100,
                                        spam_threshold = 3,
                                        curve_keybind = false,
                                        manual_notify = false,
                                        curve_notify = false,
                                        curve_method = "camera",
                                        manual_spam = "E",
                                        mobile_triggerbot_button = false,
                                        mobile_manual_spam_button = false,
                                        ability_esp = false,
                                        auto_parry = false,
                                        ball_debug = false,
                                        auto_spam = false,
                                        random_target = false,
                                        unlock_all = false,
                                        last_equipped_sword = "",
                                        last_equipped_explosion = "",
                                        favorite_swords = {
                                        },
                                        favorite_explosions = {
                                        },
                                        deleted_swords = {
                                        },
                                        deleted_explosions = {
                                        },
                                        fflag_profile = "default",
                                        fflag_json = "",
                                        fflag_auto_load = false,
                                    }
                                    configStorage.path = configStorage.folder .. "/config.json"
                                    configStorage.fflag_folder = configStorage.folder .. "/fflags"
                                    configStorage.trim = function(inputValue)
                                        return tostring(inputValue or ""):match("^%s*(.-)%s*$")
                                    end
                                    configStorage.ensure_folder = function()
                                        local tertiaryValue = "function"
                                        if type(makefolder) ~= tertiaryValue then
                                            return 
                                        end
                                        local quaternaryValue = "function"
                                        local conditionFlagA = false
                                        if type(isfolder) == quaternaryValue then
                                            local auxiliaryValue
                                            auxiliaryValue, conditionFlagA = pcall(isfolder, configStorage.folder)
                                            conditionFlagA = auxiliaryValue and conditionFlagA
                                        end
                                        if not conditionFlagA then
                                            pcall(makefolder, configStorage.folder)
                                        end
                                    end
                                    configStorage.ensure_fflag_folder = function()
                                        configStorage.ensure_folder()
                                        if type(makefolder) ~= "function" then
                                            return 
                                        end
                                        local tertiaryValue = "function"
                                        local conditionFlagA = false
                                        if type(isfolder) == tertiaryValue then
                                            local quaternaryValue
                                            quaternaryValue, conditionFlagA = pcall(isfolder, configStorage.fflag_folder)
                                            conditionFlagA = quaternaryValue and conditionFlagA
                                        end
                                        if not conditionFlagA then
                                            pcall(makefolder, configStorage.fflag_folder)
                                        end
                                    end
                                    configStorage.copy = function(inputValue)
                                        local tertiaryValue = "table"
                                        if type(inputValue) ~= tertiaryValue then
                                            return inputValue
                                        end
                                        local ballState = {
                                        }
                                        for k, quaternaryValue in inputValue, nil, nil do
                                            ballState[k] = configStorage.copy(quaternaryValue)
                                        end
                                        return ballState
                                    end
                                    configStorage.equal = function(inputValue, secondaryInput)
                                        if inputValue == secondaryInput then
                                            return true
                                        end
                                        local tertiaryValue = "table"
                                        if type(inputValue) ~= tertiaryValue or type(secondaryInput) ~= "table" then
                                            return false
                                        end
                                        for k, quaternaryValue in inputValue, nil, nil do
                                            local auxiliaryValue = "table"
                                            if type(quaternaryValue) == auxiliaryValue then
                                                if not configStorage.equal(quaternaryValue, secondaryInput[k]) then
                                                    return false
                                                end
                                                continue
                                            end
                                            if secondaryInput[k] ~= quaternaryValue then
                                                return false
                                            end
                                        end
                                        for k in secondaryInput, nil, nil do
                                            if inputValue[k] == nil then
                                                return false
                                            end
                                        end
                                        return true
                                    end
                                    configStorage.valid_key = function(inputValue)
                                        if type(inputValue) ~= "string" then
                                            return false
                                        end
                                        local tertiaryValue, quaternaryValue = pcall(function()
                                            return Enum.KeyCode[inputValue]
                                        end)
                                        return tertiaryValue and quaternaryValue ~= nil
                                    end
                                    curveMethods = {
                                        "camera",
                                        "dot",
                                        "backwards",
                                        "slow",
                                        "random",
                                    }
                                    configStorage.normalize = function(inputValue)
                                        local ballState = {
                                        }
                                        for k, tertiaryValue in configStorage.defaults, nil, nil do
                                            local conditionFlagA = type(inputValue) == "table" and inputValue[k] or nil
                                            local quaternaryValue = "table"
                                            if type(tertiaryValue) == quaternaryValue then
                                                ballState[k] = type(conditionFlagA) == "table" and configStorage.copy(conditionFlagA) or configStorage.copy(tertiaryValue)
                                            else
                                                ballState[k] = type(conditionFlagA) == type(tertiaryValue) and conditionFlagA or tertiaryValue
                                            end
                                        end
                                        ballState.accuracy = clampValue(floorValue(ballState.accuracy + 0.5), 1, 100)
                                        ballState.spam_threshold = clampValue(floorValue(ballState.spam_threshold + 0.5), 1, 3)
                                        if not findInTable(curveMethods, ballState.curve_method) then
                                            ballState.curve_method = configStorage.defaults.curve_method
                                        end
                                        if not configStorage.valid_key(ballState.manual_spam) then
                                            ballState.manual_spam = configStorage.defaults.manual_spam
                                        end
                                        ballState.fflag_profile = configStorage.trim(ballState.fflag_profile)
                                        if ballState.fflag_profile == "" then
                                            ballState.fflag_profile = configStorage.defaults.fflag_profile
                                        end
                                        return ballState
                                    end
                                    do
                                        local data = nil
                                        if configStorage.storage_ok then
                                            configStorage.ensure_folder()
                                            pcall(function()
                                                data = httpService:JSONDecode(readfile(configStorage.path))
                                            end)
                                        end
                                        _G.config = configStorage.normalize(data)
                                    end
                                    config = _G.config
                                    configStorage.changed = function()
                                        if not configStorage.has_saved then
                                            return true
                                        end
                                        for k in configStorage.defaults, nil, nil do
                                            local tertiaryValue = configStorage.last_saved[k]
                                            local quaternaryValue = config[k]
                                            if type(tertiaryValue) == "table" or type(quaternaryValue) == "table" then
                                                if not configStorage.equal(tertiaryValue, quaternaryValue) then
                                                    return true
                                                end
                                                continue
                                            end
                                            if tertiaryValue ~= quaternaryValue then
                                                return true
                                            end
                                        end
                                        return false
                                    end
                                    configStorage.save = function()
                                        if not (not configStorage.storage_ok or not configStorage.changed()) then
                                            local ballState = {
                                            }
                                            for k, tertiaryValue in configStorage.defaults, nil, nil do
                                                local quaternaryValue = config[k]
                                                if type(tertiaryValue) == "table" then
                                                    ballState[k] = type(quaternaryValue) == "table" and configStorage.copy(quaternaryValue) or configStorage.copy(tertiaryValue)
                                                else
                                                    ballState[k] = type(quaternaryValue) == type(tertiaryValue) and quaternaryValue or tertiaryValue
                                                end
                                            end
                                            local tertiaryValue, quaternaryValue = pcall(function()
                                                return httpService:JSONEncode(ballState)
                                            end)
                                            if not tertiaryValue then
                                                return 
                                            end
                                            configStorage.ensure_folder()
                                            if not pcall(writefile, configStorage.path, quaternaryValue) then
                                                return 
                                            end
                                            for k in configStorage.defaults, nil, nil do
                                                local auxiliaryValue = ballState[k]
                                                configStorage.last_saved[k] = type(auxiliaryValue) == "table" and configStorage.copy(auxiliaryValue) or auxiliaryValue
                                            end
                                            configStorage.has_saved = true
                                            return 
                                        end
                                        if not (controlValueA <= 3227) then
                                            return 
                                        end
                                        while true do

                                        end
                                    end
                                    fflagProfiles = {
                                        dropdown = nil,
                                        path = function(inputValue)
                                            local tertiaryValue = configStorage.trim(inputValue)
                                            if tertiaryValue == "" then
                                                return nil, "profile name is empty"
                                            end
                                            local sanitizedProfileName = tertiaryValue:gsub("[<>:\"/\\|%?%*%c]", "_"):sub(1, 64)
                                            return configStorage.fflag_folder .. "/" .. sanitizedProfileName .. ".json", nil, sanitizedProfileName
                                        end,
                                        decode = function(inputValue)
                                            if type(inputValue) ~= "string" or configStorage.trim(inputValue) == "" then
                                                return nil, "fflags json is empty"
                                            end
                                            local tertiaryValue, quaternaryValue = pcall(function()
                                                return httpService:JSONDecode(inputValue)
                                            end)
                                            if not tertiaryValue or type(quaternaryValue) ~= "table" then
                                                return nil, "invalid fflags json"
                                            end
                                            local ballState = {
                                            }
                                            local auxiliaryValue = 0
                                            for k, candidateValue in quaternaryValue, nil, nil do
                                                local resultValue = "string"
                                                if type(k) ~= resultValue or configStorage.trim(k) == "" then
                                                    return nil, "every fflag needs a valid string name"
                                                end
                                                local errorValue = "string"
                                                if type(candidateValue) ~= errorValue and type(candidateValue) ~= "number" and type(candidateValue) ~= "boolean" then
                                                    return nil, "fflag values must be strings, numbers, or booleans"
                                                end
                                                ballState[k] = tostring(candidateValue)
                                                auxiliaryValue = auxiliaryValue + 1
                                            end
                                            if auxiliaryValue == 0 then
                                                return nil, "fflags json has no flags"
                                            end
                                            return ballState, nil, auxiliaryValue
                                        end,
                                        apply = function(inputValue)
                                            if type(setfflag) ~= "function" then
                                                return false, "setfflag is unavailable in this executor"
                                            end
                                            local tertiaryValue, quaternaryValue, auxiliaryValue = fflagProfiles.decode(inputValue)
                                            if not tertiaryValue then
                                                return false, quaternaryValue
                                            end
                                            local ballState = {
                                            }
                                            for k, candidateValue in tertiaryValue, nil, nil do
                                                if not pcall(setfflag, k, candidateValue) then
                                                    insertIntoTable(ballState, k)
                                                end
                                            end
                                            if #ballState > 0 then
                                                table.sort(ballState)
                                                return false, formatString("failed to apply %d/%d fflags: %s", #ballState, auxiliaryValue, concatTable(ballState, ", "))
                                            end
                                            return true, formatString("applied %d fflags", auxiliaryValue)
                                        end,
                                        save_profile = function(inputValue, secondaryInput)
                                            if not configStorage.storage_ok then
                                                return false, "file storage is unavailable"
                                            end
                                            local tertiaryValue, quaternaryValue = fflagProfiles.decode(secondaryInput)
                                            if not tertiaryValue then
                                                if true then
                                                    return false, quaternaryValue
                                                end
                                                while true do

                                                end
                                            end
                                            local auxiliaryValue, candidateValue, resultValue = fflagProfiles.path(inputValue)
                                            if not auxiliaryValue then
                                                return false, candidateValue
                                            end
                                            local errorValue, encodedValue = pcall(function()
                                                return httpService:JSONEncode(tertiaryValue)
                                            end)
                                            if not errorValue then
                                                return false, "could not encode the fflags profile"
                                            end
                                            configStorage.ensure_fflag_folder()
                                            if not pcall(writefile, auxiliaryValue, encodedValue) then
                                                return false, "could not save the fflags profile"
                                            end
                                            return true, encodedValue, resultValue
                                        end,
                                        load_profile = function(inputValue)
                                            if not configStorage.storage_ok then
                                                return false, "file storage is unavailable"
                                            end
                                            local tertiaryValue, quaternaryValue = fflagProfiles.path(inputValue)
                                            if not tertiaryValue then
                                                return false, quaternaryValue
                                            end
                                            local auxiliaryValue, candidateValue = pcall(readfile, tertiaryValue)
                                            if not auxiliaryValue or type(candidateValue) ~= "string" then
                                                return false, "fflags profile was not found"
                                            end
                                            local resultValue, errorValue = fflagProfiles.decode(candidateValue)
                                            if not resultValue then
                                                return false, errorValue
                                            end
                                            return true, candidateValue
                                        end,
                                        list = function()
                                            local tertiaryValue = "function"
                                            if type(listfiles) ~= tertiaryValue then
                                                return nil, "listfiles is unavailable in this executor"
                                            end
                                            configStorage.ensure_fflag_folder()
                                            local quaternaryValue, auxiliaryValue = pcall(listfiles, configStorage.fflag_folder)
                                            if not quaternaryValue or type(auxiliaryValue) ~= "table" then
                                                return nil, "could not list the fflags profiles"
                                            end
                                            local ballState = {
                                            }
                                            local spamController = {
                                            }
                                            for _, candidateValue in auxiliaryValue, nil, nil do
                                                local match = tostring(candidateValue):gsub("\\", "/"):match("([^/]+)%.json$")
                                                if match and not spamController[match] then
                                                    spamController[match] = true
                                                    insertIntoTable(ballState, match)
                                                end
                                            end
                                            table.sort(ballState, function(inputValue, secondaryInput)
                                                return inputValue:lower() < secondaryInput:lower()
                                            end)
                                            return ballState
                                        end,
                                        delete = function(inputValue)
                                            if type(delfile) ~= "function" then
                                                return false, "delfile is unavailable in this executor"
                                            end
                                            local tertiaryValue, quaternaryValue = fflagProfiles.path(inputValue)
                                            if not tertiaryValue then
                                                return false, quaternaryValue
                                            end
                                            if not pcall(delfile, tertiaryValue) then
                                                return false, "could not delete the fflags profile"
                                            end
                                            return true
                                        end,
                                    }
                                end
                            end
                            runtimeConnections = nil
                            if config.fflag_auto_load then
                                local secondaryValue
                                do
                                    local fflagJson = config.fflag_json
                                    local tertiaryValue
                                    tertiaryValue, secondaryValue = fflagProfiles.load_profile(config.fflag_profile)
                                    if tertiaryValue then
                                        config.fflag_json = secondaryValue
                                    else
                                        secondaryValue = fflagJson
                                    end
                                end
                                local tertiaryValue, quaternaryValue = fflagProfiles.apply(secondaryValue)
                                runtimeConnections = {
                                    ok = tertiaryValue,
                                    message = quaternaryValue,
                                }
                            end
                            configStorage.save()
                            spawnTask(function()
                                while _G.oxyFluent do
                                    waitTask(1)
                                    configStorage.save()
                                end
                            end)
                            local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
                            local oxy = Fluent:CreateWindow({
                                Title = "Oxy",
                                TabWidth = 145,
                                Size = UDim2.fromOffset(440, 315),
                                Acrylic = false,
                                Theme = "Dark",
                                MinimizeKey = Enum.KeyCode.LeftControl,
                            })
                            do
                                local combat = oxy:AddTab({ Title = "Combat", Icon = "swords" })
                                local visual2 = oxy:AddTab({ Title = "Visual", Icon = "eye" })
                                local misc2 = oxy:AddTab({ Title = "Misc", Icon = "settings" })
                                fflagsTab = oxy:AddTab({ Title = "FFlags", Icon = "file-json" })
                                local combatSection = combat:AddSection("")
                                local visualSection = visual2:AddSection("")
                                local miscSection = misc2:AddSection("")
                                parrySection = combatSection
                                curve = combatSection
                                spam = combatSection
                                hotkeys = combatSection
                                visual = visualSection
                                misc = miscSection
                            end
                        end
                        local profile, fflagsSection, profileNameInput, flagsJsonInput
                        do
                            do
                                profile = fflagsTab:AddSection("Profile")
                                fflagsSection = fflagsTab:AddSection("FFlags JSON")
                                notificationService = {
                                    notify = function(_, notification)
                                        Fluent:Notify({
                                            Title = notification.title,
                                            Content = notification.content,
                                            Duration = notification.duration,
                                        })
                                    end,
                                }
                            end
                            createGuiInstance = function(inputValue, secondaryInput)
                                local auxiliaryValue = createInstance(inputValue)
                                for k, candidateValue in secondaryInput, nil, nil do
                                    if k ~= "Parent" then
                                        auxiliaryValue[k] = candidateValue
                                    end
                                end
                                auxiliaryValue.Parent = secondaryInput.Parent
                                return auxiliaryValue
                            end
                            do
                                fflagProfiles.notify_result = function(inputValue, secondaryInput)
                                    notificationService:notify({
                                        title = inputValue and "fflags" or "fflags error",
                                        content = secondaryInput,
                                        duration = inputValue and 4 or 6,
                                    })
                                end
                                fflagProfiles.is_option = function(inputValue)
                                    return type(inputValue) == "string" and inputValue ~= "(no saved profiles)" and inputValue ~= "(profile listing unavailable)"
                                end
                                fflagProfiles.options = function()
                                    local auxiliaryValue, candidateValue = fflagProfiles.list()
                                    if not auxiliaryValue then
                                        return { "(profile listing unavailable)" }, candidateValue
                                    end
                                    if #auxiliaryValue == 0 then
                                        return { "(no saved profiles)" }
                                    end
                                    return auxiliaryValue
                                end
                                profileNameInput = profile:AddInput("ProfileName", {
                                    Title = "Profile name",
                                    Description = "Saved profile name",
                                    Default = config.fflag_profile,
                                    Placeholder = "default",
                                    Finished = true,
                                    Callback = function(inputValue)
                                        config.fflag_profile = configStorage.trim(inputValue)
                                    end,
                                })
                                flagsJsonInput = fflagsSection:AddInput("FflagsJson", {
                                    Title = "FFlags JSON",
                                    Description = "JSON object containing flag values",
                                    Default = config.fflag_json,
                                    Placeholder = "{\"DFIntTaskSchedulerTargetFps\":\"240\"}",
                                    Finished = true,
                                })
                                flagsJsonInput:OnChanged(function(fflagJson)
                                    config.fflag_json = fflagJson
                                end)
                            end
                        end
                        do
                            fflagProfiles.load_into_editor = function(inputValue)
                                local auxiliaryValue, candidateValue, resultValue = fflagProfiles.path(inputValue)
                                if not resultValue then
                                    return false, candidateValue
                                end
                                local errorValue, encodedValue = fflagProfiles.load_profile(resultValue)
                                if not errorValue then
                                    return false, encodedValue
                                end
                                config.fflag_profile = resultValue
                                config.fflag_json = encodedValue
                                profileNameInput:SetValue(resultValue)
                                flagsJsonInput:SetValue(encodedValue)
                                configStorage.save()
                                return true, resultValue
                            end
                            fflagProfiles.refresh_dropdown = function(inputValue)
                                local auxiliaryValue = fflagProfiles.options()
                                fflagProfiles.dropdown:SetValues(auxiliaryValue)
                                fflagProfiles.dropdown:SetValue(findInTable(auxiliaryValue, inputValue) and inputValue or auxiliaryValue[1])
                            end
                            do
                                local auxiliaryValue, candidateValue = fflagProfiles.options()
                                fflagProfiles.dropdown = profile:AddDropdown("SavedProfiles", {
                                    Title = "Saved profiles",
                                    Values = auxiliaryValue,
                                    Multi = false,
                                    Default = findInTable(auxiliaryValue, config.fflag_profile) and config.fflag_profile or auxiliaryValue[1],
                                    Callback = function(inputValue)
                                        if not fflagProfiles.is_option(inputValue) then
                                            return
                                        end
                                        local resultValue, errorValue = fflagProfiles.load_into_editor(inputValue)
                                        if not resultValue then
                                            fflagProfiles.notify_result(false, errorValue)
                                        end
                                    end,
                                })
                                if candidateValue then
                                    deferTask(function()
                                        fflagProfiles.notify_result(false, candidateValue)
                                    end)
                                end
                            end
                        end
                        profile:AddButton({ Title = "Save profile", Callback = function()
                            local auxiliaryValue, candidateValue, resultValue = fflagProfiles.save_profile(configStorage.trim(profileNameInput.Value), flagsJsonInput.Value)
                            if auxiliaryValue then
                                config.fflag_profile = resultValue
                                config.fflag_json = candidateValue
                                profileNameInput:SetValue(resultValue)
                                flagsJsonInput:SetValue(candidateValue)
                                configStorage.save()
                                fflagProfiles.refresh_dropdown(resultValue)
                                fflagProfiles.notify_result(true, formatString("saved profile '%s'", resultValue))
                            else
                                fflagProfiles.notify_result(false, candidateValue)
                            end
                        end })
                        profile:AddButton({ Title = "Load profile", Callback = function()
                            local loadIntoEditor = fflagProfiles.load_into_editor
                            local auxiliaryValue = table.pack(configStorage.trim(profileNameInput.Value))
                            auxiliaryValue.n = 1 + auxiliaryValue.n - 1
                            table.move(auxiliaryValue, 1, auxiliaryValue.n, 1, auxiliaryValue)
                            local candidateValue, resultValue = loadIntoEditor(table.unpack(auxiliaryValue, 1, auxiliaryValue.n))
                            if candidateValue then
                                if true then
                                    fflagProfiles.refresh_dropdown(resultValue)
                                    fflagProfiles.notify_result(true, formatString("loaded profile '%s'", resultValue))
                                else
                                    while true do

                                    end
                                end
                            else
                                fflagProfiles.notify_result(false, resultValue)
                            end
                        end })
                        do
                            local auxiliaryValue = profile:AddToggle("AutoLoad", {
                                Title = "Auto load profile",
                                Default = config.fflag_auto_load,
                                Callback = function(fflagAutoLoad)
                                config.fflag_auto_load = fflagAutoLoad
                                configStorage.save()
                            end,
                            })
                            profile:AddButton({ Title = "Set selected as auto load", Callback = function()
                                local candidateValue = fflagProfiles.dropdown.Value
                                if not fflagProfiles.is_option(candidateValue) then
                                    fflagProfiles.notify_result(false, "select a saved profile first")
                                    return 
                                end
                                local resultValue, errorValue = fflagProfiles.load_into_editor(candidateValue)
                                if not resultValue then
                                    fflagProfiles.notify_result(false, errorValue)
                                    return 
                                end
                                auxiliaryValue:SetValue(true)
                                fflagProfiles.notify_result(true, formatString("auto load set to '%s'", errorValue))
                            end })
                            profile:AddButton({ Title = "Delete selected profile", Callback = function()
                                local candidateValue = fflagProfiles.dropdown.Value
                                if not fflagProfiles.is_option(candidateValue) then
                                    fflagProfiles.notify_result(false, "select a saved profile first")
                                    return 
                                end
                                local resultValue, errorValue = fflagProfiles.delete(candidateValue)
                                if not resultValue then
                                    fflagProfiles.notify_result(false, errorValue)
                                    return 
                                end
                                if config.fflag_profile == candidateValue then
                                    config.fflag_profile = configStorage.defaults.fflag_profile
                                    config.fflag_json = ""
                                    profileNameInput:SetValue(configStorage.defaults.fflag_profile)
                                    flagsJsonInput:SetValue("")
                                    auxiliaryValue:SetValue(false)
                                end
                                fflagProfiles.refresh_dropdown()
                                configStorage.save()
                                fflagProfiles.notify_result(true, formatString("deleted profile '%s'", candidateValue))
                            end })
                        end
                        fflagsSection:AddParagraph({ Title = "Format", Content = "{\"FFlagName\":\"value\"}" })
                        fflagsSection:AddButton({ Title = "Apply FFlags", Callback = function()
                            config.fflag_profile = configStorage.trim(profileNameInput.Value)
                            config.fflag_json = flagsJsonInput.Value
                            configStorage.save()
                            local auxiliaryValue, candidateValue = fflagProfiles.apply(config.fflag_json)
                            fflagProfiles.notify_result(auxiliaryValue, candidateValue)
                        end })
                        if runtimeConnections then
                            deferTask(function()
                                fflagProfiles.notify_result(runtimeConnections.ok, runtimeConnections.message)
                            end)
                        end
                    end
                    local runtimeConnections, ballState, touchEnabled, keyboardEnabled, gamepadEnabled, spamController, abilityEspState, triggerbotState
                    do
                        local inventoryUnlockManager, curveController, swordAnimationState, parryController, helperFunction
                        do
                            local eventCapture
                            do
                                runtimeConnections = {
                                }
                                inventoryUnlockManager = {
                                    current = nil,
                                    visited = {
                                    },
                                }
                                curveController = {
                                    methods = curveMethods,
                                    dropdown = nil,
                                    syncing = false,
                                }
                                swordAnimationState = {
                                    active = nil,
                                    cache = {
                                    },
                                    tracks = {
                                    },
                                    api = nil,
                                    generation = 0,
                                    last_spam = 0,
                                    cancel_delay = 0.12,
                                    cancel_fraction = 0.35,
                                }
                                parryController = {
                                    count = 0,
                                    first_signal = nil,
                                }
                                pcall(function()
                                    swordAnimationState.api = require(ReplicatedStorage.Shared.SwordAPI)
                                end)
                                localPlayer.CharacterAdded:Connect(function()
                                    clearTable(swordAnimationState.tracks)
                                    swordAnimationState.active = nil
                                    swordAnimationState.generation = swordAnimationState.generation + 1
                                    swordAnimationState.last_spam = 0
                                end)
                                ballState = {
                                    state = {
                                        AerodynamicTime = tick(),
                                        LastWarping = tick(),
                                        LerpRadians = 0,
                                        Curving = tick(),
                                    },
                                    positions = {
                                    },
                                    replicator = nil,
                                }
                                helperFunction = function(inputValue, secondaryInput, tertiaryInput)
                                    return inputValue + (secondaryInput - inputValue) * tertiaryInput
                                end
                                eventCapture = {
                                    captured = {
                                    },
                                    hooked = {
                                    },
                                    originals = {
                                    },
                                    token_fn = nil,
                                }
                                for _, primaryValue in getgc(true) do
                                    if type(primaryValue) ~= "function" or not debug.info(primaryValue, "s"):find("PRY", 1, true) then
                                        continue
                                    else
                                        for _, secondaryValue in debug.getupvalues(primaryValue) do
                                            local tertiaryValue = "function"
                                            if type(secondaryValue) == tertiaryValue then
                                                print("found.")
                                                eventCapture.token_fn = secondaryValue
                                                break
                                            end
                                        end
                                        if not eventCapture.token_fn then
                                            continue
                                        end
                                    end
                                    break
                                end
                                eventCapture.tokenize = function(inputValue)
                                    local primaryValue = 100
                                    local secondaryValue = tostring(floorValue(Workspace:GetServerTimeNow() * primaryValue))
                                    local tertiaryValue = eventCapture.token_fn(inputValue, "TIME")
                                    local quaternaryValue = createTable(#secondaryValue)
                                    for i = 1, #secondaryValue do
                                        local auxiliaryValue = 256
                                        quaternaryValue[i] = stringChar(bitwiseXor((stringByte(secondaryValue, i) + i) % auxiliaryValue, stringByte(tertiaryValue, (i - 1) % #tertiaryValue + 1)))
                                    end
                                    return concatTable(quaternaryValue)
                                end
                                eventCapture.unhook = function()
                                    for k, primaryValue in eventCapture.originals, nil, nil do
                                        pcall(function()
                                            setreadonly(k, false)
                                            k.__index = primaryValue
                                            setreadonly(k, true)
                                        end)
                                    end
                                    clearTable(eventCapture.hooked)
                                    clearTable(eventCapture.originals)
                                end
                                eventCapture.valid_args = function(inputValue)
                                    return #inputValue == 8 and type(inputValue[2]) == "string" and type(inputValue[3]) == "string" and type(inputValue[4]) == "number" and typeof(inputValue[5]) == "CFrame" and type(inputValue[6]) == "table" and type(inputValue[7]) == "table" and type(inputValue[8]) == "boolean"
                                end
                                eventCapture.hook = function(inputValue)
                                    if next(eventCapture.captured) ~= nil then
                                        return 
                                    end
                                    local primaryValue = getrawmetatable(inputValue)
                                    if eventCapture.hooked[primaryValue] then
                                        return 
                                    end
                                    eventCapture.hooked[primaryValue] = true
                                    setreadonly(primaryValue, false)
                                    local index = primaryValue.__index
                                    eventCapture.originals[primaryValue] = index
                                    primaryValue.__index = function(secondaryInput, tertiaryInput)
                                        if tertiaryInput == "FireServer" and secondaryInput:IsA("RemoteEvent") or tertiaryInput == "InvokeServer" and secondaryInput:IsA("RemoteFunction") then
                                            return function(quaternaryInput, ...)
                                                local temporaryList = {
                                                    ...,
                                                }
                                                if eventCapture.valid_args(temporaryList) then
                                                    eventCapture.captured[secondaryInput] = temporaryList
                                                    eventCapture.unhook()
                                                end
                                                return index(secondaryInput, tertiaryInput)(quaternaryInput, unpack(temporaryList))
                                            end
                                        end
                                        return index(secondaryInput, tertiaryInput)
                                    end
                                    setreadonly(primaryValue, true)
                                end
                                for _, primaryValue in ReplicatedStorage:GetDescendants() do
                                    if primaryValue:IsA("RemoteEvent") or primaryValue:IsA("RemoteFunction") then
                                        eventCapture.hook(primaryValue)
                                    end
                                end
                                ballState.get = function()
                                    for _, primaryValue in balls:GetChildren() do
                                        if primaryValue:GetAttribute("realBall") then
                                            return primaryValue
                                        end
                                    end
                                    return nil
                                end
                                ballState.get_all = function()
                                    local temporaryList = {
                                    }
                                    for _, primaryValue in balls:GetChildren() do
                                        if primaryValue:GetAttribute("realBall") then
                                            insertIntoTable(temporaryList, primaryValue)
                                        end
                                    end
                                    return temporaryList
                                end
                                do
                                    local net = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("_Index") and ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.1.0") and ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"]:FindFirstChild("net")
                                    if net then
                                        if controlValueA <= 3223 then
                                            while true do

                                            end
                                        else
                                            for _, primaryValue in net:GetChildren() do
                                                if primaryValue:IsA("UnreliableRemoteEvent") and primaryValue.Name ~= "URE/ReplicateBallPosition" then
                                                    ballState.replicator = primaryValue
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if ballState.replicator then
                                ballState.replicator.OnClientEvent:Connect(function(inputValue, secondaryInput)
                                    if inputValue and inputValue.Parent == balls and inputValue:GetAttribute("realBall") == true then
                                        ballState.positions[inputValue] = secondaryInput
                                    end
                                end)
                            end
                            ballState.position = function(inputValue)
                                local primaryValue = inputValue or ballState.get()
                                if primaryValue then
                                    return ballState.positions[primaryValue] or primaryValue.Position
                                end
                                return Vector3.zero
                            end
                            inventoryUnlockManager.pick_random = function()
                                local temporaryList = {
                                }
                                for _, primaryValue in alive:GetChildren() do
                                    if primaryValue.Name ~= name and primaryValue.PrimaryPart then
                                        insertIntoTable(temporaryList, primaryValue)
                                    end
                                end
                                if #temporaryList == 0 then
                                    inventoryUnlockManager.current = nil
                                    return 
                                end
                                if #temporaryList == 1 then
                                    inventoryUnlockManager.current = temporaryList[1]
                                    return 
                                end
                                local temporaryMap = {
                                }
                                for _, primaryValue in temporaryList, nil, nil do
                                    if not inventoryUnlockManager.visited[primaryValue.Name] then
                                        insertIntoTable(temporaryMap, primaryValue)
                                    end
                                end
                                if #temporaryMap == 0 then
                                    inventoryUnlockManager.visited = {
                                    }
                                    for _, primaryValue in temporaryList, nil, nil do
                                        if not inventoryUnlockManager.current or primaryValue.Name ~= inventoryUnlockManager.current.Name then
                                            insertIntoTable(temporaryMap, primaryValue)
                                        end
                                    end
                                    if #temporaryMap == 0 then
                                        temporaryMap = temporaryList
                                    end
                                end
                                local primaryValue = temporaryMap[randomValue(1, #temporaryMap)]
                                inventoryUnlockManager.visited[primaryValue.Name] = true
                                inventoryUnlockManager.current = primaryValue
                            end
                            touchEnabled = UserInputService.TouchEnabled
                            do
                                local mouseEnabled = UserInputService.MouseEnabled
                                keyboardEnabled = UserInputService.KeyboardEnabled
                                gamepadEnabled = UserInputService.GamepadEnabled
                                inventoryUnlockManager.by_mouse = function()
                                    local temporaryList = {
                                    }
                                    for _, primaryValue in alive:GetChildren() do
                                        if primaryValue.Name ~= name and primaryValue.PrimaryPart then
                                            insertIntoTable(temporaryList, primaryValue)
                                        end
                                    end
                                    if #temporaryList == 0 then
                                        inventoryUnlockManager.current = nil
                                        return nil
                                    end
                                    local currentCamera2 = currentCamera or Workspace.CurrentCamera
                                    local cFrame = currentCamera2.CFrame
                                    local position = cFrame.Position
                                    local lookVector = cFrame.LookVector
                                    local direction
                                    if mouseEnabled then
                                        local mouseLocation = UserInputService:GetMouseLocation()
                                        direction = currentCamera2:ScreenPointToRay(mouseLocation.X, mouseLocation.Y).Direction
                                    else
                                        local viewportSize = currentCamera2.ViewportSize
                                        direction = currentCamera2:ViewportPointToRay(viewportSize.X * 0.5, viewportSize.Y * 0.5).Direction
                                    end
                                    local calculationA = -math.huge
                                    local primaryValue = nil
                                    for _, secondaryValue in temporaryList, nil, nil do
                                        local calculationB = secondaryValue.PrimaryPart.Position - position
                                        if calculationB.Magnitude > 0 then
                                            local unit = calculationB.Unit
                                            if lookVector:Dot(unit) > 0 then
                                                local tertiaryValue = direction:Dot(unit)
                                                if calculationA < tertiaryValue then
                                                    calculationA = tertiaryValue
                                                    primaryValue = secondaryValue
                                                end
                                            end
                                        end
                                    end
                                    primaryValue = primaryValue or temporaryList[1]
                                    inventoryUnlockManager.current = primaryValue
                                    return primaryValue
                                end
                                inventoryUnlockManager.closest = function()
                                    if config.random_target then
                                        if not inventoryUnlockManager.current then
                                            inventoryUnlockManager.pick_random()
                                        end
                                        return inventoryUnlockManager.current
                                    end
                                    return inventoryUnlockManager.by_mouse()
                                end
                                curveController.get_cframe = function()
                                    local cFrame = (currentCamera or Workspace.CurrentCamera).CFrame
                                    local character = localPlayer.Character
                                    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                                    if not humanoidRootPart then
                                        return cFrame
                                    end
                                    local position = inventoryUnlockManager.current and inventoryUnlockManager.current.PrimaryPart and inventoryUnlockManager.current.PrimaryPart.Position or humanoidRootPart.Position + cFrame.LookVector * 1000
                                    local unit = (position - humanoidRootPart.Position).Unit
                                    local curveMethod = config.curve_method
                                    if curveMethod == "dot" then
                                        return CFrame.lookAt(humanoidRootPart.Position, position + createVector3(0, 1.75, 0))
                                    end
                                    if curveMethod == "backwards" then
                                        return createCFrame(humanoidRootPart.Position, humanoidRootPart.Position + -unit * 1000)
                                    end
                                    if curveMethod == "slow" then
                                        return createCFrame(humanoidRootPart.Position, humanoidRootPart.Position + createVector3(0, -350, 0))
                                    end
                                    if curveMethod == "random" then
                                        local position2 = humanoidRootPart.Position
                                        local primaryValue = 1000
                                        return createCFrame(position2, position + createVector3(randomValue(-1000, 1000), randomValue(-350, 1000), randomValue(-1000, primaryValue)))
                                    end
                                    return cFrame
                                end
                                curveController.sync_dropdown = function(inputValue)
                                    curveController.syncing = true
                                    curveController.dropdown:SetValue(inputValue)
                                    curveController.syncing = false
                                end
                                swordAnimationState.find = function(inputValue)
                                    local grabParry = inputValue:FindFirstChild("GrabParry") or inputValue:FindFirstChild("Parry") or inputValue:FindFirstChild("Grab")
                                    if grabParry then
                                        return grabParry
                                    end
                                    local base = inputValue:FindFirstChild("Base")
                                    if base then
                                        return base:FindFirstChild("GrabParry") or base:FindFirstChild("Parry") or base:FindFirstChild("Grab")
                                    end
                                    return nil
                                end
                                swordAnimationState.resolve = function(inputValue, secondaryInput)
                                    if not secondaryInput then
                                        return nil
                                    end
                                    if swordAnimationState.cache[secondaryInput] and swordAnimationState.cache[secondaryInput].Parent then
                                        return swordAnimationState.cache[secondaryInput]
                                    end
                                    local primaryValue = ReplicatedStorage:FindFirstChild("Shared")
                                    if not primaryValue then
                                        return nil
                                    end
                                    local swords = primaryValue:FindFirstChild("ReplicatedInstances")
                                    swords = swords and swords:FindFirstChild("Swords")
                                    local secondaryValue = swords and swords:FindFirstChild("GetSword")
                                    local tertiaryValue = nil
                                    if secondaryValue then
                                        pcall(function()
                                            tertiaryValue = secondaryValue:Invoke(secondaryInput)
                                        end)
                                    end
                                    local animationType = tertiaryValue and tertiaryValue.AnimationType or "Single"
                                    local swordType = tertiaryValue and tertiaryValue.SwordType or "Single"
                                    if swordAnimationState.api and type(swordAnimationState.api.GetAnimations) == "function" then
                                        local quaternaryValue, auxiliaryValue = pcall(function()
                                            return swordAnimationState.api:GetAnimations(inputValue, {
                                                "Parry",
                                                "GrabParry",
                                            }, animationType, swordType)
                                        end)
                                        if quaternaryValue and type(auxiliaryValue) == "table" and auxiliaryValue[1] then
                                            swordAnimationState.cache[secondaryInput] = auxiliaryValue[1]
                                            return auxiliaryValue[1]
                                        end
                                    end
                                    local swordAPI = primaryValue:FindFirstChild("SwordAPI")
                                    if swordAPI then
                                        swordAPI = swordAPI:FindFirstChild("Collection") or swordAPI
                                    end
                                    if swordAPI then
                                        local quaternaryValue = swordAPI:FindFirstChild(animationType)
                                        if quaternaryValue then
                                            local auxiliaryValue = swordAnimationState.find(quaternaryValue)
                                            if auxiliaryValue then
                                                swordAnimationState.cache[secondaryInput] = auxiliaryValue
                                                return auxiliaryValue
                                            end
                                        end
                                        local default = swordAPI:FindFirstChild("Default")
                                        if default then
                                            local auxiliaryValue = swordAnimationState.find(default)
                                            if auxiliaryValue then
                                                swordAnimationState.cache[secondaryInput] = auxiliaryValue
                                                return auxiliaryValue
                                            end
                                        end
                                    end
                                    return nil
                                end
                                swordAnimationState.grab = function(inputValue)
                                    local character = localPlayer.Character
                                    if not character then
                                        return false
                                    end
                                    local primaryValue = character:FindFirstChildOfClass("Humanoid")
                                    local animator = primaryValue and primaryValue:FindFirstChildOfClass("Animator")
                                    if not primaryValue or not animator then
                                        return false
                                    end
                                    local swordAnimations
                                    if globalEnvironment and globalEnvironment.skinChangerEnabled and globalEnvironment.swordAnimations then
                                        swordAnimations = globalEnvironment.swordAnimations
                                    else
                                        swordAnimations = character:GetAttribute("CurrentlyEquippedSword") or "Base Sword"
                                    end
                                    local secondaryValue = swordAnimationState.resolve(character, swordAnimations)
                                    if not secondaryValue then
                                        return false
                                    end
                                    local temporaryList = swordAnimationState.tracks[animator]
                                    if not temporaryList then
                                        temporaryList = {
                                        }
                                        swordAnimationState.tracks[animator] = temporaryList
                                    end
                                    local tertiaryValue = temporaryList[secondaryValue]
                                    if not tertiaryValue or not tertiaryValue.Parent or tertiaryValue.Parent ~= animator then
                                        local quaternaryValue
                                        quaternaryValue, tertiaryValue = pcall(function()
                                            return animator:LoadAnimation(secondaryValue)
                                        end)
                                        if not quaternaryValue or not tertiaryValue then
                                            return false
                                        end
                                        for k, auxiliaryValue in secondaryValue:GetAttributes() do
                                            tertiaryValue:SetAttribute(k, auxiliaryValue)
                                        end
                                        tertiaryValue:SetAttribute("GrabParry", true)
                                        tertiaryValue.Priority = Enum.AnimationPriority.Action4
                                        temporaryList[secondaryValue] = tertiaryValue
                                    end
                                    if inputValue then
                                        local quaternaryValue = tick()
                                        if quaternaryValue - swordAnimationState.last_spam < swordAnimationState.cancel_delay then
                                            local conditionFlagA = false
                                            if swordAnimationState.active then
                                                pcall(function()
                                                    conditionFlagA = swordAnimationState.active.IsPlaying
                                                end)
                                            end
                                            if conditionFlagA then
                                                character:SetAttribute("ParryTime", maxValue(character:GetAttribute("ParryTime") or 0, swordAnimationState.active.Length ~= 0 and swordAnimationState.active.Length or 1))
                                                return true
                                            end
                                        end
                                        swordAnimationState.last_spam = quaternaryValue
                                    else
                                        swordAnimationState.last_spam = 0
                                    end
                                    swordAnimationState.generation = swordAnimationState.generation + 1
                                    local generation = swordAnimationState.generation
                                    for _, quaternaryValue in animator:GetPlayingAnimationTracks() do
                                        if quaternaryValue:GetAttribute("GrabParry") or quaternaryValue:GetAttribute("Parry") or quaternaryValue:GetAttribute("SuccessParry") then
                                            pcall(quaternaryValue.Stop, quaternaryValue, quaternaryValue:GetAttribute("StopFadeTime") or 0.05)
                                        end
                                    end
                                    local attribute = secondaryValue:GetAttribute("PlayFadeTime") or 0.05
                                    local attribute2 = secondaryValue:GetAttribute("PlayWeight") or 1
                                    local attribute3 = secondaryValue:GetAttribute("PlaySpeed") or 1
                                    tertiaryValue.TimePosition = 0
                                    tertiaryValue:Play(attribute, attribute2, attribute3)
                                    swordAnimationState.active = tertiaryValue
                                    character:SetAttribute("ParryTime", maxValue(character:GetAttribute("ParryTime") or 0, tertiaryValue.Length ~= 0 and (tertiaryValue.Length - tertiaryValue.TimePosition) * attribute3 or 1))
                                    if inputValue then
                                        local cancelDelay = swordAnimationState.cancel_delay
                                        local length = tertiaryValue.Length or 0
                                        local calculationA
                                        if not (length > 0) then
                                            calculationA = cancelDelay
                                        else
                                            calculationA = minValue(cancelDelay, length * swordAnimationState.cancel_fraction)
                                        end
                                        if calculationA < 0.05 then
                                            calculationA = 0.05
                                        end
                                        local quaternaryValue = tertiaryValue
                                        local attribute4 = secondaryValue:GetAttribute("StopFadeTime") or 0.05
                                        delayTask(calculationA, function()
                                            if generation ~= swordAnimationState.generation or swordAnimationState.active ~= quaternaryValue then
                                                return 
                                            end
                                            pcall(quaternaryValue.Stop, quaternaryValue, attribute4)
                                        end)
                                    end
                                    return true
                                end
                                parryController.fire = function(inputValue)
                                    local currentCamera2 = currentCamera or Workspace.CurrentCamera
                                    if not config.random_target then
                                        local primaryValue = 4096
                                        if true then
                                            inventoryUnlockManager.by_mouse()
                                        else
                                            while true do

                                            end
                                        end
                                    end
                                    local primaryValue = curveController.get_cframe()
                                    local primaryPart = inventoryUnlockManager.current and inventoryUnlockManager.current.PrimaryPart
                                    local temporaryList
                                    if primaryPart then
                                        local secondaryValue = currentCamera2:WorldToViewportPoint(primaryPart.Position)
                                        temporaryList = {
                                            secondaryValue.X,
                                            secondaryValue.Y,
                                        }
                                    elseif mouseEnabled then
                                        local mouseLocation = UserInputService:GetMouseLocation()
                                        temporaryList = {
                                            mouseLocation.X,
                                            mouseLocation.Y,
                                        }
                                    else
                                        local viewportSize = currentCamera2.ViewportSize
                                        temporaryList = {
                                            viewportSize.X * 0.5,
                                            viewportSize.Y * 0.5,
                                        }
                                    end
                                    local temporaryMap = {
                                    }
                                    for _, secondaryValue in alive:GetChildren() do
                                        local primaryPart2 = secondaryValue.PrimaryPart
                                        if primaryPart2 then
                                            local tertiaryValue = currentCamera2:WorldToScreenPoint(primaryPart2.Position)
                                            if tertiaryValue and tertiaryValue.Z > 0 then
                                                temporaryMap[secondaryValue.Name] = tertiaryValue
                                            end
                                        end
                                    end
                                    if next(eventCapture.captured) == nil then
                                        if not parryController.first_signal then
                                            parryController.first_signal = require(packages.Signal).new()
                                            parryController.first_signal:Connect(require(controllers["SwordsController \12"].PRY))
                                        end
                                        parryController.first_signal:Fire(0.5, primaryValue, temporaryMap, temporaryList, false)
                                        if inputValue then
                                            swordAnimationState.grab(true)
                                        end
                                    else
                                        swordAnimationState.grab(inputValue)
                                        for k, secondaryValue in eventCapture.captured, nil, nil do
                                            local parryArguments = {
                                            }
                                            local tertiaryValue = secondaryValue[1]
                                            local quaternaryValue = secondaryValue[2]
                                            local auxiliaryValue = eventCapture.tokenize(secondaryValue[2])
                                            local candidateValue = 0.5
                                            parryArguments[1] = tertiaryValue
                                            parryArguments[2] = quaternaryValue
                                            parryArguments[3] = auxiliaryValue
                                            parryArguments[4] = candidateValue
                                            parryArguments[5] = primaryValue
                                            parryArguments[6] = temporaryMap
                                            parryArguments[7] = temporaryList
                                            parryArguments[8] = false
                                            if k:IsA("RemoteEvent") then
                                                k:FireServer(unpack(parryArguments))
                                            elseif k:IsA("RemoteFunction") then
                                                k:InvokeServer(unpack(parryArguments))
                                            end
                                        end
                                    end
                                    if parryController.count > 7 then
                                        return false
                                    end
                                    parryController.count = parryController.count + 1
                                    delayTask(0.5, function()
                                        if parryController.count > 0 then
                                            parryController.count = parryController.count - 1
                                        end
                                    end)
                                end
                            end
                        end
                        spamController = {
                            distance = 0,
                            last_auto = 0,
                            manual_on = false,
                            manual_key = Enum.KeyCode.E,
                            mobile_button = nil,
                        }
                        do
                            local parryState = {
                                debounce = false,
                                until_at = 0,
                                accuracy = 1.5,
                            }
                            abilityEspState = {
                                labels = {
                                },
                            }
                            triggerbotState = {
                                on = false,
                                busy = false,
                                key = Enum.KeyCode.T,
                                button = nil,
                            }
                            ballState.curved = function(inputValue)
                                local primaryValue = inputValue or ballState.get()
                                if primaryValue then
                                    local zoomies = primaryValue:FindFirstChild("zoomies")
                                    if not zoomies then
                                        return false
                                    end
                                    local secondaryValue = tick()
                                    local value = dataPing:GetValue()
                                    local vectorVelocity = zoomies.VectorVelocity
                                    local unit = vectorVelocity.Unit
                                    local position = localPlayer.Character.PrimaryPart.Position
                                    local tertiaryValue = ballState.position(primaryValue)
                                    local unit2 = (position - tertiaryValue).Unit
                                    local quaternaryValue = unit2:Dot(unit)
                                    local magnitude = vectorVelocity.Magnitude
                                    local auxiliaryValue = minValue(magnitude / 100, 40)
                                    local calculationA = quaternaryValue - unit2:Dot((unit - vectorVelocity).Unit)
                                    local magnitude2 = (position - tertiaryValue).Magnitude
                                    local calculationB = 0.5 - value / 1000
                                    local calculationC = magnitude2 / magnitude - value / 1000
                                    local calculationD = 15 - minValue(magnitude2 / 1000, 15) + auxiliaryValue
                                    local candidateValue = 0.8
                                    ballState.state.LerpRadians = helperFunction(ballState.state.LerpRadians, toRadians(arcSin(clampValue(quaternaryValue, -1, 1))), candidateValue)
                                    if magnitude > 100 and calculationC > value / 10 then
                                        calculationD = maxValue(calculationD - 15, 15)
                                    end
                                    if magnitude2 < calculationD then
                                        return false
                                    end
                                    if calculationA < calculationB then
                                        return true
                                    end
                                    if ballState.state.LerpRadians < 0.018 then
                                        ballState.state.LastWarping = secondaryValue
                                    end
                                    if secondaryValue - ballState.state.LastWarping < calculationC / 1.5 then
                                        return true
                                    end
                                    if secondaryValue - ballState.state.Curving < calculationC / 1.5 then
                                        return true
                                    end
                                    return quaternaryValue < calculationB
                                end
                                if not (controlValueA >= 3245) then
                                    return false
                                end
                                while true do

                                end
                            end
                            ballState.props = function()
                                local primaryValue = ballState.get()
                                local vector3 = Vector3.zero
                                local unit = (localPlayer.Character.PrimaryPart.Position - ballState.position(primaryValue)).Unit
                                return {
                                    Velocity = vector3,
                                    Direction = unit,
                                    Distance = (localPlayer.Character.PrimaryPart.Position - ballState.position(primaryValue)).Magnitude,
                                    Dot = unit:Dot(vector3.Unit),
                                }
                            end
                            inventoryUnlockManager.props = function()
                                local current = inventoryUnlockManager.current or inventoryUnlockManager.closest()
                                if not current or not current.PrimaryPart then
                                    return false
                                end
                                local position = localPlayer.Character.PrimaryPart.Position
                                return {
                                    velocity = current.PrimaryPart.Velocity,
                                    direction = (position - current.PrimaryPart.Position).Unit,
                                    distance = (position - current.PrimaryPart.Position).Magnitude,
                                }
                            end
                            spamController.perform = function(inputValue)
                                local primaryValue = ballState.get()
                                local current = inventoryUnlockManager.current or inventoryUnlockManager.closest()
                                if not primaryValue then
                                    return false
                                end
                                if not current or not current.PrimaryPart then
                                    return false
                                end
                                local assemblyLinearVelocity = primaryValue.AssemblyLinearVelocity
                                local magnitude = assemblyLinearVelocity.Magnitude
                                local secondaryValue = (localPlayer.Character.PrimaryPart.Position - ballState.position(primaryValue)).Unit:Dot(assemblyLinearVelocity.Unit)
                                local tertiaryValue = localPlayer:DistanceFromCharacter(current.PrimaryPart.Position)
                                local calculationA = inputValue.Ping + minValue(magnitude / 6, 95)
                                if inputValue.Entity_Properties.distance > calculationA then
                                    return spamController.distance
                                end
                                if calculationA < inputValue.Ball_Properties.Distance then
                                    return spamController.distance
                                end
                                if calculationA < tertiaryValue then
                                    return spamController.distance
                                end
                                spamController.distance = calculationA - clampValue(secondaryValue, -1, 0) * (5 - minValue(magnitude / 5, 5))
                                return spamController.distance
                            end
                            ballState.bind = function(inputValue)
                                spawnTask(function()
                                    if not inputValue:GetAttribute("realBall") and not inputValue:WaitForChild("zoomies", 3) then
                                        return 
                                    end
                                    inputValue:GetAttributeChangedSignal("target"):Connect(function()
                                        parryState.debounce = false
                                        parryState.until_at = 0
                                        if config.random_target then
                                            inventoryUnlockManager.pick_random()
                                        end
                                    end)
                                end)
                            end
                            balls.ChildAdded:Connect(function()
                                if config.random_target then
                                    inventoryUnlockManager.pick_random()
                                end
                            end)
                            balls.ChildAdded:Connect(ballState.bind)
                            for _, primaryValue in balls:GetChildren() do
                                ballState.bind(primaryValue)
                            end
                            abilityEspState.init = function()
                                local function createTextInput(inputValue)
                                    local character = inputValue.Character
                                    while not character or not character.Parent do
                                        waitTask()
                                        character = inputValue.Character
                                    end
                                    local head = character:WaitForChild("Head")
                                    local BillboardGui = createGuiInstance("BillboardGui", {
                                        Adornee = head,
                                        Size = createUDim2(0, 200, 0, 50),
                                        StudsOffset = createVector3(0, 3, 0),
                                        AlwaysOnTop = true,
                                        Parent = head,
                                    })
                                    local TextLabel = createGuiInstance("TextLabel", {
                                        Size = createUDim2(1, 0, 1, 0),
                                        TextColor3 = colorFromRGB(255, 255, 255),
                                        TextSize = 10,
                                        TextWrapped = false,
                                        BackgroundTransparency = 1,
                                        TextXAlignment = Enum.TextXAlignment.Center,
                                        TextYAlignment = Enum.TextYAlignment.Center,
                                        Parent = BillboardGui,
                                    })
                                    abilityEspState.labels[inputValue] = TextLabel
                                    local humanoid = character:FindFirstChild("Humanoid")
                                    if humanoid then
                                        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                                    end
                                    local function updateAbilityLabel()
                                        local attribute = inputValue:GetAttribute("EquippedAbility")
                                        TextLabel.Text = attribute and inputValue.DisplayName .. " [" .. attribute .. "]" or inputValue.DisplayName
                                        TextLabel.Visible = config.ability_esp or false
                                    end
                                    updateAbilityLabel()
                                    local connection = inputValue:GetAttributeChangedSignal("EquippedAbility"):Connect(updateAbilityLabel)
                                    local connection2 = nil
                                    connection2 = heartbeat:Connect(function()
                                        if not character or not character.Parent then
                                            connection2:Disconnect()
                                            if connection then
                                                connection:Disconnect()
                                            end
                                            BillboardGui:Destroy()
                                            abilityEspState.labels[inputValue] = nil
                                            return 
                                        end
                                        TextLabel.Visible = config.ability_esp or false
                                    end)
                                end
                                for _, primaryValue in Players:GetPlayers() do
                                    if primaryValue ~= localPlayer then
                                        primaryValue.CharacterAdded:Connect(function()
                                            createTextInput(primaryValue)
                                        end)
                                        createTextInput(primaryValue)
                                    end
                                end
                                Players.PlayerAdded:Connect(function(player)
                                    player.CharacterAdded:Connect(function()
                                        createTextInput(player)
                                    end)
                                end)
                            end
                            abilityEspState.init()
                            parryState.check = function()
                                if triggerbotState.busy then
                                    return 
                                end
                                local character = localPlayer.Character
                                character = character and character.PrimaryPart
                                if not character then
                                    return 
                                end
                                local primaryValue = tick()
                                if parryState.debounce or primaryValue < parryState.until_at then
                                    return 
                                end
                                local position = character.Position
                                local secondaryValue = clampValue(dataPing:GetValue() / 10 / 10, 5, 17)
                                local attribute = ballState.get()
                                attribute = attribute and attribute:GetAttribute("target")
                                local tornado = runtime:FindFirstChild("Tornado")
                                local attribute2 = tornado and (tornado:GetAttribute("TornadoTime") or 1)
                                local position2 = ballState.position
                                local curved = ballState.curved
                                for _, tertiaryValue in ballState.get_all() do
                                    if not tertiaryValue then
                                        return 
                                    end
                                    local quaternaryValue = tertiaryValue:FindFirstChild("zoomies")
                                    if not quaternaryValue then
                                        return 
                                    end
                                    local attribute3 = tertiaryValue:GetAttribute("target")
                                    local magnitude = quaternaryValue.VectorVelocity.Magnitude
                                    local magnitude2 = (position - position2(tertiaryValue)).Magnitude
                                    local auxiliaryValue = 0.002
                                    local accuracy = parryState.accuracy
                                    local calculationA = (2.4 + minValue(maxValue(magnitude - 9.5, 0), 650) * auxiliaryValue) * accuracy
                                    if tertiaryValue:FindFirstChild("AeroDynamicSlashVFX") then
                                        Debris:AddItem(tertiaryValue.AeroDynamicSlashVFX, 0)
                                        ballState.state.AerodynamicTime = primaryValue
                                    end
                                    if tornado and primaryValue - ballState.state.AerodynamicTime < attribute2 + 0.314159 then
                                        return 
                                    end
                                    if attribute == name and curved(tertiaryValue) then
                                        return 
                                    end
                                    if attribute3 == name and magnitude2 <= secondaryValue + maxValue(magnitude / calculationA, 9.5) and parryState.accuracy * 0.8 then
                                        parryController.fire()
                                        parryState.debounce = true
                                        parryState.until_at = primaryValue + 1
                                    end
                                end
                            end
                            parryState.set = function(autoParry)
                                config.auto_parry = autoParry
                                if autoParry then
                                    runtimeConnections.auto_parry = postSimulation:Connect(parryState.check)
                                elseif runtimeConnections.auto_parry then
                                    runtimeConnections.auto_parry:Disconnect()
                                    runtimeConnections.auto_parry = nil
                                end
                            end
                            parrySection:AddToggle("AutoParry", { Title = "Auto parry", Default = config.auto_parry or false, Callback = parryState.set })
                            remotes.ParrySuccessAll.OnClientEvent:Connect(function(inputValue, secondaryInput)
                                if secondaryInput.Parent and secondaryInput.Parent ~= localPlayer.Character and secondaryInput.Parent.Parent ~= alive then
                                    return 
                                end
                                inventoryUnlockManager.closest()
                                if not inventoryUnlockManager.current or not inventoryUnlockManager.current.PrimaryPart then
                                    return 
                                end
                                local primaryValue = ballState.get()
                                if not primaryValue then
                                    return 
                                end
                                local position = localPlayer.Character.PrimaryPart.Position
                                local magnitude = (position - inventoryUnlockManager.current.PrimaryPart.Position).Magnitude
                                local calculationA = position - ballState.position(primaryValue)
                                local magnitude2 = calculationA.Magnitude
                                local secondaryValue = calculationA.Unit:Dot(primaryValue.AssemblyLinearVelocity.Unit)
                                local tertiaryValue = ballState.curved()
                                if magnitude < 15 and magnitude2 < 15 and secondaryValue > -0.25 and tertiaryValue then
                                    parryController.fire()
                                end
                            end)
                            remotes.ParrySuccess.OnClientEvent:Connect(function()
                                local character = localPlayer.Character
                                if not character or not character:IsDescendantOf(Workspace) then
                                    return 
                                end
                                local humanoid = character:FindFirstChildOfClass("Humanoid")
                                humanoid = humanoid and humanoid:FindFirstChildOfClass("Animator")
                                if not humanoid then
                                    return 
                                end
                                swordAnimationState.generation = swordAnimationState.generation + 1
                                swordAnimationState.last_spam = 0
                                for _, primaryValue in humanoid:GetPlayingAnimationTracks() do
                                    if primaryValue:GetAttribute("GrabParry") or primaryValue:GetAttribute("Parry") then
                                        primaryValue:Stop(primaryValue:GetAttribute("StopFadeTime"))
                                    end
                                end
                            end)
                            balls.ChildAdded:Connect(function()
                                parryState.debounce = false
                                parryState.until_at = 0
                            end)
                            balls.ChildRemoved:Connect(function(child)
                                ballState.positions[child] = nil
                                parryController.count = 0
                                parryState.debounce = false
                                parryState.until_at = 0
                                inventoryUnlockManager.current = nil
                                inventoryUnlockManager.visited = {
                                }
                                if runtimeConnections.target_change then
                                    runtimeConnections.target_change:Disconnect()
                                    runtimeConnections.target_change = nil
                                end
                            end)
                            remotes.ParrySuccessAll.OnClientEvent:Connect(function(inputValue, secondaryInput)
                                local position = localPlayer.Character.PrimaryPart.Position
                                local primaryValue = ballState.get()
                                if not primaryValue then
                                    return 
                                end
                                local zoomies = primaryValue:FindFirstChild("zoomies")
                                if not zoomies then
                                    return 
                                end
                                local magnitude = zoomies.VectorVelocity.Magnitude
                                local magnitude2 = (position - ballState.position(primaryValue)).Magnitude
                                local value = dataPing:GetValue()
                                local calculationA = magnitude2 / magnitude - value / 1000
                                local calculationB = 15 - minValue(magnitude2 / 1000, 15) + minValue(magnitude / 100, 40)
                                if magnitude > 100 and calculationA > value / 10 then
                                    calculationB = maxValue(calculationB - 15, 15)
                                end
                                if secondaryInput ~= localPlayer.Character.PrimaryPart and magnitude2 > calculationB then
                                    ballState.state.Curving = tick()
                                end
                            end)
                            parrySection:AddSlider("Accuracy", { Title = "Accuracy", Min = 1, Max = 100, Default = config.accuracy or 100, Rounding = 1, Callback = function(accuracy)
                                parryState.accuracy = (accuracy - 1) * 0.015151515151515152
                                config.accuracy = accuracy
                            end })
                            parryState.accuracy = (config.accuracy - 1) * 0.015151515151515152
                        end
                        parrySection:AddToggle("RandomTarget", { Title = "Random target", Default = config.random_target or false, Callback = function(randomTarget)
                            spawnTask(function()
                                config.random_target = randomTarget
                                inventoryUnlockManager.current = nil
                                inventoryUnlockManager.visited = {
                                }
                                if randomTarget then
                                    inventoryUnlockManager.pick_random()
                                end
                            end)
                        end })
                        curveController.hotkeys = {
                            [Enum.KeyCode.One] = "camera",
                            [Enum.KeyCode.Two] = "dot",
                            [Enum.KeyCode.Three] = "backwards",
                            [Enum.KeyCode.Four] = "slow",
                            [Enum.KeyCode.Five] = "random",
                        }
                        curveController.dropdown = curve:AddDropdown("CurveMethod", {
                            Title = "Curve method",
                            Values = curveMethods,
                            Multi = false,
                            Default = config.curve_method or "camera",
                            Callback = function(curveMethod)
                            local syncing = curveController.syncing
                            spawnTask(function()
                                local primaryValue = syncing
                                local conditionFlagA
                                if syncing then
                                    conditionFlagA = primaryValue
                                else
                                    conditionFlagA = config.curve_method == curveMethod
                                end
                                if conditionFlagA then
                                    if config.curve_notify and not syncing then
                                        notificationService:notify({
                                            title = "curve method",
                                            content = "already " .. curveMethod,
                                            duration = 3,
                                        })
                                    end
                                    return 
                                end
                                config.curve_method = curveMethod
                                if config.curve_notify then
                                    notificationService:notify({
                                        title = "curve method",
                                        content = "curve method is now " .. curveMethod,
                                        duration = 3,
                                    })
                                end
                            end)
                        end })
                        UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if gameProcessed or not config.curve_keybind then
                                return 
                            end
                            local primaryValue = curveController.hotkeys[input.KeyCode]
                            if not primaryValue then
                                return 
                            end
                            if config.curve_method == primaryValue then
                                if config.curve_notify then
                                    notificationService:notify({
                                        title = "curve method",
                                        content = ("already ") .. primaryValue,
                                        duration = 3,
                                    })
                                end
                                return 
                            end
                            config.curve_method = primaryValue
                            curveController.sync_dropdown(primaryValue)
                            if config.curve_notify then
                                notificationService:notify({
                                    title = "curve method",
                                    content = "curve method is now " .. primaryValue,
                                    duration = 3,
                                })
                            end
                        end)
                        hotkeys:AddToggle("hotkey_curve", { Title = "Hotkey curve", Default = config.curve_keybind or false, Callback = function(curveKeybind)
                            spawnTask(function()
                                config.curve_keybind = curveKeybind
                            end)
                        end })
                        hotkeys:AddToggle("hotkey_notify", { Title = "Hotkey notify", Default = config.curve_notify or false, Callback = function(curveNotify)
                            spawnTask(function()
                                config.curve_notify = curveNotify
                            end)
                        end })
                        triggerbotState.fire = function(inputValue)
                            if triggerbotState.busy then
                                return 
                            end
                            triggerbotState.busy = true
                            parryController.fire()
                            inputValue:GetAttributeChangedSignal("target"):Once(function()
                                triggerbotState.busy = false
                            end)
                            local primaryValue = tick()
                            spawnTask(function()
                                while true do
                                    preSimulation:Wait()
                                    if not (tick() - primaryValue >= 1 or not triggerbotState.busy) then
                                        continue
                                    end
                                    break
                                end
                                triggerbotState.busy = false
                            end)
                        end
                        triggerbotState.update_button = function()
                            if triggerbotState.button then
                                triggerbotState.button.Text = triggerbotState.on and "triggerbot [on]" or "triggerbot [off]"
                            end
                        end
                        triggerbotState.set = function(inputValue)
                            local on = inputValue == true
                            if triggerbotState.on == on then
                                triggerbotState.update_button()
                                return 
                            end
                            triggerbotState.on = on
                            _G.triggerbot = on
                            notificationService:notify({
                                title = "triggerbot",
                                content = on and "on" or "off",
                                duration = 2,
                            })
                            if on then
                                runtimeConnections.triggerbot = preSimulation:Connect(function()
                                    local primaryValue = ballState.get()
                                    if primaryValue and primaryValue:GetAttribute("target") == name then
                                        triggerbotState.fire(primaryValue)
                                    end
                                end)
                            elseif runtimeConnections.triggerbot then
                                runtimeConnections.triggerbot:Disconnect()
                                runtimeConnections.triggerbot = nil
                            end
                            triggerbotState.update_button()
                        end
                        if touchEnabled then
                            hotkeys:AddToggle("triggerbot_button", { Title = "Triggerbot button", Default = config.mobile_triggerbot_button or false, Callback = function(mobileTriggerbotButton)
                                config.mobile_triggerbot_button = mobileTriggerbotButton
                                if triggerbotState.button then
                                    triggerbotState.button.Visible = mobileTriggerbotButton
                                end
                                if not mobileTriggerbotButton then
                                    triggerbotState.set(false)
                                end
                            end })
                        end
                        spamController.auto_check = function()
                            local primaryValue = ballState.get()
                            if not primaryValue then
                                return 
                            end
                            if not primaryValue:FindFirstChild("zoomies") then
                                return 
                            end
                            inventoryUnlockManager.closest()
                            if not inventoryUnlockManager.current or not inventoryUnlockManager.current.PrimaryPart then
                                return 
                            end
                            local secondaryValue = tick()
                            local tertiaryValue = 1
                            local quaternaryValue = 16
                            local auxiliaryValue = spamController.perform({
                                Ball_Properties = ballState.props(),
                                Entity_Properties = inventoryUnlockManager.props(),
                                Ping = clampValue(dataPing:GetValue() / 10, tertiaryValue, quaternaryValue),
                            })
                            local character = localPlayer.Character
                            local primaryPart = character and character.PrimaryPart
                            if not primaryPart then
                                return 
                            end
                            local magnitude = (primaryPart.Position - ballState.position(primaryValue)).Magnitude
                            local attribute = primaryValue:GetAttribute("target")
                            if not attribute then
                                return 
                            end
                            local candidateValue = localPlayer:DistanceFromCharacter(inventoryUnlockManager.current.PrimaryPart.Position)
                            if candidateValue > auxiliaryValue or magnitude > auxiliaryValue then
                                return 
                            end
                            if character:GetAttribute("Pulsed") then
                                return 
                            end
                            if attribute == name and candidateValue > 30 and magnitude > 30 then
                                return 
                            end
                            if magnitude <= auxiliaryValue and parryController.count > config.spam_threshold and secondaryValue - spamController.last_auto >= 0.001 then
                                spamController.last_auto = secondaryValue
                                parryController.fire(true)
                            end
                        end
                        spamController.set_auto = function(autoSpam)
                            config.auto_spam = autoSpam
                            if autoSpam then
                                runtimeConnections.auto_spam = preSimulation:Connect(spamController.auto_check)
                            elseif runtimeConnections.auto_spam then
                                runtimeConnections.auto_spam:Disconnect()
                                runtimeConnections.auto_spam = nil
                            end
                        end
                        spam:AddToggle("AutoSpam", { Title = "Auto spam", Default = config.auto_spam or false, Callback = spamController.set_auto })
                        spam:AddSlider("Threshold", { Title = "Threshold", Min = 1, Max = 3, Default = config.spam_threshold or 3, Rounding = 1, Callback = function(inputValue)
                            spawnTask(function()
                                if true then
                                    config.spam_threshold = tonumber(inputValue)
                                else
                                    while true do

                                    end
                                end
                            end)
                        end })
                        UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if gameProcessed then
                                return 
                            end
                            if input.KeyCode == Enum.KeyCode.E then
                                _G.manual_spam = not _G.manual_spam
                            end
                        end)
                        if type(config.manual_spam) == "string" and Enum.KeyCode[config.manual_spam] then
                            spamController.manual_key = Enum.KeyCode[config.manual_spam]
                        end
                        spamController.update_button = function()
                            if spamController.mobile_button then
                                spamController.mobile_button.Text = spamController.manual_on and "manual spam [on]" or "manual spam [off]"
                            end
                        end
                        spamController.set_manual = function(inputValue)
                            local manualOn = inputValue == true
                            if spamController.manual_on == manualOn then
                                spamController.update_button()
                                return 
                            end
                            spamController.manual_on = manualOn
                            if runtimeConnections.manual_spam then
                                runtimeConnections.manual_spam:Disconnect()
                                runtimeConnections.manual_spam = nil
                            end
                            if manualOn then
                                local primaryValue = 0
                                runtimeConnections.manual_spam = preSimulation:Connect(function()
                                    local secondaryValue = tick()
                                    if secondaryValue - primaryValue < 0.001 then
                                        return 
                                    end
                                    primaryValue = secondaryValue
                                    parryController.fire(true)
                                end)
                            end
                            spamController.update_button()
                            if config.manual_notify then
                                notificationService:notify({
                                    title = "manual spam",
                                    content = manualOn and "on" or "off",
                                    duration = 4,
                                })
                            end
                        end
                    end
                    do
                        if touchEnabled then
                            hotkeys:AddToggle("manual_spam_button", { Title = "Manual spam button", Default = config.mobile_manual_spam_button or false, Callback = function(mobileManualSpamButton)
                                config.mobile_manual_spam_button = mobileManualSpamButton
                                if spamController.mobile_button then
                                    spamController.mobile_button.Visible = mobileManualSpamButton
                                end
                                if not mobileManualSpamButton then
                                    spamController.set_manual(false)
                                end
                            end })
                        end
                        do
                            local conditionFlagA = false
                            local function helperFunction()
                                if conditionFlagA or not keyboardEnabled and not gamepadEnabled then
                                    return 
                                end
                                conditionFlagA = true
                                hotkeys:AddKeybind("TriggerbotKey", {
                                    Title = "Triggerbot key",
                                    Default = triggerbotState.key.Name,
                                    Mode = "Toggle",
                                    ChangedCallback = function(key)
                                        if key ~= triggerbotState.key then
                                            triggerbotState.key = key
                                        end
                                    end,
                                })
                                hotkeys:AddKeybind("ManualSpamKey", {
                                    Title = "Manual spam key",
                                    Default = spamController.manual_key.Name,
                                    Mode = "Toggle",
                                    ChangedCallback = function(manualKey)
                                        if manualKey ~= spamController.manual_key then
                                            spamController.manual_key = manualKey
                                            config.manual_spam = manualKey.Name
                                        end
                                    end,
                                })
                            end
                            helperFunction()
                            UserInputService.GamepadConnected:Connect(function()
                                gamepadEnabled = true
                                helperFunction()
                            end)
                            UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function()
                                keyboardEnabled = UserInputService.KeyboardEnabled
                                helperFunction()
                            end)
                            UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(function()
                                gamepadEnabled = UserInputService.GamepadEnabled
                                helperFunction()
                            end)
                        end
                    end
                    do
                        UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if gameProcessed then
                                return 
                            end
                            if input.KeyCode == triggerbotState.key then
                                triggerbotState.set(not triggerbotState.on)
                            end
                            if input.KeyCode == spamController.manual_key then
                                spamController.set_manual(not spamController.manual_on)
                            end
                        end)
                        if touchEnabled then
                            do
                                local ScreenGui = createGuiInstance("ScreenGui", {
                                    Name = "oxy_mobile",
                                    ResetOnSpawn = false,
                                    IgnoreGuiInset = true,
                                    DisplayOrder = 50,
                                    Parent = localPlayer:WaitForChild("PlayerGui"),
                                })
                                local function helperFunction(inputValue, secondaryInput, tertiaryInput)
                                    local primaryValue = createGuiInstance("TextButton", {
                                        Name = inputValue,
                                        AnchorPoint = createVector2(1, 0.5),
                                        Position = secondaryInput,
                                        Size = fromOffset(130, 44),
                                        BackgroundColor3 = colorFromRGB(22, 22, 22),
                                        BorderSizePixel = 0,
                                        AutoButtonColor = false,
                                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
                                        TextColor3 = colorFromRGB(255, 255, 255),
                                        TextSize = 16,
                                        TextWrapped = false,
                                        ZIndex = 2,
                                        Parent = ScreenGui,
                                    })
                                    createGuiInstance("UICorner", {
                                        CornerRadius = createUDim(0, 8),
                                        Parent = primaryValue,
                                    })
                                    createGuiInstance("UIStroke", {
                                        Color = colorFromRGB(35, 35, 35),
                                        Thickness = 1,
                                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                        Parent = primaryValue,
                                    })
                                    local conditionFlagA = false
                                    local conditionFlagB = false
                                    local secondaryValue = nil
                                    local position = nil
                                    local position2 = nil
                                    primaryValue.InputBegan:Connect(function(input)
                                        local userInputType = input.UserInputType
                                        if userInputType ~= Enum.UserInputType.Touch and userInputType ~= Enum.UserInputType.MouseButton1 then
                                            return 
                                        end
                                        conditionFlagA = true
                                        conditionFlagB = false
                                        secondaryValue = input
                                        position = input.Position
                                        position2 = primaryValue.Position
                                    end)
                                    UserInputService.InputChanged:Connect(function(input)
                                        if not conditionFlagA or input ~= secondaryValue and input.UserInputType ~= Enum.UserInputType.MouseMovement then
                                            return 
                                        end
                                        local calculationA = input.Position - position
                                        if not (controlValueB > 1424) then
                                            if calculationA.Magnitude > 4 then
                                                conditionFlagB = true
                                            end
                                            primaryValue.Position = createUDim2(position2.X.Scale, position2.X.Offset + calculationA.X, position2.Y.Scale, position2.Y.Offset + calculationA.Y)
                                            return 
                                        end
                                        while true do

                                        end
                                    end)
                                    UserInputService.InputEnded:Connect(function(input)
                                        if input == secondaryValue then
                                            conditionFlagA = false
                                            secondaryValue = nil
                                        end
                                    end)
                                    primaryValue.MouseButton1Click:Connect(function()
                                        if conditionFlagB then
                                            conditionFlagB = false
                                            return 
                                        end
                                        tertiaryInput()
                                        primaryValue.BackgroundColor3 = colorFromRGB(40, 40, 40)
                                        createTween(TweenService, primaryValue, createTweenInfo(0.2), {
                                            BackgroundColor3 = colorFromRGB(22, 22, 22),
                                        }):Play()
                                    end)
                                    return primaryValue
                                end
                                triggerbotState.button = helperFunction("Triggerbot", createUDim2(1, -280, 0.5, 0), function()
                                    triggerbotState.set(not triggerbotState.on)
                                end)
                                triggerbotState.button.Visible = config.mobile_triggerbot_button
                                spamController.mobile_button = helperFunction("ManualSpam", createUDim2(1, -140, 0.5, 0), function()
                                    spamController.set_manual(not spamController.manual_on)
                                end)
                            end
                            spamController.mobile_button.Visible = config.mobile_manual_spam_button
                            triggerbotState.update_button()
                            spamController.update_button()
                        end
                        spam:AddToggle("manual_notify", { Title = "Manual notify", Default = config.manual_notify or false, Callback = function(manualNotify)
                            config.manual_notify = manualNotify
                        end })
                        visual:AddToggle("ability_esp", { Title = "Ability ESP", Default = config.ability_esp or false, Callback = function(abilityEsp)
                            config.ability_esp = abilityEsp
                            for k, primaryValue in abilityEspState.labels, nil, nil do
                                if primaryValue and primaryValue.Parent then
                                    local attribute = k:GetAttribute("EquippedAbility")
                                    primaryValue.Text = attribute and k.DisplayName .. " [" .. attribute .. "]" or k.DisplayName
                                    primaryValue.Visible = abilityEsp
                                end
                            end
                        end })
                        do
                            local inventoryUnlockManager = {
                                enabled = config.unlock_all or false,
                                ready = false,
                                shop_controller = nil,
                                shop_api = nil,
                                shop = nil,
                                swords = nil,
                                sword_fn = swordEventConnections.sword_fn,
                                selected_sword = nil,
                                original_sword = nil,
                                explosion_module = nil,
                                explosion_original = nil,
                                explosion_hooked = false,
                                selected_explosion = nil,
                            }
                            inventoryUnlockManager.unlock_originals = setmetatable({
                            }, {
                                __mode = "k",
                            })
                            inventoryUnlockManager.unlocked = {
                            }
                            inventoryUnlockManager.shadow_connections = setmetatable({
                            }, {
                                __mode = "k",
                            })
                            inventoryUnlockManager.page_connections = {
                            }
                            inventoryUnlockManager.refresh_generation = {
                            }
                            inventoryUnlockManager.modern_originals = setmetatable({
                            }, {
                                __mode = "k",
                            })
                            inventoryUnlockManager.modern_tag = "oxy_unlock_all"
                            inventoryUnlockManager.original_set_equipped = nil
                            inventoryUnlockManager.original_buy_fns = {
                            }
                            inventoryUnlockManager.parry_connections = swordEventConnections.parry_connections
                            inventoryUnlockManager.fire_connections = swordEventConnections.fire_sword_connections
                            inventoryUnlockManager.play_parry = swordEventConnections.play_parry
                            inventoryUnlockManager.chroma_bound = false
                            inventoryUnlockManager.character_connection = nil
                            inventoryUnlockManager.added_connection = nil
                            inventoryUnlockManager.sword_attr_connection = nil
                            local function helperFunction(inputValue, secondaryInput)
                                pcall(function()
                                    if secondaryInput then
                                        inputValue:Enable()
                                    else
                                        inputValue:Disable()
                                    end
                                end)
                            end
                            inventoryUnlockManager.set_sword_override = function(inputValue, secondaryInput)
                                for _, primaryValue in inputValue.parry_connections, nil, nil do
                                    helperFunction(primaryValue, not secondaryInput)
                                end
                                for _, primaryValue in inputValue.fire_connections, nil, nil do
                                    helperFunction(primaryValue, not secondaryInput)
                                end
                            end
                            inventoryUnlockManager.apply_chroma = function(inputValue, secondaryInput, tertiaryInput)
                                local colorConfig = tertiaryInput.ColorConfig or tertiaryInput.TweenColorConfig
                                local conditionFlagA = not colorConfig
                                local pos
                                if conditionFlagA then
                                    pos = tertiaryInput.Name:find("Chroma") or tertiaryInput.Name:find("Rainbow")
                                else
                                    pos = conditionFlagA
                                end
                                if pos then
                                    colorConfig = "Chroma"
                                end
                                if colorConfig then
                                    secondaryInput:SetAttribute("ColorConfig", colorConfig)
                                    secondaryInput:AddTag("TweenColor")
                                end
                            end
                            inventoryUnlockManager.slot_fav_visual = function(inputValue, secondaryInput, tertiaryInput)
                                if not tertiaryInput or not tertiaryInput:IsA("GuiObject") then
                                    return 
                                end
                                local attribute = tertiaryInput:GetAttribute("Name")
                                if not attribute or attribute == "" then
                                    return 
                                end
                                local primaryValue = inputValue:is_fav(secondaryInput, attribute)
                                local favorited = tertiaryInput:FindFirstChild("Favorited")
                                if favorited and favorited:IsA("ImageLabel") then
                                    favorited.Visible = primaryValue
                                    if primaryValue then
                                        favorited.Image = "rbxassetid://15697987058"
                                    end
                                end
                                local shadow = tertiaryInput:FindFirstChild("Shadow")
                                if shadow and inputValue.unlocked[secondaryInput] then
                                    shadow.Enabled = false
                                end
                            end
                            inventoryUnlockManager.native_fav_map = function(inputValue)
                                if inputValue.native_map then
                                    return inputValue.native_map
                                end
                                if not inputValue.shop_controller or type(inputValue.shop_controller._inventoryPages) ~= "table" then
                                    return nil
                                end
                                for _, primaryValue in inputValue.shop_controller._inventoryPages, nil, nil do
                                    if type(primaryValue) ~= "table" or type(primaryValue.MarkDirty) ~= "function" then
                                        continue
                                    end
                                    local secondaryValue, tertiaryValue = pcall(debug.getupvalues, primaryValue.MarkDirty)
                                    if not secondaryValue or type(tertiaryValue) ~= "table" then
                                        continue
                                    end
                                    for _, quaternaryValue in tertiaryValue, nil, nil do
                                        if type(quaternaryValue) ~= "function" then
                                            continue
                                        end
                                        local auxiliaryValue, candidateValue = pcall(debug.getupvalues, quaternaryValue)
                                        if not auxiliaryValue or type(candidateValue) ~= "table" then
                                            continue
                                        end
                                        for _, resultValue in candidateValue, nil, nil do
                                            if type(resultValue) ~= "function" then
                                                continue
                                            end
                                            local errorValue, encodedValue = pcall(debug.getupvalues, resultValue)
                                            if not errorValue or type(encodedValue) ~= "table" then
                                                continue
                                            end
                                            for _, fallbackValue in encodedValue, nil, nil do
                                                if type(fallbackValue) == "table" and fallbackValue.Sword ~= nil and fallbackValue.Explosion ~= nil and not fallbackValue._virtualItems then
                                                    inputValue.native_map = fallbackValue
                                                    return fallbackValue
                                                end
                                            end
                                        end
                                    end
                                end
                                return nil
                            end
                            inventoryUnlockManager.sync_fav_map = function(inputValue, secondaryInput)
                                local primaryValue = inputValue:native_fav_map()
                                if not primaryValue then
                                    return 
                                end
                                local secondaryValue = primaryValue[secondaryInput]
                                if type(secondaryValue) ~= "table" then
                                    return 
                                end
                                local favoriteSwords = secondaryInput == "Sword" and config.favorite_swords or secondaryInput == "Explosion" and config.favorite_explosions or {
                                }
                                for k in secondaryValue, nil, nil do
                                    if not favoriteSwords[k] then
                                        secondaryValue[k] = nil
                                    end
                                end
                                for k, tertiaryValue in favoriteSwords, nil, nil do
                                    tertiaryValue = tertiaryValue and true
                                    secondaryValue[k] = tertiaryValue or nil
                                end
                            end
                            inventoryUnlockManager.is_fav = function(inputValue, secondaryInput, tertiaryInput)
                                if secondaryInput == "Sword" then
                                    return config.favorite_swords and config.favorite_swords[tertiaryInput] == true
                                end
                                if secondaryInput == "Explosion" then
                                    if false then
                                        while true do

                                        end
                                    end
                                    return config.favorite_explosions and config.favorite_explosions[tertiaryInput] == true
                                end
                                return false
                            end
                            inventoryUnlockManager.is_deleted = function(inputValue, secondaryInput, tertiaryInput)
                                if secondaryInput == "Sword" then
                                    return config.deleted_swords and config.deleted_swords[tertiaryInput] == true
                                end
                                if secondaryInput == "Explosion" then
                                    return config.deleted_explosions and config.deleted_explosions[tertiaryInput] == true
                                end
                                return false
                            end
                            inventoryUnlockManager.refresh_shop_item = function(inputValue, secondaryInput, tertiaryInput, quaternaryInput)
                                local shopController = inputValue.shop_controller and inputValue.shop_controller._virtualItems[secondaryInput]
                                local shopController2 = inputValue.shop_controller and inputValue.shop_controller._inventoryPages[secondaryInput]
                                if type(shopController) == "table" then
                                    for _, primaryValue in shopController, nil, nil do
                                        if primaryValue.Name == tertiaryInput then
                                            primaryValue.Section = quaternaryInput and "Owned" or "Unowned"
                                            if primaryValue.OwnsItem and type(primaryValue.OwnsItem.Set) == "function" then
                                                pcall(primaryValue.OwnsItem.Set, primaryValue.OwnsItem, quaternaryInput)
                                            end
                                            if not quaternaryInput then
                                                primaryValue.IsFavorited = false
                                                primaryValue.Name_ = (primaryValue.Name_ or primaryValue.Name):gsub("^#", "")
                                                primaryValue.LayoutOrder = primaryValue.OriginalLayoutOrder or primaryValue.LayoutOrder or 0
                                            end
                                            if shopController2 and shopController2.MarkDirty then
                                                shopController2.MarkDirty(primaryValue, false, true)
                                            end
                                            break
                                        end
                                    end
                                end
                                if shopController2 and shopController2.MarkDirty then
                                    shopController2.MarkDirty(nil, true, true)
                                end
                            end
                            inventoryUnlockManager.delete_item = function(inputValue, secondaryInput, tertiaryInput)
                                if secondaryInput == "Sword" then
                                    config.deleted_swords = config.deleted_swords or {
                                    }
                                    config.deleted_swords[tertiaryInput] = true
                                    if config.favorite_swords then
                                        config.favorite_swords[tertiaryInput] = nil
                                    end
                                    if inputValue.selected_sword == tertiaryInput then
                                        inputValue:restore_sword()
                                    end
                                elseif secondaryInput == "Explosion" then
                                    config.deleted_explosions = config.deleted_explosions or {
                                    }
                                    config.deleted_explosions[tertiaryInput] = true
                                    if config.favorite_explosions then
                                        config.favorite_explosions[tertiaryInput] = nil
                                    end
                                    if inputValue.selected_explosion == tertiaryInput then
                                        inputValue.selected_explosion = nil
                                    end
                                end
                                pcall(configStorage.save)
                                inputValue:sync_fav_map(secondaryInput)
                                if inputValue.shop_controller then
                                    inputValue:refresh_shop_item(secondaryInput, tertiaryInput, false)
                                end
                                inputValue:refresh_selected()
                                if not controlFlagB then
                                    return 
                                end
                            end
                            inventoryUnlockManager.undelete_item = function(inputValue, secondaryInput, tertiaryInput)
                                if secondaryInput == "Sword" and config.deleted_swords then
                                    config.deleted_swords[tertiaryInput] = nil
                                elseif secondaryInput == "Explosion" and config.deleted_explosions then
                                    config.deleted_explosions[tertiaryInput] = nil
                                end
                                pcall(configStorage.save)
                                inputValue:sync_fav_map(secondaryInput)
                                if inputValue.shop_controller then
                                    inputValue:refresh_shop_item(secondaryInput, tertiaryInput, true)
                                end
                                inputValue:refresh_selected()
                            end
                            inventoryUnlockManager.toggle_fav = function(inputValue, secondaryInput, tertiaryInput)
                                if inputValue:is_deleted(secondaryInput, tertiaryInput) then
                                    return 
                                end
                                if secondaryInput == "Sword" then
                                    config.favorite_swords = config.favorite_swords or {
                                    }
                                    config.favorite_swords[tertiaryInput] = config.favorite_swords[tertiaryInput] and nil or true
                                elseif secondaryInput == "Explosion" then
                                    config.favorite_explosions = config.favorite_explosions or {
                                    }
                                    config.favorite_explosions[tertiaryInput] = config.favorite_explosions[tertiaryInput] and nil or true
                                end
                                pcall(configStorage.save)
                                inputValue:sync_fav_map(secondaryInput)
                                local virtualItems = inputValue.shop_controller and inputValue.shop_controller._virtualItems and inputValue.shop_controller._virtualItems[secondaryInput]
                                local inventoryPages = inputValue.shop_controller and inputValue.shop_controller._inventoryPages and inputValue.shop_controller._inventoryPages[secondaryInput]
                                local primaryValue = inputValue:is_fav(secondaryInput, tertiaryInput)
                                if type(virtualItems) == "table" then
                                    for _, secondaryValue in virtualItems, nil, nil do
                                        if secondaryValue.Name == tertiaryInput then
                                            secondaryValue.IsFavorited = primaryValue
                                            if secondaryValue.OwnsItem and type(secondaryValue.OwnsItem.Set) == "function" then
                                                pcall(secondaryValue.OwnsItem.Set, secondaryValue.OwnsItem, true)
                                            end
                                            local originalLayoutOrder = secondaryValue.OriginalLayoutOrder or secondaryValue.LayoutOrder or 0
                                            secondaryValue.OriginalLayoutOrder = originalLayoutOrder
                                            if primaryValue then
                                                secondaryValue.LayoutOrder = originalLayoutOrder - 1000
                                                secondaryValue.Name_ = "#" .. (secondaryValue.Name_ or secondaryValue.Name):gsub("^#", "")
                                            else
                                                secondaryValue.LayoutOrder = originalLayoutOrder
                                                secondaryValue.Name_ = (secondaryValue.Name_ or secondaryValue.Name):gsub("^#", "")
                                            end
                                            break
                                        end
                                    end
                                end
                                if inventoryPages and inventoryPages.MarkDirty then
                                    inventoryPages.MarkDirty(nil, true, true)
                                end
                                inputValue:refresh_selected()
                            end
                            inventoryUnlockManager.refresh_favs = function(inputValue, secondaryInput)
                                if not inputValue.shop_controller then
                                    return 
                                end
                                inputValue:sync_fav_map(secondaryInput)
                                local primaryValue = inputValue.shop_controller._virtualItems[secondaryInput]
                                local secondaryValue = inputValue.shop_controller._inventoryPages[secondaryInput]
                                if type(primaryValue) ~= "table" then
                                    return 
                                end
                                for _, tertiaryValue in primaryValue, nil, nil do
                                    local quaternaryValue = inputValue:is_fav(secondaryInput, tertiaryValue.Name)
                                    tertiaryValue.IsFavorited = quaternaryValue
                                    local ownsItem = tertiaryValue.OwnsItem
                                    if ownsItem then
                                        local auxiliaryValue = "function"
                                        ownsItem = type(tertiaryValue.OwnsItem.Set) == auxiliaryValue
                                    end
                                    if ownsItem then
                                        pcall(tertiaryValue.OwnsItem.Set, tertiaryValue.OwnsItem, true)
                                    end
                                    local originalLayoutOrder = tertiaryValue.OriginalLayoutOrder or tertiaryValue.LayoutOrder or 0
                                    tertiaryValue.OriginalLayoutOrder = originalLayoutOrder
                                    if quaternaryValue then
                                        tertiaryValue.LayoutOrder = originalLayoutOrder - 1000
                                        tertiaryValue.Name_ = "#" .. (tertiaryValue.Name_ or tertiaryValue.Name):gsub("^#", "")
                                    else
                                        tertiaryValue.LayoutOrder = originalLayoutOrder
                                        tertiaryValue.Name_ = (tertiaryValue.Name_ or tertiaryValue.Name):gsub("^#", "")
                                    end
                                end
                                if secondaryValue and secondaryValue.MarkDirty then
                                    secondaryValue.MarkDirty(nil, true, true)
                                end
                            end
                            inventoryUnlockManager.equip_sword = function(inputValue, secondaryInput, tertiaryInput)
                                if not inputValue.swords then
                                    return false
                                end
                                local conditionFlagA = not tertiaryInput
                                if conditionFlagA and inputValue:is_deleted("Sword", secondaryInput) then
                                    inputValue:undelete_item("Sword", secondaryInput)
                                end
                                local sword = inputValue.swords:GetSword(secondaryInput)
                                if not sword then
                                    return false
                                end
                                local character = localPlayer.Character
                                if not character then
                                    return false
                                end
                                if conditionFlagA and not inputValue.original_sword then
                                    inputValue.original_sword = localPlayer:GetAttribute("CurrentlyEquippedSword") or character:GetAttribute("CurrentlyEquippedSword")
                                end
                                if tertiaryInput then
                                    inputValue.selected_sword = nil
                                else
                                    inputValue.selected_sword = sword.Name
                                    config.last_equipped_sword = sword.Name
                                    inputValue:set_sword_override(true)
                                end
                                localPlayer:SetAttribute("CurrentlyEquippedSword", sword.Name)
                                character:SetAttribute("CurrentlyEquippedSword", sword.Name)
                                pcall(function()
                                    local equipSwordTo = inputValue.swords.EquipSwordTo
                                    for k, primaryValue in debug.getupvalues(equipSwordTo) do
                                        if primaryValue == true then
                                            debug.setupvalue(equipSwordTo, k, false)
                                            break
                                        end
                                    end
                                    if not (controlValueB >= 1437) then
                                        return 
                                    end
                                    while true do

                                    end
                                end)
                                if not pcall(function()
                                    inputValue.swords:EquipSwordTo(character, sword.Name)
                                end) then
                                    return false
                                end
                                local primaryValue = character:FindFirstChild(sword.Name)
                                if primaryValue then
                                    if true then
                                        inputValue:apply_chroma(primaryValue, sword)
                                    else
                                        while true do

                                        end
                                    end
                                end
                                if inputValue.sword_fn then
                                    pcall(inputValue.sword_fn, sword.Name)
                                end
                                return true
                            end
                            inventoryUnlockManager.restore_sword = function(inputValue)
                                if inputValue.original_sword and inputValue.original_sword ~= "" then
                                    inputValue:equip_sword(inputValue.original_sword, true)
                                else
                                    inputValue.selected_sword = nil
                                end
                                inputValue.original_sword = nil
                                inputValue:set_sword_override(false)
                            end
                            inventoryUnlockManager.ensure_explosion_wrap = function(inputValue)
                                if inputValue.explosion_hooked or not inputValue.explosion_module then
                                    return 
                                end
                                inputValue.explosion_hooked = true
                                inputValue.explosion_original = inputValue.explosion_module.PlayExplosion
                                inputValue.explosion_module.PlayExplosion = function(secondaryInput, tertiaryInput, quaternaryInput, fifthInput, sixthInput, seventhInput, eighthInput)
                                    if inventoryUnlockManager.enabled and inventoryUnlockManager.selected_explosion and inventoryUnlockManager.selected_explosion ~= "" and eighthInput and seventhInput == localPlayer.Character then
                                        tertiaryInput = inventoryUnlockManager.selected_explosion
                                    end
                                    return inventoryUnlockManager.explosion_original(secondaryInput, tertiaryInput, quaternaryInput, fifthInput, sixthInput, seventhInput, eighthInput)
                                end
                            end
                            inventoryUnlockManager.equip_explosion = function(inputValue, selectedExplosion)
                                if inputValue:is_deleted("Explosion", selectedExplosion) then
                                    inputValue:undelete_item("Explosion", selectedExplosion)
                                end
                                inputValue.selected_explosion = selectedExplosion
                                config.last_equipped_explosion = selectedExplosion
                                inputValue:ensure_explosion_wrap()
                                return true
                            end
                            inventoryUnlockManager.bind_shadow = function(inputValue, secondaryInput, tertiaryInput)
                                if inputValue.shadow_connections[tertiaryInput] then
                                    return 
                                end
                                local function createTextInput()
                                    if inputValue.unlocked[secondaryInput] and tertiaryInput.Parent and tertiaryInput.Enabled then
                                        tertiaryInput.Enabled = false
                                    end
                                end
                                inputValue.shadow_connections[tertiaryInput] = tertiaryInput:GetPropertyChangedSignal("Enabled"):Connect(createTextInput)
                                createTextInput()
                            end
                            inventoryUnlockManager.refresh_visuals = function(inputValue, secondaryInput)
                                if inputValue.shop_controller then
                                    local primaryValue = inputValue.shop_controller._inventoryPages[secondaryInput]
                                    local secondaryValue = inputValue.shop_controller._virtualItems[secondaryInput]
                                    local conditionFlagA = not primaryValue or not primaryValue.Scroll
                                    if not conditionFlagA then
                                        local tertiaryValue = "table"
                                        conditionFlagA = type(secondaryValue) ~= tertiaryValue
                                    end
                                    if conditionFlagA then
                                        return 
                                    end
                                    if not inputValue.page_connections[secondaryInput] and primaryValue.ScrollingFrame then
                                        inputValue.page_connections[secondaryInput] = primaryValue.ScrollingFrame.DescendantAdded:Connect(function(descendant)
                                            if descendant:IsA("GuiObject") then
                                                deferTask(function()
                                                    inputValue:slot_fav_visual(secondaryInput, descendant)
                                                    local shadow = descendant:FindFirstChild("Shadow") or descendant.Name == "Shadow" and descendant
                                                    if shadow and inputValue.unlocked[secondaryInput] then
                                                        inputValue:bind_shadow(secondaryInput, shadow)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                    deferTask(function()
                                        for _, tertiaryValue in secondaryValue, nil, nil do
                                            local quaternaryValue, auxiliaryValue = pcall(primaryValue.Scroll.GetRenderedSlot, tertiaryValue)
                                            if quaternaryValue and auxiliaryValue then
                                                inputValue:slot_fav_visual(secondaryInput, auxiliaryValue)
                                                local shadow = auxiliaryValue:FindFirstChild("Shadow")
                                                if shadow then
                                                    if inputValue.unlocked[secondaryInput] then
                                                        inputValue:bind_shadow(secondaryInput, shadow)
                                                    else
                                                        shadow.Enabled = not tertiaryValue.OwnsItem:Get()
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                    return 
                                end
                                if not (controlValueA <= 3230) then
                                    return 
                                end
                                while true do

                                end
                            end
                            inventoryUnlockManager.set_category_unlock = function(inputValue, secondaryInput, tertiaryInput)
                                if not inputValue.shop_controller then
                                    return 
                                end
                                if tertiaryInput then
                                    if controlValueB > 1425 then
                                        while true do

                                        end
                                    else
                                        inputValue:sync_fav_map(secondaryInput)
                                    end
                                end
                                local primaryValue = inputValue.shop_controller._virtualItems[secondaryInput]
                                local secondaryValue = inputValue.shop_controller._inventoryPages[secondaryInput]
                                if type(primaryValue) ~= "table" then
                                    return 
                                end
                                if secondaryValue and secondaryValue.BeginBatch then
                                    secondaryValue.BeginBatch()
                                end
                                if tertiaryInput then
                                    inputValue.unlocked[secondaryInput] = true
                                    local curveController = {
                                    }
                                    for _, tertiaryValue in primaryValue, nil, nil do
                                        if tertiaryValue.InventoryKey then
                                            curveController[tertiaryValue.Name] = true
                                        end
                                    end
                                    for _, tertiaryValue in primaryValue, nil, nil do
                                        if not inputValue.unlock_originals[tertiaryValue] then
                                            inputValue.unlock_originals[tertiaryValue] = {
                                                Section = tertiaryValue.Section,
                                                ForceHide = tertiaryValue.ForceHide,
                                                OriginalLayoutOrder = tertiaryValue.OriginalLayoutOrder or tertiaryValue.LayoutOrder,
                                            }
                                        end
                                        local quaternaryValue = inputValue:is_deleted(secondaryInput, tertiaryValue.Name)
                                        local auxiliaryValue = quaternaryValue and "Unowned" or "Owned"
                                        local conditionFlagA = false
                                        if tertiaryValue.Section ~= auxiliaryValue then
                                            tertiaryValue.Section = auxiliaryValue
                                            conditionFlagA = true
                                        end
                                        if tertiaryValue.OwnsItem and type(tertiaryValue.OwnsItem.Set) == "function" then
                                            pcall(tertiaryValue.OwnsItem.Set, tertiaryValue.OwnsItem, not quaternaryValue)
                                        end
                                        local isFavorited = not quaternaryValue and inputValue:is_fav(secondaryInput, tertiaryValue.Name)
                                        tertiaryValue.IsFavorited = isFavorited
                                        local originalLayoutOrder = tertiaryValue.OriginalLayoutOrder or tertiaryValue.LayoutOrder or 0
                                        tertiaryValue.OriginalLayoutOrder = originalLayoutOrder
                                        local layoutOrder = originalLayoutOrder - (isFavorited and 1000 or 0)
                                        if tertiaryValue.LayoutOrder ~= layoutOrder then
                                            tertiaryValue.LayoutOrder = layoutOrder
                                            conditionFlagA = true
                                        end
                                        if isFavorited then
                                            local name2 = "#" .. (tertiaryValue.Name_ or tertiaryValue.Name):gsub("^#", "")
                                            if tertiaryValue.Name_ ~= name2 then
                                                tertiaryValue.OriginalName_ = tertiaryValue.OriginalName_ or tertiaryValue.Name_
                                                tertiaryValue.Name_ = name2
                                                conditionFlagA = true
                                            end
                                        else
                                            local name2 = (tertiaryValue.Name_ or tertiaryValue.Name):gsub("^#", "")
                                            if tertiaryValue.Name_ ~= name2 then
                                                tertiaryValue.Name_ = name2
                                                conditionFlagA = true
                                            end
                                        end
                                        local forceHide = not tertiaryValue.InventoryKey and curveController[tertiaryValue.Name] or false
                                        if tertiaryValue.ForceHide ~= forceHide then
                                            tertiaryValue.ForceHide = forceHide
                                            conditionFlagA = true
                                        end
                                        if conditionFlagA and secondaryValue and secondaryValue.MarkDirty then
                                            secondaryValue.MarkDirty(tertiaryValue, false, true)
                                        end
                                    end
                                else
                                    inputValue.unlocked[secondaryInput] = nil
                                    for _, tertiaryValue in primaryValue, nil, nil do
                                        local quaternaryValue = inputValue.unlock_originals[tertiaryValue]
                                        if quaternaryValue then
                                            local conditionFlagA = false
                                            if tertiaryValue.Section ~= quaternaryValue.Section then
                                                tertiaryValue.Section = quaternaryValue.Section
                                                conditionFlagA = true
                                            end
                                            if tertiaryValue.ForceHide ~= quaternaryValue.ForceHide then
                                                tertiaryValue.ForceHide = quaternaryValue.ForceHide
                                                conditionFlagA = true
                                            end
                                            if conditionFlagA and secondaryValue and secondaryValue.MarkDirty then
                                                secondaryValue.MarkDirty(tertiaryValue, false, true)
                                            end
                                            inputValue.unlock_originals[tertiaryValue] = nil
                                        end
                                    end
                                end
                                if secondaryValue and secondaryValue.MarkDirty then
                                    secondaryValue.MarkDirty(nil, true, true)
                                end
                                if secondaryValue and secondaryValue.EndBatch then
                                    secondaryValue.EndBatch()
                                end
                                inputValue:refresh_visuals(secondaryInput)
                            end
                            inventoryUnlockManager.expected_size = function(inputValue, secondaryInput)
                                local calculationA
                                if secondaryInput == "Sword" and inputValue.swords then
                                    local primaryValue, secondaryValue = pcall(function()
                                        return inputValue.swords:GetCollection()
                                    end)
                                    local conditionFlagA = primaryValue and type(secondaryValue) == "table"
                                    calculationA = 0
                                    if conditionFlagA then
                                        for k in secondaryValue, nil, nil do
                                            calculationA = calculationA + 1
                                        end
                                    end
                                else
                                    calculationA = 0
                                    if secondaryInput == "Explosion" then
                                        local misc2 = ReplicatedStorage:FindFirstChild("Misc")
                                        misc2 = misc2 and misc2:FindFirstChild("DataExplosions")
                                        if misc2 then
                                            for _, primaryValue in misc2:GetChildren() do
                                                if not primaryValue:GetAttribute("Hidden") then
                                                    calculationA = calculationA + 1
                                                end
                                            end
                                        end
                                    end
                                end
                                return calculationA
                            end
                            inventoryUnlockManager.schedule_refresh = function(inputValue, secondaryInput)
                                inputValue.refresh_generation[secondaryInput] = (inputValue.refresh_generation[secondaryInput] or 0) + 1
                                local primaryValue = inputValue.refresh_generation[secondaryInput]
                                if type(inputValue.shop_controller._loadInventoryPage) == "function" then
                                    pcall(inputValue.shop_controller._loadInventoryPage, secondaryInput)
                                end
                                spawnTask(function()
                                    local secondaryValue = inputValue:expected_size(secondaryInput)
                                    local calculationA = -1
                                    local calculationB = 0
                                    for i = 1, 120 do
                                        heartbeat:Wait()
                                        if not inputValue.enabled or not inputValue.unlocked[secondaryInput] or inputValue.refresh_generation[secondaryInput] ~= primaryValue then
                                            return 
                                        end
                                        local tertiaryValue = inputValue.shop_controller._virtualItems[secondaryInput]
                                        local calculationC = 0
                                        if type(tertiaryValue) == "table" then
                                            for _, quaternaryValue in tertiaryValue, nil, nil do
                                                if not quaternaryValue.InventoryKey then
                                                    calculationC = calculationC + 1
                                                end
                                            end
                                        end
                                        if calculationC == calculationA and calculationC > 0 then
                                            calculationB = calculationB + 1
                                        else
                                            calculationB = 0
                                            calculationA = calculationC
                                        end
                                        if secondaryValue > 0 and calculationC >= secondaryValue or secondaryValue == 0 and calculationB >= 5 then
                                            heartbeat:Wait()
                                            inputValue:set_category_unlock(secondaryInput, true)
                                            return 
                                        end
                                    end
                                    if inputValue.enabled and inputValue.unlocked[secondaryInput] and inputValue.refresh_generation[secondaryInput] == primaryValue then
                                        inputValue:set_category_unlock(secondaryInput, true)
                                    end
                                end)
                            end
                            inventoryUnlockManager.refresh_selected = function(inputValue)
                                if not inputValue.shop_controller or not inputValue.shop then
                                    return 
                                end
                                local selectedItem = inputValue.shop_controller._selectedItem
                                if not selectedItem then
                                    return 
                                end
                                local buyButton = inputValue.shop.Holder.InfoBG:FindFirstChild("BuyButton")
                                local favorite = inputValue.shop.Holder:FindFirstChild("Favorite")
                                local delete = inputValue.shop.Holder.InfoBG:FindFirstChild("Delete")
                                if inputValue.enabled and inputValue.unlocked[selectedItem.type] and (selectedItem.type == "Sword" or selectedItem.type == "Explosion") then
                                    local virtualItems = inputValue.shop_controller._virtualItems and inputValue.shop_controller._virtualItems[selectedItem.type]
                                    local primaryValue = nil
                                    if virtualItems then
                                        primaryValue = inputValue.shop_controller._virtualItems[selectedItem.type][selectedItem.key or selectedItem.name]
                                    end
                                    if inputValue:is_deleted(selectedItem.type, selectedItem.name) or primaryValue and primaryValue.Section == "Unowned" then
                                        if buyButton then
                                            buyButton.Visible = false
                                        end
                                        if favorite then
                                            favorite.Visible = false
                                        end
                                        if delete then
                                            delete.Visible = true
                                        end
                                    else
                                        if buyButton then
                                            buyButton.Visible = true
                                            if buyButton:FindFirstChild("PriceTag") and buyButton.PriceTag:FindFirstChild("TextLabel") then
                                                buyButton.PriceTag.TextLabel.Visible = true
                                                buyButton.PriceTag.TextLabel.Text = "Equip"
                                            end
                                            if buyButton:FindFirstChild("PriceTag") and buyButton.PriceTag:FindFirstChild("Price") then
                                                buyButton.PriceTag.Price.Visible = false
                                            end
                                        end
                                        if favorite then
                                            favorite.Visible = true
                                            local secondaryValue = inputValue:is_fav(selectedItem.type, selectedItem.name)
                                            favorite.Image = secondaryValue and "rbxassetid://15697987058" or "rbxassetid://15697981750"
                                            favorite.HoverImage = secondaryValue and "rbxassetid://15697983062" or "rbxassetid://15697987058"
                                        end
                                        if delete then
                                            delete.Visible = true
                                        end
                                    end
                                end
                            end
                            inventoryUnlockManager.set_modern_unlock = function(inputValue, secondaryInput, tertiaryInput)
                                local shopApi = inputValue.shop_api
                                local ownedBases = shopApi and shopApi.OwnedBases and shopApi.OwnedBases[secondaryInput]
                                if type(ownedBases) ~= "table" then
                                    return 
                                end
                                for k, primaryValue in ownedBases, nil, nil do
                                    local secondaryValue, tertiaryValue = pcall(shopApi.ParseItemKey, shopApi, secondaryInput, {
                                        Name = k,
                                    })
                                    secondaryValue = secondaryValue and tertiaryValue
                                    local ownedCopies = nil
                                    if secondaryValue then
                                        local conditionFlagA, quaternaryValue = pcall(shopApi.GetItemData, shopApi, secondaryInput, tertiaryValue)
                                        conditionFlagA = conditionFlagA and type(quaternaryValue) == "table"
                                        ownedCopies = nil
                                        if conditionFlagA then
                                            ownedCopies = quaternaryValue.OwnedCopies
                                        end
                                    end
                                    local conditionFlagA = tertiaryInput and ownedCopies and type(ownedCopies.Get) == "function"
                                    if conditionFlagA then
                                        local quaternaryValue = "function"
                                        conditionFlagA = type(ownedCopies.Set) == quaternaryValue
                                    end
                                    if conditionFlagA then
                                        if not inputValue.modern_originals[ownedCopies] then
                                            local quaternaryValue, auxiliaryValue = pcall(ownedCopies.Get, ownedCopies)
                                            if quaternaryValue then
                                                inputValue.modern_originals[ownedCopies] = {
                                                    Value = auxiliaryValue,
                                                }
                                            end
                                        end
                                        local quaternaryValue, auxiliaryValue = pcall(ownedCopies.Get, ownedCopies)
                                        if quaternaryValue and (type(auxiliaryValue) ~= "number" or auxiliaryValue < 1) then
                                            pcall(ownedCopies.Set, ownedCopies, 1)
                                        end
                                    end
                                    if primaryValue and type(primaryValue.SetTag) == "function" then
                                        pcall(primaryValue.SetTag, primaryValue, inputValue.modern_tag, tertiaryInput and true or nil)
                                    end
                                    if not tertiaryInput and ownedCopies then
                                        local quaternaryValue = inputValue.modern_originals[ownedCopies]
                                        if quaternaryValue and type(ownedCopies.Set) == "function" then
                                            local state = primaryValue and primaryValue.State
                                            local conditionFlagB = state and type(state.Get) == "function"
                                            local conditionFlagC = false
                                            if conditionFlagB then
                                                local auxiliaryValue, candidateValue = pcall(state.Get, state)
                                                conditionFlagC = auxiliaryValue and candidateValue == true
                                            end
                                            if not conditionFlagC then
                                                pcall(ownedCopies.Set, ownedCopies, quaternaryValue.Value)
                                            end
                                            inputValue.modern_originals[ownedCopies] = nil
                                        end
                                    end
                                end
                            end
                            inventoryUnlockManager.hook_modern_shop = function(inputValue)
                                local shopApi = inputValue.shop_api
                                if not shopApi or inputValue.original_set_equipped then
                                    return 
                                end
                                if type(shopApi.SetEquipped) ~= "function" then
                                    return 
                                end
                                inputValue.original_set_equipped = shopApi.SetEquipped
                                shopApi.SetEquipped = function(secondaryInput, ...)
                                    local curveController = {
                                        ...,
                                    }
                                    local itemType = curveController[1]
                                    local name2 = curveController[2]
                                    if type(itemType) == "table" then
                                        name2 = itemType.Name
                                        itemType = itemType.ItemType
                                    elseif type(name2) == "table" then
                                        name2 = name2.Name
                                    end
                                    local ownedBases = shopApi.OwnedBases
                                    local primaryValue = "table"
                                    local conditionFlagA = type(ownedBases) == primaryValue and ownedBases[itemType]
                                    local conditionFlagB = type(conditionFlagA) == "table" and conditionFlagA[name2] ~= nil
                                    local enabled = inventoryUnlockManager.enabled
                                    local conditionFlagC
                                    if enabled then
                                        conditionFlagC = conditionFlagB or itemType == "Sword" or itemType == "Explosion"
                                    else
                                        conditionFlagC = enabled
                                    end
                                    if conditionFlagC then
                                        local conditionFlagD = itemType == "Sword"
                                        local pos
                                        if conditionFlagD then
                                            pos = conditionFlagD
                                        else
                                            pos = tostring(itemType):lower():find("sword")
                                        end
                                        if pos and inventoryUnlockManager:equip_sword(name2, false) then
                                            return true
                                        end
                                        local conditionFlagE = itemType == "Explosion"
                                        if not conditionFlagE then
                                            conditionFlagE = tostring(itemType):lower():find("explosion")
                                        end
                                        if conditionFlagE then
                                            return inventoryUnlockManager:equip_explosion(name2)
                                        end
                                    end
                                    return inventoryUnlockManager.original_set_equipped(secondaryInput, unpack(curveController))
                                end
                            end
                            inventoryUnlockManager.hook_shop = function(inputValue)
                                local shop = localPlayer:WaitForChild("PlayerGui"):FindFirstChild("Shop")
                                local holder = shop and shop:FindFirstChild("Holder")
                                local infoBG = holder and holder:FindFirstChild("InfoBG")
                                local buyButton = infoBG and infoBG:FindFirstChild("BuyButton")
                                if not shop or not buyButton then
                                    return false
                                end
                                inputValue.shop = shop
                                for _, primaryValue in getconnections(buyButton.Activated) do
                                    if primaryValue and primaryValue.Function then
                                        insertIntoTable(inputValue.original_buy_fns, primaryValue.Function)
                                        primaryValue:Disable()
                                    end
                                end
                                holder = holder and holder:FindFirstChild("Favorite")
                                if holder then
                                    for _, primaryValue in getconnections(holder.Activated) do
                                        if primaryValue and primaryValue.Function then
                                            primaryValue:Disable()
                                        end
                                    end
                                    holder.Activated:Connect(function()
                                        local selectedItem = inputValue.shop_controller and inputValue.shop_controller._selectedItem
                                        if selectedItem and inputValue.enabled and (selectedItem.type == "Sword" or selectedItem.type == "Explosion") then
                                            inputValue:toggle_fav(selectedItem.type, selectedItem.name)
                                        end
                                    end)
                                end
                                infoBG = infoBG and infoBG:FindFirstChild("Delete")
                                if infoBG then
                                    for _, primaryValue in getconnections(infoBG.Activated) do
                                        if primaryValue and primaryValue.Function then
                                            primaryValue:Disable()
                                        end
                                    end
                                    infoBG.Activated:Connect(function()
                                        local selectedItem = inputValue.shop_controller and inputValue.shop_controller._selectedItem
                                        local conditionFlagA = not selectedItem or not inputValue.enabled
                                        local conditionFlagB
                                        if conditionFlagA then
                                            conditionFlagB = conditionFlagA
                                        else
                                            conditionFlagB = selectedItem.type ~= "Sword" and selectedItem.type ~= "Explosion"
                                        end
                                        if conditionFlagB then
                                            return 
                                        end
                                        if inputValue:is_deleted(selectedItem.type, selectedItem.name) then
                                            inputValue:undelete_item(selectedItem.type, selectedItem.name)
                                        else
                                            inputValue:delete_item(selectedItem.type, selectedItem.name)
                                        end
                                    end)
                                end
                                game:GetService("GuiService"):GetPropertyChangedSignal("SelectedObject"):Connect(function()
                                    if not inputValue.enabled or not inputValue.shop or not inputValue.shop.Enabled then
                                        return 
                                    end
                                    deferTask(function()
                                        inputValue:refresh_selected()
                                    end)
                                end)
                                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                                    if true then
                                        if gameProcessed or not inputValue.enabled or not inputValue.shop or not inputValue.shop.Enabled or input.UserInputType ~= Enum.UserInputType.Gamepad1 then
                                            return 
                                        end
                                        local selectedItem = inputValue.shop_controller and inputValue.shop_controller._selectedItem
                                        if not selectedItem then
                                            return 
                                        end
                                        if input.KeyCode == Enum.KeyCode.ButtonY then
                                            if selectedItem.type == "Sword" or selectedItem.type == "Explosion" then
                                                inputValue:toggle_fav(selectedItem.type, selectedItem.name)
                                            end
                                        elseif input.KeyCode == Enum.KeyCode.ButtonX then
                                            if selectedItem.type == "Sword" or selectedItem.type == "Explosion" then
                                                if inputValue:is_deleted(selectedItem.type, selectedItem.name) then
                                                    inputValue:undelete_item(selectedItem.type, selectedItem.name)
                                                else
                                                    inputValue:delete_item(selectedItem.type, selectedItem.name)
                                                end
                                            end
                                        elseif input.KeyCode == Enum.KeyCode.ButtonA then
                                            local infoBG2 = inputValue.shop and inputValue.shop:FindFirstChild("Holder") and inputValue.shop.Holder:FindFirstChild("InfoBG")
                                            infoBG2 = infoBG2 and infoBG2:FindFirstChild("BuyButton")
                                            if selectedItem.type == "Sword" then
                                                inputValue:equip_sword(selectedItem.name, false)
                                                if infoBG2 and infoBG2:FindFirstChild("PriceTag") and infoBG2.PriceTag:FindFirstChild("TextLabel") then
                                                    infoBG2.PriceTag.TextLabel.Text = "Equipped"
                                                end
                                            elseif selectedItem.type == "Explosion" then
                                                inputValue:equip_explosion(selectedItem.name)
                                                if infoBG2 and infoBG2:FindFirstChild("PriceTag") and infoBG2.PriceTag:FindFirstChild("TextLabel") then
                                                    infoBG2.PriceTag.TextLabel.Text = "Equipped"
                                                end
                                            end
                                        end
                                    else
                                        while true do

                                        end
                                    end
                                end)
                                inputValue.shop_controller.itemSelected:Connect(function(secondaryInput)
                                    if secondaryInput and inputValue.unlocked[secondaryInput.type] then
                                        inputValue:set_category_unlock(secondaryInput.type, true)
                                    end
                                    deferTask(function()
                                        inputValue:refresh_selected()
                                    end)
                                end)
                                buyButton.Activated:Connect(function()
                                    local selectedItem = inputValue.shop_controller._selectedItem
                                    if not selectedItem then
                                        return 
                                    end
                                    if inputValue.enabled and inputValue.unlocked[selectedItem.type] then
                                        if inputValue:is_deleted(selectedItem.type, selectedItem.name) then
                                            inputValue:undelete_item(selectedItem.type, selectedItem.name)
                                        end
                                        if selectedItem.type == "Sword" then
                                            if inputValue:equip_sword(selectedItem.name, false) then
                                                buyButton.PriceTag.TextLabel.Text = "Equipped"
                                            end
                                            return 
                                        end
                                        if selectedItem.type == "Explosion" then
                                            inputValue:equip_explosion(selectedItem.name)
                                            buyButton.PriceTag.TextLabel.Text = "Equipped"
                                            return 
                                        end
                                    end
                                    for _, primaryValue in inputValue.original_buy_fns, nil, nil do
                                        spawnTask(primaryValue)
                                    end
                                end)
                                local function createTextInput()
                                    if not inputValue.shop.Enabled or not inputValue.enabled then
                                        return 
                                    end
                                    for _, primaryValue in {
                                        "Sword",
                                        "Explosion",
                                    }, nil, nil do
                                        if inputValue.unlocked[primaryValue] then
                                            inputValue:schedule_refresh(primaryValue)
                                        end
                                    end
                                end
                                inputValue.shop:GetPropertyChangedSignal("Enabled"):Connect(function()
                                    if inputValue.shop.Enabled then
                                        deferTask(createTextInput)
                                    end
                                end)
                                if inputValue.shop.Enabled then
                                    deferTask(createTextInput)
                                end
                                return true
                            end
                            inventoryUnlockManager.hook_sword_fx = function(inputValue)
                                local shared = ReplicatedStorage:FindFirstChild("Shared")
                                shared = shared and shared:FindFirstChild("ReplicatedInstances")
                                shared = shared and shared:FindFirstChild("Swords")
                                if shared then
                                    local primaryValue, secondaryValue = pcall(require, shared)
                                    if primaryValue then
                                        inputValue.swords = secondaryValue
                                    end
                                end
                                local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
                                remotes2 = remotes2 and remotes2:FindFirstChild("ParrySuccessAll")
                                if remotes2 then
                                    remotes2.OnClientEvent:Connect(function(...)
                                        if not inputValue.enabled or not inputValue.selected_sword or not inputValue.play_parry then
                                            return 
                                        end
                                        local curveController = {
                                            ...,
                                        }
                                        local sword = inputValue.swords and inputValue.swords:GetSword(inputValue.selected_sword)
                                        if sword and curveController[4] and tostring(curveController[4]) == name then
                                            curveController[1] = sword.SlashName
                                            curveController[3] = sword.Name
                                        end
                                        return inputValue.play_parry(unpack(curveController))
                                    end)
                                end
                            end
                            inventoryUnlockManager.setup_character = function(inputValue, secondaryInput)
                                if inputValue.character_connection then
                                    pcall(function()
                                        inputValue.character_connection:Disconnect()
                                    end)
                                    inputValue.character_connection = nil
                                end
                                if not secondaryInput then
                                    return 
                                end
                                if inputValue.enabled and config.last_equipped_sword and config.last_equipped_sword ~= "" then
                                    deferTask(function()
                                        if not controlFlagB then
                                            return 
                                        end
                                        if inputValue.enabled and config.last_equipped_sword ~= "" then
                                            inputValue:equip_sword(config.last_equipped_sword, false)
                                        end
                                    end)
                                end
                                local function createTextInput(child)
                                    if not inputValue.enabled or not child:IsA("Model") or not inputValue.swords or not inputValue.selected_sword then
                                        return 
                                    end
                                    local sword = inputValue.swords:GetSword(child.Name)
                                    if not sword then
                                        return 
                                    end
                                    if child.Name ~= inputValue.selected_sword then
                                        local selectedSword = inputValue.selected_sword
                                        deferTask(function()
                                            if inputValue.enabled and inputValue.selected_sword == selectedSword then
                                                inputValue:equip_sword(selectedSword, false)
                                            end
                                        end)
                                    else
                                        inputValue:apply_chroma(child, sword)
                                        if inputValue.sword_fn then
                                            deferTask(function()
                                                if inputValue.enabled and inputValue.selected_sword == child.Name then
                                                    if true then
                                                        pcall(inputValue.sword_fn, child.Name)
                                                    else
                                                        while true do

                                                        end
                                                    end
                                                end
                                            end)
                                        end
                                    end
                                end
                                inputValue.character_connection = secondaryInput.ChildAdded:Connect(createTextInput)
                                for _, primaryValue in secondaryInput:GetChildren() do
                                    createTextInput(primaryValue)
                                end
                            end
                            inventoryUnlockManager.hook_chroma = function(inputValue)
                                if inputValue.chroma_bound then
                                    return 
                                end
                                inputValue.chroma_bound = true
                                inputValue.added_connection = localPlayer.CharacterAdded:Connect(function(character)
                                    inputValue:setup_character(character)
                                end)
                                if localPlayer.Character then
                                    deferTask(function()
                                        inputValue:setup_character(localPlayer.Character)
                                    end)
                                end
                                inputValue.sword_attr_connection = localPlayer:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
                                    local selectedSword = inputValue.selected_sword
                                    if not inputValue.enabled or not selectedSword or localPlayer:GetAttribute("CurrentlyEquippedSword") == selectedSword then
                                        return 
                                    end
                                    localPlayer:SetAttribute("CurrentlyEquippedSword", selectedSword)
                                    if localPlayer.Character then
                                        localPlayer.Character:SetAttribute("CurrentlyEquippedSword", selectedSword)
                                    end
                                    if inputValue.sword_fn then
                                        pcall(inputValue.sword_fn, selectedSword)
                                    end
                                end)
                            end
                            inventoryUnlockManager.initialize = function(inputValue)
                                local primaryValue = ReplicatedStorage.Controllers:FindFirstChild("UI")
                                local shopController = primaryValue and primaryValue:FindFirstChild("ShopController")
                                local secondaryValue = primaryValue and primaryValue:FindFirstChild("ShopControllerAPI")
                                local tertiaryValue, quaternaryValue = pcall(require, shopController)
                                local auxiliaryValue, candidateValue = pcall(require, secondaryValue)
                                local conditionFlagA = not tertiaryValue
                                if not conditionFlagA then
                                    local resultValue = "table"
                                    conditionFlagA = type(quaternaryValue) ~= resultValue
                                end
                                if conditionFlagA then
                                    quaternaryValue = nil
                                end
                                if not auxiliaryValue or type(candidateValue) ~= "table" then
                                    candidateValue = nil
                                end
                                if not quaternaryValue and not candidateValue then
                                    warn("[oxy] unlock all: failed to load shop controllers")
                                    return 
                                end
                                inputValue.shop_controller = quaternaryValue
                                inputValue.shop_api = candidateValue
                                inputValue:hook_sword_fx()
                                inputValue:hook_chroma()
                                pcall(function()
                                    inputValue.explosion_module = require(ReplicatedStorage.Controllers.VFXController)
                                end)
                                inputValue:ensure_explosion_wrap()
                                if inputValue.shop_controller then
                                    inputValue:hook_shop()
                                end
                                if inputValue.shop_api then
                                    inputValue:hook_modern_shop()
                                end
                                inputValue.ready = true
                                inputValue:set_enabled(inputValue.enabled)
                                if inputValue.enabled and config.last_equipped_sword and config.last_equipped_sword ~= "" then
                                    deferTask(function()
                                        if inputValue.enabled and config.last_equipped_sword ~= "" then
                                            inputValue:equip_sword(config.last_equipped_sword, false)
                                        end
                                    end)
                                end
                                if inputValue.enabled and config.last_equipped_explosion and config.last_equipped_explosion ~= "" then
                                    deferTask(function()
                                        if inputValue.enabled and config.last_equipped_explosion ~= "" then
                                            inputValue:equip_explosion(config.last_equipped_explosion)
                                        end
                                    end)
                                end
                            end
                            inventoryUnlockManager.set_enabled = function(inputValue, secondaryInput)
                                inputValue.enabled = secondaryInput == true
                                if not inputValue.ready then
                                    return 
                                end
                                for _, primaryValue in {
                                    "Sword",
                                    "Explosion",
                                }, nil, nil do
                                    if inputValue.enabled then
                                        if inputValue.shop_controller then
                                            inputValue:set_category_unlock(primaryValue, true)
                                            inputValue:schedule_refresh(primaryValue)
                                        end
                                        inputValue:set_modern_unlock(primaryValue, true)
                                    else
                                        if inputValue.shop_controller then
                                            inputValue.refresh_generation[primaryValue] = (inputValue.refresh_generation[primaryValue] or 0) + 1
                                            inputValue:set_category_unlock(primaryValue, false)
                                        end
                                        inputValue:set_modern_unlock(primaryValue, false)
                                    end
                                end
                                if not inputValue.enabled then
                                    inputValue:restore_sword()
                                    inputValue.selected_explosion = nil
                                else
                                    inputValue:refresh_selected()
                                end
                            end
                            spawnTask(function()
                                inventoryUnlockManager:initialize()
                            end)
                            misc:AddToggle("UnlockAll", { Title = "Unlock all", Default = config.unlock_all or false, Callback = function(unlockAll)
                                config.unlock_all = unlockAll
                                inventoryUnlockManager:set_enabled(unlockAll)
                            end })
                        end
                    end
                    do
                        local ScreenGui = nil
                        misc:AddToggle("ball_stats", { Title = "Ball stats", Default = config.ball_debug or false, Callback = function(ballDebug)
                            config.ball_debug = ballDebug
                            if ballDebug then
                                ScreenGui = createGuiInstance("ScreenGui", {
                                    Parent = localPlayer:WaitForChild("PlayerGui"),
                                    ResetOnSpawn = false,
                                })
                                local TextLabel = createGuiInstance("TextLabel", {
                                    Size = createUDim2(0.2, 0, 0.05, 0),
                                    Position = createUDim2(0.7, 0, 0.1, 0),
                                    TextSize = 26,
                                    BackgroundTransparency = 1,
                                    TextColor3 = Color3.new(1, 1, 1),
                                    Font = Enum.Font.Fantasy,
                                    Text = "waiting...",
                                    Parent = ScreenGui,
                                })
                                local inventoryUnlockManager = {
                                }
                                runtimeConnections.ball_stats = heartbeat:Connect(function()
                                    local primaryValue = ballState.get_all()
                                    if not controlFlagA then
                                        return 
                                    end
                                    if #primaryValue == 0 then
                                        TextLabel.Text = "waiting..."
                                        TextLabel.TextColor3 = Color3.new(1, 1, 1)
                                        return 
                                    end
                                    local curveController = {
                                    }
                                    for _, secondaryValue in primaryValue, nil, nil do
                                        curveController[secondaryValue] = true
                                    end
                                    for k in inventoryUnlockManager, nil, nil do
                                        if not curveController[k] then
                                            inventoryUnlockManager[k] = nil
                                        end
                                    end
                                    local calculationA = 0
                                    local secondaryValue = nil
                                    for _, tertiaryValue in primaryValue, nil, nil do
                                        local quaternaryValue = tertiaryValue:FindFirstChild("zoomies")
                                        if quaternaryValue then
                                            local auxiliaryValue = maxValue(inventoryUnlockManager[tertiaryValue] or 0, quaternaryValue.VectorVelocity.Magnitude)
                                            inventoryUnlockManager[tertiaryValue] = auxiliaryValue
                                            if auxiliaryValue > calculationA then
                                                calculationA = auxiliaryValue
                                                secondaryValue = tertiaryValue
                                            end
                                        end
                                    end
                                    if secondaryValue then
                                        local conditionFlagA = calculationA >= 2200
                                        TextLabel.Text = formatString("ball velocity: %.0f", calculationA) .. (conditionFlagA and " (LIMIT!)" or "")
                                        TextLabel.TextColor3 = conditionFlagA and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)
                                    else
                                        TextLabel.Text = "waiting..."
                                        TextLabel.TextColor3 = Color3.new(1, 1, 1)
                                    end
                                end)
                            else
                                if runtimeConnections.ball_stats then
                                    runtimeConnections.ball_stats:Disconnect()
                                    runtimeConnections.ball_stats = nil
                                end
                                if ScreenGui then
                                    ScreenGui:Destroy()
                                    ScreenGui = nil
                                end
                            end
                        end })
                    end
                    return 
                end
                while true do

                end
            end
        end
    end
end
