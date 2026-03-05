local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Create the UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyFloatUI"
screenGui.ResetOnSpawn = false -- This keeps the UI alive during transitions
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.8, -50)
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Float Toggle (Height 30)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 160, 0, 40)
toggleButton.Position = UDim2.new(0.5, -80, 0.5, -5)
toggleButton.Text = "Turn ON"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

-- 2. State & Logic
local isFloating = false
local floatPart = nil

local function cleanupPlatform()
    if floatPart then
        floatPart:Destroy()
        floatPart = nil
    end
end

local function toggleFloat()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    isFloating = not isFloating
    
    if isFloating then
        toggleButton.Text = "Turn OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        
        cleanupPlatform()
        
        floatPart = Instance.new("Part")
        floatPart.Name = "FloatPlatform"
        floatPart.Size = Vector3.new(50, 1, 50) -- Made it even bigger for safety
        floatPart.Anchored = true
        floatPart.Transparency = 1
        floatPart.CanCollide = true
        
        -- Set position at height 30
        local currentPos = humanoidRootPart.Position
        floatPart.Position = Vector3.new(currentPos.X, 30, currentPos.Z)
        floatPart.Parent = workspace
        
        -- Teleport player
        humanoidRootPart.CFrame = CFrame.new(floatPart.Position + Vector3.new(0, 3, 0))
    else
        toggleButton.Text = "Turn ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        cleanupPlatform()
    end
end

-- 3. AUTO-RESTART FIX
-- This part detects when you enter a new dungeon and resets the state so you don't fall
player.CharacterAdded:Connect(function()
    if isFloating then
        -- Wait a tiny bit for the dungeon to load, then put the floor back
        task.wait(1)
        isFloating = false -- Reset state so toggleFloat turns it back "on"
        toggleFloat()
    end
end)

toggleButton.MouseButton1Click:Connect(toggleFloat)
