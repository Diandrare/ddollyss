-- bro got deobf by a fucking bot 
-- by top deobf nigga

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players") 
local RunService = game:GetService("RunService") 
local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local StatsService = game:GetService("Stats") 
local UserInputService = game:GetService("UserInputService") 
local Camera = workspace.CurrentCamera 
local SwordAPI = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("SwordAPI") 
local player = Players.LocalPlayer
local function parryContextAllowed()
 local c=player.Character local h=c and c:FindFirstChildOfClass("Humanoid") local r=c and (c.PrimaryPart or c:FindFirstChild("HumanoidRootPart"))
 if not c or not h or h.Health<=0 or not r or c:GetAttribute("Stunned") or c:GetAttribute("DoNotParry") or c:GetAttribute("IsFrozen") then return false end
 if c.Parent==workspace:FindFirstChild("Alive") then return true end
 if player:GetAttribute("LobbyParry") and not player:GetAttribute("InLobbyParryCooldown") then return true end
 if player:GetAttribute("LobbyTraining") and c.Parent==workspace:FindFirstChild("Dead") then return true end
 local sp=workspace:FindFirstChild("Spawn") local lt=sp and sp:FindFirstChild("LobbyTraining") local area=lt and lt:FindFirstChild("TrainingArea")
 if area and area:IsA("BasePart") then local q=area.CFrame:PointToObjectSpace(r.Position) return math.abs(q.X)<=area.Size.X/2+2 and math.abs(q.Z)<=area.Size.Z/2+2 and math.abs(q.Y)<=area.Size.Y/2+20 end
 return false
end
do
 local env=getgenv() local host=(gethui and gethui()) or game:GetService("CoreGui") local protect=protect_gui or protectgui or syn and syn.protect_gui
 local function cloak(g) if not g then return end pcall(function() g.Name=game:GetService("HttpService"):GenerateGUID(false):gsub("-",""):sub(1,18) g.ResetOnSpawn=false end) if protect then pcall(protect,g) end if set_hidden_gui then pcall(set_hidden_gui,g,true) end if host and g.Parent~=host then pcall(function() g.Parent=host end) end end
 env.C417CloakGui=cloak
 env.C417ScrambleUI=function(instance) if instance then pcall(function() for _,v in ipairs(instance:GetDescendants()) do if v:IsA("GuiObject") then v.Name=game:GetService("HttpService"):GenerateGUID(false):gsub("-",""):sub(1,18) end end end) end end
 env.GameSecure=setmetatable({},{__index=function(_,k) if k=="GetService" then return function(_,n) return (cloneref or function(x)return x end)(game:GetService(n)) end end return game[k] end})
 if not env.C417SecurityProbe then env.C417SecurityProbe=true task.spawn(function() while true do local st=os.clock() local fin=false task.delay(2,function() fin=true end) while not fin and os.clock()-st<4 do RunService.RenderStepped:Wait() end if not fin then warn("[417 Security] scheduler freeze") end task.wait(5) end end) end
end

-- // [ НАСТРОЙКИ ] // -- 
local cfg = { 
parry = true, 
spam = false, 
trigger = false, 
cps = 200, 
accuracy = 50,
randomPingAccuracy = false,
autoSpam = false,
spamThreshold = 2.5,
distanceMultiplier = 0.3,
targetChangeStop = false,
aiPatterns = true,
aiDetection = true,
abilityDetections = true,
animfix = true, 
showStats = true,
showSpamUI = true,
showTriggerUI = true,
curveType = 'straight',
showBindWindow = false,
spamBindKey = "P"
}

local CONFIG_FOLDER = "417Script"
local CONFIG_PATH = CONFIG_FOLDER .. "/config.json"
local CONFIG_FS = type(isfolder)=="function" and type(makefolder)=="function" and type(isfile)=="function" and type(readfile)=="function" and type(writefile)=="function"
local function Save417Config()
    if not CONFIG_FS then return false end
    return pcall(function()
        if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
        writefile(CONFIG_PATH, game:GetService("HttpService"):JSONEncode(cfg))
    end)
end
local function Load417Config()
    if not CONFIG_FS or not isfile(CONFIG_PATH) then return end
    pcall(function()
        local loaded=game:GetService("HttpService"):JSONDecode(readfile(CONFIG_PATH))
        if type(loaded)=="table" then
            for key,default in pairs(cfg) do
                local value=loaded[key]
                if value~=nil and type(value)==type(default) then cfg[key]=value end
            end
        end
    end)
end
Load417Config()
local RuntimeAccuracy = math.clamp(tonumber(cfg.accuracy) or 50,1,100)
task.spawn(function() while task.wait(1) do Save417Config() end end)
getgenv().Save417Config=Save417Config
getgenv().Load417Config=Load417Config

-- // [ БИНД ] // -- 
local spamBindKey = cfg.spamBindKey or "P" 
local isWaitingForBind = false 
local parried_balls = {} 
local triggered_balls = {} 
local AnimationCache = {}

-- // [ ПЕРЕМЕННЫЕ ] // -- 
local spamActive = cfg.spam == true 
local lastSpamTime = 0

-- // [ СТАТИСТИКА ] // -- 
local ballStats = { current = 0, peak = 0 } 
local statsFrame = nil 
local currentLabel = nil

local function GetBallSpeed() 
for _, v in pairs(workspace.Balls:GetChildren()) do 
if v:GetAttribute("realBall") then 
if v.Velocity then 
return v.Velocity.Magnitude 
end 
local z = v:FindFirstChild("zoomies") 
if z and z:FindFirstChild("VectorVelocity") then 
return z.VectorVelocity.Magnitude 
end 
end 
end 
return 0 
end

local function UpdateBallStats() 
local speed = GetBallSpeed() 
ballStats.current = math.floor(speed) 
if speed > ballStats.peak then 
ballStats.peak = math.floor(speed) 
end 
if statsFrame and statsFrame.Visible and currentLabel then 
currentLabel.Text = "⚡ " .. ballStats.current .. " | 📈 " .. ballStats.peak 
end 
end

local lastBallId = nil 
task.spawn(function() 
while true do 
local newId = nil 
for _, v in pairs(workspace.Balls:GetChildren()) do 
if v:GetAttribute("realBall") then 
newId = v:GetDebugId() 
break 
end 
end 
if newId and newId ~= lastBallId then 
ballStats.peak = 0 
lastBallId = newId 
end 
task.wait(0.2) 
end 
end)

task.spawn(function() 
while true do 
if cfg.showStats and statsFrame and statsFrame.Visible then 
UpdateBallStats() 
end 
task.wait(0.05) 
end 
end)

local AbilityDetection={infinity=false,deathslash=false,timehole=false,fury=false,phantom=false,dribble=false,pull=false}
local function AbilityBlocked()
 if not cfg.abilityDetections then return false end
 local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
 return AbilityDetection.infinity or AbilityDetection.deathslash or AbilityDetection.timehole or AbilityDetection.fury or AbilityDetection.phantom or AbilityDetection.dribble or AbilityDetection.pull or (root and root:FindFirstChild("SingularityCape")~=nil)
end
pcall(function() ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(_,v) AbilityDetection.infinity=v and true or false end) end)
pcall(function() ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(_,v) AbilityDetection.deathslash=v and true or false end) end)
pcall(function()
 local net=ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net
 net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(p) if p==player or p==player.Name or p and p.Name==player.Name then AbilityDetection.timehole=true end end)
 net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function() AbilityDetection.timehole=false end)
 net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(p) if p==player or p==player.Name or p and p.Name==player.Name then AbilityDetection.fury=true end end)
 net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function() AbilityDetection.fury=false end)
end)
pcall(function()
 local remotes=ReplicatedStorage:FindFirstChild("Remotes")
 local pull=remotes and (remotes:FindFirstChild("PlrPulled") or remotes:FindFirstChild("PlrPulsed"))
 if pull then pull.OnClientEvent:Connect(function(a,b) AbilityDetection.pull=type(a)=="boolean" and a or type(b)=="boolean" and b or true if type(a)~="boolean" and type(b)~="boolean" then task.delay(1.5,function() AbilityDetection.pull=false end) end end) end
end)
task.spawn(function()
 while task.wait(.15) do
  local ball local folder=workspace:FindFirstChild("Balls")
  if folder then for _,v in ipairs(folder:GetChildren()) do if v:GetAttribute("realBall") then ball=v break end end end
  AbilityDetection.dribble=ball and (ball:GetAttribute("Dribble")==true or ball:GetAttribute("Dribbling")==true or ball:FindFirstChild("Dribble")~=nil or ball:FindFirstChild("Dribbling")~=nil) or false
 end
end)
task.spawn(function()
 local runtime=workspace:FindFirstChild("Runtime") or workspace:WaitForChild("Runtime",15)
 if runtime then runtime.ChildAdded:Connect(function(o)
  if o.Name~="maxTransmission" and o.Name~="transmissionpart" then return end
  local weld=o:FindFirstChildWhichIsA("WeldConstraint") local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
  if weld and root and weld.Part1==root then AbilityDetection.phantom=true task.delay(1,function() AbilityDetection.phantom=false end) end
 end) end
end)
getgenv().C417AbilityDetectionState=AbilityDetection

-- // [ PING ] // -- 
local function GetPing() 
local success, result = pcall(function() 
return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() 
end) 
return success and result or 100 
end
task.spawn(function()
 while task.wait(1) do
  if cfg.randomPingAccuracy then
   local ping=GetPing()
   if ping>=90 then RuntimeAccuracy=4
   elseif ping<=50 then RuntimeAccuracy=math.random(70,100)
   else RuntimeAccuracy=math.clamp(tonumber(cfg.accuracy) or 50,1,100) end
  else RuntimeAccuracy=math.clamp(tonumber(cfg.accuracy) or 50,1,100) end
 end
end)
local AI={ping=100,frame=1/60,jitter=0,extra=0,last=0,motion=setmetatable({},{__mode="k"})}
RunService.Heartbeat:Connect(function(dt) local old=AI.frame AI.frame=old+((dt or 1/60)-old)*.12 AI.jitter=AI.jitter+(math.abs((dt or 1/60)-old)-AI.jitter)*.15 if os.clock()-AI.last>.25 then AI.last=os.clock() local p=GetPing() AI.ping=AI.ping+(p-AI.ping)*.22 end if not cfg.aiDetection then AI.extra=0 elseif AI.ping>=220 or AI.frame>=.065 then AI.extra=.05 elseif AI.ping>=140 or AI.frame>=.035 then AI.extra=.028 elseif AI.ping>=85 then AI.extra=.012 else AI.extra=0 end end)
local function ClosestOpponent() local root=player.Character and player.Character.PrimaryPart local alive=workspace:FindFirstChild("Alive") if not root or not alive then return end local best,res=math.huge,nil for _,c in ipairs(alive:GetChildren()) do if c~=player.Character and c.PrimaryPart then local d=(c.PrimaryPart.Position-root.Position).Magnitude if d<best then best,res=d,c end end end return res end
local function CalculateParryDistance(ball,velocity,root)
 local speed=velocity.Magnitude local ping=GetPing() local capped=math.min(math.max(speed-9.5,0),650) local div=(2.4+capped*.002)*(0.75+(math.clamp(RuntimeAccuracy,1,100)-1)*(3/99)) local modern=math.clamp(ping/100,5,17)+math.max(speed/div,9.5) local legacy=speed/math.max(2.4,RuntimeAccuracy/8)+ping/10 local result=math.max(modern,legacy)
 if cfg.aiDetection then result=result+math.clamp(speed*AI.extra,0,30) if speed>=750 then result=math.max(result,9.5+speed*.025) end end
 if cfg.aiPatterns then local now=os.clock() local h=AI.motion[ball] if h then local dt=math.clamp(now-h.time,1/240,.15) local acc=(velocity-h.velocity).Magnitude/dt local turn=velocity.Magnitude>0 and h.velocity.Magnitude>0 and math.acos(math.clamp(velocity.Unit:Dot(h.velocity.Unit),-1,1)) or 0 result=result+math.clamp(acc*.0015+speed*turn*.07,0,20) end AI.motion[ball]={velocity=velocity,time=now} local o=ClosestOpponent() if o and o.PrimaryPart then local to=root.Position-o.PrimaryPart.Position if to.Magnitude>0 then result=result+math.clamp(math.max(o.PrimaryPart.AssemblyLinearVelocity:Dot(to.Unit),0)*.1,0,12) end end end
 return result
end

-- // [ УВУ ДЕТЕКТ - ПОРОГ 25 СТАДИЙ + ВСЕГДА ТЯЖЁЛАЯ ЛОГИКА ] // -- 
local Lerp_Radians = 0 
local Last_Warping = tick()

local function Is_Curved(ball) 
local Zoomies = ball:FindFirstChild("zoomies") 
if not Zoomies then 
return false 
end 
local Velocity = Zoomies.VectorVelocity 
local Character = player.Character 
if not Character or not Character.PrimaryPart then 
return false 
end

-- ПОРОГ 25 СТАДИЙ (НЕ УВУ ЕСЛИ МЯЧ БЛИЖЕ 25)
local distanceToBall = (Character.PrimaryPart.Position - ball.Position).Magnitude
if distanceToBall <= 25 then
    return false
end

local Speed = Velocity.Magnitude
local Direction = (Character.PrimaryPart.Position - ball.Position).Unit
local Dot = Direction:Dot(Velocity.Unit)

local Ping = GetPing() / 1000
local Distance = (Character.PrimaryPart.Position - ball.Position).Magnitude
local Reach_Time = Distance / Speed - Ping
local Radians = math.rad(math.asin(math.clamp(Dot, -1, 1)))
Lerp_Radians = Lerp_Radians + (Radians - Lerp_Radians) * 0.8

if Lerp_Radians < 0.018 then
    Last_Warping = tick()
end

if (tick() - Last_Warping) < (Reach_Time / 1.5) then
    return true
end
return Dot < (0.5 - Ping)
end

-- // [ АНИМАЦИИ ] // -- 
local function GetParryAnimation() 
local char = player.Character 
local currentSword = char and char:GetAttribute("CurrentlyEquippedSword") 
if not currentSword then 
return SwordAPI.Collection.Default:FindFirstChild("GrabParry") 
end 
if AnimationCache[currentSword] then 
return AnimationCache[currentSword] 
end 
local success, swordData = pcall(function() 
return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(currentSword) 
end) 
if success and type(swordData) == "table" then 
for _, obj in pairs(SwordAPI.Collection:GetChildren()) do 
if obj.Name == swordData.AnimationType then 
local anim = obj:FindFirstChild("GrabParry") or obj:FindFirstChild("Grab") 
if anim then 
AnimationCache[currentSword] = anim 
return anim 
end 
end 
end 
end 
return SwordAPI.Collection.Default:FindFirstChild("GrabParry") 
end

local function PlayParryAnimation() 
if not cfg.animfix then 
return 
end 
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid") 
if not hum or not hum:FindFirstChild("Animator") then 
return 
end 
local animation = GetParryAnimation() 
if not animation then 
return 
end 
for _, track in pairs(hum.Animator:GetPlayingAnimationTracks()) do 
if track.Name:find("Grab") or track.Name:find("Parry") then 
track:Stop(0.1) 
end 
end 
local track = hum.Animator:LoadAnimation(animation) 
track:Play(0, 1, 1) 
end

-- // [ КРИВЫЕ ] // -- 
local function ApplyCurveToCFrame(baseCFrame) 
if not cfg.curveType or cfg.curveType == 'straight' then 
return baseCFrame 
end 
local rotation = CFrame.new() 
if cfg.curveType == 'backwards' then 
rotation = CFrame.Angles(0, math.rad(180), 0) 
elseif cfg.curveType == 'down' then 
rotation = CFrame.Angles(math.rad(-45), 0, 0) 
elseif cfg.curveType == 'up' then 
rotation = CFrame.Angles(math.rad(45), 0, 0) 
elseif cfg.curveType == 'left' then 
rotation = CFrame.Angles(0, math.rad(-90), 0) 
elseif cfg.curveType == 'right' then 
rotation = CFrame.Angles(0, math.rad(90), 0) 
elseif cfg.curveType == 'random' then 
local randomAngle = math.random() * math.pi * 2 
rotation = CFrame.Angles(0, randomAngle, 0) 
end 
return baseCFrame * rotation 
end

-- // [ ПОЛУЧЕНИЕ ДАННЫХ ДЛЯ ПАРРИ ] // -- 
local function GetParryData() 
local viewportSize = Camera.ViewportSize 
local centerPos = { viewportSize.X / 2, viewportSize.Y / 2 } 
local events = {} 
for _, v in pairs(workspace.Alive:GetChildren()) do 
if v ~= player.Character and v:FindFirstChild("HumanoidRootPart") then 
local screenPos, isOnScreen = Camera:WorldToScreenPoint(v.HumanoidRootPart.Position) 
if isOnScreen then 
events[tostring(v)] = screenPos 
end 
end 
end 
return Camera.CFrame, events, centerPos 
end 
local recentParries=0
local RAP={keyTable=nil,transformFn=nil,netModule=nil,remoteId=nil,hash=nil,remote=nil,ready=false}
pcall(function()
 local oldInfo oldInfo=hookfunction(getrenv().debug.info,function(f,t) if checkcaller and not checkcaller() then return oldInfo(f,t) end if type(f)=="function" and t=="s" then return "[C]" end if f==4 and t=="s" then return "ReplicatedStorage.Controllers.SwordsController " end return oldInfo(f,t) end)
 local oldEnv oldEnv=hookfunction(getrenv().getfenv,function(l) if checkcaller and not checkcaller() then return oldEnv(l) end if type(l)=="number" and l>=1 and l<=10 then return oldEnv(10) end return oldEnv(l) end)
end)
task.spawn(function() pcall(function() local cs=ReplicatedStorage:WaitForChild("Controllers",15) local sc for _,v in ipairs(cs:GetChildren()) do if v.Name:sub(1,16)=="SwordsController" then sc=v break end end local pry=sc and sc:WaitForChild("PRY",15) if not pry then return end local gu=debug.getupvalues or getupvalues local u=gu(require(pry)) RAP.keyTable,RAP.transformFn,RAP.netModule,RAP.remoteId,RAP.hash=u[3],u[4],u[6],u[7],u[8] RAP.remote=RAP.netModule:RemoteEvent(RAP.remoteId) RAP.ready=RAP.remote~=nil end) end)
local function SendParry()
 if not RAP.ready or not parryContextAllowed() or AbilityBlocked() then return false end local kt=RAP.keyTable local key=kt and kt[1] and kt[1][kt[3]] if not key then return false end local ok,tr=pcall(RAP.transformFn,key,"TIME") if not ok or not tr then ok,tr=pcall(RAP.transformFn,key) end if not ok or not tr then return false end
 local ts=tostring(math.floor(workspace:GetServerTimeNow()*100)) local out={} for i=1,#ts do out[i]=string.char(bit32.bxor((ts:byte(i)+i)%256,tr:byte((i-1)%#tr+1))) end
 local cf,events,mouse=GetParryData() cf=ApplyCurveToCFrame(cf) local fired=pcall(function() RAP.remote:FireServer(RAP.hash,key,table.concat(out),0.5,cf,events,mouse,false) end) if fired then recentParries=(recentParries or 0)+1 task.delay(.5,function() recentParries=math.max((recentParries or 1)-1,0) end) end if fired and cfg.animfix then task.spawn(PlayParryAnimation) end return fired
end

-- // [ АВТОПАРРИ ] // -- 
local function ProcessAutoParry(ball) 
if not cfg.parry or spamActive then 
return 
end 
local bID = ball:GetDebugId() 
if ball:GetAttribute("target") ~= player.Name or parried_balls[bID] then 
return 
end 
if Is_Curved(ball) then 
return 
end 
local charPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart") 
if not charPart then 
return 
end 
local velocity = ball.zoomies.VectorVelocity 
local ballPos = ball.Position 
local playerPos = charPart.Position 
local dist = (playerPos - ballPos).Magnitude 
local threshold = CalculateParryDistance(ball, velocity, charPart)
if dist <= threshold or dist <= 20 then 
parried_balls[bID] = true 
SendParry() 
ball:GetAttributeChangedSignal("target"):Once(function() 
parried_balls[bID] = nil 
end) 
end 
end

-- // [ ТРИГГЕРБОТ ] // -- 
local function ProcessTriggerBot(ball) 
if not cfg.trigger or spamActive then 
return 
end 
local bID = ball:GetDebugId() 
if ball:GetAttribute("target") == player.Name and not triggered_balls[bID] then 
triggered_balls[bID] = true 
SendParry() 
ball:GetAttributeChangedSignal("target"):Once(function() 
triggered_balls[bID] = nil 
end) 
end 
end

local AS={target=nil,targetTime=0,lastCheck=0,lastFire=0,trackedBall=nil,targetConn=nil,engagedTarget=nil,abortCycle=false}
local function ResetAutoSpamTargetGuard()
 if AS.targetConn then AS.targetConn:Disconnect() AS.targetConn=nil end
 AS.trackedBall=nil
 AS.engagedTarget=nil
 AS.abortCycle=false
end
local function TrackAutoSpamTarget(ball)
 if AS.trackedBall==ball then return end
 ResetAutoSpamTargetGuard()
 AS.trackedBall=ball
 AS.engagedTarget=ball:GetAttribute("target")
 AS.targetConn=ball:GetAttributeChangedSignal("target"):Connect(function()
  if AS.trackedBall~=ball then return end
  local liveTarget=ball:GetAttribute("target")
  if cfg.targetChangeStop then
   if not AS.engagedTarget then
    AS.engagedTarget=liveTarget
   elseif liveTarget and liveTarget~=AS.engagedTarget then
    AS.engagedTarget=liveTarget
    AS.abortCycle=true
   end
  else
   AS.engagedTarget=liveTarget
   AS.abortCycle=false
  end
 end)
end
local function ProcessAutoSpam(ball)
 if not cfg.autoSpam or not parryContextAllowed() then ResetAutoSpamTargetGuard() return end local root=player.Character and player.Character.PrimaryPart local z=ball:FindFirstChild("zoomies") if not root or not z then return end
 TrackAutoSpamTarget(ball)
 local now=tick() if now-AS.lastFire<0.015 then return end AS.lastFire=now local target=ball:GetAttribute("target")
 if cfg.targetChangeStop then
  if not AS.engagedTarget then
   AS.engagedTarget=target
  elseif target and target~=AS.engagedTarget then
   AS.engagedTarget=target
   AS.abortCycle=true
  end
 else
  AS.engagedTarget=target
  AS.abortCycle=false
 end
 if AS.abortCycle then AS.abortCycle=false return end
 if now-AS.lastCheck>.1 then AS.target=ClosestOpponent() AS.lastCheck=now AS.targetTime=now end local enemy=AS.target if not enemy or not enemy.PrimaryPart or not target then return end
 local speed=z.VectorVelocity.Magnitude if speed<.001 then return end local ping=math.clamp(GetPing()/10,1,16) local max=(ping+math.min(speed/6,255)+math.clamp(speed*AI.extra,0,35))*cfg.distanceMultiplier
 local bd=(root.Position-ball.Position).Magnitude local ed=(root.Position-enemy.PrimaryPart.Position).Magnitude if bd>max or ed>max then return end local dot=(root.Position-ball.Position).Unit:Dot(z.VectorVelocity.Unit) local acc=max-math.clamp(dot,-1,0)*(5-math.min(speed/5,5))
 if (target==enemy.Name or target==player.Name) and bd<=acc and ed<=acc and recentParries>cfg.spamThreshold then SendParry() end
end

-- // [ ОСНОВНОЙ ЦИКЛ СПАМА ] // -- 
task.spawn(function() 
while true do 
if spamActive and RAP.ready then 
local delay = 1 / cfg.cps 
if tick() - lastSpamTime >= delay then 
SendParry() 
lastSpamTime = tick() 
end 
end 
task.wait(0.001) 
end 
end)

local BindButton = nil 
local StatusBtn = nil

-- // [ ОБРАБОТЧИК БИНДА ] // -- 
UserInputService.InputBegan:Connect(function(input, gameProcessed) 
if gameProcessed then 
return 
end 
if isWaitingForBind then 
local key = input.KeyCode.Name 
if key ~= "Unknown" then 
spamBindKey = key
cfg.spamBindKey = key
isWaitingForBind = false 
if BindButton then 
BindButton.Text = "[ " .. spamBindKey .. " ]" 
BindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
end 
end 
return 
end 
if input.KeyCode.Name == spamBindKey then 
spamActive = not spamActive
cfg.spam = spamActive
if StatusBtn then 
StatusBtn.Text = spamActive and "SPAM" or "SPAM" 
StatusBtn.BackgroundColor3 = spamActive and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(30, 30, 30) 
StatusBtn.TextColor3 = spamActive and Color3.new(1, 1, 1) or Color3.fromRGB(255, 140, 0) 
end 
print("[417] Spam:", spamActive and "ON" or "OFF") 
end 
end)

-- // [ ОСНОВНОЙ ЦИКЛ ] // -- 
RunService.Heartbeat:Connect(function() 
if not RAP.ready then 
return 
end 
local ball=nil
local balls=workspace:FindFirstChild("Balls")
if balls then for _,v in pairs(balls:GetChildren()) do if v:GetAttribute("realBall") then ball=v break end end end
if ball then
 if cfg.trigger then ProcessTriggerBot(ball) elseif cfg.parry and not spamActive then ProcessAutoParry(ball) end
 ProcessAutoSpam(ball)
end
local training=workspace:FindFirstChild("TrainingBalls")
if training and parryContextAllowed() then for _,v in ipairs(training:GetChildren()) do if v:GetAttribute("realBall") then if cfg.parry then ProcessAutoParry(v) end ProcessAutoSpam(v) break end end end 
end)

-- // [ ОСТАНОВКА АНИМАЦИИ ПРИ УСПЕШНОМ ПАРРИ ] // -- 
ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function() 
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid") 
if not hum or not hum:FindFirstChild("Animator") then 
return 
end 
for _, track in pairs(hum.Animator:GetPlayingAnimationTracks()) do 
if track.Name:find("Grab") or track.Name:find("Parry") then 
track:Stop(0.1) 
end 
end 
end)

-- // [ UI ] // -- 
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
pcall(function() getgenv().C417CloakGui(ScreenGui) end)

local function MakeDraggable(frame) 
local dragging, dragInput, dragStart, startPos 
frame.InputBegan:Connect(function(input) 
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
dragging = true 
dragStart = input.Position 
startPos = frame.Position 
input.Changed:Connect(function() 
if input.UserInputState == Enum.UserInputState.End then 
dragging = false 
end 
end) 
end 
end) 
frame.InputChanged:Connect(function(input) 
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
dragInput = input 
end 
end) 
UserInputService.InputChanged:Connect(function(input) 
if input == dragInput and dragging then 
local delta = input.Position - dragStart 
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) 
end 
end) 
end

-- ОКОШКО ДЛЯ БИНДА 
local BindFrame = Instance.new("Frame", ScreenGui) 
BindFrame.Size = UDim2.new(0, 100, 0, 40) 
BindFrame.Position = UDim2.new(0.5, -50, 0.25, 0) 
BindFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) 
BindFrame.BackgroundTransparency = 0.3 
BindFrame.Visible = false 
Instance.new("UICorner", BindFrame).CornerRadius = UDim.new(0, 8) 
Instance.new("UIStroke", BindFrame).Color = Color3.fromRGB(100, 100, 100) 
MakeDraggable(BindFrame)

local BindLabel = Instance.new("TextLabel", BindFrame) 
BindLabel.Size = UDim2.new(1, 0, 1, 0) 
BindLabel.Position = UDim2.new(0, 0, 0, 0) 
BindLabel.BackgroundTransparency = 1 
BindLabel.Text = "BIND" 
BindLabel.TextColor3 = Color3.fromRGB(180, 180, 180) 
BindLabel.Font = Enum.Font.GothamBold 
BindLabel.TextSize = 10 
BindLabel.TextXAlignment = Enum.TextXAlignment.Center

local BindButton = Instance.new("TextButton", BindFrame) 
BindButton.Size = UDim2.new(0, 50, 0, 25) 
BindButton.Position = UDim2.new(0.5, -25, 0, 30) 
BindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
BindButton.Text = "[ " .. spamBindKey .. " ]" 
BindButton.TextColor3 = Color3.fromRGB(255, 170, 0) 
BindButton.Font = Enum.Font.GothamBold 
BindButton.TextSize = 12 
Instance.new("UICorner", BindButton).CornerRadius = UDim.new(0, 5)

BindButton.MouseButton1Click:Connect(function() 
isWaitingForBind = true 
BindButton.Text = "[ ... ]" 
BindButton.BackgroundColor3 = Color3.fromRGB(80, 50, 0) 
end)

-- ОСНОВНОЕ UI 
local MainFrame = Instance.new("Frame", ScreenGui) 
MainFrame.Size = UDim2.new(0, 130, 0, 60) 
MainFrame.Position = UDim2.new(0.5, -135, 0.15, 0) 
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
MainFrame.BackgroundTransparency = 0.25 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10) 
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 120, 0) 
MakeDraggable(MainFrame)

local StatusBtn = Instance.new("TextButton", MainFrame) 
StatusBtn.Size = UDim2.new(1, -20, 1, -20) 
StatusBtn.Position = UDim2.new(0, 10, 0, 10) 
StatusBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
StatusBtn.Text = "SPAM" 
StatusBtn.TextColor3 = Color3.fromRGB(255, 140, 0) 
StatusBtn.Font = Enum.Font.GothamBold 
StatusBtn.TextSize = 14 
Instance.new("UICorner", StatusBtn).CornerRadius = UDim.new(0, 8)

local TBFrame = Instance.new("Frame", ScreenGui) 
TBFrame.Size = UDim2.new(0, 130, 0, 60) 
TBFrame.Position = UDim2.new(0.5, 5, 0.15, 0) 
TBFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
TBFrame.BackgroundTransparency = 0.25 
Instance.new("UICorner", TBFrame).CornerRadius = UDim.new(0, 10) 
Instance.new("UIStroke", TBFrame).Color = Color3.fromRGB(255, 120, 0) 
MakeDraggable(TBFrame)

local TBBtn = Instance.new("TextButton", TBFrame) 
TBBtn.Size = UDim2.new(1, -20, 1, -20) 
TBBtn.Position = UDim2.new(0, 10, 0, 10) 
TBBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
TBBtn.Text = "TB OFF" 
TBBtn.TextColor3 = Color3.fromRGB(255, 140, 0) 
TBBtn.Font = Enum.Font.GothamBold 
TBBtn.TextSize = 14 
Instance.new("UICorner", TBBtn).CornerRadius = UDim.new(0, 8)

statsFrame = Instance.new("Frame", ScreenGui) 
statsFrame.Size = UDim2.new(0, 160, 0, 40) 
statsFrame.Position = UDim2.new(0.5, 145, 0.15, 0) 
statsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
statsFrame.BackgroundTransparency = 0.25 
Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 10) 
Instance.new("UIStroke", statsFrame).Color = Color3.fromRGB(255, 120, 0) 
MakeDraggable(statsFrame)

currentLabel = Instance.new("TextLabel", statsFrame) 
currentLabel.Size = UDim2.new(1, -10, 1, -10) 
currentLabel.Position = UDim2.new(0, 5, 0, 5) 
currentLabel.BackgroundTransparency = 1 
currentLabel.Text = "⚡ 0 | 📈 0" 
currentLabel.TextColor3 = Color3.fromRGB(255, 200, 100) 
currentLabel.Font = Enum.Font.GothamBold 
currentLabel.TextSize = 12

StatusBtn.MouseButton1Click:Connect(function() 
if not RAP.ready then 
StatusBtn.Text = "NO REMOTE!" 
task.wait(1) 
StatusBtn.Text = spamActive and "SPAM" or "SPAM" 
return 
end 
spamActive = not spamActive
cfg.spam = spamActive
StatusBtn.Text = spamActive and "SPAM" or "SPAM" 
StatusBtn.BackgroundColor3 = spamActive and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(30, 30, 30) 
StatusBtn.TextColor3 = spamActive and Color3.new(1, 1, 1) or Color3.fromRGB(255, 140, 0) 
end)

TBBtn.MouseButton1Click:Connect(function() 
if not RAP.ready then 
TBBtn.Text = "NO REMOTE!" 
task.wait(1) 
TBBtn.Text = cfg.trigger and "TB ON" or "TB OFF" 
return 
end 
cfg.trigger = not cfg.trigger 
TBBtn.Text = cfg.trigger and "TB ON" or "TB OFF" 
TBBtn.BackgroundColor3 = cfg.trigger and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(30, 30, 30) 
TBBtn.TextColor3 = cfg.trigger and Color3.new(1, 1, 1) or Color3.fromRGB(255, 140, 0) 
end)

-- // [ NEVERLOSE UI - РАБОЧАЯ ВЕРСИЯ ] // -- 
local _uiBefore={} local _uiHost=(gethui and gethui()) or game:GetService("CoreGui")
pcall(function() for _,g in ipairs(_uiHost:GetChildren()) do _uiBefore[g]=true end end)
local status, NEVERLOSE = pcall(function() 
local source=game:HttpGet("https://raw.githubusercontent.com/AchaoticSoftworksCore/AchaoticAssets/main/UiLibrarys/NEVERLOSE-UI-Nightly.luau")
local sliderStart=source:find("function sectionfunc:AddSlider",1,true)
local sliderEnd=sliderStart and source:find("function sectionfunc:AddDropdown",sliderStart,true)
if sliderStart and sliderEnd then
 local before=source:sub(1,sliderStart-1)
 local chunk=source:sub(sliderStart,sliderEnd-1)
 local after=source:sub(sliderEnd)
 chunk=chunk:gsub("function sectionfunc:AddSlider%(SliderNameString,Min,Max,Default,callback%)","function sectionfunc:AddSlider(SliderNameString,Min,Max,Default,callback,Decimals)\n\t\t\t\tDecimals=Decimals or 0\n\t\t\t\tlocal DecimalFactor=10^Decimals\n\t\t\t\tlocal function FormatSlider(v) return Decimals>0 and string.format('%%.'..Decimals..'f',v) or tostring(math.floor(v+0.5)) end",1)
 chunk=chunk:gsub('local ValueText = Instance.new%("TextLabel"%)','local ValueText = Instance.new("TextBox")',1)
 chunk=chunk:gsub("local Valuea = math.floor%(%(%(Max %- Min%) %* SizeScale%) %+ Min%)","local Valuea = math.floor((((Max - Min) * SizeScale) + Min) * DecimalFactor + 0.5) / DecimalFactor",1)
 chunk=chunk:gsub("ValueText.Text = tostring%(Valuea%)","ValueText.Text = FormatSlider(Valuea)",1)
 chunk=chunk:gsub("ValueText.Text = tostring%(Default%)","ValueText.Text = FormatSlider(Default)",1)
 chunk=chunk:gsub("ValueText.Text = tostring%(s%)","ValueText.Text = FormatSlider(s)",1)
 local injection=[[
                ValueText.ClearTextOnFocus=false
                ValueText.FocusLost:Connect(function()
                    local typed=tonumber(ValueText.Text)
                    if not typed then ValueText.Text=FormatSlider(Default) return end
                    typed=math.clamp(typed,Min,Max)
                    typed=math.floor(typed*DecimalFactor+0.5)/DecimalFactor
                    ValueText.Text=FormatSlider(typed)
                    Inline.Size=UDim2.fromScale(math.clamp((typed-Min)/math.max(Max-Min,0.001),0,1),1)
                    callback(typed)
                end)

]]
 chunk=chunk:gsub("%s*local func={}","\n"..injection.."                local func={}",1)
 source=before..chunk..after
end
return loadstring(source)()
end)

if status and NEVERLOSE then
 task.spawn(function() for _=1,20 do pcall(function() for _,g in ipairs(_uiHost:GetChildren()) do if g:IsA("ScreenGui") and not _uiBefore[g] then _uiBefore[g]=true getgenv().C417CloakGui(g) end end end) task.wait(.1) end end)
NEVERLOSE:Theme("nightly") 
local Win = NEVERLOSE:AddWindow("417", " ") 
local Tab = Win:AddTab('AP', 'zap') 
local MainSec = Tab:AddSection('Main') 
MainSec:AddToggle('Auto Parry', cfg.parry, function(v)
cfg.parry = v
end)
MainSec:AddToggle('Randomize Accuracy (Ping Based)', cfg.randomPingAccuracy, function(v)
cfg.randomPingAccuracy=v
if not v then RuntimeAccuracy=math.clamp(tonumber(cfg.accuracy) or 50,1,100) end
end) 
MainSec:AddDropdown('Curve Type', { 
'straight', 
'backwards', 
'up', 
'down', 
'left', 
'right', 
'random' 
}, cfg.curveType or 'straight', function(v) 
cfg.curveType = v 
end) 
local VisualSec = Tab:AddSection('Visuals') 
VisualSec:AddToggle('Show Bind Window', cfg.showBindWindow, function(v) 
cfg.showBindWindow = v 
BindFrame.Visible = v 
end) 
VisualSec:AddToggle('Show Spam UI', cfg.showSpamUI, function(v) 
cfg.showSpamUI = v
MainFrame.Visible = v
end) 
VisualSec:AddToggle('Show TriggerBot UI', cfg.showTriggerUI, function(v) 
cfg.showTriggerUI = v
TBFrame.Visible = v
end) 
VisualSec:AddToggle('Show Ball Stats', cfg.showStats, function(v) 
cfg.showStats = v 
statsFrame.Visible = v 
end) 
local SetSec = Tab:AddSection('Settings')
local AccuracySlider = SetSec:AddSlider('Accuracy', 1, 100, cfg.accuracy, function(v)
cfg.accuracy = v
if not cfg.randomPingAccuracy then RuntimeAccuracy=v end
end)
local CPSSlider = SetSec:AddSlider('CPS', 60, 500, cfg.cps, function(v) 
cfg.cps = v 
end) 
SetSec:AddToggle('Anim Fix', cfg.animfix, function(v) 
cfg.animfix = v 
end) 
local SpamSec = Tab:AddSection('Auto Spam')
SpamSec:AddToggle('Auto Spam', cfg.autoSpam, function(v) cfg.autoSpam=v end)
SpamSec:AddToggle('Target Change Stop', cfg.targetChangeStop, function(v) cfg.targetChangeStop=v ResetAutoSpamTargetGuard() end)
local SpamThresholdSlider = SpamSec:AddSlider('Parry Threshold', 0, 10, cfg.spamThreshold, function(v) cfg.spamThreshold=math.round(v*10)/10 end, 1)
local DistanceMultiplierSlider = SpamSec:AddSlider('Distance Multiplier', 0.3, 3, cfg.distanceMultiplier, function(v) cfg.distanceMultiplier=math.round(v*10)/10 end, 1)
local AISec = Tab:AddSection('AI')
AISec:AddToggle('AI Patterns', cfg.aiPatterns, function(v) cfg.aiPatterns=v if not v then table.clear(AI.motion) end end)
AISec:AddToggle('AI Detection', cfg.aiDetection, function(v) cfg.aiDetection=v end)
AISec:AddToggle('All Ability Detections', cfg.abilityDetections, function(v) cfg.abilityDetections=v end)
local SocialSec = Tab:AddSection('Social', 'right') 
SocialSec:AddLabel('TG: 417script') 
SocialSec:AddLabel('DC: https://discord.gg/ycZdSqN2Hq') 
SocialSec:AddLabel('TT: swatlln') 
SocialSec:AddButton('Copy Discord', function() 
setclipboard("https://discord.gg/ycZdSqN2Hq") 
end) 
end

statsFrame.Visible = cfg.showStats
BindFrame.Visible = cfg.showBindWindow
MainFrame.Visible = cfg.showSpamUI
TBFrame.Visible = cfg.showTriggerUI 
TBFrame.Visible = true
