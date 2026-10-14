-- Script corrigido para carregamento assíncrono da UI (FluentPlus)
-- O carregamento da biblioteca de UI é a principal causa do congelamento.
-- Envolver o script em task.spawn() permite que o jogo permaneça responsivo enquanto a UI carrega em segundo plano.
task.spawn(function()
--return Library

-- Script refatorado para usar a Fluent UI Library (FluentPlus)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Criar a janela principal
local Window = Fluent:CreateWindow({
    Title = "angeli",
    SubTitle = "",
    TabWidth = 100,
    Size = UDim2.fromOffset(440, 315),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})
-- Mapeamento das abas para a nova sintaxe da Fluent UI
local Tabs = {
    Rage = Window:AddTab({Title = "Autoparry", Icon = "sword"}),
    Detection = Window:AddTab({Title = "Detection", Icon = "eye"}),
    Spam = Window:AddTab({Title = "Spam", Icon = "skull"}),
    Player = Window:AddTab({Title = "Player", Icon = "user"}),
    Visuals = Window:AddTab({Title = "Visuals", Icon = "monitor"}),
    Misc = Window:AddTab({Title = "Misc", Icon = "settings"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "sliders"})
}

local Options = Fluent.Options

-- O restante do código original começa aqui

repeat task.wait(0.5) until game:IsLoaded()

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

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

local Alive = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
local Runtime = workspace.Runtime

local System = {
    __properties = {
        __autoparry_enabled = false,
        __triggerbot_enabled = false,
        __manual_spam_enabled = false,
        __auto_spam_enabled = false,
        __play_animation = false,
        __curve_mode = 1,
        __accuracy = 1,
        __divisor_multiplier = 1.1,
        __parried = false,
        __training_parried = false,
        __spam_threshold = 1.5,
        __parries = 0,
        __parry_key = nil,
        __grab_animation = nil,
        __tornado_time = tick(),
        __first_parry_done = false,
        __connections = {},
        __reverted_remotes = {},
        __spam_accumulator = 0,
        __spam_rate = 240,
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
    },
    
    __triggerbot = {
        __enabled = false,
        __is_parrying = false,
        __parries = 0,
        __max_parries = 10000,
        __parry_delay = 0.5
    }
}

local revertedRemotes = {}
local originalMetatables = {}
local Parry_Key = nil
local PF = nil
local SC = nil

if ReplicatedStorage:FindFirstChild("Controllers") then
    for _, child in ipairs(ReplicatedStorage.Controllers:GetChildren()) do
        if child.Name:match("^SwordsController%s*$") then
            SC = child
        end
    end
end

local function update_divisor()
    System.__properties.__divisor_multiplier = 0.59 + (System.__properties.__accuracy - 1) * (3 / 99)
end

local function update_randomized_accuracy()
    if not System.__properties.__randomized_accuracy_enabled then return end
    
    local ping_str = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    local ping = tonumber(ping_str:match("%d+")) or 0
    
    local new_accuracy
    if ping >= 90 then
        new_accuracy = 4
    elseif ping <= 50 then
        new_accuracy = math.random(70, 100)
    else
        new_accuracy = System.__properties.__accuracy
    end
    
    if new_accuracy then
        System.__properties.__accuracy = new_accuracy
        update_divisor()
    end
end

task.spawn(function()
    while task.wait(1) do
        if System.__properties.__randomized_accuracy_enabled then
            update_randomized_accuracy()
        end
    end
end)

-- SISTEMA DE BYPASS DO angeli.LUA (SIMPLIFICADO E MODIFICADO)
local DualBypassSystem = {
    __properties = {
        __captured_data = nil,
        __first_parry_done = false,
        __test_bypass_enabled = true,
        __use_virtual_input_once = true,
        __virtual_input_used = false,
        __original_metatables = {},
        __active_hooks = {}
    }
}

-- Função para validar args do remote (IDÊNTICA AO angeli.LUA)
function DualBypassSystem.isValidRemoteArgs(args)
    return #args == 7 and
        type(args[2]) == "string" and
        type(args[3]) == "number" and
        typeof(args[4]) == "CFrame" and
        type(args[5]) == "table" and
        type(args[6]) == "table" and
        type(args[7]) == "boolean"
end

function DualBypassSystem.hookRemote(remote)
    if not DualBypassSystem.__properties.__original_metatables[getrawmetatable(remote)] then
        DualBypassSystem.__properties.__original_metatables[getrawmetatable(remote)] = true
        local meta = getrawmetatable(remote)
        setreadonly(meta, false)

        local oldIndex = meta.__index
        meta.__index = function(self, key)
            if (key == "FireServer" and self:IsA("RemoteEvent")) or
               (key == "InvokeServer" and self:IsA("RemoteFunction")) then
                return function(obj, ...)
                    local args = {...}
                    -- Capturar dados do primeiro parry válido
                    if DualBypassSystem.isValidRemoteArgs(args) and not DualBypassSystem.__properties.__captured_data then
                        DualBypassSystem.__properties.__captured_data = {
                            remote = obj,
                            args = args
                        }
                    end
                    
                    -- Também salvar para o bypass original
                    if DualBypassSystem.isValidRemoteArgs(args) and not revertedRemotes[obj] then
                        revertedRemotes[obj] = args
                        Parry_Key = args[2]
                    end
                    
                    return oldIndex(self, key)(obj, unpack(args))
                end
            end
            return oldIndex(self, key)
        end
        setreadonly(meta, true)
    end
end

for _, remote in pairs(ReplicatedStorage:GetChildren()) do
    if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
        DualBypassSystem.hookRemote(remote)
    end
end

ReplicatedStorage.ChildAdded:Connect(function(child)
    if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
        DualBypassSystem.hookRemote(child)
    end
end)

-- Executar o bypass (MODIFICADO: APENAS VIRTUAL INPUT PARA PRIMEIRO PARRY)
function DualBypassSystem.execute_test_bypass()
    if not DualBypassSystem.__properties.__captured_data or not DualBypassSystem.__properties.__test_bypass_enabled then
        return
    end

    local captured = DualBypassSystem.__properties.__captured_data
    local remote = captured.remote
    local original_args = captured.args
    
    -- Preparar dados para manter funcionalidade
    local camera = workspace.CurrentCamera
    local event_data = {}
    
    if Alive then
        for _, entity in pairs(Alive:GetChildren()) do
            if entity.PrimaryPart then
                local success, screen_point = pcall(function()
                    return camera:WorldToScreenPoint(entity.PrimaryPart.Position)
                end)
                if success then
                    event_data[entity.Name] = screen_point
                end
            end
        end
    end
    
    -- Usar posição da câmera como alvo
    local is_mobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
    local final_aim_target
    
    if is_mobile then
        local viewport = camera.ViewportSize
        final_aim_target = {viewport.X / 2, viewport.Y / 2}
    else
        local success, mouse = pcall(function()
            return UserInputService:GetMouseLocation()
        end)
        if success then
            final_aim_target = {mouse.X, mouse.Y}
        else
            final_aim_target = {0, 0}
        end
    end
    
    -- Replicar o parry usando a estrutura capturada
    local modified_args = {
        original_args[1], -- ID da bola
        original_args[2], -- Parry Key capturada
        original_args[3],
        camera.CFrame,    -- CFrame atual (câmera)
        event_data,       -- Entidades na tela
        final_aim_target, -- Alvo do mouse/câmera
        original_args[7]
    }
    
    -- Executar o bypass
    pcall(function()
        if remote:IsA('RemoteEvent') then
            remote:FireServer(unpack(modified_args))
        elseif remote:IsA('RemoteFunction') then
            remote:InvokeServer(unpack(modified_args))
        end
    end)
end

System.animation = {}

function System.animation.play_grab_parry()
    if not System.__properties.__play_animation then
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local animator = humanoid and humanoid:FindFirstChildOfClass('Animator')
    if not humanoid or not animator then return end
    
    local sword_name
    if getgenv().skinChangerEnabled then
        sword_name = getgenv().swordAnimations
    else
        sword_name = character:GetAttribute('CurrentlyEquippedSword')
    end
    if not sword_name then return end
    
    local sword_api = ReplicatedStorage.Shared.SwordAPI.Collection
    local parry_animation = sword_api.Default:FindFirstChild('GrabParry')
    if not parry_animation then return end
    
    local sword_data = ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(sword_name)
    if not sword_data or not sword_data['AnimationType'] then return end
    
    for _, object in pairs(sword_api:GetChildren()) do
        if object.Name == sword_data['AnimationType'] then
            if object:FindFirstChild('GrabParry') or object:FindFirstChild('Grab') then
                local animation_type = object:FindFirstChild('GrabParry') and 'GrabParry' or 'Grab'
                parry_animation = object[animation_type]
            end
        end
    end
    
    if System.__properties.__grab_animation and System.__properties.__grab_animation.IsPlaying then
        System.__properties.__grab_animation:Stop()
    end
    
    System.__properties.__grab_animation = animator:LoadAnimation(parry_animation)
    System.__properties.__grab_animation.Priority = Enum.AnimationPriority.Action4
    System.__properties.__grab_animation:Play()
end

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
    local balls_table = {}
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return balls_table end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            table.insert(balls_table, ball)
        end
    end
    return balls_table
end

System.player = {}

local Closest_Entity = nil

local last_closest_check = 0
function System.player.get_closest()
    local now = tick()
    if now - last_closest_check < 0.1 then
        return Closest_Entity
    end
    last_closest_check = now

    local max_distance = math.huge
    local closest_entity = nil
    
    if not Alive then return nil end
    
    for _, entity in pairs(Alive:GetChildren()) do
        if entity ~= LocalPlayer.Character then
            if entity.PrimaryPart then
                local distance = LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
                if distance < max_distance then
                    max_distance = distance
                    closest_entity = entity
                end
            end
        end
    end
    
    Closest_Entity = closest_entity
    return closest_entity
end

function System.player.get_closest_to_cursor()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
        return nil
    end
    
    local closest_player = nil
    local minimal_dot = -math.huge
    local camera = workspace.CurrentCamera
    
    if not Alive then return nil end
    
    local success, mouse_location = pcall(function()
        return UserInputService:GetMouseLocation()
    end)
    
    if not success then return nil end
    
    local ray = camera:ScreenPointToRay(mouse_location.X, mouse_location.Y)
    local pointer = CFrame.lookAt(ray.Origin, ray.Origin + ray.Direction)
    
    for _, player in pairs(Alive:GetChildren()) do
        if player == LocalPlayer.Character then continue end
        if not player:FindFirstChild('HumanoidRootPart') then continue end
        
        local direction = (player.HumanoidRootPart.Position - camera.CFrame.Position).Unit
        local dot = pointer.LookVector:Dot(direction)
        
        if dot > minimal_dot then
            minimal_dot = dot
            closest_player = player
        end
    end
    
    return closest_player
end

System.curve = {}

function System.curve.get_cframe()
    local camera = workspace.CurrentCamera
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    if not root then return camera.CFrame end
    
    local targetPart
    local closest = System.player.get_closest_to_cursor()
    if closest and closest:FindFirstChild('HumanoidRootPart') then
        targetPart = closest.HumanoidRootPart
    end
    
    local target_pos = targetPart and targetPart.Position or (root.Position + camera.CFrame.LookVector * 100)
    
    local curve_functions = {
        function() return camera.CFrame end,
        
        function()
            local direction = (target_pos - root.Position).Unit
            local random_offset
            local attempts = 0
            repeat
                random_offset = Vector3.new(
                    math.random(-4000, 4000),
                    math.random(-4000, 4000),
                    math.random(-4000, 4000)
                )
                local curve_direction = (target_pos + random_offset - root.Position).Unit
                local dot = direction:Dot(curve_direction)
                attempts = attempts + 1
            until dot < 0.95 or attempts > 10
            return CFrame.new(root.Position, target_pos + random_offset)
        end,
        
        function()
            return CFrame.new(root.Position, target_pos + Vector3.new(0, 5, 0))
        end,
        
        function()
            local direction = (root.Position - target_pos).Unit
            local backwards_pos = root.Position + direction * 10000 + Vector3.new(0, 1000, 0)
            return CFrame.new(camera.CFrame.Position, backwards_pos)
        end,
        
        function()
            return CFrame.new(root.Position, target_pos + Vector3.new(0, -9e18, 0))
        end,
        
        function()
            return CFrame.new(root.Position, target_pos + Vector3.new(0, 9e18, 0))
        end
    }
    
    return curve_functions[System.__properties.__curve_mode]()
end

System.parry = {}

function System.parry.execute()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then
        return
    end
    
    -- USAR VIRTUAL INPUT APENAS PARA O PRIMEIRO PARRY (SEM BLOCK BUTTON)
    if not System.__properties.__first_parry_done and DualBypassSystem.__properties.__use_virtual_input_once 
       and not DualBypassSystem.__properties.__virtual_input_used then
        -- Simular um clique virtual (sem usar o Block Button)
        System.__properties.__first_parry_done = true
        DualBypassSystem.__properties.__virtual_input_used = true
        print("🎮 VirtualInput usado para primeiro parry (sem Block Button)")
        
        task.wait(0.1)
    end

    local camera = workspace.CurrentCamera
    local success, mouse = pcall(function()
        return UserInputService:GetMouseLocation()
    end)
    
    if not success then return end
    
    local vec2_mouse = {mouse.X, mouse.Y}
    local is_mobile = System.__properties.__is_mobile
    
    local event_data = {}
    if Alive then
        for _, entity in pairs(Alive:GetChildren()) do
            if entity.PrimaryPart then
                local success2, screen_point = pcall(function()
                    return camera:WorldToScreenPoint(entity.PrimaryPart.Position)
                end)
                if success2 then
                    event_data[entity.Name] = screen_point
                end
            end
        end
    end
    
    local curve_cframe = System.curve.get_cframe()

    local final_aim_target
    if is_mobile then
        local viewport = camera.ViewportSize
        final_aim_target = {viewport.X / 2, viewport.Y / 2}
    else
        final_aim_target = vec2_mouse
    end

    for remote, original_args in pairs(revertedRemotes) do
        local modified_args = {
            original_args[1],
            original_args[2],
            original_args[3],
            curve_cframe,
            event_data,
            final_aim_target,
            original_args[7]
        }
        
        pcall(function()
            if remote:IsA('RemoteEvent') then
                remote:FireServer(unpack(modified_args))
            elseif remote:IsA('RemoteFunction') then
                remote:InvokeServer(unpack(modified_args))
            end
        end)
    end
    
    -- EXECUTAR BYPASS DO TEST (ENVIAR BOLA PARA CÂMERA)
    if DualBypassSystem.__properties.__test_bypass_enabled and DualBypassSystem.__properties.__captured_data then
        DualBypassSystem.execute_test_bypass()
    end
    
    if System.__properties.__parries > 10000 then return end
    
    System.__properties.__parries = System.__properties.__parries + 1
    task.delay(0.5, function()
        if System.__properties.__parries > 0 then
            System.__properties.__parries = System.__properties.__parries - 1
        end
    end)
end

function System.parry.keypress()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then
        return
    end

    local camera = workspace.CurrentCamera
    local curve_cframe = System.curve.get_cframe()
    local event_data = {}
    
    if Alive then
        for _, entity in pairs(Alive:GetChildren()) do
            if entity.PrimaryPart then
                local success2, screen_point = pcall(function()
                    return camera:WorldToScreenPoint(entity.PrimaryPart.Position)
                end)
                if success2 then
                    event_data[entity.Name] = screen_point
                end
            end
        end
    end
    
    local is_mobile = System.__properties.__is_mobile
    local final_aim_target
    
    if is_mobile then
        local viewport = camera.ViewportSize
        final_aim_target = {viewport.X / 2, viewport.Y / 2}
    else
        local success, mouse = pcall(function()
            return UserInputService:GetMouseLocation()
        end)
        if success then
            final_aim_target = {mouse.X, mouse.Y}
        else
            final_aim_target = {0, 0}
        end
    end
    
    for remote, original_args in pairs(revertedRemotes) do
        local modified_args = {
            original_args[1],
            original_args[2],
            original_args[3],
            curve_cframe,
            event_data,
            final_aim_target,
            original_args[7]
        }
        
        pcall(function()
            if remote:IsA('RemoteEvent') then
                remote:FireServer(unpack(modified_args))
            elseif remote:IsA('RemoteFunction') then
                remote:InvokeServer(unpack(modified_args))
            end
        end)
    end
    
    if System.__properties.__parries > 10000 then return end
    
    System.__properties.__parries = System.__properties.__parries + 1
    task.delay(0.5, function()
        if System.__properties.__parries > 0 then
            System.__properties.__parries = System.__properties.__parries - 1
        end
    end)
end

function System.parry.execute_action()
    System.animation.play_grab_parry()
    System.parry.execute()
end

local function linear_predict(a, b, t)
    return a + (b - a) * t
end

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

    if props.__lerp_radians < 0.016 then
        props.__last_warping = tick()
    end

    if distance < (ball_distance_threshold * 0.85) then
        return false
    end

    local sudden_curve = (tick() - props.__last_warping) < (reach_time / 1.4)
    if sudden_curve then
        return true
    end

    local sustained_curve = (tick() - props.__curving) < (reach_time / 1.1)
    if sustained_curve then
        return true
    end

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
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
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
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
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
                System.parry.execute()
                task.wait(parryDelay)
            else
                break
            end
        end
    end)
end)

Runtime.ChildAdded:Connect(function(Object)
    if System.__config.__detections.__phantom then
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
                                
                                task.delay(1, function()
                                    System.__properties.__parried = false
                                end)
                                
                            elseif Highlighted == false then
                                FocusConnection:Disconnect()
                            end
                        end)
                        
                        task.delay(3, function()
                            if FocusConnection and FocusConnection.Connected then
                                FocusConnection:Disconnect()
                            end
                        end)
                    end
                end
            end
        end
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, root)
    if root.Parent and root.Parent ~= LocalPlayer.Character then
        if not Alive or root.Parent.Parent ~= Alive then
            return
        end
    end
    
    local closest = System.player.get_closest()
    local ball = System.ball.get()
    
    if not ball or not closest then return end
    
    local target_distance = (LocalPlayer.Character.PrimaryPart.Position - closest.PrimaryPart.Position).Magnitude
    local distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
    local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
    local dot = direction:Dot(ball.AssemblyLinearVelocity.Unit)
    
    local curve_detected = System.detection.is_curved()
    
    if target_distance < 15 and distance < 15 and dot > -0.25 then
        if curve_detected then
            System.parry.execute_action()
        end
    end
    
    if System.__properties.__grab_animation then
        System.__properties.__grab_animation:Stop()
    end
end)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if not Alive or LocalPlayer.Character.Parent ~= Alive then
        return
    end
    
    if System.__properties.__grab_animation then
        System.__properties.__grab_animation:Stop()
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(a, b)
    local Primary_Part = LocalPlayer.Character.PrimaryPart
    local Ball = System.ball.get()

    if not Ball then
        return
    end

    local Zoomies = Ball:FindFirstChild('zoomies')

    if not Zoomies then
        return
    end

    local Speed = Zoomies.VectorVelocity.Magnitude

    local Distance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
    local Velocity = Zoomies.VectorVelocity

    local Ball_Direction = Velocity.Unit

    local Direction = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Unit
    local Dot = Direction:Dot(Ball_Direction)

    local Pings = Stats.Network.ServerStatsItem['Data Ping']:GetValue()

    local Speed_Threshold = math.min(Speed / 100, 40)
    local Reach_Time = Distance / Speed - (Pings / 1000)

    local Enough_Speed = Speed > 1
    local Ball_Distance_Threshold = 15 - math.min(Distance / 1000, 15) + Speed_Threshold

    if Enough_Speed and Reach_Time > Pings / 10 then
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 15, 15)
    end

    if b ~= Primary_Part and Distance > Ball_Distance_Threshold then
        System.detection.__ball_properties.__curving = tick()
    end
end)

System.triggerbot = {}

function System.triggerbot.trigger(ball)
    if System.__triggerbot.__is_parrying or System.__triggerbot.__parries > System.__triggerbot.__max_parries then
        return
    end
    
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and 
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then
        return
    end
    
    System.__triggerbot.__is_parrying = true
    System.__triggerbot.__parries = System.__triggerbot.__parries + 1
    
    System.animation.play_grab_parry()
    System.parry.execute()
    
    task.delay(System.__triggerbot.__parry_delay, function()
        if System.__triggerbot.__parries > 0 then
            System.__triggerbot.__parries = System.__triggerbot.__parries - 1
        end
    end)
    
    local connection
    connection = ball:GetAttributeChangedSignal('target'):Once(function()
        System.__triggerbot.__is_parrying = false
        if connection then
            connection:Disconnect()
        end
    end)
    
    task.spawn(function()
        local start_time = tick()
        repeat
            RunService.Heartbeat:Wait()
        until (tick() - start_time >= 1 or not System.__triggerbot.__is_parrying)
        
        System.__triggerbot.__is_parrying = false
    end)
end

function System.triggerbot.loop()
    if not System.__triggerbot.__enabled then return end
    
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and 
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then
        return
    end
    
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:IsA('BasePart') and ball:GetAttribute('target') == LocalPlayer.Name then
            System.triggerbot.trigger(ball)
            break
        end
    end
end

function System.triggerbot.enable(enabled)
    System.__triggerbot.__enabled = enabled
    
    if enabled then
        if not System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot = RunService.Heartbeat:Connect(System.triggerbot.loop)
        end
    else
        if System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot:Disconnect()
            System.__properties.__connections.__triggerbot = nil
        end
        System.__triggerbot.__is_parrying = false
        System.__triggerbot.__parries = 0
    end
end

System.manual_spam = {}

local manualSpamThread = nil

function System.manual_spam.start()
    System.manual_spam.stop()

    System.__properties.__manual_spam_enabled = true

    -- Cache de funções (performance extrema)
    local parry_keypress = System.parry.keypress
    local parry_execute = System.parry.execute
    local play_animation = System.animation.play_grab_parry

    local threshold = 0.015

    manualSpamThread = coroutine.create(function()
        local last_spam = 0

        while System.__properties.__manual_spam_enabled do
            local now = os.clock()

            if now - last_spam >= threshold then
                last_spam = now

                if getgenv().ManualSpamMode == "Keypress" then
                    parry_keypress()
                else
                    parry_execute()
                    if getgenv().ManualSpamAnimationFix then
                        play_animation()
                    end
                end
            end

            coroutine.yield()
        end
    end)

    -- Scheduler simples
    task.spawn(function()
        while System.__properties.__manual_spam_enabled
            and manualSpamThread
            and coroutine.status(manualSpamThread) ~= "dead" do

            coroutine.resume(manualSpamThread)
            task.wait()
        end
    end)
end

function System.manual_spam.stop()
    System.__properties.__manual_spam_enabled = false
    manualSpamThread = nil
end

System.auto_spam = {}

local autoSpamThread = nil

function System.auto_spam.start()
    System.auto_spam.stop()

    System.__properties.__auto_spam_enabled = true

    autoSpamThread = coroutine.create(function()
        while System.__properties.__auto_spam_enabled do
            if System.__properties.__spam_target then
                System.parry.execute()
            end

            coroutine.yield()
        end
    end)

    task.spawn(function()
        while System.__properties.__auto_spam_enabled
            and autoSpamThread
            and coroutine.status(autoSpamThread) ~= "dead" do

            coroutine.resume(autoSpamThread)
            task.wait()
        end
    end)
end

function System.auto_spam.stop()
    System.__properties.__auto_spam_enabled = false
    System.__properties.__spam_target = nil
    System.__properties.__spam_target_time = 0
    autoSpamThread = nil
end

function System.auto_spam:get_entity_properties()
    local entity = Closest_Entity
    if not entity or not entity.PrimaryPart then return false end
    
    local char = LocalPlayer.Character
    if not char or not char.PrimaryPart then return false end
    
    local root_pos = char.PrimaryPart.Position
    local entity_pos = entity.PrimaryPart.Position
    local diff = root_pos - entity_pos
    
    return {
        Velocity = entity.PrimaryPart.Velocity,
        Direction = diff.Unit,
        Distance = diff.Magnitude
    }
end

function System.auto_spam:get_ball_properties()
    local ball = System.ball.get()
    if not ball then return false end
    
    local char = LocalPlayer.Character
    if not char or not char.PrimaryPart then return false end
    
    local ball_pos = ball.Position
    local root_pos = char.PrimaryPart.Position
    local diff = root_pos - ball_pos
    
    local ball_velocity = ball.AssemblyLinearVelocity or Vector3.zero
    
    return {
        Velocity = ball_velocity,
        Direction = diff.Unit,
        Distance = diff.Magnitude,
        Dot = diff.Unit:Dot(ball_velocity.Unit)
    }
end

function System.auto_spam.spam_service(self)
    local ball = System.ball.get()
    local entity = System.player.get_closest()
    
    if not ball or not entity or not entity.PrimaryPart then
        return false
    end
    
    local spam_accuracy = 0
    
    local velocity = ball.AssemblyLinearVelocity or Vector3.zero
    local speed = velocity.Magnitude
    
    local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
    local dot = direction:Dot(velocity.Unit)
    
    local target_position = entity.PrimaryPart.Position
    local target_distance = LocalPlayer:DistanceFromCharacter(target_position)
    
    local multiplier = System.__properties.__auto_spam_distance_multiplier or 1.0
    local base_distance = 30 * multiplier
    local maximum_spam_distance = (self.Ping + math.min(speed / 4, 60)) * multiplier
    
    if self.Entity_Properties.Distance > maximum_spam_distance and self.Entity_Properties.Distance > base_distance then
        return 0
    end
    
    if self.Ball_Properties.Distance > maximum_spam_distance and self.Ball_Properties.Distance > base_distance then
        return 0
    end
    
    if target_distance > maximum_spam_distance and target_distance > base_distance then
        return 0
    end
    
    local maximum_speed =  7 - math.min(speed / 5, 5)
    local maximum_dot = math.clamp(dot, -1, 1) * maximum_speed
    
    spam_accuracy = maximum_spam_distance - maximum_dot
    
    return spam_accuracy
end

function System.auto_spam.start()
    if System.__properties.__connections.__auto_spam_connection then
        System.__properties.__connections.__auto_spam_connection:Disconnect()
    end
    
    System.__properties.__auto_spam_enabled = true
    
    local last_auto_spam = 0
    local last_target_check = 0
    local event = RunService.Heartbeat
    
    -- Cache de funções e serviços para performance
    local get_ball = System.ball.get
    local get_closest = System.player.get_closest
    local parry_keypress = System.parry.keypress
    local parry_execute = System.parry.execute
    local play_animation = System.animation.play_grab_parry
    
    System.__properties.__connections.__auto_spam_connection = event:Connect(function()
        local char = LocalPlayer.Character
        if not System.__properties.__auto_spam_enabled or not char or char.Parent ~= Alive then
            return
        end
        
        local now = tick()
        local threshold = 0.015
        if now - last_auto_spam < threshold then return end
        last_auto_spam = now
            
        local ball = get_ball()
        if not ball then return end
        
        local zoomies = ball:FindFirstChild('zoomies')
        if not zoomies then return end
        
        -- Otimização: Não busca o player mais próximo a cada frame, apenas a cada 0.1s
        if now - last_target_check > 0.1 then
            get_closest()
            last_target_check = now
            
            if System.__properties.__spam_target then
                local target = System.__properties.__spam_target
                if not target.Parent or not target:FindFirstChild("Humanoid") or target.Humanoid.Health <= 0 then
                    System.__properties.__spam_target = nil
                    System.__properties.__spam_target_time = 0
                end
            end
            
            if not System.__properties.__spam_target or (now - System.__properties.__spam_target_time > 1) then
                System.__properties.__spam_target = Closest_Entity
                System.__properties.__spam_target_time = now
            end
        end
        
        local ball_target = ball:GetAttribute('target')
        if not ball_target then return end
        
        local ball_properties = System.auto_spam:get_ball_properties()
        local entity_properties = System.auto_spam:get_entity_properties()
        
        if ball_properties and entity_properties then
            local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
            local ping_threshold = math.clamp(ping / 5, 1, 16)
            
            local spam_accuracy = System.auto_spam.spam_service({
                Ball_Properties = ball_properties,
                Entity_Properties = entity_properties,
                Ping = ping_threshold
            })
            
            if spam_accuracy > 0 then
                local root = char.PrimaryPart
                if not root then return end
                
                local target_entity = Closest_Entity
                if not target_entity or not target_entity.PrimaryPart then return end
                
                local target_pos = target_entity.PrimaryPart.Position
                local target_dist = (root.Position - target_pos).Magnitude
                
                local ball_pos = ball.Position
                local dist_to_ball = (root.Position - ball_pos).Magnitude
                
                local shouldSpam = false
                local spam_target = System.__properties.__spam_target
                if spam_target then
                    if ball_target == spam_target.Name or ball_target == LocalPlayer.Name then
                        shouldSpam = true
                    end
                end
                
                if shouldSpam and not char:GetAttribute('Pulsed') then
                    if target_dist <= spam_accuracy and dist_to_ball <= spam_accuracy then
                        local multiplier = System.__properties.__auto_spam_distance_multiplier or 1.0
                        local max_allowed_dist = 35 * multiplier
                        
                        local is_target = (ball_target == LocalPlayer.Name)
                        local final_max_dist = is_target and max_allowed_dist or (max_allowed_dist * 0.8)
                        
                        if target_dist <= final_max_dist and dist_to_ball <= final_max_dist then
                            if System.__properties.__parries > System.__properties.__spam_threshold then
                                if getgenv().AutoSpamMode == "Keypress" then
                                    parry_keypress()
                                else
                                    parry_execute()
                                    if getgenv().AutoSpamAnimationFix then
                                        play_animation()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

System.autoparry = {}

function System.autoparry.start()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
    end
    
    System.__properties.__connections.__autoparry = RunService.PreSimulation:Connect(function()
        if not System.__properties.__autoparry_enabled or not LocalPlayer.Character or 
           not LocalPlayer.Character.PrimaryPart then
            return
        end
        
        local balls = System.ball.get_all()
        local one_ball = System.ball.get()
        
        local training_ball = nil
        if workspace:FindFirstChild("TrainingBalls") then
            for _, Instance in pairs(workspace.TrainingBalls:GetChildren()) do
                if Instance:GetAttribute("realBall") then
                    training_ball = Instance
                    break
                end
            end
        end

        for _, ball in pairs(balls) do
            if System.__triggerbot.__enabled then return end
            if getgenv().BallVelocityAbove800 then return end
            if not ball then continue end
            
            local zoomies = ball:FindFirstChild('zoomies')
            if not zoomies then continue end
            
            ball:GetAttributeChangedSignal('target'):Once(function()
                System.__properties.__parried = false
            end)
            
            if System.__properties.__parried then continue end
            
            local ball_target = ball:GetAttribute('target')
            local velocity = zoomies.VectorVelocity
            local distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
            
            local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 10
            local ping_threshold = math.clamp(ping / 10, 5, 17)
            local speed = velocity.Magnitude
            
            local capped_speed_diff = math.min(math.max(speed - 9.5, 0), 650)
            local speed_divisor = (2.4 + capped_speed_diff * 0.002) * System.__properties.__divisor_multiplier
            local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)
            
            local curved = System.detection.is_curved()
            
            if ball:FindFirstChild('AeroDynamicSlashVFX') then
                ball.AeroDynamicSlashVFX:Destroy()
                System.__properties.__tornado_time = tick()
            end
            
            if Runtime:FindFirstChild('Tornado') then
                if (tick() - System.__properties.__tornado_time) < 
                   (Runtime.Tornado:GetAttribute('TornadoTime') or 1) + 0.314159 then
                    continue
                end
            end
            
            if one_ball and one_ball:GetAttribute('target') == LocalPlayer.Name and curved then
                continue
            end
            
            if ball:FindFirstChild('ComboCounter') then continue end
            
            if LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then continue end
            
            if System.__config.__detections.__infinity and System.__properties.__infinity_active then continue end
            if System.__config.__detections.__deathslash and System.__properties.__deathslash_active then continue end
            if System.__config.__detections.__timehole and System.__properties.__timehole_active then continue end
            if System.__config.__detections.__slashesoffury and System.__properties.__slashesoffury_active then continue end
            
            if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
                -- MODIFICAÇÃO: REMOVIDA A VERIFICAÇÃO DO BLOCK BUTTON
                -- Apenas executa o bypass normalmente
                
                if getgenv().AutoAbility then
                    local AbilityCD = LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
                    if AbilityCD and AbilityCD.Offset.Y == 0.5 then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Abilities") then
                            local abilities = LocalPlayer.Character.Abilities
                            if (abilities:FindFirstChild("Raging Deflection") and abilities["Raging Deflection"].Enabled) or
                               (abilities:FindFirstChild("Rapture") and abilities["Rapture"].Enabled) or
                               (abilities:FindFirstChild("Calming Deflection") and abilities["Calming Deflection"].Enabled) or
                               (abilities:FindFirstChild("Aerodynamic Slash") and abilities["Aerodynamic Slash"].Enabled) or
                               (abilities:FindFirstChild("Fracture") and abilities["Fracture"].Enabled) or
                               (abilities:FindFirstChild("Death Slash") and abilities["Death Slash"].Enabled) then
                                System.__properties.__parried = true
                                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                                task.wait(2.432)
                                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
                                continue
                            end
                        end
                    end
                end
            end
            
            if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
                if getgenv().AutoParryMode == "Keypress" then
                    System.parry.keypress()
                else
                    System.parry.execute_action()
                end
                System.__properties.__parried = true
            end
            
            local last_parrys = tick()
            repeat
                RunService.Stepped:Wait()
            until (tick() - last_parrys) >= 1 or not System.__properties.__parried
            System.__properties.__parried = false
        end

        if training_ball then
            local zoomies = training_ball:FindFirstChild('zoomies')
            if zoomies then
                training_ball:GetAttributeChangedSignal('target'):Once(function()
                    System.__properties.__training_parried = false
                end)
                
                if not System.__properties.__training_parried then
                    local ball_target = training_ball:GetAttribute('target')
                    local velocity = zoomies.VectorVelocity
                    local distance = LocalPlayer:DistanceFromCharacter(training_ball.Position)
                    local speed = velocity.Magnitude
                    
                    local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 10
                    local ping_threshold = math.clamp(ping / 10, 5, 17)
                    
                    local capped_speed_diff = math.min(math.max(speed - 9.5, 0), 650)
                    local speed_divisor = (2.4 + capped_speed_diff * 0.002) * System.__properties.__divisor_multiplier
                    local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)
                    
                    if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
                        if getgenv().AutoParryMode == "Keypress" then
                            System.parry.keypress()
                        else
                            System.parry.execute_action()
                        end
                        System.__properties.__training_parried = true
                        
                        local last_parrys = tick()
                        repeat
                            RunService.Stepped:Wait()
                        until (tick() - last_parrys) >= 1 or not System.__properties.__training_parried
                        System.__properties.__training_parried = false
                    end
                end
            end
        end
    end)
end

function System.autoparry.stop()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
        System.__properties.__connections.__autoparry = nil
    end
end

local function create_mobile_button(name, position_y, color)
    local gui = Instance.new('ScreenGui')
    gui.Name = 'angeli' .. name .. 'Mobile'
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local button = Instance.new('TextButton')
    button.Size = UDim2.new(0, 140, 0, 50)
    button.Position = UDim2.new(0.5, -70, position_y, 0)
    button.BackgroundTransparency = 1
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.Draggable = true
    button.AutoButtonColor = false
    button.ZIndex = 2
    
    local bg = Instance.new('Frame')
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bg.Parent = button
    
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = bg
    
    local stroke = Instance.new('UIStroke')
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = bg
    
    local text = Instance.new('TextLabel')
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.ZIndex = 3
    text.Parent = button
    
    button.Parent = gui
    gui.Parent = CoreGui
    
    return {gui = gui, button = button, text = text, bg = bg}
end

local function destroy_mobile_gui(gui_data)
    if gui_data and gui_data.gui then
        gui_data.gui:Destroy()
    end
end

local swordInstancesInstance = ReplicatedStorage:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
local swordInstances = require(swordInstancesInstance)

local swordsController

local function findSwordsController()
    while task.wait() and (not swordsController) do
        for i,v in getconnections(ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent) do
            if v.Function and islclosure(v.Function) then
                local upvalues = getupvalues(v.Function)
                if #upvalues == 1 and type(upvalues[1]) == "table" then
                    swordsController = upvalues[1]
                    break
                end
            end
        end
    end
end

task.spawn(findSwordsController)

function getSlashName(swordName)
    local slashName = swordInstances:GetSword(swordName)
    return (slashName and slashName.SlashName) or "SlashEffect"
end

function setSword()
    if not getgenv().skinChangerEnabled then return end
    
    if setupvalue and rawget then
        pcall(function()
            setupvalue(rawget(swordInstances,"EquipSwordTo"),3,false)
        end)
    end
    
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

local playParryFunc
local parrySuccessAllConnection

local function findParryConnections()
    while task.wait() and not parrySuccessAllConnection do
        for i,v in getconnections(ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent) do
            if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
                parrySuccessAllConnection = v
                playParryFunc = v.Function
                pcall(function() v:Disable() end)
            end
        end
    end
end

task.spawn(findParryConnections)

local parrySuccessClientConnection
local function findClientConnection()
    while task.wait() and not parrySuccessClientConnection do
        for i,v in getconnections(ReplicatedStorage.Remotes.ParrySuccessClient.Event) do
            if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
                parrySuccessClientConnection = v
                pcall(function() v:Disable() end)
            end
        end
    end
end

task.spawn(findClientConnection)

getgenv().slashName = "SlashEffect"

local lastOtherParryTimestamp = 0
local clashConnections = {}

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
    if not playParryFunc then return end
    
    local args = {...}
    if tostring(args[4]) ~= LocalPlayer.Name then
        lastOtherParryTimestamp = tick()
    elseif getgenv().skinChangerEnabled and getgenv().changeSwordFX and getgenv().swordFX and getgenv().swordFX ~= "" then
        if getgenv().slashName then
            args[1] = getgenv().slashName
        end
        args[3] = getgenv().swordFX
    end
    return playParryFunc(unpack(args))
end)

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
            if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
                setSword()
            end
            if char and (not char:FindFirstChild(getgenv().swordModel)) then
                setSword()
            end
            for _,v in (char and char:GetChildren()) or {} do
                if v:IsA("Model") and v.Name ~= getgenv().swordModel then
                    pcall(function() v:Destroy() end)
                end
                task.wait()
            end
        end
    end
end)

-- Configurações iniciais do getgenv()
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
getgenv().Walkablesemiimortal = false
getgenv().WalkablesemiimortalNotify = false
getgenv().skinChangerEnabled = false
getgenv().changeSwordModel = true
getgenv().changeSwordAnimation = true
getgenv().changeSwordFX = true
getgenv().swordModel = ""
getgenv().swordAnimations = ""
getgenv().swordFX = ""
getgenv().AutoVote = false

-- AUTO PARRY SECTION (Rage Tab)
local autoparry_section = Tabs.Rage:AddSection("Auto Parry", "shield")

-- Toggle principal do Auto Parry
local AutoParryToggle = autoparry_section:AddToggle("AutoParryToggle", {
    Title = "Auto Parry",
    Description = "Automatically parries ball",
    Default = false,
    Callback = function(value)
        System.__properties.__autoparry_enabled = value
        if value then
            System.autoparry.start()
            if getgenv().AutoParryNotify then
                Fluent:Notify({
                    Title = "Auto Parry",
                    Content = "ON",
                    Duration = 2
                })
            end
        else
            System.autoparry.stop()
            if getgenv().AutoParryNotify then
                Fluent:Notify({
                    Title = "Auto Parry",
                    Content = "OFF",
                    Duration = 2
                })
            end
        end
    end
})

-- Dropdown de modo de parry
autoparry_section:AddDropdown("ParryMode", {
    Title = "Parry Mode",
    Description = "Select parry method",
    Values = {"Remote", "Keypress"},
    Default = "Remote",
    Multi = false,
    Callback = function(value)
        getgenv().AutoParryMode = value
    end
})

autoparry_section:AddDropdown("Mode curve", {
    Title = "Mode curve",
    Description = "Select curve type",
    Values = System.__config.__curve_names,
    Default = "Camera",
    Multi = false,
    Callback = function(value)
        for i, name in ipairs(System.__config.__curve_names) do
            if name == value then
                System.__properties.__curve_mode = i
                break
            end
        end
    end
})

-- Slider de precisão
autoparry_section:AddSlider("ParryAccuracy", {
    Title = "Parry Accuracy",
    Description = "Adjust parry accuracy",
    Default = 50,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(value)
        System.__properties.__accuracy = value
        update_divisor()
    end
})

-- Toggle de Randomize Accuracy
autoparry_section:AddToggle("RandomizeAccuracy", {
    Title = "Randomize Accuracy (Ping Based)",
    Description = "Randomizes accuracy based on ping",
    Default = false,
    Callback = function(value)
        System.__properties.__randomized_accuracy_enabled = value
        if value then
            update_randomized_accuracy()
        end
    end
})

-- Toggle de animação
autoparry_section:AddToggle("PlayAnimation", {
    Title = "Play Animation",
    Description = "Play grab parry animation",
    Default = false,
    Callback = function(value)
        System.__properties.__play_animation = value
    end
})

-- Toggle de proteção de cooldown
autoparry_section:AddToggle("CooldownProtection", {
    Title = "Cooldown Protection",
    Description = "Protect from cooldown",
    Default = false,
    Callback = function(value)
        getgenv().CooldownProtection = value
    end
})

-- Toggle de habilidade automática
autoparry_section:AddToggle("AutoAbility", {
    Title = "Auto Ability",
    Description = "Use abilities automatically",
    Default = false,
    Callback = function(value)
        getgenv().AutoAbility = value
    end
})

-- Toggle de notificação
autoparry_section:AddToggle("AutoParryNotify", {
    Title = "Notify",
    Description = "Show notifications",
    Default = false,
    Callback = function(value)
        getgenv().AutoParryNotify = value
    end
})

-- TRIGGERBOT SECTION
local triggerbot_section = Tabs.Rage:AddSection("Triggerbot", "target")

triggerbot_section:AddToggle("TriggerbotToggle", {
    Title = "Triggerbot",
    Description = "Parries instantly if targeted",
    Default = false,
    Callback = function(value)
        if System.__properties.__is_mobile then
            if value then
                if not System.__properties.__mobile_guis.triggerbot then
                    local triggerbot_mobile = create_mobile_button('Trigger', 0.7, Color3.fromRGB(255, 100, 0))
                    System.__properties.__mobile_guis.triggerbot = triggerbot_mobile
                    
                    local touch_start = 0
                    local was_dragged = false
                    
                    triggerbot_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            touch_start = tick()
                            was_dragged = false
                        end
                    end)
                    
                    triggerbot_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            if (tick() - touch_start) > 0.1 then
                                was_dragged = true
                            end
                        end
                    end)
                    
                    triggerbot_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and not was_dragged then
                            System.__properties.__triggerbot_enabled = not System.__properties.__triggerbot_enabled
                            System.triggerbot.enable(System.__properties.__triggerbot_enabled)
                            
                            if System.__properties.__triggerbot_enabled then
                                triggerbot_mobile.text.Text = "ON"
                                triggerbot_mobile.text.TextColor3 = Color3.fromRGB(255, 100, 0)
                            else
                                triggerbot_mobile.text.Text = "Trigger"
                                triggerbot_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            
                            if getgenv().TriggerbotNotify then
                                Fluent:Notify({
                                    Title = "Triggerbot",
                                    Content = System.__properties.__triggerbot_enabled and "ON" or "OFF",
                                    Duration = 2
                                })
                            end
                        end
                    end)
                end
            else
                System.__properties.__triggerbot_enabled = false
                System.triggerbot.enable(false)
                destroy_mobile_gui(System.__properties.__mobile_guis.triggerbot)
                System.__properties.__mobile_guis.triggerbot = nil
            end
        else
            System.__properties.__triggerbot_enabled = value
            System.triggerbot.enable(value)
            
            if getgenv().TriggerbotNotify then
                Fluent:Notify({
                    Title = "Triggerbot",
                    Content = value and "ON" or "OFF",
                    Duration = 2
                })
            end
        end
    end
})

triggerbot_section:AddToggle("TriggerbotNotify", {
    Title = "Notify",
    Description = "Show notifications for Triggerbot",
    Default = false,
    Callback = function(value)
        getgenv().TriggerbotNotify = value
    end
})

-- AUTOCURVE HOTKEY SECTION
local autocurve_section = Tabs.Rage:AddSection("AutoCurve Hotkey", "keyboard")

autocurve_section:AddToggle("AutoCurveHotkey", {
    Title = "AutoCurve Hotkey (Mobile)",
    Description = "Press 1-6 to change curve (Mobile version)",
    Default = false,
    Callback = function(state)
        getgenv().AutoCurveHotkeyEnabled = state
        
        if System.__properties.__is_mobile then
            if state then
                -- Implementar seletor de curva móvel se necessário
            else
                -- Remover seletor de curva móvel se necessário
            end
        end
    end
})

autocurve_section:AddToggle("AutoCurveHotkeyNotify", {
    Title = "Notify",
    Description = "Show notifications for curve changes",
    Default = false,
    Callback = function(value)
        getgenv().AutoCurveHotkeyNotify = value
    end
})

-- DETECTION TAB
local infinity_section = Tabs.Detection:AddSection("Infinity Detection", "infinity")
infinity_section:AddToggle("InfinityDetection", {
    Title = "Infinity Detection",
    Description = "Detect infinity balls",
    Default = false,
    Callback = function(value)
        System.__config.__detections.__infinity = value
    end
})

infinity_section:AddToggle("InfinityNotify", {
    Title = "Notify",
    Description = "Show notifications for infinity detection",
    Default = false,
    Callback = function(value)
        getgenv().InfinityNotify = value
    end
})

local deathslash_section = Tabs.Detection:AddSection("Death Slash Detection", "skull")
deathslash_section:AddToggle("DeathSlashDetection", {
    Title = "Death Slash Detection",
    Description = "Detect death slash",
    Default = false,
    Callback = function(value)
        System.__config.__detections.__deathslash = value
    end
})

local timehole_section = Tabs.Detection:AddSection("Time Hole Detection", "clock")
timehole_section:AddToggle("TimeHoleDetection", {
    Title = "Time Hole Detection",
    Description = "Detect time hole",
    Default = false,
    Callback = function(value)
        System.__config.__detections.__timehole = value
    end
})

local slashes_section = Tabs.Detection:AddSection("Slashes Of Fury Detection", "swords")
slashes_section:AddToggle("SlashesOfFuryDetection", {
    Title = "Slashes Of Fury Detection",
    Description = "Detect slashes of fury",
    Default = false,
    Callback = function(value)
        System.__config.__detections.__slashesoffury = value
    end
})

slashes_section:AddSlider("ParryDelay", {
    Title = "Parry Delay",
    Description = "Delay between parries in slashes of fury",
    Default = 0.05,
    Min = 0.05,
    Max = 0.250,
    Rounding = 2,
    Callback = function(value)
        parryDelay = value
    end
})

slashes_section:AddSlider("MaxParryCount", {
    Title = "Max Parry Count",
    Description = "Maximum parries in slashes of fury",
    Default = 36,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(value)
        maxParryCount = value
    end
})

local phantom_section = Tabs.Detection:AddSection("Anti-Phantom [BETA]", "ghost")
phantom_section:AddToggle("AntiPhantom", {
    Title = "Anti-Phantom [BETA]",
    Description = "Anti-phantom detection",
    Default = false,
    Callback = function(value)
        System.__config.__detections.__phantom = value
    end
})

local manual_spam_section = Tabs.Spam:AddSection("Manual Spam", "zap")

manual_spam_section:AddToggle("ManualSpamToggle", {
    Title = "Manual Spam",
    Description = "High-frequency parry spam",
    Default = false,
    Callback = function(state)
        if System.__properties.__is_mobile then
            if state then
                if not System.__properties.__mobile_guis.manual_spam then
                    local manual_spam_mobile = create_mobile_button('Spam', 0.8, Color3.fromRGB(255, 255, 255))
                    System.__properties.__mobile_guis.manual_spam = manual_spam_mobile
                    
                    local manual_touch_start = 0
                    local manual_was_dragged = false
                    
                    manual_spam_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            manual_touch_start = tick()
                            manual_was_dragged = false
                        end
                    end)
                    
                    manual_spam_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            if (tick() - manual_touch_start) > 0.1 then
                                manual_was_dragged = true
                            end
                        end
                    end)
                    
                    manual_spam_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and not manual_was_dragged then
                            System.__properties.__manual_spam_enabled = not System.__properties.__manual_spam_enabled
                            
                            if System.__properties.__manual_spam_enabled then
                                System.manual_spam.start()
                                manual_spam_mobile.text.Text = "ON"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(0, 255, 100)
                            else
                                System.manual_spam.stop()
                                manual_spam_mobile.text.Text = "Spam"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            
                            if getgenv().ManualSpamNotify then
                                Fluent:Notify({
                                    Title = "Manual Spam",
                                    Content = System.__properties.__manual_spam_enabled and "ON" or "OFF",
                                    Duration = 2
                                })
                            end
                        end
                    end)
                end
            else
                System.__properties.__manual_spam_enabled = false
                System.manual_spam.stop()
                destroy_mobile_gui(System.__properties.__mobile_guis.manual_spam)
                System.__properties.__mobile_guis.manual_spam = nil
            end
        else
            System.__properties.__manual_spam_enabled = state
            if state then
                System.manual_spam.start()
                if getgenv().ManualSpamNotify then
                    Fluent:Notify({
                        Title = "Manual Spam",
                        Content = "ON",
                        Duration = 2
                    })
                end
            else
                System.manual_spam.stop()
                if getgenv().ManualSpamNotify then
                    Fluent:Notify({
                        Title = "Manual Spam",
                        Content = "OFF",
                        Duration = 2
                    })
                end
            end
        end
    end
})

manual_spam_section:AddToggle("ManualSpamNotify", {
    Title = "Notify",
    Description = "Show notifications for manual spam",
    Default = false,
    Callback = function(value)
        getgenv().ManualSpamNotify = value
    end
})

manual_spam_section:AddDropdown("ManualSpamMode", {
    Title = "Mode",
    Description = "Select spam method",
    Values = {"Remote", "Keypress"},
    Default = "Remote",
    Multi = false,
    Callback = function(Value)
        getgenv().ManualSpamMode = Value
    end
})

manual_spam_section:AddToggle("ManualSpamAnimationFix", {
    Title = "Animation Fix",
    Description = "Fix animation during spam",
    Default = false,
    Callback = function(value)
        getgenv().ManualSpamAnimationFix = value
    end
})

local auto_spam_section = Tabs.Spam:AddSection("Auto Spam", "zap")

auto_spam_section:AddToggle("AutoSpamToggle", {
    Title = "Auto Spam",
    Description = "Automatically spam parries ball",
    Default = false,
    Callback = function(value)
        System.__properties.__auto_spam_enabled = value
        if value then
            System.auto_spam.start()
            if getgenv().AutoSpamNotify then
                Fluent:Notify({
                    Title = "Auto Spam",
                    Content = "ON",
                    Duration = 2
                })
            end
        else
            System.auto_spam.stop()
            if getgenv().AutoSpamNotify then
                Fluent:Notify({
                    Title = "Auto Spam",
                    Content = "OFF",
                    Duration = 2
                })
            end
        end
    end
})

auto_spam_section:AddToggle("AutoSpamNotify", {
    Title = "Notify",
    Description = "Show notifications for auto spam",
    Default = false,
    Callback = function(value)
        getgenv().AutoSpamNotify = value
    end
})

auto_spam_section:AddDropdown("AutoSpamMode", {
    Title = "Mode",
    Description = "Select spam method",
    Values = {"Remote", "Keypress"},
    Default = "Remote",
    Multi = false,
    Callback = function(Value)
        getgenv().AutoSpamMode = Value
    end
})

auto_spam_section:AddToggle("AutoSpamAnimationFix", {
    Title = "Animation Fix",
    Description = "Fix animation during auto spam",
    Default = false,
    Callback = function(value)
        getgenv().AutoSpamAnimationFix = value
    end
})

auto_spam_section:AddSlider("ParryThreshold", {
    Title = "Parry Threshold",
    Description = "Threshold for auto spam",
    Default = 2.5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(value)
        System.__properties.__spam_threshold = value
    end
})

auto_spam_section:AddSlider("DistanceMultiplier", {
    Title = "Distance Multiplier",
    Description = "Distance multiplier for auto spam",
    Default = 0.3,
    Min = 0.3,
    Max = 3.0,
    Rounding = 1,
    Callback = function(value)
        System.__properties.__auto_spam_distance_multiplier = value
    end
})

-- PLAYER TAB
local avatar_section = Tabs.Player:AddSection("Avatar Changer", "user")

local __flags = {}
local __players = cloneref(game:GetService('Players'))
local __localplayer = __players.LocalPlayer

local function __apparence(__name)
    local s, e = pcall(function()
        local __id = __players:GetUserIdFromNameAsync(__name)
        return __players:GetHumanoidDescriptionFromUserId(__id)
    end)

    if not s then
        return nil
    end

    return e
end

local function __set(__name, __char)
    if not __name or __name == '' then
        return
    end
    
    local __hum = __char and __char:WaitForChild('Humanoid', 5)

    if not __hum then
        return
    end

    local __desc = __apparence(__name)
    
    if not __desc then
        warn("Failed to get appearance for: " .. tostring(__name))
        return
    end

    __localplayer:ClearCharacterAppearance()
    __hum:ApplyDescriptionClientServer(__desc)
end

avatar_section:AddToggle("AvatarChanger", {
    Title = "Avatar Changer",
    Description = "Change your avatar to another player",
    Default = false,
    Callback = function(val)
        __flags['Skin Changer'] = val

        if val then
            local __char = __localplayer.Character

            if __char and __flags['name'] then
                __set(__flags['name'], __char)
            end

            __flags['loop'] = __localplayer.CharacterAdded:Connect(function(char)
                task.wait(.75)
                if __flags['name'] then
                    __set(__flags['name'], char)
                end
            end)
        else
            if __flags['loop'] then
                __flags['loop']:Disconnect()
                __flags['loop'] = nil

                local __char = __localplayer.Character

                if __char then
                    __set(__localplayer.Name, __char)
                end
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
            if __char then
                __set(val, __char)
            end
        end
    end
})

-- FOV SECTION
local fov_section = Tabs.Player:AddSection("FOV", "maximize")

fov_section:AddToggle("FOV", {
    Title = "FOV",
    Description = "Changes Camera POV",
    Default = false,
    Callback = function(value)
        getgenv().CameraEnabled = value
        local Camera = workspace.CurrentCamera
    
        if value then
            getgenv().CameraFOV = getgenv().CameraFOV or 70
            Camera.FieldOfView = getgenv().CameraFOV
                
            if not getgenv().FOVLoop then
                getgenv().FOVLoop = RunService.RenderStepped:Connect(function()
                    if getgenv().CameraEnabled then
                        Camera.FieldOfView = getgenv().CameraFOV
                    end
                end)
            end
        else
            Camera.FieldOfView = 70
                
            if getgenv().FOVLoop then
                getgenv().FOVLoop:Disconnect()
                getgenv().FOVLoop = nil
            end
        end
    end
})

fov_section:AddSlider("CameraFOV", {
    Title = "Camera FOV",
    Description = "Adjust camera field of view",
    Default = 70,
    Min = 50,
    Max = 120,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CameraFOV = Value
        if getgenv().CameraEnabled then
            workspace.CurrentCamera.FieldOfView = Value
        end
    end
})

-- CHARACTER MODIFIER SECTION
local character_section = Tabs.Player:AddSection("Character", "user")

character_section:AddToggle("CharacterModifier", {
    Title = "Character Modifier",
    Description = "Changes various character properties",
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
                        
                        if getgenv().WalkspeedCheckboxEnabled then
                            humanoid.WalkSpeed = getgenv().CustomWalkSpeed or 36
                        end
                        
                        if getgenv().JumpPowerCheckboxEnabled then
                            if humanoid.UseJumpPower then
                                humanoid.JumpPower = getgenv().CustomJumpPower or 50
                            else
                                humanoid.JumpHeight = getgenv().CustomJumpHeight or 7.2
                            end
                        end
                        
                        if getgenv().HipHeightCheckboxEnabled then
                            humanoid.HipHeight = getgenv().CustomHipHeight or 0
                        end

                        if getgenv().SpinbotCheckboxEnabled and root then
                            humanoid.AutoRotate = false
                            getgenv().spinAngle = (getgenv().spinAngle + (getgenv().CustomSpinSpeed or 5)) % 360
                            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(getgenv().spinAngle), 0)
                        else
                            if getgenv().OriginalValues.AutoRotate ~= nil then
                                humanoid.AutoRotate = getgenv().OriginalValues.AutoRotate
                            end
                        end
                    end
                    
                    if getgenv().GravityCheckboxEnabled and getgenv().CustomGravity then
                        workspace.Gravity = getgenv().CustomGravity
                    end
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
                        if humanoid.UseJumpPower then
                            humanoid.JumpPower = getgenv().OriginalValues.JumpPower or 50
                        else
                            humanoid.JumpHeight = getgenv().OriginalValues.JumpHeight or 7.2
                        end
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
    Description = "Enable infinite jumping",
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
    Description = "Enable spinbot",
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
    Description = "Spin rotation speed",
    Default = 5,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CustomSpinSpeed = Value
    end
})

character_section:AddToggle("WalkSpeed", {
    Title = "Walk Speed",
    Description = "Enable custom walk speed",
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
    Description = "Custom walk speed value",
    Default = 36,
    Min = 16,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CustomWalkSpeed = Value
        
        if getgenv().CharacterModifierEnabled and getgenv().WalkspeedCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = Value
            end
        end
    end
})

character_section:AddToggle("JumpPower", {
    Title = "Jump Power",
    Description = "Enable custom jump power",
    Default = false,
    Callback = function(value)
        getgenv().JumpPowerCheckboxEnabled = value
        
        if not value and getgenv().CharacterModifierEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") and getgenv().OriginalValues then
                local humanoid = char.Humanoid
                if humanoid.UseJumpPower then
                    humanoid.JumpPower = getgenv().OriginalValues.JumpPower or 50
                else
                    humanoid.JumpHeight = getgenv().OriginalValues.JumpHeight or 7.2
                end
            end
        end
    end
})

character_section:AddSlider("JumpPowerValue", {
    Title = "Jump Power Value",
    Description = "Custom jump power value",
    Default = 50,
    Min = 50,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CustomJumpPower = Value
        getgenv().CustomJumpHeight = Value * 0.144
        
        if getgenv().CharacterModifierEnabled and getgenv().JumpPowerCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                local humanoid = char.Humanoid
                if humanoid.UseJumpPower then
                    humanoid.JumpPower = Value
                else
                    humanoid.JumpHeight = Value * 0.144
                end
            end
        end
    end
})

character_section:AddToggle("Gravity", {
    Title = "Gravity",
    Description = "Enable custom gravity",
    Default = false,
    Callback = function(value)
        getgenv().GravityCheckboxEnabled = value
        
        if not value and getgenv().CharacterModifierEnabled then
            workspace.Gravity = 196.2
        end
    end
})

character_section:AddSlider("GravityValue", {
    Title = "Gravity Value",
    Description = "Custom gravity value",
    Default = 196.2,
    Min = 0,
    Max = 400.0,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CustomGravity = Value
        
        if getgenv().CharacterModifierEnabled and getgenv().GravityCheckboxEnabled then
            workspace.Gravity = Value
        end
    end
})

character_section:AddToggle("HipHeight", {
    Title = "Hip Height",
    Description = "Enable custom hip height",
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
    Description = "Custom hip height value",
    Default = 0,
    Min = -5,
    Max = 20,
    Rounding = 1,
    Callback = function(Value)
        getgenv().CustomHipHeight = Value
        
        if getgenv().CharacterModifierEnabled and getgenv().HipHeightCheckboxEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.HipHeight = Value
            end
        end
    end
})

-- VISUALS TAB - Ability ESP
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
      
    __state = {  
        active = false,  
        players = {},  
        update_task = nil  
    }  
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
        local ability_name = player:GetAttribute("EquippedAbility")
        label.Text = ability_name and (player.DisplayName .. "  [" .. ability_name .. "]") or player.DisplayName
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

    if not ability_esp.__state.players[player] then
        ability_esp.__state.players[player] = {}
    end  

    ability_esp.__state.players[player].label = label  
    ability_esp.__state.players[player].billboard = billboard  
    ability_esp.__state.players[player].character = character  
end

function ability_esp.add_player(player)
    if player == LocalPlayer then return end

    player.CharacterAdded:Connect(function()
        ability_esp.setup_character(player)
    end)

    if player.Character then  
        task.spawn(function()
            ability_esp.setup_character(player)  
        end)
    end
end

function ability_esp.update_loop()
    while ability_esp.__state.active do  
        task.wait(ability_esp.__config.update_rate)

        for player, data in pairs(ability_esp.__state.players) do
            if player.Character and data.label then
                ability_esp.update_label(player, data.label)
            end
        end
    end  
end  

function ability_esp.start()
    if ability_esp.__state.active then return end

    ability_esp.__state.active = true
    getgenv().AbilityESP = true

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ability_esp.add_player(player)
        end
    end

    ability_esp.__state.update_task = task.spawn(function()
        ability_esp.update_loop()
    end)
end

function ability_esp.stop()
    if not ability_esp.__state.active then return end

    ability_esp.__state.active = false
    getgenv().AbilityESP = false

    for _, v in pairs(ability_esp.__state.players) do  
        if v.billboard then v.billboard:Destroy() end  
    end

    ability_esp.__state.players = {}
end

function ability_esp.toggle(value)
    if value then
        ability_esp.start()
    else
        ability_esp.stop()
    end
end

local ability_esp_section = Tabs.Visuals:AddSection("Ability ESP", "eye")
ability_esp_section:AddToggle("AbilityESP", {  
    Title = "Ability ESP",  
    Description = "Displays Player Abilities",  
    Default = false,  
    Callback = function(value)
        ability_esp.toggle(value)

        Fluent:Notify({
            Title = "Ability ESP",
            Content = value and "Activated" or "Deactivated",
            Duration = 2
        })
    end
})

-- Ball Velocity
local ball_velocity_section = Tabs.Visuals:AddSection("Ball Velocity", "gauge")

function System.create_ball_velocity_gui()
    if System.__properties.__ball_velocity_gui then
        System.__properties.__ball_velocity_gui.gui:Destroy()
    end
    
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
    frame.Selectable = true
    frame.Draggable = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "⚡ Ball Velocity"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextStrokeTransparency = 0.8
    title.TextStrokeColor3 = Color3.new(0, 0, 0)
    title.Parent = frame
    
    local currentSpeedLabel = Instance.new("TextLabel")
    currentSpeedLabel.Name = "Text"
    currentSpeedLabel.Size = UDim2.new(1, -10, 0, 25)
    currentSpeedLabel.Position = UDim2.new(0, 5, 0, 25)
    currentSpeedLabel.BackgroundTransparency = 1
    currentSpeedLabel.Text = "Current: 0"
    currentSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    currentSpeedLabel.Font = Enum.Font.GothamBold
    currentSpeedLabel.TextSize = 16
    currentSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    currentSpeedLabel.TextStrokeTransparency = 0.7
    currentSpeedLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    currentSpeedLabel.Parent = frame
    
    local peakSpeedLabel = Instance.new("TextLabel")
    peakSpeedLabel.Name = "Text"
    peakSpeedLabel.Size = UDim2.new(1, -10, 0, 25)
    peakSpeedLabel.Position = UDim2.new(0, 5, 0, 50)
    peakSpeedLabel.BackgroundTransparency = 1
    peakSpeedLabel.Text = "Peak: 0"
    peakSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    peakSpeedLabel.Font = Enum.Font.GothamBold
    peakSpeedLabel.TextSize = 16
    peakSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    peakSpeedLabel.TextStrokeTransparency = 0.5
    peakSpeedLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    peakSpeedLabel.Parent = frame
    
    frame.Parent = gui
    gui.Parent = CoreGui
    
    System.__properties.__ball_velocity_gui = {
        gui = gui,
        frame = frame,
        currentSpeedLabel = currentSpeedLabel,
        peakSpeedLabel = peakSpeedLabel
    }
end

function System.update_ball_velocity()
    if not System.__properties.__ball_velocity_enabled or not System.__properties.__ball_velocity_gui then
        return
    end
    
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
    
    local velocity = zoomies.VectorVelocity
    local speed = velocity.Magnitude
    
    if speed > System.__properties.__peak_velocity then
        System.__properties.__peak_velocity = speed
    end
    
    System.__properties.__ball_velocity_gui.currentSpeedLabel.Text = string.format("Current: %.1f", speed)
    System.__properties.__ball_velocity_gui.peakSpeedLabel.Text = string.format("Peak: %.1f", System.__properties.__peak_velocity)
end

ball_velocity_section:AddToggle("BallVelocity", {
    Title = "Show Ball Velocity",
    Description = "Display ball velocity stats",
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
            
            Fluent:Notify({
                Title = "Ball Velocity",
                Content = "Activated",
                Duration = 2
            })
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
            
            Fluent:Notify({
                Title = "Ball Velocity",
                Content = "Deactivated",
                Duration = 2
            })
        end
    end
})

local skin_changer_section = Tabs.Misc:AddSection("Skin Changer", "sword")

skin_changer_section:AddToggle("SkinChanger", {
    Title = "Skin Changer",
    Description = "Change sword skins",
    Default = false,
    Callback = function(value)
        getgenv().skinChangerEnabled = value
        if value then
            getgenv().updateSword()
            Fluent:Notify({
                Title = "Skin Changer",
                Content = "Enabled",
                Duration = 2
            })
        else
            Fluent:Notify({
                Title = "Skin Changer",
                Content = "Disabled",
                Duration = 2
            })
        end
    end
})

skin_changer_section:AddToggle("ChangeSwordModel", {
    Title = "Change Sword Model",
    Description = "Change sword model",
    Default = true,
    Callback = function(value)
        getgenv().changeSwordModel = value
        if getgenv().skinChangerEnabled then
            getgenv().updateSword()
        end
    end
})

skin_changer_section:AddInput("SwordModelName", {
    Title = "Sword Model Name",
    Placeholder = "Enter Sword Model Name...",
    Default = "",
    Callback = function(text)
        getgenv().swordModel = text
        if getgenv().skinChangerEnabled and getgenv().changeSwordModel then
            getgenv().updateSword()
        end
    end
})

skin_changer_section:AddToggle("ChangeSwordAnimation", {
    Title = "Change Sword Animation",
    Description = "Change sword animations",
    Default = true,
    Callback = function(value)
        getgenv().changeSwordAnimation = value
        if getgenv().skinChangerEnabled then
            getgenv().updateSword()
        end
    end
})

skin_changer_section:AddInput("SwordAnimationName", {
    Title = "Sword Animation Name",
    Placeholder = "Enter Sword Animation Name...",
    Default = "",
    Callback = function(text)
        getgenv().swordAnimations = text
        if getgenv().skinChangerEnabled and getgenv().changeSwordAnimation then
            getgenv().updateSword()
        end
    end
})

skin_changer_section:AddToggle("ChangeSwordFX", {
    Title = "Change Sword FX",
    Description = "Change sword effects",
    Default = true,
    Callback = function(value)
        getgenv().changeSwordFX = value
        if getgenv().skinChangerEnabled then
            getgenv().updateSword()
        end
    end
})

skin_changer_section:AddInput("SwordFXName", {
    Title = "Sword FX Name",
    Placeholder = "Enter Sword FX Name...",
    Default = "",
    Callback = function(text)
        getgenv().swordFX = text
        if getgenv().skinChangerEnabled and getgenv().changeSwordFX then
            getgenv().updateSword()
        end
    end
})

-- NO RENDER SECTION
local no_render_section = Tabs.Misc:AddSection("No Render", "eye-off")

local Connections_Manager = {}

no_render_section:AddToggle("NoRender", {
    Title = "No Render",
    Description = "Disables rendering of effects",
    Default = false,
    Callback = function(state)
        local effectScripts = LocalPlayer.PlayerScripts:FindFirstChild("EffectScripts")
        if effectScripts then
            local clientFX = effectScripts:FindFirstChild("ClientFX")
            if clientFX then
                clientFX.Disabled = state
            end
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

-- BOTÃO MÓVEL PARA UI
local mobile_ui_button = nil

local function create_mobile_ui_button()
    if mobile_ui_button then
        mobile_ui_button.gui:Destroy()
    end
    
    local gui = Instance.new('ScreenGui')
    gui.Name = 'angeliMobileUIButton'
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 9999
    
    local button = Instance.new('TextButton')
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = UDim2.new(0.95, -25, 0.05, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BackgroundTransparency = 0.3
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Draggable = true
    button.AutoButtonColor = true
    button.ZIndex = 10000
    
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button
    
    local stroke = Instance.new('UIStroke')
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = button
    
    local text = Instance.new('TextLabel')
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "R"
    text.Font = Enum.Font.GothamBold
    text.TextSize = 24
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.ZIndex = 10001
    text.Parent = button
    
    button.MouseButton1Click:Connect(function()
        Window:Minimize(not Window.Minimized)
    end)
    
    button.Parent = gui
    gui.Parent = CoreGui
    
    mobile_ui_button = {gui = gui, button = button}
    return mobile_ui_button
end

-- Criar botão móvel se for mobile
if System.__properties.__is_mobile then
    task.spawn(function()
        task.wait(2)
        create_mobile_ui_button()
    end)
end

-- SETTINGS TAB
-- Configurar SaveManager e InterfaceManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignorar configurações de tema (gerenciadas separadamente)
SaveManager:IgnoreThemeSettings()

-- Definir pastas para salvar configurações
InterfaceManager:SetFolder("angeli")
SaveManager:SetFolder("angeli/configs")

-- Construir seções de Interface e Config na aba Settings
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

-- Carregar configuração automática se existir
SaveManager:LoadAutoloadConfig()

-- Notificação inicial
Fluent:Notify({
    Title = "angeli",
    Content = "Loaded successfully! (Dual Bypass System - Virtual Input First Parry)",
    Duration = 5
})

print("River loaded with Fluent UI and Dual Bypass System!")

end) -- Fim do task.spawn para carregamento assíncrono da UI
