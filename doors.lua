local workspaceService = game:GetService("Workspace")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local httpService = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local proximityPromptService = game:GetService("ProximityPromptService")
local lighting = game:GetService("Lighting")

if getgenv().ZeScriptLoaded then
  warn("Roshan Doors Page Hub is already running! Please destroy the existing instance first.")
  return
end

getgenv().ZeScriptLoaded = true
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
local window
local touchEnabled = userInputService.TouchEnabled
local v1 = "RoshanHub_LoadLog.txt"

local function f1(message)
  pcall(function()
    local v2 = ""

    if isfile and isfile(v1) then
      v2 = readfile(v1)
    end

    if writefile then
      writefile(v1, v2 .. message .. "\n")
    end
  end)

  warn(message)
end

local function f2(p1, p2)
  local ok, result = pcall(p1)

  if not ok then
    local message2 = "[RoshanHub Error - " .. (p2 or "Unknown") .. "]: " .. tostring(result)
    f1("[" .. os.date("%H:%M:%S") .. "] " .. message2)

    if window and window.Notify then
      window:Notify({ Text = message2, Duration = 5, Type = "Error" })
    else
      warn(message2)
    end
  end

  return ok
end

if not (syn and syn.request or http_request or request) then
  warn("Your executor doesn't support HTTP requests!")
end

local newContentTesting = loadstring(game:HttpGet("https://raw.githubusercontent.com/XasonYTB/XaLib/refs/heads/main/NewContentTesting"))()
local vector = Vector2.new(500, 400)
local vector2 = Vector2.new(700, 500)

window = newContentTesting:CreateWindow({
  Title = "🌹 Roshan Doors Page Hub",
  Size = userInputService.TouchEnabled and vector or vector2,
  MinSize = vector,
  MaxSize = Vector2.new(900, 700),
  Keybind = Enum.KeyCode.RightShift,
  Theme = "Purple",
})

local list = {}
local list2 = {}

local function f3(p3, p4)
  table.insert(list, p4)
  table.insert(list2, p3)
end

local flag = false
local value = "Unknown"
local v3
local v4 = "RoshanHubDoors_Settings.json"
local flag2 = false
local connect
local v5 = {}
local v6 = false
local v7 = false
local doorReachDistance = 25
local v8 = false
local speedValue = 16
local walkSpeed = 16
local v9 = false
local map = {}
local connect2
local v10 = false
local v11 = false
local v12 = false
local v13 = false
local v14 = false
local flag3 = false
local v15 = false
local v16 = false
local v17 = false
local v18 = false
local v19 = false
local v20 = false
local autoProxiInstant = true
local r
local list3 = {}
local v21 = 0
local v22
local map2 = {}
local v23 = false
local collisionClone
local customPhysicalProperties
local cameraType
local cameraSubject
local flag4 = true
local v24
local v25 = false
local map3 = {}
local flag5 = false
local mainCategory
local exploitsCategory
local floorCategory
local visualCategory
local settingsCategory
local essentialsTab
local protectionTab
local universalTab
local interactTab
local espTab
local displayTab
local f4
local f5
local v26
local v27
local v28
local v29
local v30
local v31
local parent
local v32
local v33
local v34
local v35
local v36
local v37
local v38
local f6
local f7
local f8
local v39
local v40
local create
local create2
local create3
local f9
local f10
local f11
local f12
local f13
local f14
local f15
local f16
local f17
local f18
local f19
local f20
local f21
local f22
local f23
local f24
local f25
local f26
local f27
local f28
local f29
local f30
local f31
local f32
local f33
local f34
local f35
local f36
local f37
local f38
local f39
local f40
local f41
local create4

f3("Hook check", function()
  flag = false
  local v41 = hookfunction or replaceclosure or hookmetamethod
  local v42

  if v41 then
    v42 = false

    local ok2, result2 = pcall(function()
      local v43
      v43 = v41(function() return 1 end, function(...) return v43(...) end)
      v42 = true
    end)

    if ok2 and v42 then
      flag = true
    else
      warn("[RoshanHub UNC] Hook test FAILED: " .. tostring(result2))
    end
  else
    warn("[RoshanHub UNC] No hook function available on this executor")
  end

  task.delay(1, function()
    if flag then
      window:Notify({
        Text = "✅ Hook support detected — all features available",
        Duration = 4,
        Type = "Success",
      })
    else
      window:Notify({
        Text = "⚠️ No hook support — Anti Heartbeat & Anti A-90 unavailable",
        Duration = 7,
        Type = "Warning",
      })
    end
  end)
end)

f3("Floor detection", function()
  value = "Unknown"

  function f5()
    f2(function()
      local gameData = replicatedStorage:FindFirstChild("GameData")

      if gameData then
        local floor = gameData:FindFirstChild("Floor")

        if floor then
          value = floor.Value
        end
      end

      if value == "Unknown" then
        if workspace:FindFirstChild("MinesData") then
          value = "Mines"
        elseif workspace:FindFirstChild("BackdoorData") then
          value = "Backdoor"
        elseif workspace:FindFirstChild("GardenData") then
          value = "Garden"
        elseif workspace:FindFirstChild("PartyData") then
          value = "Party"
        else
          value = "Hotel"
        end
      end
    end, "Floor Detection")

    return value
  end

  value = f5()
end)

f3("Categories & tabs", function()
  mainCategory = window:CreateCategory("Main", "⭐")
  exploitsCategory = window:CreateCategory("Exploits", "⚡")
  floorCategory = window:CreateCategory("Floor", "🏢")
  visualCategory = window:CreateCategory("Visual", "👁️")
  settingsCategory = window:CreateCategory("Settings", "⚙️")
  essentialsTab = mainCategory:CreateTab("Essentials", "🔥")
  protectionTab = mainCategory:CreateTab("Protection", "🛡️")
  universalTab = exploitsCategory:CreateTab("Universal", "🌍")
  interactTab = exploitsCategory:CreateTab("Interact", "🤝")
  espTab = visualCategory:CreateTab("ESP", "📍")
  displayTab = visualCategory:CreateTab("Display", "🎨")
end)

f3("Settings table", function()
  v3 = {
    spoofCrouch = false,
    antiEyes = false,
    disableScreech = false,
    disableSnare = false,
    objectBypass = false,
    noAccel = false,
    autoProxi = false,
    autoProxiInstant = true,
    autoProxiKey = "R",
    proximityReach = 0,
    doorReach = false,
    doorReachDistance = 25,
    antiSpeedBypass = false,
    speed = false,
    speedValue = 16,
    minesAnticheat = false,
    espDoor = false,
    espObjective = false,
    espEntity = false,
    entityNotifier = false,
    fullbright = false,
    fov = 70,
    theme = "Purple",
    autoLoad = false,
    godMode = false,
  }
end)

f3("Save/load functions", function()
  v4 = "RoshanHubDoors_Settings.json"

  function f21()
    local ok3, result3 = pcall(function()
      if writefile then
        writefile(v4, httpService:JSONEncode(v3))
      end
    end)

    if not ok3 then
      window:Notify({
        Text = "[Settings Save Error]: " .. tostring(result3),
        Duration = 5,
        Type = "Error",
      })
    end

    return ok3
  end

  function f22()
    local ok4, result4 = pcall(function()
      if isfile and isfile(v4) then
        return httpService:JSONDecode(readfile(v4))
      end

      return nil
    end)

    if ok4 and result4 then
      for key, value2 in pairs(result4) do
        if v3[key] ~= nil then
          v3[key] = value2
        end
      end

      return true
    end

    return false
  end
end)

local f42, f43, f44, f45, f46

f3("Helper vars", function()
  local v44 = {}

  function f43(enabled)
    f2(function()
      for _, value3 in pairs(workspaceService:GetDescendants()) do
        if value3:IsA("Light") or value3:IsA("PointLight") or value3:IsA("SpotLight")
          or value3:IsA("SurfaceLight") then
          value3.Enabled = enabled
        end
      end
    end, "Toggle Lights")
  end

  function f44(key2, anchored)
    f2(function()
      local findFirstChild = players:FindFirstChild(key2)

      if findFirstChild and findFirstChild.Character then
        local humanoidRootPart = findFirstChild.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
          humanoidRootPart.Anchored = anchored
          v44[key2] = anchored
        end
      end
    end, "Freeze Player")
  end

  function f45(p5)
    f2(function()
      local findFirstChild2 = players:FindFirstChild(p5)

      if findFirstChild2 and findFirstChild2.Character then
        currentCamera.CameraSubject = findFirstChild2.Character.Humanoid
        window:Notify({ Text = "Now spectating " .. p5, Duration = 3, Type = "Success" })
      else
        window:Notify({ Text = "Could not spectate " .. p5, Duration = 3, Type = "Error" })
      end
    end, "Spectate Player")
  end

  function f46()
    f2(function()
      if localPlayer.Character then
        currentCamera.CameraSubject = localPlayer.Character.Humanoid
        window:Notify({ Text = "Stopped spectating", Duration = 2, Type = "Success" })
      end
    end, "Stop Spectating")
  end

  function f42()
    local list4 = {}

    f2(function()
      for _, value4 in ipairs(players:GetPlayers()) do
        table.insert(list4, { name = value4.Name, userId = tostring(value4.UserId) })
      end
    end, "Get All Players")

    return list4
  end
end)

f3("GodMode functions", function()
  flag2 = false
  connect = nil
  v5 = {}

  function f13(instance)
    f2(function()
      local humanoid = instance:WaitForChild("Humanoid")
      local humanoidRootPart2 = instance:WaitForChild("HumanoidRootPart")
      local waitForChild = instance:WaitForChild("Collision", true)

      if not waitForChild then
        return
      end

      v5 = {
        HipHeight = humanoid.HipHeight,
        RootCanCollide = humanoidRootPart2.CanCollide,
        RootCollisionGroup = humanoidRootPart2.CollisionGroup,
        CollisionSize = waitForChild.Size,
        CollisionCanCollide = waitForChild.CanCollide,
        CollisionCanTouch = waitForChild.CanTouch,
        CollisionCanQuery = waitForChild.CanQuery,
        CollisionCollisionGroup = waitForChild.CollisionGroup,
      }
    end, "Save Original GodMode")
  end

  function f14(instance2)
    f2(function()
      local humanoid2 = instance2:FindFirstChild("Humanoid")
      local humanoidRootPart3 = instance2:FindFirstChild("HumanoidRootPart")
      local findFirstChild3 = instance2:FindFirstChild("Collision", true)

      if not (humanoid2 and humanoidRootPart3 and findFirstChild3) then
        return
      end

      humanoidRootPart3.CanCollide = false

      findFirstChild3.Size = Vector3.new(1, 0.1, 3)
      findFirstChild3.CanCollide = true
      findFirstChild3.CollisionGroup = "PlayerCrouching"

      humanoid2.HipHeight = 0
    end, "Apply GodMode")
  end

  function f8(instance3)
    f2(function()
      local humanoid3 = instance3:FindFirstChild("Humanoid")
      local humanoidRootPart4 = instance3:FindFirstChild("HumanoidRootPart")
      local findFirstChild4 = instance3:FindFirstChild("Collision", true)

      if not (humanoid3 and humanoidRootPart4 and findFirstChild4 and v5.HipHeight) then
        return
      end

      humanoid3.HipHeight = v5.HipHeight

      humanoidRootPart4.CanCollide = v5.RootCanCollide
      humanoidRootPart4.CollisionGroup = v5.RootCollisionGroup

      findFirstChild4.Size = v5.CollisionSize
      findFirstChild4.CanCollide = v5.CollisionCanCollide
      findFirstChild4.CanTouch = v5.CollisionCanTouch
      findFirstChild4.CanQuery = v5.CollisionCanQuery
      findFirstChild4.CollisionGroup = v5.CollisionCollisionGroup
    end, "Restore Original GodMode")
  end

  function f15(instance4)
    f2(function()
      local humanoidRootPart5 = instance4:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart5 then
        humanoidRootPart5.CFrame = humanoidRootPart5.CFrame + Vector3.new(0, 3, 0)
      end
    end, "Teleport Up")
  end

  function f16(p6)
    f2(function()
      if connect then
        connect:Disconnect()
      end

      connect = runService.Heartbeat:Connect(function()
        if flag2 then
          f14(p6)
        end
      end)
    end, "Start GodMode Loop")
  end

  function f17()
    f2(function()
      if connect then
        connect:Disconnect()
        connect = nil
      end
    end, "Stop GodMode Loop")
  end

  v6 = false

  function f18()
    f2(function()
      local character = localPlayer.Character

      if not character or flag2 then
        return
      end

      f13(character)
      flag2 = true
      f16(character)

      window:Notify({
        Text = "🛡️ GodMode Auto-Enabled (Entity nearby)",
        Duration = 2,
        Type = "Success",
      })
    end, "Enable GodMode")
  end

  function f19()
    f2(function()
      local character2 = localPlayer.Character

      if not character2 or not flag2 then
        return
      end

      flag2 = false
      f17()
      f8(character2)
      f15(character2)

      window:Notify({
        Text = "GodMode Auto-Disabled (Entities far)",
        Duration = 2,
        Type = "Warning",
      })
    end, "Disable GodMode")
  end

  function f20()
    if not v6 then
      return
    end

    f2(function()
      local character3 = localPlayer.Character

      if not character3 then
        return
      end

      local humanoidRootPart6 = character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart6 then
        return
      end

      local flag6 = false

      for _, value5 in ipairs({ "RushMoving", "AmbushMoving", "BackdoorRush" }) do
        local findFirstChild5 = workspace:FindFirstChild(value5)

        if findFirstChild5 then
          local basePart = findFirstChild5:FindFirstChildWhichIsA("BasePart")

          if basePart and (humanoidRootPart6.Position - basePart.Position).Magnitude <= 325 then
            flag6 = true
            break
          end
        end
      end

      if flag6 and not flag2 then
        f18()
      elseif not flag6 and flag2 then
        f19()
      end
    end, "Check Entity Distance")
  end

  localPlayer.CharacterAdded:Connect(function(character4)
    f2(function()
      if flag2 then
        task.wait(0.1)
        f13(character4)
        f16(character4)
      end
    end, "Character Added - GodMode")
  end)
end)

f3("UI - EssentialsTab", function()
  essentialsTab:Toggle("Auto GodMode", v3.godMode, function(p7)
    f2(function()
      v6 = p7
      v3.godMode = p7

      if p7 then
        v30 = task.spawn(function()
          while v6 do
            task.wait(0.1)
            f20()
          end
        end)
      else
        if v30 then
          task.cancel(v30)
          v30 = nil
        end

        if flag2 then
          f19()
        end
      end
    end, "Auto GodMode Toggle")
  end, "Auto-enable GodMode when entities are within 325 studs")
end)

f3("UI - DoorReach", function()
  v7 = false
  doorReachDistance = v3.doorReachDistance

  essentialsTab:Toggle("Door Reach", v3.doorReach, function(p8)
    f2(function()
      v7 = p8
      v3.doorReach = p8

      if p8 then
        v27 = task.spawn(function()
          while v7 do
            f2(function()
              local character5 = localPlayer and localPlayer.Character

              if not character5 then
                return
              end

              local humanoidRootPart7 = character5:FindFirstChild("HumanoidRootPart")

              if not humanoidRootPart7 then
                return
              end

              local currentRooms = workspace:FindFirstChild("CurrentRooms")

              if not currentRooms then
                return
              end

              local getChildren = currentRooms:GetChildren()

              table.sort(getChildren, function(p9, p10)
                return (tonumber(p9.Name) or 0) > (tonumber(p10.Name) or 0)
              end)

              for i = 1, math.min(3, #getChildren) do
                local instance5 = getChildren[i]

                if instance5 then
                  local door = instance5:FindFirstChild("Door")

                  if door then
                    local clientOpen = door:FindFirstChild("ClientOpen")

                    if clientOpen then
                      local basePart2 = door:IsA("BasePart") and door
                        or door:FindFirstChildWhichIsA("BasePart")

                      if basePart2 then
                        if (humanoidRootPart7.Position - basePart2.Position).Magnitude
                          <= doorReachDistance then
                          clientOpen:FireServer()
                        end
                      end
                    end
                  end
                end
              end
            end, "Door Reach Loop")

            task.wait(0.1)
          end
        end)
      elseif v27 then
        task.cancel(v27)
        v27 = nil
      end
    end, "Door Reach Toggle")
  end, "Open doors from further away")

  essentialsTab:Slider("Door Reach Distance", 10, 75, v3.doorReachDistance, function(doorReachDistance2)
    f2(function()
      doorReachDistance = doorReachDistance2
      v3.doorReachDistance = doorReachDistance2
    end, "Door Reach Distance Slider")
  end, "Maximum distance to open doors")
end)

f3("AntiSpeed setup", function()
  v39 = value == "Mines" and 75 or 250
  flag4 = true

  function f4()
    f2(function()
      local character6 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
      local collisionPart = character6:WaitForChild("CollisionPart")

      if collisionClone then
        collisionClone:Destroy()
        collisionClone = nil
      end

      collisionClone = collisionPart:Clone()
      collisionClone.Name = "_CollisionClone"
      collisionClone.Massless = true
      collisionClone.Parent = character6
      collisionClone.CanCollide = false
      collisionClone.CanQuery = false
      collisionClone.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)

      if v24 then
        task.cancel(v24)
        v24 = nil
      end

      v24 = task.spawn(function()
        while flag4 do
          task.wait(0.23)

          f2(function()
            if collisionClone then
              collisionClone.Massless = false
              task.wait(0.23)
              local humanoidRootPart8 = character6:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart8 and humanoidRootPart8.Anchored then
                collisionClone.Massless = true
                task.wait(1)
              end

              collisionClone.Massless = true
            end
          end, "Anti Speed Loop")
        end
      end)
    end, "AntiSpeed Bypass Auto-Start")
  end

  task.defer(f4)

  localPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    f4()
  end)

  v8 = false
  walkSpeed = 16
  speedValue = v3.speedValue

  essentialsTab:Toggle("Enable Speed", v3.speed, function(p11)
    f2(function()
      v8 = p11
      v3.speed = p11

      if p11 then
        local character7 = localPlayer.Character

        if character7 then
          local humanoid4 = character7:FindFirstChild("Humanoid")

          if humanoid4 then
            walkSpeed = humanoid4.WalkSpeed
          end
        end

        v36 = task.spawn(function()
          while v8 do
            task.wait(0.1)

            f2(function()
              local character8 = localPlayer.Character

              if character8 then
                local humanoid5 = character8:FindFirstChild("Humanoid")

                if humanoid5 then
                  humanoid5.WalkSpeed = speedValue
                end
              end
            end, "Speed Loop")
          end
        end)
      else
        if v36 then
          task.cancel(v36)
          v36 = nil
        end

        local character9 = localPlayer.Character

        if character9 then
          local humanoid6 = character9:FindFirstChild("Humanoid")

          if humanoid6 then
            humanoid6.WalkSpeed = walkSpeed
          end
        end
      end
    end, "Enable Speed Toggle")
  end, "Increase walk speed — requires AntiSpeed Bypass active")

  essentialsTab:Slider("Speed Value", 2, v39, math.min(v3.speedValue, v39), function(speedValue2)
    f2(function()
      speedValue = speedValue2
      v3.speedValue = speedValue2
    end, "Speed Value Slider")
  end, "Set your desired walk speed")
end)

f3("UI - Fullbright", function()
  v9 = false
  map = {}

  essentialsTab:Toggle("Fullbright", v3.fullbright, function(p12)
    f2(function()
      v9 = p12
      v3.fullbright = p12

      if p12 then
        map = {
          Brightness = lighting.Brightness,
          ClockTime = lighting.ClockTime,
          FogEnd = lighting.FogEnd,
          GlobalShadows = lighting.GlobalShadows,
          Ambient = lighting.Ambient,
        }

        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        lighting.Ambient = Color3.fromRGB(178, 178, 178)

        connect2 = lighting.Changed:Connect(function(p13)
          if not v9 then
            return
          end

          f2(function()
            if p13 == "Brightness" and lighting.Brightness ~= 2 then
              lighting.Brightness = 2
            end

            if p13 == "ClockTime" and lighting.ClockTime ~= 14 then
              lighting.ClockTime = 14
            end

            if p13 == "FogEnd" and lighting.FogEnd ~= 100000 then
              lighting.FogEnd = 100000
            end

            if p13 == "GlobalShadows" and lighting.GlobalShadows ~= false then
              lighting.GlobalShadows = false
            end

            if p13 == "Ambient" and lighting.Ambient ~= Color3.fromRGB(178, 178, 178) then
              lighting.Ambient = Color3.fromRGB(178, 178, 178)
            end
          end, "Fullbright Changed Event")
        end)
      else
        if connect2 then
          connect2:Disconnect()
          connect2 = nil
        end

        for key3, value6 in pairs(map) do
          lighting[key3] = value6
        end
      end
    end, "Fullbright Toggle")
  end, "See clearly in dark areas")
end)

f3("UI - Protection tab", function()
  v10 = false

  protectionTab:Toggle("Spoof Crouch", v3.spoofCrouch, function(p14)
    f2(function()
      v10 = p14
      v3.spoofCrouch = p14

      if p14 then
        v26 = task.spawn(function()
          while v10 do
            f2(
              function() replicatedStorage.RemotesFolder.Crouch:FireServer(true, true) end,
              "Spoof Crouch Loop"
            )

            task.wait(0.32)
          end
        end)
      elseif v26 then
        task.cancel(v26)
        v26 = nil
      end
    end, "Spoof Crouch Toggle")
  end, "Tricks the game into thinking you're always crouching")

  v11 = false

  protectionTab:Toggle("Anti Eyes", v3.antiEyes, function(p15)
    f2(function()
      v11 = p15
      v3.antiEyes = p15

      if p15 then
        v38 = task.spawn(function()
          while v11 do
            f2(function()
              for _, value7 in pairs(workspace:GetChildren()) do
                if value7.Name == "Eyes" and value7:FindFirstChild("Core") then
                  local core = value7.Core

                  if core:FindFirstChild("Ambience") and core.Ambience.Playing then
                    replicatedStorage.RemotesFolder.MotorReplication:FireServer(-650)
                    break
                  end
                end
              end
            end, "Anti Eyes Loop")

            task.wait()
          end
        end)
      elseif v38 then
        task.cancel(v38)
        v38 = nil
      end
    end, "Anti Eyes Toggle")
  end, "Automatically looks away from Eyes")

  v12 = false
  parent = nil

  protectionTab:Toggle("Disable Screech", v3.disableScreech, function(p16)
    f2(function()
      v12 = p16
      v3.disableScreech = p16
      local screech = replicatedStorage.Entities:FindFirstChild("Screech")

      if p16 and screech then
        local zeScriptStuff = replicatedStorage:FindFirstChild("ZeScript_Stuff")

        if not zeScriptStuff then
          zeScriptStuff = Instance.new("Folder")
          zeScriptStuff.Name = "ZeScript_Stuff"
          zeScriptStuff.Parent = replicatedStorage
        end

        local disabledEntity = zeScriptStuff:FindFirstChild("DisabledEntity")

        if not disabledEntity then
          disabledEntity = Instance.new("Folder")
          disabledEntity.Name = "DisabledEntity"
          disabledEntity.Parent = zeScriptStuff
        end

        parent = screech.Parent
        screech.Parent = disabledEntity
      elseif not p16 and screech and parent then
        screech.Parent = parent
      end
    end, "Disable Screech Toggle")
  end, "Prevents Screech from spawning")

  local v45 = false
  local list5 = {}

  protectionTab:Toggle("Disable Snare", v3.disableSnare, function(p17)
    f2(function()
      v45 = p17
      v3.disableSnare = p17

      if p17 then
        for _, value8 in pairs(workspace.CurrentRooms:GetChildren()) do
          f2(function()
            local assets = value8:FindFirstChild("Assets")

            if assets then
              for _, value9 in pairs(assets:GetChildren()) do
                if value9.Name == "Snare" then
                  local hitbox = value9:FindFirstChild("Hitbox")

                  if hitbox then
                    hitbox.CanTouch = false
                    table.insert(list5, hitbox)
                  end
                end
              end
            end
          end, "Disable Snare - Initial")
        end

        task.spawn(function()
          while v45 do
            task.wait(0.5)

            f2(function()
              for _, value10 in pairs(workspace.CurrentRooms:GetChildren()) do
                local assets2 = value10:FindFirstChild("Assets")

                if assets2 then
                  for _, value11 in pairs(assets2:GetChildren()) do
                    if value11.Name == "Snare" then
                      local hitbox2 = value11:FindFirstChild("Hitbox")

                      if hitbox2 and hitbox2.CanTouch then
                        hitbox2.CanTouch = false

                        if not table.find(list5, hitbox2) then
                          table.insert(list5, hitbox2)
                        end
                      end
                    end
                  end
                end
              end
            end, "Disable Snare Loop")
          end
        end)
      else
        for _, value12 in pairs(list5) do
          f2(function()
            if value12 and value12.Parent then
              value12.CanTouch = true
            end
          end, "Re-enable Snare")
        end

        list5 = {}
      end
    end, "Disable Snare Toggle")
  end, "Disables Snare traps")
end)

f3("Hook init & toggles", function()
  v13 = false
  v14 = false
  flag3 = false

  function f23()
    if flag3 then
      return
    end

    if not flag then
      warn("[RoshanHub] initHooks called but hook support unavailable — skipping")
      return
    end

    local ok5, result5 = pcall(function()
      local hideMonster = replicatedStorage:WaitForChild("RemotesFolder"):WaitForChild("HideMonster")
      local a90 = replicatedStorage:WaitForChild("RemotesFolder"):WaitForChild("A90")
      local v46 = hookfunction or replaceclosure or hookmetamethod

      if not v46 then
        error("No hook function found!")
      end

      local v47

      v47 = v46(getrawmetatable(game).__namecall, function(p18, ...)
        if getnamecallmethod() == "FireServer" then
          if v13 and p18 == hideMonster then
            print("[HideMonster] Blocked!")
            return
          end

          if v14 and p18 == a90 then
            if ({ ... })[1] == "moved" then
              print("[A90] Blocked! Sending 'didnt'")
              return v47(p18, "didnt")
            end
          end
        end

        return v47(p18, ...)
      end)

      flag3 = true
      print("[RoshanHub] Hooks initialized!")
    end)

    if not ok5 then
      warn("[RoshanHub] initHooks FAILED: " .. tostring(result5))
    end
  end

  if flag then
    protectionTab:Toggle("Anti Heartbeat Kick", false, function(p19)
      f2(function()
        v13 = p19

        if p19 then
          f23()
        end

        window:Notify({
          Text = p19 and "Anti Heartbeat enabled!" or "Anti Heartbeat disabled.",
          Duration = 3,
          Type = p19 and "Success" or "Warning",
        })
      end, "Anti Heartbeat Toggle")
    end, "Blocks Figure's heartbeat minigame from killing you")

    protectionTab:Toggle("No Camera Shake", false, function(p20)
      f2(function()
        local cameraShaker = replicatedStorage:FindFirstChild("CameraShaker")

        if not cameraShaker then
          window:Notify({ Text = "CameraShaker not found", Duration = 3, Type = "Error" })
          return
        end

        local ok6, v48 = pcall(require, cameraShaker)

        if not ok6 or not v48 then
          window:Notify({ Text = "Failed to require CameraShaker", Duration = 3, Type = "Error" })
          return
        end

        if p20 then
          local v49 = hookfunction or replaceclosure

          if v49 and v48.Update then
            getgenv()._origCamShakeUpdate = v49(v48.Update, function(p21, p22)
              return CFrame.new()
            end)
          end

          window:Notify({ Text = "No Camera Shake enabled!", Duration = 3, Type = "Success" })
        else
          if getgenv()._origCamShakeUpdate then
            local v50 = hookfunction or replaceclosure

            if v50 and v48.Update then
              v50(v48.Update, getgenv()._origCamShakeUpdate)
            end

            getgenv()._origCamShakeUpdate = nil
          end

          window:Notify({ Text = "Camera Shake restored.", Duration = 3, Type = "Warning" })
        end
      end, "No Camera Shake Toggle")
    end, "Disables all camera shake effects")

    protectionTab:Toggle("Anti A-90", false, function(p23)
      f2(function()
        v14 = p23

        if p23 then
          f23()
        end

        window:Notify({
          Text = p23 and "Anti A-90 enabled!" or "Anti A-90 disabled.",
          Duration = 3,
          Type = p23 and "Success" or "Warning",
        })
      end, "Anti A90 Toggle")
    end, "Replaces A-90 death signal with survival signal")
  else
    protectionTab:Label("❌ Anti Heartbeat — requires hook support (unsupported executor)")
    protectionTab:Label("❌ Anti A-90 — requires hook support (unsupported executor)")
    protectionTab:Label("❌ No Camera Shake — requires hook support (unsupported executor)")
  end
end)

f3("AntiGroundskeeper vars", function()
  v15 = false
  local flag7 = false
  cameraType = currentCamera.CameraType
  cameraSubject = currentCamera.CameraSubject

  function f24(p24)
    if not p24 then
      return nil
    end

    local ok7, result6 = pcall(function() return p24:GetPivot() end)

    if ok7 and result6 then
      return result6.Position
    end

    local findFirstChildWhichIsA = p24:FindFirstChildWhichIsA("BasePart", true)
    return findFirstChildWhichIsA and findFirstChildWhichIsA.Position or nil
  end

  local connect3

  function f25(instance6)
    if connect3 then
      return
    end

    local head = instance6:FindFirstChild("Head")

    if not head then
      return
    end

    cameraType = currentCamera.CameraType
    cameraSubject = currentCamera.CameraSubject
    currentCamera.CameraType = Enum.CameraType.Scriptable

    connect3 = runService.RenderStepped:Connect(function()
      if not head or not head.Parent then
        return
      end

      currentCamera.CFrame = head.CFrame * CFrame.new(0, -2, 0)
    end)
  end

  function f26()
    if connect3 then
      connect3:Disconnect()
      connect3 = nil
    end

    currentCamera.CameraType = cameraType

    if cameraSubject then
      currentCamera.CameraSubject = cameraSubject
    end
  end

  function f27(instance7)
    f2(function()
      if flag7 then
        return
      end

      local humanoid7 = instance7:FindFirstChild("Humanoid")
      local humanoidRootPart9 = instance7:FindFirstChild("HumanoidRootPart")

      if not (humanoid7 and humanoidRootPart9) then
        return
      end

      humanoidRootPart9.CFrame = humanoidRootPart9.CFrame + Vector3.new(0, 2, 0)
      humanoid7.HipHeight = 5
      f25(instance7)
      flag7 = true
      window:Notify({ Text = "Anti-Groundskeeper Activated", Duration = 2, Type = "Warning" })
    end)
  end

  function f28(instance8)
    f2(function()
      local humanoid8 = instance8:FindFirstChild("Humanoid")

      if humanoid8 then
        humanoid8.HipHeight = 2
      end

      f26()
      local humanoidRootPart10 = instance8:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart10 then
        humanoidRootPart10.CFrame = humanoidRootPart10.CFrame - Vector3.new(0, 2, 0)
      end

      flag7 = false
      window:Notify({ Text = "Anti-Groundskeeper Deactivated", Duration = 2, Type = "Success" })
    end)
  end

  function f29()
    if not v15 then
      return
    end

    f2(function()
      local character10 = localPlayer.Character

      if not character10 then
        return
      end

      local humanoidRootPart11 = character10:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart11 then
        return
      end

      local flag8 = false

      for _, value13 in pairs(workspace.CurrentRooms:GetChildren()) do
        local groundskeeper = value13:FindFirstChild("Groundskeeper")

        if groundskeeper and groundskeeper:IsA("Model") then
          local v51 = f24(groundskeeper)

          if v51 and (humanoidRootPart11.Position - v51).Magnitude <= 300 then
            flag8 = true
            break
          end
        end
      end

      if flag8 and not flag7 then
        f27(character10)
      elseif not flag8 and flag7 then
        f28(character10)
      end
    end)
  end

  protectionTab:Toggle("Anti-Groundskeeper", false, function(p25)
    f2(function()
      v15 = p25

      if p25 then
        v37 = task.spawn(function()
          while v15 do
            task.wait(0.1)
            f29()
          end
        end)
      else
        if v37 then
          task.cancel(v37)
          v37 = nil
        end

        if flag7 then
          local character11 = localPlayer.Character

          if character11 then
            f28(character11)
          end
        end
      end
    end)
  end, "Auto-avoids Groundskeeper when nearby")

  localPlayer.CharacterAdded:Connect(function()
    f2(function()
      flag7 = false
      f26()
    end)
  end)
end)

f3("FigureGodMode", function()
  v16 = false
  local flag9 = false

  function f30(p26)
    if not p26 then
      return nil
    end

    local ok8, result7 = pcall(function() return p26:GetPivot() end)

    if ok8 and result7 then
      return result7.Position
    end

    local findFirstChildWhichIsA2 = p26:FindFirstChildWhichIsA("BasePart", true)
    return findFirstChildWhichIsA2 and findFirstChildWhichIsA2.Position or nil
  end

  local connect4

  function f31(instance9)
    if connect4 then
      return
    end

    local head2 = instance9:FindFirstChild("Head")

    if not head2 then
      return
    end

    cameraType = currentCamera.CameraType
    cameraSubject = currentCamera.CameraSubject
    currentCamera.CameraType = Enum.CameraType.Scriptable

    connect4 = runService.RenderStepped:Connect(function()
      if not head2 or not head2.Parent then
        return
      end

      currentCamera.CFrame = head2.CFrame * CFrame.new(0, -10, 0)
    end)
  end

  function f32()
    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    currentCamera.CameraType = cameraType

    if cameraSubject then
      currentCamera.CameraSubject = cameraSubject
    end
  end

  function f33(instance10)
    f2(function()
      if flag9 then
        return
      end

      local humanoid9 = instance10:FindFirstChild("Humanoid")
      local humanoidRootPart12 = instance10:FindFirstChild("HumanoidRootPart")

      if not (humanoid9 and humanoidRootPart12) then
        return
      end

      humanoidRootPart12.CFrame = humanoidRootPart12.CFrame + Vector3.new(0, 13, 0)
      humanoid9.HipHeight = 13
      f31(instance10)
      flag9 = true
      window:Notify({ Text = "Figure GodMode Activated", Duration = 2, Type = "Warning" })
    end)
  end

  function f34(instance11)
    f2(function()
      local humanoid10 = instance11:FindFirstChild("Humanoid")

      if humanoid10 then
        humanoid10.HipHeight = 2
      end

      f32()
      local humanoidRootPart13 = instance11:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart13 then
        humanoidRootPart13.CFrame = humanoidRootPart13.CFrame - Vector3.new(0, 13, 0)
      end

      flag9 = false
      window:Notify({ Text = "Figure GodMode Deactivated", Duration = 2, Type = "Success" })
    end)
  end

  function f35()
    if not v16 then
      return
    end

    f2(function()
      local character12 = localPlayer.Character

      if not character12 then
        return
      end

      local humanoidRootPart14 = character12:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart14 then
        return
      end

      local flag10 = false

      for _, value14 in pairs(workspace.CurrentRooms:GetChildren()) do
        local figureSetup = value14:FindFirstChild("FigureSetup")

        if figureSetup then
          local figureRig = figureSetup:FindFirstChild("FigureRig")

          if figureRig then
            local v52 = f30(figureRig)

            if v52 and (humanoidRootPart14.Position - v52).Magnitude <= 30 then
              flag10 = true
              break
            end
          end
        end
      end

      if flag10 and not flag9 then
        f33(character12)
      elseif not flag10 and flag9 then
        f34(character12)
      end
    end)
  end

  universalTab:Toggle("Figure GodMode", false, function(p27)
    f2(function()
      v16 = p27

      if p27 then
        v28 = task.spawn(function()
          while v16 do
            task.wait(0.1)
            f35()
          end
        end)
      else
        if v28 then
          task.cancel(v28)
          v28 = nil
        end

        if flag9 then
          local character13 = localPlayer.Character

          if character13 then
            f34(character13)
          end
        end
      end
    end)
  end, "Auto-activates GodMode when Figure is within 30 studs")

  localPlayer.CharacterAdded:Connect(function()
    f2(function()
      flag9 = false
      f32()
    end)
  end)
end)

f3("UI - AntiDupe", function()
  local v53 = false
  local list6 = {}

  universalTab:Toggle("Anti-Dupe", false, function(p28)
    f2(function()
      local function f47(instance12)
        f2(function()
          local sideroomSpace = instance12:FindFirstChild("SideroomSpace")

          if sideroomSpace then
            local collision = sideroomSpace:FindFirstChild("Collision")

            if collision and collision:IsA("BasePart") and collision.CanCollide then
              collision.CanCollide = false
              collision.CanQuery = false
              collision.CanTouch = false

              if not table.find(list6, collision) then
                table.insert(list6, collision)
              end
            end
          end

          local sideroomDupe = instance12:FindFirstChild("SideroomDupe")

          if sideroomDupe then
            local doorFake = sideroomDupe:FindFirstChild("DoorFake")

            if doorFake then
              local hidden = doorFake:FindFirstChild("Hidden")

              if hidden and hidden:IsA("BasePart") and hidden.CanCollide then
                hidden.CanCollide = false
                hidden.CanQuery = false
                hidden.CanTouch = false

                if not table.find(list6, hidden) then
                  table.insert(list6, hidden)
                end
              end
            end

            for _, value15 in pairs(sideroomDupe:GetDescendants()) do
              if value15:IsA("BasePart") and value15.Name:lower():find("collision") then
                value15:Destroy()
              end
            end
          end
        end, "Anti-Dupe - Room")
      end

      v53 = p28

      if p28 then
        for _, value16 in pairs(workspace.CurrentRooms:GetChildren()) do
          f47(value16)
        end

        task.spawn(function()
          while v53 do
            task.wait(0.5)

            for _, value17 in pairs(workspace.CurrentRooms:GetChildren()) do
              f47(value17)
            end
          end
        end)
      else
        for _, value18 in pairs(list6) do
          f2(function()
            if value18 and value18.Parent then
              value18.CanCollide = true
              value18.CanQuery = true
              value18.CanTouch = true
            end
          end, "Re-enable Dupe Collisions")
        end

        list6 = {}
      end
    end, "Anti-Dupe Toggle")
  end, "Disables dupe room collisions")
end)

f3("UI - ObjectBypass", function()
  v17 = false
  local list7 = {}

  universalTab:Toggle("Object Bypass", v3.objectBypass, function(p29)
    f2(function()
      v17 = p29
      v3.objectBypass = p29

      local function f48(instance13)
        f2(function()
          local assets3 = instance13:FindFirstChild("Assets")

          if not assets3 then
            return
          end

          for _, value19 in pairs(assets3:GetChildren()) do
            if value19.Name == "ChandelierObstruction" then
              local collision2 = value19:FindFirstChild("Collision")

              if collision2 and collision2.CanTouch then
                collision2.CanTouch = false
                collision2.CanQuery = false

                if not table.find(list7, collision2) then
                  table.insert(list7, collision2)
                end
              end
            end
          end

          for _, value20 in pairs(assets3:GetDescendants()) do
            if value20:IsA("Model")
              and value20:GetAttribute("LoadModule") == "AnimatedObstacleKill" then
              for _, value21 in pairs(value20:GetDescendants()) do
                if value21:IsA("BasePart") and value21.CanTouch then
                  value21.CanTouch = false
                  value21.CanQuery = false

                  if not table.find(list7, value21) then
                    table.insert(list7, value21)
                  end
                end
              end
            end
          end
        end, "Object Bypass - Room")
      end

      if p29 then
        for _, value22 in pairs(workspace.CurrentRooms:GetChildren()) do
          f48(value22)
        end

        task.spawn(function()
          while v17 do
            task.wait(0.5)

            for _, value23 in pairs(workspace.CurrentRooms:GetChildren()) do
              f48(value23)
            end
          end
        end)
      else
        for _, value24 in pairs(list7) do
          f2(function()
            if value24 and value24.Parent then
              value24.CanTouch = true
              value24.CanQuery = true
            end
          end, "Re-enable Objects")
        end

        list7 = {}
      end
    end, "Object Bypass Toggle")
  end, "Disables chandeliers and animated obstacles")
end)

f3("UI - NoAccel", function()
  v18 = false
  customPhysicalProperties = nil

  universalTab:Toggle("No Acceleration", v3.noAccel, function(p30)
    f2(function()
      v18 = p30
      v3.noAccel = p30

      if p30 then
        local humanoidRootPart15 = (localPlayer.Character
          or localPlayer.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")

        if humanoidRootPart15 then
          customPhysicalProperties = humanoidRootPart15.CustomPhysicalProperties

          humanoidRootPart15.CustomPhysicalProperties = PhysicalProperties.new(
            100, 0.7, 0, 1, 1
          )
        end

        v31 = task.spawn(function()
          while v18 do
            task.wait(0.5)

            f2(function()
              local character14 = localPlayer and localPlayer.Character



              if character14 then
                local humanoidRootPart16 = character14:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart16 then
                  local customPhysicalProperties2 = humanoidRootPart16.CustomPhysicalProperties

                  if not customPhysicalProperties2 or customPhysicalProperties2.Density ~= 100 then
                    humanoidRootPart16.CustomPhysicalProperties = PhysicalProperties.new(
                      100, 0.7, 0, 1, 1
                    )
                  end
                end
              end
            end, "No Accel Loop")
          end
        end)
      else
        if v31 then
          task.cancel(v31)
          v31 = nil
        end

        local character15 = localPlayer and localPlayer.Character

        if character15 then
          local humanoidRootPart17 = character15:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart17 then
            humanoidRootPart17.CustomPhysicalProperties = customPhysicalProperties
          end
        end

        customPhysicalProperties = nil
      end
    end, "No Acceleration Toggle")
  end, "Removes movement acceleration for instant speed")
end)

f3("EntityPathing", function()
  v19 = false
  local savedRoshanNodes

  function f36()
    f2(function()
      local currentRooms2 = workspace:FindFirstChild("CurrentRooms")

      if not currentRooms2 then
        return
      end

      if not savedRoshanNodes then
        savedRoshanNodes = workspace:FindFirstChild("Saved_RoshanNodes")

        if not savedRoshanNodes then
          savedRoshanNodes = Instance.new("Folder")
          savedRoshanNodes.Name = "Saved_RoshanNodes"
          savedRoshanNodes.Parent = workspace
        end
      end

      for _, value25 in pairs(currentRooms2:GetChildren()) do
        f2(function()
          if value25:IsA("Model") then
            local pathfindNodes = value25:FindFirstChild("PathfindNodes")

            if pathfindNodes then
              local name = "Room_" .. value25.Name .. "_Nodes"

              if not savedRoshanNodes:FindFirstChild(name) then
                local clone = pathfindNodes:Clone()
                clone.Name = name

                for _, value26 in pairs(clone:GetDescendants()) do
                  if value26:IsA("BasePart") then
                    value26.Transparency = v19 and 0 or 1
                  end
                end

                clone.Parent = savedRoshanNodes
              end
            end
          end
        end, "Setup Pathfind Nodes - " .. tostring(value25.Name))
      end
    end, "Setup Pathfind Nodes Main")
  end

  f36()

  task.spawn(function()
    while true do
      task.wait(1)
      f36()
    end
  end)

  universalTab:Toggle("Entity Pathing", false, function(p31)
    f2(function()
      v19 = p31

      if savedRoshanNodes then
        for _, value27 in pairs(savedRoshanNodes:GetChildren()) do
          for _, value28 in pairs(value27:GetDescendants()) do
            if value28:IsA("BasePart") then
              value28.Transparency = p31 and 0 or 1
            end
          end
        end

        window:Notify({
          Text = p31 and "Entity pathing nodes visible!" or "Entity pathing nodes hidden",
          Duration = 2,
          Type = p31 and "Success" or "Warning",
        })
      else
        window:Notify({ Text = "No pathfind nodes found yet", Duration = 2, Type = "Warning" })
      end
    end, "Entity Pathing Toggle")
  end, "Shows entity pathfinding nodes")
end)

f3("UI - AutoFinishDaily", function()
  local v54 = false

  universalTab:Toggle("Auto Finish Daily Run", false, function(p32)
    f2(function()
      v54 = p32

      if p32 then
        window:Notify({
          Text = "[Daily Run]: Go through some rooms — it'll auto-finish after a bit!",
          Duration = 8,
          Type = "Warning",
        })

        v33 = task.spawn(function()
          while v54 do
            task.wait(1)

            f2(function()
              local character16 = localPlayer and localPlayer.Character

              if not character16 then
                return
              end

              local humanoidRootPart18 = character16:FindFirstChild("HumanoidRootPart")

              if not humanoidRootPart18 then
                return
              end

              local currentRooms3 = workspace:FindFirstChild("CurrentRooms")

              if not currentRooms3 then
                return
              end

              for _, value29 in pairs(currentRooms3:GetChildren()) do
                local findFirstChild6 = value29:FindFirstChild("RippleExitDoor", true)

                if findFirstChild6 then
                  local basePart3 = findFirstChild6:IsA("BasePart") and findFirstChild6

                  local findFirstChildWhichIsA3 = basePart3

                  findFirstChildWhichIsA3 = basePart3 or findFirstChild6:FindFirstChildWhichIsA(
                    "BasePart", true
                  )

                  if findFirstChildWhichIsA3 then
                    humanoidRootPart18.CFrame = findFirstChildWhichIsA3.CFrame
                      + Vector3.new(0, 3, 0)

                    window:Notify({
                      Text = "Teleported to Daily Run Exit!",
                      Duration = 3,
                      Type = "Success",
                    })
                  end
                end
              end
            end, "Auto Finish Daily Run Loop")
          end
        end)
      elseif v33 then
        task.cancel(v33)
        v33 = nil
      end
    end, "Auto Finish Daily Run Toggle")
  end, "Automatically teleports to the daily run exit")
end)

f3("UI - AnticheatManip", function()
  local v55 = false
  local flag11 = false
  local t = Enum.KeyCode.T

  userInputService.InputBegan:Connect(function(input, p33)
    f2(function()
      if input.KeyCode == t and not p33 then
        flag11 = true
      end
    end, "AntiCheat Manip Input Began")
  end)

  userInputService.InputEnded:Connect(function(input2, p34)
    f2(function()
      if input2.KeyCode == t then
        flag11 = false
      end
    end, "AntiCheat Manip Input Ended")
  end)

  universalTab:Toggle("AntiCheat Manipulation (Hold T)", false, function(p35)
    f2(function()
      v55 = p35

      if p35 then
        v35 = task.spawn(function()
          while v55 do
            task.wait(0.03)

            f2(function()
              if flag11 and localPlayer.Character then
                localPlayer.Character:PivotTo(localPlayer.Character:GetPivot()
                  + workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1) * -100)
              end
            end, "AntiCheat Manip Loop")
          end
        end)
      elseif v35 then
        task.cancel(v35)
        v35 = nil
      end
    end, "AntiCheat Manipulation Toggle")
  end, "Hold T to use the anticheat to teleport through walls")
end)

f3("InteractTab", function()
  v20 = false
  autoProxiInstant = v3.autoProxiInstant
  r = Enum.KeyCode[v3.autoProxiKey] or Enum.KeyCode.R
  flag5 = false
  map3 = {}
  local list8 = { "close", "leave", "hide" }

  function f37(instance14)
    if not instance14 or not instance14.Enabled then
      return false
    end

    local lower = instance14.ActionText and instance14.ActionText:lower() or ""

    for _, value30 in ipairs(list8) do
      if lower:find(value30, 1, true) then
        return false
      end
    end

    if lower:find("exit", 1, true) and not lower:find("door", 1, true) then
      return false
    end

    if instance14.ObjectText == "Painting" then
      return false
    end

    local getAttribute = instance14:GetAttribute("Interactions" .. localPlayer.Name)

    if getAttribute and getAttribute > 5 then
      return false
    end

    return true
  end

  function f38(instance15)
    local parent2 = instance15.Parent

    if not parent2 then
      return nil
    end

    if parent2:IsA("BasePart") then
      return parent2.Position
    end

    local ok9, result8 = pcall(function() return parent2:GetPivot() end)

    if ok9 and result8 then
      return result8.Position
    end

    local findFirstChildWhichIsA4 = parent2:FindFirstChildWhichIsA("BasePart", true)
    return findFirstChildWhichIsA4 and findFirstChildWhichIsA4.Position or nil
  end

  function f11(instance16)
    local v56 = autoProxiInstant and instance16.HoldDuration > 0
    local holdDuration

    if v56 then
      holdDuration = instance16.HoldDuration
      instance16.HoldDuration = 0
      fireproximityprompt(instance16)

      task.delay(0.1, function()
        if instance16 and instance16.Parent then
          instance16.HoldDuration = holdDuration
        end
      end)
    else
      fireproximityprompt(instance16)
    end
  end

  list3 = {}
  v21 = 0

  function f12()
    local list9 = {}
    local list10 = {}
    local currentRooms4 = workspace:FindFirstChild("CurrentRooms")

    if currentRooms4 then
      table.insert(list10, currentRooms4)
    end

    local playerGui = localPlayer:FindFirstChild("PlayerGui")

    if playerGui then
      table.insert(list10, playerGui)
    end

    for _, value31 in ipairs(list10) do
      for _, value32 in ipairs(value31:GetDescendants()) do
        if value32:IsA("ProximityPrompt") then
          table.insert(list9, value32)
        end
      end
    end

    list3 = list9
    v21 = tick()
  end

  function f10()
    f2(function()
      local character17 = localPlayer.Character

      if not character17 then
        return
      end

      local humanoidRootPart19 = character17:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart19 then
        return
      end

      local position = humanoidRootPart19.Position
      local v57 = tick()

      if v57 - v21 >= 1.5 then
        f12()
      end

      local list11 = {}

      for _, value33 in ipairs(list3) do
        if not (not value33 or not value33.Parent) then
          if f37(value33) then
            local v58 = f38(value33)
            local v59 = (value33.MaxActivationDistance or 10) + 4

            if not (v58 and (position - v58).Magnitude > v59) then
              local v60 = tostring(value33)

              if not (map3[v60] and v57 - map3[v60] < 0.1) then
                map3[v60] = v57
                table.insert(list11, value33)
              end
            end
          end
        end
      end

      local v61 = 0

      for _, value34 in ipairs(list11) do
        if not (not value34 or not value34.Parent) then
          f11(value34)
          v61 = v61 + 1

          if v61 >= 5 then
            v61 = 0
            task.wait()
          end
        end
      end

      for key4, value35 in pairs(map3) do
        if v57 - value35 > 5 then
          map3[key4] = nil
        end
      end
    end, "Run Auto Proxi")
  end

  userInputService.InputBegan:Connect(function(input3, p36)
    f2(function()
      if input3.KeyCode ~= r or p36 then
        return
      end

      flag5 = true

      if v20 then
        f10()
      end
    end, "Input Began - AutoProxi")
  end)

  userInputService.InputEnded:Connect(function(input4, p37)
    f2(function()
      if input4.KeyCode == r then
        flag5 = false
      end
    end, "Input Ended - AutoProxi")
  end)

  local v62 = interactTab
  local v63 = touchEnabled and "Loot Aura" or "Auto Proxi (Hold R)"
  local autoProxi = v3.autoProxi
  local v64

  v40, v64 = v62:Toggle(v63, autoProxi, function(p38)
    f2(function()
      v20 = p38
      v3.autoProxi = p38
      map3 = {}
      list3 = {}
      v21 = 0

      if p38 then
        v32 = task.spawn(function()
          while v20 do
            task.wait(0.1)

            if touchEnabled then
              map3 = {}
              v21 = 0
              f10()
            elseif flag5 then
              map3 = {}
              v21 = 0
              f10()
            end
          end
        end)
      elseif v32 then
        task.cancel(v32)
        v32 = nil
      end
    end, "Auto Proxi Toggle")
  end, "Hold R to auto interact with nearby prompts")

  interactTab:Toggle("Instant Interact", v3.autoProxiInstant, function(autoProxiInstant2)
    f2(function()
      autoProxiInstant = autoProxiInstant2
      v3.autoProxiInstant = autoProxiInstant2
    end, "Instant Interact Toggle")
  end, "Bypass hold duration on proximity prompts")

  if not touchEnabled then
    interactTab:DependsOn(interactTab:Keybind("Auto Proxi Key", r, function(r2, p39)
      f2(function()
        r = r2
        v3.autoProxiKey = r2.Name
      end, "Auto Proxi Keybind")
    end, "Key to hold for Auto Proxi"), v40)
  end
end)

f3("Floor - Hotel tab", function()
  if value ~= "Hotel" then
    return
  end

  local hotelTab = floorCategory:CreateTab("Hotel", "🏨")
  local v65 = false
  local v66
  local flag12 = false

  hotelTab:Toggle("Finish Room 100's Minigame", false, function(p40)
    f2(function()
      v65 = p40
      flag12 = false

      if p40 then
        window:Notify({
          Text = "[Room 100]: Searching for ElevatorBreaker...",
          Duration = 5,
          Type = "Warning",
        })

        v66 = task.spawn(function()
          local flag13 = false

          while v65 and not flag13 do
            task.wait(0.1)

            f2(function()
              local currentRooms5 = workspace:FindFirstChild("CurrentRooms")

              if not currentRooms5 then
                return
              end

              for _, value36 in pairs(currentRooms5:GetChildren()) do
                if value36:FindFirstChild("ElevatorBreakerEmpty", true) then
                  flag13 = true

                  window:Notify({
                    Text = "[Room 100]: Found ElevatorBreakerEmpty! Waiting...",
                    Duration = 3,
                    Type = "Success",
                  })

                  break
                end
              end
            end, "Room 100 - Check Empty")
          end

          while v65 and not flag12 do
            task.wait(3)

            f2(function()
              local currentRooms6 = workspace:FindFirstChild("CurrentRooms")

              if not currentRooms6 then
                return
              end

              for _, value37 in pairs(currentRooms6:GetChildren()) do
                local findFirstChild7 = value37:FindFirstChild("ElevatorBreaker", true)

                if findFirstChild7 then
                  flag12 = true

                  window:Notify({
                    Text = "[Room 100]: ElevatorBreaker found! Auto-completing...",
                    Duration = 3,
                    Type = "Success",
                  })

                  task.wait(0.5)

                  local findFirstChild8 = findFirstChild7:FindFirstChild(
                    "ActivateEventPrompt", true
                  )

                  if findFirstChild8 and findFirstChild8:IsA("ProximityPrompt") then
                    fireproximityprompt(findFirstChild8)

                    window:Notify({
                      Text = "[Room 100]: Event prompt activated!",
                      Duration = 2,
                      Type = "Success",
                    })
                  end

                  break
                end
              end
            end, "Room 100 - Check Breaker")
          end

          while v65 and flag12 do
            task.wait(1)

            f2(function()
              replicatedStorage:WaitForChild("RemotesFolder"):WaitForChild("EBF"):FireServer()
            end, "Room 100 - Fire EBF")
          end
        end)
      else
        if v66 then
          task.cancel(v66)
          v66 = nil
        end

        flag12 = false
      end
    end, "Room 100 Toggle")
  end, "Automatically completes the Room 100 electrical minigame")

  local v67 = false
  local v68
  local v69 = {}
  local v70 = 0

  local function f49()
    local currentRooms7 = workspace:FindFirstChild("CurrentRooms")
    return currentRooms7 and currentRooms7:FindFirstChild("50") ~= nil
  end

  local function getDoor()
    local currentRooms8 = workspace:FindFirstChild("CurrentRooms")

    if not currentRooms8 then
      return nil
    end

    local findFirstChild9 = currentRooms8:FindFirstChild("50")
    return findFirstChild9 and findFirstChild9:FindFirstChild("Door")
  end

  local function f50()
    local character18 = localPlayer.Character

    if not character18 then
      return false
    end

    local humanoidRootPart20 = character18:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart20 then
      return false
    end

    local door2 = getDoor()

    if not door2 then
      return false
    end

    local basePart4 = door2:IsA("BasePart") and door2
      or door2:FindFirstChildWhichIsA("BasePart")

    if not basePart4 then
      return false
    end

    return (humanoidRootPart20.Position - basePart4.Position).Magnitude <= 25
  end

  local function f51()
    local list12 = {}
    local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

    if not playerGui2 then
      return list12
    end

    local permUI = playerGui2:FindFirstChild("PermUI")

    if not permUI then
      return list12
    end

    local hints = permUI:FindFirstChild("Hints")

    if not hints then
      return list12
    end

    for _, value38 in pairs(hints:GetChildren()) do
      if value38:IsA("ImageLabel") and value38.Name == "Icon" then
        local textLabel = value38:FindFirstChildWhichIsA("TextLabel")

        if textLabel and textLabel.Text then
          local v71 = tonumber(textLabel.Text)

          if v71 ~= nil then
            table.insert(list12, v71)
          end
        end
      end
    end

    return list12
  end

  local function f52()
    local v72 = f51()
    local v73 = #v72 ~= #v69

    if not v73 then
      for j = 1, #v72 do
        if v72[j] ~= v69[j] then
          v73 = true
          break
        end
      end
    end

    if v73 then
      v69 = v72
      return true, v72
    end

    return false, v69
  end

  local function f53(p41, p42)
    local list13 = {}

    if #p41 == 0 then
      return list13
    end

    for k = 1, p42 do
      local text = ""

      for m = 1, 5 do
        text = text .. tostring(p41[math.random(1, #p41)])
      end

      table.insert(list13, text)
    end

    return list13
  end

  local function f54(p43)
    f2(function()
      replicatedStorage:WaitForChild("RemotesFolder"):WaitForChild("PL"):FireServer(p43)
    end, "Try Code")
  end

  local function f55(text2, p44, p45)
    if tick() - v70 < 2 then
      return
    end

    v70 = tick()

    f2(function()
      window:Notify({ Text = text2, Duration = p44 or 3, Type = p45 or "Success" })
    end, "Notification")
  end

  local function f56()
    f2(function()
      if not f49() then
        f55("[Room 50]: You're not in Room 50!", 5, "Warning")
        v67 = false
        return
      end

      local _, v74 = f52()

      if #v74 == 0 then
        f55("[Room 50]: No books collected! Get at least one hint book first.", 5, "Warning")
        v67 = false
        return
      end

      f55(string.format(
        "[Room 50]: Solver active! %d hints: [%s]", #v74, table.concat(v74, ", ")
      ), 5, "Success")

      local v75 = tick()
      local count = 0
      local v76 = tick()
      local v77 = tick()

      while v67 do
        if tick() - v77 >= 0.5 then
          v77 = tick()
          local v78, v79 = f52()

          if v78 then
            f55(string.format(
              "[Room 50]: Hints updated! %d hints: [%s]", #v79, table.concat(v79, ", ")
            ), 3, "Success")
          end
        end

        if not f50() then
          if tick() - v76 >= 5 then
            f55("[Room 50]: Too far from door! Move closer.", 3, "Warning")
            v76 = tick()
          end

          task.wait(1)
        else
          for _, value39 in ipairs((f53(v69, 25))) do
            if not v67 then
              break
            end

            f54(value39)
            count = count + 1
          end

          if count % 1000 == 0 then
            local v80 = tick()

            f55(string.format(
              "[Room 50]: %d codes tried (%.0f/sec) | Hints: [%s]", count, count / (v80 - v75),
              table.concat(v69, ", ")
            ), 3, "Success")
          end

          task.wait(0.01)
        end
      end
    end, "Room 50 Solver Main")
  end

  hotelTab:Toggle("Room 50 Code Solver", false, function(p46)
    f2(function()
      v67 = p46

      if p46 then
        v69 = {}
        v68 = task.spawn(f56)
      else
        if v68 then
          task.cancel(v68)
          v68 = nil
        end

        f55("[Room 50]: Solver stopped", 2, "Warning")
      end
    end, "Room 50 Solver Toggle")
  end, "Auto-solves Room 50 by trying combinations from your hint books")
end)

f3("Floor - Mines tab", function()
  if value ~= "Mines" then
    return
  end

  local minesTab = floorCategory:CreateTab("Mines", "⛏️")
  local list14 = {}

  minesTab:Toggle("Anticheat Bypass", v3.minesAnticheat, function(p47)
    f2(function()
      v25 = p47
      v3.minesAnticheat = p47

      if p47 then
        for _, value40 in pairs(workspace.CurrentRooms:GetChildren()) do
          f2(function()
            local findFirstChild10 = value40:FindFirstChild("Ladder", true)

            if findFirstChild10 then
              local highlight = Instance.new("Highlight")
              highlight.FillColor = Color3.fromRGB(0, 100, 255)
              highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
              highlight.FillTransparency = 0.5
              highlight.OutlineTransparency = 0
              highlight.Parent = findFirstChild10

              table.insert(list14, highlight)
            end
          end, "Mines Bypass - Ladder ESP")
        end

        v29 = task.spawn(function()
          while v25 do
            task.wait(0.1)

            f2(function()
              local character19 = localPlayer.Character

              if character19 then
                if character19:GetAttribute("Climbing") == true then
                  window:Notify({
                    Text = "[Bypass]: Wait 2 seconds, don't move",
                    Duration = 2,
                    Type = "Warning",
                  })

                  task.wait(0.5)
                  character19:SetAttribute("Climbing", false)
                end
              end
            end, "Mines Bypass Loop")
          end
        end)
      else
        if v29 then
          task.cancel(v29)
          v29 = nil
        end

        for _, value41 in pairs(list14) do
          f2(function()
            if value41 and value41.Parent then
              value41:Destroy()
            end
          end, "Remove Ladder ESP")
        end

        list14 = {}
      end
    end, "Mines Anticheat Bypass Toggle")
  end, "Prevents ladder detection anticheat")

  local v81
  local seen = {}

  minesTab:Toggle("Anti Giggle", false, function(p48)
    f2(function()
      if p48 then
        seen = {}

        v81 = task.spawn(function()
          while p48 do
            f2(function()
              local currentRooms9 = workspace:FindFirstChild("CurrentRooms")

              if not currentRooms9 then
                return
              end

              for _, value42 in pairs(currentRooms9:GetChildren()) do
                f2(function()
                  local findFirstChild11 = value42:FindFirstChild("GiggleCeiling", true)

                  if findFirstChild11 then
                    local hitbox3 = findFirstChild11:FindFirstChild("Hitbox")

                    if hitbox3 and hitbox3:IsA("BasePart") and not seen[hitbox3] then
                      hitbox3.CanQuery = false
                      hitbox3.CanTouch = false
                      seen[hitbox3] = true
                    end
                  end
                end, "Anti Giggle - Room")
              end
            end, "Anti Giggle Loop")

            task.wait(1)
          end
        end)

        window:Notify({ Text = "Anti Giggle enabled!", Duration = 2, Type = "Success" })
      else
        if v81 then
          task.cancel(v81)
          v81 = nil
        end

        seen = {}
        window:Notify({ Text = "Anti Giggle disabled.", Duration = 2, Type = "Warning" })
      end
    end, "Anti Giggle Toggle")
  end, "Disables GiggleCeiling hitbox detection")
end)

f3("Floor - Backdoor tab", function()
  if value ~= "Backdoor" then
    return
  end

  local backdoorTab = floorCategory:CreateTab("Backdoor", "🚪")
  local v82 = false
  local v83
  local huge = math.huge

  backdoorTab:Toggle("Timer Notify", false, function(p49)
    f2(function()
      v82 = p49

      if p49 then
        huge = math.huge

        v83 = task.spawn(function()
          while v82 do
            task.wait(0.25)

            f2(function()
              local floorReplicated = replicatedStorage:FindFirstChild("FloorReplicated")

              if not floorReplicated then
                return
              end

              local digitalTimer = floorReplicated:FindFirstChild("DigitalTimer")

              if not digitalTimer then
                return
              end

              local value43 = digitalTimer.Value
              local v84 = math.floor(value43 / 5) * 5

              if v84 ~= huge then
                if v84 < huge then
                  local type = "Success"

                  if v84 <= 10 then
                    type = "Error"
                  elseif v84 <= 25 then
                    type = "Warning"
                  end

                  window:Notify({
                    Text = "⏱ Time left: " .. tostring(v84),
                    Duration = 3,
                    Type = type,
                  })
                end

                huge = v84
              end
            end, "Timer Notify Loop")
          end
        end)

        window:Notify({ Text = "Timer Notify enabled!", Duration = 2, Type = "Success" })
      else
        if v83 then
          task.cancel(v83)
          v83 = nil
        end

        huge = math.huge
        window:Notify({ Text = "Timer Notify disabled.", Duration = 2, Type = "Warning" })
      end
    end, "Timer Notify Toggle")
  end, "Notifies every 5 seconds of remaining Backdoor time")
end)

f3("Floor - Garden tab", function()
  if value ~= "Garden" then
    return
  end

  local gardenTab = floorCategory:CreateTab("Garden", "🌿")
  local v85, v86

  if flag then
    v85 = false
    v86 = false

    gardenTab:Toggle("Anti Surge", false, function(p50)
      f2(function()
        v85 = p50

        if p50 and not v86 then
          local ok10, result9 = pcall(function()
            local waitForChild2 = replicatedStorage:WaitForChild("RemotesFolder"):WaitForChild(
              "SurgeRemote", 10
            )

            if not waitForChild2 then
              error("SurgeRemote not found")
            end

            local v87 = hookfunction or replaceclosure

            if not v87 then
              error("No hook function available")
            end

            local v88

            v88 = v87(getrawmetatable(game).__namecall, function(p51, ...)
              if getnamecallmethod() == "FireServer" and p51 == waitForChild2 and v85 then
                return
              end

              return v88(p51, ...)
            end)

            v86 = true
          end)

          if ok10 then
            window:Notify({ Text = "✅ Anti Surge enabled!", Duration = 3, Type = "Success" })
          else
            v85 = false

            window:Notify({
              Text = "❌ Anti Surge failed: " .. tostring(result9),
              Duration = 6,
              Type = "Error",
            })
          end
        elseif not p50 then
          window:Notify({ Text = "Anti Surge disabled.", Duration = 2, Type = "Warning" })
        end
      end, "Anti Surge Toggle")
    end, "Blocks SurgeRemote FireServer on Garden floor")
  else
    gardenTab:Label("❌ Anti Surge — requires hook support (unsupported executor)")
  end
end)

f3("Floor - Party tab", function()
  if value ~= "Party" then
    return
  end

  local rankedTab = floorCategory:CreateTab("Ranked", "🎉")

  rankedTab:Toggle("Boostpad Reach", false, function(p52)
    f2(function()
      local currentRooms10 = workspace:FindFirstChild("CurrentRooms")

      if not currentRooms10 then
        window:Notify({ Text = "CurrentRooms not found", Duration = 3, Type = "Error" })
        return
      end

      for _, value44 in pairs(currentRooms10:GetChildren()) do
        f2(function()
          local itemPads = value44:FindFirstChild("ItemPads")

          if not itemPads then
            return
          end

          for _, value45 in pairs(itemPads:GetChildren()) do
            f2(function()
              local hitBox = value45:FindFirstChild("HitBox")

              if hitBox and hitBox:IsA("BasePart") then
                hitBox.Size = p52 and Vector3.new(25, 25, 25) or Vector3.new(1, 1, 1)
              end
            end, "Boostpad HitBox")
          end
        end, "Boostpad Room")
      end

      window:Notify({
        Text = p52 and "Boostpad Reach enabled!" or "Boostpad Reach disabled.",
        Duration = 2,
        Type = p52 and "Success" or "Warning",
      })
    end, "Boostpad Reach Toggle")
  end, "Expands boostpad hitboxes to 25x25x25")

  local v89 = false
  local v90

  rankedTab:Toggle("Item ESP", false, function(p53)
    f2(function()
      v89 = p53

      if not p53 then
        if v90 then
          task.cancel(v90)
          v90 = nil
        end

        local drops = workspace:FindFirstChild("Drops")

        if drops then
          for _, value46 in pairs(drops:GetDescendants()) do
            if value46:IsA("Highlight") and value46.Name == "ItemESP" then
              value46:Destroy()
            end
          end
        end

        return
      end

      v90 = task.spawn(function()
        while v89 do
          f2(function()
            local drops2 = workspace:FindFirstChild("Drops")

            if not drops2 then
              return
            end

            for _, value47 in pairs(drops2:GetChildren()) do
              if value47:IsA("Model") then
                if value47.Name ~= "GoldPile" then
                  if not value47:FindFirstChild("ItemESP") then
                    local itemESP = Instance.new("Highlight")
                    itemESP.Name = "ItemESP"
                    itemESP.FillColor = Color3.fromRGB(0, 200, 255)
                    itemESP.OutlineColor = Color3.fromRGB(0, 150, 200)
                    itemESP.FillTransparency = 0.4
                    itemESP.OutlineTransparency = 0
                    itemESP.Parent = value47
                  end
                end
              end
            end
          end, "Item ESP Loop")

          task.wait(0.5)
        end
      end)
    end, "Item ESP Toggle")
  end, "Highlights items in Drops (skips GoldPile)")
end)

f3("ESP system", function()
  v22 = {
    Door = false,
    Objective = false,
    Entity = false,
    Player = false,
  }

  map2 = {}

  function f39(instance17, p54)
    if not instance17 then
      return true
    end

    for _, value48 in pairs(instance17:GetChildren()) do
      if (value48:IsA("Highlight") or value48:IsA("BillboardGui"))
        and value48.Name == p54 .. "ESP" then
        return true
      end
    end

    return false
  end

  function f6(key5)
    f2(function()
      if map2[key5] then
        for _, value49 in pairs(map2[key5]) do
          if value49 and value49.Parent then
            value49:Destroy()
          end
        end

        map2[key5] = {}
      end
    end, "Clear ESP - " .. key5)
  end

  function f40(parent3, key6, p55, outlineColor, text3)
    f2(function()
      if not parent3 or f39(parent3, key6) then
        return
      end

      if not map2[key6] then
        map2[key6] = {}
      end

      local highlight2 = Instance.new("Highlight")
      highlight2.Name = key6 .. "ESP"
      highlight2.FillColor = p55
      highlight2.OutlineColor = outlineColor
      highlight2.FillTransparency = 0.5
      highlight2.OutlineTransparency = 0
      highlight2.Parent = parent3

      table.insert(map2[key6], highlight2)

      if text3 then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = key6 .. "ESP"
        billboardGui.AlwaysOnTop = true
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.Parent = parent3

        local textLabel2 = Instance.new("TextLabel")
        textLabel2.Size = UDim2.new(1, 0, 1, 0)
        textLabel2.BackgroundTransparency = 1
        textLabel2.Text = text3
        textLabel2.TextColor3 = p55
        textLabel2.TextStrokeTransparency = 0
        textLabel2.TextScaled = true
        textLabel2.Font = Enum.Font.GothamBold
        textLabel2.Parent = billboardGui

        table.insert(map2[key6], billboardGui)
      end
    end, "Add ESP - " .. key6)
  end

  function create()
    f2(function()
      for _, value50 in pairs(workspace.CurrentRooms:GetChildren()) do
        f2(function()
          local door3 = value50:FindFirstChild("Door")

          if door3 and door3:IsA("Model") then
            f40(door3, "Door", Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 200, 0), nil)
          end
        end, "Create Door ESP")
      end
    end, "Create Door ESP")
  end

  function create2()
    f2(function()
      for _, value51 in pairs(workspace.CurrentRooms:GetChildren()) do
        f2(function()
          for _, value52 in pairs(value51:GetDescendants()) do
            local v91 = ({
              KeyObtain = "Key",
              FuseObtain = "Fuse",
              FuseHolder = "Fuse",
              LiveHintBook = "Book",
              LeverForGate = "Lever",
              LiveBreakerPolePickup = "Breaker",
              TimerLever = "Timer",
              Padlock = "Lock",
            })[value52.Name]

            if v91 then
              f40(
                value52, "Objective", Color3.fromRGB(255, 255, 0), Color3.fromRGB(200, 200, 0),
                v91
              )
            end
          end
        end, "Create Objective ESP")
      end
    end, "Create Objective ESP")
  end

  function create3()
    f2(function()
      local v92 = {
        RushMoving = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(200, 0, 0), "RUSH" },
        AmbushMoving = { Color3.fromRGB(255, 100, 0), Color3.fromRGB(200, 80, 0), "AMBUSH" },
        Eyes = { Color3.fromRGB(150, 0, 255), Color3.fromRGB(120, 0, 200), "EYES" },
        Halt = { Color3.fromRGB(0, 200, 255), Color3.fromRGB(0, 150, 200), "HALT" },
        Screech = { Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200), "SCREECH" },
        A60 = { Color3.fromRGB(255, 50, 50), Color3.fromRGB(200, 30, 30), "A60" },
        A120 = { Color3.fromRGB(255, 50, 50), Color3.fromRGB(200, 30, 30), "A120" },
      }

      for _, value53 in pairs(workspace:GetChildren()) do
        f2(function()
          local v93 = v92[value53.Name]

          if v93 and value53:IsA("Model") then
            f40(value53, "Entity", v93[1], v93[2], v93[3])
          end
        end, "Entity ESP - Workspace")
      end

      for _, value54 in pairs(workspace.CurrentRooms:GetChildren()) do
        f2(function()
          local figureSetup2 = value54:FindFirstChild("FigureSetup")

          if figureSetup2 then
            local figureRig2 = figureSetup2:FindFirstChild("FigureRig")

            if figureRig2 then
              f40(
                figureRig2, "Entity", Color3.fromRGB(255, 0, 0), Color3.fromRGB(200, 0, 0),
                "FIGURE"
              )
            end
          end

          local seekSetup = value54:FindFirstChild("SeekSetup")
            or value54:FindFirstChild("Seek")

          if seekSetup then
            local seekRig = seekSetup:FindFirstChild("SeekRig")
              or seekSetup:FindFirstChild("Seek") or seekSetup

            if seekRig and seekRig:IsA("Model") then
              f40(
                seekRig, "Entity", Color3.fromRGB(0, 0, 0), Color3.fromRGB(100, 100, 100),
                "SEEK"
              )
            end
          end

          local assets4 = value54:FindFirstChild("Assets")

          if assets4 then
            for _, value55 in pairs(assets4:GetChildren()) do
              if value55.Name == "Snare" then
                f40(
                  value55, "Entity", Color3.fromRGB(255, 100, 100), Color3.fromRGB(200, 80, 80),
                  "SNARE"
                )
              end
            end
          end
        end, "Entity ESP - Room")
      end
    end, "Create Entity ESP")
  end

  function f41()
    f2(function()
      for key7, value56 in pairs(map2) do
        local list15 = {}

        for _, value57 in pairs(value56) do
          if value57 and value57.Parent then
            table.insert(list15, value57)
          end
        end

        map2[key7] = list15
      end
    end, "Cleanup Destroyed ESP")
  end

  function create4()
    f2(function()
      for _, value58 in pairs(players:GetPlayers()) do
        f2(function()
          if value58 == players.LocalPlayer then
            return
          end

          local character20 = value58.Character

          if character20 then
            f40(
              character20, "Player", Color3.fromRGB(255, 255, 255),
              Color3.fromRGB(200, 200, 200), value58.Name
            )
          end
        end, "Player ESP - " .. value58.Name)
      end
    end, "Create Player ESP")
  end

  function f9()
    if v34 then
      task.cancel(v34)
    end

    v34 = task.spawn(function()
      while v22.Door or v22.Objective or v22.Entity or v22.Player do
        task.wait(0.5)
        f41()

        if v22.Door then
          create()
        end

        if v22.Objective then
          create2()
        end

        if v22.Entity then
          create3()
        end

        if v22.Player then
          create4()
        end
      end
    end)
  end

  espTab:Dropdown("ESP Types", { "Door", "Objective", "Entity", "Player" }, function(p56)
    f2(function()
      for _, value59 in ipairs({
        { key = "Door", setting = "espDoor", create = create },
        { key = "Objective", setting = "espObjective", create = create2 },
        { key = "Entity", setting = "espEntity", create = create3 },
        { key = "Player", setting = "espPlayer", create = create4 },
      }) do
        if p56[value59.key] and not v22[value59.key] then
          v22[value59.key] = true
          v3[value59.setting] = true
          value59.create()
          f9()
        elseif not p56[value59.key] and v22[value59.key] then
          v22[value59.key] = false
          v3[value59.setting] = false
          f6(value59.key)
        end
      end

      if not v22.Door and not v22.Objective and not v22.Entity and not v22.Player then
        if v34 then
          task.cancel(v34)
          v34 = nil
        end
      end
    end, "ESP Dropdown")
  end, "Select ESP types to enable")
end)

f3("Entity Notifier & FOV", function()
  v23 = false
  local v94 = {}

  espTab:Toggle("Entity Notifier", v3.entityNotifier, function(p57)
    f2(function()
      v23 = p57
      v3.entityNotifier = p57

      if not p57 then
        v94 = {}
      end
    end, "Entity Notifier Toggle")
  end, "Get notified when entities spawn")

  task.spawn(function()
    local list16 = {
      { name = "RushMoving", text = "⚡ Rush is coming!", type = "Error" },
      { name = "AmbushMoving", text = "⚡ Ambush is coming!", type = "Error" },
      { name = "Eyes", text = "👁️ Eyes has appeared!", type = "Error" },
      { name = "Halt", text = "🛑 Halt has appeared!", type = "Warning" },
    }

    while true do
      task.wait(0.5)

      if v23 then
        f2(function()
          for _, value60 in ipairs(list16) do
            local findFirstChild12 = workspace:FindFirstChild(value60.name)

            if findFirstChild12 and not v94[value60.name] then
              v94[value60.name] = true
              window:Notify({ Text = value60.text, Duration = 5, Type = value60.type })
            elseif not findFirstChild12 and v94[value60.name] then
              v94[value60.name] = nil
            end
          end
        end, "Entity Notifier Loop")
      end
    end
  end)

  local fov = v3.fov

  local connect5 = runService.RenderStepped:Connect(function()
    f2(function()
      local currentCamera2 = workspace.CurrentCamera

      if currentCamera2 and currentCamera2.FieldOfView ~= fov then
        currentCamera2.FieldOfView = fov
      end
    end, "FOV RenderStepped")
  end)

  displayTab:Slider("FOV", 70, 120, v3.fov, function(fov2)
    f2(function()
      fov = fov2
      v3.fov = fov2
    end, "FOV Slider")
  end, "Adjust field of view")

  getgenv()._RoshanHubFovConn = connect5
end)

f3("Settings UI", function()
  settingsCategory:ThemePicker("UI Theme", function(theme, p58)
    f2(function()
      v3.theme = theme
      window:Notify({ Text = "Theme changed to " .. theme, Duration = 2, Type = "Success" })
    end, "Theme Picker")
  end, "Choose UI color theme")

  settingsCategory:Keybind(
    "Toggle UI Key", Enum.KeyCode.RightShift, function(p59, p60) end,
    "Key to open/close the hub"
  )

  settingsCategory:Toggle("Auto Load Settings", v3.autoLoad, function(autoLoad)
    f2(function()
      v3.autoLoad = autoLoad
      f21()
    end, "Auto Load Settings Toggle")
  end, "Automatically load settings on script start")

  settingsCategory:Button("Save Settings", function()
    f2(function()
      if f21() then
        window:Notify({ Text = "✅ Settings saved!", Duration = 2, Type = "Success" })
      else
        window:Notify({ Text = "Failed to save settings", Duration = 2, Type = "Error" })
      end
    end, "Save Settings Button")
  end, "Save current settings to file")

  settingsCategory:Button("Load Settings", function()
    f2(function()
      if f22() then
        window:Notify({ Text = "✅ Settings loaded!", Duration = 3, Type = "Success" })
      else
        window:Notify({ Text = "No saved settings found", Duration = 2, Type = "Warning" })
      end
    end, "Load Settings Button")
  end, "Load settings from file")
end)

f3("Destroy function", function()
  function f7()
    f2(function()
      if connect2 then
        connect2:Disconnect()
      end

      if getgenv()._RoshanHubFovConn then
        getgenv()._RoshanHubFovConn:Disconnect()
      end

      for _, _ in ipairs({ v26, v38, v24, v29, v36, v31, v32, v27, v34, v30, v28, v37, v35, v33 }) do
      end

      if connect then
        connect:Disconnect()
      end

      f6("Door")
      f6("Objective")
      f6("Entity")
      f6("Player")

      local character21 = localPlayer and localPlayer.Character

      if character21 then
        local humanoid11 = character21:FindFirstChild("Humanoid")

        if humanoid11 then
          humanoid11.WalkSpeed = walkSpeed
        end

        local humanoidRootPart21 = character21:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart21 then
          humanoidRootPart21.CustomPhysicalProperties = customPhysicalProperties
        end

        if collisionClone then
          collisionClone:Destroy()
        end

        if flag2 then
          f8(character21)
        end
      end

      if v9 then
        for key8, value61 in pairs(map) do
          lighting[key8] = value61
        end
      end

      if v12 and parent then
        local screech2 = replicatedStorage.Entities:FindFirstChild("Screech")

        if screech2 then
          screech2.Parent = parent
        end
      end

      getgenv().ZeScriptLoaded = false
      getgenv()._RoshanHubFovConn = nil

      window:Notify({ Text = "🗑️ Hub destroyed! Goodbye!", Duration = 3, Type = "Warning" })
      task.wait(0.5)

      if window.Destroy then
        window:Destroy()
      end
    end, "Destroy Script")
  end

  settingsCategory:Button(
    "Destroy Hub", function() f7() end, "Remove hub and restore all original settings"
  )

  settingsCategory:Button("Reset All Settings", function()
    f2(function()
      v3 = {
        spoofCrouch = false,
        antiEyes = false,
        disableScreech = false,
        disableSnare = false,
        objectBypass = false,
        noAccel = false,
        autoProxi = false,
        autoProxiInstant = true,
        autoProxiKey = "R",
        proximityReach = 0,
        doorReach = false,
        doorReachDistance = 25,
        antiSpeedBypass = false,
        speed = false,
        speedValue = 16,
        minesAnticheat = false,
        espDoor = false,
        espObjective = false,
        espEntity = false,
        entityNotifier = false,
        fullbright = false,
        fov = 70,
        theme = "Purple",
        autoLoad = false,
        godMode = false,
      }

      window:Notify({ Text = "Settings reset to defaults!", Duration = 2, Type = "Success" })
    end, "Reset All Settings Button")
  end, "Reset all settings to default values")

  settingsCategory:Button(
    "Hide UI", function() f2(function() window:Hide() end, "Hide UI Button") end,
    "Hide UI — press RightShift to show again"
  )
end)

f3("Credits & Version", function()
  settingsCategory:Label("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  settingsCategory:Label("🌹 Roshan Doors Page Hub  v2.0")
  settingsCategory:Label("Floor detected: " .. value)
  settingsCategory:Label("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  settingsCategory:Label("📚 UI Library by: XasonYTB")
  settingsCategory:Label("⚡ Original Script by: ZeScript")
  settingsCategory:Label("🌹 Hub Edition by: Roshan")
  settingsCategory:Label("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end)

f3("Auto load", function()
  if v3.autoLoad then
    if f22() then
      window:Notify({ Text = "✅ Auto-loaded settings!", Duration = 2, Type = "Success" })
    end
  end
end)

task.spawn(function()
  pcall(function()
    if writefile then
      writefile(v1, [[
=== Roshan Hub Load Log ===
]])
    end
  end)

  for index, value62 in ipairs(list) do
    local v95 = list2[index] or "Phase " .. index
    f1("[Phase " .. index .. "/" .. #list .. "] Starting: " .. v95)
    local ok11, result10 = pcall(value62)

    if not ok11 then
      local text4 = "[Phase " .. index .. " FAILED] " .. v95 .. ": " .. tostring(result10)
      f1(text4)
      pcall(function() window:Notify({ Text = text4, Duration = 10, Type = "Error" }) end)
    else
      f1("[Phase " .. index .. "] OK: " .. v95)
    end

    task.wait()
  end

  f1("[RoshanHub] All phases complete.")
  wait(0.2)
  window:Show()
end)
