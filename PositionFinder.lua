--made by nika

local G2L = {};

-- StarterGui.ScreenGui
G2L["1"] = Instance.new("ScreenGui", game.CoreGui);
G2L["1"]["Name"] = game:GetService("HttpService"):GenerateGUID(false)
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.ScreenGui.Holder
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(217, 211, 196);
G2L["2"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["2"]["Size"] = UDim2.new(0, 250, 0, 325);
G2L["2"]["Position"] = UDim2.new(1, -8, 1, -8);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[Holder]];


-- StarterGui.ScreenGui.Holder.axes
G2L["3"] = Instance.new("Folder", G2L["2"]);
G2L["3"]["Name"] = [[axes]];


-- StarterGui.ScreenGui.Holder.axes.xaxis
G2L["4"] = Instance.new("TextLabel", G2L["3"]);
G2L["4"]["TextWrapped"] = true;
G2L["4"]["ZIndex"] = 0;
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["TextSize"] = 14;
G2L["4"]["TextScaled"] = true;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(206, 193, 176);
G2L["4"]["FontFace"] = Font.new([[rbxassetid://12187374765]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4"]["TextColor3"] = Color3.fromRGB(140, 112, 93);
G2L["4"]["BackgroundTransparency"] = 1;
G2L["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4"]["Size"] = UDim2.new(1, 0, 0.1, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Text"] = [[X    ]];
G2L["4"]["Name"] = [[xaxis]];


-- StarterGui.ScreenGui.Holder.axes.yaxis
G2L["5"] = Instance.new("TextLabel", G2L["3"]);
G2L["5"]["TextWrapped"] = true;
G2L["5"]["ZIndex"] = 0;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 14;
G2L["5"]["TextScaled"] = true;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(206, 193, 176);
G2L["5"]["FontFace"] = Font.new([[rbxassetid://12187374765]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(140, 112, 93);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["5"]["Size"] = UDim2.new(1, 0, 0.1, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[Y]];
G2L["5"]["LayoutOrder"] = 1;
G2L["5"]["Name"] = [[yaxis]];


-- StarterGui.ScreenGui.Holder.axes.zaxis
G2L["6"] = Instance.new("TextLabel", G2L["3"]);
G2L["6"]["TextWrapped"] = true;
G2L["6"]["ZIndex"] = 0;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["TextSize"] = 14;
G2L["6"]["TextScaled"] = true;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(206, 193, 176);
G2L["6"]["FontFace"] = Font.new([[rbxassetid://12187374765]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["6"]["TextColor3"] = Color3.fromRGB(140, 112, 93);
G2L["6"]["BackgroundTransparency"] = 1;
G2L["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["6"]["Size"] = UDim2.new(1, 0, 0.1, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Text"] = [[    Z]];
G2L["6"]["LayoutOrder"] = 2;
G2L["6"]["Name"] = [[zaxis]];


-- StarterGui.ScreenGui.Holder.axes.UIListLayout
G2L["7"] = Instance.new("UIListLayout", G2L["3"]);
G2L["7"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["7"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["7"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.ScreenGui.Holder.UIPadding
G2L["8"] = Instance.new("UIPadding", G2L["2"]);
G2L["8"]["PaddingTop"] = UDim.new(0, 4);
G2L["8"]["PaddingRight"] = UDim.new(0, 4);
G2L["8"]["PaddingLeft"] = UDim.new(0, 4);
G2L["8"]["PaddingBottom"] = UDim.new(0, 4);


-- StarterGui.ScreenGui.Holder.buttons
G2L["9"] = Instance.new("Folder", G2L["2"]);
G2L["9"]["Name"] = [[buttons]];


-- StarterGui.ScreenGui.Holder.buttons.Grab
G2L["a"] = Instance.new("TextButton", G2L["9"]);
G2L["a"]["TextWrapped"] = true;
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["a"]["AutoButtonColor"] = false;
G2L["a"]["TextSize"] = 12;
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["a"]["ZIndex"] = 0;
G2L["a"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["a"]["Size"] = UDim2.new(0.5, 0, 0.1, 0);
G2L["a"]["Name"] = [[Grab]];
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Text"] = [[GRAB]];
G2L["a"]["Position"] = UDim2.new(0, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.buttons.Grab.UICorner
G2L["b"] = Instance.new("UICorner", G2L["a"]);
G2L["b"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.buttons.Copy
G2L["c"] = Instance.new("TextButton", G2L["9"]);
G2L["c"]["TextWrapped"] = true;
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["c"]["AutoButtonColor"] = false;
G2L["c"]["TextSize"] = 12;
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["c"]["ZIndex"] = 0;
G2L["c"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["c"]["Size"] = UDim2.new(0.5, 0, 0.1, 0);
G2L["c"]["LayoutOrder"] = 1;
G2L["c"]["Name"] = [[Copy]];
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Text"] = [[COPY]];
G2L["c"]["Position"] = UDim2.new(1, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.buttons.Copy.UICorner
G2L["d"] = Instance.new("UICorner", G2L["c"]);
G2L["d"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.buttons.UIListLayout
G2L["e"] = Instance.new("UIListLayout", G2L["9"]);
G2L["e"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["e"]["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
G2L["e"]["Padding"] = UDim.new(0, 4);
G2L["e"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
G2L["e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["e"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.ScreenGui.Holder.buttons.Exit
G2L["f"] = Instance.new("TextButton", G2L["9"]);
G2L["f"]["TextWrapped"] = true;
G2L["f"]["BorderSizePixel"] = 0;
G2L["f"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["f"]["AutoButtonColor"] = false;
G2L["f"]["TextSize"] = 12;
G2L["f"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["f"]["ZIndex"] = 0;
G2L["f"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["f"]["Size"] = UDim2.new(0.5, 0, 0.1, 0);
G2L["f"]["LayoutOrder"] = 2;
G2L["f"]["Name"] = [[Exit]];
G2L["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["Text"] = [[EXIT]];
G2L["f"]["Position"] = UDim2.new(0, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.buttons.Exit.UICorner
G2L["10"] = Instance.new("UICorner", G2L["f"]);
G2L["10"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.UICorner
G2L["11"] = Instance.new("UICorner", G2L["2"]);



-- StarterGui.ScreenGui.Holder.Confirm
G2L["12"] = Instance.new("Frame", G2L["2"]);
G2L["12"]["Visible"] = false;
G2L["12"]["ZIndex"] = 2;
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(217, 211, 196);
G2L["12"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["12"]["ClipsDescendants"] = true;
G2L["12"]["Size"] = UDim2.new(1, 0, 0.25, 0);
G2L["12"]["Position"] = UDim2.new(1, 0, 0.9, -4);
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["Name"] = [[Confirm]];


-- StarterGui.ScreenGui.Holder.Confirm.UICorner
G2L["13"] = Instance.new("UICorner", G2L["12"]);



-- StarterGui.ScreenGui.Holder.Confirm.Title
G2L["14"] = Instance.new("TextLabel", G2L["12"]);
G2L["14"]["TextWrapped"] = true;
G2L["14"]["BorderSizePixel"] = 0;
G2L["14"]["TextSize"] = 12;
G2L["14"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["14"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["14"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["14"]["Size"] = UDim2.new(1, 0, 0, 31);
G2L["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["14"]["Text"] = [[SURE?]];
G2L["14"]["Name"] = [[Title]];


-- StarterGui.ScreenGui.Holder.Confirm.Title.UICorner
G2L["15"] = Instance.new("UICorner", G2L["14"]);
G2L["15"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Confirm.Title.UIPadding
G2L["16"] = Instance.new("UIPadding", G2L["14"]);
G2L["16"]["PaddingLeft"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Confirm.UIPadding
G2L["17"] = Instance.new("UIPadding", G2L["12"]);
G2L["17"]["PaddingTop"] = UDim.new(0, 4);
G2L["17"]["PaddingRight"] = UDim.new(0, 4);
G2L["17"]["PaddingLeft"] = UDim.new(0, 4);
G2L["17"]["PaddingBottom"] = UDim.new(0, 4);


-- StarterGui.ScreenGui.Holder.Confirm.buttons
G2L["18"] = Instance.new("Folder", G2L["12"]);
G2L["18"]["Name"] = [[buttons]];


-- StarterGui.ScreenGui.Holder.Confirm.buttons.UIListLayout
G2L["19"] = Instance.new("UIListLayout", G2L["18"]);
G2L["19"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["19"]["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
G2L["19"]["Padding"] = UDim.new(0, 4);
G2L["19"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
G2L["19"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["19"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.ScreenGui.Holder.Confirm.buttons.No
G2L["1a"] = Instance.new("TextButton", G2L["18"]);
G2L["1a"]["TextWrapped"] = true;
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["1a"]["AutoButtonColor"] = false;
G2L["1a"]["TextSize"] = 12;
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1a"]["ZIndex"] = 2;
G2L["1a"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["1a"]["Size"] = UDim2.new(0.5, 0, 0, 31);
G2L["1a"]["LayoutOrder"] = 1;
G2L["1a"]["Name"] = [[No]];
G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["Text"] = [[NO]];
G2L["1a"]["Position"] = UDim2.new(0, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.Confirm.buttons.No.UICorner
G2L["1b"] = Instance.new("UICorner", G2L["1a"]);
G2L["1b"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Confirm.buttons.Yes
G2L["1c"] = Instance.new("TextButton", G2L["18"]);
G2L["1c"]["TextWrapped"] = true;
G2L["1c"]["BorderSizePixel"] = 0;
G2L["1c"]["TextColor3"] = Color3.fromRGB(82, 59, 43);
G2L["1c"]["AutoButtonColor"] = false;
G2L["1c"]["TextSize"] = 12;
G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1c"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["1c"]["Size"] = UDim2.new(0.5, 0, 0, 31);
G2L["1c"]["BackgroundTransparency"] = 1;
G2L["1c"]["Name"] = [[Yes]];
G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c"]["Text"] = [[YES]];
G2L["1c"]["Position"] = UDim2.new(1, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.Confirm.buttons.Yes.UICorner
G2L["1d"] = Instance.new("UICorner", G2L["1c"]);
G2L["1d"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.top
G2L["1e"] = Instance.new("Folder", G2L["2"]);
G2L["1e"]["Name"] = [[top]];


-- StarterGui.ScreenGui.Holder.top.UIListLayout
G2L["1f"] = Instance.new("UIListLayout", G2L["1e"]);
G2L["1f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["1f"]["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
G2L["1f"]["Padding"] = UDim.new(0, 4);
G2L["1f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["1f"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.ScreenGui.Holder.top.Title
G2L["20"] = Instance.new("TextLabel", G2L["1e"]);
G2L["20"]["TextWrapped"] = true;
G2L["20"]["ZIndex"] = 0;
G2L["20"]["BorderSizePixel"] = 0;
G2L["20"]["TextSize"] = 12;
G2L["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["20"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["20"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["20"]["Size"] = UDim2.new(0, 181, 0, 31);
G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["20"]["Text"] = [[POSITION GRABBER]];
G2L["20"]["Name"] = [[Title]];


-- StarterGui.ScreenGui.Holder.top.Title.UICorner
G2L["21"] = Instance.new("UICorner", G2L["20"]);
G2L["21"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.top.Title.UIPadding
G2L["22"] = Instance.new("UIPadding", G2L["20"]);
G2L["22"]["PaddingLeft"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.top.Log
G2L["23"] = Instance.new("TextButton", G2L["1e"]);
G2L["23"]["TextWrapped"] = true;
G2L["23"]["BorderSizePixel"] = 0;
G2L["23"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["23"]["AutoButtonColor"] = false;
G2L["23"]["TextSize"] = 12;
G2L["23"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["23"]["ZIndex"] = 0;
G2L["23"]["AnchorPoint"] = Vector2.new(0, 1);
G2L["23"]["Size"] = UDim2.new(0.5, 0, 0.1, 0);
G2L["23"]["LayoutOrder"] = 1;
G2L["23"]["Name"] = [[Log]];
G2L["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["23"]["Text"] = [[LOG]];
G2L["23"]["Position"] = UDim2.new(0, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.top.Log.UICorner
G2L["24"] = Instance.new("UICorner", G2L["23"]);
G2L["24"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.top.Log.UIAspectRatioConstraint
G2L["25"] = Instance.new("UIAspectRatioConstraint", G2L["23"]);
G2L["25"]["AspectRatio"] = 2;


-- StarterGui.ScreenGui.Holder.Log
G2L["26"] = Instance.new("Frame", G2L["2"]);
G2L["26"]["Visible"] = false;
G2L["26"]["ZIndex"] = 2;
G2L["26"]["BorderSizePixel"] = 0;
G2L["26"]["BackgroundColor3"] = Color3.fromRGB(217, 211, 196);
G2L["26"]["AnchorPoint"] = Vector2.new(1, 0);
G2L["26"]["ClipsDescendants"] = true;
G2L["26"]["Size"] = UDim2.new(1, 0, 0, 144);
G2L["26"]["Position"] = UDim2.new(1, 0, 0.1, 4);
G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["26"]["Name"] = [[Log]];


-- StarterGui.ScreenGui.Holder.Log.UICorner
G2L["27"] = Instance.new("UICorner", G2L["26"]);



-- StarterGui.ScreenGui.Holder.Log.UIPadding
G2L["28"] = Instance.new("UIPadding", G2L["26"]);
G2L["28"]["PaddingTop"] = UDim.new(0, 4);
G2L["28"]["PaddingRight"] = UDim.new(0, 4);
G2L["28"]["PaddingLeft"] = UDim.new(0, 4);
G2L["28"]["PaddingBottom"] = UDim.new(0, 4);


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame
G2L["29"] = Instance.new("ScrollingFrame", G2L["26"]);
G2L["29"]["Active"] = true;
G2L["29"]["BorderSizePixel"] = 0;
G2L["29"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["29"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
G2L["29"]["ClipsDescendants"] = false;
G2L["29"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["29"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["ScrollBarThickness"] = 0;
G2L["29"]["BackgroundTransparency"] = 1;


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list
G2L["2a"] = Instance.new("Folder", G2L["29"]);
G2L["2a"]["Name"] = [[list]];


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.UIListLayout
G2L["2b"] = Instance.new("UIListLayout", G2L["2a"]);
G2L["2b"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["2b"]["HorizontalFlex"] = Enum.UIFlexAlignment.Fill;
G2L["2b"]["Padding"] = UDim.new(0, 4);
G2L["2b"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.Example
G2L["2c"] = Instance.new("TextButton", G2L["2a"]);
G2L["2c"]["TextWrapped"] = true;
G2L["2c"]["BorderSizePixel"] = 0;
G2L["2c"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["2c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["2c"]["AutoButtonColor"] = false;
G2L["2c"]["TextSize"] = 12;
G2L["2c"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["2c"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2c"]["AnchorPoint"] = Vector2.new(1, 1);
G2L["2c"]["Size"] = UDim2.new(0.5, 0, 0, 31);
G2L["2c"]["LayoutOrder"] = 1;
G2L["2c"]["Name"] = [[Example]];
G2L["2c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2c"]["Text"] = [[1, 1, 1]];
G2L["2c"]["Visible"] = false;
G2L["2c"]["Position"] = UDim2.new(1, 0, 1, 0);


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.Example.UICorner
G2L["2d"] = Instance.new("UICorner", G2L["2c"]);
G2L["2d"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.Example.Copied
G2L["2e"] = Instance.new("TextLabel", G2L["2c"]);
G2L["2e"]["TextWrapped"] = true;
G2L["2e"]["BorderSizePixel"] = 0;
G2L["2e"]["TextSize"] = 12;
G2L["2e"]["BackgroundColor3"] = Color3.fromRGB(82, 59, 43);
G2L["2e"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2e"]["TextColor3"] = Color3.fromRGB(217, 211, 196);
G2L["2e"]["AnchorPoint"] = Vector2.new(1, 0);
G2L["2e"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["2e"]["Visible"] = false;
G2L["2e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2e"]["Text"] = [[COPIED]];
G2L["2e"]["Name"] = [[Copied]];
G2L["2e"]["Position"] = UDim2.new(1, 0, 0, 0);


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.Example.Copied.UICorner
G2L["2f"] = Instance.new("UICorner", G2L["2e"]);
G2L["2f"]["CornerRadius"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Log.ScrollingFrame.list.Example.UIPadding
G2L["30"] = Instance.new("UIPadding", G2L["2c"]);
G2L["30"]["PaddingRight"] = UDim.new(0, 6);
G2L["30"]["PaddingLeft"] = UDim.new(0, 6);


-- StarterGui.ScreenGui.Holder.Darken
G2L["31"] = Instance.new("TextButton", G2L["2"]);
G2L["31"]["BorderSizePixel"] = 0;
G2L["31"]["AutoButtonColor"] = false;
G2L["31"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["31"]["Selectable"] = false;
G2L["31"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["31"]["Size"] = UDim2.new(1, 8, 1, 8);
G2L["31"]["BackgroundTransparency"] = 0.5;
G2L["31"]["Name"] = [[Darken]];
G2L["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["31"]["Text"] = [[]];
G2L["31"]["Visible"] = false;
G2L["31"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.ScreenGui.Holder.Darken.UICorner
G2L["32"] = Instance.new("UICorner", G2L["31"]);



-- StarterGui.ScreenGui.LocalScript
G2L["33"] = Instance.new("LocalScript", G2L["1"]);



-- StarterGui.ScreenGui.LocalScript
local function C_33()
local script = G2L["33"];
	local gui = script.Parent
	local holder = gui.Holder
	local buttons = holder.buttons
	local axes = holder.axes
	local log = holder.Log
	
	local lastlog = nil
	
	buttons.Grab.MouseButton1Down:Connect(function()
		local lp = game.Players.LocalPlayer
		local char = lp.Character or lp.CharacterAdded:Wait()
		if char then
			axes.xaxis.Text = string.format("%f", char.PrimaryPart.Position.X)
			axes.yaxis.Text = string.format("%f", char.PrimaryPart.Position.Y)
			axes.zaxis.Text = string.format("%f", char.PrimaryPart.Position.Z)
			
			local round = string.format("%d, %d, %d", axes.xaxis.Text, axes.yaxis.Text, axes.zaxis.Text)
			if lastlog and lastlog == round then return end
			lastlog = round
			local newlog = log.ScrollingFrame.list.Example:Clone()
			newlog.Parent = log.ScrollingFrame.list
			newlog.Visible = true
			newlog
