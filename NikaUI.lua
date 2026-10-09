--== Nika Hub UI ==--
-- Custom interface library. Drop-in replacement for Fluent in Nika Hub.
-- API-compatible with: CreateWindow, Notify, AddTab, AddSection,
-- AddToggle, AddSlider, AddDropdown, AddInput, AddKeybind, AddButton, AddParagraph.

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local gethui = gethui or function() return game:GetService("CoreGui") end

-- ============================================================
-- THEME
-- ============================================================
local Theme = {
    Bg        = Color3.fromRGB(10, 10, 14),
    BgHi      = Color3.fromRGB(14, 14, 20),
    Panel     = Color3.fromRGB(18, 18, 24),
    PanelAlt  = Color3.fromRGB(24, 24, 32),
    Element   = Color3.fromRGB(30, 30, 40),
    ElementHi = Color3.fromRGB(42, 42, 54),
    Accent    = Color3.fromRGB(140, 100, 255),
    AccentAlt = Color3.fromRGB(80, 200, 255),
    Text      = Color3.fromRGB(235, 235, 245),
    TextDim   = Color3.fromRGB(150, 150, 168),
    TextOff   = Color3.fromRGB(90, 90, 105),
    Stroke    = Color3.fromRGB(44, 44, 58),
    Good      = Color3.fromRGB(90, 220, 130),
    Bad       = Color3.fromRGB(255, 90, 110),
    Warn      = Color3.fromRGB(255, 190, 90),
}

local FontRegular = Enum.Font.Gotham
local FontMedium  = Enum.Font.GothamMedium
local FontBold    = Enum.Font.GothamBold

-- ============================================================
-- HELPERS
-- ============================================================
local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Parent" then inst[k] = v end
    end
    if props.Parent then inst.Parent = props.Parent end
    return inst
end

local function corner(parent, radius)
    return new("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

local function stroke(parent, color, thickness, transparency)
    return new("UIStroke", {
        Color = color or Theme.Stroke,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function pad(parent, t, r, b, l)
    if type(t) == "table" then
        l, b, r, t = t.L, t.B, t.R, t.T
    end
    return new("UIPadding", {
        PaddingTop = UDim.new(0, t or 0),
        PaddingBottom = UDim.new(0, b or t or 0),
        PaddingLeft = UDim.new(0, l or r or t or 0),
        PaddingRight = UDim.new(0, r or t or 0),
        Parent = parent,
    })
end

local function tween(inst, time, props, style, dir)
    local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local t = TweenService:Create(inst, info, props)
    t:Play()
    return t
end

-- ============================================================
-- TAB ICON MAP
-- ============================================================
local IconMap = {
    ["swords"]    = "⚔",
    ["eye"]       = "◉",
    ["scan-eye"]  = "◉",
    ["settings"]  = "⚙",
    ["wrench"]    = "⚒",
    ["file-json"] = "{ }",
    ["braces"]    = "{ }",
    ["crosshair"] = "✛",
    ["target"]    = "◎",
    ["home"]      = "⌂",
    ["user"]      = "◍",
    ["shield"]    = "⛨",
    ["zap"]       = "⚡",
    ["flame"]     = "▲",
    ["star"]      = "★",
    ["box"]       = "▣",
}

local function iconFor(name, title)
    if name and IconMap[name] then return IconMap[name] end
    if title and #title > 0 then return title:sub(1, 1):upper() end
    return "•"
end

-- ============================================================
-- NOTIFICATION SYSTEM
-- ============================================================
local notifHolder = nil

local function ensureNotifHolder()
    if notifHolder and notifHolder.Parent then return notifHolder end

    local gui = new("ScreenGui", {
        Name = "NikaUI_Notif",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 200,
        IgnoreGuiInset = true,
        Parent = gethui(),
    })

    local holder = new("Frame", {
        Name = "Holder",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -16, 0, 16),
        Size = UDim2.new(0, 320, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = gui,
    })

    new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Parent = holder,
    })

    notifHolder = holder
    return holder
end

local function pushNotification(opts)
    opts = opts or {}
    local holder = ensureNotifHolder()

    local card = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Panel,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = -os.clock() * 1000,
        Parent = holder,
    })
    corner(card, 10)
    local cardStroke = stroke(card, Theme.Stroke, 1, 0.35)
    cardStroke.Transparency = 1

    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.PanelAlt),
            ColorSequenceKeypoint.new(1, Theme.Panel),
        }),
        Rotation = 90,
        Parent = card,
    })

    new("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 18),
        PaddingRight = UDim.new(0, 14),
        Parent = card,
    })

    local accent = new("Frame", {
        Size = UDim2.new(0, 3, 1, -16),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Parent = card,
    })
    corner(accent, 2)
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentAlt),
        }),
        Rotation = 90,
        Parent = accent,
    })

    local titleLbl = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Font = FontBold,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1,
        Text = opts.Title or "Nika",
        Parent = card,
    })

    local contentLbl = new("TextLabel", {
        Position = UDim2.new(0, 0, 0, 20),
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        Font = FontRegular,
        TextSize = 13,
        TextColor3 = Theme.TextDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextTransparency = 1,
        Text = opts.Content or "",
        Parent = card,
    })

    tween(card, 0.25, { BackgroundTransparency = 0 })
    tween(cardStroke, 0.25, { Transparency = 0.35 })
    tween(accent, 0.25, { BackgroundTransparency = 0 })
    tween(titleLbl, 0.25, { TextTransparency = 0 })
    tween(contentLbl, 0.25, { TextTransparency = 0 })

    local duration = opts.Duration or 4
    task.delay(duration, function()
        if not card.Parent then return end
        tween(card, 0.25, { BackgroundTransparency = 1 })
        tween(cardStroke, 0.25, { Transparency = 1 })
        tween(accent, 0.25, { BackgroundTransparency = 1 })
        tween(titleLbl, 0.25, { TextTransparency = 1 })
        tween(contentLbl, 0.25, { TextTransparency = 1 })
        task.wait(0.35)
        card:Destroy()
    end)
end

-- ============================================================
-- COMPONENT BUILDERS
-- ============================================================

-- Shared hover wiring
local function wireHover(frame, baseColor, hoverColor)
    frame.MouseEnter:Connect(function()
        tween(frame, 0.15, { BackgroundColor3 = hoverColor })
    end)
    frame.MouseLeave:Connect(function()
        tween(frame, 0.15, { BackgroundColor3 = baseColor })
    end)
end

-- Toggle ------------------------------------------------
local function buildToggle(parent, layoutOrder, id, opts)
    opts = opts or {}

    local row = new("Frame", {
        Name = "Toggle_" .. tostring(id or "t"),
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, Theme.Stroke, 1, 0.4)
    wireHover(row, Theme.Element, Theme.ElementHi)

    new("TextLabel", {
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        BackgroundTransparency = 1,
        Font = FontMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "Toggle",
        Parent = row,
    })

    local switchBg = new("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.new(0, 42, 0, 22),
        BackgroundColor3 = Theme.PanelAlt,
        BorderSizePixel = 0,
        Parent = row,
    })
    corner(switchBg, 11)
    stroke(switchBg, Theme.Stroke, 1, 0.3)
    local fill = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = switchBg,
    })
    corner(fill, 11)

    local knob = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
        Parent = switchBg,
    })
    corner(knob, 8)

    local api = { Value = opts.Default == true, _callback = opts.Callback }

    local function render(animate)
        local time = animate and 0.18 or 0
        if api.Value then
            tween(fill, time, { BackgroundTransparency = 0 })
            tween(knob, time, {
                Position = UDim2.new(0, switchBg.AbsoluteSize.X - 19, 0.5, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
            })
        else
            tween(fill, time, { BackgroundTransparency = 1 })
            tween(knob, time, {
                Position = UDim2.new(0, 3, 0.5, 0),
                BackgroundColor3 = Theme.Text,
            })
        end
    end

    local click = new("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = row,
    })

    click.MouseButton1Click:Connect(function()
        api.Value = not api.Value
        render(true)
        if api._callback then
            pcall(api._callback, api.Value)
        end
    end)

    render(false)

    api.SetValue = function(v)
        api.Value = v == true
        render(true)
    end

    return api
end

-- Slider ------------------------------------------------
local function buildSlider(parent, layoutOrder, id, opts)
    opts = opts or {}
    local minV = opts.Min or 0
    local maxV = opts.Max or 100
    local rounding = opts.Rounding or 1
    local factor = 10 ^ rounding

    local function snap(v)
        return math.floor(v * factor + 0.5) / factor
    end

    local row = new("Frame", {
        Name = "Slider_" .. tostring(id or "s"),
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, Theme.Stroke, 1, 0.4)
    wireHover(row, Theme.Element, Theme.ElementHi)

    new("TextLabel", {
        Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -80, 0, 16),
        BackgroundTransparency = 1,
        Font = FontMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "Slider",
        Parent = row,
    })

    local valueLbl = new("TextLabel", {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -14, 0, 8),
        Size = UDim2.new(0, 60, 0, 16),
        BackgroundTransparency = 1,
        Font = FontBold,
        TextSize = 13,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        Text = tostring(snap(opts.Default or minV)),
        Parent = row,
    })

    local track = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -12),
        Size = UDim2.new(1, -28, 0, 6),
        BackgroundColor3 = Theme.PanelAlt,
        BorderSizePixel = 0,
        Parent = row,
    })
    corner(track, 3)

    local fill = new("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = track,
    })
    corner(fill, 3)
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentAlt),
        }),
        Parent = fill,
    })

    local handle = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 14, 0, 14),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = track,
    })
    corner(handle, 7)
    stroke(handle, Theme.Accent, 2, 0)

    local api = { Value = snap(opts.Default or minV), _callback = opts.Callback }
    local dragging = false

    local function updateFromX(px, fromUser)
        local rel = math.clamp((px - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local raw = minV + (maxV - minV) * rel
        local v = snap(raw)
        api.Value = v
        valueLbl.Text = tostring(v)
        local pct = (v - minV) / (maxV - minV)
        tween(fill, 0.05, { Size = UDim2.new(pct, 0, 1, 0) })
        tween(handle, 0.05, { Position = UDim2.new(pct, 0, 0.5, 0) })
        if fromUser and api._callback then
            pcall(api._callback, v)
        end
    end

    local hit = new("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = row,
    })

    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X, true)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                      or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X, true)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    updateFromX(track.AbsolutePosition.X + track.AbsoluteSize.X * ((api.Value - minV) / (maxV - minV)), false)

    api.SetValue = function(v)
        updateFromX(track.AbsolutePosition.X + track.AbsoluteSize.X * ((snap(v) - minV) / (maxV - minV)), false)
    end

    return api
end

-- Dropdown ----------------------------------------------
local function buildDropdown(parent, layoutOrder, id, opts, guiRoot)
    opts = opts or {}
    local values = {}
    for i, v in ipairs(opts.Values or {}) do
        values[i] = tostring(v)
    end

    local row = new("Frame", {
        Name = "Dropdown_" .. tostring(id or "d"),
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, Theme.Stroke, 1, 0.4)
    wireHover(row, Theme.Element, Theme.ElementHi)

    new("TextLabel", {
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -110, 1, 0),
        BackgroundTransparency = 1,
        Font = FontMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "Dropdown",
        Parent = row,
    })

    local valueLbl = new("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -34, 0.5, 0),
        Size = UDim2.new(0, 140, 0, 16),
        BackgroundTransparency = 1,
        Font = FontRegular,
        TextSize = 13,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = tostring(opts.Default or values[1] or ""),
        Parent = row,
    })

    local arrow = new("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundTransparency = 1,
        Font = FontBold,
        TextSize = 12,
        TextColor3 = Theme.TextDim,
        Text = "▼",
        Parent = row,
    })

    local api = {
        Value = tostring(opts.Default or values[1] or ""),
        _values = values,
        _callback = opts.Callback,
        _multi = opts.Multi == true,
        _popup = nil,
    }

    local function closePopup()
        if api._popup then
            local p = api._popup
            api._popup = nil
            tween(p, 0.12, { BackgroundTransparency = 1 })
            for _, c in ipairs(p:GetDescendants()) do
                if c:IsA("TextLabel") then
                    tween(c, 0.12, { TextTransparency = 1 })
                end
            end
            task.delay(0.15, function() if p.Parent then p:Destroy() end end)
            tween(arrow, 0.15, { Rotation = 0 })
        end
    end

    local function select(v)
        api.Value = v
        valueLbl.Text = v
        if api._callback then
            pcall(api._callback, v)
        end
    end

    local function openPopup()
        closePopup()

        local popup = new("Frame", {
            Position = UDim2.fromOffset(row.AbsolutePosition.X, row.AbsolutePosition.Y + row.AbsoluteSize.Y + 4),
            Size = UDim2.fromOffset(row.AbsoluteSize.X, math.min(#values * 30 + 8, 240)),
            BackgroundColor3 = Theme.PanelAlt,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            ZIndex = 999,
            Parent = guiRoot,
        })
        corner(popup, 8)
        stroke(popup, Theme.Stroke, 1, 0.2)
        new("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Theme.PanelAlt),
                ColorSequenceKeypoint.new(1, Theme.Panel),
            }),
            Rotation = 90,
            Parent = popup,
        })
        api._popup = popup
        tween(arrow, 0.15, { Rotation = 180 })

        local scroll = new("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Stroke,
            ZIndex = 999,
            Parent = popup,
        })
        pad(scroll, 4)

        new("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2),
            Parent = scroll,
        })

        for i, v in ipairs(values) do
            local isSelected = (v == api.Value)
            local item = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundColor3 = isSelected and Theme.ElementHi or Theme.Element,
                BackgroundTransparency = isSelected and 0 or 1,
                BorderSizePixel = 0,
                Font = FontRegular,
                TextSize = 13,
                TextColor3 = isSelected and Theme.Text or Theme.TextDim,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = "  " .. v,
                AutoButtonColor = false,
                LayoutOrder = i,
                ZIndex = 999,
                Parent = scroll,
            })
            corner(item, 6)

            item.MouseEnter:Connect(function()
                if not isSelected then
                    tween(item, 0.1, { BackgroundTransparency = 0, BackgroundColor3 = Theme.ElementHi, TextColor3 = Theme.Text })
                end
            end)
            item.MouseLeave:Connect(function()
                if not isSelected then
                    tween(item, 0.1, { BackgroundTransparency = 1, TextColor3 = Theme.TextDim })
                end
            end)

            item.MouseButton1Click:Connect(function()
                select(v)
                closePopup()
            end)
        end

        task.defer(function()
            local conn
            conn = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then return end
                local mx, my = input.Position.X, input.Position.Y
                local rp = popup.AbsolutePosition
                local rs = popup.AbsoluteSize
                if mx < rp.X or mx > rp.X + rs.X or my < rp.Y or my > rp.Y + rs.Y then
                    conn:Disconnect()
                    closePopup()
                end
            end)
            if api._popup == nil then conn:Disconnect() end
        end)
    end

    local hit = new("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = row,
    })

    hit.MouseButton1Click:Connect(function()
        if api._popup then
            closePopup()
        else
            openPopup()
        end
    end)

    api.SetValue = function(v)
        v = tostring(v)
        api.Value = v
        valueLbl.Text = v
    end

    api.SetValues = function(arr)
        values = {}
        for i, v in ipairs(arr or {}) do values[i] = tostring(v) end
        api._values = values
        if not table.find(values, api.Value) then
            api.Value = values[1] or ""
            valueLbl.Text = api.Value
        end
    end

    return api
end

-- Input ------------------------------------------------
local function buildInput(parent, layoutOrder, id, opts)
    opts = opts or {}
    local hasDesc = opts.Description and opts.Description ~= ""

    local height = hasDesc and 66 or 46
    local row = new("Frame", {
        Name = "Input_" .. tostring(id or "i"),
        Size = UDim2.new(1, 0, 0, height),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, Theme.Stroke, 1, 0.4)

    new("TextLabel", {
        Position = UDim2.new(0, 14, 0, 6),
        Size = UDim2.new(1, -28, 0, 14),
        BackgroundTransparency = 1,
        Font = FontMedium,
        TextSize = 12,
        TextColor3 = Theme.TextDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "Input",
        Parent = row,
    })

    local fieldTop = hasDesc and 26 or 20

    if hasDesc then
        new("TextLabel", {
            Position = UDim2.new(0, 14, 0, 20),
            Size = UDim2.new(1, -28, 0, 12),
            BackgroundTransparency = 1,
            Font = FontRegular,
            TextSize = 11,
            TextColor3 = Theme.TextOff,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = opts.Description,
            Parent = row,
        })
    end

    local field = new("Frame", {
        Position = UDim2.new(0, 10, 1, -(hasDesc and 32 or 32)),
        Size = UDim2.new(1, -20, 0, 26),
        BackgroundColor3 = Theme.PanelAlt,
        BorderSizePixel = 0,
        Parent = row,
    })
    corner(field, 6)
    local fieldStroke = stroke(field, Theme.Stroke, 1, 0.3)

    local textBox = new("TextBox", {
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 1, 0),
        BackgroundTransparency = 1,
        Font = FontRegular,
        TextSize = 13,
        TextColor3 = Theme.Text,
        PlaceholderText = opts.Placeholder or "",
        PlaceholderColor3 = Theme.TextOff,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = tostring(opts.Default or ""),
        ClearTextOnFocus = false,
        Parent = field,
    })

    local api = {
        Value = tostring(opts.Default or ""),
        _callback = opts.Callback,
        _finished = opts.Finished == true,
        _changed = {},
    }

    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        api.Value = textBox.Text
        for _, fn in ipairs(api._changed) do pcall(fn, api.Value) end
    end)

    textBox.Focused:Connect(function()
        tween(fieldStroke, 0.15, { Color = Theme.Accent, Transparency = 0 })
    end)

    textBox.FocusLost:Connect(function(enterPressed)
        tween(fieldStroke, 0.15, { Color = Theme.Stroke, Transparency = 0.3 })
        if (enterPressed or not api._finished) and api._callback then
            pcall(api._callback, api.Value)
        end
    end)

    api.SetValue = function(v)
        v = tostring(v)
        api.Value = v
        textBox.Text = v
    end

    api.OnChanged = function(fn)
        table.insert(api._changed, fn)
    end

    return api
end

-- Button ------------------------------------------------
local function buildButton(parent, layoutOrder, opts)
    opts = opts or {}

    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Font = FontMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        Text = opts.Title or "Button",
        AutoButtonColor = false,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(btn, 8)
    local btnStroke = stroke(btn, Theme.Stroke, 1, 0.4)

    btn.MouseEnter:Connect(function()
        tween(btn, 0.15, { BackgroundColor3 = Theme.ElementHi })
        tween(btnStroke, 0.15, { Color = Theme.Accent, Transparency = 0.5 })
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, 0.15, { BackgroundColor3 = Theme.Element })
        tween(btnStroke, 0.15, { Color = Theme.Stroke, Transparency = 0.4 })
    end)

    btn.MouseButton1Click:Connect(function()
        if opts.Callback then pcall(opts.Callback) end
    end)

    return { Instance = btn }
end

-- Keybind ----------------------------------------------
local function buildKeybind(parent, layoutOrder, id, opts)
    opts = opts or {}
    local currentKey = nil
    if type(opts.Default) == "string" then
        currentKey = Enum.KeyCode[opts.Default]
    elseif typeof(opts.Default) == "EnumItem" then
        currentKey = opts.Default
    end
    if not currentKey then currentKey = Enum.KeyCode.Unknown end

    local row = new("Frame", {
        Name = "Keybind_" .. tostring(id or "k"),
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, Theme.Stroke, 1, 0.4)
    wireHover(row, Theme.Element, Theme.ElementHi)

    new("TextLabel", {
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -100, 1, 0),
        BackgroundTransparency = 1,
        Font = FontMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "Keybind",
        Parent = row,
    })

    local keyBox = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.new(0, 70, 0, 26),
        BackgroundColor3 = Theme.PanelAlt,
        BorderSizePixel = 0,
        Font = FontBold,
        TextSize = 12,
        TextColor3 = Theme.Text,
        Text = currentKey.Name,
        AutoButtonColor = false,
        Parent = row,
    })
    corner(keyBox, 6)
    local keyStroke = stroke(keyBox, Theme.Stroke, 1, 0.3)

    local listening = false
    local api = { Value = currentKey, _callback = opts.ChangedCallback }

    local function stopListening()
        listening = false
        keyBox.Text = currentKey.Name
        tween(keyBox, 0.15, { BackgroundColor3 = Theme.PanelAlt })
        tween(keyStroke, 0.15, { Color = Theme.Stroke, Transparency = 0.3 })
    end

    keyBox.MouseButton1Click:Connect(function()
        if listening then
            stopListening()
            return
        end
        listening = true
        keyBox.Text = "..."
        tween(keyBox, 0.15, { BackgroundColor3 = Theme.Accent })
        tween(keyStroke, 0.15, { Color = Theme.Accent, Transparency = 0 })
    end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if not listening then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if input.KeyCode == Enum.KeyCode.Escape then
            stopListening()
            return
        end
        currentKey = input.KeyCode
        api.Value = currentKey
        stopListening()
        if api._callback then pcall(api._callback, currentKey) end
    end)

    api.SetValue = function(k)
        if typeof(k) == "EnumItem" then
            currentKey = k
        elseif type(k) == "string" then
            currentKey = Enum.KeyCode[k] or currentKey
        end
        api.Value = currentKey
        keyBox.Text = currentKey.Name
    end

    return api
end

-- Paragraph --------------------------------------------
local function buildParagraph(parent, layoutOrder, opts)
    opts = opts or {}
    local frame = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.PanelAlt,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Parent = parent,
    })
    corner(frame, 8)
    stroke(frame, Theme.Stroke, 1, 0.5)
    new("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        Parent = frame,
    })

    local titleLbl = new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
        Font = FontBold,
        TextSize = 12,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = opts.Title or "",
        Parent = frame,
    })

    local contentLbl = new("TextLabel", {
        Position = UDim2.new(0, 0, 0, opts.Title and 18 or 0),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Font = FontRegular,
        TextSize = 12,
        TextColor3 = Theme.TextDim,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Text = opts.Content or "",
        Parent = frame,
    })

    return { Instance = frame }
end

-- ============================================================
-- SECTION (holds components)
-- ============================================================
local function makeSection(scroll, title)
    local container = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = #scroll:GetChildren(),
        Parent = scroll,
    })

    local cursor = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = container,
    })

    local layout = new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = cursor,
    })

    if title and title ~= "" then
        local header = new("Frame", {
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            Parent = cursor,
        })
        new("TextLabel", {
            Position = UDim2.new(0, 2, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Font = FontBold,
            TextSize = 11,
            TextColor3 = Theme.TextDim,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = string.upper(title),
            Parent = header,
        })
        new("Frame", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -2, 0.5, 0),
            Size = UDim2.new(0, 40, 0, 1),
            BackgroundColor3 = Theme.Stroke,
            BorderSizePixel = 0,
            Parent = header,
        })
    end

    local order = 100
    local section = {}

    local function add(api)
        order = order + 1
        return api
    end

    local guiRoot = scroll:FindFirstAncestorWhichIsA("ScreenGui")

    function section:AddToggle(id, opts)     return add(buildToggle(cursor, order, id, opts)) end
    function section:AddSlider(id, opts)     return add(buildSlider(cursor, order, id, opts)) end
    function section:AddDropdown(id, opts)   return add(buildDropdown(cursor, order, id, opts, guiRoot)) end
    function section:AddInput(id, opts)      return add(buildInput(cursor, order, id, opts)) end
    function section:AddButton(opts)         return add(buildButton(cursor, order, opts)) end
    function section:AddKeybind(id, opts)    return add(buildKeybind(cursor, order, id, opts)) end
    function section:AddParagraph(opts)      return add(buildParagraph(cursor, order, opts)) end

    return section
end

-- ============================================================
-- MODULE
-- ============================================================
local NikaUI = {}
NikaUI.__index = NikaUI

function NikaUI:Notify(opts)
    pushNotification(opts)
    return self
end

function NikaUI:CreateWindow(opts)
    opts = opts or {}
    local winTitle = opts.Title or "Nika Hub"
    local winSub   = opts.SubTitle or ""
    local winSize  = opts.Size or UDim2.fromOffset(520, 360)
    local minKey   = opts.MinimizeKey or Enum.KeyCode.LeftControl

    local gui = new("ScreenGui", {
        Name = "NikaUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 50,
        IgnoreGuiInset = true,
        Parent = gethui(),
    })

    local main = new("Frame", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = winSize,
        BackgroundColor3 = Theme.Bg,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = gui,
    })
    corner(main, 12)
    stroke(main, Theme.Stroke, 1, 0.4)
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.BgHi),
            ColorSequenceKeypoint.new(1, Theme.Bg),
        }),
        Rotation = 115,
        Parent = main,
    })

    -- topbar
    local topbar = new("Frame", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        Parent = main,
    })
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 26, 36)),
            ColorSequenceKeypoint.new(1, Theme.Panel),
        }),
        Rotation = 90,
        Parent = topbar,
    })
    new("Frame", {
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.Stroke,
        BorderSizePixel = 0,
        Parent = topbar,
    })

    -- logo dot
    local logo = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 16, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = topbar,
    })
    corner(logo, 4)
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentAlt),
        }),
        Rotation = 45,
        Parent = logo,
    })

    new("TextLabel", {
        Position = UDim2.new(0, 38, 0, winSub ~= "" and 6 or 0),
        Size = UDim2.new(1, -180, 0, winSub ~= "" and 16 or 44),
        BackgroundTransparency = 1,
        Font = FontBold,
        TextSize = 15,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = winSub ~= "" and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
        Text = winTitle,
        Parent = topbar,
    })

    if winSub ~= "" then
        new("TextLabel", {
            Position = UDim2.new(0, 38, 0, 24),
            Size = UDim2.new(1, -180, 0, 12),
            BackgroundTransparency = 1,
            Font = FontRegular,
            TextSize = 11,
            TextColor3 = Theme.TextDim,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = winSub,
            Parent = topbar,
        })
    end

    -- buttons
    local minBtn = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -40, 0.5, 0),
        Size = UDim2.new(0, 26, 0, 26),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Text = "—",
        Font = FontBold,
        TextSize = 14,
        TextColor3 = Theme.TextDim,
        AutoButtonColor = false,
        Parent = topbar,
    })
    corner(minBtn, 6)

    local closeBtn = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 26, 0, 26),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0,
        Text = "×",
        Font = FontBold,
        TextSize = 16,
        TextColor3 = Theme.TextDim,
        AutoButtonColor = false,
        Parent = topbar,
    })
    corner(closeBtn, 6)

    -- sidebar
    local sidebar = new("Frame", {
        Position = UDim2.new(0, 0, 0, 44),
        Size = UDim2.new(0, 162, 1, -44),
        BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0,
        Parent = main,
    })
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 28)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20)),
        }),
        Rotation = 90,
        Parent = sidebar,
    })
    new("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = Theme.Stroke,
        BorderSizePixel = 0,
        Parent = sidebar,
    })

    local sidebarPad = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = sidebar,
    })
    pad(sidebarPad, 10)

    local tabList = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = sidebarPad,
    })
    new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),
        Parent = tabList,
    })

    -- content
    local content = new("Frame", {
        Position = UDim2.new(0, 162, 0, 44),
        Size = UDim2.new(1, -162, 1, -44),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = main,
    })

    -- drag
    local dragStart, startPos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragStart = nil
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement
                       or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)

    -- minimize
    local minimized = false
    local storedSize = winSize
    local function toggleMin()
        minimized = not minimized
        if minimized then
            storedSize = main.Size
            tween(main, 0.3, { Size = UDim2.fromOffset(main.AbsoluteSize.X, 44) }, Enum.EasingStyle.Quart)
        else
            tween(main, 0.3, { Size = storedSize }, Enum.EasingStyle.Quart)
        end
    end

    minBtn.MouseButton1Click:Connect(toggleMin)
    minBtn.MouseEnter:Connect(function() tween(minBtn, 0.15, { BackgroundColor3 = Theme.ElementHi, TextColor3 = Theme.Text }) end)
    minBtn.MouseLeave:Connect(function() tween(minBtn, 0.15, { BackgroundColor3 = Theme.Element, TextColor3 = Theme.TextDim }) end)

    closeBtn.MouseButton1Click:Connect(function()
        tween(main, 0.15, { BackgroundTransparency = 1 })
        task.wait(0.2)
        gui:Destroy()
    end)
    closeBtn.MouseEnter:Connect(function() tween(closeBtn, 0.15, { BackgroundColor3 = Theme.Bad, TextColor3 = Color3.new(1,1,1) }) end)
    closeBtn.MouseLeave:Connect(function() tween(closeBtn, 0.15, { BackgroundColor3 = Theme.Element, TextColor3 = Theme.TextDim }) end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == minKey then toggleMin() end
    end)

    -- window object
    local window = {}
    local tabs = {}
    local activePage = nil
    local activeButton = nil

    local function setActive(tabObj)
        if activePage then activePage.Visible = false end
        if activeButton then
            tween(activeButton.bar, 0.2, { BackgroundTransparency = 1 })
            tween(activeButton.label, 0.2, { TextColor3 = Theme.TextDim })
            tween(activeButton.icon,  0.2, { TextColor3 = Theme.TextDim })
            tween(activeButton.bg,    0.2, { BackgroundColor3 = Theme.Element, BackgroundTransparency = 1 })
        end
        activePage = tabObj.page
        activeButton = tabObj.button
        activePage.Visible = true
        if activeButton then
            tween(activeButton.bar, 0.2, { BackgroundTransparency = 0 })
            tween(activeButton.label, 0.2, { TextColor3 = Theme.Text })
            tween(activeButton.icon,  0.2, { TextColor3 = Theme.Accent })
            tween(activeButton.bg,    0.2, { BackgroundColor3 = Theme.Element, BackgroundTransparency = 0 })
        end
    end

    function window:AddTab(tabOpts)
        tabOpts = tabOpts or {}
        local tabTitle = tabOpts.Title or "Tab"
        local tabIcon  = tabOpts.Icon or ""

        -- sidebar button
        local button = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Theme.Element,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #tabs + 1,
            Parent = tabList,
        })
        corner(button, 8)

        local bar = new("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 3, 0, 20),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = button,
        })
        corner(bar, 2)
        new("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Theme.Accent),
                ColorSequenceKeypoint.new(1, Theme.AccentAlt),
            }),
            Rotation = 90,
            Parent = bar,
        })

        local icon = new("TextLabel", {
            Position = UDim2.new(0, 14, 0, 0),
            Size = UDim2.new(0, 22, 1, 0),
            BackgroundTransparency = 1,
            Font = FontBold,
            TextSize = 14,
            TextColor3 = Theme.TextDim,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = iconFor(tabIcon, tabTitle),
            Parent = button,
        })

        local label = new("TextLabel", {
            Position = UDim2.new(0, 42, 0, 0),
            Size = UDim2.new(1, -48, 1, 0),
            BackgroundTransparency = 1,
            Font = FontMedium,
            TextSize = 13,
            TextColor3 = Theme.TextDim,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = tabTitle,
            Parent = button,
        })

        -- page
        local page = new("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = content,
        })

        local scroll = new("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Stroke,
            ScrollBarImageTransparency = 0.3,
            Parent = page,
        })
        pad(scroll, 14)

        new("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 14),
            Parent = scroll,
        })

        local tabObj = {
            page = page,
            scroll = scroll,
            button = { Instance = button, bg = button, bar = bar, icon = icon, label = label },
        }
        table.insert(tabs, tabObj)

        button.MouseButton1Click:Connect(function()
            setActive(tabObj)
        end)
        button.MouseEnter:Connect(function()
            if activeButton ~= button then
                tween(button, 0.15, { BackgroundColor3 = Theme.Element, BackgroundTransparency = 0.3 })
            end
        end)
        button.MouseLeave:Connect(function()
            if activeButton ~= button then
                tween(button, 0.15, { BackgroundTransparency = 1 })
            end
        end)

        -- tab api
        local tabApi = {}
        function tabApi:AddSection(title)
            return makeSection(scroll, title or "")
        end

        -- convenience passthrough
        function tabApi:AddToggle(id, o)     return self:AddSection(""):AddToggle(id, o) end
        function tabApi:AddSlider(id, o)     return self:AddSection(""):AddSlider(id, o) end
        function tabApi:AddDropdown(id, o)   return self:AddSection(""):AddDropdown(id, o) end
        function tabApi:AddInput(id, o)      return self:AddSection(""):AddInput(id, o) end
        function tabApi:AddButton(o)         return self:AddSection(""):AddButton(o) end
        function tabApi:AddKeybind(id, o)    return self:AddSection(""):AddKeybind(id, o) end
        function tabApi:AddParagraph(o)      return self:AddSection(""):AddParagraph(o) end

        if #tabs == 1 then
            setActive(tabObj)
        end

        return tabApi
    end

    function window:Destroy()
        gui:Destroy()
    end

    return window
end

return NikaUI
