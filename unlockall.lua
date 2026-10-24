       local exec = (identifyexecutor or function() return "" end)()
        if type(exec) == "string" and exec:find("Xeno") then isXeno = true end
    end)

    if not isXeno then
        local SkinTab = Window:Tab({ Title = "Unlock All", Icon = "box" })

        local favoriteSwords = {}
        pcall(function()
            if isfile and isfile("LeviHubX/fav_swords.json") then
                local decoded = HttpService:JSONDecode(readfile("LeviHubX/fav_swords.json"))
                if type(decoded) == "table" then favoriteSwords = decoded end
            end
        end)
        local function saveFavs()
            pcall(function()
                if isfolder and makefolder and not isfolder("LeviHubX") then makefolder("LeviHubX") end
                if writefile then writefile("LeviHubX/fav_swords.json", HttpService:JSONEncode(favoriteSwords)) end
            end)
        end
        local function refreshFavList() end
        getgenv().setExplosionChangerToggleUI = function() end
        getgenv().setExplosionInputUI = function() end
        getgenv().setExplosionApplyText = function() end
        getgenv().setLeviHubShopButtonText = function(button, text)
            if not button then return end
            for _, textObject in ipairs(button:GetDescendants()) do
                if textObject:IsA("TextLabel")
                    or textObject:IsA("TextButton")
                    or textObject:IsA("TextBox") then
                    textObject.Text = text
                end
            end
            if button:IsA("TextButton") then
                button.Text = text
            end
        end
        getgenv().forceLeviHubShopEquippedText = function(shop, button, kind, itemName)
            getgenv()._lhxShopForcedEquip = {
                Button = button,
                Kind = kind,
                Name = itemName,
                Until = os.clock() + 2.5,
            }

            local function applyOnce()
                local targetButton = button
                if (not targetButton or not targetButton.Parent) and shop and shop:FindFirstChild("Holder") then
                    local infoBG = shop.Holder:FindFirstChild("InfoBG")
                    targetButton = infoBG and (infoBG:FindFirstChild("BuyButton") or infoBG:FindFirstChild("EquipButton"))
                    if not targetButton and infoBG then
                        for _, child in ipairs(infoBG:GetChildren()) do
                            if (child:IsA("TextButton") or child:IsA("ImageButton")) and not child.Name:lower():find("close") then
                                targetButton = child
                                break
                            end
                        end
                    end
                end
                getgenv().setLeviHubShopButtonText(targetButton, "Equipped")
            end

            applyOnce()
            task.spawn(function()
                while os.clock() < getgenv()._lhxShopForcedEquip.Until do
                    applyOnce()
                    task.wait(0.05)
                end
            end)
        end

        SkinTab:Section({ Title = "Unlock All" })
        SkinTab:Toggle({
            Title = "Unlock All",
            Desc = "Unlocks sword and explosion shop pages locally",
            Value = false,
            Callback = function(v)
                if not v then return end
                local player = game:GetService("Players").LocalPlayer
                local shop = player.PlayerGui:FindFirstChild("Shop")
                if not shop then
                    WindUI:Notify({ Title = "Error", Content = "Shop GUI not found!", Duration = 3 })
                    return
                end

                if not getgenv().unlockAllHooked then
                    getgenv()._lhxCurrentInfoItem = ""
                    getgenv()._lhxCurrentInfoKind = ""
                    getgenv().unlockAllHooked = true
                    getgenv().skinChanger = true
                    getgenv().explosionChanger = true
                    if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(true) end
                    if getgenv().setExplosionChangerToggleUI then getgenv().setExplosionChangerToggleUI(true) end

                    task.spawn(function()
                        while task.wait(0.4) do
                            local pages = shop.Holder and shop.Holder:FindFirstChild("Pages")
                            if (shop.Enabled == false) or (shop.Holder and shop.Holder.Visible == false) then
                                getgenv()._lhxCurrentInfoItem = ""
                                getgenv()._lhxCurrentInfoKind = ""
                            end
                            getgenv()._lhxCurrentShopKind = ""
                            if pages then
                                for _, activePageName in ipairs({"Sword", "Explosion"}) do
                                    local activePage = pages:FindFirstChild(activePageName)
                                    if activePage and activePage:IsA("GuiObject") and activePage.Visible then
                                        getgenv()._lhxCurrentShopKind = activePageName
                                        break
                                    end
                                end
                            end
                            if (getgenv()._lhxCurrentShopKind or "") ~= ""
                                and (getgenv()._lhxCurrentInfoKind or "") ~= ""
                                and getgenv()._lhxCurrentInfoKind ~= getgenv()._lhxCurrentShopKind then
                                getgenv()._lhxCurrentInfoItem = ""
                                getgenv()._lhxCurrentInfoKind = ""
                            end
                            for _, pageName in ipairs({"Sword", "Explosion"}) do
                                local page = pages and pages:FindFirstChild(pageName)
                                if page then
                                    local unownedHeader = page:FindFirstChild("HeaderTitle")
                                    if unownedHeader then
                                        unownedHeader.Visible = false
                                    end

                                    for _, child in ipairs(page:GetDescendants()) do
                                        if child.Name == "Lock" and child:IsA("GuiObject") then
                                            child.Visible = false
                                            local itemCard = child.Parent
                                            if itemCard and itemCard:IsA("GuiObject") then
                                                itemCard.LayoutOrder = 0
                                                if itemCard.Parent and itemCard.Parent.Name == "Unowned" then
                                                    local ownedContainer = page:FindFirstChild("Owned", true)
                                                    if ownedContainer and ownedContainer:IsA("GuiObject") then
                                                        itemCard.Parent = ownedContainer
                                                    end
                                                end
                                                
                                                local favBtn = itemCard:FindFirstChild("Favorite", true) or itemCard:FindFirstChild("Star", true)
                                                local delBtn = itemCard:FindFirstChild("Delete", true) or itemCard:FindFirstChild("Trash", true)

                                                if favBtn and favBtn:IsA("GuiObject") then favBtn.Visible = false end
                                                if delBtn and delBtn:IsA("GuiObject") then delBtn.Visible = false end
                                                
                                                if not itemCard:FindFirstChild("LeviHubHooked") then
                                                    local tag = Instance.new("BoolValue", itemCard)
                                                    tag.Name = "LeviHubHooked"
                                                    
                                                    local itemName = itemCard.Name
                                                    local itemKind = pageName
                                                    local titleObj = itemCard:FindFirstChild("Title", true) or itemCard:FindFirstChild("ItemName", true) or itemCard:FindFirstChild("Name", true)
                                                    if titleObj and titleObj:IsA("TextLabel") then itemName = titleObj.Text end
                                                    
                                                    if not itemCard:FindFirstChild("LeviHubItemHook") then
                                                        local tag = Instance.new("BoolValue", itemCard)
                                                        tag.Name = "LeviHubItemHook"
                                                        itemCard.InputEnded:Connect(function(input)
                                                            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                                                getgenv()._lhxCurrentInfoItem = itemName
                                                                getgenv()._lhxCurrentInfoKind = itemKind
                                                            end
                                                        end)
                                                    end
                                                    
                                                    if favBtn and (favBtn:IsA("GuiButton") or favBtn:IsA("ImageButton") or favBtn:IsA("TextButton")) then
                                                        favBtn.MouseButton1Click:Connect(function()
                                                            local found = false
                                                            for _, s in ipairs(favoriteSwords) do if s == itemName then found = true; break end end
                                                            if not found then
                                                                table.insert(favoriteSwords, itemName)
                                                                pcall(function() saveFavs() end)
                                                                pcall(function() refreshFavList() end)
                                                                WindUI:Notify({ Title = "Favorites", Content = itemName .. " added to favorites.", Duration = 3 })
                                                            else
                                                                WindUI:Notify({ Title = "Favorites", Content = itemName .. " is already in favorites.", Duration = 3 })
                                                            end
                                                        end)
                                                    end
                                                    
                                                    if delBtn and (delBtn:IsA("GuiButton") or delBtn:IsA("ImageButton") or delBtn:IsA("TextButton")) then
                                                        delBtn.MouseButton1Click:Connect(function()
                                                            local removed = false
                                                            for i, s in ipairs(favoriteSwords) do
                                                                if s == itemName then
                                                                    table.remove(favoriteSwords, i)
                                                                    pcall(function() saveFavs() end)
                                                                    pcall(function() refreshFavList() end)
                                                                    WindUI:Notify({ Title = "Favorites", Content = itemName .. " removed from favorites.", Duration = 3 })
                                                                    removed = true
                                                                    break
                                                                end
                                                            end
                                                            if not removed then
                                                                WindUI:Notify({ Title = "Favorites", Content = itemName .. " is not in favorites.", Duration = 3 })
                                                            end
                                                        end)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end

                            local infoBG = shop.Holder:FindFirstChild("InfoBG")
                            if infoBG then
                                local targetBtn = infoBG:FindFirstChild("BuyButton") or infoBG:FindFirstChild("EquipButton")

                                if not targetBtn then
                                    for _, child in ipairs(infoBG:GetChildren()) do
                                        if (child:IsA("TextButton") or child:IsA("ImageButton")) and not child.Name:lower():find("close") then
                                            targetBtn = child
                                            break
                                        end
                                    end
                                end

                                if targetBtn then
                                    local function getSelectedShopItemName()
                                        local clickedItem = getgenv()._lhxCurrentInfoItem or ""
                                        local clickedKind = getgenv()._lhxCurrentInfoKind or ""
                                        local activeKind = getgenv()._lhxCurrentShopKind or ""
                                        if activeKind ~= "" and clickedKind ~= "" and clickedKind ~= activeKind then return "" end
                                        if clickedItem == "" or clickedItem == "Title" then return "" end
                                        local itemName = clickedItem
                                        pcall(function()
                                            local ibg = shop.Holder and shop.Holder:FindFirstChild("InfoBG")
                                            local namer = ibg and ibg:FindFirstChild("Namer")
                                            if namer and namer:IsA("TextLabel") and namer.Text ~= "" and namer.Text ~= "Title" then
                                                itemName = namer.Text
                                            end
                                        end)
                                        return itemName
                                    end
                                    local selectedShopItem = getSelectedShopItemName()
                                    local hasSelectedShopItem = selectedShopItem ~= ""
                                    targetBtn.Visible = hasSelectedShopItem
                                    if targetBtn:IsA("GuiButton") then targetBtn.Active = hasSelectedShopItem end

                                    local forcedEquip = getgenv()._lhxShopForcedEquip
                                    local namerNow = ""
                                    pcall(function()
                                        local ibgN = shop.Holder:FindFirstChild("InfoBG")
                                        local nmr = ibgN and ibgN:FindFirstChild("Namer")
                                        if nmr and nmr:IsA("TextLabel") then namerNow = nmr.Text end
                                    end)
                                    local activeKindForButton = "Sword"
                                    do
                                        local okS2, isS2 = pcall(function()
                                            local m = require(game:GetService("ReplicatedStorage").Shared.ReplicatedInstances.Swords)
                                            return m:GetSword(namerNow) ~= nil
                                        end)
                                        if not (okS2 and isS2) then activeKindForButton = "Explosion" end
                                    end
                                    if hasSelectedShopItem and forcedEquip
                                        and forcedEquip.Until
                                        and os.clock() < forcedEquip.Until
                                        and forcedEquip.Kind == activeKindForButton then
                                        getgenv().setLeviHubShopButtonText(targetBtn, "Equipped")
                                    else
                                        local txt = targetBtn:FindFirstChildOfClass("TextLabel")
                                        if txt and txt.Text ~= "Equip" and txt.Text ~= "Equipped" then txt.Text = "Equip" end
                                        if targetBtn:IsA("TextButton") and targetBtn.Text ~= "Equip" and targetBtn.Text ~= "Equipped" then targetBtn.Text = "Equip" end
                                    end

                                    local globalFav = shop.Holder:FindFirstChild("Favorite", true) or shop:FindFirstChild("Favorite", true)
                                    local infoBG_forDel = shop.Holder:FindFirstChild("InfoBG")
                                    local globalDel = infoBG_forDel and infoBG_forDel:FindFirstChild("Delete") or shop.Holder:FindFirstChild("Delete", true)
                                    
                                    if globalFav then
                                        globalFav.Visible = hasSelectedShopItem
                                        if globalFav:IsA("GuiButton") then globalFav.Active = hasSelectedShopItem end
                                    end
                                    if globalDel then
                                        globalDel.Visible = hasSelectedShopItem
                                        if globalDel:IsA("GuiButton") then globalDel.Active = hasSelectedShopItem end
                                    end

                                    if not targetBtn:FindFirstChild("SkinChangerHookedV2") then
                                         local hookTag = Instance.new("BoolValue", targetBtn)
                                         hookTag.Name = "SkinChangerHookedV2"                                         
                                         local globalFav = shop.Holder:FindFirstChild("Favorite", true) or shop:FindFirstChild("Favorite", true)
                                         local infoBG_forDel = shop.Holder:FindFirstChild("InfoBG")
                                         local globalDel = infoBG_forDel and infoBG_forDel:FindFirstChild("Delete") or shop.Holder:FindFirstChild("Delete", true)

                                         local function getInfoItemName()
                                    local clickedItem = getgenv()._lhxCurrentInfoItem or ""
                                    local clickedKind = getgenv()._lhxCurrentInfoKind or ""
                                    local activeKind = getgenv()._lhxCurrentShopKind or ""
                                    if activeKind ~= "" and clickedKind ~= "" and clickedKind ~= activeKind then return "" end
                                    if clickedItem == "" or clickedItem == "Title" then return "" end
                                    local nm = clickedItem
                                    pcall(function()
                                        local ibg = shop.Holder:FindFirstChild("InfoBG")
                                        local namer = ibg and ibg:FindFirstChild("Namer")
                                        if namer and namer:IsA("TextLabel") and namer.Text ~= "" and namer.Text ~= "Title" then nm = namer.Text end
                                    end)
                                    return nm
                                         end

                                         if globalFav and not globalFav:FindFirstChild("LeviHubFavHooked") then
                                             local favTag = Instance.new("BoolValue", globalFav)
                                             favTag.Name = "LeviHubFavHooked"
                                             globalFav.MouseButton1Click:Connect(function()
                                                 local itemName = getInfoItemName()
                                                 if itemName ~= "" and itemName ~= "Title" then
                                                     local found = false
                                                     for i, s in ipairs(favoriteSwords) do
                                                         if s == itemName then
                                                             table.remove(favoriteSwords, i)
                                                             found = true
                                                             WindUI:Notify({ Title = "Favorites", Content = itemName .. " removed from favorites.", Duration = 3 })
                                                             break
                                                         end
                                                     end
                                                     if not found then
                                                         table.insert(favoriteSwords, itemName)
                                                         WindUI:Notify({ Title = "Favorites", Content = itemName .. " added to favorites.", Duration = 3 })
                                                     end
                                                     pcall(function() saveFavs() end)
                                                     pcall(function() refreshFavList() end)
                                                 end
                                             end)
                                         end

                                         if globalDel and not globalDel:FindFirstChild("LeviHubDelHooked") then
                                             local delTag = Instance.new("BoolValue", globalDel)
                                             delTag.Name = "LeviHubDelHooked"
                                             globalDel.MouseButton1Click:Connect(function()
                                                 local itemName = getInfoItemName()
                                                 if itemName ~= "" and itemName ~= "Title" then
                                                     local removed = false
                                                     for i, s in ipairs(favoriteSwords) do
                                                         if s == itemName then
                                                             table.remove(favoriteSwords, i)
                                                             removed = true
                                                             WindUI:Notify({ Title = "Favorites", Content = itemName .. " deleted from favorites.", Duration = 3 })
                                                             break
                                                         end
                                                     end
                                                     if not removed then
                                                         WindUI:Notify({ Title = "Favorites", Content = itemName .. " is not in favorites.", Duration = 3 })
                                                     end
                                                     pcall(function() saveFavs() end)
                                                     pcall(function() refreshFavList() end)
                                                 end
                                             end)
                                         end

                                         targetBtn.MouseButton1Click:Connect(function()
                                    local activeKind = "Sword"
                                    do
                                        local nmK = ""
                                        pcall(function()
                                            local ibgK = shop.Holder:FindFirstChild("InfoBG")
                                            local nmr = ibgK and ibgK:FindFirstChild("Namer")
                                            if nmr and nmr:IsA("TextLabel") then nmK = nmr.Text end
                                        end)
                                        if nmK == "" then nmK = getgenv()._lhxCurrentInfoItem or "" end
                                        local okS, isS = pcall(function()
                                            local m = require(game:GetService("ReplicatedStorage").Shared.ReplicatedInstances.Swords)
                                            return m:GetSword(nmK) ~= nil
                                        end)
                                        if not (okS and isS) then activeKind = "Explosion" end
                                    end

                                            local infoBG = shop.Holder:FindFirstChild("InfoBG")
                                            if not infoBG then
                                                return
                                            end

                                             local itemName = getInfoItemName()

                                             if itemName == "" or itemName == "Title" then return end

                                             if itemName ~= "" and itemName ~= "Title" then
                                                 getgenv().forceLeviHubShopEquippedText(shop, targetBtn, activeKind, itemName)

                                                if activeKind == "Explosion" then
                                                    getgenv().explosionFX = itemName
                                                    getgenv().explosionChanger = true
                                                    if getgenv().setExplosionChangerToggleUI then getgenv().setExplosionChangerToggleUI(true) end
                                                    if getgenv().setExplosionInputUI then getgenv().setExplosionInputUI(itemName) end
                                                    getgenv().setExplosionApplyText("Equipped")
                                                    if getgenv().updateExplosion then
                                                        task.spawn(function()
                                                            getgenv().updateExplosion()
                                                        end)
                                                    end
                                                else
                                                    getgenv().swordModel = itemName
                                                    getgenv().swordAnimations = itemName
                                                    getgenv().swordFX = itemName
                                                    getgenv().skinChanger = true

                                                    if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(true) end
                                                    if skinSwordInput and skinSwordInput.Set then skinSwordInput:Set(itemName) end
                                                    if getgenv().updateSword then getgenv().updateSword() end
                                                end

                                                getgenv().forceLeviHubShopEquippedText(shop, targetBtn, activeKind, itemName)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end)
                    WindUI:Notify({ Title = "Skin Changer", Content = "Unlocked swords and explosions locally!", Duration = 3 })
                else
                    WindUI:Notify({ Title = "Skin Changer", Content = "Already unlocked!", Duration = 3 })
                end
            end,
        })

    end



    local SKIN_LAST_EQUIPPED_CONFIG_KEY = "Skin.LastEquippedSword"
    local EXPLOSION_LAST_EQUIPPED_CONFIG_KEY = "Skin.LastEquippedExplosion"
    local AUTO_CONFIG_FILE = "LeviHubX/auto_config.json"

    local function readLeviHubAutoConfig()
        local data = {}
        pcall(function()
            if isfile and isfile(AUTO_CONFIG_FILE) then
                local decoded = HttpService:JSONDecode(readfile(AUTO_CONFIG_FILE))
                if type(decoded) == "table" then
                    data = decoded
                end
            end
        end)
        return data
    end

    local function writeLeviHubAutoConfig(data)
        pcall(function()
            if isfolder and makefolder and not isfolder("LeviHubX") then
                makefolder("LeviHubX")
            end
            if writefile then
                writefile(AUTO_CONFIG_FILE, HttpService:JSONEncode(data or {}))
            end
        end)
    end

    local function loadLastEquippedSword()
        local data = readLeviHubAutoConfig()
        local saved = data[SKIN_LAST_EQUIPPED_CONFIG_KEY]
        return type(saved) == "string" and saved or ""
    end

    local function loadLastEquippedExplosion()
        local data = readLeviHubAutoConfig()
        local saved = data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY]
        return type(saved) == "string" and saved or ""
    end

    getgenv().saveLastEquippedSword = function(swordName)
        if type(swordName) ~= "string" or swordName == "" then return end

        local autoConfig = getgenv()._lhxAutoConfig
        local data = autoConfig and autoConfig.Data
        if type(data) ~= "table" then
            data = readLeviHubAutoConfig()
        end

        data[SKIN_LAST_EQUIPPED_CONFIG_KEY] = swordName
        if autoConfig and type(autoConfig.Data) == "table" then
            autoConfig.Data[SKIN_LAST_EQUIPPED_CONFIG_KEY] = swordName
        end
        writeLeviHubAutoConfig(data)
    end

    getgenv().saveLastEquippedExplosion = function(explosionName)
        if type(explosionName) ~= "string" or explosionName == "" then return end

        local autoConfig = getgenv()._lhxAutoConfig
        local data = autoConfig and autoConfig.Data
        if type(data) ~= "table" then
            data = readLeviHubAutoConfig()
        end

        data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY] = explosionName
        if autoConfig and type(autoConfig.Data) == "table" then
            autoConfig.Data[EXPLOSION_LAST_EQUIPPED_CONFIG_KEY] = explosionName
        end
        writeLeviHubAutoConfig(data)
    end



    do
        local savedLastSword = loadLastEquippedSword()
        local savedLastExplosion = loadLastEquippedExplosion()
        getgenv().skinChanger = getgenv().skinChanger or savedLastSword ~= ""
        getgenv().swordModel = type(getgenv().swordModel) == "string" and getgenv().swordModel ~= "" and getgenv().swordModel or savedLastSword
        getgenv().swordAnimations = type(getgenv().swordAnimations) == "string" and getgenv().swordAnimations ~= "" and getgenv().swordAnimations or savedLastSword
        getgenv().swordFX = type(getgenv().swordFX) == "string" and getgenv().swordFX ~= "" and getgenv().swordFX or savedLastSword
        getgenv().explosionChanger = getgenv().explosionChanger or savedLastExplosion ~= ""
        getgenv().explosionFX = type(getgenv().explosionFX) == "string" and getgenv().explosionFX ~= "" and getgenv().explosionFX or savedLastExplosion
    end

    task.spawn(function()
        local rs = game:GetService("ReplicatedStorage")
        local swordInstancesInstance = rs:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
        local swordInstances = require(swordInstancesInstance)

        local swordsController
        task.spawn(function()
            while task.wait(0.25) and not swordsController do
                local ok, conns = pcall(getconnections, rs.Remotes.FireSwordInfo.OnClientEvent)
                if ok and conns then
                    for _, v in ipairs(conns) do
                        if v.Function and islclosure and islclosure(v.Function) then
                            local ok2, up = pcall(getupvalues, v.Function)
                            if ok2 and #up == 1 and type(up[1]) == "table" then
                                swordsController = up[1]
                                break
                            end
                        end
                    end
                end
            end
        end)

        local function getSlashName(swordName)
            local ok, sln = pcall(function() return swordInstances:GetSword(swordName) end)
            return (ok and sln and sln.SlashName) or "SlashEffect"
        end

        local function refreshSlashName()
            local fxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
            if fxName ~= "" then
                getgenv().slashName = getSlashName(fxName)
            else
                getgenv().slashName = "SlashEffect"
            end
        end
        refreshSlashName()

        local function setSword()
            if not getgenv().skinChanger then return end
            if not LocalPlayer.Character then return end
            pcall(function()
                local f = rawget(swordInstances, "EquipSwordTo")
                if type(f) == "function" then
                    local ups = getupvalues(f)
                    for i = 1, #ups do
                        if type(ups[i]) == "boolean" then
                            setupvalue(f, i, false)
                            break
                        end
                    end
                end
            end)
            pcall(function()
                swordInstances:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel)
            end)
            task.spawn(function()
                local attempts = 0
                while not swordsController and attempts < 20 do
                    task.wait(0.5); attempts = attempts + 1
                end
                if not swordsController then return end
                pcall(function()
                    if swordsController.SetSword then
                        swordsController:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel)
                    end
                end)
                pcall(function()
                    local targetSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                    if rs.Remotes:FindFirstChild("FireSwordInfo") then
                        rs.Remotes.FireSwordInfo:FireServer(targetSword)
                    end
                    if swordsController.currentSword ~= nil then
                        pcall(function() swordsController.currentSword = targetSword end)
                    end
                    if swordsController.SwordFX ~= nil then
                        pcall(function() swordsController.SwordFX = targetSword end)
                    end
                end)
            end)
        end

        local hookedFuncs = {}
        task.spawn(function()
            local remotesToHook = {"ParrySuccessAll", "ParryAttempt", "ParrySuccess", "PlaySound", "PlayVisuals"}
            while task.wait(1) do
                for _, remoteName in ipairs(remotesToHook) do
                    local remote = rs.Remotes:FindFirstChild(remoteName)
                    if remote and remote:IsA("RemoteEvent") then
                        local ok, conns = pcall(getconnections, remote.OnClientEvent)
                        if ok and type(conns) == "table" then
                            for _, v in ipairs(conns) do
                                local func = v.Function
                                if func and not hookedFuncs[func] then
                                    
                                    hookedFuncs[func] = true
                                    v:Disable()
                                    local targetFunc = func
                                    local ourFunc
                                    ourFunc = function(...)
                                        local args = { ... }

                                        local isLocal = false
                                        for _, arg in ipairs(args) do
                                            if tostring(arg) == LocalPlayer.Name or (typeof(arg) == "Instance" and (arg == LocalPlayer.Character or arg == LocalPlayer)) then
                                                isLocal = true
                                                break
                                            end
                                        end

                                        if isLocal and getgenv().skinChanger then
                                            local fxSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                                            refreshSlashName()

                                            local swordFound = false
                                            local slashFound = false

                                            for i, arg in ipairs(args) do
                                                if type(arg) == "string" then
                                                    if fxSword ~= "" and not slashFound and (arg:match("Slash") or arg == "Default" or arg:match("Effect")) then
                                                        args[i] = getgenv().slashName
                                                        slashFound = true
                                                    elseif fxSword ~= "" and not swordFound then
                                                        local isSword = false
                                                        pcall(function()
                                                            if rs.Shared.ReplicatedInstances.Swords:FindFirstChild(arg) then
                                                                isSword = true
                                                            end
                                                        end)
                                                        if isSword or arg == LocalPlayer:GetAttribute("CurrentlyEquippedSword") then
                                                            args[i] = fxSword
                                                            swordFound = true
                                                        end
                                                    end
                                                end
                                            end

                                            if fxSword ~= "" and not slashFound and type(args[1]) == "string" then
                                                args[1] = getgenv().slashName
                                            end
                                            if fxSword ~= "" and not swordFound and type(args[3]) == "string" then
                                                args[3] = fxSword
                                            end
                                        end
                                        if setthreadidentity then pcall(setthreadidentity, 2) end
                                        pcall(targetFunc, unpack(args))
                                    end
                                    hookedFuncs[ourFunc] = true
                                    remote.OnClientEvent:Connect(ourFunc)
                                end
                            end
                        end
                    end
                end
            end
        end)

        getgenv().updateSword = function()
            refreshSlashName()
            if getgenv().skinChanger and getgenv().swordModel ~= "" and getgenv().saveLastEquippedSword then
                getgenv().saveLastEquippedSword(getgenv().swordModel)
            end
            setSword()
        end

        task.spawn(function()
            while task.wait(1) do
                if getgenv().skinChanger and getgenv().swordModel ~= "" then
                    local char = LocalPlayer.Character
                    if char then
                        if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
                            setSword()
                        end
                        if not char:FindFirstChild(getgenv().swordModel) then
                            setSword()
                        end
                        for _, v in pairs(char:GetChildren()) do
                            if v:IsA("Model") and v.Name ~= getgenv().swordModel then
                                v:Destroy()
                            end
                            task.wait()
                        end
                    end
                end
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function()
            if getgenv().skinChanger then
                getgenv().skinChanger = false
                if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(false) end
                task.wait(2)
                getgenv().skinChanger = true
                if getgenv().setSkinChangerToggleUI then getgenv().setSkinChangerToggleUI(true) end
                task.wait(0.5)
                pcall(function() getgenv().updateSword() end)
            end
        end)
    end)


    task.spawn(function()
        local rs = game:GetService("ReplicatedStorage")
        local explosionHookedFuncs = {}
        

        local explosionDirectHooked = {}
        local deadFolderHooked = false
        local explosionModule = nil
        local bindableInvokeHooked = false
        local nativeExplosionSuppressorHooked = {}
        local pendingKillExplosionPosition = nil
        local pendingKillExplosionAt = 0
        local lastLocalKillAt = 0
        local lastLocalKillStatTotal = nil
        local killStatWatcherStarted = false
        local lastLocalExplosionPlayedAt = 0
        local lastLocalExplosionPlayedPosition = nil

        local function normalizeExplosionName(value)
            return tostring(value or ""):lower():gsub("[^%w]", "")
        end

        local function getNetFolder()
            local packages = rs:FindFirstChild("Packages")
            local index = packages and packages:FindFirstChild("_Index")
            local sleitnick = index and index:FindFirstChild("sleitnick_net@0.1.0")
            return sleitnick and sleitnick:FindFirstChild("net")
        end

        local function getExplosionInstances()
            local shared = rs:FindFirstChild("Shared")
            local replicatedInstances = shared and shared:FindFirstChild("ReplicatedInstances")
            return replicatedInstances and replicatedInstances:FindFirstChild("Explosions")
        end

        local function getExplosionDataFolder()
            local misc = rs:FindFirstChild("Misc")
            return misc and misc:FindFirstChild("DataExplosions")
        end

        local function getExplosionEffectsFolder()
            return rs:FindFirstChild("ExplosionEffects")
        end

        local function getExplosionModule()
            if explosionModule ~= nil then return explosionModule end
            local instance = getExplosionInstances()
            if instance and instance:IsA("ModuleScript") then
                local ok, result = pcall(function()
                    return require(instance)
                end)
                explosionModule = ok and result or false
            end
            return explosionModule
        end

        local function findExplosionInstanceByName(value)
            if type(value) ~= "string" or value == "" then return nil end
            local wanted = normalizeExplosionName(value)
            for _, root in ipairs({getExplosionDataFolder(), getExplosionEffectsFolder(), getExplosionInstances()}) do
                if root then
                    local exact = root:FindFirstChild(value, true)
                    if exact then return exact end
                    for _, child in ipairs(root:GetDescendants()) do
                        if normalizeExplosionName(child.Name) == wanted then
                            return child
                        end
                    end
                end
            end
            return nil
        end

        local function findExplosionDataConfig(value)
            if type(value) ~= "string" or value == "" then return nil end
            local dataFolder = getExplosionDataFolder()
            if not dataFolder then return nil end

            local wanted = normalizeExplosionName(value)
            local exact = dataFolder:FindFirstChild(value, true)
            if exact then return exact end

            for _, child in ipairs(dataFolder:GetDescendants()) do
                if normalizeExplosionName(child.Name) == wanted then
                    return child
                end
                for _, attributeValue in pairs(child:GetAttributes()) do
                    if type(attributeValue) == "string"
                        and normalizeExplosionName(attributeValue) == wanted then
                        return child
                    end
                end
            end
            return nil
        end

        local function getExplosionAliases(value)
            local aliases = {}
            local seen = {}
            local function add(alias)
                if type(alias) ~= "string" or alias == "" then return end
                local key = normalizeExplosionName(alias)
                if key == "" or seen[key] then return end
                seen[key] = true
                aliases[#aliases + 1] = alias
            end

            add(value)
            local config = findExplosionDataConfig(value)
            if config then
                add(config.Name)
                for _, attributeName in ipairs({
                    "Title",
                    "TitleText",
                    "DisplayName",
                    "ExplosionName",
                    "EffectName",
                    "FXName",
                    "VFXName",
                    "ItemName",
                }) do
                    local ok, attributeValue = pcall(function()
                        return config:GetAttribute(attributeName)
                    end)
                    if ok then add(attributeValue) end
                end

                local scanned = 0
                for _, object in ipairs(config:GetDescendants()) do
                    if object:IsA("StringValue") then
                        add(object.Value)
                        scanned = scanned + 1
                        if scanned >= 20 then break end
                    end
                end
            end
            return aliases
        end

        local function isPlayableExplosionTemplate(instance)
            if typeof(instance) ~= "Instance" then return false end
            if instance:IsA("Configuration")
                or instance:IsA("ModuleScript")
                or instance:IsA("Script")
                or instance:IsA("LocalScript")
                or instance:IsA("BindableFunction")
                or instance:IsA("BindableEvent")
                or instance:IsA("ObjectValue") then
                return false
            end
            return instance:IsA("Folder")
                or instance:IsA("Model")
                or instance:IsA("BasePart")
                or instance:IsA("Attachment")
                or instance:IsA("Accessory")
                or instance:IsA("Tool")
                or instance:FindFirstChildWhichIsA("BasePart", true) ~= nil
                or instance:FindFirstChildWhichIsA("ParticleEmitter", true) ~= nil
                or instance:FindFirstChildWhichIsA("Beam", true) ~= nil
                or instance:FindFirstChildWhichIsA("Trail", true) ~= nil
        end

        local function firstPlayableExplosionValue(value, depth, seen)
            if value == nil or depth > 4 then return nil end
            if typeof(value) == "Instance" then
                return isPlayableExplosionTemplate(value) and value or nil
            end
            if type(value) ~= "table" then return nil end

            seen = seen or {}
            if seen[value] then return nil end
            seen[value] = true

            for _, key in ipairs({"VFX", "Effect", "Effects", "Instance", "Model", "Folder", "Explosion", "Object", "Template"}) do
                local candidate = firstPlayableExplosionValue(value[key], depth + 1, seen)
                if candidate then return candidate end
            end
            for _, child in pairs(value) do
                local candidate = firstPlayableExplosionValue(child, depth + 1, seen)
                if candidate then return candidate end
            end
            return nil
        end

        local function getReplicatedExplosionTemplate(value)
            local instances = getExplosionInstances()
            if not instances then return nil end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local direct = instances:FindFirstChild(alias, true)
                if isPlayableExplosionTemplate(direct) then
                    getgenv().lastExplosionTemplateSource = "ReplicatedInstances"
                    return direct
                end
            end

            local bindable = instances:FindFirstChild("GetInstance")
            if bindable and bindable:IsA("BindableFunction") then
                for _, alias in ipairs(getExplosionAliases(value)) do
                    local ok, result = pcall(function()
                        return bindable:Invoke(alias)
                    end)
                    local template = ok and firstPlayableExplosionValue(result, 0, {}) or nil
                    if template then
                        getgenv().lastExplosionTemplateSource = "ReplicatedInstances.GetInstance"
                        return template
                    end
                end
            end

            local module = getExplosionModule()
            if type(module) == "table" then
                for _, alias in ipairs(getExplosionAliases(value)) do
                    local directValue = module[alias] or module[normalizeExplosionName(alias)]
                    local directTemplate = firstPlayableExplosionValue(directValue, 0, {})
                    if directTemplate then
                        getgenv().lastExplosionTemplateSource = "ReplicatedInstances.Module"
                        return directTemplate
                    end

                    for _, methodName in ipairs({"GetInstance", "GetExplosion", "GetExplosionVFX", "GetEffect", "Get"}) do
                        local method = module[methodName]
                        if type(method) == "function" then
                            for _, callWithSelf in ipairs({true, false}) do
                                local ok, result = pcall(function()
                                    if callWithSelf then
                                        return method(module, alias)
                                    end
                                    return method(alias)
                                end)
                                local template = ok and firstPlayableExplosionValue(result, 0, {}) or nil
                                if template then
                                    getgenv().lastExplosionTemplateSource = "ReplicatedInstances." .. methodName
                                    return template
                                end
                            end
                        end
                    end
                end
            end

            return nil
        end

        local function findExplosionEffectTemplate(value)
            if type(value) ~= "string" or value == "" then return nil end
            local replicatedTemplate = getReplicatedExplosionTemplate(value)
            if replicatedTemplate then return replicatedTemplate end

            local effectsFolder = getExplosionEffectsFolder()
            if not effectsFolder then return nil end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local exact = effectsFolder:FindFirstChild(alias, true)
                if exact and isPlayableExplosionTemplate(exact) then
                    getgenv().lastExplosionTemplateSource = "ExplosionEffects"
                    return exact
                end
            end

            for _, alias in ipairs(getExplosionAliases(value)) do
                local wanted = normalizeExplosionName(alias)
                for _, child in ipairs(effectsFolder:GetDescendants()) do
                    if isPlayableExplosionTemplate(child) and normalizeExplosionName(child.Name) == wanted then
                        getgenv().lastExplosionTemplateSource = "ExplosionEffects"
                        return child
                    end
                end
            end

            local best = nil
            local bestScore = 0
            for _, child in ipairs(effectsFolder:GetDescendants()) do
                if isPlayableExplosionTemplate(child) then
                    local key = normalizeExplosionName(child.Name)
                    local score = 0
                    for _, alias in ipairs(getExplosionAliases(value)) do
                        local wanted = normalizeExplosionName(alias)
                        if wanted:find(key, 1, true) or key:find(wanted, 1, true) then
                            score = math.max(score, math.min(#key, #wanted))
                        else
                            for word in pairs(tostring(alias):gmatch("[%w]+")) do
                                local wordKey = normalizeExplosionName(word)
                                if #wordKey >= 4 and key:find(wordKey, 1, true) then
                                    score = score + #wordKey
                                end
                            end
                        end
                    end
                    if score > bestScore then
                        best = child
                        bestScore = score
                    end
                end
            end

            if best then
                getgenv().lastExplosionTemplateSource = "ExplosionEffects.Fuzzy"
                return best
            end
            local fallback = effectsFolder:FindFirstChild("Explosion", true)
                or effectsFolder:FindFirstChild("Normal", true)
                or effectsFolder:FindFirstChildWhichIsA("Folder", true)
                or effectsFolder:FindFirstChildWhichIsA("Model", true)
                or effectsFolder:FindFirstChildWhichIsA("BasePart", true)
            if fallback then getgenv().lastExplosionTemplateSource = "ExplosionEffects.Fallback" end
            return fallback
        end

        local function getSelectedExplosionName()
            local selected = getgenv().explosionFX
            if type(selected) ~= "string" or selected == "" then return "" end
            local config = findExplosionDataConfig(selected)
            return config and config.Name or selected
        end

        local function isPlayerString(value)
            if type(value) ~= "string" then return false end
            for _, player in ipairs(Players:GetPlayers()) do
                if value == player.Name or value == player.DisplayName then
                    return true
                end
            end
            return false
        end

        local function isKnownExplosionName(value)
            if type(value) ~= "string" or value == "" then return false end
            if findExplosionInstanceByName(value) then return true end
            local instances = getExplosionInstances()
            if instances then
                local bindable = instances:FindFirstChild("GetInstance")
                if bindable and bindable:IsA("BindableFunction") then
                    local ok, result = pcall(function()
                        return bindable:Invoke(value)
                    end)
                    if ok and result then return true end
                end
                if instances:FindFirstChild(value, true) then return true end
            end

            local module = getExplosionModule()
            if type(module) == "table" then
                if module[value] ~= nil then return true end
                for _, methodName in ipairs({"GetExplosion", "GetInstance", "Get"}) do
                    if type(module[methodName]) == "function" then
                        local ok, result = pcall(function()
                            return module[methodName](module, value)
                        end)
                        if ok and result then return true end
                    end
                end
            end
            return false
        end

        local function argsMentionLocal(args)
            for _, arg in ipairs(args) do
                if arg == LocalPlayer or arg == LocalPlayer.Character or arg == LocalPlayer.Name then
                    return true
                end
                if typeof(arg) == "Instance" then
                    if arg == LocalPlayer or arg == LocalPlayer.Character then return true end
                    if LocalPlayer.Character and arg:IsDescendantOf(LocalPlayer.Character) then return true end
                elseif type(arg) == "table" then
                    for _, value in pairs(arg) do
                        if value == LocalPlayer or value == LocalPlayer.Character or value == LocalPlayer.Name then
                            return true
                        end
                    end
                end
            end
            return false
        end

        local function valueMentionsLocal(value, depth)
            if depth > 4 or value == nil then return false end
            if value == LocalPlayer or value == LocalPlayer.Character or value == LocalPlayer.Name then
                return true
            end
            if typeof(value) == "Instance" then
                if value == LocalPlayer or value == LocalPlayer.Character then return true end
                if value:IsA("Player") then
                    return value == LocalPlayer
                        or value.Name == LocalPlayer.Name
                        or value.DisplayName == LocalPlayer.DisplayName
                end
                return LocalPlayer.Character and value:IsDescendantOf(LocalPlayer.Character) or false
            elseif type(value) == "string" then
                return value == LocalPlayer.Name or value == LocalPlayer.DisplayName
            elseif type(value) == "table" then
                for _, child in pairs(value) do
                    if valueMentionsLocal(child, depth + 1) then return true end
                end
            end
            return false
        end

        local function tableIndicatesLocalKill(tbl, depth)
            if type(tbl) ~= "table" or depth > 4 then return false end
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                local killerKey = keyText:find("killer", 1, true)
                    or keyText:find("attacker", 1, true)
                    or keyText:find("creator", 1, true)
                    or keyText:find("source", 1, true)
                    or keyText:find("from", 1, true)
                    or keyText:find("dealer", 1, true)
                    or keyText:find("owner", 1, true)
                local victimKey = keyText:find("victim", 1, true)
                    or keyText:find("dead", 1, true)
                    or keyText:find("killed", 1, true)
                    or keyText:find("target", 1, true)
                if killerKey and valueMentionsLocal(value, 0) then return true end
                if victimKey and valueMentionsLocal(value, 0) then return false end
            end
            for _, value in pairs(tbl) do
                if tableIndicatesLocalKill(value, depth + 1) then return true end
            end
            return false
        end

        local function tableIndicatesLocalDeath(tbl, depth)
            if type(tbl) ~= "table" or depth > 4 then return false end
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                local victimKey = keyText:find("victim", 1, true)
                    or keyText:find("dead", 1, true)
                    or keyText:find("killed", 1, true)
                    or keyText:find("target", 1, true)
                if victimKey and valueMentionsLocal(value, 0) then return true end
            end
            for _, value in pairs(tbl) do
                if tableIndicatesLocalDeath(value, depth + 1) then return true end
            end
            return false
        end

        local function argsIndicateLocalDeath(args)
            for _, arg in ipairs(args) do
                if tableIndicatesLocalDeath(arg, 0) then return true end
            end
            return false
        end

        local function argsIndicateLocalKill(args, remoteName)
            for _, arg in ipairs(args) do
                if tableIndicatesLocalKill(arg, 0) then return true end
            end
            local first = args[1]
            local second = args[2]
            local third = args[3]
            if valueMentionsLocal(second, 0) and not valueMentionsLocal(first, 0) then return true end
            if valueMentionsLocal(third, 0) and not valueMentionsLocal(first, 0) then return true end
            if valueMentionsLocal(first, 0) and not valueMentionsLocal(second, 0) then return true end

            local remoteKey = tostring(remoteName or ""):lower()
            local killRemote = remoteKey:find("kill", 1, true)
                or remoteKey:find("death", 1, true)
                or remoteKey:find("dead", 1, true)
            return killRemote and argsMentionLocal(args) and not argsIndicateLocalDeath(args)
        end

        local function getPositionFromExplosionValue(value, depth)
            if depth > 3 or value == nil then return nil end
            if typeof(value) == "Vector3" then return value end
            if typeof(value) == "CFrame" then return value.Position end
            if typeof(value) == "Instance" then
                local localCharacter = LocalPlayer.Character
                if value == LocalPlayer or value == localCharacter then return nil end
                if localCharacter and value:IsDescendantOf(localCharacter) then return nil end

                if value:IsA("BasePart") then return value.Position end
                if value:IsA("Player") then
                    local character = value.Character
                    local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
                    return root and root.Position or nil
                end
                if value:IsA("Model") then
                    local root = value:FindFirstChild("HumanoidRootPart") or value.PrimaryPart
                    if root then return root.Position end
                    local ok, pivot = pcall(function() return value:GetPivot() end)
                    if ok and pivot then return pivot.Position end
                end
            elseif type(value) == "table" then
                for _, child in pairs(value) do
                    local position = getPositionFromExplosionValue(child, depth + 1)
                    if position then return position end
                end
            end
            return nil
        end

        local function isLocalExplosionPosition(position)
            if typeof(position) ~= "Vector3" then return false end
            local character = LocalPlayer.Character
            local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
            return root and (position - root.Position).Magnitude <= 4 or false
        end

        local function getExplosionPositionFromArgs(args)
            for _, arg in ipairs(args) do
                local position = getPositionFromExplosionValue(arg, 0)
                if position and not isLocalExplosionPosition(position) then return position end
            end
            return nil
        end

        local function parseVector3Attribute(value)
            if typeof(value) == "Vector3" then return value end
            if type(value) ~= "string" then return nil end
            local numbers = {}
            for numberText in value:gmatch("[-+]?%d+%.?%d*") do
                numbers[#numbers + 1] = tonumber(numberText)
                if #numbers >= 3 then break end
            end
            if #numbers >= 3 then
                return Vector3.new(numbers[1], numbers[2], numbers[3])
            end
            return nil
        end

        local function getNumberAttribute(object, names)
            for _, name in ipairs(names) do
                local value = tonumber(object:GetAttribute(name))
                if value then return value end
            end
            return nil
        end

        local function delayedTween(object, delayTime, duration, properties)
            if not next(properties) then return end
            task.delay(delayTime or 0, function()
                if object and object.Parent then
                    pcall(function()
                        TweenService:Create(
                            object,
                            TweenInfo.new(math.max(duration or 0.05, 0.05), Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            properties
                        ):Play()
                    end)
                end
            end)
        end

        local function activateLocalExplosionObject(root)
            local objects = {root}
            for _, object in ipairs(root:GetDescendants()) do
                objects[#objects + 1] = object
            end

            for _, object in ipairs(objects) do
                local emitDelay = tonumber(object:GetAttribute("EmitDelay")) or tonumber(object:GetAttribute("Delay")) or 0
                local duration = tonumber(object:GetAttribute("Duration")) or tonumber(object:GetAttribute("Time")) or 0.35
                if object:IsA("BasePart") then
                    object.Anchored = true
                    object.CanCollide = false
                    object.CanTouch = false
                    object.CanQuery = false

                    local properties = {}
                    local sizeTarget = parseVector3Attribute(object:GetAttribute("Size_Target"))
                        or parseVector3Attribute(object:GetAttribute("Size"))
                    local transparencyTarget = tonumber(object:GetAttribute("Transparency_Target"))
                        or tonumber(object:GetAttribute("Transparency"))
                    if sizeTarget then properties.Size = sizeTarget end
                    if transparencyTarget then properties.Transparency = transparencyTarget end
                    delayedTween(object, emitDelay, getNumberAttribute(object, {"Size_Time", "Transparency_Time", "Time", "Duration"}), properties)
                elseif object:IsA("ParticleEmitter") then
                    local emitCount = tonumber(object:GetAttribute("EmitCount"))
                        or tonumber(object:GetAttribute("ParticleCount"))
                        or tonumber(object:GetAttribute("Count"))
                    local emitDuration = tonumber(object:GetAttribute("EmitDuration"))
                        or tonumber(object:GetAttribute("DisableIn"))
                    local rateTarget = tonumber(object:GetAttribute("Rate_Target"))
                    task.delay(emitDelay, function()
                        if object and object.Parent then
                            if emitCount and emitCount > 0 then
                                pcall(function() object:Emit(emitCount) end)
                            else
                                pcall(function() object.Enabled = true end)
                                if emitDuration and emitDuration > 0 then
                                    task.delay(emitDuration, function()
                                        if object and object.Parent then object.Enabled = false end
                                    end)
                                end
                            end
                            if rateTarget then
                                delayedTween(object, 0, duration, {Rate = rateTarget})
                            end
                        end
                    end)
                elseif object:IsA("Beam") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local properties = {}
                    local width0 = tonumber(object:GetAttribute("Width0"))
                    local width1 = tonumber(object:GetAttribute("Width1"))
                    if width0 then properties.Width0 = width0 end
                    if width1 then properties.Width1 = width1 end
                    delayedTween(object, emitDelay, duration, properties)
                elseif object:IsA("Trail") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local lifetime = tonumber(object:GetAttribute("Lifetime"))
                    if lifetime then object.Lifetime = lifetime end
                elseif object:IsA("Light") then
                    task.delay(emitDelay, function()
                        if object and object.Parent then object.Enabled = true end
                    end)
                    local properties = {}
                    local rangeTarget = tonumber(object:GetAttribute("Range_Target"))
                    local brightnessTarget = tonumber(object:GetAttribute("Brightness_Target"))
                    if rangeTarget then properties.Range = rangeTarget end
                    if brightnessTarget then properties.Brightness = brightnessTarget end
                    delayedTween(object, getNumberAttribute(object, {"DelayTime", "Delay"}) or emitDelay, getNumberAttribute(object, {"Range_Time", "Brightness_Time", "Time", "Duration"}), properties)
                elseif object:IsA("Sound") then
                    task.delay(tonumber(object:GetAttribute("Delay")) or emitDelay, function()
                        if object and object.Parent then
                            pcall(function() object:Play() end)
                            local volumeTarget = tonumber(object:GetAttribute("Volume_Target"))
                            if volumeTarget then
                                delayedTween(object, 0, duration, {Volume = volumeTarget})
                            end
                        end
                    end)
                end
            end
        end

        local function playSyntheticExplosion(position)
            getgenv().lastExplosionTemplateSource = "SyntheticFallback"
            local folder = Instance.new("Folder")
            folder.Name = "LeviHubExplosion_LocalFallback"
            folder.Parent = workspace:FindFirstChild("Runtime") or workspace

            local part = Instance.new("Part")
            part.Name = "Burst"
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            part.Material = Enum.Material.Neon
            part.Shape = Enum.PartType.Ball
            part.Size = Vector3.new(1, 1, 1)
            part.Color = Color3.fromRGB(120, 180, 255)
            part.Transparency = 1
            pcall(function() part.LocalTransparencyModifier = 1 end)
            part.CFrame = CFrame.new(position or Vector3.zero)
            part.Parent = folder

            local attachment = Instance.new("Attachment")
            attachment.Parent = part

            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(90, 130, 255))
            emitter.LightEmission = 1
            emitter.Lifetime = NumberRange.new(0.35, 0.9)
            emitter.Speed = NumberRange.new(28, 58)
            emitter.SpreadAngle = Vector2.new(180, 180)
            emitter.Drag = 4
            emitter.Rate = 0
            emitter.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.8),
                NumberSequenceKeypoint.new(1, 0),
            })
            emitter.Parent = attachment
            emitter:Emit(90)

            local light = Instance.new("PointLight")
            light.Color = part.Color
            light.Brightness = 5
            light.Range = 18
            light.Parent = part

            TweenService:Create(part, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(9, 9, 9),
                Transparency = 1,
            }):Play()
            TweenService:Create(light, TweenInfo.new(0.45), {Brightness = 0, Range = 0}):Play()

            task.delay(2, function()
                if folder and folder.Parent then folder:Destroy() end
            end)
            return true
        end



        local function playLocalExplosion(position)
            if not getgenv().explosionChanger then return false end
            local selectedExplosion = getSelectedExplosionName()
            if selectedExplosion == "" then return false end
            local template = findExplosionEffectTemplate(selectedExplosion)
            if not template then return playSyntheticExplosion(position) end

            local clone = template:Clone()
            clone.Name = "LeviHubExplosion_" .. selectedExplosion

            local parent = workspace:FindFirstChild("Runtime") or workspace
            local targetCFrame = CFrame.new(position or Vector3.zero)

            if clone:IsA("Attachment") then
                local folder = Instance.new("Folder")
                folder.Name = "LeviHubExplosion_" .. selectedExplosion
                folder.Parent = parent

                local anchor = Instance.new("Part")
                anchor.Name = "LeviHubExplosionAnchor"
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.CanTouch = false
                anchor.CanQuery = false
                anchor.Transparency = 1
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.CFrame = targetCFrame
                anchor.Parent = folder

                clone.Parent = anchor
                clone = folder
            else
                clone.Parent = parent
            end

            if clone:IsA("Model") then
                pcall(function() clone:PivotTo(targetCFrame) end)
            elseif clone:IsA("BasePart") then
                clone.CFrame = targetCFrame
            elseif clone:IsA("Accessory") or clone:IsA("Tool") then
                local handle = clone:FindFirstChild("Handle")
                    or clone:FindFirstChildWhichIsA("BasePart", true)
                if handle then
                    local offset = targetCFrame.Position - handle.Position
                    for _, part in ipairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = part.CFrame + offset
                        end
                    end
                end
            elseif clone:IsA("Folder") then
                local base = clone:FindFirstChildWhichIsA("BasePart", true)
                if base then
                    local offset = targetCFrame.Position - base.Position
                    for _, part in ipairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = part.CFrame + offset
                        end
                    end
                else
                    local anchor = Instance.new("Part")
                    anchor.Name = "LeviHubExplosionAnchor"
                    anchor.Anchored = true
                    anchor.CanCollide = false
                    anchor.CanTouch = false
                    anchor.CanQuery = false
                    anchor.Transparency = 1
                    anchor.Size = Vector3.new(1, 1, 1)
                    anchor.CFrame = targetCFrame
                    anchor.Parent = clone
                    for _, child in ipairs(clone:GetDescendants()) do
                        if child:IsA("Attachment") and not child.Parent:IsA("BasePart") then
                            child.Parent = anchor
                        end
                    end
                end
            end

            activateLocalExplosionObject(clone)
            task.delay(8, function()
                if clone and clone.Parent then clone:Destroy() end
            end)
            return true
        end

        local function isLeviHubExplosionObject(object)
            local current = object
            while current and current ~= workspace do
                if type(current.Name) == "string"
                    and current.Name:find("LeviHubExplosion", 1, true) then
                    return true
                end
                current = current.Parent
            end
            return false
        end

        local function hideNativeExplosionVisual(object)
            if not object or isLeviHubExplosionObject(object) then return end
            local objects = { object }
            for _, descendant in ipairs(object:GetDescendants()) do
                objects[#objects + 1] = descendant
            end

            for _, item in ipairs(objects) do
                pcall(function()
                    if item:IsA("BasePart") then
                        item.Transparency = 1
                        item.LocalTransparencyModifier = 1
                        item.CanCollide = false
                        item.CanTouch = false
                        item.CanQuery = false
                    elseif item:IsA("ParticleEmitter") then
                        item.Enabled = false
                        item.Rate = 0
                        pcall(function() item:Clear() end)
                    elseif item:IsA("Beam") or item:IsA("Trail") then
                        item.Enabled = false
                    elseif item:IsA("Light") then
                        item.Enabled = false
                        item.Brightness = 0
                        item.Range = 0
                    elseif item:IsA("Sound") then
                        item.Volume = 0
                        pcall(function() item:Stop() end)
                    end
                end)
            end
        end

        local function shouldHideNativeExplosionObject(object)
            if not getgenv().explosionChanger then return false end
            if (getgenv()._lhxExplosionLocalKillUntil or 0) <= os.clock() then return false end
            if isLeviHubExplosionObject(object) then return false end

            local key = normalizeExplosionName(object and object.Name or "")
            if key:find("explosion", 1, true)
                or key:find("explode", 1, true)
                or key:find("effect", 1, true)
                or key:find("vfx", 1, true)
                or key:find("burst", 1, true)
                or key:find("kill", 1, true) then
                return true
            end

            local parent = object and object.Parent
            local parentKey = normalizeExplosionName(parent and parent.Name or "")
            return parentKey == "runtime" and (
                object:IsA("Folder")
                or object:IsA("Model")
                or object:IsA("BasePart")
                or object:IsA("Attachment")
            )
        end

        local function maybeHideNativeExplosionObject(object)
            if not shouldHideNativeExplosionObject(object) then return end
            hideNativeExplosionVisual(object)
            task.delay(0.03, function() hideNativeExplosionVisual(object) end)
            task.delay(0.12, function() hideNativeExplosionVisual(object) end)
            task.delay(0.3, function() hideNativeExplosionVisual(object) end)
        end

        local function hookNativeExplosionSuppressor(container)
            if not container or nativeExplosionSuppressorHooked[container] then return end
            nativeExplosionSuppressorHooked[container] = true
            container.ChildAdded:Connect(maybeHideNativeExplosionObject)
        end

        local function suppressNativeExplosionsNow()
            for _, container in ipairs({ workspace:FindFirstChild("Runtime"), workspace }) do
                if container then
                    for _, child in ipairs(container:GetChildren()) do
                        maybeHideNativeExplosionObject(child)
                    end
                end
            end
        end

        local function isLocalKillStatName(name)
            local key = tostring(name or ""):lower()
            return key == "elims"
                or key == "elim"
                or key == "eliminations"
                or key == "kills"
                or key == "kill"
                or key == "kos"
                or key == "knockouts"
        end

        local function numericStatValue(value)
            if type(value) == "number" then return value end
            if type(value) == "string" then return tonumber(value) end
            if typeof(value) == "Instance" then
                if value:IsA("IntValue")
                    or value:IsA("NumberValue")
                    or value:IsA("StringValue") then
                    return tonumber(value.Value)
                end
            end
            return nil
        end

        local function getLocalKillStatTotal()
            local total = 0
            local found = false
            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
            if leaderstats then
                for _, stat in ipairs(leaderstats:GetChildren()) do
                    if isLocalKillStatName(stat.Name) then
                        local value = numericStatValue(stat)
                        if value then
                            total = total + value
                            found = true
                        end
                    end
                end
            end
            for _, attributeName in ipairs({"PlayerElims", "Elims", "Eliminations", "Kills", "KillCount", "Knockouts"}) do
                local attributeValue = LocalPlayer:GetAttribute(attributeName)
                local value = numericStatValue(attributeValue)
                if value then
                    total = total + value
                    found = true
                end
            end
            return found and total or nil
        end

        local function playPendingKillExplosion()
            if not getgenv().explosionChanger and (not getgenv().finisherModel or getgenv().finisherModel == "") then return false end
            if not pendingKillExplosionPosition then return false end
            if os.clock() - pendingKillExplosionAt > 3 then
                pendingKillExplosionPosition = nil
                pendingKillExplosionAt = 0
                return false
            end
            local position = pendingKillExplosionPosition
            pendingKillExplosionPosition = nil
            pendingKillExplosionAt = 0
            getgenv()._lhxExplosionLocalKillUntil = os.clock() + 1.25
            if lastLocalExplosionPlayedPosition
                and os.clock() - lastLocalExplosionPlayedAt < 0.25
                and (lastLocalExplosionPlayedPosition - position).Magnitude < 8 then
                return false
            end
            lastLocalExplosionPlayedAt = os.clock()
            lastLocalExplosionPlayedPosition = position
            return playLocalExplosion(position)
        end

        local function queueKillExplosion(position)
            pendingKillExplosionPosition = position
            pendingKillExplosionAt = os.clock()
            if os.clock() - lastLocalKillAt <= 2.5 then
                playPendingKillExplosion()
            end
        end

        local function markLocalKill(position)
            lastLocalKillAt = os.clock()
            getgenv()._lhxExplosionLocalKillUntil = os.clock() + 1.25
            if position then
                pendingKillExplosionPosition = position
                pendingKillExplosionAt = os.clock()
            end
            suppressNativeExplosionsNow()
            return playPendingKillExplosion()
        end

        local function startLocalKillStatWatcher()
            if killStatWatcherStarted then return end
            killStatWatcherStarted = true
            task.spawn(function()
                while task.wait(0.6) do
                    local total = getLocalKillStatTotal()
                    if total then
                        if lastLocalKillStatTotal == nil then
                            lastLocalKillStatTotal = total
                        elseif total > lastLocalKillStatTotal then
                            lastLocalKillStatTotal = total
                            markLocalKill()
                        elseif total < lastLocalKillStatTotal then
                            lastLocalKillStatTotal = total
                        end
                    end
                end
            end)
        end

        local function patchExplosionTable(tbl, remoteKey, selectedExplosion, depth)
            if type(tbl) ~= "table" or depth > 2 then return false end
            local changed = false
            for key, value in pairs(tbl) do
                local keyText = tostring(key):lower()
                if type(value) == "string" then
                    local keyLooksRight = keyText:find("explosion", 1, true)
                        or keyText:find("effect", 1, true)
                        or keyText:find("fx", 1, true)
                    if keyLooksRight or isKnownExplosionName(value) then
                        tbl[key] = selectedExplosion
                        changed = true
                    end
                elseif type(value) == "table" then
                    changed = patchExplosionTable(value, remoteKey, selectedExplosion, depth + 1) or changed
                end
            end
            return changed
        end

        local function patchExplosionArgs(remoteName, args, isOurKill)
            if not getgenv().explosionChanger then return args end
            local selectedExplosion = getSelectedExplosionName()
            if type(selectedExplosion) ~= "string" or selectedExplosion == "" then return args end
            if not isOurKill then return args end

            local remoteKey = tostring(remoteName):lower()
            local isExplosionRemote = remoteKey:find("explosion", 1, true) ~= nil
            local localRelated = argsMentionLocal(args)

            local changed = false

            for index, arg in ipairs(args) do
                if type(arg) == "string" and not isPlayerString(arg) then
                    local valueKey = arg:lower()
                    local shouldPatch = isKnownExplosionName(arg)
                        or isExplosionRemote
                        or (localRelated and (
                            valueKey:find("explosion", 1, true)
                            or valueKey:find("effect", 1, true)
                            or valueKey:find("fx", 1, true)
                        ))
                    if shouldPatch then
                        args[index] = selectedExplosion
                        changed = true
                    end
                elseif type(arg) == "table" then
                    changed = patchExplosionTable(arg, remoteKey, selectedExplosion, 0) or changed
                end
            end

            if isExplosionRemote and not changed then
                for index, arg in ipairs(args) do
                    if type(arg) == "string" and not isPlayerString(arg) then
                        args[index] = selectedExplosion
                        break
                    end
                end
            end

            return args
        end

        local function invokeExplosionRemote(remote, explosionName)
            if not remote or type(explosionName) ~= "string" or explosionName == "" then return false end
            local fired = false
            for _, args in ipairs({
                {explosionName},
                {"Explosion", explosionName},
                {"ExplosionFX", explosionName},
                {"KillEffect", explosionName},
                {explosionName, "Explosion"},
                {explosionName, "ExplosionFX"},
            }) do
                local ok = pcall(function()
                    if remote:IsA("RemoteFunction") then
                        remote:InvokeServer(unpack(args))
                    elseif remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    end
                end)
                fired = ok or fired
            end
            return fired
        end

        local function isExplosionBindable(instance)
            if typeof(instance) ~= "Instance" or not instance:IsA("BindableFunction") then return false end
            local nameKey = normalizeExplosionName(instance.Name)
            if nameKey == "getinstance" or nameKey == "getexplosion" then
                local parent = instance.Parent
                while parent and parent ~= rs do
                    if normalizeExplosionName(parent.Name):find("explosion", 1, true) then
                        return true
                    end
                    parent = parent.Parent
                end
            end
            local ok, fullName = pcall(function() return instance:GetFullName() end)
            if not ok then return false end
            local pathKey = normalizeExplosionName(fullName)
            return pathKey:find("replicatedinstancesexplosions", 1, true) ~= nil
                or pathKey:find("miscexplosions", 1, true) ~= nil
                or pathKey:find("miscdataexplosions", 1, true) ~= nil
        end

        local function installExplosionBindableHook()
            if bindableInvokeHooked then return end
            local hookFunction = getExecutorGlobal("hookfunction") or getExecutorGlobal("hookfunc")
            local makeClosure = getExecutorGlobal("newcclosure") or function(callback) return callback end
            if type(hookFunction) ~= "function" then return end

            local dummyBindable = Instance.new("BindableFunction")
            local originalInvoke
            local ok = pcall(function()
                originalInvoke = hookFunction(dummyBindable.Invoke, makeClosure(function(self, ...)
                    local args = { ... }
                    local localKillWindow = (getgenv()._lhxExplosionLocalKillUntil or 0) > os.clock()
                    if getgenv().explosionChanger and localKillWindow and isExplosionBindable(self) then
                        local selectedExplosion = getSelectedExplosionName()
                        if selectedExplosion ~= "" then
                            for index, value in ipairs(args) do
                                if type(value) == "string" and not isPlayerString(value) then
                                    args[index] = selectedExplosion
                                    break
                                end
                            end
                            if #args == 0 then
                                args[1] = selectedExplosion
                            end
                        end
                    end
                    return originalInvoke(self, unpack(args))
                end))
            end)
            dummyBindable:Destroy()
            bindableInvokeHooked = ok == true
        end

        local function findExplosionEquipRemotes()
            local remotes = {}
            local store = rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("Store")
            local net = getNetFolder()
            local function addRemote(remote)
                if not remote then return end
                for _, existing in ipairs(remotes) do
                    if existing == remote then return end
                end
                table.insert(remotes, remote)
            end

            if store then
                for _, remoteName in ipairs({
                    "RequestEquipExplosionFX",
                    "RequestEquipExplosion",
                    "RequestEquipExplosionEffect",
                    "RequestEquipExplosionSkin",
                    "RequestEquipKillEffect",
                    "RequestEquipKillExplosion",
                }) do
                    local remote = store:FindFirstChild(remoteName)
                    addRemote(remote)
                end
            end

            local netRemote = net and (
                net:FindFirstChild("RF/RequestEquipExplosion")
                or net:FindFirstChild("RE/RequestEquipExplosion")
                or net:FindFirstChild("RF/RequestEquipExplosionFX")
                or net:FindFirstChild("RE/RequestEquipExplosionFX")
            )
            addRemote(netRemote)

            if #remotes == 0 then
                for _, obj in ipairs(rs:GetDescendants()) do
                    if obj:IsA("RemoteFunction") or obj:IsA("RemoteEvent") then
                        local key = obj.Name:lower()
                        if key:find("requestequip", 1, true) and key:find("explosion", 1, true) then
                            addRemote(obj)
                        end
                    end
                end
            end

            return remotes
        end

        getgenv().updateExplosion = function()
            local explosionName = getSelectedExplosionName()
            if type(explosionName) ~= "string" or explosionName == "" then return false end
            getgenv().explosionFX = explosionName

            pcall(function() LocalPlayer:SetAttribute("CurrentlyEquippedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentlyEquippedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("SelectedExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("SelectedExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentExplosion", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("CurrentExplosionFX", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("KillEffect", explosionName) end)
            pcall(function() LocalPlayer:SetAttribute("EquippedKillEffect", explosionName) end)
            if LocalPlayer.Character then
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentlyEquippedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentlyEquippedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("SelectedExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("SelectedExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentExplosion", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("CurrentExplosionFX", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("KillEffect", explosionName) end)
                pcall(function() LocalPlayer.Character:SetAttribute("EquippedKillEffect", explosionName) end)
            end

            if getgenv().saveLastEquippedExplosion then
                getgenv().saveLastEquippedExplosion(explosionName)
            end

            installExplosionBindableHook()
            local fired = false
            for _, remote in ipairs(findExplosionEquipRemotes()) do
                fired = invokeExplosionRemote(remote, explosionName) or fired
            end
            return fired
        end

        getgenv().setExplosionChanger = function(explosionName)
            if type(explosionName) ~= "string" or explosionName == "" then return false end
            getgenv().explosionFX = explosionName
            getgenv().explosionChanger = true
            if getgenv().setExplosionChangerToggleUI then getgenv().setExplosionChangerToggleUI(true) end
            if getgenv().setExplosionInputUI then getgenv().setExplosionInputUI(explosionName) end
            return getgenv().updateExplosion()
        end

        getgenv().testExplosion = function()
            local character = LocalPlayer.Character
            local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
            local camera = workspace.CurrentCamera
            local position = root and (root.Position + root.CFrame.LookVector * 7)
                or camera and (camera.CFrame.Position + camera.CFrame.LookVector * 12)
                or Vector3.zero
            return playLocalExplosion(position)
        end

        installExplosionBindableHook()
        startLocalKillStatWatcher()
        hookNativeExplosionSuppressor(workspace:FindFirstChild("Runtime"))
        hookNativeExplosionSuppressor(workspace)
        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Runtime" then
                hookNativeExplosionSuppressor(child)
            end
            maybeHideNativeExplosionObject(child)
        end)

        local function hookDeadFolder()
            if deadFolderHooked then return end
            local deadFolder = workspace:FindFirstChild("Dead")
            if not deadFolder then return end
            deadFolderHooked = true
            deadFolder.ChildAdded:Connect(function(character)
                if not getgenv().explosionChanger and (not getgenv().finisherModel or getgenv().finisherModel == "") then return end
                task.wait(0.05)
                if character == LocalPlayer.Character then return end

                local root = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
                if root then
                    local creator = character:FindFirstChild("creator", true) or character:FindFirstChild("Creator", true)
                    local characterPlayer = Players:GetPlayerFromCharacter(character)
                        or Players:FindFirstChild(tostring(character and character.Name or ""))
                    
                    local isLocalKill = false
                    if creator and (creator.Value == LocalPlayer or creator.Value == LocalPlayer.Name) then
                        isLocalKill = true
                        markLocalKill(root.Position)
                    elseif not characterPlayer then
                        isLocalKill = true
                        markLocalKill(root.Position)
                    else
                        queueKillExplosion(root.Position)
                    end
                    
                    if isLocalKill and getgenv().finisherModel and getgenv().finisherModel ~= "" and getgenv()._lhxFCModule then
                        if not characterPlayer then
                            task.spawn(function()
                                local s = pcall(function()
                                    getgenv()._lhxFCModule:Play(getgenv().finisherModel, character)
                                end)
                                if not s then
                                    pcall(function()
                                        getgenv()._lhxFCModule:Play(character, getgenv().finisherModel)
                                    end)
                                end
                            end)
                        end
                    end
                end
            end)
        end

        hookDeadFolder()
        workspace.ChildAdded:Connect(function(child)
            if child.Name == "Dead" then
                deadFolderHooked = false
                task.defer(hookDeadFolder)
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function(character)
            task.wait(0.75)
            if getgenv().explosionChanger and getgenv().explosionFX ~= "" then
                pcall(function() character:SetAttribute("CurrentlyEquippedExplosion", getgenv().explosionFX) end)
                pcall(getgenv().updateExplosion)
            end
        end)

        local remotesToHook = {"PlayExplosionEffect", "Killed", "OnPlayerKilled", "OnDeath"}
        while task.wait(1) do
            local remotesFolder = rs:FindFirstChild("Remotes")
            if remotesFolder then
                for _, remoteName in ipairs(remotesToHook) do
                    local remote = remotesFolder:FindFirstChild(remoteName)
                    if remote and remote:IsA("RemoteEvent") then
                        if not explosionDirectHooked[remote] then
                            explosionDirectHooked[remote] = true
                            remote.OnClientEvent:Connect(function(...)
                                if not getgenv().explosionChanger then return end
                                local rawArgs = { ... }
                                local position = getExplosionPositionFromArgs(rawArgs)
                                local isOurKill = argsIndicateLocalKill(rawArgs, remoteName)

                                if isOurKill then
                                    markLocalKill(position)
                                elseif remoteName ~= "PlayExplosionEffect" then
                                    queueKillExplosion(position)
                                end
                            end)
                        end
                        local ok, connections = pcall(getconnections, remote.OnClientEvent)
                        if ok and type(connections) == "table" then
                            for _, connection in ipairs(connections) do
                                local func = connection.Function
                                if func and not explosionHookedFuncs[func] then
                                    if isourclosure and isourclosure(func) then
                                        explosionHookedFuncs[func] = true
                                        continue
                                    end
                                    explosionHookedFuncs[func] = true
                                    connection:Disable()
                                    local targetFunc = func
                                    local ourFunc
                                    ourFunc = function(...)
                                        local rawArgs = { ... }
                                        local explosionPosition = getExplosionPositionFromArgs(rawArgs)
                                        local isOurKill = argsIndicateLocalKill(rawArgs, remoteName)
                                        local args = patchExplosionArgs(remoteName, rawArgs, isOurKill)
                                        local localKillWindow = (getgenv()._lhxExplosionLocalKillUntil or 0) > os.clock()

                                        if getgenv().explosionChanger then
                                            if isOurKill then
                                                markLocalKill(explosionPosition)
                                            elseif remoteName ~= "PlayExplosionEffect" then
                                                queueKillExplosion(explosionPosition)
                                            end
                                            if remoteName == "PlayExplosionEffect" and (isOurKill or localKillWindow) then
                                                return
                                            end
                                        end
                                        if setthreadidentity then pcall(setthreadidentity, 2) end
                                        pcall(targetFunc, unpack(args))
                                    end
                                    explosionHookedFuncs[ourFunc] = true
                                    remote.OnClientEvent:Connect(ourFunc)
                                end
                            end
                        end
                    end
                end
            end
