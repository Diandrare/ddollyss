local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Create the UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyFloatUI"
screenGui.ResetOnSpawn = false
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

local function toggleFloat()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    isFloating = not isFloating
    
    if isFloating then
        -- Update UI
        toggleButton.Text = "Turn OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        
        -- Clean up old platform if it exists
        if floatPart then
            floatPart:Destroy()
        end
        
        -- Create a large invisible platform for the player to stand on
        floatPart = Instance.new("Part")
        floatPart.Name = "FloatPlatform"
        floatPart.Size = Vector3.new(25, 1, 25) -- Big enough to move around a little
        floatPart.Anchored = true
        floatPart.Transparency = 1 -- Fully invisible
        floatPart.CanCollide = true
        
        -- Set position to your current X/Z, but exactly at height 30
        local currentPos = humanoidRootPart.Position
        floatPart.Position = Vector3.new(currentPos.X, 30, currentPos.Z)
        floatPart.Parent = workspace
        
        -- Teleport player slightly above the platform so they land safely on it
        humanoidRootPart.CFrame = CFrame.new(floatPart.Position + Vector3.new(0, 3, 0))
        
    else
        -- Update UI
        toggleButton.Text = "Turn ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        
        -- Remove the platform so the player falls back down to the ground
        if floatPart then
            floatPart:Destroy()
            floatPart = nil
        end
    end
end

-- 3. Connect Button Click
toggleButton.MouseButton1Click:Connect(toggleFloat)
