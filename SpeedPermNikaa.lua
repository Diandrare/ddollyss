-- Walkspeed GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Input = Instance.new("TextBox")
local SetBtn = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- GUI Styling
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 128) -- Neon Green
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.1, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Speed Control"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

Input.Parent = Frame
Input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Input.Position = UDim2.new(0.1, 0, 0.35, 0)
Input.Size = UDim2.new(0.8, 0, 0, 30)
Input.Text = "100"
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextSize = 18

SetBtn.Parent = Frame
SetBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
SetBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
SetBtn.Size = UDim2.new(0.8, 0, 0, 25)
SetBtn.Text = "Set Speed"
SetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBtn.Font = Enum.Font.SourceSansBold

local player = game.Players.LocalPlayer
local currentSpeed = 100

local function updateSpeed()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
            
            -- Anti-reset connection
            local conn
            conn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if humanoid and humanoid.WalkSpeed ~= currentSpeed then
                    humanoid.WalkSpeed = currentSpeed
                end
            end)
        end
    end
end

SetBtn.MouseButton1Click:Connect(function()
    local s = tonumber(Input.Text)
    if s then
        currentSpeed = s
        updateSpeed()
    end
end)

-- Handle Respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    updateSpeed()
end)
