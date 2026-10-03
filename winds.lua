-- Reuse a completed session instead of installing duplicate hooks/connections.
do
    local session = getgenv().WindsRecoveredSession
    if session and session.window and session.window._ui and session.window._ui.Parent then
        session.window._ui.Enabled = true
        session.window:change_visiblity(true)
        return
    end
end
-- Best-effort source reconstruction. See Reconstruction_Report.md.
-- Constants were inferred; game-dependent features require runtime validation.
local cloneref = cloneref or function(value) return value end
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")


											do
												loadstring([[    function LPH_NO_VIRTUALIZE(f) return f end;
    function LPH_JIT(f) return f end;
    function LPH_NO_UPVALUES(f) return f end;
    function LPH_JIT_MAX(f) return f end;
    function LPH_ENCSTR(s) return s end;
    function LPH_ENCFUNC(f) return f end;
]])()

												-- Removed unconditional 9999 FPS cap.

												do
													local gg = {
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
															Success = "Success",
														},
													}

													getgenv().GG = gg
												end
											end

											language = GG.Language

											convertStringToTable = function(arg)
												local tbl23 = {}

												for match in string.gmatch(arg, "([^,]+)") do
													local match2 = match:match("^%s*(.-)%s*$")
													table.insert(tbl23, match2)
												end

												return tbl23
											end

											convertTableToString = function(arg)
												return table.concat(arg, ", ")
											end

											if not isfolder then
												isfolder = function()
													return false
												end
											end

											if not makefolder then
												makefolder = function()
												end
											end

											if not writefile then
												writefile = function()
												end
											end

											if not readfile then
												readfile = function()
													return nil
												end
											end

											v92 = cloneref(game:GetService("UserInputService"))
											v93 = cloneref(game:GetService("ContentProvider"))
											v94 = cloneref(game:GetService("TweenService"))
											v89 = cloneref(game:GetService("HttpService"))
											v95 = cloneref(game:GetService("TextService"))
											v96 = cloneref(game:GetService("RunService"))
											v97 = cloneref(game:GetService("Lighting"))
											v98 = cloneref(game:GetService("Players"))
											v99 = cloneref(game:GetService("CoreGui"))
											v100 = cloneref(game:GetService("Debris"))
											mouse = v98.LocalPlayer:GetMouse()

											do
												local v101 = v99:FindFirstChild("Winds")

												if v101 then
													v100:AddItem(v101, 0)
												end
											end
-- Removed unmatched end from the supplied fragment.

										do
											local obj2, index2, instance

											do
												do
													if not isfolder("WindsRecovered") then
														makefolder("WindsRecovered")
													end

													getgenv()._WindsLoaded = true

													obj2 = setmetatable({
														disconnect = function(arg, arg2)
															if not arg[arg2] then
																return
															end
															arg[arg2]:Disconnect()
															arg[arg2] = nil
														end,
														disconnect_all = function(arg)
															for _, v101 in arg, nil, nil do
																local v102 = "function"

																if typeof(v101) ~= v102 then
																	v101:Disconnect()
																end
															end
														end,
													}, Connections)

													do
														local obj3 = setmetatable({
															map = function(arg, arg2, arg3, arg4, arg5, arg6)
																return (arg2 - arg3) * (arg6 - arg5) / (arg4 - arg3) + arg5
															end,
															viewport_point_to_world = function(arg, arg2, arg3)
																local v101 = workspace.CurrentCamera:ScreenPointToRay(arg2.X, arg2.Y)
																return v101.Origin + v101.Direction * arg3
															end,
															get_offset = function(arg)
																return arg:map(workspace.CurrentCamera.ViewportSize.Y, 0, 1080, 8, 56)
															end,
														}, Util)

														index2 = {}
														index2.__index = index2

														index2.new = function(arg)
															local obj4 = setmetatable({ _object = arg, _folder = nil, _frame = nil, _root = nil }, index2)
															obj4:setup()
															return obj4
														end

														index2.create_folder = function(arg)
															local v101 = workspace.CurrentCamera:FindFirstChild("Acrylic")

															if v101 then
																v100:AddItem(v101, 0)
															end

															local folder = Instance.new("Folder")
															folder.Name = "Acrylic"
															folder.Parent = workspace.CurrentCamera
															arg._folder = folder
														end

														index2.create_depth_of_fields = function()
															local acrylicBlur = v97:FindFirstChild("AcrylicBlur") or Instance.new("DepthOfFieldEffect")
															acrylicBlur.FarIntensity = 0
															acrylicBlur.FocusDistance = 0.05
															acrylicBlur.InFocusRadius = 0.1
															acrylicBlur.NearIntensity = 1
															acrylicBlur.Name = "AcrylicBlur"
															acrylicBlur.Parent = v97

															for _, v101 in v97:GetChildren() do
																if v101:IsA("DepthOfFieldEffect") then
																	if v101 ~= acrylicBlur then
																		obj2[v101] = v101:GetPropertyChangedSignal("FarIntensity"):Connect(function()
																			v101.FarIntensity = 0
																		end)

																		v101.FarIntensity = 0
																	end
																end
															end
														end

														index2.create_frame = function(arg)
															local frame = Instance.new("Frame")
															frame.Size = UDim2.new(1, 0, 1, 0)
															frame.Position = UDim2.new(0.5, 0, 0.5, 0)
															frame.AnchorPoint = Vector2.new(0.5, 0.5)
															frame.BackgroundTransparency = 1
															frame.Parent = arg._object
															arg._frame = frame
														end

														index2.create_root = function(arg)
															local part = Instance.new("Part")
															part.Name = "Root"
															part.Color = Color3.new(0, 0, 0)
															part.Material = Enum.Material.Glass
															part.Size = Vector3.new(1, 1, 0)
															part.Anchored = true
															part.CanCollide = false
															part.CanQuery = false
															part.Locked = true
															part.CastShadow = false
															part.Transparency = 0.98
															part.Parent = arg._folder
															local specialMesh = Instance.new("SpecialMesh")
															specialMesh.MeshType = Enum.MeshType.Brick
															specialMesh.Offset = Vector3.new(0, 0, -0.1)
															specialMesh.Parent = part
															arg._root = part
														end

														index2.setup = function(arg)
															arg:create_depth_of_fields()
															arg:create_folder()
															arg:create_root()
															arg:create_frame()
															arg:render(0.001)
															arg:check_quality_level()
														end

														index2.render = function(arg, arg2)
															local currentCamera = workspace.CurrentCamera
															local screenGui = arg._object:FindFirstAncestorWhichIsA("ScreenGui")
															local vector2 = Vector2.zero
															local vector22 = Vector2.zero
															local vector23 = Vector2.zero
															local flag21 = true

															local function fn32()
																return arg._root ~= nil and arg._object.Visible and (screenGui == nil or screenGui.Enabled)
															end

															local function fn33()
																if false then -- recovered opaque guard
																	error("Unreachable obfuscation trap")
																end

																local v101 = obj3:viewport_point_to_world(vector2, arg2)
																local v102 = obj3:viewport_point_to_world(vector22, arg2)
																local v103 = obj3:viewport_point_to_world(vector23, arg2)
																local magnitude = (v102 - v101).Magnitude
																local magnitude2 = (v102 - v103).Magnitude
																local cFrame = currentCamera.CFrame
																arg._root.CFrame = CFrame.fromMatrix((v101 + v103) / 2, cFrame.XVector, cFrame.YVector, cFrame.ZVector)
																arg._root.Mesh.Scale = Vector3.new(magnitude, magnitude2, 0)
															end

															local function fn34()
																local v101 = obj3:get_offset()
																local n = arg._frame.AbsoluteSize - Vector2.new(v101, v101)
																local n36 = arg._frame.AbsolutePosition + Vector2.new(v101 / 2, v101 / 2)
																vector2 = n36
																vector22 = n36 + Vector2.new(n.X, 0)
																vector23 = n36 + n
																flag21 = true
															end

															local function fn35()
																flag21 = true
															end

															obj2.cframe_update = currentCamera:GetPropertyChangedSignal("CFrame"):Connect(fn35)
															obj2.viewport_size_update = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn35)
															obj2.field_of_view_update = currentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(fn35)
															obj2.frame_absolute_position = arg._frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(fn34)
															obj2["frame_size_update"] = arg._frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn34)
															obj2.blur_render = v96.RenderStepped:Connect(function()
    if not arg._object.Parent then obj2:disconnect("blur_render"); return end
    if fn32() then
        if flag21 then fn33(); flag21 = false end
    end
end)
															fn34()
														end
													end
												end

												do
													index2.check_quality_level = function(arg)
														local gameSettings = UserSettings().GameSettings

														if gameSettings.SavedQualityLevel.Value < 8 then
															arg:change_visiblity(false)
														end

														obj2.quality_level = gameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function()
															arg:change_visiblity(UserSettings().GameSettings.SavedQualityLevel.Value >= 8)
														end)
													end

													index2.change_visiblity = function(arg, arg2)
														arg._root.Transparency = arg2 and 0.98 or 1
													end

													obj = setmetatable({
														save = function(arg, arg2, arg3)
															local ok, result = pcall(function()
																local json = v89:JSONEncode(arg3)
																writefile("WindsRecovered/" .. arg2 .. ".json", json)
															end)

															if not ok then
																warn("[Winds config]", result)
															end
														end,
														load = function(arg, arg2, arg3)
															local ok, result = pcall(function()
																if not isfile("WindsRecovered/" .. arg2 .. ".json") then
																	arg:save(arg2, arg3)
																	return
																end
																local v101 = readfile("WindsRecovered/" .. arg2 .. ".json")
																if not v101 then
																	arg:save(arg2, arg3)
																	return
																end
																return v89:JSONDecode(v101)
															end)

															if not ok then
																warn("failed to load config", result)
															end

															return result or { _flags = {}, _keybinds = {}, _library = {} }
														end,
													}, Config)

													index = {
														_config = obj:load(game.GameId),
														_choosing_keybind = false,
														_device = nil,
														_ui_open = true,
														_ui_scale = 1,
														_ui_loaded = false,
														_ui = nil,
														_dragging = false,
														_drag_start = nil,
														_container_position = nil,
													}

													index.__index = index
index._connections = obj2

													index.new = function()
														local obj3 = setmetatable({ _loaded = false, _tab = 0 }, index)
														obj3:create_ui()
														return obj3
													end

													index._all_modules = {}

													do
														local instance2 = Instance.new("ScreenGui")
														instance2.Name = "WindsNotifications"
														instance2.ResetOnSpawn = false
														instance2.IgnoreGuiInset = true
														instance2.ZIndexBehavior = Enum.ZIndexBehavior.Global
														instance2.Parent = v99
														instance = Instance.new("Frame")
														instance.Name = "Container"
														instance.Size = UDim2.new(0, 340, 1, -40)
														instance.Position = UDim2.new(0, 20, 1, -20)
														instance.AnchorPoint = Vector2.new(0, 1)
														instance.BackgroundTransparency = 1
														instance.ClipsDescendants = false
														instance.Parent = instance2
													end
												end

												do
													local uiListLayout = Instance.new("UIListLayout")
													uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
													uiListLayout.Padding = UDim.new(0, 12)
													uiListLayout.Parent = instance
												end
											end

											do
												local color = Color3.fromRGB(18, 18, 24)
												local color2 = Color3.fromRGB(42, 45, 65)
												local color3 = Color3.fromRGB(235, 235, 245)
												local color4 = Color3.fromRGB(160, 160, 180)
												Color3.fromRGB(139, 92, 246)
												Color3.fromRGB(167, 139, 250)

												index.SendNotification = function(arg)
													local instance2 = Instance.new("Frame")
													instance2.Size = UDim2.new(0, 240, 0, 48)
													instance2.BackgroundTransparency = 1
													instance2.Parent = instance
													local frame = Instance.new("Frame")
													frame.Size = UDim2.new(1, 0, 1, 0)
													frame.BackgroundColor3 = color
													frame.BackgroundTransparency = 0.05
													frame.BorderSizePixel = 0
													frame.Parent = instance2
													local uiCorner = Instance.new("UICorner")
													uiCorner.CornerRadius = UDim.new(0, 14)
													uiCorner.Parent = frame
													local uiStroke = Instance.new("UIStroke")
													uiStroke.Color = color2
													uiStroke.Transparency = 0.1
													uiStroke.Thickness = 1
													uiStroke.Parent = frame
													local instance3 = Instance.new("ImageLabel")
													instance3.BackgroundTransparency = 1
													instance3.Size = UDim2.new(0, 16, 0, 16)
													instance3.Position = UDim2.new(0, 14, 0.5, 0)
													instance3.AnchorPoint = Vector2.new(0, 0.5)
													instance3.Image = arg.icon or ""
													instance3.ImageColor3 = arg.iconColor or Color3.fromRGB(200, 200, 200)
													instance3.Parent = frame
													local textLabel = Instance.new("TextLabel")
													textLabel.Text = arg.title or "Notification"
													textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
													textLabel.TextSize = 13
													textLabel.TextColor3 = color3
													textLabel.BackgroundTransparency = 1
													textLabel.Position = UDim2.new(0, 44, 0, 8)
													textLabel.Size = UDim2.new(1, -56, 0, 16)
													textLabel.TextXAlignment = Enum.TextXAlignment.Left
													textLabel.TextTruncate = Enum.TextTruncate.AtEnd
													textLabel.Parent = frame
													local textLabel2 = Instance.new("TextLabel")
													textLabel2.Text = arg.text or ""
													textLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular)
													textLabel2.TextSize = 13
													textLabel2.TextColor3 = color4
													textLabel2.BackgroundTransparency = 1
													textLabel2.Position = UDim2.new(0, 44, 0, 24)
													textLabel2.Size = UDim2.new(1, -56, 0, 16)
													textLabel2.TextWrapped = false
													textLabel2.TextTruncate = Enum.TextTruncate.AtEnd
													textLabel2.TextXAlignment = Enum.TextXAlignment.Left
													textLabel2.Parent = frame
													frame.Position = UDim2.new(-1, 0, 0, 0)
													v94:Create(frame, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()

													task.delay(arg.duration or 5, function()
														v94:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(-1, 0, 0, 0), BackgroundTransparency = 1 }):Play()

														task.delay(0.3, function()
															instance2:Destroy()
														end)
													end)
												end
											end

											index.get_screen_scale = function(arg)
												arg._ui_scale = workspace.CurrentCamera.ViewportSize.X / 1920
											end

											index.get_device = function(arg)
												local device

												if not v92.TouchEnabled and v92.KeyboardEnabled and v92.MouseEnabled then
													device = "PC"
												elseif v92.TouchEnabled then
													device = "Mobile"
												else
													device = "Unknown"

													if v92.GamepadEnabled then
														device = "Console"
													end
												end

												arg._device = device
											end

											index.removed = function(arg, arg2)
												arg._ui.AncestryChanged:Once(arg2)
											end

											index.flag_type = function(arg, arg2, arg3)
												if not index._config._flags[arg2] then
													return
												end
												return typeof(index._config._flags[arg2]) == arg3
											end

											index.remove_table_value = function(arg, arg2, arg3)
												for k, v101 in arg2, nil, nil do
													if v101 == arg3 then
														table.remove(arg2, k)
													end
												end
											end

											index.create_ui = function(arg)
												local winds = v99:FindFirstChild("Winds")

												if winds then
													v100:AddItem(winds, 0)
												end

												local screenGui = Instance.new("ScreenGui")
												screenGui.ResetOnSpawn = false
												screenGui.Name = "Winds"
												screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
												screenGui.Parent = v99
												local frame = Instance.new("Frame")
												frame.ClipsDescendants = true
												frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
												frame.AnchorPoint = Vector2.new(0.5, 0.5)
												frame.Name = "Container"
												frame.BackgroundColor3 = Color3.fromRGB(12, 14, 16)
												frame.Position = UDim2.new(0.5, 0, 0.5, 0)
												frame.Size = UDim2.new(0, 0, 0, 0)
												frame.Active = true
												frame.BorderSizePixel = 0
												frame.Parent = screenGui
												local uiCorner = Instance.new("UICorner")
												uiCorner.CornerRadius = UDim.new(0, 16)
												uiCorner.Parent = frame
												local instance2 = Instance.new("Frame")
												instance2.BackgroundTransparency = 1
												instance2.Name = "Handler"
												instance2.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance2.Size = UDim2.new(0, 698, 0, 479)
												instance2.BorderSizePixel = 0
												instance2.ZIndex = 2
												instance2.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
												instance2.Parent = frame
												local frame2 = Instance.new("Frame")
												frame2.Name = "Search"
												frame2.Size = UDim2.new(0, 240, 0, 34)
												frame2.Position = UDim2.new(0, 180, 0, 12)
												frame2.AnchorPoint = Vector2.new(0, 0)
												frame2.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
												frame2.BackgroundTransparency = 0.1
												frame2.BorderSizePixel = 0
												frame2.Parent = instance2
												local uiCorner2 = Instance.new("UICorner")
												uiCorner2.CornerRadius = UDim.new(1, 0)
												uiCorner2.Parent = frame2
												local uiStroke = Instance.new("UIStroke")
												uiStroke.Color = Color3.fromRGB(38, 42, 58)
												uiStroke.Transparency = 0.5
												uiStroke.Parent = frame2
												local imageButton = Instance.new("ImageButton")
												imageButton.Size = UDim2.new(0, 18, 0, 18)
												imageButton.Position = UDim2.new(0, 8, 0.5, 0)
												imageButton.AnchorPoint = Vector2.new(0, 0.5)
												imageButton.ImageColor3 = Color3.fromRGB(139, 92, 246)
												imageButton.BackgroundTransparency = 1
												imageButton.Image = "rbxassetid://117707949657765"
												imageButton.Parent = frame2
												local textBox = Instance.new("TextBox")
												textBox.Size = UDim2.new(1, -44, 1, 0)
												textBox.Position = UDim2.new(0, 40, 0, 0)
												textBox.TextXAlignment = Enum.TextXAlignment.Left
												textBox.TextYAlignment = Enum.TextYAlignment.Center
												textBox.BackgroundTransparency = 1
												textBox.TextTransparency = 0
												textBox.PlaceholderText = "Search Functions.."
												textBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
												textBox.TextColor3 = Color3.fromRGB(235, 235, 245)
												textBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular)
												textBox.TextSize = 12
												textBox.ClearTextOnFocus = false
												textBox.Text = ""
												textBox.Parent = frame2
												local uiPadding = Instance.new("UIPadding")
												uiPadding.PaddingLeft = UDim.new(0, 2)
												uiPadding.Parent = textBox
												local v101 = nil

												local function fn32(arg2)
													local v102 = string.lower(arg2)
													if v102 == v101 then
														return
													end
													v101 = v102
													local flag21 = v102 == ""

													for _, allModule in ipairs(index._all_modules) do
														local visible = flag21 or string.find(allModule.title, v102, 1, true) ~= nil

														if allModule.frame.Visible ~= visible then
															allModule.frame.Visible = visible
														end
													end
												end

												textBox:GetPropertyChangedSignal("Text"):Connect(function()
													fn32(textBox.Text)
												end)

												local instance3 = Instance.new("ScrollingFrame")
												instance3.ScrollBarImageTransparency = 1
												instance3.ScrollBarThickness = 0
												instance3.Name = "Tabs"
												instance3.Size = UDim2.new(0, 129, 0, 401)
												instance3.Selectable = false
												instance3.AutomaticCanvasSize = Enum.AutomaticSize.XY
												instance3.BackgroundTransparency = 1
												instance3.Position = UDim2.new(0.03, 0, 0.16, 0)
												instance3.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance3.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
												instance3.BorderSizePixel = 0
												instance3.CanvasSize = UDim2.new(0, 0, 0.5, 0)
												instance3.Parent = instance2
												local frame3 = Instance.new("Frame")
												frame3.Name = "Divider"
												frame3.BackgroundTransparency = 0.5
												frame3.BorderSizePixel = 0
												frame3.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
												frame3.Position = UDim2.new(0.03, 0, 0.125, 0)
												frame3.Size = UDim2.new(0, 650, 0, 1)
												frame3.Parent = instance2
												local uiGradient = Instance.new("UIGradient")
												local numberSequence = NumberSequence.new
												local tbl23 = {}
												local v102 = NumberSequenceKeypoint.new(0, 1)
												local v103 = NumberSequenceKeypoint.new(0.58, 0)
												local new = NumberSequenceKeypoint.new
												tbl23[1] = v102
												tbl23[2] = v103

												do
													local values = table.pack(new(1, 1))
													table.move(values, 1, values.n, 3, tbl23)
												end

												uiGradient.Transparency = numberSequence(tbl23)
												uiGradient.Parent = frame3
												local frame4 = Instance.new("Frame")
												frame4.Name = "Divider"
												frame4.BackgroundTransparency = 0.5
												frame4.BorderSizePixel = 0
												frame4.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
												frame4.Position = UDim2.new(0, 0, 0.9, 0)
												frame4.Size = UDim2.new(0, 150, 0, 1)
												frame4.Parent = instance2
												frame4.Visible = false
												local uiGradient2 = Instance.new("UIGradient")
												local numberSequence2 = NumberSequence.new
												local tbl24 = {}
												local v104 = NumberSequenceKeypoint.new(0, 1)
												local v105 = NumberSequenceKeypoint.new(0.5, 0)
												local new2 = NumberSequenceKeypoint.new
												local v106 = 1
												tbl24[1] = v104
												tbl24[2] = v105

												do
													local values = table.pack(new2(1, v106))
													table.move(values, 1, values.n, 3, tbl24)
												end

												uiGradient2.Transparency = numberSequence2(tbl24)
												uiGradient2.Parent = frame4
												local instance4 = Instance.new("UIListLayout")
												instance4.Padding = UDim.new(0, 5)
												instance4.SortOrder = Enum.SortOrder.LayoutOrder
												instance4.Parent = instance3
												local instance5 = Instance.new("TextLabel")
												instance5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
												instance5.TextColor3 = Color3.fromRGB(139, 92, 246)
												instance5.TextTransparency = 0.20000000298023224
												instance5.Text = "Winds"
												instance5.Name = "ClientName"
												instance5.Size = UDim2.new(0, 30, 0, 13)
												instance5.AnchorPoint = Vector2.new(0, 0.5)
												instance5.Position = UDim2.new(0.03, 0, 0.054999999701976776, 0)
												instance5.BackgroundTransparency = 1
												instance5.TextXAlignment = Enum.TextXAlignment.Left
												instance5.BorderSizePixel = 0
												instance5.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance5.TextSize = 15
												instance5.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
												instance5.Parent = instance2
												local uiGradient3 = Instance.new("UIGradient")
												local colorSequence = ColorSequence.new
												local tbl25 = {}
												local v107 = ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246))
												local v108 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0))
												local new3 = ColorSequenceKeypoint.new
												local v109 = 1
												local color = Color3.fromRGB
												local v110 = 139
												tbl25[1] = v107
												tbl25[2] = v108

												do
													local values = table.pack(new3(v109, color(v110, 92, 246)))
													table.move(values, 1, values.n, 3, tbl25)
												end

												uiGradient3.Color = colorSequence(tbl25)
												uiGradient3.Offset = Vector2.new(-1, 0)
												uiGradient3.Parent = instance5
												local TweenService = game:GetService("TweenService")
												TweenService:Create(uiGradient3, TweenInfo.new(1.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), { Offset = Vector2.new(1, 0) }):Play()
												local instance6 = Instance.new("Frame")
												instance6.Name = "Pin"
												instance6.Position = UDim2.new(0.026000000536441803, 0, 0.135, 0)
												instance6.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance6.Size = UDim2.new(0, 2, 0, 16)
												instance6.BorderSizePixel = 0
												instance6.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
												instance6.Parent = instance2
												instance6.Visible = false
												local uiCorner3 = Instance.new("UICorner")
												uiCorner3.CornerRadius = UDim.new(0, 12)
												uiCorner3.Parent = instance6
												local instance7 = Instance.new("ImageLabel")
												instance7.ScaleType = Enum.ScaleType.Fit
												instance7.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance7.AnchorPoint = Vector2.new(0, 0.5)
												instance7.Image = "rbxassetid://87073625404390"
												instance7.BackgroundTransparency = 1
												instance7.Position = UDim2.new(0.82, 0, 0.054999999701976776, 0)
												instance7.Name = "Icon"
												instance7.Size = UDim2.new(0, 25, 0, 25)
												instance7.BorderSizePixel = 0
												instance7.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
												instance7.Parent = instance2
												instance7.ImageRectSize = Vector2.new(32, 32)
												local n = 0

												task.spawn(function()
													while instance7.Parent do
														if instance7.Visible then
															n = n % 10 + 1
															instance7.ImageRectOffset = Vector2.new((n - 1) * 32, 0)
														end

														task.wait(0.16666666666666666)
													end
												end)

												local folder = Instance.new("Folder")
												folder.Name = "Sections"
												folder.Parent = instance2
												local instance8 = Instance.new("TextButton")
												instance8.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
												instance8.TextColor3 = Color3.fromRGB(0, 0, 0)
												instance8.BorderColor3 = Color3.fromRGB(0, 0, 0)
												instance8.Text = ""
												instance8.AutoButtonColor = false
												instance8.Name = "Minimize"
												instance8.BackgroundTransparency = 1
												instance8.Position = UDim2.new(0.020057305693626404, 0, 0.885, 0)
												instance8.Size = UDim2.new(0, 24, 0, 24)
												instance8.BorderSizePixel = 0
												instance8.TextSize = 14
												instance8.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
												instance8.Parent = instance2
												local instance9 = Instance.new("Frame")
												instance9.Name = "PlayerCapsule"
												instance9.Size = UDim2.new(0, 140, 0, 40)
												instance9.AnchorPoint = Vector2.new(0, 1)
												instance9.Position = UDim2.new(0, 14, 1, -14)
												instance9.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
												instance9.BackgroundTransparency = 0.2
												instance9.BorderSizePixel = 0
												instance9.Parent = instance2
												local uiCorner4 = Instance.new("UICorner")
												uiCorner4.CornerRadius = UDim.new(1, 0)
												uiCorner4.Parent = instance9
												local instance10 = Instance.new("UIStroke")
												instance10.Color = Color3.fromRGB(55, 55, 60)
												instance10.Transparency = 0.65
												instance10.Thickness = 1
												instance10.Parent = instance9
												local imageLabel = Instance.new("ImageLabel")
												imageLabel.Size = UDim2.new(0, 30, 0, 30)
												imageLabel.Position = UDim2.new(0, 8, 0.5, 0)
												imageLabel.AnchorPoint = Vector2.new(0, 0.5)
												imageLabel.BackgroundTransparency = 1
												imageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

												task.spawn(function()
													local ok, image = pcall(function()
														return v98:GetUserThumbnailAsync(v98.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
													end)

													if ok then
														imageLabel.Image = image
													end
												end)

												imageLabel.Parent = instance9
												local uiCorner5 = Instance.new("UICorner")
												uiCorner5.CornerRadius = UDim.new(1, 0)
												uiCorner5.Parent = imageLabel
												local frame5 = Instance.new("Frame")
												frame5.Size = UDim2.new(1, -52, 1, 0)
												frame5.Position = UDim2.new(0, 46, 0, 0)
												frame5.BackgroundTransparency = 1
												frame5.Parent = instance9
												local textLabel = Instance.new("TextLabel")
												textLabel.Size = UDim2.new(1, 0, 0, 18)
												textLabel.Position = UDim2.new(0, 0, 0, 5)
												textLabel.BackgroundTransparency = 1
												textLabel.Text = v98.LocalPlayer.DisplayName or v98.LocalPlayer.Name
												textLabel.TextXAlignment = Enum.TextXAlignment.Left
												textLabel.TextYAlignment = Enum.TextYAlignment.Center
												textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
												textLabel.TextSize = 13
												textLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
												textLabel.Parent = frame5
												local textLabel2 = Instance.new("TextLabel")
												textLabel2.Size = UDim2.new(1, 0, 0, 14)
												textLabel2.Position = UDim2.new(0, 0, 0, 20)
												textLabel2.BackgroundTransparency = 1
												textLabel2.Text = "Customer"
												textLabel2.TextXAlignment = Enum.TextXAlignment.Left
												textLabel2.TextYAlignment = Enum.TextYAlignment.Center
												textLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular)
												textLabel2.TextSize = 11
												textLabel2.TextColor3 = Color3.fromRGB(160, 160, 165)
												textLabel2.Parent = frame5
												local RunService = game:GetService("RunService")
												local Stats = game:GetService("Stats")
												local frame6 = Instance.new("Frame")
												frame6.Name = "StatsCapsule"
												frame6.Size = UDim2.new(0, 150, 0, 32)
												frame6.AnchorPoint = Vector2.new(1, 0)
												frame6.Position = UDim2.new(1, -14, 0, 13)
												frame6.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
												frame6.BackgroundTransparency = 0.05
												frame6.BorderSizePixel = 0
												frame6.Parent = instance2
												Instance.new("UICorner", frame6).CornerRadius = UDim.new(1, 0)
												local instance11 = Instance.new("UIStroke", frame6)
												instance11.Color = Color3.fromRGB(55, 55, 60)
												instance11.Transparency = 0.65
												instance11.Thickness = 1
												local textLabel3 = Instance.new("TextLabel")
												textLabel3.BackgroundTransparency = 1
												textLabel3.Size = UDim2.new(1, -16, 1, 0)
												textLabel3.Position = UDim2.new(0, 8, 0, 0)
												textLabel3.TextXAlignment = Enum.TextXAlignment.Left
												textLabel3.TextYAlignment = Enum.TextYAlignment.Center
												textLabel3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
												textLabel3.TextSize = 12
												textLabel3.TextColor3 = Color3.fromRGB(230, 230, 235)
												textLabel3.Parent = frame6
												os.clock()
												local v111 = nil

												pcall(function()
													v111 = Stats.Network.ServerStatsItem["Data Ping"]
												end)

												do
    local elapsed, frames = 0, 0
    textLabel3.Text = "FPS -- | Ping --"
    obj2.performance_label = RunService.RenderStepped:Connect(function(dt)
        if not textLabel3.Parent then obj2:disconnect("performance_label"); return end
        elapsed += dt
        frames += 1
        if elapsed < 0.5 then return end
        local ping = 0
        if v111 then pcall(function() ping = v111:GetValue() end) end
        textLabel3.Text = string.format("%d FPS | %d ms", math.floor(frames / elapsed + 0.5), math.floor(ping + 0.5))
        elapsed, frames = 0, 0
    end)
end
												local uiScale = Instance.new("UIScale")
												uiScale.Parent = frame
												arg._ui = screenGui
screenGui.Destroying:Connect(function()
    obj2:disconnect_all()
end)
												local position = frame.Position
												local vector2 = Vector2.zero
												local v112 = nil
												local connection = nil
												local flag21 = false

												local function fn33()
													if connection then
														connection:Disconnect()
														connection = nil
													end

													v112 = nil
												end

												local function fn34(arg2)
													return arg2.UserInputState == Enum.UserInputState.End or arg2.UserInputState == Enum.UserInputState.Cancel
												end

												local function fn35()
													if not v112 then
														return
													end
													fn33()
													arg._dragging = false
												end

												local function fn36(arg2)
													fn33()
													v112 = arg2
													flag21 = arg2.UserInputType == Enum.UserInputType.Touch
													vector2 = Vector2.new(arg2.Position.X, arg2.Position.Y)
													position = frame.Position
													arg._dragging = false

													connection = arg2.Changed:Connect(function(arg3)
														if arg3 == "UserInputState" and fn34(arg2) then
															fn35()
														end
													end)
												end

												local function fn37(arg2)
													local vector22 = Vector2.new(arg2.Position.X - vector2.X, arg2.Position.Y - vector2.Y)

													if not arg._dragging then
														if vector22.Magnitude < 3 then
															return
														end
														arg._dragging = true
													end

													frame.Position = UDim2.new(position.X.Scale, position.X.Offset + vector22.X, position.Y.Scale, position.Y.Offset + vector22.Y)
												end

												local function fn38(input)
													if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
														fn36(input)
													end
												end

												local function fn39(input)
													if not v112 then
														return
													end

													if flag21 then
														if input == v112 then
															fn37(input)
														end
													elseif input.UserInputType == Enum.UserInputType.MouseMovement then
														fn37(input)
													end
												end

												obj2.container_input_began = frame.InputBegan:Connect(fn38)
												obj2.input_changed = v92.InputChanged:Connect(fn39)

												obj2["input_ended"] = v92.InputEnded:Connect(function(input)
													if not v112 then
														return
													end

													if input == v112 or not flag21 and input.UserInputType == Enum.UserInputType.MouseButton1 then
														fn35()
													end
												end)

												arg:removed(function()
													arg._ui = nil
													obj2:disconnect_all()
												end)

												arg.Update1Run = function(arg2, arg3)
													if arg3 == "nil" then
														frame.BackgroundTransparency = 0.05000000074505806
													else
														local v113 = 13

														if true then -- recovered opaque guard
															frame.BackgroundTransparency = tonumber(arg3)
														else
															error("Unreachable obfuscation trap")
														end
													end
												end

												arg.UIVisiblity = function()
													screenGui.Enabled = not screenGui.Enabled
												end

												arg.change_visiblity = function(arg2, arg3)
													if arg3 then
														TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(698, 479) }):Play()
													else
														TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(104.5, 52) }):Play()
													end
												end

												arg.load = function(arg2)
													arg2:get_device()

													if arg2._device == "Mobile" or arg2._device == "Unknown" then
														arg2:get_screen_scale()
														uiScale.Scale = arg2._ui_scale

														obj2.ui_scale = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
															arg2:get_screen_scale()
															uiScale.Scale = arg2._ui_scale
														end)
													end

													TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(698, 479) }):Play()
													index2.new(frame)
													arg2._ui_loaded = true

													task.spawn(function()
														local tbl26 = {}

														for _, v113 in screenGui:GetDescendants() do
															if v113:IsA("ImageLabel") then
																table.insert(tbl26, v113)
															end
														end

														pcall(function()
															v93:PreloadAsync(tbl26)
														end)
													end)
												end

												arg.update_tabs = function(arg2, arg3)
													for _, v113 in instance3:GetChildren() do
														if v113.Name == "Tab" then
															if v113 == arg3 then
																if v113.BackgroundTransparency ~= 0.5 then
																	local n36 = v113.LayoutOrder * 0.086923076923076922
																	TweenService:Create(instance6, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.fromScale(0.026, 0.135 + n36) }):Play()
																	TweenService:Create(v113, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 0.08 }):Play()
																	TweenService:Create(v113.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { TextTransparency = 0.2, TextColor3 = Color3.fromRGB(139, 92, 246) }):Play()
																	TweenService:Create(v113.TextLabel.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Offset = Vector2.new(1, 0) }):Play()
																	TweenService:Create(v113.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 0.2, ImageColor3 = Color3.fromRGB(139, 92, 246) }):Play()
																end
															elseif v113.BackgroundTransparency ~= 1 then
																TweenService:Create(v113, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()

																TweenService:Create(v113.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
																	TextTransparency = 0.3,
																	TextColor3 = Color3.fromRGB(235, 235, 245),
																}):Play()

																TweenService:Create(v113.TextLabel.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Offset = Vector2.new(0, 0) }):Play()
																TweenService:Create(v113.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 0.4, ImageColor3 = Color3.fromRGB(235, 235, 245) }):Play()
															end
														end
													end
												end

												arg.update_sections = function(arg2, arg3, arg4)
													if false then -- removed missing opaque flag guard
														return
													end

													for _, v113 in folder:GetChildren() do
														if v113 == arg3 or v113 == arg4 then
															v113.Visible = true
														else
															v113.Visible = false
														end
													end
												end

												arg.create_tab = function(arg2, text, image)
													local tbl26 = {}
													local instance12 = Instance.new("GetTextBoundsParams")
													instance12.Text = text
													instance12.Font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
													instance12.Size = 13
													instance12.Width = 10000
													local textBoundsAsync = v95:GetTextBoundsAsync(instance12)
													local flag22 = not instance3:FindFirstChild("Tab")
													local textButton = Instance.new("TextButton")
													textButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
													textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
													textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
													textButton.Text = ""
													textButton.AutoButtonColor = false
													textButton.BackgroundTransparency = 1
													textButton.Name = "Tab"
													textButton.Size = UDim2.new(0, 129, 0, 38)
													textButton.BorderSizePixel = 0
													textButton.TextSize = 14
													textButton.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
													textButton.Parent = instance3
													textButton.LayoutOrder = arg2._tab
													local instance13 = Instance.new("UICorner")
													instance13.CornerRadius = UDim.new(0, 6)
													instance13.Parent = textButton
													local textLabel4 = Instance.new("TextLabel")
													textLabel4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
													textLabel4.TextColor3 = Color3.fromRGB(235, 235, 245)
													textLabel4.TextTransparency = 0.3
													textLabel4.Text = text
													textLabel4.Size = UDim2.new(0, textBoundsAsync.X, 0, 16)
													textLabel4.AnchorPoint = Vector2.new(0, 0.5)
													textLabel4.Position = UDim2.new(0.26, 0, 0.5, 0)
													textLabel4.BackgroundTransparency = 1
													textLabel4.TextXAlignment = Enum.TextXAlignment.Left
													textLabel4.BorderSizePixel = 0
													textLabel4.BorderColor3 = Color3.fromRGB(0, 0, 0)
													textLabel4.TextSize = 13
													textLabel4.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
													textLabel4.Parent = textButton
													local uiGradient4 = Instance.new("UIGradient")
													local colorSequence2 = ColorSequence.new
													local tbl27 = {}
													local v113 = ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 235, 245))
													local v114 = ColorSequenceKeypoint.new(0.7, Color3.fromRGB(140, 150, 180))
													local new4 = ColorSequenceKeypoint.new
													local color2 = Color3.fromRGB
													local v115 = 48
													local v116 = 48
													tbl27[1] = v113
													tbl27[2] = v114

													do
														local values = table.pack(new4(1, color2(v115, v116, 58)))
														table.move(values, 1, values.n, 3, tbl27)
													end

													uiGradient4.Color = colorSequence2(tbl27)
													uiGradient4.Parent = textLabel4
													local instance14 = Instance.new("ImageLabel")
													instance14.ScaleType = Enum.ScaleType.Fit
													instance14.ImageTransparency = 0.3
													instance14.BorderColor3 = Color3.fromRGB(0, 0, 0)
													instance14.AnchorPoint = Vector2.new(0, 0.5)
													instance14.BackgroundTransparency = 1
													instance14.Position = UDim2.new(0.10000000149011612, 0, 0.5, 0)
													instance14.Name = "Icon"
													instance14.Image = image
													instance14.Size = UDim2.new(0, 12, 0, 14)
													instance14.BorderSizePixel = 0
													instance14.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
													instance14.Parent = textButton
													local scrollingFrame = Instance.new("ScrollingFrame")
													scrollingFrame.Name = "LeftSection"
													scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.XY
													scrollingFrame.ScrollBarThickness = 0
													scrollingFrame.Size = UDim2.new(0, 243, 0, 360)
													scrollingFrame.Selectable = false
													scrollingFrame.AnchorPoint = Vector2.new(0, 0)
													scrollingFrame.ScrollBarImageTransparency = 1
													scrollingFrame.BackgroundTransparency = 1
													scrollingFrame.Position = UDim2.new(0.235, 0, 0.16, 0)
													scrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
													scrollingFrame.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
													scrollingFrame.BorderSizePixel = 0
													scrollingFrame.CanvasSize = UDim2.new(0, 0, 0.5, 0)
													scrollingFrame.Visible = false
													scrollingFrame.Parent = folder
													local uiListLayout = Instance.new("UIListLayout")
													uiListLayout.Padding = UDim.new(0, 11)
													uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
													uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
													uiListLayout.Parent = scrollingFrame
													local instance15 = Instance.new("UIPadding")
													instance15.PaddingTop = UDim.new(0, 1)
													instance15.Parent = scrollingFrame
													local scrollingFrame2 = Instance.new("ScrollingFrame")
													scrollingFrame2.Name = "RightSection"
													scrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.XY
													scrollingFrame2.ScrollBarThickness = 0
													scrollingFrame2.Size = UDim2.new(0, 243, 0, 360)
													scrollingFrame2.Selectable = false
													scrollingFrame2.AnchorPoint = Vector2.new(0, 0)
													scrollingFrame2.ScrollBarImageTransparency = 1
													scrollingFrame2.BackgroundTransparency = 1
													scrollingFrame2.Position = UDim2.new(0.6, 0, 0.16, 0)
													scrollingFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
													scrollingFrame2.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
													scrollingFrame2.BorderSizePixel = 0
													scrollingFrame2.CanvasSize = UDim2.new(0, 0, 0.5, 0)
													scrollingFrame2.Visible = false
													scrollingFrame2.Parent = folder
													local uiListLayout2 = Instance.new("UIListLayout")
													uiListLayout2.Padding = UDim.new(0, 11)
													uiListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
													uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
													uiListLayout2.Parent = scrollingFrame2
													local uiPadding2 = Instance.new("UIPadding")
													uiPadding2.PaddingTop = UDim.new(0, 1)
													uiPadding2.Parent = scrollingFrame2
													arg2._tab = arg2._tab + 1

													if flag22 then
														arg2:update_tabs(textButton, scrollingFrame, scrollingFrame2)
														arg2:update_sections(scrollingFrame, scrollingFrame2)
													end

													textButton.MouseButton1Click:Connect(function()
														arg2:update_tabs(textButton, scrollingFrame, scrollingFrame2)
														arg2:update_sections(scrollingFrame, scrollingFrame2)
													end)

													tbl26.create_module = function(arg3, arg4)
														local v117 = 0
														local tbl28 = { _state = false, _size = 0, _multiplier = 0 }

														if arg4.section == "right" then
															arg4.section = scrollingFrame2
														else
															arg4.section = scrollingFrame
														end

														local instance16 = Instance.new("Frame")
														instance16.ClipsDescendants = true
														instance16.BorderColor3 = Color3.fromRGB(0, 0, 0)
														instance16.BackgroundTransparency = 0.7
														instance16.Position = UDim2.new(0.0041152262128889561, 0, 0, 0)
														instance16.Name = "Module"
														instance16.Size = UDim2.new(1, -8, 0, 93)
														instance16.BorderSizePixel = 0
														instance16.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
														instance16.Parent = arg4.section
														local uiListLayout3 = Instance.new("UIListLayout")
														uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
														uiListLayout3.Parent = instance16
														local instance17 = Instance.new("UICorner")
														instance17.CornerRadius = UDim.new(0, 8)
														instance17.Parent = instance16
														local uiStroke2 = Instance.new("UIStroke")
														uiStroke2.Color = Color3.fromRGB(38, 42, 58)
														uiStroke2.Transparency = 0.5
														uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
														uiStroke2.Parent = instance16
														local textButton2 = Instance.new("TextButton")
														textButton2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
														textButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
														textButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
														textButton2.Text = ""
														textButton2.AutoButtonColor = false
														textButton2.BackgroundTransparency = 1
														textButton2.Name = "Header"
														textButton2.Size = UDim2.new(1, 0, 0, 93)
														textButton2.BorderSizePixel = 0
														textButton2.TextSize = 14
														textButton2.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														textButton2.Parent = instance16
														table.insert(index._all_modules, { frame = instance16, title = string.lower(arg4.title or "") })
														local imageLabel2 = Instance.new("ImageLabel")
														imageLabel2.ImageColor3 = Color3.fromRGB(152, 181, 255)
														imageLabel2.ScaleType = Enum.ScaleType.Fit
														imageLabel2.BorderColor3 = Color3.fromRGB(139, 92, 246)
														imageLabel2.AnchorPoint = Vector2.new(0, 0.5)
														imageLabel2.Image = "rbxassetid://79095934438045"
														imageLabel2.BackgroundTransparency = 1
														imageLabel2.Position = UDim2.new(0.073, 0, 0.81999999284744263, 0)
														imageLabel2.Name = "Icon"
														imageLabel2.Size = UDim2.new(0, 10, 0, 10)
														imageLabel2.BorderSizePixel = 0
														imageLabel2.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														imageLabel2.Parent = textButton2
														imageLabel2.Visible = false
														local textLabel5 = Instance.new("TextLabel")
														textLabel5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
														textLabel5.TextColor3 = Color3.fromRGB(139, 92, 246)
														textLabel5.TextTransparency = 0.2

														if not arg4.rich then
															textLabel5.Text = arg4.title or "Skibidi"
														else
															textLabel5.RichText = true
															textLabel5.Text = arg4.richtext or "<font color='rgb(255,0,0)'>Winds</font> user"
														end

														textLabel5.Name = "ModuleName"
														textLabel5.Size = UDim2.new(0, 205, 0, 13)
														textLabel5.AnchorPoint = Vector2.new(0, 0.5)
														textLabel5.Position = UDim2.new(0.072999998927116394, 0, 0.22, 0)
														textLabel5.BackgroundTransparency = 1
														textLabel5.TextXAlignment = Enum.TextXAlignment.Left
														textLabel5.BorderSizePixel = 0
														textLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
														textLabel5.TextSize = 13
														textLabel5.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														textLabel5.Parent = textButton2
														local instance18 = Instance.new("TextLabel")
														instance18.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
														instance18.TextColor3 = Color3.fromRGB(139, 92, 246)
														instance18.TextTransparency = 0.69999998807907104
														instance18.Text = arg4.description
														instance18.Name = "Description"
														instance18.Size = UDim2.new(0, 205, 0, 13)
														instance18.AnchorPoint = Vector2.new(0, 0.5)
														instance18.Position = UDim2.new(0.072999998927116394, 0, 0.41999998688697815, 0)
														instance18.BackgroundTransparency = 1
														instance18.TextXAlignment = Enum.TextXAlignment.Left
														instance18.BorderSizePixel = 0
														instance18.BorderColor3 = Color3.fromRGB(0, 0, 0)
														instance18.TextSize = 10
														instance18.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														instance18.Parent = textButton2
														local instance19 = Instance.new("Frame")
														instance19.Name = "Toggle"
														instance19.BackgroundTransparency = 0.7
														instance19.Position = UDim2.new(0.073, 0, 0.72, 0)
														instance19.BorderColor3 = Color3.fromRGB(0, 0, 0)
														instance19.Size = UDim2.new(0, 25, 0, 12)
														instance19.BorderSizePixel = 0
														instance19.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
														instance19.Parent = textButton2
														local uiCorner6 = Instance.new("UICorner")
														uiCorner6.CornerRadius = UDim.new(0, 12)
														uiCorner6.Parent = instance19
														local instance20 = Instance.new("Frame")
														instance20.BorderColor3 = Color3.fromRGB(0, 0, 0)
														instance20.AnchorPoint = Vector2.new(0, 0.5)
														instance20.BackgroundTransparency = 0.20000000298023224
														instance20.Position = UDim2.new(0.1, 0, 0.5, 0)
														instance20.Name = "Circle"
														instance20.Size = UDim2.new(0, 8, 0, 8)
														instance20.BorderSizePixel = 0
														instance20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
														instance20.Parent = instance19
														local uiCorner7 = Instance.new("UICorner")
														uiCorner7.CornerRadius = UDim.new(0, 12)
														uiCorner7.Parent = instance20
														local instance21 = Instance.new("Frame")
														instance21.Name = "Keybind"
														instance21.BackgroundTransparency = 0.69999998807907104
														instance21.Position = UDim2.new(0.78, 0, 0.73500001430511475, 0)
														instance21.BorderColor3 = Color3.fromRGB(0, 0, 0)
														instance21.Size = UDim2.new(0, 33, 0, 15)
														instance21.BorderSizePixel = 0
														instance21.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
														instance21.Parent = textButton2
														local instance22 = Instance.new("UICorner")
														instance22.CornerRadius = UDim.new(0, 3)
														instance22.Parent = instance21
														local textLabel6 = Instance.new("TextLabel")
														textLabel6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
														textLabel6.TextColor3 = Color3.fromRGB(220, 222, 255)
														textLabel6.BorderColor3 = Color3.fromRGB(0, 0, 0)
														textLabel6.Text = "None"
														textLabel6.AnchorPoint = Vector2.new(0.5, 0.5)
														textLabel6.Size = UDim2.new(0, 25, 0, 13)
														textLabel6.BackgroundTransparency = 1
														textLabel6.TextXAlignment = Enum.TextXAlignment.Left
														textLabel6.Position = UDim2.new(0.5, 0, 0.5, 0)
														textLabel6.BorderSizePixel = 0
														textLabel6.TextSize = 10
														textLabel6.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														textLabel6.Parent = instance21
														local frame7 = Instance.new("Frame")
														frame7.BorderColor3 = Color3.fromRGB(0, 0, 0)
														frame7.AnchorPoint = Vector2.new(0.5, 0)
														frame7.BackgroundTransparency = 0.08
														frame7.Position = UDim2.new(0.5, 0, 0.62000000476837158, 0)
														frame7.Name = "Divider"
														frame7.Size = UDim2.new(0, 241, 0, 1)
														frame7.BorderSizePixel = 0
														frame7.BackgroundColor3 = Color3.fromRGB(38, 42, 58)
														frame7.Parent = textButton2
														local frame8 = Instance.new("Frame")
														frame8.BorderColor3 = Color3.fromRGB(0, 0, 0)
														frame8.AnchorPoint = Vector2.new(0.5, 0)
														frame8.BackgroundTransparency = 0.08
														frame8.Position = UDim2.new(0.5, 0, 1, 0)
														frame8.Name = "Divider"
														frame8.Size = UDim2.new(0, 207, 0, 1)
														frame8.BorderSizePixel = 0
														frame8.BackgroundColor3 = Color3.fromRGB(38, 42, 58)
														frame8.Parent = textButton2
														local frame9 = Instance.new("Frame")
														frame9.Name = "Options"
														frame9.BackgroundTransparency = 1
														frame9.Position = UDim2.new(0, 0, 1, 0)
														frame9.BorderColor3 = Color3.fromRGB(0, 0, 0)
														frame9.Size = UDim2.new(1, 0, 0, 8)
														frame9.BorderSizePixel = 0
														frame9.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
														frame9.Parent = instance16
														local uiPadding3 = Instance.new("UIPadding")
														uiPadding3.PaddingTop = UDim.new(0, 8)
														uiPadding3.Parent = frame9
														local uiListLayout4 = Instance.new("UIListLayout")
														uiListLayout4.Padding = UDim.new(0, 6)
														uiListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
														uiListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
														uiListLayout4.Parent = frame9

														tbl28.change_state = function(arg5, state)
															arg5._state = state

															if arg5._state then
																TweenService:Create(instance16, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 93 + arg5._size + arg5._multiplier) }):Play()
																TweenService:Create(instance19, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(99, 102, 241) }):Play()

																TweenService:Create(instance20, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
																	Size = UDim2.new(0, 8, 0, 8),
																	Position = UDim2.new(1, -13, 0.5, 0),
																	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
																}):Play()
															else
																TweenService:Create(instance16, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 93) }):Play()
																TweenService:Create(instance19, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play()

																TweenService:Create(instance20, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
																	Size = UDim2.new(0, 8, 0, 8),
																	Position = UDim2.new(0.1, 0, 0.5, 0),
																	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
																}):Play()
															end

															index._config._flags[arg4.flag] = arg5._state
															obj:save(game.GameId, index._config)
															arg4.callback(arg5._state)
														end

														tbl28.connect_keybind = function(arg5)
															if not index._config._keybinds[arg4.flag] then
																return
															end

															obj2[arg4.flag .. "_keybind"] = v92.InputBegan:Connect(function(input, gameProcessed)
																if gameProcessed then
																	return
																end
																local v118 = index._config._keybinds[arg4.flag]
																if tostring(input.KeyCode) ~= v118 then
																	return
																end
																arg5:change_state(not arg5._state)
															end)
														end

														tbl28.scale_keybind = function(arg5, arg6)
															if index._config._keybinds[arg4.flag] and not arg6 then
																local v118 = string.gsub(tostring(index._config._keybinds[arg4.flag]), "Enum.KeyCode.", "")
																local instance23 = Instance.new("GetTextBoundsParams")
																instance23.Text = v118
																instance23.Font = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
																instance23.Size = 10
																instance23.Width = 10000
																local textBoundsAsync2 = v95:GetTextBoundsAsync(instance23)
																instance21.Size = UDim2.fromOffset(textBoundsAsync2.X + 6, 15)
																textLabel6.Size = UDim2.fromOffset(textBoundsAsync2.X, 13)
															else
																instance21.Size = UDim2.fromOffset(33, 15)
																textLabel6.Size = UDim2.fromOffset(25, 13)
															end
														end

														if index:flag_type(arg4.flag, "boolean") then
															tbl28._state = true
															arg4.callback(tbl28._state)
															instance19.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															instance20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
															instance20.Position = UDim2.new(1, -13, 0.5, 0)
														end

														if index._config._keybinds[arg4.flag] then
															local v118 = "Enum.KeyCode."
															textLabel6.Text = string.gsub(tostring(index._config._keybinds[arg4.flag]), v118, "")
															tbl28:connect_keybind()
															tbl28:scale_keybind()
														end

														obj2[arg4.flag .. "_input_began"] = textButton2.InputBegan:Connect(function(input)
															if index._choosing_keybind then
																return
															end

															if input.UserInputType ~= Enum.UserInputType.MouseButton3 then
																return
															end
															index._choosing_keybind = true

															obj2.keybind_choose_start = v92.InputBegan:Connect(function(input2, gameProcessed)
																if gameProcessed then
																	return
																end

																if input2 == Enum.UserInputState or input2 == Enum.UserInputType then
																	return
																end

																if input2.KeyCode == Enum.KeyCode.Unknown then
																	return
																end

																if input2.KeyCode == Enum.KeyCode.Backspace then
																	tbl28:scale_keybind(true)
																	index._config._keybinds[arg4.flag] = nil
																	obj:save(game.GameId, index._config)
																	textLabel6.Text = "None"

																	if obj2[arg4.flag .. "_keybind"] then
																		obj2[arg4.flag .. "_keybind"]:Disconnect()
																		obj2[arg4.flag .. "_keybind"] = nil
																	end

																	obj2.keybind_choose_start:Disconnect()
																	obj2.keybind_choose_start = nil
																	index._choosing_keybind = false
																	return
																end

																obj2.keybind_choose_start:Disconnect()
																obj2.keybind_choose_start = nil
																index._config._keybinds[arg4.flag] = tostring(input2.KeyCode)
																obj:save(game.GameId, index._config)

																if obj2[arg4.flag .. "_keybind"] then
																	obj2[arg4.flag .. "_keybind"]:Disconnect()
																	obj2[arg4.flag .. "_keybind"] = nil
																end

																tbl28:connect_keybind()
																tbl28:scale_keybind()
																index._choosing_keybind = false
																textLabel6.Text = string.gsub(tostring(index._config._keybinds[arg4.flag]), "Enum.KeyCode.", "")
															end)
														end)

														textButton2.MouseButton1Click:Connect(function()
															tbl28:change_state(not tbl28._state)
														end)

														tbl28.create_paragraph = function(arg5, arg6)
															v117 += 1
															local tbl29 = {}

															if arg5._size == 0 then
																arg5._size = 13
															end

															arg5._size = arg5._size + (arg6.customScale or 70)

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local frame10 = Instance.new("Frame")
															frame10.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
															frame10.BackgroundTransparency = 0.1
															frame10.Size = UDim2.new(1, -16, 0, 30)
															frame10.BorderSizePixel = 0
															frame10.Name = "Paragraph"
															frame10.AutomaticSize = Enum.AutomaticSize.Y
															frame10.Parent = frame9
															frame10.LayoutOrder = v117
															local instance23 = Instance.new("UICorner")
															instance23.CornerRadius = UDim.new(0, 5)
															instance23.Parent = frame10
															local textLabel7 = Instance.new("TextLabel")
															textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															textLabel7.TextColor3 = Color3.fromRGB(225, 230, 240)
															textLabel7.Text = arg6.title or "Label"
															textLabel7.Size = UDim2.new(1, -10, 0, 20)
															textLabel7.Position = UDim2.new(0, 5, 0, 5)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.TextYAlignment = Enum.TextYAlignment.Center
															textLabel7.TextSize = 12
															textLabel7.AutomaticSize = Enum.AutomaticSize.XY
															textLabel7.Parent = frame10
															local textLabel8 = Instance.new("TextLabel")
															textLabel8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textLabel8.TextColor3 = Color3.fromRGB(180, 180, 180)

															if not arg6.rich then
																textLabel8.Text = arg6.text or "Skibidi"
															else
																textLabel8.RichText = true
																textLabel8.Text = arg6.richtext or "<font color='rgb(255,0,0)'>Winds</font> user"
															end

															textLabel8.Size = UDim2.new(1, -12, 0, 20)
															textLabel8.Position = UDim2.new(0, 5, 0, 30)
															textLabel8.BackgroundTransparency = 1
															textLabel8.TextXAlignment = Enum.TextXAlignment.Left
															textLabel8.TextYAlignment = Enum.TextYAlignment.Top
															textLabel8.TextSize = 11
															textLabel8.TextWrapped = true
															textLabel8.AutomaticSize = Enum.AutomaticSize.XY
															textLabel8.Parent = frame10

															frame10.MouseEnter:Connect(function()
																TweenService:Create(frame10, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(42, 50, 66) }):Play()
															end)

															frame10.MouseLeave:Connect(function()
																TweenService:Create(frame10, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(22, 24, 32) }):Play()
															end)

															return tbl29
														end

														tbl28.create_text = function(arg5, arg6)
															v117 += 1
															local tbl29 = {}

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + (arg6.customScale or 50)

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local frame10 = Instance.new("Frame")
															frame10.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
															frame10.BackgroundTransparency = 0.1
															frame10.Size = UDim2.new(0, 207, 0, arg6.CustomYSize)
															frame10.BorderSizePixel = 0
															frame10.Name = "Text"
															frame10.AutomaticSize = Enum.AutomaticSize.Y
															frame10.Parent = frame9
															frame10.LayoutOrder = v117
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 4)
															uiCorner8.Parent = frame10
															local textLabel7 = Instance.new("TextLabel")
															textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textLabel7.TextColor3 = Color3.fromRGB(180, 180, 180)

															if not arg6.rich then
																textLabel7.Text = arg6.text or "Skibidi"
															else
																textLabel7.RichText = true
																textLabel7.Text = arg6.richtext or "<font color='rgb(255,0,0)'>Winds</font> user"
															end

															textLabel7.Size = UDim2.new(1, -10, 1, 0)
															textLabel7.Position = UDim2.new(0, 5, 0, 5)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.TextYAlignment = Enum.TextYAlignment.Top
															textLabel7.TextSize = 10
															textLabel7.TextWrapped = true
															textLabel7.AutomaticSize = Enum.AutomaticSize.XY
															textLabel7.Parent = frame10

															frame10.MouseEnter:Connect(function()
																TweenService:Create(frame10, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(42, 42, 66) }):Play()
															end)

															frame10.MouseLeave:Connect(function()
																TweenService:Create(frame10, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(22, 24, 32) }):Play()
															end)

															tbl29.Set = function(arg7, arg8)
																if true then -- recovered opaque guard
																	if not arg8.rich then
																		textLabel7.Text = arg8.text or "Skibidi"
																	else
																		textLabel7.RichText = true
																		textLabel7.Text = arg8.richtext or "<font color='rgb(255,0,0)'>Winds</font> user"
																	end

																	return
																end

																error("Unreachable obfuscation trap")
															end

															return tbl29
														end

														tbl28.create_textbox = function(arg5, arg6)
															v117 += 1
															local tbl29 = { _text = "" }
															local flag23 = arg6.multiline == true
															local height

															if flag23 then
																height = arg6.height or 70
															else
																height = flag23
															end

															local n36 = height or 22

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + 25 + n36

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local textLabel7 = Instance.new("TextLabel")
															textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.TextTransparency = 0.2
															textLabel7.Text = arg6.title or "Enter text"
															textLabel7.Size = UDim2.new(0, 207, 0, 13)
															textLabel7.AnchorPoint = Vector2.new(0, 0)
															textLabel7.Position = UDim2.new(0, 0, 0, 0)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.BorderSizePixel = 0
															textLabel7.Parent = frame9
															textLabel7.TextSize = 10
															textLabel7.LayoutOrder = v117
															local textBox2 = Instance.new("TextBox")
															textBox2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textBox2.TextColor3 = Color3.fromRGB(235, 235, 245)
															textBox2.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textBox2.PlaceholderText = arg6.placeholder or "Enter text..."
															textBox2.Text = index._config._flags[arg6.flag] or ""
															textBox2.Name = "Textbox"
															textBox2.Size = UDim2.new(0, 207, 0, n36)
															textBox2.BorderSizePixel = 0
															textBox2.TextSize = 12
															textBox2.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															textBox2.BackgroundTransparency = 0.9
															textBox2.ClearTextOnFocus = false
															textBox2.ClipsDescendants = true
															textBox2.TextTruncate = Enum.TextTruncate.AtEnd
															textBox2.Parent = frame9
															textBox2.LayoutOrder = v117
															textBox2.TextXAlignment = Enum.TextXAlignment.Left
															textBox2.TextYAlignment = flag23 and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
															local instance23 = Instance.new("UIPadding")
															instance23.PaddingLeft = UDim.new(0, 8)
															instance23.PaddingRight = UDim.new(0, 10)

															if flag23 then
																textBox2.MultiLine = true
																textBox2.TextWrapped = true
																textBox2.ClearTextOnFocus = false
																instance23.PaddingTop = UDim.new(0, 4)
																instance23.PaddingBottom = UDim.new(0, 4)
															end

															instance23.Parent = textBox2
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 4)
															uiCorner8.Parent = textBox2
															local v118 = 0

															local function fn40()
																if not flag23 then
																	return
																end
																local text2 = textBox2.Text

																if text2 == "" then
																	text2 = " "
																end

																local ok, result = pcall(function()
																	local instance24 = Instance.new("GetTextBoundsParams")
																	instance24.Text = text2
																	instance24.Font = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
																	instance24.Size = 10
																	instance24.Width = 195
																	return v95:GetTextBoundsAsync(instance24)
																end)

																local n37 = math.clamp((ok and result and result.Y or n36) + 12, n36, arg6.max_height or 260)
																local n38 = n37 - n36

																if n38 ~= v118 then
																	v118 = n38
																	textBox2.Size = UDim2.new(0, 207, 0, n37)
																	frame9.Size = UDim2.new(1, -8, 0, arg5._size + n38)

																	if tbl28._state then
																		instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size + n38)
																	end
																end
															end

															tbl29.update_text = function(arg7, text2)
																arg7._text = text2
																index._config._flags[arg6.flag] = arg7._text
																obj:save(game.GameId, index._config)
																arg6.callback(arg7._text)
																fn40()
															end

															if index:flag_type(arg6.flag, "string") then
																tbl29:update_text(index._config._flags[arg6.flag])
															end

															if flag23 then
																local flag24 = false

																textBox2:GetPropertyChangedSignal("Text"):Connect(function()
																	if flag24 then
																		return
																	end
																	flag24 = true

																	task.defer(function()
																		flag24 = false
																		fn40()
																	end)
																end)

																task.defer(fn40)
															end

															textBox2.FocusLost:Connect(function()
																tbl29:update_text(textBox2.Text)
															end)

															return tbl29
														end

														tbl28.create_checkbox = function(arg5, arg6)
															v117 += 1
															local tbl29 = { _state = false }

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + 20

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local textButton3 = Instance.new("TextButton")
															textButton3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textButton3.TextColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Text = ""
															textButton3.AutoButtonColor = false
															textButton3.BackgroundTransparency = 1
															textButton3.Name = "Checkbox"
															textButton3.Size = UDim2.new(0, 207, 0, 10)
															textButton3.BorderSizePixel = 0
															textButton3.TextSize = 14
															textButton3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Parent = frame9
															textButton3.LayoutOrder = v117
															local textLabel7 = Instance.new("TextLabel")
															textLabel7.Name = "TitleLabel"

															if language == "th" then
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 13
															else
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 11
															end

															textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.TextTransparency = 0.2
															textLabel7.Text = arg6.title or "Skibidi"
															textLabel7.Size = UDim2.new(0, 142, 0, 13)
															textLabel7.AnchorPoint = Vector2.new(0, 0.5)
															textLabel7.Position = UDim2.new(0, 0, 0.5, 0)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.Parent = textButton3
															local instance23 = Instance.new("Frame")
															instance23.Name = "Checkbox"
															instance23.Size = UDim2.fromOffset(14, 14)
															instance23.Position = UDim2.new(1, -35, 0.5, 0)
															instance23.AnchorPoint = Vector2.new(0, 0.5)
															instance23.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															instance23.BorderSizePixel = 0
															instance23.Parent = textButton3
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 4)
															uiCorner8.Parent = instance23
															local textLabel8 = Instance.new("TextLabel")
															textLabel8.Name = "Title"
															textLabel8.Size = UDim2.new(1, 0, 1, 0)
															textLabel8.BackgroundTransparency = 1
															textLabel8.TextColor3 = Color3.fromRGB(0, 0, 0)
															textLabel8.TextScaled = false
															textLabel8.TextSize = 12
															textLabel8.Font = Enum.Font.SourceSans
															textLabel8.Text = index._config._keybinds[arg6.flag] and string.gsub(tostring(index._config._keybinds[arg6.flag]), "Enum.KeyCode.", "") or "..."
															textLabel8.Parent = instance23
															local frame10 = Instance.new("Frame")
															frame10.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame10.AnchorPoint = Vector2.new(1, 0.5)
															frame10.BackgroundTransparency = 0.9
															frame10.Position = UDim2.new(1, 0, 0.5, 0)
															frame10.Name = "Box"
															frame10.Size = UDim2.new(0, 15, 0, 15)
															frame10.BorderSizePixel = 0
															frame10.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame10.Parent = textButton3
															local uiCorner9 = Instance.new("UICorner")
															uiCorner9.CornerRadius = UDim.new(0, 5)
															uiCorner9.Parent = frame10
															local instance24 = Instance.new("Frame")
															instance24.AnchorPoint = Vector2.new(0.5, 0.5)
															instance24.BackgroundTransparency = 0.2
															instance24.Position = UDim2.new(0.5, 0, 0.5, 0)
															instance24.BorderColor3 = Color3.fromRGB(0, 0, 0)
															instance24.Name = "Fill"
															instance24.BorderSizePixel = 0
															instance24.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															instance24.Parent = frame10
															local uiCorner10 = Instance.new("UICorner")
															uiCorner10.CornerRadius = UDim.new(0, 5)
															uiCorner10.Parent = instance24

															tbl29.change_state = function(arg7, state)
																arg7._state = state

																if arg7._state then
																	TweenService:Create(frame10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 0.7 }):Play()
																	TweenService:Create(instance24, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(9, 9) }):Play()
																else
																	TweenService:Create(frame10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 0.9 }):Play()
																	TweenService:Create(instance24, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(0, 0) }):Play()
																end

																index._config._flags[arg6.flag] = arg7._state
																obj:save(game.GameId, index._config)
																arg6.callback(arg7._state)
															end

															if index:flag_type(arg6.flag, "boolean") then
																tbl29:change_state(index._config._flags[arg6.flag])
															end

															textButton3.MouseButton1Click:Connect(function()
																tbl29:change_state(not tbl29._state)
															end)

															textButton3.InputBegan:Connect(function(input, gameProcessed)
																if gameProcessed then
																	return
																end

																if input.UserInputType ~= Enum.UserInputType.MouseButton3 then
																	return
																end

																if index._choosing_keybind then
																	return
																end
																index._choosing_keybind = true
																local connection2 = nil

																connection2 = v92.InputBegan:Connect(function(input2, gameProcessed2)
																	if gameProcessed2 then
																		return
																	end

																	if input2.UserInputType ~= Enum.UserInputType.Keyboard then
																		return
																	end

																	if input2.KeyCode == Enum.KeyCode.Unknown then
																		return
																	end

																	if input2.KeyCode == Enum.KeyCode.Backspace then
																		tbl28:scale_keybind(true)
																		index._config._keybinds[arg6.flag] = nil
																		obj:save(game.GameId, index._config)
																		textLabel8.Text = "..."

																		if obj2[arg6.flag .. "_keybind"] then
																			obj2[arg6.flag .. "_keybind"]:Disconnect()
																			obj2[arg6.flag .. "_keybind"] = nil
																		end

																		connection2:Disconnect()
																		index._choosing_keybind = false
																		return
																	end

																	connection2:Disconnect()
																	index._config._keybinds[arg6.flag] = tostring(input2.KeyCode)
																	obj:save(game.GameId, index._config)

																	if obj2[arg6.flag .. "_keybind"] then
																		obj2[arg6.flag .. "_keybind"]:Disconnect()
																		obj2[arg6.flag .. "_keybind"] = nil
																	end

																	tbl28:connect_keybind()
																	tbl28:scale_keybind()
																	index._choosing_keybind = false
																	textLabel8.Text = string.gsub(tostring(index._config._keybinds[arg6.flag]), "Enum.KeyCode.", "")
																end)
															end)

															obj2[arg6.flag .. "_keypress"] = v92.InputBegan:Connect(function(input, gameProcessed)
																if gameProcessed then
																	return
																end

																if input.UserInputType == Enum.UserInputType.Keyboard then
																	local v118 = index._config._keybinds[arg6.flag]

																	if v118 and tostring(input.KeyCode) == v118 then
																		tbl29:change_state(not tbl29._state)
																	end
																end
															end)

															return tbl29
														end

														tbl28.create_divider = function(arg5, arg6)
															v117 += 1

															if arg5._size == 0 then
																arg5._size = 11

																if false then -- recovered opaque guard
																	error("Unreachable obfuscation trap")
																end
															end

															arg5._size = arg5._size + 27

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															local frame10 = Instance.new("Frame")
															frame10.Size = UDim2.new(0, 207, 0, 20)
															frame10.BackgroundTransparency = 1
															frame10.Name = "OuterFrame"
															frame10.Parent = frame9
															frame10.LayoutOrder = v117

															if arg6 and arg6.showtopic then
																local textLabel7 = Instance.new("TextLabel")
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
																textLabel7.TextTransparency = 0
																textLabel7.Text = arg6.title
																textLabel7.Size = UDim2.new(0, 165, 0, 13)
																textLabel7.Position = UDim2.new(0.5, 0, 0.501, 0)
																textLabel7.BackgroundTransparency = 1
																textLabel7.TextXAlignment = Enum.TextXAlignment.Center
																textLabel7.BorderSizePixel = 0
																textLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
																textLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
																textLabel7.TextSize = 11
																textLabel7.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
																textLabel7.ZIndex = 3
																textLabel7.TextStrokeTransparency = 0
																textLabel7.Parent = frame10
															end

															if not arg6 or arg6 and not arg6.disableline then
																local frame11 = Instance.new("Frame")
																frame11.Size = UDim2.new(1, 0, 0, 1)
																frame11.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
																frame11.BorderSizePixel = 0
																frame11.Name = "Divider"
																frame11.Parent = frame10
																frame11.ZIndex = 2
																frame11.Position = UDim2.new(0, 0, 0.5, -0.5)
																local uiGradient5 = Instance.new("UIGradient")
																uiGradient5.Parent = frame11
																local colorSequence3 = ColorSequence.new
																local tbl29 = {}
																local v118 = ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 235, 245))
																local v119 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(235, 235, 245))
																local new5 = ColorSequenceKeypoint.new
																local color3 = Color3.fromRGB
																local v120 = 255
																tbl29[1] = v118
																tbl29[2] = v119

																do
																	local values = table.pack(new5(1, color3(v120, 255, 255, 0)))
																	table.move(values, 1, values.n, 3, tbl29)
																end

																uiGradient5.Color = colorSequence3(tbl29)
																local numberSequence3 = NumberSequence.new
																local tbl30 = {}
																local v121 = NumberSequenceKeypoint.new(0, 1)
																local v122 = NumberSequenceKeypoint.new(0.5, 0)
																local new6 = NumberSequenceKeypoint.new
																local v123 = 1
																local v124 = 1
																tbl30[1] = v121
																tbl30[2] = v122

																do
																	local values = table.pack(new6(v123, v124))
																	table.move(values, 1, values.n, 3, tbl30)
																end

																uiGradient5.Transparency = numberSequence3(tbl30)
																uiGradient5.Rotation = 0
																local uiCorner8 = Instance.new("UICorner")
																uiCorner8.CornerRadius = UDim.new(0, 2)
																uiCorner8.Parent = frame11
															end

															return true
														end

														tbl28.create_slider = function(arg5, arg6)
															v117 += 1
															local tbl29 = {}

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + 27

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)

																if false then -- recovered opaque guard
																	error("Unreachable obfuscation trap")
																end
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
															local tweenInfo2 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
															local tweenInfo3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
															local textButton3 = Instance.new("TextButton")
															textButton3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textButton3.TextSize = 14
															textButton3.TextColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Text = ""
															textButton3.AutoButtonColor = false
															textButton3.BackgroundTransparency = 1
															textButton3.Name = "Slider"
															textButton3.Size = UDim2.new(0, 207, 0, 22)
															textButton3.BorderSizePixel = 0
															textButton3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Parent = frame9
															textButton3.LayoutOrder = v117
															local instance23 = Instance.new("TextLabel")

															if GG.SelectedLanguage == "th" then
																instance23.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																instance23.TextSize = 13
															else
																instance23.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																instance23.TextSize = 11
															end

															instance23.TextColor3 = Color3.fromRGB(235, 235, 245)
															instance23.TextTransparency = 0.20000000298023224
															instance23.Text = arg6.title
															instance23.Size = UDim2.new(1, -48, 0, 13)
															instance23.Position = UDim2.new(0, 0, 0.05000000074505806, 0)
															instance23.BackgroundTransparency = 1
															instance23.TextXAlignment = Enum.TextXAlignment.Left
															instance23.TextTruncate = Enum.TextTruncate.AtEnd
															instance23.BorderSizePixel = 0
															instance23.BorderColor3 = Color3.fromRGB(0, 0, 0)
															instance23.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															instance23.Parent = textButton3
															local frame10 = Instance.new("Frame")
															frame10.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame10.AnchorPoint = Vector2.new(0.5, 1)
															frame10.BackgroundTransparency = 0.7
															frame10.Position = UDim2.new(0.5, 0, 0.94999998807907104, 0)
															frame10.Name = "Drag"
															frame10.Size = UDim2.new(0, 207, 0, 5)
															frame10.BorderSizePixel = 0
															frame10.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame10.Parent = textButton3
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 14)
															uiCorner8.Parent = frame10
															local frame11 = Instance.new("Frame")
															frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame11.AnchorPoint = Vector2.new(0, 0.5)
															frame11.BackgroundTransparency = 0.08
															frame11.Position = UDim2.new(0, 0, 0.5, 0)
															frame11.Name = "Fill"
															frame11.Size = UDim2.new(0, 0, 0, 4)
															frame11.BorderSizePixel = 0
															frame11.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame11.Parent = frame10
															local instance24 = Instance.new("UICorner")
															instance24.CornerRadius = UDim.new(0, 3)
															instance24.Parent = frame11
															local uiGradient5 = Instance.new("UIGradient")
															local new5 = ColorSequenceKeypoint.new
															local color3 = Color3.fromRGB
															local v118 = 40
															uiGradient5.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(167, 139, 250)), new5(1, color3(109, v118, 217)) })
															uiGradient5.Parent = frame11
															local frame12 = Instance.new("Frame")
															frame12.AnchorPoint = Vector2.new(0.5, 0.5)
															frame12.Name = "Thumb"
															frame12.Position = UDim2.new(0, 0, 0.5, 0)
															frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame12.Size = UDim2.new(0, 8, 0, 8)
															frame12.BorderSizePixel = 0
															frame12.ZIndex = 3
															frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
															frame12.Parent = frame10
															local instance25 = Instance.new("UICorner")
															instance25.CornerRadius = UDim.new(1, 0)
															instance25.Parent = frame12
															local uiStroke3 = Instance.new("UIStroke")
															uiStroke3.Color = Color3.fromRGB(30, 30, 38)
															uiStroke3.Thickness = 1.5
															uiStroke3.Parent = frame12
															local instance26 = Instance.new("TextLabel")
															instance26.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															instance26.TextColor3 = Color3.fromRGB(235, 235, 245)
															instance26.TextTransparency = 0.2
															instance26.Text = "0"
															instance26.Name = "Value"
															instance26.Size = UDim2.new(0, 42, 0, 13)
															instance26.AnchorPoint = Vector2.new(1, 0)
															instance26.Position = UDim2.new(1, 0, 0, 0)
															instance26.BackgroundTransparency = 1
															instance26.TextXAlignment = Enum.TextXAlignment.Right
															instance26.BorderSizePixel = 0
															instance26.BorderColor3 = Color3.fromRGB(0, 0, 0)
															instance26.TextSize = 12
															instance26.TextTruncate = Enum.TextTruncate.AtEnd
															instance26.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															instance26.Parent = textButton3
															local flag23 = false

															tbl29.set_percentage = function(arg7, arg8)
																local n36

																if arg6.round_number then
																	n36 = math.floor(arg8)
																else
																	n36 = math.floor(arg8 * 10) / 10
																end

																local n37 = math.clamp((arg8 - arg6.minimum_value) / (arg6.maximum_value - arg6.minimum_value), 0, 1)
																local text2 = math.clamp(n36, arg6.minimum_value, arg6.maximum_value)
																local v119 = flag23 and tweenInfo2 or tweenInfo3
																index._config._flags[arg6.flag] = text2
																instance26.Text = text2
																TweenService:Create(frame11, v119, { Size = UDim2.new(n37, 0, 0, 4) }):Play()
																TweenService:Create(frame12, v119, { Position = UDim2.new(n37, (0.5 - n37) * 8, 0.5, 0) }):Play()
																arg6.callback(text2)
															end

															tbl29.update = function(arg7)
																local n36 = arg6.maximum_value - arg6.minimum_value
																arg7:set_percentage(arg6.minimum_value + math.clamp((mouse.X - frame10.AbsolutePosition.X) / math.max(1, frame10.AbsoluteSize.X), 0, 1) * n36)
															end

															tbl29.input = function()
																flag23 = true
																TweenService:Create(frame12, tweenInfo, { Size = UDim2.new(0, 11, 0, 11) }):Play()
																tbl29:update()
																if false then -- removed opaque flag guard
																	return
																end

																obj2["slider_drag_" .. arg6.flag] = mouse.Move:Connect(function()
																	tbl29:update()
																end)

																obj2["slider_input_ended_" .. arg6.flag] = v92.InputEnded:Connect(function(input)
																	if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
																		return
																	end
																	flag23 = false
																	TweenService:Create(frame12, tweenInfo3, { Size = UDim2.new(0, 8, 0, 8) }):Play()
																	obj2:disconnect("slider_drag_" .. arg6.flag)
																	obj2:disconnect("slider_input_ended_" .. arg6.flag)

																	if not arg6.ignoresaved then
																		obj:save(game.GameId, index._config)
																	end
																end)
															end

															if index:flag_type(arg6.flag, "number") then
																if not arg6.ignoresaved then
																	tbl29:set_percentage(index._config._flags[arg6.flag])
																else
																	tbl29:set_percentage(arg6.value)
																end
															else
																tbl29:set_percentage(arg6.value)
															end

															textButton3.MouseButton1Down:Connect(function()
																tbl29:input()
															end)

															return tbl29
														end

														tbl28.create_range_slider = function(arg5, arg6)
															v117 += 1

															local tbl29 = {
																min_value = arg6.min_value or arg6.minimum_value,
																max_value = arg6.max_value or arg6.maximum_value,
																min_thumb = nil,
																max_thumb = nil,
																fill = nil,
																drag = nil,
																is_dragging = false,
																active_thumb = nil,
															}

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + 27

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local textButton3 = Instance.new("TextButton")
															textButton3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															textButton3.TextSize = 11
															textButton3.TextColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Text = ""
															textButton3.AutoButtonColor = false
															textButton3.BackgroundTransparency = 1
															textButton3.Name = "RangeSlider"
															textButton3.Size = UDim2.new(0, 207, 0, 22)
															textButton3.BorderSizePixel = 0
															textButton3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
															textButton3.Parent = frame9
															textButton3.LayoutOrder = v117
															textButton3.ClipsDescendants = false
															local textLabel7 = Instance.new("TextLabel")

															if GG.SelectedLanguage == "th" then
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 13
															else
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 11
															end

															textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.TextTransparency = 0.2
															textLabel7.Text = arg6.title
															textLabel7.Size = UDim2.new(1, -42, 0, 13)
															textLabel7.Position = UDim2.new(0, 0, 0.05000000074505806, 0)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.TextTruncate = Enum.TextTruncate.AtEnd
															textLabel7.BorderSizePixel = 0
															textLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textLabel7.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.Parent = textButton3
															local frame10 = Instance.new("Frame")
															frame10.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame10.AnchorPoint = Vector2.new(0.5, 1)
															frame10.BackgroundTransparency = 0.89999997615814209
															frame10.Position = UDim2.new(0.5, 0, 0.94999998807907104, 0)
															frame10.Name = "Drag"
															frame10.Size = UDim2.new(0, 207, 0, 5)
															frame10.BorderSizePixel = 0
															frame10.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame10.Parent = textButton3
															tbl29.drag = frame10
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 12)
															uiCorner8.Parent = frame10
															local frame11 = Instance.new("Frame")
															frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame11.AnchorPoint = Vector2.new(0, 0.5)
															frame11.BackgroundTransparency = 0.08
															frame11.Position = UDim2.new(0, 0, 0.5, 0)
															frame11.Name = "Fill"
															frame11.Size = UDim2.new(0, 0, 0, 4)
															frame11.BorderSizePixel = 0
															frame11.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame11.Parent = frame10
															tbl29.fill = frame11
															local uiCorner9 = Instance.new("UICorner")
															uiCorner9.CornerRadius = UDim.new(0, 3)
															uiCorner9.Parent = frame11
															local uiGradient5 = Instance.new("UIGradient")
															local new5 = ColorSequenceKeypoint.new
															local color3 = Color3.fromRGB
															local v118 = 217
															uiGradient5.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(167, 139, 250)), new5(1, color3(109, 40, v118)) })
															uiGradient5.Parent = frame11
															local frame12 = Instance.new("Frame")
															frame12.AnchorPoint = Vector2.new(0.5, 0.5)
															frame12.Name = "MinThumb"
															frame12.Position = UDim2.new(0, 0, 0.5, 0)
															frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame12.Size = UDim2.new(0, 8, 0, 8)
															frame12.BorderSizePixel = 0
															frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
															frame12.Parent = frame10
															tbl29.min_thumb = frame12
															local uiCorner10 = Instance.new("UICorner")
															uiCorner10.CornerRadius = UDim.new(1, 0)
															uiCorner10.Parent = frame12
															local uiStroke3 = Instance.new("UIStroke")
															uiStroke3.Color = Color3.fromRGB(30, 30, 38)
															uiStroke3.Thickness = 1.5
															uiStroke3.Parent = frame12
															local frame13 = Instance.new("Frame")
															frame13.AnchorPoint = Vector2.new(0.5, 0.5)
															frame13.Name = "MaxThumb"
															frame13.Position = UDim2.new(0, 0, 0.5, 0)
															frame13.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame13.Size = UDim2.new(0, 8, 0, 8)
															frame13.BorderSizePixel = 0
															frame13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
															frame13.Parent = frame10
															tbl29.max_thumb = frame13
															local uiCorner11 = Instance.new("UICorner")
															uiCorner11.CornerRadius = UDim.new(1, 0)
															uiCorner11.Parent = frame13
															local uiStroke4 = Instance.new("UIStroke")
															uiStroke4.Color = Color3.fromRGB(30, 30, 38)
															uiStroke4.Thickness = 1.5
															uiStroke4.Parent = frame13
															local textLabel8 = Instance.new("TextLabel")
															textLabel8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															textLabel8.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel8.TextTransparency = 0.20000000298023224
															textLabel8.Text = string.format("%.3f, %.3f", tbl29.min_value, tbl29.max_value)
															textLabel8.Name = "Value"
															textLabel8.Size = UDim2.new(0, 80, 0, 13)
															textLabel8.AnchorPoint = Vector2.new(1, 0)
															textLabel8.Position = UDim2.new(1, 0, 0, 0)
															textLabel8.BackgroundTransparency = 1
															textLabel8.TextXAlignment = Enum.TextXAlignment.Right
															textLabel8.BorderSizePixel = 0
															textLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textLabel8.TextSize = 10
															textLabel8.TextTruncate = Enum.TextTruncate.AtEnd
															textLabel8.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															textLabel8.Parent = textButton3

															local function fn40(arg7)
																local x = frame10.AbsoluteSize.X
																return arg6.minimum_value + (arg6.maximum_value - arg6.minimum_value) * math.clamp(arg7 - frame10.AbsolutePosition.X, 0, x) / x
															end

															tbl29.update_positions = function(arg7, arg8)
																local n36 = (arg7.max_value - arg6.minimum_value) / (arg6.maximum_value - arg6.minimum_value)
																local n37 = math.clamp((arg7.min_value - arg6.minimum_value) / (arg6.maximum_value - arg6.minimum_value), 0, 1)
																local n38 = math.clamp(n36, 0, 1)

																if arg8 then
																	TweenService:Create(arg7.min_thumb, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(n37, (0.5 - n37) * 8, 0.5, 0) }):Play()
																	TweenService:Create(arg7.max_thumb, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(n38, (0.5 - n38) * 8, 0.5, 0) }):Play()
																	TweenService:Create(arg7.fill, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(n38 - n37, 0, 1, 0), Position = UDim2.new(n37, 0, 0.5, 0) }):Play()
																elseif true then -- recovered opaque guard
																	arg7.min_thumb.Position = UDim2.new(n37, (0.5 - n37) * 8, 0.5, 0)
																	arg7.max_thumb.Position = UDim2.new(n38, (0.5 - n38) * 8, 0.5, 0)
																	arg7.fill.Size = UDim2.new(n38 - n37, 0, 1, 0)
																	arg7.fill.Position = UDim2.new(n37, 0, 0.5, 0)
																else
																	error("Unreachable obfuscation trap")
																end

																if arg6.round_number then
																	textLabel8.Text = string.format("%.0f, %.0f", arg7.min_value, arg7.max_value)
																else
																	textLabel8.Text = string.format("%.1f, %.1f", arg7.min_value, arg7.max_value)
																end

																index._config._flags[arg6.flag .. "_min"] = arg7.min_value
																index._config._flags[arg6.flag .. "_max"] = arg7.max_value
																obj:save(game.GameId, index._config)
																arg6.callback(arg7.min_value, arg7.max_value)
															end

															local function fn41(arg7)
																if arg7.UserInputType ~= Enum.UserInputType.MouseButton1 and arg7.UserInputType ~= Enum.UserInputType.Touch then
																	return
																end
																local position2 = arg7.Position
																local absolutePosition = frame10.AbsolutePosition
																local n36 = absolutePosition.X + (tbl29.min_value - arg6.minimum_value) / (arg6.maximum_value - arg6.minimum_value) * frame10.AbsoluteSize.X
																if false then -- removed opaque flag guard
																	return
																end
																local n37 = absolutePosition.X + (tbl29.max_value - arg6.minimum_value) / (arg6.maximum_value - arg6.minimum_value) * frame10.AbsoluteSize.X
																local n38 = math.abs(position2.X - n36)
																local n39 = math.abs(position2.X - n37)

																if n38 < 35 and n38 < n39 then
																	tbl29.active_thumb = "min"
																	tbl29.is_dragging = true
																elseif n39 < 35 then
																	tbl29.active_thumb = "max"
																	tbl29.is_dragging = true
																end
															end

															local function fn42(arg7)
																if not tbl29.is_dragging or not tbl29.active_thumb then
																	return
																end
																local v119 = fn40(arg7.Position.X)

																if tbl29.active_thumb == "min" then
																	tbl29.min_value = math.max(math.min(v119, tbl29.max_value), arg6.minimum_value)
																elseif tbl29.active_thumb == "max" then
																	local maximumValue = arg6.maximum_value
																	tbl29.max_value = math.min(math.max(v119, tbl29.min_value), maximumValue)
																end

																tbl29:update_positions(false)
															end

															local function fn43(arg7)
																if not (arg7.UserInputType ~= Enum.UserInputType.MouseButton1 and arg7.UserInputType ~= Enum.UserInputType.Touch) then
																	if tbl29.is_dragging then
																		tbl29:update_positions(true)
																	end

																	tbl29.is_dragging = false
																	tbl29.active_thumb = nil
																	return
																end

																if true then -- recovered opaque guard
																	return
																end

																error("Unreachable obfuscation trap")
															end

															textButton3.InputBegan:Connect(function(input)
																if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																	fn41(input)
																end
															end)

															textButton3.InputChanged:Connect(function(input)
																if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
																	if tbl29.is_dragging then
																		fn42(input)
																	end
																end

																if false then -- removed missing opaque flag guard
																	return
																end
															end)

															textButton3.InputEnded:Connect(function(input)
																if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																	fn43(input)
																	if false then -- removed opaque flag guard
																		return
																	end
																end
															end)

															obj2["range_slider_touch_" .. arg6.flag] = v92.TouchMoved:Connect(function(arg7, arg8)
																if arg8 then
																	return
																end

																if tbl29.is_dragging then
																	fn42(arg7)
																end
															end)

															if index:flag_type(arg6.flag .. "_min", "number") then
																tbl29.min_value = index._config._flags[arg6.flag .. "_min"]
																tbl29.max_value = index._config._flags[arg6.flag .. "_max"] or arg6.max_value
															end

															task.spawn(function()
																task.wait()
																tbl29:update_positions(true)
															end)

															return tbl29
														end

														tbl28.create_dropdown = function(arg5, arg6)
															if not arg6.Order then
																v117 += 1
															end

															local tbl29 = { _state = false, _size = 0 }

															if not arg6.Order then
																if arg5._size == 0 then
																	arg5._size = 11
																end

																arg5._size = arg5._size + 44
															end

															if not arg6.Order then
																if tbl28._state then
																	instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
																end

																frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															end

															local instance23 = Instance.new("TextButton")
															instance23.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
															instance23.TextColor3 = Color3.fromRGB(0, 0, 0)
															instance23.BorderColor3 = Color3.fromRGB(0, 0, 0)
															instance23.Text = ""
															instance23.AutoButtonColor = false
															instance23.BackgroundTransparency = 1
															instance23.Name = "Dropdown"
															instance23.Size = UDim2.new(0, 207, 0, 38)
															instance23.BorderSizePixel = 0
															instance23.TextSize = 14
															instance23.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
															instance23.Parent = frame9

															if not arg6.Order then
																instance23.LayoutOrder = v117
															else
																instance23.LayoutOrder = arg6.OrderValue
															end

															if not index._config._flags[arg6.flag] then
																index._config._flags[arg6.flag] = {}
															end

															local textLabel7 = Instance.new("TextLabel")

															if GG.SelectedLanguage == "th" then
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/NotoSansThai.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 13
															else
																textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																textLabel7.TextSize = 11
															end

															textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.TextTransparency = 0.20000000298023224
															textLabel7.Text = arg6.title
															textLabel7.Size = UDim2.new(0, 207, 0, 13)
															textLabel7.BackgroundTransparency = 1
															textLabel7.TextXAlignment = Enum.TextXAlignment.Left
															textLabel7.BorderSizePixel = 0
															textLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textLabel7.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.Parent = instance23
															local frame10 = Instance.new("Frame")
															frame10.ClipsDescendants = true
															frame10.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame10.AnchorPoint = Vector2.new(0.5, 0)
															frame10.BackgroundTransparency = 0.7
															frame10.Position = UDim2.new(0.5, 0, 1.2000000476837158, 0)
															frame10.Name = "Container"
															frame10.Size = UDim2.new(0, 207, 0, 22)
															frame10.BorderSizePixel = 0
															frame10.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
															frame10.Parent = textLabel7
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 5)
															uiCorner8.Parent = frame10
															local frame11 = Instance.new("Frame")
															frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
															frame11.AnchorPoint = Vector2.new(0.5, 0)
															frame11.BackgroundTransparency = 1
															frame11.Position = UDim2.new(0.5, 0, 0, 0)
															frame11.Name = "Header"
															frame11.Size = UDim2.new(0, 207, 0, 22)
															frame11.BorderSizePixel = 0
															frame11.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															frame11.Parent = frame10
															local textLabel8 = Instance.new("TextLabel")
															textLabel8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															textLabel8.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel8.TextTransparency = 0.20000000298023224
															textLabel8.Name = "CurrentOption"
															textLabel8.Size = UDim2.new(0, 161, 0, 13)
															textLabel8.AnchorPoint = Vector2.new(0, 0.5)
															textLabel8.Position = UDim2.new(0.05, 0, 0.5, 0)
															textLabel8.BackgroundTransparency = 1
															textLabel8.TextXAlignment = Enum.TextXAlignment.Left
															textLabel8.BorderSizePixel = 0
															textLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
															textLabel8.TextSize = 10
															textLabel8.TextTruncate = Enum.TextTruncate.AtEnd
															textLabel8.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															textLabel8.Parent = frame11
															local uiGradient5 = Instance.new("UIGradient")
															local numberSequence3 = NumberSequence.new
															local tbl30 = {}
															local v118 = NumberSequenceKeypoint.new(0, 0)
															local v119 = NumberSequenceKeypoint.new(0.704, 0)
															local v120 = NumberSequenceKeypoint.new(0.872, 0.3625)
															local new5 = NumberSequenceKeypoint.new
															local v121 = 1
															local v122 = 1
															tbl30[1] = v118
															tbl30[2] = v119
															tbl30[3] = v120

															do
																local values = table.pack(new5(v121, v122))
																table.move(values, 1, values.n, 4, tbl30)
															end

															uiGradient5.Transparency = numberSequence3(tbl30)
															uiGradient5.Parent = textLabel8
															local instance24 = Instance.new("TextLabel")
															instance24.Text = "⇅"
															instance24.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
															instance24.TextSize = 10
															instance24.TextColor3 = Color3.fromRGB(235, 235, 245)
															instance24.BackgroundTransparency = 1
															instance24.Size = UDim2.new(0, 10, 0, 10)
															instance24.Position = UDim2.new(0.91, 0, 0.5, 0)
															instance24.AnchorPoint = Vector2.new(0, 0.5)
															instance24.Parent = frame11
															local scrollingFrame3 = Instance.new("ScrollingFrame")
															scrollingFrame3.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
															scrollingFrame3.Active = true
															scrollingFrame3.ScrollBarImageTransparency = 1
															scrollingFrame3.AutomaticCanvasSize = Enum.AutomaticSize.XY
															scrollingFrame3.ScrollBarThickness = 0
															scrollingFrame3.Name = "Options"
															scrollingFrame3.Size = UDim2.new(0, 207, 0, 0)
															scrollingFrame3.BackgroundTransparency = 1
															scrollingFrame3.Position = UDim2.new(0, 0, 1, 0)
															scrollingFrame3.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
															scrollingFrame3.BorderColor3 = Color3.fromRGB(0, 0, 0)
															scrollingFrame3.BorderSizePixel = 0
															scrollingFrame3.CanvasSize = UDim2.new(0, 0, 0.5, 0)
															scrollingFrame3.Parent = frame10
															local instance25 = Instance.new("UIListLayout")
															instance25.SortOrder = Enum.SortOrder.LayoutOrder
															instance25.Parent = scrollingFrame3
															instance25.Padding = UDim.new(0, 3)
															local instance26 = Instance.new("UIPadding")
															instance26.PaddingTop = UDim.new(0, 2)
															instance26.PaddingBottom = UDim.new(0, 4)
															instance26.PaddingLeft = UDim.new(0, 8)
															instance26.Parent = scrollingFrame3
															local uiListLayout5 = Instance.new("UIListLayout")
															uiListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
															uiListLayout5.Parent = frame10

															tbl29.update = function(arg7, arg8)
																if arg6.multi_dropdown then
																	if not index._config._flags[arg6.flag] then
																		index._config._flags[arg6.flag] = {}
																	end

																	local v123 = nil

																	if #index._config._flags[arg6.flag] > 0 then
																		v123 = convertTableToString(index._config._flags[arg6.flag])
																	end

																	local tbl31 = {}

																	if v123 then
																		for match in string.gmatch(v123, "([^,]+)") do
																			local match2 = match:match("^%s*(.-)%s*$")

																			if match2 ~= "Label" then
																				table.insert(tbl31, match2)
																			end
																		end
																	else
																		for match in string.gmatch(textLabel8.Text, "([^,]+)") do
																			local match2 = match:match("^%s*(.-)%s*$")

																			if match2 ~= "Label" then
																				table.insert(tbl31, match2)
																			end
																		end
																	end

																	local v124 = convertStringToTable(textLabel8.Text)
																	optionSkibidi = "nil"

																	if typeof(arg8) ~= "string" then
																		optionSkibidi = arg8.Name
																	else
																		optionSkibidi = arg8
																	end

																	for k, v125 in pairs(v124) do
																		if v125 == optionSkibidi then
																			table.remove(v124, k)
																			break
																		end
																	end

																	textLabel8.Text = table.concat(tbl31, ", ")
																	local tbl32 = {}

																	for _, v125 in scrollingFrame3:GetChildren() do
																		if v125.Name == "Option" then
																			table.insert(tbl32, v125.Text)

																			if table.find(tbl31, v125.Text) then
																				v125.TextTransparency = 0.2
																			else
																				v125.TextTransparency = 0.6
																			end
																		end
																	end

																	for k, v125 in convertStringToTable(textLabel8.Text), nil, nil do
																		if not table.find(tbl32, v125) and table.find(tbl31, v125) then
																			table.remove(tbl31, k)
																		end
																	end

																	textLabel8.Text = table.concat(tbl31, ", ")
																	index._config._flags[arg6.flag] = convertStringToTable(textLabel8.Text)
																else
																	textLabel8.Text = typeof(arg8) == "string" and arg8 or arg8.Name

																	for _, v123 in scrollingFrame3:GetChildren() do
																		if v123.Name == "Option" then
																			if v123.Text == textLabel8.Text then
																				v123.TextTransparency = 0.2
																			else
																				v123.TextTransparency = 0.6
																			end
																		end
																	end

																	index._config._flags[arg6.flag] = arg8
																end

																obj:save(game.GameId, index._config)
																arg6.callback(arg8)
															end

															local n36 = 0

															tbl29.unfold_settings = function(arg7)
																arg7._state = not arg7._state

																if arg7._state then
																	tbl28._multiplier = tbl28._multiplier + arg7._size
																	n36 = arg7._size
																	TweenService:Create(instance16, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 93 + tbl28._size + tbl28._multiplier) }):Play()
																	TweenService:Create(instance16.Options, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, tbl28._size + tbl28._multiplier) }):Play()
																	TweenService:Create(instance23, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(207, 39 + arg7._size) }):Play()
																	TweenService:Create(frame10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(207, 22 + arg7._size) }):Play()
																	TweenService:Create(instance24, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
																else
																	tbl28._multiplier = tbl28._multiplier - arg7._size
																	n36 = 0
																	TweenService:Create(instance16, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 93 + tbl28._size + tbl28._multiplier) }):Play()
																	TweenService:Create(instance16.Options, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, tbl28._size + tbl28._multiplier) }):Play()
																	TweenService:Create(instance23, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(207, 39) }):Play()
																	TweenService:Create(frame10, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(207, 22) }):Play()
																	TweenService:Create(instance24, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
																end
															end

															if 0 < #arg6.options then
																tbl29._size = 7

																for k, v123 in arg6.options, nil, nil do
																	local textButton3 = Instance.new("TextButton")
																	textButton3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
																	textButton3.Active = false
																	textButton3.TextTransparency = 0.60000002384185791
																	textButton3.AnchorPoint = Vector2.new(0, 0.5)
																	textButton3.TextSize = 10
																	textButton3.Size = UDim2.new(0, 186, 0, 16)
																	textButton3.TextColor3 = Color3.fromRGB(235, 235, 245)
																	textButton3.BorderColor3 = Color3.fromRGB(0, 0, 0)
																	textButton3.Text = typeof(v123) == "string" and v123 or v123.Name
																	textButton3.AutoButtonColor = false
																	textButton3.Name = "Option"
																	textButton3.BackgroundTransparency = 1
																	textButton3.TextXAlignment = Enum.TextXAlignment.Left
																	textButton3.Selectable = false
																	textButton3.Position = UDim2.new(0.049999881535768509, 0, 0.34210526943206787, 0)
																	textButton3.BorderSizePixel = 0
																	textButton3.BackgroundColor3 = Color3.fromRGB(235, 235, 245)
																	textButton3.Parent = scrollingFrame3

																	if arg6.bindable then
																		local str8 = arg6.flag .. "_" .. (typeof(v123) == "string" and v123 or v123.Name)

																		local tbl31 = {
																			LeftControl = "LCTRL",
																			RightControl = "RCTRL",
																			LeftShift = "LSHIFT",
																			RightShift = "RSHIFT",
																			LeftAlt = "LALT",
																			RightAlt = "RALT",
																			Backspace = "BACK",
																			Backquote = "`",
																			LeftBracket = "[",
																			RightBracket = "]",
																			Semicolon = ";",
																			Quote = "'",
																			Comma = ",",
																			Period = ".",
																			Slash = "/",
																			BackSlash = "\\",
																			Minus = "-",
																			Equals = "=",
																			Space = "SPACE",
																			Return = "ENTER",
																			CapsLock = "CAPS",
																			Tab = "TAB",
																		}

																		local function fn40(arg7)
																			if not arg7 then
																				return nil
																			end
																			local v124 = string.gsub(tostring(arg7), "Enum.KeyCode.", "")
																			local v125 = tbl31[v124] or v124
																			local str9

																			if not (#v125 > 5) then
																				str9 = v125
																			else
																				str9 = string.sub(v125, 1, 5)
																			end

																			return string.upper(str9)
																		end

																		local instance27 = Instance.new("TextButton")
																		instance27.Name = "Bind"
																		instance27.Size = UDim2.fromOffset(36, 12)
																		instance27.Position = UDim2.new(1, -3, 0.5, 0)
																		instance27.AnchorPoint = Vector2.new(1, 0.5)
																		instance27.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
																		instance27.BackgroundTransparency = 0.15
																		instance27.AutoButtonColor = false
																		instance27.BorderSizePixel = 0
																		instance27.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
																		instance27.TextSize = 8
																		instance27.Text = "BIND"
																		instance27.TextColor3 = Color3.fromRGB(120, 124, 140)
																		instance27.ZIndex = 5
																		instance27.Parent = textButton3
																		local uiCorner9 = Instance.new("UICorner")
																		uiCorner9.CornerRadius = UDim.new(0, 5)
																		uiCorner9.Parent = instance27
																		local uiStroke3 = Instance.new("UIStroke")
																		uiStroke3.Color = Color3.fromRGB(48, 52, 70)
																		uiStroke3.Thickness = 1
																		uiStroke3.Transparency = 0.55
																		uiStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
																		uiStroke3.Parent = instance27
																		local flag23 = false

																		local function fn41()
																			if flag23 then
																				instance27.Text = "PRESS"
																				instance27.TextColor3 = Color3.fromRGB(235, 235, 245)
																				instance27.BackgroundColor3 = Color3.fromRGB(45, 36, 64)
																				uiStroke3.Color = Color3.fromRGB(167, 139, 250)
																				uiStroke3.Transparency = 0
																				return
																			end

																			local v124 = fn40(index._config._keybinds[str8])
																			instance27.Text = v124 or "None"
																			instance27.TextColor3 = v124 and Color3.fromRGB(196, 181, 253) or Color3.fromRGB(120, 130, 140)
																			instance27.BackgroundColor3 = v124 and Color3.fromRGB(31, 27, 48) or Color3.fromRGB(24, 26, 34)
																			uiStroke3.Color = v124 and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(48, 52, 70)
																			uiStroke3.Transparency = v124 and 0.35 or 0.55
																		end

																		local function fn42()
																			for _, v124 in scrollingFrame3:GetChildren() do
																				local isTextButton = v124:IsA("TextButton") and v124:FindFirstChild("Bind")

																				if isTextButton then
																					local v125 = fn40(index._config._keybinds[arg6.flag .. "_" .. v124.Text])
																					isTextButton.Text = v125 or "BIND"
																					isTextButton.TextColor3 = v125 and Color3.fromRGB(196, 181, 253) or Color3.fromRGB(120, 124, 140)
																					isTextButton.BackgroundColor3 = v125 and Color3.fromRGB(31, 27, 48) or Color3.fromRGB(24, 26, 34)
																					local uiStroke4 = isTextButton:FindFirstChildOfClass("UIStroke")

																					if uiStroke4 then
																						uiStroke4.Color = v125 and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(48, 52, 70)
																						uiStroke4.Transparency = v125 and 0.35 or 0.75
																					end
																				end
																			end
																		end

																		fn41()

																		instance27.MouseEnter:Connect(function()
																			if flag23 then
																				return
																			end
																			TweenService:Create(uiStroke3, TweenInfo.new(0.15), { Transparency = 0.1 }):Play()
																		end)

																		instance27.MouseLeave:Connect(function()
																			if flag23 then
																				return
																			end
																			fn41()
																		end)

																		instance27.MouseButton2Click:Connect(function()
																			if flag23 then
																				return
																			end
																			index._config._keybinds[str8] = nil
																			obj:save(game.GameId, index._config)
																			fn41()
																		end)

																		instance27.MouseButton1Click:Connect(function()
																			if index._choosing_keybind or flag23 then
																				return
																			end
																			index._choosing_keybind = true
																			flag23 = true
																			fn41()
																			local connection2 = nil

																			connection2 = v92.InputBegan:Connect(function(input, gameProcessed)
																				if gameProcessed or input.UserInputType ~= Enum.UserInputType.Keyboard then
																					return
																				end
																				connection2:Disconnect()
																				flag23 = false
																				index._choosing_keybind = false
																				if input.KeyCode == Enum.KeyCode.Escape then
																					fn41()
																					return
																				end

																				if input.KeyCode == Enum.KeyCode.Backspace then
																					index._config._keybinds[str8] = nil
																				else
																					local str9 = tostring(input.KeyCode)

																					for _, v124 in arg6.options, nil, nil do
																						local v125 = "string"
																						local str10 = arg6.flag .. "_" .. (typeof(v124) == v125 and v124 or v124.Name)

																						if str10 ~= str8 and index._config._keybinds[str10] == str9 then
																							index._config._keybinds[str10] = nil
																						end
																					end

																					index._config._keybinds[str8] = str9
																				end

																				obj:save(game.GameId, index._config)
																				fn42()
																			end)
																		end)
																	end

																	local instance27 = Instance.new("UIGradient")
																	local numberSequence4 = NumberSequence.new
																	local tbl31 = {}
																	local v124 = NumberSequenceKeypoint.new(0, 0)
																	local v125 = NumberSequenceKeypoint.new(0.704, 0)
																	local v126 = NumberSequenceKeypoint.new(0.872, 0.36250001192092896)
																	local new6 = NumberSequenceKeypoint.new
																	local v127 = 1
																	tbl31[1] = v124
																	tbl31[2] = v125
																	tbl31[3] = v126

																	do
																		local values = table.pack(new6(1, v127))
																		table.move(values, 1, values.n, 4, tbl31)
																	end

																	instance27.Transparency = numberSequence4(tbl31)
																	instance27.Parent = textButton3

																	textButton3.MouseButton1Click:Connect(function()
																		if not index._config._flags[arg6.flag] then
																			index._config._flags[arg6.flag] = {}
																		end

																		if arg6.multi_dropdown then
																			if table.find(index._config._flags[arg6.flag], v123) then
																				index:remove_table_value(index._config._flags[arg6.flag], v123)
																			else
																				table.insert(index._config._flags[arg6.flag], v123)
																			end
																		end

																		tbl29:update(v123)
																	end)

																	if not (k > arg6.maximum_options) then
																		tbl29._size = tbl29._size + 19
																		scrollingFrame3.Size = UDim2.fromOffset(207, tbl29._size)
																	end
																end
															end

															tbl29.New = function(arg7, arg8)
																instance23:Destroy(true)
																arg8.OrderValue = instance23.LayoutOrder
																tbl28._multiplier = tbl28._multiplier - n36
																return tbl28:create_dropdown(arg8)
															end

															if index:flag_type(arg6.flag, "string") then
																tbl29:update(index._config._flags[arg6.flag])

																if false then -- recovered opaque guard
																	error("Unreachable obfuscation trap")
																end
															else
																tbl29:update(arg6.options[1])
															end

															instance23.MouseButton1Click:Connect(function()
																tbl29:unfold_settings()

																if false then -- recovered opaque guard
																	error("Unreachable obfuscation trap")
																end
															end)

															if arg6.bindable then
																obj2[arg6.flag .. "_option_binds"] = v92.InputBegan:Connect(function(input, gameProcessed)
																	if gameProcessed then
																		return
																	end

																	if index._choosing_keybind then
																		return
																	end

																	if input.UserInputType ~= Enum.UserInputType.Keyboard then
																		return
																	end

																	for _, v123 in arg6.options, nil, nil do
																		local v124 = index._config._keybinds[arg6.flag .. "_" .. (typeof(v123) == "string" and v123 or v123.Name)]
																		if v124 and tostring(input.KeyCode) == v124 then
																			tbl29:update(v123)
																			break
																		end
																	end
																end)
															end

															return tbl29
														end

														tbl28.create_feature = function(arg5, arg6)
															v117 += 1
															local flag23 = arg6.history == true
															local flag24 = arg6.no_image == true
															local n36 = flag24 and 22
															local n37

															if n36 then
																n37 = n36
															else
																n37 = flag23 and 30 or 22
															end

															if arg5._size == 0 then
																arg5._size = 11
															end

															arg5._size = arg5._size + n37 + 6

															if tbl28._state then
																instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size)
															end

															frame9.Size = UDim2.new(1, -8, 0, arg5._size)
															local instance23 = Instance.new("Frame")
															instance23.Name = "Feature"
															instance23.Size = UDim2.new(0, 207, 0, n37)
															instance23.BackgroundColor3 = flag24 and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(22, 24, 32)
															instance23.BackgroundTransparency = flag24 and 0.9 or 0.9
															instance23.BorderSizePixel = 0
															instance23.Parent = frame9
															instance23.LayoutOrder = v117
															local uiCorner8 = Instance.new("UICorner")
															uiCorner8.CornerRadius = UDim.new(0, 4)
															uiCorner8.Parent = instance23
															local uiStroke3 = nil

															if not flag24 then
																if true then -- recovered opaque guard
																	uiStroke3 = Instance.new("UIStroke")
																	uiStroke3.Color = Color3.fromRGB(38, 42, 58)
																	uiStroke3.Transparency = 0.35
																	uiStroke3.Thickness = 1
																	uiStroke3.Parent = instance23
																else
																	error("Unreachable obfuscation trap")
																end
															end

															local instance24 = Instance.new("TextButton")
															instance24.BackgroundTransparency = 1
															instance24.BorderSizePixel = 0
															instance24.Size = UDim2.new(1, 0, 1, 0)
															instance24.Text = ""
															instance24.AutoButtonColor = false
															instance24.ZIndex = 2
															instance24.Parent = instance23
															local imageLabel3 = Instance.new("ImageLabel")
															imageLabel3.Name = "Thumb"
															imageLabel3.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
															imageLabel3.BackgroundTransparency = 0.2
															imageLabel3.BorderSizePixel = 0
															imageLabel3.Size = UDim2.new(0, flag23 and 22 or 16, 0, flag23 and 22 or 16)
															imageLabel3.Position = UDim2.new(0, 6, 0.5, 0)
															imageLabel3.AnchorPoint = Vector2.new(0, 0.5)
															imageLabel3.Image = arg6.image or "rbxassetid://10734966447"
															imageLabel3.ScaleType = Enum.ScaleType.Crop
															imageLabel3.ZIndex = 3
															imageLabel3.Visible = arg6.no_image ~= true
															imageLabel3.Parent = instance23
															local uiCorner9 = Instance.new("UICorner")
															uiCorner9.CornerRadius = UDim.new(0, 5)
															uiCorner9.Parent = imageLabel3
															local textLabel7 = Instance.new("TextLabel")
															textLabel7.BackgroundTransparency = 1
															textLabel7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
															textLabel7.Text = arg6.title or "Checkbox"
															textLabel7.TextColor3 = Color3.fromRGB(235, 235, 245)
															textLabel7.TextTransparency = 0.2
															textLabel7.TextSize = flag24 and 12 or flag23 and 11 or 12
															textLabel7.TextXAlignment = flag24 and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
															textLabel7.TextTruncate = Enum.TextTruncate.AtEnd
															textLabel7.Position = UDim2.new(0, flag24 and 0 or flag23 and 34 or 26, 0, 0)
															textLabel7.Size = UDim2.new(1, flag24 and 0 or flag23 and -100 or -70, 1, 0)
															textLabel7.ZIndex = 3
															textLabel7.Parent = instance23

															if arg6.subtitle and flag23 and not arg6.no_image then
																textLabel7.Position = UDim2.new(0, 34, 0, 5)
																textLabel7.Size = UDim2.new(1, -62, 0, 13)
																local instance25 = Instance.new("TextLabel")
																instance25.BackgroundTransparency = 1
																instance25.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
																instance25.Text = arg6.subtitle
																instance25.TextColor3 = Color3.fromRGB(160, 170, 180)
																instance25.TextTransparency = 0.15
																instance25.TextSize = 9
																instance25.TextXAlignment = Enum.TextXAlignment.Left
																instance25.TextTruncate = Enum.TextTruncate.AtEnd
																instance25.Position = UDim2.new(0, 34, 0, 15)
																instance25.Size = UDim2.new(1, -62, 0, 14)
																instance25.ZIndex = 3
																instance25.Parent = instance23
															end

															instance24.MouseEnter:Connect(function()
																TweenService:Create(instance23, TweenInfo.new(0.18), {
																	BackgroundColor3 = flag24 and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(32, 34, 46),
																	BackgroundTransparency = flag24 and 0 or 0.12,
																}):Play()

																if uiStroke3 then
																	TweenService:Create(uiStroke3, TweenInfo.new(0.18), { Color = Color3.fromRGB(139, 92, 246), Transparency = 0.25 }):Play()
																end
															end)

															instance24.MouseLeave:Connect(function()
																TweenService:Create(instance23, TweenInfo.new(0.18), {
																	BackgroundColor3 = flag24 and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(22, 24, 32),
																	BackgroundTransparency = flag24 and 0.9 or 0.12,
																}):Play()

																if uiStroke3 then
																	TweenService:Create(uiStroke3, TweenInfo.new(0.18), { Color = Color3.fromRGB(38, 42, 58), Transparency = 0.3 }):Play()
																end
															end)

															instance24.MouseButton1Click:Connect(function()
																if arg6.button_callback then
																	arg6.button_callback()
																end
															end)

															if flag23 then
																if arg6.on_delete then
																	local textButton3 = Instance.new("TextButton")
																	textButton3.Name = "Reset"
																	textButton3.AnchorPoint = Vector2.new(1, 0.5)
																	textButton3.Position = UDim2.new(1, -6, 0.5, 0)
																	textButton3.Size = UDim2.new(0, 18, 0, 18)
																	textButton3.BackgroundColor3 = Color3.fromRGB(40, 24, 32)
																	textButton3.BackgroundTransparency = 0.05
																	textButton3.BorderSizePixel = 0
																	textButton3.Text = "×"
																	textButton3.TextColor3 = Color3.fromRGB(248, 113, 113)
																	textButton3.TextSize = 14
																	textButton3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
																	textButton3.AutoButtonColor = false
																	textButton3.ZIndex = 4
																	textButton3.Parent = instance23
																	local instance25 = Instance.new("UICorner")
																	instance25.CornerRadius = UDim.new(0, 5)
																	instance25.Parent = textButton3

																	textButton3.MouseEnter:Connect(function()
																		textButton3.BackgroundColor3 = Color3.fromRGB(80, 28, 36)
																	end)

																	textButton3.MouseLeave:Connect(function()
																		textButton3.BackgroundColor3 = Color3.fromRGB(40, 24, 32)
																	end)

																	textButton3.MouseButton1Click:Connect(function()
																		arg6.on_delete()
																	end)
																end
															else
																if not index._config._flags then
																	index._config._flags = {}
																end

																if not index._config._flags[arg6.flag] then
																	index._config._flags[arg6.flag] = { checked = false, BIND = arg6.default or "Unknown" }
																end

																local checked = index._config._flags[arg6.flag].checked
																local textButton3 = Instance.new("TextButton")
																textButton3.AnchorPoint = Vector2.new(1, 0.5)
																textButton3.Position = UDim2.new(1, -6, 0.5, 0)
																textButton3.Size = UDim2.new(0, 16, 0, 16)
																textButton3.BackgroundColor3 = checked and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(18, 18, 24)
																textButton3.Text = ""
																textButton3.AutoButtonColor = false
																textButton3.ZIndex = 5
																textButton3.Parent = instance23
																local uiCorner10 = Instance.new("UICorner")
																uiCorner10.CornerRadius = UDim.new(0, 4)
																uiCorner10.Parent = textButton3
																local uiStroke4 = Instance.new("UIStroke")
																uiStroke4.Color = Color3.fromRGB(139, 92, 246)
																uiStroke4.Thickness = 1
																uiStroke4.Parent = textButton3

																textButton3.MouseButton1Click:Connect(function()
																	checked = not checked
																	textButton3.BackgroundColor3 = checked and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(18, 18, 24)
																	index._config._flags[arg6.flag].checked = checked
																	obj:save(game.GameId, index._config)

																	if arg6.callback then
																		arg6.callback(checked)
																	end
																end)

																if arg6.callback then
																	arg6.callback(checked)

																	if false then -- recovered opaque guard
																		error("Unreachable obfuscation trap")
																	end
																end
															end

															return {
																instance = instance23,
																remove = function()
																	if not instance23.Parent then
																		return
																	end
																	instance23:Destroy()
																	arg5._size = math.max(11, arg5._size - n37 - 6)
																	frame9.Size = UDim2.new(1, -8, 0, arg5._size)

																	if tbl28._state then
																		instance16.Size = UDim2.new(1, -8, 0, 93 + arg5._size + tbl28._multiplier)
																	end
																end,
															}
														end

														return tbl28
													end

													return tbl26
												end

												obj2.library_visiblity = v92.InputBegan:Connect(function(input)
													if input.KeyCode ~= Enum.KeyCode.RightControl then
														return
													end

													if getgenv().guilibraryVisible then
														arg._ui.Enabled = not arg._ui.Enabled
													elseif true then -- recovered opaque guard
														arg._ui_open = not arg._ui_open
														arg:change_visiblity(arg._ui_open)
													else
														error("Unreachable obfuscation trap")
													end
												end)

												arg._ui.Container.Handler.Minimize.MouseButton1Click:Connect(function()
													arg._ui_open = not arg._ui_open
													arg:change_visiblity(arg._ui_open)
												end)

												return arg
											end
										end
-- Removed unmatched end from the supplied fragment.

									do
										v84 = index.new()
										Combat = v84:create_tab("Combat", "rbxassetid://76499042599127")
										Detection = v84:create_tab("Detection", "rbxassetid://10734951847")
										Misc = v84:create_tab("Misc", "rbxassetid://10734887784")
										Optimization = v84:create_tab("Optimization", "rbxassetid://10734966248")
										v85 = cloneref(game:GetService("RunService"))
										v90 = cloneref(game:GetService("Players"))
										v86 = cloneref(game:GetService("Stats"))
										v87 = cloneref(game:GetService("ReplicatedStorage"))
										cloneref(game:GetService("CoreGui"))
										v88 = cloneref(game:GetService("UserInputService"))

										do
											local v92 = cloneref(game:GetService("Debris"))
											cloneref(game:GetService("ContextActionService"))
											alive = workspace:FindFirstChild("Alive") or workspace:WaitForChild("Alive")
											runtime = workspace.Runtime
											tbl19 = {}
											localPlayer = v90.LocalPlayer
											localPlayer2 = v90.LocalPlayer
											virtualInputManager = Instance.new("VirtualInputManager")
											tbl20 = {}

											Optimization:create_module({
												title = "No Render",
												flag = "No_Render",
												description = "Disables rendering of effects",
												section = "left",
												callback = function(disabled)
													localPlayer.PlayerScripts.EffectScripts.ClientFX.Disabled = disabled

													if disabled then
														tbl20["No Render"] = workspace.Runtime.ChildAdded:Connect(function(child)
															v92:AddItem(child, 0)
														end)
													elseif true then -- recovered opaque guard
														if tbl20["No Render"] then
															tbl20["No Render"]:Disconnect()
															tbl20["No Render"] = nil
														end
													else
														error("Unreachable obfuscation trap")
													end
												end,
											}):change_state(false)
										end
									end

									do
										local function fn32(arg)
											return (arg:gsub("^DFInt", ""):gsub("^DFFlag", ""):gsub("FString", ""):gsub("FLog", ""):gsub("^FFlag", ""):gsub("^DFint", ""):gsub("^FInt", ""))
										end

										v91 = false
										str7 = ""
										local tbl23 = {}
										local tbl24 = {}

										local function fn33(arg)
											if getfflag then
												local ok, result = pcall(getfflag, fn32(arg))
												if ok and result then
													return fn32(arg)
												end
												local ok2, result2 = pcall(getfflag, arg)
												if ok2 and result2 then
													return arg
												end
											end

											return fn32(arg)
										end

										fn30 = function(arg)
											if not setfflag then
												warn("this executor isnt supported, for using fflags.")
												return false
											end

											if false then -- removed opaque flag guard
												return
											end

											task.spawn(function()
												os.clock()
												local v92 = 0
												tbl24 = {}

												for k, v93 in pairs(arg) do
													local v94 = fn33(k)

													pcall(function()
														if tbl23[v94] == nil and getfflag then
															tbl23[v94] = getfflag(v94)
														end

														setfflag(v94, v93)
														v92 += 1
														table.insert(tbl24, v94)
													end)
												end
											end)

											return true
										end

										fn31 = function()
											if not setfflag then
												return
											end

											task.spawn(function()
												if true then -- recovered opaque guard
													if true then -- recovered opaque guard
														local n = 0

														for _, v92 in ipairs(tbl24) do
															local v93 = tbl23[v92]

															if v93 ~= nil then
																if pcall(setfflag, v92, v93) then
																	n += 1
																end
															end
														end

														tbl24 = {}
													else
														error("Unreachable obfuscation trap")
													end

													return
												end

												error("Unreachable obfuscation trap")
											end)
										end
									end
-- Removed unmatched end from the supplied fragment.

								do
									do
										do
											do
												do
													local function fn32(arg)
														if not arg or arg:gsub("%s", "") == "" then
															return nil
														end

														local ok, result = pcall(function()
															return v89:JSONDecode(arg)
														end)

														if ok then
															local v92 = "table"
															ok = type(result) == v92
														end

														if ok then
															return result
														end
														local tbl23 = {}
														local flag21 = false

														for match in arg:gmatch("[^,;\n]+") do
															local match2, v92 = match:match("^%s*([%w_%.]+)%s*=%s*(.-)%s*$")

															if match2 and v92 then
																tbl23[match2] = v92
																flag21 = true
															end
														end

														if flag21 then
															return tbl23
														end
														return nil
													end

													local function fn33()
														local v92 = fn32(str7)
														if not v92 then
															warn("[Invalid FFlags.]")
															return false
														end
														return fn30(v92)
													end

													Optimization:create_module({
														title = "Custom FFlags",
														flag = "Custom_FFlags_Enabled",
														description = "Toggle ON to apply, OFF to restore originals",
														section = "left",
														callback = function(arg)
															v91 = arg

															if arg then
																fn33()
															else
																fn31()
															end
														end,
													}):create_textbox({
														title = "￬ FFlag ￬",
														placeholder = "e.g. {\"DFIntTaskSchedulerTargetFps\":\"240\"}",
														flag = "Custom_FFlags",
														section = "left",
														multiline = true,
														height = 70,
														max_height = 260,
														callback = function(arg)
															if true then -- recovered opaque guard
																str7 = arg

																if v91 then
																	local v92 = fn32(arg)
																	if not v92 then
																		warn("Inalid Input.")
																		return
																	end
																	fn30(v92)
																end

																return
															end

															error("Unreachable obfuscation trap")
														end,
													})
												end
											end

											do
												local function fn32()
													local flag21 = false
													local uiBackgroundUrl = index._config._flags.UI_Background_URL or ""
													local n = index._config._flags["UI_Background_Transparency"] or 25
													local n36 = 0
													local imageLabel = nil
													local videoFrame = nil
													local instance = nil
													local n37 = 0

													local function fn33()
														local request_ = syn and syn.request or http and http.request or http_request
														local request_2

														if request_ then
															request_2 = request_
														else
															request_2 = fluxus and fluxus.request
														end

														return request_2 or request
													end

													local function fn34()
														if not isfolder("WindsRecovered") then
															makefolder("WindsRecovered")
														end

														if not isfolder("Winds/Background") then
															makefolder("Winds/Background")
														end
													end

													local function fn35(arg)
														return (tostring(arg or ""):gsub("%%(%x%x)", function(arg2)
															return string.char(tonumber(arg2, 16))
														end))
													end

													local function fn36(arg)
														local str8 = tostring(arg or "")
														local match, v92 = str8:match("discordapp%.net/external/[^/]+/(https?)/(.+)")
														if match and v92 then
															return match .. "://" .. (v92:match("([^?]+)") or v92)
														end
														local match2 = str8:match("discordapp%.net/external/[^/]+/(https?%%3A%%2F%%2F[^%s]+)")
														if match2 then
															return fn35(match2:match("([^?]+)") or match2)
														end
														return str8
													end

													local function fn37(arg, arg2)
														if type(arg) ~= "table" then
															return nil
														end
														local v92 = string.lower(arg2)

														for k, v93 in pairs(arg) do
															if string.lower(tostring(k)) == v92 then
																return v93
															end
														end
													end

													local function fn38(arg)
														if true then -- recovered opaque guard
															local v92 = "string"
															if typeof(arg) ~= v92 then
																return false
															end
															local v93 = string.lower(arg:sub(1, 120))
															return v93:find("<!doctype", 1, true) ~= nil or v93:find("<html", 1, true) ~= nil
														end

														error("Unreachable obfuscation trap")
													end

													local function fn39(arg)
														local v92 = "string"
														return typeof(arg) == v92 and #arg >= 64 and not fn38(arg)
													end

													local function fn40(arg, arg2, arg3)
														local match = string.lower(arg or "")
														match = match:match("([^?]+)") or match
														local v92 = string.lower(arg3 or "")
														local str8 = typeof(arg2) == "string" and arg2:sub(1, 16) or ""
														local v93 = "ftyp"
														if str8:sub(5, 8) == v93 then
															return "video", "mp4"
														end
														local v94 = "GIF87a"
														if str8:sub(1, 6) == v94 or str8:sub(1, 6) == "GIF89a" then
															return "image", "gif"
														end

														if str8:sub(1, 8) == "\137PNG\r\n\26\n" then
															return "image", "png"
														end

														if not (str8:byte(1) == 255 and str8:byte(2) == 216) then
															if str8:sub(1, 4) == "RIFF" and typeof(arg2) == "string" and arg2:sub(9, 12) == "WEBP" then
																return "image", "webp"
															end

															if v92:find("video") then
																return "video", "mp4"
															end

															if v92:find("png") then
																return "image", "gif"
															end

															if v92:find("gif") then
																return "image", "png"
															end

															if v92:find("jpeg") or v92:find("jpg") then
																return "image", "jpg"
															end

															if v92:find("webp") then
																return "image", "webp"
															end

															if match:match("%.mp4$") or match:match("%.webm$") then
																return "video", "mp4"
															end

															if match:match("%.gif$") then
																return "image", "gif"
															end

															if match:match("%.png$") then
																return "image", "png"
															end

															if match:match("%.jpe?g$") then
																return "image", "jpg"
															end

															if match:match("%.webp$") then
																return "image", "webp"
															end
															return "image", "gif"
														end

														if true then -- recovered opaque guard
															return "image", "jpg"
														end

														error("Unreachable obfuscation trap")
													end

													local function fn41(arg)
														if not arg then
															return nil
														end
														local match = arg:match("^%s*(.-)%s*$") or arg

														if not (match:match("^rbxassetid://") or match:match("^rbxasset://")) then
															if match:match("^(%d+)$") then
																return "rbxassetid://" .. match
															end
															local v92 = string.lower(match)

															if v92:find("roblox.com", 1, true) or v92:find("rbxcdn.com", 1, true) then
																local match2 = match:match("[?&]id=(%d+)") or match:match("rbxassetid://(%d+)")
																if match2 then
																	return "rbxassetid://" .. match2
																end
															end

															return nil
														end

														local v92 = 0
														if true then -- recovered opaque guard
															return match
														end

														error("Unreachable obfuscation trap")
													end

													local function fn42()
														local container = v84._ui and v84._ui:FindFirstChild("Container")
														if not container then
															return nil
														end

														if not imageLabel then
															imageLabel = Instance.new("ImageLabel")
															imageLabel.Name = "CustomBackground"
															imageLabel.BackgroundTransparency = 1
															imageLabel.BorderSizePixel = 0
															imageLabel.Size = UDim2.fromScale(1, 1)
															imageLabel.Position = UDim2.fromScale(0, 0)
															imageLabel.ScaleType = Enum.ScaleType.Crop
															imageLabel.ZIndex = 0
															imageLabel.Visible = false
															imageLabel.Parent = container
															local instance2 = Instance.new("UICorner")
															instance2.CornerRadius = UDim.new(0, 16)
															instance2.Parent = imageLabel
														end

														if not videoFrame then
															videoFrame = Instance.new("VideoFrame")
															videoFrame.Name = "CustomBackgroundVideo"
															videoFrame.BackgroundTransparency = 1
															videoFrame.BorderSizePixel = 0
															videoFrame.Size = UDim2.fromScale(1, 1)
															videoFrame.Position = UDim2.fromScale(0, 0)
															videoFrame.Looped = true
															videoFrame.Volume = 0
															videoFrame.ZIndex = 0
															videoFrame.Visible = false
															videoFrame.Parent = container
															local uiCorner = Instance.new("UICorner")
															uiCorner.CornerRadius = UDim.new(0, 16)
															uiCorner.Parent = videoFrame
														end

														if not instance then
															instance = Instance.new("Frame")
															instance.Name = "Background"
															instance.BackgroundColor3 = Color3.fromRGB(14, 12, 16)
															instance.BorderSizePixel = 0
															instance.Size = UDim2.fromScale(1, 1)
															instance.ZIndex = 1
															instance.Visible = false
															instance.Parent = container
															local uiCorner = Instance.new("UICorner")
															uiCorner.CornerRadius = UDim.new(0, 16)
															uiCorner.Parent = instance
														end

														return container
													end

													local function fn43(arg)
														n = tonumber(arg) or 25
														local imageTransparency = math.clamp(n / 100, 0, 1)

														if imageLabel then
															imageLabel.ImageTransparency = imageTransparency
														end

														if instance then
															instance.BackgroundTransparency = 1 - imageTransparency
														end
													end

													local function fn44()
														if not videoFrame then
															return
														end

														task.spawn(function()
															local now2 = os.clock()

															while videoFrame and videoFrame.Parent and not videoFrame.IsLoaded and os.clock() - now2 < 8 do
																task.wait()
															end

															if videoFrame and videoFrame.Visible then
																pcall(function()
																	videoFrame.Looped = true
																	videoFrame.Volume = 0
																	videoFrame:Play()
																end)
															end
														end)
													end

													local function fn45()
														if imageLabel then
															imageLabel.Visible = false
															imageLabel.Image = ""
														end

														if videoFrame then
															pcall(function()
																videoFrame:Pause()
															end)

															videoFrame.Visible = false
															videoFrame.Video = ""
														end

														if instance then
															instance.Visible = false
														end
													end

													local function fn46(arg)
														fn42()
														fn43(n)

														if arg == "video" then
															if imageLabel then
																imageLabel.Visible = false
																imageLabel.Image = ""
															end

															if videoFrame then
																videoFrame.Visible = true
																fn44()
															end

															if instance then
																instance.Visible = n > 0
															end
														else
															if videoFrame then
																pcall(function()
																	videoFrame:Pause()
																end)

																videoFrame.Visible = false
																videoFrame.Video = ""
															end

															if imageLabel then
																imageLabel.Visible = true
															end

															if instance then
																instance.Visible = false
															end
														end
													end

													local function fn47(arg, arg2)
														if type(arg2) ~= "string" or arg2 == "" then
															return nil
														end

														if arg2:match("^https?://") then
															return arg2
														end
														local match = arg:match("^(https?://[^/]+)")
														if not match then
															return nil
														end

														if arg2:sub(1, 1) == "/" then
															return match .. arg2
														end
														return (arg:match("^(https?://.+)/") or match) .. "/" .. arg2
													end

													local fn48 = nil

													fn48 = function(arg, arg2)
														local n38 = arg2 or 0
														if n38 > 6 then
															return nil, nil
														end
														local v92 = fn33()
														local body = nil
														local v93 = nil

														if v92 then
															local ok, result = pcall(v92, {
																Url = arg,
																Method = "GET",
																Headers = {
																	["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
																	Accept = "*/*",
																	["Accept-Language"] = "en-US,en;q=0.9",
																	["Referer"] = "https://discord.com/",
																},
															})

															local flag22

															if ok then
																local v94 = "table"
																flag22 = type(result) == v94
															else
																flag22 = ok
															end

															body = nil
															v93 = nil

															if flag22 then
																local num = tonumber(result.StatusCode or result.Status)
																local headers = result.Headers
																v93 = fn37(headers, "Content-Type")

																if num and num >= 300 and num < 400 then
																	local v94 = fn47(arg, fn37(headers, "Location"))
																	body = nil
																	if v94 then
																		return fn48(v94, n38 + 1)
																	end
																else
																	local flag23 = num == 200 or num == 201 or num == 206
																	body = nil

																	if flag23 then
																		body = result.Body
																	end
																end
															end
														end

														if not fn39(body) then
															local ok, result = pcall(function()
																return game:HttpGet(arg)
															end)

															if ok then
																body = result
															end
														end

														if not fn39(body) then
															return nil, v93
														end
														return body, v93
													end

													local function fn49(arg)
														for _, v92 in ipairs(arg) do
															local v93, v94 = fn48(v92)
															if fn39(v93) then
																return v93, v94, v92
															end
														end
													end

													local function fn50(arg, arg2)
														local flag22 = arg == "video" and videoFrame or imageLabel
														if not flag22 then
															return false
														end
														local now2 = os.clock()

														while true do
															local parent = flag22.Parent

															if parent then
																parent = os.clock() - now2 < (arg2 or 5)
															end

															if parent then
																if flag22.IsLoaded == true then
																	return true
																end
																task.wait()
																continue
															end

															break
														end

														return flag22.IsLoaded == true
													end

													local function fn51(arg, arg2)
														n37 += 1
														local match = arg:match("%.([%w]+)$") or "png"
														local v92 = ""
														local str8 = "winds_bg_" .. tostring(os.time()) .. v92 .. tostring(n37) .. "." .. match
														writefile(str8, arg2)
														task.wait(0.15)
														local genv = getgenv and getgenv() or {}
														local getcustomasset_ = genv.getcustomasset or getcustomasset or genv.getsynasset or getsynasset
														if type(getcustomasset_) ~= "function" then
															return nil
														end
														local ok, result = pcall(getcustomasset_, str8, true)
														if ok and typeof(result) == "string" and result ~= "" then
															return result
														end
														local ok2, result2 = pcall(getcustomasset_, str8)

														if ok2 then
															local v93 = "string"
															ok2 = typeof(result2) == v93
														end

														if ok2 and result2 ~= "" then
															return result2
														end
														return nil
													end

													local function fn52(arg, arg2)
														fn42()

														for _, v92 in ipairs(arg2) do
															if type(v92) == "string" and v92 ~= "" then
																local ok

																if arg == "video" then
																	ok = pcall(function()
																		videoFrame.Video = v92
																		videoFrame.Looped = true
																		videoFrame.Volume = 0
																		videoFrame:Play()
																	end)
																else
																	ok = pcall(function()
																		imageLabel.Image = v92
																	end)
																end

																if ok then
																	fn46(arg)

																	if arg ~= "video" then
																		if imageLabel then
																			imageLabel.Image = ""
																			imageLabel.Image = v92
																		end

																		return true
																	end

																	if fn50(arg, arg == "video" and 2.5 or v92:match("^https?://") and 2 or 4) then
																		if arg == "video" then
																			fn44()
																		end

																		return true
																	end
																end
															end
														end

														return false
													end

													local function fn53(arg, arg2)
														n36 += 1
														local v92 = n36

														task.spawn(function()
															if not flag21 then
																fn45()
																return
															end
															arg = tostring(arg or ""):match("^%s*(.-)%s*$") or ""
															if arg == "" then
																fn45()
																return
															end

															if not fn42() then
																return
															end
															local v93 = fn41(arg)

															if v93 then
																if v92 ~= n36 then
																	return
																end
																local tbl23 = { v93, arg }
																if fn52(fn40(arg), tbl23) then
																	return
																end
															end

															fn34()
															local v94 = fn36(arg)

															if imageLabel then
																imageLabel.Image = ""
															end

															local tbl23 = { v94 }

															if v94 ~= arg then
																table.insert(tbl23, arg)
															end

															local v95, v96, v97 = fn49(tbl23)
															if v92 ~= n36 then
																return
															end

															if not fn39(v95) then
																if not arg2 then
																	index.SendNotification({ title = "Background", text = "Failed to download URL", duration = 5 })
																end

																return
															end

															local v98, v99 = fn40(v97 or v94, v95, v96)
															pcall(writefile, "Winds/Background/source.txt", arg)
															pcall(writefile, "Winds/Background/kind.txt", v98 .. "|" .. v99)
															if v92 ~= n36 then
																return
															end
															local v100

															if v98 then
																v100 = v98
															else
																v100 = fn40(v97 or v94, v95, v96)
															end

															if v100 == "video" then
																local mp4 = fn51("clip.mp4", v95)

																if mp4 then
																	fn42()

																	pcall(function()
																		videoFrame.Video = ""
																		videoFrame.Video = mp4
																		videoFrame.Looped = true
																		videoFrame.Volume = 0
																		videoFrame:Play()
																	end)

																	fn46("video")
																	if fn50("video", 5) then
																		fn44()
																		return
																	end

																	pcall(function()
																		videoFrame:Pause()
																		videoFrame.Visible = false
																		videoFrame.Video = ""
																	end)
																end

																if not arg2 then
																	index.SendNotification({
																		title = "Background",
																		text = "This MP4 can't play. Use PNG or JPG.",
																		duration = 5,
																	})
																end

																return
															end

															local v101 = fn51("winds_bg." .. (v99 or "png"), v95)
															if fn52("image", { v101 }) then
																return
															end

															if not arg2 then
																index.SendNotification({ title = "Background", text = "Couldn't load this file on your executor", duration = 3 })
															end
														end)
													end

													local v92 = Optimization:create_module({
														title = "Background Changer",
														flag = "UI_Background_Changer",
														description = "PNG, GIF, or MP4 wallpaper from a URL",
														section = "left",
														callback = function(arg)
															flag21 = arg

															if arg then
																fn53(uiBackgroundUrl, true)
															else
																fn45()
															end
														end,
													})

													v92:create_textbox({
														title = "URL",
														placeholder = "https://... .png",
														flag = "UI_Background_URL",
														callback = function(arg)
															uiBackgroundUrl = arg

															if flag21 then
																fn53(arg, false)
															end
														end,
													})

													v92:create_slider({
														title = "Transparency",
														flag = "UI_Background_Transparency",
														minimum_value = 0,
														maximum_value = 100,
														value = 25,
														round_number = true,
														callback = function(arg)
															fn43(arg)
														end,
													})

													local uiBackgroundSaveName = index._config._flags.UI_Background_SaveName or ""
													local flag22 = false
													local v93 = nil

													local function fn54()
														local uiBackgroundHistory = index._config._flags.UI_Background_History
														local v94 = "table"

														if type(uiBackgroundHistory) ~= v94 then
															local uiBackgroundHistory2 = {}
															index._config._flags.UI_Background_History = uiBackgroundHistory2
															uiBackgroundHistory = uiBackgroundHistory2
														end

														return uiBackgroundHistory
													end

													local function fn55()
														local tbl23 = { "None" }

														for _, v94 in ipairs(fn54()) do
															if v94.name then
																table.insert(tbl23, v94.name)
															end
														end

														return tbl23
													end

													local function fn56(arg)
														for _, v94 in ipairs(fn54()) do
															if v94.name == arg then
																return v94
															end
														end
													end

													local function fn57()
														return {
															title = "Saved wallpapers",
															flag = "UI_Background_Selected",
															options = fn55(),
															maximum_options = 16,
															multi_dropdown = false,
															callback = function(arg)
																if flag22 then
																	return
																end
																local v94 = "string"
																local name = typeof(arg) == v94 and arg or arg and arg.Name
																if not name or name == "None" then
																	return
																end
																local v95 = fn56(name)
																if not v95 then
																	return
																end
																uiBackgroundUrl = v95.url or ""
																index._config._flags.UI_Background_URL = uiBackgroundUrl
																obj:save(game.GameId, index._config)

																if flag21 then
																	fn53(uiBackgroundUrl, false)
																end
															end,
														}
													end

													local function fn58()
														if false then -- removed opaque flag guard
															return
														end

														if not v93 then
															return
														end
														flag22 = true
														local v94 = fn57()
														v94.Order = true
														v93 = v93:New(v94)
														flag22 = false
													end

													v92:create_textbox({
														title = "Save name",
														placeholder = "Wallpaper name",
														flag = "UI_Background_SaveName",
														callback = function(arg)
															uiBackgroundSaveName = arg
														end,
													})

													v92:create_feature({
														history = true,
														no_image = true,
														title = "Save Wallpaper",
														button_callback = function()
															local match = tostring(uiBackgroundUrl or ""):match("^%s*(.-)%s*$") or ""
															if match == "" then
																index.SendNotification({ title = "Background", text = "Put a wallpaper URL first", duration = 2 })
																return
															end
															local match2 = tostring(uiBackgroundSaveName or ""):match("^%s*(.-)%s*$") or ""
															local v94 = fn54()

															if match2 == "" then
																match2 = "Wallpaper " .. tostring(#v94 + 1)
															end

															for _, v95 in ipairs(v94) do
																if v95.name == match2 then
																	v95.url = match
																	v95.thumb = imageLabel and imageLabel.Image or v95.thumb or ""
																	obj:save(game.GameId, index._config)
																	fn58()
																	index.SendNotification({ title = "Background", text = "Updated " .. match2, duration = 2 })
																	return
																end
															end

															if 14 <= #v94 then
																table.remove(v94, 1)
															end

															table.insert(v94, { name = match2, url = match, thumb = imageLabel and imageLabel.Image or "" })
															obj:save(game.GameId, index._config)
															fn58()
															index.SendNotification({ title = "Background", text = "Saved " .. match2, duration = 2 })
														end,
													})

													local createDropdown = v92.create_dropdown
													local v94 = fn57()
													v93 = createDropdown(v92, v94)

													v92:create_feature({
														history = true,
														no_image = true,
														title = "Delete Wallpaper",
														button_callback = function()
															local v95 = index._config._flags["UI_Background_Selected"]
															local name = typeof(v95) == "string" and v95 or v95 and v95.Name
															if not name or name == "None" then
																index.SendNotification({ title = "Background", text = "Select a saved wallpaper first", duration = 2 })
																return
															end
															local v96 = fn54()

															for i, v97 in ipairs(v96) do
																if v97.name == name then
																	table.remove(v96, i)
																	break
																end
															end

															index._config._flags.UI_Background_Selected = "None"
															obj:save(game.GameId, index._config)
															fn58()
															index.SendNotification({ title = "Background", text = "Loaded " .. name, duration = 2 })
														end,
													})

													v92._size = v92._size + 8
												end

												fn32()
											end

											do
												local function fn32()
													local deviceSpoof = "Off"

													if isfile and isfile("Winds/device_spoof.txt") then
														deviceSpoof = tostring(readfile("Winds/device_spoof.txt") or "Off"):gsub("%s+", "")
													end

													if deviceSpoof == "" then
														deviceSpoof = "Off"
													end

													if deviceSpoof == "Off" and index._config._flags.Device_Spoof then
														deviceSpoof = index._config._flags.Device_Spoof
													end

													if deviceSpoof == "Tablet" then
														deviceSpoof = "Phone"
													end

													index._config._flags.Device_Spoof = deviceSpoof
													getgenv()._WindsSpoofDevice = deviceSpoof

													local function fn33(arg)
														if arg == "Console" then
															return Enum.UserInputType.Gamepad1
														end

														if arg == "Phone" or arg == "Tablet" then
															return Enum.UserInputType.Touch
														end
														return Enum.UserInputType.MouseMovement
													end

													local function fn34(deviceSpoof2)
														if not isfolder("WindsRecovered") then
															makefolder("WindsRecovered")
														end

														if deviceSpoof2 == "Off" then
															if isfile and isfile("Winds/device_spoof.txt") then
																delfile("Winds/device_spoof.txt")
															end

															if isfile and isfile("Winds/device_boot.luau") then
																delfile("Winds/device_boot.luau")
															end
														else
															writefile("Winds/device_spoof.txt", deviceSpoof2)
														end

														index._config._flags.Device_Spoof = deviceSpoof2
														obj:save(game.GameId, index._config)
													end

													local function fn35(arg, arg2)
														if type(arg) ~= "table" then
															return
														end

														local v92 = ({
															PC = {
																TouchEnabled = false,
																MouseEnabled = true,
																KeyboardEnabled = true,
																GamepadEnabled = false,
															},
															Phone = {
																TouchEnabled = true,
																MouseEnabled = false,
																KeyboardEnabled = false,
																GamepadEnabled = false,
															},
															Tablet = { TouchEnabled = true, MouseEnabled = false, KeyboardEnabled = true, GamepadEnabled = false },
															Console = {
																TouchEnabled = false,
																MouseEnabled = false,
																KeyboardEnabled = false,
																GamepadEnabled = true,
															},
														})[arg2]

														if v92 then
															for k, v93 in pairs(v92) do
																rawset(arg, k, v93)
															end
														end

														rawset(arg, "GetLastInputType", function()
															return fn33(getgenv()._WindsSpoofDevice or arg2)
														end)
													end

													local function fn36()
														local getupvalue_ = getupvalue or debug and debug.getupvalue
														local setupvalue_ = setupvalue or debug and debug.setupvalue
														if not (getconnections and getupvalue_ and setupvalue_) then
															return
														end

														local function fn37(arg)
															for _, v92 in getconnections(arg) do
																local function_ = v92.Function

																if type(function_) == "function" then
																	local v93 = getupvalue_(function_, 1)
																	local v94 = getupvalue_(function_, 2)

																	if not (type(v93) ~= "function" or type(v94) ~= "table" or v94.OnChange == nil) then
																		if not getgenv()._WindsOrigGetDevice then
																			getgenv()._WindsOrigGetDevice = v93
																		end

																		setupvalue_(function_, 1, function()
																			local windsSpoofDevice = getgenv()._WindsSpoofDevice
																			if windsSpoofDevice and windsSpoofDevice ~= "Off" then
																				return windsSpoofDevice
																			end
																			local windsOrigGetDevice = getgenv()._WindsOrigGetDevice
																			if windsOrigGetDevice then
																				return windsOrigGetDevice()
																			end
																			return "PC"
																		end)
																	end
																end
															end
														end

														pcall(function()
															fn37(require(v87:WaitForChild("UserInputService")).LastInputTypeChanged)
														end)

														pcall(function()
															fn37(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"))
														end)

														pcall(function()
															fn37(localPlayer.PlayerGui:GetPropertyChangedSignal("ScreenOrientation"))
														end)
													end

													local function fn37(arg)
														return arg ~= nil and type(arg.FireServer) == "function"
													end

													local function fn38(arg)
														if arg == "Phone" then
															return "Mobile"
														end

														if arg == "Console" then
															return "Console"
														end
														return "PC"
													end

													local function fn39(arg)
														local v92 = fn38(arg)
														local duelUI = localPlayer:FindFirstChild("PlayerGui")
														duelUI = duelUI and duelUI:FindFirstChild("DuelUI")
														if not duelUI or not duelUI.Enabled then
															return
														end

														for _, v93 in duelUI:GetDescendants() do
															if v93.Name == "PlayerName" and v93:IsA("TextLabel") and v93.Text == localPlayer.Name then
																local device = v93.Parent and v93.Parent:FindFirstChild("Device", true)

																if device then
																	for _, v94 in device:GetChildren() do
																		if v94:IsA("GuiObject") then
																			v94.Visible = v94.Name == v92 or v94.Name == arg
																		end
																	end
																end
															end
														end
													end

													local function fn40(arg)
														pcall(function()
															local DuelController = require(v87.Controllers.DuelController)
															if not DuelController or not DuelController.AddPlayer or getgenv()._WindsDuelAddHook then
																return
															end
															getgenv()._WindsDuelAddHook = true
															local addPlayer = DuelController.AddPlayer

															DuelController.AddPlayer = function(arg2, arg3, arg4, arg5)
																addPlayer(arg2, arg3, arg4, arg5)

																if arg5 == localPlayer.UserId then
																	task.defer(function()
																		fn39(getgenv()._WindsSpoofDevice or arg)
																	end)
																end
															end
														end)
													end

													local v92 = nil

													local function fn41(arg)
														if not arg or arg == "Off" or v92 == arg then
															return
														end
														local getupvalue_ = getupvalue or debug and debug.getupvalue

														if getconnections and getupvalue_ then
															pcall(function()
																for _, v93 in getconnections(require(v87.ClientGameModules.DeviceListener).OnChange) do
																	local function_ = v93.Function

																	if type(function_) == "function" and fn37(getupvalue_(function_, 1)) then
																		v92 = arg
																		function_(arg)
																		break
																	end
																end
															end)
														end

														fn40(arg)

														if not getgenv()._WindsDuelPaint then
															getgenv()._WindsDuelPaint = true

															task.spawn(function()
																while true do
																	local windsSpoofDevice = getgenv()._WindsSpoofDevice

																	if not (not windsSpoofDevice or windsSpoofDevice == "Off") then
																		fn39(windsSpoofDevice)
																		task.wait(0.4)
																		continue
																	end

																	break
																end

																getgenv()._WindsDuelPaint = nil
															end)
														end
													end

													local function fn42(windsSpoofDevice)
														if windsSpoofDevice == "Off" then
															getgenv()._WindsSpoofDevice = nil
															fn36()
															return
														end

														getgenv()._WindsSpoofDevice = windsSpoofDevice
														fn35(require(v87:WaitForChild("UserInputService")), windsSpoofDevice)
														fn36()
														local DeviceListener = require(v87.ClientGameModules.DeviceListener)
														DeviceListener.Device = windsSpoofDevice

														if DeviceListener.State and DeviceListener.State.Set then
															DeviceListener.State:Set(windsSpoofDevice)
														end

														fn41(windsSpoofDevice)
													end

													getgenv()._WindsOrigGetDevice = nil
													local flag21 = false

													local function fn43()
														return syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
													end

													local function fn44()
														local v93 = fn43()
														if type(v93) ~= "function" then
															return
														end

														if not isfolder("WindsRecovered") then
															if false then -- recovered opaque guard
																error("Unreachable obfuscation trap")
															end

															makefolder("WindsRecovered")
														end

													local function fn45()
														local v93 = cloneref(game:GetService("TeleportService"))
														local v94 = localPlayer

														task.delay(1.2, function()
															if not pcall(function()
																v93:TeleportToPlaceInstance(game.PlaceId, game.JobId, v94)
															end) then
																pcall(function()
																	v93:Teleport(game.PlaceId, v94)
																end)
															end
														end)
													end

													if deviceSpoof ~= "Off" then
														task.spawn(function()
															task.wait(0.4)
															fn42(deviceSpoof)
															fn44()
															task.wait(2)
															fn42(deviceSpoof)
														end)
													end

													local v93 = false

													Optimization:create_module({
														title = "Device Spoofer",
														flag = "Device_Spoof_Mod",
														description = "Serversided. Rejoins to apply.",
														section = "left",
														callback = function()
														end,
													}):create_dropdown({
														title = "Device",
														flag = "Device_Spoof",
														options = { "Off", "PC", "Console", "Phone" },
														maximum_options = 4,
														multi_dropdown = false,
														callback = function(arg)
															if not v93 then
																return
															end
															local v94 = "string"
															arg = typeof(arg) == v94 and arg or arg and arg.Name or "Off"
															fn34(arg)
															fn42(arg)
															fn44()

															index.SendNotification({
																title = "Device Spoofer",
																text = arg == "Off" and "Rejoining..." or "Rejoining as " .. arg,
																duration = 5,
															})

															fn45()
														end,
													})

													task.defer(function()
														v93 = true
													end)
												end

												fn32()
											end
										end

										do
											flag18 = false
											getgenv().TriggerbotInfinityDetection = false
											getgenv().TriggerbotKeypress = false

											do
												local v92 = false
												getgenv().TriggerbotNotify = v92
											end
										end

										n33 = 0
										flag19 = false
										SelectedParryType = "Camera"
										System = {}
										System.autoparry = {}
										System.parry = {}
										System.ball = {}
										System.detection = {}

										System.detection = {
											__ball_properties = {
												__aerodynamic_time = tick(),
												__last_warping = tick(),
												__lerp_radians = 0,
												__curving = tick(),
											},
										}

										do
											local Data = nil
											local NoobParryEnabled = nil

											task.spawn(function()
												local ReplicatedStorage = game:GetService("ReplicatedStorage")
												local ok, result = pcall(require, ReplicatedStorage.Packages.Replion)
												local flag21

												if ok then
													local v92 = "table"
													flag21 = type(result) == v92
												else
													flag21 = ok
												end

												if flag21 and result.Client and result.Client.WaitReplion then
													Data = result.Client:WaitReplion("Data")
												end

												local ServerInfo = require(ReplicatedStorage.ServerInfo)
												local Utils = require(ReplicatedStorage.Common.Utils)
												NoobParryEnabled = not ServerInfo.isDungeonsMatchServer() and not ServerInfo.isRankedMatchServer() and not ServerInfo.isMedalServer() and not ServerInfo.isClanWarServer() and not ServerInfo.isTournamentMatchServer() and Utils.FFlag.GetInstantFFlag("NoobParryEnabled", true)
											end)

											local function fn32()
												if not Data then
													return nil
												end
												local timesParried = Data:Get("timesParried") or 0
												local n

												if timesParried == 0 then
													n = 1.5
												elseif timesParried == 1 then
													n = 1.25
												elseif timesParried == 2 then
													n = 1
												elseif timesParried == 3 then
													n = 0.75
												else
													n = 0.5

													if timesParried == 4 then
														n = 0.625
													end
												end

												if NoobParryEnabled then
													local Kills = Data:Get("TotalStats.Kills") or 0

													if Kills < 20 then
														n = Kills / 20 * n
													end
												end

												return n
											end
										end
									end

									-- Removed orphaned remote discovery block; native-input fallback is used.
 do
ParryCD = nil
										selectedTarget = nil
										Closest_Entity = nil

										System.__properties = {
											__autoparry_enabled = true,
											__connections = {},
											__auto_spam_enabled = false,
											__ability_esp_enabled = false,
											__spam_threshold = 1.5,
											__manual_spam_enabled = false,
										}

										do
											local tbl23 = {}

											if not pcall(function()
												for _, child in pairs(v87.Misc.DataAbilities:GetChildren()) do
													local attribute = child:GetAttribute("Icon")

													if attribute then
														tbl23[child.Name] = attribute
													end
												end
											end) then
												warn("Failed to load ability icons")
											end
										end
									end

									System.__properties.slashesoffury_active = false

									System.__config = {
										__detections = {
											infinity = false,
											deathslash = false,
											dribble = false,
											timehole = false,
											forcefield = false,
											slashesoffury = false,
											phantom = false,
										},
									}

									System.__state = {}

									System.__state = {
										infinity_active = false,
										deathslash_active = false,
										timehole_active = false,
										slashes_active = false,
									}

									tbl21 = {}
									ParryCD = nil
									selectedTarget = nil

									do
										local v92 = nil
										local n = 0
										local flag21 = false

										tbl21.Parry_Animation = function()
											local grabParry = v87.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
											local attribute = localPlayer.Character:GetAttribute("CurrentlyEquippedSword")
											if not attribute then
												return
											end

											if not grabParry then
												return
											end
											local v93 = v87.Shared.ReplicatedInstances.Swords.GetSword:Invoke(attribute)
											if not v93 or not v93.AnimationType then
												return
											end

											for _, v94 in v87.Shared.SwordAPI.Collection:GetChildren() do
												if v94.Name == v93.AnimationType then
													if v94:FindFirstChild("GrabParry") or v94:FindFirstChild("Grab") then
														local str8 = "GrabParry"

														if v94:FindFirstChild("Grab") then
															str8 = "Grab"
														end

														grabParry = v94[str8]
													end
												end
											end

											for _, v94 in localPlayer.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
												if v94.Name == "GrabParry" or v94.Name == "Grab" then
													v94.TimePosition = 0
													v94:Stop(v94:GetAttribute("StopFadeTime") or 0.1)
												elseif v94.Name == "SuccessParry" or v94.Name == "Success" then
													v94:Stop(v94:GetAttribute("StopFadeTime") or 0.1)
												end
											end

											v92 = localPlayer.Character.Humanoid.Animator:LoadAnimation(grabParry)
											v92:Play(v92:GetAttribute("PlayFadeTime") or 0, v92:GetAttribute("PlayWeight") or 1, v92:GetAttribute("PlaySpeed") or 1)
										end

										tbl21.Play_Animation = function()
											if os.clock() - n >= 0.19999999999999996 or flag21 then
												n = os.clock()
												flag21 = false
												tbl21.Parry_Animation()
											end
										end

										v87.Remotes.ParrySuccess.OnClientEvent:Connect(function()
											flag21 = true
											local humanoid = localPlayer.Character:FindFirstChild("Humanoid")

											if true then -- recovered opaque guard
												if humanoid then
													for _, v93 in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
														if v93.Name == "GrabParry" or v93.Name == "Grab" then
															v93:Stop(v93:GetAttribute("StopFadeTime") or 0.1)
														end
													end
												end

												return
											end

											error("Unreachable obfuscation trap")
										end)
									end
								end

								do
									do
										local tbl23 = {}

										tbl11 = {
											Apply = function(arg, arg2)
												if true then -- recovered opaque guard
													for k, v92 in arg2, nil, nil do
														arg[k] = v92
													end

													return
												end

												error("Unreachable obfuscation trap")
											end,
											Billboard = function(arg, arg2)
												if arg == localPlayer then
													return
												end
												local head = (arg2 or arg.Character or arg.CharacterAdded:Wait()):WaitForChild("Head")
												local billboardGui = Instance.new("BillboardGui")

												tbl11.Apply(billboardGui, {
													Adornee = head,
													Size = UDim2.new(0, 200, 0, 42),
													StudsOffset = Vector3.new(0, 3, 0),
													AlwaysOnTop = true,
													Parent = head,
												})

												local instance = Instance.new("TextLabel")

												tbl11.Apply(instance, {
													Size = UDim2.new(1, 0, 1, 0),
													Text = "",
													TextColor3 = Color3.fromRGB(255, 255, 255),
													TextSize = 15,
													TextWrapped = false,
													BackgroundTransparency = 1,
													TextXAlignment = Enum.TextXAlignment.Center,
													TextYAlignment = Enum.TextYAlignment.Center,
													Parent = billboardGui,
												})

												tbl23[arg] = instance
											end,
										}

										local tbl24 = {}
										local tbl25 = {}
										local tbl26 = {}
										local Abilities = require(game:GetService("ReplicatedStorage").Shared.Abilities)

										local tbl27 = {
											"Quad Jump",
											"Luck",
											"Reaper",
											"Misfortune",
											"Martyrdom",
											"Golden Ball",
											"Tact",
											"Scopophobia",
											"Bounty",
											"Qi-Charge",
											"Guardian Angel",
											"Virus",
										}

										local tbl28 = {
											["Guardian Angel"] = {
												ChargeAttr = "GuardianAngelParriesLeft",
												MaxCharges = 2,
											},
											["Quantum Arena"] = {
												ChargeAttr = "QuantumArenaCharge",
												MaxCharges = 5,
											},
											Necromancer = {
												ChargeAttr = "NecromancersLeft",
												MaxCharges = 5,
											},
											Blink = { ChargeAttr = "BlinkLeft", MaxCharges = 5 },
										}

										GetChargeInfo = function(arg, arg2)
											local v92 = tbl28[arg2]
											if not v92 then
												return nil
											end
											local playerFromCharacter = game.Players:GetPlayerFromCharacter(arg)
											local v93 = nil

											if arg:GetAttribute(v92.ChargeAttr) ~= nil then
												v93 = arg
											end

											if not (not v93 and playerFromCharacter and playerFromCharacter:GetAttribute(v92.ChargeAttr) ~= nil) then
												playerFromCharacter = v93
											end

											if not playerFromCharacter then
												local abilities = arg:FindFirstChild("Abilities")

												if abilities and abilities:GetAttribute(v92.ChargeAttr) ~= nil then
													playerFromCharacter = abilities
												end
											end

											playerFromCharacter = playerFromCharacter or arg
											local attribute = playerFromCharacter:GetAttribute(v92.ChargeAttr) or 0
											local maxCharges = v92.MaxCharges or 2

											if v92.MaxChargesAttr then
												maxCharges = playerFromCharacter:GetAttribute(v92.MaxChargesAttr) or maxCharges
											end

											local n = nil

											if v92.NextUseAttr then
												local attribute2 = playerFromCharacter:GetAttribute(v92.NextUseAttr)
												n = nil

												if attribute2 then
													local n36 = attribute2 - workspace:GetServerTimeNow()
													n = nil

													if n36 > 0 then
														n = tick() + n36
													end

													if false then -- removed missing opaque flag guard
														return
													end
												end
											end

											return { Charges = attribute, MaxCharges = maxCharges, CDEnd = n }
										end

										Misc:create_module({
											title = "Ablity ESP",
											flag = "Ability_Esp",
											description = "Ability Esp",
											section = "right",
											callback = function(arg)
												if arg then
													tbl20["Ability ESP"] = v85.Heartbeat:Connect(function()
														local alive2 = workspace.Alive
														local dataAbilities = v87.Misc.DataAbilities

														for _, v92 in v90:GetPlayers() do
															if v92 and v92 ~= localPlayer2 and v92.Character then
																if not tbl25[v92] then
																	tbl25[v92] = true

																	tbl20["Ability CD Tracker"] = v92.Character:GetAttributeChangedSignal("AbilityActive"):Connect(function()
																		if v92.Character:GetAttribute("AbilityActive") then
																			local attribute = v92:GetAttribute("EquippedAbility")
																			local v93 = Abilities.getAbilityCooldown(v92, attribute)
																			local serverTimeNow = workspace:GetServerTimeNow()
																			tbl24[v92] = serverTimeNow

																			if v93 and v93 > 0 then
																				tbl26[v92] = serverTimeNow + v93
																			end
																		else
																			local v93 = tbl24[v92]

																			if v93 then
																				local n = workspace:GetServerTimeNow() - v93
																			end

																			tbl24[v92] = nil
																		end
																	end)
																end

																local attribute = v92:GetAttribute("EquippedAbility")
																local v93 = tbl23[v92]

																if v93 then
																	local parent = v93.Parent
																	local abilityImage = parent:FindFirstChild("AbilityImage")

																	if v92.Character.Parent == alive2 then
																		v93.Visible = true

																		if attribute then
																			local attribute2 = dataAbilities:FindFirstChild(attribute)
																			local attribute3 = attribute2 and attribute2:GetAttribute("Icon")
																			attribute2 = attribute2 and attribute2:GetAttribute("Icon1")
																			local upgrades = v92:FindFirstChild("Upgrades")
																			upgrades = upgrades and upgrades:FindFirstChild(attribute)

																			if (upgrades and upgrades.Value or 0) > 0 then
																				if attribute2 and attribute2 ~= "" then
																					attribute3 = attribute2
																				end
																			end

																			local v94 = tbl26[v92]
																			local flag21 = not v92.Character:GetAttribute("AbilityActive") and not v94
																			local v95 = tbl28[attribute]
																			local str8

																			if table.find(tbl27, attribute) then
																				str8 = "Passive"
																			elseif v95 then
																				local v96 = GetChargeInfo(v92.Character, attribute)

																				if v96 then
																					str8 = string.format("%d/%d Charges", v96.Charges, v96.MaxCharges)

																					if v96.CDEnd then
																						local n = v96.CDEnd - tick()

																						if n > 0 then
																							str8 ..= string.format(" (%.1fs)", n)
																						end
																					end
																				else
																					str8 = "Charged"
																				end
																			elseif v92.Character:GetAttribute("AbilityActive") then
																				local v96 = tbl24[v92]

																				if v96 then
																					str8 = string.format("ACTIVE %.1fs", workspace:GetServerTimeNow() - v96)
																				else
																					str8 = "ACTIVE"
																				end
																			else
																				local v96 = tbl26[v92]

																				if v96 then
																					local n = v96 - workspace:GetServerTimeNow()

																					if n > 0 then
																						str8 = string.format("%.1fs", n)
																					else
																						tbl26[v92] = nil
																						str8 = "Ready"
																					end
																				else
																					str8 = ""

																					if flag21 then
																						str8 = "Ready"
																					end
																				end
																			end

																			v93.Text = v92.DisplayName .. " [" .. attribute .. " | " .. str8 .. "]"

																			if not abilityImage then
																				local imageLabel = Instance.new("ImageLabel")
																				imageLabel.Name = "AbilityImage"
																				imageLabel.BackgroundTransparency = 1
																				imageLabel.Size = UDim2.new(0, 30, 0, 30)
																				imageLabel.Parent = parent
																				imageLabel.Position = UDim2.new(0.5, -30, 0, 0)
																				abilityImage = imageLabel
																			end

																			abilityImage.Position = UDim2.new(0.5, -15, 0, -v93.TextBounds.Y)

																			if attribute3 and attribute3 ~= "" then
																				abilityImage.Image = attribute3
																				abilityImage.Visible = true
																			else
																				abilityImage.Visible = false
																			end
																		else
																			v93.Visible = false
																			v93.Text = v92.DisplayName

																			if abilityImage then
																				abilityImage.Visible = false
																			end
																		end
																	else
																		v93.Visible = false

																		if abilityImage then
																			abilityImage.Visible = false
																		end
																	end
																end
															end
														end
													end)
												else
													for _, v92 in tbl23, nil, nil do
														v92.Visible = false
														local abilityImage = v92.Parent:FindFirstChild("AbilityImage")

														if abilityImage then
															abilityImage.Visible = false
														end
													end

													if tbl20["Ability ESP"] then
														tbl20["Ability ESP"]:Disconnect()
														tbl20["Ability ESP"] = nil
													end
												end
											end,
										})

										task.spawn(function()
											for _, v92 in v90:GetPlayers() do
												if v92 ~= localPlayer2 then
													tbl11.Billboard(v92)
												end

												v92.CharacterAdded:Connect(function(character)
													tbl11.Billboard(v92, character)
												end)
											end

											v90.PlayerAdded:Connect(function(player)
												if player ~= localPlayer2 then
													player.CharacterAdded:Connect(function(character)
														tbl11.Billboard(player, character)
													end)
												end
											end)

											v90.PlayerRemoving:Connect(function(player)
												if true then -- recovered opaque guard
													tbl23[player] = nil
													return
												end

												error("Unreachable obfuscation trap")
											end)
										end)
									end

									n34 = 1
									getgenv().Parry_Range = 0
									n35 = 50

									fn29 = function()
										if HumanizerEnabled and getgenv().RandomMin and getgenv().RandomMax then
											local n = getgenv().RandomMin + math.random() * (getgenv().RandomMax - getgenv().RandomMin)
											n34 = 0.7 + (n - 1) * 0.0020202020202020202
											return n
										end

										n34 = 0.1 + (n35 - 1) * 0.0020202020202020202
										return n35
									end

									do
										local balls = workspace:WaitForChild("Balls")

										tbl21.Get_Ball = function()
											for _, v92 in balls:GetChildren() do
												if v92:GetAttribute("realBall") then
													return v92
												end
											end
										end

										tbl21.Get_Balls = function()
											local tbl23 = {}

											for _, v92 in balls:GetChildren() do
												if v92:GetAttribute("realBall") then
													table.insert(tbl23, v92)
												end
											end

											return tbl23
										end
									end
								end
							end

							do
								do
									local obj, fn30

									do
										obj = setmetatable({}, { __mode = "k" })

										do
											local v89 = nil
											local obj2 = setmetatable({}, { __mode = "k" })

											fn30 = function(arg)
												if obj2[arg] then
													return
												end
												obj2[arg] = true

												arg.OnClientEvent:Connect(function(arg2, arg3)
													local v90

													if typeof(arg2) == "Vector3" then
														v90 = arg2
														arg2 = arg3
													else
														v90 = arg3
													end

													if typeof(v90) ~= "Vector3" or typeof(arg2) ~= "Instance" or not arg2:IsA("BasePart") then
														return
													end
													v89 = arg
													local v91 = obj[arg2]

													if v91 then
														local now2 = os.clock()
														v91[1] = v90
														v91[2] = now2
													else
														obj[arg2] = { v90, os.clock() }
													end
												end)
											end
										end
									end

									do
										local function fn31()
											for _, descendant in ipairs(v87:GetDescendants()) do
												if descendant:IsA("UnreliableRemoteEvent") then
													fn30(descendant)
												end
											end
										end

										tbl21.Ball_Position = function(f)local U= obj [f];if U then local n=os.clock()-U[2];if n<=0.5 then if n<=0 then return U[1];end;local i=f:FindFirstChild("zoomies");local W=i and i.VectorVelocity or f.AssemblyLinearVelocity;return U[1]+W*math.min(n,0.25);end;end;return f.Position;end
										task.defer(fn31)
									end

									tbl19.ball_remote_added = v87.DescendantAdded:Connect(function(descendant)
										if descendant:IsA("UnreliableRemoteEvent") then
											fn30(descendant)
										end
									end)
								end

								tbl22 = { Curving = tick(), Lerp_Radians = 0, Last_Warping = tick() }

								tbl21.Lerp = function(arg, arg2, arg3)
									return arg + (arg2 - arg) * arg3
								end

								tbl21.Is_Curved = function(f)if not f then return false;end;local U=f:FindFirstChild("zoomies");if not U then return false;end;local i= localPlayer2 .Character;if not(i and(i:FindFirstChild("HumanoidRootPart")or i.PrimaryPart))then return false;end;i=U.VectorVelocity;local W=i.Unit;U= tbl21 .Ball_Position(f);if not U then return false;end;f=( localPlayer2 .Character.HumanoidRootPart.Position-U).Unit;local w=f:Dot(W);if getgenv().BackWardsAntiCurve then if w<-0.75 then return true;end;end;local j=i.Magnitude;local G,O=math.min(j/100,40),f:Dot((W-i).Unit);W,i,f=math.clamp(w-O,-1,1),( localPlayer2 .Character.HumanoidRootPart.Position-U).Magnitude,game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue();local r,q,_=0.5-f/1000,7*math.max(w,0),i/j-f/1000;O,U=15-math.min(i/1000,15)+q+G,math.clamp(w,-1,1);G=math.rad(math.asin(U)); tbl22 .Lerp_Radians= tbl21 .Lerp( tbl22 .Lerp_Radians,G,0.8);if i<O then return false;end;if W<r then return true;end;if  tbl22 .Lerp_Radians<0.018 then  tbl22 .Last_Warping=tick();end;if tick()- tbl22 .Last_Warping<_/1.5 then return true;end;if tick()- tbl22 .Curving<_/1.5 then return true;end;return w<r;end
								flag20 = v88.TouchEnabled and not v88.MouseEnabled

								tbl21.Closest_Player = function()
									local alive2 = workspace.Alive
									local character = localPlayer2.Character
									if not character or character.Parent ~= alive2 then
										Closest_Entity = nil
										return false
									end
									local huge = math.huge
									local v89 = nil

									for _, v90 in alive2:GetChildren() do
										if v90 and v90.Name ~= localPlayer2.Name then
											local humanoidRootPart = v90:FindFirstChild("HumanoidRootPart") or v90.PrimaryPart

											if humanoidRootPart then
												local v91 = localPlayer2:DistanceFromCharacter(humanoidRootPart.Position)

												if v91 < huge then
													huge = v91
													v89 = v90
												end
											end
										end
									end

									Closest_Entity = v89
									return Closest_Entity
								end

								do
									local v89 = nil

									tbl21.Closest_Aim = function()
										local alive2 = workspace.Alive
										if not localPlayer2.Character or localPlayer2.Character.Parent ~= alive2 then
											return false
										end
										local n = -math.huge
										local currentCamera = workspace.CurrentCamera
										local v90 = nil

										for _, v91 in alive2:GetChildren() do
											if v91 ~= localPlayer2.Character and v91.PrimaryPart then
												v91:FindFirstChildOfClass("Humanoid")
												local v92 = currentCamera.CFrame.LookVector:Dot((v91.PrimaryPart.Position - currentCamera.CFrame.Position).Unit)
												local v93, v94 = currentCamera:WorldToViewportPoint(v91.PrimaryPart.Position)

												if v94 and v92 > n then
													n = v92
													v90 = v91
												end
											end
										end

										v89 = v90
										return v89
									end
								end
							end

							do
								do
									local v89 = nil

									tbl21.Closest_Mouse = function()
										local alive2 = workspace.Alive
										if not localPlayer2.Character or localPlayer2.Character.Parent ~= alive2 then
											return false
										end
										local huge = math.huge
										local currentCamera = workspace.CurrentCamera
										local mouseLocation = game:GetService("UserInputService"):GetMouseLocation()
										local v90 = nil

										for _, v91 in alive2:GetChildren() do
											if v91 ~= localPlayer2.Character and v91.PrimaryPart then
												v91:FindFirstChildOfClass("Humanoid")
												local v92, v93 = currentCamera:WorldToViewportPoint(v91.PrimaryPart.Position)

												if v93 then
													local magnitude = (Vector2.new(v92.X, v92.Y) - mouseLocation).Magnitude

													if magnitude < huge and magnitude <= 300 then
														huge = magnitude
														v90 = v91
													end
												end
											end
										end

										v89 = v90
										return v89
									end
								end

								tbl21.FFA = function()
									local currentCamera = workspace.CurrentCamera
									local alive2 = workspace.Alive
									if not alive2 then
										return false
									end
									local v89 = tbl21.Get_Ball()
									if not v89 then
										return false
									end

									if not v89:FindFirstChild("zoomies") then
										return false
									end

									if #alive2:GetChildren() ~= 3 then
										return false
									end
									local attribute = v89:GetAttribute("from")
									local tbl23 = {}

									for _, v90 in alive2:GetChildren() do
										if v90 ~= localPlayer2.Character and v90.Name ~= attribute and v90.PrimaryPart then
											local v91, v92 = currentCamera:WorldToScreenPoint(v90.PrimaryPart.Position)

											if v92 then
												table.insert(tbl23, { Character = v90, Screen_Data = { v91.X, v91.Y } })
											end
										end
									end

									if #tbl23 < 1 then
										return false
									end
									return tbl23[math.random(1, #tbl23)]
								end

								tbl21.select_target_by_mouse = function()
									local tbl23 = {}

									for _, v89 in workspace.Alive:GetChildren() do
										if v89.Name ~= localPlayer2.Name and v89.PrimaryPart then
											table.insert(tbl23, v89)
										end
									end

									local currentCamera = workspace.CurrentCamera
									local mouseLocation = game:GetService("UserInputService"):GetMouseLocation()
									local direction = currentCamera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y).Direction
									local n = -math.huge
									local v89 = nil

									for _, v90 in tbl23, nil, nil do
										local v91 = direction:Dot((v90.PrimaryPart.Position - currentCamera.CFrame.Position).Unit)

										if n < v91 then
											n = v91
											v89 = v90
										end
									end

									return v89
								end

								tbl21.Get_Crosshair_Target = function()
									local currentCamera = workspace.CurrentCamera
									local alive2 = workspace.Alive
									if not alive2 then
										return false
									end
									local viewportSize = currentCamera.ViewportSize
									local vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
									local huge = math.huge
									local tbl23 = nil

									for _, v89 in alive2:GetChildren() do
										if v89 ~= localPlayer2.Character and v89.PrimaryPart then
											local v90, v91 = currentCamera:WorldToScreenPoint(v89.PrimaryPart.Position)

											if v91 then
												local magnitude = (Vector2.new(v90.X, v90.Y) - vector2).Magnitude

												if magnitude < huge then
													tbl23 = { Character = v89, Screen_Data = { v90.X, v90.Y } }
													huge = magnitude
												end
											end
										end
									end

									return tbl23
								end

								tbl21.Parry_Data = function(arg)
									tbl21.Closest_Player()
									tbl21.Closest_Mouse()
									tbl21.Closest_Aim()

									if game:GetService("UserInputService").TouchEnabled then
										Vector2_Mouse_Location = { workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 }
									else
										local mouseLocation = game:GetService("UserInputService"):GetMouseLocation()
										Vector2_Mouse_Location = { mouseLocation.X, mouseLocation.Y }
									end

									local tbl23 = {}

									for _, v89 in workspace.Alive:GetChildren() do
										local humanoidRootPart = v89:FindFirstChild("HumanoidRootPart") or v89.PrimaryPart

										if humanoidRootPart then
											tbl23[v89.Name] = workspace.CurrentCamera:WorldToScreenPoint(humanoidRootPart.Position)
										end
									end

									if arg == "Camera" then
										local tbl24 = {}
										local v89 = Vector2_Mouse_Location
										local cframe = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + workspace.CurrentCamera.CFrame.LookVector)
										tbl24[1] = 0
										tbl24[2] = cframe
										tbl24[3] = tbl23
										tbl24[4] = v89
										return tbl24
									end

									if arg == "Force Dot" then
										local v89 = tbl21.Get_Crosshair_Target()

										if v89 then
											local screenData = v89.Screen_Data

											return {
												0,
												CFrame.new(localPlayer2.Character.PrimaryPart.Position, v89.Character.PrimaryPart.Position),
												tbl23,
												screenData,
											}
										end

										local tbl24 = {}
										local cframe = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + workspace.CurrentCamera.CFrame.LookVector)
										local v90 = Vector2_Mouse_Location
										tbl24[1] = 0
										tbl24[2] = cframe
										tbl24[3] = tbl23
										tbl24[4] = v90
										return tbl24
									end

									if arg == "Dot" then
										local currentCamera = workspace.CurrentCamera
										local v89 = tbl21.select_target_by_mouse()
										local position = v89 and v89.PrimaryPart and v89.PrimaryPart.Position or localPlayer2.Character.PrimaryPart.Position + currentCamera.CFrame.LookVector * 1000
										local v90 = Vector2_Mouse_Location

										return {
											0,
											CFrame.lookAt(localPlayer2.Character.PrimaryPart.Position, position + Vector3.new(0, 2, 0)),
											tbl23,
											v90,
										}
									end

									if arg == "FFA" then
										local v89 = tbl21.FFA()

										if v89 then
											local screenData = v89.Screen_Data

											return {
												0,
												CFrame.new(localPlayer2.Character.PrimaryPart.Position, v89.Character.PrimaryPart.Position),
												tbl23,
												screenData,
											}
										end

										local tbl24 = {}
										local cframe = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + workspace.CurrentCamera.CFrame.LookVector)
										local v90 = Vector2_Mouse_Location
										tbl24[1] = 0
										tbl24[2] = cframe
										tbl24[3] = tbl23
										tbl24[4] = v90
										return tbl24
									end

									if arg == "Backwards" then
										local n = -workspace.CurrentCamera.CFrame.LookVector * 10000
										local tbl24 = {}
										local cframe = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + Vector3.new(n.X, 0, n.Z))
										local v89 = Vector2_Mouse_Location
										tbl24[1] = 0
										tbl24[2] = cframe
										tbl24[3] = tbl23
										tbl24[4] = v89
										return tbl24
									end

									if arg == "Random" then
										local tbl24 = {}
										local random2 = math.random
										local cframe = CFrame.new(workspace.CurrentCamera.CFrame.Position, Vector3.new(math.random(-3000, 3000), math.random(-3000, 3000), random2(-3000, 3000)))
										local v89 = Vector2_Mouse_Location
										tbl24[1] = 0
										tbl24[2] = cframe
										tbl24[3] = tbl23
										tbl24[4] = v89
										return tbl24
									end

									return arg
								end

								workspace.Balls.ChildRemoved:Connect(function(child)
									child:SetAttribute("from", nil)
									child:SetAttribute("target", nil)
								end)

								-- The uploaded ExecuteParry body was empty. Reconstructed native-input fallback.
-- Camera/target modes cannot alter native F-key targeting through this fallback.
do
    local held = false
    ExecuteParry = function(_mode)
        if held or v88:GetFocusedTextBox() then return false end
        local character = localPlayer2.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false end
        held = true
        local ok, err = pcall(function()
            virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        end)
        if not ok then
            held = false
            warn("[Winds recovered] Native parry input failed: " .. tostring(err))
            return false
        end
        task.delay(0.03, function()
            pcall(function() virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game) end)
            held = false
        end)
        return true
    end
end

								v87.Remotes.InfinityBall.OnClientEvent:Connect(function(arg, infinityActive)
									System.__state.infinity_active = infinityActive or false
								end)

								getgenv().PhantomDetection = "Ability"
								getgenv().PhantomAccuracyValue = 90
								getgenv().PhantomAccuracyDuration = 5

								do
									local flag21 = false
									local v89 = nil

									v87.Remotes.Phantom.OnClientEvent:Connect(function(arg, arg2)
										if not System.__config.__detections.phantom then
											return
										end

										if arg2 and arg2.Name == localPlayer2.Name and getgenv().PhantomDetection == "Ability" then
											v87.Remotes.AbilityButtonPress:Fire()
										elseif arg and arg.Name == localPlayer2.Name and getgenv().PhantomDetection == "Accuracy" then
											if not flag21 then
												flag21 = true
												v89 = n35
												n35 = getgenv().PhantomAccuracyValue
												fn29()

												task.delay(getgenv().PhantomAccuracyDuration, function()
													n35 = v89
													fn29()
													flag21 = false
												end)
											end
										end
									end)
								end
							end

							do
								v87.Remotes.DeathBall.OnClientEvent:Connect(function(arg, deathslashActive)
									System.__state.deathslash_active = deathslashActive or false
								end)

								do
									local n = 0
									local n36 = 0

									tbl21.Invis_detection = function()
										if tick() - n < 0.25 then
											return n36
										end
										local tbl23 = {}

										for _, v89 in workspace.Alive:GetChildren() do
											if v89 ~= localPlayer2.Character then
												if v89:FindFirstChild("Invisibility") or v89:GetAttribute("Invisibility") then
													table.insert(tbl23, v89)
												end
											end
										end

										n = tick()
										n36 = #tbl23 >= 2
										return #tbl23 >= 2
									end
								end
							end

							getgenv().SlashOfFuryDetection = false

							do
								local v89 = false
								getgenv().sofactive = v89
							end
-- Removed unmatched end from the supplied fragment.

						local v89, Lighting

						do
							do
								do
									do
										do
											getgenv().sof_Parries = 1
											getgenv().sof_Delay = 0.12

											workspace:WaitForChild("Balls").ChildAdded:Connect(function(child)
												child.ChildAdded:Connect(function(child2)
													if getgenv().SlashOfFuryDetection and child2.Name == "ComboCounter" then
														local textLabel = child2:FindFirstChildOfClass("TextLabel")

														if textLabel then
															getgenv().sofactive = true

															while true do
																local num = tonumber(textLabel.Text)

																if num and num < getgenv().sof_Parries then
																	ExecuteParry(SelectedParryType)
																end

																task.wait(getgenv().sof_Delay)
																if not (not textLabel.Parent or not textLabel) then
																	continue
																end
																break
															end

															getgenv().sofactive = false
														end
													end
												end)
											end)

											System.autoparry = {}
											getgenv().Parry_Accuracy = 5
											getgenv().ParryStep = getgenv().ParryStep or "PreSimulation"

											do
												local tbl23 = {
													PreSimulation = v85.PreSimulation,
													PostSimulation = v85.PostSimulation,
													PreRender = v85.PreRender,
												}

												local function fn30()
													return tbl23[getgenv().ParryStep] or v85.PreSimulation
												end

												System.autoparry.start = function()
													if System.__properties.__connections.__autoparry then
														System.__properties.__connections.__autoparry:Disconnect()
													end

													System.__properties.__connections.__autoparry = fn30():Connect(function()
														if not System.__properties.__autoparry_enabled or not localPlayer.Character or not localPlayer.Character.PrimaryPart then
															return
														end
														local v90 = tbl21.Get_Ball()
														local v91 = tbl21.Get_Balls()
														local v92 = tbl21.Invis_detection()
														local exitTo = nil
														local zoomies, attribute, magnitude, v93, v94, n, v95, magnitude2, n36, n37, n38, v96, flag21, tornadoTime, n39, attribute2, primaryPart, maxShield, abilities, hotbar, visible, timeHole, deathslashActive, slashesoffuryActive, flag22, enabled, flag23, now2, flag24

														for _, v97 in pairs(v91) do
															if v97 then
																zoomies = v97:FindFirstChild("zoomies")

																if zoomies then
																	v97:GetAttributeChangedSignal("target"):Once(function()
																		flag19 = false
																	end)

																	if flag19 then
																		exitTo = 1
																		break
																	else
																		attribute = v97:GetAttribute("target")

																		if v90 then
																			v90:GetAttribute("target")
																		end

																		magnitude = zoomies.VectorVelocity.Magnitude
																		v93 = 12
																		v94 = 20
																		n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																		v95 = tbl21.Ball_Position(v97)

																		if v95 then
																			magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																			n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																			n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																			n38 = n37 + getgenv().Parry_Range
																			v96 = tbl21.Is_Curved(v97)
																			flag21 = attribute == localPlayer.Name
																			v96 = flag21 and v96

																			if not v96 then
																				if v97:FindFirstChild("AeroDynamicSlashVFX") then
																					v97.AeroDynamicSlashVFX:Destroy()
																					System.__properties.tornado_time = tick()
																				end

																				if runtime:FindFirstChild("Tornado") then
																					tornadoTime = System.__properties.tornado_time
																					n39 = tick() - tornadoTime
																					attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1

																					if not (n39 < attribute2 + 0.314159) then
																						primaryPart = localPlayer.Character.PrimaryPart

																						if not primaryPart:FindFirstChild("SingularityCape") then
																							maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																							abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																							hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																							visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																							timeHole = abilities and abilities:FindFirstChild("Time Hole")
																							timeHole = timeHole and timeHole.Enabled
																							abilities = abilities and abilities:FindFirstChild("Infinity")
																							abilities = abilities and abilities.Enabled

																							if getgenv().sofactive then
																								exitTo = 2
																								break
																							elseif System.__config.__detections.timehole then
																								timeHole = visible and timeHole

																								if not timeHole then
																									if System.__config.__detections.infinity then
																										abilities = visible and abilities

																										if not abilities then
																											if System.__config.__detections.forcefield then
																												maxShield = visible and maxShield

																												if not maxShield then
																													deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																													if not deathslashActive then
																														slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																														if not slashesoffuryActive then
																															flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																															if flag22 then
																																if getgenv().CooldownProtection then
																																	if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																		v87.Remotes.AbilityButtonPress:Fire()
																																	else
																																		exitTo = 6
																																		break
																																	end
																																elseif getgenv().AutoAbility then
																																	if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																		exitTo = 4
																																		break
																																	else
																																		enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																		if enabled then
																																			flag19 = true
																																			v87.Remotes.AbilityButtonPress:Fire()
																																			task.wait(2.432)
																																			v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																		else
																																			exitTo = 5
																																			break
																																		end
																																	end
																																else
																																	exitTo = 3
																																	break
																																end
																															else
																																flag23 = false

																																if getgenv().AutoParryMode == "Velocity" then
																																	flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																elseif getgenv().AutoParryMode == "Distance" then
																																	flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																end

																																if flag23 then
																																	ExecuteParry(SelectedParryType)
																																	tbl21.Play_Animation()
																																	flag19 = true
																																end

																																now2 = tick()

																																while true do
																																	v85.PreSimulation:Wait()
																																	flag24 = tick() - now2 >= 0.6 or not flag19
																																	if not flag24 then
																																		continue
																																	end
																																	break
																																end

																																flag19 = false
																															end
																														end
																													end
																												end
																											else
																												deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																												if not deathslashActive then
																													slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																													if not slashesoffuryActive then
																														flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																														if flag22 then
																															if getgenv().CooldownProtection then
																																if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																	v87.Remotes.AbilityButtonPress:Fire()
																																else
																																	exitTo = 6
																																	break
																																end
																															elseif getgenv().AutoAbility then
																																if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																	exitTo = 4
																																	break
																																else
																																	enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																	if enabled then
																																		flag19 = true
																																		v87.Remotes.AbilityButtonPress:Fire()
																																		task.wait(2.432)
																																		v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																	else
																																		exitTo = 5
																																		break
																																	end
																																end
																															else
																																exitTo = 3
																																break
																															end
																														else
																															flag23 = false

																															if getgenv().AutoParryMode == "Velocity" then
																																flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																															elseif getgenv().AutoParryMode == "Distance" then
																																flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																															end

																															if flag23 then
																																ExecuteParry(SelectedParryType)
																																tbl21.Play_Animation()
																																flag19 = true
																															end

																															now2 = tick()

																															while true do
																																v85.PreSimulation:Wait()
																																flag24 = tick() - now2 >= 0.6 or not flag19
																																if not flag24 then
																																	continue
																																end
																																break
																															end

																															flag19 = false
																														end
																													end
																												end
																											end
																										end
																									elseif System.__config.__detections.forcefield then
																										maxShield = visible and maxShield

																										if not maxShield then
																											error("devirt: unstructured jump to block_1344") -- goto block_1344
																										end
																									else
																										deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																										if not deathslashActive then
																											slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																											if not slashesoffuryActive then
																												flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																												if flag22 then
																													if getgenv().CooldownProtection then
																														if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																															v87.Remotes.AbilityButtonPress:Fire()
																														else
																															exitTo = 6
																															break
																														end
																													elseif getgenv().AutoAbility then
																														if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																															exitTo = 4
																															break
																														else
																															enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																															if enabled then
																																flag19 = true
																																v87.Remotes.AbilityButtonPress:Fire()
																																task.wait(2.432)
																																v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																															else
																																exitTo = 5
																																break
																															end
																														end
																													else
																														exitTo = 3
																														break
																													end
																												else
																													flag23 = false

																													if getgenv().AutoParryMode == "Velocity" then
																														flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																													elseif getgenv().AutoParryMode == "Distance" then
																														flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																													end

																													if flag23 then
																														ExecuteParry(SelectedParryType)
																														tbl21.Play_Animation()
																														flag19 = true
																													end

																													now2 = tick()

																													while true do
																														v85.PreSimulation:Wait()
																														flag24 = tick() - now2 >= 0.6 or not flag19
																														if not flag24 then
																															continue
																														end
																														break
																													end

																													flag19 = false
																												end
																											end
																										end
																									end
																								end
																							elseif System.__config.__detections.infinity then
																								abilities = visible and abilities

																								if not abilities then
																									error("devirt: unstructured jump to block_1414") -- goto block_1414
																								end
																							elseif System.__config.__detections.forcefield then
																								maxShield = visible and maxShield

																								if not maxShield then
																									error("devirt: unstructured jump to block_1344") -- goto block_1344
																								end
																							else
																								deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																								if not deathslashActive then
																									slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																									if not slashesoffuryActive then
																										flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																										if flag22 then
																											if getgenv().CooldownProtection then
																												if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																													v87.Remotes.AbilityButtonPress:Fire()
																												else
																													exitTo = 6
																													break
																												end
																											elseif getgenv().AutoAbility then
																												if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																													exitTo = 4
																													break
																												else
																													enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																													if enabled then
																														flag19 = true
																														v87.Remotes.AbilityButtonPress:Fire()
																														task.wait(2.432)
																														v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																													else
																														exitTo = 5
																														break
																													end
																												end
																											else
																												exitTo = 3
																												break
																											end
																										else
																											flag23 = false

																											if getgenv().AutoParryMode == "Velocity" then
																												flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																											elseif getgenv().AutoParryMode == "Distance" then
																												flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																											end

																											if flag23 then
																												ExecuteParry(SelectedParryType)
																												tbl21.Play_Animation()
																												flag19 = true
																											end

																											now2 = tick()

																											while true do
																												v85.PreSimulation:Wait()
																												flag24 = tick() - now2 >= 0.6 or not flag19
																												if not flag24 then
																													continue
																												end
																												break
																											end

																											flag19 = false
																										end
																									end
																								end
																							end
																						end
																					end
																				else
																					primaryPart = localPlayer.Character.PrimaryPart

																					if not primaryPart:FindFirstChild("SingularityCape") then
																						maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																						abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																						hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																						visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																						timeHole = abilities and abilities:FindFirstChild("Time Hole")
																						timeHole = timeHole and timeHole.Enabled
																						abilities = abilities and abilities:FindFirstChild("Infinity")
																						abilities = abilities and abilities.Enabled

																						if getgenv().sofactive then
																							exitTo = 2
																							break
																						elseif System.__config.__detections.timehole then
																							timeHole = visible and timeHole

																							if not timeHole then
																								error("devirt: unstructured jump to block_1488") -- goto block_1488
																							end
																						elseif System.__config.__detections.infinity then
																							abilities = visible and abilities

																							if not abilities then
																								error("devirt: unstructured jump to block_1414") -- goto block_1414
																							end
																						elseif System.__config.__detections.forcefield then
																							maxShield = visible and maxShield

																							if not maxShield then
																								error("devirt: unstructured jump to block_1344") -- goto block_1344
																							end
																						else
																							deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																							if not deathslashActive then
																								slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																								if not slashesoffuryActive then
																									flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																									if flag22 then
																										if getgenv().CooldownProtection then
																											if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																												v87.Remotes.AbilityButtonPress:Fire()
																											else
																												exitTo = 6
																												break
																											end
																										elseif getgenv().AutoAbility then
																											if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																												exitTo = 4
																												break
																											else
																												enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																												if enabled then
																													flag19 = true
																													v87.Remotes.AbilityButtonPress:Fire()
																													task.wait(2.432)
																													v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																												else
																													exitTo = 5
																													break
																												end
																											end
																										else
																											exitTo = 3
																											break
																										end
																									else
																										flag23 = false

																										if getgenv().AutoParryMode == "Velocity" then
																											flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																										elseif getgenv().AutoParryMode == "Distance" then
																											flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																										end

																										if flag23 then
																											ExecuteParry(SelectedParryType)
																											tbl21.Play_Animation()
																											flag19 = true
																										end

																										now2 = tick()

																										while true do
																											v85.PreSimulation:Wait()
																											flag24 = tick() - now2 >= 0.6 or not flag19
																											if not flag24 then
																												continue
																											end
																											break
																										end

																										flag19 = false
																									end
																								end
																							end
																						end
																					end
																				end
																			end
																		end
																	end
																end
															end
														end

														if exitTo == 1 then
															return
														end

														if exitTo == 2 then
															return
														end

														if exitTo ~= 3 then
															if exitTo == 4 then
																local exitTo3 = nil
																flag23 = false

																if getgenv().AutoParryMode == "Velocity" then
																	flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																elseif getgenv().AutoParryMode == "Distance" then
																	flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																end

																if flag23 then
																	ExecuteParry(SelectedParryType)
																	tbl21.Play_Animation()
																	flag19 = true
																end

																now2 = tick()

																while true do
																	v85.PreSimulation:Wait()
																	flag24 = tick() - now2 >= 0.6 or not flag19
																	if not flag24 then
																		continue
																	end
																	break
																end

																flag19 = false
																local exitTo2 = nil
																local exitTo9 = nil

																for _, v97 in pairs(v91) do
																	if v97 then
																		zoomies = v97:FindFirstChild("zoomies")

																		if zoomies then
																			v97:GetAttributeChangedSignal("target"):Once(function()
																				flag19 = false
																			end)

																			if flag19 then
																				exitTo9 = 1
																				break
																			else
																				attribute = v97:GetAttribute("target")

																				if v90 then
																					v90:GetAttribute("target")
																				end

																				magnitude = zoomies.VectorVelocity.Magnitude
																				v93 = 12
																				v94 = 20
																				n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																				v95 = tbl21.Ball_Position(v97)

																				if v95 then
																					magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																					n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																					n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																					n38 = n37 + getgenv().Parry_Range
																					v96 = tbl21.Is_Curved(v97)
																					flag21 = attribute == localPlayer.Name
																					v96 = flag21 and v96

																					if not v96 then
																						if v97:FindFirstChild("AeroDynamicSlashVFX") then
																							v97.AeroDynamicSlashVFX:Destroy()
																							System.__properties.tornado_time = tick()
																						end

																						if runtime:FindFirstChild("Tornado") then
																							tornadoTime = System.__properties.tornado_time
																							n39 = tick() - tornadoTime
																							attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1
																							if not (n39 < attribute2 + 0.314159) then
																								exitTo9 = 10
																								break
																							end
																						else
																							primaryPart = localPlayer.Character.PrimaryPart

																							if not primaryPart:FindFirstChild("SingularityCape") then
																								maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																								abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																								hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																								visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																								timeHole = abilities and abilities:FindFirstChild("Time Hole")
																								timeHole = timeHole and timeHole.Enabled
																								abilities = abilities and abilities:FindFirstChild("Infinity")
																								abilities = abilities and abilities.Enabled

																								if getgenv().sofactive then
																									exitTo9 = 2
																									break
																								elseif System.__config.__detections.timehole then
																									timeHole = visible and timeHole
																									if not timeHole then
																										exitTo9 = 9
																										break
																									end
																								elseif System.__config.__detections.infinity then
																									abilities = visible and abilities
																									if not abilities then
																										exitTo9 = 8
																										break
																									end
																								elseif System.__config.__detections.forcefield then
																									maxShield = visible and maxShield
																									if not maxShield then
																										exitTo9 = 7
																										break
																									end
																								else
																									deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																									if not deathslashActive then
																										slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																										if not slashesoffuryActive then
																											flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																											if flag22 then
																												if getgenv().CooldownProtection then
																													if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																														v87.Remotes.AbilityButtonPress:Fire()
																													else
																														exitTo9 = 6
																														break
																													end
																												elseif getgenv().AutoAbility then
																													if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																														exitTo9 = 4
																														break
																													else
																														enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																														if enabled then
																															flag19 = true
																															v87.Remotes.AbilityButtonPress:Fire()
																															task.wait(2.432)
																															v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																														else
																															exitTo9 = 5
																															break
																														end
																													end
																												else
																													exitTo9 = 3
																													break
																												end
																											else
																												flag23 = false

																												if getgenv().AutoParryMode == "Velocity" then
																													flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																												elseif getgenv().AutoParryMode == "Distance" then
																													flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																												end

																												if flag23 then
																													ExecuteParry(SelectedParryType)
																													tbl21.Play_Animation()
																													flag19 = true
																												end

																												now2 = tick()

																												while true do
																													v85.PreSimulation:Wait()
																													flag24 = tick() - now2 >= 0.6 or not flag19
																													if not flag24 then
																														continue
																													end
																													break
																												end

																												flag19 = false
																											end
																										end
																									end
																								end
																							end
																						end
																					end
																				end
																			end
																		end
																	end
																end

																if exitTo9 == 1 then
																	exitTo2 = 1
																elseif exitTo9 == 2 then
																	exitTo2 = 2
																elseif exitTo9 == 3 then
																	exitTo2 = 3
																elseif exitTo9 == 4 then
																	exitTo2 = 4
																elseif exitTo9 == 5 then
																	exitTo2 = 5
																elseif exitTo9 == 6 then
																	exitTo2 = 6
																elseif exitTo9 == 7 then
																	deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																	if deathslashActive then
																		error("devirt: unstructured jump to block_2852") -- goto block_2852
																	else
																		slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																		if slashesoffuryActive then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																			if flag22 then
																				if getgenv().CooldownProtection then
																					if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																						v87.Remotes.AbilityButtonPress:Fire()
																						error("devirt: unstructured jump to block_2852") -- goto block_2852
																					else
																						exitTo2 = 6
																					end
																				elseif getgenv().AutoAbility then
																					if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																						exitTo2 = 4
																					else
																						enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																						if enabled then
																							flag19 = true
																							v87.Remotes.AbilityButtonPress:Fire()
																							task.wait(2.432)
																							v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																							error("devirt: unstructured jump to block_2852") -- goto block_2852
																						else
																							exitTo2 = 5
																						end
																					end
																				else
																					exitTo2 = 3
																				end
																			else
																				flag23 = false

																				if getgenv().AutoParryMode == "Velocity" then
																					flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																				elseif getgenv().AutoParryMode == "Distance" then
																					flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																				end

																				if flag23 then
																					ExecuteParry(SelectedParryType)
																					tbl21.Play_Animation()
																					flag19 = true
																				end

																				now2 = tick()

																				while true do
																					v85.PreSimulation:Wait()
																					flag24 = tick() - now2 >= 0.6 or not flag19
																					if not flag24 then
																						continue
																					end
																					break
																				end

																				flag19 = false
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			end
																		end
																	end
																elseif exitTo9 == 8 then
																	if System.__config.__detections.forcefield then
																		maxShield = visible and maxShield

																		if maxShield then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			error("devirt: unstructured jump to block_1671") -- goto block_1671
																		end
																	else
																		deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																		if deathslashActive then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																			if slashesoffuryActive then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																				if flag22 then
																					if getgenv().CooldownProtection then
																						if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																							v87.Remotes.AbilityButtonPress:Fire()
																							error("devirt: unstructured jump to block_2852") -- goto block_2852
																						else
																							exitTo2 = 6
																						end
																					elseif getgenv().AutoAbility then
																						if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																							exitTo2 = 4
																						else
																							enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																							if enabled then
																								flag19 = true
																								v87.Remotes.AbilityButtonPress:Fire()
																								task.wait(2.432)
																								v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																								error("devirt: unstructured jump to block_2852") -- goto block_2852
																							else
																								exitTo2 = 5
																							end
																						end
																					else
																						exitTo2 = 3
																					end
																				else
																					flag23 = false

																					if getgenv().AutoParryMode == "Velocity" then
																						flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																					elseif getgenv().AutoParryMode == "Distance" then
																						flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																					end

																					if flag23 then
																						ExecuteParry(SelectedParryType)
																						tbl21.Play_Animation()
																						flag19 = true
																					end

																					now2 = tick()

																					while true do
																						v85.PreSimulation:Wait()
																						flag24 = tick() - now2 >= 0.6 or not flag19
																						if not flag24 then
																							continue
																						end
																						break
																					end

																					flag19 = false
																					error("devirt: unstructured jump to block_2852") -- goto block_2852
																				end
																			end
																		end
																	end
																elseif exitTo9 == 9 then
																	if System.__config.__detections.infinity then
																		abilities = visible and abilities

																		if abilities then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			error("devirt: unstructured jump to block_1741") -- goto block_1741
																		end
																	elseif System.__config.__detections.forcefield then
																		maxShield = visible and maxShield

																		if maxShield then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			error("devirt: unstructured jump to block_1671") -- goto block_1671
																		end
																	else
																		deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																		if deathslashActive then
																			error("devirt: unstructured jump to block_2852") -- goto block_2852
																		else
																			slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																			if slashesoffuryActive then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																				if flag22 then
																					if getgenv().CooldownProtection then
																						if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																							v87.Remotes.AbilityButtonPress:Fire()
																							error("devirt: unstructured jump to block_2852") -- goto block_2852
																						else
																							exitTo2 = 6
																						end
																					elseif getgenv().AutoAbility then
																						if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																							exitTo2 = 4
																						else
																							enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																							if enabled then
																								flag19 = true
																								v87.Remotes.AbilityButtonPress:Fire()
																								task.wait(2.432)
																								v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																								error("devirt: unstructured jump to block_2852") -- goto block_2852
																							else
																								exitTo2 = 5
																							end
																						end
																					else
																						exitTo2 = 3
																					end
																				else
																					flag23 = false

																					if getgenv().AutoParryMode == "Velocity" then
																						flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																					elseif getgenv().AutoParryMode == "Distance" then
																						flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																					end

																					if flag23 then
																						ExecuteParry(SelectedParryType)
																						tbl21.Play_Animation()
																						flag19 = true
																					end

																					now2 = tick()

																					while true do
																						v85.PreSimulation:Wait()
																						flag24 = tick() - now2 >= 0.6 or not flag19
																						if not flag24 then
																							continue
																						end
																						break
																					end

																					flag19 = false
																					error("devirt: unstructured jump to block_2852") -- goto block_2852
																				end
																			end
																		end
																	end
																elseif exitTo9 == 10 then
																	primaryPart = localPlayer.Character.PrimaryPart

																	if primaryPart:FindFirstChild("SingularityCape") then
																		error("devirt: unstructured jump to block_2852") -- goto block_2852
																	else
																		maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																		abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																		hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																		visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																		timeHole = abilities and abilities:FindFirstChild("Time Hole")
																		timeHole = timeHole and timeHole.Enabled
																		abilities = abilities and abilities:FindFirstChild("Infinity")
																		abilities = abilities and abilities.Enabled

																		if getgenv().sofactive then
																			exitTo2 = 2
																		elseif System.__config.__detections.timehole then
																			timeHole = visible and timeHole

																			if timeHole then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				error("devirt: unstructured jump to block_1815") -- goto block_1815
																			end
																		elseif System.__config.__detections.infinity then
																			abilities = visible and abilities

																			if abilities then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				error("devirt: unstructured jump to block_1741") -- goto block_1741
																			end
																		elseif System.__config.__detections.forcefield then
																			maxShield = visible and maxShield

																			if maxShield then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				error("devirt: unstructured jump to block_1671") -- goto block_1671
																			end
																		else
																			deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																			if deathslashActive then
																				error("devirt: unstructured jump to block_2852") -- goto block_2852
																			else
																				slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																				if slashesoffuryActive then
																					error("devirt: unstructured jump to block_2852") -- goto block_2852
																				else
																					flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																					if flag22 then
																						if getgenv().CooldownProtection then
																							if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																								v87.Remotes.AbilityButtonPress:Fire()
																								error("devirt: unstructured jump to block_2852") -- goto block_2852
																							else
																								exitTo2 = 6
																							end
																						elseif getgenv().AutoAbility then
																							if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																								exitTo2 = 4
																							else
																								enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																								if enabled then
																									flag19 = true
																									v87.Remotes.AbilityButtonPress:Fire()
																									task.wait(2.432)
																									v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																									error("devirt: unstructured jump to block_2852") -- goto block_2852
																								else
																									exitTo2 = 5
																								end
																							end
																						else
																							exitTo2 = 3
																						end
																					else
																						flag23 = false

																						if getgenv().AutoParryMode == "Velocity" then
																							flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																						elseif getgenv().AutoParryMode == "Distance" then
																							flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																						end

																						if flag23 then
																							ExecuteParry(SelectedParryType)
																							tbl21.Play_Animation()
																							flag19 = true
																						end

																						now2 = tick()

																						while true do
																							v85.PreSimulation:Wait()
																							flag24 = tick() - now2 >= 0.6 or not flag19
																							if not flag24 then
																								continue
																							end
																							break
																						end

																						flag19 = false
																						error("devirt: unstructured jump to block_2852") -- goto block_2852
																					end
																				end
																			end
																		end
																	end
																end

																if exitTo2 == 1 then
																	exitTo3 = 1
																elseif exitTo2 == 2 then
																	exitTo3 = 2
																elseif exitTo2 ~= 3 then
																	if exitTo2 == 4 then
																		error("devirt: unstructured jump to block_692") -- goto block_692
																	else
																		exitTo3 = 3
																	end
																end

																if exitTo3 ~= 1 then
																	if exitTo3 ~= 2 then
																		if exitTo3 == 3 then
																			if exitTo2 == 5 then
																				local exitTo12 = nil
																				local exitTo5, exitTo4

																				while true do
																					exitTo5 = nil

																					while true do
																						flag23 = false

																						if getgenv().AutoParryMode == "Velocity" then
																							flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																						elseif getgenv().AutoParryMode == "Distance" then
																							flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																						end

																						if flag23 then
																							ExecuteParry(SelectedParryType)
																							tbl21.Play_Animation()
																							flag19 = true
																						end

																						now2 = tick()

																						while true do
																							v85.PreSimulation:Wait()
																							flag24 = tick() - now2 >= 0.6 or not flag19
																							if not flag24 then
																								continue
																							end
																							break
																						end

																						flag19 = false
																						exitTo4 = nil

																						for _, v97 in pairs(v91) do
																							if v97 then
																								zoomies = v97:FindFirstChild("zoomies")

																								if zoomies then
																									v97:GetAttributeChangedSignal("target"):Once(function()
																										flag19 = false
																									end)

																									if flag19 then
																										exitTo4 = 1
																										break
																									else
																										attribute = v97:GetAttribute("target")

																										if v90 then
																											v90:GetAttribute("target")
																										end

																										magnitude = zoomies.VectorVelocity.Magnitude
																										v93 = 12
																										v94 = 20
																										n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																										v95 = tbl21.Ball_Position(v97)

																										if v95 then
																											magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																											n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																											n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																											n38 = n37 + getgenv().Parry_Range
																											v96 = tbl21.Is_Curved(v97)
																											flag21 = attribute == localPlayer.Name
																											v96 = flag21 and v96

																											if not v96 then
																												if v97:FindFirstChild("AeroDynamicSlashVFX") then
																													v97.AeroDynamicSlashVFX:Destroy()
																													System.__properties.tornado_time = tick()
																												end

																												if runtime:FindFirstChild("Tornado") then
																													tornadoTime = System.__properties.tornado_time
																													n39 = tick() - tornadoTime
																													attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1

																													if not (n39 < attribute2 + 0.314159) then
																														primaryPart = localPlayer.Character.PrimaryPart

																														if not primaryPart:FindFirstChild("SingularityCape") then
																															maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																															abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																															hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																															visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																															timeHole = abilities and abilities:FindFirstChild("Time Hole")
																															timeHole = timeHole and timeHole.Enabled
																															abilities = abilities and abilities:FindFirstChild("Infinity")
																															abilities = abilities and abilities.Enabled

																															if getgenv().sofactive then
																																exitTo4 = 2
																																break
																															elseif System.__config.__detections.timehole then
																																timeHole = visible and timeHole

																																if not timeHole then
																																	if System.__config.__detections.infinity then
																																		abilities = visible and abilities

																																		if not abilities then
																																			if System.__config.__detections.forcefield then
																																				maxShield = visible and maxShield

																																				if not maxShield then
																																					deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																					if not deathslashActive then
																																						slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																						if not slashesoffuryActive then
																																							flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																							if flag22 then
																																								if getgenv().CooldownProtection then
																																									if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																										v87.Remotes.AbilityButtonPress:Fire()
																																									else
																																										exitTo4 = 6
																																										break
																																									end
																																								elseif getgenv().AutoAbility then
																																									if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																										exitTo4 = 4
																																										break
																																									else
																																										enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																										if enabled then
																																											flag19 = true
																																											v87.Remotes.AbilityButtonPress:Fire()
																																											task.wait(2.432)
																																											v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																										else
																																											exitTo4 = 5
																																											break
																																										end
																																									end
																																								else
																																									exitTo4 = 3
																																									break
																																								end
																																							else
																																								flag23 = false

																																								if getgenv().AutoParryMode == "Velocity" then
																																									flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																								elseif getgenv().AutoParryMode == "Distance" then
																																									flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																								end

																																								if flag23 then
																																									ExecuteParry(SelectedParryType)
																																									tbl21.Play_Animation()
																																									flag19 = true
																																								end

																																								now2 = tick()

																																								while true do
																																									v85.PreSimulation:Wait()
																																									flag24 = tick() - now2 >= 0.6 or not flag19
																																									if not flag24 then
																																										continue
																																									end
																																									break
																																								end

																																								flag19 = false
																																							end
																																						end
																																					end
																																				end
																																			else
																																				deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																				if not deathslashActive then
																																					slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																					if not slashesoffuryActive then
																																						flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																						if flag22 then
																																							if getgenv().CooldownProtection then
																																								if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																									v87.Remotes.AbilityButtonPress:Fire()
																																								else
																																									exitTo4 = 6
																																									break
																																								end
																																							elseif getgenv().AutoAbility then
																																								if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																									exitTo4 = 4
																																									break
																																								else
																																									enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																									if enabled then
																																										flag19 = true
																																										v87.Remotes.AbilityButtonPress:Fire()
																																										task.wait(2.432)
																																										v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																									else
																																										exitTo4 = 5
																																										break
																																									end
																																								end
																																							else
																																								exitTo4 = 3
																																								break
																																							end
																																						else
																																							flag23 = false

																																							if getgenv().AutoParryMode == "Velocity" then
																																								flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																							elseif getgenv().AutoParryMode == "Distance" then
																																								flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																							end

																																							if flag23 then
																																								ExecuteParry(SelectedParryType)
																																								tbl21.Play_Animation()
																																								flag19 = true
																																							end

																																							now2 = tick()

																																							while true do
																																								v85.PreSimulation:Wait()
																																								flag24 = tick() - now2 >= 0.6 or not flag19
																																								if not flag24 then
																																									continue
																																								end
																																								break
																																							end

																																							flag19 = false
																																						end
																																					end
																																				end
																																			end
																																		end
																																	elseif System.__config.__detections.forcefield then
																																		maxShield = visible and maxShield

																																		if not maxShield then
																																			error("devirt: unstructured jump to block_1998") -- goto block_1998
																																		end
																																	else
																																		deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																		if not deathslashActive then
																																			slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																			if not slashesoffuryActive then
																																				flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																				if flag22 then
																																					if getgenv().CooldownProtection then
																																						if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																							v87.Remotes.AbilityButtonPress:Fire()
																																						else
																																							exitTo4 = 6
																																							break
																																						end
																																					elseif getgenv().AutoAbility then
																																						if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																							exitTo4 = 4
																																							break
																																						else
																																							enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																							if enabled then
																																								flag19 = true
																																								v87.Remotes.AbilityButtonPress:Fire()
																																								task.wait(2.432)
																																								v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																							else
																																								exitTo4 = 5
																																								break
																																							end
																																						end
																																					else
																																						exitTo4 = 3
																																						break
																																					end
																																				else
																																					flag23 = false

																																					if getgenv().AutoParryMode == "Velocity" then
																																						flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																					elseif getgenv().AutoParryMode == "Distance" then
																																						flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																					end

																																					if flag23 then
																																						ExecuteParry(SelectedParryType)
																																						tbl21.Play_Animation()
																																						flag19 = true
																																					end

																																					now2 = tick()

																																					while true do
																																						v85.PreSimulation:Wait()
																																						flag24 = tick() - now2 >= 0.6 or not flag19
																																						if not flag24 then
																																							continue
																																						end
																																						break
																																					end

																																					flag19 = false
																																				end
																																			end
																																		end
																																	end
																																end
																															elseif System.__config.__detections.infinity then
																																abilities = visible and abilities

																																if not abilities then
																																	error("devirt: unstructured jump to block_2068") -- goto block_2068
																																end
																															elseif System.__config.__detections.forcefield then
																																maxShield = visible and maxShield

																																if not maxShield then
																																	error("devirt: unstructured jump to block_1998") -- goto block_1998
																																end
																															else
																																deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																if not deathslashActive then
																																	slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																	if not slashesoffuryActive then
																																		flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																		if flag22 then
																																			if getgenv().CooldownProtection then
																																				if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																					v87.Remotes.AbilityButtonPress:Fire()
																																				else
																																					exitTo4 = 6
																																					break
																																				end
																																			elseif getgenv().AutoAbility then
																																				if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																					exitTo4 = 4
																																					break
																																				else
																																					enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																					if enabled then
																																						flag19 = true
																																						v87.Remotes.AbilityButtonPress:Fire()
																																						task.wait(2.432)
																																						v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																					else
																																						exitTo4 = 5
																																						break
																																					end
																																				end
																																			else
																																				exitTo4 = 3
																																				break
																																			end
																																		else
																																			flag23 = false

																																			if getgenv().AutoParryMode == "Velocity" then
																																				flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																			elseif getgenv().AutoParryMode == "Distance" then
																																				flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																			end

																																			if flag23 then
																																				ExecuteParry(SelectedParryType)
																																				tbl21.Play_Animation()
																																				flag19 = true
																																			end

																																			now2 = tick()

																																			while true do
																																				v85.PreSimulation:Wait()
																																				flag24 = tick() - now2 >= 0.6 or not flag19
																																				if not flag24 then
																																					continue
																																				end
																																				break
																																			end

																																			flag19 = false
																																		end
																																	end
																																end
																															end
																														end
																													end
																												else
																													primaryPart = localPlayer.Character.PrimaryPart

																													if not primaryPart:FindFirstChild("SingularityCape") then
																														maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																														abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																														hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																														visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																														timeHole = abilities and abilities:FindFirstChild("Time Hole")
																														timeHole = timeHole and timeHole.Enabled
																														abilities = abilities and abilities:FindFirstChild("Infinity")
																														abilities = abilities and abilities.Enabled

																														if getgenv().sofactive then
																															exitTo4 = 2
																															break
																														elseif System.__config.__detections.timehole then
																															timeHole = visible and timeHole

																															if not timeHole then
																																error("devirt: unstructured jump to block_2142") -- goto block_2142
																															end
																														elseif System.__config.__detections.infinity then
																															abilities = visible and abilities

																															if not abilities then
																																error("devirt: unstructured jump to block_2068") -- goto block_2068
																															end
																														elseif System.__config.__detections.forcefield then
																															maxShield = visible and maxShield

																															if not maxShield then
																																error("devirt: unstructured jump to block_1998") -- goto block_1998
																															end
																														else
																															deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																															if not deathslashActive then
																																slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																if not slashesoffuryActive then
																																	flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																	if flag22 then
																																		if getgenv().CooldownProtection then
																																			if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																				v87.Remotes.AbilityButtonPress:Fire()
																																			else
																																				exitTo4 = 6
																																				break
																																			end
																																		elseif getgenv().AutoAbility then
																																			if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																				exitTo4 = 4
																																				break
																																			else
																																				enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																				if enabled then
																																					flag19 = true
																																					v87.Remotes.AbilityButtonPress:Fire()
																																					task.wait(2.432)
																																					v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																				else
																																					exitTo4 = 5
																																					break
																																				end
																																			end
																																		else
																																			exitTo4 = 3
																																			break
																																		end
																																	else
																																		flag23 = false

																																		if getgenv().AutoParryMode == "Velocity" then
																																			flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																		elseif getgenv().AutoParryMode == "Distance" then
																																			flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																		end

																																		if flag23 then
																																			ExecuteParry(SelectedParryType)
																																			tbl21.Play_Animation()
																																			flag19 = true
																																		end

																																		now2 = tick()

																																		while true do
																																			v85.PreSimulation:Wait()
																																			flag24 = tick() - now2 >= 0.6 or not flag19
																																			if not flag24 then
																																				continue
																																			end
																																			break
																																		end

																																		flag19 = false
																																	end
																																end
																															end
																														end
																													end
																												end
																											end
																										end
																									end
																								end
																							end
																						end

																						if exitTo4 == 1 then
																							exitTo5 = 1
																							break
																						elseif exitTo4 == 2 then
																							exitTo5 = 2
																							break
																						elseif exitTo4 ~= 3 then
																							if exitTo4 == 4 then
																								exitTo5 = 3
																								break
																							elseif exitTo4 == 5 then
																								continue
																							else
																								exitTo5 = 4
																								break
																							end
																						end

																						break
																					end

																					if exitTo5 == 1 then
																						exitTo12 = 1
																						break
																					elseif exitTo5 == 2 then
																						exitTo12 = 2
																						break
																					elseif exitTo5 == 3 then
																						exitTo3 = nil
																						local exitTo11 = nil

																						while true do
																							flag23 = false

																							if getgenv().AutoParryMode == "Velocity" then
																								flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																							elseif getgenv().AutoParryMode == "Distance" then
																								flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																							end

																							if flag23 then
																								ExecuteParry(SelectedParryType)
																								tbl21.Play_Animation()
																								flag19 = true
																							end

																							now2 = tick()

																							while true do
																								v85.PreSimulation:Wait()
																								flag24 = tick() - now2 >= 0.6 or not flag19
																								if not flag24 then
																									continue
																								end
																								break
																							end

																							flag19 = false
																							exitTo2 = nil
																							local exitTo10 = nil

																							for _, v97 in pairs(v91) do
																								if v97 then
																									zoomies = v97:FindFirstChild("zoomies")

																									if zoomies then
																										v97:GetAttributeChangedSignal("target"):Once(function()
																											flag19 = false
																										end)

																										if flag19 then
																											exitTo10 = 1
																											break
																										else
																											attribute = v97:GetAttribute("target")

																											if v90 then
																												v90:GetAttribute("target")
																											end

																											magnitude = zoomies.VectorVelocity.Magnitude
																											v93 = 12
																											v94 = 20
																											n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																											v95 = tbl21.Ball_Position(v97)

																											if v95 then
																												magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																												n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																												n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																												n38 = n37 + getgenv().Parry_Range
																												v96 = tbl21.Is_Curved(v97)
																												flag21 = attribute == localPlayer.Name
																												v96 = flag21 and v96

																												if not v96 then
																													if v97:FindFirstChild("AeroDynamicSlashVFX") then
																														v97.AeroDynamicSlashVFX:Destroy()
																														System.__properties.tornado_time = tick()
																													end

																													if runtime:FindFirstChild("Tornado") then
																														tornadoTime = System.__properties.tornado_time
																														n39 = tick() - tornadoTime
																														attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1
																														if not (n39 < attribute2 + 0.314159) then
																															exitTo10 = 10
																															break
																														end
																													else
																														primaryPart = localPlayer.Character.PrimaryPart

																														if not primaryPart:FindFirstChild("SingularityCape") then
																															maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																															abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																															hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																															visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																															timeHole = abilities and abilities:FindFirstChild("Time Hole")
																															timeHole = timeHole and timeHole.Enabled
																															abilities = abilities and abilities:FindFirstChild("Infinity")
																															abilities = abilities and abilities.Enabled

																															if getgenv().sofactive then
																																exitTo10 = 2
																																break
																															elseif System.__config.__detections.timehole then
																																timeHole = visible and timeHole
																																if not timeHole then
																																	exitTo10 = 9
																																	break
																																end
																															elseif System.__config.__detections.infinity then
																																abilities = visible and abilities
																																if not abilities then
																																	exitTo10 = 8
																																	break
																																end
																															elseif System.__config.__detections.forcefield then
																																maxShield = visible and maxShield
																																if not maxShield then
																																	exitTo10 = 7
																																	break
																																end
																															else
																																deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																if not deathslashActive then
																																	slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																	if not slashesoffuryActive then
																																		flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																		if flag22 then
																																			if getgenv().CooldownProtection then
																																				if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																					v87.Remotes.AbilityButtonPress:Fire()
																																				else
																																					exitTo10 = 6
																																					break
																																				end
																																			elseif getgenv().AutoAbility then
																																				if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																					exitTo10 = 4
																																					break
																																				else
																																					enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																					if enabled then
																																						flag19 = true
																																						v87.Remotes.AbilityButtonPress:Fire()
																																						task.wait(2.432)
																																						v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																					else
																																						exitTo10 = 5
																																						break
																																					end
																																				end
																																			else
																																				exitTo10 = 3
																																				break
																																			end
																																		else
																																			flag23 = false

																																			if getgenv().AutoParryMode == "Velocity" then
																																				flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																			elseif getgenv().AutoParryMode == "Distance" then
																																				flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																			end

																																			if flag23 then
																																				ExecuteParry(SelectedParryType)
																																				tbl21.Play_Animation()
																																				flag19 = true
																																			end

																																			now2 = tick()

																																			while true do
																																				v85.PreSimulation:Wait()
																																				flag24 = tick() - now2 >= 0.6 or not flag19
																																				if not flag24 then
																																					continue
																																				end
																																				break
																																			end

																																			flag19 = false
																																		end
																																	end
																																end
																															end
																														end
																													end
																												end
																											end
																										end
																									end
																								end
																							end

																							if exitTo10 == 1 then
																								exitTo2 = 1

																								if exitTo2 == 1 then
																									exitTo11 = 5
																									break
																								elseif exitTo2 == 2 then
																									exitTo11 = 6
																									break
																								elseif exitTo2 ~= 3 then
																									if exitTo2 == 4 then
																										continue
																									else
																										exitTo11 = 7
																										break
																									end
																								end
																							elseif exitTo10 == 2 then
																								exitTo2 = 2
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							elseif exitTo10 == 3 then
																								exitTo2 = 3
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							elseif exitTo10 == 4 then
																								exitTo2 = 4
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							elseif exitTo10 == 5 then
																								exitTo2 = 5
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							elseif exitTo10 == 6 then
																								exitTo2 = 6
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							elseif exitTo10 == 7 then
																								exitTo11 = 1
																								break
																							elseif exitTo10 == 8 then
																								exitTo11 = 2
																								break
																							elseif exitTo10 == 9 then
																								exitTo11 = 3
																								break
																							elseif exitTo10 == 10 then
																								exitTo11 = 4
																								break
																							else
																								error("devirt: unstructured jump to block_2508") -- goto block_2508
																							end

																							break
																						end

																						if exitTo11 == 1 then
																							exitTo12 = 4
																							break
																						elseif exitTo11 == 2 then
																							exitTo12 = 5
																							break
																						elseif exitTo11 == 3 then
																							exitTo12 = 6
																							break
																						elseif exitTo11 == 4 then
																							exitTo12 = 7
																							break
																						else
																							if exitTo11 == 5 then
																								exitTo3 = 1
																							elseif exitTo11 == 6 then
																								exitTo3 = 2
																							elseif exitTo11 == 7 then
																								exitTo3 = 3
																							end

																							if exitTo3 == 1 then
																								exitTo12 = 8
																								break
																							elseif exitTo3 == 2 then
																								exitTo12 = 9
																								break
																							elseif exitTo3 == 3 then
																								if exitTo2 == 5 then
																									continue
																								else
																									exitTo12 = 10
																									break
																								end
																							end
																						end
																					else
																						exitTo12 = 3
																						break
																					end

																					break
																				end

																				if exitTo12 ~= 1 then
																					if exitTo12 ~= 2 then
																						if exitTo12 == 3 then
																							if exitTo5 == 4 then
																								if exitTo4 == 6 then
																									local exitTo15 = nil
																									local exitTo6

																									while true do
																										exitTo6 = nil

																										while getgenv().AutoAbility do
																											if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																												exitTo6 = 1
																												break
																											else
																												enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																												if enabled then
																													flag19 = true
																													v87.Remotes.AbilityButtonPress:Fire()
																													task.wait(2.432)
																													v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																													local exitTo7 = nil

																													for _, v97 in pairs(v91) do
																														if v97 then
																															zoomies = v97:FindFirstChild("zoomies")

																															if zoomies then
																																v97:GetAttributeChangedSignal("target"):Once(function()
																																	flag19 = false
																																end)

																																if flag19 then
																																	exitTo7 = 1
																																	break
																																else
																																	attribute = v97:GetAttribute("target")

																																	if v90 then
																																		v90:GetAttribute("target")
																																	end

																																	magnitude = zoomies.VectorVelocity.Magnitude
																																	v93 = 12
																																	v94 = 20
																																	n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																																	v95 = tbl21.Ball_Position(v97)

																																	if v95 then
																																		magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																																		n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																																		n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																																		n38 = n37 + getgenv().Parry_Range
																																		v96 = tbl21.Is_Curved(v97)
																																		flag21 = attribute == localPlayer.Name
																																		v96 = flag21 and v96

																																		if not v96 then
																																			if v97:FindFirstChild("AeroDynamicSlashVFX") then
																																				v97.AeroDynamicSlashVFX:Destroy()
																																				System.__properties.tornado_time = tick()
																																			end

																																			if runtime:FindFirstChild("Tornado") then
																																				tornadoTime = System.__properties.tornado_time
																																				n39 = tick() - tornadoTime
																																				attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1

																																				if not (n39 < attribute2 + 0.314159) then
																																					primaryPart = localPlayer.Character.PrimaryPart

																																					if not primaryPart:FindFirstChild("SingularityCape") then
																																						maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																																						abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																																						hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																																						visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																																						timeHole = abilities and abilities:FindFirstChild("Time Hole")
																																						timeHole = timeHole and timeHole.Enabled
																																						abilities = abilities and abilities:FindFirstChild("Infinity")
																																						abilities = abilities and abilities.Enabled

																																						if getgenv().sofactive then
																																							exitTo7 = 2
																																							break
																																						elseif System.__config.__detections.timehole then
																																							timeHole = visible and timeHole

																																							if not timeHole then
																																								if System.__config.__detections.infinity then
																																									abilities = visible and abilities

																																									if not abilities then
																																										if System.__config.__detections.forcefield then
																																											maxShield = visible and maxShield

																																											if not maxShield then
																																												deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																												if not deathslashActive then
																																													slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																													if not slashesoffuryActive then
																																														flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																														if flag22 then
																																															if getgenv().CooldownProtection then
																																																if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																																	v87.Remotes.AbilityButtonPress:Fire()
																																																else
																																																	exitTo7 = 6
																																																	break
																																																end
																																															elseif getgenv().AutoAbility then
																																																if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																																	exitTo7 = 4
																																																	break
																																																else
																																																	enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																																	if enabled then
																																																		flag19 = true
																																																		v87.Remotes.AbilityButtonPress:Fire()
																																																		task.wait(2.432)
																																																		v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																																	else
																																																		exitTo7 = 5
																																																		break
																																																	end
																																																end
																																															else
																																																exitTo7 = 3
																																																break
																																															end
																																														else
																																															flag23 = false

																																															if getgenv().AutoParryMode == "Velocity" then
																																																flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																															elseif getgenv().AutoParryMode == "Distance" then
																																																flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																															end

																																															if flag23 then
																																																ExecuteParry(SelectedParryType)
																																																tbl21.Play_Animation()
																																																flag19 = true
																																															end

																																															now2 = tick()

																																															while true do
																																																v85.PreSimulation:Wait()
																																																flag24 = tick() - now2 >= 0.6 or not flag19
																																																if not flag24 then
																																																	continue
																																																end
																																																break
																																															end

																																															flag19 = false
																																														end
																																													end
																																												end
																																											end
																																										else
																																											error("devirt: unstructured jump to block_1161") -- goto block_1161
																																										end
																																									end
																																								else
																																									error("devirt: unstructured jump to block_1160") -- goto block_1160
																																								end
																																							end
																																						else
																																							error("devirt: unstructured jump to block_1159") -- goto block_1159
																																						end
																																					end
																																				end
																																			else
																																				error("devirt: unstructured jump to block_1145") -- goto block_1145
																																			end
																																		end
																																	end
																																end
																															end
																														end
																													end

																													if exitTo7 == 1 then
																														exitTo6 = 4
																														break
																													elseif exitTo7 == 2 then
																														exitTo6 = 5
																														break
																													elseif exitTo7 ~= 3 then
																														if exitTo7 == 4 then
																															exitTo6 = 1
																															break
																														elseif exitTo7 == 5 then
																															exitTo6 = 2
																															break
																														elseif exitTo7 == 6 then
																															continue
																														else
																															exitTo6 = 3
																															break
																														end
																													end
																												else
																													exitTo6 = 2
																													break
																												end
																											end

																											break
																										end

																										if exitTo6 == 1 then
																											exitTo3 = nil
																											local exitTo14 = nil

																											while true do
																												flag23 = false

																												if getgenv().AutoParryMode == "Velocity" then
																													flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																												elseif getgenv().AutoParryMode == "Distance" then
																													flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																												end

																												if flag23 then
																													ExecuteParry(SelectedParryType)
																													tbl21.Play_Animation()
																													flag19 = true
																												end

																												now2 = tick()

																												while true do
																													v85.PreSimulation:Wait()
																													flag24 = tick() - now2 >= 0.6 or not flag19
																													if not flag24 then
																														continue
																													end
																													break
																												end

																												flag19 = false
																												exitTo2 = nil
																												local exitTo13 = nil

																												for _, v97 in pairs(v91) do
																													if v97 then
																														zoomies = v97:FindFirstChild("zoomies")

																														if zoomies then
																															v97:GetAttributeChangedSignal("target"):Once(function()
																																flag19 = false
																															end)

																															if flag19 then
																																exitTo13 = 1
																																break
																															else
																																attribute = v97:GetAttribute("target")

																																if v90 then
																																	v90:GetAttribute("target")
																																end

																																magnitude = zoomies.VectorVelocity.Magnitude
																																v93 = 12
																																v94 = 20
																																n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																																v95 = tbl21.Ball_Position(v97)

																																if v95 then
																																	magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																																	n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																																	n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																																	n38 = n37 + getgenv().Parry_Range
																																	v96 = tbl21.Is_Curved(v97)
																																	flag21 = attribute == localPlayer.Name
																																	v96 = flag21 and v96

																																	if not v96 then
																																		if v97:FindFirstChild("AeroDynamicSlashVFX") then
																																			v97.AeroDynamicSlashVFX:Destroy()
																																			System.__properties.tornado_time = tick()
																																		end

																																		if runtime:FindFirstChild("Tornado") then
																																			tornadoTime = System.__properties.tornado_time
																																			n39 = tick() - tornadoTime
																																			attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1
																																			if not (n39 < attribute2 + 0.314159) then
																																				exitTo13 = 10
																																				break
																																			end
																																		else
																																			primaryPart = localPlayer.Character.PrimaryPart

																																			if not primaryPart:FindFirstChild("SingularityCape") then
																																				maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																																				abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																																				hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																																				visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																																				timeHole = abilities and abilities:FindFirstChild("Time Hole")
																																				timeHole = timeHole and timeHole.Enabled
																																				abilities = abilities and abilities:FindFirstChild("Infinity")
																																				abilities = abilities and abilities.Enabled

																																				if getgenv().sofactive then
																																					exitTo13 = 2
																																					break
																																				elseif System.__config.__detections.timehole then
																																					timeHole = visible and timeHole
																																					if not timeHole then
																																						exitTo13 = 9
																																						break
																																					end
																																				elseif System.__config.__detections.infinity then
																																					abilities = visible and abilities
																																					if not abilities then
																																						exitTo13 = 8
																																						break
																																					end
																																				elseif System.__config.__detections.forcefield then
																																					maxShield = visible and maxShield
																																					if not maxShield then
																																						exitTo13 = 7
																																						break
																																					end
																																				else
																																					deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																					if not deathslashActive then
																																						slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																						if not slashesoffuryActive then
																																							flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																							if flag22 then
																																								if getgenv().CooldownProtection then
																																									if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																										v87.Remotes.AbilityButtonPress:Fire()
																																									else
																																										exitTo13 = 6
																																										break
																																									end
																																								elseif getgenv().AutoAbility then
																																									if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																										exitTo13 = 4
																																										break
																																									else
																																										enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																										if enabled then
																																											flag19 = true
																																											v87.Remotes.AbilityButtonPress:Fire()
																																											task.wait(2.432)
																																											v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																										else
																																											exitTo13 = 5
																																											break
																																										end
																																									end
																																								else
																																									exitTo13 = 3
																																									break
																																								end
																																							else
																																								flag23 = false

																																								if getgenv().AutoParryMode == "Velocity" then
																																									flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																								elseif getgenv().AutoParryMode == "Distance" then
																																									flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																								end

																																								if flag23 then
																																									ExecuteParry(SelectedParryType)
																																									tbl21.Play_Animation()
																																									flag19 = true
																																								end

																																								now2 = tick()

																																								while true do
																																									v85.PreSimulation:Wait()
																																									flag24 = tick() - now2 >= 0.6 or not flag19
																																									if not flag24 then
																																										continue
																																									end
																																									break
																																								end

																																								flag19 = false
																																							end
																																						end
																																					end
																																				end
																																			end
																																		end
																																	end
																																end
																															end
																														end
																													end
																												end

																												if exitTo13 == 1 then
																													exitTo2 = 1

																													if exitTo2 == 1 then
																														exitTo14 = 4
																														break
																													elseif exitTo2 == 2 then
																														exitTo14 = 5
																														break
																													elseif exitTo2 == 3 then
																														exitTo14 = 6
																														break
																													elseif exitTo2 == 4 then
																														continue
																													else
																														exitTo14 = 7
																														break
																													end
																												elseif exitTo13 == 2 then
																													exitTo2 = 2
																													error("devirt: unstructured jump to block_2677") -- goto block_2677
																												elseif exitTo13 == 3 then
																													exitTo2 = 3
																													error("devirt: unstructured jump to block_2677") -- goto block_2677
																												elseif exitTo13 == 4 then
																													exitTo2 = 4
																													error("devirt: unstructured jump to block_2677") -- goto block_2677
																												elseif exitTo13 == 5 then
																													exitTo2 = 5
																													error("devirt: unstructured jump to block_2677") -- goto block_2677
																												elseif exitTo13 == 6 then
																													exitTo2 = 6
																													error("devirt: unstructured jump to block_2677") -- goto block_2677
																												elseif exitTo13 ~= 7 then
																													if exitTo13 == 8 then
																														exitTo14 = 1
																														break
																													elseif exitTo13 == 9 then
																														exitTo14 = 2
																														break
																													elseif exitTo13 == 10 then
																														exitTo14 = 3
																														break
																													else
																														error("devirt: unstructured jump to block_2677") -- goto block_2677
																													end
																												end

																												break
																											end

																											if exitTo14 == 1 then
																												exitTo15 = 2
																												break
																											elseif exitTo14 == 2 then
																												exitTo15 = 3
																												break
																											elseif exitTo14 == 3 then
																												exitTo15 = 4
																												break
																											elseif exitTo14 == 4 then
																												exitTo3 = 1

																												if exitTo3 == 1 then
																													exitTo15 = 6
																													break
																												elseif exitTo3 == 2 then
																													exitTo15 = 7
																													break
																												elseif exitTo3 == 3 then
																													if exitTo2 == 5 then
																														exitTo15 = 8
																														break
																													elseif exitTo2 == 6 then
																														continue
																													else
																														exitTo15 = 9
																														break
																													end
																												end
																											elseif exitTo14 == 5 then
																												exitTo3 = 2
																												error("devirt: unstructured jump to block_2682") -- goto block_2682
																											elseif exitTo14 == 6 then
																												error("devirt: unstructured jump to block_2682") -- goto block_2682
																											elseif exitTo14 == 7 then
																												exitTo3 = 3
																												error("devirt: unstructured jump to block_2682") -- goto block_2682
																											else
																												exitTo15 = 5
																												break
																											end
																										else
																											exitTo15 = 1
																											break
																										end

																										break
																									end

																									if exitTo15 == 1 then
																										if exitTo6 == 2 then
																											error("devirt: unstructured jump to block_2909") -- goto block_2909
																										else
																											if exitTo6 ~= 3 then
																												if exitTo6 ~= 4 then
																													if exitTo6 ~= 5 then
																														local exitTo18 = nil
																														local exitTo8

																														while true do
																															flag23 = false

																															if getgenv().AutoParryMode == "Velocity" then
																																flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																															elseif getgenv().AutoParryMode == "Distance" then
																																flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																															end

																															if flag23 then
																																ExecuteParry(SelectedParryType)
																																tbl21.Play_Animation()
																																flag19 = true
																															end

																															now2 = tick()

																															while true do
																																v85.PreSimulation:Wait()
																																flag24 = tick() - now2 >= 0.6 or not flag19
																																if not flag24 then
																																	continue
																																end
																																break
																															end

																															flag19 = false
																															exitTo8 = nil

																															for _, v97 in pairs(v91) do
																																if v97 then
																																	zoomies = v97:FindFirstChild("zoomies")

																																	if zoomies then
																																		v97:GetAttributeChangedSignal("target"):Once(function()
																																			flag19 = false
																																		end)

																																		if flag19 then
																																			exitTo8 = 1
																																			break
																																		else
																																			attribute = v97:GetAttribute("target")

																																			if v90 then
																																				v90:GetAttribute("target")
																																			end

																																			magnitude = zoomies.VectorVelocity.Magnitude
																																			v93 = 12
																																			v94 = 20
																																			n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																																			v95 = tbl21.Ball_Position(v97)

																																			if v95 then
																																				magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																																				n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																																				n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																																				n38 = n37 + getgenv().Parry_Range
																																				v96 = tbl21.Is_Curved(v97)
																																				flag21 = attribute == localPlayer.Name
																																				v96 = flag21 and v96

																																				if not v96 then
																																					if v97:FindFirstChild("AeroDynamicSlashVFX") then
																																						v97.AeroDynamicSlashVFX:Destroy()
																																						System.__properties.tornado_time = tick()
																																					end

																																					if runtime:FindFirstChild("Tornado") then
																																						tornadoTime = System.__properties.tornado_time
																																						n39 = tick() - tornadoTime
																																						attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1

																																						if not (n39 < attribute2 + 0.314159) then
																																							primaryPart = localPlayer.Character.PrimaryPart

																																							if not primaryPart:FindFirstChild("SingularityCape") then
																																								maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																																								abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																																								hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																																								visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																																								timeHole = abilities and abilities:FindFirstChild("Time Hole")
																																								timeHole = timeHole and timeHole.Enabled
																																								abilities = abilities and abilities:FindFirstChild("Infinity")
																																								abilities = abilities and abilities.Enabled

																																								if getgenv().sofactive then
																																									exitTo8 = 2
																																									break
																																								elseif System.__config.__detections.timehole then
																																									timeHole = visible and timeHole

																																									if not timeHole then
																																										if System.__config.__detections.infinity then
																																											abilities = visible and abilities

																																											if not abilities then
																																												if System.__config.__detections.forcefield then
																																													maxShield = visible and maxShield

																																													if not maxShield then
																																														deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																														if not deathslashActive then
																																															slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																															if not slashesoffuryActive then
																																																flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																																if flag22 then
																																																	if getgenv().CooldownProtection then
																																																		if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																																			v87.Remotes.AbilityButtonPress:Fire()
																																																		else
																																																			exitTo8 = 6
																																																			break
																																																		end
																																																	elseif getgenv().AutoAbility then
																																																		if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																																			exitTo8 = 4
																																																			break
																																																		else
																																																			enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																																			if enabled then
																																																				flag19 = true
																																																				v87.Remotes.AbilityButtonPress:Fire()
																																																				task.wait(2.432)
																																																				v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																																			else
																																																				exitTo8 = 5
																																																				break
																																																			end
																																																		end
																																																	else
																																																		exitTo8 = 3
																																																		break
																																																	end
																																																else
																																																	flag23 = false

																																																	if getgenv().AutoParryMode == "Velocity" then
																																																		flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																																	elseif getgenv().AutoParryMode == "Distance" then
																																																		flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																																	end

																																																	if flag23 then
																																																		ExecuteParry(SelectedParryType)
																																																		tbl21.Play_Animation()
																																																		flag19 = true
																																																	end

																																																	now2 = tick()

																																																	while true do
																																																		v85.PreSimulation:Wait()
																																																		flag24 = tick() - now2 >= 0.6 or not flag19
																																																		if not flag24 then
																																																			continue
																																																		end
																																																		break
																																																	end

																																																	flag19 = false
																																																end
																																															end
																																														end
																																													end
																																												else
																																													error("devirt: unstructured jump to block_804") -- goto block_804
																																												end
																																											end
																																										else
																																											error("devirt: unstructured jump to block_803") -- goto block_803
																																										end
																																									end
																																								else
																																									error("devirt: unstructured jump to block_802") -- goto block_802
																																								end
																																							end
																																						end
																																					else
																																						error("devirt: unstructured jump to block_788") -- goto block_788
																																					end
																																				end
																																			end
																																		end
																																	end
																																end
																															end

																															if exitTo8 == 1 then
																																exitTo18 = 1
																																break
																															elseif exitTo8 == 2 then
																																exitTo18 = 2
																																break
																															elseif exitTo8 == 3 then
																																continue
																															elseif exitTo8 == 4 then
																																exitTo3 = nil
																																local exitTo17 = nil

																																while true do
																																	flag23 = false

																																	if getgenv().AutoParryMode == "Velocity" then
																																		flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																	elseif getgenv().AutoParryMode == "Distance" then
																																		flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																	end

																																	if flag23 then
																																		ExecuteParry(SelectedParryType)
																																		tbl21.Play_Animation()
																																		flag19 = true
																																	end

																																	now2 = tick()

																																	while true do
																																		v85.PreSimulation:Wait()
																																		flag24 = tick() - now2 >= 0.6 or not flag19
																																		if not flag24 then
																																			continue
																																		end
																																		break
																																	end

																																	flag19 = false
																																	exitTo2 = nil
																																	local exitTo16 = nil

																																	for _, v97 in pairs(v91) do
																																		if v97 then
																																			zoomies = v97:FindFirstChild("zoomies")

																																			if zoomies then
																																				v97:GetAttributeChangedSignal("target"):Once(function()
																																					flag19 = false
																																				end)

																																				if flag19 then
																																					exitTo16 = 1
																																					break
																																				else
																																					attribute = v97:GetAttribute("target")

																																					if v90 then
																																						v90:GetAttribute("target")
																																					end

																																					magnitude = zoomies.VectorVelocity.Magnitude
																																					v93 = 12
																																					v94 = 20
																																					n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, v93, v94)
																																					v95 = tbl21.Ball_Position(v97)

																																					if v95 then
																																						magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v95).Magnitude
																																						n36 = math.max(0, magnitude2 - getgenv().Parry_Accuracy) / math.max(magnitude - n, 1)
																																						n37 = n + magnitude / (2.3497562749127492 + magnitude * 0.002) * n34
																																						n38 = n37 + getgenv().Parry_Range
																																						v96 = tbl21.Is_Curved(v97)
																																						flag21 = attribute == localPlayer.Name
																																						v96 = flag21 and v96

																																						if not v96 then
																																							if v97:FindFirstChild("AeroDynamicSlashVFX") then
																																								v97.AeroDynamicSlashVFX:Destroy()
																																								System.__properties.tornado_time = tick()
																																							end

																																							if runtime:FindFirstChild("Tornado") then
																																								tornadoTime = System.__properties.tornado_time
																																								n39 = tick() - tornadoTime
																																								attribute2 = runtime.Tornado:GetAttribute("TornadoTime") or 1
																																								if not (n39 < attribute2 + 0.314159) then
																																									exitTo16 = 10
																																									break
																																								end
																																							else
																																								primaryPart = localPlayer.Character.PrimaryPart

																																								if not primaryPart:FindFirstChild("SingularityCape") then
																																									maxShield = localPlayer2.Character.PrimaryPart:FindFirstChild("MaxShield")
																																									abilities = localPlayer2.Character and localPlayer2.Character:FindFirstChild("Abilities")
																																									hotbar = localPlayer2:FindFirstChild("PlayerGui") and localPlayer2.PlayerGui:FindFirstChild("Hotbar")
																																									visible = hotbar and hotbar:FindFirstChild("Ability") and hotbar.Ability:FindFirstChild("Duration") and hotbar.Ability.Duration.Visible
																																									timeHole = abilities and abilities:FindFirstChild("Time Hole")
																																									timeHole = timeHole and timeHole.Enabled
																																									abilities = abilities and abilities:FindFirstChild("Infinity")
																																									abilities = abilities and abilities.Enabled

																																									if getgenv().sofactive then
																																										exitTo16 = 2
																																										break
																																									elseif System.__config.__detections.timehole then
																																										timeHole = visible and timeHole
																																										if not timeHole then
																																											exitTo16 = 9
																																											break
																																										end
																																									elseif System.__config.__detections.infinity then
																																										abilities = visible and abilities
																																										if not abilities then
																																											exitTo16 = 8
																																											break
																																										end
																																									elseif System.__config.__detections.forcefield then
																																										maxShield = visible and maxShield
																																										if not maxShield then
																																											exitTo16 = 7
																																											break
																																										end
																																									else
																																										deathslashActive = System.__config.__detections.deathslash and System.__state.deathslash_active

																																										if not deathslashActive then
																																											slashesoffuryActive = System.__config.__detections.slashesoffury and System.__properties.slashesoffury_active

																																											if not slashesoffuryActive then
																																												flag22 = attribute == localPlayer.Name and magnitude2 <= n37

																																												if flag22 then
																																													if getgenv().CooldownProtection then
																																														if localPlayer.PlayerGui.Hotbar.Block.UIGradient.Offset.Y < 0.4 then
																																															v87.Remotes.AbilityButtonPress:Fire()
																																														else
																																															exitTo16 = 6
																																															break
																																														end
																																													elseif getgenv().AutoAbility then
																																														if localPlayer.PlayerGui.Hotbar.Ability.UIGradient.Offset.Y ~= 0.5 then
																																															exitTo16 = 4
																																															break
																																														else
																																															enabled = localPlayer.Character.Abilities:FindFirstChild("Raging Deflection") and localPlayer.Character.Abilities["Raging Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Rapture") and localPlayer.Character.Abilities.Rapture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Flash Counter") and localPlayer.Character.Abilities["Flash Counter"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Calming Deflection") and localPlayer.Character.Abilities["Calming Deflection"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Aerodynamic Slash") and localPlayer.Character.Abilities["Aerodynamic Slash"].Enabled or localPlayer.Character.Abilities:FindFirstChild("Fracture") and localPlayer.Character.Abilities.Fracture.Enabled or localPlayer.Character.Abilities:FindFirstChild("Death Slash") and localPlayer.Character.Abilities["Death Slash"].Enabled

																																															if enabled then
																																																flag19 = true
																																																v87.Remotes.AbilityButtonPress:Fire()
																																																task.wait(2.432)
																																																v87:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																																															else
																																																exitTo16 = 5
																																																break
																																															end
																																														end
																																													else
																																														exitTo16 = 3
																																														break
																																													end
																																												else
																																													flag23 = false

																																													if getgenv().AutoParryMode == "Velocity" then
																																														flag23 = v92 and magnitude2 <= n38 and not flag19 or not v92 and attribute == localPlayer.Name and magnitude2 <= n38 and not flag19
																																													elseif getgenv().AutoParryMode == "Distance" then
																																														flag23 = not flag19 and n36 <= 0.5 and (magnitude >= 80 or magnitude2 <= n38 + magnitude * 0.12) and (v92 or attribute == localPlayer.Name)
																																													end

																																													if flag23 then
																																														ExecuteParry(SelectedParryType)
																																														tbl21.Play_Animation()
																																														flag19 = true
																																													end

																																													now2 = tick()

																																													while true do
																																														v85.PreSimulation:Wait()
																																														flag24 = tick() - now2 >= 0.6 or not flag19
																																														if not flag24 then
																																															continue
																																														end
																																														break
																																													end

																																													flag19 = false
																																												end
																																											end
																																										end
																																									end
																																								end
																																							end
																																						end
																																					end
																																				end
																																			end
																																		end
																																	end

																																	if exitTo16 == 1 then
																																		exitTo2 = 1

																																		if exitTo2 == 1 then
																																			exitTo17 = 5
																																			break
																																		elseif exitTo2 == 2 then
																																			exitTo17 = 6
																																			break
																																		elseif exitTo2 ~= 3 then
																																			if exitTo2 == 4 then
																																				continue
																																			else
																																				exitTo17 = 7
																																				break
																																			end
																																		end
																																	elseif exitTo16 == 2 then
																																		exitTo2 = 2
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	elseif exitTo16 == 3 then
																																		exitTo2 = 3
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	elseif exitTo16 == 4 then
																																		exitTo2 = 4
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	elseif exitTo16 == 5 then
																																		exitTo2 = 5
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	elseif exitTo16 == 6 then
																																		exitTo2 = 6
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	elseif exitTo16 == 7 then
																																		exitTo17 = 1
																																		break
																																	elseif exitTo16 == 8 then
																																		exitTo17 = 2
																																		break
																																	elseif exitTo16 == 9 then
																																		exitTo17 = 3
																																		break
																																	elseif exitTo16 == 10 then
																																		exitTo17 = 4
																																		break
																																	else
																																		error("devirt: unstructured jump to block_2339") -- goto block_2339
																																	end

																																	break
																																end

																																if exitTo17 == 1 then
																																	exitTo18 = 3
																																	break
																																elseif exitTo17 == 2 then
																																	exitTo18 = 4
																																	break
																																elseif exitTo17 == 3 then
																																	exitTo18 = 5
																																	break
																																elseif exitTo17 == 4 then
																																	exitTo18 = 6
																																	break
																																else
																																	if exitTo17 == 5 then
																																		exitTo3 = 1
																																	elseif exitTo17 == 6 then
																																		exitTo3 = 2
																																	elseif exitTo17 == 7 then
																																		exitTo3 = 3
																																	end

																																	if exitTo3 == 1 then
																																		exitTo18 = 7
																																		break
																																	elseif exitTo3 == 2 then
																																		exitTo18 = 8
																																		break
																																	elseif exitTo3 == 3 then
																																		exitTo18 = 9
																																		break
																																	else
																																		continue
																																	end
																																end
																															end

																															break
																														end

																														if exitTo18 ~= 1 then
																															if exitTo18 ~= 2 then
																																if exitTo18 == 3 then
																																	error("devirt: unstructured jump to block_1671") -- goto block_1671
																																end

																																if exitTo18 == 4 then
																																	error("devirt: unstructured jump to block_1741") -- goto block_1741
																																end

																																if exitTo18 == 5 then
																																	error("devirt: unstructured jump to block_1815") -- goto block_1815
																																end

																																if exitTo18 == 6 then
																																	error("devirt: unstructured jump to block_1893") -- goto block_1893
																																end

																																if exitTo18 ~= 7 then
																																	if exitTo18 ~= 8 then
																																		if exitTo18 == 9 then
																																			if exitTo2 == 5 then
																																				error("devirt: unstructured jump to block_2909") -- goto block_2909
																																			end

																																			if exitTo2 == 6 then
																																				error("devirt: unstructured jump to block_2964") -- goto block_2964
																																			end

																																			return
																																		end

																																		if exitTo8 == 5 then
																																			error("devirt: unstructured jump to block_2909") -- goto block_2909
																																		end

																																		if exitTo8 == 6 then
																																			error("devirt: unstructured jump to block_2964") -- goto block_2964
																																		end

																																		return
																																	end

																																	return
																																end

																																return
																															end

																															return
																														end

																														return
																													end

																													return
																												end

																												return
																											end

																											return
																										end
																									else
																										if exitTo15 == 2 then
																											error("devirt: unstructured jump to block_1741") -- goto block_1741
																										end

																										if exitTo15 == 3 then
																											error("devirt: unstructured jump to block_1815") -- goto block_1815
																										end

																										if exitTo15 == 4 then
																											error("devirt: unstructured jump to block_1893") -- goto block_1893
																										end

																										if exitTo15 == 5 then
																											error("devirt: unstructured jump to block_1671") -- goto block_1671
																										end

																										if exitTo15 ~= 6 then
																											if exitTo15 ~= 7 then
																												if exitTo15 == 8 then
																													error("devirt: unstructured jump to block_2909") -- goto block_2909
																												end

																												if exitTo15 ~= 9 then
																													error("devirt: unstructured jump to block_3019") -- goto block_3019
																												end

																												return
																											end

																											return
																										end

																										return
																									end
																								end

																								return
																							end
																						else
																							if exitTo12 == 4 then
																								error("devirt: unstructured jump to block_1671") -- goto block_1671
																							end

																							if exitTo12 == 5 then
																								error("devirt: unstructured jump to block_1741") -- goto block_1741
																							end

																							if exitTo12 == 6 then
																								error("devirt: unstructured jump to block_1815") -- goto block_1815
																							end

																							if exitTo12 == 7 then
																								error("devirt: unstructured jump to block_1893") -- goto block_1893
																							end

																							if exitTo12 ~= 8 then
																								if exitTo12 ~= 9 then
																									if exitTo12 == 10 then
																										if exitTo2 == 6 then
																											error("devirt: unstructured jump to block_2964") -- goto block_2964
																										end

																										return
																									end

																									error("devirt: unstructured jump to block_3019") -- goto block_3019
																								end

																								return
																							end

																							return
																						end

																						error("devirt: unstructured jump to block_3019") -- goto block_3019
																					end

																					return
																				end

																				return
																			else
																				if exitTo2 == 6 then
																					error("devirt: unstructured jump to block_2964") -- goto block_2964
																				end

																				return
																			end
																		end

																		error("devirt: unstructured jump to block_3019") -- goto block_3019
																	end

																	return
																end

																return
															else
																if exitTo == 5 then
																	error("devirt: unstructured jump to block_2909") -- goto block_2909
																end

																if exitTo == 6 then
																	error("devirt: unstructured jump to block_2964") -- goto block_2964
																end

																return
															end
														end

														error("devirt: unstructured jump to block_3019") -- goto block_3019
													end)
												end
											end
										end

										do
											local module

											do
												System.autoparry.stop = function()
													if System.__properties.__connections.__autoparry then
														System.__properties.__connections.__autoparry:Disconnect()
														System.__properties.__connections.__autoparry = nil
													end
												end

												System.auto_spam = {}

												System.auto_spam.get_entity_properties = function()
													tbl21.Closest_Player()
													if not Closest_Entity then
														return false
													end
													local primaryPart = Closest_Entity.PrimaryPart or Closest_Entity:FindFirstChild("HumanoidRootPart")
													local primaryPart2 = localPlayer.Character and (localPlayer.Character.PrimaryPart or localPlayer.Character:FindFirstChild("HumanoidRootPart"))
													if not primaryPart or not primaryPart2 then
														return false
													end

													return {
														Velocity = primaryPart.Velocity,
														Direction = (primaryPart2.Position - primaryPart.Position).Unit,
														Distance = (primaryPart2.Position - primaryPart.Position).Magnitude,
													}
												end

												System.auto_spam.get_ball_properties = function()
													local v90 = tbl21.Get_Ball()
													if not v90 then
														return false
													end
													local zoomies = v90:FindFirstChild("zoomies")
													if not zoomies then
														return false
													end
													local vectorVelocity = zoomies.VectorVelocity
													local v91 = tbl21.Ball_Position(v90)
													if not v91 then
														return false
													end
													local unit = (localPlayer.Character.PrimaryPart.Position - v91).Unit

													return {
														speed = vectorVelocity.Magnitude,
														Velocity = vectorVelocity,
														Direction = unit,
														Distance = (localPlayer.Character.PrimaryPart.Position - v91).Magnitude,
														Dot = unit:Dot(vectorVelocity.Unit),
													}
												end

												System.auto_spam.spam_service = function(arg)
													local v90 = tbl21.Get_Ball()
													local v91 = tbl21.Closest_Player()
													if not v90 or not v91 or not v91.PrimaryPart then
														return false
													end
													local zoomies = v90:FindFirstChild("zoomies")
													if not zoomies then
														return false
													end
													local vectorVelocity = zoomies.VectorVelocity
													local magnitude = vectorVelocity.Magnitude
													local v92 = tbl21.Ball_Position(v90)
													if not v92 then
														return false
													end
													local v93 = (localPlayer.Character.PrimaryPart.Position - v92).Unit:Dot(vectorVelocity.Unit)
													local n = arg.Ping + math.min(magnitude / 5, 95)
													if arg.Entity_Properties.Distance > n or arg.Ball_Properties.Distance > n then
														return 0
													end
													local n36 = 10 - math.min(magnitude / 5, 5)
													return n - math.clamp(v93, -1, 0) * n36
												end

												System.auto_spam.start = function()
													if System.__properties.__connections.__auto_spam then
														System.__properties.__connections.__auto_spam:Disconnect()
													end

													System.__properties.__auto_spam_enabled = true

													System.__properties.__connections.__auto_spam = v85.PreSimulation:Connect(function()
														local v90 = tbl21.Get_Ball()
														if not v90 then
															return
														end

														if System.__config.__detections.infinity and System.__state.infinity_active then
															return
														end

														if System.__config.__detections.slashes and System.__properties.slashesoffury_active then
															return
														end
														local zoomies = v90:FindFirstChild("zoomies")
														if not zoomies then
															return
														end
														tbl21.Closest_Player()

														if not Closest_Entity then
															if false then -- recovered opaque guard
																error("Unreachable obfuscation trap")
															end

															return
														end

														local primaryPart = Closest_Entity.PrimaryPart or Closest_Entity:FindFirstChild("HumanoidRootPart")
														if not primaryPart then
															return
														end
														local n = math.clamp(v86.Network.ServerStatsItem["Data Ping"]:GetValue() / 10, 10, 16)
														local attribute = v90:GetAttribute("target")
														local v91 = System.auto_spam:get_ball_properties()
														local v92 = System.auto_spam:get_entity_properties()

														if not (not v91 or not v92) then
															local v93 = System.auto_spam.spam_service({ Ball_Properties = v91, Entity_Properties = v92, Ping = n })
															local v94 = localPlayer:DistanceFromCharacter(primaryPart.Position)
															local v95 = tbl21.Ball_Position(v90)

															if not v95 then
																if true then -- recovered opaque guard
																	return
																end

																error("Unreachable obfuscation trap")
															end
															;(localPlayer.Character.PrimaryPart.Position - v95).Unit:Dot(zoomies.VectorVelocity.Unit)
															local v96 = localPlayer:DistanceFromCharacter(v95)
															if not attribute then
																return
															end

															if v94 > v93 or v96 > v93 then
																return
															end

															if localPlayer.Character:GetAttribute("Pulsed") then
																return
															end

															if attribute == localPlayer.Name and v94 > 30 and v96 > 30 then
																return
															end

															if v96 <= v93 and n33 > System.__properties.__spam_threshold then
																if getgenv().AutoSpamMode == "Keypress" then
																	virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
																	virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
																else
																	ExecuteParry(SelectedParryType)
																	tbl21.Play_Animation()
																end
															end

															return
														end

														if true then -- recovered opaque guard
															return
														end

														error("Unreachable obfuscation trap")
													end)
												end

												System.auto_spam.stop = function()
													System.__properties.__auto_spam_enabled = false

													if System.__properties.__connections.__auto_spam then
														System.__properties.__connections.__auto_spam:Disconnect()
														System.__properties.__connections.__auto_spam = nil
													end
												end

												v87.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(arg, arg2)
													local primaryPart = localPlayer2.Character.PrimaryPart
													local v90 = tbl21.Get_Ball()
													if not v90 then
														return
													end
													local zoomies = v90:FindFirstChild("zoomies")
													if not zoomies then
														return
													end
													local magnitude = zoomies.VectorVelocity.Magnitude
													local v91 = tbl21.Ball_Position(v90)

													if not v91 then
														if false then -- removed opaque flag guard
															return
														end
														return
													end

													local magnitude2 = (localPlayer2.Character.PrimaryPart.Position - v91).Magnitude
													local v92 = (localPlayer2.Character.PrimaryPart.Position - v91).Unit:Dot(zoomies.VectorVelocity.Unit)
													local value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
													local n = math.min(magnitude / 100, 40)
													local n36 = magnitude2 / magnitude - value / 1000
													local flag21 = magnitude > 100
													local n37 = 40 * math.max(v92, 0)
													local n38 = 15 - math.min(magnitude2 / 1000, 15) + n37 + n

													if flag21 and n36 > value / 10 then
														n38 = math.max(n38 - 10, 15)
													end

													if arg2 ~= primaryPart and magnitude2 > n38 then
														if true then -- recovered opaque guard
															tbl22.Curving = tick()
														else
															error("Unreachable obfuscation trap")
														end
													end
												end)

												System.manual_spam = {}

												System.manual_spam.start = function()
													if System.__properties.__connections.__manual_spam then
														System.__properties.__connections.__manual_spam:Disconnect()
													end

													System.__properties.__manual_spam_enabled = true

													System.__properties.__connections.__manual_spam = v85.PreSimulation:Connect(function()
														if not System.__properties.__manual_spam_enabled then
															return
														end

														if not localPlayer.Character or localPlayer.Character.Parent ~= alive then
															return
														end

														if getgenv().ManualSpamMode == "Keypress" then
															virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
															virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
														else
															ExecuteParry(SelectedParryType)

															if getgenv().ManualSpamAnimationFix then
																tbl21.Play_Animation()
															end
														end
													end)
												end

												System.manual_spam.stop = function()
													System.__properties.__manual_spam_enabled = false

													if System.__properties.__connections.__manual_spam then
														if true then -- recovered opaque guard
															System.__properties.__connections.__manual_spam:Disconnect()
															System.__properties.__connections.__manual_spam = nil
														else
															error("Unreachable obfuscation trap")
														end
													end
												end

												getgenv().ENABLED = false
												getgenv().SWORD_NAME = ""
												getgenv().SLASH_NAME = nil
												getgenv().ORIGINAL_SWORD = nil
												getgenv().ORIGINAL_SLASH = nil

												do
													local swords = v87:FindFirstChild("Shared") and v87.Shared:FindFirstChild("ReplicatedInstances") and v87.Shared.ReplicatedInstances:FindFirstChild("Swords")

													if not (swords and swords:IsA("ModuleScript")) then
														swords = nil

														for _, descendant in pairs(v87:GetDescendants()) do
															if descendant:IsA("ModuleScript") and descendant.Name == "Swords" then
																swords = descendant
																break
															else
																swords = nil
															end
														end
													end

													assert(swords, "Swords module not found")
													local v90 = getthreadidentity and getthreadidentity()

													if setthreadidentity then
														if true then -- recovered opaque guard
															setthreadidentity(2)
														else
															error("Unreachable obfuscation trap")
														end
													end

													module = require(swords)

													if setthreadidentity then
														setthreadidentity(v90 or 8)
													end
												end
											end

											local v90 = nil

											pcall(function()
												for _, v91 in pairs(getconnections(v87.Remotes.FireSwordInfo.OnClientEvent)) do
													if v91.Function and islclosure(v91.Function) then
														local v92 = getupvalues(v91.Function)
														if type(v92[1]) == "table" and v92[1].SetSword then
															v90 = v92[1]
															break
														end
													end
												end
											end)

											getgenv()._WindsWithId2 = function(arg)
												local v91 = getthreadidentity and getthreadidentity()

												if setthreadidentity then
													setthreadidentity(2)
												end

												local ok, result = pcall(arg)

												if setthreadidentity then
													setthreadidentity(v91 or 8)
												end

												return ok, result
											end

											getgenv().GetSlashNameSafe = function(arg)
												if module.GetSword then
													local sword = module:GetSword(arg)
													if sword and sword.SlashName then
														return sword.SlashName
													end
												end

												return arg
											end

											getgenv()._WindsResolveSword = function(arg)
												if not arg or arg == "" then
													return arg
												end

												if module.GetSword and module:GetSword(arg) then
													return arg
												end
												local collection = nil

												pcall(function()
													collection = module:GetCollection()
												end)

												if type(collection) ~= "table" then
													return arg
												end
												local v91 = string.lower(arg)

												for k, v92 in pairs(collection) do
													if type(k) == "string" and string.lower(k) == v91 then
														return k
													end

													if type(v92) == "table" and type(v92.DisplayName) == "string" and string.lower(v92.DisplayName) == v91 then
														return k
													end
												end

												return arg
											end

											getgenv()._WindsStripSwords = function(arg, arg2)
												for _, child in ipairs(arg:GetChildren()) do
													if child:GetAttribute("_equippedSword") and child.Name ~= arg2 then
														child:Destroy()
													end
												end
											end

											getgenv()._WindsHasSwordModel = function(arg, arg2)
												local v91 = arg and arg:FindFirstChild(arg2)
												return v91 and v91:GetAttribute("_equippedSword") == true
											end

											getgenv()._WindsCharReady = function(arg)
												if not arg or not arg.Parent then
													return false
												end

												if not arg:IsDescendantOf(workspace) then
													return false
												end

												if arg:FindFirstChildOfClass("Humanoid") then
													if not arg:FindFirstChild("Torso") then
														return false
													end

													if not arg:FindFirstChild("Left Arm") then
														return false
													end

													if not arg:FindFirstChild("Right Arm") then
														return false
													end
													return true
												end

												if true then -- recovered opaque guard
													return false
												end

												error("Unreachable obfuscation trap")
											end

											getgenv()._WindsSwordMountedOk = function(arg, arg2)
												local v91 = arg and arg:FindFirstChild(arg2)
												if not (v91 and v91:GetAttribute("_equippedSword") == true and v91.Parent == arg) then
													return false
												end
												local n = 0

												for _, descendant in ipairs(arg:GetDescendants()) do
													if descendant:HasTag("SwordMotor") then
														n += 1

														if descendant:IsA("Motor6D") or descendant:IsA("Weld") then
															if not descendant.Part0 or not descendant.Part1 or not descendant.Part0.Parent or not descendant.Part1.Parent then
																return false
															end
														end
													end
												end

												return n > 0
											end

											getgenv().ApplySword = function()
												if not getgenv().ENABLED then
													return
												end

												if getgenv()._WindsSwordBusy then
													return
												end
												local match = tostring(getgenv().SWORD_NAME or ""):match("^%s*(.-)%s*$") or ""
												if match == "" then
													return
												end
												local swordNotFound = getgenv()._WindsResolveSword(match)
												getgenv().SWORD_NAME = swordNotFound
												local character = localPlayer.Character
												if not character then
													return
												end

												if not getgenv()._WindsCharReady(character) then
													return
												end
												getgenv()._WindsSwordBusy = true

												if not getgenv().ORIGINAL_SWORD then
													getgenv().ORIGINAL_SWORD = character:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword")
												end

												if not getgenv().ORIGINAL_SLASH then
													getgenv().ORIGINAL_SLASH = getgenv().GetSlashNameSafe(getgenv().ORIGINAL_SWORD)
												end

												local ok, result = pcall(function()
													if not (module.GetSword and module:GetSword(swordNotFound)) then
														if getgenv()._WindsSwordMissing ~= swordNotFound then
															getgenv()._WindsSwordMissing = swordNotFound
															index.SendNotification({ title = "Skin Changer", text = "Sword not found: " .. swordNotFound, duration = 3 })
														end
													else
														getgenv()._WindsSwordMissing = nil

														getgenv()._WindsWithId2(function()
															if module.ForceEquipSwordTo then
																module:ForceEquipSwordTo(character, swordNotFound)
															else
																module:EquipSwordTo(character, swordNotFound)
															end
														end)
													end

													getgenv()._WindsWithId2(function()
														if not v90 then
															pcall(function()
																for _, v91 in pairs(getconnections(v87.Remotes.FireSwordInfo.OnClientEvent)) do
																	if v91.Function and islclosure(v91.Function) then
																		local v92 = getupvalues(v91.Function)
																		if type(v92[1]) == "table" and v92[1].SetSword then
																			v90 = v92[1]
																			break
																		end
																	end
																end
															end)
														end

														if v90 then
															pcall(function()
																v90:SetSword(swordNotFound)
															end)
														end
													end)

													character:SetAttribute("CurrentlyEquippedSword", swordNotFound)
													localPlayer:SetAttribute("CurrentlyEquippedSword", swordNotFound)
													getgenv()._WindsStripSwords(character, swordNotFound)
												end)

												local v91 = false
												getgenv()._WindsSwordBusy = v91

												if not ok then
													warn(result)

													if false then -- recovered opaque guard
														error("Unreachable obfuscation trap")
													end
												end
											end

											getgenv().updateSword = function()
												if getgenv().ApplySword then
													getgenv().ApplySword()
												end
											end

											getgenv().RestoreSword = function()
												local character = localPlayer.Character
												if not character then
													return
												end

												if not getgenv().ORIGINAL_SWORD then
													return
												end
												local originalSword = getgenv().ORIGINAL_SWORD

												getgenv()._WindsWithId2(function()
													if module.ForceEquipSwordTo then
														module:ForceEquipSwordTo(character, originalSword)
													else
														module:EquipSwordTo(character, originalSword)
													end

													if v90 then
														pcall(function()
															v90:SetSword(originalSword)
														end)
													end
												end)

												character:SetAttribute("CurrentlyEquippedSword", originalSword)
												localPlayer:SetAttribute("CurrentlyEquippedSword", originalSword)
												getgenv()._WindsStripSwords(character, originalSword)
												getgenv().SWORD_NAME = originalSword
												getgenv().SLASH_NAME = getgenv().ORIGINAL_SLASH
												getgenv().ORIGINAL_SWORD = nil
												getgenv().ORIGINAL_SLASH = nil
											end
										end
									end

									do
										localPlayer.CharacterAdded:Connect(function(character)
											task.spawn(function()
												if not character:WaitForChild("Humanoid", 8) then
													return
												end
												local now2 = os.clock()

												while character.Parent and not getgenv()._WindsCharReady(character) and os.clock() - now2 < 6 do
													task.wait(0.05)
												end

												if localPlayer.Character ~= character then
													return
												end
												local now3 = os.clock()

												while true do
													if localPlayer.Character == character and os.clock() - now3 < 2 then
														if not character:GetAttribute("AppearanceLoaded") then
															task.wait(0.2)
															continue
														end
													end

													break
												end

												task.wait(0.3)
												if localPlayer.Character ~= character then
													return
												end

												if getgenv().ENABLED and getgenv().ApplySword then
													getgenv().ApplySword()
												end

												task.wait(0.55)

												if localPlayer.Character == character and getgenv().ENABLED and getgenv().ApplySword then
													getgenv().ApplySword()
												end
											end)
										end)

										getgenv()._WindsSwordKeepId = (getgenv()._WindsSwordKeepId or 0) + 1

										task.spawn(function()
											local windsSwordKeepId = getgenv()._WindsSwordKeepId

											while getgenv()._WindsSwordKeepId == windsSwordKeepId do
												task.wait(0.35)

												if getgenv().ENABLED and getgenv().SWORD_NAME and getgenv().SWORD_NAME ~= "" then
													local character = localPlayer.Character

													if character and getgenv()._WindsCharReady(character) then
														local swordName = getgenv().SWORD_NAME

														if not getgenv()._WindsSwordMountedOk(character, swordName) then
															if getgenv().ApplySword then
																getgenv().ApplySword()
															end
														elseif getgenv()._WindsStripSwords then
															getgenv()._WindsStripSwords(character, swordName)
														end
													end
												end
											end
										end)

										do
											local function_ = nil

											for _, v90 in pairs(getconnections(v87.Remotes.ParrySuccessAll.OnClientEvent)) do
												if v90.Function and getinfo(v90.Function).name == "parrySuccessAll" then
													function_ = v90.Function
													v90:Disable()
													break
												end
											end

											v87.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
												setthreadidentity(2)
												local tbl23 = { ... }
												local name = localPlayer.Name

												if tostring(tbl23[4]) == name then
													if getgenv().SLASH_NAME and getgenv().SLASH_NAME ~= "" then
														tbl23[1] = getgenv().SLASH_NAME
													end

													if getgenv().SWORD_NAME and getgenv().SWORD_NAME ~= "" then
														tbl23[3] = getgenv().SWORD_NAME
													end
												end

												return function_(unpack(tbl23))
											end)
										end
									end

									do
										local function fn30()
											tbl20.Triggerbot = v85.PreSimulation:Connect(function()
												local v90 = tbl21.Get_Balls()

												for _, v91 in pairs(v90) do
													if not v91 then
														return
													end

													v91:GetAttributeChangedSignal("target"):Once(function()
														flag18 = false
													end)

													if flag18 then
														return
													end
													local attribute = v91:GetAttribute("target")
													local character = localPlayer.Character
													if not character or not character.PrimaryPart then
														return
													end

													if character.PrimaryPart:FindFirstChild("SingularityCape") then
														return
													end

													if getgenv().TriggerbotInfinityDetection and System.__state.infinity_active then
														return
													end

													if attribute == tostring(localPlayer) then
														local triggerbotHumanizer = getgenv().TriggerbotHumanizer or 0
														flag18 = true

														task.delay(triggerbotHumanizer / 1000, function()
															if not getgenv().triggerbot_enabled then
																return
															end

															if getgenv().TriggerbotKeypress then
																mouse1click()
															else
																ExecuteParry(SelectedParryType)
																tbl21.Play_Animation()
															end
														end)
													end

													local now2 = tick()

													while true do
														v85.PreSimulation:Wait()
														local v92 = 1
														if not (tick() - now2 >= v92 or not flag18) then
															continue
														end
														break
													end

													flag18 = false
												end
											end)
										end

										local function fn31()
											if tbl20.Triggerbot then
												tbl20.Triggerbot:Disconnect()
												tbl20.Triggerbot = nil
											end

											flag18 = false
										end

										getgenv().AutoParryNotify = false

										v89 = Combat:create_module({
											title = "Auto Parry",
											flag = "AutoParry",
											description = "Automatically parries incoming balls",
											section = "left",
											callback = function(autoparryEnabled)
												System.__properties.__autoparry_enabled = autoparryEnabled

												if autoparryEnabled then
													System.autoparry.start()
												else
													System.autoparry.stop()
												end

												if getgenv().AutoParryNotify then
													index.SendNotification({
														title = "Auto Parry",
														text = autoparryEnabled and "ON" or "OFF",
														duration = 2,
														icon = "rbxassetid://128616761621643",
													})
												end
											end,
										})

										local v90 = Combat:create_module({
											title = "Triggerbot",
											description = "Parries instantly if targeted",
											flag = "triggerbot",
											section = "left",
											callback = function(triggerbotEnabled)
												getgenv().triggerbot_enabled = triggerbotEnabled

												if triggerbotEnabled then
													fn30()
												else
													if false then -- recovered opaque guard
														error("Unreachable obfuscation trap")
													end

													fn31()
												end

												if getgenv().TriggerbotNotify then
													index.SendNotification({
														title = "Triggerbot",
														text = triggerbotEnabled and "ON" or "OFF",
														duration = 2,
														icon = "rbxassetid://128616761621643",
													})
												end
											end,
										})

										if flag20 then
											v90:create_checkbox({
												title = "Mobile UI",
												flag = "TriggerbotMobileUI",
												description = "Show/Hide mobile interface",
												callback = function(triggerbotui)
													getgenv().triggerbotui = triggerbotui

													if triggerbotui then
														if game.CoreGui:FindFirstChild("TriggerbotUI") then
															game.CoreGui:FindFirstChild("TriggerbotUI"):Destroy()
														end

														if tbl20["Triggerbot UI"] then
															tbl20["Triggerbot UI"]:Disconnect()
															tbl20["Triggerbot UI"] = nil
														end

														local screenGui = Instance.new("ScreenGui")
														screenGui.Name = "TriggerbotUI"
														screenGui.ResetOnSpawn = false
														screenGui.Parent = game.CoreGui
														local frame = Instance.new("Frame")
														frame.Size = UDim2.new(0, 170, 0, 60)
														frame.Position = UDim2.new(0.5, -85, 0.1, 0)
														frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
														frame.BorderSizePixel = 0
														frame.Active = true
														frame.Draggable = true
														frame.Parent = screenGui
														local uiCorner = Instance.new("UICorner")
														uiCorner.CornerRadius = UDim.new(0, 12)
														uiCorner.Parent = frame
														local uiStroke = Instance.new("UIStroke")
														uiStroke.Thickness = 2
														uiStroke.Color = Color3.fromRGB(90, 120, 255)
														uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
														uiStroke.Parent = frame
														local color = Color3.fromRGB(90, 120, 255)
														local color2 = Color3.fromRGB(255, 100, 0)
														local textLabel = Instance.new("TextLabel")
														textLabel.BackgroundTransparency = 1
														textLabel.Size = UDim2.new(1, 0, 1, 0)
														textLabel.Text = "Triggerbot"
														textLabel.Font = Enum.Font.GothamBold
														textLabel.TextSize = 18
														textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
														textLabel.Parent = frame

														if getgenv().triggerbot_enabled then
															textLabel.Text = "Triggerbot ON"
															uiStroke.Color = color2
														else
															textLabel.Text = "Triggerbot"
															uiStroke.Color = color
														end

														frame.InputBegan:Connect(function(input)
															if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																local triggerbotEnabled = not getgenv().triggerbot_enabled
																getgenv().triggerbot_enabled = triggerbotEnabled

																if triggerbotEnabled then
																	textLabel.Text = "Triggerbot ON"
																	uiStroke.Color = color2
																	fn30()

																	if v90 and v90.update_flag then
																		v90:update_flag(true)
																	end

																	if getgenv().TriggerbotNotify then
																		index.SendNotification({
																			title = "Triggerbot",
																			text = "ON",
																			duration = 2,
																			icon = "rbxassetid://128616761621643",
																		})
																	end
																else
																	textLabel.Text = "Triggerbot"
																	uiStroke.Color = color
																	fn31()
																	if false then -- removed opaque flag guard
																		return
																	end

																	if v90 and v90.update_flag then
																		v90:update_flag(false)
																	end

																	if getgenv().TriggerbotNotify then
																		index.SendNotification({
																			title = "Triggerbot",
																			text = "OFF",
																			duration = 2,
																			icon = "rbxassetid://128616761621643",
																		})
																	end
																end
															end
														end)
													elseif game.CoreGui:FindFirstChild("TriggerbotUI") then
														game.CoreGui:FindFirstChild("TriggerbotUI"):Destroy()
													end
												end,
											})
										end

										v90:create_slider({
											title = "Delay",
											flag = "TriggerbotHumanizer",
											minimum_value = 0,
											maximum_value = 200,
											value = 100,
											round_number = true,
											callback = function(triggerbotHumanizer)
												getgenv().TriggerbotHumanizer = triggerbotHumanizer
											end,
										})

										v90:create_checkbox({
											title = "Notify",
											flag = "TriggerbotNotify",
											callback = function(triggerbotNotify)
												getgenv().TriggerbotNotify = triggerbotNotify
											end,
										})
									end
								end

								do
									do
										v89:create_slider({
											title = "Accuracy",
											flag = "ParryAccuracy",
											maximum_value = 100,
											minimum_value = 1,
											value = 25,
											round_number = true,
											callback = function(arg)
												n35 = arg
												fn29()
												getgenv().Parry_Accuracy = math.floor((25 - n34 * 25) * 100) / 100
											end,
										})

										v89:create_slider({
											title = "Parry Range",
											flag = "ParryRange",
											minimum_value = 1,
											maximum_value = 10,
											value = 1,
											round_number = true,
											callback = function(parryRange)
												getgenv().Parry_Range = parryRange
											end,
										})

										v89:create_checkbox({
											title = "Backwards Anticurve",
											flag = "BackwardsAnticurve",
											callback = function(backWardsAntiCurve)
												getgenv().BackWardsAntiCurve = backWardsAntiCurve
											end,
										})

										v89:create_divider({})

										v89:create_dropdown({
											title = "Parry Method",
											flag = "Method",
											options = { "Velocity", "Distance" },
											default = "Distance",
											multi_dropdown = false,
											maximum_options = 2,
											callback = function(autoParryMode)
												getgenv().AutoParryMode = autoParryMode
											end,
										})

										v89:create_dropdown({
											title = "Parry Loop",
											flag = "ParryStep",
											options = { "PreSimulation", "PostSimulation", "PreRender" },
											default = "PreSimulation",
											multi_dropdown = false,
											maximum_options = 3,
											callback = function(parryStep)
												getgenv().ParryStep = parryStep

												if System.__properties.__connections.__autoparry then
													System.autoparry.start()
												end
											end,
										})

										getgenv().CurveNotify = true

										do
											local v90 = nil

											v89:create_dropdown({
												title = "Curve Type",
												flag = "ParryDirection",
												options = { "Random", "Camera", "Dot", "FFA", "Backwards" },
												multi_dropdown = false,
												maximum_options = 999,
												bindable = true,
												callback = function(arg)
													local v91 = "string"
													local name = typeof(arg) == v91 and arg or arg and arg.Name or tostring(arg)
													local flag21 = v90 ~= nil and v90 ~= name
													SelectedParryType = name
													v90 = name
													if not flag21 or not getgenv().CurveNotify then
														return
													end
													local keybinds = index._config._keybinds and index._config._keybinds["ParryDirection_" .. name]
													local str7

													if keybinds then
														str7 = name .. "  [" .. string.gsub(tostring(keybinds), "Enum.KeyCode.", "") .. "]"
													else
														str7 = name
													end

													index.SendNotification({ title = "Curve Type", text = str7, duration = 2 })
												end,
											})
										end
									end

									v89:create_divider({})

									v89:create_checkbox({
										title = "Cooldown Protection",
										flag = "CooldownProtection",
										callback = function(cooldownProtection)
											getgenv().CooldownProtection = cooldownProtection
										end,
									})

									do
										local HttpService = game:GetService("HttpService")
										local windsStats = workspace:FindFirstChild("WindsStats") or Instance.new("Folder", workspace)
										windsStats.Name = "WindsStats"

										local function fn30()
											local ballUiPos = windsStats:FindFirstChild("ball_ui_pos")
											if not ballUiPos then
												return nil
											end

											local ok, result = pcall(function()
												return HttpService:JSONDecode(ballUiPos.Value)
											end)

											if ok and result and result.x and result.y then
												return UDim2.new(0, result.x, 0, result.y)
											end
											return nil
										end

										local function fn31(arg)
											local json = HttpService:JSONEncode({ x = arg.X.Offset, y = arg.Y.Offset })
											local ballUiPos = windsStats:FindFirstChild("ball_ui_pos") or Instance.new("StringValue", windsStats)
											ballUiPos.Name = "ball_ui_pos"
											ballUiPos.Value = json
										end

										tbl12 = {
											__config = {
												gui_name = "BallStatsGui",
												colors = {
													bg_main = Color3.fromRGB(12, 12, 15),
													bg_card = Color3.fromRGB(20, 20, 25),
													text_primary = Color3.fromRGB(255, 255, 255),
													text_secondary = Color3.fromRGB(180, 180, 190),
													text_muted = Color3.fromRGB(90, 90, 100),
													accent_primary = Color3.fromRGB(0, 230, 255),
													accent_secondary = Color3.fromRGB(255, 60, 120),
													border = Color3.fromRGB(45, 45, 55),
													gradient_main_1 = Color3.fromRGB(30, 30, 40),
													gradient_main_2 = Color3.fromRGB(60, 60, 80),
												},
											},
											__state = {
												active = false,
												gui = nil,
												ball_data = {},
												is_dragging = false,
											},
											create_corner = function(arg)
												local uiCorner = Instance.new("UICorner")
												uiCorner.CornerRadius = UDim.new(0, arg or 10)
												return uiCorner
											end,
											create_stroke = function(thickness, color, transparency)
												local uiStroke = Instance.new("UIStroke")
												uiStroke.Thickness = thickness or 1
												uiStroke.Color = color or tbl12.__config.colors.border
												uiStroke.Transparency = transparency or 0
												uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
												return uiStroke
											end,
											create_gradient = function(rotation, arg, arg2)
												local uiGradient = Instance.new("UIGradient")
												uiGradient.Rotation = rotation or 45
												local new = ColorSequenceKeypoint.new
												uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, arg), new(1, arg2) })
												return uiGradient
											end,
											create_stat_card = function(parent, arg, arg2, backgroundColor3, text)
												local frame = Instance.new("Frame")
												frame.Size = UDim2.new(1, 0, 0, 55)
												frame.Position = UDim2.new(0, 0, 0, arg)
												frame.BackgroundColor3 = tbl12.__config.colors.bg_card
												frame.BackgroundTransparency = 0.3
												frame.BorderSizePixel = 0
												frame.Parent = parent
												tbl12.create_corner(12).Parent = frame
												tbl12.create_stroke(1, tbl12.__config.colors.border, 0.6).Parent = frame
												local frame2 = Instance.new("Frame")
												frame2.Size = UDim2.new(0, 36, 0, 36)
												frame2.Position = UDim2.new(0, 12, 0.5, -18)
												frame2.BackgroundColor3 = backgroundColor3
												frame2.BackgroundTransparency = 0.85
												frame2.BorderSizePixel = 0
												frame2.Parent = frame
												tbl12.create_corner(10).Parent = frame2
												tbl12.create_stroke(1.5, backgroundColor3, 0.4).Parent = frame2
												local textLabel = Instance.new("TextLabel")
												textLabel.Size = UDim2.new(1, 0, 1, 0)
												textLabel.BackgroundTransparency = 1
												textLabel.Text = text or "⚡"
												textLabel.TextColor3 = backgroundColor3
												textLabel.TextSize = 14
												textLabel.Font = Enum.Font.GothamBold
												textLabel.Parent = frame2
												local textLabel2 = Instance.new("TextLabel")
												textLabel2.Size = UDim2.new(1, -60, 0, 11)
												textLabel2.Position = UDim2.new(0, 56, 0, 10)
												textLabel2.BackgroundTransparency = 1
												textLabel2.Text = string.upper(arg2)
												textLabel2.TextColor3 = tbl12.__config.colors.text_muted
												textLabel2.Font = Enum.Font.GothamBold
												textLabel2.TextSize = 10
												textLabel2.TextXAlignment = Enum.TextXAlignment.Left
												textLabel2.Parent = frame
												local textLabel3 = Instance.new("TextLabel")
												textLabel3.Size = UDim2.new(1, -60, 0, 24)
												textLabel3.Position = UDim2.new(0, 56, 0, 24)
												textLabel3.BackgroundTransparency = 1
												textLabel3.Text = "0.0"
												textLabel3.TextColor3 = tbl12.__config.colors.text_primary
												textLabel3.Font = Enum.Font.GothamBlack
												textLabel3.TextSize = 22
												textLabel3.TextXAlignment = Enum.TextXAlignment.Left
												textLabel3.Parent = frame
												local textLabel4 = Instance.new("TextLabel")
												textLabel4.Size = UDim2.new(0, 50, 1, 0)
												textLabel4.Position = UDim2.new(1, -14, 0, 0)
												textLabel4.BackgroundTransparency = 1
												textLabel4.TextColor3 = tbl12.__config.colors.text_muted
												textLabel4.Font = Enum.Font.GothamMedium
												textLabel4.TextSize = 9
												textLabel4.TextTransparency = 0.5
												textLabel4.TextXAlignment = Enum.TextXAlignment.Right
												textLabel4.Parent = frame
												return textLabel3
											end,
											create_gui = function()
												local instance = Instance.new("ScreenGui")
												instance.Name = tbl12.__config.gui_name
												instance.ResetOnSpawn = false
												instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
												instance.Parent = localPlayer:WaitForChild("PlayerGui")
												local frame = Instance.new("Frame")
												frame.Name = "MainFrame"
												frame.Size = UDim2.new(0, 190, 0, 95)
												frame.Position = fn30() or UDim2.new(0, 40, 0, 200)
												frame.BackgroundColor3 = tbl12.__config.colors.bg_main
												frame.BackgroundTransparency = 0.15
												frame.BorderSizePixel = 0
												frame.Active = true
												frame.Parent = instance
												tbl12.create_corner(12).Parent = frame
												tbl12.create_stroke(1, tbl12.__config.colors.border, 0.6).Parent = frame
												local textLabel = Instance.new("TextLabel")
												textLabel.Size = UDim2.new(1, -16, 0, 20)
												textLabel.Position = UDim2.new(0, 8, 0, 6)
												textLabel.BackgroundTransparency = 1
												textLabel.Text = "BALL VELOCITY"
												textLabel.TextColor3 = tbl12.__config.colors.text_secondary
												textLabel.Font = Enum.Font.GothamMedium
												textLabel.TextSize = 10
												textLabel.TextXAlignment = Enum.TextXAlignment.Left
												textLabel.Parent = frame
												local frame2 = Instance.new("Frame")
												frame2.Size = UDim2.new(1, -16, 0, 1)
												frame2.Position = UDim2.new(0, 8, 0, 28)
												frame2.BackgroundColor3 = tbl12.__config.colors.border
												frame2.BackgroundTransparency = 0.7
												frame2.BorderSizePixel = 0
												frame2.Parent = frame
												local textLabel2 = Instance.new("TextLabel")
												textLabel2.Size = UDim2.new(0.5, 0, 0, 16)
												textLabel2.Position = UDim2.new(0, 8, 0, 36)
												textLabel2.BackgroundTransparency = 1
												textLabel2.Text = "Current"
												textLabel2.TextColor3 = tbl12.__config.colors.text_muted
												textLabel2.Font = Enum.Font.Gotham
												textLabel2.TextSize = 12
												textLabel2.TextXAlignment = Enum.TextXAlignment.Left
												textLabel2.Parent = frame
												local textLabel3 = Instance.new("TextLabel")
												textLabel3.Size = UDim2.new(0.5, -8, 0, 18)
												textLabel3.Position = UDim2.new(0.5, 0, 0, 34)
												textLabel3.BackgroundTransparency = 1
												textLabel3.Text = "0.0"
												textLabel3.TextColor3 = tbl12.__config.colors.text_primary
												textLabel3.Font = Enum.Font.GothamBold
												textLabel3.TextSize = 14
												textLabel3.TextXAlignment = Enum.TextXAlignment.Right
												textLabel3.Parent = frame
												local textLabel4 = Instance.new("TextLabel")
												textLabel4.Size = UDim2.new(0.5, 0, 0, 16)
												textLabel4.Position = UDim2.new(0, 8, 0, 58)
												textLabel4.BackgroundTransparency = 1
												textLabel4.Text = "Peak"
												textLabel4.TextColor3 = tbl12.__config.colors.text_muted
												textLabel4.Font = Enum.Font.Gotham
												textLabel4.TextSize = 12
												textLabel4.TextXAlignment = Enum.TextXAlignment.Left
												textLabel4.Parent = frame
												local textLabel5 = Instance.new("TextLabel")
												textLabel5.Size = UDim2.new(0.5, -8, 0, 18)
												textLabel5.Position = UDim2.new(0.5, 0, 0, 56)
												textLabel5.BackgroundTransparency = 1
												textLabel5.Text = "0.0"
												textLabel5.TextColor3 = tbl12.__config.colors.accent_secondary
												textLabel5.Font = Enum.Font.GothamBold
												textLabel5.TextSize = 14
												textLabel5.TextXAlignment = Enum.TextXAlignment.Right
												textLabel5.Parent = frame
												local UserInputService = game:GetService("UserInputService")
												local position = nil
												local position2 = nil

												frame.InputBegan:Connect(function(input)
													if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
														tbl12.__state.is_dragging = true
														position = input.Position
														position2 = frame.Position
														local connection = nil

														connection = input.Changed:Connect(function()
															if input.UserInputState == Enum.UserInputState.End then
																tbl12.__state.is_dragging = false
																connection:Disconnect()
																fn31(frame.Position)
															end
														end)
													end
												end)

												UserInputService.InputChanged:Connect(function(input)
													if tbl12.__state.is_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
														local n = input.Position - position
														frame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n.X, position2.Y.Scale, position2.Y.Offset + n.Y)
													end
												end)

												return instance, textLabel3, textLabel5
											end,
											start = function()
												if tbl12.__state.active then
													return
												end
												tbl12.__state.active = true
												tbl12.__state.ball_data = {}
												local v90, v91, v92 = tbl12.create_gui()
												tbl12.__state.gui = v90
												local RunService = game:GetService("RunService")

												if System and System.__properties and System.__properties.__connections then
													System.__properties.__connections.ball_velocity = RunService.Heartbeat:Connect(function()
														local v93 = tbl21.Get_Ball()

														if not v93 then
															v91.Text = "0.0"
															v92.Text = "0.0"
															if false then -- removed missing opaque flag guard
																return
															end
															return
														end

														local zoomies = v93:FindFirstChild("zoomies")
														if not zoomies then
															v91.Text = "0.0"
															return
														end
														local magnitude = zoomies.VectorVelocity.Magnitude
														tbl12.__state.ball_data[v93] = tbl12.__state.ball_data[v93] or 0

														if tbl12.__state.ball_data[v93] < magnitude then
															tbl12.__state.ball_data[v93] = magnitude
														end

														v91.Text = string.format("%.1f", magnitude)
														v92.Text = string.format("%.1f", tbl12.__state.ball_data[v93])
													end)
												else
													warn("System or connection table not found. UI created but will not update stats.")
												end
											end,
											stop = function()
												if not tbl12.__state.active then
													return
												end
												tbl12.__state.active = false

												if System and System.__properties and System.__properties.__connections and System.__properties.__connections.ball_velocity then
													System.__properties.__connections.ball_velocity:Disconnect()
													System.__properties.__connections.ball_velocity = nil
												end

												if tbl12.__state.gui then
													tbl12.__state.gui:Destroy()
													tbl12.__state.gui = nil
												end

												tbl12.__state.ball_data = {}
											end,
										}
									end
								end

								do
									Misc:create_module({
										title = "Show Ball Velocity",
										description = "",
										flag = "ballvelocity",
										section = "left",
										callback = function(arg)
											if arg then
												tbl12.start()
											else
												tbl12.stop()
											end
										end,
									})

									tbl21.Lobby_Balls = function()
										for _, child in pairs(workspace.TrainingBalls:GetChildren()) do
											if child:GetAttribute("realBall") then
												return child
											end
										end
									end

									do
										local v90 = false
										getgenv().AutoSpamNotify = v90
									end
								end

								do
									local v90 = Combat:create_module({
										title = "Auto Spam",
										flag = "Auto_Spam_Parry",
										description = "Automatically spam parries ball",
										section = "right",
										callback = function(autoSpamEnabled)
											System.__properties.__auto_spam_enabled = autoSpamEnabled

											if autoSpamEnabled then
												System.auto_spam.start()
											else
												System.auto_spam.stop()
											end

											if getgenv().AutoSpamNotify then
												index.SendNotification({
													title = "Auto Spam",
													text = autoSpamEnabled and "ON" or "OFF",
													duration = 2,
													icon = "rbxassetid://128616761621643",
												})
											end
										end,
									})

									v90:create_dropdown({
										title = "Mode",
										flag = "autospam_mode",
										options = { "Remote", "Keypress" },
										default = "Remote",
										multi_dropdown = false,
										maximum_options = 2,
										callback = function(autoSpamMode)
											getgenv().AutoSpamMode = autoSpamMode
										end,
									})

									getgenv().ManualSpamNotify = false

									local v91 = Combat:create_module({
										title = "Manual Spam",
										description = "High-frequency parry spam",
										flag = "manualspam",
										section = "right",
										callback = function(manualSpamEnabled)
											System.__properties.__manual_spam_enabled = manualSpamEnabled

											if manualSpamEnabled then
												System.manual_spam.start()
											else
												System.manual_spam.stop()
											end

											if getgenv().ManualSpamNotify then
												index.SendNotification({
													title = "Manual Spam",
													text = manualSpamEnabled and "ON" or "OFF",
													duration = 2,
													icon = "rbxassetid://128616761621643",
												})
											end
										end,
									})

									if flag20 then
										v91:create_checkbox({
											title = "Manual Spam UI",
											flag = "Manual_Spam_UI",
											callback = function(spamui)
												getgenv().spamui = spamui

												if game.CoreGui:FindFirstChild("ManualSpamUI") then
													game.CoreGui:FindFirstChild("ManualSpamUI"):Destroy()
												end

												if tbl20["Manual Spam UI"] then
													tbl20["Manual Spam UI"]:Disconnect()
													tbl20["Manual Spam UI"] = nil
												end

												if not spamui then
													return
												end
												local RunService = game:GetService("RunService")
												local instance = Instance.new("ScreenGui")
												instance.Name = "ManualSpamUI"
												instance.ResetOnSpawn = false
												instance.Parent = game.CoreGui
												local frame = Instance.new("Frame")
												frame.Size = UDim2.new(0, 170, 0, 60)
												frame.Position = UDim2.new(0.5, -85, 0.85, 0)
												frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
												frame.BorderSizePixel = 0
												frame.Active = true
												frame.Draggable = true
												frame.Parent = instance
												local instance2 = Instance.new("UICorner")
												instance2.CornerRadius = UDim.new(0, 12)
												instance2.Parent = frame
												local instance3 = Instance.new("UIStroke")
												instance3.Thickness = 2
												instance3.Color = Color3.fromRGB(90, 120, 255)
												instance3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
												instance3.Parent = frame
												local textLabel = Instance.new("TextLabel")
												textLabel.BackgroundTransparency = 1
												textLabel.Size = UDim2.new(1, 0, 1, 0)
												textLabel.Text = "Spam"
												textLabel.Font = Enum.Font.GothamBold
												textLabel.TextSize = 18
												textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
												textLabel.Parent = frame
												local flag21 = false

												frame.InputBegan:Connect(function(input)
													if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
														flag21 = not flag21

														if flag21 then
															textLabel.Text = "Spam ON"
															instance3.Color = Color3.fromRGB(80, 120, 120)

															tbl20["Manual Spam UI"] = RunService.PreSimulation:Connect(function()
																ExecuteParry(SelectedParryType)
																tbl21.Play_Animation()
															end)
														else
															textLabel.Text = "Spam"
															instance3.Color = Color3.fromRGB(90, 120, 255)

															if tbl20["Manual Spam UI"] then
																tbl20["Manual Spam UI"]:Disconnect()
																tbl20["Manual Spam UI"] = nil
															end
														end
													end
												end)
											end,
										})
									end

									v91:create_dropdown({
										title = "Mode",
										flag = "manualspam_mode",
										options = { "Remote", "Keypress" },
										default = "Remote",
										multi_dropdown = false,
										maximum_options = 2,
										callback = function(manualSpamMode)
											getgenv().ManualSpamMode = manualSpamMode
										end,
									})

									v91:create_checkbox({
										title = "Animation Fix",
										flag = "ManualSpamAnimationFix",
										callback = function(manualSpamAnimationFix)
											getgenv().ManualSpamAnimationFix = manualSpamAnimationFix
										end,
									})

									v91:create_checkbox({
										title = "Notify",
										flag = "Manualspam",
										callback = function(manualSpamNotify)
											getgenv().ManualSpamNotify = manualSpamNotify
										end,
									})

									v90:create_slider({
										title = "Parry Threshold",
										flag = "Parry_Threshold",
										maximum_value = 3,
										minimum_value = 0,
										value = 1.5,
										round_number = false,
										callback = function(spamThreshold)
											ParryThreshold = spamThreshold
											System.__properties.__spam_threshold = spamThreshold
										end,
									})

									v90:create_checkbox({
										title = "Notify",
										flag = "fuckinguatospamnotify",
										callback = function(autoSpamNotify)
											getgenv().AutoSpamNotify = autoSpamNotify
										end,
									})
								end
							end

							do
								local flag21, clone

								do
									do
										local flag22, connection, tbl23, fn30

										do
											local Players, fn31

											do
												Combat:create_module({
													title = "Humanizer",
													flag = "Human_izer",
													description = "Randomizes parry accuracy",
													section = "right",
													callback = function(arg)
														HumanizerEnabled = arg
														fn29()
													end,
												}):create_range_slider({
													title = "Randomized Pairy Accuracy",
													flag = "RandomRange",
													minimum_value = 1,
													maximum_value = 100,
													min_value = 20,
													max_value = 50,
													round_number = true,
													callback = function(randomMin, randomMax)
														getgenv().RandomMin = randomMin
														getgenv().RandomMax = randomMax

														if HumanizerEnabled then
															fn29()
														end
													end,
												})

												Players = game:GetService("Players")
												getgenv().StaffDetectNotify = true

												do
													local tbl24 = {
														Mod = true,
														Support = true,
														Admin = true,
														Developer = true,
														["Lead Developer"] = true,
														Management = true,
														Executive = true,
														["Co-Owner"] = true,
														Contributor = true,
														["Trial QA"] = true,
														Holder = true,
													}

													flag22 = false
													connection = nil
													tbl23 = {}

													fn31 = function(arg)
														local roleInGroup = arg:GetRoleInGroup(12836673)
														return tbl24[roleInGroup] == true, roleInGroup
													end
												end
											end

											do
												local function fn32(arg)
													if not flag22 then
														return
													end

													if arg == localPlayer then
														return
													end

													if tbl23[arg] then
														return
													end
													local v90, v91 = fn31(arg)

													if v90 then
														tbl23[arg] = true

														if getgenv().StaffDetectNotify then
															index.SendNotification({
																title = "Staff Detected ⚠",
																text = arg.Name .. " | " .. v91,
																duration = 10,
																icon = "rbxassetid://128616761621643",
															})
														end
													end
												end

												fn30 = function()
													for _, player in ipairs(Players:GetPlayers()) do
														fn32(player)
													end

													connection = Players.PlayerAdded:Connect(function(player)
														task.wait(1)
														fn32(player)
													end)
												end
											end
										end

										do
											do
												local function fn31()
													if connection then
														connection:Disconnect()
														connection = nil
													end

													table.clear(tbl23)
												end

												Detection:create_module({
													title = "Staff detection",
													flag = "detect_staff",
													description = "Detect staff members and notify",
													section = "left",
													callback = function(arg)
														flag22 = arg

														if arg then
															fn30()
														else
															fn31()
														end
													end,
												})
											end
										end
									end

									Lighting = game:GetService("Lighting")
									flag21 = false
									clone = nil

									do
										local sky = Lighting:FindFirstChildOfClass("Sky")

										if sky then
											clone = sky:Clone()
											sky:Destroy()
										end
									end
								end

								do
									do
										Lighting.GlobalShadows = true

										do
											local tbl23 = {
												Piss = {
													SkyboxUp = "rbxassetid://2651437350",
													SkyboxRt = "rbxassetid://2651436979",
													SkyboxLf = "rbxassetid://2651436494",
													SkyboxFt = "rbxassetid://2651435990",
													SkyboxBk = "rbxassetid://2651432901",
													SkyboxDn = "rbxassetid://2651434974",
												},
												Peach = {
													SkyboxUp = "rbxassetid://566616187",
													SkyboxRt = "rbxassetid://566616082",
													SkyboxLf = "rbxassetid://566616044",
													SkyboxFt = "rbxassetid://566616141",
													SkyboxBk = "rbxassetid://566616113",
													SkyboxDn = "rbxassetid://566616232",
												},
												Saku = {
													SkyboxUp = "http://www.roblox.com/asset/?id=271077958",
													SkyboxRt = "http://www.roblox.com/asset/?id=271042467",
													SkyboxLf = "http://www.roblox.com/asset/?id=271042310",
													SkyboxFt = "http://www.roblox.com/asset/?id=271042556",
													SkyboxBk = "http://www.roblox.com/asset/?id=271042516",
													SkyboxDn = "http://www.roblox.com/asset/?id=271077243",
												},
												Purple = {
													SkyboxUp = "http://www.roblox.com/asset/?id=570557727",
													SkyboxRt = "http://www.roblox.com/asset/?id=570557672",
													SkyboxLf = "http://www.roblox.com/asset/?id=570557620",
													SkyboxFt = "http://www.roblox.com/asset/?id=570557559",
													SkyboxBk = "http://www.roblox.com/asset/?id=570557514",
													SkyboxDn = "http://www.roblox.com/asset/?id=570557775",
												},
												Retro = {
													SkyboxUp = "rbxassetid://18164890128",
													SkyboxRt = "rbxassetid://18164873920",
													SkyboxLf = "rbxassetid://18164877945",
													SkyboxFt = "rbxassetid://18164870251",
													SkyboxBk = "rbxassetid://18164881924",
													SkyboxDn = "rbxassetid://18166113875",
												},
												Space = {
													SkyboxUp = "rbxassetid://15983964246",
													SkyboxRt = "rbxassetid://15983966246",
													SkyboxLf = "rbxassetid://15983967420",
													SkyboxFt = "rbxassetid://15983965025",
													SkyboxBk = "rbxassetid://15983968922",
													SkyboxDn = "rbxassetid://15983966825",
												},
												Sea = {
													SkyboxUp = "http://www.roblox.com/asset/?id=321846070",
													SkyboxRt = "http://www.roblox.com/asset/?id=321846207",
													SkyboxLf = "http://www.roblox.com/asset/?id=321846162",
													SkyboxFt = "http://www.roblox.com/asset/?id=321845951",
													SkyboxBk = "http://www.roblox.com/asset/?id=321846018",
													SkyboxDn = "http://www.roblox.com/asset/?id=321846104",
												},
												["Night V2"] = {
													SkyboxUp = "http://www.roblox.com/Asset/?ID=12064131",
													SkyboxRt = "http://www.roblox.com/Asset/?ID=12064115",
													SkyboxLf = "http://www.roblox.com/Asset/?ID=12063984",
													SkyboxFt = "http://www.roblox.com/Asset/?ID=12064121",
													SkyboxBk = "http://www.roblox.com/Asset/?ID=12064107",
													SkyboxDn = "http://www.roblox.com/Asset/?ID=12064152",
												},
												Dark = {
													SkyboxUp = "rbxassetid://15470160563",
													SkyboxRt = "rbxassetid://15470158022",
													SkyboxLf = "rbxassetid://15470155938",
													SkyboxFt = "rbxassetid://15470153860",
													SkyboxBk = "rbxassetid://15470149279",
													SkyboxDn = "rbxassetid://15470151245",
												},
												Anime = {
													SkyboxUp = "http://www.roblox.com/asset/?id=104038404823203",
													SkyboxRt = "http://www.roblox.com/asset/?id=99961685452126",
													SkyboxLf = "http://www.roblox.com/asset/?id=84924000207295",
													SkyboxFt = "http://www.roblox.com/asset/?id=95687237979398",
													SkyboxBk = "http://www.roblox.com/asset/?id=81858382098344",
													SkyboxDn = "http://www.roblox.com/asset/?id=138472117789684",
												},
												Beach = {
													SkyboxUp = "http://www.roblox.com/asset/?id=151165227",
													SkyboxRt = "http://www.roblox.com/asset/?id=151165206",
													SkyboxLf = "http://www.roblox.com/asset/?id=151165191",
													SkyboxFt = "http://www.roblox.com/asset/?id=151165224",
													SkyboxBk = "http://www.roblox.com/asset/?id=151165214",
													SkyboxDn = "http://www.roblox.com/asset/?id=151165197",
												},
												Pink = {
													SkyboxUp = "rbxassetid://12635316856",
													SkyboxRt = "rbxassetid://12635315817",
													SkyboxLf = "rbxassetid://12635313718",
													SkyboxFt = "rbxassetid://12635312870",
													SkyboxBk = "rbxassetid://12635309703",
													SkyboxDn = "rbxassetid://12635311686",
												},
												Rainbow = {
													SkyboxUp = "rbxassetid://12877083856",
													SkyboxRt = "rbxassetid://12877085497",
													SkyboxLf = "rbxassetid://12877085497",
													SkyboxFt = "rbxassetid://12877085497",
													SkyboxBk = "rbxassetid://12877085497",
													SkyboxDn = "rbxassetid://12877086914",
												},
												Lucid = {
													SkyboxUp = "rbxassetid://8508112781",
													SkyboxRt = "rbxassetid://8508111092",
													SkyboxLf = "rbxassetid://8508107681",
													SkyboxFt = "rbxassetid://8508104949",
													SkyboxBk = "rbxassetid://8508098796",
													SkyboxDn = "rbxassetid://8508103588",
												},
												Nebulous = {
													SkyboxUp = "rbxassetid://131036626982613",
													SkyboxRt = "rbxassetid://103716549795832",
													SkyboxLf = "rbxassetid://126542804346203",
													SkyboxFt = "rbxassetid://107665368823185",
													SkyboxBk = "rbxassetid://95020137072033",
													SkyboxDn = "rbxassetid://92862258103959",
												},
											}

											local function fn30()
												local tbl24 = {}

												for k in pairs(tbl23) do
													table.insert(tbl24, k)
												end

												table.sort(tbl24)
												return tbl24
											end

											Misc:create_module({
												title = "Custom Sky",
												flag = "Custom_Sky",
												description = "Toggles a custom skybox",
												section = "right",
												callback = function(arg)
													flag21 = arg
													local sky = Lighting:FindFirstChildOfClass("Sky")

													if arg then
														if not sky then
															Instance.new("Sky").Parent = Lighting
														end
													else
														if sky then
															sky:Destroy()
														end

														if clone then
															clone:Clone().Parent = Lighting
														end

														Lighting.GlobalShadows = true
													end
												end,
											}):create_dropdown({
												title = "Select Sky",
												flag = "custom_sky_selector",
												multi_dropdown = false,
												maximum_options = 10,
												options = fn30(),
												callback = function(arg)
													if not flag21 then
														return
													end

													if true then -- recovered opaque guard
														local sky = Lighting:FindFirstChildOfClass("Sky")
														if not sky then
															return
														end
														local v90 = tbl23[arg]
														if not v90 then
															return
														end

														for k, v91 in pairs(v90) do
															sky[k] = v91
														end

														Lighting.GlobalShadows = false
														return
													end

													error("Unreachable obfuscation trap")
												end,
											})
										end
									end

									do
										Misc:create_module({
											title = "Skin Changer",
											flag = "Visuals",
											description = "Change your sword to anysword u want",
											section = "left",
											callback = function(enabled)
												getgenv().ENABLED = enabled
												getgenv().skinChanger = enabled

												if enabled then
													task.spawn(function()
														if getgenv().ApplySword then
															getgenv().ApplySword()
														end
													end)
												else
													task.spawn(function()
														if true then -- recovered opaque guard
															if getgenv().RestoreSword then
																getgenv().RestoreSword()
															end
														else
															error("Unreachable obfuscation trap")
														end
													end)
												end
											end,
										}):create_textbox({
											title = "￬ Sword Name ￬",
											placeholder = "Enter sword name...",
											flag = "Sword_Name",
											section = "left",
											callback = function(arg)
												getgenv().SWORD_NAME = tostring(arg or ""):match("^%s*(.-)%s*$") or ""
												getgenv().SLASH_NAME = getgenv().GetSlashNameSafe(getgenv().SWORD_NAME)

												task.spawn(function()
													if getgenv().ApplySword then
														getgenv().ApplySword()
													end
												end)
											end,
										})

										Detection:create_module({
											title = "Infinity Detection",
											flag = "detect_infinity",
											description = "Smart Infinity detection",
											section = "right",
											callback = function(infinity)
												System.__config.__detections.infinity = infinity
											end,
										})

										Detection:create_module({
											title = "Death Slash Detection",
											flag = "detect_deathslash",
											description = "Smart Death Slash detection",
											section = "right",
											callback = function(deathslash)
												System.__config.__detections.deathslash = deathslash
											end,
										})

										Detection:create_module({
											title = "Force Field Detection",
											flag = "detect_forcefield",
											description = "Smart Force Field detection",
											section = "left",
											callback = function(forcefield)
												System.__config.__detections.forcefield = forcefield
											end,
										})

										Detection:create_module({
											title = "Time Hole Detection",
											flag = "detect_timehole",
											description = "Smart Time Hole detection",
											section = "left",
											callback = function(timehole)
												System.__config.__detections.timehole = timehole
											end,
										})

										Detection:create_module({
											title = "Phantom Detection",
											flag = "detect_phantom",
											description = "Smart Time Hole detection",
											section = "left",
											callback = function(phantom)
												System.__config.__detections.phantom = phantom
											end,
										}):create_dropdown({
											title = "Mode",
											flag = "Phatom_Mode",
											options = { "Ability", "Accuracy" },
											default = "Accuracy",
											multi_dropdown = false,
											maximum_options = 2,
											callback = function(phantomDetection)
												getgenv().PhantomDetection = phantomDetection
											end,
										})

										do
											local v90 = Detection:create_module({
												title = "Slashes Of Fury Detection",
												flag = "detect_slashes",
												description = "Smart Slashes Of Fury detection",
												section = "left",
												callback = function(slashOfFuryDetection)
													getgenv().SlashOfFuryDetection = slashOfFuryDetection
												end,
											})

											v90:create_slider({
												title = "Max Parries",
												flag = "Slashes_Parries",
												section = "left",
												minimum_value = 1,
												maximum_value = 35,
												value = 1,
												round_number = true,
												callback = function(sofParries)
													getgenv().sof_Parries = sofParries
												end,
											})

											v90:create_slider({
												title = "Delay",
												flag = "Slashes_Delay",
												section = "left",
												minimum_value = 0.05,
												maximum_value = 0.35,
												value = 0.12,
												callback = function(sofDelay)
													if true then -- recovered opaque guard
														getgenv().sof_Delay = sofDelay
														return
													end

													error("Unreachable obfuscation trap")
												end,
											})
										end
									end

									getgenv().Dribble = false
									getgenv().Dribble_Chance = 100

									do
										local n = 0

										workspace.Alive.DescendantAdded:Connect(function(descendant)
											if descendant.Name == "DRIBBLE_IMMUNITY" then
												if localPlayer.Character and descendant.Parent == localPlayer.Character then
													return
												end
												n = tick()
											end
										end)

										local function fn30(character)
											character.DescendantAdded:Connect(function(descendant)
												if descendant.Name == "FAKE_HIGHLIGHT" then
													if getgenv().Dribble and tick() - n <= 1 and math.random(1, 100) <= getgenv().Dribble_Chance then
														tbl21.Play_Animation()
														ExecuteParry(SelectedParryType)
													end
												end
											end)
										end

										if localPlayer.Character then
											fn30(localPlayer.Character)
										end

										localPlayer.CharacterAdded:Connect(fn30)
									end
								end
							end

							do
								Detection:create_module({
									title = "Dribble Detection",
									flag = "dribble_detection",
									description = "Parry when someone dribble you",
									section = "left",
									callback = function(dribble)
										getgenv().Dribble = dribble
									end,
								}):create_slider({
									title = "Dribble Chance",
									flag = "dribble_chance",
									minimum_value = 0,
									maximum_value = 100,
									value = 100,
									round_number = true,
									callback = function(dribbleChance)
										getgenv().Dribble_Chance = dribbleChance
									end,
								})

								v89:create_checkbox({
									title = "Notify",
									flag = "Autoparry",
									callback = function(autoParryNotify)
										getgenv().AutoParryNotify = autoParryNotify
									end,
								})

								v89:create_checkbox({
									title = "Auto Ability",
									flag = "AutoAbility",
									callback = function(autoAbility)
										if true then -- recovered opaque guard
											getgenv().AutoAbility = autoAbility
											return
										end

										error("Unreachable obfuscation trap")
									end,
								})

								workspace.Balls.ChildRemoved:Connect(function()
									n33 = 0
									flag19 = false

									if tbl20["Target Change"] then
										tbl20["Target Change"]:Disconnect()
										tbl20["Target Change"] = nil
									end
								end)

								getgenv().AutoPreClick = false

								do
									local v90 = nil
									local tbl23 = {}
									local tbl24 = {}

									local function fn30()
										if not getgenv().AutoPreClick then
											return
										end
										local v91 = tbl21.Get_Ball()
										if not v91 then
											return
										end
										local zoomies = v91:FindFirstChild("zoomies")
										if not zoomies then
											return
										end
										local magnitude = zoomies.VectorVelocity.Magnitude
										local attribute = v91:GetAttribute("target")

										if not tbl23[v91] then
											if false then -- removed opaque flag guard
												return
											end

											if true then -- recovered opaque guard
												tbl23[v91] = {}

												if false then -- recovered opaque guard
													error("Unreachable obfuscation trap")
												end
											else
												error("Unreachable obfuscation trap")
											end
										end

										table.insert(tbl23[v91], magnitude)

										if #tbl23[v91] > 15 then
											table.remove(tbl23[v91], 1)
										end

										if attribute and attribute ~= "" and attribute ~= tostring(localPlayer) then
											v90 = attribute
											if false then -- removed opaque flag guard
												return
											end
										end
									end

									workspace.Alive.ChildRemoved:Connect(function(child)
										if getgenv().AutoPreClick then
											if not v90 then
												return
											end

											if child.Name ~= v90 then
												return
											end

											if tbl24[child.Name] then
												return
											end
											local flag21 = false

											for _, v91 in pairs(tbl23) do
												for _, v92 in ipairs(v91) do
													if v92 >= 600 then
														flag21 = true
														break
													end
												end

												if not flag21 then
													continue
												end
												break
											end

											if flag21 then
												tbl24[child.Name] = true

												task.delay(math.random(120, 140) / 1000, function()
													local alive2 = workspace.Alive
													if not alive2 then
														tbl24[child.Name] = nil
														return
													end

													if not alive2:FindFirstChild(localPlayer.Name) then
														tbl24[child.Name] = nil
														return
													end
													local v91 = tbl21.Get_Ball()
													if not v91 then
														return
													end
													local name = localPlayer.Name
													if v91:GetAttribute("target") == name then
														tbl24[child.Name] = nil
														return
													end
													tbl21.Play_Animation()
													ExecuteParry(SelectedParryType)
													tbl24[child.Name] = nil
												end)

												v90 = nil
												tbl23 = {}
											end

											return
										end

										if true then -- recovered opaque guard
											return
										end

										error("Unreachable obfuscation trap")
									end)

									v85.Heartbeat:Connect(function()
										fn30()
									end)
								end
							end

							v89:create_checkbox({
								title = "Auto Pre Click",
								flag = "AutoPreClick",
								description = "Pre-clicks after a sing elimination",
								callback = function(autoPreClick)
									getgenv().AutoPreClick = autoPreClick
									if false then -- removed opaque flag guard
										return
									end
								end,
							})

							getgenv().GriefPreClickEnabled = false
							getgenv().GriefPreClickMode = "Keybind"
							getgenv().GriefPreClickTarget = nil
							getgenv().GriefPreClickChance = 40

							do
								local v90 = 25
								getgenv().GriefPreClickProxRange = v90
							end
						end

						local RunService, Players

						do
							do
								do
									local tbl23, fn30, fn31

									do
										getgenv().GriefPreClickBallRange = 22
										getgenv().GriefPreClickRequireNear = true
										tbl23 = {}

										fn30 = function()
											if not getgenv().GriefPreClickEnabled then
												return
											end

											if getgenv().GriefPreClickMode ~= "Keybind" then
												return
											end
											local v90 = tbl21.select_target_by_mouse() or tbl21.Closest_Aim() or tbl21.Closest_Player()

											if v90 then
												local name = v90.Name
												getgenv().GriefPreClickTarget = name
												index.SendNotification({ title = "Grief Target", text = v90.Name, duration = 2, icon = "rbxassetid://128616761621643" })
											end
										end

										do
											local function fn32()
												local character = localPlayer.Character
												if not character or not character.PrimaryPart then
													return nil
												end

												if getgenv().GriefPreClickMode == "Near" then
													local position = character.PrimaryPart.Position
													local griefPreClickProxRange = getgenv().GriefPreClickProxRange or 25
													local name = nil

													for _, v90 in alive:GetChildren() do
														if v90 ~= character and v90.PrimaryPart then
															local magnitude = (v90.PrimaryPart.Position - position).Magnitude

															if magnitude <= griefPreClickProxRange then
																name = v90.Name
																griefPreClickProxRange = magnitude
															end
														end
													end

													return name
												end

												local griefPreClickTarget = getgenv().GriefPreClickTarget
												if not griefPreClickTarget or griefPreClickTarget == "" then
													return nil
												end

												if getgenv().GriefPreClickRequireNear then
													local v90 = alive:FindFirstChild(griefPreClickTarget)
													if not v90 or not v90.PrimaryPart then
														return nil
													end
													local magnitude = (v90.PrimaryPart.Position - character.PrimaryPart.Position).Magnitude
													if (getgenv().GriefPreClickProxRange or 25) < magnitude then
														return nil
													end
												end

												return griefPreClickTarget
											end

											local function fn33(arg, arg2)
												if not arg or not arg2 then
													return false
												end
												local attribute = arg:GetAttribute("target")
												if not attribute or attribute == "" then
													return false
												end

												if attribute ~= arg2 then
													return false
												end

												if attribute == localPlayer.Name then
													return false
												end
												local character = localPlayer.Character
												if not character or not character.PrimaryPart then
													return false
												end

												if character.Parent ~= alive then
													return false
												end

												if character.PrimaryPart:FindFirstChild("SingularityCape") then
													return false
												end
												local v90 = alive:FindFirstChild(arg2)
												if not v90 or not v90.PrimaryPart then
													return false
												end
												local v91 = tbl21.Ball_Position(arg)
												if not v91 then
													return false
												end
												local magnitude = (v91 - v90.PrimaryPart.Position).Magnitude
												if (getgenv().GriefPreClickBallRange or 22) < magnitude then
													return false
												end
												local n = math.clamp(getgenv().GriefPreClickChance or 40, 0, 100)
												if n <= 0 then
													return false
												end

												if n >= 100 then
													return true
												end
												return math.random(1, 100) <= n
											end

											local function fn34(arg, arg2)
												local str7 = tostring(arg) .. "_" .. arg2
												if tbl23[str7] then
													return
												end

												if not fn33(arg, arg2) then
													return
												end
												tbl23[str7] = true
												tbl21.Play_Animation()
												ExecuteParry(SelectedParryType)

												arg:GetAttributeChangedSignal("target"):Once(function()
													if true then -- recovered opaque guard
														tbl23[str7] = nil
														return
													end

													error("Unreachable obfuscation trap")
												end)

												task.delay(0.85, function()
													tbl23[str7] = nil
												end)
											end

											fn31 = function()
												if tbl20.GriefPreClick then
													return
												end

												tbl20.GriefPreClick = v85.PreSimulation:Connect(function()
													if not getgenv().GriefPreClickEnabled then
														return
													end
													local v90 = fn32()
													if not v90 then
														return
													end
													local v91 = tbl21.Get_Ball()
													if not v91 then
														return
													end
													fn34(v91, v90)
												end)
											end
										end
									end

									do
										do
											local function fn32()
												if tbl20.GriefPreClick then
													tbl20.GriefPreClick:Disconnect()
													tbl20.GriefPreClick = nil
												end

												table.clear(tbl23)
											end

											local v90 = Combat:create_module({
												title = "Grief Pre Click",
												flag = "GriefPreClick",
												description = "Legit pre-clicks when ball nears your target",
												section = "left",
												callback = function(griefPreClickEnabled)
													getgenv().GriefPreClickEnabled = griefPreClickEnabled

													if griefPreClickEnabled then
														fn31()
													else
														fn32()
													end
												end,
											})

											v90:create_dropdown({
												title = "Target Mode",
												flag = "GriefPreClickMode",
												options = { "Keybind", "Near" },
												default = "Keybind",
												multi_dropdown = false,
												maximum_options = 2,
												callback = function(griefPreClickMode)
													getgenv().GriefPreClickMode = griefPreClickMode
												end,
											})

											tbl19.GriefPreClickSelectKey = v88.InputBegan:Connect(function(input, gameProcessed)
												if false then -- removed opaque flag guard
													return
												end

												if gameProcessed then
													return
												end

												if input.UserInputType ~= Enum.UserInputType.Keyboard then
													return
												end

												if input.KeyCode ~= Enum.KeyCode.T then
													return
												end
												fn30()
											end)

											v90:create_slider({
												title = "Pre Click Chance %",
												flag = "GriefPreClickChance",
												minimum_value = 0,
												maximum_value = 100,
												value = 40,
												round_number = true,
												callback = function(griefPreClickChance)
													getgenv().GriefPreClickChance = griefPreClickChance
												end,
											})

											v90:create_slider({
												title = "Follow Range",
												flag = "GriefPreClickProxRange",
												minimum_value = 10,
												maximum_value = 80,
												value = 25,
												round_number = true,
												callback = function(griefPreClickProxRange)
													getgenv().GriefPreClickProxRange = griefPreClickProxRange
												end,
											})

											v90:create_slider({
												title = "Ball Trigger Range",
												flag = "GriefPreClickBallRange",
												minimum_value = 8,
												maximum_value = 50,
												value = 22,
												round_number = true,
												callback = function(griefPreClickBallRange)
													getgenv().GriefPreClickBallRange = griefPreClickBallRange
												end,
											})
										end
									end
								end

								local v90 = false
								getgenv().BallTrailEnabled = v90
							end

							do
								local localPlayer3, str7, flag21, fn30

								do
									getgenv().TrailRainbow = true
									getgenv().TrailHue = 0
									RunService = game:GetService("RunService")

									if not flag20 then
										Misc:create_module({
											title = "GUI Library Visible",
											description = "visibility of the GUI",
											flag = "guilibraryvisible",
											section = "left",
											callback = function(guilibraryVisible)
												getgenv().guilibraryVisible = guilibraryVisible
											end,
										})
									end

									task.spawn(function()
										local ReplicatedStorage = game:GetService("ReplicatedStorage")
										local RunService2 = game:GetService("RunService")
										local Players2 = game:GetService("Players")
										local UserInputService = game:GetService("UserInputService")
										local TweenService = game:GetService("TweenService")
										local localPlayer4 = Players2.LocalPlayer
										local v90 = localPlayer4:WaitForChild("PlayerGui")
										local EmotesShared = nil
										local Trove = nil

										pcall(function()
											EmotesShared = require(ReplicatedStorage.Shared.EmotesShared)
											Trove = require(ReplicatedStorage.Packages.Trove)
										end)

										local tbl23

										tbl23 = {
											storage = {},
											current = nil,
											trove = nil,
											load_animations = function()
												if true then -- recovered opaque guard
													for _, child in pairs(ReplicatedStorage.Misc.Emotes:GetChildren()) do
														if child:IsA("Animation") and child:GetAttribute("EmoteName") then
															tbl23.storage[child:GetAttribute("EmoteName")] = child
														end
													end

													return
												end

												error("Unreachable obfuscation trap")
											end,
											get_emotes_list = function()
												local tbl24 = {}

												for k in pairs(tbl23.storage) do
													table.insert(tbl24, k)
												end

												table.sort(tbl24)
												return tbl24
											end,
											play = function(current)
												local v91 = tbl23.storage[current]
												if not v91 or not localPlayer4.Character then
													return false
												end
												tbl23.stop()
												task.wait()
												local v92 = Trove.new()
												tbl23.trove = v92
												tbl23.current = current

												task.spawn(function()
													if tbl23.trove ~= v92 then
														return
													end

													pcall(function()
														EmotesShared:Play(localPlayer4.Character, v92, v91.Name, true, workspace:GetServerTimeNow())
													end)
												end)

												return true
											end,
											stop = function()
												if tbl23.trove then
													pcall(function()
														tbl23.trove:Destroy()
													end)

													tbl23.trove = nil
												end

												tbl23.current = nil
											end,
											start = function()
												if true then -- recovered opaque guard
													if not System.__properties.__connections.animations then
														System.__properties.__connections.animations = RunService2.Heartbeat:Connect(function()
															if not localPlayer4.Character or not localPlayer4.Character.PrimaryPart then
																return
															end

															if localPlayer4.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude > 30 and tbl23.current then
																tbl23.stop()
															end
														end)
													end

													return
												end

												error("Unreachable obfuscation trap")
											end,
											cleanup = function()
												if false then -- recovered opaque guard
													error("Unreachable obfuscation trap")
												end

												tbl23.stop()

												if System.__properties.__connections.animations then
													System.__properties.__connections.animations:Disconnect()
													System.__properties.__connections.animations = nil
												end
											end,
										}

										tbl23.load_animations()
										local v91 = tbl23.get_emotes_list()
										local v92 = v91[1]
										local tbl24 = {}
										local screenGui = Instance.new("ScreenGui")
										screenGui.Name = "EmotesPanel"
										screenGui.ResetOnSpawn = false
										screenGui.Enabled = false
										screenGui.Parent = v90
										local frame = Instance.new("Frame")
										frame.Size = UDim2.new(0, 270, 0, 320)
										frame.Position = UDim2.new(1, -290, 0.5, -160)
										frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
										frame.BorderSizePixel = 0
										frame.Parent = screenGui
										Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
										local textLabel = Instance.new("TextLabel")
										textLabel.Text = "EMOTES"
										textLabel.Font = Enum.Font.GothamBold
										textLabel.TextSize = 18
										textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
										textLabel.BackgroundTransparency = 1
										textLabel.Size = UDim2.new(1, 0, 0, 40)
										textLabel.Parent = frame
										local frame2 = Instance.new("Frame")
										frame2.Size = UDim2.new(1, 0, 1, -40)
										frame2.Position = UDim2.new(0, 0, 0, 40)
										frame2.BackgroundTransparency = 1
										frame2.Parent = frame
										local instance = Instance.new("UIPadding")
										instance.PaddingLeft = UDim.new(0, 14)
										instance.PaddingRight = UDim.new(0, 14)
										instance.PaddingTop = UDim.new(0, 12)
										instance.PaddingBottom = UDim.new(0, 11)
										instance.Parent = frame2
										local instance2 = Instance.new("UIListLayout")
										instance2.Padding = UDim.new(0, 10)
										instance2.Parent = frame2
										instance2.SortOrder = Enum.SortOrder.LayoutOrder

										local function fn31(arg, arg2, arg3)
											arg.MouseEnter:Connect(function()
												local tbl25 = { BackgroundColor3 = arg3 }
												TweenService:Create(arg, TweenInfo.new(0.15), tbl25):Play()
											end)

											arg.MouseLeave:Connect(function()
												local tbl25 = { BackgroundColor3 = arg2 }
												TweenService:Create(arg, TweenInfo.new(0.15), tbl25):Play()
											end)
										end

										for i = 1, 5 do
											tbl24[i] = { emote = nil, key = nil }
											local frame3 = Instance.new("Frame")
											frame3.Size = UDim2.new(1, 0, 0, 44)
											frame3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
											frame3.Parent = frame2
											Instance.new("UICorner", frame3).CornerRadius = UDim.new(0, 8)
											local uiListLayout = Instance.new("UIListLayout")
											uiListLayout.FillDirection = Enum.FillDirection.Horizontal
											uiListLayout.Padding = UDim.new(0, 6)
											uiListLayout.Parent = frame3
											uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
											uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
											local instance3 = Instance.new("UIPadding")
											instance3.PaddingLeft = UDim.new(0, 8)
											instance3.PaddingRight = UDim.new(0, 8)
											instance3.Parent = frame3
											local instance4 = Instance.new("TextLabel")
											instance4.Text = "Slot " .. i
											instance4.Font = Enum.Font.Gotham
											instance4.TextSize = 13
											instance4.TextColor3 = Color3.fromRGB(120, 120, 220)
											instance4.BackgroundTransparency = 1
											instance4.Size = UDim2.new(0, 50, 1, 0)
											instance4.Parent = frame3
											local textButton = Instance.new("TextButton")
											textButton.Size = UDim2.new(1, -120, 1, -12)
											textButton.Text = "Select"
											textButton.Font = Enum.Font.Gotham
											textButton.TextSize = 14
											textButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
											textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
											textButton.Parent = frame3
											textButton.AutoButtonColor = false
											Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
											local instance5 = Instance.new("TextButton")
											instance5.Size = UDim2.new(0, 40, 1, -14)
											instance5.Text = "Key"
											instance5.Font = Enum.Font.GothamBold
											instance5.TextSize = 11
											instance5.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
											instance5.TextColor3 = Color3.fromRGB(255, 255, 255)
											instance5.Parent = frame3
											instance5.AutoButtonColor = false
											Instance.new("UICorner", instance5).CornerRadius = UDim.new(0, 6)
											local color = Color3.fromRGB
											local v93 = 70
											fn31(textButton, Color3.fromRGB(45, 45, 45), color(70, 70, v93))
											local color2 = Color3.fromRGB
											fn31(instance5, Color3.fromRGB(60, 60, 60), color2(85, 85, 85))

											textButton.MouseButton1Click:Connect(function()
												local v94 = v91[math.random(1, #v91)]
												tbl24[i].emote = v94
												textButton.Text = v94
											end)

											instance5.MouseButton1Click:Connect(function()
												instance5.Text = "..."
												local connection = nil

												connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
													if gameProcessed then
														return
													end
													tbl24[i].key = input.KeyCode
													instance5.Text = input.KeyCode.Name
													connection:Disconnect()
												end)
											end)
										end

										UserInputService.InputBegan:Connect(function(input, gameProcessed)
											if gameProcessed then
												return
											end

											for _, v93 in pairs(tbl24) do
												if v93.key and input.KeyCode == v93.key then
													if v93.emote then
														tbl23.play(v93.emote)
													end
												end
											end
										end)

										local v93 = Misc:create_module({
											title = "Emotes",
											flag = "Emotes",
											description = "Custom Emotes",
											section = "right",
											callback = function(animations)
												getgenv().Animations = animations

												if animations then
													tbl23.start()

													if v92 then
														tbl23.play(v92)
													end
												else
													tbl23.cleanup()
												end
											end,
										})

										v93:create_checkbox({
											title = "Emotes UI",
											flag = "EmotesUI",
											callback = function(enabled)
												screenGui.Enabled = enabled
											end,
										})

										v93:create_dropdown({
											title = "Emote Type",
											flag = "Selected_Animation",
											options = v91,
											multi_dropdown = false,
											maximum_options = 10,
											callback = function(arg)
												v92 = arg

												if getgenv().Animations then
													tbl23.play(arg)
												end
											end,
										}):update(v92)
									end)

									Players = game:GetService("Players")
									localPlayer3 = Players.LocalPlayer
									str7 = ""
									flag21 = false

									do
										local function fn31(arg)
											if true then -- recovered opaque guard
												local ok, result = pcall(function()
													return Players:GetUserIdFromNameAsync(arg)
												end)

												return ok and result or nil
											end

											error("Unreachable obfuscation trap")
										end

										fn30 = function(lastMorphNameOrId)
											if not lastMorphNameOrId or lastMorphNameOrId == "" then
												return
											end
											local character = localPlayer3.Character
											if not character then
												return
											end
											local humanoid = character:FindFirstChildOfClass("Humanoid")
											local head = character:FindFirstChild("Head")
											if not humanoid or not head then
												return
											end
											local num

											if tonumber(lastMorphNameOrId) then
												num = tonumber(lastMorphNameOrId)
											else
												num = fn31(lastMorphNameOrId)
											end

											if not num then
												return
											end

											local ok, result = pcall(function()
												return Players:CreateHumanoidModelFromUserId(num)
											end)

											if ok and result then
												local head2 = result:FindFirstChild("Head")
												local humanoid2 = result:FindFirstChildOfClass("Humanoid")

												if head2 then
													local decal = head:FindFirstChildOfClass("Decal")
													local decal2 = head2:FindFirstChildOfClass("Decal")

													if decal2 then
														if not decal then
															decal = Instance.new("Decal")
															decal.Name = "face"
															decal.Parent = head
														end

														decal.Texture = decal2.Texture
													elseif decal then
														decal:Destroy()
													end

													local specialMesh = head:FindFirstChildOfClass("SpecialMesh")
													local specialMesh2 = head2:FindFirstChildOfClass("SpecialMesh")

													if specialMesh2 then
														if not specialMesh then
															specialMesh = Instance.new("SpecialMesh")
															specialMesh.Parent = head
														end

														specialMesh.MeshId = specialMesh2.MeshId
														specialMesh.TextureId = specialMesh2.TextureId
														specialMesh.Scale = specialMesh2.Scale
													end
												end

												for _, child in ipairs(character:GetChildren()) do
													if child:IsA("Accessory") or child:IsA("Clothing") or child:IsA("ShirtGraphic") or child:IsA("BodyColors") or child:IsA("CharacterMesh") then
														child:Destroy()
													end
												end

												local bodyColors = result:FindFirstChildOfClass("BodyColors")

												if bodyColors then
													bodyColors:Clone().Parent = character
												end

												if humanoid.RigType == Enum.HumanoidRigType.R15 and humanoid2 then
													for _, v90 in ipairs({ "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale", "ProportionScale" }) do
														local v91 = humanoid2:FindFirstChild(v90)
														local v92 = humanoid:FindFirstChild(v90)

														if v91 and v92 then
															v92.Value = v91.Value
														end
													end
												end

												if humanoid.RigType == Enum.HumanoidRigType.R6 then
													for _, child in ipairs(result:GetChildren()) do
														if child:IsA("CharacterMesh") then
															child:Clone().Parent = character
														end
													end
												else
													for _, child in ipairs(result:GetChildren()) do
														if child:IsA("MeshPart") then
															local v90 = character:FindFirstChild(child.Name)

															if v90 and v90:IsA("MeshPart") then
																v90.MeshId = child.MeshId
																v90.TextureID = child.TextureID
															end
														end
													end
												end

												for _, child in ipairs(result:GetChildren()) do
													if child:IsA("Accessory") then
														local clone = child:Clone()
														clone.Parent = character
														local handle = clone:FindFirstChild("Handle")

														if handle and handle:IsA("BasePart") then
															handle.CanCollide = false

															if not handle:FindFirstChildOfClass("WrapLayer") then
																local attachment = handle:FindFirstChildOfClass("Attachment")
																local v90 = nil

																if attachment then
																	v90 = nil

																	for _, child2 in ipairs(character:GetChildren()) do
																		if child2:IsA("BasePart") and child2:FindFirstChild(attachment.Name) then
																			v90 = child2:FindFirstChild(attachment.Name)
																			break
																		else
																			v90 = nil
																		end
																	end
																end

																if v90 then
																	handle.CFrame = v90.WorldCFrame * attachment.CFrame:Inverse()
																	local weldConstraint = Instance.new("WeldConstraint")
																	weldConstraint.Part0 = handle
																	weldConstraint.Part1 = v90.Parent
																	weldConstraint.Parent = handle
																else
																	local torso = head or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")

																	if torso then
																		handle.CFrame = torso.CFrame
																		local weldConstraint = Instance.new("WeldConstraint")
																		weldConstraint.Part0 = handle
																		weldConstraint.Part1 = torso
																		weldConstraint.Parent = handle
																	end
																end
															end
														end
													elseif child:IsA("Clothing") or child:IsA("ShirtGraphic") then
														child:Clone().Parent = character
													end
												end

												result:Destroy()
												getgenv().lastMorphNameOrId = lastMorphNameOrId

												if getgenv().ENABLED and getgenv().ApplySword then
													task.delay(0.4, function()
														if true then -- recovered opaque guard
															if getgenv().ENABLED and getgenv().ApplySword then
																getgenv().ApplySword()
															end

															return
														end

														error("Unreachable obfuscation trap")
													end)
												elseif getgenv().skinChanger and getgenv().updateSword then
													task.delay(0.5, function()
														getgenv().updateSword()
													end)
												end
											end
										end
									end
								end

								local v90 = Misc:create_module({
									title = "Avatar Changer",
									description = "Avatar Changer",
									flag = "avatarChanger",
									section = "left",
									callback = function(arg)
										flag21 = arg

										if tbl20["Avatar Changer"] then
											tbl20["Avatar Changer"]:Disconnect()
											tbl20["Avatar Changer"] = nil
										end

										if arg then
											if str7 ~= "" then
												fn30(str7)
											end

											tbl20["Avatar Changer"] = localPlayer3.CharacterAdded:Connect(function(character)
												task.spawn(function()
													if not character:WaitForChild("Humanoid", 8) then
														return
													end

													if not character:WaitForChild("Head", 8) then
														return
													end
													local now2 = os.clock()

													while character.Parent and not character:IsDescendantOf(workspace) and os.clock() - now2 < 5 do
														task.wait()
													end

													local now3 = os.clock()

													while localPlayer.Character == character and not character:GetAttribute("AppearanceLoaded") and os.clock() - now3 < 3 do
														task.wait(0.05)
													end

													task.wait(0.3)
													if not flag21 or str7 == "" or localPlayer3.Character ~= character then
														return
													end
													fn30(str7)
													task.wait(0.45)

													if getgenv().ENABLED and getgenv().ApplySword and localPlayer3.Character == character then
														getgenv().ApplySword()
													end
												end)

												if false then -- removed opaque flag guard
													return
												end
											end)
										end

										if false then -- removed opaque flag guard
											return
										end
									end,
								})

								_G.PlayerCosmeticsCleanup = {}

								v90:create_checkbox({
									title = "Player Cosmetics",
									flag = "Player_Cosmetics",
									description = "Apply headless and korblox",
									section = "left",
									callback = function(arg)
										local localPlayer4 = game:GetService("Players").LocalPlayer

										local function fn31(arg2)
											if arg2 then
												_G.PlayerCosmeticsCleanup.hairs = {}

												for _, child in pairs(arg2:GetChildren()) do
													if child:IsA("Accessory") then
														if child:FindFirstChild("Handle") then
															table.insert(_G.PlayerCosmeticsCleanup.hairs, child:Clone())
															child:Destroy()
														end
													end
												end

												return
											end

											if true then -- recovered opaque guard
												return
											end

											error("Unreachable obfuscation trap")
										end

										local function fn32(arg2)
											if not arg2 then
												return
											end
											local rightLeg = arg2:FindFirstChild("RightLeg") or arg2:FindFirstChild("Right Leg") or arg2:FindFirstChild("RightLowerLeg")
											if not rightLeg then
												warn("Right leg not found (R6/R15 mismatch)")
												return
											end

											for _, child in pairs(rightLeg:GetChildren()) do
												if child:IsA("SpecialMesh") then
													child:Destroy()
												end
											end

											local specialMesh = Instance.new("SpecialMesh")
											specialMesh.MeshId = "rbxassetid://101851696"
											specialMesh.TextureId = "rbxassetid://115727863"
											specialMesh.Scale = Vector3.new(1, 1, 1)
											specialMesh.Parent = rightLeg
										end

										local function fn33(arg2)
											if arg2 then
												local rightLeg = arg2:FindFirstChild("RightLeg") or arg2:FindFirstChild("Right Leg")

												if rightLeg then
													local specialMesh = rightLeg:FindFirstChildOfClass("SpecialMesh")

													if specialMesh then
														_G.PlayerCosmeticsCleanup.originalMeshId = specialMesh.MeshId
														_G.PlayerCosmeticsCleanup.originalTextureId = specialMesh.TextureId
														_G.PlayerCosmeticsCleanup.originalScale = specialMesh.Scale
													else
														_G.PlayerCosmeticsCleanup.hadNoMesh = true
													end

													_G.PlayerCosmeticsCleanup.rightLegChildren = {}

													for _, child in pairs(rightLeg:GetChildren()) do
														if child:IsA("SpecialMesh") then
															table.insert(_G.PlayerCosmeticsCleanup.rightLegChildren, {
																ClassName = child.ClassName,
																Properties = { MeshId = child.MeshId, TextureId = child.TextureId, Scale = child.Scale },
															})
														end
													end
												end
											end
										end

										local function fn34(parent)
											if not parent then
												return
											end

											if _G.PlayerCosmeticsCleanup.hairs then
												for _, hair in pairs(_G.PlayerCosmeticsCleanup.hairs) do
													hair.Parent = parent
												end

												return
											end

											if true then -- recovered opaque guard
												return
											end

											error("Unreachable obfuscation trap")
										end

										local function fn35(arg2)
											if arg2 then
												local rightLeg = arg2:FindFirstChild("RightLeg") or arg2:FindFirstChild("Right Leg")

												if rightLeg and _G.PlayerCosmeticsCleanup.rightLegChildren then
													for _, child in pairs(rightLeg:GetChildren()) do
														if child:IsA("SpecialMesh") then
															child:Destroy()
														end
													end

													if _G.PlayerCosmeticsCleanup.hadNoMesh then
														return
													end

													for _, v91 in ipairs(_G.PlayerCosmeticsCleanup.rightLegChildren) do
														if v91.ClassName == "SpecialMesh" then
															local specialMesh = Instance.new("SpecialMesh")
															specialMesh.MeshId = v91.Properties.MeshId
															specialMesh.TextureId = v91.Properties.TextureId
															specialMesh.Scale = v91.Properties.Scale
															specialMesh.Parent = rightLeg
														end
													end
												end
											end
										end

										if arg then
											CosmeticsActive = true
											getgenv().Config = { Headless = true }

											if localPlayer4.Character then
												local head = localPlayer4.Character:FindFirstChild("Head")

												if head and getgenv().Config.Headless then
													_G.PlayerCosmeticsCleanup.headTransparency = head.Transparency
													local decal = head:FindFirstChildOfClass("Decal")

													if decal then
														_G.PlayerCosmeticsCleanup.faceDecalId = decal.Texture
														_G.PlayerCosmeticsCleanup.faceDecalName = decal.Name
													end
												end

												fn33(localPlayer4.Character)
												fn32(localPlayer4.Character)
												fn31(localPlayer4.Character)
											end

											_G.PlayerCosmeticsCleanup.characterAddedConn = localPlayer4.CharacterAdded:Connect(function(character)
												local head = character:FindFirstChild("Head")

												if head and getgenv().Config.Headless then
													_G.PlayerCosmeticsCleanup.headTransparency = head.Transparency
													local decal = head:FindFirstChildOfClass("Decal")

													if decal then
														_G.PlayerCosmeticsCleanup.faceDecalId = decal.Texture
														_G.PlayerCosmeticsCleanup.faceDecalName = decal.Name
													end
												end

												fn33(character)
												fn32(character)
												fn31(character)
												if true then -- recovered opaque guard
													return
												end

												error("Unreachable obfuscation trap")
											end)

											if getgenv().Config.Headless then
												headLoop = task.spawn(function()
													while CosmeticsActive do
														local character = localPlayer4.Character

														if character then
															local head = character:FindFirstChild("Head")

															if head then
																head.Transparency = 1
																local decal = head:FindFirstChildOfClass("Decal")

																if decal then
																	decal:Destroy()
																end
															end
														end

														task.wait(0.1)
													end
												end)
											end
										else
											CosmeticsActive = false

											if _G.PlayerCosmeticsCleanup.characterAddedConn then
												_G.PlayerCosmeticsCleanup.characterAddedConn:Disconnect()
												_G.PlayerCosmeticsCleanup.characterAddedConn = nil
											end

											if headLoop then
												task.cancel(headLoop)
												headLoop = nil
											end

											local character = localPlayer4.Character

											if character then
												local head = character:FindFirstChild("Head")

												if head and _G.PlayerCosmeticsCleanup.headTransparency ~= nil then
													head.Transparency = _G.PlayerCosmeticsCleanup.headTransparency

													if _G.PlayerCosmeticsCleanup.faceDecalId then
														local decal = head:FindFirstChildOfClass("Decal") or Instance.new("Decal", head)
														decal.Name = _G.PlayerCosmeticsCleanup.faceDecalName or "face"
														decal.Texture = _G.PlayerCosmeticsCleanup.faceDecalId
														decal.Face = Enum.NormalId.Front
													end
												end

												fn35(character)
												fn34(character)
											end

											_G.PlayerCosmeticsCleanup = {}
										end
									end,
								})

								v90:create_textbox({
									title = "Avatar User",
									placeholder = "Username or UserID",
									flag = "avatarUser",
									section = "left",
									callback = function(arg)
										str7 = arg

										if flag21 and arg and arg ~= "" then
											fn30(arg)
										end
									end,
								})
							end

							do
								local v90 = nil
								local flag21 = false
								local v91 = nil

								for _, v92 in getgc(true) do
									if type(v92) ~= "table" then
										v91 = nil
									else
										local value = rawget(v92, "PlayExplosion")
										local value2 = rawget(v92, "PlayExplosionFromInstance")
										local value3 = rawget(v92, "UpdateEmissionMultiplier")
										local flag22 = type(value) == "function"

										if flag22 then
											local v93 = "function"
											flag22 = type(value2) == v93
										end

										if flag22 and type(value3) == "function" then
											v91 = v92
											break
										else
											v91 = nil
										end
									end
								end

								local playExplosion = v91.PlayExplosion

								v91.PlayExplosion = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
									if v90 and v90 ~= "" then
										if flag21 and arg7 and arg6 == localPlayer2.Character then
											arg2 = v90
										end
									end

									return playExplosion(arg, arg2, arg3, arg4, arg5, arg6, arg7)
								end

								Misc:create_module({
									title = "Explosion Changer",
									flag = "explosionChangerEnabled",
									description = "Change your explosion to anyexplosion u want",
									section = "left",
									callback = function(arg)
										flag21 = arg
									end,
								}):create_textbox({
									title = "￬ Explosion Name ￬",
									placeholder = "Enter Explosion Name...",
									flag = "Explosion_Name",
									section = "left",
									callback = function(arg)
										v90 = arg
									end,
								})
							end
						end

						do
							do
								do
									local connection = nil

									v89:create_checkbox({
										title = "Anti Double Jump",
										flag = "Anti_Double",
										description = "Stops ur Double Jump",
										section = "left",
										callback = function(arg)
											if connection then
												connection:Disconnect()
												connection = nil
											end

											local function fn30(character)
												local setAttribute = character.SetAttribute
												local v90 = arg
												local v91

												if arg then
													v91 = v90
												else
													v91 = nil
												end

												setAttribute(character, "JumpDB", v91)
											end

											if arg then
												if localPlayer2.Character then
													fn30(localPlayer2.Character)

													if false then -- recovered opaque guard
														error("Unreachable obfuscation trap")
													end
												end

												connection = localPlayer2.CharacterAdded:Connect(fn30)
											elseif localPlayer2.Character then
												fn30(localPlayer2.Character)
											end
										end,
									})
								end

								getgenv().AutoRematch = false

								do
									local flag21 = false
									local tbl23 = {}

									local function fn30(arg)
										local v90 = 0

										pcall(function()
											for _, v91 in getconnections(arg.Activated) do
												v91:Fire()
												v90 += 1
											end
										end)

										if v90 == 0 then
											pcall(firesignal, arg.Activated)
										end
									end

									local function fn31(arg)
										if not getgenv().AutoRematch then
											return
										end
										local buttons = arg:FindFirstChild("Buttons")
										buttons = buttons and buttons:FindFirstChild("RematchButton")
										if flag21 or not buttons or not buttons.Visible then
											return
										end

										if localPlayer:GetAttribute("Rematch") then
											return
										end
										flag21 = true
										fn30(buttons)
									end

									Misc:create_module({
										title = "Auto Rematch",
										flag = "Auto_Rematch",
										description = "Auto clicks rematch on win/lose",
										section = "right",
										callback = function(autoRematch)
											getgenv().AutoRematch = autoRematch

											if autoRematch then
												local duelUI = localPlayer:WaitForChild("PlayerGui"):WaitForChild("DuelUI")

												for _, v90 in { "WinScreen", "LoseScreen" }, nil, nil do
													local v91 = duelUI:WaitForChild(v90)

													tbl23[v90] = v91:GetPropertyChangedSignal("Visible"):Connect(function()
														if v91.Visible then
															fn31(v91)
														else
															flag21 = false
														end
													end)

													if v91.Visible then
														fn31(v91)
													end
												end
											else
												for k, v90 in pairs(tbl23) do
													v90:Disconnect()
													tbl23[k] = nil
												end

												flag21 = false
											end
										end,
									})
								end
							end

							do
								local flag21, flag22, cFrame

								do
									local currentCamera = workspace.CurrentCamera
									flag21 = false
									flag22 = false
									cFrame = nil

									RunService.Heartbeat:Connect(function()
										if flag21 then
											local blindness = Lighting:FindFirstChild("Blindness")

											if blindness and blindness.Enabled then
												blindness.Enabled = false
											end

											for _, v90 in Lighting:GetChildren() do
												if v90.Name == "Blindness" and v90:IsA("Atmosphere") then
													v90:Destroy()
												end
											end
										end

										if flag22 then
											local character = localPlayer2.Character
											character = character and character:FindFirstChildOfClass("Highlight")

											if character and character.FillColor == Color3.new(0, 0, 1) then
												cFrame = cFrame or currentCamera.CFrame
												currentCamera.CFrame = cFrame
											else
												cFrame = nil
											end
										end
									end)
								end

								local v90 = Detection:create_module({
									title = "Quasar",
									description = "Anti Quasar",
									flag = "Quasar",
									section = "left",
									callback = function()
									end,
								})

								v90:create_checkbox({
									title = "Anti Blindness",
									flag = "Anti_Blindness",
									description = "Blocks Quasar blindness",
									section = "left",
									callback = function(arg)
										flag21 = arg
									end,
								})

								v90:create_checkbox({
									title = "Anti Disorientate",
									flag = "Anti_Disorientate",
									description = "Blocks Quasar camera spin",
									section = "left",
									callback = function(arg)
										flag22 = arg

										if not arg then
											cFrame = nil
										end
									end,
								})
							end
						end

						local flag21, flag22, v90

						do
							local Utils = require(v87.Common.Utils)
							local Net_ = require(v87.Packages.Net)
							flag21 = false
							flag22 = false
							v90 = false
							local profileCard = localPlayer2.PlayerGui:WaitForChild("ProfileCard")
							local playerCard = localPlayer2.PlayerGui:WaitForChild("KillCamCard").PlayerCard

							local function fn30(arg)
								for _, v91 in Players:GetPlayers() do
									if v91.Name == arg or v91.DisplayName == arg then
										return v91
									end
								end
							end

							if not Net_._statsHook then
								Net_._statsHook = true

								do
									local invoke = Net_.Invoke

									Net_.Invoke = function(arg, arg2, arg3, ...)
										local v91 = invoke(arg, arg2, arg3, ...)

										if arg2 == "PlayerProfile/GetProfile" and typeof(v91) == "table" then
											if flag21 and v91.Wins == nil then
												v91.Wins = arg3:GetAttribute("PlayerWins") or 0
											end

											if flag22 and v91.Kills == nil then
												v91.Kills = arg3:GetAttribute("PlayerElims") or 0
											end

											if v90 and v91.RAP == nil then
												v91.RAP = arg3:GetAttribute("TotalRAP") or 0
											end
										end

										return v91
									end
								end
							end

							RunService.Heartbeat:Connect(function()
								if not (flag21 or flag22 or v90) then
									return
								end

								if profileCard.Enabled then
									local v91 = fn30(profileCard.Customize.Profile.PlayerProfile.Details.Username.Text:match("@(.+)") or "")
									if not v91 then
										return
									end
									local stats = profileCard.Customize.Profile.PlayerProfile.Stats
									local playerCard2 = profileCard.Customize.PlayerCard

									if flag22 then
										local attribute = v91:GetAttribute("PlayerElims") or 0
										local kills = playerCard2.Kills
										stats.Kills.Visible = true
										kills.Visible = true
										stats.Kills.Amount.Text = Utils.ValueConvertor:AddCommas(attribute)
										playerCard2.Kills.Amount.Text = ("%* Elims"):format(Utils.ValueConvertor:AddCommas(attribute))
										playerCard2.Kills.Shadow.Text = playerCard2.Kills.Amount.Text
									end

									if flag21 then
										local attribute = v91:GetAttribute("PlayerWins") or 0
										local wins = playerCard2.Wins
										stats.Wins.Visible = true
										wins.Visible = true
										stats.Wins.Amount.Text = Utils.ValueConvertor:AddCommas(attribute)
										playerCard2.Wins.Amount.Text = ("%* Wins"):format(Utils.ValueConvertor:AddCommas(attribute))
										playerCard2.Wins.Shadow.Text = playerCard2.Wins.Amount.Text
									end

									if v90 then
										local attribute = v91:GetAttribute("TotalRAP") or 0
										stats.Rap.Visible = true
										stats.Rap.Amount.Text = ("%*%*"):format(Utils.ValueConvertor:ShrinkNumber(attribute), attribute <= 1000 and "" or "+")
									end
								end

								if playerCard.Parent.Enabled and (flag21 or flag22) then
									local v91 = fn30(playerCard.Username.Text)
									if not v91 then
										return
									end

									if flag22 then
										local attribute = v91:GetAttribute("PlayerElims") or 0
										playerCard.Kills.Visible = true
										playerCard.Kills.Amount.Text = ("%* Elims"):format(Utils.ValueConvertor:AddCommas(attribute))
										playerCard.Kills.Shadow.Text = playerCard.Kills.Amount.Text
									end

									if flag21 then
										local attribute = v91:GetAttribute("PlayerWins") or 0
										playerCard.Wins.Visible = true
										playerCard.Wins.Amount.Text = ("%* Wins"):format(Utils.ValueConvertor:AddCommas(attribute))
										playerCard.Wins.Shadow.Text = playerCard.Wins.Amount.Text
									end
								end
							end)
						end

						do
							local v91 = Misc:create_module({
								title = "Stats",
								description = "Force Showing Stats",
								flag = "ballvelocity",
								section = "left",
								callback = function()
								end,
							})

							v91:create_checkbox({
								title = "Show Wins",
								flag = "Show_Wins",
								description = "Force show hidden wins",
								section = "left",
								callback = function(arg)
									flag21 = arg
								end,
							})

							v91:create_checkbox({
								title = "Show Elims",
								flag = "Show_Elims",
								description = "Force show hidden elims",
								section = "left",
								callback = function(arg)
									flag22 = arg
								end,
							})

							v91:create_checkbox({
								title = "Show Rap",
								flag = "Show_RAP",
								description = "Force show hidden rAP",
								section = "left",
								callback = function(arg)
									v90 = arg
								end,
							})
						end

						RS = game:GetService("RunService")
						R = game:GetService("ReplicatedStorage")
						CR = require(R.Packages._Index["ytrev_replion@2.0.0-rc.1"].replion.Client.ClientReplion)
						Net = require(R.Packages.Net)
						TD = require(R.Shared.TitleData)
						on = false
						eq = nil
						tag = {}
						info = {}

						for _, v91 in TD, nil, nil do
							local v92 = info
							local name = v91.Name
							tag[v91.Tag.Text] = v91.Name
							v92[name] = v91
						end

						local oldGet = CR.Get -- capture per run; never recurse through a shared global

						CR.Get = function(arg, arg2)
							if not on then
								return oldGet(arg, arg2)
							end
							local v91 = "table"
							local tbl23 = typeof(arg2) == v91 and arg2 or { arg2 }
							if tbl23[1] == "Titles" and tbl23[2] then
								return true
							end

							if tbl23[1] == "EquippedTitle" or arg2 == "EquippedTitle" then
								return eq
							end
							return oldGet(arg, arg2)
						end

						do
							local fn30 = nil

							if not Net._titleHook then
								Net._titleHook = true

								do
									local invoke = Net.Invoke

									Net.Invoke = function(arg, arg2, arg3, ...)
										if arg2 == "EquipTitle" and on then
											eq = arg3
											localPlayer2:SetAttribute("Chat_Tag", arg3)
											task.defer(fn30)
											return true
										end

										local v91 = invoke(arg, arg2, arg3, ...)
										local flag23 = on and arg2 == "PlayerProfile/GetProfile" and arg3 == localPlayer2

										if flag23 then
											local v92 = "table"
											flag23 = typeof(v91) == v92
										end

										if flag23 and eq then
											v91.Title = eq
										end

										return v91
									end
								end
							end

							fn30 = function()
								if not on then
									return
								end
								local settings = localPlayer2.PlayerGui:FindFirstChild("Settings")
								if not settings then
									return
								end

								for _, v91 in settings:GetDescendants() do
									if v91.Name == "TitleList" then
										for _, v92 in v91:GetChildren() do
											local textLabel = v92:FindFirstChild("TextLabel")
											local selected = v92:FindFirstChild("Selected")

											if textLabel and selected then
												v92.Visible = true
												local flag23 = textLabel.Text == "None" and nil or tag[textLabel.Text]
												local visible = not flag23 and not eq or flag23 == eq
												selected.Visible = visible
												v92.Image = visible and "rbxassetid://101973108838865" or "rbxassetid://137266342109996"
												v92.HoverImage = visible and "rbxassetid://72246188791319" or "rbxassetid://75518436288869"
											end
										end
									end
								end
							end

							RS.Heartbeat:Connect(function()
								if not on then
									return
								end
								local v91 = eq

								if localPlayer2:GetAttribute("Chat_Tag") ~= v91 then
									localPlayer2:SetAttribute("Chat_Tag", eq)
								end

								local v92 = eq and info[eq]
								local profileCard = localPlayer2.PlayerGui:FindFirstChild("ProfileCard")
								if not (v92 and profileCard and profileCard.Enabled) then
									return
								end
								local title = profileCard.Customize.Profile.PlayerProfile.Details.Title
								local title2 = profileCard.Customize.PlayerCard.Title
								local color = v92.Tag.Color
								title.Text = v92.Tag.Text
								title.TextColor3 = color
								title.Visible = true
								local text = v92.Tag.Text
								local color2 = v92.Tag.Color
								title2.Text = text
								title2.TextColor3 = color2
							end)

							localPlayer2.PlayerGui.ChildAdded:Connect(function(child)
								if child.Name == "Settings" and on then
									task.defer(fn30)
								end
							end)

							Misc:create_module({
								title = "Unlock All Titles",
								flag = "Unlock_Titles",
								description = "Unlock + equip (local)",
								section = "right",
								callback = function(arg)
									on = arg

									if not arg then
										eq = nil
										localPlayer2:SetAttribute("Chat_Tag", nil)
										return
									end

									task.defer(fn30)
								end,
							})
						end

						workspace.Balls.ChildRemoved:Connect(function()
							tbl22.Curving = tick()
							tbl22.Lerp_Radians = 0
							tbl22.Last_Warping = tick()
						end)

						v84:load()
getgenv().WindsRecoveredSession = {window=v84, library=index, parryBackend="native F key"}
						return
