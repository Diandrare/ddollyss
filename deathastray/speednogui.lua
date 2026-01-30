local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local SPEED = 80 -- Change Speed N1k

-- Set initial speed
humanoid.WalkSpeed = SPEED

-- For Permanent Speed N1k
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if humanoid.WalkSpeed ~= SPEED then
        humanoid.WalkSpeed = SPEED
    end
end)

-- Handel Rspawn N1k
player.CharacterAdded:Connect(function(newChar)
    local newHum = newChar:WaitForChild("Humanoid")
    newHum.WalkSpeed = SPEED
    newHum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if newHum.WalkSpeed ~= SPEED then
            newHum.WalkSpeed = SPEED
        end
    end)
end)
