-- FluentRiseShim v1.0
-- Rise API compatibility layer over Fluent.
-- Drop-in replacement for library_optimized_btw.lua.

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Rise = {}
Rise.Toggles = {}
Rise.Options = {}
Rise.Scales = {}
Rise.Corners = {}
Rise.CornerRadius = 8
Rise.ShowToggleFrameInKeybinds = false
Rise.KeybindFrame = { Visible = false }
Rise.ScreenGui = Fluent.ScreenGui
Rise.Scheme = {
    AccentColor = Color3.fromRGB(248, 59, 5),
    MainColor = Color3.fromRGB(20, 20, 20),
    BackgroundColor = Color3.fromRGB(30, 30, 30),
    OutlineColor = Color3.fromRGB(60, 60, 60),
    FontColor = Color3.fromRGB(237, 232, 220),
    WhiteColor = Color3.fromRGB(255, 255, 255),
    Font = Font.new("rbxasset://fonts/families/GothamSSm.json"),
}

local UnloadCallbacks = {}
local _idxCounter = 0
local function nextIdx()
    _idxCounter = _idxCounter + 1
    return _idxCounter
end

local _imgAssets = {}
Rise.ImageManager = { _assets = _imgAssets }

local function _imgAdd(a, b, c, d)
    local name, url
    if type(a) == "table" and a == Rise.ImageManager then
        name, url = b, d
    else
        name, url = a, c
    end
    _imgAssets[name] = url
    return url
end

local function _imgGet(a, b)
    local name = (type(a) == "table" and a == Rise.ImageManager) and b or a
    return _imgAssets[name]
end

Rise.ImageManager.AddAsset = _imgAdd
Rise.ImageManager.GetAsset = _imgGet

function Rise:Notify(opts)
    pcall(function()
        Fluent:Notify({
            Title = tostring(opts.Title or "Nika"),
            Content = tostring(opts.Description or ""),
            Duration = tonumber(opts.Time) or 3,
        })
    end)
end

function Rise:SetNotifySide(side)
    pcall(function() Fluent:SetNotifySide(side) end)
end

function Rise:SetIconModule(_) end

function Rise:UpdateColorsUsingRegistry()
    pcall(function() Fluent:UpdateColorsUsingRegistry() end)
end

function Rise:SafeCallback(fn, ...)
    if type(fn) == "function" then
        local ok, err = pcall(fn, ...)
        if not ok then warn("[Nika] callback error: " .. tostring(err)) end
    end
end

function Rise:AddOutline(obj)
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.Scheme.OutlineColor
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

function Rise:MakeLine(parent, opts)
    local line = Instance.new("Frame")
    line.BackgroundColor3 = self.Scheme.OutlineColor
    line.BorderSizePixel = 0
    line.Position = opts.Position
    line.Size = opts.Size
    line.Parent = parent
    return line
end

function Rise:MakeDraggable(obj, dragObj)
    local dragging = false
    local dragInput, dragStart, startPos

    dragObj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragObj.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Rise:CreateLoading(opts)
    local lua = {
        _msg = opts.Title or "",
        SetMessage = function(self, m) self._msg = m end,
        SetDescription = function(self, _) end,
        SetCurrentStep = function(self, _) end,
        Continue = function(self) end,
    }
    return lua
end

function Rise:OnUnload(fn)
    if type(fn) == "function" then
        table.insert(UnloadCallbacks, fn)
    end
end

function Rise:Unload()
    for _, fn in ipairs(UnloadCallbacks) do
        pcall(fn)
    end
    pcall(function() Fluent:Destroy() end)
end

local function applyFlScheme()
    if Rise.Scheme.AccentColor then
        pcall(function()
            Fluent.Scheme.AccentColor = Rise.Scheme.AccentColor
            Fluent:UpdateColorsUsingRegistry()
        end)
    end
end

local function wrapKeyPicker(parentGroupbox, ownerToggle)
    return function(self, key, opts)
        opts = opts or {}
        local defaultKey = opts.Default or "None"
        if type(defaultKey) == "table" and defaultKey.Name then
            defaultKey = defaultKey.Name
        end

        local kb = parentGroupbox:AddKeybind(key, {
            Title = opts.Text or opts.Title or key,
            Default = defaultKey,
            Mode = (opts.Mode == "Hold") and "Hold" or "Toggle",
            Callback = function()
                if ownerToggle and opts.SyncToggleState then
                    ownerToggle:SetValue(not ownerToggle.Value)
                end
            end,
        })

        kb.Type = "KeyPicker"
        kb.Idx = nextIdx()
        Rise.Options[key] = kb
        return kb
    end
end

local function wrapColorPicker(parentGroupbox)
    return function(self, key, opts)
        opts = opts or {}
        local cp = parentGroupbox:AddColorpicker(key, {
            Title = opts.Title or opts.Text or key,
            Default = opts.Default or Color3.fromRGB(255, 255, 255),
            Transparency = opts.Transparency,
        })
        cp.Type = "ColorPicker"
        cp.Idx = nextIdx()
        Rise.Options[key] = cp
        return cp
    end
end

local function wrapLabel(label, parentGroupbox)
    label.Type = "Label"
    label.Idx = nextIdx()
    label.AddColorPicker = wrapColorPicker(parentGroupbox)
    label.AddKeyPicker = wrapKeyPicker(parentGroupbox, nil)
    return label
end

local function wrapToggle(toggle, parentGroupbox)
    toggle.Type = "Toggle"
    toggle.Idx = nextIdx()
    toggle.AddKeyPicker = wrapKeyPicker(parentGroupbox, toggle)
    return toggle
end

local function wrapSlider(slider)
    slider.Type = "Slider"
    slider.Idx = nextIdx()
    return slider
end

local function wrapDropdown(dropdown)
    dropdown.Type = "Dropdown"
    dropdown.Idx = nextIdx()
    return dropdown
end

local function wrapInput(input)
    input.Type = "Input"
    input.Idx = nextIdx()
    return input
end

local function wrapButton(btn)
    btn.Type = "Button"
    btn.Idx = nextIdx()
    return btn
end

local function convertDropdownDefault(opts)
    if type(opts.Default) == "number" and type(opts.Values) == "table" then
        return opts.Values[opts.Default]
    end
    return opts.Default
end

local function buildGroupbox(gb)
    local w = { _fluent = gb }

    w.AddToggle = function(self, key, opts)
        opts = opts or {}
        local t = gb:AddToggle(key, {
            Title = opts.Text or opts.Title or key,
            Default = opts.Default and true or false,
            Tooltip = opts.Tooltip,
            Callback = opts.Callback,
        })
        Rise.Toggles[key] = wrapToggle(t, gb)
        return Rise.Toggles[key]
    end

    w.AddSlider = function(self, key, opts)
        opts = opts or {}
        local s = gb:AddSlider(key, {
            Title = opts.Text or opts.Title or key,
            Default = tonumber(opts.Default) or tonumber(opts.Min) or 0,
            Min = tonumber(opts.Min) or 0,
            Max = tonumber(opts.Max) or 100,
            Rounding = tonumber(opts.Rounding) or 0,
            Tooltip = opts.Tooltip,
            Callback = opts.Callback,
        })
        Rise.Options[key] = wrapSlider(s)
        return Rise.Options[key]
    end

    w.AddDropdown = function(self, key, opts)
        opts = opts or {}
        local d = gb:AddDropdown(key, {
            Title = opts.Text or opts.Title or key,
            Values = opts.Values or opts.Options or {},
            Default = convertDropdownDefault(opts),
            Multi = opts.Multi or false,
            Tooltip = opts.Tooltip,
            Callback = opts.Callback,
        })
        Rise.Options[key] = wrapDropdown(d)
        return Rise.Options[key]
    end

    w.AddInput = function(self, key, opts)
        opts = opts or {}
        local i = gb:AddInput(key, {
            Title = opts.Text or opts.Title or key,
            Default = opts.Default or "",
            Placeholder = opts.Placeholder or "",
            Tooltip = opts.Tooltip,
            Finished = opts.Finished,
            Callback = opts.Callback,
        })
        Rise.Options[key] = wrapInput(i)
        return Rise.Options[key]
    end

    w.AddButton = function(self, name, cb)
        opts = type(name) == "table" and name or { Title = name, Callback = cb }
        local b = gb:AddButton({
            Title = opts.Title or "Button",
            Callback = opts.Callback or function() end,
        })
        return wrapButton(b)
    end

    w.AddLabel = function(self, text, wraps)
        local l = gb:AddParagraph({
            Title = "",
            Content = tostring(text or ""),
        })
        return wrapLabel(l, gb)
    end

    w.AddDivider = function(self)
        return gb:AddDivider()
    end

    w.AddColorPicker = function(self, key, opts)
        return wrapColorPicker(gb)(nil, key, opts)
    end

    w.AddKeyPicker = function(self, key, opts)
        return wrapKeyPicker(gb, nil)(nil, key, opts)
    end

    w.AddDependencyBox = function(self)
        local dep = { _children = {}, _deps = {}, _parent = gb }

        dep.AddToggle = function(self2, key, opts)
            local t = w.AddToggle(w, key, opts)
            table.insert(dep._children, t)
            return t
        end
        dep.AddSlider = function(self2, key, opts)
            local s = w.AddSlider(w, key, opts)
            table.insert(dep._children, s)
            return s
        end
        dep.AddDropdown = function(self2, key, opts)
            local d = w.AddDropdown(w, key, opts)
            table.insert(dep._children, d)
            return d
        end
        dep.AddInput = function(self2, key, opts)
            local i = w.AddInput(w, key, opts)
            table.insert(dep._children, i)
            return i
        end
        dep.AddColorPicker = function(self2, key, opts)
            local c = w.AddColorPicker(w, key, opts)
            table.insert(dep._children, c)
            return c
        end

        dep.SetupDependencies = function(self2, deps)
            dep._deps = deps or {}

            local function check()
                for _, d in ipairs(dep._deps) do
                    local widget, expected = d[1], d[2]
                    if widget and widget.Value ~= expected then
                        return false
                    end
                end
                return true
            end

            local function apply()
                local visible = check()
                for _, child in ipairs(dep._children) do
                    pcall(function()
                        if child.SetVisible then
                            child:SetVisible(visible)
                        elseif child._fluent and child._fluent.SetVisible then
                            child._fluent:SetVisible(visible)
                        end
                    end)
                end
            end

            for _, d in ipairs(dep._deps) do
                pcall(function()
                    d[1]:OnChanged(apply)
                end)
            end
            apply()
        end

        return dep
    end

    return w
end

function Rise:CreateWindow(opts)
    opts = opts or {}
    local win = Fluent:CreateWindow({
        Title = opts.Title or "Nika",
        SubTitle = opts.Footer or "",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = false,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl,
    })

    local wrapper = { _fluent = win }

    wrapper.AddTab = function(self, name, icon, _)
        local tab = win:AddTab({ Title = name, Icon = icon or "circle" })

        local tabWrap = { _fluent = tab }

        tabWrap.AddLeftGroupbox = function(self2, gname)
            local gb = tab:AddGroupbox({
                Title = (gname and gname ~= "") and gname or nil,
                Column = 1,
            })
            return buildGroupbox(gb)
        end

        tabWrap.AddRightGroupbox = function(self2, gname)
            local gb = tab:AddGroupbox({
                Title = (gname and gname ~= "") and gname or nil,
                Column = 2,
            })
            return buildGroupbox(gb)
        end

        return tabWrap
    end

    wrapper.Toggle = function(self)
        pcall(function() win:Toggle() end)
    end

    applyFlScheme()
    return wrapper
end

Rise.ToggleKeybindSetter = nil
setmetatable(Rise, {
    __newindex = function(t, k, v)
        if k == "ToggleKeybind" and v then
            pcall(function()
                if v.OnClick then
                    v:OnClick(function()
                        pcall(function() Fluent:Toggle() end)
                    end)
                end
            end)
        end
        rawset(t, k, v)
    end,
})

return Rise
