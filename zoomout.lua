-- Far Zoom Script for Roblox by 79xv
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

if player.CameraMaxZoomDistance then
    player.CameraMaxZoomDistance = 100000 -- Set to a very high number
end

-- Kadang Kereset Jadi Gunain Loop
task.spawn(function()
    while task.wait(1) do
        if player.CameraMaxZoomDistance < 100000 then
            player.CameraMaxZoomDistance = 100000
        end
    end
end)
