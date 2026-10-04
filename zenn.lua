--[[
    Zenthra — Blade Ball
    Standalone rebuild from a Luraph devirt dump.
    No Luarmor. No VM. No auth. Loads directly.

    Usage:
        loadstring(game:HttpGet("...zenthra.lua"))()

    Executor requirements:
        hookmetamethod, hookfunction, getconnections, getupvalues,
        setupvalue, gethui, getcustomasset/getsynasset, cloneref,
        setthreadidentity, identifyexecutor.

    Tested intent: Synapse-class executors.
--]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local UserInputService   = game:GetService("UserInputService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local Workspace          = game:GetService("Workspace")
local Stats              = game:GetService("Stats")
local CoreGui            = game:GetService("CoreGui")
local Debris             = game:GetService("Debris")
local HttpService        = game:GetService("HttpService")
local Lighting           = game:GetService("Lighting")
local TeleportService    = game:GetService("TeleportService")
local TweenService       = game:GetService("TweenService")
local SoundService       = game:GetService("SoundService")
local ContentProvider    = game:GetService("ContentProvider")
local TextChatService    = game:GetService("TextChatService")
local LocalizationService= game:GetService("LocalizationService")
local GuiService         = game:GetService("GuiService")

local localPlayer        = Players.LocalPlayer
local currentCamera      = Workspace.CurrentCamera
local VirtualInputManager = Instance.new("VirtualInputManager")

-- ============================================================
-- EXECUTOR
-- ============================================================
local EXEC = {
    hookmetamethod   = hookmetamethod,
    hookfunction     = hookfunction,
    getconnections   = getconnections,
    getupvalues      = getupvalues,
    setupvalue       = setupvalue,
    getrawmetatable  = getrawmetatable,
    setreadonly      = setreadonly,
    newcclosure      = newcclosure,
    cloneref         = cloneref or function(o) return o end,
    gethui           = gethui,
    identifyexecutor = identifyexecutor,
    setthreadidentity = setthreadidentity,
    getthreadidentity = getthreadidentity,
    islclosure       = islclosure,
    getnamecallmethod = getnamecallmethod,
    getcustomasset   = getcustomasset or getsynasset or (syn and syn.getcustomasset),
    firetouchinterest = firetouchinterest,
}

local function get_safe_parent()
    local ok, hui = pcall(function() return EXEC.gethui and EXEC.gethui() end)
    if ok and hui and typeof(hui) == "Instance" then
        local ok2 = pcall(function() hui:GetChildren() end)
        if ok2 and hui.Name ~= "RobloxGui" then return hui end
    end
    local ok3, core = pcall(function() return CoreGui end)
    if ok3 and core then return core end
    return localPlayer:WaitForChild("PlayerGui")
end

-- ============================================================
-- CONSTANTS
-- ============================================================
local PI  = math.pi
local TAU = PI * 2
local HUGENUM = math.huge
local is_mobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- ============================================================
-- SESSION (teardown token)
-- ============================================================
local SESSION = {}
local MAIN_THREAD = coroutine.running()

local function is_current_session()
    return getgenv().__ZenthraSession == SESSION
end
getgenv().__ZenthraSession = SESSION

-- ============================================================
-- STATE TABLE (the "tbl21" from the devirt)
-- ============================================================
local Z = {
    config = {
        auto_parry                = false,
        backward_detection        = false,
        triggerbot_delay          = 0,
        kill_pre_click            = false,
        kill_pre_click_range      = 30,
        kill_pre_click_speed      = 1,
        accuracy                  = 75,
        parry_distance_multiplier = 1,
        randomize_accuracy        = false,
        random_accuracy_min       = 25,
        random_accuracy_max       = 85,
        curve_mode                = 2,
        target_mode               = 3,
        parry_mode                = "Remote",
        is_mobile                 = is_mobile,

        target_player_enabled     = false,
        target_player_name        = nil,
        target_player_follow      = false,
        target_player_text        = true,
        target_player_notify      = false,
        target_player_text_size   = 18,
        target_player_text_color  = Color3.fromRGB(255, 0, 0),
        target_player_highlight   = false,
        target_player_highlight_color = Color3.fromRGB(255, 0, 0),

        follow_target_mode        = 1,
        follow_target_text        = true,
        follow_target_text_size   = 18,
        follow_target_text_color  = Color3.fromRGB(255, 0, 0),
        follow_target_highlight   = false,
        follow_target_highlight_color = Color3.fromRGB(255, 0, 0),
        follow_target_name        = nil,

        show_aim_target           = false,
        aim_target_highlight      = false,
        aim_target_highlight_color= Color3.fromRGB(0, 255, 127),
        aim_target_text           = false,
        aim_target_text_color     = Color3.fromRGB(0, 255, 127),
    },

    detections = {
        infinity      = false,
        deathslash    = false,
        tornado_time  = 0,
        aerodynamic_time = 0,
        slashesoffury = false,
        forcefield    = false,
        timehole      = false,
        dribble       = false,
    },

    state = {
        grab_track            = nil,
        reverted_remotes      = {},
        hooked_metatables     = {},
        fire_server_hooked    = false,
        invoke_server_hooked  = false,
        ball_tracking         = {},
        parried               = false,
        infinity_active       = false,
        deathslash_active     = false,
        slashesoffury_active  = false,
        forcefield_active     = false,
        timehole_active       = false,
        first_parry_done      = false,
        last_execute_tick     = 0,
        parry_busy            = false,
        parry_busy_token      = 0,
        parry_busy_entry      = nil,
        parry_busy_targets    = nil,
        parry_multi_pending   = false,
        parry_multi_active    = false,
        parry_multi_generation= 0,
        parry_multi_entries   = nil,
        parry_multi_inflight  = nil,
        parry_multi_confirmed_count = 0,
        parry_confirm_clear_at= 0,
    },

    curve_detection = {
        velocity_history  = {},
        dot_histories     = {},
        lerp_radians      = 0,
        last_warp_time    = 0,
        curve_time        = 0,
        per_ball          = {},
        per_ball_last_cleanup = 0,
        tuning            = nil,
        tuning_version    = 0,
    },

    parry_cooldown = {
        failed_at = 0, last_parrying = nil, conn = nil,
        ability_fired = false, fired_at = 0, watch_conn = nil,
        visual_cd_conn = nil, ability_cd_conn = nil, success_conn = nil,
        success_all_conn = nil, remote_retry_at = 0, armed = false,
        lock_kind = "idle", no_threat_since = 0,
        block_active = false, block_started_at = 0, block_ready_at = 0,
        block_duration = 0, generation = 0, lifecycle_generation = 0,
        phase = "idle", action_generation = -1, action_token = 0,
        last_action_frame = -1, last_action_at = 0,
        pending_token = 0, followup_token = 0, confirmed_followup_token = 0,
        feature_epoch = 0, fallback_used = false, attempted_ability = nil,
        pending_kind = nil, pending_ability = nil, pending_profile = nil,
        pending_entry = nil, pending_ball = nil, pending_character = nil,
        pending_at = 0, pending_deadline = 0,
        pending_origin_position = nil, pending_origin_velocity = nil,
        pending_origin_root_velocity = nil, pending_origin_walk_speed = 0,
        pending_origin_jump_speed = 0, pending_origin_grounded = false,
        pending_origin_target = nil, pending_origin_cooldown = 0,
        pending_origin_charges = nil, pending_origin_active = false,
        pending_direction = nil, pending_local_accepted = false,
        ability_signal_at = 0, ability_signal_duration = 0,
        confirmed_at = 0, confirmed_profile = nil, coverage_until = 0,
        exhausted_generation = -1, last_step_at = 0, frame_dt = 0.016666,
        parry_open_at = 0, observed_parry_at = 0, observed_parry_deadline = 0,
        last_threat_at = 0, last_threat_ball = nil,
        precondition_name = nil, precondition_at = 0, precondition_value = false,
        ability_script = nil, ability_script_name = nil,
        ability_button = nil, ability_hold = nil,
        targeting_helper = nil, runtime_ref = nil, waypoint_ref = nil,
        shield_ref = nil, shield_char = nil,
        humanoid_ref = nil, humanoid_char = nil,
        marked_at = 0, attempt_at = 0, attempt_grad = nil,
        attempt_deadline = 0, attempt_window_seen = false,
        last_attempt_at = 0, last_success_at = 0,
        grad_y = nil, grad_t = 0, grad_rate = nil,
        clash_ball = nil, clash_ball_left = false,
        mark_open = false, mark_kind = nil,
        win_open_at = 0, win_dur = nil, last_win_d = nil,
        cancel_at = 0, grad_low_since = 0,
        parry_latch_target_seq = nil,
    },

    triggerbot = {
        enabled = false, is_parrying = false, connection = nil,
        ball_conns = {}, pending = {}, hooked_folder = nil,
        folder_add_conn = nil, folder_rem_conn = nil,
    },

    spam = {
        manual_enabled = false, auto_enabled = false,
        parries = 0, threshold = 1.5, sensitivity_multiplier = 1,
        connection_manual = nil, connection_manual_extra = nil,
        connection_auto = nil, thread_manual = nil, thread_auto = nil,
        fire_interval = 0.008333, animation_fix_interval = 0.016666,
        animation_fix_manual = false, animation_fix_auto = false,
        last_animation_fix_manual_t = 0, last_animation_fix_auto_t = 0,
        last_manual_fire_t = 0, last_auto_fire_t = 0,
        last_parried_ball = nil, manual_mode = "Remote", auto_mode = "Remote",
        remote_list = {}, remote_list_dirty = false,
        auto_decay_at = {}, ping_cache = 0, ping_cache_t = 0,
        balls_ref = nil, balls_children = nil, balls_dirty = true,
        balls_conn_add = nil, balls_conn_rem = nil,
        alive_ref = nil, alive_me = nil,
        hum_ref = nil, hum_char = nil, root_ref = nil, root_char = nil,
        zoomies_cache = setmetatable({}, {__mode="k"}),
    },

    ability = {
        cooldown_protection = false,
        auto_ability = false,
    },

    device_spoof = { target = "Console", installed = false },

    player_mods = {
        fov_enabled = false, fov = 70,
        speed_enabled = false, speed = 16, speed_conn = nil,
        gravity_enabled = false, gravity = 196.2,
        jump_power_enabled = false, jump_power = 50, jump_conn = nil,
        infinite_jump_enabled = false, infinite_jump_conn = nil,
    },

    ball_trail = {
        active = false, color = Color3.fromRGB(0, 255, 200),
        num_trails = 8, attachments = {}, connection = nil,
    },

    parry_visualizer = {
        active = false, color = Color3.fromRGB(0, 200, 255),
        parts = {}, connection = nil, char_conn = nil, current_radius = 1,
    },

    target_player = { active=false, text_draw=nil, highlights=nil, highlight_char=nil, connection=nil },
    follow_target = { active=false, text_draw=nil, highlights=nil, highlight_char=nil, connection=nil, move_connection=nil, post_connection=nil },
    aim_target    = { active=false, text_draw=nil, highlights=nil, highlight_char=nil, connection=nil },

    visual = { highlight_container = nil },

    ability_esp = {
        active=false, drawings={}, connection=nil,
        mode="Text", show_name=false, name_mode="Display Name",
        name_size=18, name_color=Color3.fromRGB(255,255,255),
        ability_size=16, ability_color=Color3.fromRGB(120,200,255),
        show_cd=false, cd_type="Text", cd_size=15, cd_color=Color3.fromRGB(180,180,180),
        show_timer=false, active_type="Text", active_size=15, active_color=Color3.fromRGB(255,200,80),
    },

    ball_velocity = { active=false, gui=nil, peak={}, connection=nil },
    ball_indicator = {
        active=false, gui=nil, position=Vector2.new(0,0), rotation=0, connection=nil,
        size = is_mobile and 30 or 40,
        distance = is_mobile and 70 or 120,
    },

    no_render = { active=false, connection=nil, parry_attempt_conn=nil, parry_attempt_handler=nil, _patch_running=false },

    orbit_ball = {
        active=false, speed=50, height=5, distance=15, angle=0,
        connection=nil, post_connection=nil,
        _saved_platform_stand=nil, _saved_auto_rotate=nil,
        _antifling_mod=nil, _antifling_orig=nil,
    },

    immortal = {
        config = { radius=25, height=30, angles=360, visualizer_enabled=false, visualizer_color=Color3.fromRGB(255,0,0) },
        state = {
            enabled=false, notify=false, connections={},
            cache = { character=nil, hrp=nil, head=nil, alive=nil, original_cframe=nil, original_velocity=nil },
            visualizer = { parts={}, folder=nil },
        },
    },

    world_customizer = {
        enabled = false,
        originals = {},
        managed = {},
        connections = {},
        monitor_started = false,
        _reapply_pending = false,
        order = {
            "saturation","brightness","contrast","tint","fog",
            "clock_time","ambient","outdoor_ambient","light_brightness",
            "exposure","disable_bloom","disable_sun_rays","disable_shadows",
            "disable_celestial",
        },
    },

    low_graphics = {
        enabled = false, saved = {}, connections = {},
        quality_original = nil, mesh_detail_original = nil,
    },

    kill_sound = { enabled = false, folder = "Zenthra/killsounds" },
    hit_sound  = { enabled = false },

    skybox = { presets = {}, original = {} },

    autoplay = {
        enabled=false, anti_afk=true, tick_interval=0.1,
        ball=nil, lobby_choice=nil, control_point=nil, elapsed=0,
        last_generation=0, last_jump_at=0, double_jumped=false,
        connections={}, afk_conn=nil, cached_floor=nil, floor_scan_at=0,
        cached_target=nil, cached_target_at=0, cached_ball_pos=nil,
        target_refresh=0.12, char=nil, hrp=nil, hum=nil,
        _ws={}, _in_lobby=nil, _balls_watch_folder=nil, _last_alive=nil, _last_pos=nil,
        current_dir = Vector3.new(0,0,0),
        config = {
            default_distance=30, multiplier_threshold=70, traversing=25,
            direction=1, jump_percentage=50, jumping_enabled=false,
            double_jump_percentage=50, double_jumping_enabled=false,
            movement_duration=0.8, offset_factor=0.7, generation_threshold=0.25,
        },
    },

    sword_material = {
        enabled=false, material="ForceField", material_enabled=true,
        color_enabled=false, custom_color=Color3.fromRGB(255,255,255),
        originals={}, item_info=nil, started=false, last_equipped=nil,
        _reapply_token=0, _hooked_sword_changer=false,
        player_conn=nil, render_conn=nil, attr_conn=nil,
        char_conn=nil, char_removed_conn=nil, char_desc_conn=nil, char_attr_conn=nil,
        sword_conns={}, sword_parts={}, cached_roots={}, _applying=false, _dirty=false, _dirty_t=0, _accum=0,
    },

    avatar_material = {
        enabled=false, material="ForceField", material_enabled=true,
        color_enabled=false, custom_color=Color3.fromRGB(255,255,255),
        originals={}, item_info=nil, started=false, _reapply_token=0,
        player_conn=nil, render_conn=nil, char_conn=nil, char_removed_conn=nil, char_desc_conn=nil,
        cached_parts={}, _applying=false, _dirty=false, _dirty_t=0, _accum=0,
    },

    avatar = { korblox_enabled=false, headless_enabled=false, korblox_conn=nil, headless_conn=nil },

    anim = { grab_track = nil },

    cache = {
        current_frame=0,
        closest_char=nil, closest_frame=-1,
        closest_aim_char=nil, closest_aim_frame=-1,
        event_data={}, event_data_frame=-1,
        mouse_vec={0,0}, mouse_vec_frame=-1,
        cframe=nil, cframe_frame=-1,
        parry_target=nil, parry_target_frame=-1,
        balls_folder=nil, training_balls_folder=nil,
        ping_time=0, ping_val=50,
        block_button=nil, block_cd=nil,
        first_ball=nil, first_ball_frame=-1,
        all_balls={}, all_balls_frame=-1,
        targeted_balls={}, targeted_balls_frame=-1,
        root_ref=nil, root_frame=-1,
        dribble_result=false, dribble_frame=-1,
        ability_cd=nil,
        last_ball_targets={},
        invis_alive_folder=nil, invis_scan_frame=-1, invis_scan_result=false,
        invis_aim_frame=-1, invis_aim_result=false,
    },
}

local Flags = {}          -- persisted module flags
local Options = {}        -- widget instances
local Binds = {}          -- active keybinds

Z.cache.get_balls_folder = function()
    if Z.cache.balls_folder and Z.cache.balls_folder.Parent then return Z.cache.balls_folder end
    Z.cache.balls_folder = Workspace:FindFirstChild("Balls")
    return Z.cache.balls_folder
end

Z.cache.get_training_balls_folder = function()
    if Z.cache.training_balls_folder and Z.cache.training_balls_folder.Parent then return Z.cache.training_balls_folder end
    Z.cache.training_balls_folder = Workspace:FindFirstChild("TrainingBalls")
    return Z.cache.training_balls_folder
end

Z.cache.get_ping = function()
    local t = os.clock()
    if t - Z.cache.ping_time >= 0.03 then
        Z.cache.ping_time = t
        local ok, val = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        end)
        Z.cache.ping_val = (ok and val) or 50
    end
    return Z.cache.ping_val
end

Z.cache.get_block_button = function()
    if Z.cache.block_button and Z.cache.block_button.Parent then return Z.cache.block_button end
    local pg = localPlayer:FindFirstChild("PlayerGui")
    local hotbar = pg and pg:FindFirstChild("Hotbar")
    local block  = hotbar and hotbar:FindFirstChild("Block")
    if block then
        Z.cache.block_button = block:FindFirstChildOfClass("TextButton")
            or block:FindFirstChildOfClass("ImageButton")
            or (block:IsA("GuiButton") and block)
    end
    return Z.cache.block_button
end

-- ============================================================
-- THROTTLE
-- ============================================================
local throttle_times = {}
local function throttle(key, interval)
    local now = os.clock()
    local last = throttle_times[key]
    if last and now - last < interval then return false end
    throttle_times[key] = now
    return true
end

-- ============================================================
-- CONNECTIONS (tracked)
-- ============================================================
local TrackedConns = setmetatable({}, {__mode="k"})
getgenv().__ZenthraTrackedConns = getgenv().__ZenthraTrackedConns or {}

local function track(c)
    if c and typeof(c) == "RBXScriptConnection" then
        table.insert(getgenv().__ZenthraTrackedConns, c)
    end
    return c
end

local function disconnect(c)
    if c and typeof(c) == "RBXScriptConnection" then
        pcall(function() c:Disconnect() end)
    end
end

-- ============================================================
-- BALL MODULE
-- ============================================================
local Ball = {}
local ball_refs = setmetatable({}, {__mode="k"})
local zoomies_refs = setmetatable({}, {__mode="k"})

Ball.get_velocity = function(part, model)
    if model then
        local v = model:GetAttribute("Velocity")
        if v and typeof(v) == "Vector3" then return v end
    end
    local z = zoomies_refs[part]
    if z == nil then
        z = part:FindFirstChild("zoomies") or false
        zoomies_refs[part] = z
    end
    if z then
        local v = z.VectorVelocity
        if v then return v end
    end
    return part.AssemblyLinearVelocity
end

Ball.get_all = function()
    if Z.cache.all_balls_frame == Z.cache.current_frame then return Z.cache.all_balls end
    Z.cache.all_balls_frame = Z.cache.current_frame
    local out = Z.cache.all_balls
    table.clear(out)
    local main = Z.cache.get_balls_folder()
    local training = Z.cache.get_training_balls_folder()

    local function scan(folder)
        if not folder then return end
        for _, child in ipairs(folder:GetChildren()) do
            local entry = ball_refs[child]
            if entry then
                table.insert(out, entry)
            else
                if child:GetAttribute("realBall") == true then
                    entry = { part = child, model = nil, is_targeted = false }
                    ball_refs[child] = entry
                    table.insert(out, entry)
                elseif child:IsA("Model") then
                    local p = child:FindFirstChild("Corpo") or child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")
                    if p then
                        entry = { part = p, model = child, is_targeted = false }
                        ball_refs[child] = entry
                        table.insert(out, entry)
                    end
                end
            end

            if entry then
                local name = localPlayer.Name
                local t = child:GetAttribute("target")
                if not t and entry.model then
                    t = entry.model:GetAttribute("target")
                    if not t then
                        local cw = entry.model:FindFirstChild("CollisionWhitelist")
                        if cw and cw.Value == localPlayer.Character then t = name end
                    end
                end
                entry.is_targeted = (t == name)
            end
        end
    end

    scan(main)
    if not Z.player_is_in_alive() then scan(training) end
    return out
end

Ball.get_first = function()
    if Z.cache.first_ball_frame == Z.cache.current_frame then return Z.cache.first_ball end
    Z.cache.first_ball_frame = Z.cache.current_frame
    local folder = Z.cache.get_balls_folder()
    if not folder then Z.cache.first_ball = nil; return nil end
    for _, c in ipairs(folder:GetChildren()) do
        if c:GetAttribute("realBall") == true then
            Z.cache.first_ball = c
            return c
        end
    end
    Z.cache.first_ball = nil
    return nil
end

Ball.get_targeted = function()
    if Z.cache.targeted_balls_frame == Z.cache.current_frame then return Z.cache.targeted_balls end
    Z.cache.targeted_balls_frame = Z.cache.current_frame
    local out = Z.cache.targeted_balls
    table.clear(out)
    for _, b in ipairs(Ball.get_all()) do
        if b.is_targeted then table.insert(out, b) end
    end
    return out
end

Ball.any_other_invisibility = function()
    local alive = Workspace:FindFirstChild("Alive")
    if not alive then return false end
    for _, c in ipairs(alive:GetChildren()) do
        if c.Name ~= localPlayer.Name then
            local p = Players:FindFirstChild(c.Name)
            if p and p:GetAttribute("CurrentlyEquippedAbility") == "Invisibility" then
                return true
            end
        end
    end
    return false
end

Ball.others_all_invisibility = function()
    if Z.cache.invis_scan_frame == Z.cache.current_frame then return Z.cache.invis_scan_result == true end
    Z.cache.invis_scan_frame = Z.cache.current_frame
    local folder = Z.cache.invis_alive_folder
    if not folder or folder.Parent ~= Workspace then
        folder = Workspace:FindFirstChild("Alive")
        Z.cache.invis_alive_folder = folder
    end
    if not folder then Z.cache.invis_scan_result = false; return false end
    local found = false
    for _, c in ipairs(folder:GetChildren()) do
        if c.Name ~= localPlayer.Name then
            local p = Players:FindFirstChild(c.Name)
            if not p or p:GetAttribute("CurrentlyEquippedAbility") ~= "Invisibility" then
                Z.cache.invis_scan_result = false
                return false
            end
            found = true
        end
    end
    Z.cache.invis_scan_result = found
    return found
end

Ball.should_disable_aim_for_invis = function()
    if Z.cache.invis_aim_frame == Z.cache.current_frame then return Z.cache.invis_aim_result == true end
    Z.cache.invis_aim_frame = Z.cache.current_frame
    local r = Ball.others_all_invisibility() and #Ball.get_targeted() > 0
    Z.cache.invis_aim_result = r
    return r
end

Ball.check_tornado = function(part)
    if part:FindFirstChild("AeroDynamicSlashVFX") then
        pcall(function() part.AeroDynamicSlashVFX:Destroy() end)
        Z.detections.tornado_time = tick()
    end
    local runtime = Workspace:FindFirstChild("Runtime")
    if runtime and runtime:FindFirstChild("Tornado") then
        local t = runtime.Tornado:GetAttribute("TornadoTime") or 1
        if tick() - Z.detections.tornado_time < t + 0.314159 then
            return true
        end
    end
    return false
end

Ball.update_tracking = function(part, model)
    local key = tostring(part)
    local cd = Z.curve_detection
    if not Z.state.ball_tracking[key] then Z.state.ball_tracking[key] = {samples={}} end
    if not cd.velocity_history[key] then cd.velocity_history[key] = {} end
    if not cd.dot_histories[key] then cd.dot_histories[key] = {} end
    local vel = Ball.get_velocity(part, model)
    local root = Z.player_get_root()
    local samples = Z.state.ball_tracking[key].samples
    table.insert(samples, { vel = vel, t = os.clock() })
    if #samples > 20 then table.remove(samples, 1) end
    local hist = cd.velocity_history[key]
    table.insert(hist, vel)
    if #hist > 10 then table.remove(hist, 1) end
    if root then
        local dhist = cd.dot_histories[key]
        local delta = root.Position - part.Position
        if delta.Magnitude > 0.001 and vel.Magnitude >= 1 then
            table.insert(dhist, delta.Unit:Dot(vel.Unit))
            if #dhist > 10 then table.remove(dhist, 1) end
        end
    end
end

-- ============================================================
-- PLAYER MODULE
-- ============================================================
local Player = {}

Player.get_root = function()
    local c = localPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

Player.is_alive = function()
    local c = localPlayer.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    local r = c:FindFirstChild("HumanoidRootPart")
    return h ~= nil and r ~= nil and h.Health > 0
end

Player.is_in_alive_folder = function()
    local c = localPlayer.Character
    if not c then return false end
    local a = Workspace:FindFirstChild("Alive")
    return a ~= nil and c.Parent == a
end

Player.is_in_dead_folder = function()
    local c = localPlayer.Character
    if not c then return false end
    local d = Workspace:FindFirstChild("Dead")
    return d ~= nil and c.Parent == d
end

Player.get_alive_chars = function()
    if Z.cache.alive_chars_frame == Z.cache.current_frame then return Z.cache.alive_chars end
    Z.cache.alive_chars_frame = Z.cache.current_frame
    local a = Workspace:FindFirstChild("Alive")
    if a then
        Z.cache.alive_chars = a:GetChildren()
    else
        Z.cache.alive_chars = {}
    end
    return Z.cache.alive_chars
end

Player.is_char_in_alive = function(char)
    if not char then return false end
    local a = Workspace:FindFirstChild("Alive")
    return a ~= nil and char.Parent == a
end

Player.get_char_label = function(char)
    if not char then return "" end
    local p = Players:GetPlayerFromCharacter(char)
    return p and p.DisplayName or char.Name
end

Player.get_aim_part = function(model)
    if not model or not model.Parent then return nil end
    if model:IsA("BasePart") then return model end
    if model:IsA("Model") then
        return model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    end
    return nil
end

Player.get_aim_highlight_root = function(model)
    if not model then return nil end
    if model:IsA("Model") then return model end
    if model:IsA("BasePart") then
        local p = model.Parent
        if p and p:IsA("Model") then return p end
        return model
    end
    return nil
end

Player.has_singularity_cape = function()
    local c = localPlayer.Character
    if not c or not c.PrimaryPart then return false end
    return c.PrimaryPart:FindFirstChild("SingularityCape") ~= nil
end

Player.nearest_alive_distance = function(pos)
    local cd = Z.curve_detection
    local frame = Z.cache.current_frame
    if cd.near_frame == frame and type(cd.near_dist) == "number" then return cd.near_dist end
    local me = localPlayer.Character
    cd.opp_root = nil
    cd.opp_char = nil
    local chars = Player.get_alive_chars()
    local best, bestRoot, bestChar = 1e9, nil, nil
    local nearest = 1e9
    for i = 1, #chars do
        local c = chars[i]
        if c ~= me then
            local r = c:FindFirstChild("HumanoidRootPart")
            if r then
                local d = (r.Position - pos).Magnitude
                if d < best then
                    best = d
                    bestRoot = r
                    bestChar = c
                end
                if Players:GetPlayerFromCharacter(c) and d < nearest then
                    cd.opp_root = r
                    cd.opp_char = c
                    nearest = d
                end
            end
        end
    end
    if not cd.opp_root then
        cd.opp_root = bestRoot
        cd.opp_char = bestChar
        nearest = best
    end
    cd.near_frame = frame
    cd.near_dist = nearest
    return nearest
end

Player.get_closest_parry_target = function(mousePos)
    if Player.is_in_dead_folder() then
        local t = Z.lobby_targets_get_closest(mousePos)
        if t and Z.lobby_is_target(t) then return t end
        return nil
    end
    if not Player.get_root() then return nil end
    local best, bestChar = HUGENUM, nil
    for _, c in ipairs(Player.get_alive_chars()) do
        if c.Name ~= localPlayer.Name then
            local r = c:FindFirstChild("HumanoidRootPart")
            if r then
                local sp = currentCamera:WorldToViewportPoint(r.Position)
                if sp.Z > 0 then
                    local d = (mousePos - Vector2.new(sp.X, sp.Y)).Magnitude
                    if d < best then best = d; bestChar = c end
                end
            end
        end
    end
    return bestChar
end

Player.get_closest_to_cursor = function()
    if Z.cache.closest_frame == Z.cache.current_frame then return Z.cache.closest_char end
    Z.cache.closest_frame = Z.cache.current_frame
    Z.cache.closest_char = Player.get_closest_parry_target(UserInputService:GetMouseLocation())
    return Z.cache.closest_char
end

Player.get_closest_to_aim = function()
    if not Z.config.is_mobile then return Player.get_closest_to_cursor() end
    if Z.cache.closest_aim_frame == Z.cache.current_frame then return Z.cache.closest_aim_char end
    Z.cache.closest_aim_frame = Z.cache.current_frame
    local vp = currentCamera.ViewportSize
    Z.cache.closest_aim_char = Player.get_closest_parry_target(Vector2.new(vp.X/2, vp.Y/2))
    return Z.cache.closest_aim_char
end

-- ============================================================
-- LOBBY TRAINING HELPERS
-- ============================================================
Z.lobby_is_target_name = function(name)
    return type(name) == "string" and name:match("^Target<") ~= nil
end

Z.lobby_is_target = function(obj)
    return typeof(obj) == "Instance" and Z.lobby_is_target_name(obj.Name)
end

Z.lobby_is_target_alive = function(obj)
    if not obj or not obj.Parent then return false end
    local h = obj:GetAttribute("Health")
    if type(h) ~= "number" then return true end
    return h > 0
end

Z.lobby_targets = { scan_frame = -1, targets = {} }

Z.lobby_scan = function()
    local lt = Z.lobby_targets
    if lt.scan_frame == Z.cache.current_frame then return end
    lt.scan_frame = Z.cache.current_frame
    table.clear(lt.targets)
    local lobby = Workspace:FindFirstChild("Spawn")
    lobby = lobby and lobby:FindFirstChild("LobbyTraining")
    lobby = lobby and lobby:FindFirstChild("Lobby")
    if not lobby then return end
    for _, d in ipairs(lobby:GetDescendants()) do
        if Z.lobby_is_target_name(d.Name) then
            table.insert(lt.targets, d)
        end
    end
end

Z.lobby_get_live = function()
    Z.lobby_scan()
    local out = {}
    for _, t in ipairs(Z.lobby_targets.targets) do
        if t.Parent and Z.lobby_is_target_alive(t) then table.insert(out, t) end
    end
    return out
end

Z.lobby_targets_get_closest = function(screenPos)
    if not screenPos then return nil end
    local best, bestObj = HUGENUM, nil
    for _, t in ipairs(Z.lobby_get_live()) do
        local p = Player.get_aim_part(t)
        if p then
            local sp = currentCamera:WorldToViewportPoint(p.Position)
            if sp.Z > 0 then
                local d = (screenPos - Vector2.new(sp.X, sp.Y)).Magnitude
                if d < best then best = d; bestObj = t end
            end
        end
    end
    return bestObj
end

-- ============================================================
-- CURVE DETECTION (the crown jewel)
-- ============================================================
local Curve = {}

-- Tuning: extracted from devirt literals
local DEFAULT_TUNING = {
    strafe_to_opp_dot = 0.4,
    strafe_stand_ratio = 0.65,
    strafe_move_ratio = 0.4,
    leftover_phys_ratio = 1.8,
    teleport_min_jump = 40,
    teleport_step_factor = 8,
    same_position_epsilon = 0.01,
    stale_seconds = 1.5,
    possession_gap = 0.25,
    phys_away_dot = -0.5,
    phys_away_min_speed = 60,
    phys_release_dot = 0,
    phys_release_stop_speed = 40,
    phys_release_stop_dot = -0.15,
    phys_pass_max_distance = 30,
    curve_return_acc_bonus = 1.2,
    relatch_distance = 18,
    preturn_zoomies_max = 0.995,
    preturn_zoomies_min = 0.3,
    preturn_alv_min = 0.97,
    preturn_max_age = 0.35,
    preturn_min_dist = 3,
    preturn_straighten_eps = 0.01,
    preturn_close_distance = 42,
    preturn_close_max_age = 0.2,
    preturn_close_zoomies_max = 0.92,
    preturn_close_alv_min = 0.5,
    preturn_move_min_speed = 4,
    preturn_move_relax_rate = 0.003,
    preturn_move_relax_max = 0.15,
    preturn_min_flip_interval = 0.25,
    close_hit_zoomies_ratio = 0.7,
    click_min_raw = 0.3,
    click_min_alv_dot = 0.5,
    hover_click_tti = 0.25,
    hit_radius = 8,
    curve_return_max_dist = 275,
    relatch_min_age = 0.2,
    preturn_turning_eps = 0.015,
    preturn_min_alv = 20,
    preturn_decel_ratio = 0.95,
    preturn_decel_alv_min = 0.9,
    preturn_decel_ref_min = 0.84,
    preturn_rise_ratio = 1.03,
    preturn_speed_lie_ratio = 0.5,
    preturn_strafe_zoomies_max = 0.92,
    preturn_rise_eps = 0.002,
    close_side_raw_min = -0.7,
    flip_wait_min_dist = 40,
    straight_wait_min_opp = 100,
    close_hit_floor = 12,
    close_hit_alv_min = 0.3,
    close_hit_min_speed = 10,
    close_hit_tti = 0.12,
    close_hit_accel_min = 500,
    close_hit_project_min = 60,
    close_hit_raw_max = -0.5,
    close_hit_time_max_dist = 90,
    close_hit_react = 0.015,
    phys_pass_graze_dot = -0.85,
    interp_dead_alv = 15,
    interp_dead_zoomies = 80,
    interp_snap_min = 25,
    close_linear_opp = 80,
    interp_preturn_raw_max = 0.96,
    hover_parked_min_dist = 30,
    flip_click_max_tti = 0.1,
    close_side_pass_distance = 42,
    close_side_pass_ratio = 0.75,
    recede_min = 0.12,
    away_dot = -0.5,
}
Z.curve_detection.tuning = DEFAULT_TUNING

local function clamp(v, a, b) if v < a then return a elseif v > b then return b end return v end
local function lerp(a, b, t) return a + (b - a) * t end
local function sign(x) if x > 0 then return 1 elseif x < 0 then return -1 end return 0 end

-- Ball state management
local function reset_per_ball_state(ballId)
    local cd = Z.curve_detection
    if not cd.per_ball then return end
    local b = cd.per_ball[ballId]
    if not b then return end
    local keep = {}
    for k, v in pairs(b) do keep[k] = v end
    for k in pairs(b) do b[k] = nil end
    b.prev_ball_dir = nil; b.prev_sin = nil
    b.lerp_angular = 0; b.lerp_angular_toward = 0; b.lerp_sin = 0
    b.dot_history = {}; b.curve_signal = 0; b.backwards_signal = 0
    b.close_back_signal = 0; b.linear_miss_signal = 0
    b.angular_velocity_smooth = 0; b.last_linear_time = 0
    b.last_curve_label = nil; b.last_root_pos = nil
    b.last_closest = nil; b.last_dot = nil
    b.last_curved = false; b.last_bwd = false
    b.last_decision_time = 0
    b.dot_fast = 0; b.dot_slow = 0
    b.dot_tension_peak = 0; b.last_dot_tension_peak = 0
    b.bwd_parry_streak = 0; b.dot_drop_peak = 0; b.kappa_peak = 0
    b.parry_latched = keep.parry_latched
    b.parry_latched_at = keep.parry_latched_at
end

Z.reset_per_ball_state = reset_per_ball_state

-- physical state init
local function init_phys(per_ball, prev_call_time, last_pos)
    per_ball.ac_version = 3
    per_ball.server_parried_seq = nil
    per_ball.server_parried_phase = nil
    per_ball.server_parried_from = nil
    per_ball.server_parried_at = nil
    per_ball.prev_ball_dir = nil
    per_ball.prev_call_time = prev_call_time
    per_ball.last_sample_time = prev_call_time
    per_ball.last_position = last_pos
    per_ball.last_root_pos = nil
    per_ball.last_curve_label = nil
    per_ball.last_closest = nil
    per_ball.last_dot = nil
    per_ball.last_raw_dot = nil
    per_ball.last_alv_dot = nil
    per_ball.last_dist = nil
    per_ball.last_curved = false
    per_ball.last_bwd = false
    per_ball.last_decision_time = 0
    per_ball.physical_away = per_ball.physical_away == true
    per_ball.last_motion_dot = per_ball.last_motion_dot
    per_ball.phys_from = nil
    per_ball.phys_flip_t = nil
    per_ball.phys_went_away = false
    per_ball.phys_released = false
    per_ball.phys_saw_negative = false
    per_ball.phys_preturn = false
    per_ball.phys_preturn_dot0 = nil
    per_ball.phys_preturn_pos0 = nil
    per_ball.phys_preturn_speed0 = nil
    per_ball.phys_preturn_veto = nil
    per_ball.phys_late_entry = nil
    per_ball.phys_speed_peak = nil
    per_ball.phys_speed_ref = nil
    per_ball.phys_speed_min = nil
    per_ball.phys_peak = 0
    per_ball.phys_flip_alv = nil
    per_ball.phys_flip_dist = nil
    per_ball.phys_seen_approach = false
    per_ball.physical_hold = false
    per_ball.parry_latched = per_ball.parry_latched
    per_ball.parry_latched_at = per_ball.parry_latched_at
    per_ball.parry_latch_away_n = per_ball.parry_latch_away_n
    per_ball.parry_latch_away_t = per_ball.parry_latch_away_t
    per_ball.parry_latch_last_t = per_ball.parry_latch_last_t
    per_ball.parry_latch_sample_time = per_ball.parry_latch_sample_time
    per_ball.parry_latch_last_dist = per_ball.parry_latch_last_dist
end

-- Physical detection
local function phys_detect(per_ball, tuning, dotVal, alvDot, flipAlv, alvMag, alvAccel, from, wentAway, released, sawNeg, flipDist, oppDist, speed, speedRef, speedPeak, possessionAge, lastRawDot)
    local out = nil
    if per_ball.phys_went_away then
        if dotVal < 0 then per_ball.phys_saw_negative = true end
        local released2 = not per_ball.phys_released
        if released2 then released2 = not (possessionAge == true and dotVal < 0) end
        if released2 then
            released2 = alvDot > (tuning.phys_release_dot or 0)
            if not released2 then
                released2 = flipAlv < (tuning.phys_release_stop_speed or 40)
                if released2 then released2 = alvDot >= (tuning.phys_release_stop_dot or -0.15) end
            end
        end
        if released2 then per_ball.phys_released = true end

        local neg = dotVal < 0
        if neg then
            neg = not per_ball.phys_released
            if not neg then
                neg = alvDot > (tuning.close_hit_alv_min or 0.3)
                if neg then neg = flipAlv > (tuning.phys_away_min_speed or 60) end
            end
        end
        if neg then
            out = "phys_away"
        elseif not per_ball.phys_released then
            if alvDot < (tuning.phys_away_dot or -0.5) then
                if per_ball.phys_flip_alv == nil then
                    per_ball.phys_flip_alv = flipAlv
                    per_ball.phys_flip_dist = flipDist
                end
                local n = (clamp(Z.config.accuracy or 50, 1, 100) - 1) / 99
                local strafeToOppDot = tuning.strafe_to_opp_dot or 0.4
                local keep_waiting
                if per_ball.phys_saw_negative == true then
                    local ok = (per_ball.phys_flip_dist or 0) > (tuning.flip_wait_min_dist or 40)
                    if not ok then ok = (per_ball.phys_flip_dist or 0) <= (tuning.preturn_close_distance or 42) end
                    keep_waiting = ok and flipAlv >= per_ball.phys_flip_alv * (1 - n)
                else
                    local dist2 = per_ball.phys_flip_dist or flipDist
                    local n33 = 0
                    if type(possessionAge) == "number" and possessionAge < 1e8 then n33 = possessionAge - dist2 end
                    local flag20 = type(possessionAge) == "number" and possessionAge < 1e8
                    local flag21 = flag20 and possessionAge >= (tuning.straight_wait_min_opp or 100)
                    flag21 = flag21 and n33 > 1
                    if flag21 then flag21 = dist2 > (tuning.phys_pass_max_distance or 30) end
                    if flag21 then
                        keep_waiting = (flipDist - dist2) / n33 < n
                    else
                        flag20 = flipDist > (tuning.phys_pass_max_distance or 30) and n > 0 and flag20
                        if flag20 then flag20 = dist2 > (tuning.phys_pass_max_distance or 30) end
                        keep_waiting = flag20 and true or false
                    end
                end
                local passable = per_ball.phys_saw_negative ~= true
                if passable then passable = flipDist <= (tuning.phys_pass_max_distance or 30) end
                if passable then passable = alvDot > (tuning.phys_pass_graze_dot or -0.85) end
                if passable then
                    out = "phys_pass"
                elseif keep_waiting then
                    out = "phys_flip_wait"
                end
            else
                local passable = per_ball.phys_saw_negative ~= true
                if passable then passable = flipDist <= (tuning.phys_pass_max_distance or 30) end
                if passable then passable = alvDot > (tuning.phys_pass_graze_dot or -0.85) end
                if passable then out = "phys_pass" end
            end
        end
        if out == nil and dotVal >= 0 and flipDist > (tuning.curve_return_max_dist or 200) then
            out = "phys_far_return"
        end
    else
        local recentFlip = (per_ball.phys_flip_interval or 999) < (tuning.preturn_min_flip_interval or 0.35)
        local alvOk = flipAlv >= (tuning.preturn_min_alv or 20)
        local riseOk = per_ball.last_raw_dot == nil or dotVal <= per_ball.last_raw_dot + (tuning.preturn_rise_eps or 0.002)
        local speedPeak2 = per_ball.phys_speed_peak or speed
        local rising = speed > (per_ball.phys_speed_min or speed) * (tuning.preturn_rise_ratio or 1.03)
        local decel = not rising and speed <= speedPeak2 * (tuning.preturn_decel_ratio or 0.95)
        local speedRef2 = speedRef
        local refOk = not decel and not rising and type(speedRef2) == "number"
        if refOk and speedRef2 > speedPeak2 then
            decel = speed <= speedRef2 * (tuning.preturn_decel_ratio or 0.95)
            if decel then decel = speed >= speedRef2 * (tuning.preturn_decel_ref_min or 0.84) end
        end

        local close25 = alvOk and not recentFlip and riseOk and possessionAge and possessionAge < (tuning.preturn_close_max_age or 0.2)
        local distOk = close25 and flipDist > (tuning.preturn_min_dist or 3)
        if distOk then distOk = flipDist <= (tuning.preturn_close_distance or 42) end
        if distOk then distOk = dotVal < (tuning.preturn_close_zoomies_max or 0.92) or decel end
        if distOk then distOk = dotVal > (tuning.preturn_zoomies_min or 0.3) end
        local moveRelax = 0
        if (alvMag or 0) > (tuning.preturn_move_min_speed or 4) then
            moveRelax = math.min((alvMag or 0) * (tuning.preturn_move_relax_rate or 0.003), tuning.preturn_move_relax_max or 0.15)
        end
        if distOk then distOk = alvDot > (tuning.preturn_close_alv_min or 0.5) - moveRelax end

        local alvMin = tuning.preturn_alv_min or 0.97
        if decel then alvMin = tuning.preturn_decel_alv_min or 0.9 end
        local fast = alvDot < (tuning.preturn_zoomies_max or 0.995)
        if fast then
            local spd2 = 0
            spd2 = math.sqrt((alvMag or 0) * (alvMag or 0)) -- placeholder; real code uses alv vector, not speed
        end
        if not recentFlip and riseOk and not rising then
            local ok = possessionAge and possessionAge < (tuning.preturn_max_age or 0.35)
            if ok then ok = flipDist > (tuning.preturn_min_dist or 3) end
            ok = ok and (fast or decel)
            if ok then ok = dotVal > (tuning.preturn_zoomies_min or 0.3) end
            if not per_ball.phys_preturn and per_ball.phys_preturn_veto ~= true and (distOk or (ok and alvDot > alvMin - moveRelax)) then
                per_ball.phys_preturn = true
                per_ball.phys_preturn_dot0 = dotVal
                per_ball.phys_preturn_pos0 = per_ball.phys_preturn_pos0
                per_ball.phys_preturn_speed0 = per_ball.phys_preturn_speed0
            end
        end

        if per_ball.phys_preturn then
            if (per_ball.phys_preturn_speed0 or speed) * (tuning.preturn_rise_ratio or 1.03) < speed then
                per_ball.phys_preturn = false
                per_ball.phys_preturn_veto = true
            end
        end

        if per_ball.phys_preturn then
            local p0 = per_ball.phys_preturn_pos0
            local dotNew
            if p0 ~= nil then
                local d = p0 - per_ball.last_position
                local m = d.Magnitude
                if m > 0.001 then dotNew = (d/m):Dot(per_ball.prev_ball_dir) else dotNew = dotVal end
            else
                dotNew = dotVal
            end
            local turning = dotNew < (per_ball.phys_preturn_dot0 or dotNew) - (tuning.preturn_turning_eps or 0.015)
            local lie = flipAlv > (tuning.phys_away_min_speed or 60)
            if lie then lie = speed < flipAlv * (tuning.preturn_speed_lie_ratio or 0.5) end

            if not alvOk then
                per_ball.phys_preturn = false
            else
                lie = not decel or lie
                if lie then lie = dotNew >= (tuning.preturn_zoomies_max or 0.985) end
                if lie and alvDot > 0.9 then
                    per_ball.phys_preturn = false
                else
                    local straighten = not decel
                    if straighten then straighten = dotNew > (per_ball.phys_preturn_dot0 or dotNew) + (tuning.preturn_straighten_eps or 0.01) end
                    if straighten then
                        per_ball.phys_preturn = false
                    elseif possessionAge and possessionAge > (tuning.preturn_max_age or 0.35) and alvDot > 0.5 and not turning then
                        per_ball.phys_preturn = false
                    end
                end
            end
        end

        out = per_ball.phys_preturn and "phys_preturn" or nil
    end

    if out == nil and dotVal < 0 then
        if dotVal <= (tuning.close_hit_raw_max or -0.5) then
            out = "phys_away"
        else
            -- treat as phys_away still
            if alvDot > (tuning.close_hit_alv_min or 0.3) then
                if flipAlv > (tuning.phys_away_min_speed or 60) then out = "phys_away" end
            end
        end
    end
    return out
end

-- Legacy curve check
local function curve_check(part, model, vel, speed, dist, rootPos, rootVel)
    if speed < 1 then return false, false end
    local toRoot = rootPos - part.Position
    if dist < 0.001 then return false, false end
    local dot = toRoot.Unit:Dot(vel.Unit)
    local bwd = dot < 0
    local ping = Z.cache.get_ping() or 50
    local tti = dist / speed - ping * 0.001
    local thresh = 15 - math.min(dist / 1000, 15) + math.min(speed / 100, 40)
    if dist < thresh then return false, bwd end

    local cd = Z.curve_detection
    local key = part
    local state = cd.per_ball[key]
    if not state then state = { last_dir=nil, last_warping=0, lerp=0, redirect_at=0 }; cd.per_ball[key] = state end
    local now = tick()
    local window = tti / 1.5
    if now - (cd.curve_time or 0) < window then return true, bwd end

    local v = vel
    local rel = rootVel and (rootVel - v) or (rootVel - v)
    local d = 0.5 - ping * 0.001
    if dot - toRoot.Unit:Dot(rel or Vector3.new()) < d then return true, bwd end
    local ang = math.rad(math.asin(clamp(dot, -1, 1)))
    local smoothed = (state.lerp or 0) + (ang - (state.lerp or 0)) * 0.8
    state.lerp = smoothed
    if smoothed < 0.018 then state.last_warping = now end
    if now - (state.last_warping or 0) < window then return true, bwd end
    return dot < d, bwd
end

Ball.is_curved = function(part, model, vel, speed, dist, rootPos, rootVel)
    -- simplified: use legacy check for stability. Backward-detect is what matters.
    return curve_check(part, model, vel or Ball.get_velocity(part, model), speed or (vel or Ball.get_velocity(part, model)).Magnitude, dist, rootPos, rootVel)
end

-- ============================================================
-- PARRY DISTANCE FUNCTIONS
-- ============================================================
local Parry = {}

Parry.get_divisor_multiplier = function(acc)
    local a = clamp(acc or Z.config.accuracy, 1, 100)
    return 1.15 + ((Z.cache.get_ping() or 50) - 30) / 170 * -0.9 + (a - 1) * 0.005050505050505051
end

Parry.get_legacy_parry_distance = function(dist, acc)
    local a = clamp(acc or Z.config.accuracy, 1, 100)
    local ping = Z.cache.get_ping() or 50
    local base = 1.15 + (ping - 30) / 170 * -0.9
    local mult = 0.35 / clamp(tonumber(Z.config.parry_distance_multiplier) or 1, 0.1, 4)
    local aa = base + (a - 1) * (mult / 99)
    local cc = clamp(a / 10 / 10, 5, 17)
    local s = (2.4 + math.min(math.max(dist - 9.5, 0), 650) * 0.002) * aa
    return cc + math.max(dist / s, 9.5)
end

Parry.get_premium_parry_distance = function(dist, acc)
    local ping = Z.cache.get_ping() or 50
    local a = clamp(3.25 + ping * 0.04, 4, 16)
    local div = Parry.get_divisor_multiplier(acc)
    local s = (2.4 + math.max(dist - 9.5, 0) * 0.002) * div
    local g = clamp(ping / 1000, 0, 0.45)
    local e = ((clamp(acc or Z.config.accuracy, 1, 100) - 1) / 99) ^ 3
    local c = a + math.max(dist / math.max(s, 0.15), 9.5)
    local l = a + math.max(dist * (g * 0.5 + 0.1), 9.5)
    c = c + (math.min(c, l) - c) * e
    local s2 = dist * (g * 0.5 + 0.15 - 0.05 * e)
    return (c < s2) and s2 or c
end

Parry.get_zenthra_parry_distance = function(dist, acc)
    local a = clamp(acc or Z.config.accuracy, 1, 100)
    local ping = Z.cache.get_ping() or 50
    local base = 1.15 + (a - 30) / 170 * -0.9
    local mult = 0.3 / clamp(tonumber(Z.config.parry_distance_multiplier) or 1, 0.1, 10)
    local aa = base + (a - 1) * (mult / 99)
    local cc = clamp(3.25 + a * 0.04, 4, 16)
    local s = (2.4 + math.min(math.max(dist - 9.5, 0), 650) * 0.002) * aa
    return cc + math.max(dist / math.max(s, 0.15), 9.5)
end

Parry.fire_gap_for = function(ping, tight)
    ping = ping or 0
    if tight then return clamp(ping * 0.35, 0.016, 0.04) end
    return clamp(ping * 0.5 + 0.018, 0.028, 0.085)
end

-- ============================================================
-- PARRY: DIRECT REMOTE RESOLUTION
-- ============================================================
local DIRECT = {
    remote = nil,
    hash = nil,
    uiddhash = "5455ef47-de02-4074-808c-8d82c2cd12ec",
    resolved = false,
    _warming = false,
    _last_scan = 0,
}
Z.parry = { direct = DIRECT }
Z.parry.reset_per_ball_state = reset_per_ball_state

local function is_uidd(s)
    return type(s) == "string" and #s == 32 and s:match("^%x+$") ~= nil
end

local function get_net_package()
    local packages = localPlayer:FindFirstChild("PlayerScripts")
    local contentFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Packages")
    contentFolder = contentFolder and contentFolder:FindFirstChild("_Index")
    if contentFolder then
        for _, child in ipairs(contentFolder:GetChildren()) do
            if child.Name:sub(1, 13) == "sleitnick_net@" then
                local net = child:FindFirstChild("net")
                if net then return net end
            end
        end
    end
    local ok, net = pcall(function()
        return game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.1.0"].net
    end)
    return ok and net or nil
end

local function is_jobId(str)
    if type(str) ~= "string" or #str == 0 then return false end
    local jid = game.JobId
    if type(jid) ~= "string" or #jid == 0 then return false end
    local stripped = str:gsub("^RE/", "")
    local jidClean = jid:gsub("-", "")
    return stripped == jid or stripped == jidClean
end

local function find_parry_remote(getInstance, name, skip)
    if type(name) ~= "string" or #name == 0 then return nil end
    if skip and skip[name] then return nil end
    if is_jobId(name) then return nil end
    local net = get_net_package()
    if net then
        local r = net:FindFirstChild("RE/" .. name) or net:FindFirstChild("RE/" .. name:gsub("-", ""))
        if r and r.ClassName == "RemoteEvent" then
            if not is_jobId(r.Name) then return r end
        end
    end
    return nil
end

local function hash_remote_via_proto(fn)
    if type(fn) ~= "function" or islclosure(fn) then return false end
    local proto = debug.getproto and debug.getproto(fn, 1, true)
    return false
end

local function scan_and_resolve()
    if DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent and DIRECT.hash then return true end
    if DIRECT._warming then return DIRECT.resolved end
    DIRECT._warming = true
    local ok = false
    for i = 1, 8 do
        if DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent then ok = true; break end
        task.wait(0.15)
    end
    DIRECT._warming = false
    return ok
end

Z.warm_direct = function()
    if is_alt_game() then return end
    if DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent and DIRECT.hash then return end
    if DIRECT._warming then return end
    task.spawn(function()
        for _ = 1, 30 do
            if is_alt_game() then break end
            local ok = scan_and_resolve()
            if ok then break end
            task.wait(0.3)
        end
    end)
end

-- ============================================================
-- PARRY: EXECUTE
-- ============================================================
local function is_alt_game()
    return game.PlaceId == 16044264830
end

local function fire_hardware_key()
    if is_mobile then
        local btn = Z.cache.get_block_button()
        if btn then
            local ap = btn.AbsolutePosition
            local as = btn.AbsoluteSize
            VirtualInputManager:SendMouseButtonEvent(ap.X + as.X/2, ap.Y + as.Y/2, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(ap.X + as.X/2, ap.Y + as.Y/2, 0, false, game, 0)
            return
        end
        local ml = UserInputService:GetMouseLocation()
        if ml then
            VirtualInputManager:SendMouseButtonEvent(ml.X, ml.Y, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(ml.X, ml.Y, 0, false, game, 0)
            return
        end
    end
    local keys = { "F" }
    local ok, binds = pcall(function()
        local sc = game:GetService("ReplicatedStorage"):FindFirstChild("Controllers")
        sc = sc and sc:FindFirstChild("SettingsController")
        if not sc then return nil end
        local mod = require(sc)
        local b = mod:GetBinds("Block")
        local out = {}
        local seen = {}
        local function add(x) if type(x) == "string" and x ~= "" and not seen[x] then seen[x] = true; table.insert(out, x) end end
        if type(b) == "table" then add(b.Bind1); add(b.Bind2); add(b.Bind3) end
        return #out > 0 and out or nil
    end)
    if ok and binds then keys = binds end
    for _, k in ipairs(keys) do
        local kc = Enum.KeyCode[k]
        if typeof(kc) == "EnumItem" and kc ~= Enum.KeyCode.Unknown then
            VirtualInputManager:SendKeyEvent(true, kc, false, game)
            VirtualInputManager:SendKeyEvent(false, kc, false, game)
            return
        end
        if k == "MouseButton1" or k == "MouseButton2" then
            local btn = k == "MouseButton2" and 1 or 0
            local ml = UserInputService:GetMouseLocation()
            if ml then
                VirtualInputManager:SendMouseButtonEvent(ml.X, ml.Y, btn, true, game, 0)
                VirtualInputManager:SendMouseButtonEvent(ml.X, ml.Y, btn, false, game, 0)
                return
            end
        end
    end
end

local function fire_mouse_click()
    if is_mobile then return end
    if not mouse1press then fire_hardware_key(); return end
    task.delay(0.1, function() pcall(mouse1release) end)
end

local function fire_keypress()
    if Z.config.curve_mode == 1 and Z.config.parry_mode == "Keypress" then
        fire_hardware_key()
        return
    end
    local saveCF = currentCamera.CFrame
    local aimCF = Curve.get_cframe()
    currentCamera.CFrame = aimCF
    fire_hardware_key()
    task.spawn(function()
        RunService.RenderStepped:Wait()
        currentCamera.CFrame = saveCF
    end)
end

Z.fire_hardware_key = fire_hardware_key
Z.fire_mouse_click = fire_mouse_click
Z.fire_keypress = fire_keypress

-- Forward: fire on reverted remote
local fn57_cache
local function fn57()
    if fn57_cache then return fn57_cache end
    fn57_cache = function(remote, method, n, ...)
        if Z.state.firing_custom_parry then return nil end
        local args = {...}
        local needed = is_alt_game() and 5 or 8
        if n ~= needed then return nil end
        if not Z.parry.build_args then return nil end
        local cfg = Z.parry.build_args(args)
        if not cfg then return nil end
        DIRECT.remote = remote
        DIRECT.hash = args[2]
        DIRECT.uiddhash = args[1]
        DIRECT.resolved = true
        table.clear(Z.state.reverted_remotes)
        Z.state.reverted_remotes[remote] = args
        Z.parry.rebuild_remote_list()
        return cfg
    end
    return fn57_cache
end

Z.parry.rebuild_remote_list = function()
    local list = {}
    for r, args in pairs(Z.state.reverted_remotes) do
        if r and r.Parent then
            table.insert(list, { remote = r, args = args, is_event = r:IsA("RemoteEvent") })
        else
            Z.state.reverted_remotes[r] = nil
        end
    end
    Z.spam.remote_list = list
    Z.spam.remote_list_dirty = false
end

Z.parry.build_args = function(src)
    if is_alt_game() then
        local out = {}
        out[1] = src[1]; out[2] = src[2]; out[3] = Curve.get_cframe(); out[4] = src[4]; out[5] = src[5]
        return out
    end
    local u, h, c
    if DIRECT.remote and DIRECT.hash then
        u = DIRECT.uiddhash
        h = DIRECT.hash
    end
    return {
        u or src[1],
        h or src[2],
        c or src[3],
        src[4],
        Curve.get_cframe(),
        Z.parry.get_event_data(),
        Z.parry.get_mouse_vec(),
        src[8],
    }
end

Z.parry.get_event_data = function()
    if Z.cache.event_data_frame == Z.cache.current_frame then return Z.cache.event_data end
    Z.cache.event_data_frame = Z.cache.current_frame
    local out = {}
    if Player.is_in_dead_folder() then
        if Curve.get_target_mode_name() ~= "None" then
            local t = Curve.get_parry_target()
            if t and Z.lobby_is_target(t) then
                local p = Player.get_aim_part(t)
                if p then out[t.Name] = currentCamera:WorldToScreenPoint(p.Position) end
            end
        else
            for _, t in ipairs(Z.lobby_get_live()) do
                local p = Player.get_aim_part(t)
                if p then out[t.Name] = currentCamera:WorldToScreenPoint(p.Position) end
            end
        end
        Z.cache.event_data = out
        return out
    end
    if Z.config.target_player_enabled then
        local c = Z.target_player.get_character()
        if c and c.PrimaryPart then
            out[c.Name] = currentCamera:WorldToScreenPoint(c.PrimaryPart.Position)
        end
        Z.cache.event_data = out
        return out
    end
    for _, c in ipairs(Player.get_alive_chars()) do
        if c.PrimaryPart then out[c.Name] = currentCamera:WorldToScreenPoint(c.PrimaryPart.Position) end
    end
    Z.cache.event_data = out
    return out
end

Z.parry.get_mouse_vec = function()
    if Z.cache.mouse_vec_frame == Z.cache.current_frame then return Z.cache.mouse_vec end
    Z.cache.mouse_vec_frame = Z.cache.current_frame
    local out = nil
    if Z.config.target_player_enabled and not Player.is_in_dead_folder() then
        local c = Z.target_player.get_character()
        if c then
            local r = c:FindFirstChild("HumanoidRootPart")
            if r then
                local sp = currentCamera:WorldToScreenPoint(r.Position)
                out = { sp.X, sp.Y }
            end
        end
    end
    if not out and not Z.config.target_player_enabled then
        local target
        if Curve.uses_lobby_targets_only() then
            target = Curve.get_target_mode_name() == "None" and Curve.get_lobby_screen_target() or Curve.get_parry_target()
        elseif Curve.get_target_mode_name() == "None" then
            target = Z.config.is_mobile and Player.get_closest_to_aim() or Player.get_closest_to_cursor()
        else
            target = Curve.get_parry_target()
        end
        if target and Curve.is_valid_target_entity(target) then
            local p = Player.get_aim_part(target)
            if p then
                local sp = currentCamera:WorldToScreenPoint(p.Position)
                out = { sp.X, sp.Y }
            end
        end
    end
    if not out and not Z.config.target_player_enabled and Z.config.is_mobile then
        local vp = currentCamera.ViewportSize
        out = { vp.X/2, vp.Y/2 }
    end
    if not out then
        local ml = UserInputService:GetMouseLocation()
        out = { ml.X, ml.Y }
    end
    Z.cache.mouse_vec = out
    return out
end

Z.parry.execute = function()
    if Z.dribble_locked and Z.dribble_locked() then return false end
    local function resetLast()
        local info = Z.parry._last_target_info
        if info and info.ball_id then reset_per_ball_state(info.ball_id) end
    end
    if Z.config.parry_mode == "Mouse Click" and not Z.config.is_mobile then
        fire_mouse_click()
        task.spawn(Z.anim.play_grab)
        resetLast()
        return true
    end
    if Z.config.parry_mode == "Keypress" then
        fire_keypress()
        task.spawn(Z.anim.play_grab)
        resetLast()
        return true
    end
    if Z.fire_remote() then
        task.spawn(Z.anim.play_grab)
        resetLast()
        return true
    end
    if is_alt_game() and not (DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent) then
        task.spawn(Z.warm_direct)
        fire_hardware_key()
        resetLast()
        return true
    end
    return false
end

Z.parry.execute_fast = function(mode)
    if Z.dribble_locked and Z.dribble_locked() then return false end
    local function resetLast()
        local info = Z.parry._last_target_info
        if info and info.ball_id then reset_per_ball_state(info.ball_id) end
    end
    if mode == "Mouse Click" and not Z.config.is_mobile then
        fire_mouse_click()
        resetLast()
        return
    end
    if mode == "Keypress" then
        fire_hardware_key()
        resetLast()
        return
    end
    if Z.fire_remote(true) then resetLast(); return end
    if is_alt_game() and not (DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent) then
        task.spawn(Z.warm_direct)
        fire_hardware_key()
        resetLast()
    end
end

-- Fire Server via reverted remotes
Z.fire_remote = function(fast)
    if is_alt_game() then
        if not (DIRECT.resolved and DIRECT.remote and DIRECT.remote.Parent) then return false end
        if not DIRECT.hash then return false end
        local args = { DIRECT.uiddhash, DIRECT.hash, "", 0, CFrame.new(), {}, {}, false }
        pcall(function()
            DIRECT.remote:FireServer(table.unpack(args, 1, 8))
        end)
        return true
    end
    local list = Z.spam.remote_list
    if Z.spam.remote_list_dirty then Z.parry.rebuild_remote_list(); list = Z.spam.remote_list end
    if not list or #list == 0 then
        if DIRECT.remote and DIRECT.remote.Parent and DIRECT.hash then
            local args = { DIRECT.uiddhash, DIRECT.hash, "", 0, CFrame.new(), {}, {}, false }
            local ok = pcall(function()
                DIRECT.remote:FireServer(table.unpack(args, 1, 8))
            end)
            return ok
        end
        return false
    end
    local entry = list[1]
    if not entry or not entry.remote or not entry.remote.Parent then
        Z.parry.rebuild_remote_list()
        return false
    end
    local cfg = entry.args
    if not cfg then return false end
    local finalArgs
    if Z.state.parry_busy_targets and Z.state.parry_busy_entry then
        -- use existing
        finalArgs = cfg
    else
        finalArgs = Z.parry.build_args(cfg)
    end
    Z.state.firing_custom_parry = true
    local ok = pcall(function()
        entry.remote:FireServer(table.unpack(finalArgs, 1, 8))
    end)
    Z.state.firing_custom_parry = false
    return ok
end

-- ============================================================
-- PARRY: REMOTE HOOK
-- ============================================================
local function hook_remote(remote)
    if Z.state.reverted_remotes[remote] then return end
    local cls = remote.ClassName
    if type(hookfunction) == "function" then
        if (cls == "RemoteEvent" or cls == "UnreliableRemoteEvent") and not Z.state.fire_server_hooked then
            local ok = pcall(function()
                local fn = hookfunction(remote.FireServer, function(self, ...)
                    local args = {...}
                    local n = select("#", ...)
                    local handled = fn57()(self, "FireServer", n, table.unpack(args, 1, n))
                    if handled then
                        return
                    end
                    return remote.FireServer(self, table.unpack(args, 1, n))
                end)
                if type(fn) == "function" then Z.state.fire_server_hooked = true end
            end)
            if ok then return end
        elseif cls == "RemoteFunction" and not Z.state.invoke_server_hooked then
            local ok = pcall(function()
                local fn = hookfunction(remote.InvokeServer, function(self, ...)
                    local args = {...}
                    local n = select("#", ...)
                    local handled = fn57()(self, "InvokeServer", n, table.unpack(args, 1, n))
                    if handled then return end
                    return remote.InvokeServer(self, table.unpack(args, 1, n))
                end)
                if type(fn) == "function" then Z.state.invoke_server_hooked = true end
            end)
            if ok then return end
        end
    end
    -- metamethod fallback
    local mt = getrawmetatable(remote)
    if Z.state.hooked_metatables[mt] then return end
    Z.state.hooked_metatables[mt] = true
    setreadonly(mt, false)
    local indexFn = mt.__index
    if type(getnamecallmethod) == "function" then
        local namecall = mt.__namecall
        mt.__namecall = function(self, ...)
            local method = getnamecallmethod()
            if method ~= "FireServer" and method ~= "InvokeServer" then
                return namecall(self, ...)
            end
            local c = self.ClassName
            local isEvent = method == "FireServer" and c == "RemoteEvent"
            local isFn = method == "InvokeServer" and c == "RemoteFunction"
            if not (isEvent or isFn) then
                return namecall(self, ...)
            end
            local ok, fn = pcall(indexFn, self, method)
            if not ok or type(fn) ~= "function" then return namecall(self, ...) end
            local n = select("#", ...)
            local handled = fn57()(self, method, n, ...)
            if handled then
                return fn(self, table.unpack(handled, 1, select("#", table.unpack(handled))))
            end
            return namecall(self, ...)
        end
    else
        mt.__index = function(self, key)
            if key == "FireServer" and self.ClassName == "RemoteEvent" then
                local fn = indexFn(self, key)
                return function(s, ...)
                    local handled = fn57()(s, "FireServer", select("#", ...), ...)
                    if handled then return end
                    return fn(s, ...)
                end
            end
            if key == "InvokeServer" and self.ClassName == "RemoteFunction" then
                local fn = indexFn(self, key)
                return function(s, ...)
                    local handled = fn57()(s, "InvokeServer", select("#", ...), ...)
                    if handled then return end
                    return fn(s, ...)
                end
            end
            return indexFn(self, key)
        end
    end
    setreadonly(mt, true)
end

Z.hook_remote = hook_remote

Z.remote_init = function()
    for _, child in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            hook_remote(child)
        end
    end
    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
    if remotes then
        for _, child in ipairs(remotes:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                hook_remote(child)
            end
        end
        track(remotes.ChildAdded:Connect(function(c)
            if c:IsA("RemoteEvent") or c:IsA("RemoteFunction") then hook_remote(c) end
        end))
    end
    track(game:GetService("ReplicatedStorage").ChildAdded:Connect(function(c)
        if c:IsA("RemoteEvent") or c:IsA("RemoteFunction") then hook_remote(c) end
    end))
end

-- ============================================================
-- CURVE: TARGETING + PARRY TARGET
-- ============================================================
Curve.get_target_mode_name = function()
    local modes = {"None", "Farthest", "Closest", "Random"}
    local m = Z.config.target_mode or 3
    return modes[m] or "Closest"
end

Curve.uses_lobby_targets_only = function() return Player.is_in_dead_folder() end

Curve.is_valid_target_entity = function(obj)
    if not obj or not obj.Parent then return false end
    if Curve.uses_lobby_targets_only() then
        return Z.lobby_is_target(obj) and Z.lobby_is_target_alive(obj)
    end
    if obj == localPlayer.Character then return false end
    return Player.is_char_in_alive(obj)
end

Curve.get_lobby_screen_target = function(pos)
    if not pos then
        if Z.config.is_mobile then
            local vp = currentCamera.ViewportSize
            pos = Vector2.new(vp.X/2, vp.Y/2)
        else
            pos = UserInputService:GetMouseLocation()
        end
    end
    return Z.lobby_targets_get_closest(pos)
end

Curve.get_entity_world_pos = function(obj)
    if not obj or not obj.Parent then return nil end
    if obj:IsA("Model") then
        local ok, cf = pcall(function() return obj:GetPivot() end)
        if ok and cf then return cf.Position end
    end
    local p = Player.get_aim_part(obj)
    return p and p.Position
end

Curve.measure_target_distance = function(from, obj, mode)
    local pos = Curve.get_entity_world_pos(obj)
    if not pos then return nil end
    local d = pos - from
    if mode == "Farthest" then return d.Magnitude end
    return Vector3.new(d.X, 0, d.Z).Magnitude
end

Curve.collect_parry_targets = function()
    if Curve.uses_lobby_targets_only() then
        local out = {}
        for _, t in ipairs(Z.lobby_get_live()) do
            if Z.lobby_is_target(t) then table.insert(out, t) end
        end
        return out
    end
    local me = localPlayer.Character
    local out = {}
    for _, c in ipairs(Player.get_alive_chars()) do
        if c ~= me and Curve.is_valid_target_entity(c) then
            if c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart then
                table.insert(out, c)
            end
        end
    end
    return out
end

Curve.get_parry_target = function()
    if Z.cache.parry_target_frame == Z.cache.current_frame then return Z.cache.parry_target end
    Z.cache.parry_target_frame = Z.cache.current_frame
    if Ball.should_disable_aim_for_invis() then Z.cache.parry_target = nil; return nil end
    if Curve.get_target_mode_name() == "None" then Z.cache.parry_target = nil; return nil end
    local list = Curve.collect_parry_targets()
    if #list == 0 then Z.cache.parry_target = nil; return nil end
    local mode = Curve.get_target_mode_name()
    if mode == "Random" then
        local pick = list[math.random(1, #list)]
        Z.cache.parry_target = Curve.is_valid_target_entity(pick) and pick or nil
        return Z.cache.parry_target
    end
    local root = Player.get_root()
    if not root then
        local first = list[1]
        Z.cache.parry_target = Curve.is_valid_target_entity(first) and first or nil
        return Z.cache.parry_target
    end
    local from = root.Position
    local best = mode == "Farthest" and -HUGENUM or HUGENUM
    local bestObj = nil
    for _, c in ipairs(list) do
        if Curve.is_valid_target_entity(c) then
            local d = Curve.measure_target_distance(from, c, mode)
            if d then
                if mode == "Farthest" then
                    if d > best then best = d; bestObj = c end
                else
                    if d < best then best = d; bestObj = c end
                end
            end
        end
    end
    Z.cache.parry_target = bestObj
    return bestObj
end

Curve.get_target_pos = function()
    if Ball.should_disable_aim_for_invis() then
        if Z.config.curve_mode == 1 then
            return currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * 100
        end
        local r = Player.get_root()
        return r and (r.Position + currentCamera.CFrame.LookVector * 100)
    end
    if Z.config.target_player_enabled and not Player.is_in_dead_folder() then
        local c = Z.target_player.get_character()
        if c then
            local r = c:FindFirstChild("HumanoidRootPart")
            if r then return r.Position end
        end
        if Z.config.curve_mode == 1 then
            return currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * 100
        end
        local r = Player.get_root()
        return r and (r.Position + currentCamera.CFrame.LookVector * 100)
    end
    local mode = Curve.get_target_mode_name()
    if Curve.uses_lobby_targets_only() then
        local t = (mode == "None") and Curve.get_lobby_screen_target() or Curve.get_parry_target()
        if t and Z.lobby_is_target(t) then
            local p = Player.get_aim_part(t)
            if p then return p.Position end
        end
    elseif mode == "None" then
        local t = Z.config.is_mobile and Player.get_closest_to_aim() or Player.get_closest_to_cursor()
        if t and Curve.is_valid_target_entity(t) then
            local p = Player.get_aim_part(t)
            if p then return p.Position end
        end
    else
        local t = Curve.get_parry_target()
        if t and Curve.is_valid_target_entity(t) then
            local p = Player.get_aim_part(t)
            if p then return p.Position end
        end
    end
    if Z.config.curve_mode == 1 then
        return currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * 100
    end
    local r = Player.get_root()
    return r and (r.Position + currentCamera.CFrame.LookVector * 100)
end

Curve.get_cframe = function()
    if Z.cache.cframe_frame == Z.cache.current_frame then return Z.cache.cframe end
    Z.cache.cframe_frame = Z.cache.current_frame
    local root = Player.get_root()
    if not root then
        Z.cache.cframe = currentCamera.CFrame
        return currentCamera.CFrame
    end
    local target = Curve.get_target_pos() or (root.Position + currentCamera.CFrame.LookVector * 100)
    local right = currentCamera.CFrame.RightVector
    local up = Vector3.new(0, 1, 0)
    local toTarget = target - root.Position
    local forward = toTarget.Magnitude > 0.001 and -toTarget.Unit or -currentCamera.CFrame.LookVector
    local mode = Z.config.curve_mode
    local cf
    if mode == 1 then
        cf = currentCamera.CFrame
    elseif mode == 2 then
        local rand = math.random
        local sx = rand(0, 1) == 0 and -1 or 1
        local k = rand(1, 6)
        local v
        if k == 1 then v = forward * rand(7000, 12000) + right * (sx * rand(2000, 5000)) + up * rand(3000, 6000)
        elseif k == 2 then v = forward * rand(8000, 15000) + right * (sx * rand(1500, 4000)) + up * rand(2000, 5000)
        elseif k == 3 then v = right * (sx * rand(8000, 15000)) + forward * rand(2000, 5000) + up * rand(2000, 5000)
        elseif k == 4 then v = right * (sx * rand(10000, 18000)) + forward * rand(1000, 3000) + up * rand(1500, 4000)
        elseif k == 5 then v = forward * rand(10000, 18000) + right * (sx * rand(3000, 6000)) + up * rand(2500, 5500)
        else v = up * rand(6000, 10000) + forward * rand(4000, 8000) + right * (sx * rand(2000, 5000)) end
        cf = CFrame.new(root.Position, target + v)
    elseif mode == 3 then
        cf = CFrame.new(root.Position, target + Vector3.new(0, 5, 0))
    elseif mode == 4 then
        local altPos
        if Z.config.target_player_enabled and not Player.is_in_dead_folder() then
            local c = Z.target_player.get_character()
            local r = c and c:FindFirstChild("HumanoidRootPart")
            altPos = r and r.Position
        end
        if not altPos and Player.is_in_dead_folder() then
            local t = Curve.get_parry_target()
            if not t and Curve.get_target_mode_name() == "None" then t = Curve.get_lobby_screen_target() end
            if t and Z.lobby_is_target(t) then
                local p = Player.get_aim_part(t)
                altPos = p and p.Position
            end
        end
        if not altPos then
            local from = root.Position
            local best = HUGENUM
            for _, c in ipairs(Player.get_alive_chars()) do
                if c.Name ~= localPlayer.Name then
                    local r = c:FindFirstChild("HumanoidRootPart")
                    if r then
                        local d = (r.Position - from).Magnitude
                        if d < best then best = d; altPos = r.Position end
                    end
                end
            end
        end
        local dir = altPos and (root.Position - altPos) or (root.Position - target)
        local unit = dir.Magnitude > 0.001 and dir.Unit or -currentCamera.CFrame.LookVector
        cf = CFrame.new(currentCamera.CFrame.Position, root.Position + unit * 10000 + Vector3.new(0, 1000, 0))
    elseif mode == 5 then
        cf = CFrame.new(root.Position, target + Vector3.new(0, -9e18, 0))
    elseif mode == 6 then
        cf = CFrame.new(root.Position, target + Vector3.new(0, 9e18, 0))
    elseif mode == 7 then
        local d = (root.Position - target).Magnitude
        local y = clamp((d - 60) * 0.2, -25, 5)
        cf = CFrame.new(root.Position, target + Vector3.new(0, y, 0))
    else
        cf = currentCamera.CFrame
    end
    Z.cache.cframe = cf
    return cf
end

-- ============================================================
-- ANIM (grab leg)
-- ============================================================
Z.anim = { grab_track = nil }

Z.anim.stop_tracks_with_attrs = function(animator, attrs)
    if not animator then return end
    for _, t in ipairs(animator:GetPlayingAnimationTracks()) do
        for _, a in ipairs(attrs) do
            if t:GetAttribute(a) then
                pcall(function() t:Stop(t:GetAttribute("StopFadeTime")) end)
                break
            end
        end
    end
end

Z.anim.get_sword_name = function()
    local c = localPlayer.Character
    if not c then return nil end
    return c:GetAttribute("CurrentlyEquippedSword") or localPlayer:GetAttribute("CurrentlyEquippedSword")
end

Z.anim.get_anim_folder = function()
    local name = Z.anim.get_sword_name()
    local collection = ReplicatedStorage.Shared.SwordAPI.Collection
    if name then
        local ok, sword = pcall(function() return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(name) end)
        if ok and sword and sword.AnimationType then
            local f = collection:FindFirstChild(sword.AnimationType)
            if f then return f end
        end
    end
    return collection.Default
end

Z.anim.play_grab = function()
    local c = localPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local animator = h and h:FindFirstChildOfClass("Animator")
    if not animator then return end
    if c:GetAttribute("InOverdriveMech") then return end
    Z.anim.stop_tracks_with_attrs(animator, { "SuccessParry", "Parry", "GrabParry" })
    local folder = Z.anim.get_anim_folder()
    if not folder then return end
    local anim = folder:FindFirstChild("GrabParry") or folder:FindFirstChild("Grab") or folder:FindFirstChild("Parry")
    if not anim then return end
    local track = animator:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action4
    local ok = pcall(function()
        track:Play(track:GetAttribute("PlayFadeTime"), track:GetAttribute("PlayWeight"), track:GetAttribute("PlaySpeed"))
    end)
    if not ok then return end
    local spd = track:GetAttribute("PlaySpeed") or 1
    local dur = track.Length == 0 and 1 or (track.Length - track.TimePosition) * spd
    c:SetAttribute("ParryTime", math.max(c:GetAttribute("ParryTime") or 0, dur))
    Z.anim.grab_track = track
end

Z.anim.stop_grab = function()
    if Z.anim.grab_track then pcall(function() Z.anim.grab_track:Stop(Z.anim.grab_track:GetAttribute("StopFadeTime")) end) end
    Z.anim.grab_track = nil
    local c = localPlayer.Character
    c = c and c:FindFirstChildOfClass("Humanoid")
    local animator = c and c:FindFirstChildOfClass("Animator")
    if animator then Z.anim.stop_tracks_with_attrs(animator, { "GrabParry", "Parry" }) end
end

-- ============================================================
-- PARRY PROCESS (the main loop)
-- ============================================================
local function fire_cooldown_protection()
    return false
end
Z.parry.try_cooldown_protection = fire_cooldown_protection

Parry.process = function()
    if not Z.config.auto_parry then return end
    if Z.triggerbot.enabled then return end
    if Z.phantom and Z.phantom.active then return end
    if Ball.others_all_invisibility() then return end

    local char = localPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if not root then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if root:FindFirstChild("SingularityCape") then return end

    local balls = Ball.get_targeted()
    if #balls == 0 then return end

    local myPos = root.Position
    for _, entry in ipairs(balls) do
        local part = entry.part
        local model = entry.model
        local key = tostring(part)
        if part:FindFirstChild("ComboCounter") then continue end
        if Ball.check_tornado(part) then continue end
        if Z.detections.infinity and Z.state.infinity_active then continue end
        if Z.detections.deathslash and Z.state.deathslash_active then continue end
        if Z.detections.slashesoffury and Z.state.slashesoffury_active then continue end
        if Z.detections.timehole and Z.state.timehole_active then continue end

        local vel = Ball.get_velocity(part, model)
        local speed = vel.Magnitude
        local dist = (part.Position - myPos).Magnitude
        Ball.update_tracking(part, model)
        local curved, bwd = false, false
        if speed >= 1 then
            curved, bwd = Ball.is_curved(part, model, vel, speed, dist, myPos, root.AssemblyLinearVelocity)
        end
        if Z.state.parried then continue end
        if curved then continue end
        if bwd and Z.config.backward_detection == false then continue end
        if bwd then continue end

        local acc = Z.config.accuracy
        if Z.config.randomize_accuracy then
            local lo = clamp(math.floor(math.min(Z.config.random_accuracy_min, Z.config.random_accuracy_max)), 1, 100)
            local hi = clamp(math.floor(math.max(Z.config.random_accuracy_min, Z.config.random_accuracy_max)), 1, 100)
            acc = math.random(lo, hi)
        end
        local parryDist = Parry.get_premium_parry_distance(speed, acc)
        if dist > parryDist then
            parryDist = Parry.get_zenthra_parry_distance(speed, acc)
        end
        parryDist = parryDist * clamp(tonumber(Z.config.parry_distance_multiplier) or 1, 0.1, 10)
        if dist > parryDist then continue end

        Z.parry._last_target_info = {
            ball_id = tostring(part),
            distance = dist,
            parry_distance = parryDist,
            accuracy = acc,
            speed = speed,
            time = tick(),
        }

        Z.parry.execute()
        Z.state.last_execute_tick = tick()
        entry.parried = true
        Z.state.parried = true
        Z.spam.parries += 1
        task.delay(0.5, function()
            if Z.spam.parries > 0 then Z.spam.parries -= 1 end
        end)
        local startT = tick()
        task.spawn(function()
            repeat RunService.PreSimulation:Wait() until tick() - startT >= 1 or not Z.state.parried
            Z.state.parried = false
        end)
    end
end

Z.parry_loop_conn = nil
local function start_parry_loop()
    if Z.parry_loop_conn then return end
    Z.parry_loop_conn = RunService.PreSimulation:Connect(function()
        pcall(Parry.process)
    end)
end
start_parry_loop()

-- ============================================================
-- SPAM
-- ============================================================
local function spam_click_fix()
    pcall(function()
        local f = Enum.KeyCode.F
        local binds = { "F" }
        local ok, mod = pcall(function()
            local sc = ReplicatedStorage:FindFirstChild("Controllers")
            sc = sc and sc:FindFirstChild("SettingsController")
            if not sc then return nil end
            local m = require(sc)
            return m:GetBinds("Block")
        end)
        if ok and mod then
            for _, k in ipairs({ mod.Bind1, mod.Bind2, mod.Bind3 }) do
                if type(k) == "string" and k ~= "" and k ~= "MouseButton1" and k ~= "MouseButton2" then
                    local kc = Enum.KeyCode[k]
                    if typeof(kc) == "EnumItem" and kc ~= Enum.KeyCode.Unknown then
                        f = kc
                        break
                    end
                end
            end
        end
        VirtualInputManager:SendKeyEvent(true, f, false, game)
        VirtualInputManager:SendKeyEvent(false, f, false, game)
    end)
end

Z.spam.manual_step = function()
    local s = Z.spam
    if not s.manual_enabled then return end
    if Ball.others_all_invisibility() then return end
    local c = localPlayer.Character
    if not c then return end
    local hum = s.hum_ref
    if not hum or s.hum_char ~= c or hum.Parent ~= c then
        hum = c:FindFirstChildOfClass("Humanoid")
        s.hum_ref = hum
        s.hum_char = c
    end
    if not hum or hum.Health <= 0 then return end
    local root = s.root_ref
    if not root or s.root_char ~= c or root.Parent ~= c then
        root = c:FindFirstChild("HumanoidRootPart")
        s.root_ref = root
        s.root_char = c
    end
    if not root then return end
    local alive = s.alive_ref
    if not alive or alive.Parent ~= Workspace then
        alive = Workspace:FindFirstChild("Alive")
        s.alive_ref = alive
    end
    if not alive then return end
    local me = s.alive_me
    if not me or me.Parent ~= alive then
        me = alive:FindFirstChild(localPlayer.Name)
        s.alive_me = me
    end
    if not me then return end
    local mode = s.manual_mode
    if mode == "Remote" and s.animation_fix_manual then
        local t = os.clock()
        if t - s.last_animation_fix_manual_t >= s.animation_fix_interval then
            s.last_animation_fix_manual_t = t
            if Z.config.is_mobile then task.spawn(fire_hardware_key) else spam_click_fix() end
        end
    end
    local now = os.clock()
    if now - s.last_manual_fire_t >= s.fire_interval then
        s.last_manual_fire_t = now
        Z.parry.execute_fast(mode)
    end
end

Z.spam.manual_start = function()
    Z.spam.kill_manual_loop()
    Z.spam.manual_enabled = true
    Z.spam.last_animation_fix_manual_t = 0
    Z.spam.last_manual_fire_t = 0
    Z.warm_direct()
    if Z.spam.remote_list_dirty then Z.parry.rebuild_remote_list() end
    Z.spam.thread_manual = task.spawn(function()
        local s = Z.spam
        while s.manual_enabled do
            s.manual_step()
            RunService.PostSimulation:Wait()
            if not s.manual_enabled then break end
            s.manual_step()
            RunService.PreSimulation:Wait()
        end
    end)
end

Z.spam.kill_manual_loop = function()
    if Z.spam.thread_manual then
        pcall(task.cancel, Z.spam.thread_manual)
        Z.spam.thread_manual = nil
    end
    if Z.spam.connection_manual then Z.spam.connection_manual:Disconnect(); Z.spam.connection_manual = nil end
end

Z.spam.manual_stop = function()
    Z.spam.manual_enabled = false
    Z.spam.kill_manual_loop()
    Z.spam.last_parried_ball = nil
    Z.state.parried = false
    Z.spam.hum_ref = nil; Z.spam.hum_char = nil
    Z.spam.root_ref = nil; Z.spam.root_char = nil
    Z.spam.alive_me = nil
end

Z.spam.auto_step = function()
    local s = Z.spam
    if not s.auto_enabled then return end
    if Ball.others_all_invisibility() then return end
    local c = localPlayer.Character
    if not c then return end
    local root = s.root_ref
    if not root or s.root_char ~= c or root.Parent ~= c then
        root = c:FindFirstChild("HumanoidRootPart")
        s.root_ref = root
        s.root_char = c
    end
    if not root then return end
    local hum = s.hum_ref
    if not hum or s.hum_char ~= c or hum.Parent ~= c then
        hum = c:FindFirstChildOfClass("Humanoid")
        s.hum_ref = hum
        s.hum_char = c
    end
    if not hum or hum.Health <= 0 then return end
    if c:GetAttribute("Pulsed") then return end
    local now = os.clock()
    for i = #s.auto_decay_at, 1, -1 do
        if now >= s.auto_decay_at[i] then
            if s.parries > 0 then s.parries -= 1 end
            table.remove(s.auto_decay_at, i)
        end
    end
    local balls = s.balls_ref
    if not balls or balls.Parent ~= Workspace then
        balls = Workspace:FindFirstChild("Balls")
        s.balls_ref = balls
        s.balls_dirty = true
        if s.balls_conn_add then s.balls_conn_add:Disconnect(); s.balls_conn_add = nil end
        if s.balls_conn_rem then s.balls_conn_rem:Disconnect(); s.balls_conn_rem = nil end
        if balls then
            s.balls_conn_add = balls.ChildAdded:Connect(function() s.balls_dirty = true end)
            s.balls_conn_rem = balls.ChildRemoved:Connect(function() s.balls_dirty = true end)
        end
    end
    if not balls then return end
    local children = s.balls_children
    if s.balls_dirty or not children then
        children = balls:GetChildren()
        s.balls_children = children
        s.balls_dirty = false
    end
    local mode = s.auto_mode
    local sens = s.sensitivity_multiplier
    if now - s.ping_cache_t >= 0.03 or s.ping_cache_t == 0 then
        s.ping_cache = Z.cache.get_ping()
        s.ping_cache_t = now
    end
    local ping = s.ping_cache
    local B = clamp(ping / 10, 1, 16)
    local myPos = root.Position
    local myName = localPlayer.Name
    local threshold = s.threshold
    local parries = s.parries
    local zoomiesCache = s.zoomies_cache
    for _, child in ipairs(children) do
        if not child:IsA("BasePart") then continue end
        local z = zoomiesCache[child]
        if not z or z.Parent ~= child then
            z = child:FindFirstChild("zoomies")
            zoomiesCache[child] = z
        end
        if not z then continue end
        local t = child:GetAttribute("target")
        if not t then continue end
        local dist = (myPos - child.Position).Magnitude
        if t ~= myName and (child ~= s.last_parried_ball or dist > 30) then continue end
        local vmag = z.VectorVelocity.Magnitude
        local C = 2.4 + math.min(math.max(vmag - 9.5, 0), 650) * 0.002
        local near = (B + math.max(vmag / C, 9.5)) * sens
        local far = (B + math.min(vmag / 6, 255)) * sens
        local hasParries = parries > threshold
        local nearT = hasParries and far * 0.7 or far
        local farT = hasParries and 30 * sens * 0.7 or 30 * sens
        if dist > nearT then continue end
        if t == myName and dist > farT then continue end
        if dist <= near and parries > threshold then
            local fireTime = os.clock()
            if fireTime - s.last_auto_fire_t < s.fire_interval then break end
            s.last_auto_fire_t = fireTime
            if mode == "Remote" and s.animation_fix_auto then
                if now - s.last_animation_fix_auto_t >= s.animation_fix_interval then
                    s.last_animation_fix_auto_t = now
                    if Z.config.is_mobile then task.spawn(fire_hardware_key) else spam_click_fix() end
                end
            end
            s.parries = s.parries + 1
            s.last_parried_ball = child
            table.insert(s.auto_decay_at, now + 0.2)
            Z.parry.execute_fast(mode)
            break
        end
    end
end

Z.spam.auto_start = function()
    Z.spam.kill_auto_loop()
    Z.spam.auto_enabled = true
    Z.spam.last_animation_fix_auto_t = 0
    Z.spam.last_auto_fire_t = 0
    Z.warm_direct()
    Z.spam.parries = 0
    table.clear(Z.spam.auto_decay_at)
    Z.spam.thread_auto = task.spawn(function()
        local s = Z.spam
        while s.auto_enabled do
            s.auto_step()
            RunService.PostSimulation:Wait()
            if not s.auto_enabled then break end
            s.auto_step()
            RunService.PreSimulation:Wait()
        end
    end)
end

Z.spam.kill_auto_loop = function()
    if Z.spam.thread_auto then
        pcall(task.cancel, Z.spam.thread_auto)
        Z.spam.thread_auto = nil
    end
    if Z.spam.connection_auto then Z.spam.connection_auto:Disconnect(); Z.spam.connection_auto = nil end
end

Z.spam.auto_stop = function()
    Z.spam.auto_enabled = false
    Z.spam.parries = 0
    Z.spam.last_parried_ball = nil
    table.clear(Z.spam.auto_decay_at)
    Z.spam.kill_auto_loop()
    if Z.spam.balls_conn_add then Z.spam.balls_conn_add:Disconnect(); Z.spam.balls_conn_add = nil end
    if Z.spam.balls_conn_rem then Z.spam.balls_conn_rem:Disconnect(); Z.spam.balls_conn_rem = nil end
    Z.spam.balls_ref = nil
    Z.spam.balls_children = nil
    Z.spam.balls_dirty = true
    Z.spam.hum_ref = nil; Z.spam.hum_char = nil
    Z.spam.root_ref = nil; Z.spam.root_char = nil
end

-- ============================================================
-- TRIGGERBOT
-- ============================================================
Z.triggerbot.fire = function(part)
    if not Z.triggerbot.enabled then return end
    if not part or not part.Parent then return end
    if part:GetAttribute("target") ~= localPlayer.Name then return end
    if Player.has_singularity_cape() then return end
    if Ball.others_all_invisibility() then return end
    Z.fire_remote()
end

Z.triggerbot.try_ball = function(part)
    local t = Z.triggerbot
    if not t.enabled or not part then return end
    if part:GetAttribute("target") ~= localPlayer.Name then t.pending[part] = nil; return end
    if t.pending[part] then return end
    t.pending[part] = true
    local d = Z.config.triggerbot_delay or 0
    if d <= 0 then
        t.fire(part)
    else
        task.delay(d / 1000, function() t.fire(part) end)
    end
end

Z.triggerbot.hook_ball = function(part)
    local t = Z.triggerbot
    if not part:IsA("BasePart") then return end
    if t.ball_conns[part] then return end
    t.ball_conns[part] = part:GetAttributeChangedSignal("target"):Connect(function()
        t.try_ball(part)
    end)
    t.try_ball(part)
end

Z.triggerbot.unhook_all = function()
    local t = Z.triggerbot
    for p, c in pairs(t.ball_conns) do pcall(function() c:Disconnect() end) end
    table.clear(t.ball_conns)
    table.clear(t.pending)
    if t.folder_add_conn then t.folder_add_conn:Disconnect(); t.folder_add_conn = nil end
    if t.folder_rem_conn then t.folder_rem_conn:Disconnect(); t.folder_rem_conn = nil end
    t.hooked_folder = nil
end

Z.triggerbot.hook_folder = function()
    local t = Z.triggerbot
    if not t.enabled then return end
    local f = Z.cache.get_balls_folder()
    if not f or f == t.hooked_folder then return end
    t.unhook_all()
    t.hooked_folder = f
    for _, c in ipairs(f:GetChildren()) do t.hook_ball(c) end
    t.folder_add_conn = f.ChildAdded:Connect(function(c) t.hook_ball(c) end)
    t.folder_rem_conn = f.ChildRemoved:Connect(function(c)
        local conn = t.ball_conns[c]
        if conn then conn:Disconnect(); t.ball_conns[c] = nil end
        t.pending[c] = nil
    end)
end

Z.triggerbot.process = function()
    local t = Z.triggerbot
    if not t.enabled then return end
    local f = Z.cache.get_balls_folder()
    if f and f ~= t.hooked_folder then t.hook_folder() end
end

Z.triggerbot.set = function(enabled)
    Z.triggerbot.enabled = enabled
    if enabled then
        Z.warm_direct()
        Z.triggerbot.hook_folder()
        if not Z.triggerbot.connection then
            Z.triggerbot.connection = RunService.Heartbeat:Connect(Z.triggerbot.process)
        end
    else
        if Z.triggerbot.connection then Z.triggerbot.connection:Disconnect(); Z.triggerbot.connection = nil end
        Z.triggerbot.is_parrying = false
        Z.triggerbot.unhook_all()
    end
end

-- ============================================================
-- TARGET_PLAYER / FOLLOW_TARGET / AIM_TARGET
-- ============================================================
Z.visual = { highlight_container = nil }

Z.visual.get_highlight_container = function()
    if Z.visual.highlight_container and Z.visual.highlight_container.Parent then return Z.visual.highlight_container end
    local f = Instance.new("Folder")
    f.Name = "ZenthraHighlights"
    f.Parent = get_safe_parent()
    Z.visual.highlight_container = f
    return f
end

Z.visual.clear_highlight = function(state)
    if state.highlights then
        for _, h in ipairs(state.highlights) do pcall(function() h:Destroy() end) end
        state.highlights = nil
    end
    state.highlight_char = nil
end

Z.visual.apply_highlight_color = function(state, color)
    if not state.highlights then return end
    for _, h in ipairs(state.highlights) do
        if h.Parent then h.FillColor = color; h.OutlineColor = color end
    end
end

Z.visual.rebuild_part_highlights = function(state, char, parent)
    if state.highlights then
        for _, h in ipairs(state.highlights) do pcall(function() h:Destroy() end) end
    end
    state.highlights = {}
    state.highlight_char = char
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            local h = Instance.new("Highlight")
            h.Name = "ZenthraHighlight"
            h.Adornee = d
            h.Parent = parent
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.FillTransparency = 0.5
            h.OutlineTransparency = 0
            table.insert(state.highlights, h)
        end
    end
end

Z.visual.set_highlight = function(state, char, color, enabled)
    if not enabled or not char or not char.Parent then
        Z.visual.clear_highlight(state)
        return
    end
    local parent = Z.visual.get_highlight_container()
    if state.highlight_char ~= char or not state.highlights or #state.highlights == 0 then
        Z.visual.rebuild_part_highlights(state, char, parent)
    end
    local allValid = true
    for _, h in ipairs(state.highlights) do
        local a = h.Adornee
        if not (h.Parent and a and a.Parent and a:IsDescendantOf(char)) then
            allValid = false; break
        end
    end
    if not allValid then
        Z.visual.rebuild_part_highlights(state, char, parent)
    end
    for _, h in ipairs(state.highlights) do
        h.Enabled = true
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        if h.Parent ~= parent then h.Parent = parent end
    end
end

-- Target Player
Z.target_player.get_character = function()
    if not Z.config.target_player_enabled then return nil end
    if Z.config.target_player_follow and not Player.is_alive() then return nil end
    local function find(name)
        if not name then return nil end
        local alive = Workspace:FindFirstChild("Alive")
        if not alive then return nil end
        local c = alive:FindFirstChild(name)
        if c and c:FindFirstChild("HumanoidRootPart") and Player.is_char_in_alive(c) then return c end
        return nil
    end
    local c = find(Z.config.target_player_name)
    if c then return c end
    if Z.config.target_player_follow then
        Z.target_player.lock()
        return find(Z.config.target_player_name)
    end
    return nil
end

Z.target_player.lock = function()
    local c = Player.get_closest_to_aim()
    if not c or not Player.is_char_in_alive(c) then
        Z.config.target_player_name = nil
        return
    end
    Z.config.target_player_name = c.Name
    if Z.config.target_player_notify then
        local p = Players:FindFirstChild(c.Name)
        local display = p and p.DisplayName or c.Name
        notify("Target Player", "Targeting " .. display, true, 3)
    end
end

Z.target_player.stop_walking = function()
    local c = localPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h then h:Move(Vector3.zero, false); h:MoveTo(c.PrimaryPart and c.PrimaryPart.Position or c:GetPivot().Position) end
end

Z.target_player.update = function()
    local t, cfg = Z.target_player, Z.config
    local draw = t.text_draw
    if not cfg.target_player_enabled then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(t)
        return
    end
    if not throttle("target_player", 0) then return end
    local c = t.get_character()
    if not c then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(t)
        if cfg.target_player_name and not cfg.target_player_follow then cfg.target_player_name = nil end
        return
    end
    local root = c:FindFirstChild("HumanoidRootPart")
    if not root then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(t)
        return
    end
    Z.visual.set_highlight(t, c, cfg.target_player_highlight_color, cfg.target_player_highlight)
    if draw and cfg.target_player_text then
        local head = c:FindFirstChild("Head") or root
        local pos, onScreen = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 3, 0))
        if onScreen then
            draw.Size = cfg.target_player_text_size
            draw.Color = cfg.target_player_text_color
            draw.Position = Vector2.new(pos.X, pos.Y)
            draw.Text = "TARGET"
            draw.Visible = true
        else
            draw.Visible = false
        end
    elseif draw then
        draw.Visible = false
    end
end

Z.target_player.start = function()
    if Z.target_player.active then return end
    Z.target_player.active = true
    if not Z.target_player.text_draw then
        local t = Drawing.new("Text")
        t.Visible = false
        t.Center = true
        t.Outline = true
        t.OutlineColor = Color3.new(0,0,0)
        t.Text = "TARGET"
        t.Font = Drawing.Fonts.UI
        Z.target_player.text_draw = t
    end
    Z.target_player.connection = RunService.RenderStepped:Connect(function()
        Z.target_player.update()
    end)
end

Z.target_player.stop = function()
    if not Z.target_player.active then return end
    Z.target_player.active = false
    if Z.target_player.connection then Z.target_player.connection:Disconnect(); Z.target_player.connection = nil end
    if Z.target_player.text_draw then Z.target_player.text_draw.Visible = false end
    Z.visual.clear_highlight(Z.target_player)
    Z.target_player.stop_walking()
end

-- Follow Target
Z.follow_target.get_mode_name = function()
    local m = Z.config.follow_target_mode or 1
    return ({"Walk", "TP"})[m] or "Walk"
end

Z.follow_target.lock = function()
    local c = Player.get_closest_to_aim()
    if not c or not Player.is_char_in_alive(c) then
        Z.config.follow_target_name = nil
        return
    end
    Z.config.follow_target_name = c.Name
end

Z.follow_target.get_character = function()
    if not Z.follow_target.active or not Player.is_alive() then return nil end
    local function find(name)
        if not name then return nil end
        local a = Workspace:FindFirstChild("Alive")
        if not a then return nil end
        local c = a:FindFirstChild(name)
        if c and c:FindFirstChild("HumanoidRootPart") and Player.is_char_in_alive(c) then return c end
        return nil
    end
    local c = find(Z.config.follow_target_name)
    if c then return c end
    Z.follow_target.lock()
    return find(Z.config.follow_target_name)
end

Z.follow_target.stop_walking = function()
    local c = localPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h then h:Move(Vector3.zero, false) end
end

Z.follow_target.follow_update = function()
    if not Z.follow_target.active then return end
    if Z.follow_target.get_mode_name() ~= "Walk" then return end
    if not Player.is_alive() then Z.follow_target.stop_walking(); return end
    local c = localPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local root = c:FindFirstChild("HumanoidRootPart")
    if not h or not root or h.Health <= 0 then return end
    local t = Z.follow_target.get_character()
    if not t then return end
    local tr = t:FindFirstChild("HumanoidRootPart")
    if not tr then return end
    local d = tr.Position - root.Position
    d = Vector3.new(d.X, 0, d.Z)
    if d.Magnitude < 2.5 then h:Move(Vector3.zero, false); return end
    h:Move(d.Unit, false)
end

Z.follow_target.update = function()
    local f, cfg = Z.follow_target, Z.config
    local draw = f.text_draw
    if not f.active then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(f)
        return
    end
    if not throttle("follow_target", 0) then return end
    local c = f.get_character()
    if not c then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(f)
        return
    end
    local root = c:FindFirstChild("HumanoidRootPart")
    if not root then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(f)
        return
    end
    Z.visual.set_highlight(f, c, cfg.follow_target_highlight_color, cfg.follow_target_highlight)
    if draw and cfg.follow_target_text then
        local head = c:FindFirstChild("Head") or root
        local pos, onScreen = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 3, 0))
        if onScreen then
            draw.Size = cfg.follow_target_text_size
            draw.Color = cfg.follow_target_text_color
            draw.Position = Vector2.new(pos.X, pos.Y)
            draw.Text = "TARGET"
            draw.Visible = true
        else
            draw.Visible = false
        end
    elseif draw then
        draw.Visible = false
    end
end

Z.follow_target.set_mode = function(mode)
    for i, m in ipairs({"Walk", "TP"}) do
        if m == mode then Z.config.follow_target_mode = i; break end
    end
    if not Z.follow_target.active then return end
    if mode == "Walk" then
        Z.orbit_ball.stop()
    end
end

Z.follow_target.start = function()
    if Z.follow_target.active then return end
    Z.follow_target.active = true
    Z.follow_target.lock()
    if not Z.follow_target.text_draw then
        local t = Drawing.new("Text")
        t.Visible = false
        t.Center = true
        t.Outline = true
        t.OutlineColor = Color3.new(0,0,0)
        t.Text = "TARGET"
        t.Font = Drawing.Fonts.UI
        Z.follow_target.text_draw = t
    end
    Z.follow_target.connection = RunService.RenderStepped:Connect(function()
        Z.follow_target.update()
        Z.follow_target.follow_update()
    end)
end

Z.follow_target.stop = function()
    if not Z.follow_target.active then return end
    Z.follow_target.active = false
    if Z.follow_target.connection then Z.follow_target.connection:Disconnect(); Z.follow_target.connection = nil end
    if Z.follow_target.move_connection then Z.follow_target.move_connection:Disconnect(); Z.follow_target.move_connection = nil end
    if Z.follow_target.post_connection then Z.follow_target.post_connection:Disconnect(); Z.follow_target.post_connection = nil end
    if Z.follow_target.text_draw then Z.follow_target.text_draw.Visible = false end
    Z.visual.clear_highlight(Z.follow_target)
    Z.follow_target.stop_walking()
    Z.config.follow_target_name = nil
end

-- Aim Target
Z.aim_target.update = function()
    local a, cfg = Z.aim_target, Z.config
    local draw = a.text_draw
    if not a.active then return end
    if not cfg.show_aim_target then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(a)
        return
    end
    if not throttle("aim_target", 0) then return end
    local target
    if Curve.uses_lobby_targets_only() then
        target = Curve.get_target_mode_name() == "None" and Curve.get_lobby_screen_target() or Curve.get_parry_target()
        if not target or not Z.lobby_is_target(target) then
            if draw then draw.Visible = false end
            Z.visual.clear_highlight(a)
            return
        end
    else
        target = Curve.get_parry_target()
        if not target or not Curve.is_valid_target_entity(target) then
            if draw then draw.Visible = false end
            Z.visual.clear_highlight(a)
            return
        end
    end
    local isLobbyTarget = target and Z.lobby_is_target(target)
    if not target or (not isLobbyTarget and not Player.is_char_in_alive(target)) then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(a)
        return
    end
    local p = Player.get_aim_part(target)
    if not p then
        if draw then draw.Visible = false end
        Z.visual.clear_highlight(a)
        return
    end
    local hlRoot = Player.get_aim_highlight_root(target)
    Z.visual.set_highlight(a, hlRoot, cfg.aim_target_highlight_color, cfg.aim_target_highlight)
    if draw and cfg.aim_target_text then
        local pos, onScreen = currentCamera:WorldToViewportPoint(p.Position + Vector3.new(0, 3, 0))
        if onScreen then
            draw.Size = 16
            draw.Color = cfg.aim_target_text_color
            draw.Position = Vector2.new(pos.X, pos.Y)
            draw.Text = isLobbyTarget and target.Name or Player.get_char_label(target)
            draw.Visible = true
        else
            draw.Visible = false
        end
    elseif draw then
        draw.Visible = false
    end
end

Z.aim_target.start = function()
    if Z.aim_target.active then return end
    Z.aim_target.active = true
    if not Z.aim_target.text_draw then
        local t = Drawing.new("Text")
        t.Visible = false
        t.Center = true
        t.Outline = true
        t.OutlineColor = Color3.new(0,0,0)
        t.Font = Drawing.Fonts.UI
        Z.aim_target.text_draw = t
    end
    Z.aim_target.connection = RunService.RenderStepped:Connect(Z.aim_target.update)
end

Z.aim_target.stop = function()
    if not Z.aim_target.active then return end
    Z.aim_target.active = false
    if Z.aim_target.connection then Z.aim_target.connection:Disconnect(); Z.aim_target.connection = nil end
    if Z.aim_target.text_draw then Z.aim_target.text_draw.Visible = false end
    Z.visual.clear_highlight(Z.aim_target)
end

Z.player_get_root = Player.get_root
Z.player_is_in_alive = Player.is_in_alive_folder

-- ============================================================
-- ORBIT BALL
-- ============================================================
Z.orbit_ball.set_rep_root = function(part, target)
    if type(sethiddenproperty) ~= "function" then return false end
    return pcall(sethiddenproperty, part, "PhysicsRepRootPart", target)
end

Z.orbit_ball.get_antifling = function()
    if Z.orbit_ball._antifling_mod then return Z.orbit_ball._antifling_mod end
    local ok, mod = pcall(function()
        local c = ReplicatedStorage:FindFirstChild("Controllers")
        local a = c and c:FindFirstChild("AntiFlingController")
        return a and require(a)
    end)
    if ok and type(mod) == "table" and type(mod.Reteleport) == "function" then
        Z.orbit_ball._antifling_mod = mod
        return mod
    end
    return nil
end

Z.orbit_ball.disable_antifling = function()
    if Z.orbit_ball._antifling_orig then return end
    local m = Z.orbit_ball.get_antifling()
    if not m then return end
    Z.orbit_ball._antifling_orig = m.Reteleport
    m.Reteleport = function() end
end

Z.orbit_ball.restore_antifling = function()
    if not Z.orbit_ball._antifling_orig then return end
    local m = Z.orbit_ball._antifling_mod
    if m then m.Reteleport = Z.orbit_ball._antifling_orig end
    Z.orbit_ball._antifling_orig = nil
end

Z.orbit_ball.step = function(dt)
    if not Z.orbit_ball.active then return end
    local alive = Workspace:FindFirstChild("Alive")
    if not alive then return end
    local c = localPlayer.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if not alive:FindFirstChild(localPlayer.Name) then return end
    local ball = Ball.get_first()
    if not ball then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum and not Z.orbit_ball._saved_platform_stand then
        Z.orbit_ball._saved_platform_stand = hum.PlatformStand
        Z.orbit_ball._saved_auto_rotate = hum.AutoRotate
        hum.PlatformStand = true
        hum.AutoRotate = false
    end
    if dt and dt > 0 then
        Z.orbit_ball.angle = Z.orbit_ball.angle + Z.orbit_ball.speed * dt
    end
    local p = ball.Position
    local d = Z.orbit_ball.distance
    local cf = CFrame.lookAt(
        Vector3.new(p.X + math.cos(Z.orbit_ball.angle) * d, p.Y + Z.orbit_ball.height, p.Z + math.sin(Z.orbit_ball.angle) * d),
        p
    )
    root.Anchored = false
    Z.orbit_ball.set_rep_root(root, ball)
    c:PivotTo(cf)
    root.AssemblyLinearVelocity = ball.AssemblyLinearVelocity
    root.AssemblyAngularVelocity = Vector3.zero
    currentCamera.CameraSubject = ball
end

Z.orbit_ball.start = function()
    if Z.orbit_ball.active then return end
    Z.orbit_ball.active = true
    Z.orbit_ball.angle = 0
    Z.orbit_ball.disable_antifling()
    Z.orbit_ball.connection = RunService.PreSimulation:Connect(function(dt) Z.orbit_ball.step(dt) end)
    Z.orbit_ball.post_connection = RunService.PostSimulation:Connect(function() Z.orbit_ball.step(0) end)
end

Z.orbit_ball.stop = function()
    if not Z.orbit_ball.active then return end
    Z.orbit_ball.active = false
    if Z.orbit_ball.connection then Z.orbit_ball.connection:Disconnect(); Z.orbit_ball.connection = nil end
    if Z.orbit_ball.post_connection then Z.orbit_ball.post_connection:Disconnect(); Z.orbit_ball.post_connection = nil end
    Z.orbit_ball.restore_antifling()
    local c = localPlayer.Character
    if c then
        local root = c:FindFirstChild("HumanoidRootPart")
        if root then
            root.Anchored = false
            Z.orbit_ball.set_rep_root(root, nil)
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and Z.orbit_ball._saved_platform_stand ~= nil then
            hum.PlatformStand = Z.orbit_ball._saved_platform_stand
            hum.AutoRotate = Z.orbit_ball._saved_auto_rotate ~= false
        end
        if hum then currentCamera.CameraSubject = hum end
    end
    Z.orbit_ball._saved_platform_stand = nil
    Z.orbit_ball._saved_auto_rotate = nil
end

-- ============================================================
-- IMMORTAL
-- ============================================================
Z.immortal.update_cache = function()
    local c = localPlayer.Character
    if c ~= Z.immortal.state.cache.character then
        Z.immortal.state.cache.character = c
        if c then
            Z.immortal.state.cache.hrp = c:FindFirstChild("HumanoidRootPart")
            Z.immortal.state.cache.head = c:FindFirstChild("Head")
            Z.immortal.state.cache.alive = Workspace:FindFirstChild("Alive")
        else
            Z.immortal.state.cache.hrp = nil
            Z.immortal.state.cache.head = nil
        end
    end
end

Z.immortal.is_in_alive = function()
    return Z.immortal.state.cache.alive
        and Z.immortal.state.cache.character
        and Z.immortal.state.cache.character.Parent == Z.immortal.state.cache.alive
end

Z.immortal.get_random_position = function()
    local hrp = Z.immortal.state.cache.hrp
    if not hrp then return CFrame.new() end
    local origin = hrp.Position
    local radius = Z.immortal.config.radius
    local ang = math.rad(math.random(0, Z.immortal.config.angles))
    local yOff = math.floor(tick() * 11.9) % 2 == 0 and 0 or Z.immortal.config.height
    local x = origin.X + math.cos(ang) * radius
    local y = origin.Y - hrp.Size.Y * 0.5 + 5 + yOff
    local z = origin.Z + math.sin(ang) * radius
    return CFrame.new(x, y, z)
end

Z.immortal.perform_desync = function()
    local im = Z.immortal
    im.update_cache()
    local cache = im.state.cache
    if not im.state.enabled or not cache.hrp or not im.is_in_alive() then return end
    local hrp = cache.hrp
    cache.original_cframe = hrp.CFrame
    cache.original_velocity = hrp.AssemblyLinearVelocity
    local newCF = im.get_random_position()
    hrp.CFrame = newCF
    hrp.AssemblyLinearVelocity = Vector3.new(1, 1, 1)
    RunService.RenderStepped:Wait()
    hrp.CFrame = cache.original_cframe
    hrp.AssemblyLinearVelocity = cache.original_velocity
end

Z.immortal.reset_cache = function()
    local c = Z.immortal.state.cache
    c.character = nil; c.hrp = nil; c.head = nil; c.alive = nil
    c.original_cframe = nil; c.original_velocity = nil
end

Z.immortal.start = function()
    if Z.immortal.state.enabled then return end
    Z.immortal.state.enabled = true
    if not Z.immortal.state.connections.heartbeat then
        Z.immortal.state.connections.heartbeat = RunService.Heartbeat:Connect(Z.immortal.perform_desync)
    end
end

Z.immortal.stop = function()
    if not Z.immortal.state.enabled then return end
    Z.immortal.state.enabled = false
    if Z.immortal.state.connections.heartbeat then
        Z.immortal.state.connections.heartbeat:Disconnect()
        Z.immortal.state.connections.heartbeat = nil
    end
    Z.immortal.reset_cache()
end

track(localPlayer.CharacterAdded:Connect(function()
    if Z.immortal.state.enabled then
        task.wait(1)
        Z.immortal.reset_cache()
        if Z.immortal.state.connections.heartbeat then
            Z.immortal.state.connections.heartbeat:Disconnect()
        end
        Z.immortal.state.connections.heartbeat = RunService.Heartbeat:Connect(Z.immortal.perform_desync)
    end
end))

-- ============================================================
-- PLAYER MODS
-- ============================================================
Z.player_mods.set_fov = function(enabled, fov)
    Z.player_mods.fov_enabled = enabled
    if fov then Z.player_mods.fov = fov end
    currentCamera.FieldOfView = enabled and Z.player_mods.fov or 70
end

Z.player_mods.set_speed = function(enabled, speed)
    Z.player_mods.speed_enabled = enabled
    if speed then Z.player_mods.speed = speed end
    if Z.player_mods.speed_conn then Z.player_mods.speed_conn:Disconnect(); Z.player_mods.speed_conn = nil end
    if enabled then
        local acc = 0
        Z.player_mods.speed_conn = RunService.Heartbeat:Connect(function(dt)
            acc += dt
            if acc < 0.1 then return end
            acc = 0
            local c = localPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = Z.player_mods.speed end
        end)
    else
        local c = localPlayer.Character
        c = c and c:FindFirstChildOfClass("Humanoid")
        if c then c.WalkSpeed = 16 end
    end
end

Z.player_mods.set_gravity = function(enabled, gravity)
    Z.player_mods.gravity_enabled = enabled
    if gravity then Z.player_mods.gravity = gravity end
    Workspace.Gravity = enabled and Z.player_mods.gravity or 196.2
end

Z.player_mods.set_jump_power = function(enabled, power)
    Z.player_mods.jump_power_enabled = enabled
    if power then Z.player_mods.jump_power = power end
    if Z.player_mods.jump_conn then Z.player_mods.jump_conn:Disconnect(); Z.player_mods.jump_conn = nil end
    if enabled then
        local acc = 0
        Z.player_mods.jump_conn = RunService.Heartbeat:Connect(function(dt)
            acc += dt
            if acc < 0.1 then return end
            acc = 0
            local c = localPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.UseJumpPower then h.JumpPower = Z.player_mods.jump_power else h.JumpHeight = Z.player_mods.jump_power / 5 end
        end)
    else
        local c = localPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then
            if h.UseJumpPower then h.JumpPower = 50 else h.JumpHeight = 7.2 end
        end
    end
end

Z.player_mods.set_infinite_jump = function(enabled)
    Z.player_mods.infinite_jump_enabled = enabled
    if Z.player_mods.infinite_jump_conn then
        Z.player_mods.infinite_jump_conn:Disconnect()
        Z.player_mods.infinite_jump_conn = nil
    end
    if enabled then
        Z.player_mods.infinite_jump_conn = UserInputService.JumpRequest:Connect(function()
            local c = localPlayer.Character
            c = c and c:FindFirstChildOfClass("Humanoid")
            if c then c:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end

-- ============================================================
-- BALL TRAIL
-- ============================================================
Z.ball_trail.get_ball = function()
    local f = Z.cache.get_balls_folder()
    if not f then return nil end
    for _, c in ipairs(f:GetChildren()) do
        if c:IsA("BasePart") then return c end
    end
    return nil
end

Z.ball_trail.build_color = function()
    local c = Z.ball_trail.color
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, c),
        ColorSequenceKeypoint.new(0.5, Color3.new(math.min(c.R*1.3, 1), math.min(c.G*1.3, 1), math.min(c.B*1.3, 1))),
        ColorSequenceKeypoint.new(1, c),
    })
end

Z.ball_trail.attach = function(ball)
    Z.ball_trail.detach()
    local count = Z.ball_trail.num_trails
    for i = 1, count do
        local ang = i / count * TAU
        local radius = math.random(150, 250) / 100
        local yOff = math.random(-150, 150) / 100
        local a0 = Instance.new("Attachment")
        a0.Position = Vector3.new(math.cos(ang) * radius, yOff, math.sin(ang) * radius)
        a0.Parent = ball
        local a1 = Instance.new("Attachment")
        a1.Position = Vector3.new(math.cos(ang + math.pi * 0.7) * radius * 1.3, -yOff, math.sin(ang + math.pi * 0.7) * radius * 1.3)
        a1.Parent = ball
        local trail = Instance.new("Trail")
        trail.Attachment0 = a0
        trail.Attachment1 = a1
        trail.Lifetime = 0.6
        trail.MinLength = 0
        trail.FaceCamera = true
        trail.LightEmission = 1
        trail.LightInfluence = 0
        trail.Texture = "rbxassetid://5029929719"
        trail.TextureMode = Enum.TextureMode.Stretch
        trail.Color = Z.ball_trail.build_color()
        trail.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.3, 0),
            NumberSequenceKeypoint.new(0.7, 0.3),
            NumberSequenceKeypoint.new(1, 1),
        })
        trail.WidthScale = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.3, 0.25),
            NumberSequenceKeypoint.new(0.7, 0.15),
            NumberSequenceKeypoint.new(1, 0.02),
        })
        trail.Parent = ball
        table.insert(Z.ball_trail.attachments, {
            a0 = a0, a1 = a1, trail = trail,
            baseAngle = ang, angle = 0,
            speed = math.random(15, 30) / 10,
            spiralSpeed = math.random(25, 45) / 10,
            radiusMultiplier = math.random(80, 130) / 100,
            pulseOffset = math.random() * TAU,
            baseRadius = radius, baseHeight = yOff,
            chaosSpeed = math.random(10, 20) / 10,
        })
    end
end

Z.ball_trail.detach = function()
    for _, a in ipairs(Z.ball_trail.attachments) do
        if a.a0 and a.a0.Parent then a.a0:Destroy() end
        if a.a1 and a.a1.Parent then a.a1:Destroy() end
        if a.trail and a.trail.Parent then a.trail:Destroy() end
    end
    Z.ball_trail.attachments = {}
end

Z.ball_trail.animate = function(dt)
    if not Z.ball_trail.active then return end
    local t = tick()
    for _, a in ipairs(Z.ball_trail.attachments) do
        if not a.a0.Parent then continue end
        a.angle = a.angle + a.speed * dt
        local spiral = a.angle * a.spiralSpeed
        local pulse = math.sin(t * 4 + a.pulseOffset) * 0.4 + 1
        local sway = math.sin(a.angle * 3) * 0.7
        local chaos = math.sin(t * a.chaosSpeed + a.pulseOffset) * 0.5
        local r1 = a.baseRadius * a.radiusMultiplier * pulse
        local r2 = a.baseRadius * 1.3 * a.radiusMultiplier * pulse
        a.a0.Position = Vector3.new(
            math.cos(a.baseAngle + a.angle) * r1 + math.cos(spiral) * 0.6,
            a.baseHeight + math.sin((a.baseAngle + a.angle) * 3) * 0.8 + sway + chaos + math.sin(spiral * 2) * 0.6,
            math.sin(a.baseAngle + a.angle) * r1 + math.sin(spiral) * 0.6
        )
        a.a1.Position = Vector3.new(
            math.cos(a.baseAngle + a.angle + math.pi * 0.7) * r2 + math.sin(spiral * 1.3) * 0.5,
            -a.baseHeight + math.cos((a.baseAngle + a.angle) * 2.5) * 0.8 - sway - chaos + math.cos(spiral * 1.7) * 0.5,
            math.sin(a.baseAngle + a.angle + math.pi * 0.7) * r2 + math.cos(spiral * 1.1) * 0.5
        )
        a.trail.LightEmission = math.sin(t * 5 + a.pulseOffset) * 0.4 + 0.6
    end
end

Z.ball_trail.start = function()
    if Z.ball_trail.active then return end
    Z.ball_trail.active = true
    local ball = Z.ball_trail.get_ball()
    if ball then Z.ball_trail.attach(ball) end
    Z.ball_trail.connection = RunService.Heartbeat:Connect(function(dt)
        local bt = Z.ball_trail
        if not bt.active then return end
        if not throttle("ball_trail", 0) then return end
        local b = bt.get_ball()
        if not b then bt.detach(); return end
        if #bt.attachments == 0 then bt.attach(b) end
        bt.animate(dt)
    end)
end

Z.ball_trail.stop = function()
    if not Z.ball_trail.active then return end
    Z.ball_trail.active = false
    if Z.ball_trail.connection then Z.ball_trail.connection:Disconnect(); Z.ball_trail.connection = nil end
    Z.ball_trail.detach()
end

Z.ball_trail.update_color = function(color)
    Z.ball_trail.color = color
    for _, a in ipairs(Z.ball_trail.attachments) do
        if a.trail and a.trail.Parent then a.trail.Color = Z.ball_trail.build_color() end
    end
end

-- ============================================================
-- PARRY VISUALIZER
-- ============================================================
Z.parry_visualizer.rebuild = function()
    for _, p in ipairs(Z.parry_visualizer.parts) do
        if p and p.Parent then p:Destroy() end
    end
    Z.parry_visualizer.parts = {}
    local seg = 160
    for _ = 1, seg do
        local p = Instance.new("Part")
        p.Anchored = true
        p.CanCollide = false
        p.CanQuery = false
        p.CanTouch = false
        p.CastShadow = false
        p.Material = Enum.Material.Neon
        p.Color = Z.parry_visualizer.color
        p.Size = Vector3.new(0.25, 0.25, 0.1)
        p.Parent = Workspace
        table.insert(Z.parry_visualizer.parts, p)
    end
end

Z.parry_visualizer.get_parry_radius = function()
    local maxSpeed = 0
    for _, b in ipairs(Ball.get_all()) do
        local v = Ball.get_velocity(b.part, b.model)
        maxSpeed = math.max(maxSpeed, v.Magnitude)
    end
    return clamp(Parry.get_premium_parry_distance(maxSpeed, Z.config.accuracy), 4, 60)
end

Z.parry_visualizer.get_ground = function(root)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { root.Parent }
    local hit = Workspace:Raycast(root.Position, Vector3.new(0, -50, 0), params)
    if hit then return hit.Position + Vector3.new(0, 0.03, 0) end
    return root.Position - Vector3.new(0, 3, 0)
end

Z.parry_visualizer.update_ring = function(center, radius)
    local parts = Z.parry_visualizer.parts
    local n = #parts
    if n == 0 then return end
    local seg = n
    for i, p in ipairs(parts) do
        local ang = (i - 1) / seg * TAU
        local x1 = center.X + math.cos(ang) * radius
        local z1 = center.Z + math.sin(ang) * radius
        local ang2 = ang + TAU / seg
        local x2 = center.X + math.cos(ang2) * radius
        local z2 = center.Z + math.sin(ang2) * radius
        p.Size = Vector3.new(0.25, 0.25, (Vector3.new(x2, center.Y, z2) - Vector3.new(x1, center.Y, z1)).Magnitude + 0.02)
        p.CFrame = CFrame.new(Vector3.new(x1, center.Y, z1), Vector3.new(x2, center.Y, z2))
    end
end

Z.parry_visualizer.start = function()
    if Z.parry_visualizer.active then return end
    Z.parry_visualizer.active = true
    Z.parry_visualizer.current_radius = 1
    Z.parry_visualizer.rebuild()
    Z.parry_visualizer.char_conn = localPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if Z.parry_visualizer.active then Z.parry_visualizer.rebuild() end
    end)
    Z.parry_visualizer.connection = RunService.Heartbeat:Connect(function()
        local v = Z.parry_visualizer
        if not v.active then return end
        if not throttle("parry_viz", 0.05) then return end
        local root = Player.get_root()
        if #v.parts == 0 then v.rebuild(); return end
        if not root then return end
        local ground = v.get_ground(root)
        local radius = v.get_parry_radius()
        v.current_radius = v.current_radius + (radius - v.current_radius) * 0.15
        v.update_ring(ground, v.current_radius)
    end)
end

Z.parry_visualizer.stop = function()
    if not Z.parry_visualizer.active then return end
    Z.parry_visualizer.active = false
    if Z.parry_visualizer.connection then Z.parry_visualizer.connection:Disconnect(); Z.parry_visualizer.connection = nil end
    if Z.parry_visualizer.char_conn then Z.parry_visualizer.char_conn:Disconnect(); Z.parry_visualizer.char_conn = nil end
    for _, p in ipairs(Z.parry_visualizer.parts) do
        if p and p.Parent then p:Destroy() end
    end
    Z.parry_visualizer.parts = {}
end

Z.parry_visualizer.update_color = function(color)
    Z.parry_visualizer.color = color
    for _, p in ipairs(Z.parry_visualizer.parts) do
        if p and p.Parent then p.Color = color end
    end
end

-- ============================================================
-- BALL INDICATOR
-- ============================================================
Z.ball_indicator.start = function()
    if Z.ball_indicator.active then return end
    Z.ball_indicator.active = true
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZenthraBallIndicator"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = get_safe_parent()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, Z.ball_indicator.size, 0, Z.ball_indicator.size)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = 1
    frame.Parent = gui
    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.Size = UDim2.new(1, 0, 1, 0)
    img.Position = UDim2.new(0.5, 0, 0.5, 0)
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.Image = "rbxassetid://18604510750"
    img.ImageColor3 = Color3.new(0, 1, 0)
    img.Parent = frame
    Z.ball_indicator.gui = gui
    Z.ball_indicator.connection = RunService.RenderStepped:Connect(function(dt)
        local bi = Z.ball_indicator
        if not bi.active then return end
        if not throttle("ball_indicator", 0.033) then return end
        local ball = Ball.get_first()
        local c = localPlayer.Character
        if not ball or not c or not c.PrimaryPart then img.Visible = false; return end
        img.Visible = true
        local delta = ball.Position - c.PrimaryPart.Position
        local dist = delta.Magnitude
        local unit = delta.Unit
        local cam = currentCamera.CFrame
        local ang = math.atan2(unit:Dot(cam.RightVector), unit:Dot(cam.LookVector))
        local r = clamp(dist / 50 * bi.distance, 0, bi.distance)
        local target = Vector2.new(math.sin(ang) * r, -math.cos(ang) * r)
        bi.position = bi.position:Lerp(target, math.min(12 * dt, 1))
        frame.Position = UDim2.new(0.5, bi.position.X, 0.5, bi.position.Y)
        bi.rotation = bi.rotation + (math.deg(ang) - bi.rotation) * math.min(8 * dt, 1)
        img.Rotation = bi.rotation
    end)
end

Z.ball_indicator.stop = function()
    if not Z.ball_indicator.active then return end
    Z.ball_indicator.active = false
    if Z.ball_indicator.connection then Z.ball_indicator.connection:Disconnect(); Z.ball_indicator.connection = nil end
    if Z.ball_indicator.gui then Z.ball_indicator.gui:Destroy(); Z.ball_indicator.gui = nil end
end

-- ============================================================
-- NO RENDER
-- ============================================================
Z.no_render.start = function()
    if Z.no_render.active then return end
    Z.no_render.active = true
    pcall(function()
        localPlayer.PlayerScripts.EffectScripts.ClientFX.Disabled = true
    end)
    local alive = Workspace:FindFirstChild("Alive")
    if alive then
        for _, c in ipairs(alive:GetChildren()) do
            for _, d in ipairs(c:GetDescendants()) do
                if d.Name == "ParryFX" or d:HasTag("ParryFX") then d:Destroy() end
            end
        end
    end
end

Z.no_render.stop = function()
    if not Z.no_render.active then return end
    Z.no_render.active = false
    pcall(function()
        localPlayer.PlayerScripts.EffectScripts.ClientFX.Disabled = false
    end)
end

-- ============================================================
-- ABILITY ESP (Drawing based)
-- ============================================================
local ability_names_cache
local function get_ability_module(name)
    if not name or name == "" then return nil end
    local ok, mod = pcall(function() return require(ReplicatedStorage.Shared.Abilities[name]) end)
    return ok and mod or nil
end

local ability_icons_cache
local function get_ability_icon(name)
    if not name or name == "" then return nil end
    if not ability_icons_cache then
        local ok, mod = pcall(require, ReplicatedStorage.Shared.AbilityIcons)
        ability_icons_cache = ok and mod or false
    end
    if ability_icons_cache then
        local id = ability_icons_cache[name]
        if type(id) == "string" and id ~= "" then return id end
    end
    return nil
end

local function get_ability_upgrade(plr, abilityName)
    if not abilityName or abilityName == "" then return 0 end
    local ok, val = pcall(function() return plr.Upgrades[abilityName].Value end)
    return ok and val or 0
end

local function get_ability_level(plr, abilityName)
    if not abilityName or abilityName == "" then return nil end
    return abilityName .. " V" .. (get_ability_upgrade(plr, abilityName) + 1)
end

local function make_drawing_text(size, color)
    local d = Drawing.new("Text")
    d.Visible = false
    d.Center = true
    d.Outline = true
    d.OutlineColor = Color3.new(0,0,0)
    d.Color = color
    d.Size = size
    d.Font = Drawing.Fonts.UI
    return d
end

Z.ability_esp.create_drawing = function(plr)
    if Z.ability_esp.drawings[plr] then
        Z.ability_esp.remove_drawing(plr)
    end
    Z.ability_esp.drawings[plr] = {
        nameDraw = make_drawing_text(Z.ability_esp.name_size, Z.ability_esp.name_color),
        abilityDraw = make_drawing_text(Z.ability_esp.ability_size, Z.ability_esp.ability_color),
        timerDraw = make_drawing_text(Z.ability_esp.active_size, Z.ability_esp.active_color),
        cdDraw = make_drawing_text(Z.ability_esp.cd_size, Z.ability_esp.cd_color),
        usesDraw = make_drawing_text(Z.ability_esp.active_size, Color3.fromRGB(100, 255, 150)),
        curUses = nil, maxUses = nil,
        activeStart = nil, activeDur = nil,
        cdStart = nil, cdLen = nil,
        abilityName = nil, abilityLine = nil,
        iconId = nil,
        charConns = {},
    }
end

Z.ability_esp.remove_drawing = function(plr)
    local d = Z.ability_esp.drawings[plr]
    if not d then return end
    d.nameDraw:Remove()
    d.abilityDraw:Remove()
    d.timerDraw:Remove()
    d.cdDraw:Remove()
    d.usesDraw:Remove()
    for _, c in ipairs(d.charConns or {}) do pcall(function() c:Disconnect() end) end
    Z.ability_esp.drawings[plr] = nil
end

Z.ability_esp.hide_all = function(d)
    d.nameDraw.Visible = false
    d.abilityDraw.Visible = false
    d.timerDraw.Visible = false
    d.cdDraw.Visible = false
    d.usesDraw.Visible = false
end

Z.ability_esp.begin_cd = function(d, plr)
    local mod = get_ability_module(d.abilityName)
    if not mod or not mod.cooldown then return end
    local upg = get_ability_upgrade(plr, d.abilityName)
    local cd = math.max(0, mod.cooldown - (mod.cooldownReductionPerUpgrade or 0) * (upg or 0))
    if cd > 0 then
        d.cdStart = tick()
        d.cdLen = cd
    end
end

Z.ability_esp.track_player = function(plr)
    Z.ability_esp.create_drawing(plr)

    local function bindChar(char)
        local d = Z.ability_esp.drawings[plr]
        if not d then return end
        for _, c in ipairs(d.charConns) do pcall(function() c:Disconnect() end) end
        table.clear(d.charConns)
        d.activeStart = nil
        d.activeDur = nil
        d.cdStart = nil
        d.cdLen = nil
        local abilityName = plr:GetAttribute("CurrentlyEquippedAbility")
        if abilityName and abilityName ~= "" then
            d.abilityName = abilityName
            d.abilityLine = get_ability_level(plr, abilityName)
            d.iconId = get_ability_icon(abilityName)
            if abilityName == "Dribble" then
                d.maxUses = 2 + (get_ability_upgrade(plr, abilityName) or 0)
                d.curUses = d.maxUses
            end
        end
        table.insert(d.charConns, char.AttributeChanged:Connect(function(attr)
            local dd = Z.ability_esp.drawings[plr]
            if not dd then return end
            if attr == "AbilityActive" then
                local active = char:GetAttribute("AbilityActive")
                local dur = plr:GetAttribute("AbilityDuration")
                if active == true and dur and dur > 0 then
                    dd.activeStart = tick()
                    dd.activeDur = dur
                else
                    dd.activeStart = nil
                    dd.activeDur = nil
                end
            end
        end))
        table.insert(d.charConns, plr.AttributeChanged:Connect(function(attr)
            local dd = Z.ability_esp.drawings[plr]
            if not dd then return end
            if attr == "CurrentlyEquippedAbility" then
                local newName = plr:GetAttribute("CurrentlyEquippedAbility")
                dd.abilityName = newName
                dd.abilityLine = get_ability_level(plr, newName)
                dd.cdStart = nil
                dd.cdLen = nil
                dd.iconId = get_ability_icon(newName)
                if newName == "Dribble" then
                    dd.maxUses = 2 + (get_ability_upgrade(plr, newName) or 0)
                    dd.curUses = dd.maxUses
                else
                    dd.maxUses = nil
                    dd.curUses = nil
                end
            elseif attr == "AbilityDuration" then
                local active = char:GetAttribute("AbilityActive")
                local dur = plr:GetAttribute("AbilityDuration")
                if active == true and dur and dur > 0 then
                    dd.activeStart = tick()
                    dd.activeDur = dur
                end
            end
        end))
    end

    if plr.Character then bindChar(plr.Character) end
    plr.CharacterAdded:Connect(bindChar)
    plr.CharacterRemoving:Connect(function()
        local d = Z.ability_esp.drawings[plr]
        if not d then return end
        Z.ability_esp.hide_all(d)
        d.activeStart = nil
        d.activeDur = nil
        d.cdStart = nil
        d.cdLen = nil
    end)
end

Z.ability_esp.update = function()
    local e = Z.ability_esp
    if not e.active then return end
    local now = tick()
    for plr, d in pairs(e.drawings) do
        if not plr or not plr.Parent then
            e.remove_drawing(plr)
            continue
        end
        local char = plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        if not root then
            e.hide_all(d)
            continue
        end
        local function worldToScreen(pos)
            local sp, on = currentCamera:WorldToViewportPoint(pos)
            if not on or sp.Z <= 0 then return nil end
            return Vector2.new(sp.X, sp.Y)
        end
        local anchor = worldToScreen((head or root).Position + Vector3.new(0, (head and head.Size.Y * 0.5 + 1.5) or 2, 0))
        if not anchor then
            e.hide_all(d)
            continue
        end
        local offset = 0
        if e.show_name then
            local name = e.name_mode == "Username" and plr.Name or plr.DisplayName
            offset += e.name_size + 2
            d.nameDraw.Position = anchor + Vector2.new(0, -offset)
            d.nameDraw.Text = name
            d.nameDraw.Size = e.name_size
            d.nameDraw.Color = e.name_color
            d.nameDraw.Visible = true
        else
            d.nameDraw.Visible = false
        end
        if d.abilityLine then
            local pos = anchor + Vector2.new(0, offset)
            d.abilityDraw.Position = pos
            d.abilityDraw.Text = d.abilityLine
            d.abilityDraw.Size = e.ability_size
            d.abilityDraw.Color = e.ability_color
            d.abilityDraw.Visible = true
            offset += e.ability_size + 4
        else
            d.abilityDraw.Visible = false
        end
        if e.show_cd and d.cdStart and d.cdLen then
            local left = math.max(0, d.cdLen - (now - d.cdStart))
            if left > 0 then
                d.cdDraw.Position = anchor + Vector2.new(0, offset)
                d.cdDraw.Size = e.cd_size
                d.cdDraw.Color = e.cd_color
                d.cdDraw.Text = string.format("cd %.1fs", left)
                d.cdDraw.Visible = true
                offset += e.cd_size + 2
            else
                d.cdDraw.Visible = false
                d.cdStart = nil
                d.cdLen = nil
            end
        else
            d.cdDraw.Visible = false
        end
        if e.show_timer and d.activeStart and d.activeDur then
            local left = math.max(0, d.activeDur - (now - d.activeStart))
            if left > 0 then
                d.timerDraw.Position = anchor + Vector2.new(0, offset)
                d.timerDraw.Size = e.active_size
                d.timerDraw.Color = e.active_color
                d.timerDraw.Text = string.format("active %.1fs", left)
                d.timerDraw.Visible = true
                offset += e.active_size + 2
            else
                d.timerDraw.Visible = false
                d.activeStart = nil
                d.activeDur = nil
            end
        else
            d.timerDraw.Visible = false
        end
    end
end

Z.ability_esp.start = function()
    if Z.ability_esp.active then return end
    Z.ability_esp.active = true
    pcall(function() require(ReplicatedStorage.Shared.Abilities) end)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer then Z.ability_esp.track_player(p) end
    end
    Players.PlayerAdded:Connect(function(p)
        if Z.ability_esp.active and p ~= localPlayer then Z.ability_esp.track_player(p) end
    end)
    Players.PlayerRemoving:Connect(function(p)
        Z.ability_esp.remove_drawing(p)
    end)
    Z.ability_esp.connection = RunService.RenderStepped:Connect(Z.ability_esp.update)
end

Z.ability_esp.stop = function()
    if not Z.ability_esp.active then return end
    Z.ability_esp.active = false
    if Z.ability_esp.connection then Z.ability_esp.connection:Disconnect(); Z.ability_esp.connection = nil end
    for p in pairs(Z.ability_esp.drawings) do
        Z.ability_esp.remove_drawing(p)
    end
end

-- ============================================================
-- KILL SOUND / HIT SOUND
-- ============================================================
local sound_templates = setmetatable({}, {__mode="v"})

Z.sound_fx = {}
Z.sound_fx.play = function(soundId, volume, duration)
    if type(soundId) ~= "string" or soundId == "" then return false end
    local tpl = sound_templates[soundId]
    if not tpl then
        local s = Instance.new("Sound")
        s.SoundId = soundId
        sound_templates[soundId] = s
        task.spawn(function() pcall(function() ContentProvider:PreloadAsync({s}) end) end)
        tpl = s
    end
    local clone = tpl:Clone()
    local vol = clamp(tonumber(volume) or 50, 0, 100) / 100 * 2
    clone.Volume = vol
    clone.Parent = SoundService
    local done = false
    local function cleanup()
        if done then return end
        done = true
        pcall(function() clone:Destroy() end)
    end
    pcall(function() clone.Ended:Connect(cleanup) end)
    pcall(function() clone:Play() end)
    task.delay(duration or 15, cleanup)
    return true
end

Z.kill_sound.names = {
    "None", "UwU", "Medal", "Fatality", "Skeet", "Switches", "Rust Headshot",
    "Neverlose Sound", "Bubble", "Laser", "Steve", "Call of Duty", "Bat",
    "TF2 Critical", "Saber", "Bameware",
}

Z.kill_sound.ids = {
    UwU = "rbxassetid://8323804973",
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

Z.hit_sound.ids = Z.kill_sound.ids
Z.hit_sound.names = Z.kill_sound.names

Z.kill_sound.play = function(force)
    local flags = Flags
    if not force then
        if not Z.kill_sound.enabled and flags.kill_sound_module ~= true then return end
    end
    local sel = flags.kill_sound_selected
    if type(sel) == "table" then sel = sel[1] end
    local id = Z.kill_sound.ids[sel]
    if not id then return false end
    Z.sound_fx.play(id, flags.kill_sound_volume, 10)
    return true
end

Z.hit_sound.play = function(force)
    local flags = Flags
    if not force then
        if not Z.hit_sound.enabled and flags.hit_sound_module ~= true then return end
    end
    local sel = flags.hit_sound_selected
    if type(sel) == "table" then sel = sel[1] end
    local id = Z.hit_sound.ids[sel]
    if not id then return false end
    Z.sound_fx.play(id, flags.hit_sound_volume, 10)
    return true
end

-- ============================================================
-- HOOKS FOR SOUNDS
-- ============================================================
task.spawn(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 30)
    if not remotes then return end
    local killed = remotes:WaitForChild("Killed", 30)
    if killed then
        track(killed.OnClientEvent:Connect(function()
            pcall(Z.kill_sound.play)
        end))
    end
    local parrySuccess = remotes:WaitForChild("ParrySuccess", 30)
    if parrySuccess then
        track(parrySuccess.OnClientEvent:Connect(function()
            pcall(Z.hit_sound.play)
        end))
    end
end)

-- ============================================================
-- SWORD MATERIAL
-- ============================================================
local SWORD_MATERIAL_ENUM = {
    Default = Enum.Material.Plastic,
    ForceField = Enum.Material.ForceField,
    Glass = Enum.Material.Glass,
    Neon = Enum.Material.Neon,
    Ice = Enum.Material.Ice,
    Metal = Enum.Material.Metal,
    DiamondPlate = Enum.Material.DiamondPlate,
    Granite = Enum.Material.Granite,
    Marble = Enum.Material.Marble,
    Wood = Enum.Material.Wood,
    Foil = Enum.Material.Foil,
    SmoothPlastic = Enum.Material.SmoothPlastic,
}

Z.sword_material.get_item_info = function()
    if Z.sword_material.item_info then return Z.sword_material.item_info end
    local ok, mod = pcall(function() return require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ItemInfo")) end)
    if ok then Z.sword_material.item_info = mod end
    return Z.sword_material.item_info
end

local BODY_PARTS = {
    Head=true, Torso=true, HumanoidRootPart=true, UpperTorso=true, LowerTorso=true,
    LeftUpperArm=true, LeftLowerArm=true, LeftHand=true,
    RightUpperArm=true, RightLowerArm=true, RightHand=true,
    LeftUpperLeg=true, LeftLowerLeg=true, LeftFoot=true,
    RightUpperLeg=true, RightLowerLeg=true, RightFoot=true,
}

local function is_body_part(p)
    return p and (p:IsA("BasePart") or p:IsA("MeshPart")) and BODY_PARTS[p.Name] == true
end

local function is_sword_root(obj, char, name)
    if not obj or not (obj:IsA("Model") or obj:IsA("Tool")) then return false end
    if is_body_part(obj) then return false end
    local info = Z.sword_material.get_item_info()
    if info and info.Sword and info.Sword[obj.Name] then return true end
    if obj.Name == "Base Sword" or obj.Name == "BaseSword" then return true end
    if name ~= "" and obj.Name == name then return true end
    if obj:IsA("Tool") and obj:FindFirstChildWhichIsA("BasePart", true) then return true end
    if obj.Parent == char and obj:IsA("Model") and not obj:FindFirstChildOfClass("Humanoid") then
        if obj:FindFirstChildWhichIsA("Accessory", true) then return false end
        local n = obj.Name:lower()
        if n:find("hitbox") or n:find("collision") or n:find("aura") then return false end
        local main = obj:FindFirstChildWhichIsA("MeshPart", true) or obj:FindFirstChildWhichIsA("BasePart", true)
        if main and not is_body_part(main) then return true end
    end
    return false
end

local function find_sword_roots(char)
    if not char then return {} end
    local out, seen = {}, {}
    local name = char:GetAttribute("CurrentlyEquippedSword") or ""
    local function try(o)
        if not o or seen[o] then return end
        if is_sword_root(o, char, name) then
            seen[o] = true
            table.insert(out, o)
        end
    end
    if name ~= "" then
        local s = char:FindFirstChild(name, true)
        if s then
            if s:IsA("Model") or s:IsA("Tool") then try(s)
            elseif s:IsA("BasePart") or s:IsA("MeshPart") then
                local a = s:FindFirstAncestorWhichIsA("Model")
                if a and a ~= char then try(a) end
            end
        end
    end
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Model") or c:IsA("Tool") then try(c)
        elseif c:IsA("Folder") then
            for _, cc in ipairs(c:GetChildren()) do
                if cc:IsA("Model") or cc:IsA("Tool") then try(cc) end
            end
        end
    end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("Model") or d:IsA("Tool") then try(d) end
    end
    return out
end

Z.sword_material.apply_part = function(part)
    if not part or not part.Parent then return end
    if not (part:IsA("BasePart") or part:IsA("MeshPart")) then return end
    if is_body_part(part) then return end
    if part.Transparency >= 0.999 then return end
    if not Z.sword_material.originals[part] then
        local tbl = {
            Material = part.Material,
            Color = part.Color,
            Transparency = part.Transparency,
            Reflectance = part.Reflectance,
        }
        Z.sword_material.originals[part] = tbl
    end
    local og = Z.sword_material.originals[part]
    local matEnabled = Z.sword_material.material_enabled and Z.sword_material.material ~= "Default"
    local colEnabled = Z.sword_material.color_enabled
    if not matEnabled and not colEnabled then
        pcall(function()
            part.Material = og.Material
            part.Color = og.Color
            part.Transparency = og.Transparency
        end)
        return
    end
    pcall(function()
        if matEnabled then
            local m = SWORD_MATERIAL_ENUM[Z.sword_material.material]
            if m then part.Material = m end
        elseif colEnabled then
            if og.Material then part.Material = og.Material end
            if og.Transparency ~= nil then part.Transparency = og.Transparency end
        else
            if og.Material then part.Material = og.Material end
            if og.Transparency ~= nil then part.Transparency = og.Transparency end
        end
        if colEnabled then
            part.Color = Z.sword_material.custom_color
        elseif og.Color then
            part.Color = og.Color
        end
    end)
end

Z.sword_material.apply_sword = function(root)
    if not root or not root.Parent then return end
    local parts = Z.sword_material.sword_parts[root]
    if not parts then return end
    for i = 1, #parts do
        Z.sword_material.apply_part(parts[i])
    end
end

Z.sword_material.refresh_swords = function(char)
    if not char then return end
    Z.sword_material.cached_roots = find_sword_roots(char)
    local seen = {}
    for _, root in ipairs(Z.sword_material.cached_roots) do
        seen[root] = true
        if not Z.sword_material.sword_conns[root] then
            local parts = {}
            if root:IsA("BasePart") or root:IsA("MeshPart") then
                table.insert(parts, root)
            else
                for _, d in ipairs(root:GetDescendants()) do
                    if d:IsA("BasePart") or d:IsA("MeshPart") then
                        table.insert(parts, d)
                    end
                end
            end
            Z.sword_material.sword_parts[root] = parts
            Z.sword_material.sword_conns[root] = root.DescendantAdded:Connect(function()
                Z.sword_material.schedule_reapply()
            end)
        end
        Z.sword_material.apply_sword(root)
    end
    for root, conn in pairs(Z.sword_material.sword_conns) do
        if not seen[root] or not root.Parent then
            if conn then pcall(function() conn:Disconnect() end) end
            Z.sword_material.sword_conns[root] = nil
            Z.sword_material.sword_parts[root] = nil
        end
    end
end

Z.sword_material.apply_all = function()
    if not Z.sword_material.enabled then return end
    local char = localPlayer.Character
    if not char then return end
    if #Z.sword_material.cached_roots == 0 then Z.sword_material.refresh_swords(char) end
    for i = #Z.sword_material.cached_roots, 1, -1 do
        local root = Z.sword_material.cached_roots[i]
        if not root or not root.Parent then
            table.remove(Z.sword_material.cached_roots, i)
        else
            Z.sword_material.apply_sword(root)
        end
    end
end

Z.sword_material.schedule_reapply = function()
    Z.sword_material._dirty = true
    Z.sword_material._dirty_t = os.clock()
end

Z.sword_material.update = function(dt)
    if not Z.sword_material.enabled then return end
    if Z.sword_material._applying then return end
    local char = localPlayer.Character
    if not char then return end
    local now = os.clock()
    if Z.sword_material._dirty then
        if now - (Z.sword_material._dirty_t or 0) >= 0.12 then
            Z.sword_material._dirty = false
            Z.sword_material._applying = true
            pcall(function()
                Z.sword_material.refresh_swords(char)
                Z.sword_material.apply_all()
            end)
            Z.sword_material._applying = false
        end
        return
    end
    Z.sword_material._accum = (Z.sword_material._accum or 0) + (dt or 0)
    if Z.sword_material._accum < 0.5 then return end
    Z.sword_material._accum = 0
    Z.sword_material._applying = true
    pcall(Z.sword_material.apply_all)
    Z.sword_material._applying = false
end

Z.sword_material.monitor_char = function(char)
    if not char then return end
    if Z.sword_material.char_conn then Z.sword_material.char_conn:Disconnect(); Z.sword_material.char_conn = nil end
    if Z.sword_material.char_desc_conn then Z.sword_material.char_desc_conn:Disconnect(); Z.sword_material.char_desc_conn = nil end
    if Z.sword_material.char_attr_conn then Z.sword_material.char_attr_conn:Disconnect(); Z.sword_material.char_attr_conn = nil end
    Z.sword_material.char_conn = char.ChildAdded:Connect(function()
        if not Z.sword_material._applying then Z.sword_material.schedule_reapply() end
    end)
    Z.sword_material.char_desc_conn = char.DescendantAdded:Connect(function(d)
        if not Z.sword_material._applying and (d:IsA("Model") or d:IsA("Tool") or d:IsA("BasePart") or d:IsA("MeshPart")) then
            Z.sword_material.schedule_reapply()
        end
    end)
    Z.sword_material.char_attr_conn = char:GetAttributeChangedSignal("CurrentlyEquippedSword"):Connect(function()
        Z.sword_material.schedule_reapply()
    end)
    Z.sword_material.refresh_swords(char)
end

Z.sword_material.start = function()
    Z.sword_material.enabled = true
    if Z.sword_material.started then Z.sword_material.schedule_reapply(); return end
    Z.sword_material.started = true
    Z.sword_material.player_conn = localPlayer.CharacterAdded:Connect(function(c)
        task.defer(function()
            Z.sword_material.monitor_char(c)
            Z.sword_material.schedule_reapply()
        end)
    end)
    Z.sword_material.render_conn = RunService.Heartbeat:Connect(Z.sword_material.update)
    if localPlayer.Character then Z.sword_material.monitor_char(localPlayer.Character) end
    Z.sword_material.schedule_reapply()
end

Z.sword_material.stop = function()
    Z.sword_material.enabled = false
    Z.sword_material.started = false
    if Z.sword_material.player_conn then Z.sword_material.player_conn:Disconnect(); Z.sword_material.player_conn = nil end
    if Z.sword_material.render_conn then Z.sword_material.render_conn:Disconnect(); Z.sword_material.render_conn = nil end
    if Z.sword_material.char_conn then Z.sword_material.char_conn:Disconnect(); Z.sword_material.char_conn = nil end
    if Z.sword_material.char_desc_conn then Z.sword_material.char_desc_conn:Disconnect(); Z.sword_material.char_desc_conn = nil end
    if Z.sword_material.char_attr_conn then Z.sword_material.char_attr_conn:Disconnect(); Z.sword_material.char_attr_conn = nil end
    for root, conn in pairs(Z.sword_material.sword_conns) do
        if conn then pcall(function() conn:Disconnect() end) end
    end
    Z.sword_material.sword_conns = {}
    Z.sword_material.sword_parts = {}
    Z.sword_material.cached_roots = {}
    for part, og in pairs(Z.sword_material.originals) do
        if part.Parent then
            pcall(function()
                part.Material = og.Material
                part.Color = og.Color
                part.Transparency = og.Transparency
            end)
        end
    end
    table.clear(Z.sword_material.originals)
end

-- ============================================================
-- AVATAR MATERIAL (same structure, different target set)
-- ============================================================
Z.avatar_material.get_item_info = Z.sword_material.get_item_info

local function is_sword_ancestor(o, char)
    local info = Z.avatar_material.get_item_info()
    local parent = o.Parent
    while parent and parent ~= char do
        if parent:IsA("Model") or parent:IsA("Tool") then
            if info and info.Sword and info.Sword[parent.Name] then return true end
            if parent.Name == "Base Sword" or parent.Name == "BaseSword" then return true end
        end
        parent = parent.Parent
    end
    return false
end

local function is_target_part(p, char)
    if not char or not p or not p:IsDescendantOf(char) then return false end
    if not (p:IsA("BasePart") or p:IsA("MeshPart")) then return false end
    if p.Transparency >= 0.999 then return false end
    if is_sword_ancestor(p, char) then return false end
    return true
end

Z.avatar_material.apply_part = function(part)
    if not part or not part.Parent then return end
    if not (part:IsA("BasePart") or part:IsA("MeshPart")) then return end
    if part.Transparency >= 0.999 then return end
    local char = localPlayer.Character
    if not char or not is_target_part(part, char) then return end
    if not Z.avatar_material.originals[part] then
        Z.avatar_material.originals[part] = {
            Material = part.Material,
            Color = part.Color,
            Transparency = part.Transparency,
            Reflectance = part.Reflectance,
        }
    end
    local og = Z.avatar_material.originals[part]
    local matEnabled = Z.avatar_material.material_enabled and Z.avatar_material.material ~= "Default"
    local colEnabled = Z.avatar_material.color_enabled
    if not matEnabled and not colEnabled then
        pcall(function()
            part.Material = og.Material
            part.Color = og.Color
            part.Transparency = og.Transparency
        end)
        return
    end
    pcall(function()
        if matEnabled then
            local m = SWORD_MATERIAL_ENUM[Z.avatar_material.material]
            if m then part.Material = m end
        else
            if og.Material then part.Material = og.Material end
            if og.Transparency ~= nil then part.Transparency = og.Transparency end
        end
        if colEnabled then
            part.Color = Z.avatar_material.custom_color
        elseif og.Color then
            part.Color = og.Color
        end
    end)
end

Z.avatar_material.refresh_target_parts = function(char)
    table.clear(Z.avatar_material.cached_parts)
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if is_target_part(d, char) then
            table.insert(Z.avatar_material.cached_parts, d)
        end
    end
end

Z.avatar_material.apply_all = function()
    if not Z.avatar_material.enabled then return end
    local char = localPlayer.Character
    if not char then return end
    if #Z.avatar_material.cached_parts == 0 then Z.avatar_material.refresh_target_parts(char) end
    for i = #Z.avatar_material.cached_parts, 1, -1 do
        local p = Z.avatar_material.cached_parts[i]
        if not p or not p.Parent or not p:IsDescendantOf(char) then
            table.remove(Z.avatar_material.cached_parts, i)
        else
            Z.avatar_material.apply_part(p)
        end
    end
end

Z.avatar_material.schedule_reapply = function()
    Z.avatar_material._dirty = true
    Z.avatar_material._dirty_t = os.clock()
end

Z.avatar_material.update = function(dt)
    if not Z.avatar_material.enabled then return end
    if Z.avatar_material._applying then return end
    local char = localPlayer.Character
    if not char then return end
    local now = os.clock()
    if Z.avatar_material._dirty then
        if now - (Z.avatar_material._dirty_t or 0) >= 0.12 then
            Z.avatar_material._dirty = false
            Z.avatar_material._applying = true
            pcall(function()
                Z.avatar_material.refresh_target_parts(char)
                Z.avatar_material.apply_all()
            end)
            Z.avatar_material._applying = false
        end
        return
    end
    Z.avatar_material._accum = (Z.avatar_material._accum or 0) + (dt or 0)
    if Z.avatar_material._accum < 0.5 then return end
    Z.avatar_material._accum = 0
    Z.avatar_material._applying = true
    pcall(Z.avatar_material.apply_all)
    Z.avatar_material._applying = false
end

Z.avatar_material.monitor_char = function(char)
    if not char then return end
    if Z.avatar_material.char_conn then Z.avatar_material.char_conn:Disconnect() end
    if Z.avatar_material.char_desc_conn then Z.avatar_material.char_desc_conn:Disconnect() end
    Z.avatar_material.char_conn = char.ChildAdded:Connect(function()
        if not Z.avatar_material._applying then Z.avatar_material.schedule_reapply() end
    end)
    Z.avatar_material.char_desc_conn = char.DescendantAdded:Connect(function(d)
        if not Z.avatar_material._applying and (d:IsA("BasePart") or d:IsA("MeshPart")) then
            Z.avatar_material.schedule_reapply()
        end
    end)
    Z.avatar_material.refresh_target_parts(char)
end

Z.avatar_material.start = function()
    Z.avatar_material.enabled = true
    if Z.avatar_material.started then Z.avatar_material.schedule_reapply(); return end
    Z.avatar_material.started = true
    Z.avatar_material.player_conn = localPlayer.CharacterAdded:Connect(function(c)
        task.defer(function()
            Z.avatar_material.monitor_char(c)
            Z.avatar_material.schedule_reapply()
        end)
    end)
    Z.avatar_material.render_conn = RunService.Heartbeat:Connect(Z.avatar_material.update)
    if localPlayer.Character then Z.avatar_material.monitor_char(localPlayer.Character) end
    Z.avatar_material.schedule_reapply()
end

Z.avatar_material.stop = function()
    Z.avatar_material.enabled = false
    Z.avatar_material.started = false
    if Z.avatar_material.player_conn then Z.avatar_material.player_conn:Disconnect(); Z.avatar_material.player_conn = nil end
    if Z.avatar_material.render_conn then Z.avatar_material.render_conn:Disconnect(); Z.avatar_material.render_conn = nil end
    if Z.avatar_material.char_conn then Z.avatar_material.char_conn:Disconnect(); Z.avatar_material.char_conn = nil end
    if Z.avatar_material.char_desc_conn then Z.avatar_material.char_desc_conn:Disconnect(); Z.avatar_material.char_desc_conn = nil end
    for part, og in pairs(Z.avatar_material.originals) do
        if part.Parent then
            pcall(function()
                part.Material = og.Material
                part.Color = og.Color
                part.Transparency = og.Transparency
            end)
        end
    end
    table.clear(Z.avatar_material.originals)
    table.clear(Z.avatar_material.cached_parts)
end

-- ============================================================
-- AVATAR (korblox / headless)
-- ============================================================
Z.avatar.apply_korblox = function(char)
    local rl = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
    if not rl then return end
    for _, c in ipairs(rl:GetChildren()) do
        if c:IsA("SpecialMesh") or c:IsA("Mesh") then c:Destroy() end
    end
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "rbxassetid://101851696"
    mesh.TextureId = "rbxassetid://115727863"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = rl
end

Z.avatar.remove_korblox = function(char)
    local rl = char:FindFirstChild("RightLeg") or char:FindFirstChild("Right Leg")
    if not rl then return end
    for _, c in ipairs(rl:GetChildren()) do
        if c:IsA("SpecialMesh") and c.MeshId == "rbxassetid://101851696" then c:Destroy() end
    end
end

Z.avatar.set_korblox = function(enabled)
    Z.avatar.korblox_enabled = enabled
    if Z.avatar.korblox_conn then Z.avatar.korblox_conn:Disconnect(); Z.avatar.korblox_conn = nil end
    local char = localPlayer.Character
    if enabled then
        if char then Z.avatar.apply_korblox(char) end
        Z.avatar.korblox_conn = localPlayer.CharacterAdded:Connect(function(c)
            task.wait(0.1)
            if Z.avatar.korblox_enabled then Z.avatar.apply_korblox(c) end
        end)
    else
        if char then Z.avatar.remove_korblox(char) end
    end
end

Z.avatar.apply_headless = function(char)
    local head = char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 1
    local decal = head:FindFirstChildOfClass("Decal")
    if decal then decal:Destroy() end
end

Z.avatar.remove_headless = function(char)
    local head = char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 0
end

Z.avatar.set_headless = function(enabled)
    Z.avatar.headless_enabled = enabled
    if Z.avatar.headless_conn then Z.avatar.headless_conn:Disconnect(); Z.avatar.headless_conn = nil end
    local char = localPlayer.Character
    if enabled then
        if char then Z.avatar.apply_headless(char) end
        Z.avatar.headless_conn = localPlayer.CharacterAdded:Connect(function(c)
            task.wait(0.1)
            if Z.avatar.headless_enabled then Z.avatar.apply_headless(c) end
        end)
    else
        if char then Z.avatar.remove_headless(char) end
    end
end

-- ============================================================
-- WORLD CUSTOMIZER
-- ============================================================
local WC = Z.world_customizer

WC.save_lighting = function()
    if WC.originals.lighting then return end
    WC.originals.lighting = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ClockTime = Lighting.ClockTime,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
        GlobalShadows = Lighting.GlobalShadows,
        ExposureCompensation = Lighting.ExposureCompensation,
    }
end

WC.flag_on = function(key) return Flags["wc_" .. key] == true end
WC.get_flag = function(key, default)
    local v = Flags["wc_" .. key]
    if v == nil then return default end
    if type(v) == "table" and v.H then return Color3.fromHSV(v.H, v.S, v.V) end
    return v
end

WC.get_managed_cc = function()
    for _, c in ipairs(Lighting:GetChildren()) do
        if c:IsA("ColorCorrectionEffect") and c.Name ~= "ZenthraWorldCC" then
            if not WC.originals[c] then
                WC.originals[c] = { Enabled=c.Enabled, Saturation=c.Saturation, Brightness=c.Brightness, Contrast=c.Contrast, TintColor=c.TintColor }
            end
        end
    end
    local cc = Lighting:FindFirstChild("ZenthraWorldCC")
    if not cc then
        cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "ZenthraWorldCC"
        cc.Parent = Lighting
        WC.managed.cc = cc
    end
    return cc
end

WC.sync_cc = function()
    local enabled = WC.enabled and (WC.flag_on("saturation") or WC.flag_on("brightness") or WC.flag_on("contrast") or WC.flag_on("tint"))
    if not enabled then
        local cc = WC.managed.cc or Lighting:FindFirstChild("ZenthraWorldCC")
        if cc then cc:Destroy(); WC.managed.cc = nil end
        for k, og in pairs(WC.originals) do
            if typeof(k) == "Instance" and k:IsA("ColorCorrectionEffect") and k.Parent and k.Name ~= "ZenthraWorldCC" then
                for p, v in pairs(og) do k[p] = v end
            end
        end
        return
    end
    local cc = WC.get_managed_cc()
    cc.Enabled = true
    cc.Saturation = WC.flag_on("saturation") and WC.get_flag("saturation_amount", 0) or 0
    cc.Brightness = WC.flag_on("brightness") and WC.get_flag("brightness_amount", 0) or 0
    cc.Contrast = WC.flag_on("contrast") and WC.get_flag("contrast_amount", 0) or 0
    cc.TintColor = WC.flag_on("tint") and WC.get_flag("tint_color", Color3.new(1,1,1)) or Color3.new(1,1,1)
end

WC.apply = function(key)
    if not WC.enabled then return end
    WC.save_lighting()
    if key == "saturation" or key == "brightness" or key == "contrast" or key == "tint" then
        WC.sync_cc(); return
    end
    if key == "clock_time" then
        Lighting.ClockTime = WC.get_flag("clock_time_amount", 14)
    elseif key == "ambient" then
        Lighting.Ambient = WC.get_flag("ambient_color", Color3.fromRGB(128,128,128))
    elseif key == "outdoor_ambient" then
        Lighting.OutdoorAmbient = WC.get_flag("outdoor_ambient_color", Color3.fromRGB(128,128,128))
    elseif key == "light_brightness" then
        Lighting.Brightness = WC.get_flag("light_brightness_amount", 2)
    elseif key == "exposure" then
        Lighting.ExposureCompensation = WC.get_flag("exposure_amount", 0)
    elseif key == "disable_bloom" then
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("BloomEffect") then
                if not WC.originals[c] then WC.originals[c] = { Enabled=c.Enabled, Intensity=c.Intensity, Size=c.Size, Threshold=c.Threshold } end
                c.Enabled = false
            end
        end
    elseif key == "disable_sun_rays" then
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("SunRaysEffect") then
                if not WC.originals[c] then WC.originals[c] = { Enabled=c.Enabled, Intensity=c.Intensity, Spread=c.Spread } end
                c.Enabled = false
            end
        end
    elseif key == "disable_shadows" then
        Lighting.GlobalShadows = false
    elseif key == "disable_celestial" then
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("Sky") then
                if not WC.originals[c] then WC.originals[c] = { CelestialBodiesShown=c.CelestialBodiesShown, StarCount=c.StarCount } end
                c.CelestialBodiesShown = false
                c.StarCount = 0
            end
        end
    end
end

WC.revert = function(key)
    if key == "saturation" or key == "brightness" or key == "contrast" or key == "tint" then
        WC.sync_cc(); return
    end
    local light = WC.originals.lighting
    if key == "clock_time" and light then Lighting.ClockTime = light.ClockTime end
    if key == "ambient" and light then Lighting.Ambient = light.Ambient end
    if key == "outdoor_ambient" and light then Lighting.OutdoorAmbient = light.OutdoorAmbient end
    if key == "light_brightness" and light then Lighting.Brightness = light.Brightness end
    if key == "exposure" and light then Lighting.ExposureCompensation = light.ExposureCompensation end
    if key == "disable_shadows" and light then Lighting.GlobalShadows = light.GlobalShadows end
    if key == "disable_bloom" or key == "disable_sun_rays" or key == "disable_celestial" then
        for k, og in pairs(WC.originals) do
            if typeof(k) == "Instance" and k.Parent then
                for p, v in pairs(og) do pcall(function() k[p] = v end) end
            end
        end
    end
end

WC.apply_all = function()
    for _, key in ipairs(WC.order) do
        if WC.flag_on(key) then WC.apply(key) end
    end
end

WC.revert_all = function()
    for _, key in ipairs(WC.order) do
        if WC.flag_on(key) then WC.revert(key) end
    end
end

WC.start = function()
    WC.enabled = true
    WC.apply_all()
end

WC.stop = function()
    WC.enabled = false
    WC.revert_all()
end

WC.on_toggle = function(key, on)
    if on and WC.enabled then WC.apply(key) end
    if not on then WC.revert(key) end
end

WC.on_value = function(key)
    if WC.enabled and WC.flag_on(key) then WC.apply(key) end
end

-- ============================================================
-- LOW GRAPHICS
-- ============================================================
local LG = Z.low_graphics

LG.should_process = function(obj)
    if not obj or not obj.Parent then return false end
    if obj.Name:sub(1, 7) == "Zenthra" then return false end
    local pg = localPlayer:FindFirstChild("PlayerGui")
    if pg and obj:IsDescendantOf(pg) then return false end
    if CoreGui and obj:IsDescendantOf(CoreGui) then return false end
    local c = localPlayer.Character
    if c and obj:IsDescendantOf(c) then return false end
    return obj:IsDescendantOf(Workspace) or obj.Parent == Workspace or obj:IsDescendantOf(Lighting)
end

LG.strip = function(obj)
    if not LG.should_process(obj) or LG.saved[obj] then return end
    local tbl = {}
    if obj:IsA("MeshPart") then
        tbl.kind = "MeshPart"
        tbl.TextureID = obj.TextureID
        tbl.Material = obj.Material
        tbl.CastShadow = obj.CastShadow
        obj.TextureID = ""
        obj.Material = Enum.Material.SmoothPlastic
        obj.CastShadow = false
    elseif obj:IsA("BasePart") then
        tbl.kind = "BasePart"
        tbl.Material = obj.Material
        tbl.CastShadow = obj.CastShadow
        tbl.Color = obj.Color
        obj.Material = Enum.Material.SmoothPlastic
        obj.CastShadow = false
        local sa = obj:FindFirstChildOfClass("SurfaceAppearance")
        if sa then
            tbl.surface = sa
            tbl.ColorMap = sa.ColorMap
            tbl.MetalnessMap = sa.MetalnessMap
            tbl.NormalMap = sa.NormalMap
            tbl.RoughnessMap = sa.RoughnessMap
            sa.ColorMap = ""
            sa.MetalnessMap = ""
            sa.NormalMap = ""
            sa.RoughnessMap = ""
        end
    end
    if obj:IsA("ParticleEmitter") then
        tbl.kind = "ParticleEmitter"
        tbl.Rate = obj.Rate; tbl.Texture = obj.Texture; tbl.Enabled = obj.Enabled
        obj.Enabled = false; obj.Rate = 0; obj.Texture = ""
    end
    if obj:IsA("Beam") then
        tbl.kind = "Beam"; tbl.Texture = obj.Texture; tbl.Enabled = obj.Enabled
        obj.Texture = ""; obj.Enabled = false
    end
    if obj:IsA("Trail") then
        tbl.kind = "Trail"; tbl.Texture = obj.Texture; tbl.Enabled = obj.Enabled
        obj.Texture = ""; obj.Enabled = false
    end
    if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
        tbl.kind = "Light"; tbl.Enabled = obj.Enabled; tbl.Brightness = obj.Brightness; tbl.Shadows = obj.Shadows
        obj.Enabled = false; obj.Shadows = false
    end
    if tbl.kind then LG.saved[obj] = tbl end
end

LG.process_root = function(root)
    if not root then return end
    for _, d in ipairs(root:GetDescendants()) do LG.strip(d) end
    if root ~= Workspace then LG.strip(root) end
end

LG.restore = function(obj, tbl)
    if not obj or not obj.Parent or not tbl then return end
    if tbl.kind == "MeshPart" then
        if tbl.TextureID ~= nil then obj.TextureID = tbl.TextureID end
        if tbl.Material then obj.Material = tbl.Material end
        if tbl.CastShadow ~= nil then obj.CastShadow = tbl.CastShadow end
    elseif tbl.kind == "BasePart" then
        if tbl.Material then obj.Material = tbl.Material end
        if tbl.CastShadow ~= nil then obj.CastShadow = tbl.CastShadow end
        if tbl.Color then obj.Color = tbl.Color end
        if tbl.surface and tbl.surface.Parent then
            if tbl.ColorMap ~= nil then tbl.surface.ColorMap = tbl.ColorMap end
            if tbl.MetalnessMap ~= nil then tbl.surface.MetalnessMap = tbl.MetalnessMap end
            if tbl.NormalMap ~= nil then tbl.surface.NormalMap = tbl.NormalMap end
            if tbl.RoughnessMap ~= nil then tbl.surface.RoughnessMap = tbl.RoughnessMap end
        end
    elseif tbl.kind == "ParticleEmitter" then
        obj.Rate = tbl.Rate; obj.Texture = tbl.Texture; obj.Enabled = tbl.Enabled
    elseif tbl.kind == "Beam" then
        obj.Texture = tbl.Texture; obj.Enabled = tbl.Enabled
    elseif tbl.kind == "Trail" then
        obj.Texture = tbl.Texture; obj.Enabled = tbl.Enabled
    elseif tbl.kind == "Light" then
        obj.Enabled = tbl.Enabled; obj.Brightness = tbl.Brightness; obj.Shadows = tbl.Shadows
    end
end

LG.start = function()
    if LG.enabled then return end
    LG.enabled = true
    pcall(function()
        LG.quality_original = settings().Rendering.QualityLevel
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
    pcall(function() Workspace.Terrain.Decoration = false end)
    LG.process_root(Workspace)
    LG.process_root(Lighting)
    LG.connections.descendant = Workspace.DescendantAdded:Connect(function(d)
        if LG.enabled then
            task.defer(function()
                if LG.enabled then LG.strip(d) end
            end)
        end
    end)
end

LG.stop = function()
    if not LG.enabled then return end
    LG.enabled = false
    if LG.connections.descendant then LG.connections.descendant:Disconnect(); LG.connections.descendant = nil end
    for obj, tbl in pairs(LG.saved) do LG.restore(obj, tbl) end
    table.clear(LG.saved)
    pcall(function()
        if LG.quality_original then
            settings().Rendering.QualityLevel = LG.quality_original
        end
    end)
    pcall(function() Workspace.Terrain.Decoration = true end)
end

-- ============================================================
-- NOTIFICATION HELPER (forward decl for widgets)
-- ============================================================
local notify_fn = nil
function notify(title, text, success, duration)
    if notify_fn then return notify_fn(title, text, success, duration) end
end

-- ============================================================
-- GUI LIBRARY
-- ============================================================
local GUI = {}
GUI.State = {
    Connections = {},
    ThemeBindings = {},
    FontCache = {},
    Saved = {},
}
GUI.Palette = {
    Accent = Color3.fromRGB(246, 246, 249),
    AccentSoft = Color3.fromRGB(200, 198, 206),
    AccentDim = Color3.fromRGB(140, 140, 112),
    Background = Color3.fromRGB(8, 8, 10),
    Surface = Color3.fromRGB(16, 16, 19),
    SurfaceAlt = Color3.fromRGB(25, 25, 29),
    Border = Color3.fromRGB(40, 40, 46),
    BorderSoft = Color3.fromRGB(28, 28, 33),
    Text = Color3.fromRGB(246, 246, 249),
    SubText = Color3.fromRGB(136, 137, 144),
    Muted = Color3.fromRGB(100, 100, 99),
    Danger = Color3.fromRGB(232, 90, 94),
    Success = Color3.fromRGB(214, 214, 219),
    Warning = Color3.fromRGB(226, 200, 100),
}
GUI.Defaults = {}
for k, v in pairs(GUI.Palette) do GUI.Defaults[k] = v end

local FONT_FAMILY = "rbxasset://fonts/families/GothamSSm.json"
GUI.Layout = {
    FontFamily = FONT_FAMILY,
    Weight = Enum.FontWeight,
    Ease = Enum.EasingStyle.Quint,
    EaseIn = Enum.EasingDirection.In,
    Width = 680,
    Height = 500,
    TopbarH = 46,
    SidebarW = 140,
    TabH = 30,
    TabPad = 8,
    TabGap = 2,
    Row = 24,
    OptionH = 24,
    FieldH = 30,
    ChipH = 16,
    TabIndicatorSlide = 0.22,
}
if is_mobile then
    GUI.Layout.Row = 30
    GUI.Layout.OptionH = 30
    GUI.Layout.FieldH = 36
    GUI.Layout.TabH = 40
end

local function safe_parent()
    return get_safe_parent()
end

local function font(weight)
    weight = weight or Enum.FontWeight.Medium
    local cached = GUI.State.FontCache[weight]
    if not cached then
        cached = Font.new(FONT_FAMILY, weight)
        GUI.State.FontCache[weight] = cached
    end
    return cached
end

local function track_gui(c)
    table.insert(GUI.State.Connections, c)
    return c
end

local function new(className, props, children)
    local ok, inst = pcall(Instance.new, className)
    if not ok or not inst then return nil end
    if props then
        local parent = props.Parent
        if parent ~= nil then
            props.Parent = nil
            for k, v in pairs(props) do
                pcall(function() inst[k] = v end)
            end
            pcall(function() inst.Parent = parent end)
        else
            for k, v in pairs(props) do
                pcall(function() inst[k] = v end)
            end
        end
    end
    if children then
        for _, c in ipairs(children) do
            if c then c.Parent = inst end
        end
    end
    return inst
end

local function corner(radius, parent)
    local c = Instance.new("UICorner")
    c.CornerRadius = typeof(radius) == "UDim" and radius or UDim.new(0, radius or 8)
    if parent then c.Parent = parent end
    return c
end

local function stroke(color, thickness, transparency, parent)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    if typeof(color) == "Color3" then s.Color = color end
    if parent then s.Parent = parent end
    return s
end

local function tween(inst, props, duration, ease, dir)
    if not inst then return end
    local info = TweenInfo.new(duration or 0.22, ease or GUI.Layout.Ease, dir or Enum.EasingDirection.Out)
    local t = TweenService:Create(inst, info, props)
    t:Play()
    return t
end

local function theme_bind(inst, prop, key)
    table.insert(GUI.State.ThemeBindings, { instance = inst, property = prop, key = key })
    inst[prop] = GUI.Palette[key]
    return inst
end

local function theme_set(theme)
    theme = theme or {}
    for k, v in pairs(theme) do
        if GUI.Palette[k] ~= nil and typeof(v) == "Color3" then
            GUI.Palette[k] = v
        end
    end
    for i = #GUI.State.ThemeBindings, 1, -1 do
        local b = GUI.State.ThemeBindings[i]
        local ok = pcall(function() b.instance[b.property] = GUI.Palette[b.key] end)
        if not ok then table.remove(GUI.State.ThemeBindings, i) end
    end
end

GUI.theme_set = theme_set

-- ============================================================
-- NOTIFICATION
-- ============================================================
local NotifyState = {
    Width = 292,
    Gap = 8,
    Edge = 18,
    Position = "Right Bottom",
    Active = {},
}

local notifRoot = nil

local function get_notif_root()
    if notifRoot and notifRoot.Parent then return notifRoot end
    notifRoot = Instance.new("ScreenGui")
    notifRoot.Name = "ZenthraNotifications"
    notifRoot.ResetOnSpawn = false
    notifRoot.IgnoreGuiInset = true
    notifRoot.DisplayOrder = 9999
    notifRoot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notifRoot.Parent = safe_parent()
    return notifRoot
end

local function notif_profile()
    if NotifyState.Position == "Right Top" then
        return { ax = 1, ay = 0, xs = 1, ys = 0, shown = -NotifyState.Edge, hidden = NotifyState.Width + NotifyState.Edge, sign = 1 }
    elseif NotifyState.Position == "Left Bottom" then
        return { ax = 0, ay = 1, xs = 0, ys = 1, shown = NotifyState.Edge, hidden = -(NotifyState.Width + NotifyState.Edge), sign = -1 }
    elseif NotifyState.Position == "Left Top" then
        return { ax = 0, ay = 0, xs = 0, ys = 0, shown = NotifyState.Edge, hidden = -(NotifyState.Width + NotifyState.Edge), sign = 1 }
    end
    return { ax = 1, ay = 1, xs = 1, ys = 1, shown = -NotifyState.Edge, hidden = NotifyState.Width + NotifyState.Edge, sign = -1 }
end

local function notif_restack()
    local p = notif_profile()
    local base = p.sign > 0 and (NotifyState.Edge + GuiService:GetGuiInset().Y) or NotifyState.Edge
    for _, entry in ipairs(NotifyState.Active) do
        local card = entry.Card
        if not entry.Dismissing and card.Parent then
            card.AnchorPoint = Vector2.new(p.ax, p.ay)
            tween(card, { Position = UDim2.new(p.xs, p.shown, p.ys, p.sign * base) }, 0.2)
            base += entry.Height + NotifyState.Gap
        end
    end
end

local function notif_push(title, text, kind, duration)
    kind = kind or "info"
    duration = duration or 4
    local p = notif_profile()
    local parent = get_notif_root()

    local colors = {
        info = { key = "Accent", glyph = "info" },
        success = { key = "Success", glyph = "check" },
        error = { key = "Danger", glyph = "alert" },
        warning = { key = "Warning", glyph = "alert" },
    }
    local info = colors[kind] or colors.info

    local card = new("CanvasGroup", {
        Name = "Notification",
        AnchorPoint = Vector2.new(p.ax, p.ay),
        Size = UDim2.fromOffset(NotifyState.Width, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        GroupTransparency = 1,
        BackgroundColor3 = GUI.Palette.Surface,
        BackgroundTransparency = 0.02,
        BorderSizePixel = 0,
        Parent = parent,
    })
    corner(10, card)
    stroke(GUI.Palette.Border, 1, 0.3, card)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 12)
    pad.PaddingBottom = UDim.new(0, 12)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.Parent = card
    local vpad = new("Frame", {
        Position = UDim2.fromOffset(36, 0),
        Size = UDim2.new(1, -36, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = card,
    })
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 6)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = vpad
    new("Frame", {
        Name = "IconBox",
        Size = UDim2.fromOffset(26, 26),
        BackgroundColor3 = GUI.Palette[info.key],
        BackgroundTransparency = 0.86,
        BorderSizePixel = 0,
        Parent = card,
    })
    local titleLbl = new("TextLabel", {
        Text = tostring(title),
        TextSize = 13,
        FontFace = font(Enum.FontWeight.Bold),
        TextColor3 = GUI.Palette.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 15),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = vpad,
    })
    if text and text ~= "" then
        new("TextLabel", {
            Text = tostring(text),
            TextSize = 12,
            FontFace = font(Enum.FontWeight.Regular),
            TextColor3 = GUI.Palette.SubText,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = vpad,
        })
    end
    card.Position = UDim2.new(p.xs, p.hidden, p.ys, p.sign * (p.sign > 0 and (NotifyState.Edge + GuiService:GetGuiInset().Y) or NotifyState.Edge))

    local entry = { Card = card, Height = 64, Dismissing = false }
    table.insert(NotifyState.Active, 1, entry)
    task.defer(function()
        if not card.Parent then return end
        entry.Height = math.max(card.AbsoluteSize.Y, 1)
        notif_restack()
        tween(card, { GroupTransparency = 0 }, 0.3)
    end)
    local function dismiss()
        if entry.Dismissing or not card.Parent then return end
        entry.Dismissing = true
        for i, e in ipairs(NotifyState.Active) do
            if e == entry then table.remove(NotifyState.Active, i); break end
        end
        notif_restack()
        tween(card, { GroupTransparency = 1 }, 0.24)
        task.delay(0.3, function() card:Destroy() end)
    end
    entry.Dismiss = dismiss
    task.delay(duration, dismiss)
    return entry
end

notify_fn = function(title, text, success, duration)
    local kind = "info"
    if success == false then kind = "error"
    elseif success == true then kind = "success" end
    return notif_push(title, text, kind, duration or 4)
end

GUI.notify = notify_fn

-- ============================================================
-- COMPONENTS
-- ============================================================

local function option_root(parent, height, order)
    return new("Frame", {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, height),
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent,
    })
end

local function module_toggle(parent, opts, order)
    local order_ = order or 0
    local initial = false
    if opts.Flag then
        if GUI.State.Saved[opts.Flag] ~= nil then initial = GUI.State.Saved[opts.Flag] == true
        elseif opts.Default == true then initial = true end
    end

    local desc = opts.Description or opts.description
    local hasDesc = desc ~= nil and desc ~= ""
    local rowH = hasDesc and (is_mobile and 44 or 40) or (is_mobile and 36 or 30)

    local root = new("Frame", {
        Name = "Module",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = GUI.Palette.Surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = order_,
        Parent = parent,
    })
    corner(10, root)
    local rootStroke = stroke(GUI.Palette.Border, 1, 0.3, root)

    local header = new("TextButton", {
        Name = "Header",
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, rowH),
        BackgroundTransparency = 1,
        Parent = root,
    })

    local title = new("TextLabel", {
        Text = opts.Title or opts.title or "Module",
        TextSize = 13,
        FontFace = font(Enum.FontWeight.SemiBold),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Position = UDim2.new(0, 13, 0, hasDesc and 8 or 0),
        Size = UDim2.new(1, -70, 0, hasDesc and 15 or rowH),
        Parent = header,
    })

    if hasDesc then
        new("TextLabel", {
            Text = desc,
            TextSize = 11,
            FontFace = font(Enum.FontWeight.Regular),
            TextColor3 = GUI.Palette.Muted,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Position = UDim2.new(0, 13, 0, 24),
            Size = UDim2.new(1, -70, 0, 13),
            Parent = header,
        })
    end

    local body = new("Frame", {
        Name = "Body",
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = root,
    })
    local bodyInner = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = body,
    })
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 13)
    pad.PaddingLeft = UDim.new(0, 13)
    pad.PaddingRight = UDim.new(0, 13)
    pad.Parent = bodyInner
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 9)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = bodyInner

    local toggleFrame, toggleKnob

    if opts.Flag then
        toggleFrame = new("Frame", {
            Name = "Toggle",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -13, 0, hasDesc and 18 or rowH / 2),
            Size = UDim2.fromOffset(34, 18),
            BackgroundColor3 = GUI.Palette.SurfaceAlt,
            BackgroundTransparency = 0.45,
            BorderSizePixel = 0,
            Parent = header,
        })
        corner(UDim.new(1, 0), toggleFrame)
        stroke(GUI.Palette.Border, 1, 0.2, toggleFrame)
        toggleKnob = new("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 3, 0.5, 0),
            Size = UDim2.fromOffset(10, 10),
            BackgroundColor3 = GUI.Palette.Muted,
            BorderSizePixel = 0,
            Parent = toggleFrame,
        })
        corner(UDim.new(1, 0), toggleKnob)
    end

    local module = {
        Root = root, Header = header, Title = title, Body = body, BodyInner = bodyInner,
        Enabled = initial, Flag = opts.Flag,
        SetEnabled = nil, Get = function() return module.Enabled end,
    }

    function module:SetEnabled(enabled, silent, noExpand)
        enabled = enabled == true
        module.Enabled = enabled
        if opts.Flag then
            Flags[opts.Flag] = enabled
            GUI.State.Saved[opts.Flag] = enabled
        end
        if toggleFrame then
            tween(toggleFrame, {
                BackgroundColor3 = enabled and GUI.Palette.Accent or GUI.Palette.SurfaceAlt,
                BackgroundTransparency = enabled and 0.06 or 0.45,
            }, 0.26)
            tween(toggleKnob, {
                Position = enabled and UDim2.new(1, -13, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                BackgroundColor3 = enabled and GUI.Palette.Background or GUI.Palette.Muted,
            }, 0.32)
        end
        tween(rootStroke, { Color = enabled and GUI.Palette.Accent or GUI.Palette.Border, Transparency = enabled and 0.55 or 0.3 }, 0.2)
        tween(title, { TextColor3 = enabled and GUI.Palette.Text or GUI.Palette.SubText }, 0.2)
        local target = enabled and (#bodyInner:GetChildren() > 2) and module._measuredBodyHeight or 0
        if target == 0 then target = enabled and module._measuredBodyHeight or 0 end
        if silent ~= true then
            if target > 0 then
                tween(body, { Size = UDim2.new(1, 0, 0, target) }, 0.34)
            else
                tween(body, { Size = UDim2.new(1, 0, 0, 0) }, 0.34)
            end
        else
            body.Size = UDim2.new(1, 0, 0, target)
        end
        if not silent and opts.Callback then
            task.spawn(opts.Callback, enabled)
        end
    end

    task.defer(function()
        module._measuredBodyHeight = bodyInner.AbsoluteSize.Y + 23
    end)
    track_gui(bodyInner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        module._measuredBodyHeight = bodyInner.AbsoluteSize.Y + 23
        if module.Enabled then
            body.Size = UDim2.new(1, 0, 0, module._measuredBodyHeight)
        end
    end))

    track_gui(header.MouseButton1Click:Connect(function()
        if opts.Flag then
            module:SetEnabled(not module.Enabled)
        end
    end))

    task.defer(function() module:SetEnabled(initial, true) end)

    if initial and opts.Callback then
        task.spawn(opts.Callback, true)
    end

    return module
end

local Components = {}

function Components.Toggle(parent, opts, order)
    local flag = opts.Flag or opts.flag
    local initial = false
    if flag then
        if GUI.State.Saved[flag] ~= nil then initial = GUI.State.Saved[flag] == true
        elseif opts.Default == true then initial = true end
    end
    local root = option_root(parent, GUI.Layout.Row, order)
    local btn = new("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Parent = root,
    })
    local lbl = new("TextLabel", {
        Text = opts.Title or "Toggle",
        TextSize = 12,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -40, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = btn,
    })
    local sw = new("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(30, 16),
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = btn,
    })
    corner(UDim.new(1, 0), sw)
    stroke(GUI.Palette.Border, 1, 0.3, sw)
    local knob = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.fromOffset(10, 10),
        BackgroundColor3 = GUI.Palette.Muted,
        BorderSizePixel = 0,
        Parent = sw,
    })
    corner(UDim.new(1, 0), knob)

    local widget = { Type = "Toggle", Value = initial, Root = root, Flag = flag }
    function widget:Set(value, silent)
        value = value == true
        widget.Value = value
        if flag then Flags[flag] = value; GUI.State.Saved[flag] = value end
        tween(sw, { BackgroundColor3 = value and GUI.Palette.Accent or GUI.Palette.SurfaceAlt, BackgroundTransparency = value and 0.06 or 0.5 }, 0.24)
        tween(knob, { Position = value and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), BackgroundColor3 = value and GUI.Palette.Background or GUI.Palette.Muted }, 0.3)
        tween(lbl, { TextColor3 = value and GUI.Palette.Text or GUI.Palette.SubText }, 0.2)
        if not silent and opts.Callback then task.spawn(opts.Callback, value) end
    end
    function widget:Get() return widget.Value end
    track_gui(btn.MouseButton1Click:Connect(function()
        widget:Set(not widget.Value)
    end))
    widget:Set(initial, true)
    return widget
end

function Components.Slider(parent, opts, order)
    local flag = opts.Flag or opts.flag
    local min = opts.Min or opts.minimum_value or 0
    local max = opts.Max or opts.maximum_value or 100
    local decimals = opts.Decimals or opts.decimals or 0
    local suffix = opts.Suffix or opts.suffix or ""
    local initial = opts.Default or opts.value or min
    if flag and type(GUI.State.Saved[flag]) == "number" then initial = GUI.State.Saved[flag] end
    initial = clamp(tonumber(initial) or min, min, max)

    local root = option_root(parent, is_mobile and 38 or 32, order)
    local lbl = new("TextLabel", {
        Text = opts.Title or "Slider",
        TextSize = 12,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = root,
    })
    local valLbl = new("TextLabel", {
        Text = tostring(initial) .. suffix,
        TextSize = 13,
        FontFace = font(Enum.FontWeight.SemiBold),
        TextColor3 = GUI.Palette.Text,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Right,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.fromOffset(60, 20),
        Parent = root,
    })
    local track = new("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, 5),
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Parent = root,
    })
    corner(UDim.new(1, 0), track)
    local fill = new("Frame", {
        Size = UDim2.fromScale((initial - min) / math.max(max - min, 0.0001), 1),
        BackgroundColor3 = GUI.Palette.Accent,
        BorderSizePixel = 0,
        Parent = track,
    })
    corner(UDim.new(1, 0), fill)
    local knob = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(9, 9),
        BackgroundColor3 = GUI.Palette.AccentSoft,
        BorderSizePixel = 0,
        Parent = fill,
    })
    corner(UDim.new(1, 0), knob)
    local hit = new("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, is_mobile and 26 or 20),
        Parent = root,
    })
    local widget = { Type = "Slider", Value = initial, Root = root, Flag = flag }
    local active = false
    local function round(v)
        local m = 10 ^ decimals
        return math.floor(v * m + 0.5) / m
    end
    local function setFromPos(x)
        local xs = track.AbsoluteSize.X
        if xs < 1 then return end
        local t = clamp((x - track.AbsolutePosition.X) / xs, 0, 1)
        widget:Set(min + (max - min) * t)
    end
    function widget:Set(value, silent)
        value = clamp(round(tonumber(value) or min), min, max)
        widget.Value = value
        if flag then Flags[flag] = value; GUI.State.Saved[flag] = value end
        local t = (value - min) / math.max(max - min, 0.0001)
        valLbl.Text = tostring(value) .. suffix
        tween(fill, { Size = UDim2.fromScale(t, 1) }, 0.16)
        if not silent and opts.Callback then task.spawn(opts.Callback, value) end
    end
    function widget:Get() return widget.Value end
    widget.set_percentage = function(self, v, silent) widget:Set(v, silent) end
    track_gui(hit.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        active = true
        setFromPos(input.Position.X)
        local conn1
        local conn2
        conn1 = UserInputService.InputChanged:Connect(function(i)
            if not active then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                setFromPos(i.Position.X)
            end
        end)
        conn2 = UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                active = false
                if conn1 then conn1:Disconnect() end
                if conn2 then conn2:Disconnect() end
            end
        end)
    end))
    widget:Set(initial, true)
    return widget
end

function Components.Dropdown(parent, opts, order)
    local flag = opts.Flag or opts.flag
    local isMulti = opts.Multi == true or opts.multi_dropdown == true
    local options = opts.Options or opts.options or {}
    local maxVisible = opts.MaxVisible or opts.maximum_options or 6
    local value
    if isMulti then
        value = {}
        local def = opts.Default or opts.value
        if type(def) == "table" then
            for _, v in ipairs(def) do value[v] = true end
        elseif type(def) == "string" then
            value[def] = true
        end
    else
        value = opts.Default or opts.value or options[1]
    end
    if flag and GUI.State.Saved[flag] ~= nil then value = GUI.State.Saved[flag] end

    local root = new("Frame", {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent,
    })
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 5)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = root

    local head = new("Frame", {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Parent = root,
    })
    new("TextLabel", {
        Text = opts.Title or "Dropdown",
        TextSize = 12,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = head,
    })
    local openBtn = new("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, GUI.Layout.FieldH),
        Parent = root,
    })
    corner(7, openBtn)
    stroke(GUI.Palette.Border, 1, 0.25, openBtn)
    local pad2 = Instance.new("UIPadding")
    pad2.PaddingLeft = UDim.new(0, 10)
    pad2.PaddingRight = UDim.new(0, 10)
    pad2.Parent = openBtn
    local display = new("TextLabel", {
        Text = isMulti and "None" or tostring(value or "None"),
        TextSize = 12,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = openBtn,
    })
    local chev = new("TextLabel", {
        Text = "▼",
        TextSize = 10,
        FontFace = font(Enum.FontWeight.Bold),
        TextColor3 = GUI.Palette.Muted,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(12, 12),
        Parent = openBtn,
    })
    local panel = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = root,
    })
    local panelInner = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Parent = panel,
    })
    corner(7, panelInner)
    stroke(GUI.Palette.Border, 1, 0.3, panelInner)
    local pad3 = Instance.new("UIPadding")
    pad3.PaddingTop = UDim.new(0, 4)
    pad3.PaddingBottom = UDim.new(0, 4)
    pad3.PaddingLeft = UDim.new(0, 4)
    pad3.PaddingRight = UDim.new(0, 4)
    pad3.Parent = panelInner
    local optList = Instance.new("UIListLayout")
    optList.Padding = UDim.new(0, 2)
    optList.SortOrder = Enum.SortOrder.LayoutOrder
    optList.Parent = panelInner

    local open = false
    local entries = {}

    local widget = { Type = "Dropdown", Value = value, Options = options, Root = root, Flag = flag }

    local function refreshDisplay()
        if isMulti then
            local list_ = {}
            for _, o in ipairs(options) do if value[o] then table.insert(list_, o) end end
            display.Text = #list_ > 0 and table.concat(list_, ", ") or "None"
        else
            display.Text = value and tostring(value) or "None"
        end
        for opt, entry in pairs(entries) do
            local on = isMulti and value[opt] or (value == opt)
            tween(entry.text, { TextColor3 = on and GUI.Palette.Text or GUI.Palette.SubText }, 0.15)
            tween(entry.bg, { BackgroundTransparency = on and 0.86 or 1 }, 0.15)
        end
    end

    local function setOpen(v)
        open = v
        local count = math.min(#options, maxVisible)
        local h = count * GUI.Layout.OptionH + math.max(count - 1, 0) * 2 + 8
        tween(chev, { Rotation = v and 180 or 0 }, 0.24)
        tween(panel, { Size = UDim2.new(1, 0, 0, v and h or 0) }, 0.24)
        tween(openBtn, { BackgroundColor3 = v and GUI.Palette.Surface or GUI.Palette.SurfaceAlt }, 0.15)
    end

    function widget:SetOptions(newOptions)
        newOptions = newOptions or {}
        for _, e in pairs(entries) do e.bg:Destroy() end
        entries = {}
        widget.Options = newOptions
        options = newOptions
        for i, o in ipairs(newOptions) do
            local btn = new("TextButton", {
                Text = "",
                AutoButtonColor = false,
                BackgroundColor3 = GUI.Palette.Accent,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, GUI.Layout.OptionH),
                LayoutOrder = i,
                Parent = panelInner,
            })
            corner(5, btn)
            local txt = new("TextLabel", {
                Text = tostring(o),
                TextSize = 11.5,
                FontFace = font(Enum.FontWeight.Medium),
                TextColor3 = GUI.Palette.SubText,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.fromOffset(10, 0),
                TextTruncate = Enum.TextTruncate.AtEnd,
                Parent = btn,
            })
            entries[o] = { bg = btn, text = txt }
            track_gui(btn.MouseButton1Click:Connect(function()
                if isMulti then
                    local newVal = {}
                    for k in pairs(value) do newVal[k] = value[k] end
                    newVal[o] = not newVal[o] or nil
                    widget:Set(newVal)
                else
                    widget:Set(o)
                    setOpen(false)
                end
            end))
        end
        refreshDisplay()
    end

    function widget:Set(v, silent)
        if isMulti then
            local tbl = {}
            if type(v) == "table" then
                if #v > 0 then for _, x in ipairs(v) do tbl[x] = true end
                else for k, val in pairs(v) do if val then tbl[k] = true end end end
            elseif type(v) == "string" then
                tbl[v] = true
            end
            widget.Value = tbl
            value = tbl
        else
            widget.Value = v
            value = v
        end
        if flag then Flags[flag] = widget.Value; GUI.State.Saved[flag] = widget.Value end
        refreshDisplay()
        if not silent and opts.Callback then task.spawn(opts.Callback, widget.Value) end
    end

    function widget:Get() return widget.Value end

    track_gui(openBtn.MouseButton1Click:Connect(function()
        setOpen(not open)
    end))

    widget:SetOptions(options)
    widget:Set(value, true)
    return widget
end

function Components.Input(parent, opts, order)
    local flag = opts.Flag or opts.flag
    local initial = opts.Default or opts.value or ""
    if flag and type(GUI.State.Saved[flag]) == "string" then initial = GUI.State.Saved[flag] end

    local root = new("Frame", {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent,
    })
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 5)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = root
    if opts.Title and opts.Title ~= "" then
        new("TextLabel", {
            Text = opts.Title,
            TextSize = 12,
            FontFace = font(Enum.FontWeight.Medium),
            TextColor3 = GUI.Palette.SubText,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = root,
        })
    end
    local box = new("Frame", {
        Size = UDim2.new(1, 0, 0, GUI.Layout.FieldH - 2),
        BackgroundColor3 = GUI.Palette.Surface,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = root,
    })
    corner(8, box)
    local boxStroke = stroke(GUI.Palette.Border, 1, 0.25, box)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.Parent = box
    local textBox = new("TextBox", {
        Text = initial,
        PlaceholderText = opts.Placeholder or opts.placeholder or "",
        ClearTextOnFocus = false,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = Enum.TextTruncate.AtEnd,
        FontFace = font(Enum.FontWeight.Medium),
        TextSize = 12,
        TextColor3 = GUI.Palette.Text,
        PlaceholderColor3 = GUI.Palette.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = box,
    })

    local widget = { Type = "Input", Value = initial, Root = root, Flag = flag }
    function widget:Set(v, silent)
        v = tostring(v or "")
        widget.Value = v
        textBox.Text = v
        if flag then Flags[flag] = v; GUI.State.Saved[flag] = v end
        if not silent and opts.Callback then task.spawn(opts.Callback, v) end
    end
    function widget:Get() return widget.Value end
    track_gui(textBox.Focused:Connect(function()
        tween(boxStroke, { Color = GUI.Palette.Accent, Transparency = 0.35 }, 0.15)
    end))
    track_gui(textBox.FocusLost:Connect(function(enter)
        tween(boxStroke, { Color = GUI.Palette.Border, Transparency = 0.25 }, 0.15)
        widget:Set(textBox.Text)
    end))
    widget:Set(initial, true)
    return widget
end

function Components.Button(parent, opts, order)
    local root = option_root(parent, GUI.Layout.FieldH, order)
    local btn = new("TextButton", {
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Parent = root,
    })
    corner(7, btn)
    stroke(GUI.Palette.Border, 1, 0.25, btn)
    local lbl = new("TextLabel", {
        Text = opts.Title or "Button",
        TextSize = 12,
        FontFace = font(Enum.FontWeight.SemiBold),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = btn,
    })
    track_gui(btn.MouseEnter:Connect(function()
        tween(btn, { BackgroundTransparency = 0.1 }, 0.15)
        tween(lbl, { TextColor3 = GUI.Palette.Text }, 0.15)
    end))
    track_gui(btn.MouseLeave:Connect(function()
        tween(btn, { BackgroundTransparency = 0.35 }, 0.2)
        tween(lbl, { TextColor3 = GUI.Palette.SubText }, 0.2)
    end))
    track_gui(btn.MouseButton1Click:Connect(function()
        if opts.Callback then task.spawn(opts.Callback) end
    end))
    return { Type = "Button", Root = root, SetTitle = function(_, t) lbl.Text = t end }
end

function Components.Colorpicker(parent, opts, order)
    local flag = opts.Flag or opts.flag
    local initial = opts.Default or opts.value or Color3.fromRGB(255, 255, 255)
    if flag and typeof(GUI.State.Saved[flag]) == "Color3" then initial = GUI.State.Saved[flag] end
    local h, s, v = initial:ToHSV()

    local root = new("Frame", {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent,
    })
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 6)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = root

    local head = new("Frame", {
        Size = UDim2.new(1, 0, 0, GUI.Layout.Row),
        BackgroundTransparency = 1,
        Parent = root,
    })
    new("TextLabel", {
        Text = opts.Title or "Color",
        TextSize = 12,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -50, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = head,
    })
    local swatch = new("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(34, 18),
        BackgroundColor3 = initial,
        BorderSizePixel = 0,
        Parent = head,
    })
    corner(6, swatch)
    stroke(GUI.Palette.Border, 1, 0.35, swatch)

    local body = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = root,
    })
    local panel = new("Frame", {
        Size = UDim2.new(1, 0, 0, 158),
        BackgroundColor3 = GUI.Palette.SurfaceAlt,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Parent = body,
    })
    corner(8, panel)
    stroke(GUI.Palette.Border, 1, 0.25, panel)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.Parent = panel

    local sv = new("Frame", {
        Size = UDim2.new(1, 0, 0, 78),
        BackgroundColor3 = Color3.fromHSV(h, 1, 1),
        BorderSizePixel = 0,
        Parent = panel,
    })
    corner(6, sv)
    local gradW = new("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = sv,
    })
    corner(6, gradW)
    local gradWhite = Instance.new("UIGradient")
    gradWhite.Color = ColorSequence.new(Color3.new(1, 1, 1))
    gradWhite.Transparency = NumberSequence.new(0, 1)
    gradWhite.Parent = gradW
    local gradB = new("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = sv,
    })
    corner(6, gradB)
    local gradBlack = Instance.new("UIGradient")
    gradBlack.Rotation = 90
    gradBlack.Transparency = NumberSequence.new(1, 0)
    gradBlack.Parent = gradB
    local cursor = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(10, 10),
        BackgroundTransparency = 1,
        ZIndex = 3,
        Parent = sv,
    })
    corner(UDim.new(1, 0), cursor)
    stroke(Color3.new(1,1,1), 2, 0, cursor)

    local hueBar = new("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 84),
        Parent = panel,
    })
    corner(UDim.new(1, 0), hueBar)
    local hueGrad = Instance.new("UIGradient")
    hueGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,255,0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0,0,255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255,0,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0)),
    })
    hueGrad.Parent = hueBar
    local hueCursor = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(h, 0, 0.5, 0),
        Size = UDim2.fromOffset(8, 14),
        BackgroundColor3 = Color3.new(1,1,1),
        BorderSizePixel = 0,
        ZIndex = 2,
        Parent = hueBar,
    })
    corner(3, hueCursor)
    stroke(Color3.new(0,0,0), 1, 0.3, hueCursor)

    local hexBox = new("TextBox", {
        Text = string.format("#%02X%02X%02X", math.floor(initial.R*255+0.5), math.floor(initial.G*255+0.5), math.floor(initial.B*255+0.5)),
        TextSize = 11,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundColor3 = GUI.Palette.Surface,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ClearTextOnFocus = false,
        Position = UDim2.new(0, 0, 0, 104),
        Size = UDim2.new(1, 0, 0, 30),
        Parent = panel,
    })
    corner(6, hexBox)
    stroke(GUI.Palette.BorderSoft, 1, 0.3, hexBox)

    local widget = { Type = "Colorpicker", Value = initial, Root = root, Flag = flag, _open = false }

    local function updateColor(noCallback)
        local c = Color3.fromHSV(h, s, v)
        widget.Value = c
        swatch.BackgroundColor3 = c
        sv.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        cursor.Position = UDim2.new(s, 0, 1 - v, 0)
        hueCursor.Position = UDim2.new(h, 0, 0.5, 0)
        hexBox.Text = string.format("#%02X%02X%02X", math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5))
        if flag then Flags[flag] = c; GUI.State.Saved[flag] = c end
        if not noCallback and opts.Callback then task.spawn(opts.Callback, c) end
    end

    function widget:Set(c, silent)
        if typeof(c) ~= "Color3" then return end
        h, s, v = c:ToHSV()
        updateColor(silent == true)
    end
    function widget:Get() return widget.Value end

    local svActive, hueActive = false, false
    track_gui(sv.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        svActive = true
        local function upd(x, y)
            local xs, ys = sv.AbsoluteSize.X, sv.AbsoluteSize.Y
            if xs < 1 or ys < 1 then return end
            s = clamp((x - sv.AbsolutePosition.X) / xs, 0, 1)
            v = 1 - clamp((y - sv.AbsolutePosition.Y) / ys, 0, 1)
            updateColor(true)
        end
        upd(input.Position.X, input.Position.Y)
        local c1 = UserInputService.InputChanged:Connect(function(i)
            if not svActive then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                upd(i.Position.X, i.Position.Y)
            end
        end)
        local c2 = UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                svActive = false
                c1:Disconnect(); c2:Disconnect()
                updateColor()
            end
        end)
    end))
    track_gui(hueBar.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        hueActive = true
        local function upd(x)
            local xs = hueBar.AbsoluteSize.X
            if xs < 1 then return end
            h = clamp((x - hueBar.AbsolutePosition.X) / xs, 0, 1)
            updateColor(true)
        end
        upd(input.Position.X)
        local c1 = UserInputService.InputChanged:Connect(function(i)
            if not hueActive then return end
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                upd(i.Position.X)
            end
        end)
        local c2 = UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                hueActive = false
                c1:Disconnect(); c2:Disconnect()
                updateColor()
            end
        end)
    end))
    track_gui(hexBox.FocusLost:Connect(function()
        local hex = hexBox.Text:gsub("#", "")
        if #hex == 6 and tonumber(hex, 16) then
            widget:Set(Color3.fromHex(hex))
        else
            updateColor(true)
        end
    end))
    local function toggleOpen()
        widget._open = not widget._open
        tween(body, { Size = UDim2.new(1, 0, 0, widget._open and 158 or 0) }, 0.28)
    end
    track_gui(swatch:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() end))
    track_gui(head.InputBegan and head.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleOpen() end
    end) or nil)
    -- allow clicking on label
    local labelHit = new("TextButton", {
        Text = "", AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, GUI.Layout.Row),
        Parent = root,
    })
    track_gui(labelHit.MouseButton1Click:Connect(toggleOpen))

    updateColor(true)
    return widget
end

function Components.Paragraph(parent, opts, order)
    local root = new("Frame", {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = order or 0,
        Parent = parent,
    })
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 3)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = root
    if opts.Title and opts.Title ~= "" then
        new("TextLabel", {
            Text = opts.Title,
            TextSize = 13,
            FontFace = font(Enum.FontWeight.SemiBold),
            TextColor3 = GUI.Palette.Text,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = root,
        })
    end
    local textLbl = new("TextLabel", {
        Text = opts.Text or "",
        TextSize = 11.5,
        FontFace = font(Enum.FontWeight.Regular),
        TextColor3 = GUI.Palette.SubText,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = root,
    })
    return { Type = "Paragraph", Root = root, Set = function(_, t) textLbl.Text = t end }
end

function Components.Divider(parent, _, order)
    local root = option_root(parent, 9, order)
    local line = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = GUI.Palette.Border,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Parent = root,
    })
    return { Type = "Divider", Root = root }
end

-- ============================================================
-- MODULE (wrapping a group of widgets under a header)
-- ============================================================
local Module = {}

function Module.new(tab, opts)
    opts = opts or {}
    local m = module_toggle(tab.Left or tab.Right, opts, opts.Order or (#tab.Modules + 1))
    m._widgets = {}
    table.insert(tab.Modules, m)
    m._tab = tab
    m._opts = opts

    function m:Toggle(widgetOpts)
        return Components.Toggle(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Slider(widgetOpts)
        return Components.Slider(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Dropdown(widgetOpts)
        return Components.Dropdown(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Input(widgetOpts)
        return Components.Input(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Button(widgetOpts)
        return Components.Button(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Colorpicker(widgetOpts)
        return Components.Colorpicker(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Paragraph(widgetOpts)
        return Components.Paragraph(self.BodyInner, widgetOpts, (#self._widgets + 1))
    end
    function m:Divider(widgetOpts)
        return Components.Divider(self.BodyInner, widgetOpts or {}, (#self._widgets + 1))
    end
    return m
end

-- ============================================================
-- PAGE
-- ============================================================
local function create_page(parent)
    local page = new("CanvasGroup", {
        Name = "Page",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        Visible = false,
        Parent = parent,
    })
    local scroller = new("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageTransparency = 0.45,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = page,
    })
    theme_bind(scroller, "ScrollBarImageColor3", "Muted")
    local inner = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = scroller,
    })
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 14)
    pad.PaddingBottom = UDim.new(0, 20)
    pad.PaddingLeft = UDim.new(0, 24)
    pad.PaddingRight = UDim.new(0, 20)
    pad.Parent = inner
    local hl = Instance.new("UIListLayout")
    hl.Padding = UDim.new(0, 12)
    hl.FillDirection = Enum.FillDirection.Horizontal
    hl.SortOrder = Enum.SortOrder.LayoutOrder
    hl.Parent = inner

    local function column(order)
        return new("Frame", {
            Name = "Column",
            Size = UDim2.new(0.5, -6, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = order,
            Parent = inner,
        }, { (function()
            local l = Instance.new("UIListLayout")
            l.Padding = UDim.new(0, 10)
            l.SortOrder = Enum.SortOrder.LayoutOrder
            return l
        end)() })
    end

    return page, scroller, column(0), column(1)
end

-- ============================================================
-- TAB
-- ============================================================
local Tab = {}

function Tab.new(window, opts)
    local tab = {
        Window = window,
        Title = opts.Title or "Tab",
        Modules = {},
        Index = #window.Tabs + 1,
        Internal = opts.Internal == true,
    }
    local btn = new("TextButton", {
        Name = "Tab",
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, GUI.Layout.TabH),
        BackgroundTransparency = 1,
        ZIndex = 2,
        LayoutOrder = tab.Internal and 9999 or tab.Index,
        Parent = window.TabHolder,
    })
    tab.Button = btn
    local row = new("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Parent = btn,
    }, {
        (function()
            local l = Instance.new("UIListLayout")
            l.FillDirection = Enum.FillDirection.Horizontal
            l.Padding = UDim.new(0, 7)
            l.VerticalAlignment = Enum.VerticalAlignment.Center
            l.SortOrder = Enum.SortOrder.LayoutOrder
            return l
        end)(),
        (function()
            local p = Instance.new("UIPadding")
            p.PaddingLeft = UDim.new(0, 12)
            p.PaddingRight = UDim.new(0, 12)
            return p
        end)(),
    })
    local iconLbl
    if opts.Icon then
        iconLbl = new("TextLabel", {
            Text = "",
            TextSize = 14,
            FontFace = font(Enum.FontWeight.Medium),
            TextColor3 = GUI.Palette.SubText,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(15, 15),
            LayoutOrder = 1,
            Parent = row,
        })
    end
    local textLbl = new("TextLabel", {
        Text = tab.Title,
        TextSize = 12.5,
        FontFace = font(Enum.FontWeight.Medium),
        TextColor3 = GUI.Palette.SubText,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 1, 0),
        LayoutOrder = 2,
        Parent = row,
    })
    tab.Text = textLbl
    tab.Glyph = iconLbl

    local page, scroller, left, right = create_page(window.Content)
    tab.Page = page
    tab.Scroller = scroller
    tab.Left = left
    tab.Right = right

    function tab:Select(silent)
        if window.ActiveTab == tab then return end
        local prev = window.ActiveTab
        window.ActiveTab = tab
        if prev then
            tween(prev.Page, { GroupTransparency = 1 }, 0.2)
            task.delay(0.2, function()
                if window.ActiveTab ~= prev then prev.Page.Visible = false end
            end)
            tween(prev.Text, { TextColor3 = GUI.Palette.SubText }, 0.15)
        end
        page.Visible = true
        page.GroupTransparency = 1
        tween(page, { GroupTransparency = 0 }, 0.28)
        tween(textLbl, { TextColor3 = GUI.Palette.Text }, 0.2)
        if window.SlideIndicator then window:SlideIndicator(tab, not silent) end
    end

    track_gui(btn.MouseButton1Click:Connect(function() tab:Select() end))
    track_gui(btn.MouseEnter:Connect(function()
        if window.ActiveTab ~= tab then tween(textLbl, { TextColor3 = GUI.Palette.Text }, 0.15) end
    end))
    track_gui(btn.MouseLeave:Connect(function()
        if window.ActiveTab ~= tab then tween(textLbl, { TextColor3 = GUI.Palette.SubText }, 0.15) end
    end))

    table.insert(window.Tabs, tab)
    if not window.ActiveTab or window.ActiveTab.Internal then
        tab:Select(true)
    else
        page.Visible = false
    end
    return tab
end

-- ============================================================
-- WINDOW
-- ============================================================
local Window = {}

function Window.new(opts)
    opts = opts or {}
    local win = {
        Tabs = {},
        ActiveTab = nil,
        Open = true,
        ToggleKey = opts.ToggleKey or Enum.KeyCode.RightShift,
        _parked = {},
    }

    local screen = new("ScreenGui", {
        Name = "Zenthra",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        AutoLocalize = false,
        DisplayOrder = 9998,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = safe_parent(),
    })
    win.Screen = screen

    local layer = new("Frame", {
        Name = "Layer",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Parent = screen,
    })
    local uiscale = new("UIScale", { Scale = 1, Parent = layer })
    win.Scale = uiscale

    local function rescale()
        local vp = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
        local margin = is_mobile and 30 or 90
        uiscale.Scale = clamp(math.min(vp.X / (GUI.Layout.Width + margin), vp.Y / (GUI.Layout.Height + margin)), 0.4, 1)
    end
    rescale()
    if currentCamera then
        track_gui(currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale))
    end

    local holder = new("Frame", {
        Name = "Holder",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(GUI.Layout.Width, GUI.Layout.Height),
        BackgroundTransparency = 1,
        Visible = true,
        Parent = layer,
    }, {
        (function()
            local s = Instance.new("UIScale")
            s.Scale = 1
            return s
        end)(),
    })
    win.Holder = holder
    win.RootScale = holder:FindFirstChildOfClass("UIScale")

    local root = new("CanvasGroup", {
        Name = "Root",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = GUI.Palette.Background,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        GroupTransparency = 1,
        Parent = holder,
    })
    corner(13, root)
    theme_bind(root, "BackgroundColor3", "Background")
    local rootStroke = stroke(GUI.Palette.Border, 1, 0.35, root)
    theme_bind(rootStroke, "Color", "Border")
    win.Root = root

    local topbar = new("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, GUI.Layout.TopbarH),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 4,
        Parent = root,
    })
    local titleBox = new("Frame", {
        Position = UDim2.new(0, 18, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(0, 30),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Parent = topbar,
    }, {
        (function()
            local l = Instance.new("UIListLayout")
            l.FillDirection = Enum.FillDirection.Horizontal
            l.Padding = UDim.new(0, 7)
            l.VerticalAlignment = Enum.VerticalAlignment.Center
            l.SortOrder = Enum.SortOrder.LayoutOrder
            return l
        end)(),
    })
    new("TextLabel", {
        Text = opts.Title or "Zenthra",
        TextSize = 14,
        FontFace = font(Enum.FontWeight.Bold),
        TextColor3 = GUI.Palette.Text,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 16),
        LayoutOrder = 1,
        Parent = titleBox,
    })
    if opts.Subtitle then
        new("TextLabel", {
            Text = opts.Subtitle,
            TextSize = 11,
            FontFace = font(Enum.FontWeight.Regular),
            TextColor3 = GUI.Palette.Muted,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromOffset(0, 14),
            LayoutOrder = 2,
            Parent = titleBox,
        })
    end

    local function topbar_button(offset, glyph, colorKey)
        local b = new("TextButton", {
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -offset, 0.5, 0),
            Size = UDim2.fromOffset(26, 26),
            BackgroundColor3 = GUI.Palette.SurfaceAlt,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = topbar,
        })
        corner(8, b)
        theme_bind(b, "BackgroundColor3", "SurfaceAlt")
        local lbl = new("TextLabel", {
            Text = glyph,
            TextSize = 14,
            FontFace = font(Enum.FontWeight.Bold),
            TextColor3 = GUI.Palette.SubText,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Parent = b,
        })
        track_gui(b.MouseEnter:Connect(function()
            tween(b, { BackgroundTransparency = 0.25 }, 0.15)
            tween(lbl, { TextColor3 = colorKey and GUI.Palette[colorKey] or GUI.Palette.Text }, 0.15)
        end))
        track_gui(b.MouseLeave:Connect(function()
            tween(b, { BackgroundTransparency = 1 }, 0.2)
            tween(lbl, { TextColor3 = GUI.Palette.SubText }, 0.2)
        end))
        return b, lbl
    end

    local minBtn = topbar_button(14, "—")
    new("Frame", {
        Position = UDim2.new(0, 0, 0, GUI.Layout.TopbarH),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = GUI.Palette.Border,
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = root,
    })

    local sidebar = new("Frame", {
        Name = "Sidebar",
        Position = UDim2.new(0, 0, 0, GUI.Layout.TopbarH + 1),
        Size = UDim2.new(0, GUI.Layout.SidebarW, 1, -(GUI.Layout.TopbarH + 1)),
        BackgroundColor3 = GUI.Palette.Surface,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = root,
    })
    theme_bind(sidebar, "BackgroundColor3", "Surface")
    win.Sidebar = sidebar

    local tabScroll = new("ScrollingFrame", {
        Position = UDim2.new(0, 12, 0, 12),
        Size = UDim2.new(1, -24, 1, -24),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = sidebar,
    })
    local indicator = new("Frame", {
        Name = "Indicator",
        Size = UDim2.new(1, -GUI.Layout.TabPad * 2, 0, GUI.Layout.TabH),
        BackgroundColor3 = GUI.Palette.Accent,
        BackgroundTransparency = 0.67,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 1,
        Parent = tabScroll,
    })
    corner(7, indicator)
    theme_bind(indicator, "BackgroundColor3", "Accent")
    win.Indicator = indicator

    local tabHolder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Parent = tabScroll,
    }, {
        (function()
            local l = Instance.new("UIListLayout")
            l.Padding = UDim.new(0, GUI.Layout.TabGap)
            l.SortOrder = Enum.SortOrder.LayoutOrder
            return l
        end)(),
        (function()
            local p = Instance.new("UIPadding")
            p.PaddingTop = UDim.new(0, GUI.Layout.TabPad)
            p.PaddingLeft = UDim.new(0, GUI.Layout.TabPad)
            p.PaddingRight = UDim.new(0, GUI.Layout.TabPad)
            return p
        end)(),
    })
    win.TabHolder = tabHolder
    win.TabScroll = tabScroll

    local content = new("Frame", {
        Name = "Content",
        Position = UDim2.new(0, GUI.Layout.SidebarW + 1, 0, GUI.Layout.TopbarH + 1),
        Size = UDim2.new(1, -(GUI.Layout.SidebarW + 1), 1, -(GUI.Layout.TopbarH + 1)),
        BackgroundTransparency = 1,
        ZIndex = 4,
        Parent = root,
    })
    win.Content = content

    function win:SlideIndicator(target, animated)
        if not indicator then return end
        local order = {}
        for _, t in ipairs(self.Tabs) do table.insert(order, t) end
        table.sort(order, function(a, b) return a.Button.LayoutOrder < b.Button.LayoutOrder end)
        local y = GUI.Layout.TabPad
        for _, t in ipairs(order) do
            if t == target then break end
            y += GUI.Layout.TabH + GUI.Layout.TabGap
        end
        indicator.Visible = true
        indicator.Size = UDim2.new(1, -(GUI.Layout.TabPad * 2), 0, GUI.Layout.TabH)
        if animated then
            tween(indicator, { Position = UDim2.fromOffset(GUI.Layout.TabPad, y) }, GUI.Layout.TabIndicatorSlide)
        else
            indicator.Position = UDim2.fromOffset(GUI.Layout.TabPad, y)
        end
    end

    local dragging = false
    local dragStartPos, dragStart
    track_gui(topbar.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        dragging = true
        dragStartPos = input.Position
        dragStart = holder.Position
    end))
    track_gui(UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local d = input.Position - dragStartPos
        holder.Position = UDim2.new(dragStart.X.Scale, dragStart.X.Offset + d.X / uiscale.Scale, dragStart.Y.Scale, dragStart.Y.Offset + d.Y / uiscale.Scale)
    end))
    track_gui(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))

    function win:SetVisible(v)
        v = v == true
        self.Open = v
        if v then
            screen.Enabled = true
            holder.Visible = true
            self.RootScale.Scale = 0.78
            root.GroupTransparency = 1
            tween(self.RootScale, { Scale = 0.94 }, 0.36)
            tween(root, { GroupTransparency = 0 }, 0.26)
        else
            tween(self.RootScale, { Scale = 0.86 }, 0.22, GUI.Layout.Ease, GUI.Layout.EaseIn)
            tween(root, { GroupTransparency = 1 }, 0.2, GUI.Layout.Ease, GUI.Layout.EaseIn)
            task.delay(0.22, function()
                if not self.Open then
                    holder.Visible = false
                    screen.Enabled = false
                end
            end)
        end
    end

    track_gui(minBtn.MouseButton1Click:Connect(function() win:SetVisible(false) end))

    function win:Toggle()
        self:SetVisible(not self.Open)
    end

    function win:Tab(opts2)
        return Tab.new(self, opts2 or {})
    end

    track_gui(UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == self.ToggleKey then win:Toggle() end
    end))

    task.defer(function() win:SetVisible(true) end)

    table.insert(_G.__ZenthraWindows or {}, win)
    _G.__ZenthraWindows = _G.__ZenthraWindows or {}
    table.insert(_G.__ZenthraWindows, win)

    return win
end

-- ============================================================
-- BUILD THE UI
-- ============================================================
local win = Window.new({
    Title = "Zenthra",
    Subtitle = "Blade Ball",
    ToggleKey = Enum.KeyCode.RightShift,
})

local Combat    = win:Tab({ Title = "Combat", Icon = "sword" })
local Detections= win:Tab({ Title = "Detections", Icon = "shield" })
local Visuals   = win:Tab({ Title = "Visuals", Icon = "eye" })
local PlayerT   = win:Tab({ Title = "Player", Icon = "user" })
local SwordT    = win:Tab({ Title = "Sword", Icon = "package" })
local AvatarT   = win:Tab({ Title = "Avatar", Icon = "users" })
local WorldT    = win:Tab({ Title = "World", Icon = "globe" })
local BlatantT  = win:Tab({ Title = "Blatant", Icon = "skull" })
local MiscT     = win:Tab({ Title = "Misc", Icon = "settings" })
local GuiT      = win:Tab({ Title = "Gui", Icon = "settings", Internal = false })

-- ============================================================
-- COMBAT
-- ============================================================
local autoParryMod = Module.new(Combat, {
    Title = "Auto Parry",
    Description = "automatic ball deflection",
    Flag = "auto_parry",
    Callback = function(v)
        Z.config.auto_parry = v
        if v then
            task.defer(Z.warm_direct)
        else
            if Z.state.parry_multi_active then Z.parry.multi_ball_finish() end
            if Z.state.parry_busy then
                Z.state.parry_busy = false
                Z.state.parry_busy_entry = nil
                Z.state.parry_busy_targets = nil
            end
        end
    end,
})

local _bdConfirm = false
autoParryMod:Toggle({
    Title = "Backward Detection",
    Flag = "backward_detection",
    BeforeChange = function(v)
        if not v or _bdConfirm then _bdConfirm = false; return true end
        _bdConfirm = true
        notify("Backward Detection - Beta", "Still in beta and may cause deaths. Click the toggle again to confirm and enable.", "warning", 8)
        return false
    end,
    Callback = function(v)
        Z.config.backward_detection = v
    end,
})

local accuracySlider
accuracySlider = autoParryMod:Slider({
    Title = "Accuracy",
    Flag = "parry_accuracy",
    Default = 75,
    Min = 1,
    Max = 100,
    Decimals = 0,
    Callback = function(v)
        Z.config.accuracy = v
    end,
})

autoParryMod:Slider({
    Title = "Parry Distance Multiplier",
    Flag = "parry_distance_multiplier",
    Default = 1,
    Min = 0.1,
    Max = 10,
    Decimals = 1,
    Callback = function(v)
        Z.config.parry_distance_multiplier = clamp(tonumber(v) or 1, 0.1, 10)
    end,
})

autoParryMod:Toggle({
    Title = "Randomize Accuracy",
    Flag = "randomize_accuracy",
    Callback = function(v)
        Z.config.randomize_accuracy = v
    end,
})

autoParryMod:Slider({
    Title = "Random Min",
    Flag = "random_min",
    Default = 25,
    Min = 1,
    Max = 100,
    Callback = function(v) Z.config.random_accuracy_min = v end,
})
autoParryMod:Slider({
    Title = "Random Max",
    Flag = "random_max",
    Default = 85,
    Min = 1,
    Max = 100,
    Callback = function(v) Z.config.random_accuracy_max = v end,
})

autoParryMod:Dropdown({
    Title = "Parry Mode",
    Flag = "parry_mode",
    Options = is_mobile and { "Remote", "Keypress" } or { "Remote", "Keypress", "Mouse Click" },
    Default = "Remote",
    MaxVisible = 4,
    Callback = function(v)
        Z.config.parry_mode = v
        if v == "Remote" then
            task.defer(function()
                Z.warm_direct()
            end)
        end
    end,
})

autoParryMod:Divider({})
autoParryMod:Toggle({
    Title = "Kill Pre Click",
    Flag = "kill_pre_click",
    Callback = function(v) Z.config.kill_pre_click = v end,
})
autoParryMod:Slider({
    Title = "Pre Click Range",
    Flag = "kill_pre_click_range",
    Default = 30,
    Min = 5,
    Max = 100,
    Callback = function(v) Z.config.kill_pre_click_range = v end,
})
autoParryMod:Slider({
    Title = "Pre Click Ball Speed",
    Flag = "kill_pre_click_speed",
    Default = 1,
    Min = 1,
    Max = 1000,
    Callback = function(v) Z.config.kill_pre_click_speed = v end,
})

autoParryMod:Divider({})
autoParryMod:Toggle({
    Title = "Show Aim Target",
    Flag = "show_aim_target",
    Callback = function(v)
        Z.config.show_aim_target = v
        if v then Z.aim_target.start() else Z.aim_target.stop() end
    end,
})
autoParryMod:Toggle({
    Title = "Aim Highlight",
    Flag = "aim_target_highlight",
    Callback = function(v) Z.config.aim_target_highlight = v end,
})
autoParryMod:Colorpicker({
    Title = "Aim Highlight Color",
    Flag = "aim_target_highlight_color",
    Default = Color3.fromRGB(0, 255, 127),
    Callback = function(c)
        Z.config.aim_target_highlight_color = c
        Z.visual.apply_highlight_color(Z.aim_target, c)
    end,
})
autoParryMod:Toggle({
    Title = "Aim Text",
    Flag = "aim_target_text",
    Callback = function(v) Z.config.aim_target_text = v end,
})
autoParryMod:Colorpicker({
    Title = "Aim Text Color",
    Flag = "aim_target_text_color",
    Default = Color3.fromRGB(0, 255, 127),
    Callback = function(c)
        Z.config.aim_target_text_color = c
        if Z.aim_target.text_draw then Z.aim_target.text_draw.Color = c end
    end,
})

autoParryMod:Divider({})
autoParryMod:Dropdown({
    Title = "Curve Mode",
    Flag = "curve_mode",
    Options = { "Camera", "Random", "Accelerated", "Back", "Down", "Up", "Dot" },
    Default = "Random",
    MaxVisible = 7,
    Callback = function(v)
        for i, name in ipairs({ "Camera", "Random", "Accelerated", "Back", "Down", "Up", "Dot" }) do
            if name == v then Z.config.curve_mode = i; break end
        end
    end,
})
autoParryMod:Dropdown({
    Title = "Target Mode",
    Flag = "target_mode",
    Options = { "None", "Farthest", "Closest", "Random" },
    Default = "Closest",
    MaxVisible = 4,
    Callback = function(v)
        for i, name in ipairs({ "None", "Farthest", "Closest", "Random" }) do
            if name == v then Z.config.target_mode = i; break end
        end
    end,
})

local targetPlayerMod = Module.new(Combat, {
    Title = "Target Player",
    Description = "locks onto the player closest to your aim",
    Flag = "target_player_enabled",
    Callback = function(v)
        Z.config.target_player_enabled = v
        if v then
            Z.target_player.lock()
            Z.target_player.start()
        else
            Z.config.target_player_name = nil
            Z.target_player.stop()
        end
    end,
})
targetPlayerMod:Toggle({
    Title = "Highlight Target",
    Flag = "target_player_highlight",
    Callback = function(v)
        Z.config.target_player_highlight = v
        if not v then Z.visual.clear_highlight(Z.target_player) end
    end,
})
targetPlayerMod:Colorpicker({
    Title = "Highlight Color",
    Flag = "target_player_highlight_color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(c)
        Z.config.target_player_highlight_color = c
        Z.visual.apply_highlight_color(Z.target_player, c)
    end,
})
targetPlayerMod:Toggle({
    Title = "Target Text",
    Flag = "target_player_text",
    Default = true,
    Callback = function(v) Z.config.target_player_text = v end,
})
targetPlayerMod:Slider({
    Title = "Target Text Size",
    Flag = "target_player_text_size",
    Default = 18,
    Min = 8,
    Max = 36,
    Callback = function(v) Z.config.target_player_text_size = v end,
})
targetPlayerMod:Colorpicker({
    Title = "Target Text Color",
    Flag = "target_player_text_color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(c)
        Z.config.target_player_text_color = c
        if Z.target_player.text_draw then Z.target_player.text_draw.Color = c end
    end,
})
targetPlayerMod:Toggle({
    Title = "Follow Target",
    Flag = "target_player_follow",
    Callback = function(v) Z.config.target_player_follow = v end,
})

Module.new(Combat, {
    Title = "Triggerbot",
    Description = "fires when the ball targets you",
    Flag = "triggerbot",
    Callback = function(v) Z.triggerbot.set(v) end,
}):Slider({
    Title = "Triggerbot Speed (ms)",
    Flag = "triggerbot_delay",
    Default = 0,
    Min = 0,
    Max = 500,
    Callback = function(v) Z.config.triggerbot_delay = v end,
})

local spamMod = Module.new(Combat, {
    Title = "Manual Spam",
    Description = "continuously fires the parry remote",
    Flag = "manual_spam",
    Callback = function(v)
        if v then Z.spam.manual_start() else Z.spam.manual_stop() end
    end,
})
spamMod:Dropdown({
    Title = "Spam Mode",
    Flag = "manual_spam_mode",
    Options = is_mobile and { "Remote", "Keypress" } or { "Remote", "Keypress", "Mouse Click" },
    Default = "Remote",
    Callback = function(v) Z.spam.manual_mode = v end,
})
spamMod:Toggle({
    Title = "Animation Fix",
    Flag = "manual_spam_anim_fix",
    Callback = function(v) Z.spam.animation_fix_manual = v end,
})

local autoSpamMod = Module.new(Combat, {
    Title = "Auto Spam",
    Description = "spams based on ball proximity",
    Flag = "auto_spam",
    Callback = function(v)
        if v then Z.spam.auto_start() else Z.spam.auto_stop() end
    end,
})
autoSpamMod:Dropdown({
    Title = "Spam Mode",
    Flag = "auto_spam_mode",
    Options = is_mobile and { "Remote", "Keypress" } or { "Remote", "Keypress", "Mouse Click" },
    Default = "Remote",
    Callback = function(v) Z.spam.auto_mode = v end,
})
autoSpamMod:Slider({
    Title = "Parry Threshold",
    Flag = "spam_threshold",
    Default = 1.5,
    Min = 1,
    Max = 5,
    Decimals = 1,
    Callback = function(v) Z.spam.threshold = v end,
})
autoSpamMod:Slider({
    Title = "Sensitivity",
    Flag = "spam_sensitivity",
    Default = 1,
    Min = 0,
    Max = 3,
    Decimals = 2,
    Callback = function(v) Z.spam.sensitivity_multiplier = v end,
})
autoSpamMod:Toggle({
    Title = "Animation Fix",
    Flag = "auto_spam_anim_fix",
    Callback = function(v) Z.spam.animation_fix_auto = v end,
})

-- ============================================================
-- DETECTIONS
-- ============================================================
Module.new(Detections, {
    Title = "Infinity Detection",
    Description = "ignore infinity ball",
    Flag = "detect_infinity",
    Callback = function(v) Z.detections.infinity = v end,
})
Module.new(Detections, {
    Title = "Death Slash Detection",
    Description = "ignore death slash ball",
    Flag = "detect_deathslash",
    Callback = function(v) Z.detections.deathslash = v end,
})
local soFuryMod = Module.new(Detections, {
    Title = "Slashes of Fury Detection",
    Description = "ignore slashes of fury ability",
    Flag = "detect_slashesoffury",
    Callback = function(v) Z.detections.slashesoffury = v end,
})
soFuryMod:Slider({
    Title = "Max Parries",
    Flag = "slashesoffury_max_parries",
    Default = 36,
    Min = 1,
    Max = 36,
    Callback = function(v) Z.slashesoffury_detection = { max_parries = v, parry_delay = 0.05 } end,
})
Module.new(Detections, {
    Title = "Forcefield Detection",
    Description = "ignore forcefield ability",
    Flag = "detect_forcefield",
    Callback = function(v) Z.detections.forcefield = v end,
})
Module.new(Detections, {
    Title = "Time Hole Detection",
    Description = "ignore time hole ability",
    Flag = "detect_timehole",
    Callback = function(v) Z.detections.timehole = v end,
})

-- ============================================================
-- VISUALS
-- ============================================================
local trailMod = Module.new(Visuals, {
    Title = "Ball Trail",
    Description = "neon trails on the ball",
    Flag = "ball_trail",
    Callback = function(v)
        if v then Z.ball_trail.start() else Z.ball_trail.stop() end
    end,
})
trailMod:Slider({
    Title = "Trail Count",
    Flag = "ball_trail_count",
    Default = 8,
    Min = 1,
    Max = 16,
    Callback = function(v)
        Z.ball_trail.num_trails = v
        if Z.ball_trail.active then
            local b = Z.ball_trail.get_ball()
            if b then Z.ball_trail.detach(); Z.ball_trail.attach(b) end
        end
    end,
})
trailMod:Colorpicker({
    Title = "Trail Color",
    Flag = "ball_trail_color",
    Default = Color3.fromRGB(0, 255, 200),
    Callback = function(c) Z.ball_trail.update_color(c) end,
})

Module.new(Visuals, {
    Title = "Parry Visualizer",
    Description = "shows a ring at your parry range",
    Flag = "parry_visualizer",
    Callback = function(v)
        if v then Z.parry_visualizer.start() else Z.parry_visualizer.stop() end
    end,
}):Colorpicker({
    Title = "Ring Color",
    Flag = "parry_visualizer_color",
    Default = Color3.fromRGB(0, 200, 255),
    Callback = function(c) Z.parry_visualizer.update_color(c) end,
})

local espMod = Module.new(Visuals, {
    Title = "Ability ESP",
    Description = "shows equipped abilities over players",
    Flag = "ability_esp",
    Callback = function(v)
        if v then Z.ability_esp.start() else Z.ability_esp.stop() end
    end,
})
espMod:Dropdown({
    Title = "Display Mode",
    Flag = "esp_display_mode",
    Options = { "Text", "Image" },
    Default = "Text",
    Callback = function(v) Z.ability_esp.mode = v end,
})
espMod:Toggle({
    Title = "Show Name",
    Flag = "esp_show_name",
    Callback = function(v) Z.ability_esp.show_name = v end,
})
espMod:Dropdown({
    Title = "Name Type",
    Flag = "esp_name_mode",
    Options = { "Display Name", "Username" },
    Default = "Display Name",
    Callback = function(v) Z.ability_esp.name_mode = v end,
})
espMod:Slider({
    Title = "Name Size",
    Flag = "esp_name_size",
    Default = 18,
    Min = 8,
    Max = 30,
    Callback = function(v) Z.ability_esp.name_size = v end,
})
espMod:Colorpicker({
    Title = "Name Color",
    Flag = "esp_name_color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) Z.ability_esp.name_color = c end,
})
espMod:Slider({
    Title = "Ability Size",
    Flag = "esp_ability_size",
    Default = 16,
    Min = 8,
    Max = 36,
    Callback = function(v) Z.ability_esp.ability_size = v end,
})
espMod:Colorpicker({
    Title = "Ability Color",
    Flag = "esp_ability_color",
    Default = Color3.fromRGB(120, 200, 255),
    Callback = function(c) Z.ability_esp.ability_color = c end,
})
espMod:Toggle({
    Title = "Show Cooldown",
    Flag = "esp_show_cd",
    Callback = function(v) Z.ability_esp.show_cd = v end,
})
espMod:Colorpicker({
    Title = "Cooldown Color",
    Flag = "esp_cd_color",
    Default = Color3.fromRGB(180, 180, 180),
    Callback = function(c) Z.ability_esp.cd_color = c end,
})
espMod:Toggle({
    Title = "Show Active Timer",
    Flag = "esp_show_timer",
    Callback = function(v) Z.ability_esp.show_timer = v end,
})
espMod:Colorpicker({
    Title = "Active Timer Color",
    Flag = "esp_active_color",
    Default = Color3.fromRGB(255, 200, 80),
    Callback = function(c) Z.ability_esp.active_color = c end,
})

Module.new(Visuals, {
    Title = "Ball Indicator",
    Description = "on-screen arrow towards the ball",
    Flag = "ball_indicator",
    Callback = function(v)
        if v then Z.ball_indicator.start() else Z.ball_indicator.stop() end
    end,
})

Module.new(Visuals, {
    Title = "No Render",
    Description = "disables client effects",
    Flag = "no_render",
    Callback = function(v)
        if v then Z.no_render.start() else Z.no_render.stop() end
    end,
})

-- ============================================================
-- PLAYER
-- ============================================================
local fovMod = Module.new(PlayerT, {
    Title = "Field of View",
    Description = "change camera FOV",
    Flag = "fov",
    Callback = function(v) Z.player_mods.set_fov(v, nil) end,
})
fovMod:Slider({
    Title = "FOV",
    Flag = "fov_value",
    Default = 70,
    Min = 40,
    Max = 120,
    Callback = function(v)
        Z.player_mods.fov = v
        if Z.player_mods.fov_enabled then currentCamera.FieldOfView = v end
    end,
})

local speedMod = Module.new(PlayerT, {
    Title = "Speed",
    Description = "change walk speed",
    Flag = "speed",
    Callback = function(v) Z.player_mods.set_speed(v, nil) end,
})
speedMod:Slider({
    Title = "Walk Speed",
    Flag = "speed_value",
    Default = 16,
    Min = 1,
    Max = 200,
    Callback = function(v)
        Z.player_mods.speed = v
        if Z.player_mods.speed_enabled then
            local c = localPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = v end
        end
    end,
})

local gravMod = Module.new(PlayerT, {
    Title = "Gravity",
    Description = "change workspace gravity",
    Flag = "gravity",
    Callback = function(v) Z.player_mods.set_gravity(v, nil) end,
})
gravMod:Slider({
    Title = "Gravity",
    Flag = "gravity_value",
    Default = 196,
    Min = 0,
    Max = 500,
    Callback = function(v)
        Z.player_mods.gravity = v
        if Z.player_mods.gravity_enabled then Workspace.Gravity = v end
    end,
})

local jumpMod = Module.new(PlayerT, {
    Title = "Jump Power",
    Description = "change humanoid jump power",
    Flag = "jump_power",
    Callback = function(v) Z.player_mods.set_jump_power(v, nil) end,
})
jumpMod:Slider({
    Title = "Jump Power",
    Flag = "jump_power_value",
    Default = 50,
    Min = 0,
    Max = 300,
    Callback = function(v)
        Z.player_mods.jump_power = v
        if Z.player_mods.jump_power_enabled then
            local c = localPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then
                if h.UseJumpPower then h.JumpPower = v else h.JumpHeight = v / 5 end
            end
        end
    end,
})

Module.new(PlayerT, {
    Title = "Infinite Jump",
    Description = "jump in mid-air",
    Flag = "infinite_jump",
    Callback = function(v) Z.player_mods.set_infinite_jump(v) end,
})

-- ============================================================
-- SWORD
-- ============================================================
local swordMatMod = Module.new(SwordT, {
    Title = "Sword Material",
    Description = "change your sword material / color",
    Flag = "sword_material",
    Callback = function(v)
        if v then Z.sword_material.start() else Z.sword_material.stop() end
    end,
})
swordMatMod:Toggle({
    Title = "Material Changer",
    Flag = "sword_material_apply",
    Default = true,
    Callback = function(v)
        Z.sword_material.material_enabled = v
        if Z.sword_material.enabled then Z.sword_material.schedule_reapply() end
    end,
})
swordMatMod:Dropdown({
    Title = "Material",
    Flag = "sword_material_type",
    Options = { "Default", "ForceField", "Glass", "Neon", "Ice", "Metal", "DiamondPlate", "Granite", "Marble", "Wood", "Foil", "SmoothPlastic" },
    Default = "ForceField",
    MaxVisible = 8,
    Callback = function(v)
        Z.sword_material.material = v
        if Z.sword_material.enabled then Z.sword_material.schedule_reapply() end
    end,
})
swordMatMod:Toggle({
    Title = "Color Changer",
    Flag = "sword_color_apply",
    Callback = function(v)
        Z.sword_material.color_enabled = v
        if Z.sword_material.enabled then Z.sword_material.schedule_reapply() end
    end,
})
swordMatMod:Colorpicker({
    Title = "Sword Color",
    Flag = "sword_color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c)
        Z.sword_material.custom_color = c
        if Z.sword_material.enabled and Z.sword_material.apply_all then
            Z.sword_material.schedule_reapply()
        end
    end,
})

-- ============================================================
-- AVATAR
-- ============================================================
local avatarMatMod = Module.new(AvatarT, {
    Title = "Avatar Material",
    Description = "change your avatar's material / color",
    Flag = "avatar_material",
    Callback = function(v)
        if v then Z.avatar_material.start() else Z.avatar_material.stop() end
    end,
})
avatarMatMod:Toggle({
    Title = "Material Changer",
    Flag = "avatar_material_apply",
    Default = true,
    Callback = function(v)
        Z.avatar_material.material_enabled = v
        if Z.avatar_material.enabled then Z.avatar_material.schedule_reapply() end
    end,
})
avatarMatMod:Dropdown({
    Title = "Material",
    Flag = "avatar_material_type",
    Options = { "Default", "ForceField", "Glass", "Neon", "Ice", "Metal", "DiamondPlate", "Granite", "Marble", "Wood", "Foil", "SmoothPlastic" },
    Default = "ForceField",
    MaxVisible = 8,
    Callback = function(v)
        Z.avatar_material.material = v
        if Z.avatar_material.enabled then Z.avatar_material.schedule_reapply() end
    end,
})
avatarMatMod:Toggle({
    Title = "Color Changer",
    Flag = "avatar_color_apply",
    Callback = function(v)
        Z.avatar_material.color_enabled = v
        if Z.avatar_material.enabled then Z.avatar_material.schedule_reapply() end
    end,
})
avatarMatMod:Colorpicker({
    Title = "Avatar Color",
    Flag = "avatar_color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c)
        Z.avatar_material.custom_color = c
        if Z.avatar_material.enabled then Z.avatar_material.schedule_reapply() end
    end,
})

Module.new(AvatarT, {
    Title = "Korblox",
    Description = "replaces right leg with korblox mesh",
    Flag = "korblox",
    Callback = function(v) Z.avatar.set_korblox(v) end,
})
Module.new(AvatarT, {
    Title = "Headless",
    Description = "makes head invisible",
    Flag = "headless",
    Callback = function(v) Z.avatar.set_headless(v) end,
})

-- ============================================================
-- WORLD
-- ============================================================
local wcMod = Module.new(WorldT, {
    Title = "World Customizer",
    Description = "customize lighting, color and effects",
    Flag = "world_customizer",
    Callback = function(v)
        if v then WC.start() else WC.stop() end
    end,
})
wcMod:Toggle({ Title = "Saturation", Flag = "wc_saturation", Callback = function(v) WC.on_toggle("saturation", v) end })
wcMod:Slider({ Title = "Saturation Amount", Flag = "wc_saturation_amount", Default = 0, Min = -1, Max = 1, Decimals = 2, Callback = function() WC.on_value("saturation") end })
wcMod:Toggle({ Title = "Brightness", Flag = "wc_brightness", Callback = function(v) WC.on_toggle("brightness", v) end })
wcMod:Slider({ Title = "Brightness Amount", Flag = "wc_brightness_amount", Default = 0, Min = -1, Max = 1, Decimals = 2, Callback = function() WC.on_value("brightness") end })
wcMod:Toggle({ Title = "Contrast", Flag = "wc_contrast", Callback = function(v) WC.on_toggle("contrast", v) end })
wcMod:Slider({ Title = "Contrast Amount", Flag = "wc_contrast_amount", Default = 0, Min = -1, Max = 1, Decimals = 2, Callback = function() WC.on_value("contrast") end })
wcMod:Toggle({ Title = "Tint", Flag = "wc_tint", Callback = function(v) WC.on_toggle("tint", v) end })
wcMod:Colorpicker({ Title = "Tint Color", Flag = "wc_tint_color", Default = Color3.new(1,1,1), Callback = function() WC.on_value("tint") end })
wcMod:Toggle({ Title = "Clock Time", Flag = "wc_clock_time", Callback = function(v) WC.on_toggle("clock_time", v) end })
wcMod:Slider({ Title = "Time (Hours)", Flag = "wc_clock_time_amount", Default = 14, Min = 0, Max = 24, Decimals = 1, Callback = function() WC.on_value("clock_time") end })
wcMod:Toggle({ Title = "Ambient", Flag = "wc_ambient", Callback = function(v) WC.on_toggle("ambient", v) end })
wcMod:Colorpicker({ Title = "Ambient Color", Flag = "wc_ambient_color", Default = Color3.fromRGB(128,128,128), Callback = function() WC.on_value("ambient") end })
wcMod:Toggle({ Title = "Outdoor Ambient", Flag = "wc_outdoor_ambient", Callback = function(v) WC.on_toggle("outdoor_ambient", v) end })
wcMod:Colorpicker({ Title = "Outdoor Ambient Color", Flag = "wc_outdoor_ambient_color", Default = Color3.fromRGB(128,128,128), Callback = function() WC.on_value("outdoor_ambient") end })
wcMod:Toggle({ Title = "Light Brightness", Flag = "wc_light_brightness", Callback = function(v) WC.on_toggle("light_brightness", v) end })
wcMod:Slider({ Title = "Brightness Level", Flag = "wc_light_brightness_amount", Default = 2, Min = 0, Max = 10, Decimals = 1, Callback = function() WC.on_value("light_brightness") end })
wcMod:Toggle({ Title = "Exposure", Flag = "wc_exposure", Callback = function(v) WC.on_toggle("exposure", v) end })
wcMod:Slider({ Title = "Exposure Amount", Flag = "wc_exposure_amount", Default = 0, Min = -3, Max = 3, Decimals = 2, Callback = function() WC.on_value("exposure") end })
wcMod:Toggle({ Title = "Disable Bloom", Flag = "wc_disable_bloom", Callback = function(v) WC.on_toggle("disable_bloom", v) end })
wcMod:Toggle({ Title = "Disable Sun Rays", Flag = "wc_disable_sun_rays", Callback = function(v) WC.on_toggle("disable_sun_rays", v) end })
wcMod:Toggle({ Title = "Disable Shadows", Flag = "wc_disable_shadows", Callback = function(v) WC.on_toggle("disable_shadows", v) end })
wcMod:Toggle({ Title = "Hide Sun / Moon / Stars", Flag = "wc_disable_celestial", Callback = function(v) WC.on_toggle("disable_celestial", v) end })

Module.new(WorldT, {
    Title = "Low Graphics",
    Description = "strip materials and lighting effects",
    Flag = "low_graphics",
    Callback = function(v)
        if v then LG.start() else LG.stop() end
    end,
})

-- ============================================================
-- BLATANT
-- ============================================================
local orbitMod = Module.new(BlatantT, {
    Title = "Orbit Ball",
    Description = "orbits your character around the ball",
    Flag = "orbit_ball",
    Callback = function(v)
        if v then Z.orbit_ball.start() else Z.orbit_ball.stop() end
    end,
})
orbitMod:Slider({ Title = "Speed", Flag = "orbit_speed", Default = 50, Min = 1, Max = 200, Callback = function(v) Z.orbit_ball.speed = v end })
orbitMod:Slider({ Title = "Distance", Flag = "orbit_distance", Default = 15, Min = 5, Max = 60, Callback = function(v) Z.orbit_ball.distance = v end })
orbitMod:Slider({ Title = "Height", Flag = "orbit_height", Default = 5, Min = -20, Max = 30, Callback = function(v) Z.orbit_ball.height = v end })

local followMod = Module.new(BlatantT, {
    Title = "Follow Target",
    Description = "locks onto and follows the player closest to your crosshair",
    Flag = "follow_target",
    Callback = function(v)
        if v then Z.follow_target.start() else Z.follow_target.stop() end
    end,
})
followMod:Dropdown({
    Title = "Follow Method",
    Flag = "follow_target_mode",
    Options = { "Walk", "TP" },
    Default = "Walk",
    Callback = function(v) Z.follow_target.set_mode(v) end,
})
followMod:Toggle({ Title = "Highlight Target", Flag = "follow_target_highlight", Callback = function(v) Z.config.follow_target_highlight = v end })
followMod:Colorpicker({ Title = "Highlight Color", Flag = "follow_target_highlight_color", Default = Color3.fromRGB(255, 0, 0), Callback = function(c) Z.config.follow_target_highlight_color = c; Z.visual.apply_highlight_color(Z.follow_target, c) end })
followMod:Toggle({ Title = "Target Text", Flag = "follow_target_text", Default = true, Callback = function(v) Z.config.follow_target_text = v end })
followMod:Slider({ Title = "Target Text Size", Flag = "follow_target_text_size", Default = 18, Min = 8, Max = 36, Callback = function(v) Z.config.follow_target_text_size = v end })
followMod:Colorpicker({ Title = "Target Text Color", Flag = "follow_target_text_color", Default = Color3.fromRGB(255, 0, 0), Callback = function(c) Z.config.follow_target_text_color = c; if Z.follow_target.text_draw then Z.follow_target.text_draw.Color = c end end })

Module.new(BlatantT, {
    Title = "Immortality",
    Description = "teleports you around the alive folder every frame",
    Flag = "walkable_immortal",
    Callback = function(v)
        if v then Z.immortal.start() else Z.immortal.stop() end
    end,
})

-- ============================================================
-- MISC
-- ============================================================
local killSoundMod = Module.new(MiscT, {
    Title = "Kill Sound",
    Description = "play a sound when you kill someone",
    Flag = "kill_sound_module",
    Callback = function(v)
        Z.kill_sound.enabled = v
    end,
})
killSoundMod:Dropdown({
    Title = "Sound",
    Flag = "kill_sound_selected",
    Options = Z.kill_sound.names,
    Default = "UwU",
    MaxVisible = 10,
    Callback = function() end,
})
killSoundMod:Slider({
    Title = "Volume (%)",
    Flag = "kill_sound_volume",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function() end,
})

local hitSoundMod = Module.new(MiscT, {
    Title = "Hit Sound",
    Description = "play a sound when you parry",
    Flag = "hit_sound_module",
    Callback = function(v)
        Z.hit_sound.enabled = v
    end,
})
hitSoundMod:Dropdown({
    Title = "Sound",
    Flag = "hit_sound_selected",
    Options = Z.hit_sound.names,
    Default = "UwU",
    MaxVisible = 10,
    Callback = function() end,
})
hitSoundMod:Slider({
    Title = "Volume (%)",
    Flag = "hit_sound_volume",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function() end,
})

-- ============================================================
-- GUI TAB
-- ============================================================
local themeKeys = {
    { Title = "Accent", Flag = "bb_theme_accent", Key = "Accent" },
    { Title = "Background", Flag = "bb_theme_background", Key = "Background" },
    { Title = "Surface", Flag = "bb_theme_surface", Key = "Surface" },
    { Title = "Border", Flag = "bb_theme_border", Key = "Border" },
    { Title = "Text", Flag = "bb_theme_text", Key = "Text" },
    { Title = "SubText", Flag = "bb_theme_subtext", Key = "SubText" },
}
local themeMod = Module.new(GuiT, {
    Title = "Appearance",
    Description = "Customize the menu colors",
    Flag = nil,
    Order = 1,
})
local themePickers = {}
for _, k in ipairs(themeKeys) do
    themePickers[k.Key] = themeMod:Colorpicker({
        Title = k.Title,
        Flag = k.Flag,
        Default = GUI.Palette[k.Key],
        Callback = function(c)
            local theme = {}
            theme[k.Key] = c
            theme_set(theme)
        end,
    })
end
themeMod:Button({
    Title = "Reset Theme",
    Callback = function()
        theme_set(GUI.Defaults)
        for _, k in ipairs(themeKeys) do
            local p = themePickers[k.Key]
            if p and p.Set then p:Set(GUI.Defaults[k.Key], true) end
        end
    end,
})

local overlayMod = Module.new(GuiT, {
    Title = "Overlays",
    Description = "ping and FPS on screen",
    Flag = nil,
    Order = 2,
})
overlayMod:Toggle({
    Title = "Show Real Ping",
    Flag = "show_real_ping",
    Callback = function(v)
        if v then start_ping_overlay() else stop_ping_overlay() end
    end,
})
overlayMod:Toggle({
    Title = "Show FPS",
    Flag = "show_fps",
    Callback = function(v)
        if v then start_fps_overlay() else stop_fps_overlay() end
    end,
})

-- Ping / FPS overlay implementations (simple)
local pingGui, pingConn, pingLabel
function start_ping_overlay()
    if pingGui then return end
    pingGui = Instance.new("ScreenGui")
    pingGui.Name = "ZenthraPing"
    pingGui.ResetOnSpawn = false
    pingGui.IgnoreGuiInset = true
    pingGui.DisplayOrder = 500
    pingGui.Parent = safe_parent()
    pingLabel = Instance.new("TextLabel")
    pingLabel.AnchorPoint = Vector2.new(1, 0)
    pingLabel.Position = UDim2.new(1, -20, 0, 120)
    pingLabel.Size = UDim2.fromOffset(120, 24)
    pingLabel.BackgroundTransparency = 1
    pingLabel.FontFace = font(Enum.FontWeight.Bold)
    pingLabel.TextSize = 18
    pingLabel.TextColor3 = Color3.new(1,1,1)
    pingLabel.TextXAlignment = Enum.TextXAlignment.Right
    pingLabel.Text = "0 ms"
    pingLabel.Parent = pingGui
    pingConn = RunService.Heartbeat:Connect(function()
        if not pingLabel or not pingLabel.Parent then return end
        if not throttle("ping_overlay", 0.15) then return end
        local ping = Z.cache.get_ping() or 0
        pingLabel.Text = string.format("%.0f ms", ping)
    end)
end

function stop_ping_overlay()
    if pingConn then pingConn:Disconnect(); pingConn = nil end
    if pingGui then pingGui:Destroy(); pingGui = nil end
    pingLabel = nil
end

local fpsGui, fpsConn, fpsLabel
function start_fps_overlay()
    if fpsGui then return end
    fpsGui = Instance.new("ScreenGui")
    fpsGui.Name = "ZenthraFPS"
    fpsGui.ResetOnSpawn = false
    fpsGui.IgnoreGuiInset = true
    fpsGui.DisplayOrder = 500
    fpsGui.Parent = safe_parent()
    fpsLabel = Instance.new("TextLabel")
    fpsLabel.AnchorPoint = Vector2.new(1, 0)
    fpsLabel.Position = UDim2.new(1, -20, 0, 150)
    fpsLabel.Size = UDim2.fromOffset(120, 24)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.FontFace = font(Enum.FontWeight.Bold)
    fpsLabel.TextSize = 18
    fpsLabel.TextColor3 = Color3.new(1,1,1)
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
    fpsLabel.Text = "0 FPS"
    fpsLabel.Parent = fpsGui
    local frames = 0
    local last = os.clock()
    fpsConn = RunService.RenderStepped:Connect(function()
        if not fpsLabel or not fpsLabel.Parent then return end
        frames += 1
        local now = os.clock()
        if now - last >= 0.5 then
            fpsLabel.Text = tostring(math.floor(frames / (now - last) + 0.5)) .. " FPS"
            frames = 0
            last = now
        end
    end)
end

function stop_fps_overlay()
    if fpsConn then fpsConn:Disconnect(); fpsConn = nil end
    if fpsGui then fpsGui:Destroy(); fpsGui = nil end
    fpsLabel = nil
end

-- restore overlay state on load
task.defer(function()
    if Flags.show_real_ping == true then start_ping_overlay() end
    if Flags.show_fps == true then start_fps_overlay() end
end)

-- ============================================================
-- INITIALIZE
-- ============================================================
-- Hook remotes
Z.remote_init()

-- Warm direct remote
task.defer(function()
    Z.warm_direct()
end)

-- Preload the "grab" anim folder lazily
task.defer(function()
    pcall(function()
        local _ = ReplicatedStorage.Shared.SwordAPI.Collection
    end)
end)

-- Session guard for the main loop
task.spawn(function()
    while is_current_session() do
        RunService.Heartbeat:Wait()
    end
    -- cleanup
    pcall(function()
        if _G.__ZenthraWindows then
            for _, w in ipairs(_G.__ZenthraWindows) do
                pcall(function() w.Screen:Destroy() end)
            end
        end
        for _, c in ipairs(GUI.State.Connections) do
            pcall(function() c:Disconnect() end)
        end
    end)
end)

notify("Zenthra", "Loaded — press RightShift to toggle.", true, 4)

return win
