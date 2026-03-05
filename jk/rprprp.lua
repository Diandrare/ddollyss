-- Init Toggles
getgenv().AutoPetEnabled = false
getgenv().AutoRuneEnabled = false
getgenv().AutoSellEnabled = false

-- Run Scripts in background
task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Diandrare/ddollyss/refs/heads/main/jk/pppp.lua"))()
    end)
    if not success then warn("Failed to load Pet.lua: " .. tostring(err)) end
end)

task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Diandrare/ddollyss/refs/heads/main/jk/rrrr.lua"))()
    end)
    if not success then warn("Failed to load Rune.lua: " .. tostring(err)) end
end)

-- Create UI
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Prevent duplicate UI
if CoreGui:FindFirstChild("SwiptUI_Toggle") then
    CoreGui.SwiptUI_Toggle:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwiptUI_Toggle"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main draggable frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 155)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Simple drag

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -70, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Auto Sort"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 40)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 16

CloseButton.MouseButton1Click:Connect(function()
    getgenv().AutoPetEnabled = false
    getgenv().AutoRuneEnabled = false
    getgenv().AutoSellEnabled = false
    ScreenGui:Destroy()
    print("❌ Swipt UI Terminated and Toggles Disabled")
end)

-- Open Button (Hidden by default)
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
OpenButton.Position = UDim2.new(0.5, -40, 0, 10)
OpenButton.Size = UDim2.new(0, 80, 0, 30)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Text = "Open UI"
OpenButton.TextColor3 = Color3.fromRGB(240, 240, 240)
OpenButton.TextSize = 14
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -55, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 40)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 24

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

-- Function to create a toggle
local function createToggle(name, yPos, globalVarName)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = name .. "Frame"
    ToggleFrame.Parent = MainFrame
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Position = UDim2.new(0, 0, 0, yPos)
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)

    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 20, 0, 0)
    Label.Size = UDim2.new(0, 150, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Parent = ToggleFrame
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.Position = UDim2.new(1, -60, 0.5, -12)
    Button.Size = UDim2.new(0, 40, 0, 24)
    Button.Font = Enum.Font.GothamBold
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 100, 100)
    Button.TextSize = 12
    Button.AutoButtonColor = false

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = Button

    -- Click Event
    Button.MouseButton1Click:Connect(function()
        local currentState = getgenv()[globalVarName]
        getgenv()[globalVarName] = not currentState
        
        if getgenv()[globalVarName] then
            Button.Text = "ON"
            Button.TextColor3 = Color3.fromRGB(100, 255, 100)
            Button.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
        else
            Button.Text = "OFF"
            Button.TextColor3 = Color3.fromRGB(255, 100, 100)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        end
    end)
    
    -- Init Check
    if getgenv()[globalVarName] then
        Button.Text = "ON"
        Button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Button.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
    end
end

-- Create the Toggles
createToggle("Pet", 50, "AutoPetEnabled")
createToggle("Rune", 80, "AutoRuneEnabled")
createToggle("Auto Sell All", 110, "AutoSellEnabled")

print("--- [ MainUI Loaded ] ---")
