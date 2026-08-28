-- ===== KONFIGURASI =====
local SPOOF_DEVICE = "PC"     
local AUTO_REJOIN = false      
local REJOIN_DELAY = 2        

if not SPOOF_DEVICE then return end

-- ===== FUNGSI SPOOF =====
local function applySpoof()
    local RS = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")

    -- Patch module UserInputService
    local wrap = nil
    pcall(function()
        wrap = require(RS:WaitForChild("UserInputService"))
    end)
    if wrap and type(wrap) == "table" then
        local flags = {
            PC = { TouchEnabled = false, MouseEnabled = true, KeyboardEnabled = true, GamepadEnabled = false },
            Phone = { TouchEnabled = true, MouseEnabled = false, KeyboardEnabled = false, GamepadEnabled = false },
            Console = { TouchEnabled = false, MouseEnabled = false, KeyboardEnabled = false, GamepadEnabled = true }
        }
        local f = flags[SPOOF_DEVICE]
        if f then
            for k, v in pairs(f) do
                rawset(wrap, k, v)
            end
        end
        local last = Enum.UserInputType.MouseMovement
        if SPOOF_DEVICE == "Console" then
            last = Enum.UserInputType.Gamepad1
        elseif SPOOF_DEVICE == "Phone" then
            last = Enum.UserInputType.Touch
        end
        rawset(wrap, "GetLastInputType", function()
            return last
        end)
    end

    -- Patch DeviceListener
    pcall(function()
        local DL = require(RS:WaitForChild("ClientGameModules"):WaitForChild("DeviceListener"))
        if DL then
            DL.Device = SPOOF_DEVICE
            if DL.State and DL.State.Set then
                DL.State:Set(SPOOF_DEVICE)
            end
            if DL.OnChange and DL.OnChange.Fire then
                DL.OnChange:Fire(SPOOF_DEVICE)
            end
        end
    end)

    -- Hook connections (jika support)
    if getconnections and getupvalue and setupvalue then
        pcall(function()
            for _, c in getconnections(UserInputService.LastInputTypeChanged) do
                local fn = c.Function
                if type(fn) == "function" then
                    local u1 = getupvalue(fn, 1)
                    local u2 = getupvalue(fn, 2)
                    if type(u1) == "function" and type(u2) == "table" and u2.OnChange then
                        setupvalue(fn, 1, function()
                            return SPOOF_DEVICE
                        end)
                    end
                end
            end
        end)
    end

    getgenv()._WindsSpoofDevice = SPOOF_DEVICE
    print("[Spoofer] Device set to: " .. SPOOF_DEVICE)
end

-- ===== FUNGSI REJOIN =====
local function doRejoin()
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local placeId = game.PlaceId
    if placeId then
        pcall(function()
            TeleportService:Teleport(placeId, LP)
        end)
        print("[Rejoin] Rejoin ke server baru...")
    else
        warn("[Rejoin] Gagal dapat PlaceId")
    end
end

-- ===== EKSEKUSI UTAMA =====
print("[Spoofer] Menerapkan spoof...")
applySpoof()

if AUTO_REJOIN then
    print("[Rejoin] Akan rejoin dalam " .. REJOIN_DELAY .. " detik...")
    task.wait(REJOIN_DELAY)
    doRejoin()
else
    print("[Spoofer] Selesai (tanpa rejoin)")
end

-- ===== PASTIKAN SPOOF BERTAHAN SETELAH TELEPORT =====
local function setupPersistence()
    local qot = syn and syn.queue_on_teleport or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    if type(qot) == "function" then
        qot([[
            local SPOOF_DEVICE = "]] .. SPOOF_DEVICE .. [["
            local function reapply()
                local RS = game:GetService("ReplicatedStorage")
                local wrap = nil
                pcall(function() wrap = require(RS:WaitForChild("UserInputService")) end)
                if wrap and type(wrap) == "table" then
                    local flags = {
                        PC = { TouchEnabled = false, MouseEnabled = true, KeyboardEnabled = true, GamepadEnabled = false },
                        Phone = { TouchEnabled = true, MouseEnabled = false, KeyboardEnabled = false, GamepadEnabled = false },
                        Console = { TouchEnabled = false, MouseEnabled = false, KeyboardEnabled = false, GamepadEnabled = true }
                    }
                    local f = flags[SPOOF_DEVICE]
                    if f then
                        for k, v in pairs(f) do
                            rawset(wrap, k, v)
                        end
                    end
                    local last = Enum.UserInputType.MouseMovement
                    if SPOOF_DEVICE == "Console" then last = Enum.UserInputType.Gamepad1
                    elseif SPOOF_DEVICE == "Phone" then last = Enum.UserInputType.Touch end
                    rawset(wrap, "GetLastInputType", function() return last end)
                end
                getgenv()._WindsSpoofDevice = SPOOF_DEVICE
                print("[Spoofer] Re-applied after teleport")
            end
            game:IsLoaded() and reapply() or game.Loaded:Connect(reapply)
        ]])
        print("[Spoofer] Persistence via queue_on_teleport registered")
    else
        pcall(function()
            local TeleportService = game:GetService("TeleportService")
            TeleportService.TeleportInitFinished:Connect(function()
                task.wait(1)
                applySpoof()
                print("[Spoofer] Re-applied via TeleportInitFinished")
            end)
            print("[Spoofer] Persistence via TeleportInitFinished registered")
        end)
    end
end

setupPersistence()

print("[Spoofer] Script selesai. Device: " .. SPOOF_DEVICE .. (AUTO_REJOIN and " (auto rejoin aktif)" or " (tanpa auto rejoin)"))
