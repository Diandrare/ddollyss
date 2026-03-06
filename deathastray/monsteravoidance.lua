local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Method 1: Renaming the Humanoid (Safe Version)
local function protectCharacter(character)
    if not character then return end
    
    -- Use a protected call to wait for the humanoid safely
    task.spawn(function()
        local success, humanoid = pcall(function()
            return character:WaitForChild("Humanoid", 5)
        end)
        
        if success and humanoid and humanoid:IsA("Humanoid") then
            humanoid.Name = "SafeHumanoid"
        end
    end)
end

-- Protect current character
if LocalPlayer.Character then
    protectCharacter(LocalPlayer.Character)
end
-- Protect future characters when you respawn
LocalPlayer.CharacterAdded:Connect(protectCharacter)


-- Method 2: Safely removing Monster Hitboxes/Damage Parts
task.spawn(function()
    while task.wait(2) do
        -- Wrapped in pcall to prevent executor crashes
        pcall(function()
            -- Only scan the direct children of workspace to reduce lag, 
            -- or use a specific folder if the game stores enemies in one (e.g. workspace.Enemies)
            for _, obj in ipairs(workspace:GetDescendants()) do
                
                -- Check if it's a character model but NOT the player
                if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                    local isEnemy = obj:FindFirstChild("Humanoid")
                    
                    if isEnemy then
                        -- Remove TouchTransmitters (usually how games detect hits)
                        for _, part in ipairs(obj:GetDescendants()) do
                            if part:IsA("TouchTransmitter") then
                                pcall(function() part:Destroy() end)
                            end
                        end
                        
                        -- Destroy specific parts if they exist
                        local weapon = obj:FindFirstChild("Weapon")
                        if weapon then
                            pcall(function() weapon:Destroy() end)
                        end
                        
                        local hitbox = obj:FindFirstChild("Hitbox")
                        if hitbox then
                            pcall(function() hitbox:Destroy() end)
                        end
                    end
                end
                
            end
        end)
    end
end)
