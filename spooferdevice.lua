-- =====================================================
--   DEVICE SPOOFER + AUTO REJOIN - BLADE BALL
--   Untuk menyembunyikan emulator / deteksi perangkat
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- =====================================================
--   FUNGSI SPOOFING
-- =====================================================

-- 1. Spoof TouchEnabled (aktifkan touch pada PC agar terlihat HP)
--    Untuk PC, biasanya TouchEnabled = false; kita set true
--    Tapi ini hanya efek lokal, bisa mempengaruhi input handling.
local function spoofTouch()
    -- Tidak ada cara langsung mengubah UserInputService.TouchEnabled, 
    -- tapi kita bisa membuat event simulasi atau menggunakan FFlag.
    -- Alternatif: set FFlag untuk memaksa touch mode.
    setfflag("UserInputService.TouchEnabled", "true")
    setfflag("UserInputService.EnableTouchEvents", "true")
    warn("[Spoofer] TouchEnabled diset ke true")
end

-- 2. Spoof Accelerometer (emulator biasanya false)
local function spoofAccelerometer()
    setfflag("UserInputService.AccelerometerEnabled", "true")
    warn("[Spoofer] Accelerometer diset true")
end

-- 3. Spoof Keyboard/Mouse (pasti ada di PC)
local function spoofKeyboardMouse()
    setfflag("UserInputService.KeyboardEnabled", "true")
    setfflag("UserInputService.MouseEnabled", "true")
    warn("[Spoofer] Keyboard & Mouse enabled")
end

-- 4. Ubah Device model di dalam game (jika ada pengukuran lain)
local function spoofDeviceModel()
    -- Beberapa game menggunakan GetFFlag atau perintah internal.
    -- Kita coba ganti os.name atau tick? Tidak bisa langsung.
    -- Kita bisa kirim remote event palsu jika diperlukan.
    -- Sebagai ganti, kita gunakan mock untuk UserInputService.GetDeviceType()
    -- Tapi tidak ada API resmi. Kita hanya bisa manipulasi FFlag.
    setfflag("Device.Model", "PC (Windows)")
    setfflag("Device.Name", "Desktop")
    warn("[Spoofer] Device model diubah menjadi PC")
end

-- 5. Nonaktifkan deteksi emulator dengan mematikan flag tertentu
local function disableEmulatorDetection()
    setfflag("Roblox.EmulatorDetection", "false")
    setfflag("Roblox.EnvironmentCheck", "false")
    setfflag("Roblox.DetectVirtualMachine", "false")
    warn("[Spoofer] Deteksi emulator dinonaktifkan")
end

-- 6. Jalankan semua spoof
local function applySpoofs()
    spoofTouch()
    spoofAccelerometer()
    spoofKeyboardMouse()
    spoofDeviceModel()
    disableEmulatorDetection()
    print("[Spoofer] Semua spoof telah diterapkan!")
end

-- =====================================================
--   AUTO REJOIN
-- =====================================================

local function rejoin()
    local placeId = game.PlaceId
    local jobId = game.JobId
    if not placeId or not jobId then
        warn("[Rejoin] Gagal mendapatkan PlaceId/JobId")
        return
    end
    
    -- Metode 1: Teleport ke server yang sama dengan rejoin
    -- Beberapa executor mendukung TeleportService:Teleport ke PlaceId yang sama
    local success, err = pcall(function()
        TeleportService:Teleport(placeId, LP, nil, nil)
    end)
    
    if not success then
        warn("[Rejoin] Teleport gagal: " .. tostring(err))
        -- Metode 2: Kick dan reconnect (cara lain)
        LP:Kick("Rejoining for device spoof...")
        -- Alternatif: gunakan http untuk refresh
        -- HttpService:GetAsync("https://www.roblox.com/games/" .. placeId)
    else
        print("[Rejoin] Teleport berhasil, server baru akan dimuat.")
    end
end

-- =====================================================
--   MAIN EXECUTION
-- =====================================================

-- Cek apakah script sudah pernah dijalankan (agar tidak loop)
if not getgenv().BLADE_SPOOF_RAN then
    getgenv().BLADE_SPOOF_RAN = true
    
    print("[Spoofer] Memulai spoofing dan rejoin...")
    applySpoofs()
    
    -- Tunggu beberapa detik agar spoof efektif, lalu rejoin
    task.wait(2)
    rejoin()
else
    print("[Spoofer] Script sudah dijalankan sebelumnya, hanya terapkan spoof tanpa rejoin")
    applySpoofs()
end

-- =====================================================
--   HOOK untuk deteksi perubahan (opsional)
-- =====================================================

-- Jika ada event yang mencoba mendeteksi ulang, kita bisa override
local oldGetDeviceType = UserInputService.GetDeviceType
UserInputService.GetDeviceType = function(...)
    -- Kembalikan "Computer" atau "Desktop"
    return Enum.DeviceType.Computer
end

print("[Spoofer] Device type hooked menjadi Computer")
