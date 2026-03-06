local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Method 1: Renaming the Humanoid
-- Many Roblox games use a simple `hit.Parent:FindFirstChild("Humanoid")` check.
-- Renaming your Humanoid can sometimes bypass monster attacks.
local function protectCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Name = "SafeHumanoid"
    end
end

if LocalPlayer.Character then
    protectCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(protectCharacter)

-- Method 2: Removing Monster Hitboxes or Damage Parts
-- This will continuously check the workspace for monsters and remove their hitboxes.
-- You will need to change "Monster" and "Hitbox" to the actual names used in Cultivation Simulator.
task.spawn(function()
    while task.wait(2) do
        -- Iterate through all objects in the workspace
        for _, obj in ipairs(workspace:GetDescendants()) do
            -- Change "Monster" to the name of the enemy models in the game
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
                -- Option A: Destroy the monster's weapon or hitbox part
                local weapon = obj:FindFirstChild("Weapon")
                local hitbox = obj:FindFirstChild("Hitbox")
                
                if weapon then weapon:Destroy() end
                if hitbox then hitbox:Destroy() end
                
                -- Option B: Disable the monster's TouchInterest if they do damage on touch
                for _, part in ipairs(obj:GetDescendants()) do
                    if part:IsA("TouchTransmitter") then
                        part:Destroy()
                    end
                end
            end
        end
    end
end)

-- Method 3: Position Spoofing (Teleporting slightly away when a monster is near)
-- This requires more complex logic, but here is a simple example of keeping distance:
-- (Uncomment to use)
--[[
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = LocalPlayer.Character.HumanoidRootPart
    
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
            local enemyRoot = obj:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                local distance = (rootPart.Position - enemyRoot.Position).Magnitude
                if distance < 10 then -- If enemy is closer
