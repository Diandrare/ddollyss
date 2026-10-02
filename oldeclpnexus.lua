-- ═══════════════════════════════════════════════════════════════
-- EclipseNexus v2.1 — BladeBall
-- patched: compat shim, namecall capture, live Alive/Runtime,
--          AP loop connection leak fix
-- ═══════════════════════════════════════════════════════════════

-- === COMPAT SHIM ===
-- normalize executor globals across modern executors
do
    local env = (type(getgenv) == "function" and getgenv()) or _G

    local function resolve(path)
        local a, b = path:match("^(.-)%.(.+)$")
        if a then
            local tbl = rawget(env, a)
            return tbl and rawget(tbl, b) or nil
        end
        return rawget(env, path)
    end

    local aliasMap = {
        getrawmetatable   = {"getrawmetatable", "debug.getmetatable"},
        setreadonly       = {"setreadonly", "debug.setreadonly"},
        getnamecallmethod = {"getnamecallmethod", "debug.getnamecallmethod"},
        newcclosure       = {"newcclosure", "debug.newcclosure"},
        hookfunction      = {"hookfunction", "replaceclosure", "hookfunc", "debug.hookfunction"},
        checkcaller       = {"checkcaller", "debug.checkcaller"},
        islclosure        = {"islclosure", "debug.islclosure", "debug.islfunction"},
        getupvalues       = {"getupvalues", "debug.getupvalues", "debug.getupvalue"},
        setupvalue        = {"setupvalue", "debug.setupvalue"},
        getinfo           = {"getinfo", "debug.getinfo"},
        getconnections    = {"getconnections", "debug.getconnections"},
        filtergc          = {"filtergc", "debug.filtergc"},
        setthreadidentity = {"setthreadidentity", "setidentity", "debug.setthreadidentity"},
    }

    for alias, sources in pairs(aliasMap) do
        if rawget(env, alias) == nil then
            for _, src in ipairs(sources) do
                local fn = resolve(src)
                if fn then
                    env[alias] = fn
                    break
                end
            end
        end
    end
end
-- === END SHIM ===

repeat
    task.wait()
until game:IsLoaded()

P = game:GetService("Players")
R = game:GetService("RunService")
RS = game:GetService("ReplicatedStorage")
L = game:GetService("Lighting")
UI = game:GetService("UserInputService")
TS = game:GetService("TweenService")
DB = game:GetService("Debris")
Stats = game:GetService("Stats")

pl = P.LocalPlayer
pg = pl:WaitForChild("PlayerGui")
mb = UI.TouchEnabled and not UI.KeyboardEnabled
pcMode = false

for _, child in ipairs(pg:GetChildren()) do
    if child.Name == "ENX" then
        child:Destroy()
    end
end

-- ── remote capture hook (kick immunity + parry tuple capture) ──
pcall(function()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall

    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()

        if method == "Kick" and self == pl then
            return
        end

        if method == "FireServer" and typeof(self) == "Instance" and self:IsA("RemoteEvent") then
            local args = {...}

            if #args == 7
                and typeof(args[2]) == "string"
                and typeof(args[3]) == "number"
                and typeof(args[4]) == "CFrame"
                and typeof(args[5]) == "table"
                and typeof(args[6]) == "table"
                and typeof(args[7]) == "boolean"
            then
                revertedRemotes[self] = args
                if not hasData then
                    hasData = true
                    if ST then
                        pcall(function() ST.Text = "Ready! (namecall)" end)
                    end
                end
            end
        end

        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end)

S = {
    AP = false, AS = false, BE = false, PE = false, RE = false, DE = false,
    FP = false, BT = false, AD = false, FB = false, VT = false, AE = false,
    SI = false, SK = false, ID = false, TD = false, DD = false, AF = false,
    BF = false, TN = false, AE2 = false, SR = false, PD = false, HS = false,
    IW = false, TB = false, SG = false, LAP = false, LAS = false, KS = false,
    NR = false, NR2 = false, SC = false, IM = false
}

orbitR = 20
orbitH = 5
imOrbitR = 15
savedWS = nil
savedJP = nil
revertedRemotes = {}
hasData = false
serverFireCounter = 0
peakSpeed = 0
Parries = 0
Speed_Divisor_Multiplier = 1.1
ParryThreshold = 1
Closest_Entity = nil
Infinity = false
Phantom = false
siAngle = 0
imAngle = 0
imDesync = {}
ms = false
ms_enabled = false
lobbySpamDB = 0
trainingParried = false
Balls = nil
Runtime = nil
Alive = nil
TrainingBalls = nil
VTL1 = nil
VTL2 = nil
VTL3 = nil
VTUI = nil
ST = nil
SD = nil
hitSound = nil
HL = {}
BHL = nil
TLb = nil
AEGUI = {}
abilityDB = {}
pAbCache = {}
aeLabels = {}
musicSound = nil
currentMusicIdx = 0
songBtns = {}
nowPlayingLabel = nil
NOTIF_TL = nil
NOTIF = nil
op = false
C = nil
allUI = {}
VTUI_REF = {}
TB2 = {}
TP = {}
MF = nil
SG2 = nil
OB = nil
MS = nil
MD = nil
MkTab = nil
MkSec = nil
MkTog = nil
MkSlider = nil
CP = nil
EP = nil
XP = nil
MU = nil
MP = nil
SB = nil
ShowNotif = nil
doFire = nil
isStaff = nil
KSS_selected = "92076037937225"
KSS_lastKill = 0
KSS_conns = {}
KSS_curSound = nil
swordModel = ""
swordAnimations = ""
swordFX = ""
skinChangerEnabled = false
noRenderConn = nil
noRender2Conn = nil
siLV = nil
siAtt = nil

AE_STATE = {
    active = false,
    players = {}
}

Network = Stats.Network

Sys = {
    __parried = false,
    __training_parried = false,
    __antidot_parried = false,
    __grab_animation = nil,
    __play_animation = false,
    __curve_mode = 1,
    __infinity_active = false,
    __deathslash_active = false,
    __timehole_active = false,
    __spam_target = nil,
    __spam_target_time = 0,
    __auto_spam_enabled = false,
    __first_parry_done = false,
    __tornado_time = tick(),
    __last_closest = tick()
}

function applyStats(p2)
    local v148 = p2 and p2:FindFirstChildOfClass("Humanoid")
    if not v148 then return end

    if savedWS then v148.WalkSpeed = savedWS end
    if savedJP then v148.JumpPower = savedJP end
end

pl.CharacterAdded:Connect(function(character)
    task.wait(0.5)
    applyStats(character)
    peakSpeed = 0
end)

C = ({
    Ocean = { BG = Color3.fromRGB(4, 12, 24), P = Color3.fromRGB(6, 18, 36), C = Color3.fromRGB(8, 24, 48), A = Color3.fromRGB(0, 180, 220), A2 = Color3.fromRGB(0, 230, 255), TX = Color3.fromRGB(220, 245, 255), SB = Color3.fromRGB(100, 160, 190), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(20, 40, 60) },
    Emerald = { BG = Color3.fromRGB(4, 14, 8), P = Color3.fromRGB(6, 20, 12), C = Color3.fromRGB(8, 28, 16), A = Color3.fromRGB(0, 200, 80), A2 = Color3.fromRGB(0, 255, 120), TX = Color3.fromRGB(220, 255, 230), SB = Color3.fromRGB(80, 160, 100), ON = Color3.fromRGB(0, 230, 100), OF = Color3.fromRGB(15, 40, 20) },
    Royalty = { BG = Color3.fromRGB(10, 6, 20), P = Color3.fromRGB(16, 10, 30), C = Color3.fromRGB(22, 14, 42), A = Color3.fromRGB(180, 100, 255), A2 = Color3.fromRGB(220, 160, 255), TX = Color3.fromRGB(240, 230, 255), SB = Color3.fromRGB(140, 110, 180), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(35, 20, 55) },
    Purple = { BG = Color3.fromRGB(8, 6, 18), P = Color3.fromRGB(14, 10, 28), C = Color3.fromRGB(20, 15, 38), A = Color3.fromRGB(120, 60, 220), A2 = Color3.fromRGB(160, 100, 255), TX = Color3.fromRGB(240, 235, 255), SB = Color3.fromRGB(120, 100, 160), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(30, 20, 50) },
    Crimson = { BG = Color3.fromRGB(16, 4, 8), P = Color3.fromRGB(24, 6, 12), C = Color3.fromRGB(32, 8, 16), A = Color3.fromRGB(220, 40, 60), A2 = Color3.fromRGB(255, 80, 100), TX = Color3.fromRGB(255, 230, 235), SB = Color3.fromRGB(180, 100, 110), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(50, 15, 20) },
    Midnight = { BG = Color3.fromRGB(6, 6, 10), P = Color3.fromRGB(10, 10, 16), C = Color3.fromRGB(16, 16, 24), A = Color3.fromRGB(100, 120, 255), A2 = Color3.fromRGB(140, 160, 255), TX = Color3.fromRGB(230, 235, 255), SB = Color3.fromRGB(110, 115, 150), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(25, 25, 40) }
}).Ocean

local function v3(p3, p4, p5)
    local v153 = Instance.new(p3)
    for k, v in pairs(p5 or {}) do
        pcall(function() v153[k] = v end)
    end
    v153.Parent = p4
    return v153
end

local v4 = not mb and 430 or 310
local v5 = not mb and 590 or 520

local function v6(p6, p7)
    local u164 = false
    local u165, u166, u167

    p6.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local inputPosition = input.Position
            local p7Position = p7.Position
            u164 = true
            u165 = inputPosition
            u166 = p7Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    u164 = false
                end
            end)
        end
    end)

    p6.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            u167 = input
        end
    end)

    UI.InputChanged:Connect(function(input)
        if input == u167 and u164 then
            local v526 = input.Position - u165
            p7.Position = UDim2.new(u166.X.Scale, u166.X.Offset + v526.X, u166.Y.Scale, u166.Y.Offset + v526.Y)
        end
    end)
end

SG2 = v3("ScreenGui", pg, {
    Name = "ENX",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 10
})

local v7 = v3("Frame", SG2, {
    BorderSizePixel = 0,
    ZIndex = 20,
    Size = UDim2.fromOffset(not mb and 260 or 200, 40),
    Position = UDim2.new(0.5, -130, 0, 8),
    BackgroundColor3 = C.P
})
v3("UICorner", v7, { CornerRadius = UDim.new(0, 20) })
MS = v3("UIStroke", v7, { Thickness = 1.5, Transparency = 0.2, Color = C.A })
table.insert(allUI, { prop = "Color", key = "A", obj = MS })

MD = v3("Frame", v7, {
    ZIndex = 21,
    Size = UDim2.fromOffset(8, 8),
    Position = UDim2.new(0, 11, 0.5, -4),
    BackgroundColor3 = C.ON
})
v3("UICorner", MD, { CornerRadius = UDim.new(1, 0) })

v3("TextLabel", v7, {
    BackgroundTransparency = 1,
    Text = "EclipseNexus",
    TextSize = 12,
    ZIndex = 21,
    Size = UDim2.new(1, -65, 1, 0),
    Position = UDim2.new(0, 24, 0, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})

OB = v3("TextButton", v7, {
    Text = "OPEN",
    TextSize = 10,
    AutoButtonColor = false,
    ZIndex = 22,
    Size = UDim2.fromOffset(52, 26),
    Position = UDim2.new(1, -58, 0.5, -13),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
table.insert(allUI, { prop = "BackgroundColor3", key = "A", obj = OB })
v3("UICorner", OB, { CornerRadius = UDim.new(0, 8) })
v6(v7, v7)

MF = v3("Frame", SG2, {
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 1,
    Size = UDim2.fromOffset(v4, v5),
    Position = UDim2.new(0.5, -v4 / 2, 0.5, -v5 / 2),
    BackgroundColor3 = C.BG
})
v3("UICorner", MF, { CornerRadius = UDim.new(0, 18) })
local v10 = v3("UIStroke", MF, {
    Thickness = 1.5,
    Transparency = 0.3,
    Color = C.A,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
})
table.insert(allUI, { prop = "Color", key = "A", obj = v10 })
table.insert(allUI, { prop = "BackgroundColor3", key = "BG", obj = MF })
v6(MF, MF)

OB.MouseButton1Click:Connect(function()
    op = not op
    if op then
        MF.Visible = true
        MF.Size = UDim2.fromOffset(0, 0)
        pcall(function()
            TS:Create(MF, TweenInfo.new(0.35, Enum.EasingStyle.Quart), { Size = UDim2.fromOffset(v4, v5) }):Play()
        end)
        OB.Text = "CLOSE"
        pcall(function()
            TS:Create(OB, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { BackgroundColor3 = Color3.fromRGB(200, 40, 40) }):Play()
        end)
        return
    end

    pcall(function()
        TS:Create(MF, TweenInfo.new(0.25, Enum.EasingStyle.Quart), { Size = UDim2.fromOffset(0, 0) }):Play()
    end)
    task.delay(0.28, function() MF.Visible = false end)
    OB.Text = "OPEN"
    pcall(function()
        TS:Create(OB, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
    end)
end)

local function v12(p8, p9, p10)
    local v183 = Instance.new(p8)
    for k, v in pairs(p10 or {}) do
        pcall(function() v183[k] = v end)
    end
    v183.Parent = p9
    return v183
end

local v13 = v12("Frame", MF, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 62),
    BackgroundColor3 = C.P
})
v12("UICorner", v13, { CornerRadius = UDim.new(0, 18) })
v12("Frame", v13, {
    BorderSizePixel = 0,
    ZIndex = 3,
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 1, -18),
    BackgroundColor3 = C.P
})
table.insert(allUI, { prop = "BackgroundColor3", key = "P", obj = v13 })

local v14 = v12("Frame", v13, {
    ZIndex = 4,
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.new(0, 10, 0.5, -22),
    BackgroundColor3 = Color3.fromRGB(2, 2, 8)
})
v12("UICorner", v14, { CornerRadius = UDim.new(1, 0) })
local v15 = v12("UIStroke", v14, { Thickness = 2, Color = C.A })
table.insert(allUI, { prop = "Color", key = "A", obj = v15 })

local v16 = v12("Frame", v14, {
    ZIndex = 5,
    Size = UDim2.fromOffset(40, 40),
    Position = UDim2.fromOffset(10, -4),
    BackgroundColor3 = C.P
})
v12("UICorner", v16, { CornerRadius = UDim.new(1, 0) })
table.insert(allUI, { prop = "BackgroundColor3", key = "P", obj = v16 })

v12("TextLabel", v14, {
    BackgroundTransparency = 1,
    Text = "E",
    TextSize = 24,
    ZIndex = 6,
    Size = UDim2.new(1, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.A
})

local v17 = v12("TextLabel", v13, {
    BackgroundTransparency = 1,
    Text = "ECLIPSENEXUS",
    TextSize = 15,
    ZIndex = 4,
    Size = UDim2.new(1, -110, 0, 22),
    Position = UDim2.new(0, 62, 0, 8),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})
table.insert(allUI, { prop = "TextColor3", key = "TX", obj = v17 })

local v18 = v12("TextLabel", v13, {
    BackgroundTransparency = 1,
    Text = "v2.1 BladeBall",
    TextSize = 10,
    ZIndex = 4,
    Size = UDim2.new(1, -110, 0, 14),
    Position = UDim2.new(0, 62, 0, 30),
    Font = Enum.Font.Gotham,
    TextColor3 = C.A,
    TextXAlignment = Enum.TextXAlignment.Left
})
table.insert(allUI, { prop = "TextColor3", key = "A", obj = v18 })

local v19 = v12("Frame", v13, {
    BorderSizePixel = 0,
    ZIndex = 4,
    Size = UDim2.new(1, -20, 0, 2),
    Position = UDim2.new(0, 10, 1, -3),
    BackgroundColor3 = C.A
})
v12("UICorner", v19, { CornerRadius = UDim.new(1, 0) })
table.insert(allUI, { prop = "BackgroundColor3", key = "A", obj = v19 })

local v20 = v12("Frame", MF, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, -16, 0, 28),
    Position = UDim2.new(0, 8, 0, 66),
    BackgroundColor3 = C.P
})
v12("UICorner", v20, { CornerRadius = UDim.new(0, 8) })
table.insert(allUI, { prop = "BackgroundColor3", key = "P", obj = v20 })
v12("UIListLayout", v20, {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 5),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Center
})

local t5 = {}
local t6 = {
    Ocean = { BG = Color3.fromRGB(4, 12, 24), P = Color3.fromRGB(6, 18, 36), C = Color3.fromRGB(8, 24, 48), A = Color3.fromRGB(0, 180, 220), A2 = Color3.fromRGB(0, 230, 255), TX = Color3.fromRGB(220, 245, 255), SB = Color3.fromRGB(100, 160, 190), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(20, 40, 60) },
    Emerald = { BG = Color3.fromRGB(4, 14, 8), P = Color3.fromRGB(6, 20, 12), C = Color3.fromRGB(8, 28, 16), A = Color3.fromRGB(0, 200, 80), A2 = Color3.fromRGB(0, 255, 120), TX = Color3.fromRGB(220, 255, 230), SB = Color3.fromRGB(80, 160, 100), ON = Color3.fromRGB(0, 230, 100), OF = Color3.fromRGB(15, 40, 20) },
    Royalty = { BG = Color3.fromRGB(10, 6, 20), P = Color3.fromRGB(16, 10, 30), C = Color3.fromRGB(22, 14, 42), A = Color3.fromRGB(180, 100, 255), A2 = Color3.fromRGB(220, 160, 255), TX = Color3.fromRGB(240, 230, 255), SB = Color3.fromRGB(140, 110, 180), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(35, 20, 55) },
    Purple = { BG = Color3.fromRGB(8, 6, 18), P = Color3.fromRGB(14, 10, 28), C = Color3.fromRGB(20, 15, 38), A = Color3.fromRGB(120, 60, 220), A2 = Color3.fromRGB(160, 100, 255), TX = Color3.fromRGB(240, 235, 255), SB = Color3.fromRGB(120, 100, 160), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(30, 20, 50) },
    Crimson = { BG = Color3.fromRGB(16, 4, 8), P = Color3.fromRGB(24, 6, 12), C = Color3.fromRGB(32, 8, 16), A = Color3.fromRGB(220, 40, 60), A2 = Color3.fromRGB(255, 80, 100), TX = Color3.fromRGB(255, 230, 235), SB = Color3.fromRGB(180, 100, 110), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(50, 15, 20) },
    Midnight = { BG = Color3.fromRGB(6, 6, 10), P = Color3.fromRGB(10, 10, 16), C = Color3.fromRGB(16, 16, 24), A = Color3.fromRGB(100, 120, 255), A2 = Color3.fromRGB(140, 160, 255), TX = Color3.fromRGB(230, 235, 255), SB = Color3.fromRGB(110, 115, 150), ON = Color3.fromRGB(0, 220, 140), OF = Color3.fromRGB(25, 25, 40) }
}

local function v23(p11)
    C = t6[p11]

    for _, v in ipairs(allUI) do
        pcall(function() v.obj[v.prop] = C[v.key] end)
    end

    for k, v in pairs(t5) do
        local UIStroke = v:FindFirstChildOfClass("UIStroke")
        if UIStroke then UIStroke:Destroy() end
        if k == p11 then
            v12("UIStroke", v, { Thickness = 2, Color = Color3.new(1, 1, 1) })
        end
    end

    if not op then
        pcall(function()
            TS:Create(OB, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
        end)
    end

    pcall(function()
        if VTUI_REF.frame then VTUI_REF.frame.BackgroundColor3 = C.P end
        if VTUI_REF.stroke then VTUI_REF.stroke.Color = C.A end
        v16.BackgroundColor3 = C.P
    end)
end

for _, v in ipairs({ "Ocean", "Emerald", "Royalty", "Purple", "Crimson", "Midnight" }) do
    local v26 = v12("TextButton", v20, {
        Text = "",
        AutoButtonColor = false,
        ZIndex = 3,
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = t6[v].A
    })
    v12("UICorner", v26, { CornerRadius = UDim.new(1, 0) })
    t5[v] = v26
    v26.MouseButton1Click:Connect(function() v23(v) end)
end

local v27 = v12("Frame", MF, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, -16, 0, 30),
    Position = UDim2.new(0, 8, 0, 100),
    BackgroundColor3 = C.P
})
v12("UICorner", v27, { CornerRadius = UDim.new(0, 10) })
table.insert(allUI, { prop = "BackgroundColor3", key = "P", obj = v27 })
v12("UIListLayout", v27, {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 2),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Center
})

local v28 = v12("Frame", MF, {
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 2,
    Size = UDim2.new(1, -16, 1, -172),
    Position = UDim2.new(0, 8, 0, 136)
})

local v29 = v12("Frame", MF, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, -16, 0, 24),
    Position = UDim2.new(0, 8, 1, -30),
    BackgroundColor3 = C.P
})
v12("UICorner", v29, { CornerRadius = UDim.new(0, 8) })
local v30 = v12("UIStroke", v29, { Thickness = 1, Transparency = 0.6, Color = C.A })
table.insert(allUI, { prop = "Color", key = "A", obj = v30 })
table.insert(allUI, { prop = "BackgroundColor3", key = "P", obj = v29 })

SD = v12("Frame", v29, {
    ZIndex = 3,
    Size = UDim2.fromOffset(7, 7),
    Position = UDim2.new(0, 9, 0.5, -3.5),
    BackgroundColor3 = C.ON
})
v12("UICorner", SD, { CornerRadius = UDim.new(1, 0) })

ST = v12("TextLabel", v29, {
    BackgroundTransparency = 1,
    Text = "EclipseNexus Loading...",
    TextSize = 10,
    ZIndex = 3,
    Size = UDim2.new(1, -24, 1, 0),
    Position = UDim2.new(0, 23, 0, 0),
    Font = Enum.Font.Gotham,
    TextColor3 = C.SB,
    TextXAlignment = Enum.TextXAlignment.Left
})
table.insert(allUI, { prop = "TextColor3", key = "SB", obj = ST })

function MkTab(p12, p13)
    local v209 = not mb and 44 or 34
    local v210 = v12("TextButton", v27, {
        TextSize = 8,
        AutoButtonColor = false,
        ZIndex = 3,
        Size = UDim2.fromOffset(v209, 24),
        BackgroundColor3 = C.C,
        Text = (p13 or "") .. p12,
        Font = Enum.Font.GothamMedium,
        TextColor3 = C.SB
    })
    v12("UICorner", v210, { CornerRadius = UDim.new(0, 8) })
    table.insert(allUI, { prop = "BackgroundColor3", key = "C", obj = v210 })

    local v211 = v12("ScrollingFrame", v28, {
        BackgroundTransparency = 1,
        ScrollBarThickness = 3,
        Visible = false,
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarImageColor3 = C.A,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    v12("UIListLayout", v211, { Padding = UDim.new(0, 5) })
    v12("UIPadding", v211, {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 6)
    })

    TB2[p12] = v210
    TP[p12] = v211

    v210.MouseButton1Click:Connect(function()
        for k, v in pairs(TP) do
            v.Visible = false
            TB2[k].TextColor3 = C.SB
            pcall(function()
                TS:Create(TB2[k], TweenInfo.new(0.15, Enum.EasingStyle.Quart), { BackgroundColor3 = C.C }):Play()
            end)
        end
        v211.Visible = true
        v210.TextColor3 = C.TX
        pcall(function()
            TS:Create(v210, TweenInfo.new(0.15, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
        end)
    end)

    return v211
end

function MkSec(p14, p15)
    local v214 = v12("Frame", p14, {
        BackgroundTransparency = 1,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, 20)
    })
    v12("Frame", v214, {
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = C.OF
    })
    local v215 = v12("Frame", v214, {
        BorderSizePixel = 0,
        ZIndex = 3,
        Size = UDim2.fromOffset(#p15 * 7 + 14, 14),
        Position = UDim2.new(0, 6, 0.5, -7),
        BackgroundColor3 = C.BG
    })
    v12("TextLabel", v215, {
        BackgroundTransparency = 1,
        TextSize = 9,
        ZIndex = 4,
        Size = UDim2.new(1, 0, 1, 0),
        Text = p15:upper(),
        Font = Enum.Font.GothamBold,
        TextColor3 = C.A,
        TextXAlignment = Enum.TextXAlignment.Center
    })
end

function MkTog(p16, p17, p18, p19)
    local v220 = if not p19 then (not mb and 32 or 38) else (not mb and 44 or 54)
    local v221 = v12("Frame", p16, {
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, v220),
        BackgroundColor3 = C.C
    })
    v12("UICorner", v221, { CornerRadius = UDim.new(0, 10) })
    v12("UIStroke", v221, { Thickness = 1, Color = C.OF })

    local v222 = v12("Frame", v221, {
        BorderSizePixel = 0,
        ZIndex = 3,
        Size = UDim2.new(0, 3, 0.6, 0),
        Position = UDim2.new(0, 0, 0.2, 0),
        BackgroundColor3 = C.OF
    })
    v12("UICorner", v222, { CornerRadius = UDim.new(1, 0) })

    v12("TextLabel", v221, {
        BackgroundTransparency = 1,
        TextSize = 11,
        ZIndex = 3,
        Size = UDim2.new(1, -56, 0, 16),
        Position = p19 and UDim2.new(0, 12, 0, 5) or UDim2.new(0, 12, 0.5, -8),
        Text = p17,
        Font = Enum.Font.GothamMedium,
        TextColor3 = C.TX,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    if p19 then
        v12("TextLabel", v221, {
            BackgroundTransparency = 1,
            TextSize = 9,
            ZIndex = 3,
            Size = UDim2.new(1, -56, 0, 12),
            Position = UDim2.new(0, 12, 0, 21),
            Text = p19,
            Font = Enum.Font.Gotham,
            TextColor3 = C.SB,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end

    local v223 = v12("TextButton", v221, {
        Text = "",
        AutoButtonColor = false,
        ZIndex = 4,
        Size = UDim2.fromOffset(36, 19),
        Position = UDim2.new(1, -44, 0.5, -9.5),
        BackgroundColor3 = C.OF
    })
    v12("UICorner", v223, { CornerRadius = UDim.new(1, 0) })

    local v224 = v12("Frame", v223, {
        ZIndex = 5,
        Size = UDim2.fromOffset(13, 13),
        Position = UDim2.new(0, 3, 0.5, -6.5),
        BackgroundColor3 = Color3.new(1, 1, 1)
    })
    v12("UICorner", v224, { CornerRadius = UDim.new(1, 0) })

    v223.MouseButton1Click:Connect(function()
        S[p18] = not S[p18]
        local v541 = S[p18]

        pcall(function()
            TS:Create(v223, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { BackgroundColor3 = v541 and C.ON or C.OF }):Play()
        end)
        pcall(function()
            TS:Create(v224, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                Position = v541 and UDim2.new(1, -16, 0.5, -6.5) or UDim2.new(0, 3, 0.5, -6.5)
            }):Play()
        end)
        pcall(function()
            TS:Create(v222, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { BackgroundColor3 = v541 and C.A or C.OF }):Play()
        end)

        if v541 then
            pcall(function()
                TS:Create(v221, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = C.P }):Play()
            end)
            task.delay(0.3, function()
                pcall(function()
                    TS:Create(v221, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { BackgroundColor3 = C.C }):Play()
                end)
            end)
        end
    end)
end

function MkSlider(p20, p21, p22, p23, p24, p25)
    local v231 = v12("Frame", p20, {
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, not mb and 46 or 54),
        BackgroundColor3 = C.C
    })
    v12("UICorner", v231, { CornerRadius = UDim.new(0, 10) })
    v12("UIStroke", v231, { Thickness = 1, Color = C.OF })

    v12("TextLabel", v231, {
        BackgroundTransparency = 1,
        TextSize = 11,
        ZIndex = 3,
        Size = UDim2.new(1, -54, 0, 16),
        Position = UDim2.new(0, 12, 0, 6),
        Text = p21,
        Font = Enum.Font.GothamMedium,
        TextColor3 = C.TX,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local v232 = v12("TextLabel", v231, {
        BackgroundTransparency = 1,
        TextSize = 11,
        ZIndex = 3,
        Size = UDim2.fromOffset(42, 16),
        Position = UDim2.new(1, -46, 0, 6),
        Text = tostring(p24),
        Font = Enum.Font.GothamBold,
        TextColor3 = C.A,
        TextXAlignment = Enum.TextXAlignment.Right
    })

    local v233 = v12("Frame", v231, {
        BorderSizePixel = 0,
        ZIndex = 3,
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 30),
        BackgroundColor3 = C.OF
    })
    v12("UICorner", v233, { CornerRadius = UDim.new(1, 0) })

    local v234 = (p24 - p22) / (p23 - p22)
    local v235 = v12("Frame", v233, {
        BorderSizePixel = 0,
        ZIndex = 4,
        Size = UDim2.new(v234, 0, 1, 0),
        BackgroundColor3 = C.A
    })
    v12("UICorner", v235, { CornerRadius = UDim.new(1, 0) })

    local v236 = v12("Frame", v233, {
        ZIndex = 5,
        Size = UDim2.fromOffset(16, 16),
        Position = UDim2.new(v234, -8, 0.5, -8),
        BackgroundColor3 = Color3.new(1, 1, 1)
    })
    v12("UICorner", v236, { CornerRadius = UDim.new(1, 0) })

    local u237 = false

    local function v238(p26)
        local v555 = math.clamp((p26 - v233.AbsolutePosition.X) / math.max(v233.AbsoluteSize.X, 1), 0, 1)
        local v556 = math.round(p22 + v555 * (p23 - p22))
        v235.Size = UDim2.new(v555, 0, 1, 0)
        v236.Position = UDim2.new(v555, -8, 0.5, -8)
        v232.Text = tostring(v556)
        p25(v556)
    end

    v233.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            u237 = true
            v238(input.Position.X)
        end
    end)
    UI.InputChanged:Connect(function(input)
        if u237 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            v238(input.Position.X)
        end
    end)
    UI.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            u237 = false
        end
    end)
end

R.Heartbeat:Connect(function()
    local v239 = (math.sin(tick() * 2.5) + 1) / 2
    MS.Transparency = v239 * 0.5 + 0.1
    MD.BackgroundColor3 = op and C.A or C.ON
end)

local function v32(p27, p28, p29)
    local v243 = Instance.new(p27)
    for k, v in pairs(p29 or {}) do
        pcall(function() v243[k] = v end)
    end
    v243.Parent = p28
    return v243
end

CP = MkTab("Combat", "")
EP = MkTab("ESP", "")
XP = MkTab("Extra", "")
MU = MkTab("Music", "")
MP = MkTab("Misc", "")
TP.Combat.Visible = true
TB2.Combat.TextColor3 = C.TX
pcall(function()
    TS:Create(TB2.Combat, TweenInfo.new(0.01, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
end)

MkSec(CP, "Automation")
MkTog(CP, "Auto Parry", "AP", "Parries ball automatically")
MkSlider(CP, "Parry Accuracy", 1, 100, 100, function(p30)
    Speed_Divisor_Multiplier = 0.59 + (p30 - 1) * 0.030303030303030304
end)
MkTog(CP, "Auto Spam", "AS", "Spams parry when targeted")
MkSlider(CP, "Spam Threshold", 1, 3, 1, function(p31)
    ParryThreshold = p31
end)
MkTog(CP, "Triggerbot", "TB", "Triggerbot on closest player")
MkTog(CP, "Auto Dodge", "AD", "Teleports to avoid ball")

local v36 = v32("TextButton", v32("ScreenGui", pg, {
    Name = "ENX_ADFloat",
    ResetOnSpawn = false,
    DisplayOrder = 11
}), {
    Text = "",
    ZIndex = 10,
    AutoButtonColor = false,
    Size = UDim2.fromOffset(64, 64),
    Position = UDim2.new(0, 84, 0.62, 0),
    BackgroundColor3 = C.A
})
v32("UICorner", v36, { CornerRadius = UDim.new(1, 0) })
v32("UIStroke", v36, { Thickness = 2, Transparency = 0.4, Color = C.A2 })
v32("TextLabel", v36, {
    BackgroundTransparency = 1,
    Text = "↗",
    TextSize = 20,
    ZIndex = 11,
    Size = UDim2.new(1, 0, 0.5, 0),
    Position = UDim2.new(0, 0, 0, 6),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v32("TextLabel", v36, {
    BackgroundTransparency = 1,
    Text = "DODGE",
    TextSize = 9,
    ZIndex = 11,
    Size = UDim2.new(1, 0, 0.36, 0),
    Position = UDim2.new(0, 0, 0.62, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})

local u37 = false
local u38 = false
local inputPosition
local Position
local u41 = false

v36.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u38 = true
        inputPosition = input.Position
        Position = v36.Position
        u41 = false
    end
end)

v36.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if not u41 then
            u37 = not u37
            S.AD = u37
            pcall(function()
                TS:Create(v36, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
                    BackgroundColor3 = u37 and Color3.fromRGB(80, 220, 140) or C.A
                }):Play()
            end)
        end
        u38 = false
    end
end)

UI.InputChanged:Connect(function(input)
    if u38 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local v257 = input.Position - inputPosition
        if not u41 and v257.Magnitude > 10 then u41 = true end
        if u41 then
            v36.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v257.X, Position.Y.Scale, Position.Y.Offset + v257.Y)
        end
    end
end)

MkSec(CP, "Detection")
MkTog(CP, "Infinity Detection", "ID", "Stops parry during Infinity")
MkTog(CP, "Phantom Detection", "PD", "Auto handles Phantom")
MkTog(CP, "Singularity Detect", "SG", "Stops during Singularity cape")
MkSec(CP, "Lobby / Training")
MkTog(CP, "Lobby Auto Parry", "LAP", "Parries in TrainingBalls")
MkTog(CP, "Lobby Auto Spam", "LAS", "Spams in TrainingBalls")
MkSec(CP, "Survival")
MkTog(CP, "Semi Immortal", "SI", "Orbits ball - you move normally")
MkSlider(CP, "Orbit Radius", 4, 150, 20, function(p32) orbitR = p32 end)
MkSlider(CP, "Orbit Height", 0, 100, 5, function(p33) orbitH = p33 end)
MkTog(CP, "Immortal", "IM", "Visual desync orbit - others see you orbiting")
MkSlider(CP, "Immortal Radius", 4, 100, 15, function(p34) imOrbitR = p34 end)
MkSec(CP, "Ability Detection")
MkTog(CP, "Infinity Warn", "IW", "Warns Infinity used")
MkTog(CP, "Time Hole Detect", "TD", "Warns Time Hole used")
MkTog(CP, "Death Slash Detect", "DD", "Warns Death Slash used")
MkTog(CP, "Tornado Detect", "TN", "Warns Tornado spawned")
MkTog(CP, "Aerodynamic Detect", "AE2", "Warns + parries Aerodynamic")
MkTog(CP, "Anti Fury", "AF", "Warns Fury used")
MkTog(CP, "Bubble Fury Warn", "BF", "Warns Bubble Fury")
MkTog(CP, "Speed Rush Warn", "SR", "Warns Speed Rush used")

local function v42(p35, p36, p37)
    local v264 = Instance.new(p35)
    for k, v in pairs(p37 or {}) do
        pcall(function() v264[k] = v end)
    end
    v264.Parent = p36
    return v264
end

MkSec(EP, "Players")
MkTog(EP, "Player ESP", "PE", "Highlights players")
MkTog(EP, "Distance ESP", "DE", "Shows stud distance")
MkTog(EP, "Rainbow ESP", "RE", "Color cycle highlights")
MkTog(EP, "Staff Detect", "SK", "Highlights staff")
MkSec(EP, "Ball")
MkTog(EP, "Ball ESP", "BE", "Highlights the ball")
MkTog(EP, "Ball Tracer", "BT", "Selection box on ball")
MkSec(XP, "Trackers")
MkTog(XP, "Velocity Tracker", "VT", "Shows ball speed")
MkTog(XP, "Ability ESP", "AE", "Shows ability above players")

MkSec(MP, "Player")
MkSlider(MP, "WalkSpeed", 16, 120, 16, function(p38)
    savedWS = p38
    local v268 = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
    if v268 then v268.WalkSpeed = p38 end
end)
MkSlider(MP, "JumpPower", 50, 250, 50, function(p39)
    savedJP = p39
    local v270 = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
    if v270 then v270.JumpPower = p39 end
end)

MkSec(MP, "Input Mode")
local v43 = v42("Frame", MP, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 46),
    BackgroundColor3 = C.C
})
v42("UICorner", v43, { CornerRadius = UDim.new(0, 10) })
v42("UIStroke", v43, { Thickness = 1, Color = C.OF })

local v44 = v42("TextLabel", v43, {
    BackgroundTransparency = 1,
    Text = "Mode: Mobile (Touch)",
    TextSize = 11,
    ZIndex = 3,
    Size = UDim2.new(1, -8, 0, 16),
    Position = UDim2.new(0, 12, 0, 6),
    Font = Enum.Font.GothamMedium,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})

local v45 = v42("Frame", v43, {
    BorderSizePixel = 0,
    ZIndex = 3,
    Size = UDim2.new(1, -24, 0, 6),
    Position = UDim2.new(0, 12, 0, 30),
    BackgroundColor3 = C.OF
})
v42("UICorner", v45, { CornerRadius = UDim.new(1, 0) })

local v46 = v42("Frame", v45, {
    BorderSizePixel = 0,
    ZIndex = 4,
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = C.A
})
v42("UICorner", v46, { CornerRadius = UDim.new(1, 0) })

local v47 = v42("Frame", v45, {
    ZIndex = 5,
    Size = UDim2.fromOffset(16, 16),
    Position = UDim2.new(0, -8, 0.5, -8),
    BackgroundColor3 = Color3.new(1, 1, 1)
})
v42("UICorner", v47, { CornerRadius = UDim.new(1, 0) })

local u48 = false

local function v49(p40)
    pcMode = math.clamp((p40 - v45.AbsolutePosition.X) / math.max(v45.AbsoluteSize.X, 1), 0, 1) >= 0.5
    local v272 = not pcMode and 0 or 1
    v46.Size = UDim2.new(v272, 0, 1, 0)
    v47.Position = UDim2.new(v272, -8, 0.5, -8)
    v44.Text = not pcMode and "Mode: Mobile (Touch)" or "Mode: PC (Keyboard)"
    v44.TextColor3 = pcMode and C.A or C.TX
end

v45.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u48 = true
        v49(input.Position.X)
    end
end)
UI.InputChanged:Connect(function(input)
    if u48 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        v49(input.Position.X)
    end
end)
UI.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u48 = false
    end
end)

MkSec(MP, "Performance")
MkTog(MP, "FPS Boost", "FP", "Removes effects once")
MkTog(MP, "Full Bright", "FB", "Max brightness")
MkSec(MP, "Render")
MkTog(MP, "No Render (ENX)", "NR", "Destroys Runtime children")
MkTog(MP, "No Render (Alt)", "NR2", "Disables EffectScripts ClientFX")

MkSec(MP, "Sword Changer")
MkTog(MP, "Skin Changer", "SC", "Enables sword skin changing")
local v50 = v42("TextBox", MP, {
    BorderSizePixel = 0,
    PlaceholderText = "Sword Model Name...",
    TextSize = 10,
    ClearTextOnFocus = false,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = C.C,
    Font = Enum.Font.Gotham,
    TextColor3 = C.TX,
    PlaceholderColor3 = C.SB,
    TextXAlignment = Enum.TextXAlignment.Left
})
v42("UICorner", v50, { CornerRadius = UDim.new(0, 8) })
v42("UIStroke", v50, { Thickness = 1, Color = C.OF })
v42("UIPadding", v50, { PaddingLeft = UDim.new(0, 8) })
v50.FocusLost:Connect(function() swordModel = v50.Text end)

local v51 = v42("TextBox", MP, {
    BorderSizePixel = 0,
    PlaceholderText = "Sword Animation Name...",
    TextSize = 10,
    ClearTextOnFocus = false,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = C.C,
    Font = Enum.Font.Gotham,
    TextColor3 = C.TX,
    PlaceholderColor3 = C.SB,
    TextXAlignment = Enum.TextXAlignment.Left
})
v42("UICorner", v51, { CornerRadius = UDim.new(0, 8) })
v42("UIStroke", v51, { Thickness = 1, Color = C.OF })
v42("UIPadding", v51, { PaddingLeft = UDim.new(0, 8) })
v51.FocusLost:Connect(function() swordAnimations = v51.Text end)

local v52 = v42("TextBox", MP, {
    BorderSizePixel = 0,
    PlaceholderText = "Sword FX Name...",
    TextSize = 10,
    ClearTextOnFocus = false,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = C.C,
    Font = Enum.Font.Gotham,
    TextColor3 = C.TX,
    PlaceholderColor3 = C.SB,
    TextXAlignment = Enum.TextXAlignment.Left
})
v42("UICorner", v52, { CornerRadius = UDim.new(0, 8) })
v42("UIStroke", v52, { Thickness = 1, Color = C.OF })
v42("UIPadding", v52, { PaddingLeft = UDim.new(0, 8) })
v52.FocusLost:Connect(function() swordFX = v52.Text end)

local v53 = v42("TextButton", MP, {
    Text = "Apply Sword",
    TextSize = 11,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v42("UICorner", v53, { CornerRadius = UDim.new(0, 10) })
v53.MouseButton1Click:Connect(function()
    if not S.SC then
        ShowNotif("Enable Skin Changer first", Color3.fromRGB(255, 80, 80))
        return
    end
    skinChangerEnabled = true
    swordModel = v50.Text
    swordAnimations = v51.Text
    swordFX = v52.Text
    ShowNotif("Sword applied!", Color3.fromRGB(0, 220, 140))
end)

local function v54(p41, p42, p43)
    local v279 = Instance.new(p41)
    for k, v in pairs(p43 or {}) do
        pcall(function() v279[k] = v end)
    end
    v279.Parent = p42
    return v279
end

MkSec(MP, "Kill Sound")
MkTog(MP, "Kill Sound", "KS", "Plays sound when you kill someone")

local t17 = {
    "Fahhhh", "Very angry", "Leave me alone", "Get over here",
    "HEHEHE HA", "Head shot", "Lesgoo", "I back", "Fatality",
    "Pans", "Bruh", "Beautiful girl", "DION TIMMER SHIAWASE"
}
local t18 = {
    "92076037937225", "96664488756631", "116957716755028", "8643750815",
    "93779555057888", "84233173598772", "8097518145", "6512108316",
    "27274429332", "6011094380", "7616380887", "9070284921", "5409360995"
}

local v57 = v54("Frame", MP, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, not mb and 46 or 54),
    BackgroundColor3 = C.C
})
v54("UICorner", v57, { CornerRadius = UDim.new(0, 10) })
v54("UIStroke", v57, { Thickness = 1, Color = C.OF })

local v58 = v54("TextLabel", v57, {
    BackgroundTransparency = 1,
    Text = "Sound: Fahhhh",
    TextSize = 11,
    Size = UDim2.new(1, -8, 0, 16),
    Position = UDim2.new(0, 12, 0, 6),
    Font = Enum.Font.GothamMedium,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})

local v59 = v54("Frame", v57, {
    BorderSizePixel = 0,
    Size = UDim2.new(1, -24, 0, 6),
    Position = UDim2.new(0, 12, 0, 30),
    BackgroundColor3 = C.OF
})
v54("UICorner", v59, { CornerRadius = UDim.new(1, 0) })

local v60 = v54("Frame", v59, {
    BorderSizePixel = 0,
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = C.A
})
v54("UICorner", v60, { CornerRadius = UDim.new(1, 0) })

local v61 = v54("Frame", v59, {
    Size = UDim2.fromOffset(16, 16),
    Position = UDim2.new(0, -8, 0.5, -8),
    BackgroundColor3 = Color3.new(1, 1, 1)
})
v54("UICorner", v61, { CornerRadius = UDim.new(1, 0) })

local u62 = false
local function v63(p44)
    local v283 = math.round(math.clamp((p44 - v59.AbsolutePosition.X) / math.max(v59.AbsoluteSize.X, 1), 0, 1) * (#t17 - 1) + 1)
    v60.Size = UDim2.new((v283 - 1) / (#t17 - 1), 0, 1, 0)
    v61.Position = UDim2.new((v283 - 1) / (#t17 - 1), -8, 0.5, -8)
    v58.Text = "Sound: " .. t17[v283]
    KSS_selected = t18[v283]
end
v59.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u62 = true
        v63(input.Position.X)
    end
end)
UI.InputChanged:Connect(function(input)
    if u62 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        v63(input.Position.X)
    end
end)
UI.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u62 = false
    end
end)

MkSec(MP, "FastFlags")
local t19 = { "Default (All FFlags)", "Fps Boost", "Lag Fix", "Lag Ball" }

local v65 = v54("Frame", MP, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = C.C
})
v54("UICorner", v65, { CornerRadius = UDim.new(0, 10) })
v54("UIStroke", v65, { Thickness = 1, Color = C.OF })

local v66 = v54("TextLabel", v65, {
    BackgroundTransparency = 1,
    Text = "Select Profile",
    TextSize = 10,
    ZIndex = 3,
    Size = UDim2.new(1, -80, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    Font = Enum.Font.GothamMedium,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})

local n15 = 1
local v68 = v54("TextButton", v65, {
    Text = "<", TextSize = 12, AutoButtonColor = false, ZIndex = 4,
    Size = UDim2.fromOffset(28, 24),
    Position = UDim2.new(1, -62, 0.5, -12),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v54("UICorner", v68, { CornerRadius = UDim.new(0, 6) })
v68.MouseButton1Click:Connect(function()
    n15 = (n15 - 1 + -1) % #t19 + 1
    v66.Text = t19[n15]
end)

local v69 = v54("TextButton", v65, {
    Text = ">", TextSize = 12, AutoButtonColor = false, ZIndex = 4,
    Size = UDim2.fromOffset(28, 24),
    Position = UDim2.new(1, -30, 0.5, -12),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v54("UICorner", v69, { CornerRadius = UDim.new(0, 6) })
v69.MouseButton1Click:Connect(function()
    n15 = (n15 - 1 + 1) % #t19 + 1
    v66.Text = t19[n15]
end)

local t20 = {
    ["Default (All FFlags)"] = {
        DFIntPhysicsEMAInverseSmoothingFactor = "2074",
        FFlagAnimationTrackStepFix = "True",
        DFFlagTextureQualityOverrideEnabled = "True",
        DFIntTextureQualityOverride = "0",
        DFFlagGameNetFixReplicationSkipBug = "True",
        DFFlagCorrectCachePolicySkipRedirectCache = "True",
        FFlagPushFrameTimeToHarmony = "True",
        DFFlagSkipSomePropertiesSkip = "True",
        DFFlagSkipReadDiskCacheRedirects = "True",
        DFFlagSkipSomeProperties = "True",
        FFlagDisablePostFx = "True",
        FIntDebugTextureManagerSkipMips = "4",
        DFIntWaitOnUpdateNetworkLoopEndedMS = "1",
        FFlagAdServiceEnabled = "False",
        DFIntDebugFRMQualityLevelOverride = "3",
        DFIntCSGLevelOfDetailSwitchingDistance = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
        FIntRobloxGuiBlurIntensity = "0",
        DFIntDataSenderRate = "2000",
        DFIntRakNetLoopMs = "15",
        DFIntMaxProcessPacketsStepsPerCyclic = "1500",
        DFIntConnectionMTUSize = "1240",
        InterpolationMaxDelayMSec = "0",
        SimSolverResponsiveness = "2147483647",
        DFFlagDebugPerfMode = "True",
        FFlagDebugDisableOptimizedBytecode = "False"
    },
    ["Fps Boost"] = {
        DFFlagTextureQualityOverrideEnabled = "True",
        DFIntTextureQualityOverride = "0",
        DFFlagGameNetFixReplicationSkipBug = "True",
        DFFlagCorrectCachePolicySkipRedirectCache = "True",
        FFlagPushFrameTimeToHarmony = "True",
        DFFlagSkipSomePropertiesSkip = "True",
        DFFlagSkipReadDiskCacheRedirects = "True",
        DFFlagSkipSomeProperties = "True"
    },
    ["Lag Fix"] = {
        FIntDebugTextureManagerSkipMips = "4",
        DFIntWaitOnUpdateNetworkLoopEndedMS = "1",
        FIntFontSizePadding = "2",
        FFlagAdServiceEnabled = "False",
        DFIntDebugFRMQualityLevelOverride = "3",
        DFIntCSGLevelOfDetailSwitchingDistance = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
        DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
        FIntRobloxGuiBlurIntensity = "0"
    },
    ["Lag Ball"] = {
        DFIntMaxProcessPacketsJobScaling = "2139999999",
        DFIntMaxProcessPacketsStepsAccumulated = "0",
        DFIntMaxProcessPacketsStepsPerCyclic = "2139999999",
        DFIntMaxFrameBufferSize = "4",
        DFIntMaxFramesToSend = "1",
        DFIntMaxAverageFrameDelayExceedFactor = "0",
        DFIntPerformanceControlFrameTimeMax = "1",
        FIntInterpolationAwareTargetTimeLerpHundredth = "100",
        DFIntNumFramesAllowedToBeAboveError = "0",
        DFIntInterpolationMinAssemblyCount = "1",
        DFIntCodecMaxOutgoingFrames = "2139999999",
        DFIntCodecMaxIncomingPackets = "2139999999",
        DFIntClientPacketMaxDelayMs = "1",
        DFIntClientPacketHealthyAllocationPercent = "50",
        DFIntInterpolationDtLimitForLod = "1",
        DFIntParallelAdaptiveInterpolationBatchCount = "1",
        DFIntRakNetClockDriftAdjustmentPerPingMillisecond = "2139999999",
        FIntInterpolationMaxDelayMSec = "1",
        FIntNumFramesToCaptureCallStack = "1"
    }
}

local v71 = v54("TextButton", MP, {
    Text = "Apply FastFlags (Rejoin needed)",
    TextSize = 10,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v54("UICorner", v71, { CornerRadius = UDim.new(0, 10) })
v71.MouseButton1Click:Connect(function()
    local v288 = t19[n15]
    local v289 = t20[v288]
    if not v289 then return end

    local _setfflag
    pcall(function() _setfflag = setfflag end)
    if not _setfflag then
        pcall(function() _setfflag = getgenv().setfflag end)
    end
    if not _setfflag then
        ShowNotif("setfflag unavailable", Color3.fromRGB(255, 80, 80))
        return
    end

    for k, v in pairs(v289) do
        pcall(function()
            local v560 = k:gsub("^DFInt", ""):gsub("^DFFlag", ""):gsub("^FFlag", ""):gsub("^FInt", "")
            _setfflag(v560, tostring(v))
        end)
    end
    ShowNotif("Applied: " .. v288, Color3.fromRGB(0, 220, 140))
end)

MkSec(MP, "Hit Sounds")
MkTog(MP, "Hit Sounds", "HS", "Plays sound on parry success")

local t21 = {
    Medal = "rbxassetid://6607336718",
    Fatality = "rbxassetid://6607113255",
    Skeet = "rbxassetid://6607204501",
    Switches = "rbxassetid://6607173363",
    Bubble = "rbxassetid://6534947588",
    Laser = "rbxassetid://7837461331",
    Steve = "rbxassetid://4965083997",
    Bat = "rbxassetid://3333907347",
    Saber = "rbxassetid://8415678813"
}

local Folder = Instance.new("Folder")
Folder.Name = "ENX_Sounds"
Folder.Parent = workspace
hitSound = Instance.new("Sound", Folder)
hitSound.Volume = 6
hitSound.SoundId = "rbxassetid://6607336718"

local t22 = { "Medal", "Fatality", "Skeet", "Switches", "Bubble", "Laser", "Steve", "Bat", "Saber" }

local v75 = v54("Frame", MP, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, not mb and 46 or 54),
    BackgroundColor3 = C.C
})
v54("UICorner", v75, { CornerRadius = UDim.new(0, 10) })
v54("UIStroke", v75, { Thickness = 1, Color = C.OF })

local v76 = v54("TextLabel", v75, {
    BackgroundTransparency = 1,
    Text = "Sound: Medal",
    TextSize = 11,
    Size = UDim2.new(1, -8, 0, 16),
    Position = UDim2.new(0, 12, 0, 6),
    Font = Enum.Font.GothamMedium,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Left
})

local v77 = v54("Frame", v75, {
    BorderSizePixel = 0,
    Size = UDim2.new(1, -24, 0, 6),
    Position = UDim2.new(0, 12, 0, 30),
    BackgroundColor3 = C.OF
})
v54("UICorner", v77, { CornerRadius = UDim.new(1, 0) })

local v78 = v54("Frame", v77, {
    BorderSizePixel = 0,
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = C.A
})
v54("UICorner", v78, { CornerRadius = UDim.new(1, 0) })

local v79 = v54("Frame", v77, {
    Size = UDim2.fromOffset(16, 16),
    Position = UDim2.new(0, -8, 0.5, -8),
    BackgroundColor3 = Color3.new(1, 1, 1)
})
v54("UICorner", v79, { CornerRadius = UDim.new(1, 0) })

local u80 = false
local function v81(p45)
    local v294 = math.round(math.clamp((p45 - v77.AbsolutePosition.X) / math.max(v77.AbsoluteSize.X, 1), 0, 1) * (#t22 - 1) + 1)
    v78.Size = UDim2.new((v294 - 1) / (#t22 - 1), 0, 1, 0)
    v79.Position = UDim2.new((v294 - 1) / (#t22 - 1), -8, 0.5, -8)
    local v295 = t22[v294]
    v76.Text = "Sound: " .. v295
    hitSound.SoundId = t21[v295] or "rbxassetid://6607336718"
end
v77.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u80 = true
        v81(input.Position.X)
    end
end)
UI.InputChanged:Connect(function(input)
    if u80 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        v81(input.Position.X)
    end
end)
UI.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u80 = false
    end
end)

MkSec(MP, "Credits")
local v82 = v54("Frame", MP, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = C.C
})
v54("UICorner", v82, { CornerRadius = UDim.new(0, 10) })
v54("UIStroke", v82, { Thickness = 1, Color = C.OF })
v54("TextLabel", v82, {
    BackgroundTransparency = 1,
    Text = "EclipseNexus v2.1",
    TextSize = 14,
    ZIndex = 3,
    Size = UDim2.new(1, 0, 0, 22),
    Position = UDim2.new(0, 0, 0, 6),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.A,
    TextXAlignment = Enum.TextXAlignment.Center
})
v54("TextLabel", v82, {
    BackgroundTransparency = 1,
    Text = "BladeBall Script",
    TextSize = 11,
    ZIndex = 3,
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 0, 28),
    Font = Enum.Font.Gotham,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Center
})

local function v83(p46, p47, p48)
    local v302 = Instance.new(p46)
    for k, v in pairs(p48 or {}) do
        pcall(function() v302[k] = v end)
    end
    v302.Parent = p47
    return v302
end

local function v84(p49, p50)
    local u313 = false
    local u314, u315, u316

    p49.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local inputPosition2 = input.Position
            local p50Position = p50.Position
            u313 = true
            u314 = inputPosition2
            u315 = p50Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    u313 = false
                end
            end)
        end
    end)

    p49.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            u316 = input
        end
    end)

    UI.InputChanged:Connect(function(input)
        if input == u316 and u313 then
            local v566 = input.Position - u314
            p50.Position = UDim2.new(u315.X.Scale, u315.X.Offset + v566.X, u315.Y.Scale, u315.Y.Offset + v566.Y)
        end
    end)
end

SB = v83("TextButton", SG2, {
    Text = "",
    ZIndex = 10,
    Size = UDim2.fromOffset(64, 64),
    Position = UDim2.new(0, 10, 0.62, 0),
    BackgroundColor3 = C.A
})
v83("UICorner", SB, { CornerRadius = UDim.new(1, 0) })
table.insert(allUI, { prop = "BackgroundColor3", key = "A", obj = SB })
v83("UIStroke", SB, { Thickness = 2, Transparency = 0.4, Color = C.A2 })
v83("TextLabel", SB, {
    BackgroundTransparency = 1,
    Text = ">>",
    TextSize = 16,
    ZIndex = 11,
    Size = UDim2.new(1, 0, 0.5, 0),
    Position = UDim2.new(0, 0, 0, 6),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v83("TextLabel", SB, {
    BackgroundTransparency = 1,
    Text = "SPAM",
    TextSize = 9,
    ZIndex = 11,
    Size = UDim2.new(1, 0, 0.36, 0),
    Position = UDim2.new(0, 0, 0.62, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v84(SB, SB)

VTUI = v83("Frame", SG2, {
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 15,
    Size = UDim2.fromOffset(190, 100),
    Position = UDim2.new(0.5, -95, 0, 56),
    BackgroundColor3 = C.P
})
v83("UICorner", VTUI, { CornerRadius = UDim.new(0, 12) })
local v86 = v83("UIStroke", VTUI, { Thickness = 1.5, Transparency = 0.3, Color = C.A })
v84(VTUI, VTUI)

local v87 = v83("Frame", VTUI, {
    BorderSizePixel = 0,
    ZIndex = 16,
    Size = UDim2.new(1, 0, 0, 22),
    BackgroundColor3 = C.C
})
v83("UICorner", v87, { CornerRadius = UDim.new(0, 12) })
local v88 = v83("Frame", v87, {
    BorderSizePixel = 0,
    ZIndex = 17,
    Size = UDim2.new(1, 0, 0, 12),
    Position = UDim2.new(0, 0, 1, -12),
    BackgroundColor3 = C.C
})
v83("TextLabel", v87, {
    BackgroundTransparency = 1,
    Text = "Ball Velocity",
    TextSize = 11,
    ZIndex = 17,
    Size = UDim2.new(1, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.A,
    TextXAlignment = Enum.TextXAlignment.Center
})

VTL1 = v83("TextLabel", VTUI, {
    BackgroundTransparency = 1,
    Text = "-- st/s",
    TextSize = 15,
    ZIndex = 16,
    Size = UDim2.new(1, -8, 0, 20),
    Position = UDim2.new(0, 4, 0, 24),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.TX,
    TextXAlignment = Enum.TextXAlignment.Center
})
VTL3 = v83("TextLabel", VTUI, {
    BackgroundTransparency = 1,
    Text = "Peak: 0 st/s",
    TextSize = 11,
    ZIndex = 16,
    Size = UDim2.new(1, -8, 0, 16),
    Position = UDim2.new(0, 4, 0, 44),
    Font = Enum.Font.GothamBold,
    TextColor3 = C.ON,
    TextXAlignment = Enum.TextXAlignment.Center
})
VTL2 = v83("TextLabel", VTUI, {
    BackgroundTransparency = 1,
    Text = "X:0 Y:0 Z:0",
    TextSize = 10,
    ZIndex = 16,
    Size = UDim2.new(1, -8, 0, 14),
    Position = UDim2.new(0, 4, 0, 62),
    Font = Enum.Font.Gotham,
    TextColor3 = C.SB,
    TextXAlignment = Enum.TextXAlignment.Center
})

VTUI_REF.frame = VTUI
VTUI_REF.stroke = v86
VTUI_REF.header = v87
VTUI_REF.hfill = v88

NOTIF = v83("Frame", SG2, {
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 30,
    Size = UDim2.fromOffset(290, 44),
    Position = UDim2.new(0.5, -145, 0, 60),
    BackgroundColor3 = Color3.fromRGB(12, 12, 20)
})
v83("UICorner", NOTIF, { CornerRadius = UDim.new(0, 10) })
v83("UIStroke", NOTIF, { Thickness = 1.5, Color = Color3.fromRGB(255, 80, 80) })
NOTIF_TL = v83("TextLabel", NOTIF, {
    BackgroundTransparency = 1,
    Text = "",
    TextSize = 13,
    ZIndex = 31,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 8, 0, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 80, 80),
    TextXAlignment = Enum.TextXAlignment.Left
})

function ShowNotif(p51, p52)
    pcall(function()
        NOTIF_TL.Text = "! " .. p51
        NOTIF_TL.TextColor3 = p52 or Color3.fromRGB(255, 80, 80)
        local UIStroke = NOTIF:FindFirstChildOfClass("UIStroke")
        if UIStroke then
            UIStroke.Color = p52 or Color3.fromRGB(255, 80, 80)
        end
        NOTIF.Visible = true
        task.delay(3, function() NOTIF.Visible = false end)
    end)
end

UI.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        OB:FireButton1()
    end
end)

function isStaff(p53)
    local v321 = p53.Name:lower()
    for _, v in ipairs({ "mods", "admin", "staff", "owner", "developer", "dev", "moderator" }) do
        if v321:find(v) then
            return true
        end
    end
    local ok, result = pcall(function()
        return p53:GetRankInGroup(2868472)
    end)
    if ok and result >= 200 then
        return true
    end
    return false
end

-- ── live-resolve Alive / Runtime (was static) ──
task.spawn(function()
    while task.wait(1) do
        if not Alive or not Alive.Parent then
            Alive = workspace:FindFirstChild("Alive")
        end
        if not Runtime or not Runtime.Parent then
            Runtime = workspace:FindFirstChild("Runtime")
        end
    end
end)

task.spawn(function()
    pcall(function()
        Balls = workspace:WaitForChild("Balls", 10)
    end)
end)

task.spawn(function()
    pcall(function()
        TrainingBalls = workspace:WaitForChild("TrainingBalls", 10)
    end)
end)

local function v89(p54)
    return #p54 == 7
        and typeof(p54[2]) == "string"
        and typeof(p54[3]) == "number"
        and typeof(p54[4]) == "CFrame"
        and typeof(p54[5]) == "table"
        and typeof(p54[6]) == "table"
        and typeof(p54[7]) == "boolean"
end

-- ── fallback capture via __index hook ──
task.spawn(function()
    pcall(function()
        local v568 = getrawmetatable(game)
        local __index = v568.__index

        setreadonly(v568, false)
        v568.__index = newcclosure(function(p55, p56)
            if p56 == "FireServer" and p55:IsA("RemoteEvent") then
                return newcclosure(function(_, ...)
                    local t23 = { ... }
                    if v89(t23) or p55.Name:find("Parry") then
                        revertedRemotes[p55] = t23
                        if not hasData then
                            hasData = true
                            pcall(function() ST.Text = "Ready! (hook)" end)
                        end
                    end
                    return __index(p55, p56)(p55, ...)
                end)
            end
            return __index(p55, p56)
        end)
        setreadonly(v568, true)
    end)
end)

-- ── last-resort capture via filtergc ──
task.spawn(function()
    task.wait(1)
    if hasData then return end

    pcall(function()
        local v570
        for _, v572 in filtergc("table", {}) do
            local v573 = true
            for i = 0, 1 do
                local v575 = rawget(v572, i)
                if typeof(v575) ~= "Instance" or not v575:IsA("RemoteEvent") then
                    v573 = false
                    break
                end
            end
            if v573 then
                v570 = v572
                break
            end
        end

        if not v570 then return end

        local t24 = {}
        for _, v in pairs(v570) do
            if type(v) == "string" and v:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") then
                table.insert(t24, v)
            end
        end

        local v579 = rawget(v570, 3)
        if not v579 then return end

        local v580 = t24[rawget(v579, 3)]
        local v581 = rawget(v579, 2)
        if not v580 or not v581 then return end

        local BindableEvent = Instance.new("BindableEvent")
        local FireServer = (game:FindFirstChildWhichIsA("RemoteEvent", true) or Instance.new("RemoteEvent")).FireServer
        local u584
        u584 = hookfunction(FireServer, function(p58, ...)
            if not checkcaller() and (p58:IsA("RemoteEvent") and select(1, ...) == v580 and select(2, ...) == v581) then
                hookfunction(FireServer, u584)
                BindableEvent:Fire(p58)
            end
            return u584(p58, ...)
        end)

        local v585 = BindableEvent.Event:Wait()

        if not hasData then
            hasData = true
            revertedRemotes[v585] = {
                v580, v581, 0.5,
                workspace.CurrentCamera.CFrame,
                {},
                { workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 },
                false
            }
            pcall(function() ST.Text = "Ready! (filtergc)" end)
        end
    end)
end)

task.spawn(function()
    local ok, result = pcall(function()
        return workspace:WaitForChild("Balls", 10)
    end)
    if ok and result then Balls = result end

    if Balls then
        Balls.ChildAdded:Connect(function()
            Sys.__parried = false
            Sys.__antidot_parried = false
        end)
        Balls.ChildRemoved:Connect(function()
            Parries = 0
            Sys.__parried = false
            Sys.__antidot_parried = false
            Phantom = false
            peakSpeed = 0
            if VTL3 then VTL3.Text = "Peak: 0 st/s" end
        end)
    end
end)

local function v90()
    local t25 = {}
    local Balls2 = workspace:FindFirstChild("Balls")
    if not Balls2 then return t25 end
    for _, child in pairs(Balls2:GetChildren()) do
        if child:GetAttribute("realBall") then
            child.CanCollide = false
            table.insert(t25, child)
        end
    end
    return t25
end

local n16 = 0
local function v92()
    local timestamp = tick()
    if timestamp - n16 < 0.1 then return Closest_Entity end
    n16 = timestamp

    local n17 = 1e999
    local v338
    if not Alive then return nil end

    for _, child in pairs(Alive:GetChildren()) do
        if child ~= pl.Character and child.PrimaryPart then
            local v341 = pl:DistanceFromCharacter(child.PrimaryPart.Position)
            if v341 < n17 then
                n17 = v341
                v338 = child
            end
        end
    end

    Closest_Entity = v338
    return v338
end

local function v93()
    if not pl.Character or not pl.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local v342
    local n18 = -1e999
    local CurrentCamera = workspace.CurrentCamera
    if not Alive then return nil end

    local ok, result = pcall(function() return UI:GetMouseLocation() end)
    if not ok then return nil end

    local v347 = CurrentCamera:ScreenPointToRay(result.X, result.Y)
    local cFrame = CFrame.lookAt(v347.Origin, v347.Origin + v347.Direction)

    for _, child in pairs(Alive:GetChildren()) do
        if child ~= pl.Character and child:FindFirstChild("HumanoidRootPart") then
            local Unit = (child.HumanoidRootPart.Position - CurrentCamera.CFrame.Position).Unit
            local v352 = cFrame.LookVector:Dot(Unit)
            if n18 < v352 then
                n18 = v352
                v342 = child
            end
        end
    end

    return v342
end

local function v94()
    local CurrentCamera = workspace.CurrentCamera
    local v354 = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
    if not v354 then return CurrentCamera.CFrame end

    local v355 = v93()
    local v356 = v355 and v355:FindFirstChild("HumanoidRootPart")
    local v357 = v356 and v356.Position or v354.Position + CurrentCamera.CFrame.LookVector * 100

    return ({
        function() return CurrentCamera.CFrame end,
        function()
            local Unit = (v357 - v354.Position).Unit
            local n19 = 0
            local vector3
            repeat
                vector3 = Vector3.new(math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000))
                n19 += 1
            until Unit:Dot((v357 + vector3 - v354.Position).Unit) < 0.95 or n19 > 10
            return CFrame.new(v354.Position, v357 + vector3)
        end,
        function() return CFrame.new(v354.Position, v357 + Vector3.new(0, 5, 0)) end,
        function()
            local Unit = (v354.Position - v357).Unit
            local v591 = v354.Position + Unit * 10000 + Vector3.new(0, 1000, 0)
            return CFrame.new(CurrentCamera.CFrame.Position, v591)
        end,
        function() return CFrame.new(v354.Position, v357 + Vector3.new(0, -9E+18, 0)) end,
        function() return CFrame.new(v354.Position, v357 + Vector3.new(0, 9E+18, 0)) end
    })[Sys.__curve_mode]()
end

local function v95()
    if not Sys.__play_animation then return end

    local Character = pl.Character
    if not Character then return end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local v360 = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
    if not Humanoid or not v360 then return end

    local v361 = skinChangerEnabled and (swordAnimations ~= "" and swordAnimations) or Character:GetAttribute("CurrentlyEquippedSword")
    if not v361 then return end

    pcall(function()
        local Collection = RS.Shared.SwordAPI.Collection
        local GrabParry = Collection.Default:FindFirstChild("GrabParry")
        if not GrabParry then return end

        local v594 = RS.Shared.ReplicatedInstances.Swords.GetSword:Invoke(v361)
        if not v594 or not v594.AnimationType then return end

        for _, child in pairs(Collection:GetChildren()) do
            if child.Name == v594.AnimationType then
                local v597 = not child:FindFirstChild("GrabParry") and "Grab" or "GrabParry"
                if child:FindFirstChild(v597) then
                    GrabParry = child[v597]
                end
            end
        end

        if Sys.__grab_animation and Sys.__grab_animation.IsPlaying then
            Sys.__grab_animation:Stop()
        end

        Sys.__grab_animation = v360:LoadAnimation(GrabParry)
        Sys.__grab_animation.Priority = Enum.AnimationPriority.Action4
        Sys.__grab_animation:Play()
    end)
end

function doFire()
    if not pl.Character then return end

    local CurrentCamera = workspace.CurrentCamera
    local ok, result = pcall(function() return UI:GetMouseLocation() end)
    if not ok then return end

    local t26 = {
        mb and (not pcMode and CurrentCamera.ViewportSize.X / 2) or result.X,
        mb and (not pcMode and CurrentCamera.ViewportSize.Y / 2) or result.Y
    }

    local t27 = {}
    if Alive then
        for _, child in pairs(Alive:GetChildren()) do
            if child.PrimaryPart then
                pcall(function()
                    local v598 = CurrentCamera:WorldToScreenPoint(child.PrimaryPart.Position)
                    t27[child.Name] = v598
                end)
            end
        end
    end

    local v369 = v94()

    if not Sys.__first_parry_done then
        pcall(function()
            for _, v in pairs(getconnections(pl.PlayerGui.Hotbar.Block.Activated)) do
                v:Fire()
            end
        end)
        Sys.__first_parry_done = true
        serverFireCounter += 1
        return
    end

    for k, v in pairs(revertedRemotes) do
        local t28 = { v[1], v[2], v[3], v369, t27, t26, v[7] }
        pcall(function()
            if k:IsA("RemoteEvent") then
                k:FireServer(table.unpack(t28))
                return
            end
            if k:IsA("RemoteFunction") then
                k:InvokeServer(table.unpack(t28))
            end
        end)
    end

    serverFireCounter += 1

    if Parries < 10000 then
        Parries += 1
        task.delay(0.5, function()
            if Parries > 0 then Parries -= 1 end
        end)
    end
end

local t29 = {}
local t30 = {}
local t31 = { 0, 0 }
local cFrame = CFrame.new()
local t32 = {}
local n20 = 0
local u102 = false

local function v103()
    local elapsed = os.clock()
    if elapsed - n20 < 0.016 then return end
    n20 = elapsed

    local CurrentCamera = workspace.CurrentCamera
    local ok, result = pcall(function() return UI:GetMouseLocation() end)

    t31 = {
        mb and (not pcMode and CurrentCamera.ViewportSize.X / 2) or (ok and result.X or CurrentCamera.ViewportSize.X / 2),
        mb and (not pcMode and CurrentCamera.ViewportSize.Y / 2) or (ok and result.Y or CurrentCamera.ViewportSize.Y / 2)
    }
    cFrame = v94()

    local t33 = {}
    if Alive then
        for _, child in pairs(Alive:GetChildren()) do
            if child.PrimaryPart then
                pcall(function()
                    local v601 = CurrentCamera:WorldToScreenPoint(child.PrimaryPart.Position)
                    t33[child.Name] = v601
                end)
            end
        end
    end

    t32 = t33
    t30 = {}
    t29 = {}

    for k, v in pairs(revertedRemotes) do
        table.insert(t29, k)
        table.insert(t30, { v[1], v[2], v[3], cFrame, t32, t31, v[7] })
    end

    u102 = true
end

local function v104()
    if not pl.Character then return end

    if not Sys.__first_parry_done then
        pcall(function()
            for _, v in pairs(getconnections(pl.PlayerGui.Hotbar.Block.Activated)) do
                v:Fire()
            end
        end)
        Sys.__first_parry_done = true
        serverFireCounter += 1
        return
    end

    if not u102 then return end

    for i = 1, #t29 do
        local v383 = t29[i]
        local v384 = t30[i]
        if v383 and v384 then
            pcall(function()
                if v383:IsA("RemoteEvent") then
                    v383:FireServer(table.unpack(v384))
                    return
                end
                v383:InvokeServer(table.unpack(v384))
            end)
        end
    end

    serverFireCounter += 1
end

local u105 = false
local t34 = {}
local t35 = {}

local function v108()
    u105 = false
    ms = false

    for _, v in ipairs(t34) do
        pcall(function() task.cancel(v) end)
    end
    t34 = {}

    for _, v in ipairs(t35) do
        pcall(function() v:Disconnect() end)
    end
    t35 = {}
    u102 = false
end

local function v109()
    if not hasData then
        if ST then ST.Text = "Capturing...wait!" end
        return
    end

    v108()
    u105 = true
    ms = true

    local n21 = 0
    local connection = R.RenderStepped:Connect(function()
        if u105 then v103() end
    end)
    table.insert(t35, connection)

    local co = coroutine.create(function()
        while u105 do
            v104(); v104(); v104()
            local elapsed = os.clock()
            if elapsed - n21 >= 0.008 then
                n21 = elapsed
                task.spawn(v95)
            end
            task.wait(0)
        end
    end)
    coroutine.resume(co)
    table.insert(t34, co)

    local co2 = coroutine.create(function()
        while u105 do
            v104(); v104(); v104()
            task.wait(0)
        end
    end)
    coroutine.resume(co2)
    table.insert(t34, co2)

    local connection2 = R.Stepped:Connect(function()
        if u105 then v104(); v104() end
    end)
    table.insert(t35, connection2)

    local connection3 = R.PreSimulation:Connect(function()
        if u105 then v104(); v104() end
    end)
    table.insert(t35, connection3)
end

SB.MouseButton1Click:Connect(function()
    if u105 then
        v108()
        pcall(function()
            TS:Create(SB, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
        end)
        return
    end

    v109()
    pcall(function()
        TS:Create(SB, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = Color3.fromRGB(138, 43, 226) }):Play()
    end)
end)

UI.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F and not UI:GetFocusedTextBox() then
        if u105 then
            v108()
            pcall(function()
                TS:Create(SB, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = C.A }):Play()
            end)
            return
        end

        v109()
        pcall(function()
            TS:Create(SB, TweenInfo.new(0.1, Enum.EasingStyle.Quart), { BackgroundColor3 = Color3.fromRGB(138, 43, 226) }):Play()
        end)
    end
end)

R.Heartbeat:Connect(function()
    if not u105 then
        SB.BackgroundColor3 = C.A
    end
end)

pcall(function()
    RS.Remotes.ParrySuccess.OnClientEvent:Connect(function()
        if S.HS and hitSound then
            pcall(function() hitSound:Play() end)
        end
    end)
end)

pcall(function()
    RS.Remotes.InfinityBall.OnClientEvent:Connect(function(_, p60)
        Infinity = p60 or false
        Sys.__infinity_active = p60 or false
    end)
end)

pcall(function()
    RS.Remotes.DeathBall.OnClientEvent:Connect(function(_, p62)
        Sys.__deathslash_active = p62 or false
    end)
end)

local t40 = {
    __lerp_radians = 0,
    __last_warping = tick(),
    __curving = tick(),
    __aerodynamic_time = tick()
}

local function v111()
    local v414
    if Balls then
        for _, child in ipairs(Balls:GetChildren()) do
            if child:GetAttribute("realBall") then
                v414 = child
                break
            end
        end
    end
    if not v414 then return false end

    local zoomies = v414:FindFirstChild("zoomies")
    if not zoomies then return false end

    local VectorVelocity = zoomies.VectorVelocity
    local Magnitude = VectorVelocity.Magnitude
    if Magnitude < 1 then return false end

    local Unit = VectorVelocity.Unit
    local Character = pl.Character
    if not Character or not Character.PrimaryPart then return false end

    local PrimaryPartPosition = Character.PrimaryPart.Position
    local Unit2 = (PrimaryPartPosition - v414.Position).Unit
    local v424 = Unit2:Dot(Unit)

    local Value = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    local v426 = Value / 1000
    local Magnitude2 = (PrimaryPartPosition - v414.Position).Magnitude
    local v428 = Magnitude2 / Magnitude - v426
    local v429 = math.min(Magnitude / 100, 40)
    local v430 = 15 - math.min(Magnitude2 / 1000, 15) + v429

    if Magnitude > 100 and v428 > Value / 10 then
        v430 = math.max(v430 - 15, 15)
    end
    if Magnitude2 < v430 * 0.85 then return false end

    local v431 = math.clamp(v424, -1, 1)
    local v432 = math.rad(math.asin(v431))
    local v433 = math.asin(v431)
    t40.__lerp_radians = t40.__lerp_radians + ((v432 + v433) * 0.5 - t40.__lerp_radians) * 0.82

    local v436 = math.clamp((math.clamp(0.55 - v426 * 0.75, -1, 0.45) + (0.5 - v426)) * 0.5, -1, 0.45)
    if v436 > v424 - Unit2:Dot((Unit - VectorVelocity).Unit) then return true end
    if t40.__lerp_radians < 0.017 then t40.__last_warping = tick() end
    if tick() - t40.__last_warping < v428 / 1.45 then return true end
    if tick() - t40.__curving < v428 / 1.3 then return true end

    return v424 < v436
end

pcall(function()
    RS.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
        local v610 = ({ ... })[1]
        if v610 == pl or v610 == pl.Name or (v610 and v610.Name == pl.Name) then
            Sys.__timehole_active = true
        end
    end)
end)

pcall(function()
    RS.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
        Sys.__timehole_active = false
    end)
end)

pcall(function()
    RS.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, p64)
        if p64 and (p64.Parent and p64.Parent ~= pl.Character) and (not Alive or p64.Parent.Parent ~= Alive) then
            return
        end

        local v613
        if Balls then
            for _, child in ipairs(Balls:GetChildren()) do
                if child:GetAttribute("realBall") then
                    v613 = child
                    break
                end
            end
        end
        if not v613 then return end

        local zoomies = v613:FindFirstChild("zoomies")
        if zoomies and (pl.Character.PrimaryPart.Position - v613.Position).Unit:Dot(zoomies.VectorVelocity.Unit) < 0.5 then
            t40.__curving = tick()
        end
    end)
end)

-- ── AP loop with connection-leak fix ──
local watchedBalls = setmetatable({}, { __mode = "k" })
local watchedTraining = setmetatable({}, { __mode = "k" })
local connection

R.Heartbeat:Connect(function()
    if S.AP and not connection then
        connection = R.RenderStepped:Connect(function()
            if not S.AP or (not pl.Character or not pl.Character.PrimaryPart) then return end

            local v617 = v90()
            local v618
            if TrainingBalls then
                for _, child in ipairs(TrainingBalls:GetChildren()) do
                    if child:GetAttribute("realBall") then
                        v618 = child
                        break
                    end
                end
            end

            for _, v in ipairs(v617) do
                if not v then continue end

                local zoomies = v:FindFirstChild("zoomies")
                if not zoomies then continue end

                if not watchedBalls[v] then
                    watchedBalls[v] = true
                    v:GetAttributeChangedSignal("target"):Connect(function()
                        Sys.__parried = false
                        Sys.__antidot_parried = false
                    end)
                end

                if Sys.__parried then continue end

                local target = v:GetAttribute("target")
                local VectorVelocity = zoomies.VectorVelocity
                local Magnitude = (pl.Character.PrimaryPart.Position - v.Position).Magnitude
                local Value = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                local v628 = math.clamp(Value / 10, 5, 17)
                local Magnitude3 = VectorVelocity.Magnitude

                if Magnitude3 <= 0 then continue end

                local v630 = v628 + math.max(Magnitude3 / ((math.min(math.max(Magnitude3 - 9.5, 0), 650) * 0.002 + 2.5) * Speed_Divisor_Multiplier), 9.5) + math.clamp(Value / 1000 * Magnitude3, 0, 30)

                if Magnitude3 > 1500 then
                    v630 *= math.clamp(1 + (Magnitude3 - 1500) / 1000, 1.5, 3.5)
                end

                local v631 = (pl.Character.PrimaryPart.Position - v.Position).Unit:Dot(VectorVelocity.Unit)

                if target ~= pl.Name and v631 < 0.1 then continue end

                if v:FindFirstChild("AeroDynamicSlashVFX") then
                    pcall(function() v.AeroDynamicSlashVFX:Destroy() end)
                    t40.__aerodynamic_time = tick()
                end

                if (Runtime and Runtime:FindFirstChild("Tornado") and (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 > tick() - Sys.__tornado_time)
                    or (v111() and target == pl.Name)
                    or v:FindFirstChild("ComboCounter")
                    or pl.Character.PrimaryPart:FindFirstChild("SingularityCape")
                    or (S.ID and Sys.__infinity_active)
                then
                    continue
                end

                local v632 = v92()

                if v632 and not Sys.__antidot_parried
                    and (pl.Character.PrimaryPart.Position - v632.PrimaryPart.Position).Magnitude <= 30
                    and v631 > 0.75
                    and target == pl.Name
                    and Magnitude <= 30
                then
                    doFire()
                    Sys.__parried = true
                    Sys.__antidot_parried = true
                end

                if S.TB and v632 and target == v632.Name then
                    if (pl.Character.PrimaryPart.Position - v632.PrimaryPart.Position).Magnitude <= 35 and target == pl.Name and Magnitude <= v630 then
                        doFire()
                        Sys.__parried = true
                    end
                elseif target == pl.Name and Magnitude <= v630 then
                    if Parries > 7 then continue end
                    Parries += 1
                    task.delay(0.5, function()
                        if Parries > 0 then Parries -= 1 end
                    end)
                    doFire()
                    Sys.__parried = true
                end

                if Sys.__parried then
                    local timestamp = tick()
                    repeat
                        R.RenderStepped:Wait()
                    until tick() - timestamp >= 1 or not Sys.__parried
                    Sys.__parried = false
                    Sys.__antidot_parried = false
                end
            end

            if v618 and S.LAP then
                local zoomies = v618:FindFirstChild("zoomies")
                if zoomies then
                    if not watchedTraining[v618] then
                        watchedTraining[v618] = true
                        v618:GetAttributeChangedSignal("target"):Connect(function()
                            Sys.__training_parried = false
                        end)
                    end

                    if not Sys.__training_parried then
                        local target = v618:GetAttribute("target")
                        local Magnitude = zoomies.VectorVelocity.Magnitude
                        local v637 = pl:DistanceFromCharacter(v618.Position)
                        local Value = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                        local v639 = math.clamp(Value / 10, 5, 17)
                            + math.max(Magnitude / ((math.min(math.max(Magnitude - 9.5, 0), 650) * 0.002 + 2.5) * Speed_Divisor_Multiplier), 9.5)
                            + math.clamp(Value / 1000 * Magnitude, 0, 30)

                        if Magnitude > 1500 then
                            v639 *= math.clamp(1 + (Magnitude - 1500) / 1000, 1.5, 3.5)
                        end

                        if target == pl.Name and v637 <= v639 then
                            doFire()
                            Sys.__training_parried = true
                            local timestamp = tick()
                            repeat
                                R.RenderStepped:Wait()
                            until tick() - timestamp >= 1 or not Sys.__training_parried
                            Sys.__training_parried = false
                        end
                    end
                end
            end
        end)
        return
    end

    if not S.AP and connection then
        connection:Disconnect()
        connection = nil
    end
end)

local connection4
R.Heartbeat:Connect(function()
    if S.AS and not connection4 then
        connection4 = R.RenderStepped:Connect(function()
            if not S.AS then return end

            local Character = pl.Character
            if not Character or not Character.PrimaryPart then return end
            if not Alive or Character.Parent ~= Alive then return end

            local timestamp = tick()
            if timestamp - (Sys.__last_spam_check or 0) < 0.008 then return end
            Sys.__last_spam_check = timestamp

            local v643
            if Balls then
                for _, child in ipairs(Balls:GetChildren()) do
                    if child:GetAttribute("realBall") then
                        v643 = child
                        break
                    end
                end
            end
            if not v643 then return end
            if not v643:FindFirstChild("zoomies") then return end

            if timestamp - (Sys.__target_check_time or 0) > 0.1 then
                Sys.__target_check_time = timestamp
                local v646 = v92()
                if v646 then
                    if Sys.__spam_target and (not Sys.__spam_target.Parent or not Sys.__spam_target:FindFirstChild("Humanoid") or Sys.__spam_target.Humanoid.Health <= 0) then
                        Sys.__spam_target = nil
                    end
                    if not Sys.__spam_target or timestamp - (Sys.__spam_target_time or 0) > 1 then
                        Sys.__spam_target = v646
                        Sys.__spam_target_time = timestamp
                    end
                end
            end

            local target = v643:GetAttribute("target")
            if not target then return end

            local v648 = v643.AssemblyLinearVelocity or Vector3.zero
            local Magnitude = v648.Magnitude
            if Magnitude < 5 then return end

            local PrimaryPart = Character.PrimaryPart
            local v651 = (PrimaryPart.Position - v643.Position).Unit:Dot(v648.Unit)
            local v652 = math.clamp(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, 1, 16) + math.min(Magnitude / 6, 95)
            local v653 = 5 - math.min(Magnitude / 5, 5)
            local v654 = v652 - math.clamp(v651, -1, 0) * v653

            local _Closest_Entity = Closest_Entity
            if not _Closest_Entity or not _Closest_Entity.PrimaryPart then return end

            local Magnitude4 = (PrimaryPart.Position - _Closest_Entity.PrimaryPart.Position).Magnitude
            local v657 = pl:DistanceFromCharacter(v643.Position)
            local v658 = pl:DistanceFromCharacter(_Closest_Entity.PrimaryPart.Position)

            if v652 < Magnitude4 then return end
            if v654 < v657 then return end
            if v652 < v658 then return end
            if target == pl.Name and v658 > 30 and v657 > 30 then return end
            if Character:GetAttribute("Pulsed") then return end

            local __spam_target = Sys.__spam_target
            if not __spam_target then return end
            if target ~= __spam_target.Name and target ~= pl.Name then return end

            if v658 <= v654 and v657 <= v654 and Parries > ParryThreshold then
                doFire()
                if Sys.__play_animation then v95() end
            end
        end)
        return
    end

    if not S.AS and connection4 then
        connection4:Disconnect()
        connection4 = nil
    end
end)

R.Heartbeat:Connect(function()
    pcall(function()
        if not S.LAS then return end

        local timestamp = tick()
        if timestamp - lobbySpamDB < 0.06 then return end

        if not TrainingBalls then TrainingBalls = workspace:FindFirstChild("TrainingBalls") end
        if not TrainingBalls then return end

        local v661
        for _, child in ipairs(TrainingBalls:GetChildren()) do
            if child:GetAttribute("realBall") then
                v661 = child
                break
            end
        end
        if not v661 then return end

        local zoomies = v661:FindFirstChild("zoomies")
        if not zoomies then return end

        local Magnitude = zoomies.VectorVelocity.Magnitude
        local v666 = pl:DistanceFromCharacter(v661.Position)
        local v667 = math.clamp(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 10 / 10, 5, 17)
            + math.max(Magnitude / ((math.min(math.max(Magnitude - 9.5, 0), 650) * 0.002 + 2.5) * Speed_Divisor_Multiplier), 9.5)

        if Magnitude > 2000 then v667 *= 2 end

        if v661:GetAttribute("target") == pl.Name and v666 <= v667 then
            lobbySpamDB = timestamp
            doFire()
        end
    end)
end)

R.Heartbeat:Connect(function()
    pcall(function()
        for k, v in pairs(HL) do
            if not k or not k.Parent then
                pcall(function() v:Destroy() end)
                HL[k] = nil
            end
        end

        if not S.PE and not S.SK then
            for k, v in pairs(HL) do
                pcall(function() v:Destroy() end)
                HL[k] = nil
            end
            return
        end

        for _, player in ipairs(P:GetPlayers()) do
            if player ~= pl and player.Character then
                local v674 = isStaff(player)

                if S.PE or (S.SK and v674) then
                    if not HL[player] then
                        local Highlight = Instance.new("Highlight")
                        Highlight.Adornee = player.Character
                        Highlight.FillColor = v674 and Color3.fromRGB(255, 50, 50) or C.A
                        Highlight.OutlineColor = v674 and Color3.fromRGB(255, 200, 0) or C.A2
                        Highlight.FillTransparency = 0.5
                        Highlight.OutlineTransparency = 0
                        Highlight.Parent = workspace
                        HL[player] = Highlight
                    end

                    if S.DE then
                        local v676 = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                        local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        if v676 and HumanoidRootPart then
                            HL[player].Name = math.floor((HumanoidRootPart.Position - v676.Position).Magnitude) .. "st" .. (not v674 and "" or "[S]")
                        end
                    end
                elseif HL[player] then
                    pcall(function() HL[player]:Destroy() end)
                    HL[player] = nil
                end
            end
        end
    end)
end)

R.Heartbeat:Connect(function()
    pcall(function()
        local v678
        if Balls then
            for _, child in ipairs(Balls:GetChildren()) do
                if child:GetAttribute("realBall") then
                    v678 = child
                    break
                end
            end
        end

        if not S.BE then
            if BHL then BHL:Destroy(); BHL = nil end
            return
        end

        if v678 and not BHL then
            BHL = Instance.new("Highlight")
            BHL.Adornee = v678
            BHL.FillColor = C.A2
            BHL.OutlineColor = C.A
            BHL.FillTransparency = 0.3
            BHL.OutlineTransparency = 0
            BHL.Parent = workspace
        end

        if BHL and not v678 then BHL:Destroy(); BHL = nil end
    end)
end)

R.Heartbeat:Connect(function()
    pcall(function()
        local v681
        if Balls then
            for _, child in ipairs(Balls:GetChildren()) do
                if child:GetAttribute("realBall") then
                    v681 = child
                    break
                end
            end
        end

        if not S.BT or not v681 then
            if TLb then TLb:Destroy(); TLb = nil end
            return
        end

        if not TLb then
            TLb = Instance.new("SelectionBox")
            TLb.Color3 = C.A2
            TLb.LineThickness = 0.06
            TLb.SurfaceTransparency = 1
            TLb.Parent = workspace
        end
        TLb.Adornee = v681
    end)
end)

R.Heartbeat:Connect(function()
    pcall(function()
        if VTUI then VTUI.Visible = S.VT end

        if not S.VT then
            if VTL1 then VTL1.Text = "-- st/s" end
            if VTL2 then VTL2.Text = "X:0 Y:0 Z:0" end
            return
        end

        local v684
        if Balls then
            for _, child in ipairs(Balls:GetChildren()) do
                if child:GetAttribute("realBall") then
                    v684 = child
                    break
                end
            end
        end

        if not v684 then
            if VTL1 then VTL1.Text = "-- st/s" end
            if VTL2 then VTL2.Text = "X:0 Y:0 Z:0" end
            if VTL3 then VTL3.Text = "Peak: " .. peakSpeed .. " st/s" end
            return
        end

        local zoomies = v684:FindFirstChild("zoomies")
        local v688 = zoomies and zoomies.VectorVelocity or (v684.AssemblyLinearVelocity or Vector3.zero)
        local v689 = math.floor(v688.Magnitude)

        if v689 > peakSpeed then
            peakSpeed = v689
            if VTL3 then VTL3.Text = "Peak: " .. peakSpeed .. " st/s" end
        end

        local Character = pl.Character
        local v691 = Character and Character:FindFirstChild("HumanoidRootPart")
        local s1 = ""

        if v691 and v688.Magnitude > 1 then
            local v693 = v688.Unit:Dot((v691.Position - v684.Position).Unit)
            if v693 > 0.3 then
                s1 = " → YOU"
            elseif v693 < -0.3 then
                s1 = " ← AWAY"
            end
        end

        if VTL1 then
            VTL1.Text = v689 .. " st/s" .. s1
            VTL1.TextColor3 = v689 > 150 and Color3.fromRGB(255, 50, 50) or (v689 > 60 and Color3.fromRGB(255, 180, 0) or C.A)
        end

        if VTL2 then
            VTL2.Text = string.format("X:%.0f Y:%.0f Z:%.0f", v688.X, v688.Y, v688.Z)
        end
    end)
end)

R.Heartbeat:Connect(function()
    pcall(function()
        if not S.RE then return end

        local v694 = tick() % 4 / 4

        for _, v in pairs(HL) do
            v.FillColor = Color3.fromHSV(v694, 1, 1)
            v.OutlineColor = Color3.fromHSV((v694 + 0.5) % 1, 1, 1)
        end

        if BHL then
            BHL.FillColor = Color3.fromHSV((v694 + 0.25) % 1, 1, 1)
        end
    end)
end)

local t41 = {
    gui_name = "AbilityESPGui",
    text_size = 14,
    update_rate = 0.03333333333333333,
    gui_size = UDim2.new(0, 200, 0, 40),
    studs_offset = Vector3.new(0, 3.2, 0),
    text_color = Color3.fromRGB(255, 255, 255),
    stroke_color = Color3.fromRGB(0, 0, 0),
    font = Enum.Font.GothamBold
}

local function v115(p65)
    local Character = p65.Character
    if not Character or not Character.Parent then return nil end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return nil end

    local Head = Character:FindFirstChild("Head")
    if not Head then return nil end

    local t41gui_name = Head:FindFirstChild(t41.gui_name)
    if t41gui_name then t41gui_name:Destroy() end

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = t41.gui_name
    BillboardGui.Adornee = Head
    BillboardGui.Size = t41.gui_size
    BillboardGui.StudsOffset = t41.studs_offset
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = Head

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = t41.text_color
    TextLabel.TextStrokeColor3 = t41.stroke_color
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.Font = t41.font
    TextLabel.TextSize = t41.text_size
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    TextLabel.Parent = BillboardGui

    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

    return TextLabel, BillboardGui
end

local function v116(p66, p67)
    if not p66 or (not p66.Parent or not p67 or not p67.Parent) then return false end

    local Character = p66.Character
    if not Character or not Character.Parent or not Character:FindFirstChildOfClass("Humanoid") then
        return false
    end

    if S.AE then
        p67.Visible = true
        local EquippedAbility = p66:GetAttribute("EquippedAbility")
        p67.Text = EquippedAbility and (p66.DisplayName .. "  [" .. EquippedAbility .. "]") or p66.DisplayName
    else
        p67.Visible = false
    end

    return true
end

local function v117(p68)
    if not S.AE then return end
    task.wait(0.1)

    local Character = p68.Character
    if not Character or not Character.Parent or not Character:FindFirstChildOfClass("Humanoid") then return end

    local v456, v457 = v115(p68)
    if not v456 then return end

    if not AE_STATE.players[p68] then
        AE_STATE.players[p68] = {}
    end

    AE_STATE.players[p68].label = v456
    AE_STATE.players[p68].billboard = v457
    AE_STATE.players[p68].character = Character

    Character.AncestryChanged:Connect(function()
        if not Character.Parent and AE_STATE.players[p68] then
            if AE_STATE.players[p68].billboard then
                AE_STATE.players[p68].billboard:Destroy()
            end
            AE_STATE.players[p68].label = nil
            AE_STATE.players[p68].billboard = nil
            AE_STATE.players[p68].character = nil
        end
    end)

    pcall(function()
        Character:GetAttributeChangedSignal("EquippedAbility"):Connect(function()
            if AE_STATE.players[p68] and AE_STATE.players[p68].label then
                v116(p68, AE_STATE.players[p68].label)
            end
        end)
    end)
end

local function v118(p69)
    if AE_STATE.players[p69] then
        if AE_STATE.players[p69].billboard then
            pcall(function() AE_STATE.players[p69].billboard:Destroy() end)
        end
        AE_STATE.players[p69] = nil
    end
    AEGUI[p69] = nil
end

local function v119(p70)
    if p70 == pl then return end
    v118(p70)
    AEGUI[p70] = true
    p70.CharacterAdded:Connect(function() v117(p70) end)
    if p70.Character then
        task.spawn(function() v117(p70) end)
    end
end

local function v120()
    while S.AE do
        task.wait(t41.update_rate)
        local t42 = {}
        for k, v in pairs(AE_STATE.players) do
            if not k or not k.Parent then
                table.insert(t42, k)
            else
                local Character = k.Character
                if not Character or not Character.Parent or not Character:FindFirstChildOfClass("Humanoid") then
                    if v.billboard then
                        pcall(function() v.billboard:Destroy() end)
                        v.billboard = nil
                        v.label = nil
                    end
                elseif v.label then
                    v116(k, v.label)
                end
            end
        end
        for _, v in ipairs(t42) do v118(v) end
    end
end

local function v121()
    AE_STATE.active = true
    for _, player in ipairs(P:GetPlayers()) do v119(player) end
    P.PlayerAdded:Connect(function(player)
        if player ~= pl then v119(player) end
    end)
    task.spawn(v120)
end

local function v122()
    AE_STATE.active = false
    for k in pairs(AE_STATE.players) do v118(k) end
    AEGUI = {}
end

R.Heartbeat:Connect(function()
    if S.AE and not AE_STATE.active then
        AE_STATE.active = true
        v121()
        return
    end
    if not S.AE and AE_STATE.active then
        AE_STATE.active = false
        v122()
    end
end)

for _, player in ipairs(P:GetPlayers()) do
    if player ~= pl then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            if S.AE then v117(player) end
        end)
    end
end

P.PlayerAdded:Connect(function(player)
    if player ~= pl then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            if S.AE then v117(player) end
        end)
    end
end)

pl.CharacterAdded:Connect(function()
    task.wait(0.5)
    if S.AE then
        for _, player in ipairs(P:GetPlayers()) do
            if player ~= pl then v117(player) end
        end
    end
end)

local function v125(p71)
    if KSS_curSound then
        pcall(function()
            KSS_curSound:Stop()
            KSS_curSound:Destroy()
        end)
        KSS_curSound = nil
    end

    local Part = Instance.new("Part")
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.1, 0.1, 0.1)
    Part.Position = p71 or Vector3.new(0, 0, 0)
    Part.Parent = workspace

    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://" .. KSS_selected
    Sound.Volume = 0.7
    Sound.RollOffMode = Enum.RollOffMode.Linear
    Sound.MaxDistance = 500
    Sound.Parent = Part
    KSS_curSound = Sound
    Sound:Play()
    DB:AddItem(Part, 5)
end

local function v126(p72)
    if p72.Character then
        task.spawn(function()
            local Character = p72.Character
            local Humanoid = Character:WaitForChild("Humanoid", 5)
            if Humanoid then
                Humanoid.Died:Connect(function()
                    if p72 ~= pl then
                        local v740 = Character
                        if not S.KS then return end
                        local timestamp = tick()
                        if timestamp - KSS_lastKill < 0.3 then return end
                        KSS_lastKill = timestamp
                        local v742 = v740 and (not not v740.PrimaryPart and v740.PrimaryPart.Position) or workspace.CurrentCamera.CFrame.Position
                        v125(v742)
                    end
                end)
            end
        end)
    end

    p72.CharacterAdded:Connect(function(character)
        local Humanoid = character:WaitForChild("Humanoid", 5)
        if Humanoid then
            Humanoid.Died:Connect(function()
                if p72 ~= pl then
                    local v737 = character
                    if not S.KS then return end
                    local timestamp = tick()
                    if timestamp - KSS_lastKill < 0.3 then return end
                    KSS_lastKill = timestamp
                    local v739 = v737 and (not not v737.PrimaryPart and v737.PrimaryPart.Position) or workspace.CurrentCamera.CFrame.Position
                    v125(v739)
                end
            end)
        end
    end)
end

local function v127()
    for _, player in ipairs(P:GetPlayers()) do v126(player) end
    KSS_conns.playerAdded = P.PlayerAdded:Connect(function(player) v126(player) end)
end

local function v128()
    if KSS_curSound then
        pcall(function()
            KSS_curSound:Stop()
            KSS_curSound:Destroy()
        end)
        KSS_curSound = nil
    end
    for _, v in pairs(KSS_conns) do
        pcall(function() v:Disconnect() end)
    end
    KSS_conns = {}
end

R.Heartbeat:Connect(function()
    if S.KS and not KSS_conns.playerAdded then
        v127()
        return
    end
    if not S.KS and KSS_conns.playerAdded then
        v128()
    end
end)

R.Heartbeat:Connect(function()
    if not S.NR then
        if noRenderConn then
            pcall(function() noRenderConn:Disconnect() end)
            noRenderConn = nil
        end
    elseif not noRenderConn and Runtime then
        noRenderConn = Runtime.ChildAdded:Connect(function(child)
            DB:AddItem(child, 0)
        end)
    end

    if not S.NR2 then
        if noRender2Conn then
            pcall(function() noRender2Conn:Disconnect() end)
            noRender2Conn = nil
        end
        pcall(function()
            local EffectScripts = pl.PlayerScripts:FindFirstChild("EffectScripts")
            if EffectScripts then
                local ClientFX = EffectScripts:FindFirstChild("ClientFX")
                if ClientFX then ClientFX.Disabled = false end
            end
        end)
        return
    end

    pcall(function()
        local EffectScripts = pl.PlayerScripts:FindFirstChild("EffectScripts")
        if EffectScripts then
            local ClientFX = EffectScripts:FindFirstChild("ClientFX")
            if ClientFX then ClientFX.Disabled = true end
        end
    end)
end)

local lib
local u130

task.spawn(function()
    pcall(function()
        local Swords = RS:WaitForChild("Shared", 10):WaitForChild("ReplicatedInstances", 10):WaitForChild("Swords", 10)
        lib = require(Swords)
    end)
end)

task.spawn(function()
    local timestamp = tick()
    while not u130 and tick() - timestamp < 15 do
        task.wait()
        pcall(function()
            for _, v in ipairs(getconnections(RS.Remotes.FireSwordInfo.OnClientEvent)) do
                if not v.Function or not islclosure(v.Function) then continue end
                local v711 = getupvalues(v.Function)
                if #v711 == 1 and type(v711[1]) == "table" then
                    u130 = v711[1]
                    return
                end
            end
        end)
    end
end)

local s2 = "SlashEffect"
local Function

task.spawn(function()
    local timestamp = tick()
    repeat
        task.wait()
        for _, v in ipairs(getconnections(RS.Remotes.ParrySuccessAll.OnClientEvent)) do
            if not v.Function then continue end
            local ok, result = pcall(function() return getinfo(v.Function) end)
            if ok and result and result.name == "parrySuccessAll" then
                Function = v.Function
                v:Disable()
                break
            end
        end
    until Function or tick() - timestamp > 5

    if Function then
        RS.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
            setthreadidentity(2)
            local t43 = { ... }
            if tostring(t43[4]) ~= tostring(pl) then
                return Function(unpack(t43))
            end
            if skinChangerEnabled and S.SC and swordFX ~= "" then
                t43[1] = s2
                t43[3] = swordFX
            end
            return Function(unpack(t43))
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
        if skinChangerEnabled and S.SC then
            pcall(function()
                local Character = pl.Character
                if not Character then return end

                if swordModel ~= "" then
                    if pl:GetAttribute("CurrentlyEquippedSword") ~= swordModel and skinChangerEnabled and S.SC and setupvalue and lib then
                        pcall(function()
                            setupvalue(rawget(lib, "EquipSwordTo"), 3, false)
                            if swordModel ~= "" then lib:EquipSwordTo(pl.Character, swordModel) end
                            if swordAnimations ~= "" and u130 and u130.SetSword then u130:SetSword(swordAnimations) end
                        end)
                    end

                    if not Character:FindFirstChild(swordModel) and skinChangerEnabled and S.SC and setupvalue and lib then
                        pcall(function()
                            setupvalue(rawget(lib, "EquipSwordTo"), 3, false)
                            if swordModel ~= "" then lib:EquipSwordTo(pl.Character, swordModel) end
                            if swordAnimations ~= "" and u130 and u130.SetSword then u130:SetSword(swordAnimations) end
                        end)
                    end

                    for _, child in ipairs(Character:GetChildren()) do
                        if child:IsA("Model") and child.Name ~= swordModel then
                            pcall(function() child:Destroy() end)
                        end
                        task.wait()
                    end
                end
            end)
        end
    end
end)

R.Heartbeat:Connect(function()
    if S.SC and (skinChangerEnabled and swordFX ~= "" and swordFX ~= "") then
        local _swordFX = swordFX
        local s3
        if not _swordFX or _swordFX == "" then
            s3 = "SlashEffect"
        elseif not lib then
            s3 = "SlashEffect"
        else
            local ok, result = pcall(function()
                local Sword = lib:GetSword(_swordFX)
                return Sword and Sword.SlashName or "SlashEffect"
            end)
            s3 = ok and result or "SlashEffect"
        end
        s2 = s3
    end
end)

task.spawn(function()
    local v500 = false
    while task.wait(0.5) do
        if S.FP and not v500 then
            v500 = true
            pcall(function()
                L.GlobalShadows = false
                L.Brightness = 1
                L.FogEnd = 100000
                for _, descendant in ipairs(game:GetDescendants()) do
                    pcall(function()
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Smoke") or descendant:IsA("Fire") then
                            descendant:Destroy()
                            return
                        end
                        if descendant:IsA("BasePart") then
                            descendant.Material = Enum.Material.Plastic
                            descendant.Reflectance = 0
                            descendant.Color = Color3.fromRGB(0, 0, 0)
                        end
                    end)
                end
            end)
        elseif not S.FP then
            v500 = false
        end
    end
end)

R.Heartbeat:Connect(function()
    if not S.FB then return end
    pcall(function()
        L.Ambient = Color3.new(1, 1, 1)
        L.OutdoorAmbient = Color3.new(1, 1, 1)
        L.Brightness = 2
    end)
end)

local n26 = 0
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local v721
            if Balls then
                for _, child in ipairs(Balls:GetChildren()) do
                    if child:GetAttribute("realBall") then
                        v721 = child
                        break
                    end
                end
            end
            local v724 = v721 and math.floor((v721.AssemblyLinearVelocity or Vector3.zero).Magnitude) or 0
            local v725 = math.floor((serverFireCounter - n26) / 0.5)
            n26 = serverFireCounter
            if ST then
                if not hasData then
                    ST.Text = "EclipseNexus Capturing..."
                else
                    ST.Text = string.format("CPS:%d Ball:%dst/s", v725, v724)
                end
            end
            if SD then
                SD.BackgroundColor3 = hasData and C.A or Color3.fromRGB(60, 60, 90)
            end
        end)
    end
end)

local function v134(p73, p74, p75)
    local v504 = Instance.new(p73)
    for k, v in pairs(p75 or {}) do
        pcall(function() v504[k] = v end)
    end
    v504.Parent = p74
    return v504
end

musicSound = Instance.new("Sound")
musicSound.Name = "ENX_Music"
musicSound.Volume = 0.8
musicSound.Looped = true
musicSound.Parent = workspace

local t44 = {
    { name = "Multo", id = 7492665376 },
    { name = "Love Me Not", id = 1843619980 },
    { name = "Back To Being Friends", id = 6838623385 },
    { name = "Sana (Single)", id = 3108025828 }
}

MkSec(MU, "YouTube Music Player")
local v136 = v134("TextButton", MU, {
    Text = "▶  Open YouTube Music",
    TextSize = 12,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = Color3.fromRGB(180, 0, 0),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v134("UICorner", v136, { CornerRadius = UDim.new(0, 10) })
v136.MouseButton1Click:Connect(function()
    pcall(function()
        v136.Text = "Loading..."
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-YouTube-Music-Player-72222"))()
        v136.Text = "▶  YouTube Music Active"
    end)
end)

MkSec(MU, "Now Playing")
nowPlayingLabel = v134("TextLabel", MU, {
    BorderSizePixel = 0,
    TextSize = 11,
    Text = "♪ None",
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = C.C,
    Font = Enum.Font.GothamBold,
    TextColor3 = C.A,
    TextXAlignment = Enum.TextXAlignment.Center
})
v134("UICorner", nowPlayingLabel, { CornerRadius = UDim.new(0, 10) })

MkSec(MU, "Songs")
for i, v in ipairs(t44) do
    local v139 = v134("Frame", MU, {
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = C.C
    })
    v134("UICorner", v139, { CornerRadius = UDim.new(0, 10) })
    v134("UIStroke", v139, { Thickness = 1, Color = C.OF })
    v134("TextLabel", v139, {
        BackgroundTransparency = 1,
        TextSize = 11,
        ZIndex = 3,
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Text = v.name,
        Font = Enum.Font.GothamMedium,
        TextColor3 = C.TX,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local v140 = v134("TextButton", v139, {
        Text = "▶",
        TextSize = 13,
        AutoButtonColor = false,
        ZIndex = 4,
        Size = UDim2.fromOffset(36, 26),
        Position = UDim2.new(1, -42, 0.5, -13),
        BackgroundColor3 = C.A,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.new(1, 1, 1)
    })
    v134("UICorner", v140, { CornerRadius = UDim.new(0, 6) })
    songBtns[i] = v140

    v140.MouseButton1Click:Connect(function()
        if currentMusicIdx == i then
            pcall(function()
                musicSound:Stop()
                musicSound.SoundId = ""
            end)
            currentMusicIdx = 0
            v140.Text = "▶"
            v140.BackgroundColor3 = C.A
            if nowPlayingLabel then nowPlayingLabel.Text = "♪ None" end
            return
        end

        pcall(function()
            musicSound:Stop()
            musicSound.SoundId = ""
        end)
        currentMusicIdx = 0
        for _, v2 in pairs(songBtns) do
            v2.Text = "▶"
            v2.BackgroundColor3 = C.A
        end
        currentMusicIdx = i
        v140.Text = "■"
        v140.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        if nowPlayingLabel then nowPlayingLabel.Text = "♪ " .. v.name end

        local id = v.id
        task.spawn(function()
            pcall(function()
                musicSound:Stop()
                task.wait(0.05)
                musicSound.SoundId = "rbxassetid://" .. tostring(id)
                local timestamp = tick()
                repeat task.wait(0.1) until musicSound.IsLoaded or tick() - timestamp > 8
                if musicSound.IsLoaded then musicSound:Play() end
            end)
        end)
    end)
end

MkSec(MU, "Custom ID")
local v141 = v134("Frame", MU, {
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = C.C
})
v134("UICorner", v141, { CornerRadius = UDim.new(0, 10) })
v134("UIStroke", v141, { Thickness = 1, Color = C.OF })

local v142 = v134("TextBox", v141, {
    BorderSizePixel = 0,
    PlaceholderText = "Paste audio ID...",
    TextSize = 10,
    ClearTextOnFocus = false,
    ZIndex = 3,
    Size = UDim2.new(1, -72, 1, -8),
    Position = UDim2.new(0, 8, 0, 4),
    BackgroundColor3 = C.BG,
    Font = Enum.Font.Gotham,
    TextColor3 = C.TX,
    PlaceholderColor3 = C.SB
})
v134("UICorner", v142, { CornerRadius = UDim.new(0, 6) })

local v143 = v134("TextButton", v141, {
    Text = "▶ Play",
    TextSize = 9,
    AutoButtonColor = false,
    ZIndex = 4,
    Size = UDim2.fromOffset(58, 26),
    Position = UDim2.new(1, -62, 0.5, -13),
    BackgroundColor3 = C.A,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v134("UICorner", v143, { CornerRadius = UDim.new(0, 6) })

v143.MouseButton1Click:Connect(function()
    local v511 = (v142.Text or ""):match("%d+")
    if v511 and #v511 > 0 then
        pcall(function()
            musicSound:Stop()
            musicSound.SoundId = ""
        end)
        currentMusicIdx = 0
        for _, v in pairs(songBtns) do
            v.Text = "▶"
            v.BackgroundColor3 = C.A
        end
        currentMusicIdx = -1
        if nowPlayingLabel then nowPlayingLabel.Text = "♪ ID: " .. v511 end

        task.spawn(function()
            pcall(function()
                musicSound:Stop()
                task.wait(0.05)
                musicSound.SoundId = "rbxassetid://" .. tostring(v511)
                local timestamp = tick()
                repeat task.wait(0.1) until musicSound.IsLoaded or tick() - timestamp > 8
                if musicSound.IsLoaded then musicSound:Play() end
            end)
        end)
    end
end)

MkSlider(MU, "Music Volume", 0, 100, 80, function(p76)
    if musicSound then musicSound.Volume = p76 / 100 end
end)

local v144 = v134("TextButton", MU, {
    Text = "⏹ Stop",
    TextSize = 12,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 2,
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = Color3.fromRGB(160, 30, 30),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1)
})
v134("UICorner", v144, { CornerRadius = UDim.new(0, 10) })

v144.MouseButton1Click:Connect(function()
    pcall(function()
        musicSound:Stop()
        musicSound.SoundId = ""
    end)
    currentMusicIdx = 0
    if nowPlayingLabel then nowPlayingLabel.Text = "♪ None" end
    for _, v in pairs(songBtns) do
        v.Text = "▶"
        v.BackgroundColor3 = C.A
    end
end)

pcall(function()
    if setfflag then
        setfflag("TaskSchedulerTargetFps", "5099990")
    end
end)

pcall(function()
    RS.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
        local t45 = { ... }
        if tostring(t45[4]) ~= tostring(pl) and S.KS then
            local v727 = t45[4] and t45[4].Parent
            if v727 then
                task.spawn(function()
                    local v746 = v727.PrimaryPart and v727.PrimaryPart.Position or workspace.CurrentCamera.CFrame.Position
                    local timestamp = tick()
                    if timestamp - KSS_lastKill >= 0.3 then
                        KSS_lastKill = timestamp

                        local Part = Instance.new("Part")
                        Part.Anchored = true
                        Part.CanCollide = false
                        Part.Transparency = 1
                        Part.Size = Vector3.new(0.1, 0.1, 0.1)
                        Part.Position = v746
                        Part.Parent = workspace

                        local Sound = Instance.new("Sound")
                        Sound.SoundId = "rbxassetid://" .. KSS_selected
                        Sound.Volume = 0.7
                        Sound.Parent = Part
                        Sound:Play()
                        DB:AddItem(Part, 5)
                    end
                end)
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(0.8) do
        if S.SC and skinChangerEnabled and swordAnimations ~= "" then
            pcall(function()
                if u130 and u130.SetSword then
                    u130:SetSword(swordAnimations)
                end
            end)
        end
    end
end)

R.Heartbeat:Connect(function()
    pcall(function()
        if not S.RE then return end
        local v728 = tick() % 4 / 4
        for _, v in pairs(HL) do
            v.FillColor = Color3.fromHSV(v728, 1, 1)
            v.OutlineColor = Color3.fromHSV((v728 + 0.5) % 1, 1, 1)
        end
        if BHL then BHL.FillColor = Color3.fromHSV((v728 + 0.25) % 1, 1, 1) end
    end)
end)

pcall(function()
    for _, player in ipairs(P:GetPlayers()) do
        if player ~= pl then
            player.CharacterAdded:Connect(function()
                pAbCache[player] = nil
            end)
        end
    end
end)

P.PlayerAdded:Connect(function(player)
    if player ~= pl then
        player.CharacterAdded:Connect(function()
            pAbCache[player] = nil
        end)
    end
end)

print("[EclipseNexus v2.1] Loaded — patches applied")
pcall(function()
    task.wait(2)
    if hasData then
        if ST then ST.Text = "Ready! Remote captured" end
        return
    elseif ST then
        ST.Text = "Waiting for first parry..."
    end
end)
