local DEVICE_SPOOFER_SOURCE = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TARGET_DEVICE = "PC"
task.spawn(function()
	local cgm = ReplicatedStorage:WaitForChild("ClientGameModules", 30)
	if not cgm then return end
	local mod = cgm:WaitForChild("DeviceListener", 30)
	if not mod then return end
	local ok, DL = pcall(require, mod)
	if not ok or not DL then return end
	if DL.RegisterDeviceChanged then
		local OriginalRegister = DL.RegisterDeviceChanged
		DL.RegisterDeviceChanged = function(self, deviceTable, ...)
			if type(deviceTable) == "table" then
				for k, v in pairs(deviceTable) do
					if type(v) == "string" then
						local l = v:lower()
						if l == "mobile" or l == "phone" or l == "tablet" or l == "android" or l == "ios" then
							deviceTable[k] = TARGET_DEVICE
						end
					elseif typeof(v) == "EnumItem" then
						if v == Enum.Platform.Android or v == Enum.Platform.IOS then
							deviceTable[k] = Enum.Platform.Windows
						end
					end
				end
			elseif type(deviceTable) == "string" then
				local l = deviceTable:lower()
				if l == "mobile" or l == "phone" or l == "tablet" or l == "android" or l == "ios" then
					deviceTable = TARGET_DEVICE
				end
			end
			return OriginalRegister(self, deviceTable, ...)
		end
	end
	pcall(function() DL.Device = TARGET_DEVICE end)
	pcall(function()
		if type(DL.Device) == "table" then
			for k, v in pairs(DL.Device) do
				if type(v) == "string" then
					local l = v:lower()
					if l == "mobile" or l == "phone" or l == "android" or l == "ios" then
						DL.Device[k] = TARGET_DEVICE
					end
				end
			end
		end
	end)
	task.wait(1)
	pcall(function() DL:RegisterDeviceChanged(DL.Device) end)
	task.wait(2)
	pcall(function() DL:RegisterDeviceChanged(DL.Device) end)
	task.wait(3)
	pcall(function() DL:RegisterDeviceChanged(DL.Device) end)
end)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(self, key)
	if self == UserInputService then
		if key == "GetPlatform" then
			return function() return Enum.Platform.Windows end
		end
		if key == "TouchEnabled" or key == "TouchScreenEnabled" or key == "AccelerometerEnabled" or key == "GyroscopeEnabled" or key == "GamepadEnabled" or key == "VREnabled" then
			return false
		end
		if key == "KeyboardEnabled" or key == "MouseEnabled" then
			return true
		end
		if key == "PreferredInput" then
			return Enum.PreferredInput.KeyboardAndMouse
		end
	end
	return oldIndex(self, key)
end)
setreadonly(mt, true)
]]

local Handlers = {}

local function packValues(...)
    return {{...}, select("#", ...)}
end

local function unpackValues(packed)
    return unpack(packed[1], 1, packed[2])
end

local function normalizeIterator(value, state, control)
    if type(value) ~= "function" then
        local mt = getmetatable(value)
        if mt ~= nil and mt.__iter ~= nil then
            return mt.__iter(value)
        elseif (mt and mt.__call) == nil and type(value) == "table" then
            return pairs(value)
        end
    end
    return value, state, control
end

local function setRange(target, first, ...)
    local values = {...}
    for index = 1, select("#", ...) do
        target[first + index - 1] = values[index]
    end
end

-- Bind shared dependencies once; returned callbacks retain their original identity.
local binders = {}
binders[0] = function(handler)
    return function(...)
        return handler(...)
    end
end
binders[1] = function(handler, arg1)
    return function(...)
        return handler(arg1, ...)
    end
end
binders[2] = function(handler, arg1, arg2)
    return function(...)
        return handler(arg1, arg2, ...)
    end
end
binders[3] = function(handler, arg1, arg2, arg3)
    return function(...)
        return handler(arg1, arg2, arg3, ...)
    end
end
binders[4] = function(handler, arg1, arg2, arg3, arg4)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, ...)
    end
end
binders[5] = function(handler, arg1, arg2, arg3, arg4, arg5)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, ...)
    end
end
binders[6] = function(handler, arg1, arg2, arg3, arg4, arg5, arg6)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, arg6, ...)
    end
end
binders[7] = function(handler, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, ...)
    end
end
binders[8] = function(handler, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, ...)
    end
end
binders[9] = function(handler, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, ...)
    end
end
binders[10] = function(handler, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    return function(...)
        return handler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, ...)
    end
end

local function bind(handler, ...)
    return binders[select("#", ...)](handler, ...)
end

-- ============================================================================
-- Entry point
-- ============================================================================

-- Initialize services, restore configuration, wire gameplay events, and construct the UI.
function Handlers.main(...)
    -- Services and shared state
    local parryCipher, backgroundColor, result, isBallCurvingRef, lastPingReadRef, disableParticleCleanupRef, refreshAimIfEnabledRef
    local cosmetics2, aimCacheRef, parryTransform, temporary4, animationRecentlyPlayedRef, loadConfig, ballCurveStates
    local swordApiRef, keybindPanelRef, curveOptionsPanelRef, speedLabelRef, watchBallTargetRef, triggerLabel, spamKeyButtonRef
    local runService, isParryBlockedRef, curveDropdownButtonRef, getParryConnectionFunction, tweenService, findAutoexecFolderRef, initializeCosmeticsSafely
    local positionRef, originalIndexRef, cipherKeyLengthRef, parrySucceededRef, fpsLabelRef, animationCacheRef, unboundKey
    local refreshCurvePanelRef, parryRemoteRef, cipherBufferRef, temporary8Ref, swordOverrideEnabledRef, resolveParryAnimationRef, curvePanelOpenRef
    local applyDeviceSpoofRef, findBallRef, getParryConnectionFunction2, temporary10, hideRightLegRef, cosmeticsRef, isPlayerAliveRef
    local spamPanel, deleteConfigAndResetRef, speedDisplayRef, shopControllerApiRef, replicatedStorage, resetFramePositionsRef, playParryAnimationRef
    local playAnimationRef, isVisualEffectRef, parryCooldownRef, ballPresentRef, swordOverrideNameRef, appearanceCacheRef, getPingRef
    local applySavedUiStateRef, initializeCosmeticsSafely2, curveOptionsOpenRef, curveKeyRowsRef, triggerKeyButtonRef, clearVisualEffectsRef, trySpamParryRef
    local setImmortalityHookRef, enableParticleCleanupRef, lastM1StopRef, createFloatingButton, triggerButtonRef, fpsPanelRef, keybindPanelOpenRef
    local refreshAimCacheRef, spamStroke, initializeCosmeticsSafely3, lighting, restoreRightLegRef, ballTargetedPlayerRef, updateSpeedLabelRef
    local selectedCurveRef, applyOptimizationRef, trackedBallsRef, hasRejoinFlagRef, triggerPanel, cacheRightLegRef, lastTriggerTimeRef
    local swordControllerRef, getTeleportQueueRef, keyOptionsPopupRef, beginKeyCaptureRef, immortalityButtonRef, temporary16, makeDraggableRef
    local resetFramePositionsRef2, immortalityTransformRef, unboundKey2, encodeTimestampRef, updateImmortalityTransformRef, hasFileAccessRef, hideHeadRef
    local optimizationStateRef, cachedPingRef, trackBallRef, tryUseAbilityRef, curveDropdownButtonRef2, getBallCurveStateRef, curveOptions
    local immortalityHookEnabledRef, disableNetworkOverrideRef, curveRows, spamCountRef, config, buildCurveWindow, spamHistory
    local onKeybindInputBeganRef, debugFlags, immortalityStrokeRef2, httpService, watchParryStateRef, mutedTextColor, initializeCosmeticsSafely4
    local enableNoRenderRef, triggerStroke, temporary24, applyAppearanceRef, keyOptionRowsRef, calculateCurveTargetRef, immortalityStroke
    local sendParryRef, resetFramePositionsRef3, enableNetworkOverrideRef, onBallFrameRef, spamLabel, tryParryAnimationRef, camera
    local accentColorRef, resetConfigDefaultsRef, saveConfigRef, saveKeybindsRef, refreshKeybindPanelRef, swordAnimationsRef, animationBusyRef
    local dragConnectionsRef, coreGui, textColor, setSwordOverrideRef, pendingKeybindRef, keyCaptureActiveRef, stats
    local ballConnectionsRef, defaultPositionsRef, players, localPlayerRef, originalFireServerRef, temporary30, keybinds
    local playerDataRef, ballSpeedStateRef, clearCloudsRef, styleFloatingButtonRef, immortalityPanel, getSwordConnectionFunction, ballTargetTimesRef
    local userInputService, curveOptionsPanelRef2, immortalityLabel, optimizationConnections, disableNoRenderRef, temporary32Ref, debris
    local watchBallPresenceRef, stopAnimationRef, spamButtonRef, restoreHeadRef, remoteBallPositions, screenGuiRef, cipherKeyBytes
    players = game:GetService("Players")
    runService = game:GetService("RunService")
    replicatedStorage = game:GetService("ReplicatedStorage")
    stats = game:GetService("Stats")
    userInputService = game:GetService("UserInputService")
    tweenService = game:GetService("TweenService")
    lighting = game:GetService("Lighting")
    httpService = game:GetService("HttpService")
    debris = game:GetService("Debris")
    camera = workspace.CurrentCamera
    swordApiRef = {value = replicatedStorage:WaitForChild("Shared"):WaitForChild("SwordAPI")}
    localPlayerRef = {value = players.LocalPlayer}
    unboundKey = Enum.KeyCode.None
    remoteBallPositions = setmetatable({}, {__mode = "k"})
    local netFolder = replicatedStorage:FindFirstChild("Packages")
    if netFolder then
        netFolder = replicatedStorage.Packages:FindFirstChild("_Index")
    end
    if netFolder then
        netFolder = replicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.1.0")
    end
    if netFolder then
        netFolder = replicatedStorage.Packages._Index["sleitnick_net@0.1.0"]:FindFirstChild("net")
    end
    if netFolder then
        for _, remote in ipairs(netFolder:GetChildren()) do
            if remote:IsA("UnreliableRemoteEvent") then
                remote.OnClientEvent:Connect(bind(Handlers.onRemoteBallUpdate, remoteBallPositions))
            end
        end
    end
    -- File access, autoexec discovery, and device spoofing
    hasFileAccessRef = {value = bind(Handlers.hasFileAccess)}
    hasRejoinFlagRef = {value = bind(Handlers.hasRejoinFlag, hasFileAccessRef)}
    findAutoexecFolderRef = {value = bind(Handlers.findAutoexecFolder)}
    getTeleportQueueRef = {value = bind(Handlers.getTeleportQueueFunction)}
    applyDeviceSpoofRef = {
        value = bind(Handlers.applyDeviceSpoofAndRejoin, getTeleportQueueRef, hasFileAccessRef, localPlayerRef, hasRejoinFlagRef, findAutoexecFolderRef)
    }
    appearanceCacheRef = {value = {}}
    cacheRightLegRef = {value = bind(Handlers.cacheRightLegAppearance, appearanceCacheRef)}
    hideRightLegRef = {value = bind(Handlers.hideRightLeg)}
    restoreRightLegRef = {value = bind(Handlers.restoreRightLeg, appearanceCacheRef)}
    hideHeadRef = {value = bind(Handlers.hideHead)}
    restoreHeadRef = {value = bind(Handlers.restoreHead)}
    config = {
        parry = true,
        spamParry = false,
        spam = false,
        trigger = false,
        cps = 60,
        accuracy = 75,
        autoAccuracy = false,
        spamThreshold = 1,
        animfix = false,
        showStats = false,
        immortality = false,
        curveType = "straight",
        showBindWindow = false,
        showSpamUI = false,
        showTriggerUI = false,
        showImmortalUI = false,
        showCurveUI = false,
        showFpsUI = false,
        saveButtonPositions = false,
        buttonPositions = {},
        unlock_all = false,
        last_equipped_sword = "",
        last_equipped_explosion = "",
        favorite_swords = {},
        favorite_explosions = {},
        deleted_swords = {},
        deleted_explosions = {},
        imm = {
            angle = 70,
            height = 15,
            depth = -8,
            radius = 10,
            ui = false
        },
        optim = {
            destroyParticles = false,
            unlimitedKBPS = false,
            headless = false,
            korblox = false,
            noRender = false
        },
        ability = {cooldown_protection = false}
    }
    -- Default settings and character appearance
    applyAppearanceRef = {value = nil}
    defaultPositionsRef, applyAppearanceRef.value = localPlayerRef.value.Character, bind(Handlers.applyCharacterAppearance, restoreRightLegRef, restoreHeadRef, hideHeadRef, cacheRightLegRef, hideRightLegRef, config)
    if defaultPositionsRef then
        applyAppearanceRef.value(localPlayerRef.value.Character)
    end
    saveConfigRef, defaultPositionsRef = bind(Handlers.onCharacterAdded, applyAppearanceRef, appearanceCacheRef), localPlayerRef.value.CharacterAdded
    defaultPositionsRef, dragConnectionsRef = defaultPositionsRef.Connect, defaultPositionsRef
    defaultPositionsRef(dragConnectionsRef, saveConfigRef)
    defaultPositionsRef, dragConnectionsRef = task.spawn, bind(Handlers.watchCharacterAppearance, localPlayerRef, config, applyAppearanceRef)
    defaultPositionsRef(dragConnectionsRef)
    dragConnectionsRef = {}
    saveConfigRef = UDim2.new(0.5, -160, 0.15, 0)
    dragConnectionsRef.MainFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, 5, 0.15, 0)
    dragConnectionsRef.TBFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, 5, 0.25, 0)
    dragConnectionsRef.ImmFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, 165, 0.15, 0)
    dragConnectionsRef.statsFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, 165, 0.2, 0)
    dragConnectionsRef.fpsFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, -75, 0.35, 0)
    dragConnectionsRef.CurveMainFrame = saveConfigRef
    saveConfigRef = UDim2.new(0.5, -110, 0.45, 0)
    dragConnectionsRef.KeybindMainFrame = saveConfigRef
    defaultPositionsRef = {value = dragConnectionsRef}
    saveConfigRef = {}
    dragConnectionsRef = {value = saveConfigRef}
    saveConfigRef = {value = saveConfigRef}
    loadConfig, saveConfigRef.value = bind(Handlers.loadConfig, httpService, config), bind(Handlers.saveConfig, config, httpService)
    loadConfig()
    config.immortality = false
    optimizationStateRef = {destroyParticles = nil, charAdded = nil, unlimitedKBPS = nil, noRender = nil}
    optimizationConnections = optimizationStateRef
    clearCloudsRef = {destroyParticles = false, unlimitedKBPS = false, noRender = false}
    optimizationStateRef = {value = clearCloudsRef}
    clearCloudsRef = {value = bind(Handlers.removeCloudsAndWaterEffects, lighting)}
    isVisualEffectRef = {value = bind(Handlers.isVisualEffect)}
    clearVisualEffectsRef = {value = bind(Handlers.clearVisualEffects, isVisualEffectRef, camera)}
    enableParticleCleanupRef = {
        value = bind(Handlers.enableParticleCleanup, optimizationConnections, localPlayerRef, isVisualEffectRef, optimizationStateRef, clearVisualEffectsRef, clearCloudsRef)
    }
    disableParticleCleanupRef = {value = bind(Handlers.disableParticleCleanup, optimizationStateRef, optimizationConnections)}
    enableNetworkOverrideRef = {value = bind(Handlers.enableNetworkRateOverride, optimizationStateRef, optimizationConnections, runService)}
    disableNetworkOverrideRef = {value = bind(Handlers.disableNetworkRateOverride, optimizationStateRef, optimizationConnections)}
    enableNoRenderRef = {value = bind(Handlers.enableNoRender, optimizationStateRef, localPlayerRef, optimizationConnections)}
    disableNoRenderRef = {value = bind(Handlers.disableNoRender, optimizationStateRef, localPlayerRef, optimizationConnections)}
    applyOptimizationRef = {value = applyOptimizationRef}
    applyOptimizationRef.value, watchParryStateRef = bind(Handlers.applyOptimization, disableNetworkOverrideRef, disableNoRenderRef, applyAppearanceRef, enableParticleCleanupRef, enableNetworkOverrideRef, disableParticleCleanupRef, enableNoRenderRef, localPlayerRef), config.optim
    parryCooldownRef, watchParryStateRef, ballTargetTimesRef = pairs(watchParryStateRef)
    parryCooldownRef, watchParryStateRef, ballTargetTimesRef = normalizeIterator(parryCooldownRef, watchParryStateRef, ballTargetTimesRef)
    for index2, item2 in parryCooldownRef, watchParryStateRef, ballTargetTimesRef do
        ballConnectionsRef, ballTargetedPlayerRef, ballTargetTimesRef = index2, item2, index2
        if ballTargetedPlayerRef then
            applyOptimizationRef.value(ballConnectionsRef, ballTargetedPlayerRef)
        end
    end
    ballConnectionsRef, ballTargetedPlayerRef, ballTargetTimesRef = nil, nil, nil
    watchParryStateRef = {failed_at = 0, duration = 2, last_parrying = nil, conn = nil}
    -- Parry cooldowns and ball tracking
    parryCooldownRef = {value = watchParryStateRef}
    watchParryStateRef = {value = watchParryStateRef}
    ballTargetTimesRef, watchParryStateRef.value = localPlayerRef.value.Character, bind(Handlers.watchCharacterParryState, parryCooldownRef)
    if ballTargetTimesRef then
        watchParryStateRef.value(localPlayerRef.value.Character)
    end
    ballTargetTimesRef, ballTargetedPlayerRef = localPlayerRef.value.CharacterAdded, bind(Handlers.updateCharacterParryWatcherSafely, watchParryStateRef)
    ballConnectionsRef, ballTargetTimesRef = ballTargetTimesRef, ballTargetTimesRef.Connect
    ballTargetTimesRef(ballConnectionsRef, ballTargetedPlayerRef)
    ballConnectionsRef = {}
    ballTargetTimesRef = {value = ballConnectionsRef}
    ballTargetedPlayerRef = {}
    ballConnectionsRef = {value = ballTargetedPlayerRef}
    ballTargetedPlayerRef = {value = false}
    ballPresentRef = {value = false}
    spamCountRef = {value = 0}
    swordOverrideEnabledRef = {value = false}
    swordOverrideNameRef = {value = ""}
    isPlayerAliveRef = {}
    spamHistory = isPlayerAliveRef
    ballSpeedStateRef, isPlayerAliveRef = bind(Handlers.expireSpamHistory, spamHistory, spamCountRef), task.spawn
    isPlayerAliveRef(ballSpeedStateRef)
    isPlayerAliveRef = {value = isPlayerAliveRef}
    isPlayerAliveRef.value, speedDisplayRef = bind(Handlers.isLocalPlayerAlive, localPlayerRef), {}
    speedDisplayRef.current = 0
    speedDisplayRef.peak = 0
    ballSpeedStateRef = {value = speedDisplayRef}
    speedDisplayRef = {value = nil}
    speedLabelRef = {value = nil}
    findBallRef = {value = bind(Handlers.findBall)}
    updateSpeedLabelRef = {value = bind(Handlers.updateBallSpeedLabel, speedLabelRef, ballSpeedStateRef, speedDisplayRef, findBallRef)}
    cachedPingRef, lastPingReadRef = task.spawn, bind(Handlers.watchPeakBallSpeed, config, ballSpeedStateRef)
    cachedPingRef(lastPingReadRef)
    lastPingReadRef, getPingRef, cachedPingRef = runService.RenderStepped, bind(Handlers.updateVisibleSpeedPanel, config, speedDisplayRef, updateSpeedLabelRef), runService.RenderStepped.Connect
    cachedPingRef(lastPingReadRef, getPingRef)
    cachedPingRef = {value = 100}
    lastPingReadRef = {value = 0}
    getPingRef = {value = getPingRef}
    getBallCurveStateRef, getPingRef.value = {}, bind(Handlers.getCachedPing, lastPingReadRef, stats, cachedPingRef)
    ballCurveStates = getBallCurveStateRef
    getBallCurveStateRef = {value = bind(Handlers.getBallCurveState, remoteBallPositions, ballTargetTimesRef, ballConnectionsRef, ballCurveStates)}
    isBallCurvingRef = {value = isBallCurvingRef}
    -- Sword modules and animation state
    isBallCurvingRef.value, swordControllerRef = bind(Handlers.isBallCurving, getBallCurveStateRef), swordApiRef.value
    swordControllerRef = {value = swordControllerRef}
    shopControllerApiRef = bind(Handlers.requireSwordApi, swordControllerRef, replicatedStorage)
    pcall(shopControllerApiRef)
    swordAnimationsRef = {value = nil}
    playerDataRef = bind(Handlers.requireSwordAnimations, swordAnimationsRef, replicatedStorage)
    pcall(playerDataRef)
    shopControllerApiRef = {value = nil}
    animationCacheRef = bind(Handlers.requireShopControllerApi, shopControllerApiRef, replicatedStorage)
    pcall(animationCacheRef)
    playerDataRef = {value = nil}
    stopAnimationRef = bind(Handlers.waitForPlayerData, replicatedStorage, playerDataRef)
    pcall(stopAnimationRef)
    stopAnimationRef, resolveParryAnimationRef = {}, {}
    stopAnimationRef.Cache = resolveParryAnimationRef
    animationCacheRef = {value = stopAnimationRef}
    stopAnimationRef = {value = bind(Handlers.stopAnimationTrack)}
    playAnimationRef = {value = bind(Handlers.playAnimationTrack, playerDataRef)}
    resolveParryAnimationRef = {value = bind(Handlers.resolveParryAnimation, swordControllerRef, animationCacheRef, swordApiRef, localPlayerRef, swordAnimationsRef)}
    parrySucceededRef = {value = false}
    animationBusyRef = {value = false}
    animationRecentlyPlayedRef = {value = false}
    lastM1StopRef = {value = false}
    isParryBlockedRef = {value = nil}
    playParryAnimationRef = {
        value = bind(Handlers.playParryAnimation, swordOverrideEnabledRef, resolveParryAnimationRef, shopControllerApiRef, stopAnimationRef, localPlayerRef, playAnimationRef, swordOverrideNameRef, swordApiRef, config, isParryBlockedRef)
    }
    tryParryAnimationRef = {
        value = bind(Handlers.tryPlayParryAnimation, animationBusyRef, playParryAnimationRef, parrySucceededRef, config, animationRecentlyPlayedRef, isParryBlockedRef, lastM1StopRef)
    }
    calculateCurveTargetRef = replicatedStorage.Shared.DebugFlags
    debugFlags = require(replicatedStorage.Shared.DebugFlags)
    isParryBlockedRef.value = bind(Handlers.isParryBlocked, localPlayerRef, debugFlags)
    calculateCurveTargetRef = {value = bind(Handlers.calculateCurveTarget, config, localPlayerRef)}
    temporary30 = packValues(replicatedStorage:FindFirstChild("PRY", true))
    result = require(unpackValues(temporary30))
    temporary30 = getupvalue(result, 3)
    temporary10 = getupvalue(result, 4)
    parryTransform = getupvalue(result, 8)
    parryCipher = temporary30[temporary30[1]]
    cipherKeyLengthRef = {}
    cipherKeyBytes = cipherKeyLengthRef
    cipherKeyLengthRef = {value = 0}
    cipherBufferRef = temporary10(parryCipher, "TIME")
    cipherKeyLengthRef.value, encodeTimestampRef = #cipherBufferRef, 1
    aimCacheRef = cipherKeyLengthRef.value
    if not (cipherKeyLengthRef.value ~= cipherKeyLengthRef.value) then
        if not (1 > cipherKeyLengthRef.value) then
            while true do
                parryRemoteRef = string.byte(cipherBufferRef, encodeTimestampRef)
                cipherKeyBytes[encodeTimestampRef] = parryRemoteRef
                encodeTimestampRef = encodeTimestampRef + 1
                if encodeTimestampRef > aimCacheRef then
                    break
                else
                    continue
                end
            end
        end
    end
    cipherBufferRef = table.create(24)
    cipherBufferRef = {value = cipherBufferRef}
    encodeTimestampRef = {value = bind(Handlers.encodeParryTimestamp, cipherKeyBytes, cipherKeyLengthRef, cipherBufferRef)}
    originalFireServerRef, refreshAimCacheRef = {}, {}
    refreshAimCacheRef.screen = originalFireServerRef
    originalFireServerRef = {}
    originalFireServerRef[2], originalFireServerRef[1] = 0, 0
    refreshAimCacheRef.aim = originalFireServerRef
    refreshAimCacheRef.cf = nil
    refreshAimCacheRef.lastRefresh = 0
    aimCacheRef = {value = refreshAimCacheRef}
    refreshAimCacheRef = {value = refreshAimCacheRef}
    refreshAimCacheRef.value, parryRemoteRef = bind(Handlers.refreshAimCache, aimCacheRef, camera, localPlayerRef), runService.PreSimulation
    parryRemoteRef, refreshAimIfEnabledRef, originalFireServerRef = parryRemoteRef.Connect, bind(Handlers.refreshAimIfEnabled, config, refreshAimCacheRef), parryRemoteRef
    parryRemoteRef(originalFireServerRef, refreshAimIfEnabledRef)
    parryRemoteRef = {value = nil}
    originalFireServerRef = {value = nil}
    trackedBallsRef = Instance.new("RemoteEvent")
    -- Gameplay event handlers
    sendParryRef, trackedBallsRef = trackedBallsRef.FireServer, bind(Handlers.interceptFireServer, parryRemoteRef, originalFireServerRef)
    refreshAimIfEnabledRef = hookfunction(sendParryRef, trackedBallsRef)
    originalFireServerRef.value = refreshAimIfEnabledRef
    refreshAimIfEnabledRef = {value = 0}
    sendParryRef = {value = sendParryRef}
    lastTriggerTimeRef, sendParryRef.value = {}, bind(Handlers.sendParry, {
        aimCacheRef = aimCacheRef,
        calculateCurveTargetRef = calculateCurveTargetRef,
        refreshAimIfEnabledRef = refreshAimIfEnabledRef,
        originalFireServerRef = originalFireServerRef,
        spamCountRef = spamCountRef,
        parryTransform = parryTransform,
        spamHistory = spamHistory,
        encodeTimestampRef = encodeTimestampRef,
        parryRemoteRef = parryRemoteRef,
        isParryBlockedRef = isParryBlockedRef,
        parryCipher = parryCipher,
        refreshAimCacheRef = refreshAimCacheRef,
        camera = camera
    })
    trackedBallsRef = {value = lastTriggerTimeRef}
    lastTriggerTimeRef = {value = 0}
    trackBallRef = {value = bind(Handlers.trackBall, trackedBallsRef)}
    tryUseAbilityRef = task.spawn
    onBallFrameRef = bind(Handlers.runTriggerLoop, playParryAnimationRef, lastTriggerTimeRef, sendParryRef, trackedBallsRef, config)
    tryUseAbilityRef(onBallFrameRef)
    tryUseAbilityRef = {value = bind(Handlers.tryUseAbility, parryCooldownRef, ballTargetedPlayerRef, replicatedStorage, config, ballPresentRef)}
    onBallFrameRef, trySpamParryRef = task.spawn, bind(Handlers.runAbilityLoop, ballPresentRef, parryRemoteRef, tryUseAbilityRef, config, ballTargetedPlayerRef)
    onBallFrameRef(trySpamParryRef)
    onBallFrameRef = {
        value = bind(Handlers.onTrackedBallFrame, {
            localPlayerRef = localPlayerRef,
            debris = debris,
            isBallCurvingRef = isBallCurvingRef,
            remoteConnections = remoteBallPositions,
            trackBallRef = trackBallRef,
            getPingRef = getPingRef,
            ballTargetTimesRef = ballTargetTimesRef,
            getBallCurveStateRef = getBallCurveStateRef,
            config = config,
            ballTargetedPlayerRef = ballTargetedPlayerRef,
            ballCurveStates = ballCurveStates,
            ballPresentRef = ballPresentRef
        })
    }
    trySpamParryRef = {
        value = bind(Handlers.trySpamParry, localPlayerRef, remoteBallPositions, spamCountRef, config, isPlayerAliveRef, ballPresentRef, getPingRef)
    }
    watchBallTargetRef = task.spawn
    watchBallPresenceRef = bind(Handlers.watchBallPresence, ballPresentRef)
    watchBallTargetRef(watchBallPresenceRef)
    watchBallTargetRef = {
        value = bind(Handlers.watchBallTarget, localPlayerRef, trackBallRef, ballCurveStates, config, ballPresentRef, ballTargetedPlayerRef, ballConnectionsRef)
    }
    watchBallPresenceRef = {value = 0}
    immortalityTransformRef, immortalityHookEnabledRef = runService.PreSimulation, bind(Handlers.onPreSimulation, parryRemoteRef, isPlayerAliveRef, sendParryRef, ballPresentRef, ballTargetedPlayerRef, config, watchBallPresenceRef, tryParryAnimationRef)
    originalIndexRef, immortalityTransformRef = immortalityTransformRef, immortalityTransformRef.Connect
    immortalityTransformRef(originalIndexRef, immortalityHookEnabledRef)
    immortalityTransformRef, originalIndexRef = task.spawn, bind(Handlers.runAutoParryLoop, watchBallTargetRef, trySpamParryRef, onBallFrameRef, parryRemoteRef, ballTargetedPlayerRef, config)
    immortalityTransformRef(originalIndexRef)
    immortalityHookEnabledRef, immortalityTransformRef = bind(Handlers.onParrySucceeded, parrySucceededRef, shopControllerApiRef, stopAnimationRef, config, animationBusyRef, animationRecentlyPlayedRef, localPlayerRef), replicatedStorage.Remotes.ParrySuccess.OnClientEvent
    immortalityTransformRef, originalIndexRef = immortalityTransformRef.Connect, immortalityTransformRef
    immortalityTransformRef(originalIndexRef, immortalityHookEnabledRef)
    originalIndexRef = bind(Handlers.connectM1StopEvent, replicatedStorage, lastM1StopRef)
    pcall(originalIndexRef)
    originalIndexRef = {}
    originalIndexRef.CFrame = nil
    originalIndexRef.Velocity = nil
    immortalityTransformRef = {value = originalIndexRef}
    updateImmortalityTransformRef, originalIndexRef = bind(Handlers.updateImmortalityTransform, runService, localPlayerRef, immortalityTransformRef, config), runService.Heartbeat
    immortalityHookEnabledRef, originalIndexRef = originalIndexRef, originalIndexRef.Connect
    originalIndexRef(immortalityHookEnabledRef, updateImmortalityTransformRef)
    immortalityHookEnabledRef = getrawmetatable(game)
    originalIndexRef = {value = immortalityHookEnabledRef.__index}
    immortalityHookEnabledRef = {value = false}
    setImmortalityHookRef = bind(Handlers.readImmortalityProperty, originalIndexRef, localPlayerRef, immortalityTransformRef, config)
    updateImmortalityTransformRef = newcclosure(setImmortalityHookRef)
    updateImmortalityTransformRef = {value = updateImmortalityTransformRef}
    setImmortalityHookRef = {value = setImmortalityHookRef}
    -- Floating control panels
    setImmortalityHookRef.value, screenGuiRef = bind(Handlers.setImmortalityHookEnabled, immortalityHookEnabledRef, updateImmortalityTransformRef, originalIndexRef), config.immortality
    if screenGuiRef then
        setImmortalityHookRef.value(true)
    end
    screenGuiRef = Instance.new("ScreenGui")
    screenGuiRef = {value = screenGuiRef}
    coreGui = game:FindFirstChild("CoreGui")
    if coreGui then
        accentColorRef = bind(Handlers.parentScreenGui, screenGuiRef, coreGui)
        pcall(accentColorRef)
    end
    if not screenGuiRef.value.Parent then
        makeDraggableRef = localPlayerRef.value:WaitForChild("PlayerGui")
        screenGuiRef.value.Parent = makeDraggableRef
    end
    screenGuiRef.value.ResetOnSpawn = false
    makeDraggableRef = {value = bind(Handlers.makeDraggable, dragConnectionsRef, userInputService, defaultPositionsRef, config, runService)}
    accentColorRef = Color3.fromRGB(255, 140, 0)
    accentColorRef = {value = accentColorRef}
    backgroundColor = Color3.fromRGB(30, 30, 30)
    textColor = Color3.fromRGB(255, 255, 255)
    mutedTextColor = Color3.fromRGB(130, 130, 130)
    createFloatingButton = bind(Handlers.createFloatingButton, backgroundColor, accentColorRef, tweenService)
    styleFloatingButtonRef = {value = bind(Handlers.styleFloatingButton, backgroundColor, accentColorRef, textColor, tweenService)}
    spamPanel = Instance.new("Frame", screenGuiRef.value)
    spamButtonRef = UDim2.new(0, 130, 0, 60)
    spamPanel.Size = spamButtonRef
    spamPanel.Position = defaultPositionsRef.value.MainFrame
    spamButtonRef = Color3.fromRGB(20, 20, 20)
    spamPanel.BackgroundColor3 = spamButtonRef
    spamPanel.BackgroundTransparency = 0.25
    spamButtonRef = Instance.new("UICorner", spamPanel)
    spamStroke = UDim.new(0, 10)
    spamButtonRef.CornerRadius = spamStroke
    spamButtonRef = Instance.new("UIStroke", spamPanel)
    spamButtonRef.Color = accentColorRef.value
    makeDraggableRef.value(spamPanel, nil, "MainFrame")
    spamButtonRef, spamStroke, spamLabel = createFloatingButton(spamPanel, "SPAM")
    spamButtonRef = {value = spamButtonRef}
    triggerPanel = Instance.new("Frame", screenGuiRef.value)
    triggerButtonRef = UDim2.new(0, 130, 0, 60)
    triggerPanel.Size = triggerButtonRef
    triggerPanel.Position = defaultPositionsRef.value.TBFrame
    triggerButtonRef = Color3.fromRGB(20, 20, 20)
    triggerPanel.BackgroundColor3 = triggerButtonRef
    triggerPanel.BackgroundTransparency = 0.25
    triggerButtonRef = Instance.new("UICorner", triggerPanel)
    triggerLabel = UDim.new(0, 10)
    triggerButtonRef.CornerRadius = triggerLabel
    triggerButtonRef = Instance.new("UIStroke", triggerPanel)
    triggerButtonRef.Color = accentColorRef.value
    makeDraggableRef.value(triggerPanel, nil, "TBFrame")
    triggerPanel.Visible = false
    triggerButtonRef, triggerLabel, triggerStroke = createFloatingButton(triggerPanel, "TRIGGER")
    triggerButtonRef = {value = triggerButtonRef}
    immortalityPanel = Instance.new("Frame", screenGuiRef.value)
    immortalityButtonRef = UDim2.new(0, 130, 0, 60)
    immortalityPanel.Size = immortalityButtonRef
    immortalityPanel.Position = defaultPositionsRef.value.ImmFrame
    immortalityButtonRef = Color3.fromRGB(20, 20, 20)
    immortalityPanel.BackgroundColor3 = immortalityButtonRef
    immortalityPanel.BackgroundTransparency = 0.25
    immortalityButtonRef = Instance.new("UICorner", immortalityPanel)
    immortalityLabel = UDim.new(0, 10)
    immortalityButtonRef.CornerRadius = immortalityLabel
    immortalityButtonRef = Instance.new("UIStroke", immortalityPanel)
    immortalityButtonRef.Color = accentColorRef.value
    makeDraggableRef.value(immortalityPanel, nil, "ImmFrame")
    immortalityPanel.Visible = false
    immortalityButtonRef, immortalityLabel, immortalityStroke = createFloatingButton(immortalityPanel, "IMMORTAL")
    immortalityButtonRef = {value = immortalityButtonRef}
    fpsPanelRef = Instance.new("Frame", screenGuiRef.value)
    speedDisplayRef.value = fpsPanelRef
    fpsPanelRef = UDim2.new(0, 160, 0, 40)
    speedDisplayRef.value.Size = fpsPanelRef
    speedDisplayRef.value.Position = defaultPositionsRef.value.statsFrame
    fpsPanelRef = Color3.fromRGB(20, 20, 20)
    speedDisplayRef.value.BackgroundColor3 = fpsPanelRef
    speedDisplayRef.value.BackgroundTransparency = 0.25
    fpsPanelRef = Instance.new("UICorner", speedDisplayRef.value)
    fpsLabelRef = UDim.new(0, 10)
    fpsPanelRef.CornerRadius = fpsLabelRef
    fpsPanelRef = Instance.new("UIStroke", speedDisplayRef.value)
    fpsPanelRef.Color = accentColorRef.value
    makeDraggableRef.value(speedDisplayRef.value, nil, "statsFrame")
    speedDisplayRef.value.Visible = false
    fpsPanelRef = Instance.new("TextLabel", speedDisplayRef.value)
    speedLabelRef.value = fpsPanelRef
    fpsPanelRef = UDim2.new(1, -10, 1, -10)
    speedLabelRef.value.Size = fpsPanelRef
    fpsPanelRef = UDim2.new(0, 5, 0, 5)
    speedLabelRef.value.Position = fpsPanelRef
    speedLabelRef.value.BackgroundTransparency = 1
    speedLabelRef.value.Text = "\226\154\161 0.0 | \240\159\147\136 0.0"
    fpsPanelRef = Color3.fromRGB(255, 200, 100)
    speedLabelRef.value.TextColor3 = fpsPanelRef
    speedLabelRef.value.Font = Enum.Font.GothamBold
    speedLabelRef.value.TextSize = 12
    fpsPanelRef = Instance.new("Frame", screenGuiRef.value)
    fpsPanelRef = {value = fpsPanelRef}
    fpsLabelRef = UDim2.new(0, 150, 0, 26)
    fpsPanelRef.value.Size = fpsLabelRef
    fpsPanelRef.value.Position = defaultPositionsRef.value.fpsFrame
    fpsLabelRef = Color3.fromRGB(20, 20, 20)
    fpsPanelRef.value.BackgroundColor3 = fpsLabelRef
    fpsPanelRef.value.BackgroundTransparency = 0.25
    fpsLabelRef = Instance.new("UICorner", fpsPanelRef.value)
    positionRef = UDim.new(0, 8)
    fpsLabelRef.CornerRadius = positionRef
    fpsLabelRef = Instance.new("UIStroke", fpsPanelRef.value)
    fpsLabelRef.Color = accentColorRef.value
    makeDraggableRef.value(fpsPanelRef.value, nil, "fpsFrame")
    fpsPanelRef.value.Visible = false
    fpsLabelRef = Instance.new("TextLabel", fpsPanelRef.value)
    fpsLabelRef = {value = fpsLabelRef}
    positionRef = UDim2.new(1, -10, 1, -6)
    fpsLabelRef.value.Size = positionRef
    positionRef = UDim2.new(0, 5, 0, 3)
    fpsLabelRef.value.Position = positionRef
    fpsLabelRef.value.BackgroundTransparency = 1
    fpsLabelRef.value.Text = "FPS: 0 | PING: 0 ms"
    positionRef = Color3.fromRGB(255, 200, 100)
    fpsLabelRef.value.TextColor3 = positionRef
    fpsLabelRef.value.Font = Enum.Font.GothamBold
    fpsLabelRef.value.TextSize = 11
    fpsLabelRef.value.TextXAlignment = Enum.TextXAlignment.Center
    positionRef = {value = 120}
    curveOptionsOpenRef, curveDropdownButtonRef2 = runService.RenderStepped, bind(Handlers.updateFpsAndPingLabel, getPingRef, positionRef, fpsLabelRef, fpsPanelRef)
    curveOptionsPanelRef2, curveOptionsOpenRef = curveOptionsOpenRef, curveOptionsOpenRef.Connect
    curveOptionsOpenRef(curveOptionsPanelRef2, curveDropdownButtonRef2)
    curveOptionsOpenRef = {value = nil}
    curveOptionsPanelRef2 = {value = nil}
    curveDropdownButtonRef2 = {value = nil}
    curvePanelOpenRef = {value = false}
    selectedCurveRef = config.curveType or "straight"
    selectedCurveRef = {value = selectedCurveRef}
    curveOptions = {}
    curveRows = curveOptions
    refreshCurvePanelRef = {}
    refreshCurvePanelRef[7], refreshCurvePanelRef[8], refreshCurvePanelRef[2], refreshCurvePanelRef[4], refreshCurvePanelRef[5], refreshCurvePanelRef[3], refreshCurvePanelRef[6], refreshCurvePanelRef[1] = "right", "random", "dot", "up", "down", "backwards", "left", "straight"
    curveOptions = refreshCurvePanelRef
    refreshCurvePanelRef = {
        value = bind(Handlers.refreshCurveWindow, curveRows, textColor, accentColorRef, curveDropdownButtonRef2, curveOptionsPanelRef2, selectedCurveRef, tweenService)
    }
    buildCurveWindow = bind(Handlers.buildCurveWindow, {
        accentColorRef = accentColorRef,
        selectedCurveRef = selectedCurveRef,
        saveConfigRef = saveConfigRef,
        makeDraggableRef = makeDraggableRef,
        config = config,
        refreshCurvePanelRef = refreshCurvePanelRef,
        curvePanelOpenRef = curvePanelOpenRef,
        curveOptionsPanelRef = curveOptionsPanelRef2,
        curveOptionsOpenRef = curveOptionsOpenRef,
        screenGuiRef = screenGuiRef,
        curveOptions = curveOptions,
        defaultPositionsRef = defaultPositionsRef,
        curveDropdownButtonRef = curveDropdownButtonRef2,
        curveRows = curveRows
    })
    buildCurveWindow()
    keybindPanelRef = {value = nil}
    keyOptionsPopupRef = {value = nil}
    keyCaptureActiveRef = {value = false}
    pendingKeybindRef = {value = nil}
    keybindPanelOpenRef = {value = false}
    saveKeybindsRef = {}
    saveKeybindsRef.spam = Enum.KeyCode.P
    saveKeybindsRef.trigger = Enum.KeyCode.T
    curveKeyRowsRef = {}
    saveKeybindsRef.curve = curveKeyRowsRef
    keybinds = saveKeybindsRef
    saveKeybindsRef = _G._417_savedBinds
    if _G._417_savedBinds then
        saveKeybindsRef, keyOptionRowsRef = _G._417_savedBinds, bind(Handlers.parseSavedKeyCode, unboundKey)
        curveKeyRowsRef = keyOptionRowsRef(saveKeybindsRef.spam)
        if curveKeyRowsRef then
            keybinds.spam = curveKeyRowsRef
        end
        spamKeyButtonRef = keyOptionRowsRef(saveKeybindsRef.trigger)
        if spamKeyButtonRef then
            keybinds.trigger = spamKeyButtonRef
        end
        triggerKeyButtonRef = type(saveKeybindsRef.curve)
        if triggerKeyButtonRef == "table" then
            triggerKeyButtonRef, curveDropdownButtonRef, curveOptionsPanelRef = pairs(saveKeybindsRef.curve)
            triggerKeyButtonRef, curveDropdownButtonRef, curveOptionsPanelRef = normalizeIterator(triggerKeyButtonRef, curveDropdownButtonRef, curveOptionsPanelRef)
            for index3, item3 in triggerKeyButtonRef, curveDropdownButtonRef, curveOptionsPanelRef do
                refreshKeybindPanelRef, beginKeyCaptureRef, curveOptionsPanelRef = index3, item3, index3
                resetFramePositionsRef = type(beginKeyCaptureRef)
                if resetFramePositionsRef ~= "string" then
                    unboundKey2 = nil
                else
                    resetFramePositionsRef = beginKeyCaptureRef == "NONE" or beginKeyCaptureRef == "None"
                    if resetFramePositionsRef then
                        unboundKey2 = unboundKey
                    else
                        unboundKey2 = Enum.KeyCode[beginKeyCaptureRef]
                    end
                end
                if unboundKey2 then
                    keybinds.curve[refreshKeybindPanelRef] = unboundKey2
                end
            end
            refreshKeybindPanelRef, beginKeyCaptureRef, curveOptionsPanelRef = nil, nil, nil
        end
    end
    saveKeybindsRef = {value = saveKeybindsRef}
    curveKeyRowsRef, saveKeybindsRef.value = {}, bind(Handlers.saveKeybinds, keybinds, saveConfigRef)
    keyOptionRowsRef = {value = curveKeyRowsRef}
    spamKeyButtonRef = {}
    curveKeyRowsRef = {value = spamKeyButtonRef}
    spamKeyButtonRef = {value = nil}
    triggerKeyButtonRef = {value = nil}
    curveDropdownButtonRef = {value = nil}
    curveOptionsPanelRef = {value = nil}
    refreshKeybindPanelRef = {
        value = bind(Handlers.refreshKeybindingWindow, {
            textColor = textColor,
            triggerKeyButtonRef = triggerKeyButtonRef,
            keybindPanelOpenRef = keybindPanelOpenRef,
            tweenService = tweenService,
            keyOptionRowsRef = keyOptionRowsRef,
            curveDropdownButtonRef = curveDropdownButtonRef,
            pendingKeybindRef = pendingKeybindRef,
            curveKeyRowsRef = curveKeyRowsRef,
            spamKeyButtonRef = spamKeyButtonRef,
            keybinds = keybinds,
            config = config,
            selectedKey = unboundKey,
            mutedTextColor = mutedTextColor,
            accentColorRef = accentColorRef
        })
    }
    beginKeyCaptureRef = {
        value = bind(Handlers.beginKeybindCapture, keybindPanelRef, keyCaptureActiveRef, refreshKeybindPanelRef, pendingKeybindRef, keyOptionsPopupRef)
    }
    unboundKey2 = bind(Handlers.buildKeybindingWindow, {
        accentColorRef = accentColorRef,
        keybinds = keybinds,
        keybindPanelOpenRef = keybindPanelOpenRef,
        curveOptionsPanelRef = curveOptionsPanelRef,
        triggerKeyButtonRef = triggerKeyButtonRef,
        tweenService = tweenService,
        saveKeybindsRef = saveKeybindsRef,
        keyOptionsPopupRef = keyOptionsPopupRef,
        keybindPanelRef = keybindPanelRef,
        keyCaptureActiveRef = keyCaptureActiveRef,
        textColor = textColor,
        pendingKeybindRef = pendingKeybindRef,
        curveKeyRowsRef = curveKeyRowsRef,
        makeDraggableRef = makeDraggableRef,
        curveOptions = curveOptions,
        spamKeyButtonRef = spamKeyButtonRef,
        keyOptionRowsRef = keyOptionRowsRef,
        beginKeyCaptureRef = beginKeyCaptureRef,
        refreshKeybindPanelRef = refreshKeybindPanelRef,
        selectedKey = unboundKey,
        screenGuiRef = screenGuiRef,
        defaultPositionsRef = defaultPositionsRef,
        curveDropdownButtonRef = curveDropdownButtonRef,
        mutedTextColor = mutedTextColor
    })
    unboundKey2()
    resetFramePositionsRef3, onKeybindInputBeganRef = userInputService.InputBegan, bind(Handlers.onKeybindInputBegan, {
        ballTargetedPlayerRef = ballTargetedPlayerRef,
        spamButtonRef = spamButtonRef,
        triggerLabel = triggerLabel,
        selectedCurveRef = selectedCurveRef,
        triggerStroke = triggerStroke,
        triggerButtonRef = triggerButtonRef,
        saveConfigRef = saveConfigRef,
        httpService = httpService,
        parryRemoteRef = parryRemoteRef,
        keybinds = keybinds,
        spamLabel = spamLabel,
        selectedKey = unboundKey,
        refreshKeybindPanelRef = refreshKeybindPanelRef,
        config = config,
        refreshCurvePanelRef = refreshCurvePanelRef,
        styleFloatingButtonRef = styleFloatingButtonRef,
        spamStroke = spamStroke
    })
    resetFramePositionsRef, resetFramePositionsRef3 = resetFramePositionsRef3, resetFramePositionsRef3.Connect
    resetFramePositionsRef3(resetFramePositionsRef, onKeybindInputBeganRef)
    onKeybindInputBeganRef, resetFramePositionsRef3 = bind(Handlers.toggleSpam, styleFloatingButtonRef, spamLabel, spamButtonRef, parryRemoteRef, ballTargetedPlayerRef, spamStroke), spamButtonRef.value.MouseButton1Click
    resetFramePositionsRef, resetFramePositionsRef3 = resetFramePositionsRef3, resetFramePositionsRef3.Connect
    resetFramePositionsRef3(resetFramePositionsRef, onKeybindInputBeganRef)
    onKeybindInputBeganRef, resetFramePositionsRef3 = bind(Handlers.toggleTrigger, styleFloatingButtonRef, triggerStroke, saveConfigRef, parryRemoteRef, config, triggerLabel, triggerButtonRef), triggerButtonRef.value.MouseButton1Click
    resetFramePositionsRef, resetFramePositionsRef3 = resetFramePositionsRef3, resetFramePositionsRef3.Connect
    resetFramePositionsRef3(resetFramePositionsRef, onKeybindInputBeganRef)
    onKeybindInputBeganRef, resetFramePositionsRef3 = bind(Handlers.toggleImmortality, styleFloatingButtonRef, immortalityStroke, saveConfigRef, parryRemoteRef, config, immortalityLabel, immortalityButtonRef, setImmortalityHookRef), immortalityButtonRef.value.MouseButton1Click
    resetFramePositionsRef, resetFramePositionsRef3 = resetFramePositionsRef3, resetFramePositionsRef3.Connect
    resetFramePositionsRef3(resetFramePositionsRef, onKeybindInputBeganRef)
    styleFloatingButtonRef.value(ballTargetedPlayerRef.value, spamButtonRef.value, spamStroke, spamLabel)
    styleFloatingButtonRef.value(config.trigger, triggerButtonRef.value, triggerLabel, triggerStroke)
    immortalityStrokeRef2 = immortalityStroke
    styleFloatingButtonRef.value(config.immortality, immortalityButtonRef.value, immortalityLabel, immortalityStroke)
    resetFramePositionsRef2 = {}
    resetFramePositionsRef2, resetFramePositionsRef3 = {}, resetFramePositionsRef2
    resetFramePositionsRef2, resetFramePositionsRef = {}, resetFramePositionsRef2
    resetFramePositionsRef3 = {value = resetFramePositionsRef3}
    resetFramePositionsRef = {value = resetFramePositionsRef}
    onKeybindInputBeganRef = {value = resetFramePositionsRef2}
    resetFramePositionsRef2 = {value = bind(Handlers.resetFramePositions, config, dragConnectionsRef, saveConfigRef)}
    immortalityStrokeRef2 = {value = bind(Handlers.refreshSettingsControls, config, resetFramePositionsRef, onKeybindInputBeganRef, resetFramePositionsRef3)}
    resetConfigDefaultsRef = {value = bind(Handlers.resetConfigDefaults, refreshKeybindPanelRef, keybinds, refreshCurvePanelRef, config, selectedCurveRef)}
    applySavedUiStateRef = {
        value = bind(Handlers.applySavedUiState, {
            spamPanel = spamPanel,
            selectedCurveRef = selectedCurveRef,
            spamLabel = spamLabel,
            ballTargetedPlayerRef = ballTargetedPlayerRef,
            applyOptimizationRef = applyOptimizationRef,
            curveOptionsPanelRef = curveOptionsPanelRef2,
            immortalityLabel = immortalityLabel,
            triggerButtonRef = triggerButtonRef,
            speedDisplayRef = speedDisplayRef,
            triggerStroke = triggerStroke,
            keybindPanelRef = keybindPanelRef,
            immortalityButtonRef = immortalityButtonRef,
            spamButtonRef = spamButtonRef,
            immortalityStroke = immortalityStroke,
            styleFloatingButtonRef = styleFloatingButtonRef,
            setImmortalityHookRef = setImmortalityHookRef,
            refreshCurvePanelRef = refreshCurvePanelRef,
            keyCaptureActiveRef = keyCaptureActiveRef,
            spamStroke = spamStroke,
            curveOptionsOpenRef = curveOptionsOpenRef,
            config = config,
            fpsPanelRef = fpsPanelRef,
            pendingKeybindRef = pendingKeybindRef,
            curvePanelOpenRef = curvePanelOpenRef,
            refreshKeybindPanelRef = refreshKeybindPanelRef,
            keyOptionsPopupRef = keyOptionsPopupRef,
            triggerPanel = triggerPanel,
            immortalityPanel = immortalityPanel,
            triggerLabel = triggerLabel
        })
    }
    deleteConfigAndResetRef = {value = bind(Handlers.deleteConfigAndReset, applySavedUiStateRef, resetFramePositionsRef2, immortalityStrokeRef2, resetConfigDefaultsRef)}
    -- Cosmetic controller and shop integration
    cosmeticsRef, initializeCosmeticsSafely2 = {}, {}
    cosmeticsRef.parry_connections = initializeCosmeticsSafely2
    initializeCosmeticsSafely2 = {}
    cosmeticsRef.fire_sword_connections = initializeCosmeticsSafely2
    cosmeticsRef.play_parry = nil
    cosmeticsRef.sword_fn = nil
    cosmetics2 = cosmeticsRef
    cosmeticsRef = replicatedStorage:WaitForChild("Remotes", 15)
    setSwordOverrideRef = cosmeticsRef and cosmeticsRef:WaitForChild("ParrySuccessAll", 10)
    initializeCosmeticsSafely2 = setSwordOverrideRef
    if setSwordOverrideRef then
        initializeCosmeticsSafely4 = type(getconnections)
        initializeCosmeticsSafely2 = initializeCosmeticsSafely4 == "function"
    end
    if initializeCosmeticsSafely2 then
        initializeCosmeticsSafely2, initializeCosmeticsSafely4 = pcall(getconnections, setSwordOverrideRef.OnClientEvent)
        initializeCosmeticsSafely3 = initializeCosmeticsSafely2
        if initializeCosmeticsSafely2 then
            initializeCosmeticsSafely = type(initializeCosmeticsSafely4)
            initializeCosmeticsSafely3 = initializeCosmeticsSafely == "table"
        end
        if initializeCosmeticsSafely3 then
            initializeCosmeticsSafely3, initializeCosmeticsSafely, temporary4 = ipairs(initializeCosmeticsSafely4)
            initializeCosmeticsSafely3, initializeCosmeticsSafely, temporary4 = normalizeIterator(initializeCosmeticsSafely3, initializeCosmeticsSafely, temporary4)
            for index4, item4 in initializeCosmeticsSafely3, initializeCosmeticsSafely, temporary4 do
                temporary24, temporary32Ref, temporary4 = index4, item4, index4
                temporary32Ref = {value = temporary32Ref}
                getParryConnectionFunction2 = bind(Handlers.getParryConnectionFunction, temporary32Ref)
                temporary8Ref, getParryConnectionFunction2 = pcall(getParryConnectionFunction2)
                getSwordConnectionFunction = temporary8Ref
                if temporary8Ref then
                    getParryConnectionFunction = type(getParryConnectionFunction2)
                    getSwordConnectionFunction = getParryConnectionFunction == "function"
                end
                if getSwordConnectionFunction then
                    table.insert(cosmetics2.parry_connections, temporary32Ref.value)
                    cosmetics2.play_parry = getParryConnectionFunction2
                end
            end
            temporary24, temporary32Ref, temporary4 = nil, nil, nil
        end
    end
    initializeCosmeticsSafely2 = cosmeticsRef and cosmeticsRef:WaitForChild("FireSwordInfo", 10)
    initializeCosmeticsSafely4 = initializeCosmeticsSafely2
    if initializeCosmeticsSafely2 then
        initializeCosmeticsSafely3 = type(getconnections)
        initializeCosmeticsSafely4 = initializeCosmeticsSafely3 == "function"
    end
    if initializeCosmeticsSafely4 then
        initializeCosmeticsSafely4, initializeCosmeticsSafely3 = pcall(getconnections, initializeCosmeticsSafely2.OnClientEvent)
        initializeCosmeticsSafely = initializeCosmeticsSafely4
        if initializeCosmeticsSafely4 then
            temporary4 = type(initializeCosmeticsSafely3)
            initializeCosmeticsSafely = temporary4 == "table"
        end
        if initializeCosmeticsSafely then
            initializeCosmeticsSafely, temporary4, temporary24 = ipairs(initializeCosmeticsSafely3)
            initializeCosmeticsSafely, temporary4, temporary24 = normalizeIterator(initializeCosmeticsSafely, temporary4, temporary24)
            for index5, item5 in initializeCosmeticsSafely, temporary4, temporary24 do
                temporary32Ref, temporary8Ref, temporary24 = index5, item5, index5
                temporary8Ref = {value = temporary8Ref}
                getSwordConnectionFunction = bind(Handlers.getSwordConnectionFunction, temporary8Ref)
                getParryConnectionFunction2, getSwordConnectionFunction = pcall(getSwordConnectionFunction)
                getParryConnectionFunction = getParryConnectionFunction2
                if getParryConnectionFunction2 then
                    temporary16 = type(getSwordConnectionFunction)
                    getParryConnectionFunction = temporary16 == "function"
                end
                if getParryConnectionFunction then
                    table.insert(cosmetics2.fire_sword_connections, temporary8Ref.value)
                    cosmetics2.sword_fn = getSwordConnectionFunction
                end
            end
            temporary32Ref, temporary8Ref, temporary24 = nil, nil, nil
        end
    end
    setSwordOverrideRef = {
        enabled = false,
        ready = false,
        shop_controller = nil,
        shop_api = nil,
        shop = nil,
        swords = nil
    }
    setSwordOverrideRef.sword_fn = cosmetics2.sword_fn
    setSwordOverrideRef.selected_sword = nil
    setSwordOverrideRef.original_sword = nil
    setSwordOverrideRef.explosion_module = nil
    setSwordOverrideRef.explosion_original = nil
    setSwordOverrideRef.explosion_hooked = false
    setSwordOverrideRef.selected_explosion = nil
    initializeCosmeticsSafely3 = {}
    initializeCosmeticsSafely3, initializeCosmeticsSafely4 = {}, initializeCosmeticsSafely3
    initializeCosmeticsSafely3.__mode = "k"
    initializeCosmeticsSafely2 = setmetatable(initializeCosmeticsSafely4, initializeCosmeticsSafely3)
    setSwordOverrideRef.unlock_originals = initializeCosmeticsSafely2
    initializeCosmeticsSafely4 = {}
    setSwordOverrideRef.unlocked = initializeCosmeticsSafely4
    initializeCosmeticsSafely3 = {}
    initializeCosmeticsSafely4, initializeCosmeticsSafely3 = initializeCosmeticsSafely3, {}
    initializeCosmeticsSafely3.__mode = "k"
    initializeCosmeticsSafely2 = setmetatable(initializeCosmeticsSafely4, initializeCosmeticsSafely3)
    setSwordOverrideRef.shadow_connections = initializeCosmeticsSafely2
    initializeCosmeticsSafely4 = {}
    setSwordOverrideRef.page_connections = initializeCosmeticsSafely4
    initializeCosmeticsSafely4 = {}
    setSwordOverrideRef.refresh_generation = initializeCosmeticsSafely4
    initializeCosmeticsSafely3 = {}
    initializeCosmeticsSafely4, initializeCosmeticsSafely3 = initializeCosmeticsSafely3, {}
    initializeCosmeticsSafely3.__mode = "k"
    initializeCosmeticsSafely2 = setmetatable(initializeCosmeticsSafely4, initializeCosmeticsSafely3)
    setSwordOverrideRef.modern_originals = initializeCosmeticsSafely2
    setSwordOverrideRef.modern_tag = "417_unlock_all"
    setSwordOverrideRef.original_set_equipped = nil
    initializeCosmeticsSafely4 = {}
    setSwordOverrideRef.original_buy_fns = initializeCosmeticsSafely4
    setSwordOverrideRef.parry_connections = cosmetics2.parry_connections
    setSwordOverrideRef.fire_connections = cosmetics2.fire_sword_connections
    setSwordOverrideRef.play_parry = cosmetics2.play_parry
    setSwordOverrideRef.chroma_bound = false
    setSwordOverrideRef.character_connection = nil
    setSwordOverrideRef.added_connection = nil
    setSwordOverrideRef.sword_attr_connection = nil
    cosmeticsRef = {value = setSwordOverrideRef}
    setSwordOverrideRef = bind(Handlers.setSwordOverride)
    cosmeticsRef.value.set_sword_override = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.applyChroma)
    cosmeticsRef.value.apply_chroma = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.isFav, config)
    cosmeticsRef.value.is_fav = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.isDeleted, config)
    cosmeticsRef.value.is_deleted = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.nativeFavMap)
    cosmeticsRef.value.native_fav_map = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.syncFavMap, config)
    cosmeticsRef.value.sync_fav_map = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.slotFavVisual)
    cosmeticsRef.value.slot_fav_visual = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.bindShadow)
    cosmeticsRef.value.bind_shadow = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.refreshShopItem)
    cosmeticsRef.value.refresh_shop_item = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.deleteItem, config, saveConfigRef)
    cosmeticsRef.value.delete_item = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.undeleteItem, config, saveConfigRef)
    cosmeticsRef.value.undelete_item = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.toggleFav, config, saveConfigRef)
    cosmeticsRef.value.toggle_fav = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.refreshFavs)
    cosmeticsRef.value.refresh_favs = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.equipSword, config, swordOverrideEnabledRef, swordOverrideNameRef, localPlayerRef)
    cosmeticsRef.value.equip_sword = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.restoreSword, swordOverrideEnabledRef, swordOverrideNameRef)
    cosmeticsRef.value.restore_sword = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.ensureExplosionHook, cosmeticsRef, localPlayerRef)
    cosmeticsRef.value.ensure_explosion_wrap = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.equipExplosion, config)
    cosmeticsRef.value.equip_explosion = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.refreshVisuals)
    cosmeticsRef.value.refresh_visuals = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.setCategoryUnlock)
    cosmeticsRef.value.set_category_unlock = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.expectedSize, replicatedStorage)
    cosmeticsRef.value.expected_size = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.scheduleRefresh, runService)
    cosmeticsRef.value.schedule_refresh = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.refreshSelected)
    cosmeticsRef.value.refresh_selected = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.setModernUnlock)
    cosmeticsRef.value.set_modern_unlock = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.hookModernShop, cosmeticsRef)
    cosmeticsRef.value.hook_modern_shop = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.hookShop, localPlayerRef)
    cosmeticsRef.value.hook_shop = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.hookSwordEffects, replicatedStorage, localPlayerRef)
    cosmeticsRef.value.hook_sword_fx = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.setupCosmeticCharacter, config)
    cosmeticsRef.value.setup_character = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.hookChroma, localPlayerRef)
    cosmeticsRef.value.hook_chroma = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.initializeCosmeticsController, replicatedStorage, config)
    cosmeticsRef.value.initialize = setSwordOverrideRef
    setSwordOverrideRef = bind(Handlers.setEnabled, config, swordOverrideEnabledRef, saveConfigRef)
    cosmeticsRef.value.set_enabled = setSwordOverrideRef
    if config.unlock_all then
        setSwordOverrideRef, initializeCosmeticsSafely2 = task.spawn, bind(Handlers.initializeCosmeticsSafely, cosmeticsRef)
        setSwordOverrideRef(initializeCosmeticsSafely2)
    end
    setSwordOverrideRef = bind(Handlers.createUiLibrary, localPlayerRef, tweenService)
    setSwordOverrideRef = setSwordOverrideRef()
    setSwordOverrideRef = {value = setSwordOverrideRef}
    if setSwordOverrideRef.value then
        initializeCosmeticsSafely2 = bind(Handlers.buildSettingsWindow, {
            immortalityLabel = immortalityLabel,
            spamPanel = spamPanel,
            curveOptions = curveOptions,
            parrySucceededRef = parrySucceededRef,
            curveOptionsPanelRef = curveOptionsPanelRef2,
            setImmortalityHookRef = setImmortalityHookRef,
            fpsPanelRef = fpsPanelRef,
            deleteConfigAndResetRef = deleteConfigAndResetRef,
            immortalityStroke = immortalityStroke,
            applyOptimizationRef = applyOptimizationRef,
            lastM1StopRef = lastM1StopRef,
            speedDisplayRef = speedDisplayRef,
            ballPresentRef = ballPresentRef,
            keyOptionsPopupRef = keyOptionsPopupRef,
            styleFloatingButtonRef = styleFloatingButtonRef,
            immortalityButtonRef = immortalityButtonRef,
            triggerPanel = triggerPanel,
            trackedBallsRef = trackedBallsRef,
            onKeybindInputBeganRef = onKeybindInputBeganRef,
            saveConfigRef = saveConfigRef,
            parryRemoteRef = parryRemoteRef,
            resetFramePositionsRef = resetFramePositionsRef3,
            ballTargetTimesRef = ballTargetTimesRef,
            applyAppearanceRef = applyAppearanceRef,
            pendingKeybindRef = pendingKeybindRef,
            animationBusyRef = animationBusyRef,
            immortalityPanel = immortalityPanel,
            animationRecentlyPlayedRef = animationRecentlyPlayedRef,
            selectedCurveRef = selectedCurveRef,
            ballCurveStates = ballCurveStates,
            resetFramePositionsRef2 = resetFramePositionsRef2,
            cosmeticsRef = cosmeticsRef,
            curveOptionsOpenRef = curveOptionsOpenRef,
            config = config,
            localPlayerRef = localPlayerRef,
            curvePanelOpenRef = curvePanelOpenRef,
            resetFramePositionsRef3 = resetFramePositionsRef,
            setSwordOverrideRef = setSwordOverrideRef,
            lastTriggerTimeRef = lastTriggerTimeRef,
            ballConnectionsRef = ballConnectionsRef,
            keyCaptureActiveRef = keyCaptureActiveRef,
            refreshCurvePanelRef = refreshCurvePanelRef,
            refreshKeybindPanelRef = refreshKeybindPanelRef,
            keybindPanelRef = keybindPanelRef,
            applyDeviceSpoofRef = applyDeviceSpoofRef
        })
        initializeCosmeticsSafely2()
    end
    applySavedUiStateRef.value()
    return
end

-- ============================================================================
-- Gameplay and event handlers
-- ============================================================================

function Handlers.applyCurveSelection(config, selectedCurveRef, refreshCurvePanelRef)
    local config2, curveType
    curveType = config.curveType
    if not (selectedCurveRef.value == config.curveType) then
        config2, selectedCurveRef.value = config, config.curveType
        config2.curveType = curveType
        refreshCurvePanelRef.value()
    end
    return
end

function Handlers.beginCurveKeyCapture(beginKeyCaptureRef, positionKeybindPanelRef)
    beginKeyCaptureRef.value("curve", positionKeybindPanelRef.value)
    return
end

function Handlers.beginSpamKeyCapture(beginKeyCaptureRef)
    beginKeyCaptureRef.value("spam", nil)
    return
end

function Handlers.beginTriggerKeyCapture(beginKeyCaptureRef)
    beginKeyCaptureRef.value("trigger", nil)
    return
end

function Handlers.calculateCurveTarget(config, localPlayerRef, value)
    local result, angles, alive, temporary4, position, huge, character
    local temporary8, position2, lookAt, temporary11
    character = not config.curveType
    if config.curveType then
        character = config.curveType == "straight"
    end
    if character then
        return value
    end
    if config.curveType == "dot" then
        character = localPlayerRef.value.Character
        angles = localPlayerRef.value.Character and (localPlayerRef.value.Character.PrimaryPart or localPlayerRef.value.Character:FindFirstChild("HumanoidRootPart"))
        if not angles then
            return value
        end
        alive = workspace:FindFirstChild("Alive")
        if not alive then
            return value
        end
        temporary11 = nil
        huge = math.huge
        position2 = packValues(alive:GetChildren())
        lookAt, position2, position = ipairs(unpackValues(position2))
        lookAt, position2, position = normalizeIterator(lookAt, position2, position)
        for index, item in lookAt, position2, position do
            temporary8, temporary4, position = index, item, index
            result = temporary4 ~= character and temporary4:FindFirstChild("HumanoidRootPart")
            if result then
                if (angles.Position - temporary4.HumanoidRootPart.Position).Magnitude < huge then
                    huge, temporary11 = (angles.Position - temporary4.HumanoidRootPart.Position).Magnitude, temporary4
                end
            end
        end
        temporary8, temporary4, position = nil, nil, nil
        if temporary11 then
            lookAt, position2 = CFrame.lookAt, value.Position
            position = temporary11.HumanoidRootPart.Position
            temporary8 = Vector3.new(0, 1.75, 0)
            position = position + temporary8
            lookAt = packValues(lookAt(position2, position))
            return unpackValues(lookAt)
        end
        return value
    end
    character = CFrame.new()
    if config.curveType == "backwards" then
        angles = CFrame.Angles(0, 10313.240312354817, 0)
        character = angles
    else
        if config.curveType == "down" then
            angles = CFrame.Angles(-2578.3100780887044, 0, 0)
            character = angles
        else
            if config.curveType == "up" then
                angles = CFrame.Angles(2578.3100780887044, 0, 0)
                character = angles
            else
                if config.curveType == "left" then
                    angles = CFrame.Angles(0, -5156.620156177409, 0)
                    character = angles
                else
                    if config.curveType == "right" then
                        angles = CFrame.Angles(0, 5156.620156177409, 0)
                        character = angles
                    else
                        if config.curveType == "random" then
                            angles = CFrame.Angles
                            lookAt = math.random()
                            angles = angles(0, lookAt * math.pi * 2, 0)
                            character = angles
                        end
                    end
                end
            end
        end
    end
    return value * character
end

function Handlers.chooseCurveType(refreshCurvePanelRef, curveOptionsPanelRef, saveConfigRef, curveTypeRef, config, curveTypeRef2, curvePanelOpenRef)
    local curveType2, config2
    curveTypeRef.value, curveType2, config2 = curveTypeRef2.value, curveTypeRef2.value, config
    config2.curveType = curveType2
    refreshCurvePanelRef.value()
    curvePanelOpenRef.value, config2 = false, curveOptionsPanelRef.value
    config2.Visible = false
    saveConfigRef.value()
    return
end

function Handlers.clearBallCacheEntry(ballConnectionsRef, ball, remoteConnections, ballCurveStates, ballTargetTimesRef, ballId)
    local ballId2
    ballId2 = ballId
    ballCurveStates[ballId] = nil
    ballTargetTimesRef.value[ballId2] = nil
    ballConnectionsRef.value[ballId2] = nil
    remoteConnections[ball] = nil
    return
end

function Handlers.clearBallCaches(ballTargetTimesRef, ballConnectionsRef, ballCurveStates)
    local result, temporary2, temporary3, temporary4
    temporary2, temporary3, result = pairs(ballTargetTimesRef.value)
    temporary2, temporary3, result = normalizeIterator(temporary2, temporary3, result)
    temporary4 = temporary2(temporary3, result)
    result = temporary4
    if not (temporary4 == nil) then
        while true do
            ballTargetTimesRef.value[temporary4] = nil
            temporary4 = temporary2(temporary3, result)
            result = temporary4
            if temporary4 == nil then
                break
            else
                continue
            end
        end
    end
    temporary2, temporary3, result = pairs(ballConnectionsRef.value)
    temporary2, temporary3, result = normalizeIterator(temporary2, temporary3, result)
    temporary4 = temporary2(temporary3, result)
    result = temporary4
    if not (temporary4 == nil) then
        while true do
            ballConnectionsRef.value[temporary4] = nil
            temporary4 = temporary2(temporary3, result)
            result = temporary4
            if temporary4 == nil then
                break
            else
                continue
            end
        end
    end
    temporary2, temporary3, result = pairs(ballCurveStates)
    temporary2, temporary3, result = normalizeIterator(temporary2, temporary3, result)
    temporary4 = temporary2(temporary3, result)
    result = temporary4
    if not (temporary4 == nil) then
        while true do
            ballCurveStates[temporary4] = nil
            temporary4 = temporary2(temporary3, result)
            result = temporary4
            if temporary4 == nil then
                break
            else
                continue
            end
        end
    end
    return
end

function Handlers.clearCharacterCacheEntry(appearanceCacheRef, character)
    appearanceCacheRef.value[character] = nil
    return
end

function Handlers.clearTrackedBalls(trackedBallsRef)
    local result
    result = {}
    trackedBallsRef.value = result
    return
end

function Handlers.clearTrackedBallTarget(ballConnectionsRef, ballTargetedPlayerRef, ballCurveStates)
    local ballTargetedPlayer2
    ballTargetedPlayer2 = ballTargetedPlayerRef.value
    ballConnectionsRef.value[ballTargetedPlayerRef.value] = nil
    ballCurveStates[ballTargetedPlayer2] = nil
    return
end

function Handlers.connectM1StopEvent(replicatedStorage, lastM1StopRef)
    local m1Stop, event, event2, rememberM1StopTime
    m1Stop = replicatedStorage.Remotes:FindFirstChild("M1Stop")
    if m1Stop then
        event2, rememberM1StopTime = m1Stop.Event, bind(Handlers.rememberM1StopTime, lastM1StopRef)
        event, event2 = event2, event2.Connect
        event2(event, rememberM1StopTime)
    end
    return
end

function Handlers.copyDiscordInvite()
    setclipboard("https://discord.gg/dQ7TNW4Ppb")
    return
end

function Handlers.createKeySystem(tweenService, theme, userInputService, guiParent, accentColor, value, otherValue, otherValue2, otherValue3)
    local tweenServiceRef2, frame, title, uIStroke, copyTextWithFallback, frameRef, uIStroke2
    local uICorner, submit, connectDropdownDrag, uICorner2, position, uICorner3, uICorner4
    local pasteKey, uICorner5, submitKeySystem, tweenServiceRef3, screenGui, screenGuiRef, copyKey
    local uIStroke3
    screenGuiRef = {}
    screenGui = screenGuiRef
    screenGuiRef = Instance.new("ScreenGui")
    screenGuiRef = {value = screenGuiRef}
    frameRef = Instance.new("Frame")
    uICorner2 = Instance.new("UICorner")
    frame = Instance.new("Frame")
    uICorner3 = Instance.new("UICorner")
    title = Instance.new("TextLabel")
    pasteKey = Instance.new("TextBox")
    uIStroke = Instance.new("UIStroke")
    uICorner5 = Instance.new("UICorner")
    copyKey = Instance.new("TextButton")
    uIStroke2 = Instance.new("UIStroke")
    uICorner = Instance.new("UICorner")
    submit = Instance.new("TextButton")
    uIStroke3 = Instance.new("UIStroke")
    uICorner4 = Instance.new("UICorner")
    screenGuiRef.value.Parent = guiParent
    screenGuiRef.value.ResetOnSpawn = false
    screenGuiRef.value.IgnoreGuiInset = true
    screenGuiRef.value.ZIndexBehavior = Enum.ZIndexBehavior.Global
    frameRef.Parent = screenGuiRef.value
    tweenServiceRef3 = Vector2.new(0.5, 0.5)
    frameRef.AnchorPoint = tweenServiceRef3
    frameRef.BackgroundColor3 = theme.Themes.BlackgroundColor
    frameRef.BackgroundTransparency = 0.35
    frameRef.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.5, 0, 0.5, 0)
    frameRef.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0, 0, 0, 0)
    frameRef.Size = tweenServiceRef3
    tweenServiceRef3 = UDim.new(0, 12)
    uICorner2.CornerRadius = tweenServiceRef3
    uICorner2.Parent = frameRef
    frame.Parent = frameRef
    frame.BackgroundColor3 = theme.Themes.BlackColor
    frame.BackgroundTransparency = 0.45
    frame.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(-0.00109238492, 0, 0.081521742, 0)
    frame.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(1, 0, 0.913586974, 0)
    frame.Size = tweenServiceRef3
    frame.ZIndex = 2
    tweenServiceRef3 = UDim.new(0, 10)
    uICorner3.CornerRadius = tweenServiceRef3
    uICorner3.Parent = frame
    title.Name = "Title"
    title.Parent = frameRef
    tweenServiceRef3 = Vector2.new(0.5, 0)
    title.AnchorPoint = tweenServiceRef3
    title.BackgroundTransparency = 1
    title.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.5, 0, 0.143000007, 0)
    title.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0.899999976, 0, 0.150000006, 0)
    title.Size = tweenServiceRef3
    title.ZIndex = 4
    title.Font = Enum.Font.SourceSansBold
    tweenServiceRef3 = otherValue or "Key System"
    title.Text = tweenServiceRef3
    title.TextColor3 = accentColor
    title.TextScaled = true
    title.TextSize = 14
    title.TextStrokeColor3 = accentColor
    title.TextStrokeTransparency = 0.86
    title.TextWrapped = true
    pasteKey.Name = "PasteKey"
    pasteKey.Parent = frameRef
    tweenServiceRef3 = Vector2.new(0.5, 0)
    pasteKey.AnchorPoint = tweenServiceRef3
    pasteKey.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    pasteKey.BackgroundTransparency = 0.5
    pasteKey.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.50000006, 0, 0.373641312, 0)
    pasteKey.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0.899999976, 0, 0.25, 0)
    pasteKey.Size = tweenServiceRef3
    pasteKey.ZIndex = 4
    pasteKey.ClearTextOnFocus = false
    pasteKey.Font = Enum.Font.SourceSansSemibold
    pasteKey.Text = ""
    tweenServiceRef3 = Color3.fromRGB(255, 255, 255)
    pasteKey.TextColor3 = tweenServiceRef3
    pasteKey.TextScaled = true
    pasteKey.TextSize = 14
    pasteKey.TextTransparency = 0.39
    pasteKey.TextWrapped = true
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = pasteKey
    tweenServiceRef3 = UDim.new(0, 8)
    uICorner5.CornerRadius = tweenServiceRef3
    uICorner5.Parent = pasteKey
    copyKey.Name = "CopyKey"
    copyKey.Parent = frameRef
    copyKey.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    copyKey.BackgroundTransparency = 0.55
    copyKey.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.0489396416, 0, 0.754076123, 0)
    copyKey.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0.42039147, 0, 0.182608709, 0)
    copyKey.Size = tweenServiceRef3
    copyKey.ZIndex = 5
    copyKey.Font = Enum.Font.SourceSansBold
    copyKey.Text = "Get Key"
    copyKey.TextColor3 = accentColor
    copyKey.TextScaled = true
    copyKey.TextSize = 14
    copyKey.TextWrapped = true
    uIStroke2.Color = accentColor
    uIStroke2.Transparency = 0.5
    uIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke2.Parent = copyKey
    tweenServiceRef3 = UDim.new(1, 0)
    uICorner.CornerRadius = tweenServiceRef3
    uICorner.Parent = copyKey
    submit.Name = "Submit"
    submit.Parent = frameRef
    submit.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    submit.BackgroundTransparency = 0.55
    submit.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.517944396, 0, 0.754076123, 0)
    submit.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0.428548098, 0, 0.182608709, 0)
    submit.Size = tweenServiceRef3
    submit.ZIndex = 5
    submit.Font = Enum.Font.SourceSansBold
    submit.Text = "Submit"
    submit.TextColor3 = accentColor
    submit.TextScaled = true
    submit.TextSize = 14
    submit.TextWrapped = true
    uIStroke3.Color = accentColor
    uIStroke3.Transparency = 0.5
    uIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke3.Parent = submit
    tweenServiceRef3 = UDim.new(1, 0)
    uICorner4.CornerRadius = tweenServiceRef3
    uICorner4.Parent = submit
    copyTextWithFallback, tweenServiceRef3 = frameRef, tweenService
    connectDropdownDrag = TweenInfo.new(0.4, Enum.EasingStyle.Quint)
    submitKeySystem = {}
    position = UDim2.new(0.25, 0, 0.25, 0)
    submitKeySystem.Size = position
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Create
    tweenServiceRef3 = tweenServiceRef3(tweenServiceRef2, copyTextWithFallback, connectDropdownDrag, submitKeySystem)
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Play
    tweenServiceRef3(tweenServiceRef2)
    copyTextWithFallback, tweenServiceRef3 = bind(Handlers.copyTextWithFallback, otherValue2), copyKey.MouseButton1Click
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Connect
    tweenServiceRef3(tweenServiceRef2, copyTextWithFallback)
    tweenServiceRef3 = {value = false}
    tweenServiceRef2 = {value = nil}
    submitKeySystem, copyTextWithFallback = bind(Handlers.submitKeySystem, tweenService, tweenServiceRef2, screenGuiRef, tweenServiceRef3, pasteKey, otherValue3, frameRef), submit.MouseButton1Click
    connectDropdownDrag, copyTextWithFallback = copyTextWithFallback, copyTextWithFallback.Connect
    copyTextWithFallback(connectDropdownDrag, submitKeySystem)
    connectDropdownDrag, copyTextWithFallback = bind(Handlers.connectDropdownDrag, frameRef, userInputService), task.spawn
    copyTextWithFallback(connectDropdownDrag)
    copyTextWithFallback = bind(Handlers.rememberMousePosition, tweenServiceRef2)
    screenGui.Callback = copyTextWithFallback
    return screenGui
end

function Handlers.delete(tabTitle, self)
    tabTitle:Destroy()
    return
end

function Handlers.deleteItem(config, saveConfigRef, self, category, itemName)
    local deletedSwords, temporary2
    if category == "Sword" then
        deletedSwords = config.deleted_swords
        if not config.deleted_swords then
            temporary2 = {}
            deletedSwords = temporary2
        end
        config.deleted_swords = deletedSwords
        config.deleted_swords[itemName] = true
        if config.favorite_swords then
            config.favorite_swords[itemName] = nil
        end
        if self.selected_sword == itemName then
            self:restore_sword()
        end
    else
        if category == "Explosion" then
            deletedSwords = config.deleted_explosions
            if not config.deleted_explosions then
                temporary2 = {}
                deletedSwords = temporary2
            end
            config.deleted_explosions = deletedSwords
            config.deleted_explosions[itemName] = true
            if config.favorite_explosions then
                config.favorite_explosions[itemName] = nil
            end
            if self.selected_explosion == itemName then
                self.selected_explosion = nil
            end
        end
    end
    pcall(saveConfigRef.value)
    self:sync_fav_map(category)
    if self.shop_controller then
        self:refresh_shop_item(category, itemName, false)
    end
    self:refresh_selected()
    return
end

function Handlers.destroyCapturedInstance(instance)
    instance:Destroy()
    return
end

function Handlers.disableAndDestroyEffect(delayRef)
    local destroy, destroy2
    destroy = delayRef.value and delayRef.value.Parent
    if destroy then
        destroy = delayRef.value
        delayRef.value.Enabled = false
        destroy, destroy2 = destroy.Destroy, destroy
        destroy(destroy2)
    end
    return
end

function Handlers.disconnectCharacterWatcher(cosmetics)
    cosmetics.character_connection:Disconnect()
    return
end

function Handlers.encodeParryTimestamp(cipherKeyBytes, cipherKeyLengthRef, cipherBufferRef)
    local cipherBuffer2, cipherKeyBytes2, temporary3, temporary4, floor, cipherKeyLength2, bxor
    local temporary8, char
    floor = math.floor
    cipherKeyBytes2 = workspace:GetServerTimeNow()
    cipherKeyBytes2 = cipherKeyBytes2 * 100
    floor = packValues(floor(cipherKeyBytes2))
    temporary8 = tostring(unpackValues(floor))
    cipherBuffer2, cipherKeyBytes2, cipherKeyLength2 = cipherBufferRef.value, cipherKeyBytes, cipherKeyLengthRef.value
    temporary4 = 1
    if not (#temporary8 ~= #temporary8) then
        if not (1 > #temporary8) then
            while true do
                char = string.char
                bxor = bit32.bxor
                temporary3 = string.byte(temporary8, temporary4)
                bxor = packValues(bxor((temporary3 + temporary4) % 256, cipherKeyBytes2[(temporary4 - 1) % cipherKeyLength2 + 1]))
                char = char(unpackValues(bxor))
                cipherBuffer2[temporary4] = char
                temporary4 = temporary4 + 1
                if temporary4 > #temporary8 then
                    break
                else
                    continue
                end
            end
        end
    end
    temporary4 = packValues(table.concat(cipherBuffer2, "", 1, #temporary8))
    return unpackValues(temporary4)
end

function Handlers.expectedSize(replicatedStorage, self, otherValue)
    local result, temporary2, temporary3, temporary4, temporary5, misc, misc2
    local getSwordCollection, temporary9
    temporary4 = 0
    misc2 = otherValue == "Sword" and self.swords
    if misc2 then
        getSwordCollection = bind(Handlers.getSwordCollection, self)
        misc2, getSwordCollection = pcall(getSwordCollection)
        misc = misc2
        if misc2 then
            temporary5 = type(getSwordCollection)
            misc = temporary5 == "table"
        end
        if misc then
            misc, temporary5, temporary3 = pairs(getSwordCollection)
            misc, temporary5, temporary3 = normalizeIterator(misc, temporary5, temporary3)
            temporary2 = misc(temporary5, temporary3)
            temporary3 = temporary2
            if not (temporary2 == nil) then
                while true do
                    temporary4 = temporary4 + 1
                    temporary2 = misc(temporary5, temporary3)
                    temporary3 = temporary2
                    if temporary2 == nil then
                        break
                    else
                        continue
                    end
                end
            end
        end
    else
        if otherValue == "Explosion" then
            misc2 = replicatedStorage:FindFirstChild("Misc")
            getSwordCollection = misc2 and misc2:FindFirstChild("DataExplosions")
            if getSwordCollection then
                temporary5 = packValues(getSwordCollection:GetChildren())
                misc, temporary5, temporary3 = ipairs(unpackValues(temporary5))
                misc, temporary5, temporary3 = normalizeIterator(misc, temporary5, temporary3)
                for index, item in misc, temporary5, temporary3 do
                    temporary2, result, temporary3 = index, item, index
                    temporary9 = result:GetAttribute("Hidden")
                    if not temporary9 then
                        temporary4 = temporary4 + 1
                    end
                end
                temporary2, result, temporary3 = nil, nil, nil
            end
        end
    end
    return temporary4
end

function Handlers.expireSpamHistory(spamHistory, spamCountRef)
    local result, temporary2
    while true do
        temporary2 = tick()
        result = 1
        while true do
            if result <= #spamHistory then
                if temporary2 >= spamHistory[result] then
                    table.remove(spamHistory, result)
                    if spamCountRef.value > 0 then
                        spamCountRef.value = spamCountRef.value - 1
                        continue
                    else
                        continue
                    end
                else
                    result = result + 1
                    continue
                end
            else
                break
            end
        end
        task.wait(0.1)
    end
end

function Handlers.fadeSpamStrokeOut(tweenService, spamKeyButtonRef)
    local tweenService2, spamKeyButton2, temporary3, tweenService3, tweenInfo
    spamKeyButton2, tweenService3 = spamKeyButtonRef.value, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary3 = {}
    temporary3.Transparency = 0.3
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, spamKeyButton2, tweenInfo, temporary3)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    return
end

function Handlers.fadeStrokeIn(tweenService, triggerKeyButtonRef)
    local tweenService2, tweenInfo, tweenService3, triggerKeyButton2, temporary5
    triggerKeyButton2, tweenService3 = triggerKeyButtonRef.value, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary5 = {}
    temporary5.Transparency = 0.3
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, triggerKeyButton2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    return
end

function Handlers.fadeStrokeOut(tweenService, uICornerRef)
    local tweenInfo, uICorner2, temporary3, tweenService2, tweenService3
    tweenService3, uICorner2 = tweenService, uICornerRef.value
    tweenInfo = TweenInfo.new(0.2)
    temporary3 = {}
    temporary3.Transparency = 0
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, uICorner2, tweenInfo, temporary3)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    return
end

function Handlers.fadeStrokeOutOnHover(tweenService, triggerKeyButtonRef)
    local tweenInfo, tweenService2, triggerKeyButton2, temporary4, tweenService3
    tweenService3, triggerKeyButton2 = tweenService, triggerKeyButtonRef.value
    tweenInfo = TweenInfo.new(0.2)
    temporary4 = {}
    temporary4.Transparency = 0.6
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, triggerKeyButton2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    return
end

function Handlers.fadeTriggerStrokeIn(tweenService, triggerKeyButtonRef)
    local tweenService2, tweenService3, triggerKeyButton2, temporary4, tweenInfo
    tweenService2, triggerKeyButton2 = tweenService, triggerKeyButtonRef.value
    tweenInfo = TweenInfo.new(0.2)
    temporary4 = {}
    temporary4.Transparency = 0
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, triggerKeyButton2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    return
end

function Handlers.findBall()
    local findRealBallInFolder, temporary2, temporary3Ref
    temporary3Ref = {value = 0}
    findRealBallInFolder = bind(Handlers.findRealBallInFolder, temporary3Ref)
    temporary2 = packValues(workspace:FindFirstChild("Balls"))
    findRealBallInFolder(unpackValues(temporary2))
    temporary2 = packValues(workspace:FindFirstChild("TrainingBalls"))
    findRealBallInFolder(unpackValues(temporary2))
    return temporary3Ref.value
end

function Handlers.findBallInChildren(ballPresentRef, value)
    local result, temporary2, temporary3, temporary4, temporary5, ballPresent2
    ballPresent2 = not value
    if value then
        ballPresent2 = ballPresentRef.value
    end
    if ballPresent2 then
        return
    end
    temporary4 = packValues(value:GetChildren())
    ballPresent2, temporary4, temporary5 = ipairs(unpackValues(temporary4))
    ballPresent2, temporary4, temporary5 = normalizeIterator(ballPresent2, temporary4, temporary5)
    result, temporary2 = ballPresent2(temporary4, temporary5)
    temporary5 = result
    if not (result == nil) then
        while true do
            temporary3 = temporary2:GetAttribute("realBall")
            if temporary3 then
                ballPresentRef.value = true
                return
            end
            result, temporary2 = ballPresent2(temporary4, temporary5)
            temporary5 = result
            if result == nil then
                return
            end
        end
    end
    return
end

function Handlers.findRealBallInFolder(magnitudeRef, value)
    local result, temporary2, temporary3, temporary4, temporary5, zoomies, temporary7
    local temporary8, temporary9
    if not value then
        return
    end
    temporary3 = packValues(value:GetChildren())
    result, temporary3, temporary4 = pairs(unpackValues(temporary3))
    result, temporary3, temporary4 = normalizeIterator(result, temporary3, temporary4)
    for index, item in result, temporary3, temporary4 do
        temporary9, temporary2, temporary4 = index, item, index
        zoomies = temporary2:GetAttribute("realBall")
        if zoomies then
            zoomies = temporary2:FindFirstChild("zoomies")
            temporary8 = zoomies and zoomies.VectorVelocity.Magnitude > magnitudeRef.value
            if temporary8 then
                magnitudeRef.value = zoomies.VectorVelocity.Magnitude
            end
            temporary8 = temporary2:GetAttribute("Velocity")
            temporary5 = typeof(temporary8)
            temporary7 = temporary5 == "Vector3" and temporary8.Magnitude > magnitudeRef.value
            if temporary7 then
                magnitudeRef.value = temporary8.Magnitude
            end
        end
    end
    temporary9, temporary2, temporary4 = nil, nil, nil
    return
end

function Handlers.finishParryAnimationCooldown(animationRecentlyPlayedRef, playParryAnimationRef, parrySucceededRef, animationBusyRef)
    local wait, temporary2
    animationBusyRef.value = false
    wait = task.wait
    temporary2 = packValues(math.max(0.1, 0.3 - playParryAnimationRef.value))
    wait(unpackValues(temporary2))
    if not parrySucceededRef.value then
        animationRecentlyPlayedRef.value = false
    end
    return
end

function Handlers.fire(buttonRef, self, ...)
    local result, button2
    button2, result = buttonRef.value, packValues(...)
    button2(unpackValues(result))
    return
end

function Handlers.fireAbility(replicatedStorage)
    replicatedStorage.Remotes.AbilityButtonPress:Fire()
    return
end

function Handlers.get(noopDropdownRef, self)
    return noopDropdownRef.value
end

function Handlers.getBallCurveState(remoteConnections, ballTargetTimesRef, ballConnectionsRef, ballCurveStates, ball)
    local result, onBallCurveTargetChanged, temporary3, ballCurveStates2, ballCurveStates3
    temporary3 = ball:GetDebugId()
    if not ballCurveStates[temporary3] then
        onBallCurveTargetChanged, ballCurveStates2 = {}, ballCurveStates
        onBallCurveTargetChanged.lerp_radians = 0
        onBallCurveTargetChanged.last_warping = 0
        result = tick()
        onBallCurveTargetChanged.curving = result
        ballCurveStates2[temporary3] = onBallCurveTargetChanged
        ballCurveStates2 = ball:GetAttributeChangedSignal("target")
        onBallCurveTargetChanged = bind(Handlers.onBallCurveTargetChanged, ballTargetTimesRef, temporary3, ballCurveStates)
        ballCurveStates2, ballCurveStates3 = ballCurveStates2.Connect, ballCurveStates2
        ballCurveStates2(ballCurveStates3, onBallCurveTargetChanged)
        ballCurveStates2, onBallCurveTargetChanged = ball.Destroying, bind(Handlers.clearBallCacheEntry, ballConnectionsRef, ball, remoteConnections, ballCurveStates, ballTargetTimesRef, temporary3)
        ballCurveStates3, ballCurveStates2 = ballCurveStates2, ballCurveStates2.Connect
        ballCurveStates2(ballCurveStates3, onBallCurveTargetChanged)
    end
    return ballCurveStates[temporary3]
end

function Handlers.getCachedPing(lastPingReadRef, stats, cachedPingRef)
    local result, readNetworkPing, temporary3, temporary4
    temporary3 = tick()
    if temporary3 - lastPingReadRef.value >= 0.1 then
        readNetworkPing, lastPingReadRef.value = bind(Handlers.readNetworkPing, stats), temporary3
        temporary4, readNetworkPing = pcall(readNetworkPing)
        result = temporary4 and readNetworkPing
        if result then
            cachedPingRef.value = readNetworkPing
        end
    end
    return cachedPingRef.value
end

function Handlers.getParryConnectionFunction(connectionRef)
    return connectionRef.value.Function
end

function Handlers.hide(lay, header, uIStroke, tweenService, tweenServiceRef2, sectionRef, self)
    local tweenService2, position, tweenInfo, tweenService3, temporary5, section2
    section2, tweenService2 = sectionRef.value, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary5 = {}
    position = UDim2.new(0.97, 0, 0, 1)
    temporary5.Size = position
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, section2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    tweenServiceRef2.value = false
    section2, tweenService2 = lay, tweenService
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.BackgroundTransparency = 1
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, section2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    tweenService2 = tweenService
    section2 = sectionRef.value
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.BackgroundTransparency = 1
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, section2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    section2, tweenService2 = uIStroke, tweenService
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.Transparency = 1
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, section2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    section2, tweenService2 = header, tweenService
    tweenInfo = TweenInfo.new(0.3)
    temporary5 = {}
    temporary5.TextTransparency = 1
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, section2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    return
end

function Handlers.interceptFireServer(parryRemoteRef, originalFireServerRef, value, ...)
    local result, originalFireServer2, originalFireServer3, temporary4
    if parryRemoteRef.value then
        temporary4, originalFireServer2 = packValues(...), originalFireServerRef.value
        originalFireServer2 = packValues(originalFireServer2(value, unpackValues(temporary4)))
        return unpackValues(originalFireServer2)
    end
    temporary4, originalFireServer3 = packValues(...), {}
    setRange(originalFireServer3, 1, unpackValues(temporary4))
    originalFireServer2 = originalFireServer3
    originalFireServer3 = #originalFireServer3 == 8
    if originalFireServer3 then
        temporary4 = typeof(originalFireServer2[5])
        originalFireServer3 = temporary4 == "CFrame"
    end
    if originalFireServer3 then
        parryRemoteRef.value = value
    end
    originalFireServer3, result = originalFireServerRef.value, packValues(...)
    originalFireServer3 = packValues(originalFireServer3(value, unpackValues(result)))
    return unpackValues(originalFireServer3)
end

function Handlers.invokeSelectedAction(resetFramePositionsRef)
    resetFramePositionsRef.value()
    return
end

function Handlers.isBallCurving(getBallCurveStateRef, value, otherValue, otherValue2, otherValue3, otherValue4, otherValue5)
    local rad, temporary2, temporary3, temporary4, temporary5, unit, temporary7
    local temporary8, unit2, temporary10, temporary11
    temporary7 = not value
    if value then
        temporary7 = not otherValue
    end
    if temporary7 then
        return false
    end
    temporary7 = getBallCurveStateRef.value(value)
    unit2 = otherValue.Unit
    unit = (otherValue4 - value.Position).Unit
    temporary11 = (otherValue4 - value.Position).Unit:Dot(otherValue.Unit)
    temporary8 = math.min(otherValue2 / 100, 40)
    temporary2 = unit:Dot((unit2 - otherValue).Unit)
    temporary5 = math.min(otherValue3 / 1000, 15)
    temporary4 = 15 - temporary5 + temporary8
    temporary10 = math.clamp(temporary11, -1, 1)
    rad = math.rad
    temporary5 = packValues(math.asin(temporary10))
    rad = rad(unpackValues(temporary5))
    temporary7.lerp_radians = temporary7.lerp_radians + (rad - temporary7.lerp_radians) * 0.8
    temporary5 = otherValue2 > 0 and otherValue3 / otherValue2 - otherValue5 / 1000 > otherValue5 / 10
    if temporary5 then
        temporary5 = math.max(temporary4 - 15, 15)
        temporary4 = temporary5
    end
    if otherValue3 < temporary4 then
        return false
    end
    if temporary11 - temporary2 < 0.5 - otherValue5 / 1000 then
        return true
    end
    if temporary7.lerp_radians < 0.018 then
        temporary5 = tick()
        temporary7.last_warping = temporary5
    end
    temporary3 = tick()
    if temporary3 - temporary7.last_warping < (otherValue3 / otherValue2 - otherValue5 / 1000) / 1.5 then
        return true
    end
    temporary3 = tick()
    if temporary3 - temporary7.curving < (otherValue3 / otherValue2 - otherValue5 / 1000) / 1.5 then
        return true
    end
    return false
end

function Handlers.isLocalPlayerAlive(localPlayerRef)
    local humanoid, alive, temporary3
    if not localPlayerRef.value.Character then
        return false
    end
    humanoid = localPlayerRef.value.Character:FindFirstChildOfClass("Humanoid")
    alive = not humanoid
    if humanoid then
        alive = humanoid.Health <= 0
    end
    if alive then
        return false
    end
    alive = localPlayerRef.value:GetAttribute("LobbyTraining")
    if alive then
        return true
    end
    alive = workspace:FindFirstChild("Alive")
    if not alive then
        return false
    end
    temporary3 = alive:FindFirstChild(localPlayerRef.value.Name)
    if not temporary3 then
        return false
    end
    return true
end

function Handlers.isParryBlocked(localPlayerRef, debugFlags)
    local result, character, temporary3, temporary4, temporary5
    temporary5 = false
    character = localPlayerRef.value.Character
    if not localPlayerRef.value.Character then
        return false
    end
    temporary4 = localPlayerRef.value.Character:GetAttribute("Stunned")
    if temporary4 then
        temporary5 = true
    end
    temporary4 = localPlayerRef.value:GetAttribute("LobbyTraining") and (character.Parent == workspace.Dead and true or false)
    result = character.Parent ~= workspace.Alive
    if character.Parent ~= workspace.Alive then
        temporary3 = debugFlags.LobbyParry or (localPlayerRef.value:GetAttribute("LobbyParry") or temporary4)
        result = not temporary3
    end
    if result then
        temporary5 = true
    end
    result = localPlayerRef.value.Upgrades and localPlayerRef.value.Upgrades["Qi-Charge"]
    temporary3 = character:GetAttribute("DoNotParry") or character:GetAttribute("ChargingAdrenaline") and result and result.Value < 2
    if temporary3 then
        temporary5 = true
    end
    temporary3 = localPlayerRef.value:GetAttribute("LobbyParry") and localPlayerRef.value:GetAttribute("InLobbyParryCooldown")
    if temporary3 then
        temporary5 = true
    end
    return temporary5
end

function Handlers.keepScreenGuiEnabled(screenGui)
    if not screenGui.Enabled then
        screenGui.Enabled = true
    end
    return
end

function Handlers.loadAnimationTrack(shopControllerApiRef, animationRef, grabParryRef)
    local result
    result = packValues(shopControllerApiRef.value:LoadAnimation(animationRef.value, grabParryRef.value, true))
    return unpackValues(result)
end

function Handlers.loadPlayerAvatarThumbnail(userImage, localPlayerRef)
    local userImage2, players, players2
    userImage2 = userImage
    players = game:GetService("Players")
    players, players2 = players.GetUserThumbnailAsync, players
    players = players(players2, localPlayerRef.value.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    userImage2.Image = players
    return
end

function Handlers.markParrySuccessCooldown(parrySucceededRef)
    parrySucceededRef.value = true
    task.wait(0.3)
    parrySucceededRef.value = false
    return
end

function Handlers.noopKeySystem()
    return
end

function Handlers.onBallCurveTargetChanged(ballTargetTimesRef, ballId, ballCurveStates)
    local ballId2, temporary2, temporary3
    ballTargetTimesRef.value[ballId] = nil
    if ballCurveStates[ballId] then
        ballId2 = ballId
        ballCurveStates[ballId].lerp_radians = 0
        temporary2 = ballCurveStates[ballId2]
        temporary3 = tick()
        temporary2.curving = temporary3
    end
    return
end

function Handlers.onCharacterAdded(applyAppearanceRef, appearanceCacheRef, value)
    local applyCapturedAppearance, delay, applyConfigToWorld
    applyCapturedAppearance, delay = bind(Handlers.applyCapturedAppearance, applyAppearanceRef, value), task.delay
    delay(0.6, applyCapturedAppearance)
    applyCapturedAppearance, delay, applyConfigToWorld = bind(Handlers.clearCharacterCacheEntry, appearanceCacheRef, value), value.Destroying.Connect, value.Destroying
    delay(applyConfigToWorld, applyCapturedAppearance)
    applyConfigToWorld, delay = bind(Handlers.applyConfigToWorld), task.defer
    delay(applyConfigToWorld)
    return
end

function Handlers.onKeySystemInputChanged(tweenServiceRef, updateNotificationDragRef, value)
    local result
    result = value.UserInputType == Enum.UserInputType.MouseMovement or value.UserInputType == Enum.UserInputType.Touch
    if result then
        if tweenServiceRef.value then
            updateNotificationDragRef.value(value)
        end
    end
    return
end

function Handlers.onParryingChanged(character, parryCooldownRef)
    local result, parryCooldown2, temporary3
    temporary3 = character:GetAttribute("Parrying")
    parryCooldown2 = parryCooldownRef.value.last_parrying == true and temporary3 == false
    if parryCooldown2 then
        parryCooldown2 = parryCooldownRef.value
        result = tick()
        parryCooldown2.failed_at = result
    else
        parryCooldown2 = temporary3 == nil or temporary3 == true
        if parryCooldown2 then
            parryCooldownRef.value.failed_at = 0
        end
    end
    parryCooldownRef.value.last_parrying = temporary3
    return
end

function Handlers.onParrySucceeded(parrySucceededRef, shopControllerApiRef, stopAnimationRef, config, animationBusyRef, animationRecentlyPlayedRef, localPlayerRef)
    local result, spawn, temporary3, markParrySuccessCooldown, temporary5, temporary6, temporary7
    local temporary8
    if not config.animfix then
        return
    end
    animationRecentlyPlayedRef.value, animationBusyRef.value = false, false
    spawn, markParrySuccessCooldown = task.spawn, bind(Handlers.markParrySuccessCooldown, parrySucceededRef)
    spawn(markParrySuccessCooldown)
    spawn = localPlayerRef.value.Character and localPlayerRef.value.Character:FindFirstChildOfClass("Humanoid")
    if not spawn then
        return
    end
    markParrySuccessCooldown = spawn:FindFirstChildOfClass("Animator") or spawn:FindFirstChild("Animator")
    if not markParrySuccessCooldown then
        return
    end
    if shopControllerApiRef.value then
        temporary6 = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(markParrySuccessCooldown))
        temporary5, temporary6, temporary8 = pairs(unpackValues(temporary6))
        temporary5, temporary6, temporary8 = normalizeIterator(temporary5, temporary6, temporary8)
        for index, item in temporary5, temporary6, temporary8 do
            temporary7, result, temporary8 = index, item, index
            temporary3 = result:GetAttribute("GrabParry")
            if temporary3 then
                pcall(stopAnimationRef.value, result)
            end
        end
        temporary7, result, temporary8 = nil, nil, nil
    end
    return
end

function Handlers.onPreSimulation(parryRemoteRef, isPlayerAliveRef, sendParryRef, ballPresentRef, ballTargetedPlayerRef, config, watchBallPresenceRef, tryParryAnimationRef, value)
    local result, cps, config2
    cps = ballPresentRef.value and not config.spamParry
    if cps then
        ballPresentRef.value = false
    end
    config2 = (ballTargetedPlayerRef.value or ballPresentRef.value) and parryRemoteRef.value
    if not config2 then
        watchBallPresenceRef.value = 0
        return
    end
    config2 = isPlayerAliveRef.value()
    if not config2 then
        watchBallPresenceRef.value = 0
        return
    end
    if config.animfix then
        tryParryAnimationRef.value()
    end
    cps = value > 0.05 or value < 0
    if cps then
        value = 0
    end
    config2, watchBallPresenceRef.value = config, watchBallPresenceRef.value + value
    cps = config2.cps
    if config2.cps <= 0 then
        return
    end
    config2 = math.floor(watchBallPresenceRef.value * config2.cps)
    if config2 <= 0 then
        return
    end
    watchBallPresenceRef.value = watchBallPresenceRef.value - config2 / cps
    if watchBallPresenceRef.value < 0 then
        watchBallPresenceRef.value = 0
    end
    if config2 > 10 then
        config2 = 10
    end
    result = 1
    if not (config2 ~= config2) then
        if not (1 > config2) then
            while true do
                sendParryRef.value()
                result = result + 1
                if result > config2 then
                    break
                else
                    continue
                end
            end
        end
    end
    if config2 >= 10 then
        result = math.min(watchBallPresenceRef.value, 0.5 / cps)
        watchBallPresenceRef.value = result
    end
    return
end

function Handlers.onRemoteBallUpdate(remoteConnections, ball, position)
    local result, temporary2
    result = ball and position
    if result then
        temporary2 = typeof(position)
        result = temporary2 == "Vector3"
    end
    if result then
        temporary2 = ball:GetAttribute("realBall")
        result = temporary2 == true
    end
    if result then
        remoteConnections[ball] = position
    end
    return
end

function Handlers.parentScreenGui(screenGuiRef, coreGui)
    screenGuiRef.value.Parent = coreGui
    return
end

function Handlers.playAnimationTrack(playerDataRef, value)
    local result, temporary2, temporary3, temporary4, temporary5
    temporary4 = playerDataRef.value and playerDataRef.value:Get("timesParried") or 0
    result = temporary4 and temporary4 >= 0 and temporary4 <= 4 and true or false
    temporary5 = result and 0.05 or value:GetAttribute("PlayFadeTime")
    temporary3 = result and 1 or value:GetAttribute("PlayWeight")
    temporary2 = result and temporary4 / 5 + 1 or value:GetAttribute("PlaySpeed")
    value:Play(temporary5, temporary3, temporary2)
    return
end

-- Choose and play the equipped sword parry animation.
function Handlers.playParryAnimation(swordOverrideEnabledRef, resolveParryAnimationRef, shopControllerApiRef, stopAnimationRef, localPlayerRef, playAnimationRef, swordOverrideNameRef, swordAPIRef, config, isParryBlockedRef)
    local grabParry, temporary2Ref, temporary3, grabParryRef, temporary5, swordOverrideName2, temporary7
    local temporary8, loadAnimationTrack, temporary10
    if not config.animfix then
        return
    end
    if isParryBlockedRef.value then
        temporary10, temporary2Ref = pcall(isParryBlockedRef.value)
        swordOverrideName2 = temporary10 and temporary2Ref
        if swordOverrideName2 then
            return
        end
        temporary10 = localPlayerRef.value.Character and localPlayerRef.value.Character:FindFirstChildOfClass("Humanoid")
        if not temporary10 then
            return
        end
        temporary2Ref = temporary10:FindFirstChildOfClass("Animator") or temporary10:FindFirstChild("Animator")
        temporary2Ref = {value = temporary2Ref}
        if not temporary2Ref.value then
            return
        end
        if swordOverrideEnabledRef.value then
            if swordOverrideNameRef.value ~= "" then
                swordOverrideName2 = swordOverrideNameRef.value
            else
                if not localPlayerRef.value.Character then
                    return
                end
                grabParry = localPlayerRef.value.Character:GetAttribute("CurrentlyEquippedSword")
                grabParryRef = resolveParryAnimationRef.value(grabParry)
                grabParryRef = {value = grabParryRef}
                if not grabParryRef.value then
                    grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
                    grabParryRef.value = grabParry
                    if not grabParryRef.value then
                        return
                    end
                    if shopControllerApiRef.value then
                        loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                        grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                        grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                        for index, item in grabParry, loadAnimationTrack, temporary3 do
                            temporary5, temporary8, temporary3 = index, item, index
                            temporary7 = temporary8:GetAttribute("SuccessParry")
                            if temporary7 then
                                pcall(stopAnimationRef.value, temporary8)
                            end
                        end
                        temporary5, temporary8, temporary3 = nil, nil, nil
                        loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                        grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                        temporary3 = grabParry and loadAnimationTrack
                        if temporary3 then
                            playAnimationRef.value(loadAnimationTrack)
                        end
                    else
                        grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                        grabParry.Priority = Enum.AnimationPriority.Action4
                        grabParry:Play(0, 1, 1)
                    end
                    return
                end
                if shopControllerApiRef.value then
                    loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                    grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                    grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                    for index2, item2 in grabParry, loadAnimationTrack, temporary3 do
                        temporary5, temporary8, temporary3 = index2, item2, index2
                        temporary7 = temporary8:GetAttribute("SuccessParry")
                        if temporary7 then
                            pcall(stopAnimationRef.value, temporary8)
                        end
                    end
                    temporary5, temporary8, temporary3 = nil, nil, nil
                    loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                    grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                    temporary3 = grabParry and loadAnimationTrack
                    if temporary3 then
                        playAnimationRef.value(loadAnimationTrack)
                    end
                else
                    grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                    grabParry.Priority = Enum.AnimationPriority.Action4
                    grabParry:Play(0, 1, 1)
                end
                return
            end
            grabParryRef = resolveParryAnimationRef.value(swordOverrideName2)
            grabParryRef = {value = grabParryRef}
            if not grabParryRef.value then
                grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
                grabParryRef.value = grabParry
                if not grabParryRef.value then
                    return
                end
                if shopControllerApiRef.value then
                    loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                    grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                    grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                    for index3, item3 in grabParry, loadAnimationTrack, temporary3 do
                        temporary5, temporary8, temporary3 = index3, item3, index3
                        temporary7 = temporary8:GetAttribute("SuccessParry")
                        if temporary7 then
                            pcall(stopAnimationRef.value, temporary8)
                        end
                    end
                    temporary5, temporary8, temporary3 = nil, nil, nil
                    loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                    grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                    temporary3 = grabParry and loadAnimationTrack
                    if temporary3 then
                        playAnimationRef.value(loadAnimationTrack)
                    end
                else
                    grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                    grabParry.Priority = Enum.AnimationPriority.Action4
                    grabParry:Play(0, 1, 1)
                end
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index4, item4 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index4, item4, index4
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        if swordOverrideEnabledRef.value then
            swordOverrideName2 = swordOverrideNameRef.value
        else
            if not localPlayerRef.value.Character then
                return
            end
            grabParry = localPlayerRef.value.Character:GetAttribute("CurrentlyEquippedSword")
            grabParryRef = resolveParryAnimationRef.value(grabParry)
            grabParryRef = {value = grabParryRef}
            if not grabParryRef.value then
                grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
                grabParryRef.value = grabParry
                if not grabParryRef.value then
                    return
                end
                if shopControllerApiRef.value then
                    loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                    grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                    grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                    for index5, item5 in grabParry, loadAnimationTrack, temporary3 do
                        temporary5, temporary8, temporary3 = index5, item5, index5
                        temporary7 = temporary8:GetAttribute("SuccessParry")
                        if temporary7 then
                            pcall(stopAnimationRef.value, temporary8)
                        end
                    end
                    temporary5, temporary8, temporary3 = nil, nil, nil
                    loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                    grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                    temporary3 = grabParry and loadAnimationTrack
                    if temporary3 then
                        playAnimationRef.value(loadAnimationTrack)
                    end
                else
                    grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                    grabParry.Priority = Enum.AnimationPriority.Action4
                    grabParry:Play(0, 1, 1)
                end
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index6, item6 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index6, item6, index6
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        grabParryRef = resolveParryAnimationRef.value(swordOverrideName2)
        grabParryRef = {value = grabParryRef}
        if not grabParryRef.value then
            grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
            grabParryRef.value = grabParry
            if not grabParryRef.value then
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index7, item7 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index7, item7, index7
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        if shopControllerApiRef.value then
            loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
            grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
            grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
            for index8, item8 in grabParry, loadAnimationTrack, temporary3 do
                temporary5, temporary8, temporary3 = index8, item8, index8
                temporary7 = temporary8:GetAttribute("SuccessParry")
                if temporary7 then
                    pcall(stopAnimationRef.value, temporary8)
                end
            end
            temporary5, temporary8, temporary3 = nil, nil, nil
            loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
            grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
            temporary3 = grabParry and loadAnimationTrack
            if temporary3 then
                playAnimationRef.value(loadAnimationTrack)
            end
        else
            grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
            grabParry.Priority = Enum.AnimationPriority.Action4
            grabParry:Play(0, 1, 1)
        end
        return
    end
    temporary10 = localPlayerRef.value.Character and localPlayerRef.value.Character:FindFirstChildOfClass("Humanoid")
    if not temporary10 then
        return
    end
    temporary2Ref = temporary10:FindFirstChildOfClass("Animator") or temporary10:FindFirstChild("Animator")
    temporary2Ref = {value = temporary2Ref}
    if not temporary2Ref.value then
        return
    end
    if swordOverrideEnabledRef.value then
        if swordOverrideNameRef.value ~= "" then
            swordOverrideName2 = swordOverrideNameRef.value
        else
            if not localPlayerRef.value.Character then
                return
            end
            grabParry = localPlayerRef.value.Character:GetAttribute("CurrentlyEquippedSword")
            grabParryRef = resolveParryAnimationRef.value(grabParry)
            grabParryRef = {value = grabParryRef}
            if not grabParryRef.value then
                grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
                grabParryRef.value = grabParry
                if not grabParryRef.value then
                    return
                end
                if shopControllerApiRef.value then
                    loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                    grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                    grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                    for index9, item9 in grabParry, loadAnimationTrack, temporary3 do
                        temporary5, temporary8, temporary3 = index9, item9, index9
                        temporary7 = temporary8:GetAttribute("SuccessParry")
                        if temporary7 then
                            pcall(stopAnimationRef.value, temporary8)
                        end
                    end
                    temporary5, temporary8, temporary3 = nil, nil, nil
                    loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                    grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                    temporary3 = grabParry and loadAnimationTrack
                    if temporary3 then
                        playAnimationRef.value(loadAnimationTrack)
                    end
                else
                    grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                    grabParry.Priority = Enum.AnimationPriority.Action4
                    grabParry:Play(0, 1, 1)
                end
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index10, item10 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index10, item10, index10
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        grabParryRef = resolveParryAnimationRef.value(swordOverrideName2)
        grabParryRef = {value = grabParryRef}
        if not grabParryRef.value then
            grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
            grabParryRef.value = grabParry
            if not grabParryRef.value then
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index11, item11 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index11, item11, index11
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        if shopControllerApiRef.value then
            loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
            grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
            grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
            for index12, item12 in grabParry, loadAnimationTrack, temporary3 do
                temporary5, temporary8, temporary3 = index12, item12, index12
                temporary7 = temporary8:GetAttribute("SuccessParry")
                if temporary7 then
                    pcall(stopAnimationRef.value, temporary8)
                end
            end
            temporary5, temporary8, temporary3 = nil, nil, nil
            loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
            grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
            temporary3 = grabParry and loadAnimationTrack
            if temporary3 then
                playAnimationRef.value(loadAnimationTrack)
            end
        else
            grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
            grabParry.Priority = Enum.AnimationPriority.Action4
            grabParry:Play(0, 1, 1)
        end
        return
    end
    if swordOverrideEnabledRef.value then
        swordOverrideName2 = swordOverrideNameRef.value
    else
        if not localPlayerRef.value.Character then
            return
        end
        grabParry = localPlayerRef.value.Character:GetAttribute("CurrentlyEquippedSword")
        grabParryRef = resolveParryAnimationRef.value(grabParry)
        grabParryRef = {value = grabParryRef}
        if not grabParryRef.value then
            grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
            grabParryRef.value = grabParry
            if not grabParryRef.value then
                return
            end
            if shopControllerApiRef.value then
                loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
                grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
                grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
                for index13, item13 in grabParry, loadAnimationTrack, temporary3 do
                    temporary5, temporary8, temporary3 = index13, item13, index13
                    temporary7 = temporary8:GetAttribute("SuccessParry")
                    if temporary7 then
                        pcall(stopAnimationRef.value, temporary8)
                    end
                end
                temporary5, temporary8, temporary3 = nil, nil, nil
                loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
                grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
                temporary3 = grabParry and loadAnimationTrack
                if temporary3 then
                    playAnimationRef.value(loadAnimationTrack)
                end
            else
                grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
                grabParry.Priority = Enum.AnimationPriority.Action4
                grabParry:Play(0, 1, 1)
            end
            return
        end
        if shopControllerApiRef.value then
            loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
            grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
            grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
            for index14, item14 in grabParry, loadAnimationTrack, temporary3 do
                temporary5, temporary8, temporary3 = index14, item14, index14
                temporary7 = temporary8:GetAttribute("SuccessParry")
                if temporary7 then
                    pcall(stopAnimationRef.value, temporary8)
                end
            end
            temporary5, temporary8, temporary3 = nil, nil, nil
            loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
            grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
            temporary3 = grabParry and loadAnimationTrack
            if temporary3 then
                playAnimationRef.value(loadAnimationTrack)
            end
        else
            grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
            grabParry.Priority = Enum.AnimationPriority.Action4
            grabParry:Play(0, 1, 1)
        end
        return
    end
    grabParryRef = resolveParryAnimationRef.value(swordOverrideName2)
    grabParryRef = {value = grabParryRef}
    if not grabParryRef.value then
        grabParry = swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry")
        grabParryRef.value = grabParry
        if not grabParryRef.value then
            return
        end
        if shopControllerApiRef.value then
            loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
            grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
            grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
            for index15, item15 in grabParry, loadAnimationTrack, temporary3 do
                temporary5, temporary8, temporary3 = index15, item15, index15
                temporary7 = temporary8:GetAttribute("SuccessParry")
                if temporary7 then
                    pcall(stopAnimationRef.value, temporary8)
                end
            end
            temporary5, temporary8, temporary3 = nil, nil, nil
            loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
            grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
            temporary3 = grabParry and loadAnimationTrack
            if temporary3 then
                playAnimationRef.value(loadAnimationTrack)
            end
        else
            grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
            grabParry.Priority = Enum.AnimationPriority.Action4
            grabParry:Play(0, 1, 1)
        end
        return
    end
    if shopControllerApiRef.value then
        loadAnimationTrack = packValues(shopControllerApiRef.value:GetPlayingAnimationTracks(temporary2Ref.value))
        grabParry, loadAnimationTrack, temporary3 = pairs(unpackValues(loadAnimationTrack))
        grabParry, loadAnimationTrack, temporary3 = normalizeIterator(grabParry, loadAnimationTrack, temporary3)
        for index16, item16 in grabParry, loadAnimationTrack, temporary3 do
            temporary5, temporary8, temporary3 = index16, item16, index16
            temporary7 = temporary8:GetAttribute("SuccessParry")
            if temporary7 then
                pcall(stopAnimationRef.value, temporary8)
            end
        end
        temporary5, temporary8, temporary3 = nil, nil, nil
        loadAnimationTrack = bind(Handlers.loadAnimationTrack, shopControllerApiRef, temporary2Ref, grabParryRef)
        grabParry, loadAnimationTrack = pcall(loadAnimationTrack)
        temporary3 = grabParry and loadAnimationTrack
        if temporary3 then
            playAnimationRef.value(loadAnimationTrack)
        end
    else
        grabParry = temporary2Ref.value:LoadAnimation(grabParryRef.value)
        grabParry.Priority = Enum.AnimationPriority.Action4
        grabParry:Play(0, 1, 1)
    end
    return
end

-- Supply the saved character transform to intercepted property reads.
function Handlers.readImmortalityProperty(originalIndexRef, localPlayerRef, immortalityTransformRef, config, value, otherValue)
    local cFrame, head, temporary3
    head = config.immortality
    if config.immortality then
        cFrame = checkcaller()
        head = not cFrame
    end
    if head then
        head = otherValue == "CFrame" and localPlayerRef.value.Character and localPlayerRef.value.Character:FindFirstChild("HumanoidRootPart")
        if head then
            if value == localPlayerRef.value.Character.HumanoidRootPart then
                head = immortalityTransformRef.value.CFrame or CFrame.new()
                return head
            end
            head = localPlayerRef.value.Character:FindFirstChild("Head")
            if value == head then
                head = immortalityTransformRef.value.CFrame
                if immortalityTransformRef.value.CFrame then
                    cFrame = immortalityTransformRef.value.CFrame
                    temporary3 = Vector3.new(0, localPlayerRef.value.Character.HumanoidRootPart.Size.Y / 2 + 0.5, 0)
                    head = cFrame + temporary3
                end
                if not head then
                    head = CFrame.new()
                end
                return head
            end
            head = packValues(originalIndexRef.value(value, otherValue))
            return unpackValues(head)
        end
    end
    head = packValues(originalIndexRef.value(value, otherValue))
    return unpackValues(head)
end

function Handlers.readNetworkPing(stats)
    local result
    result = packValues(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    return unpackValues(result)
end

function Handlers.refreshAimCache(aimCacheRef, camera, localPlayerRef)
    local result, temporary2, temporary3, temporary4, temporary5, character, temporary7
    local humanoidRootPart, temporary9, screen, temporary11, temporary12, aimCache2
    temporary2 = os.clock()
    if temporary2 - aimCacheRef.value.lastRefresh < 0.016 then
        return
    end
    aimCache2 = aimCacheRef.value
    aimCacheRef.value.lastRefresh = temporary2
    aimCache2.cf = camera.CFrame
    aimCache2 = workspace:FindFirstChild("Alive")
    if aimCache2 then
        table.clear(aimCacheRef.value.screen)
        character = localPlayerRef.value.Character
        temporary7 = packValues(aimCache2:GetChildren())
        result, temporary7, temporary3 = ipairs(unpackValues(temporary7))
        result, temporary7, temporary3 = normalizeIterator(result, temporary7, temporary3)
        for index, item in result, temporary7, temporary3 do
            temporary5, temporary12, temporary3 = index, item, index
            if temporary12 ~= character then
                humanoidRootPart = temporary12:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    temporary9, temporary4 = camera:WorldToScreenPoint(humanoidRootPart.Position)
                    if temporary4 then
                        screen = aimCacheRef.value.screen
                        temporary11 = tostring(temporary12)
                        screen[temporary11] = temporary9
                    end
                end
            end
        end
        temporary5, temporary12, temporary3 = nil, nil, nil
    else
        table.clear(aimCacheRef.value.screen)
    end
    character = camera.ViewportSize
    aimCacheRef.value.aim[1] = camera.ViewportSize.X / 2
    aimCacheRef.value.aim[2] = character.Y / 2
    return
end

function Handlers.refreshAimIfEnabled(config, refreshAimCacheRef)
    local result
    result = config.parry or config.spamParry or config.trigger
    if result then
        refreshAimCacheRef.value()
    end
    return
end

function Handlers.refreshCharacterEffectsAfterDelay(clearCloudsRef, clearVisualEffectsRef)
    task.wait(0.5)
    clearCloudsRef.value()
    clearVisualEffectsRef.value()
    return
end

function Handlers.refreshGuiDescendant(cosmetics, category, value)
    local refreshShopSlotVisual, defer
    defer = value:IsA("GuiObject")
    if defer then
        refreshShopSlotVisual, defer = bind(Handlers.refreshShopSlotVisual, cosmetics, category, value), task.defer
        defer(refreshShopSlotVisual)
    end
    return
end

function Handlers.refreshSettingsControls(config, resetFramePositionsRef, onKeybindInputBeganRef, resetFramePositionsRef2)
    local config2, restoreSecondaryControl, restorePrimaryControl, config3, updateState
    restorePrimaryControl, updateState, restoreSecondaryControl = bind(Handlers.restorePrimaryControl, onKeybindInputBeganRef), bind(Handlers.updateState, resetFramePositionsRef2), bind(Handlers.restoreSecondaryControl, resetFramePositionsRef)
    updateState("parry", config.parry)
    updateState("autoAccuracy", config.autoAccuracy)
    updateState("animfix", config.animfix)
    updateState("spamParry", config.spamParry)
    updateState("trigger", config.trigger)
    updateState("immortality", config.immortality)
    updateState("showStats", config.showStats)
    updateState("showFpsUI", config.showFpsUI)
    updateState("showBindWindow", config.showBindWindow)
    updateState("showSpamUI", config.showSpamUI)
    updateState("showTriggerUI", config.showTriggerUI)
    updateState("showImmortalUI", config.showImmortalUI)
    updateState("showCurveUI", config.showCurveUI)
    updateState("saveButtonPositions", config.saveButtonPositions)
    config2 = config
    updateState("optim_unlimitedKBPS", config.optim.unlimitedKBPS)
    updateState("optim_headless", config2.optim.headless)
    updateState("optim_korblox", config2.optim.korblox)
    updateState("optim_noRender", config2.optim.noRender)
    updateState("ability_cooldown_protection", config2.ability.cooldown_protection)
    updateState("unlock_all", config2.unlock_all)
    restoreSecondaryControl("accuracy", config2.accuracy)
    restoreSecondaryControl("cps", config2.cps)
    restoreSecondaryControl("spamThreshold", config2.spamThreshold)
    restoreSecondaryControl("imm_angle", config2.imm.angle)
    restoreSecondaryControl("imm_height", config2.imm.height)
    config3 = config2
    config2 = config2.imm
    restoreSecondaryControl("imm_depth", -config2.depth)
    restoreSecondaryControl("imm_radius", config3.imm.radius)
    restorePrimaryControl("curveType", config3.curveType)
    return
end

function Handlers.rejoinCurrentServer(teleportServiceRef, localPlayerRef)
    teleportServiceRef.value:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayerRef.value)
    return
end

function Handlers.rememberM1StopTime(lastM1StopRef, value)
    lastM1StopRef.value = value
    return
end

function Handlers.rememberMousePosition(tweenServiceRef, value, otherValue)
    tweenServiceRef.value = otherValue
    return
end

function Handlers.rememberPressedKey(keyCodeRef, input)
    if input.KeyCode ~= Enum.KeyCode.Unknown then
        keyCodeRef.value = input.KeyCode
    end
    return
end

function Handlers.removeBallEffect(debris, aeroDynamicSlashVFX)
    debris:AddItem(aeroDynamicSlashVFX, 0)
    return
end

function Handlers.removeCapturedInstance(instance)
    local debris, debris2
    debris = game:GetService("Debris")
    debris, debris2 = debris.AddItem, debris
    debris(debris2, instance, 0)
    return
end

function Handlers.removeRuntimeEffectSafely(optimizationStateRef, value)
    local removeCapturedInstance
    if optimizationStateRef.value.noRender then
        removeCapturedInstance = bind(Handlers.removeCapturedInstance, value)
        pcall(removeCapturedInstance)
    end
    return
end

function Handlers.resolveParryAnimation(swordControllerRef, animationCacheRef, swordAPIRef, localPlayerRef, swordAnimationsRef, value)
    local character, swordController2, getSwordParryAnimation, getSwordParryAnimationRef, temporary5, getSwordParryAnimation2, temporary7
    local temporary8, temporary9, temporary10, getSwordParryAnimationRef2, swordController3, temporary13
    character = localPlayerRef.value.Character
    if not character then
        return nil
    end
    temporary7 = value or ""
    if animationCacheRef.value.Cache[temporary7] then
        return animationCacheRef.value.Cache[temporary7]
    end
    getSwordParryAnimationRef2 = {value = "Default"}
    getSwordParryAnimationRef = {value = "Single"}
    getSwordParryAnimation = value and value ~= "" and swordAnimationsRef.value
    if getSwordParryAnimation then
        swordController2 = bind(Handlers.getSwordDefinition, swordAnimationsRef, value)
        getSwordParryAnimation, swordController2 = pcall(swordController2)
        getSwordParryAnimation2 = getSwordParryAnimation and swordController2
        if getSwordParryAnimation2 then
            swordController3 = type(swordController2)
            getSwordParryAnimation2 = swordController3 == "table"
        end
        if getSwordParryAnimation2 then
            getSwordParryAnimation2 = swordController2.AnimationType or getSwordParryAnimationRef2.value
            getSwordParryAnimation2, getSwordParryAnimationRef2.value = swordController2.SwordType, getSwordParryAnimation2
            if not getSwordParryAnimation2 then
                getSwordParryAnimation2 = getSwordParryAnimationRef.value
            end
            getSwordParryAnimationRef.value = getSwordParryAnimation2
        end
    end
    swordController2, getSwordParryAnimation = swordControllerRef.value, nil
    if swordControllerRef.value then
        getSwordParryAnimation2 = type(swordControllerRef.value.GetAnimations)
        swordController2 = getSwordParryAnimation2 == "function"
    end
    if swordController2 then
        getSwordParryAnimation2 = bind(Handlers.getSwordParryAnimation, getSwordParryAnimationRef, character, getSwordParryAnimationRef2, swordControllerRef)
        swordController2, getSwordParryAnimation2 = pcall(getSwordParryAnimation2)
        swordController3 = swordController2
        if swordController2 then
            temporary5 = type(getSwordParryAnimation2)
            swordController3 = temporary5 == "table"
        end
        if swordController3 then
            swordController3, temporary5, temporary8 = pairs(getSwordParryAnimation2)
            swordController3, temporary5, temporary8 = normalizeIterator(swordController3, temporary5, temporary8)
            temporary13, temporary9 = swordController3(temporary5, temporary8)
            temporary8 = temporary13
            if not (temporary13 == nil) then
                while true do
                    temporary10 = typeof(temporary9)
                    if temporary10 == "Instance" then
                        getSwordParryAnimation = temporary9
                        break
                    else
                        temporary13, temporary9 = swordController3(temporary5, temporary8)
                        temporary8 = temporary13
                        if temporary13 == nil then
                            break
                        else
                            continue
                        end
                    end
                    break
                end
            end
        end
    end
    if not getSwordParryAnimation then
        swordController2 = swordAPIRef.value.Collection.Default
        getSwordParryAnimation2 = swordAPIRef.value.Collection.Default and (swordAPIRef.value.Collection.Default:FindFirstChild("GrabParry") or swordController2:FindFirstChild("Grab"))
        getSwordParryAnimation = getSwordParryAnimation2
    end
    animationCacheRef.value.Cache[temporary7] = getSwordParryAnimation
    return getSwordParryAnimation
end

function Handlers.restorePrimaryControl(onKeybindInputBeganRef, value, otherValue)
    local result, applyPrimaryControlValue, temporary3
    result = onKeybindInputBeganRef.value[value]
    temporary3 = result and result.SetValue
    if temporary3 then
        applyPrimaryControlValue = bind(Handlers.applyPrimaryControlValue, result, otherValue)
        pcall(applyPrimaryControlValue)
    end
    return
end

function Handlers.restoreSecondaryControl(resetFramePositionsRef, value, otherValue)
    local result, temporary2, applySecondaryControlValue
    temporary2 = resetFramePositionsRef.value[value]
    result = temporary2 and temporary2.SetValue
    if result then
        applySecondaryControlValue = bind(Handlers.applySecondaryControlValue, temporary2, otherValue)
        pcall(applySecondaryControlValue)
    end
    return
end

function Handlers.runAbilityLoop(ballPresentRef, parryRemoteRef, tryUseAbilityRef, config, ballTargetedPlayerRef)
    local result
    while true do
        result = config.ability.cooldown_protection and parryRemoteRef.value and not ballTargetedPlayerRef.value and not ballPresentRef.value and not config.trigger
        if result then
            tryUseAbilityRef.value()
        end
        task.wait(0.05)
    end
end

-- Run the automatic parry loop while balls are present.
function Handlers.runAutoParryLoop(watchBallTargetRef, trySpamParryRef, onBallFrameRef, parryRemoteRef, ballTargetedPlayerRef, config)
    local result, temporary2, temporary3, trainingBalls, temporary5, temporary6, temporary7
    while true do
        trainingBalls = parryRemoteRef.value and (config.parry or config.trigger or config.spamParry) and workspace:FindFirstChild("Balls")
        if trainingBalls then
            temporary2 = packValues(workspace.Balls:GetChildren())
            trainingBalls, temporary2, temporary7 = pairs(unpackValues(temporary2))
            trainingBalls, temporary2, temporary7 = normalizeIterator(trainingBalls, temporary2, temporary7)
            for index, item in trainingBalls, temporary2, temporary7 do
                result, temporary5, temporary7 = index, item, index
                temporary6 = temporary5:GetAttribute("realBall")
                if temporary6 then
                    if not ballTargetedPlayerRef.value then
                        if config.trigger then
                            watchBallTargetRef.value(temporary5)
                        else
                            if config.parry then
                                onBallFrameRef.value(temporary5)
                            end
                        end
                    end
                    if config.spamParry then
                        trySpamParryRef.value(temporary5)
                    end
                end
            end
            result, temporary5, temporary7 = nil, nil, nil
            trainingBalls = workspace:FindFirstChild("TrainingBalls")
            if trainingBalls then
                temporary7 = packValues(trainingBalls:GetChildren())
                temporary2, temporary7, result = pairs(unpackValues(temporary7))
                temporary2, temporary7, result = normalizeIterator(temporary2, temporary7, result)
                for index2, item2 in temporary2, temporary7, result do
                    temporary5, temporary6, result = index2, item2, index2
                    temporary3 = temporary6:GetAttribute("realBall")
                    if temporary3 then
                        if not ballTargetedPlayerRef.value then
                            if config.trigger then
                                watchBallTargetRef.value(temporary6)
                            else
                                if config.parry then
                                    onBallFrameRef.value(temporary6)
                                end
                            end
                        end
                        if config.spamParry then
                            trySpamParryRef.value(temporary6)
                        end
                    end
                end
                temporary5, temporary6, result = nil, nil, nil
            end
            task.wait(0.01)
            continue
        else
            task.wait(0.1)
            continue
        end
    end
end

function Handlers.runCapturedAction(deleteConfigAndResetRef)
    deleteConfigAndResetRef.value()
    return
end

function Handlers.runCapturedActionSafely(applyDeviceSpoofRef)
    pcall(applyDeviceSpoofRef.value)
    return
end

function Handlers.runTriggerLoop(playParryAnimationRef, lastTriggerTimeRef, sendParryRef, trackedBallsRef, config)
    local result, temporary2, temporary3
    while true do
        if #trackedBallsRef.value > 0 then
            temporary3 = tick()
            if temporary3 - lastTriggerTimeRef.value >= 0.01 then
                temporary2 = table.remove(trackedBallsRef.value, 1)
                result = temporary2 and temporary3 - temporary2.t < 0.5 and temporary2.ball and temporary2.ball.Parent
                if result then
                    if config.animfix then
                        playParryAnimationRef.value()
                    end
                    sendParryRef.value(true)
                    lastTriggerTimeRef.value = temporary3
                end
            end
            task.wait(0.003)
            continue
        else
            task.wait(0.01)
            continue
        end
    end
end

function Handlers.sendCapturedParryArguments(parryCipher, findBallInChildrenRef, aimCacheRef, originalFireServerRef, parryTransform, parryRemoteRef, targetPosition)
    originalFireServerRef.value(parryRemoteRef.value, parryTransform, parryCipher, targetPosition, 0.025, findBallInChildrenRef.value, aimCacheRef.value.screen, aimCacheRef.value.aim, false)
    return
end

function Handlers.sendParry(context, value)
    local result, spamHistory2, temporary3, temporary4, temporary5Ref, sendCapturedParryArguments, findBallInChildrenRef
    if not context.parryRemoteRef.value then
        return false
    end
    temporary5Ref = context.isParryBlockedRef.value()
    if temporary5Ref then
        temporary5Ref = {value = false}
        findBallInChildrenRef = bind(Handlers.findBallInChildren, temporary5Ref)
        findBallInChildrenRef(workspace.Balls)
        result = packValues(workspace:FindFirstChild("TrainingBalls"))
        findBallInChildrenRef(unpackValues(result))
        if not temporary5Ref.value then
            return false
        end
        context.refreshAimCacheRef.value()
        temporary5Ref = context.aimCacheRef.value.cf or context.camera.CFrame
        findBallInChildrenRef = context.calculateCurveTargetRef.value(temporary5Ref)
        findBallInChildrenRef = {value = findBallInChildrenRef}
        temporary4 = context.encodeTimestampRef.value()
        sendCapturedParryArguments = bind(Handlers.sendCapturedParryArguments, context.parryCipher, findBallInChildrenRef, context.aimCacheRef, context.originalFireServerRef, context.parryTransform, context.parryRemoteRef, temporary4)
        result = pcall(sendCapturedParryArguments)
        if result then
            sendCapturedParryArguments = tick()
            context.refreshAimIfEnabledRef.value = sendCapturedParryArguments
        end
        if context.spamCountRef.value <= 7 then
            context.spamCountRef.value = context.spamCountRef.value + 1
            sendCapturedParryArguments = table.insert
            spamHistory2 = context.spamHistory
            temporary3 = tick()
            temporary3 = temporary3 + 0.5
            sendCapturedParryArguments(spamHistory2, temporary3)
        end
        return result
    end
    context.refreshAimCacheRef.value()
    temporary5Ref = context.aimCacheRef.value.cf or context.camera.CFrame
    findBallInChildrenRef = context.calculateCurveTargetRef.value(temporary5Ref)
    findBallInChildrenRef = {value = findBallInChildrenRef}
    temporary4 = context.encodeTimestampRef.value()
    sendCapturedParryArguments = bind(Handlers.sendCapturedParryArguments, context.parryCipher, findBallInChildrenRef, context.aimCacheRef, context.originalFireServerRef, context.parryTransform, context.parryRemoteRef, temporary4)
    result = pcall(sendCapturedParryArguments)
    if result then
        sendCapturedParryArguments = tick()
        context.refreshAimIfEnabledRef.value = sendCapturedParryArguments
    end
    if context.spamCountRef.value <= 7 then
        context.spamCountRef.value = context.spamCountRef.value + 1
        sendCapturedParryArguments = table.insert
        spamHistory2 = context.spamHistory
        temporary3 = tick()
        temporary3 = temporary3 + 0.5
        sendCapturedParryArguments(spamHistory2, temporary3)
    end
    return result
end

function Handlers.setAbilityCooldownProtection(config, saveConfigRef, cooldownProtection)
    config.ability.cooldown_protection = cooldownProtection
    saveConfigRef.value()
    return
end

function Handlers.setAccuracy(config, saveConfigRef, accuracy)
    config.accuracy = accuracy
    saveConfigRef.value()
    return
end

function Handlers.setAnimationFixEnabled(config, saveConfigRef, animfix)
    config.animfix = animfix
    saveConfigRef.value()
    return
end

function Handlers.setAutoAccuracyEnabled(config, saveConfigRef, autoAccuracy)
    config.autoAccuracy = autoAccuracy
    saveConfigRef.value()
    return
end

function Handlers.setAutoParryEnabled(context, parry)
    local clearBallCaches
    context.config.parry = parry
    clearBallCaches = bind(Handlers.clearBallCaches, context.ballTargetTimesRef, context.ballConnectionsRef, context.ballCurveStates)
    pcall(clearBallCaches)
    clearBallCaches = bind(Handlers.clearTrackedBalls, context.trackedBallsRef)
    pcall(clearBallCaches)
    context.lastM1StopRef.value, context.animationBusyRef.value, context.parrySucceededRef.value, context.animationRecentlyPlayedRef.value = false, false, false, false
    context.lastTriggerTimeRef.value = 0
    context.saveConfigRef.value()
    return
end

function Handlers.setClicksPerSecond(config, saveConfigRef, cps)
    config.cps = cps
    saveConfigRef.value()
    return
end

function Handlers.setControllerEnabled(enabled, controller)
    if enabled then
        controller:Enable()
    else
        controller:Disable()
    end
    return
end

function Handlers.setCurveType(refreshKeybindPanelRef, selectedCurveRef, saveConfigRef, config, refreshCurvePanelRef, curveType)
    local config2
    config.curveType = curveType
    if not (selectedCurveRef.value == curveType) then
        selectedCurveRef.value, config2 = curveType, config
        config2.curveType = curveType
        refreshCurvePanelRef.value()
    end
    refreshKeybindPanelRef.value()
    saveConfigRef.value()
    return
end

function Handlers.setEnabled(config, swordOverrideEnabledRef, saveConfigRef, self, enabled)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6
    self.enabled = enabled == true
    config.unlock_all = self.enabled
    if not self.enabled then
        swordOverrideEnabledRef.value = false
    end
    if not self.ready then
        return
    end
    temporary3 = {}
    temporary3[2], temporary3[1] = "Explosion", "Sword"
    temporary6, result, temporary2 = ipairs(temporary3)
    temporary6, result, temporary2 = normalizeIterator(temporary6, result, temporary2)
    for index, item in temporary6, result, temporary2 do
        temporary3, temporary4, temporary2 = index, item, index
        if self.enabled then
            if self.shop_controller then
                self:set_category_unlock(temporary4, true)
                self:schedule_refresh(temporary4)
            end
            self:set_modern_unlock(temporary4, true)
        else
            if self.shop_controller then
                temporary5 = self.refresh_generation[temporary4] or 0
                self.refresh_generation[temporary4] = temporary5 + 1
                self:set_category_unlock(temporary4, false)
            end
            self:set_modern_unlock(temporary4, false)
        end
    end
    temporary3, temporary4, temporary2 = nil, nil, nil
    if not self.enabled then
        self:restore_sword()
        self.selected_explosion = nil
    else
        self:refresh_selected()
    end
    pcall(saveConfigRef.value)
    return
end

function Handlers.setImmortality(immortalityLabel, setImmortalityHookRef, saveConfigRef, config, immortalityButtonRef, styleFloatingButtonRef, immortalityStroke, immortality)
    config.immortality = immortality
    styleFloatingButtonRef.value(config.immortality, immortalityButtonRef.value, immortalityLabel, immortalityStroke)
    pcall(setImmortalityHookRef.value, config.immortality)
    saveConfigRef.value()
    return
end

function Handlers.setImmortalityAngle(config, saveConfigRef, angle)
    config.imm.angle = angle
    saveConfigRef.value()
    return
end

function Handlers.setImmortalityDepth(config, saveConfigRef, value)
    config.imm.depth = -value
    saveConfigRef.value()
    return
end

function Handlers.setImmortalityHeight(config, saveConfigRef, height)
    config.imm.height = height
    saveConfigRef.value()
    return
end

function Handlers.setImmortalityHookEnabled(immortalityHookEnabledRef, updateImmortalityTransformRef, originalIndexRef, value)
    local result, originalIndex2
    result = value and not immortalityHookEnabledRef.value
    if result then
        originalIndex2, immortalityHookEnabledRef.value = updateImmortalityTransformRef.value, true
        hookmetamethod(game, "__index", originalIndex2)
    else
        result = not value and immortalityHookEnabledRef.value
        if result then
            originalIndex2, immortalityHookEnabledRef.value = originalIndexRef.value, false
            hookmetamethod(game, "__index", originalIndex2)
        end
    end
    return
end

function Handlers.setImmortalityRadius(config, saveConfigRef, radius)
    config.imm.radius = radius
    saveConfigRef.value()
    return
end

function Handlers.setKorbloxEnabled(saveConfigRef, localPlayerRef, applyAppearanceRef, config, korblox)
    config.optim.korblox = korblox
    if localPlayerRef.value.Character then
        applyAppearanceRef.value(localPlayerRef.value.Character)
    end
    saveConfigRef.value()
    return
end

function Handlers.setPhysicsSenderRate()
    setfflag("S2PhysicsSenderRate", "100")
    return
end

function Handlers.setSavePositionsEnabled(config, saveConfigRef, saveButtonPositions)
    config.saveButtonPositions = saveButtonPositions
    saveConfigRef.value()
    return
end

function Handlers.setSpamParryEnabled(config, ballPresentRef, saveConfigRef, spamParry)
    config.spamParry = spamParry
    if not spamParry then
        ballPresentRef.value = false
    end
    saveConfigRef.value()
    return
end

function Handlers.setSpamThreshold(config, saveConfigRef, spamThreshold)
    config.spamThreshold = spamThreshold
    saveConfigRef.value()
    return
end

function Handlers.show(header, sectionRef, uIStroke, tweenServiceRef, tweenServiceRef2, tweenServiceRef3, lay, self)
    local tweenService2, tweenService3, tweenInfo, header2, temporary5
    tweenServiceRef.value(true)
    header2, tweenServiceRef3.value, tweenService3 = header, true, tweenServiceRef2
    tweenInfo = TweenInfo.new(0.3)
    temporary5 = {}
    temporary5.TextTransparency = 0
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, header2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    tweenService3, header2 = tweenServiceRef2, lay
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.BackgroundTransparency = 0.5
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, header2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService3, header2 = tweenServiceRef2, sectionRef.value
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.BackgroundTransparency = 0.55
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, header2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    header2, tweenService3 = uIStroke, tweenServiceRef2
    tweenInfo = TweenInfo.new(1)
    temporary5 = {}
    temporary5.Transparency = 0.5
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, header2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    return
end

function Handlers.status(labelText, icon, effect, highlightedRef, toggle, tweenService, self, otherValue)
    local position, tweenService2, tweenInfo, tweenService3, position2, tweenService4, tweenInfo2
    if otherValue then
        tweenService3 = highlightedRef.value == true and 0 or 0.3
        tweenInfo, tweenService4 = toggle, tweenService
        tweenInfo2 = TweenInfo.new(0.5, Enum.EasingStyle.Quint)
        position = {}
        position2 = UDim2.new(0.899999976, 0, -0.351014495, 0)
        position.Size = position2
        tweenService4, tweenService2 = tweenService4.Create, tweenService4
        tweenService4 = tweenService4(tweenService2, tweenInfo, tweenInfo2, position)
        tweenService2, tweenService4 = tweenService4, tweenService4.Play
        tweenService4(tweenService2)
        tweenService4, tweenInfo = tweenService, labelText
        tweenInfo2 = TweenInfo.new(1, Enum.EasingStyle.Quint)
        position = {}
        position.TextTransparency = tweenService3
        tweenService4, tweenService2 = tweenService4.Create, tweenService4
        tweenService4 = tweenService4(tweenService2, tweenInfo, tweenInfo2, position)
        tweenService2, tweenService4 = tweenService4, tweenService4.Play
        tweenService4(tweenService2)
        tweenService4, tweenInfo = tweenService, effect
        tweenInfo2 = TweenInfo.new(0.4)
        position = {}
        position.BackgroundTransparency = 0
        tweenService2, tweenService4 = tweenService4, tweenService4.Create
        tweenService4 = tweenService4(tweenService2, tweenInfo, tweenInfo2, position)
        tweenService4, tweenService2 = tweenService4.Play, tweenService4
        tweenService4(tweenService2)
        tweenService4, tweenInfo = tweenService, icon
        tweenInfo2 = TweenInfo.new(0.4)
        position = {}
        position.BackgroundTransparency = 0
        tweenService4, tweenService2 = tweenService4.Create, tweenService4
        tweenService4 = tweenService4(tweenService2, tweenInfo, tweenInfo2, position)
        tweenService2, tweenService4 = tweenService4, tweenService4.Play
        tweenService4(tweenService2)
    else
        tweenService3, tweenService2 = tweenService, effect
        tweenInfo = TweenInfo.new(0.4)
        tweenInfo2 = {}
        tweenInfo2.BackgroundTransparency = 1
        tweenService3, tweenService4 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService4, tweenService2, tweenInfo, tweenInfo2)
        tweenService3, tweenService4 = tweenService3.Play, tweenService3
        tweenService3(tweenService4)
        tweenService3 = tweenService
        tweenService2 = icon
        tweenInfo = TweenInfo.new(0.4)
        tweenInfo2 = {}
        tweenInfo2.BackgroundTransparency = 1
        tweenService3, tweenService4 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService4, tweenService2, tweenInfo, tweenInfo2)
        tweenService4, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService4)
        tweenService3, tweenService2 = tweenService, toggle
        tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint)
        tweenInfo2 = {}
        position = UDim2.new(0, 0, 0, 0)
        tweenInfo2.Size = position
        tweenService3, tweenService4 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService4, tweenService2, tweenInfo, tweenInfo2)
        tweenService4, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService4)
        tweenService3 = tweenService
        tweenService2 = labelText
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint)
        tweenInfo2 = {}
        tweenInfo2.TextTransparency = 1
        tweenService4, tweenService3 = tweenService3, tweenService3.Create
        tweenService3 = tweenService3(tweenService4, tweenService2, tweenInfo, tweenInfo2)
        tweenService4, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService4)
    end
    return
end

function Handlers.stopAnimationTrack(value)
    local result
    result = value:GetAttribute("StopFadeTime")
    value:Stop(result)
    return
end

function Handlers.submitKeySystem(tweenService, acceptedValueRef, screenGuiRef, tweenServiceRef2, pasteKey, acceptedValueRef2, frame)
    local position, acceptedValue2, frame2, acceptedValue3, tweenInfo, temporary6
    if tweenServiceRef2.value then
        return
    end
    tweenServiceRef2.value, acceptedValue2, acceptedValue3 = true, acceptedValueRef2, pasteKey
    acceptedValue3 = acceptedValue3.Text
    acceptedValue2 = acceptedValue2(acceptedValue3)
    if acceptedValue2 then
        acceptedValue2, frame2 = tweenService, frame
        tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
        temporary6 = {}
        position = UDim2.new(0, 0, 0, 0)
        temporary6.Size = position
        acceptedValue2, acceptedValue3 = acceptedValue2.Create, acceptedValue2
        acceptedValue2 = acceptedValue2(acceptedValue3, frame2, tweenInfo, temporary6)
        acceptedValue2, acceptedValue3 = acceptedValue2.Play, acceptedValue2
        acceptedValue2(acceptedValue3)
        acceptedValue2 = acceptedValueRef.value or bind(Handlers.noopKeySystem)
        acceptedValueRef.value = acceptedValue2
        acceptedValue3, acceptedValue2 = bind(Handlers.destroyNotificationAfterDelay, screenGuiRef), task.spawn
        acceptedValue2(acceptedValue3)
        acceptedValueRef.value(pasteKey.Text)
        return
    end
    pasteKey.Text = ""
    tweenServiceRef2.value = false
    return
end

function Handlers.teleportToCurrentPlace(teleportServiceRef, localPlayerRef)
    teleportServiceRef.value:Teleport(game.PlaceId, localPlayerRef.value)
    return
end

function Handlers.text(labelText, self, otherValue)
    local labelText2, temporary2
    labelText2 = labelText
    temporary2 = tostring(otherValue)
    labelText2.Text = temporary2
    return
end

function Handlers.theme(theme, self, lower)
    local lower2, lower3
    lower3 = lower or "original"
    lower2 = tostring(lower3)
    lower2, lower3 = lower2.lower, lower2
    lower2 = lower2(lower3)
    lower = lower2
    if lower2 == "original" then
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(1, 17, 33)
        lower2.BlackgroundColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(9, 9, 19)
        lower2.BlackColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(7, 7, 17)
        lower2.HeaderColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(0, 34, 44)
        lower2.TraceColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(19, 176, 243)
        lower2.MainColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(3, 6, 25)
        lower2.MainColorDrop = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(0, 17, 35)
        lower2.SectionColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(3, 35, 50)
        lower2.StrokeColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(2, 5, 22)
        lower2.ButtonBlackgroundColor = lower3
    end
    if lower == "nightly" then
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(20, 20, 20)
        lower2.BlackgroundColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(15, 15, 15)
        lower2.BlackColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(28, 28, 28)
        lower2.HeaderColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(255, 140, 0)
        lower2.TraceColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(255, 140, 0)
        lower2.MainColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(65, 54, 31)
        lower2.MainColorDrop = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(22, 22, 22)
        lower2.SectionColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(255, 140, 0)
        lower2.StrokeColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(30, 30, 30)
        lower2.ButtonBlackgroundColor = lower3
    end
    if lower == "dark" then
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(37, 37, 37)
        lower2.BlackgroundColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(8, 8, 8)
        lower2.BlackColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(8, 8, 8)
        lower2.HeaderColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(25, 25, 25)
        lower2.TraceColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(0, 172, 247)
        lower2.MainColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(64, 65, 67)
        lower2.MainColorDrop = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(13, 13, 13)
        lower2.SectionColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(28, 28, 28)
        lower2.StrokeColor = lower3
        lower2 = theme.Themes
        lower3 = Color3.fromRGB(13, 13, 13)
        lower2.ButtonBlackgroundColor = lower3
    end
    return
end

function Handlers.toggleImmortality(styleFloatingButtonRef, immortalityStroke, saveConfigRef, parryRemoteRef, config, immortalityLabel, immortalityButtonRef, setImmortalityHookRef)
    local config2
    if not parryRemoteRef.value then
        immortalityLabel.Text = "NO REMOTE!"
        task.wait(1)
        immortalityLabel.Text = "IMMORTAL"
        return
    end
    config2 = config
    config.immortality = not config.immortality
    styleFloatingButtonRef.value(config2.immortality, immortalityButtonRef.value, immortalityLabel, immortalityStroke)
    pcall(setImmortalityHookRef.value, config.immortality)
    saveConfigRef.value()
    return
end

function Handlers.toggleSpam(styleFloatingButtonRef, spamLabel, spamButtonRef, parryRemoteRef, ballTargetedPlayerRef, spamStroke)
    local styleFloatingButton2
    if not parryRemoteRef.value then
        spamStroke.Text = "NO REMOTE!"
        task.wait(1)
        spamStroke.Text = "SPAM"
        return
    end
    styleFloatingButton2, ballTargetedPlayerRef.value = styleFloatingButtonRef.value, not ballTargetedPlayerRef.value
    styleFloatingButton2(ballTargetedPlayerRef.value, spamButtonRef.value, spamStroke, spamLabel)
    return
end

function Handlers.toggleTrigger(styleFloatingButtonRef, triggerStroke, saveConfigRef, parryRemoteRef, config, triggerLabel, triggerButtonRef)
    local config2
    if not parryRemoteRef.value then
        triggerLabel.Text = "NO REMOTE!"
        task.wait(1)
        triggerLabel.Text = "TRIGGER"
        return
    end
    config2 = config
    config.trigger = not config.trigger
    styleFloatingButtonRef.value(config2.trigger, triggerButtonRef.value, triggerLabel, triggerStroke)
    saveConfigRef.value()
    return
end

function Handlers.trackBall(trackedBallsRef, ball)
    local insert, temporary2, temporary3, trackedBalls2, temporary5
    insert, trackedBalls2, temporary3 = ipairs(trackedBallsRef.value)
    insert, trackedBalls2, temporary3 = normalizeIterator(insert, trackedBalls2, temporary3)
    temporary5, temporary2 = insert(trackedBalls2, temporary3)
    temporary3 = temporary5
    if not (temporary5 == nil) then
        while true do
            if temporary2.ball == ball then
                return
            end
            temporary5, temporary2 = insert(trackedBalls2, temporary3)
            temporary3 = temporary5
            if temporary5 == nil then
                insert, temporary3, trackedBalls2 = table.insert, {}, trackedBallsRef.value
                temporary3.ball = ball
                temporary5 = tick()
                temporary3.t = temporary5
                insert(trackedBalls2, temporary3)
                return
            end
        end
    end
    insert, temporary3, trackedBalls2 = table.insert, {}, trackedBallsRef.value
    temporary3.ball = ball
    temporary5 = tick()
    temporary3.t = temporary5
    insert(trackedBalls2, temporary3)
    return
end

function Handlers.tryPlayParryAnimation(animationBusyRef, playParryAnimationRef, parrySucceededRef, config, animationRecentlyPlayedRef, isParryBlockedRef, lastM1StopRef)
    local playParryAnimation2, delay, playParryAnimationRef2, finishParryAnimationCooldown
    if not config.animfix then
        return
    end
    if isParryBlockedRef.value then
        playParryAnimationRef2, delay = pcall(isParryBlockedRef.value)
        playParryAnimation2 = playParryAnimationRef2 and delay
        if playParryAnimation2 then
            return
        end
        playParryAnimationRef2 = animationRecentlyPlayedRef.value or animationBusyRef.value or lastM1StopRef.value
        if playParryAnimationRef2 then
            return
        end
        playParryAnimationRef2, animationRecentlyPlayedRef.value, animationBusyRef.value = playParryAnimationRef.value, true, true
        playParryAnimationRef2()
        playParryAnimationRef2 = {value = 0}
        playParryAnimation2, finishParryAnimationCooldown, delay = playParryAnimationRef2.value, bind(Handlers.finishParryAnimationCooldown, animationRecentlyPlayedRef, playParryAnimationRef2, parrySucceededRef, animationBusyRef), task.delay
        delay(playParryAnimation2, finishParryAnimationCooldown)
        return
    end
    playParryAnimationRef2 = animationRecentlyPlayedRef.value or animationBusyRef.value or lastM1StopRef.value
    if playParryAnimationRef2 then
        return
    end
    playParryAnimationRef2, animationRecentlyPlayedRef.value, animationBusyRef.value = playParryAnimationRef.value, true, true
    playParryAnimationRef2()
    playParryAnimationRef2 = {value = 0}
    playParryAnimation2, finishParryAnimationCooldown, delay = playParryAnimationRef2.value, bind(Handlers.finishParryAnimationCooldown, animationRecentlyPlayedRef, playParryAnimationRef2, parrySucceededRef, animationBusyRef), task.delay
    delay(playParryAnimation2, finishParryAnimationCooldown)
    return
end

-- Evaluate nearby players and send spam parries when configured.
function Handlers.trySpamParry(localPlayerRef, remoteConnections, spamCountRef, config, isPlayerAliveRef, ballPresentRef, getPingRef, value)
    local alive, clamp, character, zoomies, clamp2, temporary6, humanoidRootPart
    local huge, temporary9, clamp3, temporary11, temporary12, floor
    if not config.spamParry then
        ballPresentRef.value = false
        return
    end
    alive = isPlayerAliveRef.value()
    if not alive then
        ballPresentRef.value = false
        return
    end
    character = localPlayerRef.value.Character
    alive = not localPlayerRef.value.Character
    if localPlayerRef.value.Character then
        alive = not localPlayerRef.value.Character.PrimaryPart
    end
    if alive then
        ballPresentRef.value = false
        return
    end
    alive = workspace:FindFirstChild("Alive")
    if not alive then
        ballPresentRef.value = false
        return
    end
    clamp = nil
    huge = math.huge
    temporary9 = packValues(alive:GetChildren())
    humanoidRootPart, temporary9, zoomies = ipairs(unpackValues(temporary9))
    humanoidRootPart, temporary9, zoomies = normalizeIterator(humanoidRootPart, temporary9, zoomies)
    for index, item in humanoidRootPart, temporary9, zoomies do
        temporary6, clamp2, zoomies = index, item, index
        clamp3 = clamp2 ~= character and clamp2.PrimaryPart
        if clamp3 then
            if (character.PrimaryPart.Position - clamp2.PrimaryPart.Position).Magnitude < huge then
                huge, clamp = (character.PrimaryPart.Position - clamp2.PrimaryPart.Position).Magnitude, clamp2
            end
        end
    end
    temporary6, clamp2, zoomies = nil, nil, nil
    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        ballPresentRef.value = false
        return
    end
    temporary9 = not clamp
    if clamp then
        temporary9 = not clamp.PrimaryPart
    end
    if temporary9 then
        ballPresentRef.value = false
        return
    end
    zoomies = value:FindFirstChild("zoomies")
    if not zoomies then
        ballPresentRef.value = false
        return
    end
    zoomies = getPingRef.value()
    temporary9 = zoomies / 10
    zoomies = zoomies / 10 / 500
    clamp2 = 30.3
    clamp3 = temporary9 <= 0 or temporary9 >= 130
    if clamp3 then
        clamp3 = temporary9 <= 131 or temporary9 >= 160
        if clamp3 then
            clamp3 = temporary9 <= 161 or temporary9 >= 225
            if clamp3 then
                clamp3 = temporary9 > 226 and temporary9 < 500
                if clamp3 then
                    clamp3 = math.clamp
                    floor = math.floor
                    temporary11 = packValues(math.max(value.zoomies.VectorVelocity.Magnitude / 4 + zoomies, 32.5))
                    floor = floor(unpackValues(temporary11))
                    clamp3 = clamp3(floor, 32.5, 80)
                    clamp2 = clamp3
                end
            else
                clamp3 = math.clamp
                floor = math.floor
                temporary11 = packValues(math.max(value.zoomies.VectorVelocity.Magnitude / 4.25 + zoomies, 29.5))
                floor = floor(unpackValues(temporary11))
                clamp3 = clamp3(floor, 29.5, 70)
                clamp2 = clamp3
            end
        else
            clamp3 = math.clamp
            floor = math.floor
            temporary11 = packValues(math.max(value.zoomies.VectorVelocity.Magnitude / 4.65 + zoomies, 27.25))
            floor = floor(unpackValues(temporary11))
            clamp3 = clamp3(floor, 27.25, 70)
            clamp2 = clamp3
        end
    else
        clamp3 = math.clamp
        floor = math.floor
        temporary11 = packValues(math.max(value.zoomies.VectorVelocity.Magnitude / 5 + zoomies, 26))
        floor = floor(unpackValues(temporary11))
        clamp3 = clamp3(floor, 26, 70)
        clamp2 = clamp3
    end
    clamp3 = config.spamThreshold or 1
    clamp2 = clamp2 * clamp3
    temporary12 = remoteConnections[value] or value.Position
    temporary11 = (humanoidRootPart.Position - temporary12).Magnitude <= clamp2 * 1.5 and (humanoidRootPart.Position - clamp.PrimaryPart.Position).Magnitude <= clamp2 and spamCountRef.value > 1
    ballPresentRef.value = temporary11
    return
end

function Handlers.tryUseAbility(parryCooldownRef, ballTargetedPlayerRef, replicatedStorage, config, ballPresentRef)
    local fireAbility, failedAt, temporary3
    if not config.ability.cooldown_protection then
        return false
    end
    failedAt = ballTargetedPlayerRef.value or ballPresentRef.value or config.trigger
    if failedAt then
        return false
    end
    failedAt = parryCooldownRef.value.failed_at
    if parryCooldownRef.value.failed_at == 0 then
        return false
    end
    fireAbility = tick()
    if fireAbility - failedAt >= parryCooldownRef.value.duration then
        parryCooldownRef.value.failed_at = 0
        return false
    end
    fireAbility = bind(Handlers.fireAbility, replicatedStorage)
    temporary3 = pcall(fireAbility)
    parryCooldownRef.value.failed_at = 0
    return temporary3
end

function Handlers.undeleteItem(config, saveConfigRef, self, category, itemName)
    local result
    result = category == "Sword" and config.deleted_swords
    if result then
        config.deleted_swords[itemName] = nil
    else
        result = category == "Explosion" and config.deleted_explosions
        if result then
            config.deleted_explosions[itemName] = nil
        end
    end
    pcall(saveConfigRef.value)
    self:sync_fav_map(category)
    if self.shop_controller then
        self:refresh_shop_item(category, itemName, true)
    end
    self:refresh_selected()
    return
end

function Handlers.updateCharacterParryWatcherSafely(watchParryStateRef, value)
    pcall(watchParryStateRef.value, value)
    return
end

-- Update the local immortality transform on Heartbeat.
function Handlers.updateImmortalityTransform(runService, localPlayerRef, immortalityTransformRef, config)
    local result, temporary2, temporary3, temporary4, immortalityTransform2, immortalityTransform3, new
    local temporary8, humanoidRootPart, temporary10, cFrame, config2
    humanoidRootPart = config.immortality and localPlayerRef.value.Character and localPlayerRef.value.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        immortalityTransform3 = bind(Handlers.setPhysicsSenderRate)
        pcall(immortalityTransform3)
        humanoidRootPart = localPlayerRef.value.Character.HumanoidRootPart
        cFrame = localPlayerRef.value.Character.HumanoidRootPart.CFrame
        temporary3 = Vector3.new(0, 0.01, 0)
        humanoidRootPart.CFrame = cFrame + temporary3
        immortalityTransform3 = immortalityTransformRef.value
        immortalityTransformRef.value.CFrame = humanoidRootPart.CFrame
        immortalityTransform3.Velocity = humanoidRootPart.AssemblyLinearVelocity
        immortalityTransform3 = tick()
        cFrame = immortalityTransform3 * math.pi * 2 * config.imm.angle / 5
        temporary8 = math.floor(immortalityTransform3 * 29)
        temporary8 = temporary8 % 2 == 0 and config.imm.depth or config.imm.height
        immortalityTransform2 = immortalityTransformRef.value.CFrame
        new = Vector3.new
        temporary10 = math.cos(cFrame)
        config2 = config
        temporary4 = temporary10 * config.imm.radius
        result = math.sin(cFrame)
        config2 = config2.imm
        result = result * config2.radius
        new = new(temporary4, temporary8, result)
        humanoidRootPart.CFrame = immortalityTransform2 + new
        temporary2 = Vector3.new(0, 0, 0)
        humanoidRootPart.AssemblyLinearVelocity = temporary2
        runService.RenderStepped:Wait()
        immortalityTransform2 = immortalityTransformRef.value
        humanoidRootPart.CFrame = immortalityTransformRef.value.CFrame
        humanoidRootPart.AssemblyLinearVelocity = immortalityTransform2.Velocity
    end
    return
end

function Handlers.updateState(resetFramePositionsRef, value, otherValue)
    local result, updateControlValue, temporary3
    result = resetFramePositionsRef.value[value]
    temporary3 = result and result.SetValue
    if temporary3 then
        updateControlValue = bind(Handlers.updateControlValue, result, otherValue)
        pcall(updateControlValue)
    end
    return
end

function Handlers.value(noopSliderRef, inline, noopSliderRef2, valueText, self, otherValue)
    local result, valueText2
    valueText2 = valueText
    result = tostring(otherValue)
    valueText2.Text = result
    valueText2 = inline
    result = UDim2.fromScale(otherValue / noopSliderRef2.value, 1)
    valueText2.Size = result
    noopSliderRef.value(otherValue)
    return
end

function Handlers.waitForPlayerData(replicatedStorage, playerDataRef)
    local result, temporary2, temporary3
    result = getthreadidentity and getthreadidentity() or 2
    if setthreadidentity then
        pcall(setthreadidentity, 2)
    end
    temporary3 = require(replicatedStorage.Packages.Replion)
    temporary2 = temporary3.Client:WaitReplion("Data")
    playerDataRef.value = temporary2
    if setthreadidentity then
        pcall(setthreadidentity, result)
    end
    return
end

function Handlers.watchBallPresence(ballPresentRef)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, trainingBalls
    local temporary8
    while true do
        if ballPresentRef.value then
            temporary3 = false
            temporary4 = packValues(workspace.Balls:GetChildren())
            trainingBalls, temporary4, temporary8 = pairs(unpackValues(temporary4))
            trainingBalls, temporary4, temporary8 = normalizeIterator(trainingBalls, temporary4, temporary8)
            result, temporary6 = trainingBalls(temporary4, temporary8)
            temporary8 = result
            if not (result == nil) then
                while true do
                    temporary5 = temporary6:GetAttribute("realBall")
                    if temporary5 then
                        temporary3 = true
                        break
                    else
                        result, temporary6 = trainingBalls(temporary4, temporary8)
                        temporary8 = result
                        if result == nil then
                            break
                        else
                            continue
                        end
                    end
                    break
                end
            end
            if not temporary3 then
                trainingBalls = workspace:FindFirstChild("TrainingBalls")
                if trainingBalls then
                    temporary8 = packValues(trainingBalls:GetChildren())
                    temporary4, temporary8, result = pairs(unpackValues(temporary8))
                    temporary4, temporary8, result = normalizeIterator(temporary4, temporary8, result)
                    temporary6, temporary5 = temporary4(temporary8, result)
                    result = temporary6
                    if not (temporary6 == nil) then
                        while true do
                            temporary2 = temporary5:GetAttribute("realBall")
                            if temporary2 then
                                temporary3 = true
                                break
                            else
                                temporary6, temporary5 = temporary4(temporary8, result)
                                result = temporary6
                                if temporary6 == nil then
                                    break
                                else
                                    continue
                                end
                            end
                            break
                        end
                    end
                end
            end
            if not temporary3 then
                ballPresentRef.value = false
            end
        end
        task.wait(0.1)
    end
end

function Handlers.watchBallTarget(localPlayerRef, trackBallRef, ballCurveStates, config, ballPresentRef, ballTargetedPlayerRef, ballConnectionsRef, ball)
    local ballTargetedPlayerRef2, clearTrackedBallTarget, once, once2
    ballTargetedPlayerRef2 = not config.trigger
    if config.trigger then
        ballTargetedPlayerRef2 = ballTargetedPlayerRef.value
    end
    if not ballTargetedPlayerRef2 then
        ballTargetedPlayerRef2 = ballPresentRef.value
    end
    if ballTargetedPlayerRef2 then
        return
    end
    ballTargetedPlayerRef2 = ball:GetDebugId()
    ballTargetedPlayerRef2 = {value = ballTargetedPlayerRef2}
    once = ball:GetAttribute("target")
    once2 = once == localPlayerRef.value.Name and not ballConnectionsRef.value[ballTargetedPlayerRef2.value]
    if once2 then
        ballConnectionsRef.value[ballTargetedPlayerRef2.value] = true
        trackBallRef.value(ball)
        once2 = ball:GetAttributeChangedSignal("target")
        once2, clearTrackedBallTarget, once = once2.Once, bind(Handlers.clearTrackedBallTarget, ballConnectionsRef, ballTargetedPlayerRef2, ballCurveStates), once2
        once2(once, clearTrackedBallTarget)
    end
    return
end

function Handlers.watchCharacterParryState(parryCooldownRef, character)
    local onParryingChanged, parryCooldown2, connect, connect2
    if not character then
        return
    end
    if parryCooldownRef.value.conn then
        parryCooldownRef.value.conn:Disconnect()
        parryCooldownRef.value.conn = nil
    end
    parryCooldown2 = parryCooldownRef.value
    connect = character:GetAttribute("Parrying")
    parryCooldown2.last_parrying = connect
    parryCooldown2.failed_at = 0
    connect = character:GetAttributeChangedSignal("Parrying")
    connect, connect2, onParryingChanged = connect.Connect, connect, bind(Handlers.onParryingChanged, character, parryCooldownRef)
    connect = connect(connect2, onParryingChanged)
    parryCooldown2.conn = connect
    return
end

function Handlers.watchPeakBallSpeed(config, ballSpeedStateRef)
    local balls, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    local ball, temporary9
    temporary2 = nil
    while true do
        if config.showStats then
            balls = workspace:FindFirstChild("Balls")
            if balls then
                temporary6 = nil
                temporary9 = packValues(balls:GetChildren())
                temporary5, temporary9, temporary7 = pairs(unpackValues(temporary9))
                temporary5, temporary9, temporary7 = normalizeIterator(temporary5, temporary9, temporary7)
                temporary4, ball = temporary5(temporary9, temporary7)
                temporary7 = temporary4
                if not (temporary4 == nil) then
                    while true do
                        temporary3 = ball:GetAttribute("realBall")
                        if temporary3 then
                            temporary3 = ball:GetDebugId()
                            temporary6 = temporary3
                            break
                        else
                            temporary4, ball = temporary5(temporary9, temporary7)
                            temporary7 = temporary4
                            if temporary4 == nil then
                                break
                            else
                                continue
                            end
                        end
                        break
                    end
                end
                temporary5 = temporary6 and temporary6 ~= temporary2
                if temporary5 then
                    ballSpeedStateRef.value.peak = 0
                    temporary2 = temporary6
                end
            end
        end
        task.wait(0.2)
    end
end

-- ============================================================================
-- Appearance and performance
-- ============================================================================

function Handlers.applyCapturedAppearance(applyAppearanceRef, character)
    applyAppearanceRef.value(character)
    return
end

function Handlers.applyCharacterAppearance(restoreRightLegRef, restoreHeadRef, hideHeadRef, cacheRightLegRef, hideRightLegRef, config, value)
    if not value then
        return
    end
    cacheRightLegRef.value(value)
    if config.optim.korblox then
        hideRightLegRef.value(value)
    else
        restoreRightLegRef.value(value)
    end
    if config.optim.headless then
        hideHeadRef.value(value)
    else
        restoreHeadRef.value(value)
    end
    return
end

function Handlers.applyNetworkBandwidthLimit()
    local setNetworkBandwidthLimit
    setNetworkBandwidthLimit = bind(Handlers.setNetworkBandwidthLimit)
    pcall(setNetworkBandwidthLimit)
    return
end

function Handlers.applyOptimization(disableNetworkOverrideRef, disableNoRenderRef, applyAppearanceRef, enableParticleCleanupRef, enableNetworkOverrideRef, disableParticleCleanupRef, enableNoRenderRef, localPlayerRef, value, otherValue)
    local result
    if value == "destroyParticles" then
        if otherValue then
            enableParticleCleanupRef.value()
        else
            disableParticleCleanupRef.value()
        end
    else
        if value == "unlimitedKBPS" then
            if otherValue then
                enableNetworkOverrideRef.value()
            else
                disableNetworkOverrideRef.value()
            end
        else
            if value == "noRender" then
                if otherValue then
                    enableNoRenderRef.value()
                else
                    disableNoRenderRef.value()
                end
            else
                result = value == "headless" or value == "korblox"
                if result then
                    if localPlayerRef.value.Character then
                        applyAppearanceRef.value(localPlayerRef.value.Character)
                    end
                end
            end
        end
    end
    return
end

function Handlers.cacheRightLegAppearance(appearanceCacheRef, character)
    local result, temporary2, temporary3, temporary4, temporary5, insert, temporary7
    local temporary8, rightLegChildren
    temporary7 = character:FindFirstChild("RightLeg") or character:FindFirstChild("Right Leg")
    if not temporary7 then
        return
    end
    if not appearanceCacheRef.value[character] then
        temporary4 = {}
        appearanceCacheRef.value[character] = temporary4
    end
    if not appearanceCacheRef.value[character].rightLegChildren then
        temporary4 = {}
        appearanceCacheRef.value[character].rightLegChildren = temporary4
        temporary3 = packValues(temporary7:GetChildren())
        temporary8, temporary3, temporary4 = ipairs(unpackValues(temporary3))
        temporary8, temporary3, temporary4 = normalizeIterator(temporary8, temporary3, temporary4)
        for index, item in temporary8, temporary3, temporary4 do
            temporary5, temporary2, temporary4 = index, item, index
            insert = temporary2:IsA("SpecialMesh")
            if insert then
                insert = table.insert
                rightLegChildren, result = appearanceCacheRef.value[character].rightLegChildren, {}
                result.MeshId = temporary2.MeshId
                result.TextureId = temporary2.TextureId
                result.Scale = temporary2.Scale
                insert(rightLegChildren, result)
            end
        end
        temporary5, temporary2, temporary4 = nil, nil, nil
    end
    return
end

function Handlers.clearTerrainWaterEffects()
    local result, terrain, temporary3, temporary4, temporary5, temporary6, temporary7
    terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterTransparency = 1
        terrain.WaterReflectance = 0
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        temporary4 = packValues(terrain:GetDescendants())
        temporary6, temporary4, temporary5 = ipairs(unpackValues(temporary4))
        temporary6, temporary4, temporary5 = normalizeIterator(temporary6, temporary4, temporary5)
        for index, item in temporary6, temporary4, temporary5 do
            temporary7, result, temporary5 = index, item, index
            temporary3 = result:IsA("Texture") or result:IsA("Decal")
            if temporary3 then
                result.Transparency = 1
            end
        end
        temporary7, result, temporary5 = nil, nil, nil
    end
    return
end

function Handlers.clearVisualEffects(isVisualEffectRef, camera)
    local delay, temporary2Ref, temporary3, temporary4, removeVisualEffectSafely, temporary6, temporary7
    local temporary8
    temporary8 = packValues(workspace:GetDescendants())
    temporary3, temporary8, temporary7 = ipairs(unpackValues(temporary8))
    temporary3, temporary8, temporary7 = normalizeIterator(temporary3, temporary8, temporary7)
    for index, item in temporary3, temporary8, temporary7 do
        temporary6, temporary4, temporary7 = index, item, index
        temporary2Ref = isVisualEffectRef.value(temporary4)
        if temporary2Ref then
            temporary2Ref = {value = temporary4}
            delay, removeVisualEffectSafely = task.delay, bind(Handlers.removeVisualEffectSafely, temporary2Ref)
            delay(0, removeVisualEffectSafely)
        end
    end
    temporary6, temporary4, temporary7 = nil, nil, nil
    temporary8 = packValues(camera:GetDescendants())
    temporary3, temporary8, temporary7 = ipairs(unpackValues(temporary8))
    temporary3, temporary8, temporary7 = normalizeIterator(temporary3, temporary8, temporary7)
    for index2, item2 in temporary3, temporary8, temporary7 do
        temporary6, temporary4, temporary7 = index2, item2, index2
        temporary2Ref = isVisualEffectRef.value(temporary4)
        if temporary2Ref then
            temporary2Ref = {value = temporary4}
            delay, removeVisualEffectSafely = task.delay, bind(Handlers.removeVisualEffectSafely, temporary2Ref)
            delay(0, removeVisualEffectSafely)
        end
    end
    temporary6, temporary4, temporary7 = nil, nil, nil
    return
end

function Handlers.destroyVisualEffectSafely(instance)
    local destroyCapturedInstance
    destroyCapturedInstance = bind(Handlers.destroyCapturedInstance, instance)
    pcall(destroyCapturedInstance)
    return
end

function Handlers.disableClientEffects(localPlayerRef)
    localPlayerRef.value.PlayerScripts.EffectScripts.ClientFX.Disabled = false
    return
end

function Handlers.disableNetworkRateOverride(optimizationStateRef, optimizationConnections)
    if not optimizationStateRef.value.unlimitedKBPS then
        return
    end
    optimizationStateRef.value.unlimitedKBPS = false
    if optimizationConnections.unlimitedKBPS then
        optimizationConnections.unlimitedKBPS:Disconnect()
        optimizationConnections.unlimitedKBPS = nil
    end
    return
end

function Handlers.disableNoRender(optimizationStateRef, localPlayerRef, optimizationConnections)
    local disableClientEffects
    if not optimizationStateRef.value.noRender then
        return
    end
    optimizationStateRef.value.noRender = false
    disableClientEffects = bind(Handlers.disableClientEffects, localPlayerRef)
    pcall(disableClientEffects)
    if optimizationConnections.noRender then
        optimizationConnections.noRender:Disconnect()
        optimizationConnections.noRender = nil
    end
    return
end

function Handlers.disableParticleCleanup(optimizationStateRef, optimizationConnections)
    if not optimizationStateRef.value.destroyParticles then
        return
    end
    optimizationStateRef.value.destroyParticles = false
    if optimizationConnections.destroyParticles then
        optimizationConnections.destroyParticles:Disconnect()
        optimizationConnections.destroyParticles = nil
    end
    if optimizationConnections.charAdded then
        optimizationConnections.charAdded:Disconnect()
        optimizationConnections.charAdded = nil
    end
    return
end

function Handlers.enableClientEffects(localPlayerRef)
    localPlayerRef.value.PlayerScripts.EffectScripts.ClientFX.Disabled = true
    return
end

function Handlers.enableNetworkRateOverride(optimizationStateRef, optimizationConnections, runService)
    local preSimulation, optimizationConnections2, preSimulation2, applyNetworkBandwidthLimit
    if optimizationStateRef.value.unlimitedKBPS then
        return
    end
    optimizationStateRef.value.unlimitedKBPS = true
    optimizationConnections2 = optimizationConnections
    preSimulation, applyNetworkBandwidthLimit = runService.PreSimulation, bind(Handlers.applyNetworkBandwidthLimit)
    preSimulation, preSimulation2 = preSimulation.Connect, preSimulation
    preSimulation = preSimulation(preSimulation2, applyNetworkBandwidthLimit)
    optimizationConnections2.unlimitedKBPS = preSimulation
    return
end

function Handlers.enableNoRender(optimizationStateRef, localPlayerRef, optimizationConnections)
    local removeRuntimeEffectSafely, runtime, childAdded, childAdded2, optimizationConnections2
    if optimizationStateRef.value.noRender then
        return
    end
    optimizationStateRef.value.noRender = true
    optimizationConnections2 = bind(Handlers.enableClientEffects, localPlayerRef)
    pcall(optimizationConnections2)
    runtime = workspace:FindFirstChild("Runtime")
    if runtime then
        childAdded2, optimizationConnections2, removeRuntimeEffectSafely = runtime.ChildAdded, optimizationConnections, bind(Handlers.removeRuntimeEffectSafely, optimizationStateRef)
        childAdded2, childAdded = childAdded2.Connect, childAdded2
        childAdded2 = childAdded2(childAdded, removeRuntimeEffectSafely)
        optimizationConnections2.noRender = childAdded2
    end
    return
end

function Handlers.enableParticleCleanup(optimizationConnections, localPlayerRef, isVisualEffectRef, optimizationStateRef, clearVisualEffectsRef, clearCloudsRef)
    local descendantAdded, onVisualEffectAdded, descendantAdded2, optimizationConnections2
    if optimizationStateRef.value.destroyParticles then
        return
    end
    optimizationStateRef.value.destroyParticles = true
    clearCloudsRef.value()
    clearVisualEffectsRef.value()
    optimizationConnections2 = optimizationConnections
    onVisualEffectAdded, descendantAdded = bind(Handlers.onVisualEffectAdded, isVisualEffectRef), game.DescendantAdded
    descendantAdded, descendantAdded2 = descendantAdded.Connect, descendantAdded
    descendantAdded = descendantAdded(descendantAdded2, onVisualEffectAdded)
    optimizationConnections2.destroyParticles = descendantAdded
    descendantAdded, onVisualEffectAdded = localPlayerRef.value.CharacterAdded, bind(Handlers.refreshCharacterEffectsAfterDelay, clearCloudsRef, clearVisualEffectsRef)
    descendantAdded, descendantAdded2 = descendantAdded.Connect, descendantAdded
    descendantAdded = descendantAdded(descendantAdded2, onVisualEffectAdded)
    optimizationConnections2.charAdded = descendantAdded
    return
end

function Handlers.hideHead(character)
    local result, temporary2, temporary3, temporary4, head, temporary6, temporary7
    head = character:FindFirstChild("Head")
    if not head then
        return
    end
    head.Transparency = 1
    temporary2 = packValues(head:GetChildren())
    temporary6, temporary2, temporary3 = ipairs(unpackValues(temporary2))
    temporary6, temporary2, temporary3 = normalizeIterator(temporary6, temporary2, temporary3)
    for index, item in temporary6, temporary2, temporary3 do
        result, temporary7, temporary3 = index, item, index
        temporary4 = temporary7:IsA("Decal")
        if temporary4 then
            temporary7.Transparency = 1
        end
    end
    result, temporary7, temporary3 = nil, nil, nil
    return
end

function Handlers.hideRightLeg(character)
    local specialMesh, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    temporary5 = character:FindFirstChild("RightLeg") or character:FindFirstChild("Right Leg")
    if not temporary5 then
        return
    end
    temporary3 = packValues(temporary5:GetChildren())
    specialMesh, temporary3, temporary2 = ipairs(unpackValues(temporary3))
    specialMesh, temporary3, temporary2 = normalizeIterator(specialMesh, temporary3, temporary2)
    for index, item in specialMesh, temporary3, temporary2 do
        temporary7, temporary4, temporary2 = index, item, index
        temporary6 = temporary4:IsA("SpecialMesh")
        if temporary6 then
            temporary4:Destroy()
        end
    end
    temporary7, temporary4, temporary2 = nil, nil, nil
    specialMesh = Instance.new("SpecialMesh")
    specialMesh.MeshId = "rbxassetid://101851696"
    specialMesh.TextureId = "rbxassetid://115727863"
    temporary3 = Vector3.new(1, 1, 1)
    specialMesh.Scale = temporary3
    specialMesh.Parent = temporary5
    return
end

function Handlers.isVisualEffect(value)
    local result, temporary2
    temporary2 = not value
    if value then
        temporary2 = not value.Parent
    end
    if temporary2 then
        return false
    end
    result = value.ClassName == "ParticleEmitter" or value.ClassName == "Trail" or value.ClassName == "Beam" or value.ClassName == "Smoke" or value.ClassName == "Fire" or value.ClassName == "Sparkles" or value.ClassName == "Explosion" or value.ClassName == "Highlight" or value.ClassName == "SurfaceAppearance"
    return result
end

function Handlers.onVisualEffectAdded(isVisualEffectRef, value)
    local destroyVisualEffectSafely, removeVisualEffectSafely, delayRef, delay2
    delayRef = isVisualEffectRef.value(value)
    if delayRef then
        delayRef = {value = value}
        removeVisualEffectSafely, delay2 = bind(Handlers.removeVisualEffectSafely, delayRef), task.delay
        delay2(0, removeVisualEffectSafely)
    end
    delayRef = value:IsA("Clouds")
    if delayRef then
        destroyVisualEffectSafely, delayRef = bind(Handlers.destroyVisualEffectSafely, value), task.delay
        delayRef(0, destroyVisualEffectSafely)
    end
    return
end

function Handlers.removeCloudsAndWaterEffects(lighting)
    local removeLightingClouds
    removeLightingClouds = bind(Handlers.removeLightingClouds, lighting)
    pcall(removeLightingClouds)
    removeLightingClouds = bind(Handlers.clearTerrainWaterEffects)
    pcall(removeLightingClouds)
    return
end

function Handlers.removeLightingClouds(lighting)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6
    result = packValues(lighting:GetChildren())
    temporary2, result, temporary3 = ipairs(unpackValues(result))
    temporary2, result, temporary3 = normalizeIterator(temporary2, result, temporary3)
    for index, item in temporary2, result, temporary3 do
        temporary5, temporary4, temporary3 = index, item, index
        temporary6 = temporary4:IsA("Clouds")
        if temporary6 then
            temporary4.Parent = nil
        end
    end
    temporary5, temporary4, temporary3 = nil, nil, nil
    return
end

function Handlers.removeVisualEffectSafely(delayRef)
    local disableAndDestroyEffect
    disableAndDestroyEffect = bind(Handlers.disableAndDestroyEffect, delayRef)
    pcall(disableAndDestroyEffect)
    return
end

function Handlers.restoreHead(character)
    local result, temporary2, temporary3, temporary4, temporary5, head, temporary7
    head = character:FindFirstChild("Head")
    if not head then
        return
    end
    head.Transparency = 0
    result = packValues(head:GetChildren())
    temporary3, result, temporary7 = ipairs(unpackValues(result))
    temporary3, result, temporary7 = normalizeIterator(temporary3, result, temporary7)
    for index, item in temporary3, result, temporary7 do
        temporary2, temporary5, temporary7 = index, item, index
        temporary4 = temporary5:IsA("Decal")
        if temporary4 then
            temporary5.Transparency = 0
        end
    end
    temporary2, temporary5, temporary7 = nil, nil, nil
    return
end

function Handlers.restoreRightLeg(appearanceCacheRef, character)
    local specialMesh, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    temporary5 = character:FindFirstChild("RightLeg") or character:FindFirstChild("Right Leg")
    if not temporary5 then
        return
    end
    temporary4 = packValues(temporary5:GetChildren())
    temporary6, temporary4, temporary2 = ipairs(unpackValues(temporary4))
    temporary6, temporary4, temporary2 = normalizeIterator(temporary6, temporary4, temporary2)
    for index, item in temporary6, temporary4, temporary2 do
        temporary3, temporary7, temporary2 = index, item, index
        specialMesh = temporary7:IsA("SpecialMesh")
        if specialMesh then
            temporary7:Destroy()
        end
    end
    temporary3, temporary7, temporary2 = nil, nil, nil
    temporary6 = appearanceCacheRef.value[character] and appearanceCacheRef.value[character].rightLegChildren
    if temporary6 then
        temporary6, temporary4, temporary2 = ipairs(appearanceCacheRef.value[character].rightLegChildren)
        temporary6, temporary4, temporary2 = normalizeIterator(temporary6, temporary4, temporary2)
        for index2, item2 in temporary6, temporary4, temporary2 do
            temporary3, temporary7, temporary2 = index2, item2, index2
            specialMesh = Instance.new("SpecialMesh")
            specialMesh.MeshId = temporary7.MeshId
            specialMesh.TextureId = temporary7.TextureId
            specialMesh.Scale = temporary7.Scale
            specialMesh.Parent = temporary5
        end
        temporary3, temporary7, temporary2 = nil, nil, nil
    end
    return
end

function Handlers.setHeadlessEnabled(saveConfigRef, localPlayerRef, applyAppearanceRef, config, headless)
    config.optim.headless = headless
    if localPlayerRef.value.Character then
        applyAppearanceRef.value(localPlayerRef.value.Character)
    end
    saveConfigRef.value()
    return
end

function Handlers.setNetworkBandwidthLimit()
    local networkClient, networkClient2
    networkClient2 = game:GetService("NetworkClient")
    networkClient, networkClient2 = networkClient2, networkClient2.SetOutgoingKBPSLimit
    networkClient2(networkClient, math.huge)
    return
end

function Handlers.setNetworkRateOverrideEnabled(config, applyOptimizationRef, saveConfigRef, unlimitedKBPS)
    config.optim.unlimitedKBPS = unlimitedKBPS
    applyOptimizationRef.value("unlimitedKBPS", unlimitedKBPS)
    saveConfigRef.value()
    return
end

function Handlers.setNoRenderEnabled(config, applyOptimizationRef, saveConfigRef, noRender)
    config.optim.noRender = noRender
    applyOptimizationRef.value("noRender", noRender)
    saveConfigRef.value()
    return
end

function Handlers.updateHeader(headName, labelRef, self, otherValue, otherValue2)
    local result, temporary2
    result = otherValue or "NEVERLOSE"
    headName.Text = result
    temporary2 = labelRef.value and otherValue2
    if temporary2 then
        result = otherValue2 or "Script Hub"
        labelRef.value.Text = result
    end
    return
end

function Handlers.watchCharacterAppearance(localPlayerRef, config, applyAppearanceRef)
    local result
    while true do
        result = task.wait(1.5)
        if result then
            result = localPlayerRef.value.Character and (config.optim.korblox or config.optim.headless)
            if result then
                applyAppearanceRef.value(localPlayerRef.value.Character)
                continue
            else
                continue
            end
        else
            break
        end
    end
    return
end

-- ============================================================================
-- Cosmetics and shop
-- ============================================================================

function Handlers.applyCapturedChroma(swordController, setSwordOverrideRef, getEquippedSwordRef)
    swordController:apply_chroma(setSwordOverrideRef.value, getEquippedSwordRef.value)
    return
end

function Handlers.applyCharacterChroma(swordController, swordModel, getCharacterSwordRef)
    swordController:apply_chroma(swordModel, getCharacterSwordRef.value)
    return
end

function Handlers.applyChroma(self, otherValue, otherValue2)
    local result, temporary2
    result = otherValue2.ColorConfig or otherValue2.TweenColorConfig
    if not result then
        temporary2 = otherValue2.Name:find("Chroma") or otherValue2.Name:find("Rainbow")
        if temporary2 then
            result = "Chroma"
        end
    end
    if result then
        otherValue:SetAttribute("ColorConfig", result)
        otherValue:AddTag("TweenColor")
    end
    return
end

function Handlers.bindShadow(self, otherValue, otherValue2)
    local getPropertyChangedSignal, enforceShopShadowVisibility, getPropertyChangedSignal2, shadowConnections
    if self.shadow_connections[otherValue2] then
        return
    end
    getPropertyChangedSignal, enforceShopShadowVisibility, getPropertyChangedSignal2, shadowConnections = otherValue2, bind(Handlers.enforceShopShadowVisibility, self, otherValue, otherValue2), otherValue2.GetPropertyChangedSignal, self.shadow_connections
    getPropertyChangedSignal2 = getPropertyChangedSignal2(getPropertyChangedSignal, "Enabled")
    getPropertyChangedSignal2, getPropertyChangedSignal = getPropertyChangedSignal2.Connect, getPropertyChangedSignal2
    getPropertyChangedSignal2 = getPropertyChangedSignal2(getPropertyChangedSignal, enforceShopShadowVisibility)
    shadowConnections[otherValue2] = getPropertyChangedSignal2
    enforceShopShadowVisibility()
    return
end

function Handlers.callRefreshSelected(cosmetics)
    cosmetics:refresh_selected()
    return
end

function Handlers.callSlotFavVisual(category, shopController, cosmetics, itemCollection)
    local result, temporary2, temporary3, shadow, temporary5, temporary6, temporary7
    local temporary8, temporary9
    temporary3, temporary9, temporary8 = pairs(itemCollection)
    temporary3, temporary9, temporary8 = normalizeIterator(temporary3, temporary9, temporary8)
    for index, item in temporary3, temporary9, temporary8 do
        temporary5, result, temporary8 = index, item, index
        temporary2, temporary7 = pcall(shopController.Scroll.GetRenderedSlot, itemCollection, result)
        shadow = temporary2 and temporary7
        if shadow then
            cosmetics:slot_fav_visual(category, temporary7)
            shadow = temporary7:FindFirstChild("Shadow")
            if shadow then
                if cosmetics.unlocked[category] then
                    cosmetics:bind_shadow(category, shadow)
                else
                    temporary6 = result.OwnsItem:Get()
                    shadow.Enabled = not temporary6
                end
            end
        end
    end
    temporary5, result, temporary8 = nil, nil, nil
    return
end

function Handlers.disableSwordEquipGuard(swordController)
    local result, equipSwordTo, temporary3, temporary4, temporary5, temporary6
    equipSwordTo = swordController.swords.EquipSwordTo
    temporary3 = packValues(debug.getupvalues(swordController.swords.EquipSwordTo))
    result, temporary3, temporary4 = pairs(unpackValues(temporary3))
    result, temporary3, temporary4 = normalizeIterator(result, temporary3, temporary4)
    temporary5, temporary6 = result(temporary3, temporary4)
    temporary4 = temporary5
    if not (temporary5 == nil) then
        while true do
            if temporary6 == true then
                debug.setupvalue(equipSwordTo, temporary5, false)
                break
            else
                temporary5, temporary6 = result(temporary3, temporary4)
                temporary4 = temporary5
                if temporary5 == nil then
                    break
                else
                    continue
                end
            end
            break
        end
    end
    return
end

function Handlers.enforceShopShadowVisibility(cosmetics, category, shadow)
    local result
    result = cosmetics.unlocked[category] and shadow.Parent and shadow.Enabled
    if result then
        shadow.Enabled = false
    end
    return
end

function Handlers.ensureExplosionHook(cosmeticsRef, localPlayerRef, value)
    local playExplosionOverride, explosionModule
    explosionModule = value.explosion_hooked or not value.explosion_module
    if explosionModule then
        return
    end
    value.explosion_hooked = true
    value.explosion_original = value.explosion_module.PlayExplosion
    playExplosionOverride, explosionModule = bind(Handlers.playExplosionOverride, cosmeticsRef, localPlayerRef), value.explosion_module
    explosionModule.PlayExplosion = playExplosionOverride
    return
end

function Handlers.equipExplosion(config, self, explosionName)
    local result
    result = self:is_deleted("Explosion", explosionName)
    if result then
        self:undelete_item("Explosion", explosionName)
    end
    self.selected_explosion = explosionName
    config.last_equipped_explosion = explosionName
    self:ensure_explosion_wrap()
    return true
end

function Handlers.equipSelectedShopItem(cosmetics, buyButton)
    local result, temporary2, selectedItem, temporary4, temporary5, temporary6
    selectedItem = cosmetics.shop_controller._selectedItem
    if not cosmetics.shop_controller._selectedItem then
        return
    end
    temporary4 = cosmetics.enabled and cosmetics.unlocked[cosmetics.shop_controller._selectedItem.type]
    if temporary4 then
        temporary4 = cosmetics:is_deleted(cosmetics.shop_controller._selectedItem.type, cosmetics.shop_controller._selectedItem.name)
        if temporary4 then
            cosmetics:undelete_item(selectedItem.type, selectedItem.name)
        end
        if selectedItem.type == "Sword" then
            temporary4 = cosmetics:equip_sword(selectedItem.name, false)
            if temporary4 then
                buyButton.PriceTag.TextLabel.Text = "Equipped"
            end
            return
        end
        if selectedItem.type == "Explosion" then
            cosmetics:equip_explosion(selectedItem.name)
            buyButton.PriceTag.TextLabel.Text = "Equipped"
            return
        end
        temporary4, temporary5, result = ipairs(cosmetics.original_buy_fns)
        temporary4, temporary5, result = normalizeIterator(temporary4, temporary5, result)
        for index, item in temporary4, temporary5, result do
            temporary2, temporary6, result = index, item, index
            task.spawn(temporary6)
        end
        temporary2, temporary6, result = nil, nil, nil
        return
    end
    temporary4, temporary5, result = ipairs(cosmetics.original_buy_fns)
    temporary4, temporary5, result = normalizeIterator(temporary4, temporary5, result)
    for index2, item2 in temporary4, temporary5, result do
        temporary2, temporary6, result = index2, item2, index2
        task.spawn(temporary6)
    end
    temporary2, temporary6, result = nil, nil, nil
    return
end

function Handlers.equipSelectedSwordDeferred(cosmetics, selectedSwordRef)
    local result
    result = cosmetics.enabled and cosmetics.selected_sword == selectedSwordRef.value
    if result then
        cosmetics:equip_sword(selectedSwordRef.value, false)
    end
    return
end

function Handlers.equipSword(config, swordOverrideEnabledRef, swordOverrideNameRef, localPlayerRef, self, swordName, forceEquip)
    local disableSwordEquipGuard, equipSwordOnCharacter, setSwordOverrideRef, characterRef, getEquippedSwordRef, temporary6
    if not self.swords then
        return false
    end
    getEquippedSwordRef = bind(Handlers.getEquippedSword, self, swordName)
    temporary6, getEquippedSwordRef = pcall(getEquippedSwordRef)
    getEquippedSwordRef = {value = getEquippedSwordRef}
    characterRef = not temporary6
    if temporary6 then
        characterRef = not getEquippedSwordRef.value
    end
    if characterRef then
        return false
    end
    characterRef = {value = localPlayerRef.value.Character}
    if not characterRef.value then
        return false
    end
    setSwordOverrideRef = not forceEquip and not self.original_sword
    if setSwordOverrideRef then
        setSwordOverrideRef = localPlayerRef.value:GetAttribute("CurrentlyEquippedSword") or characterRef.value:GetAttribute("CurrentlyEquippedSword")
        self.original_sword = setSwordOverrideRef
    end
    if forceEquip then
        self.selected_sword = nil
        swordOverrideEnabledRef.value = false
        swordOverrideNameRef.value = ""
    else
        self.selected_sword = getEquippedSwordRef.value.Name
        config.last_equipped_sword = getEquippedSwordRef.value.Name
        swordOverrideEnabledRef.value = true
        swordOverrideNameRef.value, setSwordOverrideRef, disableSwordEquipGuard = getEquippedSwordRef.value.Name, self.set_sword_override, self
        setSwordOverrideRef(disableSwordEquipGuard, true)
    end
    localPlayerRef.value:SetAttribute("CurrentlyEquippedSword", getEquippedSwordRef.value.Name)
    characterRef.value:SetAttribute("CurrentlyEquippedSword", getEquippedSwordRef.value.Name)
    disableSwordEquipGuard = bind(Handlers.disableSwordEquipGuard, self)
    pcall(disableSwordEquipGuard)
    equipSwordOnCharacter = bind(Handlers.equipSwordOnCharacter, self, characterRef, getEquippedSwordRef)
    disableSwordEquipGuard = pcall(equipSwordOnCharacter)
    if not disableSwordEquipGuard then
        return false
    end
    setSwordOverrideRef = characterRef.value:FindFirstChild(getEquippedSwordRef.value.Name)
    setSwordOverrideRef = {value = setSwordOverrideRef}
    if setSwordOverrideRef.value then
        equipSwordOnCharacter = bind(Handlers.applyCapturedChroma, self, setSwordOverrideRef, getEquippedSwordRef)
        pcall(equipSwordOnCharacter)
    end
    if self.sword_fn then
        pcall(self.sword_fn, getEquippedSwordRef.value.Name)
    end
    return true
end

function Handlers.equipSwordOnCharacter(swordController, characterRef, getEquippedSwordRef)
    swordController.swords:EquipSwordTo(characterRef.value, getEquippedSwordRef.value.Name)
    return
end

function Handlers.getCharacterSword(swordController, swordModel)
    local result
    result = packValues(swordController.swords:GetSword(swordModel.Name))
    return unpackValues(result)
end

function Handlers.getEquippedSword(swordController, swordName)
    local result
    result = packValues(swordController.swords:GetSword(swordName))
    return unpackValues(result)
end

function Handlers.getSwordCollection(swordController)
    local result
    result = packValues(swordController.swords:GetCollection())
    return unpackValues(result)
end

function Handlers.getSwordConnectionFunction(connectionRef)
    return connectionRef.value.Function
end

function Handlers.getSwordDefinition(swordAnimationsRef, swordName)
    local result
    result = packValues(swordAnimationsRef.value:GetSword(swordName))
    return unpackValues(result)
end

function Handlers.getSwordParryAnimation(getSwordParryAnimationRef, character, getSwordParryAnimationRef2, swordControllerRef)
    local character2, swordController2, temporary3, swordController3
    swordController3, character2, temporary3 = swordControllerRef.value, character, {}
    temporary3[1], temporary3[2] = "Parry", "GrabParry"
    swordController3, swordController2 = swordController3.GetAnimations, swordController3
    swordController3 = packValues(swordController3(swordController2, character2, temporary3, getSwordParryAnimationRef2.value, getSwordParryAnimationRef.value))
    return unpackValues(swordController3)
end

function Handlers.hookChroma(localPlayerRef, value)
    local onCosmeticCharacterAdded, refreshLocalCosmeticCharacter, characterAdded
    if value.chroma_bound then
        return
    end
    value.chroma_bound = true
    characterAdded, onCosmeticCharacterAdded = localPlayerRef.value.CharacterAdded, bind(Handlers.onCosmeticCharacterAdded, value)
    refreshLocalCosmeticCharacter, characterAdded = characterAdded, characterAdded.Connect
    characterAdded = characterAdded(refreshLocalCosmeticCharacter, onCosmeticCharacterAdded)
    value.added_connection = characterAdded
    if localPlayerRef.value.Character then
        refreshLocalCosmeticCharacter, characterAdded = bind(Handlers.refreshLocalCosmeticCharacter, value, localPlayerRef), task.defer
        characterAdded(refreshLocalCosmeticCharacter)
    end
    characterAdded = localPlayerRef.value:GetAttributeChangedSignal("CurrentlyEquippedSword")
    refreshLocalCosmeticCharacter, onCosmeticCharacterAdded, characterAdded = characterAdded, bind(Handlers.refreshEquippedSwordAttribute, value, localPlayerRef), characterAdded.Connect
    characterAdded = characterAdded(refreshLocalCosmeticCharacter, onCosmeticCharacterAdded)
    value.sword_attr_connection = characterAdded
    return
end

function Handlers.hookModernShop(cosmeticsRef, self)
    local shopApi, setEquipped
    shopApi = self.shop_api
    setEquipped = not shopApi
    if shopApi then
        setEquipped = self.original_set_equipped
    end
    if setEquipped then
        return
    end
    setEquipped = type(shopApi.SetEquipped)
    if setEquipped ~= "function" then
        return
    end
    self.original_set_equipped = shopApi.SetEquipped
    setEquipped = bind(Handlers.setEquipped, shopApi, cosmeticsRef, self)
    shopApi.SetEquipped = setEquipped
    return
end

function Handlers.hookModernShopDeferred(cosmetics)
    cosmetics:hook_modern_shop()
    return
end

function Handlers.hookShop(localPlayerRef, self)
    local result, toggleSelectedItemFavorite, temporary3, temporary4, guiServiceRef, temporary6, temporary7
    local playerGui, scheduleVisibleShopRefresh, toggleSelectedItemDeleted, playerGui2, guiService2
    playerGui = localPlayerRef.value:WaitForChild("PlayerGui")
    playerGui2, playerGui = playerGui, playerGui.FindFirstChild
    playerGui = playerGui(playerGui2, "Shop")
    playerGui2 = playerGui and playerGui:FindFirstChild("Holder")
    temporary6 = playerGui2 and playerGui2:FindFirstChild("InfoBG")
    temporary7 = temporary6 and temporary6:FindFirstChild("BuyButton")
    guiServiceRef = not playerGui
    if playerGui then
        guiServiceRef = not temporary7
    end
    if guiServiceRef then
        return false
    end
    self.shop = playerGui
    guiServiceRef = type(getconnections)
    if guiServiceRef == "function" then
        guiService2 = packValues(getconnections(temporary7.Activated))
        guiServiceRef, guiService2, scheduleVisibleShopRefresh = ipairs(unpackValues(guiService2))
        guiServiceRef, guiService2, scheduleVisibleShopRefresh = normalizeIterator(guiServiceRef, guiService2, scheduleVisibleShopRefresh)
        for index, item in guiServiceRef, guiService2, scheduleVisibleShopRefresh do
            toggleSelectedItemFavorite, toggleSelectedItemDeleted, scheduleVisibleShopRefresh = index, item, index
            temporary4 = toggleSelectedItemDeleted and toggleSelectedItemDeleted.Function
            if temporary4 then
                table.insert(self.original_buy_fns, toggleSelectedItemDeleted.Function)
                toggleSelectedItemDeleted:Disable()
            end
        end
        toggleSelectedItemFavorite, toggleSelectedItemDeleted, scheduleVisibleShopRefresh = nil, nil, nil
        guiServiceRef = playerGui2:FindFirstChild("Favorite")
        if guiServiceRef then
            scheduleVisibleShopRefresh = packValues(getconnections(guiServiceRef.Activated))
            guiService2, scheduleVisibleShopRefresh, toggleSelectedItemFavorite = ipairs(unpackValues(scheduleVisibleShopRefresh))
            guiService2, scheduleVisibleShopRefresh, toggleSelectedItemFavorite = normalizeIterator(guiService2, scheduleVisibleShopRefresh, toggleSelectedItemFavorite)
            for index2, item2 in guiService2, scheduleVisibleShopRefresh, toggleSelectedItemFavorite do
                toggleSelectedItemDeleted, temporary4, toggleSelectedItemFavorite = index2, item2, index2
                temporary3 = temporary4 and temporary4.Function
                if temporary3 then
                    temporary4:Disable()
                end
            end
            toggleSelectedItemDeleted, temporary4, toggleSelectedItemFavorite = nil, nil, nil
            toggleSelectedItemFavorite, guiService2 = bind(Handlers.toggleSelectedItemFavorite, self), guiServiceRef.Activated
            guiService2, scheduleVisibleShopRefresh = guiService2.Connect, guiService2
            guiService2(scheduleVisibleShopRefresh, toggleSelectedItemFavorite)
        end
        guiService2 = temporary6:FindFirstChild("Delete")
        if guiService2 then
            toggleSelectedItemFavorite = packValues(getconnections(guiService2.Activated))
            scheduleVisibleShopRefresh, toggleSelectedItemFavorite, toggleSelectedItemDeleted = ipairs(unpackValues(toggleSelectedItemFavorite))
            scheduleVisibleShopRefresh, toggleSelectedItemFavorite, toggleSelectedItemDeleted = normalizeIterator(scheduleVisibleShopRefresh, toggleSelectedItemFavorite, toggleSelectedItemDeleted)
            for index3, item3 in scheduleVisibleShopRefresh, toggleSelectedItemFavorite, toggleSelectedItemDeleted do
                temporary4, temporary3, toggleSelectedItemDeleted = index3, item3, index3
                result = temporary3 and temporary3.Function
                if result then
                    temporary3:Disable()
                end
            end
            temporary4, temporary3, toggleSelectedItemDeleted = nil, nil, nil
            scheduleVisibleShopRefresh, toggleSelectedItemDeleted = guiService2.Activated, bind(Handlers.toggleSelectedItemDeleted, self)
            toggleSelectedItemFavorite, scheduleVisibleShopRefresh = scheduleVisibleShopRefresh, scheduleVisibleShopRefresh.Connect
            scheduleVisibleShopRefresh(toggleSelectedItemFavorite, toggleSelectedItemDeleted)
        end
    end
    guiServiceRef = game:GetService("GuiService")
    guiServiceRef, guiService2 = guiServiceRef.GetPropertyChangedSignal, guiServiceRef
    guiServiceRef = guiServiceRef(guiService2, "SelectedObject")
    guiService2, guiServiceRef, scheduleVisibleShopRefresh = guiServiceRef, guiServiceRef.Connect, bind(Handlers.scheduleVisibleShopRefresh, self)
    guiServiceRef(guiService2, scheduleVisibleShopRefresh)
    scheduleVisibleShopRefresh, guiServiceRef = bind(Handlers.equipSelectedShopItem, self, temporary7), temporary7.Activated
    guiServiceRef, guiService2 = guiServiceRef.Connect, guiServiceRef
    guiServiceRef(guiService2, scheduleVisibleShopRefresh)
    guiServiceRef = self.shop_controller.itemSelected
    if self.shop_controller.itemSelected then
        guiServiceRef, scheduleVisibleShopRefresh = self.shop_controller.itemSelected, bind(Handlers.onCategoryUnlockChanged, self)
        guiService2, guiServiceRef = guiServiceRef, guiServiceRef.Connect
        guiServiceRef(guiService2, scheduleVisibleShopRefresh)
    end
    guiServiceRef = {value = guiServiceRef}
    guiServiceRef.value, guiService2 = bind(Handlers.refreshBothShopCategories, self), self.shop
    scheduleVisibleShopRefresh, guiService2 = guiService2, guiService2.GetPropertyChangedSignal
    guiService2 = guiService2(scheduleVisibleShopRefresh, "Enabled")
    toggleSelectedItemFavorite = bind(Handlers.refreshVisibleShopDeferred, self, guiServiceRef)
    scheduleVisibleShopRefresh, guiService2 = guiService2, guiService2.Connect
    guiService2(scheduleVisibleShopRefresh, toggleSelectedItemFavorite)
    if self.shop.Enabled then
        task.defer(guiServiceRef.value)
    end
    return true
end

function Handlers.hookShopDeferred(cosmetics)
    cosmetics:hook_shop()
    return
end

function Handlers.hookSwordEffects(replicatedStorage, localPlayerRef, swordController)
    local result, shared, playSwordEffectOverride, remotes, shared2
    remotes = replicatedStorage:FindFirstChild("Remotes")
    result = remotes and remotes:FindFirstChild("ParrySuccessAll")
    if result then
        playSwordEffectOverride, shared2 = bind(Handlers.playSwordEffectOverride, swordController, localPlayerRef), result.OnClientEvent
        shared, shared2 = shared2, shared2.Connect
        shared2(shared, playSwordEffectOverride)
    end
    shared2 = replicatedStorage:FindFirstChild("Shared")
    shared = shared2 and shared2:FindFirstChild("ReplicatedInstances")
    shared2 = shared
    shared = shared and shared2:FindFirstChild("Swords")
    if shared then
        shared, playSwordEffectOverride = pcall(require, shared)
        if shared then
            swordController.swords = playSwordEffectOverride
        end
    end
    return
end

function Handlers.initializeCosmetics(cosmeticsRef)
    cosmeticsRef.value:initialize()
    return
end

function Handlers.initializeCosmeticsController(replicatedStorage, config, cosmetics)
    local uI, temporary2, temporary3, temporary4, temporary5, requireExplosionModule, defer
    local temporary8, temporary9
    uI = replicatedStorage.Controllers:FindFirstChild("UI")
    temporary9 = uI and uI:FindFirstChild("ShopController")
    temporary4 = uI and uI:FindFirstChild("ShopControllerAPI")
    temporary3, temporary8 = pcall(require, temporary9)
    temporary5, temporary2 = pcall(require, temporary4)
    defer = not temporary3
    if temporary3 then
        requireExplosionModule = type(temporary8)
        defer = requireExplosionModule ~= "table"
    end
    if defer then
        temporary8 = nil
    end
    defer = not temporary5
    if temporary5 then
        requireExplosionModule = type(temporary2)
        defer = requireExplosionModule ~= "table"
    end
    if defer then
        temporary2 = nil
    end
    defer = not temporary8 and not temporary2
    if defer then
        warn("[417] unlock all: failed to load shop controllers")
        return
    end
    cosmetics.shop_controller = temporary8
    cosmetics.shop_api = temporary2
    cosmetics:hook_sword_fx()
    cosmetics:hook_chroma()
    requireExplosionModule = bind(Handlers.requireExplosionModule, cosmetics, replicatedStorage)
    pcall(requireExplosionModule)
    cosmetics:ensure_explosion_wrap()
    if cosmetics.shop_controller then
        requireExplosionModule = bind(Handlers.hookShopDeferred, cosmetics)
        pcall(requireExplosionModule)
    end
    if cosmetics.shop_api then
        requireExplosionModule = bind(Handlers.hookModernShopDeferred, cosmetics)
        pcall(requireExplosionModule)
    end
    cosmetics.ready = true
    cosmetics:set_enabled(cosmetics.enabled)
    defer = cosmetics.enabled and config.last_equipped_sword and config.last_equipped_sword ~= ""
    if defer then
        requireExplosionModule, defer = bind(Handlers.restoreConfiguredSword, cosmetics, config), task.defer
        defer(requireExplosionModule)
    end
    defer = cosmetics.enabled and config.last_equipped_explosion and config.last_equipped_explosion ~= ""
    if defer then
        defer, requireExplosionModule = task.defer, bind(Handlers.restoreConfiguredExplosion, cosmetics, config)
        defer(requireExplosionModule)
    end
    return
end

function Handlers.initializeCosmeticsFromToggle(cosmeticsRef)
    cosmeticsRef.value:initialize()
    return
end

function Handlers.initializeCosmeticsSafely(cosmeticsRef)
    local initializeCosmetics
    initializeCosmetics = bind(Handlers.initializeCosmetics, cosmeticsRef)
    pcall(initializeCosmetics)
    return
end

function Handlers.isDeleted(config, self, category, itemName)
    local result
    if category == "Sword" then
        result = config.deleted_swords and config.deleted_swords[itemName] == true
        return result
    end
    if category == "Explosion" then
        result = config.deleted_explosions and config.deleted_explosions[itemName] == true
        return result
    end
    return false
end

function Handlers.isFav(config, self, category, itemName)
    local result
    if category == "Sword" then
        result = config.favorite_swords and config.favorite_swords[itemName] == true
        return result
    end
    if category == "Explosion" then
        result = config.favorite_explosions and config.favorite_explosions[itemName] == true
        return result
    end
    return false
end

function Handlers.nativeFavMap(self)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    local temporary8, temporary9, temporary10, temporary11, temporary12, temporary13, temporary14
    local temporary15, temporary16, temporary17, temporary18, temporary19, temporary20, temporary21
    local temporary22, temporary23, temporary24, temporary25, temporary26, temporary27, temporary28
    if self.native_map then
        return self.native_map
    end
    temporary18 = not self.shop_controller
    if self.shop_controller then
        temporary5 = type(self.shop_controller._inventoryPages)
        temporary18 = temporary5 ~= "table"
    end
    if temporary18 then
        return nil
    end
    temporary18, temporary5, temporary23 = pairs(self.shop_controller._inventoryPages)
    temporary18, temporary5, temporary23 = normalizeIterator(temporary18, temporary5, temporary23)
    temporary9, temporary15 = temporary18(temporary5, temporary23)
    temporary23 = temporary9
    if not (temporary9 == nil) then
        while true do
            temporary12 = type(temporary15)
            temporary7 = temporary12 == "table"
            if temporary12 == "table" then
                temporary12 = type(temporary15.MarkDirty)
                temporary7 = temporary12 == "function"
            end
            if temporary7 then
                temporary7, temporary12 = pcall(debug.getupvalues, temporary15.MarkDirty)
                temporary26 = temporary7
                if temporary7 then
                    temporary14 = type(temporary12)
                    temporary26 = temporary14 == "table"
                end
                if temporary26 then
                    temporary26, temporary14, temporary24 = pairs(temporary12)
                    temporary26, temporary14, temporary24 = normalizeIterator(temporary26, temporary14, temporary24)
                    temporary27, result = temporary26(temporary14, temporary24)
                    temporary24 = temporary27
                    if not (temporary27 == nil) then
                        while true do
                            temporary3 = type(result)
                            if temporary3 == "function" then
                                temporary3, temporary19 = pcall(debug.getupvalues, result)
                                temporary16 = temporary3
                                if temporary3 then
                                    temporary20 = type(temporary19)
                                    temporary16 = temporary20 == "table"
                                end
                                if temporary16 then
                                    temporary16, temporary20, temporary11 = pairs(temporary19)
                                    temporary16, temporary20, temporary11 = normalizeIterator(temporary16, temporary20, temporary11)
                                    temporary22, temporary13 = temporary16(temporary20, temporary11)
                                    temporary11 = temporary22
                                    if not (temporary22 == nil) then
                                        while true do
                                            temporary6 = type(temporary13)
                                            if temporary6 == "function" then
                                                temporary6, temporary4 = pcall(debug.getupvalues, temporary13)
                                                temporary8 = temporary6
                                                if temporary6 then
                                                    temporary21 = type(temporary4)
                                                    temporary8 = temporary21 == "table"
                                                end
                                                if temporary8 then
                                                    temporary8, temporary21, temporary10 = pairs(temporary4)
                                                    temporary8, temporary21, temporary10 = normalizeIterator(temporary8, temporary21, temporary10)
                                                    temporary28, temporary2 = temporary8(temporary21, temporary10)
                                                    temporary10 = temporary28
                                                    if not (temporary28 == nil) then
                                                        while true do
                                                            temporary17 = type(temporary2)
                                                            temporary25 = temporary17 == "table" and temporary2.Sword ~= nil and temporary2.Explosion ~= nil and not temporary2._virtualItems
                                                            if temporary25 then
                                                                self.native_map = temporary2
                                                                return temporary2
                                                            end
                                                            temporary28, temporary2 = temporary8(temporary21, temporary10)
                                                            temporary10 = temporary28
                                                            if temporary28 == nil then
                                                                temporary22, temporary13 = temporary16(temporary20, temporary11)
                                                                temporary11 = temporary22
                                                                if temporary22 == nil then
                                                                    temporary27, result = temporary26(temporary14, temporary24)
                                                                    temporary24 = temporary27
                                                                    if temporary27 == nil then
                                                                        temporary9, temporary15 = temporary18(temporary5, temporary23)
                                                                        temporary23 = temporary9
                                                                        if temporary9 == nil then
                                                                            return nil
                                                                        end
                                                                        continue
                                                                    else
                                                                        continue
                                                                    end
                                                                    break
                                                                else
                                                                    continue
                                                                end
                                                                break
                                                            else
                                                                continue
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            temporary22, temporary13 = temporary16(temporary20, temporary11)
                                            temporary11 = temporary22
                                            if temporary22 == nil then
                                                temporary27, result = temporary26(temporary14, temporary24)
                                                temporary24 = temporary27
                                                if temporary27 == nil then
                                                    temporary9, temporary15 = temporary18(temporary5, temporary23)
                                                    temporary23 = temporary9
                                                    if temporary9 == nil then
                                                        return nil
                                                    end
                                                    continue
                                                else
                                                    continue
                                                end
                                                break
                                            else
                                                continue
                                            end
                                        end
                                    end
                                end
                            end
                            temporary27, result = temporary26(temporary14, temporary24)
                            temporary24 = temporary27
                            if temporary27 == nil then
                                temporary9, temporary15 = temporary18(temporary5, temporary23)
                                temporary23 = temporary9
                                if temporary9 == nil then
                                    return nil
                                end
                                continue
                            else
                                continue
                            end
                        end
                    end
                end
            end
            temporary9, temporary15 = temporary18(temporary5, temporary23)
            temporary23 = temporary9
            if temporary9 == nil then
                return nil
            end
        end
    end
    return nil
end

function Handlers.onCategoryUnlockChanged(cosmetics, value)
    local refreshSelectedShopItem, defer
    defer = value and cosmetics.unlocked[value.type]
    if defer then
        cosmetics:set_category_unlock(value.type, true)
    end
    refreshSelectedShopItem, defer = bind(Handlers.refreshSelectedShopItem, cosmetics), task.defer
    defer(refreshSelectedShopItem)
    return
end

function Handlers.onCosmeticCharacterAdded(cosmetics, value)
    cosmetics:setup_character(value)
    return
end

function Handlers.playExplosionOverride(cosmeticsRef, localPlayerRef, value, selectedExplosion, otherValue, otherValue2, otherValue3, otherValue4, otherValue5)
    local result
    result = cosmeticsRef.value.enabled and cosmeticsRef.value.selected_explosion and cosmeticsRef.value.selected_explosion ~= "" and otherValue5 and otherValue4 == localPlayerRef.value.Character
    if result then
        selectedExplosion = cosmeticsRef.value.selected_explosion
    end
    result = packValues(cosmeticsRef.value.explosion_original(value, selectedExplosion, otherValue, otherValue2, otherValue3, otherValue4, otherValue5))
    return unpackValues(result)
end

function Handlers.playSelectedSwordEffect(cosmetics, swordModel)
    local result
    result = cosmetics.enabled and cosmetics.selected_sword == swordModel.Name
    if result then
        pcall(cosmetics.sword_fn, swordModel.Name)
    end
    return
end

function Handlers.playSwordEffectOverride(cosmetics, localPlayerRef, ...)
    local playParry, temporary2, temporary3, temporary4
    temporary2 = not cosmetics.enabled
    if cosmetics.enabled then
        temporary2 = not cosmetics.selected_sword
    end
    if not temporary2 then
        temporary2 = not cosmetics.play_parry
    end
    if temporary2 then
        return
    end
    playParry, temporary4 = packValues(...), {}
    setRange(temporary4, 1, unpackValues(playParry))
    temporary2 = temporary4
    temporary4 = cosmetics.swords and cosmetics.swords:GetSword(cosmetics.selected_sword)
    playParry = temporary4 and temporary2[4]
    if playParry then
        temporary3 = tostring(temporary2[4])
        playParry = temporary3 == localPlayerRef.value.Name
    end
    if playParry then
        temporary2[1] = temporary4.SlashName
        temporary2[3] = temporary4.Name
    end
    playParry = cosmetics.play_parry
    temporary3 = packValues(unpack(temporary2))
    playParry = packValues(playParry(unpackValues(temporary3)))
    return unpackValues(playParry)
end

function Handlers.refreshBothShopCategories(cosmetics)
    local result, temporary2, temporary3, temporary4, temporary5
    temporary2 = not cosmetics.shop.Enabled
    if cosmetics.shop.Enabled then
        temporary2 = not cosmetics.enabled
    end
    if temporary2 then
        return
    end
    temporary5 = {}
    temporary5[1], temporary5[2] = "Sword", "Explosion"
    temporary2, temporary4, temporary3 = ipairs(temporary5)
    temporary2, temporary4, temporary3 = normalizeIterator(temporary2, temporary4, temporary3)
    for index, item in temporary2, temporary4, temporary3 do
        temporary5, result, temporary3 = index, item, index
        if cosmetics.unlocked[result] then
            cosmetics:schedule_refresh(result)
        end
    end
    temporary5, result, temporary3 = nil, nil, nil
    return
end

function Handlers.refreshEquippedSwordAttribute(cosmetics, localPlayerRef)
    local result, temporary2, selectedSword
    selectedSword = cosmetics.selected_sword
    result = not cosmetics.enabled
    if cosmetics.enabled then
        result = not cosmetics.selected_sword
    end
    if not result then
        temporary2 = localPlayerRef.value:GetAttribute("CurrentlyEquippedSword")
        result = temporary2 == selectedSword
    end
    if result then
        return
    end
    localPlayerRef.value:SetAttribute("CurrentlyEquippedSword", selectedSword)
    if localPlayerRef.value.Character then
        localPlayerRef.value.Character:SetAttribute("CurrentlyEquippedSword", selectedSword)
    end
    if cosmetics.sword_fn then
        pcall(cosmetics.sword_fn, selectedSword)
    end
    return
end

function Handlers.refreshFavs(self, otherValue)
    local gsub, temporary2, temporary3, ownsItem, gsub2, gsub3, temporary7
    local temporary8, temporary9, temporary10, temporary11, temporary12, gsub4
    if not self.shop_controller then
        return
    end
    self:sync_fav_map(otherValue)
    temporary12 = self.shop_controller._virtualItems[otherValue]
    temporary10 = self.shop_controller._inventoryPages[otherValue]
    temporary2 = type(self.shop_controller._virtualItems[otherValue])
    if temporary2 ~= "table" then
        return
    end
    temporary2, temporary11, temporary9 = pairs(temporary12)
    temporary2, temporary11, temporary9 = normalizeIterator(temporary2, temporary11, temporary9)
    for index, item in temporary2, temporary11, temporary9 do
        temporary3, temporary8, temporary9 = index, item, index
        temporary7 = self:is_fav(otherValue, temporary8.Name)
        temporary8.IsFavorited = temporary7
        ownsItem = temporary8.OwnsItem
        if temporary8.OwnsItem then
            gsub2 = type(temporary8.OwnsItem.Set)
            ownsItem = gsub2 == "function"
        end
        if ownsItem then
            pcall(temporary8.OwnsItem.Set, temporary8.OwnsItem, true)
        end
        ownsItem = temporary8.OriginalLayoutOrder or temporary8.LayoutOrder or 0
        temporary8.OriginalLayoutOrder = ownsItem
        if temporary7 then
            temporary8.LayoutOrder = ownsItem - 1000
            gsub3 = temporary8.Name_ or temporary8.Name
            gsub3, gsub = gsub3.gsub, gsub3
            gsub3 = gsub3(gsub, "^#", "")
            temporary8.Name_ = "#" .. gsub3
        else
            temporary8.LayoutOrder = ownsItem
            gsub2 = temporary8.Name_ or temporary8.Name
            gsub2, gsub4 = gsub2.gsub, gsub2
            gsub2 = gsub2(gsub4, "^#", "")
            temporary8.Name_ = gsub2
        end
    end
    temporary3, temporary8, temporary9 = nil, nil, nil
    temporary2 = temporary10 and temporary10.MarkDirty
    if temporary2 then
        temporary10.MarkDirty(nil, true, true)
    end
    return
end

function Handlers.refreshLocalCosmeticCharacter(cosmetics, localPlayerRef)
    cosmetics:setup_character(localPlayerRef.value.Character)
    return
end

function Handlers.refreshSelected(self)
    local buyButton, delete, temporary3, temporary4, temporary5, selectedItem, favorite
    local temporary8
    selectedItem = not self.shop_controller
    if self.shop_controller then
        selectedItem = not self.shop
    end
    if selectedItem then
        return
    end
    selectedItem = self.shop_controller._selectedItem
    if not self.shop_controller._selectedItem then
        return
    end
    buyButton = self.shop.Holder.InfoBG:FindFirstChild("BuyButton")
    favorite = self.shop.Holder:FindFirstChild("Favorite")
    delete = self.shop.Holder.InfoBG:FindFirstChild("Delete")
    temporary3 = self.enabled and self.unlocked[selectedItem.type] and (selectedItem.type == "Sword" or selectedItem.type == "Explosion")
    if temporary3 then
        temporary3 = self.shop_controller._virtualItems and self.shop_controller._virtualItems[selectedItem.type]
        temporary5 = nil
        if temporary3 then
            temporary8 = selectedItem.key or selectedItem.name
            temporary5 = temporary3[temporary8]
        end
        temporary8 = self:is_deleted(selectedItem.type, selectedItem.name) or temporary5 and temporary5.Section == "Unowned"
        if temporary8 then
            if buyButton then
                buyButton.Visible = false
            end
            if favorite then
                favorite.Visible = false
            end
            if delete then
                delete.Visible = true
            end
        else
            if buyButton then
                buyButton.Visible = true
                temporary8 = buyButton:FindFirstChild("PriceTag") and buyButton.PriceTag:FindFirstChild("TextLabel")
                if temporary8 then
                    buyButton.PriceTag.TextLabel.Visible = true
                    buyButton.PriceTag.TextLabel.Text = "Equip"
                end
                temporary8 = buyButton:FindFirstChild("PriceTag") and buyButton.PriceTag:FindFirstChild("Price")
                if temporary8 then
                    buyButton.PriceTag.Price.Visible = false
                end
            end
            if favorite then
                favorite.Visible = true
                temporary8 = self:is_fav(selectedItem.type, selectedItem.name)
                temporary4 = temporary8 and "rbxassetid://15697987058" or "rbxassetid://15697981750"
                favorite.Image = temporary4
                temporary4 = temporary8 and "rbxassetid://15697983062" or "rbxassetid://15697987058"
                favorite.HoverImage = temporary4
            end
            if delete then
                delete.Visible = true
            end
        end
    end
    return
end

function Handlers.refreshSelectedShopItem(cosmetics)
    cosmetics:refresh_selected()
    return
end

function Handlers.refreshShopItem(self, otherValue, otherValue2, otherValue3)
    local result, ownsItem, temporary3, temporary4, ownsItem2, temporary6, temporary7
    local temporary8, temporary9
    temporary3 = self.shop_controller and self.shop_controller._virtualItems[otherValue]
    temporary4 = self.shop_controller and self.shop_controller._inventoryPages[otherValue]
    temporary6 = type(temporary3)
    if temporary6 == "table" then
        temporary6, temporary9, temporary7 = pairs(temporary3)
        temporary6, temporary9, temporary7 = normalizeIterator(temporary6, temporary9, temporary7)
        result, temporary8 = temporary6(temporary9, temporary7)
        temporary7 = result
        if not (result == nil) then
            while true do
                if temporary8.Name == otherValue2 then
                    ownsItem2 = otherValue3 and "Owned" or "Unowned"
                    temporary8.Section = ownsItem2
                    ownsItem2 = temporary8.OwnsItem
                    if temporary8.OwnsItem then
                        ownsItem = type(temporary8.OwnsItem.Set)
                        ownsItem2 = ownsItem == "function"
                    end
                    if ownsItem2 then
                        pcall(temporary8.OwnsItem.Set, temporary8.OwnsItem, otherValue3)
                    end
                    if not otherValue3 then
                        temporary8.IsFavorited = false
                        ownsItem2 = temporary8.Name_ or temporary8.Name
                        ownsItem2, ownsItem = ownsItem2.gsub, ownsItem2
                        ownsItem2 = ownsItem2(ownsItem, "^#", "")
                        temporary8.Name_ = ownsItem2
                        ownsItem2 = temporary8.OriginalLayoutOrder or temporary8.LayoutOrder or 0
                        temporary8.LayoutOrder = ownsItem2
                    end
                    ownsItem2 = temporary4 and temporary4.MarkDirty
                    if ownsItem2 then
                        temporary4.MarkDirty(temporary8, false, true)
                    end
                    break
                else
                    result, temporary8 = temporary6(temporary9, temporary7)
                    temporary7 = result
                    if result == nil then
                        break
                    else
                        continue
                    end
                end
                break
            end
        end
    end
    temporary6 = temporary4 and temporary4.MarkDirty
    if temporary6 then
        temporary4.MarkDirty(nil, true, true)
    end
    return
end

function Handlers.refreshShopSlotVisual(cosmetics, category, shopSlot)
    local result, shopSlot2, temporary3
    shopSlot2 = shopSlot
    cosmetics:slot_fav_visual(category, shopSlot)
    temporary3 = shopSlot2:FindFirstChild("Shadow") or shopSlot.Name == "Shadow" and shopSlot
    result = temporary3 and cosmetics.unlocked[category]
    if result then
        cosmetics:bind_shadow(category, temporary3)
    end
    return
end

function Handlers.refreshSwordModel(swordController, value)
    local selectedSwordRef, equipSelectedSwordDeferred, applyCharacterChroma, getCharacterSwordRef, temporary5
    temporary5 = not swordController.enabled
    if swordController.enabled then
        getCharacterSwordRef = value:IsA("Model")
        temporary5 = not getCharacterSwordRef
    end
    if not temporary5 then
        temporary5 = not swordController.swords
    end
    if not temporary5 then
        temporary5 = not swordController.selected_sword
    end
    if temporary5 then
        return
    end
    getCharacterSwordRef = bind(Handlers.getCharacterSword, swordController, value)
    temporary5, getCharacterSwordRef = pcall(getCharacterSwordRef)
    getCharacterSwordRef = {value = getCharacterSwordRef}
    selectedSwordRef = not temporary5
    if temporary5 then
        selectedSwordRef = not getCharacterSwordRef.value
    end
    if selectedSwordRef then
        return
    end
    if value.Name ~= swordController.selected_sword then
        selectedSwordRef = {value = swordController.selected_sword}
        equipSelectedSwordDeferred, applyCharacterChroma = bind(Handlers.equipSelectedSwordDeferred, swordController, selectedSwordRef), task.defer
        applyCharacterChroma(equipSelectedSwordDeferred)
    else
        applyCharacterChroma = bind(Handlers.applyCharacterChroma, swordController, value, getCharacterSwordRef)
        pcall(applyCharacterChroma)
        if swordController.sword_fn then
            applyCharacterChroma, selectedSwordRef = bind(Handlers.playSelectedSwordEffect, swordController, value), task.defer
            selectedSwordRef(applyCharacterChroma)
        end
    end
    return
end

function Handlers.refreshVisibleShopDeferred(cosmetics, guiServiceRef)
    if cosmetics.shop.Enabled then
        task.defer(guiServiceRef.value)
    end
    return
end

function Handlers.refreshVisuals(self, otherValue)
    local result, temporary2, callSlotFavVisual, refreshGuiDescendant, pageConnections, callSlotFavVisual2
    if not self.shop_controller then
        return
    end
    result = self.shop_controller._inventoryPages[otherValue]
    temporary2 = self.shop_controller._virtualItems[otherValue]
    pageConnections = not result
    if result then
        pageConnections = not result.Scroll
    end
    if not pageConnections then
        callSlotFavVisual = type(temporary2)
        pageConnections = callSlotFavVisual ~= "table"
    end
    if pageConnections then
        return
    end
    pageConnections = not self.page_connections[otherValue] and result.ScrollingFrame
    if pageConnections then
        pageConnections = self.page_connections
        callSlotFavVisual, refreshGuiDescendant = result.ScrollingFrame.DescendantAdded, bind(Handlers.refreshGuiDescendant, self, otherValue)
        callSlotFavVisual2, callSlotFavVisual = callSlotFavVisual, callSlotFavVisual.Connect
        callSlotFavVisual = callSlotFavVisual(callSlotFavVisual2, refreshGuiDescendant)
        pageConnections[otherValue] = callSlotFavVisual
    end
    pageConnections, callSlotFavVisual = task.defer, bind(Handlers.callSlotFavVisual, otherValue, result, self, temporary2)
    pageConnections(callSlotFavVisual)
    return
end

function Handlers.requireExplosionModule(cosmetics, replicatedStorage)
    local result, cosmetics2
    cosmetics2 = cosmetics
    result = require(replicatedStorage.Controllers.VFXController)
    cosmetics2.explosion_module = result
    return
end

function Handlers.requireShopControllerApi(shopControllerApiRef, replicatedStorage)
    local result, temporary2
    result = getthreadidentity and getthreadidentity() or 2
    if setthreadidentity then
        pcall(setthreadidentity, 2)
    end
    temporary2 = require(replicatedStorage.Controllers.AnimationController)
    shopControllerApiRef.value = temporary2
    if setthreadidentity then
        pcall(setthreadidentity, result)
    end
    return
end

function Handlers.requireSwordAnimations(swordAnimationsRef, replicatedStorage)
    local result, temporary2
    temporary2 = getthreadidentity and getthreadidentity() or 2
    if setthreadidentity then
        pcall(setthreadidentity, 2)
    end
    result = require(replicatedStorage.Shared.ReplicatedInstances.Swords)
    swordAnimationsRef.value = result
    if setthreadidentity then
        pcall(setthreadidentity, temporary2)
    end
    return
end

function Handlers.requireSwordApi(swordControllerRef, replicatedStorage)
    local result, temporary2
    temporary2 = getthreadidentity and getthreadidentity() or 2
    if setthreadidentity then
        pcall(setthreadidentity, 2)
    end
    result = require(replicatedStorage.Shared.SwordAPI)
    swordControllerRef.value = result
    if setthreadidentity then
        pcall(setthreadidentity, temporary2)
    end
    return
end

function Handlers.restoreSword(swordOverrideEnabledRef, swordOverrideNameRef, self)
    local result
    result = self.original_sword and self.original_sword ~= ""
    if result then
        self:equip_sword(self.original_sword, true)
    else
        self.selected_sword = nil
    end
    self.original_sword = nil
    swordOverrideEnabledRef.value = false
    swordOverrideNameRef.value = ""
    self:set_sword_override(false)
    return
end

function Handlers.scheduleVisibleShopRefresh(cosmetics)
    local defer, callRefreshSelected
    defer = not cosmetics.enabled
    if cosmetics.enabled then
        defer = not cosmetics.shop
    end
    if not defer then
        defer = not cosmetics.shop.Enabled
    end
    if defer then
        return
    end
    defer, callRefreshSelected = task.defer, bind(Handlers.callRefreshSelected, cosmetics)
    defer(callRefreshSelected)
    return
end

function Handlers.setCategoryUnlock(self, otherValue, otherValue2)
    local result, temporary2, ownsItem, gsub, temporary5, temporary6, temporary7
    local temporary8, temporary9, temporary10, gsub2, temporary12, temporary13, temporary14
    local unlockOriginals, gsub3, gsub4
    if not self.shop_controller then
        return
    end
    if otherValue2 then
        self:sync_fav_map(otherValue)
    end
    temporary7 = self.shop_controller._virtualItems[otherValue]
    temporary5 = self.shop_controller._inventoryPages[otherValue]
    temporary9 = type(self.shop_controller._virtualItems[otherValue])
    if temporary9 ~= "table" then
        return
    end
    temporary9 = temporary5 and temporary5.BeginBatch
    if temporary9 then
        temporary5:BeginBatch()
    end
    if otherValue2 then
        self.unlocked[otherValue] = true
        result = {}
        temporary9 = result
        result, temporary14, temporary6 = pairs(temporary7)
        result, temporary14, temporary6 = normalizeIterator(result, temporary14, temporary6)
        for index, item in result, temporary14, temporary6 do
            temporary2, temporary10, temporary6 = index, item, index
            if temporary10.InventoryKey then
                temporary9[temporary10.Name] = true
            end
        end
        temporary2, temporary10, temporary6 = nil, nil, nil
        result, temporary14, temporary6 = pairs(temporary7)
        result, temporary14, temporary6 = normalizeIterator(result, temporary14, temporary6)
        for index2, item2 in result, temporary14, temporary6 do
            temporary2, temporary10, temporary6 = index2, item2, index2
            if not self.unlock_originals[temporary10] then
                temporary8, unlockOriginals = {}, self.unlock_originals
                temporary8.Section = temporary10.Section
                temporary8.ForceHide = temporary10.ForceHide
                ownsItem = temporary10.OriginalLayoutOrder or temporary10.LayoutOrder
                temporary8.OriginalLayoutOrder = ownsItem
                unlockOriginals[temporary10] = temporary8
            end
            unlockOriginals = self:is_deleted(otherValue, temporary10.Name)
            temporary13 = unlockOriginals and "Unowned" or "Owned"
            temporary8 = false
            if temporary10.Section ~= temporary13 then
                temporary10.Section = temporary13
                temporary8 = true
            end
            ownsItem = temporary10.OwnsItem
            if temporary10.OwnsItem then
                temporary12 = type(temporary10.OwnsItem.Set)
                ownsItem = temporary12 == "function"
            end
            if ownsItem then
                pcall(temporary10.OwnsItem.Set, temporary10.OwnsItem, not unlockOriginals)
            end
            ownsItem = not unlockOriginals and self:is_fav(otherValue, temporary10.Name)
            temporary10.IsFavorited = ownsItem
            temporary12 = temporary10.OriginalLayoutOrder or temporary10.LayoutOrder or 0
            temporary10.OriginalLayoutOrder = temporary12
            gsub4 = ownsItem and 1000 or 0
            if temporary10.LayoutOrder ~= temporary12 - gsub4 then
                temporary10.LayoutOrder = temporary12 - gsub4
                temporary8 = true
            end
            if ownsItem then
                gsub2 = temporary10.Name_ or temporary10.Name
                gsub2, gsub3 = gsub2.gsub, gsub2
                gsub2 = gsub2(gsub3, "^#", "")
                if temporary10.Name_ ~= "#" .. gsub2 then
                    gsub = temporary10.OriginalName_ or temporary10.Name_
                    temporary10.OriginalName_ = gsub
                    temporary10.Name_ = "#" .. gsub2
                    temporary8 = true
                end
            else
                gsub4 = temporary10.Name_ or temporary10.Name
                gsub4, gsub = gsub4.gsub, gsub4
                gsub4 = gsub4(gsub, "^#", "")
                if temporary10.Name_ ~= gsub4 then
                    temporary10.Name_ = gsub4
                    temporary8 = true
                end
            end
            gsub4 = not temporary10.InventoryKey and temporary9[temporary10.Name] or false
            if temporary10.ForceHide ~= gsub4 then
                temporary10.ForceHide = gsub4
                temporary8 = true
            end
            gsub = temporary8 and temporary5 and temporary5.MarkDirty
            if gsub then
                temporary5.MarkDirty(temporary10, false, true)
            end
        end
        temporary2, temporary10, temporary6 = nil, nil, nil
    else
        self.unlocked[otherValue] = nil
        temporary9, result, temporary14 = pairs(temporary7)
        temporary9, result, temporary14 = normalizeIterator(temporary9, result, temporary14)
        for index3, item3 in temporary9, result, temporary14 do
            temporary6, temporary2, temporary14 = index3, item3, index3
            temporary10 = self.unlock_originals[temporary2]
            if self.unlock_originals[temporary2] then
                unlockOriginals = false
                if temporary2.Section ~= self.unlock_originals[temporary2].Section then
                    temporary2.Section = self.unlock_originals[temporary2].Section
                    unlockOriginals = true
                end
                if temporary2.ForceHide ~= temporary10.ForceHide then
                    temporary2.ForceHide = temporary10.ForceHide
                    unlockOriginals = true
                end
                temporary13 = unlockOriginals and temporary5 and temporary5.MarkDirty
                if temporary13 then
                    temporary5.MarkDirty(temporary2, false, true)
                end
                self.unlock_originals[temporary2] = nil
            end
        end
        temporary6, temporary2, temporary14 = nil, nil, nil
    end
    temporary9 = temporary5 and temporary5.MarkDirty
    if temporary9 then
        temporary5.MarkDirty(nil, true, true)
    end
    temporary9 = temporary5 and temporary5.EndBatch
    if temporary9 then
        temporary5:EndBatch()
    end
    self:refresh_visuals(otherValue)
    return
end

function Handlers.setCosmeticsEnabled(cosmeticsRef, value)
    local initializeCosmeticsFromToggle
    if not cosmeticsRef.value.ready then
        initializeCosmeticsFromToggle = bind(Handlers.initializeCosmeticsFromToggle, cosmeticsRef)
        pcall(initializeCosmeticsFromToggle)
    end
    cosmeticsRef.value:set_enabled(value)
    return
end

function Handlers.setEquipped(shopApi, cosmeticsRef, cosmeticsRef2, self, ...)
    local lower, temporary2, lower2, itemType, name, lower3, ownedBases
    local itemType2, temporary9
    itemType2, name = {}, packValues(...)
    setRange(itemType2, 1, unpackValues(name))
    itemType = itemType2
    name, itemType2 = itemType2[2], itemType2[1]
    ownedBases = type(itemType2)
    if ownedBases == "table" then
        itemType2, name = itemType2.ItemType, itemType2.Name
    else
        ownedBases = type(name)
        if ownedBases == "table" then
            name = name.Name
        end
    end
    ownedBases = shopApi.OwnedBases
    temporary2 = type(shopApi.OwnedBases)
    temporary9 = temporary2 == "table" and ownedBases[itemType2]
    lower = type(temporary9)
    temporary2 = lower == "table" and temporary9[name] ~= nil
    lower = cosmeticsRef.value.enabled and (temporary2 or itemType2 == "Sword" or itemType2 == "Explosion")
    if lower then
        lower = itemType2 == "Sword"
        if not (itemType2 == "Sword") then
            lower = tostring(itemType2)
            lower, lower2 = lower.lower, lower
            lower = lower(lower2)
            lower, lower2 = lower.find, lower
            lower = lower(lower2, "sword")
        end
        lower2 = lower and cosmeticsRef.value:equip_sword(name, false)
        if lower2 then
            return true
        end
        lower2 = itemType2 == "Explosion"
        if not (itemType2 == "Explosion") then
            lower2 = tostring(itemType2)
            lower3, lower2 = lower2, lower2.lower
            lower2 = lower2(lower3)
            lower3, lower2 = lower2, lower2.find
            lower2 = lower2(lower3, "explosion")
        end
        if lower2 then
            lower3 = packValues(cosmeticsRef.value:equip_explosion(name))
            return unpackValues(lower3)
        end
        lower = cosmeticsRef2.original_set_equipped
        lower3 = packValues(unpack(itemType))
        lower = packValues(lower(self, unpackValues(lower3)))
        return unpackValues(lower)
    end
    lower = cosmeticsRef2.original_set_equipped
    lower3 = packValues(unpack(itemType))
    lower = packValues(lower(self, unpackValues(lower3)))
    return unpackValues(lower)
end

function Handlers.setModernUnlock(self, otherValue, otherValue2)
    local result, temporary2, parseItemKey, temporary4, parseItemKey2, temporary6, ownedCopies
    local temporary8, shopApi, temporary10, parseItemKey3, temporary12, temporary13, modernOriginals
    local temporary15, parseItemKey4, temporary17
    shopApi = self.shop_api
    temporary6 = self.shop_api and self.shop_api.OwnedBases and self.shop_api.OwnedBases[otherValue]
    temporary2 = type(temporary6)
    if temporary2 ~= "table" then
        return
    end
    temporary2, result, temporary17 = pairs(temporary6)
    temporary2, result, temporary17 = normalizeIterator(temporary2, result, temporary17)
    for index, item in temporary2, result, temporary17 do
        temporary12, temporary10, temporary17 = index, item, index
        temporary4, parseItemKey4 = {}, shopApi.ParseItemKey
        temporary4.Name = temporary12
        temporary15, parseItemKey4 = pcall(parseItemKey4, shopApi, otherValue, temporary4)
        parseItemKey2, ownedCopies = temporary15, nil
        if temporary15 then
            parseItemKey2 = parseItemKey4
        end
        if parseItemKey2 then
            parseItemKey2, temporary4 = pcall(shopApi.GetItemData, shopApi, otherValue, parseItemKey4)
            parseItemKey = parseItemKey2
            if parseItemKey2 then
                modernOriginals = type(temporary4)
                parseItemKey = modernOriginals == "table"
            end
            if parseItemKey then
                ownedCopies = temporary4.OwnedCopies
            end
        end
        parseItemKey2 = otherValue2 and ownedCopies
        if parseItemKey2 then
            temporary4 = type(ownedCopies.Get)
            parseItemKey2 = temporary4 == "function"
        end
        if parseItemKey2 then
            temporary4 = type(ownedCopies.Set)
            parseItemKey2 = temporary4 == "function"
        end
        if parseItemKey2 then
            if not self.modern_originals[ownedCopies] then
                temporary4, parseItemKey = pcall(ownedCopies.Get, ownedCopies)
                if temporary4 then
                    modernOriginals, temporary13 = self.modern_originals, {}
                    temporary13.Value = parseItemKey
                    modernOriginals[ownedCopies] = temporary13
                end
            end
            temporary4, parseItemKey = pcall(ownedCopies.Get, ownedCopies)
            modernOriginals = temporary4
            if temporary4 then
                parseItemKey3 = type(parseItemKey)
                modernOriginals = parseItemKey3 ~= "number" or parseItemKey < 1
            end
            if modernOriginals then
                pcall(ownedCopies.Set, ownedCopies, 1)
            end
        end
        temporary4 = temporary10
        if temporary10 then
            parseItemKey = type(temporary10.SetTag)
            temporary4 = parseItemKey == "function"
        end
        if temporary4 then
            temporary13 = otherValue2 and true or nil
            pcall(temporary10.SetTag, temporary10, self.modern_tag, temporary13)
        end
        temporary4 = not otherValue2 and ownedCopies
        if temporary4 then
            temporary4 = self.modern_originals[ownedCopies]
            parseItemKey = self.modern_originals[ownedCopies]
            if self.modern_originals[ownedCopies] then
                modernOriginals = type(ownedCopies.Set)
                parseItemKey = modernOriginals == "function"
            end
            if parseItemKey then
                parseItemKey = temporary10 and temporary10.State
                modernOriginals, parseItemKey3 = false, parseItemKey
                if parseItemKey then
                    temporary13 = type(parseItemKey.Get)
                    parseItemKey3 = temporary13 == "function"
                end
                if parseItemKey3 then
                    parseItemKey3, temporary13 = pcall(parseItemKey.Get, parseItemKey)
                    temporary8 = parseItemKey3 and temporary13 == true
                    modernOriginals = temporary8
                end
                if not modernOriginals then
                    pcall(ownedCopies.Set, ownedCopies, temporary4.Value)
                end
                self.modern_originals[ownedCopies] = nil
            end
        end
    end
    temporary12, temporary10, temporary17 = nil, nil, nil
    return
end

function Handlers.setSwordOverride(value, otherValue)
    local result, temporary2, setControllerEnabled, temporary4, temporary5, temporary6, temporary7
    local temporary8
    temporary4, result, temporary2 = ipairs(value.parry_connections)
    temporary4, result, temporary2 = normalizeIterator(temporary4, result, temporary2)
    for index, item in temporary4, result, temporary2 do
        temporary7, temporary8, temporary2 = index, item, index
        temporary5 = temporary8
        temporary6 = not otherValue
        setControllerEnabled = bind(Handlers.setControllerEnabled, temporary6, temporary5)
        pcall(setControllerEnabled)
    end
    temporary7, temporary8, temporary2 = nil, nil, nil
    temporary4, result, temporary2 = ipairs(value.fire_connections)
    temporary4, result, temporary2 = normalizeIterator(temporary4, result, temporary2)
    for index2, item2 in temporary4, result, temporary2 do
        temporary7, temporary8, temporary2 = index2, item2, index2
        temporary5 = temporary8
        temporary6 = not otherValue
        setControllerEnabled = bind(Handlers.setControllerEnabled, temporary6, temporary5)
        pcall(setControllerEnabled)
    end
    temporary7, temporary8, temporary2 = nil, nil, nil
    return
end

function Handlers.setupCosmeticCharacter(config, self, character)
    local result, refreshSwordModel, disconnectCharacterWatcher, disconnectCharacterWatcher2, temporary5, temporary6
    if self.character_connection then
        disconnectCharacterWatcher2 = bind(Handlers.disconnectCharacterWatcher, self)
        pcall(disconnectCharacterWatcher2)
        self.character_connection = nil
    end
    if not character then
        return
    end
    refreshSwordModel = self.enabled and config.last_equipped_sword and config.last_equipped_sword ~= ""
    if refreshSwordModel then
        refreshSwordModel, disconnectCharacterWatcher2 = task.defer, bind(Handlers.equipConfiguredSword, self, config)
        refreshSwordModel(disconnectCharacterWatcher2)
    end
    disconnectCharacterWatcher2, refreshSwordModel = character.ChildAdded, bind(Handlers.refreshSwordModel, self)
    disconnectCharacterWatcher, disconnectCharacterWatcher2 = disconnectCharacterWatcher2, disconnectCharacterWatcher2.Connect
    disconnectCharacterWatcher2 = disconnectCharacterWatcher2(disconnectCharacterWatcher, refreshSwordModel)
    self.character_connection = disconnectCharacterWatcher2
    disconnectCharacterWatcher = packValues(character:GetChildren())
    disconnectCharacterWatcher2, disconnectCharacterWatcher, temporary5 = ipairs(unpackValues(disconnectCharacterWatcher))
    disconnectCharacterWatcher2, disconnectCharacterWatcher, temporary5 = normalizeIterator(disconnectCharacterWatcher2, disconnectCharacterWatcher, temporary5)
    for index, item in disconnectCharacterWatcher2, disconnectCharacterWatcher, temporary5 do
        temporary6, result, temporary5 = index, item, index
        refreshSwordModel(result)
    end
    temporary6, result, temporary5 = nil, nil, nil
    return
end

function Handlers.slotFavVisual(self, otherValue, otherValue2)
    local result, favorited, temporary3, temporary4, shadow
    temporary4 = not otherValue2
    if otherValue2 then
        temporary3 = otherValue2:IsA("GuiObject")
        temporary4 = not temporary3
    end
    if temporary4 then
        return
    end
    temporary4 = otherValue2:GetAttribute("Name")
    temporary3 = not temporary4
    if temporary4 then
        temporary3 = temporary4 == ""
    end
    if temporary3 then
        return
    end
    temporary3 = self:is_fav(otherValue, temporary4)
    favorited = otherValue2:FindFirstChild("Favorited")
    shadow = favorited and favorited:IsA("ImageLabel")
    if shadow then
        favorited.Visible = temporary3
        if temporary3 then
            favorited.Image = "rbxassetid://15697987058"
        end
    end
    shadow = otherValue2:FindFirstChild("Shadow")
    result = shadow and self.unlocked[otherValue]
    if result then
        shadow.Enabled = false
    end
    return
end

function Handlers.syncFavMap(config, self, otherValue)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    local temporary8, temporary9
    temporary7 = self:native_fav_map()
    if not temporary7 then
        return
    end
    temporary3 = temporary7[otherValue]
    temporary8 = type(temporary7[otherValue])
    if temporary8 ~= "table" then
        return
    end
    temporary8 = otherValue == "Sword" and config.favorite_swords or otherValue == "Explosion" and config.favorite_explosions
    if not temporary8 then
        temporary2 = {}
        temporary8 = temporary2
    end
    temporary2, result, temporary6 = pairs(temporary3)
    temporary2, result, temporary6 = normalizeIterator(temporary2, result, temporary6)
    temporary4 = temporary2(result, temporary6)
    temporary6 = temporary4
    if not (temporary4 == nil) then
        while true do
            if not temporary8[temporary4] then
                temporary3[temporary4] = nil
            end
            temporary4 = temporary2(result, temporary6)
            temporary6 = temporary4
            if temporary4 == nil then
                break
            else
                continue
            end
        end
    end
    temporary2, result, temporary6 = pairs(temporary8)
    temporary2, result, temporary6 = normalizeIterator(temporary2, result, temporary6)
    for index, item in temporary2, result, temporary6 do
        temporary4, temporary5, temporary6 = index, item, index
        temporary9 = temporary5 and true or nil
        temporary3[temporary4] = temporary9
    end
    temporary4, temporary5, temporary6 = nil, nil, nil
    return
end

function Handlers.toggleFav(config, saveConfigRef, self, category, itemName)
    local result, temporary2, favoriteSwords, temporary4, temporary5, gsub, ownsItem
    local gsub2, gsub3, temporary10, temporary11, temporary12, gsub4
    temporary2 = self:is_deleted(category, itemName)
    if temporary2 then
        return
    end
    if category == "Sword" then
        favoriteSwords = config.favorite_swords
        if not config.favorite_swords then
            temporary10 = {}
            favoriteSwords = temporary10
        end
        config.favorite_swords = favoriteSwords
        favoriteSwords = config.favorite_swords[itemName] and nil or true
        config.favorite_swords[itemName] = favoriteSwords
    else
        if category == "Explosion" then
            favoriteSwords = config.favorite_explosions
            if not config.favorite_explosions then
                temporary10 = {}
                favoriteSwords = temporary10
            end
            config.favorite_explosions = favoriteSwords
            favoriteSwords = config.favorite_explosions[itemName] and nil or true
            config.favorite_explosions[itemName] = favoriteSwords
        end
    end
    pcall(saveConfigRef.value)
    self:sync_fav_map(category)
    temporary2 = self.shop_controller and self.shop_controller._virtualItems and self.shop_controller._virtualItems[category]
    favoriteSwords = self.shop_controller and self.shop_controller._inventoryPages and self.shop_controller._inventoryPages[category]
    temporary10 = self:is_fav(category, itemName)
    temporary11 = type(temporary2)
    if temporary11 == "table" then
        temporary11, temporary4, temporary5 = pairs(temporary2)
        temporary11, temporary4, temporary5 = normalizeIterator(temporary11, temporary4, temporary5)
        temporary12, result = temporary11(temporary4, temporary5)
        temporary5 = temporary12
        if not (temporary12 == nil) then
            while true do
                if result.Name == itemName then
                    result.IsFavorited = temporary10
                    ownsItem = result.OwnsItem
                    if result.OwnsItem then
                        gsub4 = type(result.OwnsItem.Set)
                        ownsItem = gsub4 == "function"
                    end
                    if ownsItem then
                        pcall(result.OwnsItem.Set, result.OwnsItem, true)
                    end
                    ownsItem = result.OriginalLayoutOrder or result.LayoutOrder or 0
                    result.OriginalLayoutOrder = ownsItem
                    if temporary10 then
                        result.LayoutOrder = ownsItem - 1000
                        gsub3 = result.Name_ or result.Name
                        gsub, gsub3 = gsub3, gsub3.gsub
                        gsub3 = gsub3(gsub, "^#", "")
                        result.Name_ = "#" .. gsub3
                    else
                        result.LayoutOrder = ownsItem
                        gsub4 = result.Name_ or result.Name
                        gsub4, gsub2 = gsub4.gsub, gsub4
                        gsub4 = gsub4(gsub2, "^#", "")
                        result.Name_ = gsub4
                    end
                    break
                else
                    temporary12, result = temporary11(temporary4, temporary5)
                    temporary5 = temporary12
                    if temporary12 == nil then
                        break
                    else
                        continue
                    end
                end
                break
            end
        end
    end
    temporary11 = favoriteSwords and favoriteSwords.MarkDirty
    if temporary11 then
        favoriteSwords.MarkDirty(nil, true, true)
    end
    self:refresh_selected()
    return
end

function Handlers.toggleSelectedItemDeleted(cosmetics)
    local result, temporary2
    temporary2 = cosmetics.shop_controller and cosmetics.shop_controller._selectedItem
    result = not temporary2
    if temporary2 then
        result = not cosmetics.enabled
    end
    if result then
        return
    end
    result = temporary2.type ~= "Sword" and temporary2.type ~= "Explosion"
    if result then
        return
    end
    result = cosmetics:is_deleted(temporary2.type, temporary2.name)
    if result then
        cosmetics:undelete_item(temporary2.type, temporary2.name)
    else
        cosmetics:delete_item(temporary2.type, temporary2.name)
    end
    return
end

function Handlers.toggleSelectedItemFavorite(cosmetics)
    local result, temporary2
    result = cosmetics.shop_controller and cosmetics.shop_controller._selectedItem
    temporary2 = result and cosmetics.enabled and (result.type == "Sword" or result.type == "Explosion")
    if temporary2 then
        cosmetics:toggle_fav(result.type, result.name)
    end
    return
end

function Handlers.waitForShopCategoryRefresh(refreshGeneration, category, runService, cosmetics)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    local temporary8, temporary9, temporary10, temporary11
    temporary2 = cosmetics:expected_size(category)
    temporary9, temporary3, temporary10 = 0, -1, 1
    while true do
        runService.Heartbeat:Wait()
        temporary4 = not cosmetics.enabled
        if cosmetics.enabled then
            temporary4 = not cosmetics.unlocked[category]
        end
        if not temporary4 then
            temporary4 = cosmetics.refresh_generation[category] ~= refreshGeneration
        end
        if temporary4 then
            return
        end
        temporary7, temporary4 = 0, cosmetics.shop_controller._virtualItems[category]
        temporary5 = type(cosmetics.shop_controller._virtualItems[category])
        if temporary5 == "table" then
            temporary5, result, temporary6 = pairs(temporary4)
            temporary5, result, temporary6 = normalizeIterator(temporary5, result, temporary6)
            for index, item in temporary5, result, temporary6 do
                temporary11, temporary8, temporary6 = index, item, index
                if not temporary8.InventoryKey then
                    temporary7 = temporary7 + 1
                end
            end
            temporary11, temporary8, temporary6 = nil, nil, nil
        end
        temporary5 = temporary7 == temporary3 and temporary7 > 0
        if temporary5 then
            temporary9 = temporary9 + 1
        else
            temporary9, temporary3 = 0, temporary7
        end
        temporary5 = temporary2 > 0 and temporary7 >= temporary2 or temporary2 == 0 and temporary9 >= 5
        if temporary5 then
            runService.Heartbeat:Wait()
            cosmetics:set_category_unlock(category, true)
            return
        end
        temporary10 = temporary10 + 1
        if temporary10 > 120 then
            temporary10 = cosmetics.enabled and cosmetics.unlocked[category] and cosmetics.refresh_generation[category] == refreshGeneration
            if temporary10 then
                cosmetics:set_category_unlock(category, true)
            end
            return
        end
    end
end

-- ============================================================================
-- Configuration and utilities
-- ============================================================================

function Handlers.applyConfigToWorld()
    ApplyCfgToWorld()
    return
end

function Handlers.applyDeviceSpoofAndRejoin(getTeleportQueueRef, hasFileAccessRef, localPlayerRef, hasRejoinFlagRef, findAutoexecFolderRef)
    local result, temporary2Ref, retryTeleport, temporary4, teleportServiceRef, rejoinCurrentServer
    temporary2Ref = hasRejoinFlagRef.value()
    if temporary2Ref then
        temporary4 = hasFileAccessRef.value()
        if temporary4 then
            pcall(delfile, "ds_rejoin.flag")
        end
        temporary2Ref = findAutoexecFolderRef.value()
        if temporary2Ref then
            pcall(writefile, temporary2Ref .. "/device_spoofer.lua", DEVICE_SPOOFER_SOURCE)
        end
        temporary4 = loadstring(DEVICE_SPOOFER_SOURCE)
        temporary4()
        return
    end
    temporary4 = hasFileAccessRef.value()
    if temporary4 then
        pcall(writefile, "ds_rejoin.flag", "1")
    end
    temporary2Ref = findAutoexecFolderRef.value()
    temporary2Ref = {value = temporary2Ref}
    if not temporary2Ref.value then
        teleportServiceRef = bind(Handlers.ensureAutoexecFolder, temporary2Ref)
        pcall(teleportServiceRef)
    end
    if temporary2Ref.value then
        pcall(writefile, temporary2Ref.value .. "/device_spoofer.lua", DEVICE_SPOOFER_SOURCE)
    end
    temporary4 = getTeleportQueueRef.value()
    if temporary4 then
        pcall(temporary4, "if delfile then pcall(delfile, \"ds_rejoin.flag\") end\nloadstring([==[ local ReplicatedStorage = game:GetService(\"ReplicatedStorage\")\nlocal UserInputService = game:GetService(\"UserInputService\")\nlocal TARGET_DEVICE = \"PC\"\ntask.spawn(function()\n\tlocal cgm = ReplicatedStorage:WaitForChild(\"ClientGameModules\", 30)\n\tif not cgm then return end\n\tlocal mod = cgm:WaitForChild(\"DeviceListener\", 30)\n\tif not mod then return end\n\tlocal ok, DL = pcall(require, mod)\n\tif not ok or not DL then return end\n\tif DL.RegisterDeviceChanged then\n\t\tlocal OriginalRegister = DL.RegisterDeviceChanged\n\t\tDL.RegisterDeviceChanged = function(self, deviceTable, ...)\n\t\t\tif type(deviceTable) == \"table\" then\n\t\t\t\tfor k, v in pairs(deviceTable) do\n\t\t\t\t\tif type(v) == \"string\" then\n\t\t\t\t\t\tlocal l = v:lower()\n\t\t\t\t\t\tif l == \"mobile\" or l == \"phone\" or l == \"tablet\" or l == \"android\" or l == \"ios\" then\n\t\t\t\t\t\t\tdeviceTable[k] = TARGET_DEVICE\n\t\t\t\t\t\tend\n\t\t\t\t\telseif typeof(v) == \"EnumItem\" then\n\t\t\t\t\t\tif v == Enum.Platform.Android or v == Enum.Platform.IOS then\n\t\t\t\t\t\t\tdeviceTable[k] = Enum.Platform.Windows\n\t\t\t\t\t\tend\n\t\t\t\t\tend\n\t\t\t\tend\n\t\t\telseif type(deviceTable) == \"string\" then\n\t\t\t\tlocal l = deviceTable:lower()\n\t\t\t\tif l == \"mobile\" or l == \"phone\" or l == \"tablet\" or l == \"android\" or l == \"ios\" then\n\t\t\t\t\tdeviceTable = TARGET_DEVICE\n\t\t\t\tend\n\t\t\tend\n\t\t\treturn OriginalRegister(self, deviceTable, ...)\n\t\tend\n\tend\n\tpcall(function() DL.Device = TARGET_DEVICE end)\n\tpcall(function()\n\t\tif type(DL.Device) == \"table\" then\n\t\t\tfor k, v in pairs(DL.Device) do\n\t\t\t\tif type(v) == \"string\" then\n\t\t\t\t\tlocal l = v:lower()\n\t\t\t\t\tif l == \"mobile\" or l == \"phone\" or l == \"android\" or l == \"ios\" then\n\t\t\t\t\t\tDL.Device[k] = TARGET_DEVICE\n\t\t\t\t\tend\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\tend)\n\ttask.wait(1)\n\tpcall(function() DL:RegisterDeviceChanged(DL.Device) end)\n\ttask.wait(2)\n\tpcall(function() DL:RegisterDeviceChanged(DL.Device) end)\n\ttask.wait(3)\n\tpcall(function() DL:RegisterDeviceChanged(DL.Device) end)\nend)\nlocal mt = getrawmetatable(game)\nlocal oldIndex = mt.__index\nsetreadonly(mt, false)\nmt.__index = newcclosure(function(self, key)\n\tif self == UserInputService then\n\t\tif key == \"GetPlatform\" then\n\t\t\treturn function() return Enum.Platform.Windows end\n\t\tend\n\t\tif key == \"TouchEnabled\" or key == \"TouchScreenEnabled\" or key == \"AccelerometerEnabled\" or key == \"GyroscopeEnabled\" or key == \"GamepadEnabled\" or key == \"VREnabled\" then\n\t\t\treturn false\n\t\tend\n\t\tif key == \"KeyboardEnabled\" or key == \"MouseEnabled\" then\n\t\t\treturn true\n\t\tend\n\t\tif key == \"PreferredInput\" then\n\t\t\treturn Enum.PreferredInput.KeyboardAndMouse\n\t\tend\n\tend\n\treturn oldIndex(self, key)\nend)\nsetreadonly(mt, true)\n ]==])()\n")
    end
    teleportServiceRef = game:GetService("TeleportService")
    teleportServiceRef = {value = teleportServiceRef}
    rejoinCurrentServer = bind(Handlers.rejoinCurrentServer, teleportServiceRef, localPlayerRef)
    result = pcall(rejoinCurrentServer)
    if not result then
        retryTeleport, rejoinCurrentServer = bind(Handlers.retryTeleport, teleportServiceRef, localPlayerRef), task.delay
        rejoinCurrentServer(3, retryTeleport)
    end
    return
end

function Handlers.copyTelegramLink()
    setclipboard("https://t.me/SCRIPT417")
    return
end

function Handlers.copyTextToClipboard(clipboardText)
    local result
    result = packValues(tostring(clipboardText))
    setclipboard(unpackValues(result))
    return
end

function Handlers.copyTextToClipboardFallback(clipboardText)
    local result
    result = packValues(tostring(clipboardText))
    toclipboard(unpackValues(result))
    return
end

function Handlers.copyTikTokLink()
    setclipboard("https://www.tiktok.com/@vincere417")
    return
end

function Handlers.deleteConfigAndReset(applySavedUiStateRef, resetFramePositionsRef, immortalityStrokeRef, resetConfigDefaultsRef)
    local result
    result = isfile and delfile and isfile("417_config_file.json")
    if result then
        delfile("417_config_file.json")
    end
    resetConfigDefaultsRef.value()
    resetFramePositionsRef.value()
    immortalityStrokeRef.value()
    applySavedUiStateRef.value()
    return
end

function Handlers.encodeAndWriteConfig(config, httpService)
    local result, config2, config3, config4
    config2, config4, result = {}, config, {}
    config2.parry = config.parry
    config2.spamParry = config4.spamParry
    config2.trigger = config4.trigger
    config2.cps = config4.cps
    config2.accuracy = config4.accuracy
    config2.autoAccuracy = config4.autoAccuracy
    config2.spamThreshold = config4.spamThreshold
    config2.animfix = config4.animfix
    config2.showStats = config4.showStats
    config2.curveType = config4.curveType
    config2.showBindWindow = config4.showBindWindow
    config2.showSpamUI = config4.showSpamUI
    config2.showTriggerUI = config4.showTriggerUI
    config2.showImmortalUI = config4.showImmortalUI
    config2.showCurveUI = config4.showCurveUI
    config2.showFpsUI = config4.showFpsUI
    config2.saveButtonPositions = config4.saveButtonPositions
    config2.unlock_all = config4.unlock_all
    config2.last_equipped_sword = config4.last_equipped_sword
    config2.last_equipped_explosion = config4.last_equipped_explosion
    result.cfg = config2
    result.imm = config4.imm
    result.optim = config4.optim
    result.ability = config4.ability
    config3 = config4.buttonPositions
    if not config4.buttonPositions then
        config2 = {}
        config3 = config2
    end
    result.buttonPositions = config3
    config2 = config
    result.favorite_swords = config.favorite_swords
    result.favorite_explosions = config2.favorite_explosions
    result.deleted_swords = config2.deleted_swords
    result.deleted_explosions = config2.deleted_explosions
    config3 = _G._417_savedKeybind or "P"
    result.keybind = config3
    config3 = _G._417_savedBinds
    if not _G._417_savedBinds then
        config2 = {}
        config2.spam = "P"
        config2.trigger = "T"
        config4 = {}
        config2.curve = config4
        config3 = config2
    end
    result.binds = config3
    config2 = packValues(httpService:JSONEncode(result))
    writefile("417_config_file.json", unpackValues(config2))
    return
end

function Handlers.ensureAutoexecFolder(autoexecFolderRef)
    local result
    makefolder("autoexec")
    result = isfolder("autoexec")
    if result then
        autoexecFolderRef.value = "autoexec"
    end
    return
end

function Handlers.equipConfiguredSword(cosmetics, config)
    local result
    result = cosmetics.enabled and config.last_equipped_sword ~= ""
    if result then
        cosmetics:equip_sword(config.last_equipped_sword, false)
    end
    return
end

function Handlers.findAutoexecFolder()
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    local temporary8
    temporary8 = {}
    temporary8[7], temporary8[4], temporary8[5], temporary8[2], temporary8[1], temporary8[3], temporary8[6] = "workspace/autoexec", "Autoexec", "scripts/autoexec", "AutoExec", "autoexec", "AUTOEXEC", "scripts/AutoExec"
    temporary6, temporary2, result = ipairs(temporary8)
    temporary6, temporary2, result = normalizeIterator(temporary6, temporary2, result)
    temporary8, temporary5 = temporary6(temporary2, result)
    result = temporary8
    if not (temporary8 == nil) then
        while true do
            temporary7, temporary3 = pcall(isfolder, temporary5)
            temporary4 = temporary7 and temporary3
            if temporary4 then
                return temporary5
            end
            temporary8, temporary5 = temporary6(temporary2, result)
            result = temporary8
            if temporary8 == nil then
                return nil
            end
        end
    end
    return nil
end

function Handlers.getTeleportQueueFunction()
    local result, temporary2
    temporary2 = type(queueonteleport)
    if temporary2 == "function" then
        return queueonteleport
    end
    temporary2 = type(queue_on_teleport)
    if temporary2 == "function" then
        return queue_on_teleport
    end
    result = type(syn)
    temporary2 = result == "table"
    if result == "table" then
        result = type(syn.queue_on_teleport)
        temporary2 = result == "function"
    end
    if temporary2 then
        return syn.queue_on_teleport
    end
    result = type(fluxus)
    temporary2 = result == "table"
    if result == "table" then
        result = type(fluxus.queue_on_teleport)
        temporary2 = result == "function"
    end
    if temporary2 then
        return fluxus.queue_on_teleport
    end
    return nil
end

function Handlers.hasFileAccess()
    local result
    result = type(isfile)
    if result == "function" then
        result = type(writefile)
    end
    if result == "function" then
        result = type(delfile)
    end
    return result == "function"
end

function Handlers.hasRejoinFlag(hasFileAccessRef)
    local result, temporary2, temporary3
    temporary3 = hasFileAccessRef.value()
    if not temporary3 then
        return false
    end
    result, temporary3 = pcall(isfile, "ds_rejoin.flag")
    temporary2 = result and temporary3 == true
    return temporary2
end

-- Restore configuration values and saved key bindings from disk.
function Handlers.loadConfig(httpService, config)
    local result, temporary2, readAndDecodeConfig, temporary4, temporary5, temporary6, temporary7
    local temporary8
    readAndDecodeConfig = isfile and readfile
    if not readAndDecodeConfig then
        return
    end
    readAndDecodeConfig = isfile("417_config_file.json")
    if not readAndDecodeConfig then
        return
    end
    readAndDecodeConfig = bind(Handlers.readAndDecodeConfig, httpService)
    temporary2, readAndDecodeConfig = pcall(readAndDecodeConfig)
    temporary6 = not temporary2
    if temporary2 then
        temporary4 = type(readAndDecodeConfig)
        temporary6 = temporary4 ~= "table"
    end
    if temporary6 then
        return
    end
    temporary6 = type(readAndDecodeConfig.binds)
    if temporary6 == "table" then
        _G._417_savedBinds = readAndDecodeConfig.binds
    end
    temporary6 = type(readAndDecodeConfig.keybind)
    if temporary6 == "string" then
        _G._417_savedKeybind = readAndDecodeConfig.keybind
    end
    temporary4 = type(readAndDecodeConfig.cfg)
    temporary6 = temporary4 == "table" and readAndDecodeConfig.cfg.saveButtonPositions == true
    if not temporary6 then
        return
    end
    temporary4 = type(readAndDecodeConfig.buttonPositions)
    if temporary4 == "table" then
        config.buttonPositions = readAndDecodeConfig.buttonPositions
    end
    temporary4 = type(readAndDecodeConfig.cfg)
    if temporary4 == "table" then
        temporary4, temporary7, temporary5 = pairs(readAndDecodeConfig.cfg)
        temporary4, temporary7, temporary5 = normalizeIterator(temporary4, temporary7, temporary5)
        for index, item in temporary4, temporary7, temporary5 do
            result, temporary8, temporary5 = index, item, index
            if config[result] ~= nil then
                config[result] = temporary8
            end
        end
        result, temporary8, temporary5 = nil, nil, nil
        temporary4 = config.accuracy and config.accuracy <= 10
        if temporary4 then
            config.accuracy = 75
        end
    end
    temporary4 = type(readAndDecodeConfig.imm)
    if temporary4 == "table" then
        temporary4, temporary7, temporary5 = pairs(readAndDecodeConfig.imm)
        temporary4, temporary7, temporary5 = normalizeIterator(temporary4, temporary7, temporary5)
        for index2, item2 in temporary4, temporary7, temporary5 do
            result, temporary8, temporary5 = index2, item2, index2
            if config.imm[result] ~= nil then
                config.imm[result] = temporary8
            end
        end
        result, temporary8, temporary5 = nil, nil, nil
    end
    temporary4 = type(readAndDecodeConfig.optim)
    if temporary4 == "table" then
        temporary4, temporary7, temporary5 = pairs(readAndDecodeConfig.optim)
        temporary4, temporary7, temporary5 = normalizeIterator(temporary4, temporary7, temporary5)
        for index3, item3 in temporary4, temporary7, temporary5 do
            result, temporary8, temporary5 = index3, item3, index3
            if config.optim[result] ~= nil then
                config.optim[result] = temporary8
            end
        end
        result, temporary8, temporary5 = nil, nil, nil
    end
    temporary4 = type(readAndDecodeConfig.ability)
    if temporary4 == "table" then
        temporary4, temporary7, temporary5 = pairs(readAndDecodeConfig.ability)
        temporary4, temporary7, temporary5 = normalizeIterator(temporary4, temporary7, temporary5)
        for index4, item4 in temporary4, temporary7, temporary5 do
            result, temporary8, temporary5 = index4, item4, index4
            if config.ability[result] ~= nil then
                config.ability[result] = temporary8
            end
        end
        result, temporary8, temporary5 = nil, nil, nil
    end
    temporary4 = type(readAndDecodeConfig.favorite_swords)
    if temporary4 == "table" then
        config.favorite_swords = readAndDecodeConfig.favorite_swords
    end
    temporary4 = type(readAndDecodeConfig.favorite_explosions)
    if temporary4 == "table" then
        config.favorite_explosions = readAndDecodeConfig.favorite_explosions
    end
    temporary4 = type(readAndDecodeConfig.deleted_swords)
    if temporary4 == "table" then
        config.deleted_swords = readAndDecodeConfig.deleted_swords
    end
    temporary4 = type(readAndDecodeConfig.deleted_explosions)
    if temporary4 == "table" then
        config.deleted_explosions = readAndDecodeConfig.deleted_explosions
    end
    return
end

function Handlers.readAndDecodeConfig(httpService)
    local httpService2, temporary2, httpService3
    httpService3 = httpService
    temporary2 = packValues(readfile("417_config_file.json"))
    httpService3, httpService2 = httpService3.JSONDecode, httpService3
    httpService3 = packValues(httpService3(httpService2, unpackValues(temporary2)))
    return unpackValues(httpService3)
end

function Handlers.resetConfigDefaults(refreshKeybindPanelRef, keybinds, refreshCurvePanelRef, config, selectedCurveRef)
    local config2, temporary2, temporary3
    config2 = config
    config.parry = true
    config2.animfix = false
    config2.spamParry = false
    config2.trigger = false
    config2.immortality = false
    config2.autoAccuracy = false
    config2.accuracy = 75
    config2.cps = 200
    config2.spamThreshold = 1
    config2.curveType = "straight"
    config2.showStats = false
    config2.showFpsUI = false
    config2.showBindWindow = false
    config2.showSpamUI = false
    config2.showTriggerUI = false
    config2.showImmortalUI = false
    config2.showCurveUI = false
    config2.saveButtonPositions = false
    temporary2 = {}
    config2.buttonPositions = temporary2
    temporary2 = {}
    temporary2.angle = 70
    temporary2.height = 15
    temporary2.depth = -8
    temporary2.radius = 10
    temporary2.ui = false
    config2.imm = temporary2
    temporary2 = {
        destroyParticles = false,
        unlimitedKBPS = false,
        headless = false,
        korblox = false,
        noRender = false
    }
    config2.optim = temporary2
    temporary2 = {}
    temporary2.cooldown_protection = false
    config2.ability = temporary2
    config2.unlock_all = false
    temporary2 = {}
    config2.favorite_swords = temporary2
    temporary2 = {}
    config2.favorite_explosions = temporary2
    temporary2 = {}
    config2.deleted_swords = temporary2
    temporary2 = {}
    config2.deleted_explosions = temporary2
    config2.last_equipped_sword = ""
    config2.last_equipped_explosion = ""
    _G._417_savedKeybind = "P"
    temporary2 = {}
    temporary2.spam = "P"
    temporary2.trigger = "T"
    temporary3 = {}
    temporary2.curve = temporary3
    _G._417_savedBinds = temporary2
    config2 = keybinds
    keybinds.spam = Enum.KeyCode.P
    config2.trigger = Enum.KeyCode.T
    temporary2 = {}
    config2.curve = temporary2
    selectedCurveRef.value = "straight"
    pcall(refreshKeybindPanelRef.value)
    pcall(refreshCurvePanelRef.value)
    return
end

function Handlers.restoreConfiguredExplosion(cosmetics, config)
    if cosmetics.enabled then
        cosmetics:equip_explosion(config.last_equipped_explosion)
    end
    return
end

function Handlers.restoreConfiguredSword(cosmetics, config)
    if cosmetics.enabled then
        cosmetics:equip_sword(config.last_equipped_sword, false)
    end
    return
end

function Handlers.retryTeleport(teleportServiceRef, localPlayerRef)
    local teleportToCurrentPlace
    teleportToCurrentPlace = bind(Handlers.teleportToCurrentPlace, teleportServiceRef, localPlayerRef)
    pcall(teleportToCurrentPlace)
    return
end

-- Save the current configuration with protected file access.
function Handlers.saveConfig(config, httpService)
    local encodeAndWriteConfig
    if not writefile then
        return
    end
    if not config.saveButtonPositions then
        return
    end
    encodeAndWriteConfig = bind(Handlers.encodeAndWriteConfig, config, httpService)
    pcall(encodeAndWriteConfig)
    return
end

-- ============================================================================
-- Interface and input
-- ============================================================================

function Handlers.addButton(createInvisibleButtonRef, theme, tweenService, sectionRef, accentColor, self, title, onClick)
    local invokeButtonAction, fire, uIAspectRatioConstraint, button, labelText, uIStroke, uICorner
    local fire2
    onClick = {value = onClick}
    button = onClick.value or bind(Handlers.noopButton)
    onClick.value = button
    button = Instance.new("Frame")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    uIStroke = Instance.new("UIStroke")
    button.Name = "Button"
    button.Parent = sectionRef.value
    button.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    button.BackgroundTransparency = 0.55
    button.BorderSizePixel = 0
    fire2 = UDim2.new(0.899999976, 0, -0.351014495, 0)
    button.Size = fire2
    button.ZIndex = 5
    uIAspectRatioConstraint.Parent = button
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    fire2 = UDim.new(0, 8)
    uICorner.CornerRadius = fire2
    uICorner.Parent = button
    uIStroke.Thickness = 1
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = button
    labelText.Name = "LabelText"
    labelText.Parent = button
    fire2 = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = fire2
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    fire2 = UDim2.new(0.5, 0, 0.5, 0)
    labelText.Position = fire2
    fire2 = UDim2.new(0.899999976, 0, 0.75, 0)
    labelText.Size = fire2
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    fire2 = title or "Kill all"
    labelText.Text = fire2
    labelText.TextColor3 = accentColor
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextTransparency = 0.3
    labelText.TextWrapped = true
    fire = createInvisibleButtonRef.value(button)
    fire2, invokeButtonAction = fire.MouseButton1Click, bind(Handlers.invokeButtonAction, onClick)
    fire, fire2 = fire2, fire2.Connect
    fire2(fire, invokeButtonAction)
    fire2, invokeButtonAction = button.MouseEnter, bind(Handlers.highlightButton, tweenService, labelText, uIStroke)
    fire2, fire = fire2.Connect, fire2
    fire2(fire, invokeButtonAction)
    invokeButtonAction, fire2 = bind(Handlers.unhighlightButton, tweenService, labelText, uIStroke), button.MouseLeave
    fire, fire2 = fire2, fire2.Connect
    fire2(fire, invokeButtonAction)
    fire = {}
    fire2 = fire
    fire = bind(Handlers.fire, onClick)
    fire2.Fire = fire
    fire = bind(Handlers.setToggleLabelText, labelText)
    fire2.Text = fire
    return fire2
end

function Handlers.addDropdown(tweenService, tweenServiceRef2, createInvisibleButtonRef, sectionRef, accentColor, theme, self, title, items, defaultValue, onChanged)
    local rebuildDropdownItemsRef, setDropdownExpandedRef, downBar, setDropdownValue, topBar, refreshDropdownButtonStatesRef, updateDropdownVisibilityRef
    local icon, refreshDropdownItems, setDropdownButtonStatesRef, noopDropdownRef, uIStroke, temporary13Ref, uICorner
    local uICorner2, labelText, valueText, updateLabelRef, noopDropdownRef2, uIListLayout, uIAspectRatioConstraint
    local uICorner3, uIStroke2
    items = {value = items}
    onChanged = {value = onChanged}
    noopDropdownRef2 = items.value
    if not items.value then
        uIAspectRatioConstraint = {}
        noopDropdownRef2 = uIAspectRatioConstraint
    end
    noopDropdownRef2, items.value = defaultValue, noopDropdownRef2
    if not defaultValue then
        noopDropdownRef2 = items.value[1]
    end
    noopDropdownRef2, defaultValue = onChanged.value, noopDropdownRef2
    if not onChanged.value then
        noopDropdownRef2 = bind(Handlers.noopDropdown)
    end
    onChanged.value = noopDropdownRef2
    noopDropdownRef2 = Instance.new("Frame")
    noopDropdownRef2 = {value = noopDropdownRef2}
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner2 = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    topBar = Instance.new("Frame")
    uICorner = Instance.new("UICorner")
    uIStroke = Instance.new("UIStroke")
    valueText = Instance.new("TextLabel")
    icon = Instance.new("TextLabel")
    downBar = Instance.new("Frame")
    uICorner3 = Instance.new("UICorner")
    uIStroke2 = Instance.new("UIStroke")
    uIListLayout = Instance.new("UIListLayout")
    noopDropdownRef2.value.Name = "Dropdown"
    noopDropdownRef2.value.Parent = sectionRef.value
    noopDropdownRef2.value.BackgroundTransparency = 1
    noopDropdownRef2.value.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(0.899999976, 0, -0.351014495, 0)
    noopDropdownRef2.value.Size = noopDropdownRef
    noopDropdownRef2.value.ZIndex = 5
    uIAspectRatioConstraint.Parent = noopDropdownRef2.value
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    noopDropdownRef = UDim.new(0, 8)
    uICorner2.CornerRadius = noopDropdownRef
    uICorner2.Parent = noopDropdownRef2.value
    labelText.Name = "LabelText"
    labelText.Parent = noopDropdownRef2.value
    noopDropdownRef = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = noopDropdownRef
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(0.296666116, 0, 0.499999374, 0)
    labelText.Position = noopDropdownRef
    noopDropdownRef = UDim2.new(0.593582511, 0, 0.75, 0)
    labelText.Size = noopDropdownRef
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    noopDropdownRef = title or "Label-Test"
    labelText.Text = noopDropdownRef
    noopDropdownRef = Color3.fromRGB(255, 255, 255)
    labelText.TextColor3 = noopDropdownRef
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextWrapped = true
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    topBar.Name = "TopBar"
    topBar.Parent = noopDropdownRef2.value
    topBar.Active = true
    noopDropdownRef = Vector2.new(1, 0.5)
    topBar.AnchorPoint = noopDropdownRef
    topBar.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    topBar.BackgroundTransparency = 0.5
    topBar.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(0.950000167, 0, 0.500000715, 0)
    topBar.Position = noopDropdownRef
    noopDropdownRef = UDim2.new(0.313529521, 0, 0.5, 0)
    topBar.Size = noopDropdownRef
    topBar.ZIndex = 6
    noopDropdownRef = UDim.new(1, 0)
    uICorner.CornerRadius = noopDropdownRef
    uICorner.Parent = topBar
    uIStroke.Thickness = 1
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = topBar
    valueText.Name = "ValueText"
    valueText.Parent = topBar
    noopDropdownRef = Vector2.new(0.5, 0.5)
    valueText.AnchorPoint = noopDropdownRef
    valueText.BackgroundTransparency = 1
    valueText.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(0.358571023, 0, 0.500001013, 0)
    valueText.Position = noopDropdownRef
    noopDropdownRef = UDim2.new(0.697142839, 0, 0.998000145, 0)
    valueText.Size = noopDropdownRef
    valueText.ZIndex = 6
    valueText.Font = Enum.Font.SourceSansSemibold
    noopDropdownRef = tostring(defaultValue)
    valueText.Text = noopDropdownRef
    noopDropdownRef = Color3.fromRGB(255, 255, 255)
    valueText.TextColor3 = noopDropdownRef
    valueText.TextScaled = true
    valueText.TextSize = 14
    valueText.TextWrapped = true
    icon.Name = "Icon"
    icon.Parent = topBar
    noopDropdownRef = Vector2.new(1, 0.5)
    icon.AnchorPoint = noopDropdownRef
    icon.BackgroundTransparency = 1
    icon.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(1, 0, 0.5, 0)
    icon.Position = noopDropdownRef
    icon.Rotation = 90
    noopDropdownRef = UDim2.new(0.949999988, 0, 0.949999988, 0)
    icon.Size = noopDropdownRef
    icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
    icon.ZIndex = 6
    icon.Font = Enum.Font.SourceSans
    icon.Text = "<"
    icon.TextColor3 = accentColor
    icon.TextScaled = true
    icon.TextSize = 14
    icon.TextWrapped = true
    downBar.Name = "DownBar"
    downBar.Parent = noopDropdownRef2.value
    downBar.Active = true
    noopDropdownRef = Vector2.new(1, 0)
    downBar.AnchorPoint = noopDropdownRef
    downBar.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    downBar.BackgroundTransparency = 0.15
    downBar.BorderSizePixel = 0
    noopDropdownRef = UDim2.new(0.948214233, 0, 0.873961239, 0)
    downBar.Position = noopDropdownRef
    noopDropdownRef = UDim2.new(0.308999985, 0, 0, 0)
    downBar.Size = noopDropdownRef
    downBar.Visible = false
    downBar.ZIndex = 10
    noopDropdownRef = UDim.new(0, 10)
    uICorner3.CornerRadius = noopDropdownRef
    uICorner3.Parent = downBar
    uIStroke2.Thickness = 1
    uIStroke2.Color = accentColor
    uIStroke2.Transparency = 0.5
    uIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke2.Parent = downBar
    uIListLayout.Parent = downBar
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    noopDropdownRef = UDim.new(0, 2)
    uIListLayout.Padding = noopDropdownRef
    noopDropdownRef = {value = defaultValue}
    temporary13Ref = {value = false}
    refreshDropdownButtonStatesRef = downBar:GetPropertyChangedSignal("Size")
    setDropdownButtonStatesRef, updateDropdownVisibilityRef, refreshDropdownButtonStatesRef = refreshDropdownButtonStatesRef, bind(Handlers.updateDropdownVisibility, downBar), refreshDropdownButtonStatesRef.Connect
    refreshDropdownButtonStatesRef(setDropdownButtonStatesRef, updateDropdownVisibilityRef)
    refreshDropdownButtonStatesRef = {value = bind(Handlers.refreshDropdownButtonStates, downBar)}
    setDropdownButtonStatesRef = {value = bind(Handlers.setDropdownButtonStates, downBar)}
    updateDropdownVisibilityRef = {value = bind(Handlers.setSectionExpanded, setDropdownButtonStatesRef, tweenService, downBar, temporary13Ref)}
    setDropdownExpandedRef = {
        value = bind(Handlers.setDropdownExpanded, labelText, refreshDropdownButtonStatesRef, updateDropdownVisibilityRef, noopDropdownRef2, icon, tweenService, downBar)
    }
    setDropdownExpandedRef.value(temporary13Ref.value)
    rebuildDropdownItemsRef = createInvisibleButtonRef.value(noopDropdownRef2.value)
    setDropdownValue, updateLabelRef = bind(Handlers.setDropdownValue, temporary13Ref, setDropdownExpandedRef), rebuildDropdownItemsRef.MouseButton1Click
    rebuildDropdownItemsRef, updateLabelRef = updateLabelRef, updateLabelRef.Connect
    updateLabelRef(rebuildDropdownItemsRef, setDropdownValue)
    updateLabelRef = {value = bind(Handlers.updateLabel, downBar, tweenService)}
    rebuildDropdownItemsRef = {value = bind(Handlers.rebuildDropdownItems, onChanged, valueText, noopDropdownRef, downBar, updateLabelRef, items)}
    table.insert(theme.auto_function, updateDropdownVisibilityRef.value)
    rebuildDropdownItemsRef.value()
    refreshDropdownItems = {}
    setDropdownValue = refreshDropdownItems
    refreshDropdownItems = bind(Handlers.refreshDropdownItems, items, rebuildDropdownItemsRef)
    setDropdownValue.Refresh = refreshDropdownItems
    refreshDropdownItems = bind(Handlers.setDropdownLabelText, labelText)
    setDropdownValue.Text = refreshDropdownItems
    refreshDropdownItems = bind(Handlers.get, noopDropdownRef)
    setDropdownValue.Get = refreshDropdownItems
    refreshDropdownItems = bind(Handlers.setValue, valueText, noopDropdownRef)
    setDropdownValue.SetValue = refreshDropdownItems
    tweenServiceRef2.value()
    return setDropdownValue
end

function Handlers.addKeybind(textService, userInputService, createInvisibleButtonRef, sectionRef, tweenService, accentColor, self, title, defaultKey, onPressed)
    local setDropdownTitleAndResize, uICorner, resizeKeybindTextRef, captureKeybind, labelText, uIAspectRatioConstraint, temporary7Ref
    local valueText, keybind, setDropdownTitleAndResize2, uIStroke, brindText, uICorner2
    defaultKey = {value = defaultKey}
    onPressed = {value = onPressed}
    keybind = onPressed.value or bind(Handlers.noopKeybind)
    onPressed.value = keybind
    keybind = Instance.new("Frame")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner2 = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    brindText = Instance.new("Frame")
    uICorner = Instance.new("UICorner")
    uIStroke = Instance.new("UIStroke")
    valueText = Instance.new("TextLabel")
    keybind.Name = "Keybind"
    keybind.Parent = sectionRef.value
    keybind.BackgroundTransparency = 1
    keybind.BorderSizePixel = 0
    resizeKeybindTextRef = UDim2.new(0.899999976, 0, -0.351014495, 0)
    keybind.Size = resizeKeybindTextRef
    keybind.ZIndex = 5
    uIAspectRatioConstraint.Parent = keybind
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    resizeKeybindTextRef = UDim.new(0, 8)
    uICorner2.CornerRadius = resizeKeybindTextRef
    uICorner2.Parent = keybind
    labelText.Name = "LabelText"
    labelText.Parent = keybind
    resizeKeybindTextRef = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = resizeKeybindTextRef
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    resizeKeybindTextRef = UDim2.new(0.296665907, 0, 0.499999106, 0)
    labelText.Position = resizeKeybindTextRef
    resizeKeybindTextRef = UDim2.new(0.593582749, 0, 0.75, 0)
    labelText.Size = resizeKeybindTextRef
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    resizeKeybindTextRef = title or ""
    labelText.Text = resizeKeybindTextRef
    resizeKeybindTextRef = Color3.fromRGB(255, 255, 255)
    labelText.TextColor3 = resizeKeybindTextRef
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextWrapped = true
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextTransparency = 0.3
    brindText.Name = "BrindText"
    brindText.Parent = keybind
    resizeKeybindTextRef = Vector2.new(1, 0.5)
    brindText.AnchorPoint = resizeKeybindTextRef
    resizeKeybindTextRef = Color3.fromRGB(26, 26, 26)
    brindText.BackgroundColor3 = resizeKeybindTextRef
    brindText.BackgroundTransparency = 0.5
    brindText.BorderSizePixel = 0
    resizeKeybindTextRef = UDim2.new(0.998, 0, 0.5, 0)
    brindText.Position = resizeKeybindTextRef
    resizeKeybindTextRef = UDim2.new(0.150000006, 0, 0.5, 0)
    brindText.Size = resizeKeybindTextRef
    brindText.ZIndex = 6
    resizeKeybindTextRef = UDim.new(1, 0)
    uICorner.CornerRadius = resizeKeybindTextRef
    uICorner.Parent = brindText
    uIStroke.Thickness = 1
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = brindText
    valueText.Name = "ValueText"
    valueText.Parent = brindText
    resizeKeybindTextRef = Vector2.new(0.5, 0.5)
    valueText.AnchorPoint = resizeKeybindTextRef
    valueText.BackgroundTransparency = 1
    valueText.BorderSizePixel = 0
    resizeKeybindTextRef = UDim2.new(0.5, 0, 0.5, 0)
    valueText.Position = resizeKeybindTextRef
    resizeKeybindTextRef = UDim2.new(0.980000019, 0, 0.998000026, 0)
    valueText.Size = resizeKeybindTextRef
    valueText.ZIndex = 6
    valueText.Font = Enum.Font.SourceSansSemibold
    if not defaultKey.value then
        resizeKeybindTextRef = "None"
    else
        resizeKeybindTextRef = defaultKey.value.Name
    end
    valueText.Text = resizeKeybindTextRef
    resizeKeybindTextRef = Color3.fromRGB(255, 255, 255)
    valueText.TextColor3 = resizeKeybindTextRef
    valueText.TextScaled = true
    valueText.TextSize = 14
    valueText.TextWrapped = true
    resizeKeybindTextRef = {value = bind(Handlers.resizeKeybindText, brindText, valueText, tweenService, textService)}
    temporary7Ref = {value = false}
    setDropdownTitleAndResize = createInvisibleButtonRef.value(keybind)
    captureKeybind, setDropdownTitleAndResize2 = bind(Handlers.captureKeybind, labelText, resizeKeybindTextRef, onPressed, temporary7Ref, tweenService, userInputService, valueText, defaultKey), setDropdownTitleAndResize.MouseButton1Click
    setDropdownTitleAndResize2, setDropdownTitleAndResize = setDropdownTitleAndResize2.Connect, setDropdownTitleAndResize2
    setDropdownTitleAndResize2(setDropdownTitleAndResize, captureKeybind)
    resizeKeybindTextRef.value()
    setDropdownTitleAndResize = {}
    setDropdownTitleAndResize2, setDropdownTitleAndResize = setDropdownTitleAndResize, bind(Handlers.setDropdownTitleAndResize, labelText, resizeKeybindTextRef)
    setDropdownTitleAndResize2.Text = setDropdownTitleAndResize
    setDropdownTitleAndResize = bind(Handlers.setKeybindValue, onPressed, defaultKey, resizeKeybindTextRef, valueText)
    setDropdownTitleAndResize2.Value = setDropdownTitleAndResize
    return setDropdownTitleAndResize2
end

function Handlers.addLabel(sectionRef, tweenServiceRef, tweenServiceRef2, self, text)
    local uICorner, label, updateLabelVisibility, text2, labelText, uIAspectRatioConstraint, text3
    label = Instance.new("Frame")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = sectionRef.value
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    text3 = UDim2.new(0.899999976, 0, 0.5, 0)
    label.Size = text3
    label.ZIndex = 5
    uIAspectRatioConstraint.Parent = label
    uIAspectRatioConstraint.AspectRatio = 6
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    text3 = UDim.new(0, 8)
    uICorner.CornerRadius = text3
    uICorner.Parent = label
    labelText.Name = "LabelText"
    labelText.Parent = label
    text3 = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = text3
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    text3 = UDim2.new(0.5, 0, 0.5, 0)
    labelText.Position = text3
    text3 = UDim2.new(1, 0, 0.649999976, 0)
    labelText.Size = text3
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    text3 = text or "Label"
    labelText.Text = text3
    text3 = Color3.fromRGB(255, 255, 255)
    labelText.TextColor3 = text3
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextTransparency = 0.3
    labelText.TextWrapped = true
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    tweenServiceRef.value()
    text3 = labelText:GetPropertyChangedSignal("TextTransparency")
    updateLabelVisibility, text2, text3 = bind(Handlers.updateLabelVisibility, labelText, label), text3, text3.Connect
    text3(text2, updateLabelVisibility)
    text2 = {}
    text3, text2 = text2, bind(Handlers.text, labelText)
    text3.Text = text2
    text2 = bind(Handlers.setLabelStatus, tweenServiceRef2, label, labelText)
    text3.Status = text2
    return text3
end

function Handlers.addSection(accentColor, createInvisibleButtonRef, userInputService, left, theme, right, tweenService, textService, self, title, side)
    local addButton, uICorner, tweenServiceRef2, uIListLayout, uIStroke, tweenServiceRef3, uICorner2
    local addButton2, updateSectionVisibility, lay, header, sectionRef
    sectionRef = side or "left"
    side = sectionRef
    sectionRef = Instance.new("Frame")
    sectionRef = {value = sectionRef}
    uICorner = Instance.new("UICorner")
    uIStroke = Instance.new("UIStroke")
    header = Instance.new("TextLabel")
    uIListLayout = Instance.new("UIListLayout")
    lay = Instance.new("Frame")
    uICorner2 = Instance.new("UICorner")
    sectionRef.value.Name = "Section"
    tweenServiceRef3 = side == "left" and left or side == "right" and right or nil
    sectionRef.value.Parent = tweenServiceRef3
    sectionRef.value.BackgroundColor3 = theme.Themes.SectionColor
    sectionRef.value.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.970000029, 0, 0, 0)
    sectionRef.value.Size = tweenServiceRef3
    sectionRef.value.ZIndex = 5
    tweenServiceRef3 = UDim.new(0, 10)
    uICorner.CornerRadius = tweenServiceRef3
    uICorner.Parent = sectionRef.value
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.Thickness = 1
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = sectionRef.value
    header.Name = "Header"
    header.Parent = sectionRef.value
    tweenServiceRef3 = Vector2.new(0.5, 0)
    header.AnchorPoint = tweenServiceRef3
    header.BackgroundTransparency = 1
    header.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.5, 0, 0.100000001, 0)
    header.Position = tweenServiceRef3
    tweenServiceRef3 = UDim2.new(0.949999988, 0, 0, 15)
    header.Size = tweenServiceRef3
    header.ZIndex = 5
    header.Font = Enum.Font.SourceSansSemibold
    tweenServiceRef3 = title or "Section"
    header.Text = tweenServiceRef3
    header.TextColor3 = accentColor
    header.TextScaled = true
    header.TextSize = 14
    header.TextWrapped = true
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.TextTransparency = 1
    tweenServiceRef3, addButton = tweenService, header
    addButton2 = TweenInfo.new(0.3)
    updateSectionVisibility = {}
    updateSectionVisibility.TextTransparency = 0
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Create
    tweenServiceRef3 = tweenServiceRef3(tweenServiceRef2, addButton, addButton2, updateSectionVisibility)
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Play
    tweenServiceRef3(tweenServiceRef2)
    uIListLayout.Parent = sectionRef.value
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tweenServiceRef3 = UDim.new(0, 4)
    uIListLayout.Padding = tweenServiceRef3
    lay.Name = "lay"
    lay.Parent = sectionRef.value
    lay.BackgroundColor3 = accentColor
    lay.BorderSizePixel = 0
    tweenServiceRef3 = UDim2.new(0.970000029, 0, 0, 1)
    lay.Size = tweenServiceRef3
    lay.ZIndex = 5
    lay.BackgroundTransparency = 1
    sectionRef.value.BackgroundTransparency = 1
    uIStroke.Transparency = 1
    tweenServiceRef3, addButton = tweenService, lay
    addButton2 = TweenInfo.new(1)
    updateSectionVisibility = {}
    updateSectionVisibility.BackgroundTransparency = 0.5
    tweenServiceRef3, tweenServiceRef2 = tweenServiceRef3.Create, tweenServiceRef3
    tweenServiceRef3 = tweenServiceRef3(tweenServiceRef2, addButton, addButton2, updateSectionVisibility)
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Play
    tweenServiceRef3(tweenServiceRef2)
    tweenServiceRef3 = tweenService
    addButton = sectionRef.value
    addButton2 = TweenInfo.new(1)
    updateSectionVisibility = {}
    updateSectionVisibility.BackgroundTransparency = 0.55
    tweenServiceRef3, tweenServiceRef2 = tweenServiceRef3.Create, tweenServiceRef3
    tweenServiceRef3 = tweenServiceRef3(tweenServiceRef2, addButton, addButton2, updateSectionVisibility)
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef3, tweenServiceRef3.Play
    tweenServiceRef3(tweenServiceRef2)
    addButton, tweenServiceRef3 = uIStroke, tweenService
    addButton2 = TweenInfo.new(1)
    updateSectionVisibility = {}
    updateSectionVisibility.Transparency = 0.5
    tweenServiceRef3, tweenServiceRef2 = tweenServiceRef3.Create, tweenServiceRef3
    tweenServiceRef3 = tweenServiceRef3(tweenServiceRef2, addButton, addButton2, updateSectionVisibility)
    tweenServiceRef3, tweenServiceRef2 = tweenServiceRef3.Play, tweenServiceRef3
    tweenServiceRef3(tweenServiceRef2)
    tweenServiceRef3 = {value = true}
    tweenServiceRef2 = UDim.new(1, 0)
    uICorner2.CornerRadius = tweenServiceRef2
    uICorner2.Parent = lay
    tweenServiceRef2 = {value = bind(Handlers.resizeSectionToContent, sectionRef, tweenServiceRef3, tweenService)}
    table.insert(theme.auto_function, tweenServiceRef2.value)
    addButton = sectionRef.value:GetPropertyChangedSignal("Size")
    addButton, addButton2, updateSectionVisibility = addButton.Connect, addButton, bind(Handlers.updateSectionVisibility, sectionRef)
    addButton(addButton2, updateSectionVisibility)
    sectionRef.value.InputBegan:Connect(tweenServiceRef2.value)
    tweenServiceRef2.value()
    addButton2 = {}
    addButton = addButton2
    addButton2 = bind(Handlers.addButton, createInvisibleButtonRef, theme, tweenService, sectionRef, accentColor)
    addButton.AddButton = addButton2
    addButton2 = bind(Handlers.addLabel, sectionRef, tweenServiceRef2, tweenService)
    addButton.AddLabel = addButton2
    addButton2 = bind(Handlers.addToggle, createInvisibleButtonRef, theme, tweenService, sectionRef)
    addButton.AddToggle = addButton2
    addButton2 = bind(Handlers.addKeybind, textService, userInputService, createInvisibleButtonRef, sectionRef, tweenService, accentColor)
    addButton.AddKeybind = addButton2
    addButton2 = bind(Handlers.addSlider, tweenService, tweenServiceRef2, userInputService, sectionRef, accentColor, theme)
    addButton.AddSlider = addButton2
    addButton2 = bind(Handlers.addDropdown, tweenService, tweenServiceRef2, createInvisibleButtonRef, sectionRef, accentColor, theme)
    addButton.AddDropdown = addButton2
    addButton2 = bind(Handlers.hide, lay, header, uIStroke, tweenService, tweenServiceRef3, sectionRef)
    addButton.Hide = addButton2
    addButton2 = bind(Handlers.show, header, sectionRef, uIStroke, tweenServiceRef2, tweenService, tweenServiceRef3, lay)
    addButton.Show = addButton2
    return addButton
end

function Handlers.addSlider(tweenService, tweenServiceRef2, userInputService, sectionRef, accentColor, theme, self, title, minimum, maximum, defaultValue, onChanged)
    local frame, uIAspectRatioConstraint, value, valueText, setSliderValueRef, onSliderFocusChanged, uICorner
    local uICorner2, uICorner3, noopSlider, value2, uICorner4, inline, cir
    local moveFrame, labelText, box, uICorner5, uIStroke, positionRef
    minimum = {value = minimum}
    maximum = {value = maximum}
    onChanged = {value = onChanged}
    noopSlider = minimum.value or 1
    minimum.value, noopSlider = noopSlider, maximum.value
    if not noopSlider then
        noopSlider = 100
    end
    maximum.value, noopSlider = noopSlider, defaultValue
    if not defaultValue then
        noopSlider = minimum.value
    end
    noopSlider, defaultValue = onChanged.value, noopSlider
    if not onChanged.value then
        noopSlider = bind(Handlers.noopSlider)
    end
    onChanged.value = noopSlider
    noopSlider = Instance.new("Frame")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    box = Instance.new("Frame")
    uICorner2 = Instance.new("UICorner")
    uIStroke = Instance.new("UIStroke")
    valueText = Instance.new("TextLabel")
    moveFrame = Instance.new("Frame")
    uICorner4 = Instance.new("UICorner")
    inline = Instance.new("Frame")
    uICorner3 = Instance.new("UICorner")
    cir = Instance.new("Frame")
    uICorner5 = Instance.new("UICorner")
    frame = Instance.new("Frame")
    noopSlider.Name = "Slider"
    noopSlider.Parent = sectionRef.value
    noopSlider.BackgroundTransparency = 1
    noopSlider.BorderSizePixel = 0
    positionRef = UDim2.new(0.899999976, 0, -0.351014495, 0)
    noopSlider.Size = positionRef
    noopSlider.ZIndex = 5
    uIAspectRatioConstraint.Parent = noopSlider
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    positionRef = UDim.new(0, 8)
    uICorner.CornerRadius = positionRef
    uICorner.Parent = noopSlider
    labelText.Name = "LabelText"
    labelText.Parent = noopSlider
    positionRef = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = positionRef
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    positionRef = UDim2.new(0.238462642, 0, 0.499999374, 0)
    labelText.Position = positionRef
    positionRef = UDim2.new(0.477176398, 0, 0.75, 0)
    labelText.Size = positionRef
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    positionRef = title or "Control"
    labelText.Text = positionRef
    positionRef = Color3.fromRGB(255, 255, 255)
    labelText.TextColor3 = positionRef
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextWrapped = true
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextTransparency = 0.3
    box.Name = "Box"
    box.Parent = noopSlider
    positionRef = Vector2.new(0, 0.5)
    box.AnchorPoint = positionRef
    box.BackgroundColor3 = theme.Themes.ButtonBlackgroundColor
    box.BackgroundTransparency = 0.5
    box.BorderSizePixel = 0
    positionRef = UDim2.new(0.800000012, 0, 0.5, 0)
    box.Position = positionRef
    positionRef = UDim2.new(0.150000006, 0, 0.5, 0)
    box.Size = positionRef
    box.ZIndex = 6
    positionRef = UDim.new(1, 0)
    uICorner2.CornerRadius = positionRef
    uICorner2.Parent = box
    uIStroke.Thickness = 1
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = box
    valueText.Name = "ValueText"
    valueText.Parent = box
    positionRef = Vector2.new(0.5, 0.5)
    valueText.AnchorPoint = positionRef
    valueText.BackgroundTransparency = 1
    valueText.BorderSizePixel = 0
    positionRef = UDim2.new(0.5, 0, 0.5, 0)
    valueText.Position = positionRef
    positionRef = UDim2.new(0.99000001, 0, 0.99000001, 0)
    valueText.Size = positionRef
    valueText.ZIndex = 6
    valueText.Font = Enum.Font.SourceSansSemibold
    positionRef = tostring(defaultValue)
    valueText.Text = positionRef
    positionRef = Color3.fromRGB(255, 255, 255)
    valueText.TextColor3 = positionRef
    valueText.TextScaled = true
    valueText.TextSize = 14
    valueText.TextWrapped = true
    moveFrame.Name = "MoveFrame"
    moveFrame.Parent = noopSlider
    positionRef = Vector2.new(0, 0.5)
    moveFrame.AnchorPoint = positionRef
    moveFrame.BackgroundColor3 = theme.Themes.MainColorDrop
    moveFrame.BorderSizePixel = 0
    moveFrame.ClipsDescendants = true
    positionRef = UDim2.new(0.477050841, 0, 0.50000006, 0)
    moveFrame.Position = positionRef
    positionRef = UDim2.new(0.290949076, 0, 0.099999994, 0)
    moveFrame.Size = positionRef
    moveFrame.ZIndex = 5
    positionRef = UDim.new(1, 0)
    uICorner4.CornerRadius = positionRef
    uICorner4.Parent = moveFrame
    inline.Name = "Inline"
    inline.Parent = moveFrame
    positionRef = Vector2.new(0, 0.5)
    inline.AnchorPoint = positionRef
    inline.BackgroundColor3 = theme.Themes.MainColor
    inline.BorderSizePixel = 0
    positionRef = UDim2.new(0, 0, 0.5, 0)
    inline.Position = positionRef
    positionRef = UDim2.new(defaultValue / maximum.value, 0, 1, 0)
    inline.Size = positionRef
    inline.ZIndex = 5
    positionRef = UDim.new(1, 0)
    uICorner3.CornerRadius = positionRef
    uICorner3.Parent = inline
    cir.Name = "Cir"
    cir.Parent = inline
    positionRef = Vector2.new(1, 0.5)
    cir.AnchorPoint = positionRef
    cir.BackgroundColor3 = theme.Themes.MainColor
    cir.BorderSizePixel = 0
    positionRef = UDim2.new(1, 0, 0.5, 0)
    cir.Position = positionRef
    positionRef = UDim2.new(3, 0, 3, 0)
    cir.Size = positionRef
    cir.SizeConstraint = Enum.SizeConstraint.RelativeYY
    cir.ZIndex = 5
    positionRef = UDim.new(0.5, 0)
    uICorner5.CornerRadius = positionRef
    uICorner5.Parent = cir
    frame.Parent = noopSlider
    positionRef = Vector2.new(0, 0.5)
    frame.AnchorPoint = positionRef
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    positionRef = UDim2.new(0.477050841, 0, 0.500000358, 0)
    frame.Position = positionRef
    positionRef = UDim2.new(0.322948873, 0, 0.900000036, 0)
    frame.Size = positionRef
    frame.ZIndex = 5
    positionRef = {value = false}
    setSliderValueRef = {value = 0.322948873}
    value, setSliderValueRef.value = frame.InputBegan, bind(Handlers.setSliderValue, valueText, inline, onChanged, moveFrame, minimum, maximum, tweenService)
    onSliderFocusChanged, value, value2 = bind(Handlers.onSliderFocusChanged, labelText, setSliderValueRef, tweenService, positionRef), value.Connect, value
    value(value2, onSliderFocusChanged)
    onSliderFocusChanged, value = bind(Handlers.onTextBoxFocusChanged, positionRef, tweenService, labelText), frame.InputEnded
    value, value2 = value.Connect, value
    value(value2, onSliderFocusChanged)
    value2, onSliderFocusChanged, value = userInputService.InputChanged, bind(Handlers.onDropdownInputChanged, positionRef, setSliderValueRef), userInputService.InputChanged.Connect
    value(value2, onSliderFocusChanged)
    value2 = {}
    value2, value = bind(Handlers.value, onChanged, inline, maximum, valueText), value2
    value.Value = value2
    value2 = bind(Handlers.setValueWe, valueText, inline, maximum)
    value.SetValue = value2
    value2 = bind(Handlers.setButtonLabelText, labelText)
    value.Text = value2
    tweenServiceRef2.value()
    return value
end

function Handlers.addTab(tabTitleRef, screenGui, accentColor, userInputService, tabHose, textService, tweenService, createInvisibleButtonRef, theme, tabButtons, self, title, icon)
    local image, fadeTabTitleRef, label, uIAspectRatioConstraint, mainColor, bindCanvasSize, right
    local uICorner, updateSelectedTabButtons, uIListLayout, uIListLayout2, selectTab, tabRef, tabButtonRef
    local tabButton2, left, bindCanvasSize2, uICorner2
    tabButtonRef = {}
    tabButton2 = tabButtonRef
    tabButtonRef = Instance.new("Frame")
    tabButtonRef = {value = tabButtonRef}
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner = Instance.new("UICorner")
    image = Instance.new("ImageLabel")
    uICorner2 = Instance.new("UICorner")
    label = Instance.new("TextLabel")
    mainColor = theme.Themes.MainColor
    tabRef = Color3.fromRGB(0, 172, 247)
    if mainColor == tabRef then
        mainColor = theme.Themes.BlackgroundColor
    end
    tabButtonRef.value.Name = "TabButton"
    tabButtonRef.value.Parent = tabButtons
    tabButtonRef.value.BackgroundColor3 = mainColor
    tabButtonRef.value.BackgroundTransparency = 1
    tabRef = Color3.fromRGB(0, 0, 0)
    tabButtonRef.value.BorderColor3 = tabRef
    tabButtonRef.value.BorderSizePixel = 0
    tabRef = UDim2.new(0.899999976, 0, 0.5, 0)
    tabButtonRef.value.Size = tabRef
    tabButtonRef.value.ZIndex = 5
    uIAspectRatioConstraint.Parent = tabButtonRef.value
    uIAspectRatioConstraint.AspectRatio = 4
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    tabRef = UDim.new(0, 8)
    uICorner.CornerRadius = tabRef
    uICorner.Parent = tabButtonRef.value
    image.Name = "Image"
    image.Parent = tabButtonRef.value
    tabRef = Vector2.new(0, 0.5)
    image.AnchorPoint = tabRef
    image.BackgroundTransparency = 1
    image.BorderSizePixel = 0
    tabRef = UDim2.new(0.0149999997, 0, 0.5, 0)
    image.Position = tabRef
    tabRef = UDim2.new(0.850000024, 0, 0.800000012, 0)
    image.Size = tabRef
    image.SizeConstraint = Enum.SizeConstraint.RelativeYY
    image.ZIndex = 5
    image.ImageColor3 = theme.Themes.MainColor
    tabRef = icon or "rbxassetid://3926305904"
    image.Image = tabRef
    tabRef = UDim.new(0, 3)
    uICorner2.CornerRadius = tabRef
    uICorner2.Parent = image
    label.Name = "Label"
    label.Parent = tabButtonRef.value
    tabRef = Vector2.new(0.5, 0.5)
    label.AnchorPoint = tabRef
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    tabRef = UDim2.new(0.640507042, 0, 0.500000238, 0)
    label.Position = tabRef
    tabRef = UDim2.new(0.718986034, 0, 0.600000024, 0)
    label.Size = tabRef
    label.ZIndex = 5
    label.Font = Enum.Font.SourceSansBold
    tabRef = title or "Index"
    label.Text = tabRef
    tabRef = Color3.fromRGB(255, 255, 255)
    label.TextColor3 = tabRef
    label.TextScaled = true
    label.TextSize = 14
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    tabRef = Instance.new("Frame")
    tabRef = {value = tabRef}
    left = Instance.new("ScrollingFrame")
    uIListLayout2 = Instance.new("UIListLayout")
    right = Instance.new("ScrollingFrame")
    uIListLayout = Instance.new("UIListLayout")
    tabRef.value.Name = "Tab"
    tabRef.value.Parent = tabHose
    fadeTabTitleRef = Vector2.new(0.5, 0.5)
    tabRef.value.AnchorPoint = fadeTabTitleRef
    tabRef.value.BackgroundTransparency = 1
    tabRef.value.BorderSizePixel = 0
    tabRef.value.ClipsDescendants = true
    fadeTabTitleRef = UDim2.new(0.5, 0, 0.5, 0)
    tabRef.value.Position = fadeTabTitleRef
    fadeTabTitleRef = UDim2.new(0.99000001, 0, 0.99000001, 0)
    tabRef.value.Size = fadeTabTitleRef
    tabRef.value.ZIndex = 6
    left.Name = "Left"
    left.Parent = tabRef.value
    left.Active = true
    fadeTabTitleRef = Vector2.new(0, 0.5)
    left.AnchorPoint = fadeTabTitleRef
    left.BackgroundTransparency = 1
    left.BorderSizePixel = 0
    left.ClipsDescendants = false
    fadeTabTitleRef = UDim2.new(0, 0, 0.5, 0)
    left.Position = fadeTabTitleRef
    fadeTabTitleRef = UDim2.new(0.499000001, 0, 0.980000019, 0)
    left.Size = fadeTabTitleRef
    left.ZIndex = 5
    left.ScrollBarThickness = 0
    left.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
    uIListLayout2.Parent = left
    uIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    fadeTabTitleRef = UDim.new(0, 5)
    uIListLayout2.Padding = fadeTabTitleRef
    right.Name = "Right"
    right.Parent = tabRef.value
    right.Active = true
    fadeTabTitleRef = Vector2.new(1, 0.5)
    right.AnchorPoint = fadeTabTitleRef
    right.BackgroundTransparency = 1
    right.BorderSizePixel = 0
    right.ClipsDescendants = false
    fadeTabTitleRef = UDim2.new(1, 0, 0.5, 0)
    right.Position = fadeTabTitleRef
    fadeTabTitleRef = UDim2.new(0.499000001, 0, 0.980000019, 0)
    right.Size = fadeTabTitleRef
    right.ZIndex = 5
    right.ScrollBarThickness = 0
    uIListLayout.Parent = right
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    fadeTabTitleRef = UDim.new(0, 5)
    uIListLayout.Padding = fadeTabTitleRef
    fadeTabTitleRef = {value = right}
    bindCanvasSize, selectTab = bind(Handlers.bindCanvasSize, fadeTabTitleRef), task.spawn
    selectTab(bindCanvasSize)
    fadeTabTitleRef = {value = left}
    selectTab, bindCanvasSize = task.spawn, bind(Handlers.bindCanvasSize, fadeTabTitleRef)
    selectTab(bindCanvasSize)
    fadeTabTitleRef = {value = bind(Handlers.fadeTabTitle, tabTitleRef, tweenService)}
    selectTab, bindCanvasSize2 = bind(Handlers.selectTab, tabButtonRef, fadeTabTitleRef, tweenService, tabRef), screenGui
    if #bindCanvasSize2 == 0 then
        selectTab(true, 0)
    else
        selectTab(false, 0)
    end
    bindCanvasSize, bindCanvasSize2, updateSelectedTabButtons = table.insert, screenGui, {}
    updateSelectedTabButtons[2], updateSelectedTabButtons[1] = selectTab, tabRef.value
    bindCanvasSize(bindCanvasSize2, updateSelectedTabButtons)
    bindCanvasSize2 = createInvisibleButtonRef.value(tabButtonRef.value)
    updateSelectedTabButtons, bindCanvasSize = bind(Handlers.updateSelectedTabButtons, screenGui, tabRef), bindCanvasSize2.MouseButton1Click
    bindCanvasSize2, bindCanvasSize = bindCanvasSize, bindCanvasSize.Connect
    bindCanvasSize(bindCanvasSize2, updateSelectedTabButtons)
    bindCanvasSize = bind(Handlers.addSection, accentColor, createInvisibleButtonRef, userInputService, left, theme, right, tweenService, textService)
    tabButton2.AddSection = bindCanvasSize
    return tabButton2
end

function Handlers.addTabLabel(tabButtons, self, otherValue)
    local uIAspectRatioConstraint, tabTitle, setTabLabelText, setTabLabelText2
    tabTitle = Instance.new("TextLabel")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    tabTitle.Name = "TabTitle"
    tabTitle.Parent = tabButtons
    setTabLabelText2 = Color3.fromRGB(255, 255, 255)
    tabTitle.BackgroundColor3 = setTabLabelText2
    tabTitle.BackgroundTransparency = 1
    setTabLabelText2 = Color3.fromRGB(0, 0, 0)
    tabTitle.BorderColor3 = setTabLabelText2
    tabTitle.BorderSizePixel = 0
    setTabLabelText2 = UDim2.new(0.949999988, 0, 0.5, 0)
    tabTitle.Size = setTabLabelText2
    tabTitle.ZIndex = 5
    tabTitle.Font = Enum.Font.SourceSansSemibold
    setTabLabelText2 = otherValue or "Home"
    tabTitle.Text = setTabLabelText2
    setTabLabelText2 = Color3.fromRGB(255, 255, 255)
    tabTitle.TextColor3 = setTabLabelText2
    tabTitle.TextScaled = true
    tabTitle.TextSize = 14
    tabTitle.TextTransparency = 0.61
    tabTitle.TextWrapped = true
    tabTitle.TextXAlignment = Enum.TextXAlignment.Left
    uIAspectRatioConstraint.Parent = tabTitle
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    setTabLabelText = {}
    setTabLabelText2 = setTabLabelText
    setTabLabelText = bind(Handlers.setTabLabelText, tabTitle)
    setTabLabelText2.Text = setTabLabelText
    setTabLabelText = bind(Handlers.delete, tabTitle)
    setTabLabelText2.Delete = setTabLabelText
    return setTabLabelText2
end

function Handlers.addToggle(createInvisibleButtonRef, theme, tweenService, sectionRef, self, title, defaultValue, onChanged)
    local uICorner, uIAspectRatioConstraint, uICorner2, icon, effect, setSliderLabelText, uICorner3
    local labelText, animateToggleValueRef, setSliderLabelText2, setToggleValueAndNotify, toggle
    defaultValue = {value = defaultValue}
    onChanged = {value = onChanged}
    toggle = onChanged.value or bind(Handlers.noopToggle)
    onChanged.value = toggle
    toggle = Instance.new("Frame")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uICorner3 = Instance.new("UICorner")
    labelText = Instance.new("TextLabel")
    effect = Instance.new("Frame")
    uICorner = Instance.new("UICorner")
    icon = Instance.new("Frame")
    uICorner2 = Instance.new("UICorner")
    toggle.Name = "Toggle"
    toggle.Parent = sectionRef.value
    toggle.BackgroundTransparency = 1
    toggle.BorderSizePixel = 0
    animateToggleValueRef = UDim2.new(0.899999976, 0, -0.351014495, 0)
    toggle.Size = animateToggleValueRef
    toggle.ZIndex = 5
    uIAspectRatioConstraint.Parent = toggle
    uIAspectRatioConstraint.AspectRatio = 7
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    animateToggleValueRef = UDim.new(0, 8)
    uICorner3.CornerRadius = animateToggleValueRef
    uICorner3.Parent = toggle
    labelText.Name = "LabelText"
    labelText.Parent = toggle
    animateToggleValueRef = Vector2.new(0.5, 0.5)
    labelText.AnchorPoint = animateToggleValueRef
    labelText.BackgroundTransparency = 1
    labelText.BorderSizePixel = 0
    animateToggleValueRef = UDim2.new(0.38587454, 0, 0.499999583, 0)
    labelText.Position = animateToggleValueRef
    animateToggleValueRef = UDim2.new(0.772000015, 0, 0.75, 0)
    labelText.Size = animateToggleValueRef
    labelText.ZIndex = 6
    labelText.Font = Enum.Font.SourceSansSemibold
    animateToggleValueRef = title or "Label-Test"
    labelText.Text = animateToggleValueRef
    animateToggleValueRef = Color3.fromRGB(255, 255, 255)
    labelText.TextColor3 = animateToggleValueRef
    labelText.TextScaled = true
    labelText.TextSize = 14
    labelText.TextWrapped = true
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    effect.Name = "Effect"
    effect.Parent = toggle
    animateToggleValueRef = Vector2.new(0, 0.5)
    effect.AnchorPoint = animateToggleValueRef
    effect.BackgroundColor3 = theme.Themes.MainColorDrop
    effect.BorderSizePixel = 0
    animateToggleValueRef = UDim2.new(0.800000012, 0, 0.5, 0)
    effect.Position = animateToggleValueRef
    animateToggleValueRef = UDim2.new(0.180000006, 0, 0.55, 0)
    effect.Size = animateToggleValueRef
    effect.ZIndex = 6
    animateToggleValueRef = UDim.new(0.5, 0)
    uICorner.CornerRadius = animateToggleValueRef
    uICorner.Parent = effect
    icon.Name = "Icon"
    icon.Parent = effect
    animateToggleValueRef = Vector2.new(0.5, 0.5)
    icon.AnchorPoint = animateToggleValueRef
    icon.BackgroundColor3 = theme.Themes.MainColor
    icon.BorderSizePixel = 0
    animateToggleValueRef = UDim2.new(0.75, 0, 0.5, 0)
    icon.Position = animateToggleValueRef
    animateToggleValueRef = UDim2.new(1, 0, 1, 0)
    icon.Size = animateToggleValueRef
    icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
    icon.ZIndex = 7
    animateToggleValueRef = UDim.new(0.5, 0)
    uICorner2.CornerRadius = animateToggleValueRef
    uICorner2.Parent = icon
    animateToggleValueRef = {value = bind(Handlers.animateToggleValue, theme, labelText, icon, tweenService)}
    animateToggleValueRef.value(defaultValue.value, 0)
    setSliderLabelText = createInvisibleButtonRef.value(toggle)
    setSliderLabelText2, setSliderLabelText, setToggleValueAndNotify = setSliderLabelText.MouseButton1Click.Connect, setSliderLabelText.MouseButton1Click, bind(Handlers.setToggleValueAndNotify, defaultValue, animateToggleValueRef, onChanged)
    setSliderLabelText2(setSliderLabelText, setToggleValueAndNotify)
    setSliderLabelText = {}
    setSliderLabelText2, setSliderLabelText = setSliderLabelText, bind(Handlers.setSliderLabelText, labelText)
    setSliderLabelText2.Text = setSliderLabelText
    setSliderLabelText = bind(Handlers.setDropdownValueAndNotify, defaultValue, animateToggleValueRef, onChanged)
    setSliderLabelText2.Value = setSliderLabelText
    setSliderLabelText = bind(Handlers.setValueDf, defaultValue, animateToggleValueRef)
    setSliderLabelText2.SetValue = setSliderLabelText
    setSliderLabelText = bind(Handlers.status, labelText, icon, effect, defaultValue, toggle, tweenService)
    setSliderLabelText2.Status = setSliderLabelText
    return setSliderLabelText2
end

function Handlers.addWindow(guiParent, theme, textService, createInvisibleButtonRef, userInputService, tweenService, protectGui, localPlayerRef, accentColor, self, title, subtitle, icon)
    local uICorner, inputBegan, frame, positionRef, uICorner2, uICorner3, uICorner4
    local tweenServiceRef2, uICorner5, screenGui, uIListLayout, screenGuiRef2, beginWindowDragging, uICorner6
    local tweenService2, updateNotificationDragRef, inputBegan2, outlo, uICorner7, temporary20Ref, userData
    local uICorner8, temporary23Ref, connectRef, dropShadow, bindCanvasSizeRef, tweenService3, outloRef2
    local headName, tweenServiceRef3, outloRef3, position2, frameRef2, userName, tabHose
    local tabButtons, frameRef3, userImage, createWindowTitleRef
    positionRef = {}
    positionRef, position2 = icon, positionRef
    if not icon then
        positionRef = UDim2.new(0.200000003, 210, 0.200000003, 175)
    end
    positionRef = {value = positionRef}
    screenGuiRef2 = {}
    screenGui = screenGuiRef2
    screenGuiRef2 = Instance.new("ScreenGui")
    frameRef2 = Instance.new("Frame")
    uICorner4 = Instance.new("UICorner")
    frame = Instance.new("Frame")
    uICorner = Instance.new("UICorner")
    frameRef3 = Instance.new("Frame")
    uICorner2 = Instance.new("UICorner")
    dropShadow = Instance.new("ImageLabel")
    headName = Instance.new("TextLabel")
    tabButtons = Instance.new("ScrollingFrame")
    uIListLayout = Instance.new("UIListLayout")
    tabHose = Instance.new("Frame")
    outlo = Instance.new("Frame")
    uICorner8 = Instance.new("UICorner")
    outloRef2 = Instance.new("Frame")
    uICorner5 = Instance.new("UICorner")
    outloRef3 = Instance.new("Frame")
    uICorner3 = Instance.new("UICorner")
    userData = Instance.new("Frame")
    uICorner6 = Instance.new("UICorner")
    userImage = Instance.new("ImageLabel")
    uICorner7 = Instance.new("UICorner")
    userName = Instance.new("TextLabel")
    temporary23Ref = {value = nil}
    temporary20Ref = {value = nil}
    connectRef = screenGuiRef2:GetPropertyChangedSignal("Enabled")
    createWindowTitleRef, connectRef, tweenService3 = connectRef, connectRef.Connect, bind(Handlers.keepScreenGuiEnabled, screenGuiRef2)
    connectRef(createWindowTitleRef, tweenService3)
    connectRef, createWindowTitleRef = task.spawn, bind(Handlers.createWindowTitle, temporary23Ref, frameRef2, accentColor, subtitle)
    connectRef(createWindowTitleRef)
    connectRef = {value = true}
    createWindowTitleRef = {
        value = bind(Handlers.setWindowVisible, {
            headName = headName,
            tabButtons = tabButtons,
            outlo = outloRef2,
            frame = frameRef3,
            outloRef2 = outloRef3,
            outloRef3 = outlo,
            frameRef2 = frame,
            titleRef = temporary23Ref,
            tweenService = tweenService,
            frameRef3 = frameRef2,
            userName = userName,
            positionRef = positionRef,
            originalPositionRef = temporary20Ref,
            userImage = userImage,
            dropShadow = dropShadow,
            tabHose = tabHose
        })
    }
    tweenService3, tweenService2 = task.spawn, bind(Handlers.createWindowToggleButton, connectRef, tweenService, temporary20Ref, frameRef2, createWindowTitleRef)
    tweenService3(tweenService2)
    tweenService3 = task.spawn
    tweenService2 = bind(Handlers.connectWindowDrag, frameRef2, connectRef, userInputService)
    tweenService3(tweenService2)
    screenGuiRef2.Parent = guiParent
    screenGuiRef2.ResetOnSpawn = false
    screenGuiRef2.IgnoreGuiInset = true
    screenGuiRef2.ZIndexBehavior = Enum.ZIndexBehavior.Global
    protectGui(screenGuiRef2)
    frameRef2.Parent = screenGuiRef2
    frameRef2.Active = true
    tweenService3 = Vector2.new(0.5, 0.5)
    frameRef2.AnchorPoint = tweenService3
    frameRef2.BackgroundColor3 = theme.Themes.BlackgroundColor
    frameRef2.BackgroundTransparency = 0.45
    tweenService3 = Color3.fromRGB(0, 0, 0)
    frameRef2.BorderColor3 = tweenService3
    frameRef2.BorderSizePixel = 0
    tweenService3 = UDim2.new(0.5, 0, 0.5, 0)
    frameRef2.Position = tweenService3
    tweenService3 = UDim2.new(0, 0, 0, 0)
    frameRef2.Size = tweenService3
    frameRef2.ZIndex = 2
    frameRef2.ClipsDescendants = true
    tweenService3, tweenServiceRef2 = tweenService, frameRef2
    tweenServiceRef3 = TweenInfo.new(1, Enum.EasingStyle.Quint)
    bindCanvasSizeRef = {}
    bindCanvasSizeRef.Size = positionRef.value
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, tweenServiceRef2, tweenServiceRef3, bindCanvasSizeRef)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService3 = UDim.new(0, 12)
    uICorner4.CornerRadius = tweenService3
    uICorner4.Parent = frameRef2
    tweenService3 = Instance.new("UIStroke")
    tweenService3.Color = accentColor
    tweenService3.Transparency = 0.4
    tweenService3.Thickness = 1
    tweenService3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tweenService3.Parent = frameRef2
    frame.Parent = frameRef2
    frame.BackgroundColor3 = theme.Themes.BlackColor
    frame.BackgroundTransparency = 0.55
    tweenService2 = Color3.fromRGB(0, 0, 0)
    frame.BorderColor3 = tweenService2
    frame.BorderSizePixel = 0
    tweenService2 = UDim2.new(0.223214373, 0, 0, 0)
    frame.Position = tweenService2
    tweenService2 = UDim2.new(0.774634778, 0, 1, 0)
    frame.Size = tweenService2
    frame.ZIndex = 2
    tweenService2 = UDim.new(0, 0)
    uICorner.CornerRadius = tweenService2
    tweenService2 = UDim.new(0, 10)
    uICorner.TopRightRadius = tweenService2
    tweenService2 = UDim.new(0, 10)
    uICorner.BottomRightRadius = tweenService2
    uICorner.Parent = frame
    frameRef3.Parent = frameRef2
    frameRef3.BackgroundColor3 = theme.Themes.HeaderColor
    frameRef3.BackgroundTransparency = 0.7
    tweenService2 = Color3.fromRGB(0, 0, 0)
    frameRef3.BorderColor3 = tweenService2
    frameRef3.BorderSizePixel = 0
    tweenService2 = UDim2.new(0.223214373, 0, 0, 0)
    frameRef3.Position = tweenService2
    tweenService2 = UDim2.new(0.774999976, 0, 0.140000001, 0)
    frameRef3.Size = tweenService2
    frameRef3.ZIndex = 4
    tweenService2 = UDim.new(0, 10)
    uICorner2.CornerRadius = tweenService2
    uICorner2.Parent = frameRef3
    dropShadow.Name = "DropShadow"
    dropShadow.Parent = frameRef2
    tweenService2 = Vector2.new(0.5, 0.5)
    dropShadow.AnchorPoint = tweenService2
    dropShadow.BackgroundTransparency = 1
    dropShadow.BorderSizePixel = 0
    tweenService2 = UDim2.new(0.963742971, 0, 0.5, 0)
    dropShadow.Position = tweenService2
    tweenService2 = UDim2.new(-0.0510042384, 47, 0.839458942, 47)
    dropShadow.Size = tweenService2
    dropShadow.ZIndex = 3
    dropShadow.Image = "rbxassetid://6014261993"
    tweenService2 = Color3.fromRGB(0, 0, 0)
    dropShadow.ImageColor3 = tweenService2
    dropShadow.ImageTransparency = 0.86
    dropShadow.ScaleType = Enum.ScaleType.Slice
    tweenService2 = Rect.new(49, 49, 450, 450)
    dropShadow.SliceCenter = tweenService2
    headName.Name = "HeadName"
    headName.Parent = frameRef2
    tweenService2 = Color3.fromRGB(255, 255, 255)
    headName.BackgroundColor3 = tweenService2
    headName.BackgroundTransparency = 1
    tweenService2 = Color3.fromRGB(0, 0, 0)
    headName.BorderColor3 = tweenService2
    headName.BorderSizePixel = 0
    tweenService2 = UDim2.new(0.0100000342, 0, 0.010000146, 0)
    headName.Position = tweenService2
    tweenService2 = UDim2.new(0.205458686, 0, 0.133462012, 0)
    headName.Size = tweenService2
    headName.ZIndex = 4
    headName.Font = Enum.Font.SourceSansBold
    tweenService2 = title or "NEVERLOSE"
    headName.Text = tweenService2
    tweenService2 = Color3.fromRGB(255, 255, 255)
    headName.TextColor3 = tweenService2
    headName.TextScaled = true
    headName.TextSize = 14
    headName.TextStrokeColor3 = accentColor
    headName.TextStrokeTransparency = 0.72
    headName.TextWrapped = true
    tweenService2 = Instance.new("UIGradient")
    tweenService2.Parent = headName
    tweenServiceRef2, tweenServiceRef3 = ColorSequence.new, {}
    bindCanvasSizeRef = ColorSequenceKeypoint.new(0, accentColor)
    updateNotificationDragRef = ColorSequenceKeypoint.new
    inputBegan = packValues(Color3.fromRGB(255, 190, 60))
    updateNotificationDragRef = updateNotificationDragRef(0.5, unpackValues(inputBegan))
    inputBegan2 = packValues(ColorSequenceKeypoint.new(1, accentColor))
    tweenServiceRef3[2], tweenServiceRef3[1] = updateNotificationDragRef, bindCanvasSizeRef
    setRange(tweenServiceRef3, 3, unpackValues(inputBegan2))
    tweenServiceRef2 = tweenServiceRef2(tweenServiceRef3)
    tweenService2.Color = tweenServiceRef2
    tweenServiceRef2 = Vector2.new(-1, 0)
    tweenService2.Offset = tweenServiceRef2
    tweenServiceRef2 = tweenService
    updateNotificationDragRef = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    inputBegan2 = {}
    inputBegan = Vector2.new(1, 0)
    inputBegan2.Offset = inputBegan
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef2.Create, tweenServiceRef2
    tweenServiceRef2 = tweenServiceRef2(tweenServiceRef3, tweenService2, updateNotificationDragRef, inputBegan2)
    tweenServiceRef2, tweenServiceRef3 = tweenServiceRef2.Play, tweenServiceRef2
    tweenServiceRef2(tweenServiceRef3)
    tabButtons.Name = "TabButtons"
    tabButtons.Parent = frameRef2
    tabButtons.Active = true
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    tabButtons.BackgroundColor3 = tweenServiceRef2
    tabButtons.BackgroundTransparency = 1
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    tabButtons.BorderColor3 = tweenServiceRef2
    tabButtons.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.00760957832, 0, 0.143462211, 0)
    tabButtons.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.20784913, 0, 0.753122032, 0)
    tabButtons.Size = tweenServiceRef2
    tabButtons.ZIndex = 5
    tweenServiceRef2 = UDim2.new(0, 0, 0, 0)
    tabButtons.CanvasSize = tweenServiceRef2
    tabButtons.ScrollBarThickness = 1
    uIListLayout.Parent = tabButtons
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tweenServiceRef2 = UDim.new(0, 4)
    uIListLayout.Padding = tweenServiceRef2
    tweenServiceRef2 = {value = tabButtons}
    tweenServiceRef3, bindCanvasSizeRef = task.spawn, bind(Handlers.bindCanvasSize, tweenServiceRef2)
    tweenServiceRef3(bindCanvasSizeRef)
    tabHose.Name = "TabHose"
    tabHose.Parent = frameRef2
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    tabHose.BackgroundColor3 = tweenServiceRef2
    tabHose.BackgroundTransparency = 1
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    tabHose.BorderColor3 = tweenServiceRef2
    tabHose.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.223214373, 0, 0.143462211, 0)
    tabHose.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.774635077, 0, 0.856537759, 0)
    tabHose.Size = tweenServiceRef2
    tabHose.ZIndex = 5
    outlo.Name = "outlo"
    outlo.Parent = frameRef2
    tweenServiceRef2 = Vector2.new(1, 0)
    outlo.AnchorPoint = tweenServiceRef2
    outlo.BackgroundColor3 = theme.Themes.TraceColor
    outlo.BackgroundTransparency = 0.55
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    outlo.BorderColor3 = tweenServiceRef2
    outlo.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(1, 0, 0.136999995, 0)
    outlo.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.774999976, 0, 0, 1)
    outlo.Size = tweenServiceRef2
    outlo.ZIndex = 4
    tweenServiceRef2 = UDim.new(0, 4)
    uICorner8.CornerRadius = tweenServiceRef2
    uICorner8.Parent = outlo
    outloRef2.Name = "outlo"
    outloRef2.Parent = frameRef2
    tweenServiceRef2 = Vector2.new(1, 0.5)
    outloRef2.AnchorPoint = tweenServiceRef2
    outloRef2.BackgroundColor3 = theme.Themes.TraceColor
    outloRef2.BackgroundTransparency = 0.55
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    outloRef2.BorderColor3 = tweenServiceRef2
    outloRef2.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.223908007, 0, 0.5, 0)
    outloRef2.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0, 1, 1, 0)
    outloRef2.Size = tweenServiceRef2
    outloRef2.ZIndex = 4
    tweenServiceRef2 = UDim.new(0, 4)
    uICorner5.CornerRadius = tweenServiceRef2
    uICorner5.Parent = outloRef2
    outloRef3.Name = "outlo"
    outloRef3.Parent = frameRef2
    tweenServiceRef2 = Vector2.new(1, 0)
    outloRef3.AnchorPoint = tweenServiceRef2
    outloRef3.BackgroundColor3 = theme.Themes.TraceColor
    outloRef3.BackgroundTransparency = 0.55
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    outloRef3.BorderColor3 = tweenServiceRef2
    outloRef3.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.223908007, 0, 0.923109949, 0)
    outloRef3.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.223908007, 0, 0, 1)
    outloRef3.Size = tweenServiceRef2
    outloRef3.ZIndex = 4
    tweenServiceRef2 = UDim.new(0, 4)
    uICorner3.CornerRadius = tweenServiceRef2
    uICorner3.Parent = outloRef3
    userData.Name = "UserData"
    userData.Parent = frameRef2
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    userData.BackgroundColor3 = tweenServiceRef2
    userData.BackgroundTransparency = 1
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    userData.BorderColor3 = tweenServiceRef2
    userData.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(-0.000179085735, 0, 0.926525652, 0)
    userData.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.225179195, 0, 0.0718210712, 0)
    userData.Size = tweenServiceRef2
    userData.ZIndex = 5
    tweenServiceRef2 = UDim.new(0, 2)
    uICorner6.CornerRadius = tweenServiceRef2
    uICorner6.Parent = userData
    userImage.Name = "UserImage"
    userImage.Parent = userData
    tweenServiceRef2 = Vector2.new(0.5, 0.5)
    userImage.AnchorPoint = tweenServiceRef2
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    userImage.BackgroundColor3 = tweenServiceRef2
    userImage.BackgroundTransparency = 1
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    userImage.BorderColor3 = tweenServiceRef2
    userImage.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.150000006, 0, 0.5, 0)
    userImage.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.949999988, 0, 0.949999988, 0)
    userImage.Size = tweenServiceRef2
    userImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    userImage.ZIndex = 5
    tweenServiceRef3 = bind(Handlers.loadPlayerAvatarThumbnail, userImage, localPlayerRef)
    pcall(tweenServiceRef3)
    tweenServiceRef2 = UDim.new(0.5, 0)
    uICorner7.CornerRadius = tweenServiceRef2
    uICorner7.Parent = userImage
    userName.Name = "UserName"
    userName.Parent = userData
    tweenServiceRef2 = Vector2.new(0, 0.5)
    userName.AnchorPoint = tweenServiceRef2
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    userName.BackgroundColor3 = tweenServiceRef2
    userName.BackgroundTransparency = 1
    tweenServiceRef2 = Color3.fromRGB(0, 0, 0)
    userName.BorderColor3 = tweenServiceRef2
    userName.BorderSizePixel = 0
    tweenServiceRef2 = UDim2.new(0.31400001, 0, 0.5, 0)
    userName.Position = tweenServiceRef2
    tweenServiceRef2 = UDim2.new(0.717000008, 0, 0.649999976, 0)
    userName.Size = tweenServiceRef2
    userName.ZIndex = 5
    userName.Font = Enum.Font.SourceSansSemibold
    tweenServiceRef2 = localPlayerRef.value.DisplayName or "Player"
    userName.Text = tweenServiceRef2
    tweenServiceRef2 = Color3.fromRGB(255, 255, 255)
    userName.TextColor3 = tweenServiceRef2
    userName.TextScaled = true
    userName.TextSize = 14
    userName.TextWrapped = true
    userName.TextXAlignment = Enum.TextXAlignment.Left
    tweenServiceRef2 = bind(Handlers.addTabLabel, tabButtons)
    position2.AddTabLabel = tweenServiceRef2
    tweenServiceRef2 = bind(Handlers.addTab, temporary23Ref, screenGui, accentColor, userInputService, tabHose, textService, tweenService, createInvisibleButtonRef, theme, tabButtons)
    position2.AddTab = tweenServiceRef2
    tweenServiceRef2 = bind(Handlers.updateHeader, headName, temporary23Ref)
    position2.UpdateHeader = tweenServiceRef2
    tweenServiceRef2 = bind(Handlers.destroyUiElement, screenGuiRef2)
    position2.Delete = tweenServiceRef2
    tweenServiceRef2 = {value = nil}
    tweenServiceRef3 = {value = nil}
    bindCanvasSizeRef = {value = nil}
    updateNotificationDragRef = {value = bind(Handlers.updateNotificationDrag, tweenServiceRef3, bindCanvasSizeRef, frameRef2)}
    beginWindowDragging, inputBegan2 = bind(Handlers.beginWindowDragging, frameRef2, tweenServiceRef3, bindCanvasSizeRef, tweenServiceRef2), frameRef3.InputBegan
    inputBegan2, inputBegan = inputBegan2.Connect, inputBegan2
    inputBegan2(inputBegan, beginWindowDragging)
    beginWindowDragging, inputBegan2 = bind(Handlers.onKeySystemInputChanged, tweenServiceRef2, updateNotificationDragRef), userInputService.InputChanged
    inputBegan2, inputBegan = inputBegan2.Connect, inputBegan2
    inputBegan2(inputBegan, beginWindowDragging)
    return position2
end

function Handlers.animateNotificationIn(headTitle, countdown, closeButton, tweenService, uIStroke, notifyRef, bodyTitle, iconImage)
    local tweenService2, tweenInfo, tweenService3, temporary4, position, notify2
    notify2, tweenService3 = notifyRef.value, tweenService
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quint)
    temporary4 = {}
    position = UDim2.new(0.99, 0, 0.75, 0)
    temporary4.Size = position
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService3, notify2 = tweenService, uIStroke
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.Transparency = 0.5
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    notify2, tweenService3 = headTitle, tweenService
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.TextTransparency = 0
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    notify2, tweenService3 = bodyTitle, tweenService
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.TextTransparency = 0.3
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    notify2, tweenService3 = countdown, tweenService
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.BackgroundTransparency = 0
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    notify2, tweenService3 = iconImage, tweenService
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.ImageTransparency = 0
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    notify2, tweenService3 = closeButton, tweenService
    tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    temporary4 = {}
    temporary4.ImageTransparency = 0
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, notify2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    return
end

function Handlers.animateNotificationLifetime(animateNotificationOutRef, countdown, duration, tweenService)
    local result, tweenService2, new, position, tweenService3, countdown2
    task.wait(1.3)
    countdown2, tweenService3 = countdown, tweenService
    new = TweenInfo.new
    result = tonumber(duration) or 3
    new = new(result, Enum.EasingStyle.Linear)
    result = {}
    position = UDim2.new(1, 0, 0.1, 0)
    result.Size = position
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, countdown2, new, result)
    tweenService3:Play()
    tweenService3.Completed:Wait()
    task.wait(0.5)
    animateNotificationOutRef.value()
    return
end

function Handlers.animateNotificationOut(headTitle, countdown, closeButton, tweenService, uIStroke, notifyRef, bodyTitle, iconImage)
    local tweenService2, tweenInfo, position, destroyNotification, tweenService3, tweenService4
    tweenService2, tweenService4 = notifyRef.value, tweenService
    destroyNotification = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    tweenInfo = {}
    position = UDim2.new(0.75, 0, 0, 0)
    tweenInfo.Size = position
    tweenService4, tweenService3 = tweenService4.Create, tweenService4
    tweenService4 = tweenService4(tweenService3, tweenService2, destroyNotification, tweenInfo)
    tweenService3, destroyNotification = tweenService, uIStroke
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.Transparency = 1
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    destroyNotification, tweenService3 = headTitle, tweenService
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.TextTransparency = 1
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    tweenService3, destroyNotification = tweenService, bodyTitle
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.TextTransparency = 1
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService3, destroyNotification = tweenService, countdown
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.BackgroundTransparency = 1
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    tweenService3 = tweenService
    destroyNotification = iconImage
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.ImageTransparency = 1
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    destroyNotification, tweenService3 = closeButton, tweenService
    tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
    position = {}
    position.ImageTransparency = 1
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, destroyNotification, tweenInfo, position)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService4:Play()
    destroyNotification, tweenService3 = bind(Handlers.destroyNotification, notifyRef), tweenService4.Completed
    tweenService3, tweenService2 = tweenService3.Connect, tweenService3
    tweenService3(tweenService2, destroyNotification)
    return
end

function Handlers.animateToggleValue(theme, labelText, icon, tweenService, value, otherValue)
    local labelText2, tweenInfo, tweenService2, position, tweenService3, temporary6
    if value then
        labelText2, tweenService2 = labelText, tweenService
        tweenInfo = TweenInfo.new(otherValue)
        temporary6 = {}
        temporary6.TextTransparency = 0
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        labelText2 = icon
        tweenInfo = TweenInfo.new(otherValue)
        temporary6 = {}
        position = UDim2.new(0.75, 0, 0.5, 0)
        temporary6.Position = position
        temporary6.BackgroundColor3 = theme.Themes.MainColor
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    else
        tweenService2, labelText2 = tweenService, labelText
        tweenInfo = TweenInfo.new(otherValue)
        temporary6 = {}
        temporary6.TextTransparency = 0.3
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        labelText2 = icon
        tweenInfo = TweenInfo.new(otherValue)
        temporary6 = {}
        position = UDim2.new(0.25, 0, 0.5, 0)
        temporary6.Position = position
        position = Color3.fromRGB(194, 194, 194)
        temporary6.BackgroundColor3 = position
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    end
    return
end

function Handlers.applyPrimaryControlValue(control, controlValue)
    control:SetValue(controlValue)
    return
end

function Handlers.applySavedUiState(context)
    local applyCurveSelection, config2, config3, styleFloatingButton2, spamLabel2
    config3 = context.config
    context.speedDisplayRef.value.Visible = context.config.showStats
    context.fpsPanelRef.value.Visible = config3.showFpsUI
    context.spamPanel.Visible = config3.showSpamUI
    context.triggerPanel.Visible = config3.showTriggerUI
    context.immortalityPanel.Visible = config3.showImmortalUI
    if context.curveOptionsOpenRef.value then
        context.curveOptionsOpenRef.value.Visible = context.config.showCurveUI
    end
    if context.keybindPanelRef.value then
        context.keybindPanelRef.value.Visible = context.config.showBindWindow
    end
    styleFloatingButton2 = not context.config.showCurveUI and context.curvePanelOpenRef.value and context.curveOptionsPanelRef.value
    if styleFloatingButton2 then
        context.curveOptionsPanelRef.value.Visible = false
        context.curvePanelOpenRef.value = false
    end
    styleFloatingButton2 = not context.config.showBindWindow and context.keyCaptureActiveRef.value and context.keyOptionsPopupRef.value
    if styleFloatingButton2 then
        context.keyOptionsPopupRef.value.Visible = false
        context.keyCaptureActiveRef.value = false
        context.pendingKeybindRef.value = nil
    end
    spamLabel2, context.ballTargetedPlayerRef.value, config2, config3, styleFloatingButton2 = context.spamLabel, false, context.spamStroke, context.spamButtonRef.value, context.styleFloatingButtonRef.value
    styleFloatingButton2(false, config3, config2, spamLabel2)
    styleFloatingButton2(context.config.trigger, context.triggerButtonRef.value, context.triggerLabel, context.triggerStroke)
    styleFloatingButton2(context.config.immortality, context.immortalityButtonRef.value, context.immortalityLabel, context.immortalityStroke)
    pcall(context.setImmortalityHookRef.value, context.config.immortality)
    styleFloatingButton2, config2 = context.applyOptimizationRef.value, context.config
    context.applyOptimizationRef.value("unlimitedKBPS", context.config.optim.unlimitedKBPS)
    styleFloatingButton2("noRender", config2.optim.noRender)
    pcall(context.refreshKeybindPanelRef.value)
    applyCurveSelection = bind(Handlers.applyCurveSelection, context.config, context.selectedCurveRef, context.refreshCurvePanelRef)
    pcall(applyCurveSelection)
    return
end

function Handlers.applySecondaryControlValue(control, controlValue)
    control:SetValue(controlValue)
    return
end

function Handlers.beginDrag(userInputService, config, onPositionChanged, draggingRef, positionRef, positionRef2, positionRef3, input)
    local position2, saveFramePosition, userInputService2
    position2 = input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
    if position2 then
        draggingRef.value, position2 = true, input.Position
        userInputService2, positionRef2.value = userInputService, position2
        positionRef.value = userInputService2.Position
        positionRef3.value, position2, saveFramePosition = positionRef.value, input.Changed, bind(Handlers.saveFramePosition, config, draggingRef, userInputService, input, onPositionChanged)
        userInputService2, position2 = position2, position2.Connect
        position2(userInputService2, saveFramePosition)
    end
    return
end

function Handlers.beginDropdownDragging(frame, positionRef, positionRef2, draggingRef, input)
    local frame2, stopDropdownDragging, position2
    position2 = input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
    if position2 then
        draggingRef.value, position2 = true, input.Position
        positionRef.value, frame2 = position2, frame
        positionRef2.value = frame2.Position
        stopDropdownDragging, position2 = bind(Handlers.stopDropdownDragging, input, draggingRef), input.Changed
        frame2, position2 = position2, position2.Connect
        position2(frame2, stopDropdownDragging)
    end
    return
end

function Handlers.beginKeybindCapture(keybindPanelRef, keyCaptureActiveRef, refreshKeybindPanelRef, pendingKeybindRef, keyOptionsPopupRef, kind, name)
    local position, keyOptionsPopup2
    keyOptionsPopup2 = {}
    keyOptionsPopup2.kind = kind
    keyOptionsPopup2.name = name
    pendingKeybindRef.value = keyOptionsPopup2
    keyCaptureActiveRef.value = true
    keyOptionsPopupRef.value.Visible = true
    keyOptionsPopup2 = keyOptionsPopupRef.value
    position = UDim2.new(keybindPanelRef.value.Position.X.Scale, keybindPanelRef.value.Position.X.Offset + 228, keybindPanelRef.value.Position.Y.Scale, keybindPanelRef.value.Position.Y.Offset)
    keyOptionsPopup2.Position = position
    refreshKeybindPanelRef.value()
    return
end

function Handlers.beginSliderDragging(positionRef, draggingRef, frame, connectRef, positionRef2, input)
    local frame2, stopSliderDragging, position2
    position2 = (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not connectRef.value
    if position2 then
        draggingRef.value, position2 = true, input.Position
        positionRef2.value, frame2 = position2, frame
        positionRef.value = frame2.Position
        position2, stopSliderDragging = input.Changed, bind(Handlers.stopSliderDragging, input, draggingRef)
        frame2, position2 = position2, position2.Connect
        position2(frame2, stopSliderDragging)
    end
    return
end

function Handlers.beginWindowDragging(frame, tweenServiceRef, bindCanvasSizeRef, tweenServiceRef2, input)
    local frame2, position, stopWindowDragging
    position = input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
    if position then
        position, tweenServiceRef2.value = input.Position, true
        tweenServiceRef.value, frame2 = position, frame
        bindCanvasSizeRef.value = frame2.Position
        position, stopWindowDragging = input.Changed, bind(Handlers.stopWindowDragging, input, tweenServiceRef2)
        position, frame2 = position.Connect, position
        position(frame2, stopWindowDragging)
    end
    return
end

function Handlers.bindCanvasSize(tweenServiceRef)
    local uIListLayout, tweenService2, updateSectionCanvas, tweenService3
    uIListLayout = tweenServiceRef.value:WaitForChild("UIListLayout", 9999999)
    tweenService3 = tweenServiceRef.value
    tweenService2 = UDim2.new(0, 0, 0, uIListLayout.AbsoluteContentSize.Y + 45)
    tweenService3.CanvasSize = tweenService2
    tweenService3 = uIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")
    updateSectionCanvas, tweenService3, tweenService2 = bind(Handlers.updateSectionCanvas, tweenServiceRef, uIListLayout), tweenService3.Connect, tweenService3
    tweenService3(tweenService2, updateSectionCanvas)
    return
end

-- Build the floating curve selector.
function Handlers.buildCurveWindow(context)
    local uICorner, textLabel, frame, curveRows2, chooseCurveType, uICorner2, textButton
    local frame2, curveOptionsOpen2, curveOptionsOpen3, curveRows3, curveOptionsOpen4, temporary13Ref
    curveOptionsOpen3 = Instance.new("Frame", context.screenGuiRef.value)
    context.curveOptionsOpenRef.value = curveOptionsOpen3
    curveOptionsOpen3 = context.curveOptionsOpenRef.value
    curveOptionsOpen4 = UDim2.new(0, 150, 0, 45)
    curveOptionsOpen3.Size = curveOptionsOpen4
    curveOptionsOpen3.Position = context.defaultPositionsRef.value.CurveMainFrame
    curveOptionsOpen4 = Color3.fromRGB(20, 20, 20)
    curveOptionsOpen3.BackgroundColor3 = curveOptionsOpen4
    curveOptionsOpen3.BackgroundTransparency = 0.1
    curveOptionsOpen3 = Instance.new("UICorner", context.curveOptionsOpenRef.value)
    curveOptionsOpen4 = UDim.new(0, 10)
    curveOptionsOpen3.CornerRadius = curveOptionsOpen4
    curveOptionsOpen2 = context.curveOptionsOpenRef.value
    curveOptionsOpen3 = Instance.new("UIStroke", context.curveOptionsOpenRef.value)
    curveOptionsOpen3.Color = context.accentColorRef.value
    curveOptionsOpen2.Visible = false
    curveOptionsOpen3 = Instance.new("TextButton", curveOptionsOpen2)
    context.curveDropdownButtonRef.value = curveOptionsOpen3
    curveOptionsOpen3 = context.curveDropdownButtonRef.value
    curveOptionsOpen4 = UDim2.new(1, -10, 1, -10)
    curveOptionsOpen3.Size = curveOptionsOpen4
    curveOptionsOpen4 = UDim2.new(0, 5, 0, 5)
    curveOptionsOpen3.Position = curveOptionsOpen4
    curveOptionsOpen4 = Color3.fromRGB(30, 30, 30)
    curveOptionsOpen3.BackgroundColor3 = curveOptionsOpen4
    temporary13Ref = string.upper(context.selectedCurveRef.value)
    curveOptionsOpen3.Text = "CURVE: " .. temporary13Ref
    curveOptionsOpen3.TextColor3 = context.accentColorRef.value
    curveOptionsOpen3.Font = Enum.Font.GothamBold
    curveOptionsOpen3.TextSize = 13
    curveOptionsOpen3 = Instance.new("UICorner", context.curveDropdownButtonRef.value)
    curveOptionsOpen4 = UDim.new(0, 8)
    curveOptionsOpen3.CornerRadius = curveOptionsOpen4
    curveOptionsOpen3 = Instance.new("Frame", context.screenGuiRef.value)
    context.curveOptionsPanelRef.value = curveOptionsOpen3
    curveOptionsOpen3 = context.curveOptionsPanelRef.value
    curveOptionsOpen4 = UDim2.new(0, 150, 0, #context.curveOptions * 28 + 10)
    curveOptionsOpen3.Size = curveOptionsOpen4
    curveOptionsOpen4 = UDim2.new(0.5, -75, 0.35, 48)
    curveOptionsOpen3.Position = curveOptionsOpen4
    curveOptionsOpen4 = Color3.fromRGB(15, 15, 15)
    curveOptionsOpen3.BackgroundColor3 = curveOptionsOpen4
    curveOptionsOpen3.BackgroundTransparency = 0.05
    curveOptionsOpen3 = Instance.new("UICorner", context.curveOptionsPanelRef.value)
    curveOptionsOpen4 = UDim.new(0, 10)
    curveOptionsOpen3.CornerRadius = curveOptionsOpen4
    curveOptionsOpen2 = context.curveOptionsPanelRef.value
    curveOptionsOpen3 = Instance.new("UIStroke", context.curveOptionsPanelRef.value)
    curveOptionsOpen3.Color = context.accentColorRef.value
    curveOptionsOpen2.Visible = false
    curveOptionsOpen3 = 1
    curveOptionsOpen4 = #context.curveOptions
    if not (#context.curveOptions ~= #context.curveOptions) then
        if not (1 > #context.curveOptions) then
            while true do
                temporary13Ref = {value = context.curveOptions[curveOptionsOpen3]}
                textButton = Instance.new("TextButton", context.curveOptionsPanelRef.value)
                uICorner = UDim2.new(1, -10, 0, 26)
                textButton.Size = uICorner
                uICorner = UDim2.new(0, 5, 0, 5 + (curveOptionsOpen3 - 1) * 28)
                textButton.Position = uICorner
                uICorner = Color3.fromRGB(25, 25, 25)
                textButton.BackgroundColor3 = uICorner
                textButton.Text = ""
                textButton.AutoButtonColor = false
                textButton.Name = temporary13Ref.value
                uICorner = Instance.new("UICorner", textButton)
                frame2 = UDim.new(0, 5)
                uICorner.CornerRadius = frame2
                uICorner = Instance.new("UIStroke", textButton)
                uICorner.Color = context.accentColorRef.value
                uICorner.Transparency = 0.6
                uICorner.Thickness = 1
                frame2 = Instance.new("Frame", textButton)
                uICorner2 = UDim2.new(0, 8, 0, 8)
                frame2.Size = uICorner2
                uICorner2 = UDim2.new(0, 10, 0.5, -4)
                frame2.Position = uICorner2
                uICorner2 = Color3.fromRGB(0, 0, 0)
                frame2.BackgroundColor3 = uICorner2
                frame2.BorderSizePixel = 0
                uICorner2 = Instance.new("UICorner", frame2)
                textLabel = UDim.new(0, 2)
                uICorner2.CornerRadius = textLabel
                uICorner2 = Instance.new("UIStroke", frame2)
                uICorner2.Color = context.accentColorRef.value
                uICorner2.Transparency = 0.4
                uICorner2.Thickness = 1
                textLabel = Instance.new("TextLabel", textButton)
                frame = UDim2.new(1, -40, 1, 0)
                textLabel.Size = frame
                frame = UDim2.new(0, 24, 0, 0)
                textLabel.Position = frame
                textLabel.BackgroundTransparency = 1
                frame = string.upper(temporary13Ref.value)
                textLabel.Text = frame
                textLabel.TextColor3 = context.accentColorRef.value
                textLabel.Font = Enum.Font.GothamBold
                textLabel.TextSize = 11
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                frame = Instance.new("Frame", textButton)
                curveRows2 = UDim2.new(0, 6, 0, 6)
                frame.Size = curveRows2
                curveRows2 = UDim2.new(1, -14, 0.5, -3)
                frame.Position = curveRows2
                curveRows2 = Color3.fromRGB(70, 70, 70)
                frame.BackgroundColor3 = curveRows2
                frame.BorderSizePixel = 0
                curveRows2 = Instance.new("UICorner", frame)
                curveRows3 = UDim.new(0.5, 0)
                curveRows2.CornerRadius = curveRows3
                curveRows2 = context.curveRows
                chooseCurveType = {}
                chooseCurveType.label = textLabel
                chooseCurveType.stroke = uICorner
                chooseCurveType.iconStroke = uICorner2
                chooseCurveType.dot = frame
                curveRows2[temporary13Ref.value] = chooseCurveType
                curveRows2, chooseCurveType = textButton.MouseButton1Click, bind(Handlers.chooseCurveType, context.refreshCurvePanelRef, context.curveOptionsPanelRef, context.saveConfigRef, context.selectedCurveRef, context.config, temporary13Ref, context.curvePanelOpenRef)
                curveRows2, curveRows3 = curveRows2.Connect, curveRows2
                curveRows2(curveRows3, chooseCurveType)
                curveOptionsOpen3 = curveOptionsOpen3 + 1
                if curveOptionsOpen3 > curveOptionsOpen4 then
                    break
                else
                    continue
                end
            end
        end
    end
    context.refreshCurvePanelRef.value()
    curveOptionsOpen3, curveOptionsOpen2 = context.curveDropdownButtonRef.value.MouseButton1Click, bind(Handlers.toggleCurveWindow, context.refreshCurvePanelRef, context.curvePanelOpenRef, context.curveOptionsPanelRef, context.curveOptionsOpenRef)
    curveOptionsOpen3, curveOptionsOpen4 = curveOptionsOpen3.Connect, curveOptionsOpen3
    curveOptionsOpen3(curveOptionsOpen4, curveOptionsOpen2)
    curveOptionsOpen3, curveOptionsOpen4, curveOptionsOpen2 = context.makeDraggableRef.value, context.curveOptionsOpenRef.value, bind(Handlers.positionDropdown, context.curveOptionsPanelRef)
    curveOptionsOpen3(curveOptionsOpen4, curveOptionsOpen2, "CurveMainFrame")
    return
end

-- Build the keybinding editor and its per-action controls.
function Handlers.buildKeybindingWindow(context)
    local frame, uICornerRef, curveKeyRows2, textButton, keyOptionRows2, keybindPanel2, spamKeyButtonRef2
    local triggerKeyButtonRef2, positionKeybindPanelRef, clearSelectedKeybind, frame2, spamKeyButton2, curveDropdownButton2, textLabel
    local textLabel2, triggerKeyButtonRef3, curveDropdownButtonRef2, frame3, curveKeyRows3, fadeStrokeOut, keyOptionRows3
    local uICornerRef2, fadeTriggerStrokeIn, keyOptionsPopup2, keybindPanel3, fadeKeybindStrokeIn, textButton2, keybindPanel4
    keybindPanel4 = Instance.new("Frame", context.screenGuiRef.value)
    context.keybindPanelRef.value = keybindPanel4
    keybindPanel4 = context.keybindPanelRef.value
    frame = UDim2.new(0, 220, 0, 162)
    keybindPanel4.Size = frame
    keybindPanel4.Position = context.defaultPositionsRef.value.KeybindMainFrame
    frame = Color3.fromRGB(20, 20, 20)
    keybindPanel4.BackgroundColor3 = frame
    keybindPanel4.BackgroundTransparency = 0.1
    keybindPanel4 = Instance.new("UICorner", context.keybindPanelRef.value)
    frame = UDim.new(0, 10)
    keybindPanel4.CornerRadius = frame
    keybindPanel3 = context.keybindPanelRef.value
    keybindPanel4 = Instance.new("UIStroke", context.keybindPanelRef.value)
    keybindPanel4.Color = context.accentColorRef.value
    keybindPanel3.ClipsDescendants = true
    keybindPanel3.Visible = false
    keybindPanel4 = Instance.new("TextLabel", keybindPanel3)
    frame = UDim2.new(1, -16, 0, 24)
    keybindPanel4.Size = frame
    frame = UDim2.new(0, 8, 0, 6)
    keybindPanel4.Position = frame
    keybindPanel4.BackgroundTransparency = 1
    keybindPanel4.Text = "KEY BINDINGS"
    keybindPanel4.TextColor3 = context.accentColorRef.value
    keybindPanel4.Font = Enum.Font.GothamBold
    keybindPanel4.TextSize = 13
    keybindPanel4.TextXAlignment = Enum.TextXAlignment.Center
    frame = Instance.new("Frame", context.keybindPanelRef.value)
    keybindPanel3 = UDim2.new(1, -16, 0, 36)
    frame.Size = keybindPanel3
    keybindPanel3 = UDim2.new(0, 8, 0, 34)
    frame.Position = keybindPanel3
    keybindPanel3 = Color3.fromRGB(28, 28, 28)
    frame.BackgroundColor3 = keybindPanel3
    frame.BorderSizePixel = 0
    keybindPanel3 = Instance.new("UICorner", frame)
    textLabel2 = UDim.new(0, 6)
    keybindPanel3.CornerRadius = textLabel2
    keybindPanel3 = Instance.new("UIStroke", frame)
    keybindPanel3.Color = context.accentColorRef.value
    keybindPanel3.Transparency = 0.6
    keybindPanel3.Thickness = 1
    textLabel2 = Instance.new("TextLabel", frame)
    spamKeyButtonRef2 = UDim2.new(0.5, -8, 1, 0)
    textLabel2.Size = spamKeyButtonRef2
    spamKeyButtonRef2 = UDim2.new(0, 14, 0, 0)
    textLabel2.Position = spamKeyButtonRef2
    textLabel2.BackgroundTransparency = 1
    textLabel2.Text = "SPAM"
    textLabel2.TextColor3 = context.accentColorRef.value
    textLabel2.Font = Enum.Font.GothamBold
    textLabel2.TextSize = 12
    textLabel2.TextXAlignment = Enum.TextXAlignment.Left
    spamKeyButtonRef2 = Instance.new("TextButton", frame)
    context.spamKeyButtonRef.value = spamKeyButtonRef2
    spamKeyButtonRef2 = context.spamKeyButtonRef.value
    frame2 = UDim2.new(0.5, -14, 1, -8)
    spamKeyButtonRef2.Size = frame2
    frame2 = UDim2.new(0.5, 0, 0, 4)
    spamKeyButtonRef2.Position = frame2
    frame2 = Color3.fromRGB(40, 40, 40)
    spamKeyButtonRef2.BackgroundColor3 = frame2
    fadeKeybindStrokeIn = context.keybinds.spam ~= nil and context.keybinds.spam ~= context.selectedKey
    frame2 = fadeKeybindStrokeIn and context.keybinds.spam.Name or "NONE"
    spamKeyButtonRef2.Text = frame2
    fadeKeybindStrokeIn = context.keybinds.spam ~= nil and context.keybinds.spam ~= context.selectedKey
    frame2 = fadeKeybindStrokeIn and context.textColor or context.mutedTextColor
    context.spamKeyButtonRef.value.TextColor3 = frame2
    spamKeyButtonRef2 = context.spamKeyButtonRef.value
    context.spamKeyButtonRef.value.Font = Enum.Font.GothamBold
    spamKeyButtonRef2.TextSize = 11
    spamKeyButtonRef2.AutoButtonColor = false
    spamKeyButtonRef2 = Instance.new("UICorner", context.spamKeyButtonRef.value)
    frame2 = UDim.new(0, 5)
    spamKeyButtonRef2.CornerRadius = frame2
    spamKeyButton2 = context.spamKeyButtonRef.value
    spamKeyButtonRef2 = Instance.new("UIStroke", context.spamKeyButtonRef.value)
    spamKeyButtonRef2 = {value = spamKeyButtonRef2}
    spamKeyButtonRef2.value.Color = context.accentColorRef.value
    spamKeyButtonRef2.value.Transparency = 0.3
    spamKeyButtonRef2.value.Thickness = 1
    fadeKeybindStrokeIn, frame2 = bind(Handlers.fadeKeybindStrokeIn, context.tweenService, spamKeyButtonRef2), spamKeyButton2.MouseEnter
    spamKeyButton2, frame2 = frame2, frame2.Connect
    frame2(spamKeyButton2, fadeKeybindStrokeIn)
    frame2, fadeKeybindStrokeIn = context.spamKeyButtonRef.value.MouseLeave, bind(Handlers.fadeSpamStrokeOut, context.tweenService, spamKeyButtonRef2)
    frame2, spamKeyButton2 = frame2.Connect, frame2
    frame2(spamKeyButton2, fadeKeybindStrokeIn)
    fadeKeybindStrokeIn, frame2 = bind(Handlers.beginSpamKeyCapture, context.beginKeyCaptureRef), context.spamKeyButtonRef.value.MouseButton1Click
    spamKeyButton2, frame2 = frame2, frame2.Connect
    frame2(spamKeyButton2, fadeKeybindStrokeIn)
    frame2 = Instance.new("Frame", context.keybindPanelRef.value)
    spamKeyButton2 = UDim2.new(1, -16, 0, 36)
    frame2.Size = spamKeyButton2
    spamKeyButton2 = UDim2.new(0, 8, 0, 74)
    frame2.Position = spamKeyButton2
    spamKeyButton2 = Color3.fromRGB(28, 28, 28)
    frame2.BackgroundColor3 = spamKeyButton2
    frame2.BorderSizePixel = 0
    spamKeyButton2 = Instance.new("UICorner", frame2)
    fadeKeybindStrokeIn = UDim.new(0, 6)
    spamKeyButton2.CornerRadius = fadeKeybindStrokeIn
    spamKeyButton2 = Instance.new("UIStroke", frame2)
    spamKeyButton2.Color = context.accentColorRef.value
    spamKeyButton2.Transparency = 0.6
    spamKeyButton2.Thickness = 1
    fadeKeybindStrokeIn = Instance.new("TextLabel", frame2)
    triggerKeyButtonRef2 = UDim2.new(0.5, -8, 1, 0)
    fadeKeybindStrokeIn.Size = triggerKeyButtonRef2
    triggerKeyButtonRef2 = UDim2.new(0, 14, 0, 0)
    fadeKeybindStrokeIn.Position = triggerKeyButtonRef2
    fadeKeybindStrokeIn.BackgroundTransparency = 1
    fadeKeybindStrokeIn.Text = "TRIGGER"
    fadeKeybindStrokeIn.TextColor3 = context.accentColorRef.value
    fadeKeybindStrokeIn.Font = Enum.Font.GothamBold
    fadeKeybindStrokeIn.TextSize = 12
    fadeKeybindStrokeIn.TextXAlignment = Enum.TextXAlignment.Left
    triggerKeyButtonRef2 = Instance.new("TextButton", frame2)
    context.triggerKeyButtonRef.value = triggerKeyButtonRef2
    triggerKeyButtonRef2 = context.triggerKeyButtonRef.value
    textButton = UDim2.new(0.5, -14, 1, -8)
    triggerKeyButtonRef2.Size = textButton
    textButton = UDim2.new(0.5, 0, 0, 4)
    triggerKeyButtonRef2.Position = textButton
    textButton = Color3.fromRGB(40, 40, 40)
    triggerKeyButtonRef2.BackgroundColor3 = textButton
    fadeTriggerStrokeIn = context.keybinds.trigger ~= nil and context.keybinds.trigger ~= context.selectedKey
    textButton = fadeTriggerStrokeIn and context.keybinds.trigger.Name
    if textButton then
        triggerKeyButtonRef2.Text = textButton
        fadeTriggerStrokeIn = context.keybinds.trigger ~= nil and context.keybinds.trigger ~= context.selectedKey
        textButton = fadeTriggerStrokeIn and context.textColor or context.mutedTextColor
        context.triggerKeyButtonRef.value.TextColor3 = textButton
        triggerKeyButtonRef2 = context.triggerKeyButtonRef.value
        context.triggerKeyButtonRef.value.Font = Enum.Font.GothamBold
        triggerKeyButtonRef2.TextSize = 11
        triggerKeyButtonRef2.AutoButtonColor = false
        triggerKeyButtonRef2 = Instance.new("UICorner", context.triggerKeyButtonRef.value)
        textButton = UDim.new(0, 5)
        triggerKeyButtonRef2.CornerRadius = textButton
        triggerKeyButtonRef3 = context.triggerKeyButtonRef.value
        triggerKeyButtonRef2 = Instance.new("UIStroke", context.triggerKeyButtonRef.value)
        triggerKeyButtonRef2 = {value = triggerKeyButtonRef2}
        triggerKeyButtonRef2.value.Color = context.accentColorRef.value
        triggerKeyButtonRef2.value.Transparency = 0.3
        triggerKeyButtonRef2.value.Thickness = 1
        fadeTriggerStrokeIn, textButton = bind(Handlers.fadeTriggerStrokeIn, context.tweenService, triggerKeyButtonRef2), triggerKeyButtonRef3.MouseEnter
        triggerKeyButtonRef3, textButton = textButton, textButton.Connect
        textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
        textButton, fadeTriggerStrokeIn = context.triggerKeyButtonRef.value.MouseLeave, bind(Handlers.fadeStrokeIn, context.tweenService, triggerKeyButtonRef2)
        textButton, triggerKeyButtonRef3 = textButton.Connect, textButton
        textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
        fadeTriggerStrokeIn, textButton = bind(Handlers.beginTriggerKeyCapture, context.beginKeyCaptureRef), context.triggerKeyButtonRef.value.MouseButton1Click
        triggerKeyButtonRef3, textButton = textButton, textButton.Connect
        textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
        textButton = Instance.new("TextButton", context.keybindPanelRef.value)
        triggerKeyButtonRef3 = UDim2.new(1, -16, 0, 36)
        textButton.Size = triggerKeyButtonRef3
        triggerKeyButtonRef3 = UDim2.new(0, 8, 0, 114)
        textButton.Position = triggerKeyButtonRef3
        triggerKeyButtonRef3 = Color3.fromRGB(28, 28, 28)
        textButton.BackgroundColor3 = triggerKeyButtonRef3
        textButton.BorderSizePixel = 0
        textButton.Text = ""
        textButton.AutoButtonColor = false
        triggerKeyButtonRef3 = Instance.new("UICorner", textButton)
        fadeTriggerStrokeIn = UDim.new(0, 6)
        triggerKeyButtonRef3.CornerRadius = fadeTriggerStrokeIn
        triggerKeyButtonRef3 = Instance.new("UIStroke", textButton)
        triggerKeyButtonRef3 = {value = triggerKeyButtonRef3}
        triggerKeyButtonRef3.value.Color = context.accentColorRef.value
        triggerKeyButtonRef3.value.Transparency = 0.6
        triggerKeyButtonRef3.value.Thickness = 1
        fadeTriggerStrokeIn = Instance.new("TextLabel", textButton)
        curveDropdownButtonRef2 = UDim2.new(1, -50, 1, 0)
        fadeTriggerStrokeIn.Size = curveDropdownButtonRef2
        curveDropdownButtonRef2 = UDim2.new(0, 14, 0, 0)
        fadeTriggerStrokeIn.Position = curveDropdownButtonRef2
        fadeTriggerStrokeIn.BackgroundTransparency = 1
        fadeTriggerStrokeIn.Text = "CURVE"
        fadeTriggerStrokeIn.TextColor3 = context.accentColorRef.value
        fadeTriggerStrokeIn.Font = Enum.Font.GothamBold
        fadeTriggerStrokeIn.TextSize = 12
        fadeTriggerStrokeIn.TextXAlignment = Enum.TextXAlignment.Left
        curveDropdownButtonRef2 = Instance.new("TextLabel", textButton)
        context.curveDropdownButtonRef.value = curveDropdownButtonRef2
        curveDropdownButtonRef2 = context.curveDropdownButtonRef.value
        curveDropdownButton2 = UDim2.new(0, 30, 1, 0)
        curveDropdownButtonRef2.Size = curveDropdownButton2
        curveDropdownButton2 = UDim2.new(1, -34, 0, 0)
        curveDropdownButtonRef2.Position = curveDropdownButton2
        curveDropdownButtonRef2.BackgroundTransparency = 1
        curveDropdownButtonRef2.Text = "\226\150\182"
        curveDropdownButtonRef2.TextColor3 = context.accentColorRef.value
        curveDropdownButtonRef2.Font = Enum.Font.GothamBold
        curveDropdownButtonRef2.TextSize = 12
        curveDropdownButtonRef2.TextXAlignment = Enum.TextXAlignment.Center
        keyOptionsPopup2, curveDropdownButtonRef2 = bind(Handlers.fadeKeybindStrokeOut, context.tweenService, triggerKeyButtonRef3), textButton.MouseEnter
        curveDropdownButtonRef2, curveDropdownButton2 = curveDropdownButtonRef2.Connect, curveDropdownButtonRef2
        curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
        curveDropdownButtonRef2, keyOptionsPopup2 = textButton.MouseLeave, bind(Handlers.fadeStrokeOutOnHover, context.tweenService, triggerKeyButtonRef3)
        curveDropdownButton2, curveDropdownButtonRef2 = curveDropdownButtonRef2, curveDropdownButtonRef2.Connect
        curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
        curveDropdownButtonRef2 = Instance.new("Frame", context.keybindPanelRef.value)
        context.curveOptionsPanelRef.value = curveDropdownButtonRef2
        curveDropdownButtonRef2 = context.curveOptionsPanelRef.value
        curveDropdownButton2 = UDim2.new(1, 0, 0, #context.curveOptions * 38)
        curveDropdownButtonRef2.Size = curveDropdownButton2
        curveDropdownButton2 = UDim2.new(0, 0, 0, 158)
        curveDropdownButtonRef2.Position = curveDropdownButton2
        curveDropdownButtonRef2.BackgroundTransparency = 1
        curveDropdownButtonRef2.Visible = false
        curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 = ipairs(context.curveOptions)
        curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 = normalizeIterator(curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2)
        for index, item in curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 do
            keybindPanel2, positionKeybindPanelRef, keyOptionsPopup2 = index, item, index
            positionKeybindPanelRef = {value = positionKeybindPanelRef}
            frame3 = Instance.new("Frame", context.curveOptionsPanelRef.value)
            uICornerRef = UDim2.new(1, -16, 0, 34)
            frame3.Size = uICornerRef
            uICornerRef = UDim2.new(0, 8, 0, (keybindPanel2 - 1) * 38)
            frame3.Position = uICornerRef
            uICornerRef = Color3.fromRGB(25, 25, 25)
            frame3.BackgroundColor3 = uICornerRef
            frame3.BorderSizePixel = 0
            uICornerRef = Instance.new("UICorner", frame3)
            textLabel = UDim.new(0, 6)
            uICornerRef.CornerRadius = textLabel
            uICornerRef = Instance.new("UIStroke", frame3)
            uICornerRef.Color = context.accentColorRef.value
            uICornerRef.Transparency = 0.6
            uICornerRef.Thickness = 1
            textLabel = Instance.new("TextLabel", frame3)
            textButton2 = UDim2.new(0.5, -8, 1, 0)
            textLabel.Size = textButton2
            textButton2 = UDim2.new(0, 20, 0, 0)
            textLabel.Position = textButton2
            textLabel.BackgroundTransparency = 1
            textButton2 = string.upper(positionKeybindPanelRef.value)
            textLabel.Text = textButton2
            textLabel.TextColor3 = context.accentColorRef.value
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 11
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textButton2 = Instance.new("TextButton", frame3)
            uICornerRef2 = UDim2.new(0.5, -22, 1, -8)
            textButton2.Size = uICornerRef2
            uICornerRef2 = UDim2.new(0.5, 2, 0, 4)
            textButton2.Position = uICornerRef2
            uICornerRef2 = Color3.fromRGB(40, 40, 40)
            textButton2.BackgroundColor3 = uICornerRef2
            textButton2.Text = "NONE"
            textButton2.TextColor3 = context.mutedTextColor
            textButton2.Font = Enum.Font.GothamBold
            textButton2.TextSize = 10
            textButton2.AutoButtonColor = false
            uICornerRef2 = Instance.new("UICorner", textButton2)
            curveKeyRows3 = UDim.new(0, 5)
            uICornerRef2.CornerRadius = curveKeyRows3
            uICornerRef2 = Instance.new("UIStroke", textButton2)
            uICornerRef2 = {value = uICornerRef2}
            uICornerRef2.value.Color = context.accentColorRef.value
            uICornerRef2.value.Transparency = 0.3
            uICornerRef2.value.Thickness = 1
            fadeStrokeOut, curveKeyRows3 = bind(Handlers.fadeStrokeOut, context.tweenService, uICornerRef2), textButton2.MouseEnter
            curveKeyRows2, curveKeyRows3 = curveKeyRows3, curveKeyRows3.Connect
            curveKeyRows3(curveKeyRows2, fadeStrokeOut)
            curveKeyRows3, fadeStrokeOut = textButton2.MouseLeave, bind(Handlers.fadeButtonStrokeOut, context.tweenService, uICornerRef2)
            curveKeyRows3, curveKeyRows2 = curveKeyRows3.Connect, curveKeyRows3
            curveKeyRows3(curveKeyRows2, fadeStrokeOut)
            curveKeyRows3, fadeStrokeOut = textButton2.MouseButton1Click, bind(Handlers.beginCurveKeyCapture, context.beginKeyCaptureRef, positionKeybindPanelRef)
            curveKeyRows3, curveKeyRows2 = curveKeyRows3.Connect, curveKeyRows3
            curveKeyRows3(curveKeyRows2, fadeStrokeOut)
            fadeStrokeOut, curveKeyRows3 = {}, context.curveKeyRowsRef.value
            fadeStrokeOut.keyBtn = textButton2
            fadeStrokeOut.rowStroke = uICornerRef
            fadeStrokeOut.row = frame3
            curveKeyRows3[positionKeybindPanelRef.value] = fadeStrokeOut
        end
        keybindPanel2, positionKeybindPanelRef, keyOptionsPopup2 = nil, nil, nil
        keyOptionsPopup2, curveDropdownButtonRef2 = bind(Handlers.toggleKeybindPanel, context.tweenService, context.refreshKeybindPanelRef, context.keybindPanelRef, context.keybindPanelOpenRef, context.curveOptions, context.curveOptionsPanelRef), textButton.MouseButton1Click
        curveDropdownButtonRef2, curveDropdownButton2 = curveDropdownButtonRef2.Connect, curveDropdownButtonRef2
        curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
        curveDropdownButtonRef2 = Instance.new("ScrollingFrame", context.screenGuiRef.value)
        context.keyOptionsPopupRef.value = curveDropdownButtonRef2
        curveDropdownButtonRef2 = context.keyOptionsPopupRef.value
        curveDropdownButton2 = UDim2.new(0, 160, 0, 320)
        curveDropdownButtonRef2.Size = curveDropdownButton2
        curveDropdownButton2 = UDim2.new(0.5, 100, 0.45, 0)
        curveDropdownButtonRef2.Position = curveDropdownButton2
        curveDropdownButton2 = Color3.fromRGB(15, 15, 15)
        curveDropdownButtonRef2.BackgroundColor3 = curveDropdownButton2
        curveDropdownButtonRef2.BackgroundTransparency = 0.05
        curveDropdownButtonRef2.BorderSizePixel = 0
        curveDropdownButton2 = UDim2.new(0, 0, 0, 0)
        curveDropdownButtonRef2.CanvasSize = curveDropdownButton2
        curveDropdownButtonRef2.ScrollBarThickness = 3
        curveDropdownButtonRef2.ScrollBarImageColor3 = context.accentColorRef.value
        curveDropdownButtonRef2 = Instance.new("UICorner", context.keyOptionsPopupRef.value)
        curveDropdownButton2 = UDim.new(0, 10)
        curveDropdownButtonRef2.CornerRadius = curveDropdownButton2
        keyOptionsPopup2 = context.keyOptionsPopupRef.value
        curveDropdownButtonRef2 = Instance.new("UIStroke", context.keyOptionsPopupRef.value)
        curveDropdownButtonRef2.Color = context.accentColorRef.value
        keyOptionsPopup2.Visible = false
        curveDropdownButtonRef2 = Instance.new("UIListLayout", keyOptionsPopup2)
        curveDropdownButtonRef2 = {value = curveDropdownButtonRef2}
        curveDropdownButton2 = UDim.new(0, 2)
        curveDropdownButtonRef2.value.Padding = curveDropdownButton2
        curveDropdownButtonRef2.value.SortOrder = Enum.SortOrder.LayoutOrder
        curveDropdownButtonRef2.value.HorizontalAlignment = Enum.HorizontalAlignment.Center
        keyOptionsPopup2 = {}
        keyOptionsPopup2[14], keyOptionsPopup2[2], keyOptionsPopup2[10], keyOptionsPopup2[13], keyOptionsPopup2[11], keyOptionsPopup2[4], keyOptionsPopup2[6], keyOptionsPopup2[9], keyOptionsPopup2[1], keyOptionsPopup2[7], keyOptionsPopup2[12], keyOptionsPopup2[5], keyOptionsPopup2[3], keyOptionsPopup2[8], keyOptionsPopup2[16], keyOptionsPopup2[15] = "M", "A", "I", "L", "J", "C", "E", "H", "NONE", "F", "K", "D", "B", "G", "O", "N"
        keyOptionsPopup2[23], keyOptionsPopup2[24], keyOptionsPopup2[20], keyOptionsPopup2[27], keyOptionsPopup2[31], keyOptionsPopup2[25], keyOptionsPopup2[17], keyOptionsPopup2[26], keyOptionsPopup2[19], keyOptionsPopup2[21], keyOptionsPopup2[22], keyOptionsPopup2[30], keyOptionsPopup2[18], keyOptionsPopup2[28], keyOptionsPopup2[29], keyOptionsPopup2[32] = "V", "W", "S", "Z", "LeftControl", "X", "P", "Y", "R", "T", "U", "RightShift", "Q", "Space", "LeftShift", "RightControl"
        keyOptionsPopup2[43], keyOptionsPopup2[37], keyOptionsPopup2[47], keyOptionsPopup2[45], keyOptionsPopup2[44], keyOptionsPopup2[42], keyOptionsPopup2[34], keyOptionsPopup2[40], keyOptionsPopup2[38], keyOptionsPopup2[33], keyOptionsPopup2[39], keyOptionsPopup2[35], keyOptionsPopup2[48], keyOptionsPopup2[46], keyOptionsPopup2[41], keyOptionsPopup2[36] = "F6", "Escape", "F10", "F8", "F7", "F5", "RightAlt", "F3", "F1", "LeftAlt", "F2", "Tab", "F11", "F9", "F4", "CapsLock"
        keyOptionsPopup2[49] = "F12"
        keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef = ipairs(keyOptionsPopup2)
        keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef = normalizeIterator(keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef)
        for index2, item2 in keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef do
            frame3, uICornerRef, positionKeybindPanelRef = index2, item2, index2
            uICornerRef = {value = uICornerRef}
            textLabel = Instance.new("TextButton", context.keyOptionsPopupRef.value)
            textButton2 = UDim2.new(1, -8, 0, 26)
            textLabel.Size = textButton2
            textLabel.LayoutOrder = frame3
            textButton2 = Color3.fromRGB(25, 25, 25)
            textLabel.BackgroundColor3 = textButton2
            textLabel.Text = ""
            textLabel.AutoButtonColor = false
            textLabel.Name = uICornerRef.value
            textButton2 = Instance.new("UICorner", textLabel)
            uICornerRef2 = UDim.new(0, 5)
            textButton2.CornerRadius = uICornerRef2
            textButton2 = Instance.new("UIStroke", textLabel)
            textButton2.Color = context.accentColorRef.value
            textButton2.Transparency = 0.6
            textButton2.Thickness = 1
            uICornerRef2 = Instance.new("Frame", textLabel)
            curveKeyRows3 = UDim2.new(0, 8, 0, 8)
            uICornerRef2.Size = curveKeyRows3
            curveKeyRows3 = UDim2.new(0, 10, 0.5, -4)
            uICornerRef2.Position = curveKeyRows3
            curveKeyRows3 = Color3.fromRGB(0, 0, 0)
            uICornerRef2.BackgroundColor3 = curveKeyRows3
            uICornerRef2.BorderSizePixel = 0
            curveKeyRows3 = Instance.new("UICorner", uICornerRef2)
            curveKeyRows2 = UDim.new(0, 2)
            curveKeyRows3.CornerRadius = curveKeyRows2
            curveKeyRows3 = Instance.new("UIStroke", uICornerRef2)
            curveKeyRows3.Color = context.accentColorRef.value
            curveKeyRows3.Transparency = 0.4
            curveKeyRows3.Thickness = 1
            curveKeyRows2 = Instance.new("TextLabel", textLabel)
            fadeStrokeOut = UDim2.new(1, -40, 1, 0)
            curveKeyRows2.Size = fadeStrokeOut
            fadeStrokeOut = UDim2.new(0, 24, 0, 0)
            curveKeyRows2.Position = fadeStrokeOut
            curveKeyRows2.BackgroundTransparency = 1
            curveKeyRows2.Text = uICornerRef.value
            fadeStrokeOut = uICornerRef.value == "NONE" and context.mutedTextColor or context.accentColorRef.value
            curveKeyRows2.TextColor3 = fadeStrokeOut
            curveKeyRows2.Font = Enum.Font.GothamBold
            curveKeyRows2.TextSize = 11
            curveKeyRows2.TextXAlignment = Enum.TextXAlignment.Left
            fadeStrokeOut = Instance.new("Frame", textLabel)
            keyOptionRows3 = UDim2.new(0, 6, 0, 6)
            fadeStrokeOut.Size = keyOptionRows3
            keyOptionRows3 = UDim2.new(1, -14, 0.5, -3)
            fadeStrokeOut.Position = keyOptionRows3
            keyOptionRows3 = Color3.fromRGB(70, 70, 70)
            fadeStrokeOut.BackgroundColor3 = keyOptionRows3
            fadeStrokeOut.BorderSizePixel = 0
            keyOptionRows3 = Instance.new("UICorner", fadeStrokeOut)
            keyOptionRows2 = UDim.new(0.5, 0)
            keyOptionRows3.CornerRadius = keyOptionRows2
            keyOptionRows3, clearSelectedKeybind = context.keyOptionRowsRef.value, {}
            clearSelectedKeybind.label = curveKeyRows2
            clearSelectedKeybind.stroke = textButton2
            clearSelectedKeybind.iconStroke = curveKeyRows3
            clearSelectedKeybind.dot = fadeStrokeOut
            keyOptionRows3[uICornerRef.value] = clearSelectedKeybind
            keyOptionRows3, clearSelectedKeybind = textLabel.MouseButton1Click, bind(Handlers.clearSelectedKeybind, context.keybinds, context.keyCaptureActiveRef, context.refreshKeybindPanelRef, context.pendingKeybindRef, context.selectedKey, uICornerRef, context.saveKeybindsRef, context.keyOptionsPopupRef)
            keyOptionRows3, keyOptionRows2 = keyOptionRows3.Connect, keyOptionRows3
            keyOptionRows3(keyOptionRows2, clearSelectedKeybind)
        end
        frame3, uICornerRef, positionKeybindPanelRef = nil, nil, nil
        keyOptionsPopup2, keybindPanel2 = task.defer, bind(Handlers.updateDropdownCanvas, context.keyOptionsPopupRef, curveDropdownButtonRef2)
        keyOptionsPopup2(keybindPanel2)
        context.refreshKeybindPanelRef.value()
        keybindPanel2, keyOptionsPopup2, positionKeybindPanelRef = context.keybindPanelRef.value, context.makeDraggableRef.value, bind(Handlers.positionKeybindPanel, context.keyOptionsPopupRef, context.keyCaptureActiveRef)
        keyOptionsPopup2(keybindPanel2, positionKeybindPanelRef, "KeybindMainFrame")
        return
    end
    triggerKeyButtonRef2.Text = "NONE"
    fadeTriggerStrokeIn = context.keybinds.trigger ~= nil and context.keybinds.trigger ~= context.selectedKey
    textButton = fadeTriggerStrokeIn and context.textColor or context.mutedTextColor
    context.triggerKeyButtonRef.value.TextColor3 = textButton
    triggerKeyButtonRef2 = context.triggerKeyButtonRef.value
    context.triggerKeyButtonRef.value.Font = Enum.Font.GothamBold
    triggerKeyButtonRef2.TextSize = 11
    triggerKeyButtonRef2.AutoButtonColor = false
    triggerKeyButtonRef2 = Instance.new("UICorner", context.triggerKeyButtonRef.value)
    textButton = UDim.new(0, 5)
    triggerKeyButtonRef2.CornerRadius = textButton
    triggerKeyButtonRef3 = context.triggerKeyButtonRef.value
    triggerKeyButtonRef2 = Instance.new("UIStroke", context.triggerKeyButtonRef.value)
    triggerKeyButtonRef2 = {value = triggerKeyButtonRef2}
    triggerKeyButtonRef2.value.Color = context.accentColorRef.value
    triggerKeyButtonRef2.value.Transparency = 0.3
    triggerKeyButtonRef2.value.Thickness = 1
    fadeTriggerStrokeIn, textButton = bind(Handlers.fadeTriggerStrokeIn, context.tweenService, triggerKeyButtonRef2), triggerKeyButtonRef3.MouseEnter
    triggerKeyButtonRef3, textButton = textButton, textButton.Connect
    textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
    textButton, fadeTriggerStrokeIn = context.triggerKeyButtonRef.value.MouseLeave, bind(Handlers.fadeStrokeIn, context.tweenService, triggerKeyButtonRef2)
    textButton, triggerKeyButtonRef3 = textButton.Connect, textButton
    textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
    fadeTriggerStrokeIn, textButton = bind(Handlers.beginTriggerKeyCapture, context.beginKeyCaptureRef), context.triggerKeyButtonRef.value.MouseButton1Click
    triggerKeyButtonRef3, textButton = textButton, textButton.Connect
    textButton(triggerKeyButtonRef3, fadeTriggerStrokeIn)
    textButton = Instance.new("TextButton", context.keybindPanelRef.value)
    triggerKeyButtonRef3 = UDim2.new(1, -16, 0, 36)
    textButton.Size = triggerKeyButtonRef3
    triggerKeyButtonRef3 = UDim2.new(0, 8, 0, 114)
    textButton.Position = triggerKeyButtonRef3
    triggerKeyButtonRef3 = Color3.fromRGB(28, 28, 28)
    textButton.BackgroundColor3 = triggerKeyButtonRef3
    textButton.BorderSizePixel = 0
    textButton.Text = ""
    textButton.AutoButtonColor = false
    triggerKeyButtonRef3 = Instance.new("UICorner", textButton)
    fadeTriggerStrokeIn = UDim.new(0, 6)
    triggerKeyButtonRef3.CornerRadius = fadeTriggerStrokeIn
    triggerKeyButtonRef3 = Instance.new("UIStroke", textButton)
    triggerKeyButtonRef3 = {value = triggerKeyButtonRef3}
    triggerKeyButtonRef3.value.Color = context.accentColorRef.value
    triggerKeyButtonRef3.value.Transparency = 0.6
    triggerKeyButtonRef3.value.Thickness = 1
    fadeTriggerStrokeIn = Instance.new("TextLabel", textButton)
    curveDropdownButtonRef2 = UDim2.new(1, -50, 1, 0)
    fadeTriggerStrokeIn.Size = curveDropdownButtonRef2
    curveDropdownButtonRef2 = UDim2.new(0, 14, 0, 0)
    fadeTriggerStrokeIn.Position = curveDropdownButtonRef2
    fadeTriggerStrokeIn.BackgroundTransparency = 1
    fadeTriggerStrokeIn.Text = "CURVE"
    fadeTriggerStrokeIn.TextColor3 = context.accentColorRef.value
    fadeTriggerStrokeIn.Font = Enum.Font.GothamBold
    fadeTriggerStrokeIn.TextSize = 12
    fadeTriggerStrokeIn.TextXAlignment = Enum.TextXAlignment.Left
    curveDropdownButtonRef2 = Instance.new("TextLabel", textButton)
    context.curveDropdownButtonRef.value = curveDropdownButtonRef2
    curveDropdownButtonRef2 = context.curveDropdownButtonRef.value
    curveDropdownButton2 = UDim2.new(0, 30, 1, 0)
    curveDropdownButtonRef2.Size = curveDropdownButton2
    curveDropdownButton2 = UDim2.new(1, -34, 0, 0)
    curveDropdownButtonRef2.Position = curveDropdownButton2
    curveDropdownButtonRef2.BackgroundTransparency = 1
    curveDropdownButtonRef2.Text = "\226\150\182"
    curveDropdownButtonRef2.TextColor3 = context.accentColorRef.value
    curveDropdownButtonRef2.Font = Enum.Font.GothamBold
    curveDropdownButtonRef2.TextSize = 12
    curveDropdownButtonRef2.TextXAlignment = Enum.TextXAlignment.Center
    keyOptionsPopup2, curveDropdownButtonRef2 = bind(Handlers.fadeKeybindStrokeOut, context.tweenService, triggerKeyButtonRef3), textButton.MouseEnter
    curveDropdownButtonRef2, curveDropdownButton2 = curveDropdownButtonRef2.Connect, curveDropdownButtonRef2
    curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
    curveDropdownButtonRef2, keyOptionsPopup2 = textButton.MouseLeave, bind(Handlers.fadeStrokeOutOnHover, context.tweenService, triggerKeyButtonRef3)
    curveDropdownButton2, curveDropdownButtonRef2 = curveDropdownButtonRef2, curveDropdownButtonRef2.Connect
    curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
    curveDropdownButtonRef2 = Instance.new("Frame", context.keybindPanelRef.value)
    context.curveOptionsPanelRef.value = curveDropdownButtonRef2
    curveDropdownButtonRef2 = context.curveOptionsPanelRef.value
    curveDropdownButton2 = UDim2.new(1, 0, 0, #context.curveOptions * 38)
    curveDropdownButtonRef2.Size = curveDropdownButton2
    curveDropdownButton2 = UDim2.new(0, 0, 0, 158)
    curveDropdownButtonRef2.Position = curveDropdownButton2
    curveDropdownButtonRef2.BackgroundTransparency = 1
    curveDropdownButtonRef2.Visible = false
    curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 = ipairs(context.curveOptions)
    curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 = normalizeIterator(curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2)
    for index3, item3 in curveDropdownButtonRef2, curveDropdownButton2, keyOptionsPopup2 do
        keybindPanel2, positionKeybindPanelRef, keyOptionsPopup2 = index3, item3, index3
        positionKeybindPanelRef = {value = positionKeybindPanelRef}
        frame3 = Instance.new("Frame", context.curveOptionsPanelRef.value)
        uICornerRef = UDim2.new(1, -16, 0, 34)
        frame3.Size = uICornerRef
        uICornerRef = UDim2.new(0, 8, 0, (keybindPanel2 - 1) * 38)
        frame3.Position = uICornerRef
        uICornerRef = Color3.fromRGB(25, 25, 25)
        frame3.BackgroundColor3 = uICornerRef
        frame3.BorderSizePixel = 0
        uICornerRef = Instance.new("UICorner", frame3)
        textLabel = UDim.new(0, 6)
        uICornerRef.CornerRadius = textLabel
        uICornerRef = Instance.new("UIStroke", frame3)
        uICornerRef.Color = context.accentColorRef.value
        uICornerRef.Transparency = 0.6
        uICornerRef.Thickness = 1
        textLabel = Instance.new("TextLabel", frame3)
        textButton2 = UDim2.new(0.5, -8, 1, 0)
        textLabel.Size = textButton2
        textButton2 = UDim2.new(0, 20, 0, 0)
        textLabel.Position = textButton2
        textLabel.BackgroundTransparency = 1
        textButton2 = string.upper(positionKeybindPanelRef.value)
        textLabel.Text = textButton2
        textLabel.TextColor3 = context.accentColorRef.value
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 11
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textButton2 = Instance.new("TextButton", frame3)
        uICornerRef2 = UDim2.new(0.5, -22, 1, -8)
        textButton2.Size = uICornerRef2
        uICornerRef2 = UDim2.new(0.5, 2, 0, 4)
        textButton2.Position = uICornerRef2
        uICornerRef2 = Color3.fromRGB(40, 40, 40)
        textButton2.BackgroundColor3 = uICornerRef2
        textButton2.Text = "NONE"
        textButton2.TextColor3 = context.mutedTextColor
        textButton2.Font = Enum.Font.GothamBold
        textButton2.TextSize = 10
        textButton2.AutoButtonColor = false
        uICornerRef2 = Instance.new("UICorner", textButton2)
        curveKeyRows3 = UDim.new(0, 5)
        uICornerRef2.CornerRadius = curveKeyRows3
        uICornerRef2 = Instance.new("UIStroke", textButton2)
        uICornerRef2 = {value = uICornerRef2}
        uICornerRef2.value.Color = context.accentColorRef.value
        uICornerRef2.value.Transparency = 0.3
        uICornerRef2.value.Thickness = 1
        fadeStrokeOut, curveKeyRows3 = bind(Handlers.fadeStrokeOut, context.tweenService, uICornerRef2), textButton2.MouseEnter
        curveKeyRows2, curveKeyRows3 = curveKeyRows3, curveKeyRows3.Connect
        curveKeyRows3(curveKeyRows2, fadeStrokeOut)
        curveKeyRows3, fadeStrokeOut = textButton2.MouseLeave, bind(Handlers.fadeButtonStrokeOut, context.tweenService, uICornerRef2)
        curveKeyRows3, curveKeyRows2 = curveKeyRows3.Connect, curveKeyRows3
        curveKeyRows3(curveKeyRows2, fadeStrokeOut)
        curveKeyRows3, fadeStrokeOut = textButton2.MouseButton1Click, bind(Handlers.beginCurveKeyCapture, context.beginKeyCaptureRef, positionKeybindPanelRef)
        curveKeyRows3, curveKeyRows2 = curveKeyRows3.Connect, curveKeyRows3
        curveKeyRows3(curveKeyRows2, fadeStrokeOut)
        fadeStrokeOut, curveKeyRows3 = {}, context.curveKeyRowsRef.value
        fadeStrokeOut.keyBtn = textButton2
        fadeStrokeOut.rowStroke = uICornerRef
        fadeStrokeOut.row = frame3
        curveKeyRows3[positionKeybindPanelRef.value] = fadeStrokeOut
    end
    keybindPanel2, positionKeybindPanelRef, keyOptionsPopup2 = nil, nil, nil
    keyOptionsPopup2, curveDropdownButtonRef2 = bind(Handlers.toggleKeybindPanel, context.tweenService, context.refreshKeybindPanelRef, context.keybindPanelRef, context.keybindPanelOpenRef, context.curveOptions, context.curveOptionsPanelRef), textButton.MouseButton1Click
    curveDropdownButtonRef2, curveDropdownButton2 = curveDropdownButtonRef2.Connect, curveDropdownButtonRef2
    curveDropdownButtonRef2(curveDropdownButton2, keyOptionsPopup2)
    curveDropdownButtonRef2 = Instance.new("ScrollingFrame", context.screenGuiRef.value)
    context.keyOptionsPopupRef.value = curveDropdownButtonRef2
    curveDropdownButtonRef2 = context.keyOptionsPopupRef.value
    curveDropdownButton2 = UDim2.new(0, 160, 0, 320)
    curveDropdownButtonRef2.Size = curveDropdownButton2
    curveDropdownButton2 = UDim2.new(0.5, 100, 0.45, 0)
    curveDropdownButtonRef2.Position = curveDropdownButton2
    curveDropdownButton2 = Color3.fromRGB(15, 15, 15)
    curveDropdownButtonRef2.BackgroundColor3 = curveDropdownButton2
    curveDropdownButtonRef2.BackgroundTransparency = 0.05
    curveDropdownButtonRef2.BorderSizePixel = 0
    curveDropdownButton2 = UDim2.new(0, 0, 0, 0)
    curveDropdownButtonRef2.CanvasSize = curveDropdownButton2
    curveDropdownButtonRef2.ScrollBarThickness = 3
    curveDropdownButtonRef2.ScrollBarImageColor3 = context.accentColorRef.value
    curveDropdownButtonRef2 = Instance.new("UICorner", context.keyOptionsPopupRef.value)
    curveDropdownButton2 = UDim.new(0, 10)
    curveDropdownButtonRef2.CornerRadius = curveDropdownButton2
    keyOptionsPopup2 = context.keyOptionsPopupRef.value
    curveDropdownButtonRef2 = Instance.new("UIStroke", context.keyOptionsPopupRef.value)
    curveDropdownButtonRef2.Color = context.accentColorRef.value
    keyOptionsPopup2.Visible = false
    curveDropdownButtonRef2 = Instance.new("UIListLayout", keyOptionsPopup2)
    curveDropdownButtonRef2 = {value = curveDropdownButtonRef2}
    curveDropdownButton2 = UDim.new(0, 2)
    curveDropdownButtonRef2.value.Padding = curveDropdownButton2
    curveDropdownButtonRef2.value.SortOrder = Enum.SortOrder.LayoutOrder
    curveDropdownButtonRef2.value.HorizontalAlignment = Enum.HorizontalAlignment.Center
    keyOptionsPopup2 = {}
    keyOptionsPopup2[14], keyOptionsPopup2[2], keyOptionsPopup2[10], keyOptionsPopup2[13], keyOptionsPopup2[11], keyOptionsPopup2[4], keyOptionsPopup2[6], keyOptionsPopup2[9], keyOptionsPopup2[1], keyOptionsPopup2[7], keyOptionsPopup2[12], keyOptionsPopup2[5], keyOptionsPopup2[3], keyOptionsPopup2[8], keyOptionsPopup2[16], keyOptionsPopup2[15] = "M", "A", "I", "L", "J", "C", "E", "H", "NONE", "F", "K", "D", "B", "G", "O", "N"
    keyOptionsPopup2[23], keyOptionsPopup2[24], keyOptionsPopup2[20], keyOptionsPopup2[27], keyOptionsPopup2[31], keyOptionsPopup2[25], keyOptionsPopup2[17], keyOptionsPopup2[26], keyOptionsPopup2[19], keyOptionsPopup2[21], keyOptionsPopup2[22], keyOptionsPopup2[30], keyOptionsPopup2[18], keyOptionsPopup2[28], keyOptionsPopup2[29], keyOptionsPopup2[32] = "V", "W", "S", "Z", "LeftControl", "X", "P", "Y", "R", "T", "U", "RightShift", "Q", "Space", "LeftShift", "RightControl"
    keyOptionsPopup2[43], keyOptionsPopup2[37], keyOptionsPopup2[47], keyOptionsPopup2[45], keyOptionsPopup2[44], keyOptionsPopup2[42], keyOptionsPopup2[34], keyOptionsPopup2[40], keyOptionsPopup2[38], keyOptionsPopup2[33], keyOptionsPopup2[39], keyOptionsPopup2[35], keyOptionsPopup2[48], keyOptionsPopup2[46], keyOptionsPopup2[41], keyOptionsPopup2[36] = "F6", "Escape", "F10", "F8", "F7", "F5", "RightAlt", "F3", "F1", "LeftAlt", "F2", "Tab", "F11", "F9", "F4", "CapsLock"
    keyOptionsPopup2[49] = "F12"
    keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef = ipairs(keyOptionsPopup2)
    keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef = normalizeIterator(keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef)
    for index4, item4 in keyOptionsPopup2, keybindPanel2, positionKeybindPanelRef do
        frame3, uICornerRef, positionKeybindPanelRef = index4, item4, index4
        uICornerRef = {value = uICornerRef}
        textLabel = Instance.new("TextButton", context.keyOptionsPopupRef.value)
        textButton2 = UDim2.new(1, -8, 0, 26)
        textLabel.Size = textButton2
        textLabel.LayoutOrder = frame3
        textButton2 = Color3.fromRGB(25, 25, 25)
        textLabel.BackgroundColor3 = textButton2
        textLabel.Text = ""
        textLabel.AutoButtonColor = false
        textLabel.Name = uICornerRef.value
        textButton2 = Instance.new("UICorner", textLabel)
        uICornerRef2 = UDim.new(0, 5)
        textButton2.CornerRadius = uICornerRef2
        textButton2 = Instance.new("UIStroke", textLabel)
        textButton2.Color = context.accentColorRef.value
        textButton2.Transparency = 0.6
        textButton2.Thickness = 1
        uICornerRef2 = Instance.new("Frame", textLabel)
        curveKeyRows3 = UDim2.new(0, 8, 0, 8)
        uICornerRef2.Size = curveKeyRows3
        curveKeyRows3 = UDim2.new(0, 10, 0.5, -4)
        uICornerRef2.Position = curveKeyRows3
        curveKeyRows3 = Color3.fromRGB(0, 0, 0)
        uICornerRef2.BackgroundColor3 = curveKeyRows3
        uICornerRef2.BorderSizePixel = 0
        curveKeyRows3 = Instance.new("UICorner", uICornerRef2)
        curveKeyRows2 = UDim.new(0, 2)
        curveKeyRows3.CornerRadius = curveKeyRows2
        curveKeyRows3 = Instance.new("UIStroke", uICornerRef2)
        curveKeyRows3.Color = context.accentColorRef.value
        curveKeyRows3.Transparency = 0.4
        curveKeyRows3.Thickness = 1
        curveKeyRows2 = Instance.new("TextLabel", textLabel)
        fadeStrokeOut = UDim2.new(1, -40, 1, 0)
        curveKeyRows2.Size = fadeStrokeOut
        fadeStrokeOut = UDim2.new(0, 24, 0, 0)
        curveKeyRows2.Position = fadeStrokeOut
        curveKeyRows2.BackgroundTransparency = 1
        curveKeyRows2.Text = uICornerRef.value
        fadeStrokeOut = uICornerRef.value == "NONE" and context.mutedTextColor or context.accentColorRef.value
        curveKeyRows2.TextColor3 = fadeStrokeOut
        curveKeyRows2.Font = Enum.Font.GothamBold
        curveKeyRows2.TextSize = 11
        curveKeyRows2.TextXAlignment = Enum.TextXAlignment.Left
        fadeStrokeOut = Instance.new("Frame", textLabel)
        keyOptionRows3 = UDim2.new(0, 6, 0, 6)
        fadeStrokeOut.Size = keyOptionRows3
        keyOptionRows3 = UDim2.new(1, -14, 0.5, -3)
        fadeStrokeOut.Position = keyOptionRows3
        keyOptionRows3 = Color3.fromRGB(70, 70, 70)
        fadeStrokeOut.BackgroundColor3 = keyOptionRows3
        fadeStrokeOut.BorderSizePixel = 0
        keyOptionRows3 = Instance.new("UICorner", fadeStrokeOut)
        keyOptionRows2 = UDim.new(0.5, 0)
        keyOptionRows3.CornerRadius = keyOptionRows2
        keyOptionRows3, clearSelectedKeybind = context.keyOptionRowsRef.value, {}
        clearSelectedKeybind.label = curveKeyRows2
        clearSelectedKeybind.stroke = textButton2
        clearSelectedKeybind.iconStroke = curveKeyRows3
        clearSelectedKeybind.dot = fadeStrokeOut
        keyOptionRows3[uICornerRef.value] = clearSelectedKeybind
        keyOptionRows3, clearSelectedKeybind = textLabel.MouseButton1Click, bind(Handlers.clearSelectedKeybind, context.keybinds, context.keyCaptureActiveRef, context.refreshKeybindPanelRef, context.pendingKeybindRef, context.selectedKey, uICornerRef, context.saveKeybindsRef, context.keyOptionsPopupRef)
        keyOptionRows3, keyOptionRows2 = keyOptionRows3.Connect, keyOptionRows3
        keyOptionRows3(keyOptionRows2, clearSelectedKeybind)
    end
    frame3, uICornerRef, positionKeybindPanelRef = nil, nil, nil
    keyOptionsPopup2, keybindPanel2 = task.defer, bind(Handlers.updateDropdownCanvas, context.keyOptionsPopupRef, curveDropdownButtonRef2)
    keyOptionsPopup2(keybindPanel2)
    context.refreshKeybindPanelRef.value()
    keybindPanel2, keyOptionsPopup2, positionKeybindPanelRef = context.keybindPanelRef.value, context.makeDraggableRef.value, bind(Handlers.positionKeybindPanel, context.keyOptionsPopupRef, context.keyCaptureActiveRef)
    keyOptionsPopup2(keybindPanel2, positionKeybindPanelRef, "KeybindMainFrame")
    return
end

-- Create the settings tabs and connect controls to configuration handlers.
function Handlers.buildSettingsWindow(context)
    local config2, showRemoteFoundNotification, angle, setSwordOverrideRef2, setSwordOverride2, setNetworkRateOverrideEnabled, resetFramePositions2
    local resetFramePositions3, resetFramePositions4, setClicksPerSecond, config3, onKeybindInputBegan2, setImmortalityAngle, setAccuracy
    local setAutoParryEnabled, copyDiscordInvite, curveOptions2, config4
    context.setSwordOverrideRef.value:Theme("nightly")
    setSwordOverrideRef2 = context.setSwordOverrideRef.value
    resetFramePositions2 = packValues(UDim2.new(0, 420, 0, 260))
    setSwordOverrideRef2, setSwordOverride2 = setSwordOverrideRef2.AddWindow, setSwordOverrideRef2
    setSwordOverrideRef2 = setSwordOverrideRef2(setSwordOverride2, "417", "NO REMOTE FOUND (must parry first self)", unpackValues(resetFramePositions2))
    setSwordOverrideRef2 = {value = setSwordOverrideRef2}
    setSwordOverride2, showRemoteFoundNotification = task.spawn, bind(Handlers.showRemoteFoundNotification, context.parryRemoteRef, setSwordOverrideRef2, context.setSwordOverrideRef)
    setSwordOverride2(showRemoteFoundNotification)
    setSwordOverride2 = setSwordOverrideRef2.value:AddTab("AP", "rbxassetid://130551565616516")
    showRemoteFoundNotification = setSwordOverride2:AddSection("Main", "left")
    onKeybindInputBegan2 = context.resetFramePositionsRef.value
    curveOptions2, resetFramePositions2, setAutoParryEnabled = context.config.parry, showRemoteFoundNotification.AddToggle, bind(Handlers.setAutoParryEnabled, {
        ballCurveStates = context.ballCurveStates,
        animationRecentlyPlayedRef = context.animationRecentlyPlayedRef,
        saveConfigRef = context.saveConfigRef,
        lastM1StopRef = context.lastM1StopRef,
        ballConnectionsRef = context.ballConnectionsRef,
        lastTriggerTimeRef = context.lastTriggerTimeRef,
        trackedBallsRef = context.trackedBallsRef,
        animationBusyRef = context.animationBusyRef,
        config = context.config,
        ballTargetTimesRef = context.ballTargetTimesRef,
        parrySucceededRef = context.parrySucceededRef
    })
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "Auto Parry", curveOptions2, setAutoParryEnabled)
    onKeybindInputBegan2.parry = resetFramePositions2
    onKeybindInputBegan2 = context.resetFramePositionsRef3.value
    resetFramePositions2, config2, setAccuracy = showRemoteFoundNotification.AddSlider, context.config.accuracy, bind(Handlers.setAccuracy, context.config, context.saveConfigRef)
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "Accuracy", 0, 100, config2, setAccuracy)
    onKeybindInputBegan2.accuracy = resetFramePositions2
    onKeybindInputBegan2 = context.resetFramePositionsRef.value
    curveOptions2, setAutoParryEnabled, resetFramePositions2 = context.config.autoAccuracy, bind(Handlers.setAutoAccuracyEnabled, context.config, context.saveConfigRef), showRemoteFoundNotification.AddToggle
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "Auto Accuracy", curveOptions2, setAutoParryEnabled)
    onKeybindInputBegan2.autoAccuracy = resetFramePositions2
    config2 = context.config
    resetFramePositions2, setAutoParryEnabled, curveOptions2 = showRemoteFoundNotification.AddToggle, bind(Handlers.setAbilityCooldownProtection, context.config, context.saveConfigRef), context.config.ability.cooldown_protection
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "CD Protect", curveOptions2, setAutoParryEnabled)
    onKeybindInputBegan2.ability_cooldown_protection = resetFramePositions2
    resetFramePositions2, setAutoParryEnabled, curveOptions2 = showRemoteFoundNotification.AddToggle, bind(Handlers.setSpamParryEnabled, context.config, context.ballPresentRef, context.saveConfigRef), config2.spamParry
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "Auto Spam", curveOptions2, setAutoParryEnabled)
    onKeybindInputBegan2.spamParry = resetFramePositions2
    onKeybindInputBegan2 = context.resetFramePositionsRef3.value
    config2, setAccuracy = config2.spamThreshold, bind(Handlers.setSpamThreshold, context.config, context.saveConfigRef)
    resetFramePositions2 = showRemoteFoundNotification:AddSlider("Spam Threshold", 1, 2, config2, setAccuracy)
    onKeybindInputBegan2.spamThreshold = resetFramePositions2
    onKeybindInputBegan2, curveOptions2 = context.onKeybindInputBeganRef.value, context.curveOptions
    config2, setAutoParryEnabled, resetFramePositions2 = bind(Handlers.setCurveType, context.refreshKeybindPanelRef, context.selectedCurveRef, context.saveConfigRef, context.config, context.refreshCurvePanelRef), context.config.curveType, showRemoteFoundNotification.AddDropdown
    resetFramePositions2 = resetFramePositions2(showRemoteFoundNotification, "Curve Type", curveOptions2, setAutoParryEnabled, config2)
    onKeybindInputBegan2.curveType = resetFramePositions2
    onKeybindInputBegan2 = setSwordOverride2:AddSection("Settings", "left")
    resetFramePositions2 = context.resetFramePositionsRef3.value
    resetFramePositions4, setClicksPerSecond, setAccuracy = onKeybindInputBegan2.AddSlider, bind(Handlers.setClicksPerSecond, context.config, context.saveConfigRef), context.config.cps
    resetFramePositions4 = resetFramePositions4(onKeybindInputBegan2, "CPS", 60, 500, setAccuracy, setClicksPerSecond)
    resetFramePositions2.cps = resetFramePositions4
    resetFramePositions2 = context.resetFramePositionsRef.value
    config2, setAutoParryEnabled, resetFramePositions4 = bind(Handlers.setAnimationFixEnabled, context.config, context.saveConfigRef), context.config.animfix, onKeybindInputBegan2.AddToggle
    resetFramePositions4 = resetFramePositions4(onKeybindInputBegan2, "Anim Fix", setAutoParryEnabled, config2)
    resetFramePositions2.animfix = resetFramePositions4
    resetFramePositions2 = setSwordOverride2:AddSection("UI Visibility", "right")
    resetFramePositions4 = context.resetFramePositionsRef.value
    config2 = context.config.showStats
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setSpeedPanelVisible, context.config, context.speedDisplayRef, context.saveConfigRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show Ball Stats", config2, setAccuracy)
    resetFramePositions4.showStats = resetFramePositions3
    config2 = context.config.showFpsUI
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setFpsPanelVisible, context.config, context.fpsPanelRef, context.saveConfigRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Fps UI", config2, setAccuracy)
    resetFramePositions4.showFpsUI = resetFramePositions3
    config2 = context.config.showBindWindow
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setKeybindPanelVisible, context.keyOptionsPopupRef, context.refreshKeybindPanelRef, context.saveConfigRef, context.config, context.keyCaptureActiveRef, context.keybindPanelRef, context.pendingKeybindRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show Keybind UI", config2, setAccuracy)
    resetFramePositions4.showBindWindow = resetFramePositions3
    config2 = context.config.showSpamUI
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setSpamPanelVisible, context.config, context.spamPanel, context.saveConfigRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show Spam UI", config2, setAccuracy)
    resetFramePositions4.showSpamUI = resetFramePositions3
    config2 = context.config.showTriggerUI
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setTriggerPanelVisible, context.config, context.triggerPanel, context.saveConfigRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show TriggerBot UI", config2, setAccuracy)
    resetFramePositions4.showTriggerUI = resetFramePositions3
    config2 = context.config.showImmortalUI
    setAccuracy, resetFramePositions3 = bind(Handlers.setImmortalityPanelVisible, context.config, context.immortalityPanel, context.saveConfigRef), resetFramePositions2.AddToggle
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show Immortal UI", config2, setAccuracy)
    resetFramePositions4.showImmortalUI = resetFramePositions3
    config2 = context.config.showCurveUI
    resetFramePositions3, setAccuracy = resetFramePositions2.AddToggle, bind(Handlers.setCurvePanelVisible, context.curveOptionsPanelRef, context.curveOptionsOpenRef, context.saveConfigRef, context.config, context.curvePanelOpenRef)
    resetFramePositions3 = resetFramePositions3(resetFramePositions2, "Show Curves UI", config2, setAccuracy)
    resetFramePositions4.showCurveUI = resetFramePositions3
    resetFramePositions4 = setSwordOverride2:AddSection("Immortal (bannable)", "right")
    resetFramePositions3 = context.resetFramePositionsRef.value
    curveOptions2, setClicksPerSecond, setAccuracy = resetFramePositions4.AddToggle, bind(Handlers.setImmortality, context.immortalityLabel, context.setImmortalityHookRef, context.saveConfigRef, context.config, context.immortalityButtonRef, context.styleFloatingButtonRef, context.immortalityStroke), context.config.immortality
    curveOptions2 = curveOptions2(resetFramePositions4, "Enabled", setAccuracy, setClicksPerSecond)
    resetFramePositions3.immortality = curveOptions2
    resetFramePositions3, config4 = context.resetFramePositionsRef3.value, context.config
    curveOptions2, angle, setImmortalityAngle = resetFramePositions4.AddSlider, context.config.imm.angle, bind(Handlers.setImmortalityAngle, context.config, context.saveConfigRef)
    curveOptions2 = curveOptions2(resetFramePositions4, "Angle", 0, 70, angle, setImmortalityAngle)
    resetFramePositions3.imm_angle = curveOptions2
    angle, setImmortalityAngle, curveOptions2 = config4.imm.height, bind(Handlers.setImmortalityHeight, context.config, context.saveConfigRef), resetFramePositions4.AddSlider
    curveOptions2 = curveOptions2(resetFramePositions4, "Height", 0, 50, angle, setImmortalityAngle)
    resetFramePositions3.imm_height = curveOptions2
    config3 = config4
    config4 = config4.imm
    curveOptions2, angle, setImmortalityAngle = resetFramePositions4.AddSlider, -config4.depth, bind(Handlers.setImmortalityDepth, context.config, context.saveConfigRef)
    curveOptions2 = curveOptions2(resetFramePositions4, "Depth", 0, 8, angle, setImmortalityAngle)
    resetFramePositions3.imm_depth = curveOptions2
    setImmortalityAngle, angle, curveOptions2 = bind(Handlers.setImmortalityRadius, context.config, context.saveConfigRef), config3.imm.radius, resetFramePositions4.AddSlider
    curveOptions2 = curveOptions2(resetFramePositions4, "Radius", 0, 20, angle, setImmortalityAngle)
    resetFramePositions3.imm_radius = curveOptions2
    resetFramePositions3 = setSwordOverrideRef2.value:AddTab("OPTIM", "rbxassetid://80758916183665")
    curveOptions2 = resetFramePositions3:AddSection("Looks", "left")
    setAutoParryEnabled = context.resetFramePositionsRef.value
    angle, setImmortalityAngle = config3.optim.headless, bind(Handlers.setHeadlessEnabled, context.saveConfigRef, context.localPlayerRef, context.applyAppearanceRef, context.config)
    config2 = curveOptions2:AddToggle("Headless", angle, setImmortalityAngle)
    setAutoParryEnabled.optim_headless = config2
    angle = config3.optim.korblox
    config2, setImmortalityAngle = curveOptions2.AddToggle, bind(Handlers.setKorbloxEnabled, context.saveConfigRef, context.localPlayerRef, context.applyAppearanceRef, context.config)
    config2 = config2(curveOptions2, "Korblox", angle, setImmortalityAngle)
    setAutoParryEnabled.optim_korblox = config2
    angle = config3.unlock_all
    config2, setImmortalityAngle = curveOptions2.AddToggle, bind(Handlers.setCosmeticsEnabled, context.cosmeticsRef)
    config2 = config2(curveOptions2, "Unlock All (Bannable)", angle, setImmortalityAngle)
    setAutoParryEnabled.unlock_all = config2
    setAutoParryEnabled = resetFramePositions3:AddSection("Effects", "left")
    config2 = context.resetFramePositionsRef.value
    config4, setImmortalityAngle, setAccuracy = bind(Handlers.setNoRenderEnabled, context.config, context.applyOptimizationRef, context.saveConfigRef), config3.optim.noRender, setAutoParryEnabled.AddToggle
    setAccuracy = setAccuracy(setAutoParryEnabled, "No Render", setImmortalityAngle, config4)
    config2.optim_noRender = setAccuracy
    config2 = resetFramePositions3:AddSection("Config", "left")
    setAccuracy = context.resetFramePositionsRef.value
    config4, config3, setClicksPerSecond = config3.saveButtonPositions, bind(Handlers.setSavePositionsEnabled, context.config, context.saveConfigRef), config2.AddToggle
    setClicksPerSecond = setClicksPerSecond(config2, "Save Config", config4, config3)
    setAccuracy.saveButtonPositions = setClicksPerSecond
    setAccuracy, setImmortalityAngle = config2.AddButton, bind(Handlers.runCapturedAction, context.deleteConfigAndResetRef)
    setAccuracy(config2, "Delete Current Config", setImmortalityAngle)
    setImmortalityAngle, setAccuracy = bind(Handlers.invokeSelectedAction, context.resetFramePositionsRef2), config2.AddButton
    setAccuracy(config2, "Reset Buttons", setImmortalityAngle)
    setAccuracy = resetFramePositions3:AddSection("Network", "right")
    setClicksPerSecond = context.resetFramePositionsRef.value
    config3, angle, setNetworkRateOverrideEnabled = context.config.optim.unlimitedKBPS, setAccuracy.AddToggle, bind(Handlers.setNetworkRateOverrideEnabled, context.config, context.applyOptimizationRef, context.saveConfigRef)
    angle = angle(setAccuracy, "Unlimited KBPS", config3, setNetworkRateOverrideEnabled)
    setClicksPerSecond.optim_unlimitedKBPS = angle
    setClicksPerSecond = resetFramePositions3:AddSection("Spoofer", "right")
    angle, config3 = setClicksPerSecond.AddButton, bind(Handlers.runCapturedActionSafely, context.applyDeviceSpoofRef)
    angle(setClicksPerSecond, "PC", config3)
    angle = setSwordOverrideRef2.value:AddTab("SOCIAL", "rbxassetid://131607023382430")
    setImmortalityAngle = angle:AddSection("Links")
    setImmortalityAngle:AddLabel("TG: https://t.me/SCRIPT417")
    setImmortalityAngle:AddLabel("DC: https://discord.gg/dQ7TNW4Ppb")
    setImmortalityAngle:AddLabel("TT: https://www.tiktok.com/@vincere417")
    config4, copyDiscordInvite = setImmortalityAngle.AddButton, bind(Handlers.copyDiscordInvite)
    config4(setImmortalityAngle, "Copy Discord", copyDiscordInvite)
    config4, copyDiscordInvite = setImmortalityAngle.AddButton, bind(Handlers.copyTelegramLink)
    config4(setImmortalityAngle, "Copy Telegram", copyDiscordInvite)
    config4, copyDiscordInvite = setImmortalityAngle.AddButton, bind(Handlers.copyTikTokLink)
    config4(setImmortalityAngle, "Copy TikTok", copyDiscordInvite)
    return
end

function Handlers.captureKeybind(labelText, resizeKeybindTextRef, keybindRef, capturingKeyRef, tweenService, userInputService, valueText, selectedKeyRef)
    local labelText2, tweenInfo, tweenService2, temporary4, temporary5Ref, tweenService3, inputBegan
    if capturingKeyRef.value then
        return
    end
    capturingKeyRef.value = true
    temporary5Ref = {value = nil}
    tweenService3, inputBegan = bind(Handlers.rememberPressedKey, temporary5Ref), userInputService.InputBegan
    tweenService2, inputBegan = inputBegan, inputBegan.Connect
    inputBegan = inputBegan(tweenService2, tweenService3)
    labelText2, tweenService2 = labelText, tweenService
    tweenInfo = TweenInfo.new(0.3)
    temporary4 = {}
    temporary4.TextTransparency = 0
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    valueText.Text = "..."
    while true do
        task.wait()
        resizeKeybindTextRef.value()
        tweenService2 = temporary5Ref.value or not capturingKeyRef.value
        if tweenService2 then
            break
        else
            continue
        end
    end
    labelText2, tweenService2 = labelText, tweenService
    tweenInfo = TweenInfo.new(0.3)
    temporary4 = {}
    temporary4.TextTransparency = 0.3
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    capturingKeyRef.value = false
    if inputBegan then
        inputBegan:Disconnect()
    end
    if temporary5Ref.value then
        if not temporary5Ref.value then
            tweenService3 = "None"
        else
            tweenService3 = temporary5Ref.value.Name
        end
        valueText.Text = tweenService3
        tweenService2, selectedKeyRef.value = resizeKeybindTextRef.value, temporary5Ref.value
        tweenService2()
        keybindRef.value(temporary5Ref.value)
    end
    return
end

function Handlers.clearSelectedKeybind(keybinds, keyCaptureActiveRef, refreshKeybindPanelRef, pendingKeybindRef, selectedKey, uICornerRef, saveKeybindsRef, keyOptionsPopupRef)
    local selectedKey2
    if pendingKeybindRef.value then
        if uICornerRef.value == "NONE" then
            selectedKey2 = selectedKey
        else
            selectedKey2 = Enum.KeyCode[uICornerRef.value]
        end
        if selectedKey2 then
            if pendingKeybindRef.value.kind == "spam" then
                keybinds.spam = selectedKey2
            else
                if pendingKeybindRef.value.kind == "trigger" then
                    keybinds.trigger = selectedKey2
                else
                    if pendingKeybindRef.value.kind == "curve" then
                        keybinds.curve[pendingKeybindRef.value.name] = selectedKey2
                    end
                end
            end
            saveKeybindsRef.value()
        end
    end
    selectedKey2, keyCaptureActiveRef.value = keyOptionsPopupRef.value, false
    selectedKey2.Visible = false
    pendingKeybindRef.value = nil
    refreshKeybindPanelRef.value()
    return
end

function Handlers.connectDropdownDrag(frame, userInputService)
    local resultRef, temporary2Ref, updateSliderDragRef, beginDropdownDragging, frame2, temporary6Ref, inputBegan
    resultRef = {value = nil}
    temporary2Ref = {value = nil}
    temporary6Ref = {value = nil}
    updateSliderDragRef = {value = updateSliderDragRef}
    frame2, updateSliderDragRef.value = frame, bind(Handlers.updateSliderDrag, temporary2Ref, temporary6Ref, frame)
    beginDropdownDragging, inputBegan = bind(Handlers.beginDropdownDragging, frame, temporary2Ref, temporary6Ref, resultRef), frame2.InputBegan
    frame2, inputBegan = inputBegan, inputBegan.Connect
    inputBegan(frame2, beginDropdownDragging)
    beginDropdownDragging, inputBegan = bind(Handlers.onWindowDragInputChanged, resultRef, updateSliderDragRef), userInputService.InputChanged
    frame2, inputBegan = inputBegan, inputBegan.Connect
    inputBegan(frame2, beginDropdownDragging)
    return
end

function Handlers.connectNotificationLifetime(countdown, animateNotificationOutRef, tweenService, closeButton, duration)
    local animateNotificationLifetime
    closeButton.MouseButton1Click:Connect(animateNotificationOutRef.value)
    if duration then
        animateNotificationLifetime = bind(Handlers.animateNotificationLifetime, animateNotificationOutRef, countdown, duration, tweenService)
        pcall(animateNotificationLifetime)
    end
    return
end

function Handlers.connectWindowDrag(frame, connectRef, userInputService)
    local resultRef, updateWindowDragRef, temporary3Ref, beginSliderDragging, temporary5Ref, frame2, inputBegan
    resultRef = {value = nil}
    temporary3Ref = {value = nil}
    temporary5Ref = {value = nil}
    updateWindowDragRef = {value = updateWindowDragRef}
    updateWindowDragRef.value, frame2 = bind(Handlers.updateWindowDrag, temporary3Ref, temporary5Ref, frame), frame
    beginSliderDragging, inputBegan = bind(Handlers.beginSliderDragging, temporary5Ref, resultRef, frame, connectRef, temporary3Ref), frame2.InputBegan
    inputBegan, frame2 = inputBegan.Connect, inputBegan
    inputBegan(frame2, beginSliderDragging)
    inputBegan, beginSliderDragging = userInputService.InputChanged, bind(Handlers.onSliderDragInputChanged, resultRef, connectRef, updateWindowDragRef)
    frame2, inputBegan = inputBegan, inputBegan.Connect
    inputBegan(frame2, beginSliderDragging)
    return
end

function Handlers.copyTextWithFallback(clipboardText)
    local copyTextToClipboard
    copyTextToClipboard = bind(Handlers.copyTextToClipboard, clipboardText)
    pcall(copyTextToClipboard)
    copyTextToClipboard = bind(Handlers.copyTextToClipboardFallback, clipboardText)
    pcall(copyTextToClipboard)
    return
end

function Handlers.createFloatingButton(backgroundColor, accentColorRef, tweenService, value, text)
    local highlightFloatingButton, mouseEnter, mouseEnter2, uICornerRef, textLabel, textButton
    textButton = Instance.new("TextButton", value)
    uICornerRef = UDim2.new(1, -20, 1, -20)
    textButton.Size = uICornerRef
    uICornerRef = UDim2.new(0, 10, 0, 10)
    textButton.Position = uICornerRef
    textButton.BackgroundColor3 = backgroundColor
    textButton.Text = ""
    textButton.AutoButtonColor = false
    uICornerRef = Instance.new("UICorner", textButton)
    textLabel = UDim.new(0, 8)
    uICornerRef.CornerRadius = textLabel
    uICornerRef = Instance.new("UIStroke", textButton)
    uICornerRef = {value = uICornerRef}
    uICornerRef.value.Color = accentColorRef.value
    uICornerRef.value.Transparency = 0.5
    uICornerRef.value.Thickness = 1
    textLabel = Instance.new("TextLabel", textButton)
    mouseEnter2 = UDim2.new(1, -20, 1, 0)
    textLabel.Size = mouseEnter2
    mouseEnter2 = UDim2.new(0, 10, 0, 0)
    textLabel.Position = mouseEnter2
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = accentColorRef.value
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    highlightFloatingButton, mouseEnter2 = bind(Handlers.highlightFloatingButton, uICornerRef, tweenService), textButton.MouseEnter
    mouseEnter2, mouseEnter = mouseEnter2.Connect, mouseEnter2
    mouseEnter2(mouseEnter, highlightFloatingButton)
    highlightFloatingButton, mouseEnter2 = bind(Handlers.unhighlightFloatingButton, uICornerRef, tweenService), textButton.MouseLeave
    mouseEnter2, mouseEnter = mouseEnter2.Connect, mouseEnter2
    mouseEnter2(mouseEnter, highlightFloatingButton)
    return textButton, textLabel, uICornerRef.value
end

function Handlers.createInvisibleButton(parent)
    local position, textButton
    textButton = Instance.new("TextButton")
    position = UDim2.new(1, 0, 1, 0)
    textButton.Size = position
    textButton.BackgroundTransparency = 1
    textButton.TextTransparency = 1
    textButton.Text = ""
    textButton.Parent = parent
    textButton.ZIndex = 5000
    return textButton
end

function Handlers.createNotificationArea(tweenService, protectGui, theme, guiParent, accentColor, value)
    local notification, mainFrame, uIListLayout, notify, notification2
    notification2 = {}
    notification2.MaxNotifications = 5
    notification = notification2
    notification2 = Instance.new("ScreenGui")
    mainFrame = Instance.new("Frame")
    uIListLayout = Instance.new("UIListLayout")
    notification2.Name = "Notification"
    notification2.Parent = guiParent
    notification2.ResetOnSpawn = false
    notification2.ZIndexBehavior = Enum.ZIndexBehavior.Global
    notification2.IgnoreGuiInset = true
    protectGui(notification2)
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = notification2
    notify = Vector2.new(1, 1)
    mainFrame.AnchorPoint = notify
    mainFrame.BackgroundTransparency = 1
    mainFrame.BorderSizePixel = 0
    notify = UDim2.new(0.99000001, 0, 0.99000001, 0)
    mainFrame.Position = notify
    notify = UDim2.new(0.35, 0, 0.100000001, 0)
    mainFrame.Size = notify
    uIListLayout.Parent = mainFrame
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    notify = UDim.new(0, 4)
    uIListLayout.Padding = notify
    notify = bind(Handlers.notify, accentColor, notification, tweenService, mainFrame, theme)
    notification.Notify = notify
    return notification
end

-- Construct the reusable UI library.
function Handlers.createUiLibrary(localPlayerRef, tweenService)
    local userInputService, textService, temporary3, createInvisibleButtonRef, temporary5, theme, temporary7
    local runUiRefreshLoop, temporary9, themeRef, temporary11
    localPlayerRef.value:GetMouse()
    userInputService = game:GetService("UserInputService")
    textService = game:GetService("TextService")
    temporary9 = game:FindFirstChild("CoreGui") or localPlayerRef.value.PlayerGui
    temporary11 = protectgui or syn and syn.protect_gui or bind(Handlers.noopUi)
    temporary3 = Color3.fromRGB(255, 140, 0)
    createInvisibleButtonRef = {value = 255}
    temporary7, createInvisibleButtonRef.value, theme = {}, bind(Handlers.createInvisibleButton), {}
    theme.auto_function = temporary7
    temporary7 = {}
    temporary5 = Color3.fromRGB(20, 20, 20)
    temporary7.BlackgroundColor = temporary5
    temporary5 = Color3.fromRGB(15, 15, 15)
    temporary7.BlackColor = temporary5
    temporary5 = Color3.fromRGB(28, 28, 28)
    temporary7.HeaderColor = temporary5
    temporary5 = Color3.fromRGB(100, 100, 100)
    temporary7.TraceColor = temporary5
    temporary7.MainColor = temporary3
    temporary5 = Color3.fromRGB(65, 54, 31)
    temporary7.MainColorDrop = temporary5
    temporary5 = Color3.fromRGB(22, 22, 22)
    temporary7.SectionColor = temporary5
    temporary5 = Color3.fromRGB(255, 140, 0)
    temporary7.StrokeColor = temporary5
    temporary5 = Color3.fromRGB(30, 30, 30)
    temporary7.ButtonBlackgroundColor = temporary5
    theme.Themes = temporary7
    theme._Version = "10.C"
    theme._Name = "NEVERLOSE"
    themeRef = theme
    theme = bind(Handlers.theme, themeRef)
    themeRef.Theme = theme
    theme = bind(Handlers.addWindow, temporary9, themeRef, textService, createInvisibleButtonRef, userInputService, tweenService, temporary11, localPlayerRef, temporary3)
    themeRef.AddWindow = theme
    theme = bind(Handlers.createKeySystem, tweenService, themeRef, userInputService, temporary9, temporary3)
    themeRef.KeySystem = theme
    theme = bind(Handlers.createNotificationArea, tweenService, temporary11, themeRef, temporary9, temporary3)
    themeRef.Notification = theme
    runUiRefreshLoop, theme = bind(Handlers.runUiRefreshLoop, themeRef), task.spawn
    theme(runUiRefreshLoop)
    return themeRef
end

function Handlers.createWindowTitle(textLabelRef, frame, strokeColor, title)
    local position, textLabel2
    if title then
        textLabel2 = Instance.new("TextLabel")
        textLabel2.Parent = frame
        position = Color3.fromRGB(255, 255, 255)
        textLabel2.BackgroundColor3 = position
        textLabel2.BackgroundTransparency = 1
        position = Color3.fromRGB(0, 0, 0)
        textLabel2.BorderColor3 = position
        textLabel2.BorderSizePixel = 0
        position = UDim2.new(0.243000001, 0, 0.0250000004, 0)
        textLabel2.Position = position
        position = UDim2.new(0.666889787, 0, 0.0627818182, 0)
        textLabel2.Size = position
        textLabel2.ZIndex = 5
        textLabel2.Font = Enum.Font.SourceSansBold
        position = title or " "
        textLabel2.Text = position
        position = Color3.fromRGB(255, 255, 255)
        textLabel2.TextColor3 = position
        textLabel2.TextScaled = true
        textLabel2.TextSize = 14
        textLabel2.TextStrokeColor3 = strokeColor
        textLabel2.TextStrokeTransparency = 0.9
        textLabel2.TextWrapped = true
        textLabel2.TextXAlignment = Enum.TextXAlignment.Left
        textLabel2.RichText = true
        textLabelRef.value = textLabel2
    end
    return
end

function Handlers.createWindowToggleButton(connectRef, tweenService, collapsedRef, frame, createWindowTitleRef)
    local mouseButton1Click, imageButton, mouseButton1Click2, toggleWindowCollapsed
    imageButton = Instance.new("ImageButton")
    imageButton.Parent = frame
    mouseButton1Click = Color3.fromRGB(255, 255, 255)
    imageButton.BackgroundColor3 = mouseButton1Click
    imageButton.BackgroundTransparency = 1
    mouseButton1Click = Color3.fromRGB(0, 0, 0)
    imageButton.BorderColor3 = mouseButton1Click
    imageButton.BorderSizePixel = 0
    mouseButton1Click = UDim2.new(0.908723712, 0, 0.0239103697, 0)
    imageButton.Position = mouseButton1Click
    mouseButton1Click = UDim2.new(0.0900000036, 0, 0.0900000036, 0)
    imageButton.Size = mouseButton1Click
    imageButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    imageButton.ZIndex = 4
    imageButton.Image = "rbxassetid://10002398990"
    imageButton.ScaleType = Enum.ScaleType.Fit
    mouseButton1Click, toggleWindowCollapsed = imageButton.MouseButton1Click, bind(Handlers.toggleWindowCollapsed, tweenService, createWindowTitleRef, imageButton, connectRef, frame, collapsedRef)
    mouseButton1Click, mouseButton1Click2 = mouseButton1Click.Connect, mouseButton1Click
    mouseButton1Click(mouseButton1Click2, toggleWindowCollapsed)
    return
end

function Handlers.destroyNotification(notifyRef)
    notifyRef.value:Destroy()
    return
end

function Handlers.destroyNotificationAfterDelay(screenGuiRef)
    task.wait(0.45)
    screenGuiRef.value:Destroy()
    return
end

function Handlers.destroyUiElement(screenGui, value)
    local result
    result = packValues(screenGui:Destroy())
    return unpackValues(result)
end

function Handlers.fadeButtonStrokeOut(tweenService, uICornerRef)
    local uICorner2, temporary2, tweenService2, tweenService3, tweenInfo
    tweenService3, uICorner2 = tweenService, uICornerRef.value
    tweenInfo = TweenInfo.new(0.2)
    temporary2 = {}
    temporary2.Transparency = 0.3
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, uICorner2, tweenInfo, temporary2)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    return
end

function Handlers.fadeKeybindStrokeIn(tweenService, spamKeyButtonRef)
    local tweenService2, tweenService3, spamKeyButton2, temporary4, tweenInfo
    spamKeyButton2, tweenService2 = spamKeyButtonRef.value, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary4 = {}
    temporary4.Transparency = 0
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, spamKeyButton2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    return
end

function Handlers.fadeKeybindStrokeOut(tweenService, triggerKeyButtonRef)
    local tweenInfo, tweenService2, triggerKeyButton2, temporary4, tweenService3
    triggerKeyButton2, tweenService3 = triggerKeyButtonRef.value, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary4 = {}
    temporary4.Transparency = 0
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, triggerKeyButton2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    return
end

function Handlers.fadeTabTitle(tabTitleRef, tweenService)
    local tweenService2, temporary2, tweenInfo, tabTitle2, tweenService3
    if tabTitleRef.value then
        tweenService2, tabTitle2 = tweenService, tabTitleRef.value
        tweenInfo = TweenInfo.new(0.1)
        temporary2 = {}
        temporary2.TextTransparency = 0.1
        temporary2.TextStrokeTransparency = 0.95
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, tabTitle2, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        task.wait(0.11)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.1)
        temporary2 = {}
        temporary2.TextTransparency = 0
        temporary2.TextStrokeTransparency = 0.9
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, tabTitle2, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

function Handlers.finishDrag(positionRef, frameName, onPositionChanged, defaultPositionsRef, positionedObject)
    local onPositionChanged2, temporary2
    temporary2 = defaultPositionsRef.value[frameName]
    if defaultPositionsRef.value[frameName] then
        positionedObject.Position = defaultPositionsRef.value[frameName]
        positionRef.value, onPositionChanged2 = temporary2, onPositionChanged
        if onPositionChanged2 then
            onPositionChanged(temporary2)
        end
    end
    return
end

function Handlers.highlightButton(tweenService, labelText, uIStroke)
    local tweenService2, tweenService3, temporary3, tweenInfo, labelText2
    tweenService3, labelText2 = tweenService, labelText
    tweenInfo = TweenInfo.new(0.1)
    temporary3 = {}
    temporary3.TextTransparency = 0
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, labelText2, tweenInfo, temporary3)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    tweenService3 = tweenService
    labelText2 = uIStroke
    tweenInfo = TweenInfo.new(0.2)
    temporary3 = {}
    temporary3.Transparency = 0
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, labelText2, tweenInfo, temporary3)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    return
end

function Handlers.highlightDropdownItem(tweenService, textButton)
    local tweenService2, tweenInfo, textButton2, tweenService3, temporary5
    textButton2, tweenService2 = textButton, tweenService
    tweenInfo = TweenInfo.new(0.1)
    temporary5 = {}
    temporary5.TextTransparency = 0
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, textButton2, tweenInfo, temporary5)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    return
end

function Handlers.highlightFloatingButton(uICornerRef, tweenService)
    local uICorner2, temporary2, tweenService2, tweenInfo, tweenService3
    if uICornerRef.value.Transparency ~= 0 then
        tweenService3, uICorner2 = tweenService, uICornerRef.value
        tweenInfo = TweenInfo.new(0.25)
        temporary2 = {}
        temporary2.Transparency = 0.1
        tweenService3, tweenService2 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService2, uICorner2, tweenInfo, temporary2)
        tweenService3, tweenService2 = tweenService3.Play, tweenService3
        tweenService3(tweenService2)
    end
    return
end

function Handlers.invokeButtonAction(buttonRef)
    buttonRef.value()
    return
end

function Handlers.makeDraggable(dragConnectionsRef, userInputService, defaultPositionsRef, config, runService, userInputService2, otherValue, otherValue2)
    local dragConnections2, temporary2Ref, temporary3Ref, temporary4Ref, beginDrag, connect, temporary7Ref
    local positionRef
    temporary3Ref = {value = false}
    temporary4Ref = {value = nil}
    temporary2Ref = {value = nil}
    temporary7Ref = {value = nil}
    positionRef = {value = nil}
    dragConnections2, beginDrag, connect = userInputService2.InputBegan, bind(Handlers.beginDrag, userInputService2, config, otherValue2, temporary3Ref, temporary7Ref, temporary2Ref, positionRef), userInputService2.InputBegan.Connect
    connect(dragConnections2, beginDrag)
    beginDrag, connect = bind(Handlers.setDragging, temporary4Ref), userInputService2.InputChanged
    dragConnections2, connect = connect, connect.Connect
    connect(dragConnections2, beginDrag)
    connect, beginDrag = userInputService.InputChanged, bind(Handlers.rememberDragPosition, positionRef, temporary3Ref, temporary7Ref, temporary4Ref, temporary2Ref)
    connect, dragConnections2 = connect.Connect, connect
    connect(dragConnections2, beginDrag)
    beginDrag, dragConnections2, connect = bind(Handlers.moveDraggedFrame, positionRef, userInputService2, otherValue), runService.RenderStepped, runService.RenderStepped.Connect
    connect(dragConnections2, beginDrag)
    if otherValue2 then
        if config.buttonPositions[otherValue2] then
            dragConnections2 = UDim2.new(config.buttonPositions[otherValue2].X.S, config.buttonPositions[otherValue2].X.O, config.buttonPositions[otherValue2].Y.S, config.buttonPositions[otherValue2].Y.O)
            userInputService2.Position = dragConnections2
            positionRef.value = userInputService2.Position
        end
        beginDrag, dragConnections2 = bind(Handlers.finishDrag, positionRef, otherValue2, otherValue, defaultPositionsRef, userInputService2), dragConnectionsRef.value
        dragConnections2[otherValue2] = beginDrag
    end
    return
end

function Handlers.moveDraggedFrame(positionRef, positionedObject, onPositionChanged, value)
    local result, positionedObject2, y, position2, offset, temporary6, offset2
    local temporary8, position3
    if not positionRef.value then
        return
    end
    position2 = positionedObject.Position
    temporary6 = math.clamp(value * 25, 0, 1)
    offset2 = position2.X.Offset + (positionRef.value.X.Offset - position2.X.Offset) * temporary6
    offset = position2.Y.Offset + (positionRef.value.Y.Offset - position2.Y.Offset) * temporary6
    y = positionRef.value
    temporary8 = math.abs(position2.X.Offset + (positionRef.value.X.Offset - position2.X.Offset) * temporary6 - positionRef.value.X.Offset)
    result = temporary8 < 0.5
    y = y.Y
    positionedObject2 = math.abs(offset - y.Offset)
    temporary8 = positionedObject2 < 0.5
    if result then
        offset2 = positionRef.value.X.Offset
    end
    if positionedObject2 < 0.5 then
        offset = positionRef.value.Y.Offset
    end
    positionedObject2 = positionedObject
    position3 = UDim2.new(positionRef.value.X.Scale, offset2, positionRef.value.Y.Scale, offset)
    positionedObject2.Position = position3
    if onPositionChanged then
        onPositionChanged(positionedObject.Position)
    end
    positionedObject2 = result and temporary8
    if positionedObject2 then
        positionRef.value = nil
    end
    return
end

function Handlers.noopButton()
    return
end

function Handlers.noopDropdown()
    return
end

function Handlers.noopKeybind()
    return
end

function Handlers.noopSlider()
    return
end

function Handlers.noopToggle()
    return
end

function Handlers.noopUi()
    return
end

function Handlers.notify(accentColor, notification, tweenService, mainFrame, theme, value, otherValue, otherValue2, otherValue3, otherValue4)
    local notifyRef, temporary2, headTitle, countdown, animateNotificationIn, connectNotificationLifetime, iconImage
    local bodyTitle, spawn, closeButton, uICorner, uIStroke, animateNotificationOutRef
    temporary2 = mainFrame:GetChildren()
    if #temporary2 > notification.MaxNotifications then
        return false
    end
    temporary2 = {error = "9072920609", success = "9073052584", warning = "9072448788", info = "9072944922"}
    uICorner = otherValue or "error"
    notifyRef = tostring(uICorner)
    notifyRef, uICorner = notifyRef.lower, notifyRef
    notifyRef = notifyRef(uICorner)
    temporary2 = temporary2[notifyRef]
    notifyRef = Instance.new("Frame")
    notifyRef = {value = notifyRef}
    uICorner = Instance.new("UICorner")
    uIStroke = Instance.new("UIStroke")
    iconImage = Instance.new("ImageLabel")
    headTitle = Instance.new("TextLabel")
    bodyTitle = Instance.new("TextLabel")
    countdown = Instance.new("Frame")
    closeButton = Instance.new("ImageButton")
    notifyRef.value.Name = "Notify"
    notifyRef.value.Parent = mainFrame
    notifyRef.value.BackgroundColor3 = theme.Themes.SectionColor
    notifyRef.value.BackgroundTransparency = 0.5
    notifyRef.value.BorderSizePixel = 0
    notifyRef.value.ClipsDescendants = true
    animateNotificationIn = UDim2.new(0.75, 0, 0, 0)
    notifyRef.value.Size = animateNotificationIn
    animateNotificationIn = UDim.new(0, 10)
    uICorner.CornerRadius = animateNotificationIn
    uICorner.Parent = notifyRef.value
    uIStroke.Color = accentColor
    uIStroke.Transparency = 0.5
    uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uIStroke.Parent = notifyRef.value
    iconImage.Name = "IconImage"
    iconImage.Parent = notifyRef.value
    animateNotificationIn = Vector2.new(0.5, 0.5)
    iconImage.AnchorPoint = animateNotificationIn
    iconImage.BackgroundTransparency = 1
    iconImage.BorderSizePixel = 0
    animateNotificationIn = UDim2.new(0.0549999997, 0, 0.5, 0)
    iconImage.Position = animateNotificationIn
    animateNotificationIn = UDim2.new(0.850000024, 0, 0.850000024, 0)
    iconImage.Size = animateNotificationIn
    iconImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    iconImage.ZIndex = 5
    spawn = tostring(temporary2)
    iconImage.Image = "rbxassetid://" .. spawn
    iconImage.ImageTransparency = 1
    iconImage.ImageColor3 = theme.Themes.MainColor
    headTitle.Name = "HeadTitle"
    headTitle.Parent = notifyRef.value
    headTitle.BackgroundTransparency = 1
    headTitle.BorderSizePixel = 0
    animateNotificationIn = UDim2.new(0.130612239, 0, 0.0750002638, 0)
    headTitle.Position = animateNotificationIn
    animateNotificationIn = UDim2.new(0.738775492, 0, 0.369384199, 0)
    headTitle.Size = animateNotificationIn
    headTitle.ZIndex = 7
    headTitle.Font = Enum.Font.SourceSansSemibold
    animateNotificationIn = otherValue2 or "Head"
    headTitle.Text = animateNotificationIn
    animateNotificationIn = Color3.fromRGB(255, 255, 255)
    headTitle.TextColor3 = animateNotificationIn
    headTitle.TextScaled = true
    headTitle.TextSize = 14
    headTitle.TextWrapped = true
    headTitle.TextXAlignment = Enum.TextXAlignment.Left
    headTitle.TextTransparency = 1
    bodyTitle.Name = "BodyTitle"
    bodyTitle.Parent = notifyRef.value
    bodyTitle.BackgroundTransparency = 1
    bodyTitle.BorderSizePixel = 0
    animateNotificationIn = UDim2.new(0.130612239, 0, 0.444384605, 0)
    bodyTitle.Position = animateNotificationIn
    animateNotificationIn = UDim2.new(0.738775492, 0, 0.47554332, 0)
    bodyTitle.Size = animateNotificationIn
    bodyTitle.ZIndex = 7
    bodyTitle.Font = Enum.Font.SourceSansSemibold
    animateNotificationIn = otherValue3 or "Body"
    bodyTitle.Text = animateNotificationIn
    animateNotificationIn = Color3.fromRGB(255, 255, 255)
    bodyTitle.TextColor3 = animateNotificationIn
    bodyTitle.TextScaled = true
    bodyTitle.TextSize = 14
    bodyTitle.TextTransparency = 1
    bodyTitle.TextWrapped = true
    bodyTitle.TextXAlignment = Enum.TextXAlignment.Left
    countdown.Name = "Countdown"
    countdown.Parent = notifyRef.value
    animateNotificationIn = Vector2.new(0, 1)
    countdown.AnchorPoint = animateNotificationIn
    countdown.BackgroundColor3 = theme.Themes.MainColor
    countdown.BorderSizePixel = 0
    animateNotificationIn = UDim2.new(0, 0, 1.07500005, 0)
    countdown.Position = animateNotificationIn
    animateNotificationIn = UDim2.new(0, 0, 0.100000001, 0)
    countdown.Size = animateNotificationIn
    countdown.ZIndex = 6
    countdown.BackgroundTransparency = 1
    closeButton.Name = "CloseButton"
    closeButton.Parent = notifyRef.value
    animateNotificationIn = Vector2.new(0.5, 0.5)
    closeButton.AnchorPoint = animateNotificationIn
    closeButton.BackgroundTransparency = 1
    closeButton.BorderSizePixel = 0
    animateNotificationIn = UDim2.new(0.939999998, 0, 0.5, 0)
    closeButton.Position = animateNotificationIn
    animateNotificationIn = UDim2.new(0.550000012, 0, 0.550000012, 0)
    closeButton.Size = animateNotificationIn
    closeButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
    closeButton.ZIndex = 5
    closeButton.Image = "rbxassetid://9127564477"
    animateNotificationOutRef = Enum.ScaleType
    closeButton.ScaleType = Enum.ScaleType.Fit
    closeButton.ImageTransparency = 1
    animateNotificationIn = bind(Handlers.animateNotificationIn, headTitle, countdown, closeButton, tweenService, uIStroke, notifyRef, bodyTitle, iconImage)
    animateNotificationOutRef = {value = bind(Handlers.animateNotificationOut, headTitle, countdown, closeButton, tweenService, uIStroke, notifyRef, bodyTitle, iconImage)}
    animateNotificationIn()
    spawn = task.spawn
    connectNotificationLifetime = bind(Handlers.connectNotificationLifetime, countdown, animateNotificationOutRef, tweenService, closeButton, otherValue4)
    spawn(connectNotificationLifetime)
    return
end

function Handlers.onDropdownInputChanged(positionRef, setSliderValueRef, value)
    local result
    if positionRef.value then
        result = value.UserInputType == Enum.UserInputType.MouseMovement or value.UserInputType == Enum.UserInputType.Touch
        if result then
            setSliderValueRef.value(value)
        end
    end
    return
end

-- Dispatch key presses to spam, trigger, and curve actions.
function Handlers.onKeybindInputBegan(context, input, gameProcessed)
    local result, refreshCurvePanel2, styleFloatingButton2, keyCode, config2, temporary6, config3
    local encodeAndWriteConfig, temporary9
    if gameProcessed then
        return
    end
    if not context.parryRemoteRef.value then
        return
    end
    keyCode = input.KeyCode
    config2 = context.keybinds.spam ~= nil and context.keybinds.spam ~= context.selectedKey
    styleFloatingButton2 = config2 and input.KeyCode == context.keybinds.spam
    if styleFloatingButton2 then
        context.ballTargetedPlayerRef.value, styleFloatingButton2 = not context.ballTargetedPlayerRef.value, context.styleFloatingButtonRef.value
        styleFloatingButton2(context.ballTargetedPlayerRef.value, context.spamButtonRef.value, context.spamStroke, context.spamLabel)
        return
    end
    config2 = context.keybinds.trigger ~= nil and context.keybinds.trigger ~= context.selectedKey
    styleFloatingButton2 = config2 and input.KeyCode == context.keybinds.trigger
    if styleFloatingButton2 then
        config3 = context.config
        context.config.trigger = not context.config.trigger
        context.styleFloatingButtonRef.value(config3.trigger, context.triggerButtonRef.value, context.triggerLabel, context.triggerStroke)
        context.saveConfigRef.value()
        return
    end
    styleFloatingButton2, temporary6, config2 = pairs(context.keybinds.curve)
    styleFloatingButton2, temporary6, config2 = normalizeIterator(styleFloatingButton2, temporary6, config2)
    config3, result = styleFloatingButton2(temporary6, config2)
    config2 = config3
    if not (config3 == nil) then
        while true do
            temporary9 = result ~= nil and result ~= context.selectedKey
            refreshCurvePanel2 = temporary9 and result == keyCode
            if refreshCurvePanel2 then
                context.config.curveType = config3
                refreshCurvePanel2, context.selectedCurveRef.value = context.refreshCurvePanelRef.value, config3
                refreshCurvePanel2()
                context.refreshKeybindPanelRef.value()
                if writefile then
                    if context.config.saveButtonPositions then
                        encodeAndWriteConfig = bind(Handlers.encodeAndWriteConfig, context.config, context.httpService)
                        pcall(encodeAndWriteConfig)
                    end
                end
                break
            else
                config3, result = styleFloatingButton2(temporary6, config2)
                config2 = config3
                if config3 == nil then
                    break
                else
                    continue
                end
            end
            break
        end
    end
    return
end

function Handlers.onSliderDragInputChanged(draggingRef, connectRef, updateWindowDragRef, value)
    local result
    result = value.UserInputType == Enum.UserInputType.MouseMovement or value.UserInputType == Enum.UserInputType.Touch
    if result then
        result = draggingRef.value and not connectRef.value
        if result then
            updateWindowDragRef.value(value)
        end
    end
    return
end

function Handlers.onSliderFocusChanged(labelText, setSliderValueRef, tweenService, positionRef, value)
    local labelText2, tweenService2, temporary3, tweenInfo, tweenService3
    tweenService3 = value.UserInputType == Enum.UserInputType.MouseButton1 or value.UserInputType == Enum.UserInputType.Touch
    if tweenService3 then
        tweenService3, positionRef.value = setSliderValueRef.value, true
        tweenService3(value)
        labelText2, tweenService3 = labelText, tweenService
        tweenInfo = TweenInfo.new(0.1)
        temporary3 = {}
        temporary3.TextTransparency = 0
        tweenService2, tweenService3 = tweenService3, tweenService3.Create
        tweenService3 = tweenService3(tweenService2, labelText2, tweenInfo, temporary3)
        tweenService2, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService2)
    end
    return
end

function Handlers.onTextBoxFocusChanged(positionRef, tweenService, labelText, value)
    local tweenInfo, temporary2, labelText2, tweenService2, tweenService3
    tweenService2 = value.UserInputType == Enum.UserInputType.MouseButton1 or value.UserInputType == Enum.UserInputType.Touch
    if tweenService2 then
        positionRef.value, tweenService2, labelText2 = false, tweenService, labelText
        tweenInfo = TweenInfo.new(0.1)
        temporary2 = {}
        temporary2.TextTransparency = 0.3
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, labelText2, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

-- Update per-ball state and react to ball targeting changes.
function Handlers.onTrackedBallFrame(context, ball)
    local aeroDynamicSlashVFX, vectorVelocity, temporary3, temporary4, accuracy, magnitude, removeBallEffect
    local runtime, min, temporary10, temporary11, zoomies, temporary13, temporary14
    local magnitude2, temporary16, temporary17, ballTargetedPlayer2
    ballTargetedPlayer2 = not context.config.parry
    if context.config.parry then
        ballTargetedPlayer2 = context.ballTargetedPlayerRef.value
    end
    if not ballTargetedPlayer2 then
        ballTargetedPlayer2 = context.ballPresentRef.value
    end
    if ballTargetedPlayer2 then
        return
    end
    ballTargetedPlayer2 = ball:GetDebugId()
    zoomies = ball:GetAttribute("target")
    temporary13 = zoomies ~= context.localPlayerRef.value.Name or context.ballTargetTimesRef.value[ballTargetedPlayer2]
    if temporary13 then
        return
    end
    temporary13 = context.localPlayerRef.value.Character and (context.localPlayerRef.value.Character:FindFirstChild("HumanoidRootPart") or context.localPlayerRef.value.Character.PrimaryPart)
    if not temporary13 then
        return
    end
    zoomies = ball:FindFirstChild("zoomies")
    if not zoomies then
        return
    end
    aeroDynamicSlashVFX = ball:FindFirstChild("AeroDynamicSlashVFX")
    if aeroDynamicSlashVFX then
        removeBallEffect = bind(Handlers.removeBallEffect, context.debris, aeroDynamicSlashVFX)
        pcall(removeBallEffect)
        runtime = context.getBallCurveStateRef.value(ball)
        removeBallEffect = tick()
        runtime.AerodynamicTime = removeBallEffect
    end
    runtime = workspace:FindFirstChild("Runtime")
    removeBallEffect = runtime and runtime:FindFirstChild("Tornado")
    if removeBallEffect then
        vectorVelocity = context.ballCurveStates[ballTargetedPlayer2]
        temporary16 = context.ballCurveStates[ballTargetedPlayer2] and context.ballCurveStates[ballTargetedPlayer2].AerodynamicTime
        if temporary16 then
            temporary16 = removeBallEffect:GetAttribute("TornadoTime") or 0
            temporary17 = tick()
            if temporary17 - vectorVelocity.AerodynamicTime < temporary16 + 0.314159 then
                return
            end
            vectorVelocity = zoomies.VectorVelocity
            magnitude = context.remoteConnections[ball] or ball.Position
            magnitude = (temporary13.Position - magnitude).Magnitude
            temporary17 = context.getPingRef.value()
            temporary4 = math.clamp(temporary17 / 10 / 10, 5, 17)
            magnitude2 = vectorVelocity.Magnitude
            min = math.min
            accuracy = math.max(vectorVelocity.Magnitude - 9.5, 0)
            min = min(accuracy, 650)
            accuracy = context.config.accuracy
            if context.config.autoAccuracy then
                temporary14 = math.clamp((temporary17 - 60) * 0.35, -25, 35)
                accuracy = accuracy - temporary14
                temporary14 = math.clamp(accuracy, 0, 100)
                accuracy = temporary14
            end
            temporary3 = math.max(magnitude2 / ((2.4 + min * 0.002) * (0.5 + (accuracy - 1) * 0.010101010101010102)), 9.5)
            temporary10 = temporary4 + temporary3
            temporary3 = context.isBallCurvingRef.value(ball, vectorVelocity, magnitude2, magnitude, temporary13.Position, temporary17)
            if temporary3 then
                return
            end
            temporary11 = ball:GetAttribute("target")
            temporary3 = temporary11 == context.localPlayerRef.value.Name and magnitude <= temporary10
            if temporary3 then
                context.ballTargetTimesRef.value[ballTargetedPlayer2] = true
                context.trackBallRef.value(ball)
            end
            return
        end
    end
    vectorVelocity = zoomies.VectorVelocity
    magnitude = context.remoteConnections[ball] or ball.Position
    magnitude = (temporary13.Position - magnitude).Magnitude
    temporary17 = context.getPingRef.value()
    temporary4 = math.clamp(temporary17 / 10 / 10, 5, 17)
    magnitude2 = vectorVelocity.Magnitude
    min = math.min
    accuracy = math.max(vectorVelocity.Magnitude - 9.5, 0)
    min = min(accuracy, 650)
    accuracy = context.config.accuracy
    if context.config.autoAccuracy then
        temporary14 = math.clamp((temporary17 - 60) * 0.35, -25, 35)
        accuracy = accuracy - temporary14
        temporary14 = math.clamp(accuracy, 0, 100)
        accuracy = temporary14
    end
    temporary3 = math.max(magnitude2 / ((2.4 + min * 0.002) * (0.5 + (accuracy - 1) * 0.010101010101010102)), 9.5)
    temporary10 = temporary4 + temporary3
    temporary3 = context.isBallCurvingRef.value(ball, vectorVelocity, magnitude2, magnitude, temporary13.Position, temporary17)
    if temporary3 then
        return
    end
    temporary11 = ball:GetAttribute("target")
    temporary3 = temporary11 == context.localPlayerRef.value.Name and magnitude <= temporary10
    if temporary3 then
        context.ballTargetTimesRef.value[ballTargetedPlayer2] = true
        context.trackBallRef.value(ball)
    end
    return
end

function Handlers.onWindowDragInputChanged(draggingRef, updateSliderDragRef, value)
    local result
    result = value.UserInputType == Enum.UserInputType.MouseMovement or value.UserInputType == Enum.UserInputType.Touch
    if result then
        if draggingRef.value then
            updateSliderDragRef.value(value)
        end
    end
    return
end

function Handlers.parseSavedKeyCode(selectedKey, value)
    local result
    result = type(value)
    if result ~= "string" then
        return nil
    end
    result = value == "NONE" or value == "None"
    if result then
        return selectedKey
    end
    return Enum.KeyCode[value]
end

function Handlers.positionDropdown(curveOptionsPanelRef, value)
    local curveOptionsPanel2, position
    if curveOptionsPanelRef.value then
        curveOptionsPanel2 = curveOptionsPanelRef.value
        position = UDim2.new(value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset + 48)
        curveOptionsPanel2.Position = position
    end
    return
end

function Handlers.positionKeybindPanel(keyOptionsPopupRef, keyCaptureActiveRef, value)
    local keyOptionsPopup2, position
    keyOptionsPopup2 = keyOptionsPopupRef.value and keyCaptureActiveRef.value
    if keyOptionsPopup2 then
        keyOptionsPopup2 = keyOptionsPopupRef.value
        position = UDim2.new(value.X.Scale, value.X.Offset + 228, value.Y.Scale, value.Y.Offset)
        keyOptionsPopup2.Position = position
    end
    return
end

function Handlers.rebuildDropdownItems(noopDropdownRef, valueText, noopDropdownRef2, downBar, updateLabelRef, noopDropdownRef3)
    local result, temporary2, mouseButton1Click, selectDropdownItem, temporary5Ref, temporary6, temporary7
    local mouseButton1Click2, temporary9
    temporary9 = packValues(downBar:GetChildren())
    temporary6, temporary9, temporary7 = ipairs(unpackValues(temporary9))
    temporary6, temporary9, temporary7 = normalizeIterator(temporary6, temporary9, temporary7)
    for index, item in temporary6, temporary9, temporary7 do
        result, temporary5Ref, temporary7 = index, item, index
        temporary2 = temporary5Ref:isA("TextButton")
        if temporary2 then
            temporary5Ref:Destroy()
        end
    end
    result, temporary5Ref, temporary7 = nil, nil, nil
    temporary6, temporary9, temporary7 = ipairs(noopDropdownRef3.value)
    temporary6, temporary9, temporary7 = normalizeIterator(temporary6, temporary9, temporary7)
    for index2, item2 in temporary6, temporary9, temporary7 do
        result, temporary5Ref, temporary7 = index2, item2, index2
        temporary5Ref = {value = temporary5Ref}
        temporary2 = updateLabelRef.value()
        mouseButton1Click = tostring(temporary5Ref.value)
        temporary2.Text = mouseButton1Click
        mouseButton1Click, selectDropdownItem = temporary2.MouseButton1Click, bind(Handlers.selectDropdownItem, noopDropdownRef, temporary5Ref, noopDropdownRef2, valueText)
        mouseButton1Click, mouseButton1Click2 = mouseButton1Click.Connect, mouseButton1Click
        mouseButton1Click(mouseButton1Click2, selectDropdownItem)
    end
    result, temporary5Ref, temporary7 = nil, nil, nil
    return
end

function Handlers.refreshCurveWindow(curveRows, textColor, accentColorRef, curveDropdownButtonRef, curveOptionsPanelRef, selectedCurveRef, tweenService)
    local label, tweenService2, temporary3, tweenService3, tweenInfo, temporary6, temporary7
    local temporary8, temporary9, curveDropdownButton2, temporary11
    if not curveDropdownButtonRef.value then
        return
    end
    curveDropdownButton2 = curveDropdownButtonRef.value
    temporary11 = string.upper(selectedCurveRef.value)
    curveDropdownButton2.Text = "CURVE: " .. temporary11
    if curveOptionsPanelRef.value then
        curveDropdownButton2, temporary8, temporary6 = pairs(curveRows)
        curveDropdownButton2, temporary8, temporary6 = normalizeIterator(curveDropdownButton2, temporary8, temporary6)
        for index, item in curveDropdownButton2, temporary8, temporary6 do
            temporary11, temporary9, temporary6 = index, item, index
            if temporary11 == selectedCurveRef.value then
                tweenService2, label = tweenService, temporary9.label
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.TextColor3 = textColor
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2 = tweenService
                label = temporary9.stroke
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.Transparency = 0
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2, label = tweenService, temporary9.iconStroke
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.Color = textColor
                temporary3.Transparency = 0
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2 = tweenService
                label = temporary9.dot
                tweenInfo = TweenInfo.new(0.3)
                temporary3 = {}
                temporary7 = Color3.fromRGB(0, 220, 90)
                temporary3.BackgroundColor3 = temporary7
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService2, tweenService3 = tweenService2.Play, tweenService2
                tweenService2(tweenService3)
            else
                tweenService2, label = tweenService, temporary9.label
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.TextColor3 = accentColorRef.value
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2 = tweenService
                label = temporary9.stroke
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.Transparency = 0.6
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                label, tweenService2 = temporary9.iconStroke, tweenService
                tweenInfo = TweenInfo.new(0.4)
                temporary3 = {}
                temporary3.Color = accentColorRef.value
                temporary3.Transparency = 0.4
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2 = tweenService
                label = temporary9.dot
                tweenInfo = TweenInfo.new(0.3)
                temporary3 = {}
                temporary7 = Color3.fromRGB(70, 70, 70)
                temporary3.BackgroundColor3 = temporary7
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService2, tweenService3 = tweenService2.Play, tweenService2
                tweenService2(tweenService3)
            end
        end
        temporary11, temporary9, temporary6 = nil, nil, nil
    end
    return
end

function Handlers.refreshDropdownButtonStates(downBar)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    temporary5 = 0
    result = packValues(downBar:GetChildren())
    temporary2, result, temporary3 = ipairs(unpackValues(result))
    temporary2, result, temporary3 = normalizeIterator(temporary2, result, temporary3)
    for index, item in temporary2, result, temporary3 do
        temporary4, temporary6, temporary3 = index, item, index
        temporary7 = temporary6:isA("TextButton")
        if temporary7 then
            temporary5 = temporary5 + 9
        end
    end
    temporary4, temporary6, temporary3 = nil, nil, nil
    return temporary5 + 15
end

function Handlers.refreshDropdownItems(noopDropdownRef, rebuildDropdownItemsRef, value, otherValue)
    local rebuildDropdownItems2
    rebuildDropdownItems2 = otherValue or noopDropdownRef.value
    rebuildDropdownItems2, noopDropdownRef.value = rebuildDropdownItemsRef.value, rebuildDropdownItems2
    rebuildDropdownItems2()
    return
end

-- Refresh key labels, highlights, and the active capture state.
function Handlers.refreshKeybindingWindow(context)
    local tweenService2, temporary2, temporary3, temporary4, temporary5, spamKeyButton2, label
    local temporary8, tweenInfo, temporary10, temporary11, tweenService3
    if context.spamKeyButtonRef.value then
        temporary10 = context.keybinds.spam ~= nil and context.keybinds.spam ~= context.selectedKey
        if temporary10 then
            spamKeyButton2 = context.spamKeyButtonRef.value
            context.spamKeyButtonRef.value.Text = context.keybinds.spam.Name
            spamKeyButton2.TextColor3 = context.textColor
        else
            spamKeyButton2 = context.spamKeyButtonRef.value
            context.spamKeyButtonRef.value.Text = "NONE"
            spamKeyButton2.TextColor3 = context.mutedTextColor
        end
    end
    if context.triggerKeyButtonRef.value then
        temporary10 = context.keybinds.trigger ~= nil and context.keybinds.trigger ~= context.selectedKey
        if temporary10 then
            spamKeyButton2 = context.triggerKeyButtonRef.value
            context.triggerKeyButtonRef.value.Text = context.keybinds.trigger.Name
            spamKeyButton2.TextColor3 = context.textColor
        else
            spamKeyButton2 = context.triggerKeyButtonRef.value
            context.triggerKeyButtonRef.value.Text = "NONE"
            spamKeyButton2.TextColor3 = context.mutedTextColor
        end
    end
    spamKeyButton2, temporary8, temporary10 = pairs(context.curveKeyRowsRef.value)
    spamKeyButton2, temporary8, temporary10 = normalizeIterator(spamKeyButton2, temporary8, temporary10)
    for index, item in spamKeyButton2, temporary8, temporary10 do
        temporary2, temporary4, temporary10 = index, item, index
        tweenService3 = context.keybinds.curve[temporary2] ~= nil and context.keybinds.curve[temporary2] ~= context.selectedKey
        if tweenService3 then
            temporary4.keyBtn.Text = context.keybinds.curve[temporary2].Name
            temporary4.keyBtn.TextColor3 = context.textColor
        else
            temporary4.keyBtn.Text = "NONE"
            temporary4.keyBtn.TextColor3 = context.mutedTextColor
        end
        if context.config.curveType == temporary2 then
            tweenService2 = temporary4.rowStroke
            tweenService3 = Color3.fromRGB(0, 220, 90)
            tweenService2.Color = tweenService3
            temporary4.rowStroke.Transparency = 0.1
        else
            temporary4.rowStroke.Color = context.accentColorRef.value
            temporary4.rowStroke.Transparency = 0.6
        end
    end
    temporary2, temporary4, temporary10 = nil, nil, nil
    if context.curveDropdownButtonRef.value then
        temporary8 = context.keybindPanelOpenRef.value and "\226\150\188" or "\226\150\182"
        context.curveDropdownButtonRef.value.Text = temporary8
    end
    spamKeyButton2, temporary8, temporary10 = pairs(context.keyOptionRowsRef.value)
    spamKeyButton2, temporary8, temporary10 = normalizeIterator(spamKeyButton2, temporary8, temporary10)
    temporary2, temporary4 = spamKeyButton2(temporary8, temporary10)
    temporary10 = temporary2
    if not (temporary2 == nil) then
        while true do
            temporary5 = false
            if context.pendingKeybindRef.value then
                tweenService2 = nil
                if context.pendingKeybindRef.value.kind == "spam" then
                    tweenService2 = context.keybinds.spam
                else
                    if context.pendingKeybindRef.value.kind == "trigger" then
                        tweenService2 = context.keybinds.trigger
                    else
                        if context.pendingKeybindRef.value.kind == "curve" then
                            tweenService2 = context.keybinds.curve[context.pendingKeybindRef.value.name]
                        end
                    end
                end
                if temporary2 == "NONE" then
                    tweenInfo = tweenService2 ~= nil and tweenService2 ~= context.selectedKey
                    temporary5 = not tweenInfo
                else
                    if tweenService2 ~= nil then
                        tweenService3 = tweenService2 ~= context.selectedKey and tweenService2.Name == temporary2
                        if tweenService3 then
                            tweenService2, label = context.tweenService, temporary4.label
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.TextColor3 = context.textColor
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService2, tweenService3 = tweenService2.Play, tweenService2
                            tweenService2(tweenService3)
                            tweenService2 = context.tweenService
                            label = temporary4.stroke
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Transparency = 0
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.iconStroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Color = context.textColor
                            temporary3.Transparency = 0
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            tweenService2 = context.tweenService
                            label = temporary4.dot
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = Color3.fromRGB(0, 220, 90)
                            temporary3.BackgroundColor3 = temporary11
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                        else
                            label, tweenService2 = temporary4.label, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = temporary2 == "NONE" and context.mutedTextColor or context.accentColorRef.value
                            temporary3.TextColor3 = temporary11
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService2, tweenService3 = tweenService2.Play, tweenService2
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.stroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Transparency = 0.6
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.iconStroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Color = context.accentColorRef.value
                            temporary3.Transparency = 0.4
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.dot, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = Color3.fromRGB(70, 70, 70)
                            temporary3.BackgroundColor3 = temporary11
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                        end
                        temporary2, temporary4 = spamKeyButton2(temporary8, temporary10)
                        temporary10 = temporary2
                        if temporary2 == nil then
                            break
                        else
                            continue
                        end
                    else
                        tweenService3 = tweenService2 ~= nil and tweenService2.Name == temporary2
                        if tweenService3 then
                            tweenService2, label = context.tweenService, temporary4.label
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.TextColor3 = context.textColor
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService2, tweenService3 = tweenService2.Play, tweenService2
                            tweenService2(tweenService3)
                            tweenService2 = context.tweenService
                            label = temporary4.stroke
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Transparency = 0
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.iconStroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Color = context.textColor
                            temporary3.Transparency = 0
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            tweenService2 = context.tweenService
                            label = temporary4.dot
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = Color3.fromRGB(0, 220, 90)
                            temporary3.BackgroundColor3 = temporary11
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                        else
                            label, tweenService2 = temporary4.label, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = temporary2 == "NONE" and context.mutedTextColor or context.accentColorRef.value
                            temporary3.TextColor3 = temporary11
                            tweenService2, tweenService3 = tweenService2.Create, tweenService2
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService2, tweenService3 = tweenService2.Play, tweenService2
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.stroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Transparency = 0.6
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.iconStroke, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary3.Color = context.accentColorRef.value
                            temporary3.Transparency = 0.4
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                            label, tweenService2 = temporary4.dot, context.tweenService
                            tweenInfo = TweenInfo.new(0.2)
                            temporary3 = {}
                            temporary11 = Color3.fromRGB(70, 70, 70)
                            temporary3.BackgroundColor3 = temporary11
                            tweenService3, tweenService2 = tweenService2, tweenService2.Create
                            tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                            tweenService3, tweenService2 = tweenService2, tweenService2.Play
                            tweenService2(tweenService3)
                        end
                        temporary2, temporary4 = spamKeyButton2(temporary8, temporary10)
                        temporary10 = temporary2
                        if temporary2 == nil then
                            break
                        else
                            continue
                        end
                    end
                end
            end
            if temporary5 then
                tweenService2, label = context.tweenService, temporary4.label
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary3.TextColor3 = context.textColor
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService2, tweenService3 = tweenService2.Play, tweenService2
                tweenService2(tweenService3)
                tweenService2 = context.tweenService
                label = temporary4.stroke
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary3.Transparency = 0
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                label, tweenService2 = temporary4.iconStroke, context.tweenService
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary3.Color = context.textColor
                temporary3.Transparency = 0
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                tweenService2 = context.tweenService
                label = temporary4.dot
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary11 = Color3.fromRGB(0, 220, 90)
                temporary3.BackgroundColor3 = temporary11
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
            else
                label, tweenService2 = temporary4.label, context.tweenService
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary11 = temporary2 == "NONE" and context.mutedTextColor or context.accentColorRef.value
                temporary3.TextColor3 = temporary11
                tweenService2, tweenService3 = tweenService2.Create, tweenService2
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService2, tweenService3 = tweenService2.Play, tweenService2
                tweenService2(tweenService3)
                label, tweenService2 = temporary4.stroke, context.tweenService
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary3.Transparency = 0.6
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                label, tweenService2 = temporary4.iconStroke, context.tweenService
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary3.Color = context.accentColorRef.value
                temporary3.Transparency = 0.4
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
                label, tweenService2 = temporary4.dot, context.tweenService
                tweenInfo = TweenInfo.new(0.2)
                temporary3 = {}
                temporary11 = Color3.fromRGB(70, 70, 70)
                temporary3.BackgroundColor3 = temporary11
                tweenService3, tweenService2 = tweenService2, tweenService2.Create
                tweenService2 = tweenService2(tweenService3, label, tweenInfo, temporary3)
                tweenService3, tweenService2 = tweenService2, tweenService2.Play
                tweenService2(tweenService3)
            end
            temporary2, temporary4 = spamKeyButton2(temporary8, temporary10)
            temporary10 = temporary2
            if temporary2 == nil then
                break
            else
                continue
            end
        end
    end
    return
end

function Handlers.rememberDragPosition(positionRef, draggingRef, initialPositionRef, dragInputRef, dragStartRef, value)
    local position2, temporary2
    temporary2 = value == dragInputRef.value and draggingRef.value
    if temporary2 then
        position2 = UDim2.new(initialPositionRef.value.X.Scale, initialPositionRef.value.X.Offset + (value.Position - dragStartRef.value).X, initialPositionRef.value.Y.Scale, initialPositionRef.value.Y.Offset + (value.Position - dragStartRef.value).Y)
        positionRef.value = position2
    end
    return
end

function Handlers.rememberDropdownValue(contentHeightRef, panelRef)
    contentHeightRef.value = contentHeightRef.value + panelRef.value.AbsoluteSize.Y * 1.2
    return
end

function Handlers.resetFramePositions(config, dragConnectionsRef, saveConfigRef)
    local result, temporary2, temporary3, temporary4, temporary5
    result = {}
    config.buttonPositions = result
    temporary2, temporary4, result = pairs(dragConnectionsRef.value)
    temporary2, temporary4, result = normalizeIterator(temporary2, temporary4, result)
    for index, item in temporary2, temporary4, result do
        temporary3, temporary5, result = index, item, index
        pcall(temporary5)
    end
    temporary3, temporary5, result = nil, nil, nil
    saveConfigRef.value()
    return
end

function Handlers.resizeKeybindText(brindText, valueText, tweenService, textService)
    local brindText2, tweenService2, tweenService3, tweenInfo, temporary5, textService2, position
    textService2 = textService
    tweenService3 = valueText.Text
    brindText2 = valueText.TextSize
    tweenInfo = valueText.Font
    temporary5 = packValues(Vector2.new(math.huge, math.huge))
    textService2, tweenService2 = textService2.GetTextSize, textService2
    textService2 = textService2(tweenService2, tweenService3, brindText2, tweenInfo, unpackValues(temporary5))
    brindText2, tweenService2 = brindText, tweenService
    tweenInfo = TweenInfo.new(0.2)
    temporary5 = {}
    position = UDim2.new(0, textService2.X + 1, 0.550000012, 0)
    temporary5.Size = position
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, brindText2, tweenInfo, temporary5)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    return
end

function Handlers.resizeSectionToContent(sectionRef, tweenServiceRef, tweenServiceRef2, value)
    local panelRef, tweenService2, tweenInfo, position, temporary5Ref, setSectionLayoutDirty, tweenService3
    local section2
    if not value then
        temporary5Ref = sectionRef.value.Visible and tweenServiceRef.value
        if temporary5Ref then
            temporary5Ref = {value = 1}
            tweenService3 = packValues(sectionRef.value:GetChildren())
            tweenService2, tweenService3, section2 = ipairs(unpackValues(tweenService3))
            tweenService2, tweenService3, section2 = normalizeIterator(tweenService2, tweenService3, section2)
            for index, item in tweenService2, tweenService3, section2 do
                tweenInfo, panelRef, section2 = index, item, index
                panelRef = {value = panelRef}
                position = panelRef.value:IsA("Frame") or panelRef.value:IsA("TextLabel")
                if position then
                    if panelRef.value.Visible then
                        setSectionLayoutDirty = bind(Handlers.setSectionLayoutDirty, temporary5Ref, panelRef)
                        pcall(setSectionLayoutDirty)
                    end
                end
            end
            tweenInfo, panelRef, section2 = nil, nil, nil
            section2, tweenService2 = sectionRef.value, tweenServiceRef2
            tweenInfo = TweenInfo.new(0.2)
            panelRef = {}
            position = UDim2.new(0.97, 0, 0, 15 + temporary5Ref.value)
            panelRef.Size = position
            tweenService2, tweenService3 = tweenService2.Create, tweenService2
            tweenService2 = tweenService2(tweenService3, section2, tweenInfo, panelRef)
            tweenService3, tweenService2 = tweenService2, tweenService2.Play
            tweenService2(tweenService3)
        end
    else
        temporary5Ref = {value = 1}
        tweenService3 = packValues(sectionRef.value:GetChildren())
        tweenService2, tweenService3, section2 = ipairs(unpackValues(tweenService3))
        tweenService2, tweenService3, section2 = normalizeIterator(tweenService2, tweenService3, section2)
        for index2, item2 in tweenService2, tweenService3, section2 do
            tweenInfo, panelRef, section2 = index2, item2, index2
            panelRef = {value = panelRef}
            position = panelRef.value:IsA("Frame") or panelRef.value:IsA("TextLabel")
            if position then
                if panelRef.value.Visible then
                    setSectionLayoutDirty = bind(Handlers.rememberDropdownValue, temporary5Ref, panelRef)
                    pcall(setSectionLayoutDirty)
                end
            end
        end
        tweenInfo, panelRef, section2 = nil, nil, nil
        tweenService2, section2 = tweenServiceRef2, sectionRef.value
        tweenInfo = TweenInfo.new(0.2)
        panelRef = {}
        position = UDim2.new(0.97, 0, 0, 15 + temporary5Ref.value)
        panelRef.Size = position
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, section2, tweenInfo, panelRef)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

function Handlers.runUiRefreshCallbacks(theme)
    local result, temporary2, temporary3, temporary4, temporary5
    result, temporary4, temporary5 = ipairs(theme.auto_function)
    result, temporary4, temporary5 = normalizeIterator(result, temporary4, temporary5)
    for index, item in result, temporary4, temporary5 do
        temporary2, temporary3, temporary5 = index, item, index
        pcall(temporary3)
    end
    temporary2, temporary3, temporary5 = nil, nil, nil
    return
end

function Handlers.runUiRefreshLoop(theme)
    local runUiRefreshCallbacks
    _G.index_neverlose = true
    while true do
        if _G.index_neverlose then
            task.wait(0.25)
            runUiRefreshCallbacks = bind(Handlers.runUiRefreshCallbacks, theme)
            pcall(runUiRefreshCallbacks)
            continue
        else
            break
        end
    end
    return
end

function Handlers.saveFramePosition(config, draggingRef, positionedObject, input, onPositionChanged)
    local positionedObject2, onPositionChanged2, temporary3, temporary4, onPositionChanged3
    if input.UserInputState == Enum.UserInputState.End then
        onPositionChanged3, draggingRef.value = onPositionChanged, false
        if onPositionChanged3 then
            onPositionChanged3 = config.saveButtonPositions
        end
        if onPositionChanged3 then
            onPositionChanged2, onPositionChanged3, positionedObject2, temporary4, temporary3 = onPositionChanged, config.buttonPositions, positionedObject, {}, {}
            temporary4.S = positionedObject.Position.X.Scale
            temporary4.O = positionedObject2.Position.X.Offset
            temporary3.X = temporary4
            temporary4 = {}
            temporary4.S = positionedObject2.Position.Y.Scale
            temporary4.O = positionedObject2.Position.Y.Offset
            temporary3.Y = temporary4
            onPositionChanged3[onPositionChanged2] = temporary3
        end
    end
    return
end

function Handlers.saveKeybinds(keybinds, saveConfigRef)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    temporary2 = {}
    temporary5 = keybinds.spam and keybinds.spam.Name or "NONE"
    temporary2.spam = temporary5
    temporary5 = keybinds.trigger and keybinds.trigger.Name or "NONE"
    temporary2.trigger = temporary5
    temporary6 = {}
    temporary2.curve = temporary6
    result = temporary2
    temporary2, temporary5, temporary6 = pairs(keybinds.curve)
    temporary2, temporary5, temporary6 = normalizeIterator(temporary2, temporary5, temporary6)
    for index, item in temporary2, temporary5, temporary6 do
        temporary3, temporary4, temporary6 = index, item, index
        temporary7 = temporary4 and temporary4.Name or "NONE"
        result.curve[temporary3] = temporary7
    end
    temporary3, temporary4, temporary6 = nil, nil, nil
    _G._417_savedBinds = result
    saveConfigRef.value()
    return
end

function Handlers.scheduleRefresh(runService, self, otherValue)
    local result, waitForShopCategoryRefresh, spawn
    waitForShopCategoryRefresh = self.refresh_generation[otherValue] or 0
    self.refresh_generation[otherValue] = waitForShopCategoryRefresh + 1
    result = self.refresh_generation[otherValue]
    spawn = type(self.shop_controller._loadInventoryPage)
    if spawn == "function" then
        pcall(self.shop_controller._loadInventoryPage, otherValue)
    end
    waitForShopCategoryRefresh, spawn = bind(Handlers.waitForShopCategoryRefresh, result, otherValue, runService, self), task.spawn
    spawn(waitForShopCategoryRefresh)
    return
end

function Handlers.selectDropdownItem(noopDropdownRef, itemValueRef, itemValueRef2, valueText)
    local result, itemValue2, valueText2
    valueText2, itemValue2 = valueText, itemValueRef.value
    result = tostring(itemValueRef.value)
    valueText2.Text = result
    itemValueRef2.value = itemValue2
    noopDropdownRef.value(itemValue2)
    return
end

function Handlers.selectTab(tabButtonRef, fadeTabTitleRef, tweenService, tabRef, value, otherValue)
    local tweenInfo, tweenService2, temporary3, tab2, position, tweenService3
    if value then
        if not tabRef.value.Visible then
            task.spawn(fadeTabTitleRef.value)
            tweenService2 = tabRef.value
            tweenService3 = UDim2.new(0.5, 0, 0, 0)
            tweenService2.Position = tweenService3
            tweenService3 = UDim2.new(0.85, 0, 0, 0)
            tweenService2.Size = tweenService3
        end
        tabRef.value.Visible = true
        tab2, tweenService2 = tabRef.value, tweenService
        tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        temporary3 = {}
        position = UDim2.new(0.5, 0, 0.5, 0)
        temporary3.Position = position
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, tab2, tweenInfo, temporary3)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        temporary3 = {}
        position = UDim2.new(0.99000001, 0, 0.99000001, 0)
        temporary3.Size = position
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, tab2, tweenInfo, temporary3)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tab2, tweenService2 = tabButtonRef.value, tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary3 = {}
        temporary3.BackgroundTransparency = 0.55
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, tab2, tweenInfo, temporary3)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    else
        tabRef.value.Visible = false
        tab2, tweenService2 = tabRef.value, tweenService
        tweenInfo = TweenInfo.new(0.5)
        temporary3 = {}
        position = UDim2.new(0.5, 0, 1.5, 0)
        temporary3.Position = position
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, tab2, tweenInfo, temporary3)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tab2, tweenService2 = tabButtonRef.value, tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary3 = {}
        temporary3.BackgroundTransparency = 1
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, tab2, tweenInfo, temporary3)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    end
    return
end

function Handlers.setButtonLabelText(labelText, value, otherValue)
    local labelText2, temporary2
    labelText2 = labelText
    temporary2 = tostring(otherValue)
    labelText2.Text = temporary2
    return
end

function Handlers.setCurvePanelVisible(curveOptionsPanelRef, curveOptionsOpenRef, saveConfigRef, config, curvePanelOpenRef, showCurveUI)
    local curveOptionsPanel2
    config.showCurveUI = showCurveUI
    if curveOptionsOpenRef.value then
        curveOptionsOpenRef.value.Visible = showCurveUI
        if not showCurveUI then
            curvePanelOpenRef.value, curveOptionsPanel2 = false, curveOptionsPanelRef.value
            if curveOptionsPanel2 then
                curveOptionsPanelRef.value.Visible = false
            end
        end
    end
    saveConfigRef.value()
    return
end

function Handlers.setDragging(draggingRef, value)
    local result
    result = value.UserInputType == Enum.UserInputType.MouseMovement or value.UserInputType == Enum.UserInputType.Touch
    if result then
        draggingRef.value = value
    end
    return
end

function Handlers.setDropdownButtonStates(downBar)
    local result, temporary2, temporary3, temporary4, temporary5, temporary6, temporary7
    temporary7 = 0
    temporary5 = packValues(downBar:GetChildren())
    temporary3, temporary5, temporary4 = ipairs(unpackValues(temporary5))
    temporary3, temporary5, temporary4 = normalizeIterator(temporary3, temporary5, temporary4)
    for index, item in temporary3, temporary5, temporary4 do
        temporary6, result, temporary4 = index, item, index
        temporary2 = result:isA("TextButton")
        if temporary2 then
            temporary7 = temporary7 + result.AbsoluteSize.Y
        end
    end
    temporary6, result, temporary4 = nil, nil, nil
    return temporary7 + 15
end

function Handlers.setDropdownExpanded(labelText, refreshDropdownButtonStatesRef, updateDropdownVisibilityRef, noopDropdownRef, icon, tweenService, downBar, value)
    local tweenService2, temporary2, icon2, tweenService3, tweenService4, tweenInfo, position
    local tweenService5, tweenInfo2, temporary10
    if value then
        noopDropdownRef.value.Visible = true
        icon2, tweenService2 = icon, tweenService
        tweenInfo2 = TweenInfo.new(0.15)
        temporary2 = {}
        temporary2.Rotation = 90
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, icon2 = tweenService, labelText
        tweenInfo2 = TweenInfo.new(0.4)
        temporary2 = {}
        temporary2.TextTransparency = 0
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, icon2 = tweenService, downBar
        tweenInfo2 = TweenInfo.new(0.1)
        temporary2 = {}
        tweenService4 = UDim2.new
        temporary10 = refreshDropdownButtonStatesRef.value()
        tweenService4 = tweenService4(0.4, 0, 0, temporary10)
        temporary2.Size = tweenService4
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        updateDropdownVisibilityRef.value()
        icon2, tweenService3 = icon2, icon2.GetChildren
        tweenService3 = packValues(tweenService3(icon2))
        tweenService2, tweenService3, icon2 = ipairs(unpackValues(tweenService3))
        tweenService2, tweenService3, icon2 = normalizeIterator(tweenService2, tweenService3, icon2)
        for index, item in tweenService2, tweenService3, icon2 do
            tweenInfo2, temporary2, icon2 = index, item, index
            tweenService4 = temporary2:isA("TextButton")
            if tweenService4 then
                tweenService4 = UDim2.new(0, 0, 0, 0)
                temporary2.Size = tweenService4
                temporary2.TextTransparency = 1
                tweenService4 = tweenService
                tweenInfo = TweenInfo.new(0.01 + tweenInfo2 / 100)
                temporary10 = {}
                position = UDim2.new(0.99000001, 0, 0.5, 0)
                temporary10.Size = position
                temporary10.TextTransparency = 0.3
                tweenService5, tweenService4 = tweenService4, tweenService4.Create
                tweenService4 = tweenService4(tweenService5, temporary2, tweenInfo, temporary10)
                tweenService4, tweenService5 = tweenService4.Play, tweenService4
                tweenService4(tweenService5)
            end
        end
        tweenInfo2, temporary2, icon2 = nil, nil, nil
    else
        tweenService3 = packValues(downBar:GetChildren())
        tweenService2, tweenService3, icon2 = ipairs(unpackValues(tweenService3))
        tweenService2, tweenService3, icon2 = normalizeIterator(tweenService2, tweenService3, icon2)
        for index2, item2 in tweenService2, tweenService3, icon2 do
            tweenInfo2, temporary2, icon2 = index2, item2, index2
            tweenService4 = temporary2:isA("TextButton")
            if tweenService4 then
                temporary2.TextTransparency = 0.3
                tweenService4 = tweenService
                tweenInfo = TweenInfo.new(0.04)
                temporary10 = {}
                position = UDim2.new(0, 0, 0, 0)
                temporary10.Size = position
                temporary10.TextTransparency = 1
                tweenService5, tweenService4 = tweenService4, tweenService4.Create
                tweenService4 = tweenService4(tweenService5, temporary2, tweenInfo, temporary10)
                tweenService4, tweenService5 = tweenService4.Play, tweenService4
                tweenService4(tweenService5)
            end
        end
        tweenInfo2, temporary2, icon2 = nil, nil, nil
        tweenService2, icon2 = tweenService, icon
        tweenInfo2 = TweenInfo.new(0.15)
        temporary2 = {}
        temporary2.Rotation = -90
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        icon2 = labelText
        tweenInfo2 = TweenInfo.new(0.4)
        temporary2 = {}
        temporary2.TextTransparency = 0.3
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, icon2 = tweenService, downBar
        tweenInfo2 = TweenInfo.new(0.1)
        temporary2 = {}
        tweenService4 = UDim2.new(0.4, 0, 0, 0)
        temporary2.Size = tweenService4
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, icon2, tweenInfo2, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

function Handlers.setDropdownLabelText(labelText, value, otherValue)
    local labelText2, temporary2
    labelText2 = labelText
    temporary2 = tostring(otherValue)
    labelText2.Text = temporary2
    return
end

function Handlers.setDropdownTitleAndResize(labelText, resizeKeybindTextRef, value, otherValue)
    local result, labelText2
    labelText2 = labelText
    result = tostring(otherValue)
    labelText2.Text = result
    resizeKeybindTextRef.value()
    return
end

function Handlers.setDropdownValue(expandedRef, setDropdownExpandedRef)
    local setDropdownExpanded2
    setDropdownExpanded2, expandedRef.value = setDropdownExpandedRef.value, not expandedRef.value
    setDropdownExpanded2(expandedRef.value)
    return
end

function Handlers.setDropdownValueAndNotify(selectedValueRef, animateToggleValueRef, toggleRef, value, otherValue)
    local animateToggleValue2
    animateToggleValue2, selectedValueRef.value = animateToggleValueRef.value, otherValue
    animateToggleValue2(otherValue, 0.1)
    toggleRef.value(otherValue)
    return
end

function Handlers.setFpsPanelVisible(config, fpsPanelRef, saveConfigRef, showFpsUI)
    config.showFpsUI = showFpsUI
    fpsPanelRef.value.Visible = showFpsUI
    saveConfigRef.value()
    return
end

function Handlers.setImmortalityPanelVisible(config, immortalityPanel, saveConfigRef, showImmortalUI)
    config.showImmortalUI = showImmortalUI
    immortalityPanel.Visible = showImmortalUI
    saveConfigRef.value()
    return
end

function Handlers.setKeybindPanelVisible(keyOptionsPopupRef, refreshKeybindPanelRef, saveConfigRef, config, keyCaptureActiveRef, keybindPanelRef, pendingKeybindRef, showBindWindow)
    local keyOptionsPopup2
    config.showBindWindow = showBindWindow
    keybindPanelRef.value.Visible = showBindWindow
    if not showBindWindow then
        keyCaptureActiveRef.value, keyOptionsPopup2 = false, keyOptionsPopupRef.value
        keyOptionsPopup2.Visible = false
        pendingKeybindRef.value = nil
        refreshKeybindPanelRef.value()
    end
    saveConfigRef.value()
    return
end

function Handlers.setKeybindValue(keybindRef, selectedKeyRef, resizeKeybindTextRef, valueText, value, otherValue)
    local resizeKeybindText2, name
    if not otherValue then
        name = "None"
    else
        name = otherValue.Name
    end
    valueText.Text = name
    selectedKeyRef.value, resizeKeybindText2 = otherValue, resizeKeybindTextRef.value
    resizeKeybindText2()
    keybindRef.value(otherValue)
    return
end

function Handlers.setLabelStatus(tweenService, label, labelText, value, otherValue)
    local position, tweenInfo, tweenService2, tweenService3, temporary5, label2
    if otherValue then
        tweenService3, label2 = tweenService, label
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint)
        temporary5 = {}
        position = UDim2.new(0.899999976, 0, 0.5, 0)
        temporary5.Size = position
        tweenService3, tweenService2 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService2, label2, tweenInfo, temporary5)
        tweenService2, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService2)
        tweenService3, label2 = tweenService, labelText
        tweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Quint)
        temporary5 = {}
        temporary5.TextTransparency = 0.3
        tweenService2, tweenService3 = tweenService3, tweenService3.Create
        tweenService3 = tweenService3(tweenService2, label2, tweenInfo, temporary5)
        tweenService3, tweenService2 = tweenService3.Play, tweenService3
        tweenService3(tweenService2)
    else
        tweenService3, label2 = tweenService, label
        tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint)
        temporary5 = {}
        position = UDim2.new(0, 0, 0, 0)
        temporary5.Size = position
        tweenService2, tweenService3 = tweenService3, tweenService3.Create
        tweenService3 = tweenService3(tweenService2, label2, tweenInfo, temporary5)
        tweenService2, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService2)
        tweenService3, label2 = tweenService, labelText
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint)
        temporary5 = {}
        temporary5.TextTransparency = 1
        tweenService3, tweenService2 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService2, label2, tweenInfo, temporary5)
        tweenService3, tweenService2 = tweenService3.Play, tweenService3
        tweenService3(tweenService2)
    end
    return
end

function Handlers.setSectionExpanded(setDropdownButtonStatesRef, tweenService, downBar, expandedRef)
    local new, tweenService2, downBar2, tweenInfo, temporary5, tweenService3, temporary7
    if expandedRef.value then
        tweenService3, downBar2 = tweenService, downBar
        tweenInfo = TweenInfo.new(0.1)
        temporary5 = {}
        new = UDim2.new
        temporary7 = setDropdownButtonStatesRef.value()
        new = new(0.4, 0, 0, temporary7)
        temporary5.Size = new
        tweenService3, tweenService2 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService2, downBar2, tweenInfo, temporary5)
        tweenService2, tweenService3 = tweenService3, tweenService3.Play
        tweenService3(tweenService2)
    else
        downBar2, tweenService3 = downBar, tweenService
        tweenInfo = TweenInfo.new(0.1)
        temporary5 = {}
        new = UDim2.new(0.4, 0, 0, 0)
        temporary5.Size = new
        tweenService3, tweenService2 = tweenService3.Create, tweenService3
        tweenService3 = tweenService3(tweenService2, downBar2, tweenInfo, temporary5)
        tweenService3, tweenService2 = tweenService3.Play, tweenService3
        tweenService3(tweenService2)
    end
    return
end

function Handlers.setSectionLayoutDirty(contentHeightRef, panelRef)
    contentHeightRef.value = contentHeightRef.value + panelRef.value.AbsoluteSize.Y * 1.2
    return
end

function Handlers.setSliderLabelText(labelText, value, otherValue)
    local labelText2, temporary2
    labelText2 = labelText
    temporary2 = tostring(otherValue)
    labelText2.Text = temporary2
    return
end

function Handlers.setSliderValue(valueText, inline, noopSliderRef, moveFrame, noopSliderRef2, noopSliderRef3, tweenService, value)
    local result, temporary2, temporary3, fromScale, tweenInfo, tweenService2, inline2
    local tweenService3
    temporary3 = math.clamp((value.Position.X - moveFrame.AbsolutePosition.X) / moveFrame.AbsoluteSize.X, 0, 1)
    temporary2 = math.floor((noopSliderRef3.value - noopSliderRef2.value) * temporary3 + noopSliderRef2.value)
    fromScale = UDim2.fromScale
    tweenService3 = math.clamp(temporary3 + 0.15, 0, 1)
    fromScale = fromScale(tweenService3, 1)
    tweenService3 = valueText
    tweenService2 = tostring(temporary2)
    tweenService3.Text = tweenService2
    inline2, tweenService3 = inline, tweenService
    tweenInfo = TweenInfo.new(0.1)
    result = {}
    result.Size = fromScale
    tweenService2, tweenService3 = tweenService3, tweenService3.Create
    tweenService3 = tweenService3(tweenService2, inline2, tweenInfo, result)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    noopSliderRef.value(temporary2)
    return
end

function Handlers.setSpamPanelVisible(config, spamPanel, saveConfigRef, showSpamUI)
    config.showSpamUI = showSpamUI
    spamPanel.Visible = showSpamUI
    saveConfigRef.value()
    return
end

function Handlers.setSpeedPanelVisible(config, speedDisplayRef, saveConfigRef, showStats)
    config.showStats = showStats
    speedDisplayRef.value.Visible = showStats
    saveConfigRef.value()
    return
end

function Handlers.setTabLabelText(tabTitle, value, otherValue)
    local result, tabTitle2
    tabTitle2 = tabTitle
    result = tostring(otherValue)
    tabTitle2.Text = result
    return
end

function Handlers.setToggleLabelText(labelText, value, otherValue)
    local result, labelText2
    labelText2 = labelText
    result = tostring(otherValue)
    labelText2.Text = result
    return
end

function Handlers.setToggleValueAndNotify(toggleStateRef, animateToggleValueRef, toggleRef)
    local toggleState2, animateToggleValue2
    animateToggleValue2, toggleStateRef.value = animateToggleValueRef.value, not toggleStateRef.value
    toggleState2 = toggleStateRef.value
    animateToggleValue2(toggleStateRef.value, 0.1)
    toggleRef.value(toggleState2)
    return
end

function Handlers.setTriggerPanelVisible(config, triggerPanel, saveConfigRef, showTriggerUI)
    config.showTriggerUI = showTriggerUI
    triggerPanel.Visible = showTriggerUI
    saveConfigRef.value()
    return
end

function Handlers.setValue(valueText, noopDropdownRef, self, otherValue)
    local result, valueText2
    valueText2 = valueText
    result = tostring(otherValue)
    valueText2.Text = result
    noopDropdownRef.value = otherValue
    return
end

function Handlers.setValueDf(selectedValueRef, animateToggleValueRef, self, otherValue)
    local animateToggleValue2
    animateToggleValue2, selectedValueRef.value = animateToggleValueRef.value, otherValue
    animateToggleValue2(otherValue, 0.1)
    return
end

function Handlers.setValueWe(valueText, inline, noopSliderRef, self, otherValue)
    local valueText2, temporary2
    valueText2 = valueText
    temporary2 = tostring(otherValue)
    valueText2.Text = temporary2
    valueText2 = inline
    temporary2 = UDim2.fromScale(otherValue / noopSliderRef.value, 1)
    valueText2.Size = temporary2
    return
end

function Handlers.setWindowVisible(context, value)
    local title2, tweenService2, tweenInfo, position2, tweenService3, temporary6
    if value then
        title2, tweenService2 = context.frameRef3, context.tweenService
        tweenInfo = TweenInfo.new(1.4, Enum.EasingStyle.Quint)
        temporary6 = {}
        temporary6.Size = context.positionRef.value
        position2 = UDim2.new(0.5, 0, 0.5, 0)
        temporary6.Position = position2
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        title2, tweenService2 = context.headName, context.tweenService
        tweenInfo = TweenInfo.new(0.4666666666666666, Enum.EasingStyle.Quint)
        temporary6 = {}
        position2 = UDim2.new(0.205458686, 0, 0.133462012, 0)
        temporary6.Size = position2
        position2 = UDim2.new(0.0100000342, 0, 0.010000146, 0)
        temporary6.Position = position2
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.tabHose
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        position2 = UDim2.new(0.223, 0, 0.143, 0)
        temporary6.Position = position2
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.tabButtons
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        position2 = UDim2.new(0.008, 0, 0.143, 0)
        temporary6.Position = position2
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        if context.titleRef.value then
            title2, tweenService2 = context.titleRef.value, context.tweenService
            tweenInfo = TweenInfo.new(0.3)
            temporary6 = {}
            temporary6.TextTransparency = 0
            temporary6.TextStrokeTransparency = 0.9
            tweenService2, tweenService3 = tweenService2.Create, tweenService2
            tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
            tweenService3, tweenService2 = tweenService2, tweenService2.Play
            tweenService2(tweenService3)
        end
        tweenService2, title2 = context.tweenService, context.userName
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.TextTransparency = 0
        temporary6.TextStrokeTransparency = 1
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        title2, tweenService2 = context.userImage, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.ImageTransparency = 0
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        title2, tweenService2 = context.outloRef3, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 0.55
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2 = context.tweenService
        title2 = context.outlo
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 0.55
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        title2, tweenService2 = context.outloRef2, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 0.55
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.frameRef2
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 0.55
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        title2, tweenService2 = context.frame, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 0.7
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.dropShadow
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.ImageTransparency = 0.86
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    else
        title2, tweenService2 = context.frameRef3, context.tweenService
        tweenInfo = TweenInfo.new(1.4, Enum.EasingStyle.Quint)
        temporary6 = {}
        position2 = UDim2.new(0.14, 0, 0.14, 0)
        temporary6.Size = position2
        temporary6.Position = context.originalPositionRef.value
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        title2, tweenService2 = context.headName, context.tweenService
        tweenInfo = TweenInfo.new(1.1666666666666667, Enum.EasingStyle.Quint)
        temporary6 = {}
        position2 = UDim2.new(0.9, 0, 0.5, 0)
        temporary6.Size = position2
        position2 = UDim2.new(0.046, 0, 0.24, 0)
        temporary6.Position = position2
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.tabHose
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        position2 = UDim2.new(1.5, 0, 0.143, 0)
        temporary6.Position = position2
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        title2, tweenService2 = context.tabButtons, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        position2 = UDim2.new(-1.25, 0, 0.143, 0)
        temporary6.Position = position2
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        if context.titleRef.value then
            title2, tweenService2 = context.titleRef.value, context.tweenService
            tweenInfo = TweenInfo.new(0.3)
            temporary6 = {}
            temporary6.TextTransparency = 1
            temporary6.TextStrokeTransparency = 1
            tweenService2, tweenService3 = tweenService2.Create, tweenService2
            tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
            tweenService3, tweenService2 = tweenService2, tweenService2.Play
            tweenService2(tweenService3)
        end
        tweenService2, title2 = context.tweenService, context.userName
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.TextTransparency = 1
        temporary6.TextStrokeTransparency = 1
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        title2, tweenService2 = context.userImage, context.tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.ImageTransparency = 1
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2 = context.tweenService
        title2 = context.outloRef3
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 1
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.outlo
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 1
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.outloRef2
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 1
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.frameRef2
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 1
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.frame
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.BackgroundTransparency = 1
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2, title2 = context.tweenService, context.dropShadow
        tweenInfo = TweenInfo.new(0.3)
        temporary6 = {}
        temporary6.ImageTransparency = 1
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, title2, tweenInfo, temporary6)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

function Handlers.showRemoteFoundNotification(parryRemoteRef, setSwordOverrideRef, setSwordOverrideRef2)
    local notify, notify2
    while true do
        task.wait(0.01)
        if parryRemoteRef.value ~= nil then
            break
        else
            continue
        end
    end
    setSwordOverrideRef.value:UpdateHeader("417", "Remote Found")
    notify2 = setSwordOverrideRef2.value:Notification()
    notify, notify2 = notify2, notify2.Notify
    notify2(notify, "success", "Remote Found", "Parry Remote Found, you can now use the script :3", 3)
    return
end

function Handlers.stopDropdownDragging(input, draggingRef)
    if input.UserInputState == Enum.UserInputState.End then
        draggingRef.value = false
    end
    return
end

function Handlers.stopSliderDragging(input, draggingRef)
    if input.UserInputState == Enum.UserInputState.End then
        draggingRef.value = false
    end
    return
end

function Handlers.stopWindowDragging(input, tweenServiceRef)
    if input.UserInputState == Enum.UserInputState.End then
        tweenServiceRef.value = false
    end
    return
end

function Handlers.styleFloatingButton(backgroundColor, accentColorRef, textColor, tweenService, value, otherValue, otherValue2, otherValue3)
    local tweenService2, temporary2, tweenService3, tweenInfo
    if value then
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.BackgroundColor3 = accentColorRef.value
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, otherValue, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.TextColor3 = textColor
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, otherValue2, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.Transparency = 0
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, otherValue3, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    else
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.BackgroundColor3 = backgroundColor
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, otherValue, tweenInfo, temporary2)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.TextColor3 = accentColorRef.value
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, otherValue2, tweenInfo, temporary2)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
        tweenService2 = tweenService
        tweenInfo = TweenInfo.new(0.3)
        temporary2 = {}
        temporary2.Transparency = 0.5
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, otherValue3, tweenInfo, temporary2)
        tweenService2, tweenService3 = tweenService2.Play, tweenService2
        tweenService2(tweenService3)
    end
    return
end

function Handlers.toggleCurveWindow(refreshCurvePanelRef, curvePanelOpenRef, curveOptionsPanelRef, curveOptionsOpenRef)
    local curveOptionsPanel2, curvePanelOpen2
    if not curveOptionsOpenRef.value.Visible then
        return
    end
    curvePanelOpenRef.value, curveOptionsPanel2 = not curvePanelOpenRef.value, curveOptionsPanelRef.value
    curvePanelOpen2 = curvePanelOpenRef.value
    curveOptionsPanel2.Visible = curvePanelOpenRef.value
    if curvePanelOpen2 then
        refreshCurvePanelRef.value()
    end
    return
end

function Handlers.toggleKeybindPanel(tweenService, refreshKeybindPanelRef, keybindPanelRef, keybindPanelOpenRef, curveOptions, curveOptionsPanelRef)
    local position, tweenService2, curveOptionsPanel2, temporary4, tweenService3, tweenInfo, keybindPanel2
    curveOptionsPanel2, keybindPanelOpenRef.value = curveOptionsPanelRef.value, not keybindPanelOpenRef.value
    curveOptionsPanel2.Visible = keybindPanelOpenRef.value
    tweenService3 = keybindPanelOpenRef.value and #curveOptions * 38 or 0
    tweenService2, keybindPanel2 = tweenService, keybindPanelRef.value
    tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    temporary4 = {}
    position = UDim2.new(0, 220, 0, 162 + tweenService3)
    temporary4.Size = position
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, keybindPanel2, tweenInfo, temporary4)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    refreshKeybindPanelRef.value()
    return
end

function Handlers.toggleWindowCollapsed(tweenService, createWindowTitleRef, imageButton, connectRef, frame, collapsedRef)
    local position, tweenService2, imageButton2, temporary4, tweenService3, tweenInfo
    connectRef.value = not connectRef.value
    if connectRef.value then
        imageButton2, collapsedRef.value, tweenService2 = imageButton, frame.Position, tweenService
        tweenInfo = TweenInfo.new(0.5)
        temporary4 = {}
        position = UDim2.new(0.0900000036, 0, 0.0900000036, 0)
        temporary4.Size = position
        position = UDim2.new(0.908723712, 0, 0.0239103697, 0)
        temporary4.Position = position
        position = Vector2.new(0, 0)
        temporary4.AnchorPoint = position
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, imageButton2, tweenInfo, temporary4)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    else
        imageButton2, tweenService2 = imageButton, tweenService
        tweenInfo = TweenInfo.new(0.5)
        temporary4 = {}
        position = UDim2.new(0.3, 0, 0.3, 0)
        temporary4.Size = position
        position = UDim2.new(1, 0, -0.009, 0)
        temporary4.Position = position
        position = Vector2.new(1, 0)
        temporary4.AnchorPoint = position
        tweenService3, tweenService2 = tweenService2, tweenService2.Create
        tweenService2 = tweenService2(tweenService3, imageButton2, tweenInfo, temporary4)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    end
    createWindowTitleRef.value(connectRef.value)
    return
end

function Handlers.unhighlightButton(tweenService, labelText, uIStroke)
    local tweenService2, tweenInfo, temporary3, labelText2, tweenService3
    labelText2, tweenService3 = labelText, tweenService
    tweenInfo = TweenInfo.new(0.1)
    temporary3 = {}
    temporary3.TextTransparency = 0.3
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, labelText2, tweenInfo, temporary3)
    tweenService2, tweenService3 = tweenService3, tweenService3.Play
    tweenService3(tweenService2)
    tweenService3 = tweenService
    labelText2 = uIStroke
    tweenInfo = TweenInfo.new(0.2)
    temporary3 = {}
    temporary3.Transparency = 0.5
    tweenService3, tweenService2 = tweenService3.Create, tweenService3
    tweenService3 = tweenService3(tweenService2, labelText2, tweenInfo, temporary3)
    tweenService3, tweenService2 = tweenService3.Play, tweenService3
    tweenService3(tweenService2)
    return
end

function Handlers.unhighlightDropdownItem(tweenService, textButton)
    local textButton2, temporary2, tweenService2, tweenService3, tweenInfo
    textButton2, tweenService2 = textButton, tweenService
    tweenInfo = TweenInfo.new(0.1)
    temporary2 = {}
    temporary2.TextTransparency = 0.3
    tweenService3, tweenService2 = tweenService2, tweenService2.Create
    tweenService2 = tweenService2(tweenService3, textButton2, tweenInfo, temporary2)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    return
end

function Handlers.unhighlightFloatingButton(uICornerRef, tweenService)
    local tweenService2, tweenInfo, tweenService3, uICorner2, temporary5
    if uICornerRef.value.Transparency ~= 0 then
        uICorner2, tweenService2 = uICornerRef.value, tweenService
        tweenInfo = TweenInfo.new(0.25)
        temporary5 = {}
        temporary5.Transparency = 0.5
        tweenService2, tweenService3 = tweenService2.Create, tweenService2
        tweenService2 = tweenService2(tweenService3, uICorner2, tweenInfo, temporary5)
        tweenService3, tweenService2 = tweenService2, tweenService2.Play
        tweenService2(tweenService3)
    end
    return
end

function Handlers.updateBallSpeedLabel(speedLabelRef, ballSpeedStateRef, speedDisplayRef, findBallRef)
    local ballSpeedState2, temporary2, temporary3, temporary4, temporary5
    temporary5 = findBallRef.value()
    ballSpeedState2 = math.floor(temporary5 * 10 + 0.5)
    ballSpeedState2, temporary4 = ballSpeedStateRef.value, ballSpeedState2 / 10
    ballSpeedStateRef.value.current = temporary4
    ballSpeedState2 = ballSpeedState2.peak
    if temporary5 > ballSpeedState2 then
        ballSpeedState2 = ballSpeedStateRef.value
        temporary3 = math.floor(temporary5 * 10 + 0.5)
        ballSpeedState2.peak = temporary3 / 10
    end
    ballSpeedState2 = speedDisplayRef.value and speedDisplayRef.value.Visible and speedLabelRef.value
    if ballSpeedState2 then
        ballSpeedState2 = speedLabelRef.value
        temporary2 = string.format("\226\154\161 %.1f | \240\159\147\136 %.1f", ballSpeedStateRef.value.current, ballSpeedStateRef.value.peak)
        ballSpeedState2.Text = temporary2
    end
    return
end

function Handlers.updateControlValue(control, controlValue)
    control:SetValue(controlValue)
    return
end

function Handlers.updateDropdownCanvas(keyOptionsPopupRef, curveDropdownButtonRef)
    local keyOptionsPopup2, position
    keyOptionsPopup2 = keyOptionsPopupRef.value
    position = UDim2.new(0, 0, 0, curveDropdownButtonRef.value.AbsoluteContentSize.Y + 10)
    keyOptionsPopup2.CanvasSize = position
    return
end

function Handlers.updateDropdownVisibility(downBar)
    if downBar.Size.Y.Offset < 4 then
        downBar.Visible = false
    else
        downBar.Visible = true
    end
    return
end

function Handlers.updateFpsAndPingLabel(getPingRef, positionRef, fpsLabelRef, fpsPanelRef, value)
    local result, format, floor, fpsLabel2, temporary5
    if not fpsPanelRef.value.Visible then
        return
    end
    if value > 0 then
        positionRef.value = positionRef.value + (1 / value - positionRef.value) * 0.2
    end
    fpsLabel2 = fpsLabelRef.value
    format = string.format
    result = math.floor(positionRef.value + 0.5)
    floor = math.floor
    temporary5 = getPingRef.value()
    temporary5 = temporary5 + 0.5
    floor = packValues(floor(temporary5))
    format = format("FPS: %d | PING: %d ms", result, unpackValues(floor))
    fpsLabel2.Text = format
    return
end

function Handlers.updateLabel(downBar, tweenService)
    local tweenInfo, tweenService2, tweenService3, uIAspectRatioConstraint, highlightDropdownItem, temporary6, textButton
    textButton = Instance.new("TextButton")
    uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    textButton.Parent = downBar
    textButton.BackgroundTransparency = 1
    textButton.BorderSizePixel = 0
    tweenService2 = UDim2.new(0.99000001, 0, 0.5, 0)
    textButton.Size = tweenService2
    textButton.ZIndex = 10000
    textButton.Font = Enum.Font.SourceSansSemibold
    textButton.Text = "List"
    tweenService2 = Color3.fromRGB(255, 255, 255)
    textButton.TextColor3 = tweenService2
    textButton.TextScaled = true
    textButton.TextSize = 14
    textButton.TextWrapped = true
    highlightDropdownItem, tweenService2 = textButton, tweenService
    tweenInfo = TweenInfo.new(0.1)
    temporary6 = {}
    temporary6.TextTransparency = 0.3
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, highlightDropdownItem, tweenInfo, temporary6)
    tweenService2, tweenService3 = tweenService2.Play, tweenService2
    tweenService2(tweenService3)
    uIAspectRatioConstraint.Parent = textButton
    uIAspectRatioConstraint.AspectRatio = 4.5
    uIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    tweenService2, highlightDropdownItem = textButton.MouseEnter, bind(Handlers.highlightDropdownItem, tweenService, textButton)
    tweenService2, tweenService3 = tweenService2.Connect, tweenService2
    tweenService2(tweenService3, highlightDropdownItem)
    tweenService2, highlightDropdownItem = textButton.MouseLeave, bind(Handlers.unhighlightDropdownItem, tweenService, textButton)
    tweenService3, tweenService2 = tweenService2, tweenService2.Connect
    tweenService2(tweenService3, highlightDropdownItem)
    return textButton
end

function Handlers.updateLabelVisibility(labelText, label)
    if labelText.TextTransparency <= 0.99 then
        label.Visible = true
    else
        label.Visible = false
    end
    return
end

function Handlers.updateNotificationDrag(tweenServiceRef, bindCanvasSizeRef, frame, value)
    local tweenInfo, tweenService2, tweenService3, temporary4, position, frame2
    position = UDim2.new(bindCanvasSizeRef.value.X.Scale, bindCanvasSizeRef.value.X.Offset + (value.Position - tweenServiceRef.value).X, bindCanvasSizeRef.value.Y.Scale, bindCanvasSizeRef.value.Y.Offset + (value.Position - tweenServiceRef.value).Y)
    tweenService2 = game:GetService("TweenService")
    frame2 = frame
    tweenInfo = TweenInfo.new(0.1)
    temporary4 = {}
    temporary4.Position = position
    tweenService2, tweenService3 = tweenService2.Create, tweenService2
    tweenService2 = tweenService2(tweenService3, frame2, tweenInfo, temporary4)
    tweenService3, tweenService2 = tweenService2, tweenService2.Play
    tweenService2(tweenService3)
    return
end

function Handlers.updateSectionCanvas(tweenServiceRef, uIListLayout)
    local position, tweenService2
    tweenService2 = tweenServiceRef.value
    position = UDim2.new(0, 0, 0, uIListLayout.AbsoluteContentSize.Y + 45)
    tweenService2.CanvasSize = position
    return
end

function Handlers.updateSectionVisibility(sectionRef)
    if sectionRef.value.Size.Y.Offset <= 1 then
        sectionRef.value.Visible = false
    else
        sectionRef.value.Visible = true
    end
    return
end

function Handlers.updateSelectedTabButtons(screenGui, tabRef)
    local result, temporary2, temporary3, temporary4, temporary5
    temporary3, temporary4, result = ipairs(screenGui)
    temporary3, temporary4, result = normalizeIterator(temporary3, temporary4, result)
    for index, item in temporary3, temporary4, result do
        temporary2, temporary5, result = index, item, index
        if temporary5[1] == tabRef.value then
            temporary5[2](true, 0.4)
            task.wait()
        else
            temporary5[2](false, 0.4)
        end
    end
    temporary2, temporary5, result = nil, nil, nil
    return
end

function Handlers.updateSliderDrag(dragStartRef, initialPositionRef, frame, value)
    local tweenService, position, tweenService2, temporary4, tweenInfo, frame2
    position = UDim2.new(initialPositionRef.value.X.Scale, initialPositionRef.value.X.Offset + (value.Position - dragStartRef.value).X, initialPositionRef.value.Y.Scale, initialPositionRef.value.Y.Offset + (value.Position - dragStartRef.value).Y)
    tweenService = game:GetService("TweenService")
    frame2 = frame
    tweenInfo = TweenInfo.new(0.2)
    temporary4 = {}
    temporary4.Position = position
    tweenService, tweenService2 = tweenService.Create, tweenService
    tweenService = tweenService(tweenService2, frame2, tweenInfo, temporary4)
    tweenService, tweenService2 = tweenService.Play, tweenService
    tweenService(tweenService2)
    return
end

function Handlers.updateVisibleSpeedPanel(config, speedDisplayRef, updateSpeedLabelRef)
    local result
    result = config.showStats and speedDisplayRef.value and speedDisplayRef.value.Visible
    if result then
        updateSpeedLabelRef.value()
    end
    return
end

function Handlers.updateWindowDrag(dragStartRef, initialPositionRef, frame, value)
    local result, tweenService, frame2, tweenInfo, tweenService2, position
    position = UDim2.new(initialPositionRef.value.X.Scale, initialPositionRef.value.X.Offset + (value.Position - dragStartRef.value).X, initialPositionRef.value.Y.Scale, initialPositionRef.value.Y.Offset + (value.Position - dragStartRef.value).Y)
    tweenService = game:GetService("TweenService")
    frame2 = frame
    tweenInfo = TweenInfo.new(0.15)
    result = {}
    result.Position = position
    tweenService, tweenService2 = tweenService.Create, tweenService
    tweenService = tweenService(tweenService2, frame2, tweenInfo, result)
    tweenService2, tweenService = tweenService, tweenService.Play
    tweenService(tweenService2)
    return
end

return Handlers.main(...)
