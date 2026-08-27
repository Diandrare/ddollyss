-- =====================================================
--   DEVICE SPOOFER + AUTO REJOIN - BLADE BALL
--   VERSI KHUSUS DELTA EXECUTOR
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- =====================================================
--   CEK APAKAH SUDAH PERNAH DIJALANKAN
-- =====================================================

if not getgenv().BLADE_SPOOF_RAN then
    getgenv().BLADE_SPOOF_RAN = true
else
    print("[Spoofer] Sudah dijalankan sebelumnya, skip rejoin")
end

-- =====================================================
--   SPOOFING DEVICE (CARA YANG DIDUKUNG DELTA)
-- =====================================================

-- Delta TIDAK mendukung setfflag(), jadi kita pakai cara lain:
-- 1. Hook fungsi GetDeviceType
-- 2. Manipulasi properti UserInputService

local function spoofDevice()
    -- Override GetDeviceType agar selalu return Computer
    local oldGetDeviceType = UserInputService.GetDeviceType
    UserInputService.GetDeviceType = function(self)
        return Enum.DeviceType.Computer
    end
    print("[Spoofer] GetDeviceType di-hook => Computer")
    
    -- Coba manipulasi properti internal (jika ada)
    -- Beberapa executor mendukung ini
    pcall(function()
        UserInputService.TouchEnabled = false
        UserInputService.MouseEnabled = true
        UserInputService.KeyboardEnabled = true
        UserInputService.AccelerometerEnabled = false
    end)
    print("[Spoofer] Properti input diset ke mode PC")
end

-- =====================================================
--   AUTO REJOIN
-- =====================================================

local function rejoin()
    local placeId = game.PlaceId
    if not placeId then
        warn("[Rejoin] Gagal dapat PlaceId")
        return
    end
    
    -- Delta mendukung TeleportService:Teleport
    local success, err = pcall(function()
        TeleportService:Teleport(placeId, LP)
    end)
    
    if not success then
        print("[Rejoin] Teleport gagal, coba metode kick...")
        LP:Kick("Rejoining for device spoof...")
    else
        print("[Rejoin] Teleport berhasil!")
    end
end

-- =====================================================
--   EKSEKUSI UTAMA
-- =====================================================

print("[Spoofer] Menerapkan spoofing...")
spoofDevice()

-- Tunggu sebentar agar spoof efektif
task.wait(1.5)

if not getgenv().BLADE_SPOOF_RAN then
    print("[Spoofer] Melakukan rejoin...")
    rejoin()
else
    print("[Spoofer] Spoof sudah aktif, tidak perlu rejoin")
end

-- =====================================================
--   HOOK PERMANEN (AGAR TETAP AKTIF)
-- =====================================================

-- Jalankan di setiap frame untuk memastikan spoof tetap aktif
RunService.Heartbeat:Connect(function()
    -- Jika ada deteksi ulang, kita override lagi
    if UserInputService.GetDeviceType ~= spoofDevice then
        UserInputService.GetDeviceType = function()
            return Enum.DeviceType.Computer
        end
    end
end)

print("[Spoofer] Script selesai! Device sekarang terdeteksi sebagai PC.")
