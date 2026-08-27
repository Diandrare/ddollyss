-- =====================================================
--   DEVICE SPOOFER + AUTO REJOIN - BLADE BALL
--   VERSI DELTA (ERROR FIXED)
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- =====================================================
--   CEK STATUS SCRIPT
-- =====================================================

if not getgenv().BLADE_SPOOF_RAN then
    getgenv().BLADE_SPOOF_RAN = true
else
    print("[Spoofer] Sudah dijalankan, skip rejoin")
end

-- =====================================================
--   SPOOFING DEVICE
-- =====================================================

-- Simpan fungsi asli (jika ada)
local originalGetDeviceType = UserInputService.GetDeviceType

-- Fungsi override yang aman
local function overrideDeviceType()
    pcall(function()
        -- Ganti method GetDeviceType agar selalu return Computer
        UserInputService.GetDeviceType = function()
            return Enum.DeviceType.Computer
        end
    end)
end

-- Fungsi spoof properti tambahan (hanya jika bisa)
local function spoofProperties()
    pcall(function()
        -- Coba set properti (mungkin readonly, tapi kita coba)
        UserInputService.TouchEnabled = false
        UserInputService.MouseEnabled = true
        UserInputService.KeyboardEnabled = true
        UserInputService.AccelerometerEnabled = false
    end)
end

-- Gabungkan semua spoof
local function applySpoof()
    overrideDeviceType()
    spoofProperties()
    print("[Spoofer] Device spoof applied")
end

-- =====================================================
--   AUTO REJOIN
-- =====================================================

local function doRejoin()
    local placeId = game.PlaceId
    if not placeId then
        warn("[Rejoin] PlaceId tidak ditemukan")
        return
    end
    
    local success, err = pcall(function()
        TeleportService:Teleport(placeId, LP)
    end)
    
    if not success then
        print("[Rejoin] Teleport gagal: " .. tostring(err))
        -- Fallback: kick
        LP:Kick("Rejoining for device spoof...")
    else
        print("[Rejoin] Teleport berhasil!")
    end
end

-- =====================================================
--   EKSEKUSI UTAMA
-- =====================================================

applySpoof()

-- Tunggu sebentar agar spoof efektif
task.wait(1.5)

if not getgenv().BLADE_SPOOF_RAN then
    doRejoin()
end

-- =====================================================
--   JAGA SPOOF TETAP AKTIF (HEARTBEAT HOOK)
-- =====================================================

RunService.Heartbeat:Connect(function()
    -- Re-apply spoof setiap frame untuk mengatasi reset
    pcall(function()
        if UserInputService.GetDeviceType ~= nil then
            UserInputService.GetDeviceType = function()
                return Enum.DeviceType.Computer
            end
        end
    end)
end)

print("[Spoofer] Script selesai, device di-spoof sebagai PC")
