-- Load guard: if the script was already loaded, clean up the prior instance
-- before continuing. Previously this just returned and required the user to
-- manually unload, which would fail silently on re-execute.
if getgenv()._aurorasigma then
    -- Try to clean up the previous instance
    pcall(function()
        if _G.ailon_unload then _G.ailon_unload() end
    end)
    -- If unload didn't clear the flag, force-clear it
    getgenv()._aurorasigma = nil
    task.wait(0.1)  -- give cleanup a tick to complete
end

getgenv()._aurorasigma = true

local ContentProvider = game:GetService("ContentProvider")
local LogService = game:GetService("LogService")

local hook = hookfunction or detour_function or (replaceclosure and function(old, new)
    return replaceclosure(old, new)
end)

local cclosure = newcclosure or function(f)
    return f
end

local renv = getrenv and getrenv() or _G

local set_readonly = setreadonly or (make_writeable and function(t, v)
    if v then
        make_writeable(t)
    else
        make_readonly(t)
    end
end)

local function isRelevantCaller()
    for i = 3, 6 do
        local src = debug.info(i, "s")
        if src and (
            src:find("RemoveLoadingScreen") or
            src:find("Loading") or
            src:find("Detection")
        ) then
            return true
        end
    end

    if getcallingscript then
        local ok, script = pcall(getcallingscript)
        if ok and script then
            local name = tostring(script)
            if name:find("RemoveLoadingScreen") or name:find("Loading") then
                return true
            end
        end
    end

    return false
end

local originalRandom
originalRandom = hook(renv.math.random, cclosure(function(...)
    if isRelevantCaller() then
        return 0
    end
    return originalRandom(...)
end))

local originalPreloadAsync
originalPreloadAsync = hook(ContentProvider.PreloadAsync, cclosure(function(self, assets, callback)
    if self ~= ContentProvider then
        return originalPreloadAsync(self, assets, callback)
    end

    if isRelevantCaller() and type(assets) == "table" then
        if callback then
            for _, asset in ipairs(assets) do
                task.spawn(pcall, callback, asset, Enum.AssetFetchStatus.Success)
            end
        end
        return
    end

    return originalPreloadAsync(self, assets, callback)
end))

local mt = getrawmetatable(game)
if mt and set_readonly then
    local originalNamecall = mt.__namecall

    set_readonly(mt, false)

    mt.__namecall = cclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = { ... }

        if method == "PreloadAsync" and self == ContentProvider and isRelevantCaller() then
            pcall(function()
                local assets, callback = args[1], args[2]
                if type(assets) == "table" and callback then
                    for _, asset in ipairs(assets) do
                        task.spawn(pcall, callback, asset, Enum.AssetFetchStatus.Success)
                    end
                end
            end)
            return
        end

        return originalNamecall(self, ...)
    end)

    set_readonly(mt, true)
end

print("very true")

-- Queue the entire script to re-run on server hop/teleport so BAC bypass persists
if queue_on_teleport then
    local scriptSource = nil
    
    -- Try to get the script source for re-execution
    if getgenv()._ailon_source then
        scriptSource = getgenv()._ailon_source
    else
        -- Store the script path/source on first run
        -- Uses the loadstring approach to re-execute from saved source
        local success, source = pcall(function()
            if readfile and isfile and isfile("ailon/ailon_source.lua") then
                return readfile("ailon/ailon_source.lua")
            end
            return nil
        end)
        
        if success and source then
            scriptSource = source
        end
    end
    
    -- If we have source, queue it. Otherwise queue a loadstring fallback.
    if scriptSource then
        getgenv()._ailon_source = scriptSource
        queue_on_teleport(scriptSource)
    else
        -- Fallback: re-run the bypass portion at minimum on teleport
        queue_on_teleport([[
            getgenv()._aurorasigma = nil -- Reset so bypass runs again
            
            local ContentProvider = game:GetService("ContentProvider")
            local hook = hookfunction or detour_function or (replaceclosure and function(old, new)
                return replaceclosure(old, new)
            end)
            local cclosure = newcclosure or function(f) return f end
            local renv = getrenv and getrenv() or _G
            local set_readonly = setreadonly or (make_writeable and function(t, v)
                if v then make_writeable(t) else make_readonly(t) end
            end)
            
            local function isRelevantCaller()
                for i = 3, 6 do
                    local src = debug.info(i, "s")
                    if src and (src:find("RemoveLoadingScreen") or src:find("Loading") or src:find("Detection")) then
                        return true
                    end
                end
                if getcallingscript then
                    local ok, script = pcall(getcallingscript)
                    if ok and script then
                        local name = tostring(script)
                        if name:find("RemoveLoadingScreen") or name:find("Loading") then return true end
                    end
                end
                return false
            end
            
            local originalRandom
            originalRandom = hook(renv.math.random, cclosure(function(...)
                if isRelevantCaller() then return 0 end
                return originalRandom(...)
            end))
            
            local originalPreloadAsync
            originalPreloadAsync = hook(ContentProvider.PreloadAsync, cclosure(function(self, assets, callback)
                if self ~= ContentProvider then return originalPreloadAsync(self, assets, callback) end
                if isRelevantCaller() and type(assets) == "table" then
                    if callback then
                        for _, asset in ipairs(assets) do
                            task.spawn(pcall, callback, asset, Enum.AssetFetchStatus.Success)
                        end
                    end
                    return
                end
                return originalPreloadAsync(self, assets, callback)
            end))
            
            local mt = getrawmetatable(game)
            if mt and set_readonly then
                local originalNamecall = mt.__namecall
                set_readonly(mt, false)
                mt.__namecall = cclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = { ... }
                    if method == "PreloadAsync" and self == ContentProvider and isRelevantCaller() then
                        pcall(function()
                            local assets, callback = args[1], args[2]
                            if type(assets) == "table" and callback then
                                for _, asset in ipairs(assets) do
                                    task.spawn(pcall, callback, asset, Enum.AssetFetchStatus.Success)
                                end
                            end
                        end)
                        return
                    end
                    return originalNamecall(self, ...)
                end)
                set_readonly(mt, true)
            end
            
            print("BAC bypass re-applied after teleport")
        ]])
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

getgenv().GG = {
    Language = {
        CheckboxEnabled = "Enabled",
        CheckboxDisabled = "Disabled",
        SliderValue = "Value",
        DropdownSelect = "Select",
        DropdownNone = "None",
        DropdownSelected = "Selected",
        ButtonClick = "Click",
        TextboxEnter = "Enter",
        ModuleEnabled = "Enabled",
        ModuleDisabled = "Disabled",
        TabGeneral = "General",
        TabSettings = "Settings",
        Loading = "Loading...",
        Error = "Error",
        Success = "Success"
    }
}

-- Replace the SelectedLanguage with a reference to GG.Language
local SelectedLanguage = GG.Language

function convertStringToTable(inputString)
    local result = {}
    for value in string.gmatch(inputString, "([^,]+)") do
        local trimmedValue = value:match("^%s*(.-)%s*$")
        tablein(result, trimmedValue)
    end

    return result
end

function convertTableToString(inputTable)
    return table.concat(inputTable, ", ")
end

local UserInputService = cloneref(game:GetService('UserInputService'))
local ContentProvider = cloneref(game:GetService('ContentProvider'))
local TweenService = cloneref(game:GetService('TweenService'))
local HttpService = cloneref(game:GetService('HttpService'))
local TextService = cloneref(game:GetService('TextService'))
local RunService = cloneref(game:GetService('RunService'))
local Lighting = cloneref(game:GetService('Lighting'))
local Players = cloneref(game:GetService('Players'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local Debris = cloneref(game:GetService('Debris'))

local mouse = Players.LocalPlayer:GetMouse()
local old_ailon = CoreGui:FindFirstChild('ailon')

if old_ailon then
    Debris:AddItem(old_ailon, 0)
end

if not isfolder("ailon") then
    makefolder("ailon")
end


local Connections = setmetatable({
    disconnect = function(self, connection)
        if not self[connection] then
            return
        end
    
        self[connection]:Disconnect()
        self[connection] = nil
    end,
    disconnect_all = function(self)
        for _, value in self do
            if typeof(value) == 'function' then
                continue
            end
    
            value:Disconnect()
        end
    end
}, Connections)


local Util = setmetatable({
    map = function(self: any, value: number, in_minimum: number, in_maximum: number, out_minimum: number, out_maximum: number)
        return (value - in_minimum) * (out_maximum - out_minimum) / (in_maximum - in_minimum) + out_minimum
    end,
    viewport_point_to_world = function(self: any, location: any, distance: number)
        local unit_ray = workspace.CurrentCamera:ScreenPointToRay(location.X, location.Y)

        return unit_ray.Origin + unit_ray.Direction * distance
    end,
    get_offset = function(self: any)
        local viewport_size_Y = workspace.CurrentCamera.ViewportSize.Y

        return self:map(viewport_size_Y, 0, 2560, 8, 56)
    end
}, Util)


local AcrylicBlur = {}
AcrylicBlur.__index = AcrylicBlur


function AcrylicBlur.new(object: GuiObject)
    local self = setmetatable({
        _object = object,
        _folder = nil,
        _frame = nil,
        _root = nil
    }, AcrylicBlur)

    self:setup()

    return self
end


function AcrylicBlur:create_folder()
    local old_folder = workspace.CurrentCamera:FindFirstChild('AcrylicBlur')

    if old_folder then
        Debris:AddItem(old_folder, 0)
    end

    local folder = Instance.new('Folder')
    folder.Name = 'AcrylicBlur'
    folder.Parent = workspace.CurrentCamera

    self._folder = folder
end


function AcrylicBlur:create_depth_of_fields()
    local depth_of_fields = Lighting:FindFirstChild('AcrylicBlur') or Instance.new('DepthOfFieldEffect')
    depth_of_fields.FarIntensity = 0
    depth_of_fields.FocusDistance = 0.05
    depth_of_fields.InFocusRadius = 0.1
    depth_of_fields.NearIntensity = 1
    depth_of_fields.Name = 'AcrylicBlur'
    depth_of_fields.Parent = Lighting

    for _, object in Lighting:GetChildren() do
        if not object:IsA('DepthOfFieldEffect') then
            continue
        end

        if object == depth_of_fields then
            continue
        end

        Connections[object] = object:GetPropertyChangedSignal('FarIntensity'):Connect(function()
            object.FarIntensity = 0
        end)

        object.FarIntensity = 0
    end
end


function AcrylicBlur:create_frame()
    local frame = Instance.new('Frame')
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = 1
    frame.Parent = self._object

    self._frame = frame
end


function AcrylicBlur:create_root()
    local part = Instance.new('Part')
    part.Name = 'Root'
    part.Color = Color3.new(0, 0, 0)
    part.Material = Enum.Material.Glass
    part.Size = Vector3.new(1, 1, 0)  -- Use a thin part
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.Locked = true
    part.CastShadow = false
    part.Transparency = 0.98
    part.Parent = self._folder

    -- Create a SpecialMesh to simulate the acrylic blur effect
    local specialMesh = Instance.new('SpecialMesh')
    specialMesh.MeshType = Enum.MeshType.Brick  -- Use Brick mesh or another type suitable for the effect
    specialMesh.Offset = Vector3.new(0, 0, -0.000001)  -- Small offset to prevent z-fighting
    specialMesh.Parent = part

    self._root = part  -- Store the part as root
end


function AcrylicBlur:setup()
    self:create_depth_of_fields()
    self:create_folder()
    self:create_root()
    
    self:create_frame()
    self:render(0.001)

    self:check_quality_level()
end


function AcrylicBlur:render(distance: number)
    local positions = {
        top_left = Vector2.new(),
        top_right = Vector2.new(),
        bottom_right = Vector2.new(),
    }

    local function update_positions(size: any, position: any)
        positions.top_left = position
        positions.top_right = position + Vector2.new(size.X, 0)
        positions.bottom_right = position + size
    end

    local function update()
        local top_left = positions.top_left
        local top_right = positions.top_right
        local bottom_right = positions.bottom_right

        local top_left3D = Util:viewport_point_to_world(top_left, distance)
        local top_right3D = Util:viewport_point_to_world(top_right, distance)
        local bottom_right3D = Util:viewport_point_to_world(bottom_right, distance)

        local width = (top_right3D - top_left3D).Magnitude
        local height = (top_right3D - bottom_right3D).Magnitude

        if not self._root then
            return
        end

        self._root.CFrame = CFrame.fromMatrix((top_left3D + bottom_right3D) / 2, workspace.CurrentCamera.CFrame.XVector, workspace.CurrentCamera.CFrame.YVector, workspace.CurrentCamera.CFrame.ZVector)
        local mesh = self._root:FindFirstChildOfClass('SpecialMesh')
        if mesh then mesh.Scale = Vector3.new(width, height, 0) end
    end

    local function on_change()
        local offset = Util:get_offset()
        local size = self._frame.AbsoluteSize - Vector2.new(offset, offset)
        local position = self._frame.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

        update_positions(size, position)
        task.spawn(update)
    end

    Connections['cframe_update'] = workspace.CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(update)
    Connections['viewport_size_update'] = workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(update)
    Connections['field_of_view_update'] = workspace.CurrentCamera:GetPropertyChangedSignal('FieldOfView'):Connect(update)

    Connections['frame_absolute_position'] = self._frame:GetPropertyChangedSignal('AbsolutePosition'):Connect(on_change)
    Connections['frame_absolute_size'] = self._frame:GetPropertyChangedSignal('AbsoluteSize'):Connect(on_change)
    
    task.spawn(update)
end


function AcrylicBlur:check_quality_level()
    local game_settings = UserSettings().GameSettings
    local quality_level = game_settings.SavedQualityLevel.Value

    if quality_level < 8 then
        self:change_visiblity(false)
    end

    Connections['quality_level'] = game_settings:GetPropertyChangedSignal('SavedQualityLevel'):Connect(function()
        local game_settings = UserSettings().GameSettings
        local quality_level = game_settings.SavedQualityLevel.Value

        self:change_visiblity(quality_level >= 8)
    end)
end


function AcrylicBlur:change_visiblity(state: boolean)
    self._root.Transparency = state and 0.98 or 1
end


local Config = setmetatable({
    save = function(self: any, file_name: any, config: any)
        local success_save, result = pcall(function()
            local flags = HttpService:JSONEncode(config)
            writefile('ailon/'..file_name..'.json', flags)
        end)
    
        if not success_save then
            warn('failed to save config', result)
        end
    end,
    load = function(self: any, file_name: any, config: any)
        local success_load, result = pcall(function()
            if not isfile('ailon/'..file_name..'.json') then
                self:save(file_name, config)
        
                return
            end
        
            local flags = readfile('ailon/'..file_name..'.json')
        
            if not flags then
                self:save(file_name, config)
        
                return
            end

            return HttpService:JSONDecode(flags)
        end)
    
        if not success_load then
            warn('failed to load config', result)
        end
    
        if not result then
            result = {
                _flags = {},
                _keybinds = {},
                _library = {}
            }
        end
    
        return result
    end
}, Config)


local Library = {
    _config = Config:load(game.GameId),

    _choosing_keybind = false,
    _device = nil,

    _ui_open = true,
    _ui_scale = 1,
    _ui_loaded = false,
    _ui = nil,

    _dragging = false,
    _drag_start = nil,
    _container_position = nil
}
Library.__index = Library


function Library.new()
    local self = setmetatable({
        _loaded = false,
        _tab = 0,
    }, Library)
    
    self:create_ui()

    return self
end

-- Create Notification Container
local NotificationContainer = Instance.new("Frame")
NotificationContainer.Name = "CondemnedNotifications"
NotificationContainer.Size = UDim2.new(0, 320, 0, 0)
NotificationContainer.Position = UDim2.new(1, -10, 1, -10)
NotificationContainer.AnchorPoint = Vector2.new(1, 1)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.ClipsDescendants = false
NotificationContainer.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxGui") or game:GetService("CoreGui")
NotificationContainer.AutomaticSize = Enum.AutomaticSize.Y
Library._notifications = NotificationContainer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = NotificationContainer

-- Function to create notifications
function Library.SendNotification(settings)
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(1, 0, 0, 0)
    Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification.BackgroundTransparency = 0.1
    Notification.BorderSizePixel = 0
    Notification.Name = "Notification"
    Notification.Parent = NotificationContainer
    Notification.AutomaticSize = Enum.AutomaticSize.Y
    Notification.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Notification

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 60, 60)
    UIStroke.Transparency = 0.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = Notification

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Notification

    local Title = Instance.new("TextLabel")
    Title.Text = settings.title or "Notification"
    Title.TextColor3 = Color3.fromRGB(210, 210, 210)
    Title.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Title.TextSize = 14
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextYAlignment = Enum.TextYAlignment.Center
    Title.Parent = Notification

    local Body = Instance.new("TextLabel")
    Body.Text = settings.text or ""
    Body.TextColor3 = Color3.fromRGB(180, 180, 180)
    Body.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Body.TextSize = 12
    Body.Size = UDim2.new(1, -20, 0, 0)
    Body.Position = UDim2.new(0, 12, 0, 28)
    Body.BackgroundTransparency = 1
    Body.TextXAlignment = Enum.TextXAlignment.Left
    Body.TextYAlignment = Enum.TextYAlignment.Top
    Body.TextWrapped = true
    Body.AutomaticSize = Enum.AutomaticSize.Y
    Body.Parent = Notification

    local Padding = Instance.new("UIPadding")
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = Notification

    Notification.Position = UDim2.new(1, 330, 0, 0)

    task.spawn(function()
        local tweenIn = TweenService:Create(Notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0, 0)
        })
        tweenIn:Play()

        task.wait(settings.duration or 5)

        local tweenOut = TweenService:Create(Notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 330, 0, 0)
        })
        tweenOut:Play()

        tweenOut.Completed:Connect(function()
            Notification:Destroy()
        end)
    end)
end

function Library:get_screen_scale()
    local viewport_size_x = workspace.CurrentCamera.ViewportSize.X

    self._ui_scale = viewport_size_x / 1400
end


function Library:get_device()
    local device = 'Unknown'

    if not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
        device = 'PC'
    elseif UserInputService.TouchEnabled then
        device = 'Mobile'
    elseif UserInputService.GamepadEnabled then
        device = 'Console'
    end

    self._device = device
end


function Library:removed(action: any)
    self._ui.AncestryChanged:Once(action)
end


function Library:flag_type(flag: any, flag_type: any)
    if not Library._config._flags[flag] then
        return
    end

    return typeof(Library._config._flags[flag]) == flag_type
end


function Library:remove_table_value(__table: any, table_value: string)
    for index, value in __table do
        if value ~= table_value then
            continue
        end

        table.remove(__table, index)
    end
end


function Library:create_ui()
    local old_ailon = CoreGui:FindFirstChild('ailon')

    if old_ailon then
        Debris:AddItem(old_ailon, 0)
    end

    local ailon = Instance.new('ScreenGui')
    ailon.ResetOnSpawn = false
    ailon.Name = 'ailon'
    ailon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ailon.Parent = CoreGui
    
    local Container = Instance.new('Frame')
    Container.ClipsDescendants = true
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.Name = 'Container'
    Container.BackgroundTransparency = 0.05000000074505806
    Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    
    local ContainerGradient = Instance.new('UIGradient')
    ContainerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    ContainerGradient.Rotation = 45
    ContainerGradient.Parent = Container

    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 0, 0, 0)
    Container.Active = true
    Container.BorderSizePixel = 0
    Container.Parent = ailon
    
    local UICorner = Instance.new('UICorner')
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Container
    
    local UIStroke = Instance.new('UIStroke')
    UIStroke.Color = Color3.fromRGB(60, 60, 60)
    UIStroke.Transparency = 0.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = Container
    
    local Handler = Instance.new('Frame')
    Handler.BackgroundTransparency = 1
    Handler.Name = 'Handler'
    Handler.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Handler.Size = UDim2.new(0, 680, 0, 460)
    Handler.BorderSizePixel = 0
    Handler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Handler.Parent = Container
    
    local Tabs = Instance.new('ScrollingFrame')
    Tabs.ScrollBarImageTransparency = 1
    Tabs.ScrollBarThickness = 0
    Tabs.Name = 'Tabs'
    Tabs.Size = UDim2.new(0, 129, 0, 401)
    Tabs.Selectable = false
    Tabs.AutomaticCanvasSize = Enum.AutomaticSize.XY
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0.026097271591424942, 0, 0.1111111119389534, 0)
    Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs.BorderSizePixel = 0
    Tabs.CanvasSize = UDim2.new(0, 0, 0.5, 0)
    Tabs.Parent = Handler
    
    local UIListLayout = Instance.new('UIListLayout')
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Tabs
    
    local ClientName = Instance.new('TextLabel')
    ClientName.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    ClientName.TextColor3 = Color3.fromRGB(200, 200, 200)
    ClientName.TextTransparency = 0.20000000298023224
    ClientName.Text = 'Ailon'
    ClientName.Name = 'ClientName'
    ClientName.Size = UDim2.new(0, 45, 0, 18)
    ClientName.AnchorPoint = Vector2.new(0, 0.5)
    ClientName.Position = UDim2.new(0.07, 0, 0.055, 0)
    ClientName.BackgroundTransparency = 1
    ClientName.TextXAlignment = Enum.TextXAlignment.Left
    ClientName.BorderSizePixel = 0
    ClientName.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ClientName.TextSize = 16
    ClientName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ClientName.Parent = Handler
    
    local UIGradient = Instance.new('UIGradient')
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
    }
    UIGradient.Parent = ClientName

    task.spawn(function()
        while task.wait() do
            if not ClientName or not ClientName.Parent then break end
            UIGradient.Offset = Vector2.new(math.sin(os.clock() * 1.5), 0)
        end
    end)

    local TopDivider = Instance.new('Frame')
    TopDivider.Name = 'TopDivider'
    TopDivider.Size = UDim2.new(0.85, 0, 0, 1)
    TopDivider.Position = UDim2.new(0.5, 0, 0, 36)
    TopDivider.AnchorPoint = Vector2.new(0.5, 0)
    TopDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TopDivider.BorderSizePixel = 0
    TopDivider.Parent = Handler
    
    local TopDividerGradient = Instance.new('UIGradient')
    TopDividerGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.2, 0),
        NumberSequenceKeypoint.new(0.8, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    TopDividerGradient.Parent = TopDivider
    
    local SideDivider = Instance.new('Frame')
    SideDivider.Name = 'SideDivider'
    SideDivider.Size = UDim2.new(0, 2, 0, 340)
    SideDivider.Position = UDim2.new(0.235, 0, 0.5, 0)
    SideDivider.AnchorPoint = Vector2.new(0.5, 0.5)
    SideDivider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SideDivider.BorderSizePixel = 0
    SideDivider.Parent = Handler
    
    local SideDividerCorner = Instance.new('UICorner')
    SideDividerCorner.CornerRadius = UDim.new(1, 0)
    SideDividerCorner.Parent = SideDivider
    
    local Sections = Instance.new('Folder')
    Sections.Name = 'Sections'
    Sections.Parent = Handler


    local Icon = Instance.new('ImageLabel')
    Icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Icon.ScaleType = Enum.ScaleType.Fit
    Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.Image = 'rbxassetid://138719305710506'
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0.025, 0, 0.055, 0)
    Icon.Name = 'Icon'
    Icon.Size = UDim2.new(0, 24, 0, 24)
    Icon.BorderSizePixel = 0
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = Handler

    local IconGradient = Instance.new('UIGradient')
    IconGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
    }
    IconGradient.Parent = Icon

    task.spawn(function()
        while task.wait() do
            if not Icon or not Icon.Parent then break end
            IconGradient.Offset = Vector2.new(math.sin(os.clock() * 1.5), 0)
        end
    end)

    task.spawn(function()
        local frames = {'rbxassetid://116621149840132', 'rbxassetid://135328418151934', 'rbxassetid://73167853323814'}
        local index = 0
        while task.wait(0.20) do
            if not Icon or not Icon.Parent then break end
            index = index + 1
            Icon.Image = frames[index]
            if index == 3 then
                index = 0
            end
        end
    end)
    
    local Minimize = Instance.new('TextButton')
    Minimize.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Minimize.TextColor3 = Color3.fromRGB(0, 0, 0)
    Minimize.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Minimize.Text = ''
    Minimize.AutoButtonColor = false
    Minimize.Name = 'Minimize'
    Minimize.BackgroundTransparency = 1
    Minimize.Position = UDim2.new(0.020057305693626404, 0, 0.02922755666077137, 0)
    Minimize.Size = UDim2.new(0, 24, 0, 24)
    Minimize.BorderSizePixel = 0
    Minimize.TextSize = 14
    Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Minimize.Parent = Handler
    
    local UIScale = Instance.new('UIScale')
    UIScale.Parent = Container    
    
    self._ui = ailon

    local function on_drag(input: InputObject, process: boolean)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            self._dragging = true
            self._drag_start = input.Position
            self._container_position = Container.Position

            Connections['container_input_ended'] = input.Changed:Connect(function()
                if input.UserInputState ~= Enum.UserInputState.End then
                    return
                end

                Connections:disconnect('container_input_ended')
                self._dragging = false
            end)
        end
    end

    local function update_drag(input: any)
        local delta = input.Position - self._drag_start
        local position = UDim2.new(self._container_position.X.Scale, self._container_position.X.Offset + delta.X, self._container_position.Y.Scale, self._container_position.Y.Offset + delta.Y)

        TweenService:Create(Container, TweenInfo.new(0.2), {
            Position = position
        }):Play()
    end

    local function drag(input: InputObject, process: boolean)
        if not self._dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            update_drag(input)
        end
    end

    Connections['container_input_began'] = Container.InputBegan:Connect(on_drag)
    Connections['input_changed'] = UserInputService.InputChanged:Connect(drag)

    self:removed(function()
        self._ui = nil
        Connections:disconnect_all()
    end)

    function self:Update1Run(a)
        if a == "nil" then
            Container.BackgroundTransparency = 0.05000000074505806;
        else
            pcall(function()
                Container.BackgroundTransparency = tonumber(a);
            end);
        end;
    end;

    function self:UIVisiblity()
        ailon.Enabled = not ailon.Enabled;
    end;

    function self:change_visiblity(state: boolean)
        if state then
            TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(680, 460)
            }):Play()
        else
            TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(104.5, 52)
            }):Play()
        end
    end
    

    function self:load()
        local content = {}
    
        for _, object in ailon:GetDescendants() do
            if not object:IsA('ImageLabel') then
                continue
            end
    
            table.insert(content, object)
        end
    
        ContentProvider:PreloadAsync(content)
        self:get_device()

        if self._device == 'Mobile' or self._device == 'Unknown' then
            self:get_screen_scale()
            UIScale.Scale = self._ui_scale
    
            Connections['ui_scale'] = workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(function()
                self:get_screen_scale()
                UIScale.Scale = self._ui_scale
            end)
        end
    
        TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(680, 460)
        }):Play()

        AcrylicBlur.new(Container)
        self._ui_loaded = true
    end

    function self:update_tabs(tab: TextButton)
        for index, object in Tabs:GetChildren() do
            if object.Name ~= 'Tab' then
                continue
            end

            if object == tab then
                if object.BackgroundTransparency ~= 0.5 then
                    local offset = object.LayoutOrder * (0.113 / 1.3)

                    TweenService:Create(object, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.5
                    }):Play()

                    TweenService:Create(object.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        TextTransparency = 0.2,
                        TextColor3 = Color3.fromRGB(200, 200, 200)
                    }):Play()

                    TweenService:Create(object.TextLabel.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Offset = Vector2.new(1, 0)
                    }):Play()

                    TweenService:Create(object.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ImageTransparency = 0.2,
                        ImageColor3 = Color3.fromRGB(200, 200, 200)
                    }):Play()
                end

                continue
            end

            if object.BackgroundTransparency ~= 1 then
                TweenService:Create(object, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play()
                
                TweenService:Create(object.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TextTransparency = 0.7,
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()

                TweenService:Create(object.TextLabel.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Offset = Vector2.new(0, 0)
                }):Play()

                TweenService:Create(object.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end
        end
    end

    function self:update_sections(left_section: ScrollingFrame, right_section: ScrollingFrame)
        for _, object in Sections:GetChildren() do
            if object == left_section or object == right_section then
                object.Visible = true

                continue
            end

            object.Visible = false
        end
    end

    function self:create_tab(title: string, icon: string, visible: boolean)
        if visible == nil then visible = true end
        local TabManager = {}

        local LayoutOrder = 0;

        local font_params = Instance.new('GetTextBoundsParams')
        font_params.Text = title
        font_params.Font = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        font_params.Size = 13
        font_params.Width = 10000

        local font_size = TextService:GetTextBoundsAsync(font_params)
        local first_tab = not Tabs:FindFirstChild('Tab')

        local Tab = Instance.new('TextButton')
        Tab.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab.Text = ''
        Tab.AutoButtonColor = false
        Tab.BackgroundTransparency = 1
        Tab.Name = 'Tab'
        Tab.Size = UDim2.new(0, 129, 0, 38)
        Tab.BorderSizePixel = 0
        Tab.TextSize = 14
        Tab.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        Tab.Parent = Tabs
        Tab.Visible = visible
        Tab.LayoutOrder = self._tab
        
        local UICorner = Instance.new('UICorner')
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Tab
        
        local TabGradient = Instance.new('UIGradient')
        TabGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
        }
        TabGradient.Rotation = 90
        TabGradient.Parent = Tab
        
        local TextLabel = Instance.new('TextLabel')
        TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextTransparency = 0.7 -- 0.800000011920929
        TextLabel.Text = title
        TextLabel.Size = UDim2.new(0, font_size.X, 0, 16)
        TextLabel.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel.Position = UDim2.new(0.2400001734495163, 0, 0.5, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.BorderSizePixel = 0
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.TextSize = 13
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.Parent = Tab
        
        local UIGradient = Instance.new('UIGradient')
        UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(155, 155, 155)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 58, 58))
        }
        UIGradient.Parent = TextLabel
        
        local Icon = Instance.new('ImageLabel')
        Icon.ScaleType = Enum.ScaleType.Fit
        Icon.ImageTransparency = 0.800000011920929
        Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Icon.AnchorPoint = Vector2.new(0, 0.5)
        Icon.BackgroundTransparency = 1
        Icon.Position = UDim2.new(0.10000000149011612, 0, 0.5, 0)
        Icon.Name = 'Icon'
        Icon.Image = icon
        Icon.Size = UDim2.new(0, 12, 0, 12)
        Icon.BorderSizePixel = 0
        Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Icon.Parent = Tab
        
        Tab.MouseEnter:Connect(function()
            if Tab.BackgroundTransparency ~= 0.5 then
                TweenService:Create(TextLabel, TweenInfo.new(0.3), {TextTransparency = 0.4}):Play()
                TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0.4}):Play()
            end
        end)

        Tab.MouseLeave:Connect(function()
            if Tab.BackgroundTransparency ~= 0.5 then
                TweenService:Create(TextLabel, TweenInfo.new(0.3), {TextTransparency = 0.7}):Play()
                TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0.8}):Play()
            end
        end)

        local LeftSection = Instance.new('ScrollingFrame')
        LeftSection.Name = 'LeftSection'
        LeftSection.AutomaticCanvasSize = Enum.AutomaticSize.XY
        LeftSection.ScrollBarThickness = 0
        LeftSection.Size = UDim2.new(0, 243, 0, 374)
        LeftSection.Selectable = false
        LeftSection.AnchorPoint = Vector2.new(0, 0.5)
        LeftSection.ScrollBarImageTransparency = 1
        LeftSection.BackgroundTransparency = 1
        LeftSection.Position = UDim2.new(0.2594326436519623, 0, 0.5, 0)
        LeftSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LeftSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LeftSection.BorderSizePixel = 0
        LeftSection.CanvasSize = UDim2.new(0, 0, 0.5, 0)
        LeftSection.Visible = false
        LeftSection.Parent = Sections
        
        local UIListLayout = Instance.new('UIListLayout')
        UIListLayout.Padding = UDim.new(0, 11)
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = LeftSection
        
        local UIPadding = Instance.new('UIPadding')
        UIPadding.PaddingTop = UDim.new(0, 1)
        UIPadding.Parent = LeftSection

        local RightSection = Instance.new('ScrollingFrame')
        RightSection.Name = 'RightSection'
        RightSection.AutomaticCanvasSize = Enum.AutomaticSize.XY
        RightSection.ScrollBarThickness = 0
        RightSection.Size = UDim2.new(0, 243, 0, 374)
        RightSection.Selectable = false
        RightSection.AnchorPoint = Vector2.new(0, 0.5)
        RightSection.ScrollBarImageTransparency = 1
        RightSection.BackgroundTransparency = 1
        RightSection.Position = UDim2.new(0.6290000081062317, 0, 0.5, 0)
        RightSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
        RightSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        RightSection.BorderSizePixel = 0
        RightSection.CanvasSize = UDim2.new(0, 0, 0.5, 0)
        RightSection.Visible = false
        RightSection.Parent = Sections
        
        local UIListLayout = Instance.new('UIListLayout')
        UIListLayout.Padding = UDim.new(0, 11)
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = RightSection
        
        local UIPadding = Instance.new('UIPadding')
        UIPadding.PaddingTop = UDim.new(0, 1)
        UIPadding.Parent = RightSection

        self._tab += 1

        if first_tab then
            self:update_tabs(Tab, LeftSection, RightSection)
            self:update_sections(LeftSection, RightSection)
        end

        Tab.MouseButton1Click:Connect(function()
            self:update_tabs(Tab, LeftSection, RightSection)
            self:update_sections(LeftSection, RightSection)
        end)

        function TabManager:SetVisible(state: boolean)
            Tab.Visible = state
        end

        function TabManager:create_module(settings: any)

            local LayoutOrderModule = 0;

            local ModuleManager = {
                _state = false,
                _locked = false,
                _size = 0,
                _multiplier = 0
            }

            if settings.section == 'right' then
                settings.section = RightSection
            else
                settings.section = LeftSection
            end

            local Module = Instance.new('Frame')
            Module.ClipsDescendants = true
            Module.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Module.BackgroundTransparency = 0.5
            Module.Position = UDim2.new(0.004115226212888956, 0, 0, 0)
            Module.Name = 'Module'
            Module.Size = UDim2.new(0, 241, 0, 93)
            Module.BorderSizePixel = 0
            Module.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
            Module.Parent = settings.section

            local UIListLayout = Instance.new('UIListLayout')
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = Module
            
            local UICorner = Instance.new('UICorner')
            UICorner.CornerRadius = UDim.new(0, 8)
            UICorner.Parent = Module
            
            local UIStroke = Instance.new('UIStroke')
            UIStroke.Color = Color3.fromRGB(100, 100, 100)
            UIStroke.Transparency = 0.7
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            UIStroke.Parent = Module
            
            local Header = Instance.new('TextButton')
            Header.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            Header.TextColor3 = Color3.fromRGB(0, 0, 0)
            Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Header.Text = ''
            Header.AutoButtonColor = false
            Header.BackgroundTransparency = 1
            Header.Name = 'Header'
            Header.Size = UDim2.new(0, 241, 0, 93)
            Header.BorderSizePixel = 0
            Header.TextSize = 14
            Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Header.Parent = Module
    
-- ==================== PER-MODULE LOCK BUTTON (Fixed + Small) ====================
local LockButton = Instance.new('ImageButton')
LockButton.Name = 'LockButton'
LockButton.Size = UDim2.new(0, 13, 0, 13)
LockButton.AnchorPoint = Vector2.new(1, 0)
LockButton.Position = UDim2.new(1, -6, 0, 6)
LockButton.BackgroundTransparency = 1
LockButton.Image = 'rbxassetid://12060512624'
LockButton.ImageColor3 = Color3.fromRGB(150, 150, 150)
LockButton.ZIndex = 10
LockButton.Parent = Header

ModuleManager._locked = false

local function updateLockVisual()
    if ModuleManager._locked then
        LockButton.ImageColor3 = Color3.fromRGB(255, 65, 65)
    else
        LockButton.ImageColor3 = Color3.fromRGB(150, 150, 150)
    end
end

local function setModuleInteractable(state: boolean)
    for _, desc in ipairs(Module:GetDescendants()) do
        if desc == LockButton then continue end
        
        if desc:IsA("TextButton") or desc:IsA("ImageButton") or desc:IsA("TextBox") then
            desc.Active = state
            desc.Selectable = state
            
            if desc:IsA("TextButton") or desc:IsA("ImageButton") then
                desc.AutoButtonColor = state
            end
            
            -- Extra safety for sliders and colorpickers
            if desc.Name == "Circle" or desc.Name == "Swatch" or desc.Name == "HueStrip" or desc.Name == "SvSquare" then
                desc.Active = state
            end
        end
    end
end

LockButton.MouseButton1Click:Connect(function()
    if Library._choosing_keybind then return end
    
    ModuleManager._locked = not ModuleManager._locked
    
    updateLockVisual()
    setModuleInteractable(not ModuleManager._locked)   -- This is the key fix
    
    Library.SendNotification({
        title = ModuleManager._locked and "Module Locked" or "Module Unlocked",
        text = settings.title or "",
        duration = 1.5
    })
end)

-- Hover
LockButton.MouseEnter:Connect(function()
    TweenService:Create(LockButton, TweenInfo.new(0.15), {
        ImageColor3 = ModuleManager._locked and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(220, 220, 220)
    }):Play()
end)

LockButton.MouseLeave:Connect(function()
    updateLockVisual()
end)

-- Initial setup
updateLockVisual()
setModuleInteractable(true)

    LockButton.MouseButton1Click:Connect(function()
        ModuleManager._locked = not ModuleManager._locked
        if ModuleManager._locked then
            game:GetService("TweenService"):Create(LockButton, TweenInfo.new(0.2), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            game:GetService("TweenService"):Create(LockButton, TweenInfo.new(0.2), {
                ImageColor3 = Color3.fromRGB(150, 150, 150)
            }):Play()
        end
    end)
            
            local Icon = Instance.new('ImageLabel')
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            Icon.ScaleType = Enum.ScaleType.Fit
            Icon.ImageTransparency = 0.699999988079071
            Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.Image = 'rbxassetid://79095934438045'
            Icon.BackgroundTransparency = 1
            Icon.Position = UDim2.new(0.07100000232458115, 0, 0.8199999928474426, 0)
            Icon.Name = 'Icon'
            Icon.Size = UDim2.new(0, 15, 0, 15)
            Icon.BorderSizePixel = 0
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.Parent = Header
            
            local ModuleName = Instance.new('TextLabel')
            ModuleName.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            ModuleName.TextColor3 = Color3.fromRGB(200, 200, 200)
            ModuleName.TextTransparency = 0.20000000298023224
            if not settings.rich then
                ModuleName.Text = settings.title or "Skibidi"
            else
                ModuleName.RichText = true
                ModuleName.Text = settings.richtext or "<font color='rgb(200,200,200)'>ailon</font> user"
            end;
            ModuleName.Name = 'ModuleName'
            ModuleName.Size = UDim2.new(0, 205, 0, 13)
            ModuleName.AnchorPoint = Vector2.new(0, 0.5)
            ModuleName.Position = UDim2.new(0.0729999989271164, 0, 0.23999999463558197, 0)
            ModuleName.BackgroundTransparency = 1
            ModuleName.TextXAlignment = Enum.TextXAlignment.Left
            ModuleName.BorderSizePixel = 0
            ModuleName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ModuleName.TextSize = 13
            ModuleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ModuleName.Parent = Header
            
            local Description = Instance.new('TextLabel')
            Description.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            Description.TextColor3 = Color3.fromRGB(200, 200, 200)
            Description.TextTransparency = 0.699999988079071
            Description.Text = settings.description
            Description.Name = 'Description'
            Description.Size = UDim2.new(0, 205, 0, 13)
            Description.AnchorPoint = Vector2.new(0, 0.5)
            Description.Position = UDim2.new(0.0729999989271164, 0, 0.41999998688697815, 0)
            Description.BackgroundTransparency = 1
            Description.TextXAlignment = Enum.TextXAlignment.Left
            Description.BorderSizePixel = 0
            Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Description.TextSize = 10
            Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Description.Parent = Header
            
            local Toggle = Instance.new('Frame')
            Toggle.Name = 'Toggle'
            Toggle.BackgroundTransparency = 0.699999988079071
            Toggle.Position = UDim2.new(0.8199999928474426, 0, 0.7570000290870667, 0)
            Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.Size = UDim2.new(0, 25, 0, 12)
            Toggle.BorderSizePixel = 0
            Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.Parent = Header
            
            local UICorner = Instance.new('UICorner')
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = Toggle
            
            local Circle = Instance.new('Frame')
            Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Circle.AnchorPoint = Vector2.new(0, 0.5)
            Circle.BackgroundTransparency = 0.20000000298023224
            Circle.Position = UDim2.new(0, 0, 0.5, 0)
            Circle.Name = 'Circle'
            Circle.Size = UDim2.new(0, 12, 0, 12)
            Circle.BorderSizePixel = 0
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.Parent = Toggle
            
            local UICorner = Instance.new('UICorner')
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = Circle
            
            local Keybind = Instance.new('Frame')
            Keybind.Name = 'Keybind'
            Keybind.BackgroundTransparency = 0.699999988079071
            Keybind.Position = UDim2.new(0.15000000596046448, 0, 0.7350000143051147, 0)
            Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.Size = UDim2.new(0, 33, 0, 15)
            Keybind.BorderSizePixel = 0
            Keybind.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
            Keybind.Parent = Header
            
            local UICorner = Instance.new('UICorner')
            UICorner.CornerRadius = UDim.new(0, 3)
            UICorner.Parent = Keybind
            
            local TextLabel = Instance.new('TextLabel')
            TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.Text = 'None'
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.Size = UDim2.new(0, 25, 0, 13)
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.TextSize = 10
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.Parent = Keybind
            
            local Divider = Instance.new('Frame')
            Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Divider.AnchorPoint = Vector2.new(0.5, 0)
            Divider.BackgroundTransparency = 0.5
            Divider.Position = UDim2.new(0.5, 0, 0.6200000047683716, 0)
            Divider.Name = 'Divider'
            Divider.Size = UDim2.new(0, 241, 0, 1)
            Divider.BorderSizePixel = 0
            Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Divider.Parent = Header
            
            local Divider = Instance.new('Frame')
            Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Divider.AnchorPoint = Vector2.new(0.5, 0)
            Divider.BackgroundTransparency = 0.5
            Divider.Position = UDim2.new(0.5, 0, 1, 0)
            Divider.Name = 'Divider'
            Divider.Size = UDim2.new(0, 241, 0, 1)
            Divider.BorderSizePixel = 0
            Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Divider.Parent = Header
            
            local Options = Instance.new('Frame')
            Options.Name = 'Options'
            Options.BackgroundTransparency = 1
            Options.Position = UDim2.new(0, 0, 1, 0)
            Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Options.Size = UDim2.new(0, 241, 0, 8)
            Options.BorderSizePixel = 0
            Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Options.Parent = Module

            local UIPadding = Instance.new('UIPadding')
            UIPadding.PaddingTop = UDim.new(0, 8)
            UIPadding.Parent = Options

            local UIListLayout = Instance.new('UIListLayout')
            UIListLayout.Padding = UDim.new(0, 5)
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = Options

            function ModuleManager:change_state(state: boolean)
                self._state = state

                if self._state then
                    TweenService:Create(Module, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.fromOffset(241, 93 + self._size + self._multiplier)
                    }):Play()

                    TweenService:Create(Toggle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(160, 160, 160)
                    }):Play()

                    TweenService:Create(Circle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(160, 160, 160),
                        Position = UDim2.fromScale(0.53, 0.5)
                    }):Play()
                else
                    TweenService:Create(Module, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.fromOffset(241, 93)
                    }):Play()

                    TweenService:Create(Toggle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    }):Play()

                    TweenService:Create(Circle, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Position = UDim2.fromScale(0, 0.5)
                    }):Play()
                end

                Library._config._flags[settings.flag] = self._state
                Config:save(game.GameId, Library._config)

                settings.callback(self._state)
            end
            
            function ModuleManager:connect_keybind()
                if not Library._config._keybinds[settings.flag] then
                    return
                end

                Connections[settings.flag..'_keybind'] = UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
                if ModuleManager._locked then return end
                    if process then
                        return
                    end
                    
                    if tostring(input.KeyCode) ~= Library._config._keybinds[settings.flag] then
                        return
                    end
                    
                    self:change_state(not self._state)
                end)
            end

            function ModuleManager:scale_keybind(empty: boolean)
                if Library._config._keybinds[settings.flag] and not empty then
                    local keybind_string = string.gsub(tostring(Library._config._keybinds[settings.flag]), 'Enum.KeyCode.', '')

                    local font_params = Instance.new('GetTextBoundsParams')
                    font_params.Text = keybind_string
                    font_params.Font = Font.new('rbxasset://fonts/families/Montserrat.json', Enum.FontWeight.Bold)
                    font_params.Size = 10
                    font_params.Width = 10000
            
                    local font_size = TextService:GetTextBoundsAsync(font_params)
                    
                    Keybind.Size = UDim2.fromOffset(font_size.X + 6, 15)
                    TextLabel.Size = UDim2.fromOffset(font_size.X, 13)
                else
                    Keybind.Size = UDim2.fromOffset(31, 15)
                    TextLabel.Size = UDim2.fromOffset(25, 13)
                end
            end

            if Library:flag_type(settings.flag, 'boolean') then
                ModuleManager._state = true
                settings.callback(ModuleManager._state)

                Toggle.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
                Circle.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
                Circle.Position = UDim2.fromScale(0.53, 0.5)
            end

            if Library._config._keybinds[settings.flag] then
                local keybind_string = string.gsub(tostring(Library._config._keybinds[settings.flag]), 'Enum.KeyCode.', '')
                TextLabel.Text = keybind_string

                ModuleManager:connect_keybind()
                ModuleManager:scale_keybind()
            end

            Connections[settings.flag..'_input_began'] = Header.InputBegan:Connect(function(input: InputObject)
                if Library._choosing_keybind then
                    return
                end

                if input.UserInputType ~= Enum.UserInputType.MouseButton3 then
                    return
                end
                
                Library._choosing_keybind = true
                
                Connections['keybind_choose_start'] = UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
                if ModuleManager._locked then return end
                    if process then
                        return
                    end
                    
                    if input == Enum.UserInputState or input == Enum.UserInputType then
                        return
                    end

                    if input.KeyCode == Enum.KeyCode.Unknown then
                        return
                    end

                    if input.KeyCode == Enum.KeyCode.Backspace then
                        ModuleManager:scale_keybind(true)

                        Library._config._keybinds[settings.flag] = nil
                        Config:save(game.GameId, Library._config)

                        TextLabel.Text = 'None'
                        
                        if Connections[settings.flag..'_keybind'] then
                            Connections[settings.flag..'_keybind']:Disconnect()
                            Connections[settings.flag..'_keybind'] = nil
                        end

                        Connections['keybind_choose_start']:Disconnect()
                        Connections['keybind_choose_start'] = nil

                        Library._choosing_keybind = false

                        return
                    end
                    
                    Connections['keybind_choose_start']:Disconnect()
                    Connections['keybind_choose_start'] = nil
                    
                    Library._config._keybinds[settings.flag] = tostring(input.KeyCode)
                    Config:save(game.GameId, Library._config)

                    if Connections[settings.flag..'_keybind'] then
                        Connections[settings.flag..'_keybind']:Disconnect()
                        Connections[settings.flag..'_keybind'] = nil
                    end

                    ModuleManager:connect_keybind()
                    ModuleManager:scale_keybind()
                    
                    Library._choosing_keybind = false

                    local keybind_string = string.gsub(tostring(Library._config._keybinds[settings.flag]), 'Enum.KeyCode.', '')
                    TextLabel.Text = keybind_string
                end)
            end)

            Header.MouseButton1Click:Connect(function()
                ModuleManager:change_state(not ModuleManager._state)
            end)

            function ModuleManager:create_paragraph(settings: any)
                LayoutOrderModule = LayoutOrderModule + 1;

                local ParagraphManager = {}
                
                if self._size == 0 then
                    self._size = 11
                end
            
                self._size += settings.customScale or 70
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end
            
                Options.Size = UDim2.fromOffset(241, self._size)
            
                -- Container Frame
                local Paragraph = Instance.new('Frame')
                Paragraph.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Paragraph.BackgroundTransparency = 0.1
                Paragraph.Size = UDim2.new(0, 207, 0, 30) -- Initial size, auto-resized later
                Paragraph.BorderSizePixel = 0
                Paragraph.Name = "Paragraph"
                Paragraph.AutomaticSize = Enum.AutomaticSize.Y -- Support auto-resizing height
                Paragraph.Parent = Options
                Paragraph.LayoutOrder = LayoutOrderModule;
            
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Paragraph
            
                -- Title Label
                local Title = Instance.new('TextLabel')
                Title.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Title.TextColor3 = Color3.fromRGB(210, 210, 210)
                Title.Text = settings.title or "Title"
                Title.Size = UDim2.new(1, -10, 0, 20)
                Title.Position = UDim2.new(0, 5, 0, 5)
                Title.BackgroundTransparency = 1
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextYAlignment = Enum.TextYAlignment.Center
                Title.TextSize = 12
                Title.AutomaticSize = Enum.AutomaticSize.XY
                Title.Parent = Paragraph
            
                -- Body Text
                local Body = Instance.new('TextLabel')
                Body.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Body.TextColor3 = Color3.fromRGB(180, 180, 180)
                
                if not settings.rich then
                    Body.Text = settings.text or "Skibidi"
                else
                    Body.RichText = true
                    Body.Text = settings.richtext or "<font color='rgb(200,200,200)'>ailon</font> user"
                end
                
                Body.Size = UDim2.new(1, -10, 0, 20)
                Body.Position = UDim2.new(0, 5, 0, 30)
                Body.BackgroundTransparency = 1
                Body.TextXAlignment = Enum.TextXAlignment.Left
                Body.TextYAlignment = Enum.TextYAlignment.Top
                Body.TextSize = 11
                Body.TextWrapped = true
                Body.AutomaticSize = Enum.AutomaticSize.XY
                Body.Parent = Paragraph
            
                -- Hover effect for Paragraph (optional)
                Paragraph.MouseEnter:Connect(function()
                    TweenService:Create(Paragraph, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    }):Play()
                end)
            
                Paragraph.MouseLeave:Connect(function()
                    TweenService:Create(Paragraph, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    }):Play()
                end)

                return ParagraphManager
            end

            function ModuleManager:create_colorpicker(settings: any)
    LayoutOrderModule = LayoutOrderModule + 1

    local ColorpickerManager = {
        _color = settings.default or Color3.fromRGB(255, 0, 0),
        _h = 0, _s = 1, _v = 1
    }

    -- Init HSV from default
    do
        local c = ColorpickerManager._color
        local h, s, v = Color3.toHSV(c)
        ColorpickerManager._h = h
        ColorpickerManager._s = s
        ColorpickerManager._v = v
    end

    -- Load saved color
    if Library._config._flags[settings.flag] then
        local sv = Library._config._flags[settings.flag]
        if type(sv) == "table" and sv.R then
            local c = Color3.fromRGB(sv.R, sv.G, sv.B)
            ColorpickerManager._color = c
            local h, s, v = Color3.toHSV(c)
            ColorpickerManager._h = h
            ColorpickerManager._s = s
            ColorpickerManager._v = v
        end
    end

    if self._size == 0 then self._size = 11 end
    self._size += 32

    if ModuleManager._state then
        Module.Size = UDim2.fromOffset(241, 93 + self._size)
    end
    Options.Size = UDim2.fromOffset(241, self._size)

    -- ── Row (label + swatch) ──────────────────────────────────────────────
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0, 207, 0, 22)
    Row.BackgroundTransparency = 1
    Row.LayoutOrder = LayoutOrderModule
    Row.Parent = Options

    local Label = Instance.new("TextLabel")
    Label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextTransparency = 0.2
    Label.Text = settings.title or "Color"
    Label.Size = UDim2.new(1, -30, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 11
    Label.Parent = Row

    local Swatch = Instance.new("TextButton")
    Swatch.Size = UDim2.new(0, 22, 0, 22)
    Swatch.Position = UDim2.new(1, -22, 0, 0)
    Swatch.BackgroundColor3 = ColorpickerManager._color
    Swatch.BorderSizePixel = 0
    Swatch.Text = ""
    Swatch.AutoButtonColor = false
    Swatch.Parent = Row
    Instance.new("UICorner", Swatch).CornerRadius = UDim.new(0, 5)
    local SwatchStroke = Instance.new("UIStroke", Swatch)
    SwatchStroke.Color = Color3.fromRGB(100, 100, 100)
    SwatchStroke.Transparency = 0.5

    -- ── Popup panel ───────────────────────────────────────────────────────
    local POPUP_H = 180
    local popupOpen = false

    local Popup = Instance.new("Frame")
    Popup.Size = UDim2.new(0, 207, 0, 0)
    Popup.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Popup.BorderSizePixel = 0
    Popup.ClipsDescendants = true
    Popup.LayoutOrder = LayoutOrderModule
    Popup.Parent = Options
    Instance.new("UICorner", Popup).CornerRadius = UDim.new(0, 7)
    local PopupStroke = Instance.new("UIStroke", Popup)
    PopupStroke.Color = Color3.fromRGB(70, 70, 70)
    PopupStroke.Transparency = 0.4

    -- Inner wrapper so ClipsDescendants hides during close tween
    local Inner = Instance.new("Frame")
    Inner.Size = UDim2.new(1, 0, 0, POPUP_H)
    Inner.BackgroundTransparency = 1
    Inner.Parent = Popup

    -- ── SV square (left, 150×150) ─────────────────────────────────────────
    local SQ = 145
    local SvSquare = Instance.new("TextButton")
    SvSquare.Size = UDim2.new(0, SQ, 0, SQ)
    SvSquare.Position = UDim2.new(0, 8, 0, 10)
    SvSquare.BackgroundColor3 = Color3.fromHSV(ColorpickerManager._h, 1, 1)
    SvSquare.BorderSizePixel = 0
    SvSquare.Text = ""
    SvSquare.AutoButtonColor = false
    SvSquare.Parent = Inner
    Instance.new("UICorner", SvSquare).CornerRadius = UDim.new(0, 5)

    -- White→transparent (left to right: white gradient)
    local WhiteGrad = Instance.new("Frame")
    WhiteGrad.Size = UDim2.new(1, 0, 1, 0)
    WhiteGrad.BackgroundTransparency = 0
    WhiteGrad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WhiteGrad.BorderSizePixel = 0
    WhiteGrad.Parent = SvSquare
    Instance.new("UICorner", WhiteGrad).CornerRadius = UDim.new(0, 5)
    local WG = Instance.new("UIGradient", WhiteGrad)
    WG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
    }
    WG.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    WG.Rotation = 0

    -- Black→transparent (bottom to top: black gradient)
    local BlackGrad = Instance.new("Frame")
    BlackGrad.Size = UDim2.new(1, 0, 1, 0)
    BlackGrad.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BlackGrad.BackgroundTransparency = 0
    BlackGrad.BorderSizePixel = 0
    BlackGrad.Parent = SvSquare
    Instance.new("UICorner", BlackGrad).CornerRadius = UDim.new(0, 5)
    local BG = Instance.new("UIGradient", BlackGrad)
    BG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
    }
    BG.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    BG.Rotation = 90

    -- Picker circle on the SV square
    local Picker = Instance.new("Frame")
    Picker.Size = UDim2.new(0, 10, 0, 10)
    Picker.AnchorPoint = Vector2.new(0.5, 0.5)
    Picker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Picker.BorderSizePixel = 0
    Picker.ZIndex = 5
    Picker.Position = UDim2.new(
        ColorpickerManager._s,
        0,
        1 - ColorpickerManager._v,
        0
    )
    Picker.Parent = SvSquare
    Instance.new("UICorner", Picker).CornerRadius = UDim.new(1, 0)
    local PickerStroke = Instance.new("UIStroke", Picker)
    PickerStroke.Color = Color3.fromRGB(0, 0, 0)
    PickerStroke.Thickness = 1.5
    PickerStroke.Transparency = 0.3

    -- ── Hue strip (right of square) ───────────────────────────────────────
    local HueStrip = Instance.new("TextButton")
    HueStrip.Size = UDim2.new(0, 14, 0, SQ)
    HueStrip.Position = UDim2.new(0, 8 + SQ + 6, 0, 10)
    HueStrip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HueStrip.BorderSizePixel = 0
    HueStrip.Text = ""
    HueStrip.AutoButtonColor = false
    HueStrip.Parent = Inner
    Instance.new("UICorner", HueStrip).CornerRadius = UDim.new(0, 4)

    -- Hue rainbow gradient (top=0°, bottom=360°)
    local HueGrad = Instance.new("UIGradient", HueStrip)
    HueGrad.Rotation = 90
    local hueKP = {}
    for i = 0, 6 do
        hueKP[i+1] = ColorSequenceKeypoint.new(i/6, Color3.fromHSV(i/6, 1, 1))
    end
    HueGrad.Color = ColorSequence.new(hueKP)

    -- Hue cursor line
    local HueCursor = Instance.new("Frame")
    HueCursor.Size = UDim2.new(1, 4, 0, 3)
    HueCursor.Position = UDim2.new(0, -2, ColorpickerManager._h, -1)
    HueCursor.AnchorPoint = Vector2.new(0, 0.5)
    HueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HueCursor.BorderSizePixel = 0
    HueCursor.ZIndex = 5
    HueCursor.Parent = HueStrip
    Instance.new("UICorner", HueCursor).CornerRadius = UDim.new(1, 0)
    local HueCursorStroke = Instance.new("UIStroke", HueCursor)
    HueCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    HueCursorStroke.Thickness = 1
    HueCursorStroke.Transparency = 0.4

    -- ── Hex input + preview row at the bottom ─────────────────────────────
    local BottomRow = Instance.new("Frame")
    BottomRow.Size = UDim2.new(1, -16, 0, 22)
    BottomRow.Position = UDim2.new(0, 8, 0, 10 + SQ + 8)
    BottomRow.BackgroundTransparency = 1
    BottomRow.Parent = Inner

    local PreviewSwatch = Instance.new("Frame")
    PreviewSwatch.Size = UDim2.new(0, 22, 0, 22)
    PreviewSwatch.BackgroundColor3 = ColorpickerManager._color
    PreviewSwatch.BorderSizePixel = 0
    PreviewSwatch.Parent = BottomRow
    Instance.new("UICorner", PreviewSwatch).CornerRadius = UDim.new(0, 5)

    local HexLabel = Instance.new("TextLabel")
    HexLabel.Text = "#"
    HexLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    HexLabel.TextSize = 10
    HexLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    HexLabel.Size = UDim2.new(0, 12, 1, 0)
    HexLabel.Position = UDim2.new(0, 28, 0, 0)
    HexLabel.BackgroundTransparency = 1
    HexLabel.TextXAlignment = Enum.TextXAlignment.Center
    HexLabel.Parent = BottomRow

    local HexBox = Instance.new("TextBox")
    HexBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    HexBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    HexBox.PlaceholderText = "FF0000"
    HexBox.Text = ""
    HexBox.TextSize = 10
    HexBox.Size = UDim2.new(1, -46, 1, 0)
    HexBox.Position = UDim2.new(0, 42, 0, 0)
    HexBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    HexBox.BackgroundTransparency = 0.3
    HexBox.BorderSizePixel = 0
    HexBox.ClearTextOnFocus = false
    HexBox.Parent = BottomRow
    Instance.new("UICorner", HexBox).CornerRadius = UDim.new(0, 4)

    -- ── Helpers ───────────────────────────────────────────────────────────
    local function colorToHex(c)
        return string.format("%02X%02X%02X",
            math.round(c.R * 255),
            math.round(c.G * 255),
            math.round(c.B * 255))
    end

    local function hexToColor(hex)
        hex = hex:gsub("#","")
        if #hex ~= 6 then return nil end
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16)
        local b = tonumber(hex:sub(5,6), 16)
        if not (r and g and b) then return nil end
        return Color3.fromRGB(r, g, b)
    end

    local function applyColor(h, s, v, skipHex)
        ColorpickerManager._h = h
        ColorpickerManager._s = s
        ColorpickerManager._v = v
        local color = Color3.fromHSV(h, s, v)
        ColorpickerManager._color = color

        -- Update square background to pure hue
        SvSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)

        -- Move picker dot: X = saturation, Y = (1-value)
        Picker.Position = UDim2.new(math.clamp(s, 0, 1), 0, math.clamp(1 - v, 0, 1), 0)

        -- Move hue cursor
        HueCursor.Position = UDim2.new(0, -2, math.clamp(h, 0, 0.9999), -1)

        -- Update swatches
        Swatch.BackgroundColor3 = color
        PreviewSwatch.BackgroundColor3 = color

        -- Update hex
        if not skipHex then
            HexBox.Text = colorToHex(color)
        end

        -- Save + callback
        Library._config._flags[settings.flag] = {
            R = math.round(color.R * 255),
            G = math.round(color.G * 255),
            B = math.round(color.B * 255)
        }
        Config:save(game.GameId, Library._config)
        if settings.callback then settings.callback(color) end
    end

    function ColorpickerManager:set_color(color)
        local h, s, v = Color3.toHSV(color)
        applyColor(h, s, v)
    end

    -- Initial sync
    applyColor(ColorpickerManager._h, ColorpickerManager._s, ColorpickerManager._v)

    -- ── SV square drag ────────────────────────────────────────────────────
    local svDragging = false

    local function updateSV()
        local rx = math.clamp((mouse.X - SvSquare.AbsolutePosition.X) / SvSquare.AbsoluteSize.X, 0, 1)
        local ry = math.clamp((mouse.Y - SvSquare.AbsolutePosition.Y) / SvSquare.AbsoluteSize.Y, 0, 1)
        applyColor(ColorpickerManager._h, rx, 1 - ry)
    end

    SvSquare.MouseButton1Down:Connect(function()
        if ModuleManager._locked then return end
        svDragging = true
        updateSV()
    end)

    Connections["sv_move_"..settings.flag] = UserInputService.InputChanged:Connect(function(inp)
        if svDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            updateSV()
        end
    end)

    Connections["sv_end_"..settings.flag] = UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            svDragging = false
        end
    end)

    -- ── Hue strip drag ────────────────────────────────────────────────────
    local hueDragging = false

    local function updateHue()
        local ry = math.clamp((mouse.Y - HueStrip.AbsolutePosition.Y) / HueStrip.AbsoluteSize.Y, 0, 0.9999)
        applyColor(ry, ColorpickerManager._s, ColorpickerManager._v)
    end

    HueStrip.MouseButton1Down:Connect(function()
        if ModuleManager._locked then return end
        hueDragging = true
        updateHue()
    end)

    Connections["hue_move_"..settings.flag] = UserInputService.InputChanged:Connect(function(inp)
        if hueDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            updateHue()
        end
    end)

    Connections["hue_end_"..settings.flag] = UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            hueDragging = false
        end
    end)

    -- ── Hex input ─────────────────────────────────────────────────────────
    HexBox.FocusLost:Connect(function()
        if ModuleManager._locked then
            HexBox.Text = colorToHex(ColorpickerManager._color)
            return
        end
        local color = hexToColor(HexBox.Text)
        if color then
            local h, s, v = Color3.toHSV(color)
            applyColor(h, s, v, true)
        else
            HexBox.Text = colorToHex(ColorpickerManager._color)
        end
    end)

    -- ── Toggle popup ──────────────────────────────────────────────────────
    Swatch.MouseButton1Click:Connect(function()
        if ModuleManager._locked then return end
        popupOpen = not popupOpen

        if popupOpen then
            self._size += POPUP_H
            if ModuleManager._state then
                Module.Size = UDim2.fromOffset(241, 93 + self._size)
            end
            Options.Size = UDim2.fromOffset(241, self._size)

            TweenService:Create(Popup, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(207, POPUP_H)
            }):Play()
        else
            self._size -= POPUP_H
            if ModuleManager._state then
                Module.Size = UDim2.fromOffset(241, 93 + self._size)
            end
            Options.Size = UDim2.fromOffset(241, self._size)

            TweenService:Create(Popup, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(207, 0)
            }):Play()
        end
    end)

    return ColorpickerManager
end

            function ModuleManager:create_text(settings: any)
                LayoutOrderModule = LayoutOrderModule + 1
            
                local TextManager = {}
            
                if self._size == 0 then
                    self._size = 11
                end
            
                self._size += settings.customScale or 50 -- Adjust the default height for text elements
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end
            
                Options.Size = UDim2.fromOffset(241, self._size)
            
                -- Container Frame
                local TextFrame = Instance.new('Frame')
                TextFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                TextFrame.BackgroundTransparency = 0.1
                TextFrame.Size = UDim2.new(0, 207, 0, settings.CustomYSize) -- Initial size, auto-resized later
                TextFrame.BorderSizePixel = 0
                TextFrame.Name = "Text"
                TextFrame.AutomaticSize = Enum.AutomaticSize.Y -- Support auto-resizing height
                TextFrame.Parent = Options
                TextFrame.LayoutOrder = LayoutOrderModule
            
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = TextFrame
            
                -- Body Text
                local Body = Instance.new('TextLabel')
                Body.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Body.TextColor3 = Color3.fromRGB(180, 180, 180)
            
                if not settings.rich then
                    Body.Text = settings.text or "Skibidi" -- Default text
                else
                    Body.RichText = true
                    Body.Text = settings.richtext or "<font color='rgb(200,200,200)'>ailon</font> user" -- Default rich text
                end
            
                Body.Size = UDim2.new(1, -10, 1, 0)
                Body.Position = UDim2.new(0, 5, 0, 5)
                Body.BackgroundTransparency = 1
                Body.TextXAlignment = Enum.TextXAlignment.Left
                Body.TextYAlignment = Enum.TextYAlignment.Top
                Body.TextSize = 10
                Body.TextWrapped = true
                Body.AutomaticSize = Enum.AutomaticSize.XY
                Body.Parent = TextFrame
            
                -- Hover effect for TextFrame (optional)
                TextFrame.MouseEnter:Connect(function()
                    TweenService:Create(TextFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    }):Play()
                end)
            
                TextFrame.MouseLeave:Connect(function()
                    TweenService:Create(TextFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    }):Play()
                end)

                function TextManager:Set(new_settings)
                    if not new_settings.rich then
                        Body.Text = new_settings.text or "Skibidi" -- Default text
                    else
                        Body.RichText = true
                        Body.Text = new_settings.richtext or "<font color='rgb(200,200,200)'>ailon</font> user" -- Default rich text
                    end
                end;
            
                return TextManager
            end
            function ModuleManager:create_textbox(settings: any)
                LayoutOrderModule = LayoutOrderModule + 1
            
                local TextboxManager = {
                    _text = ""
                }
            
                if self._size == 0 then
                    self._size = 11
                end
            
                self._size += 32
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end
            
                Options.Size = UDim2.fromOffset(241, self._size)
            
                local Label = Instance.new('TextLabel')
                Label.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextTransparency = 0.2
                Label.Text = settings.title or "Enter text"
                Label.Size = UDim2.new(0, 207, 0, 13)
                Label.AnchorPoint = Vector2.new(0, 0)
                Label.Position = UDim2.new(0, 0, 0, 0)
                Label.BackgroundTransparency = 1
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.BorderSizePixel = 0
                Label.Parent = Options
                Label.TextSize = 10;
                Label.LayoutOrder = LayoutOrderModule
            
                local Textbox = Instance.new('TextBox')
                Textbox.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Textbox.PlaceholderText = settings.placeholder or "Enter text..."
                Textbox.Text = Library._config._flags[settings.flag] or ""
                Textbox.Name = 'Textbox'
                Textbox.Size = UDim2.new(0, 207, 0, 15)
                Textbox.BorderSizePixel = 0
                Textbox.TextSize = 10
                Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.BackgroundTransparency = 0.9
                Textbox.ClearTextOnFocus = false
                Textbox.Parent = Options
                Textbox.LayoutOrder = LayoutOrderModule
            
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Textbox
            
                function TextboxManager:update_text(text: string)
                    self._text = text
                    Library._config._flags[settings.flag] = self._text
                    Config:save(game.GameId, Library._config)
                    settings.callback(self._text)
                end
            
                if Library:flag_type(settings.flag, 'string') then
                    TextboxManager:update_text(Library._config._flags[settings.flag])
                end
            
                Textbox.FocusLost:Connect(function()
                    if ModuleManager._locked then return end
                    TextboxManager:update_text(Textbox.Text)
                end)
            
                return TextboxManager
            end   

            function ModuleManager:create_checkbox(settings: any)
                LayoutOrderModule = LayoutOrderModule + 1
                local CheckboxManager = { _state = false }
            
                if self._size == 0 then
                    self._size = 11
                end
                self._size += 20
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end
                Options.Size = UDim2.fromOffset(241, self._size)
            
                local Checkbox = Instance.new("TextButton")
                Checkbox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Checkbox.TextColor3 = Color3.fromRGB(0, 0, 0)
                Checkbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Checkbox.Text = ""
                Checkbox.AutoButtonColor = false
                Checkbox.BackgroundTransparency = 1
                Checkbox.Name = "Checkbox"
                Checkbox.Size = UDim2.new(0, 207, 0, 15)
                Checkbox.BorderSizePixel = 0
                Checkbox.TextSize = 14
                Checkbox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Checkbox.Parent = Options
                Checkbox.LayoutOrder = LayoutOrderModule
            
                local TitleLabel = Instance.new("TextLabel")
                TitleLabel.Name = "TitleLabel"
                if SelectedLanguage == "th" then
                    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    TitleLabel.TextSize = 13
                else
                    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                    TitleLabel.TextSize = 11
                end
                TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TitleLabel.TextTransparency = 0.2
                TitleLabel.Text = settings.title or "Skibidi"
                TitleLabel.Size = UDim2.new(0, 142, 0, 13)
                TitleLabel.AnchorPoint = Vector2.new(0, 0.5)
                TitleLabel.Position = UDim2.new(0, 0, 0.5, 0)
                TitleLabel.BackgroundTransparency = 1
                TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                TitleLabel.Parent = Checkbox

                local KeybindBox = Instance.new("Frame")
                KeybindBox.Name = "KeybindBox"
                KeybindBox.Size = UDim2.fromOffset(14, 14)
                KeybindBox.Position = UDim2.new(1, -35, 0.5, 0)
                KeybindBox.AnchorPoint = Vector2.new(0, 0.5)
                KeybindBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBox.BorderSizePixel = 0
                KeybindBox.Parent = Checkbox
            
                local KeybindCorner = Instance.new("UICorner")
                KeybindCorner.CornerRadius = UDim.new(0, 6)
                KeybindCorner.Parent = KeybindBox
            
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.Name = "KeybindLabel"
                KeybindLabel.Size = UDim2.new(1, 0, 1, 0)
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
                KeybindLabel.TextScaled = false
                KeybindLabel.TextSize = 10
                KeybindLabel.Font = Enum.Font.SourceSans
                KeybindLabel.Text = Library._config._keybinds[settings.flag] 
                    and string.gsub(tostring(Library._config._keybinds[settings.flag]), "Enum.KeyCode.", "") 
                    or "..."
                KeybindLabel.Parent = KeybindBox
            
                local Box = Instance.new("Frame")
                Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Box.AnchorPoint = Vector2.new(1, 0.5)
                Box.BackgroundTransparency = 0.9
                Box.Position = UDim2.new(1, 0, 0.5, 0)
                Box.Name = "Box"
                Box.Size = UDim2.new(0, 15, 0, 15)
                Box.BorderSizePixel = 0
                Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Box.Parent = Checkbox
            
                local BoxCorner = Instance.new("UICorner")
                BoxCorner.CornerRadius = UDim.new(0, 6)
                BoxCorner.Parent = Box
            
                local Fill = Instance.new("Frame")
                Fill.AnchorPoint = Vector2.new(0.5, 0.5)
                Fill.BackgroundTransparency = 0.2
                Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
                Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Fill.Name = "Fill"
                Fill.BorderSizePixel = 0
                Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Fill.Parent = Box
            
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(0, 3)
                FillCorner.Parent = Fill
            
                function CheckboxManager:change_state(state: boolean)
                    self._state = state
                    if self._state then
                        TweenService:Create(Box, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 0.7
                        }):Play()
                        TweenService:Create(Fill, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(9, 9)
                        }):Play()
                    else
                        TweenService:Create(Box, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 0.9
                        }):Play()
                        TweenService:Create(Fill, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(0, 0)
                        }):Play()
                    end
                    Library._config._flags[settings.flag] = self._state
                    Config:save(game.GameId, Library._config)
                    settings.callback(self._state)
                end
            
                if Library:flag_type(settings.flag, "boolean") then
                    CheckboxManager:change_state(Library._config._flags[settings.flag])
                end
            
                Checkbox.MouseButton1Click:Connect(function()
                    if ModuleManager._locked then return end
                    CheckboxManager:change_state(not CheckboxManager._state)
                end)
            
                Checkbox.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    if input.UserInputType ~= Enum.UserInputType.MouseButton3 then return end
                    if Library._choosing_keybind then return end
            
                    Library._choosing_keybind = true
                    local chooseConnection
                    chooseConnection = UserInputService.InputBegan:Connect(function(keyInput, processed)
                        if ModuleManager._locked then return end
                        if processed then return end
                        if keyInput.UserInputType ~= Enum.UserInputType.Keyboard then return end
                        if keyInput.KeyCode == Enum.KeyCode.Unknown then return end
            
                        if keyInput.KeyCode == Enum.KeyCode.Backspace then
                            ModuleManager:scale_keybind(true)
                            Library._config._keybinds[settings.flag] = nil
                            Config:save(game.GameId, Library._config)
                            KeybindLabel.Text = "..."
                            if Connections[settings.flag .. "_keybind"] then
                                Connections[settings.flag .. "_keybind"]:Disconnect()
                                Connections[settings.flag .. "_keybind"] = nil
                            end
                            chooseConnection:Disconnect()
                            Library._choosing_keybind = false
                            return
                        end
            
                        chooseConnection:Disconnect()
                        Library._config._keybinds[settings.flag] = tostring(keyInput.KeyCode)
                        Config:save(game.GameId, Library._config)
                        if Connections[settings.flag .. "_keybind"] then
                            Connections[settings.flag .. "_keybind"]:Disconnect()
                            Connections[settings.flag .. "_keybind"] = nil
                        end
                        ModuleManager:connect_keybind()
                        ModuleManager:scale_keybind()
                        Library._choosing_keybind = false
            
                        local keybind_string = string.gsub(tostring(Library._config._keybinds[settings.flag]), "Enum.KeyCode.", "")
                        KeybindLabel.Text = keybind_string
                    end)
                end)
            
                local keyPressConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if ModuleManager._locked then return end
                    if gameProcessed then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        local storedKey = Library._config._keybinds[settings.flag]
                        if storedKey and tostring(input.KeyCode) == storedKey then
                            CheckboxManager:change_state(not CheckboxManager._state)
                        end
                    end
                end)
                Connections[settings.flag .. "_keypress"] = keyPressConnection
            
                return CheckboxManager
            end

            function ModuleManager:create_divider(settings: any)
                -- Layout order management
                LayoutOrderModule = LayoutOrderModule + 1;
            
                if self._size == 0 then
                    self._size = 11
                end
            
                self._size += 27
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                local dividerHeight = 1
                local dividerWidth = 207 -- Adjust this to fit your UI width
            
                -- Create the outer frame to control spacing above and below
                local OuterFrame = Instance.new('Frame')
                OuterFrame.Size = UDim2.new(0, dividerWidth, 0, 20) -- Height here controls spacing above and below
                OuterFrame.BackgroundTransparency = 1 -- Fully invisible
                OuterFrame.Name = 'OuterFrame'
                OuterFrame.Parent = Options
                OuterFrame.LayoutOrder = LayoutOrderModule

                if settings and settings.showtopic then
                    local TextLabel = Instance.new('TextLabel')
                    TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- 154, 182, 255
                    TextLabel.TextTransparency = 0
                    TextLabel.Text = settings.title
                    TextLabel.Size = UDim2.new(0, 153, 0, 13)
                    TextLabel.Position = UDim2.new(0.5, 0, 0.501, 0)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
                    TextLabel.BorderSizePixel = 0
                    TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.TextSize = 11
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.ZIndex = 3;
                    TextLabel.TextStrokeTransparency = 0;
                    TextLabel.Parent = OuterFrame
                end;
                
                if not settings or settings and not settings.disableline then
                    -- Create the inner divider frame that will be placed in the middle of the OuterFrame
                    local Divider = Instance.new('Frame')
                    Divider.Size = UDim2.new(1, 0, 0, dividerHeight)
                    Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White color
                    Divider.BorderSizePixel = 0
                    Divider.Name = 'Divider'
                    Divider.Parent = OuterFrame
                    Divider.ZIndex = 2;
                    Divider.Position = UDim2.new(0, 0, 0.5, -dividerHeight / 2) -- Center the divider vertically in the OuterFrame
                
                    -- Add a UIGradient to the divider for left and right transparency
                    local Gradient = Instance.new('UIGradient')
                    Gradient.Parent = Divider
                    Gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),  -- Start with white
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), -- Keep it white in the middle
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255, 0))  -- Fade to transparent on the right side
                    })
                    Gradient.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),   
                        NumberSequenceKeypoint.new(0.5, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    })
                    Gradient.Rotation = 0 -- Horizontal gradient (fade from left to right)
                
                    -- Optionally, you can add a corner radius for rounded ends
                    local UICorner = Instance.new('UICorner')
                    UICorner.CornerRadius = UDim.new(0, 2) -- Small corner radius for smooth edges
                    UICorner.Parent = Divider

                end;
            
                return true;
            end
            
            function ModuleManager:create_slider(settings: any)

                LayoutOrderModule = LayoutOrderModule + 1

                local SliderManager = {}

                if self._size == 0 then
                    self._size = 11
                end

                self._size += 27

                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                Options.Size = UDim2.fromOffset(241, self._size)

                local Slider = Instance.new('TextButton')
                Slider.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal);
                Slider.TextSize = 14;
                Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Slider.Text = ''
                Slider.AutoButtonColor = false
                Slider.BackgroundTransparency = 1
                Slider.Name = 'Slider'
                Slider.Size = UDim2.new(0, 207, 0, 22)
                Slider.BorderSizePixel = 0
                Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Slider.Parent = Options
                Slider.LayoutOrder = LayoutOrderModule
                
                local TextLabel = Instance.new('TextLabel')
                if GG.SelectedLanguage == "th" then
                    TextLabel.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                    TextLabel.TextSize = 13;
                else
                    TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                    TextLabel.TextSize = 11;
                end;
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextTransparency = 0.20000000298023224
                TextLabel.Text = settings.title
                TextLabel.Size = UDim2.new(0, 153, 0, 13)
                TextLabel.Position = UDim2.new(0, 0, 0.05000000074505806, 0)
                TextLabel.BackgroundTransparency = 1
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.BorderSizePixel = 0
                TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.Parent = Slider
                
                local Drag = Instance.new('Frame')
                Drag.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Drag.AnchorPoint = Vector2.new(0.5, 1)
                Drag.BackgroundTransparency = 0.8999999761581421
                Drag.Position = UDim2.new(0.5, 0, 0.949999988079071, 0)
                Drag.Name = 'Drag'
                Drag.Size = UDim2.new(0, 207, 0, 4)
                Drag.BorderSizePixel = 0
                Drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Drag.Parent = Slider
                
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(1, 0)
                UICorner.Parent = Drag
                
                local Fill = Instance.new('Frame')
                Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Fill.AnchorPoint = Vector2.new(0, 0.5)
                Fill.BackgroundTransparency = 0.5
                Fill.Position = UDim2.new(0, 0, 0.5, 0)
                Fill.Name = 'Fill'
                Fill.Size = UDim2.new(0, 103, 0, 4)
                Fill.BorderSizePixel = 0
                Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Fill.Parent = Drag
                
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(0, 3)
                UICorner.Parent = Fill
                
                local UIGradient = Instance.new('UIGradient')
                UIGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 79, 79))
                }
                UIGradient.Parent = Fill
                
                local Circle = Instance.new('Frame')
                Circle.AnchorPoint = Vector2.new(1, 0.5)
                Circle.Name = 'Circle'
                Circle.Position = UDim2.new(1, 0, 0.5, 0)
                Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Circle.Size = UDim2.new(0, 6, 0, 6)
                Circle.BorderSizePixel = 0
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.Parent = Fill
                
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(1, 0)
                UICorner.Parent = Circle
                
                local Value = Instance.new('TextLabel')
                Value.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Value.TextTransparency = 0.20000000298023224
                Value.Text = '50'
                Value.Name = 'Value'
                Value.Size = UDim2.new(0, 42, 0, 13)
                Value.AnchorPoint = Vector2.new(1, 0)
                Value.Position = UDim2.new(1, 0, 0, 0)
                Value.BackgroundTransparency = 1
                Value.TextXAlignment = Enum.TextXAlignment.Right
                Value.BorderSizePixel = 0
                Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Value.TextSize = 10
                Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Value.Parent = Slider

                function SliderManager:set_percentage(percentage: number)
                    local rounded_number = 0

                    if settings.round_number then
                        rounded_number = math.floor(percentage)
                    else
                        rounded_number = math.floor(percentage * 10) / 10
                    end

                    percentage = (percentage - settings.minimum_value) / (settings.maximum_value - settings.minimum_value)
                    
                    local slider_size = math.clamp(percentage, 0.02, 1) * Drag.Size.X.Offset
                    local number_threshold = math.clamp(rounded_number, settings.minimum_value, settings.maximum_value)
    
                    Library._config._flags[settings.flag] = number_threshold
                    Value.Text = number_threshold
    
                    TweenService:Create(Fill, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.fromOffset(slider_size, Drag.Size.Y.Offset)
                    }):Play()
    
                    settings.callback(number_threshold)
                end

                function SliderManager:update()
                    local mouse_position = (mouse.X - Drag.AbsolutePosition.X) / Drag.Size.X.Offset
                    local percentage = settings.minimum_value + (settings.maximum_value - settings.minimum_value) * mouse_position

                    self:set_percentage(percentage)
                end

                function SliderManager:input()
                    SliderManager:update()
    
                    Connections['slider_drag_'..settings.flag] = mouse.Move:Connect(function()
                        SliderManager:update()
                    end)
                    
                    Connections['slider_input_'..settings.flag] = UserInputService.InputEnded:Connect(function(input: InputObject, process: boolean)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
                            return
                        end
    
                        Connections:disconnect('slider_drag_'..settings.flag)
                        Connections:disconnect('slider_input_'..settings.flag)

                        if not settings.ignoresaved then
                            Config:save(game.GameId, Library._config);
                        end;
                    end)
                end


                if Library:flag_type(settings.flag, 'number') then
                    if not settings.ignoresaved then
                        SliderManager:set_percentage(Library._config._flags[settings.flag]);
                    else
                        SliderManager:set_percentage(settings.value);
                    end;
                else
                    SliderManager:set_percentage(settings.value);
                end;
    
                Slider.MouseButton1Down:Connect(function()
                if ModuleManager._locked then return end
                    SliderManager:input()
                end)

                function SliderManager:SetVisible(state: boolean)
                    Slider.Visible = state
                end

                return SliderManager
            end

            function ModuleManager:create_dual_slider(settings: any)
                LayoutOrderModule = LayoutOrderModule + 1
                local SliderManager = { _min = settings.minimum_value, _max = settings.maximum_value }
                if Library._config._flags[settings.flag] then
                    local saved = Library._config._flags[settings.flag]
                    if type(saved) == "table" and #saved >= 2 then
                        SliderManager._min = saved[1]
                        SliderManager._max = saved[2]
                    end
                end

                if self._size == 0 then self._size = 11 end
                self._size += 27
                if ModuleManager._state then Module.Size = UDim2.fromOffset(241, 93 + self._size) end
                Options.Size = UDim2.fromOffset(241, self._size)

                local Slider = Instance.new('TextButton')
                Slider.Text = ''
                Slider.AutoButtonColor = false
                Slider.BackgroundTransparency = 1
                Slider.Name = 'DualSlider'
                Slider.Size = UDim2.new(0, 207, 0, 22)
                Slider.BorderSizePixel = 0
                Slider.Parent = Options
                Slider.LayoutOrder = LayoutOrderModule
                
                local TextLabel = Instance.new('TextLabel')
                TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextTransparency = 0.2
                TextLabel.Text = settings.title
                TextLabel.Size = UDim2.new(0, 153, 0, 13)
                TextLabel.Position = UDim2.new(0, 0, 0.05, 0)
                TextLabel.BackgroundTransparency = 1
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.TextSize = 11
                TextLabel.Parent = Slider
                
                local Drag = Instance.new('Frame')
                Drag.AnchorPoint = Vector2.new(0.5, 1)
                Drag.BackgroundTransparency = 0.9
                Drag.Position = UDim2.new(0.5, 0, 0.95, 0)
                Drag.Name = 'Drag'
                Drag.Size = UDim2.new(0, 207, 0, 4)
                Drag.BorderSizePixel = 0
                Drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Drag.Parent = Slider
                
                local Fill = Instance.new('Frame')
                Fill.AnchorPoint = Vector2.new(0, 0.5)
                Fill.BackgroundTransparency = 0.5
                Fill.Position = UDim2.new(0, 0, 0.5, 0)
                Fill.Name = 'Fill'
                Fill.Size = UDim2.new(0, 0, 0, 4)
                Fill.BorderSizePixel = 0
                Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Fill.Parent = Drag
                
                local MinCircle = Instance.new('Frame')
                MinCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                MinCircle.Position = UDim2.new(0, 0, 0.5, 0)
                MinCircle.Size = UDim2.new(0, 6, 0, 6)
                MinCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinCircle.Parent = Drag
                Instance.new("UICorner", MinCircle).CornerRadius = UDim.new(1, 0)
                
                local MaxCircle = Instance.new('Frame')
                MaxCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                MaxCircle.Position = UDim2.new(1, 0, 0.5, 0)
                MaxCircle.Size = UDim2.new(0, 6, 0, 6)
                MaxCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MaxCircle.Parent = Drag
                Instance.new("UICorner", MaxCircle).CornerRadius = UDim.new(1, 0)
                
                local Value = Instance.new('TextLabel')
                Value.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Value.Text = '0 - 100'
                Value.Size = UDim2.new(0, 80, 0, 13)
                Value.AnchorPoint = Vector2.new(1, 0)
                Value.Position = UDim2.new(1, 0, 0, 0)
                Value.BackgroundTransparency = 1
                Value.TextXAlignment = Enum.TextXAlignment.Right
                Value.TextSize = 10
                Value.Parent = Slider

                function SliderManager:update_visuals()
                    local range = settings.maximum_value - settings.minimum_value
                    local minP = (self._min - settings.minimum_value) / range
                    local maxP = (self._max - settings.minimum_value) / range
                    
                    Fill.Position = UDim2.new(minP, 0, 0.5, 0)
                    Fill.Size = UDim2.new(maxP - minP, 0, 1, 0)
                    MinCircle.Position = UDim2.new(minP, 0, 0.5, 0)
                    MaxCircle.Position = UDim2.new(maxP, 0, 0.5, 0)
                    
                    local minV = settings.round_number and math.floor(self._min) or math.floor(self._min * 10) / 10
                    local maxV = settings.round_number and math.floor(self._max) or math.floor(self._max * 10) / 10
                    Value.Text = string.format("%s - %s%s", tostring(minV), tostring(maxV), settings.suffix or "")
                    
                    Library._config._flags[settings.flag] = {minV, maxV}
                    settings.callback({minV, maxV})
                end

                function SliderManager:input(isMin)
                    local connection
                    connection = mouse.Move:Connect(function()
                        local mouse_position = math.clamp((mouse.X - Drag.AbsolutePosition.X) / Drag.Size.X.Offset, 0, 1)
                        local val = settings.minimum_value + (settings.maximum_value - settings.minimum_value) * mouse_position
                        
                        if isMin then
                            self._min = math.clamp(val, settings.minimum_value, self._max)
                        else
                            self._max = math.clamp(val, self._min, settings.maximum_value)
                        end
                        self:update_visuals()
                        -- Fire callback live during drag so script-side AccuracyMin/Max
                        -- update in real-time. Previously only update_visuals fired,
                        -- meaning the runtime values stayed at whatever was loaded -
                        -- effectively only the max ever mattered for the random roll.
                        if settings.callback then
                            pcall(settings.callback, {self._min, self._max})
                        end
                    end)
                    
                    Connections['dual_input_'..settings.flag] = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                        connection:Disconnect()
                        Connections:disconnect('dual_input_'..settings.flag)
                        Config:save(game.GameId, Library._config)
                    end)
                end

                Slider.MouseButton1Down:Connect(function()
                if ModuleManager._locked then return end
                    local mouse_position = math.clamp((mouse.X - Drag.AbsolutePosition.X) / Drag.Size.X.Offset, 0, 1)
                    local val = settings.minimum_value + (settings.maximum_value - settings.minimum_value) * mouse_position
                    local distMin = math.abs(val - SliderManager._min)
                    local distMax = math.abs(val - SliderManager._max)
                    SliderManager:input(distMin < distMax)
                end)

                if Library._config._flags[settings.flag] then
                    local saved = Library._config._flags[settings.flag]
                    if type(saved) == "table" then
                        SliderManager._min, SliderManager._max = (table.unpack or unpack)(saved)
                    else
                        SliderManager._min, SliderManager._max = settings.min_value, settings.max_value
                    end
                else
                    SliderManager._min, SliderManager._max = settings.min_value, settings.max_value
                end
                SliderManager:update_visuals()
                if settings.callback then
                    settings.callback({SliderManager._min, SliderManager._max})
                end

                function SliderManager:SetVisible(state: boolean)
                    Slider.Visible = state
                end

                return SliderManager
            end

            function ModuleManager:create_dropdown(settings: any)

                if not settings.Order then
                    LayoutOrderModule = LayoutOrderModule + 1;
                end;

                local DropdownManager = {
                    _state = false,
                    _size = 0
                }

                if not settings.Order then
                    if self._size == 0 then
                        self._size = 11
                    end

                    self._size += 44
                end;

                if not settings.Order then
                    if ModuleManager._state then
                        Module.Size = UDim2.fromOffset(241, 93 + self._size)
                    end
                    Options.Size = UDim2.fromOffset(241, self._size)
                end

                local Dropdown = Instance.new('TextButton')
                Dropdown.FontFace = Font.new('rbxasset://fonts/families/SourceSansPro.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
                Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Dropdown.Text = ''
                Dropdown.AutoButtonColor = false
                Dropdown.BackgroundTransparency = 1
                Dropdown.Name = 'Dropdown'
                Dropdown.Size = UDim2.new(0, 207, 0, 39)
                Dropdown.BorderSizePixel = 0
                Dropdown.TextSize = 14
                Dropdown.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Dropdown.Parent = Options

                if not settings.Order then
                    Dropdown.LayoutOrder = LayoutOrderModule;
                else
                    Dropdown.LayoutOrder = settings.OrderValue;
                end;

                if not Library._config._flags[settings.flag] then
                    Library._config._flags[settings.flag] = {};
                end;
                
                local TextLabel = Instance.new('TextLabel')
                if GG.SelectedLanguage == "th" then
                    TextLabel.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                    TextLabel.TextSize = 13;
                else
                    TextLabel.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextLabel.TextSize = 11;
                end;
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextTransparency = 0.20000000298023224
                TextLabel.Text = settings.title
                TextLabel.Size = UDim2.new(0, 207, 0, 13)
                TextLabel.BackgroundTransparency = 1
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.BorderSizePixel = 0
                TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.Parent = Dropdown
                
                local Box = Instance.new('Frame')
                Box.ClipsDescendants = true
                Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Box.AnchorPoint = Vector2.new(0.5, 0)
                Box.BackgroundTransparency = 0.8999999761581421
                Box.Position = UDim2.new(0.5, 0, 1.2000000476837158, 0)
                Box.Name = 'Box'
                Box.Size = UDim2.new(0, 207, 0, 22)
                Box.BorderSizePixel = 0
                Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Box.Parent = TextLabel
                
                local UICorner = Instance.new('UICorner')
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = Box
                
                local Header = Instance.new('Frame')
                Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Header.AnchorPoint = Vector2.new(0.5, 0)
                Header.BackgroundTransparency = 1
                Header.Position = UDim2.new(0.5, 0, 0, 0)
                Header.Name = 'Header'
                Header.Size = UDim2.new(0, 207, 0, 22)
                Header.BorderSizePixel = 0
                Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Header.Parent = Box
                
                local CurrentOption = Instance.new('TextLabel')
                CurrentOption.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                CurrentOption.TextColor3 = Color3.fromRGB(255, 255, 255)
                CurrentOption.TextTransparency = 0.20000000298023224
                CurrentOption.Name = 'CurrentOption'
                CurrentOption.Size = UDim2.new(0, 161, 0, 13)
                CurrentOption.AnchorPoint = Vector2.new(0, 0.5)
                CurrentOption.Position = UDim2.new(0.04999988153576851, 0, 0.5, 0)
                CurrentOption.BackgroundTransparency = 1
                CurrentOption.TextXAlignment = Enum.TextXAlignment.Left
                CurrentOption.BorderSizePixel = 0
                CurrentOption.BorderColor3 = Color3.fromRGB(0, 0, 0)
                CurrentOption.TextSize = 10
                CurrentOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CurrentOption.Parent = Header
                local UIGradient = Instance.new('UIGradient')
                UIGradient.Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.704, 0),
                    NumberSequenceKeypoint.new(0.872, 0.36250001192092896),
                    NumberSequenceKeypoint.new(1, 1)
                }
                UIGradient.Parent = CurrentOption
                
                local Arrow = Instance.new('ImageLabel')
                Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Arrow.AnchorPoint = Vector2.new(0, 0.5)
                Arrow.Image = 'rbxassetid://84232453189324'
                Arrow.BackgroundTransparency = 1
                Arrow.Position = UDim2.new(0.9100000262260437, 0, 0.5, 0)
                Arrow.Name = 'Arrow'
                Arrow.Size = UDim2.new(0, 8, 0, 8)
                Arrow.BorderSizePixel = 0
                Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Arrow.Parent = Header
                
                local Options = Instance.new('ScrollingFrame')
                Options.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
                Options.Active = true
                Options.ScrollBarImageTransparency = 1
                Options.AutomaticCanvasSize = Enum.AutomaticSize.XY
                Options.ScrollBarThickness = 0
                Options.Name = 'Options'
                Options.Size = UDim2.new(0, 207, 0, 0)
                Options.BackgroundTransparency = 1
                Options.Position = UDim2.new(0, 0, 1, 0)
                Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Options.BorderSizePixel = 0
                Options.CanvasSize = UDim2.new(0, 0, 0.5, 0)
                Options.Parent = Box
                
                local UIListLayout = Instance.new('UIListLayout')
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Parent = Options
                
                local UIPadding = Instance.new('UIPadding')
                UIPadding.PaddingTop = UDim.new(0, -1)
                UIPadding.PaddingLeft = UDim.new(0, 10)
                UIPadding.Parent = Options
                
                local UIListLayout = Instance.new('UIListLayout')
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Parent = Box

                function DropdownManager:update(option: string)
                    -- If multi-dropdown is enabled
                    if settings.multi_dropdown then
                        -- Split the CurrentOption.Text by commas into a table

                        if not Library._config._flags[settings.flag] then
                            Library._config._flags[settings.flag] = {};
                        end;

                        local CurrentTargetValue = nil;
                        
                        if #Library._config._flags[settings.flag] > 0 then

                            CurrentTargetValue = convertTableToString(Library._config._flags[settings.flag]);

                        end;

                        local selected = {}

                        if CurrentTargetValue then
                            for value in string.gmatch(CurrentTargetValue, "([^,]+)") do
                                -- Trim spaces around the option using string.match
                                local trimmedValue = value:match("^%s*(.-)%s*$")  -- Trim leading and trailing spaces
                                
                                -- Exclude any unwanted labels (e.g. "Label")
                                if trimmedValue ~= "Label" then
                                    table.insert(selected, trimmedValue)
                                end
                            end
                        else
                            for value in string.gmatch(CurrentOption.Text, "([^,]+)") do
                                -- Trim spaces around the option using string.match
                                local trimmedValue = value:match("^%s*(.-)%s*$")  -- Trim leading and trailing spaces
                                
                                -- Exclude any unwanted labels (e.g. "Label")
                                if trimmedValue ~= "Label" then
                                    table.insert(selected, trimmedValue)
                                end
                            end
                        end;
                
                        local CurrentTextGet = convertStringToTable(CurrentOption.Text);

                        optionSkibidi = "nil";
                        if typeof(option) ~= 'string' then
                            optionSkibidi = option.Name;
                        else
                            optionSkibidi = option;
                        end;

                        local found = false
                        for i, v in pairs(CurrentTextGet) do
                            if v == optionSkibidi then
                                table.remove(CurrentTextGet, i);
                                break;
                            end
                        end

                        CurrentOption.Text = table.concat(selected, ", ")
                        local OptionsChild = {}
                        -- Update the transparent effect of each option
                        for _, object in Options:GetChildren() do
                            if object.Name == "Option" then
                                table.insert(OptionsChild, object.Text)
                                if table.find(selected, object.Text) then
                                    object.TextTransparency = 0.2
                                else
                                    object.TextTransparency = 0.6
                                end
                            end
                        end

                        CurrentTargetValue = convertStringToTable(CurrentOption.Text);

                        for _, v in CurrentTargetValue do
                            if not table.find(OptionsChild, v) and table.find(selected, v) then
                                table.remove(selected, _)
                            end;
                        end;

                        CurrentOption.Text = table.concat(selected, ", ");
                
                        Library._config._flags[settings.flag] = convertStringToTable(CurrentOption.Text);
                    else
                        -- For single dropdown, just set the CurrentOption.Text to the selected option
                        CurrentOption.Text = (typeof(option) == "string" and option) or option.Name
                        for _, object in Options:GetChildren() do
                            if object.Name == "Option" then
                                -- Only update transparency for actual option text buttons
                                if object.Text == CurrentOption.Text then
                                    object.TextTransparency = 0.2
                                else
                                    object.TextTransparency = 0.6
                                end
                            end
                        end
                        Library._config._flags[settings.flag] = option
                    end
                
                    -- Save the configuration state
                    Config:save(game.GameId, Library._config)
                
                    -- Callback with the updated option(s)
                    settings.callback(option)
                end
                
                local CurrentDropSizeState = 0;

                function DropdownManager:unfold_settings()
                    self._state = not self._state

                    if self._state then
                        ModuleManager._multiplier += self._size

                        CurrentDropSizeState = self._size;

                        TweenService:Create(Module, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(241, 93 + ModuleManager._size + ModuleManager._multiplier)
                        }):Play()

                        TweenService:Create(Module.Options, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(241, ModuleManager._size + ModuleManager._multiplier)
                        }):Play()

                        TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(207, 39 + self._size)
                        }):Play()

                        TweenService:Create(Box, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(207, 22 + self._size)
                        }):Play()

                        TweenService:Create(Arrow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Rotation = 180
                        }):Play()
                    else
                        ModuleManager._multiplier -= self._size

                        CurrentDropSizeState = 0;

                        TweenService:Create(Module, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(241, 93 + ModuleManager._size + ModuleManager._multiplier)
                        }):Play()

                        TweenService:Create(Module.Options, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(241, ModuleManager._size + ModuleManager._multiplier)
                        }):Play()

                        TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(207, 39)
                        }):Play()

                        TweenService:Create(Box, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(207, 22)
                        }):Play()

                        TweenService:Create(Arrow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Rotation = 0
                        }):Play()
                    end
                end

                if #settings.options > 0 then
                    DropdownManager._size = 3

                    for index, value in settings.options do
                        local Option = Instance.new('TextButton')
                        Option.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                        Option.Active = false
                        Option.TextTransparency = 0.6000000238418579
                        Option.AnchorPoint = Vector2.new(0, 0.5)
                        Option.TextSize = 10
                        Option.Size = UDim2.new(0, 186, 0, 16)
                        Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Option.Text = (typeof(value) == "string" and value) or value.Name;
                        Option.AutoButtonColor = false
                        Option.Name = 'Option'
                        Option.BackgroundTransparency = 1
                        Option.TextXAlignment = Enum.TextXAlignment.Left
                        Option.Selectable = false
                        Option.Position = UDim2.new(0.04999988153576851, 0, 0.34210526943206787, 0)
                        Option.BorderSizePixel = 0
                        Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Option.Parent = Options
                        
                        local UIGradient = Instance.new('UIGradient')
                        UIGradient.Transparency = NumberSequence.new{
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(0.704, 0),
                            NumberSequenceKeypoint.new(0.872, 0.36250001192092896),
                            NumberSequenceKeypoint.new(1, 1)
                        }
                        UIGradient.Parent = Option

                        Option.MouseButton1Click:Connect(function()
                    if ModuleManager._locked then return end
                            if not Library._config._flags[settings.flag] then
                                Library._config._flags[settings.flag] = {};
                            end;

                            if settings.multi_dropdown then
                                if table.find(Library._config._flags[settings.flag], value) then
                                    Library:remove_table_value(Library._config._flags[settings.flag], value)
                                else
                                    table.insert(Library._config._flags[settings.flag], value)
                                end
                            end

                            DropdownManager:update(value)
                        end)
    
                        if index > settings.maximum_options then
                            continue
                        end
    
                        DropdownManager._size += 16
                        Options.Size = UDim2.fromOffset(207, DropdownManager._size)
                    end
                end

                function DropdownManager:New(value)
                    Dropdown:Destroy(true);
                    value.OrderValue = Dropdown.LayoutOrder
                    ModuleManager._multiplier -= CurrentDropSizeState
                    return ModuleManager:create_dropdown(value)
                end;

                if Library:flag_type(settings.flag, 'string') then
                    DropdownManager:update(Library._config._flags[settings.flag])
                else
                    DropdownManager:update(settings.options[1])
                end
    
                Dropdown.MouseButton1Click:Connect(function()
                    if ModuleManager._locked then return end
                    DropdownManager:unfold_settings()
                end)

                return DropdownManager
            end

            function ModuleManager:create_feature(settings)

                local checked = false;
                
                LayoutOrderModule = LayoutOrderModule + 1
            
                if self._size == 0 then
                    self._size = 11
                end
            
                self._size += 20
            
                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size);
                end
            
                Options.Size = UDim2.fromOffset(241, self._size);
            
                local FeatureContainer = Instance.new("Frame")
                FeatureContainer.Size = UDim2.new(0, 207, 0, 16)
                FeatureContainer.BackgroundTransparency = 1
                FeatureContainer.Parent = Options
                FeatureContainer.LayoutOrder = LayoutOrderModule
            
                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Parent = FeatureContainer
            
                local FeatureButton = Instance.new("TextButton")
                FeatureButton.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                FeatureButton.TextSize = 11;
                FeatureButton.Size = UDim2.new(1, -35, 0, 16)
                FeatureButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                FeatureButton.TextColor3 = Color3.fromRGB(210, 210, 210)
                FeatureButton.Text = "    " .. settings.title or "    " .. "Feature"
                FeatureButton.AutoButtonColor = false
                FeatureButton.TextXAlignment = Enum.TextXAlignment.Left
                FeatureButton.TextTransparency = 0.2
                FeatureButton.Parent = FeatureContainer
            
                local RightContainer = Instance.new("Frame")
                RightContainer.Size = UDim2.new(0, 45, 0, 16)
                RightContainer.BackgroundTransparency = 1
                RightContainer.Parent = FeatureContainer
            
                local RightLayout = Instance.new("UIListLayout")
                RightLayout.Padding = UDim.new(0.1, 0)
                RightLayout.FillDirection = Enum.FillDirection.Horizontal
                RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
                RightLayout.Parent = RightContainer
            
                local KeybindBox = Instance.new("TextLabel")
                KeybindBox.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                KeybindBox.Size = UDim2.new(0, 15, 0, 15)
                KeybindBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBox.TextSize = 11
                KeybindBox.BackgroundTransparency = 1
                KeybindBox.LayoutOrder = 2;
                KeybindBox.Parent = RightContainer
            
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Size = UDim2.new(1, 0, 1, 0)
                KeybindButton.BackgroundTransparency = 1
                KeybindButton.TextTransparency = 1
                KeybindButton.Parent = KeybindBox

                local CheckboxCorner = Instance.new("UICorner", KeybindBox)
                CheckboxCorner.CornerRadius = UDim.new(0, 3)

                local UIStroke = Instance.new("UIStroke", KeybindBox)
                UIStroke.Color = Color3.fromRGB(255, 255, 255)
                UIStroke.Thickness = 1
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            
                if not Library._config._flags then
                    Library._config._flags = {}
                end
            
                if not Library._config._flags[settings.flag] then
                    Library._config._flags[settings.flag] = {
                        checked = false,
                        BIND = settings.default or "Unknown"
                    }
                end
            
                checked = Library._config._flags[settings.flag].checked
                KeybindBox.Text = Library._config._flags[settings.flag].BIND

                if KeybindBox.Text == "Unknown" then
                    KeybindBox.Text = "...";
                end;

                local UseF_Var = nil;
            
                if not settings.disablecheck then
                    local Checkbox = Instance.new("TextButton")
                    Checkbox.Size = UDim2.new(0, 15, 0, 15)
                    Checkbox.BackgroundColor3 = checked and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
                    Checkbox.Text = ""
                    Checkbox.Parent = RightContainer
                    Checkbox.LayoutOrder = 1;

                    local UIStroke = Instance.new("UIStroke", Checkbox)
                    UIStroke.Color = Color3.fromRGB(255, 255, 255)
                    UIStroke.Thickness = 1
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                
                    local CheckboxCorner = Instance.new("UICorner")
                    CheckboxCorner.CornerRadius = UDim.new(0, 3)
                    CheckboxCorner.Parent = Checkbox
            
                    local function toggleState()
                        checked = not checked
                        Checkbox.BackgroundColor3 = checked and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
                        Library._config._flags[settings.flag].checked = checked
                        Config:save(game.GameId, Library._config)
                        if settings.callback then
                            settings.callback(checked)
                        end
                    end

                    UseF_Var = toggleState
                
                    Checkbox.MouseButton1Click:Connect(toggleState)

                else

                    UseF_Var = function()
                        settings.button_callback();
                    end;

                end;
            
                KeybindButton.MouseButton1Click:Connect(function()
                    KeybindBox.Text = "..."
                    local inputConnection
                    inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
                        if gameProcessed then return end
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local newKey = input.KeyCode.Name
                            Library._config._flags[settings.flag].BIND = newKey
                            if newKey ~= "Unknown" then
                                KeybindBox.Text = newKey;
                            end;
                            Config:save(game.GameId, Library._config) -- Save new keybind
                            inputConnection:Disconnect()
                        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                            Library._config._flags[settings.flag].BIND = "Unknown"
                            KeybindBox.Text = "..."
                            Config:save(game.GameId, Library._config)
                            inputConnection:Disconnect()
                        end
                    end)
                    Connections["keybind_input_" .. settings.flag] = inputConnection
                end)
            
                local keyPressConnection
                keyPressConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode.Name == Library._config._flags[settings.flag].BIND then
                            UseF_Var();
                        end
                    end
                end)
                Connections["keybind_press_" .. settings.flag] = keyPressConnection
            
                FeatureButton.MouseButton1Click:Connect(function()
                    if settings.button_callback then
                        settings.button_callback()
                    end
                end)

                if not settings.disablecheck then
                    settings.callback(checked);
                end;
            
                return FeatureContainer
            end                    

            return ModuleManager
        end

        return TabManager
    end

    Connections['library_visiblity'] = UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
        if input.KeyCode ~= Enum.KeyCode.Insert then
            return
        end

        self._ui_open = not self._ui_open
        self:change_visiblity(self._ui_open)
    end)

    self._ui.Container.Handler.Minimize.MouseButton1Click:Connect(function()
        self._ui_open = not self._ui_open
        self:change_visiblity(self._ui_open)
    end)

    return self
end

local main = Library.new()

local rage = main:create_tab('Combat', 'rbxassetid://76499042599127')
local detectionstab = main:create_tab('Detection', 'rbxassetid://10734951847')
local visuals = main:create_tab('Visuals', 'rbxassetid://10723346959')
local pl = main:create_tab('Player', 'rbxassetid://126017907477623')
local sw = main:create_tab('Sword', 'rbxassetid://75691853201877')
local av = main:create_tab('Avatar', 'rbxassetid://10885655986')

repeat task.wait() until game:IsLoaded()

local Players = cloneref(game:GetService('Players'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local RunService = cloneref(game:GetService('RunService'))
local TweenService = cloneref(game:GetService('TweenService'))
local Stats = cloneref(game:GetService('Stats'))
local Debris = cloneref(game:GetService('Debris'))
local CoreGui = cloneref(game:GetService('CoreGui'))

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

local Alive = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
local Runtime = workspace.Runtime

local System = {
    __properties = {
        __autoparry_enabled = false,
        __triggerbot_enabled = false,
        __manual_spam_enabled = false,
        __auto_spam_enabled = false,
        __play_animation = false,
        __curve_mode = 1,
        __accuracy = 50,
        __divisor_multiplier = 1.1,
        __parried = false,
        __training_parried = false,
        __spam_threshold = 1.5,
        __parries = 0,
        __parry_key = nil,
        __grab_animation = nil,
        __tornado_time = tick(),
        __first_parry_done = false,
        __connections = {},
        __reverted_remotes = {},
        __spam_accumulator = 0,
        __spam_rate = 9999,
        __infinity_active = false,
        __deathslash_active = false,
        __timehole_active = false,
        __slashesoffury_active = false,
        __slashesoffury_count = 0,
        __is_mobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled,
        __mobile_guis = {},
        __aerodynamic_time = tick(),
        __last_warping = tick(),
        __lerp_radians = 0,
        __curving_time = tick()
    },
    
    __config = {
        __curve_names = {'Camera', 'Random', 'Accelerated', 'Backwards', 'Slow', 'High'},
        __detections = {
            __infinity = false,
            __deathslash = false,
            __timehole = false,
            __slashesoffury = false,
            __phantom = false
        }
    },
    
    __triggerbot = {
        __enabled = false,
        __is_parrying = false,
        __parries = 0,
        __max_parries = 10000,
        __parry_delay = 0.5
    }
}

local originalMetatables = {}

System.ball = {}

function System.ball.get()
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return nil end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            return ball
        end
    end
    return nil
end

function System.ball.get_all()
    local balls_table = {}
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return balls_table end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            ball.CanCollide = false
            table.insert(balls_table, ball)
        end
    end
    return balls_table
end

System.player = {}

local Closest_Entity = nil

function System.player.get_closest()
    local max_distance = math.huge
    local closest_entity = nil
    
    if not Alive then return nil end
    
    for _, entity in pairs(Alive:GetChildren()) do
        if entity ~= LocalPlayer.Character then
            if entity.PrimaryPart then
                local distance = LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
                if distance < max_distance then
                    max_distance = distance
                    closest_entity = entity
                end
            end
        end
    end
    
    Closest_Entity = closest_entity
    return closest_entity
end

function System.player.get_closest_to_cursor()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
        return nil
    end
    
    local closest_player = nil
    local minimal_dot = -math.huge
    local camera = workspace.CurrentCamera
    
    for _, player in pairs(Alive:GetChildren()) do
        if player ~= LocalPlayer.Character then
            if player:FindFirstChild('HumanoidRootPart') then
                local direction = (player.HumanoidRootPart.Position - camera.CFrame.Position).Unit
                local dot = camera.CFrame.LookVector:Dot(direction)
                
                if dot > minimal_dot then
                    minimal_dot = dot
                    closest_player = player
                end
            end
        end
    end
    
    return closest_player
end
local Parry_Key = nil
local PF = nil
local SC = nil

if ReplicatedStorage:FindFirstChild("Controllers") then
    for _, child in ipairs(ReplicatedStorage.Controllers:GetChildren()) do
        if child.Name:match("^SwordsController%s*$") then
            SC = child
        end
    end
end

if LocalPlayer.PlayerGui:FindFirstChild("Hotbar") and LocalPlayer.PlayerGui.Hotbar:FindFirstChild("Block") then
    for _, v in next, getconnections(LocalPlayer.PlayerGui.Hotbar.Block.Activated) do
        if SC and getfenv(v.Function).script == SC then
            PF = v.Function
            break
        end
    end
end

local function linear_predict(x, y, z)
    return x + (y - x) * z
end

local AccuracyMin = 100
local AccuracyMax = 100
local HumanizerEnabled = false

local VirtualInputManager = game:GetService("VirtualInputManager")

local HookSystem = {}
HookSystem.ParryRemotes = {}
-- Once we've captured the parry remotes, the hook can stop doing work.
-- Without this, EVERY remote FireServer call (including yours from legit
-- clicks) runs through pcall + IsA + table write. Condemned doesn't have
-- this hook at all (uses PRY method), which is why it's smooth on legit
-- clicks and Ailon wasn't.
HookSystem.CaptureComplete = false
HookSystem.RemoteCount = 0

local oldIndex

--// Hook setup
function HookSystem.Init()
    if typeof(hookmetamethod) ~= "function" then
        warn("hookmetamethod not supported, falling back to VIM only")
        return
    end

    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
        -- FAST PATH 1: capture already complete - bail with zero work.
        -- This is the hot path for every CFrame/Position/Parent/etc read
        -- in the entire game. Must be as cheap as possible.
        if HookSystem.CaptureComplete then
            return oldIndex(self, key)
        end
        
        -- FAST PATH 2: not a FireServer/InvokeServer access
        if key ~= "FireServer" and key ~= "InvokeServer" then
            return oldIndex(self, key)
        end
        
        -- FAST PATH 3: our own call
        if checkcaller() then
            return oldIndex(self, key)
        end
        
        -- SLOW PATH (only runs during capture phase, ~3 captures total)
        local isRemote = false
        local ok, result = pcall(function()
            if key == "FireServer" then
                return self:IsA("RemoteEvent")
            else
                return self:IsA("RemoteFunction")
            end
        end)
        if ok then isRemote = result end
        
        if not isRemote then
            return oldIndex(self, key)
        end
        
        return function(_, ...)
            local args = { ... }

            -- Detect valid parry remote pattern
            if #args == 7 
            and type(args[2]) == "string" 
            and type(args[3]) == "number" then
                if not HookSystem.ParryRemotes[self] then
                    HookSystem.RemoteCount = HookSystem.RemoteCount + 1
                end
                HookSystem.ParryRemotes[self] = args
                
                -- Blade Ball fires 3 parry remotes per parry. Once we've
                -- seen all 3, the hook is done - flip CaptureComplete so
                -- subsequent calls take the fast path with zero per-call
                -- overhead. This is what makes legit clicks smooth.
                if HookSystem.RemoteCount >= 3 then
                    HookSystem.CaptureComplete = true
                end
            end

            return oldIndex(self, key)(_, unpack(args))
        end
    end))
end

--// Execute parry using captured remotes or fallback
-- event_data is updated every frame so parry calls never block computing it
local _cachedEventData = {}
local _cachedAimTarget = {0, 0}
RunService.RenderStepped:Connect(function()
    local camera   = workspace.CurrentCamera
    local viewport = camera.ViewportSize
    local ok, mp   = pcall(UserInputService.GetMouseLocation, UserInputService)
    _cachedAimTarget = ok and {mp.X, mp.Y} or {viewport.X / 2, viewport.Y / 2}
    if System.__properties.__is_mobile then
        _cachedAimTarget = {viewport.X / 2, viewport.Y / 2}
    end
    if Alive then
        local data = {}
        for _, entity in pairs(Alive:GetChildren()) do
            local pp = entity.PrimaryPart
            if pp then
                local ok2, sp = pcall(camera.WorldToScreenPoint, camera, pp.Position)
                if ok2 then data[entity.Name] = sp end
            end
        end
        _cachedEventData = data
    end
end)

function HookSystem.Parry()
    if next(HookSystem.ParryRemotes) then
        local curve_cframe = System.curve.get_cframe()

        for remote, originalArgs in pairs(HookSystem.ParryRemotes) do
            local modifiedArgs = {
                originalArgs[1],
                originalArgs[2],
                0,
                curve_cframe,
                _cachedEventData,
                _cachedAimTarget,
                originalArgs[7] or false
            }
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(unpack(modifiedArgs))
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(unpack(modifiedArgs))
                end
            end)
        end
    else
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

HookSystem.Init()

local lastAnimationPlayTime = 0
local lastSpamAnimationPlayTime = 0
local animationDelayBypass = false
local AnimationRegistry = {}
local SpamAnimationCounter = 0
local AnimationSpamMode = false

local function StopAnimationTrack(animTrack)
    local fadeOutDuration = animTrack:GetAttribute("StopFadeTime")
    animTrack:Stop(fadeOutDuration)
end

local function PlayAnimationWithAttributes(animTrack)
    local fadeInDuration = animTrack:GetAttribute("PlayFadeTime")
    local weightPriority = animTrack:GetAttribute("PlayWeight")
    local playbackSpeed = animTrack:GetAttribute("PlaySpeed")
    animTrack:Play(fadeInDuration, weightPriority, playbackSpeed)
end

System.animation = {}

function System.animation.resolve_parry_animation()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local equippedWeapon = character:GetAttribute("CurrentlyEquippedSword")
    if not equippedWeapon then 
        return ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
    end
    
    if AnimationRegistry[equippedWeapon] then
        return AnimationRegistry[equippedWeapon]
    end
    
    local weaponDataSuccess, weaponData = pcall(function()
        return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(equippedWeapon)
    end)
    
    if not weaponDataSuccess or not weaponData or type(weaponData) ~= "table" then
        AnimationRegistry[equippedWeapon] = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
        return AnimationRegistry[equippedWeapon]
    end
    
    if not weaponData.AnimationType or type(weaponData.AnimationType) ~= "string" then
        AnimationRegistry[equippedWeapon] = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
        return AnimationRegistry[equippedWeapon]
    end
    
    local collectionFolder = ReplicatedStorage.Shared.SwordAPI.Collection
    for _, weaponStyle in pairs(collectionFolder:GetChildren()) do
        if weaponStyle.Name == weaponData.AnimationType then
            local targetAnimation = weaponStyle:FindFirstChild("GrabParry") or weaponStyle:FindFirstChild("Grab")
            if targetAnimation then
                AnimationRegistry[equippedWeapon] = targetAnimation
                return targetAnimation
            end
        end
    end
    
    AnimationRegistry[equippedWeapon] = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
    return AnimationRegistry[equippedWeapon]
end

function System.animation.play_grab_parry(force)
    if not force and not System.__properties.__play_animation then return end

    local character = LocalPlayer.Character
    local humanoid  = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return end

    local targetAnimation = System.animation.resolve_parry_animation()
    if not targetAnimation then
        targetAnimation = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
        if not targetAnimation then return end
    end

    -- Stop any competing tracks cleanly so the grab animation
    -- isn't suppressed by a higher-priority playing track.
    for _, playingTrack in pairs(animator:GetPlayingAnimationTracks()) do
        local name = playingTrack.Name
        if name == "GrabParry" or name == "Grab" then
            -- In spam/clash mode restart from frame 0 for responsiveness.
            -- Otherwise let it finish naturally (don't restart mid-animation).
            if AnimationSpamMode then
                playingTrack.TimePosition = 0
            end
            StopAnimationTrack(playingTrack)
        elseif name == "SuccessParry" or name == "Success" then
            StopAnimationTrack(playingTrack)
        end
    end

    -- Load and play. LoadAnimation returns a cached track if already loaded,
    -- so repeated calls don't allocate new tracks.
    local animTrack = animator:LoadAnimation(targetAnimation)
    -- Ensure the track plays from the beginning every time so the full
    -- grab animation is visible rather than snapping to a mid-point.
    animTrack.TimePosition = 0
    PlayAnimationWithAttributes(animTrack)
end

function System.animation.spam_sequence()
    if (os.clock() - lastAnimationPlayTime) >= (1/90) then
        lastAnimationPlayTime = os.clock()
        
        -- Build-up gate: starts at 0.1s (10Hz) and accelerates as clash intensity increases
        local gate = 0.1
        if SpamAnimationCounter >= 4 then
            gate = 1/60 -- Full speed (clash)
        elseif SpamAnimationCounter >= 2 then
            gate = 0.05 -- Mid speed
        end
        
        if (os.clock() - lastSpamAnimationPlayTime) >= gate or animationDelayBypass then
            lastSpamAnimationPlayTime = os.clock()
            animationDelayBypass = false
            System.animation.play_grab_parry(true)
        end
    end
end

-- Always-on heartbeat to keep AnimationSpamMode synced with counter.
-- Previously this only updated inside the AP loop, so when AP was disabled
-- OR bailed early, AnimationSpamMode could stay stuck TRUE after a clash
-- ended. The counter decayed via task.delay but the derived flag didn't
-- refresh - so auto spam animations kept using the fast 1/60s gate even
-- after backing out of clash. Matches Condemned's approach.
local _lastAnimSpamMode = false
RunService.Heartbeat:Connect(function()
    local newMode = SpamAnimationCounter > 1
    if newMode ~= _lastAnimSpamMode then
        -- Transitioning out of spam mode: clear the timing context so the
        -- normal-rate gate (0.1s) takes effect immediately on the next
        -- spam_sequence call instead of being suppressed by stale timestamps.
        if not newMode then
            lastSpamAnimationPlayTime = 0
            lastAnimationPlayTime = 0
            animationDelayBypass = true
        end
        _lastAnimSpamMode = newMode
    end
    AnimationSpamMode = newMode
end)

-- System.ball table moved up.

-- Utilities cleaned up.

-- Duplicate block removed.

local BallHelper = {
    ball = {
        properties = System.__properties
    },
    get_ball = function() return System.ball.get() end,
    get_all = function() return System.ball.get_all() end,
    
    get_velocity = function(ball)
        local zoomies = ball:FindFirstChild("zoomies")
        return zoomies and zoomies.VectorVelocity or Vector3.new()
    end,
    
    get_distance = function(ball)
        if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return math.huge end
        return (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
    end,
    
    is_targeting_me = function(ball)
        return ball:GetAttribute("target") == LocalPlayer.Name
    end
}

-- ── Curve detector constants ─────────────────────────────────────────────────
local CURVE_ANGLE       = 0.09   -- cross magnitude threshold for lateral curves
local BACK_RANGE        = 200    -- backwards curve detection range
local CLOSE_RANGE       = 50     -- close-range enhanced detection zone
local SUPER_CLOSE_RANGE = 18     -- super-close zone: ball almost on top of us
local FRAME_TIME        = 1/60
local LERP_FACTOR       = 0.50   -- smoothing alpha for warp-guard angle lerp
local LERP_THRESHOLD    = 0.020  -- angle (rad) below which we stamp last_warping
local TI_WINDOW_DIVISOR = 1.20   -- skip window = TTI / this (capped at 0.55s)
local MIN_DISTANCE_ZERO = 0.001
local MIN_SPEED         = 1
local VEL_HISTORY_SIZE  = 6      -- velocity samples for angular-rate estimation

-- Cached ping updated every 0.1s
local cachedPingSec       = 0
local cachedPingThreshold = 0.45

task.spawn(function()
    local pingItem = Stats.Network.ServerStatsItem["Data Ping"]
    while true do
        local ms            = pingItem:GetValue()
        cachedPingSec       = ms / 1000
        cachedPingThreshold = math.clamp(0.38 + cachedPingSec * 0.25, 0.38, 0.58)
        task.wait(0.1)
    end
end)

-- Per-ball state: resets whenever the ball identity changes so stale
-- lerp/history from a previous ball never pollutes the next one.
local _curveState = {
    ballRef      = nil,   -- last seen ball instance
    lerp_radians = 0,
    last_warping = tick(),
    curving      = tick(),
    velHistory   = {},    -- {velUnit, time}
    lastVelUnit  = nil,   -- used to detect same-instance re-throws
}

local function _resetCurveState(ball, preserveSpawnTime)
    _curveState.ballRef      = ball
    _curveState.lerp_radians = 0
    _curveState.last_warping = tick()
    _curveState.curving      = tick()
    _curveState.velHistory   = {}
    -- FIX (bug 2): On a re-throw reset (same ball instance, direction flip from
    -- clash bounce), preserve ballSpawnTime so the age guards (ballAge > 0.10)
    -- still hold. Only zero it for genuinely new ball instances.
    if not preserveSpawnTime then
        _curveState.ballSpawnTime = tick()
    end
    _curveState.lastVelUnit  = nil
    if _debugEnabled then
        warn("[CurveDet:reset] " .. (preserveSpawnTime and "re-throw" or "new ball") .. " — state cleared")
    end
end

-- Debug log: only prints when enabled, throttled per message key
local _debugEnabled = false
local _debugThrottle = {}
local function _dbg(key, fmt, ...)
    if not _debugEnabled then return end
    local now = tick()
    if (now - (_debugThrottle[key] or 0)) < 0.20 then return end
    _debugThrottle[key] = now
    warn("[CurveDet:" .. key .. "] " .. string.format(fmt, ...))
end

-- Always fires on every detection hit with properly formatted output
local _lastHitWarn = 0
local function _ret(gate, fmt, ...)
    local msg = (fmt and select('#', ...) > 0) and string.format(fmt, ...) or (fmt or gate)
    local full = string.format("[CurveDet] %-18s | %s", gate, msg)
    if _debugEnabled then
        warn(full)
    else
        local n = tick()
        if (n - _lastHitWarn) >= 0.30 then
            _lastHitWarn = n
            warn(full)
        end
    end
    return true
end

BallHelper.curve_debug = function(enabled)
    _debugEnabled = enabled
    _debugThrottle = {}  -- clear throttle so first messages always fire
    warn("[CurveDet] debug logs " .. (enabled and "ENABLED" or "DISABLED"))
    if enabled then
        warn("[CurveDet] signals will appear in yellow. Call BallHelper.curve_debug(false) to stop.")
    end
end

-- Shared state table kept for legacy compat (external code may read .properties)
BallHelper.ball = {
    properties = {
        aerodynamic_time = tick(),
        last_warping     = tick(),
        lerp_radians     = 0,
        curving          = tick(),
    },
    velocity_history = {},
}

-- Returns true if the ball is curved/bait.
function BallHelper.ball_curved()
    local ball    = BallHelper.get_ball()
    if not ball then return false end
    local zoomies = ball:FindFirstChild("zoomies")
    if not zoomies then return false end
    local char    = LocalPlayer.Character
    if not char then return false end
    local hrp     = char.PrimaryPart
    if not hrp then return false end

    local velocity = zoomies.VectorVelocity
    local speed    = velocity.Magnitude
    if speed < MIN_SPEED then return false end

    local delta    = hrp.Position - ball.Position
    local distance = delta.Magnitude
    if distance < MIN_DISTANCE_ZERO then return false end

    -- Reset state when a new ball is detected
    if _curveState.ballRef ~= ball then
        _resetCurveState(ball)
    end

    -- Detect same-instance re-throw: if the ball direction flips sharply
    -- (dot < -0.5 vs last frame's unit vector) the game reused the object
    -- for a new throw — stale velHistory would corrupt angularRate otherwise.
    local velUnit = velocity * (1 / speed)
    if _curveState.lastVelUnit then
        local continuityDot = _curveState.lastVelUnit:Dot(velUnit)
        if continuityDot < -0.5 then
            if _debugEnabled then
                warn("[CurveDet:reset] same-ball re-throw detected (dot=" .. string.format("%.2f", continuityDot) .. ") — state cleared")
            end
            -- FIX (bug 2): Pass preserveSpawnTime=true so the age guards remain
            -- valid after a clash bounce re-throw; only clear velocity history.
            _resetCurveState(ball, true)
        end
    end
    _curveState.lastVelUnit = velUnit

    local toMe    = delta * (1 / distance)
    local pingSec = cachedPingSec

    local timeToImpact = math.max(distance / speed - pingSec, FRAME_TIME)
    local targeted     = ball:GetAttribute("target") == LocalPlayer.Name

    -- ── Signal 1: Alignment dot ───────────────────────────────────────────────
    -- 1.0 = ball heading straight at us, -1.0 = flying directly away
    local dot = toMe:Dot(velUnit)

    -- ── Signal 2: Predictive dot ──────────────────────────────────────────────
    -- Project forward by (ping*2 + small distance factor), capped at 0.45s.
    -- At close range we use a shorter lookahead so we don't over-project.
    local lookahead = distance < CLOSE_RANGE
        and math.clamp(pingSec * 1.5, 0.03, 0.15)
        or  math.clamp(pingSec * 2 + (distance / speed) * 0.08, pingSec * 2, 0.45)
    local futurePos   = ball.Position + velocity * lookahead
    local futureDelta = hrp.Position - futurePos
    local futureDist  = futureDelta.Magnitude
    local futureDot   = futureDist > MIN_DISTANCE_ZERO
        and (futureDelta * (1 / futureDist)):Dot(velUnit)
        or dot

    -- ── Signal 3: Lateral cross magnitude ────────────────────────────────────
    local cross = toMe:Cross(velUnit).Magnitude

    -- ── Signal 4: Angular velocity (velocity direction change rate) ───────────
    -- Measures how fast the ball's heading is rotating in rad/s.
    -- Uses a fixed-size ring-buffer per ball; stale entries (>0.4s) purged.
    local angularRate = 0
    local history = _curveState.velHistory
    local now = tick()
    table.insert(history, { v = velUnit, t = now })
    -- Purge old entries
    while #history > VEL_HISTORY_SIZE do table.remove(history, 1) end
    for i = #history, 1, -1 do
        if (now - history[i].t) > 0.40 then table.remove(history, i) end
    end
    if #history >= 2 then
        local oldest = history[1]
        local dt = now - oldest.t
        if dt > 0.001 then
            local cosA = math.clamp(oldest.v:Dot(velUnit), -1, 1)
            angularRate = math.acos(cosA) / dt  -- rad/s
        end
    end

    -- ── Signal 5: Predictive miss ─────────────────────────────────────────────
    -- Hitbox scales with ping*speed (reaction window) and distance (angle error).
    -- Close-range hitbox is deliberately tighter to reduce false positives.
    local hitbox
    if distance < SUPER_CLOSE_RANGE then
        hitbox = math.clamp(3 + pingSec * speed * 0.05, 3, 8)
    elseif distance < CLOSE_RANGE then
        hitbox = math.clamp(4 + pingSec * speed * 0.07 + distance * 0.02, 4, 14)
    else
        hitbox = math.clamp(4 + pingSec * speed * 0.08 + distance * 0.04, 4, 22)
    end
    local predictedPos = ball.Position + velocity * timeToImpact
    local missAmount   = (hrp.Position - predictedPos).Magnitude
    local willMiss     = missAmount > hitbox

    _dbg("signals",
        "dot=%.2f futureDot=%.2f cross=%.3f angRate=%.2f miss=%.1f/%.1f dist=%.1f spd=%.1f tgt=%s",
        dot, futureDot, cross, angularRate, missAmount, hitbox, distance, speed, tostring(targeted))

    -- Track how long this ball has been in flight so we don't fire soft gates
    -- on frame 1 when velocity/dot haven't settled yet.
    if not _curveState.ballSpawnTime then
        _curveState.ballSpawnTime = now
    end
    local ballAge = now - _curveState.ballSpawnTime  -- seconds since ball detected

    -- ══════════════════════════════════════════════════════════════════════════
    -- SUPER CLOSE RANGE  (distance < SUPER_CLOSE_RANGE)
    -- Ball is basically on top of us. Very aggressive detection for real players.
    -- ══════════════════════════════════════════════════════════════════════════
    if distance < SUPER_CLOSE_RANGE then
        -- High dot curve detection: ball coming straight but might curve
        -- Detects when dot is very high but futureDot drops significantly
        -- Removed age guard to detect curves even when player is moving
        if dot > 0.80 and (dot - futureDot) > 0.08 then
            return _ret("sc_high_dot", "dot=%.2f futDot=%.2f", dot, futureDot)
        end

        -- Left curve detection: dot product indicates leftward movement
        -- Use dot difference to detect direction changes
        -- Removed age guard to detect curves even when player is moving
        if (dot - futureDot) > 0.12 and dot < 0.75 then
            return _ret("sc_left_curve", "dotDiff=%.2f dot=%.2f", dot - futureDot, dot)
        end

        -- Right curve detection: dot product indicates rightward movement
        -- Use dot difference to detect direction changes
        -- Removed age guard to detect curves even when player is moving
        if (dot - futureDot) > 0.12 and dot < 0.75 then
            return _ret("sc_right_curve", "dotDiff=%.2f dot=%.2f", dot - futureDot, dot)
        end

        -- Hard backwards: clearly flying away + confirmed miss
        -- Relaxed threshold to detect hard back curves against real players
        -- Removed age guard to detect curves even when player is moving
        if dot < -0.05 and willMiss then
            return _ret("sc_back_hard", "dot=%.2f willMiss dist=%.1f", dot, distance)
        end
        -- Hard backwards without miss check (more aggressive for real players)
        if dot < -0.10 then
            return _ret("sc_back_hard_no_miss", "dot=%.2f dist=%.1f", dot, distance)
        end
        -- Lateral curve: dot difference indicates off-axis movement
        -- Removed age guard for super close range to detect curves immediately
        if (dot - futureDot) > 0.10 and dot < 0.60 then
            return _ret("sc_lateral", "dotDiff=%.2f dot=%.2f", dot - futureDot, dot)
        end
        -- Angular acceleration: ball rapidly changing direction + off-axis
        -- Removed age guard to detect curves even when player is moving
        if angularRate > 2.0 and dot < 0.70 then
            return _ret("sc_angular", "angRate=%.2f dot=%.2f", angularRate, dot)
        end
        -- Velocity reversal: future dot drops sharply
        -- Removed age guard to detect curves even when player is moving
        if futureDot < dot - 0.15 and dot < 0.80 then
            return _ret("sc_reversal", "dot=%.2f futDot=%.2f", dot, futureDot)
        end
        -- Both future dot low AND ball will miss
        -- Removed age guard to detect curves even when player is moving
        if futureDot < 0.45 and willMiss then
            return _ret("sc_future_miss", "futDot=%.2f", futureDot)
        end
        -- Any significant dot difference at super close range = curve
        if (dot - futureDot) > 0.12 then
            return _ret("sc_any_dot_diff", "dotDiff=%.2f", dot - futureDot)
        end
        -- Any angular velocity at super close range = curve
        if angularRate > 1.5 then
            return _ret("sc_any_angular", "angRate=%.2f", angularRate)
        end
        -- Any off-axis dot at super close range = curve (movement-robust)
        if dot < 0.65 then
            return _ret("sc_off_axis", "dot=%.2f", dot)
        end
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- CLOSE RANGE  (distance < CLOSE_RANGE)
    -- ══════════════════════════════════════════════════════════════════════════
    if distance < CLOSE_RANGE then
        -- High dot curve detection: ball coming straight but might curve
        -- Removed age guard to detect curves even when player is moving
        if dot > 0.75 and (dot - futureDot) > 0.06 then
            return _ret("cr_high_dot", "dot=%.2f futDot=%.2f", dot, futureDot)
        end

        -- Left curve detection: dot product indicates leftward movement
        -- Use dot difference to detect direction changes
        -- Removed age guard to detect curves even when player is moving
        if (dot - futureDot) > 0.10 and dot < 0.70 then
            return _ret("cr_left_curve", "dotDiff=%.2f dot=%.2f", dot - futureDot, dot)
        end

        -- Right curve detection: dot product indicates rightward movement
        -- Use dot difference to detect direction changes
        -- Removed age guard to detect curves even when player is moving
        if (dot - futureDot) > 0.10 and dot < 0.70 then
            return _ret("cr_right_curve", "dotDiff=%.2f dot=%.2f", dot - futureDot, dot)
        end

        -- Hard backwards: both dot AND future dot clearly off.
        -- Relaxed thresholds to detect hard back curves against real players
        -- Removed age guard to detect curves even when player is moving
        if dot < 0.05 and futureDot < 0.25 then
            return _ret("cr_back_hard", "dot=%.2f futDot=%.2f", dot, futureDot)
        end
        -- Hard backwards without futureDot check (more aggressive)
        if dot < -0.05 then
            return _ret("cr_back_hard_simple", "dot=%.2f", dot)
        end
        -- Velocity reversal with miss
        -- Removed age guard to detect curves even when player is moving
        if futureDot < dot - 0.15 and willMiss then
            return _ret("cr_reversal_miss", "dot=%.2f futDot=%.2f", dot, futureDot)
        end
        -- Strong lateral + off-axis dot
        -- Use dot difference instead of cross
        -- Removed age guard to detect curves even when player is moving
        if (dot - futureDot) > 0.08 and dot < 0.55 and (speed < 120 or dot < 0.30) then
            return _ret("cr_lateral", "dotDiff=%.2f dot=%.2f spd=%.1f", dot - futureDot, dot, speed)
        end
        -- Angular rate + off-axis (relaxed thresholds)
        -- Removed age guard to detect curves even when player is moving
        if angularRate > 1.5 and dot < 0.50 and speed < 120 then
            return _ret("cr_angular", "angRate=%.2f dot=%.2f spd=%.1f", angularRate, dot, speed)
        end
        -- Targeted + will-miss + off-axis
        -- Removed age guard to detect curves even when player is moving
        if targeted and willMiss and dot < 0.60 then
            return _ret("cr_tgt_miss", "dot=%.2f", dot)
        end
        -- Angular + dot difference both agree
        -- Removed age guard to detect curves even when player is moving
        if angularRate > 1.5 and (dot - futureDot) > 0.06 and dot < 0.50 and speed < 120 then
            return _ret("cr_angular_dot", "angRate=%.2f dotDiff=%.2f dot=%.2f spd=%.1f", angularRate, dot - futureDot, dot, speed)
        end
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- BACKWARDS BALL DETECTOR  (any range, no targeted gate)
    -- ══════════════════════════════════════════════════════════════════════════
    do
        -- Hard backwards: clearly flying away.
        -- Relaxed to -0.15 (was -0.20) to detect hard back curves against real players
        if dot < -0.15 and distance < BACK_RANGE and speed > 15 then
            return _ret("back_hard", "dot=%.2f dist=%.1f spd=%.1f", dot, distance, speed)
        end
        -- Soft backwards: removed age guard to detect curves even when player is moving
        -- Relaxed futureDot to < 0.25 (was 0.22).
        local softRange = math.min(BACK_RANGE, 100)
        if dot < 0.25 and willMiss
        and distance < softRange and speed > 15 and futureDot < 0.30 then
            return _ret("back_soft", "dot=%.2f futDot=%.2f", dot, futureDot)
        end
        -- Velocity reversal at range — removed age guard to detect curves when moving
        if dot > 0 and futureDot < dot - 0.20 and distance < CLOSE_RANGE then
            return _ret("back_reversal", "dot=%.2f futDot=%.2f", dot, futureDot)
        end
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- TARGETED BACKWARDS CURVE  (medium to far range)
    -- ══════════════════════════════════════════════════════════════════════════
    if targeted and distance < BACK_RANGE and distance >= CLOSE_RANGE then
        -- Relaxed thresholds for targeted backwards curves
        if dot < 0.10 and futureDot < 0.20 then
            return _ret("tgt_back", "TGT backwards dot=%.2f futureDot=%.2f", dot, futureDot)
        end
        local bcThreshold = math.clamp(0.55 - (distance / BACK_RANGE) * 0.20, 0.35, 0.55)
        if willMiss and dot < bcThreshold and speed > 12 then
            return _ret("tgt_miss", "TGT will-miss dot=%.2f thr=%.2f", dot, bcThreshold)
        end
        if angularRate > 2.5 and dot < 0.45 then
            return _ret("tgt_angular", "TGT angular angRate=%.2f dot=%.2f", angularRate, dot)
        end
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- WARP GUARD  (sustained off-axis over multiple frames)
    -- ══════════════════════════════════════════════════════════════════════════
    local angleRad = math.acos(math.clamp(dot, -1, 1))
    _curveState.lerp_radians = linear_predict(_curveState.lerp_radians, angleRad, LERP_FACTOR)
    -- Also sync legacy props table so external reads stay valid
    BallHelper.ball.properties.lerp_radians = _curveState.lerp_radians

    if _curveState.lerp_radians < LERP_THRESHOLD then
        _curveState.last_warping = now
        BallHelper.ball.properties.last_warping = now
    end

    local tiWindow = math.min(timeToImpact / TI_WINDOW_DIVISOR, 0.55)
    local warpFired  = (now - _curveState.last_warping) < tiWindow
    local curvFired  = (now - _curveState.curving)      < tiWindow
    -- Require BOTH timers: one stale timestamp can't cause false positives
    if warpFired and curvFired then
        return _ret("warp", "WARP guard fired lerp=%.3f tiWin=%.2f", _curveState.lerp_radians, tiWindow)
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- FINAL GATE  (dot difference + dot, distance-aware, two-signal required)
    -- ══════════════════════════════════════════════════════════════════════════
    local threshold   = cachedPingThreshold
    local dotDiffNeeded = CURVE_ANGLE + (distance / 500) * 0.04
    -- Require dot difference AND dot both off — single-signal final gate caused FPs
    if (dot - futureDot) > dotDiffNeeded and dot < threshold then
        return _ret("final_dot_diff_dot", "FINAL dotDiff=%.3f>%.3f dot=%.2f<%.2f", dot - futureDot, dotDiffNeeded, dot, threshold)
    end
    -- Targeted ball with very strong lateral movement
    if targeted and (dot - futureDot) > dotDiffNeeded * 1.8 and dot < 0.70 then
        return _ret("final_tgt_dot_diff", "FINAL targeted dotDiff=%.3f dot=%.2f", dot - futureDot, dot)
    end

    return false
end

-- Alias so existing calls to vector3curve still work
BallHelper.vector3curve = BallHelper.ball_curved




System.curve = {}

-- Curve methods string-keyed (Condemned-style). Single source of truth.
-- AP loop calls System.curve.get_cframe() which dispatches by name.
local CurrentCurveMethod = "camera"

function System.curve.get_cframe()
    local camera = workspace.CurrentCamera
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    if not root then return camera.CFrame end
    
    local targetPart
    local closest = System.player.get_closest_to_cursor()
    if closest and closest:FindFirstChild('HumanoidRootPart') then
        targetPart = closest.HumanoidRootPart
    end
    
    local targetPosition = (targetPart and targetPart.Position)
        or (root.Position + camera.CFrame.LookVector * 1000)
    local toTarget = (targetPosition - root.Position).Unit
    local method = CurrentCurveMethod
    
    if method == "dot" then
        return CFrame.lookAt(root.Position, targetPosition + Vector3.new(0, 1.75, 0))
    elseif method == "backwards" then
        -- Enhanced backwards curve with distance-aware behavior
        local ball = BallHelper.get_ball()
        local distance = ball and (ball.Position - root.Position).Magnitude or 50
        
        -- At close range, use a more aggressive backwards angle for better curve handling
        if distance < CLOSE_RANGE then
            -- Add slight upward tilt for close-range backwards to handle vertical curves
            local backwardsDir = -toTarget
            local tiltedBackwards = (backwardsDir + Vector3.new(0, 0.3, 0)).Unit
            return CFrame.new(root.Position, root.Position + tiltedBackwards * 1000)
        else
            -- Standard backwards for medium to far range
            return CFrame.new(root.Position, root.Position + (-toTarget) * 1000)
        end
    elseif method == "slow" then
        return CFrame.new(root.Position, root.Position + Vector3.new(0, -350, 0))
    else
        return camera.CFrame
    end
end

System.parry = {}

function System.parry.execute()
    if System.__properties.__parries > 10000 or not LocalPlayer.Character then
        return
    end
    
    HookSystem.Parry()
    
    if System.__properties.__parries > 10000 then return end
    
    System.__properties.__parries = System.__properties.__parries + 1
    task.delay(0.5, function()
        if System.__properties.__parries > 0 then
            System.__properties.__parries = System.__properties.__parries - 1
        end
    end)
end



-- // aqqqqq

function System.parry.execute_action()
    System.animation.play_grab_parry(true)  -- force=true: always play, ignore toggle
    System.parry.execute()
end

local function linear_predict(a, b, time_volume)
    return a + (b - a) * time_volume
end

System.detection = {
    __ball_properties = {
        __aerodynamic_time = tick(),
        __last_warping = tick(),
        __lerp_radians = 0,
        __curving = tick()
    }
}

function System.detection.is_curved(ball)
    return BallHelper.ball_curved()
end

-- SecondaryEndCD is fired by the server after every parry to signal cooldown end.
-- Without a listener the event queue fills up (32 events dropped warning) and
-- causes a lag spike after each parry. Connect a no-op to drain it cleanly.
pcall(function()
    ReplicatedStorage.Remotes.SecondaryEndCD.OnClientEvent:Connect(function() end)
end)

ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c, d)
    System.__properties.__deathslash_active = d or false
end)

ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a, b)
    System.__properties.__infinity_active = b or false
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
        System.__properties.__timehole_active = true
    end
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
    System.__properties.__timehole_active = false
end)

local maxParryCount = 36
local parryDelay = 0.05

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
    local args = {...}
    local player = args[1]
    
    if player == LocalPlayer or player == LocalPlayer.Name or (player and player.Name == LocalPlayer.Name) then
        System.__properties.__slashesoffury_active = true
        System.__properties.__slashesoffury_count = 0
    end
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_active = false
    System.__properties.__slashesoffury_count = 0
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
    System.__properties.__slashesoffury_count = System.__properties.__slashesoffury_count + 1
end)

ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
    spawn(function()
        while System.__properties.__slashesoffury_active and System.__properties.__slashesoffury_count < maxParryCount do
            if System.__config.__detections.__slashesoffury then
                System.parry.execute()
                task.wait(parryDelay)
            else
                break
            end
        end
    end)
end)

Runtime.ChildAdded:Connect(function(Object)
    if System.__config.__detections.__phantom then
        if Object.Name == "maxTransmission" or Object.Name == "transmissionpart" then
            local Weld = Object:FindFirstChildWhichIsA("WeldConstraint")
            if Weld then
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if Character and Weld.Part1 == Character.HumanoidRootPart then
                    local CurrentBall = System.ball.get()
                    Weld:Destroy()
                    
                    if CurrentBall then
                        local FocusConnection
                        FocusConnection = RunService.RenderStepped:Connect(function()
                            local Highlighted = CurrentBall:GetAttribute("highlighted")
                            
                            if Highlighted == true then
                                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                                System.__properties.__parried = true
                                
                                task.delay(1, function()
                                    System.__properties.__parried = false
                                end)
                                
                            elseif Highlighted == false then
                                FocusConnection:Disconnect()
                            end
                        end)
                        
                        task.delay(3, function()
                            if FocusConnection and FocusConnection.Connected then
                                FocusConnection:Disconnect()
                            end
                        end)
                    end
                end
            end
        end
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, root)
    -- Fast exit when no parry features are active (FPS protection for legit clicks)
    if not (System.__properties.__autoparry_enabled 
        or System.__properties.__manual_spam_enabled 
        or System.__properties.__auto_spam_enabled) then 
        return 
    end
    
    if root.Parent and root.Parent ~= LocalPlayer.Character then
        if not Alive or root.Parent.Parent ~= Alive then
            return
        end
    end
    
    local closest = System.player.get_closest()
    local ball = System.ball.get()
    
    if not ball or not closest then return end
    
    local target_distance = (LocalPlayer.Character.PrimaryPart.Position - closest.PrimaryPart.Position).Magnitude
    local distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
    local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
    local dot = direction:Dot(ball.AssemblyLinearVelocity.Unit)
    
    local curveResult = System.detection.is_curved()
    
    -- Never force parry if curve is detected, regardless of distance
    if curveResult then
        return
    end
    
    -- FIX (bug 3): Fast balls travel further between frames, so the hard-coded
    -- 15-stud clash threshold misses them. Scale the window up with ball speed
    -- (capped at +10 extra studs) so high-speed clash balls still get parried.
    local clashBallSpeed = ball.AssemblyLinearVelocity.Magnitude
    local clashDist = 15 + math.min(clashBallSpeed / 20, 10)
    if target_distance < clashDist and distance < clashDist and dot > -0.25 then
        System.parry.execute_action()
    end
    
    if System.__properties.__grab_animation then
        System.__properties.__grab_animation:Stop()
    end
end)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if not Alive or not LocalPlayer.Character or LocalPlayer.Character.Parent ~= Alive then
        return
    end
    
    -- Fast exit when no script features need to react to this parry event.
    -- On legit user-clicks this prevents the listener from doing work each
    -- click, which previously caused noticeable FPS drops. We only care
    -- about ParrySuccess events when one of the parry features is actually
    -- running.
    local apOn = System.__properties.__autoparry_enabled
    local msOn = System.__properties.__manual_spam_enabled
    local asOn = System.__properties.__auto_spam_enabled
    if not (apOn or msOn or asOn) then return end
    
    if SpamAnimationCounter < 5 then
        SpamAnimationCounter = SpamAnimationCounter + 1
        task.delay(0.15, function()
            if SpamAnimationCounter > 0 then
                SpamAnimationCounter = SpamAnimationCounter - 1
            end
        end)
    end
    
    animationDelayBypass = true
    
    -- Only do animation work if an animation-fix feature is on
    local needsAnimWork = (System.__properties.__play_animation and apOn)
        or (getgenv().ManualSpamAnimationFix and msOn)
        or (getgenv().AutoSpamAnimationFix and asOn)
    if not needsAnimWork then return end
    
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, animTrack in pairs(animator:GetPlayingAnimationTracks()) do
            if animTrack.Name == "GrabParry" or animTrack.Name == "Grab" then
                if not AnimationSpamMode then
                    pcall(function() animTrack.TimePosition = 0 end)
                end
                StopAnimationTrack(animTrack)
            end
        end
    end
    
    if System.__properties.__grab_animation then
        System.__properties.__grab_animation:Stop()
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(a, b)
    -- Fast exit when no parry features active (FPS protection for legit clicks)
    if not (System.__properties.__autoparry_enabled 
        or System.__properties.__manual_spam_enabled 
        or System.__properties.__auto_spam_enabled) then 
        return 
    end
    
    local Primary_Part = LocalPlayer.Character.PrimaryPart
    local Ball = System.ball.get()

    if not Ball then
        return
    end

    local Zoomies = Ball:FindFirstChild('zoomies')

    if not Zoomies then
        return
    end

    local Speed = Zoomies.VectorVelocity.Magnitude

    local Distance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
    local Velocity = Zoomies.VectorVelocity

    local Ball_Direction = Velocity.Unit

    local Direction = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Unit
    local Dot = Direction:Dot(Ball_Direction)

    local Pings = Stats.Network.ServerStatsItem['Data Ping']:GetValue()

    local Speed_Threshold = math.min(Speed / 100, 40)
    local Reach_Time = Distance / Speed - (Pings / 1000)

    local Enough_Speed = Speed > 1
    local Ball_Distance_Threshold = 15 - math.min(Distance / 1000, 15) + Speed_Threshold

    if Enough_Speed and Reach_Time > Pings / 10 then
        Ball_Distance_Threshold = math.max(Ball_Distance_Threshold - 15, 15)
    end

    if b ~= Primary_Part and Distance > Ball_Distance_Threshold then
        System.__properties.__curving_time = tick()
    end
end)

System.triggerbot = {}

function System.triggerbot.trigger(ball)
    if System.__triggerbot.__is_parrying or System.__triggerbot.__parries > System.__triggerbot.__max_parries then
        return
    end
    
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and 
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then
        return
    end
    
    System.__triggerbot.__is_parrying = true
    System.__triggerbot.__parries = System.__triggerbot.__parries + 1
    
    System.animation.play_grab_parry()
    System.parry.execute()
    
    task.delay(System.__triggerbot.__parry_delay, function()
        if System.__triggerbot.__parries > 0 then
            System.__triggerbot.__parries = System.__triggerbot.__parries - 1
        end
    end)
    
    local connection
    connection = ball:GetAttributeChangedSignal('target'):Once(function()
        System.__triggerbot.__is_parrying = false
        if connection then
            connection:Disconnect()
        end
    end)
    
    task.spawn(function()
        local start_time = tick()
        repeat
            RunService.Heartbeat:Wait()
        until (tick() - start_time >= 1 or not System.__triggerbot.__is_parrying)
        
        System.__triggerbot.__is_parrying = false
    end)
end

function System.triggerbot.loop()
    if not System.__triggerbot.__enabled then return end
    
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and 
       LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then
        return
    end
    
    local balls = workspace:FindFirstChild('Balls')
    if not balls then return end
    
    for _, ball in pairs(balls:GetChildren()) do
        if ball:IsA('BasePart') and ball:GetAttribute('target') == LocalPlayer.Name then
            System.triggerbot.trigger(ball)
            break
        end
    end
end

function System.triggerbot.enable(enabled)
    System.__triggerbot.__enabled = enabled
    
    if enabled then
        if not System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot = RunService.Heartbeat:Connect(System.triggerbot.loop)
        end
    else
        if System.__properties.__connections.__triggerbot then
            System.__properties.__connections.__triggerbot:Disconnect()
            System.__properties.__connections.__triggerbot = nil
        end
        System.__triggerbot.__is_parrying = false
        System.__triggerbot.__parries = 0
    end
end

System.manual_spam = {}

-- Manual spam ramp-up state: starts slow and accelerates to full rate over
-- the first ~500ms. Matches Condemned's behavior so manual spam doesn't
-- start at 420Hz instantly (looks more natural and avoids the immediate
-- burst that can trigger anti-cheat heuristics).
local manualSpamStartTick = 0
local lastManualSpamTick = 0

function System.manual_spam.loop(delta)
    if not System.__properties.__manual_spam_enabled then return end
    if not LocalPlayer.Character or LocalPlayer.Character.Parent ~= Alive then return end
    
    -- Acceleration: 1.0x at start ramping up to 1.5x at 0.5s elapsed and capped.
    local baseRate = System.__properties.__spam_rate
    local elapsed = tick() - manualSpamStartTick
    local accelFactor = math.min(1 + (elapsed / 0.5) * 0.5, 1.5)
    local effectiveRate = baseRate * accelFactor
    local interval = 1 / effectiveRate
    
    local now = tick()
    local timeSinceLast = now - lastManualSpamTick
    
    if timeSinceLast >= interval then
        -- Burst fire to bridge FPS gaps (cap at 5 to avoid rate-limit kicks)
        local fireAmount = math.min(math.floor(timeSinceLast / interval), 5)
        lastManualSpamTick = now
        for i = 1, fireAmount do
            System.parry.execute()
            if getgenv().ManualSpamAnimationFix then
                System.animation.spam_sequence()
            end
        end
    end
end

function System.manual_spam.start()
    if System.__properties.__connections.__manual_spam then
        System.__properties.__connections.__manual_spam:Disconnect()
    end
    
    System.__properties.__manual_spam_enabled = true
    -- Reset ramp-up timing on each start
    manualSpamStartTick = tick()
    lastManualSpamTick = tick()
    System.__properties.__connections.__manual_spam = RunService.Heartbeat:Connect(System.manual_spam.loop)
end

function System.manual_spam.stop()
    System.__properties.__manual_spam_enabled = false
    manualSpamStartTick = 0
    if System.__properties.__connections.__manual_spam then
        System.__properties.__connections.__manual_spam:Disconnect()
        System.__properties.__connections.__manual_spam = nil
    end
end

System.auto_spam = {}

function System.auto_spam:get_entity_properties()
    System.player.get_closest()
    
    if not Closest_Entity then return false end
    
    local entity_velocity = Closest_Entity.PrimaryPart.Velocity
    local entity_direction = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Unit
    local entity_distance = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Magnitude
    
    return {
        Velocity = entity_velocity,
        Direction = entity_direction,
        Distance = entity_distance
    }
end

function System.auto_spam:get_ball_properties()
    local ball = System.ball.get()
    if not ball then return false end
    
    -- Get ball position safely (handle both Model and BasePart)
    local ball_position
    if ball:IsA("Model") then
        ball_position = ball.PrimaryPart and ball.PrimaryPart.Position or ball:GetPivot().Position
    else
        ball_position = ball.Position
    end
    
    if not ball_position then return false end
    
    local ball_velocity = ball:IsA("BasePart") and ball.AssemblyLinearVelocity or (ball.PrimaryPart and ball.PrimaryPart.AssemblyLinearVelocity) or Vector3.zero
    local ball_speed = ball_velocity.Magnitude
    
    local char = LocalPlayer.Character
    if not char or not char.PrimaryPart then return false end
    
    local ball_direction = (char.PrimaryPart.Position - ball_position).Unit
    local ball_distance = (char.PrimaryPart.Position - ball_position).Magnitude
    local ball_dot = ball_speed > 0 and ball_direction:Dot(ball_velocity.Unit) or 0
    
    return {
        Velocity = ball_velocity,
        Direction = ball_direction,
        Distance = ball_distance,
        Dot = ball_dot
    }
end

function System.auto_spam.spam_service(self)
    local ball = System.ball.get()
    local entity = System.player.get_closest()
    
    if not ball or not entity or not entity.PrimaryPart then
        return false
    end
    
    local spam_accuracy = 0
    
    local velocity = ball.AssemblyLinearVelocity
    local speed = velocity.Magnitude
    
    local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
    local dot = direction:Dot(velocity.Unit)
    
    local target_position = entity.PrimaryPart.Position
    local target_distance = LocalPlayer:DistanceFromCharacter(target_position)
    
    local maximum_spam_distance = self.Ping + math.min(speed / 6, 255)
    
    if self.Entity_Properties.Distance > maximum_spam_distance then
        return spam_accuracy
    end
    
    if self.Ball_Properties.Distance > maximum_spam_distance then
        return spam_accuracy
    end
    
    if target_distance > maximum_spam_distance then
        return spam_accuracy
    end
    
    local maximum_speed = 5 - math.min(speed / 5, 5)
    local maximum_dot = math.clamp(dot, -1, 0) * maximum_speed
    
    spam_accuracy = maximum_spam_distance - maximum_dot
    
    return spam_accuracy
end

function System.auto_spam.start()
    if System.__properties.__connections.__auto_spam then
        System.__properties.__connections.__auto_spam:Disconnect()
    end
    
    System.__properties.__auto_spam_enabled = true
    
    -- Immediately patch animation on the very first frame auto spam activates
    if getgenv().AutoSpamAnimationFix then
        task.spawn(function()
            System.animation.spam_sequence()
        end)
    end
    
    System.__properties.__connections.__auto_spam = RunService.PreSimulation:Connect(function()
        local ball = System.ball.get()
        
        if not ball then return end
        
        if System.__properties.__slashesoffury_active then return end
        
        local zoomies = ball:FindFirstChild('zoomies')
        if not zoomies then return end
        
        System.player.get_closest()
        
        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
        local ping_threshold = math.clamp(ping / 10, 1, 16)
        
        local ball_target = ball:GetAttribute('target')
        
        if ball_target == LocalPlayer.Name then
            local ball_properties = System.auto_spam:get_ball_properties()
            local entity_properties = System.auto_spam:get_entity_properties()
            
            if not ball_properties or not entity_properties then return end
        
            local accuracy = System.auto_spam.spam_service({
                Ping = ping_threshold,
                Ball_Properties = ball_properties,
                Entity_Properties = entity_properties
            })
        
            local target_position = Closest_Entity.PrimaryPart.Position
            local target_distance = LocalPlayer:DistanceFromCharacter(target_position)
            
            local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
            local ball_direction = zoomies.VectorVelocity.Unit
            
            local dot = direction:Dot(ball_direction)
            local distance = LocalPlayer:DistanceFromCharacter(ball.Position)
            
            if not ball_target then return end
            if target_distance > accuracy or distance > accuracy then return end
            
            local pulsed = LocalPlayer.Character:GetAttribute('Pulsed')
            if pulsed then return end
            
            if ball_target == LocalPlayer.Name and target_distance > 30 and distance > 30 then return end
            
            if distance <= accuracy and System.__properties.__parries > System.__properties.__spam_threshold then
                System.parry.execute()
                if getgenv().AutoSpamAnimationFix then
                    System.animation.spam_sequence()
                end
            end
        end
    end)
end

function System.auto_spam.stop()
    System.__properties.__auto_spam_enabled = false
    if System.__properties.__connections.__auto_spam then
        System.__properties.__connections.__auto_spam:Disconnect()
        System.__properties.__connections.__auto_spam = nil
    end
end

System.autoparry = {}

local GlobalParryLocks = {}

function System.autoparry.start()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
    end
    
    System.__properties.__connections.__autoparry = RunService.PreSimulation:Connect(function()
        -- AnimationSpamMode is now updated by an always-on Heartbeat (see
        -- animation section), so removed redundant update here.
        if not System.__properties.__autoparry_enabled or not LocalPlayer.Character or 
           not LocalPlayer.Character.PrimaryPart then
            return
        end
        
        local balls = System.ball.get_all()
        local training_ball = nil
        if workspace:FindFirstChild("TrainingBalls") then
            for _, Instance in pairs(workspace.TrainingBalls:GetChildren()) do
                if Instance:GetAttribute("realBall") then
                    training_ball = Instance
                    break
                end
            end
        end

        local function processParry(ball, is_training)
            if not ball then return end
            
            local zoomies = ball:FindFirstChild('zoomies')
            if not zoomies then return end
            
            if not GlobalParryLocks[ball] then
                GlobalParryLocks[ball] = {
                    ParriedLastBall = false,
                    lastTarget = nil,
                    lastFireTick = 0,
                    CurrentRandomAcc = AccuracyMin,
                }
            end
            local lockData = GlobalParryLocks[ball]
            local currentTarget = ball:GetAttribute('target')
            
            if currentTarget ~= lockData.lastTarget then
                lockData.ParriedLastBall = false
                lockData.lastTarget = currentTarget
                -- Re-roll random accuracy on each new target (per-ball, matches Condemned).
                -- This is what makes humanizer actually feel "random" - each ball that
                -- targets you (or retargets) gets a fresh random accuracy value within
                -- AccuracyMin/AccuracyMax range.
                if HumanizerEnabled then
                    local minVal = math.min(AccuracyMin, AccuracyMax)
                    local maxVal = math.max(AccuracyMin, AccuracyMax)
                    lockData.CurrentRandomAcc = math.random(minVal, maxVal)
                else
                    lockData.CurrentRandomAcc = AccuracyMin
                end
            end
            
            if lockData.ParriedLastBall then 
                if (tick() - lockData.lastFireTick) > 1 then
                    lockData.ParriedLastBall = false
                else
                    return 
                end
            end
            
            local velocity = zoomies.VectorVelocity
            local distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
            
            local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 10
            local ping_threshold = math.clamp(ping / 10, 5, 17)
            local speed = velocity.Magnitude
            
            local capped_speed_diff = math.max(speed - 9.5, 0)
            -- Per-ball accuracy: when humanizer is on, lockData.CurrentRandomAcc
            -- was rolled at ball target change (above). When humanizer is off, it
            -- equals AccuracyMin which equals the slider value. Either way, this
            -- replaces the static __divisor_multiplier with a per-ball value so
            -- the random accuracy actually varies between balls.
            local currentAcc = lockData.CurrentRandomAcc or AccuracyMin
            local mappedAcc = 1 + (currentAcc - 1) * (79 / 99)
            local perBallDivisorMult = 0.75 + (mappedAcc - 1) * (3 / 99)
            local speed_divisor = (2.4 + capped_speed_diff * 0.002) * perBallDivisorMult
            -- FIX (bug 3): At high speed the ball can fly past the threshold between frames.
            -- Add a ping-scaled lookahead bonus so fast balls are caught further out.
            local ping_sec = Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 1000
            local speedLookahead = math.min(speed * ping_sec, 12)
            local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5) + speedLookahead
            
            if not is_training then
                local curveResult = System.detection.is_curved(ball)
                
                if ball:FindFirstChild('AeroDynamicSlashVFX') then
                    ball.AeroDynamicSlashVFX:Destroy()
                    System.__properties.__tornado_time = tick()
                end
                
                if Runtime:FindFirstChild('Tornado') then
                    if (tick() - System.__properties.__tornado_time) < 
                       (Runtime.Tornado:GetAttribute('TornadoTime') or 1) + 0.314159 then
                        return
                    end
                end
                
                -- Any curve (including backwards) = bait. Skip parry entirely.
                if currentTarget == LocalPlayer.Name and curveResult then
                    return
                end
                
                if ball:FindFirstChild('ComboCounter') then return end
                if LocalPlayer.Character.PrimaryPart:FindFirstChild('SingularityCape') then return end
                if System.__config.__detections.__infinity and System.__properties.__infinity_active then return end
                if System.__config.__detections.__deathslash and System.__properties.__deathslash_active then return end
                if System.__config.__detections.__timehole and System.__properties.__timehole_active then return end
                if System.__config.__detections.__slashesoffury and System.__properties.__slashesoffury_active then return end
            end
            
            if currentTarget == LocalPlayer.Name and distance <= parry_accuracy then
                if not is_training then
                    if getgenv().CooldownProtection then
                        local ParryCD = LocalPlayer.PlayerGui.Hotbar.Block.UIGradient
                        if ParryCD.Offset.Y < 0.4 then
                            ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                            return
                        end
                    end
                    
                    if getgenv().AutoAbility then
                        local AbilityCD = LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
                        if AbilityCD.Offset.Y == 0.5 then
                            if LocalPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and LocalPlayer.Character.Abilities["Raging Deflection"].Enabled or
                               LocalPlayer.Character.Abilities:FindFirstChild("Rapture") and LocalPlayer.Character.Abilities["Rapture"].Enabled or
                               LocalPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and LocalPlayer.Character.Abilities["Calming Deflection"].Enabled or
                               LocalPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and LocalPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or
                               LocalPlayer.Character.Abilities:FindFirstChild("Fracture") and LocalPlayer.Character.Abilities["Fracture"].Enabled or
                               LocalPlayer.Character.Abilities:FindFirstChild("Death Slash") and LocalPlayer.Character.Abilities["Death Slash"].Enabled then
                                
                                lockData.ParriedLastBall = true
                                lockData.lastFireTick = tick()
                                ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
                                task.wait(2.432)
                                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
                                return
                            end
                        end
                    end
                end
                
                if (tick() - lockData.lastFireTick) >= 0.15 then
                    -- Check for curve before force parrying
                    local curveResult = System.detection.is_curved(ball)
                    if not curveResult then
                        lockData.ParriedLastBall = true
                        lockData.lastFireTick = tick()
                        System.parry.execute_action()
                    end
                end
            end
        end

        for _, ball in pairs(balls) do
            if System.__triggerbot.__enabled then return end
            if getgenv().BallVelocityAbove800 then return end
            processParry(ball, false)
        end

        if training_ball then
            processParry(training_ball, true)
        end
    end)
end

function System.autoparry.stop()
    if System.__properties.__connections.__autoparry then
        System.__properties.__connections.__autoparry:Disconnect()
        System.__properties.__connections.__autoparry = nil
    end
end

local function create_mobile_button(name, position_y, color)
    local gui = Instance.new('ScreenGui')
    gui.Name = 'Sigma' .. name .. 'Mobile'
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local button = Instance.new('TextButton')
    button.Size = UDim2.new(0, 140, 0, 50)
    button.Position = UDim2.new(0.5, -70, position_y, 0)
    button.BackgroundTransparency = 1
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.Draggable = true
    button.AutoButtonColor = false
    button.ZIndex = 2
    
    local bg = Instance.new('Frame')
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bg.Parent = button
    
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = bg
    
    local stroke = Instance.new('UIStroke')
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = bg
    
    local text = Instance.new('TextLabel')
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.ZIndex = 3
    text.Parent = button
    
    button.Parent = gui
    gui.Parent = CoreGui
    
    return {gui = gui, button = button, text = text, bg = bg}
end

local function create_mobile_button(name, position_y, color)
    local gui = Instance.new('ScreenGui')
    gui.Name = 'Sigma' .. name .. 'Mobile'
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local button = Instance.new('TextButton')
    button.Size = UDim2.new(0, 140, 0, 50)
    button.Position = UDim2.new(0.5, -70, position_y, 0)
    button.BackgroundTransparency = 1
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.Draggable = true
    button.AutoButtonColor = false
    button.ZIndex = 2
    
    local bg = Instance.new('Frame')
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bg.Parent = button
    
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = bg
    
    local stroke = Instance.new('UIStroke')
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = bg
    
    local text = Instance.new('TextLabel')
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.ZIndex = 3
    text.Parent = button
    
    button.Parent = gui
    gui.Parent = CoreGui
    
    return {gui = gui, button = button, text = text, bg = bg}
end

local function destroy_mobile_gui(gui_data)
    if gui_data and gui_data.gui then
        gui_data.gui:Destroy()
    end
end

local autoparry_module = rage:create_module({
    title = 'Auto Parry',
    flag = 'Auto_Parry',
    description = 'Automatically parries ball',
    section = 'left',
    callback = function(value)
        System.__properties.__autoparry_enabled = value
        if value then
            System.autoparry.start()
            if getgenv().AutoParryNotify then
                Library.SendNotification({
                    title = "Auto Parry",
                    text = "ON",
                    duration = 2
                })
            end
        else
            System.autoparry.stop()
            if getgenv().AutoParryNotify then
                Library.SendNotification({
                    title = "Auto Parry",
                    text = "OFF",
                    duration = 2
                })
            end
        end
    end
})



local AutoCurveDropdown = autoparry_module:create_dropdown({
    title = "Curve Method",
    flag = "curve_type",
    options = {'camera', 'dot', 'backwards', 'slow'},
    multi_dropdown = false,
    maximum_options = 4,
    callback = function(value)
        CurrentCurveMethod = value
    end
})

local acc_slider = autoparry_module:create_slider({
    title = 'Parry Accuracy',
    flag = 'Parry_Accuracy',
    maximum_value = 100,
    minimum_value = 1,
    value = 100,
    round_number = true,
    callback = function(value)
        if not HumanizerEnabled then
            AccuracyMin = value
            AccuracyMax = value
        end
    end
})

local dual_acc_slider = autoparry_module:create_dual_slider({
    title = "Parry Accuracy",
    flag = "accuracy_range",
    minimum_value = 1,
    maximum_value = 100,
    min_value = 30,
    max_value = 70,
    round_number = true,
    callback = function(values)
        if HumanizerEnabled then
            AccuracyMin = values[1]
            AccuracyMax = values[2]
        end
    end
})

autoparry_module:create_checkbox({
    title = "Random Accuracy",
    flag = "Humanizer_Enabled",
    callback = function(value)
        HumanizerEnabled = value
        acc_slider:SetVisible(not value)
        if dual_acc_slider then 
            dual_acc_slider:SetVisible(value)
            if value and dual_acc_slider._min and dual_acc_slider._max then
                AccuracyMin = dual_acc_slider._min
                AccuracyMax = dual_acc_slider._max
            end
        end
    end
})

local function updateDualSliderVisibility()
    local humanizerFlag = Library._config._flags["Humanizer_Enabled"]
    local isHumanizerOn = false
    if type(humanizerFlag) == "table" and humanizerFlag.checked ~= nil then
        isHumanizerOn = humanizerFlag.checked
    elseif type(humanizerFlag) == "boolean" then
        isHumanizerOn = humanizerFlag
    end
    
    if dual_acc_slider then dual_acc_slider:SetVisible(isHumanizerOn) end
    if acc_slider then acc_slider:SetVisible(not isHumanizerOn) end
end

updateDualSliderVisibility()

autoparry_module:create_checkbox({
    title = "Play Animation",
    flag = "Play_Animation",
    callback = function(value)
        System.__properties.__play_animation = value
    end
})

autoparry_module:create_divider({})

autoparry_module:create_checkbox({
    title = "Notify",
    flag = "Auto_Parry_Notify",
    callback = function(value)
        getgenv().AutoParryNotify = value
    end
})

autoparry_module:create_checkbox({
    title = "Cooldown Protection",
    flag = "CooldownProtection",
    callback = function(value)
        getgenv().CooldownProtection = value
    end
})

autoparry_module:create_checkbox({
    title = "Auto Ability",
    flag = "AutoAbility",
    callback = function(value)
        getgenv().AutoAbility = value
    end
})

local triggerbot_module = rage:create_module({
    title = "Triggerbot",
    description = "Parries instantly if targeted",
    flag = "triggerbot",
    section = 'right',
    callback = function(value)
        if System.__properties.__is_mobile then
            if value then
                if not System.__properties.__mobile_guis.triggerbot then
                    local triggerbot_mobile = create_mobile_button('Trigger', 0.7, Color3.fromRGB(255, 255, 255))
                    System.__properties.__mobile_guis.triggerbot = triggerbot_mobile
                    
                    local touch_start = 0
                    local was_dragged = false
                    
                    triggerbot_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            touch_start = tick()
                            was_dragged = false
                        end
                    end)
                    
                    triggerbot_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            if (tick() - touch_start) > 0.1 then
                                was_dragged = true
                            end
                        end
                    end)
                    
                    triggerbot_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and not was_dragged then
                            System.__properties.__triggerbot_enabled = not System.__properties.__triggerbot_enabled
                            System.triggerbot.enable(System.__properties.__triggerbot_enabled)
                            
                            if System.__properties.__triggerbot_enabled then
                                triggerbot_mobile.text.Text = "ON"
                                triggerbot_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            else
                                triggerbot_mobile.text.Text = "Trigger"
                                triggerbot_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            
                            if getgenv().TriggerbotNotify then
                                Library.SendNotification({
                                    title = "Triggerbot",
                                    text = System.__properties.__triggerbot_enabled and "ON" or "OFF",
                                    duration = 2
                                })
                            end
                        end
                    end)
                end
            else
                System.__properties.__triggerbot_enabled = false
                System.triggerbot.enable(false)
                destroy_mobile_gui(System.__properties.__mobile_guis.triggerbot)
                System.__properties.__mobile_guis.triggerbot = nil
            end
        else
            System.__properties.__triggerbot_enabled = value
            System.triggerbot.enable(value)
            
            if getgenv().TriggerbotNotify then
                Library.SendNotification({
                    title = "Triggerbot",
                    text = value and "ON" or "OFF",
                    duration = 2
                })
            end
        end
    end
})

triggerbot_module:create_checkbox({
    title = "Hold Mode",
    flag = "TriggerbotHoldMode",
    callback = function(value)
        getgenv().TriggerbotHoldMode = value
        if value and triggerbot_module._state then
            local boundKey = Library._config._keybinds['triggerbot']
            local isHeld = false
            if boundKey then
                pcall(function()
                    local keyStr = string.gsub(tostring(boundKey), "Enum%.KeyCode%.", "")
                    local keyEnum = Enum.KeyCode[keyStr]
                    if keyEnum then
                        isHeld = game:GetService("UserInputService"):IsKeyDown(keyEnum)
                    end
                end)
            end
            if not isHeld then
                triggerbot_module:change_state(false)
            end
        end
    end
})

game:GetService("UserInputService").InputEnded:Connect(function(input, processed)
    if processed then return end
    if not getgenv().TriggerbotHoldMode then return end
    if not triggerbot_module._state then return end
    
    local boundKey = Library._config._keybinds['triggerbot']
    if boundKey and tostring(input.KeyCode) == tostring(boundKey) then
        triggerbot_module:change_state(false)
    end
end)

triggerbot_module:create_checkbox({
    title = "Notify",
    flag = "TriggerbotNotify",
    callback = function(value)
        getgenv().TriggerbotNotify = value
    end
})

local function create_curve_selector_mobile()
    local gui = Instance.new('ScreenGui')
    gui.Name = 'SigmaCurveSelectorMobile'
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local main_frame = Instance.new('Frame')
    main_frame.Size = UDim2.new(0, 140, 0, 40)
    main_frame.Position = UDim2.new(0.5, -70, 0.12, 0)
    main_frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main_frame.BorderSizePixel = 0
    main_frame.AnchorPoint = Vector2.new(0.5, 0)
    main_frame.ZIndex = 5
    main_frame.Parent = gui
    
    local main_corner = Instance.new('UICorner')
    main_corner.CornerRadius = UDim.new(0, 8)
    main_corner.Parent = main_frame
    
    local main_stroke = Instance.new('UIStroke')
    main_stroke.Color = Color3.fromRGB(60, 60, 60)
    main_stroke.Thickness = 1
    main_stroke.Parent = main_frame

    local header = Instance.new('Frame')
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundTransparency = 1
    header.ZIndex = 6
    header.Parent = main_frame
    
    local header_text = Instance.new('TextLabel')
    header_text.Size = UDim2.new(1, -35, 1, 0)
    header_text.Position = UDim2.new(0, 12, 0, 0)
    header_text.BackgroundTransparency = 1
    header_text.Text = "CURVE"
    header_text.Font = Enum.Font.Gotham
    header_text.TextSize = 11
    header_text.TextColor3 = Color3.fromRGB(180, 180, 180)
    header_text.TextXAlignment = Enum.TextXAlignment.Left
    header_text.ZIndex = 7
    header_text.Parent = header

    local toggle_btn = Instance.new('TextButton')
    toggle_btn.Size = UDim2.new(0, 24, 0, 24)
    toggle_btn.Position = UDim2.new(1, -32, 0.5, -12)
    toggle_btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toggle_btn.Text = "−"
    toggle_btn.Font = Enum.Font.GothamBold
    toggle_btn.TextSize = 14
    toggle_btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggle_btn.AutoButtonColor = false
    toggle_btn.ZIndex = 7
    toggle_btn.Parent = header
    
    local toggle_corner = Instance.new('UICorner')
    toggle_corner.CornerRadius = UDim.new(0, 4)
    toggle_corner.Parent = toggle_btn
    
    local toggle_stroke = Instance.new('UIStroke')
    toggle_stroke.Color = Color3.fromRGB(50, 50, 50)
    toggle_stroke.Thickness = 1
    toggle_stroke.Parent = toggle_btn

    local buttons_container = Instance.new('Frame')
    buttons_container.Size = UDim2.new(1, -16, 0, 0)
    buttons_container.Position = UDim2.new(0, 8, 0, 48)
    buttons_container.BackgroundTransparency = 1
    buttons_container.ClipsDescendants = true
    buttons_container.ZIndex = 6
    buttons_container.Parent = main_frame
    
    local list_layout = Instance.new('UIListLayout')
    list_layout.Padding = UDim.new(0, 4)
    list_layout.FillDirection = Enum.FillDirection.Vertical
    list_layout.SortOrder = Enum.SortOrder.LayoutOrder
    list_layout.Parent = buttons_container
    
    local CURVE_TYPES = {
        {name = "Camera"},
        {name = "Random"},
        {name = "Accelerated"},
        {name = "Backwards"},
        {name = "Slow"},
        {name = "High"}
    }
    
    local buttons = {}
    local current_selected = nil
    
    for i, curve_data in ipairs(CURVE_TYPES) do
        local btn_container = Instance.new('Frame')
        btn_container.Size = UDim2.new(1, 0, 0, 32)
        btn_container.BackgroundTransparency = 1
        btn_container.ZIndex = 7
        btn_container.LayoutOrder = i
        btn_container.Parent = buttons_container
        
        local btn = Instance.new('TextButton')
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.ZIndex = 8
        btn.Parent = btn_container
        
        local btn_corner = Instance.new('UICorner')
        btn_corner.CornerRadius = UDim.new(0, 6)
        btn_corner.Parent = btn
        
        local btn_stroke = Instance.new('UIStroke')
        btn_stroke.Color = Color3.fromRGB(45, 45, 45)
        btn_stroke.Thickness = 1
        btn_stroke.Parent = btn

        local indicator = Instance.new('Frame')
        indicator.Size = UDim2.new(0, 3, 0, 20)
        indicator.Position = UDim2.new(0, 6, 0.5, -10)
        indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        indicator.BorderSizePixel = 0
        indicator.Visible = false
        indicator.ZIndex = 10
        indicator.Parent = btn
        
        local indicator_corner = Instance.new('UICorner')
        indicator_corner.CornerRadius = UDim.new(1, 0)
        indicator_corner.Parent = indicator
        
        local btn_text = Instance.new('TextLabel')
        btn_text.Size = UDim2.new(1, -20, 1, 0)
        btn_text.Position = UDim2.new(0, 16, 0, 0)
        btn_text.BackgroundTransparency = 1
        btn_text.Text = curve_data.name
        btn_text.Font = Enum.Font.Gotham
        btn_text.TextSize = 11
        btn_text.TextColor3 = Color3.fromRGB(150, 150, 150)
        btn_text.TextXAlignment = Enum.TextXAlignment.Left
        btn_text.ZIndex = 9
        btn_text.Parent = btn
        
        buttons[i] = {
            button = btn, 
            stroke = btn_stroke, 
            text = btn_text,
            indicator = indicator,
            container = btn_container
        }
        
        local touch_start = 0
        local was_dragged = false
        
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                touch_start = tick()
                was_dragged = false
            end
        end)
        
        btn.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                if (tick() - touch_start) > 0.1 then
                    was_dragged = true
                end
            end
        end)
        
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch and not was_dragged then

                -- Map old display names to new string-keyed methods
                local nameMap = {
                    Camera = "camera", Random = "camera", Accelerated = "dot",
                    Backwards = "backwards", Slow = "slow", High = "slow"
                }
                local newMethod = nameMap[curve_data.name] or "camera"
                CurrentCurveMethod = newMethod
                if AutoCurveDropdown and AutoCurveDropdown.update then
                    pcall(function() AutoCurveDropdown:update(newMethod) end)
                end

                if current_selected then
                    game:GetService("TweenService"):Create(current_selected.button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    }):Play()
                    game:GetService("TweenService"):Create(current_selected.text, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        TextColor3 = Color3.fromRGB(150, 150, 150)
                    }):Play()
                    game:GetService("TweenService"):Create(current_selected.stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Color = Color3.fromRGB(45, 45, 45)
                    }):Play()
                    current_selected.indicator.Visible = false
                end

                game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                }):Play()
                game:GetService("TweenService"):Create(btn_text, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                game:GetService("TweenService"):Create(btn_stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Color = Color3.fromRGB(255, 255, 255)
                }):Play()
                indicator.Visible = true
                
                current_selected = buttons[i]
                
                if getgenv().CurveNotifyEnabled then
                    Library.SendNotification({
                        title = "Curve",
                        text = newMethod,
                        duration = 2
                    })
                end
            end
        end)
    end

    local is_expanded = true
    local expanded_height = 48 + (#CURVE_TYPES * 32) + ((#CURVE_TYPES - 1) * 4) + 12
    local minimized_height = 40
    
    buttons_container.Size = UDim2.new(1, -16, 0, (#CURVE_TYPES * 32) + ((#CURVE_TYPES - 1) * 4))
    main_frame.Size = UDim2.new(0, 140, 0, expanded_height)
    
    toggle_btn.MouseButton1Click:Connect(function()
        is_expanded = not is_expanded
        toggle_btn.Text = is_expanded and "−" or "+"
        
        game:GetService("TweenService"):Create(main_frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 140, 0, is_expanded and expanded_height or minimized_height)
        }):Play()
        
        game:GetService("TweenService"):Create(buttons_container, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -16, 0, is_expanded and (#CURVE_TYPES * 32) + ((#CURVE_TYPES - 1) * 4) or 0)
        }):Play()
    end)

    local drag_start = nil
    local start_pos = nil
    local is_dragging = false
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag_start = input.Position
            start_pos = main_frame.Position
            is_dragging = true
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if is_dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - drag_start
            main_frame.Position = UDim2.new(
                start_pos.X.Scale,
                start_pos.X.Offset + delta.X,
                start_pos.Y.Scale,
                start_pos.Y.Offset + delta.Y
            )
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            is_dragging = false
        end
    end)
    
    gui.Parent = CoreGui
    
    return {gui = gui, main_frame = main_frame, buttons = buttons}
end

-- Condemned-style curve hotkey system (1:1 port).
-- Keys 1-5 map to camera/dot/backwards/slow/random. Sets CurrentCurveMethod
-- directly. Notifies if the notify checkbox is enabled. If user presses the
-- key for the currently-active method, notifies "already <method>" instead.
local curve_hotkey_module = rage:create_module({
    title = "Curve Hotkeys",
    description = "Use 1-5 keys to swap curves",
    flag = "curve_hotkey",
    section = "left",
    callback = function(value)
        getgenv().CurveHotkeyEnabled = value
    end
})

curve_hotkey_module:create_checkbox({
    title = "Notify",
    flag = "CurveHotkeyNotify",
    callback = function(value)
        getgenv().CurveNotifyEnabled = value
    end
})

local CurveKeyMap = {
    [Enum.KeyCode.One]   = "camera",
    [Enum.KeyCode.Two]   = "dot",
    [Enum.KeyCode.Three] = "backwards",
    [Enum.KeyCode.Four]  = "slow",
    [Enum.KeyCode.Five]  = "camera",
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end -- Optimization: ignore mouse clicks
    if not getgenv().CurveHotkeyEnabled then return end
    local method = CurveKeyMap[input.KeyCode]
    if not method then return end
    if CurrentCurveMethod == method then
        if getgenv().CurveNotifyEnabled then
            Library.SendNotification({ title = 'Curve', text = 'already ' .. method, duration = 2 })
        end
        return
    end
    CurrentCurveMethod = method
    -- Sync the dropdown UI to reflect the new method
    if AutoCurveDropdown and AutoCurveDropdown.update then
        pcall(function() AutoCurveDropdown:update(method) end)
    end
    if getgenv().CurveNotifyEnabled then
        Library.SendNotification({ title = 'Curve', text = method, duration = 2 })
    end
end)



detectionstab:create_module({
    title = 'Infinity Detection',
    flag = 'Infinity',
    description = '',
    section = 'left',
    callback = function(value)
        System.__config.__detections.__infinity = value
    end
})

detectionstab:create_module({
    title = 'Death Slash Detection',
    flag = 'Death_Slash',
    description = '',
    section = 'right',
    callback = function(value)
        System.__config.__detections.__deathslash = value
    end
})

detectionstab:create_module({
    title = 'Time Hole Detection',
    flag = 'Time_Hole',
    description = '',
    section = 'left',
    callback = function(value)
        System.__config.__detections.__timehole = value
    end
})

local slashes_module = detectionstab:create_module({
    title = 'Slashes Of Fury Detection',
    flag = 'Slashes_Of_Fury',
    description = '',
    section = 'right',
    callback = function(value)
        System.__config.__detections.__slashesoffury = value
    end
})

slashes_module:create_slider({
    title = "Parry Delay",
    minimum_value = 0.05,
    maximum_value = 0.250,
    value = 0.05,
    round_number = true,
    flag = "parry_delay",
    callback = function(value)
        parryDelay = value
    end
})

slashes_module:create_slider({
    title = "Max Parry Count",
    minimum_value = 1,
    maximum_value = 36,
    value = 36,
    round_number = true,
    flag = "max_parry_count",
    callback = function(value)
        maxParryCount = value
    end
})

detectionstab:create_module({
    title = 'Anti-Phantom [BETA]',
    flag = 'Anti_Phantom',
    description = '',
    section = 'left',
    callback = function(value)
        System.__config.__detections.__phantom = value
    end
})

local manual_spam_module = rage:create_module({
    title = "Manual Spam",
    description = "High-frequency parry spam",
    flag = "manualspam",
    section = "left",
    callback = function(state)
        if System.__properties.__is_mobile then
            if state then
                if not System.__properties.__mobile_guis.manual_spam then
                    local manual_spam_mobile = create_mobile_button('Spam', 0.8, Color3.fromRGB(255, 255, 255))
                    System.__properties.__mobile_guis.manual_spam = manual_spam_mobile
                    
                    local manual_touch_start = 0
                    local manual_was_dragged = false
                    
                    manual_spam_mobile.button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            manual_touch_start = tick()
                            manual_was_dragged = false
                        end
                    end)
                    
                    manual_spam_mobile.button.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            if (tick() - manual_touch_start) > 0.1 then
                                manual_was_dragged = true
                            end
                        end
                    end)
                    
                    manual_spam_mobile.button.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and not manual_was_dragged then
                            System.__properties.__manual_spam_enabled = not System.__properties.__manual_spam_enabled
                            
                            if System.__properties.__manual_spam_enabled then
                                System.manual_spam.start()
                                manual_spam_mobile.text.Text = "ON"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            else
                                System.manual_spam.stop()
                                manual_spam_mobile.text.Text = "Spam"
                                manual_spam_mobile.text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            
                            if getgenv().ManualSpamNotify then
                                Library.SendNotification({
                                    title = "ManualSpam",
                                    text = System.__properties.__manual_spam_enabled and "ON" or "OFF",
                                    duration = 2
                                })
                            end
                        end
                    end)
                end
            else
                System.__properties.__manual_spam_enabled = false
                System.manual_spam.stop()
                destroy_mobile_gui(System.__properties.__mobile_guis.manual_spam)
                System.__properties.__mobile_guis.manual_spam = nil
            end
        else
            System.__properties.__manual_spam_enabled = state
            if state then
                System.manual_spam.start()
            else
                System.manual_spam.stop()
            end
            
            if getgenv().ManualSpamNotify then
                Library.SendNotification({
                    title = "Manual Spam",
                    text = state and "ON" or "OFF",
                    duration = 2
                })
            end
        end
    end
})

manual_spam_module:create_checkbox({
    title = "Notify",
    flag = "ManualSpamNotify",
    callback = function(value)
        getgenv().ManualSpamNotify = value
    end
})

-- Hold Mode (ported from Condemned 1:1):
-- When enabled, manual spam only fires while the keybind key is HELD DOWN.
-- Releasing the key turns the toggle off. When disabled (default), the
-- keybind toggles manual spam on/off like a regular toggle.
manual_spam_module:create_checkbox({
    title = "Hold Mode",
    flag = "ManualSpamHoldMode",
    callback = function(value)
        getgenv().ManualSpamHoldMode = value
        
        -- If Hold Mode is enabled while manual spam is currently ON,
        -- turn it off unless the user is actively holding the key.
        if value and manual_spam_module._state then
            local boundKey = Library._config._keybinds['manualspam']
            local isHeld = false
            if boundKey then
                pcall(function()
                    local keyStr = string.gsub(tostring(boundKey), "Enum%.KeyCode%.", "")
                    local keyEnum = Enum.KeyCode[keyStr]
                    if keyEnum then
                        isHeld = UserInputService:IsKeyDown(keyEnum)
                    end
                end)
            end
            if not isHeld then
                manual_spam_module:change_state(false)
            end
        end
    end
})

-- Key release handler: when in Hold Mode and the user releases the bound
-- key, turn manual spam off. Matches Condemned's behavior.
UserInputService.InputEnded:Connect(function(input, processed)
    if processed then return end
    if not getgenv().ManualSpamHoldMode then return end
    if not manual_spam_module._state then return end
    
    local boundKey = Library._config._keybinds['manualspam']
    if boundKey and tostring(input.KeyCode) == tostring(boundKey) then
        manual_spam_module:change_state(false)
    end
end)



manual_spam_module:create_checkbox({
    title = "Animation Fix",
    flag = "ManualSpamAnimationFix",
    callback = function(value)
        getgenv().ManualSpamAnimationFix = value
        System.__properties.__manual_spam_animation_fix = value
    end
})

manual_spam_module:create_slider({
    title = 'Spam Rate',
    flag = 'Spam_Rate',
    maximum_value = 5000,
    minimum_value = 60,
    value = 240,
    round_number = true,
    callback = function(value)
        System.__properties.__spam_rate = value
    end
})

local auto_spam_module = rage:create_module({
    title = 'Auto Spam',
    flag = 'Auto_Spam_Parry',
    description = 'Automatically spam parries ball',
    section = 'right',
    callback = function(value)
        System.__properties.__auto_spam_enabled = value
        if value then
            System.auto_spam.start()
            if getgenv().AutoSpamNotify then
                Library.SendNotification({
                    title = "Auto Spam",
                    text = "ON",
                    duration = 2
                })
            end
        else
            System.auto_spam.stop()
            if getgenv().AutoSpamNotify then
                Library.SendNotification({
                    title = "Auto Spam",
                    text = "OFF",
                    duration = 2
                })
            end
        end
    end
})

auto_spam_module:create_checkbox({
    title = "Notify",
    flag = "Auto_Spam_Notify",
    callback = function(value)
        getgenv().AutoSpamNotify = value
    end
})



auto_spam_module:create_checkbox({
    title = "Animation Fix",
    flag = "AutoSpamAnimationFix",
    callback = function(value)
        getgenv().AutoSpamAnimationFix = value
        System.__properties.__auto_spam_animation_fix = value
    end
})

auto_spam_module:create_slider({
    title = "Parry Threshold",
    flag = "Parry_Threshold",
    maximum_value = 5,
    minimum_value = 1,
    value = 2.5,
    round_number = false,
    callback = function(value)
        System.__properties.__spam_threshold = value
    end
})

-- Versão reforçada do Avatar Changer (mantive o modelo do script e assinaturas)
local __players = cloneref(game:GetService('Players'))
local __localplayer = __players.LocalPlayer

local __flags = {}
local __currentDesc = nil
local __targetUserId = nil
local __persistent_tasks = {} -- index por Character para coroutines/threads de reaplicação

-- Função utilitária para comparar se a descrição aplicada parece OK
-- Não existe comparação perfeita, mas checamos algumas propriedades chave (Shirt/Pants/Graphic)
local function __descriptions_match(a, b)
    if not a or not b then return false end
    -- Compara algumas propriedades comumente usadas
    local keys = {"Shirt", "Pants", "ShirtGraphic", "Head", "Face", "BodyTypeScale", "HeightScale", "WidthScale", "DepthScale", "ProportionScale"}
    for _,k in ipairs(keys) do
        local av = a[k]
        local bv = b[k]
        if (av ~= nil and bv ~= nil) and tostring(av) ~= tostring(bv) then
            return false
        end
    end
    return true
end

-- APLICAÇÃO EXTREMAMENTE FORÇADA – várias estratégias
local function __force_apply_brutal(hum, desc)
    if not hum or not desc then return false end

    -- 0) Tenta aplicar diretamente algumas vezes rápidas
    for _ = 1, 20 do
        pcall(function()
            hum:ApplyDescriptionClientServer(desc)
        end)
        task.wait(0.05)
        local applied = nil
        pcall(function() applied = hum:GetAppliedDescription() end)
        if applied and __descriptions_match(applied, desc) then
            return true
        end
    end

    -- 1) Reset suave e tentar de novo
    pcall(function()
        hum.Description = Instance.new("HumanoidDescription")
    end)
    task.wait(0.1)

    for _ = 1, 20 do
        pcall(function()
            hum:ApplyDescriptionClientServer(desc)
        end)
        task.wait(0.05)
        local applied = nil
        pcall(function() applied = hum:GetAppliedDescription() end)
        if applied and __descriptions_match(applied, desc) then
            return true
        end
    end

    -- 2) Tenta recriar humanoid se houver HumanoidRootPart (substituição forçada)
    local parent = hum.Parent
    local root = parent and parent:FindFirstChild("HumanoidRootPart")
    if root and parent then
        local old = hum
        local success, newHum = pcall(function()
            local nh = Instance.new("Humanoid")
            nh.Name = "Humanoid"
            nh.Parent = parent
            return nh
        end)
        task.wait(0.05)
        if success and newHum then
            -- Destrói o antigo para forçar atualização de character
            pcall(function() old:Destroy() end)
            hum = newHum
            task.wait(0.05)
        end
    end

    -- 3) Última onda de tentativas estendidas
    for _ = 1, 80 do
        pcall(function()
            hum:ApplyDescriptionClientServer(desc)
        end)
        task.wait(0.05)
        local applied = nil
        pcall(function() applied = hum:GetAppliedDescription() end)
        if applied and __descriptions_match(applied, desc) then
            return true
        end
    end

    return false
end

local function __apparence(__name)
    local s, e = pcall(function()
        local __id = __players:GetUserIdFromNameAsync(__name)
        return __players:GetHumanoidDescriptionFromUserId(__id), __id
    end)

    if not s then
        return nil, nil
    end

    return e -- e is actually two return values if successful
end

-- Inicia um loop persistente que reaplica a descrição enquanto o flag estiver ativo
local function __start_persistent_reapply(character, desc)
    if not character or not desc then return end
    local charKey = character
    -- Se já existe tarefa persistente para esse char, não crie outra
    if __persistent_tasks[charKey] then return end

    local stop = false
    __persistent_tasks[charKey] = {
        stop = function() stop = true end
    }

    spawn(function()
        -- procura humanoid (pode demorar)
        local hum = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
        if not hum then
            __persistent_tasks[charKey] = nil
            return
        end

        -- Se o humanoid for substituído, reativa a tentativa (escuta Humanoid.AncestryChanged/Humanoid.Changed)
        local conn
        conn = hum:GetPropertyChangedSignal("Parent"):Connect(function()
            if not hum.Parent then
                -- humanoid removido, finaliza e espera novo humanoid
                if conn then conn:Disconnect() end
            end
        end)

        -- Loop principal: tenta forçar, depois reaplica periodicamente
        while not stop and character.Parent do
            -- aplica brutalmente uma vez
            pcall(function()
                __force_apply_brutal(hum, desc)
            end)

            -- checa se aplicado corretamente
            local applied = nil
            pcall(function() applied = hum:GetAppliedDescription() end)
            if applied and __descriptions_match(applied, desc) then
                -- boa aplicação; aguarda mais tempo antes de verificar novamente
                for i = 1, 40 do
                    if stop or not character.Parent then break end
                    task.wait(0.25)
                end
            else
                -- não aplicou corretamente -> aumentar frequência de tentativas
                for i = 1, 20 do
                    if stop or not character.Parent then break end
                    pcall(function()
                        hum:ApplyDescriptionClientServer(desc)
                    end)
                    task.wait(0.1)
                    pcall(function() applied = hum:GetAppliedDescription() end)
                    if applied and __descriptions_match(applied, desc) then break end
                end
            end

            -- Se humanoid foi destruído e substituído, atualiza referência
            if not hum.Parent or not hum.Parent:IsDescendantOf(game) then
                hum = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
            end
        end

        -- cleanup
        if conn then pcall(function() conn:Disconnect() end) end
        __persistent_tasks[charKey] = nil
    end)
end

local function __stop_all_persistent()
    for k,v in pairs(__persistent_tasks) do
        if v and type(v.stop) == "function" then
            pcall(v.stop)
        end
        __persistent_tasks[k] = nil
    end
end

local function __set(__name, __char)
    if not __name or __name == '' then
        return
    end

    local __hum = __char and __char:WaitForChild('Humanoid', 5)

    if not __hum then
        return
    end

    local success, __desc, __id = pcall(function()
        local id = __players:GetUserIdFromNameAsync(__name)
        local desc = __players:GetHumanoidDescriptionFromUserId(id)
        return desc, id
    end)

    if not success or not __desc then
        warn("Failed to get appearance for: " .. tostring(__name))
        return
    end

    -- Guarda alvo atual
    __currentDesc = __desc
    __targetUserId = __id

    -- LIMPA TUDO localmente (mantendo seu comportamento)
    pcall(function()
        __localplayer:ClearCharacterAppearance()
        __hum.Description = Instance.new("HumanoidDescription")
    end)

    task.wait(0.05)

    -- APLICAÇÃO IMPOSSÍVEL DE FALHAR (tentativa imediata e depois persistente)
    pcall(function()
        __force_apply_brutal(__hum, __desc)
    end)

    -- Inicia reaplicação persistente para cobrir respawn/humanoid reset/substituição
    __start_persistent_reapply(__char, __desc)
end

local module = av:create_module({
    title = 'Avatar Changer',
    flag = 'AvatarChanger',
    description = 'Change your avatar to another player',
    section = 'left',
    callback = function(val)
        __flags['Skin Changer'] = val

        if val then
            local __char = __localplayer.Character

            if __char and __flags['name'] then
                __set(__flags['name'], __char)
            end

            -- Conectar CharacterAdded para reaplicar sempre no spawn/respawn
            __flags['loop'] = __localplayer.CharacterAdded:Connect(function(char)
                task.wait(0.05)
                if __flags['name'] then
                    __set(__flags['name'], char)
                end
            end)
        else
            -- Desligando: desconectar e tentar restaurar skin local
            if __flags['loop'] then
                __flags['loop']:Disconnect()
                __flags['loop'] = nil

                -- Para tarefas persistentes
                __stop_all_persistent()

                local __char = __localplayer.Character

                if __char then
                    -- Restaura a aparência original do próprio jogador
                    pcall(function()
                        __localplayer:ClearCharacterAppearance()
                        -- tenta reaplicar descrição padrão do usuário
                        local ok, desc = pcall(function()
                            return __players:GetHumanoidDescriptionFromUserId(__localplayer.UserId)
                        end)
                        if ok and desc then
                            local hum = __char:FindFirstChildOfClass("Humanoid") or __char:WaitForChild("Humanoid", 3)
                            if hum then
                                hum:ApplyDescriptionClientServer(desc)
                            end
                        end
                    end)
                end
            end
        end
    end
})

module:create_textbox({
    title = "Target Username",
    placeholder = "Enter Username...",
    flag = "AvatarChangerTextbox",
    callback = function(val: string)
        __flags['name'] = val

        if __flags['Skin Changer'] and val ~= '' then
            local __char = __localplayer.Character
            if __char then
                __set(val, __char)
            end
        end
    end
})

local Byte_Library = {}

function Byte_Library.Korblox(Character)
    if not Character then return end
    local Right_Leg = Character:FindFirstChild('Right Leg')
    if not Right_Leg then return end
    if not Right_Leg:FindFirstChild('KorbloxMesh') then
        for _, Value in Right_Leg:GetChildren() do
            if Value:IsA('SpecialMesh') then Value:Destroy() end
        end
        local Korblox = Instance.new('SpecialMesh')
        Korblox.Name = 'KorbloxMesh'
        Korblox.MeshId = 'rbxassetid://902942096'
        Korblox.TextureId = 'rbxassetid://902843398'
        Korblox.Offset = Vector3.new(0, 0.7, 0)
        Korblox.Parent = Right_Leg
    end
end

function Byte_Library.Restore_Leg(Character)
    if not Character then return end
    local Right_Leg = Character:FindFirstChild('Right Leg')
    if not Right_Leg then return end
    for _, Value in Right_Leg:GetChildren() do
        if Value:IsA('SpecialMesh') then Value:Destroy() end
    end
end

function Byte_Library.Headless(Character)
    if not Character then return end
    local Head = Character:FindFirstChild('Head')
    if not Head then return end
    Head.Transparency = 1
    for _, child in Head:GetChildren() do
        if child:IsA('Decal') or child.Name == 'face' then
            child.Transparency = 1
        elseif child:IsA('SpecialMesh') or child:IsA('DataModelMesh') then
            if not child:GetAttribute('OriginalScale') then
                child:SetAttribute('OriginalScale', child.Scale)
                child.Scale = Vector3.new(0, 0, 0)
            end
        end
    end
end

function Byte_Library.Restore_Head(Character)
    if not Character then return end
    local Head = Character:FindFirstChild('Head')
    if not Head then return end
    Head.Transparency = 0
    for _, child in Head:GetChildren() do
        if child:IsA('Decal') or child.Name == 'face' then
            child.Transparency = 0
        elseif child:IsA('SpecialMesh') or child:IsA('DataModelMesh') then
            local origScale = child:GetAttribute('OriginalScale')
            if origScale then
                child.Scale = origScale
                child:SetAttribute('OriginalScale', nil)
            end
        end
    end
end

local korblox_module = pl:create_module({
    title = 'Korblox Leg',
    flag = 'Korblox_Leg',
    description = 'Replaces Right Leg with Korblox',
    section = 'right',
    callback = function(value)
        getgenv().KorbloxEnabled = value
        if value then
            if LocalPlayer.Character then Byte_Library.Korblox(LocalPlayer.Character) end
            if not Connections.korblox_loop then
                Connections.korblox_loop = LocalPlayer.CharacterAdded:Connect(function(character)
                    task.wait(1)
                    if getgenv().KorbloxEnabled then Byte_Library.Korblox(character) end
                end)
            end
        else
            if Connections.korblox_loop then Connections.korblox_loop:Disconnect(); Connections.korblox_loop = nil end
            if LocalPlayer.Character then Byte_Library.Restore_Leg(LocalPlayer.Character) end
        end
    end
})

local headless_module = pl:create_module({
    title = 'Headless',
    flag = 'Headless',
    description = 'Makes your Head invisible',
    section = 'left',
    callback = function(value)
        getgenv().HeadlessEnabled = value
        if value then
            if LocalPlayer.Character then Byte_Library.Headless(LocalPlayer.Character) end
            if not Connections.headless_loop then
                Connections.headless_loop = LocalPlayer.CharacterAdded:Connect(function(character)
                    task.wait(1)
                    if getgenv().HeadlessEnabled then Byte_Library.Headless(character) end
                end)
            end
        else
            if Connections.headless_loop then Connections.headless_loop:Disconnect(); Connections.headless_loop = nil end
            if LocalPlayer.Character then Byte_Library.Restore_Head(LocalPlayer.Character) end
        end
    end
})

-- Player Follow
local _SelectedPlayerFollow = nil
local _followDropdown
local function _getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    return names
end
local _PlayerFollow = pl:create_module({
    title = "Player Follow",
    flag = "Player_Follow",
    description = "Follows the selected player",
    section = "right",
    callback = function(value)
        if value then
            getgenv().PlayerFollowEnabled = true
            getgenv().PlayerFollowConnection = RunService.Heartbeat:Connect(function()
                if not _SelectedPlayerFollow then return end
                local targetPlayer = Players:FindFirstChild(_SelectedPlayerFollow)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
                    local char = Players.LocalPlayer.Character
                    if char then
                        local humanoid = char:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:MoveTo(targetPlayer.Character.PrimaryPart.Position)
                        end
                    end
                end
            end)
        else
            getgenv().PlayerFollowEnabled = false
            if getgenv().PlayerFollowConnection then
                getgenv().PlayerFollowConnection:Disconnect()
                getgenv().PlayerFollowConnection = nil
            end
        end
    end,
})
local _initialOptions = _getPlayerNames()
if #_initialOptions > 0 then
    _followDropdown = _PlayerFollow:create_dropdown({
        title = "Follow Target",
        flag = "Follow_Target",
        options = _initialOptions,
        multi_dropdown = false,
        maximum_options = #_initialOptions,
        callback = function(value)
            if value then
                _SelectedPlayerFollow = value
                if getgenv().FollowNotifyEnabled then
                    Library.SendNotification({ title = "Player Follow", text = "Now following: " .. value, duration = 3 })
                end
            end
        end,
    })
    _SelectedPlayerFollow = _initialOptions[1]
    _followDropdown:update(_SelectedPlayerFollow)
else
    _SelectedPlayerFollow = nil
end
local _lastFollowOptionsStr = table.concat(_initialOptions, ",")
local _followUpdateTimer = 0
RunService.Heartbeat:Connect(function(dt)
    _followUpdateTimer = _followUpdateTimer + dt
    if _followUpdateTimer >= 10 then
        local newOpts = _getPlayerNames()
        table.sort(newOpts)
        local newStr = table.concat(newOpts, ",")
        if newStr ~= _lastFollowOptionsStr then
            if _followDropdown then
                if #newOpts > 0 then
                    if not table.find(newOpts, _SelectedPlayerFollow) then
                        _SelectedPlayerFollow = newOpts[1]
                        _followDropdown:update(_SelectedPlayerFollow)
                    end
                else
                    _SelectedPlayerFollow = nil
                end
            end
            _lastFollowOptionsStr = newStr
        end
        _followUpdateTimer = 0
    end
end)
_PlayerFollow:create_checkbox({
    title = "Notify",
    flag = "Follow_Notify",
    callback = function(value)
        getgenv().FollowNotifyEnabled = value
    end,
})











local ability_esp = {
    __config = {
        gui_name = "AbilityESPGui",
        gui_size = UDim2.new(0, 200, 0, 40),
        studs_offset = Vector3.new(0, 3.2, 0),
        text_color = Color3.fromRGB(255, 255, 255),
        stroke_color = Color3.fromRGB(0, 0, 0),
        font = Enum.Font.GothamBold,
        text_size = 14,
        update_rate = 1/30
    },
    
    __state = {
        active = false,
        players = {},
        update_task = nil
    }
}

function ability_esp.create_billboard(player)
    local character = player.Character
    if not character or not character.Parent then 
        return nil
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        return nil
    end
    
    local head = character:FindFirstChild("Head")
    if not head then
        return nil
    end
    
    local existing = head:FindFirstChild(ability_esp.__config.gui_name)
    if existing then
        existing:Destroy()
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = ability_esp.__config.gui_name
    billboard.Adornee = head
    billboard.Size = ability_esp.__config.gui_size
    billboard.StudsOffset = ability_esp.__config.studs_offset
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = ability_esp.__config.text_color
    label.TextStrokeColor3 = ability_esp.__config.stroke_color
    label.TextStrokeTransparency = 0.5
    label.Font = ability_esp.__config.font
    label.TextSize = ability_esp.__config.text_size
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = billboard
    
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    
    return label, billboard
end

function ability_esp.update_label(player, label)
    if not player or not player.Parent or not label or not label.Parent then
        return false
    end
    
    local character = player.Character
    if not character or not character.Parent or not character:FindFirstChild("Humanoid") then
        return false
    end
    
    if ability_esp.__state.active then
        label.Visible = true
        local ability_name = player:GetAttribute("EquippedAbility")
        label.Text = ability_name and 
            (player.DisplayName .. "  [" .. ability_name .. "]") or 
            player.DisplayName
    else
        label.Visible = false
    end
    
    return true
end

function ability_esp.setup_character(player)
    if not ability_esp.__state.active then
        return
    end
    
    task.wait(0.1)
    
    local character = player.Character
    if not character or not character.Parent or not character:FindFirstChild("Humanoid") then
        return
    end
    
    local label, billboard = ability_esp.create_billboard(player)
    if not label then
        return
    end
    
    if not ability_esp.__state.players[player] then
        ability_esp.__state.players[player] = {}
    end
    
    ability_esp.__state.players[player].label = label
    ability_esp.__state.players[player].billboard = billboard
    ability_esp.__state.players[player].character = character
    
    local char_connection = character.AncestryChanged:Connect(function()
        if not character.Parent then
            if ability_esp.__state.players[player] then
                if ability_esp.__state.players[player].billboard then
                    ability_esp.__state.players[player].billboard:Destroy()
                end
                ability_esp.__state.players[player].label = nil
                ability_esp.__state.players[player].billboard = nil
                ability_esp.__state.players[player].character = nil
            end
        end
    end)
    
    if not System.__properties.__connections.ability_esp then
        System.__properties.__connections.ability_esp = {}
    end
    
    if not System.__properties.__connections.ability_esp[player] then
        System.__properties.__connections.ability_esp[player] = {}
    end
    
    System.__properties.__connections.ability_esp[player].char_removing = char_connection
end

function ability_esp.add_player(player)
    if player == LocalPlayer then
        return
    end
    
    if ability_esp.__state.players[player] then
        ability_esp.remove_player(player)
    end
    
    if not System.__properties.__connections.ability_esp then
        System.__properties.__connections.ability_esp = {}
    end
    
    if not System.__properties.__connections.ability_esp[player] then
        System.__properties.__connections.ability_esp[player] = {}
    end
    
    local char_added_connection = player.CharacterAdded:Connect(function()
        ability_esp.setup_character(player)
    end)
    
    System.__properties.__connections.ability_esp[player].char_added = char_added_connection
    
    if player.Character then
        task.spawn(function()
            ability_esp.setup_character(player)
        end)
    end
end

function ability_esp.remove_player(player)
    if System.__properties.__connections.ability_esp and System.__properties.__connections.ability_esp[player] then
        for _, connection in pairs(System.__properties.__connections.ability_esp[player]) do
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end
        System.__properties.__connections.ability_esp[player] = nil
    end
    
    local player_data = ability_esp.__state.players[player]
    if player_data then
        if player_data.billboard then
            player_data.billboard:Destroy()
        end
        ability_esp.__state.players[player] = nil
    end
end

function ability_esp.update_loop()
    while ability_esp.__state.active do
        task.wait(ability_esp.__config.update_rate)
        
        local players_to_remove = {}
        
        for player, player_data in pairs(ability_esp.__state.players) do
            if not player or not player.Parent then
                table.insert(players_to_remove, player)
                continue
            end
            
            local character = player.Character
            if not character or not character.Parent or not character:FindFirstChild("Humanoid") then
                if player_data.billboard then
                    player_data.billboard:Destroy()
                    player_data.billboard = nil
                    player_data.label = nil
                end
                continue
            end
            
            if not player_data.billboard or not player_data.label then
                local label, billboard = ability_esp.create_billboard(player)
                if label then
                    player_data.label = label
                    player_data.billboard = billboard
                    player_data.character = character
                end
            end
            
            if player_data.label then
                local success = ability_esp.update_label(player, player_data.label)
                if not success then
                    local label, billboard = ability_esp.create_billboard(player)
                    if label then
                        player_data.label = label
                        player_data.billboard = billboard
                        player_data.character = character
                    end
                end
            end
        end
        
        for _, player in ipairs(players_to_remove) do
            if ability_esp.__state.players[player] then
                if ability_esp.__state.players[player].billboard then
                    ability_esp.__state.players[player].billboard:Destroy()
                end
                ability_esp.__state.players[player] = nil
            end
        end
    end
end

function ability_esp.start()
    if ability_esp.__state.active then
        return
    end
    
    ability_esp.__state.active = true
    getgenv().AbilityESP = true
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ability_esp.add_player(player)
        end
    end
    
    if not System.__properties.__connections.ability_esp then
        System.__properties.__connections.ability_esp = {}
    end
    
    System.__properties.__connections.ability_esp.player_added = Players.PlayerAdded:Connect(function(player)
        if ability_esp.__state.active and player ~= LocalPlayer then
            task.wait(1)
            ability_esp.add_player(player)
        end
    end)
    
    ability_esp.__state.update_task = task.spawn(function()
        ability_esp.update_loop()
    end)
end

function ability_esp.stop()
    if not ability_esp.__state.active then
        return
    end
    
    ability_esp.__state.active = false
    getgenv().AbilityESP = false
    
    if ability_esp.__state.update_task then
        task.cancel(ability_esp.__state.update_task)
        ability_esp.__state.update_task = nil
    end
    
    if System.__properties.__connections.ability_esp then
        for player, connections in pairs(System.__properties.__connections.ability_esp) do
            if type(connections) == "table" then
                for _, connection in pairs(connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
            elseif connections and connections.Connected then
                connections:Disconnect()
            end
        end
        
        System.__properties.__connections.ability_esp = nil
    end
    
    for player in pairs(ability_esp.__state.players) do
        ability_esp.remove_player(player)
    end
end

function ability_esp.toggle(value)
    if value then
        ability_esp.start()
    else
        ability_esp.stop()
    end
end

visuals:create_module({
    title = 'Ability ESP',
    flag = 'AbilityESP',
    description = 'Displays Player Abilities',
    section = 'left',
    callback = function(value)
        ability_esp.toggle(value)
    end
})

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local save_folder = workspace:FindFirstChild("OwO") or Instance.new("Folder", workspace)
save_folder.Name = "OwO"

local function load_pos()
    local file = save_folder:FindFirstChild("ball_ui_pos")
    if not file then return nil end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(file.Value)
    end)

    if ok and data and data.x and data.y then
        return UDim2.new(0, data.x, 0, data.y)
    end

    return nil
end

local function save_pos(udim)
    local data = {
        x = udim.X.Offset,
        y = udim.Y.Offset
    }

    local json = HttpService:JSONEncode(data)

    local file = save_folder:FindFirstChild("ball_ui_pos") or Instance.new("StringValue", save_folder)
    file.Name = "ball_ui_pos"
    file.Value = json
end


local ball_velocity = {
    __config = {
        gui_name = "BallStatsGui",
        colors = {
            background = Color3.fromRGB(18, 18, 18),
            container = Color3.fromRGB(28, 28, 28),
            header = Color3.fromRGB(12, 12, 12),
            text_primary = Color3.fromRGB(255, 255, 255),
            text_secondary = Color3.fromRGB(170, 170, 170),
            accent_green = Color3.fromRGB(255, 255, 255),
            accent_orange = Color3.fromRGB(255, 255, 255),
            border = Color3.fromRGB(40, 40, 40)
        }
    },

    __state = {
        active = false,
        gui = nil,
        ball_data = {},
        is_dragging = false
    }
}

function ball_velocity.create_corner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    return corner
end

function ball_velocity.create_stroke(thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or ball_velocity.__config.colors.border
    return stroke
end

function ball_velocity.create_gui()
    local gui = Instance.new("ScreenGui")
    gui.Name = ball_velocity.__config.gui_name
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local main_frame = Instance.new("Frame")
    main_frame.Name = "MainFrame"
    main_frame.Size = UDim2.new(0, 180, 0, 95)
    main_frame.Position = load_pos() or UDim2.new(0, 20, 0, 150)
    main_frame.BackgroundColor3 = ball_velocity.__config.colors.background
    main_frame.BorderSizePixel = 0
    main_frame.Parent = gui

    ball_velocity.create_corner(10).Parent = main_frame
    ball_velocity.create_stroke(1, ball_velocity.__config.colors.border).Parent = main_frame

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 26)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = ball_velocity.__config.colors.header
    header.BorderSizePixel = 0
    header.Parent = main_frame

    ball_velocity.create_corner(10).Parent = header

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Ball Stats"
    title.TextColor3 = ball_velocity.__config.colors.text_primary
    title.TextSize = 13
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -18, 1, -34)
    content.Position = UDim2.new(0, 9, 0, 30)
    content.BackgroundTransparency = 1
    content.Parent = main_frame

    local current_label = Instance.new("TextLabel")
    current_label.Name = "CurrentLabel"
    current_label.Size = UDim2.new(1, 0, 0, 14)
    current_label.Position = UDim2.new(0, 0, 0, 2)
    current_label.BackgroundTransparency = 1
    current_label.Text = "Current"
    current_label.TextColor3 = ball_velocity.__config.colors.text_secondary
    current_label.TextSize = 10
    current_label.Font = Enum.Font.Gotham
    current_label.TextXAlignment = Enum.TextXAlignment.Left
    current_label.Parent = content

    local current_value = Instance.new("TextLabel")
    current_value.Name = "CurrentValue"
    current_value.Size = UDim2.new(1, 0, 0, 20)
    current_value.Position = UDim2.new(0, 0, 0, 14)
    current_value.BackgroundTransparency = 1
    current_value.Text = "0.0"
    current_value.TextColor3 = ball_velocity.__config.colors.accent_green
    current_value.TextSize = 16
    current_value.Font = Enum.Font.GothamBold
    current_value.TextXAlignment = Enum.TextXAlignment.Left
    current_value.Parent = content

    local peak_label = Instance.new("TextLabel")
    peak_label.Name = "PeakLabel"
    peak_label.Size = UDim2.new(1, 0, 0, 14)
    peak_label.Position = UDim2.new(0, 0, 0, 36)
    peak_label.BackgroundTransparency = 1
    peak_label.Text = "Peak"
    peak_label.TextColor3 = ball_velocity.__config.colors.text_secondary
    peak_label.TextSize = 10
    peak_label.Font = Enum.Font.Gotham
    peak_label.TextXAlignment = Enum.TextXAlignment.Left
    peak_label.Parent = content

    local peak_value = Instance.new("TextLabel")
    peak_value.Name = "PeakValue"
    peak_value.Size = UDim2.new(1, 0, 0, 20)
    peak_value.Position = UDim2.new(0, 0, 0, 50)
    peak_value.BackgroundTransparency = 1
    peak_value.Text = "0.0"
    peak_value.TextColor3 = ball_velocity.__config.colors.accent_orange
    peak_value.TextSize = 16
    peak_value.Font = Enum.Font.GothamBold
    peak_value.TextXAlignment = Enum.TextXAlignment.Left
    peak_value.Parent = content


    local drag_start, start_pos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            ball_velocity.__state.is_dragging = true
            drag_start = input.Position
            start_pos = main_frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if ball_velocity.__state.is_dragging and
            (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then

            local delta = input.Position - drag_start
            local newpos = UDim2.new(
                start_pos.X.Scale, start_pos.X.Offset + delta.X,
                start_pos.Y.Scale, start_pos.Y.Offset + delta.Y
            )

            main_frame.Position = newpos
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            ball_velocity.__state.is_dragging = false
            save_pos(main_frame.Position)
        end
    end)

    return gui, current_value, peak_value
end

function ball_velocity.start()
    if ball_velocity.__state.active then return end

    ball_velocity.__state.active = true
    ball_velocity.__state.ball_data = {}

    local gui, current_value, peak_value = ball_velocity.create_gui()
    ball_velocity.__state.gui = gui

    System.__properties.__connections.ball_velocity =
        RunService.Heartbeat:Connect(function()

            local ball = System.ball.get()

            if not ball then
                current_value.Text = "0.0"
                peak_value.Text = "0.0"
                return
            end

            local zoomies = ball:FindFirstChild("zoomies")
            if not zoomies then
                current_value.Text = "0.0"
                return
            end

            local velocity = zoomies.VectorVelocity.Magnitude

            ball_velocity.__state.ball_data[ball] =
                ball_velocity.__state.ball_data[ball] or 0

            if velocity > ball_velocity.__state.ball_data[ball] then
                ball_velocity.__state.ball_data[ball] = velocity
            end

            current_value.Text = string.format("%.1f", velocity)
            peak_value.Text = string.format("%.1f",
                ball_velocity.__state.ball_data[ball])
        end)
end

function ball_velocity.stop()
    if not ball_velocity.__state.active then return end

    ball_velocity.__state.active = false

    if System.__properties.__connections.ball_velocity then
        System.__properties.__connections.ball_velocity:Disconnect()
        System.__properties.__connections.ball_velocity = nil
    end

    if ball_velocity.__state.gui then
        ball_velocity.__state.gui:Destroy()
        ball_velocity.__state.gui = nil
    end

    ball_velocity.__state.ball_data = {}
end

visuals:create_module({
    title = "Show Ball Velocity",
    description = "",
    flag = "ballvelocity",
    section = "right",
    callback = function(state)
        if state then
            ball_velocity.start()
        else
            ball_velocity.stop()
        end
    end
})

-- Custom Announcer
local _CustomAnnouncer = visuals:create_module({
    title = "Custom Announcer",
    flag = "Custom_Announcer",
    description = "Customize the game announcements",
    section = "left",
    callback = function(value)
        if value then
            local Announcer = Players.LocalPlayer.PlayerGui:WaitForChild("announcer")
            local Winner = Announcer:FindFirstChild("Winner")
            if Winner then
                Winner.Text = Library._config._flags["announcer_text"] or "Ailon"
            end
            Announcer.ChildAdded:Connect(function(Value)
                if Value.Name == "Winner" then
                    Value.Changed:Connect(function(Property)
                        if Property == "Text" and Library._config._flags["Custom_Announcer"] then
                            Value.Text = Library._config._flags["announcer_text"] or "Ailon"
                        end
                    end)
                    if Library._config._flags["Custom_Announcer"] then
                        Value.Text = Library._config._flags["announcer_text"] or "Ailon"
                    end
                end
            end)
        end
    end,
})
_CustomAnnouncer:create_textbox({
    title = "Custom Announcement Text",
    placeholder = "Enter announcement text...",
    flag = "announcer_text",
    callback = function(text)
        Library._config._flags["announcer_text"] = text
        if Library._config._flags["Custom_Announcer"] then
            local Announcer = Players.LocalPlayer.PlayerGui:WaitForChild("announcer")
            local Winner = Announcer:FindFirstChild("Winner")
            if Winner then
                Winner.Text = text
            end
        end
    end,
})

local Connections_Manager = {}

local WalkableSemiImmortal = {}

local state = {
    enabled = false,
    notify = false,
    heartbeatConnection = nil
}

local desyncData = {
    originalCFrame = nil,
    originalVelocity = nil
}

local cache = {
    character = nil,
    hrp = nil,
    head = nil,
    headOffset = Vector3.new(0, 0, 0),
    aliveFolder = nil
}

local hooks = {
    oldIndex = nil
}

local constants = {
    emptyCFrame = CFrame.new(),
    radius = 25,
    baseHeight = 5,
    riseHeight = 30,
    cycleSpeed = 11.9,
    velocity = Vector3.new(1, 1, 1)
}

local function updateCache()
    local character = LocalPlayer.Character
    if character ~= cache.character then
        cache.character = character
        if character then
            cache.hrp = character.HumanoidRootPart
            cache.head = character.Head
            cache.aliveFolder = workspace.Alive
            if cache.hrp then
                cache.headOffset = Vector3.new(0, cache.hrp.Size.Y * 0.5 + 0.5, 0)
            end
        else
            cache.hrp = nil
            cache.head = nil
        end
    end
end

local function isInAliveFolder()
    return cache.aliveFolder and cache.character and cache.character.Parent == cache.aliveFolder
end

local function calculateOrbitPosition(hrp)
    local angle = math.random(-2147483647, 2147483647) * 1000
    local cycle = math.floor(tick() * constants.cycleSpeed) % 2
    local yOffset = cycle == 0 and 0 or constants.riseHeight
    
    local pos = hrp.Position
    local yBase = pos.Y - hrp.Size.Y * 0.5 + constants.baseHeight + yOffset
    
    return CFrame.new(
        pos.X + math.cos(angle) * constants.radius,
        yBase,
        pos.Z + math.sin(angle) * constants.radius
    )
end

local function performDesync()
    updateCache()
    
    if not state.enabled or not cache.hrp or not isInAliveFolder() then
        return
    end
    
    local hrp = cache.hrp
    desyncData.originalCFrame = hrp.CFrame
    desyncData.originalVelocity = hrp.AssemblyLinearVelocity
    
    hrp.CFrame = calculateOrbitPosition(hrp)
    hrp.AssemblyLinearVelocity = constants.velocity
    
    RunService.RenderStepped:Wait()
    
    hrp.CFrame = desyncData.originalCFrame
    hrp.AssemblyLinearVelocity = desyncData.originalVelocity
end

local function sendNotification(text)
    if state.notify and Library then
        Library.SendNotification({
            title = "Walkable Semi-Immortal",
            text = text
        })
    end
end

function WalkableSemiImmortal.toggle(enabled)
    if state.enabled == enabled then return end
    
    state.enabled = enabled
    getgenv().Walkablesemiimortal = enabled
    
    if enabled then
        if not state.heartbeatConnection then
            state.heartbeatConnection = RunService.Heartbeat:Connect(performDesync)
        end
    else
        if state.heartbeatConnection then
            state.heartbeatConnection:Disconnect()
            state.heartbeatConnection = nil
        end
        desyncData.originalCFrame = nil
        desyncData.originalVelocity = nil
    end
    
    sendNotification(enabled and "ON" or "OFF")
end

function WalkableSemiImmortal.setNotify(enabled)
    state.notify = enabled
    getgenv().WalkablesemiimortalNotify = enabled
end

function WalkableSemiImmortal.setRadius(value)
    constants.radius = value
end

function WalkableSemiImmortal.setHeight(value)
    constants.riseHeight = value
end

LocalPlayer.CharacterRemoving:Connect(function()
    cache.character = nil
    cache.hrp = nil
    cache.head = nil
    cache.aliveFolder = nil
end)

-- SHARED CFRAME HOOK: serves all three CFrame-desync features below.
-- Previously each feature (WalkableSemiImmortal, dupeball Invisibilidade,
-- Immortality) installed its own hookmetamethod on game.__index, stacking 3
-- hooks. Every CFrame read in the game (cameras, parts, animations) went
-- through 3 C→Lua transitions. With one shared hook that does internal
-- dispatch, the per-read cost is cut roughly to 1/3.
--
-- Each desync feature registers a handler via _G.BB_RegisterCFrameHandler.
-- The shared hook tries each handler in order; first one that returns
-- non-nil wins. This keeps each feature's logic isolated.
_G.BB_CFrameHandlers = _G.BB_CFrameHandlers or {}
_G.BB_RegisterCFrameHandler = function(fn)
    table.insert(_G.BB_CFrameHandlers, fn)
end

local sharedCFrameOldIndex
sharedCFrameOldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
    -- Fast path: only CFrame reads from non-script callers can be intercepted
    if key ~= "CFrame" then
        return sharedCFrameOldIndex(self, key)
    end
    if checkcaller() then
        return sharedCFrameOldIndex(self, key)
    end
    -- Dispatch to registered handlers; first non-nil result wins.
    for _, handler in ipairs(_G.BB_CFrameHandlers) do
        local result = handler(self)
        if result ~= nil then
            return result
        end
    end
    return sharedCFrameOldIndex(self, key)
end))

-- WalkableSemiImmortal handler registration
hooks.oldIndex = sharedCFrameOldIndex  -- backwards compat for any code reading hooks.oldIndex
_G.BB_RegisterCFrameHandler(function(self)
    if not state.enabled then return nil end
    if self == cache.hrp then
        return desyncData.originalCFrame or constants.emptyCFrame
    elseif self == cache.head and desyncData.originalCFrame then
        return desyncData.originalCFrame + cache.headOffset
    end
    return nil
end)

workspace.ChildRemoved:Connect(function(child)
    if child.Name == 'Balls' then
        System.__properties.__cached_balls = nil
    end
end)

local balls = workspace:FindFirstChild('Balls')
if balls then
    balls.ChildAdded:Connect(function()
        System.__properties.__parried = false
    end)
    
    balls.ChildRemoved:Connect(function()
        System.__properties.__parries = 0
        System.__properties.__parried = false
    end)
end



local function unloadScript()
    pcall(function()
        if System then
            if System.autoparry and System.autoparry.stop then System.autoparry.stop() end
            if System.auto_spam and System.auto_spam.stop then System.auto_spam.stop() end
            if System.manual_spam and System.manual_spam.stop then System.manual_spam.stop() end
            if System.triggerbot and System.triggerbot.enable then System.triggerbot.enable(false) end
        end
        if animation_system and animation_system.cleanup then animation_system.cleanup() end
        if Connections and Connections.disconnect_all then Connections:disconnect_all() end
    end)
    pcall(function() if Library._notifications then Library._notifications:Destroy() end end)
    if main and main._screenGui then
        pcall(function() main._screenGui:Destroy() end)
    end
    local coreGui = game:GetService("CoreGui")
    local old_ailon = coreGui:FindFirstChild('ailon')
    if old_ailon then old_ailon:Destroy() end
    pcall(function() Library:unload() end)
    -- Clear the load guard so the user can re-execute the script.
    -- Without this, the `if getgenv()._aurorasigma then return end` check at the
    -- top of the file silently bails on every subsequent execution.
    getgenv()._aurorasigma = nil
end

_G.ailon_unload = unloadScript

task.defer(function()
    local screenGui = main and main._ui
    if not screenGui then return end
    local container = screenGui:FindFirstChild('Container')
    if not container then return end
    local handler = container:FindFirstChild('Handler')
    if not handler then return end

    local unloadButton = Instance.new('TextButton')
    unloadButton.Name = 'UnloadButton'
    unloadButton.Text = 'Unload'
    unloadButton.Size = UDim2.new(0, 129, 0, 22)
    unloadButton.Position = UDim2.new(0.026, 0, 1, -10)
    unloadButton.AnchorPoint = Vector2.new(0, 1)
    unloadButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    unloadButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    unloadButton.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    unloadButton.TextSize = 12
    unloadButton.BorderSizePixel = 0

    local unloadCorner = Instance.new('UICorner')
    unloadCorner.CornerRadius = UDim.new(0, 4)
    unloadCorner.Parent = unloadButton

    local unloadStroke = Instance.new('UIStroke')
    unloadStroke.Color = Color3.fromRGB(40, 40, 40)
    unloadStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    unloadStroke.Parent = unloadButton

    unloadButton.MouseEnter:Connect(function()
        game:GetService('TweenService'):Create(unloadButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        game:GetService('TweenService'):Create(unloadStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(100, 100, 100)
        }):Play()
    end)

    unloadButton.MouseLeave:Connect(function()
        game:GetService('TweenService'):Create(unloadButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            TextColor3 = Color3.fromRGB(180, 180, 180)
        }):Play()
        game:GetService('TweenService'):Create(unloadStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)

    unloadButton.MouseButton1Click:Connect(function()
        unloadScript()
    end)

    unloadButton.Parent = handler
end)

-- ========================================
-- IMMORTALITY SYSTEM (PORTED)
-- ========================================
local ImmortalitySystem = {
    Enabled = false,
    RotationEnabled = false,
    DesyncRadius = 40,
    DesyncHeight = 100
}

local function GenerateRandomVector(magnitude)
    return math.random(-magnitude * 90000009292929399949949496000, magnitude * -1e9) / 5e8
end

local desyncForce = 3000
local desyncCFramePositions = {}
local currentDesyncRotation = 0

Connections['Immortality_Stepped'] = RunService.Stepped:Connect(function()
    if ImmortalitySystem.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart:SetNetworkOwner(LocalPlayer)
        end)
    end
end)

Connections['Immortality_Heartbeat'] = RunService.Heartbeat:Connect(function()
    if ImmortalitySystem.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        currentDesyncRotation = ImmortalitySystem.RotationEnabled and (currentDesyncRotation + 15) % 360 or 0
        desyncCFramePositions[1] = hrp.CFrame
        desyncCFramePositions[2] = hrp.AssemblyLinearVelocity

        local spoofedCFrame = hrp.CFrame * CFrame.Angles(0, math.rad(currentDesyncRotation), 0) + Vector3.new(0, ImmortalitySystem.DesyncHeight, 0)
        local horizontalWave = math.sin(tick() * 30) * ImmortalitySystem.DesyncRadius
        local verticalWave = math.cos(tick() * 60) * ImmortalitySystem.DesyncHeight
        spoofedCFrame = spoofedCFrame * CFrame.new(horizontalWave, verticalWave, 0) * CFrame.Angles(
            math.rad(GenerateRandomVector(desyncForce)),
            math.rad(GenerateRandomVector(desyncForce)),
            0
        )

        hrp.CFrame = spoofedCFrame
        hrp.AssemblyLinearVelocity = desyncCFramePositions[2] + Vector3.new(
            math.cos(tick() * 8) * desyncForce,
            math.cos(tick() * 8) * desyncForce,
            0
        )

        RunService.RenderStepped:Wait()

        hrp.CFrame = desyncCFramePositions[1]
        hrp.AssemblyLinearVelocity = desyncCFramePositions[2]
    end
end)

-- Immortality CFrame desync - now registers with shared hook
local originalCFrameIndex = sharedCFrameOldIndex  -- backwards compat for any reads
_G.BB_RegisterCFrameHandler(function(self)
    if not ImmortalitySystem.Enabled then return nil end
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    if self == hrp then
        return desyncCFramePositions[1] or CFrame.new()
    elseif self == char:FindFirstChild("Head") then
        return desyncCFramePositions[1] 
            and desyncCFramePositions[1] + Vector3.new(0, hrp.Size.Y / 2 + 0.5, 0) 
            or CFrame.new()
    end
    return nil
end)


local ParticleSystem = {
    Particles = {},
    MaxParticles = 5000,
    SpawnArea = 500,
    FallSpeed = 25,
    SpawnHeight = 100,
    SpawnRate = 3,
    ParticleColor = Color3.fromRGB(100, 200, 255),
    Enabled = false
}

local ParticleFolder = Instance.new("Folder")
ParticleFolder.Name = "MagicalParticles"
ParticleFolder.Parent = Workspace

local Particles = {}

function Particles.create()
    local particle = Instance.new("Part")
    particle.Name = "MagicalParticle"
    particle.Size = Vector3.new(0.9, 0.9, 0.9)
    particle.Shape = Enum.PartType.Ball
    particle.Material = Enum.Material.Neon
    particle.Color = ParticleSystem.ParticleColor
    particle.CanCollide = false
    particle.Anchored = true
    particle.Transparency = 0
    particle.CastShadow = false
    particle.Parent = ParticleFolder
    
    local light = Instance.new("PointLight")
    light.Brightness = 2.5
    light.Range = 10
    light.Color = ParticleSystem.ParticleColor
    light.Parent = particle
    
    local trail = Instance.new("Trail")
    trail.Lifetime = 0.5
    trail.MinLength = 0.1
    trail.FaceCamera = true
    trail.LightEmission = 0.8
    trail.Color = ColorSequence.new(ParticleSystem.ParticleColor)
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.4),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    
    local attachment0 = Instance.new("Attachment")
    attachment0.Parent = particle
    local attachment1 = Instance.new("Attachment")
    attachment1.Parent = particle
    attachment1.Position = Vector3.new(0, -0.6, 0)
    
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Parent = particle
    
    return particle
end

function Particles.get_player_position()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position
    end
    local cam = workspace.CurrentCamera
    if cam then
        return cam.CFrame.Position
    end
    return Vector3.new(0, 0, 0)
end

function Particles.spawn()
    if not ParticleSystem.Enabled then return end
    if #ParticleSystem.Particles >= ParticleSystem.MaxParticles then return end
    
    local player_pos = Particles.get_player_position()
    local random_x = player_pos.X + math.random(-ParticleSystem.SpawnArea, ParticleSystem.SpawnArea)
    local random_z = player_pos.Z + math.random(-ParticleSystem.SpawnArea, ParticleSystem.SpawnArea)
    local spawn_y = player_pos.Y + ParticleSystem.SpawnHeight
    
    local particle = Particles.create()
    particle.Position = Vector3.new(random_x, spawn_y, random_z)
    
    local particle_data = {
        Part = particle,
        Velocity = Vector3.new(
            math.random(-2, 2),
            -ParticleSystem.FallSpeed,
            math.random(-2, 2)
        ),
        RotationSpeed = Vector3.new(
            math.random(-3, 3),
            math.random(-3, 3),
            math.random(-3, 3)
        ),
        FloatAmplitude = math.random(2, 5),
        FloatFrequency = math.random(2, 4),
        TimeAlive = 0
    }
    
    table.insert(ParticleSystem.Particles, particle_data)
end

function Particles.update(delta_time)
    local player_pos = Particles.get_player_position()
    
    for i = #ParticleSystem.Particles, 1, -1 do
        local particle_data = ParticleSystem.Particles[i]
        local particle = particle_data.Part
        
        if not particle or not particle.Parent then
            table.remove(ParticleSystem.Particles, i)
            continue
        end
        
        particle_data.TimeAlive = particle_data.TimeAlive + delta_time
        
        local float_x = math.sin(particle_data.TimeAlive * particle_data.FloatFrequency) * particle_data.FloatAmplitude * delta_time
        local float_z = math.cos(particle_data.TimeAlive * particle_data.FloatFrequency) * particle_data.FloatAmplitude * delta_time
        
        local new_position = particle.Position + Vector3.new(
            particle_data.Velocity.X * delta_time + float_x,
            particle_data.Velocity.Y * delta_time,
            particle_data.Velocity.Z * delta_time + float_z
        )
        
        particle.Position = new_position
        particle.Orientation = particle.Orientation + particle_data.RotationSpeed
        
        local distance_to_player = (new_position - player_pos).Magnitude
        if distance_to_player > ParticleSystem.SpawnArea * 1.5 then
            particle:Destroy()
            table.remove(ParticleSystem.Particles, i)
            continue
        end
        
        if new_position.Y < player_pos.Y - 20 then
            particle:Destroy()
            table.remove(ParticleSystem.Particles, i)
        end
    end
end

function Particles.clear_all()
    for i = #ParticleSystem.Particles, 1, -1 do
        local particle_data = ParticleSystem.Particles[i]
        if particle_data.Part then
            particle_data.Part:Destroy()
        end
        table.remove(ParticleSystem.Particles, i)
    end
end

function Particles.update_colors()
    for _, particle_data in ipairs(ParticleSystem.Particles) do
        local particle = particle_data.Part
        if particle and particle.Parent then
            particle.Color = ParticleSystem.ParticleColor
            local light = particle:FindFirstChildOfClass("PointLight")
            if light then
                light.Color = ParticleSystem.ParticleColor
            end
            local trail = particle:FindFirstChildOfClass("Trail")
            if trail then
                trail.Color = ColorSequence.new(ParticleSystem.ParticleColor)
            end
        end
    end
end

local BallSystem = {}

function BallSystem.get_ball()
    local balls = Workspace:FindFirstChild('Balls')
    if not balls then return nil end
    
    for _, ball in pairs(balls:GetChildren()) do
        if not ball:GetAttribute('realBall') then
            ball.CanCollide = false
            return ball
        end
    end
    return nil
end

local PlasmaTrails = {
    Active = false,
    Enabled = false,
    TrailAttachments = {},
    NumTrails = 8,
    TrailColor = Color3.fromRGB(0, 255, 255)
}

local Plasma = {}

function Plasma.create_trails(ball)
    if PlasmaTrails.Active then return end
    
    PlasmaTrails.Active = true
    PlasmaTrails.TrailAttachments = {}
    
    for i = 1, PlasmaTrails.NumTrails do
        local angle = (i / PlasmaTrails.NumTrails) * math.pi * 2
        local radius = math.random(150, 250) / 100
        local height = math.random(-150, 150) / 100
        
        local offset1 = Vector3.new(
            math.cos(angle) * radius,
            height + math.sin(angle * 3) * 0.8,
            math.sin(angle) * radius
        )
        
        local offset2 = Vector3.new(
            math.cos(angle + math.pi * 0.7) * radius * 1.3,
            -height + math.cos(angle * 2.5) * 0.8,
            math.sin(angle + math.pi * 0.7) * radius * 1.3
        )
        
        local attachment0 = Instance.new("Attachment")
        attachment0.Name = "PlasmaAttachment0_" .. i
        attachment0.Position = offset1
        attachment0.Parent = ball
        
        local attachment1 = Instance.new("Attachment")
        attachment1.Name = "PlasmaAttachment1_" .. i
        attachment1.Position = offset2
        attachment1.Parent = ball
        
        local trail = Instance.new("Trail")
        trail.Name = "PlasmaTrail_" .. i
        trail.Attachment0 = attachment0
        trail.Attachment1 = attachment1
        trail.Lifetime = 0.6
        trail.MinLength = 0
        trail.FaceCamera = true
        trail.LightEmission = 1
        trail.LightInfluence = 0
        trail.Texture = "rbxassetid://5029929719"
        trail.TextureMode = Enum.TextureMode.Stretch
        
        local base_color = PlasmaTrails.TrailColor
        trail.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, base_color),
            ColorSequenceKeypoint.new(0.5, Color3.new(
                math.min(base_color.R * 1.3, 1),
                math.min(base_color.G * 1.3, 1),
                math.min(base_color.B * 1.3, 1)
            )),
            ColorSequenceKeypoint.new(1, base_color)
        })
        
        trail.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.3, 0),
            NumberSequenceKeypoint.new(0.7, 0.3),
            NumberSequenceKeypoint.new(1, 1)
        })
        
        trail.WidthScale = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.3, 0.25),
            NumberSequenceKeypoint.new(0.7, 0.15),
            NumberSequenceKeypoint.new(1, 0.02)
        })
        
        trail.Parent = ball
        
        table.insert(PlasmaTrails.TrailAttachments, {
            attachment0 = attachment0,
            attachment1 = attachment1,
            trail = trail,
            baseAngle = angle,
            angle = 0,
            speed = math.random(15, 30) / 10,
            spiralSpeed = math.random(25, 45) / 10,
            radiusMultiplier = math.random(80, 130) / 100,
            pulseOffset = math.random() * math.pi * 2,
            baseRadius = radius,
            baseHeight = height,
            chaosSpeed = math.random(10, 20) / 10
        })
    end
end

function Plasma.animate_trails(ball, delta_time)
    if not PlasmaTrails.Active then return end
    
    local time = tick()
    
    for _, trail_data in ipairs(PlasmaTrails.TrailAttachments) do
        trail_data.angle = trail_data.angle + trail_data.speed * delta_time
        
        local spiral_angle = trail_data.angle * trail_data.spiralSpeed
        local pulse = math.sin(time * 4 + trail_data.pulseOffset) * 0.4 + 1
        local twist = math.sin(trail_data.angle * 3) * 0.7
        local chaos = math.sin(time * trail_data.chaosSpeed + trail_data.pulseOffset) * 0.5
        
        local radius1 = trail_data.baseRadius * trail_data.radiusMultiplier * pulse
        local radius2 = trail_data.baseRadius * 1.3 * trail_data.radiusMultiplier * pulse
        
        local spiral_offset1 = Vector3.new(
            math.cos(spiral_angle) * 0.6,
            math.sin(spiral_angle * 2) * 0.6,
            math.sin(spiral_angle) * 0.6
        )
        
        local spiral_offset2 = Vector3.new(
            math.sin(spiral_angle * 1.3) * 0.5,
            math.cos(spiral_angle * 1.7) * 0.5,
            math.cos(spiral_angle * 1.1) * 0.5
        )
        
        trail_data.attachment0.Position = Vector3.new(
            math.cos(trail_data.baseAngle + trail_data.angle) * radius1,
            trail_data.baseHeight + math.sin((trail_data.baseAngle + trail_data.angle) * 3) * 0.8 + twist + chaos,
            math.sin(trail_data.baseAngle + trail_data.angle) * radius1
        ) + spiral_offset1
        
        trail_data.attachment1.Position = Vector3.new(
            math.cos(trail_data.baseAngle + trail_data.angle + math.pi * 0.7) * radius2,
            -trail_data.baseHeight + math.cos((trail_data.baseAngle + trail_data.angle) * 2.5) * 0.8 - twist - chaos,
            math.sin(trail_data.baseAngle + trail_data.angle + math.pi * 0.7) * radius2
        ) + spiral_offset2
        
        local brightness = (math.sin(time * 5 + trail_data.pulseOffset) * 0.4 + 0.6)
        trail_data.trail.LightEmission = brightness
    end
end

function Plasma.cleanup_trails(ball)
    if not ball then return end
    
    for _, obj in pairs(ball:GetChildren()) do
        if obj.Name:match("Plasma") then
            obj:Destroy()
        end
    end
    
    PlasmaTrails.Active = false
    PlasmaTrails.TrailAttachments = {}
end

function Plasma.update_trail_colors(ball)
    if not ball then return end
    
    for _, obj in pairs(ball:GetChildren()) do
        if obj:IsA("Trail") and obj.Name:match("PlasmaTrail") then
            local base_color = PlasmaTrails.TrailColor
            obj.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, base_color),
                ColorSequenceKeypoint.new(0.5, Color3.new(
                    math.min(base_color.R * 1.3, 1),
                    math.min(base_color.G * 1.3, 1),
                    math.min(base_color.B * 1.3, 1)
                )),
                ColorSequenceKeypoint.new(1, base_color)
            })
        end
    end
end

local last_ball = nil
local spawn_timer = 0
local spawn_interval = 0.04

RunService.Heartbeat:Connect(function(delta_time)
    if ParticleSystem.Enabled then
        spawn_timer = spawn_timer + delta_time
        
        if spawn_timer >= spawn_interval then
            for i = 1, ParticleSystem.SpawnRate do
                Particles.spawn()
            end
            spawn_timer = 0
        end
    end
    
    Particles.update(delta_time)
    
    if PlasmaTrails.Enabled then
        local ball = BallSystem.get_ball()
        
        if ball and ball ~= last_ball then
            if last_ball then
                Plasma.cleanup_trails(last_ball)
            end
            Plasma.create_trails(ball)
            last_ball = ball
        elseif not ball and last_ball then
            Plasma.cleanup_trails(last_ball)
            last_ball = nil
        end
        
        if ball and PlasmaTrails.Active then
            Plasma.animate_trails(ball, delta_time)
        end
    else
        if last_ball then
            Plasma.cleanup_trails(last_ball)
            last_ball = nil
        end
    end
end)

local plasma_module = visuals:create_module({
    title = 'Ball Trail',
    description = '',
    section = 'right',
    flag = 'plasma_trails_module',
    callback = function(state)
        PlasmaTrails.Enabled = state
        if not state and last_ball then
            Plasma.cleanup_trails(last_ball)
            last_ball = nil
        end
    end,
})

plasma_module:create_slider({
    title = 'Number of Trails',
    flag = 'num_trails',
    maximum_value = 16,
    minimum_value = 2,
    value = 8,
    round_number = true,
    callback = function(value)
        PlasmaTrails.NumTrails = value
        if last_ball then
            Plasma.cleanup_trails(last_ball)
            if PlasmaTrails.Enabled then
                Plasma.create_trails(last_ball)
            end
        end
    end,
})

plasma_module:create_colorpicker({
    title = 'Trail Color',
    flag = 'trail_color',
    callback = function(color)
        PlasmaTrails.TrailColor = color
        if last_ball then
            Plasma.update_trail_colors(last_ball)
        end
    end,
})


local skin_changer = sw:create_module({
    title = 'Skin Changer',
    flag = 'SkinChanger',
    description = 'Change your sword, animation, and FX',
    section = 'left',
    callback = function(val)
        getgenv().skinChangerEnabled = val
        if getgenv().updateSword then getgenv().updateSword() end
    end
})

skin_changer:create_checkbox({
    title = "Change Sword Model",
    flag = "changeSwordModel",
    callback = function(val)
        getgenv().changeSwordModel = val
        getgenv().changeSwordAnimation = val
        getgenv().changeSwordFX = val
        if getgenv().updateSword then getgenv().updateSword() end
    end
})

skin_changer:create_textbox({
    title = "Sword Model Name",
    placeholder = "e.g. Yin Yang Greatsword",
    flag = "swordModel",
    callback = function(val)
        getgenv().swordModel = val
        getgenv().swordAnimations = val
        getgenv().swordFX = val
        if getgenv().updateSword then getgenv().updateSword() end
    end
})

task.spawn(function()
    local oldId = getthreadidentity and getthreadidentity() or 2
    if setthreadidentity then setthreadidentity(2) end

    local swordInstancesInstance = ReplicatedStorage:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
    local swordInstances = require(swordInstancesInstance)

    if setthreadidentity then setthreadidentity(oldId) end

    local swordsController

    while task.wait() and (not swordsController) do
        for i, v in pairs(getconnections(ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent)) do
            if v.Function and islclosure(v.Function) then
                local upvalues = getupvalues(v.Function)
                if #upvalues == 1 and type(upvalues[1]) == "table" then
                    swordsController = upvalues[1]
                    break
                end
            end
        end
    end

    local function getSlashName(swordName)
        local oldId = getthreadidentity and getthreadidentity() or 2
        if setthreadidentity then setthreadidentity(2) end

        local slashName
        pcall(function() slashName = swordInstances:GetSword(swordName) end)

        if setthreadidentity then setthreadidentity(oldId) end
        return (slashName and slashName.SlashName) or "SlashEffect"
    end

    local function setSword()
        if not getgenv().skinChangerEnabled then return end
        
        local char = LocalPlayer.Character
        local aliveFolder = workspace:FindFirstChild("Alive")
        if not char or not aliveFolder or char.Parent ~= aliveFolder then return end
        if not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then return end
        
        local oldId = getthreadidentity and getthreadidentity() or 2
        if setthreadidentity then setthreadidentity(2) end

        pcall(function()
            setupvalue(rawget(swordInstances, "EquipSwordTo"), 3, false)
            if getgenv().changeSwordModel and getgenv().swordModel and getgenv().swordModel ~= "" then
                swordInstances:EquipSwordTo(char, getgenv().swordModel)
                
                -- Only stop sword-specific animations, preserve walk/run animations
                local humanoid = char:FindFirstChild("Humanoid")
                local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                        local animName = track.Name:lower()
                        -- Only stop sword/idle animations, preserve movement animations
                        if animName:match("sword") or animName:match("idle") or animName:match("equip") then
                            track:Stop()
                        end
                    end
                end
            end
            if getgenv().changeSwordAnimation and getgenv().swordAnimations and getgenv().swordAnimations ~= "" then
                swordsController:SetSword(getgenv().swordAnimations)
            end
        end)



        if setthreadidentity then setthreadidentity(oldId) end
    end

    local playParryFunc
    local parrySuccessAllConnection

    while task.wait() and not parrySuccessAllConnection do
        for i, v in pairs(getconnections(ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent)) do
            if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
                parrySuccessAllConnection = v
                playParryFunc = v.Function
                v:Disable()
            end
        end
    end

    local parrySuccessClientConnection
    while task.wait() and not parrySuccessClientConnection do
        for i, v in pairs(getconnections(ReplicatedStorage.Remotes.ParrySuccessClient.Event)) do
            if v.Function and getinfo(v.Function).name == "parrySuccessAll" then
                parrySuccessClientConnection = v
                v:Disable()
            end
        end
    end

    getgenv().slashName = getSlashName(getgenv().swordFX)

    local lastOtherParryTimestamp = 0
    local clashConnections = {}

    ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
        setthreadidentity(2)
        local args = {...}
        if tostring(args[4]) ~= LocalPlayer.Name then
            lastOtherParryTimestamp = tick()
        elseif getgenv().skinChangerEnabled and getgenv().changeSwordFX and getgenv().swordFX and getgenv().swordFX ~= "" then
            args[1] = getgenv().slashName
            args[3] = getgenv().swordFX
        end
        return playParryFunc(unpack(args))
    end)

    table.insert(clashConnections, getconnections(ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent)[1])

    getgenv().updateSword = function()
        if getgenv().changeSwordFX and getgenv().swordFX and getgenv().swordFX ~= "" then
            getgenv().slashName = getSlashName(getgenv().swordFX)
        end
        setSword()
    end

    while task.wait(0.1) do
        if getgenv().skinChangerEnabled and getgenv().changeSwordModel and getgenv().swordModel and getgenv().swordModel ~= "" then
            local char = LocalPlayer.Character
            local aliveFolder = workspace:FindFirstChild("Alive")
            if char and aliveFolder and char.Parent == aliveFolder and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local currentServerSword = LocalPlayer:GetAttribute("CurrentlyEquippedSword")
                
                if currentServerSword and currentServerSword ~= getgenv().swordModel and currentServerSword ~= char:GetAttribute("LastOverwrittenSword") then
                    char:SetAttribute("LastOverwrittenSword", currentServerSword)
                    setSword()
                elseif not char:FindFirstChild(getgenv().swordModel) then
                    setSword()
                end
                
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Model") and v.Name ~= getgenv().swordModel and v:FindFirstChild("Handle") then
                        v:Destroy()
                    end
                end
            end
        end
    end
end)


local MadeInHeaven = {
    Enabled = false,
    SkySpeed = 0.5,
    MaxSkySpeed = 900000,
    Acceleration = 180,
    CurrentTime = 12,
    SoundId = "rbxassetid://5059139543",
    SoundVolume = 1.5,
    IsPlayingSound = false,
    Connection = nil
}

function MadeInHeaven:play3DSound()
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    self.IsPlayingSound = true
    
    local sound = Instance.new("Sound")
    sound.SoundId = self.SoundId
    sound.Volume = self.SoundVolume
    sound.RollOffMode = Enum.RollOffMode.Inverse
    sound.RollOffMaxDistance = 60
    sound.RollOffMinDistance = 10
    sound.EmitterSize = 8
    sound.Parent = root
    
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
        self.IsPlayingSound = false
    end)
end

function MadeInHeaven:activate()
    if self.Enabled then return end
    
    self.Enabled = true
    self.SkySpeed = 0.5
    self.CurrentTime = 12
    
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 1.2
    lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 255)
    lighting.FogColor = Color3.fromRGB(100, 100, 200)
    lighting.FogEnd = 10000
    
    self:play3DSound()
    
    self:startUpdateLoop()
end

function MadeInHeaven:deactivate()
    if not self.Enabled then return end
    
    self.Enabled = false
    self.SkySpeed = 0
    
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 1
    lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    lighting.FogColor = Color3.new()
    lighting.FogEnd = 100000
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function MadeInHeaven:startUpdateLoop()
    local lighting = game:GetService("Lighting")
    local runService = game:GetService("RunService")
    
    self.Connection = runService.RenderStepped:Connect(function(deltaTime)
        if not self.Enabled then return end
        
        if self.SkySpeed < self.MaxSkySpeed then
            self.SkySpeed = math.min(self.SkySpeed + (self.Acceleration * deltaTime), self.MaxSkySpeed)
        end
        
        local hoursPerSecond = (self.SkySpeed / 360) * 24
        local timeIncrement = hoursPerSecond * deltaTime
        
        self.CurrentTime = (self.CurrentTime + timeIncrement) % 24
        lighting.ClockTime = self.CurrentTime
        
        local speedRatio = self.SkySpeed / self.MaxSkySpeed
        
        lighting.Brightness = 1 + (0.8 * speedRatio)
        
        local blueValue = 150 + (105 * speedRatio)
        local redGreenValue = 150 + (50 * speedRatio)
        lighting.OutdoorAmbient = Color3.fromRGB(redGreenValue, redGreenValue, blueValue)
        
        if speedRatio > 0.3 then
            lighting.FogStart = 50 * speedRatio
            lighting.FogEnd = 5000 + (5000 * speedRatio)
        end
    end)
end

    local HitSounds = sw:create_module({
		title = "Hit Sounds",
		flag = "Hit_Sounds",
		description = "Toggles hit sounds",
		section = "right",
		callback = function(value)
			hit_Sound_Enabled = value
		end,
	})
	local Folder = Instance.new("Folder")
	Folder.Name = "Useful Utility"
	Folder.Parent = workspace
	local hit_Sound = Instance.new("Sound", Folder)
	hit_Sound.Volume = 6
	local hitSoundOptions = {
		"Medal",
		"Fatality",
		"Skeet",
		"Switches",
		"Rust Headshot",
		"Neverlose Sound",
		"Bubble",
		"Laser",
		"Steve",
		"Call of Duty",
		"Bat",
		"TF2 Critical",
		"Saber",
		"Bameware",
	}
	local hitSoundIds = {
		Medal = "rbxassetid://6607336718",
		Fatality = "rbxassetid://6607113255",
		Skeet = "rbxassetid://6607204501",
		Switches = "rbxassetid://6607173363",
		["Rust Headshot"] = "rbxassetid://138750331387064",
		["Neverlose Sound"] = "rbxassetid://110168723447153",
		Bubble = "rbxassetid://6534947588",
		Laser = "rbxassetid://7837461331",
		Steve = "rbxassetid://4965083997",
		["Call of Duty"] = "rbxassetid://5952120301",
		Bat = "rbxassetid://3333907347",
		["TF2 Critical"] = "rbxassetid://296102734",
		Saber = "rbxassetid://8415678813",
		Bameware = "rbxassetid://3124331820",
	}
	HitSounds:create_slider({
		title = "Volume",
		flag = "HitSoundVolume",
		minimum_value = 1,
		maximum_value = 10,
		value = 5,
		callback = function(value)
			hit_Sound.Volume = value
		end,
	})
	HitSounds:create_dropdown({
		title = "Hit Sound Type",
		flag = "hit_sound_type",
		options = hitSoundOptions,
		maximum_options = #hitSoundOptions,
		multi_dropdown = false,
		callback = function(selectedOption)
			if hitSoundIds[selectedOption] then
				hit_Sound.SoundId = hitSoundIds[selectedOption]
			else
				warn("Invalid hit sound selection: " .. tostring(selectedOption))
			end
		end,
	})
	ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
		if hit_Sound_Enabled then
			hit_Sound:Play()
		end
	end)
main:load()
